Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35391C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EE120640
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EE120640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A216EA62;
	Tue,  3 Dec 2019 17:56:17 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F3E6EA62
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 17:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJyfd6RROzxWMCvkbkKjBS1zwRG5DvmIIqnUET6uDlC5ryR7mgQVXetnjFUMRZQ9iMJ/DLWedr8U0b4mN+N6LYajs75SVhTlrbRJJfSwFDIAm/XVDk7duYMELjYLuOHTFbb1/ApTPd+rHxXwM5DKl2g9X+ovrRcY5fZB5m7fkOTAN7gVWh45q+uKDxor18Yt8/+psw8o79HlsluPQa3daLmnJz4/DM+VK+wZvuXk0y/AMNEm0h9zwen7SeWtSLGkHrC258Epe7E1xBTnGiofYhL2Fgpphf3+SlI15I6g8SnnLqdI6w0J3x8RAjk7BYAnCCh/1M8zkThKIAmPHbhlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FAU3zJVUIRO0BjgEwC1EgfE/ZvgGEcJxKR9MOuf1CI=;
 b=ZY4tZUVcFoQJI5p3IK/tjtwwWVQEp+wq3rdtn7kbXj0cZndbdu1HbYm4Gf10Qsdmj1PucvmXYIBOeRGEDAIDRdIZwlhuHVkdivoHqxSJfIHSNrIVH15Ni4GPoSwFj08ge5UFVOO8b822pxx7F5T3dbtvBwN7g4iUiRCKGT59Dr7EH6r174mam7YTIrJomca5xYVPZ+RP8tdbGcGEGC369QEGUJenJj2QyuquWcJFfpLtWeq6xeisvoSUnwRdx0YQqL5ermkkB8r+Wyyac2paL4kn+QYAo1LRC9veKCB4cNlb16O84BnrxPq5jafwq8P1vr+Ys6CyaDL9MSL2wQCwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2339.namprd12.prod.outlook.com (52.132.11.148) by
 BL0PR12MB2516.namprd12.prod.outlook.com (52.132.11.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 17:56:15 +0000
Received: from BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::9c32:dffe:31f5:49ca]) by BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::9c32:dffe:31f5:49ca%2]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 17:56:15 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Loading NV10/14 Bounding Box Data
 Directly from Code
Thread-Topic: [PATCH v2] drm/amd/display: Loading NV10/14 Bounding Box Data
 Directly from Code
Thread-Index: AQHVqgIIPXfgrFdP9kGrKKoo8NmefqeosaRA
Date: Tue, 3 Dec 2019 17:56:15 +0000
Message-ID: <BL0PR12MB23398BC7580F74C1BE4CD445FD420@BL0PR12MB2339.namprd12.prod.outlook.com>
References: <20191203174921.9357-1-zhan.liu@amd.com>
In-Reply-To: <20191203174921.9357-1-zhan.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-03T17:56:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=728d07a3-6afa-4426-a671-0000f4a344db;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-03T17:56:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4c6108ed-7fdc-45a9-8422-00002a69b995
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72206b1d-6124-4415-1d17-08d7781a1745
x-ms-traffictypediagnostic: BL0PR12MB2516:|BL0PR12MB2516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB251622C88DE5EE2F09BC40C0FD420@BL0PR12MB2516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(13464003)(189003)(199004)(2906002)(8676002)(76116006)(8936002)(66446008)(66556008)(74316002)(66476007)(76176011)(7696005)(66946007)(6116002)(11346002)(3846002)(52536014)(71190400001)(64756008)(53546011)(26005)(446003)(71200400001)(186003)(6506007)(110136005)(99286004)(102836004)(316002)(6636002)(5660300002)(9686003)(6436002)(55016002)(229853002)(2501003)(14454004)(81166006)(81156014)(7736002)(6246003)(4326008)(305945005)(86362001)(33656002)(478600001)(25786009)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2516;
 H:BL0PR12MB2339.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3nhk0aBjfK466qa/wTMCeHXvizgcj7P9b/sNH3o0hFoHlNjlpzhzK9BpW8XG6smU/Geox9a79FX/Q+R/EbHN3XO4oNEO5KgjceUkiigN/GDCHw/SEvwrh3uEoRaCWq6ZThvtxIN484WJZd/MHKPe1EUYjTFuSYcKMRzbEjSRhhifqzDsVUnkf+k60DgMMzIJ0KC5Ab3cAr/mOYf8mv7lPOXorLTqn+dTcfYJHrl5z5p/ofEmf2hbIsywStDjNiR0qjFu0PyFSBxsOP1uzYxHJzBqQOETPimXSyfmT8gJ40lwqGdb0fDylTfvQQI1lhBpPlOXdruNIM//2LEfikkyeIMg29wsq3FBqEgBESTXav2Dm/iSlbEbUmVNwPeuxNmXxRRGS55xk3Ih3/eHZ7aR2NMBVPhd+3B6Q2a/YL66z5SVDbf/IA2zcU2CI15+CZK
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72206b1d-6124-4415-1d17-08d7781a1745
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 17:56:15.0243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMfEE09eo60S0Tq9E6ppI7TS7ju3AebMAyAl8CiIpVgvv8ggyC6E1LdE6ZImw5zgKBhGx8clLK0XRhmASaXjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2516
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FAU3zJVUIRO0BjgEwC1EgfE/ZvgGEcJxKR9MOuf1CI=;
 b=GviWW9RUxFIO9fAYqwh7OUsqB7h1pmYot2A31i1vhcacNN4EHN0OAUKUGcAHtdhV+ctB2hretinTx5+D+CPLixqM+8EPRp/cjx2lkJ19gHm1TwaOLRxnTFeXBgc2isBqo7uycLYkb/xo5EOJS5dz/qS+VdgmPxGjqwsN/zk2CMQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hersenxs.wu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQoKClJl
