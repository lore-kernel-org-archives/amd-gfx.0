Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E3CCC6B1C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 03:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1709A10E16F;
	Thu, 15 Oct 2026 03:48:27 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414D910E16F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 03:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1QfoyB6IQP04n7RyRZANDHZaZff2M/dutHXN3Vr2qEsUVnjz3Ch7PXc7Zzocf2PD3WfQcjAYUu32bzCn7Hw/PUEQrKw+liA327nbOIKo9H7uQrcmY/kvg1cqVfqzlw9hJ5LLSSuwcxELtBIIPLOQtNdQT3rAIjBRulN2qKxnm3HpVizylLelESLvPYAh4fTLotkQj2G5j8NPzq3PxpvgPIsl1Y3z/5nONtePIGHqNqDtCL0mu8Dta8SEnVH2dOSHYFt7U9pViXKY5qBqz3ccx8fKPQNNsexaoSYkw00L1/8LcJR4NrhJcMXnRZ+EfSEcTyYvD01t38K6OKjBrbeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYvH+7cXwsYdF1aZ89PS9sPeNEVgB2YZFSDda+NM+VQ=;
 b=jDRW/ZMMXsdbGW9fovl6ZBQjerH/IIYogIGuT5gEpYefC8i1qWaEeDWPDbP6jVTyk7QZEpkUzyYEsZwrwKqHYZX1aeGUC/SF05arqAwIY6jmFTWZj9THvr7jT9rN9u5gxISzTDDevBiEQ/i4KFAyqXgtiITGAwWCU7egRAREMWah0oNwYZ+nFBUrtwRnApbfKB1IxEdbN13pYVsyRJoMj3htPe39AZGb23pRMprKeVaopuyCG7/Q1LqzvnZrAwEGegcXQwruo2ngli7zZ/jISZMcJU4dQrIofj5KJ7uWiV0BM2BGI62U6XpzcnjBfPLPt9ASwVQ7BPKWWX6tEMIkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYvH+7cXwsYdF1aZ89PS9sPeNEVgB2YZFSDda+NM+VQ=;
 b=YoyGnhapVJ/wi3xF7Sjcq6n+tfmISIp05ncDRTDeZvW68F2XvfIvpNYq4us7alRF1pgC7/pXu5GeZASXAlh7mlgUU8qIMvFQMOfNe78WClToovR3NwMtJmfkvy3Z4kSIJhsasIjQ0s/ghHjB1g9AlTvKBbz1e+q1Xhl3J6uFrk0=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 03:45:24 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 03:45:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/9] drm/amdgpu: skip VKMS mode-config helpers during GPU
 reset
Thread-Topic: [PATCH 2/9] drm/amdgpu: skip VKMS mode-config helpers during GPU
 reset
Thread-Index: AQHdWuxkeVO2eGlpq0StrRunxFFCZrb7NGIAgALAibA=
Date: Thu, 15 Oct 2026 03:45:23 +0000
Message-ID: <PH7PR12MB6000696BA9F3E5C409CC2ED7FB9C2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <20261013082457.2492273-2-Prike.Liang@amd.com>
 <2991b037-fa46-4d33-a6b7-c7783c92b105@amd.com>
