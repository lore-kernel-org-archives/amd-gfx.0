Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D2BC54E66
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 06:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B67510FCAB;
	Fri, 15 Mar 2024 06:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R6OxsL4o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9949210FCAB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 06:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwV3pRsVM+pK50D8WqmNibRXKJ9muqCPNH5sM/N+LIAyTRRECsPJX2xBhT2tY5ZhoB4N2mT5kYjq3p3QkKranGfqn7Lqb41vhs/4m4gm5xNy3g0qeGsXwhNTt9BHxrIcUAhMlU4DHgK9yEAAqwgJ1Gi9Jm7XczESlPCrNAwO7V5wbEK1ixGLya6s3w3OApmPRRlSYL10JCyDXGOHn4CpRI0Ua1EUmx9JQxrdDBeXXb2vPoyurQwIyOmkYJKx1OI9umVzWmsZmSRI0Lwpfa9FM6luzkk1j80JKvQ+mS64XiEwoIG1e/ylMf2N1KtevA/GPOAYBPgH0BshLfqnKq7y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fUIXxcb7J2Yet8WQilyrgE0W32saD+N4qYuivhbfW4=;
 b=XMpiwKAzViRo3M+DzZegvLkqQld0YFFg9BkqTtdDp41IrxFOY2gibe7SpT5rRKa84gzWSIqjrI6xCd80LJUUGM7xMGJMngPq8CtJleN+dGXfdoXT0ucU68TRPvGS3/sSut6rqgt2MPweSebtfqcvqRiIv61mWU5fOCsd3xhrwN35AKu52Vc2vYAhC4gFu7Qk49T1ZuELatHUrdvT9mKIimGk52fSPKvktiszHgHz2nW3/lZLin9c/jGig88NrMgWWaiwJf0ZkuPwc7yvQUaIQx4Gom0aAmONnYCQq5DTOUKb8NuE+S75HOIKvgLbwKrbcEdeccMpAXNsevZEYH+UCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fUIXxcb7J2Yet8WQilyrgE0W32saD+N4qYuivhbfW4=;
 b=R6OxsL4oatM0dUxBlQa4+WwZfEs9anIdD4sMGI39xJ/dEnYxfbC53OE3lETFB1+rqVIc7CKd/bujmvi6MJl577NRHp7Z4dT+iV/BiprVDGqvUrj/zMkn62kWinXIzJdfo3u75Xi8XxZDriDKZt8ILVHfD8QfflDZ+ZYgo0dmixQ=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.19; Fri, 15 Mar 2024 06:56:58 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::4730:f7bb:1576:31c5]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::4730:f7bb:1576:31c5%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 06:56:58 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Cheung, Donald"
 <donald.cheung@amd.com>, "Khatir, Sepehr" <sepehr.khatir@amd.com>, "Oliveira, 
 Daniel" <Daniel.Oliveira@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: Use metric table for pcie speed/width
Thread-Topic: [PATCH 2/2] drm/amd/pm: Use metric table for pcie speed/width
Thread-Index: AQHadpuJofRGiwhMvU+9e0X7MI2MDbE4XjcAgAAAX9A=
Date: Fri, 15 Mar 2024 06:56:58 +0000
Message-ID: <DS7PR12MB60712D1D94E62122163921ED8E282@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240315054149.3259906-1-asad.kamal@amd.com>
 <20240315054149.3259906-2-asad.kamal@amd.com>
 <5fd938dd-3df4-42bf-9dbe-f7c77f40e34d@amd.com>
