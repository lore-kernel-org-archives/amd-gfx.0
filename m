Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE67BCA1010
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 21:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8999F10E203;
	Wed,  3 Sep 2025 21:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jBaF+p2I";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED7A10E203
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 21:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFXqNMTMVI80w92DwNEyqzjk719vWxaIEakuNSQIWZzFz1hzp57AZvnuRH+/wxvlP6Id8yGkruuk59/rTF2MkmBxji5tSlD4X/UJYIay3HFUX9GhXM80cd8QIIid+szYRRvEhYeOWD5D6Lsqxh+8LStDRBPlnZP6OJB+jfL5oZpEsQ5RoCXJ8JIVM6re3ILMpRUh+38H+J+WVTILt6t4FtHzy3dWB337LEcGAeynjxTI/tiDB7iNlEwv1ilmG5C3vumAx79+n4QNsPrd8xfJWtcFy8BG07BrsHbFo+in6pHUqlrJForpByzsteDgyW/BUp5gUBDi9UQ9Hvg4fLz8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doisYbhJGZS9aLvTPMsUYZhdPnCErCxk4A8OIr5/jrI=;
 b=qP7qxNa1XWayooSz16lY3u3T6ICaOzsm5aGWAJKIDZ/EBVESJBLKCBS7I69bMe8VvBGyS5RVNZLIY5IGn4WHaRaZejysw5+JggkqgUg1ByXtxn2Dtkci7C4rRBq9TjVi1RaJjO95YYlqsznfa8XjPF4wRXsAjXDKx58M9DpYGiua9Wz1ZvF7goeXvuxicZpg+KSqNZiBYByEmLt8tmw5TDLuYtap5qP25JVxxN+s2DhZlhKKc9CeOcfx0O8mp5i0P2UJaCIvaIjNn/yNruXUsvNgDpHIp01wMoMoK99vOuKclASXBrF09EJaQasPRcxFAnx/3NK2PkmH1fKvJeWdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doisYbhJGZS9aLvTPMsUYZhdPnCErCxk4A8OIr5/jrI=;
 b=jBaF+p2IQgqXzYRQItys08FIAoJ8wsJ2SsxtvNuMOni/KuTOrecJ3ASx9/MMcMO9SPLVTOyKY9Ip5A9O94txjKf6TDnb9TQQDHs4Pp2MKedUawoIAEfxBfabwITOKX0yuV3Xu4p2aJBOgTmGoksOjGK3m7XzWvRTsOeK2TWyoG4=
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 3 Sep
 2025 21:01:10 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::2f44:c21:dbf1:b98f]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::2f44:c21:dbf1:b98f%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:01:10 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin"
 <Bin.Du@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, "Antony, Dominic" <Dominic.Antony@amd.com>, "Jawich, 
 Phil" <Phil.Jawich@amd.com>, "xglooom@gmail.com" <xglooom@gmail.com>
Subject: RE: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
Thread-Topic: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
Thread-Index: AQHcHRJzrYAahqYs+ECNKQ7pk5bm1rSB65qAgAAF1BA=
Date: Wed, 3 Sep 2025 21:01:10 +0000
Message-ID: <CY5PR12MB6429886911C284A3F4777BBAFE01A@CY5PR12MB6429.namprd12.prod.outlook.com>
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
 <20250903203601.839525-2-pratap.nirujogi@amd.com>
 <2a0c1e16-8594-439f-95a2-763ca5e92ac4@amd.com>
