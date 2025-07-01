Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2023FC83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 13:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF67B10E2C1;
	Tue,  1 Jul 2025 13:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="23dz3uLE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7F210E2BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 13:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI33tRoPIkaLxtAnKAhfBf8GLsuN1g/9vnZgOHUexiuZTNRlhbwpzmPnBbLGsmnUT4tEv0H5l4Bi32ZdB295memxgeqlrC1m4MTMub3QGlLP2aLzQnD4QNH4MqFwWw5QmeAwJbrw+/gfXckJhAJRz950zqyLUa1EESMKSWDIofBDBtJI1JHDotgnuweFx+hmg79habA8FK1EVeR7BGoctPbz00tiVALx+3E9ov6gu78cM2CKorzSzwZjZZIAHj2ZA9YcGteMd/UdatdlBH1GbLOdpMeyTKUiVpKhucfTzW/dslB5P+slwxoYzFwd+JG7OeBjBLk3zMUyd8U0B2Dr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9y8RZWXlav65Zc1xxj1u23ZAZKPMDKuuTC5ftyoov0=;
 b=wzg5k0izlbNlq8+f2V8kfqOZDfUcOpXASoqZgtNVGhIhszWcV/WuaHE/nAGz4C0p2TLiTieUo/h2sXHxj3pzxDkPGabPWdtlMQxCJkXVHuf4qMhtKlZ645JPflXsTf4StjVx0qcKx+K4ZWRAJL7Wp1kYjQufJ3tfir3HpuE8/8sJ1+2JHyQmMGfJIblRgVLNvhUtc64VGso8ytBqx2UkMFYv/s2hxCc1+3BlqrXlmAAoJwrJtvpHV8pK4Mp9nPdDLNHT7jXNLW7whUwNqdBENL2DLqiqZD1zoAfsBXp6+h+9ZPZybRWffJs413RheI7iHXQ7K0SARbJXg67lR5aH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9y8RZWXlav65Zc1xxj1u23ZAZKPMDKuuTC5ftyoov0=;
 b=23dz3uLEFXQC4bQaiBpRz+q9j7IdQ9Gxl0uKC80zeMBDpUB6T0DnRSlwOFIbYEvRtI+TSIJnQNVY42srdausA5p6CTMDwJkSHlki8EP/LQ76dfIGFEIU4nIMnfQg0O5VjRDcZbg1lxWFEb/kijOfmMA7szmVqs2PZ9BhwqTtKvw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 13:12:26 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 13:12:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 07/11] drm/amdgpu: add user queue vm identifier
Thread-Topic: [PATCH v4 07/11] drm/amdgpu: add user queue vm identifier
Thread-Index: AQHb5ORolQiSCWuV4Ea/lzRO6U47j7QTgi8AgAmCGCA=
Date: Tue, 1 Jul 2025 13:12:26 +0000
Message-ID: <DS7PR12MB60053702F3897C9C2065B634FB41A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-7-Prike.Liang@amd.com>
 <faed435a-1f15-4a77-a66e-2e03062699a7@amd.com>
