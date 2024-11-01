Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3BFE6F085
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 19:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F064310E9FD;
	Fri,  1 Nov 2024 19:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MHTNu6l3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C8B10E9FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 19:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGBnqeQ9h7u/mH4M9VrYIRMoT3Djh0KH3gKo3Wqf5QEd9NxqF8pmZMSrBLJ8SIudiLIf3tYxPmMnGI8otEvz4H6oqDswVNfaL4buJWxZkVaehpdd9bB3IEaxHFU16GI7iyGeikua+y5bC8XqpkOYl3P6vjgM6zk4F4g5IjXQ9ElKIMoWHWXXr82+6yiUQLLuFCKolCLqm3Orjw/RMUpdAdsaABsIaS0KMvdpHJpbf9hM0BSjAlvo/VZaMGZYHvZG2dQZ3ITckvET+WNZtinOZYrLLZR3S86KmChlTJMD9Cbmtv3JGQjQam+ZzjV206btR2SRVgrX9xpyQj1WTZAeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNvxgfPjf332QJX03jTGrVtU5bFGQqhKUKFPwBg6Prw=;
 b=x8in+F1Od17VoeFxqd6uvAAqG73kTAcaH13YT12Q+BgNrUhY4pA8FEio8vz0/YuuRfJXo1G6N8uhL94FpiYHBT/von+FX5KDg1AAh+n9Za+sf3P7w3rInZFkZj1G+xNY9cFLa92J4cEWeoXAqxRnSTnSF8cL7F3UCIiWOKEwU9F96VJa7vKdZDlicLvFph/cYkrJ/XSyj9ZG87p8u7CKN9YuUrDirUbKGykSDpvZkQy43ZNXUE1L9tw5rdTgiZMOb/iOE4/fWINJF2xL7BsWr6tkjAKRVpQO3BSpZhIdYBjOEkPA8IniDlB0XbGCMwQBgli5oOcdGQ8g3FGPMr1rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNvxgfPjf332QJX03jTGrVtU5bFGQqhKUKFPwBg6Prw=;
 b=MHTNu6l3n3Cpj5fHwIk+//K8++KIl0joYTm7mORzUeX63GOgRJ7xM16HQJP5Sp//EHNZMMvaZdOqd5OGN6KoRMXliF3vnCjiKOT0j2TgRjPje8HmaK8U3YjBdtQTLqHS96NM5MqiwUcamE6wgDpLIhLTYkoP1mDckN1MEpWaCjQ=
