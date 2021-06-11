Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD2C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5619E61059
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5619E61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A866EE32;
	Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911A6EE32
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsSVGTJOOgIy8hE62Fo3TjXYcKEA/erYQXlr9KXYYh4DIVMFEx/x2DBd4JF7Fmnlc/Y1aWr8Hpib+JgLV9qIvhAjSG8SroXGspHnu7IAnSmnEX7LTfYdhHw0adB9A+Z8f3CvbuGCvtoPdfLGaPCzT4REDyB+dg+C8KPucWEgj/HUBksLzuifYXtShPRkD//z0aLwxlLkonxlXgWeKYKUP73q+cqRdATKKZCziwLs8o5qQ1kjroar7ZiBYo8pUsGLkJAgqXLCWmbCo2M2cOBeBl6MSXsxLf22AjPLQoXAD612UKjuHKlJuQASx9yJ8KBnQAdoTryfB7sliH18wxyECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qBSxNvDnNpveB1gG+C6hJzqP7bKjBrVYQVzp1YV7EU=;
 b=CcMm+VJ6OiMD5YsMoYMjVMxmDzzRZBFhGlVk84lrXP7qSA7ouoPL64aq3/8F55AGXVmG2YLglGv+tcVyn5ig3LLfh++FBkJiLtzYKSY5sfj4j5ycM2G+ByxkYaakt2wuJEim93UxtgVOiS56L4cvhQACDehWPIdzt26HIvQ1dz+krV0OIjkd+Oo+sz4dvrg1N59pz1Tjb5LUe+iN3KwebTack5N9fj9nCu1x9xJf4jKWl6KdG3D3f1ZVnUDpGP7nE0fcEW0996+kqu0phAmQ5przACV3FPI6/60nipd8ITe3yvuDDT8cqLbLZCq1CtIxe/s1PRUMce0xv/QSdrb+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qBSxNvDnNpveB1gG+C6hJzqP7bKjBrVYQVzp1YV7EU=;
 b=kNO1JVYprTKK6nuIeHjOJ7Rt7wfduDnMYk19JVUsYtikhsfJPxQ6z6J6qeua2u3m+wUlzrhuWXp/63pHYD32Zi857iDu2GNPGmWYJ8g00dffQI3KmntSjcsyf/sImMXdGYPDI1gdwfOwuGS2TlyQJ2f1HE3R8HEt+SKW4zCkdyE=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by BYAPR12MB2744.namprd12.prod.outlook.com (2603:10b6:a03:69::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Fri, 11 Jun
 2021 07:05:58 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::4e) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:57 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:56 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: cache psp runtime boot_cfg_bitmask in sw_int
Date: Fri, 11 Jun 2021 15:05:45 +0800
Message-ID: <1623395146-2162-7-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bb8c3e7-0f05-45b6-1837-08d92ca75d3f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2744:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2744CDB5E18CD2F8987904C4FC349@BYAPR12MB2744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC+Jq3imp4W+bHTR5VDCLjyVRXbwSSJXDclKVabryp3PTI6GOuYfSj+GFHRxvhG8pcw2dUT4+6NORRrtXBfe3OPTX7sj+iYsY+GjIlppzxEgN//JiQh0MBlhBQ6P80c+VC0WcgP3Yf6CsulY0+tx8Hih03exq+P5boPG52LFPbe2AABqMpYcDhb+nIFN3D2RBcYUjC83JPDs3S4tnRqgA7Zw8c72aVWnl1l29bVA3nqIGNv0Th61fOoPo99bslvsoXD6QASZ7yU5VOZSJUXOJFdeCBA4Izvh+zxiLZYCNbAMvHln8uXSa3hdbRY/W+Zv4zkItHOzYetzF0xcLQ1ozVi8RPuURvKP6GsYURqPzBqSUTk1oucv9cHIzw4xxAqGhR020R6ATANxyLn5OlwUsLydw3F0wMdWO7GRzl7Oj016iFDIYZedz2DB5Q919Q6JSA6ym1FRotymSlkFsHDA9PmvyuGzsj404W/LEezOfqMXMa1DAXdYuBxVcyltRg54Gz39It9bjFCvBtcVjrGDLVA8UpuYT/VCTBqNDXNg/20ecSe8MQMaamkSCli/fjTQru2UDx6CTaSAVX5IgTN+7ppAeVBBD5ywj8z0b8ieHDMVlfhDNB7Xdj7OwMU2p6Mpo17FZeG1uA+7dAcJ4vscbuh81Ym9uuSg/Cg2h54res9TpPUOdGC9az/iDiL/AiSh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(8936002)(82740400003)(7696005)(2616005)(356005)(6916009)(336012)(4326008)(8676002)(186003)(70586007)(86362001)(81166007)(426003)(2906002)(70206006)(5660300002)(36860700001)(82310400003)(6666004)(316002)(47076005)(26005)(36756003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:58.3613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb8c3e7-0f05-45b6-1837-08d92ca75d3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2744
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

PSP runtime boot_cfg_bitmask carries various psp bl
feature bit mask that can be used by driver. Cache
it in sw_init for further usage.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dc786c91ec9d..28f95c5cd373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -237,6 +237,7 @@ static int psp_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 	int ret;
+	struct psp_runtime_boot_cfg_entry boot_cfg_entry;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		ret = psp_init_microcode(psp);
@@ -246,6 +247,12 @@ static int psp_sw_init(void *handle)
 		}
 	}
 
+	memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry));
+	if (psp_get_runtime_db_entry(adev,
+				PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG,
+				&boot_cfg_entry))
+		psp->boot_cfg_bitmask = boot_cfg_entry.boot_cfg_bitmask;
+
 	ret = psp_memory_training_init(psp);
 	if (ret) {
 		DRM_ERROR("Failed to initialize memory training!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 4dad9b539f06..2bd85b505f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -378,6 +378,8 @@ struct psp_context
 	struct psp_securedisplay_context	securedisplay_context;
 	struct mutex			mutex;
 	struct psp_memory_training_context mem_train_ctx;
+
+	uint32_t			boot_cfg_bitmask;
 };
 
 struct amdgpu_psp_funcs {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
