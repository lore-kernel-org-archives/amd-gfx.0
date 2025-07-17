Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CAC83F22
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 02:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FF910E0E7;
	Thu, 17 Jul 2025 02:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ysVvU4C/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94AF10E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 02:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up3JotFeLZcPv/QRe72MyvL+jaMSbBWSYMBqr0N21r0vcdMmBV0lOERjupjGDy8MJCDJ0LGu+1XWhWyYq8QTH3J2S/7x0YdxDhH7afal04ORoeV8eG8TcwyV3Z1OKp7xGOQvCbIuJsBI3SLvbf4hP+w7VsPjCZrfAjmUTqp7Sz1jOYs2IwZnX2zKYrF6b88pzzPE7CVFGlBBz/VorNeKbV+fcCzmp6pHClIhJ8XpVl0kTkGLVTlq70m9XzqQ1jb5CYTMNwx1+wBq9cHsgJpoPv5Oe/6C5LlMIhR+IMhXI0b9t7g0cVHQESkRnEvJ88d9+bo1ynyzjAIwShYFLPm81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3Csm93D2XHvDyNhY2UuS2vhTGfCQndJxxhUS62b/S4=;
 b=yqdC+E2rRTlhiW+WrInH8Mh4t5eUZmP87cBzjHQZHfinZ+8VsJ2ksrOsKuxkKqqLi0PmuNz3kGMNUt19lS/ZuaWahi/EWynW0zUNDNimtunvF1Lv6Hi/YvmKB5iFCSFD4gVehPo3h5ztflkibKNEDEKlslnWoPjjo1tM+oV+QHN6ANgipqErH0j5UxoDiIw8jiY5NU+uu6seDBR56CQBJKbkerSSHbD5Q/LfnkYuDSBVlcKS1326aObJaI/nFDHmnmVmQNWAVqa8DEo8UaqT4zcH/RSfW8r7TEPXqIs3gXUqFCu+OjglsoqFg3D4UyVba7Mrlj+OnNDJzONyhSuNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3Csm93D2XHvDyNhY2UuS2vhTGfCQndJxxhUS62b/S4=;
 b=ysVvU4C/J00186uJD3aQrPIYSkdWLTm7VAApRUPidhJ37QMAYgJdbRrDKSzpcTbS7ZY55mRHWxRIen+NNcRRhIBaZxt9PACWqUnli/fzEFxflopfs8Wp0+i9PYnAdPFCUKNspCLTSxiVi1Zfl9h0YYsEF/MnaMFmVK0QO9m2kfE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 02:46:30 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Thu, 17 Jul 2025
 02:46:30 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
Thread-Index: AQHb8q3/nm1gXMxGl0GXuYOfxGKnCrQ0K78AgABInqCAAHBdAIAAvgyA
Date: Thu, 17 Jul 2025 02:46:30 +0000
Message-ID: <DS7PR12MB600581BD4CA2CCBBDA9D090CFB51A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711215122.23288-1-alexander.deucher@amd.com>
 <20250711215122.23288-2-alexander.deucher@amd.com>
 <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
 <DS7PR12MB60058FF28CFE6FB8326A24E3FB56A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_P+PmesAQFRn+83cFjN5hADjH+LxSN0cmzQvQn6KUaXEA@mail.gmail.com>
