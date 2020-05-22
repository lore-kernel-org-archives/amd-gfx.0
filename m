Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7B0C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1A820663
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vsQKZl1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1A820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395206EA1A;
	Fri, 22 May 2020 18:03:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69C46EA1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 18:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAUaN29pdeh6HsrmpAREwQy+r4n1ZgvRg0XiIAuPaZMYsqHc/s+qK+Q74YsAqqgl0bgcO97417mlMB+iPrIZY888kSaq0lbnoK6TuMdfQFH7ZcVw38IvOP2puaRPJtULoBP4EH57pJMXdBP9lKRMnQrPZRWnugFoN+zf5e+1tAD+bngSoU/nxrUDh22fW019mXiEdJ5fzGTOLmHVYvw916jmEdXTiZjXE+ov97XwL1ogt4TAtYe2jdOrTTliitfzi2pKHAFsWyOvEvTOTVYvRnyJDlmjxhGo02frMgjRQjMLk6//XEm/NNtAdAK5NDIQHPfZy9j1Jy7nYeuj8P8Y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3DsWsW8IZMz6L76hRfOKnq4NlYnv2t45Qj5jNfqZIU=;
 b=Qr2UU319nBwOT4+3HeAY3/TeOchLdT50Uh8hiu+NhGm8y2+RykLbX0rk93XYMknWyOj37/OaxtjFO+OwfhlYEsjGCO6MIs3M0UQ0pq2NLvuYmNk9yjowMd3AjLo+te8EiBTqmQBX31XHKYmWv+ticxJK4kBde5SJR/wwjbTXTrM6cYuUFjM4HdSEN6aeTMSO5nlUZ+Ck0571Pz+6RZi516bhHkbTAtjEc0TXW32QScKLBELDIWdzwph5oMDeRGqgwZQxAffujzI8QS0E+OzfDfHCVtmNmoA1/3OIfNyFRkTpKsy/YgE76Ed4UJboVrmw8NvG/i8kbs0G2calbW8M1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3DsWsW8IZMz6L76hRfOKnq4NlYnv2t45Qj5jNfqZIU=;
 b=vsQKZl1WakkUNXmtAE9g5g0Sy3egLjSi8yIyxYv4rtDGYBPHMlcdsylgVI7uGJWJ1A/Yj7U+WnPMtkK5W1VwCbwvXM3ch+GyppqSbl+CHgehuLVq+d5YI0N+iVLdUPzagadwG/VMXdtdE+MmfTUUVDbx9AgC7caZz96QCdmnGfU=
Received: from CO2PR04CA0141.namprd04.prod.outlook.com (2603:10b6:104::19) by
 BYAPR12MB2999.namprd12.prod.outlook.com (2603:10b6:a03:df::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Fri, 22 May 2020 18:03:43 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::d8) by CO2PR04CA0141.outlook.office365.com
 (2603:10b6:104::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 18:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 18:03:42 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 22 May
 2020 13:03:41 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 22 May 2020 13:03:40 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Make BREAK_TO_DEBUGGER() a debug print
Date: Fri, 22 May 2020 14:03:26 -0400
Message-ID: <20200522180326.5325-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966005)(6916009)(5660300002)(26005)(336012)(36756003)(356005)(316002)(82740400003)(1076003)(8936002)(47076004)(81166007)(2616005)(186003)(54906003)(82310400002)(4326008)(70586007)(2906002)(8676002)(70206006)(44832011)(426003)(6666004)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b7e504-3e51-4483-60bc-08d7fe7a768a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2999:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2999E2DBC8EE0B20378FEE0EECB40@BYAPR12MB2999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdRVvV8EGSt7DNyXiI9GAfCFWbE9ZmHPy2tC03B0jcZvqer5BcGo6W2m+gG1Tc1MHT852bri4qelNMmZx5Ez8jtZbSzZZ/zW1cQr5/0dn+CgqzJlJgkHC7lsWptwjNY+n1CBA5KuKtxkAg/4xyrtRoNXCm/UWXD+0R55apmxPl/7s/qeDHt5PmKnBJsu/1JTLJScyh03O3oaEJ4ryO8ZvXI5PXSeVI/QgZ+LcbG9L4WtsuS8CKDndQC/gOdjMMFclA/YXHmpZwrd/TBdOSzAmzFbnvyauyyhSPc89k6xsKf1pljbtKXtS3LG2ghpcBwr+g7ktZO544XKUiSCQmleblwCi3S5P2dY32frw/G5bLqP49BL4kBVY6olvhUvd44j+/KatT66vOmEhDygCaTp9A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 18:03:42.2850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b7e504-3e51-4483-60bc-08d7fe7a768a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Warnings in the kernel are generally treated as errors.

The BREAK_TO_DEBUGGER macro is not a critical error or warning, but
rather intended for developer use to help investigate behavior and
sequences for other issues.

We do still make use of DC_ERROR/ASSERT(0) in various places in the
code for things that are genuine issues.

Since most developers don't actually KGDB while debugging the kernel
these essentially would have no value on their own since the KGDB
breakpoint wouldn't trigger - ASSERT(0) was used as a shortcut to get
a stacktrace.

[How]
Turn it into a DRM_DEBUG_DRIVER print instead. We unfortunately lose
the stacktrace, but we still do retain some of the useful debug
information this offers by having at least the function and line
number loggable.

If KGDB is supported in the kernel this will still trigger a real
breakpoint as well.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 6d7bca562eec..604ceb6c0375 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -111,7 +111,15 @@
 #define ASSERT(expr) WARN_ON_ONCE(!(expr))
 #endif
 
-#define BREAK_TO_DEBUGGER() ASSERT(0)
+#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#define BREAK_TO_DEBUGGER() \
+	do { \
+		DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__); \
+		kgdb_breakpoint(); \
+	} while (0)
+#else
+#define BREAK_TO_DEBUGGER() DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__)
+#endif
 
 #define DC_ERR(...)  do { \
 	dm_error(__VA_ARGS__); \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
