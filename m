Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C7C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF1F61155
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF1F61155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C5B6E14F;
	Mon,  3 May 2021 19:49:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09896E14F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB6nfOFNMLdtPit3X1BkbKUNPslJ3Y1WS/1/0gZPkludjP+aElYFbFdqYu7Yf27WYBj1SWL7iGUCJeWcUmCio9zZw96WBx0JMGuQqDvsgzifi/573luS4KZFQ6uXXAXvgu+ndibVZMpobMr+OThpLxq9+n04BV+QqBqe23XGKDDCj301DYVUx5uPQWbh9cQPiAAUtU5bHF4kvRXOfOzHbZmdvNa7v2lBAKioWF+mvM8ycQgipm47Jwifcxj8TxGM41uOCGNws1UR7lrVBdlzx1H9XWlfw1/9aeOupyg+Ckxk+hfphp5lcySyCk+TadcPLWWxIE23K1IrkBQoxLqSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mEshI7NbQKAbwMqZrNzeNlgRCg7GRSHupD40HbhWLQ=;
 b=BJcBaZBVWr/TeRtud8gYDdHmkP0YLOn4Hneh95abmYIOEbVv21f1CPONzTf/yV3F5Ive7hivzXEEWjbxnfIZGdDzIMwurhH92Sl1P1sNvMA0Gnd305pORzp11pB2lk1gJymzbG+FRK7OD3AVyGGcN5vdstN06AYGWVyQgNubQn0C4DZJd0aWDnR4KPFxK/VGnRQkwEavHSWOir5NJq+jFNAj0lPYHuTHegHQTxleRCJbm8e7wRkIildph0Rqq9CpBNn2jEWv7+rPSilVk0gbNWhmZM1cPv8W5fOWUTNjp9ywGERIsNF1WF9Wz2Ms9nu4cAJiQNeiG8rJAvuu/ZfYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mEshI7NbQKAbwMqZrNzeNlgRCg7GRSHupD40HbhWLQ=;
 b=3+7LdJwL12vBrFF5SZ9u1IU9lX4NOzKv54zfl5KG+dk9qw8VohbnjMYUHJd2vLtCQ+e9/HqL0CkCxvpQADawB3ZFaQNJg7elIahCG7MsJjrI2jHoimKmefNqsbctNaSbiG5fTeK/GfYmvpqPWxMjYmcYRGcNYMKR6Z+mH0z6ntY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Mon, 3 May 2021 19:49:43 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 19:49:43 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH] drm/amdkfd: fix no atomics settings in the kfd topology
