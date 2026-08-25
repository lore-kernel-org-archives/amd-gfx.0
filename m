Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D02C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E4910E178;
	Tue, 25 Aug 2026 04:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWlXFhCy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D4510E178
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzexQ8UMU/35cILpPiJhnmi4z5PIEL4SFB6NxNgTvi0l08OF7BWH5g1+TdLA29EXh2+lTgBUX2kAmnK9CJot0/xwLO9sN8jZNxhS3gYpBOvEvUqj9Rn42/qukX2QD+x16RefAK68Jo4lfaIAOrKwCMUYF6ClmIOHYNZEiE99FnPrVKGqmCwve3uCrHv6/OvFUF/WfWxUilTgNuByHqHSe56BKmfxpP/0hLdBik/P03xwi+C1GR0skVmK2V4FheEFvBdJgxbplj+t4dCFd7TRQ3BPv0Vf0rYfTnpKPMpcG9yTlAAQ3zhuProeXFPq1V+9EwmM/f/TASET3C7PDgerQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXbH7a13XIEQcRoTe24Uiyht4gzFsXjattA5nr/ZlhY=;
 b=mf+kCAYLMLwVH0HU6gGCpfPeGNaY8xjM7Va8Xfe6LRmZSTEHSIEtFqYqlTMfODz8mug9P8enEf28mCE+8zcgZguMVCGNiwP9jl2hxc26qLMGYbg4b2RhoBGCyd1IPWxUvVTMl0hzaBpiMLngehiMWz3WbvuQjOnSbW1f4TmVqew3VulZizaaiK00eBLFh0GH0ZzkY5JRpFAPruSffMqfzUaF9Xlkz+WnbFFG4CfX2Z3lokRl7PsrwwopP3dSC63Ne5A3sQh/DY2eSMUnqraPmE04uYi0pSqNJl6NyJkrXAyfQVea7LYPWfJUcYMG3tp2JDQpE2sbaQKBo7ZmPiOf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXbH7a13XIEQcRoTe24Uiyht4gzFsXjattA5nr/ZlhY=;
 b=pWlXFhCyy7d13RHsJaipFn3kJhu84DBQ17D9jNVqN2seMj+Ot7CAdTd+viQcDg3kEky7LWBExAXDj+UhML+m//21gqD0YNLy7HgfjSVGaQVo0eQQmifQ1AnhmJeeIZ4VjajT2Vw6IzRQ5kZe+LBt71kNRnK21s+AkQ00NE4r++o=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:59:44 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 04:59:43 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Six,
 Lancelot" <Lancelot.Six@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "Zhu, James" <James.Zhu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, Samuel
 Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: RE: [RFC PATCH 0/3] drm/amdgpu: Render-node second-level trap handler
