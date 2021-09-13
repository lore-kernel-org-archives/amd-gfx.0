Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0313DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 13:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C995860F9F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 13:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C995860F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531076E17D;
	Mon, 13 Sep 2021 13:02:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B51D6E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 13:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UptCevdk7nb6N53xJzHf80vz2N3uoelSpEF+atDzy7AGqreTIBeLHAQQlyQskKZgtGS1NoAxUDlbHEV2PO+5Mh+dRMYesTkrrAFQ1D1DsBK9qsNe7TUv68VWXa5I24yQH0v5YO/fkKY1/HSkWaZa+bbXfYpWufW3sYqXeGSGhfoYuJf586VV4mAFn2JkZbUISV+qD6xAIUOPSbivdvVk/L+PhfNM5pUqU2QdfpPz4zYBihmSZ+3iOu0O492xMxovNIUAQHCOD1BhQcCpCba/sRsXEVlgxpJwLDcgT+O4pKoQ5wplhRT2fT1mdCeR0ZUgM7kPtUm7srvt7G7gnp1b8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=h1BCH8ByBLX1c64E6Qsp2fNlF1cuuuekQwoPYt2QQpU=;
 b=YE94hG4TfHHYtwmBb3HSSnXEESkqUTQ5JcwZsgqkieQ5bNGII4xISeTD6xUtRHWBeQ7+3iudLwK6jjLdaZCqDm/2FCePVx3tiGJQKSHlZVLSXWEcs1Etn0eu2BDUaQqGrnQHLR9Q7HpI21CTv1q+UjPSpRq9j19GK69iAqaWQzGig+7ZCDa5y32dRwqNTUZKTpidPb7u+PAzIglrJtPIfwdEwxPabMa7tnJR6VPkYOb7y3pJFXAcTMfEwm9xJjwH2yfnUP15i3LGm7Cdp8ZJfKO5pUwg3s2xwfkuG/x3qpPsQWoFbpurUjx1IqDhDCskmFuxMt0ibFzRskPa/fdp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1BCH8ByBLX1c64E6Qsp2fNlF1cuuuekQwoPYt2QQpU=;
 b=SayDFNPsQmeZW21vQ1Y4OIpoX4QZLKGemyUwVnDLcSH8tHWuFm2tBFc2PCrIxQjJoVyqn2NVL8BYHsSW3DztaD9Ob8QQAMrUKqbUL1rEyR8XMxo1/5fhQB3w4tEyiZJnUZXtwRYTc3wz3Jo6LDYAGkMeUVTTaTgYZ1LAWeWmt00=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 13:02:48 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::601a:855c:7c9e:220b]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::601a:855c:7c9e:220b%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 13:02:48 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>
Subject: RE: [PATCH v4 2/3] drm/amdgpu: VCE avoid memory allocation during IB
 test
Thread-Topic: [PATCH v4 2/3] drm/amdgpu: VCE avoid memory allocation during IB
 test
Thread-Index: AQHXqHtloIgN0QuKcUy5XTGH0UjnFquhq40AgABB4QA=
Date: Mon, 13 Sep 2021 13:02:48 +0000
Message-ID: <DM8PR12MB5399EC65F41296A354D0E8EAE5D99@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20210913084253.241955-1-xinhui.pan@amd.com>
 <20210913084253.241955-2-xinhui.pan@amd.com>
 <b75f2a81-e922-1a24-7d32-900b6607b0bd@amd.com>
