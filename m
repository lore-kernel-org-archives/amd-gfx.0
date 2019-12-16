Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE8DC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 09:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6049B206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 09:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EuOMETgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6049B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAA16E049;
	Mon, 16 Dec 2019 09:18:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A82A6E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 09:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZHlzo9pfDLOqBKMluSdMcSaT81ZcZWdHkZbDkaIEuNPaWleSzxgYue80HiaJZQJE9aRsez63kxH393iVaUzE30Az14gDWkYi8qaocI/hLntTTmFCXw6gwVHCbHUK1KjDHev0ob+FRxxw/U5QczvEWX27iL4bnA5FFHS+UAYpEM207Z160w3g/svXRsDw0NHQKVcmeUn63zw5cwoykjPzpJ0g0jqbYXyJ2tNyfH6sYMEuJFYR1qvpSAcbmUCN8CInKmigLTstNUQj1t79Mkhvsn/Ftv7MPC9BI3aAR7b2/hnC8Qv31qG7Nia5uaYC6ExWWDUfnBJiL3n4eAO1y38gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USKLZabkshgvSIoigUZ9eNeY9++KaxMcaqw5ZSq2AmQ=;
 b=kROun1JhKjhjX6L/MOP6n9Iiain8+2sr+DNnZxXDTwimZ5PnLB7Yg2xwOcUQ3Nho0Jb/F2H0e1gPvxC1ME/BxsyFExpl6jEO7sUyPxkUOzjIfXCh6a1o5EiHCD61Iv1Ukm3D7QLcs+rzFQCEBbYsT6Jq3v0lz+6I590BFDQPcq5XCHF5IC8P+8LHTl5+nFnMItN89W5rrUzmSQemwKKQyP7cfAoNVoZh/1F/tI5F+2INhgjy+D4mfui+JW/8i6gMWNeOMbTA9yO0+kbEh89WP7Ss5LO2o0XsuZvT6t/oNf4cxS5XAtYC6fcM4JNTEhkueG2qjqFlTTJgNCj5Bfs27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USKLZabkshgvSIoigUZ9eNeY9++KaxMcaqw5ZSq2AmQ=;
 b=EuOMETgfml0LfAQudUZRBqbDTIhUL+Ay03HtwEXRybU1YQz0Wh6C6dlqey6PMLeEcMYs5rqc9NZ5z0UmbCd1HGzIKay+Gqk9oyEajKii5SXGbTbecArxgylhvFyxFi2kc9nNPlXaNr5TNbczGZCdOjFsW7LT60hV7Mn25ULvB/M=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (20.178.242.91) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.238.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Mon, 16 Dec 2019 09:18:45 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::1892:1a4f:de3b:2c12]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::1892:1a4f:de3b:2c12%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 09:18:45 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Tonga sriov also need load firmware
 with smu
Thread-Topic: [PATCH] drm/amdgpu/sriov: Tonga sriov also need load firmware
 with smu
