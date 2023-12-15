Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CD4C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 15:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9A610E0F7;
	Fri, 15 Dec 2023 15:19:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F9D10E0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 15:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3jRDQt+sfkdB9Sn6nIsvJ551VBrrH1b2raVi5W7if0ryThlCHZ27YtreWgB3ExcuwepEBA9bRfiyzWsqzQCzRgKTPSfZX1LyTKNUGy6DEZ/xCbVLvamLLPmSdTYuRGBqfp7mIAULa09puvXeN8yxDjPGO2bfHu3eUDPZWc0ULzZA+Vl2SDgBx0f17egcG7qFF60fyTOUE1VDmuSI2y+TGI5bU4cOx68Vj1CH3a8zN8YIlfdMcUagcg9BMW7fXyvm+3qZNk6Jm34670mEBIas/oW8VstLZTevDAMhVkW+YPRv8CnAimAGMVspsoHvYrY57+jfY5dj2ev+khTUbSYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcLWyCTR/qdmMzvUz0jnEmachBLUoBa3015vL5FfcmQ=;
 b=U85l8rFfJ0P9Nrj/CsalbWJGNJsGZ4QT/dVYKTscehpBvm7rC5AZhcXEpajHU0GPpFnFZN5oFgCHpvNYcSqTpyBIP7zgrEGQUFCGJqqfazH+4C24gClzb7kBjnt+9RYqX17JYw8tbC46QfLwQ2+yHEFQgWw1rloldf+hyhkXR3nhRHX4oHk+4MZXreFRX6LECq86vJKG4Swcrq9FzUxZmEAMNqboK6I9CUw8rR4KJUn5v70V6LpECRbiaacA2pTF5mT9Y5QId3NANMa98bGCHrKtpLszbal1Bih2i3aEavkvAjxF0yPU28oiEAnZd+HnEz4uzshdpF0D4IoQokUVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcLWyCTR/qdmMzvUz0jnEmachBLUoBa3015vL5FfcmQ=;
 b=Z3yYxoXJ0FgeUL27+wJdryMOyGQ0G3Y6I9WiSUT8TyxozI+T0FTHIkwFTamjJ+IhAqcNjN2PP3G6BI9XNFXZJOMipUHXBGmUglbqWSReUaHylNXCYxQD7YLG6u5pINJWCTzidEWqsJDbX77PP6IcCG1KlodSmFhADaZA12lhL5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 15:19:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 15:19:11 +0000
