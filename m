Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B8EC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D8210E456;
	Mon, 19 Sep 2022 02:04:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AC610E456
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHgN4ypSTOOX9533gVsJP5uJyH94fpi84UcHJkyUFRUuOz7sSn55IwhIvoDz+DQG/6Z2OWu1XBUgdUv/D+bTLILFge0Oe3utThFi6HcSt+QLItU54l6uPdMKELNpTIeeUsp5GwFYHexYAsUTPfcgr412s58+HZMvkHEUL6Bn2s7vmD0hHrqe1iJlCFYtEpQ6kz5tlmkItE1VCai5wiLU01j1gHZThhQ/vu4rIWOGyATTN3TtAr4o+rs+NVDZ+4kWr51LIfG6D72BmsXIB52CrH2hjUSS2DcLLnVPNCvebHys39eOol4bYHplO2mHgLXCKaBt86KKxlN0efCzgfxMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0qtyD4Zdgs251ybzFQCk6FdkBAgEevbAEdD0T8RxeE=;
 b=N4d4asXRJInkwL2t5LoreioY4JIGDVusYuw9CaV8b9G3oUGRcWd7d7e5XcZC1jH1XsJ9jZlK4momGMWxeJhUoQnen2y52aV5WCVZHUnnc7kzyVP9fvW4I42bPt4orYhZ21/wvNhuceeLgE9wkwc6jd5z/Y9rQi5rfQSlp/c009seaE8XgAq+I5HwyjJk7emKe/BezIPlndKejaXBgBg4ilEFDbytPJkr/Y7+dsFHgc6CeVnjwqiePiWrpz1ZMSvFBBqsaNPzsApK7X0vpgnAmhhtonj/Nqfe7+rgC1m0EAy5w8qqI+TS9socDg+7Qmbwfvyk6HleZQctk0OLpPWoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0qtyD4Zdgs251ybzFQCk6FdkBAgEevbAEdD0T8RxeE=;
 b=uzvCfSZqNL55O74DU3QfbVHFov9iAT4Nbep1mxI+fE4kjqJi4Zd32Ubcwiu2ZtNEr3vQX28qcwCjhrm6SXbi6Mhkqbw7f8M3DDNK0CUJAajDri8/QDfR7nYVrdVAGpX5YxdzgZJi8pzRCuOHk0huJrfsQhWhLaWdPHbmV04ZKaQ=
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 02:04:15 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::de) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 02:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:04:15 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 7/7] drm/amd/pm: revise SMU11 pptable setup
Date: Mon, 19 Sep 2022 10:02:51 +0800
Message-ID: <20220919020251.7048-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|DM6PR12MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: d16e9837-75a1-4295-9b0f-08da99e34108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub7IVML+k55GZHS8uGoKZ08Kkb+/ctzZhKuVEhx3zMlvOWlOzMWzWcDGpmjzjqfLIMoq3yuFty+xVDhsnxZtKBfy2M32SubPzEK62glJBU8RlAWTmDqdwdMqBsDoqTnDM3VW+AyaVOlXluu7OyWPatF8BXXCTvKGClaQV0Rw5n0KpxARl+pnF32B5iFPIupZxU8WV+ySAmCQxTpRUqYbrbmbgOeExDG9XqEaLsUn43GKMhZu8WByUzaONMckK9nfjTYbSDXkOdnnN5XXbIVJl4CjDYRoY2yoPBgXx70HlKmkshoDI1zD4BhDrtY9l9ayUOFxwO7iaKgKazUvClroGK7+qobUkfmtVDiojGMT1lg7ppMzVRU6b0lo64ZxXf/AQmfHYvug9RUMrsLjXk/1LE9Q/iZVhe2TQhFOEg1sf62rT7bKkCqP2OCegxkdDdr3s7E1aHrnKQXgguMxUML09YzOrhnYkt5Uo07gmim38oq0rwD4WxkE3XD7xJoGOJOLh4/tzyFveF7pBfFqiQD0PK/BR3ADhePTeXWMz7VJx+aTnMmKG8NJTZU6f9+LMM/PDEHgkZEQqH14cYFq9V6p3hRKLUG4wPPHnimzyenv+Q+cd/lTTT34zYZiSP6Yn689mqTrt6AuAFdUZct/469gjQ/SguWtmS3n783istdY46IcACID5lEHycD3adBGE5upbxLjsAk/pkD4KwY5PeAFjhWkQ8HPqXzNa8lmE+KNNSgEknIWyiKX9arSzu3U04IjXY+pL8a9GRLN3YvxTCtdH78ldrB6YfegodlPhanDaBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(5660300002)(336012)(16526019)(47076005)(6916009)(54906003)(81166007)(6666004)(86362001)(82740400003)(316002)(426003)(356005)(36860700001)(2906002)(83380400001)(8936002)(186003)(1076003)(44832011)(2616005)(4326008)(7696005)(40460700003)(26005)(70586007)(41300700001)(478600001)(8676002)(40480700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:04:15.2180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e9837-75a1-4295-9b0f-08da99e34108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code more readable and scalable.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie4e5dd7b409acf91cc41ea59c00dcfe58e291e80
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 73 ++++++++++++-------
 5 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index a9215494dcdd..256641c650ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -318,5 +318,6 @@ int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
 void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
 
+void smu_v11_0_pptable_source_init(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 445005571f76..d691b64577af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2499,6 +2499,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.smu_handle_passthrough_sbr = smu_v11_0_handle_passthrough_sbr,
 	.set_mp1_state = smu_cmn_set_mp1_state,
+	.pptable_source_init = smu_v11_0_pptable_source_init,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0bcd4fe0ef17..0d48258fc50f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3569,6 +3569,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_mp1_state = smu_cmn_set_mp1_state,
 	.get_default_config_table_settings = navi10_get_default_config_table_settings,
 	.set_config_table = navi10_set_config_table,
+	.pptable_source_init = smu_v11_0_pptable_source_init,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 74996a8fb671..f020e6b17597 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4414,6 +4414,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_unique_id = sienna_cichlid_get_unique_id,
 	.mode2_reset_is_support = sienna_cichlid_is_mode2_reset_supported,
 	.mode2_reset = sienna_cichlid_mode2_reset,
+	.pptable_source_init = smu_v11_0_pptable_source_init,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6008450370e8..b56ef76a35f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -338,6 +338,15 @@ static int smu_v11_0_set_pptable_v2_1(struct smu_context *smu, void **table,
 	return 0;
 }
 
+void smu_v11_0_pptable_source_init(struct smu_context *smu)
+{
+	smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+	if (smu->pptable_id && !amdgpu_sriov_vf(smu->adev))
+		smu->pptable_source = PPTABLE_SOURCE_INTERNAL_HARDCOPY;
+	else
+		smu->pptable_source = PPTABLE_SOURCE_VBIOS;
+}
+
 int smu_v11_0_setup_pptable(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -349,41 +358,49 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 	void *table;
 	uint16_t version_major, version_minor;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	switch (smu->pptable_source) {
+	case PPTABLE_SOURCE_INTERNAL_HARDCOPY:
+		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
+
 		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
-		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
-			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
-			switch (version_minor) {
-			case 0:
-				ret = smu_v11_0_set_pptable_v2_0(smu, &table, &size);
-				break;
-			case 1:
-				ret = smu_v11_0_set_pptable_v2_1(smu, &table, &size,
-								smu->smu_table.boot_values.pp_table_id);
-				break;
-			default:
-				ret = -EINVAL;
-				break;
-			}
-			if (ret)
-				return ret;
-			goto out;
+
+		if (version_major != 2)
+			return -EINVAL;
+
+		switch (version_minor) {
+		case 0:
+			ret = smu_v11_0_set_pptable_v2_0(smu, &table, &size);
+			break;
+		case 1:
+			ret = smu_v11_0_set_pptable_v2_1(smu, &table, &size,
+							smu->smu_table.boot_values.pp_table_id);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
 		}
-	}
+		if (ret)
+			return ret;
+		break;
 
-	dev_info(adev->dev, "use vbios provided pptable\n");
-	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-						powerplayinfo);
+	case PPTABLE_SOURCE_VBIOS:
+		dev_info(adev->dev, "use vbios provided pptable\n");
 
-	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
-						(uint8_t **)&table);
-	if (ret)
-		return ret;
-	size = atom_table_size;
+		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+							powerplayinfo);
+		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
+							(uint8_t **)&table);
+		if (ret)
+			return ret;
+		size = atom_table_size;
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
-out:
 	if (!smu->smu_table.power_play_table)
 		smu->smu_table.power_play_table = table;
 	if (!smu->smu_table.power_play_table_size)
-- 
2.34.1

