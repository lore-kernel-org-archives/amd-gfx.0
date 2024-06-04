Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786F4C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 18:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC29910E0EA;
	Tue,  4 Jun 2024 18:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="objpU/Q2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D617A10E0EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 18:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUsKqIqBYthFx1uiD4yYkpVP0lZ0c7AoWm38C9uFoh4h6/ktfdfpo7QQkU3HhKJuta+LqWtOg3A+WKq9z3zDBHlDvEFhdnWUfGXUNBpDE1vKHG0xUDD4AQJYyM9wYbyzDZ7k5KdAUeoL2ByDv7qxcMpa4O58L/4dEdbBrmB50ugFYhYu0qxYDtwi6I4M8NISL6cfPgOzG5QCjw8DWQmPiwXCuv+H3SShJAUjH1UdAaVZv1pPl5LF2vP/zQJxG4hbDdpdDZMSAZqQNPZlAiskOYqNVvPIgzu/2QKn9TV17PfE5Ozuk8APvzc2JZ2/ArV+P/ccz2iB0PCkqiUeiShIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+alXwzHpz0KmCoNA3SEUe3B+fVOvQukUrRcXApv6/s=;
 b=I0FR20nZdx5tcRu5Ky91o1AnbPevSnPbPL8TO5q6h4SPS7b9HWf4KNE3lBF/fuKa62PWJdatXrIKDQMfkwY/1AMtaFVLXx/PzFdG18AEhIecZ8lJ0j9Db+Yb5oYPC7hbcIZACUjHnOoxkmYuPeodXfibGTlveihVtJChb4gfX7NIsNtEtIB78KzPaUJKtuZBt1nMJCFlr+B+2Y5fm14J4uRwJiKLObrHazoS/uApCt4LZGVCtveZPacnanrdOz7bjthFO0ppe/GpMqriAn/doVf4A5gCbP12ptUKckQYZ0jqG4fCw371bZuzvAkk9hpr1QFeRXvP3xgNp4y3AadPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+alXwzHpz0KmCoNA3SEUe3B+fVOvQukUrRcXApv6/s=;
 b=objpU/Q2pkEdy6G+FcIbWpIAs6o5/XuuivSIGsVyFAhlkygUYFaQtzKrtgjN+etK2rOwR/+EN8fU3dVXB0OYHcJyqiX+mydYVWVGli4SJ5AYJPFVLQ9stcK8hvDa5zKf/i0d7bm4acMfOAV+7BNGOW/WNFK09QRIQfKz6svKmYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 18:40:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:40:00 +0000