In-Reply-To: <2a0c1e16-8594-439f-95a2-763ca5e92ac4@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-03T21:00:33.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6429:EE_|MW4PR12MB6851:EE_
x-ms-office365-filtering-correlation-id: 46f9c109-86a3-4edb-5376-08ddeb2d0256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d0dHbXZmSlBUdGw5RzE3L0Mwbms2NjdaVG9wSDk4MXJ6UEhZU2JxQXhOY0Yv?=
 =?utf-8?B?V2lhV2I1T01Vb0NRV21keDVhUFdsUkNyNW1EZGJ2WjhwK0taQ3VuWTBKOFR0?=
 =?utf-8?B?RERnT2tBcWlRcWxoUFVXakNreXplZW5iWlEraXJibzF5dE9jbkY5UGNJdzJi?=
 =?utf-8?B?M3M4bzhzN0pocEFwTiswRG1ZTkhzUFJIVUlLUDU4YTUxZHUzL0tvOHE0VWxW?=
 =?utf-8?B?SjA3aUlrSWNoT3U2eXpkUzZUbGdVT1E5WWtWallmTU10M1g1aGN0NGFnZ1p5?=
 =?utf-8?B?dlgxTGdOUEpNd0xWQ3JrYWMwWkZYbGphekNoeDFRWW1yVFUwQ1JQaUowOWFB?=
 =?utf-8?B?cE85bEVXWE5UbTFsQ1h5UlRYZG9NVGdjR2JEdElwUFFGOHRCTURZdGxDNGtS?=
 =?utf-8?B?SGxuMmtiN2x6QmVxajFCMEdrZi9OUUIwZzVLWTZHcVZpckR3S1dOci80N05y?=
 =?utf-8?B?MjNGRDlGakg2OGpRZmdxOVV5Y2pzdERGT2IwYkowUk9hSG1uY1dJeUx3YTJD?=
 =?utf-8?B?UitRZG11RHM5SVh6Wk1xVi9hbGJvcmw5RUc5NGlmcDN2cjluZlVINWV6SUNy?=
 =?utf-8?B?U25wNHU2bHlyeVptZHZLVXZZWGl2UkVUNEpOOURtR0VnUVNmalhXU2tXZ0dx?=
 =?utf-8?B?U3R4VndwWlY5SUdNUnlNK2FpN1FWTVlRMjIxbVhVNkcrVjdPd2wwNmUydXE4?=
 =?utf-8?B?czhhbzZkSmkrYVpjMmRldlhsSUVNcjV3aUYzSEYvQlRmeE96Q0VmM2JucjJC?=
 =?utf-8?B?dEIxRGxIdGlQaGVSaGh6ekF6S1R5TDZZdkxjZDRWVUFEMHBIMlV5a1NPSHpX?=
 =?utf-8?B?MG1uZytKYmJSSW9WRjF5VWRacnRJbmwwMU5yV1VvUjNFYlVOaU1oM2UrdFhV?=
 =?utf-8?B?U1JlRXA1V01rY0YwNnpCRGVlU0NBK0lRYTA1ZGhNQUNTRElDNktuaGNLY08r?=
 =?utf-8?B?a09sUFpwbkJWaHBWT3cwVXhKMVFhYlUzaUVsNXNRT0RJbmJQaHBLdWY0M0py?=
 =?utf-8?B?ODdNSFFaVGdyR0M0aUd5S1Y2U3o0a3NXdEF5LzVabGp6cHpvWk91bVdUT2NB?=
 =?utf-8?B?U3l2NGJRUS9HYVZrbjFuMUtiL2p5Y3lUQ21aeE5vMXAxTlQrY3FwcEhZT0tl?=
 =?utf-8?B?SHRJRmN2WmM5WXpnY3U0a2VGR08vUVhGdlhFdG9KV3lIOVUwVHJCeTJZTlpM?=
 =?utf-8?B?azhBdmhQbkVzZ3BVTTMvcDg0aGJyTEwrVjBZSlBrdkhCUVdnei9uaVpnRWpB?=
 =?utf-8?B?R3IyeDlxVUFTWWhFREY4eGZya1dJQzVYRUNMRFNzcjM2RTlCZWlHSDIyb042?=
 =?utf-8?B?SURPRHVHNlhLQklJUCtlNWM1b3dtTXY2c3pxYWcyWnNEUTZiaVB1blJkeHl3?=
 =?utf-8?B?d2daWDlwVG1VZDd2Um9sQU5VRkdXeEM4TjN5eTBxcEFoMVJhY1FsLzZHMTk1?=
 =?utf-8?B?TzBhMFZKOU1kQ1pZZU5ubXlQVUs3bk5CY3RvR3ZDWkZnY2R5WnN4SFVEYjlV?=
 =?utf-8?B?bXQraUU2RGNHMFR0eUhIUm9pWGxaa0tiYUlUZFYwTnB3NlZ2cXgwRDQrUEhI?=
 =?utf-8?B?a2JsT1dZSFA1WStPQWx5elVVYmtYRmJBNmNKVG1yNk1aanNHN25QVHp5TWVR?=
 =?utf-8?B?VytoTGFkKy9FUnFtZ3ZqWUV3YkpiNEtNeHBzK3gwaE5kZW1yNUFCdEduUjZu?=
 =?utf-8?B?eUZaSm55WVJJa0ZBdnhpSkg3QWRkdHVPMTcxaE95bmxGWUpIaGhJVURoM1Ro?=
 =?utf-8?B?MEtxRzdrLzhzL2VCQnY0WU10MXVoOFVIcHByQ3JLRVlvOC9LaGJLMFdtZ3Zw?=
 =?utf-8?B?a3hOYjhZcUxTZTV0MWJHbTFxdlVSNWNJYXpJNFVqUmlvUUtIbDU4UFJZc1pK?=
 =?utf-8?B?cmV0MGRvaTNINVJPMUxiMW9DKytBby84Ti9SOEg0TUFlVThwUzRtMlN0R2c2?=
 =?utf-8?B?OUdoQkkxeURLN2JpRVB3b2dTK3o1NjZvT1g0UVV3OStHSnNCTjZxMGR3dkdS?=
 =?utf-8?Q?9Rb6PWvAeNJIYR589brx582hF6tSC0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0xlZE5xUmFRczJLeWovcEJQQmplQlo2Q1dUQXBURGJHcTRxYjlYdnlqRXEw?=
 =?utf-8?B?UXhZeHZORldoRzNRR1h3RjdPRHBRWXZmYWhscUpVbTcrOERLclk1L25adWpQ?=
 =?utf-8?B?MXIralhrY1poM0pBM2w4V1Vhbk84Sis4alNLb0tpaDY0cnROY3NnUHdJajRn?=
 =?utf-8?B?cUZlV1BTbHhRbGIxaGw0Ni9WUFZ0OWlVN01DZEY1M0VrbmNMRUJ5MXdDV0Va?=
 =?utf-8?B?Z1RoMVVJK0pRTEJ0UmRMOTVUbTBYcnd3bGdvallGb3RiampIbkIxSWQzREY0?=
 =?utf-8?B?SmlKZnd5cWFnZlQvc0l5cGZNNnJESmwxUmRDVkNHK0phV25uQk1vNkY1dkdp?=
 =?utf-8?B?VVBzbEVDWENIRmVXRGZ0VWJ6UWw4WDNlb2o4VU1IMU9sTGZDTUQxQWNqWUc4?=
 =?utf-8?B?NmhBclF4ZWMrajdWRjZBeE9mbEpmb0JtVE0xbDlpcWpPUTJWRTdHK2xsSWov?=
 =?utf-8?B?ZjZMTUdPWjVaYitLaWJoUU9NelhXN3lIZmpTSnJwbWRNNzBLeTlFai9XWU9o?=
 =?utf-8?B?ZjBRVHdxbTNGSVh3Si9CZk1jK0pEanlINVJVRCs4OXg1UmQrWDNUdUxFT1dI?=
 =?utf-8?B?MmNkVU9BV3pFTDNLZ0gvemFxOVZ3MHZUWVZPa2tGdDNnY1pDVXpGQUUwR1RF?=
 =?utf-8?B?dDFOdUxTUFJ2N3J0aXE3U2hWUzdzSzRnYXVpbWphOVFiQWJsdTZMN1ljUlBM?=
 =?utf-8?B?Tm1FMDM5TlNEY2lYTGdCc2drZ3lxcW83aUtLMzlYeE5ucGpheXk0QndmN1NR?=
 =?utf-8?B?Q1ptZ3ZWVnl2bHo5dCtpbFJ5d2NBOFVvb0xqWVVQQU1DUUNNRUl3L2ZndnJG?=
 =?utf-8?B?TDBCaU9PTVZkckZhNE9ZNlhhQ1pyWnVNUER1ZnArVHdQSjNmbFJhVC8wZXRR?=
 =?utf-8?B?Y2lFSGxyYXp1RU9UT1RBd2lSQTIrUXNvL2k0NDYxdHlZYmVpYmdtOW5WTFp1?=
 =?utf-8?B?T0Y5MTlOSmp2bmprZ1U1a05md1B5dlIzakc3L3hIWVRiN1RFREoyV2x2a0hR?=
 =?utf-8?B?ODIzTXJmaHNtR0ViUEZrUTQycHV2N213WU9xMXdPTENpQWpXU2wvTHJSTlJI?=
 =?utf-8?B?K0pUdU5YSExVVlFGejUrcEsrd2FrVXRzVldHb1ZhYTBIMnVuZGlCL2xnU0g4?=
 =?utf-8?B?Y3JRTVZmVlZtNDBKSG5XajdEa2Vua1JaZUdLdEpJb1Q0dUhXT281MGdwZElh?=
 =?utf-8?B?VmR3NXA0OWNES2tUZ2M0enFpbVZlWEFjS1BudHJHc1ZiYWkrZFZEREs3ZGxZ?=
 =?utf-8?B?ZTNQYXBpSGZYMy91Tkh3alpKdzVSdUlUZFpFYjQrUGpFRUlmeU51QklwSG1a?=
 =?utf-8?B?MG1KbE1mb3JxaTNmOTVubGJVV1Y3R1ZDUHVaRjBEWnlwVm9TMkpGa3A2TG1D?=
 =?utf-8?B?VnNrNVZWcktKU2ViWGdCRktFdmp6Q3RyQkIzWmV5azdZUWVuUjdrY0RBMCtQ?=
 =?utf-8?B?SnN0QURNUGtiVUJweDN6ckpkeHdQWW5BU0owRW5WUE5WSGpmaUVGVGlkNU1J?=
 =?utf-8?B?ZGtkaXFqeWJYTnVVdzB0YzFEUXk2WTdpRDhJL1FsN2szT1h4aUV3WjZKakNM?=
 =?utf-8?B?bnJCU0haWHZ3NjJPbnNhZzRXZVBlaDhIdHRoQitKTUNqRWpmalNJMWZLVm42?=
 =?utf-8?B?ZktoS2kwbDBrQ0ZrRWVaOHU3TTBvMXlZY2FwTFhicG9CajJyMjZ2eEUwSkZY?=
 =?utf-8?B?aE5Gc3RRR3VBOEFvbU93NFRsM0dTTkJCdFB2L3R5K3Z4bS9UYVFRZE9xTTBR?=
 =?utf-8?B?b2lPQmxxV1NxdjNoajgvVEZlQ1VBT1diNllybEVGNnBIQXlmRExYQzBlRk5R?=
 =?utf-8?B?elZtV24xQ0JNeWVpVVRNVm1Za1c3Z2dyOHE1V05oR0ZjT2FHNWVXUEw0MXdx?=
 =?utf-8?B?TjNMSmdMNlArWDY3Z0tETnVRTUx1WXBVbVEyWW5NY056ZE02UWV6TGxORHVI?=
 =?utf-8?B?aW5HQjhxVDcwNlU0ODIvZzl3TUc0OFNtbVJSR3hVTUJoMXlxQnRIZXRKYUpv?=
 =?utf-8?B?eHpvRGU4UjNveTl2blVuU1Erbzk2NVZoYVI2S2VZeUtQTitYazhxOE5EVlVw?=
 =?utf-8?B?Ykptb0t4dDlLaUJsbXJuUXRLMkdNbi9RN1hTTUYxeUxhWGI1K2pVeDQreXE5?=
 =?utf-8?Q?h7cg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f9c109-86a3-4edb-5376-08ddeb2d0256
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 21:01:10.1494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ALDU+MT/A91Og0EXrl7mgLaykAHMb2Jg+cnuXWgJSwCYq6Rr5gbvCBU81xEPnpPrM9Q3qaEH63xRSDXNZwwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8
TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDMs
IDIwMjUgNDo0MCBQTQ0KVG86IE5pcnVqb2dpLCBQcmF0YXAgPFByYXRhcC5OaXJ1am9naUBhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFt
ZC5jb20+DQpDYzogQ2hhbiwgQmVuamFtaW4gKEtvb24gUGFuKSA8QmVuamFtaW4uQ2hhbkBhbWQu
Y29tPjsgRHUsIEJpbiA8QmluLkR1QGFtZC5jb20+OyBSb3Npa29wdWxvcywgR2pvcmdqaSA8R2pv
cmdqaS5Sb3Npa29wdWxvc0BhbWQuY29tPjsgTGksIEtpbmcgPEtpbmcuTGlAYW1kLmNvbT47IEFu
dG9ueSwgRG9taW5pYyA8RG9taW5pYy5BbnRvbnlAYW1kLmNvbT47IEphd2ljaCwgUGhpbCA8UGhp
bC5KYXdpY2hAYW1kLmNvbT47IHhnbG9vb21AZ21haWwuY29tDQpTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvMl0gZHJtL2FtZC9hbWRncHU6IE1vdmUgaXNwIGZpcm13YXJlIGxvYWQgaW50byBpc3Bf
djRfMV94IG1vZHVsZXMNCg0KT24gOS8zLzI1IDM6MzUgUE0sIE5pcnVqb2dpLCBQcmF0YXAgd3Jv
dGU6DQo+IE1vdmUgaXNwIGZpcm13YXJlIGxvYWQgZnJvbSBnZW5lcmljIGFtZGdwdV9pc3AgZHJp
dmVyIHRvIGlzcCB2ZXJzaW9uDQo+IHNwZWNpZmljIGRyaXZlciBtb2R1bGVzIGlzcF92NF8xXzAg
YW5kIGlzcF92NF8xXzEuDQoNCkkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2h5IHRvIGRvIHRo
aXMgY2hhbmdlLiAgSXNuJ3QgaXQganVzdCBtb3JlIGNvZGUgZHVwbGljYXRpb24gd2l0aCB0aGlz
IHBhdGNoPw0KDQpIaSBNYXJpbywgSSBoYXZlIGFkZGVkIHRoaXMgdG8gc2hvdyB0aGUgcmVmZXJl
bmNlIG9mIGNhbGxpbmcgdGhlIGZ3IGxvYWQgaW4gdGhlIHNhbWUgZmlsZSB3aGVyZSBNT0RVTEVf
RklSTVdBUkUgaXMgYWRkZWQuIFRoaXMgYWxpZ25zIHdpdGggdGhlIGFwcHJvYWNoIGZvbGxvd2Vk
IGluIG90aGVyIGRyaXZlcnMgKGFtZGdwdV92Y24sIGdmeF92MTFfMCBldGMuKS4NCg0KVGhhbmtz
LA0KUHJhdGFwDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogUHJhdGFwIE5pcnVqb2dpIDxwcmF0YXAu
bmlydWpvZ2lAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2lzcC5jIHwgMjIgKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuaCB8ICAyICsrDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jIHwgMTIgKysrKysrKysrKystDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5oIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmMgfCAxMiArKysrKysrKysrKy0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmggfCAgMiArLQ0KPiAgIDYgZmlsZXMgY2hh
bmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmMNCj4gaW5kZXggOWNkZGJmNTA0NDJhLi45MGFm
MzVlZThmNmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pc3AuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmMN
Cj4gQEAgLTY4LDcgKzY4LDcgQEAgc3RhdGljIGludCBpc3BfaHdfZmluaShzdHJ1Y3QgYW1kZ3B1
X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ICAgfQ0KPg0K
PiAtc3RhdGljIGludCBpc3BfbG9hZF9md19ieV9wc3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ICtpbnQgaXNwX2xvYWRfZndfYnlfcHNwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQ0KPiAgIHsNCj4gICAgICAgY29uc3Qgc3RydWN0IGNvbW1vbl9maXJtd2FyZV9oZWFkZXIgKmhk
cjsNCj4gICAgICAgY2hhciB1Y29kZV9wcmVmaXhbMTBdOw0KPiBAQCAtODAsNyArODAsNyBAQCBz
dGF0aWMgaW50IGlzcF9sb2FkX2Z3X2J5X3BzcChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRl
dikNCj4NCj4gICAgICAgLyogcmVhZCBpc3AgZncgKi8NCj4gICAgICAgciA9IGFtZGdwdV91Y29k
ZV9yZXF1ZXN0KGFkZXYsICZhZGV2LT5pc3AuZncsIEFNREdQVV9VQ09ERV9PUFRJT05BTCwNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFtZGdwdS8lcy5iaW4iLCB1Y29kZV9wcmVm
aXgpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFtZGdwdS8lcy5iaW4iLCB1
Y29kZV9wcmVmaXgpOw0KPiAgICAgICBpZiAocikgew0KPiAgICAgICAgICAgICAgIGFtZGdwdV91
Y29kZV9yZWxlYXNlKCZhZGV2LT5pc3AuZncpOw0KPiAgICAgICAgICAgICAgIHJldHVybiByOw0K
PiBAQCAtMTAzLDI3ICsxMDMsMjMgQEAgc3RhdGljIGludCBpc3BfZWFybHlfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2lwX2Jsb2NrDQo+ICppcF9ibG9jaykNCj4NCj4gICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+YWRldjsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9pc3Ag
KmlzcCA9ICZhZGV2LT5pc3A7DQo+ICsgICAgIGludCByOw0KPiArDQo+ICsgICAgIGlzcC0+YWRl
diA9IGFkZXY7DQo+ICsgICAgIGlzcC0+cGFyZW50ID0gYWRldi0+ZGV2Ow0KPg0KPiAgICAgICBz
d2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIElTUF9IV0lQLCAwKSkgew0KPiAgICAgICBj
YXNlIElQX1ZFUlNJT04oNCwgMSwgMCk6DQo+IC0gICAgICAgICAgICAgaXNwX3Y0XzFfMF9zZXRf
aXNwX2Z1bmNzKGlzcCk7DQo+ICsgICAgICAgICAgICAgciA9IGlzcF92NF8xXzBfc2V0X2lzcF9m
dW5jcyhpc3ApOw0KPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICBjYXNlIElQX1ZFUlNJ
T04oNCwgMSwgMSk6DQo+IC0gICAgICAgICAgICAgaXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKGlz
cCk7DQo+ICsgICAgICAgICAgICAgciA9IGlzcF92NF8xXzFfc2V0X2lzcF9mdW5jcyhpc3ApOw0K
PiAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiAgICAgICB9DQo+DQo+IC0gICAgIGlzcC0+YWRldiA9IGFkZXY7
DQo+IC0gICAgIGlzcC0+cGFyZW50ID0gYWRldi0+ZGV2Ow0KPiAtDQo+IC0gICAgIGlmIChpc3Bf
bG9hZF9md19ieV9wc3AoYWRldikpIHsNCj4gLSAgICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVS
KCIlczogaXNwIGZ3IGxvYWQgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQo+IC0gICAgICAgICAgICAg
cmV0dXJuIC1FTk9FTlQ7DQo+IC0gICAgIH0NCj4gLQ0KPiAtICAgICByZXR1cm4gMDsNCj4gKyAg
ICAgcmV0dXJuIHI7DQo+ICAgfQ0KPg0KPiAgIHN0YXRpYyBib29sIGlzcF9pc19pZGxlKHN0cnVj
dCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKSBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2lzcC5oDQo+IGluZGV4IGQ2ZjRmZmE0Yzk3Yy4uMzY3NTAxMjNlZDQ2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmgNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5oDQo+IEBAIC01Nyw0ICs1
Nyw2IEBAIHN0cnVjdCBhbWRncHVfaXNwIHsNCj4gICBleHRlcm4gY29uc3Qgc3RydWN0IGFtZGdw
dV9pcF9ibG9ja192ZXJzaW9uIGlzcF92NF8xXzBfaXBfYmxvY2s7DQo+ICAgZXh0ZXJuIGNvbnN0
IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBpc3BfdjRfMV8xX2lwX2Jsb2NrOw0KPg0K
PiAraW50IGlzcF9sb2FkX2Z3X2J5X3BzcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+
ICsNCj4gICAjZW5kaWYgLyogX19BTURHUFVfSVNQX0hfXyAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jDQo+IGluZGV4IDAwMjdhNjM5YzdlNi4uOTI2OTQ3YTYx
MmE0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8w
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jDQo+IEBA
IC0xODUsNyArMTg1LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaXNwX2Z1bmNzIGlzcF92NF8x
XzBfZnVuY3MgPSB7DQo+ICAgICAgIC5od19maW5pID0gaXNwX3Y0XzFfMF9od19maW5pLA0KPiAg
IH07DQo+DQo+IC12b2lkIGlzcF92NF8xXzBfc2V0X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lz
cCAqaXNwKQ0KPiAraW50IGlzcF92NF8xXzBfc2V0X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lz
cCAqaXNwKQ0KPiAgIHsNCj4gKyAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpc3At
PmFkZXY7DQo+ICsNCj4gICAgICAgaXNwLT5mdW5jcyA9ICZpc3BfdjRfMV8wX2Z1bmNzOw0KPiAr
DQo+ICsgICAgIC8qIGxvYWQgaXNwIGZpcm13YXJlICovDQo+ICsgICAgIGlmIChpc3BfbG9hZF9m
d19ieV9wc3AoYWRldikpIHsNCj4gKyAgICAgICAgICAgICBkcm1fZXJyKCZhZGV2LT5kZGV2LCAi
aXNwIGZ3IGxvYWQgZmFpbGVkXG4iKTsNCj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsN
Cj4gKyAgICAgfQ0KPiArDQo+ICsgICAgIHJldHVybiAwOw0KPiAgIH0NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAuaA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAuaA0KPiBpbmRleCA0ZDIzOTE5OGVkZDAuLjVlNDNi
YTA2NDcwOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0
XzFfMC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAuaA0K
PiBAQCAtNDUsNiArNDUsNiBAQA0KPiAgICNkZWZpbmUgSVNQNDEwX0dQSU9fU0VOU09SX09GRlNF
VCAweDY2MTNDDQo+ICAgI2RlZmluZSBJU1A0MTBfR1BJT19TRU5TT1JfU0laRSAweDU0DQo+DQo+
IC12b2lkIGlzcF92NF8xXzBfc2V0X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKTsN
Cj4gK2ludCBpc3BfdjRfMV8wX3NldF9pc3BfZnVuY3Moc3RydWN0IGFtZGdwdV9pc3AgKmlzcCk7
DQo+DQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9pc3BfdjRfMV8xLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8x
LmMNCj4gaW5kZXggYTg4N2RmNTIwNDE0Li45NzY2YzYwNTZkYzQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmMNCj4gQEAgLTM2OSw3ICszNjksMTcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBpc3BfZnVuY3MgaXNwX3Y0XzFfMV9mdW5jcyA9IHsNCj4gICAgICAg
Lmh3X2ZpbmkgPSBpc3BfdjRfMV8xX2h3X2ZpbmksDQo+ICAgfTsNCj4NCj4gLXZvaWQgaXNwX3Y0
XzFfMV9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApDQo+ICtpbnQgaXNwX3Y0
XzFfMV9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApDQo+ICAgew0KPiArICAg
ICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlzcC0+YWRldjsNCj4gKw0KPiAgICAgICBp
c3AtPmZ1bmNzID0gJmlzcF92NF8xXzFfZnVuY3M7DQo+ICsNCj4gKyAgICAgLyogbG9hZCBpc3Ag
ZmlybXdhcmUgKi8NCj4gKyAgICAgaWYgKGlzcF9sb2FkX2Z3X2J5X3BzcChhZGV2KSkgew0KPiAr
ICAgICAgICAgICAgIGRybV9lcnIoJmFkZXYtPmRkZXYsICJpc3AgZncgbG9hZCBmYWlsZWRcbiIp
Ow0KPiArICAgICAgICAgICAgIHJldHVybiAtRU5PRU5UOw0KPiArICAgICB9DQo+ICsNCj4gKyAg
ICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvaXNwX3Y0XzFfMS5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0
XzFfMS5oDQo+IGluZGV4IGZlNDVkNzBkODdmMS4uYjIyMWQ4YjgxOTgzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmgNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5oDQo+IEBAIC00NCw2ICs0NCw2IEBADQo+
ICAgI2RlZmluZSBJU1A0MTFfR1BJT19TRU5TT1JfT0ZGU0VUIDB4NjYxM0MNCj4gICAjZGVmaW5l
IElTUDQxMV9HUElPX1NFTlNPUl9TSVpFIDB4NTQNCj4NCj4gLXZvaWQgaXNwX3Y0XzFfMV9zZXRf
aXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApOw0KPiAraW50IGlzcF92NF8xXzFfc2V0
X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKTsNCj4NCj4gICAjZW5kaWYNCg0K
