Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2551C3ABD9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 08:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DB989A77;
	Wed, 14 May 2025 08:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgopAlA5";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C8D89A77
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 08:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scCQtEXyN779ssFcxwF7TaggDzmsUkpfs8RuH1F5gude8A4FCP2Rtn/01RowHUebmm/x/g3AY4HeHonlkAEMTwsOoqRjDpsfypDAsU/YL232s7y+BYIjvn0EFTqFNvQ3uHzGZSxRtZEVIdPJWLCUQKbIHFWJg1eJWFqyyjnNkpdTmBa6RUfIyeDtrTsU2+/vyYUTmFnffiJ6n0ddOA81MMkgQmvZHtfJSzT7oLxXEJgliWIbOUXa4bR+b0D9sa5m459kd/FyTfUjzaObC2Q1L5XuuJBmZ4PS7j7S8WBLGaYZ+mLNdudbGNkdPUI/ez8Ve0CFdpu/SzS/U01aslFELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmbnd8AkfYrTqdltAk6YhbpTIGo112Ow0L2jcXoXSIw=;
 b=rThxds7I+ynEYANIWeBuT7VQ2uQM8U5HSqp6o/Y28BvMBj7CHQmHgmwsdTmxbivAx23PcP1UGA9EaL5zchpW4Q9WFeLkg6X0kk253/jfRTcukm8moht7LJgmfP2WpMvH/uZpbqVX6o8xJvad5wn2ISYqXJTqKT5yPx2g6iANV/fXPaKEvRBHihduVr7G7t1kdioFuYoVkS3hgrhxtYd2hWOMyuKd2HJrqy9knVZbPwDn84G+8Aha+sH9BqygC4HoQQoQXC4W4VjI8pMdl/aNfyGH/ZLXMja+Z4SZGoQ6chORWWYAZeLyMS93+CM1c0NEFIlJLpwcqL+n7hi7TcMH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmbnd8AkfYrTqdltAk6YhbpTIGo112Ow0L2jcXoXSIw=;
 b=vgopAlA50KrwUQk4jC2k2yh0jQSKGse6SORJWVvhH8oYCug88eLICOGU3pPC1JKg7DXQp/JO+MwHE1cN1hFexhbA0KA29+0vzu0UTU9kZUdRNHDOIKbvyX+RxbpfW+Ior0GvsDabiVIzN8u15SAnnK9hsNjixJIAhUtU43oRnbc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 14 May
 2025 08:19:12 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 08:19:12 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix userq resource double freed
Thread-Topic: [PATCH] drm/amdgpu: fix userq resource double freed
Thread-Index: AQHbww+2KZNIblBJS0G79Jqg9vVHOLPRth4AgAASM+A=
Date: Wed, 14 May 2025 08:19:12 +0000
Message-ID: <DS7PR12MB60054EE620EBE4EC5E00C161FB91A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250512073002.401719-1-Prike.Liang@amd.com>
 <afa44c90-2e7b-4fef-9a64-b869980d39b7@amd.com>
