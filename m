Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B268C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63DA710E44C;
	Mon, 19 Sep 2022 02:03:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F97310E430
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZE+X9c6ItLUPsw6zAs/134l4Urf2sR7Cs2B3Du1/MW28QuBl50+cFUrpaVp63Tw7OQX+adEPUjhVfmBkELfddEaZoxfH3M3FK+L4BpcBnjKVPcbtNFAK3jkIAXJR90uv0/i0BY1W0Ye2IyISzOoE2oKSe3rvQL6BOnZwbr2JX9QXtzqrlCp+4auUQkxhZ9vL9/ToD41U35hTZ+DFklJcbnrMQmCaUtyV0Av+I6/vv7RXM9hmq1vtEp1HAjFUU4uJHymQSphrUsvS/tLRlHShTnE4AAFXp94qGLl2+BdBUcOz7D4++QvVSbzLAjMyqWJo2FLOxT2Qb43TZEWrVzUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1Grv/jT9vr1sz6jiaudb5fYZCpUZ0Ygyom/ejcbZ8I=;
 b=NU+Avq9CwIhFRzPiAMOKQQjl4fvnwcz/rJI6ga2Ls8D1U01m2iYmtkb6+mERTJ+F7yL/HB6mAj9CBaHoex3uk/DJ56WNc3Y3li+w0NZ7jBG258w7C6i23lu+gyWw7Dd6jDaiDzsbRAOaCdBfFMorzhXzIoYALXl5mANn/W54E8+AI5cqopk5d/e0Uy7FyDQpmvSoechpXrRRjuC89XKSmX91a1DFYpClIRJwXw13KsxU+vmWmoNZaIp88P1fd9S+DtqqfyyGfFE5BHb01RBNB1STp10SIb/O9xQevHgLMrb3XRHFyKnamAI+t+y7ugljSntEvBtIotQMWKnsilsp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1Grv/jT9vr1sz6jiaudb5fYZCpUZ0Ygyom/ejcbZ8I=;
 b=gv95jg4bLDvZurke6uYf7ol9GvQARXzDab/9I8uNRiRPrFD+uTooMjkD/WjeMp4JSAdkffGQcFVQuDwNq/lqwcjCC0LPzbKNEIVGpoOtimDZWs79OEcJlwb/69EhEzGfgaSCsEeQ/hfsCfexhKExcDZrKQD9jW6WTihOkmVgHKM=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 02:03:27 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::a7) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19 via Frontend
 Transport; Mon, 19 Sep 2022 02:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:03:26 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:24 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/7] drm/amd/pm: drop the pptable related workarounds for
 SMU 13.0.0
Date: Mon, 19 Sep 2022 10:02:46 +0800
Message-ID: <20220919020251.7048-2-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: bf684a05-882a-4956-02dc-08da99e32443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZ3CqAKu+i3zmLxk21B/mCXokim8DRG2dfcyFztUE9YljLNYnrWzyNzCflnqUT7FO5eWLWtZfvVjGjN7j51qG87/pGhn2ZH5sOV2t/C8tiXpSpNlJTNZisVNhy5v9/baeIrRu+BM10YkrKB5hvmw2IsWXti173Kn/qeBBdphTYlwTsin9iD6NnS+PB6kdCUsY0IJJVbSXddCa85HqsH2EduNst7VMsgDJmshR0Y3ZgrbPFK/iG11u+I42xx84CSqMQ1byyG4DgzLBsC8f587ttzFxnn67Xoxhg6aRN0BJAVtVH1CmzDjcO/QtsesnfOJLqYIj1p4IKDwrgJfDYtvJ5Y6oESATEnWC/eEzvB0G27sBZsNUaN04a+Ue1EI67j86+BGT7AjHkz66nv0xrj182Si8xkLeKVb0VA0IHyOvOQ+AFSUtJFvV5jUO4IwfIv3ocqCWrDnpuw9Srsgm8LJqTPiiQm0O1rSHfrPH/cvcJ25IM/DeqHdXWCTjdH0bd2mOvxUvvO6D3BtMNFOu+eskqKAx5e7W7pKj06a+/VqBlI4cMng5kPQ10hbYSZErym5MIHSaT5f6ZDYJ61gWEGzRaYpcB9sAtT73svBjzWxjXfvP+1pZLA8CEqVa29NXSO9FeDM3nzs8diJy/ZP25XDTgkseOuO3e4TLtWuplWa/TbqiFaNkriQt1tyIQcAt4+ViLilr/FNpNfRSZHNpOSYxN7maCN1TNWaRrnl+jyZ/jjVMuqVQhVFVC5zfKkaiBKq2muXQe965nNVFC/4/vlyVeAJ8thp0P3KSqxsnl+cmyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(7696005)(26005)(2616005)(81166007)(356005)(44832011)(478600001)(2906002)(5660300002)(36860700001)(82310400005)(86362001)(36756003)(82740400003)(40460700003)(426003)(47076005)(1076003)(186003)(16526019)(336012)(6666004)(83380400001)(40480700001)(41300700001)(4326008)(6916009)(316002)(54906003)(8676002)(70586007)(70206006)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:03:26.8531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf684a05-882a-4956-02dc-08da99e32443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

