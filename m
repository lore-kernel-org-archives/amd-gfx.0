Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBADC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 09:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150C010E1FD;
	Tue, 14 May 2024 09:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+Dusrps";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1968510E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 09:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgulex4VWdIrPM3v+cJzKM84p4XiurX+Y1yk7debGyJrxfUoTEdUL/zI7xVit5HzGHEIzJ3pgyE78Re6XfEEicBFSE470w7iY6/HUedOjFcJTDFfO680zXsowce7S8oGTsERMV5JZbdv8bp+5Q8nqzwaMLdi+dA99/+MY7QDCmKj2H1HDU7ybP/QixJvnAE7Jkrc5tU3ptctQPBSSfbgpolY+2TUPlpUaHCPtmE6zNK30g+KRWj8g7plu2r22CDgRdG0EgxzkMP1TkQ5CcnH2qiywDbkAZidmTq1NA9vykDIK4MWNYTVNYNWKVErAfrenbIZjfwdGb7ILPDH9KGTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCvTWFr/9PP7nO+qxsaBieNr2UmkghvOssZc0TAheTw=;
 b=DeaftooJM3+2qiqSBPo5sEjde77PejimUYrr9NFN+QTHRnBWvG3tKCPceZKAsq9A1lxiYqkhgFxKChpgVOztndtdT0+rQvGtpn6HYcNvFXCb03DEGE3Iv3/2yKqd7T/GbtmI7jXKRw+Rwnc5DBrBIXE9F9A2J3ODshKA6B0jm0OJxQw2ztD0dcsTntlGm2GnQ/dXLzmdhWwK74sVwVfupiy1/ekjT8QGdL3GZjq4+mnOc7OlWJA1erKqrhNd7KkBfchMaLxHeOuSTJotMXyGN92rcQaVGlBBDYN5Ckc+FVUEaZkBe9ItSB8B3FIjSYbRY3/5cSwkFiIM25wlezhOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCvTWFr/9PP7nO+qxsaBieNr2UmkghvOssZc0TAheTw=;
 b=A+DusrpstDUuBlPPU2faH5yCJYG5HmcnGYNVVjrWC/2s3diEOw3tPnUGoaOaWXcta4Q6nfb9S7dQ+h/WjYtgf/9ZZBySs1GKMJu0/qhDLewEURJVjgHymnZ71qm2+afS5Gwy1rOeusJO2zYT5jbWZ90E17F2jprlCFX5R+TJxLw=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 09:05:40 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::20) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 09:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 09:05:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 04:05:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 04:05:37 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: check specific index for smu13
Date: Tue, 14 May 2024 17:05:36 +0800
Message-ID: <20240514090536.3655966-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: c875c11d-ebd4-4c56-714a-08dc73f506fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wc/PESQBrrONoIygmqB0lQr+9lyErdWL2NdXozqspEavjS4/m569T5NTRs9V?=
 =?us-ascii?Q?d8yx96hHxFsy9dlq2NqlcJU8NTYtMDexmfA6NviIBuDE2tH5UcfZ4pin3+y2?=
 =?us-ascii?Q?Rx4tle81AVSf+KTIHB7gcGPlDVJyLVpjXQi4PNGsUjEdWwcPooJBkQNCW1HA?=
 =?us-ascii?Q?vXOXx62XRQ06zjMkeYBwexhEebw1cfdDbES7HhAmAt2BBgNsUJSyz/Y3DXfl?=
 =?us-ascii?Q?OBBfJjHx7RtUTYrMPDEXkqb+w3gEfm62UgFEaZZaCNb9FcKjxrlRBL0ruD2I?=
 =?us-ascii?Q?mN2qpVOZxIKzpbFoIUETOwvXVVEUxGOyV+ZDUXQ/kR5L1EoSO2EDuihfXMIK?=
 =?us-ascii?Q?W3CgZBGKfiy1X0l27KRI+dU2FY1CJbKoH3991xqvY1OIt3BogErRcbSH/9K1?=
 =?us-ascii?Q?ebL2wNKvI+mgQR4RgOTFG5lWCfIpv1BFLnDb9EpD7+83H4+DmVGqnDA02A4V?=
 =?us-ascii?Q?kzdpBajzR5RNNq+we1TAAdvHHAQ2nlHXxFzmBQrhBgsLgE0OApZY8Z2E3io8?=
 =?us-ascii?Q?M238tsRP2GPFhI9D3rZhYbDLVkUeCRRVQMpQks7ygfVVnQYkETAPwNGg4HuQ?=
 =?us-ascii?Q?yoIBMGPRqU3ryG+8iGWN+pxGgTOT0KjfeDuOYot92qYN+gHK7MYJEFSrImmM?=
 =?us-ascii?Q?BeQJ/WfqKOCt0ztFi5x/glpklHaFld73nsSBEET5AEfv3Q82VTe9X1BdNwbp?=
 =?us-ascii?Q?LPzyGWFsBg93Tu1FuyZAh2jNKCmRi/layDO0+AWb5qLdxtMBk2P1Xthrtrp7?=
 =?us-ascii?Q?op2z89ypGZWxscJY1/H0b8DIvdZWUJI92Ik+spip4rrAw+1qulipeG7ZGR71?=
 =?us-ascii?Q?DGYbuIlBKx+LuMqV5ab0/HnM4hN/7J62yvxXV1jomaZbsWkmhc294EOdUtCD?=
 =?us-ascii?Q?epHMf9BjFUSPm2Gke1s24J3JpuVcR1305Eov2RSVD10JlyemjaZwFMutOuu/?=
 =?us-ascii?Q?3PZEiJP545I+2VLtEUPwqtdJgUCCdyiy/0K59YJxVt6liP8SZxGDALzQVeG1?=
 =?us-ascii?Q?yDwvjnKg+O2oYKgsqSwtAV0LSn0pj5X5V7TcvB25eF1vpujF6/O6828iscEp?=
 =?us-ascii?Q?HanYQUKc+sK6zM25QCGhk0lzBE/i0liXC2yRGRyPu2C5Rate909UpXDaW0me?=
 =?us-ascii?Q?94GbHJUh1A1svz3L10JboZZKUKlSSIgpWGFORklj7sYq8+G3bcja/FbCWzoh?=
 =?us-ascii?Q?DyR0FB+F7yLUIOe6E5urm2hIsMjceWu2IA/OeiUAl6Oh3DojYXoj58Btz0N3?=
 =?us-ascii?Q?QRaPUksNq+0feNhKJCJZoncMX09BTjpprwVm/N/AKcazt9dk0b12N2qw2vJd?=
 =?us-ascii?Q?hu1LBzmH9s0C4NmyHPk0If9PHulNFCaQS8Rprwk0Nyd/5H9S/XjkrM03Z6km?=
 =?us-ascii?Q?G9rHHRZtb3olsObIY5csa+4SB26q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 09:05:40.0038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c875c11d-ebd4-4c56-714a-08dc73f506fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

To avoid warning problems, drop index and use PPSMC_MSG_GfxDriverReset instead of index.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 46ab70a244af..6d691edf74fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2330,20 +2330,15 @@ static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index;
-
 	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
-
+	ret = smu_cmn_send_msg_without_waiting(smu, PPSMC_MSG_GfxDriverReset,
+						SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 	/* Reset takes a bit longer, wait for 200ms. */
 	msleep(200);
 
-- 
2.25.1

