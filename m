Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D3EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 04:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE19810E729;
	Fri, 25 Feb 2022 04:22:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A2810E729
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 04:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW6ZZ0A5ADjuaAe7WoTanchkRLX4gNa9XXg2PpfO43T6VGE6cacwtE8Kk0c+F54SJHY2hEcLnGvDMMEbZL++bfVwQ7JP60N+FxYWX6ELpsdQhh1LU5lJ4xU2pkT3Q/vXdMO3nW7mUYReHnTDkoiyf4FaFWAvUCOpBzNEpqLUs5nNfGIn5O3ATTewW/rGBMe664mLZHmEVIkOAXiHKD0TqjgkNX8cTtbCMP6TnYRW5qmz2Zvju5k622vv2sXEaycRW77zl3eLqvAEJTof3GVrf6i6iALq4yy041o+k/TFwlaxbtog/xDRrbBBEGjZ3x1jMK4ztHgrgMJFAXC6DRIDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkSP+NKeVEiJbKIVnktRRj60SbaTzIbdo4oxcrM3Tm0=;
 b=ct/yu+Bn4K10ULjs0yBacOQVwa+KaPmTI6pyK68ztBi+81Jbf2uS68Jr0cstAI4RM53MLa2CYV3nV6hu5oDitj6lRFxKGHQaq3EHTgs/sgestullaFBgUzgHfMjveslI+8I40f/MaloIlzun9pWV3EwtKKOZjMCcHKs1lmyfGiblD2XykDcy9RWbBtWtEBpokmZGJmOJpBtdqyzzemUWrGgCZIPC+wNxq3ZYQMnzJAmkZev/8UUdPviOGvY85c8RPRzrsfShVkhyPf7RP/JpXgWe/vjLSK6JNQ/cEfAQ8UzUFYtdknaL4u3BiA7JROmKsOXw6kxm0Opk/GlMG8mEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkSP+NKeVEiJbKIVnktRRj60SbaTzIbdo4oxcrM3Tm0=;
 b=MY9ZIlKmeGsus9II8Wt3yTrfKglNowACdraV4xl484oRg2KzeplNgMLC33CkFuaTVi/WO32k3zatFfFKCxrb22hCKaL0+6VH5njqgcDDoGtwSnG5OBCdPep797vM9zsDr6LYTUnrWctch8032+QwWd3ojuIAJsyuzPeRiINA36o=
Received: from BN6PR16CA0013.namprd16.prod.outlook.com (2603:10b6:404:f5::23)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 04:22:20 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::c2) by BN6PR16CA0013.outlook.office365.com
 (2603:10b6:404:f5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Fri, 25 Feb 2022 04:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 04:22:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 22:22:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Date: Fri, 25 Feb 2022 09:51:56 +0530
Message-ID: <20220225042156.676421-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 711cadfd-cb98-4688-e6b2-08d9f81669ab
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1398A85BAA7BC22CF2C62A47973E9@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /w7beyCYyu1MKcMNMVo7qhoqWeNI5Q9eDwNKZEXaZTmE/bZC+sqiXQLVI4uGwMDi7XGaywsBIfASwtzZ6pJrxHraKAmLu0m8nAqtqo+Iu85LTHrcXQFmnT2Kyj8CN1CZcG7yloXh7a2mmQZcdpYDxXdcxRbTNazzINlls5LaPsbVscrrltXjJAb7ZCO23jqxrO1XEjnyMVHD9BM04RZVksGHuJPglnqNWXQ8HTHIKmYpquW9rjS/mnTmk9Lv8oO0C25S+0Os4j2SPzl2KNZ14HJCd64bYSU1ogbDOxjtTMYImMnrL5OUtO0cHpr+ms1DD0wRk1yqeE53Pp98DG02WfX2j/Z0VjLyvKf/EZlK1mNJVCI0C28fHECHNR7wivmRTqLfINNclPeCEvttqxUu19VI42JFOfhVF9kj3Z8x3z6ybvvAaVLIBvrlmSqDis50xjzmC3V6uzv2sjEdQ8KYUb8F90drCBe+tWMqPCQDgS3koqi7Y8lv9uAU3SGbGw163SfWyRZyM6ZfcgcqujbZhOj0GdYqeQTZRhd3irm79Mg1CBS4FPQ2FhLpNx7UWTQu9IY05fo/Bx2FuJ2UzjAY37O3vY1reZjsgoHc/Fppvxvl1glSjn9llpW+Lt87kEu1p0r6LlimwJ2T0kJ+UPn7nunRbIi2xLC3m3+WSVYi5OJ5CjAwtLMX83eWNsRUsysgSn6O1w8n9UvV1e+x/Gt45A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(4326008)(8676002)(36756003)(426003)(44832011)(16526019)(186003)(81166007)(26005)(2906002)(356005)(336012)(47076005)(40460700003)(15650500001)(8936002)(2616005)(508600001)(316002)(1076003)(86362001)(5660300002)(6666004)(70586007)(70206006)(82310400004)(7696005)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 04:22:19.4853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711cadfd-cb98-4688-e6b2-08d9f81669ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, KevinYang.Wang@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When PMFW is really busy, it will respond with 0xFC. However, it doesn't
change the response register state when it becomes free. Driver should
retry and proceed to send message if the response status is 0xFC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 590a6ed12d54..92161b9d8c1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -297,7 +297,6 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
 	if (reg == SMU_RESP_NONE ||
-	    reg == SMU_RESP_BUSY_OTHER ||
 	    res == -EREMOTEIO)
 		goto Out;
 	__smu_cmn_send_msg(smu, msg_index, param);
@@ -391,7 +390,6 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
 	if (reg == SMU_RESP_NONE ||
-	    reg == SMU_RESP_BUSY_OTHER ||
 	    res == -EREMOTEIO) {
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
 		goto Out;
-- 
2.25.1

