Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E852C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 03:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B016610E4A3;
	Tue,  7 Nov 2023 03:06:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDACE10E115
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 03:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grZwA+g9YntGlp2ahOaYGxVpfQi1KccEvnlxWFJ0E/c19IS2jR2kBeJlMbUcXjIPs7Rj1JazVnOXOrZAzbXXUxhlfGVCjVKpMHSyaDESH6fpfx5opPUpGBUzurCuXleK3z/pUqnIIRVz82PUfAWGsT6hQq5c09ROUo28x7y3BMVCD+tLHU2p1u99fOQKmF4HTMRjJ6MKbBiXWK2FABYyKstYvBdYimTAoMiLImgJoBTBUxPdB8DFj8eiVeDaa5s6RFpOOxJbP1hFbkqVR3Rz/c8cRfHm3b4RjyORbLLY2WVsM8jnbdvcrjX0Rv1aEEkMDYH+8jxDOo5TL57WSzI7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+HSpxIUdRHO81iXDcvVmmGgDcFHiEvd7CV+27zz2tU=;
 b=ccqIQw86JDhSntSvN4smsOQqMWP+Og16C7uji9rsOzkqoxlwAi21BzVBEkL6yq8Ci4JNpiLxEU1M2XJ8FpvUnTgoj9KQaIgPrdNuDY2rLvCssJGRiCe3Nm/bjGydvFPusJ7+pLhuaCOxRHI9y8ZXtZwzjLSTDHJv6Ow8DF360hTZItSztLrOlSKIike0kTQ1ps7CQWEzCBAkYsa0Ka8/Ole3zJkAEJIuCMDPGVLJYOV7BiyBt2uODUR/HZAp0Gp27vZPHtKMSjFIF2aqR7YYLDP6px9DlvDm/Ic03pPe7Moqwc+99sw8jusSSYG7ZmCoQuVX/a5b14eTMYE6xh0aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+HSpxIUdRHO81iXDcvVmmGgDcFHiEvd7CV+27zz2tU=;
 b=U4f5AxFVs/e92nvnjiYB8GvnFvUEtEgYps92qZ9HN9B0RHrQb9olo7mg9SKdP7CvLNLpGLDpjp0lXsILEZVLlmAVrafW/MT8iiXQ+J1Sj9V4GCN5m/8fiETxjVidj8onDG5YIF1BPiaCPVObbN2ZWlHqtq0TjdA3pEu/ZdZcPAs=
