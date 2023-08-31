Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA357C83F37
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 20:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FD410E6DC;
	Thu, 31 Aug 2023 20:59:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE1310E6DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 20:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT08KilO4O65XHpy4Wg9mP1wMpESyjkOP33A0CXhlNQhYmDAySMLLCs38uFr6QvkBgBTASfgkjMnHGChOMFLm4W1zfgj899EyVRY5VU0G8z586YKU/UnCkBbNAjjQvx/CLvk6GBPOfBBqjFCgFqBeW8S52KQGvuqN/hP7gXVBWRTcS48w0AgoNOQKYYhDVRQcwt0nmHxybIu0SrPlAtYD5Gp3KBLPqzgt0W+74QhbCZguX17RXiYp1nOixzUj0FUMjC5AbmbY5bOC5POTaSkgNlqHwLZp3BCJaA5F4PAXYAB/QQrQsW+rEf0M2qWHL/frkvGdO6AY2/T7absOttt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm+ATGaibugfoTNdIwHLG2CXDbeBXgfSill9rrgH2HE=;
 b=WkLrD39Q4bOkBQyGPPtcmk4tDCbnapohISk0bc7Fplzguxgna4ACZ/esLz+uJsLH2dvfzNRuPilqliV/iS6UTJeHrcHcuAHxDBuC9IJMOPQGANDNSLzq0MTe4F1CTvT/FuxS/6o6I1GA3EjjeJ62Qz/UgEQ5s+RrGg/aV5mr3kZ44uNv2VjWubtR2SDbBZRgfZPQ48ilUspkkzGKL0s2WwOpbTUtF3d525SwrpqKmyElxuVC5IiPysZ2iEsUCvEEnb7CHjiyY+joppfnlKmR09molUgUMzjnmw2QfK/KiF9r62flATleG4A6fxkfM0JhlIYCCgxIDSXB23uhbE5zBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm+ATGaibugfoTNdIwHLG2CXDbeBXgfSill9rrgH2HE=;
 b=nVcYZQ5SQGk6dd+ODpqNDk7EDs8DKVvgh3I1mpLkUmU0CWnUL/3UnOReyKj6YP9uhc+m9KsD9vhAulT77I9xX6hZ+Flpb0x3v93rmaP9V7Xmn02GnV6cUQO9A/DwVBzNDi8ubaDEaDJQ2dQyVvmZPwDlWzM3W5E3Poc85lG8EKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 20:59:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 20:59:39 +0000