Message-ID: <797565c8-77f9-4f74-bf1c-c5cd7b380906@amd.com>
Date: Tue, 4 Jun 2024 14:39:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] drm/amdkfd: remove logically dead code
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240603084947.2570291-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240603084947.2570291-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0342.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d4300a2a-8c65-4393-b64a-08dc84c5bd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZVVTRGSVJMT3dsTHJvNnVTMU16bHl3TUZBYU1GaVY4aWVobmpSTnZYelJI?=
 =?utf-8?B?a1pxRStWQnFiMEZSdEtHaitBU0s0eWRSZjlKOWNFZERUUUl1L1EwYjNnM1lJ?=
 =?utf-8?B?WDBuK3VxNkM2MVpJRHBJc1FWSjZvWDVCdE5lZVdYeklIVTRFZTFlU2lkeWFS?=
 =?utf-8?B?ZFVHMHpDaytiUnlsMnpSciszODhJMnc2ejEyVWgyRjd1dWphMDl3RkVtNTN6?=
 =?utf-8?B?UU94TlRvMlowc3k1VVV4ZUk2STRLaGQ5a045WHFuUkN5RkRGTytuYXJHWWlY?=
 =?utf-8?B?R0lsM2ZtckFKU2o0VTA2b0xpUUE0NHk0N01aRWN0Q0JqcnlmSHhzTC9wMmdU?=
 =?utf-8?B?cVFTeVJEOHdaT25ZSDNJbnVPd01UZnU1SVVnZVBsYkhhSWljNi9yc3hQWDR2?=
 =?utf-8?B?MnNOdGFVUEt4elVWaVpRTVhaSUFWWStoWldvdjk1M0ltT01BdFFqcFNSb1Nl?=
 =?utf-8?B?djFnVThFZGtLV210bVluZXAwZG5kVFJRZ2V6QjVLelJEV1dnamFJZWY1NHZv?=
 =?utf-8?B?N1c5bFdmc0hrc2tOMVBKUTRmazBGc215Wms1MUNzaDlNRElycHVXdlVHT29r?=
 =?utf-8?B?WFNUZkpadTMwTlYxalY1aWM3NStkWitQWVpHdk9qb1ZMbkUwM2tiNnEyZFND?=
 =?utf-8?B?dEtmV016anNzdEZUMU1qeDEzKzUrZCtZcFpkbU1icm40bTRwOU5GMk1hall6?=
 =?utf-8?B?bjJ6T1h4TTlUdTExMnQxTGFGVk01aTJHVUpwbktpamxKNW01R2VNWkppWmdh?=
 =?utf-8?B?d1JKT3VsUVlRWmMyYy9qcGlra2RMTE84WVRXbUF4amlZMHVYY21XNFhKU0xJ?=
 =?utf-8?B?YzlUN05RbmRBdUg5Ynk5a1IyYWtsSWdxVC9OZVViNG1pRmZLRHVRdGVPQ2dl?=
 =?utf-8?B?S3pkQmRTT2xqeC9zKzc3dExjRFpPcGxEczdXRkNNVWl1UFZiL0lEWWFMZzJR?=
 =?utf-8?B?U0lKckh2TUNqNFd5cC9EREZVRm9ZeTdYRW80aGY1RnJQK0JYVjhNTGZEbVNx?=
 =?utf-8?B?b29LSldPY3N4cWllaTNWZlNuL2gwMGdPTlZaWENEa2cxSTg2cnVrUEs5bk5h?=
 =?utf-8?B?WkU3a09VOXR4UTA2bzhsbjA5WDNCUEdtcGpiMndkS1l2MnpreHJuQ1lpWE9T?=
 =?utf-8?B?K2d4ZHBaWlZPdFBtZDhVa0dFZG85dW1sdnFtNlVXNnl0TUx1WjJqbTR6Y3R5?=
 =?utf-8?B?TzlqblBwelVOV3dJanNFdnhTeUZyNUZENVM4L0R3cklmTFp1OStjbllOMDFB?=
 =?utf-8?B?ak00NDlsUHh6Z3V0cG01OTl1Vzc4NVFZZmNsWHRFb1JmMlFCeWY1TnFqc01J?=
 =?utf-8?B?WEZ6ZUpYSVRmTG45VHNrdUtEY2YvWlVYb2JwakxVQTNWOE5NWGFGM2U5TmZU?=
 =?utf-8?B?bm1SUFcxc0FKSkRqTkN2MGs2S0VOU0JKMTVhWTdBZWsrSElhOFUwZUorNUpl?=
 =?utf-8?B?aSt3Rmg2eVlDWnd4L0Y5MnBzYlVJODNPalZ3b3RPOWg4bVMrRStpRTExRU1D?=
 =?utf-8?B?R0xFQ0RlVTRyUUVVT3JEM2hCSm5rN09HTk81NmRxLzNyMWdpNGJLakU4ZTdq?=
 =?utf-8?B?Ulh3RmZ4RU5RNC9IVURLU2J0enlxNDdpMTJBUU1YcU9uUUlhaTluZ3QxbUxO?=
 =?utf-8?B?T2NLYVVRb2Y2NXU3VzZaeHRaRGxhUXM5TkhlYTFYakFKRXpCbHNUelJ1cDQw?=
 =?utf-8?B?YW1tcWM1Z1FNdzl5TS9Zam5zeVhOV3BVUFRySkxjK2hGQ3M5bExBRmJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZkeWhnWTJEeE1oa0hrTS9xQ1cvOE13U2ZmS0RMNE0rZmdjbzVVZTdwNytG?=
 =?utf-8?B?YU94LytTVzZ1Q212Wm9WVDFyMURPT0E2MVp4eStVNnhKOUxwdEN2YlFvSE83?=
 =?utf-8?B?OHdrajNEQ3Vub0VqZGpqMi9zYTFzRTVzU3d1bjkyQU03Y3hOTnBSb2JlS1NJ?=
 =?utf-8?B?T3IweU1vUHpmMEdCaVoyZkd3K043ZmpLQVhraGQwR3NucFdPdzl5bHN6L0pW?=
 =?utf-8?B?UDlSR3ZWVldxa0ord2JkRmFFcjJIdUw5VjFDbVA1TWx0ejM3U1FsODRVTERa?=
 =?utf-8?B?blFKTnFhbVR3MnFFZkx6dlBtYzB5T21oM2FoU1IrUmR1SU9JTlg1RmQyc3g3?=
 =?utf-8?B?L3NJcU0yZkp5eUFQYm9mT3RYM0s2OTJ6MW5MUmYyOFNJRVVuc3p0cGg4b0Vr?=
 =?utf-8?B?bklYSXBabmFpWUNTQ3p3a0JPVE1JVDZ6dlhLSUdadTJNSzludCtxVDAvSDNO?=
 =?utf-8?B?TW4ybnZUb2h3OEwwMWxvWE4rQmxCMGVTejE3YmpkRmNVR1VjczJremdVdkZ6?=
 =?utf-8?B?bFQwY2ZxaENjdFdWcU1HR2prYUZHR2FiT3hjajhGemlzQjI2RTlnRmlaMyta?=
 =?utf-8?B?U0hVUGtCbGNFOXRJYXU5eVg0YlNIUGJTenowVWJibjdCckxXaFRKYWFpejdN?=
 =?utf-8?B?K3FaelhGbHhNd0xUVzR2QWlndDVTeXl4VGMrQTB4NWpVajRrU2lheFdwZllW?=
 =?utf-8?B?Q1lTdFBUM2h1VWFaT0ZDOTRmanJPL3hWOEI5dnNiVDYvK3NKdXhtb3A5dTA4?=
 =?utf-8?B?ZEo0S1p1bWlvU3ZqUXRzOE01S0c3V1M5ODNhTEZDcURxUzZPRzdtYnR5VFZR?=
 =?utf-8?B?T1V2TnZmSzF6ZjRwM1VEZ0hNWUFYOEc4Ujk0d2JUajRHTjllWG1Pcm5GTjhs?=
 =?utf-8?B?YlJ0d1V6WnNKMFJ1bzRHR1BUV1MzU29BbUNkenB6OTh2T240U09YNEpRaWVo?=
 =?utf-8?B?Qkx1a2llWit3OU9IclJQTDEwYXNRWm5QaFNLKzZONDRNZXhsaUZiNkJJd0E3?=
 =?utf-8?B?OUdUQ0RlV0ZzRFBRblhkb1FSaXd0ZG8vdFFmSTViV0lYRlF3eVk2elZsS3Vl?=
 =?utf-8?B?aGVJVVppK0h1RmlqWHI3YTU0Mmt6TVBDZU9iTlc1bUVLbUpXZVkwNG1vSG42?=
 =?utf-8?B?Uld0MU9IVDFubWVBMXhKVHhPYjFCWngwdjFWUXAwRml3RGtyRDVpN3duQnpO?=
 =?utf-8?B?dWkrbXM3b0RFR1JPbTF4V2NEMVJ1ZTdyeUdBazZ3U283dmtWZ01GSktwODhF?=
 =?utf-8?B?dENJRHVNTWtCVEZOdS9DWmdYS3F3MGpRNWkzMUw2UEdEeXQzUHYxQll0UWVh?=
 =?utf-8?B?OHpCYXRCSzhaUzNoWU5UVmFnN3A2Ump3REdZM0o0MzBEazBnTGxHdTZxTi82?=
 =?utf-8?B?YjdSS3ZOSHhUNExoOGh1WnJMczV0T29vWklvazg0N3hIM1Zzb2hFRStRNTBB?=
 =?utf-8?B?aEVNSDdkRERnd21SejI2bXVLZzJmL0FWTnhvTExNM2puYkdoQnZqWmJwQVk4?=
 =?utf-8?B?RkZ2OTBVQlVxTGE1OGxsRThQdFNxbFhpbmN1dDl1ZGkvU2hiNlcrVzRKWVRD?=
 =?utf-8?B?VWpzMHNLZGpaclBOYlVmVUxHZDVWZk5ra1I5Yk84dWVMdnF4L2JVWmV0bGlm?=
 =?utf-8?B?S0VFOEl1LytZSEwwVHdtejVobnVYcklLOFJFWGtXN0dWTHk1aXM3YXowUnYw?=
 =?utf-8?B?K1VIdnY4SU1CeFZaR3VGbU5kZm4xc1cvNi93cERqWnQ2U2hsb0dzWHNPRzZ6?=
 =?utf-8?B?Ylk0dFNJSlVnRmtyYm54SlJ5UDQxM3g0TUEvSHFpTE14TVhOQk40eHUvc1g5?=
 =?utf-8?B?UW8wQXozQytEdW93ajBxalRrTXRGYmlPRCtmd09zOVpHY0g0NkowcFZXUWdP?=
 =?utf-8?B?amFVM2x6Rm81dVhYQnEyaG9zQ1h6YVRQRnUwdXRHUEFSU0FHTVRaN0lUMlBD?=
 =?utf-8?B?U1NsUWtteW5Eb0FBTWZQNjVkTHJXZ0JrUzVnckZ1VE5WTmplSit6U0NaNEtw?=
 =?utf-8?B?WkJXeXJ5bTJJV3NIUGZ1ZTJJVjVES3JDWXFVZklpcXBpSmNxREcxK3ZuSWQw?=
 =?utf-8?B?TU45dktDb1hpbjNJNXVYUk1rbG5zR1grTDJ1bWdsV25NZnZ6anRsem9pZ1lz?=
 =?utf-8?Q?TSvINdpB6fuG2DJ3gEA3DNz+D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4300a2a-8c65-4393-b64a-08dc84c5bd62
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:40:00.1921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX9BDlt0oKNhnlZEx6X+MVcFBz6fM+Explz+KeD4w7D0oL7+WdRf0LPKzmAnxkqRWhvYZ/kYg14tRFb4iEAo2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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


On 2024-06-03 04:49, Jesse Zhang wrote:
> idr_for_each_entry can ensure that mem is not empty during the loop.
> So don't need check mem again.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index fdf171ad4a3c..32e5db509560 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1913,11 +1913,6 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   			struct kfd_criu_bo_priv_data *bo_priv;
>   			int i, dev_idx = 0;
>   
> -			if (!mem) {
> -				ret = -ENOMEM;
> -				goto exit;
> -			}
> -
>   			kgd_mem = (struct kgd_mem *)mem;
>   			dumper_bo = kgd_mem->bo;
>   
