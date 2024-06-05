Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94AEC27C5E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 15:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE6910E3EF;
	Wed,  5 Jun 2024 15:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="apk8njh5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADB110E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 15:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbWKNSN5Fl7ayGBGTcVj+ROVV0dq/UEQwqRLmMPjPW8RDy2baSl8lrzujUQHeGwtBWFyPzIBLBgqJ/2JIfhaC+SyEqFGdp7UwR6emgdqGRESntERy+GrGJMWeeLQomXPCOLmC8SoBm7wmY5MmzwFEY5bH2Y4WbAMNtHhZjOtd2dIHBRGXsG/X0IiROCGE+3Cd+z2J+RQ84N+YOB0dywtClt5xs5MilzkypH07HOyD6hO/eryn06/mi70MQ30YOh4TgZIbJWepEFh+6fSnXdPO1c3BIcOf9AXvsiI/rAgMRJQo+MmsE1oAf7rPlRkl+VjbPdLqfCyIyhI9Yeg7is1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKJ8DApwhc5NytcVhI/DXBChOosLT9S2wdzrv2l/UaU=;
 b=gqNCnNhBO9i6bEKB/f58hOPNvJ023hz9ZBj3Kb5jV5gGf+4bvOlrWPDxT/YX1CWFopRM7E0b94Xu1a5+CNqlIaoV0X5387LnJGQDvewyOr9cYdFXK/Kt7Dsup4XHNO2PFGO+J15ocV3/344ukrfC+fy1Ea8KN1jNcN40nmR9/uM77fM667KffTj3J3EkJHNXquSFugmPFPZZTrv6g9BVMcXmY4Dwb6PCVHQwssdfk/LoujO7LIDJEA+02fBeNi52AjZn/T889Mc90PzVYIvLA+0HC5I4HBQL5NGP/RsGlz8nUL0hfXtvT0+wqrPABfaPvb/rH7iHSNgtFs6mRkLMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKJ8DApwhc5NytcVhI/DXBChOosLT9S2wdzrv2l/UaU=;
 b=apk8njh5j2e1tRM56c3W+/c8mxKRZ2rd813NzlpbxcR9QuD6B9DIs1hS0lcHA+8PBQCNN9BW03j4/O2Z2RNKRwJGJZDfNsZzJKr0DKpdasnnZnKywdAkQgFxOkW2n/TCK1b3MeQlU+nDX1EXRlgJChonVjNJCKoHVN5j463h48g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 15:56:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 15:56:35 +0000
