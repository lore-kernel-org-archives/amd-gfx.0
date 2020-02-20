Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0BFC11D04
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 08:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A011A207FD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 08:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X1Et5W7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A011A207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433C789DFF;
	Thu, 20 Feb 2020 08:41:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B37089DFF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 08:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq1xwDOXkTeRrSamGz+7p7wsbvwo4LdRV6FXT8IpD38gqPe3+CkaLlrQ2aJW4s/fCf6gweVmdifShypv8oqZ4B+rBwAguo/8w5vw04XDmuV90c8VEYA8t4p3ZTqWfU3we57TeNE0SYY4hoJwjAG0MztwJ7sZ1Spmde2N+lGmoXNCyMbPh0o1GnXd7Wg8ixbKi3ye7ZexZLoUpXB0I+isaejqHWeAPkx9dmVXege/ctoCnn/suPFsKu6cR7IRCPtUgrP4bhixfUlCt+2TM4Fo0Bq5Q/wJCu3AqR8xBpTAyOpWnW4QeXvX/iaBr+5LMV5lsXmjThmPJ5MmcwvzId6HmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTWlonN9VN1PAbRrfKbkRUt75bOx5EFJkm+9D1vcDro=;
 b=DOcDfPGXCvDQQQPhV+MuRJj5CZk2Qf0UR9CQe4DL6/xuF/Kvb8u2jRysFxEjCJ4Aw+JvfoFI1impG0tVHS43vPDWWnclSR4TioyEO+FSS7Vh5YBqc/U34MwsAt5J/LZBnwnAc1X0PXgo3IcNEZ4hVB5ASXx+tp8UsmqpJOz46zTn6MamAXaJlx9VprvaZWIyonBH8h91iI+nF4cwIRc+x1NeEP4jRzAUaafaCKC+gy/QZ9RBp2V6vApbkSR0Epf1Ok1CRBp6sZshRkySXQIUNv+FzXxZRskj0FITeejblxUt7LmIeTR5XTQp0We6XRTNMtmNc0VMura4nT3hAfTkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTWlonN9VN1PAbRrfKbkRUt75bOx5EFJkm+9D1vcDro=;
 b=X1Et5W7sz+u8Oi1wZzpp3F0E6XodmsZaadU1+CQQrOWgzmr6zBBlnucGGeCStVlj3kYhjpQCZNJLovkPywLSmzymT1RgZJ0pHsKvyjjWc02Bx6cqdUs4rVCQnb6UCDfHfToJ4q0AGyew4j0AoQr7leDvUZngeSOOqmrnvyTfkW0=
Received: from MN2PR12MB3167.namprd12.prod.outlook.com (20.179.80.95) by
 MN2PR12MB4517.namprd12.prod.outlook.com (20.180.245.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 20 Feb 2020 08:41:10 +0000
Received: from MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::746d:8d3c:30d3:fd71]) by MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::746d:8d3c:30d3:fd71%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 08:41:09 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Thread-Index: AQHV5tnD+HE6O3FRpEGArZnh3CNUt6giDTsAgABJroCAAAshgIABVmeg
Date: Thu, 20 Feb 2020 08:41:09 +0000
Message-ID: <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-20T08:41:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=07d59223-3cd1-4cdc-9e57-0000c5aac1ea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-20T08:41:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 73d5683a-2513-48aa-aeba-0000f2edf5fd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Li@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 548fb51e-3179-4e9a-db21-08d7b5e0a273
x-ms-traffictypediagnostic: MN2PR12MB4517:|MN2PR12MB4517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4517B4FCAA9D05AAF9F15933ED130@MN2PR12MB4517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(55016002)(9686003)(478600001)(45080400002)(86362001)(5660300002)(52536014)(110136005)(6636002)(966005)(33656002)(7696005)(53546011)(6506007)(8936002)(71200400001)(81166006)(81156014)(8676002)(64756008)(186003)(2906002)(76116006)(26005)(66476007)(66556008)(66946007)(316002)(66446008)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4517;
 H:MN2PR12MB3167.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5J2wlF36adqO4FMQSf4XrirjxM+DVXajGQJ2FRKPWa2gS4nTvpRDeUrrXA1Qkp6R38aaacWy+hO6PQRqkUI4Pq7yg/a84vUQYu7iXRVseAD+GX8xtlbKqGnQ2YtZ91P7ETMKHeeahwfugLntYuOBQXkZA1BcjzUqcUudu5DTf8DJ0lM4l+8TsbsKK7wo2Dv9sv4ghgmPZnBaTlTixFM/TO2DqGmXgVT/RogaOSGHkBO1lWwh9gvPEPNcQu0fsNyUYPOdBoCCE6WuGqCosAmhBQorciTOyRCcrl/GQIix007L+6D7J144a/Ecm3KwNu3EkiMaB1b2+jxzc02Y6vfIwGfr9SzAM32WV/+DFxboKy6t2Sz2Q4oqCVGmdmcJukyHxlFpYAOW6W92l9KxEs30RIi+Wz9huPAF6Cq/S7s+m0B2i8UW7V939dv4d0JYp7VlhKoPr5VcAmnySeZGl3XY2KDyqv2eaya7PVhtwueAC7JBT9WvNyMyJcdI4o5+IIsyz/9iXiwiVC3u3fEvMtBHT0OdZTF7Qn8U/xyYssAFCLU2BkusGaf1aTtjKIM6GpsOwB+uaJSBuGFHo7662LY9P99wPjOY0Li2yMYV0S3QZ6g2RQ0eurTg7UIeMHBMOuyrEQOX5o5ImDpmY3N0OYNmlbV27K+EsfHeFlNHdwfnpXJu5zdgjGILUAp0DGZbgzsC