The pptable in the vbios is fully ready. The related workarounds
in driver are not needed any more.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I2549cd1acd6eebde361ed8e27d5631bd57644e52
--
v1->v2:
  - drop unrelated and unnecessary changes(Alex, Guchun)
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 46 ++--------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 54 ++-----------------
 2 files changed, 6 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4fd685af8fa4..53d26bca524a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -210,7 +210,8 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	if (!adev->scpm_enabled)
 		return 0;
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7))
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7)) ||
+	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)))
 		return 0;
 
 	/* override pptable_id from driver parameter */
@@ -219,27 +220,6 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
-
-		/*
-		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
-		 *   - use vbios carried pptable when pptable_id is 3664, 3715 or 3795
-		 *   - use 36831 soft pptable when pptable_id is 3683
-		 */
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
-			switch (pptable_id) {
-			case 3664:
-			case 3715:
-			case 3795:
-				pptable_id = 0;
-				break;
-			case 3683:
-				pptable_id = 36831;
-				break;
-			default:
-				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
-				return -EINVAL;
-			}
-		}
 	}
 
 	/* "pptable_id == 0" means vbios carries the pptable. */
@@ -475,28 +455,8 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 
-		/*
-		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
-		 *   - use 3664, 3683 or 3715 on request
-		 *   - use 3664 when pptable_id is 0
-		 * TODO: drop these when the pptable carried in vbios is ready.
-		 */
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
-			switch (pptable_id) {
-			case 0:
-				pptable_id = 3664;
-				break;
-			case 3664:
-			case 3683:
-			case 3715:
-				break;
-			default:
-				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
-				return -EINVAL;
-			}
-		} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10)) {
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
 			pptable_id = 6666;
-		}
 	}
 
 	/* force using vbios pptable in sriov mode */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a6b7319fbfe6..1d454485e0d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -375,59 +375,11 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t pptable_id;
 	int ret = 0;
 
-	/*
-	 * With SCPM enabled, the pptable used will be signed. It cannot
-	 * be used directly by driver. To get the raw pptable, we need to
-	 * rely on the combo pptable(and its revelant SMU message).
-	 */
-	if (adev->scpm_enabled) {
-		ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
-							&smu_table->power_play_table,
-							&smu_table->power_play_table_size);
-	} else {
-		/* override pptable_id from driver parameter */
-		if (amdgpu_smu_pptable_id >= 0) {
-			pptable_id = amdgpu_smu_pptable_id;
-			dev_info(adev->dev, "override pptable id %d\n", pptable_id);
-		} else {
-			pptable_id = smu_table->boot_values.pp_table_id;
-		}
-
-		/*
-		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
-		 *   - use vbios carried pptable when pptable_id is 3664, 3715 or 3795
-		 *   - use soft pptable when pptable_id is 3683
-		 */
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
-			switch (pptable_id) {
-			case 3664:
-			case 3715:
-			case 3795:
-			case 3794:
-				pptable_id = 0;
-				break;
-			case 3683:
-				break;
-			default:
-				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
-				return -EINVAL;
-			}
-		}
-
-		/* force using vbios pptable in sriov mode */
-		if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
-			ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
-								&smu_table->power_play_table,
-								&smu_table->power_play_table_size);
-		else
-			ret = smu_v13_0_get_pptable_from_firmware(smu,
-								  &smu_table->power_play_table,
-								  &smu_table->power_play_table_size,
-								  pptable_id);
-	}
+	ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
+						&smu_table->power_play_table,
+						&smu_table->power_play_table_size);
 	if (ret)
 		return ret;
 
-- 
2.34.1

