Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED75C46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 17:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A0610EA73;
	Fri, 15 Dec 2023 17:28:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDF510EA70
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 17:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7oBQB8tWry/uvCKII63Ge8VRbX/DscJefAs5xk/ALBHZkuFC2UmfnIe1fNAytyLSI8YB/63DOxzfPYh/auIwouSxGqeEKd5aNDz4cJMGOofC2RZs9tPMJ+LnWuuKiIH3bmfyTzdoiMieGUKScoAdjYhxTrc/ng5TNWe6WykhTw98CsT6xuGikaIpuON2U4TpHoJRx0IKSx8I4FGprMdKNCgCdS32jKphsYT8bpSU/gBUODbkLsmBLNQlx91KNuNaGKCYE10TyX/yfgBkZ7ga4qiSj0uCybTFsgMZW8Z/MwEa0LrOstJFf3TE7zI/5A5k8LRtyqL2sDvQws6bRtVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0mIk1DtOWK+W7rnNvTU65rU5QNmWzzqeQ/92NtDgck=;
 b=Biu907AV39TVaxZeHJ7UcNUJnCQAO1wGJl+ihX5dPeAmQY5ynS/RwoHu73r6/Knplx0ZJejnmAOgKZRofgecux6QD5+lSa2nbHSzPpe22/BdawKUSG68zfBXFZJZHqlTgG7/eq0pWpCrePUG/ezDrpNVFmHuRSqqxeqniXNan5714n+5iXsv80D+s2yk1vhvwU25+NkvYFxMOGEG9YcWGFXxzYhE8RyfUQ2lv0AukXReXS6elR8cs/GURQraemRiH8yQHVzlWpYOystgfepHVeQY5V5ijtqw0EvyplalM06+9X5PV9Bib29UR5Yts4/OO+tUdPG0nX9uwInDkQuOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0mIk1DtOWK+W7rnNvTU65rU5QNmWzzqeQ/92NtDgck=;
 b=PCVgmVGstkHbhGec/d/9HlRw1r4Y7vzVIEWfwcJ5PqeGZJxTnlnIrVq7PfR3QgyhoOOBjnSRUvXsYfGJhsmCKyKndxmoxGrzV/D6/v6rhXg2wgSvWwvexFdKubMOX3RlPSOEHdX8lubA62lKUKFggM6Mtws71ixHZSQ/JBqxxT0=
Received: from BL1PR13CA0147.namprd13.prod.outlook.com (2603:10b6:208:2bb::32)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:28:02 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8d) by BL1PR13CA0147.outlook.office365.com
 (2603:10b6:208:2bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 17:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 17:28:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 11:27:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd: Make SW CTF handler cope with different
 read_sensor() results
Date: Fri, 15 Dec 2023 11:27:39 -0600
Message-ID: <20231215172740.15407-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215172740.15407-1-mario.limonciello@amd.com>
References: <20231215172740.15407-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 89041c96-53dc-4680-ffaf-08dbfd9330b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVV/c7CrLIUmJKVp8+bHzPqBNMzrKsWeGrdiXEoegc5yh0FeKsz8VlA2jf60bWMN9mk3kZY95seUvLekl0FFfg+Azo7A5FriRTahxWMRwlNUYUCXDTAmkRHIT7QZEcNJr7UppmEnyMjuApA47F7FlZv9+yWxS+g3ud6k8z8WSkZDKRUK0kGOh5QMoCDDEEfIF99QSvpk0CvOTnRMbWVbEE+cLcbPP4ErMlbU4vCRQDHjlnqv4+p+TPyzZFqF8eJ4m92P5KJWHhtjpjxeYSYlXM8ot44p2GXwBvpj9Gp9Pwu2EcxiTHG62XyGagcxmQEEJQblnWlxGRyGC4bORsFl/gIiCtBfWo/e8XSilRvlOzefiSJsmHc8wI8DzoHLHv+NkRZ22CPyejRDtZn0yaLNkDFJG74G1d1E/4bSEnCKMpM9Oaauk94Ymki7gHMY81l6xbHuB3+tDRU+9ysZATgv9hEr/5Pb4UO/OnorRteS+/V1OYOl28OC7QYyelday/KKiO5JqX9DzFXvNXfHYlOdvmXb7yUvpacj0Y3ehRZ1ZjANe32W7yvVwVKiwABflu3REZU7L2se8OeEduKb0lC/w0sZtbadO7mlKhN5g5/2U51VP9RDRtQd/+hYiKpRnr9+mugJujFHN0+yv50MC890hxLPXJcfA3m+kxnNwGkkl/UzZD8K1ihtdn/OBDNo6h7dXVYXNXcKyQM83DGTRHx2Zo+oyAMaAuvB6885bFneprpJahsupgjAnNh7v2CRVL78oX+zlpZIWbLtl3m/lbwUP+j2k8d0RG4YNMXx3MjaShVZeKTzbAichMfnHM/wHTp6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(478600001)(82740400003)(6666004)(7696005)(1076003)(2616005)(40480700001)(26005)(426003)(336012)(16526019)(316002)(70586007)(6916009)(70206006)(356005)(81166007)(36860700001)(47076005)(86362001)(40460700003)(4326008)(44832011)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:28:02.2104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89041c96-53dc-4680-ffaf-08dbfd9330b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

The SW CTF handler assumes that the read_sensor() call always succeeds
and has updated `hotspot_tmp`, but this may not be guaranteed.

For example some of the read_sensor() callbacks will return 0 when a RAS
interrupt is triggered in which case `hotspot_tmp` won't be updated.

Adjust the logic to catch this circumstance and output a warning.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Only show `Failed to read hotspot temperature` when sensor read fails
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c16703868e5c..b259e67a229b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1163,21 +1163,26 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 	struct smu_temperature_range *range =
 				&smu->thermal_range;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t hotspot_tmp, size;
+	uint32_t hotspot_tmp = 0, size;
 
 	/*
 	 * If the hotspot temperature is confirmed as below SW CTF setting point
 	 * after the delay enforced, nothing will be done.
 	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
 	 */
-	if (range->software_shutdown_temp &&
-	    smu->ppt_funcs->read_sensor &&
-	    !smu->ppt_funcs->read_sensor(smu,
-					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
-					 &hotspot_tmp,
-					 &size) &&
-	    hotspot_tmp / 1000 < range->software_shutdown_temp)
-		return;
+	if (range->software_shutdown_temp && smu->ppt_funcs->read_sensor) {
+		int r = smu->ppt_funcs->read_sensor(smu,
+						    AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						    &hotspot_tmp,
+						    &size);
+		switch (r) {
+		case 0:
+			if (hotspot_tmp / 1000 < range->software_shutdown_temp)
+				return;
+		default:
+			dev_err(adev->dev, "Failed to read hotspot temperature: %d\n", r);
+		}
+	}
 
 	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
 	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-- 
2.34.1

