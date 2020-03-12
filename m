Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8AC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 11:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5D620716
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 11:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fi95tFWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5D620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA766E1B3;
	Thu, 12 Mar 2020 11:30:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8B96E1B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 11:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6V/SazugCy7PIJHTIWUmT+YFNknvOXzJ9LXCKH8c88wet1x7DBWmcN65uxiOaa5VfksXZarXA5qAtzTTLG9gMix6BcTAwkrUPi5sr7eQgqJvULuKObfZfYEm5Pzo9g8qbKevgEJ61KWTq3/9mnQXIvmtvf+Y7tZneMEp0Oeqa3D6fZDFcliNFW3K05/AL0qAgcsZ+q4rpp8Mym8CbIE9t3OWxSu73LFkIlYAnaQEnsWDGr/AlaWHERpQjw15iBO1Mon9m4lVY2Lb+q2nUiL+cXZHq2CP/tVIynF9cetuZyV2Ss/VoU6nYcGoXl5H4O33ykBFYxDTyJgVqlwQMwgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo/IywF3BZDxuwcqIF/WemLlU1ThRuQoFKk9JGEyfEQ=;
 b=fwpnPd5NgTug4dWJJyruAotKe13AC8QlCxaYT4Ae63vzKHc5h2NXmx76lSFpd7i3RZz73uGVk2Pj2Ua4fwdMy1oqQgWEh68SEcp8jsRYVxbv5ZkV2GhrKpfhPdmlj0Z0DHswUB6E8Boo0CTJwb2DuITJWJaLcqOmiI7VJa1EFAQ/QdqdXaXLip8aPPEzh02SRk8cDegldlWo6HsXMwPWxhEI7CTvMtumr5Q7ral4waNb6TRc3yYTpMz84iAAd5A2OLXecgz/FBuDpXMJK2kICopo9QevPiOdlAS63ruKwCdsYl3WqRZvamOl6MbjbHVcAPYxwiSdTwxT++5erzQyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo/IywF3BZDxuwcqIF/WemLlU1ThRuQoFKk9JGEyfEQ=;
 b=fi95tFWjhfEmRLcLGcwdGZCOpl1pZ7WByF7YGgy2UwCMnR8hLSz4hcoTuWpG09EoNpEU/iGonntia6J1fJWCHQvzF5wXHVHqtNS1JJZpWQFah/TT3JYzXmkr1y2lkNr7TMeXR4aSgQK/QJv/d4OHJBkyHQ5/vWQQKfV59KyLidY=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 12 Mar
 2020 11:30:26 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 11:30:26 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Thread-Topic: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Thread-Index: AQHV+F8U5L7Se/dMEkmUhlnvgqMGdahE0m3Q
Date: Thu, 12 Mar 2020 11:30:26 +0000
Message-ID: <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200312111203.81500-1-christian.koenig@amd.com>
In-Reply-To: <20200312111203.81500-1-christian.koenig@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b37df705-297d-4ea9-55d1-08d7c678c308
x-ms-traffictypediagnostic: MN2PR12MB3757:|MN2PR12MB3757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3757A481FEF0D0CAE840AEA284FD0@MN2PR12MB3757.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(5660300002)(2906002)(8676002)(7696005)(110136005)(71200400001)(86362001)(52536014)(33656002)(186003)(6506007)(53546011)(8936002)(966005)(9686003)(45080400002)(478600001)(26005)(76116006)(81166006)(81156014)(66556008)(55016002)(316002)(66946007)(66574012)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3757;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omHEbcoZoO9zNQq7zKgT7GHQQ83N3H/4O/K8PRNzL2xMpuTO+Llfb2k5ISO8yDKKNkt7rszXJmUyCNtCMD5MgJZUyVP8dihtMTKQSgHsE2d2qXWYjjZGgnz66WKgEH1tfMoy3Qazt7QsibitXdcheeaumsZm71dE2i6T7dadurJZtMSIIBFmoIF0RN+FCcpLHNULVqp4dOqrZ33hSUWu4rDtZLKKc4oQfXbi9Aik4RX8xTd+Rf/Bu8u3+oeLIFVbjF3/y3J4LeoazwlR16MQOFRi05XRHwdIZfjrsdlgeeAr6S6ERzmlTW9pF/SFnr7MP5ntSg5eZTef1aD+/6TPg3VDNmhDgOBik3wy+COMypcB3Ii8mTeAXgimhTv5BeuibmzToH4iUv23YrIjdySNpvSD1lt18Zv+R1OuGJycZ04G07QsFuUEzOSz94aQxKEJBYIcgHFxXhrfx+tbSeNgCAKOB8nJ3MsQWYoYTE1JKVk=
x-ms-exchange-antispam-messagedata: 2Y87wDbTdL3TaQriHh1Ka8r23A2v//1FNLB+9EbhBQ0Mj7/7ttgVM5v3G0XEOyi1dG1z5sfxWzKtdp+pkCB29wtrNdncFFKex4kld2oE9ynHFIUUHT6lvzYPlfsR6j5X8DcwbwoOrNadXy45PHcx5w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37df705-297d-4ea9-55d1-08d7c678c308
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 11:30:26.5653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47xl50vbooRHrKwnKVHtpGe8Sl9x60HR0K5XbQRz7bgZv6CWHe+nYObC/XFK1/ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
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

