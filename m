Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D404FC87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 16:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CC110E6C4;
	Tue,  5 Aug 2025 16:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gZJy/Ej";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DFD10E6C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 16:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys9is+CpOgH8qU2F/ygghJ7iXYBNpWK85kAt84hgAR9B2AUE/gxXtaeLd30KV2WNRZUehC93mZBi/OJDaW97FUy9YMWPLKdg1Pmm/5XFFVG2b5jjMnFiJIcmX7YUGldySmQ/E8/tf/32Ea3fn4D8f+SPz23ufTFXAN29/ZWRVEth24v66byYXZH72wPkCTfx/Jz3c1lp3vRoUC9wB9WqaWf8AvkD6Zx2lJJWzZzybNLrujfcp6W2XidWsHKdTJoRK2F9fmnxJhKz/hx1xSBdiAXsIa8etjXVNvTrHtHz/Q2ejSd2CIE+l/rR0D8DpvSu6OsK8GoQ+ggA6Vumh+a7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+5gDLkw0Y8yHaNx2AgdL0iHv/bDCoSltq14DNze/C4=;
 b=XyMBI0bQh/jMiMXn0WJFrpOaI8cnT65GP3Vt7Xz7Q9k1OFwRfG7JeSK87wVFdG6Os+C2QegTOaMoHwxNfSQlqY90KQqBfku7oWhFm9SDW3R1h6dRuDlppUW32JprdpwPcNpVftn7Tst5Tv84pTPjDbzP9IjK5WrOFOrq/shfxpiX1PQ0eq2Q/rQnKXnEm6dxHG7zvJ3zFCh5Si8OXLBJqVv2vHL2znlUyRaPjGsCO8McRnbKwK4xQgtwF4S50uue/jm6cYeCanysKO413wag4zCPJpQMc6Z3AGY9XG2blmKlIPa/7K7Hn9px6SJBKD3qrEnEvhEqXJTRkkaDUz+YOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+5gDLkw0Y8yHaNx2AgdL0iHv/bDCoSltq14DNze/C4=;
 b=2gZJy/EjRIWK9mi+duoYjhGpnOdOxAQLu2CAQC7dgKpgqctBEvAUkos/Y2y7ruMvF59hnzTJcRmwopCIbks81914rm2PZ55HmwkWy5OZs+plb/Fej/CmPxEY0d3faHgA/clObsPMFeWc+J8Ou02Mym7rZAd3bW2HCESXjoUnod4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 16:29:27 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%4]) with mapi id 15.20.8989.015; Tue, 5 Aug 2025
 16:29:26 +0000
Message-ID: <6603d06b-4d58-4d34-af69-ff6921b261fa@amd.com>
Date: Tue, 5 Aug 2025 12:29:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add primary plane to commits for correct
 VRR handling
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>,
 Xaver Hugl <xaver.hugl@kde.org>
