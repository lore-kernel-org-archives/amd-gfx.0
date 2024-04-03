Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1C8C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 01:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7171122B9;
	Wed,  3 Apr 2024 01:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wM3r1h7z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01BC1122B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 01:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAGdVyuokwNWjSb76rphKTqpzbFauca+KUtT9/v9LaghAaV0HEOp8XkzvafsGWyuVaA1rKtN3GwzNVcGHPncAYhvNX2jF0zCps4EVUNfq+DWYq4WAX435mQ5W3A12fmOcrEcW7UXqOOhFEwhTpFn/9ePJ8A2EeVZ/uzquzdDTbgpJUxWKlvfz6HaPM9zgxFD8rmtFK/+ltfxZhGt4+C6YPUrsmd7ZdRr1dOWillCxqOgnCxQqc2EGAFkbhjakRaC8RAF7mAGW/WS4Ehj5R6rA7yvPcVpRROvVNSfCnC6lp7qH9hYSg848MwIMH/kve/YTtY/VuXyAejJd9oeci3GHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO04MUuurQYkeAJQfzxTm9EUAVGaI3suDcAZ6Cnin0w=;
 b=TCETtTy1QOVWKdtclNNn8NV6Q+oq3+kzJZpL0MWz6/LG/1QkVVGqkeJcpiVC3+4YtpKyWzzK4+A9Vu1CApKe/7MFhYKdfcwyIEzvbBjjoM/J/pSS/mKpadC5iKjKglEkeUApnFJLLvJEsMbGaVtR4+BqvHOKEA9kGpaQNqb3s7GnQwAohy77XgkF+oN/ZKteRl8ohcLYc7YoEn4UwPo+M/o7pDdoT+dHSzKq2Iy5VXeK71OMYHgAOP94Scg9Uofh4L9J4fh+n3CXuynarBt16T81YzzNirKEcfBMn/oIoVNdnV8rp6PDTeQwx/s8srMhyqjxi8hE0+nKUuFUPV/sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO04MUuurQYkeAJQfzxTm9EUAVGaI3suDcAZ6Cnin0w=;
 b=wM3r1h7zbRhUMSPtce5o11fgKpqYgKJr1PXetxU2QAL4jK9PsHAM++CSxJuHRuIOC/387mksjPhObdU+s/9WwtVX67qXoBBp6HwDGKLYGE9y2qDOUUkYSoDwyRpyfCnRqMBkPQvc5Uz+o0aDneWI2wr2PpkMHG8Xz6auQaBqEr0=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 01:31:17 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 01:31:16 +0000
Message-ID: <de774146-0253-485b-8572-0c5cee1ceef0@amd.com>
Date: Tue, 2 Apr 2024 20:31:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/amdkfd: sync all devices to wait all processes
 being evicted
