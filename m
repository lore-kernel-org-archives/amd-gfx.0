Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55A5C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 02:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862FB20747
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 02:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NuscKVbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862FB20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C506E588;
	Thu, 11 Jun 2020 02:29:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC546E588
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 02:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaZUvqrJjgwCt5qqeOQByc3uW2V+A8Wb0PpBB6NGH93RlIBFYSIqvVXZN1w/urt/P6HPifFCqm9cG0/vsvR1MbcKCQ2evTm7BsBVC5FudbvbXDNu5uPI9JxwM0mBUdYSr4kN99zRorSK0dbRWxLgxCcnF2FOH4pVCdOEIng94wa9R4ers66wB5HtBl2xeSgRlZgYKMeP0Ox8tVkyBNUEkdjIul7HS4EvNlfEnROzco5REcvqlxIeJ+wyJSpvPZ4i2xmKMc4qhWeWxdbiJSRntSm11HZBcc403Z58pR+ahVBNoacazJOL47zvV4PQist038FRPgXSJhNxbTbUP+x5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8ivnEdfCraLrLnFfuONijJPFzBEYusfN6iEOZ9S214=;
 b=CGp76dRTjeWEAlue+Bme62Xi99u/F0CTEj3CVtku9fjTl/OBptCm6q0g6pNfP/sXNw9HXRXmpnZ8pCfbl00NKPUEvFQuwrjXxMUxiIwQ51LNyaI4D8O5CFtJOzjiZtH+ABhO6cFxGc1triRP7hsnU73xqlx0Jsgt1c+Qh1r3q1Q8+AWhHwGQ8xeMO5m+/PhCtw3Fd2zW1mnZGx3NGKw0hd9S0uL1pD/stXhkAN8Iih1DW/A7vKAjKwLj+MYW2ArB477xZEWQq3Va27PIqOBP+vSr+Ahp/L+xYlT7b/HCUry6YOzWJGf7DYVxzH9hjZMBMlYwxn7LoRbFzhAyGu/EUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8ivnEdfCraLrLnFfuONijJPFzBEYusfN6iEOZ9S214=;
 b=NuscKVbbhCKBx3NlH3VMsudztyZFceQ/NcTYNF7YAkXV8vAcNilm2KuOW+ui5bRCdMIkIe18QnLpTN0B0q3IpLN4d9Hqu8xQ9SB7cb7hl3LBss6Q4ZPUcLrAMwUrXbHFI9cKOq8FtUCxW4pF0/28PZKJQ9iSKmUu96pLMLUjRgk=
