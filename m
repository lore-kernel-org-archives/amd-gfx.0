Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F2CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208D910EAE8;
	Fri, 14 Jan 2022 01:37:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903F810EAEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpkCGmiRfmApMZvhDA5gZGNKnlXxHqixgiMY+PqjJjvg5Y2A6PvZLeHokpXsOzAqAocUl2eNfkrPZyNVrH7yx2nfoxGVBKiwaPfbXw3yMAlc1dAB/23EvrWLi0P4AEJYtqlHi1YJOpL8J5Z7C3negHRqkkP5nE1kVJ6cowgAMZfHSZJ2yo2D7+nzEBJfPQaozeoZ2C5kl8LVh+djOyKcF6Is1ztOVH8QLssyALV685FgfTUipWZdOREIsdbg5n2zQ8j9AEv4GSacmHBBIWs4fceiNfjAJPrzIY8pILErCYcjwuaTrzV0UrXoLMwaByGRjmbUWie0EUdvi9oaMSv7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5G0KiTxn7NdYkLRiuBU6OGn38eajAccXFFYrGxCGsI=;
 b=An1FVJzrGm+0KVcQXJ8s9WHMV0jWnZDy108FjLBI0Z6JiKFEDf6y+rIl6A8YsZoThfVohkx59VC8Bnnebi4UnJsR5Du3l8Y8NYFUcbeUjnzk1dVUgh3mchuUNpn2Tv5cYCCZIptQR/Gl2Ap2BtzOki1Tj3N/7zaH5GV/WRb9P/K4X+ssC9HiUwoMrC4lP+BAIALeSYit0Q9K/d/OUKZR/sM+Yc+kC6XvYDO52N4A/2pWklgggnK+F0BuLWIaYAnDOcAaNftdPYTfW+iQOTIc7phtm4vRE+xSiYyEpNJTX1T4sW+g1hXzqiQjSctVAroN3UJFQhrqVfR1EZHuuo2BFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5G0KiTxn7NdYkLRiuBU6OGn38eajAccXFFYrGxCGsI=;
 b=t6bzTpPW/FC8Lal40c2dXpWKEA3hfqVjH6vy/tQ71SmBFG6st0wuOI7SWjpEzcHd8eO9NNGz6PpeQYZVKTRoyEUuP8o2gmD8xoi2a+WqooiPwpwYSgazQnDNvkkqFhHA4mFRjzvnsGFERPt1B3aKAHQ3fU1kyjgi6WfY1diF+Lk=
Received: from BN0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:408:ea::17)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 01:37:27 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a2) by BN0PR04CA0072.outlook.office365.com
 (2603:10b6:408:ea::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:26 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:21 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: adjust bit comparison to be more type
 safe
Date: Fri, 14 Jan 2022 09:36:47 +0800
Message-ID: <20220114013657.3119627-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15229fe5-dcd6-4d35-caf2-08d9d6fe6be4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5041:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5041C05B9C7EE8F3E17DCB02FC549@CH0PR12MB5041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5UkjPfvyU1bAJ1WT2EN4oxlP1vXPTsIaFTHNdVJUMysyXZupbxDa54iCGlCVGVwNF7K4CHKxtJruyg/N8qn8PnsQUrWxr+fqDAe2vpJw68TFFCzmBjAWNuawo03wqiNerMA5BFr/DBxPQmLah58Eb1Plo9ZMwFMV1KL6ON+UT3f2Z3oYxU84pRwdRXqqAh11xSO0J/jsPuHaI5gMWDtHZsK/PEwsDB+Z04qGoAwU36BY9boXe+lgAhE48OEA10iVtoygXjAJbqZ/qTWGK3rUkIcCc6PGVccin9JfBASwt3HqHK9RkgodHKdQ2lrErDr/tnjgwqWH1nVOoCy64o7anP0j/5lJ1tpWYFkHBNe4ttw3L/gNZ5QugK88FLJR/yX9ofbhDx/Xw9NuadwoCEPHH9h0SpKejymrU50G0x9kniPFqt4hyXzYqGu0exntdKdcfx1ALau9kqiUG25elwVTUF8qGlUZFTAEHvpWZkdme42GWGrOsGhUUPnSVUn7eKlV+F9Ir21az8C6ibYmvkd8GWOpeEgZoltjBb5/Juuah7P7X1Hg5oRX/qORSamdLUqI4qPPwA3fLgWOGOxa3vf6pYjL1QDL8Z6FDpbUWKp1EposL0mj23/GJB1PWHaep5Ly8kBvXvKLY/Nec5Zjn2ZX8fyfL7Y5KTEOc54W/Cirkcgk70p459oIjKNJqBW8G12y6Xgyo/Gdhi/HYR5USgdK0qCQWH7T4yBFieRfE5X++Aeu+JSBnxgah9qegLLA01xZAQdXtSqpJL3P79UIXd4fNms0CFVMBL7WERm9/03d6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(508600001)(36756003)(356005)(81166007)(316002)(8936002)(8676002)(40460700001)(70586007)(54906003)(7696005)(82310400004)(5660300002)(70206006)(6666004)(1076003)(426003)(2616005)(47076005)(36860700001)(336012)(6916009)(83380400001)(86362001)(26005)(2906002)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:26.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15229fe5-dcd6-4d35-caf2-08d9d6fe6be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

Might potentially have truncation problem with the implicit casting

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index fa0569174aec..82c651535628 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -441,7 +441,7 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
 {
 	uint32_t fw_boot_status = REG_READ(DMCUB_SCRATCH0);
-	bool should_detect = fw_boot_status & DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED;
+	bool should_detect = (fw_boot_status & DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED) != 0;
 	return should_detect;
 }
 
-- 
2.25.1