Cc: amd-gfx@lists.freedesktop.org
References: <20250730080902.6849-1-michel@daenzer.net>
 <5620e30c-d953-4cd3-993d-0aea878574a1@amd.com>
 <3f54ad00-4d07-4027-9afe-380a34419784@daenzer.net>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <3f54ad00-4d07-4027-9afe-380a34419784@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0422.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::9) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: adc87188-66de-4a14-60b1-08ddd43d3eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVhncjZJaklSNzc4Z1AxaU9jVWJaOWZHTWdJalRMNGtHNzNzVjhRVDNyakla?=
 =?utf-8?B?WGgyT1lOSkNLWjBhS1VTRk9aQXJEU2hSelFZa2kzcThKRU5nemxicXVWM2U2?=
 =?utf-8?B?dFk3ekw5ZEZYRnViTzI4UEVyQWdtZWhrQXVYdzNGTmNRL1lneHhjSFRMNnNB?=
 =?utf-8?B?RkFvYTR2c1hwREE5MVB4YmVOUGFrS2ZrUjcvRVZ6REdwWmdUU1VxL3pja3ow?=
 =?utf-8?B?WXMwbk9SWHIzQmUvNTZLRi9QNmtVQ25uZGUzSlZUZjlkbDcyeDhTazBMb0d2?=
 =?utf-8?B?d0pjcStMckdvM1ZsbEtaRWhLNDRLaDMzV01pa29mZG1mbXlYSW01VlJ6NkNx?=
 =?utf-8?B?RnEvd1pjVVdqTDkyTytiMW9ta0FLblcvZ1V0S2tiWTdrMUxSVFFPbHZXdHJD?=
 =?utf-8?B?WlZjT2I1M1JVSk9udnNsWlRZQXlDaHNYMll4V0MwTXE4VldHakRQNFBTSGdO?=
 =?utf-8?B?aEpxT0tQSnE0Z1MwV0NWUmlqU3p1YWhWOGo5RHF2NXdsVnI2Y3ZPdEZVa2dR?=
 =?utf-8?B?bW83eUViTDBwbFpuR21wQnJCM2RzcWk5SElzZUIybVJ6WURDMGhkSXJTNzNO?=
 =?utf-8?B?OGo0Q2x2TW1OOFpXNVZUYnZsRTg4Nk1wQ3IrQnp1YTU5QjNBRm5DdmRtRXQ3?=
 =?utf-8?B?eEV1YnZGNGlteXIyL3hQY2NQWDc5bEtWd0p0bXZhY2xrMFFKMnQxOG9TZ2tt?=
 =?utf-8?B?SjRwdk10aEI2a1NraHBQeGtnWGxsZ1BmMnQvdzdYSXpEUjE4cGg0RHVZR0Vm?=
 =?utf-8?B?VjV3OVlSSVZJWk1XMksrTEhaeEVDYkFpejlFMU9yZE9SUmxZMExLNURqRW5B?=
 =?utf-8?B?OXoxUDRhOTNBTkx2bFpkNWRpN0VZbFpZQW1MMVlES3Bwa2pqdHlCTHpDaTds?=
 =?utf-8?B?K2JUUnpoeDdiZnA5N05NZ21RZC9kYkNpS2ZSUitzVmpDcytZNC9uaUF5U1p1?=
 =?utf-8?B?OG1zbllMbW4yYnFaT2dqYnFzS0I4RS9GM0Q2aWJDRGFMcStmbllmUkVRdzdm?=
 =?utf-8?B?YVZMNk1VSENrM3VmQXNma055aEJTb2NHOHVNUWsvWUIrc3dFU216TDZNUlRQ?=
 =?utf-8?B?WW5QbUIzVWM0UnhKeEpPaitaU29pNGNFbnpmdUFBcVdLOUNIWWFhbG9GSkZX?=
 =?utf-8?B?VGxzT1VLVTBTUVR6L2pzK296Y3QvUnJyT1dDRDExbTB4OEJXVjYwRFg4U2Jw?=
 =?utf-8?B?c3QvemdyK0lKajdIVmZ5WUUrS1M3SzNoV3dGTUw4V0Y1d2VpeENNSWJEdmVq?=
 =?utf-8?B?VExuRUp4UEtzUFFiSkdtQ0xxZEVGbGx1bXk1SmdNR1VJMWM4cWhsVTE2RnBC?=
 =?utf-8?B?blp3bEQ4QzhhMGVXUlF0U3ZScjU0bmlsdEg3b1RITlB3Z2pQd05HSXFoZStr?=
 =?utf-8?B?emo2MnZJQjNSK3VjVkh4V3IzdUt0V0dYT0hTNEt3SzVGNlZheUFQTm14cGZX?=
 =?utf-8?B?dytxTm16SWxWdlB2dS9PdDhGVFB0d2VLS0pja2dDU1pML2NLYllhWmtqOHlC?=
 =?utf-8?B?VTN0TWE4SGdYY01pL3VvNWxSNjNnRE1ROFRrQ2lPY1N4QUU0aUVPK2dzZ29q?=
 =?utf-8?B?VlZ3Z3pmZjh2N05hZjJYTFlpY0ErN2ZuQ1BnL0xxZ3dGckxaWU1KOHl1dXh4?=
 =?utf-8?B?OEdhcGZqRG4rcTN4dHE1VHJpNmRDVVpVRUpRZU9CTmRLQlFnUDZieHc5cTBB?=
 =?utf-8?B?eVFPQk5ZN3B1bk1xeGZRTjQzQTlTU2xReUswWmJLR0xSZWNLZFZiSnlYMWpP?=
 =?utf-8?B?L2ozaUhNY2J4RkdXMlE2bHlMVURGeVBmcklDUFh6OGRKbVFZMmNCb0MwbUxh?=
 =?utf-8?Q?KNH+fChjqSzHcC5Brn2NqMLY5NXTEyA/knfY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkVGTTd6MElkd3hVQXhQcFE2bnM4M01RajZHNS9reXZZK2J2S2Z0MzhJbzBp?=
 =?utf-8?B?ajRyOWNMUmlNVUdPMjVZK3hGMnp6WjVzdEJnM1hvUnI3cDZzeElnMTdCTnVH?=
 =?utf-8?B?ckthVldUWW9odmpXc2NjOWI1dlBzR2xSdW5idktFaFJnR2NBVytBSFJybzJV?=
 =?utf-8?B?NlEwMjVFMThyUVJ2R0xiRWoydncvcGMrOGpENE02L084aTdWRlNiYk9oV3c5?=
 =?utf-8?B?eVE2VGJJTDlMdlN3UFdpVzRabVhDTnQ4Szl4SXZFKzJlV1RXbVg2OHpKWk5i?=
 =?utf-8?B?Q21pbzRzSzQ5VnZFNWpKOUo2YnAxUndRMkhnQjRqUSsvNFg3a0plOGdLMDZa?=
 =?utf-8?B?c1E4T1FmYkMycnpsWTYzOFJFT1ZjMTYvNXVDZXdIOWJkbHdqTndXeEg0K3ZO?=
 =?utf-8?B?WjQzemhDY1BWcWpiNW03YzRqcFd5T3BweGwyRWdOSng4MHVOZUlDaVZwL1dw?=
 =?utf-8?B?d3orZHdHRWVtVU1TcTlOUzdrOW0wTms5SUhzN1o4MlFrTFppMUZKVFZ2M1Jh?=
 =?utf-8?B?dTUraHNMZWFOaHI3SGtCMXBmYVA4NWVVWXdzOGptZ1FYcG9zWXhzMlBIQnJJ?=
 =?utf-8?B?bW9PZXVpS1hydTQzTVpSNk4vV0NLc0xvVThrRGVUT0tCQTBNMmZKK1JyT24z?=
 =?utf-8?B?eUM2RnN3eWxaK3AvbU1wOXJROUtBR25aR0MzUjd3dlBTSVdRZkpheWZjNDJW?=
 =?utf-8?B?K0FNTFM5YlFhVHVUb0hZMzZQbDJIb1JzbFNlQVJVWFFQeHBuRDlzdFgreHRi?=
 =?utf-8?B?T0FWT2NWVysrYnJRV1Vvb1lKYmhaNTZnL1B5emRVclhPVzRZTktpUnY2ZFhp?=
 =?utf-8?B?UGdpTWJlR1RiUFlJVkt6b2ZMUDFHK3l2QVNnUEZMU0ltalpCSzhOK2FnOGti?=
 =?utf-8?B?a2M2bEtQSkJsTmtRTkdvM0ZWNjRJVUJ1MTBNVjNmN0dCWmxET05WdHljWVZJ?=
 =?utf-8?B?WDVic3ZneXJTWDE0dHBwWW45QkFHUnVwYUV0T1VrMmFhKy80MjMyaVp1cjZ4?=
 =?utf-8?B?YTQ0VkpTZnlrTHFXWk5tTWdqTGEzRGJUNFdRTjNEZkp0VlNiSy9wZ2JITk9q?=
 =?utf-8?B?ald2eWVaSm81RDUxZ1V0TWY1d0xTL3hHSG9kWXc1UWxQc0lLaVlZU0ppNWM4?=
 =?utf-8?B?TTFlM3c4ZHF0T0lMdlhsS21sV09NdWJjZjZKbHZQQjB3S1N5SjlGYTZQL3Vl?=
 =?utf-8?B?WTJ0dWVubHJGcnl0YTJyN1EvcGZ2Qm5lUzBBK2I5d2tUZkFXbXFESXhrUVMy?=
 =?utf-8?B?dHZoQlNqditHRzVGL0pvMDFRTHNqVThBTFJEVjJRVFlOVm9XYXpTeDduU3FP?=
 =?utf-8?B?MFBKZ3RWS2w4c2h2MVVtRmNMVkZrRjZ5MzZPQ3Vwa1UxRmtFQjlFeWFwSFdR?=
 =?utf-8?B?YVlHVnNPZFRCWlp4SzJJdUhvc1FsSlVtdXZwbXgrQmJwZWExMkIwRHFBSWxL?=
 =?utf-8?B?NTNkOFMrdEE3c25iZ0VBSVB5Njh6cmxTOHczMm12VzRrdW0rTXFSUXlWNVd5?=
 =?utf-8?B?dlZZbEdYc3BmaG0rTEZlTjYrTVIzNVh0Rkp5QlI5NkhxK29TTDZGc2R2SlVR?=
 =?utf-8?B?dkNEdFlaekdUVTU3bG9tUnBIYjhJR1E0K3RGVTh6SjR6WkkrcTNQSXlVckJX?=
 =?utf-8?B?K0JtbUo4QjZTbUVGRG9ndWQ2ZmpCWERLN2thKzhKUllDOHcwNk1OakRGRytD?=
 =?utf-8?B?TXZEK3JwaGwxWlMrcUdwcG95ZGUyNy9UNWx2MHpSZWkrK2xlOG1CdXlTRjVt?=
 =?utf-8?B?aERLOXVCZnlvbVArNEtoekJjYkc0Z0FROTl5RHJWS1Y3MXFBWk13ZUpOeVlY?=
 =?utf-8?B?WjhrYVdwMWY0WVAxVnVET3VvRWs1SUVQbUhlbXRYVlNJbzNuZDRUMkx4bE5z?=
 =?utf-8?B?MFFzT2w2d2xmWmd4WmpLTmhEb2dsOU4xdk1wSHBCUFdNZHFkUzA0T3VsYWhD?=
 =?utf-8?B?NzFFUXdrM3VQMkh2dlpqZU1oY0RSMHZXYTFFaEJtc0V1a05rbjB0U1R3MUdJ?=
 =?utf-8?B?UWtzYk9DUlp0d2QzTTlOUGxnNnZMajVDcU1VSHFOZ2VPcExTb0FjdWJkZnll?=
 =?utf-8?B?K1RpNEN5aytrbEtkZmJLTlpqc1JDcmI0ZUE2SGNiWHRjd0FDNTZCNzhnL05N?=
 =?utf-8?Q?Nve9zq2F/gisrDRy4vnGmpdW7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc87188-66de-4a14-60b1-08ddd43d3eb3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:29:26.8955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV/DBjYEXUp37wE1gPwMNoQ+oVNB1ged/o9pa3QKQ8G4tlBtgeVuyHlYM1S4jEjugyrkuzsJjSxbvlvzChNWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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



On 2025-08-04 04:03, Michel Dänzer wrote:
> On 31.07.25 19:27, Harry Wentland wrote:
>> On 2025-07-30 04:09, Michel Dänzer wrote:
>>> From: Michel Dänzer <mdaenzer@redhat.com>
>>>
>>> amdgpu_dm_commit_planes calls update_freesync_state_on_stream only for
>>> the primary plane. If a commit affects a CRTC but not its primary plane,
>>> it would previously not trigger a refresh cycle or affect LFC, violating
>>> current UAPI semantics.
>>>
>>> Fixes e.g. atomic commits affecting only the cursor plane being limited
>>> to the minimum refresh rate.
>>>
>>> Don't do this for the legacy cursor ioctls though, it would break the
>>> UAPI semantics for those.
>>>
>>> Suggested-by: Xaver Hugl <xaver.hugl@kde.org>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
>>> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Thanks Harry.
> 
> 
> It occurred to me that Cc: stable might be appropriate for this fix, what do you think?
> 

Agreed.

Harry

> 

