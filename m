Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070F6E77170
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 19:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D7F10E5BB;
	Thu,  5 Dec 2024 19:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzu6oY4F";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C72810E5BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 19:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtSXn7sS5v0h37FVO06GodUj2y84Qx9AmnK+pIxLbU4DxRi7X1/DwhW52jWavFshKtvg7Cm1Wce+5VIBCdxhTNT9Xt3O2dVRaavqjGioFIgMx2NFQNyMUj0Ry2QJJ6dKhu5GjC/w5zRgEjkGnSuidn022URHHplShZnU3SyEPRCDTVgPMpBbmgCcHsaaZnPYYINQunAC+tFRTL15utRq3nc31dzbqVdggjlvArAOXaqBrcMzyIwTN5C5/2cqZww65DFG4RNyWaxmJ+WUwFJD0HUG+2Pqr/rL58ZycDlKVNrhitoO4tS1qhzbS3WYsbRE4GlmG7x6iAW38LogGA7HtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ3V3qwuqPR6aTRGd6P2qsg4IK9r0Jf17FzAr6ke1MM=;
 b=AIxQ0cnPUJCTnkP4QCANLjmKAg9fEvf8rxvPOQjqlKF6UfIZnYjZjbsq63ipcZZE6MKkeNxqlS1dAVLOtQShX6DHAeZLG12tL93gCK5CLzEL3/Vow1UH6C4AoPf19SN00wfVjQZ0OCHtyW3sroLJvrUsXBkCDZUAqI3YLBHE+onD+qNINPZujhalO/29uj2eYOklRxjhNYO1kW4e6tRJ8GMmzouRPYIhmlyjEZ+G+gLyGZR5TtOOq3KnMaUeEFNJvv3RFNy0DJ81z3OkLtVchEHpyXeaR9lZakNzmYDkfQrBKcO8KNXGgO5QYwUs8nxfuJDxRTnkfUur/MToDsSzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ3V3qwuqPR6aTRGd6P2qsg4IK9r0Jf17FzAr6ke1MM=;
 b=bzu6oY4Fx/HzrGLxEsY38UIBz6/yzIqNxjB7oJW8gDYKaqvpJ5nN38deuJ9I0jfZjDk8rj/ISkAlmbG5NfRgqbHNnuDYDvCSq6FQTuAsBx7xY/dirFOV/rXz+rSeImDcvQ7NQnvndfTBNIpk11pKdKDzGGtgVDr1uSRi6nFMzSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 19:00:19 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 19:00:18 +0000
