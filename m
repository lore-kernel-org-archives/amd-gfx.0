Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92BC4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B27360FC3
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B27360FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB0D6E14D;
	Tue, 17 Aug 2021 09:43:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E845C6E14D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MauUTxvlsRazx+YiMElEE70Z4mFRNLWViuzz0lf295EegQ/QTciGWiEr14KHgy4yzzW1aZTXbCu4isvBVE5RQGAI+qZ+Tsix0oVEig4eFzP7yIRqMfWSKdV3pxqvdU/W8oF50vC26+itooD9MbNqCPragrJ9/xT/5Ds+Z1Qopjxw91w5J8ANV5akCcN3QO79moj581aoomi5KDsHcq7z4d6Niqr6P7/Yreoh0GbyVYc0x6roc6Mh8hWWc7QCqTIgFIaTJ6yc8+pzXw0BsEwn3AE/sZ2/XjbqYagzqWVcG+LlYQtDnnQmUoh900Fv+xVotxkJsq+UyajnOnSAQWZhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPH309nHUhVvRKd3+OEm9M/1wCkXILIP3noK4dWJHz0=;
 b=ZVpgHHXtZ6LpiMr8NeytYgCC3rU5toENWCrKxPTJUdy8rGUDJakcRBcbvUgVC/zUNdumX/ylgVdCGJDr865aYmaEHQpzQuk+ZFvLe8zAMkq3ZE9wMbLxlJ5J12ecaK7sisuzcKDz0S4kl1LRxfiMuwWF5OvdDdyJn/ijFKct5RAnw5ijsxjBnycLi6rIrUAyHSsS9XxpSgQYaXEtm7DQF7pdi7IHfYYETnU70Q+ra246y9NLyCAx6wamdVpRWwLu4inUrPCVQGSyY3KxCUHWEZUcQeX3yaSPihtoeCW2F/gNt3EfjzhRtebzwBCSbg1Pf1Gw0sH4XoratW7loQnEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPH309nHUhVvRKd3+OEm9M/1wCkXILIP3noK4dWJHz0=;
 b=yZAP8tpJ4sWECXyOsjiQtl8clsALhTjMAoObL7VPIyL5gXCx3DQhfG4f1Lb0gXTjdjSA2qDgUMOuGp1B1JuuMg+B9dq9xN716L+icwJC2ve0j2ieDuH/TUZADUpRmlvE04swh6+zVoPI0+DJpVNdfRLD/ab8U6nuoWgD2APaLCw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Tue, 17 Aug 2021 09:43:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 09:43:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Leo" <Leo.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
Thread-Index: AQHXkzLBqks1LrJJAUud/oBDlwP35at3TFGAgAAjcPA=
Date: Tue, 17 Aug 2021 09:43:09 +0000
Message-ID: <DM6PR12MB26198C4D8A712DE7E7EC0580E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210817064005.1437328-1-evan.quan@amd.com>
 <374e0b56-e81f-b4c6-ae97-0ade2c0f5b36@amd.com>
