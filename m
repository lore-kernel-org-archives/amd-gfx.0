Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E38E77170
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 09:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CC810E0DF;
	Thu,  5 Dec 2024 09:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbIPpAaJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CA110E0DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 09:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X13YHuPcUbI478hAspc4r8vyz/Zu9Isw82LUKt282DAayAxKV6QWMIYOsWRx0aaCpQj2iNg7Eh8D8ecE9GrYvWdGqsDLYySz61OpE5Lq7F9AgDQVra01dxo3I++ni47ZX34IYh34okN3HhAuxmQnh18oQevncrCOdpgqW9zZcnWpCkzYnmQxnA2nWeBHibRwHOA519ki2VKs9yodWqjSPR7FeDGTQoBtwrXZTwFzWf6xrdwVKRgNEPsINrpwOFzssk2oUWxgUdn8f4aZU4g0OHO5ENWgFOZfk0L+1O3P/lBbZt4EOUC8xlG4TxkfPPkzAmJADOJCR+DejwOvZa4Krw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzuNd2yBLbAnJBf7yGFTud03VdN8FTBTnZEBLfm5EXQ=;
 b=NzyBjrT1BsGhebLITIuLaHW6coNhPk+xkOWqLToy3azJYsEMcJfIiZZqKDw3A+8mEGUmEbq7LtickKHVUPdZ8XAYCVADjolX1oBOZlb1D0z5YqfwG/MUx0t4wqQ6dTcGVhYZUr9ycqRaqkTsplr4VPcNxqY3qcGlpY9PZS1hk2X5MYhrRuXuqmHrffZ+oK2c0Z3d427SVQd3oRW1nl8oEI3dGswIK2RJW836by4O0bIbRROdefMRrsIVD0npMvLW2PydJqsyaehHxCBQOIZ8gIdGI/SStiVtIhKLS1qy1szEyUWb39YFv6QXye258Kwi68DlsRqYYOopg3/7EsMahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzuNd2yBLbAnJBf7yGFTud03VdN8FTBTnZEBLfm5EXQ=;
 b=mbIPpAaJtQvUJw52bPcYeaGcSIJ7jA6MlrLC3OOXAE5WQW3KqQUuX3N1oxGs6O/+xBBOo4bz1PfF4VOw1+EZVv/MVV2Oxjy+0kLl/uaJcy/btI0vRSBel4hdTxVTwLyPiJ1K6o5CbX3ukqdP+5RFRLVn6AcuMmAsd1M3GLVqLks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 09:46:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 09:46:54 +0000