In-Reply-To: <5fd938dd-3df4-42bf-9dbe-f7c77f40e34d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=58f47d3f-67d9-48af-9a0b-e74abc053a7e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-15T06:56:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA3PR12MB7879:EE_
x-ms-office365-filtering-correlation-id: 654eac4e-9c44-472d-74d6-08dc44bd1b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0O9K8ObozLuPXdDttO21YilIihXjPM0t0plQNSKUIyo6WBOWQmonryZqKTBKNcHSi2xy0xfZR/JNVIncgyLMpLke3nAuedlMHHWosK/34plqnHjuDZyowo0WHDDIbFGpGJ2R/gYk+OQqDLUwOYjwvFKDr7GsUfrz2VjsleSJAT9+L1B3Mgv3x51kXb24ZEkGDRBjSUe3jZXG97jmK1I6pP91dxHZiV8Q1KFjG2MbjSr39vBRedYw9RmtS5V54Q82vBvQtWAOPH+wN1sO+uaO8dERsbAJd3AD/tnMmmxN9/Uw24yxPkyIL5kx+m2A+rY6/3frJdgCXe/npaEaqg5vIxmHp0iW1C97GdQGBMnPsnZyd91xAq7Uw9ZGYuUaq75E+37BUkJ1lgykiY5d296fT5ZD5wggPgdCk0hiaYq0LZjdtbcpbYegLmAhyrQ92Cvs5FW2adpEJg6lnBK/AmSRnKVOigtVx3ARegQXRUY9qIWhOb26/p/8Hm0tyDYl4Yu6xtdPat/KPOHO1habAwZBVHLhBShzxKJhPEBxIec9p8QcPUD4bdXLZnGGhw2JfcAGkFnQNaMebe75xRMqswZlgaOpnjznZMS+gH23tTw3eYejwItIPTGeH6gIhvCM5izDyhGVC3hD6Sit0V355NK/L7Im1HjoNSEKhEQptBaZ3iFeRXckyTK5uBwZaIMQAOrgavhATFJwcV75JX3EWhx2Vw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uy9KQ0RQa1dWR0xmdk55UG5CMUdjZFRnTG5XZWVySTQ2QmJaWjFRbVorVmtO?=
 =?utf-8?B?V1VIYTIrd1NhOFJXamxNNmdVTWdJQzBRSFJWc3lnOVp6R0hKaGU4YVVHQ1Jh?=
 =?utf-8?B?MWVpcnV0SmhFUWdCWElOelkvUkRpVjUzd3hmcHE5U0dWMll1dXY3d1p6ZE1I?=
 =?utf-8?B?Nk4vejkwaEEzcnVLY3pmTDBoM1ZlamlIS2dnOU4wUWhWRWNHbHI1U2RVOUVY?=
 =?utf-8?B?Mjlad2ltYUV2NzdsWHZOekt4SG9sS2djbEloUkcvbFJyL2FEemF6L1NaSWgv?=
 =?utf-8?B?U2pRMzl5K1U1bHpIa0Vmc2ZYRmpUL1BDSnpwaEVtVXNDSGRhMVBrcUJEVmRw?=
 =?utf-8?B?ejR0d3ZCZVMzSWE2cFA2YVBoSmFSK1REaC93blpiZC8ybWp4S0x3N216SXpy?=
 =?utf-8?B?WGZhT3J5RjRVS2VxVFgwVWR4aTNKd0tSaS9kR0dPdzBvRGtMdHgzMm9wVCtM?=
 =?utf-8?B?OUkwZXVWdldxU2VXRVBxaGtIMkpGa1VVRUJOWnFjeDBNUzZMYzROYVF2eFhp?=
 =?utf-8?B?MU5TdFQ0MGx6MEE3dDVnNnNwcVkyTzdaYlN1dU91OFgwZUx5WjdhT09OcHlT?=
 =?utf-8?B?YUhtNUNka3ZPRkR6bDB5Tzd3WDl3RHFLTFVaTzJLOEIzVGNUREYxQ0VGQVBB?=
 =?utf-8?B?bzAzNUtGTkt5MnNxZmVwaTFlMjVTbitYaGlBMVFFQzhocE85d3YvVjM4OXRs?=
 =?utf-8?B?YnVHVm9VT3h0a3U4TXltK1hudjNmdFpBYzdPREp2M0VIcjFzbnlDb24vY3kv?=
 =?utf-8?B?V1MxcUxaSitPeHBOTWo2U2Y4Nlcwb0VBUFVsNkw0UzNKMnBFM2JFY1BIYkls?=
 =?utf-8?B?UXl5cXpxS0R6Q3NTOWNIVkpNZEhHV2RNNmtFeWFsMmJqOC9VS0p2YVVXL2oz?=
 =?utf-8?B?U0V1VGNyRm9rakZqWjlLR0U3d1A3Y2JVRDlLdU8rN1lwMVNwR2pzbUNXMytr?=
 =?utf-8?B?cW9vMEFwZ2RJNTA3OGxkUjBCV0JUYU5QcjZEcGRTL3o2ODdib3hkS0xtWnJl?=
 =?utf-8?B?OWhyVjJwREFobFplOXpscGl2UzNhVTVpTkZWYjBuWnRNTnVIRUM1UmQxZmFs?=
 =?utf-8?B?U0RqOUtKc3FGQXZuclRlMVB2S0k1OElpbkhEOExUUEZVTllvdmhjbjlBVVRU?=
 =?utf-8?B?NURyTnF6Mm1hSVZ6aWtaQlZYZm9oMFdvakhxWEF5YWYvVnBQeTRRNGY5Y3li?=
 =?utf-8?B?d3U5SlRKRlhGTllINURBTS9pcHNZcW0yU2R5RnlMTWdaeFlmb0RWR1JnOEVI?=
 =?utf-8?B?aFRoREJWL0FicUZCZlQwYXZiSFV1dnBpcmxmaWozZ0tnNWtsWmJwblRqSkFD?=
 =?utf-8?B?ZGR4ZEFXUzZ2dTRIeE92MjVlbDdXUEZOdlhBTnpHMWFhU2lPSDlkVFRGL3RP?=
 =?utf-8?B?bWlZRElVR1ViUFJvVjhPZTgwanZZT2dqWDJDenJxY0dtQjU3RVQ3MVFtOUV2?=
 =?utf-8?B?YlRob3I2V1Awby9pMmhhbmNLQkJlQmVyYS9Sc280UUVaN3o5Yko0alZ3Sks0?=
 =?utf-8?B?ODNiQkEyRGhqWWlCV1FQLzNsWnBzNVk2NVFyczJhekhuSUh4NytpQ1Rab29Z?=
 =?utf-8?B?NkxvaGhWTmJNOVdwQXdRc0VqYXoyV2hCcm1CWldRcmRNV2VpaE1oWE1BV2Ry?=
 =?utf-8?B?dk1qOFNTZE5mRmV3NE1Obmh5Z3gzRmFNTUZuZHkxQ0cwRE54L041b3FpLzFl?=
 =?utf-8?B?dlkxQ3grWlJHTEY2UC8yQitwcjR3ME9HdUtWSEY1U1RaK0gzQlpacmx0UWd2?=
 =?utf-8?B?K0c1TWV2NEhXQzhOTXVSdG84MC9WL01QU2pZQ1ZSdEtVSUdycmx3T1RkYUxk?=
 =?utf-8?B?OU03dkMwRUZmTnVENVUxQXpqay9pNGFyK3YvZUN3OTlhZlBwN3hoWXV5dzBW?=
 =?utf-8?B?andtQzYweVNvZGNvYTRSVjFkTzdLTXJjWVNvekZNVUZmY1ZpNzhtOWZOQWZB?=
 =?utf-8?B?QllwVG1sZDhtZ203OXBveWd0d0lWTk91bDJZSkM0YlYzV2tJcFV6dkNJL1hI?=
 =?utf-8?B?cnF0eHJ1WVN6dWVwYmpXL2RsVmZkTjlvN3FveWxzYmk3dWdNQVEzRGFIeGdk?=
 =?utf-8?B?QTZseXJsd2ZmMEFDNVdGejdOeXZJWHhIdDVNL2JwQzBVLzhScm95ZEpjSlAy?=
 =?utf-8?Q?6AXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654eac4e-9c44-472d-74d6-08dc44bd1b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 06:56:58.2525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2HgNxVQXDek/OwkaBxdOp6NGHxw78ckdTtiLuCVWEclJCDf0ueGFORAaJ3dxCEvmt1oajg6mwjIKX1D3Hu1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJp
