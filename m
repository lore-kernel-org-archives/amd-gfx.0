Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A21C43457
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 11:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD252145D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 11:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IkglIDdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD252145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AF86E437;
	Mon, 12 Oct 2020 11:51:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138746E437
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 11:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhwpIRLCDg6I/OuofS9/E97UnYa+7KE4XRcidoAil7pfaa7OVH4OMBKCbt93l83nGpJ5TZdR3oQCMDDxqZKmuzU9xVzUM/TPtz4id/5kuVWhc4eoV3eo6K8JRS2my2k3wOGz4jLfQNVeZ+1Jbo0Qu7H6EBa7s6lPi7Tc6Nbl7f0D24Pbz8shJdz0l+t5eA2GPjO6EMx8Ir0GrH3SVQMGdxxziqnpXzMi7GhjvjIyMMerUV49XCdZzhN3lNMcDq8c9PDZyPo+UoHkm5WmLt6BJ388jzpA+oP4Rc3HLXcHQHW82JR34+TV7lrcuFX5Z8VonGK7aLDdazsP7IuwooxYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZxt1iCApSubKJMPq57JpbT2NPPqNTXZp9k/tY9Hn+c=;
 b=mqXCs0AVqd8Osw464Hu9eM+N/gSUdMFD7FUEld6HvSKQzimlA08Li3qKfRY/p5Iy01QYnk32wMDUxfbh/GO/Vn4pqpWlPOLhA28HjbJpO3KPTMjm4XtL5b9LVBLrqtLTwCMs4i+rJdzzCxYIJ9LX7MXsKuVK/BvfJK3lGvcnWzarRh3uy9Ib+JdAmXdXthOqI9EzH0HHsKyiHyJiAcQ/KhU7ywRfHuwQQiYRKAap+JwtNUUbTgri13ObgbfThFlGyFdSxdjXefBwk3OoAXDZ01CyOgqC+qEUIuLLByUJoXILhRozscV9LTFI/OVl5VJEYT7hETEiVHSu2hOJGx+zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZxt1iCApSubKJMPq57JpbT2NPPqNTXZp9k/tY9Hn+c=;
 b=IkglIDdLoHFO8dY0tP6jBo6IU3z7y5iaL1yZgBcgujprDARBRMzmbB8hx84xKI8X7vFzoY/5t8OVXqMlri7+vzzAqKmfHHMyLONTO4flRuXcGJd0UQzkM3N01KmmBmpjrB12cSSFWFeU2mFR6obWqhUWuRgqmgj/qZndcE9VZ7o=
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM5PR12MB1897.namprd12.prod.outlook.com (2603:10b6:3:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 11:51:17 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380%6]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 11:51:17 +0000
From: "Patel, Mihir" <Mihir.Patel@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Thread-Topic: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Thread-Index: AQHWoHZuBGHcWtM0WkurDINF7fN4zKmTrkOAgAAFz8CAAAOGgIAAAVuwgAAQ/oCAAAEqgIAAD1nQ
Date: Mon, 12 Oct 2020 11:51:17 +0000
Message-ID: <DM6PR12MB4452264DE7A75EA39CD85393E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
 <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <24df1d90-04ad-e444-306d-7c2e16979b80@amd.com>
 <3d9496e3-74ec-288d-4736-eb583d0f1c92@amd.com>
