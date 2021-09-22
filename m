Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 10:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D694360F4B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 10:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D694360F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DBE6EB68;
	Wed, 22 Sep 2021 10:33:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993CF6EB68
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 10:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOtohkldmetDjKG4zCbjDlb494NcSq0VMPWsEZj5A9mlCI16YF2QzmAmN6MpTTWzDV3t75NX8bYs87LSA2Ins2JakJ8sNCFbLPBfRfuUOJR+JdbrYt+Nd22IIgNnlOYg5dGLWTfL9kqpEqbBv/XOwcROmupqqiLGLdENOc49lvBEc4UdZsDXY0CkW+mG4yifcSN0fFSJupmRuf1LZftz2bSMOQA9UBZ3oTf8wKHwSXwhGEAoet5yHJFbLhzHO5sfhb4bIPtQg5yqMG8XLRRbHf7Zq3PEWQr3mESP+kEl+0l2ABQd7Z5CvwKcD7uA9BzjAAipUVXtHuL6IM1gD2s85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Gdx8wCNW8PvCy87w4eNhqWS48GPNl7VAzbMmCAY49KE=;
 b=npEKurhC5CN8Tc5fbc2PxxUKi2kSSmCl19Mlix2919+D+uq9+hk+N8t/fJNLP9DZIyHuYB+bptEn132nwY1Gk7KVgYoQXH/u0DURmqofKtA7U6mK9VsK/swtMOqCxuKj4hKMlOJupqQPYrr8RDHbwp8rwz70IwldQh+W0LROaSPKLRKFm/fYHL/Ye3ehHSwXo2gMJ0jFxZOLUrCSJ2dB/OGBmvLNqeUeAh5my4PTyfhTAF2LlAmG++IT2jF5idVe47vu/2SFazzeViJsRz6AKeFR8QiBCbx7BAvbhy0d5GMzQJyWz9HSVu1fWZKNDY/UR2Lv9p1QCTGKEe8GiWLZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdx8wCNW8PvCy87w4eNhqWS48GPNl7VAzbMmCAY49KE=;
 b=0QClvq381hmG/BUPKT+8HGmoE0RCJGH9iiLaYrT6o/dCo7jI2kIyglKLeuYCdxEfrAGMbHUT8XNiiqUSf7pbML/9b+d+sJ2rRmcecx1HA6toM6ZwUj803Xq/WDxfM/oS/87Ihvbmp5ZALxot877vBP2XEKDVHH93ynoeE1vievk=
