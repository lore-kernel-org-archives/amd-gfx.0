Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BCC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2B42085B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2B42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1576F759;
	Thu,  7 Nov 2019 17:33:48 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720059.outbound.protection.outlook.com [40.107.72.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7C76F759
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 17:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PracsXkjJW7r3diBkhDFVHwMkU++bXq6L18oRsatQLIQ25WCMZlPppEY419/jXQL0aeH2lRqq3WoN6gKiMeSWQAADWiF6OkaVPMG8ugVdi9mXAN6WMC4su3eK0siAJLbWS044Q397f0hetYXvVOJGq0LUUV7cv+HeHwSHLUqtJadLAP/QLMNw6MSYtdQ/Sa5lZNgHP+MLUpSMHMksrUCF+T0YNILr0015/GwOSypoj6sdh16zi5g+Wq1sqOrBzY5Nun3sYdtOYAujeiQRI+ddI0wnUFNd7n8BildtAjvO+IZo2aHHKN8VooudI5qIe5yd7ejZykWKKYIi44emwF3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQUTItLGiSQs+Kd3irTWJLceNudeyURDQVAa3Te4e5k=;
 b=TV0p7I0aKyUJZMH0mv/Acp7a3moH9qruvxYfxVZXrkD456uSHYzJw6BZl+qZlEFpnRvB7/0V2Q8QrjMEM9l6Tou7nXd+QXuUxuyc8b2uUKvd8FQEce4PcznAO30HzemIsHgflq9V7StNSBen/pN4Mu/vDR3SqejpV5IJTf46hQbEqoj3ovduKuY3Mtzn45JzrA3rBUeTrkluvTpqpKzzqSibmxEKOkP0rZPS9TRmtOmQCi0Lq3GtQGq8O5G7n8s4uFVKJh4y5fE4+TKRIpn99qP9SztiPhBZ2en50FDLyn3oeXHWS9H4s8wxk6iUFZpcwKBW/kDQZ6o7Itu9glI59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3291.namprd12.prod.outlook.com (20.179.106.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 7 Nov 2019 17:33:44 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 17:33:44 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Simplify the mmap offset related bit operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVlZGAfmrIt3RmZEW8tSKMosYzEw==
Date: Thu, 7 Nov 2019 17:33:44 +0000
Message-ID: <20191107173330.20703-1-Yong.Zhao@amd.com>
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
x-ms-office365-filtering-correlation-id: 7bc0b6ed-00e0-487d-eda2-08d763a8a350
x-ms-traffictypediagnostic: DM6PR12MB3291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB329108C51A39FC1B40C8DC53F0780@DM6PR12MB3291.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(5640700003)(14454004)(478600001)(25786009)(305945005)(2501003)(7736002)(6916009)(6486002)(6436002)(6512007)(36756003)(2906002)(8936002)(86362001)(81166006)(8676002)(81156014)(50226002)(4326008)(386003)(71190400001)(316002)(1076003)(66066001)(66946007)(99286004)(5660300002)(256004)(52116002)(3846002)(486006)(2616005)(476003)(6116002)(2351001)(71200400001)(66446008)(64756008)(66556008)(66476007)(102836004)(26005)(186003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3291;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zl8hS78RyvM//Orgdzx1H8HiktQorylfJDRV0zRqTaQNgEgdeDO9y51sQOIo+DzGDoEoXTGkz08O/Ws76JoJD+v9Lpp7AA+k/jT73QdTYmbnnfJtn6x4mWPsmQdn/I2SWxNkNmFWMB7dXM6td4WqTe5nSixmwIdHtr3cKVmmu24T/KA5q4vtnTW5h/+iNwuF0TnOFveyZdJmDiFiWPJqcHFBRIfm3NFjRVMLusxaUrWjbZX+4J+IPCz4DdpSZgKgFAzXbNCYUsq5ZKHI9FdgXPEH2sXWU+Flgo6iDHRN2iWO2IBFNX/3DrutQBojANDWYCcAzg/S+2cPN6dsP1JdT5V47AeQhquRYeXaLxet0O2JDNk6NNBH7KksIyUMQWn3lJMe+9kHbndINFI7u0AG7Y51q2JbX3cWDcSq1Eoi6cXt6JsSL2HPefW1ed6PeJMm
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc0b6ed-00e0-487d-eda2-08d763a8a350
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:33:44.4988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9kkwiFdxs1Uao6gxvCoeAWx2SdSxepYGk5MhM7HJNKDSgrQlYpTc2DHbUKM6txm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQUTItLGiSQs+Kd3irTWJLceNudeyURDQVAa3Te4e5k=;
 b=z8X8zrOeUB/CEaqAPp+YiGXyb/uSXMY5PH1lYzXYJmB4F2FWQiH24E6hM/rpl78n7HrhcZgkPAF/yrwumM4/e8FvkwcSU0X6MBRrxpDZiqczupjpnQchcvcdJVfOAOicKVsd2Yw5dzX3GSw3AV30W6ztCc9ei9qIG2JNDqsLnY8=
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
Message-ID: <20191107173344.vdvXzxPAfgm7ZTKmJZkT2mCiOyl8wLTk-YnetCHRaBc@z>

VGhlIG5ldyBjb2RlIHVzZXMgc3RyYWlnaHRmb3J3YXJkIGJpdCBzaGlmdHMgYW5kIHRodXMgaGFz
IGJldHRlciByZWFkYWJpbGl0eS4KCkNoYW5nZS1JZDogSTBjMWY3Y2NhN2UyNGRkYjdiNGZmZTFj
YjBmYTcxOTQzODI4YWUzNzMKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMTcg
KysrKysrKy0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMu
YyAgfCAgMSAtCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgIHwgIDkg
KysrLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIHwgIDMg
Ky0tCiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCmluZGV4IGI5MTk5Mzc1M2I4
Mi4uZTU5YzIyOTg2MWU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfY2hhcmRldi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2
LmMKQEAgLTI5OCw3ICsyOTgsNiBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF9jcmVhdGVfcXVldWUo
c3RydWN0IGZpbGUgKmZpbGVwLCBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsCiAJLyogUmV0dXJuIGdw
dV9pZCBhcyBkb29yYmVsbCBvZmZzZXQgZm9yIG1tYXAgdXNhZ2UgKi8KIAlhcmdzLT5kb29yYmVs
bF9vZmZzZXQgPSBLRkRfTU1BUF9UWVBFX0RPT1JCRUxMOwogCWFyZ3MtPmRvb3JiZWxsX29mZnNl
dCB8PSBLRkRfTU1BUF9HUFVfSUQoYXJncy0+Z3B1X2lkKTsKLQlhcmdzLT5kb29yYmVsbF9vZmZz
ZXQgPDw9IFBBR0VfU0hJRlQ7CiAJaWYgKEtGRF9JU19TT0MxNShkZXYtPmRldmljZV9pbmZvLT5h
c2ljX2ZhbWlseSkpCiAJCS8qIE9uIFNPQzE1IEFTSUNzLCBpbmNsdWRlIHRoZSBkb29yYmVsbCBv
ZmZzZXQgd2l0aGluIHRoZQogCQkgKiBwcm9jZXNzIGRvb3JiZWxsIGZyYW1lLCB3aGljaCBjb3Vs
ZCBiZSAxIHBhZ2Ugb3IgMiBwYWdlcy4KQEAgLTEzMTIsMTAgKzEzMTEsOSBAQCBzdGF0aWMgaW50
IGtmZF9pb2N0bF9hbGxvY19tZW1vcnlfb2ZfZ3B1KHN0cnVjdCBmaWxlICpmaWxlcCwKIAkvKiBN
TUlPIGlzIG1hcHBlZCB0aHJvdWdoIGtmZCBkZXZpY2UKIAkgKiBHZW5lcmF0ZSBhIGtmZCBtbWFw
IG9mZnNldAogCSAqLwotCWlmIChmbGFncyAmIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX01NSU9f
UkVNQVApIHsKLQkJYXJncy0+bW1hcF9vZmZzZXQgPSBLRkRfTU1BUF9UWVBFX01NSU8gfCBLRkRf
TU1BUF9HUFVfSUQoYXJncy0+Z3B1X2lkKTsKLQkJYXJncy0+bW1hcF9vZmZzZXQgPDw9IFBBR0Vf
U0hJRlQ7Ci0JfQorCWlmIChmbGFncyAmIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX01NSU9fUkVN
QVApCisJCWFyZ3MtPm1tYXBfb2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9NTUlPCisJCQkJCXwgS0ZE
X01NQVBfR1BVX0lEKGFyZ3MtPmdwdV9pZCk7CiAKIAlyZXR1cm4gMDsKIApAQCAtMTkzOCwyMCAr
MTkzNiwxOSBAQCBzdGF0aWMgaW50IGtmZF9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSkKIHsKIAlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2Nlc3M7CiAJ
c3RydWN0IGtmZF9kZXYgKmRldiA9IE5VTEw7Ci0JdW5zaWduZWQgbG9uZyB2bV9wZ29mZjsKKwl1
bnNpZ25lZCBsb25nIG1tYXBfb2Zmc2V0OwogCXVuc2lnbmVkIGludCBncHVfaWQ7CiAKIAlwcm9j
ZXNzID0ga2ZkX2dldF9wcm9jZXNzKGN1cnJlbnQpOwogCWlmIChJU19FUlIocHJvY2VzcykpCiAJ
CXJldHVybiBQVFJfRVJSKHByb2Nlc3MpOwogCi0Jdm1fcGdvZmYgPSB2bWEtPnZtX3Bnb2ZmOwot
CXZtYS0+dm1fcGdvZmYgPSBLRkRfTU1BUF9PRkZTRVRfVkFMVUVfR0VUKHZtX3Bnb2ZmKTsKLQln
cHVfaWQgPSBLRkRfTU1BUF9HUFVfSURfR0VUKHZtX3Bnb2ZmKTsKKwltbWFwX29mZnNldCA9IHZt
YS0+dm1fcGdvZmYgPDwgUEFHRV9TSElGVDsKKwlncHVfaWQgPSBLRkRfTU1BUF9HRVRfR1BVX0lE
KG1tYXBfb2Zmc2V0KTsKIAlpZiAoZ3B1X2lkKQogCQlkZXYgPSBrZmRfZGV2aWNlX2J5X2lkKGdw
dV9pZCk7CiAKLQlzd2l0Y2ggKHZtX3Bnb2ZmICYgS0ZEX01NQVBfVFlQRV9NQVNLKSB7CisJc3dp
dGNoIChtbWFwX29mZnNldCAmIEtGRF9NTUFQX1RZUEVfTUFTSykgewogCWNhc2UgS0ZEX01NQVBf
VFlQRV9ET09SQkVMTDoKIAkJaWYgKCFkZXYpCiAJCQlyZXR1cm4gLUVOT0RFVjsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYwppbmRleCA5MDgwODFjODVkZTEuLjFmODM2NTU3
NWIxMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYwpAQCAtMzQ2LDcg
KzM0Niw2IEBAIGludCBrZmRfZXZlbnRfY3JlYXRlKHN0cnVjdCBmaWxlICpkZXZrZmQsIHN0cnVj
dCBrZmRfcHJvY2VzcyAqcCwKIAkJcmV0ID0gY3JlYXRlX3NpZ25hbF9ldmVudChkZXZrZmQsIHAs
IGV2KTsKIAkJaWYgKCFyZXQpIHsKIAkJCSpldmVudF9wYWdlX29mZnNldCA9IEtGRF9NTUFQX1RZ
UEVfRVZFTlRTOwotCQkJKmV2ZW50X3BhZ2Vfb2Zmc2V0IDw8PSBQQUdFX1NISUZUOwogCQkJKmV2
ZW50X3Nsb3RfaW5kZXggPSBldi0+ZXZlbnRfaWQ7CiAJCX0KIAkJYnJlYWs7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3ByaXYuaAppbmRleCA2NmJhZThmMmRhZDEuLjhlZWNkMmNkMWZkMiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCkBAIC01OSwyNCArNTksMjEgQEAK
ICAqIE5PVEU6IHN0cnVjdCB2bV9hcmVhX3N0cnVjdC52bV9wZ29mZiB1c2VzIG9mZnNldCBpbiBw
YWdlcy4gSGVuY2UsIHRoZXNlCiAgKiAgZGVmaW5lcyBhcmUgdy5yLnQgdG8gUEFHRV9TSVpFCiAg
Ki8KLSNkZWZpbmUgS0ZEX01NQVBfVFlQRV9TSElGVAkoNjIgLSBQQUdFX1NISUZUKQorI2RlZmlu
ZSBLRkRfTU1BUF9UWVBFX1NISUZUCSg2MikKICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9NQVNLCSgw
eDNVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkKICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9ET09S
QkVMTAkoMHgzVUxMIDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpCiAjZGVmaW5lIEtGRF9NTUFQX1RZ
UEVfRVZFTlRTCSgweDJVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkKICNkZWZpbmUgS0ZEX01N
QVBfVFlQRV9SRVNFUlZFRF9NRU0JKDB4MVVMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQogI2Rl
ZmluZSBLRkRfTU1BUF9UWVBFX01NSU8JKDB4MFVMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQog
Ci0jZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9TSElGVCAoNDYgLSBQQUdFX1NISUZUKQorI2RlZmlu
ZSBLRkRfTU1BUF9HUFVfSURfU0hJRlQgKDQ2KQogI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfTUFT
SyAoKCgxVUxMIDw8IEtGRF9HUFVfSURfSEFTSF9XSURUSCkgLSAxKSBcCiAJCQkJPDwgS0ZEX01N
QVBfR1BVX0lEX1NISUZUKQogI2RlZmluZSBLRkRfTU1BUF9HUFVfSUQoZ3B1X2lkKSAoKCgodWlu
dDY0X3QpZ3B1X2lkKSA8PCBLRkRfTU1BUF9HUFVfSURfU0hJRlQpXAogCQkJCSYgS0ZEX01NQVBf
R1BVX0lEX01BU0spCi0jZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9HRVQob2Zmc2V0KSAgICAoKG9m
ZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKSBcCisjZGVmaW5lIEtGRF9NTUFQX0dFVF9HUFVf
SUQob2Zmc2V0KSAgICAoKG9mZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKSBcCiAJCQkJPj4g
S0ZEX01NQVBfR1BVX0lEX1NISUZUKQogCi0jZGVmaW5lIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9N
QVNLCSgweDNGRkZGRkZGRkZGRlVMTCA+PiBQQUdFX1NISUZUKQotI2RlZmluZSBLRkRfTU1BUF9P
RkZTRVRfVkFMVUVfR0VUKG9mZnNldCkgKG9mZnNldCAmIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9N
QVNLKQotCiAvKgogICogV2hlbiB3b3JraW5nIHdpdGggY3Agc2NoZWR1bGVyIHdlIHNob3VsZCBh
c3NpZ24gdGhlIEhJUSBtYW51YWxseSBvciB2aWEKICAqIHRoZSBhbWRncHUgZHJpdmVyIHRvIGEg
Zml4ZWQgaHFkIHNsb3QsIGhlcmUgYXJlIHRoZSBmaXhlZCBISVEgaHFkIHNsb3QKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCmluZGV4IDZhYmZiNzdhZTU0MC4uMzlkYzQ5
YjhmZDg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vz
cy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMKQEAgLTU1
NCw4ICs1NTQsNyBAQCBzdGF0aWMgaW50IGtmZF9wcm9jZXNzX2luaXRfY3dzcl9hcHUoc3RydWN0
IGtmZF9wcm9jZXNzICpwLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCiAJCWlmICghZGV2LT5jd3NyX2Vu
YWJsZWQgfHwgcXBkLT5jd3NyX2thZGRyIHx8IHFwZC0+Y3dzcl9iYXNlKQogCQkJY29udGludWU7
CiAKLQkJb2Zmc2V0ID0gKEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVNIHwgS0ZEX01NQVBfR1BV
X0lEKGRldi0+aWQpKQotCQkJPDwgUEFHRV9TSElGVDsKKwkJb2Zmc2V0ID0gS0ZEX01NQVBfVFlQ
RV9SRVNFUlZFRF9NRU0gfCBLRkRfTU1BUF9HUFVfSUQoZGV2LT5pZCk7CiAJCXFwZC0+dGJhX2Fk
ZHIgPSAoaW50NjRfdCl2bV9tbWFwKGZpbGVwLCAwLAogCQkJS0ZEX0NXU1JfVEJBX1RNQV9TSVpF
LCBQUk9UX1JFQUQgfCBQUk9UX0VYRUMsCiAJCQlNQVBfU0hBUkVELCBvZmZzZXQpOwotLSAKMi4x
Ny4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