In-Reply-To: <3d9496e3-74ec-288d-4736-eb583d0f1c92@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-12T11:51:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=eba73422-9e46-4e74-9834-0000f3ffec6c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-12T11:51:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bbca5732-3b02-4a23-b412-0000376557ce
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.83.139.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 179446a9-c92e-40f9-4099-08d86ea52120
x-ms-traffictypediagnostic: DM5PR12MB1897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18975A71A7E04C61A157B5E1E8070@DM5PR12MB1897.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpum6JaaTpqmD3RhqxCT7tBuJGKv8DaZ7eI7KV8g0ABQ6fxl+9q9dhMf7l2Qmqrbu1xTorEfV9QTW4Ek0aRY5xMZVC/3WtahrWhiIycyur78yUXS+W+fiR9je66o1vfccj2E80zY1ePBnFmxlm2MZEDSz7ORciNJYfMvuXb10/tbrxvyMGJGYUOZW+JVUGdn5o5cAPMuJPzWMPYTc9kusNefcK2fHSpNPkvc0YqmufA9pnUwcPKMLeNAOKtd9I3z76NPvtFS0iv5X4keCS1BKpXm4K22l73fra4STYqN3deHAwXt//GwYdvqcqyFTiQR4Aptm94b1pNma0oJWe3k5MXOVX0xXPOZ9RgZuWLMoy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(7696005)(9686003)(478600001)(966005)(33656002)(4326008)(55016002)(54906003)(66446008)(71200400001)(52536014)(110136005)(26005)(8936002)(5660300002)(76116006)(86362001)(8676002)(186003)(66946007)(316002)(53546011)(2906002)(83380400001)(6506007)(64756008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: M4htyMdpMpK+qyUCSAq7hZ5ssLoI6uO7y+b99WQ2yY7C/lkTcjMPvRLu03UFFU2FGaykY3PNyrFYNi4qZiman/RABPRV6PsWtyKrVDpQOQC+lJfygPdYZ14NPXGXYs3dZbVU6ZDpPIL/WOokCQDjeiLUYyLeSVwaWJhyFaZd8Fz260w84XGpeDtw+kRFqLYFZs5p8AXQpetjftPqtJq61ha6Sl8XOOzc3XGVWubpqG/qEuRXQJ+gk+HW1a0XxCJcqvWqeHF+eVbSy9pMrzgVbC0rCL8TCbbDYWJ5aXpHNa+rbISxMm+ZLDCZud04SpcmfQKqklbPORezhY/k521ZGy0EaB2PlhXNIfYrHb86M6erObNp6laeGwMgR5iJAYo8qDELm5Q+sk/4w5hp0IBbtX8SsdwNy+Jfs2cVId0P6wy1ZBn7aTKN9T4KN7jdzGysvMB141TT/WgvGiPiyysOTBxgFD8c7EXS5kAj8+yaeVFI/K/U9kHjg8H/3LJYjhraMWQRh8cdI3psZv28rebf0MWTZocAQAAoro1DyaOSU20S5lOeCqm0C2Y3h63zA0Yk8UoLC+W3Sj8SdwZc4O3lhF4Af11XgxwEmmkfSYuXUjdiSscMzzUgRk4TDgv3xlGXmXkv70pbJ/evf9HmGEoYyQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179446a9-c92e-40f9-4099-08d86ea52120
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 11:51:17.6489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAL/oaZoAuYPrDPueJ91gybIX07HuxjpJ5X27KUIJ6I6hH0XVeEM2aL82MQvamzMgHp+RvuIGMPHl5HArNfEvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1897
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
Cc: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDEyLCAyMDIw
IDQ6MjQgUE0NClRvOiBQYXRlbCwgTWloaXIgPE1paGlyLlBhdGVsQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IENoYXVoYW4sIE1hZGhhdiA8TWFkaGF2LkNoYXVo
YW5AYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEthbWxpeWEsIFByYWthc2ggPFByYWthc2guS2FtbGl5YUBhbWQuY29tPjsgU3VyYW1wYWxs
aSwgS2lzaG9yZSA8S2lzaG9yZS5TdXJhbXBhbGxpQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIHYzXSBkcm0vYW1kZ3B1OiBBZGQgZGVidWdmcyBlbnRyeSBmb3IgcHJpbnRpbmcgVk0gaW5m
bw0KDQpBbSAxMi4xMC4yMCB1bSAxMjo1MCBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6DQo+IEFt
IDEyLjEwLjIwIHVtIDEyOjAwIHNjaHJpZWIgUGF0ZWwsIE1paGlyOg0KPj4gW0FNRCBPZmZpY2lh
bCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPj4NCj4+DQo+Pg0KPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTIsIDIw
MjAgMzoxNCBQTQ0KPj4gVG86IFBhdGVsLCBNaWhpciA8TWloaXIuUGF0ZWxAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBDYzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRo
YXYuQ2hhdWhhbkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIA0KPj4gPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBTdXJhbXBhbGxpLCBLaXNob3JlIA0KPj4gPEtpc2hvcmUuU3VyYW1w
YWxsaUBhbWQuY29tPjsgS2FtbGl5YSwgUHJha2FzaCANCj4+IDxQcmFrYXNoLkthbWxpeWFAYW1k
LmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRybS9hbWRncHU6IEFkZCBkZWJ1Z2Zz
IGVudHJ5IGZvciBwcmludGluZyBWTSANCj4+IGluZm8NCj4+DQo+PiBbU05JUF0NCj4+PiBIaSBD
aHJpc3RpYW4sDQo+Pj4gT25lIHF1ZXN0aW9uIHJlZ2FyZGluZyBnZXR0aW5nIHRvdGFsIGFsbG9j
YXRpb25zIGJ5IGFwcCBhbmQgYWxzbyANCj4+PiBzd2FwcGVkIHNpemUgZm9yIHRoZSBhcHAuDQo+
Pj4gU2hvdWxkbuKAmXQgd2UgcHJpbnQgbWFwcGVkIGVudHJpZXMgYXMgd2VsbCB0byBnZXQgdG90
YWwgYWxsb2NhdGlvbiBieSANCj4+PiB0aGUgcHJvY2VzcyA/DQo+Pj4gQWxzbyB3aGljaCBsaXN0
IHdvdWxkIHJlcHJlc2VudCBzd2FwcGVkIG1lbW9yeT8NCj4+IE5vbmUsIHdlIGRvbid0IHJlYWxs
eSBoYXZlIHRoYXQgaW5mb3JtYXRpb24gYW55d2hlcmUgc2luY2Ugd2UgZG9uJ3QgDQo+PiByZWFs
bHkgaGF2ZSBhIHN3YXBwZWQgc3RhdGUuDQo+Pg0KPj4gU2VlIHdoZW4gdGhlIGFwcGxpY2F0aW9u
IGFsbG9jYXRlcyBhIEJPIGluIFZSQU0gdGhlIGtlcm5lbCBkcml2ZXIgaXMgDQo+PiBmcmVlIHRv
IHN3YXAgaXQgb3V0IHRvIEdUVCBhbmQgc3RpbGwgZG8gY29tbWFuZCBzdWJtaXNzaW9uLiBPbmx5
IHdoZW4gDQo+PiBpdCBpcyBmdXJ0aGVyIHN3YXBwZWQgb3V0IHRvIHRoZSBDUFUgZG9tYWluIGl0
IGlzIG5vdCBhY2Nlc3NpYmxlIGFueSANCj4+IG1vcmUuDQo+Pg0KPj4gU28gd2hhdCB5b3UgY2Fu
IGRvIGlzIHRvIGxvb2sgYXQgdGhlIEJPcyBpbiB0aGUgQ1BVIGRvbWFpbiwgYnV0IHRoaXMgDQo+
PiBvbmx5IGdpdmVzIHlvdSBhIGNlcnRhaW4gaGludCBvbiB3aGF0J3MgZ29pbmcgb24uDQo+Pg0K
Pj4gUmVnYXJkcywNCj4+IENocmlzdGlhbi4NCj4+DQo+PiBUaGFua3MgQ2hyaXN0aWFuIGZvciBj
bGFyaWZ5aW5nIGFib3V0IHN3YXBwZWQgbWVtb3J5LiBIb3cgYWJvdXQgdG90YWwgDQo+PiBhbGxv
Y2F0ZWQgc2l6ZT8gQ2FuJ3Qgd2UgcHJpbnQgbWFwcGVkIEJPcyBzaW5jZSBhbWRncHVfZ2VtX2lu
Zm8gaXMgDQo+PiBGSUxFL2dlbSBoYW5kbGUgYmFzZWQ/DQo+DQo+IFRoYXQncyB3aGF0IHlvdSBh
cmUgYWxyZWFkeSBwcmludGluZy4gRS5nLiBpZiB5b3Ugc3VtIHVwIGFsbCB0aGUgQk9zIA0KPiBp
biBhbGwgdGhlIGRpZmZlcmVudCBzdGF0ZXMgdGhlbiB5b3UgaGF2ZSB0aGUgdG90YWwgYW1vdW50
IG9mIA0KPiBhbGxvY2F0ZWQgbWVtb3J5IGZvciB0aGlzIHByb2Nlc3MuDQo+DQo+IEV2ZW4gaWYg
c29tZSBvZiB0aGF0IG1lbW9yeSBpc24ndCBtYXBwZWQgaW50byB0aGUgVk0uDQoNClRoaW5raW5n
IGEgYml0IG1vcmUgYWJvdXQgaXQsIHdoZW4geW91IGFsc28gbG9vayBhdCANCmJvLT5wcmVmZXJy
ZWRfZG9tYWlucyBhbmQgY29tcGFyZSB0aGF0IHdpdGggdGhlIGN1cnJlbnQgZG9tYWluIHlvdSBj
YW4NCmFsc28gZmlndXJlIG91dCBpZiBhIEJPIGlzIHN3YXBwZWQgb3V0IG9yIG5vdC4NCg0KQ2hy
aXN0aWFuLg0KDQpUaGFua3MgYWdhaW4gQ2hyaXN0aWFuLiBXZSBhcmUgbW9zdGx5IGludGVyZXN0
ZWQgaW4gR1RUIHRvIENQVSBzd2FwLiBXZSB3b3VsZCBsaWtlIHRvIGFkZCB0aGlzIGluZm8gYXMg
d2VsbCBpbiBmdXR1cmUgcGF0Y2guDQpBZGRyZXNzZWQgb3RoZXIgY29tbWVudHMgaW4gUGF0Y2gg
VjQuDQo+DQo+IENocmlzdGlhbi4NCj4NCj4+IFJlZ2FyZHMsDQo+PiBNaWhpcg0KPj4+IFRoYW5r
cywNCj4+PiBNaWhpcg0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
