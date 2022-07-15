Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8DEC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D167113666;
	Sat, 16 Jul 2022 14:38:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F6D88E45
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 13:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTFxRextrS1y58ZqSYwYtGLsllEeZaXkdWYXCywOe60hQz4eRq6T9TicLMaVTBouiwuJy24c84EFGUVOrcQJvzNSucoMhLl4z4TP/keGykWcNb0L2aLAsL/8KYgchl5+eT8LHY/6L3xMBP7L7DQvhzn+21QDL+ew624mlV8Vlecfg7NZLfOf+IJdFlGgBGHb8s+xrF3oqHEJf2r7SO8p3zMhVA8UlQ9Jc1FhW8IkoYJavPX/eiGXoHLxrDQRrA+n2rbd2lK+w4cLlGRu05kjbn6v02cRpctIrBWR+2trJ8F1lIcqdWP/UNFS6WSYS5KV8myg9ns4MQ4QnDB5nCA6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teEKNgr0xsAlX4U/F4tNetnl161afDM5WDCBJlZAGjc=;
 b=L5KzO+g2PKMYDijvbPLKedfiXcmoTgKuPa+RE8I7lD9g+A00ORw49IFiddqfTrufUWfIKT7QV0rQ2EiegIMWVXL90TeBSbHDMr35ZRjNokEu6FsBFQOqHEZKoG97nnaGosIFy5MGZG7+cNfcM6Cwz12+ucMTHiw9AwctsqkmgRzV9Puqtl0VYoUjk13MCsUNUs91Z4XtG0K15Vf+jIy10zC694x9YhB4Lyj6Gu3VlShz6ctUgN/RyBGIltnikWU/B2EbqCl/61jJDi5gyM6GalqBK31JY8cYYofpEb2TQcwwv8T8arrDfNcFFJiu3dl7UtZE8HAMzdtRELyYlplOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teEKNgr0xsAlX4U/F4tNetnl161afDM5WDCBJlZAGjc=;
 b=c84L/X6w9JzvAH0XHKoj/Ot1chCKyjf7juDwhVHyaCAiXbqIPSqVKFhl5Jpoy9O6EdKHR/66RB490ko1p4mIP9ZLiZJRloy2mlERFYRfhQk3ljcP0TzQGODd3Tm+JLu/ZRo6wZu1Nx27rsV8/xfvH6eo6EaRtrtw20EM9jq8hoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR1201MB0015.namprd12.prod.outlook.com (2603:10b6:300:df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 13:39:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Fri, 15 Jul 2022
 13:39:03 +0000
Message-ID: <16dec7c1-ce3d-f53e-1209-be353139d6f6@amd.com>
Date: Fri, 15 Jul 2022 15:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: align between libdrm and drm api
Content-Language: en-US
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220714212233.14571-1-ruijing.dong@amd.com>
 <e1c41136-18a6-7747-ce18-b6fb6e1797c2@gmail.com>
 <SJ1PR12MB6194978742183900BB898D0A958B9@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ1PR12MB6194978742183900BB898D0A958B9@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38619bdb-1f10-46a7-6920-08da666761a1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bfqxrf3mzQ9V3LnMkf6eeurtcdMtNVYuIER6/wD3hoHR1sWr2Dm2brb5XTBtnAxL4Mo+CkScmluuJ2+KKSYq4+hz6qKzl9xmNduzb231h99D4KyIs/CXAzqoE1WUACqeV5rr6pS3UHgaSgebnF2mI62bNdCT4tIoe0CCLGzn4yRuS/uFlmBEMKd0G8k6uXmyQn/vf/Zr60vBDI7GhnGugPo2AweiDipa+J4piynzmH0CimwpRlVXXCTxd4vNQEX95nmLqnOkrYFh1p/zFLKT4UDDg7Ri7X18BYTx0CpwLOt0yG0qjiROrBsuYegsmh0olRHFY132iBjZR7Ub2OYqhuPtgV28eviYYnzrK6xCmz3vKBv8hHvCK8HwdcJkUJvlsV9ac3btFlV0oqQUok2olqtejTiFT/Zo/I6O3tvFyEaZZu9EdtRFOrt5Xzblws2LlsmEyhnwObM25wnINgq1XJEddP/tx/N9UGp0YvvHarJDhsj6ihYIV7sr4inBfR1zGNYXjhz7dND4Kxlff5TyMPQx70pgb9zkReqdBzAreu8cYCR1E/irIWkRuDKYO4cJtIgcTcPV3hmcKDkCJRp7eDBKiatP/4C/H3oRznh2ciF3KmcZwMSiBUUxu3hNaXyIQ5vftPq3ORfab/dHHI0g47z/FBllXLnPYorXoPphzdH+6QAqazPAcHpi1TeIS0SZOZNkJj3e4QUVIn9gbktZpUZB6ue16jClkZHRz4PxImGoZS5X28vUOsV1/Et/nEZ54f1fbEEHXAt4MZAjdjLjzlclsE8TkYpxwNaOkNgLPCPJxLjg2Z3IlMOzjr3CQMR0LGAXz1822teAjjVLixUpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(5660300002)(83380400001)(186003)(2616005)(31686004)(36756003)(66476007)(66946007)(4326008)(66556008)(8676002)(8936002)(2906002)(316002)(6512007)(6506007)(6666004)(53546011)(41300700001)(38100700002)(478600001)(54906003)(110136005)(6486002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXAvc1dZNXBMaW84NG1MVVVxdmg1ZTRnaEZxejJJTzRWVFdmdkhtV1VPLzFU?=
 =?utf-8?B?RHhybWRjODYzbFRqNHZyd2plb1RZWXAyemhBR0p1SWh1Rmc1UkVrbUJEbVlY?=
 =?utf-8?B?UjRvWlVEYUFCWkxGYVlmTk9GcDRrbTZXNFBLQlcvazBFZkFaMG16WDJxMDRs?=
 =?utf-8?B?bTY0amtMS2prRnMvV3NYNTcrRFhlK1NqekZtRjhCVGJiQkduQTNzQjhYcEpT?=
 =?utf-8?B?WFRLWHluL0hYaXowL1ZPTTBLcUMvdHJHWmFuRzJPQzNnYW9YdlViUmZ4d3BE?=
 =?utf-8?B?QkVNYWN1Yjh3bmNsZHg1dWlDUDFyaEpMMXhUUVRmdXliT1lEelZQZFdPamRR?=
 =?utf-8?B?bzVVbHJTcE4yREpMQWJZNEo5NDM5QzNGQlVVdkVFbzdpZUVSdGlDeFE5aE4y?=
 =?utf-8?B?UnJ2clNnYUlPaTczeG43eDlXRHp4dExqVGxKckdwRDkrNWJBeDRQRHdJNkc5?=
 =?utf-8?B?aXhXMHh5TzFsV0crOFdkT2YvRERCbE44MnNManBlVkV5UWQ5djNScVk4TlFG?=
 =?utf-8?B?VnlzU05XUEREZWxCWHRSWHFackhtWDJpeWtZL0FrdldvVkE1bUZ0VzhYenVX?=
 =?utf-8?B?aHdMWGx5a2VsakRDWWVOaDhyUlF6d2R6c1NQTnhETFlXZm5RWUw1b2cxNjdK?=
 =?utf-8?B?SEJUcXR6bzZHL1dYRjBPOGYyZWhvNzRvMVNEc1RvUngrWGFxZXhPWmRYSy9Y?=
 =?utf-8?B?NERqUnl3Z3lGZzdvL3A5c1Z5WEppajA4Vi9NbFpOZUQrazJId1lqd042d3Bx?=
 =?utf-8?B?bkZOc1NPZGo4ZkpVV0xnRGFlS2FMOCtwZ01YdjlndlFUUXNmWWRCNWxvZHhx?=
 =?utf-8?B?bzcxclJjbENkR0swd3FQeTQ2Z1hMZ1lMaHl4MU1JV3NxSDh4QU9EblA3N0Nr?=
 =?utf-8?B?WFpqSnNvUUVTUENKRXNDY3dKNFNwWStpcFFSZS9sZWgzNXhxeDBZamdmQU1x?=
 =?utf-8?B?THkrUDJUVmNMM2xadU9xaFRwTlBOY1o0V2N6OHRsVnQzSFpMNjlWUDB1U1dG?=
 =?utf-8?B?M2s0NDlQeEF5V3JUeXhOUy9wdVI2L2RsMDdxbnU5SmYwMldOTkduTlQvdFpx?=
 =?utf-8?B?SEZtbkNlL3YvNW4xSGZva2Fpc05TbEZCUTZOVHNqNG9TL0ZFbW5uaEFVRXVl?=
 =?utf-8?B?a3BpUUoxMXVPTWdLQUJ4UGdOTDRHWmYrSGV0NkpuNThWeERYTzJ6L2l2WWZm?=
 =?utf-8?B?VUx2aFRYWVZGVkVaaGNkWHhKU3JUWW1NeUVpajNGWDZtVEQyNWFYWm03Tlp3?=
 =?utf-8?B?dkhpZTlOY3ZPNy9iQ0kvQ0VNTUE3YngvaXE5dVRHRkpSR1dVazQ0Y2tJb09t?=
 =?utf-8?B?ejFGN3c0Y2xmeXBWQnFNcERUbFMyRU1UM3htNDFES3RHNmo4U1lIRU91b0VR?=
 =?utf-8?B?OWFxRXVHaGpvdTIzN0E3T01hTVRhUDIrMWl6SFNGQ0grczhOMm8xZHRrMlVK?=
 =?utf-8?B?N3ZvdTErazNJdytZV3djMUpySE9USm1ncStBZXhwZTJVbmUrS1QvT25hWEhi?=
 =?utf-8?B?dlNGcURqa1Y1YXRVUXFlSDJNUFpVSEpnMmUrVEFzaXQvbGpkN0ZRUVFERW5E?=
 =?utf-8?B?Y3lTQ0VUQ2VUZHF0MFZUR25rREhZdE05UnhkaklZTUNmWVQyVCtISzVkc2dU?=
 =?utf-8?B?YTlLOUtYdHJTbVluajRZa3I0QUFtbFB3VVRKU2IrTlhqK21IWFVwY0k0bFlE?=
 =?utf-8?B?bGZjZWg1Rm5XS1N1Q2NYM1lwdmlocU13QStXM1FVdFJlR2ZHZUhZTlcyWno0?=
 =?utf-8?B?N29qWWVFLy8zTmgxQ3l6TVB3RzdMbnhEU2ZYKzRGb1pEUjVaRnpCaGNxUUZ0?=
 =?utf-8?B?ekVNbW4rckZYaDlWbFN0aXVTQkUzaUlmK05sYU5ZQStWVEpJL0tuYVV3dWY4?=
 =?utf-8?B?MEtVQWdKblpQOU11ZE01czB6ZGc4aGVGZW1HaEhlczZLc1VWVUQyL1hrSjJV?=
 =?utf-8?B?V29IclJvY3k2RXBOMktPZ2ZvNFNjcjhERnk3MnRqdGtFdk5rMTI3S3htdVFn?=
 =?utf-8?B?VGN3UEZmbWl2NDczSEFjbkRvL056UTJjQURBVUxLNUFrTEFjcGpvbGY5VnAz?=
 =?utf-8?B?ckRqZkJqS0JFMk41K3FFZ25DNTlFUDZBZWpoNGhUQVhRU3FXZG1DUTJVUjVW?=
 =?utf-8?B?bGI5Tk9hOCtBMGlpYjBrbVVyZzlhSjVJWm13RTBGcUtnMStoemRDNnVBL3Rp?=
 =?utf-8?Q?wF8yHUJttNT+rsu0ghm4280Hs2V/mIVn/DSKeltj5yDa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38619bdb-1f10-46a7-6920-08da666761a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 13:39:03.3385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci4ES90Wg4XS/5haOrxEXeFjXM6PaRabtygJwktt/X9yU7NSfReOJk9yaXHxchn5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0015
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Ruijing,

ok in this case please prepare a kernel patch and send it to the mailing 
list with full description why we do this change.

Thanks,
Christian.

Am 15.07.22 um 15:33 schrieb Dong, Ruijing:
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> You are right, when process the libdrm code review (not committed yet), we realized the corresponding file needs to align to the kernel.
> So we will need to have this header file changed first, then to process libdrm code again.
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Friday, July 15, 2022 4:41 AM
> To: Dong, Ruijing <Ruijing.Dong@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: align between libdrm and drm api
>
> Am 14.07.22 um 23:22 schrieb Ruijing Dong:
>> define HW_IP_VCN_UNIFIED the same as HW_IP_VCN_ENC
> Usually that should be the other way around, libdrm aligns to the kernel.
>
> Why was that modification committed to libdrm first? There are usually plenty of warnings before we can do that.
>
> Regards,
> Christian.
>
>> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
>> ---
>>    include/uapi/drm/amdgpu_drm.h | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index 18d3246d636e..fe33db8441bc
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -560,6 +560,7 @@ struct drm_amdgpu_gem_va {
>>    #define AMDGPU_HW_IP_UVD_ENC      5
>>    #define AMDGPU_HW_IP_VCN_DEC      6
>>    #define AMDGPU_HW_IP_VCN_ENC      7
>> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
>>    #define AMDGPU_HW_IP_VCN_JPEG     8
>>    #define AMDGPU_HW_IP_NUM          9
>>

