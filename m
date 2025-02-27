Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40046C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 13:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EA910E1C6;
	Thu, 27 Feb 2025 13:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkEUmclK";
	dkim-atps=neutral
Received: from outbound.mail.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C204510E1C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 13:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5W9AQIhSuCxCY4DBrE9INKkgJ3K7G3gnCCgjyehz8KNHrkfigsyvsGXM7OK+m8LXLnjVLc4ZaVR64EB/RvnsVbsSnpxcbRSajy5KYejFS5eVUfolYg8MVk4q+6kt4yE8Y82XvWnBTiv5O8jnHugxabG3PBpN7Kmlqmue+A/H5nXNKdwTtZxL0acB//3+sBd/zGY3RGMgmzDSWb4iT2YixN6qmYcpu0WqkryFe2dEssyp1VgdjLFU14kRMAFzQPJFK2/smluEofEPM4DSNmeZpOe9pxbEG5xf6TjT0TFSY+lIefainK4Bo2oN+1h20jyYX4nFqsbEQLb7w/CMRM7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHSfW6JIPnkdbE8D5RFwqTcbuEWlgdQUvWTNh5UzCeI=;
 b=YviDfHNlZbBmItANc0OqwCEEskXZUu6P9Omd/SEfVIN8SpHOl3+QFHhTSllJsf1PtmJc5rkB4mzLEfsT/CqvhWGsEaIYDH+f4FtCc69QxK9x9YNWJzE9Hd+dJZfFIrhbhffF00Z0yMehv/Z8iGW/yVyAquVqZX8C1TRsXtVDKc2f8qhkMMyecKQQpzJy0luLQGfc9nHo5BeyXyIAarz6e4CRdhIXXVnSOI6pmF3HDJVhz6qRnoSLlPpZZB2348Nd2Wz1WWfffYfzC5BxSPR+AgWdO0Q8tmOV1xjS4uLjR/pxVsQ8jp4zws7UlaEF9dKJNSlQO8q3+KOTe8Gphps3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHSfW6JIPnkdbE8D5RFwqTcbuEWlgdQUvWTNh5UzCeI=;
 b=xkEUmclKKi9ZFYfQho8/gqf+g6eyAF/d6LUjiS8DYzhnlVRc6X76oZj/iS2oPtY2jrzW6yYvO4s9bSABdrfsH3TGsppffFrZY7lEwJNo8r603hPGEXADwX9SNj0mEbm+qtH6eqAxzlJ14Jem3QngEFvra5nauVDyUDNG6BTMKGY=
