Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE9CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5FB20873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5FB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEC76E5ED;
	Mon, 28 Oct 2019 11:31:18 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730089.outbound.protection.outlook.com [40.107.73.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690B36E5E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 11:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr1boYW4fm1nfpMuk0SQrUhCdK3QiNVDhiNRPa38viTEbGyI21U6KWbbS5kzcm0WzAgjOw56O8hOr/1i4qDStB3bNoLOwgglN93imx5+ABeONuGYUKt3jHH0u9ycY/YhpDuwEhlljR5hG5YNwZdnv1p8aiLZmh1VqZ5PL5J0ITFYBmhflfga8esMbdJgGLKPIjL6E8mhzjOcAxTpytRX2HF+vTSe+Ll6IazODawl2pYVHg2e/VCokZ+HwgWsrwVu3fViLhpR6tSBq+cQUyMl0qHE9+TzwLyX/EONiKB5hkZnLvrADQnhDM/k5QFDWn1nS7Fyb7f29iqbfseFfs4mGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2wMFW3cI5qPR79cAFE2mEj6gGrgDwFdi7l77eGdYdk=;
 b=G6uAAwvC8/NW1Tj/BsAtipmQPHPrNF/e4I5xJKpq/Urzs2chxy7DjITdDs1amkVSxnkiLJ8t20w1irmmmXmknQvzYJ8ouVA1G83llhVFnkM1Is2smekclgSvQrzCIgX3Zx/3qVeKBuUasvZhWzn5R2J81JLAKvYwqme6eKa2UXs3ju/tRTOXXUkmVif/pFuD0+zqb/fSbd8FuijTInGVz8tArJ9y+P6DkRnHtJO/SX9hvdMpfiU8S4MZTPaibaJ9A7lM+m+3zn+in52wq23Gtrp9eIXI8eokW6fVLe/8gd3eFeHclmLckSg78vUHSGCK6w6sEl9x5nL7UNYQTYEvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0055.namprd12.prod.outlook.com (2603:10b6:300:103::17)
 by DM5PR12MB1675.namprd12.prod.outlook.com (2603:10b6:4:5::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 11:31:15 +0000
Received: from BY2NAM03FT038.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::208) by MWHPR12CA0055.outlook.office365.com
 (2603:10b6:300:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 11:31:14 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT038.mail.protection.outlook.com (10.152.84.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 11:31:14 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 06:31:13 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 06:31:12 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: clear UVD VCPU buffer when err_event_athub
 generated
Date: Mon, 28 Oct 2019 19:31:06 +0800
Message-ID: <1572262269-14985-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(189003)(199004)(86362001)(51416003)(186003)(50226002)(8936002)(8676002)(26005)(81166006)(81156014)(2616005)(486006)(356004)(6666004)(70206006)(6916009)(305945005)(44832011)(126002)(50466002)(48376002)(498600001)(2906002)(476003)(5660300002)(70586007)(14444005)(2351001)(47776003)(336012)(36756003)(426003)(16586007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1675; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf31d8b-220e-469f-6eba-08d75b9a5764
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1675E03FDED35BDC7AE1D6B5F6660@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOdidlHI2YrAsLXn8tixiN4DJmQLN7U8SiMqbiO6QGEoT2lE0xm65mOTKrTTupazBdar6/aXCAlKy9KSC+B6F24/798RlE9+2ejPoztEBs2mQdoYuqr++JPepYL1V4JzDXI5kC9fG6Rf+JWOgk8heqkquwISu7nZRf5/2Zpr7JnRg3CQW+uirXRszZGdOj1rGjMnYRjdMg52bw4T9IltVpMkwnF1SaR1g0XNEkZcwPU/H5n2Bw1JOGIDcxh7/DijXyJiM/1iZg6dbhiiQB6fLyK5MqgK+3fLMOE1UtP8mgde6H8cti2BXOoO72Hpz+h39rQeWUXaTGFlLKcpo7PA1S6oESL3e1OkCmyJ4r3ItLERUCPDEk2eoxsRmIXO8GkipFIKMagYvPzXKw7EphPfSWfY+UBHj3A7aF//IbUXEHFTEiuJ36ggFsSV8jERM3AK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 11:31:14.4194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf31d8b-220e-469f-6eba-08d75b9a5764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2wMFW3cI5qPR79cAFE2mEj6gGrgDwFdi7l77eGdYdk=;
 b=Rq59iyoJgTq26aAXqu2odvU9HIQP/pj7AwvExFyPV5spi79566zysAeIFpYpUl3PcSMm5dSfNci1NxdErDOAaH9ZFyraGa6tu1kazc9eRfSnxhsOlHTt8hpo63fApb+fFFtEL/0p04u1BL9pGiA0h4sarZZjwjkFSnow+U1KbLQ=
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
Cc: Le Ma <le.ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028113106.W3nugK_8ogxuZuWiAXNId1ToYMmtqjtLyOf3NZ0U4Kk@z>

VGhlIGVycl9ldmVudF9hdGh1YiBlcnJvciB3aWxsIG1lc3MgdXAgdGhlIGJ1ZmZlciBhbmQgY2F1
c2UgVVZEIHJlc3VtZSBoYW5nLgoKQ2hhbmdlLUlkOiBJZjE3YTIxNjFmYjliMWI1MmVhYzA4ZGUw
MGQyZTkzNTE5MWJkYmY5OQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCAxMCArKysrKysrKyst
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCmluZGV4IGIyYzM2NGIuLmI0ZGQ4OWEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKQEAgLTM5LDYgKzM5LDggQEAK
ICNpbmNsdWRlICJjaWtkLmgiCiAjaW5jbHVkZSAidXZkL3V2ZF80XzJfZC5oIgogCisjaW5jbHVk
ZSAiYW1kZ3B1X3Jhcy5oIgorCiAvKiAxIHNlY29uZCB0aW1lb3V0ICovCiAjZGVmaW5lIFVWRF9J
RExFX1RJTUVPVVQJbXNlY3NfdG9famlmZmllcygxMDAwKQogCkBAIC0zNzIsNyArMzc0LDEzIEBA
IGludCBhbWRncHVfdXZkX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCWlm
ICghYWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8pCiAJCQlyZXR1cm4gLUVOT01FTTsKIAotCQlt
ZW1jcHlfZnJvbWlvKGFkZXYtPnV2ZC5pbnN0W2pdLnNhdmVkX2JvLCBwdHIsIHNpemUpOworCQkv
KiByZS13cml0ZSAwIHNpbmNlIGVycl9ldmVudF9hdGh1YiB3aWxsIGNvcnJ1cHQgVkNQVSBidWZm
ZXIgKi8KKwkJaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkgeworCQkJRFJNX1dBUk4o
IlVWRCBWQ1BVIHN0YXRlIG1heSBsb3N0IGR1ZSB0byBSQVMgRVJSRVZFTlRfQVRIVUJfSU5URVJS
VVBUXG4iKTsKKwkJCW1lbXNldChhZGV2LT51dmQuaW5zdFtqXS5zYXZlZF9ibywgMCwgc2l6ZSk7
CisJCX0gZWxzZSB7CisJCQltZW1jcHlfZnJvbWlvKGFkZXYtPnV2ZC5pbnN0W2pdLnNhdmVkX2Jv
LCBwdHIsIHNpemUpOworCQl9CiAJfQogCXJldHVybiAwOwogfQotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