In-Reply-To: <2991b037-fa46-4d33-a6b7-c7783c92b105@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T03:29:28.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MN0PR12MB6199:EE_
x-ms-office365-filtering-correlation-id: 2372ca29-c39c-4ea2-77f5-08df2a6ebe79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: obhwR5jp778MhuwQ9DpAUJAdpm+E6i2ZOUbAZthh0yWpmGWS7mWimu2x5VsY54RE1EQXApH2ZrQpxcTneN2xBOo1durNJxqGvrreI+jzjB403EQ/2hFSCJWFtPt2QOY9TP60bHiJCBQ2po4ZQgN2zdTnf8eUe4EPYILQ/T0JphpDhNNS9Gaz2I0fGAORrWPeZbmLo008zNLEMqSN8maTv0PdYijAFVlVNVF0dAiafdtyy3UntOMSLdVLJb5bdH2rKMxspeSsCMbhSZHySRtaoD/uToNe8wLhoYz4st2A42UFfW4TIA8/97XD9AQAIR3uGsBKkXlhrLBHE/x8w3MjDiONPT51BDdPNw4y82SBs3KhHmDXnS/SFe5TwuPWiOuyg+tgQSB5KBCnPZQcjTCoxCshIDqrFcCokl0bAtz4k7EnWIxPsA1f6fGsFqwENF5VCT8d+mgiOmaWdF3oTcX0T5srwvtdlG9uvnDGNU6lfXhV2PI62xbqYrYawKgWMVj94SdLGHd9PBGIfrBI0E5L0Aayq1swogUERaD8PQ6/Onk+0Z4T/rlJbRhRRCd9XTljVcwjTXHn5ze1q3/EaMCTQ2LDU4DGzmtF1JUyP/UCANEeiX3qJY+lo3oPwd/wC9bJqDZBY5qN8nrbU2n+aYTtkFX2k7N2GeXh9kIC9fWGEC3uPWgx9dZBb48AL/dIdoapCeqSG2Yz4f0z3DmflQSFIksny8AdCi0aymW4Q8J0/tY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGQ5dzZxQUJ5VEpFZVhKcVZPcmhOMEdKWHFjc2pCdktNR2xad012OVl3WUFl?=
 =?utf-8?B?eWhkdDBIWHN5ZWRoMXRKeStNWWVRcVppRGRkdlJCdWdkQVpaZEQ2enVxWVhH?=
 =?utf-8?B?Zm1mNVNkSHE0ZllVY0lWQmtPdW1zckMxdzNVbFdVZjhoVnFMRHV1RGtaalBH?=
 =?utf-8?B?MXhLN1YwMDVmNmZDOFhXbmpJUjIyajJ2Z1FxUHoxTVRTYkNQSjVJbStSRmJz?=
 =?utf-8?B?RU5RNWF4YlhLMHlNUFNWNlFQd1BwMXNQOU9tdlFPMXdsQkhUcENyakZmaTZ6?=
 =?utf-8?B?ZVJOUG5XTWsvUDQxVSt1SkZzQ3U5UFFud3BwbFlRTkhSMkJKLzBzWTJ5ZXk2?=
 =?utf-8?B?N1FPb0NOcmVXUEFIdzZVR3VWeXlWTmU3YjJkNWdhYTNBU2FqWlJJdTFxWVZl?=
 =?utf-8?B?dGlPYWdxZUdvWk9qUnBFTGRmNElkNVRoQTdTY0lPbW5nbFV3V2VNZlVuaWtO?=
 =?utf-8?B?cW9sZktJY04wUFJyOG5OQ3RqajcyQWZhOEN5WERvdEo0a1FBT0pOVCtvb3N4?=
 =?utf-8?B?M2JyQUtTclBGejNQNDgvR1V2dXVnM2ZRb3laRmJIU1ZWaGhRMnJTRHZjRTlT?=
 =?utf-8?B?Q1pUVzZMbmpnN1FTdnhiaFZvNjNHZmV3ajYzaUxmcERCM2F1OW90TVNYVFg1?=
 =?utf-8?B?cVI2MXVZbjdPUmVQNmdOTGltbGcyWFN1RzdROGtwYjhKZ3dJdDFpbThkdys5?=
 =?utf-8?B?bUJRTm9jdEZxcEpENmhFcWdDSThYTExqTnlYMHF0cHRITGtiNFNEcUtqcmhV?=
 =?utf-8?B?SHQxeVJIckhWOWhKYVVXcnVOTlFNNVltbHVWbE9ZRXc1Q1dpMDZMeEd4YVho?=
 =?utf-8?B?UHFFbG1ubllNb0gxMlVybnptRXprak5LSHROU00weGwwNGtPRnlVWFJXeHFO?=
 =?utf-8?B?YUJYa0FmQit3WlEyQk9QQjFncFhUMklvT1dGVzdybzQ5M1RkSDdZU2NvTjJS?=
 =?utf-8?B?K2laR2phLytlOGJCS05DSkdrU1EyemFkREtFeFpFaHR3ZkhXaVNHbWFCNnMr?=
 =?utf-8?B?dkw2cGVsemJjNWVvcmRhUXd4Q2xVZHBLL3RocjVvelI3aVhwV292aXRLYlhG?=
 =?utf-8?B?TzBPSHdaWFpRWE41eHo1RUI1SWtqdnhZcnhEdC95bTdEWFhzNVJPUllaQUFs?=
 =?utf-8?B?Znd3NVJ2WVJ6KzRlU3RPaDFBay9qenQvbm1wMXRycWN4cXJJT2JDOHhQdWhK?=
 =?utf-8?B?c1V0YjJvMjluUFlLbXBKQnBsTVYrZWxhbnFlWE04Skh2SVBSVjhlY09HMTF2?=
 =?utf-8?B?NzJVU3BGYk5vcmFNMmdXc2tEakwxMVFTTUlhdUJRK0N6M0VwemVZcGp3RWc2?=
 =?utf-8?B?amxtYTFwUUxsRmNuWi9WYVQ3UGVwUzY2anZPUDNMNGxFRWxQbkFRMDZSU3hB?=
 =?utf-8?B?OW1EU1dsQk5IRFY1bkhta3Jsb2tpaDZLd0l1ZTdUMU5UbHpySTlFRWRIc1BJ?=
 =?utf-8?B?MHl5UDN3Q1YveFVqVkZlc0hSNE9pMGxGR0txdkJROUpyeFpCY05rczR4VXV5?=
 =?utf-8?B?QjVZRlZMZDJsdmgwc1p0T0ErUnUxeXFVMjZjdXZ4QVRWcTVsZXhGOXpkbUVK?=
 =?utf-8?B?OENkc3Bjb2V5bm1rM1lmQmxscGMrUzZnRnRyZ3lTZWsyS2JUQjBHU0VtR0RH?=
 =?utf-8?B?bUZOenRkcEpVRXVxeUdXbVBLbEF5bnJRVWFFZ3g5RklQYzkzd3hOQzdwdUhW?=
 =?utf-8?B?ZlNZRGU5cTJDT3NkTE9zbFN6NVQ5WkVtUG9ISkxqUEVzcis2ai8xY2w2M01k?=
 =?utf-8?B?dUx3OCtVdmxOeFozeUJkY1F2NGxvWXByWUhWWDh1S2FvbWtIN1J6ZCtldEtW?=
 =?utf-8?B?TnZhOXBMbG5JVGRsSllhczZ3aFhyNzRMSGNHTS9wa0JkWnNEckswSmVyRjdm?=
 =?utf-8?B?bUpqRmo4R0o2WUxLTE1RQjZGMlpBVjBjQzk5Zm9LY2EyVkZNUWRlV3p1RG53?=
 =?utf-8?B?dGZuamsrRk9qU0RVNllscVphdTUvcFV3c0RDVVBDR0xSMEVRRDR1blgzakMy?=
 =?utf-8?B?RFZtOTdaT1g0QWpYWHpLTG1FbjlHbGcwMk5oSjZlTklGTktIM2NHOERhY29G?=
 =?utf-8?B?WGFqNHMxakZqM3pVOHNDMGtYdmpHSFlQUk9INnZwbjE1OGgyTjBRdlo3eGJG?=
 =?utf-8?B?UFVHNDczMWpwRlRac3pFcldobVFOY0RlZ2JiOG5qak0zTGFjbC9BSXZhRXow?=
 =?utf-8?B?QWlWNCtwaEFyMGtLTTE2eVRvT3dETXF4TFN2cVJNN2JpTHRGTEZCWHVrREdX?=
 =?utf-8?B?MzZ5Wnl6dS84aWpvRXFnVnB1VkxlVStHdEJNUHNDeGx2L2gxMXdzY3I2M011?=
 =?utf-8?Q?vG4YSiL9QMla6ap/qP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2372ca29-c39c-4ea2-77f5-08df2a6ebe79
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 03:45:23.9933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/S1/A934RM6JFUBWhMLBN7yBa+s2RIna4PoYmAAxXWbw8+O3guNIqQTQjaC1mKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMywgMjAyNiA1OjI4IFBNDQo+IFRv
OiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT47IFByb3N5YWssIFZp
dGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzld
IGRybS9hbWRncHU6IHNraXAgVktNUyBtb2RlLWNvbmZpZyBoZWxwZXJzIGR1cmluZyBHUFUNCj4g
cmVzZXQNCj4NCj4gT24gMTAvMTMvMjYgMTA6MjQsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IEdQ
VSByZWNvdmVyeSBhbHJlYWR5IG5vdGlmaWVzIERSTSBjbGllbnRzLiBTa2lwIHRoZSBWS01TIG1v
ZGUtY29uZmlnDQo+ID4gc3VzcGVuZC9yZXN1bWUgaGVscGVycyBkdXJpbmcgdGhhdCBpbnRlcm5h
bCByZXNldCB0byBhdm9pZCBkdXBsaWNhdGUNCj4gPiBjbGllbnQgbm90aWZpY2F0aW9uIGFuZCBh
dG9taWMtc3RhdGUgaGFuZGxpbmcgdW5kZXIgdGhlIHJlc2V0IGxvY2suDQo+ID4gS2VlcCBvcmRp
bmFyeSBzeXN0ZW0gc3VzcGVuZCBhbmQgcmVzdW1lIHVuY2hhbmdlZC4NCj4NCj4gQ2xlYXIgTkFL
IHRvIHRoYXQgYXMgd2VsbC4NCj4NCj4gVGhlIGFtZGdwdV9pbl9yZXNldCgpIGZ1bmN0aW9uIGNh
biBvbmx5IGJlIGNhbGxlZCBmcm9tIGluc2lkZSB0aGUgR1BVIHJlc2V0IGl0c2VsZiENCj4NCj4g
SXQgaXMgKk5PVCogYWxsb3dlZCB0byBza2lwIGFueSBvcGVyYXRpb24gb3V0c2lkZSB0aGUgcmVz
ZXQgZGVwZW5kaW5nIG9uIHRoaXMuDQoNCkhvdyBhYm91dCBtb3ZpbmcgdGhlIGRybV9tb2RlX2Nv
bmZpZ19oZWxwZXJfc3VzcGVuZCgpL3Jlc3VtZSgpIGNhbGxzIGZvcg0KVktNUyBpbnRvIHRoZSBz
eXN0ZW0gc3VzcGVuZC9yZXN1bWUgcGF0aCAoYW1kZ3B1X2RldmljZV9zdXNwZW5kL3Jlc3VtZSgp
KT8NClZLTVMgaGFzIG5vIGhhcmR3YXJlIHN0YXRlIGEgcmVzZXQgY2FuIGxvc2UsIHNvIHJlY292
ZXJ5IGRvZXNuJ3QgbmVlZCB0aGVtLA0KYW5kIHRoYXQgY2FuIGRyb3AgdGhlIGFtZGdwdV9pbl9y
ZXNldCgpIGNoZWNrIGVudGlyZWx5Lg0KDQpSZWdhcmRzLA0KICAgUHJpa2UNCj4gUmVnYXJkcywN
Cj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFBy
aWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92a21zLmMgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZrbXMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZrbXMuYw0KPiA+IGluZGV4IGQ2YjUxYjNmMjE2Yi4uYTQ5YzdkZGE0YzRlIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21zLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gQEAgLTQ5MSw2
ICs0OTEsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV92a21zX3N1c3BlbmQoc3RydWN0DQo+IGFtZGdw
dV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ID4gICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gaXBfYmxvY2stPmFkZXY7DQo+ID4gICAgIGludCByOw0KPiA+DQo+ID4gKyAgIGlmIChhbWRn
cHVfaW5fcmVzZXQoYWRldikpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+
ICAgICByID0gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5kKGFkZXZfdG9fZHJtKGFkZXYp
KTsNCj4gPiAgICAgaWYgKHIpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4gQEAgLTUw
NSw2ICs1MDgsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV92a21zX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1
X2lwX2Jsb2NrDQo+ICppcF9ibG9jaykNCj4gPiAgICAgciA9IGFtZGdwdV92a21zX2h3X2luaXQo
aXBfYmxvY2spOw0KPiA+ICAgICBpZiAocikNCj4gPiAgICAgICAgICAgICByZXR1cm4gcjsNCj4g
PiArICAgaWYgKGFtZGdwdV9pbl9yZXNldChpcF9ibG9jay0+YWRldikpDQo+ID4gKyAgICAgICAg
ICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICAgICByZXR1cm4gZHJtX21vZGVfY29uZmlnX2hlbHBl
cl9yZXN1bWUoYWRldl90b19kcm0oaXBfYmxvY2stPmFkZXYpKTsNCj4gPiAgfQ0KPiA+DQoNCg==
