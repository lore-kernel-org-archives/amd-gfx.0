Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7D606A327
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UpclON4r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D483110E11C;
	Tue,  3 Nov 2026 14:15:24 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3231010E11C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3Hyvhv1dv3FTnNksc4l8+JgfJf+In92WPtjdE1wEM75/mmRTsfTPSXCwsso+APRZWmdsloyHIQh8oL6YwIWlJaU1yRlZ+UC1TpQpRG+JBwnhok++OIGN12an/PywWkh6OfWEGl7yHVrhg83oeqsEzAWJNWJmH/AsEUIrcizxyCOI7AQsmcCy5LwAM1RxZ4a1Q5Hu+3bg305pEDiCdUghOyxZ047i4zAWpQal3O7ar3sVenVpDIcLjbodg9/vfm7yXBjiPRMJGl0OuT/bVVmtktbhFGflmKBaFPchRTNCx6mka66AAnY0jks+eo/dK7Hv5yuGqpJ3iZQLq3GFlJiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4TWl4ehGiznS14XDdd0BZP6cUKrhjUoFb1IVgx7x58=;
 b=lNJ3cpRKkuKFqNeo2kvs9FQAzFKSEIgsXnxgkbnn9JZU9uxnXVhYMIH+tssVOI/siHiG72hPQSkLIWmPDqN09st//lkgY4HnKgwMjeSGzIRbeRBZicNfPwq1u8SvScRF7OwT5vnlXtjzEpntQfEfYGfnRa73R+x2yzflHGrGAXsDdr/E6e8PpQ+jgeVsDjk2MzxjGoAJOpojQdltSQnGd/f8/LPJMSIK93gt3LWhPHhslF/PBMR1QZNsePlCp4qDN1660jMOqgP8p0K7erWM188YEGBGaA2iV4M8jdzLT01bAZab4DPyj+it/BU7FnxADpc9fOFOZtCaSg37muNoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4TWl4ehGiznS14XDdd0BZP6cUKrhjUoFb1IVgx7x58=;
 b=UpclON4rkVQGUt1cly4Hz1Us/k0KVM6UTIv4hi61RxJFgWyYxspMp8XOqK3zUKKLfa2YNiiuVwr7EbyGmWhK7BMU7NPrPitvx/3bFgW2jum2v0ve6hM+nJByar30JX2TDj6iWekujUu8vcBvvFuqKGnl9fsIpZlIp3ZFPSG4qgQ=
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:15:13 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::3e) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 14:15:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 14:15:11 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 08:15:08 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Nathan Blomquist
 <nblomquist@gmail.com>
Subject: [PATCH] drm/amd/pm: track BACO state in the SMU v11 ArmD3 sequence
Date: Tue, 3 Nov 2026 08:14:57 -0600
Message-ID: <20261103141457.2558235-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 74446c2a-4928-4e8e-260a-08df39b4dfae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|13003099007|56012099006|11063799006|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: DEj2Wr1KD/NuC4+nM91DqJ98SttAnxuzzyot0/h6t3NAtUTBY5jDdigB26naemUSUrPhbqqI0GAnssPw6WoQI4QIaYXFw68B1MdbreT/sxTk6wqbeZtkAMKMmF744nRuK/0QSSEdg/NkvkDqSRfCPD+eUhWrWfuKY8r3FIhf6n8zSIkMTr4l39BXA/bjGZM8vbNRAZv34DcKMajWL/kPIc0ri2AlPiqyMDDMr2I8aoS1h8tXAGLgnXdT5NuKKP4RuZY3uSX8nEAmtyoirJAhjsUqGdQTZh9fGtjxbbUMky4ocA+V/puOh846eXqVCNHh8d0E383WE2oa7/ncqr4nW/RecEGDtzB+Q96maTXjFL4TJHdmXgwuZxxJMnGpK7NECOr96XcCyruq8f7HQ4l+FIy44MCfRI3/vkgwYpGOp6zzsuQ2WL8wOJvEVqSvC8AC+rFoQi1OXfPHxNmewy1IlyqLyuIQ3qSbgZT2WTTO9GbizSisU2yEdmeweZg3Te73/KZLN2Jj3hF3SOgHW+KbFsYEElHnRmsxbLczYhvfZf90ACVmSXkrARtnRzA/SQShtvaAXRl9KgdGV2m6kC/cJFWMACR+8+qAk/Ocpx4eLuv2enMogj+Smh0kk5l1/PcHI3sGe5WZr20YSzmd+Brk/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FzpjetBvuFCt+uj3J0OYedEHhez8M/5u037wD374NGUJAPK1+lJ3m3WOVDZ5Qp5mBKGiD9BCXWPkQKsarSurQ53Z3HsALTHbYaMpb/ZPl3Pzh3QeThotCyP+vCn70PQm9vjMlzO7mir4k04HOhix/vzm+u5V5Y2jCeqt7DATaFejjcOl18UwJUjaFfthP4K4UCwVDgQ6+bytOh/x5DjngaBDztauoiEiLMi5h77Fnog6mWAB542PSGA/RH5WVwYDrxXuovSaq747OdNSs04kNp5Ur0NV75qgN4Kt6AFG0u6ztlDQAoEyi0/r4+pKaNioFHBsqMXwk0UkWhrMYEJzJGuNbfkmEvD5iViTl7sl2W+pjPP37778okmNh3NXtpvYXluZdJQlLM9EQ/Z4GFj//trOanA9WeG7uQ8gkZDihZPUlPB8zmLCR0zIYNOnIwrK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:15:11.8518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74446c2a-4928-4e8e-260a-08df39b4dfae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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

