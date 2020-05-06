Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C7BC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 07:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1111220721
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 07:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kHbQDNQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1111220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A511F89A32;
	Wed,  6 May 2020 07:26:22 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690071.outbound.protection.outlook.com [40.107.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE2E89A0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 07:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLdAuX5aBb3U5o1JWki3i5sRc50noysNIxp7zdG3rZZX3x7f1ViKk6nX3mprKko+wEbMZUegoCbsUpXpDfQA5LzJaNFVgzgK5UpLU5upllDKCp59H/3y3/aYBkD8nrT7vuJbo2i3WI10T8R8ew0iDwW20vPPNk6fWl5hcJ+0GxOuOUvvOKXk1Mj7M36vIRY3Ys9z6QIcrscuAd5CSIQs2P4OPHM0cVNeGI5WcI161tDEpr9oChqnxhTMSvYagCWQvjKE63C0zpr5q+rboRtpfafdE+uz5lrFmviaiO1xNzbmosiU7TaxAASVJn4BjnNi4R172BlIMkfnHHSadpjA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh2ENP0gK0znj4gsAZ07yJw8/OBblg9PSL2Zqwsi89I=;
 b=AJ/DkjTPHjz1Th1GbnY/8ZBK58IpWj0qBvytrdxurG2lETV4ZwD2EfpOIqCej407DULV67DmEpn6+6ke7yzGAS8m8u8PGha5ktjSbQITusLKyzeNLqasH9YECO3T3fY3PElFSxFBTU+gdGDkfDdZaxLaj1ttDEBhTbOUCHvnASEDQGihJQHVj/IhTw0AFZ6NL8aXp9fxXbskob3ljfF7uMyCQxgIXd7ghwteoJJ44D1VELg3z4OEbddfpE1KrX45dKPf1JwtA7sE9GXCcB1ixg2CLjzEVW8id0+ZIqBuWPzt164gNoV52wp2INe2laX9tEMkim0nbx8gtBE6SdbC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh2ENP0gK0znj4gsAZ07yJw8/OBblg9PSL2Zqwsi89I=;
 b=kHbQDNQRrGmkRZGwnN0UoE3B/hD2CDW2kY9ObzHbQJ3MuXKHYNnFV50DdUOUh2HKeVWufhKFVCXDrOpb1j5wZjNZE9VblgfL0Kgi7DOgZ2+rG/eGQ+Jw1mv9c1Nmp6F4/NH+ewp+JiHBw5MMD+heoi8THijltoA1knO/rSiCmgM=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 07:26:17 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 07:26:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: RE: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Thread-Topic: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Thread-Index: AQHWIr1cCV9AMtYmuE+erEhNhPuMnqianwRg
Date: Wed, 6 May 2020 07:26:16 +0000
Message-ID: <BYAPR12MB288896162E5761D45A5077DFB0A40@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200505091239.GA117990@mwanda>
In-Reply-To: <20200505091239.GA117990@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-06T06:52:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dd1e01a6-bf40-44fe-82ce-000088dd37e2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-06T07:00:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 75bd27cf-877d-470d-802e-00006948942d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.232.44.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f44d9b2-5123-4a69-01e9-08d7f18ec3e7
x-ms-traffictypediagnostic: BYAPR12MB2901:|BYAPR12MB2901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29014A43B011326FFB46C4A3B0A40@BYAPR12MB2901.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEhKrlJkWiTvwZ8moTKc3DqsaP8fdDH6ZfG76VlJc7qvaqxoMDyHxfljlrf9DX4LFxgaWCwJ10HGTsnxFZCcKUV2TXLhZK7H2YflsnAWAc4JXjgzgvx4U9f7dJehp+i+5RkMAzUddNs1FHHBHm6RdFNw8bkq+cjTy11EeSHFYsp8J3cjhvghDp6hiYFdiqtWrTgGRjlHl5BB7b2NnHHOhBiy+cQFH1ZyJySqHA2eK5NxU8mPTJGP9F9oTAj/sj4SMBI7aOZxth31YDO5p3HJJ8CC7pD+pxVE4TF1MSb/WJ8t7FowI7iah1ki0HVdyjEDx1VeKIk7P3zaiXkm1wz/D+ZdLD5jzIBv594lNLvV92KAPFTPBvnj8zqGpwm2ZBiPGJeDDASzQWO7Xo2OMRScWGxGgosCVIsRckCJWFi2lENFOZMIjF2KT0fDv6HJUFO1BTnD6bmfg83Ndp6MtUvb6ys/8QbuIpfDJd584vZz8/+9WW3x+L23bTds66sfMvCzZKifotLL2zq+Y0snvfTpNj0DYrWDQcfYnWjyOtzDTS/trmcjpboiFfk6wJFjGE+W00B1iJ6RaM9HsxrDX/kMaEdJr8lf6Y334gWA7aX9XKhgiV5/gydPYJ585qTtBeoM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(33430700001)(86362001)(8936002)(55016002)(9686003)(33656002)(53546011)(966005)(478600001)(76116006)(45080400002)(8676002)(66446008)(64756008)(66556008)(66946007)(66476007)(52536014)(7696005)(110136005)(6506007)(186003)(26005)(6636002)(2906002)(5660300002)(33440700001)(4326008)(316002)(83080400001)(71200400001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wYtwr719PgNm6uy50aL4xkgzx5MNQT6/7rS5+YOwGXPkXPaTxHEKFjHb91Q0LgKQWi/Yehs2qREHhXPrYzOdGYx3+8jFMV0cYA60N6NXDTCkxZkk05J/So4DpQOSASFGqGe1H1uLKBrG0vg8ehc0tNqbSIHEgLz7mCWnvx66FMw3IBjFxnO1UUUVAYCocLkhxiRAphy+VAiJcGnKrOYVN/idmRbNiFRNYchiatO7fSfrfT+FySUL0y09mhONL1pzYoMk/XunYxAzM2VYZHvu8SkW+v6jxCbaHyx/gpjE2HUK1Zx6lLzlmJjnDWGXFYGAhLgGUtucv4W3YYfRbfZg29FKKntPfn7aZF15iWUYvVouu9PSbCPVQUKVVaa7iR4Mbfr3fsZigL1S/ZkX+eTSiJr9bZOio8TV8IvLWmNWmpWkUutkKP6orNr8Q+kg2bGYQ8lPQ20Uwz+ngtxDIpRSh4mqHRp7EPM92sWnEG3nVq5QbVd2XM3HKKTIA9s/zmK2Sm5Kndj2RobmtyLYUaebeHCqMBt/8+mfpMwMPYEUFssdjBSAsakln0R2QJghNa4+K6KygjchM+9JM2sJVqBKFx+vr2TGWtWQLYI4l9+KNlZ3f4K5IaoLCtD4hdlbwwOLri7tWAKOxrGWnuTOvBEBqIo5inU/Eq4vm5LDd8tI45mXvbNTX+MD7r/ii7xjkE3Sf3bZfCArPSF2wO7DZx1fF5J+7cfHVl0HsAbXivCI8y9csSWq9aM/16V2tBPqKJPbgJ3jAs+VYiVQpVQvU2Cq6qxB/391xdwDO3vXULz/1+Q=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f44d9b2-5123-4a69-01e9-08d7f18ec3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 07:26:16.9261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFBsWwsKiUI/zgZk0m1qj4o1DQ6NIE9+HK+8+/T/f3sN7k7jB8WXmUeyfno6qP/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpIaSBEYW46DQoNClBsZWFzZSBjaGVjayB0aGUgZm9sbG93aW5n
IHBpZWNlIG9mIGNvZGUgaW4gYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2N0cmxfcGFyc2VfZGF0YToNCg0K
CWlmIChvcCAhPSAtMSkgew0KCQlpZiAoYW1kZ3B1X3Jhc19maW5kX2Jsb2NrX2lkX2J5X25hbWUo
YmxvY2tfbmFtZSwgJmJsb2NrX2lkKSkNCgkJCXJldHVybiAtRUlOVkFMOw0KDQoJCWRhdGEtPmhl
YWQuYmxvY2sgPSBibG9ja19pZDsNCg0KYW1kZ3B1X3Jhc19maW5kX2Jsb2NrX2lkX2J5X25hbWUg
d2lsbCByZXR1cm4gZXJyb3IgZGlyZWN0bHkgaWYgc29tZW9uZSB0cnkgdG8gcHJvdmlkZSBhbiBp
bnZhbGlkIGJsb2NrX25hbWUgaW50ZW50aW9uYWxseSB2aWEgZGVidWdmcy4NCg0KUmVnYXJkcywN
ClRhbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFt
ZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBEYW4NCj4g
Q2FycGVudGVyDQo+IFNlbnQ6IDIwMjDE6jXUwjXI1SAxNzoxMw0KPiBUbzogUGFuLCBYaW5odWkg
PFhpbmh1aS5QYW5AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IFN1YmplY3Q6IFtidWcgcmVwb3J0XSBkcm0vYW1kZ3B1OiBhZGQgYW1kZ3B1X3Jhcy5jIHRv
IHN1cHBvcnQgcmFzICh2MikNCj4gDQo+IEhlbGxvIHhpbmh1aSBwYW4sDQo+IA0KPiBUaGUgcGF0
Y2ggYzAzMGYyZTQxNjZjOiAiZHJtL2FtZGdwdTogYWRkIGFtZGdwdV9yYXMuYyB0byBzdXBwb3J0
IHJhcw0KPiAodjIpIiBmcm9tIE9jdCAzMSwgMjAxOCwgbGVhZHMgdG8gdGhlIGZvbGxvd2luZyBz
dGF0aWMgY2hlY2tlcg0KPiB3YXJuaW5nOg0KPiANCj4gCWRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYzo2MjANCj4gYW1kZ3B1X3Jhc19mZWF0dXJlX2VuYWJsZSgpDQo+IAl3
YXJuOiB1bmNhcHBlZCB1c2VyIGluZGV4ICdyYXNfYmxvY2tfc3RyaW5nW2hlYWQtPmJsb2NrXScN
Cj4gDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiAgICA1ODcg
IGludCBhbWRncHVfcmFzX2ZlYXR1cmVfZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPiAgICA1ODggICAgICAgICAgICAgICAgICBzdHJ1Y3QgcmFzX2NvbW1vbl9pZiAqaGVhZCwg
Ym9vbCBlbmFibGUpDQo+ICAgIDU4OSAgew0KPiAgICA1OTAgICAgICAgICAgc3RydWN0IGFtZGdw
dV9yYXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7DQo+ICAgIDU5MSAgICAg
ICAgICB1bmlvbiB0YV9yYXNfY21kX2lucHV0IGluZm87DQo+ICAgIDU5MiAgICAgICAgICBpbnQg
cmV0Ow0KPiAgICA1OTMNCj4gICAgNTk0ICAgICAgICAgIGlmICghY29uKQ0KPiAgICA1OTUgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgNTk2DQo+ICAgIDU5NyAgICAgICAg
ICBpZiAoIWVuYWJsZSkgew0KPiAgICA1OTggICAgICAgICAgICAgICAgICBpbmZvLmRpc2FibGVf
ZmVhdHVyZXMgPSAoc3RydWN0IHRhX3Jhc19kaXNhYmxlX2ZlYXR1cmVzX2lucHV0KQ0KPiB7DQo+
ICAgIDU5OSAgICAgICAgICAgICAgICAgICAgICAgICAgLmJsb2NrX2lkID0gIGFtZGdwdV9yYXNf
YmxvY2tfdG9fdGEoaGVhZC0+YmxvY2spLA0KPiAgICA2MDAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC5lcnJvcl90eXBlID0gYW1kZ3B1X3Jhc19lcnJvcl90b190YShoZWFkLT50eXBlKSwNCj4g
ICAgNjAxICAgICAgICAgICAgICAgICAgfTsNCj4gICAgNjAyICAgICAgICAgIH0gZWxzZSB7DQo+
ICAgIDYwMyAgICAgICAgICAgICAgICAgIGluZm8uZW5hYmxlX2ZlYXR1cmVzID0gKHN0cnVjdCB0
YV9yYXNfZW5hYmxlX2ZlYXR1cmVzX2lucHV0KQ0KPiB7DQo+ICAgIDYwNCAgICAgICAgICAgICAg
ICAgICAgICAgICAgLmJsb2NrX2lkID0gIGFtZGdwdV9yYXNfYmxvY2tfdG9fdGEoaGVhZC0+Ymxv
Y2spLA0KPiAgICA2MDUgICAgICAgICAgICAgICAgICAgICAgICAgIC5lcnJvcl90eXBlID0gYW1k
Z3B1X3Jhc19lcnJvcl90b190YShoZWFkLT50eXBlKSwNCj4gICAgNjA2ICAgICAgICAgICAgICAg
ICAgfTsNCj4gICAgNjA3ICAgICAgICAgIH0NCj4gICAgNjA4DQo+ICAgIDYwOSAgICAgICAgICAv
KiBEbyBub3QgZW5hYmxlIGlmIGl0IGlzIG5vdCBhbGxvd2VkLiAqLw0KPiAgICA2MTAgICAgICAg
ICAgV0FSTl9PTihlbmFibGUgJiYgIWFtZGdwdV9yYXNfaXNfZmVhdHVyZV9hbGxvd2VkKGFkZXYs
DQo+IGhlYWQpKTsNCj4gICAgNjExICAgICAgICAgIC8qIEFyZSB3ZSBhbGVyYWR5IGluIHRoYXQg
c3RhdGUgd2UgYXJlIGdvaW5nIHRvIHNldD8gKi8NCj4gICAgNjEyICAgICAgICAgIGlmICghKCEh
ZW5hYmxlIF4gISFhbWRncHVfcmFzX2lzX2ZlYXR1cmVfZW5hYmxlZChhZGV2LCBoZWFkKSkpDQo+
ICAgIDYxMyAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICA2MTQNCj4gICAgNjE1ICAg
ICAgICAgIGlmICghYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7DQo+ICAgIDYxNiAgICAg
ICAgICAgICAgICAgIHJldCA9IHBzcF9yYXNfZW5hYmxlX2ZlYXR1cmVzKCZhZGV2LT5wc3AsICZp
bmZvLCBlbmFibGUpOw0KPiAgICA2MTcgICAgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ICAg
IDYxOCAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3Jhc19wYXJzZV9zdGF0dXNfY29k
ZShhZGV2LA0KPiAgICA2MTkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZW5hYmxlID8gImVuYWJsZSI6ImRpc2FibGUiLA0KPiAgICA2MjAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFzX2Js
b2NrX3N0cihoZWFkLT5ibG9jayksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eIFRo
ZSBoZWFkLT5ibG9jaw0KPiB2YWx1ZSBjYW4gYmUgc2V0IHRvIGFueXRoaW5nIHVzaW5nIGRlYnVn
ZnMuICBUaGF0J3MgYSBwcm9ibGVtIGJlY2F1c2UgaXQNCj4gY291bGQgZWFzaWx5IGxlYWQgdG8g
YSBrZXJuZWwgcGFuaWMgKHdoaWNoIGlzDQo+IGFubm95aW5nKSBhbmQgYWxzbyBiZWNhdXNlIHRo
ZXNlIGRheXMgd2UgdHJ5IHRvIHJlc3RyaWN0IHdoYXQgcm9vdCBjYW4gZG8uDQo+IA0KPiAgICA2
MjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
ZW51bSB0YV9yYXNfc3RhdHVzKXJldCk7DQo+ICAgIDYyMiAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKHJldCA9PSBUQV9SQVNfU1RBVFVTX19SRVNFVF9ORUVERUQpDQo+ICAgIDYyMyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVBR0FJTjsNCj4gICAgNjI0ICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgNjI1ICAgICAgICAg
ICAgICAgICAgfQ0KPiAgICA2MjYgICAgICAgICAgfQ0KPiAgICA2MjcNCj4gICAgNjI4ICAgICAg
ICAgIC8qIHNldHVwIHRoZSBvYmogKi8NCj4gICAgNjI5ICAgICAgICAgIF9fYW1kZ3B1X3Jhc19m
ZWF0dXJlX2VuYWJsZShhZGV2LCBoZWFkLCBlbmFibGUpOw0KPiAgICA2MzANCj4gICAgNjMxICAg
ICAgICAgIHJldHVybiAwOw0KPiAgICA2MzIgIH0NCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBjYXJw
ZW50ZXINCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZg0KPiByZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N0YW8uemhvdTElNDBhbWQuY29tJTdD
ZDk5MjVlY2E3NjMxNDkxODANCj4gZWE1MDhkN2YwZDQ3Y2ZlJTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYNCj4gMzcyNDI2Njc3NTQ4OTIzOTYmYW1wO3NkYXRh
PWslMkZNVGd6OUQxaklKR1JGQnUyWXV1Nnd1SFAlMkJQYlINCj4gdkVjTkpwODdzbElKRSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
