Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6AC2D0D0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 04:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724DA10E326;
	Mon, 24 Jun 2024 04:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urboWTGI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5DF10E326
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 04:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IenJMsfnWxaP3b/qmwkGqgh8paHEt9WOwZGt99R7Z8TFlMUhwhUc0EzpmEGdRKepHJFIrA8dTa0ogu/ULyfgR0RwezsgpOfy4+sAP/euBwjseoF7XMWiyzqB3nvq73ZrFOT55suY2sijpITT8OdM4YLQFEyHa+O3RELtuYHWVDrmyQlvPA8XlGxKVYKt6ExQRcOLYRJKm6olaURs0UgOyiIF8RGVemTHzZ68b/kvkNUt6m4ttw6ilKE4MKRXHL1qlNa+mezZWrkw6xoXldymnKxkg07ekGUOhnK4JKqjlXmZ1Uay8v6QYVuy8hm5P21ytQyq1PxRH0CHFstZw4M9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKXE9JVAkziWvfYNCp7YaXs5bLDIqWHhKFLTqKV+p/M=;
 b=dalIgrH7VlBx+dnvGYFMPFJGbzsWf8yeMDNKmOzJN056wBZo+gk4iFINMAK2q7swzDXM2XapDJmdjr1f1vmOG94aMevU0Z1a4/RjmuEMhFP+XxMhCpu/3GPKM1LqbaQKDuorMtwkXvFSbG9ooTxUPp1fzDfnNphZ1a0RwCzhZ3X+xerdeR87xcGelp3Iv8irUYH3EdsiPYXWVBINn946Zr5o1nlr44hG9ou8D1g4mm0W3MehlYjCx94m8cjp8CuW9wYm9pOyAMm5hBLEIJazvJOHFBG0FquEOEOswmIgwQadyLO7V012tYZFNCVzYdRtDAVV3OWAYCluJpPqPWaU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKXE9JVAkziWvfYNCp7YaXs5bLDIqWHhKFLTqKV+p/M=;
 b=urboWTGITUax+qqjhcYzVjFEoLEVSAhFWYvPDCLNYUwC+rjaV1aGywN8/IJxniyk92mXCGTuBfpQ8+qRpiWp4llaZhO0qUceg0kx234qYU/0dl8Q5mU7SxWyNjwdxN4jGEHqUXvSywR/m0GoHkNmkAb8cJnRDv0pP0H9g2v3iEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.21; Mon, 24 Jun 2024 04:44:42 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 04:44:42 +0000