On Navi1x/Sienna Cichlid with runtime PM, when the audio function is
enabled, BACO entry and exit are delegated to PMFW by sending
SMU_MSG_ArmD3 instead of going through smu_v11_0_baco_set_state().
Unlike the v13/v14/v15 helpers, smu_v11_0_baco_set_armd3_sequence()
does not update smu_baco->state, so the driver keeps reporting
SMU_BACO_STATE_EXIT while the ASIC is armed for / sitting in BACO.

At runtime resume amdgpu_device_baco_exit() checks
amdgpu_device_supports_baco(), which ends up in
smu_v11_0_get_bamaco_support().  Since the state never reads ENTER, the
"already in BACO" shortcut is skipped and the live BACO feature bit is
consulted instead.  PMFW clears that bit once ArmD3(BACO) is armed, so
the check reports "supported but not enabled", the exit fails with
-ENOTSUPP and the ULPS ArmD3 message is never sent.  The runtime resume
caller ignores the error, and a later secondary bus reset leaves the
device unreachable.  This shows up on a Navi 23 being handed from amdgpu
to vfio-pci:

  baco_enter: in_runpm=1 audio_enabled=1 armd3=1 baco_state=1 ret=0
  bamaco: state=1 ... feat supported=1 enabled=0 in_runpm=1
  baco_exit: supports=0 ...
  runtime resume: baco_exit ret=-524

Update smu_baco->state in the helper, mirroring the v13 implementation,
so the capability check short-circuits while in BACO.

Reported-by: Nathan Blomquist <nblomquist@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
Tested-by: Nathan Blomquist <nblomquist@gmail.com>
Fixes: 13d75eadfa1a5 ("drm/amd/pm: correct the runpm handling for BACO supported ASIC")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This was developed with help from Claude Sonnet based on an extra debugging
patch shared on the bug.
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 09e20d5ee0446..18d8b2105a663 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1419,7 +1419,25 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * PMFW owns the BACO transition once armed, so keep the driver's view
+	 * in sync.  Otherwise smu_v11_0_get_bamaco_support() falls back to the
+	 * live BACO feature bit, which PMFW clears when armed, and the runtime
+	 * resume wrongly concludes BACO is unsupported and skips the exit.
+	 */
+	if (baco_seq == BACO_SEQ_BAMACO || baco_seq == BACO_SEQ_BACO)
+		smu_baco->state = SMU_BACO_STATE_ENTER;
+	else
+		smu_baco->state = SMU_BACO_STATE_EXIT;
+
+	return 0;
 }
 
 int smu_v11_0_get_bamaco_support(struct smu_context *smu)
-- 
2.43.0

