Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DB8CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 18:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FA210E82B;
	Wed, 22 Oct 2025 18:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrSCEHS0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6833A10E82B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 18:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuMInizqE3l+xaXqRJ+vpQJNXs33tij69m5E0BFDrDcdghyXVo/NeOrkQOqMGLl0ERTMFexARHNim8jTXfXHVn3NBySTCKjHM+7adQXe+J35rSXTtNodNErciE4K1AnPB0rH/r+5Qtx2tNR1jTWsLzvu1O6qfyC6Z7V8Gyy6dyKP03w1dKOLj8/vFLPDDhaUr0qB+IR4XFc9vBKzbk+nibERogCcZq1wQTtLlkikP4JjxXryTFVE9Ryi0IFxOmrUdtoJMVrCrXPxqtchulw+Mel+LTZhlMdjGZqqsd/vhh4+4AkaQ4ptP+RFZqM3zI4YWZ+C4odw+LiIZan6tEO9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Mx5h5llmDNbUSp+Tsvd6qT3sTQLkS956PgLYzznQVg=;
 b=D2cXASh7cRmZXhup2qnAbSmMgcNB/ulz7+XWs8Cs7Qz5FzRJZVDV7p70H+2L8Ske90mepsvN+88EfUiMdsD+/Iw5ZW9t7Xi9r9KzsZ/I9tLpbeHRpPkV9khgNi+LwmvjGVWZ146/GrztgtO27WFWytaI4+WtelYBsRwIO1RbxkkivOu6IsdUvNjvkf8nFeXDVsUge6S2qRAd23AONOSq/Ny5wAL6ms0+JYNDML7gWXA6tV0VRZk3nAROfMZPtQzft+nNAy/X1WfKC7fgwZeCAWlnBe6bZUa4yaj44EinE16GUxQABryyiC2sukdYgrlsvzyBRRhMezmwXO5bwlWwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Mx5h5llmDNbUSp+Tsvd6qT3sTQLkS956PgLYzznQVg=;
 b=WrSCEHS0WakPlU3cJt6lU5dc7oVBBDp+WGpYOEbITIjeZRZyygfYn/8Qozk+73G5KJBjOiyku+MX/Rvp+7sRUc8BOGcV1pcKsm8kEa5mJLa7V8yrcc91Wp+uGjZk7r1PnPb4185hNVYDNgercnQQFGFBopgv5PFerbXEEOIBsyk=
Received: from SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 18:27:38 +0000
Received: from SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::1f8f:b41c:5af0:e621]) by SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::1f8f:b41c:5af0:e621%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 18:27:38 +0000
From: "Pan, Ellen" <Yunru.Pan@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Make SR-IOV critical region checks
 overflow-safe
Thread-Topic: [PATCH] drm/amdgpu: Make SR-IOV critical region checks
 overflow-safe
