Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D754C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 15:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A430361164
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 15:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A430361164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC336E0EA;
	Mon,  3 May 2021 15:57:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0496E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 15:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i29pEApqwh+jUpsV7+RBXT8O68thROYQD+UzGmCO95Sbbt+MnHErVv07WhXzt3ZdWw9HFU0JOlLvt0qGtnHweu7Qn5gYsr6Z2Bz8rRG+RasoGp4q8Q0GNeeTP/BnVSYffPgyxmjZpkUetx49p+KFv8QoOhtE+PsHMX1WEp+TAfnjr48+obueeCJUxDn1s/sgBeprkgzuI2qJJKmumx7FGPI0TPEg8JlEV0Amc8bKTNWLY4R8YGInWy6GO3PlZ49kxKyQ/gILfVh48K8Vr8xyHOZcg36DQaw1hC4ti+gB6s/jRieNhO/aWuPEdaumr8mx5FTwYfXbtYrCgCIjw0eAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8UKRriDKauqwKNUa5fR75/UH89Ml/4Krbydvz1qX4A=;
 b=QL0RdI7GNZPOGp5LJG9zOR4nsOiFVMAx4XIsGrWBcagT63eRqAVU0SYgM3JS8hyzZ548DoVc1rafNWsO8qws9kPHM+a2llwBtOApcK/CzHyJLxEKDJlgd4bU1oL5XS5VmK2inL5eCgwLQvJdFoQb8rsoEFi8JV/EixSd0Cx8Qpok4PDZBJd9930I1kt1l5/VK3GZ9KmpZMCwukH9azs1eWIU81k/BtR/DURFEo/9KN7Drdp3xj7rNb3InS7hbaQAq1KUMEyuKhcc03LtZV3PuYoW2La+Jrs1KNLro++VeXb3NhouuBHdfs8yi3geEQMNmE8WpeIZJNWPBZz5nR81Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8UKRriDKauqwKNUa5fR75/UH89Ml/4Krbydvz1qX4A=;
 b=yDbgIdXdr13YAgP/1k4tgDXn3MtfTG5qCqYteFqT2buHvnBLGbmeckoptxR/OdXQea8wF6G9hABrvI6yYLSj6rjaTY+MNAFaspDurrSau6KYRoEVq9YcOoreCD5bmC8He26pc3HZO3utWtyPIcmITLjeIH5qiO9XEfjTGC1eCpA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.43; Mon, 3 May 2021 15:57:16 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 15:57:16 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix no atomics settings in the kfd topology
