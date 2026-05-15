Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D0CD4851
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 21:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A5D10E44A;
	Fri, 15 May 2026 21:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUVJcv/J";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B8310E44A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 21:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUtSZtwxOL7YXMdCh+4FmA2eINY9q2vSIcBEusGGmaFIMIFar4fQEwGg9i2+niuevQCNTu7Ov1Q1GK4MIGGSCblFGSntPDq5NMQAHGH2Hf3XydCNJlMMJIOzZyHpOh+lIGcZRskYyVSwCfXEJy9X8zXbAm9s0Y2BpTrDv6HpEMmlZVlfR+HiDvfzp2sokTHR2JmAbglMekCc1IqPdaH2gzZHk8YI+kcGQBZQGdkWxjS7IbiwExuIMTZ+GEv5kYMOXhHpMdMKZTftMYw8hNKqG9tUmAh/aEBsz0fDG9x763NrtFpeJBW6w5klvdlaM0lG3Ob45QvUbzWPOTNZFNhxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPzAxf4mlFYNLSqllpSDNhbAsEl8WN1hFR5l3XWJS6s=;
 b=oVDoEOjNRABIPd1WqALx+e2x0WcKpkk2TfLRyxUM+NWXKaM2D5gUQxnDujLo4byDSEb86rD89qesZ8IsbyEqCp+YtjkzsRBxUh78f9R9xEaRRZufaXLRiSdVqe+MnbnQmYwUSgIfyFLLUnFiivx4+vhxVGsEuvyXJXSN4yMo6tyZvCNFw/84RBbg8sSNsGD6olKKGx96ti0aCNIAdFTkbeevYS0hHDlGnisgjT4iXqjrFga7ZBAFwhiuwyS3U9IfSmaqfoeKs906zkd7z3cLJsd9k4BUHcllzwJNHQIYZTlgrHyDLrSQfmwHlCjdO5OTYWElH/gd6A0zc8XQpZEjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPzAxf4mlFYNLSqllpSDNhbAsEl8WN1hFR5l3XWJS6s=;
 b=DUVJcv/JvnfSvsW6yF1RplIClwpQwlx8ATKTQEstRmo6Uf38Sk9FIDMnuzXQm2EX2554pMmzonf0CbcShDhw1PQt+PbvrR9kZa7uKZvFi/7AM5DcroZIt+kmpz35LIaZ40Mh0JNwSGMnXLe30Wr9LWBkRiUBymaSIgQjm1r86Tw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 21:02:12 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 21:02:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/3] drm/amd/pm: Reject negative values in
 thermal_throttling_logging
Thread-Topic: [PATCH 2/3] drm/amd/pm: Reject negative values in
 thermal_throttling_logging
Thread-Index: AQHc2N580rNCnxl/r02k8CObe26qSbYPqlrg
Date: Fri, 15 May 2026 21:02:12 +0000
Message-ID: <BL1PR12MB5144381EBD50C66BA864B652F7042@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260430201803.90458-1-vitaly.prosyak@amd.com>
 <20260430201803.90458-2-vitaly.prosyak@amd.com>
