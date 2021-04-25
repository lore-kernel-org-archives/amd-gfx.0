Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C91C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1285861404
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1285861404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7F86E4BB;
	Sun, 25 Apr 2021 07:10:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF1E6E4BB
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUl1Wv2AuP8oj2Yq+NymMu3siVggfESxDU6z3BZY7+IRYcIlesdqzVnOeQcFxArg1bqVFHoCanAZLDkr6JT0Yxk4Do8+B6vTuu1NjRDlaY8pI61Lcfs9YYaSxJ2/Lm8fI/MipvgHxOV32ESJrEYY5kYzLb5n1+Zgb7GMHiMiojeGDgFn0s6u0yyZi0cTZssIowWFJluz4zUQ1VHPevv/W8DIZ0UHbLgGiM2Q3xQbXPSnDuBRnz038deGUVj5CyvZ4uBuAc4Mq3XaH6Zzy40dS6si2+m5X4xRaLwE+V20Je7eP1n7R1dQkPO+HarGsxAOg7AXknQdrfRgFIJPjjWn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJCO1GUGBPYbv1hQwhHPRwJdrPmZjf2EebbITRSH/N8=;
 b=V74AMMoWCcP9ECKAko7vK0eB9fUCyxC4Xq+/004AORQMWaHYFu+AENgXTbs44rkQGEWNa/5YhGjxaQQt9KrJ/8If3bS7L1tfL/hhK6ulp4HY0c9qZueQdk8dwK9j/ZDqaJiZOp3naGaiW/aQvLeplR1jHb3ddevPy+RwV1sODq7S7eQcMfw9z9UPYu/RzJmeBMPouJVSuQIcSWIv6WaxAiSW5gT28CJt6zJDvBn9MN0+yUuNJlwy12UZ4LbRZj30T+9ld8eWsKlzmph4fCamTXDqF8qdkEpKInqRe+tsrEYytW2SYRwiJi62OG/k5/GAKtAFEZr3KHVTWtgaELfACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJCO1GUGBPYbv1hQwhHPRwJdrPmZjf2EebbITRSH/N8=;
 b=XlFT+voGjEgb6A5r765EKAseZuXQhg5XiHwrutILFe8JEDR2ex2IeGISQTPFCxaHODGehhetAiS1X34DPk99ZwuiGYvKlhbx9YeWWOrio1KdsezWkh06I1yv2yu2B69ebgQEOwW5mapuZ+2J+gpyJ7PP493ZNWYky3CYWa6x63o=
Received: from DS7PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:3bb::23)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 07:10:18 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::25) by DS7PR03CA0078.outlook.office365.com
 (2603:10b6:5:3bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Sun, 25 Apr 2021 07:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 07:10:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:10:16 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 02:10:15 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: implement smuio callback to query socket id
Date: Sun, 25 Apr 2021 15:10:13 +0800
Message-ID: <1619334613-13073-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c08b30a3-0d7c-432d-1bea-08d907b92e6d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4692:
X-Microsoft-Antispam-PRVS: <BL0PR12MB46922850710BED3F9B06BFD9FC439@BL0PR12MB4692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWng2HFCA9Oh76F6MdnbU0RCfZ+I/dbUNa5eYwYQ2CpZe6x322Vs5OThB59OrDydyxqJTzQFIhhRuBmgSok8OJJyNX+0HYqs1hm4zRL8splOhJ/dN4qYLnpZpZwj/QheCQdLZqjz72bmafmrNVhshBzFOE94wtBahlwtNu4JTKxkR23kMPUWWZXyl5fz/4CbAZVdjfcyE5c5dQUV7ArDqUKsgYPqQV+5GWSL8cEDqrVq3DPc0U2wQNWo5dwe9hzhR8nKSphdQvKCsk6h5wBuddAXTw6SpxVMdTnlq1iUgwHaXlJSr78CGS/HZ0ae3SliRQbo303hLTwE+zQiuntoNtk8jsnMa6ol5TjiYClX0BT0n76pKOFoAhBODpUuWo8WdFHmxqsZdAO+T7eHrBLjhhVnWwB3+255LNSItVjqXrtbhrQuzxJYmCeXnBiuNV1NLd93Uj4D///drANxLnb61bMZujXBlyPrd/TzGb4NDNHigq4Wq28S+P4d36rr2jId0fr/birM4DuYmC7d2O9LnTh3kARG925mp13rmy2PpDGu9zlZBEAN1owzLMkO/0VH1cVuR0mHG9YEHtQ2/VQloSScZ+JgJTihUMMExNjIBTUqDHtLtf1tjznib3zSTVdengp+aTV6IHd7FINZzJEJfDQ4u9bG2VsPeT7K2Yxdq4svnZKm/ev/MuVHbqZeDy5p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(6636002)(26005)(5660300002)(110136005)(81166007)(2906002)(316002)(86362001)(82740400003)(356005)(83380400001)(4326008)(7696005)(70586007)(36756003)(8936002)(2616005)(8676002)(70206006)(336012)(426003)(36860700001)(47076005)(186003)(478600001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 07:10:17.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b30a3-0d7c-432d-1bea-08d907b92e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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

get_socket_id is used to query socket id

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index b860ec9..484bb3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -29,6 +29,7 @@ struct amdgpu_smuio_funcs {
 	void (*update_rom_clock_gating)(struct amdgpu_device *adev, bool enable);
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
 	u32 (*get_die_id)(struct amdgpu_device *adev);
+	u32 (*get_socket_id)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 079b094..3c47c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -89,6 +89,23 @@ static u32 smuio_v13_0_get_die_id(struct amdgpu_device *adev)
 }
 
 /**
+ * smuio_v13_0_get_socket_id - query socket id from FCH
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns socket id
+ */
+static u32 smuio_v13_0_get_socket_id(struct amdgpu_device *adev)
+{
+	u32 data, socket_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	socket_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, SOCKET_ID);
+
+	return socket_id;
+}
+
+/**
  * smuio_v13_0_supports_host_gpu_xgmi - detect xgmi interface between cpu and gpu/s.
  *
  * @adev: amdgpu device pointer
@@ -115,6 +132,7 @@ const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
 	.get_rom_index_offset = smuio_v13_0_get_rom_index_offset,
 	.get_rom_data_offset = smuio_v13_0_get_rom_data_offset,
 	.get_die_id = smuio_v13_0_get_die_id,
+	.get_socket_id = smuio_v13_0_get_socket_id,
 	.is_host_gpu_xgmi_supported = smuio_v13_0_is_host_gpu_xgmi_supported,
 	.update_rom_clock_gating = smuio_v13_0_update_rom_clock_gating,
 	.get_clock_gating_state = smuio_v13_0_get_clock_gating_state,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