Date: Mon,  3 May 2021 11:57:05 -0400
Message-Id: <20210503155705.102068-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41 via Frontend Transport; Mon, 3 May 2021 15:57:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af090e4f-b566-4b4e-0f28-08d90e4c1fba
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021782411BBFD069AFC52693855B9@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05pftrk/qVQlbcriaVHvT0usl5AJoElg0IHEnvfG7vmQ8Qws8RpR33nFTUuZZRcAuFWmOhtgKCLqAvM+tiYce4Se22zY/TFyIfCKRSZ247RylAWrrPUnsNIGyc74/gH/ctXEFYmtUeFxowKGFPRiTbGE8ZcbVCu0zPcbxMqsEQJD5mEx4FZc15x9F+LYxOOKV6He2twP8xu9GGBOx5kk7xIv16Cby5x8u25oaZxosOxhMhIYwqL1x/ccsYvaZBjEK4ndvaU+dzX0g+qsS/1dRhKQf6hoDkdLO4JQOLSzEd0R6KrttQb+VlRjkWpke4pR/sRcgBdIju1P5q7A2Z9w0w4RT4cqPQ3o4dPg2As1CIJFT4p7MbyX2Qw2Z2ZfZ9KSc2ytdMDW/f9tqOW1N8+b305xmyE0NAivgwGNifrMRxd8vpFM6MULy11uoIcJnwFaZk/vlwBw9XGdKdmzNxrW979KhHAC2wIkFRQcmfSihTf2ccW9DQjWZuZTMoKiaofSNhbv5TSqNWJd9unMKwHI/BNoYKEvj+nXTrGWtBkbvdIGKOR5oXSgtpo+Q0Ee1Icq39SNzwYZUFC5eXSB7zp+gfzGs6UlVPxVMgLSCr5fkL3TB/Voa/H2wE5OO8e4/ZYHVzoKq9qmooRv2RvCPdkwwCwKGf/VPdJNvzDcBXdGIn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(36756003)(4326008)(316002)(6916009)(66556008)(66476007)(66946007)(52116002)(7696005)(2906002)(86362001)(2616005)(956004)(6486002)(186003)(44832011)(16526019)(38100700002)(38350700002)(478600001)(6666004)(8676002)(8936002)(83380400001)(5660300002)(26005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vF/MtUlas3SJ2bKHwUVKKA9gxSsdXsFU/3ifEo/k7mUa6T8i9uRgOce0gCgm?=
 =?us-ascii?Q?IrK/hukK5IXtoEtewPHGJb9yfal3MBVjm4O4JGuHdNXPF8V+gUD4Qm0rs9p4?=
 =?us-ascii?Q?ZT1SA92IWd6nT6IakUgQbQhKhnRVcNaI9TKP6Zoe+Hs4b/5wSoiV5nH6IDrW?=
 =?us-ascii?Q?URWPOBh1vwLX80SpdB2WEvm1/YnPCCQCiBGrPm2FLyBvez3hQszeks1B7gOR?=
 =?us-ascii?Q?RaALDfhiD9l4M3aR3Da8bRV3uplYemXp9GefpRku3rXSLI+tGKdZPu8KlJIQ?=
 =?us-ascii?Q?YsKvFo2/o/gEO5xpX3pIiARa58SW8sE+t9liwvQYloRv4i7DXNQkgoRcIbGn?=
 =?us-ascii?Q?CUgr2orBFJEYshRbtCOaAnPX5fNA7nLloN88226mHFI7ln2P9WwdZ3F95Vm/?=
 =?us-ascii?Q?0KgithFLQTm5Qmtx72o75nakqM1vhXa1ea09ERkBS8WerUTn7X8s3DpAarXJ?=
 =?us-ascii?Q?my1kRlKy4VJffBdo+ux+FCDnF/aVtu46bd1EspUw0v3Z0Iht3nvlRGBHKIsp?=
 =?us-ascii?Q?gzWQuvXH2ST/K/md7eSODpuebNGRilbtYBPl0MrHA93XAgP1eFxOSJNZGXL1?=
 =?us-ascii?Q?IpxfxYtPmPkZbl46Tj8r+122/4HzzblRIxXwMOzZUamwDy1v+l0Tj0jqv6of?=
 =?us-ascii?Q?ARqWjcxQ+klWH29cAV1azC7bOm+TgfCVDrlL66WBYdEJAsw8/IRFSkmGC5qj?=
 =?us-ascii?Q?CNpySRIcLaXh9sohOHKfIrtdT1Z//Eh6Xqd674Wj1Q9mwWkxUTdR9Z0hW+sv?=
 =?us-ascii?Q?BO+/3rGQe4z8dCx6DzOHt3JB93X6VxeJnVOXadM1ILv4MJazK0dYcL6aaouO?=
 =?us-ascii?Q?gam+2lWuJodjpAIYQh8SkzFkbHgctm/w+jm6iNS9PFu4apsb0o/Q7UqI7mx8?=
 =?us-ascii?Q?8fIq91vig/aEVQ1vM97DdXdKJeWXhnvVCgRmBCFvcX4TW5692sHwtm6t2PpU?=
 =?us-ascii?Q?Va/dPGjEI/rew0RtmiFtXiHNlPn3Kcp9p50DExTPnxKs9P3jdQp7aclGcFOk?=
 =?us-ascii?Q?k5mDexUoF0aQ1DFkpfjQKcGzRFlN5tWwRbmpiGdWBmZjxZEA8w0gsLNLLyrZ?=
 =?us-ascii?Q?uljv6agg25txO0OcMtfVfpG3mmzZQ41cK08DsnhpF2X77NYzxOF2JHuW2Cf2?=
 =?us-ascii?Q?cSNYpfC1ED0i9qhXKvGT2EWI0yon03IPn4tqJrn4p37rGfgsidPHYTPd6IBi?=
 =?us-ascii?Q?wWtKpx3VLdSXByZvOhCQ2cIQzH0DtKlxmhGkOKD80kr+UAWxXzB0+Q17LKLl?=
 =?us-ascii?Q?WnEBcBEE5MhsaQSw0LvIRAiTjOpkz6yh9K1yF06t/JA8SXIYhzvvLoSx7zH7?=
 =?us-ascii?Q?Vd05NPnHU+esDoDJ9W+NFzF9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af090e4f-b566-4b4e-0f28-08d90e4c1fba
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 15:57:16.4345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/kW7rGY8+BdXNJ78tXD3MAKlN1re9ubqB+0WkuNZ8FBE5WffryR6qmtaGYJYBgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To account for various PCIe and xGMI setups, check the no atomics settings
for a device in relation to every direct peer.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 55 ++++++++++++++---------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 30430aefcfc7..40ac7fe2a499 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1192,47 +1192,60 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topology_device *dev)
 		mem->mem_clk_max = local_mem_info.mem_clk_max;
 }
 
