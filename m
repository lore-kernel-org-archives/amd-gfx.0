Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FDBCFA45C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 18:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B3510E188;
	Wed, 23 Oct 2024 18:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4EFWXRq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7593410E188
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 18:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR3xwM0+MC4nN+YH5AZbJ7pO0ewozfjaduFYnTYVQID29uIa8O2MNP/QMRI0Kz1WchSi61aA++kr1vOko9u7F8NkGqFs0zWVAoohM0I5wmWHL+8Npb9EYbb8M6h3rbaauNnLoeCQ6WiPfIeR2aaK4950l6RVEbk567MWnH4DPBYybRL77AFdsA6S+aIJPgbpidcG6lJztmu6ghp8aGCRRgN6pqpDr4R9RZs4Ky7ux1/WE0+fgBenyPlMlAH00zF8NVTFzt0P2aXbPjhP6E0NurLk6UBGBBnK+0xPF+qXZ7ITsM42Z9StpsGHWwEpuTJlTMxYTlATqxR81b+wZivOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7niTRLGTgmapjGESNWezYx1kInYnug7GvUqI6gtP2kc=;
 b=F7a9NShmFd+AghfOT+cWya9DKzNgIVNLWGliPgL4bSXx1QGnq15+jZU8ep+XOma/vl0I6qKi1Wt64BMKYT4wfEFx/yICaVA/ZWIIlpU8rujW3Pwdi5gLSE0ULNLyodYbW9dgkh4uHK2hcFZ8SHeIeEdwbIaB+1armaTz+fNt3Bp+KNkeJaa3U/kFKvnxjAq9YAkN9+TsUkg1isWrOq2Y+NmTaMQC+X2PoHrQiRcq5uuW24jAHdQS0IQS2IRD9orictY8rlEFNFG+CuQskxw4uQsTbd8me6/YbXX8WzVfpIkOVZRaB1j1hGLgIME3ix43VacX9Nxl2GR+zeHG9elekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7niTRLGTgmapjGESNWezYx1kInYnug7GvUqI6gtP2kc=;
 b=N4EFWXRqVQ9f7AZVSb0Gq/mn69q9dzsMuge0CxzYxaXZ51OwSsiyK4lQ8G+RLqfK+LFRjpaariLt8HV/7oZQUvxWG3rFBozjpwu6k2YaoZSpX1ICgk3giIeDQFcQD/LZKkNIE3Whp37KxfANkYY92I+z0hJatDJoVhd9647MYRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 18:12:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 18:12:35 +0000