In-Reply-To: <374e0b56-e81f-b4c6-ae97-0ade2c0f5b36@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-17T09:43:05Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c5b4367b-02b8-4a9f-af66-ca1b36b19043;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a81b6bd2-139c-452f-3d70-08d961636c2c
x-ms-traffictypediagnostic: DM5PR1201MB0026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00262FC714761A100E74B33AE4FE9@DM5PR1201MB0026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZ8m0nuRFgfMtcsAJx8W9A2g6lT58i/j6S8beLwGHxfQ3u1W5fPs8SWEqVAXOasKSRu/z1kFBrJJpyYFSvLgNICioSGXomqgf6MC+P3kMKrI4Wy72zPyeYJhIjm5P76lRo7Ar8rmCEz9AWjbOXpdb/53hMkjzp9wLid5LUYu5cPJGIEiaaaqn6/51u4EQQ6xsxwEYDLfBljl7uSw+3//4AaA3BO/4hKPe5D3Q1yBg2xC4nesj55xsitVAcZTtAYGhLLvwG8KJzH6ZuBPlzjfQhHjhi8GGR+LT8822GgA684USks41eNqfP2F7J80CYrLIkDQiOH0ZpwZVxsCdz5kzJKvFJHQxU8KZuL2DhjWfcnhISySce8Vojqtycnv0ACVjkusYSYLyhxyekYOMGWfkRCq+5/eb1YGLBJqxLeLEPkATi2Qz+z+Y7NS4o/BZf8UXVvo9OM0fv2OHAoP5/EG+pFaVyo1Id+JtJ5VThyedSl3HUgun7A8CfzdJ62aQ8OJlj1pU9d1XDOPBZZeTHeyxptBLlSiughK7lEs5NN5mIF+9Mm98VDtHx5cspOZiwR97LhPNu8Py8dkgBi0K1T4mX7fcQNL77F9FoSjlLLdldZUs3O43VjL5VlWQDjFUtG5RNvaxCYbMsCbsBsbMgLFPX2zpkgbmd1jDegdQ1g2Ex7JQC8Is0ia7FOcP+4TZsVyAbyUUhIeaOejh2YLO23LpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(52536014)(122000001)(66946007)(33656002)(66556008)(66476007)(83380400001)(38100700002)(38070700005)(316002)(8936002)(2906002)(6636002)(110136005)(15650500001)(54906003)(8676002)(7696005)(6506007)(9686003)(55016002)(26005)(186003)(53546011)(86362001)(5660300002)(76116006)(71200400001)(64756008)(66446008)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXhqWk1MdzRFaStzb200L1p2UnZQQUQ4R0t6NlVuZlgwZjVxb1VhTzNhZHN1?=
 =?utf-8?B?VFhUa084ZGdQdkdxZUlvck1nMExGMHFIQXZLSEhESFlkV1BkSEExSnpjaFVl?=
 =?utf-8?B?cC8yY3BXZzVsTHBkQ3dDcTVHWmpqMWlsSkIveU5FQld6cHloM0w3dXZrVGsv?=
 =?utf-8?B?TDJVSzZEZGtSOFRQOG1wd3RkNFFyNWJmWFNuMVYzNXNJQW5ib0M0eXkzWGNO?=
 =?utf-8?B?TGJsRjFjRksxcHdZUm5MYkkxL0QwS3Z0Zng0NituUU1BOXhNWTJ2MkFOUzFs?=
 =?utf-8?B?Y3VkS3pqcVZmdm5kd21wclBTZVErTW54MXdFM0kwOUNqNWxZSWZOMkx6OUdo?=
 =?utf-8?B?Qk1aajNCd2NaRXFBZWY0ajV0bEIraThCSVFwOEpMT3pnVk1Xa01Nak5OU0Fw?=
 =?utf-8?B?WFVKYnBEcFN1SFJ2L2l6Q0FQNCtKVEFmRzRJcng5NnRFVTE5WXJ5Zy9VWm9X?=
 =?utf-8?B?cUZZMHF2MVhCaWQ2Y05sTFdmalM0N2h6QVl2bWtnTW5ML3lGbEdySXBWaHVF?=
 =?utf-8?B?UDM3clJ3eXZtQnlDaCs2SVdhUldwVllGa1VXbzJHMTRwVGVyQzc4RXlzU1hy?=
 =?utf-8?B?cEI1eWpiM2J1YWRUNXVBREFaV1NTeklwM2ZKUzliaWlabTBTY0xIKzg2NER2?=
 =?utf-8?B?bUlYVkZyalEydS90ZWY4a080MzlOUzQweWtLTmZQQ25oQWxYbUZ6N0dQZmE4?=
 =?utf-8?B?NDZoTmExbkVScmNmVjV3NGtLaU56ZEhXNXJrQ0g0Si9iVktGYjFSNmVObTJn?=
 =?utf-8?B?TWVXR3FWTDhNQndxajFFSWpnbzNKeTdRV1Z4TnlFK1hGMGpoMGw4S25LcStO?=
 =?utf-8?B?K3ZIWlNPRTB4MUJodElZQnRSb096K01aaCtDSVZjaUlUbllxNTU5dXBjM3dB?=
 =?utf-8?B?TnF5U2dCRC9uc2p5NmxMSkxqS2d3Qkw0S1Nxa09XdHI5eDJYbEJLNi9LRWJO?=
 =?utf-8?B?MjVvUXhLWG9qOWh4NFppem5jNnhsdkZ6alZsY2RLa3MzdTNRaTVqRGJTenlP?=
 =?utf-8?B?cCt0K1RQdnNvNkZseDhMRUtxckxTVHBLWGUxL0tldXFtbW9lZVdRODh2MVlG?=
 =?utf-8?B?MHplQzdPaEN6VzVKZWZzVDdYOHoxb1lySnM0UkRJbXdFd29UV1hhT1lDdEli?=
 =?utf-8?B?ckozUW9YM1NMUzZ4RDFSNGd5azM1bnhwOXdIdVcyRFBNN3pDVTAwMUpYWEtm?=
 =?utf-8?B?MklpZDZ5YkIvTTIzM1oyaU5lZG9WUHorQ2tSTGVKK3N1amp3L0Zkblk4S1Iw?=
 =?utf-8?B?SFF3cmtzT3paUFhoNVIxejg3S0d2SlZnMmJQYmlpNCtsZ2FHcktLQXJaNThE?=
 =?utf-8?B?cFJYTDUwVXFYKzlYbXJGcWlVeE0yRDdIcjdmdzVvTFlWNGNVL2JpY08vVEtF?=
 =?utf-8?B?YnFTNWJhZ21pRjQwdlg3R05TVXFaMGJKeHp5VGpDdWNPV2NZaUxuUC9Oem1V?=
 =?utf-8?B?dHhPanZzWTBZYzVoVzJNQkVFL0RaT3J0SjBlT0Z6VWlqTWxHSzBqZVI3WW83?=
 =?utf-8?B?YVhxTFdlOTVrTVFXelVxNUpnNU1CNmJqNzRsYlVSYytLbUd4WUxUaGxuNkU1?=
 =?utf-8?B?ZnlhTjVnRTRiQUNWTlZZNVFqaUxyL1pVbDU2eWVzVk5pOXFENmplWktUWmlW?=
 =?utf-8?B?c0pMR0haUlBZYlg3Z2tvY3poRXlhR2JlK2RlSmV4aUR4N3VSUXlyZzE3TUlM?=
 =?utf-8?B?azQyakJMY0hERGZwMzdndjlnc1Y3NkFXaGV6MWI3ZVpXMGNYUGkwU0E3RlRq?=
 =?utf-8?Q?TPOQOCdAEC+Yx/oeUCSyEYVg3bCTXXL/XgIQkfQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81b6bd2-139c-452f-3d70-08d961636c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 09:43:09.2831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EK6DyycaEElI97ZZDcDm5mqOcMT0su87cuWhBagVhay6g5XyaJ0jvU6G525jey0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KK0xlbyB0byBzaGFyZSBoaXMgaW5zaWdodHMNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5M
YXphckBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTcsIDIwMjEgMzoyOCBQTQ0K
PiBUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgQ2hlbiwgR3VjaHVuDQo+IDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgUGFuLCBYaW5o
dWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogcHJvcGVybHkgcG93ZXJnYXRlIFBvbGFyaXMxMiBVVkQvVkNFDQo+IG9uIHN1c3BlbmQNCj4g
DQo+IA0KPiANCj4gT24gOC8xNy8yMDIxIDEyOjEwIFBNLCBFdmFuIFF1YW4gd3JvdGU6DQo+ID4g
SWYgdGhlIHBvd2VyZ2F0aW5nIG9mIFVWRC9WQ0UgaXMgaW4gcHJvY2Vzcywgd2FpdCBmb3IgaXRz
IGNvbXBsZXRpb24NCj4gPiBiZWZvcmUgcHJvY2VlZGluZyhzdXNwZW5kaW5nKS4gVGhpcyBjYW4g
Zml4IHNvbWUgaGFuZ3Mgb2JzZXJ2ZWQgb24NCj4gPiBzdXNwZW5kaW5nIHdoZW4gVVZEL1ZDRSBz
dGlsbCB1c2luZyhlLmcuIGlzc3VlICJwbS1zdXNwZW5kIiB3aGVuIHZpZGVvDQo+ID4gaXMgc3Rp
bGwgcGxheWluZykuDQo+ID4NCj4gPiBDaGFuZ2UtSWQ6IEkzNmYzOWQ5NzMxZTBhOTYzOGI1MmQ1
ZDkyNTU4YjBlZTljMjNhOWVkDQo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1
YW5AYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZf
MC5jIHwgNSArKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAu
YyB8IDUgKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMNCj4gPiBpbmRleCA0
ZWViZjk3M2EwNjUuLjJmZGNlNTcyYmFlYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y2XzAuYw0KPiA+IEBAIC01NTQsNiArNTU0LDExIEBAIHN0YXRpYyBpbnQgdXZk
X3Y2XzBfc3VzcGVuZCh2b2lkICpoYW5kbGUpDQo+ID4gICAJaW50IHI7DQo+ID4gICAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+
ID4NCj4gPiArCS8qDQo+ID4gKwkgKiBJZiB0aGUgcG93ZXJnYXRpbmcgaXMgaW4gcHJvY2Vzcywg
d2FpdCBmb3IgaXRzIGNvbXBsZXRpb24uDQo+ID4gKwkgKi8NCj4gPiArCWZsdXNoX2RlbGF5ZWRf
d29yaygmYWRldi0+dXZkLmlkbGVfd29yayk7DQo+ID4gKw0KPiBJZiBydW5uaW5nIGlkbGUgaXMg
YSBwcmVyZXF1aXNpdGUgYmVmb3JlIGdvaW5nIHRvIHN1c3BlbmQsIHRoZW4gc29tZXRoaW5nIGVs
c2UNCj4gaXMgbWlzc2luZyBoZXJlLg0KPiANCj4gT3RoZXJ3aXNlLCB0aGUgaGFuZyBsb29rcyBt
b3JlIGxpa2UgYSBwZW5kaW5nIHdvcmsgbGF1bmNoZWQgYWZ0ZXINCj4gaGFyZHdhcmUgaXMgc3Vz
cGVuZGVkIGFuZCB0cnlpbmcgdG8gYWNjZXNzIGhhcmR3YXJlLiBBcyB0aGUgaGFyZHdhcmUgaXMN
Cj4gZ29pbmcgdG8gYmUgc3VzcGVuZGVkIGFueXdheSwgZG9lc24ndCBpdCB3b3JrIHdpdGgNCj4g
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIC0gbWFraW5nIHN1cmUgdGhhdCBub3RoaW5nIGlzIGdv
aW5nIHRvIGJlDQo+IGxhdW5jaGVkIGxhdGVyIHRvIGFjY2VzcyBoYXJkd2FyZT8NCltRdWFuLCBF
dmFuXSBUaGUgcmVhc29uIHdlIGNob3NlIGZsdXNoX2RlbGF5ZWRfd29yayBpbnN0ZWFkIG9mIGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYyBpcyB3ZSB0aGluayB0aG9zZSBvcGVyYXRpb25zIHBlcmZv
cm1lZCBpbiBpZGxlX3dvcmsoZHBtIGRpc2FibGVtZW50LCBwb3dlcmdhdGluZykgc2VlbXMgbmVl
ZGVkIGNvbnNpZGVyaW5nIHRoZSBhY3Rpb24gaXMgJ3N1c3BlbmQnLiBTbywgaW5zdGVhZCBvZiAi
Y2FuY2VsIiwgbWF5YmUgd2FpdGluZyBmb3IgdGhlbSBjb21wbGV0aW9uIGlzIG1vcmUgcHJvcGVy
LiANCj4gDQo+IFRoZW4gdGhpcyBtYXkgYmUgYSBwb3RlbnRpYWwgaXNzdWUgZm9yIG90aGVyIHN1
c3BlbmQgY2FsbHMgYWxzbyB3aGVyZSB3b3JrIGlzDQo+IHBlbmRpbmcgdG8gYmUgbGF1bmNoZWQg
d2hlbiBoYXJkd2FyZSBpcyBzdXNwZW5kZWQuDQpbUXVhbiwgRXZhbl0gRG8geW91IG1lYW4gd2Ug
bmVlZCB0byBjaGVjayB3aGV0aGVyIHRoZXJlIGlzIHNpbWlsYXIgaXNzdWUgZm9yIG90aGVyIElQ
cz8NCg0KQlINCkV2YW4NCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIAlyID0gdXZk
X3Y2XzBfaHdfZmluaShhZGV2KTsNCj4gPiAgIAlpZiAocikNCj4gPiAgIAkJcmV0dXJuIHI7DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMNCj4gPiBpbmRleCA2ZDkx
MDhmYTIyZTAuLmYwYWRlY2Q1ZWMwYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y2VfdjNfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNlX3YzXzAuYw0KPiA+IEBAIC01MDMsNiArNTAzLDExIEBAIHN0YXRpYyBpbnQgdmNlX3Yz
XzBfc3VzcGVuZCh2b2lkICpoYW5kbGUpDQo+ID4gICAJaW50IHI7DQo+ID4gICAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+ID4N
Cj4gPiArCS8qDQo+ID4gKwkgKiBJZiB0aGUgcG93ZXJnYXRpbmcgaXMgaW4gcHJvY2Vzcywgd2Fp
dCBmb3IgaXRzIGNvbXBsZXRpb24uDQo+ID4gKwkgKi8NCj4gPiArCWZsdXNoX2RlbGF5ZWRfd29y
aygmYWRldi0+dmNlLmlkbGVfd29yayk7DQo+ID4gKw0KPiA+ICAgCXIgPSB2Y2VfdjNfMF9od19m
aW5pKGFkZXYpOw0KPiA+ICAgCWlmIChyKQ0KPiA+ICAgCQlyZXR1cm4gcjsNCj4gPg0K
