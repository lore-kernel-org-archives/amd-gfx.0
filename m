Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF54FCA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885D6217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D6217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BE96F860;
	Fri,  1 Nov 2019 20:11:56 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC836F860
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSli0+mIH3ESUZ2GOGF5icajBhfAlMLUyVj7l4iJEFH8j8vhDsoWKH8pSXuVwSCiBCXreEgDpm8V4sMHgtHOpYwPdNZ/0f0urNPFcf686CfI/k1PbRLupVKmzNqg/d9wkN2+WF7j9HFhr0wdR+KEn2Ty/rvU053U+Xmfr6D6SYr3EfUS9/hs5ttOjoghOOFPDiq0nghsig7UjmRi645Pl1xy/owEXSLCpEc2ZRI3kFDJMTJoD6wExjtb1zE5NM3JcYvvFnhvVArtHcpENFAQRkU9iCtL84yZp2B4cDE76sRpdgtHZZc+iHK8SPdWsMe3y73cL8J1Y42m93D2J6oJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFTOWsmajGVT1oaS639AEUtj5vc0b7Z1fpULqX7h6ck=;
 b=mSHi6mjDo/v7KRpLHKmH0dNERnsONLP1wjVKjRXJ7SvClmMFJL7MBUCvKJaG2n4U5o07Cd4m/kiyid1Gn2idnF83hLU/z8DzwqzJ63ckNdFl8jsl9ABSb9bcaUlKcNpfnaVFNtoUxEm8PceFaYoCeSXtltim1zPpimfXjXzc7rUck3I65YQGbfJeb+9bNtOtZvRUXeA4QvEbO1XCiPBZ08IUv5yaqR/mevxOJaaDM4mGSdALYT7k1SkM6/R20aci/3hQiuC4qn5EzAMJZfEjloblaUWj1GhaLQj/3AR525QmsV/TyaPmAzWSt+7cM6qR3zjeoeHxPVedGXrSHD8zOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3740.namprd12.prod.outlook.com (10.255.172.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 1 Nov 2019 20:11:52 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:11:52 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Simplify the mmap offset related bit operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVkPCZFRJsMCOEZkSsXpsspPuRWw==
Date: Fri, 1 Nov 2019 20:11:52 +0000
Message-ID: <20191101201138.6125-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbf62c70-efd5-4b90-1346-08d75f07bc52
x-ms-traffictypediagnostic: DM6PR12MB3740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37409A32EBE1C7A44D7D783BF0620@DM6PR12MB3740.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(25786009)(5640700003)(5660300002)(6436002)(6506007)(6486002)(14454004)(486006)(386003)(2616005)(476003)(6916009)(2351001)(2501003)(52116002)(99286004)(256004)(6512007)(36756003)(478600001)(81166006)(2906002)(26005)(8676002)(7736002)(1076003)(186003)(102836004)(316002)(66556008)(81156014)(50226002)(305945005)(4326008)(66476007)(66946007)(64756008)(66446008)(66066001)(3846002)(71200400001)(8936002)(86362001)(6116002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3740;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92UxPw0GGDr1teU2wid4rfVqvqkZI+VC94I0N5k/J2Oyf+0fS0wGgQeqgvIPUJ7MWI7s1TobitK1spPN18W7GXGLJqUe6zwdv/LHLK+YvSH8mWyrQ+y3m2taiqmtX2Iu/VF1o6VaEGksvs7Uq49kywxo0LiIEFPiE00Ee+mjTnMazwsDyX6KEyruKMpiYSkhXPgRvA4vasNJ62FuzwC1ov774YCagyVU20HpgfJ+37JaKmxzzAKfRWqRkmFSlnPD9qjDC/cF0xmKJSNfIrNeC6UNrgL/S/eeE9NoCrmRwzQZ/jcdoC6SUOHPMhMAjY243FH2juTnR+PAfbjNvVwSfZhDGynALPYG6yhoL0krKWFyIv48AekdbKSHwKITalXcuE08gH7vi8pZgwZ2JzItKSj+Pc1CHqpSczJLBT7BDabiu9U0x/Ux/Qfv57IL2Xoa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf62c70-efd5-4b90-1346-08d75f07bc52
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:11:52.6668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCBEhA/lC9XTpldi7TZPm7OzUgKpFSUwQPq9zJDR4/+uTuChnqK8PDP3F6lyUdNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFTOWsmajGVT1oaS639AEUtj5vc0b7Z1fpULqX7h6ck=;
 b=lPWwKfi9WzSI32dzz9DrWzjhqgjfoSHYXLCRUO9XesfrIK1TpPuMD/m6arSU38M8S11KCdPkPgvLje+qd7Prp4H5Yxp5NbBS4jZtkZ5xMc07PMOgY4LL5hOSA78nWTzR697sDLe/cLrVeC/P0rAs8XOsxS5mNpiU++AL4X4CZe4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101201152.bavZiwcmtjs6AY4xzz8EQZOIiZ67FneYZwef7rlv3Kc@z>

VGhlIG5ldyBjb2RlIGlzIG11Y2ggY2xlYW5lciBhbmQgcmVzdWx0cyBpbiBiZXR0ZXIgcmVhZGFi
aWxpdHkuCgpDaGFuZ2UtSWQ6IEkwYzFmN2NjYTdlMjRkZGI3YjRmZmUxY2IwZmE3MTk0MzgyOGFl
MzczClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyB8IDEwICsrKystLS0tLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYyAgfCAgMSAtCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgIHwgIDkgKysrLS0tLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIHwgIDMgKy0tCiA0IGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9jaGFyZGV2LmMKaW5kZXggYjkxOTkzNzUzYjgyLi4zNDA3OGRmMzY2MjEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwpAQCAtMjk4LDcgKzI5OCw2IEBA
IHN0YXRpYyBpbnQga2ZkX2lvY3RsX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgZmlsZSAqZmlsZXAsIHN0
cnVjdCBrZmRfcHJvY2VzcyAqcCwKIAkvKiBSZXR1cm4gZ3B1X2lkIGFzIGRvb3JiZWxsIG9mZnNl
dCBmb3IgbW1hcCB1c2FnZSAqLwogCWFyZ3MtPmRvb3JiZWxsX29mZnNldCA9IEtGRF9NTUFQX1RZ
UEVfRE9PUkJFTEw7CiAJYXJncy0+ZG9vcmJlbGxfb2Zmc2V0IHw9IEtGRF9NTUFQX0dQVV9JRChh
cmdzLT5ncHVfaWQpOwotCWFyZ3MtPmRvb3JiZWxsX29mZnNldCA8PD0gUEFHRV9TSElGVDsKIAlp
ZiAoS0ZEX0lTX1NPQzE1KGRldi0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5KSkKIAkJLyogT24g
U09DMTUgQVNJQ3MsIGluY2x1ZGUgdGhlIGRvb3JiZWxsIG9mZnNldCB3aXRoaW4gdGhlCiAJCSAq
IHByb2Nlc3MgZG9vcmJlbGwgZnJhbWUsIHdoaWNoIGNvdWxkIGJlIDEgcGFnZSBvciAyIHBhZ2Vz
LgpAQCAtMTkzOCwyMCArMTkzNywxOSBAQCBzdGF0aWMgaW50IGtmZF9tbWFwKHN0cnVjdCBmaWxl
ICpmaWxwLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKIHsKIAlzdHJ1Y3Qga2ZkX3Byb2Nl
c3MgKnByb2Nlc3M7CiAJc3RydWN0IGtmZF9kZXYgKmRldiA9IE5VTEw7Ci0JdW5zaWduZWQgbG9u
ZyB2bV9wZ29mZjsKKwl1bnNpZ25lZCBsb25nIG1tYXBfb2Zmc2V0OwogCXVuc2lnbmVkIGludCBn
cHVfaWQ7CiAKIAlwcm9jZXNzID0ga2ZkX2dldF9wcm9jZXNzKGN1cnJlbnQpOwogCWlmIChJU19F
UlIocHJvY2VzcykpCiAJCXJldHVybiBQVFJfRVJSKHByb2Nlc3MpOwogCi0Jdm1fcGdvZmYgPSB2
bWEtPnZtX3Bnb2ZmOwotCXZtYS0+dm1fcGdvZmYgPSBLRkRfTU1BUF9PRkZTRVRfVkFMVUVfR0VU
KHZtX3Bnb2ZmKTsKLQlncHVfaWQgPSBLRkRfTU1BUF9HUFVfSURfR0VUKHZtX3Bnb2ZmKTsKKwlt
bWFwX29mZnNldCA9IHZtYS0+dm1fcGdvZmYgPDwgUEFHRV9TSElGVDsKKwlncHVfaWQgPSBLRkRf
TU1BUF9HRVRfR1BVX0lEKG1tYXBfb2Zmc2V0KTsKIAlpZiAoZ3B1X2lkKQogCQlkZXYgPSBrZmRf
ZGV2aWNlX2J5X2lkKGdwdV9pZCk7CiAKLQlzd2l0Y2ggKHZtX3Bnb2ZmICYgS0ZEX01NQVBfVFlQ
RV9NQVNLKSB7CisJc3dpdGNoIChtbWFwX29mZnNldCAmIEtGRF9NTUFQX1RZUEVfTUFTSykgewog
CWNhc2UgS0ZEX01NQVBfVFlQRV9ET09SQkVMTDoKIAkJaWYgKCFkZXYpCiAJCQlyZXR1cm4gLUVO
T0RFVjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYwppbmRleCA5MDgwODFj
ODVkZTEuLjFmODM2NTU3NWIxMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2V2ZW50cy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVu
dHMuYwpAQCAtMzQ2LDcgKzM0Niw2IEBAIGludCBrZmRfZXZlbnRfY3JlYXRlKHN0cnVjdCBmaWxl
ICpkZXZrZmQsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwKIAkJcmV0ID0gY3JlYXRlX3NpZ25hbF9l
dmVudChkZXZrZmQsIHAsIGV2KTsKIAkJaWYgKCFyZXQpIHsKIAkJCSpldmVudF9wYWdlX29mZnNl
dCA9IEtGRF9NTUFQX1RZUEVfRVZFTlRTOwotCQkJKmV2ZW50X3BhZ2Vfb2Zmc2V0IDw8PSBQQUdF
X1NISUZUOwogCQkJKmV2ZW50X3Nsb3RfaW5kZXggPSBldi0+ZXZlbnRfaWQ7CiAJCX0KIAkJYnJl
YWs7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAppbmRleCA2NmJhZThmMmRhZDEu
LjhlZWNkMmNkMWZkMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCkBAIC01
OSwyNCArNTksMjEgQEAKICAqIE5PVEU6IHN0cnVjdCB2bV9hcmVhX3N0cnVjdC52bV9wZ29mZiB1
c2VzIG9mZnNldCBpbiBwYWdlcy4gSGVuY2UsIHRoZXNlCiAgKiAgZGVmaW5lcyBhcmUgdy5yLnQg
dG8gUEFHRV9TSVpFCiAgKi8KLSNkZWZpbmUgS0ZEX01NQVBfVFlQRV9TSElGVAkoNjIgLSBQQUdF
X1NISUZUKQorI2RlZmluZSBLRkRfTU1BUF9UWVBFX1NISUZUCSg2MikKICNkZWZpbmUgS0ZEX01N
QVBfVFlQRV9NQVNLCSgweDNVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkKICNkZWZpbmUgS0ZE
X01NQVBfVFlQRV9ET09SQkVMTAkoMHgzVUxMIDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpCiAjZGVm
aW5lIEtGRF9NTUFQX1RZUEVfRVZFTlRTCSgweDJVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkK
ICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9SRVNFUlZFRF9NRU0JKDB4MVVMTCA8PCBLRkRfTU1BUF9U
WVBFX1NISUZUKQogI2RlZmluZSBLRkRfTU1BUF9UWVBFX01NSU8JKDB4MFVMTCA8PCBLRkRfTU1B
UF9UWVBFX1NISUZUKQogCi0jZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9TSElGVCAoNDYgLSBQQUdF
X1NISUZUKQorI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfU0hJRlQgKDQ2KQogI2RlZmluZSBLRkRf
TU1BUF9HUFVfSURfTUFTSyAoKCgxVUxMIDw8IEtGRF9HUFVfSURfSEFTSF9XSURUSCkgLSAxKSBc
CiAJCQkJPDwgS0ZEX01NQVBfR1BVX0lEX1NISUZUKQogI2RlZmluZSBLRkRfTU1BUF9HUFVfSUQo
Z3B1X2lkKSAoKCgodWludDY0X3QpZ3B1X2lkKSA8PCBLRkRfTU1BUF9HUFVfSURfU0hJRlQpXAog
CQkJCSYgS0ZEX01NQVBfR1BVX0lEX01BU0spCi0jZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9HRVQo
b2Zmc2V0KSAgICAoKG9mZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKSBcCisjZGVmaW5lIEtG
RF9NTUFQX0dFVF9HUFVfSUQob2Zmc2V0KSAgICAoKG9mZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9N
QVNLKSBcCiAJCQkJPj4gS0ZEX01NQVBfR1BVX0lEX1NISUZUKQogCi0jZGVmaW5lIEtGRF9NTUFQ
X09GRlNFVF9WQUxVRV9NQVNLCSgweDNGRkZGRkZGRkZGRlVMTCA+PiBQQUdFX1NISUZUKQotI2Rl
ZmluZSBLRkRfTU1BUF9PRkZTRVRfVkFMVUVfR0VUKG9mZnNldCkgKG9mZnNldCAmIEtGRF9NTUFQ
X09GRlNFVF9WQUxVRV9NQVNLKQotCiAvKgogICogV2hlbiB3b3JraW5nIHdpdGggY3Agc2NoZWR1
bGVyIHdlIHNob3VsZCBhc3NpZ24gdGhlIEhJUSBtYW51YWxseSBvciB2aWEKICAqIHRoZSBhbWRn
cHUgZHJpdmVyIHRvIGEgZml4ZWQgaHFkIHNsb3QsIGhlcmUgYXJlIHRoZSBmaXhlZCBISVEgaHFk
IHNsb3QKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCmluZGV4IDZhYmZi
NzdhZTU0MC4uMzlkYzQ5YjhmZDg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfcHJvY2Vzcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cm9jZXNzLmMKQEAgLTU1NCw4ICs1NTQsNyBAQCBzdGF0aWMgaW50IGtmZF9wcm9jZXNzX2luaXRf
Y3dzcl9hcHUoc3RydWN0IGtmZF9wcm9jZXNzICpwLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCiAJCWlm
ICghZGV2LT5jd3NyX2VuYWJsZWQgfHwgcXBkLT5jd3NyX2thZGRyIHx8IHFwZC0+Y3dzcl9iYXNl
KQogCQkJY29udGludWU7CiAKLQkJb2Zmc2V0ID0gKEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVN
IHwgS0ZEX01NQVBfR1BVX0lEKGRldi0+aWQpKQotCQkJPDwgUEFHRV9TSElGVDsKKwkJb2Zmc2V0
ID0gS0ZEX01NQVBfVFlQRV9SRVNFUlZFRF9NRU0gfCBLRkRfTU1BUF9HUFVfSUQoZGV2LT5pZCk7
CiAJCXFwZC0+dGJhX2FkZHIgPSAoaW50NjRfdCl2bV9tbWFwKGZpbGVwLCAwLAogCQkJS0ZEX0NX
U1JfVEJBX1RNQV9TSVpFLCBQUk9UX1JFQUQgfCBQUk9UX0VYRUMsCiAJCQlNQVBfU0hBUkVELCBv
ZmZzZXQpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
