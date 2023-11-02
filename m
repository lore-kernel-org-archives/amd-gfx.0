Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814F8C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 15:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3BD10E8E0;
	Thu,  2 Nov 2023 15:04:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD2110E8E0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 15:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH+nU/RMx6cRJ+tNohrmXNdhPjoQpdlx8DiQNLPk/tRu9DN+sib/WsrF346Ad/yuBp2rPxBuBqtiX5AGfMU36N8R3vojwHY6P+Z54vhSEjlqupOHi6pSAE+Bk+4ge62d4nvuSCQ0BHPc4JQ3x2bG0ryOZ1lKy6VVrJy5j3O1tkJRLSWlrZGhw4Cyr9UQulKzuUgy+oqSOUlYV3F2MmH/1JEJFcUBcNFcFGL3oSW47OzsDCJhwHBSfdwVWcZAp/O39KIQr+RMxXAnIL2clLpXOj8I7b38++sLYyrLgXWgUwG7tdiJJnOI/y5c04aIO5m7TRWq2H3Vw+SMkclOYedq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wncTctsx1aE0FQBp5Wqz+nAzKarTBXzW5kiqwa0eK4Y=;
 b=auGjemGKRVa+tDQfvo2uR0VnyZXormEO384JGLgKazWNxYYKgEVEuPRzIYTkc2H9uVaY+Y0mgqMjXhWh24aaSUPXpkqR9/XohfldaPnPTDBdSTZfUxM+K4XyHz+u4ZUmwMlL634iR/h+Mki/szt0UW5dudtIloPIAjyQXWdnHDfcB7wC2g/JqzWj/UzQ8oI2LxhfkPK7qcVb5+hGjjjS6gO4XHZZoarLiAHm5MSEQny6Uj19uuLq4lvt9qC7pY7v5RKBl9/S3+H5p0/SMiJBcz7J2xyW+U/W29Fb5yrlAJu8FeWGE0ci5ooQT86WxYPbq2InY00fBHfj6IYDUqV4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wncTctsx1aE0FQBp5Wqz+nAzKarTBXzW5kiqwa0eK4Y=;
 b=YOU9zmP3OtVMSfK+7c9rrkSGqwNnonPLGVZ2pVUTIz0qL5WASUMoTG/v6KZijOqQ4GxQXsTJ7qNMpV1eTmOTPCN/KHFSLCkxVmvu3X2HEaURVRiZev3HoPbd5HQ8D/jcVfGmNVGfhncCz1A5NOUk7fscYuSAwGL2s6SeGicczos=
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 15:04:45 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::77) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Thu, 2 Nov 2023 15:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 15:04:45 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 10:04:42 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Add flag to enable indirect RLCG access for
 gfx v9.4.3
Date: Thu, 2 Nov 2023 11:04:24 -0400
Message-ID: <20231102150427.12978-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a69f99f0-881a-1b52-1e29-4cb6b2bc1994@amd.com>
References: <a69f99f0-881a-1b52-1e29-4cb6b2bc1994@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3217d08f-4072-442a-9a1f-08dbdbb50cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZIT5TBjNvJ8ih0Aln1QmEtJNPAVTGGQ4wOcdnVTDBqSyWUeAMDz6ikzfjzkATJQfN6IcsyvAI81dVMzVo92BKKEW3O4F8kiKjewa0DQNWuY6juRgUslmBhMGxxwH+uoYK9A7wqhrfs/LjvhFOwERdJjfoxYbWRL86vcHNbeZVhdN1zlDu3R7n6z9P1+mp8sVRiqCWLRvtn+729uZK7mv+RYjQLGStWEG2El4bWms/jr7h7XKYhS+5qPDRw0RvsMIRo5q2f9aJXNzukUVTQx+EPUHK1ip0GkNduvTX9fYTKCEDzbkcqg6gXBUfSScm/dzM0SQChRoKKQRnM8Vsj6x5rYTBFuucmCIkPeaKw6svB1NF0+NILJSkdPoLFIk6aKoZZCbKVSqEIfwjdWbKjxwjNT9wHHjkNphgKgcUGNKoTKhgLlMgFDlyttmq/kNTsmsFdbuqmZIJnDG+VudqV+XvAVR9gey7qamUXGgLdvjnDkjDyf/xFOsAhCDnWq3IkMJO2jiFoG24ND+SWLaTq8LCX+2yxBrnHJ6FXp/v1qvDZGLmiIayVfBenswC8abvicv8M327yYulmADYMOgUfV83LFcVoBiAJUU+X+unzblf5nNpAacPM8HhKBa3a3vi9HlI9C9UmHrkQvaCu6jTtZACChFBm9m1qpmxrQKSNZPU20udqJ0VZUfoAWopaRQAglSCEujcKmBUMkum3SzVse3PtYD+dTTAAXUHHxD4TWS0r7mqPNSNuIhShLR/xoDvyIBL2OMmxugDn33NwBTetXOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(16526019)(26005)(2616005)(1076003)(478600001)(7696005)(6666004)(47076005)(36860700001)(336012)(83380400001)(2906002)(4744005)(426003)(5660300002)(41300700001)(70586007)(70206006)(8676002)(316002)(6916009)(54906003)(4326008)(8936002)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:04:45.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3217d08f-4072-442a-9a1f-08dbdbb50cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "rlcg_reg_access_supported" flag is missing. Add it back in.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a1c2c952d882..ce2a9876369e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1101,6 +1101,7 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
 		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
 	}
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
-- 
2.34.1

