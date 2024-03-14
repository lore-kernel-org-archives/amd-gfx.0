Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C4BC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 13:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0687D10E89D;
	Thu, 14 Mar 2024 13:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qPGEiKEb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A66D10E89D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 13:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9Yp4UeWBXksBzOrPk6GJAC/WcTSW8japbJ8guIws9LCCSqWDcf+iIOAzfkOggQ9SpGngv29BW7yrh9uZPLZST1awb/xhMA8WJaOOCpUYugo3XlrFq1HohsrK9NsiEwM9rByV2QYN8bO3pV07lovAheiS9sGyJiA5Hu2v/5YwzbwPvvQBC/LVa/iQ4IeBxi3z40FCbHClZeo4wg62rAb1PeJ5+SN+V1zNjhcREWABKslxTvn2vjVINkvjskzHMVrYuWIckoQETQYyU8GvynnQ+ghdDfB8d8q0NI8nJGfSThMCkdqEpz8IxjIUU4uVaf2hDMjnaFMrH3A3VlIQsq07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTCIgeQSHTmzvoSBkGRgoVcmT+J2HwxlI9/ZX+KpxXU=;
 b=iR2WCeHFkEtOfrkZLt3ZlFaVaiy4UNzheVJjiy3h8/IHjmtLAFxWLokS70HBP78ZaNAULFwwHrw9Jvp67OSu2DvL6CGNX3+waLqG2qmFXARqalqCi5hQk4xY3vE+8GOLJiBOFejlrqrJin/HLVmuMl3XW1R1NbYiKd2J4NvROPOQIb9t0CPZ6hCPDIU+sA1Y4eN4PTQm3w+bN8n/2qq76lTegMIMO7UHN4R422HQJgMyL0NJo0nITOQVMnC8hF8t1gYV97N6HD952HSUz62PdU1tcmGPOeKzKvU4CKNyypWaKv4unrccmujXPcDWQnVMAopGieEHdrRFPot/zq5hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTCIgeQSHTmzvoSBkGRgoVcmT+J2HwxlI9/ZX+KpxXU=;
 b=qPGEiKEb34sJCG9gysCk4JkSqrH14hwp322KbEAWja11/ViKuTBm3YNGFKXO/ofqyzuvgs3bTg56xT1QAjbWgUT6E54FvJA4KyWGc4azH+kuD4AFq4muAUWnv3XSMDngHSssqlH4Cvq55oWJpWKfnm0xRrnBSBIS5bakMFLjvdw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 13:24:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:24:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Bypass display ta if display hw is not
 available
Thread-Topic: [PATCH] drm/amdgpu: Bypass display ta if display hw is not
 available
Thread-Index: AQHadhIlwsjjRn5Np0KAAizmT/dnVLE3OUoAgAAAguA=
Date: Thu, 14 Mar 2024 13:24:53 +0000
Message-ID: <BN9PR12MB5257B5CBAD0165181E488069FC292@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240314131830.27538-1-Hawking.Zhang@amd.com>
 <CADnq5_NGvtS1L-YfZJDYu2SSYZphg1Vm1CFjq5jbE19SaffWuA@mail.gmail.com>
