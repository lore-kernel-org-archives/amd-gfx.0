Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5039C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96698219F6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96698219F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACA76EDFD;
	Tue, 19 Nov 2019 09:13:13 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam05on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe51::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB5A6EA5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 09:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byi8cc38H/IUm1jQhXOR7+lBu0ILCmkuLk03tgf9nRYBZtyaKGNj+wsEEUKyb5mFHndQvAIvWuXd0CO4kBFlyska8hdXbY209pSqlmkP0zM2DEK2F667dQCuZHamYY36zD3E1hd1g6gByqwKOH3Vcn5XbFC+Vt2bvVsvOtliYN7+rMg2RWCfGzti9pUfs3ASi25eVYi3W2BRJbixdAZhbV3eH1HrEyxDmAfd/yIGRcMxmQ3d9F6nkXPkqc7BrLv4Cw7VnUFpExSAliACwN6u+8DTcvYmPEaixwVV9fgQgzuU6nOdnP2VOVhktidl2iULOiMhJWAOXfgT6f++iopEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz3qVm+p1HekyIYS2NoAD1/2BlRKTdQLJxJocQQOEi8=;
 b=PIIcaflQA2/GSVFz52wJyTqepJKnO+WT1Eh4RFTmtCAswUUHA6ghZ2zoMxjn1bjN1hFWVJvhtUQi1a4DdHT/SL1gVm/d2VZHiHzvPXE9kNielrgD4RSTSrZZm/JTbJz6lrR4OXgxn528FCVSwNCr6qO8+EpCQwd6falqHnOlT4mi9ZPm3tWMx/Iph+z+JeP2m24sHj2WV0MiJT5wtpjvzx4iwBEXhYDIuD+BsL4eXsTEnbFHMWZrS9akh1SJalkWS/J3u2nmmT5Pi1+sD83h7ER5IPWXWcdcpX4XgCr64vX84LkM/lZhQ+v33LnMN6kk8M+jpk9orwvkMs2aTCyTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3199.namprd12.prod.outlook.com (20.179.81.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 19 Nov 2019 09:13:08 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 09:13:08 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: Christian.Koenig@amd.com, Jack.Xiao@amd.com, Tao.Zhou1@amd.com,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: invalidate semphore workaround in amdgpu_virt
Date: Tue, 19 Nov 2019 17:12:47 +0800
Message-Id: <20191119091247.4596-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:2e::23) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13b29dc5-8edc-4522-4514-08d76cd0b188
X-MS-TrafficTypeDiagnostic: MN2PR12MB3199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3199EF1F67760C50ADA1300EFD4C0@MN2PR12MB3199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(6486002)(6436002)(316002)(16586007)(5660300002)(14444005)(6512007)(8936002)(51416003)(50226002)(1076003)(4326008)(52116002)(86362001)(8676002)(81156014)(81166006)(99286004)(186003)(36756003)(50466002)(48376002)(478600001)(26005)(66556008)(66476007)(66946007)(6506007)(386003)(305945005)(47776003)(6666004)(7736002)(3846002)(486006)(2616005)(476003)(6116002)(14454004)(66066001)(2906002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3199;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzM9NXtI3XdE/eE33xaJZbCqTG2CUaqWO1sAu22htpy1kX8fY7lmzFn6s8jnQztu0PdFyq9l1PeDoPCXLU7HrtZ7Bw0UDzBlAui1rgBdT2L+5tm+dqzSyZmuhKisrcLuWW5blDaJd23aAcEsm+QQ9VFCG/4rEwu8n8EMP1G3bM3kavLUXAVSp4aYNhoGW+qIlKZYYmouhb6wPYkC5c3c8OKXQpJJdpfOnLbbDdqjOvAfxxEV/r6PQ5o9sTr+/+3yHqgUP0a8Q5M9ps/50ttReqZy4L025cIYGnqw1ZRPJ4AqrRQFk7FSWD5R72RQ5h9oqErHWN5QXBIE7kJNXZb5gQjAMAe1VQv4FtbzMxYN9p58zANmzTq1pZRdiXPw5Op4tyCCVVnHBLHwOQTuitSYCWQGMquyDmyD+Wbj/HuClI0DJCzjt+bTRHCR2+wioXSg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b29dc5-8edc-4522-4514-08d76cd0b188
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 09:13:08.6338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7Vmjo7iyunXmcSUU5fpL0mfifnSHnokM4ZsUxG0FzL7Wd2GyB+GJlPomxB2kDgftQpLWAXFPwfQdGIZdGHWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3199
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz3qVm+p1HekyIYS2NoAD1/2BlRKTdQLJxJocQQOEi8=;
 b=WRomjtR8poS8F9bfWc1aqbQfcutllMSPocGBi1IGjeVTvNGjWefcfewmlIr+imVJ2YQoW2gR7vC/juo1liSrKgF5kbB5OEiH3NviweDgAkdggMGSnMo2P/EqIUbBpCp6aKrdb06hR58Ff4iW6oXWCdpSfAgZ40sKYY6lBzdkQ6I=
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
Message-ID: <20191119091247.gqfv4ZYy26Aur_nUi0yctvM4uMSi1U6YGDovk7Cl1BU@z>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KCkl0IG1heSBsb3NlIGdwdXZt
IGludmFsaWRhdGUgYWNrbm93bGRlZ2Ugc3RhdGUgYWNyb3NzIHBvd2VyLWdhdGluZyBvZmYKY3lj
bGUuIFRvIGF2b2lkIHRoaXMgaXNzdWUgaW4gdmlydCBpbnZhbGlkYXRpb24sIGFkZCBzZW1hcGhv
cmUgYWNxdWlyZQpiZWZvcmUgaW52YWxpZGF0aW9uIGFuZCBzZW1hcGhvcmUgcmVsZWFzZSBhZnRl
ciBpbnZhbGlkYXRpb24uCgpDaGFuZ2UtSWQ6IEllOTgzMDRlNDc1MTY2YjUzZWVkMDMzNDYyZDc2
NDIzYjZiMGZjMjViClNpZ25lZC1vZmYtYnk6IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyB8IDIyICsr
KysrKysrKysrKysrKysrKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmggfCAgMyArKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICAg
fCAgMyArKy0KIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwppbmRleCBmMDRlYjFh
NjQyNzEuLmVlNTc2MTU4NTQ1ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZpcnQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmlydC5jCkBAIC0xMzUsNyArMTM1LDggQEAgdm9pZCBhbWRncHVfdmlydF9raXFfd3JlZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2KQogCiB2b2lk
IGFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAJCQkJCXVpbnQzMl90IHJlZzAsIHVpbnQzMl90IHJlZzEsCi0JCQkJCXVpbnQzMl90
IHJlZiwgdWludDMyX3QgbWFzaykKKwkJCQkJdWludDMyX3QgcmVmLCB1aW50MzJfdCBtYXNrLAor
CQkJCQl1aW50MzJfdCBzZW0pCiB7CiAJc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5n
Zngua2lxOwogCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZraXEtPnJpbmc7CkBAIC0xNDQs
OSArMTQ1LDI2IEBAIHZvaWQgYW1kZ3B1X3ZpcnRfa2lxX3JlZ193cml0ZV9yZWdfd2FpdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl1aW50MzJfdCBzZXE7CiAKIAlzcGluX2xvY2tfaXJx
c2F2ZSgma2lxLT5yaW5nX2xvY2ssIGZsYWdzKTsKLQlhbWRncHVfcmluZ19hbGxvYyhyaW5nLCAz
Mik7CisJYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgNjApOworCisJLyoKKwkgKiBJdCBtYXkgbG9z
ZSBncHV2bSBpbnZhbGlkYXRlIGFja25vd2xkZWdlIHN0YXRlIGFjcm9zcyBwb3dlci1nYXRpbmcK
KwkgKiBvZmYgY3ljbGUsIGFkZCBzZW1hcGhvcmUgYWNxdWlyZSBiZWZvcmUgaW52YWxpZGF0aW9u
IGFuZCBzZW1hcGhvcmUKKwkgKiByZWxlYXNlIGFmdGVyIGludmFsaWRhdGlvbiB0byBhdm9pZCBl
bnRlcmluZyBwb3dlciBnYXRlZCBzdGF0ZQorCSAqIHRvIFdBIHRoZSBJc3N1ZQorCSAqLworCisJ
LyogYSByZWFkIHJldHVybiB2YWx1ZSBvZiAxIG1lYW5zIHNlbWFwaG9yZSBhY3VxaXJlICovCisJ
YW1kZ3B1X3JpbmdfZW1pdF9yZWdfd2FpdChyaW5nLCBzZW0sIDB4MSwgMHgxKTsKKwogCWFtZGdw
dV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0KHJpbmcsIHJlZzAsIHJlZzEsCiAJCQkJCSAg
ICByZWYsIG1hc2spOworCS8qCisJICogYWRkIHNlbWFwaG9yZSByZWxlYXNlIGFmdGVyIGludmFs
aWRhdGlvbiwKKwkgKiB3cml0ZSB3aXRoIDAgbWVhbnMgc2VtYXBob3JlIHJlbGVhc2UKKwkgKi8K
KwlhbWRncHVfcmluZ19lbWl0X3dyZWcocmluZywgc2VtLCAwKTsKKwogCWFtZGdwdV9mZW5jZV9l
bWl0X3BvbGxpbmcocmluZywgJnNlcSk7CiAJYW1kZ3B1X3JpbmdfY29tbWl0KHJpbmcpOwogCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmtpcS0+cmluZ19sb2NrLCBmbGFncyk7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaAppbmRleCBiMGIyYmRjNzUwZGYuLmJkYTZhMmYz
N2RjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oCkBAIC0yOTUs
NyArMjk1LDggQEAgdWludDMyX3QgYW1kZ3B1X3ZpcnRfa2lxX3JyZWcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJlZyk7CiB2b2lkIGFtZGdwdV92aXJ0X2tpcV93cmVnKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHYpOwogdm9p
ZCBhbWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogCQkJCQl1aW50MzJfdCByZWcwLCB1aW50MzJfdCBycmVnMSwKLQkJCQkJdWludDMy
X3QgcmVmLCB1aW50MzJfdCBtYXNrKTsKKwkJCQkJdWludDMyX3QgcmVmLCB1aW50MzJfdCBtYXNr
LAorCQkJCQl1aW50MzJfdCBzZW0pOwogaW50IGFtZGdwdV92aXJ0X3JlcXVlc3RfZnVsbF9ncHUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgaW5pdCk7CiBpbnQgYW1kZ3B1X3ZpcnRf
cmVsZWFzZV9mdWxsX2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBpbml0KTsK
IGludCBhbWRncHVfdmlydF9yZXNldF9ncHUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKaW5kZXggZjI1Y2Q5N2JhNWYyLi4xYWU1
OWFmNzgzNmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpAQCAtNDQ4LDkg
KzQ0OCwxMCBAQCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAogCQkJIWFkZXYtPmluX2dwdV9yZXNldCkg
ewogCQl1aW50MzJfdCByZXEgPSBodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZzsKIAkJdWludDMy
X3QgYWNrID0gaHViLT52bV9pbnZfZW5nMF9hY2sgKyBlbmc7CisJCXVpbnQzMl90IHNlbSA9IGh1
Yi0+dm1faW52X2VuZzBfc2VtICsgZW5nOwogCiAJCWFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVf
cmVnX3dhaXQoYWRldiwgcmVxLCBhY2ssIHRtcCwKLQkJCQkxIDw8IHZtaWQpOworCQkJCQkJICAg
MSA8PCB2bWlkLCBzZW0pOwogCQlyZXR1cm47CiAJfQogCi0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
