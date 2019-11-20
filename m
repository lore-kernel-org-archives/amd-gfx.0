Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4723C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 09:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23312186D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 09:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23312186D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587696E11D;
	Wed, 20 Nov 2019 09:44:08 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1FE6E11D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 09:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToDyUkFMfHStogpwmSBS6w2ThcQMDOWpdcWNv8x+Rl/zSfAr/GDI4MNk/mhpW9UpeiV3SAaS3yvBxdHW0w0L8AV0BE79a1aorKsTCXfICDDq8G7Z4FuE92JzH28fewiC5nldg3kReI3xGFPQH6R12bzXaKr2MxQ72cDW/HBsEaWnIAJZmI8VerY16hyBShVumKBToamokQLYJogte9LtVYssMw+7yBcXwTtFAhSYoD+UvwMKJd2ZmkUd+1zjL0aK8jVSV/bVgutOgbfOEyl4/0lWgHApxurZ9sbV8TOy1zSdSC2MCupU/GflmsG5P0fJ2ECytWJZ49yD6CUxV7YQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnOxaPFriroygBcXdgG4/H363SVoKFKnusIPoNO2v9Y=;
 b=OU6JXY/M3DabDGTx8iunGZn7ml9NHKeEIM4R4L3QmQd3z/7aP+eOztS0exQBti3xTQu2jUmCZ1oKQamKg46lRiJtWuerDPxCg/TsHS29glN5UI8fxrkGNe0U4LtdvMJ19b3sfwi2x2AdvsFCKXDq84fBj1e8BIRM/9sYiuV8w1oFxwbabqk3S6XI089ykwslHiebmtR8QuCNERZV4dLPV7UfOFV7iKTxqk+sKyzZTOuJkAkrP2H5PVSFvx2e2CqVu/VQzN+c5p1T+iPxKyK4F1uqrs8PvYwTasU+PAnnDyPLEjCbZoghUg5sOpSZKAyF43gpi4XuwaxV1FSnjSGg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3982.namprd12.prod.outlook.com (10.255.238.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 09:44:02 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 09:44:02 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: Christian.Koenig@amd.com, Jack.Xiao@amd.com, Tao.Zhou1@amd.com,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: invalidate mmhub semphore workaround in
 amdgpu_virt
Date: Wed, 20 Nov 2019 17:14:18 +0800
Message-Id: <20191120091418.26526-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7e2fc11-4562-4e73-b3ae-08d76d9e2cd7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3982A60FCB1A79B0AC18B052FD4F0@MN2PR12MB3982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(47776003)(50226002)(486006)(6436002)(6486002)(66066001)(6512007)(16586007)(316002)(476003)(2906002)(2616005)(7736002)(48376002)(5660300002)(14444005)(305945005)(66556008)(478600001)(66476007)(66946007)(6666004)(50466002)(25786009)(86362001)(26005)(51416003)(52116002)(6506007)(1076003)(386003)(8676002)(99286004)(3846002)(6116002)(81166006)(81156014)(8936002)(14454004)(4326008)(36756003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3982;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyTZSIYlV2h5qIyGvLkYvXAn3ZdkKV94cO1aSaHSq3L/oXkpJ37gsa7gXJoTZvGB7jznKOPOiCi7WtnMrMw92EIm6KjKFSSpBnETewZ7V8VHqiAVeB913XUrFxRR2zFzxiHtbMy8N34WyQABOfrZndrXj6Z5ChKaAFJif4dFFFKgEjfLy0zN6E+Wz9Y6+3xCfO7MfJxR+QE50UpX7YM2Y8shk/btviHMAw13u7nvq0IZfNZu7tiT3Q60pWPy3AEimqCp+hUMGN/02Zzu9qFCU5TW8ThuGg5cBCmAOImyuSk2jGJBMH4h/7omAGNnGTAf1fAD45u4VfwIkXB8/4r7SWIyelkvj3xDYtTwkDn7o1hIMGIpNch1PUvg2Z7AgZY2AEQM9NQcYqZ9RFOwvDGP39HzWhN6U3yDBFXCpG1vtb8vJ40vy7pu6zT5ss3FGbpL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e2fc11-4562-4e73-b3ae-08d76d9e2cd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 09:44:02.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzZHj7Y6t+3dhCySXtblQCQeWuV17064/IGriq8SdIPfkdbkk81XFLnmQVkxjvan+mtzr9eRbizGPSi6V7Cjig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3982
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnOxaPFriroygBcXdgG4/H363SVoKFKnusIPoNO2v9Y=;
 b=Sw7l+naKbcUpnZFi84aizhneHSjEo1ZDDSXLVbhDygKjCGW4IBnJUL7clyrzmG7B2wTed+rzEtOyLQSyuJn9JlhBTp3kXcvvt3SKLBKNA6q9fwqFoX3xfHTOtUvDyctloRLTa489EUp4JUH9/bGOX1eJFEbtL6STb8HqqWmSe8A=
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
Message-ID: <20191120091418.TDorxfatSXiGdGETXWMwRcyHOiY1dgIiPRzDxCIPHRM@z>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KCkl0IG1heSBsb3NlIGdwdXZt
IGludmFsaWRhdGUgYWNrbm93bGRlZ2Ugc3RhdGUgYWNyb3NzIHBvd2VyLWdhdGluZyBvZmYKY3lj
bGUuIFRvIGF2b2lkIHRoaXMgaXNzdWUgaW4gdmlydCBpbnZhbGlkYXRpb24sIGFkZCBzZW1hcGhv
cmUgYWNxdWlyZQpiZWZvcmUgaW52YWxpZGF0aW9uIGFuZCBzZW1hcGhvcmUgcmVsZWFzZSBhZnRl
ciBpbnZhbGlkYXRpb24uCgpDaGFuZ2UtSWQ6IEllOTgzMDRlNDc1MTY2YjUzZWVkMDMzNDYyZDc2
NDIzYjZiMGZjMjViClNpZ25lZC1vZmYtYnk6IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyB8IDI2ICsr
KysrKysrKysrKysrKysrKysrKystLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZpcnQuaCB8ICAzICsrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAg
ICB8ICAzICsrLQogMyBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCmluZGV4IGYwNGVi
MWE2NDI3MS4uNzBmZmFmOTFjZDEyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmlydC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92aXJ0LmMKQEAgLTEzNSw3ICsxMzUsOCBAQCB2b2lkIGFtZGdwdV92aXJ0X2tpcV93cmVnKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHYpCiAKIHZv
aWQgYW1kZ3B1X3ZpcnRfa2lxX3JlZ193cml0ZV9yZWdfd2FpdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIAkJCQkJdWludDMyX3QgcmVnMCwgdWludDMyX3QgcmVnMSwKLQkJCQkJdWludDMy
X3QgcmVmLCB1aW50MzJfdCBtYXNrKQorCQkJCQl1aW50MzJfdCByZWYsIHVpbnQzMl90IG1hc2ss
CisJCQkJCXVpbnQzMl90IHNlbSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFkZXYt
PmdmeC5raXE7CiAJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gJmtpcS0+cmluZzsKQEAgLTE0
NCw5ICsxNDUsMzAgQEAgdm9pZCBhbWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXVpbnQzMl90IHNlcTsKIAogCXNwaW5fbG9ja19p
cnFzYXZlKCZraXEtPnJpbmdfbG9jaywgZmxhZ3MpOwotCWFtZGdwdV9yaW5nX2FsbG9jKHJpbmcs
IDMyKTsKKwlhbWRncHVfcmluZ19hbGxvYyhyaW5nLCA2MCk7CisKKwkvKgorCSAqIEl0IG1heSBs
b3NlIGdwdXZtIGludmFsaWRhdGUgYWNrbm93bGRlZ2Ugc3RhdGUgYWNyb3NzIHBvd2VyLWdhdGlu
ZworCSAqIG9mZiBjeWNsZSwgYWRkIHNlbWFwaG9yZSBhY3F1aXJlIGJlZm9yZSBpbnZhbGlkYXRp
b24gYW5kIHNlbWFwaG9yZQorCSAqIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uIHRvIGF2b2lk
IGVudGVyaW5nIHBvd2VyIGdhdGVkIHN0YXRlCisJICogdG8gV0EgdGhlIElzc3VlCisJICovCisK
KwkvKiBhIHJlYWQgcmV0dXJuIHZhbHVlIG9mIDEgbWVhbnMgc2VtYXBob3JlIGFjdXFpcmUgKi8K
KwlpZiAocmluZy0+ZnVuY3MtPnZtaHViID09IEFNREdQVV9NTUhVQl8wIHx8CisJICAgIHJpbmct
PmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMSkKKwlhbWRncHVfcmluZ19lbWl0X3JlZ193
YWl0KHJpbmcsIHNlbSwgMHgxLCAweDEpOworCiAJYW1kZ3B1X3JpbmdfZW1pdF9yZWdfd3JpdGVf
cmVnX3dhaXQocmluZywgcmVnMCwgcmVnMSwKIAkJCQkJICAgIHJlZiwgbWFzayk7CisJLyoKKwkg
KiBhZGQgc2VtYXBob3JlIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uLAorCSAqIHdyaXRlIHdp
dGggMCBtZWFucyBzZW1hcGhvcmUgcmVsZWFzZQorCSAqLworCWlmIChyaW5nLT5mdW5jcy0+dm1o
dWIgPT0gQU1ER1BVX01NSFVCXzAgfHwKKwkgICAgcmluZy0+ZnVuY3MtPnZtaHViID09IEFNREdQ
VV9NTUhVQl8xKQorCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhyaW5nLCBzZW0sIDApOworCiAJYW1k
Z3B1X2ZlbmNlX2VtaXRfcG9sbGluZyhyaW5nLCAmc2VxKTsKIAlhbWRncHVfcmluZ19jb21taXQo
cmluZyk7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgma2lxLT5yaW5nX2xvY2ssIGZsYWdzKTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oCmluZGV4IGIwYjJiZGM3NTBk
Zi4uYmRhNmEyZjM3ZGMwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
LmgKQEAgLTI5NSw3ICsyOTUsOCBAQCB1aW50MzJfdCBhbWRncHVfdmlydF9raXFfcnJlZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnKTsKIHZvaWQgYW1kZ3B1X3ZpcnRf
a2lxX3dyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJlZywgdWludDMy
X3Qgdik7CiB2b2lkIGFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCXVpbnQzMl90IHJlZzAsIHVpbnQzMl90IHJyZWcxLAot
CQkJCQl1aW50MzJfdCByZWYsIHVpbnQzMl90IG1hc2spOworCQkJCQl1aW50MzJfdCByZWYsIHVp
bnQzMl90IG1hc2ssCisJCQkJCXVpbnQzMl90IHNlbSk7CiBpbnQgYW1kZ3B1X3ZpcnRfcmVxdWVz
dF9mdWxsX2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBpbml0KTsKIGludCBh
bWRncHVfdmlydF9yZWxlYXNlX2Z1bGxfZ3B1KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBi
b29sIGluaXQpOwogaW50IGFtZGdwdV92aXJ0X3Jlc2V0X2dwdShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBmMjVjZDk3
YmE1ZjIuLjFhZTU5YWY3ODM2YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
CkBAIC00NDgsOSArNDQ4LDEwIEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNoX2dwdV90bGIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCiAJCQkhYWRldi0+aW5f
Z3B1X3Jlc2V0KSB7CiAJCXVpbnQzMl90IHJlcSA9IGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5n
OwogCQl1aW50MzJfdCBhY2sgPSBodWItPnZtX2ludl9lbmcwX2FjayArIGVuZzsKKwkJdWludDMy
X3Qgc2VtID0gaHViLT52bV9pbnZfZW5nMF9zZW0gKyBlbmc7CiAKIAkJYW1kZ3B1X3ZpcnRfa2lx
X3JlZ193cml0ZV9yZWdfd2FpdChhZGV2LCByZXEsIGFjaywgdG1wLAotCQkJCTEgPDwgdm1pZCk7
CisJCQkJCQkgICAxIDw8IHZtaWQsIHNlbSk7CiAJCXJldHVybjsKIAl9CiAKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
