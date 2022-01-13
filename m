Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE41C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 11:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED2410E133;
	Thu, 13 Jan 2022 11:13:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA26B10E133
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 11:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDpB0Sh+Ia+4oPFC5J3FyCOiZd5jr6rZiK/vLRzv3VoWTu8z65QBtEsiwgfj6SHOa7QDKelQvJt1b1wdlJ9MqFkNTFXva3GQCr9sILz8ynFofvHov7yGWWLzBBZVTYRR38PzxEyD83/IhX78JjUxI3zgR3v6/i8nmLPoy9XfTIQAndLWtFadcUOSzgVVy4AmJ5C2DpLLK0LdB+K+qZzVzaNd9ktfWgLJyoitH5LtJh5ci5NIya/Fk77j4DC2tYOcihu+M/B9ebt5nnw9zGuxcerml+8EBshSpnMoEKchuOIfJOOnvpLTeIY5UdD6qSlqnLF0FPnABFsbdy2u0hZGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPM8kmvtS7ZDjhwSc2a4MyIkaI393fP3PjAhkoedC60=;
 b=f6ASZIhH8G0pMYmVBDabXtNuUn8nC+tPgH/VkljY8eVRcId5Z5559F3oR3v35j+CvE8QQVbex5aUuYB4g0pEr5lw22fwFunvnfuKoZtF993pKywLbUulMRBPc8R2H5A2LpOL5PfLLYBYrh+WsBVHO2Gbe3sud88ceWp6ndkhMlMSaw0sZoBWRPKmbd/fXsDJU75ziFzsL+GYPObRJlfykuxwQsjnYIAFOU/RUHiv6lqC3mDbMM/RfmUwK/IkXaIaKmDsReBSYv5Q464SsU8IqnlX55ZivgQZeK7PIxpvIkAxrC1lNRuU4zCNziwV6kfVGVDPZaJ7fuH8awCFAxyI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPM8kmvtS7ZDjhwSc2a4MyIkaI393fP3PjAhkoedC60=;
 b=gRO4EA2cUAnDRwMChpKTuW6I/Om2fO/x77ZImT1e3imC9eXDy+k8sdcnVIFlPD0YogiETRFqkyM+a1rSKiTFt8QYWz2k5dJC89cRIYU5wAksiRfZh1zXjLV4HHWpi83r8ieZlXiowGIcvhnul4xcrdWJ2zlbDGydJiK88cnEIS0=
Received: from CO2PR04CA0065.namprd04.prod.outlook.com (2603:10b6:102:1::33)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 13 Jan
 2022 11:13:04 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::44) by CO2PR04CA0065.outlook.office365.com
 (2603:10b6:102:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 11:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 11:13:03 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 05:13:01 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Date: Thu, 13 Jan 2022 19:12:51 +0800
Message-ID: <20220113111251.55363-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2de6ba79-e850-43a1-79c7-08d9d685aaf4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2574B3D841B38829364E91D5B7539@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0Wl7iJ4fkrrUncljrg0nWSI6ODMrmJTUKTRgVkcCE0bjxHhzFS6sqO3xAplzUGJ94HCVWh7E+m05fKrprnRJIY1xVkkvOVjHr0yOJlIiWijMm3QfSPYYnPiSSVxXVp/84/Q1U3Byxg+346sDChk5+HQ7oFyTphnnisMGO5dyy0AKO+3kisul+XWcjBKEngrmmdUTXjn4JwbLCHGGmWdzGWVUg13Pa+pClDfJnbPls4DMJcDhWNIQAkVAU6RBYxMW5YTVeL/Slg/RDOG+/+jQa4hjGS/jQOG+LPq+MreP+Yba3Puw8nIx0nAQRywWeh5J24XDKgKeA9etlq7Ja3ZS74MbwFSa9FOqmQV3KsGHgV9MU07w9vhaFpCon/ccC4viivUFdx7/Qx+bmL1iGnHps0k6e9TbObN79kzqzNbmoyI5ndnfYYl9IYDCHcJ6faWhcVGNoWE9IasWT6CNg+USUS3lT2n3E7HkP8X/Pa+OlEQ3zHUJGFJWa4QtWFoXA1Xt+LIT9pnbNW8/wja30OZhUS3Dfzs0EGfBClQx5EjZ44hQiE1t7I4G2i2EVhCLlutIZWAFZ8PxL8Ha6gWAXSf1/GMmUaU27E3lI4fk/mFeyJyDmuYJbceBhxgyUibSmvKozvnsdeRJBMTDz9XjCIeAxhn0SiGBfLg2MInn5lVjDapubakJG5bEF/9+LLDS6WS1TJynmgq8mzpQ4Ow4PjwgIVfrP7l8EVCm/2HixGWuftwW2WnzxiAMaQFqAfqSg4eKP/xmmzaHTN/cv7IZ1qdc0ZrJZPtWyqSj6vrelZTIIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(82310400004)(8936002)(1076003)(2616005)(6666004)(36756003)(8676002)(81166007)(336012)(26005)(40460700001)(508600001)(4326008)(83380400001)(54906003)(86362001)(316002)(426003)(7696005)(2906002)(5660300002)(47076005)(6916009)(186003)(36860700001)(70586007)(70206006)(356005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 11:13:03.5060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de6ba79-e850-43a1-79c7-08d9d685aaf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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
Cc: horace.chen@amd.com, victor.skvortsov@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
This fixes 35709bd76d229a51b0c571a768b741650ec47828.
we should read pf2vf data based at mman.fw_vram_usage_va after gmc
sw_init. patch 35709bd76 breaks this logic.

[How]
calling amdgpu_virt_exchange_data in amdgpu_virt_init_data_exchange to
set the right base in the right sequence.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 894444ab0032..0b887a49b604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -625,16 +625,12 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->bios != NULL) {
+	if (adev->mman.fw_vram_usage_va != NULL) {
 		adev->virt.vf2pf_update_interval_ms = 2000;
-
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-
-		amdgpu_virt_read_pf2vf_data(adev);
 	}
 
+	amdgpu_virt_exchange_data(adev);
+
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
 		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
-- 
2.30.2

