Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB11C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BC861D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BC861D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F204089FC9;
	Tue, 29 Jun 2021 15:55:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308B489F5B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn0VoqME4fezQNVyvLQpfPUUQ0xMFu7G2h84dUuW7BprpWSpKZeGX8DdrEj9IELIqCbYA5VGFGB/VELSp6xJqS9ccjte4i2leiD/N2oXxCwngvSJzwNEAGDn5Z9mqf0Nw9IqdYVaOBrW23BSm5a6h0tnsQ4i4l0+634Ux8oZnQsNWSn0CCppU7V38WOlCMZTsi5w9qKgotEU7rHHyY2YN2DRHp77FKLhFt3a5KvLSG2C3cAuAvCj/TbdnrSt4lBJbCzwyIQmDsxdQTqftF1TG7+L6nWjJMsvRlOQrKW1qG/0bZIqTsFmDWa/1yq+Z2ukkQWVtgoAU0J7Pi1DhKsn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgK6TlkxC0HhtjlFXKXlYYAzDaIX7k3qkzio5AEAL3Y=;
 b=B4x3cy4q7IGPH6IiPsZfdTklNvme1GbNyGc8JTw3qBkCPvlKZT5xmk0eb03XzU0PZ+ELsp45ilVYrJWehP37QoAa7pr+6idKF/tADgBGOXH66d97URE7OutkaNk5XG1WpC6yV5IZ1HSqlSofFY2O2R6wKgZxaJQJ3gMcJlgXTVQpBbRrqdPiC/JXix4zT3hFD40bgOvX3rOn61zc3TdeSFeuVHPgmWoPtqae4YzpC1AVqKbLXN00AHtVCmzwURAMklVfVzd+UI5Pkypl5upK4lep6QdF4fFVclkNUxJQVgg13iOYPXOUeTrevu1T6oYHoX6qeASxuSw0oGhU2MK3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgK6TlkxC0HhtjlFXKXlYYAzDaIX7k3qkzio5AEAL3Y=;
 b=s+t8SUSSHEFlDbOB7isnZfOmaUpffzlSyHulLXm+7CK+juTbQaPE8Qy7ZsTn3hQ/fNam9d6WjB1X7773PdL5xsmuJ3bDo0VjMq/4sk2LOnR2Vaw8eJjn5+gZ0qy+xPGd2/NC0E35ZYpXkm6jinI0KTLTjHycvGcY82eZAQPv20o=
Received: from DM5PR13CA0038.namprd13.prod.outlook.com (2603:10b6:3:7b::24) by
 DM5PR1201MB0012.namprd12.prod.outlook.com (2603:10b6:3:e7::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Tue, 29 Jun 2021 15:54:57 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::da) by DM5PR13CA0038.outlook.office365.com
 (2603:10b6:3:7b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:56 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] Revert "drm/amd/display: Always write repeater mode
 regardless of LTTPR"
Date: Tue, 29 Jun 2021 11:54:16 -0400
Message-ID: <20210629155422.26118-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a67c76-e3f9-4705-a8de-08d93b163e44
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0012:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0012E21FF3D7849820D8CB3098029@DM5PR1201MB0012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QetRPRaTeMo5TJayjUC7EUDOhujbhnAPiCROOxumR6doMZTfVKSl7H/lvL03Ju+/56xiy6uj4MuS8LGbPEyTKSTWEvm+kixGDRM7Wx7B9E0iIUJyBQAujC6uKT1pph2/2KeLnDg0qp+R8gOVHxa87wojsG/IXdXRh/VLeRqm9hEaF9NwDv9mIDtLtMYC95Bh4TytlC246qwBwmWcgLZteMUOMkhSh+hW7SGeaq7gEZ2YmOeWFv1zVRT29rF72cB8nNmZ+Wc3GGx6U0av8OGwEdemDQAPme5RGncQwAiYKxTgGmMHCDoVihgioeNWYstbQUNcRKVSFXLbBHgoBt9RyUzm7hz66gttGIo4Q+zv1pPGsd96YmHV1Tpn0qn99F5OReNaegPKKfg3BzLdMiMnwsZJX0TXL0wUFQiuRXuI5tCLfjhnP9FlI1XkXtKsbryrNvpdj/7LbbaY14CiWngtE+qXDbablmngRGTC77Xx8qwGEC326bHSilHt72N4WCvJdOHLUrKQL1kmcMhSJei7P536NIMyymGE7iegzHGKwEupwXFe6a9bKcr5VbPflnNKzFGEAOMg3fVfuiueECmQTMmr0kXg3N+nzZbY9rf9Q7s5lUKAoM1bLHzWsvqbLlV+u0nmriF0hqCDYv6mOHx8SzSZeYJcMcQ9VELTFu6amOGR2D3dISXS+2IDPZcIrnJiVfi20S7R4C12TaBlcW+Ux8a7u0VXL1tFvaySuPLUth2UkB9D+4aMQOpNPl4PUfs9l3lUqt8qN85lgmUSVhjRlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(6666004)(316002)(336012)(26005)(81166007)(356005)(82740400003)(16526019)(186003)(4326008)(83380400001)(54906003)(426003)(2906002)(47076005)(478600001)(70206006)(82310400003)(5660300002)(2616005)(70586007)(8936002)(36756003)(36860700001)(1076003)(8676002)(86362001)(6916009)(26953001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:56.8582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a67c76-e3f9-4705-a8de-08d93b163e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

This reverts commit 06a2bd7ae7238cf31faeb2216c0e8a3d9b1bedfb

Some displays are not lighting up when put in LTTPR Transparent Mode

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5c3f78b2f1de..410543797275 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1608,11 +1608,12 @@ enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_train
 {
 	enum dc_status status = DC_OK;
 
-	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
-		status = configure_lttpr_mode_non_transparent(link, lt_settings);
-	else
+	if (lt_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT)
 		status = configure_lttpr_mode_transparent(link);
 
+	else if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+		status = configure_lttpr_mode_non_transparent(link, lt_settings);
+
 	return status;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
