Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992CEC7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC73910E5C0;
	Thu, 24 Aug 2023 21:32:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBCD10E153
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9G4mwrnKWf2sKP7NZ/G6D+TCDt4KGnOgkkwMksaS9tWlXyeNGZKzX7/pK774P7TvkwSjR2Dubb61zbh3QdGuiI/3jwXD49KD9L/oEdC8qrNHGGEX+CXhxP6fBV13adIy2SR7qMIBFNEgYawrFWc5DNaFpJmyov15/nuiY3v5TrrP4N2eXKCGmQ8G38075GuOi6aB3Zd5C9cCEsVJFqFppW6V6xaAZ411CddmejpNn0aWsMtnfHW8MemOBp0vKhkB+lUC6iko7lUGuDZqDLF7ko3CFLYqJiAZFIBSTjm61kIQOgML1FmHpzdCg7AsxoRL7/yuYrTf+fEPGOu6eyx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aOKH36GEm2KtXDyN86xPMW0nYc480H0Es9vHGMTdSs=;
 b=nAybE8pPVCGfo3KLuTGFMT+2V+T/GtySrx/CN2Gzc1LvqXcq544UjTla+mT6jP5E8bFdhpq/rQY/CnGnn5ZNkYcUy2DhpO/zM002cmCC3BxLgAbhxAiVyyhYLH84JHr9gNBKCpS+/UFgnc1L8gORCG1uHgCfs0wlPwVj+Mkn//Df9W4Wxh+4s8AuukiMJimuyCWxT4QZfzJbuDqAvqm/Q46EnW5rydJFKONWy9w0YWykLFN/o6NHUftkMwAUwM3OlLtwTN43+UqJhAa+U5uua0ASa3F4t1q5H1fv6a8ScePD5+/+snsCIe5ggmo4kGZMaHlHii+/2m6lEPmg2KHPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aOKH36GEm2KtXDyN86xPMW0nYc480H0Es9vHGMTdSs=;
 b=I1K+fo8mxW6hkggICbE9jQFaBMx77V1Yj0GKDMOZ+1GAezd+F4PArIV11PUjl0OyjwgVLP3UoFdMy/4E+u0ytCbavjvM/cjCmBxB28RQYQF/BEpWztXSBTszenv9D2tOsCTTObzKo5jQnLZGErNrQxJHI5wEGc0/emWd8ofKchU=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.32; Thu, 24 Aug
 2023 21:31:49 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::67) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amdgpu: add HWID for VPE
Date: Thu, 24 Aug 2023 17:31:14 -0400
Message-ID: <20230824213127.2725850-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: e79b5d07-74d1-4ee4-613e-08dba4e98631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02bqEw4nWbwb1k9DDO6QDFmPslY6HB9E57S6Po/WygB1V1Pi1ZPa7ZBMU3th5VDtKCnTTX66XwHaRAcmLPupWTuYbyQqWo4k8wWyNK9pmJkrpS1ueoikSL2eK7UXoe7FfW0Zz6b2nD5tSSJonGM8NKAaSWu614O/80d+4PWGjdwdYGy/0yPtZnvXmKaNX/zMGJy8nv44iB7pTZW3bb8O+jZ5ewwPZIW5bAry1E3WXhSQ5SpydVyD6WRi24jzxD9v4mMfnaPL105/UNZ2UbSU22ssTxNIVvIct8zWaWfgmYERpSGS/wQsz6BkrWhF/r4poWfkzzpnxAW6MtjQjZi2mX9O7conjLHfddjWOp/HV6WUOMhb0STTR5vNYOquabpLZrHYOyISgl07FlKjmKFlNTlMDlIT0rh7nMMgbWJMJX1VPGNIDXHMOJru3qCRGrLlex9dLOVWSPRYBkeZzr2vMT5OOVVZcds9oHJjJQ8aruLDl6pn4HzJ+lmxgSFLiFJ6UFIKXa2FBZ5g9shkAv23VNoZIYw/O+xzOA+uGU1u2Cgo7cOZR9t+hFNWI1fcUhgtLt/JEMCMzO/J0D3s9tvJB7QvDduAIydH46XGgMZCx13sGD/LcR3RcLetilL1KcIhbJAI1WYDgD3qlJOqwz52Yc0g77acidXt0ieLgKUvDnbpdGw1KmaN61qgBipRI1JmnpJi9A9pFf/SaumDkOP1JUOsyU5V53YICH7HXC8PWI9HVgOyFDUrf3r21v7/aAwBFNMsU6nf31Wyc7HXDuBq8XfjLR67peUNSal/yst4sovuf6B2aC9RZ1KGktZgPOuc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(316002)(54906003)(70586007)(70206006)(6916009)(478600001)(36860700001)(7696005)(41300700001)(26005)(16526019)(2616005)(8936002)(1076003)(5660300002)(4326008)(8676002)(426003)(336012)(40460700003)(2906002)(86362001)(36756003)(40480700001)(47076005)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:48.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79b5d07-74d1-4ee4-613e-08dba4e98631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add HWID for Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9274b7289a41..c513b1650be5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -175,6 +175,7 @@ static const char *hw_id_names[HW_ID_MAX] = {
 	[XGMI_HWID]		= "XGMI",
 	[XGBE_HWID]		= "XGBE",
 	[MP0_HWID]		= "MP0",
+	[VPE_HWID]		= "VPE",
 };
 
 static int hw_id_map[MAX_HWIP] = {
@@ -204,6 +205,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[XGMI_HWIP]	= XGMI_HWID,
 	[DCI_HWIP]	= DCI_HWID,
 	[PCIE_HWIP]	= PCIE_HWID,
+	[VPE_HWIP]	= VPE_HWID,
 };
 
 static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index bc9783da7e96..dad83037793a 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -43,6 +43,7 @@
 #define DAZ_HWID                                         274
 #define SDPMUX_HWID                                       19
 #define NTB_HWID                                          20
+#define VPE_HWID                                          21
 #define IOHC_HWID                                         24
 #define L2IMU_HWID                                        28
 #define VCE_HWID                                          32
-- 
2.41.0

