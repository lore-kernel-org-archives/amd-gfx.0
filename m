Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB3C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 15:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFC510E06D;
	Mon, 17 Mar 2025 15:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q128LnPt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D2510E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 15:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqzl46Kek25vtsFgoWOc3NKwGvL6szL8DXEiA9LCvkcjrsBUPPDwEgCUQlH3gz7fkLc9R6ZWczudoFHf55RVdDWahLTkxFBTJrTfT0D7Cvs1VnKqVOoYvQEfxf85NTH6KAxziTdjViSpr1j5/hgQK56EOA0CdRuUCA6AL1/5oQdHehIzipugJiCkPPimxHIG4o74Y6kv6W7wf5j7CZO+255ozENHYYCM/WKdJhE4uxHSWyi9tGgS8moMKJ/h89QbfQMCiYKDMS/thjucV2tZaWfYmNzLPMxtEaAxOeZY3DFCVk67miOdNnqzF0J6iGHou1jKCw20eiajxawespkC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+BV3d4RMlpecVKrE3l3i9uNYL7zrwjWrA3E2jsOM3o=;
 b=y3K+ODCu1i3eh0O7PoupxmUE08AmuSIDgrDnf331rfF3JeFIl9MSKa8n/P+O8LOnaCzSvAuLHGYNMusjbZse8J7Pa6t+nuxUbeNZClTe2HVrf4FgTpt7UKeZXMY/Up2kNPrKklh4LlpasqWO3ZJ109H0SLRl26AKlSQvjXTjLHO4xXAvwq8j1CH9TEdwwwt5WLmZz2ona6bLlcg9UbiHDRhGqTY4/lFNn+W83tKnDjHLr/cU9moXmfpDRxqPPbVukqhN3ag05pjWtHhtSk6J4YRprQXcH21/hH0MePA4I2PCGeGdPvJkOjBVursLFPTBoGZLStUR0eJwhrR6KIz/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+BV3d4RMlpecVKrE3l3i9uNYL7zrwjWrA3E2jsOM3o=;
 b=Q128LnPtdbIj+GqNgStvIMkScw2s5x0CXclTl/CN4fZJTZI70VTye5LACxuwRJ2ZUFPtYgzlARW0ZeR4l7KqF2kOxlMZvqGBHyA5ex7uQW4kknbGnTC2OeJY0CoCZrKFmMsYMV/rREbJYGLZWI74HukAuoC22vfFv1UUsdesiGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 15:04:21 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:04:21 +0000
