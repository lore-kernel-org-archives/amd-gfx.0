Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CA3C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB806128C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB806128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D776E3F2;
	Mon, 21 Jun 2021 19:24:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89756E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 19:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZg3T7q3XjvI11K5M1gHKyZwSIF0awVxxhRvSmpM7breRx24A7C8pZ9rvjAZYtuzSHHPoh1hcV4peWK98euPjt3b4t76NnSyJ63SkieUedWBsMusvpRG70zEJI5g4fC1hIWKqm0BceqCHY0VwNo+tbzgqpre8fKU9ybvs44b5fySzbf4hOZlGvkGf1ih1Vnh7fSODip8siepyDiOpg4r+KOOZF5dWc6Y9lCIRyYPoVF6MeWYNeWP3u7jtOakXcuCO/pGUFtPD7aUUL6q3etMxWan1CdyBlYwo1GWMUTKN6gC3l8XSn7JQJXRibzewGds2y9M6hiQk73rRsc/KwSaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPgMUMgYG8LM5pU09rKNNbydy4+CGSQYpqiRt//+qUI=;
 b=EtM2kbw26ITK+W3Fp5G3yVmUijV5L/z5avgOWTUXtGaGoukbzbEz+adMqZwp5kInBSjTlANKM24ye1X2w+ezC54tgK6xAFiuhGlaiYeSbeD2eDmLZ9/NRhtRydHVPyU2O1tzq+PBgDUe1KO/fbVYY9LR/kIyDckOk8u3kPmXkrHbxb7P6PgQUW3pPeI9iFBgIQqbFtP2Fq8dYXc5MpQWYosm5HwZyHOCnesicXDdgCd/mQfYb+Hh/XKT8cYbH/em3Itrw9+Z46iH1SU/pxdAo1b/vB7mCIt+yIUdBIHG8dbR5yx9hF+H6tDo77Z5zrJYJymbBFkv2MUw4VIFmQOldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPgMUMgYG8LM5pU09rKNNbydy4+CGSQYpqiRt//+qUI=;
 b=jAlltwRWS1pjeNds94P8V2BjBhzZaDx1OlijOSHkXiS00g9SPNQcpZaB+27K2FG+lgrDMq6JmzEUoKeEy4oyF8G96WicYfIhoWqrggpRQjjTv+YcpSpeVTwonh0U4ZMII+r/T93wRKtIS4Qi5vWJPuftfifTAqQ7UfpV7gRbd0M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 21 Jun 2021 19:24:05 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 19:24:05 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdkfd: add direct link flag to link properties