Received: from BN6PR1101CA0024.namprd11.prod.outlook.com
 (2603:10b6:405:4a::34) by DM4PR12MB5357.namprd12.prod.outlook.com
 (2603:10b6:5:39b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 10:33:03 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::33) by BN6PR1101CA0024.outlook.office365.com
 (2603:10b6:405:4a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 10:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 10:33:03 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 05:33:00 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set poison supported flag for RAS (v2)
Date: Wed, 22 Sep 2021 18:32:47 +0800
Message-ID: <20210922103248.2401-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103248.2401-1-tao.zhou1@amd.com>
References: <20210922103248.2401-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667a4d6d-2f18-4ee4-7942-08d97db45bba
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5357863B57445DBFB0C32919B0A29@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ua58Lu2sDseVKNwwQ1cEN4YfSw8HV5HMIdcsCIhHeloST1MJolSGqz52uZY82/PAZ7oIcbmuGOfGJi0b1v8ps4GjXLWLSVAWvxharh8MxSBmthLJIFf351Yv952dL0bh5lk9JepypMlZtWmdLKiGFUx3tOPaNhKdq4guVaum2ucV49ERVLwBRTsKKCHQGSMjYhGQWOnp0au3KOjlATOeySC1hFGH+PnLE7Vj9vRk9UPOCHIgrtPc8lIG0qM1RsC8qsMOmvJc/Sy28guN+VLMuOZausyTf1uX5wG/oREC8ixLdSvTx9GRXBP2GxHADSRJYROMdlDGEg5xayWEhOFQoOj0ALWttwFRHZfRMSnatsbclcPNfNSGy73g4A/m9bXIM8ZtNNkrOCG3Vlqc8XrWATKBH90yo0KsaEWaqHogbwZEcg/WJEr+w2rX8xIA0P4kEPVTucN0W5zC6ijAJoJSU3BCJafDzcRvmaip9aJy6Ke51KEMsj2Yd3Vu62EqYVIcC6AokAvLs55330zpOyXyMI/4KoyGyBN8WISrZK2NvHcIZRggmXEqy0DaliZh8pD2eOZ3na9TOFCz+lXZTy6eUNcKghJ5ZVO+5D8YdVZoe5+FaYKv72GjgnDxb8qYMl7i6SfwXy80Lta5WFEfjF2ivyxg2Kj/eEkciL2mC7lTSKFK/dapKjJzfVtP0Q7owPBlaMb6Zq19+rwZFFPGG4ajmNUFC9hdoleLTdzYUi8V/c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(8676002)(336012)(6666004)(70206006)(356005)(110136005)(36860700001)(26005)(16526019)(36756003)(186003)(7696005)(47076005)(81166007)(6636002)(5660300002)(2906002)(426003)(86362001)(2616005)(83380400001)(70586007)(82310400003)(4326008)(1076003)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 10:33:03.5748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667a4d6d-2f18-4ee4-7942-08d97db45bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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

Add RAS poison supported flag and tell PSP RAS TA about the info.

v2: rename poison_mode to poison_supported, we can also disable poison
mode even we support it.
    print poison_supported value if ras feature enablement fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 32 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 ++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7d09b28889af..c5cf84829ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1442,9 +1442,9 @@ static int psp_ras_initialize(struct psp_context *psp)
 	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
 
-	if (psp->adev->gmc.xgmi.connected_to_cpu)
+	if (amdgpu_ras_is_poison_supported(adev))
 		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
-	else
+	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
 
 	ret = psp_ras_load(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 912ea1f9fd04..5b362e944541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -710,10 +710,10 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	if (!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
-			dev_err(adev->dev, "ras %s %s failed %d\n",
+			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
 				enable ? "enable":"disable",
 				get_ras_block_str(head),
-				ret);
+				amdgpu_ras_is_poison_supported(adev), ret);
 			goto out;
 		}
 	}
@@ -2251,6 +2251,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int r;
+	bool df_poison, umc_poison;
 
 	if (con)
 		return 0;
@@ -2321,6 +2322,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
+	/* Init poison supported flag, the default value is false */
+	if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->query_ras_poison_mode) {
+		df_poison =
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =
+			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+		/* Only poison is set in both DF and UMC, we can support it */
+		if (df_poison && umc_poison)
+			con->poison_supported = true;
+		else if (df_poison != umc_poison)
+			dev_warn(adev->dev, "Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
+					df_poison, umc_poison);
+	}
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
@@ -2364,6 +2382,16 @@ static int amdgpu_persistent_edc_harvesting(struct amdgpu_device *adev,
 	return 0;
 }
 
+bool amdgpu_ras_is_poison_supported(struct amdgpu_device *adev)
+{
+       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+       if (!con)
+               return false;
+
+       return con->poison_supported;
+}
+
 /* helper function to handle common stuff in ip late init phase */
 int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ec42e9873aaa..d6377e1ad20a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -352,6 +352,9 @@ struct amdgpu_ras {
 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
 
+	/* is poison mode supported */
+	bool poison_supported;
+
 	/* RAS count errors delayed work */
 	struct delayed_work ras_counte_delay_work;
 	atomic_t ras_ue_count;
@@ -649,4 +652,6 @@ int amdgpu_persistent_edc_harvesting_supported(struct amdgpu_device *adev);
 
 const char *get_ras_block_str(struct ras_common_if *ras_block);
 
+bool amdgpu_ras_is_poison_supported(struct amdgpu_device *adev);
+
 #endif
-- 
2.17.1

