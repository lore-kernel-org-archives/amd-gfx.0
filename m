Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7019C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8018210E087;
	Mon, 28 Mar 2022 13:02:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6A610E087
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQyF89xfvVhfAL19FTdh4CN5uZOpToMdYtH1cJgsSRaz2ZtBHz8wAtDSg6NQHI3eIkQWYc2N0QQVm6tx3FyO7x8kLdj8zdPdstBEPFgJosUw0X30ypigLtAk9LR3Ckjr31Nt1u7qFZO8Twsj9TdENfpYCW579knar6XQcKKOasAOFyCZvT8bqsqudBBHKYTVxuDLBgtKYTQozMJ25YubsZr0BY77pmaJPkyPPkIDQ2EraFmesg7rWdy3yUlot5Jww9TR3frEWbu7LxkNOEnZ8Wx1D1/hBIaInlpKKJM7RKvtbSak6LHVxXlgbH4ubSC/gcXIWre3Ap2sHEFd+wK4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PP3GGoHJmuWH0xzZtuhQlvUQvYmH/ZMbKeyWotEQs4=;
 b=O5ORZSVk4pQviuF/HBIiLvqzJVmXYNxIx+GkArcuK5yDef6MZ/QyqhrmSxFWw9V6BlbykRsGG6IPwEV8wZbsyVDOjCRN+EPNDkGalbnzYxbdRLSWDiKz7FWEkwFtx0RgD+ABxmbor/yh1Snusukvx2W8D5u+6TV+Z/edYvG984Bh3BPnWxxpPlA642uido3S3jzbD/B70QRKQT0HdzDvqUggUwn1PpvkpUKqEmJvmviCDCn8jW8GOIxXpR+4CkfesjEbea2zVeBtpwXq+tu6CzKb3nkzMLGB3jlXQzw5WqC/S9XBHfwZXgCrVO1JAsragyAHqg1zQLfz+EYtQUBhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PP3GGoHJmuWH0xzZtuhQlvUQvYmH/ZMbKeyWotEQs4=;
 b=PevRKL6fG56YI9w3a3z8QaZwVoDoMmy9XC5wyLLGaS6ih/kBOP/tm32kU1I9hq8TAVB6NxP28L0L6SBc4rMUYNWNgdG+dlYN/9Pf+ETcYarHnA2uFH1qAjwLh/2e5GHszarqAJ/M/CzMCyB9eKKqTtHCf1zKzJXrhFFH5pO03PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:02:13 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:02:11 +0000