In-Reply-To: <faed435a-1f15-4a77-a66e-2e03062699a7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-01T09:03:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB7698:EE_
x-ms-office365-filtering-correlation-id: e9b57de6-b247-407d-0bff-08ddb8a0ecd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?cnRVYXB1TndtQUpidlVLL2pVb3pGZXgrcHNJL04zT21xMEhEdno5Q0ZFMFE5?=
 =?utf-8?B?TTIwV3RkVXBYS3p2YlBNRzUvd00rQTFHZ3JQdHkxbWhtTGhKMkZZRHZkMS9u?=
 =?utf-8?B?OG4yOXhmTTlvczJUbHJ2R21sK1dzc3FuQlFQTXpTemhIMVUwQXh2ZlhZOXJV?=
 =?utf-8?B?dzZSYUtpL1VSdTltS3NVTzViT3lzU3FSNVFtc0Q5Ti9HWXJrV1hDK3VTWXRU?=
 =?utf-8?B?WlFrTGswcTZ6bXlHOHFpeHJHUkRJcURGVVlHeUZDeTdsbjBKTHNWMEdOdFND?=
 =?utf-8?B?dmwvbWlneVY1eDNrb2kyblRzTU9IWG5LWjJiTVVPc0VjaXV4OFJlbnRnZkcz?=
 =?utf-8?B?ckNmeFJoYmIxVnF2dy9OcjM5bk9qcmwrWUMrUjVtNjBSald4UWJYVFgvNG1H?=
 =?utf-8?B?WG9SV3diV1RpZ0gwYTA4Zi9mQi8ybmdXb1h2Tkw5bXNVSFZVY0RBVFkrZTh5?=
 =?utf-8?B?TGNXZkpmcjJOUUloM0tHOVpzeUphYVgzQjlvNno1bVcyTnlnQ1dRL2pzVmRC?=
 =?utf-8?B?NE1HaUIvU2NkRitVY01lSUt0RXZUV0lYSVlHa1dMdnovQVFHR1RJVjZIb3VF?=
 =?utf-8?B?VWZGSjFGeWFCZTRoQmpVRXFnUzhBTFhCVXNOd1FCdDBSenRES3RhY0tXdjJ4?=
 =?utf-8?B?SHIyb2JrNHgwZWlaV1hrVStQWmQyU0pySEtTSlkrUHNDVklyalNvNkhpOUtj?=
 =?utf-8?B?b3BqMVFrbkhqQjNYWE45cHlnWDhoZWI5c2N6VjlDNEc1K3ZxaG5rY1FzaStz?=
 =?utf-8?B?T3RLYkpOL3cyVnBBUUhhRE9vejl5dnVMWnRuakZ6YlRmYm9RMVJiZzJ2U2Ew?=
 =?utf-8?B?MFhuOXBBd2RoQndiSWd6MXoyN3JkTElyWVBqS1IzRGFrOWVNaHUyTVcxRCsw?=
 =?utf-8?B?WVplL3YwVnc5d1dNN2R4RUlJNDYzdDhpdkh2Ui83KzBiaWlsRndxWW5jcDd6?=
 =?utf-8?B?eVFxY3dmTlRnMmpSNUZmRlhYdmd1eWZoTWRoRlBDODlhbDdkMGVoOElJaVBv?=
 =?utf-8?B?dmZ0TGcvckZ6aThXNnJ2ajhuYW8vZHp1RmhyL1Z1eDZDTmhBTlRJbk56VFFV?=
 =?utf-8?B?dG5QY3dYbC9CUjlxcXhjWEZGSjN6RlNBSWNlcU5xRWNjeEJsOUJsZVQ0V1BC?=
 =?utf-8?B?NThDbTA2WDQyMGpyV2pWY3g5MVNKSzI0Tks3ZGZNenNkRTIxUVdaUkJiOGhY?=
 =?utf-8?B?T0lDTTNRTmV2RHNsSFBlY0dDQ2M2WU9va3F0RGxkV2R5M0F5aFZDTmVaZG1r?=
 =?utf-8?B?Y2gzRForaFdXVzkwMzVnMlkxU2d1UE9aUGYxdHcvNldieDJudlRFMnJ6L3Vh?=
 =?utf-8?B?TDBkSC9pMDVCSWZ4K2JWeDhNWnJ5dXBPWWpBb2JoR3o3OUgyNTBnVVpuQ1RS?=
 =?utf-8?B?SEpEUkpYemRScnJtWmFqWXpKL2dJUjdRUjNaeEhGYURqRUR0S21aYjlVM2hj?=
 =?utf-8?B?Z2xlT2JkcG55MEtiSHJCUTBjMDBhMFFES1RiWjlmQmFzRUJZNzYzVFRpNGFW?=
 =?utf-8?B?dHlDTU94S29BaDhOTDl2bS9Dc1VuZG1nKzhXcnVOOHRGRnFqUTBPZkllYkFC?=
 =?utf-8?B?Nlcza2d6TVp6aEVCMXhwOWMvNm1pTU9Nck9ZaE54UVdZY2tXeGJoRVFJK2hG?=
 =?utf-8?B?R3ZYcHZ2QktRRUVSU1NUSEtwN3hyYXY0dkxKU2Jsd0xYOVllZFBIL1ZHV0hR?=
 =?utf-8?B?aXFicW93N2IzaHB4STlUQkRFY1pqTUlRaHBFa0hZS2lGWi9GMFhyblpOdGZa?=
 =?utf-8?B?alprdmNWclJxb3N5S0U5RGcwSENRb0trZU92N1dKd01ubk5hV0JZcGdUMzQ2?=
 =?utf-8?B?VVhNd2tiVzA0ZFBWWi9iUGp6Q2kzQXM3Q25ncXdQVk5rM2hsVU4zd0NkemVn?=
 =?utf-8?B?QzRrVjZLc29mRTR0SzZkTjZ3aVFVWEFUYmFTZWZYYTlwV3loOXRvcmYvdTl6?=
 =?utf-8?B?QlFjZ1NtMy9xTlBKSTl3MlJtSXFrOXF1RzNpMndNQlprcU1IZW1HVU1aWkRX?=
 =?utf-8?Q?efhgJixZBptX8yefCgHD66BBj1xSzg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzA0U2Zpa0RGTDdPUGt5MFk5cy84TG9NUTN4TWU3SE9xRDFyN2pPVGgvNlZK?=
 =?utf-8?B?Mm4vUU1qMEtKVjR5cXdBU1FnUVRlZnFqelUwVUdqSmprNEZVVDZoY1lEVVBO?=
 =?utf-8?B?WkV1eUF3dGVmM1hkbzdaSW4zOHp2UU9xdUZ5YkIzbk5yc1lheFh1S05PMVdm?=
 =?utf-8?B?Nyt6cmhqQnBOYjZ4OEJCNFcwa1N1NGZUVkhCaWpmR3FZc25PVWNKZXQwT1pE?=
 =?utf-8?B?SDF3dm1jNkk1K0t1K0l5UGhZOXVDSTlyd0x1bXhDQ3FHc1RZUkFza05YR3Fi?=
 =?utf-8?B?cG5oV0xBdTJabm1zMjdYZit2ejJrVlV5YkFJU2tXeFRPR1FYdWRDMTJyRGxP?=
 =?utf-8?B?T2liNTM3RGM2dGFEOWcwenhqVDlTVUhaOVlrb3c2a2J0WVFqd3JPYXVraHhD?=
 =?utf-8?B?Znc1eEkwVGNuMS9Uc0duQWcrVXBVamdvaVBBZ3pwWC9NeU9MMW12ODlPb3gz?=
 =?utf-8?B?RlVQaGdaS0dtbG5SYVYwSitoNmR5aTk0dWFEZ2J4c2VINXhoL25pWFpOWFFP?=
 =?utf-8?B?cnMvYjdrVnJjWURsZk1Bd2xKcGsvRk9pUTRLS3ZFbC9JMlZOWXZKMWJNbVBQ?=
 =?utf-8?B?Ymhwa2l2SWFrZUhEZDR4N2Joc2tCNDZJS2Y4MkNzTDhvNVpMSTVGY0ZPZmJR?=
 =?utf-8?B?WHBLMTY5ZlRFazIwNVZRY1h3czllOFNHRVVhNndZUmJ1QTF5VmpNeVNRUWpO?=
 =?utf-8?B?QmxlTGwreUZlR0dvNkVaSmw2bHZTUWd6SURvdjlYWG45cGxJaWFiOHpyb2ZM?=
 =?utf-8?B?bFRsei9qZ0dqSDJwc2dXWWVYcjduZmRKeWhEVCtKQTgzTTBvTEp3TktZeUg0?=
 =?utf-8?B?b21wME80S1RvcVRXT3ZMTE9BNm9WeXV0MUhvMGVEKzl1TlExOXgxM1JyNHFH?=
 =?utf-8?B?TlZkc2dGMVZaTk9sZnRPdUFOZkdJczRyMDc1M2g1cDRodjJOQVc2cGI3b2ps?=
 =?utf-8?B?bmc1NDdRUXAwMVNjbm5DTExIb3BZalNDUlVrOEs3N1hWUGNrdFhoTGVkalN5?=
 =?utf-8?B?N3J2V0wySnZuRmFia0RSZXFHZ0FGU2ZQTVlzSitQcFNsWWQ1cTFnaDVKMVhk?=
 =?utf-8?B?UzRqMEw2Wm41WVl2VWRJZ0xTYXV5RGc4UTRPSmdLZjN3Yml6M1ljblpwMUZV?=
 =?utf-8?B?NzArSUZUZjk4TW5RVUdEWEE1Z2p2R2FNN05YTU96WENKeXRrb0xWOVY3OGJ1?=
 =?utf-8?B?UTNjOU9xWldEamJONHdvSmljZTcrOEtqbXd4WTMyTzd1Uy8vNCtWTGVMN2tj?=
 =?utf-8?B?a3p5eGQ3TXh1eDd1TGw0MEZubzVLMGEwVnM3VUVXSEFZcGRQYlNPZUZySUNr?=
 =?utf-8?B?akFRU2VSY1pFVjhQR2VITTZtUGdYeXF1VnpaN2ExdTdkRkJuL05ZMTZkd2Fn?=
 =?utf-8?B?NU1ueEFVYUp2Y3FBdkF3OUVFMUNSL3VTUEdGelNDWkJocnB0YVFvUHdhalZS?=
 =?utf-8?B?dGRYNS9QNXdGU0Zhd3NEcmdDQ2JKV0NTdSs4S1pCYnNDWkk2VzhBWldDYkND?=
 =?utf-8?B?TkJhN3QzOG5VdUVPSXZ6d3NOUks1cS8ySWRVR0o4WlZFTDMzWFVtWFhBeU9h?=
 =?utf-8?B?TVd0N0ZoYmFOV1hZdmlnOVhDVDVaamlCTW5NWmkzQlFweWJXKzcraCtpVTZR?=
 =?utf-8?B?S0pKOVc4d2w1ZWU0Z1l3VEhkeGVsMWRmMDhuRTF6S2JMb24yU0FsVUhHQ25W?=
 =?utf-8?B?UlB0TDY2SnkwZVRkM2pjeFlxQTlud0wrcUY4cWMydEN5S1AvWk5XbXExRzVF?=
 =?utf-8?B?OEVaZTlMbzM3MFlXakI1OENtT204a3NWUEJ0N0lSeUVPbWVEK3NuR0hHeGhT?=
 =?utf-8?B?ZkxJUTMzTG9DbVk2L0p2NFNxWERLSlNGSE5QdnlrZmhDZkgydU9RZWxFZ3py?=
 =?utf-8?B?VnM1YnpYQUl4T3VsNkZTajE2WS82TjNGbjUreWE4a2YwVWUraDZsOVhYVVpT?=
 =?utf-8?B?RW1hdnBsbWplamtHeVdHZXZuRHEvQTRLYVVnaVVKT0M2VG5BQmdpNU5zVmtW?=
 =?utf-8?B?L1ZTclJlMTkwcG1qZS95MExabnd5bmpsSlFybXhIQXF2SkpNMHZaZ1BNNFpJ?=
 =?utf-8?B?TzZGOGlDMWhDRFZsS01hTm1IRlVZbDhoL0pFd3Q3ODQxUHBOeE5NSzljU0t5?=
 =?utf-8?Q?9jN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b57de6-b247-407d-0bff-08ddb8a0ecd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 13:12:26.3458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rsn34MV8/zOI0rZcpCt5xwnw14n1gbTGk5E5gkSzGcxWQ2gAcATJf9yn/I2sDDJw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI1LCAyMDI1IDM6NTIgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDcvMTFdIGRybS9hbWRncHU6IGFkZCB1c2Vy