Message-ID: <aa63cf3e-8e27-4f0e-8ffa-52df9f8f2526@amd.com>
Date: Mon, 17 Mar 2025 20:34:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip pcie_replay_count sysfs creation for VF
To: Victor Skvortsov <victor.skvortsov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250317134555.179491-1-victor.skvortsov@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250317134555.179491-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: d76d7302-f464-459d-3b80-08dd6564fee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3dGdUJGN3c4L25FTUJYQVVrRHM3L0NtN2hrSEt1RG1INVlFckpQR1l3T3Ju?=
 =?utf-8?B?VHNDcnNDb0gxbERXeEtFditRc3lMSzZERCtTYllnME44bzFWUUNoQ0VrVGgw?=
 =?utf-8?B?bkJvVWx5YktmMVduQ294ZktrWmpYMXFrN1EyaHJhNmhHWTZzdlZxdDhZdW00?=
 =?utf-8?B?M0dKL2dza2VqbzRGemZ5WDR3QitjZnFYNGEvUzNpZnNYajV1Wm5raFFuQkRX?=
 =?utf-8?B?Y1Ewdm10SGxjeUo5TGJKWE1iL0plb0RCRnFWYmlNbXJ2ZlNPZ1ZRck52TW1y?=
 =?utf-8?B?a1h6VEFORFA3OXdueW9MTGNDWUhKdWt6dUl3YVNlWnhxNW8yK3R0OFlyK3pY?=
 =?utf-8?B?c3huc0E4SlUwSjV0eWJlSDh0WVRFKzFPdUYrak1ESUhkVzhlWUZrUnkvbHNC?=
 =?utf-8?B?R1djS3RERDN6Yk1vcmZCVnBkMzdHeHdhcG53L3A2YTRUdG4wLytnVy9LdFN1?=
 =?utf-8?B?UFBkYXRKRTczQ0R3dzRIOWxKdE5ZV3NHZzVCV2tlZUZUdHJ1d0I1SHRtUU5q?=
 =?utf-8?B?eHdNTFJHeS9kcEdlLzlIMHpLdm10MkVtb1M4RlRiUHhwMVRXS1NOS25INDM1?=
 =?utf-8?B?WUFsWTZWL3E5MWxVRHBOMmpybWxNZ2FJQUxoUFZQei9vSERnM1pCcFhGY3dU?=
 =?utf-8?B?QTZ4Smw0eEFWS0dRL1V4eWkwQjRzWVVWWXZQanVQT0xQVGVrcURHRCsvWGJF?=
 =?utf-8?B?emtNQnRhdU5HTzVPL1RPYnpUZGtZbzBYNFBVMDZTYk8wVW4zWEw1ZW1iYUxa?=
 =?utf-8?B?OERrd2p2cjhySlVmR1A3RFRjK3d4eW5iTjBKdTY3RkwrNHFZSDFoR2ZRa2pI?=
 =?utf-8?B?dkFmY21SWGFVR2g4NGlEdGlleEhHOXRsOVg0dHFjRFVoMjg3bDNXZTg1aWFl?=
 =?utf-8?B?MEN2L0owNnZ1QTJKdlZYSiszMU9HM2pTdHZpYkd3eS9tbzN0ZEhwUFVBK2U5?=
 =?utf-8?B?eFFReGNIQ0VvYyt6VnlwOHE2cDJ2cFdPM1EzOXdUMm1MOVlEaDhEdmFkOVF0?=
 =?utf-8?B?bmhnVU1oK09zM21SWmgwSlVMVzVQYi9OSjZFeVZGT0E5bTJieVYyakt6Uncr?=
 =?utf-8?B?YXVMNTlnaFBTajZ4NkRTNkc1K2RoOTFkT1R2c3hVUTZQWmVTTk1STFE5NlZC?=
 =?utf-8?B?aTJyUytoUkNBWkJQdC9BRUVTaHExT2xudGZjUDg1OVUxRFhLK3RZMFlFVWZ4?=
 =?utf-8?B?YncwK3gyZmpMWERHWWhUQnZ2ZHNjNVdoREJpQTMxU3NtYWl0L25jbXF1QzhQ?=
 =?utf-8?B?c1Vmb2ZCalYvVEU1UUhNYmlnemQvellPQzFaUUhHdkdSeGhrMDhyamFoRXNS?=
 =?utf-8?B?bFZVRXkwcmJ5TkFuejJYanpEblJwenRVYWMxbHgyQ2JwL3FaWGJvcU5ncm55?=
 =?utf-8?B?STF0Y012R3ZoWWtGV0xLMHVScHlid1NNemFiU2cvcWk4dmFHQmlrc2UzQ1Iz?=
 =?utf-8?B?cnF4Yzdra2hteFBuU21hRWpWVklvQ3N6bmN5cHlDMFJSMU1pUVNQVURiZ2NZ?=
 =?utf-8?B?WGRMSUZCeHBjQ0FGdENqb3hMM0FXc0hGK0swOG1reG9HTE1WMVBaM3creWRw?=
 =?utf-8?B?Sm1UVGtQUnN3SUt0MlpXV1Y2RXdYd0UwQitYL1ZKT2ZJakZwTEZhamI5eWNz?=
 =?utf-8?B?MXdtMWJ3cWYzalNJdlBqYmpHT0RZNzV3Q0toVXlzM29Hd0xULzFnRE1WcDE1?=
 =?utf-8?B?YlJOOW8rMjA4em1yTWE1YjdFNWlTTG02RXI3bk44THVhbXJIaFE1M1FCVUk5?=
 =?utf-8?B?S09NZmREb0kvZ3pCY3dXU2k1QnpVNllESXRrVndwUWpFdlc0TUpLL3hzcFFq?=
 =?utf-8?B?NUFCSW5FTWdFc3hzUEdWa1BrT2FuNFRLZUJnVlkwditSOU1ZNStRTmZid0po?=
 =?utf-8?Q?j9ep+E2giCrdF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pVamVyWW5OeFA2MzBLQVNpeVN1dFZrWDVZUmV2em94amFQeTdhc2d1WkFh?=
 =?utf-8?B?bVhWbytmZTJXK09LVERjWlBvcHExdEVzSTFvOE00ZTB3T0ZES2xncXJsTFhv?=
 =?utf-8?B?dlFTdWJqaHB2QzAxVVNpQTZ6L2ZjeS9qYThCNmJhQkIyTVlNVW40bFFkdGl2?=
 =?utf-8?B?UFdDUnVLUkkwb1JkenJvU21adGF1OTZQUm92YVRxM2I1bExEcG96R1I4L24r?=
 =?utf-8?B?YlUxaGR1VEtvU0R6Y1cvR0FHOHY4cmg1Zi9mWHpMenorNDBEKzIvak16K1kw?=
 =?utf-8?B?WVRSYUpnZUJJdXRWd0tFelJPQk13bE5WNTBvR2ZwOWpZQVpBVVlRTXNqdlRz?=
 =?utf-8?B?YlpMUjVGS056RTFldEY5RDkyNVMvOVBJRHR4UGlkNjIwWjEvVDJ1MjZJaFFn?=
 =?utf-8?B?OHVOQXhmd25hN1NiUWcrNmdqNG1sUXNKSEhlUmh5dUJTQ1QwREo5a3crVHI5?=
 =?utf-8?B?eC9MUEpoWDB6K2xSemZGT2RSVGFOSmpybXB1dDVLV1EwRUNWVDhsMWoxelhj?=
 =?utf-8?B?cldTR0tGdys0azFpNHJWTDNTM1VVRUlJL0V2TjRnVXdGRytwVW4xOUt2OVFw?=
 =?utf-8?B?K1ZWTlMyRzk5OFp2V2J5OHNOc1B6SFQwYTJQQXZDV3JuZFlENTJuMUJvWFpt?=
 =?utf-8?B?RkUrNzQya05KWFJWOTljTktobC9RNURFSzFmQWxHaHZsc1g1eXhVTFFvTUdm?=
 =?utf-8?B?eldrK2p3c3I3K1pwYk8wMHJ6eUhkaVRzNVF4bXBLM3NZdENxaUdJMnRoMU5Z?=
 =?utf-8?B?YjgyRUtZR0hrUHc3WjFsVHV3QTdOYk9rVnUyamdnZVREbVlJVU9YVE5IY3RK?=
 =?utf-8?B?ZFRlcDVIelV6eEJ3SWRBUVIrN1VZd3FOM3kzWGNsRUs0VUZUUUVneXg5Uzl1?=
 =?utf-8?B?cDE0R0wwRlpGYk5waUdDdkZlRXpoUm9Qd014dVFIYzJuL29SUzFkYXk3Z3NH?=
 =?utf-8?B?NTZBS2s3dXJYOHZWVDdrYVB4UEpmNDVhTTRwbnVKK1ZyREhWb2l1Y2pMc3A2?=
 =?utf-8?B?N3o2OC9KNDZKdkFNNysyb084dHgrTG52M0JDUzBOMVkxdmpmbG5rSmRLcnY5?=
 =?utf-8?B?ZTB3c2pzSDBDNmhrS3hoaG80ZEpoWHdYUjZsUzNGNjFBVnF1MzlCNlo5Z0JX?=
 =?utf-8?B?Y2ZNbEk2aWFOWFo4Vk8xTnlSSENZOWx1Y3N2ajRrM01PZEhBZHNGWWFLWGFz?=
 =?utf-8?B?MThjVzNaL0tDWUFQTE9Fa0tEOWNOYnhwUitGanFrVS8zSzBPWHZDZDF5YjA0?=
 =?utf-8?B?L1J4TEVWTm16UjA0bzV2aFNMSlpHUnBzL282RFhvVk9mZmpUa2o5eDNHN0xS?=
 =?utf-8?B?YlpUNUpqSGdKazVVVWZ0Qmg0L2tDZEw4WUhnZ2JJZTNibVhUWUI2N05WU1dm?=
 =?utf-8?B?WWQ4NWcrRGdzTXpPUHh6RDRZdHdXS3MyOEVBSkREa0dsdVBhQytSb2l3clFM?=
 =?utf-8?B?QnlUUlgrSEdKUmEwZkVQTnQ5KzNxaWhmb3VCWFhDbm8zMHFqSHYrK2lyVzNE?=
 =?utf-8?B?cXNYbjlMd2ZRb1JDbWltZnFUaXA4NkRCLy9IMDc3eW9na21YdWlwSis0ajRn?=
 =?utf-8?B?VGFQQXRsUWg2NDBzcE1pLytXVDRla0xYVE5JS0ZqQlA0WlAreEF5Y3NmZGkx?=
 =?utf-8?B?OEk0K2d1Z3VqNWU1Ri9iTG1INEVnSFc5V0RnK3RnYkh6MUZUYW1tZE1USzYx?=
 =?utf-8?B?N1Z6bkQxWjhBNDVSd2tqa25TNUg4dEM5NEpnalR4SXFRMkEya2hIY1Y4Smpm?=
 =?utf-8?B?QXUzU1VRL0ZJZGNwYmFFSW16ZzhETTZKck9pVFpCVThUYU52VWtXVTVTVHA0?=
 =?utf-8?B?VTZSU0JUN0tmazNaZzBucFRRM2h1WTdaMTBRNUhMNTZLMGxSY241VzQwYnlE?=
 =?utf-8?B?ZGJoSW9ST1BDOHRrdGNuY2twcGxYMU1jR09lK2hTbVZwSGdjS2R5QTJJcTE4?=
 =?utf-8?B?dDJpMHhoQVM4S0ZZU0hBWE9zRTlWL0RPVTBDK3JNejMyVUdtc3F6dEw4MURY?=
 =?utf-8?B?L0pmVjRzRUFVUStqTmRrTndwVnVHajZnVGtrUTNaUmxDd3JzTExYeCtFYUhh?=
 =?utf-8?B?am5tYTg4Q280b3JTZ05SYkJjQ2o3bHM5WEZYYkVQQWNyTEJEVWU4OHZSZE9j?=
 =?utf-8?Q?opHiG/sgGToyeKj4Mf08sOFnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76d7302-f464-459d-3b80-08dd6564fee5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:04:21.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gT1K7DdQIAl3AIV5OkaMazFTn5gNpsUkoI3Gvi7iY3bm9B0J21WaCqhz2d6DQav
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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



