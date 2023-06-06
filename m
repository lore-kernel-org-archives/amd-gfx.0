Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3027FC7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A723710E383;
	Tue,  6 Jun 2023 16:24:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CB310E382
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmeflmt4Zt4dlwibuaRaW7eWmyfQn9mcTv6tptJTjipfkcoMwirzt+8mGcxnw6AXWB2c3nSI0XA4XkQ3XlMlHJKgxOquhuUp3fv/h6gzHrB4I9ZYuewFLo6j2q+2j74aMn/KKZ9sC0UAv+uBV0AoaFgRyLZUnh27ZOi2msSVHUspTCpggqDljx9cVcs8BpYFhTQkedGCwbwvTvlfxEDGjfO5lnxXbPrueZEvXnokfahtiOoRthC+g3uniMVOtZ5oXiRc1p0Xc0IOgmJHQ1X35PFRr/c6aMebRde8MVQ8JNUpa6zgZ0/X14hJ6wRws0pb8mPCAOfOVGWx3HW61fccMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDFMlQ+pzDlDvRActCHKUTFThF3marVjDXlW0LQog3k=;
 b=h0BueTIKbY9M5XfxaTWbF8aN0Ac5xD25lORavuQIn63qEhgW/xjOntN039umwaUHMMRrAixJgcFqfdMnIMavXpnVerTottgClZpOQFP9XzphyFKKgc62+ChKRyXpeDnFB/9epj7+0oERegdbZRBjI39GeIl6uaGP/Cm2ccVjVH5j7s7O2sFWxM+VuNivTDpsYuH4MsW3cWawZ4f0cinEDgZ//BmxXVHaRw21YXrQRbarok4+ZAvegHLLa3Ch6e74xbgV+kleHlZk7Y/ClNVcZ3NTof2rrpyMF2yxau68iYJJDqlDRoc7P2BWiviknjSTCl6pX9fKajXVY3VxNkYG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDFMlQ+pzDlDvRActCHKUTFThF3marVjDXlW0LQog3k=;
 b=pRZGvPfwmzQvZLtXyhjpEjQTP8oDSvWyhOpRf4THyRzis50+zFY4WyDGrorj53NgTxpwRokKIGT918rOAzCw7GwHhGvsIfhclfZYMWgMoaJLkykQ+wFvE0K62PbgdQtc86pMFb1ChLWMIODfSJ52CPAVYsGWklTDJKFcmhFH/N0=
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 16:24:32 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::af) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Tue, 6 Jun 2023 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:24:31 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:24:29 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdkfd: add event age tracking
Date: Tue, 6 Jun 2023 12:24:16 -0400
Message-ID: <20230606162418.1862540-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606162418.1862540-1-James.Zhu@amd.com>
References: <20230606162418.1862540-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: e090ddfc-e76d-426c-6f57-08db66aa8258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB0SG8mKxt4jky/z8HxrUWZAckR/m1OZbEymS81t3E6mL2p1IxXVi5DyGC7npUOdR/AdQHcKR6Tlgsvt7DAyj6Dd0YfiLzVkvGkBztPP7mK2/VXIzm0PF5QS4ty8McMjx0oM0GvcENpwNACtJGYFslaVcjYtJAJ112zo9rDFsKgusLDdgvx+2HifNauEJTwP1+xQlHxAVjxlL2cd78IqxucxV9lmrgzWIvW4vBvhPo/JACfENvJs9kXkqBUS5UERQ0aI8Htu/VhH0QwArICb9hABewbx7uqv0YXTfgTH0p7r4SXijrpaZ8IAMMdtT8ig8nsxskF1lTGcjTh5v6yYEpMs9K0hWB1eNP74riv2yZ/kFfMpucZrki4GXziDmuAUltmALN5mSYWwNn1o5dR79ravhgEJ3tMbgDkBRjtQbOQBbHLnILn0py/6YWylr6Ubuu1IuEzGLMTYfnS3NzpKoUWaAUNVmzoe5LP94cb48LoF9k+HaNJLXDwj0574giwC9NI5TQo9KQ6c7nTllYPd1EdAhMV0ufsSkWrOkZ9jREzLQ1iuE4h6gctVKho6Ne+6iVU3f14kX2VwHScMpNMfqiP5pkwu68t6tAVdkeaNhqaLHkV6To1MJbekNdYxb9fT2XOKvqxogk4krYkh7NAQAXmKd+vZaIrKnZkmT3bCtXhCUUbx/7Sk7Ex+wUCITaocQH5F4axHttrWCfDZaU02g6IWyvit0g6bdi5XRWl7T5MJRPIPY8W+Cf9Ah2nu2xqCF9TxhsnRLPrxGiJY0qmQng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(1076003)(2616005)(41300700001)(36860700001)(7696005)(336012)(426003)(6666004)(47076005)(26005)(186003)(16526019)(83380400001)(40460700003)(40480700001)(478600001)(54906003)(2906002)(70586007)(6916009)(70206006)(356005)(316002)(81166007)(82740400003)(5660300002)(4326008)(8936002)(86362001)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:24:31.9583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e090ddfc-e76d-426c-6f57-08db66aa8258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add event age tracking

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1781e7669982..eeb2fdcbdcb7 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -39,9 +39,10 @@
  * - 1.11 - Add unified memory for ctx save/restore area
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
+ * - 1.14 - Update kfd_event_data
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 13
+#define KFD_IOCTL_MINOR_VERSION 14
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -320,12 +321,20 @@ struct kfd_hsa_hw_exception_data {
 	__u32 gpu_id;
 };
 
+/* hsa signal event data */
+struct kfd_hsa_signal_event_data {
+	__u64 last_event_age;	/* to and from KFD */
+};
+
 /* Event data */
 struct kfd_event_data {
 	union {
+		/* From KFD */
 		struct kfd_hsa_memory_exception_data memory_exception_data;
 		struct kfd_hsa_hw_exception_data hw_exception_data;
-	};				/* From KFD */
+		/* To and From KFD */
+		struct kfd_hsa_signal_event_data signal_event_data;
+	};
 	__u64 kfd_event_data_ext;	/* pointer to an extension structure
 					   for future exception types */
 	__u32 event_id;		/* to KFD */
-- 
2.34.1

