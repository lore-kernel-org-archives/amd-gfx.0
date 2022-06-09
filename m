Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA35C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 05:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02FD1129D9;
	Thu,  9 Jun 2022 05:14:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2761129A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 05:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQsOCAWla4PwxYFsGt/ByubWV0NJXcXWaUl/3nRRdW/Ofeif7BBR8/niDbtpy5631ddL6peAX07Q8kDgiAHCI6QoltjSv6JbirOkmup2cbSs62UnYOS3XNaBAazzz8C49MKeIwqi1odE+ABmBS3yzI93Wr5UF8mqeYJTVjbGXQsa7fTptGT2cVX5h1ZGLeT2e/3zjERvczR6vmXOPUNOx+LAm+yicPCQunBgXgdB6yL13I/QvdQEKRxSm6v7UJl2iHOniuO5X86S/Fc97Lcjac4c1UHBM1njZ+PyWKnCWnLqvJaVW0k9xgeXQTK9+TOSGph0gi5EPeLu/9/vrO+oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKE7/5pXM9cvPXTdGnyoMZX+kYvX7SkIlT2oPC2fYpk=;
 b=OVoZed0CsskM/0Fl6vr0tlEEEYdzIy7vV2uHLQzYQk90Ugo9nJ7N9PcTB8ucEvFuq7ji+T8uQy4eMFp3fJN5l42UzSsepFduSR7AGrzrxWZPTexvYAzSQuvrmNj9ep0GsZKO2jcdlWV35Xz5f2tVCu2Nwly+R2HBZu0CWU+aIVm0f49kiXRIM6jieJYL7a6+2a7JF5n1B6ED/ur997VwPhNHJPZ0+CzC1IlxO9hKj1SOdjIAjrZ6pxjvs0HQHMGLQ5oLrtiIHxzfyfCq1icX3ff0pJ0gdPQZe7REBu1WD8XM0eGGwAfVQTNvaSJQwBuDSOgCGZL7/S2lKekA4g/7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKE7/5pXM9cvPXTdGnyoMZX+kYvX7SkIlT2oPC2fYpk=;
 b=0RN/HVfDeXJxHPBVZ2CmwLJ76L0dlAPuinkhR7oyR++vA8yv6QwKVQORnlZeBu/ZgNvOtMIsB5WED1yF57vftamgYs+f2oPipQSNM+2Ucf+0Ip4Gq78KD+CA+hb59h9L+HzKbegWQ3kZgasN8/X7Vmmzm6soOKd8ZAEBXe8eI4Q=
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by DM6PR12MB2905.namprd12.prod.outlook.com (2603:10b6:5:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 05:13:58 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::8a) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18 via Frontend
 Transport; Thu, 9 Jun 2022 05:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 05:13:58 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 00:13:56 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/pm: remove the repeated EnableGfxImu message
 sending
Date: Thu, 9 Jun 2022 13:13:05 +0800
Message-ID: <20220609051305.3462971-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609051305.3462971-1-tim.huang@amd.com>
References: <20220609051305.3462971-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f913f552-dbb8-417a-8e2a-08da49d6dbe3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2905:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2905492EF2016A5D2CC722B6F6A79@DM6PR12MB2905.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhrC1goO+vTv5PM83sUmPQzKxPgMGZQJIiWim0MI9jAAdP25ZTch0r1ww5kHzph2zFgY3LeYrV35ssrfTXC91eZmICqr7gXE7noFnUBUuovaMGl5bBrOKh8wMy+dxO4UTVTl/iTUePlkw7GLPtUaJneiiYq/PaUwXrm7gnH6dX19PsJTWzzR2R0FB4XXYhWWdQc7QnE8kvLTQ4qfmAcVlPRcJX1RADyaDXUPUw6qy54UyhfSL2hd/JAvU4Q4eofkO6GY0L5qq8xi+Sv2L2VnW+DYNmhNZJm1WYwGZ0atyPGCHLxgD0Gm2L94sTFT39YI+niOi+8ha31uRGIlrJaO8uj4ZcjRDH4oFZ2eyweVJyczD+Q1AFkSrOlA9ujIH/zKp2oi3hroWNZmjmHEE65WvxauoN+p5BXSWh2Gc5cpUEYpFgH3CCc79riy8gD3wOs6XbCKRq4+In06bp4iriMryMclrS4pPnAbGpYA8EevJLFgY3IXjZMGiTV6RQ0EUdxE649v4rB0vMucl9JkqdNaPU3aqX45eOltmGnEWOm1UiPS0h+XMOuBCzqghHvjtVeDNW2dnUJGQKD3gWSIGR+to3gL2D8JjBXYFk5142EgdrCCMghgV204PS2TXLIEpXhoThai/Wl8+HDwMZPCrQEhNxBcZC6kR//DPlsk4XO3XMrm7GkAoZU0nuoMco4JwIwTptBHHA+uYBIYfPB6y94BVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(44832011)(36860700001)(36756003)(356005)(82310400005)(70206006)(70586007)(4326008)(8676002)(316002)(6916009)(54906003)(81166007)(5660300002)(15650500001)(6666004)(2906002)(7696005)(26005)(336012)(186003)(1076003)(86362001)(83380400001)(8936002)(16526019)(40460700003)(47076005)(508600001)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 05:13:58.6205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f913f552-dbb8-417a-8e2a-08da49d6dbe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The EnableGfxImu message will be issued in the set_gfx_power_up_by_imu.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 196670345552..82d3718d8324 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -219,15 +219,10 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	/* SMU fw need this message to trigger IMU to complete the initialization */
-	if (en)
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxImu, NULL);
-	else {
-		if (!adev->in_s0ix)
-			ret = smu_cmn_send_smc_msg(smu,
-						   SMU_MSG_PrepareMp1ForUnload,
-						   NULL);
-	}
+
+	if (!en && !adev->in_s0ix)
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+
 	return ret;
 }
 
-- 
2.25.1