In-Reply-To: <CADnq5_P+PmesAQFRn+83cFjN5hADjH+LxSN0cmzQvQn6KUaXEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-17T02:39:57.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6578:EE_
x-ms-office365-filtering-correlation-id: 0f44e9ed-2c28-40fc-22ef-08ddc4dc2249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVN0THpDN2VEeGdhWm5vendUdExnZ2xMa0xYQkR1ZkZwSmUvY0xUUzBNRjFi?=
 =?utf-8?B?MHBjVXRhOENxeWE4Vml6QWhpMGFHc2xWTkZwcWhjbk1UVFhLdmdnQXJHYU83?=
 =?utf-8?B?OUNPc0lDRUZLT1N2T3Uzc1dzMnhpOUsxYXROSHhaekcwUGVYK0tzQ3liNGJs?=
 =?utf-8?B?Tm1uNzVHQlRMczA4VHY4WE5JZWxtVGhaK0RyRWRORE9ZR09VVVE2N0t0QmtB?=
 =?utf-8?B?dDkvZUZRMUx3aHFXOGxoeVVwK2xHcXJKM1RTbHIyODVvbzRFdnNpbWI4dS9R?=
 =?utf-8?B?aDZxYXU5SHFEUkc5c0JWQWlKc0sxL2ZiaFdmbE1DN0VXdXZvNFQ4YW5vZTU5?=
 =?utf-8?B?cDF3Lzc2WlpXZ1k4SG5VWWpuVmtONytqdW9sajBPSnpubW1pTFRzWnB5Tm9Y?=
 =?utf-8?B?cEZXcFo5M2NQeGNoUUtXcGJhR1dVSURQd1o3dlBIaGN6bkRFc1ZwRElqd2JZ?=
 =?utf-8?B?R3VzbHNqeEwzWHVvbGE1Ty9icHk1d2g1K3FXcFkwdTR3MlkzTk8yK3ZldzBE?=
 =?utf-8?B?cVQ4V0NsS1MwNlZMSnFjaDk1RHFsVm1pSnB0ZkMyb1R3bzEwUktjQ3R3YnJa?=
 =?utf-8?B?aFEwVWlvTjluTjhJOHg3bGlEem9PcUZvNk5ldlVRZ1RFbU1uNlVKTERxRmw0?=
 =?utf-8?B?Wjk0NmgrMHBkQkdQYll6aWRnS3ZmOXFaVWhkcVVJTlpDenlHMlBEa0xBKzNy?=
 =?utf-8?B?MGVIV2NpQ1UwMUQxajJGd0NHR2NFNjVDWWo0RWRpTENCeGxGTDkwb0JZRzJH?=
 =?utf-8?B?VmFFQzc1SFA5c3diSTlkMDVubFZHYmdWTTJrRWdaQkNta2N1U2pVTmNuMGIr?=
 =?utf-8?B?a2xvNDBWZ3U5d1RWRkh3WXUrMlZrYUF4N0RnY3Jpd2xHYUtRRE9PU3h1OFlh?=
 =?utf-8?B?M1ZOSTFIK0FnNmNDY0RrdTBZNy90emhiRTA0UGtMYXBIdEVOV0ZlWUw0NlVG?=
 =?utf-8?B?ZHBDeEVHbHVBYTUxcHBhWGtEQnZVZkxuMFRMaC9pK2MxeVlZUXBpdDg3WjEw?=
 =?utf-8?B?cWZ4cnRlUHh6K21VVndYNFI3TmJjS1dZWVJ4a1N1anpncVFsUUNBNFc0Q3RP?=
 =?utf-8?B?WXVsdWl2QU5Vd1pXcFFUUWxVRmJ4YU1rbUIwVGFXOHpkcXF6SUpWS2FaUTNE?=
 =?utf-8?B?VFBqL2pLUGtOcWVEZTBxSFdzY0Nyc0cwZzFOZ1Q5b1R6Rjdad2MyWGNjS2NP?=
 =?utf-8?B?cEpraVFNdWJCeGZ1MGNRN2VpUlhTT3lNbml4YTdQVUp0ZGhVSUtubU4reWVQ?=
 =?utf-8?B?YVVrYzRjMzZwZWFaeTV0Z2pWckc1K1ZhSXY3cXRXY3F2QnVKSEtVejJDKzB2?=
 =?utf-8?B?Q0tvTHpwUXFMT2FjVlppbGRKQTZ6RWtCc0hZWjlKQXZHdG1wYjhWTWI3bDJj?=
 =?utf-8?B?dHBUSFZFazhqWVRYb014NXNGRFdXd0pkOHFubGpMNDVjazB6S0hhU08xTkNa?=
 =?utf-8?B?c1U1bG52bDRibC94WWdvRVp6ZDNBejNQN0cyeFNrOGdCNHB2QmlOcVZYOUlK?=
 =?utf-8?B?Q2NMNEhLTWJjS2w0dTE1NGxJcXp4OFFFcjdscUhVUWR3K0pWZzJDMnFja3Fa?=
 =?utf-8?B?WGtSWWJoZWVTRVZ4bVVoWmhURTNYTEttdGtIZ0MwQlQyTWxoYVdkdzdoZlJO?=
 =?utf-8?B?VnVQQlVBUCttY0VLQWdSWU9qSXZDRldNRmcxMU5TNHN1T1hHeXd6blRDcTNQ?=
 =?utf-8?B?MTF4bjNMV2pUeVpTM2lySDlqNGhLWW5zVExxVk9uSVl5dnRQRFVnL3dMQlhk?=
 =?utf-8?B?eThGL3VOM1A0QkY1WDg2aERTZmpDS0ZFRXpMeXJ2WEZFQmIwaWFOTURjT3ph?=
 =?utf-8?B?RDgzTTF5VkZlQUd0UndKVXZWWkNJQmgwVE5hUFFHTjhPRUF2WFdBWDBYWjF5?=
 =?utf-8?B?cjF1eWZ0dldzNXNNdXA2NGNHVDQ3L2tyRXExcFQwZ3ZqT2JWUUZzY3B2bTJL?=
 =?utf-8?B?czFvdjZua2cyaFVhaHVFZ1lZR3Y2ZGtNNjlUU2hVTzE0elNBNFBoci9PRGdB?=
 =?utf-8?B?UlRiUElTYVFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjdlcjR5ay9wdkpSZnY2bUFUa0NIck9SMWZhc1dwZHRNOTA2QlVRUlBHYkJt?=
 =?utf-8?B?VWZXcUJFeGhSUlpyVFZBd21YWUhLMmlNd1FyV0pBY1k4b2J1S05XK0EzYWZY?=
 =?utf-8?B?MXErM2VrRUd1TC91RitpamloY0lraHlvemJyYVZjWGRFcjZiRzJTaDFkVzB4?=
 =?utf-8?B?bzNuNVRjZVRzNk1OeERUOEZvUElUdHpiYU1hemVFZ2NCUzdqKzB4eDQwV0JQ?=
 =?utf-8?B?ajYrUDJkVGUvdnRwNHVqUkhTNXhTMHB1MDBXVkMrRHkyRVV4ZFBMS05kNHJG?=
 =?utf-8?B?WXlJTmNzSmJvTTJVa2luT2lVSVRWTFViT0xLSnIyaU5GOEhleHVhZUlra3Rw?=
 =?utf-8?B?SWt5Qy9xVU8yeitIVDB4U2xzcWZXbndVSWdKR0VwTzl4NDJ6Wms2dnFYdHlT?=
 =?utf-8?B?dXFWZnYyWVlpeVg3ZElBZEV5OXUvQTZMK0FmQ3R0bkJ4YVpWMnZrQlVRRnov?=
 =?utf-8?B?SGlIMG5NMXRkbjVIR2tQZUR5cno5RXVFanQ2a3B1dzVtR2ExSDlEUWdwMTdO?=
 =?utf-8?B?OVZkRnFrNWgvV21QSFk4NmFIVFpCUHZCeUx1TGxWbmxFZ3IvMTJyb1F6RTBt?=
 =?utf-8?B?NFRHWDMxN1pTWmIwenprRjVXTUI4N0hjby91NHppdTE2cVpzT3NvL2dSeHg2?=
 =?utf-8?B?RWZ1bGF5N1NTaTJMdXdZRWNlQXpHTGNOQUg5TTFoL1hBMnVoQTdzV2FvTEhH?=
 =?utf-8?B?SjFtY3NNT09oL3J6SWIvRWFWYTdjcEw2eU1kSUpyTlc0akVnWUZLbGdlRXIr?=
 =?utf-8?B?d05oTG5xWW8xZ2ZuUXVROEdnQmVDaW5RcnNwdkdSWHNRQzR0UFRjbkRVMHVa?=
 =?utf-8?B?SjFZN0p3andIQ0FPTCtackdjbjdBcDNEalpnblFha0VrU20xQVJxdTdWS0pP?=
 =?utf-8?B?bkdzVXBwUHZkaDZGSlZBbHc5QjBkM1pFMklYdllDbGpVZ1JCcGwyZ1dlQzJK?=
 =?utf-8?B?UXJkTzdoWCtBejMvaS93d3dteEdkcHhoazA1T1lJZXJCS1hzSjZzQVgzbEwx?=
 =?utf-8?B?ZDBaUkRsekhIbEE3eHlDeW5xMW16MDFkZWFORzNtTzkxYnRURmRDWmNNTlll?=
 =?utf-8?B?eGRVL3AxS2lEY1lvSThiczlaaU93amdHSWsvTmNaand0UGw0aEJydktCVmxJ?=
 =?utf-8?B?b1dLSDZ0bHAxN0ZMNEtIK0JQbE13SHppaE5tM29GNmVDdWhoTnlQdDhFZk53?=
 =?utf-8?B?NmRMOGU0a2RFTnp1RU92UEJTY3hFUTh0L1JKcU0zbzMvUVpGcjdPbkxtcDVw?=
 =?utf-8?B?U3oydXV2QXM1RkMzZitjcDJkS0hoYjA1bEk2Y0I2NEhpbk9NeXBycjBTWXE1?=
 =?utf-8?B?R09tRXVsQWRmQTFsOU5FUFlsZWdWVEN0bDkrQU9pR2RQaVdtd3p5WWcwaHA1?=
 =?utf-8?B?S0xWZHpUZExGcHVRUW0vZk9ZenQvY29tRUZmV2c3ZnBGekF0K0tsK080ZmRV?=
 =?utf-8?B?Y2NtYzVZTUprU3BvR2ZOSVBaV0oyUVEyQXpzZEVYeUlaUzBLRW5FL2JaM3Nn?=
 =?utf-8?B?bE9iaTVFMDlVNWlLUU0rNUdDQTBoMU12TmhkOTA0OHB6Q3FuM0ZrdmJMejgz?=
 =?utf-8?B?OUU1TzhJNkFKYkJDZ2tGWVlOV2U5ditobWl6WEpiZUVwNzlJa2V2MXU1cWpv?=
 =?utf-8?B?VEZPQzA2bjREUHlmZ1RNNkxaNmNKUzB6Z3l3WXdtZlJyOVB2MlNMVmNzU040?=
 =?utf-8?B?OTNBZkY2cnZ3RGgvSVB4ZS9HNjY5a1U3QjA1S1pacmdlNjdCdHZXOWJXaU1D?=
 =?utf-8?B?Sk4xS1M3MGRtSWp0d2lGVnVHalBpV2U3YUFRQUJzUlc1NW00bE82Y0RGUDd4?=
 =?utf-8?B?UkRBSHpzbWs2bEt1Zkd1VDNaVjJPNlp1UXlQVm5WRndkS2ZmOWk4K01UcHFz?=
 =?utf-8?B?T3RtN21KcHBVYjlNcVYxUnE2Y2hRVko0K2MzMnhTQndRYkM2WlVsbi9kUW01?=
 =?utf-8?B?M1hlLzZnTVZ6NHFDMnZzOEo4WUZxTEhQcVJJSTNidXBuSGdtTWlkM09ieXAr?=
 =?utf-8?B?SzZZVTEweWYxK1BRN0l3eG80SXF3LzFTZ2d5ZHBqMGhFdXdLbnl4dWxUL2Nz?=
 =?utf-8?B?YXpDYzVGR2tmc3BERnl3UWN4Uk9oTm1qWGlwMkdNbTMvUVYxcXJ4MXB4ZVNN?=
 =?utf-8?Q?8MCE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f44e9ed-2c28-40fc-22ef-08ddc4dc2249
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 02:46:30.3234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGR2uhr0dnGVCBGVLJW2Pe/cb3i/rZX0+qMJM3Rs1CZ92W4hiN2gs06avHapxzeg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxNiwgMjAyNSAxMToyMCBQTQ0KPiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogTGF6YXIsIExpam8gPExpam8uTGF6YXJA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbg0KPiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gZHJt
L2FtZGdwdS9nZngxMTogc2V0IE1RRCBhcyBhcHByaW9wcmlhdGUgZm9yIHF1ZXVlIHByaXYNCj4N
Cj4gT24gV2VkLCBKdWwgMTYsIDIwMjUgYXQgNTo1OOKAr0FNIExpYW5nLCBQcmlrZSA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gUmVnYXJk
cywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4gT24gQmVoYWxmIE9mDQo+ID4gPiBMYXphciwgTGlqbw0KPiA+ID4gU2VudDogV2VkbmVz
ZGF5LCBKdWx5IDE2LCAyMDI1IDEyOjE4IFBNDQo+ID4gPiBUbzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLQ0KPiA+ID4gZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+ID4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gZHJtL2FtZGdwdS9nZngx
MTogc2V0IE1RRCBhcyBhcHByaW9wcmlhdGUNCj4gPiA+IGZvciBxdWV1ZSBwcml2DQo+ID4gPg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiBPbiA3LzEyLzIwMjUgMzoyMSBBTSwgQWxleCBEZXVjaGVyIHdy
b3RlOg0KPiA+ID4gPiBTZXQgdGhlIE1RRCBhcyBhcHByb3ByaWF0ZSBmb3IgdGhlIHF1ZXVlIHBy
aXYgc3RhdGUuDQo+ID4gPiA+DQo+ID4gPiA+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyB8IDggKysrKysrLS0NCj4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
PiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djExXzAuYw0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5j
DQo+ID4gPiA+IGluZGV4IDM3ZGNlYzJkMDc4NDEuLmI5YmE4YjIyYTEwNzMgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gPiA+IEBA
IC00MTI0LDYgKzQxMjQsOCBAQCBzdGF0aWMgaW50IGdmeF92MTFfMF9nZnhfbXFkX2luaXQoc3Ry
dWN0DQo+ID4gPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHZvaWQgKm0sICAjZW5kaWYNCj4gPiA+
ID4gICAgIGlmIChwcm9wLT50bXpfcXVldWUpDQo+ID4gPiA+ICAgICAgICAgICAgIHRtcCA9IFJF
R19TRVRfRklFTEQodG1wLCBDUF9HRlhfSFFEX0NOVEwsIFRNWl9NQVRDSCwNCj4gPiA+IDEpOw0K
PiA+ID4gPiArICAgaWYgKCFwcm9wLT5wcml2X3F1ZXVlKQ0KPiA+ID4gPiArICAgICAgICAgICB0
bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfR0ZYX0hRRF9DTlRMLA0KPiA+ID4gUkJfTk9OX1BS
SVYsIDEpOw0KPiA+ID4gPiAgICAgbXFkLT5jcF9nZnhfaHFkX2NudGwgPSB0bXA7DQo+ID4gPiA+
DQo+ID4gPiA+ICAgICAvKiBzZXQgdXAgY3BfZG9vcmJlbGxfY29udHJvbCAqLyBAQCAtNDI3Niw4
ICs0Mjc4LDEwIEBAIHN0YXRpYw0KPiA+ID4gPiBpbnQgZ2Z4X3YxMV8wX2NvbXB1dGVfbXFkX2lu
aXQoc3RydWN0DQo+ID4gPiBhbWRncHVfZGV2aWNlICphZGV2LCB2b2lkICptLA0KPiA+ID4gPiAg
ICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QUV9DT05UUk9MLA0KPiA+ID4gVU5P
UkRfRElTUEFUQ0gsIDEpOw0KPiA+ID4gPiAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQ
X0hRRF9QUV9DT05UUk9MLA0KPiA+ID4gVFVOTkVMX0RJU1BBVENILA0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBwcm9wLT5hbGxvd190dW5uZWxpbmcpOw0KPiA+ID4gPiAtICAgdG1w
ID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QUV9DT05UUk9MLCBQUklWX1NUQVRFLCAxKTsN
Cj4gPiA+ID4gLSAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUFFfQ09OVFJPTCwg
S01EX1FVRVVFLA0KPiAxKTsNCj4gPiA+ID4gKyAgIGlmIChwcm9wLT5wcml2X3F1ZXVlKSB7DQo+
ID4gPiA+ICsgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUFFfQ09O
VFJPTCwNCj4gPiA+IFBSSVZfU1RBVEUsIDEpOw0KPiA+ID4gPiArICAgICAgICAgICB0bXAgPSBS
RUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsDQo+ID4gPiBLTURfUVVFVUUsIDEp
Ow0KPiA+ID4gPiArICAgfQ0KPiA+ID4NCj4gPiA+IEFzIHBlciBhYm92ZSBsb2dpYywgb25seSBr
ZXJuZWwgbW9kZSBxdWV1ZXMgYXJlIHN1cHBvc2VkIHRvIGJlDQo+ID4gPiBwcml2aWxlZ2VkLiBJ
ZiBzbywgd291bGQgc3VnZ2VzdCByZW5hbWluZyB0aGUgZmxhZyB0byBrZXJuZWxfcQ0KPiA+IEFj
Y29yZGluZyB0byB0aGUgQ1AgZ3V5cywgdGhlIHByaXZpbGVnZWQgYml0IGNhbiBiZSBhcHBsaWVk
IGJvdGggdGhlIHVzZXIgcXVldWUNCj4gYW5kIGtlcm5lbCBxdWV1ZS4gU28sIHdlIG1heSBkb24n
dCBib3VuZCB0aGUgcHJpdmlsZWdlZCBxdWV1ZSB0byB0aGUga2VybmVsIHF1ZXVlLg0KPiA+IE1l
YW53aGlsZSwgdGhlIEtNRF9RVUVVRSBiaXQgbWF5IG9ubHkgc2V0IGZvciB0aGUga2VybmVsIHF1
ZXVlIG9ubHkgZW5hYmxlZA0KPiBjYXNlLg0KPg0KPiBJIHRoaW5rIHdlIHdhbnQgUFJJVl9TVEFU
RSBmb3Igb25seSBrZXJuZWwgcXVldWVzLiAgV2h5IHdvdWxkIHlvdSB3YW50IGl0IGZvcg0KPiB1
c2VyIHF1ZXVlcz8NCklmIHRoZSB1c2VyIHF1ZXVlIG9ubHkgbGltaXRzIHRvIGJlIG5vbmUgcHJp
dmlsZWdlZCwgdGhlbiB0aGF0IHdpbGwgbGltaXQgdGhlIHVzZXIgcXVldWUgc29tZSBraW5kIG9m
IHNjaGVkdWxpbmcgY2FwYWJpbGl0eS4gQWxzbywgaXQgc2VlbXMgdGhpcyByZWdpc3RlciBiaXQg
bWF5IG5vdCBiZSBhbGxvd2VkIHRvIHRvdWNoIGhlcmUgaWYgd2Ugd2FudCB0byBhdm9pZCB0aGUg
d3JvbmcgcHJpdmlsZWdlcyBzZXR0aW5nIG9uIHRoZSB1c2VyIHF1ZXVlLiBJIHdpbGwgY2hlY2sg
dGhvc2UgcXVlc3Rpb25zIHdpdGggSFcgdGVhbSBsYXRlci4NCg0KPiBBbGV4DQo+DQo+ID4NCj4g
PiA+IFRoYW5rcywNCj4gPiA+IExpam8NCj4gPiA+DQo+ID4gPiA+ICAgICBpZiAocHJvcC0+dG16
X3F1ZXVlKQ0KPiA+ID4gPiAgICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1Bf
SFFEX1BRX0NPTlRST0wsIFRNWiwgMSk7DQo+ID4gPiA+ICAgICBtcWQtPmNwX2hxZF9wcV9jb250
cm9sID0gdG1wOw0KPiA+DQo=
