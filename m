Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614E606A331
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SPor/2k0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9381E10E16D;
	Fri,  6 Nov 2026 09:13:12 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06779112C0F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 09:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq9DdCfxp/ZVPZVFzPoLpmmXftd6gGsbiiJMMmEIsRXSeUr8rAaIM/+O+moucOWy4CwVyBahh25IZdC72+viluFVEN6r7aMM2Pjku71EKmTzo1iDlXey2q2jiBG2nNCvGb/12Enr/bZtruOPDukinOgnH2tMU4WYsY5HlH3XZ5WUIGhp3+sTEn6Ucq8rEsKot8PmxByPmgANB5rru2643IJS5XsOX0u7MPfT+PxS5kt8aZRLp3GJvyUqrlPPLasJ7+++C9OnDJk8teVoKc6+AR8AHjUekHhzvXmOZWmqEAHinf0/YUtXVcZsPHYK1YjNqYucTek+qt5kG9Cl+dN1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UFjAVwV3bhlm9PP14qH35+bLbAmzB42tKz6yC0xzoU=;
 b=T2gsF9A30xHb9vxmbt/iRD/kU7CuwUcaBbW6X/o2Tf9dbdVLHbotv/g8LO6HkXfn0zRuEmOuZAUpGcphze3nlz16gWias0eqXHrEd1ZhY5j/2ezhQ4ypKwtp9NrvSmo4Upm9R4p2HJqFk9aZW9Xf6T8zOYYMYta5quVZRii3Wc1Gp5JmWJ5QQGTjGh+uhBubHl3lgcNFSoYZZwiHty08ZowhOMCP4xbtABFKPR+7b5D+a4nDgi956MgdatULOuE/+WxKdJMkJvhV1h7KF034yX2/CkEDs9lZGzEsz6bNKCGvSOjn6YfSM6pmxwFewN/WqLvTmxGlpSQYxQWv9HtjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UFjAVwV3bhlm9PP14qH35+bLbAmzB42tKz6yC0xzoU=;
 b=SPor/2k0Qh9oWv7X9WhF7IGJ6OHfs3acZnsMnZ+P1iC4kouuvw8pq+aS8ULQ0PojKrQRM8JTRQr/CtofSKX7sPl58EnnHY90dI2eTHNSEe4tQNhthrjZwn28iYw8QOr/gXO5DmKHhqalj2v8l+1q+bXuc2/fjtMF2cQsbOe5VS4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:13:02 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 09:13:01 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't create the CWSR TMA BO as a kernel BO
Thread-Topic: [PATCH] drm/amdgpu: don't create the CWSR TMA BO as a kernel BO
Thread-Index: AQHdbcAnW+nlTn/IYkupEcfbhP+ILLcgsk+AgAAP/AA=
Date: Fri, 6 Nov 2026 09:13:01 +0000
Message-ID: <DM4PR12MB5152975D7B0C0687C6894DF8E3762@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261106072627.1449709-1-Jesse.Zhang@amd.com>
 <e210ed12-8c78-442b-ab5f-637fa5d582dd@amd.com>
