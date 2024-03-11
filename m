Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E69C5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 15:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555E410F0AD;
	Mon, 11 Mar 2024 15:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GlH9Wch4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF940112B19
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 15:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kio2llrXsTTxYpIUq0ugrGHWIW2GazYroCgWUVhdZamiyouLla8MHO68/D+gxtvB7DCJESWgAi6lU1N/Q1JojlVzEE/CW13LrixWfzOnwfZlZmtZeRBTU9iLNn6x8r4j1kHX0Ty2qGwv+TGvXr/2Ez5K3MShvALaj0/yO3XYQXgGXhrXa9yp8BWSkzsp+eru7TGSOSeVobUIjhYCPXa+AJb3rh2i8WPhZkHwpyFq38IahAPcNhO7ZW+k9njAXct7kjVKW51afquvgNeomABCHsQCwDkSLz+nk7bnVlhVYv2zS4Ci67sVHGsnniyRkS4H1Cj5U7DYMiNaZpdOFMbWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b8lormeYmYq4JpXCz3tK+47kiPayMoRexG9tZRLiP0=;
 b=FkcvMwv31wAl25/zEycH6Y053Myyutooo52IGSYRYxMWZ2UAeoP+WmOyIsNSBGLMN5rGnnUOy0mGjobC/N8pPXQf0doUrwfH4CvaPLCM8HaosbQ3lUFt1aHlCG5JmCphAqsmsOZ3RSp4TwKXv/I+t+jcfrbo4HouVEouSzkbKVLJK5mZDQx6cgwaYOnPaSXvan9kIsjEQ+3d1BdrZ65fwwudpMq4X7659zV4eqGXs3KVuVWqoZ9D0JOrpDMhHJnNiCF1GuVyOseCYNrAM4YEuK5xP0q/Wk46KFvzfnIuEthIIAdr/nUuMBxNy3fI1n6kVK0yNS58v/rSc+E7GEZ4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b8lormeYmYq4JpXCz3tK+47kiPayMoRexG9tZRLiP0=;
 b=GlH9Wch49v35F3tdVnhlOpBSHTr7sbzuaHGK0/sn9PpFJirjzOG+5pVPCc5VYH19XVVNT6JyEB0Gp8FNXu+Mw5zHZJ3hzG1KeK9jU1uygWMhB0bdCqKDla5BPBqFUds0LDK33LxX8RDYkq/pny4wvngcJsCcgBLkRPoanM7tVr0=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 15:25:08 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:25:08 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Thread-Topic: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Thread-Index: AQHacXToxD1WfV5D80+X2y/tzgqIYbEyHbeAgACP1+A=