Message-ID: <8bd679e0-2737-4082-acfb-60ca72453631@amd.com>
Date: Thu, 5 Dec 2024 10:46:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/uvd: get ring reference from rq scheduler
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Cc: leo.liu@amd.com
References: <20241204233138.796163-1-David.Wu3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241204233138.796163-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 837a490b-d61c-4fb1-ae19-08dd1511c07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWM3RWx5TEtoV3JDMWg2TFdpYUp2Wlc2dytsTFA5K1VVVXR4cWdYTkEzbjRG?=
 =?utf-8?B?TmlGY0pNYk41Ykw3MXZWZ3JYM09DUW5ObnhDR3FhTjJoZU4wbmxlWkYyMXZE?=
 =?utf-8?B?ZEVCbHNFT2hMeG1Eak9pYlQ1Z1hlai9YQ0N3RXU4bWI3a0FqZTdxdlJubmYr?=
 =?utf-8?B?YnFmT204UG5RUjB6S2c5b21NWTY5VGdQamVrMmRTTnlSYkV1OU8wOWQrZzcy?=
 =?utf-8?B?TXdvT203dHQ2MXNSUnNLSXAydmpvWGxsRXNSY0JtUkw4N0RxVlNmcWxFZWxJ?=
 =?utf-8?B?VDFPNFBTbVFyR3hZYURxc3FaVkVVdlJscHpydWVwYm1rczJOTXRFZzNrL2F3?=
 =?utf-8?B?bm1SZ2MvRmUyRUdJVnU4MWg0SlAvaWp3a2FZNVFBeTZqMzJ1ckc4N3hiaERh?=
 =?utf-8?B?bmlWcWdIaWJXZ3c1ODN0QXJNWE92Ti9DMG1aSTlYTkdPNFhQN0JuNDdoZERN?=
 =?utf-8?B?NWtZRnlFNnI0OENHbUN3MXhEMHphaGt1Z3dPUjZxamtFWTVCSnNqUEtzblY2?=
 =?utf-8?B?WWErQm9waENOQWJ6TDdxcWRGUnBNKzlVUFRLWExzUWtDVHVHUytJSk1qWStB?=
 =?utf-8?B?eXZFWFhjbHJ4U0hqaHpxb2RxSGxpRUhsWlhZbytXNE1Mak04VU52UHlLWmRM?=
 =?utf-8?B?Q0FPTHY3WGRxd2g4VnlGL0ZyeHZVK09lUExMeDVLWEJYbWl6U3dZRkF6K1RK?=
 =?utf-8?B?eW1rRG9hbE43TnhhNFQ5Zk5wSFRJem1iMWNTSFVSSU1NK3ZyVWNWN2lvdGdm?=
 =?utf-8?B?TlVMNXc4ejNNR1JNM05GTEpVQWs5Y2hWWk5oM0prZkIzUGhxN0NsYUg0V1Aw?=
 =?utf-8?B?bXQrV3dSOExGL3BSZTMzeW1SS1V0amx1SFJhcnN6UUkxTHhIK0lUblgreW1V?=
 =?utf-8?B?R25DK09ubWhBU0UyYTFwYkhEcWRiYnM5MlpublhYclVsZ01TMFJrT0I1a0l2?=
 =?utf-8?B?NEdmdmdlNU1JRjBLK2JCaWJLS0MvdVc5UGZUODFUSTEwblNqenJPWHJrcFZn?=
 =?utf-8?B?RVVEeFdIKzM4REE1blJzZ3Uyd2RtRkJVL2dtVzZ4Wk1qM2JHSnRtbzRUMi95?=
 =?utf-8?B?N1FMbHRCcFpURTdGVEF4TnJOUGdiZVN3OFp6RzJhckVLaW5ra3h6VEJ5ZWpn?=
 =?utf-8?B?dnNBRW9ZZ3V1Z1k0Q0lqY0xOYW9GakV4cGszOC9HRitNQTZwdDNiMkN0QnVu?=
 =?utf-8?B?bmRwTnptQVNnekNTTjhBZXo3WTYzRUQ4Rjh3NjF1NmhxRXFhSzVGTEk4NGRW?=
 =?utf-8?B?R3FpSlQ0Nks5Q2poNzl3VHk5Z0RuS2w4RjRCOVNWWUtlTFBheUtLQ0t3dmJ6?=
 =?utf-8?B?WGNzSlRqNDFYU2JtdnN3VmRYS3ZrbVpveS9WaFVXV0YxNVNLR1FPYzR2c2NY?=
 =?utf-8?B?SUF6SFRoZUxBRjdiWFFERGZ6cVJJYndFekhqMlUycytDenhWYktKWS9UMFFU?=
 =?utf-8?B?QWZrdWM0Ym9ydzFremZBSW1Pd0VaQzRPY3VXejRHeDkvUjlVczVNU1M2UlhI?=
 =?utf-8?B?TVYrTjkyZFJxZnVseXdoR3ZadmRmeUViMzdmbnNnM0NFeEtyaWxiakxWZWty?=
 =?utf-8?B?RjVNV2Q4NjVZTnhjeHpyeWQrVTdSbUgxaVVkMXdpMDMvZnRaYUd4TWFnQ25y?=
 =?utf-8?B?NnlIR3BnNnViM1Z0VHFlZm9xRXdrclo2bU9xenYvRzY4NVF6ZVkwR1F2b3hG?=
 =?utf-8?B?ZktvaUM4cXY5aVhlUE9iTUtrdTVQN3VzR2JERVZOYzZKTm40ZTUxeElXS3ls?=
 =?utf-8?B?UVhOdTdNWGgyRm9EY2pDcEZXZmZQd3VwY0JVS3BiaWF3Z0RhcGV4V0o2SE0w?=
 =?utf-8?B?SVU1cFEzYlNKSWlZOUR6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFqdVU2bGwvYlkrUjFkbWxQTTZYa25MK04zcStxVnFUQndWQXk4OEV2ZG9F?=
 =?utf-8?B?b0tyMG9Hb2IwQzY2WXZkL1A3M3JEbVJOVjAwZ3pDaGFGdERXL0tVU2Rib3kr?=
 =?utf-8?B?ayticlk1T09XUGZTRUV1L2cwZmY4NkpjWGtXeDdwZ3dQZldUdmhKU1k5amxl?=
 =?utf-8?B?RTMvUzBqR09CNjROd0Nkd285WTB2eG96SmZzVk1OOER6d3h5akh2SDhIUVcv?=
 =?utf-8?B?M1RDOUNLNEs3dHdDVjdQRU45YlNvUHNLdTVYTlpVT3psKzBFYTBhWlBuUHpH?=
 =?utf-8?B?K2l3RlIvN2NLc3NBQlMxSUlNaStpL1pjbG94NlBsMTB4K3UxcUpTNGxOcm40?=
 =?utf-8?B?YmRPKytPaTE5ZWJJMWo5QVM2bG9Sc24xclVtTTJic1dKMGFjeVgrQjEyM0U3?=
 =?utf-8?B?RXgxS3BzSGNMYTYzZWhEVFNkVFBqODNFUTFJRFlqOWZmT1ZCcXhMSXV3SkV1?=
 =?utf-8?B?dlJGWlk0S0xMWjQ3M0M4eWZ6RU1pbklJcVFaRkp2S25oK0VxRkZGOWgyY05R?=
 =?utf-8?B?emU4QnVyWUkzVEtSVWdnaysxbGNoL0RibUhEek5qVTRsK0VaWXk0dzJVc0RF?=
 =?utf-8?B?Mis2YTlWTmY5QXBLZzg3V2h3UzJKOGNkZVhBNzZ6SHVqVGRBbGxxTDU2Qmlq?=
 =?utf-8?B?dWhLb3RKTzZmOHlFNklhamt6V09sRzVHY1NPcEtBeFVGMG5LSytZUXdndkFC?=
 =?utf-8?B?b1lIWVZmdGIyd2xNblZQdUUxQ3N1T0ozb1I5RTk0OVhCRCszNnJLRmpIY2Rm?=
 =?utf-8?B?cGZFaFJkSFNQMU02eTlHSThNZnhOQU5IaGRXRmpETGttNlZQL21GN2JMY09m?=
 =?utf-8?B?K1lKVDllQllxd1V1ZWZhaURKdktGdGgxYlpyMXZpeXVpL0VvWUw5Tk1vbjhY?=
 =?utf-8?B?ajluaFowT3Axc3J4NDdUUVZPc0p4Rm5FdC9DVGlhZmxySFo5Y2tZOTVyWnJq?=
 =?utf-8?B?SnB1N3Zxa21LbUNrclQzY0JtcDdMdlJQekk0cjA5NHZ3Y25vdVlSK1EwcGxo?=
 =?utf-8?B?ZVI0SWdHdXQ2OXkyVGpGRW45K25uMkowTW5qdlBDWWlMNW93SDFnWnI1TWtI?=
 =?utf-8?B?aXRZOEhvWktiQi9Wa0d4MTMzT1hjcVhCRkZvaVduVkkyVjhCVUtOM2lBVWxp?=
 =?utf-8?B?a3lvbXpjVGEwZ29wSGRaNm1hOHNudjhzeUxiN1hIUmp5MGhnOHVoYzhUalhz?=
 =?utf-8?B?NDVleDUxV1c3c1VpWTFpc1A2YmdRbFg0c3VzaVdSRnFUUVFxdzdxUzZNUmVk?=
 =?utf-8?B?Nk9kR25qcmN1d2EwSFhZdFQrMW50NTdkQmFyUy9tdjdWMi96VU1FNVFiMkNu?=
 =?utf-8?B?ekhWTy9UbkhoVFA3WFp5QStiT0xKcGdEeS90UExGVlNSRHRaK2k5ZFJCRWZS?=
 =?utf-8?B?cEcyc1ZvRXhMSXZrdGpuMnlXUmdDYko0OERFV0VQQ1pNUmM4RFlxK1RCbExh?=
 =?utf-8?B?S1VFVXpxenRXcHhuSUpnMm5vS1dQYTNrMVpJWkJKR3pHbmxySDhrVGFtS1FS?=
 =?utf-8?B?MmlYRjIveHF0enZOMFJqbFU1b1JDSXJjclUvam9ZZURvS2NMQlBROW5HSTR1?=
 =?utf-8?B?SWUwUWw0YTlhVHpObGZNdG1MV242R0pseHRpT091TjFyWm9JRUxJR3dpSEc2?=
 =?utf-8?B?aHJQQ0xMck9uM1FYaE84SDN4cS83cGV4TUh5TXpyZjhCK29XOGF2VnRtdjdT?=
 =?utf-8?B?MlZmNGpwNGg3b0VjeGlvQ3ZoZnZBZ01rOVZBbUZ4c1NDUTRSZXJwd1k1a3g5?=
 =?utf-8?B?UzRTMWZXS0VzZjRzQ2c0TFdsOFR2dTA2VzJZMEk1Z01PaVVMSzlyYW9rWHgy?=
 =?utf-8?B?Z29SOHBzOGFRNVNmUTJ0YStxVTkvWS9tVE1YeENCRGpwS2RjeHdPYmJmQ3dw?=
 =?utf-8?B?UEx6dGxORlJsbWxHaVNSZE8yMHZxNThyODhhUkVLNEp0ZmRqbUZsSG4raHBi?=
 =?utf-8?B?OVpZQzkvQkNYSjI3blhBUDY0bHN0SzZDcG4xNzFGd3dYWVNpMnZodjRhK0Mr?=
 =?utf-8?B?ODA5bDlqRHJwUS9ySzRsRmN5clhSTk9PZERzMFFsNWljcW1YbmZKdHh4L0Zu?=
 =?utf-8?B?YlhuUmpXblZtOU50M0ZMUVQrNXdCNnJ4ajJFaTVnV2FGSHFjMVpMTG9KaWla?=
 =?utf-8?Q?xl2BN91ZNEwI+t/tZRySXxqeZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837a490b-d61c-4fb1-ae19-08dd1511c07b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 09:46:54.6893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV8SMV6wfYr20yDmzB25Yq7awTeOW68GUBaTX48Wleqz8Rm41zL1EE8Hkei+mEq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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

Am 05.12.24 um 00:31 schrieb David (Ming Qiang) Wu:
> base.sched may not be set for each instance and should not
> be used for cases such as non-IB tests.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 53249d4ff8ec..9d237b5937fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1288,7 +1288,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   					   struct amdgpu_job *job,
>   					   struct amdgpu_ib *ib)
>   {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
> +	struct amdgpu_ring *ring = amdgpu_job_ring(job);
>   	unsigned i;
>   
>   	/* No patching necessary for the first instance */