dmlld2VkLWJ5OiBoZXJzZW4gd3UgPCBoZXJzZW54cy53dUBhbWQuY29tPgoKLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KRnJvbTogTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPiAKU2VudDog
VHVlc2RheSwgRGVjZW1iZXIgMywgMjAxOSAxMjo0OSBQTQpUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IFd1LCBIZXJzZW4gPGhlcnNlbnhzLnd1QGFtZC5jb20+OyBLYXpsYXVza2Fz
LCBOaWNob2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPgpDYzogTGl1LCBaaGFuIDxa
aGFuLkxpdUBhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWQvZGlzcGxheTogTG9h
ZGluZyBOVjEwLzE0IEJvdW5kaW5nIEJveCBEYXRhIERpcmVjdGx5IGZyb20gQ29kZQoKW1doeV0K
TlYxMC8xNCBoYXMgcmVsZWFzZWQuIEl0cyB0aW1lIHRvIGdldCBOVjEwLzE0IGJvdW5kaW5nIGJv
eCBkaXJlY3RseSBmcm9tIGNvZGUuCgpbSG93XQpSZXRyaWV2ZSBOVjEwLzE0IGJvdW5kaW5nIGJv
eCBkYXRhIGRpcmVjdGx5IGZyb20gY29kZS4KUmV0cmlldmUgTlYxMiBib3VuZGluZyBib3ggZGF0
YSBmcm9tIGZpcm13YXJlLgoKU2lnbmVkLW9mZi1ieTogWmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291
cmNlLmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
bjIwL2RjbjIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfcmVzb3VyY2UuYwppbmRleCAyY2NmZDg0YTdkYTQuLjJhMTU4ZmY1ZjBhNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291
cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jl
c291cmNlLmMKQEAgLTgzLDggKzgzLDYgQEAKIAogI2luY2x1ZGUgImFtZGdwdV9zb2NiYi5oIgog
Ci0vKiBOVjEyIFNPQyBCQiBpcyBjdXJyZW50bHkgaW4gRlcsIG1hcmsgU1cgYm91bmRpbmcgYm94
IGludmFsaWQuICovIC0jZGVmaW5lIFNPQ19CT1VORElOR19CT1hfVkFMSUQgZmFsc2UgICNkZWZp
bmUgRENfTE9HR0VSX0lOSVQobG9nZ2VyKQogCiBzdHJ1Y3QgX3Zjc19kcGlfaXBfcGFyYW1zX3N0
IGRjbjJfMF9pcCA9IHsgQEAgLTMyNzEsMTIgKzMyNjksMTMgQEAgc3RhdGljIGJvb2wgaW5pdF9z
b2NfYm91bmRpbmdfYm94KHN0cnVjdCBkYyAqZGMsCiAKIAlEQ19MT0dHRVJfSU5JVChkYy0+Y3R4
LT5sb2dnZXIpOwogCi0JaWYgKCFiYiAmJiAhU09DX0JPVU5ESU5HX0JPWF9WQUxJRCkgeworCS8q
IFRPRE86IHVwc3RyZWFtIE5WMTIgYm91bmRpbmcgYm94IHdoZW4gaXRzIGxhdW5jaGVkICovCisJ
aWYgKCFiYiAmJiBBU0lDUkVWX0lTX05BVkkxMl9QKGRjLT5jdHgtPmFzaWNfaWQuaHdfaW50ZXJu
YWxfcmV2KSkgewogCQlEQ19MT0dfRVJST1IoIiVzOiBub3QgdmFsaWQgc29jIGJvdW5kaW5nIGJv
eC9uIiwgX19mdW5jX18pOwogCQlyZXR1cm4gZmFsc2U7CiAJfQogCi0JaWYgKGJiICYmICFTT0Nf
Qk9VTkRJTkdfQk9YX1ZBTElEKSB7CisJaWYgKGJiICYmIEFTSUNSRVZfSVNfTkFWSTEyX1AoZGMt
PmN0eC0+YXNpY19pZC5od19pbnRlcm5hbF9yZXYpKSB7CiAJCWludCBpOwogCiAJCWRjbjJfMF9u
djEyX3NvYy5zcl9leGl0X3RpbWVfdXMgPQotLQoyLjE3LjEKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
