Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2887C5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 16:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E6C10E1BC;
	Mon,  9 Jan 2023 16:19:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E755B10E19C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 16:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9g1I/119/hy6+as1vNNOOtff5anDp4oZEHWN/r/dNCaImT+Jrv+4dMgTLVMo7jMwM/+SkVxrKla2XeCkXu7BCuQ46pcDtC3F2R4JwFxogIl7t2vUAwQqaiz0GZpRv3QCeEJFNUmN6Pj+9LClTY9+bZYDpSi66g0dGgQrY1wti0ix3hFzThfJ3qjHu+9oXK4iWH7BdQUAkSpNjJ7dSYIuO0xk89DFUp9FWnjI8JEoZ9ET/9Az/7r/fcE4yckkQ0HaCAtIR4FDFZk4QVzBEMLt6pxVc7MZB4Vd7OxUfovO3f9m8wl3bMT+kos0vXNaEtZVJO3D15bVBal8PWKjxj16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ6Dao0o5Xez2aBAx72jpozsc4BHqZ2omT5T7qpMOQQ=;
 b=e6LuwL4S4TCWNo3jqG3CVQEY3OUcw/lST9lVm33/3vMHj3aySuj3D6t0r2RmueWkCLFJnNpfaaa92w3zEDEHLo5SPzZzSd4mL6czJcwHp0T+nGP/OHsN6vpGNjecmQdWu+n1mf8oSu/UGN1TftGTjPzlZ9y5OSNupxbBk+hqHCYxM2z6AQ7SZb4IfBnSkdDyZW52aPnElyu3tK5Bjxp/SAkqxFgbW95yTkRaYL4022OSOgsa5EKhycOu7HF0v0pGYWnjMHpSl/P1C4pFNAZD3aocsG+wZcRCzLSbL5Sxc5BFWMUtiZEnmTy/3lbxjzoZDa80/JuxTQsFIky2l1kbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ6Dao0o5Xez2aBAx72jpozsc4BHqZ2omT5T7qpMOQQ=;
 b=LcbwxdZeZ8Rlh0AGEbBhJ9DACN75/pH8F+EoHDAVq+AZX8mdg0IKDva0kuJeu/I0is9amEeVeQFVqj2YgUwWRDIJEOFSDgmLQ0LIMj7BmPuqgCRxqw+uw4TRUupPEpMhLAel0Ylw4iDNB+7TF7lMRkW696deM+o+MFVy69kEBEs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:19:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 16:19:48 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Fix an uninitialized variable
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Fix an uninitialized variable
Thread-Index: AQHZJEMqtJaF3cRJ5EGwE8tvvhaBlq6WP5MAgAAEJVA=
Date: Mon, 9 Jan 2023 16:19:48 +0000
Message-ID: <MN0PR12MB61014E255124318925EBBC71E2FE9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230109155735.1442464-1-srinivasan.shanmugam@amd.com>
 <CADnq5_MR4fdu783bH=WumY3PO1AGEeVp7fKVgeLMjDUQQPgCUQ@mail.gmail.com>