Message-ID: <f5bd1e5e-769f-82f6-2d5d-b3d5595f5303@amd.com>
Date: Mon, 28 Mar 2022 18:31:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] amdgpu/pm: Enable sysfs node for pp_dpm_vclk for NAVI12
Content-Language: en-US
To: Marko Zekovic <Marko.Zekovic@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328105151.4634-1-Marko.Zekovic@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220328105151.4634-1-Marko.Zekovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d551917f-efb9-4a35-af0e-08da10bb2bd5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB450032ADB0C0049B30B95A7D971D9@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XFL28GSezs3qeAsbLHk5R2vi04AlKeOYyn7yIDWohiaEiZv7mHce5enjoC/4WJRfxLUkblBoOK1FicGyLwaC+kc9EMa4XuII/LC0oLc+9fc7foyu2UPJHq2KqOqJkl2foJvrveES4Sm3T68XIap2eOeSChumqGfONSdTjqNEkZXrR3TYqUqHrTKk1vHqtlHpSDuUIgMqPQucBl3sYEKdlI7RXyxCRWhlt+b7n7YYT4tKpQaLF7RNwZu5T6qlYZjnn+nxUfk5koNhQ2FO+xMr2iZGoIJzPYoqdv/N9ZYM7fNGyqf9RE4m1YNzA5BwQg3wG0ySdboBjupFzEzFEUm8+eBbVHan4FSXrnBUnJTF2dTGdMeqjZSOMBqsz8x0LY+1RGzKlEwJeB7iy7qh5lJm9oO62M+nTNcGFWKy9YjEOITZzvIhruRDRjqjT8LAC4nXm6ZJ+ppfTxRYSr77otf3Wlr5GqelNREkTRLBeOvOZ9sw/ZbpfzBTdoEFxGh3GlyQxDzWN1cFesAyRZd25fWGeMKcmR5EBwMWYOYRhspHMY1KQUEkjI4d4hnSXDMOun/cBYJe0NdDd40/oyWzOQlOIe5gquUKXayhzDtZskrhJABm+mCdPnjKO5CXeDns21bPsDT5NUHk1TOkRs/p9KqPrRS1bl0NzxyD+5Ge7WkYQMMb/dLGYZ4e5ph+e4E4RJK/Q/4WBKzI1+rSRlnFgUfhRn4QmyYjB7U5T6LHWxrLVCfowG4ojiEyPaXYG50Y5PM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2616005)(26005)(2906002)(38100700002)(508600001)(66476007)(186003)(53546011)(83380400001)(36756003)(31696002)(316002)(5660300002)(6512007)(8936002)(6506007)(31686004)(6666004)(66556008)(8676002)(6486002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJsczIxQTJhK3V6ckhDMVdlZXBIUXZpOWllRTlFUE1iYXl2Z1JsNnRHcktM?=
 =?utf-8?B?aHZnelNMOXVhU0pJRUxscUJxY1RTcHl3R0lST3BBMmZnMVZQd2tkWlRiVERs?=
 =?utf-8?B?Mm1maDZHbUxleWJsRi9UODVOUXV1ZDZDQVlndENicjhnVVBGOXhObXhycjNw?=
 =?utf-8?B?UXpCd3RGaThoZ1dtTHlxd2JRTVFEdlF5UURESXpsNnVVUHlGcHA1UU4rdnNw?=
 =?utf-8?B?SE9KandXT1ZkTExpMVYyU0ZHRzdSZm9xaGtaQ00vNG1MNWU2YzNhbytxTUxO?=
 =?utf-8?B?endhdVdkRk5tV1NQRDVKek5WblJLcTA0RHFTT1JtL2pKbkdYMkE2Mm1ialNH?=
 =?utf-8?B?M1Mzc21DdVJlS0NnSVViOHUveG9wb1FCS0FsOFNHOTRlQU1BRnduUmZLL3kv?=
 =?utf-8?B?cjl0bU9zR2NxWDBGd09IOW5ncE40cW5xTDJkRms5M0ZhU3hLbnVYRU1Fc0Iz?=
 =?utf-8?B?ek1wbno4NFVnTnBtK3RxSEI2VVh3THczKzlFQ2ZGaDFESDA4dlpYbDFVekRK?=
 =?utf-8?B?VWxvMHZWSnZ0bHZrYndvOVo1RFdxNGd2aEFtMy9vV0pyeXdOcGU2WmVkVUVY?=
 =?utf-8?B?dE00SlFHZ0M3VXhmWUQxT2tma2MxTjkxM0RzV3k0M0gzdnFnZWZkREhUNzEr?=
 =?utf-8?B?UURFdnVxTi85SzVzK2NqYmlaMUtSM2lFYzRsbXJPZjM4STZhZ0prQ3VQUENL?=
 =?utf-8?B?MFYxMnJ3bTRscHgwMFBHbUl5VzRueG5TdlVGa2paaFJCWW42dW9jbUVnVUdj?=
 =?utf-8?B?UzRIa0IyOEdxN01RcG5SUXF5TitUcDRpcDRFbkpWUTQvUkdmL3lyKzFuWitu?=
 =?utf-8?B?cmNyelU0WnBmLzhmOHNMQzdHMHpCMGp1VWlIb3hiRDQxTHJaVmhJMEhkOHo2?=
 =?utf-8?B?TkVQRWhLWGh3alQ4TXV2ditGZUFjSUtCMTY1RkU1QjE4NHl5VmVKVy9XZEoy?=
 =?utf-8?B?Z0NKLzY5Nzd0dEhuenBsa1k2aTY0Skt0MjRTRVc5eGFqREJtNEtVWXFxWld2?=
 =?utf-8?B?U3JCd0xYNE1uVm5sMWZseDZ6aFkvbGthdjVRQU40dFZERmtUUUdveW96RTQz?=
 =?utf-8?B?MDlvWWRZVjdLaGJoOVo1MWRteEdwM1FCWGwxOWlwOXpNdm93NjVFSHNmUVN0?=
 =?utf-8?B?a281MEVTaVhoeitxcEVEUmhLTFMzd1h3a3U4eXdzUUN5cXVIRWtoQldYamZk?=
 =?utf-8?B?T2s1bHI5bmQ4L2FIM0Z4K1F3WVR6UGU1YWMrT21HRnNnUEtqRW5BK05hM241?=
 =?utf-8?B?SlZONy9VTFRKcklpMjltSitYNkR2b0wybzFQY3VzVURrTWVRS2U3WEkwV1ox?=
 =?utf-8?B?Vm42ZXFmK1g4bTFMN3ZZUTk4NklLdTNHNjFkRkFhenQ2aUY5WGRlLys5cEND?=
 =?utf-8?B?aEdxN0M3U1ArcGRVRVUyVkNZK3hSK0xKb285Z1RNUDdiZlNycW45RC9lK1JP?=
 =?utf-8?B?dVQrUlAwM3dFUVBjNVZtTHRZRFNCV25kYUR4TVlDckppc0pYSTFidmJDYURG?=
 =?utf-8?B?WTF2cEdYSTBRTGViWTArUisvWkc1K1lhQThkMlc0dEZUN0tBMStSS09ZcHUy?=
 =?utf-8?B?ZFpIbTB2OXcxSEY0b1lKT0t6TkRsTjlkcU52MFloVVl2YXROaDhvcHRHMkNj?=
 =?utf-8?B?c1huNkpxT2diT3o4M2EvRWdGWk5la1FvMi9aSXpaR2FjTENuVjJyU0FKbW0w?=
 =?utf-8?B?ZHVmbVQ2T0dVZE8vTTZIalNmZ25SMW4xcEhMZ0orRytPQUxIcWo2cVlRMVE3?=
 =?utf-8?B?MmRQT0cwUldMRll4bURYREYzd0ZOSWFZSkFtMm95OFo5bmZmcjdnZFBLcUlM?=
 =?utf-8?B?akNyRlQ2OGZYNWY3M3RqSGltenkxMWtSNm9xbDVNVHE1cmdKS09JRFVHQlNt?=
 =?utf-8?B?eFBRVU93aFduT1hudXNydVdhUG5XY05xd3pUaWpLSEZPbDljbS9jcVhPWHAy?=
 =?utf-8?B?QVNzWkdYU0M3cGI1V3BpcEVmbWdwbVFZYkppZUNYZm1DRk83d0lsdHdFV0ZV?=
 =?utf-8?B?ekkrUUJCWTJUa2VMMGZ5amZHbWhkTGVuUlRYTmR5andtbnQ1c0hrNHNrS0Vz?=
 =?utf-8?B?UUlxOXB2V1JvTzk1bEpiYnEzTHpueXljR3JjNjNrVmprZ3loVUNoQ3ZoTnZS?=
 =?utf-8?B?Ryt2eTkrOFpmTm5mSExkTlZhdEY3dDVGMTBXOTV4a1NVYStsb0hrZ3RMU1d5?=
 =?utf-8?B?aWt6MkxwMWptNmNDVEFVUW5TczhGTlRVektMWDBaQWJDOE9BbHFKNkh0azZv?=
 =?utf-8?B?Y1NKM3NoZkl1V2NsUE9GYXNUYXFwZ29vZ3dKNDNETzVtSlkzekF4dlZUUUdu?=
 =?utf-8?B?SnRFUTZpa0dTd1o4RnZxWnUxZnVkWGI0dk42VGRWWXNoY2h6VFJQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d551917f-efb9-4a35-af0e-08da10bb2bd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:02:11.0761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nrGsg9CUxD1ci3ySl/q/N089tC5U0PkgLoSz+9WQcGQxTmOVWIs0iyRnvA951ov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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



On 3/28/2022 4:21 PM, Marko Zekovic wrote:
> SMI clock measure API is failing on NAVI12, because
> sysfs node for pp_dpm_vclk is not existing
> 
> Signed-off-by: Marko Zekovic <Marko.Zekovic@amd.com>
> Change-Id: I240fa055600bfc0d46dfec374339ba61764f9ab2
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9ce597ded31db..5d0602d2c1a1e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2001,7 +2001,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>   		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> -		      gc_ver == IP_VERSION(10, 3, 0)))
> +		      gc_ver == IP_VERSION(10, 3, 0) ||
> +		      gc_ver == IP_VERSION(10, 1, 2)))

For VCN, V and DCLK go in pair. A similar change needed for DCLK?

Thanks,
Lijo

>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>   		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> 
