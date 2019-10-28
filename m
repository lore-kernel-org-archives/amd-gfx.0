Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FCDCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B939E20659
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B939E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C81A6E8A0;
	Mon, 28 Oct 2019 14:08:53 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700051.outbound.protection.outlook.com [40.107.70.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DDA6E89F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmwgArvgCrBfcHWF5aZwCuuS2pa1yAW8eGcfFKh4WGfJiXFGnvbzc+SC6eG8dZ536AFvpCfbVnm2tmHYg4cmFDzZMnieceVs1mIMKrqzwdtqjkS+IA5zPrf3DAQ54mlht33VGmS63xLuUyn21kMZ4VijOaZhkBmWkxGnv8Q61SYXXPq/Jq71DdwYK1AYl0Zbjy2UCigJd+hitikf2C5Yo2b36m34PF4lUo3df0kiqlq1ldTv3vseUrVn6Z+oMgM6B1x9W/+v9TEm6X3EgVRlycpfcCy4Akoh8WVU1nA54+PtskzTToDiOigcBbYAnKciOEYFXFzw1PUNFia3/g9s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDDA5PwxqM1ukT1Th0KKz6IIVkAQyfDGvDW1pxI7WwE=;
 b=c0w0Ta76C+JUfRFiNxU6vAHgaVREnuRi0GIYd2QW+w/Z+LGMTTVzbmsTdZKkAgIZnfcEwLF1fhtSHHmiyc1hn7fmBSinVPPa4iI9jY/4W2j06hBWtlkcmRtYDCk3xfrCyXzy+deCvnYS/1s6ARmGfjBo81RXMG1hAxYiv7WhoHlczDbo33t8lTGUPQr7ICVzG/nzQWrlcReSL13HwRg/NA9q3feH/x8DDfHpdW1mt3qefW7uAepjA1mly17nweJ22xqdO7VI40t15okBrObIF/SLJGi///6CEZ9Zc6wjFNZivCjHZypYTOJPIEShRZ7ZbX8UG95tfPvnK7ZdSE9SQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0034.namprd12.prod.outlook.com (2603:10b6:301:2::20)
 by DM6PR12MB3851.namprd12.prod.outlook.com (2603:10b6:5:1c7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Mon, 28 Oct
 2019 14:08:49 +0000
Received: from CO1NAM03FT047.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::207) by MWHPR12CA0034.outlook.office365.com
 (2603:10b6:301:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 14:08:49 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT047.mail.protection.outlook.com (10.152.81.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:08:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:48 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:48 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:08:47 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amdgpu: Add ucode support for DMCUB
Date: Mon, 28 Oct 2019 10:08:27 -0400
Message-ID: <20191028140837.7908-2-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(428003)(189003)(199004)(44832011)(70586007)(76176011)(70206006)(50466002)(8936002)(86362001)(2906002)(6916009)(305945005)(2870700001)(2351001)(51416003)(6666004)(356004)(4326008)(53416004)(81166006)(47776003)(48376002)(14444005)(186003)(7696005)(1076003)(5660300002)(476003)(50226002)(336012)(316002)(36756003)(426003)(486006)(26005)(478600001)(11346002)(8676002)(446003)(126002)(81156014)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3851; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ba9f4ee-080a-4fed-468a-08d75bb05af6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3851:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38516C83293C0D4002CD7B12EC660@DM6PR12MB3851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duzfrjNgDp3/Lt9soTLR/LlPRZPS+xBZK9FHLOA4N+ZlYcY/WTLMbV40LkuErCb8FllLs0+EjM0rOYKd78AcQZzvTRvR0nGVadlEYGnSikWiqbxrw4Swm1OuoWA7Q4xRGjaJeNKxPQ7XNXrMEdvOkNsGt8Xc7Xve+edEoF06iozTBd4S42mrnVj+MNdxW/+iAPpr3+mPYAvbRWfZK+ux2XFKrmNhlSnpgrErD1mCf9uNBHHSpWxHYixVAh5h4EHutiGqy+1p+cc49a8iEb6rsVBIpoz54JyuHyV8RpjdUbpU9PboczfrDtW0pR4qQO7UoxtmqTNAO7LG3eQrSAJwWIIUhJQwxmC6byHp0kxLgzRhWnIjPTW0mWMwFSyqDYwBYISJnpHpAaIGlt+KR7JiTWYNefrq/AapJ+WM6mA90oBJm+3/iXYAOOmJadVoKujD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:08:49.3004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba9f4ee-080a-4fed-468a-08d75bb05af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3851
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDDA5PwxqM1ukT1Th0KKz6IIVkAQyfDGvDW1pxI7WwE=;
 b=QqKnRw1Mp1wHrJj+mvLGcQ5WXUxyeQEmHXWfQGzQmbtPdMLRo5axHn/2CqVgsXPa9Ta01hFLyZj3Qy3EviaewlFCmhXyNl5HMj/ywDnXyI+PlXCB6l3UeXc8pyUoXDQWrM4yAg4xEirn6hsVlHv9GjBUs8EdRcVVt1vlCyRTAv0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140827.YFsvat1ja2GnmKAeGl8H8g61wMsnHgexP5PeULDh9Ok@z>

VGhlIERNQ1VCIGlzIGEgc2Vjb25kYXJ5IERNQ1UgKERpc3BsYXkgTWljcm9Db250cm9sbGVyIFVu
aXQpIHRoYXQgaGFzCml0cyBvd24gc2VwYXJhdGUgZmlybXdhcmUuIEl0J3MgcmVxdWlyZWQgZm9y
IERNQ1Ugc3VwcG9ydCBvbiBSZW5vaXIuCgpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXpsYXVz
a2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgfCAxMSArKysrKysrKysrLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmggfCAgOSArKysrKysrKysKIDIgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Vjb2RlLmMKaW5kZXggODMzZmM0YjY4OTQwLi45ZWYzMTI0MjgyMzEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jCkBAIC00NDcsNiArNDQ3
LDcgQEAgc3RhdGljIGludCBhbWRncHVfdWNvZGVfaW5pdF9zaW5nbGVfZncoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJY29uc3Qgc3RydWN0IGNvbW1vbl9maXJtd2FyZV9oZWFkZXIgKmhl
YWRlciA9IE5VTEw7CiAJY29uc3Qgc3RydWN0IGdmeF9maXJtd2FyZV9oZWFkZXJfdjFfMCAqY3Bf
aGRyID0gTlVMTDsKIAljb25zdCBzdHJ1Y3QgZG1jdV9maXJtd2FyZV9oZWFkZXJfdjFfMCAqZG1j
dV9oZHIgPSBOVUxMOworCWNvbnN0IHN0cnVjdCBkbWN1Yl9maXJtd2FyZV9oZWFkZXJfdjFfMCAq
ZG1jdWJfaGRyID0gTlVMTDsKIAogCWlmIChOVUxMID09IHVjb2RlLT5mdykKIAkJcmV0dXJuIDA7
CkBAIC00NjAsNiArNDYxLDcgQEAgc3RhdGljIGludCBhbWRncHVfdWNvZGVfaW5pdF9zaW5nbGVf
Zncoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJaGVhZGVyID0gKGNvbnN0IHN0cnVjdCBj
b21tb25fZmlybXdhcmVfaGVhZGVyICopdWNvZGUtPmZ3LT5kYXRhOwogCWNwX2hkciA9IChjb25z
dCBzdHJ1Y3QgZ2Z4X2Zpcm13YXJlX2hlYWRlcl92MV8wICopdWNvZGUtPmZ3LT5kYXRhOwogCWRt
Y3VfaGRyID0gKGNvbnN0IHN0cnVjdCBkbWN1X2Zpcm13YXJlX2hlYWRlcl92MV8wICopdWNvZGUt
PmZ3LT5kYXRhOworCWRtY3ViX2hkciA9IChjb25zdCBzdHJ1Y3QgZG1jdWJfZmlybXdhcmVfaGVh
ZGVyX3YxXzAgKil1Y29kZS0+ZnctPmRhdGE7CiAKIAlpZiAoYWRldi0+ZmlybXdhcmUubG9hZF90
eXBlICE9IEFNREdQVV9GV19MT0FEX1BTUCB8fAogCSAgICAodWNvZGUtPnVjb2RlX2lkICE9IEFN
REdQVV9VQ09ERV9JRF9DUF9NRUMxICYmCkBAIC00NzAsNyArNDcyLDggQEAgc3RhdGljIGludCBh
bWRncHVfdWNvZGVfaW5pdF9zaW5nbGVfZncoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
ICAgICB1Y29kZS0+dWNvZGVfaWQgIT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1Rf
R1BNX01FTSAmJgogCSAgICAgdWNvZGUtPnVjb2RlX2lkICE9IEFNREdQVV9VQ09ERV9JRF9STENf
UkVTVE9SRV9MSVNUX1NSTV9NRU0gJiYKIAkJIHVjb2RlLT51Y29kZV9pZCAhPSBBTURHUFVfVUNP
REVfSURfRE1DVV9FUkFNICYmCi0JCSB1Y29kZS0+dWNvZGVfaWQgIT0gQU1ER1BVX1VDT0RFX0lE
X0RNQ1VfSU5UVikpIHsKKwkJIHVjb2RlLT51Y29kZV9pZCAhPSBBTURHUFVfVUNPREVfSURfRE1D
VV9JTlRWICYmCisJCSB1Y29kZS0+dWNvZGVfaWQgIT0gQU1ER1BVX1VDT0RFX0lEX0RNQ1VCKSkg
ewogCQl1Y29kZS0+dWNvZGVfc2l6ZSA9IGxlMzJfdG9fY3B1KGhlYWRlci0+dWNvZGVfc2l6ZV9i
eXRlcyk7CiAKIAkJbWVtY3B5KHVjb2RlLT5rYWRkciwgKHZvaWQgKikoKHVpbnQ4X3QgKil1Y29k
ZS0+ZnctPmRhdGEgKwpAQCAtNTA2LDYgKzUwOSwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV91Y29k
ZV9pbml0X3NpbmdsZV9mdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJICAgICAg
bGUzMl90b19jcHUoaGVhZGVyLT51Y29kZV9hcnJheV9vZmZzZXRfYnl0ZXMpICsKIAkJCQkJICAg
ICAgbGUzMl90b19jcHUoZG1jdV9oZHItPmludHZfb2Zmc2V0X2J5dGVzKSksCiAJCSAgICAgICB1
Y29kZS0+dWNvZGVfc2l6ZSk7CisJfSBlbHNlIGlmICh1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BV
X1VDT0RFX0lEX0RNQ1VCKSB7CisJCXVjb2RlLT51Y29kZV9zaXplID0gbGUzMl90b19jcHUoZG1j
dWJfaGRyLT5pbnN0X2NvbnN0X2J5dGVzKTsKKwkJbWVtY3B5KHVjb2RlLT5rYWRkciwKKwkJICAg
ICAgICh2b2lkICopKCh1aW50OF90ICopdWNvZGUtPmZ3LT5kYXRhICsKKwkJCQlsZTMyX3RvX2Nw
dShoZWFkZXItPnVjb2RlX2FycmF5X29mZnNldF9ieXRlcykpLAorCQkgICAgICAgdWNvZGUtPnVj
b2RlX3NpemUpOwogCX0gZWxzZSBpZiAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9J
RF9STENfUkVTVE9SRV9MSVNUX0NOVEwpIHsKIAkJdWNvZGUtPnVjb2RlX3NpemUgPSBhZGV2LT5n
ZngucmxjLnNhdmVfcmVzdG9yZV9saXN0X2NudGxfc2l6ZV9ieXRlczsKIAkJbWVtY3B5KHVjb2Rl
LT5rYWRkciwgYWRldi0+Z2Z4LnJsYy5zYXZlX3Jlc3RvcmVfbGlzdF9jbnRsLApkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuaAppbmRleCA0MTA1ODdiOTUwZjMuLmVhZjJk
NWI5YzkyZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vj
b2RlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmgKQEAg
LTI1MSw2ICsyNTEsMTMgQEAgc3RydWN0IGRtY3VfZmlybXdhcmVfaGVhZGVyX3YxXzAgewogCXVp
bnQzMl90IGludHZfc2l6ZV9ieXRlczsgIC8qIHNpemUgb2YgaW50ZXJydXB0IHZlY3RvcnMsIGlu
IGJ5dGVzICovCiB9OwogCisvKiB2ZXJzaW9uX21ham9yPTEsIHZlcnNpb25fbWlub3I9MCAqLwor
c3RydWN0IGRtY3ViX2Zpcm13YXJlX2hlYWRlcl92MV8wIHsKKwlzdHJ1Y3QgY29tbW9uX2Zpcm13
YXJlX2hlYWRlciBoZWFkZXI7CisJdWludDMyX3QgaW5zdF9jb25zdF9ieXRlczsgLyogc2l6ZSBv
ZiBpbnN0cnVjdGlvbiByZWdpb24sIGluIGJ5dGVzICovCisJdWludDMyX3QgYnNzX2RhdGFfYnl0
ZXM7IC8qIHNpemUgb2YgYnNzL2RhdGEgcmVnaW9uLCBpbiBieXRlcyAqLworfTsKKwogLyogaGVh
ZGVyIGlzIGZpeGVkIHNpemUgKi8KIHVuaW9uIGFtZGdwdV9maXJtd2FyZV9oZWFkZXIgewogCXN0
cnVjdCBjb21tb25fZmlybXdhcmVfaGVhZGVyIGNvbW1vbjsKQEAgLTI2OCw2ICsyNzUsNyBAQCB1
bmlvbiBhbWRncHVfZmlybXdhcmVfaGVhZGVyIHsKIAlzdHJ1Y3Qgc2RtYV9maXJtd2FyZV9oZWFk
ZXJfdjFfMSBzZG1hX3YxXzE7CiAJc3RydWN0IGdwdV9pbmZvX2Zpcm13YXJlX2hlYWRlcl92MV8w
IGdwdV9pbmZvOwogCXN0cnVjdCBkbWN1X2Zpcm13YXJlX2hlYWRlcl92MV8wIGRtY3U7CisJc3Ry
dWN0IGRtY3ViX2Zpcm13YXJlX2hlYWRlcl92MV8wIGRtY3ViOwogCXVpbnQ4X3QgcmF3WzB4MTAw
XTsKIH07CiAKQEAgLTMwNyw2ICszMTUsNyBAQCBlbnVtIEFNREdQVV9VQ09ERV9JRCB7CiAJQU1E
R1BVX1VDT0RFX0lEX0RNQ1VfSU5UViwKIAlBTURHUFVfVUNPREVfSURfVkNOMF9SQU0sCiAJQU1E
R1BVX1VDT0RFX0lEX1ZDTjFfUkFNLAorCUFNREdQVV9VQ09ERV9JRF9ETUNVQiwKIAlBTURHUFVf
VUNPREVfSURfTUFYSU1VTSwKIH07CiAKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