ZGF5LCBNYXJjaCAxNSwgMjAyNCAxMjoyNSBQTQ0KVG86IEthbWFsLCBBc2FkIDxBc2FkLkthbWFs
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+OyBaaGFu
ZywgTW9ycmlzIDxTaGl3dS5aaGFuZ0BhbWQuY29tPjsgQ2hldW5nLCBEb25hbGQgPGRvbmFsZC5j
aGV1bmdAYW1kLmNvbT47IEtoYXRpciwgU2VwZWhyIDxzZXBlaHIua2hhdGlyQGFtZC5jb20+OyBP
bGl2ZWlyYSwgRGFuaWVsIDxEYW5pZWwuT2xpdmVpcmFAYW1kLmNvbT47IFBvYWcsIENoYXJpcyA8
Q2hhcmlzLlBvYWdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kL3Bt
OiBVc2UgbWV0cmljIHRhYmxlIGZvciBwY2llIHNwZWVkL3dpZHRoDQoNCg0KDQpPbiAzLzE1LzIw
MjQgMTE6MTEgQU0sIEFzYWQgS2FtYWwgd3JvdGU6DQo+IFJlcG9ydCBwY2llIGxpbmsgc3BlZWQv
d2lkdGggdXNpbmcgbWV0cmljIHRhYmxlIGluIGNhc2Ugb2Ygb25lIHZmICYgaWYNCj4gcG1mdyBz
dXBwb3J0IGlzIGF2YWlsYWJsZSwgZWxzZSByZXBvcnQgZGlyZWN0bHkgZnJvbSByZWdpc3RlcnMg
aW4gY2FzZQ0KPiBvZiBwZi4gU2tpcCByZXBvcnRpbmcgaXQgZm9yIG90aGVyIGNhc2VzLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBc2FkIEthbWFsIDxhc2FkLmthbWFsQGFtZC5jb20+DQo+IC0tLQ0K
PiAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICAgfCAx
NCArKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvc211X3YxM18wXzZfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQo+IGluZGV4IDc0NGM4NGYzMDI5Zi4uMmE5MzQ4
NjRiNWViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L3NtdV92MTNfMF82X3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvc211X3YxM18wXzZfcHB0LmMNCj4gQEAgLTIxNjcsNiArMjE2Nyw3IEBAIHN0YXRpYyBz
c2l6ZV90IHNtdV92MTNfMF82X2dldF9ncHVfbWV0cmljcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwgdm9pZCAqKnRhYmxlDQo+ICAgICAgICAgICAgICAgKHN0cnVjdCBncHVfbWV0cmljc192MV81
ICopc211X3RhYmxlLT5ncHVfbWV0cmljc190YWJsZTsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQo+ICAgICAgIGludCByZXQgPSAwLCB4Y2NfaWQsIGlu
c3QsIGksIGo7DQo+ICsgICAgIGVudW0gYW1kZ3B1X3NyaW92X3ZmX21vZGUgbW9kZTsNCj4gICAg
ICAgTWV0cmljc1RhYmxlWF90ICptZXRyaWNzX3g7DQo+ICAgICAgIE1ldHJpY3NUYWJsZUFfdCAq
bWV0cmljc19hOw0KPiAgICAgICB1MTYgbGlua193aWR0aF9sZXZlbDsNCj4gQEAgLTIyMjksNyAr
MjIzMCwxNyBAQCBzdGF0aWMgc3NpemVfdCBzbXVfdjEzXzBfNl9nZXRfZ3B1X21ldHJpY3Moc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUsIHZvaWQgKip0YWJsZQ0KPiAgICAgICBncHVfbWV0cmljcy0+
Z2Z4Y2xrX2xvY2tfc3RhdHVzID0gR0VUX01FVFJJQ19GSUVMRChHZnhMb2NrWENETWFrKSA+Pg0K
PiBHRVRfSU5TVChHQywgMCk7DQo+DQo+ICAgICAgIGlmICghKGFkZXYtPmZsYWdzICYgQU1EX0lT
X0FQVSkpIHsNCj4gLSAgICAgICAgICAgICBpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0K
PiArICAgICAgICAgICAgIC8qQ2hlY2sgc211IHZlcnNpb24sIFBDSUUgbGluayBzcGVlZCBhbmQg
d2lkdGggd2lsbCBiZSByZXBvcnRlZCBmcm9tIHBtZncgbWV0cmljDQo+ICsgICAgICAgICAgICAg
ICogdGFibGUgZm9yIGJvdGggcGYgJiBvbmUgdmYgZm9yIHNtdSB2ZXJzaW9uIDg1Ljk5LjAgb3Ig
aGlnaGVyIGVsc2UgcmVwb3J0IG9ubHkNCj4gKyAgICAgICAgICAgICAgKiBmb3IgcGYgZnJvbSBy
ZWdpc3RlcnMNCj4gKyAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICBtb2RlID0gYW1k
Z3B1X3ZpcnRfZ2V0X3NyaW92X3ZmX21vZGUoYWRldik7DQo+ICsgICAgICAgICAgICAgaWYgKHNt
dS0+c21jX2Z3X3ZlcnNpb24gPj0gMHg1NTYzMDAgJiYNCj4gKyAgICAgICAgICAgICAgICAgbW9k
ZSAhPSBTUklPVl9WRl9NT0RFX01VTFRJX1ZGKSB7DQoNCmdwdV9tZXRyaWNzIGlzIG9ubHkgYXZh
aWxhYmxlIGluIG9uZS1WRiBtb2RlLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGRvIHRoaXMgZXh0
cmEgY2hlY2sgdGhlcmUuDQoNClRoYW5rcywNCkxpam8NCltLYW1hbCwgQXNhZF0gVGhhbmsgeW91
LCB3aWxsIHNlbmQgYSB2MiB3aXRoIGNoYW5nZXMNCg0KPiArICAgICAgICAgICAgICAgICAgICAg
Z3B1X21ldHJpY3MtPnBjaWVfbGlua193aWR0aCA9IG1ldHJpY3NfeC0+UENJZUxpbmtXaWR0aDsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIGdwdV9tZXRyaWNzLT5wY2llX2xpbmtfc3BlZWQgPQ0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY2llX2dlbl90b19zcGVlZChtZXRyaWNz
X3gtPlBDSWVMaW5rU3BlZWQpOw0KPiArICAgICAgICAgICAgIH0gZWxzZSBpZiAoIWFtZGdwdV9z
cmlvdl92ZihhZGV2KSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgbGlua193aWR0aF9sZXZl
bCA9IHNtdV92MTNfMF82X2dldF9jdXJyZW50X3BjaWVfbGlua193aWR0aF9sZXZlbChzbXUpOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxpbmtfd2lkdGhfbGV2ZWwgPiBNQVhfTElOS19X
SURUSCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlua193aWR0aF9sZXZlbCA9
IDA7DQo+IEBAIC0yMjM5LDYgKzIyNTAsNyBAQCBzdGF0aWMgc3NpemVfdCBzbXVfdjEzXzBfNl9n
ZXRfZ3B1X21ldHJpY3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIHZvaWQgKip0YWJsZQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgZ3B1X21ldHJpY3MtPnBjaWVfbGlua19zcGVlZCA9DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtdV92MTNfMF82X2dldF9jdXJyZW50X3BjaWVf
bGlua19zcGVlZChzbXUpOw0KPiAgICAgICAgICAgICAgIH0NCj4gKw0KPiAgICAgICAgICAgICAg
IGdwdV9tZXRyaWNzLT5wY2llX2JhbmR3aWR0aF9hY2MgPQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBTTVVRMTBfUk9VTkQobWV0cmljc194LT5QY2llQmFuZHdpZHRoQWNjWzBdKTsN
Cj4gICAgICAgICAgICAgICBncHVfbWV0cmljcy0+cGNpZV9iYW5kd2lkdGhfaW5zdCA9DQo=
