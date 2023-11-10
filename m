Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73156C4167D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 06:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6442110E69B;
	Fri, 10 Nov 2023 06:33:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4976210E69B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 06:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWK6Hv5DNfukqwdc6nWnvvwAhI+CGdeNVR2YHV/3cyt82vDL/NaJHVi4xd7XSZeySrqNHpgSEDNl52Xvk0apk8APvgSmV7P9OtVberdoJ+whPv9cPZP/PLrs4NFoWsvpvAeynLOeRBsMRLFt6yNOgrdUoB0185Oc58vTH/vlWo25WIUZwW/bDWI18YEv65wwvXis5lX5liZQsBLO5vxQtheytDaN+ZV6uiIy9gBURAoT/XIfW6cAgByADQD3SDRrMAEvlFMGXefu6dvPs7VP3Zor+hBMNbMjx6qiZaqoBRnYO4j1Idssr5ojQ98NQ6rh5Ll9zLb0rlPAcFfBZHbIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsBt2a6pkN9ph6BKSxC2xjAueRDK+TzzkXRgQbCQoSg=;
 b=YpP3cgcW3yxcjoSfZj1iohAGNwOzuEtkWEO3P0CqDZgubjYzwrhKfJp9KZkjKpkMADpdNfgcH8vpgLyNhoM4fcsKMrR1OvrWBnYlsjVHb40fYBXJLWSsvD1Kiy5WSBIpLqrtptWipk0BwDvnzzUqVK/9kJc3LeJ6FYnjb2c/9pDYHyztdD5lIe/wYoM8PACyF6Ny7iyPMwSWwLa++YHMcwP5peClOGy53EZBv+iskYukLPQwhSaHpkIVkLKsbnxHYV5BZ5w2wGhMPaPS0HI9WjJ24TQq/9tvU3JzQmTbO1FhnR/V6ZKuag/XISZJTvNVvxQQcaV4g48kZl4XDUh5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsBt2a6pkN9ph6BKSxC2xjAueRDK+TzzkXRgQbCQoSg=;
 b=oCxrFY6QijuvT6kWkYOeRURuiHWCaE25lTM/eKw1G6v1vO4t248JhgdubabpWsWWSIrlifgdH6PaHRW7HhDzXkE4wPXvozsLEgeGAkrjh9HkOW3VC+RMezpJw4eHTY6B5zNu1NipVKqA2jzCbw5pXZUsOCuZwdn+UplWHAnpo4Q=
Received: from BY5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:180::48)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 06:33:17 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:a03:180:cafe::2d) by BY5PR13CA0035.outlook.office365.com
 (2603:10b6:a03:180::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10 via Frontend
 Transport; Fri, 10 Nov 2023 06:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 06:33:16 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 00:33:12 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct mca ipid die/socket/addr decode
Date: Fri, 10 Nov 2023 14:32:39 +0800
Message-ID: <20231110063239.3889891-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfc1bc6-c7ed-41c3-bb43-08dbe1b6ebf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT+kaQ2Wqz4bj5345ULujLabCfetVY+BJv3gAnx+Oqshu7cs9K+SyxShqrtcJpY0LtYt5ylPEvf0mN6DVWHwk7ZO6twB+RwfS6sItBJVCK/jvYzh34UCeEl80ZV/d8iZNho/Gi59OVphaOzc1dbCCfW5cpAhPbai8Plv33X/vnDnkHyIkxnYiMW0Xd2kEyw9tohjK4th4XlwR4sVZ6ySqbt5b7gRYr+ZgWUaxyB5tmw93k95MdtFveW9RguyarrKrzyJCviziYRBNyKCnLtiZjLS/Y62KrM5TMdjKnJxtvC62ImNbNS621/6XYedDQePhWYrxGPyVCRSvnNOWBP9qxdtBWDdj2AUgENvj4/9JXxpP6MxbpeaNFk53d5v++CPZmCfdTtu30j92QejJiDiaW0l8f33AvtKFeUH75oVGspbGPrg3zUCOK+kePojSWANoT4NmmUVWleq3GZKlcDznM6FPMmGwinXDNMsm8cDsi16rsLk8aOPHKCK1cpPVbrwhWlDjvjt9A/takAg2u8N86ddJlgnKGS2GjI1eUhl6c25eL6YWMFOxVW3KJx7FRkIrTpU931k1IQzr+pj8r2k+bHZ5HPkbZ2tsbez3RojrbbYprYGgKgrL6TkVk7OLK0f634LebA0yvZsPfV64OdD77Jn9wB5cGMrbdQ9IeHWZ74GJvlVQaF8VMpsNUwzEjBgCsDEhJdts6gIJsjOvpV58UuVdpKVK+ZR64xG5Kya1o07fYAtGCyECzV1m/x4bkEo5Y9lZtiMapcPrzFAboHUCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(83380400001)(36860700001)(8936002)(36756003)(8676002)(4326008)(41300700001)(6666004)(47076005)(2906002)(86362001)(7696005)(81166007)(70206006)(478600001)(82740400003)(426003)(356005)(316002)(5660300002)(26005)(70586007)(336012)(6916009)(16526019)(1076003)(54906003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 06:33:16.1454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfc1bc6-c7ed-41c3-bb43-08dbe1b6ebf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

correct mca ipid die/socket/addr decode

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 789552c66d1d..3f71490b779c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2381,8 +2381,8 @@ static const struct mca_bank_ipid smu_v13_0_6_mca_ipid_table[AMDGPU_MCA_IP_COUNT
 
 static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, struct mca_bank_info *info)
 {
-	uint64_t ipid = entry->regs[MCA_REG_IDX_IPID];
-	uint32_t insthi;
+	u64 ipid = entry->regs[MCA_REG_IDX_IPID];
+	u32 instidhi, instid;
 
 	/* NOTE: All MCA IPID register share the same format,
 	 * so the driver can share the MCMP1 register header file.
@@ -2391,9 +2391,14 @@ static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, struct mca_
 	info->hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	info->mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
 
-	insthi = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
-	info->aid = ((insthi >> 2) & 0x03);
-	info->socket_id = insthi & 0x03;
+	/* Unfied DieID Format: SAASS. A:AID, S:Socket.
+	 * Unfied DieID[4] = InstanceId[0]
+	 * Unfied DieID[0:3] = InstanceIdHi[0:3]
+	 * */
+	instidhi = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
+	instid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo);
+	info->aid = ((instidhi >> 2) & 0x03);
+	info->socket_id = ((instid & 0x1) << 4) | (instidhi & 0x03);
 }
 
 static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
@@ -2567,6 +2572,7 @@ static bool mca_gfx_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct
 	uint32_t instlo;
 
 	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
+	instlo &= GENMASK(31, 1);
 	switch (instlo) {
 	case 0x36430400: /* SMNAID XCD 0 */
 	case 0x38430400: /* SMNAID XCD 1 */
@@ -2585,6 +2591,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amd
 	uint32_t errcode, instlo;
 
 	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
+	instlo &= GENMASK(31, 1);
 	if (instlo != 0x03b30400)
 		return false;
 
-- 
2.34.1

