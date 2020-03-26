Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12945C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D765120714
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZIlPNyjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D765120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC156E277;
	Thu, 26 Mar 2020 06:42:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D556E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 06:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/9nuE7M8NAqIEtRLXUpOJmVSl+3llJK4B+1MDzkGIxUpni2DKh0WIZhlsAtPzAmWqMMwgV1it5WWDAJnMTVofiam/TmDat/QpRXFvn2B2NrzuJO899sL83ZkcvOr42FRQLMMHPhomJgfqY5iltwedQYsBvGfPdaxkZh1on9gzQ3k0fGng8cI4mWxQz3xS0jUamBcFlTilMnZkDyGfHA4/zUxktJ+Gr3bMGZTHvRLZKFZw4MjoGvh06ti7+x1rd2o8G8HKET9j3dINbbdkPh6YpK8Bpl9ADfY3BYk5dAZ9GYC8OiuFQvSCfsCxxS068Nd5OOt8C1Gb7BbFc+BuI6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fZWAnilouP1R2mSDn5lr7q236ybHAp9yUpeolKnGV4=;
 b=VI+9T9RfsF6zAtkXJyGAbegNn/sappw/OJvGKdVELAbMxSrA8Yyv+qmUQRrSChC2NoSwngZkaV1kLfNrw8mI45SJ5yg8bTMAO6SW9w+mQMVXzOdQVSwR6NmSIUXYyrERcrknlMbI8zsgSmkaYghXpM4PaiOO4UxHT07ybmJ+JaqJDSYLkdiq/zcmTEKg/Br6hGcuxCKrOPDzSSsD9/NNatnf7kOYmOMpkeAGNlodF5muJz1dfIIzrGjgEnwjcLGtIy+/UvkTFIFQ5Dew2f2o7wrAbi7j75cEtX1FxFODee/ZJu7ELUgK5+sd0ICulai8xNvT4iPWrEH0QqYKmwOR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fZWAnilouP1R2mSDn5lr7q236ybHAp9yUpeolKnGV4=;
 b=ZIlPNyjVChzRZaMtU04p8NFKPa2fW1OYLiOubWLOuntb6Xm5DKg6kQC8AGXt8Hx1OUb8LnneU6tPkiCzagKplhwhE0EXxlP0Wf7+BAAZYjMIOxu3q8EOUuwCS9YkxVqmYZlYqzR/Efz4xPrdV54ZiOMyaqqCPFEWuTVbu1MEfFw=
Received: from BYAPR12MB3349.namprd12.prod.outlook.com (2603:10b6:a03:ac::19)
 by BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 06:42:12 +0000
Received: from BYAPR12MB3349.namprd12.prod.outlook.com
 ([fe80::7856:e4cc:578f:a5e7]) by BYAPR12MB3349.namprd12.prod.outlook.com
 ([fe80::7856:e4cc:578f:a5e7%5]) with mapi id 15.20.2835.025; Thu, 26 Mar 2020
 06:42:12 +0000
From: "Olsak, Marek" <Marek.Olsak@amd.com>
To: "Qiao, Ken" <Ken.Qiao@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Add mem_sync implementation for all the
 ASICs.
Thread-Topic: [PATCH 3/4] drm/amdgpu: Add mem_sync implementation for all the
 ASICs.
Thread-Index: AQHWArHaLaF/e5hYpUeHrBncPixxI6haZHgAgAAJQVM=
Date: Thu, 26 Mar 2020 06:42:12 +0000
Message-ID: <BYAPR12MB3349FC1B9E15EA89E93BFADDF9CF0@BYAPR12MB3349.namprd12.prod.outlook.com>
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
 <1585146580-27143-4-git-send-email-andrey.grodzovsky@amd.com>,
 <MN2PR12MB3951789077EA36B0FA73EE5485CF0@MN2PR12MB3951.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3951789077EA36B0FA73EE5485CF0@MN2PR12MB3951.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-26T06:42:11.595Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marek.Olsak@amd.com; 