Date: Mon, 11 Mar 2024 15:25:08 +0000
Message-ID: <BL3PR12MB6425EFDC27818399BA85C1E2EE242@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <4098f759-dc58-422d-b000-af8126775966@gmail.com>
In-Reply-To: <4098f759-dc58-422d-b000-af8126775966@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=73804b74-46ca-4c2d-9f6f-607f587c8234;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-11T15:24:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|CY8PR12MB7683:EE_
x-ms-office365-filtering-correlation-id: 62150340-cfc4-45bc-e248-08dc41df6f89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1eqOPcKKUna3DpCYo0fJqyjDO6RgcVmuH/NlC2cqqB3EMVm3VnlUZ23jJWfHqin2ydUd0TjIEYspF1CghwMoAQ7LKv6VTTXQKTq21SWW0Mo+tkISbXI/G3Jq7dahQI6W51AxvV6OPvHOQInt1gcjqSbDenLPk4fgrN48zYDggLJgtyx57FhGDcV5LmgDQfT/XNooD92psahpPQUdZ1yLjEQY6Eri9SUsvUks77RHxi55EMyE9+auSaUhUj0DOP8j9Rkka6REA4BFmiFqLfjZ7ZEEh+Oy27y0f0BS7n6dyrRE3gC5aBYh2S2dBMwxRKYfqGotNa6Of1qQ6aH2Gmt+Yhvxn5s79SLepJIRCmAN7sWAY4eKqzy0L2/2ZVVJuwBC5UBIiSQIuZ6AvJeYm/fmI7uI+XMZJNH8GKOECmB0LN9SLyJEz70eoxyMFoghCYZxiUPd8p1Dn1+SR9dbCfWyEN/uuORo9CFrcMl1dmFrillp+kw6j9yRr241l4uQznahOgb1NNWTKb6L9vRhWT53MD8vfU1qA1+f4Y57culc3aWFo+9418EZyzaAa4nrImxpm8kllF4hXDSOyD7Mf6jYdPGVivNo9cWbWAXDpP6vNoR9nfQjTWbCFEgNXIf+x5u2xZh0Qh6/wviokz5EZAJi2kp3FF5xm50fAcV3xaOL5ojHm+8ni38551akUZGtJ9oifAiQoXShIkIIWPBH0Y+o83A9j5D1+yrfa4dgTdMY6r0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2tScmhIZHRVall2TXM2VjRqYTVZN1IvNjUxWWZXUzdZY0RZRFFPSlhuNjJl?=
 =?utf-8?B?WkwvMWdwaFNvdkM1UU9tckduNC8ySEZXMDBiSWJraEFXNWRCaUdmaS9KZHZR?=
 =?utf-8?B?dzh2RmlsTGphbzNBM2JyQjhpTVowbGowNU9OVE8rS2pINFpSQ2JoYVVGeHBL?=
 =?utf-8?B?YmxZS0N4cXViV1hMRDlUYkgwajlrYUdJenZxMjNTNFN0cjRLNW9ia3lwOEQx?=
 =?utf-8?B?eEFJMzdQa2ltaElWekZ6aDFoMThodnh6aTJscHFwamFBV2tyYzVSQ1BUcVA2?=
 =?utf-8?B?MDlRMzB3UWQ5NC9FaVo1bkxoVmI4ZGlocEEzT09qRmpFQVR4a25paHNvdHlE?=
 =?utf-8?B?em5tQWFYaERFeG1OdGJsL1FpZ1lPYXV0cUZKUENmaEY2cXZSOVhVN2tuV2xr?=
 =?utf-8?B?amM1U1ZpZmdrUzFpUTJyT09GRXRWMU50dVpRUHpWQVAvRmpRRzFTUzh4QjM1?=
 =?utf-8?B?aDlqdElBdlp4WkpzZEZhMlo1TjgyeVFvVGpoVGNOZW4yYyt1VCtNTTI5NTJE?=
 =?utf-8?B?WVFZVnVYajEwRWk5YWxEaVNYdUhxL3kzTEFTMDhOd0xHTVZMQitvc2w4dFdq?=
 =?utf-8?B?MU1lNEFaY1E5Szg4T0FEK0pQdStmcHJyQ284QzI3NnF6YVdOaEtQa1llYmFD?=
 =?utf-8?B?aFUyN2I5SlRoLzdramNXRUxXaEdXc1dlZ3hSRzdYSmRJM3N3V0lBK09CK2R1?=
 =?utf-8?B?N25xaXB3V3U5Q1VyT2Y2TklaME5uMTJBamtuZ3lqSFpDYjd4UlZWZjBhVHoy?=
 =?utf-8?B?WStmYzZTakUvVFhCV20zMEV5WlRnb2ZjekdYWGJqakxVWUNoR25uZE5tZXB4?=
 =?utf-8?B?UzhudWVYRHZkUHpGSER3c0t3N2pJZWIweFo0RXFtcWNKNGxMelp4UmpZUktt?=
 =?utf-8?B?MjdJc3hocUEyYXYyaThFRjNUbXAxUmVSNVdvdWFVVEIvRkQzVFFQb1RWanBa?=
 =?utf-8?B?d2l6V29yLy9tVXF0czhoSjFEc2tpV1RCVmFBT1ZSdDZSSVhoV3hxNkNpdmxX?=
 =?utf-8?B?WVBkb2g1emtVSFJiZml4NTZxdnE4TUd4dkhFVVhHVDZhR1lOZmNMbEVEUk9k?=
 =?utf-8?B?d3pVODlNVXFWQ21JeEdJM1plL3JaWW5QVmdpRmJLWlR6c0hYdTMvdTJIQXhT?=
 =?utf-8?B?akJ2b3diZjVDZ3U3OS96YjIzSTMxYmhic2ZUTzRLQlNKYnRqZmhXVFpsZ0c4?=
 =?utf-8?B?N3RMNmhUWnc0UWpNT25JcXF1QlcxbXpTYUV5OWY2bThvc0pFcEEyaDZ6UnZr?=
 =?utf-8?B?V3hDdjR4ZE1xOThNRnpRN0U0RmdiNFBtT1FTZTFPMmwwejVLS3dhL3d4dFY4?=
 =?utf-8?B?Zml1TWRsUjZqbUZBOUc4SmVrQ0V6b2ZhY2FOdTdYSU1hbjVyNzdEZGdlRnRK?=
 =?utf-8?B?aGRSQzhMYjA3M3FENzFJZjcycmFUOUFkRTBaZFRML3g2dUFCd2J1QjdOdURj?=
 =?utf-8?B?RDVkR3VzUHBrTTh1eU5Db1g1WE5aREc1RkRpT0hxUlZjVGlCTG5ZbEZST3U5?=
 =?utf-8?B?N0ovTzZBMnNyZjV2Vm54WG5wTXhLZEpnWmd2STVCaFBKSlFnbi8wVGtuaEpF?=
 =?utf-8?B?KzErOGszdVVpSUhvc0ZGNXVuNEtleHNCdW5QZ2tPTW45NkpGaDJiaFZmcHo2?=
 =?utf-8?B?RDd6a1pTWHhseGJHRTB5MzhjeWJSLzhzUUZKTHREaW1ReENwcXBDbzV1eG83?=
 =?utf-8?B?VkF4bE5vYjJLQzdxdlNHUUpFNFZqME4wM2l2Z1FHL0dJZnRwMzgxTC9RSEVq?=
 =?utf-8?B?cFNUUEJPWkRzLzNrZGp6ZWU1RDZlTU5FaGV3bXJHZnpkakZYOG5zbUZKaEFD?=
 =?utf-8?B?S2x0aDA3SU1iMWNjL043THpQZ3lqTm9Scnk1YndMN1YvZFBDVFZESEh2bVJr?=
 =?utf-8?B?empiVmUwMVNwdXZ4elZURFk3V2ppY2hWQzR0d0QrQXhOdXIrcnFCSlBYc25o?=
 =?utf-8?B?bERYQXNHVEFIUENFa0xzbW5JN1hhNldGcElwdEx0eXc2SFJjK0ZxVjlUaGtl?=
 =?utf-8?B?bHo5bzZ2clMxZVM5N1J1WGhwdDZjZm9FU0tXdEJlV0I1MWw5QjlpUXFHNGhs?=
 =?utf-8?B?NHFFem1EL1l6QkQzbVE3VDNyMVM1RmR2NTQ4aG93anlGUmZ4aHRyL0F6alQ4?=
 =?utf-8?Q?kyhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62150340-cfc4-45bc-e248-08dc41df6f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 15:25:08.4216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMjF8YZ8zQDOO3+caRoUJ5j87flhDWRYc8pz/7P3+lYiCSloDcK0VnVP3+66UeDjd5R00iYsca55gGI4qd2Erg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTEsIDIwMjQgMjo1MCBBTQ0KPiBU
