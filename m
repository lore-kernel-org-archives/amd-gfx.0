Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F496CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 13:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB5710E44B;
	Mon, 18 Aug 2025 13:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwM5qF3n";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CE410E44B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 13:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY5UONJvD8sdTUAfO/LItoulg960uvSEXTFoY69Qae4IOZ2/y7p2bZpvtzr5ESjvtqHSduRtSZLJzPfMdNNUIxNYM/5/v3tTdNX7ejTh40CmHtS26E/Jo89DPoBBlMnXV43SzpyJCY7O0dxH+Iffe3Oqf8RybNWffGTUa4JZZbu6x/6d16gL9xLsJLL1Z1XFMiR69ecfinvk3HQfzNiR8ABu9FZiWJmiGsx9wbaFd6JwX3aFmO2XZfX6fIqizUc+A91s6pRtc0qcYtapVg+owdyE7Paq6XVzdfZMRIMAUqc5tnxCF84m/wQ279B6QFxR6VODRgGV3nnmZ1ZI54Y05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j3fmxoRH4rqxJ4ErQbQ00N8xSYY641UYTrgs9OwptU=;
 b=QqOK2qhx5OKweqNFhaBBwm6rQ9VaZV29teqU4uusDVixXMcFhtWGh+KlJJ6yyCksfsB93Mpv2uCUntAhS+pIX5G1qGn4LQHtjIeIqnpXCQSpYtUm2yUgk+g6Q3MvOmALzjyMjyNSSVa+Bgon/6pTEyQtLIHNXC+8z/tCiRG+PV4d+I5izmeX8ddcuAFRRmDIv8AvVx6CVc7T7GG2LPXKaU2roecajXYa8RBD6eaZCG+5s4lmsMtba1bie/HT5FMFKgt7Gq5NgV5PQI5cJg4cxNlsuNPFWd05kjbfj86CjrkLcmn+EM2w51ypp3SgiDWOERfKyC0uSXYed3UC5BwuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j3fmxoRH4rqxJ4ErQbQ00N8xSYY641UYTrgs9OwptU=;
 b=LwM5qF3nGXDCp+/Zt5uMGklX01erUPW95iGMMPrdArf1TSrDsJdCQU8sJFdaO16rjdXFeM76hLyNq/lNfL9/dnOYxuHuDq/uLPFA6xI1+AGWuRzYPfdGVgGT/0/vJiVU8ACjmtc6xx3ziUmnfLQDNepqXnFox96Eh0Yv9mrjuT8=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 18 Aug
 2025 13:53:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 13:53:16 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "StDenis,
 Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: print root PD address in PDE format
 instead of GPU
Thread-Topic: [PATCH 3/3] drm/amdgpu: print root PD address in PDE format
 instead of GPU
Thread-Index: AQHcEEbHJ8gFY1LdfEufZsZEC0sGorRobV8AgAAA6uA=
Date: Mon, 18 Aug 2025 13:53:16 +0000
Message-ID: <BL1PR12MB5753B01FE36306A1DD5AEB749331A@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250818134822.1927480-1-sunil.khatri@amd.com>
 <CADnq5_P9_W=nqO1ETcprD8VjTkw21oGDAhHaMFzXSbcEO0OJ2g@mail.gmail.com>