In-Reply-To: <CADnq5_MR4fdu783bH=WumY3PO1AGEeVp7fKVgeLMjDUQQPgCUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-09T16:19:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d4a2b22a-101e-4f78-97ec-f60d7a787b73;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-09T16:19:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3f2e1d84-7026-404b-b03d-12722f678a31
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CO6PR12MB5460:EE_
x-ms-office365-filtering-correlation-id: 18bc0baf-2439-4e4c-5019-08daf25d5449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfDMB92KlZDiFpcbS47F3VRGTzlHZs+nH/PFwtf2z1QS25LxT9XoQzMboHnsgOrdGJ7dvQiaYAwNUZ9JAsQQDp7yjdUxIWGgRTRA6Oc4LhNAh9ZTxfj0O6aid/5XROJHArJYpVJptmTYhNSPG5H0lbAUOTV+v/fl/PXyadq80B360qtISEMqMpDR1CdAkz2b6bjfqs7aQVRJpU8lLF4sc9v/cA3GPDdPprqay6x0j7qoncX9B1dNr1UB7HJAH84eDCaW3Jv08T5vTPC2+4OI+BbzbiIipyvtoFYiN2Ulb1lOO6VicGrw27TgoJr1eEhY1/XgYrQmwBm+26LhPT68ndIpagkekbE/GtIXX82e3WJktRVmBDklBcBxR65YPgDZg/9Jykt1m3novb43loLqJomkKx69K03CmrG5/kRNo4JCboEIxD2aR2idv95zmLcU5xn8GYwPaKMoZGEqaF5GtlJ6R/LnNcR0Nteme1ttU4/UHqf0tFE7UVV/e2lQRtqLWmrigG7EtnGrOcV+fYLGuHeQeGr77HH25luyEKXL7hT+GreLcJ63zRUS9eMiYNW0cioOskER2Vlgx7hfrfL1KQMwJJhhsrWz2ZNc+gW7kYNLXZYHWkm1i1wYw3g95wvIhCiwGXIy5RltJ4fl6tuYTGULkSOvINd3479NS0Bg9QpEkfDa+go26ajftGDVuK61/mXgHcPHKWPsMY370afz1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(6636002)(53546011)(186003)(122000001)(8936002)(26005)(52536014)(6506007)(110136005)(54906003)(9686003)(55016003)(66946007)(5660300002)(33656002)(7696005)(66446008)(66476007)(64756008)(66556008)(4326008)(316002)(86362001)(38070700005)(71200400001)(76116006)(38100700002)(478600001)(41300700001)(8676002)(2906002)(66574015)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU9jMlAzZ0JkNUZtTkVmV0VlTDV3MDlyTnMvUTd4ckoyT3F1MnNnTmljR1pu?=
 =?utf-8?B?clQxcEorc2NtUDVubTRMUk02RjZ3QmFsUFA5TUgxZXhRdlp6OTJWYUhpNDJH?=
 =?utf-8?B?US9BUld6MGs5Z3dIUSt5ZTZEb3hJRHh4U2U0emNDUjRueTlPQTkzWGRwSmt1?=
 =?utf-8?B?UUJJN1pLNno4ZHA5bEtVWCt1VUdhTUVldE9XejJDUHJxWE44UnVreDAxZ2p2?=
 =?utf-8?B?cmpBMlN0azFnS3BNMlIzblNiT05YTXFTWERvVlZrMnVFUTFoQkIxOGJxV3Yw?=
 =?utf-8?B?WUYzcURvVlNzMlZZZjBtMVpoZ3l4NnN0MVdpU0NISDZ1a2xZaTM5ZVVwRjVs?=
 =?utf-8?B?Zk1sSVoyekl2aG9TN0FZbHVCRExtVmNRenFQRUp0Rlo2cmlQeWZUMEVBUm4r?=
 =?utf-8?B?Yys5RG9zUlg1T1YzbVVKTm1sUFlXVGpnVEhmZXVTc0xXaEZGZnFYWHJWN0JU?=
 =?utf-8?B?MXY2dnZGaDFqdTNQUkx1L3QyRTd4Q2t5QWVzc3BvVDNRa1RWV0VTNGsyS3pF?=
 =?utf-8?B?S1VTS2Jyc0h1Y1dTRlE5UDFyN0w0Ym5HeUUrZG9xb1JaL1lHc3VCWmJQcXp4?=
 =?utf-8?B?cDJnbEg1dktESklNTmRHQmlVb3hKMlNBdmpkaFVtdWJjOCtUTWxkbnJkbjU3?=
 =?utf-8?B?TzNtOXNmcEpJekxrRXVpcVhjQ3JTT2s2aXpHTmtpZWVsczE2ZVZia3QvSkow?=
 =?utf-8?B?akxKZUVhR3AyRnArK1RRdWdRcGw2Um96UE5tRFVnOC9CelN6ZUVYNVBJVHhn?=
 =?utf-8?B?dVQ4Ny81bGVCVmd2YkhMbnVEVzdBZ0NmN1BrNkRCeG83c3U3ZVhUaE1vWGM0?=
 =?utf-8?B?Y0FDd205dXFqTEpxcXUxWnF3LzZaOGlDT2dEQi9ONUp6eUNhRmJaSE0wN2NC?=
 =?utf-8?B?eXBVaTBnVy9iemk2aTg0SHJTU1ovTElVNCt2WHR0SFphaTdGRjZUTHlZMVA3?=
 =?utf-8?B?dFZUSWJydkFscHZrN3dzMWFER2VKV05FU3pOVFR1R0kxWXRTQ2ZEdWpGUVc4?=
 =?utf-8?B?Q0JjNHpjdEJTeW94cjZWcFFGZnJGOXFPTVFsQURidEdZUHJ0TTA3WG9jQ01J?=
 =?utf-8?B?SUpHeS9GbktZVm5tUVNwSFNaVmtrOTBQRG5MYkNRa2FLVmtTZ0hNQU1CNXBu?=
 =?utf-8?B?ckp5ZTd5NDNIYkVFRnlUdWxqanBmaW9QdTRjRlpCQVVMdG9oNkZQc2FzK2tL?=
 =?utf-8?B?RDg1bXdyUnVJZzNHVi9qNHcrQ01pWG53K1RLQXBBUUFzeHdrWWtUeFVjZUYz?=
 =?utf-8?B?T3ladWxhMHdFa1ZnTGwrbE9GaXE3NjJ1WXczZTdEejRrNzFLMXRDY2cwNW1H?=
 =?utf-8?B?Q0twb3M3bUhlWmhBVmhncHUrUEZMTWpkcUduWk5LM2ZlOTJaTFhHODJHZ0hn?=
 =?utf-8?B?QjI1V040aUJoRlFBcWtNY0dKWWtPbWl0cnZvQ0hJekVrM1RHWFl3Y1E0SnZG?=
 =?utf-8?B?UGVGc3IzM3VDcGRtSm95VzNFeVhlWklYdE94L0NkanlUbWVvT09YcFVpMkts?=
 =?utf-8?B?eUx4ZWVNSG41U0lGaElxRWxIZU9GL3pCc21jRDdZSERKTGZqZXNRaVpWQXZh?=
 =?utf-8?B?Wmk0VDNLMjVDdjJYSlF2bTdIbjRZUk8vV254d2RkenVaSTFiek9xdWhFcWQy?=
 =?utf-8?B?T2lDbmc3dVNpYUdibGl5TTYrOWVtOHM3MTFNQ1dxakRZdVRRTm5xTWRSU3FQ?=
 =?utf-8?B?UUE2RWdHb1RKb2tEamRxMDUxRWIwUkpycFVmalg5TCtCT1d4NGxjSk5KejNl?=
 =?utf-8?B?N0lFZmFoWDNLNTJ0MVdnVVZ4UE14cGY5RkdSS1l4M1ZEVnlURlZYS0M3b0h6?=
 =?utf-8?B?ZEtUM3AvWWg3WU5JRXkxb2l5bVJCdDBQaUt0K29uQlBXQTcwZVpEcC9udzVD?=
 =?utf-8?B?MDJHblRwbG9QTGJxd05QeG81VFRVbGR3SEZHeHhGZG9IeXBOMGh6MktiVG1H?=
 =?utf-8?B?UzhpYXkvbzhOMXM5c0l1SE1wSFFDa0V6NXVTRnByQTZJaGVnWmYvSHRrdzl4?=
 =?utf-8?B?c1A4UVcvWFZIdG45TUd3Z2hDOVQxZHA2UXJ2Tis5aDkreFl5R09DZkpQbzFi?=
 =?utf-8?B?b2ViUDI1Y0MwaXVHOENScUhLYzdTVUdOMmpsVFNESkVyVXdwVmRXakx0b2RL?=
 =?utf-8?Q?2Qic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bc0baf-2439-4e4c-5019-08daf25d5449
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 16:19:48.5848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cf4xaCrAz97OrDKLlQZzRiu3lqXh6ifkgDeugronF2FtKF84rVoTtp9HAIwxwWeE+RungzhQ81CSbbR7NUZ9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFy
eSA5LCAyMDIzIDEwOjA0DQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+DQo+IENjOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5k
QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpbW9uY2llbGxvLA0KPiBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZC9h
bWRncHU6IEZpeCBhbiB1bmluaXRpYWxpemVkIHZhcmlhYmxlDQo+IA0KPiBPbiBNb24sIEphbiA5
LCAyMDIzIGF0IDEwOjU4IEFNIFNyaW5pdmFzYW4gU2hhbm11Z2FtDQo+IDxzcmluaXZhc2FuLnNo
YW5tdWdhbUBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+ICAgQ0MgICAgICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5vDQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3NkbWEuYzoyMTc6NzE6IGVycm9yOiB2YXJpYWJsZSAnaScgaXMNCj4gdW5pbml0
aWFsaXplZCB3aGVuIHVzZWQgaGVyZSBbLVdlcnJvciwtV3VuaW5pdGlhbGl6ZWRdDQo+ID4gICAg
ICAgICAgICAgICAgIHNucHJpbnRmKGZ3X25hbWUsIHNpemVvZihmd19uYW1lKSwgImFtZGdwdS8l
cyVkLmJpbiIsDQo+IHVjb2RlX3ByZWZpeCwgaSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXg0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmM6MjA3
OjE2OiBub3RlOiBpbml0aWFsaXplIHRoZQ0KPiB2YXJpYWJsZSAnaScgdG8gc2lsZW5jZSB0aGlz
IHdhcm5pbmcNCj4gPiAgICAgICAgIGludCBlcnIgPSAwLCBpOw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBeDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICA9IDANCj4gPg0KPiA+IEFzIHN1
Z2dlc3RlZCBieSBDaHJpc3RpYW4sIGJ1Z2d5DQo+ID4gInNucHJpbnRmKGZ3X25hbWUsIHNpemVv
Zihmd19uYW1lKSwgImFtZGdwdS8lcyVkLmJpbiIsIHVjb2RlX3ByZWZpeCwNCj4gaSk7Ig0KPiA+
IHNob3VsZG4ndCBiZSAiaSIgaW4gdGhlIGZpcnN0IHBsYWNlLCBidXQgcmF0aGVyIHVzaW5nICJp
bnN0YW5jZSIsDQo+ID4gYmVjYXVzZSBmb3IgaW5zdGFuY2UgZ3JlYXRlciB0aGFuIDAsIHdlIHdh
bnQgdG8gaGF2ZSBkaWZmZXJlbnQNCj4gPiBzZG1hIGZpcm13YXJlIGZvciBkaWZmZXJlbnQgaW5z
dGFuY2Ugd2UgYWRkIHRoZSBpbnN0YW5jZSBudW1iZXIuDQo+ID4NCj4gPiBSZW1vdmUgc2V0dGlu
ZyBlcnIgdG8gMCBhcyB3ZWxsLiBUaGlzIGlzIGNvbnNpZGVyZWQgdmVyeSBiYWQgY29kaW5nIHN0
eWxlLg0KPiA+DQo+ID4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4NCj4gPiBDYzogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5j
b20+DQo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVn
YW1AYW1kLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGZpeCENCg0KUmV2aWV3ZWQtYnk6IE1h
cmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KDQo+IA0KPiA+IENo
YW5nZS1JZDogSTJmMTE4MGFmNGYzN2JmMWVmZDRkNDdlN2JmNjQ0MjViMGIzODA5ZmINCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NkbWEuYyB8IDQgKyst
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9z
ZG1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5jDQo+ID4g
aW5kZXggMGUxZTI1MjFmZTI1YS4uZTliNzg3MzliOWZmNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NkbWEuYw0KPiA+IEBAIC0yMDQsNyArMjA0LDcgQEAg
aW50IGFtZGdwdV9zZG1hX2luaXRfbWljcm9jb2RlKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Zpcm13YXJlX2luZm8gKmlu
Zm8gPSBOVUxMOw0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IGNvbW1vbl9maXJtd2FyZV9oZWFk
ZXIgKmhlYWRlciA9IE5VTEw7DQo+ID4gLSAgICAgICBpbnQgZXJyID0gMCwgaTsNCj4gPiArICAg
ICAgIGludCBlcnIsIGk7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3Qgc2RtYV9maXJtd2FyZV9o
ZWFkZXJfdjJfMCAqc2RtYV9oZHI7DQo+ID4gICAgICAgICB1aW50MTZfdCB2ZXJzaW9uX21ham9y
Ow0KPiA+ICAgICAgICAgY2hhciB1Y29kZV9wcmVmaXhbMzBdOw0KPiA+IEBAIC0yMTQsNyArMjE0
LDcgQEAgaW50IGFtZGdwdV9zZG1hX2luaXRfbWljcm9jb2RlKHN0cnVjdA0KPiBhbWRncHVfZGV2
aWNlICphZGV2LA0KPiA+ICAgICAgICAgaWYgKGluc3RhbmNlID09IDApDQo+ID4gICAgICAgICAg
ICAgICAgIHNucHJpbnRmKGZ3X25hbWUsIHNpemVvZihmd19uYW1lKSwgImFtZGdwdS8lcy5iaW4i
LA0KPiB1Y29kZV9wcmVmaXgpOw0KPiA+ICAgICAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAg
ICBzbnByaW50Zihmd19uYW1lLCBzaXplb2YoZndfbmFtZSksICJhbWRncHUvJXMlZC5iaW4iLA0K
PiB1Y29kZV9wcmVmaXgsIGkpOw0KPiA+ICsgICAgICAgICAgICAgICBzbnByaW50Zihmd19uYW1l
LCBzaXplb2YoZndfbmFtZSksICJhbWRncHUvJXMlZC5iaW4iLA0KPiB1Y29kZV9wcmVmaXgsIGlu
c3RhbmNlKTsNCj4gPiAgICAgICAgIGVyciA9IGFtZGdwdV91Y29kZV9yZXF1ZXN0KGFkZXYsICZh
ZGV2LQ0KPiA+c2RtYS5pbnN0YW5jZVtpbnN0YW5jZV0uZncsIGZ3X25hbWUpOw0KPiA+ICAgICAg
ICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0K
