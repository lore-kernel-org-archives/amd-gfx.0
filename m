Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487EC4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 14:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2193620754
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K/ISB4Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2193620754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2B86E203;
	Wed, 30 Sep 2020 14:02:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D4D06E203
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 14:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbJ3SgZx7TGu1yhVRjlL0E848rjeCeD+cKABsGiO7auMRuBlL5GC+vlFTqagQElMgNSfBZxK2eVGP5y9q1ShAcoSjDCM4Nk0kcDrgBFP9W7e3zObwlP+LlwX/gVVZnoQydq3dahZ5PL1Yn1UZCm30QHYH9NrYTHBI5Qy+gKOX7/5I7W1K2ScjMny6pmwBPvKB1GDBMCYwoJ34rZsaBRbyXC6tbcjVQ5xnppemDvCKRcRtIqQB4x5cP+Fq5BZFWpmENdqO23H3sNxXNWDywN77eRWZA/MYCnM4aW+Ht8gOzg3VyOfMvosWLq55rtVvp71trXdOUZivh6Hga5WKVvppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blbUjWjghODksXTRgAiRMfC1iGIiN8YFKpVr814MkGk=;
 b=IQzCSgRBmrHnXwaskJwUMcNhEO17wB3J+T6Qae9/RyM9awImjWz2OEDc+/M//kdXICiLIiV9PDAVXPeCgT/9tMfKstwN17czSrFCuL59MNh62EQfgclflavqtMyDJJvyqRirmTdefJpSr3GjaQEXS6/ahXv96LkAr2u8Jz3mjp4BuZFWyHyvvPxXR5h6KbeyjgTLvR/fALl2wPnP62rFWM/THeYBtMgLnMMGexoZ3o6FE1WIlOYbbs89L1veBlepJCYJmoPt5h9/krtizQPQ72QVzv7irbdgMMvgfv3Icyg7InNQ82R+zkr+fKOoIoi0KWJlCjyEylietyF8ExLs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blbUjWjghODksXTRgAiRMfC1iGIiN8YFKpVr814MkGk=;
 b=K/ISB4ZiyHq9OiobUFHpTT5lKjmjxT96jCPVkWLuZHsfckkpHez+lnPBpamSwXScRgxBK0TcDVW/UQDNioE30enFSDOccCLD+ZIY/c2x8eHUdbytFBL3gMdz2zdohsjkXqwAj6081ZrOIhJ3xr0ucUWcfI4l8RRB87g+kPHWcvQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1642.namprd12.prod.outlook.com (2603:10b6:4:7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36; Wed, 30 Sep 2020 14:02:21 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 14:02:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix build error
Thread-Topic: [PATCH] drm/amdgpu: fix build error
Thread-Index: AQHWlzH/Xch5pKtnik+LgcLlnokr3amBNhjw
Date: Wed, 30 Sep 2020 14:02:21 +0000
Message-ID: <DM6PR12MB40756FCF77C32DB24379A426FC330@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200930135834.6917-1-guchun.chen@amd.com>
In-Reply-To: <20200930135834.6917-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-30T14:02:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=12dad1ca-bddf-4062-bf5b-0000f16656ba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-30T14:02:08Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4c19c3ef-e24b-48ec-b2c5-000058f1308f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-30T14:02:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 68cf6df3-0438-4923-90f1-0000746b8694
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a311a38d-1603-4acc-2b8e-08d865497380
x-ms-traffictypediagnostic: DM5PR12MB1642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16421580368E7786FB50BF07FC330@DM5PR12MB1642.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDt2XTqdYv8NRocR2UfX8ebPQVQKJdhmjQhV5G8VCAPgEM2PtscXI1bb8cjl11bHdHdr3dhSeYL6OpuRgbCJrfELLNVrNbNnODROgcYK//+nlI5b6xtXWFToyA+4unps6Wsunaw+NPkMRZmphHN41Z2TxddTrbrHDUmj9Lm+0gz/oBBjQyydiD+LQrpjNr98Pcv7kFTktw3XeVDu/JTIASaDLxPlB6KfmaeJeQH03l3Pd/n7vYBfkJbH4FQwXaYbshAm7SDxW1Uwf6zDfWR8ZYLQA3sWB0wVpmuX6VqhaFuxUiPkAgxqgIyUeuf0pMPTm9VXIVUDPAxGxJRoZuDlGInAbJBr4Vkkdjed/Tb2IBk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(8676002)(71200400001)(8936002)(55016002)(4326008)(86362001)(33656002)(478600001)(45080400002)(2906002)(76116006)(66946007)(6636002)(110136005)(316002)(53546011)(6506007)(9686003)(186003)(26005)(966005)(83380400001)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5bgPn/EEQVywYx//Hvxp/AMj9ozGONZLAXc9Pk4wE0jtWn2+ai8InmSD+ksz54y6x0esIiKE7GIo2ZtRlVMOD5ezrLr1uk40mJqdk+gFEtIYNH2Jl7rv7V8yhzPv971sIcJe5etQiaRBg0PtuEDe1zQiv9ZR5ZAHNGyvREV8NDQzWopOc6pY4L47YSvXOcuw1i+G/k3lVD79aqOhsnGtkCDlxVe4hr2R2Q7P2diweKpIcLImAhhz7ZjYwVZ2x1cmI87KtbVdmNAd7Y1LwZ7P3s6UhnKpICD1kuRBES90+XX/kGOl9jzWwNAWxxzQ+V7evRy+WBxpjdVzMx+40bT0Uk1BbNa2HZsRldhPyq2SRF9aeRAcQW1V4T/1rryPb8Igt41izBa4VpvP03fIdsB1jMm1BXEF/kAZduagffTw7SBVSZGkMMFx1nHpmh2rj1kn6mW3PC1OO5mGh6bwvPs9WeHh/3nuw5buTvO/Bz5ag5AHJSqDhOg2/U5w8SY2eQ+TzNQjRk5kk+DZh1B/OgyndjDFrzCGComoOowFix0HqiSC3ag7iH6o7iNsW8mvr92NyyMpYyD72/JvfKN5VBTqbThckjvshO5ri8lu1XQuCeBU0rrrWDY+7bi1dXwISabjCrXSYsGDNudF2phuS1MLDQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a311a38d-1603-4acc-2b8e-08d865497380
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 14:02:21.6109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Evg1WWfeeMTILWR/Ir8pJrSb8Q2Sg5r36LPO+3uMifmR+YL6L8uuYRtGGeiKUuy9nGoG34XS+9rroWLMRyeD7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1642
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IE9uIEJlaGFsZiBPZiBHdWNodW4gQ2hlbg0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIg
MzAsIDIwMjAgMjE6NTkNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3REZW5pcywgVG9tIDxU
b20uU3REZW5pc0BhbWQuY29tPg0KQ2M6IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNv
bT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGJ1aWxkIGVycm9yDQoNClJlZ3Jl
c3Npb24gYnkgcGF0Y2g6DQpmZDU4M2M0ZjAxYTcgZHJtL2FtZGdwdTogZHJvcCBkdXBsaWNhdGVk
IGVjYyBjaGVjayBmb3IgdmVnYTEwICh2NCkNCg0KQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhodWJfdjJfMS5vDQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jOiBJbiBmdW5jdGlvbiDigJhnbWNfdjlfMF9sYXRlX2luaXTigJk6DQpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jOjEyMTY6NTk6IGVycm9yOiBleHBlY3RlZCDigJgp4oCZ
IGJlZm9yZSDigJh74oCZIHRva2VuDQogMTIxNiB8ICAgaWYgKCEoYWRldi0+cmFzX2ZlYXR1cmVz
ICYgKDEgPDwgQU1ER1BVX1JBU19CTE9DS19fVU1DKSkgew0KICAgICAgfCAgICAgIH4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICkNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmM6MTIyMDoyOiBlcnJvcjog
ZXhwZWN0ZWQgZXhwcmVzc2lvbiBiZWZvcmUg4oCYfeKAmSB0b2tlbg0KIDEyMjAgfCAgfQ0KICAg
ICAgfCAgXg0KICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLm8N
Cg0KU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQotLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMiArLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMNCmluZGV4IDE1MTY4Njg4OGMzMi4uNmU5ZGUwMmQ1NDU1IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KQEAgLTEyMTMsNyArMTIxMyw3IEBA
IHN0YXRpYyBpbnQgZ21jX3Y5XzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkNCiAJICogd3JpdGVz
LCB3aGlsZSBkaXNhYmxlcyBIQk0gRUNDIGZvciB2ZWdhMTAuDQogCSAqLw0KIAlpZiAoIWFtZGdw
dV9zcmlvdl92ZihhZGV2KSAmJiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEwKSkgew0K
LQkJaWYgKCEoYWRldi0+cmFzX2ZlYXR1cmVzICYgKDEgPDwgQU1ER1BVX1JBU19CTE9DS19fVU1D
KSkgew0KKwkJaWYgKCEoYWRldi0+cmFzX2ZlYXR1cmVzICYgKDEgPDwgQU1ER1BVX1JBU19CTE9D
S19fVU1DKSkpIHsNCiAJCQlpZiAoYWRldi0+ZGYuZnVuY3MtPmVuYWJsZV9lY2NfZm9yY2VfcGFy
X3dyX3JtdykNCiAJCQkJYWRldi0+ZGYuZnVuY3MtPmVuYWJsZV9lY2NfZm9yY2VfcGFyX3dyX3Jt
dyhhZGV2LCBmYWxzZSk7DQogCQl9DQotLSANCjIuMTcuMQ0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmcl
MkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NoYXdraW5n
LnpoYW5nJTQwYW1kLmNvbSU3QzA0NWYxODdmYTg5NjRiYzg2MWU1MDhkODY1NDhmYTczJTdDM2Rk
ODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM3MDcxMjA0MzQ4NDUx
MyZhbXA7c2RhdGE9R1UlMkZKZkZwSkV0V1k1MllvZTUlMkZURjdSS05DMTM5ZjFyTTZOSVFSOXJJ
bk0lM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