x-originating-ip: [70.31.90.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73982660-03bb-46e8-98bb-08d7d150d098
x-ms-traffictypediagnostic: BYAPR12MB3494:|BYAPR12MB3494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3494757ECEE8F773D6574C68F9CF0@BYAPR12MB3494.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(2906002)(30864003)(7696005)(478600001)(52536014)(33656002)(55016002)(4326008)(26005)(5660300002)(9686003)(81156014)(66556008)(66946007)(76116006)(66476007)(64756008)(316002)(19627405001)(71200400001)(186003)(6506007)(53546011)(86362001)(8676002)(8936002)(110136005)(66446008)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3494;
 H:BYAPR12MB3349.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJJx3d1Y4vZBsUZcN5MHyfY1ym0QYTSh9jZhxjgP1FnpZ3Mu9U5+jSmgoU4pBRbRSHu/X7O24peth4aCVmHNsQV7RSckOVgJXoUhDusurHzs6IW0a2cR65wPl+TnGSYEmdinMhZ0rgteadMbPFHIay2upqwYNYFz6BsPC0S6mLfIYxae424C8W5zvtwr/3YDHBfPPayFGThf5rHU+qCX61YhM3RF+pPf/R06TWl1kbmVuegdESKFYFTWISWpIthrr131E8fhkeDyG9yy3Vn66PMDDSupvlrROMrZQXHATo0f7xG5tO3K+VK2duWWBMMp2vG4zFrZBL+2Y5hn7quwTjQR3MFhlvhxVyeKVrDF6GXVF3EOWV+snRhAkpXUdGShc5bwn+8FsqqQggbXs9cSsl0xWdi4lSxPRI4gjIkJJE1MO9jS2XNtQgNEtPYHnMAo
x-ms-exchange-antispam-messagedata: b7vS/N+xgvaBjIfCyrUX12UXVfqLB8Gu2QRZZICE/6rVphkmS/YVB7dXGqdy0PFTLYesZbr/myUPc3Fb1pX8i48nLL9lhBkQA+GFINS4h86WldvuVCdbbMY8/SK5tGIqDYf5KeyHhTYL69efkx+N4A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73982660-03bb-46e8-98bb-08d7d150d098
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 06:42:12.1735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqAKPeL9hCXXZuY9xmQlwtUzSLYgngUgAFNztIAo6To5y7PQem2xFk6ACaqj9qcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>
Content-Type: multipart/mixed; boundary="===============0696243383=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0696243383==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB3349FC1B9E15EA89E93BFADDF9CF0BYAPR12MB3349namp_"

--_000_BYAPR12MB3349FC1B9E15EA89E93BFADDF9CF0BYAPR12MB3349namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBLZW4sDQoNClRoZSBLTUQgaGFzIG5ldmVyIHVzZWQgQUNRVUlSRV9NRU0gYmVmb3JlLiBJdCBo
YXMgdG8gYmUgcmVxdWVzdGVkIGV4cGxpY2l0bHksIGJlY2F1c2UgaXQncyBhIGNoYW5nZSBpbiBL
TUQgYmVoYXZpb3IuDQoNCk1hcmVrDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
RnJvbTogUWlhbywgS2VuIDxLZW4uUWlhb0BhbWQuY29tPg0KU2VudDogTWFyY2ggMjYsIDIwMjAg
MDI6MDgNClRvOiBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+DQpDYzogT2xzYWssIE1hcmVrIDxNYXJlay5PbHNha0BhbWQuY29tPjsgR3JvZHpvdnNr
eSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1p
bmcpIDxEYXZpZDEuWmhvdUBhbWQuY29tPg0KU3ViamVjdDogu9i4tDogW1BBVENIIDMvNF0gZHJt
L2FtZGdwdTogQWRkIG1lbV9zeW5jIGltcGxlbWVudGF0aW9uIGZvciBhbGwgdGhlIEFTSUNzLg0K
DQpIaSBBbmRyZXksDQoNCldoeSBub3Qgc2V0IHRoZSBkZWZhdWx0IHZhbHVlIG9mIHN5bmNfbWVt
IGZsYWcgdG8gdHJ1ZSBpbiBLTUQ/IFNvIHRoZSBsZWdhY3kgVU1EIGRyaXZlciBjYW4gYmUgY29t
cGF0aWJsZSB3aXRoIGl0IHdpdGhvdXQgYW55IGNoYW5nZS4gQW5kIGlmIFVNRCBkb2VzbqGvdCBu
ZWVkIEFDUVVJUkVfTUVNIHRoZW4gY2FuIGV4cGxpY2l0bHkgZGlzYWJsZSBpdCBieSBzZXR0aW5n
IHRoZSBmbGFnIHRvIGZhbHNlLg0KDQpUaGFua3MsDQpLZW4NCg0KLS0tLS3Tyrz+1K28/i0tLS0t
DQq3orz+yMs6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0K
t6LLzcqxvOQ6IDIwMjDE6jPUwjI1yNUgMjI6MzANCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCrOty806IFFpYW8sIEtlbiA8S2VuLlFpYW9AYW1kLmNvbT47IE9sc2FrLCBN
YXJlayA8TWFyZWsuT2xzYWtAYW1kLmNvbT47IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdy
b2R6b3Zza3lAYW1kLmNvbT4NCtb3zOI6IFtQQVRDSCAzLzRdIGRybS9hbWRncHU6IEFkZCBtZW1f
c3luYyBpbXBsZW1lbnRhdGlvbiBmb3IgYWxsIHRoZSBBU0lDcy4NCg0KSW1wbGVtZW50IHRoZSAu
bWVtX3N5bmMgaG9vayBkZWZpbmVkIGVhcmxpZXIuDQoNClNpZ25lZC1vZmYtYnk6IEFuZHJleSBH
cm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysr
Ky0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMgIHwgMTYgKysrKysrKysr
KysrKysrLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYyAgfCAxNiArKysr
KysrKysrKysrKystICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICB8IDE3
ICsrKysrKysrKysrKysrKystICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
ICB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0NCiA1IGZpbGVzIGNoYW5nZWQsIDkzIGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTBfMC5jDQppbmRleCA3ZjlhYzFhMS4uZDdmMzE3NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYw0KQEAgLTUyMzYsNiArNTIzNiwyOSBAQCBzdGF0aWMgaW50IGdmeF92
MTBfMF9raXFfaXJxKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KICAgICAgICAgcmV0dXJu
IDA7DQogfQ0KDQorc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX21lbV9zeW5jKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZykgew0KKyAgICAgICB1bnNpZ25lZCBnY3JfY250bCA9IFBBQ0tFVDNfQUNRVUlS
RV9NRU1fR0NSX0NOVExfR0wyX0lOVigxKSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
UEFDS0VUM19BQ1FVSVJFX01FTV9HQ1JfQ05UTF9HTDJfV0IoMSkgfA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBBQ0tFVDNfQUNRVUlSRV9NRU1fR0NSX0NOVExfR0xNX0lOVigxKSB8DQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFDS0VUM19BQ1FVSVJFX01FTV9HQ1JfQ05UTF9H
TE1fV0IoMSkgfA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBQ0tFVDNfQUNRVUlSRV9N
RU1fR0NSX0NOVExfR0wxX0lOVigxKSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFD
S0VUM19BQ1FVSVJFX01FTV9HQ1JfQ05UTF9HTFZfSU5WKDEpIHwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICBQQUNLRVQzX0FDUVVJUkVfTUVNX0dDUl9DTlRMX0dMS19JTlYoMSkgfA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIFRPRE8gaXMgdGhpcyBlcXZpdmFsZW50IHRvIFZf
NTg2X0dMSV9BTEwgPyAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBQ0tFVDNfQUNR
VUlSRV9NRU1fR0NSX0NOVExfR0xJX0lOVigxKTsNCisNCisgICAgICAgLyogQUNRVUlSRV9NRU0g
LW1ha2Ugb25lIG9yIG1vcmUgc3VyZmFjZXMgdmFsaWQgZm9yIHVzZSBieSB0aGUgc3Vic2VxdWVu
dCBvcGVyYXRpb25zICovDQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFBBQ0tFVDMo
UEFDS0VUM19BQ1FVSVJFX01FTSwgNikpOw0KKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5n
LCAwKTsgLyogQ1BfQ09IRVJfQ05UTCAqLw0KKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5n
LCAweGZmZmZmZmZmKTsgIC8qIENQX0NPSEVSX1NJWkUgKi8NCisgICAgICAgYW1kZ3B1X3Jpbmdf
d3JpdGUocmluZywgMHhmZmZmZmYpOyAgLyogQ1BfQ09IRVJfU0laRV9ISSAqLw0KKyAgICAgICBh
bWRncHVfcmluZ193cml0ZShyaW5nLCAwKTsgLyogQ1BfQ09IRVJfQkFTRSAqLw0KKyAgICAgICBh
bWRncHVfcmluZ193cml0ZShyaW5nLCAwKTsgIC8qIENQX0NPSEVSX0JBU0VfSEkgKi8NCisgICAg
ICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMHgwMDAwMDAwQSk7IC8qIFBPTExfSU5URVJWQUwg
Ki8NCisgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgZ2NyX2NudGwpOyAvKiBHQ1JfQ05U
TCAqLyB9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3MgZ2Z4X3YxMF8wX2lw
X2Z1bmNzID0gew0KICAgICAgICAgLm5hbWUgPSAiZ2Z4X3YxMF8wIiwNCiAgICAgICAgIC5lYXJs
eV9pbml0ID0gZ2Z4X3YxMF8wX2Vhcmx5X2luaXQsDQpAQCAtNTI4Myw3ICs1MzA2LDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjEwXzBfcmluZ19mdW5jc19n
ZnggPSB7DQogICAgICAgICAgICAgICAgIDMgKyAvKiBDTlRYX0NUUkwgKi8NCiAgICAgICAgICAg
ICAgICAgNSArIC8qIEhEUF9JTlZMICovDQogICAgICAgICAgICAgICAgIDggKyA4ICsgLyogRkVO
Q0UgeDIgKi8NCi0gICAgICAgICAgICAgICAyLCAvKiBTV0lUQ0hfQlVGRkVSICovDQorICAgICAg
ICAgICAgICAgMiArIC8qIFNXSVRDSF9CVUZGRVIgKi8NCisgICAgICAgICAgICAgICA4LCAvKiBn
ZnhfdjEwXzBfbWVtX3N5bmMgKi8NCiAgICAgICAgIC5lbWl0X2liX3NpemUgPSA0LCAvKiBnZnhf
djEwXzBfcmluZ19lbWl0X2liX2dmeCAqLw0KICAgICAgICAgLmVtaXRfaWIgPSBnZnhfdjEwXzBf
cmluZ19lbWl0X2liX2dmeCwNCiAgICAgICAgIC5lbWl0X2ZlbmNlID0gZ2Z4X3YxMF8wX3Jpbmdf
ZW1pdF9mZW5jZSwgQEAgLTUzMDQsNiArNTMyOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1k
Z3B1X3JpbmdfZnVuY3MgZ2Z4X3YxMF8wX3JpbmdfZnVuY3NfZ2Z4ID0gew0KICAgICAgICAgLmVt
aXRfd3JlZyA9IGdmeF92MTBfMF9yaW5nX2VtaXRfd3JlZywNCiAgICAgICAgIC5lbWl0X3JlZ193
YWl0ID0gZ2Z4X3YxMF8wX3JpbmdfZW1pdF9yZWdfd2FpdCwNCiAgICAgICAgIC5lbWl0X3JlZ193
cml0ZV9yZWdfd2FpdCA9IGdmeF92MTBfMF9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0LA0K
KyAgICAgICAubWVtX3N5bmMgPSBnZnhfdjEwXzBfbWVtX3N5bmMsDQogfTsNCg0KIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3YxMF8wX3JpbmdfZnVuY3NfY29tcHV0
ZSA9IHsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jDQppbmRleCAzMWY0NGQwLi5j
ZWQ2NDU5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAu
Yw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYw0KQEAgLTM0NjYs
NiArMzQ2NiwxOCBAQCBzdGF0aWMgaW50IGdmeF92Nl8wX3NldF9wb3dlcmdhdGluZ19zdGF0ZSh2
b2lkICpoYW5kbGUsDQogICAgICAgICByZXR1cm4gMDsNCiB9DQoNCitzdGF0aWMgdm9pZCBnZnhf
djZfMF9tZW1fc3luYyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpIHsNCisgICAgICAgYW1kZ3B1
X3Jpbmdfd3JpdGUocmluZywgUEFDS0VUMyhQQUNLRVQzX1NVUkZBQ0VfU1lOQywgMykpOw0KKyAg
ICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzX1RDTDFfQUNUSU9OX0VOQSB8DQor
ICAgICAgICAgICAgICAgICAgICAgICAgIFBBQ0tFVDNfVENfQUNUSU9OX0VOQSB8DQorICAgICAg
ICAgICAgICAgICAgICAgICAgIFBBQ0tFVDNfU0hfS0NBQ0hFX0FDVElPTl9FTkEgfA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICBQQUNLRVQzX1NIX0lDQUNIRV9BQ1RJT05fRU5BKTsgIC8qIENQ
X0NPSEVSX0NOVEwgKi8NCisgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMHhmZmZmZmZm
Zik7ICAvKiBDUF9DT0hFUl9TSVpFICovDQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcs
IDApOyAgLyogQ1BfQ09IRVJfQkFTRSAqLw0KKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5n
LCAweDAwMDAwMDBBKTsgLyogcG9sbCBpbnRlcnZhbCAqLyB9DQorDQogc3RhdGljIGNvbnN0IHN0
cnVjdCBhbWRfaXBfZnVuY3MgZ2Z4X3Y2XzBfaXBfZnVuY3MgPSB7DQogICAgICAgICAubmFtZSA9
ICJnZnhfdjZfMCIsDQogICAgICAgICAuZWFybHlfaW5pdCA9IGdmeF92Nl8wX2Vhcmx5X2luaXQs
DQpAQCAtMzQ5Niw3ICszNTA4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19m
dW5jcyBnZnhfdjZfMF9yaW5nX2Z1bmNzX2dmeCA9IHsNCiAgICAgICAgICAgICAgICAgMTQgKyAx
NCArIDE0ICsgLyogZ2Z4X3Y2XzBfcmluZ19lbWl0X2ZlbmNlIHgzIGZvciB1c2VyIGZlbmNlLCB2
bSBmZW5jZSAqLw0KICAgICAgICAgICAgICAgICA3ICsgNCArIC8qIGdmeF92Nl8wX3JpbmdfZW1p
dF9waXBlbGluZV9zeW5jICovDQogICAgICAgICAgICAgICAgIFNJX0ZMVVNIX0dQVV9UTEJfTlVN
X1dSRUcgKiA1ICsgNyArIDYgKyAvKiBnZnhfdjZfMF9yaW5nX2VtaXRfdm1fZmx1c2ggKi8NCi0g
ICAgICAgICAgICAgICAzICsgMiwgLyogZ2Z4X3Y2X3JpbmdfZW1pdF9jbnR4Y250bCBpbmNsdWRp
bmcgdmd0IGZsdXNoICovDQorICAgICAgICAgICAgICAgMyArIDIgKyAvKiBnZnhfdjZfcmluZ19l
bWl0X2NudHhjbnRsIGluY2x1ZGluZyB2Z3QgZmx1c2ggKi8NCisgICAgICAgICAgICAgICA1LCAv
KiBTVVJGQUNFX1NZTkMgKi8NCiAgICAgICAgIC5lbWl0X2liX3NpemUgPSA2LCAvKiBnZnhfdjZf
MF9yaW5nX2VtaXRfaWIgKi8NCiAgICAgICAgIC5lbWl0X2liID0gZ2Z4X3Y2XzBfcmluZ19lbWl0
X2liLA0KICAgICAgICAgLmVtaXRfZmVuY2UgPSBnZnhfdjZfMF9yaW5nX2VtaXRfZmVuY2UsIEBA
IC0zNTA3LDYgKzM1MjAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNz
IGdmeF92Nl8wX3JpbmdfZnVuY3NfZ2Z4ID0gew0KICAgICAgICAgLmluc2VydF9ub3AgPSBhbWRn
cHVfcmluZ19pbnNlcnRfbm9wLA0KICAgICAgICAgLmVtaXRfY250eGNudGwgPSBnZnhfdjZfcmlu
Z19lbWl0X2NudHhjbnRsLA0KICAgICAgICAgLmVtaXRfd3JlZyA9IGdmeF92Nl8wX3JpbmdfZW1p
dF93cmVnLA0KKyAgICAgICAubWVtX3N5bmMgPSBnZnhfdjZfMF9tZW1fc3luYywNCiB9Ow0KDQog
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjZfMF9yaW5nX2Z1bmNz
X2NvbXB1dGUgPSB7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYw0KaW5kZXggNzMz
ZDM5OC4uODhjNTRjNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92N18wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMNCkBA
IC01MDAxLDYgKzUwMDEsMTggQEAgc3RhdGljIGludCBnZnhfdjdfMF9zZXRfcG93ZXJnYXRpbmdf
c3RhdGUodm9pZCAqaGFuZGxlLA0KICAgICAgICAgcmV0dXJuIDA7DQogfQ0KDQorc3RhdGljIHZv
aWQgZ2Z4X3Y3XzBfbWVtX3N5bmMoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKSB7DQorICAgICAg
IGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFBBQ0tFVDMoUEFDS0VUM19TVVJGQUNFX1NZTkMsIDMp
KTsNCisgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFDS0VUM19UQ0wxX0FDVElPTl9F
TkEgfA0KKyAgICAgICAgICAgICAgICAgICAgICAgICBQQUNLRVQzX1RDX0FDVElPTl9FTkEgfA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICBQQUNLRVQzX1NIX0tDQUNIRV9BQ1RJT05fRU5BIHwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgUEFDS0VUM19TSF9JQ0FDSEVfQUNUSU9OX0VOQSk7
ICAvKiBDUF9DT0hFUl9DTlRMICovDQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDB4
ZmZmZmZmZmYpOyAgLyogQ1BfQ09IRVJfU0laRSAqLw0KKyAgICAgICBhbWRncHVfcmluZ193cml0
ZShyaW5nLCAwKTsgIC8qIENQX0NPSEVSX0JBU0UgKi8NCisgICAgICAgYW1kZ3B1X3Jpbmdfd3Jp
dGUocmluZywgMHgwMDAwMDAwQSk7IC8qIHBvbGwgaW50ZXJ2YWwgKi8gfQ0KKw0KIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIGdmeF92N18wX2lwX2Z1bmNzID0gew0KICAgICAgICAg
Lm5hbWUgPSAiZ2Z4X3Y3XzAiLA0KICAgICAgICAgLmVhcmx5X2luaXQgPSBnZnhfdjdfMF9lYXJs
eV9pbml0LA0KQEAgLTUwMzMsNyArNTA0NSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1
X3JpbmdfZnVuY3MgZ2Z4X3Y3XzBfcmluZ19mdW5jc19nZnggPSB7DQogICAgICAgICAgICAgICAg
IDEyICsgMTIgKyAxMiArIC8qIGdmeF92N18wX3JpbmdfZW1pdF9mZW5jZV9nZnggeDMgZm9yIHVz
ZXIgZmVuY2UsIHZtIGZlbmNlICovDQogICAgICAgICAgICAgICAgIDcgKyA0ICsgLyogZ2Z4X3Y3
XzBfcmluZ19lbWl0X3BpcGVsaW5lX3N5bmMgKi8NCiAgICAgICAgICAgICAgICAgQ0lLX0ZMVVNI
X0dQVV9UTEJfTlVNX1dSRUcgKiA1ICsgNyArIDYgKyAvKiBnZnhfdjdfMF9yaW5nX2VtaXRfdm1f
Zmx1c2ggKi8NCi0gICAgICAgICAgICAgICAzICsgNCwgLyogZ2Z4X3Y3X3JpbmdfZW1pdF9jbnR4
Y250bCBpbmNsdWRpbmcgdmd0IGZsdXNoKi8NCisgICAgICAgICAgICAgICAzICsgNCArIC8qIGdm
eF92N19yaW5nX2VtaXRfY250eGNudGwgaW5jbHVkaW5nIHZndCBmbHVzaCovDQorICAgICAgICAg
ICAgICAgNSwgLyogU1VSRkFDRV9TWU5DICovDQogICAgICAgICAuZW1pdF9pYl9zaXplID0gNCwg
LyogZ2Z4X3Y3XzBfcmluZ19lbWl0X2liX2dmeCAqLw0KICAgICAgICAgLmVtaXRfaWIgPSBnZnhf
djdfMF9yaW5nX2VtaXRfaWJfZ2Z4LA0KICAgICAgICAgLmVtaXRfZmVuY2UgPSBnZnhfdjdfMF9y
aW5nX2VtaXRfZmVuY2VfZ2Z4LCBAQCAtNTA0OCw2ICs1MDYxLDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjdfMF9yaW5nX2Z1bmNzX2dmeCA9IHsNCiAgICAg
ICAgIC5lbWl0X2NudHhjbnRsID0gZ2Z4X3Y3X3JpbmdfZW1pdF9jbnR4Y250bCwNCiAgICAgICAg
IC5lbWl0X3dyZWcgPSBnZnhfdjdfMF9yaW5nX2VtaXRfd3JlZywNCiAgICAgICAgIC5zb2Z0X3Jl
Y292ZXJ5ID0gZ2Z4X3Y3XzBfcmluZ19zb2Z0X3JlY292ZXJ5LA0KKyAgICAgICAubWVtX3N5bmMg
PSBnZnhfdjdfMF9tZW1fc3luYywNCiB9Ow0KDQogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVf
cmluZ19mdW5jcyBnZnhfdjdfMF9yaW5nX2Z1bmNzX2NvbXB1dGUgPSB7IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KaW5kZXggZmMzMjU4Ni4uMGIxZDNhOCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCkBAIC02ODE1LDYgKzY4MTUsMTkgQEAgc3RhdGlj
IGludCBnZnhfdjhfMF9zcV9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogICAgICAg
ICByZXR1cm4gMDsNCiB9DQoNCitzdGF0aWMgdm9pZCBnZnhfdjhfMF9tZW1fc3luYyhzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpIHsNCisgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFD
S0VUMyhQQUNLRVQzX1NVUkZBQ0VfU1lOQywgMykpOw0KKyAgICAgICBhbWRncHVfcmluZ193cml0
ZShyaW5nLCBQQUNLRVQzX1RDTDFfQUNUSU9OX0VOQSB8DQorICAgICAgICAgICAgICAgICAgICAg
ICAgIFBBQ0tFVDNfVENfQUNUSU9OX0VOQSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgIFBB
Q0tFVDNfU0hfS0NBQ0hFX0FDVElPTl9FTkEgfA0KKyAgICAgICAgICAgICAgICAgICAgICAgICBQ
QUNLRVQzX1NIX0lDQUNIRV9BQ1RJT05fRU5BIHwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
UEFDS0VUM19UQ19XQl9BQ1RJT05fRU5BKTsgIC8qIENQX0NPSEVSX0NOVEwgKi8NCisgICAgICAg
YW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMHhmZmZmZmZmZik7ICAvKiBDUF9DT0hFUl9TSVpFICov
DQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDApOyAgLyogQ1BfQ09IRVJfQkFTRSAq
Lw0KKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCAweDAwMDAwMDBBKTsgLyogcG9sbCBp
bnRlcnZhbCAqLyB9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3MgZ2Z4X3Y4
XzBfaXBfZnVuY3MgPSB7DQogICAgICAgICAubmFtZSA9ICJnZnhfdjhfMCIsDQogICAgICAgICAu
ZWFybHlfaW5pdCA9IGdmeF92OF8wX2Vhcmx5X2luaXQsDQpAQCAtNjg2MSw3ICs2ODc0LDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjhfMF9yaW5nX2Z1bmNz
X2dmeCA9IHsNCiAgICAgICAgICAgICAgICAgMyArIC8qIENOVFhfQ1RSTCAqLw0KICAgICAgICAg
ICAgICAgICA1ICsgLyogSERQX0lOVkwgKi8NCiAgICAgICAgICAgICAgICAgMTIgKyAxMiArIC8q
IEZFTkNFIHgyICovDQotICAgICAgICAgICAgICAgMiwgLyogU1dJVENIX0JVRkZFUiAqLw0KKyAg
ICAgICAgICAgICAgIDIgKyAvKiBTV0lUQ0hfQlVGRkVSICovDQorICAgICAgICAgICAgICAgNSwg
LyogU1VSRkFDRV9TWU5DICovDQogICAgICAgICAuZW1pdF9pYl9zaXplID0gNCwgLyogZ2Z4X3Y4
XzBfcmluZ19lbWl0X2liX2dmeCAqLw0KICAgICAgICAgLmVtaXRfaWIgPSBnZnhfdjhfMF9yaW5n
X2VtaXRfaWJfZ2Z4LA0KICAgICAgICAgLmVtaXRfZmVuY2UgPSBnZnhfdjhfMF9yaW5nX2VtaXRf
ZmVuY2VfZ2Z4LCBAQCAtNjg3OSw2ICs2ODkzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRn
cHVfcmluZ19mdW5jcyBnZnhfdjhfMF9yaW5nX2Z1bmNzX2dmeCA9IHsNCiAgICAgICAgIC5wYXRj
aF9jb25kX2V4ZWMgPSBnZnhfdjhfMF9yaW5nX2VtaXRfcGF0Y2hfY29uZF9leGVjLA0KICAgICAg
ICAgLmVtaXRfd3JlZyA9IGdmeF92OF8wX3JpbmdfZW1pdF93cmVnLA0KICAgICAgICAgLnNvZnRf
cmVjb3ZlcnkgPSBnZnhfdjhfMF9yaW5nX3NvZnRfcmVjb3ZlcnksDQorICAgICAgIC5tZW1fc3lu
YyA9IGdmeF92OF8wX21lbV9zeW5jLA0KIH07DQoNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdw
dV9yaW5nX2Z1bmNzIGdmeF92OF8wX3JpbmdfZnVuY3NfY29tcHV0ZSA9IHsgZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQppbmRleCBmYjU2N2NmLi5mODUxZTgwIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KQEAgLTY2MTMsNiArNjYxMywyNCBAQCBzdGF0
aWMgaW50IGdmeF92OV8wX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCiAgICAgICAgIHJldHVybiAwOw0KIH0NCg0KK3N0YXRpYyB2b2lkIGdmeF92OV8w
X21lbV9zeW5jKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykgew0KKyAgICAgICB1bnNpZ25lZCBj
cF9jb2hlcl9jbnRsID0gUEFDS0VUM19BQ1FVSVJFX01FTV9DUF9DT0hFUl9DTlRMX1NIX0lDQUNI
RV9BQ1RJT05fRU5BKDEpIHwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBQ0tF
VDNfQUNRVUlSRV9NRU1fQ1BfQ09IRVJfQ05UTF9TSF9LQ0FDSEVfQUNUSU9OX0VOQSgxKSB8DQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUNLRVQzX0FDUVVJUkVfTUVNX0NQX0NP
SEVSX0NOVExfVENfQUNUSU9OX0VOQSgxKSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBQQUNLRVQzX0FDUVVJUkVfTUVNX0NQX0NPSEVSX0NOVExfVENMMV9BQ1RJT05fRU5BKDEp
IHwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBQ0tFVDNfQUNRVUlSRV9NRU1f
Q1BfQ09IRVJfQ05UTF9UQ19XQl9BQ1RJT05fRU5BKDEpOw0KKw0KKyAgICAgICAvKiBBQ1FVSVJF
X01FTSAtbWFrZSBvbmUgb3IgbW9yZSBzdXJmYWNlcyB2YWxpZCBmb3IgdXNlIGJ5IHRoZSBzdWJz
ZXF1ZW50IG9wZXJhdGlvbnMgKi8NCisgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFD
S0VUMyhQQUNLRVQzX0FDUVVJUkVfTUVNLCA1KSk7DQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRl
KHJpbmcsIGNwX2NvaGVyX2NudGwpOyAvKiBDUF9DT0hFUl9DTlRMICovDQorICAgICAgIGFtZGdw
dV9yaW5nX3dyaXRlKHJpbmcsIDB4ZmZmZmZmZmYpOyAgLyogQ1BfQ09IRVJfU0laRSAqLw0KKyAg
ICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCAweGZmZmZmZik7ICAvKiBDUF9DT0hFUl9TSVpF
X0hJICovDQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDApOyAvKiBDUF9DT0hFUl9C
QVNFICovDQorICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDApOyAgLyogQ1BfQ09IRVJf
QkFTRV9ISSAqLw0KKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCAweDAwMDAwMDBBKTsg
LyogUE9MTF9JTlRFUlZBTCAqLyB9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVu
Y3MgZ2Z4X3Y5XzBfaXBfZnVuY3MgPSB7DQogICAgICAgICAubmFtZSA9ICJnZnhfdjlfMCIsDQog
ICAgICAgICAuZWFybHlfaW5pdCA9IGdmeF92OV8wX2Vhcmx5X2luaXQsDQpAQCAtNjY1OSw3ICs2
Njc3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjlfMF9y
aW5nX2Z1bmNzX2dmeCA9IHsNCiAgICAgICAgICAgICAgICAgMyArIC8qIENOVFhfQ1RSTCAqLw0K
ICAgICAgICAgICAgICAgICA1ICsgLyogSERQX0lOVkwgKi8NCiAgICAgICAgICAgICAgICAgOCAr
IDggKyAvKiBGRU5DRSB4MiAqLw0KLSAgICAgICAgICAgICAgIDIsIC8qIFNXSVRDSF9CVUZGRVIg
Ki8NCisgICAgICAgICAgICAgICAyICsgLyogU1dJVENIX0JVRkZFUiAqLw0KKyAgICAgICAgICAg
ICAgIDcsIC8qIGdmeF92OV8wX21lbV9zeW5jICovDQogICAgICAgICAuZW1pdF9pYl9zaXplID0g
NCwgLyogZ2Z4X3Y5XzBfcmluZ19lbWl0X2liX2dmeCAqLw0KICAgICAgICAgLmVtaXRfaWIgPSBn
ZnhfdjlfMF9yaW5nX2VtaXRfaWJfZ2Z4LA0KICAgICAgICAgLmVtaXRfZmVuY2UgPSBnZnhfdjlf
MF9yaW5nX2VtaXRfZmVuY2UsIEBAIC02NjgwLDYgKzY2OTksNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92OV8wX3JpbmdfZnVuY3NfZ2Z4ID0gew0KICAgICAg
ICAgLmVtaXRfcmVnX3dhaXQgPSBnZnhfdjlfMF9yaW5nX2VtaXRfcmVnX3dhaXQsDQogICAgICAg
ICAuZW1pdF9yZWdfd3JpdGVfcmVnX3dhaXQgPSBnZnhfdjlfMF9yaW5nX2VtaXRfcmVnX3dyaXRl
X3JlZ193YWl0LA0KICAgICAgICAgLnNvZnRfcmVjb3ZlcnkgPSBnZnhfdjlfMF9yaW5nX3NvZnRf
cmVjb3ZlcnksDQorICAgICAgIC5tZW1fc3luYyA9IGdmeF92OV8wX21lbV9zeW5jLA0KIH07DQoN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92OV8wX3JpbmdfZnVu
Y3NfY29tcHV0ZSA9IHsNCi0tDQoyLjcuNA0KDQo=

--_000_BYAPR12MB3349FC1B9E15EA89E93BFADDF9CF0BYAPR12MB3349namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Ken,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The KMD has never used ACQUIRE_MEM before. It has to be requested explicitl=
y, because it's a change in KMD behavior.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
Marek<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Qiao, Ken &lt;Ken.Qia=
o@amd.com&gt;<br>
<b>Sent:</b> March 26, 2020 02:08<br>
<b>To:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Grodzovsky, Andrey &lt=
;Andrey.Grodzovsky@amd.com&gt;; Zhou, David(ChunMing) &lt;David1.Zhou@amd.c=
om&gt;<br>
<b>Subject:</b> =BB=D8=B8=B4: [PATCH 3/4] drm/amdgpu: Add mem_sync implemen=
tation for all the ASICs.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Andrey,<br>
<br>
Why not set the default value of sync_mem flag to true in KMD? So the legac=
y UMD driver can be compatible with it without any change. And if UMD doesn=
=A1=AFt need ACQUIRE_MEM then can explicitly disable it by setting the flag=
 to false.<br>
<br>
Thanks,<br>
Ken<br>
<br>
-----=D3=CA=BC=FE=D4=AD=BC=FE-----<br>
=B7=A2=BC=FE=C8=CB: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt; <br=
>
=B7=A2=CB=CD=CA=B1=BC=E4: 2020=C4=EA3=D4=C225=C8=D5 22:30<br>
=CA=D5=BC=FE=C8=CB: amd-gfx@lists.freedesktop.org<br>
=B3=AD=CB=CD: Qiao, Ken &lt;Ken.Qiao@amd.com&gt;; Olsak, Marek &lt;Marek.Ol=
sak@amd.com&gt;; Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
=D6=F7=CC=E2: [PATCH 3/4] drm/amdgpu: Add mem_sync implementation for all t=
he ASICs.<br>
<br>
Implement the .mem_sync hook defined earlier.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;-&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c=
&nbsp; | 16 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;-&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp; | 16 &#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-&nbsp=
; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp; | 17 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-&nbsp;
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; | 22 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;-<br>
&nbsp;5 files changed, 93 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 7f9ac1a1..d7f3177 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -5236,6 &#43;5236,29 @@ static int gfx_v10_0_kiq_irq(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v10_0_mem_sync(struct amdgpu_ring *ring) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned gcr_cntl =3D PACKET3_ACQ=
UIRE_MEM_GCR_CNTL_GL2_INV(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TODO is this eqvivalent to V_586_GLI_ALL ? */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ACQUIRE_MEM -make one or more =
surfaces valid for use by the subsequent operations */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(P=
ACKET3_ACQUIRE_MEM, 6));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0); /* CP=
_COHER_CNTL */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xfffffff=
f);&nbsp; /* CP_COHER_SIZE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xffffff)=
;&nbsp; /* CP_COHER_SIZE_HI */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0); /* CP=
_COHER_BASE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);&nbsp;=
 /* CP_COHER_BASE_HI */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x0000000=
