Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF8CCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2BC10E772;
	Mon, 18 May 2026 09:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uXyQg0XW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F92110E770
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 09:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPAZ5t+nJuUcfPfYHvY8L0FJEGcqiqngNaC+gRdb4J29BBzGdVhv+nLFYaSg6BGNd57fRDRa4zzXgUaARA2vwNn4TvGbC5MB51j4nVXMagf2h/K1PWA/llP6z1sNCLd3vlnfP+0yTYKnVI8kr/wqNmzcwx/MiPQJVkRp3i0M6h86Fy8whdplU/qrEyvcjbfRsn5KQuP5h+gZmPwEEkY5dkY5QE6mECNhHvAIwT4GepF8uMdNH5Ukz5eJQ1jV1dDlBV5jsZe9afJEPGKhM2xaGXixW+I6EpJPAeBjQQ2TCpzoZhx6AzTAKQzigwjDPotHfTqwiKlQ8QK7ArnCIQagag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfmZfQZ/nD2MZog3M5irpe3aJ8Kn63BRgLxt6hnxO/k=;
 b=jigP1923MjgdnM2nLRidBmgLBW8xBDI4dayxi4oesXKqa6U6UoeyppMOz+GsYvufrYphQx6QvK1wiSBi8aX49D2UuWdGYATsaDO6RzHdWUGO45QpejPetrSYVCPDKplTr4RgT1wjbCbW1q2QMp+1X1ak8blBgNqh5SDzdWBRlKMKvqfQCCHi/RdtG+5CBDooPGWI5jzLiKoeZf3BnpnUytZkiAhaJT1KBThluXoz7V1Cgl85ijWAlbWwQ+hpcX2JYMm8Tvj0bdtY2DCWUkDHaVWDPLZ7E0UVC0NaaN1cw3GXyNaWwH52oDUgjDg1ToaVG4D9IAK01lei/jAB0AJl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfmZfQZ/nD2MZog3M5irpe3aJ8Kn63BRgLxt6hnxO/k=;
 b=uXyQg0XWW+WqWHfhYcA4cVzwgIzuCDIcYM585s42dPtQRlsvUFi/oNUQ5IRLRe41u9CGM8Hht7KJAgG3kNp9NST4SJuQKnRzfuZyTOYuL91Zc36mVhT6+O6lzZ45d4hwWC9tNSzUnqgkpZo1T+z9O/c2hFtKK5ftil+oPBvqv/A=
Received: from MN2PR14CA0015.namprd14.prod.outlook.com (2603:10b6:208:23e::20)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 09:41:50 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::50) by MN2PR14CA0015.outlook.office365.com
 (2603:10b6:208:23e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 09:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:41:49 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 04:41:47 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 4/5] drm/amd/ras: snapshot remote cmd header to fix
 double-fetch
