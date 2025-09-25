Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C31CCAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 08:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E9410E887;
	Thu, 25 Sep 2025 08:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c2MsgES6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AAC10E887
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 08:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDY1n56h7VU9Ugh7Pz9MpF8JGYLNeb6kC8gleR1ILsx/0PuqsAh1VWVDw+ar4iteolhe6WP6tYbYyLm+9m1U/vZs7TFhFTMGx5NMuLXeXGRWCBotsiqbK5qvovfU0MB3yskKYpSsh8/aCGrsiVoLgnLK7UEKwNyMrw8bZnkConTQCcVPg223CR51aNWAX4spxCVgu2ylvSlIJV+kaLTPHTFD1vcStJrF6ksp6FLFbL/86SP6BkxSLq2sNhx0sxSZSaQI1s9oyreYMWXUwGYhBXwdKZsYp6uDx/f+bWKlsBXnf/LkA+y+RXWCao0KcEHnZBXNE4IkVDChhfL1B+6N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k2Dh27RVseFLtBDfq856Z3yeBGd0AV9MpdMEoZCZdE=;
 b=HHf29rcjepVDFjeCK6pffuDQ56phpIIZeWqBvZQNHUHdyN63Z5kufa6GncFctFmnsnGaiDqRzXX3CQccG/xfqMJmYaajHMUjq4PPRWw3qa+4NDF02048hS8EqTFAkUa/AZ9AMC13QzbqVdrl85EQJv4Igw5vnP0WHjFoNl6LOH+d5PvRW2T40pfTM/VyCwhdX5/KvQcTK1ktltPNZXe+0TSrabeB9owErYsIL2t1Is5CSPqCN90wWXP1pDCFy+Y2/4OFIMm8vCNoSN0u8d5XtKIk9e+iRwc5fmyY5uaVTQsjJVWAF3/1fyx0o+PLPtrttLaJ4EbHZzNvRi9SR+KyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k2Dh27RVseFLtBDfq856Z3yeBGd0AV9MpdMEoZCZdE=;
 b=c2MsgES6R84eG0UP9FWKLLnVg2ywPTDAOloHpxThoyE1m2egTgkzWaPnrQorcHrcpSTAx9ZHcrnNAU60P4jccsiv6l23JJJ+GLmIgl/JZI11qqUwdyUqQGarlzjCXMCyx1ivDqJ/u80ojzT6X9LHYMf4WjzROrUowRPKFPngK/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 08:15:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 08:15:13 +0000
Message-ID: <eece686d-5b30-4469-9196-6d0bfcde701c@amd.com>
Date: Thu, 25 Sep 2025 10:15:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix for GPU reset being blocked by KIQ I/O.
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com,
 Felix.Kuehling@amd.com, phasta@kernel.org, Qing.Ma@amd.com,
 HaiJun.Chang@amd.com