bzogSm9zaGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogSGFuZGxlIGR1cGxpY2F0ZSBC
T3MgZHVyaW5nIHByb2Nlc3MNCj4gcmVzdG9yZQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ug
b3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+
IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcu
DQo+DQo+DQo+IEFtIDA4LjAzLjI0IHVtIDE3OjIyIHNjaHJpZWIgTXVrdWwgSm9zaGk6DQo+ID4g
SW4gY2VydGFpbiBzaXR1YXRpb25zLCBzb21lIGFwcHMgY2FuIGltcG9ydCBhIEJPIG11bHRpcGxl
IHRpbWVzDQo+ID4gKHRocm91Z2ggSVBDIGZvciBleGFtcGxlKS4gVG8gcmVzdG9yZSBzdWNoIHBy
b2Nlc3NlcyBzdWNjZXNzZnVsbHksIHdlDQo+ID4gbmVlZCB0byB0ZWxsIGRybSB0byBpZ25vcmUg
ZHVwbGljYXRlIEJPcy4NCj4gPiBXaGlsZSBhdCBpdCwgYWxzbyBhZGQgYWRkaXRpb25hbCBsb2dn
aW5nIHRvIHByZXZlbnQgc2lsZW50IGZhaWx1cmVzDQo+ID4gd2hlbiBwcm9jZXNzIHJlc3RvcmUg
ZmFpbHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNdWt1bCBKb3NoaSA8bXVrdWwuam9zaGlA
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyB8IDE0DQo+ICsrKysrKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+
IGluZGV4IGJmOGU2NjUzMzQxZi4uNjVkODA4ZDhiNWRhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+IEBAIC0y
ODY5LDE0ICsyODY5LDE2IEBAIGludA0KPiA+IGFtZGdwdV9hbWRrZmRfZ3B1dm1fcmVzdG9yZV9w
cm9jZXNzX2Jvcyh2b2lkICppbmZvLCBzdHJ1Y3QgZG1hX2ZlbmNlDQo+ID4gX19yY3UgKg0KPiA+
DQo+ID4gICAgICAgbXV0ZXhfbG9jaygmcHJvY2Vzc19pbmZvLT5sb2NrKTsNCj4gPg0KPiA+IC0g
ICAgIGRybV9leGVjX2luaXQoJmV4ZWMsIDApOw0KPiA+ICsgICAgIGRybV9leGVjX2luaXQoJmV4
ZWMsIERSTV9FWEVDX0lHTk9SRV9EVVBMSUNBVEVTKTsNCj4gPiAgICAgICBkcm1fZXhlY191bnRp
bF9hbGxfbG9ja2VkKCZleGVjKSB7DQo+ID4gICAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KHBlZXJfdm0sICZwcm9jZXNzX2luZm8tPnZtX2xpc3RfaGVhZCwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdm1fbGlzdF9ub2RlKSB7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IGFtZGdwdV92bV9sb2NrX3BkKHBlZXJfdm0sICZleGVjLCAyKTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgZHJtX2V4ZWNfcmV0cnlfb25fY29udGVudGlvbigmZXhl
Yyk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShyZXQpKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkocmV0KSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHByX2VycigiTG9ja2luZyBWTSBQRCBmYWlsZWQsIHJldDoNCj4g
PiArICVkXG4iLCByZXQpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
dHRtX3Jlc2VydmVfZmFpbDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgfQ0KPg0KPiBUaGF0
J3MgYSBiYWQgaWRlYS4gTG9ja2luZyBjYW4gYWx3YXlzIGJlIGludGVycnVwdGVkIGFuZCB0aGF0
IHdvdWxkIHByaW50IGFuDQo+IGVycm9yIGhlcmUuDQo+DQpUaGFua3MgQ2hyaXN0aWFuLiBXaWxs
IHNlbmQgb3V0IGEgcGF0Y2ggdG8gY2hhbmdlIGl0IHRvIHByX2RlYnVnLg0KDQpSZWdhcmRzLA0K
TXVrdWwNCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gICAgICAgICAgICAgICB9
DQo+ID4NCj4gPiAgICAgICAgICAgICAgIC8qIFJlc2VydmUgYWxsIEJPcyBhbmQgcGFnZSB0YWJs
ZXMvZGlyZWN0b3J5LiBBZGQgYWxsDQo+ID4gQk9zIGZyb20gQEAgLTI4ODksOCArMjg5MSwxMCBA
QCBpbnQNCj4gYW1kZ3B1X2FtZGtmZF9ncHV2bV9yZXN0b3JlX3Byb2Nlc3NfYm9zKHZvaWQgKmlu
Zm8sIHN0cnVjdCBkbWFfZmVuY2UNCj4gX19yY3UgKg0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICBnb2JqID0gJm1lbS0+Ym8tPnRiby5iYXNlOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSBkcm1fZXhlY19wcmVwYXJlX29iaigmZXhlYywgZ29iaiwgMSk7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGRybV9leGVjX3JldHJ5X29uX2NvbnRlbnRpb24oJmV4ZWMpOw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkocmV0KSkNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwcl9lcnIoImRybV9leGVjX3ByZXBhcmVfb2JqIGZhaWxlZCwNCj4gPiArIHJldDog
JWRcbiIsIHJldCk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB0dG1f
cmVzZXJ2ZV9mYWlsOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAg
ICAgICB9DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gQEAgLTI5NTAsOCArMjk1NCwxMCBAQCBpbnQN
Cj4gYW1kZ3B1X2FtZGtmZF9ncHV2bV9yZXN0b3JlX3Byb2Nlc3NfYm9zKHZvaWQgKmluZm8sIHN0
cnVjdCBkbWFfZmVuY2UNCj4gX19yY3UgKg0KPiA+ICAgICAgICAqIHZhbGlkYXRpb25zIGFib3Zl
IHdvdWxkIGludmFsaWRhdGUgRE1BQnVmIGltcG9ydHMgYWdhaW4uDQo+ID4gICAgICAgICovDQo+
ID4gICAgICAgcmV0ID0gcHJvY2Vzc192YWxpZGF0ZV92bXMocHJvY2Vzc19pbmZvLCAmZXhlYy50
aWNrZXQpOw0KPiA+IC0gICAgIGlmIChyZXQpDQo+ID4gKyAgICAgaWYgKHJldCkgew0KPiA+ICsg
ICAgICAgICAgICAgcHJfZXJyKCJWYWxpZGF0aW5nIFZNcyBmYWlsZWQsIHJldDogJWRcbiIsIHJl
dCk7DQo+ID4gICAgICAgICAgICAgICBnb3RvIHZhbGlkYXRlX21hcF9mYWlsOw0KPiA+ICsgICAg
IH0NCj4gPg0KPiA+ICAgICAgIC8qIFVwZGF0ZSBtYXBwaW5ncyBub3QgbWFuYWdlZCBieSBLRkQg
Ki8NCj4gPiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBlZXJfdm0sICZwcm9jZXNzX2luZm8t
PnZtX2xpc3RfaGVhZCwNCg0K
