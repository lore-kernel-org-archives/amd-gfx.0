Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A656117A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22A656117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1DB89E06;
	Tue,  5 Oct 2021 17:14:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF3589E06
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 17:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOW+hn46+RJgrCOZWoyXSfygt0L9O8090JtnU1KQ9NQpzoL7oE5273oTwJbeVed7z2xjbEZM8mrqfVphyxuFqYve/ZWFo52j4wUrMKd3Q3VA8innuxxMkWnQqLeNJUSu7MbEvGd1xn5+vuGaehQGR+5DvgfaDTRWCiHQ863Qk9xtqTrkqO6/jlPdktdYKhnFrc1xj0MTx24SP9zVOr6UU4LQJMXLkxjsDISouflH/GoLtAp/6VZFmMDOiBL6gWhepqOHhju4+TYIXR/AmpFUsx/zki65/ZCyzY+tvr3+FDbPq9YoyCJhqQvjES1pOmcxoeJM4E8OzrAm+ckJhxYiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6mv6kXnwArRhjCiTZDkqbpHQMVFCL69WC3vJBZJgIw=;
 b=DW1lORjQOlX6GIX26sEaMkc5qAsU0fPVOKkP3KF6cpbEZHJAD+96IOFeeocUJE4/4BkHT3XRfoZcLGethikztvZ0hJ/rM3pI/4E0qwo/y/hh91yggYwIfJq7Ua+3NG8ErXEd8j2CZUNCKAW0yjOdsyM8Iq/q31BTNRGy4ofaho10uZQtKyzZc4+BWg0bf9e6seURx91c+3gZeI+b6uiM5f+cfv6xXf1WT3GYjGZTV196uVS02JoSUdXwjllQLl9FIfVBG5gI/dXphOpAW46IMRs2c4y9/MJoQ4jX+QD6mFsCQlitpyHb7ODef6rovsG4NOrdK8JqwJ1IUxWZbpeeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6mv6kXnwArRhjCiTZDkqbpHQMVFCL69WC3vJBZJgIw=;
 b=p/L+DB4Al3+TMbw7SWhagPgNJ6lYTVCl6qEzOEbEt3W2163rzo5J7F8yjCuMM5J4oynwuw++UtP5RkfwFhCLisUXKkuqLeneRYd7nHVdOYj64PimjmU+K/sregoL3LAoGdsIadi1rT5OP7vn25nk4/BN5qgq6xtzoBzuX8M1EYo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 17:13:57 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 17:13:57 +0000