In-Reply-To: <20260430201803.90458-2-vitaly.prosyak@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-15T21:01:53.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB8791:EE_
x-ms-office365-filtering-correlation-id: e213e7a6-938e-4aec-4c04-08deb2c53c88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|4143699003|11063799003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: EPGCVGKOrONhOP+28c8NrshNldbM/TNl17O4ZF+XqbaCkQzKiq0t867u6oGw3sQD9fbO2B80ZRKtzviznWPk4kIO5GGHsSHJl2103hOXjtj6EVb8zpLFc08u/5EpZGS/DE2GoV3jQqqlMeNO8xX0jnRz9AUHSlBr9R4W/l3MFNlDks2nETMv/yqvvTLzCWpZuUSuPC4+960liZT5G1zQ6JwgEIbvquzlqrShHY0obDU2RzOloFI2OswRpY0ivLp/0SoNkBcDbnYgPtmipuBUBBXHb2FXKA7V+kEfDqEo0KbXv+WQWj49xamZOuu3KJl6NZrv/g6Xf4PWW5fGR3GA76A3jHJlXipla6IrJuVxxCmWmW9c4ImOgj95gKeCzSJ3a56p5o90BVV/KQ0wpYCeN6a0V8dGccOP52gHoBnCjQfkE8d6W41Ezxea0bFdovMjLRsM63PWY6hauGvugxkwVm2jbWrvXl8Tcn2RBhUjGJ+Z3pRUIG3m7jGqLI18nrpfm3JWlzdqlJdv1yKPtjiB6BTtmj7oxKGZOy0xMMibgQ+Tog4RZqjnbMOYpFwgomLWtSat/U1uGjIb/HouyaTCDAR9kO0lm/OG9TEm0LkO0TKTSMA2fgGQk8FkTtXx/38hCFoXWYQ6cKlCXm7kzS5vuqCzIRkaVYIxui8yhZiF2R+4vakbU8XMlXodbq79x5c//bGSXCibYVhA7yMY6gFIHPQprwgY6ucJ+MFIrMAVM240+wJNRwUzE5E/752kkMqb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmRSUjBlRkdPQmxLSDZFSmN2d0xIMGpPYlFrUTlpaEsvam9IV3AwL1N3bmpk?=
 =?utf-8?B?M3JyNkg0OUdTb2tkMTFHNVdpTVVoZW8wSDdrVDdZM3hpSWJaTU5kZis5TGxh?=
 =?utf-8?B?aVZvOUduUjQ0ai9CQkFKU0N3cDRxSDFKYTluVWczZDV6L25WU1pZcWtBaVcv?=
 =?utf-8?B?WWRGZ1hlVG91YWlSRHJZbFkvMHdJSWJaWjI3eXlub0VpWDRjRlFiQkVMR3kv?=
 =?utf-8?B?RG5FcVQxdE9GUVpjMUd0M1VDMHlCQmM5bnBNK1pzMDRJNy8zYVE0ME9GUWJk?=
 =?utf-8?B?TTJIbzdpZEVFTERtSTJKaDJMZEpkNHo4ZUF4Y1lvdWlqY0pyT29xWnh2Q1Na?=
 =?utf-8?B?aUZWNUdWem1DVnNCZXIwMWFpcWhSMXNHdGd2MWxLczJQSGRsWTNGWmFZMGEw?=
 =?utf-8?B?ZGVtNXFKMHVINlRmN3pPWENxQk5VcjJpTEtKWnVlbWpocjJpMzJybEdDb0g0?=
 =?utf-8?B?a0ZVUy9VREZ4N0plVUtzRW1FaGpvWnZ6b2kyRTR2WThqS2MwNzhqdklySlJB?=
 =?utf-8?B?ZFFpT3E1MXYwYm9qSkU1RmM0ajkxUXIwMy9YNFBGcHdtUi9kamZKa1pxUzg4?=
 =?utf-8?B?Z3lybEdZSDFYUHd6SnRoMUZsQWRMc1R0d2JPMVRuUTFEWjRWZmQ5Mm8vMC9R?=
 =?utf-8?B?OVBoWlptci9mL0xZTzE5Mng1VXhWVEl2QXIrS05HTHFMbmx5WnV2UEx4eXQ2?=
 =?utf-8?B?SW1XRGV0WTU4RVdQTnJyeU9ROFZ4RWY3TlB1T2huZVJDOFdHd2lDMVNZZkRZ?=
 =?utf-8?B?UUNNb3VkeUsxaVhRaTlLeEZGVFFGSmsyV1oreEhhMysrOG96MitCYmV6S3Zi?=
 =?utf-8?B?N0lRM1Q1U3lRZEQ5MFZjei9LSGYyTDJXYnFhVjNUT25qQ0ljTU9wSmU4cVp4?=
 =?utf-8?B?Umd2N0dkRnRTK3htdXd1MDlLYnVsSGVZcUFVSGVLdlNRbzQyYTgrVVNQdkQz?=
 =?utf-8?B?QkNuc0E0Y2hmKzFXTHpRWXQyd0NXN2llK0diRzZlakJqS2lvSkNGdmZsSS9K?=
 =?utf-8?B?Qmw3VjZKUWZsdGRQaWR1cWhJdEMvYWJSSkVMUEJHWUl1MTczaHhJZlNwMnBr?=
 =?utf-8?B?VHlnVFRmYzBvSnF1ZitCNGF3ZWFOdWs5U1BkT0w0ZWFWbnFSN01xN0ZUR01p?=
 =?utf-8?B?SmJEM2xGY2lUdUNkZEJQZHNBRGpzeHFjaWowN2pDVkYrSkxQZStRb3B0Qncx?=
 =?utf-8?B?UG5vNXBFUjFIUmRhRDNQdCtmdTNoTU53ay84a0VHNGdMd0RVT2dXc3czbWx4?=
 =?utf-8?B?RVk2b3JaVExHYVZLNUZLRlhnWEZhL25aMnpUeGxRSnBBak1tRmsvN1MvdjBF?=
 =?utf-8?B?S3c2M1RJYm1UMXgzcWc0NTNRNDQyeTN1bDcyeENYVWZIMnQrUnVLWkFidktw?=
 =?utf-8?B?RUVtSnpjUFZmYmw5dEZueWpPajQrWkt1QjZLWURGZG51YlBDKzhPUVFMbkpC?=
 =?utf-8?B?eXI4SUNYTTlGSSsvTE9MK3FLVGRseUVmUFhaWXhIeTg5akR6ZWdSOVJvOGdl?=
 =?utf-8?B?Q1NrT21UUFFHblZaS0JmcmhvdFpyamFuQUkyMlR3NkVZV2dUbm1HazhSdTA4?=
 =?utf-8?B?VEpycFczOU1haFZnVG02b3djei9WWDhYd3RVTXBSUkIzYllVK01RaERjRkV0?=
 =?utf-8?B?MHpqam5pbzZhZXpIV3g0VTY2Q3hwZzRYb093dXptd1d3ZnZTelZRL1hCM1p5?=
 =?utf-8?B?Q0RlejRCdk9xQ25uVys5WDYyY2x0a1RyVjROeGhFRm11S0JlT0x0WnltQzV3?=
 =?utf-8?B?VFpWWmZ6bXR1N241Rnl2Zk1NbDJFYmhMNFdSV3ZoUXRwNDRHdHkwTHhRYWlV?=
 =?utf-8?B?SGVhUW54bEhGaXhaY082TXVjblBNbEhxaXdDMjcwTUFuNmd4aFNKejdaMDhi?=
 =?utf-8?B?TzRUYi9jTTVPMGNSSlBoTlg4OTVjK2h4TFNuUTRaL0wycnAzRi9ydFBZUCtQ?=
 =?utf-8?B?TmlSWlZtRVlFSXB2SldwWW45aXM4U0I2RC8xYWJDNzllYnkwZVlSU0RGWDU0?=
 =?utf-8?B?eXBIeTFDaFBhd1dsbjVZSVZiR0dwTVZDVFJhL0xCZDU1dnRPWXpyZjliM0My?=
 =?utf-8?B?V0IrWWpNWUc4SFdHcS81Z3VsMlp0ZTVENFFoWSthaDdoaHo5bHJpd1EwWmd4?=
 =?utf-8?B?Q0Fxc2t1REJrMi8wWGNWc0g5UXFEemQ2TlQ2aVJjaVRqRGxSRFZiOGJJSUFo?=
 =?utf-8?B?RGEzSmpDbTNjcUh0cGRDVUlUUWFoQTdJUng0c0NQRTdOaHg4WFJJaDMvUW05?=
 =?utf-8?B?VTVuYzV4Rkt5eVNqMzNhYWJhS1dGekwzNkNVS0l3SWluKzYveTdCajF4eDhQ?=
 =?utf-8?Q?y6rJn5VczNvOtodImT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e213e7a6-938e-4aec-4c04-08deb2c53c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 21:02:12.6771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWNZ+ikV6BkVo9LYGbTz7msmj9gA58evng+f7blLCJgNfDvNcodPY8wq7XawxikxW/ZpFmRggPCF+g9WetPIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IHZp