Thread-Index: AQHVs/Gmw5WblD3nSEmOG5QCemG1kKe8e31Q
Date: Mon, 16 Dec 2019 09:18:45 +0000
Message-ID: <MN2PR12MB303956633D82E5BEB6A5E8A1E5510@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <1576487822-3881-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1576487822-3881-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccb6cb27-8f34-46bf-d14b-08d78208f3ba
x-ms-traffictypediagnostic: MN2PR12MB3871:|MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871B4B1FD91314BF7077521E5510@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(13464003)(186003)(6506007)(53546011)(45080400002)(86362001)(52536014)(5660300002)(478600001)(966005)(81156014)(2906002)(26005)(4326008)(8936002)(55016002)(316002)(76116006)(110136005)(9686003)(64756008)(66446008)(66946007)(66556008)(66476007)(7696005)(33656002)(71200400001)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3871;
 H:MN2PR12MB3039.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1UISnWiOWIJ7Eg/Riuayj9mkCzuaSmajqn2wDAD1hemJY5UMi3pgqj31EjHCMGzuWdOH9u+VUUeW/OS3XkLZsFEvLKnV0fODwPxAAAcbMVgBIWO9kPoMxkrDnMUxV6A7guNy9wTKuUNdvbwM7pQqz9Xu+svcKz/0M65/BGsZhhZ/WUJu1zHSnCo2Kwj6A1QjF4/xo3isZGC2aJNom8are+hF4mE8i+jziCbiAG4g4EMnvIgbWfpd/AZouc7VONj1nI9ERb4E4ILnzzbPtJBteHj+AVeoH176qQG/BPUfB8B1pU1BlG/FNHCpj1jHYU8lSGN3QXfmwWKU5pTA+o9CYWnzXlBgWZCZzF71EcwZrYGGf0t+5A/MOycfqNUONs9gWZ9FU44pGlNNeyCggJcwK78roXRhhvG+OWZt66xk8Pno18LmN3vlc5Ov3WqMKZGvfmW6sL5VY9Jhl2KLkSafRLzx9RvhdNooERsISA2KKu0+SrRTaT7dHW5prk9NYJSE5zwNCgqrKLK7Gej62UfNftguKjdqYMG84z25Yzk+bdE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb6cb27-8f34-46bf-d14b-08d78208f3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 09:18:45.5591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8oAT1oO4g52P7jKqJn1lOMF2OkojPRQGWvNz4Amw0TRtWEjbNl1pVy51yfj5DX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZC1ieSBZaW50aWFuIFRhbzxZaW50aWFuLnRhb0BhbWQuY29tPg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEVtaWx5IERlbmcNClNlbnQ6IDIwMTnE6jEy1MIx
NsjVIDE3OjE3DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZW5nLCBF
bWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1L3Ny
aW92OiBUb25nYSBzcmlvdiBhbHNvIG5lZWQgbG9hZCBmaXJtd2FyZSB3aXRoIHNtdQ0KDQpGaXgg
VG9uZ2Egc3Jpb3YgbG9hZCBkcml2ZXIgZmFpbCBpc3N1ZS4NCg0KU2lnbmVkLW9mZi1ieTogRW1p
bHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgMyArKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRfcG93ZXJwbGF5LmMgfCAzIC0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQppbmRleCAyNmQxYTRjLi41MmQzZjY2IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCkBAIC0xODE4LDcgKzE4MTgsOCBAQCBz
dGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfZndfbG9hZGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiAJCX0NCiAJfQ0KIA0KLQlyID0gYW1kZ3B1X3BtX2xvYWRfc211X2Zpcm13YXJlKGFk
ZXYsICZzbXVfdmVyc2lvbik7DQorCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpIHx8IGFkZXYt
PmFzaWNfdHlwZSA9PSBDSElQX1RPTkdBKQ0KKwkJciA9IGFtZGdwdV9wbV9sb2FkX3NtdV9maXJt
d2FyZShhZGV2LCAmc211X3ZlcnNpb24pOw0KIA0KIAlyZXR1cm4gcjsNCiB9DQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jDQppbmRleCA1MDg3ZDZiLi43
MjkzNzYzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bv
d2VycGxheS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJw
bGF5LmMNCkBAIC0yNzUsOSArMjc1LDYgQEAgc3RhdGljIGludCBwcF9kcG1fbG9hZF9mdyh2b2lk
ICpoYW5kbGUpICB7DQogCXN0cnVjdCBwcF9od21nciAqaHdtZ3IgPSBoYW5kbGU7DQogDQotCWlm
ICghaHdtZ3ItPm5vdF92ZikNCi0JCXJldHVybiAwOw0KLQ0KIAlpZiAoIWh3bWdyIHx8ICFod21n
ci0+c211bWdyX2Z1bmNzIHx8ICFod21nci0+c211bWdyX2Z1bmNzLT5zdGFydF9zbXUpDQogCQly
ZXR1cm4gLUVJTlZBTDsNCiANCi0tDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N5aW50aWFuLnRhbyU0
MGFtZC5jb20lN0NhNmEwOWFlYmEwZWM0NjkzZTJhODA4ZDc4MjA4YzFmYSU3QzNkZDg5NjFmZTQ4
ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMjA4NDY1MzUwODA1MTImYW1wO3Nk
YXRhPXlSJTJGTGRnYzlJVXNodnJmYzJZV21XcjdqNnZMVXJ6eFRISXRabkVuSkdPcyUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