Received: from BYAPR11CA0066.namprd11.prod.outlook.com (2603:10b6:a03:80::43)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 13:19:42 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::2a) by BYAPR11CA0066.outlook.office365.com
 (2603:10b6:a03:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 13:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 13:19:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 07:19:39 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Set PG state to gating for vcn_v_5_0_1
Date: Thu, 27 Feb 2025 21:19:23 +0800
Message-ID: <20250227131923.812619-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc24ae9-1139-4a3e-4e97-08dd57316589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rh/huvxoH3u1MsxeDSUER8bfuTo12dK5tTDTYY3En4k5cTXXKirh/Qtb7PYn?=
 =?us-ascii?Q?f3OjZUDHoxaQfLteUeX+IwiFxa7XwbEMZs/Wf8hEgiKWg4afK/N/OcNUXpyf?=
 =?us-ascii?Q?DEpx44hRiqXmdt0ir6cgHqw097kfqc2SjeYo4G055HBgDv0EUcJusW4dlZJW?=
 =?us-ascii?Q?z6nNbnG8qEVCfRAmo8YOYBIFhEA+uXD0mSPuzEfMcyKfCNgLSOQN3qX8f1iW?=
 =?us-ascii?Q?s+DLKES040Kjt2Jd8e7CVwEvj2fiFavvyoDGIojoR5vB92S661I6jXmPGKyN?=
 =?us-ascii?Q?75yXXDJAOona7TbMrazjLeov2hXkkW7YjsmeldgRUAfGJcJ0rF159Hv2jDiY?=
 =?us-ascii?Q?Dlfhm+yZe8VA2DTiVayHrZVLlIg3R7aiAvjQK1l5xSId16YDE2PUWbMXQJ+z?=
 =?us-ascii?Q?cQJEVBP2aan3BmjaiJ/+5OAEFdUoOXJBaPbYiFHYz8EJVRkpJMk+gv4uld6k?=
 =?us-ascii?Q?QHmaqClQBQbRDR0wBtjC9hri1Yfk9lPnvzCyIiOiBBB/RZP298IgXo9cJvfq?=
 =?us-ascii?Q?OqREXtBixb57+DQfU28k0GAK27JkWI+k2PtplzrsHY22dmw9asAL3VQuXbt7?=
 =?us-ascii?Q?bf6m0uWZbz6Il5L4nzJJEkcHgnvxEdOqr+OwYcJE6yJBUf0HqkSWeZFBRpGd?=
 =?us-ascii?Q?PSTt32+cv2aOB+KGGbZv2+tEbmO3Up3bbF/xv/+un4wWiBnk6Yr2ox8E05dy?=
 =?us-ascii?Q?La6lofsOmu7oMMZdVx7MEqvEDgTZg9rJDipHQ6z/wVhpNgdBtg762u1EyE1L?=
 =?us-ascii?Q?DP2+vbgWFDilBh2CEI+9ikPcTau0+/X3vc6j2XtHPV8XC0iSm4dGzT0BgnT5?=
 =?us-ascii?Q?lgopQr4q9+ls2HEoRfS7fR3snIUdknWcK5aEbPcWwjqdY4Z+RsO8sDk1Vr1k?=
 =?us-ascii?Q?ZRs6sbqVto2KD4/HhvYMPFjeAYu8VTC/RPzHB1QH1dIRT/xZWKFUsS5+MGqC?=
 =?us-ascii?Q?5LKWelbkWZxGcI9ePzU4NjUEAJqfHkI7WDyWJ3h8EGS+JTfdgYIXkTQ5qF0u?=
 =?us-ascii?Q?ChP7eUSYbuQ4ldgEEn6IRRh4pD+fgNrwVtbKoZXAsg2/yUpZE8ubmG0mhBg4?=
 =?us-ascii?Q?XahvpzdPMkWUB7hikfzeruaJc5/oHBtxyjzU6nWRPjjMOxMdXzE8FwcRsffI?=
 =?us-ascii?Q?XWtlnEbROuZVbXlnQ/ZCHd35KqCHPCHdab1acRNKg7Yw9lQmxUnKavphUolK?=
 =?us-ascii?Q?fepBZGnpm8cUNtm8DyHFoqHoQ80RiyLvAnMIJLaCKGJEGVWTmDGH34qZSt7X?=
 =?us-ascii?Q?4F67zannAzx9MOmQ9NPFaSEFXADu83bVLkiR84uOxnCEJtRhtzwIPEBDp/kf?=
 =?us-ascii?Q?Ich3D8BO/wVpsgF/72o+wLGVt8VDHdLRJEEg41vNNIwLuNcON8ub3ieMwcgE?=
 =?us-ascii?Q?dDthyO42aAe7bqxsUxLq0A7og4Yr2wmgX7PgC1JLwPr12PW3uAgJBlhyLAmW?=
 =?us-ascii?Q?1MKfFUJzd18qcgQPw+UE7y1AnIZOWZlPq0tLLIdj8KMsZG4B/POzug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 13:19:42.3427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc24ae9-1139-4a3e-4e97-08dd57316589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

For vcn_v_5_0_1, set power state to gating during hw fini. Also there may
be scenario where VCN engine hangs during a job execution, then it's not
safe to assume that set_pg_state works fine during hw_fini to put the state
to gated. After a reset, we can assume that it's in the default state,
therefore reset the driver maintained state. Put the default state as gated
during reset as per this assumption.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 900702b1a3bb..0273157c2bfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -224,8 +224,13 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		if (vinst->cur_state != AMD_PG_STATE_GATE)
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
+	}
 
 	return 0;
 }
@@ -268,6 +273,11 @@ static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
 	int r, i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		if (amdgpu_in_reset(adev))
+			vinst->cur_state = AMD_PG_STATE_GATE;
+
 		r = amdgpu_vcn_resume(ip_block->adev, i);
 		if (r)
 			return r;
-- 
2.46.0

