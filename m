Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A919C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 11:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4DE10E453;
	Wed, 26 Jul 2023 11:25:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532DE10E453
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjhtDjvm22Yp+GPSRBQeXRWJRyXLb220L9pgzt2iuXTuqVPADY16nP2DQ7ZjFV4B0za/XiDXWPGEgzCdUGN1eaI8W/qYQoZrCtiYxrcMjlKSaI5FlmB7mNoovr4S3J14MPmZfg+TJMwtP5Us2azmEvmbOySvk9bN39AytvcIp8c7z27muy0V5L0ChG+t+/CKjvTDjmPD9Up1jlTvQH2NKnl6rRUn1ybV5JiORoFUMgnCKq8x+1WkJ9iB/WlTJNR2xvY//6bCWsxTCctumWv+LJuNXvUkvBJ5kTeag5q4U5kDXaZWEuQZzZJIRifNKbsCz0sOwylmwxabSONBUg4DaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDwohfbPp2iOO3ASxtPn4B7Um7p0638Izq2SpGFX/vQ=;
 b=aJLO4J4n6R4BweS14fZ5QkL/11nbTdpE8yY1+LQ0PSnB6vkeOo6PN76nU+ZrwhNH+Bex5LtghooAe30nOWqCJ9/QJwQfKTLuFkbhd71qrnjmmVL3QTVHWdDd/kTgcKSSBDaJgXLbmRse56X3tpOjG9dJqDphgFb011u0nYesviCwLGYcF9v4YgGBsQnDODq06/QBa5ZlLgLT8gEwNbg3+Jgouvsl57g2P5aIzGyuse0yyMflgZE1FW4aQFCjhWU5w5blm9bZVgfSyArI+4+T2pu7U0nFmhvN6kBsUXL+gO71JOf3Sf8Mrz0g/IhW2UC3JO7FzXsszaTC2vZKrpR44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDwohfbPp2iOO3ASxtPn4B7Um7p0638Izq2SpGFX/vQ=;
 b=rjveXHu8x+YETRqsIpXaLBQco0LJb3msbME75yAm/HpY8LWIk2TcX+NQEakJjEpeCXG5CfcteKjJA2HD0n71ge1UonZLdpLljLZqCYn7NySZR3ur3ZZAzVk/1r+3wfGJ0FZZJ8bMcsUejMlLnrCjfqcdyslPgZQvUCEH0jPa9K0=
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:25:08 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::9a) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 11:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 11:25:08 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 06:25:06 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
Date: Wed, 26 Jul 2023 19:24:46 +0800
Message-ID: <20230726112446.653625-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|MN2PR12MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: b92736bc-19a8-4b3f-db43-08db8dcaf7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGaHBb0De+jMoj4eHY9yNSe+GJ4RBvG5luBk0VxVvkNxh+7mWyEvefu4EpSgMM8OeUfpE2WUzKMtTs6eC2d5xewQF65hlvmdNh8oRJG2fjDv1B/qywaxR7om5ApwNmjT+gfMLN8ukEQCzJkFizPAVmKMEr+v/P+4DZXfjo+WT65jeX3Ssf82/JHZYadC6d5dBAcdvbX1dIuFcVXzvmgdVOK7fdmYsuMNHlXvDIhq0cyvX+eAeXtQOAlrHp5VgfyXL97OUgR8bGQcrLXn1nkmtpRKv7ciHJxfVyLa/tia+eft9ifHPHC3NJTPrUthEyP5OdP7F+J55hum9WZVrrigmk823oxvOq26lZ27PLTXZHWQcRW7o8AhEb0oHiW/XTsRIB62xkbYqCpfheHjLvZoK/k9Y1Jy+gigsPdNN3bXxn6S2wfJgP695X7+/QOXeYUYSlQZRBDAkwSzC5+mzhsxB4N2C5TAZCqjVYwITFBWmtY0qfN7cHjDxWHISdEH91rW3EnB9AmG/vqHQ75TcNO5r0ClONtM3eMCak2E4U7uTRhw2F9HBEdnwiZmZfwYazIiKHZ362sy2U4ar5O6xYSEQGJRs1FRpAEvNv+xNAYlSTKYOsiEw/8+N6izWwjd2WA+WFGB7ZrZqtjXRROAUfQkfEWVYOXhzglkkd/1IHlFAKXy8+Cm9LevXQNSgJyaut7P45lnJdyvVTTfSspbnFl7fUgTN2YdKeGLz2VBiDLXIhaBViZrlAX018+0gH7XfuCv5C0z5z+n1MN/W1G4XNrPtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(54906003)(478600001)(6666004)(7696005)(83380400001)(36860700001)(36756003)(40460700003)(86362001)(40480700001)(2906002)(426003)(2616005)(47076005)(186003)(336012)(1076003)(16526019)(26005)(82740400003)(356005)(81166007)(6916009)(70586007)(70206006)(316002)(4326008)(41300700001)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:25:08.5467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92736bc-19a8-4b3f-db43-08db8dcaf7f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align with new vmhub definition.
vmid_src 0 -> AMDGPU_GFXHUB(0).
vmid_src 1 -> AMDGPU_MMHUB0(0).

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6b430e10d38e..9c4e084da99a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -102,9 +102,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
+	struct amdgpu_vmhub *hub =
+		&adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0)];
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
 	struct amdgpu_task_info task_info;
 	uint32_t status = 0;
 	u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 604522f70d03..47f5ced12ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -99,7 +99,8 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
+	struct amdgpu_vmhub *hub =
+		&adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0)];
 	uint32_t status = 0;
 	u64 addr;
 
-- 
2.25.1