Q2FuIHlvdSBnaXZlIG1vcmUgZGV0YWlscyBhYm91dCAiIHdlIGNhbid0IGd1YXJhbnRlZSB0aGUg
dGhlIGNsZWFyIGZlbmNlIHdpbGwgY29tcGxldGUgYWZ0ZXIgdGhlIGV4Y2x1c2l2ZSBvbmUuIiA/
DQoNClRoYW5rcyANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9u
ayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPiBPbiBCZWhhbGYgT2YgQ2hyaXN0aWFuIEs/bmlnDQpTZW50OiBUaHVyc2RheSwgTWFy
Y2ggMTIsIDIwMjAgNzoxMiBQTQ0KVG86IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1k
Z3B1OiBmaXggYW5kIGNsZWFudXAgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2UNCg0KVGhlIHByb2Js
ZW0gaXMgdGhhdCB3ZSBjYW4ndCBhZGQgdGhlIGNsZWFyIGZlbmNlIHRvIHRoZSBCTyB3aGVuIHRo
ZXJlIGlzIGFuIGV4Y2x1c2l2ZSBmZW5jZSBvbiBpdCBzaW5jZSB3ZSBjYW4ndCBndWFyYW50ZWUg
dGhlIHRoZSBjbGVhciBmZW5jZSB3aWxsIGNvbXBsZXRlIGFmdGVyIHRoZSBleGNsdXNpdmUgb25l
Lg0KDQpUbyBmaXggdGhpcyByZWZhY3RvciB0aGUgZnVuY3Rpb24gYW5kIHdhaXQgZm9yIGFueSBw
b3RlbnRpYWwgZXhjbHVzaXZlIGZlbmNlIHdpdGggYSBzbWFsbCB0aW1lb3V0IGJlZm9yZSBhZGRp
bmcgdGhlIHNoYXJlZCBjbGVhciBmZW5jZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNDEgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KaW5kZXggNDI3NzEyNWE3OWVlLi4wNzgy
MTYyZmI1ZjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KQEAg
LTE2MSwxMCArMTYxLDExIEBAIHZvaWQgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2Uoc3RydWN0IGRy
bV9nZW1fb2JqZWN0ICpvYmosDQogDQogCXN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSB2bV9w
ZDsNCiAJc3RydWN0IGxpc3RfaGVhZCBsaXN0LCBkdXBsaWNhdGVzOw0KKwlzdHJ1Y3QgZG1hX2Zl
bmNlICpmZW5jZSA9IE5VTEw7DQogCXN0cnVjdCB0dG1fdmFsaWRhdGVfYnVmZmVyIHR2Ow0KIAlz
dHJ1Y3Qgd3dfYWNxdWlyZV9jdHggdGlja2V0Ow0KIAlzdHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192
YTsNCi0JaW50IHI7DQorCWxvbmcgcjsNCiANCiAJSU5JVF9MSVNUX0hFQUQoJmxpc3QpOw0KIAlJ
TklUX0xJU1RfSEVBRCgmZHVwbGljYXRlcyk7DQpAQCAtMTgyLDI0ICsxODMsMzIgQEAgdm9pZCBh
bWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwNCiAJCXJl
dHVybjsNCiAJfQ0KIAlib192YSA9IGFtZGdwdV92bV9ib19maW5kKHZtLCBibyk7DQotCWlmIChi
b192YSAmJiAtLWJvX3ZhLT5yZWZfY291bnQgPT0gMCkgew0KLQkJYW1kZ3B1X3ZtX2JvX3Jtdihh
ZGV2LCBib192YSk7DQorCWlmICghYm9fdmEgfHwgLS1ib192YS0+cmVmX2NvdW50KQ0KKwkJZ290
byBvdXRfdW5sb2NrOw0KIA0KLQkJaWYgKGFtZGdwdV92bV9yZWFkeSh2bSkpIHsNCi0JCQlzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7DQorCWFtZGdwdV92bV9ib19ybXYoYWRldiwgYm9f
dmEpOw0KKwlpZiAoIWFtZGdwdV92bV9yZWFkeSh2bSkpDQorCQlnb3RvIG91dF91bmxvY2s7DQog
DQotCQkJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsNCi0JCQlp
ZiAodW5saWtlbHkocikpIHsNCi0JCQkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xl
YXIgcGFnZSAiDQotCQkJCQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwgcik7
DQotCQkJfQ0KIA0KLQkJCWlmIChmZW5jZSkgew0KLQkJCQlhbWRncHVfYm9fZmVuY2UoYm8sIGZl
bmNlLCB0cnVlKTsNCi0JCQkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQotCQkJfQ0KLQkJfQ0KLQl9
DQorCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7DQorCWlmIChy
IHx8ICFmZW5jZSkNCisJCWdvdG8gb3V0X3VubG9jazsNCisNCisJciA9IGRtYV9yZXN2X3dhaXRf
dGltZW91dF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIGZhbHNlLCBmYWxzZSwNCisJCQkJICAgICAg
bXNlY3NfdG9famlmZmllcygxMCkpOw0KKwlpZiAociA9PSAwKQ0KKwkJciA9IC1FVElNRURPVVQ7
DQorCWlmIChyKQ0KKwkJZ290byBvdXRfdW5sb2NrOw0KKw0KKwlhbWRncHVfYm9fZmVuY2UoYm8s
IGZlbmNlLCB0cnVlKTsNCisJZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQorDQorb3V0X3VubG9jazoN
CisJaWYgKHVubGlrZWx5KHIpKQ0KKwkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xl
YXIgcGFnZSAiDQorCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNsb3NlICglZClcbiIsIHIpOw0K
IAl0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7ICB9DQogDQotLQ0K
Mi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQwYW1kLmNvbSU3QzM4MjZjZDAyOWM5YTRk
MDA2MTcwMDhkN2M2NzYzNDMzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzE5NjA4MzMyMDkxMDc2OCZhbXA7c2RhdGE9MWpDSU5KTHpiWWhYeDlhdDUlMkZV
JTJGWDZkNjQ3NkZoYmhVWVpyczUzQVJTQVklM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