Received: from DM5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:3:23::15) by
 MWHPR12MB1485.namprd12.prod.outlook.com (2603:10b6:301:4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Thu, 11 Jun 2020 02:29:07 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::99) by DM5PR13CA0005.outlook.office365.com
 (2603:10b6:3:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.7 via Frontend
 Transport; Thu, 11 Jun 2020 02:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 02:29:06 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 10 Jun
 2020 21:29:05 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 10 Jun 2020 21:29:04 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Add clear vf fw support
Date: Thu, 11 Jun 2020 10:29:01 +0800
Message-ID: <1591842541-29122-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966005)(82740400003)(8936002)(47076004)(316002)(2616005)(426003)(86362001)(336012)(82310400002)(4326008)(81166007)(26005)(6916009)(6666004)(70206006)(8676002)(478600001)(2906002)(70586007)(356005)(36756003)(5660300002)(83380400001)(186003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 491bfdea-2efa-4c1e-5e6d-08d80daf3727
X-MS-TrafficTypeDiagnostic: MWHPR12MB1485:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14855821AAB35CB034CE063C8F800@MWHPR12MB1485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4M5GFDUqfGtVZOTUS5hJ7/uuGcMqHyWHF1XwIgK3EIwU+cCjuhOSxAxrRpbRTtmQGr4eT3Hc8C11hgsYf7Tzi13a6Jl2T6SEzNkOILPB8qiNXE222fEXqSKF306KthBd8mJvq/QDzInDPZ1I7WxT3AT8ovQshev9L+rDntZFlR7ISnj2stXPwRE5RrG5JPLplUmFrk90OQyFXAGkem9Epp1WgmTM3+XD93+wJy6DpPQ8k2G0bhfauyLTPGfYydxwWtff5pq0JJUoiJOakHFfdxvSm3AhJzVeIeZII1PC4ft4qwNgMVCeQBTbUcfJiwsvT2m9NN1xeQQCZS+1bndKHRAlKrOVteJjt4Dunmd5zSMVBLv7I2ImcQiidnymZXaT/WfV1LlmASIqhZqp/TpZdg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 02:29:06.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491bfdea-2efa-4c1e-5e6d-08d80daf3727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1485
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

R3Vlc3QgVk0gaXNzdWUgdGhlIFBTUCBjbGVhcl92Zl9mdyBjb21tYW5kIGF0IDIgcG9pbnRzOgox
Lk9uIFZGIGRyaXZlciBsb2FkaW5nLCBhZnRlciBWRiBtZXNzYWdlIFBTUCB0byBzZXR1cCByaW5n
cywKdGhlIG5leHQgY29tbWFuZCBpcyDigJxjbGVhcl92Zl9md+KAnQoyLk9uIFZGIGRyaXZlciB1
bmxvYWQgYmVmb3JlIFZGIG1lc3NhZ2UgdG8KZGVzdHJveSByaW5ncwoKQ2hhbmdlLUlkOiBJYTMx
YWRkMzhhNjkwMzdkMWNiYmY5YjQ4YWQ4MjdmYTYzYjQ4NjBmNwpTaWduZWQtb2ZmLWJ5OiBFbWls
eSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfZ2Z4X2lmLmggfCAgOCArKysrKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGNkZDY1YjUuLjYwNTU4NDkgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTI3MCw4ICsyNzAsOSBAQCBw
c3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCiAJCWFtZGdwdV9hc2lj
X2ludmFsaWRhdGVfaGRwKHBzcC0+YWRldiwgTlVMTCk7CiAJfQogCi0JLyogV2UgYWxsb3cgVEVF
X0VSUk9SX05PVF9TVVBQT1JURUQgZm9yIFZNUiBjb21tYW5kIGluIFNSSU9WICovCi0Jc2tpcF91
bnN1cHBvcnQgPSAocHNwLT5jbWRfYnVmX21lbS0+cmVzcC5zdGF0dXMgPT0gMHhmZmZmMDAwYSkg
JiYgYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldik7CisJLyogV2UgYWxsb3cgVEVFX0VSUk9SX05P
VF9TVVBQT1JURUQgZm9yIFZNUiBjb21tYW5kIGFuZCBQU1BfRVJSX1VOS05PV05fQ09NTUFORCBp
biBTUklPViAqLworCXNraXBfdW5zdXBwb3J0ID0gKHBzcC0+Y21kX2J1Zl9tZW0tPnJlc3Auc3Rh
dHVzID09IFRFRV9FUlJPUl9OT1RfU1VQUE9SVEVEIHx8CisJCXBzcC0+Y21kX2J1Zl9tZW0tPnJl
c3Auc3RhdHVzID09IFBTUF9FUlJfVU5LTk9XTl9DT01NQU5EKSAmJiBhbWRncHVfc3Jpb3ZfdmYo
cHNwLT5hZGV2KTsKIAogCS8qIEluIHNvbWUgY2FzZXMsIHBzcCByZXNwb25zZSBzdGF0dXMgaXMg
bm90IDAgZXZlbiB0aGVyZSBpcyBubwogCSAqIHByb2JsZW0gd2hpbGUgdGhlIGNvbW1hbmQgaXMg
c3VibWl0dGVkLiBTb21lIHZlcnNpb24gb2YgUFNQIEZXCkBAIC0zODksNiArMzkwLDI2IEBAIHN0
YXRpYyBpbnQgcHNwX3Rtcl9pbml0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVybiBy
ZXQ7CiB9CiAKK3N0YXRpYyBpbnQgcHNwX2NsZWFyX3ZmX2Z3KHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwKQoreworCWludCByZXQ7CisJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKKworCWlm
ICghYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgfHwgcHNwLT5hZGV2LT5hc2ljX3R5cGUgIT0g
Q0hJUF9OQVZJMTIpCisJCXJldHVybiAwOworCisJY21kID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IHBzcF9nZnhfY21kX3Jlc3ApLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWNtZCkKKwkJcmV0dXJuIC1F
Tk9NRU07CisKKwljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfQ0xFQVJfVkZfRlc7CisKKwlyZXQg
PSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBOVUxMLCBjbWQsIHBzcC0+ZmVuY2VfYnVmX21jX2Fk
ZHIpOworCWtmcmVlKGNtZCk7CisKKwlyZXR1cm4gcmV0OworfQorCiBzdGF0aWMgaW50IHBzcF90
bXJfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwpAQCAtMTM4Miw2
ICsxNDAzLDEyIEBAIHN0YXRpYyBpbnQgcHNwX2h3X3N0YXJ0KHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwKQogCQlyZXR1cm4gcmV0OwogCX0KIAorCXJldCA9IHBzcF9jbGVhcl92Zl9mdyhwc3ApOwor
CWlmIChyZXQpIHsKKwkJRFJNX0VSUk9SKCJQU1AgY2xlYXIgdmYgZnchXG4iKTsKKwkJcmV0dXJu
IHJldDsKKwl9CisKIAlyZXQgPSBwc3BfdG1yX2luaXQocHNwKTsKIAlpZiAocmV0KSB7CiAJCURS
TV9FUlJPUigiUFNQIHRtciBpbml0IGZhaWxlZCFcbiIpOwpAQCAtMTg0Myw2ICsxODcwLDcgQEAg
c3RhdGljIGludCBwc3BfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJc3RydWN0IHBzcF9jb250ZXh0
ICpwc3AgPSAmYWRldi0+cHNwOwogCXZvaWQgKnRtcl9idWY7CiAJdm9pZCAqKnBwdHI7CisJaW50
IHJldDsKIAogCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgewogCQlwc3BfcmFzX3Rlcm1pbmF0
ZShwc3ApOwpAQCAtMTg1MSw2ICsxODc5LDExIEBAIHN0YXRpYyBpbnQgcHNwX2h3X2Zpbmkodm9p
ZCAqaGFuZGxlKQogCX0KIAogCXBzcF9hc2RfdW5sb2FkKHBzcCk7CisJcmV0ID0gcHNwX2NsZWFy
X3ZmX2Z3KHBzcCk7CisJaWYgKHJldCkgeworCQlEUk1fRVJST1IoIlBTUCBjbGVhciB2ZiBmdyFc
biIpOworCQlyZXR1cm4gcmV0OworCX0KIAogCXBzcF9yaW5nX2Rlc3Ryb3kocHNwLCBQU1BfUklO
R19UWVBFX19LTSk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Bz
cF9nZnhfaWYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9nZnhfaWYuaAppbmRl
eCBhNDRmZDYwLi5jYmMwNGE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9wc3BfZ2Z4X2lmLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9p
Zi5oCkBAIC0xMTAsNiArMTEwLDcgQEAgZW51bSBwc3BfZ2Z4X2NtZF9pZAogICAgIEdGWF9DTURf
SURfU0VUVVBfVk1SICAgID0gMHgwMDAwMDAwOSwgICAvKiBzZXR1cCBWTVIgcmVnaW9uICovCiAg
ICAgR0ZYX0NNRF9JRF9ERVNUUk9ZX1ZNUiAgPSAweDAwMDAwMDBBLCAgIC8qIGRlc3Ryb3kgVk1S
IHJlZ2lvbiAqLwogICAgIEdGWF9DTURfSURfUFJPR19SRUcgICAgID0gMHgwMDAwMDAwQiwgICAv
KiBwcm9ncmFtIHJlZ3MgKi8KKyAgICBHRlhfQ01EX0lEX0NMRUFSX1ZGX0ZXICA9IDB4MDAwMDAw
MEQsICAgLyogQ2xlYXIgVkYgRlcsIHRvIGJlIHVzZWQgb24gVkYgc2h1dGRvd24uICovCiAgICAg
LyogSURzIHVwdG8gMHgxRiBhcmUgcmVzZXJ2ZWQgZm9yIG9sZGVyIHByb2dyYW1zIChSYXZlbiwg
VmVnYSAxMC8xMi8yMCkgKi8KICAgICBHRlhfQ01EX0lEX0xPQURfVE9DICAgICA9IDB4MDAwMDAw
MjAsICAgLyogTG9hZCBUT0MgYW5kIG9idGFpbiBUTVIgc2l6ZSAqLwogICAgIEdGWF9DTURfSURf
QVVUT0xPQURfUkxDID0gMHgwMDAwMDAyMSwgICAvKiBJbmRpY2F0ZXMgYWxsIGdyYXBoaWNzIGZ3
IGxvYWRlZCwgc3RhcnQgUkxDIGF1dG9sb2FkICovCkBAIC0zNjUsNCArMzY2LDExIEBAIHN0cnVj
dCBwc3BfZ2Z4X3JiX2ZyYW1lCiAgICAgICAgICAgICAgICAgLyogdG90YWwgNjQgYnl0ZXMgKi8K
IH07CiAKKyNkZWZpbmUgUFNQX0VSUl9VTktOT1dOX0NPTU1BTkQgMHgwMDAwMDEwMAorCitlbnVt
IHRlZV9lcnJvcl9jb2RlIHsKKyAgICBURUVfU1VDQ0VTUyAgICAgICAgICAgICAgICAgICAgICAg
ICA9IDB4MDAwMDAwMDAsCisgICAgVEVFX0VSUk9SX05PVF9TVVBQT1JURUQgICAgICAgICAgICAg
PSAweEZGRkYwMDBBLAorfTsKKwogI2VuZGlmIC8qIF9QU1BfVEVFX0dGWF9JRl9IXyAqLwotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
