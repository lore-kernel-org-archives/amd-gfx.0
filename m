Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC579C3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 02:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7168F10E0C0;
	Tue,  6 May 2025 02:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2zkcrZq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCA010E0C0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 02:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkDO8rfee7JJUqX0+X0tkXf6KbvrYQJ5HMjNpGVGu7waA9IKlya50U87udPgzmkMEevVzRouZwDbMdiZkWuAZantcRnIKoEzNOZjB3qEV0PPu3lzEZ/IUtEQHXYYlEYh/4GU0pkHvHH3Lh+uLGwB96y4gNEuwl4+0olyKMF5MMY5DUDgcFapFUYSvOOk/nFP8RM0eUbHGMj7lqk6esC8/ztXo/Z7Ot2QfmzcxitQclDsVnxXVwhyLXDZDb+UGcslHkCu+XXDdPhRgqkB7WxkmE1ymlL7OTSYgD5UnksMC+8+1EiwY1YKUiReq7Oim6L0F+jcgiBDxDGtkiDRMbppEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bswlzumG6+IDpNazSh97DdKLlg2H5F5ds4qKL5oBu0=;
 b=t/XfE9IsPTrjgjLiDn2t8YljBYj42fyX8TgB8aEMkM8ptzxp7QJuIhBxekRq0K/VLy1dq7bbbPj6EhNS26xJPFPC5gh/LqXr4/puB/zNTSCkSodqUWVNVk+Qw3oP7yj3fXp5WmJ+w3cCd39hhfGIPGwlKiXJBMbL1yxgFQ5J4HDm9JMMzeTypzSpQwUJbTS/kmWFaHEfgf8O4Npv8Nf0oVtfjX0Vorh/TPPVKHekwfoSQEMxWriFCdTc81hj0NNeiN6zeWMSOv+JcrmYpqCIIyJdxhy3n5AFUjcl457zb/LMRJlOXAjjgWkYqhjlpib1HnHC+bkP/3rOX1RsLA5/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bswlzumG6+IDpNazSh97DdKLlg2H5F5ds4qKL5oBu0=;
 b=I2zkcrZqi/x/q/3DqMYDjmeovVmM5gwwI2LYacol3B0/AGiIIAMrGl3ViJxYxh5rsUZXfFXtmn47g/zZrcJF4Pt9TpIYCO3x/iFUQYznkyXbpNs6BrqMhxYUA9SOpOyA6/sSthDJ/d0ZiVZ8X3OiNVNztRLtnhNuPGVAgTSOGAo=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Tue, 6 May 2025 02:09:23 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 02:09:23 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
 fence
Thread-Topic: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
 fence
Thread-Index: AQHbuXlUoFUeeNQp8UqjNwfLDP6lvbO8Gu8AgAjI35A=
Date: Tue, 6 May 2025 02:09:23 +0000
Message-ID: <DS7PR12MB6005F0A315798BE0F22E05EEFB892@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-2-Prike.Liang@amd.com>
 <5f56c1c5-5bf9-42b9-b7c7-9e6508e803d0@amd.com>
