Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D7C7EE25
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525F510E2D9;
	Fri, 12 May 2023 21:44:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94F710E6EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsD5bbRGc7l8iZoAuBw8+ewvGqrpM1srpQwm/mKJajzY/B5BXjJ+3Qyd2DCyjBAbiLCLo3oNrdODt5pcbUn4OeftQO3zCxIDSEtjFunlwaI7yiqbQTzFt8c6fc2lmd11kQXPOMitHSfo1AjaOPrqnIE0B8wxW9gDYi2FERtfVMb6sX/HbKNWfupbSM5wLoypfCONxFMqZTGFyPyufJN3qGy4+R4FZByulDnW8MQPQW0Ywk1oHfnLfpeI5jdn1DynDuBexdfEHBfEDbfO1ZwjSYi59x4vQpM3o/jeBlEGXIYLlthqbAj1yfR/LNdRFWTSCIagr4xZAg4w6+OANfI87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY+Fg9+IeTEJfleSel5zpORTTcqRLtmsy16z21rudfM=;
 b=iHFK/igJHrVo/ZYDplbbRQaUu7GJPx6NI41qf4Hbr7t73QLlKdCQQ6l0ftL6vzSJmIdae2AMiM/He4LU/QQUws31KG0lCrnn/+wYG52fln1khvGXFoxlYbDStfhUfWZG14DhRvrxYJpA41L5A1gDNpwYFEfmqhr1JprqKRuZ+lrm6gIznnr7ipeuduLSQuFUa9NbDlw5WDxm8+ko+Ihywe7oKN4wmwxLji31EZLbvoEGedVeZfaMhEHOl0gfkXduLnLyka/NhuLKWVjcKTiyn0Acn10RM18YwByBRzxDAS5kiHhvPM8b1s3kzAB8z67dUjyIW8kjRV+L7PjisUIv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY+Fg9+IeTEJfleSel5zpORTTcqRLtmsy16z21rudfM=;
 b=FbohOyj0q0PE65+/p1Qb3ljDiO7/Vk9tDix9kIAV6LEKlLn1+D06rRrQ8Y1w4fiK6vRAFyRYUu3aHTI0TJcLXSBbFLslARvo5/hYt5t3iUlZ51UJDK0abxiw+m92rnTOTqEY/4T1kkej3A5pnLdIWwx/NtIRcLmowXOPOSIOsgA=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 21:44:21 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5d) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amdgpu: add RAS error count reset for gfx_v9_4_3
Date: Fri, 12 May 2023 17:43:49 -0400
Message-ID: <20230512214351.1356254-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: e94c8160-103b-4773-41dd-08db53320b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwsWOjq8tFJEDxJB5iURk97+mQI+PrTAZFJWxkDdNylYgi1P5bM/QAbxJawhqwkDhMq1KkmdoK9Jd0BeftNJ46AmtHP/2XjRMom+X2HNK2SaIU1KrVlGMy5rS6bgeGXlUqFggDdA/N3pMIfkzsNwmkIYPsXNaZL43P2RhMqCmNO/PHhJUJoZXbP0B1Q3RCF1YbhVTj8ij7JqM5oANsuhkGR+KkauLNPyyW1Du6OxSoAcOB7qfOa5Y8jRa3azhL1Pps0Z8nFm2qwjmghEqEWTpyW4S/5388wUx26vOQuJ06MCLTdylE120pbVc6Kz3DwziYISb8WZXfZ4fcqDrNbiTAIIdVUEe5Ep5nW6Kcij34XccGbDom/mjrwPThk33H7ZB5m27Uv+oWCsW4DeGcZAX1j0GUP2utNuH8YRzjCyUSJa2w4FLC5+E02DxVh2t0F3x/1LAIYfuqy8BLQDrL/fhga1DOpfO8/k+oMATXPKI9lGamngYo4QaLcbW82lrnN5dc3e3+u2ys0seWP4J7L6f9QSxAAEyD8bBU2S9LNPjAyLyn9XubFvOIjvezblRM0MojRj9AoHauC2G1Cw4RpIR1Ni3MDJOtQbqstHvMtS/ojNtsl275elv5GDMVrSeYnjN0m8xhewpOrDBYNbzUPP4Ai3yyYHJ05k27+bJJwVuv08XFgjuE5H3GB7pifhmDEM1CoGch26HL7hCiPtYYfzODkohBwCPrlAajbu9tYwMj8YmHeaspP0klBZ4hMCu+tUnrqRa+aF4ufaaHF7EglWiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(186003)(16526019)(336012)(356005)(26005)(1076003)(41300700001)(81166007)(7696005)(6666004)(2616005)(83380400001)(426003)(36860700001)(47076005)(478600001)(54906003)(40460700003)(4326008)(6916009)(70206006)(70586007)(82310400005)(40480700001)(316002)(82740400003)(5660300002)(8676002)(8936002)(2906002)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:20.6871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94c8160-103b-4773-41dd-08db53320b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add GFX RAS error count reset function.

v2: remove xcp operation.
    only select_se_sh when instance number is more than 1.
v3: add check for se_num before select_se_sh.
    change instance from 0 to xcc_id for register access.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index bfd041ba51d6..ac5270d5eff4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3773,6 +3773,39 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 	err_data->ue_count += ue_count;
 }
 
+static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
+					void *ras_error_status, int xcc_id)
+{
+	uint32_t i, j, k;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_3_ce_reg_list); i++) {
+		for (j = 0; j < gfx_v9_4_3_ce_reg_list[i].se_num; j++) {
+			for (k = 0; k < gfx_v9_4_3_ce_reg_list[i].reg_entry.reg_inst; k++) {
+				/* no need to select if instance number is 1 */
+				if (gfx_v9_4_3_ce_reg_list[i].se_num > 1 ||
+				    gfx_v9_4_3_ce_reg_list[i].reg_entry.reg_inst > 1)
+					gfx_v9_4_3_xcc_select_se_sh(adev, j, 0, k, xcc_id);
+
+				amdgpu_ras_inst_reset_ras_error_count(adev,
+					&(gfx_v9_4_3_ce_reg_list[i].reg_entry),
+					1,
+					GET_INST(GC, xcc_id));
+
+				amdgpu_ras_inst_reset_ras_error_count(adev,
+					&(gfx_v9_4_3_ue_reg_list[i].reg_entry),
+					1,
+					GET_INST(GC, xcc_id));
+			}
+		}
+	}
+
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
 static void gfx_v9_4_3_inst_query_ea_err_status(struct amdgpu_device *adev,
 					int xcc_id)
 {
@@ -3882,6 +3915,11 @@ static void gfx_v9_4_3_query_ras_error_count(struct amdgpu_device *adev,
 			gfx_v9_4_3_inst_query_ras_err_count);
 }
 
+static void gfx_v9_4_3_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_reset_ras_err_count);
+}
+
 static void gfx_v9_4_3_query_ras_error_status(struct amdgpu_device *adev)
 {
 	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_query_ras_err_status);
-- 
2.40.1