In-Reply-To: <afa44c90-2e7b-4fef-9a64-b869980d39b7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1773e066-7897-413a-9e41-7a79441e2f11;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T08:07:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB7866:EE_
x-ms-office365-filtering-correlation-id: d5ec8530-1c3d-454f-0d9c-08dd92c0021e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ekIrK0M2ZWNhM3JvRFBvU3BxakxKTm5aNys3OGx0VFpnZTluV1JkWFNvZjl3?=
 =?utf-8?B?SW9CSUN5d2QzN3gxYmZvU0MrdUFlU1BaQzFNTWh2M3dYOWVsclhoWnEzTWhj?=
 =?utf-8?B?azFBcnNwdVVqRnZCS1crWFhtb2FJNTZBdDN5YU1kSU9YNndjTWVaTnVXeDdq?=
 =?utf-8?B?bUlKK0t0NzBhZktRU0FmS1F0Mnh5Z25vZE9OV09QUmtpUXNLeWhab2w0YzAr?=
 =?utf-8?B?S0kwOEJYdEwxZDNBMmhXSW82U1pPMStlbm1VaFh3WEEzTzZtdGFVdFV0MFRB?=
 =?utf-8?B?dkltT1p5RmRKelpjbmdGaE5qOGZ2cWgxcHo5MnQyb2piYTlxa2FRYThMZTRR?=
 =?utf-8?B?NUoxTktENGRSdGdNZExxUUV2NHJYbWtVVzJVVnptK1A4QnUwcUJleWhRaHBC?=
 =?utf-8?B?Z0FBc09wVTdObHppZ1NBaHVkRmlEYVhSbXI4ZWlDK2Y1cGRXMUFWL1lYWGVo?=
 =?utf-8?B?T3ljNEJZc2tPOUxOa2xKWjFYYUdydGFNZ2hTaHdJbFZpeFJuT1d1KzdPelI2?=
 =?utf-8?B?RERTU01DRThySStLUFJ3a3QwMndmNXczUURYczRITXhma2tvd0pJbk40U3lh?=
 =?utf-8?B?NDdaOXhSbjV5aWdpNXMxS0RzK1N0UXExenZmYXJJTm94QkVHbGtZSmUrWFlX?=
 =?utf-8?B?WCttS2tPNklDeU1CQW9JbVdIWmJ5dTBDMlplcnFIOUZReDBkbjNkb2ZJUFhE?=
 =?utf-8?B?NU83Q2k0anl2SllNMUFNcWI4L3FqbG0vK3BZZUtTMXU2dVl2TXNZWEtFMU1M?=
 =?utf-8?B?aUlxMTRHb1hDMUtveFpxYWo0ZzlaRjF6MXZ3ZnZFMFliU0U5RTB5akdUVmxz?=
 =?utf-8?B?S2JBaStnWE1LaGIyUnJRdTNXYVE4Q1BSMk1UTDdpL2tNSTl0ZzI2Y0pXeG8y?=
 =?utf-8?B?WjVaU0lBM3doZklxSGw1NkFSMG1UWGRtMndvZkxaWllMcWhiL3kzbjRrWGV1?=
 =?utf-8?B?c2FSYklHNnhINVcxbmZROUtqVTJldVZNNzZDNzZzL0E0akNPdmtFRGZsdUN5?=
 =?utf-8?B?Q3duYlRHOGxRY215aVNFWDg2RUNQbmZaSXRwTml2SVF2TEwwTzE0a1g2bURn?=
 =?utf-8?B?Z3VkNTB4Y3FNVGVqbGtTdWZLWmJ0TEVOQ3l6a2tLRXlnWWRxY2piWXo1OXVJ?=
 =?utf-8?B?RlpxWk1yclFFNWU5MXRISG1jYmM0aXMzeUJYNTFDM2dhWkVIZWozMmE4STMw?=
 =?utf-8?B?ZStwZ2tGdUdiV2krOHh4eXdlWVQ4dURZS2RkSC9hdWxpTjRLRWNlMmEydVkx?=
 =?utf-8?B?OGljS09ONG5yMmRzYkEwamczWW1qaUdvcnZpZGdBT09XYWNSZjVLY28xTTFN?=
 =?utf-8?B?TmYwVnMzYTZobDhpNDVFWHdZR2JJeGNnK0gyaGJtNXFkblU2ZU5ac0VNZkdD?=
 =?utf-8?B?M3NsY2IrNmgwSFEzVzNBd3g1TDRlUkVPS3JLYWcrQkRQVTZidGQyZlRvUVRY?=
 =?utf-8?B?d1lDMUtXSzJJOC9IdnJ1Vi9CR3dJZUFOSlF5VEwvWDRlQUx4SjJPV1YwQ1By?=
 =?utf-8?B?Y1ZDdHdGZHozb3hsWFltckN6V2ZOaDNLd2NOOG5EUzFGZUtraDU2WG9IRkkx?=
 =?utf-8?B?S091WC9aS2MrOGF6WlhoT014c2hpNkxUVkphVjEvRStsNlpod1ZqMHB3OE5L?=
 =?utf-8?B?V3hnT0FFNmIrdEVoUlUzNEpZa2hDK0hHekhkalFqbHpoaVg2T29DM1pMRSta?=
 =?utf-8?B?NnFnZ3dzNnd5Njg2Wmk4ZE1jMW9JeUJQeXZ3cmlPVG5nSTJaanB2emdOaE5n?=
 =?utf-8?B?YmQrRkR5Z0RCaDVkU2xiYkRCU2p3R3h3VmJtd3FaZi9hek9oYVRSejkrRGpD?=
 =?utf-8?B?MnB1aC9pQmlSTzB4dnRlVlZXNHhjRDgrM3hvLzNwRFRYMzIwYTA1REhRZlVk?=
 =?utf-8?B?UmxIeUovcHpaSmR6bk1Hb2hxcnpCNmNOaFBpdkJvQW1tMnF0MjBQbTJHZGNh?=
 =?utf-8?B?MEt6bllEaEhNcy9WOERGRmpNNlBWYTVVZHNlU3YxaUN6L3ZIVnFCQkNzTXpn?=
 =?utf-8?Q?USV8wjBml2kUmYcWTR6rWJCLDR2xvk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uzg4d0JTeldIcEpncHBPcCtFb0FhczFVU3RXRjZGcHNQNkZJTy85WW5zRTF2?=
 =?utf-8?B?NnB3ZkdXdWo0SzByR0gwcUh4eVJSbGdMZkw2RmtFWFc0eExaVXA2RW1LTm91?=
 =?utf-8?B?UzViMzdldzQ4MVBOb3BQanFRNTNTL2Y3RHR0R2lKcDFwOHllcDU3TkZ6WVFF?=
 =?utf-8?B?TFFkbjdEWE9MU3NZK1lPOVdyVUxZRSsxS3VLaFZvN1htWUhmbDE4bFdmN0pC?=
 =?utf-8?B?QUVhRXVtcVpwUGwvNXlMbDl1MTBiSGZvbGJDMzZhODJJaStyMVUwdC93Q29B?=
 =?utf-8?B?WVRvRVhYK3VpajluSFp3Zkt0cDBsTFhDTEV4alRlOVdWT3I0djRKOHZnSDhP?=
 =?utf-8?B?cmF5d292MGduRC9pakRSNUU3QkdBVkJOY0pRdzhET0xSRkh2RFdUY0NuSFFm?=
 =?utf-8?B?OHFnZG5HY2lNMGpmOWVDcHpaRUQrUUhhWEk0MGY4Y29lMGtOSmZXa0hHMitv?=
 =?utf-8?B?S1lQSDZndnhram9GZnY0elZDN0l1VlhIUGY1dk5VenAxeUkreVUwNW9ZWU5E?=
 =?utf-8?B?WHIvd25GVFZpcjRJK1lJUUFSUnlMWjNZTm52aHNFK1BZbTFOUnRNUTV1bWY5?=
 =?utf-8?B?K09rRkdQejFJdFFacS83MU1mcjF2ckg4L3lkNUJoaFNlS09EbkZvZHBMTlBt?=
 =?utf-8?B?dUNWU2YzcmM3cnpNS2l0VDVzU0pMdm9hcGJSeTJ3QklWRkFhTXliNXJOV095?=
 =?utf-8?B?dlhUMnREQm9FZWNkVXpNUCt6eVREbWcwbDQwU2R0MGgvd3Fhaks0WUQ2U1JZ?=
 =?utf-8?B?QVhZcnVObFJFK2NjZC9HRFp6YmY0MW5MUWdiZUYyaTFwQVRTVUJDYWlNb2Zr?=
 =?utf-8?B?cC9tNm5KSFhjSFpRQkd1N09aYld0MW5aa2dFL2lPUnUzQ2Rnb1dtZUM0cFJD?=
 =?utf-8?B?Vjl0N0NlSVNMaksrbU9xWEtsYk00YjZudTcwWDhhUEhwVDNXMFV2dDZiQ1No?=
 =?utf-8?B?Qy9XbTdiOElOaFhjMTBZMGVIRGxzVkptWFRyOFc0bGZSTHU3WUtrWU16MTQ2?=
 =?utf-8?B?djN0Ym5Zdyt6cnJ2cVZ0M1htZnFrRXBsNFlIWkt5RG81NDVKVHI5aGViTU5D?=
 =?utf-8?B?dHZCd1hNVXpOc3dBVlFyODBRZk5sV1FzYXRuQ3lRRzZiNGc1bXdZYXdROHdT?=
 =?utf-8?B?TVN2b0VuR29mZzZTZVJFWjdUNGUwcWo2a1dKUGh5N0t0aktlZHhFRXJiTWJD?=
 =?utf-8?B?Y1JtZjFEbEFZOFBLL292QjJnYVQ3dzZpLzhqRFY4eE0zVHRBUk11NWk0Y2VP?=
 =?utf-8?B?dU13NG9vMTR1WU9zRi8xbnF1YWtxckV1RjczOXB2YmFmT0lGcEp3SWtRMVVL?=
 =?utf-8?B?V0JWTHNWTWFqZ1N6cDhwdDdFZ0tTSDlUSVBEelVOK0ZYcTN6MjhLSnZOaXFj?=
 =?utf-8?B?eS9vcnh2VmVqVk9SeE1YeWpLb3htSWs4c29nU0N5SjNXWDhqS01YR3d3L0pR?=
 =?utf-8?B?WXBldGpBSjZsMStMNk40RXRzbUc0ZkRxeDRwTCtMMFRKMkx3NlEzSm1RREVU?=
 =?utf-8?B?V2VsSU1YYnp5NlZZOEx5Wnp2eE1PbmpZUmRldHpyVWU5cnNDZkV1WGg3azNR?=
 =?utf-8?B?U0JzSzB4RWRsZ1ZLSXliUE1jZDNnMmpBWTlaM1oxQ3lPRFBRcGN5dlFHQXl0?=
 =?utf-8?B?S3FmMUFTZVJ0RGJkY0ZiaEYwd0Z3MndGc1R0ZnhRdy9kN3dadloyNEVhSmJP?=
 =?utf-8?B?eG53TXJzOGxodWkvS1NXeGdmM0ZrcWhqS1JoNjdwaU05UGgxd3VuTXUwWUtJ?=
 =?utf-8?B?MVdCVnVUQVM3aDdqV3cwSWpJZk5DZTdhTzdUY0djamZndElVRkNmQW8yRlZh?=
 =?utf-8?B?ZmRsMVBOYnNvdlgrZVJJdDBtYU5Ob0dpNzJzQTE3R1YwTVQzemNFSGN4amMx?=
 =?utf-8?B?ei9oNXNHSCtxVWE2ZUc0NlVlbWhmYUhoYXIvVUxNc2ROdkZxdTRFUC8zTGli?=
 =?utf-8?B?RFlNcVR3UWpzalV6VTdNTmtTb1RBWktzUWNsNUZTT05zMGRyWjEvM3poTDM0?=
 =?utf-8?B?WVI5T0hNNjV3NDVQN2lPbTAwUDZMKzNWWFg1MndhNWpBaXlMa0dmeWNvakpp?=
 =?utf-8?B?cWhmTHFvTFkyaWt2ekFodVhQNXZVc3Q5YlJuUHRZa2JGdEsxd0FodkNWOFpv?=
 =?utf-8?Q?CcK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ec8530-1c3d-454f-0d9c-08dd92c0021e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 08:19:12.2845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11XWJaaqPSuCdgioXcQB8ObKB6EZFnmO3LAyoZ575TdKnlCUPSq7rUIuouOg1pwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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
