Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E1BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 07:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D747310E40A;
	Tue, 31 Oct 2023 07:09:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66C510E40A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 07:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYwqq3BnrI+OKypyRqYyfMQnGzUWwyLHV438v3U6ew/4ZHIqMmiMG/2ELbVX4jsmC3XOZyhU1rhTyb+OuIJjl8290+jyuPlta11o5qP8lsMfFGHlv4VCr6n8JWoDtwsw4JOcpks3k3l04h6/bLG7ubg1er1sBQyfTkSNWn6AoOmdaBRG1mhJZRRvNrKn4v98f+20YMtlJD7Tt0WhA2Cyf7Gj6F8e5NP1PRw+WM5qfOWWTN31tVUfUMp9yfumyAGkFfyYkLK/OyE84yGNsNhSpoOt+NKhiwfJ0fbLPBcOIBOvlwco1xl6X9jtEjlaJXIZ9Xxc0UH3MTkH8O3p1/dFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4L+c/eqCPABYU+w1zWuDpuizCro2Gp7tE3vR7x3d7c=;
 b=SmeBMmpCM+Q8tFONw8qHjgwJ+fC67uwJ0teQVCQjPfnKbgqxEClOWTBHsQNqulCLOqJ0abo+WF9YGU/1hprBAk9LDEsGkPzWw8EeagzCm3fPNIOGGbq0SCZ3ORTFc+iS7Uc+yKOU0/SN3VeBRijs1nBSJj5t4ktbISQWFKByY7otgMGIF7xLz4amWUy1Ju0k7eBaTusbJvinGK34TdvXb5G4gn2i6ZJe+Q6eicuZTAqLhpJ5s0zjP1xXgEC8HJiiqzxDN/gkWvtxnk3cqZCOnXtSFwt8G8G94ORijjFIuDZQdZYZ8vn0Doejuf+Ijia7xOxpwyLl//e+ohkSYOjIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4L+c/eqCPABYU+w1zWuDpuizCro2Gp7tE3vR7x3d7c=;
 b=tjIh6xni8BszHUd2lcseA9KAX5PaOZbKg7cSCatb6iFMZfiQDb5kX9WxqxY8BMa1GPviUelf1oNInxmIqqeuzOffVTp6WsgKdox3LmPP8OYTQLq0aS970XcxMvAO3SOPmXJaMaY60TXDiwKDQtBPz3e2QRJIDf73SmEasdowokI=
Received: from DS7PR06CA0044.namprd06.prod.outlook.com (2603:10b6:8:54::20) by
 LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 07:08:59 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::17) by DS7PR06CA0044.outlook.office365.com
 (2603:10b6:8:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Tue, 31 Oct 2023 07:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 31 Oct 2023 07:08:59 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 02:08:57 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: handle extra UE register entries for gfx v9_4_3
Date: Tue, 31 Oct 2023 15:08:43 +0800
Message-ID: <20231031070843.16461-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: d13bd19d-6427-40c8-07fa-08dbd9e0412d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBM7Z1htiQ+Dp8ptMSRS5FJpGsvq4VVidLxX0GnpSShxjVohGEFralZBAUXpscMnEFKCjp0Pifog7aie9HXiaMEpCmYMJq4YEoyXdZm0b49z0dcKw9sNvf6IucnvBgWhzTWxly4BI3hvw01FBQ+1gF7uTrPds8XIwxslOvcixAywuKb4g2Xx3aO0Fun1NUH7j4O8x5xxSq7G3FSvnQKOdX9Egnk+laadXOhbA3GilHp9kJvZ8pz3VGwe6w4q285r2iiaej7P0x/PgZ4vUtiOHbKuT650ZZhisbyl625QTqX1IKzHdgA091mtfP+vzkRUaV6bBIanaOe/fpvVFvaMUKkZsxaor72L0qa5oiDIe8zoEGyOKiQFFa68f5KVUaSvRQAgLjmKgOXtFbW4IDaqF3Uu0fjxwOW/nZ5agLaURtA9zwSAvQk6LK2IggLAQ6L0HPvbKihyOjZqLvI+nyVgq9MqS/BkxyyuGDasHxeYHzeoitYfuIvJPAVx4uDwCNjQv7taQZjYMBrNkJ5GFz2sc72/5HmC9JQh+rZPVCLWyw/ljkyXDER+R6XK9cEQfv1YcYyZCNUO4QyF1hfYir8ofJrNV+elQvDaSWrx+bPG12Da2/lYAE38Fwt2EOZbB0uAyUrDmN+ZLOWm/bTsgSeO8JW2az9eu1XhrkWNgiwXx5o2Diilo8aYkMYOJl0ivG/hCYPFby4x2MFdXA+pVHJ2sm1jwY1HEndhY6JPxn8obfJXGislSiYMZMBJJjnln7gHAJdOvR7BRO3+GnCW3Cs+4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(47076005)(16526019)(336012)(2616005)(5660300002)(356005)(81166007)(36860700001)(426003)(54906003)(70206006)(70586007)(6916009)(316002)(4326008)(8676002)(8936002)(7696005)(6666004)(26005)(41300700001)(478600001)(82740400003)(86362001)(36756003)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:08:59.1804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13bd19d-6427-40c8-07fa-08dbd9e0412d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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
Cc: yipeng.chai@amd.com, Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The UE registe list is larger than CE list.

Reported-by: yipeng.chai@amd.com
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 41bbabd9ad4d..046ae95b366a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3799,6 +3799,27 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 		}
 	}
 
+	/* handle extra register entries of UE */
+	for (; i < ARRAY_SIZE(gfx_v9_4_3_ue_reg_list); i++) {
+		for (j = 0; j < gfx_v9_4_3_ue_reg_list[i].se_num; j++) {
+			for (k = 0; k < gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst; k++) {
+				/* no need to select if instance number is 1 */
+				if (gfx_v9_4_3_ue_reg_list[i].se_num > 1 ||
+					gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst > 1)
+					gfx_v9_4_3_xcc_select_se_sh(adev, j, 0, k, xcc_id);
+
+				amdgpu_ras_inst_query_ras_error_count(adev,
+					&(gfx_v9_4_3_ue_reg_list[i].reg_entry),
+					1,
+					gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_type].mem_id_ent,
+					gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_type].size,
+					GET_INST(GC, xcc_id),
+					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+					&ue_count);
+			}
+		}
+	}
+
 	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
 			xcc_id);
 	mutex_unlock(&adev->grbm_idx_mutex);
@@ -3838,6 +3859,23 @@ static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
 		}
 	}
 
+	/* handle extra register entries of UE */
+	for (; i < ARRAY_SIZE(gfx_v9_4_3_ue_reg_list); i++) {
+		for (j = 0; j < gfx_v9_4_3_ue_reg_list[i].se_num; j++) {
+			for (k = 0; k < gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst; k++) {
+				/* no need to select if instance number is 1 */
+				if (gfx_v9_4_3_ue_reg_list[i].se_num > 1 ||
+					gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst > 1)
+					gfx_v9_4_3_xcc_select_se_sh(adev, j, 0, k, xcc_id);
+
+				amdgpu_ras_inst_reset_ras_error_count(adev,
+					&(gfx_v9_4_3_ue_reg_list[i].reg_entry),
+					1,
+					GET_INST(GC, xcc_id));
+			}
+		}
+	}
+
 	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
 			xcc_id);
 	mutex_unlock(&adev->grbm_idx_mutex);
-- 
2.35.1