Thread-Topic: [RFC PATCH 0/3] drm/amdgpu: Render-node second-level trap handler
Thread-Index: AQHdMHHTcGhZ59TZOUiR1d4/KgbXdLamq7AAgAePUFA=
Date: Tue, 25 Aug 2026 04:59:43 +0000
Message-ID: <IA0PR12MB8208C05799E5FC8AFBE2664A90AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <fVqQkdSNQqGMlqwq2rRIgQ@gmail.com>
In-Reply-To: <fVqQkdSNQqGMlqwq2rRIgQ@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T04:55:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CH3PR12MB8711:EE_
x-ms-office365-filtering-correlation-id: 26e2fbdb-b5ea-4bd0-df3f-08df0265ad9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info: 5cD3OBAOjAnulzeArr+I54NCmIg0TD6HrWLpX6A7nYfkZg75K/DHz0C6PraIKKTe4no2XCL/ZETUx7+NkxW4Luk+hRi6V7grwRnhe2Ts3GtR8BnvMqklYiqReSfI83SWEbQfvA4EwKcycWmJkFHfbWAvJ9m9ZG+gfe+T1xNQEbfkSgUfihsQV307joPLcz4gjeTUE9gUEn2xzurGPKXSzhYzetW/XF5tyNMS2Lu5iKegGQAHAemBDWDgb2MaasH60g1LjUmJA9snDBYtCTAG8IwRyGIPnHloyc4FJwNLwuHYFuZsXSbb0cbgVqeCfgOCI09gPjuoH/ZiqaGSM564FAYeIC9jNMEk72dL/MTVVmQVRdrt8S/S/OXPFnAtYKR48/vEbSToDh7lbyTeRKbxMBdqP4zy1UwyEMOELzPnPCXJcuAYpQ0C0731nEpDiSkP9ZTEozk/cldA3tJZPKsWB5okrvtY/bnLrcK5/R7t/EyR5v6xq2KRDWI/mzHD277b85PWpx++tslK4rSdBFjlclHpfY26lIDDU9jwfwU8tVOBg1tT2mVZReuJliaZRh52M+6WPyuVGXR1RhXpaOM6ZF/81tZhiIlvVv18cx1UsKpdq2/jL2QW05xePJ0i3eUEI7wpt5pW6yU4dOHiv5k06FEmIzqJ5wuDr37mTmXmcWi3d2yMb3EY2hlRS4Mk5oSiafcq2GXOt7hkUpmGl7OT94XM4bQFXLyT8O1Ev7mW7GE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0V2RUJaTzJnSjRpd0NMcjlWeFBwcmc2akdVY2xMczZ0UXRHVUUrUVpPSFJ6?=
 =?utf-8?B?bm1kN2ppZDBvUWZubWlwK00rUTZwbzJ5L290SWp1YklTZUVQR3RQSEZwcnVV?=
 =?utf-8?B?NU5ISWt5VTNmamR4cG9rUnBpNEtLM2tFL25yN0o3bjVrMzV3YmpySFUvTE1G?=
 =?utf-8?B?WVRad3FKVHZVSnVrYnkvamJITnBlc1JrRnloWWdMU0c2emdRcS9XSTFxNU1Q?=
 =?utf-8?B?VG4rR0V6OTA4YzhmWkpuYzFabThDOU94R2xJV21YS24xU2cxU1J5cGZvQkE5?=
 =?utf-8?B?a1FYcGx4TVFRdnQxYTd1OTBZekV2SUp3ajhLMkJqT1hVTHhORDJtUnlwOUhC?=
 =?utf-8?B?V3NEc0xDcHhWVWxkeW1pNi95UTJPb3plTkZjNHcreGk1RVJvSmticjMxRjB5?=
 =?utf-8?B?KzRLUWZoM1dvSlpIMTFIdTdHVUNseS8xK3JqUmhVNDJLbEdSR2RRbW5XTEZ4?=
 =?utf-8?B?eE55QmE5WFVESFZadHoyTDVTQ0s3VXNXUEVvU3B4TWllcElka05DeVNHeE11?=
 =?utf-8?B?SjVIdEd1WFphaHBvcVdwT1NpVk1sVW54NDJZcG5HWUhPN3lHUGRJRTlrOTVV?=
 =?utf-8?B?cEdPTVdYSUpxTDlqQ2dxUlkwYmtaVFlEUm1hR3VvVTFobTlMZE04Ui9aRUZ3?=
 =?utf-8?B?OHhuVlZHdW9CQTlYWGpvMytjNUxCR0JmRndEb3N0cDZ3VjFhYjk1VXFnMDZo?=
 =?utf-8?B?bHc0Qk5uVjdXc0NiYllXa2NsZDhRdFVKNjN3Zm02Z2R1bkQ3djhWNy9ITTdy?=
 =?utf-8?B?ckRZcVZzcGFJNndoWGRzcW1BNmVWa1FGa09BYTNRaGJGd0RVK2JwTE5OZVA0?=
 =?utf-8?B?QkFSdjRFQXNMVFpxTnRvdmRjYUlYem8wekpxTklzTkkyUEU1dzRZU3lKOHNY?=
 =?utf-8?B?cy84TEEwZm5UaUhNWFhmNmRERG92NDhMd0RhWHFHanViV0R4V2R6WmEyZWFx?=
 =?utf-8?B?N0RJelJ0a2MrSWN2b29JRXJ4YmdXRkhQNktDT1RJNWJZZ2NBUCtvR2VTQTJ6?=
 =?utf-8?B?eWNFRFFiOUdNRHhVQ2FNd2lXVXVPNDVBWS95c3BKL1pFb2U0U2FldFliVVQz?=
 =?utf-8?B?Um9TRkFtYXRvK3g1dnp2enlTeWVEbWJidlN2R1Z3WlluMUgrZzhkNDR3TERW?=
 =?utf-8?B?M0kzYkQydnBheU5TUTBHOUZncVBrMWV5RUJiMGlFRlpOdUhKSTd3WnU3SUxo?=
 =?utf-8?B?bnJvM0sxZ1NqNDloTTluVVNROHhWblJKZ1NndDdLbUhNSCtaQUJyNDFpUFF3?=
 =?utf-8?B?R0hYOW91eTFiYWhtYWk5MU9oaWZ6YUpCNDVrbE9CZkxPSVFFa0t4bUFwS1g1?=
 =?utf-8?B?bS9Mb1czMHhibVd6OXVybjg1dDl5QlJNekJUMUNEMnNHRkxwWjlJZWlPdXNG?=
 =?utf-8?B?cERyVHR2QWJ5KzYrRlh0K2h1bktGWnpjc3VMbDlpcTQ1SkxXN3hmYmk3K0l5?=
 =?utf-8?B?WUZhbVN5enpRS04rZHpNOUZjWEhSWklSalJ6VWI1Q1hhNzgyZENqenVxZzl3?=
 =?utf-8?B?NUJDdlAvczYya3J2SDlER0V0ZFlMMk5JTFJhNEJmOVFFNWJadEY1TFkzRUFx?=
 =?utf-8?B?SGRreVhQMHRFNHVhcUVEMk1oK3dYR0M4SVBaS1RuZUxtNmZSRjgyaGZiU0pO?=
 =?utf-8?B?SlM0UEM4VUdsMVVCbkJ2ZnIrTHVqSjBpTEpBRzlaYlpGTzA0bTNJaWp6dGFU?=
 =?utf-8?B?NzhLWmVrVXhkSTB3dXhDZ2hSTW4vTDJoV2Y3dzlvaHYxZUQxL3VFZXg1aWhj?=
 =?utf-8?B?VUNWaWZvRjZrNUo1MlNQaUxSMmk5bUNhcE5uR2xLbFZvZnBLNmVpcHEzditH?=
 =?utf-8?B?QmRtdzZTL2g0bGF4RW8yb2hjMHRUQytCeE5uL1pMQVJSTzNyN2JpOE9vaUZT?=
 =?utf-8?B?U2pYUUVRWUZlK3htRmRNcGJVMHFVT291OHJ5OEJ0Zjhsa0JWQzJyc3lvMTgr?=
 =?utf-8?B?enYwcUVpaDJUQ0pSbEVZS2I1NGRpN00vQ0xYM2V3UkxHbG9JZHE5dUE5NkxK?=
 =?utf-8?B?QmNRcjZ3eEQrZHVnbVdYd2lFYW1DV3lNT2ozTUlUUWdwTTc2Yk5qdzF4YmZI?=
 =?utf-8?B?RUFHVnhIa3UvUVNLWjJjaVB4dUE3MU00dlp6TGl0RHMxVlJNTmg2QVo3VW1E?=
 =?utf-8?B?Q2liN0dINlpmcGFxdHBTV0lDNmwzRDZLQWNaR0cvbFFHaHhxVzJ1VVFVT0ln?=
 =?utf-8?B?MXRhb3dFZjBmaURMUHB5bkk5R0JhNDM1TEdNNVhhK28xVlZNY3VYc0cvdzl6?=
 =?utf-8?B?dEJGS3BtQzlod2pkR3hEeHFxK3Iza0dCV20wR25QZVk1U1VWeXBvdEJjQmpu?=
 =?utf-8?Q?AuGlRP9HfD778BNhvk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e2fbdb-b5ea-4bd0-df3f-08df0265ad9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:59:43.7180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5+0fnbJC+gtqU3mhCuuFYzEpOQKq9riUuOOUijsbZ3cy3/pu42knLmtbi5uCA8nn7YCLqIUbU3I5oZB+814Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBB
dWd1c3QgMjAsIDIwMjYgMjo1OSBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVH
QU1AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBTaXgsIExh
bmNlbG90DQo+IDxMYW5jZWxvdC5TaXhAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT47IFpodSwNCj4gSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPjsgTGF6
YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFBlbGxvdXgtDQo+IFByYXllciwgUGllcnJl
LUVyaWMgPFBpZXJyZS1lcmljLlBlbGxvdXgtcHJheWVyQGFtZC5jb20+OyBTYW11ZWwgUGl0b2lz
ZXQNCj4gPGhha3pzYW1AZ21haWwuY29tPjsgTmF0YWxpZSBWb2NrIDxuYXRhbGllLnZvY2tAZ214
LmRlPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzNdIGRybS9hbWRncHU6IFJlbmRlci1u
b2RlIHNlY29uZC1sZXZlbCB0cmFwDQo+IGhhbmRsZXINCj4NCj4gT24gMjAyNi4gYXVndXN6dHVz
IDIwLiwgY3PDvHTDtnJ0w7ZrIDk6MDE6NDAga8O2esOpcC1ldXLDs3BhaSBuecOhcmkgaWTFkSBT
cmluaXZhc2FuDQo+IFNoYW5tdWdhbSB3cm90ZToNCj4gPiBXaGVuIGEgR1BVIHNoYWRlciBoaXRz
IGFuIGVycm9yIG9yIGV4Y2VwdGlvbiwgdGhlIGhhcmR3YXJlIGNhbGxzIGENCj4gPiB0cmFwIGhh
bmRsZXIuIEFNRCBHUFVzIHN1cHBvcnQgdHdvIGxldmVsczogYSBmaXJzdC1sZXZlbCBoYW5kbGVy
IHRoYXQNCj4gPiBydW5zIGluc2lkZSB0aGUga2VybmVsICh2aWEgQ1dTUiksIGFuZCBhbiBvcHRp
b25hbCBzZWNvbmQtbGV2ZWwNCj4gPiBoYW5kbGVyIHRoYXQgcnVucyBpbiB1c2Vyc3BhY2UuIFRo
ZSBzZWNvbmQtbGV2ZWwgaGFuZGxlciBsZXRzIGENCj4gPiBydW50aW1lIG9yIGRlYnVnZ2VyIGNh
dGNoIHNoYWRlciBleGNlcHRpb25zIHdpdGhvdXQgYW55IGtlcm5lbCBjaGFuZ2VzLg0KPiA+DQo+
ID4gS0ZEIGFscmVhZHkgcHJvdmlkZXMgdGhpcyBmb3IgY29tcHV0ZSB3b3JrbG9hZHMuIFJlbmRl
ci1ub2RlIHVzZXINCj4gPiBxdWV1ZXMgdXNlIHRoZSBzYW1lIGZpcnN0LWxldmVsIENXU1IgdHJh
cCBpbmZyYXN0cnVjdHVyZSBidXQgaGFkIG5vDQo+ID4gd2F5IHRvIGluc3RhbGwgYSBzZWNvbmQt
bGV2ZWwgaGFuZGxlci4gVGhpcyBzZXJpZXMgYWRkcyB0aGF0IHN1cHBvcnQuDQo+DQo+IEhlbGxv
IFNyaW5pLA0KPg0KPiBUaGFuayB5b3UgZm9yIHdvcmtpbmcgb24gdGhpcy4NCj4gSSBub3RpY2Ug
dGhhdCB5b3UgbWVudGlvbiB1c2VyIHF1ZXVlcyBoZXJlLiBEb2VzIHRoYXQgbWVhbiB0aGF0IHRo
ZSBuZXcgdHJhcA0KPiBoYW5kbGVyIHdpbGwgb25seSB3b3JrIHdpdGggdXNlciBxdWV1ZXM/IFdl
IHdvdWxkIGxpa2UgdG8gc2VlIGl0IHdvcmtpbmcgd2l0aCBrZXJuZWwNCj4gcXVldWVzIGFzIHdl
bGwgYmVjYXVzZToNCj4NCj4gMS4gVXNlciBxdWV1ZXMgYXJlIG5vdCBzdXBwb3J0ZWQgb24gR0ZY
OSwgR0ZYMTAsIEdGWDEwLjMgMi4gVXNlciBxdWV1ZXMgYXJlDQo+IG5vdCBlbmFibGVkIGJ5IGRl
ZmF1bHQgeWV0IGluIHRoZSBrZXJuZWwgMy4gUkFEViBjdXJyZW50bHkgY2FuJ3QgdXNlIHVzZXIg
cXVldWVzIG9uDQo+IGFuIEdQVQ0KDQpIaSBUaW11ciwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJh
Y2suDQoNClRoaXMgc2VyaWVzIGZvY3VzZXMgb24gY29tcHV0ZSB1c2VyIHF1ZXVlcyBmaXJzdC4N
ClRoZSBVQVBJIGlzIGRlc2lnbmVkIHRvIGFsbG93IGtlcm5lbCBhbmQgZ3JhcGhpY3MgcXVldWUN
CnN1cHBvcnQgdG8gYmUgYWRkZWQgbGF0ZXIgYXMgYSBmb2xsb3ctdXAuDQoNCkJlc3QgcmVnYXJk
cywNClNyaW5pDQoNCj4NCj4gVGhhbmtzICYgYmVzdCByZWdhcmRzLA0KPiBUaW11cg0K
