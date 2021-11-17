Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B46AC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 18:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101C461212
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 18:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 101C461212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874BC6E829;
	Wed, 17 Nov 2021 18:56:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2446E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 18:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ5cXlMYen7HJbSjTUgdrF9n8W0czAimyL32qitdMXLObzJ0ZC9vaD1vOW2HqZqStA84D8Mc2AzegLKu9XodfIP1LcbgbIXCk4nxPbNVHOgBdlFbNoJhBeHDk7vUOZpR+cRULFnSECu8EKPiKfDtQqk3yZoybmFRKMN1WoPUV/TgUQHQK1ARSG9ZCY2oe2KVtIvKadhdUMHW9nBII/uJpu+LiVajztSY9SU8HvAQKGdv3mwHXCZoWZZRnM+uE0VO+hpVTRBaqMzCOoljjkIE4fgMu8QM0k+VzMG2GoIZugaQgZVU9+2M3DPuU8RmYFbd9j0fhhVaqgn90ptIpysfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH8HRcoI3zKtJCVqiyl7h7VDDvTsbtQrRkpM4OUvsFc=;
 b=k22QcUrxBX4B54I/ElQYoZ3smMLDJFXpK1S0c0eSd0+ovBAhSJpbRSA1SF9zKigkjOBgfDZWkJPeul/0Ubq0oF4/c8FS/9Jgf8Z+4KxkmhLZy7LNo01v/UyVxtugzjjnuUyg4nSUKJc7yTcdesrSsMs7HPr7oLNT+/G/LKSnBBleWGdf6nXK5C8TxoqTTPY2xubyZ7DyDB4Ne06qbujSwmZevRJc+YcRM7l9xG44e+G7MFi0SptRxIJ42h/HsIIDYd/Zv6CDmen7O3B208DNJNWme+EfHvYHKlSrSnK2QbcX5gEgbl0oB7EQjo+Ob28CCx6Wck2LPedRfu71BIP6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH8HRcoI3zKtJCVqiyl7h7VDDvTsbtQrRkpM4OUvsFc=;
 b=wAntncYwDpXUj0EeOG29PlsfwyRc/vd8e9zcsEqm5jOyZaiJH3PYtBOuKgOfqwsE20ZMekC4KsfVRjs18hxaEhs+zhO5mg5JveBSYO5OpTuJCIpgXlLVLq0YEREtIcZlI/hm44JOfvic1hb7Xupah/QzL3hMV0PRkzISKvTYm5s=
Received: from MWHPR04CA0063.namprd04.prod.outlook.com (2603:10b6:300:6c::25)
 by CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 18:56:01 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::a) by MWHPR04CA0063.outlook.office365.com
 (2603:10b6:300:6c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Wed, 17 Nov 2021 18:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 18:56:00 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 12:55:56 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: Print the error on command submission
Date: Wed, 17 Nov 2021 13:55:12 -0500
Message-ID: <20211117185512.102807-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211117185512.102807-1-luben.tuikov@amd.com>
References: <20211117185512.102807-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 473f4cbe-0c80-47ca-5de1-08d9a9fbe604
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17977B344F2CF4114EF04280999A9@CY4PR12MB1797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibeFRL/2OjwN/6kOaymtqnmzqeHs8HSQmzqxknqU8XW8JX+3RHqSzaQSuGr4wXmWRwfosugmPhbfxX8aCQWBHeTETG/SjaqjVxFV046rU7P2VYXyXYQ77JPdX/hSE6tTkzOWvGmhZuMDXESdyBGjljKVuEcdEkMahmuD1Ci04sc1i94Gm82pyJDNwJIcjEenjTt+2yc3rmCOPe3OohnyUa0cJoGnEiIWNOhbMdTbxsMXySi2PQldA4WYUEM9+ssg0Wr4FiOa3p+S+NawhBPFG6/bk0n7SNsaqwduLdpeFldEvicJtD47ae0yXR5i+wLlNv0IysU7t8L2sCXE0JCwyCQ4sko50cTGs0T9+8n2/907UD6NBhSxRNB9vXvm7Yyg1ZlVf8L+TosBwWKurcqM2sIoPGTk6bhOOHKDn5abQmjtLxhVG+tPg18eZQRj7BSJnctboKRSgrs6QhQIL/840RkoM/U8B2Swpwl+1NDfywrHDBkWvtAGP5umc8Z8uDjf9vSIuxdB2Bc+ZKGlupThof475L0Pa3/GckpFGw8Nq6i692VZRe6NJ7JkjA6bmUO/jfW/+CElfpzIfs3PwwF6KYkoZDHf5UNAN2xVMRQe252laBLSeOJBWOPMVy43KwGqGH9Fjklc8tRfsjj/bqtUQvmDQLIcbAi9dnY5/8FYvCF2eHjFlEqii46AC10CEA9Dr7CWGGzb5/TIF+41rrMK+VjEJiPd9TJDp4Bp+N0+Md8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(81166007)(508600001)(5660300002)(86362001)(70206006)(36756003)(7696005)(336012)(8936002)(426003)(2616005)(8676002)(36860700001)(54906003)(16526019)(2906002)(1076003)(44832011)(6666004)(83380400001)(356005)(26005)(186003)(47076005)(6916009)(316002)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 18:56:00.8978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473f4cbe-0c80-47ca-5de1-08d9a9fbe604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the error on command submission immediately after submitting to
the SMU. This is rate-limited. It helps to immediately know there was an
error on command submission, rather than leave it up to clients to report
the error, as sometimes they do not.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f9a42a07eeaebf..048ca16738638f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -352,7 +352,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
-	if (res == -EREMOTEIO)
+	if (res != 0)
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
-- 
2.34.0