Message-ID: <9fd3b988-d612-4b2d-9024-cda10f25893c@amd.com>
Date: Thu, 5 Dec 2024 14:00:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: hard-code cahceline for gc11
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241128161712.168408-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Belanger, David" <david.belanger@amd.com>
In-Reply-To: <20241128161712.168408-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::18) To CH3PR12MB9395.namprd12.prod.outlook.com
 (2603:10b6:610:1ce::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9395:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: e78e7dab-3ee5-4635-2be3-08dd155f0fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TExuQTZweEczcUtsL0VDWHNaMm1hZFlJbElBNVZOc1VPUnVKc3YwSTdjL0wz?=
 =?utf-8?B?SGR2dzRTQ25Sc1RFbStkTW5zT1lJV3VvUlYwMlUvZjhmdXJ5dmhpeHRwNVBj?=
 =?utf-8?B?Y0U3emtHYktjUWM1VUdyZkhTclNKenJrRFRGYm5jWkdudVFjTUVTQjh0VGZP?=
 =?utf-8?B?ZW1RRjFHdDVwM1BJRGdyeFg2aEFHdFpyUkRMTmJsbC85RnhlcmRoWVpBU3BK?=
 =?utf-8?B?YjFsVHFCOHNrWHMxdi9VTWFWVVhUYzdRQm9UWWpBcngxbFQ1dXFzVlg1dGNR?=
 =?utf-8?B?cit3SWMweW0zNU9oU1FIZlRScmhKWG5PTHdHMUFFaENHMGRMT1BaUDNPWVhH?=
 =?utf-8?B?cEZoaGp6WkRLNlk1L0YyR3d0NnhYZzRFc2NtUWNXbjlGa3VMcU53YUtpSFhi?=
 =?utf-8?B?dmxjMHQraWlPRVE3bGZnZEpzSDBPWlYvNEVZQS8ycVB6dE05cUFYVnBWVTdl?=
 =?utf-8?B?bDdRVExCaGdEVmx2YmlIWHpEd2djcWw3MUNxa1l1QzFvUTVHb3NYWlJ1SWJl?=
 =?utf-8?B?aTFOZ2owWVBSays3cHZERTlGR2tsYXNaY1ladEdNS3dRTHJZa0JCT2s5WkNm?=
 =?utf-8?B?TE55a2NTSGdZZnlLZHVxQytoaHJYa0lXY3A2Tm5NOFBHVVlseW5SSndyQ096?=
 =?utf-8?B?TG0wclE1MUlBSDdQQWxNY2Z4YnUzdW1RSzdiUnh0OTdhbXk5RWJ0SkxUdXpn?=
 =?utf-8?B?QUpncW5WekZ5Z1RXL1VzQlZndVkxKzI3eENBNXBNRUw5MXpxM05VZHlPbXRh?=
 =?utf-8?B?VytyK3cvcmJXVzhINDgyNm56SjB4MHQvK2d2a2N4NHVEVUc4L0hzTmVSNVBY?=
 =?utf-8?B?SHY3eHBuTGV3dG4zOEhqRVNGeEpHNU1PLzBxODAxVUFRU0dtNUpYZHd1NHd3?=
 =?utf-8?B?Y2wvUnF2WWNuOFVieVkyaUQycWRHUVRURGpRclp1WUFhMjFoSmRnaDhjRHFB?=
 =?utf-8?B?dW1xSlBnTTBJa0YzV29YcTI4cHhHQjY0WmYzZHFqcjdpMUl1dGNNUDgyNUE4?=
 =?utf-8?B?YklJMFloT1Vpdll6UlBzRUlwb1I2ajFKdnl4MjlWbi81eUpZKzlzb2t0dDZt?=
 =?utf-8?B?VzBjRTMwTU1uTExKUFVLL3Q3NVR4YlhRditkcVR1dGVGRWdnVmFqWlVmbk1P?=
 =?utf-8?B?dWcyZnhkaitzTFFnb3BWd05WUHpLK21MbW9NSTF2dlZQU3MyRHlHcytyS2N1?=
 =?utf-8?B?SE0rRUdaYmVKeDhya210TUhUWm53QVNERWhUbDE2N1FvNVJlM29RYytFcm1k?=
 =?utf-8?B?NDNvaHJiWHpMK3VMNnNPcTZkWHFhVUgxSk5FTkNXbXpWdU5lYlhuOHZRMkJ4?=
 =?utf-8?B?NFZNZUNOQ2VabnpsTHgwZVYxN1RPVXRtaFZYeWNPYkJlV1htOE91VEpNTnp2?=
 =?utf-8?B?Yk9keEhNZ1JqVXlVUnVYemw2Sjdid0d3dUtRKzlxSG9MMUVmUHYvZlRpNDBx?=
 =?utf-8?B?KzVheEl0K2Y1bjVqQXdUU29uc0NhY2JBZ1ZITWt2VVRGZStJVE5WaC9pM0Zl?=
 =?utf-8?B?Rm9RVktDUWtLYTdXQ1Y5RnBZUE05eEtxMXJQdjFSWVhyRTVUcWMvZkNJaHJL?=
 =?utf-8?B?VUFHZnVGcFhhMHd5Rld2ampBSkEwQVRCeTNhL1UrcnRGamNsWUUvK3VSL2lw?=
 =?utf-8?B?R0dTZUVFekdGTGQzL0FnTnFmNEFwTnRlYkthS0Rhdm41YllnY2RHd0MrVzlW?=
 =?utf-8?B?M0thUWlOUzVWVTRhM2JWekxQakJvdHR0NW1JTlBBMEVabUkrRFNCYWFJbXZ5?=
 =?utf-8?B?TnFxcXRtYWlWVkx1KzBjOThkZHZTenVNTVlZU2hZVjZ5dG9LcFA4VlNMaUcx?=
 =?utf-8?B?dHhybFJiR0VXQVNYcGpTUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZUMUZ4L2tVQnM0bURnbzZtdnpCZkZ2T2NzaVJ4VUgzWkJXcnlzU0RrQ0Ev?=
 =?utf-8?B?cDZQVG0waUNiS29NeFR6aWE0dDRPNzV0V3AvMVduUGU0dGhNdHFINmUwOUlt?=
 =?utf-8?B?VWM5N0NZQitPM250blZOWXJEVXArMVJjMFJUY0VwT2E4NzdlQmEyQUE4R2c1?=
 =?utf-8?B?VTZXeXZrZVV6Y243VU1jYlM1VjUzMFE3bHNRbHFVTWhqSGdBeXNOOFNiZkM4?=
 =?utf-8?B?TlYxQzZUNFhGT0E3ejlmSkR5WUpuUVFOVThYSmcxQ05LTW5WQVNlQWs0dDhu?=
 =?utf-8?B?ek5YNXZvRE1QLzNka1lGUzd3ZTRrQXNneENNSjlKSHlQRU0vZTlMT2w5ZG9Z?=
 =?utf-8?B?VUhHQUZnN3Eva090bThYREpVdVlaWkZlNjNlRVAzcW13K2NFeDNLZlAzQzBw?=
 =?utf-8?B?ZmF5RzlpbVVTQVdMdHdzblZoVm95cDZEZ2V6MEZVYU1kdmg1Z1ZZQlVUVTBS?=
 =?utf-8?B?NEphT0huTC9vVDhYdDB5RGU3ZzhBV2dodVhBSXdFTGsxaFhXS2FOVHhGUkRo?=
 =?utf-8?B?elgyTWtYbEhGbEdDM0h4aWtKRFpNNm4wLzJZRGt0Y2YzSDlpNWxLZHJCcjBn?=
 =?utf-8?B?YjV2Sm9tdVk5Y0d6bFlpbS9GNnRzQktuY0JIL2xpaUI3dDBCRWZkOTB6UDAw?=
 =?utf-8?B?aGw3MjBnNVVCbGVHUnp4MHVFTkp2RE5rVVNKUlVxQ1h4ckcvQjdGK1VSbHBP?=
 =?utf-8?B?Q2hRaE9SQU1adE9NSyt3QUdzbGVHWmxQOW1tZUgvRnVQZTVXM0lWak53TkFp?=
 =?utf-8?B?Q20xazRodnA0ZTNwNHVYSUlyMWI3VzUyejRYbmxrL0lxQW42WWF5OHZ4YkFx?=
 =?utf-8?B?eHNIZ1BKZDk0Zlc0YUxGRiswVFFNM0dZOUV6VVlxT0kwRzlJUE5ZYnRJenpv?=
 =?utf-8?B?QjhZODJNRisrL3pBQkgrOG1zdXFVRnFJZE9mRExvbm9TbGduMkozdm82N0I0?=
 =?utf-8?B?Uml3SVFjUmk3SzZ3cC91K0wyMDJleGFHZ2s1cUVyNUZYODJGZVBsN1dnZ1B0?=
 =?utf-8?B?SHdNbEYyMzluOWU1cVpEa3BWYUxtZjhLYkdRRXB3WkxuZHNxUzdvV242NW1m?=
 =?utf-8?B?dDhWVklhVlJrWjI5Z1krSG1TaUlZT3QxV2J0NjVVdG5ZUkJ3bVVEcFpCeGti?=
 =?utf-8?B?RnlVelo2ZXR4VEZnT1djSURjTmFWS2p1UkYwMWVNdmhYQ05EZWRsNy9ERXpK?=
 =?utf-8?B?a2pHSmxQem8xaUtHNXYzK1U0K1RCVm1nZ05FVm5QSjJDdldRSnJ4ZG80d25x?=
 =?utf-8?B?Z1QzY2pOODcrZkw0VitzbWtRM2VRczFLelFtdW0ySTFNSms0SWJOcWloWXB6?=
 =?utf-8?B?MzNkQ0tLZ2xidHp1OVhTdnpKMEREcENaYllVNUNNZFRKTkFONW0zeTRKRGRk?=
 =?utf-8?B?OHJieWZmZHJTK3dEcksvSVNCVmJ1SnlUL3o4bUE3dFhXY00wZXF0NWI4bGow?=
 =?utf-8?B?SFNNUEdCTGpLVjZFZFVTM0I0WFg1cVNLSU5yckhWYUk1ZDB3WGRQWHNFR1o3?=
 =?utf-8?B?Zkk3ZW5mVjlwUUFnUUtqbml1NU9oK1U0ZnB3TmZ5ZGNEVU1zT0pUd3U1cDF2?=
 =?utf-8?B?RXFWdXR0TWJ3T1hoRVEvYTR2MU0wb20wUU1wcEc3WUk3cE5OZXpNcjNTNXJl?=
 =?utf-8?B?dnp2aDRnbnlRb0puelFtUHcwYU45TG8yazg1R2xxK3pkYVdDZkh5UkMxSVYz?=
 =?utf-8?B?YVBycFR5cFo1RWZlNVV0TEZwSFhtRnp2clZiVDUwS1BVa0NrcWNqNU96MDln?=
 =?utf-8?B?UWRPd2k3TWV3Ui9UZHpjSnB2UEhYdTlkSDVYNy9vQXdHMHlJNFhnS0Y1TFNS?=
 =?utf-8?B?cDNIR3hLSlBPSkd1NE9acldicmdaVmFUU0VhdzF5MnB3b2g3YklkMWpCUDB2?=
 =?utf-8?B?MzM2dy9iVVJsSXBvTko5TTZDNk1TSWRtVmNIbmdJM0UzSVFaSWdDTnN4bCtZ?=
 =?utf-8?B?NUpScWNtZ0tKWEw2RmtQcmU1ZlhrQ3RtRG5veFJaaWVscEwzekoxTE83WW84?=
 =?utf-8?B?cGRmcENoTnlhbkFpaVVCVDg4RndJQVU1b3p1RUFoajBJVE9uTVVsWEFlVHdW?=
 =?utf-8?B?RFhNSmRoTUFwK1EzK2o3SER6VUhKSng2OXl4ck1NODZ5U1ZjbWcxVE56ZjJ2?=
 =?utf-8?Q?6OmL1yM3m1AcxTBobP+YJqJX1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78e7dab-3ee5-4635-2be3-08dd155f0fa1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 19:00:18.7155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0bk8O5HZwZzkJfnieTON+TOx7WLy/4Hh+S0EXjZQgEQrhwIHKmufyUiTCojTfSuJHAe2WRw0RpmkTiCKUnINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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


Please fix typo in title line:
cahceline -> cacheline

And I suggest also changing:
gc11 -> GFX11 (for consistency with typical name used in comments)

With comment fixes, I approve the commit:

Reviewed-by: David Belanger <david.belanger@amd.com>


On 11/28/2024 11:17 AM, Harish Kasiviswanathan wrote:
> This information is not available in ip discovery table.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 723f1220e1cc..3ca95f54601e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1423,6 +1423,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
>   
>   
>   static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
> +						   bool cache_line_size_missing,
>   						   struct kfd_gpu_cache_info *pcache_info)
>   {
>   	struct amdgpu_device *adev = kdev->adev;
> @@ -1437,6 +1438,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   					CRAT_CACHE_FLAGS_SIMD_CACHE);
>   		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
>   		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcp_cache_line_size;
> +		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
> +			pcache_info[i].cache_line_size = 128;
>   		i++;
>   	}
>   	/* Scalar L1 Instruction Cache per SQC */
> @@ -1449,6 +1452,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   					CRAT_CACHE_FLAGS_SIMD_CACHE);
>   		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
>   		pcache_info[i].cache_line_size = adev->gfx.config.gc_instruction_cache_line_size;
> +		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
> +			pcache_info[i].cache_line_size = 128;
>   		i++;
>   	}
>   	/* Scalar L1 Data Cache per SQC */
> @@ -1460,6 +1465,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   					CRAT_CACHE_FLAGS_SIMD_CACHE);
>   		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
>   		pcache_info[i].cache_line_size = adev->gfx.config.gc_scalar_data_cache_line_size;
> +		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
> +			pcache_info[i].cache_line_size = 64;
>   		i++;
>   	}
>   	/* GL1 Data Cache per SA */
> @@ -1472,7 +1479,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   					CRAT_CACHE_FLAGS_DATA_CACHE |
>   					CRAT_CACHE_FLAGS_SIMD_CACHE);
>   		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
> -		pcache_info[i].cache_line_size = 0;
> +		if (cache_line_size_missing)
> +			pcache_info[i].cache_line_size = 128;
>   		i++;
>   	}
>   	/* L2 Data Cache per GPU (Total Tex Cache) */
> @@ -1484,6 +1492,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   					CRAT_CACHE_FLAGS_SIMD_CACHE);
>   		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>   		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcc_cache_line_size;
> +		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
> +			pcache_info[i].cache_line_size = 128;
>   		i++;
>   	}
>   	/* L3 Data Cache per GPU */
> @@ -1563,6 +1573,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
>   int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pcache_info)
>   {
>   	int num_of_cache_types = 0;
> +	bool cache_line_size_missing = false;
>   
>   	switch (kdev->adev->asic_type) {
>   	case CHIP_KAVERI:
> @@ -1686,10 +1697,17 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   		case IP_VERSION(11, 5, 0):
>   		case IP_VERSION(11, 5, 1):
>   		case IP_VERSION(11, 5, 2):
> +			/* Cacheline size not available in IP discovery for gc11.
> +			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
> +			 */
> +			cache_line_size_missing = true;
> +			fallthrough;
>   		case IP_VERSION(12, 0, 0):
>   		case IP_VERSION(12, 0, 1):
>   			num_of_cache_types =
> -				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd, *pcache_info);
> +				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd,
> +									cache_line_size_missing,
> +									*pcache_info);
>   			break;
>   		default:
>   			*pcache_info = dummy_cache_info;
