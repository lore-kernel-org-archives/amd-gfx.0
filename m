Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0DEC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 00:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEDD10E1A7;
	Fri,  8 Dec 2023 00:42:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB1E10E1A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 00:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa8c3fhS3xBqlhm7dC6IhCG/czFp9zBEq/hx5yywNpWdTKrMFbfVYSMVNckoJ+gbnnlmGS7ohxVVH6tKvKJlAW29WfaF6pU6F8e8Npv5z0HGZzMpI1YZwjQP7cgSa0zpXCSHM9VAJLdxBKArZ4CfSSGHGX4yXks3tx6VESM8V/zIxwaMemYbhVWp8iAPXzbUBXMzrDzOPBJuqYImJPunyCnB2m5RW+/pXCcXSqRbPdB9jtisD2SZKJmXuOWN+q8bzEAtEfD8H6ygIUosxxUK4Er38wr7S8qR9WWkpkuLqHfNp17yUa779Qbw98ee3v5C++W2kb3M+JMSNPgyXSkK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mx57GLyYwMR9Aqxg643qvHLvZ4ER2BgztzCdeQa8yM=;
 b=j6JWXKpvJbUcoh6gVlqtGf7KaHno4+CBZ59WlJwtLhlDtJczKCR/a0rI27Bx66mmu+B1mRuchPomowl3m2PRCyg3R34Pdtkrge/pQLt1HGQWUCuM+1+jhsRwgwNzCQr1Ji+N9oHocFb/lf8CuRaZJL6kxNupmpBApETdvGaxK2GCq6rGihjf/XDj131vJwPXVGmfYLtN0dWewjP7YFcA7CwpuZ9jZELQpDK4yTQFm+IBCj1QYeiDPGijoYmGdVVFkcAx8YfuGS8F5QPZi1TEc9Ozpcc4wg6KQ5NRctTXX1vYBAylIHSnMUchUgYsNqXRDOi/B3K2w3XSV8OVPIG7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mx57GLyYwMR9Aqxg643qvHLvZ4ER2BgztzCdeQa8yM=;
 b=Nve8IiBK8AVxs4ju8wS8ZLGZ4UhvN7WvCL0cIGyETleMnEoWFpwJqjwPx4b+oHuWPTEAJ5AmDtH6hfUnFGaeXJi8hvc7bGqBFzYnwN4Xyctr/WECX0d2SMPLAjryDFFkz3+t1ycns7pPRMMnHhdwuu5mDn1bRyeQTrpAUpKIJfA=
Received: from SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 00:42:39 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::16) by SN7PR04CA0052.outlook.office365.com
 (2603:10b6:806:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Fri, 8 Dec 2023 00:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Fri, 8 Dec 2023 00:42:38 +0000
Received: from H-4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 18:42:37 -0600
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: xgmi_fill_topology_info
Date: Thu, 7 Dec 2023 18:42:11 -0600
Message-ID: <20231208004211.3720802-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a979539-3721-4036-e1ad-08dbf7869422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gTIBW7RPcGktrLvXufpfCVhXQkt2PlyD1PrPhpRDrtCJPkMGqonZ/2IgVSniiF/+LXiuhGS2BHBIuJlxGBEO/zovAHolnPCge+QZOCF2sYmrWPfG3cVG3kiX/YBG9SnQmjcjWR8fsvtXbPszFQdFaYcMmmAnLPZuZUHHIbNS1w1nldjBeAmy+y2zrmbY57jJU8IUFayBVyJVFkbER3raWfy3DHUfHzUBH4LSUPJUL6tDSU6XKPwlrQhvN7mNlPvSlv7Pf+kr8uqiqTKoUSzv2uyDMmAVExBJ9qAUxA50TdSPfcRLxjnR+GtN6kLYRUXtEoJPq56yiosUTlovbN9H2SfuHGKqiXR22A29+b4Y0swXDqyyj7Lwz7n/YsXGwBmqsrLJj7QMjvJFZA6IY6N7YjhIgRHSQmktLKHi8p/A6ClELdDeR8m4ke4iq2rB9W12/6/bqPzdhQe1cMwyTCqLxPGnAt3x195npn65w1OAxYe4AoS3akPJztLP1/dTmIKoHdiWT9ZwcGAhF1AMgCXiyZ/Hfyr2E2VNvAOwJap46xCpnuKb7almyYcU9672fcIMtifBfBdkZavbaUB8bzSf+RTq1okS2ZNcIVyWHIkr/8GexaRmbmmI9xaLXgrAT3wljw5EWxY/s7VcwVWQBIUfXi6lK9SltlmKm1Ky1+Xokjeng/izbOwt+oW4DUYXV5cRyxbHcPhAK4MwEgcYKMWXVapRL+C4dPcPiVr+48fRIl3jYdoPoTKBtEIDUQcffeRa51tFuSOoY0lN5wjcnVfCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(316002)(70206006)(6916009)(54906003)(70586007)(40460700003)(2906002)(41300700001)(5660300002)(86362001)(36756003)(81166007)(4326008)(356005)(82740400003)(8676002)(8936002)(26005)(336012)(83380400001)(6666004)(7696005)(16526019)(36860700001)(47076005)(1076003)(2616005)(40480700001)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:42:38.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a979539-3721-4036-e1ad-08dbf7869422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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
Cc: Lijo.Lazar@amd.com, Zhigang.Luo@amd.com,
 Vignesh Chander <Vignesh.Chander@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Use the mirrored topology info to fill links for VF.
The new solution is required to simplify and optimize host driver logic.
Only use the new solution for VFs that support full duplex and
extended_peer_link_info otherwise the info would be incomplete.

2. avoid calling extended_link_info on VF as its not supported

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 58 ++++++++++++++++++++----
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a21045d018f2..1bf975b8d083 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1433,8 +1433,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			 get_extended_data) ||
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
 				IP_VERSION(13, 0, 6);