Message-ID: <060fa1b7-f1c4-46f3-a09a-b2cf801e27c2@amd.com>
Date: Wed, 23 Oct 2024 14:12:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation/gpu/amdgpu: Add programming model for
 DCN
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20241017034244.223993-1-Rodrigo.Siqueira@amd.com>
 <20241017034244.223993-3-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241017034244.223993-3-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaf6dfe-7426-4cfc-fec8-08dcf38e4522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUJOOVdrSzJmUVhWanpLMC9lUFJjaGhURThzWWpNT0R4Y2YrUFVzSG85bzl3?=
 =?utf-8?B?WlNoUlRuVVJaYXBrUWR4Tmo2VFY5RkZwV0dVYXZlL25YdXFqQTZWRzc5RUox?=
 =?utf-8?B?d1QzemdzRzl1MDFzZXNRMFdjclQ5bEhid251ZlZIMERzc00vckRYblpBQ0pD?=
 =?utf-8?B?eURYZ3BZb3dYTnE5NDBMTlo3SmNDSnNnYW1ieWtqekpVbWg0bm9oeVBNem16?=
 =?utf-8?B?T1JEQlFRcmRyY0t2K29JUGRoTFB0VE9DR0UzSHhLMGpaU3o4SXFiV2NZSFNa?=
 =?utf-8?B?MzdreFJiZkNyNTA3bUx1MUxnU1Y2VW4wS0JYS0FKTHNPbXlVWXVFWlQ2dUJ4?=
 =?utf-8?B?ckZRVkhNT3VxeW9aZTFMS0ZLUzFaeEpNWjVZaEpSN0tvZlM1YndvVnVPbzJM?=
 =?utf-8?B?WDZMRHdncFNBVHhwNzBLQVRWWjlaRms3Wm9oaENHeUdqZHhpNnVnUlhiVndn?=
 =?utf-8?B?MG0zU0lTQU9jUVQrOHJwUzM4U2Y5Y2lydjVLd240VlFNcUdHb3JxUTk3cG80?=
 =?utf-8?B?WnpCdEt0dk54cy9BblBnZGJ0c3VLbG9HQTMrS3gzNzRFQ053RHhlZnBnUDM1?=
 =?utf-8?B?RlZIdllWTEJ2bk0vRklSSkpFcXhMd2pnaGJzL1V4TXA3NUh6MjBLVldmUS9M?=
 =?utf-8?B?MlY5Mk9KWlBlREFqT3ZDMGcyM2poYUFtMEtIc1Y3V3ZjL1FFWFQ3alpMMCt1?=
 =?utf-8?B?emlJdFloQmJCOW5NSTltcDFoY0tTN1E2WHJmL2tEVWxlelpYSTdLWm8rcldT?=
 =?utf-8?B?c0tzWFYrZWx2QzExeG9ndHBreVBlZ2d1aFRCSmVRcGxpekIxM1ZSOG9pYTZB?=
 =?utf-8?B?NnBkOEw4cmRnNGhLczZLR2NRQXR6YTI5Y01zdVM1bHZDaUREaExvTDQvVnl2?=
 =?utf-8?B?bUFHT1BkUjloVlFUMzFhOEN5czh3K2N6RHZmM1p0aUt5cXhZb1VzZStaNEpq?=
 =?utf-8?B?WWN6NnFDbDZNaFlrNStHU2NRS1FnaDJnZWJUK0RyUC9ISVloK0VoOG14OGhl?=
 =?utf-8?B?NFBnV2k4UTRubmkrUmtsM3dWNTdvZUdCTmFzL0xpMGRQUG9aSnV6bzA2MXRj?=
 =?utf-8?B?S3RYWTZIUi9rMEhSMm9Sc040MjBUVzlITzNyZjRJYTJMSVZQYWVJOVpid1pr?=
 =?utf-8?B?c2IxUkVENDZ4a1FEL1IwNGU1VmdYamREM3d3YkJGcnZ2Z05vcmtUUHF4SU4w?=
 =?utf-8?B?aHJ0TnB6TWFrQUFqd1FSeGowb2JKcHlPbHJtRG9OdklJb2ZLcWNiOS9ZR3Na?=
 =?utf-8?B?T0FSR2loMEMwYnF0LzhXKzVzOUhVSVltWnFiQzV3MmVleDN2WWhjcjNEcHhR?=
 =?utf-8?B?S0NGQ1I3aEdTdzZKeUVNdDhNN1VVMDRxVWtJaHBIdUFuaExRWFBlbWZ6bUVU?=
 =?utf-8?B?RlJ4SWc4WUZ4QUVFNlYrMmZ3WURZdDdEMVMwalFrMmxDblIwcXQvbkNDMXFO?=
 =?utf-8?B?YWJWOGdnOGx5S2MvMnJIbThOUm0xbG9MNmN2YmlkSUwvODJ3UWJTY1Nnc3NH?=
 =?utf-8?B?a0E1VlEyZVNnSFV6R2ROSlgxRjdKZmRjWHg4VlBKMGp4M1RRQVB3THl5SEpV?=
 =?utf-8?B?QkZMc3NHQStXb1EzdmcrSjA1QWRwU3ZNK3YyRG1CZ21TY2l3ZDFKUTNtL0Y5?=
 =?utf-8?B?NnJia2FBR3F4MmV2Q2JyeWNpdWNDcFMrM0k1NlBGMnNYeVNRVVAyOFNIVEVv?=
 =?utf-8?B?c2NBWmI1VHhpRmZhYU54ZW1BbStYMmVJN05xUUx6dGMreTRkUEszWjBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZNSjB2ZXl4VUl4ZkFVNmFtNFpGODFxYTdEQll6b1phazlWdlppNjRWbUVh?=
 =?utf-8?B?bDBaZU9rUmNPQjh5ay9pRlFqOXcrK0RpR0NHcUExRHVydXZqVkRTR0NOYkY1?=
 =?utf-8?B?YVEzdmtQVTh5b0E2RWZEenJKTTJFNnZDTkRsUndjeERadzR1QmVrQVdCSVpD?=
 =?utf-8?B?V2Rwclp0RVVZcHhpZWtiTTlXOUdDMU0yaVFqZVVjWWVJbVZmaTl0UG54NG5O?=
 =?utf-8?B?MXpBdGQ5amhlSTA3VmxYVkVXTEFnM21hbnhaUCtPZmowVzBXQlNNUElFUldh?=
 =?utf-8?B?Yndlam5zaHNwSS9vRVc4cjZJWWRJb0x4RFlRUFVVbUJUcEFtcDVHU0tMZ0Rt?=
 =?utf-8?B?ZzVMNnAvRmV4eWtvVWMyOUJoWkQvaUpmc1lnVFN0L05UR3E2a2lqeUlRb081?=
 =?utf-8?B?aWlVZWlHZHdqM2Z0WHVxdW4wMGdXK0cyZytFTGRDK08rRUhRZnJlSVZiRGl6?=
 =?utf-8?B?NXhLTEprNk5hamY2QU5lMkFkUEVqWGk5MVZLaExkYXUyb1d0eG1ReEZaSEhj?=
 =?utf-8?B?U21Gb1pFdndKaHJMZXkyNSs1UTc5cUc4RUMxbXBkQnE0Qi9nbGVhTlR6NDVj?=
 =?utf-8?B?bUhCS0dkaklPQTB4WmFGLzhnMU5XU2ZoTlg3ZnZwZlhNaUVOcFVoQm9rTnA2?=
 =?utf-8?B?RHlHUlpENjg4UktzM3g2WW1BQjU3WHVJQngrbmR1NkV5VzdnYkw5YXhnY1V1?=
 =?utf-8?B?QjNrQ0ZwbGR6dUFTZVhyV0I1OExKRThGb0QxR252M25hMGhJeEpLaVNuSXg5?=
 =?utf-8?B?NmQvODRKRkpIUVVTalA0NStqdGUvTDNnbzROakQ1bkxYb3BSck0zeldGQjRq?=
 =?utf-8?B?KzdZN0xJZ0JYMkk2L0lNV1h4Z3U1di9ZMUFJa0NPZm91cTJUc3BKWU43cjZj?=
 =?utf-8?B?NW80TTdMbzVsUjlKR1NmVG56YmlkdXFOVTltZ29LRmVzeHhkOTZTOVpQRHRN?=
 =?utf-8?B?ZTJKaVN1ZnY4bFl4QUwxclNpK0VxYkV1VEVEcHdiRXgwSitja3RKMFdvbGVv?=
 =?utf-8?B?TDlyYkdJdXY4Y1RWeUlPUkIxUzIwM2k0b1JCN3gyMjlPanp2SXgwT3lacVZD?=
 =?utf-8?B?NVAwWTFJamZJSDJFTFZYQUpEaFFDSTk1d0xSaThiUEZSamNNN25mUUxjdWkr?=
 =?utf-8?B?ZTdpU0lQSXdLTUpJRFlpR1pGbU5nZytGK2MyVThkQm1yemVFT050bnhmdnVO?=
 =?utf-8?B?UjNGUTdLRXUzalIxN3VsaUhHc1lyNWUrN3Z6SDJUSkRkWE8yQThxRXZ2RFkx?=
 =?utf-8?B?WmZRbEJ2RDJHaVZGTUI3WU5qWXI0S29SZzRqSmJaQ0hIOU1ZdHBMN1hQRHNM?=
 =?utf-8?B?V3hmZTUweWRNUm0yRlhlaTZLMkF5dm5HTFpSTWlVSUFmLzBrMmYvdzR2bmp4?=
 =?utf-8?B?VnltZUV0KzlXNngyWncxUUFORGFsUVQyaFR6TnNGdlFLUzlmTHdFT2hmQmRo?=
 =?utf-8?B?NXlnTlhDMWw3eEhSWHRxL1VCcnhHM1pIclN2M2xaU3lxbVRtYVRxYkhpSVFi?=
 =?utf-8?B?anQyOXh3MVhuZlFzT3hUTCtNSUhscDYyYVhnM3VkMHR0ZTJrVUhkcFRDNldx?=
 =?utf-8?B?azZzYVBBbDBpbTlUR2IyV1dNaTQ2eDl0S2FwaEkvQWF4SVFkSlRGc3lkVlZ6?=
 =?utf-8?B?d3BRalB6WU1lWGpYbkl0emJuK2NuQmR2VEhrcS80WWRncS85U1pLWUp0Y1Nz?=
 =?utf-8?B?OEdJN2d0WndOcDRzdzdsS2lWUzFkVzlJMXJkRWp0Ti90czhWYVg0WHpPR2J3?=
 =?utf-8?B?eUgySjl5Mm0vS3Zabk1ZcDV0dnFpZ2lDeFFtZUNGbGd1d1hFTldBMnFxdHZq?=
 =?utf-8?B?cVl3WFBDQ1BMdVMyZmZoWSt4TmRzR3JFWi9MV0xRc2JGZjRmSytibmxVRHVj?=
 =?utf-8?B?ZEQvYU0yTzRWUG43ZmIwRGhFVlBVZmFWenBxR2pXZDRjTDMvdXUvWlhjMitH?=
 =?utf-8?B?Y043VzdMb1E4Q21OWThPRVF0MzMvMmorcjZpM2l6ZmdvKzdNOTZMSkVYaHpL?=
 =?utf-8?B?ekVabGg5bG9OVlBUVGx5OTNpQnRwWmx2OWV1Y3RMTVY0ZXZiR3dzYS9remwx?=
 =?utf-8?B?SlZ5QkFQaG9WYTltT0h5cDBxVmhzWXllbDk4cEhtT3VuakFYbHBSUkdOcnU4?=
 =?utf-8?Q?441j9yxxsTQQ68mziWVfXpMVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf6dfe-7426-4cfc-fec8-08dcf38e4522
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:12:35.3238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojl6uyveMgPn1GSUJnC3HTleIAmKSLP4rIsCjepWd+xh/61JPIEhmAUVyK7fhnwC25TIL0vsw9O5B7dtRubbZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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