Cg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiBTZW50OiBXZWRuZXNkYXksIE1heSAxNCwgMjAyNSAzOjAyIFBNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggdXNlcnEgcmVzb3VyY2UgZG91Ymxl
IGZyZWVkDQo+DQo+IE9uIDUvMTIvMjUgMDk6MzAsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IEFz
IHRoZSB1c2VycSByZXNvdXJjZSB3YXMgYWxyZWFkeSBmcmVlZCBhdCB0aGUgZHJtX3JlbGVhc2Ug
ZWFybHkNCj4gPiBwaGFzZSwgaXQgc2hvdWxkIGF2b2lkIGZyZWVpbmcgdXNlcnEgcmVzb3VyY2Ug
YWdhaW4gYXQgdGhlIGxhdGVyIGttcw0KPiA+IHBvc3RjbG9zZSBjYWxsYmFjay4NCj4NCj4gQ2xl
YXIgTkFLLiBZb3UgYXJlIGp1c3QgaGlkaW5nIGEgYnVnLg0KPg0KPiBUaGUgdXNlcnEgcmVzb3Vy
Y2VzIHNob3VsZCBhbHdheXMgYmUgb25seSBjbGVhbmVkIHVwIGhlcmUgYW5kIHRoYXQgZnVuY3Rp
b24NCj4gY2FuJ3QgYmUgY2FsbGVkIHR3aWNlLg0KVGhlIG9yaWdpbmFsIGlzc3VlIGlzIHRoYXQg
dGhlIHVzZXJxIHJlc291cmNlIGlzIGZyZWVkIGZpcnN0IGF0IGFtZGdwdV9kcm1fcmVsZWFzZSgp
LCBhbmQgdGhlbiBzZWNvbmQgZnJlZWQgYXQgYW1kZ3B1X2RyaXZlcl9wb3N0Y2xvc2Vfa20oKS4N
CkF0IHRoaXMgcG9pbnQsIGl0J3MgbW9yZSByZWFzb25hYmxlIHRvIHJlbW92ZSB0aGUgdXNlcnEg
cmVzb3VyY2UgY2xlYW51cCBhdCBkcm0gZmlsZSByZWxlYXNlIHBoYXNlIGFuZCBqdXN0IGtlZXAg
ZnJlZWluZyB0aGUgdXNlcnEgcmVzb3VyY2UgYXQgcG9zdGNsb3NlIG1vbWVudD8NCg0KPg0KPiBS
ZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgOSArKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+IGluZGV4IDhkNGEyYWVkNzIzMS4u
Y2YwZjM1YTdkYWVlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYw0KPiA+IEBAIC0xNTAyLDEwICsxNTAyLDExIEBAIHZvaWQgYW1kZ3B1X2RyaXZlcl9w
b3N0Y2xvc2Vfa21zKHN0cnVjdA0KPiBkcm1fZGV2aWNlICpkZXYsDQo+ID4gICAgICAgICAgICAg
YW1kZ3B1X2JvX3VucmVzZXJ2ZShwZCk7DQo+ID4gICAgIH0NCj4gPg0KPiA+IC0gICBmcHJpdi0+
ZXZmX21nci5mZF9jbG9zaW5nID0gdHJ1ZTsNCj4gPiAtICAgYW1kZ3B1X3VzZXJxX21ncl9maW5p
KCZmcHJpdi0+dXNlcnFfbWdyKTsNCj4gPiAtICAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2Rlc3Ry
b3koJmZwcml2LT5ldmZfbWdyKTsNCj4gPiAtDQo+ID4gKyAgIGlmICghZnByaXYtPmV2Zl9tZ3Iu
ZmRfY2xvc2luZykgew0KPiA+ICsgICAgICAgICAgIGZwcml2LT5ldmZfbWdyLmZkX2Nsb3Npbmcg
PSB0cnVlOw0KPiA+ICsgICAgICAgICAgIGFtZGdwdV91c2VycV9tZ3JfZmluaSgmZnByaXYtPnVz
ZXJxX21ncik7DQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2Rlc3Ryb3ko
JmZwcml2LT5ldmZfbWdyKTsNCj4gPiArICAgfQ0KPiA+ICAgICBhbWRncHVfY3R4X21ncl9maW5p
KCZmcHJpdi0+Y3R4X21ncik7DQo+ID4gICAgIGFtZGdwdV92bV9maW5pKGFkZXYsICZmcHJpdi0+
dm0pOw0KPiA+DQoNCg==
