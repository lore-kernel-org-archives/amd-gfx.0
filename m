Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 23:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE62A10E195;
	Thu, 28 Apr 2022 23:37:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF3210E195
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 23:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrgzuMm8JSuXx+jE4ztw71w0CE5FqZXeo6keBoaPaB57dbn+RA64dq5L0NgbN7sodVuRemGg5ifcoO18dfPcKp6PeKYxpyiiUuYYWVO3pPXXzrB9Z3mWxKHiwfEWxN0/udQTT3+inmBu9qgEkSgzgaE10tPmfTDF4JeCfCIWMQKoe3b91aRq0cmeokbhJFQSMkJAgzt0YCi4MrKdwl5p9bRkdaLbQ6twWD9bhPFbeq72RN3CLd6xSIpvzVAv9omJuBd+yk3//AMYcJlCjQXMR4zrUjGEw+t0rzCkQJCY9A6XNSgfS9L2U6U3pfA/X+XsOd3Y+YWxrDKmX9AOfY9ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4oOeexF5s5rbbk6b4x0c9m61pkCytXpg7h1GLcwaiA=;
 b=Ee4Mjzux+jDd65n5ybg9/vOORW8VDFyQCKf+1kEI8r/RA2yn5/S5+7/xATnkdMcWaqxnNgerzW4Ctv1OMMeLiBWH/fn1H6v3roR6rBzaqPLx5l/m98hoJGNeEtts5eQE0BtSdR5BDX5OuoLaF4Z4+FzOLM7S4OO17L0reV/6KKHfcMmB+8+wZoQOuWnhj2BCPeCYn7imG4/IO1gS6u6ytUJVsESoUfWUS24KeTrvZbV3uZ5Velt0nkYjGGK2jaN2cmFFu1ykQ3xHfeANiJs0aEQT0qesMqr1Nr13U7j8ggCJoaGDfwapJ4oIwqWs6I93yrsg22776YpFsYuYT+D4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4oOeexF5s5rbbk6b4x0c9m61pkCytXpg7h1GLcwaiA=;
 b=YB4L7rRy3xCpNr1fQGWv5dB40mtfaybroW4p9hA+7qdOgmqNm0dFuSCLXzbh6aL4zqcl+xElkipdGXKg3q/P8FTIomncK9U3Yl+qF+ah+wtaGWQERXc9hqwiw+RQZCy2eIfwALkAl3kpYo/cqNliwk77PHqHVNlItxKoIiFZdb4=
Received: from BN1PR14CA0014.namprd14.prod.outlook.com (2603:10b6:408:e3::19)
 by DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 23:37:32 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::bc) by BN1PR14CA0014.outlook.office365.com
 (2603:10b6:408:e3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 23:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 23:37:31 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 18:37:31 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Remove trailing space
Date: Thu, 28 Apr 2022 19:37:12 -0400
Message-ID: <20220428233712.1518398-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be53bd8-8a6b-48bb-f63c-08da297010ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4561:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB456109AEF898A8E61549718EE0FD9@DM6PR12MB4561.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1JpsVo4lH89UUXDPGr5wm4iSyodTRiz0Tw6Tw27rIlbEc8s+ujmG0u9+ve0x6GIpP/N/sCX+UIduVGQMMxI4mgW0+np7obT0aqI+bDrbcRbcIwbRBVO+qZLyHvtJhfmKtWiEZs+5opMZe7d/NtwZXmDIjq7e0WeJZg0URARmv8V20AFfq5pNpw5UtMkE1drvqp6efo6fWfYpDFUFnS4Ip6Ic+SuXrKJD4WNYGgSG3ZJOjSSQ1nA9PZEPNJUlR2USPHa/gux2UPRFs1B4bEo7VBZ1i91pyqT7ndF1NZfKAzx1qt8oUKj94/UUlp8ZEsSJsj6031LbKwfrmA5RhHblNupoY3or6QEclznB/H1x/ndbjYSZuM7qsQ3b/B9pmg1SSzDWJrwnkcL95WPS+GiRxQnaoxpTBbyckwImjypuC0z5bJxICqEIJP800L75BzC9xHPs4PL1m4Y9nDaXku6oH9nrKHAnahot50dO9VLbM1IL3ATEdhc3uxo3rhHwOjRmv7zBP3MRL5JTq95fT00yX2I2rTFkhJa94ggJp9gpPyrS4bNG48/Gjbnvkgqu1jBA5OVkSS9fekCh0o3OC5luYwMk5tkD7aQDHIg5Db57oSY6lwUFgs708Zu1EkvVlxjc3uM9mv6VDp/uujFSPne9KQHqupC6uB66aWSXGRmrVegLUH4SRRZGaGKXVlhLA9rl7W9vVlYjJKO8H0rm2ghaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(26005)(316002)(7696005)(86362001)(6666004)(83380400001)(8676002)(70586007)(6916009)(36860700001)(36756003)(82310400005)(70206006)(4326008)(5660300002)(81166007)(356005)(40460700003)(16526019)(2616005)(186003)(1076003)(426003)(336012)(47076005)(4744005)(44832011)(8936002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 23:37:31.8543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be53bd8-8a6b-48bb-f63c-08da297010ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561
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
Cc: elena.sakhnovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clean up trailing space in file sienna_cichlis_ppt.c.

Signed-off-by: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ab3e9d8b831e..e4b254775d00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -410,7 +410,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
-	
+
 	return 0;
 }
 
-- 
2.25.1