On 2024-10-16 23:34, Rodrigo Siqueira wrote:
> One of the challenges to contributing to the display code is the
> complexity of the DC component. This commit adds a documentation page
> that discusses the programming model used by DCN and an overview of how
> the display code is organized.
>=20
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/amdgpu/display/dc-arch-overview.svg   | 731 +++++++++++++++++
>  .../gpu/amdgpu/display/dc-components.svg      | 732 ++++++++++++++++++
>  .../gpu/amdgpu/display/dcn-blocks.rst         |   2 +
>  .../gpu/amdgpu/display/dcn-overview.rst       |   2 +
>  Documentation/gpu/amdgpu/display/index.rst    |   1 +
>  .../amdgpu/display/programming-model-dcn.rst  | 162 ++++
>  6 files changed, 1630 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/display/dc-arch-overview.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/dc-components.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/programming-model-dc=
n.rst
>=20
> diff --git a/Documentation/gpu/amdgpu/display/dc-arch-overview.svg b/Docu=
mentation/gpu/amdgpu/display/dc-arch-overview.svg
> new file mode 100644
> index 000000000000..23394931cf26
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/display/dc-arch-overview.svg
> @@ -0,0 +1,731 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"1204.058"
> +   height=3D"510.57321"
> +   viewBox=3D"0 0 318.57366 135.08917"
> +   version=3D"1.1"
> +   id=3D"svg8"
> +   inkscape:version=3D"1.2.2 (b0a8486541, 2022-12-01)"
> +   sodipodi:docname=3D"dc-arch-overview.svg"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns=3D"http://www.w3.org/2000/svg"
> +   xmlns:svg=3D"http://www.w3.org/2000/svg"
> +   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> +   xmlns:cc=3D"http://creativecommons.org/ns#"
> +   xmlns:dc=3D"http://purl.org/dc/elements/1.1/">
> +  <defs
> +     id=3D"defs2">
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"marker8858"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8616"
> +         style=3D"fill:#aa00d4;fill-opacity:1;fill-rule:evenodd;stroke:#=
aa00d4;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Send"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Send"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8622"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"matrix(-0.3,0,0,-0.3,0.69,0)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow1Lend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow1Lend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8592"
> +         d=3D"M 0,0 5,-5 -12.5,0 5,5 Z"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:1pt;stroke-opacity:1"
> +         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Lend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Lend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8610"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"matrix(-1.1,0,0,-1.1,-1.1,0)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path1200"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-1"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-9"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-7"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-8"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-4"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-5"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-0"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-3"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-6"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-1"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-6"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-1"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-0-7"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-3-4"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-6-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-1-0"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-8"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-6"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path1200-6"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"marker8858-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8616-5"
> +         style=3D"fill:#00ffcc;fill-opacity:1;fill-rule:evenodd;stroke:#=
00ffcc;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-56"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-0-2"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-3-9"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +  </defs>
> +  <sodipodi:namedview
> +     id=3D"base"
> +     pagecolor=3D"#ffffff"
> +     bordercolor=3D"#666666"
> +     borderopacity=3D"1.0"
> +     inkscape:pageopacity=3D"0.0"
> +     inkscape:pageshadow=3D"2"
> +     inkscape:zoom=3D"1.4"
> +     inkscape:cx=3D"812.5"
> +     inkscape:cy=3D"315"
> +     inkscape:document-units=3D"mm"
> +     inkscape:current-layer=3D"layer1"
> +     showgrid=3D"false"
> +     inkscape:window-width=3D"3840"
> +     inkscape:window-height=3D"2083"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     showguides=3D"false"
> +     fit-margin-top=3D"0"
> +     fit-margin-left=3D"0"
> +     fit-margin-right=3D"0"
> +     fit-margin-bottom=3D"0"
> +     units=3D"px"
> +     inkscape:snap-global=3D"false"
> +     inkscape:showpageshadow=3D"2"
> +     inkscape:pagecheckerboard=3D"0"
> +     inkscape:deskcolor=3D"#d1d1d1" />
> +  <metadata
> +     id=3D"metadata5">
> +    <rdf:RDF>
> +      <cc:Work
> +         rdf:about=3D"">
> +        <dc:format>image/svg+xml</dc:format>
> +        <dc:type
> +           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
> +      </cc:Work>
> +    </rdf:RDF>
> +  </metadata>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(399.57097,11.171866)">
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.54816px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +       x=3D"-297.75696"
> +       y=3D"109.44505"
> +       id=3D"text1063" />
> +    <path
> +       style=3D"fill:#008000;stroke:#008000;stroke-width:0.463298;stroke=
-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:0.=
463298, 0.926596;stroke-dashoffset:0;stroke-opacity:1"
> +       d=3D"m -120.41395,84.001461 h -9.04766"
> +       id=3D"path1171-0-7"
> +       inkscape:connector-curvature=3D"0" />
> +    <path
> +       style=3D"fill:none;stroke:#ff0000;stroke-width:0.982225;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:0.982=
225, 1.96445;stroke-dashoffset:0;stroke-opacity:1"
> +       d=3D"m -129.96274,90.649221 h 8.66407"
> +       id=3D"path1171-7-1-3-8"
> +       inkscape:connector-curvature=3D"0" />
> +    <path
> +       style=3D"fill:none;stroke:#3771c8;stroke-width:0.745037;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;=
stroke-dashoffset:0;stroke-opacity:1"
> +       d=3D"m -121.33167,97.283841 h -7.91265"
> +       id=3D"path7149-3-7-8"
> +       inkscape:connector-curvature=3D"0" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.54816px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +       x=3D"-115.55721"
> +       y=3D"85.330681"
> +       id=3D"text12079"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan12077"
> +         x=3D"-115.55721"
> +         y=3D"85.330681"
> +         style=3D"font-size:4.80199px;stroke-width:0.163704">Board/Platf=
orm</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.54816px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +       x=3D"-115.75885"
> +       y=3D"92.435066"
> +       id=3D"text12079-3"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan12077-1"
> +         x=3D"-115.75885"
> +         y=3D"92.435066"
> +         style=3D"font-size:4.80199px;stroke-width:0.163704">SoC</tspan>=
</text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.54816px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +       x=3D"-115.6041"
> +       y=3D"98.608604"
> +       id=3D"text12079-3-4"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan12077-1-9"
> +         x=3D"-115.6041"
> +         y=3D"98.608604"
> +         style=3D"font-size:4.80199px;stroke-width:0.163704">Component</=
tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-368.54205"
> +       y=3D"92.633011"
> +       id=3D"text1010-5"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-368.54205"
> +         y=3D"92.633011"
> +         style=3D"font-size:6.35px;text-align:center;text-anchor:middle;=
stroke-width:0.264583"
> +         id=3D"tspan1057">DRAM</tspan></text>
> +    <g
> +       id=3D"g730"
> +       transform=3D"translate(6.9386906,-2.5203356)">
> +      <text
> +         id=3D"text838-5-2-6-2"
> +         y=3D"32.372173"
> +         x=3D"-372.97867"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.54814=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +         xml:space=3D"preserve"><tspan
> +           id=3D"tspan936-1-2-3"
> +           style=3D"text-align:center;text-anchor:middle;stroke-width:0.=
163704"
> +           y=3D"32.372173"
> +           x=3D"-372.97867"
> +           sodipodi:role=3D"line">dc_plane</tspan></text>
> +      <rect
> +         ry=3D"6.9139691e-07"
> +         y=3D"18.717371"
> +         x=3D"-390.50565"
> +         height=3D"23.904575"
> +         width=3D"35.080177"
> +         id=3D"rect834-5-2-6-75"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.561714;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +    </g>
> +    <g
> +       id=3D"g738"
> +       transform=3D"translate(6.9386906,31.346346)">
> +      <text
> +         id=3D"text734"
> +         y=3D"32.372173"
> +         x=3D"-372.97867"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.54814=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +         xml:space=3D"preserve"><tspan
> +           id=3D"tspan732"
> +           style=3D"text-align:center;text-anchor:middle;stroke-width:0.=
163704"
> +           y=3D"32.372173"
> +           x=3D"-372.97867"
> +           sodipodi:role=3D"line">dc_plane</tspan></text>
> +      <rect
> +         ry=3D"6.9139691e-07"
> +         y=3D"18.717371"
> +         x=3D"-390.50565"
> +         height=3D"23.904575"
> +         width=3D"35.080177"
> +         id=3D"rect736"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.561714;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +    </g>
> +    <rect
> +       ry=3D"2.1256196e-06"
> +       y=3D"8.5983658"
> +       x=3D"-389.18051"
> +       height=3D"73.491852"
> +       width=3D"46.307304"
> +       id=3D"rect744"
> +       style=3D"fill:none;stroke:#3771c8;stroke-width:1.13159;stroke-lin=
ecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none"=
 />