IHF1ZXVlIHZtIGlkZW50aWZpZXINCj4NCj4gT24gMjQuMDYuMjUgMTA6NDUsIFByaWtlIExpYW5n
IHdyb3RlOg0KPiA+IEFkZCBhIHVzZXIgcXVldWUgdm0gaWRlbnRpZmllciBmb3IgZWFjaCB1c2Vy
cXVldWUga21zIG9wdCBhY2Nlc3NpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCA0ICsrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAyICstDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oICAgIHwgMiArLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBpbmRleCA3OWIyNjNjMThlYjEuLjAy
MDhjNmI4YThlMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91c2VycS5jDQo+ID4gQEAgLTUwMSw2ICs1MDEsOCBAQCBhbWRncHVfdXNlcnFfZGVzdHJveShz
dHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIGludCBxdWV1ZV9pZCkNCj4gPiAgICAgcG1fcnVudGltZV9t
YXJrX2xhc3RfYnVzeShhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsNCj4gPiAgICAgcG1fcnVudGlt
ZV9wdXRfYXV0b3N1c3BlbmQoYWRldl90b19kcm0oYWRldiktPmRldik7DQo+ID4NCj4gPiArICAg
ZnByaXYtPnZtLmlzX3VzZXJxX2NvbnRleHQgPSBmYWxzZTsNCj4gPiArDQo+DQo+IEkgcmVhbGx5
IGRvbid0IGxpa2UgdGhhdCBhcHByb2FjaC4gVGhlIFZNIHNob3VsZCBub3QgaGF2ZSBhbnkgc3Bl
Y2lhbCBoYW5kbGluZw0KPiBkZXBlbmRpZ24gb24gaWYgdXNlciBxdWV1ZXMgZXhpc3RzIG9yIG5v
dC4NCj4NCj4gV2h5IGRvIHlvdSB3YW50IHRoYXQ/DQpUaGlzIGNoYW5nZSBpcyB1c2luZyB0aGUg
aXNfdXNlcnFfY29udGV4dCBmbGFnIGZvciBpZGVudGlmeWluZyB0aGUgdXNlciBxdWV1ZSB0YXNr
IHRvIHNlZSB3aGV0aGVyIGl0IGhhcyBiZWVuIHNjaGVkdWxlZCwgYW5kIHRoZW4NCmZ1cnRoZXIg
dXNlZCBmb3IgaGFuZGxpbmcgdGhlIHNlcXVlbmNlIG9mIGF0dGFjaGluZyB0aGUgZXZpY3Rpb24g
ZmVuY2UgLiBUaGUgZXZpY3Rpb24gZmVuY2UgaXMgb25seSBhdmFpbGFibGUgd2hlbiB0aGUgdXNl
ciBxdWV1ZQ0KcHJvY2VzcyBpcyBzY2hlZHVsZWQsIGJ1dCBpbiB0aGUgYW1kZ3B1X2dlbV9vYmpl
Y3Rfb3BlbigpLCBpdCBhbHdheXMgYXR0YWNoZXMgdGhlIGV2aWN0aW9uIGZlbmNlIHRvIHRoZSBC
T3MgcmVnYXJkbGVzcyBvZiB3aGV0aGVyDQp0aGUgZXZpY3Rpb24gZmVuY2UgaXMgdmFsaWQgb3Ig
bm90LiBCYXNlZCBvbiB0aGlzIGZsYWcsIHdlIGNhbiBzaW1wbGlmeSB0aGUgZXZpY3Rpb24gZmVu
Y2UgYXR0YWNoaW5nIHNlcXVlbmNlIGFuZCBvbmx5IGF0dGFjaCBhIHZhbGlkDQpldmljdGlvbiBm
ZW5jZSB0byB0aGUgQk8uDQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+ICAg
ICByZXR1cm4gcjsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTUzNSw2ICs1MzcsOCBAQCBhbWRncHVf
dXNlcnFfY3JlYXRlKHN0cnVjdCBkcm1fZmlsZSAqZmlscCwgdW5pb24NCj4gZHJtX2FtZGdwdV91
c2VycSAqYXJncykNCj4gPiAgICAgICAgICAgICAoYXJncy0+aW4uZmxhZ3MgJg0KPiBBTURHUFVf
VVNFUlFfQ1JFQVRFX0ZMQUdTX1FVRVVFX1BSSU9SSVRZX01BU0spID4+DQo+ID4gICAgICAgICAg
ICAgQU1ER1BVX1VTRVJRX0NSRUFURV9GTEFHU19RVUVVRV9QUklPUklUWV9TSElGVDsNCj4gPg0K
PiA+ICsgICBmcHJpdi0+dm0uaXNfdXNlcnFfY29udGV4dCA9IHRydWU7DQo+ID4gKw0KPiA+ICAg
ICByID0gYW1kZ3B1X3VzZXJxX3ByaW9yaXR5X3Blcm1pdChmaWxwLCBwcmlvcml0eSk7DQo+ID4g
ICAgIGlmIChyKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiByOw0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBpbmRleCAzOTExYzc4ZjgyODIuLjVlMDc1
ZThmMGNhMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
DQo+ID4gQEAgLTI1NjAsNyArMjU2MCw3IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ID4gICAgIHR0bV9s
cnVfYnVsa19tb3ZlX2luaXQoJnZtLT5scnVfYnVsa19tb3ZlKTsNCj4gPg0KPiA+ICAgICB2bS0+
aXNfY29tcHV0ZV9jb250ZXh0ID0gZmFsc2U7DQo+ID4gLQ0KPiA+ICsgICB2bS0+aXNfdXNlcnFf
Y29udGV4dCA9IGZhbHNlOw0KPiA+ICAgICB2bS0+dXNlX2NwdV9mb3JfdXBkYXRlID0gISEoYWRl
di0+dm1fbWFuYWdlci52bV91cGRhdGVfbW9kZSAmDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBBTURHUFVfVk1fVVNFX0NQVV9GT1JfR0ZYKTsNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgNCj4gPiBpbmRleCBmM2FkNjg3MTI1YWQu
LjFlM2MwZjg1Yzk4ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5oDQo+ID4gQEAgLTQyMiw3ICs0MjIsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3ZtIHsNCj4gPiAg
ICAgc3RydWN0IHR0bV9scnVfYnVsa19tb3ZlIGxydV9idWxrX21vdmU7DQo+ID4gICAgIC8qIEZs
YWcgdG8gaW5kaWNhdGUgaWYgVk0gaXMgdXNlZCBmb3IgY29tcHV0ZSAqLw0KPiA+ICAgICBib29s
ICAgICAgICAgICAgICAgICAgICBpc19jb21wdXRlX2NvbnRleHQ7DQo+ID4gLQ0KPiA+ICsgICBi
b29sICAgICAgICAgICAgICAgICAgICBpc191c2VycV9jb250ZXh0Ow0KPiA+ICAgICAvKiBNZW1v
cnkgcGFydGl0aW9uIG51bWJlciwgLTEgbWVhbnMgYW55IHBhcnRpdGlvbiAqLw0KPiA+ICAgICBp
bnQ4X3QgICAgICAgICAgICAgICAgICBtZW1faWQ7DQo+ID4NCg0K