In-Reply-To: <5f56c1c5-5bf9-42b9-b7c7-9e6508e803d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=86ab80aa-5286-4aff-b70d-163916267e3d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-06T02:05:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS4PR12MB9635:EE_
x-ms-office365-filtering-correlation-id: e0aa8ad1-ab48-4804-3b17-08dd8c43051f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Y3hoOWtZL2gwUnhFWllUdzlmVDF1SkpFWUFRa2VqUGhQVlUyYzZuakhkcnlp?=
 =?utf-8?B?Rndnalp2K1JkVEMxZ3dFU08wN2c0T0hSWHNTVFhtMmpka2ltN3IrcmZiTkpz?=
 =?utf-8?B?YXZzV3YrMlR2UVhMMW1sajFSN3Yya1hOby9NZ3RTNE5FY2w5Y2g2M3ErZXl6?=
 =?utf-8?B?eHFsUHZTbjZQTlZaVWEvNUpZYTl4OGJ5WHQ5eU5JcGdEUG5WVWlKd2VGWXl0?=
 =?utf-8?B?eTVzaldzeGYvY2JXWDdQZXhGaDNjY2NmQ0pPNExESFFTbkdITE9Bd3dKWlVw?=
 =?utf-8?B?SXRlRCt2RGNSbUxicUZIVTdDcndSWEY3QmNPZk9PYmtMMmNSK2t5ejJSdmRS?=
 =?utf-8?B?MnlLejlhYk9mb3lNWkJMT2NzSDBVcVFieEJkZTRYeDV5WkNLU05CbzRoZ0Nj?=
 =?utf-8?B?WVdZMy9SdlhlcnhLdVVBY0FDRmNzblA0eE5idHpXTzlHZ3pSUFQwYmZjbnZ5?=
 =?utf-8?B?VXphSnp1a2pITVpWWUl4NkN0TVFOY2QydTFRc21CNGd2UVZjYWNyL0w0a0hK?=
 =?utf-8?B?bkdlRmhjSW51ZDZWc3VDWDJ6SUJUZnFNczRUa2pONWZ2emVkQ3p5SzBCMnE0?=
 =?utf-8?B?bys4cS83NzZ0eFhrU2Vtbk83Zi9nMEo4ZE5hM3YrbjdJeVI3YjNnT25EaFpt?=
 =?utf-8?B?bk93ZXViazdJVVRtbEExK0QzY25rS2R5b1NZR1JWT3FPY0JYUlNBVTlSQVVu?=
 =?utf-8?B?Tm92anA5amlTREQ3SWtYSlRBN0plYXMvY1A2M09yV2JlcnlDNXRjNzV6ZEtL?=
 =?utf-8?B?UTg1UWJaQk5rRVBKWnBSQkRpb3ZhNGVVcnVmanBLL1RzQXkyNlVpdTJxME5y?=
 =?utf-8?B?a1cyNVVZa3RZeDBLekdtOXZFQjJJWkI2cVVIM0xwdTc3N3NKUU5aRjc0QTZs?=
 =?utf-8?B?bE5BN3ZBQlpvb25uQVQ0RmduV2JPalQ0VVI5dlMzd2ZVT3cwRVlocE9UamdJ?=
 =?utf-8?B?cmI4aE5MOUJwUExXSFFWMThJdElpdHRDOU05eEYxeTRhbk1CMTdpMEdHZTlt?=
 =?utf-8?B?a2ppWTVJMEFGZjNUalovR0Z4aDRVTlB4MU9mWEU5RGprZXdOemxYdWlhdkEv?=
 =?utf-8?B?OU9RNHdWL2dZbTFIN09uQk04QTNlanRST0k2cGhpSDI1OUpta3RqNW4zME5D?=
 =?utf-8?B?THQ2dzRSNXEveC9XSHJuZkZFYkwxRGVlZGxMY1oxajJGV0RTbm14ZW1aQ29l?=
 =?utf-8?B?WUl0TzB0TGdkU1o3YlRkL2ZEOTRpUFJNUmRkTmVBemd3L3hIc0dWTDQ1aEZN?=
 =?utf-8?B?Q1NUY2dMcnhaSUZRVVgzTUZPT2VvRVYrenorNmtBbFR5ZGw4bjR3YndVdCtj?=
 =?utf-8?B?VWV0VENwYWlUQnJwa21mV2VLcVdoR3BTeW9SZUJhMnNzWURTS1owTWxOVk4z?=
 =?utf-8?B?ZmZGTURzYStqa0ZYeVNxOEFBeW1rbTNVc3g4ZCtqYk1GaTdEblZkWFIvakJU?=
 =?utf-8?B?eUowOENyZGMvVXphQ0l1UkN0NGFCRmk3ZFpIT1VwcStNa0c1WS9YTEMyU0xN?=
 =?utf-8?B?Ni83djl1Y1lpYWdJL3p1REFNTnBxV3p6Wk5tait2L1ZkcGVkakZiMUFBeHJG?=
 =?utf-8?B?Q0tSN0xsc0tIaTlqWGFqRHFaSWxQMVpOaURWVXkyT0MvcEJJOUhGODVHYk9F?=
 =?utf-8?B?RWxPMG9SMnIxOUdCRmhNd2pyS1Z5T0FJRHcyVDluYmZ2ei9makpoa29Qem8w?=
 =?utf-8?B?aW1XNGlzU21QZkxLUFV4OXVUY0xpQ3cvMVhJWDBpZzkyZzh1VkNmZHVkajBH?=
 =?utf-8?B?d1dZUWdFbE15VWJnTENWaFVTaXFZVnhBUmh4bmJaMzQzdlFsZWFqeUZjM0Zx?=
 =?utf-8?B?aEtvOHZDR2tvelQvMXoyeHNZektzdTQ2akc2Qk8xcHpkb2dkUmh5Z3hvcHBV?=
 =?utf-8?B?Nmo2dWhwWkVrdjFHWVlTaTJIWWdNT1JDb3lhclMrRFBLOFBHTEM1TDZUdklW?=
 =?utf-8?B?SldOczJXaitDdjYzc292Vm4xd2VtM1RXQzVPd1FwcGhYMGFWY2FJZzBoM0Mr?=
 =?utf-8?Q?Z+FHi1z5A3/RpWhmqFhQeyrcobOFGM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkw3eFc3cXNGa1MxWEVmNGxrckh3Nm9KcEZlTHFEeFBWVjJwRkw4eTYrUndG?=
 =?utf-8?B?RGNIa2lQcFdoM0JYY1hPTlRuNHU5eGx0am90RTdWWHgvQnZJTWFtMFlOcUh2?=
 =?utf-8?B?WEZ4SlB5TGVhL2VEcnZnaDdqV05PQkUvN09jVXpmYXZRdWkyQ0hpVVFwZ1Nk?=
 =?utf-8?B?YmdFR1pIelJzbGdvLzRiWEFVeW1Kdnl6SDl1NElNRVpRZnQxSGlmdUV5T0RQ?=
 =?utf-8?B?R1IwYURIRjEvdUthOEdyMCtYam9lNjdtbjdPZlRPNFpZS2JaZ0xCMnhzQkkz?=
 =?utf-8?B?TG9ZZkprZ3dDWXJySklDSWNLUUJuUjZTd1kwYjN5bWN6MDJjcmxKZno0WmdU?=
 =?utf-8?B?SnBNcXdYbDVKR1NaRWpqZENxakpuVWRacUZLQUNCb1FLak1uNXFTTXdTNm5U?=
 =?utf-8?B?UWJxK2tyWlUrdzBJRmprbUlHaDI2bHY5VXRQUloxUzdxaDI4WFRPVDRZa0NI?=
 =?utf-8?B?NHNGa2xjMDRpNWFPLzZ6a2hwM2NQblFIUFdVYzVzRHJnM2RFcDVBUzBxSE92?=
 =?utf-8?B?bFhHQjZWcjR0VDZEYzZ2TG5BQnJUVCtjeVdmZHI5dVZacisyNHJJSStKOWpH?=
 =?utf-8?B?OHFKaWpSVkJvZThwUDhIbk9DMktZK2N0TzNONTYzTnJ5WFBBc2x2L1luZTRh?=
 =?utf-8?B?cnJhV1A0Q013akVDYmNBWnlmVG1wMll1OG5maWJqK0FXUnFDVFdCb2J5VlJ5?=
 =?utf-8?B?WTRLdUVyNlJQUWVCZjQ5TFdPUjNMZlVDazQvZzh5elJqdnhjREFyVGszdzA1?=
 =?utf-8?B?V3ZBMWNWSXhhQ2EyQng2QWpxV2hsL3lhTG9hNWxJeXNjZmlCenNNWjNEYktH?=
 =?utf-8?B?ckF6dVpJZ3IzMVVHbWhJUnVSYi9MUEwxTWszbUI1VUdMUUZ4VlVEa3JWa08v?=
 =?utf-8?B?eHgvQmIvL3ZpdHM4M2NaTGM5a2VCSUcrK2hFMHF0Z3FhNjRTbUY2b0RvY2Q5?=
 =?utf-8?B?NXQrL3JjVkFWS1A4QnJrajN6WDBJWXRRNnhPZWYwWFF1ZFVqcXkvRmxtK0xi?=
 =?utf-8?B?TXpVeExPbVJHbW1sUEEzMjhCYkhJUG82Z3FtazZ2QVYyT1dQdU9LNXVXMmM2?=
 =?utf-8?B?b2ZldFZlWlQvZEN4c1NmclVCRUI3Mm9FcUR4Y1JEcWo1cnVFZVpBNWNqdjRu?=
 =?utf-8?B?SEFORmpjRFdTZzh6bEMwUzFReVlGQkl6emM5MVhScHJ2Ulc5b2swWmR1LzhZ?=
 =?utf-8?B?b0sweHk2Z2VNSUVlbzdJdndraTRlTkVRU3QvbHFvVUIwRG9QbUlGbnMwQmRL?=
 =?utf-8?B?clc0YXFJdGtYTE1sTmdrZkZ4UkxraGV0STBDWW9NRmxZdHhRbnU0K0IzbUQw?=
 =?utf-8?B?QWJTcFBnTWl1ajRrSlU4NUwrUi90Y1M2bzdGYWNMeCtTV0QybG5JMUJ4RzA3?=
 =?utf-8?B?aHFQOG9HTjNzT2grVXNFTmFkcEZCZkp3ci8raE04Wm1uVG1rdWJTcm5NbE9J?=
 =?utf-8?B?NjFjYW9kVGNFNUJoc1EydklIRk1sSXh2M0RCMW1ZL2VhMUI2SXd0Q1dRRFdy?=
 =?utf-8?B?SEVTTnpiSGZtVk0yR1J2SmtNOTMvVnp0dExSYmFMQ2treCtqM2tUZDNseVpH?=
 =?utf-8?B?aDR6TjBpMktSd2wxZEpuMGpVQWZwaEUxUWFoSmVQcTlnZUZQWHRTdjFhTi9q?=
 =?utf-8?B?b2lhbjhlVnY1RU53K3psNjhkeDVCNmpYQkZ0YmwzTk9pdlFQZDVYZVE1clNt?=
 =?utf-8?B?M0ZqUFQ4K1Z3b0lTS09NNkRTNkRDS1lRZmowbVl2Yjc4dzFzRVArdmNpNjBk?=
 =?utf-8?B?UG9VYlRLWGRVV2dQb1JwZitDRFF4Nzlldlc4aVVCNDhvNEIrMFQyd0RQNFdI?=
 =?utf-8?B?RFNxeDBRdkh0aEdKVEUzUWFFc2lPSHdyam43dTJDRGtGUGJ5VVkxWHBXQTNW?=
 =?utf-8?B?RnU1NmJtZWRIb0tjajdyWDRZQUVtY0hVUjFWdVNWcUpFN3hBQXYzMjM3OGNv?=
 =?utf-8?B?aDkxRDBKaGllYzkyWlUySG9hRCtyb05kcDJtZkJkdEhWemRqbmJ6R3Zjd1JJ?=
 =?utf-8?B?WXdPK3QzVFAvU096bFlYZUNneUh5dVM1Kzh6VWpaR2ljemt4V1lhSFFqcWhy?=
 =?utf-8?B?QVp6N0FJdGRDRG5mOW5DOXpERXJabFhyRmdsbjZZelBzeERXZGswcjM2dW9S?=
 =?utf-8?Q?RTD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aa8ad1-ab48-4804-3b17-08dd8c43051f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 02:09:23.2498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkuhi1ySgQBHZc5DxpYQ7DgHt7vavwwVsCoFXh3jnvOwUgeSCakxvvITkDa0f7ZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDc6NTcgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi81XSBkcm0vYW1kZ3B1OiBkb24ndCBz