> +    <g
> +       id=3D"g757"
> +       transform=3D"translate(-19.949528,-8.6078171)">
> +      <text
> +         id=3D"text600"
> +         y=3D"56.289795"
> +         x=3D"-256.91336"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.54814=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +         xml:space=3D"preserve"><tspan
> +           id=3D"tspan598"
> +           style=3D"text-align:center;text-anchor:middle;stroke-width:0.=
163704"
> +           y=3D"56.289795"
> +           x=3D"-256.91336"
> +           sodipodi:role=3D"line">DC</tspan></text>
> +      <rect
> +         ry=3D"1.7458606e-06"
> +         y=3D"23.771139"
> +         x=3D"-289.21854"
> +         height=3D"60.361938"
> +         width=3D"65.042557"
> +         id=3D"rect602"
> +         style=3D"fill:none;stroke:#000000;stroke-width:1.21541;stroke-l=
inecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:non=
e" />
> +    </g>
> +    <rect
> +       ry=3D"2.3633565e-06"
> +       y=3D"4.4885707"
> +       x=3D"-316.43292"
> +       height=3D"81.711441"
> +       width=3D"79.57225"
> +       id=3D"rect787"
> +       style=3D"fill:none;stroke:#3771c8;stroke-width:1.5641;stroke-line=
cap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none" =
/>
> +    <g
> +       id=3D"g765"
> +       transform=3D"translate(6.5577393,-7.020317)">
> +      <text
> +         id=3D"text608"
> +         y=3D"31.942825"
> +         x=3D"-189.71797"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.54814=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +         xml:space=3D"preserve"><tspan
> +           id=3D"tspan606"
> +           style=3D"text-align:center;text-anchor:middle;stroke-width:0.=
163704"
> +           y=3D"31.942825"
> +           x=3D"-189.71797"
> +           sodipodi:role=3D"line">dc_link</tspan></text>
> +      <rect
> +         ry=3D"6.8036792e-07"
> +         y=3D"18.197111"
> +         x=3D"-211.99069"
> +         height=3D"23.523254"
> +         width=3D"44.846642"
> +         id=3D"rect610"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.630025;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +    </g>
> +    <rect
> +       ry=3D"1.0582555e-06"
> +       y=3D"4.3160448"
> +       x=3D"-210.69141"
> +       height=3D"36.588463"
> +       width=3D"55.543594"
> +       id=3D"rect794"
> +       style=3D"fill:none;stroke:#3771c8;stroke-width:0.874443;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <g
> +       id=3D"g781"
> +       transform=3D"translate(6.5577393,37.542802)">
> +      <text
> +         id=3D"text777"
> +         y=3D"31.942825"
> +         x=3D"-189.71797"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.54814=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +         xml:space=3D"preserve"><tspan
> +           id=3D"tspan775"
> +           style=3D"text-align:center;text-anchor:middle;stroke-width:0.=
163704"
> +           y=3D"31.942825"
> +           x=3D"-189.71797"
> +           sodipodi:role=3D"line">dc_link</tspan></text>
> +      <rect
> +         ry=3D"6.8036792e-07"
> +         y=3D"18.197111"
> +         x=3D"-211.99069"
> +         height=3D"23.523254"
> +         width=3D"44.846642"
> +         id=3D"rect779"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.630025;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +    </g>
> +    <rect
> +       ry=3D"1.0582555e-06"
> +       y=3D"50.466679"
> +       x=3D"-210.69141"
> +       height=3D"36.588463"
> +       width=3D"55.543594"
> +       id=3D"rect796"
> +       style=3D"fill:none;stroke:#3771c8;stroke-width:0.874443;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <g
> +       id=3D"g2151"
> +       transform=3D"translate(2.1659807,-25.895798)">
> +      <rect
> +         ry=3D"9.2671934e-07"
> +         y=3D"29.395185"
> +         x=3D"-132.25786"
> +         height=3D"32.040688"
> +         width=3D"44.742229"
> +         id=3D"rect618"
> +         style=3D"fill:none;stroke:#3771c8;stroke-width:0.734435;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +      <g
> +         id=3D"g838"
> +         transform=3D"translate(1.9073486e-6,0.26687336)">
> +        <text
> +           id=3D"text616"
> +           y=3D"47.132744"
> +           x=3D"-110.03735"
> +           style=3D"font-style:normal;font-weight:normal;font-size:6.548=
14px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163704"
> +           xml:space=3D"preserve"><tspan
> +             id=3D"tspan614"
> +             style=3D"text-align:center;text-anchor:middle;stroke-width:=
0.163704"
> +             y=3D"47.132744"
> +             x=3D"-110.03735"
> +             sodipodi:role=3D"line">dc_link</tspan></text>
> +        <rect
> +           ry=3D"5.7260945e-07"
> +           y=3D"35.249866"
> +           x=3D"-126.21788"
> +           height=3D"19.797579"
> +           width=3D"32.66227"
> +           id=3D"rect833"
> +           style=3D"fill:none;stroke:#000000;stroke-width:0.493257;strok=
e-linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:=
none" />
> +      </g>
> +    </g>
> +    <rect
> +       ry=3D"3.6076738e-06"
> +       y=3D"-9.4559708"
> +       x=3D"-397.85507"
> +       height=3D"124.73286"
> +       width=3D"250.94243"
> +       id=3D"rect1307"
> +       style=3D"fill:none;stroke:#008000;stroke-width:3.43179;stroke-lin=
ecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6.8635=
8, 3.43179;stroke-dashoffset:0" />
> +    <rect
> +       ry=3D"2.9172609e-06"
> +       y=3D"-4.5401988"
> +       x=3D"-393.52301"
> +       height=3D"100.8623"
> +       width=3D"174.14117"
> +       id=3D"rect1990"
> +       style=3D"fill:none;stroke:#ff0000;stroke-width:2.57074;stroke-lin=
ecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:2.570=
74, 5.14148;stroke-dashoffset:0" />
> +    <path
> +       style=3D"fill:none;stroke:#aa00d4;stroke-width:2;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1"
> +       d=3D"m -317.69814,47.452094 h -23.80954"
> +       id=3D"path2142" />
> +    <path
> +       style=3D"fill:none;stroke:#aa00d4;stroke-width:2;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1"
> +       d=3D"m -130.71642,19.101665 h -23.80954"
> +       id=3D"path2144" />
> +    <g
> +       aria-label=3D"}"
> +       transform=3D"rotate(180,-59.876965,-0.22738225)"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#aa00d4;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       id=3D"text1003-5">
> +      <path
> +         d=3D"m 92.00239,-21.748413 h 0.86816 c 0,0 15.81267,-0.177767 1=
6.15994,-0.5333 0.35553,-0.355534 1.10026,-1.124479 1.10026,-2.306836 v -20=
.048953 c 0,-1.289844 0.18603,-2.228288 0.5581,-2.815332 0.37207,-0.587044 =
0.45004,-0.992187 1.36781,-1.215429 -0.91777,-0.206706 -0.99574,-0.603581 -=
1.36781,-1.190625 -0.37207,-0.587045 -0.5581,-1.529623 -0.5581,-2.827735 v =
-19.913761 c 0,-1.174088 -0.74473,-1.938899 -1.10026,-2.294433 -0.34727,-0.=
363802 -15.00239,-0.545703 -16.15994,-0.545703 h -0.86816 v -1.773536 h 0.7=
8134 c 2.05879,0 17.33403,0.305924 18.02029,0.917774 0.69453,0.60358 1.0418=
,1.81901 1.0418,3.646289 v 19.814542 c 0,1.231966 0.22324,2.087728 0.66973,=
2.567285 0.44648,0.471289 1.25677,0.706934 2.43086,0.706934 h 0.76894 v 1.7=
73535 h -0.76894 c -1.17409,0 -1.98438,0.239778 -2.43086,0.719336 -0.44649,=
0.479557 -0.66973,1.343587 -0.66973,2.59209 v 19.937331 c 0,1.827279 -0.347=
27,3.046842 -1.0418,3.658691 -0.68626,0.611849 -15.9615,0.917774 -18.02029,=
0.917774 h -0.78134 z"
> +         style=3D"font-size:25.4px;fill:#aa00d4;stroke-width:0.264583"
> +         id=3D"path1005-3"
> +         inkscape:connector-curvature=3D"0"
> +         sodipodi:nodetypes=3D"cccsscccsscsccscsscsccscsscscc" />
> +    </g>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-275.85803"
> +       y=3D"92.633011"
> +       id=3D"text2157"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-275.85803"
> +         y=3D"92.633011"
> +         style=3D"font-size:6.35px;text-align:center;text-anchor:middle;=
stroke-width:0.264583"
> +         id=3D"tspan2155">DCN</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-279.29822"
> +       y=3D"110.19857"
> +       id=3D"text3141"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-279.29822"
> +         y=3D"110.19857"
> +         style=3D"font-weight:bold;font-size:6.35px;text-align:center;te=
xt-anchor:middle;stroke-width:0.264583"
> +         id=3D"tspan3139">SoC</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-275.85803"
> +       y=3D"123.8538"
> +       id=3D"text3375"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-275.85803"
> +         y=3D"123.8538"
> +         style=3D"font-size:6.35px;text-align:center;text-anchor:middle;=
stroke-width:0.264583"
> +         id=3D"tspan3373">Board/Platform</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-107.57491"
> +       y=3D"42.939579"
> +       id=3D"text3379"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-107.57491"
> +         y=3D"42.939579"
> +         style=3D"font-size:6.35px;text-align:center;text-anchor:middle;=
stroke-width:0.264583"
> +         id=3D"tspan3377">Display</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-182.71582"
> +       y=3D"46.643749"
> +       id=3D"text3383"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-182.71582"
> +         y=3D"46.643749"
> +         style=3D"font-size:6.35px;text-align:center;text-anchor:middle;=
stroke-width:0.264583"
> +         id=3D"tspan3381">Connector</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.175px;l=
ine-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;=
fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +       x=3D"-182.71582"
> +       y=3D"93.210457"
> +       id=3D"text3387"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-182.71582"
> +         y=3D"93.210457"
> +         style=3D"font-size:6.35px;text-align:center;text-anchor:middle;=
stroke-width:0.264583"
> +         id=3D"tspan3385">Connector</tspan></text>
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/display/dc-components.svg b/Documen=
tation/gpu/amdgpu/display/dc-components.svg
> new file mode 100644
> index 000000000000..f84bb2a57c05
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/display/dc-components.svg
> @@ -0,0 +1,732 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"533.42053"
> +   height=3D"631.18573"
> +   viewBox=3D"0 0 141.13418 167.00122"
> +   version=3D"1.1"
> +   id=3D"svg8"
> +   inkscape:version=3D"1.2.2 (b0a8486541, 2022-12-01)"
> +   sodipodi:docname=3D"dc-components.svg"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns=3D"http://www.w3.org/2000/svg"
> +   xmlns:svg=3D"http://www.w3.org/2000/svg"
> +   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> +   xmlns:cc=3D"http://creativecommons.org/ns#"
> +   xmlns:dc=3D"http://purl.org/dc/elements/1.1/">
> +  <defs
> +     id=3D"defs2">
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"marker8858"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8616"
> +         style=3D"fill:#aa00d4;fill-opacity:1;fill-rule:evenodd;stroke:#=
aa00d4;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Send"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Send"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8622"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"matrix(-0.3,0,0,-0.3,0.69,0)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow1Lend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow1Lend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8592"
> +         d=3D"M 0,0 5,-5 -12.5,0 5,5 Z"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:1pt;stroke-opacity:1"
> +         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Lend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Lend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8610"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"matrix(-1.1,0,0,-1.1,-1.1,0)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path1200"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-1"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-9"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-7"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-8"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-4"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-5"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-0"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-3"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-6"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-1"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-6"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-1"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-0-7"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-3-4"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-6-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-1-0"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-2-8"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-9-6"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path1200-6"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"marker8858-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path8616-5"
> +         style=3D"fill:#00ffcc;fill-opacity:1;fill-rule:evenodd;stroke:#=
00ffcc;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)"
> +         inkscape:connector-curvature=3D"0" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-3-3"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-6-56"
> +         style=3D"fill:#ff0000;fill-opacity:1;fill-rule:evenodd;stroke:#=
ff0000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-8-0-2"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         inkscape:connector-curvature=3D"0"
> +         id=3D"path1200-9-3-9"
> +         style=3D"fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke:#=
008000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +  </defs>
> +  <sodipodi:namedview
> +     id=3D"base"
> +     pagecolor=3D"#ffffff"
> +     bordercolor=3D"#666666"
> +     borderopacity=3D"1.0"
> +     inkscape:pageopacity=3D"0.0"
> +     inkscape:pageshadow=3D"2"
> +     inkscape:zoom=3D"1.4"
> +     inkscape:cx=3D"482.85714"
> +     inkscape:cy=3D"470"
> +     inkscape:document-units=3D"mm"
> +     inkscape:current-layer=3D"layer1"
> +     showgrid=3D"false"
> +     inkscape:window-width=3D"3840"
> +     inkscape:window-height=3D"2083"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     showguides=3D"false"
> +     fit-margin-top=3D"0"
> +     fit-margin-left=3D"0"
> +     fit-margin-right=3D"0"
> +     fit-margin-bottom=3D"0"
> +     units=3D"px"
> +     inkscape:snap-global=3D"false"
> +     inkscape:showpageshadow=3D"2"
> +     inkscape:pagecheckerboard=3D"0"
> +     inkscape:deskcolor=3D"#d1d1d1" />
> +  <metadata
> +     id=3D"metadata5">
> +    <rdf:RDF>
> +      <cc:Work
> +         rdf:about=3D"">
> +        <dc:format>image/svg+xml</dc:format>
> +        <dc:type
> +           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
> +      </cc:Work>
> +    </rdf:RDF>
> +  </metadata>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(384.1992,26.608359)">
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.0511px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.101278"
> +       x=3D"-330.72058"
> +       y=3D"57.56284"
> +       id=3D"text1063" />
> +    <rect
> +       ry=3D"4.7572436e-07"
> +       y=3D"-26.142614"
> +       x=3D"-383.73346"
> +       height=3D"16.447845"
> +       width=3D"140.2027"
> +       id=3D"rect744"
> +       style=3D"fill:none;stroke:#3771c8;stroke-width:0.93149;stroke-lin=
ecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none"=
 />