x-ms-exchange-antispam-messagedata: LKlxg06YPNyjfmu7jDZKqKbpPVpn9DhqrvLR+AmNW/r0aCj1x7/kE2okb2N0cf1uiqOp52FuUrdoVSFfClhHkUOjPDEdITgvJuiB83lOTCT/GkvlwUl2OV99gnFGC/aWMfDgDe75wzRD2XqYP4ux8w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548fb51e-3179-4e9a-db21-08d7b5e0a273
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 08:41:09.8058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cAoomUt8W97IBkebTyVBA9MvUCjooBqK3SkQlr4VQ0FgsqW3UI+N692VJW69rh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgQ2hyaXN0aWFuIGFuZCBNb25rLA0KICAgICAgV2hlbiBkb2luZyBTRE1BIGNvcHksIGEgUkFT
IHVuY29ycmVjdGFibGUgZXJyb3IgaGFwcGVucywgd2hpY2ggd2lsbCBjYXVzZSB0aGlzIGlzc3Vl
LiAgVGhlIFJBUyB1bmNvcnJlY3RhYmxlIGVycm9yIGV2ZW50IHdpbGwgdHJpZ2dlciBkcml2ZXIg
dG8gZG8gQkFDTyByZXNldCB3aGljaCB3aWxsIHNldCB0aGUgc3RhdHVzIG9mIFNETUEgc2NoZWR1
bGVyIHRvIG5vIHJlYWR5LiBBbmQgdGhlbiBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVlX3NjaGVk
IHdpbGwgcmV0dXJuIE5VTEwgaW4gZHJtX3NjaGVkX2VudGl0eV9zZWxlY3RfcnEsIHdoaWNoIGNh
dXNlIGVudGl0eS0+cnEgdG8gTlVMTC4gDQoNCkJlc3QgUmVnYXJkcw0KRGVubmlzIExpDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PiANClNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTksIDIwMjAgNzozMCBQTQ0KVG86IEtvZW5p
ZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgTGksIERlbm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBDaGVu
LCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQpTdWJqZWN0OiDlm57lpI06IFtQQVRDSF0g
ZHJtL2FtZGdwdTogZml4IGEgYnVnIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KDQo+ICsJaWYg
KCFlbnRpdHktPnJxKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KDQpZZXMsIHN1cHBvc2VkbHkgd2Ug
c2hvdWxkbid0IGdldCAnZW50aXR5LT5ycSA9PSBOVUxMJyBjYXNlICwgdGhhdCBsb29rcyB0aGUg
dHJ1ZSBidWcgDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g5Luj6KGoIENocmlzdGlhbiBL
P25pZw0K5Y+R6YCB5pe26Ze0OiAyMDIw5bm0MuaciDE55pelIDE4OjUwDQrmlLbku7bkuro6IFpo
YW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMu
TGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCuS4u+mimDogUmU6
IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGEgYnVnIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0K
DQpXZWxsIG9mIGhhbmQgdGhpcyBwYXRjaCBsb29rcyBsaWtlIGEgY2xlYXIgTkFLIHRvIG1lLg0K
DQpSZXR1cm5pbmcgd2l0aG91dCByYWlzaW5nIGFuIGVycm9yIGlzIGNlcnRhaW5seSB0aGUgd3Jv
bmcgdGhpbmcgdG8gZG8gaGVyZSBiZWNhdXNlIHdlIGp1c3QgZHJvcCB0aGUgbmVjZXNzYXJ5IHBh
Z2UgdGFibGUgdXBkYXRlcy4NCg0KSG93IGRvZXMgdGhlIGVudGl0eS0+cnEgZW5kcyB1cCBhcyBO
VUxMIGluIHRoZSBmaXJzdCBwbGFjZT8NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KQW0gMTku
MDIuMjAgdW0gMDc6MjYgc2NocmllYiBaaGFuZywgSGF3a2luZzoNCj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiBSZXZpZXdlZC1ieTog
SGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPg0KPiBSZWdhcmRzLA0KPiBI
YXdraW5nDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERlbm5pcyBMaSA8
RGVubmlzLkxpQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTksIDIwMjAg
MTI6MDUNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXIgDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpo
b3UxQGFtZC5jb20+OyBaaGFuZywgDQo+IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47
IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gQ2M6IExpLCBEZW5uaXMgPERl
bm5pcy5MaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBhIGJ1
ZyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4NCj4gY2hlY2sgd2hldGhlciB0aGUgcXVldWUg
b2YgZW50aXR5IGlzIG51bGwgdG8gYXZvaWQgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KPg0K
PiBDaGFuZ2UtSWQ6IEkwOGQ1Njc3NDAxMmNmMjI5YmEyZmU3YTAxMWMxMzU5ZThkMWUyNzgxDQo+
IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+DQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYw0KPiBpbmRleCA0Y2M3
ODgxZjQzOGMuLjY3Y2NhNDYzZGRjYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+IEBAIC05NSw2ICs5NSw5IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwNCj4g
ICAJaW50IHI7DQo+ICAgDQo+ICAgCWVudGl0eSA9IHAtPmRpcmVjdCA/ICZwLT52bS0+ZGlyZWN0
IDogJnAtPnZtLT5kZWxheWVkOw0KPiArCWlmICghZW50aXR5LT5ycSkNCj4gKwkJcmV0dXJuIDA7
DQo+ICsNCj4gICAJcmluZyA9IGNvbnRhaW5lcl9vZihlbnRpdHktPnJxLT5zY2hlZCwgc3RydWN0
IGFtZGdwdV9yaW5nLCBzY2hlZCk7DQo+ICAgDQo+ICAgCVdBUk5fT04oaWItPmxlbmd0aF9kdyA9
PSAwKTsNCj4gLS0NCj4gMi4xNy4xDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3QNCj4gcy5mcmVlZGVza3RvcC5vcmclMkZt
YWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Ntbw0KPiBuay5s
aXUlNDBhbWQuY29tJTdDMjhlNzI2MGFmM2EyNGVlYzc1OGYwOGQ3YjUyOTc1ZTMlN0MzZGQ4OTYx
ZmU0ODg0ZTYwDQo+IDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3NzA2MjAwMzIxMzQz
MSZhbXA7c2RhdGE9dk1YbWh3VGxOOGxBYXYNCj4gdXFoWWhwbUtMTTZWJTJGJTJCMiUyRnViRkJi
c2slMkJHWSUyQmp3JTNEJmFtcDtyZXNlcnZlZD0wDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQw
YW1kLmNvbSU3QzI4ZTcyNjBhZjNhMjRlZWM3NThmMDhkN2I1Mjk3NWUzJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3NzA2MjAwMzIxMzQzMSZhbXA7c2Rh
dGE9dk1YbWh3VGxOOGxBYXZ1cWhZaHBtS0xNNlYlMkYlMkIyJTJGdWJGQmJzayUyQkdZJTJCancl
M0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
