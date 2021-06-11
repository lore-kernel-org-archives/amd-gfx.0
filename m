Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E2C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752FA61059
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752FA61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233EB6EE35;
	Fri, 11 Jun 2021 07:06:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D5A6EE34
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNMqsMMlWAdEDIigNbyw74QkH0IfpDJtTL0q8nnBnsMEknqgmq5irAzBgLqjwERsS+MzfN2b5VbNdFp6f37bKaUCHxLeiYhaeRqcfFK71VytM854wrhlEEzwwYfFUcy7B0TRYhlIlwvYc2IzK76NHwHOPP2HfQjL/J/uRUk3Tp3wzQnJfDCIyRBVFcCoxFXzRb4KXr5103Pfjh6okl7yvSQwgTUwiaXiNgoGrCMHeQzTdfTCKoEy/pLNqHkxV8MuwdHffkw/3/gKybfwLWGtIbwVM/VJzNuqfRBiLwZT48EMbRknsXNEsUIhfn4Elj0iH0sQz01imIchfdZAnvSw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iozEOaY7rY525poOTEjjCOW5i+0V3TV837lUz+PgMI=;
 b=RS7gWN0yaOyAfnmTBY3n9bXbTcr/FF5nCkw/QdmE0wm4lw5Mi9W0ROqiVEtjC95LMobwVyw8XWWRCXVqrp7qCcAILzS+J5btAzQExd7Dwh5x+YAyC5ZqOxPOhwHFB7noui4+9gxHH8X7wp2ixlpCZJJSkNFBu08cDFyUmfjYoEqjuB+lbJtYg9BHW/7r3OvzIMjHFHgAexf8MH81JcxAAaJFrRnWO7D8QORakM6CqbnDNt5wnrM/pTWM2+1hQDADrAl3uDRF0350aJ6ebVfI9ZlQ/CYiVbljgvrA+5e6rtlVvXteQW0oh9U+UtyvpHcBaCDkRj489jB+FjHcV8HgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iozEOaY7rY525poOTEjjCOW5i+0V3TV837lUz+PgMI=;
 b=TQGdE9vM6set8t0yltlkOP2jFKDSpaLkzdR1KMrqVAsmsPyleW8vS+OI/AGsFo6sfsS8hW8nkLd2if+Yw4gXwlKNFeNJaf4WaAnqxi8SZqTcBPuyUvB96OjobH0la+KZDYb9Jb44+/CseEXjoQUiE9rNAUI9JGMURIiMVfDqjt4=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by BN8PR12MB3025.namprd12.prod.outlook.com (2603:10b6:408:66::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Fri, 11 Jun
 2021 07:05:56 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::8f) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:56 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:55 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: add helper function to query psp runtime db
 entry (v2)
