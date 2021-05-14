Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F344C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D1A61406
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D1A61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4FBD6EE34;
	Fri, 14 May 2021 07:42:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66B96EE34
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRF0YH0BBfPOWBSrhyMScuO4+TeR4FM8blQIJNmM255yOogCy43aebnB3F+34IKI4VNaOKdhtTkcxhKH9YPcRQiQ2RaX1/F5AI0xvLfCa7Ozf/RdgXfKvpDBvVnzotu0FJ8m3/ScA1l3jErwZwBr3cM9KBLPhdZ4l0/3oDwYFXZ0dJCr09HusM2K7wXXsL+WysRr4we/CUJbHRUyWn4PGRX7/kYqlq2NxTTD6qaMoN75xZ9c0xn2Sy3oBBFJ6me8nkAuLhjfQRc7dilh8g7OLlhnOsT5vAWhW4LGsgb09RRSEwgJgzdGjMYhn6Rw6Uhu2Xea+Odov7PW9DiJxQlM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4tBgXfXDHw3asP/+WDSvJRaQHeECMkv8j251Nso1Qw=;
 b=jLcWNtG6gKGlhbUA6jX1AFhj7dMnDf6bQcGkwXNC/Sm3jm5/FGgr1vsruwFzSRFQJgzlGnTZuUqx9wJMilJBgyh0fmj2d6K3mZ+/6qn6c8Zm+SlcZDS/1vO4Y8Rlr3HUd99ZbeKGu+DQ69PDP4SFl9iWUJpM926nz/+gTBkPNLM4skkrHZ0DI5pZ9AHB4dez7K4mHqWiLgb62tEeA2Fi+Jnc6R6aO3u7bVB971rBnfZo6mnzLK1GLCUmiYclw84Oqx/q87hYUMk7u9QSbTIrbLufdtfXCT8lsJornvK7oONqqkSUP9oIPS1B+DM4dMl5WgaSyZ6i82Ht5y0KdmlJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4tBgXfXDHw3asP/+WDSvJRaQHeECMkv8j251Nso1Qw=;
 b=1XF3MszeMAE7bYAmSWrscm+oZmmAenv64H1L5AcIMouPPJSRcsUQmcvfO6SVzkz5aFzutgJJiib1LV7b0rQxyf4nTDBmMO6Yr7E4jsEOzUm7Kko4kUiuGFBrfXlGasqHb2Q0GVXaHsp5V6i4Z7aRVvMJa93KsYPHZyy3wnxZ70E=
Received: from CO2PR04CA0069.namprd04.prod.outlook.com (2603:10b6:102:1::37)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:42:42 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::2c) by CO2PR04CA0069.outlook.office365.com
 (2603:10b6:102:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:42:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:40 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 02:42:39 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: switch to cached fw flags for sram ecc cap
Date: Fri, 14 May 2021 15:42:30 +0800
Message-ID: <1620978153-4564-3-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
References: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae278239-536c-4148-f46f-08d916abdb07
X-MS-TrafficTypeDiagnostic: CH2PR12MB4069:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40695BC42D9B457B1C7B6158FC509@CH2PR12MB4069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kG1XVGtOobaxppmJchsW1aRw8N6AfuQUSTuujTP/Npx5AG10zZ/vPK4yjbXVspBr5Wisvm+7sE71enfQZwAlTBM+CbN6h3VjHR6+GotIFOYlhFyVOJhZR6n9jLDh9XbRXrWsgNl1HXMwyMnpcN1GOlg10sHzPm7wGz6Tk8592t5/r4FroWy7WsYuMnxr7APHeEh0rM0ovcVagJFEOw3Kotm8n9xDaJGH+NS/fni8SdwYAIyWc6P3Gf2Fl1UqzPbe9ujCTgLZSbQWjyO0A4qsWttZQWpdnTjl6C/kVSzsy7fJ0zV6ABnXjqoDx4Xpzc5Xee65KIdb2OxrF9Zq+OU11kSJWzsG62pEb+DWTYHwJ1n4F8E2OoKTHr8CgjmBVZKDuIFlC6FvFLqi0Lh7kvr657Qr898Ybpdwg9dna8+cYZDRiAMMaUUx/cMCo+O+0wq4+Hmcv4jIjGdP43KMthMZzggFUMN5aOigFCD6+0IZvJuon1DufT+HVveMOtOBXr6tJ7Muk2s820R86nHICDU1aiSV2SxpZBvuErV9y2BosuQHdiJ6ChW9D5GKcapPvhw4dyj6jLXmgoT7hJ3KkJ2/ID7CGvZXv83k14Hh40UW0HRwaj0mCP7nxoTmCk/LsTeYewCxrTaQ1R+9ovdeOGb6wKkih1ye85ok1Q7BOwaCrlMtR+N63X6NuOlinFUrD0oV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(47076005)(82740400003)(82310400003)(8936002)(86362001)(70586007)(26005)(7696005)(81166007)(36860700001)(83380400001)(8676002)(6666004)(36756003)(6636002)(5660300002)(110136005)(478600001)(316002)(2906002)(70206006)(356005)(336012)(4326008)(2616005)(186003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:42:41.8007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae278239-536c-4148-f46f-08d916abdb07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check cached firmware_flags to determine whether
sram ecc is supported or not.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 28 ++++++------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 2cb8546..9f25db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -437,33 +437,19 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 }
 
 /*
+ * Helper function to query sram ecc capablity
+ *
+ * @adev: amdgpu_device pointer
+ *
  * Return true if vbios supports sram ecc or false if not
  */
 bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev)
 {
-	struct amdgpu_mode_info *mode_info = &adev->mode_info;
-	int index;
-	u16 data_offset, size;
-	union firmware_info *firmware_info;
-	u8 frev, crev;
-	bool sram_ecc_supported = false;
-
-	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-			firmwareinfo);
+	u32 fw_cap;
 
-	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context,
-				index, &size, &frev, &crev, &data_offset)) {
-		/* support firmware_info 3.1 + */
-		if ((frev == 3 && crev >=1) || (frev > 3)) {
-			firmware_info = (union firmware_info *)
-				(mode_info->atom_context->bios + data_offset);
-			sram_ecc_supported =
-				(le32_to_cpu(firmware_info->v31.firmware_capability) &
-				 ATOM_FIRMWARE_CAP_SRAM_ECC) ? true : false;
-		}
-	}
+	fw_cap = adev->mode_info.firmware_flags;
 
-	return sram_ecc_supported;
+	return (fw_cap & ATOM_FIRMWARE_CAP_SRAM_ECC) ? true : false;
 }
 
 union smu_info {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