References: <20250925073347.2010568-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250925073347.2010568-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a25d9e4-44bb-4525-768a-08ddfc0ba6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlGcy8rWUZUVWtQY0lpRHBPd0FFTnVMaWFkUHhWblp5ZXRDQUdmNjNleWRh?=
 =?utf-8?B?dzZRYUZoa1FuV1V2Ky9BYnJmQ0R5RE40U1FJSmxCSmFYWGRISHp4WGpqdElO?=
 =?utf-8?B?djVadWlzT0VXL3RHZGVMWEtpc2xHZmlUYlFhM0Zjb1F6V3ZWdDE4bjI2dE5v?=
 =?utf-8?B?UnhGbzJNdUtUa0V5T3YwaDVGQ05pcnFnWTBIcS9PK0xQN0xISlA1ZEdqajR3?=
 =?utf-8?B?cEd1OFJMTEJwVThMQkM1VHoyN1c1anB2djBrUXYxc2RONWdKbEc5K2V1ZC9w?=
 =?utf-8?B?djhneHRmalFCS1FJczFuVmVGUHdVbnZIaWhKUlprNDVoR2lLd3plaFdqejYv?=
 =?utf-8?B?THRiR3hvb1lJbm1WLzJRWnJ4eEhGb29CakNwSm5UaDNVNEY1WjdsczBST2Rs?=
 =?utf-8?B?Y2toTUkwRERTK2tyeVJPRzlhRXVZcDl2Y1hTbFI4KzN6eUFhN3BoYnNlbzBy?=
 =?utf-8?B?bGxUeU5qd1VrWjJqeGZ1cHVBYmQxUDlLdkpDQnlWUi8wUElUNFo5akdmWHc2?=
 =?utf-8?B?WjZkbW1sOU1sYWE0RkJxdmxkME5XcVd5RXJwckd4SzJIVmY0VTdVNVRjRlBj?=
 =?utf-8?B?TW9XZzVqVmViV3N2VytiMU53c2JzN2UvN210KzhGTVk3YnMzdHpLdUw2TkZC?=
 =?utf-8?B?OVNwb3VUeDY2ZEsxc0RtQ3NEc201ZThWM2hVb3FCT2ZQWUd0VmhRWFh0czdM?=
 =?utf-8?B?dk81ZFB1SmRxdnhvUFgxZzQ2ekJGSlM0UGt6ZDNZT25YN2s3dlp3ajNuay9t?=
 =?utf-8?B?WndRU2FmMzE4Tzl4Nzc4RnFJK2hxTmwzV3lsMCtxbjJIOGVXUWtmU1JkdHQ4?=
 =?utf-8?B?cXJSZHE5VlJpeUc1TWFJY0hwMEhzQ2NkdHU2NEpIVFh2VmVtY3I4TlFTWFZZ?=
 =?utf-8?B?TmpnZ2VJeEphdjJlNGpxTW9oV3VraG1RejgwbEVLZnJSdDltVjhoZW5RWVpP?=
 =?utf-8?B?djVEbkk1Wk5ZZ3BBbEdPUi93S3JGWDU4SWtqWUp3SmI0UFRpdTRTakVRUk5B?=
 =?utf-8?B?YlFZdFAreEJlQU9QQmJmblJHYjJBSmZCVDgyVGpvVW1oT3JVaWw2SC9mSmEy?=
 =?utf-8?B?cHJJNFpGR3dNVDN4V2VLektEV09tOEo5NnE1VlVkdmJFaWt6dFh1TVhqd29B?=
 =?utf-8?B?b0R3bmNWNUI5VE5iMWZJL2psUXFrb3JINXdqQk1qem82VlVacDZCR1lwK0hq?=
 =?utf-8?B?L3ltTnNKbU0zQkRnbzYraER4M3haMkJBbzdoRnduY240NzhYUGU1TFp6Q0VK?=
 =?utf-8?B?UGJERVcrOWVZenVoZGg4SU1KYTZRN2t1VXBNc0JaSXJMSW5aYWh0M2dNWnpG?=
 =?utf-8?B?emtJL052Q0U1ckZhNFhFQjN4ZlVRMDhhdlRUZ282ZEo2NHAzMXVycENxdy9H?=
 =?utf-8?B?QTlGbEtJdm5abjdIdElDekt2aU9aMG9xY0FWVVJ3WGpYNE1FU2JKS1BJeUFG?=
 =?utf-8?B?SGw5RWxDUmF1eitneTVWNkc4TGtaczM5OGZzeW9ndUo0STFkeWJubUZ6TmZO?=
 =?utf-8?B?YUE5NURVUmtvVTZGMGkvejQrM2RPTUFzVFJsYVRvMi9vK0tNaGloNFZzQnBH?=
 =?utf-8?B?OGtHTVBWVnR3cVpmQlJEUC9tYnFGdmtIMWZxU2UzNU4ybnpoUzhFVGpoRkNM?=
 =?utf-8?B?MjFWb0RBdm52QWNSdGtUalFremhlU0MxbVp4TW9adjgrMDd1Y3JCVUQ0a3NW?=
 =?utf-8?B?dWszNUpZZWo5N04wOURJRkF4MzZpWmovaGhQQ2tHU2tYbjYzYXFIbXdBMkRN?=
 =?utf-8?B?YmxkaHN0UXh6ZExYM0oyQjNQbDVzZFJSVjdWRis1Wkxza29GWmNtVWxKSHM2?=
 =?utf-8?B?ZHk4WlJuL2EzM00rNHhNaUNXek1kWm5QMEhUYWVzV1QrUXIzbUlUTUNQL0Za?=
 =?utf-8?B?RlVrVUpIWVNaZ3hlZGk2dXhSQzJpb2pOTjJoZUdERGhMZFJyK3c3c1ZZL0FM?=
 =?utf-8?Q?XgEiglTuqoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zld5YWI3SEN4VEFweUR6SVFkbXFrODdLcWlwclE3TDc2dDdsTkU4TXBMUzBU?=
 =?utf-8?B?c0p4bFFNSExzUjFNL3lON0JaWjU0czI2eEZ4Y0x1Z2xKVytMRjlrMnNhL2ty?=
 =?utf-8?B?cThmd3VSMHpMdzdLWmpzSzhNbkIreStHck93aXVPN2ZPK05tWUFWak13UGVS?=
 =?utf-8?B?Uk51emJ0M21WSmEyNzVTMy9kUnhLSTBrUVVoNzhROGZjWktqTzVBNUUrS3Ix?=
 =?utf-8?B?VlJzUTVuR0JmdGlwWHhKTlN2ZW9jajZKRFB4MWxBQmFTUjBQYXV3bnZ1aGU2?=
 =?utf-8?B?R3ZYcldSZnZ1WlppcllydkF3OTh3SlFodWJJUkhMK1IvdmpaaE9GeHdxTnZq?=
 =?utf-8?B?M0gvVGk5TVVtSDdDYk5ZRDZ2Ym9ydHBsY08yUm1OUzFBYW93cXRKemZKUXJM?=
 =?utf-8?B?RGIyUjdaMlhFQmQwZjJhU1MwbFNybFI0UlE3VDArSExlQU1iQzJEM1dLb0Nu?=
 =?utf-8?B?TFE5a2gyRmpkU2llQ3RYM1hsU1J5M1c5SmhIZm4weGptb1FMWUY1Ri8zUWN5?=
 =?utf-8?B?c1VxWG1iY3pXb3FXSW5Xd1BSZ2swb0R0cjUrUTNZdER1NUxtdk5MdmFBZ2p6?=
 =?utf-8?B?a2E1K1VKZWxCZ01UcTQvdUx2OEFzK3RmVjNJWUY0N0NBZkE2a2VQeStUakJT?=
 =?utf-8?B?cVE3K3R2b2tQQUZBV1g4SGp3bmF1bzJGbi81UUNxMEVCQU9sME1QOFA1akh6?=
 =?utf-8?B?L3V0eTh5VXI5SXdWVkZGb1dIL2NvSVJqVkg3bkhPTkl0NVZTZVZ6VU95VmZN?=
 =?utf-8?B?ZHhRY3JNb0RDOGVWbDdFSldiVWhQUWEzOEZRUURzMXM4RjdNN1Z1RlJPd1FR?=
 =?utf-8?B?L0hlbEkzYUw1OHo3VFlUWFdyN1lBUUh0MXFKZkRxYlFKZTd2c2hxbjZiRkFz?=
 =?utf-8?B?S3RHSUNQVnlCSnZuU3A0WDdRZlBRTWllcW16OE9YSXYzZ2toV0RKWGE2UEpa?=
 =?utf-8?B?THFLYXVRNVZFZHpOaGxvUGxCa2VWcXZGWXRjdk5wamNrTWZsdXh5ZkVRN3hz?=
 =?utf-8?B?QVg5a1BrMXN5MHJEOXZCckVncWlYdVFuQ2Fiem9wR1RrTUI1L0FETk1aOGNW?=
 =?utf-8?B?RU1YTXlPU1BxNUVGazBMeU5MRlBkL21DZ1RyaXQzb3dtZ0NnRmt6UjFoQk4x?=
 =?utf-8?B?azNrcHdVSzFsVUhXcW16S3EvbTlESVVtOTFJblk4SkJsMkR2N0hZR0RabkZC?=
 =?utf-8?B?U3EwNkxmcVFPSDB5RXJSOHIxQldVLzBNRjJlZzN6VjVqR0pORnpXVnovV3lB?=
 =?utf-8?B?dmM0RHFCaHh0aS8rTTBtMW5kZ1RkK0d4a1l4cjUwNXI5K1JHNFFwc2tnazJw?=
 =?utf-8?B?WUNFMFhtb3cwTFlINU9ET29RN2hFQktuWjREVXhwOU55RWRRTDRMSFRGZXFD?=
 =?utf-8?B?M28zLzZpdEpmU2NWT2R3RTNoWm4wWFNBU20wb21PczJWNkFFaWZ3NzI3cUFJ?=
 =?utf-8?B?dkFlaGVKeWMyN1kzM2FScjhsQmNEZHZ5NzVyUndNb0F3TzMzSERmTlR2Nzdw?=
 =?utf-8?B?ZmU2dEdyeXpvM1hpdDd3clQ4WDV4c2FadUs4SngwUE1KTFdDWllKdFRUcEQ4?=
 =?utf-8?B?OG9mcmc4T0hoc2FCL3h2VXNhL0pONHE5WWMrRTJibDdOMnN0ZjBlS2owbWhH?=
 =?utf-8?B?T1laZklDUnViOGhkaDdWbnRxcUdkV2VMSDlJbEt6SVd6TjRMTHR4aEw3ZEFJ?=
 =?utf-8?B?VGpjMXhacit2blJrMWFwZUZMdTJBeFFhaFNsRWFENE5QZzF1VklaTXY4MzRV?=
 =?utf-8?B?aTBEdGtLWnlVM2J3cjlaQ2dXcFFreHVFcTRUakw0MnQzZEk3dTJHUUVMT3ZE?=
 =?utf-8?B?Z1U0VDl6bldpZjhhSmR2YUxPZUM0ZlVDc0JmSTQrTVc1clNJOWFaTnRpa0Zo?=
 =?utf-8?B?ZElMcnBjRGpLL1lFQ0owTWZwcDk1V0M4azFhZlVHZGxqd1BoUzAvWE92d25G?=
 =?utf-8?B?SVRldGFlRXFxbWkwbzVoZlFZbW1vNVhNU0FIUEZhMXRzRmJ6VW1ON0lnM2l1?=
 =?utf-8?B?YWhHUEg4cTg0aUtRd0dnZTZmbGc1UW9TYTJadkRNalJ1WUJ4emRkSDhJRUU3?=
 =?utf-8?B?M2s1RTE0UGdzUmY2K2c5WTAvQXJ4MC8vYkd6NFVGSFBrVGJKT0ZzWHdDYWJk?=
 =?utf-8?Q?FSbQa2y5x9nOkZHoEfrYaV72v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a25d9e4-44bb-4525-768a-08ddfc0ba6d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:15:13.3732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfRIIVAvt8c1x0gKHVQmfPtu64cQOrlZRg4jVEuAOqvsUjmFsOC86Dj/2o3xJig9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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



On 25.09.25 09:33, Heng Zhou wrote:
> There is some probability that reset workqueue is blocked by KIQ I/O for 10+ seconds after gpu hangs.
> So we need to add a in_reset check during each KIQ register poll.
> 
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 89fc1015d3a6..b6a88103adfd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1102,6 +1102,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>  
>  	might_sleep();
>  	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +		if (amdgpu_in_reset(adev)) {
> +			goto failed_kiq_read;
> +		}

Drop the extra {}, apart from that sounds reasonable to me.

Regards,
Christian.

>  		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>  		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>  	}
> @@ -1172,6 +1175,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>  	might_sleep();
>  	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>  
> +		if (amdgpu_in_reset(adev)) {
> +			goto failed_kiq_write;
> +		}
>  		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>  		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>  	}