In-Reply-To: <CADnq5_NGvtS1L-YfZJDYu2SSYZphg1Vm1CFjq5jbE19SaffWuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a343c25a-e958-40d4-91b1-7d86ea41f2d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T13:24:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6868:EE_
x-ms-office365-filtering-correlation-id: c323b2d7-6c10-4818-743b-08dc442a220c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxcHkjQ/hh7sTBBWwla273EAhNvzLbqX5gfDeb5NgoQi1IC3a4t0D2dDCL0i/OY42F+HclpqkIAL2yQFxRwJbJraxqm/zwa0cWNDGxPVrUR1taOwGLI90dBjBRAU/vgiZKFBwaS+bp4Z1OcR8xBtDJKQ+YxR88wCk1qAuFyjRSwWXe235P0p6qfzn1q6uc28MdRqmWJn04Hg76OgZQkPW+xzSZ/UKN28KDkDElMUqQ/YQtXZVpt/OhapfQ5I7gLQzOOZ0LIuW9YzHXqiLtf+rRIwZHKHgkFfmFtDhxLGP22HicFd2kPMat3qCNnLhk6Kt/rZAX5XdPlzsBVjFjhsGbVSQaxDCF1XDkDRv0XUmKr+uYPuhpB+v0RtVyxuwZ0Hc8jzCP2UmT2ohOvYPIZjKu4GXiUFLvGJULXvkL3z9GWuqi5DWmsrz4RCrXu9/oVmTeAqpuCq0R/8u4t8uyn2oUjoxcAHyoBJwRpNVMfHIwykac4WPbcpipFJ4gFu0DwYNLXk6sSbkyU0i9ebKEmyysjmAWBl4jE+xvQ2jnuGgMJrqStmujkpF081z9FOJ4ItisPku0JyOQT+mJIye8Q8qJFMluZutqUBlzauFrhbqgdzMXnPsVoBtVb0/icLqdfXDxEbKBOwlIBUJJomQNKT8Q2CIFi8OAK+RkpqDBFVPohTxJOhppeBbREOsO7eSRPLs+cM5FarbqGn1Tdk4mLH2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUI2SCtaNmhRMElaVnVGcGtsaFlFTUFzMmxYMTRlS1ZOWE0zT1YrUHB4eGNZ?=
 =?utf-8?B?WlBldHFZNTFHVzk4UmJTS1AyNHFQckNVSlk0SGZYbFVQVlRGbEF5S3A1MGIw?=
 =?utf-8?B?NndNOUR1U05zSVZGSTd5UTFVbnUrYXlpcmlQTmg5Qlh4NTN5WDQ1THBMckpV?=
 =?utf-8?B?TVpQZzQ0ck9wR0ZXVmsxMXh2OGdoYitocmlvREFCaE83L1dETDZ4VzdRS24r?=
 =?utf-8?B?WjV1MThUeml6SWhtL3ZHTDJrUEZYamZEOWdaQXlRZDVqS2xWcWh4TDIzV3lh?=
 =?utf-8?B?eTZxOXEzRnIwRjd3S0M3U2tvV3g2OUxMS0hMTE0rVkNxNWh5TzhiMy9VZ3Ix?=
 =?utf-8?B?Qi9zQmJZMkZsYWhZcDRJZmJGMDhLSThqTnpwMzdTSWZuWWwyMVJpbG9IUWJq?=
 =?utf-8?B?NEI0M2IrZlp2M2FZeXJIcWJxTEJiR3JPY3NHTEJwRTdvcFNuaXdKV2ZHMWdn?=
 =?utf-8?B?V0FKZGQwRXN0bWNXQ1ZFaFdGNXBhZDVEMlJhY2NUM1VxRlJTeVB5dHdQWTlv?=
 =?utf-8?B?ODdzSlhrUTNqVFd3S1UxUzN4QmJJL0tDRXNkcmNEaCtVUmhaTjN3ckZoV0RJ?=
 =?utf-8?B?eU1Sc1RpOU5GRXBIY2tGTGczN1F5V0EvSlE5QUNjV0N4YUNnVmtZblFUTElt?=
 =?utf-8?B?T0dvT1l6S1hlYWtmbmZtTUNqbVFlWUJocWt1TVNHbkowNitMNFUxbjJkQlVG?=
 =?utf-8?B?WGViOStjbXB2OHJ3Y2dZL2VldjZjK0FwdTIrMlJReGNiYU93SnEycG1YRURk?=
 =?utf-8?B?U2hGS25qUlF5NWY3KzF4clFFK0RrYlZza0tHV3cvblBhajBEamduNGw4Lzdv?=
 =?utf-8?B?VTMrZlRqcUVTY21FQlBYUVFodDZhdkE2M2YzczZWbUc0VWQzaHJqQS92dkVD?=
 =?utf-8?B?M3ovYnJCeWtDa2t3NFlwUkhzZEZHMjVJWkNKZUx0K0lxcDhjdjg1OTFrVjJh?=
 =?utf-8?B?S1B6Q3czVWhuUG1sQU5sa1g1ako2czdLZzY2eWVROXJ6cEVHTjloSnN5UnNi?=
 =?utf-8?B?SkltMWJHczJwaVNRSTd5blg5cEZsaUVhMUgrVnhCcnU3MXQzTzdscjQ3TUtJ?=
 =?utf-8?B?VU5hYXpGNjQvY3FpZ2RBZ2xFaG44MU55RU9CbEZmTTJVSEdJbVA1UExQcGx6?=
 =?utf-8?B?R0svU2l5L0hUMktIYTJvaHJpajdhanFjZ3J0eFRuQkpDcitwcGd6aTNmT0cy?=
 =?utf-8?B?a21ORVZrWldOZGpmSUdtNFRFNUF6ME4yK2NaaHQzN3dKOHl0RWFHbGZIUjM4?=
 =?utf-8?B?VlJpUGtLREtBWVk4OVBub1A3a0YzbDg2dUdCd2pDWGhTRWQ3Qm1FbmZBSTQw?=
 =?utf-8?B?Z1VGQXp6dDRBTFF2Q3E4eXVjNWtveXNRakNYNk01WElueXBmZDdPbForQ0Z0?=
 =?utf-8?B?M3gyVWdSMHpDbzlGcmQxY3lMSTZYZzI4ajJGOHdMZWVBT0M5RkxmdWVBN2hs?=
 =?utf-8?B?THAvOSsrR3RIaHhlUXAyMlhUYVVhbythK1Noalh3V0xGK0ZrUzV5d0Q0L0xC?=
 =?utf-8?B?SGRSelBwUTg3eU8zZC81dTFjUjB4ZnZ6Qko5M3dGb3lGK1hxV3VnelpkejFG?=
 =?utf-8?B?NkpYVmVzdzFKVGVKM3FWd3NORDJRQkxCUmZEV0xlK1NXS0dkd3RTSTJhamYw?=
 =?utf-8?B?WkxDVC9mUFRRMWlYSGVWR3BMN1VCSVcyK2lMcmVlTitYWVlhNGlYa0ZHbWpE?=
 =?utf-8?B?Skl2V2IvaDIwSm9hUnhrQ0RoL2ZrdEhUWVhheFFFZmFJa2N3eWR5SitWTHdE?=
 =?utf-8?B?Q0grQzFZQXEzaUM5bDJyWjNBZTMwLzl3TWF0WW9OQms2bVgrTlEyeGxSQk5R?=
 =?utf-8?B?UDZwMkhuNS9COUNjb1ZBWWgzM1VrZmhFc2pra1NoVWlyZmFQOW1ScHJOT1p0?=
 =?utf-8?B?MUhBS1FNYjJTUFptU09qRXJjc20rTDNmRHFZOGlHamIvTTZ4cHBqVXFhSG9h?=
 =?utf-8?B?Ri9UaTRubDRLR3VmRUVkK0FkZ0lpclNPK09MN2YvZnZQSGFMeklvSnFkWWpp?=
 =?utf-8?B?TmgvY2k0QkE5TEZXSWdFVy9WODN0VjdDMTMrTEFQSjd4ZElaelhiK0lPQmo2?=
 =?utf-8?B?WWZ4ekk5M2M5VFFEbm1GZnJFSjdQd0UrRExCdzcyejRXN1JkdEw5TXJwZzdK?=
 =?utf-8?Q?TlUsYdTmXLIBeQNoWEsoQBDGU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c323b2d7-6c10-4818-743b-08dc442a220c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 13:24:53.0240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iK2tmtxDCgdafSdmascNb3NXeuM3RALxCQW/0WWsoyDbLvK5tMuk7cXFYKJ1IrrtKobzi2riXcY30gWuImd4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBBbGV4IQ0KDQpSZWdh
