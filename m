Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B11C33C8C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A310222D3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A310222D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52526EE96;
	Tue, 19 Nov 2019 09:12:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF77F6EE98
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 09:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpIRFI6/f4Ks4xXBTwKF5XYVoz4t6fHDof0AOusIasJMrn4TmkbTgBXryU8GrKwTwkOwGugWOjAQuvF6EfNsSpDRCroQ5sapoWtCqtDXAddwq7864I9UUyUFl1OIR+20jcJtKwMrXXrkjMMjM7nv+FHNK3okpWeVN8S9mUc0vK1ogJSI38+Faql6jGhWmpfUOixZYp31nWSkESzCw7cbfEU4xHpzC/wtp447/75G7YRl52zqsFpiO0Eu/87ViGgDSoHJ2kfiiD1GOV5Hir+yuNMSU/ZUCSpART43mTQr8GfRs2/b7ats0zZY+BqNdaTfsXbQ9rQNQ9sM2QoHy0Lz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+TBvSOTGWrU44nW5p4dB/dtGNDpaDypES3kLIPcVoA=;
 b=GddFMbjae0L5MditCt+Y0+h0MiDtBW9CmkoY8QnsuqraGpXND0Q1Pb+vzjPg1qJ/8OH+tLIpKmW6JkGYbzKHvpNXG1ckfLjNNiKYPhHBJfX3+cBw8Sz0oM9di5wx/ayxRloLGvNhYUSRzlA1xJA0YJoO62Z1UqpYgElhNegmhWObawoECN5u6tlyEsiW+sB4NBB+59GM4ieH4MSzKt6prDkSIHfkYD7rO99H9/LkSwDm0ksEo6WDjvrk2vs0lqrWnN9tSyoBWX5d5gGCSa6vsj0TTR/8kvtaAjXG8aPIb8+RbnJQjwz0ky7xcPTDAL11OfMZ5sodEUTv1aNl0qMOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3840.namprd12.prod.outlook.com (10.255.239.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.24; Tue, 19 Nov 2019 09:12:10 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 09:12:10 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: Christian.Koenig@amd.com, Jack.Xiao@amd.com, Tao.Zhou1@amd.com,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: initialize vm_inv_eng0_sem for gfxhub and
 mmhub
Date: Tue, 19 Nov 2019 17:11:49 +0800
Message-Id: <20191119091149.4543-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 549920f8-b3e2-4c5a-c645-08d76cd08eb1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3840AF7E195684E3D365B630FD4C0@MN2PR12MB3840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(48376002)(6666004)(6512007)(66476007)(66946007)(66066001)(50226002)(66556008)(4326008)(47776003)(186003)(99286004)(3846002)(6116002)(81156014)(81166006)(5660300002)(8676002)(2906002)(1076003)(478600001)(14454004)(36756003)(25786009)(6506007)(8936002)(386003)(51416003)(52116002)(50466002)(476003)(6436002)(486006)(6486002)(26005)(86362001)(2616005)(316002)(7736002)(305945005)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3840;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrWsdjlKkXD42ADXc0H9ocV0c/BRrCbEYn0wR3kFb3FzHNvCp5BS4rD3GbNnGtdE4PfQ6kf5dfozZ/qbAW+ZdBOtu9Nc0co1h8Z1QeNp/tBoHC02qGeYsbpJxyL5m2T3HSat4M5Ws78yxolQnix8MyS25/OXlf1MVQ7i7uJWY9TBfKSeTGgAvUJI4Mu5QWUF1QTvkUYDvVKXDj+4xVuuZoPUzHm6ntomgLxIH5S5EpXoKQjVaXA5nrEIu7RoHGCeJ2MDYL17hIQwBIUlICPtsZbKTNxVJ6+umIuW5B8RT/wo3FRwjrZu8/hPW5ypzbtfL6a4C+BILAw7kcvLLhpIP3sJcyJ3AcOG2n8iwhjhmC55r48l3g78gKd3KCm/gPmFn7z5Nwbhq1gwdNgfJQQOsaNrb2naGYHaH26cfZwHJMxtB9MucI+ZmA5hJ4nwB/gs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549920f8-b3e2-4c5a-c645-08d76cd08eb1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 09:12:10.1485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3wDX1YX3r2SR2yPxV0M4eIXvcbgG6Aj8T4+qOHQvvU/XshSRXhXYuJzIsVzSKHU6aMgHW2ZMMZ2DAX7Sfx6XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+TBvSOTGWrU44nW5p4dB/dtGNDpaDypES3kLIPcVoA=;
 b=0A3533MUj3H+6vl4h9PpQGSiOVPq5yttTVOueWOjfhHBWrdE4CuGeMhPAjX2UF5EY7y9hxEBGRuwCbxbw5RJ3HkXy8yRfGXNzFg92vDwh69GaysaU6WzIm567dIVidpsUTZNMpKmJSMj39HjWFUmt91ml0JAxzUTTkOeqEuniag=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119091149.viUEvSe24ELledlcwzoCi-sXgqs-cBxk5NeHE3qkEBk@z>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KClNXIG11c3QgYWNxdWlyZS9y
ZWxlYXNlIG9uZSBvZiB0aGUgdm1faW52YWxpZGF0ZV9lbmcqX3NlbSBhcm91bmQgdGhlCmludmFs
aWRhdGlvbiByZXEvYWNrLiBUaHJvdWdoIHRoaXMgd2F5LGl0IGNhbiBhdm9pZCBsb3NpbmcgaW52
YWxpZGF0ZQphY2tub3dsZWRnZSBzdGF0ZSBhY3Jvc3MgcG93ZXItZ2F0aW5nIG9mZiBjeWNsZS4K
VG8gdXNlIHZtX2ludmFsaWRhdGVfZW5nKl9zZW0sIGl0IG5lZWRzIHRvIGluaXRpYWxpemUKdm1f
aW52YWxpZGF0ZV9lbmcqX3NlbSBmaXJzdGx5LgoKQ2hhbmdlLUlkOiBJYzdhYmY0ODFiMDhkZjA4
NWMzMjZhOThlYmE0YjAwZDc4ZjMzNTYwYwpTaWduZWQtb2ZmLWJ5OiBjaGFuZ3podSA8Q2hhbmdm
ZW5nLlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuaCAgfCAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8wLmMgfCAy
ICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jIHwgMiArKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5jICB8IDIgKysKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYyAgfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tbWh1Yl92OV80LmMgIHwgNCArKysrCiA2IGZpbGVzIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKaW5kZXggNDA2
NzM2YTFiZDNkLi5iNDk5YTNkZThiYjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmgKQEAgLTc3LDYgKzc3LDcgQEAgc3RydWN0IGFtZGdwdV9nbWNfZmF1bHQgewogc3Ry
dWN0IGFtZGdwdV92bWh1YiB7CiAJdWludDMyX3QJY3R4MF9wdGJfYWRkcl9sbzMyOwogCXVpbnQz
Ml90CWN0eDBfcHRiX2FkZHJfaGkzMjsKKwl1aW50MzJfdAl2bV9pbnZfZW5nMF9zZW07CiAJdWlu
dDMyX3QJdm1faW52X2VuZzBfcmVxOwogCXVpbnQzMl90CXZtX2ludl9lbmcwX2FjazsKIAl1aW50
MzJfdAl2bV9jb250ZXh0MF9jbnRsOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4aHViX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92
MV8wLmMKaW5kZXggOWVjNDI5N2U2MWU1Li5lOTFiZDc5NDU3NzcgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYwpAQCAtMzY3LDYgKzM2Nyw4IEBAIHZvaWQgZ2Z4aHVi
X3YxXzBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlodWItPmN0eDBfcHRiX2Fk
ZHJfaGkzMiA9CiAJCVNPQzE1X1JFR19PRkZTRVQoR0MsIDAsCiAJCQkJIG1tVk1fQ09OVEVYVDBf
UEFHRV9UQUJMRV9CQVNFX0FERFJfSEkzMik7CisJaHViLT52bV9pbnZfZW5nMF9zZW0gPQorCQlT
T0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVZNX0lOVkFMSURBVEVfRU5HMF9TRU0pOwogCWh1Yi0+
dm1faW52X2VuZzBfcmVxID0KIAkJU09DMTVfUkVHX09GRlNFVChHQywgMCwgbW1WTV9JTlZBTElE
QVRFX0VORzBfUkVRKTsKIAlodWItPnZtX2ludl9lbmcwX2FjayA9CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4aHViX3YyXzAuYwppbmRleCBiNGYzMmQ4NTNjYTEuLmI3MGM3YjQ4M2MyNCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzAuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jCkBAIC0zNTYsNiArMzU2
LDggQEAgdm9pZCBnZnhodWJfdjJfMF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
CWh1Yi0+Y3R4MF9wdGJfYWRkcl9oaTMyID0KIAkJU09DMTVfUkVHX09GRlNFVChHQywgMCwKIAkJ
CQkgbW1HQ1ZNX0NPTlRFWFQwX1BBR0VfVEFCTEVfQkFTRV9BRERSX0hJMzIpOworCWh1Yi0+dm1f
aW52X2VuZzBfc2VtID0KKwkJU09DMTVfUkVHX09GRlNFVChHQywgMCwgbW1HQ1ZNX0lOVkFMSURB
VEVfRU5HMF9TRU0pOwogCWh1Yi0+dm1faW52X2VuZzBfcmVxID0KIAkJU09DMTVfUkVHX09GRlNF
VChHQywgMCwgbW1HQ1ZNX0lOVkFMSURBVEVfRU5HMF9SRVEpOwogCWh1Yi0+dm1faW52X2VuZzBf
YWNrID0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzAuYwppbmRleCA2OTY1ZTFl
NmZhOWUuLjI4MTA1ZTRhZjUwNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbW1odWJfdjFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Yx
XzAuYwpAQCAtNDIwLDYgKzQyMCw4IEBAIHZvaWQgbW1odWJfdjFfMF9pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCWh1Yi0+Y3R4MF9wdGJfYWRkcl9oaTMyID0KIAkJU09DMTVfUkVH
X09GRlNFVChNTUhVQiwgMCwKIAkJCQkgbW1WTV9DT05URVhUMF9QQUdFX1RBQkxFX0JBU0VfQURE
Ul9ISTMyKTsKKwlodWItPnZtX2ludl9lbmcwX3NlbSA9CisJCVNPQzE1X1JFR19PRkZTRVQoTU1I
VUIsIDAsIG1tVk1fSU5WQUxJREFURV9FTkcwX1NFTSk7CiAJaHViLT52bV9pbnZfZW5nMF9yZXEg
PQogCQlTT0MxNV9SRUdfT0ZGU0VUKE1NSFVCLCAwLCBtbVZNX0lOVkFMSURBVEVfRU5HMF9SRVEp
OwogCWh1Yi0+dm1faW52X2VuZzBfYWNrID0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L21taHViX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHVi
X3YyXzAuYwppbmRleCA5NDU1MzM2MzQ3MTEuLmE3Y2IxODVkNjM5YSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYwpAQCAtMzQ4LDYgKzM0OCw4IEBAIHZvaWQgbW1odWJf
djJfMF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWh1Yi0+Y3R4MF9wdGJfYWRk
cl9oaTMyID0KIAkJU09DMTVfUkVHX09GRlNFVChNTUhVQiwgMCwKIAkJCQkgbW1NTVZNX0NPTlRF
WFQwX1BBR0VfVEFCTEVfQkFTRV9BRERSX0hJMzIpOworCWh1Yi0+dm1faW52X2VuZzBfc2VtID0K
KwkJU09DMTVfUkVHX09GRlNFVChNTUhVQiwgMCwgbW1NTVZNX0lOVkFMSURBVEVfRU5HMF9TRU0p
OwogCWh1Yi0+dm1faW52X2VuZzBfcmVxID0KIAkJU09DMTVfUkVHX09GRlNFVChNTUhVQiwgMCwg
bW1NTVZNX0lOVkFMSURBVEVfRU5HMF9SRVEpOwogCWh1Yi0+dm1faW52X2VuZzBfYWNrID0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwppbmRleCAyYzVhZGZlODAzYTIuLjY2
ZWZlMmY3YmQ3NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJf
djlfNC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwpAQCAt
NTA0LDYgKzUwNCwxMCBAQCB2b2lkIG1taHViX3Y5XzRfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAkJCVNPQzE1X1JFR19PRkZTRVQoTU1IVUIsIDAsCiAJCQkgICAgbW1WTUwyVkMw
X1ZNX0NPTlRFWFQwX1BBR0VfVEFCTEVfQkFTRV9BRERSX0hJMzIpICsKIAkJCSAgICBpICogTU1I
VUJfSU5TVEFOQ0VfUkVHSVNURVJfT0ZGU0VUOworCQlodWJbaV0tPnZtX2ludl9lbmcwX3NlbSA9
CisJCQlTT0MxNV9SRUdfT0ZGU0VUKE1NSFVCLCAwLAorCQkJCQkgbW1WTUwyVkMwX1ZNX0lOVkFM
SURBVEVfRU5HMF9TRU0pICsKKwkJCQkJIGkgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZT
RVQ7CiAJCWh1YltpXS0+dm1faW52X2VuZzBfcmVxID0KIAkJCVNPQzE1X1JFR19PRkZTRVQoTU1I
VUIsIDAsCiAJCQkJCSBtbVZNTDJWQzBfVk1fSU5WQUxJREFURV9FTkcwX1JFUSkgKwotLSAKMi4x
Ny4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
