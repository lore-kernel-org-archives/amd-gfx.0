Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E1C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 19:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C543910EECA;
	Wed, 22 May 2024 19:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wyBm8qqN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85E610EECA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 19:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4Ug6GCCXjOwxHkwXvR5+YqXx+aJ9HVQeJQAT6D7i+492EnMbuWnqSIwus9tQYPuZ5A4F/g/ajhkn3Gjk9eOhPUzPmrqkbtR/mmXuSwsEzExR6QlVv20nnAx178gRdEWBw3l7mnhY/aOjNiSG1qtGeKUK92RVcjTeeKkn5QKAEcRpt6UnwSGXVgBmU14NYd+YRiIjxrasI6lt8gz4SF0jBQkCPAXdLLYFRNd5mnPv/zoTUz+p3eYfImVFF7VKANzQIUhjcUEQSHA4tuk8SNAXMVie9FLNx+Ta6Fuf64F+8arvV+I3BdEEk/USklQYhG1nF8sbDHwpqeyXNrITqOIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRxWAzitbm2jTrkLpGz60EBvXcSSdVV2y/yKV/2MUNg=;
 b=ZO5lpwJx0OWZkMwwfD+tTwv0pB+Re/U+Oy3P8TtjKTHwXtmkkL3vo3gHLJ+FvBjtr43jzT8XKzS8OKYI1P9Pu5t2da4lh7AFXop46i+MpxNoL66n+mB9ULOl/5jXogHbHZ5C/mZU5H5V9yXtey/nft4j5qzV+A4NlbzrI9VyVolUULRPKGoNjrW54yQMtGCj2R4TrDBh/xx4rQZ197BgHtEuV17SBT8p7bzf1RX7oZcQ9kGmJBDBr/vaLNFVuanYX4quCtSZnaxxSHSKcFyXT09mWEVNftRkgGYy6RnMiu0ys+OpvPQBHvoqBytHr2xfi5iqSerE65hUZaqx5GcOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRxWAzitbm2jTrkLpGz60EBvXcSSdVV2y/yKV/2MUNg=;
 b=wyBm8qqNYt/bbB41Y8EryFN2z6VJ5BQXL/E6PDUBHQCMBu/ciS9XnwHgCTor4pjdlsKN4O6c04ZkI7eJoV+4tbgPuUuCI20le60+GPsLtKpgYqseqTiG5disM3/YNqzsHf0tIs/SeRxXI9kS2Q3pfJiWZGaeXq5wGCT1YkfWJvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 22 May
 2024 19:44:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%6]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 19:44:15 +0000