Message-ID: <0da257e5-85a6-4843-4f49-5666d049110e@amd.com>
Date: Thu, 31 Aug 2023 16:59:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230824220834.362948-1-xiaogang.chen@amd.com>
 <d31985b2-74d9-2536-2995-7b693928d443@amd.com>
 <f744c06c-284f-de8b-8ed2-05d0512823a1@amd.com>
 <ed0dd323-bd99-d2f7-8cbf-6a92e5201f8e@amd.com>
 <8670e751-9a76-b9d9-47f6-05461c279f09@amd.com>
 <fef7aadd-fb8f-f5c2-10e6-b5ebdcf4be56@amd.com>
 <347c4bba-cd60-29a5-6fc0-8f445fd31300@amd.com>
 <85f4c2da-2d8d-4c73-a540-f714ebe6b2e6@amd.com>
 <f57a1e42-52af-0d67-0049-9ed6c58fe0ee@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f57a1e42-52af-0d67-0049-9ed6c58fe0ee@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: ee341799-dd51-4c69-fcbd-08dbaa653138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lktCd8CFFAv2Dw7Onu50V+4O1bTfx5Bf+zEvcrHRrV6RQRLy3gTCQolL6YjLzGEV+Sx5yF+bLN5QmugStQQnNtQGttGvVsQbsagoKfvcV6piHbtG4tcpvZEp4FFIu0VlO1+vSWsB5pO9ZGRM/LJ7pXqj6dQdgSWIHeWN7w4xehCKoAptNsh3HXg9JOeax6bvBj5/PDAlIlvo/uO6QywQADWXNc85EG4B5ldAHNB4Uq9PuF/uuA6LYjBOOvrPs9YB1h2D9RgtDBzxkWMnrayx+qhnA+UOsivhfUpIcC8vWnidrs8qeDkh9e+SbLbHN3mqifxv0xJ0u53u2s0ooREZwEobmwUIMHb7WB9OrhS2k00lFAy91Jee2fzLfm0wxfgBYUI6XdCsj52iSF3c1DtWmVERrTe96EePvxfVIpubmzF7pJ8BmI4jGfGNYN7y3gcdVMxJ4b+8xV6k5P+LmNS63e3kDiIReImeiQR3l0xdCo+0YzUj4VEYKI2OySgSOCqMQX/OseHLp/X+zztBtMMv3glMcv9uGcuZRgYzd9+Izb5J3kAZCKbpwgWkWZ4a3jCp+fYXSDNshTlX+mtZHTcNJ77Zjn/9Y+cvOeETfLeJH1TK6bH9w6ndvpaa8QwdGqsoSv7/k676CZU93ZyxieIlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(186009)(1800799009)(451199024)(8936002)(478600001)(53546011)(31686004)(66946007)(66556008)(6506007)(6486002)(66476007)(36916002)(316002)(38100700002)(41300700001)(6512007)(44832011)(26005)(83380400001)(5660300002)(36756003)(2616005)(2906002)(31696002)(86362001)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhhUkgyYXlKdTM5cUdoMURXVndBR1VlYlc2ZGcvS3RCMUhOM2ErUEtIQUQy?=
 =?utf-8?B?WGgzZ1pMb0lBQ3FKOGtIeXcvVTdld1ZaVG85N25jUEtLc0FTWnZxalkrTlBU?=
 =?utf-8?B?bDEvWWtQUWsxbEIvbHhLL1JaRCtxbGJzaVRBanN0OURKUnJFZCtlMHRKWEdS?=
 =?utf-8?B?bFVYTzNrN0ZsaGM3UWkvMDV6djVxTkVnQ3FPVG00SFd1cGNmR3cxakRNbi84?=
 =?utf-8?B?c010bFZPTkZ4VHBaL09LTG9udDF4eDZhNUh2U3ZmdVEwTjl6QlVnZVdmNDc2?=
 =?utf-8?B?Mmw5bmxPbHROOERiSGgvL3F4RG9QS3B2V1M1cTVHUFZ0a1RWVjBuR1l6NzBX?=
 =?utf-8?B?cmNucitrcmN2TkVDSjN3ZVNUaTErTlUrNlBFQzlycXlNbk4xSjFMeFJ5ZGY0?=
 =?utf-8?B?Wk9KTzFzMVJLRDVmV0hXbDlmYXZUeFlsWndHMW5OYWV3cWtTbWxqZ3JHMklG?=
 =?utf-8?B?QThiaWc2Rm4vNzlrUGl3U0FtUElJcjhBVVJxRFlUUTNxM0N6TTFtcU9ML25h?=
 =?utf-8?B?NlNGMi9FbmN4eW44UHVYQkg4Z1FRcHE3aHo4eWgzbllxMDZJTVJrajZ6b3RS?=
 =?utf-8?B?S2hYSGJTT3ZDMUgvWnYvdFNxdW5TMk5FRGtkamJWQnF4TFBJRWl1RzFaMUQz?=
 =?utf-8?B?Nlo4YjZSRlk0V3luejhDWVA3TGlNRldrUDdCVnFaUVY4L0NyNnBudmFsclNr?=
 =?utf-8?B?NHdXT2pkbHdiVmNYZWN0OUJHR3FJSkRKWGJ5enJsSW15UWR5dURGUjI2M0NN?=
 =?utf-8?B?UzVURXVRWGxYdUxGYWhtV2ZNMWRYRkdWMkhoejEyV0pkS2xzaHRTQUhuZm1U?=
 =?utf-8?B?d3p5NGxQajFiUGZPRFpZbDFTeDZKSFZxd01ta2hLN3FPUzI1RWdrT3VsMWtp?=
 =?utf-8?B?d0hOVHlzWVIzTWQyNlV5RjZpVUF3T1RwNFYrbGJuTGlvV3l1eGIvUkZCTVhY?=
 =?utf-8?B?NDBpdkRRS01aM2FTWlpRSHhkS0luWnRWMTArZ2FkcUR1WitEd05CV0VxYTVn?=
 =?utf-8?B?bHJxRm50ZlVJSmhpaGpLQlBBdExDYVZydW4yendKcFRpejdUZmVtR3J0ZlNU?=
 =?utf-8?B?c3NnQmM2RkZOQ210blhFQi9pRTR4c0FScXpUcWNlMmVYNkc3bkdaekVwVW5x?=
 =?utf-8?B?QmVPcmxlL3ZUUTRWR3pheTFRQ0dZMm0vZG9XU1YwYyt2US9kNXJ1aUNNOW91?=
 =?utf-8?B?ZHJRY0pWVENsbC9NdkZMRlRHa3VFREJRMDVzYlkvSDBZOHdrdHBaaFVPN2h2?=
 =?utf-8?B?R0xpN05BMm8rNWFCWkhTenFrT2phSjBCUGVualJXMEVucDlCQjhSRU82YnpJ?=
 =?utf-8?B?SXZaUHNQa2dubkt1NFlGd3I2QmczaitKMy95RGZwcVIybFZyNGhaaHlCTWhZ?=
 =?utf-8?B?d2xUS2NUbm53clQxYlFraUxMaGM3QXVxcTFEM24yMG10NE9kTnZ1Nk9ad1ZC?=
 =?utf-8?B?ZmlqSE90ZjdnRzdpSGlienRjK1hiMWRMUk5HVkJVWDY1NGhTWGYzL2dubFRN?=
 =?utf-8?B?RmpWRzREdW9FQWxITVk1SUh0Nzc5T3NZSDk5WHBrdUZWUG1peVlTQkJwV2ZL?=
 =?utf-8?B?amFXaTgrL1lNT1R4NGd2SjRMdGszZHpMY3Yrb0RsK2xNM3BPV2hLbi9FT3kz?=
 =?utf-8?B?Zk85a1JwTGljR2JoMHZiSjdZRjdNbnNYUVdPRS9vcVJVQVJYMjMxUU1JdENF?=
 =?utf-8?B?MUp5c1lXTjdCUzNxbWRIcExmZjF1NGtNWVppUldnM3JWTE83S2hmK0VsR0U2?=
 =?utf-8?B?MmJseVo3dmdoUG5DL1FIcFJuT0JiSGdhWFBMalA3QTFNU0FEb3VmK1RuV0Yx?=
 =?utf-8?B?RUlFYmwyWDB1MmxGVXorQ051MVVDL3NuUGNXZ0ZkRDUvalVFZXZRNUtnUGxL?=
 =?utf-8?B?b2RWc1kvTFJEbkxDd1pITlBpb1NmNnMwYnJUZWlNNnhtMkhDZXVpRzdNM0xW?=
 =?utf-8?B?dk01OUhhL3lxU2VZUFZIbVlBdHRUemcyM2tGeHNXd0ZNdmRhbWI1NkZ1emto?=
 =?utf-8?B?aWYvajdPeFNLWi9xc1FRclRwY1JEb2dxNGFmTXN6V2dRYWdMakhubDRpb2lN?=
 =?utf-8?B?OXRkNmt4d3lnQk9wVmoyS1BEUFhXSmlPUTdSU3NKc3pFZXFXNXNjQXRocWNt?=
 =?utf-8?Q?bROn16/aAvLVUG2TRq7HvAw2J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee341799-dd51-4c69-fcbd-08dbaa653138
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 20:59:39.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSmpuW9m7VfBPjuz/RMlssFsRBmyjF5zE0HdKTrFw6CgQUpG1he0Xlz6Zi9hb5ntRqWV1Zf08bfM7FxpBmIoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-31 16:33, Chen, Xiaogang wrote:
>>>>>> That said, I'm not actually sure why we're freeing the DMA 
>>>>>> address array after migration to RAM at all. I think we still 
>>>>>> need it even when we're using VRAM. We call svm_range_dma_map in 
>>>>>> svm_range_validate_and_map regardless of whether the range is in 
>>>>>> VRAM or system memory. So it will just allocate a new array the 
>>>>>> next time the range is validated anyway. VRAM pages use a special 
>>>>>> address encoding to indicate VRAM pages to the GPUVM code.
>>>>>
>>>>> I think we do not need free DMA address array as you said, it is 
>>>>> another thing though.
>>>>>
>>>>> We need unmap dma address(dma_unmap_page) after migrate from ram 
>>>>> to vram because we always do dma_map_page at 
>>>>> svm_range_validate_and_map. If not we would have multiple dma maps 
>>>>> for same sys ram page.
>>>>
>>>> svm_range_dma_map_dev calls dma_unmap_page before overwriting an 
>>>> existing valid entry in the dma_addr array. Anyway, dma unmapping 
>>>> the old pages in bulk may still be cleaner. And it avoids delays in 
>>>> cleaning up DMA mappings after migrations.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>> then we may not need do dma_unmap after migrate from ram to vram 
>>> since svm_range_dma_map_dev always do dma_unmap_page if the address 
>>> is valid dma address for sys ram, and after migrate from ram to vram 
>>> we always do gpu mapping?
>>
>> I think with XNACK enabled, the DMA mapping may be delayed until a 
>> page fault. For example on a multi-GPU system, GPU1 page faults and 
>> migrates data from system memory to its VRAM. Immediately afterwards, 
>> the page fault handler should use svm_validate_and_map to update GPU1 
>> page tables. But GPU2 page tables are not updated immediately. So the 
>> now stale DMA mappings for GPU2 would continue to exist until the 
>> next page fault on GPU2.
>>
>> Regards,
>>   Felix
>>
> If I understand correctly: when user call svm_range_set_attr, if 
> p->xnack_enabled is true, we can skip call svm_range_validate_and_map. 
> We postpone the buffer validating and gpu mapping until page fault or 
> the time the buffer really got used by a GPU, and only dma map and gpu 
> map for this GPU.

The current implementation of svm_range_set_attr skips the validation 
after migration if XNACK is off, because it is handled by 
svm_range_restore_work that gets scheduled by the MMU notifier triggered 
by the migration.

With XNACK on, svm_range_set_attr currently validates and maps after 
migration assuming that the data will be used by the GPU(s) soon. That 
is something we could change and let page faults take care of the 
mappings as needed.

Regards,
   Felix


>
> Regards
>
> Xiaogang 