In-Reply-To: <b75f2a81-e922-1a24-7d32-900b6607b0bd@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=897afda9-6802-4fb0-9a89-8a7edf7f9618;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-13T12:59:33Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c713234-5791-495a-eabb-08d976b6c98c
x-ms-traffictypediagnostic: DM8PR12MB5414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5414B7A10D09BB88ACA810E0E5D99@DM8PR12MB5414.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8DFBkVOoPSmxlgpGhQEyu7wHNC20NlfsxTcFxmlJiM4S1ITrKJA+eire9NO7fRpkGa9JAi9btwuv1yTEPth1AgFSx2iX8TS00cWlH4BHEPhbtnV0fn2YX20wpQEpB9Aia+ypK+giYsr/MHWd9ysqvBcMQgz2QrVJNb3wVmNdFuKcz0yZVtn0xUZXef/Utb66uDnvZhPCIoh4wAjVnhe1HrFk2gS9LOuXnjAlSqkYuhwPTWOXeiYD4Z8Ir3FTIDi5efGEZO0jTOdoopjTWIDlC8RU5JVfD/to6K6rkzU8C7NFDM8CnGo0lZBSiR+8KRaUaHRltmHJjPRd6u+mANa10otHBoBfz2XbsazSwd0Z5tnOl5luJfeSIfGBc/E5obN1iPzqLpROcUZqwouKtEBve/7ecPyahk/9Hjfo1JsK0Bzf1w/qo75FMPm2Dba8C6isnPgBGtm3lCkLS2uHoQX3L7rJ8X5S8y++V/Vdf8soVPaamfpljH0IsCTTqiagC+N+ZuAXYtguWmIBR8gz+fc1vro/BuM/OnThKQ0MAGDSMMuTEu7nYVCqR1af3sl3DjfvgSY2uLDKXW60vHmyJxGkAR8HgoDS3UVMfy/c2VFAcCy7NnUp5dEOv/GMRfGIarpKzr+8nQo4DaTiZz+PuJsS2VJJWpHC9jwHUllap2rZQo64Sei0LpvwkkgY8HexKlqdl83qY8ZV8245xferjuYjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(6506007)(55016002)(8936002)(26005)(186003)(33656002)(66946007)(110136005)(53546011)(316002)(122000001)(8676002)(38100700002)(9686003)(66446008)(54906003)(64756008)(66556008)(66476007)(76116006)(4326008)(7696005)(2906002)(38070700005)(71200400001)(52536014)(5660300002)(83380400001)(86362001)(478600001)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1A3N1RPWlZwUWlYZWFaM0dsYlA5OHdWdEIwRmdJV3ZtWGwrZVo4cWF6WGYv?=
 =?utf-8?B?SmwxejRqZkI4ZG9oUFNoNFpTcXB2VjlqMUlvVmI3M2p2T2NEZEtEY3E0RUZq?=
 =?utf-8?B?eDdmcWZsOWZRYms1OWd1anhBWDJsMHRNVHhadU4rSVpDRlhZQmNCaVVTbm9K?=
 =?utf-8?B?Sml2anN2ekxBSmlrVEVtOHM1WVIrSFp6dGljQ2h2Tm82YmNDeXJDVjgrRXdn?=
 =?utf-8?B?aWU4SXVqVTRhajI4c0E1VmtvY3BIdjFjeWNWS1E5VjRTRS9wQkNHVUl4Vlg5?=
 =?utf-8?B?U290ai9KdTZpV01oUmNLTTlEVHRlcWdzaE9XMitueTl3M0Q0MVhyWWNTZGQr?=
 =?utf-8?B?VjhRSGg1REllaUZEQ2djMkczWWF0M3RBSm82M1hHdEl4WEJTQUJ5NjFpcHly?=
 =?utf-8?B?OFRlYmdFeCtRKzlBODV2TXhGU2o2S2VZbEQyNUtOaUdWODVESWZST01xS0M0?=
 =?utf-8?B?NmVhN25MdWQ2L3puNzd6ZGdQSEFBVzJubTNVbXN4b3dZRHVNeUl0aWo1aHZr?=
 =?utf-8?B?RmxNL0w0bDNvV3dJUFlTZjZURTZhazBrOU9wZnBjMlQyOWVKRVhONmZETzUz?=
 =?utf-8?B?NW5OWU5ublp4MWZUYVliazBtYmhTWkRpNlpSRHEzcDI1WHBYYmZERE0yLzRa?=
 =?utf-8?B?RDlIOVlSOC9HOTJtRXFjRCtyWW9acFczcyt1TlFyblpmcDZmei9udjZwRUhL?=
 =?utf-8?B?SytMMGJmeGh6L0lwcU92a0J5ZTM2Wm5SRjhKRXRwVUFWNHBBemtoTEZmRlNX?=
 =?utf-8?B?bWx0RVVHeW5jMndZM2JNU3kxSDFVejU4aVc5ZzJuZEJ4QlZCN250WWpNYmZ5?=
 =?utf-8?B?TGgrSU5TbXJxWm9nVTJpSTRuTzdvbUxLeXlqVXVtV3ZXcG4zUzVPUEtIVmR4?=
 =?utf-8?B?WWFSdGMyYzZRSlN3cG1xMDRPd1p2VldFaFVYTm5hM083OE5NWFpnczNmMkZZ?=
 =?utf-8?B?MWNYTTRGNlN3Y0t6ajVwNzh2TGRobGRvM1RmbHM5a0pkdFdzOFRkV1hFcXdp?=
 =?utf-8?B?YmF3VGU3ZFM1VFgyd0ZjZFQxS2hKcHZEWmRrS1Y3eXVlOFdxYWFTYXpySTNP?=
 =?utf-8?B?YXlZa2h4WnVtcEZtWi9lTk1KNDVYV0d0d1NTR3F2M0hwSi9lNm0wWHRDd0s4?=
 =?utf-8?B?eWFoUFptMk9UK1JnM3g4R2lEc3pmdkdaVndoUWlCQm5ZZ3NHaWFBaEI1clpz?=
 =?utf-8?B?ei83dGx3MmdRdSs4eVJwK3AramJacHNjL0FleU1rbll6ZVQ3TzJybUpTV2ZO?=
 =?utf-8?B?KzkyUFBRWnFBT1BlRC9sNDJkMHIrVnpIZjh6SytNZm05MldCbGtlUERjL0ta?=
 =?utf-8?B?N2Zsek5BYkczeE8rWm5xeFg0ckxITnVyMVpDblN3UlNqdEQxcVoxa1BjbU44?=
 =?utf-8?B?V2E5VVVuVnNUVUlqR1drbkdIMHVsUzNwT2o5VFpVTVRmRUcxcGN1N3pUN3Zr?=
 =?utf-8?B?UkRnZm11SUtlYkhpeTNaTkw4eTNuTko4cGEyRGFrQU5SZHNLWUFhOVVIWlha?=
 =?utf-8?B?Slcvd0F2M05ycUxSYm5Ta0hPdHEybU83Qkg1YURqcmxha2NCd29oL3dRY2RN?=
 =?utf-8?B?NWt1cjBXalhwTm8zUmNKMXZOenhHYUtHTExiWnNVNXBFVTJQYVZHWEI0N0JR?=
 =?utf-8?B?Kys1c0hTZSs2eXRrYnhCVS96bVlLbEJ6TTQ4TE94MTh5NTcxWkVWeTFzSGpN?=
 =?utf-8?B?OUFUSzFFMVZlVlg1REZqd3JkRGxWdFY0Q1RoTTdxbnVCRzNSdnZydmthSkw3?=
 =?utf-8?Q?EDSbDbOQlGVsnn+XM6QUuJaeoLpBqOdR1qrIw1e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c713234-5791-495a-eabb-08d976b6c98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 13:02:48.5554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KR7SDcLf0OWASeftFWNBd0xLfT5T+GcVxxBPHYQ/9vH5tfA/eP+Y0U+JT73KPf6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KMjU2IGJ5dGVzIGFsaWdubWVudCBpcyBmb3IgVmlk
