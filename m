Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1E0CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC4111262B;
	Fri, 29 Mar 2024 10:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HSSoNDJV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC8511262B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7+Qrx0R/uY+Fchu1xItj2BpP9wfiChK9t9YKEFeHqQMtLdnhfcFpO003Odibd9ZFipAnWDgg0Jl1A7da14pbdchBAz7RyRFJ/AkKGwojvlyAQdxZDM2/cl2cdrX28VliqOsEOr3/bks3I3Uinr/pA8KBm+eNwISDWy9WmGGKpP73txYRuFtHxFj1Msn92P5pkWDMmyfw6v+I+taq4Keg7O4/iN9cU722j2Wtav0Dbv7QL9Zd4zSeojcPfrLzXLTskYwDUPtYqa6wTkfzE4CW6FgZh9lgDsgQZz3AK0+XjOEqTteX0FQUIgDQndXInCmmyiCx8ks/KjdhYHtMoh5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN44zs+toPgMjy+2ewOPy9ucQ7DqDDIVPQyGLQPFhyA=;
 b=EkoAF6jdx/lbBNiRlrZrU2PcpCmFFwHfy7q6WQmQGiJUI8ZX3WGNyDpugN9nP6IcSMRydQ+M/MNJlYmyUYpmYyUbZ0U29OcIswCgmk7dfUrGFFs0kGwUhT6sVBjXaDEsbPo/3ejsnyP9odxrpGFIJEUEEsnOVcEzzs8Wm08K8ONP4V5h8RNG33Jr5o4l9IGIFVxosT7XV6FsGzLn9gNuAHF9AixXE0t0e16xcGX4KNrkcKwDuhaFLrdoXtoI7ish1w7ppLy0HZo3kKTpxf+p2dVw6cEZ/F7H1KEJiehiVdlgf1ZXPa2ntYvjfexjuI5CENVB3J4Efk9QFXyqUlIwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN44zs+toPgMjy+2ewOPy9ucQ7DqDDIVPQyGLQPFhyA=;
 b=HSSoNDJVlzjmDZzsm1EWyLlnDTqO1+pAFigbwXUzSnxZBES91xB9yWGeRMxHGMzXq+zrO3q6HULEmTtZUTe1tVOlpBm52uBDsoNF5pm0QNM9bC18dCOYIQQiN3NbwI3PwDP8DPjur0zZFnDVEkk3bGtiGpFzERV79LFTLo3xg6M=
Received: from BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Fri, 29 Mar 2024 10:20:46 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::c1) by BY5PR16CA0001.outlook.office365.com
 (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39 via Frontend
 Transport; Fri, 29 Mar 2024 10:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:45 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:43 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 3/8] HID: amd_sfh: Add a new interface for exporting ALS data
Date: Fri, 29 Mar 2024 18:17:45 +0800
Message-ID: <20240329101748.3961982-3-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329101748.3961982-1-li.ma@amd.com>
References: <20240329101748.3961982-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: db120d6a-279a-423f-d40e-08dc4fd9e5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJ3t+u2YhzGYgPyiNxOZ67T4ZdQWIZWTg2k0X8FtpWmZXNd9PPr94O6XcLZoJ+WkA74AdZPPZ8IOtqPoH/DmqH+jt7T6IwNKuVsfhtBZcBCMr7MMyPe9Bq+SFYZrhOmD17CYyUknQ8AZ9OIxE0TIMH2DfMXa7aWO3hmMci2EdhrU808rlCai35USwMr3Ra554ecrXJTg1Bi07CslMm3NNBU+Gz/hKHIUqJZZhrSdsmn9Y7ko7up84ysH9ruu49M6raslafvexnppQmhsbu2wFcrp27/PfGJAOfCOglXFnna4Ree7o9aX9Zsh5MITI0DdkGL07F4Oj/p1LYTUlmQGpr0ci80unKctyUYiJ+HM2UUyq4EZhzrDId0jG7QgQTt61zRXELbmVyehS88NEz1M3kQ94ditpahz+p01fzkalQTAs91pOx1S7edLtsNocbnN0OcNSK+IMVN3IUjABF/9v0xEV9tPTR5CfNG2xCL3ejeqQ+JbgV1YJu1temrJm01jTkItiCQhwMUyz3NN2TRXG8NFVE61raQCApGN0woXBwdF9NvNSzB+FfAZvNwSy0z1CEmZJmDtF29zguLJz9epOWSXksW+k9XZ1ebsmlT96eeRl6tW7/GKYqRmbJ/CzEVK+b0780I8/xD5mkljRo41jLYwGx5+nMVw/vK2UjoGARkXJUB4bb1mboFRiUtOGhd3BxyTFIjm2An7L9LgVXZO+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:45.7800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db120d6a-279a-423f-d40e-08dc4fd9e5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