Date: Mon,  3 May 2021 15:49:32 -0400
Message-Id: <20210503194932.121989-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.37 via Frontend Transport; Mon, 3 May 2021 19:49:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 806a45ef-19ce-4455-be3c-08d90e6c9854
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435394732B6B935CDB258A2C855B9@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73KUC1pBSggSaA3Hf98dQ/fFKzc5efLf6kehfdfqmQAbXVmV1vkq10eXmjx5zcX4NCck0dmhbhdQO3usrBaznHMLjavvKE9r6bw47N/GgNSu9FAA1maay22O0v4xNVExeF1r6W6Ey4shBCXYgnR9SIbXx6BQK955B6UlACQTVUL0WlU1F4Ju3cC6uV1UMjAEWn7htHXlsizzuHV8F5yJj1WqNpM5lug1y/0Y0rrBUc1SAjZzUDOlBZMiEyIqhtU/+H9KwzFZSFW9A1gck8rotiG1Cte57TvLtCvDN7ffoH0Tc0/Bn0B9V3sNxUx7mhQY+vlzkkPbydG2GURBpVMVW7bzuTik/8ZB5X+uYbcZTT0P8izXSX0W5s4R8eq6AKIMwCXaCASz0TQJMbRIBAauiJ2zWeIEt41+2iF19k6wijRuZnrlQl/qNzJNdXZ3ncqbYVAVJTskm44gu0DpOhaq2zxdcuj8ZTiuyrZLyAP96sc2etwR3swYh/mOs25WktTL8kH13xnAZy24lrUxeMUCn1d/86FepW7PnrY/e0u1v6X3sgyKYCVfr6Vvx8WAFEZN1cxYkAwUXPyZVB7uen42U/Xc2K3YScvOqxiQoyq/mJMaBIE5CrWd9ZvaG3RmozGMzyaF98AXrAzKroSfsIZrzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(396003)(376002)(2906002)(83380400001)(5660300002)(2616005)(1076003)(8676002)(66556008)(66476007)(66946007)(8936002)(38350700002)(38100700002)(16526019)(186003)(956004)(26005)(478600001)(6486002)(316002)(86362001)(52116002)(7696005)(36756003)(6636002)(6666004)(4326008)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G+/AU7xlvaM5V/rrEkhob6UF4FemklRVuGgicAt/AMTW6ms+ysvkONcFAbdc?=
 =?us-ascii?Q?RAtdMbPMtMDkmLuEh+Ey4BDRovwZnk5J6VRmyihPXd9hs+icok0aapy2JBjL?=
 =?us-ascii?Q?6K3kU5tdLBp5fhzv6L0go8Ej/SeZc3kabheHtY37VtqXVPdkAE23dTeosqko?=
 =?us-ascii?Q?kIHfuqQ2M/e782Sxwm5OkT+NuRAIY+DVnfGy5/raQMu8rCSYn+JleTD6Gs0n?=
 =?us-ascii?Q?MmtWHf5zQHEqy/NmVvs+O+16tRkFKT4kVsByVrlbNe8UmOaNIsMXwSiguXwW?=
 =?us-ascii?Q?qecqBievEgptP0AYHt+/zE9RqJw9MmTYsdScc3mlrnXrD2KRFq2Yx3nyPBPY?=
 =?us-ascii?Q?WGpVmrn44KDnToomQUWiRH/baFeqvJ43Xig71TinbCwvPsTfXdxgUPIoizV/?=
 =?us-ascii?Q?lW/XpfaOgJHk5Y6duD2cXOSdXZt6m/wtQ5UPUAN+yJfJwMQ5FNikbR4DAIr3?=
 =?us-ascii?Q?BzG6sgk15T4R1hR49MUmCxIuvxGZZIiaeCorIph7K/X23Kag1zeazqMociov?=
 =?us-ascii?Q?xBL/dKmlAbZ5IQdEDOJV+eUf1WR6PfqNRUCXDZ8ljHLi3p/1Cv5WeD2Ab2cU?=
 =?us-ascii?Q?Pl90FgY4czOn89ez5uvz3ULKFF1bujbtIg0SMofx2mUhG78Pn8VD9rBmOoWZ?=
 =?us-ascii?Q?7g2N22TYgjE0SXbfUqkfBEFPeMQp0dG5634DUT00ygOdJXzomfXSdAHWhfzQ?=
 =?us-ascii?Q?33aDvVXQ6SvUk4Bxz+hptWHuecR7NubRpp0OOjDtv8r+AV5RAhDE6I111fQq?=
 =?us-ascii?Q?UGOGTIANIBrsO7xMc5FKmk9zRHsLBP+jrT7suLz7RUDbRWUV9Hg7ABrJoGEp?=
 =?us-ascii?Q?CNAZqvhyLHRnlEGbZHr8jR9aEGAh/FRw8OSMrfQnzeHbB1QT34HJ+5YACBNP?=
 =?us-ascii?Q?1uST92+Caob14Asa/3v2A1ojBiosJIZ8deWna8NmTXaZM/E0WJoZx9kVJ/SG?=
 =?us-ascii?Q?pHxCTpncVfw8di/t/NvMJu8Mrf9saMYZA3g+jVNluaVvkrWt0f1XmvAkDO2g?=
 =?us-ascii?Q?ClwSfm4vMBi5WcEVjvEKchUMkVwGCKsaDoHW6kv4FjE9xkxcq3KMG+gx0Jgc?=
 =?us-ascii?Q?V+GLPAvBYGO4DRJYxvzzv+8944SLfC4qfj28+jDbMBxYUMVupKizxBlILBS3?=
 =?us-ascii?Q?GQbrWbnBRxFcvMThheyEqkAwa6XVt3iZ3kQk4Hae/GevHIYoKgfMpP/SMoGE?=
 =?us-ascii?Q?YMP1eWqX9OPi0WZe0gb9/iI7G+0e2K0bomMlOnGPJOJM+OkPwuH5+dZIEb6g?=
 =?us-ascii?Q?XrUiyo9vnlbJdmRatAoIGeSg+AdMfC+P+hRMgnKd6TyCdnDp4r8QSiNw2zQW?=
 =?us-ascii?Q?Eb2e/zPWOSUHAOUZifM+KOsY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806a45ef-19ce-4455-be3c-08d90e6c9854
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 19:49:42.9760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA/ds6scJHX1636XgUL/GziPq4C595Cj78/PWR7SjhpezJ/KwYzawU71K6Bpb8R7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To account for various PCIe and xGMI setups, check the no atomics settings
for a device in relation to every direct peer.

v2: apply suggested clean ups in main loop.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 61 ++++++++++++++---------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 30430aefcfc7..fb4f718a1148 100644
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
+	/* check pcie support to set cpu(dev) flags for target_gpu_dev link. */
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
+	struct kfd_iolink_properties *link, *inbound_link;
+	struct kfd_topology_device *peer_dev;
+
+	if (!dev || !dev->gpu)
+		return;
 
 	/* GPU only creates direct links so apply flags setting to all */
 	list_for_each_entry(link, &dev->io_link_props, list) {
-		link->flags = flag;
-		cpu_dev = kfd_topology_device_by_proximity_domain(
+		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
+		kfd_set_iolink_no_atomics(dev, NULL, link);
+		peer_dev = kfd_topology_device_by_proximity_domain(
 				link->node_to);
-		if (cpu_dev) {
-			list_for_each_entry(cpu_link,
-					    &cpu_dev->io_link_props, list)
-				if (cpu_link->node_to == link->node_from)
-					cpu_link->flags = cpu_flag;
+
+		if (!peer_dev)
+			continue;
+
+		list_for_each_entry(inbound_link, &peer_dev->io_link_props,
+									list) {
+			if (inbound_link->node_to != link->node_from)
+				continue;
+
+			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
+			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
 		}
 	}
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
