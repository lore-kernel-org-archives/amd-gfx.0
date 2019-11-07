Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023EFC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 07:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFABD21D7F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 07:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFABD21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6B46EE95;
	Thu,  7 Nov 2019 07:36:32 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700050.outbound.protection.outlook.com [40.107.70.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160846EE95
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 07:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izXASDT7D6bwOwpVd2rIyVriVrb71qQ9bd/JvseumVwyuh322Al5XdyoS/uK/Z8rhI2rWTAEX342fYE/+fBT+Xkhhp6AJCP3aTu9hUNRGMxR/YwBYaRb27tqPJGMYPBmhB6zVONHH68lnr9WzfSR3HBUvXtmKCMAHzqILdQG34rigZGIHcgnYPGFEWPs0iST+HliWWN1Q+bS+b13WUTOnnVddvjY16WjdhzW9P2OVpqEaC9pCsSDnAgd3W7hYDd1g0dwc1gH9MDdph5AhpRYf8lpBq5tAn3VLbybK5vo+7jLbKkUJLu8pFLye4KOOAyLWoOQbUaYjy9HLxTEcTt66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/3vWYGBc/XOYP/GhHj/cpZ52aX1+eKQliiyhdI2TCA=;
 b=Y18FE27oTrdVf2lD3RQKHU1EI71LdR04OHAuh0yllnExMHxFeAn4UzQ5ia7+07pi6DlA9YD5QKfOJMCiIC4JOt+xkPHZXR4YpU0mPvnba2XuTuEjXAYzi1Ub7oEllaV9BQKYe1lgxeEV9xPiR7djTd3ojkx7jJRGMdWsw4soe7KHW2DXIdbH2QxjXkCJKyvrearq9d+/RbgY7Gb7UR9JnJWr3mVjyXbH8FPNbg2HSdWmfuTj3tiqz2X/Yca8gntM7plMwY+s/g61o7U6lhCkSCIjuaIDpaQMldhwG2bBJLnnCU6ZXQ/rMPgXNGGvHIU4Ys0WAfWt1JeeZzLZPK0y9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by MWHPR12MB1952.namprd12.prod.outlook.com (2603:10b6:300:114::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 07:36:29 +0000
Received: from DM3NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 07:36:29 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT024.mail.protection.outlook.com (10.152.82.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 07:36:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 01:36:27 -0600
Received: from jesse-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 01:36:26 -0600
From: Jesse Zhang <zhexi.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Cancel delay work before unload driver
Date: Thu, 7 Nov 2019 15:36:24 +0800
Message-ID: <1573112184-14195-1-git-send-email-zhexi.zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39850400004)(346002)(136003)(396003)(376002)(428003)(199004)(189003)(50466002)(478600001)(48376002)(36756003)(47776003)(2906002)(305945005)(4326008)(186003)(476003)(70206006)(2616005)(16586007)(8676002)(86362001)(6916009)(426003)(8936002)(26005)(81156014)(81166006)(50226002)(486006)(53416004)(70586007)(51416003)(5660300002)(126002)(316002)(336012)(7696005)(14444005)(356004)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1952; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42069e43-1abb-430d-d3a5-08d7635533c1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19525ECA103AEB4B5FF0801CEF780@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VI/N12mP6QUsY9rlVxFlllWH0JpnDt63yZV3j6ZCuR90gXkxjnQFyot1h1c4SKT73oJFWcPautoKRuHEEVYZhrIAY0QNyzAVrLDVXMop4EUHAJNQh5Oj8R1uKQYENaUUqZiK8bx3j8bug2I+Kj19h3S8FJT9DJDDM7NqlWl6vv1nTwblEwEXrxFf4pkjELTlsEw1vxXC22rJImi3S/G0oc3yqiDZb1JtTt0iPCPXLFh3O3WSr7KwBP40j1rMi9nSig7PhyTNZYEZ2J1h/oNEXP/5lLkTQM3MHB0n33OUa6Z/5QquQpyysieyi8BlMBYfoCih+Yv9r/E0PYzNsQhof9vxBdUHsJmgDIsDsyHzPFeZYreo0tXRgrktuh7gPV7vEj8XIHwl9ZnmlALfGGezySaPYxbJDlbVHgbCm9mdubtGSCIT6Oa3/GV+voW8PsV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 07:36:28.6944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42069e43-1abb-430d-d3a5-08d7635533c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/3vWYGBc/XOYP/GhHj/cpZ52aX1+eKQliiyhdI2TCA=;
 b=XH/wkdoP/a5QyJMAHTmitZPhvhBbKueaMtH//s2aOM3MMtJJCOjMFH2WruoK0dQ8jr0pH+Y70OjRBSDrOa/mlFyeZ4z8krjoCmwi3kLH46NtPUkS4nBV9TGnExk84D31n/rsnO9llHUSrkmCGEIKaQmuqEDF9WDf+D9QDru2ZE0=
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
Cc: Jesse Zhang <zhexi.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107073624.8cWUWvqSUjDSjE1DNwDxqYGNW0W571PuMQACZ0xofdY@z>

bW92ZSBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSB0byB0aGUgYmVnaW5pbmcKb2YgYW1kZ3B1
X2RldmljZV9maW5pKCkgdG8gY2FuY2VsIHVuZmluaXNoZWQKd29ya3Mgd2hpY2ggYXJlIG5vIGxv
bmdlciBuZWVkZWQuCgpDaGFuZ2UtSWQ6IEk4ODMxOTM1Yjc5N2M3OGI5NzFhYTcyMzM2OTdjMzYx
NDAzNzRmMWFjClNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDx6aGV4aS56aGFuZ0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDcgKysr
KysrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgICAgIHwgMiArKwog
MiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggZjBhZDA1ZC4uNWI4YWY2
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzEx
NSw2ICszMTE1LDEyIEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCiAJRFJNX0lORk8oImFtZGdwdTogZmluaXNoaW5nIGRldmljZS5cbiIpOwog
CWFkZXYtPnNodXRkb3duID0gdHJ1ZTsKKworCS8qIENhbmNlbCB1bmZpbmlzaGVkIGRlbGF5IHdv
cmsgYmVmb3JlIHVubG9hZCBkcml2ZXIgKi8KKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFk
ZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYt
PnV2ZC5pZGxlX3dvcmspOworCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNlLmlk
bGVfd29yayk7CisKIAkvKiBkaXNhYmxlIGFsbCBpbnRlcnJ1cHRzICovCiAJYW1kZ3B1X2lycV9k
aXNhYmxlX2FsbChhZGV2KTsKIAlpZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmlnX2luaXRp
YWxpemVkKXsKQEAgLTMxMzQsNyArMzE0MCw2IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhZGV2LT5maXJtd2FyZS5ncHVfaW5mb19mdyA9
IE5VTEw7CiAJfQogCWFkZXYtPmFjY2VsX3dvcmtpbmcgPSBmYWxzZTsKLQljYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKIAkvKiBmcmVlIGkyYyBidXNl
cyAqLwogCWlmICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9ydChhZGV2KSkKIAkJYW1kZ3B1
X2kyY19maW5pKGFkZXYpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwppbmRl
eCBkMTIxYmJkLi5mYzZjOTQ5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIu
YwpAQCAtMzY0LDYgKzM2NCw4IEBAIGludCBhbWRncHVfaWJfcmluZ190ZXN0cyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAkJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmlu
Z3NbaV07CiAJCWxvbmcgdG1vOwogCisJCWlmIChhZGV2LT5zaHV0ZG93bikKKwkJCXJldHVybiAw
OwogCQkvKiBLSVEgcmluZ3MgZG9uJ3QgaGF2ZSBhbiBJQiB0ZXN0IGJlY2F1c2Ugd2UgbmV2ZXIg
c3VibWl0IElCcwogCQkgKiB0byB0aGVtIGFuZCB0aGV5IGhhdmUgbm8gaW50ZXJydXB0IHN1cHBv
cnQuCiAJCSAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
