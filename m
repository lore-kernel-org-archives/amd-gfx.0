Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA3CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D8C217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D8C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CE06F873;
	Fri,  1 Nov 2019 20:48:34 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820083.outbound.protection.outlook.com [40.107.82.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459EA6F873
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUpmY7GiJx0bhwsVjN8Pe1aG56tM+KDc/WRE0V/C/rVtxnw1s0UKeF7WFpeJcgILSHHTVhaCJrtdUdZexXmo/zMfHHxSL6ak97x0DVR2aBzhdjpqQ6U7Rs5LtkAEkLUEZPaVsVt1IAu9yGSPZnYl9V3cu6x35KmZAw/Qh67ERwh4mODo+2Evd3iTy84OOF1kuyiEkelz7deLlqgHcO4yEyng08DCm7SeqYXyL733mc1SCn2PIUS/x7qLiSbd8mggOgyLjIBa25WmosjasMKcNFQwGfjK0rEor0Q7UwAQQM0l3SmmEnzOwnALEVwaENmcRAVSaXobzsHZVU1UVcrILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8xUoh5rnBrvfo9Wbq/aCeTsoLsKOC7ZZ7bs2cWYToU=;
 b=ZvRJ8+R4kVmhIRA/hHcTPQFtdKt+WfeBKxl9YJog0HHLgfjGqAEpOmwlUDPAqzhsjMQzhqGneWEwPc9YtyqGfnXz21Rkm5wO2ub7fAWv4uP1UUhNVTQZr3pgasfsG+xlWIh/fYR2O6LxBPC0O9XAQWXZ+ztU5AH3YzjpqE/FrHprvcdq5aFhl2HIhbeR6dRQ/DM07pEacS3nB4K0NsBbIBBUegoZ9fO4AjCrp5VZyrMNmXwFiLIvn/Z/Kw2Mbx4+dZ9ECFCynfz+ZovnLEvkzX0aLnmSiVir++ZGU7JcAYCcCpqBXecYHmmQPs5Ym82qlTe+o1ppZ1BI6KhRsntcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB4186.namprd12.prod.outlook.com (10.141.186.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Fri, 1 Nov 2019 20:48:30 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:48:30 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Simplify the mmap offset related bit operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVkPW3xyVHQwVd5kGLa7uEKtffqg==
Date: Fri, 1 Nov 2019 20:48:30 +0000
Message-ID: <20191101204818.8125-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::44) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8869fd83-4df4-427a-11cf-08d75f0cda53
x-ms-traffictypediagnostic: DM6PR12MB4186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4186CA7E73B86B3A353F574AF0620@DM6PR12MB4186.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(7736002)(2906002)(256004)(25786009)(71200400001)(81166006)(50226002)(316002)(8676002)(6116002)(81156014)(71190400001)(4326008)(36756003)(3846002)(2351001)(14454004)(66446008)(66476007)(66556008)(8936002)(64756008)(66946007)(478600001)(52116002)(476003)(486006)(1076003)(2501003)(6486002)(6512007)(5660300002)(102836004)(386003)(2616005)(5640700003)(186003)(6436002)(6506007)(305945005)(6916009)(99286004)(26005)(66066001)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4186;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DH2/N5WgSBMktIH9DfkarcWn5icEOpS7UrVYHzSjGG0dOjsOZI9bNWrPfzB0/euH6SR99XdCly26pLjb4Zos2tjZRA72R6Oz0htfZjQ8X4Mmzern4PBxVwtfYw2WZfW9wVGJoe72tUJAL7z9o/nnEurnPir+DRcOuL8FmyDnkTa97F+8OHLcuwNBvxkkOjMEmEr8bjtp2/zOClKfkK7n8W7eYPlRLTKPEq3P0HTWCmhnss9bTrh/kWoq0i0whwDlo1NahyxKTOUbuFVDpvtTv+T56x9v0EGgPGGwKRIu9p0G0pTvSOdLfcpEDnuJaDw3gD4o1uuMOSkrgeNYTmX8rCo5VDEPL5cuLm56UZaHk3NtdGejTmucTv5+3lPE7Cjk1ejVjKO1LZLXnexGE3B4+cCr/s/CDu2hMTD7Xq5lG7URoPLMwJRNuiFi5MTmiRwi
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8869fd83-4df4-427a-11cf-08d75f0cda53
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:48:30.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWPdt5Ecged5CdwCtMlFTReV87aC19s/hO6+SjhFcaGHU7V4FUZ0qE3utzyYIMRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8xUoh5rnBrvfo9Wbq/aCeTsoLsKOC7ZZ7bs2cWYToU=;
 b=N73x5xyOOOtXGokwPE18tuJ4q2y1L02/bszQYPcz2Wov63rWcPkd24wGLjGEBg7C5qS/gbwrPGPz3d+tjo7vBGQNxtl4yXbATDocdhRsWHz/DZYSZb+kWQvzPmokqW4UxDBaEGIxUMil5pnahgzpg5Ugv76gWEPFR0YoHaYYc+A=
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
Message-ID: <20191101204830.gPXuVhcSLrSEdUW8OzTLwh6YbUuxCR00qDbpbtPxtfE@z>

VGhlIG5ldyBjb2RlIGlzIG11Y2ggY2xlYW5lciBhbmQgcmVzdWx0cyBpbiBiZXR0ZXIgcmVhZGFi
aWxpdHkuCgpDaGFuZ2UtSWQ6IEkwYzFmN2NjYTdlMjRkZGI3YjRmZmUxY2IwZmE3MTk0MzgyOGFl
MzczClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyB8IDEzICsrKysrKystLS0tLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYyAgfCAgMSAtCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgIHwgIDkgKysrLS0tLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIHwgIDMgKy0tCiA0IGZpbGVzIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfY2hhcmRldi5jCmluZGV4IGI5MTk5Mzc1M2I4Mi4uNTkwMTM4NzI3Y2E5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKQEAgLTI5OCw3ICsyOTgs
NiBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF9jcmVhdGVfcXVldWUoc3RydWN0IGZpbGUgKmZpbGVw
LCBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsCiAJLyogUmV0dXJuIGdwdV9pZCBhcyBkb29yYmVsbCBv
ZmZzZXQgZm9yIG1tYXAgdXNhZ2UgKi8KIAlhcmdzLT5kb29yYmVsbF9vZmZzZXQgPSBLRkRfTU1B
UF9UWVBFX0RPT1JCRUxMOwogCWFyZ3MtPmRvb3JiZWxsX29mZnNldCB8PSBLRkRfTU1BUF9HUFVf
SUQoYXJncy0+Z3B1X2lkKTsKLQlhcmdzLT5kb29yYmVsbF9vZmZzZXQgPDw9IFBBR0VfU0hJRlQ7
CiAJaWYgKEtGRF9JU19TT0MxNShkZXYtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSkpCiAJCS8q
IE9uIFNPQzE1IEFTSUNzLCBpbmNsdWRlIHRoZSBkb29yYmVsbCBvZmZzZXQgd2l0aGluIHRoZQog
CQkgKiBwcm9jZXNzIGRvb3JiZWxsIGZyYW1lLCB3aGljaCBjb3VsZCBiZSAxIHBhZ2Ugb3IgMiBw
YWdlcy4KQEAgLTE5MzgsMjAgKzE5MzcsMjIgQEAgc3RhdGljIGludCBrZmRfbW1hcChzdHJ1Y3Qg
ZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCiB7CiAJc3RydWN0IGtmZF9w
cm9jZXNzICpwcm9jZXNzOwogCXN0cnVjdCBrZmRfZGV2ICpkZXYgPSBOVUxMOwotCXVuc2lnbmVk
IGxvbmcgdm1fcGdvZmY7CisJdW5zaWduZWQgbG9uZyBtbWFwX29mZnNldDsKIAl1bnNpZ25lZCBp
bnQgZ3B1X2lkOwogCiAJcHJvY2VzcyA9IGtmZF9nZXRfcHJvY2VzcyhjdXJyZW50KTsKIAlpZiAo
SVNfRVJSKHByb2Nlc3MpKQogCQlyZXR1cm4gUFRSX0VSUihwcm9jZXNzKTsKIAotCXZtX3Bnb2Zm
ID0gdm1hLT52bV9wZ29mZjsKLQl2bWEtPnZtX3Bnb2ZmID0gS0ZEX01NQVBfT0ZGU0VUX1ZBTFVF
X0dFVCh2bV9wZ29mZik7Ci0JZ3B1X2lkID0gS0ZEX01NQVBfR1BVX0lEX0dFVCh2bV9wZ29mZik7
CisJbW1hcF9vZmZzZXQgPSB2bWEtPnZtX3Bnb2ZmIDw8IFBBR0VfU0hJRlQ7CisJZ3B1X2lkID0g
S0ZEX01NQVBfR0VUX0dQVV9JRChtbWFwX29mZnNldCk7CiAJaWYgKGdwdV9pZCkKIAkJZGV2ID0g
a2ZkX2RldmljZV9ieV9pZChncHVfaWQpOwogCi0Jc3dpdGNoICh2bV9wZ29mZiAmIEtGRF9NTUFQ
X1RZUEVfTUFTSykgeworCS8qIG9ubHkgbGVhdmUgdGhlIG9mZnNldCBzZWdtZW50ICovCisJdm1h
LT52bV9wZ29mZiAmPSAoMVVMTCA8PCAoS0ZEX01NQVBfR1BVX0lEX1NISUZUIC0gUEFHRV9TSElG
VCkpIC0gMTsKKworCXN3aXRjaCAobW1hcF9vZmZzZXQgJiBLRkRfTU1BUF9UWVBFX01BU0spIHsK
IAljYXNlIEtGRF9NTUFQX1RZUEVfRE9PUkJFTEw6CiAJCWlmICghZGV2KQogCQkJcmV0dXJuIC1F
Tk9ERVY7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMKaW5kZXggOTA4MDgx
Yzg1ZGUxLi4xZjgzNjU1NzViMTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9ldmVudHMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZl
bnRzLmMKQEAgLTM0Niw3ICszNDYsNiBAQCBpbnQga2ZkX2V2ZW50X2NyZWF0ZShzdHJ1Y3QgZmls
ZSAqZGV2a2ZkLCBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsCiAJCXJldCA9IGNyZWF0ZV9zaWduYWxf
ZXZlbnQoZGV2a2ZkLCBwLCBldik7CiAJCWlmICghcmV0KSB7CiAJCQkqZXZlbnRfcGFnZV9vZmZz
ZXQgPSBLRkRfTU1BUF9UWVBFX0VWRU5UUzsKLQkJCSpldmVudF9wYWdlX29mZnNldCA8PD0gUEFH
RV9TSElGVDsKIAkJCSpldmVudF9zbG90X2luZGV4ID0gZXYtPmV2ZW50X2lkOwogCQl9CiAJCWJy
ZWFrOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKaW5kZXggNjZiYWU4ZjJkYWQx
Li44ZWVjZDJjZDFmZDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcml2LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaApAQCAt
NTksMjQgKzU5LDIxIEBACiAgKiBOT1RFOiBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qudm1fcGdvZmYg
dXNlcyBvZmZzZXQgaW4gcGFnZXMuIEhlbmNlLCB0aGVzZQogICogIGRlZmluZXMgYXJlIHcuci50
IHRvIFBBR0VfU0laRQogICovCi0jZGVmaW5lIEtGRF9NTUFQX1RZUEVfU0hJRlQJKDYyIC0gUEFH
RV9TSElGVCkKKyNkZWZpbmUgS0ZEX01NQVBfVFlQRV9TSElGVAkoNjIpCiAjZGVmaW5lIEtGRF9N
TUFQX1RZUEVfTUFTSwkoMHgzVUxMIDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpCiAjZGVmaW5lIEtG
RF9NTUFQX1RZUEVfRE9PUkJFTEwJKDB4M1VMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQogI2Rl
ZmluZSBLRkRfTU1BUF9UWVBFX0VWRU5UUwkoMHgyVUxMIDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQp
CiAjZGVmaW5lIEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVNCSgweDFVTEwgPDwgS0ZEX01NQVBf
VFlQRV9TSElGVCkKICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9NTUlPCSgweDBVTEwgPDwgS0ZEX01N
QVBfVFlQRV9TSElGVCkKIAotI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfU0hJRlQgKDQ2IC0gUEFH
RV9TSElGVCkKKyNkZWZpbmUgS0ZEX01NQVBfR1BVX0lEX1NISUZUICg0NikKICNkZWZpbmUgS0ZE
X01NQVBfR1BVX0lEX01BU0sgKCgoMVVMTCA8PCBLRkRfR1BVX0lEX0hBU0hfV0lEVEgpIC0gMSkg
XAogCQkJCTw8IEtGRF9NTUFQX0dQVV9JRF9TSElGVCkKICNkZWZpbmUgS0ZEX01NQVBfR1BVX0lE
KGdwdV9pZCkgKCgoKHVpbnQ2NF90KWdwdV9pZCkgPDwgS0ZEX01NQVBfR1BVX0lEX1NISUZUKVwK
IAkJCQkmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKQotI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfR0VU
KG9mZnNldCkgICAgKChvZmZzZXQgJiBLRkRfTU1BUF9HUFVfSURfTUFTSykgXAorI2RlZmluZSBL
RkRfTU1BUF9HRVRfR1BVX0lEKG9mZnNldCkgICAgKChvZmZzZXQgJiBLRkRfTU1BUF9HUFVfSURf
TUFTSykgXAogCQkJCT4+IEtGRF9NTUFQX0dQVV9JRF9TSElGVCkKIAotI2RlZmluZSBLRkRfTU1B
UF9PRkZTRVRfVkFMVUVfTUFTSwkoMHgzRkZGRkZGRkZGRkZVTEwgPj4gUEFHRV9TSElGVCkKLSNk
ZWZpbmUgS0ZEX01NQVBfT0ZGU0VUX1ZBTFVFX0dFVChvZmZzZXQpIChvZmZzZXQgJiBLRkRfTU1B
UF9PRkZTRVRfVkFMVUVfTUFTSykKLQogLyoKICAqIFdoZW4gd29ya2luZyB3aXRoIGNwIHNjaGVk
dWxlciB3ZSBzaG91bGQgYXNzaWduIHRoZSBISVEgbWFudWFsbHkgb3IgdmlhCiAgKiB0aGUgYW1k
Z3B1IGRyaXZlciB0byBhIGZpeGVkIGhxZCBzbG90LCBoZXJlIGFyZSB0aGUgZml4ZWQgSElRIGhx
ZCBzbG90CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vz
cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwppbmRleCA2YWJm
Yjc3YWU1NDAuLjM5ZGM0OWI4ZmQ4NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jCkBAIC01NTQsOCArNTU0LDcgQEAgc3RhdGljIGludCBrZmRfcHJvY2Vzc19pbml0
X2N3c3JfYXB1KHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwgc3RydWN0IGZpbGUgKmZpbGVwKQogCQlp
ZiAoIWRldi0+Y3dzcl9lbmFibGVkIHx8IHFwZC0+Y3dzcl9rYWRkciB8fCBxcGQtPmN3c3JfYmFz
ZSkKIAkJCWNvbnRpbnVlOwogCi0JCW9mZnNldCA9IChLRkRfTU1BUF9UWVBFX1JFU0VSVkVEX01F
TSB8IEtGRF9NTUFQX0dQVV9JRChkZXYtPmlkKSkKLQkJCTw8IFBBR0VfU0hJRlQ7CisJCW9mZnNl
dCA9IEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVNIHwgS0ZEX01NQVBfR1BVX0lEKGRldi0+aWQp
OwogCQlxcGQtPnRiYV9hZGRyID0gKGludDY0X3Qpdm1fbW1hcChmaWxlcCwgMCwKIAkJCUtGRF9D
V1NSX1RCQV9UTUFfU0laRSwgUFJPVF9SRUFEIHwgUFJPVF9FWEVDLAogCQkJTUFQX1NIQVJFRCwg
b2Zmc2V0KTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
