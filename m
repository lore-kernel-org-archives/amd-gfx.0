Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37102C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73E2610C7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73E2610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A970A6E3F5;
	Tue, 20 Jul 2021 14:30:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2690B6E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 14:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqBVQHPyfk+WVQz2qYKsiWb8qNtQ5iIUNzeZb3K9E+vEiSb/nJF6fRgXxlJpdy7EXzWvMWAj0Agg2axn6nfadwDLC3NhfNQK7QbTCy+NYpTp/s1pea6nOCXQ3oH7+aIdTvvOFjxYaLeUdYYXyqRXBdz4RJK7UFtFoMw5A5dGateief7o2tycVitmH5uFXIwkmJAhvwcspUQk+gVFokzp5/xtCLzGg0YEO5mZr8/VcW+IBYqBbvdhkg060Vaphdl9eJmJu9YVhZPoytn5kQ0f4t+3unu1QygkR50qX9X0Uq0j1b5P6fzWro1IJNKf/G1n/RZVIgviRKCd45Myv5O/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/OaGKHsVKefbFqf4RSOrzzq9ZycVjRk/hPuHuxvEJ4=;
 b=XyIr2TjB6+ub68F7kdjyKU7KN3qLdtXSaGQjBIQQ91zgNAw6mpBowD5C8MbdBYNOrPnBaK9hQlw5zXByDGOu9xu225pijnZ4eJJOx570Q9yw+L3AkmZ9+MS43C/i4OMROKQUgbVjaXmrfdxrUm+ZnXsiSws+9Grj4kgB1jrdsHBC5c7LZq5MSwSD89o3X3sthDIfzHwSmS2f163WAAFEEaNhCAMVxkcmHZTA+TdIRbKFvjLFuUokWHH4S8GM9oCSDrqPstRIr7vigZUv+lL8qYHL/u4G5iRtWBlP8uB1JaihSj7La75kqja336UxvGq2z6Hz8DBBTWouAlJlIUEcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/OaGKHsVKefbFqf4RSOrzzq9ZycVjRk/hPuHuxvEJ4=;
 b=a7DxYb0/Uo26lfH1ulQ7H5KaNcRN3jH2q0mGIZ6uzTFlLPhqIqjhF+sO0HaAvGb7nTey/IsxHcoRwOb2a/EB9vQSCP9bybSjT8/ycyqvSLm4E4KMTB6WBmyCt5hNeEJk2gLJrlHDzYYOfFwqwWfm8dQtXU3eCiq/OqQDgIvHuHg=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 14:30:20 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::bd) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Tue, 20 Jul 2021 14:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:30:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 09:30:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 07:30:19 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 09:30:18 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2] drm/amdgpu: Fix documentaion for dm_dmub_outbox1_low_irq
Date: Tue, 20 Jul 2021 10:30:17 -0400
Message-ID: <20210720143017.613974-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b563b63d-c4da-4f68-6a8f-08d94b8ae728
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4987619661E09EE8D759B018EBE29@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNqM5735d4WbJPDyB6ly13XMkHMZRX1RcQiehvXyedyK0ENLHXaTq7vFqmlmnZsDG6qLEcrlwMKNEDSaGQQ+c4wG/ZmXjxQKhJftjBGINpGzOlUApMijRf4wBJJVwfujJIQL1CG3eHPP9p1xSufWe2hIXpxqwUWdA5fj5gED8p1C0tkx+T9CNpCMu8QxrrLRITrps6EB8quDIPFqE5JITkcbXjMXTEo8SJIpR2cI7LTpyr7BYTvq0jlgB9JN4EL+rf7RahlhJ2Q+5KKbHgeST2Rzm2vegxWYOvdu3/QVxfl8iDN4vQ0My0jlLTacy83HHklsOLF0eI1OoR8LLDtWdUXhVZlgN5TvGHUUDnY98gdYQ3I6GUo9sTDmgYboOk74Qd3z7I6np3OBzuc/9Q6cWocq8BYWtn0ddR9yq/aRy/FLGjBs7mAr9xZieVCqjowGReaX4LCTt4s28ovTF9tXG6j0jfRIbWv6vgOwRMuEIDkLQV2fG51NUvYBJl/KsNjZeX6PmG59IH4QvDnM2+Y9zQ0314yBueCBCMdGG5Cv59Eqkom90wJ0otMxwrpngoWPlbnhNeMhtI38T/bQ8VDswXxL8KgnzlIJm9zkOueAKPOoRDL6Gvd1xxcpE2pdRD/tLeeqaa3Arv3a/j2scaPNUeRn6yu3BqAqrjE0c9hKeKi5mEDOZGp3zw0PJTfAJ4VA0og5NPxJRxUDv8kDeow6FXKkGlh1AV+rB/BiWi8cArs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(8936002)(316002)(186003)(83380400001)(81166007)(36756003)(2906002)(8676002)(356005)(86362001)(54906003)(6916009)(82310400003)(26005)(47076005)(5660300002)(36860700001)(426003)(82740400003)(336012)(2616005)(7696005)(1076003)(70206006)(70586007)(4326008)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:30:20.3592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b563b63d-c4da-4f68-6a8f-08d94b8ae728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix make htmldocs complaint:
./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:628: warning: Excess function parameter 'interrupt_params' description in 'DMUB_TRACE_MAX_READ'

v2:
Moved DMUB_TRACE_MAX_READ macro above function documentation

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7ed104e3756b..829d31e04f09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -618,6 +618,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 }
 #endif
 
+#define DMUB_TRACE_MAX_READ 64
 /**
  * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
  * @interrupt_params: used for determining the Outbox instance
@@ -625,7 +626,6 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
  * Handles the Outbox Interrupt
  * event handler.
  */
-#define DMUB_TRACE_MAX_READ 64
 static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 {
 	struct dmub_notification notify;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
