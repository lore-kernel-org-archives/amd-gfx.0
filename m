Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C683DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A8510F471;
	Tue,  3 May 2022 20:37:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC32810F45F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmmZI4CmdMKU2glQGxTX35hAkwBnM6ug33TCPjdXPDZq2GNZcDhU/LX5U1lW3ACulIZzUqdj1xRpoWJ0z3xW+wUkwnRpjF8EeUGobxMNudbXe6yigd5wYu+GDy9ST6Gt+SP+WLkpfFCEAluLeU/gdKMwZMvOWn6n6SscxNc/RRwuIVIf6zdoblDBbSeGQ8X9bFEqDIQKhZzKPDBL0vyLS2v0geGYMTpPDpQ5JNFVKvdkdhrvRNOORy7nU0h3lLa0tKrhjqlRZpj5hB3DNMS5anxbQm23MSMnLI1uFK3k7BO/F/wEi3P/ZQr43NH9f90A1lomYJxIoQWe6fvpohLL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2priJA7an+YxE3Dfrtxfqal3bu2FPVNWuBVxqaxefM=;
 b=cyVxf/frLkV8n+u1MAmANqYKX9rF9nmWHZfgpUYzwcy9eLr6ozw1ms/9lRn+OQq+IPClBA28HZRBj4ah+ERgsFkTPJt+HGlCh1C/vhTM7v5Ilro0BSp+57aNKVP1nO3eHoCtJTQ9Tqm3cN/KpUEwlQ+A2Z9V2211Sy0ylXlTlPo76VOk/nZg4zWlmPgoiez8wpyv6hrlAkd5XH64jshtrOj3zxycmqCcKmspkeI6k1domGqJDO+r1HZ4caCNoA8MOPhcuY/+4nfgI8QSh2x5FqD8DdH7hVSV2NB1fhpBd+hw3GZcTzzecUXLoQiyQ0vLyNNQYkQPP5AWRft7E6k6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2priJA7an+YxE3Dfrtxfqal3bu2FPVNWuBVxqaxefM=;
 b=R0dKVZwH0sh0vfzNlOhumgL99uS4RYoVb01wWdL64PKp9BOfmi1a+mmgtm+8Ruj4fAUVFRMKIR8a2x1800P6zbpq28pSEvcsGdDDsGpvheal2D/Uvxo6fi4Qp7dDpFEGVOwYh8RxDrO9FLH+teaK2Ih1qLpixiUnydWHk6fu6f0=
Received: from MW4PR04CA0132.namprd04.prod.outlook.com (2603:10b6:303:84::17)
 by DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:37 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f3) by MW4PR04CA0132.outlook.office365.com
 (2603:10b6:303:84::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/26] drm/amd/pm: enable mp0,vcn,dcn dpm on smu_v13_0_7
Date: Tue, 3 May 2022 16:36:59 -0400
Message-ID: <20220503203716.1230313-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba722320-aa2a-413c-f139-08da2d44c270
X-MS-TrafficTypeDiagnostic: DM6PR12MB2666:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26668838E6F022BE31F4A499F7C09@DM6PR12MB2666.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuIDRdoS+BNrMr1FppTnTo2lGmPCP0IwirDuJyf45m9rY2THWbZCYUh9Wqil7YBPNPv5sfr/vmFnuK3BdaDF39yyqU95oh1u1S6rl6T1qLR1Ed6WV6szNCZfV740kYWn69ISVA+COKHX8Y0A+OXSWs1W4ZrItzrrhwbMEMJzr7aBBxbBgZ/mQefj1mdsnKBkMo/C0Yd0fXOB3VVEnCm+rtfZYxEd/oaxAxyqTVx3BvcAavMiS00IBBkYY+hOoZSWSLCdZqYQRPhOIIFRGgZmg4uHEzYbsJmefpBGmetZdWCZqQU8PJKn5cUJfEmrU5J+hUE0P1+i7gusHlqGhSFGoYfjVer6crciMgjUr/IPm1IXcPe94MgQZnU3fmRPPqxx12Sfv8qLoQa2zyBSdrdtsqBrGZtTk5z4Yt11rcMBSrIFgm0OSCNH6SMDnTRt+dwKI+fFyzZhJltnSbKVTcjKYmrHxqaPdNlkHUL+HAqOLOdjh2N6YHBfgYYx5wZpf8Nm8O2IthJJwEbioKgJyHzPffFEzzEq+yy/8BlW68qXXMePmD6b1bylg1q1RUlJPn5E2iIXHb1R2EjOn00HZaWCUKDzeWoeuXQf64J5Z/a7AaYKK6WWS7e0bm1nqvzYltSAFIumnest8nMYb8J8YQtYTu7SqPm8gYvW24RDuEhuapp03QLAdaST0W3/pksKeLq9XJgCXDX44XFINICWg5iylA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(4326008)(8676002)(70586007)(6916009)(316002)(82310400005)(86362001)(2906002)(5660300002)(8936002)(2616005)(426003)(186003)(7696005)(6666004)(508600001)(26005)(1076003)(336012)(356005)(81166007)(36756003)(36860700001)(16526019)(47076005)(40460700003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:36.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba722320-aa2a-413c-f139-08da2d44c270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable mp0 dpm, vcn dpm, dcn dpm on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b2e858e431b3..12862866cf6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -176,6 +176,12 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
+
+	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
+
 
 	return 0;
 }
-- 
2.35.1