> +    <rect
> +       ry=3D"1.0800992e-06"
> +       y=3D"-5.1415901"
> +       x=3D"-383.27942"
> +       height=3D"37.343693"
> +       width=3D"40.239418"
> +       id=3D"rect602"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.751929;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:10.476px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-363.2121"
> +       y=3D"17.270189"
> +       id=3D"text3379"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-363.2121"
> +         y=3D"17.270189"
> +         style=3D"font-size:10.476px;text-align:center;text-anchor:middl=
e;stroke-width:0.163688"
> +         id=3D"tspan3377">Core</tspan></text>
> +    <rect
> +       ry=3D"1.0800992e-06"
> +       y=3D"-5.1415901"
> +       x=3D"-331.06259"
> +       height=3D"37.343693"
> +       width=3D"40.239418"
> +       id=3D"rect526"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.751929;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.4701343e-07"
> +       y=3D"-5.2654457"
> +       x=3D"-286.88507"
> +       height=3D"15.455184"
> +       width=3D"43.167706"
> +       id=3D"rect528"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.501024;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.4701343e-07"
> +       y=3D"15.68337"
> +       x=3D"-286.88507"
> +       height=3D"15.455184"
> +       width=3D"43.167706"
> +       id=3D"rect530"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.501024;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.4701343e-07"
> +       y=3D"36.959518"
> +       x=3D"-286.88507"
> +       height=3D"15.455184"
> +       width=3D"43.167706"
> +       id=3D"rect532"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.501024;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"1.6213723e-06"
> +       y=3D"60.089264"
> +       x=3D"-286.65378"
> +       height=3D"56.057846"
> +       width=3D"42.705132"
> +       id=3D"rect534"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.949072;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.4031123e-07"
> +       y=3D"37.077362"
> +       x=3D"-382.96875"
> +       height=3D"15.223459"
> +       width=3D"92.225845"
> +       id=3D"rect536"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.726817;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.4031123e-07"
> +       y=3D"59.989784"
> +       x=3D"-382.96875"
> +       height=3D"15.223459"
> +       width=3D"92.225845"
> +       id=3D"rect538"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.726817;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.4031123e-07"
> +       y=3D"80.283493"
> +       x=3D"-382.96875"
> +       height=3D"15.223459"
> +       width=3D"92.225845"
> +       id=3D"rect540"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.726817;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <rect
> +       ry=3D"4.3543034e-07"
> +       y=3D"124.89404"
> +       x=3D"-382.88803"
> +       height=3D"15.054706"
> +       width=3D"139.2859"
> +       id=3D"rect554"
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.888245;stroke-li=
necap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:none=
" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:8.73001px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-311.29712"
> +       y=3D"-16.144287"
> +       id=3D"text660"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-311.29712"
> +         y=3D"-16.144287"
> +         style=3D"font-size:8.73001px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan658">Display Core API (dc/dc.h)</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:10.476px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-311.40384"
> +       y=3D"17.511137"
> +       id=3D"text664"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-311.40384"
> +         y=3D"17.511137"
> +         style=3D"font-size:10.476px;text-align:center;text-anchor:middl=
e;stroke-width:0.163688"
> +         id=3D"tspan662">Link</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-336.97806"
> +       y=3D"43.095863"
> +       id=3D"text668"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-336.97806"
> +         y=3D"43.095863"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan666">Hardware Sequencer API</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-336.97806"
> +         y=3D"48.552124"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan670">(dc/inc/hw_sequence.h)</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-337.03479"
> +       y=3D"68.73642"
> +       id=3D"text750"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-337.03479"
> +         y=3D"68.73642"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan748">Hardware Sequencer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-336.98022"
> +       y=3D"89.209091"
> +       id=3D"text756"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-336.98022"
> +         y=3D"89.209091"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan754">Block Level API (dc/inc/hw)</tspan></text>
> +    <g
> +       id=3D"g1543"
> +       transform=3D"matrix(0.61866289,0,0,0.61866289,-146.50941,-10.1467=
55)">
> +      <rect
> +         ry=3D"7.3007396e-07"
> +         y=3D"180.25436"
> +         x=3D"-382.5336"
> +         height=3D"25.241808"
> +         width=3D"29.376135"
> +         id=3D"rect542"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.528201;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.05556=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +         x=3D"-367.99722"
> +         y=3D"195.3941"
> +         id=3D"text838"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-367.99722"
> +           y=3D"195.3941"
> +           style=3D"font-size:7.05556px;text-align:center;text-anchor:mi=
ddle;stroke-width:0.264583"
> +           id=3D"tspan836">DCHUB</tspan></text>
> +    </g>
> +    <a
> +       id=3D"a1538"
> +       transform=3D"matrix(0.61866289,0,0,0.61866289,-154.037,-10.146755=
)">
> +      <rect
> +         ry=3D"7.3027257e-07"
> +         y=3D"180.25093"
> +         x=3D"-339.82092"
> +         height=3D"25.248676"
> +         width=3D"28.609333"
> +         id=3D"rect546"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.521332;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.05556=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +         x=3D"-325.67853"
> +         y=3D"195.35883"
> +         id=3D"text842"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-325.67853"
> +           y=3D"195.35883"
> +           style=3D"font-size:7.05556px;text-align:center;text-anchor:mi=
ddle;stroke-width:0.264583"
> +           id=3D"tspan840">HUBP</tspan></text>
> +    </a>
> +    <g
> +       id=3D"g1533"
> +       transform=3D"matrix(0.61866289,0,0,0.61866289,-154.69251,-10.1467=
55)">
> +      <rect
> +         ry=3D"7.3027257e-07"
> +         y=3D"180.25093"
> +         x=3D"-308.59961"
> +         height=3D"25.248676"
> +         width=3D"28.609333"
> +         id=3D"rect844"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.521332;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.05556=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +         x=3D"-294.45721"
> +         y=3D"195.3941"
> +         id=3D"text848"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-294.45721"
> +           y=3D"195.3941"
> +           style=3D"font-size:7.05556px;text-align:center;text-anchor:mi=
ddle;stroke-width:0.264583"
> +           id=3D"tspan846">DPP</tspan></text>
> +    </g>
> +    <g
> +       id=3D"g1528"
> +       transform=3D"matrix(0.61866289,0,0,0.61866289,-155.67539,-10.1467=
55)">
> +      <rect
> +         ry=3D"7.3027257e-07"
> +         y=3D"180.25093"
> +         x=3D"-276.84912"
> +         height=3D"25.248676"
> +         width=3D"28.609333"
> +         id=3D"rect850"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.521332;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.05556=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +         x=3D"-262.77728"
> +         y=3D"195.3941"
> +         id=3D"text854"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-262.77728"
> +           y=3D"195.3941"
> +           style=3D"font-size:7.05556px;text-align:center;text-anchor:mi=
ddle;stroke-width:0.264583"
> +           id=3D"tspan852">MPC</tspan></text>
> +    </g>
> +    <g
> +       id=3D"g1523"
> +       transform=3D"matrix(0.61866289,0,0,0.61866289,-157.64019,-10.1467=
55)">
> +      <rect
> +         ry=3D"7.3027257e-07"
> +         y=3D"180.25093"
> +         x=3D"-243.51147"
> +         height=3D"25.248676"
> +         width=3D"28.609333"
> +         id=3D"rect856"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.521332;stroke-=
linecap:round;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-dasharray:no=
ne" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.05556=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583"
> +         x=3D"-229.2068"
> +         y=3D"193.25275"
> +         id=3D"text860"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-229.2068"
> +           y=3D"193.25275"
> +           style=3D"font-size:7.05556px;text-align:center;text-anchor:mi=
ddle;stroke-width:0.264583"
> +           id=3D"tspan858">...</tspan></text>
> +    </g>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-313.35858"
> +       y=3D"133.55629"
> +       id=3D"text951"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-313.35858"
> +         y=3D"133.55629"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan949">Hardware Registers</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-265.39505"
> +       y=3D"86.926537"
> +       id=3D"text1044"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.39505"
> +         y=3D"86.926537"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1042">DMUB</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.39505"
> +         y=3D"92.382797"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1046">Block</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-265.42343"
> +       y=3D"43.272846"
> +       id=3D"text1052"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.42343"
> +         y=3D"43.272846"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1048">DMUB Hardware API</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.42343"
> +         y=3D"48.729107"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1050">(dmub/dmub_srv.h)</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-265.40161"
> +       y=3D"24.997644"
> +       id=3D"text1058"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.40161"
> +         y=3D"24.997644"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1056">DMUB Service</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.36501px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.163688"
> +       x=3D"-265.30121"
> +       y=3D"0.99768418"
> +       id=3D"text1064"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.30121"
> +         y=3D"0.99768418"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1062">DMUB Service API</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-265.30121"
> +         y=3D"6.4539466"
> +         style=3D"font-size:4.36501px;text-align:center;text-anchor:midd=
le;stroke-width:0.163688"
> +         id=3D"tspan1066">(dc/dc_dmub_srv.h)</tspan></text>
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentat=
ion/gpu/amdgpu/display/dcn-blocks.rst
> index 5e34366f6dbe..756957128dad 100644
> --- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
> +++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
> @@ -1,3 +1,5 @@
> +.. _dcn_blocks:
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  DCN Blocks
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/gpu/amdgpu/display/dcn-overview.rst b/Document=
ation/gpu/amdgpu/display/dcn-overview.rst
> index 9fea6500448b..eb54a6802e04 100644
> --- a/Documentation/gpu/amdgpu/display/dcn-overview.rst
> +++ b/Documentation/gpu/amdgpu/display/dcn-overview.rst
> @@ -1,3 +1,5 @@
> +.. _dcn_overview:
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Display Core Next (DCN)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/g=
pu/amdgpu/display/index.rst
> index f0c342e00a39..bd2d797c123e 100644
> --- a/Documentation/gpu/amdgpu/display/index.rst
> +++ b/Documentation/gpu/amdgpu/display/index.rst
> @@ -90,6 +90,7 @@ table of content:
>     display-manager.rst
>     dcn-overview.rst
>     dcn-blocks.rst
> +   programming-model-dcn.rst
>     mpo-overview.rst
>     dc-debug.rst
>     display-contributing.rst
> diff --git a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst b=
/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> new file mode 100644
> index 000000000000..c1b48d49fb0b
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> @@ -0,0 +1,162 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DC Programming Model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In the :ref:`Display Core Next (DCN) <dcn_overview>` and :ref:`DCN Block
> +<dcn_blocks>` pages, you learned about the hardware components and how t=
hey
> +interact with each other. On this page, the focus is shifted to the disp=
lay
> +code architecture. Hence, it is reasonable to remind the reader that the=
 code