eW5jIHRoZSB1c2VyIHF1ZXVlIGV2aWN0aW9uDQo+IGZlbmNlDQo+DQo+IE9uIDQvMzAvMjUgMDQ6
NDAsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IERvbid0IHJldHVybiBhbmQgc3luYyB0aGUgdXNl
ciBxdWV1ZSBldmljdGlvbiBmZW5jZTsgb3RoZXJ3aXNlLCB0aGUNCj4gPiBldmljdGlvbiBmZW5j
ZSB3aWxsIGJlIHJldHVybmVkIGFzIGEgZGVwZW5kZW50IGZlbmNlIGR1cmluZyBWTSB1cGRhdGUN
Cj4gPiBhbmQgcmVmZXIgdG8gdGhlIGZlbmNlIHJlc3VsdCBpbiBsZWFrYWdlLg0KPg0KPiBQbGVh
c2UgZHJvcCB0aGF0IHBhdGNoLCBpdCBzaG91bGRuJ3QgYmUgbmVlZGVkIGFueSBtb3JlIGFmdGVy
IHRoZSBjaGFuZ2VzIGluDQo+IHBhdGNoICMxLg0KDQpZZXMsIG1heSBJIGdldCBwYXRjaCMxKCBk
cm0vYW1kZ3B1OiBwcm9tb3RlIHRoZSBpbXBsaWNpdCBzeW5jIHRvIHRoZSBkZXBlbmRlbnQgcmVh
ZCBmZW5jZXMpIHJldmlld2VkPw0KDQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9m
ZW5jZS5jIHwgMTEgKysrKysrKysrKysNCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZXZpY3Rpb25fZmVuY2UuaCB8ICAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3N5bmMuYyAgICAgICAgICAgfCAgNCArKysrDQo+ID4gIDMgZmlsZXMgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+IGluZGV4IGQ4NmU2
MTFhOWZmNC4uNmM5YjJiNDNhOTI5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBAQCAtMjI0LDYgKzIy
NCwxNyBAQCB2b2lkIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9kZXRhY2goc3RydWN0DQo+IGFtZGdw
dV9ldmljdGlvbl9mZW5jZV9tZ3IgKmV2Zl9tZ3IsDQo+ID4gICAgIGRtYV9mZW5jZV9wdXQoc3R1
Yik7DQo+ID4gIH0NCj4gPg0KPiA+ICtib29sIGFtZGdwdV9ldmljdGlvbl9mZW5jZV92YWxpZChz
dHJ1Y3QgZG1hX2ZlbmNlICpmKSB7DQo+ID4gKw0KPiA+ICsgICBpZighZikNCj4gPiArICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgIGlmIChmLT5vcHMgPT0gJmFtZGdwdV9ldmljdGlv
bl9mZW5jZV9vcHMpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKw0KPiA+ICsg
ICByZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gIGludCBhbWRncHVfZXZpY3Rpb25f
ZmVuY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21ncg0KPiA+ICpldmZfbWdy
KSAgew0KPiA+ICAgICAvKiBUaGlzIG5lZWRzIHRvIGJlIGRvbmUgb25lIHRpbWUgcGVyIG9wZW4g
Ki8gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2
aWN0aW9uX2ZlbmNlLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9l
dmljdGlvbl9mZW5jZS5oDQo+ID4gaW5kZXggZmNkODY3YjcxNDdkLi5kNGUxOTc1Y2FjNzEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9u
X2ZlbmNlLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZp
Y3Rpb25fZmVuY2UuaA0KPiA+IEBAIC00Miw2ICs0Miw3IEBAIHN0cnVjdCBhbWRncHVfZXZpY3Rp
b25fZmVuY2VfbWdyIHsgIH07DQo+ID4NCj4gPiAgLyogRXZpY3Rpb24gZmVuY2UgaGVscGVyIGZ1
bmN0aW9ucyAqLw0KPiA+ICtib29sIGFtZGdwdV9ldmljdGlvbl9mZW5jZV92YWxpZChzdHJ1Y3Qg
ZG1hX2ZlbmNlICpmKTsNCj4gPiAgc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZSAqDQo+ID4g
IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9jcmVhdGUoc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5j
ZV9tZ3INCj4gPiAqZXZmX21ncik7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+IGluZGV4IGQ2YWU5OTc0Yzk1Mi4uOGFjNjg1ZWIxYmUx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5j
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jDQo+
ID4gQEAgLTE4NSw2ICsxODUsMTAgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3N5bmNfdGVzdF9mZW5j
ZShzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LCAgew0KPiA+ICAgICB2b2lkICpmZW5j
ZV9vd25lciA9IGFtZGdwdV9zeW5jX2dldF9vd25lcihmKTsNCj4gPg0KPiA+ICsgICAvKiBkb24n
dCBzeW5jIHRoZSBrZ2QgdXNlcnEgZXZpY3Rpb24gZmVuY2UqLw0KPiA+ICsgICBpZihhbWRncHVf
ZXZpY3Rpb25fZmVuY2VfdmFsaWQoZikpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiA+ICsNCj4gPiAgICAgLyogQWx3YXlzIHN5bmMgdG8gbW92ZXMsIG5vIG1hdHRlciB3aGF0ICov
DQo+ID4gICAgIGlmIChmZW5jZV9vd25lciA9PSBBTURHUFVfRkVOQ0VfT1dORVJfVU5ERUZJTkVE
KQ0KPiA+ICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KDQo=
