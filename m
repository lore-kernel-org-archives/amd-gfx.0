Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302E2C27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 10:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3F910E065;
	Tue, 11 Jun 2024 10:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RxfHh9HF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2652710E57B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 10:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCw3pBX2XBbok0wY+2+pPSZxUyBP7Nd12OwlwTWYx3Aw+mVBKHduE97lrJ8BepN371r8EZ+aT19Dgx7xIuVvPWVg6hRai548uWNHCywO7QElsOaxo8BmdGQ84PSTU9JNF8CHL5GbfQb1myrOFTY9h8/m+g9a9SClKBrl4GlooVlbPOI/ZrQtmxwJQAFDqjQalZU8VV0WCvM86tJo8x56mm/PslFlMJjd+P5NxTVRJVgabiTp31jKiMr+FH0z0bqwPbS1HIKzUwB6fgKXHEtG1F7B+LIVnFgZLMdktEvvhgJdUDPQDYITOLbIYuhpla7V6AGREcthOID3csdz9TQldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk8gNzxH9/9m5QWiZwiLIyVDAjeKWpVMRmxyBgduoMM=;
 b=WUpxBxoDCUdrK1u+cWPcBJFDYf4AioJ5hOMAJEMD6v5BAxlqC8E70dhn2zD3i84XQPd+hcwJpca8eLzbGfaTRqBy7urLWVGrnpHpyS/AkIgLNtPhvkANZq21oNZvM9ocJzSNwBEr7grHy914ZexfEeOZakZBFa572wRQ6gAFIisDQXgGyUwlonacFraKVg2lXcJi5YJthKAL32GQru2kiRusTnSsnt7QFTmHpMR1yO14BXkFBSIT1/II1SiF0Am60rdCPNTurcaVnek2MahQQ98xteoaWDzcOlh9NaxYq26vwpL3PdJE/u/Fk6Q7RwniRG9ViFDJVKE7OJN7xpS2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk8gNzxH9/9m5QWiZwiLIyVDAjeKWpVMRmxyBgduoMM=;
 b=RxfHh9HF2lt/6yIvwVfFFqZGrX1EX9ge7GujyKLpUnEUqLS3u9LgUiGb6on1B2fBnnNSg19FP1rLdNTXu0syAjgcXTX0ZeqK2X913qjXEBzzQ+BcHxOtatR1yj1nfVw76O5v3EMpqXWDr3W5UUl5Beuy2405V2Vd5Nt07Z7/pTE=
Received: from BYAPR02CA0022.namprd02.prod.outlook.com (2603:10b6:a02:ee::35)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 10:06:58 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::32) by BYAPR02CA0022.outlook.office365.com
 (2603:10b6:a02:ee::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 10:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 11 Jun 2024 10:06:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 05:06:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 05:06:56 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 05:06:56 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <JingWen.Chen2@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from jpeg v4
Date: Tue, 11 Jun 2024 18:06:55 +0800
Message-ID: <20240611100655.227033-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: dd11aac6-8c7e-4a7b-2741-08dc89fe3afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Z0Gk135iiAC9H7Xn6rW4/xA7ZChXtdnkBC34m2zqHKtKw5P/Y4CupXL2opK?=
 =?us-ascii?Q?+6bKnaS+BSkXVdSny2hekanlRh9yXplZ/vG4uMEfaDY4olTwjzMZ0F2aXBaW?=
 =?us-ascii?Q?BPHLLY799KVrKkfn0tTOk6veNoOHyDH+RT/QoU6vyFl6xNoyeocahaW9dHKm?=
 =?us-ascii?Q?Mpb8cg0azLa00zau5vZGht195fLlDTxMLE+WyCgagdtVPE+deX205ss3xDR+?=
 =?us-ascii?Q?6pLvVaoXwt4DDwT1kJaOp92nwyk+xrYKQPXeniSZu6uq9b8aYhRvxdoasoFP?=
 =?us-ascii?Q?zfCNGJly0TWDBluM6gZvfxKcavAmrQqLpoZCEJEODei0odDsKLtHJs2J9ojd?=
 =?us-ascii?Q?lqx/OjofrzfCV4V5HO/KUlgks4CXMaNNgL80jr9R6XRP2br36gwivmlB1aoS?=
 =?us-ascii?Q?Ry3pVdY3zJd6+D+xfjPSzatmpkRYH7lX+XWsHb67fCySoqPkPqoahlwuozaj?=
 =?us-ascii?Q?a1dofvx5+PbXu0NG+RTn+NHGXHrgOBJXGTQv/uOxsRSd3MJxxkq79i/5XEFD?=
 =?us-ascii?Q?k59kTkNX/X8DW+9Ep5wwLGOoq9NG8f0y69Fcoq1Jce+CO94qb/N5jrE2wC7e?=
 =?us-ascii?Q?Yi5n10KNmxpSSRgYNwYqRwxTBgamzctFS+Dlgns8YlkAg9i6zojlXYNcM/OT?=
 =?us-ascii?Q?RIrLufzn9PNilPXKZycQsVZSjXEwawkrqgMB6kn95wZtR837FHH39tTVjs1U?=
 =?us-ascii?Q?RB7CP1SCAehwDlABQYVMpiYifHfRtL91xn9y9jYpSsuvj7MCicz3eQLdBwiX?=
 =?us-ascii?Q?QuGTBZ6ZCMBRW0joS0rRhZ5jFWxqSbPADrnzNhAUvcdy31Zlc0nVdNSPAG+j?=
 =?us-ascii?Q?fn3yC252+oIeB3lOM/qiIt3DIA/bCigQS1h45QXDmV54G3dZZam4bW338o0q?=
 =?us-ascii?Q?tSC5vZ+jy2vczmkwQFOorfkCWEFQ4bcTiVE/c501kIqL2nf27AXYEchaVbd6?=
 =?us-ascii?Q?YabDVxhctc3uGpCbbgchJc0FqKjsSssa+SCl87EGMXDRLDvtUrsui2Roxlnx?=
 =?us-ascii?Q?fXgOHiAHJlXz9XhTz3A1+N6FGe6la/UF2DW6szNIDSD+6F9oyqXSDweaD5zZ?=
 =?us-ascii?Q?KxtJVM0smyzBlixlpO3ts8ZG7U4/59bLsmPMAt2Q0BmcnJMJttvXwtpSIlQ+?=
 =?us-ascii?Q?agA5JwHbeQVAC/rdMU+gbnRmaaPEbaLhqOIdgq9M2JUW4WbJzWcMTCl3Akt3?=
 =?us-ascii?Q?BGzSo+zNMOH8D59Yc+XJarNF08IudGYF8O+9jbRXyrQPPeKLRjJ7qYTs70ls?=
 =?us-ascii?Q?E5BjTHd/OGp0oCVVgQajNVS6YThZY4qopFdJlQVYQ3ftFfUGiczGjZu/Ze2w?=
 =?us-ascii?Q?E/YcXYgKQXGQNKSr9pTFstkdRePeweGQIZACaJHSKeF/beN3YekxmH70pG1G?=
 =?us-ascii?Q?qkKXPpg3O7fdVTBGwwP/GO+6B7J6q0OrKA47y6VB/zjnpPs8tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 10:06:58.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd11aac6-8c7e-4a7b-2741-08dc89fe3afa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

add jpeg table size to ctx table size rather than override it

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..0edfb7754768 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -202,7 +202,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 
 		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
 		header.version = MMSCH_VERSION;
-		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
+		header.total_size = RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE);
 
 		table_loc = (uint32_t *)table->cpu_addr;
 		table_loc += header.total_size;
-- 
2.34.1