In-Reply-To: <CADnq5_P9_W=nqO1ETcprD8VjTkw21oGDAhHaMFzXSbcEO0OJ2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-18T13:53:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|PH7PR12MB7139:EE_
x-ms-office365-filtering-correlation-id: 224a1a6c-41a8-459c-a4c8-08ddde5e94f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEs2SmpqaXVvRDVrMHE2dGoza3J3M1N5L0FZOHdJeWxmVEVybDM3ZFVuc0xy?=
 =?utf-8?B?U2xoYnNrWXhhN1pFZEM5am5iT01nNUozQ0FPMVhWSHJiVWN6S0pjeGhlWlhk?=
 =?utf-8?B?VFdpcHdjM2VOMWlTTWpGdHlnWVVKWUpmdTVQbnoxRi9MZFNjMXMvQXdtRFJC?=
 =?utf-8?B?WXVKcHdpQmZ2a2c2WjhDMmxmTGtPclFvbndoWjdqdEhBV2hwWVNxQ0djVXd0?=
 =?utf-8?B?RGdZVWdnY1ZNeGlZQ24wRU5vUWpSNjRrOTFoQVpLZ2hjaVlCVkYveTlVejZC?=
 =?utf-8?B?QjZwL2NOajVNc2p6WXNKNlNWbTA2WEI0N2ZMNkszS2xqN203aUJSRGFsM0Ix?=
 =?utf-8?B?akw0ekRGbnFyZHVBTnE5S3JoaXQ0Q0JDaFFjd0tDbUVUd0tWZ0Jzelc1M3I2?=
 =?utf-8?B?eS91eFVhYVlMU0lhczl1MExGSW1iVGNYOG1ZSDJweWY5REJwSlB4K25uY2xi?=
 =?utf-8?B?L0hTeWFuQnJMaFhhbXBLREFWdlVVMERFVG96WTgwVEw3d1lmYkJJNFJMWnkz?=
 =?utf-8?B?TXI0dW1JMUVnQlg1UTczQng3SzBDd3dvU2pMY0JtQ09WL2RDTExYK3djTnV5?=
 =?utf-8?B?dEIzSG9ZVWludy8xVWs4Q2dCZ0xzdG5zNHVld0Y4OWpiSitHSDdmUWxkWDFx?=
 =?utf-8?B?WUROYkFKSWRHckdsMHNtY0FsWGtjTG42VFBLcndCUjB1TzdiL0FKbEt6blhp?=
 =?utf-8?B?bnV2YTZVcGZVWis2K1ZweE1zV0hBbCs2QkkydndvdHRUd3RLaGhmeGxQUzZM?=
 =?utf-8?B?SzhCbHh3ekJFS3Byclk5ZTBkMGJUVGcxWG8xWWRMd0d5d0RLbUtIcE9wVzRQ?=
 =?utf-8?B?RTVQRE9hbFBYaTdOQVVhRnJDcHZLbUU0azZ4Q1BiL2dFTXlVdGNTNEpzY3pU?=
 =?utf-8?B?UWdIa0JEamxDdGx4dUs0aHBkV3lxUEZBZlMxSmxKclJzTjFOY1dCQ1BxNnU3?=
 =?utf-8?B?S2NVV2lobDlPZG1WNjFoZjBxSENkMXV6OHg1cEIvdHVvZ0ljampWWDkzV3hu?=
 =?utf-8?B?RHFaY3ZzczliMWVPRVpGdW1pd203TFRnL05OS3ovdlZoNjJkZzNiT0FrMmNr?=
 =?utf-8?B?eG5xL2JJV2pqcFJxaXI4Y0ZrYmVFenN4aFVPUlJPdlFLL004MGZkcHVSTDVi?=
 =?utf-8?B?Q2hDRUU5dGd1Nng5WGV5NU5HODdVNTlGc29EVzJnc2wzcG5vdWhQZEdPeWRO?=
 =?utf-8?B?Z0pCek9VOXdmaC9hbTk2TjkydFhCbDV0RUdab2JUbVhKQWJwWG5uSFQ2aVY3?=
 =?utf-8?B?REg4Q1NpbFE4OHpvcndPTFIxZGtxRy95R2c4T2hsUFV3aUt4Zm1tRGRObWZn?=
 =?utf-8?B?ckxpZ2xOMDl0dFU5QldoaEJvYmN6RitYNkxCejRVRGFQcnh5eXlpb01HYTY4?=
 =?utf-8?B?NHk1dDhyRlA0UHVjaGtWb0FmMHBwZG9qS2t5aEo0Ym5HZ3JuNXhTdFR5Qkgv?=
 =?utf-8?B?YytUMnZ5a1FIMGRDMkR2UUVsRG1KaGdhR2VQamRBdWdRL05yekF3MXdIY2U1?=
 =?utf-8?B?aFN4Qm1aMGc1T3ptZFpJWlhvcEFJQTkxSWwrQmxQN2hXTHdZZXozeU5Oa3A3?=
 =?utf-8?B?VFJLN1V4QlplandFSXMyV0c3TDY5Q0pkWnkyNTRjSjh2Mnh4MkVzVXhsclVi?=
 =?utf-8?B?alUrbjBRcHdSUWQrY01Fa1VSbmFiRlEzY3hKMFhyK2lJNHdNM2pydGowYXVi?=
 =?utf-8?B?dkkzY1l5Q0gxVE5rem92alpjWk5YeVBZbnNxZDE2SGtTcjZadU1GeTUrSlJ1?=
 =?utf-8?B?L0tndWp0ak1LK1psSDd5T2NtbVlBM0VKdDNkdVp5M3lqbmJnWGlCclBZQjMx?=
 =?utf-8?B?UzVlTTdsRFRSdExUcy9pWkl4Z05Lb0pxZXZaRTY1eFF0ME5WbEJ6YlIvQmh2?=
 =?utf-8?B?cC81YTF4KytWMmVLRnEvc2pwUDZsR0g2bWFHMW9PNXcvekN0cENDV2F5SU43?=
 =?utf-8?B?VGEvclNqNHo4czJ1ZkpXazRIM0FCOFFDdTA2aWIvN3h3Mnk3dEROSWF6MzRw?=
 =?utf-8?B?VEdGbUJkZWp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnV1SlpBY2lUY2hMY0N0WTRyeEdQanRoY3dWczFwamtqZ29BZFRnbitaeDNI?=
 =?utf-8?B?bUFwU3REWE0zYmZwcnV4d3NUT2diSmdOeTBzN1lCS2ppL1Z3eWpVRnMwZVlu?=
 =?utf-8?B?eVZ1K3RNMWg2UGl6TjJHcHVmckFiZ3BqUE9TSk5kbWFDV2RVZ2xDYmxHWkRa?=
 =?utf-8?B?KzRENzJZWm94YnFSMlBhRklSOWZZYThxOGtKQ1pzQnlCb3BoQmJ2OElMV3Qw?=
 =?utf-8?B?dmFXeWNqQ25UamtSOThmUnpES3FiTXhnR0dYaTVpVTczMFFUUXlyWmt1RE9W?=
 =?utf-8?B?OXdzY295Zmhid28rVTRTTEl0VkxLSThWUUtaeUhNc3pjSTJwN2R2SzRSVlYw?=
 =?utf-8?B?S043NUxjeENLZklKZlJXeGRMWDJvT09UUm45OWdEU0FUQVlic1AwZFZEckRW?=
 =?utf-8?B?Z0hvKy9rZlcyR09QRkkvM2JGeXNZV0UzRDV3eEZjZ0JWbU52amQ1ZlFqOVJy?=
 =?utf-8?B?VWlXUEtYQUs3NWRiOEFJWm12emprM2F0cUdUL3Q5dUxaWVFCZ0I4ejBPTW5y?=
 =?utf-8?B?L3BhYkE1NDluOVhqN1dqN1piL3JVZVRXajJ0a01VTklBZ1hyWlVadWRYdHFz?=
 =?utf-8?B?QlhJcG1PblFHRlMyZERrN0haNlorZnRsMHdlRHdubXBBYW5zenYzRlVzZC8z?=
 =?utf-8?B?dkZjMXkzTmRuTWZCdzNOaURtZTVPSnIrcm9vdjVsci9oQ2xIeHlEaDJTNlZB?=
 =?utf-8?B?VjNmT1gzMnoxSHpZbDVYY0xJWCtNdldxQUV0MVdweGNrZ1U4TVJlakczaXZi?=
 =?utf-8?B?OTNQc2ZzVkFHekdFTjJKdTJ3NmRaWWpGd09vbnFlSUxKcHNCVFZuOE9VNUZI?=
 =?utf-8?B?dUczZ0s5Ym9yYU10MlI2RkNIRGloSW42dVV2WXNrOEpzN1hTT0dOak5qSm02?=
 =?utf-8?B?dTNNSlFySHRoK1NNaWJMVWlVUDRKVk9PUllBbEE5ZE1COE50UWdNWmFkdUZs?=
 =?utf-8?B?T2Y2SEVzbW5Ob3crL0s4eTJ2Y3JkU1F3a2FWUSt6eHI3S3RQeFFJQWVmZG05?=
 =?utf-8?B?R0c2WW55SGR6S0F0LzMzTWJSM3hUNVBTWDd0NEZxc2FlRFdtSkRvQ1phMFd0?=
 =?utf-8?B?Q3lRVGpZTUZCWEhrL3NDVGozZWNaNTRWZ1lPSjkzSFVZazAvZFIzaW56RFpM?=
 =?utf-8?B?cnFTTlNEdGVTRG41MzF6R2pFUUlrY0pmT0hDdXZwMEprVkpZcStta0ZFZ2hv?=
 =?utf-8?B?TXg1MGRPSXJLZzhiYlZqYUdhQUxoVUVOOTd4cDhPNEpGRndnM2ZqNjcrOHhj?=
 =?utf-8?B?RGN5a09ZK1NKaUtjV3NRa2ZyYmNncW1kSCtndU5HaFMxVVNUSTJRdGZSbVpF?=
 =?utf-8?B?NnBHaUpCeFBUODdQOUVnT1RlSEdFeTdYUmFLaWRhaWxGRlM5djVvRk5lU0Q4?=
 =?utf-8?B?QlVXaWZEeVo0bG9BS1dKdWNwU1hTR0JUclNodGhwbGsyRzQ5WC9KTGpITnpY?=
 =?utf-8?B?cUVPYkFnQURWU1NsbmRZaWRweUZmL3BqTmc2Nmd0NjF2c1hXNjRlSC83R2xN?=
 =?utf-8?B?WXlpNURHNFMrWFducnlaY09ZVXpwK0x1MzV4WWNGZ3I5RWRJS2ZBZmNLWUZ4?=
 =?utf-8?B?R2tKOHg0SW94WFc2WFNtOFVPOVhibm4xZVpLamFhd1drZzFOOXpxUXN1dUxV?=
 =?utf-8?B?REU2NFQ1QWdHUk1RWmtiOXp5L0RLQXRwZCtzazVuL2JZZFkyRFhZQzliRnBx?=
 =?utf-8?B?bDRyQVhKVEdNNTdobXkzWG55eGxxNFF5WHVkeWRkNjh5cVR1ODIreHAva2VY?=
 =?utf-8?B?Y0lweTBUWE5EV3BWWTROazNyZXQ5NGZUcVhPaTJpRUpwTTlyaDlVR3QvZHkx?=
 =?utf-8?B?ZWdaMFRVeTRSMDlKQ25IcmYxQmpMajFVS28yalR5b1Jmbng3V1IrSFNpVWI1?=
 =?utf-8?B?ZTRraFJickM3TUFjWGp0enlwOVBJdTl3TFprQXRNTWlONVBWYkZtTjBnLzZL?=
 =?utf-8?B?QmUvZno3R2ZMSDNSaHNtNkI3bUFlOCtybm5ZTnRTMm5oRU1LVkV4R3pHMmJl?=
 =?utf-8?B?RzJObXcyMXNET3ROTDFNOXZtUmVYZnEreDZET0N0TnhwK2N5U0U5K3RFQ2Zv?=
 =?utf-8?B?UHNYWWZLR085RlZ5azU5TFlaZmZOdWtOYXU3WWkrVXBJbDBWc2F0QkpqeHBK?=
 =?utf-8?Q?NqyI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224a1a6c-41a8-459c-a4c8-08ddde5e94f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 13:53:16.3356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIcMZbC3r6LwBPFJpQwvtGtn0iNA1r7JQnG1tXn9jEwsJfIRHN/9WFeObD1mJSk+Xx90w9CfIiURzf5m5FiGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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