Thread-Index: AQHcQ05B1jfF14tHLEW098SFZcrStrTOe79A
Date: Wed, 22 Oct 2025 18:27:38 +0000
Message-ID: <SA0PR12MB74628CF83DF35BFD10081AE1E9F3A@SA0PR12MB7462.namprd12.prod.outlook.com>
References: <20251022122009.237253-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251022122009.237253-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T18:25:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7462:EE_|DM4PR12MB6183:EE_
x-ms-office365-filtering-correlation-id: 96cde124-91ff-4279-3754-08de1198ae33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?TjNCQlg3WVV2N3Y5eUVDTHJzNW5WNVdvWTY3Rm0xMWd4VW5qa0VnelJ4NEND?=
 =?utf-8?B?YkxkdnZJaDNYVFh1anp5RTBmL2NqbHhZWGFVWUhmL0JlOS85S1RBbzNReSs3?=
 =?utf-8?B?Rmp1bFZEVDA2b2ZkKzFJSUl4akpKZzQ3d2c5QUc0dHBFSGxSRG9zLzYxT05h?=
 =?utf-8?B?aTlEYkkzR1N1MGJvNGxvdk5aRHArZHdBRFhqK1hwSnVONUFWMnNVQW9mK2pW?=
 =?utf-8?B?SUM2SWdlcEtCbmtzM0dLRlpHTmpmSy91V21FWGVOdk1KdFdXeGQ5N1Q2U1FN?=
 =?utf-8?B?V2lUeE0xalI1NjJMWk41V0xkR2V4Wnd0STUzelhnN2Z2V240OGU5RFo4b25Z?=
 =?utf-8?B?WG1JeGZ2Z2I1UFZaZTNQTVlEZWMwRTNVeU5mM1F3dGlTVDRRMDI0M1BNWFVK?=
 =?utf-8?B?K2x6WFRBd1RrVEtGSk42QXBrL1Qyc1dDVmh5QkFpR2JNaWdhcVNiM2p6UmNo?=
 =?utf-8?B?Y3hUaWkzU2tMNWthbHRDVW0ySFBDbnNOaTl4VWFBQ3JEMjJZOTBrdjJXWWhk?=
 =?utf-8?B?Nys1a0dENDlpZlUyQW00S0dqY2NjUzJicVJOdkhVY0JCOVBhZEVJcWFRU0Jm?=
 =?utf-8?B?eFBnejVUOWVabEJOWGVCQkVkeDhVRytsUjhTcEJQQ3l2SnR4LzVXQ0Q4djNZ?=
 =?utf-8?B?SERyaUR2M2tNeEkxMXBaQjliaHpQNm5PdmR6cGtnVUF2Z2FsUGF6c1hnOHdv?=
 =?utf-8?B?MkNEaExsOC9zNEJndGhML0gvUGc0SDlITzZHQnNvZU9hbzFnQ2NrUG9yOGtv?=
 =?utf-8?B?akJwcGFKY1ZoNzkvZkhwY3NXK3lOR242VWUzdVlZU1pCNVhOQ3BBbm5TNnAw?=
 =?utf-8?B?T01JQlJiMnJlYnU0ekZqMFFSTG5vVmE5L0cyb3liOVJnRHpLdjJtSTZEMXE4?=
 =?utf-8?B?emE0YjVjWmlNRk91bTBralF1clo0UjdRRXI5VVBWWWFMVjZPbjBhMndUL2ZP?=
 =?utf-8?B?ZWVMbE9NQ0h4VGhNcUhkMU1EcXBnRGFQOXRxSzVUUmVNQ3hkRGhId2xwUWNr?=
 =?utf-8?B?MHlaUndSKzVrZWtYRmVjT0pZb2MvMjNXWk93RHJhSjJFeWErc2NhazFMU1Nn?=
 =?utf-8?B?RnhLMnhIMmZlbldVU3I4cGx3RmxXYU9seVd5bDJ4TUZzN1R1cGJsQUYyZmpJ?=
 =?utf-8?B?QjQ4alhhSktjZ1VvTU50VGEwemtncUhXNTEzL3NBL1RCb0tmT0dqQlJhS1Ur?=
 =?utf-8?B?UmFuNHBFZnFoUW1BZXZESGNpTFd0WHBKd1BpbDFhZ28xQ2dONDZsdUIvRWpu?=
 =?utf-8?B?OXpzbkt1UmdkWkNkY085eC92ZEN5RlhkbDNGNU9yeisyZCsxa1g4eC9nckhS?=
 =?utf-8?B?MjZXSVhBSXpMS1Fubmx0ejFuTUtKOCtreHJtcENnQnd5T2RTK2lvYzA4TjZs?=
 =?utf-8?B?cmtFZElKeUNtMlR5T2hJdW5DVmlBaDl6Z1o1NEU1cW55Z08yMUtyY0x6c25V?=
 =?utf-8?B?aWFOY2hKZFpkR2VaYklCWmN0b01UTU9ZUW1pOWoyN0VwT2ZxaE1pbk1OUFNH?=
 =?utf-8?B?MWdxL05pbWVjdjh2MTY0a2Zpd2hDZkpZL2MrOXlFdnRyenBZV0ZHQlZLanJu?=
 =?utf-8?B?NThBd1kvYURTNXZQSC9WMUlDSmFKWUZDRkR3clFNYmMrRy9PK1JsZjVoV3Y2?=
 =?utf-8?B?WE8rSlQ3TkhNc1BuV05DazFiYjg5SFl1UzkzR1luaEJSWWF5aVp5MldoR3JC?=
 =?utf-8?B?c0ZTYVZRVEVSaEIrMHluQlgyWmZybldZcGtrdEQrZ3VKZzFzZFJaakxGTXdm?=
 =?utf-8?B?bW9UZ3VENE5saUNtKzc5Mk0zRm5VMktxTERhMmtMRjczMnJDb2hIaGpoaXdO?=
 =?utf-8?B?VXJhRlhjaklLZWVwSTluQXp4dlpqNEVteEtZQzdBaHJOemV3Y3NTUlh1bUUz?=
 =?utf-8?B?RjJZOWMzenNJZ3dsd2U4bjQ0eVdXR1pyaHFsME94WWNhMFVySmhVQ3BPYXp1?=
 =?utf-8?B?c1V5bWN3NFY0d1RnYVJiZ29URlJheTE5MDJ5aWlJWXc4a3VJNUVoRWdzck0x?=
 =?utf-8?B?cFErN1VNaVhlR0Z2djVGNDNjSFNsaFRTTUdteTdQZlVJVmw2VzNvRDJDVkJy?=
 =?utf-8?Q?TUP9Q4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3RFc1p1ci9INjZ1U1VVR0ZsendkcU9jdUUvdDE1eXlZeld6eXY3ZFJIVnNr?=
 =?utf-8?B?cHphSFc5QzIvS0plTjQyOEd1dUJONndmVnVFR2x1VGovRGlQUWh4Z205aWpE?=
 =?utf-8?B?VnZnS3BpbmljSVYxM011TUh4a0ViT0pZNUh4a1BUWXQ5bWJrU0lhZ1RhYXdp?=
 =?utf-8?B?YnR5VDNZTnNOWVJSbEVkaU9XVXBsY0FjZFN0NUxkbGs5RmhIYWt6OEVxR2hL?=
 =?utf-8?B?eEREdUZhZXdKMk9DNUVnVWoxR2pBU29IYXJGZE1OTTZGVTFsTWhkTjdVeXow?=
 =?utf-8?B?NEEvbkdQTE41WldQc29KY3NqM1RLNUsxN1NiNHBIcTJZcUd0a1R1dEN3bVpY?=
 =?utf-8?B?TmxpdGlPVnJpd1FkZFBDY2VoVWZKVDN4K3V2VklYREdrODhwZFhmcEVOMlI1?=
 =?utf-8?B?UW0vcDlJazkrZGpENDdkR3pPcFVHdUZsSFJPSU9EcktNWXZadi9BUXRPa2Ex?=
 =?utf-8?B?bk9QRUQ0WXQ2dWUvRlo0dEIrYTdKazJlb2JEREdHdTV4TzJDZ3FLU0FqT2tD?=
 =?utf-8?B?QnJoWnhNYnIrV2d3Rk1WY25OQUF6dzdVdEp4T2ZCZU0xb0hrLzVXQ2orWUFi?=
 =?utf-8?B?b1FWS1JvU0QvTkpYWEVDcXJybTBFbjZnb0tVeTN5bXMvU09ZT3BhMkd1V2ZL?=
 =?utf-8?B?WFlpTk8zVll2OWRjZ1RnYVp1RTRKU3dvNnlTdFFaVEV2T1hRb3RjbmtWTllm?=
 =?utf-8?B?NnloU3JtMTlrVDdFSFluWmpCSSt5NzNmcnpGUmFmdGhqeGJ3elJhK1c1WStM?=
 =?utf-8?B?dU5pWklHTVYweGd6ajc1WEx2SS9lQ3pjQTU5dGtYblBBdjhsbnhNcENCQ3lR?=
 =?utf-8?B?L093STNOQ0xCeWF6OXRWMXNZalNaVDRpUXp2WVp0YStJQ2l2ZEd2eS9acXI0?=
 =?utf-8?B?d0pDVEpxYVJnTXZXdEZsNlNlaGw2MmdyRXA1ZUh1NmJPYXk5ZHgvdHh1V2s0?=
 =?utf-8?B?UDhWQVU3VElLOXh1RW5ZUTVCSXpncVNYSjlQS3hUOEY2SzZFWTdSYUE3cC9D?=
 =?utf-8?B?NDJDMkhIYXhIdGdQYzU1eThNa21WZzBTL0J0QStwWDRDcE1iRGMrV2tBb1FP?=
 =?utf-8?B?a2VPd215TWEyQjdtVlp5SG51R3djeGhDM0c1MmI5MmNzbUZnbzFIZFR0NmI4?=
 =?utf-8?B?cHEzbFI1TzJSRXFwT3NQK1Fqa29NR254VXNrN1J2TTVqMzJRTUVwYkRyRTEz?=
 =?utf-8?B?UWJSQS9YTEc5NWR1SHNsbU5nU21PZlJqNGNydHBiOC84YjVyVVIxZkJ5eDVV?=
 =?utf-8?B?cE55VGZ0a0JvU1RGY2srNHFaYWx0KysreWNhSEtOblg1QjlvdkduRHd1amZ3?=
 =?utf-8?B?b1pSN1RabUQ0Q3VrZXMyR0JqcTltdzJ5ZmVGZm5XdEJ5ajFIcER6bk00WmUr?=
 =?utf-8?B?c1lHdFB5bEIyZWlpQlF5RzRITnVNemdMcGlhYk9HUmpIMzNxaUt1ODFWZUZB?=
 =?utf-8?B?RUZRTjVYRm1wbU8zSUxHWDR3NkUzOVdTeHZVMVA3K2xRYUF2L1RIelNjLzQ5?=
 =?utf-8?B?NXlReWMva2N5dWdWNE5Qek13cmFyTUtkOEdzYzZiR2RTYjl2UmxNUTVwYjAv?=
 =?utf-8?B?cjhUNGtWa2ZQSnJYZXEzQnRxYXoyek9XQ2R1S3paUGgvVjNZMzlLQlRWblZS?=
 =?utf-8?B?UnhScERmQVlZck1neld0MXRmTmZDcDVZRmsyY0hXajVmZnRwSDI1YlJYVmNj?=
 =?utf-8?B?TjlnN3dobUJKUW1WUXgrVXZmYTJBeDlwbXllNlZZcXZzOEZvMmFLMXhGTkZQ?=
 =?utf-8?B?MjZzQkkvcTg3Tm1HVEVsK1g4UzhxZHRkNy9JWTRiQlBiNGh1T1hibitDeTUx?=
 =?utf-8?B?d2d3Z2pPMDVBemE4Y0tuVE56T1dORXN6MHdZdkNTc28xUFRhbVg4dkFMc0Zx?=
 =?utf-8?B?cnYxdTFJd01EM0ZtOTJrYU40VlRCTi93bmdyUDhNVFlsMU5VNHJvMTNUdlNQ?=
 =?utf-8?B?M2tDVFZaRk54SHVQenM2Q2tiSkY5bHRlRHgyQjNwVDhDaDFTaXB1UVRSOThK?=
 =?utf-8?B?ZW5OYTZROEhmZlU1WC9lQm54ajNSOFRzbkIvRXpyWHlqc3Q4VmRZaHRhM1Uv?=
 =?utf-8?B?OW1qaGNpQ1pKNEVRTWFPcG4xSEJIYlh2TDU4Y3BrOFpmTDRCaFpiM2ZsOCs3?=
 =?utf-8?Q?loX4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cde124-91ff-4279-3754-08de1198ae33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 18:27:38.8151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0GTZVkNa01Eji5XBkcKTD46Ma9GYYIOytr5Ql5AsI3eY3agbxoBf/nIMNaPCu1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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