Message-ID: <3bce0db8-9da0-4f6e-a941-e5531518c908@amd.com>
Date: Fri, 15 Dec 2023 10:19:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214223001.218746-1-Felix.Kuehling@amd.com>
 <fe14d738-ab23-460f-ac44-2090ef9ab4c5@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <fe14d738-ab23-460f-ac44-2090ef9ab4c5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d5ed6e-379b-46a1-a744-08dbfd813099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quvlDpw/g4kFrY6t8U1hoWsRi0lScaqilkFM44+MISFDPVh+1JzqUDc8CW7bKwp/eSNx+Vp/4T/eSGDqKfLTvnHD1CqZcWZuiTZeRovoXLITfooMMaGdMtnDS8rWy0BufjTiDJ51EEDAb98zg+dQlfMIuoI7e3D+wqKL4Gtb1IVmsP0ad8NrehsidW4jchHOnx8m9RFJLi/2TC5p95Q1eWr6Ud1PZ7cbAUG+jQEHWKtakq/73ijotqQJcRgcF4kRZm7ghtBt9u862s3eMubiiMPtWxf0g80AwY950RUKGrNHRJlp+d2RWcQ3hW/+cTUNl4YxJ3Nv7iOKp3Rwc9ojvlqNs9pXJn4sOHbUhZ7bg6GHG4/V9FfO2oD5NWEmJBFHNOQvhg1DX7jU5owJVwvXH3AbU5F0Mua2pG4L3+VIcRiVGf/NQswK3QW48ALh9tWfCfYQnusUxRzBxfL0cMm4Y/hsghx74LF7wcinsuir/rlJ3BspGQ+f8arXVp2WC29MZb0SfHZMHeLyWJ08m5B/xsIFEdjiA6oxD0PqGl0Isi9b0xzQqkqK0onPVmAeOft7FAMtqrp5gShoTWMeQfO1pSDY9sWfXy0BDt/SIPl6LCA4iErAst0BHQjLIHX3beXRQJ4M+YadAeCMhta2Ykb4Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(66574015)(6506007)(2616005)(36916002)(86362001)(31696002)(36756003)(38100700002)(83380400001)(5660300002)(4326008)(44832011)(15650500001)(6512007)(53546011)(316002)(66946007)(8676002)(6486002)(8936002)(66556008)(66476007)(2906002)(4001150100001)(41300700001)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxXQnIyaU1GT0FjNGZjTGZTYlVLcTNtempGOEY3SzZFMHBJNU9sR29DV2Nj?=
 =?utf-8?B?aHA5bzV6SGRJbW55VXVWSnMvWGFaT21paDFQT0lkeldRdDhLMk1RcGtRcGxl?=
 =?utf-8?B?WStWOFB6R1VaaDgxell2ZEsxSUxMaUpiMUEydzR2V2N2eStzRUN4L3VrbTVr?=
 =?utf-8?B?K0V5R2FTRkVVdWlQVWVIUStjWnRPcUdhM1piOXBHTTNWTkFZZU1aS1VqbnpU?=
 =?utf-8?B?dkM5aVNFb1JKdmk1bFE2bmlOQVBnc05lZ2QrTVhCUE8weTJwdHdPWjFIbjVa?=
 =?utf-8?B?SWJZMFl2MzNJQkoybnd1N0ZBMHRUOEdhMUZnbys5RTJJbng1VFJWTjZOT3hj?=
 =?utf-8?B?UUs1TmE0SXd6Q0ttdmg1U21Md0hKeXZYZVBSdm9ya3JKQ2VBZFRzSjlIUDdt?=
 =?utf-8?B?bEtqdE41WER5aDBYMXY1ZmJZTlZvME5QRkt1UVdHQTN0TSt0TTROS0ZVQkFs?=
 =?utf-8?B?UnhkQlRIeWZvK3ZaQUZVcXVVWk1tRncwRjJSc2JOWWZVYkZ3anZmanJkaUxP?=
 =?utf-8?B?ZEdKd3d1SWJ4SzUxVlBWdWs1SWNZZ3hnck02VFF6dncxM3ZJWHVoNFRKdy94?=
 =?utf-8?B?NkQrcFdtU01XU1ZYdG5Rd2VsZURtS1BFeEJUSVpqdmpnSXdoRktyOE8zWUpM?=
 =?utf-8?B?WEo3bno1S2xoTnBtM0VqanRTekh2dzJROGtXeU5YYjJUNlA4cktISklmeE9T?=
 =?utf-8?B?bHBhUXRQTVp0anlDbXcySUJ2ZFcxUnRvcDREQVdaQnFxbVhXY0FIQ2ZDQmlz?=
 =?utf-8?B?ai91WHFPWnMyNS9RbWQxbCtEMDNQS2xpSEZqU0F4THBLWlA0aGNJV3loUTYr?=
 =?utf-8?B?cjBtWkphZEJyTDg2Y25oeGxXUE8rVnhNb0NVOGpjR2Z4S0dOOGZ6V0ZYZ054?=
 =?utf-8?B?a2FIU2MvcVBEa0dQV0wvNEN2T2dhWmhSWGwreFlrcFlQZlJ3bzB4RTNzMW5k?=
 =?utf-8?B?akUvKzV3SnF1NWNHNUZ6V1NodWRlU0Ezc0V6QTF0clVnZjBPRVc4cGJGZHBW?=
 =?utf-8?B?KzVDM1N3b0tsaDVNMmZnUzJuaStRYTVPNjBTTXRiT3diQSt1ZU41T2NUcDd3?=
 =?utf-8?B?aENSSXBXaXlTZ0JrVW53eVNKeGl3WVJGcFhURXJ1YWhITlJmTFlDUTlaWlND?=
 =?utf-8?B?NUN5RVovNkdXckNoT21MbitpRi80ekJYMXJRZHVMRGZQc1RPNHRPK2lDeGp3?=
 =?utf-8?B?THR4TkNSTDVYQWFHdG0yNFZkNFc0aVRkZmU5UllyNU1DSXBUS3NVOUdCZ1VO?=
 =?utf-8?B?dC9ZdFgrY1BoeFFQS0c3N2hERytXb3dhNjFoOU5wWUdScndOWXpjV1ZLblc2?=
 =?utf-8?B?SDAxaVQxTi9md2hVWVBKRGtZdU1hMndXWFpPRmEwZkFuUnlJeVpvMjBSbTNa?=
 =?utf-8?B?bDZPTjRHaWE1L0pDeEpPcmQ1YUVXZXBDR3hOWnRaZ2ZDTUJzcE5uMmpsL3JV?=
 =?utf-8?B?TTdWa1Ywby9MaVdCZ2YvNm90dTFVcFEzcXAvM0ZJazZsdXZ4VkF2bFlJby9G?=
 =?utf-8?B?b0dsOHo3SUZUeTVqakVETXZFMnQvQVJmeXpoTVNvOGVuWGd0Ulo2TktzQzIr?=
 =?utf-8?B?VjN0RUorenZNQy8zUERhdDMyR0prN0hsN28yRkhqNzJZZ1hWVWhiNDhGeTU2?=
 =?utf-8?B?N0RnWk91Ymc0ODBORk9jeU5BSU83aTZROHdzdmtwdjdGRm0vaDdHZVo3MDBn?=
 =?utf-8?B?R3NmdkI2UHRQQ0tKVHdveXFCTzN5TEhEa1FKTWFkcmloVXRmanREcUk4bWlU?=
 =?utf-8?B?dG9md3VtK0NBK1dGUVRLanZEUEl0OXg3a0l0Mys0NndkdDNnd296V3YwWFVi?=
 =?utf-8?B?WEVJekZTU0x1TWF5WHliK0tjOWFyN2doYWw5bzNLNWpEcCtwOExIMTc5cXVF?=
 =?utf-8?B?VEVWR1Vic3NoZzg1WW5qd1F2bHFMNVFCOVdIMXJwbTJuWHQ2RWloQ0xydTZj?=
 =?utf-8?B?SjNKb2xudDIzdzhzR2VQUjZqSVhmejRxNmJoQ3l2QXpyRWxhRXV4c2xoRVF2?=
 =?utf-8?B?Ymt6YmlsYm5VWGNLSTVtUkQ2bGRpUE9jNzVzQktCTlhoY0lVdXRjelZWN0Zo?=
 =?utf-8?B?eWlqakczaHIvcEE0bitYT1BOMm5WaFhlWDE5akg0eml3d1NrcERPVndmUTUv?=
 =?utf-8?Q?hfw3PdzHVjsaoo5KoD+Xc4O4L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d5ed6e-379b-46a1-a744-08dbfd813099
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:19:11.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syQ+ZRux7MXdLSnWbjfBsBSXA973oZ41ObIKHkAea9OiW4KjCU1NGjx+tCoX1XtvQvYwtqeBCSIku7jj73jllQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-15 07:30, Christian König wrote:
>> @@ -1425,11 +1451,21 @@ int amdgpu_vm_handle_moved(struct 
>> amdgpu_device *adev,
>>           }
>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>> -        if (r)
>> -            return r;
>>             if (unlock)
>>               dma_resv_unlock(resv);
>> +        if (r)
>> +            return r;
>> +
>> +        /* Remember evicted DMABuf imports in compute VMs for later
>> +         * validation
>> +         */
>> +        if (vm->is_compute_context && bo_va->base.bo &&
>> +            bo_va->base.bo->tbo.base.import_attach &&
>> +            (!bo_va->base.bo->tbo.resource ||
>> +             bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>> +            amdgpu_vm_bo_evicted(&bo_va->base);
>> +
>
> The change looks mostly good now. Just one thing which worries me is 
> that when GFX and compute is mixed in the same VM this here might 
> cause problems when we run into an error during command submission.
>
> E.g. GFX validates the VM BOs, but then the IOCTL fails before calling 
> amdgpu_vm_handle_moved().
>
> In this case the DMA-buf wouldn't be validated any more.

This code path shouldn't be relevant for command submission, but for the 
amdgpu_vm_handle_moved call in amdgpu_dma_buf_move_notify. That's where 
the BO is first found to be evicted and its PTEs invalidated. That's 
where we need to remember it so it can be validated in the next call to 
amdgpu_vm_validate.

Currently the amdgpu_cs code path calls amdgpu_vm_validate with 
ticket=NULL, so it won't validate these imports. The only place that 
auto-validates evicted imports is amdgpu_amdkfd_restore_process_bos. So 
none of this should affect amdgpu_cs command submission.

The flow for amdgpu_amdkfd_restore_process_bos is:

  * amdgpu_vm_validate validates the evicted dmabuf imports (moves the
    bo_vas from "evicted" to "invalidated")
  * amdgpu_vm_handle_moved iterates over invalidated bo_vas and updates
    the PTEs with valid entries (moves the bo_vas to "done")


Regards,
   Felix


>
> Regards,
> Christian. 