cmRzLA0KSGF3a2luZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBE
ZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMTQs
IDIwMjQgMjE6MjMNClRvOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0K
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBQaWxsYWksIEF1cmFiaW5kbyA8QXVy
YWJpbmRvLlBpbGxhaUBhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBXYW5n
LCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IEJ5cGFzcyBkaXNwbGF5IHRhIGlmIGRpc3BsYXkgaHcgaXMgbm90IGF2
YWlsYWJsZQ0KDQpPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCA5OjE44oCvQU0gSGF3a2luZyBaaGFu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gRG8gbm90IGxvYWQvaW52b2tl
IGRpc3BsYXkgVEEgaWYgZGlzcGxheSBoYXJkd2FyZSBpcyBub3QgYXZhaWxhYmxlDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDE4ICsrKysr
KysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBpbmRleCA4NjczOTdm
ZTJlOWQuLmU3ZDdmZDJjYzMxZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYw0KPiBAQCAtMTgzMCw2ICsxODMwLDEwIEBAIHN0YXRpYyBpbnQgcHNwX2hkY3Bf
aW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCj4gICAgICAgICBpZiAoYW1kZ3B1
X3NyaW92X3ZmKHBzcC0+YWRldikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4g
KyAgICAgICAvKiBieXBhc3MgaGRjcCBpbml0aWFsaXphdGlvbiBpZiBkbXUgaXMgaGFydmVzdGVk
ICovDQo+ICsgICAgICAgaWYgKCFhbWRncHVfZGV2aWNlX2hhc19kaXNwbGF5X2hhcmR3YXJlKHBz
cC0+YWRldikpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICAgIGlm
ICghcHNwLT5oZGNwX2NvbnRleHQuY29udGV4dC5iaW5fZGVzYy5zaXplX2J5dGVzIHx8DQo+ICAg
ICAgICAgICAgICFwc3AtPmhkY3BfY29udGV4dC5jb250ZXh0LmJpbl9kZXNjLnN0YXJ0X2FkZHIp
IHsNCj4gICAgICAgICAgICAgICAgIGRldl9pbmZvKHBzcC0+YWRldi0+ZGV2LCAiSERDUDogb3B0
aW9uYWwgaGRjcCB0YSB1Y29kZQ0KPiBpcyBub3QgYXZhaWxhYmxlXG4iKTsgQEAgLTE4NjIsNiAr
MTg2Niw5IEBAIGludCBwc3BfaGRjcF9pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVp
bnQzMl90IHRhX2NtZF9pZCkNCj4gICAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRl
dikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gKyAgICAgICBpZiAoIXBzcC0+
aGRjcF9jb250ZXh0LmNvbnRleHQuaW5pdGlhbGl6ZWQpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gKw0KPiAgICAgICAgIHJldHVybiBwc3BfdGFfaW52b2tlKHBzcCwgdGFfY21kX2lk
LA0KPiAmcHNwLT5oZGNwX2NvbnRleHQuY29udGV4dCk7ICB9DQo+DQo+IEBAIC0xODk3LDYgKzE5
MDQsMTAgQEAgc3RhdGljIGludCBwc3BfZHRtX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0
ICpwc3ApDQo+ICAgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+DQo+ICsgICAgICAgLyogYnlwYXNzIGR0bSBpbml0aWFs
aXphdGlvbiBpZiBkbXUgaXMgaGFydmVzdGVkICovDQo+ICsgICAgICAgaWYgKCFhbWRncHVfZGV2
aWNlX2hhc19kaXNwbGF5X2hhcmR3YXJlKHBzcC0+YWRldikpDQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4gKw0KPiAgICAgICAgIGlmICghcHNwLT5kdG1fY29udGV4dC5jb250ZXh0LmJp
bl9kZXNjLnNpemVfYnl0ZXMgfHwNCj4gICAgICAgICAgICAgIXBzcC0+ZHRtX2NvbnRleHQuY29u
dGV4dC5iaW5fZGVzYy5zdGFydF9hZGRyKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfaW5mbyhw
c3AtPmFkZXYtPmRldiwgIkRUTTogb3B0aW9uYWwgZHRtIHRhIHVjb2RlDQo+IGlzIG5vdCBhdmFp
bGFibGVcbiIpOyBAQCAtMTkyOSw2ICsxOTQwLDkgQEAgaW50IHBzcF9kdG1faW52b2tlKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpDQo+ICAgICAgICAgaWYgKGFt
ZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
DQo+ICsgICAgICAgaWYgKCFwc3AtPmR0bV9jb250ZXh0LmNvbnRleHQuaW5pdGlhbGl6ZWQpDQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICAgIHJldHVybiBwc3BfdGFf
aW52b2tlKHBzcCwgdGFfY21kX2lkLA0KPiAmcHNwLT5kdG1fY29udGV4dC5jb250ZXh0KTsgIH0N
Cj4NCj4gQEAgLTIwNjMsNiArMjA3NywxMCBAQCBzdGF0aWMgaW50IHBzcF9zZWN1cmVkaXNwbGF5
X2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQo+ICAgICAgICAgaWYgKGFtZGdw
dV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+DQo+
ICsgICAgICAgLyogYnlwYXNzIHNlY3VyZWRpc3BsYXkgaW5pdGlhbGl6YXRpb24gaWYgZG11IGlz
IGhhcnZlc3RlZCAqLw0KPiArICAgICAgIGlmICghYW1kZ3B1X2RldmljZV9oYXNfZGlzcGxheV9o
YXJkd2FyZShwc3AtPmFkZXYpKQ0KPiArICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQo+
ICAgICAgICAgaWYgKCFwc3AtPnNlY3VyZWRpc3BsYXlfY29udGV4dC5jb250ZXh0LmJpbl9kZXNj
LnNpemVfYnl0ZXMgfHwNCj4gICAgICAgICAgICAgIXBzcC0+c2VjdXJlZGlzcGxheV9jb250ZXh0
LmNvbnRleHQuYmluX2Rlc2Muc3RhcnRfYWRkcikgew0KPiAgICAgICAgICAgICAgICAgZGV2X2lu
Zm8ocHNwLT5hZGV2LT5kZXYsICJTRUNVUkVESVNQTEFZOiBzZWN1cmVkaXNwbGF5DQo+IHRhIHVj
b2RlIGlzIG5vdCBhdmFpbGFibGVcbiIpOw0KPiAtLQ0KPiAyLjE3LjENCj4NCg==