Cg0KUGxlYXNlIGhhdmUgQWxleCBvciBMaWpvIHJldmlld2VkIGl0IHRvby4NCg0KUmV2aWV3ZWQt
Ynk6IEVsbGVuIFBhbiA8eXVucnUucGFuQGFtZC5jb20+DQoNClRoYW5rcywNCkVsbGVuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjIs
IDIwMjUgODoyMCBBTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8
U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFBhbiwgRWxsZW4gPFl1bnJ1LlBhbkBhbWQu
Y29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBNYWtlIFNSLUlPViBjcml0aWNhbCBy
ZWdpb24gY2hlY2tzIG92ZXJmbG93LXNhZmUNCg0KVGhlIGZ1bmN0aW9uIGFtZGdwdV92aXJ0X2lu
aXRfY3JpdGljYWxfcmVnaW9uKCkgY29udGFpbmVkIGFuIGludmFsaWQgY2hlY2sgZm9yIGEgbmVn
YXRpdmUgaW5pdF9oZHJfb2Zmc2V0IHZhbHVlOg0KDQogICAgaWYgKGluaXRfaGRyX29mZnNldCA8
IDApDQoNClNpbmNlIGluaXRfaGRyX29mZnNldCBpcyBhbiB1bnNpZ25lZCAzMi1iaXQgaW50ZWdl
ciwgdGhpcyBjb25kaXRpb24gY2FuIG5ldmVyIGJlIHRydWUgYW5kIHRyaWdnZXJzIGEgU21hdGNo
IHdhcm5pbmc6DQoNCiAgICB3YXJuOiB1bnNpZ25lZCAnaW5pdF9oZHJfb2Zmc2V0JyBpcyBuZXZl
ciBsZXNzIHRoYW4gemVybw0KDQpJbiBhZGRpdGlvbiwgdGhlIHN1YnNlcXVlbnQgYm91bmRzIGNo
ZWNrOiBpZiAoKGluaXRfaGRyX29mZnNldCArDQppbml0X2hkcl9zaXplKSA+IHZyYW1fc2l6ZSkg
d2FzIHZ1bG5lcmFibGUgdG8gaW50ZWdlciBvdmVyZmxvdyB3aGVuIGFkZGluZyB0aGUgdHdvIHVu
c2lnbmVkIHZhbHVlcy4gIFRodXMsIGJ5IHByb21vdGluZyBvZmZzZXQgYW5kIHNpemUgdG8gNjQt
Yml0IGFuZCB1c2luZyBjaGVja19hZGRfb3ZlcmZsb3coKSB0byBzYWZlbHkgdmFsaWRhdGUgdGhl
IHN1bSBhZ2FpbnN0IFZSQU0gc2l6ZS4NCg0KRml4ZXM6IGE1ZDRkNzJlZWUwMyAoImRybS9hbWRn
cHU6IEludHJvZHVjZSBTUklPViBjcml0aWNhbCByZWdpb25zIHYyIGR1cmluZyBWRiBpbml0Iikg
UmVwb3J0ZWQgYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCkNj
OiBFbGxlbiBQYW4gPHl1bnJ1LnBhbkBhbWQuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2
YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92aXJ0LmMgfCA5ICsrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmlydC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZpcnQuYw0KaW5kZXggNjZlOWNkMTAzNTk3Li40NWYyYWQwODMzMzggMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQpAQCAtOTM3LDkgKzkzNywxMCBAQCBzdGF0
aWMgdWludDhfdCBhbWRncHVfdmlydF9jcml0X3JlZ2lvbl9jYWxjX2NoZWNrc3VtKHVpbnQ4X3Qg
KmJ1Zl9zdGFydCwgdWludDhfdCAgaW50IGFtZGdwdV92aXJ0X2luaXRfY3JpdGljYWxfcmVnaW9u
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KICAgICAgICBzdHJ1Y3QgYW1kX3NyaW92
X21zZ19pbml0X2RhdGFfaGVhZGVyICppbml0X2RhdGFfaGRyID0gTlVMTDsNCi0gICAgICAgdWlu
dDMyX3QgaW5pdF9oZHJfb2Zmc2V0ID0gYWRldi0+dmlydC5pbml0X2RhdGFfaGVhZGVyLm9mZnNl
dDsNCi0gICAgICAgdWludDMyX3QgaW5pdF9oZHJfc2l6ZSA9IGFkZXYtPnZpcnQuaW5pdF9kYXRh
X2hlYWRlci5zaXplX2tiIDw8IDEwOw0KLSAgICAgICB1aW50NjRfdCB2cmFtX3NpemU7DQorICAg
ICAgIHU2NCBpbml0X2hkcl9vZmZzZXQgPSBhZGV2LT52aXJ0LmluaXRfZGF0YV9oZWFkZXIub2Zm
c2V0Ow0KKyAgICAgICB1NjQgaW5pdF9oZHJfc2l6ZSA9ICh1NjQpYWRldi0+dmlydC5pbml0X2Rh
dGFfaGVhZGVyLnNpemVfa2IgPDwgMTA7IC8qIEtCIOKGkiBieXRlcyAqLw0KKyAgICAgICB1NjQg
dnJhbV9zaXplOw0KKyAgICAgICB1NjQgZW5kOw0KICAgICAgICBpbnQgciA9IDA7DQogICAgICAg
IHVpbnQ4X3QgY2hlY2tzdW0gPSAwOw0KDQpAQCAtOTU3LDcgKzk1OCw3IEBAIGludCBhbWRncHVf
dmlydF9pbml0X2NyaXRpY2FsX3JlZ2lvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgdnJhbV9zaXplIDw8PSAyMDsN
Cg0KLSAgICAgICBpZiAoKGluaXRfaGRyX29mZnNldCArIGluaXRfaGRyX3NpemUpID4gdnJhbV9z
aXplKSB7DQorICAgICAgIGlmIChjaGVja19hZGRfb3ZlcmZsb3coaW5pdF9oZHJfb2Zmc2V0LCBp
bml0X2hkcl9zaXplLCAmZW5kKSB8fCBlbmQgPg0KK3ZyYW1fc2l6ZSkgew0KICAgICAgICAgICAg
ICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiaW5pdF9kYXRhX2hlYWRlciBleGNlZWRzIFZSQU0gc2l6
ZSwgZXhpdGluZ1xuIik7DQogICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAgICAg
IH0NCi0tDQoyLjM0LjENCg0K