Received: from MN2PR06CA0011.namprd06.prod.outlook.com (2603:10b6:208:23d::16)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 03:06:30 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::8b) by MN2PR06CA0011.outlook.office365.com
 (2603:10b6:208:23d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 03:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 03:06:29 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 21:06:28 -0600
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: expose the connected port num info through
 sysfs
Date: Tue, 7 Nov 2023 11:06:11 +0800
Message-ID: <20231107030611.31109-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231107030611.31109-1-shiwu.zhang@amd.com>
References: <20231107030611.31109-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 109624a4-fc69-4021-35c1-08dbdf3e89c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMPZM0mN7xwTHIlORmcFneNVupS2hKPn1H64L00RFN8vjyCyRW+X8UrycUPCKTnejkX2d6z8KayD64PnKG88aYhnQNqept9uVhKiV6R2i42n/1XFsxZrn0Jk9V0Nh6sQHq3WwHpbbkhbSxlmAuLkkTgMs6o29Tb6RpxFwAgWHhBLiuhsz01nNCpEbb0pB4pxhweNWSbPhKV4cgBRrBsG7LMPS7wmn8X4TP+S1sX4MPmEVC1AfuFItG/m82UEVwI2u49cMEFB648aNMd6SMurI9tW9aYGd/8txs0/AzAQfvK0Fp/CrpEq7PK5yq5aEGGeqFLnjKmVSYWer3EtPoQ0N/GKgF0qFct5eavOv9NvMFVYHw2GqQ7inFBlGvu9E62UeBiJPxlG8yTzXgkyBDCwaxa+Es60ftf0XZLRxjaPtnsv/ioTg0JrVlzV7T1NnVa+vhyzjVUgfjtYJFyO1bHEkuH8nggUeKyxonwoTuCvSKb2Pg2WQROFxwT0pW76mQkdWXc6SsmTip2784no+L9/wSbjdtMSta3AVLFmBsPSkCjEl4xqDSwvBR4oW8bITo9hWqXLB1Ie8bAosX4ZzrC5qYyHqU38z2FHk1cSoH/ff1zX2qULo4I46fBK6H9YBmxT6KV3BMG2DD6/b+SOvtP2VIV3SJjuEsyfuMwzQujmfgkbthqahRK3bXC+pME0LaasWxDDijKDkhOMhVEC5Yzd25zIYOm5xdR2iW9S4DCIs/JAIvRd86ar+d7gTmJyK+pVkEad/I5smWnMXHGLift1OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(40480700001)(478600001)(6666004)(47076005)(82740400003)(36756003)(86362001)(81166007)(356005)(36860700001)(2616005)(41300700001)(6916009)(70586007)(70206006)(1076003)(426003)(336012)(26005)(7696005)(2906002)(5660300002)(316002)(44832011)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:06:29.5219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109624a4-fc69-4021-35c1-08dbdf3e89c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

By catting the xgmi_port_num sysfs node, it prints out the info in the
format of <src node id>:<src port num> -> <dst node id>:<dst port num>
for one xgmi link.

For example, in case of 4 sockets fully and evenly connected setup, it
would be like as below for the first node in the hive.
01:02 -> 02:03
01:03 -> 02:02
01:07 -> 03:04
01:04 -> 03:07
01:06 -> 04:05
01:05 -> 04:06
Based on the fact that there is two xgmi links between each socket pair,
"01:02 -> 02:03" means that the current socket in question use the port 2
to connect with port 3 of the second node in the hive and so on.

v2: print out the src/dst node id for each xgmi link (lijo)
v3: replace the current_node++ with +1 to align with dst node (le)
    and use the dev_err instead of pr_err (lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 2b7dc490ba6b..4bce96300e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -372,6 +372,38 @@ static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
 	return sysfs_emit(buf, "%s\n", buf);
 }
 
+static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	int i, j, size = 0;
+	int current_node;
+	/*
+	 * get the node id in the sysfs for the current socket and show
+	 * it in the port num info output in the sysfs for easy reading.
+	 * it is NOT the one retrieved from xgmi ta.
+	 */
+	for (i = 0; i < top->num_nodes; i++) {
+		if (top->nodes[i].node_id == adev->gmc.xgmi.node_id) {
+			current_node = i;
+			break;
+		}
+	}
+
+	for (i = 0; i < top->num_nodes; i++) {
+		for (j=0; j < top->nodes[i].num_links; j++)
+			/* node id in sysfs starts from 1 rather than 0 so +1 here */
+			size += sysfs_emit_at(buf, size, "%02x:%02x ->  %02x:%02x\n", current_node + 1,
+					      top->nodes[i].port_num[j].src_xgmi_port_num, i + 1,
+					      top->nodes[i].port_num[j].dst_xgmi_port_num);
+	}
+
+	return size;
+}
+
 #define AMDGPU_XGMI_SET_FICAA(o)	((o) | 0x456801)
 static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 				      struct device_attribute *attr,
@@ -411,6 +443,7 @@ static DEVICE_ATTR(xgmi_physical_id, 0444, amdgpu_xgmi_show_physical_id, NULL);
 static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
 static DEVICE_ATTR(xgmi_num_hops, S_IRUGO, amdgpu_xgmi_show_num_hops, NULL);
 static DEVICE_ATTR(xgmi_num_links, S_IRUGO, amdgpu_xgmi_show_num_links, NULL);
+static DEVICE_ATTR(xgmi_port_num, S_IRUGO, amdgpu_xgmi_show_connected_port_num, NULL);
 
 static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 					 struct amdgpu_hive_info *hive)
@@ -446,6 +479,13 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	if (ret)
 		pr_err("failed to create xgmi_num_links\n");
 
+	/* Create xgmi port num file if supported */
+	if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG) {
+		ret = device_create_file(adev->dev, &dev_attr_xgmi_port_num);
+		if (ret)
+			dev_err(adev->dev, "failed to create xgmi_port_num\n");
+	}
+
 	/* Create sysfs link to hive info folder on the first device */
 	if (hive->kobj.parent != (&adev->dev->kobj)) {
 		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
@@ -476,6 +516,8 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
+	if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG)
+		device_remove_file(adev->dev, &dev_attr_xgmi_port_num);
 
 success:
 	return ret;
@@ -492,6 +534,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
+	if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG)
+		device_remove_file(adev->dev, &dev_attr_xgmi_port_num);
 
 	if (hive->kobj.parent != (&adev->dev->kobj))
 		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
-- 
2.17.1