A); /* POLL_INTERVAL */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, gcr_cntl)=
; /* GCR_CNTL */ }<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v10_0&=
quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v10_0_=
early_init,<br>
@@ -5283,7 &#43;5306,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 3 &#43; /* CNTX_CTRL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 5 &#43; /* HDP_INVL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 8 &#43; 8 &#43; /* FENCE x2 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 2, /* SWITCH_BUFFER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 2 &#43; /* SWITCH_BUFFER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 8, /* gfx_v10_0_mem_sync */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 4, /* gf=
x_v10_0_ring_emit_ib_gfx */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D gfx_v10_0_rin=
g_emit_ib_gfx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D gfx_v10_0_=
ring_emit_fence, @@ -5304,6 &#43;5328,7 @@ static const struct amdgpu_ring_=
funcs gfx_v10_0_ring_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v10_0_r=
ing_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait =3D gfx_v10=
_0_ring_emit_reg_wait,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =
=3D gfx_v10_0_ring_emit_reg_write_reg_wait,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_sync =3D gfx_v10_0_mem_sync,=
<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute =
=3D { diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v6_0.c<br>
index 31f44d0..ced6459 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
@@ -3466,6 &#43;3466,18 @@ static int gfx_v6_0_set_powergating_state(void *=
handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v6_0_mem_sync(struct amdgpu_ring *ring) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(P=
ACKET3_SURFACE_SYNC, 3));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3_T=
CL1_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_TC_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_SH_KCACHE_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_SH_ICACHE_ACTION_ENA);&nbsp; /* CP_COHER_CNTL */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xfffffff=
f);&nbsp; /* CP_COHER_SIZE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);&nbsp;=
 /* CP_COHER_BASE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x0000000=
A); /* poll interval */ }<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v6_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v6_0&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v6_0_e=
arly_init,<br>
@@ -3496,7 &#43;3508,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ri=
ng_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 14 &#43; 14 &#43; 14 &#43; /* gfx_v6_0_ring_emit_fenc=
e x3 for user fence, vm fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 7 &#43; 4 &#43; /* gfx_v6_0_ring_emit_pipeline_sync *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SI_FLUSH_GPU_TLB_NUM_WREG * 5 &#43; 7 &#43; 6 &#43; /=
* gfx_v6_0_ring_emit_vm_flush */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 3 &#43; 2, /* gfx_v6_ring_emit_cntxcntl including vgt flush */<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 3 &#43; 2 &#43; /* gfx_v6_ring_emit_cntxcntl including vgt f=
lush */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 5, /* SURFACE_SYNC */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 6, /* gf=
x_v6_0_ring_emit_ib */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D gfx_v6_0_ring=
_emit_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D gfx_v6_0_r=
ing_emit_fence, @@ -3507,6 &#43;3520,7 @@ static const struct amdgpu_ring_f=
uncs gfx_v6_0_ring_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_rin=
g_insert_nop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_cntxcntl =3D gfx_v6_=
ring_emit_cntxcntl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v6_0_ri=
ng_emit_wreg,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_sync =3D gfx_v6_0_mem_sync,<=
br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute =3D=
 { diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v7_0.c<br>
index 733d398..88c54c4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -5001,6 &#43;5001,18 @@ static int gfx_v7_0_set_powergating_state(void *=
handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v7_0_mem_sync(struct amdgpu_ring *ring) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(P=
ACKET3_SURFACE_SYNC, 3));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3_T=
CL1_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_TC_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_SH_KCACHE_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_SH_ICACHE_ACTION_ENA);&nbsp; /* CP_COHER_CNTL */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xfffffff=
f);&nbsp; /* CP_COHER_SIZE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);&nbsp;=
 /* CP_COHER_BASE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x0000000=
A); /* poll interval */ }<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v7_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v7_0&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v7_0_e=
arly_init,<br>
@@ -5033,7 &#43;5045,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ri=
ng_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 12 &#43; 12 &#43; 12 &#43; /* gfx_v7_0_ring_emit_fenc=
e_gfx x3 for user fence, vm fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 7 &#43; 4 &#43; /* gfx_v7_0_ring_emit_pipeline_sync *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CIK_FLUSH_GPU_TLB_NUM_WREG * 5 &#43; 7 &#43; 6 &#43; =
/* gfx_v7_0_ring_emit_vm_flush */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 3 &#43; 4, /* gfx_v7_ring_emit_cntxcntl including vgt flush*/<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 3 &#43; 4 &#43; /* gfx_v7_ring_emit_cntxcntl including vgt f=
lush*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 5, /* SURFACE_SYNC */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 4, /* gf=
x_v7_0_ring_emit_ib_gfx */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D gfx_v7_0_ring=
_emit_ib_gfx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D gfx_v7_0_r=
ing_emit_fence_gfx, @@ -5048,6 &#43;5061,7 @@ static const struct amdgpu_ri=
ng_funcs gfx_v7_0_ring_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_cntxcntl =3D gfx_v7_=
ring_emit_cntxcntl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v7_0_ri=
ng_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v7_=
0_ring_soft_recovery,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_sync =3D gfx_v7_0_mem_sync,<=
br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute =3D=
 { diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v8_0.c<br>
index fc32586..0b1d3a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -6815,6 &#43;6815,19 @@ static int gfx_v8_0_sq_irq(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v8_0_mem_sync(struct amdgpu_ring *ring) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(P=
ACKET3_SURFACE_SYNC, 3));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3_T=
CL1_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_TC_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_SH_KCACHE_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_SH_ICACHE_ACTION_ENA |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_TC_WB_ACTION_ENA);&nbsp; /* CP_COHER_CNTL */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xfffffff=
f);&nbsp; /* CP_COHER_SIZE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);&nbsp;=
 /* CP_COHER_BASE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x0000000=
A); /* poll interval */ }<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v8_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v8_0&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v8_0_e=
arly_init,<br>
@@ -6861,7 &#43;6874,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ri=
ng_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 3 &#43; /* CNTX_CTRL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 5 &#43; /* HDP_INVL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 12 &#43; 12 &#43; /* FENCE x2 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 2, /* SWITCH_BUFFER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 2 &#43; /* SWITCH_BUFFER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 5, /* SURFACE_SYNC */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 4, /* gf=
x_v8_0_ring_emit_ib_gfx */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D gfx_v8_0_ring=
_emit_ib_gfx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D gfx_v8_0_r=
ing_emit_fence_gfx, @@ -6879,6 &#43;6893,7 @@ static const struct amdgpu_ri=
ng_funcs gfx_v8_0_ring_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .patch_cond_exec =3D gfx_v=
8_0_ring_emit_patch_cond_exec,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v8_0_ri=
ng_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v8_=
0_ring_soft_recovery,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_sync =3D gfx_v8_0_mem_sync,<=
br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute =3D=
 { diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v9_0.c<br>
index fb567cf..f851e80 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -6613,6 &#43;6613,24 @@ static int gfx_v9_0_query_ras_error_count(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v9_0_mem_sync(struct amdgpu_ring *ring) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned cp_coher_cntl =3D PACKET=
3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_ACQUIRE_MEM_CP_COHER_CNTL=
_SH_KCACHE_ACTION_ENA(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_ACQUIRE_MEM_CP_COHER_CNTL=
_TC_ACTION_ENA(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_ACQUIRE_MEM_CP_COHER_CNTL=
_TCL1_ACTION_ENA(1) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_ACQUIRE_MEM_CP_COHER_CNTL=
_TC_WB_ACTION_ENA(1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ACQUIRE_MEM -make one or more =
surfaces valid for use by the subsequent operations */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(P=
ACKET3_ACQUIRE_MEM, 5));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, cp_coher_=
cntl); /* CP_COHER_CNTL */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xfffffff=
f);&nbsp; /* CP_COHER_SIZE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xffffff)=
;&nbsp; /* CP_COHER_SIZE_HI */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0); /* CP=
_COHER_BASE */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);&nbsp;=
 /* CP_COHER_BASE_HI */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x0000000=
A); /* POLL_INTERVAL */ }<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v9_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v9_0&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v9_0_e=
arly_init,<br>
@@ -6659,7 &#43;6677,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ri=
ng_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 3 &#43; /* CNTX_CTRL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 5 &#43; /* HDP_INVL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 8 &#43; 8 &#43; /* FENCE x2 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 2, /* SWITCH_BUFFER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 2 &#43; /* SWITCH_BUFFER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 7, /* gfx_v9_0_mem_sync */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 4, /* gf=
x_v9_0_ring_emit_ib_gfx */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D gfx_v9_0_ring=
_emit_ib_gfx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D gfx_v9_0_r=
ing_emit_fence, @@ -6680,6 &#43;6699,7 @@ static const struct amdgpu_ring_f=
uncs gfx_v9_0_ring_funcs_gfx =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait =3D gfx_v9_=
0_ring_emit_reg_wait,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =
=3D gfx_v9_0_ring_emit_reg_write_reg_wait,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v9_=
0_ring_soft_recovery,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_sync =3D gfx_v9_0_mem_sync,<=
br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute =3D=
 {<br>
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB3349FC1B9E15EA89E93BFADDF9CF0BYAPR12MB3349namp_--

--===============0696243383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0696243383==--