AMDSFH has information about the Ambient light via the Ambient
Light Sensor (ALS) which is part of the AMD sensor fusion hub.

Add a new interface to export this information, where other drivers like
PMF can use this information to enhance user experiences.

Link: https://lore.kernel.org/all/ad064333-48a4-4cfa-9428-69e8a7c44667@redhat.com/
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 584f35a3647d42980af495fc0bc5c51eb174aa35)
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  1 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  6 +++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 22 +++++++++++++++++++
 include/linux/amd-pmf-io.h                    |  4 ++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index cd57037bf217..a1950bc6e6ce 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -39,6 +39,7 @@ struct amd_mp2_sensor_info {
 
 struct sfh_dev_status {
 	bool is_hpd_present;
+	bool is_als_present;
 };
 
 struct amd_mp2_dev {
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index 0351b0fd394a..9dbe6f4cb294 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -77,6 +77,9 @@ static int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata)
 		case HPD_IDX:
 			privdata->dev_en.is_hpd_present = false;
 			break;
+		case ALS_IDX:
+			privdata->dev_en.is_als_present = false;
+			break;
 		}
 
 		if (cl_data->sensor_sts[i] == SENSOR_ENABLED) {
@@ -188,6 +191,9 @@ static int amd_sfh1_1_hid_client_init(struct amd_mp2_dev *privdata)
 			case HPD_IDX:
 				privdata->dev_en.is_hpd_present = true;
 				break;
+			case ALS_IDX:
+				privdata->dev_en.is_als_present = true;
+				break;
 			}
 		}
 		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 197b828fc6a0..ae36312bc236 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -103,12 +103,34 @@ static int amd_sfh_hpd_info(u8 *user_present)
 	return 0;
 }
 
+static int amd_sfh_als_info(u32 *ambient_light)
+{
+	struct sfh_als_data als_data;
+	void __iomem *sensoraddr;
+
+	if (!ambient_light)
+		return -EINVAL;
+
+	if (!emp2 || !emp2->dev_en.is_als_present)
+		return -ENODEV;
+
+	sensoraddr = emp2->vsbase +
+		(ALS_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
+		OFFSET_SENSOR_DATA_DEFAULT;
+	memcpy_fromio(&als_data, sensoraddr, sizeof(struct sfh_als_data));
+	*ambient_light = amd_sfh_float_to_int(als_data.lux);
+
+	return 0;
+}
+
 int amd_get_sfh_info(struct amd_sfh_info *sfh_info, enum sfh_message_type op)
 {
 	if (sfh_info) {
 		switch (op) {
 		case MT_HPD:
 			return amd_sfh_hpd_info(&sfh_info->user_present);
+		case MT_ALS:
+			return amd_sfh_als_info(&sfh_info->ambient_light);
 		}
 	}
 	return -EINVAL;
diff --git a/include/linux/amd-pmf-io.h b/include/linux/amd-pmf-io.h
index 5b6d29d36922..b4f818205216 100644
--- a/include/linux/amd-pmf-io.h
+++ b/include/linux/amd-pmf-io.h
@@ -17,9 +17,11 @@
 /**
  * enum sfh_message_type - Query the SFH message type
  * @MT_HPD: Message ID to know the Human presence info from MP2 FW
+ * @MT_ALS: Message ID to know the Ambient light info from MP2 FW
  */
 enum sfh_message_type {
 	MT_HPD,
+	MT_ALS,
 };
 
 /**
@@ -36,9 +38,11 @@ enum sfh_hpd_info {
 
 /**
  * struct amd_sfh_info - get HPD sensor info from MP2 FW
+ * @ambient_light: Populates the ambient light information
  * @user_present: Populates the user presence information
  */
 struct amd_sfh_info {
+	u32 ambient_light;
 	u8 user_present;
 };
 
-- 
2.25.1