> +in DC is shared with other OSes; for this reason, DC provides a set of
> +abstractions and operations to connect different APIs with the hardware
> +configuration. See DC as a service available for a Display Manager (amdg=
pu_dm)
> +to access and configure DCN/DCE hardware (DCE is also part of DC, but fo=
r
> +simplicity's sake, this documentation only examines DCN).
> +
> +.. note::
> +   For this page, we will use the term GPU to refers to dGPU and APU.
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +From the display hardware perspective, it is plausible to expect that if=
 a
> +problem is well-defined, it will probably be implemented at the hardware=
 level.
> +On the other hand, when there are multiple ways of achieving something w=
ithout
> +a very well-defined scope, the solution is usually implemented as a poli=
cy at
> +the DC level. In other words, some policies are defined in the DC core
> +(resource management, power optimization, image quality, etc.), and the =
others
> +implemented in hardware are enabled via DC configuration.
> +
> +In terms of hardware management, DCN has multiple instances of the same =
block
> +(e.g., HUBP, DPP, MPC, etc), and during the driver execution, it might b=
e
> +necessary to use some of these instances. The core has policies in place=
 for
> +handling those instances. Regarding resource management, the DC objectiv=
e is
> +quite simple: minimize the hardware shuffle when the driver performs som=
e
> +actions. When the state changes from A to B, the transition is considere=
d
> +easier to maneuver if the hardware resource is still used for the same s=
et of
> +driver objects. Usually, adding and removing a resource to a `pipe_ctx` =
(more
> +details below) is not a problem; however, moving a resource from one `pi=
pe_ctx`
> +to another should be avoided.
> +
> +Another area of influence for DC is power optimization, which has a myri=
ad of
> +arrangement possibilities. In some way, just displaying an image via DCN=
 should
> +be relatively straightforward; however, showing it with the best power
> +footprint is more desirable, but it has many associated challenges.
> +Unfortunately, there is no straight-forward analytic way to determine if=
 a
> +configuration is the best one for the context due to the enormous variet=
y of
> +variables related to this problem (e.g., many different DCN/DCE hardware
> +versions, different displays configurations, etc.) for this reason DC
> +implements a dedicated library for trying some configuration and verify =
if it
> +is possible to support it or not. This type of policy is extremely compl=
ex to
> +create and maintain, and amdgpu driver relies on Display Mode Library (D=
ML) to
> +generate the best decisions.
> +
> +In summary, DC must deal with the complexity of handling multiple scenar=
ios and
> +determine policies to manage them. All of the above information is conve=
yed to
> +give the reader some idea about the complexity of driving a display from=
 the
> +driver's perspective. This=C2=A0page hopes to allow the reader to better=
 navigate
> +over the amdgpu display code.
> +
> +Display Driver Architecture Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The diagram below provides an overview of the display driver architectur=
e;
> +notice it illustrates the software layers adopted by DC:
> +
> +.. kernel-figure:: dc-components.svg
> +
> +The first layer of the diagram is the high-level DC API represented by t=
he
> +`dc.h` file; below it are two big blocks represented by Core and Link. N=
ext is
> +the hardware configuration block; the main file describing it is
> +the`hw_sequencer.h`, where the implementation of the callbacks can be fo=
und in
> +the hardware sequencer folder. Almost at the end, you can see the block =
level
> +API (`dc/inc/hw`), which represents each DCN low-level block, such as HU=
BP,
> +DPP, MPC, OPTC, etc. Notice on the left side of the diagram that we have=
 a
> +different set of layers representing the interaction with the DMUB
> +microcontroller.
> +
> +Basic Objects
> +-------------
> +
> +The below diagram outlines the basic display objects. In particular, pay
> +attention to the names in the boxes since they represent a data structur=
e in
> +the driver:
> +
> +.. kernel-figure:: dc-arch-overview.svg
> +
> +Let's start with the central block in the image, `dc`. The `dc` struct i=
s
> +initialized per GPU; for example, one GPU has one `dc` instance, two GPU=
s have
> +two `dc` instances, and so forth. In other words we have one 'dc' per 'a=
mdgpu'
> +instance. In some ways, this object behaves like the `Singleton` pattern=
.
> +
> +After the `dc` block in the diagram, you can see the `dc_link` component=
, which
> +is a low-level abstraction for the connector. One interesting aspect of =
the
> +image is that connectors are not part of the DCN block; they are defined=
 by the
> +platform/board and not by the SoC. The `dc_link` struct is the high-leve=
l data
> +container with information such as connected sinks, connection status, s=
ignal
> +types, etc. After `dc_link`, there is the `dc_sink`, which is the object=
 that
> +represents the connected display.
> +
> +.. note::
> +   For historical reasons, we used the name `dc_link`, which gives the
> +   wrong impression that this abstraction only deals with physical conne=
ctions
> +   that the developer can easily manipulate. However, this also covers
> +   conections like eDP or cases where the output is connected to other d=
evices.
> +
> +There are two structs that are not represented in the diagram since they=
 were
> +elaborated in the DCN overview page  (check the DCN block diagram :ref:`=
Display
> +Core Next (DCN) <dcn_overview>`); still, it is worth bringing back for t=
his
> +overview which is `dc_stream` and `dc_state`. The `dc_stream` stores man=
y
> +properties associated with the data transmission, but most importantly, =
it
> +represents the data flow from the connector to the display. Next we have
> +`dc_state`, which represents the logic state within the hardware at the =
moment;
> +`dc_state` is composed of `dc_stream` and `dc_plane`. The `dc_stream` is=
 the DC
> +version of `drm_crtc` and represents the post-blending pipeline.
> +
> +Speaking of the `dc_plane` data structure (first part of the diagram), y=
ou can
> +think about it as an abstraction similar to `drm_plane` that represents =
the
> +pre-blending portion of the pipeline. This image was probably processed =
by GFX
> +and is ready to be composited under a `dc_stream`. Normally, the driver =
may
> +have one or more `dc_plane` connected to the same `dc_stream`, which def=
ines a
> +composition at the DC level.
> +
> +Basic Operations
> +----------------
> +
> +Now that we have covered the basic objects, it is time to examine some o=
f the
> +basic hardware/software operations. Let's start with the `dc_create()`
> +function, which directly works with the `dc` data struct; this function =
behaves
> +like a constructor responsible for the=C2=A0basic software initializatio=
n and
> +preparing for enabling other parts of the API. It is important to highli=
ght
> +that this operation does not touch any hardware configuration; it is onl=
y a
> +software initialization.
> +
> +Next, we have the `dc_hardware_init()`, which also relies on the `dc` da=
ta
> +struct. Its main function is to put the hardware in a valid state. It is=
 worth
> +highlighting that the hardware might initialize in an unknown state, and=
 it is
> +a requirement to put it in a valid state; this function has multiple cal=
lbacks
> +for the hardware-specific initialization, whereas `dc_hardware_init` doe=
s the
> +hardware initialization and is the first point where we touch hardware.
> +
> +The `dc_get_link_at_index` is an operation that depends on the `dc_link`=
 data
> +structure. This function retrieves and enumerates all the `dc_links` ava=
ilable
> +on the device; this is required since this information is not part of th=
e SoC
> +definition but depends on the board configuration. As soon as the `dc_li=
nk` is
> +initialized, it is useful to figure out if any of them are already conne=
cted to
> +the display by using the `dc_link_detect()` function. After the driver f=
igures
> +out if any display is connected to the device, the challenging phase sta=
rts:
> +configuring the monitor to show something. Nonetheless, dealing with the=
 ideal
> +configuration is not a DC task since this is the Display Manager (`amdgp=
u_dm`)
> +responsibility which in turn is responsible for dealing with the atomic
> +commits. The only interface DC provides to the configuration phase is th=
e
> +function `dc_validate_with_context` that receives the configuration info=
rmation
> +and, based on that, validates whether the hardware can support it or not=
. It is
> +important to add that even if the display supports some specific configu=
ration,
> +it does not mean the DCN hardware can support it.
> +
> +After the DM and DC agree upon the configuration, the stream configurati=
on
> +phase starts. This task activates one or more `dc_stream` at this phase,=
 and in
> +the best-case scenario, you might be able to turn the display on with a =
black
> +screen (it does not show anything yet since it does not have any plane
> +associated with it). The final step would be to call the
> +`dc_update_planes_and_stream,` which will add or remove planes.
> +

