Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED76AC48260
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 22:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA5610E17F;
	Tue, 13 Feb 2024 22:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zpc/xgJm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20AD10E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 22:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9sgfxtIhY/awU4/Z+GdYZp82r7CcekdXVkhIcdar2CnOTj3dnHOcuM6HuR/h7nGeibFlS7gQaR+cbvbzurMpiOxX/23NO59GJiCH2AiGK82/qgkSR7dXxo2BdWqx84DFNwenOYfll78NP+SvRxCEqxT6S70fTYRJ0TFL1c8tKVnyyBPUEwfqBUUsk70p5zGMsvf1h+yvZHeQn5T8YddPyRTRkIlctw8GkDBzF6aguAqRZ9bNSRPC2g1pLDrbkSD5GDQXN3/T6aKzITnhuoyX1YPhuGZw3mhkSmfl1tPnlqtL9CMB0O3FkUa1Bb2eLMivOGQ3TN2j1eim7NYLajJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzpk5tUupVNAndrJ5Mh5Da5v6QhJY5kEv6GXfYwlHys=;
 b=EGwwGCHb6meD4ZvLBUm7A74IpN29xhbwwdkpAQDuA4p1HjLzBIr1+/bDypgYx0AmNywJO+cwa7MEioGhiA0xUq8sQ3GBM3JLzhgdJGtbsIA/ZvVIQet4mt2Ayb6wBs8sPbrX6JzuOMFJJvo9/tmpNvi3RYrEKLuDyQujw1Gcac9gngVr1jGtygA5NIocnGAW0plhryzTZGFBsK/aSIUanZ9FgLqKhDlKcREkqWSvv5EgBJ/N2C2BHYMXbL3a+aipysXnCRYTYYAXJolYBGLyQmGZdbtLJ2bSxYYDOD7tvI0lOGE/JOwpeDOj7AkA4Jrs8CaeqoeBB55/JCd0dEI89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzpk5tUupVNAndrJ5Mh5Da5v6QhJY5kEv6GXfYwlHys=;
 b=Zpc/xgJmrtUve54AhbFrgNvg3wYZoJ53GU+DZgjgucZKxqWzITxXDd191FyZ2RoYisnR6JM2F8DHhf+LtsjjNZ34jVtqeH0btEjWsk/fXlxNWlpiBPqWMd1NgWeM7kfupGReJFRaVryx61iDnBm1dm6xHgXziAlguxjjl4w/lOY=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Tue, 13 Feb
 2024 22:34:34 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::dd) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Tue, 13 Feb 2024 22:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 22:34:33 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:34:32 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not program IH_CHICKEN in vega20_ih.c under
 SRIOV
Date: Tue, 13 Feb 2024 17:34:18 -0500
Message-ID: <20240213223418.11733-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf6e6e3-4cb5-449d-2237-08dc2ce3f386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHuu7YFxbFbJPqC4KF8n1MP6RCYp5NSsbW13W2Ci5jQ5ackpXrxfcxEez7Nn2+M406ir05q5p+2xSmXLU4jf8XmFE2byQxgdUk/eJHVwCWf7+GLm+FbIXYzSufi14IB1dwh9QxFTSN3UP4obml+kic9fiXMI5WekwaHqKIGK1QhOmQqRc2ZjZBusW03u499fZgdDNJanVDbIFUq1j6V/kMYA3sVgMjOsnxS+DVWpv/K0/BVYcqFPdWhMBWXnxFmN8OjBFKH0eNM0MACVzT7DG4E1FA8TaDhojMvn/pFHgRoAfwtpUwWWFJ7+npZ1q3R2f5QIz7jiwmy2hI0HWDlnAX+ac710RM4B6SnJ4SsMe2o9KLy7cYS9zkD6HxP9CTHhZl50nALXNXwzCpcxKluqz+pZz7LMqJJTIwk6YUBm9RsHVwThtE7sb12/iCJEPCUSB/aiPtjKnBtKSm66ixvTcf3yNo2KIaGM7P76/Wj7xf9d+uct3RC8o/djCJ06MLxFTbuXomNCKPd9ddwAmBpXoaidZB7zAJeu5BMk5mgx1vC4iokgFB9VXdyAGICgKTqSbmEPQyW3LEZ6jTc4rqmQ33ee+9ubPTp2sp5NuqKbM/c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(8676002)(4326008)(70586007)(54906003)(36756003)(6916009)(316002)(2906002)(5660300002)(82740400003)(70206006)(6666004)(356005)(426003)(336012)(81166007)(2616005)(16526019)(83380400001)(86362001)(1076003)(26005)(478600001)(7696005)(8936002)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:34:33.3057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf6e6e3-4cb5-449d-2237-08dc2ce3f386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IH_CHICKEN is blocked for VF writes; this access should be skipped.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index db66e6cccaf2..b9e785846637 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -291,27 +291,29 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	adev->nbio.funcs->ih_control(adev);
 
-	if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 2, 1)) &&
-	    adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
-		if (adev->irq.ih.use_bus_addr) {
-			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
-						   MC_SPACE_GPA_ENABLE, 1);
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 2, 1)) &&
+		    adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
+			if (adev->irq.ih.use_bus_addr) {
+				ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+							   MC_SPACE_GPA_ENABLE, 1);
+			}
+			WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
 		}
-		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
-	}
 
-	/* psp firmware won't program IH_CHICKEN for aldebaran
-	 * driver needs to program it properly according to
-	 * MC_SPACE type in IH_RB_CNTL */
-	if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0)) ||
-	    (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))) {
-		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN);
-		if (adev->irq.ih.use_bus_addr) {
-			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
-						   MC_SPACE_GPA_ENABLE, 1);
+		/* psp firmware won't program IH_CHICKEN for aldebaran
+		 * driver needs to program it properly according to
+		 * MC_SPACE type in IH_RB_CNTL */
+		if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0)) ||
+		    (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))) {
+			ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN);
+			if (adev->irq.ih.use_bus_addr) {
+				ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+							   MC_SPACE_GPA_ENABLE, 1);
+			}
+			WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN, ih_chicken);
 		}
-		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN, ih_chicken);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ih); i++) {
-- 
2.34.1