dGFseS5wcm9zeWFrQGFtZC5jb20NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDMwLCAyMDI2IDQ6
MTQgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBQcm9zeWFr
LCBWaXRhbHkgPFZpdGFseS5Qcm9zeWFrQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCAyLzNdIGRybS9hbWQvcG06IFJlamVjdCBuZWdhdGl2ZSB2
YWx1ZXMgaW4NCj4gdGhlcm1hbF90aHJvdHRsaW5nX2xvZ2dpbmcNCj4NCj4gRnJvbTogVml0YWx5
IFByb3N5YWsgPHZpdGFseS5wcm9zeWFrQGFtZC5jb20+DQo+DQo+IERpc2NvdmVyeTogRnV6emlu
ZyBmb3Igc2VjdXJlIHN1cHBseSBjaGFpbiByZXF1aXJlbWVudHMNCj4gVG9vbDogYW1kX2Z1enpp
bmdfc3lzZnMgKElHVCB0ZXN0KQ0KPg0KPiBUaGUgdGhlcm1hbF90aHJvdHRsaW5nX2xvZ2dpbmcg
c3lzZnMgc3RvcmUgZnVuY3Rpb24gYWNjZXB0cyBuZWdhdGl2ZSB2YWx1ZXMNCj4gbGlrZSAtMSBh
bmQgLTk5OTk5OTksIHdoaWNoIGFyZSBub25zZW5zaWNhbCBmb3IgYSBsb2dnaW5nIGludGVydmFs
Lg0KPg0KPiBDdXJyZW50IGJlaGF2aW9yOg0KPiAtIFZhbHVlcyA8PSAwIGRpc2FibGUgbG9nZ2lu
ZyAoaW50ZW5kZWQgZm9yIDAgb25seSkNCj4gLSBWYWx1ZXMgMS0zNjAwIGVuYWJsZSBsb2dnaW5n
IHdpdGggaW50ZXJ2YWwgaW4gc2Vjb25kcw0KPiAtIE5lZ2F0aXZlIHZhbHVlcyBhcmUgYWNjZXB0
ZWQgYW5kIHRyZWF0ZWQgYXMgZGlzYWJsZQ0KPg0KPiBJc3N1ZToNCj4gTGFyZ2UgbmVnYXRpdmUg
dmFsdWVzIGxpa2UgLTk5OTk5OTkgbWFrZSBubyBzZW1hbnRpYyBzZW5zZSBhbmQgY291bGQNCj4g
aW5kaWNhdGUgaW5wdXQgdmFsaWRhdGlvbiBieXBhc3MgYXR0ZW1wdHMuIFdoaWxlIHRoZXkgZnVu
Y3Rpb25hbGx5IGRpc2FibGUNCj4gbG9nZ2luZyAoc2FtZSBhcyAwKSwgYWNjZXB0aW5nIGFyYml0
cmFyeSBuZWdhdGl2ZSB2YWx1ZXMgc3VnZ2VzdHMgaW5hZGVxdWF0ZQ0KPiBpbnB1dCB2YWxpZGF0
aW9uLg0KPg0KPiBGaXg6DQo+IEFkZCBleHBsaWNpdCBjaGVjayB0byByZWplY3QgdmFsdWVzIDwg
MCBiZWZvcmUgcHJvY2Vzc2luZy4NCj4gT25seSBhY2NlcHQ6DQo+IC0gMDogZGlzYWJsZSB0aGVy
bWFsIHRocm90dGxpbmcgbG9nZ2luZw0KPiAtIDEtMzYwMDogZW5hYmxlIHdpdGggaW50ZXJ2YWwg
aW4gc2Vjb25kcyAoZXhpc3RpbmcgdmFsaWRhdGlvbikNCj4NCj4gVGhpcyBpbXByb3ZlcyBpbnB1
dCB2YWxpZGF0aW9uIGFuZCBtYWtlcyB0aGUgaW50ZXJmYWNlIG1vcmUgcm9idXN0Lg0KPg0KPiBU
ZXN0IFJlc3VsdHMgQmVmb3JlIEZpeDoNCj4gICB0aGVybWFsX3Rocm90dGxpbmdfbG9nZ2luZzog
NiBmYWlsdXJlcw0KPiAgIC0gQWNjZXB0ZWQ6IDAsIC0xLCAtOTk5OTk5OSwgLTIxNDc0ODM2NDgs
IGVtcHR5IHN0cmluZywgMDc3Nw0KPg0KPiBUZXN0IFJlc3VsdHMgQWZ0ZXIgRml4Og0KPiAgIHRo
ZXJtYWxfdGhyb3R0bGluZ19sb2dnaW5nOiAzIGZhaWx1cmVzDQo+ICAgLSBSZWplY3RlZDogLTEs
IC05OTk5OTk5LCAtMjE0NzQ4MzY0OCAobm93IHJldHVybiAtRUlOVkFMKQ0KPiAgIC0gUmVtYWlu
aW5nOiBlbXB0eSBzdHJpbmcgKFZGUyBiZWhhdmlvciksIDAgKHZhbGlkKSwgMDc3NyAob2N0YWwp
DQo+DQo+IFRlc3RlZDogYW1kX2Z1enppbmdfc3lzZnMgSUdUIHRlc3QNCj4NCj4gQ2M6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IEplc3NlIFpoYW5nIDxqZXNzZS56
aGFuZ0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaXRhbHkgUHJvc3lhayA8dml0YWx5LnBy
b3N5YWtAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1
X3BtLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+IGluZGV4IDY2ZDg0NjZiMTY2YS4uMWVm
NzQxZjRjNDNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9w
bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gQEAgLTE2
MzQsNiArMTYzNCwxMCBAQCBzdGF0aWMgc3NpemVfdA0KPiBhbWRncHVfc2V0X3RoZXJtYWxfdGhy
b3R0bGluZ19sb2dnaW5nKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gICAgICAgaWYgKHJldCkNCj4g
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPg0KPiArICAgICAvKiBSZWplY3QgbmVnYXRpdmUg
dmFsdWVzIC0gb25seSAwIChkaXNhYmxlKSBvciAxLTM2MDAgKHNlY29uZHMpIGFyZQ0KPiB2YWxp
ZCAqLw0KPiArICAgICBpZiAodGhyb3R0bGluZ19sb2dnaW5nX2ludGVydmFsIDwgMCkNCj4gKyAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAgICAgICBpZiAodGhyb3R0bGluZ19s
b2dnaW5nX2ludGVydmFsID4gMzYwMCkNCj4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4NCj4gLS0NCj4gMi40My4wDQoNCg==