In-Reply-To: <e210ed12-8c78-442b-ab5f-637fa5d582dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-06T09:12:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA3PR12MB9089:EE_
x-ms-office365-filtering-correlation-id: 4c313ce2-df91-4684-a5ce-08df3be6286c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|261026121527099003|4143699003|11063799006|261026140227099003|56012099006|261009223027099003|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
x-microsoft-antispam-message-info: 0tSfgBFxsj3cw1Wk9YsqDcx1hLqbeCPzUVruXVY9zBodOFgniKIip37PhudpOYgf6Gnuevl9mIxNCLWSeUkBcUmn2S3VNkjLF8yAg9KKg4OSVuQKnHROjN2jJdo3c/PqXH+FDtQ3hkTLhzN/1r0nlT3eGfaGjnYzQxhV00qAxyFCUMfUpkJzky4gsncClGxYhBGgqBzGvFprv+TLiNPCwNVperaebaK0l1vr9Rnfbn4BZBgFJOKDrUYlvn+Ju9IfRcHA/5ks4N4D77KcbhJeSsdlds4XGu6bFq8Xy7FVIWX4/5fHQIN8GRy6gNBHXbeE33+b4VjrXQmzQRIuwlWqoJzesya+BySXd3927h8WL7arGBPzO0ozpxN2OI7zDC1Po5YqzbGgPMeI279oHkFVrTmq7PZvuQu5cZjh42NLSRCDhrS+ZQgAsZo+OHUuGppv5mHrEeaNYg03se6exMqXCYKPuwaDLVR9yG27HGbCyQKbT0tXardNXxdYgYYI/c1pSa80nxOnPAjih3HuMHdR+EcvLQnXZRyggeYJ+R5KVeHzV6JPDsrKqDzT4rW5umw00yYpUFocw+fpBxUhCmv0ca/3Sn2P2FdBBKAiEOScsnObTo7hMDSySrMgVD2qZbAzsKl/gBoyEwZT+yNLx2jaUYwTplVzvO1jXEe+9PfUh9mudctd9y8FnSoR9CetTVxR2MtnTa+zX1G/7ZZOkng3Mg4i+CHCiyLsdat88fn0cr8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(261026121527099003)(4143699003)(11063799006)(261026140227099003)(56012099006)(261009223027099003)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVFBa2hqenlMNVp4SkVZaXltZnU2QU5CbGlRZG1zNHloYjNadkVwdE5OYVNm?=
 =?utf-8?B?M2Fia2JxeCtBaFFpV1RkbklmWk5wTHgvTjNEWXFLcWkzNzltOXNncnF5NldO?=
 =?utf-8?B?Z3NnSFVtV3piLyt1WCsrZWplT09ZS2src2xNWWlIL3FUdmhFSTNUS09zdm8w?=
 =?utf-8?B?K3BGNjJINXMrRUkyN1k2aGd3OU56N3c5bENSSkhtKytXRU9NZ3N1VEMyWGpH?=
 =?utf-8?B?VHY4SEw5TkhOZENINElaWjFDM0Mzd1dFenJPRWNCSEVmb0tsMk1XMkxDaGgv?=
 =?utf-8?B?N3d6VWZmbUpQeU5sazgxR1ZtYW1ZdjJvTDhMMHdLMHhlTmZFR29FN0xucDVQ?=
 =?utf-8?B?T3JIbzk4NFMwaWJ3MER6Mmt3YjRjWVlXS0xnTVFYUVh5NHBXSjFaYkJ0MVB5?=
 =?utf-8?B?b21McWpCckxEaWhDVjgxL0lrUW5lblR0QzZJMVp5VXBBR3hEa2NJbDYzY0Fh?=
 =?utf-8?B?WWlObzYrVTJWNlI5RENhQ1V1UWpLZEFhNHNReEZTU0x0cGxRUkMreVg5Q2xI?=
 =?utf-8?B?SGZOaGl1YWNlVy9iTGNaNnlvSFBhelcvdFVhbzNuUVNUWkZMZFlBTjQrOUhO?=
 =?utf-8?B?SExpVW5rY1FiMngxY0d0elJ5dkxjUkN0L3JXVkRWNjdjc2phRkVQdHNYaGxl?=
 =?utf-8?B?VWF0S01QOE9BMlJZdzR1R2ZqditxSnR1L29hVm9NME0xTStaOEdIemt6Y0p0?=
 =?utf-8?B?ZFBTQ2NLd1pvM3ZWUS9WNzFFNTBWQjNEQjJZTWEwL1hQVysxMk5MMTBSakxy?=
 =?utf-8?B?WjJFV2pVaEdBMldDMXZpQytaa2FwRGk1WnkyVnpTd3h1OHpFcWl2SjJ6eFNP?=
 =?utf-8?B?RGZ6TGdaeTZBTXkwY3h6dlMyMVErR3NSMEdybk1TZHV2RkZCeWNHdHdwdlVm?=
 =?utf-8?B?MGJFcFhKd1hVOFVtei9YWGpxYTBVRmU0cUZ2S3o2NkRGeFlZTkJFWnNxaHgz?=
 =?utf-8?B?bitqVWNRT29qRVlBTE50NVVocGdjWjRJN205MzJPcE9GTUJYbU0vOVA0ekVD?=
 =?utf-8?B?MWtIOEhpdWQ0aDcvbkd4eXduYTNOVjVFU3g0bmE3YU1qVEErL05rbTNpeUU4?=
 =?utf-8?B?Nmk0Z0dSUDZibkRrNGpRVlRuc3kyeE5nSzBZZGpZTWg3cFZrSlFpMUw4RFJo?=
 =?utf-8?B?clc4TGw5RkxqVWJnL1UvMGlCaldDM1ZwQ1duRVpiUXRPbHcvTUJkb2ptZmxs?=
 =?utf-8?B?T1ovckxiUzVTb3JDaSsrU1REUFIzTUQ1RkxlZHMrbGMwKzllOEZQd1dRTUFB?=
 =?utf-8?B?a1pEdzU5RlhPLzV6cjVNaVBCVi9VRFh6SnJxMThlOGNpYnhCdXQzZWpUV2pP?=
 =?utf-8?B?TVlpY0VndTRVNTF0cFFIYSszR3lOb1V5anRwNVVnbSs4ZHNKM0hORzhTaEU3?=
 =?utf-8?B?ek8zYWlKeTZ6QkpsNUtGNmo0d3FpWU1aV1FPUEwwbUVPb2hUTXJUMWl3VlM5?=
 =?utf-8?B?a1NaQTVjbUg4a2lPTlJwWExZSUVXcjkzNGs0ekk4aXRUMDV1SzlvWHF4VC9V?=
 =?utf-8?B?NmIzRGxSZFArRXFpNHM1SlZtTUEybkhOb0xHeFU1MUxiOTBHTkthTlU0SjlO?=
 =?utf-8?B?Tk5udUdScVgrNUJDS211cjdNNE5kZWczL09BWW9taGVJMW9hZUpTNnNqRVJT?=
 =?utf-8?B?eEs2dm5WVmtxd1JXOFlQTkx0WDROa28rT1E4NGRUaG5qT280bzRrSXNOc3dN?=
 =?utf-8?B?cCthV04vWnJ1OGJtNFRzbkI4TmhxZVQvcUExSC83M2llVmVST2I3STJIQ1Ri?=
 =?utf-8?B?OWJKd281L3VDdmoxZS9sejdpTVJRME4zMU9KSzlscE80YVROT1I4Z1V1NEZD?=
 =?utf-8?B?dzZRSjYwMVhKckdOWnpnRnlVeHlYMm5xOFZGUVlZSHh6VzdXTkl4aDlmS21F?=
 =?utf-8?B?YXRkNmRMZGsxaUZReFVGeUdwemVyRHhTenZGczBOaXY3Y3FJRjU1aWtLSDNl?=
 =?utf-8?B?L3Ryc1VmNFlyNGgzYlhOTFA4MGlQZlNzM2FoTzI4NlBoTTVyVnBzdlU4aldG?=
 =?utf-8?B?ZlJJWjEzbHc4YXlJZjVsRkp1VGdiWjRyWGVRSUZBVExYeGtDYmJZUEdxY2c2?=
 =?utf-8?B?UnFBNGhoRk1PcUJNSFdIeFpxK1I3cStrU1dITHRrNmNkeVh1NHVEaGs2aTZZ?=
 =?utf-8?B?THpabTVxdml2RW93anNtRC9CdzdCa0doRkRSUW9HcDdvZ2RQUG5LcmFCcG5t?=
 =?utf-8?B?R1RkbGJDdVRPankwNFozWmM0QW9yRnJ0Qlc4V0JMNUQwaTR1cXY2dC9saE9x?=
 =?utf-8?B?eFBZZ2dsQ3JlcStWeWp4VWRlUHNQVlVuZzYrV0JzeHkwRStVQXRndFQ4ZUhJ?=
 =?utf-8?Q?ZgTu4MvnNTbWLS77gp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c313ce2-df91-4684-a5ce-08df3be6286c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 09:13:01.6319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dyJKGTYNedGzbpS5NZ311TNKd4ALCwmCSCTaZ+adFBHRegNG7c5NhmwxxWMAaC/XxlGdzNtOhjLMwa5B6vehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXks
IE5vdmVtYmVyIDYsIDIwMjYgNDoxNSBQTQ0KPiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3Nl
LlpoYW5nQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExhemFyLCBM
aWpvDQo+IDxMaWpvLkxhemFyQGFtZC5jb20+OyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHU6IGRvbid0IGNyZWF0ZSB0aGUgQ1dTUiBUTUEgQk8gYXMgYSBrZXJuZWwNCj4gQk8NCj4N
Cj4gT24gMTEvNi8yNiAwODoyNSwgSmVzc2UgWmhhbmcgd3JvdGU6DQo+ID4gYW1kZ3B1X2N3c3Jf
YWxsb2MoKSBjcmVhdGVzIHRoZSBUTUEgQk8gb2YgZXZlcnkgb3BlbmVkIHJlbmRlciBub2RlDQo+
ID4gd2l0aCB0aGUgcmVzdiBvZiB0aGUgVk0gcm9vdCBQRCBhbmQgYXMgdHRtX2JvX3R5cGVfa2Vy
bmVsLiBUaGUgVk0gcHV0cw0KPiA+IGtlcm5lbCBCT3Mgd2hpY2ggc2hhcmUgaXRzIHJlc3Ygb24g
aXRzIHBhZ2UgdGFibGUgbGlzdHMsIHNvIHRoZSBUTUEgQk8NCj4gPiBpcyB0cmVhdGVkIGFzIGEg
cGFnZSB0YWJsZTogYWZ0ZXIgYSBWUkFNIGxvc2luZyByZXNldCBpdHMgYm9fdmEgbW92ZXMNCj4g
PiB0byB0aGUgcGFnZSB0YWJsZXMgbmVlZGluZyBhbiB1cGRhdGUsIGFuZCBhbWRncHVfdm1fdXBk
YXRlX3BkZXMoKQ0KPiA+IHRyaWVzIHRvIHdyaXRlIGl0cyBQREUuIEl0IGhhcyBubyBwYXJlbnQg
cGFnZSBkaXJlY3RvcnksIHNvIHRoYXQNCj4gPiBmYWlscywgYW5kIGZhaWxzIGFnYWluIG9uIGV2
ZXJ5IGZvbGxvd2luZyBzdWJtaXNzaW9uIG9mIHRoZSBmaWxlLg0KPiA+DQo+ID4gT24gbmF2aTMx
LCBzdWJtaXR0aW5nIG9uIGEgcmVuZGVyIG5vZGUsIHRoZW4gYW1kZ3B1X2dwdV9yZWNvdmVyIGFu
ZA0KPiA+IHN1Ym1pdHRpbmcgYWdhaW4sIGFsc28gd2l0aCBhIG5ldyBjb250ZXh0Og0KPiA+DQo+
ID4gICBhbWRncHUgMDAwMDowMzowMC4wOiBWUkFNIGlzIGxvc3QgZHVlIHRvIEdQVSByZXNldCEN
Cj4gPiAgIGFtZGdwdSAwMDAwOjAzOjAwLjA6IEdQVSByZXNldCgxKSBzdWNjZWVkZWQhDQo+ID4g
ICBXQVJOSU5HOiBhbWRncHVfdm1fcHQuYzo2NjQgYXQNCj4gYW1kZ3B1X3ZtX3BkZV91cGRhdGUr
MHgzMjkvMHg1ZDANCj4gPiBbYW1kZ3B1XSwgQ1BVIzM6IHZtcmVpbml0LzI3MjgNCj4gPg0KPiA+
IGFuZCBldmVyeSBjb21tYW5kIHN1Ym1pc3Npb24gZmFpbHMgd2l0aCAtRUlOVkFMIGZyb20gdGhl
biBvbi4NCj4gPg0KPiA+IENyZWF0ZSB0aGUgVE1BIEJPIGFzIGEgZGV2aWNlIEJPLCBhIHBlciBW
TSBCTyBsaWtlIHRoZSBvdGhlciBvbmVzLg0KPiA+IFdpdGggdGhhdCB0aGUgc3VibWlzc2lvbnMg
YWZ0ZXIgdGhlIHJlc2V0IGNvbXBsZXRlLg0KPiA+DQo+ID4gRml4ZXM6IDhhOTNhYWU5ODk2YiAo
ImRybS9hbWRncHU6IEFkZCBDV1NSIGluZnJhc3RydWN0dXJlIGZvciB1c2VyDQo+ID4gcXVldWVz
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4N
Cj4NCj4gQ2xlYXIgTkFLLCB0aGF0IGFsbG93cyB0byBtbWFwIHRoZSBDV1NSIEJPIGZyb20gdXNl
cnNwYWNlIGFuZCB0aGF0IGluIHR1cm4NCj4gaXMgc2VlbiBhcyBoaWdobHkgcHJvYmxlbWF0aWMu
DQo+DQo+IElJUkMgU3VuaWwgYWxyZWFkeSBzdHVtYmxlZCBvdmVyIHRoaXMgaXNzdWUgYXMgd2Vs
bCBhbmQgd2UgYWdyZWVkIHRvIG5vdCBjaGVjaw0KPiBmb3IgdHRtX2JvX3R5cGVfa2VybmVsIGFu
eSBtb3JlLg0KPg0KPiBDb3VsZCBiZSB0aGF0IFN1bmlsIGFuZCBJIGRpZG4ndCBmaXggYWxsIHBy
b2JsZW1zIHdpdGggdGhpcywgbWF5YmUgdGFrZSBhIGxvb2sgYXQNCj4gdGhlIGhpc3Rvcnkgb2Yg
YW1kZ3B1X3ZtLmMuDQoNCkFncmVlZCwgdGhhbmtzLiBUaGUgcmVtYWluaW5nIHR5cGUgY2hlY2sg
d2FzIGluIGFtZGdwdV92bV9ib19sb2NrX2xpc3RzKCksDQogd2hpY2ggc3RpbGwgcHV0IGV2ZXJ5
IGFsd2F5cyB2YWxpZCB0dG1fYm9fdHlwZV9rZXJuZWwgQk8gb24gdGhlIFBEL1BUIGxpc3RzICh0
aGUgVE1BIEJPIGluY2x1ZGVkKS4NCiB2MiBrZWVwcyB0aGUgVE1BIEJPIGEga2VybmVsIEJPIGFu
ZCBsZXRzIHRoZSBjcmVhdG9yIG9mIHRoZSB2bV9ibyB0ZWxsIHdoZXRoZXIgaXQgaXMgYSBQRC9Q
VCAobmV3IGFtZGdwdV92bV9ib19iYXNlOjpwYWdlX3RhYmxlKSwNCiBzaW1pbGFyIHRvIHdoYXQg
U3VuaWwgZGlkIGZvciBhbWRncHVfdm1fYm9fbmVlZHNfdXBkYXRlKCkuDQoNClRoYW5rcw0KSmVz
c2UNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3dzci5jIHwgNiArKysrKy0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jd3NyLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jd3NyLmMNCj4gPiBpbmRleCBkYWNhMGEx
YWM5OTAuLjUyYWU3N2EwOGNhMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3dzci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N3c3IuYw0KPiA+IEBAIC00MzMsNyArNDMzLDExIEBAIGludCBhbWRncHVfY3dz
cl9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAq
dm0sDQo+ID4gICAgIGJwLmRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsNCj4gPiAgICAg
YnAuZmxhZ3MgPSBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0MgfA0KPiA+ICAgICAgICAg
ICAgICAgIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7DQo+ID4gLSAgIGJw
LnR5cGUgPSB0dG1fYm9fdHlwZV9rZXJuZWw7DQo+ID4gKyAgIC8qDQo+ID4gKyAgICAqIE5vdCB0
dG1fYm9fdHlwZV9rZXJuZWw6IHRoZSBWTSB0YWtlcyBrZXJuZWwgQk9zIHNoYXJpbmcgaXRzIHJl
c3YNCj4gPiArICAgICogZm9yIHBhZ2UgdGFibGVzLg0KPiA+ICsgICAgKi8NCj4gPiArICAgYnAu
dHlwZSA9IHR0bV9ib190eXBlX2RldmljZTsNCj4gPiAgICAgYnAuYm9fcHRyX3NpemUgPSBzaXpl
b2Yoc3RydWN0IGFtZGdwdV9ibyk7DQo+ID4gICAgIGJwLnJlc3YgPSB2bS0+cm9vdC5iby0+dGJv
LmJhc2UucmVzdjsNCj4gPg0KDQo=