Date: Mon, 21 Jun 2021 15:23:48 -0400
Message-Id: <20210621192348.2775943-4-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621192348.2775943-1-jonathan.kim@amd.com>
References: <20210621192348.2775943-1-jonathan.kim@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 19:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e52961ec-6f36-4fa1-d917-08d934ea2211
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24705C4FB2B123315925F2C5850A9@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FS+MdU0YeQd4amMU8kOhlEQZT5AdxMSb7QYrHLAa9oS/A1I9Me7OCQ27WLZNvuhCuRu2/AwV/wirThaoX4SiTY2IuiDDeQgDCjC8Xev9SE1Ixd8yVC2nsNM0eIZaVXnkEF+YPWpfEJxhs1NrVlkdPWWN1KUJz6WJ8C7A/5C54pEcUZ8cEi4L0Q7LP+mBGl1pmBmY/b70HbJ8ea29c2ICWa6ZM6K0YPHrSQ3W7yrDbRxwyq1Os0GqcJOIIjr58ZQM4I6SzlyP7ih633QC0hANRjsXJjjcmlQGb8To9/QY2Z5nZ474KNaNWN5UqjimvoOW8BnNQgMOxC8nTkDys/D8cviDX++q0WJL+IweeNlR4wkTEJPMynumiIvsIQ4fO6en0VQiHBgl4D50yCJnvsvF5f83ydic7WfpPi+mM8T8pcGmKqhKrs2on27vmoTgcSjjVykH531N5rK1RL7HCsmDLTm9tLAUQSCSem0hVesDhSa5vpFi/GTdhq0Lfa4gRBzfbCI8SlfHUwCiyZIT1ryEMuOI9EkhiVSiuJImL7tVrXVOWCtYRsjoFzblkOeP+NEASXbhL/fKJ4qbnOeZS4rFoGCNoON57/HzJB87ydFcWUTI4aP6K+2avmBtv81MhQ4nX2+Z0zfqZupn4OOaqlCM9q/tjHN7iU+QB6uW24KMraU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(8676002)(66946007)(5660300002)(6666004)(2616005)(6486002)(8936002)(1076003)(7696005)(2906002)(86362001)(83380400001)(26005)(52116002)(16526019)(316002)(38350700002)(6916009)(956004)(36756003)(478600001)(186003)(38100700002)(44832011)(66476007)(4326008)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8x4KeXHiatNU7IU9Y3s4OdG+Qi9vFph43o+B7xb52zOzVt6kk0sav9HChkDZ?=
 =?us-ascii?Q?GOyY+j3drmuZBRHn/SvkJuM1GmZjWGyp3y4tU2MVLzjKcuB7+xgBGpuQ38cP?=
 =?us-ascii?Q?RaWR9O5hvXp4zMJuumfLGf8rQsp7zEuS/kTDRiQ+sCAFIRqibTaGXIVed7iC?=
 =?us-ascii?Q?MbQuLi09Jni97RL9svYtmGzkj9VrHyQQ2m9vdnrwYknyuI0VZftnMvZMGQuK?=
 =?us-ascii?Q?Hd2B084krk3SG6Ej81+HHYuyCVWS15dyQK9e10c74uyKVX8I/m0NvLHe4My9?=
 =?us-ascii?Q?T+G+cS5UytU3UbsQC0BNM/H8eqvXThkI+zAD29sT1Aj56hFUbszne1B8irCo?=
 =?us-ascii?Q?W6KcPEN67WtuGCF07n/hiSULAqJPzcDNUu2MZ3XxJyUHQTotnPdvLxxF8fo+?=
 =?us-ascii?Q?9rsLjeekwuSpsC2OAKZkOlggH1rWxePBQ2gN2oDGpyWmjPRaDkCBFUC9ep53?=
 =?us-ascii?Q?5egHH4BkVq3Qao0RMYEVItK+RCpddOY22payJ8Ej4p3vz8QgSSPmIWgMLH9i?=
 =?us-ascii?Q?y/g2rFcQ/wLWIpbWDPuSAKwRoBG0gNfH43CZDMTwu/cFTpZL4Bypf/91pu2+?=
 =?us-ascii?Q?/6qQh59E22rlEZ5WafRpBxRtAa1OvVSmCUqwS00ko1l5fjfdOO3sKPPQn+Fv?=
 =?us-ascii?Q?PfO06xpbGSLTNOUekZrL/NWyjeerGCXM7l54j4rN1rlTmrGpq8Wm1rIU0621?=
 =?us-ascii?Q?Ze+Bg4duUbnixbtT/KpMzW6r3P2q7vGbBrPFdWGbPFgoL0umds/XI0EsR7m1?=
 =?us-ascii?Q?YHfC8uQv8Nissoe4UNuc7vOA3NvsVRRXf56aecaOfEiQsLkfjXg54UO3Wd3h?=
 =?us-ascii?Q?RLk+b5xIwYjiPMe7qaFrLEeXPB4sNE8pGCkmCto12yY068RzkLyL2bNR2gQQ?=
 =?us-ascii?Q?7NVvQgF3AZo/yhR44Lnc6V2Yf/nev3/j4uBVgup7rHk0U84b1guIQH+FlyOQ?=
 =?us-ascii?Q?exJhzsoBnMiKMo3efGofDTvzGN0Abd7rmyrPRKTghSpE/mfG0FyAkKuEz0Eq?=
 =?us-ascii?Q?122v3PSvnr1HhVzohnM6RiqYicAMekDTRPod4DktbvM9Erb1aIYIcRBea5lr?=
 =?us-ascii?Q?ugMyMPjNCgE41DLCF7oCh3FeGajRBIWGyT+e/wqR21dmB18Rrb4k5SOZcydb?=
 =?us-ascii?Q?8KfkV+VaOx1u6W5NnYTNPzjhOJkzDWmAy4TVxyRjMEgVshtnHNk+FguvP37p?=
 =?us-ascii?Q?1IelioZ6E0BpU4OGw3AlwNv4WFU5t+2DtvpWZNGvoY1nuezX72f2/2ysz7ta?=
 =?us-ascii?Q?MRbbmx7ziTnXuW7Ir0vkflrG5wOdRIn29hecTeJBSRCbtwuTdrueXYk6+hXs?=
 =?us-ascii?Q?fvk+lE2gbqF530K0j75c2I7U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52961ec-6f36-4fa1-d917-08d934ea2211
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 19:24:04.9371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5c9PUB7uiz1r28RU18btjCdM+smt0PCHTTlIPzx5TRvxDJUF9139iZRWYOSKJbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Flag peers as a direct link if over PCIe or over xGMI if they are adjacent
in the hive.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index d1f6de5edfb9..0d661d60ece6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -232,8 +232,9 @@ struct crat_subtype_ccompute {
 #define CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT	(1 << 2)
 #define CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT	(1 << 3)
 #define CRAT_IOLINK_FLAGS_NO_PEER_TO_PEER_DMA	(1 << 4)
+#define CRAT_IOLINK_FLAGS_DIRECT_LINK		(1 << 5)
 #define CRAT_IOLINK_FLAGS_BI_DIRECTIONAL 	(1 << 31)
-#define CRAT_IOLINK_FLAGS_RESERVED_MASK		0x7fffffe0
+#define CRAT_IOLINK_FLAGS_RESERVED_MASK		0x7fffffc0
 
 /*
  * IO interface types
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b1ce072aa20b..037fa12ac1bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1244,6 +1244,15 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
 	}
 }
 
+static void kfd_set_iolink_direct_link(struct kfd_topology_device *dev,
+					struct kfd_iolink_properties *link)
+{
+	if (link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
+			(link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+							link->max_bandwidth))
+		link->flags |= CRAT_IOLINK_FLAGS_DIRECT_LINK;
+}
+
 static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 {
 	struct kfd_iolink_properties *link, *inbound_link;
@@ -1256,6 +1265,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 	list_for_each_entry(link, &dev->io_link_props, list) {
 		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 		kfd_set_iolink_no_atomics(dev, NULL, link);
+		kfd_set_iolink_direct_link(dev, link);
 		peer_dev = kfd_topology_device_by_proximity_domain(
 				link->node_to);
 
@@ -1270,6 +1280,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
 			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
+			kfd_set_iolink_direct_link(peer_dev, inbound_link);
 		}
 	}
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