Message-ID: <7553d620-78ec-8c3e-590b-ace7e44f9b93@amd.com>
Date: Tue, 5 Oct 2021 13:13:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 00/23] USB4 DP tunneling
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0035.namprd15.prod.outlook.com
 (2603:10b6:408:c0::48) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN8PR15CA0035.namprd15.prod.outlook.com (2603:10b6:408:c0::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 17:13:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52af9e3b-2318-4ac8-065d-08d988238423
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5444B0F4E38FF3BF0DC0FE598CAF9@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDztJ//uXJA9HQamFleKC6rZiI8IvzJP6bMBkdPSlUts+MW95YZwIFLeZYPoki0q3wSu2n3pjh++OpUu1H5joFyken9tnR6SHkGd+a3svseqdI2Fk0CmAxKOZemylGbsVQEBXFFkwmtbkpFmtydrRwUuiI9DX+kcFhN4CsLeDKBYV91KGi64hFt1pjfKwZmyCX0feqqJm3Ky0UB51nU5dMpnMWu2wdSgpdmRdER32T7SU2E6xLI8PIP5oMP8gqsmxQrxfKiqN5eqdq7b9iJDCyTxx5nw7d3soCr9iwGnN+aqWVqc4Q8t5/u5vtujG8Ch/cULuSnlpQdMTe195JM8ag2ewDLTiGx4GDp3MLedwU5nnJoURJrXOu2Z1Si2y7KHk9RT2Y18kGqCBOxVhjko+Kymt99Efp+mRluGguclMwo3gshhrM8AsMRNfjPLuw0F6WVfhaAg8CnnzUkfJQIV3OyNpqvUrC5LpNovO/BRFJ1C8/NYR/pQTpVbgR3CIL56pNKOswnKJMLC4hUxM5dGAodFRZGzjne4G+N2topjJONm/QjUqJ/iOTup4kWAIX9ExfejPuh+WpaBFPDkmfOqpDep0+rQVPtBgSn1yL/CNqbKMdz8fFxJDC4xJTwsI7ngSWkxHDsWEQwR19Uo19nVzl65+cLZK7M11WUyiuYs3Jn8i2V+GhwWTRX8sqn0pw5iJWWrV8nF5xYbmbmsIcyNL6MjgmCchC77KB5ZzlTW5vs4N1djfydNcuOlZ18cIC65
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66574015)(38100700002)(956004)(16576012)(508600001)(8676002)(31686004)(86362001)(26005)(5660300002)(2616005)(83380400001)(6666004)(8936002)(316002)(44832011)(2906002)(6486002)(66946007)(186003)(66476007)(4326008)(53546011)(36756003)(66556008)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJRWk43c2tPRXdUNnd3ZWNMNTlYMXpJY1E3Ykg0ckYrWTJxM2NWbkZhSzVs?=
 =?utf-8?B?STBHSk5iOThtRzJUb2NrMTIyYW9KNkcrN1F5UGdEZFlpQVk2aGhwOHNJaUh0?=
 =?utf-8?B?bXVzVEZRNnQvWkk0T2R4R2JFSG9VS0ovemMvdS9zbWN1cXc4K0ZNTnphbXFy?=
 =?utf-8?B?bGtReXRya21VdUk2TGNJSkQreTQ5b0h4Y1diYm9LL3pvU0d5L3RIZ0JhZGht?=
 =?utf-8?B?UGlpQ08weUtwUy95RmV6SFhieTB0c2c2N3E4YnlKUWNrMDlOTm8ray8zdi9V?=
 =?utf-8?B?ZUJoc1BVb1pZV09xWGFyeUxVZCs0UnF2c213RjVOdThNL2dua005ZlhEVDlG?=
 =?utf-8?B?MnRRN0FQQk05azBUVDNvd09hcVM5d1liaGk3eEJGSnE3OE54NFlRSFdqd3pI?=
 =?utf-8?B?bDJETlE5ZExxempteDNrT25TTWFaTU9rT3BzK3UyZlVKNTFycytmdmhUU0NX?=
 =?utf-8?B?Yzh5MFhNVVFia1lyS09qYlp0OUM5MWgxUWJUWjUrbUNaY2JVQVppNzQvaWdW?=
 =?utf-8?B?MSt3Q1hEdUlTS2VYbS9lY3phUFNTWjluWURQM0g5S3RGR0NNNXVseWlEb1Rq?=
 =?utf-8?B?MDdESjJrSjVVSndZNTd6SWppR2VIdmdwdUp6a3FRUHFvNTIrY0J5dGdJWUNt?=
 =?utf-8?B?OTNmaURyK3hwdnlXa1J6NGN3TVlwK1FmME00STFoQ3JvalVER2lnZlVTc0oz?=
 =?utf-8?B?b3ovWW1hRHhCR09PYXhad1hVQTgyUFFpamsxSEZxMit3c2ZMaitZNW1rampI?=
 =?utf-8?B?dTFKQVovUWJMbzJhdjdmWEdxQTNFZy9xT2NPU0VhNzVsUzZualN4a1gyZ2s4?=
 =?utf-8?B?UnlaZ2R3NVBOdUlCMmlVaURkWFpNallIUys4SlFHVkIxbUkzN2dWVWVhZ3FM?=
 =?utf-8?B?ZnQvYlNDYXV1OEFvSkZucXh0QjgrOU04eW9QQVNGWjFCeTV2ZDZQZXR4REZh?=
 =?utf-8?B?TDFMc09jQUZYMnh2dGd6d2dyUDk5SHpZRzl2TnBEeTRML3dQd3pac1d3SFF6?=
 =?utf-8?B?M1lBWGtrQWxZa2U3K1hvSmFyTG94Rm5PWDVpVHhMalJiYnNUckJZOUdsc1cz?=
 =?utf-8?B?aTBsZThZOVNVb2FucDJmLy9TeXh6SEtHQ3NtdHR4M2RDVlFSaWlkbGFLOWNm?=
 =?utf-8?B?QlpCK3lmNTJhWTRkcitvTk03Yzk1OHRLODlqQ3BYRjRVTE1tSFNkaFoxQVA3?=
 =?utf-8?B?T1A1SUY4S2VhcktGY2pIY0wvMWZFYzM4VVRNSGMzbkpTbWNRelhGdHBsY2xo?=
 =?utf-8?B?enJwODVxWlFXUHV6TUhVRE82WEYySjMvYWE3RU9ZaVh5L1JjUDg4T0lwMjZp?=
 =?utf-8?B?bVhLUDF0a0k3Wjk0Z3d2d0xJa3JHcU8rbENuRmJZdkIydks3eTVlZ2IvZXFX?=
 =?utf-8?B?L1hqMk90Z1NLQTFGL0U5R1FJTC9OdDJFV0gvK2dodTZFOENoa1FSREtYR2pS?=
 =?utf-8?B?WHZLaGpQOEY1RTNlcC8zMWNzNWNPQmNmTDVtdFpnVCtSd29BcEIxV2FMZ0g3?=
 =?utf-8?B?UEdSYm9MYkd6YVZaUmlPSXIvTFplVmtoREpNb0ZFK1oya2sxYzBvK0YyRFJB?=
 =?utf-8?B?M2U2Q01mWTRsU2xKcVlSOTVEWGovZGNhVTNvbDVBRHFac1FzR3VRYmozZ1VP?=
 =?utf-8?B?MXQ2bGROT3lxZXZZRTFhSHdZSkNjcXZoMStzaUR1ZGlMUkRKYSt0azFFYXlB?=
 =?utf-8?B?QUx2dDg5dFUrWjJ3d2Q1YzNmMmVXaERoeEhzQ1pZNk55Q25KUmhlajJSeXJB?=
 =?utf-8?Q?v37pgdWXPzn2IKMXR2hR2hI9iPpx5E8MFYvDhVg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af9e3b-2318-4ac8-065d-08d988238423
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:13:57.5042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHzI62VDm8Ac1BACOLre+Aj7LSfNz8K6WPzTBfDWj9R7JUZTB4EPHt+TUNeO+926Ve6Ej/KKnjQD+Xink3abLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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