Message-ID: <9485a45a-1049-4a09-afbb-7acca8c0ba59@amd.com>
Date: Wed, 22 May 2024 15:44:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Pass errors from amdgpu_dm_init() up
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240519130223.6802-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240519130223.6802-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: f77fe13b-946d-4482-b5ac-08dc7a978fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGtpM1g4ZytwV09KTmIrUVZ2aDB1bjZETEsyYWViTDI2czVzc0tQTmVuV3Zs?=
 =?utf-8?B?K3JGTHk1Zmp2TnIyL2dSMEdRMFZUTzRxS0NyQ3BmNkZYZXhoWUh1Z2I2ZGho?=
 =?utf-8?B?M2JjRjdGNG90WUVBTjRZdklwQVdSR1JzdjRwNEk4VFlESDlyY3cxdjB0Q1NC?=
 =?utf-8?B?amFWM2xmbytjQUxFa3Y5ZS90SWl0UGJNK3JNNTBtZVdUdXFMZmRaT1FRSlNS?=
 =?utf-8?B?RnczZlFhN21uRGdsMElIcytrTnF5MDExOVIrZURJZHJmeDJwZnpmay93NHkz?=
 =?utf-8?B?MG0yLzNaZk1yYnl6VlNBVXAyMEJidXJncnZ1eU1KSWFhQnpGa3RaNkhIc2l6?=
 =?utf-8?B?NWNQUXNhY2tQMUFtVmlHWTlUSWY3TGZDK3FoWWJCdDdBdlR2VHNYM3lmcmNZ?=
 =?utf-8?B?N1BBNGZVUXl4ZUFpdWw0V2tLalU1RDZXb0FuOXd5VVB0T2NCVEZzMFdNL2FX?=
 =?utf-8?B?VjM0QnM4YmUyTzBmdGwrbHBBdVg3WlFqejZXakZnaHk4aVNnR2xRSHlISlpP?=
 =?utf-8?B?anpxaGRRRTRZZ1FzazF5MUJDSTBOWDVGNWdJb3VVNExVRldHUW5CeUQwUVht?=
 =?utf-8?B?QnJEQStUcTBGMTBWWkNWTW1uOHJmdUw4blNka0tEVXJGL0xJK3AyTG9RdEs2?=
 =?utf-8?B?UFd2WXhiZ3VBMWxOeVYxT3lVSDA0bHhCNlJOK3AyMmVsRStMTzVNcGJ6aTdK?=
 =?utf-8?B?dTFvdXpKakFYVHlodjQ5V3QzV3dhWjRUUi9SYm1MUzFOLzV6VXNDN2VDZEVp?=
 =?utf-8?B?cVlCSStsRHFieHBsbjJNZmFOMEM1OXpVRFVTWnkrbW9tU1Y0ZS94UmFwc2U4?=
 =?utf-8?B?MjBkUmJvTy9aSW1KMXJZbHJtL2dKdldVSFpNYWRYZ3g1eGpYcG5vTThwQWQ5?=
 =?utf-8?B?c0h6ZlZ1N2ZLSnBrMGJ4cWdiWnMrckhoVVh6M1NKSkJ5S3BTTjZWUTZzNXE4?=
 =?utf-8?B?VEtabUYyQmxTc05KYktzeTYrekJzeEp3ajFuT1llS2xrL2ZSQmRiOFE5M0lR?=
 =?utf-8?B?Misxd1FucGt2SFY0Zmw4dUVTYWhhR1dXRFJXWHFmS0tmVWltQVdUR1IvVVFN?=
 =?utf-8?B?NWltMjd0TFhCdGtOYi9pQ3M1R2JaRFAzdzJCL0pwR1RhYUtSNzRnVk5jTjFq?=
 =?utf-8?B?NDU0MjYrbHczLzR1K3lza3MrMXJNVk03c0ZRcDFKK0d0aWo5NXBSUHhJQjcw?=
 =?utf-8?B?SU9pYWpDci9qVndFOC8yVHRUZlFyaW1ZZENBS3dTNVZOOUFHM1d1ZmViVTk3?=
 =?utf-8?B?QVF1TUw5OSsrVzIzc3BVdUNCQ0d2VldYMnlYVGFnKzkvcE42aGdqcTkwclRY?=
 =?utf-8?B?cDc1KzV1SFkzZUZUakRGZ1QzcUpyaGxvWXFTYVZhaStHREZMM1U3WlBQWVNZ?=
 =?utf-8?B?NDR6TllnTS9hUkNxcVVCaVlvYkIvallVemhMNVVsSklLU0l5Y0RhU2hjU0Rt?=
 =?utf-8?B?WUVwQ01YUzZXVUxiV0xtMFI2UzYwUDh5WTczYjg2Q0RsK0JqTEw2SUUvUlJp?=
 =?utf-8?B?blpSN1J4TkswbUZqZzMzMFdEelRyMHNVREdGM1lqaUR3QTZDb1FLWm44aERa?=
 =?utf-8?B?ZE5VaTFtcGJ0aHY1SHYvZXNhU2djODVwdmRNK1kyYkZYZmRnQWFCWkl3aHl2?=
 =?utf-8?B?MWJ0Zi9IQUFxbDRNdzMxVDM4ck1wNmREQXRHWW05Y2ZobG5uNmxUSDkzeTFI?=
 =?utf-8?B?TzZBUXpBZXgzbm5PNzl6d3ZWSnE2K1lqOW9INWhqdkNxZkl1N2kxUE9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjVhQ0NIbHFoMjhHQTBQcTJ3cHUwWFI3WUVlTmVSSGk2bktBNEYzekNUVmtJ?=
 =?utf-8?B?ckUvVWxHTEp3Nmk5Y0JKM2NxTmtOTVh6RDRraHNmV2JkOGhWREZtVjdzRldv?=
 =?utf-8?B?eSsvTXJ0Vm0zRWtXNmRyeTdEc0d1WWpLYVFpcTF4L0ZIbGp5bXlCWjJPNkNO?=
 =?utf-8?B?VDFrRUNPR05MUEV2V0ZUUW9jaUEyYnZwUHBjelI5MjdWT2s4S3B1a2xHcTVY?=
 =?utf-8?B?ZUpJZHV2QnBJd1NjekYxaCtyQXhqckpERXkvN1lDN1piVjhGMk5qR25SblRr?=
 =?utf-8?B?ZjBUbE9BdDAwQVZXZ3N6eWxGT0R0ODhzbjBKNWJ6aDZEOVlPc2J6c1NURkpH?=
 =?utf-8?B?dmwzMnFxZzI0S2NHMEtVdjV3NG1xMnQvV2NhaUhMdHA3Z2FuZDlweEpTN2Rl?=
 =?utf-8?B?TnZSUVB2UVVlTDU5QWtjaUFkUFJ1Wmx6bGdPQ1puOCtlZ01GQURiTGo2VUta?=
 =?utf-8?B?WUUwaEE4amZVMW0rL1VHYzdlYk92a3NuV0gxSWZPMnNiM2gxVThGd2JKODh6?=
 =?utf-8?B?aUowckYvbHNyaEN2MFR5Y1IxMjZTUWNrc2NKamRoM0wzUE1jOFRreVNGd01V?=
 =?utf-8?B?aTRQd3RmVzdPZ056QWEyUzlSR2xJYWdiWXQwODc2alBLUlVZTCtacEtGTk9X?=
 =?utf-8?B?VHMxQURWVnJqeFZYaHRtQUJlQkhjaW5jcWN1QmtmVURQam8vMldNRGhNMHh2?=
 =?utf-8?B?RDRnSG9MN05KYldEcE5sOEZSSVd1d0dnNUZpdWd5L0xxTDY1LzFXUnJQZ2Y4?=
 =?utf-8?B?WWtsR0hudmFXOUZ6QnRtdGFhOXRUSGM0V0p0Q0lLZUpBQzEyZE1SSkZublZl?=
 =?utf-8?B?RXU5SkpxQ2ZWR3dab2NucTF6dmtHR21aWThtblZEMVdIaWU1YmhGbk1wNi93?=
 =?utf-8?B?M3JDNVFhanRhMXRzbERQVFU0cWMwNC8yYWlMcEhreHJIK2QyS0hlT2dWUmFY?=
 =?utf-8?B?aU1qUFdrVjJ2anN0L2QzdUx0VlB0N2UyRWNuUmhldlBlTVFXZFNodS9mdG1P?=
 =?utf-8?B?b3dEMHYvTGJ5SzZtRE1TLzU2ZkYrZERBVTh2d2s1NDhyL0Z6M0Q2eVBMVlpF?=
 =?utf-8?B?OGtiKzdadDN5Mml5NjBuNS9PR2RGdmNkNVZiK0ltcUE4c3lPN0Z0QnJwOW5V?=
 =?utf-8?B?ajJ0cVF6Yzcwa1lxWjFsUGM2ejZqSEk5d1I3ZVJQYWNVUWwvOEl5ZWIvTUln?=
 =?utf-8?B?T1N6WHg1SDRwYnhFSnFHalVOalVxZklSSVVod2Y1R2VOOGZDQjgrL0dTSWNw?=
 =?utf-8?B?WlVDVjlaVHgvREoxK20rY2FoSG5iVEdzT1hKUXRzZzd4bmNnRm9PNkovUUg1?=
 =?utf-8?B?VUdNZEM1aVZlUlAyOWszSTFvMmN6QWJXZnhMZGZiVkJPRW9qcm4vMTg4MVVt?=
 =?utf-8?B?c296WjNMOTVCZFNTMkxoZWZpSnN3RDRBUXZja1BQQ0xsWUpzL1k3QTMweDJK?=
 =?utf-8?B?TmZYa2Y1WnIxZUJmb2czcXlhZmp2ZWxHckdLZ1NpL2NtdHB3OTBiaGN4MERR?=
 =?utf-8?B?OVFlYzVERjdNV2VnL05oNUFDQ05ET1JpSDY0Z3k3emFGbjVKYXhUKytNclhm?=
 =?utf-8?B?ZmMvSHorUzJENWVScGJLVXNWOTBzbDI4UUxVcDA3QXpoano1U1dMeE83QWNq?=
 =?utf-8?B?TkQ4T2RqYnZpQmNUVmNvOUxCQzBUd1NVY29majcyRUtLSld0cHV4Q0pLM3kx?=
 =?utf-8?B?Q2NLV0ZuZ0VNeUtMNFY4aUxGTlpCOTBicUlvcG1HSnM1RkU4SjVjTjgzZkhF?=
 =?utf-8?B?cGY5UlZIbzdxcjVLSHJ4bkdQMHdSY0xVTFRBL21hNzVZME1yOG81RFQ3bkIr?=
 =?utf-8?B?R3NFbjllWWwyUzI0a0g0S3Y5Vm5qVUxYbTNGN3htUWNiSUI2dHZ6VFJyNDFM?=
 =?utf-8?B?NjYyY2VGNEJITHJiRnZLYVdBaFppd0ZxOUhxa0FVdzdSdjJoT1ZVR3ZlS1Vk?=
 =?utf-8?B?ckNiZ1Y4OHZtWjFxekkzZjF0ZDNOZ1dOZCtJS2ZwT0JkY2pZaWM4NFRGRXhl?=
 =?utf-8?B?THJnRUhMOWdrSTRWU0dlNWJSamRQNE44ODBIQXpMRDZwK3JGSG0zdXArQmVS?=
 =?utf-8?B?UEdOUlkzVDh4OURnemdLWDFJVWpxQWhIcDU2QVFxU2t5OTFUNS9ERHBoMmIx?=
 =?utf-8?Q?MuUxiyK4FUap2B92bGMTjZ18w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77fe13b-946d-4482-b5ac-08dc7a978fd3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:44:15.4244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gPDwDtxbfQ2lBQcsz4CBhdzyDPVfD2Q2My84AF+PdIlO/VQAqVqa4HdF1boZSDIif2qE84Z9QXy/NZODRIfRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

On 2024-05-19 09:02, Mario Limonciello wrote:
> Errors in amdgpu_dm_init() are silently ignored and dm_hw_init()
> will succeed. However often these are fatal errors and it would
> be better to pass them up.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d6e71aa808d8..01b0a331e4a6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2556,8 +2556,12 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
>  static int dm_hw_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int r;
> +
>  	/* Create DAL display manager */
> -	amdgpu_dm_init(adev);
> +	r = amdgpu_dm_init(adev);
> +	if (r)
> +		return r;
>  	amdgpu_dm_hpd_init(adev);
>  
>  	return 0;