ZW8gSFcgdGhhdCBpcyB3aXRoIEdGWDksIHNvIGl0IHNob3VsZCBiZSBmaW5lIGluIGdlbmVyYWwu
DQoNClJlZ2FyZHMsDQpMZW8NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFNlcHRl
bWJlciAxMywgMjAyMSA1OjA0IEFNDQpUbzogUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT47
IFpodSwgSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2NCAy
LzNdIGRybS9hbWRncHU6IFZDRSBhdm9pZCBtZW1vcnkgYWxsb2NhdGlvbiBkdXJpbmcgSUIgdGVz
dA0KDQpBbSAxMy4wOS4yMSB1bSAxMDo0MiBzY2hyaWViIHhpbmh1aSBwYW46DQo+IGFsbG9jIGV4
dHJhIG1zZyBmcm9tIGRpcmVjdCBJQiBwb29sLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkg
cGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQoNCkl0IHdvdWxkIGJlIGNsZWFuZXIgaWYgTGVvIGNv
dWxkIGNvbmZpcm0gdGhhdCAyNTYgYnl0ZSBhbGlnbm1lbnQgd291bGQgd29yayBhcyB3ZWxsLg0K
DQpCdXQgZWl0aGVyIHdheSBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiBjaGFu
Z2UgZnJvbSB2MToNCj4gbXNnIGlzIGFsbG9jYXRlZCBzZXBhcmF0ZWx5Lg0KPiBtc2cgaXMgYWxp
Z25lZCB0byBncHUgcGFnZSBib3VuZGFyeQ0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNlLmMgfCAyNyArKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jDQo+IGluZGV4IGU5ZmRmNDlk
NjllOC4uY2FhNGQzNDIwZTAwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZjZS5jDQo+IEBAIC04Miw3ICs4Miw2IEBAIE1PRFVMRV9GSVJNV0FSRShGSVJNV0FSRV9W
RUdBMjApOw0KPg0KPiAgIHN0YXRpYyB2b2lkIGFtZGdwdV92Y2VfaWRsZV93b3JrX2hhbmRsZXIo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsNCj4gICBzdGF0aWMgaW50IGFtZGdwdV92Y2VfZ2V0
X2NyZWF0ZV9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1aW50MzJfdCBoYW5kbGUsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8s
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAq
KmZlbmNlKTsNCj4gICBzdGF0aWMgaW50IGFtZGdwdV92Y2VfZ2V0X2Rlc3Ryb3lfbXNnKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgaGFuZGxlLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBib29sIGRpcmVjdCwgc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNl
KTsgQEAgLTQ0MSwxMiArNDQwLDEyDQo+IEBAIHZvaWQgYW1kZ3B1X3ZjZV9mcmVlX2hhbmRsZXMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBkcm1fZmlsZSAqZmlscCkNCj4gICAg
KiBPcGVuIHVwIGEgc3RyZWFtIGZvciBIVyB0ZXN0DQo+ICAgICovDQo+ICAgc3RhdGljIGludCBh
bWRncHVfdmNlX2dldF9jcmVhdGVfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMy
X3QgaGFuZGxlLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBh
bWRncHVfYm8gKmJvLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBkbWFfZmVuY2UgKipmZW5jZSkNCj4gICB7DQo+ICAgICAgIGNvbnN0IHVuc2lnbmVkIGliX3Np
emVfZHcgPSAxMDI0Ow0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iOw0KPiAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2liICppYjsNCj4gKyAgICAgc3RydWN0IGFtZGdwdV9pYiBpYl9tc2c7DQo+
ICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKmYgPSBOVUxMOw0KPiAgICAgICB1aW50NjRfdCBhZGRy
Ow0KPiAgICAgICBpbnQgaSwgcjsNCj4gQEAgLTQ1Niw5ICs0NTUsMTcgQEAgc3RhdGljIGludCBh
bWRncHVfdmNlX2dldF9jcmVhdGVfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMy
X3QgaGFuZGxlLA0KPiAgICAgICBpZiAocikNCj4gICAgICAgICAgICAgICByZXR1cm4gcjsNCj4N
Cj4gLSAgICAgaWIgPSAmam9iLT5pYnNbMF07DQo+ICsgICAgIG1lbXNldCgmaWJfbXNnLCAwLCBz
aXplb2YoaWJfbXNnKSk7DQo+ICsgICAgIC8qIG9ubHkgb25lIGdwdSBwYWdlIGlzIG5lZWRlZCwg
YWxsb2MgKzEgcGFnZSB0byBtYWtlIGFkZHIgYWxpZ25lZC4gKi8NCj4gKyAgICAgciA9IGFtZGdw
dV9pYl9nZXQocmluZy0+YWRldiwgTlVMTCwgQU1ER1BVX0dQVV9QQUdFX1NJWkUgKiAyLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfSUJfUE9PTF9ESVJFQ1QsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICZpYl9tc2cpOw0KPiArICAgICBpZiAocikNCj4gKyAgICAgICAgICAg
ICBnb3RvIGVycjsNCj4NCj4gLSAgICAgYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KGJvKTsN
Cj4gKyAgICAgaWIgPSAmam9iLT5pYnNbMF07DQo+ICsgICAgIC8qIGxldCBhZGRyIHBvaW50IHRv
IHBhZ2UgYm91bmRhcnkgKi8NCj4gKyAgICAgYWRkciA9IEFNREdQVV9HUFVfUEFHRV9BTElHTihp
Yl9tc2cuZ3B1X2FkZHIpOw0KPg0KPiAgICAgICAvKiBzdGl0Y2ggdG9nZXRoZXIgYW4gVkNFIGNy
ZWF0ZSBtc2cgKi8NCj4gICAgICAgaWItPmxlbmd0aF9kdyA9IDA7DQo+IEBAIC00OTgsNiArNTA1
LDcgQEAgc3RhdGljIGludCBhbWRncHVfdmNlX2dldF9jcmVhdGVfbXNnKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZywgdWludDMyX3QgaGFuZGxlLA0KPiAgICAgICAgICAgICAgIGliLT5wdHJbaV0g
PSAweDA7DQo+DQo+ICAgICAgIHIgPSBhbWRncHVfam9iX3N1Ym1pdF9kaXJlY3Qoam9iLCByaW5n
LCAmZik7DQo+ICsgICAgIGFtZGdwdV9pYl9mcmVlKHJpbmctPmFkZXYsICZpYl9tc2csIGYpOw0K
PiAgICAgICBpZiAocikNCj4gICAgICAgICAgICAgICBnb3RvIGVycjsNCj4NCj4gQEAgLTExMzQs
MjAgKzExNDIsMTMgQEAgaW50IGFtZGdwdV92Y2VfcmluZ190ZXN0X3Jpbmcoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKQ0KPiAgIGludCBhbWRncHVfdmNlX3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCkNCj4gICB7DQo+ICAgICAgIHN0cnVjdCBkbWFf
ZmVuY2UgKmZlbmNlID0gTlVMTDsNCj4gLSAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBOVUxM
Ow0KPiAgICAgICBsb25nIHI7DQo+DQo+ICAgICAgIC8qIHNraXAgdmNlIHJpbmcxLzIgaWIgdGVz
dCBmb3Igbm93LCBzaW5jZSBpdCdzIG5vdCByZWxpYWJsZSAqLw0KPiAgICAgICBpZiAocmluZyAh
PSAmcmluZy0+YWRldi0+dmNlLnJpbmdbMF0pDQo+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
DQo+IC0gICAgIHIgPSBhbWRncHVfYm9fY3JlYXRlX3Jlc2VydmVkKHJpbmctPmFkZXYsIDUxMiwg
UEFHRV9TSVpFLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVf
R0VNX0RPTUFJTl9WUkFNLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
Ym8sIE5VTEwsIE5VTEwpOw0KPiAtICAgICBpZiAocikNCj4gLSAgICAgICAgICAgICByZXR1cm4g
cjsNCj4gLQ0KPiAtICAgICByID0gYW1kZ3B1X3ZjZV9nZXRfY3JlYXRlX21zZyhyaW5nLCAxLCBi
bywgTlVMTCk7DQo+ICsgICAgIHIgPSBhbWRncHVfdmNlX2dldF9jcmVhdGVfbXNnKHJpbmcsIDEs
IE5VTEwpOw0KPiAgICAgICBpZiAocikNCj4gICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPg0K
PiBAQCAtMTE2Myw4ICsxMTY0LDYgQEAgaW50IGFtZGdwdV92Y2VfcmluZ190ZXN0X2liKHN0cnVj
dCBhbWRncHVfcmluZw0KPiAqcmluZywgbG9uZyB0aW1lb3V0KQ0KPg0KPiAgIGVycm9yOg0KPiAg
ICAgICBkbWFfZmVuY2VfcHV0KGZlbmNlKTsNCj4gLSAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShi
byk7DQo+IC0gICAgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYm8sIE5VTEwsIE5VTEwpOw0KPiAg
ICAgICByZXR1cm4gcjsNCj4gICB9DQo+DQoNCg==
