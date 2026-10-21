Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41131606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TTLt8L+5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F5310FD67;
	Wed, 21 Oct 2026 11:09:49 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9452A10F99D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weE7VKu83gBju+5jIm7n1ldPfoOuq1SUDLiWU18kn2lz1/OgLmTnD/hC6kiGpIn04Ixvs+p4/kS+mmNErWWdJiSwOmejp5ch3vvLcOEYID4C0wL2R9NNZvTOvNb3/JNaWqwGSp+ccwB5zuqfozn9kmriLbkiupjuTMdjd3Mr91R/4hzTa+dHjx2lat9KCBNc8BhMOjjX/wmEirVwE27LsHIRHMpE+86WJrsUK5/XRBzQnJne1kALTdrF0gW8YXmDYxx8XXberFMe1tCzD/n11PtOX8+pklTqLY6akJUsqoWrxs8qPwFC3p7Ck3vPw1Y0pWWJrDxGfNQsGtC/hHVFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6811juLEKr9Qbdt1qnrVTkE9iNoPn0WTpH5PSJlR5WI=;
 b=T0AnXs7l90A/YByqiGU5SGqTJNs0cz8RvrIA0L/1uKOSxKCxe9PhBvShfG656+uDlFm1h9ovHN6RkkQqfMuZKuISXgwUzMxjVnlDx/2cEAVW0dYSbRfjWnFHibc3NOiNotY7MeokccmNf8cIXYleTmeODZ+lYUz9HEc3EMTWg48+TsAprF7KwgRdMR8fNEmiAEvnBcgUsPmpiCmCrqocaP7a/mgIzw7docIQNHK1WKseTKczPuNtnZUt6TRubikY8sqIhSd5GvJnvM5UDxRILS2XjwFRTYIiBt/n7q1R74rR7/a36F0wjGOsbOa9XdP1mzKOwsuApXljTAewyXvOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6811juLEKr9Qbdt1qnrVTkE9iNoPn0WTpH5PSJlR5WI=;
 b=TTLt8L+5BWBdCDYbx9xEaDTyxJfyT2+LZt13U0aFFMEmDQ+b4RWOEvw2B3dPi4+ss0S4heT/A2vu49rVlJ65R0Fpb39r/RQEo9VoPOIlx6Xqnik7qhP7C3ZvsWAC3Z8XH8W6YcPOh+aYGKBxL375pdv/pT1aaVYRZ50dqN/pAXg=
Received: from BN9PR03CA0614.namprd03.prod.outlook.com (2603:10b6:408:106::19)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:09:39 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::78) by BN9PR03CA0614.outlook.office365.com
 (2603:10b6:408:106::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 11:09:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:39 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:36 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 08/12] drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
Date: Wed, 21 Oct 2026 19:09:59 +0800
Message-ID: <20261021111003.3371005-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 916e28e3-fb31-4011-0caf-08df2f63cca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: A/4mv8jK0Fxai07pHmTs1IE3AlfsEUJMpPkSq3wBdKBxf1a/+xXYj9TCHCJ0+nUIXdR18f9bp4E8GNFplHKAJV8YIdycLmsr6tiCur1SCxZv1aW45ATc1E6rD9Qv1m0tWZ8JMMsHwoAm7JVutF8U7gXl0QZXpz/nf44264+7B+zClp6ufvmj5aq16h6ApyZJFacpyJkwS0ZNe8CnFML9wVkUYniQjTRgZY7gEudYctwNiO58iI7Eiq9P5Q9pxqncf/MWIOVA3HYdfvNoqBWMSCvL4ZukVeFfLTAharkfLvnBg7bxvNNmxQpf5FKMwK1WGC3WAMWk4+mSpV8iHSMdTbrtWxZJJLgtP1U0T9iIj3zHIpIxyj3nCZPo+KpwAKSAaKVtmP4wtactfFmUpakAs5KOqVRCCWbupPYC+ItuWhqBDiAmyHURBP0dM+0MmK0nM6wIXsCidR28U193YM09LlZUyuAhlV+aiOvaXRTEujcmq68EbbH09D4rGPhpnLMu+l4wtWyOm/NM983h47QVyiTCh0gHKwQ/NrQvmR2DR1Ia8XSEpeG2ROyu6f9S2jnn0mhdNgDIfwP3D4MRTETAe5o0DwcxvFmG7vnosH83hCU80KDnigmWaamdYRqCoXQ5PNV66fyEeN+XaaCJksXL5OzRAjh4HPAF60hV4KykRJwlZKe41gjTIFudELUjHyHpZOik/cpxNaT0xCHDPtexKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /+LN2bRfcDNfsaj7dAxv49wgq5r6puKcCW7PVZJGz7rGfcZayuoRY/Z/wytENsLRk+0uYiI+DOj/Nfus1AdBxrR5umLqR0ExZzsYFwP3ojzC4ZBlB95ILx+srRy0MsuCjKQpMgaVlkSOSMTt0UXRHC75AMad2/hwT5sgwEN8QDxGuI+AuZWOzJn+plqoDn60/+bQGj/f1U9yP1Y2Qp+DvMpTF1hiOm6yH/BEXEqCSPA3sE9ENTXvtzqKty6PaBY/MdfyJycHNbeJRvq6h1qqBohftBHjXGn5JM0y7YbKUjmcUqMZyJP3DFY1FK1fbDP9EmE1aKcU4bQZPWo4rDrmiJfsFjIvXvf03LiL6FY7+KYuHKosLn8MyQp6MZpTBFE+B4yK9ZCWVNSlu1ncE6rNPeLQUL0UZTnoMuR7Mc0GxN3EOMRb6v0iMkESqSX8vJoq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:39.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916e28e3-fb31-4011-0caf-08df2f63cca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit implements a new callback set_mqd_perfcount
in struct amdgpu_mqd. This callback helps setting
mqd->compute_perfcount_enable from amdgpu_mqd_prop->perfcount_enable.

This is a per-IP callback and it is NULL if an IP does not
support PMC.

This commit also implements set_mqd_perfcount for GFX11.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 373c52b7022d..5ccaf805adb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -480,12 +480,18 @@ struct amdgpu_mqd_prop {
 	uint32_t ctx_save_area_size;
 	uint32_t ctl_stack_size;
 	bool modify;
+	/* PMC compute_perfcount_enable that programmed into this queue's MQD */
+	bool perfcount_enable;
 };
 
 struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	/* Per-IP callback to set compute_perfcount_enable,
+	 * NULL when this IP's MQD has no perfcount_enable field.
+	 */
+	void (*set_mqd_perfcount)(void *mqd, struct amdgpu_mqd_prop *p);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4b5faecf13b9..04e2d857e352 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4326,6 +4326,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -4466,6 +4467,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static void gfx_v11_0_compute_mqd_set_perfcount(void *m,
+						struct amdgpu_mqd_prop *prop)
+{
+	struct v11_compute_mqd *mqd = m;
+
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
+}
+
 static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7270,6 +7279,8 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+		gfx_v11_0_compute_mqd_set_perfcount;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.53.0