Received: from CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 19:48:10 +0000
Received: from CY8PR12MB7289.namprd12.prod.outlook.com
 ([fe80::9cc2:b7be:be33:58b7]) by CY8PR12MB7289.namprd12.prod.outlook.com
 ([fe80::9cc2:b7be:be33:58b7%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 19:48:10 +0000
From: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "mark.herbert42@gmail.com"
 <mark.herbert42@gmail.com>
Subject: RE: [PATCH 07/17] drm/amd/display: Fix brightness level not retained
 over reboot
Thread-Topic: [PATCH 07/17] drm/amd/display: Fix brightness level not retained
 over reboot
Thread-Index: AQHbLGUAQ7OmcYjUUkSWZEbASGIcD7KikMuAgABED0A=
Date: Fri, 1 Nov 2024 19:48:10 +0000
Message-ID: <CY8PR12MB728973E40876CF83D6164DA2E2562@CY8PR12MB7289.namprd12.prod.outlook.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
 <20241101134940.1426653-8-zaeem.mohamed@amd.com>
 <4b624213-1187-4c1e-a37f-644cf3ca1703@amd.com>
In-Reply-To: <4b624213-1187-4c1e-a37f-644cf3ca1703@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=449d5658-7887-4356-bb7d-76e6e93d44a7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-01T19:47:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7289:EE_|DS0PR12MB7873:EE_
x-ms-office365-filtering-correlation-id: 494ef874-37a9-4f69-f9a6-08dcfaae1d4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUpWbHBuTXVjREhGb0xyNWdDd3MrclpNeVVpZnpsRVZwcHl3YnRXSWIwM0lk?=
 =?utf-8?B?MktmWUJmVVN3ajBwT0tJaW5hWlJGdWF4aVN6VzFYVFdhZ3JMTWVxdE4rcy9t?=
 =?utf-8?B?MWh5ajhXREtYRytyZUlTbDNIODRIc3B6bFNiTjhBcmExMlNiVmw1M3NaTzhE?=
 =?utf-8?B?MnJBQ3REVHVaRTY4TzE4SGdwMzhXYUVwUm0yMSsySWNWbnFCVWN5dFpOVnQ4?=
 =?utf-8?B?MTNDdWNlcHJpaTA1WUxzR0hnYy9RTUN4d1h0VnFnWUYvZml6c1NyLzQ4RWhJ?=
 =?utf-8?B?Uk5lUnYrTCtwVGRlM3ZoQW1KblNjdlF5VUlMM0lnaHduVVVVODM1TDlDMUE2?=
 =?utf-8?B?Sm5aYWdNU0JQR0prMWt5Nld3b0JNQ3V0TlV0bk1Ba3B4SUVzYTBRWUxkNFE0?=
 =?utf-8?B?c0puTFVsZ1FpSFF1MENLYjJyVXY2NEYxRGgvcVE5MUdPOEdnQWVQNTlORlZh?=
 =?utf-8?B?Z0pudlZiUndMVzcwRm9kS054VVh4UXFRbzNsTHdmQVpSWE1BSGh4MTd1UjY0?=
 =?utf-8?B?WXpGclNhRUFmQ1c3WFlITFJYclFyTzk2cmdacFlYTmx1Q3YyNytzSmlRcDNM?=
 =?utf-8?B?K2pFajA2VHFvMWdTNUE1dVNGRWgxRkN5M3Znb1JzNk5rOGp3anBuTExVM3BS?=
 =?utf-8?B?a2Z1NkxlM1NxcnFwSXJVOG5Pb1J0Z1h1em45NXJBRzV0VWx5bUVJNU9yVDFD?=
 =?utf-8?B?RlI3akpYaWdnOU90V0JYWGVBMmRKMWZtaVdubEhBUS8zMGZvbURCU1JOV3NG?=
 =?utf-8?B?UVhrNkNUSlE2K1J3RVZkZkg0QUkrWmVhR2VtWU41cVZsZjdnSXFZdUQzOW1k?=
 =?utf-8?B?bGJ6VG9rcGtWN1JZckZGaGpRbHVlSUQ4QkdKY2p3NGtkWHQ2QWFjS0c0ZlJY?=
 =?utf-8?B?M0R1SlRvbEJlbEk5Tk96bEZneVNXVkRpelVsalNjSU44Z1hLWVpyVk9PSEMy?=
 =?utf-8?B?YVFZTE5GR2VYMkN3TVFHMlRlVnFUeWNESTNHN21KTktQTU84UTVVd3NPZTFZ?=
 =?utf-8?B?U1pSQ1pSRWJpS3VSVEwwZWcydVAwN3ZLeGhiMGY3UWhCTkM0YVNHc2wvV3JL?=
 =?utf-8?B?R1JjVWxzcW02ZFE3MVhPZDdwUDJlb2hIMitNTWJXdVhtYnNnT09QWjJrUnFr?=
 =?utf-8?B?YzdEbThBc0gyUy9ERUx3bDlEQmpQcHlMU1FMcHRmQXZLeGliMFNHVDlHUmFo?=
 =?utf-8?B?aHEvWHhXKzBXQnBCbUlkWllJM3ZpT2JDVUdHTmViR0lLVWtTUFdkSnpWNjVq?=
 =?utf-8?B?cWU4aHhrZWdXaVpOcjZLR3EzdU1iZ1RWb2UrREk0SFh5UVZjQURGTzJPWkxl?=
 =?utf-8?B?YVBZcTg3V3BxV2c5Ky9GMFlDNk9tckdyS2pyUEh4N0wyU05xbTdkd1ZRM1Rt?=
 =?utf-8?B?Z3pvMWk2S09QUjZ6RHdHNGR3OTVoeTJZME5iZDJYTytydll4L2pjRWJpbVJn?=
 =?utf-8?B?ODRURXJnRFRDM0VxdUFVNVdUdzNucjdNSVc5aDNFN08wY0YwR0QyZExGTzRo?=
 =?utf-8?B?SFltY08wd2lmcy96Q3kzdmZOY2pFUTVlM2pFcjVHUkhzK2pTQnlPUTFvVCtu?=
 =?utf-8?B?SUdSMkNwblFCaSt3dUlGRXdOTkhNMlA5UFlwZ2RVdS9QQmUwVksrUVZrY09V?=
 =?utf-8?B?THFOdHVsR3VQVXl2bjVQa0wxQ0RuN3NVNnNvaC9pWERmeHBUWk9rZlJES0h1?=
 =?utf-8?B?MkNXQURHK0hMSzlvTW9uempNL2JneUl0NzZkd054TzhSZGo1UUpDaTZRRFlr?=
 =?utf-8?Q?s+ciTC8sx5phFrh/Z5gbm0msE5kV5ABzYjga+7P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7289.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUZxNnJjbnU1L3p1c3Y2ZHVETThRMnp3ZXlXeFB2aWJ3bVVZbVlrWGJBR0ZY?=
 =?utf-8?B?MnY5RlhPMFZObitpUHJEN2d0RXhlQ3dTZ3dndzZpdW9iSDZjUXNEUlBNQXY1?=
 =?utf-8?B?a2ZUejFLclYyTDhSUnlVQ05zRURVSUZhRUhhemZWU1VmQlptRmQzVG4rLzdI?=
 =?utf-8?B?WnFLcEtaNXpkbnhZOFEvL1lXUGE0Z0tGbFhWQVJiSWtvMFExUm5nYVhoeThw?=
 =?utf-8?B?Yjhnck1GUDR3dU9YUnFtUCsxd1VBbm4zTUZuK0tVOHpURG81MisrY1c0cHhI?=
 =?utf-8?B?SWtoczQxeHg3NnYxTnVJUy8zSlg1aDVDREJ2RjZXM2V6VHgyeUMwTUFyY1Z5?=
 =?utf-8?B?YUJ5T1lwUjczS2FPYjUxUjZKUEgxdGd1V1lmNURIQTRVRjBDR1dNRGdxWmNI?=
 =?utf-8?B?bUVKMUpHVEpKM2RVcUNEOXBjNFhNRDBLTGM3Z0RRc3U2YXVwWDVqcDkxaGdk?=
 =?utf-8?B?M2dEWmFndzFoMjlCdWRTN2o5aVhlNERpR01xeXFiRXpqcW5oM1o1QkdXeGkr?=
 =?utf-8?B?QUNqWHdndFNNZ0l2ZEFTWFpDTXc0Zi9xYnd2TUZtMkV2YTRSM2JRZ2NqV3Nh?=
 =?utf-8?B?d3dkUG0xTndBU2FXOTlibzZLN0RSK2NDTW5FVlBoQlRnRDk1OEdHbEZRTkhq?=
 =?utf-8?B?YnRWVEJVRU1FZktQVW5ITTdpc0FMc2FwbkdHZmRMZWFrckxReGFRSkdSK2FP?=
 =?utf-8?B?WGJIeVNiVXZwQ3loWlU1Nkg4djkwbURYYXh5YWVxNEVBQ3QxczVMVy9VWTJE?=
 =?utf-8?B?emp1K0RGMzN0L1JuNkYzN3hHU1FVNHg2SU1zQXFrdTk2ZU9YZkVJWnNJd2dS?=
 =?utf-8?B?TjlBejMxYThqZFlxcFVEakUrNXNJd25GNEdvQUdyQ05iK1YzWVY2Mzc3QWdW?=
 =?utf-8?B?dU85ZmprTnN3VjNhbngzR3g4YW5Sd0V4b21JUU9MSzcyT1pTdUJKL25wOEcy?=
 =?utf-8?B?a3NrMFZuSTdsZnV0ZE9MTndrYnA2SXdoTW42OXMydFJ1alNtbm82akwyTFU0?=
 =?utf-8?B?blVMTVgzdGVTd253UUN2Q25IRi9PV3oybDNCS0RWRnBJMFlrck9DNDU0UmlR?=
 =?utf-8?B?T3NkNnhaWnZIOFV1NXRyb1M3VFR5OHRGSk9VZmV0U29HakpkZDZ3cWFYaHll?=
 =?utf-8?B?M3FsdkdPOEVvNEFOU3ZXWEt0dDRTbzhTL0Niem5kWEZzVmE3TU04blh6bjZW?=
 =?utf-8?B?UElJSlRCSWwwYThIQmd1UWF1dlYvOGhWSDlYRFVENkEra2huTmwrc0J6cjgw?=
 =?utf-8?B?U0lDN2xPN2cvSll0SkV5VW1ablBkWGJQKzQ2VXZDVkk0R1AyVi9ETkRyVThU?=
 =?utf-8?B?ZTNvNFBqNTJzUC8rWjg5ZUlDV0RpTzRSalBrcnRIQU1ycDQrL05SakxTc2wy?=
 =?utf-8?B?RHp0dWdTMDRaVDhTNUFMTkM2K1JQZjExMWlGekMyZmU4aFhQVU8xQWdUS2c0?=
 =?utf-8?B?bXJvL2Z1L29rYjZ6YnRacjRTQkpJNno2OVVOWXZ6R2dianVNR3lUZVE0aERp?=
 =?utf-8?B?VlJieVVqd2lmS1VaV1F5SDBCNlI4bS9mY2pHdzBhN2VPUHRxeUp4NlNxY0VX?=
 =?utf-8?B?WC9HZE9yamEwZ3BzZ3JTbFRUcUp0U0xGV2RQQ2t0VExJTVE5UTQwcWIveDRz?=
 =?utf-8?B?bW8vdWx1M3p1QURtbDdvWmJWOVRCTGtsdG42b0Y3ZGwzb3RQV2lNNkRSbXJa?=
 =?utf-8?B?TUx2bElnOGN6ZnVVUUNBVEtIVFNrb1Nvd2k3VXMyQ2pwbUd3d0hVT2t5cVZH?=
 =?utf-8?B?a3lSZnd2aEFxRGpNWHd4dUs2bXBvNDBDc0dSeTJ3UTI1NjhzN0ZzbHZDVzRl?=
 =?utf-8?B?M3ZEN2g3TmhXaDYxZ2xqUmdHdmJrVHBHU0FOSXprUWtDemNhUHlVWWlHWHNG?=
 =?utf-8?B?YTZpVXZJaTR3Z1YvQnJQbDBuNGM0VmZ5MGh4WExXdW15OXVtalcrYXpPd28v?=
 =?utf-8?B?bytlUkRtblRxNGU0Yk5ReGdTSXcwSnArSEd5M095aVk5RVNuY0dONnZvV2NF?=
 =?utf-8?B?VkFCQXl2NEdGRlVtOU9wTEJrN2x2ZjBubHg2VVN0OXVzaUtBVDgwajNHUm5x?=
 =?utf-8?B?eGtGMHFXdW00ai84WGo2dDUzbVlIVHFvcGFoQ3dZWTUzWC8wc0hxZUY4OU1F?=
 =?utf-8?Q?la2I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ef874-37a9-4f69-f9a6-08dcfaae1d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 19:48:10.2231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16J6LpzK0wtKxZ7JgCZx3pvfV3G2SN7XAKwW7Wf7QclwrUCwJyfvbuTD/HuR2ITvZJzoNQDOitaGN5+Qh0mE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFyaW8sDQoNCkRvIEkgbmVlZCB0byByZS1zZW5kIHRoZSBwYXRjaCB0byBhbWQtZ2Z4
IGFmdGVyIHRoZSB0YWdzIGhhdmUgYmVlbiBhZGRlZCBvciBpcyBzZW5kaW5nIHVwc3RyZWFtIGVu
b3VnaD8NCg0KWmFlZW0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpbW9u
Y2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwg
Tm92ZW1iZXIgMSwgMjAyNCAxMTo0MyBBTQ0KVG86IE1vaGFtZWQsIFphZWVtIDxaYWVlbS5Nb2hh
bWVkQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFdlbnRsYW5k
LCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4gcGVuZyAoTGVvKSA8U3Vu
cGVuZy5MaUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1k
LmNvbT47IE1haGZvb3osIEhhbXphIDxIYW16YS5NYWhmb296QGFtZC5jb20+OyBQaWxsYWksIEF1
cmFiaW5kbyA8QXVyYWJpbmRvLlBpbGxhaUBhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBh
bWQuY29tPjsgTGluLCBXYXluZSA8V2F5bmUuTGluQGFtZC5jb20+OyBDaHVuZywgQ2hpYUhzdWFu
IChUb20pIDxDaGlhSHN1YW4uQ2h1bmdAYW1kLmNvbT47IFp1bywgSmVycnkgPEplcnJ5Llp1b0Bh
bWQuY29tPjsgQ2hpdSwgU29sb21vbiA8U29sb21vbi5DaGl1QGFtZC5jb20+OyBXaGVlbGVyLCBE
YW5pZWwgPERhbmllbC5XaGVlbGVyQGFtZC5jb20+OyBtYXJrLmhlcmJlcnQ0MkBnbWFpbC5jb20N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMTddIGRybS9hbWQvZGlzcGxheTogRml4IGJyaWdodG5l
c3MgbGV2ZWwgbm90IHJldGFpbmVkIG92ZXIgcmVib290DQoNCk9uIDExLzEvMjAyNCAwODo0OSwg
WmFlZW0gTW9oYW1lZCB3cm90ZToNCj4gRnJvbTogVG9tIENodW5nIDxjaGlhaHN1YW4uY2h1bmdA
YW1kLmNvbT4NCj4NCj4gW1doeV0NCj4gRHVyaW5nIGJvb3QgdXAgYW5kIHJlc3VtZSB0aGUgREMg
bGF5ZXIgd2lsbCByZXNldCB0aGUgcGFuZWwgYnJpZ2h0bmVzcw0KPiB0byBmaXggYSBmbGlja2Vy
IGlzc3VlLg0KPg0KPiBJdCB3aWxsIGNhdXNlIHRoZSBkbS0+YWN0dWFsX2JyaWdodG5lc3MgaXMg
bm90IHRoZSBjdXJyZW50IHBhbmVsDQo+IGJyaWdodG5lc3MgbGV2ZWwuICh0aGUgZG0tPmJyaWdo
dG5lc3MgaXMgdGhlIGNvcnJlY3QgcGFuZWwgbGV2ZWwpDQo+DQo+IFtIb3ddDQo+IFNldCB0aGUg
YmFja2xpZ2h0IGxldmVsIGFmdGVyIGRvIHRoZSBzZXQgbW9kZS4NCj4NCj4gUmV2aWV3ZWQtYnk6
IFN1biBwZW5nIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBD
aHVuZyA8Y2hpYWhzdWFuLmNodW5nQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFphZWVtIE1v
aGFtZWQgPHphZWVtLm1vaGFtZWRAYW1kLmNvbT4NCg0KU29tZSBtb3JlIHRhZ3MsIHBsZWFzZSBl
eHBsaWNpdGx5IGFkZCB0aGVzZSB3aGlsZSBtZXJnaW5nLg0KDQpDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KRml4ZXM6IGQ5ZTg2NTgyNmMyMCAoImRybS9hbWQvZGlzcGxheTogU2ltcGxpZnkg
YnJpZ2h0bmVzcyBpbml0aWFsaXphdGlvbiIpDQpSZXBvcnRlZC1ieTogTWFyayBIZXJiZXJ0IDxt
YXJrLmhlcmJlcnQ0MkBnbWFpbC5jb20+DQpDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzM2NTUNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMTUgKysrKysrKysrKysrKysr
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IGluZGV4
IGJiZmM0N2Y2NTk1Zi4uMjU5OWE5OTUwOWRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gQEAgLTk0MTEsNiArOTQx
MSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9jb21taXRfc3RyZWFtcyhzdHJ1Y3QgZHJtX2F0
b21pY19zdGF0ZSAqc3RhdGUsDQo+ICAgICAgIGJvb2wgbW9kZV9zZXRfcmVzZXRfcmVxdWlyZWQg
PSBmYWxzZTsNCj4gICAgICAgdTMyIGk7DQo+ICAgICAgIHN0cnVjdCBkY19jb21taXRfc3RyZWFt
c19wYXJhbXMgcGFyYW1zID0ge2RjX3N0YXRlLT5zdHJlYW1zLA0KPiBkY19zdGF0ZS0+c3RyZWFt
X2NvdW50fTsNCj4gKyAgICAgYm9vbCBzZXRfYmFja2xpZ2h0X2xldmVsID0gZmFsc2U7DQo+DQo+
ICAgICAgIC8qIERpc2FibGUgd3JpdGViYWNrICovDQo+ICAgICAgIGZvcl9lYWNoX29sZF9jb25u
ZWN0b3JfaW5fc3RhdGUoc3RhdGUsIGNvbm5lY3Rvciwgb2xkX2Nvbl9zdGF0ZSwgaSkNCj4geyBA
QCAtOTUzMCw2ICs5NTMxLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RtX2NvbW1pdF9zdHJlYW1z
KHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4gICAgICAgICAgICAgICAgICAgICAg
IGFjcnRjLT5od19tb2RlID0gbmV3X2NydGNfc3RhdGUtPm1vZGU7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICBjcnRjLT5od21vZGUgPSBuZXdfY3J0Y19zdGF0ZS0+bW9kZTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgIG1vZGVfc2V0X3Jlc2V0X3JlcXVpcmVkID0gdHJ1ZTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIHNldF9iYWNrbGlnaHRfbGV2ZWwgPSB0cnVlOw0KPiAgICAgICAgICAgICAg
IH0gZWxzZSBpZiAobW9kZXJlc2V0X3JlcXVpcmVkKG5ld19jcnRjX3N0YXRlKSkgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgZHJtX2RiZ19hdG9taWMoZGV2LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIkF0b21pYyBjb21taXQ6IFJFU0VULiBjcnRjIGlkICVkOlsl
cF1cbiIsIEBAIC05NTgxLDYNCj4gKzk1ODMsMTkgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RtX2Nv
bW1pdF9zdHJlYW1zKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYWNydGMtPm90Z19pbnN0ID0gc3RhdHVzLT5wcmltYXJ5X290
Z19pbnN0Ow0KPiAgICAgICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiArDQo+ICsgICAgIC8qIER1
cmluZyBib290IHVwIGFuZCByZXN1bWUgdGhlIERDIGxheWVyIHdpbGwgcmVzZXQgdGhlIHBhbmVs
IGJyaWdodG5lc3MNCj4gKyAgICAgICogdG8gZml4IGEgZmxpY2tlciBpc3N1ZS4NCj4gKyAgICAg
ICogSXQgd2lsbCBjYXVzZSB0aGUgZG0tPmFjdHVhbF9icmlnaHRuZXNzIGlzIG5vdCB0aGUgY3Vy
cmVudCBwYW5lbCBicmlnaHRuZXNzDQo+ICsgICAgICAqIGxldmVsLiAodGhlIGRtLT5icmlnaHRu
ZXNzIGlzIHRoZSBjb3JyZWN0IHBhbmVsIGxldmVsKQ0KPiArICAgICAgKiBTbyB3ZSBzZXQgdGhl
IGJhY2tsaWdodCBsZXZlbCB3aXRoIGRtLT5icmlnaHRuZXNzIHZhbHVlIGFmdGVyIHNldCBtb2Rl
DQo+ICsgICAgICAqLw0KPiArICAgICBpZiAoc2V0X2JhY2tsaWdodF9sZXZlbCkgew0KPiArICAg
ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBkbS0+bnVtX29mX2VkcHM7IGkrKykgew0KPiArICAg
ICAgICAgICAgICAgICAgICAgaWYgKGRtLT5iYWNrbGlnaHRfZGV2W2ldKQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbWRncHVfZG1fYmFja2xpZ2h0X3NldF9sZXZlbChkbSwgaSwg
ZG0tPmJyaWdodG5lc3NbaV0pOw0KPiArICAgICAgICAgICAgIH0NCj4gKyAgICAgfQ0KPiAgIH0N
Cj4NCj4gICBzdGF0aWMgdm9pZCBkbV9zZXRfd3JpdGViYWNrKHN0cnVjdCBhbWRncHVfZGlzcGxh
eV9tYW5hZ2VyICpkbSwNCg0K