Message-ID: <41d6b445-364d-44d4-9ffe-f0f111a6b2a4@amd.com>
Date: Mon, 24 Jun 2024 10:14:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: Disable compute partition switch under
 SRIOV
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, alexander.deucher@amd.com
References: <20240622154751.632271-1-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240622154751.632271-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a6ed18-0e02-4d24-9128-08dc94085cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmZpa2g5OXVwQVRjSkFUOFJERks1OEUxSUR1SUE5V2FldXQwS0I5WW1KTGI5?=
 =?utf-8?B?R1d4eklNak40RDNLa2NqWGRvNzUwTjJSQUx5NzFDZE9QczUzcXVFY2EvREpP?=
 =?utf-8?B?RGI1YlJ5S2pUMEd2dXJmMnlHYjhxaWM0MS9pU1I2cE5KZWFCbW9tWWJwUEZG?=
 =?utf-8?B?SEgzYnUxd04vOC80ai8yWlVrOU8wQVdtWDQ4WmlZTWZCNDNyQkRFN21VWDMx?=
 =?utf-8?B?M1F3cS84SWRwd2c5ZlVENXVFNy9mSEJ4Nzh5U3ExVzQrOGk0WWdtUlZPZ29u?=
 =?utf-8?B?OUpnNUREbXhwa3hhUmNPK2RKMXpRYzNXYndwanRQVkxsdnJDZnphckZCVnpE?=
 =?utf-8?B?VWxqVVBKcEdmamdNd2tDdXk3Mk81dEZYQkcwMWRlbnU0a2xCMWNScHhTOFJ2?=
 =?utf-8?B?UjJGM2NmeHhrTStQNUdBUEJlSGtueUQ0Um1vYm40RXFlT09renNqeitDSStn?=
 =?utf-8?B?TXlWQnIrQTE0NE5YT2k4WHNFQi9hVTNKQkNJWW1jWWoyZ21TWDR6OVhiODdQ?=
 =?utf-8?B?ancrVWZsYmRLQ21CaDNRQjBCS09tMHdUVU4rYnpaU1h0RUNabnpIbVE1VVM3?=
 =?utf-8?B?WUVlZTUzd1IzQ0JtdEpacjZrdmZEUGtxM3NOaEwwWHdNQjc1TnpMWVRUUmxu?=
 =?utf-8?B?ekVTUXlmYjBBWXlKR1hmT2hwUEtMZzlNWVgyZUZKRFhwQmRzaTk3Vit6NUp5?=
 =?utf-8?B?RmNpa0ZWWGNBZWdGTWJNSW9oVmdrSktiS0E0OHB0eURoVlhLbThZNS93RWJS?=
 =?utf-8?B?TDdma01lNldyVk9GdUJSTXV5SHBlckkzS2R3emJCM0FsTnNVc3lJclUvOW1h?=
 =?utf-8?B?aTRZV2lsL1YxNEt0L1o1SjhTWVlwZXl6WFZGTjdHUkhlK3hSekFyZXpXZi9Q?=
 =?utf-8?B?cXhlYU9lejZGQ3BLNWJGeGxqeTE0R3hERHdxUTI2Z0hHOFBLdlRSNmpUSTZt?=
 =?utf-8?B?UDlBQ2xKVVpGMjhQa0lDdU9KMWltVmFJZ3EzTFRuQlY2TThoZG91Qjl0KzdL?=
 =?utf-8?B?QStPSEpKb25PVWxwbjd1anVzdm1XL1RiMTVPTjdWYzVaUTBFS1o3QzYzcWxD?=
 =?utf-8?B?VFRNV0FpUXIrQjJwN291NThNT2YvdnpWNUtCT2YrMWxxejZ0OEJMSFdTZmla?=
 =?utf-8?B?U1BaeWprUW5iZ0FsL2FNdEtnemxWUHphYndKdm9zUi9JMWtUcCtLaHBtUkkw?=
 =?utf-8?B?dVdxZGJCRC9rMHE5cXl4Y1lLOTNyR2xPd2puMUIyOEhuMXZEdUFJSEZBMnBi?=
 =?utf-8?B?TEEzQ2NYRnJCYTE3RWFsVERRZTNsMThoYUZoeU9ROEFFRVAvdnVIYjJZUUpH?=
 =?utf-8?B?R0RGZzdQMzZ1SEl5R3pNaThoamhIcmtMTnlnL2Q0WFg2Vm1uT2RWcmhnazFI?=
 =?utf-8?B?U2V1YU9TUm0zZjNHV1ZGWE9GVEVuaE5ZV01ac01CckphOVRxWURzbDZSK0c5?=
 =?utf-8?B?OTZCaU83N1RMZm5lSVZHVWNWeWRBeWE2OHhvVHpGQm84eEFYQ2ExdVpoQjll?=
 =?utf-8?B?eTVDY0dzQWlBM0FGYm5IZnF3WThNYXp6aVNKdm5FbVNZSFhRbUw5Tm1TQVNC?=
 =?utf-8?B?TTNBalFRc05LdFhEMVlCWGF0Z1JtbitJbDRyWUk0cSs0ajZDZWphWDRjQW8x?=
 =?utf-8?B?Q3AzaTQyeUZIcERtUkZ5VkJDVVc3bXNaYkppbERYZGR2Zno0cUlZbTVlMjZ3?=
 =?utf-8?B?QTFDZnNtK2twU3J3cW5MZE5DdnRBQjdNZExlT25hK2RLZVJ4YS8yenZDYk5O?=
 =?utf-8?Q?l+JEwJbUf/yhHWDs3qDJHuVKr1S/j+cMOBqlwGY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZESFpEbWV3SHFSTUhLaitxYndNYlFLNURIQXVTVUs4Zk16QVNHZWl1N2dO?=
 =?utf-8?B?OWFFKzR6L0R6QkFvVkZ5MjRjcG5CQllTRGtwb21VcEtQZUNUUTh0Qit5Vlk0?=
 =?utf-8?B?dml4cDNNSUg1TDB3bkJoVlQ1YlQ3NXdkVFpPZjVKeVc4VDdKRWpXZFcvSnVa?=
 =?utf-8?B?c0kvbXhIa1Rxd1hwV0h2WGM4MnVkVHFURDFBWWQzS1VCWmZNa04za1hYb0dU?=
 =?utf-8?B?SEs5U2FjcEw2VFI5LzYxUHgxMG95YW5tcWVrRHR5V1VySVIwSjliWlpEaU1y?=
 =?utf-8?B?ZWtnSTE0a3JoUmo0WlYzZ2RUV2RlRWRWK2dBRlcrdUN4TVI0NVlsNmpEdG1p?=
 =?utf-8?B?UzY3SFc3WnA2T2QzeXZTNEpackxuSnU2S2p0aFh6NW5YYUxpSTRMeG9rNUdF?=
 =?utf-8?B?eW5tRXdZM0J3UjAyeGtlRVRhMkNXQ056VTY0WVRSdUV0SXlGWkJjKytnenQ4?=
 =?utf-8?B?ODFTQjRTNmc4WUNIbVBHTmFQQjYrTVNxVFAydEFSL0VWaUlYL1B4QVV5czNF?=
 =?utf-8?B?cGNrbVJHN3BZVTdORUszN1pvK0M4OFp5VEM3OXJKV1preXMxME9xMk5KelVB?=
 =?utf-8?B?SlRBRGwyME9pSmJWQWhxTk5sdXVaNXBMSXo2S3NyQTkzZ3hTZUhaYzhqdWFo?=
 =?utf-8?B?WitZUUZoZkxqUDNWUmM4OW96ZHF2U1hLamNBZ0gwR1pvcEI5M1RKOFBmK2pj?=
 =?utf-8?B?aHVpaFNXaWg0cWtpNGUxQzdCVDZndzVXRnFiZVY4Nms0L2xueG02a0JnYnhZ?=
 =?utf-8?B?VWtobXMvZ3l0S2FkSy9DMCt3bi9OWmx3VENMYTcrMlppK0tuT0RoNHFoT3FG?=
 =?utf-8?B?Ynd3NXc2TDRPK291VlhxL2Q1VVo2QU9vZFRoRTRWdU5pTDd5N052MGs1OGRN?=
 =?utf-8?B?TXJQejJWalNqRm4vOHYwS1JLSmwraXdjQjdOY25tbTRsUzNKU2QwckdkcjFj?=
 =?utf-8?B?TUFvdXo3b1M4cG9EWndzdDFPa1QwRDFmbGszSjRkVWVFL2Z3K0VSekZqbXFn?=
 =?utf-8?B?YUFORi9kQTJCR1doaUg4U1VUZ3dNeHQ0QTI1bHlaZXFRanBnbzNNSGN2Wlpm?=
 =?utf-8?B?OHpDUDB5cjYvZ280cldOM2ZzSWRxd3hQZkUxZTZXSnRITFFCdGU1RXVRYjZP?=
 =?utf-8?B?Vm1OQlNROVdMWm9BTkFFYXY2bmNtbWhxYW5QdHBXbE8wTjhqTldoVEwyTzNX?=
 =?utf-8?B?ZHZiQ0lPS3R3eEFGMnlid0U0MWFPQkJPN2NNaGMwWG1oN0toMzNpeHpnZW1C?=
 =?utf-8?B?MjZQVWRWUGg0SmpGbm5DUmFGajNRVmM3eWVOYmJKTGFZenhwWm95OXF6Wkxo?=
 =?utf-8?B?b0VtSDR6UEQvVyt1RzEyenBZZlIvREN3Uy9JN3pXOWtJY25WWVgyYzhFTmcr?=
 =?utf-8?B?QzJabEJmMmtRM3ZKZjBhMjNtYU45V29WRXJOMGZwaGYvTDFOSG5HUUhTMC9o?=
 =?utf-8?B?bjdNc3ZVYm5adWwzYzh2b2pkMC8yWUZvNVBhSnhUdmlHTm00WndiaFM0ckFn?=
 =?utf-8?B?YXpqaTRCSHlsWEJsTHJLbFI1SXl1eHo3YmlIRjEwYmt6MVVNWVJucHBXazFR?=
 =?utf-8?B?dk1rNXJBN0lmcW1ndHlQVUJrdWhRTWU5MjR3TEZ1eXp4SGE2WnNRTmhwSExL?=
 =?utf-8?B?dFhUR3BFTUgxV1pKVk9Pa2lpVk9wZUV5ejhRamhXcGZxbGQxTFFndWRsVnZZ?=
 =?utf-8?B?MjgrR3QxblcyMFN0NU1FWEM2ZnBKMnhzZEE4MzJMdnpGVXdzZTdaMUw1MUFL?=
 =?utf-8?B?ek45V09QZy9OS0pqdk9xZlc4MDNLVkNZWTErSS8xQUJWOWFEKzVKNTJDdysr?=
 =?utf-8?B?eXNiUSs3WXpFSEVPa3QzNFZkRXdQaUdkWU1yNHlVVFdBYmdqQzhKUjRTdmNR?=
 =?utf-8?B?UjRrNHR6TGdHRnovYmd5UE5lMXB3QjJrVjNaY045U3RpZEJlMzNRMTQyUksr?=
 =?utf-8?B?MzN4cWdJNlpmZVBLbkc0UEUvN2VVeWorTHZvNm8yTlNoeHV2WGxLakd6VWV6?=
 =?utf-8?B?Vnl0YU5LSlZJdEYvSWNWWTJWdE9oczdlMWhvckpWalVuQVJJVE9vajFWUVFW?=
 =?utf-8?B?K3pGUURFNk5saWV4b3QxT2drRGZJdmtFaUhqU1ZveFhUbUtxbFpPeVBKNkxD?=
 =?utf-8?Q?XhBtLqOoptatzZk1FfbFwIq2K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a6ed18-0e02-4d24-9128-08dc94085cd3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 04:44:42.1885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiaVwvS7WncQ24rrESbuxYCiUTFRivU7nSVniLZPTSUpG/kMPUd03eGqOKS66bW0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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