Content-Language: en-CA
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com, felix.kuehling@amd.com
References: <20240401215349.23361-1-Zhigang.Luo@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240401215349.23361-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:806:127::32) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|IA1PR12MB6532:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XD5MQXlVom1AvLbt0cA71WBzdHlS6DPzXIhHpPq2J9/XCbt0/NwYlRH8A8sR9Ik3TeBPqnLI0V+BRxtlM9tJVSmyzObV3RsfcU9zCWTZ9wy3WyEKImAAshlfoPTAkroRWhYjy1bCxKABEnLtCsiVAY8C8N2xq3SOuiF9rUpqcA9/GCIrqYw7fH7OSzpj+Ba6NUGKrXoRoz09ukyJlB/2z1lfoTcpOKBQjzyBGmzDcm83A8RbDr48KJjnGGu0JCNl/l0jq0OERh7Oojd3BvAF3Qjy6dmpLoXCZKfaImkK4MacaLNzWcjITRuB/Rc8yZa3wcfOJYlF9lIkaKxL+vuw0F7M2YZN6Q5ID+n8V9kTBkbXY2Sk+2VIQYt586/UOD0by9j+W09e3BEHauYxU/x5KpjZyVpj120teTv8zPsbTo4c6QBuaRUANXq6Kohw/r4cxfs26Pfwi2umNiOV2o6Jrep9BLPLQYzT1GfB8jXXy5uNUKg5zY+sIRWv/Y5CPNTbyTngQaUUU1b6B/ctG+nOj4iX3OaiFB5QUtYzl5EY5cpPFpcHC0Tpp4ylSEf70KZvBeuKnBm8URpwQTVJb7rnoTgwinbVif/HH6GVDToux17CVfE83O5z/ULBGYu6cEELbooU0eCAvYSqdoYL92w++MH2lqfdKXwTPjhw4HCApc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?empzVGs2RXlKZUVNQW5lN3ZIbUhJNFQrQUJIMzVDeElDZkpGcjlFOTBwWXRn?=
 =?utf-8?B?L3pETHRMYUlaa3FtNU9UMER1MGFrb21wQW8rSU9RT1lCelFwU3FLcjkwcm9G?=
 =?utf-8?B?dEJqZjBRNkNMMGlIendkY1NQUk1GZTNtc2tnVFhJbUNlN25lKzZ0ZHI3N1Mv?=
 =?utf-8?B?dzVuZDR1bDRmOU9EakZqT29xclFmSDlUSXFEYVFrQ3hmemV4a25DRDlsZGhp?=
 =?utf-8?B?VktLbDJ4N25ML1gzNU43WnB5VDFJVGd0TGdLTkRvZitqMnZYNG9UbE9Yekps?=
 =?utf-8?B?cGZCYU9tREpHVmhLTFhaNnNrRjBMa01QSXQ4b1NpU1hBTGt5ZVpWWHhzTjJY?=
 =?utf-8?B?Nms4ZzFYci9JWEl0WFF3QjhrU2E1NitScG9oOFBaWUlRMm1XeWxUVUVOUmJG?=
 =?utf-8?B?b3FONGN5R1JJWk5LdDdwakY3dmdVTTRsR01peE1qVmExMEQ3WWVCSzhTdFdI?=
 =?utf-8?B?bXVlUDNVZmdSUTJRdWNXSHVZa1E0ZVBVenUrcUFwU1ZJRjFOdW5mUkhQOWo5?=
 =?utf-8?B?OUkyTDhSc2tUemhYdEJqZXVBQ2l1b1RaZW1XWlVSRldwN2RRZks0REM3eThm?=
 =?utf-8?B?ak5uMWVKZm82V29ERm4zQXBPNnQ2d0NreE1mQ1ZjVGlFN3A4OVp4eGdBVW96?=
 =?utf-8?B?azFXbkRib1BYWmNlaHpHR1hxSitMazRsT0ppbFNZem1KZVYvcTMyTXhYYUs5?=
 =?utf-8?B?aXlnZ01vSjlCeW5hMndCdWV5bUtlVmtGT1I4ZEQ4T2lhdkZsVWxhRjU5bkpX?=
 =?utf-8?B?TW1NcnBWQmFkZDQxem92RGZGTWpocTVVU2l5SERJd3l1SFhiTlZCNXdtOEJT?=
 =?utf-8?B?eFZOTytxRTYzUGtOVDV0Y1pVdUJkN3I3YnRvZU1naU9EYTdXQUIxcE5Xb1Zp?=
 =?utf-8?B?dXM0WGNkbWlRbDFHN3hFc2ZIb1BVS2NzTVlYLzMycHg1QkprTGpYa0MvUmd0?=
 =?utf-8?B?RHdBUW1FYnliUzI4ZURuRnh5ZStZN3dVRjMzOVZrMXphTytGODZmUWpOMzhE?=
 =?utf-8?B?T05Id0NWS3Q3cFRkRUliWGdzMlV3WXdWNU9ZWVVDRlRqdTR4OGNOK3R0dVhB?=
 =?utf-8?B?aGxIeWtiTkdZYWhHeUtmM0I3c21iZUd6ZW1qRndHTTFiMkhnNGwycjVFbmJs?=
 =?utf-8?B?ZDc1MVdDSGtXN3hEZ3ZWd1pCSmpyTTIxUk1ETjlxYm4ybVc3OVlwUTRaeHNZ?=
 =?utf-8?B?VVl0Y08xWkFsdHAzSFkyUks3QlgyZnZZSHZMOGFJdWVyeC95OWZUZHNsOWc3?=
 =?utf-8?B?dzJNSXNtUDlxMjlERjJzN0RBTHJpQ0R5SU5CaExUYWROUFpJRkpnTTVKZ1ZD?=
 =?utf-8?B?Wmo5MjJzaVc1bldvcWhsMG1MYVpabEpqWS9EQjFpa1JtWW1jckYxTHRZblRQ?=
 =?utf-8?B?L09yZnpkNmxxSVB0YlZFdE1IZzJNRHdNeGdhSzFMYlNRQ3lYbEJhRGFoRHYv?=
 =?utf-8?B?OFJhTUU1ZzVsaTc3anhiRUdWQ3p3SWVNZ0JabGRadUpkd2FTU1Bvd3dBWFJN?=
 =?utf-8?B?Z2x0cWN1bzVyRm42a0JwZWx0Zk82MS9KWXJ1QzBCbXR1a3R4b0g3UnM4K2Mr?=
 =?utf-8?B?aWZ2VjFlM1I5cWEwcW1nM0xMM0ppbkI0UzJpcVlKR3R1OXY5bmFqWS9kamlQ?=
 =?utf-8?B?eFhlaERaRTRrL3k0cC92bVFJNkxERldJa3JxdXpJR3B2LzdjUXhuaWVVRStH?=
 =?utf-8?B?UmJudDNBY2VTR1ltbkIvYTAxRm9jMTE3UW1nUi9sQXNQRTRBeCtzUmlWNFpC?=
 =?utf-8?B?RHRaTEEyaWRDM0xaK3lzY0ppWGhXSC9kWUNMMHpvTTNOaXJQQ2xDdnZOU000?=
 =?utf-8?B?ajJvL1JNWnZQS2wyRWNFNHJHN3l1ZDdXWFQwRGFHbVJReE44S3NTR3YwanhG?=
 =?utf-8?B?MnJZT3IwMHJwZyszY0ZNcnVwQVYwYnB1S0hqZlF0UUZCT0U0aGJHWXFwKzNS?=
 =?utf-8?B?SVJrdWo3K0EyUUdrTnZlUWJxTGl4SmtnV0dHbTV0b1FyMXMzLzFJY2lZZjVq?=
 =?utf-8?B?K1dBTEdLcXc4K2lRejJ1MkUrTW9EZEF2MUNQYkhTcy9uTEU0QlgrNS9ZRUV3?=
 =?utf-8?B?UjJaZmZvQWFtb2VSNElPdENrTzJ6SjZIRnRLdmpTWHlvaEpheUE1NzZ4U2hX?=
 =?utf-8?Q?45hQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9de179-48f4-4b7a-1dc2-08dc537dc1c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 01:31:16.8326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C7V87jA6s4on8xsrAPWO9zbkpsRFrtNZA7hmHfytKmYUQ7ZqdaSS9785UI8As5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 4/1/2024 4:53 PM, Zhigang Luo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> If there are more than one device doing reset in parallel, the first
> device will call kfd_suspend_all_processes() to evict all processes
> on all devices, this call takes time to finish. other device will
> start reset and recover without waiting. if the process has not been
> evicted before doing recover, it will be restored, then caused page
> fault.
>
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 041ec3de55e7..55f89c858c7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -969,11 +969,11 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>          if (!run_pm) {
>                  mutex_lock(&kfd_processes_mutex);
>                  count = ++kfd_locked;
> -               mutex_unlock(&kfd_processes_mutex);
>
>                  /* For first KFD device suspend all the KFD processes */
>                  if (count == 1)
>                          kfd_suspend_all_processes();
> +               mutex_unlock(&kfd_processes_mutex);
>          }

I do not understand why use kfd_lock here. You want evict all processes 
when first device got suspended. The kfd_lock indicates if all kfd 
driver functions got locked. It is not same meaning as device suspend. 
That is not your patch issue, but I think using different flag to record 
device suspend is better. ex, if kfd_lock got set for some other 
reasons, we would skip evicting processes here.

Regards

Xiaogang

>          for (i = 0; i < kfd->num_nodes; i++) {
> --
> 2.25.1
>
