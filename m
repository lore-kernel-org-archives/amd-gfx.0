Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C2EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBE810EA43;
	Fri, 15 Dec 2023 16:50:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345B610EA43
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaZk7qTcLQGfhyCKk8RJEt+Jtd1ILkZTE3CUjzt5/jNiiTt6XSXoOyVOXcsiixRmeCmM5BM+esjK2edHELYwWrJY8w+GWAfUR4m9vivqNub/MZunYeT9qgn9roqejsUXIbuyurprBvQjeB+wuizSSd93bV1kzaWpGcMr0RQiXyRi2JNU7N/HcTFTRpzIOZv7GQz1xXwBnLH90G3gtIMAJgjhMXZ2XDI6xpsPw3c24xFjJj+OLIolu6rmoxPZJwk2cOLA87vct6uU3CE4t2WVMwdHFLK+jW+RZ6B8gw+iDwxD6bjQYdoPLsy59b2KZx3K/+UT1TN3n0D6IFci4L0BSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku6yLJqYR7/DZEURNCt6oHRqqPkUO4QpIRLbj9JOX9g=;
 b=ZQ0JpnXtQlibs11wI29dzbcxfvBMQm8c8AHPa7Z4IzsbJMwPICg8gnr50BFaeScPTwpRFLU7pAt/AXM0wVqk8d1hYhsXIzLCqgjbrL3OLzPMqbNlzl1D/gbU1R8hbWY1qmuS+vazHX3YC7UD+/YNaZKf9vTmhnmjHlblcw6dFOqNDW37jjJtJFy8OC3DOEqoJMLbb+f+jFfa+dekvlrOOgD7IKB9Axgg0NHTdhMcpNKp5qIRSYCfe3l8iXtpl4gMSQm63V4kHotmuxZkLpT1UTZ/KWo+Rv82/XC6qHAEOEZAg9TFv5Sf2+Wfg9RR/8f4UK5UHNtFvcKGYxbueFG0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku6yLJqYR7/DZEURNCt6oHRqqPkUO4QpIRLbj9JOX9g=;
 b=cjARWdPX0fAmtC04iOLZg3vhqjZ5Tf99RsgFCXExjXcoPt5jjwdkybblxG5LWvgqXgJKL0B8/D2VnfaSxy2C5w2tXvP9aqtq9qzO7eq+ZjOvnhmjcQ2eQbL5flDzUUswAnXh/LIKuOiswMr8N6GdBxSP9IjXNamFIZB0ZPkbncc=
Received: from MN2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:208:120::16)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:50:14 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::f3) by MN2PR10CA0003.outlook.office365.com
 (2603:10b6:208:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:50:13 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:50:12 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Date: Sat, 16 Dec 2023 00:49:52 +0800
Message-ID: <20231215164952.449464-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed3bdfa-5409-43c9-9473-08dbfd8de8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1M+hto9iCy4xPrvY1UXBon+yxbs3J6d34OlvlFk6zB9y0kDhAYszlbK3WGHs2r6qIkuLX6eFQ7xoX40Hl2y26JyJWPbW1jPZaklUtQcUJxcMG0JznVrjNzuh57cwuzJNbt/5OqDeBMz+RTMgGU8pk/A+yXf+MW5Dwt2j3nbje891A7sgDTtc7jNUlMNiv0/25XQAKSBw6f5JlP9cLRwb10Xllq/eE4qFM/sdVaYjvYJCo7jpLtvQ/+XDFkUYrDi9c+MYaEvP9JTuZjNtUXZAhrUozsBfsPYVHNFqwSnuQbmV6nCBa0bEopCW7pmrGqChnyohPGSlk6pyXz0gOYLLctYFBDVKXvtYTsYhY8/RDEpXTFOjmmOJJQpxpwpgmpGjip0nEzU66FDnkFT5oaaPDmUDD2mHHvKDlzC67UgDTeTxFjAQ6kbuPGVN5VfTkEEJKjSjORqN/m9NAFSO9yqPdoYiB0Ow5qGCjFZMwVOWo1IQimPqkeasus3TKHZJMNpqpngqsYl+VqVr9qNHwOcf9n+tNtsK7AKcOWBXmhM3wEzubtvW9KljVrvb5dG8qCbtl+6cIQy4ZeQGCFPyQdS3cQ2/uJpcF7drU9iAXMQPQvLx7ZZR19pDXsK571uTDypSSSnqr52ilyAVPC6lwaAPyDD++2EdY/9Gg2qKKNJS3oo+0O5w02aJWUZLhLYWOXVX9iItgoQhRSiUTQt4uyXgJ/qFqXKEtTsSeJ0tSRD7gYrlT5ehZxBNdsZNSXIRTko6DSF/6k9kfjFAdfaruCIXwIVAttCLyO2XUkElwk13VHVsKL1f6SSG8LHTNsnusiU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(1076003)(26005)(426003)(336012)(6666004)(16526019)(2616005)(40460700003)(356005)(86362001)(82740400003)(81166007)(36756003)(83380400001)(5660300002)(2906002)(6916009)(36860700001)(7696005)(47076005)(4326008)(70586007)(316002)(70206006)(8676002)(478600001)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:50:13.9764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed3bdfa-5409-43c9-9473-08dbfd8de8be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ecc_irq is disabled while GPU mode2 reset suspending process,
but not be enabled during GPU mode2 reset resume process.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c  |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 ++
 6 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 02f4c6f9d4f6..ba9238a93064 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -358,6 +358,12 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 		/* Resume RAS */
 		amdgpu_ras_resume(tmp_adev);
 
+		r = amdgpu_ras_late_resume(tmp_adev);
+		if (r) {
+			dev_err(tmp_adev->dev, "amdgpu_ras_late_resume failed %d\n", r);
+			goto end;
+		}
+
 		/* Update PSP FW topology after reset */
 		if (reset_context->hive &&
 		    tmp_adev->gmc.xgmi.num_physical_nodes > 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8a04fb6c7c1f..318e77c493f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3164,6 +3164,43 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+/* Handle mode 2 reset, resume ecc irq state */
+int amdgpu_ras_late_resume(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_block_list *node, *tmp;
+	struct amdgpu_ras_block_object *obj;
+	int r;
+
+	/* Guest side doesn't need init ras feature */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
+		if (!node->ras_obj) {
+			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
+			continue;
+		}
+
+		obj = node->ras_obj;
+
+		if (!(obj->ras_comm.block == AMDGPU_RAS_BLOCK__SDMA ||
+			  obj->ras_comm.block == AMDGPU_RAS_BLOCK__GFX))
+			continue;
+
+		if (obj->ras_late_init) {
+			r = obj->ras_late_init(adev, &obj->ras_comm);
+			if (r) {
+				dev_err(adev->dev, "%s failed to execute ras_late_init! ret:%d\n",
+					obj->ras_comm.name, r);
+				return r;
+			}
+		} else
+			amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
+	}
+
+	return 0;
+}
+
 /* do some fini work before IP fini as dependence */
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6a941eb8fb8f..5c1ffc5a6899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -693,6 +693,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
 int amdgpu_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_ras_late_resume(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 09cbca596bb5..b93a0baeb2d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 416f3e4f0438..e633e60850b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
 	}
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+	if (adev->gmc.ecc_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	gmc_v11_0_gart_disable(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 205db28a9803..8ac4d5b7fb37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
-- 
2.25.1

