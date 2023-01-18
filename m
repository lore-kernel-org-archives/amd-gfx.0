Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F5BC38147
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 22:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE7810E860;
	Wed, 18 Jan 2023 22:47:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB28010E860
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 22:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfIrFPhfXOOYsGgio8xkvJWT1MRSlcA6PRL0HmLCJveXrvaK81kD1aSPpZ0Mm3CLvqeL59MCYpMBbrbeFRxxnLJ2GlLCVLgWw1c/8uNJt0KTQR0CvQZL9tCDM5uN0zq+LcRKiK7swqWv+LePbhZoxNowSnfGz37IlXhKGdJRPqhY5O40pFmDcvPkYCZuZoZJM/427dLwyMPmRtSXqDh37whKFA5bUBHv4IyzRLk2+kzCA1E0TMloqlOOjqzF7gDCLy+a0hDCnTBYNNOlKANEuH1aN2DwA/66zLNpkGLrEzf80jTCYhU3dZMFKt3F6TYP/lIUsfJiRw2KW8LQCh/cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zhUFR0Y6xI9EplYvBMnEWX60sBOkUbTWeKvyuvxw5s=;
 b=MrSI22n6IFM+yNmc0wtGbOalFDGGsISm3QTaUOLEONxVPaTlRDI3M/kExwjhTmKBYeghbIXQIZNLudcLnfjKBYhLPHQSfNDROp+UFOlTB3+aB5PCzLQTNw9SGlf37UrjB7VZeecEg9spYauuUiGjK6ovVyfA70VVDDD/1IVGif/aYFzVgb7Mq/xg3M1PbP7h3YY0wIO4epTTLQziYbVhUp1qgD4a5U/zZPKuInGE4s5kCr3UE4dKACoQG/k2CY0uy6JIzetvOGs4YB81vF3l03z7E9bsAU+3SRy8TTjSOpHQ2CU7/w4NIC0kXmOAcOtfoZUkzMc71ALBLNaAJHQqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zhUFR0Y6xI9EplYvBMnEWX60sBOkUbTWeKvyuvxw5s=;
 b=H1cU913IU1dW2EuX1pwTrnPGprtOx9/NF/udxx+ng0mW/EYEO5pEgSAO3xSwkDy95Un5ohcw+onKjOR41o2g4JkQSWQJH9iRZvjEH8LUbRrLlbbB5nbI6thUqCIt/hf3KtHAknIhiICP7aei1v3c/43kWIN9PNRoPvXwGHwlCNg=
Received: from CY5PR20CA0017.namprd20.prod.outlook.com (2603:10b6:930:3::13)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 22:47:14 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:3:cafe::d4) by CY5PR20CA0017.outlook.office365.com
 (2603:10b6:930:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 22:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 22:47:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 16:47:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Decrease messaging about DP alt mode
 state to debug
Date: Wed, 18 Jan 2023 16:47:09 -0600
Message-ID: <20230118224711.6832-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118224711.6832-1-mario.limonciello@amd.com>
References: <20230118224711.6832-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|SA0PR12MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3c79cc-1598-4819-b824-08daf9a5f1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F25WtIqEjkKMKXZiAv5l1rL9g3PZP7NZ+T/vrkHpJykjkDyXqUvy6kTvUx1+hbQ0CcwTckSAeYQ8BkJ77YMHWLjCjYFJ3G/vKrav92Tqi+yAcKGXMxiz1JeJiTjTnFFQrDRdjMUzEx/5eG+2zNHfoz9BtV5QvlZdMX5AFFypzG/vCNQHlB5baSenxfHqQdKo80V8vy8aWd1bHiOnhbU0q+SePJcD/rbcahKMxKT6e6Mnkmfs7TOSJ27emCY3sa1vi3apoL5oHIclwgtdwD+zFXApXuLhZ17NqjOi83/b1buBpub3QSaOTuoK/dnqSWUzIIvYRjF7mzIXpZTd7E/TIK7Ufb3QAtX/88uKZggvkNWFqnBOopYcQJhZcIz5b3a3FCKpqfQuMRUD9jz3b5nmT9bAl93IEnkxdioPDOBlI+3AqMoDLXelLfstmlJtxxtfRL6ia6nSR9FzgrEUjJfnLYpIe5n6SuIIXMcCMgYgNsUx+bGq2HFKcU8Nuf7wPpry5sMoLxYIoxoJM/I9eVyMP1Su34xS5j+zZ52AXmwkUwJyU/zfovXYJJEEsigktG7URCgk8TQGKDEdwfbATe/LUJ505/N5Aghl+i/8upOW4GCmQvzQDjedH9m0C9pSViX93JaHexQASKa6Q/mBcaODrftWqqLNKmuy3dN/gH21UMORLFpu29Ghx7oxUm+YKtQpEXnaS3cfL4LwwlGvrBka6t2gyB6XT3QPvgVQqEkHf5s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(82310400005)(426003)(47076005)(356005)(86362001)(44832011)(83380400001)(81166007)(82740400003)(8936002)(2906002)(5660300002)(4744005)(41300700001)(40480700001)(40460700003)(4326008)(6666004)(1076003)(2616005)(478600001)(186003)(336012)(26005)(316002)(16526019)(8676002)(70586007)(70206006)(6916009)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 22:47:14.4629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3c79cc-1598-4819-b824-08daf9a5f1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently plugging in a USB-C device that issues an HPD will emit
a warning level message `DP Alt mode state on HPD: %d`.

This is needlessly noisy for most people, decrease it to debug so
that it can be turned on by dynamic debug as needed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5cd81348a88b7..d9e490eca10f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -837,7 +837,7 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 		return true;
 
 	is_in_alt_mode = link->link_enc->funcs->is_in_alt_mode(link->link_enc);
-	DC_LOG_WARNING("DP Alt mode state on HPD: %d\n", is_in_alt_mode);
+	DC_LOG_DC("DP Alt mode state on HPD: %d\n", is_in_alt_mode);
 
 	if (is_in_alt_mode)
 		return true;
-- 
2.34.1