On 3/17/2025 7:15 PM, Victor Skvortsov wrote:
> VFs cannot read the NAK_COUNTER register. This information is only
> available through PMFW metrics.
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ca2ebdd3c95..86236cfad38c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -227,6 +227,24 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
>  static DEVICE_ATTR(pcie_replay_count, 0444,
>  		amdgpu_device_get_pcie_replay_count, NULL);
>  
> +static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
> +{
> +	int ret = 0;
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		ret = sysfs_create_file(&adev->dev->kobj,
> +					&dev_attr_pcie_replay_count.attr);
> +
> +	return ret;
> +}
> +
> +static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_sriov_vf(adev))
> +		sysfs_remove_file(&adev->dev->kobj,
> +				  &dev_attr_pcie_replay_count.attr);
> +}
> +
>  static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
>  					  struct bin_attribute *attr, char *buf,
>  					  loff_t ppos, size_t count)
> @@ -4166,11 +4184,6 @@ static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
>  }
>  #endif
>  
> -static const struct attribute *amdgpu_dev_attributes[] = {
> -	&dev_attr_pcie_replay_count.attr,
> -	NULL
> -};
> -
>  static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
>  {
>  	if (amdgpu_mcbp == 1)
> @@ -4609,7 +4622,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	} else
>  		adev->ucode_sysfs_en = true;
>  
> -	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
> +	r = amdgpu_device_attr_sysfs_init(adev);
>  	if (r)
>  		dev_err(adev->dev, "Could not create amdgpu device attr\n");
>  
> @@ -4746,7 +4759,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  		amdgpu_pm_sysfs_fini(adev);
>  	if (adev->ucode_sysfs_en)
>  		amdgpu_ucode_sysfs_fini(adev);
> -	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> +	amdgpu_device_attr_sysfs_fini(adev);
>  	amdgpu_fru_sysfs_fini(adev);
>  
>  	amdgpu_reg_state_sysfs_fini(adev);