Message-ID: <2f880722-3077-4362-acce-57365aa30f88@amd.com>
Date: Wed, 5 Jun 2024 11:56:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add NULL check for 'afb' before
 dereferencing in amdgpu_dm_plane_handle_cursor_update
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20240605154627.1812156-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240605154627.1812156-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 0497770e-42ed-489d-eb54-08dc857813d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG1sWlJ2RjJPUEF5OVFjV2dBWEFVWUJLanQxeHI0WG1iZG1FMkRzVnhyMDVL?=
 =?utf-8?B?cWJ2RXZJK2UrVlRUSjBrRVQ2SEhTS2VrM0I5WU5rOUFPVjVFdE9aZVc5SkJn?=
 =?utf-8?B?Z1JENkduTFV2bG54Yldwak1FSXpWU0g1Z3VvT2tOV2VrS1NreWMyTWJ6bjg5?=
 =?utf-8?B?T3RzYmR1azlPWVRsQmZXU1ZTMVBNRHpta09rUzNFWUVXc2JlSXBxNDhJT3B5?=
 =?utf-8?B?Z0hJRVRKNURMQ1haSWw4QXhpaEtEZlZDK1hpNnE5L2FXbkJ0cUlWQWhLVXVG?=
 =?utf-8?B?NFpod3pQakIzdkhsejdZQ1dyTDVXMDZ5ckgyL2pSVkNNTmN4MnJSZTVwSTdj?=
 =?utf-8?B?UU9hbVFhMGhVQXB6cnk5QzFZaWRUdEE0NXVvWUdaMXVIQVNwNHpZS1pndTZG?=
 =?utf-8?B?a09ITCtQWHlFZVZWRkZobmtvOTdZWkZKS0MzczhIeGdybWxWUndELyttczNQ?=
 =?utf-8?B?TjA5eVVlNmRjdGlqdlROellMZUJjbmF1TUlBSEZXQy91em9iYkVkRlY3L2M1?=
 =?utf-8?B?T012OUVENHREZ0cwdEUxa01na2h2M2hoSEpyZ1NTL2s2K1ZaVDhIRFY4cCtY?=
 =?utf-8?B?WXFmdFpHdGcwY2lYRlZGbG5DL01DNnVZUEt6TVF1UXhtczdlWkxoUzRueGRH?=
 =?utf-8?B?eDBHL1ArcW95cmExK0k4N041NHNJUE9NZDB4eStkS013KzlCWXZaSm1sVktW?=
 =?utf-8?B?M2REWnQ5WDhpc0ZiWWJITHVhSnViRTlvR0EwN2JhU1YxTlBrSit2ZFdMeHli?=
 =?utf-8?B?UUQ5OTNUellmamRPK280OS9Ma3dsM1grQjVvZEhuc1AyOGZWbkdPUFRzOHlI?=
 =?utf-8?B?NU91T1cvczRiQkJKdGQwamg0a2d6MWhEdjM2OUJsQXdySzRvb2RPWEFxZ01X?=
 =?utf-8?B?c2xVaVFVclF2Q2FMQTkwNzBkTnE0aFFuT05OT24yNDFNcWJwQ2JHamdPV1hM?=
 =?utf-8?B?bis2VWd3L3BBMUNRUTg5Y2xtMlYyNUhvUG1oSFZHRGZWcFpKWEFwa3RNaWFn?=
 =?utf-8?B?dUVNRUNTTUQybG1LZUVzbjRNSlFZUkwyemRhUURMcEdpRkoyUW5PclRFT29C?=
 =?utf-8?B?MlVOUjRKZExxdTgvbE9QWVF3RHhGVGlvdnJWTC9vS0ljWTZCNDl6ZnBwWExr?=
 =?utf-8?B?ejAzWEl3OEtoUXdnUVV3bUhldzlteDFZOGFISkxCaUhubzJQOUhjZlFuOUg0?=
 =?utf-8?B?QThPaWhxU1JBUDV1RkZ2YnFIRU1laWR4Wk5ldC9zUUR0NUkrTkMzR3U2YlMz?=
 =?utf-8?B?SVRDK3pGYzd3K2pxNVpzTHpmNm1VZmRiWHZaUTNsOE9GL1RUY3pmTnpqS0sx?=
 =?utf-8?B?UlJkTThjOFlVTi9wUnFvempKTHRNYmJxTFBKZm4vdjNISURJVWFBRm5wbGJF?=
 =?utf-8?B?R0hmaUpvWlBXUm5CQXQ0dzE0YlBSK0ZBY3FhcUs5Mkw5bWlxZ3N3b0l1V2tI?=
 =?utf-8?B?RzZGbE5TcDJxbUQxaU5pK3lqUUtpQnE5bkNzQytMeHV5OVNOSkd5V1RNMStw?=
 =?utf-8?B?WkRPdElrbEpyczM0L05IdmUwMm5mZGhPYzlDbG1IL1NKTGQ4SEE1UUpSNW9q?=
 =?utf-8?B?QXZrYStFRTYxZVNFQmNHK09Nc2pObE52WUUxd3ZtbWN6a2NXTzhUb3lIUVpJ?=
 =?utf-8?B?SHNRckUvaVlLYllTMzFWbHNvdUVvYWorOGtMSG03SUM2MzFjYmZLUjl2N0ZZ?=
 =?utf-8?B?OUFRSUo2Wm1WTmhXdGlRc3B3R3oySmhsWTVibG1CQkN3bUdVZGxybjV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtCeTVwRXduZ0JUcys4WnpMd2c2TTZ2bTN6VElCWERzTkdYNVRYSXRTZ0JU?=
 =?utf-8?B?dVRGeXBqc3ZoR2NqYmpBYlAxcnJKTm9XRG0zWU50Q0dmWStxYjlzOEhOMXFN?=
 =?utf-8?B?NlVZNWYreUQ0aG10ZHJoUU8vbkhFNTRKUXRnQSs0aUkyNEE4Z0lkY3JKcFl0?=
 =?utf-8?B?dU0yaHF2dDRjbHk5K2VzNUVXYSsxd2pDY0YyL0VSb3JUQzBvN2x2MStidlN2?=
 =?utf-8?B?aGRlMUtvSmM4ZndhTTc1YUxuNGJMaEtacTU5dk0xQmdaZmxsUEpQQVY3MkI3?=
 =?utf-8?B?TklWTXlOM2FhdXZvQ2ltc3FYQjM3TnF6N3NqN2pMeUhLb0pVZmp6TGpNNk9u?=
 =?utf-8?B?L0luanUwVUp6MllzYitmUHZpd1UrQUVZdzBkQy9hU0RRRFFpRzd5UlhmOUho?=
 =?utf-8?B?T0VRYy9LN2R4eVRHd3VvZFN3TGtNcVBNemZ5NXY3QkJ1bEtQQmNlL0p2QnlZ?=
 =?utf-8?B?RW1DcW8yTHhLWWxuV1hYcWlLSUh0bndhblRJSHovRjRmU0lyZ09NQitubFBa?=
 =?utf-8?B?NGM1Y0lOYXBKdE9hcTQrRUhuTnlYUGZCRDB5ZVlaSmUwaUtMd0RHcFdsQzZr?=
 =?utf-8?B?dmJ4ZXUrbG9XYXhrb3lTRVNOcVB5azcydVNSTHhITi9sNU9wMDF2YTNycXc5?=
 =?utf-8?B?eVMxcXpmQUNJUVU1RUZ6Q050dzlBVndKNnJpWDQ4SzJRQmh2bGk0aG9IZmJp?=
 =?utf-8?B?RHdFam5UOHIrd28rcXNCUmMzdUs1OG1naGttejN2RnpqT053WkpJa0NrSlBv?=
 =?utf-8?B?WWs0K0g5bGkvTTFQck5rTUVvSmk4aGwzNHZ5VjlRNnZQdEkxUUVGZUdvMzRu?=
 =?utf-8?B?aktPd0JRNFBxOXlYanBzTE5NUjNUUkxvYi90Z2RqRE55R0R2VXVRS2NOTmVC?=
 =?utf-8?B?bVduK3pjbzJzZWJQemF3ckswTllWdTRXRS8yMmNMOVVTZkpqS2RTMXBwUGZs?=
 =?utf-8?B?cnkwTHRLRlZzK21ndmFnN2ZtRitGTlZuR3dwd3V4NU8wRURHaGVOVWJmOUF2?=
 =?utf-8?B?cHMyTEwzZTRxZGtGQVk4V1NSMDNjUzVhRk1uN210YVJuY0taQ3VWbG5lWlJs?=
 =?utf-8?B?bWpzNWc4alk0QXNaK1FKcTJhbGhtQ2djUGx4RHJaUk84WTV6ZXhCcURWTlhR?=
 =?utf-8?B?USswNW5IbVR0TFEwNm1iS21lcTA2NFhCZ1FkVXBBdXZMdkdQMm1CQm12YndR?=
 =?utf-8?B?eEJMc1JsbUxKUlVXVnJWaUQzNytuaWYxcm9GSGhkSE5WRnYrSHp1d2xLS1E3?=
 =?utf-8?B?NEg4ZnZsQWlvNGRzTWx0bm5Pcmd4bHZXUTVDUm9hSFNXdm1EN2E0dnRabGVq?=
 =?utf-8?B?M3NmTE5MQzU4RVI2NWRkcGlPeDQ0N29EeG16ckVRZCtXc003NGp4VVBCYm1z?=
 =?utf-8?B?MXZXR1FRQmgyR1NibmY4b3JvN0JmNG1zY2FISHFaSWdGcCtBemkrTEc4enR3?=
 =?utf-8?B?K2FzWkR6Z1R0N292MXhFZ2VGbmphaVRnU1hhWitkYUI2MW5Bb210Z28xRXNw?=
 =?utf-8?B?WitEY1pXaWdMSCtZWi9SeHpRNnd3ZnNQQkRuVGZZamx5UEN6YlA4RHpUYW1L?=
 =?utf-8?B?NEdXT0Z2b00vcGdlVzA3cG9RQ2MzRXdWN1RyUnVxNUppVnBwcnYzVUtXemZh?=
 =?utf-8?B?NW14T1FrREs1MHNEcndzYnF6ZWZ2c0VlVjZLWVdZb0gyQThEVDlkWmVSN2NL?=
 =?utf-8?B?aU5Oa0ZSalpUaEpsQU9kSERQNUtBYU5iMzJyVjVGemxQbGFBZGZvelVOSlBn?=
 =?utf-8?B?clh6WU9ReFM2RGo2QldyU1hzNC9LcG5Jalh5NzJ5eXNBNHR4M3lpZnltcEV3?=
 =?utf-8?B?ejNmRGNJcTlueFpDaSt2a2IvbjRlTDZTZktycVYzblI4RFNlTHFFY3R5TnV4?=
 =?utf-8?B?SE81L2NWVU9Gckh4Y0l5TmFuTTlUQ2pZVEpDbEdUYTRUYkcrTWQ2MG5ZTmJG?=
 =?utf-8?B?L29HWFNrUlM1U0ErblNNZjNHbTQyR09FSm1sdVdtdnhCVkpNdWhlakhzN0NB?=
 =?utf-8?B?eUNwK0Nqam82dk95UG8rQThyb3hjUE1XYklIeUx3ZXdTb0xweVRRbEpZRTc2?=
 =?utf-8?B?Q0VaOU9FQ2pHSlIrNkJiUitCSGhyYldFQktRaXdmK1dqZTczbGRaV2ZWQUpZ?=
 =?utf-8?Q?fQv9TzGCWwvGj0KdxEK750iQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0497770e-42ed-489d-eb54-08dc857813d8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:56:35.7155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjEsZC5RteEfdV4d4uSd0Z69rUOg8GUxBLXxbshawCDVS10rN7jskOLpxBKZWIWMQLYMmDgB79oU/L0bMLd1Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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



On 2024-06-05 11:46, Srinivasan Shanmugam wrote:
> This commit adds a null check for the 'afb' variable in the
> amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
> assumed to be null, but was used later in the code without a null check.
> This could potentially lead to a null pointer dereference.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)
> 
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index a64f20fcddaa..b339642b86c0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1246,14 +1246,22 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
>  {
>  	struct amdgpu_device *adev = drm_to_adev(plane->dev);
>  	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
> -	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
> -	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
> -	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> -	uint64_t address = afb ? afb->address : 0;
> +	struct drm_crtc *crtc;
> +	struct dm_crtc_state *crtc_state;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	u64 address;
>  	struct dc_cursor_position position = {0};
>  	struct dc_cursor_attributes attributes;
>  	int ret;
>  
> +	if (!afb)
> +		return;
> +
> +	crtc = plane->state->crtc ? plane->state->crtc : old_plane_state->crtc;
> +	crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
> +	amdgpu_crtc = to_amdgpu_crtc(crtc);
> +	address = afb->address;
> +
>  	if (!plane->state->fb && !old_plane_state->fb)
>  		return;
>  