Cg0KU3VyZSBBbGV4Lg0KDQpUaGFua3MNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBB
dWd1c3QgMTgsIDIwMjUgNzoyMCBQTQ0KVG86IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBh
bWQuY29tPg0KQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU3REZW5pcywgVG9tIDxUb20uU3REZW5p
c0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGRybS9hbWRncHU6IHByaW50IHJv
b3QgUEQgYWRkcmVzcyBpbiBQREUgZm9ybWF0IGluc3RlYWQgb2YgR1BVDQoNCk9uIE1vbiwgQXVn
IDE4LCAyMDI1IGF0IDk6NDjigK9BTSBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29t
PiB3cm90ZToNCj4NCj4gUHJpbnQgUEQgYWRkcmVzcyBvZiBWTSByb290IGluc3RlYWQgb2YgR1BV
IGFkZHJlc3MgaW4gdGhlIGRlYnVnZnMuDQo+IE9uIG1vZGVybiBHUFUncyB0aGlzIGlzIHdoYXQg
VU1SIHRvb2wgZXhwZWN0cyBpbiB0aGUgcmVnaXN0ZXJzIGFzDQo+IHdlbGwuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQoNClBsZWFzZSBh
ZGQgYSBGaXhlcyB0YWcuICBXaXRoIHRoYXQgZml4ZWQ6DQpSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gaW5kZXggMTI3MDkxZGUwZjM0Li5hNzA2
NTEwNTBhY2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
YnVnZnMuYw0KPiBAQCAtMjE1NSw3ICsyMTU1LDcgQEAgc3RhdGljIGludCBhbWRncHVfcHRfaW5m
b19yZWFkKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdW51c2VkKQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgfQ0KPg0KPiAtICAgICAgIHNlcV9wcmludGYo
bSwgImdwdV9hZGRyZXNzOiAweCVsbHhcbiIsIGFtZGdwdV9ib19ncHVfb2Zmc2V0KGZwcml2LT52
bS5yb290LmJvKSk7DQo+ICsgICAgICAgc2VxX3ByaW50ZihtLCAicGRfYWRkcmVzczogMHglbGx4
XG4iLA0KPiArIGFtZGdwdV9nbWNfcGRfYWRkcihmcHJpdi0+dm0ucm9vdC5ibykpOw0KPiAgICAg
ICAgIHNlcV9wcmludGYobSwgIm1heF9wZm46IDB4JWxseFxuIiwgYWRldi0+dm1fbWFuYWdlci5t
YXhfcGZuKTsNCj4gICAgICAgICBzZXFfcHJpbnRmKG0sICJudW1fbGV2ZWw6IDB4JXhcbiIsIGFk
ZXYtPnZtX21hbmFnZXIubnVtX2xldmVsKTsNCj4gICAgICAgICBzZXFfcHJpbnRmKG0sICJibG9j
a19zaXplOiAweCV4XG4iLA0KPiBhZGV2LT52bV9tYW5hZ2VyLmJsb2NrX3NpemUpOw0KPiAtLQ0K
PiAyLjM0LjENCj4NCg==