On 6/22/2024 9:17 PM, Rajneesh Bhardwaj wrote:
> Do not allow the compute partition mode switch from the guest driver but
> still allow the query for current_compute_partition.
> 
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 82452606ae6c..1c673c0b65d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1292,6 +1292,11 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
>  	enum amdgpu_gfx_partition mode;
>  	int ret = 0, num_xcc;
>  
> +	/* Under SRIOV, this is allowed only via the host driver but not from
> +	 * within the VF */
> +	if (amdgpu_sriov_vf(adev))
> +		return -EPERM;
> +

This is not the way to do this. It needs to disable switch partition
callback in xcp_mgr for VF mode. That's the one which will be checked
for making the sysfs node read/write vs read-only.

Thanks,
Lijo
>  	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>  	if (num_xcc % 2 != 0)
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8d8763ebe027..f87dc1b9d77c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -936,11 +936,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
>  	if (r)
>  		return r;
>  
> -
> -	if (!amdgpu_sriov_vf(adev))
> -		r = amdgpu_gfx_sysfs_init(adev);
> -
> -	return r;
> +	return amdgpu_gfx_sysfs_init(adev);
>  }
>  
>  static int gfx_v9_4_3_sw_fini(void *handle)
> @@ -961,8 +957,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>  	gfx_v9_4_3_mec_fini(adev);
>  	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>  	gfx_v9_4_3_free_microcode(adev);
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_gfx_sysfs_fini(adev);
> +	amdgpu_gfx_sysfs_fini(adev);
>  
>  	return 0;
>  }
