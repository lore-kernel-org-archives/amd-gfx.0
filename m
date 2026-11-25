Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AF606A323
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BBrtK2Fu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B7810FC93;
	Wed, 25 Nov 2026 14:16:19 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD2510FC93
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaqlP3Ym3VOUVP9ren0XcHQk+MHvFmObBpMmD5iAVmAcJQpz64qN/NJkXeWLmTDpqALvYH4PfABC835C1mHNedD9foCEEXs2Z5KzlhiiskCzWOHxKN7MY7SvPKDHYbIDTqjcl3Cnr77saAPMsBmS7chUefdD93IcXqKe+rwgUuJvdcKWvCHtLQXZKboZBgmL7ttFFJzPwdgKeI4Q9LUrjLY2A/2sfNi5wnULKKaOi2OKC2AsI8RoMm1PbYtSZ2y90xHoS2rpRosxYeg02TAo8HoX9Qd8dWiB+am0exuE6JstXHn3bzx8V2FbZASSIgOpDS8troGoral3QHoCjp2/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=634RbnCdVO2/iNO4bVVRxeSAtEaQQcL+i5Bma0EFwoU=;
 b=pccBKaewgTYF3DANsayiFvt2V81IkEWGNggVrpPeErUiJuIegC3ootNfCYqAwaQZdg1R6fVYGyvWEKYHwLqCGWl5KgnzUyHGoQ/f3Mi72yy0wvJJ3DIG1xqTVg/MLlkNSo/jUgqFhYDt5vC6E05ufpzf70rr2RB+DWuBX+9QHgZQoroMx2fHZQM4LHI3NLA/sjfOfDgNxEdhtRWytdfDW48nbOkg34QA8K8MeicSM7NLuFSaeOxlfWCypjKiZLH9HD3lF4FHHMK2d2QZ2EcW78+yslfBvtJjhm2aRCsjf7LFBkQByUZSRTBk77n7p6aF5G0Qod5H5HQA/b0foXACWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=634RbnCdVO2/iNO4bVVRxeSAtEaQQcL+i5Bma0EFwoU=;
 b=BBrtK2FuJ1rDYR1DF9nHP2Ka8SAn2HPaFvj8bYWIr8YBXFXZEBbU7toHTIhvxfd8Uzh5aaGxixc7MJ6vzWDStVrqiiXb+AXAu/ehqyelY/p7Wd8rlNIq68Qqkn3+gjfjcxfoLC/3E9+cFAu03MpUMXObWdFlvFNMsRcsIOHpibU=
Received: from CH0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:610:e4::22)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 14:16:07 +0000
Received: from CH3PEPF0002457D.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::a5) by CH0PR03CA0197.outlook.office365.com
 (2603:10b6:610:e4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 14:16:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457D.mail.protection.outlook.com (10.167.252.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 14:16:06 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 08:16:06 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Add checkpoint handler for mqd 12.1
Date: Wed, 25 Nov 2026 09:15:54 -0500
Message-ID: <20261125141554.2195270-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457D:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4847a831-4f42-48d5-5407-08df4afea580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|261022113327099003|11063799006|56012099006|261022105027099003|261009223027099003|261028144727099003|261022115727099003|261026135527099003|261026140227099003|261021130227099003|261021121427099003|261021135927099003|261026130827099003|261102123227099003|261021133027099003|261021123027099003|261022075727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: HgfyaWTTnY/FvK/VVZsJKm4mR7rLHpbLU8jvlQ7kEH27d9IbszdjWg74V8LVdMrkC60Wbuj+AbKsxOEv2B44dlvMlQWioPWmWr1jxrcP9mXzyb09VMx3pebT3wDxPRf0gEaLIm1T2NgBahuOp9OBLd4sEMufUzOzgMgOWHxqhyHNlgO8N+j7ANGIW+1mDZgqEMVEHxbRWhUdFoC/8iFwf4tO3QjZIgi8fbklV1bebUS4NsXrM096rHXnjjfdSB65BwcU2ng/5WLud2XPMy9+2R9Nb62ustmcGhitZsPYhVNeOIMhiwwscFYsBFEA8glGN8IZn8mqP1V4pcG6EN5I5AwncAW2ufjqylriuMJBcHeXIZZ9o0d9F6b63pYstiGjcrWN/68wCurEYloOf1UmNk9gv5hXMJEr4EuED9wOJ77r1fjZCzDJIOczeVQ5u2sDlgTFHQySV5n2Akq82XQniIaTsR8fhbJ/XK3aWZyLQwt5/jLC0WE0p8i+sztsDB8dy9vL0viJ8STuphukkr3BfSiNZ6/80yh8efe4yBfBh23QTB0FHgGDQRiboymLv2bs996yfx6aR2UFEJyJ91rnsnnCgr3rZSeVrl83OmXPKDfpqk60dRAlW/oHx2X2fRaO4Ib7i3CaOwoh+4yt4Sh23bNXRZ/VgZjU8lxCgll6TQNRxu9RH6pe1GnJwwUK3kOD3VPEJNRKJvAIIdKygALxiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(261022113327099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261028144727099003)(261022115727099003)(261026135527099003)(261026140227099003)(261021130227099003)(261021121427099003)(261021135927099003)(261026130827099003)(261102123227099003)(261021133027099003)(261021123027099003)(261022075727099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LdYitGb/mEmlQyuuAYogpxiubIWkd2mFOiRlEvI9wgYcctco4ELsp9UK2U0f/xz4/oRaieQHzS0w6kBmsOOLfQlcW/LekclXwIvznDy0r3wWP6oi7+6uRFQa+JoMDbRXHNGuVKmaAszAsik10MSCoMgt05PUEVKINvcrAbVlYn3LyMxCfkI5sIAYmX5/7fZCDrblPFl3m6J6FTnUWQoR3ech3zkqykcb3baNmKWT5GFVC1O8AgDdB41R2OpqRigIX48XaiFJ2cZFP3Ct+gaSHM9Q9aQTLW1p2LBvMQSsPodOQ7djGVfGxECHp3FdWB156ikYK9p3EXRU+L3XLma0DZdds7zyTXk2kj95wDadtrFyq6v4sJnq/IT2OPzkVSG2FzMGgqizbSpeu4GePAFcbWID5Tmsiddtei/v/pTZMinjpyikQ3MvkQJFBvwzEHYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:16:06.8114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847a831-4f42-48d5-5407-08df4afea580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For CRIU checkpoint, we need a checkpoint function in the
mqd manager.

Add one for gfx 12.1; no different from the ones for any other
mqd manager

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index e34103067fa0..305d1d3a0e01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -671,6 +671,15 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, void *data)
 
 #endif
 
+static void checkpoint_mqd_v12_1(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
+{
+	struct v12_1_compute_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));
+}
+
 static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
 			       struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			       struct queue_properties *qp, const void *mqd_src,
@@ -766,6 +775,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
 		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
 		mqd->get_wave_state = get_wave_state_v12_1;
 		mqd->mqd_stride = kfd_mqd_stride;
+		mqd->checkpoint_mqd = checkpoint_mqd_v12_1;
 		mqd->restore_mqd = restore_mqd_v12_1;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -813,6 +823,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_sdma;
 		mqd->mqd_size = sizeof(struct v12_1_sdma_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
+		mqd->checkpoint_mqd = checkpoint_mqd_v12_1;
 		mqd->restore_mqd = restore_mqd_sdma_v12_1;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
-- 
2.34.1