-		bool ta_port_num_support = psp->xgmi_context.xgmi_ta_caps &
-						EXTEND_PEER_LINK_INFO_CMD_FLAG;
+		bool ta_port_num_support = amdgpu_sriov_vf(psp->adev) ? 0 :
+				psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG;
 
 		/* popluate the shared output buffer rather than the cmd input buffer
 		 * with node_ids as the input for GET_PEER_LINKS command execution.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 44d8c1a11e1b..dd82d73daed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -823,6 +823,28 @@ static int amdgpu_xgmi_initialize_hive_get_data_partition(struct amdgpu_hive_inf
 	return 0;
 }
 
+void amdgpu_xgmi_fill_topology_info(struct amdgpu_device *adev,
+	struct amdgpu_device *peer_adev)
+{
+	struct psp_xgmi_topology_info *top_info = &adev->psp.xgmi_context.top_info;
+	struct psp_xgmi_topology_info *peer_info = &peer_adev->psp.xgmi_context.top_info;
+
+	for (int i = 0; i < peer_info->num_nodes; i++) {
+		if (peer_info->nodes[i].node_id == adev->gmc.xgmi.node_id) {
+			for (int j = 0; j < top_info->num_nodes; j++) {
+				if (top_info->nodes[j].node_id == peer_adev->gmc.xgmi.node_id) {
+					peer_info->nodes[i].num_hops = top_info->nodes[j].num_hops;
+					peer_info->nodes[i].is_sharing_enabled =
+							top_info->nodes[j].is_sharing_enabled;
+					peer_info->nodes[i].num_links =
+							top_info->nodes[j].num_links;
+					return;
+				}
+			}
+		}
+	}
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
 	struct psp_xgmi_topology_info *top_info;
@@ -897,18 +919,38 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 				goto exit_unlock;
 		}
 
-		/* get latest topology info for each device from psp */
-		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-			ret = psp_xgmi_get_topology_info(&tmp_adev->psp, count,
-					&tmp_adev->psp.xgmi_context.top_info, false);
+		if (amdgpu_sriov_vf(adev) &&
+			psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG) {
+			/* only get topology for VF being init if it can support full duplex */
+			ret = psp_xgmi_get_topology_info(&adev->psp, count,
+						&adev->psp.xgmi_context.top_info, false);
 			if (ret) {
-				dev_err(tmp_adev->dev,
+				dev_err(adev->dev,
 					"XGMI: Get topology failure on device %llx, hive %llx, ret %d",
-					tmp_adev->gmc.xgmi.node_id,
-					tmp_adev->gmc.xgmi.hive_id, ret);
-				/* To do : continue with some node failed or disable the whole hive */
+					adev->gmc.xgmi.node_id,
+					adev->gmc.xgmi.hive_id, ret);
+				/* To do: continue with some node failed or disable the whole hive*/
 				goto exit_unlock;
 			}
+
+			/* fill the topology info for peers instead of getting from PSP */
+			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+				amdgpu_xgmi_fill_topology_info(adev, tmp_adev);
+			}
+		} else {
+			/* get latest topology info for each device from psp */
+			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+				ret = psp_xgmi_get_topology_info(&tmp_adev->psp, count,
+					&tmp_adev->psp.xgmi_context.top_info, false);
+				if (ret) {
+					dev_err(tmp_adev->dev,
+						"XGMI: Get topology failure on device %llx, hive %llx, ret %d",
+						tmp_adev->gmc.xgmi.node_id,
+						tmp_adev->gmc.xgmi.hive_id, ret);
+					/* To do : continue with some node failed or disable the whole hive */
+					goto exit_unlock;
+				}
+			}
 		}
 
 		/* get topology again for hives that support extended data */

base-commit: 44cb338138f7670ce2e1f8b9ef14e32c6ace282c
-- 
2.25.1