On 2021-10-05 03:51, Wayne Lin wrote:
> USB4 runs over USB-C and can tunnels USB3, PCIe and DP protocols.
> 
> A USB4 router is responsible for mapping Tunneled Protocol traffic
> to USB4 packets and routes packets through the USB4 Fabric.
> For this patchset, we have native DisplayPort able to be tunneled
> over USB4 Fabric.
> 
> E.g.
> DP source -> DPIA (DP In Adapter) -> USB4 host router -> USB4 port ->
> USB4 device router -> DPOA (DP Out Adapter) -> DPTX -> DP sink
> 
> Briefly, there is a CM (Connection Manager) in USB subsystem which 
> handles relevant USB4 channel configuratons. Our DMCUB is responsible
> for interacting with CM to control DPIA to enable Video Path & AUX 
> Path. Once DPIA gets into Paired state, DP source is then having a
> constructed end-to-end path to interact with DP sink as the
> conventional way.
> 
> From DP Source perspective, the USB4 Fabric and the Adapters are 
> either totally transparent or act as an LTTPR. Besides, due to
> constraints of USB4 protocols, AUX transactions under USB4 now is
> handled by DMCUB to meet USB4 protocol requirement.
> 
> Changes since v1:
> * Give the description of rough working flow of USB4 DP tunneling
> 

Thanks for the overview.

Is DP-over-USB4, or our implementation of it, specific to AMD HW?

Would it make sense to deal with DP-over-USB4 core functionality in
DRM core in a way that's common to all implementers?

Have you run checkpatch.pl on all patches?

Patches 2-3, 9-18, 20-23 and
Patches 1, 4-8 with the suggested title/description updates and
Patch 19 with the DCN guard dropped (or confirmation that it's needed) are
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> 
> Jimmy Kizito (14):
>   drm/amd/display: Update link encoder object creation.
>   drm/amd/display: Support USB4 dynamic link encoder selection.
>   drm/amd/display: Support USB4 for display endpoint control path.
>   drm/amd/display: Support DP tunneling when DPRX detection
>   drm/amd/display: Update training parameters for DPIA links
>   drm/amd/display: Support USB4 when DP link training.
>   drm/amd/display: Implement DPIA training loop
>   drm/amd/display: Implement DPIA link configuration
>   drm/amd/display: Implement DPIA clock recovery phase
>   drm/amd/display: Implement DPIA equalisation phase
>   drm/amd/display: Implement end of training for hop in DPIA display
>     path
>   drm/amd/display: Read USB4 DP tunneling data from DPCD.
>   drm/amd/display: Fix DIG_HPD_SELECT for USB4 display endpoints.
>   drm/amd/display: Add debug flags for USB4 DP link training.
> 
> Jude Shih (4):
>   drm/amd/display: Support for SET_CONFIG processing with DMUB
>   drm/amd/display: Deadlock/HPD Status/Crash Bug Fix
>   drm/amd/display: Fix USB4 Aux via DMUB terminate unexpectedly
>   drm/amd/display: USB4 bring up set correct address
> 
> Meenakshikumar Somasundaram (5):
>   drm/amd/display: USB4 DPIA enumeration and AUX Tunneling
>   drm/amd/display: Support for DMUB HPD and HPD RX interrupt handling
>   drm/amd/display: Support for SET_CONFIG processing with DMUB
>   drm/amd/display: Add dpia debug options
>   drm/amd/display: Fix for access for ddc pin and aux engine.
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 106 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  17 +-
>  drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 179 +++-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  81 +-
>  .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   9 +-
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  36 +-
>  .../drm/amd/display/dc/core/dc_link_dpia.c    | 945 ++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/core/dc_stat.c |   8 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |  22 +
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  31 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +
>  .../display/dc/dcn31/dcn31_dio_link_encoder.c | 126 ++-
>  .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   6 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |   7 +
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   5 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
>  .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   1 +
>  .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  98 ++
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>  drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
>  drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 113 ++-
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
>  .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  16 +
>  .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
>  28 files changed, 1793 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> 