-static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
+static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
+					struct kfd_topology_device *target_gpu_dev,
+					struct kfd_iolink_properties *link)
 {
-	struct kfd_iolink_properties *link, *cpu_link;
-	struct kfd_topology_device *cpu_dev;
-	struct amdgpu_device *adev;
-	uint32_t cap;
-	uint32_t cpu_flag = CRAT_IOLINK_FLAGS_ENABLED;
-	uint32_t flag = CRAT_IOLINK_FLAGS_ENABLED;
-
-	if (!dev || !dev->gpu)
+	/* xgmi always supports atomics between links. */
+	if (link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
 		return;
 
-	adev = (struct amdgpu_device *)(dev->gpu->kgd);
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		pcie_capability_read_dword(dev->gpu->pdev,
+	/* check pcie support to set cpu(dev) flags for target_get_dev link. */
+	if (target_gpu_dev) {
+		uint32_t cap;
+
+		pcie_capability_read_dword(target_gpu_dev->gpu->pdev,
 				PCI_EXP_DEVCAP2, &cap);
 
 		if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
 			     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
-			cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
+			link->flags |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
 				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
-	}
-
-	if (!adev->gmc.xgmi.num_physical_nodes) {
+	/* set gpu (dev) flags. */
+	} else {
 		if (!dev->gpu->pci_atomic_requested ||
 				dev->gpu->device_info->asic_family ==
 							CHIP_HAWAII)
-			flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
+			link->flags |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
 				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
 	}
+}
+
+static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
+{
+	struct kfd_iolink_properties *link, *cpu_link;
+	struct kfd_topology_device *cpu_dev;
+	uint32_t flag_enable = CRAT_IOLINK_FLAGS_ENABLED;
+
+	if (!dev || !dev->gpu)
+		return;
 
 	/* GPU only creates direct links so apply flags setting to all */
 	list_for_each_entry(link, &dev->io_link_props, list) {
-		link->flags = flag;
+		link->flags = flag_enable;
+		kfd_set_iolink_no_atomics(dev, NULL, link);
 		cpu_dev = kfd_topology_device_by_proximity_domain(
 				link->node_to);
+
 		if (cpu_dev) {
 			list_for_each_entry(cpu_link,
-					    &cpu_dev->io_link_props, list)
-				if (cpu_link->node_to == link->node_from)
-					cpu_link->flags = cpu_flag;
+					    &cpu_dev->io_link_props, list) {
+				if (cpu_link->node_to == link->node_from) {
+					cpu_link->flags = flag_enable;
+					kfd_set_iolink_no_atomics(cpu_dev, dev,
+								cpu_link);
+				}
+			}
 		}
 	}
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