Date: Fri, 11 Jun 2021 15:05:44 +0800
Message-ID: <1623395146-2162-6-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1193b7-50ff-45a7-a8ad-08d92ca75c2c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3025:
X-Microsoft-Antispam-PRVS: <BN8PR12MB302512CDE00167223AC897B4FC349@BN8PR12MB3025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XmVjOECqtEAb4nPLOo4nJpYnRhks7pkcqlQ70gyc0c4MR+EQeVTgtGyTkXqFtI6jWAVILws7Ckj6Iyq7KO4ZCqBWUECWy2Iyf3Fj7PbZSz0mAFz2fmfqTrtLo7KNnTOu+/hXQbqNzH4hnX1IH67kZDMsChivabeF+tTAsTl6iGTjGMV1ySGsfF0t5yq488Wj4CuZqU1ld7J9APJVzShfAPHJqXRYExiAF4yTzbSq3D0bc64rvI415/JhBWgXG7QS9bsCgCVQivVf2Y/kUJCgEmP+zAdYtcfvFXyRScQc9IoMpmMY3ahxPKp1IK5rV8FYY/eQCxZOKmTYQXm3gDLOkCH+A+HljukMQYustAT/aTeKXHpdYam3UHsiCokKGinIkpZWFgW3KXOXwUmQswCe3nE3C1R2fpK4DtFRH7kQt7IwxOlYAgaW9RH00+6WvcWj0wb4ludv0TKYLcWYZ1VYvYBWNU7r/HKwi3VDjlg32EDbV+plO272HToupYUDTUyyfz/qCuRKWZZE8vBIppj909hTk4BVHiLcP7SMmBMZh2fjHbh5MKEftmxNDHWYQq1j0+fk8Hknpw+TE0b3JnXqqWvCkpMGE8Gfsf9pi+0qaQd94CUdqIkWGo3JN/cYENu3KJNdPJfvtzRv1k/Xz0UjEbo9VD8tkEvtBle2JeCm5Ovr0G2mPNMHVp7E9yZ0Nv2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(8676002)(8936002)(7696005)(6666004)(356005)(2616005)(478600001)(26005)(316002)(6916009)(4326008)(426003)(336012)(81166007)(86362001)(186003)(36860700001)(47076005)(70206006)(5660300002)(83380400001)(82740400003)(82310400003)(36756003)(2906002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:56.6797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1193b7-50ff-45a7-a8ad-08d92ca75c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3025
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

PSP will dump various boot up information into a
portion of local frame buffer, called runtime database.
The helper function is used for driver to query those
shared information.

v2: init ret and check !ret to exit loop as soon as
found the entry

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ab4e89186186..dc786c91ec9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -164,6 +164,74 @@ static int psp_memory_training_init(struct psp_context *psp)
 	return ret;
 }
 
+/*
+ * Helper funciton to query psp runtime database entry
+ *
+ * @adev: amdgpu_device pointer
+ * @entry_type: the type of psp runtime database entry
+ * @db_entry: runtime database entry pointer
+ *
+ * Return false if runtime database doesn't exit or entry is invalid
+ * or true if the specific database entry is found, and copy to @db_entry
+ */
+static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
+				     enum psp_runtime_entry_type entry_type,
+				     void *db_entry)
+{
+	uint64_t db_header_pos, db_dir_pos;
+	struct psp_runtime_data_header db_header = {0};
+	struct psp_runtime_data_directory db_dir = {0};
+	bool ret = false;
+	int i;
+
+	db_header_pos = adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
+	db_dir_pos = db_header_pos + sizeof(struct psp_runtime_data_header);
+
+	/* read runtime db header from vram */
+	amdgpu_device_vram_access(adev, db_header_pos, (uint32_t *)&db_header,
+			sizeof(struct psp_runtime_data_header), false);
+
+	if (db_header.cookie != PSP_RUNTIME_DB_COOKIE_ID) {
+		/* runtime db doesn't exist, exit */
+		dev_warn(adev->dev, "PSP runtime database doesn't exist\n");
+		return false;
+	}
+
+	/* read runtime database entry from vram */
+	amdgpu_device_vram_access(adev, db_dir_pos, (uint32_t *)&db_dir,
+			sizeof(struct psp_runtime_data_directory), false);
+
+	if (db_dir.entry_count >= PSP_RUNTIME_DB_DIAG_ENTRY_MAX_COUNT) {
+		/* invalid db entry count, exit */
+		dev_warn(adev->dev, "Invalid PSP runtime database entry count\n");
+		return false;
+	}
+
+	/* look up for requested entry type */
+	for (i = 0; i < db_dir.entry_count && !ret; i++) {
+		if (db_dir.entry_list[i].entry_type == entry_type) {
+			switch (entry_type) {
+			case PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG:
+				if (db_dir.entry_list[i].size < sizeof(struct psp_runtime_boot_cfg_entry)) {
+					/* invalid db entry size */
+					dev_warn(adev->dev, "Invalid PSP runtime database entry size\n");
+					return false;
+				}
+				/* read runtime database entry */
+				amdgpu_device_vram_access(adev, db_header_pos + db_dir.entry_list[i].offset,
+							  (uint32_t *)db_entry, sizeof(struct psp_runtime_boot_cfg_entry), false);
+				ret = true;
+				break;
+			default:
+				ret = false;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