Date: Mon, 18 May 2026 17:40:20 +0800
Message-ID: <20260518094021.280968-4-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518094021.280968-1-Stanley.Yang@amd.com>
References: <20260518094021.280968-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: b60bcc6a-7328-4d71-d662-08deb4c1af8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UL2ecW/17WCTAQ19479yuFpFRfPZSStG2FqT1hY+BELqBhOkpRsifAcfFeDnO7stKDuI7O9q6aW3hVGmdP0dQAtLEq1nJjEnz89Z8ZvhtMRfhq45tPtKmjqLnWtao2GZQzeXcF/OrLY+sXRS9+9Ycw4o/awXrhPbHHXUe5XqWLB2Cw4olSslD8uk9Fp3SMMgkD9SiA64yBSJwQOC2RTxZUehxhWeptgIJPTtDVZ+VsnexebT0OX8itn2VVFq8pm4YfIh/5+8vL/0u5ovUJNKAyGogoB6EsSrBBaUqx28hYvq9PuLEo3eQYxcb43UxOQ2M3yn1xwAvzIOlyYl885Grituq0uSfiNjbCpNze8zcNVKO20DuCjqpa+mSXghHsZlr+Dp+iMa6HxhmfhDrJwErZu6KEwQ7lMTeIgLMxwb4kyt1Ten5EyMnU/tMZaP89Bu0Gsibk2AufbK+7WlgGOx+istZU0Ng8dGjFzreNZItygpFaw+/Hx16PYkBv4snl0Y+lF86FNJD0tig5819G6SGbKhWJ1780Kyc+OD3aICANRVbjc9qZJaThZ4aSGb3VEi9lqxVDZIl5sOc7fqHkNunzamUvmp8VjFY7G/Sk0CRwMiyndTQ6JjopfD+3SX7nnByKVYmUaHsltHS+xFpKVjrQd+eWavOJKp+wcMXYJPyEEnCMTVjjiqzC56/qLvCH7w88tdLp2oh92yNibEbQ4gMDR0zxC/bDiZP2/xCGwipjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lVaaZswsiclCnFMC8s/tvdIMYMNIu5Xn0/y4Sq23r2+EsZVdFdrpkfvwYLqS+gZf5VcasYq1VfMsb+Z5HOkbQaRfY6ZBprnJ+I1OyUvqiH1N7dyNIapH1E4456MIupP3zQeVlbzNPA0zuu26U6iuZexOzbldMpfWGQNMFiL3WVYLbPVwrHC91PbfOMKDCVqGhIDHYItJ1Tm15M2XTpUpS4qHmLqQVrl5iYCrVx+4szdte5J3jaQdLyEoezR0/quDUcHx1XAhl9F5sKEA2eg8/BKc1yus27bLbtj24cPgvuaE+pPadO8mLVREmgmDu+JF6YQJRE0vrEGDElGSHvcE8wWLkqc8owIiDFeEFfQXKpHS6i5XtJccVTl50AwwWAz9GBEfzRX3K+hBGEUMZNVVPlrZhvOHZvA1L0jveJmPgErmZ+PEbz1TEABoThsytq/r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:41:49.9875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60bcc6a-7328-4d71-d662-08deb4c1af8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

The response header lives in PF-controlled shared memory. Copy it
into a local struct once, then read cmd_res and output_size from the
snapshot so the PF cannot flip cmd_res or grow output_size between
checks.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef39..ebbf92a2bd94 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -92,6 +92,7 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 	struct amdgpu_virt_ras_cmd *virt_ras = ras_mgr->virt_ras_cmd;
 	uint32_t mem_len = ALIGN(sizeof(*cmd) + output_size, AMDGPU_GPU_PAGE_SIZE);
 	struct ras_cmd_ctx *rcmd;
+	struct ras_cmd_ctx hdr_snap;
 	struct amdgpu_virt_shared_mem shared_mem = {0};
 	int ret = 0;
 
@@ -108,15 +109,31 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 	ret = amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
 				shared_mem.gpa, mem_len);
 	if (!ret) {
-		if (rcmd->cmd_res) {
-			ret = rcmd->cmd_res;
+		/*
+		 * rcmd lives in shared memory the PF can mutate at any time.
+		 * Snapshot the entire fixed-size response header into a local
+		 * struct in one shot so every subsequent decision (cmd_res,
+		 * output_size, version, etc.) operates on a stable copy. This
+		 * defeats double-fetch / TOCTOU attacks where a malicious or
+		 * buggy PF could flip cmd_res from SUCCESS to an error after
+		 * our success branch, or enlarge output_size between the
+		 * bounds check and the memcpy below to corrupt the caller's
+		 * local output buffer.
+		 */
+		memcpy(&hdr_snap, rcmd, sizeof(hdr_snap));
+		barrier();
+
+		if (hdr_snap.cmd_res) {
+			ret = hdr_snap.cmd_res;
 			goto out;
 		}
 
-		cmd->cmd_res = rcmd->cmd_res;
-		cmd->output_size = rcmd->output_size;
-		if (rcmd->output_size && (rcmd->output_size <= output_size) && output_data)
-			memcpy(output_data, rcmd->output_buff_raw, rcmd->output_size);
+		cmd->cmd_res = hdr_snap.cmd_res;
+		cmd->output_size = hdr_snap.output_size;
+
+		if (hdr_snap.output_size && output_data &&
+		    hdr_snap.output_size <= output_size)
+			memcpy(output_data, rcmd->output_buff_raw, hdr_snap.output_size);
 	}
 
 out:
-- 
2.43.0

