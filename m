Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0D606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sN8PaT20
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568A110E124;
	Fri,  6 Nov 2026 06:37:27 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CAA10E124
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 06:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4Fig1OAwvEi974945GmFJRmQpr135WGy4VHuoqYD1pskvQVJM3ysoOYWSN3RZCtQkgXvmrykZc3Wo3KtImFJ6XYeLi7tIYDxmjvosArL4tka+yqRUIva9HgAFReHwNyUotacfz/LJsdPk+QU6m5B7xnPL4P40vCXWPd42rR4ZRzs1AMOFO2C3iqeiwbVjrzx+59P1Lxn814We60pnkwJQmCQ8jwmJad4GPkuyt2Q7+z2HqdiU1iYix99vKlkSTEojpvhyici03oXaC3hkwh14msak0mjCkX8kOiDSj/8+DM7Gy9z3nynE1X2443O9kqkMo9cIGZxhhhuBEtHnWvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ/BIAWqoUgABzKUUXuxqcXzYSWy6jr3p/SJwYNOGqs=;
 b=rZCes/e5ss3A7WFbp1vlHmmeUA010jtyrgyB7eX1zEZz88mrXhuOsPWsCES/mSVZGtt5sRnSuu0iCdkLRSdp4hONe1XJSdU3AZNlxo3r8loCaSFaOPAqZXICCNJq0A7wiVR1/hWWo5PbWOKvc3HZwFDQn+U5NaKW6Q9r/94DauTfISRFM2k4j94Z56GwC4JCMze7Z0Z4kiNlg6QDlSrtL2w+N/zxRG2l2mQtTpoURiJG+QaruhJQr3dXqk9lZdx/tM9OLDpcOhkho6IFlVpACiVDA0qP4HiFQeyByZrtFeFUzLDY/o4NnsED4FAlDfz7GNbp84a6pOBas10TlA3k+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ/BIAWqoUgABzKUUXuxqcXzYSWy6jr3p/SJwYNOGqs=;
 b=sN8PaT20neI8V+X649IDK3hJAW10ABswFxBYEHrHb+ZQTrmT1oZjv+8EE+EqT2F0PfgsaM21mu6oVeZTyRdAehbIHhaQgMfnYBdMwmGmnL8bP3TjT9JCHQZ/iTm4a7m2E0RVoiKqAS8QGcE0BQMRRkMFeEXb5NneK/V9T/mH/jk=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 06:37:16 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::9a) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 06:37:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Fri, 6 Nov 2026 06:37:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 00:37:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fetch TOS version in PSP v15.0.8
Date: Fri, 6 Nov 2026 12:06:53 +0530
Message-ID: <20261106063653.1260596-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9fe1f4-c502-42e4-6721-08df3bd065d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|261022075727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: cbQ5EIcg18owt9rcXCiOtZSYnUzqeoBePibKBUd/2/nsRIfVVgv5MYUXKzW+jocWO6MWdhA8mcd2PtxN4VJcxOsRrKsiOv25+0FcK9hsOF4r/C7iySEiIMSG335KDM8EvKxS1jmbJ1KBINCe/jWSCLEqz32IJzlDwlVsk/5XX0zoXsfGxovnO34XXbTVZ9cfISXzhVw15kVPhSh9DWltcisl+PNQrsix09k+//nsPEaX0fxNgztn4hWk4axrj+pcbH/qRUb+1E0CM+t/4IUa/zL6IjpLbP6KGUa4Ek5+XM5PLnrdOl35/rz3BYj1fnpImYu/VqxTPkCjxLuJZXip5NC1PODpblYOG5/pzRW8EewAi0SY+cMkm+95KN2zDY++1xK9gZRLsSrsA90SpV9lbOICgc+tOOEad2L4dMkbA7NTaPFnmBUjQTCA2sPquzXlvPsojB03M7jrg4/LbDd1+HRSDJ6hRTEFtss2mn4TV0AZy+fhNnHF1OxjP8yJtUtZ55vCDWnqicWa0fkOyHKKQVgMdGq6RvRLmsZ3zKT4tmxIkpI/Bb1I184Zw3YUY8SFUl2QEfnzwLpa2ZmtS83YwZg2AxNmvea3gy9S0GNGND/WQdWsAKEFGn3falpzJbsjReQZCqkeb+Djinx+8TzIwW362VkK1QaqFpHjl52FOcr3RrTTx6m9LXldNjwtM2pzrSGNe4vk3ABJynJV0ofU0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DRbXzRRRS+9WowuH8sqYpQRQkN6GB7VwXnAzq9aoWWdgT1MQa6sSPgFWjqVasfvD2CMTNogJQWe66gM76jhdOWKcI+bnHrtS49y3X1RQbWActUik0j0F01AAI0zaCpsMVYAM9smrnWDxi7o0o9YeF0aGdb0dGTVDQnB8mx/UeWBgXuGl+aBnCDd4UHvQembTYV/t5HW8+1sp9k/1OJQDaMnr5DQ+B06gRwNdEDmdSxIetIlorOaNXHVwOs1XFaaA6DEPuDLkwam9mmrf3+O9Lf97PrSoj5sbD2hTBFiFG4pLaIwf+uuV+nipMC11gHvYIcycJNsATOWpKVs5VVGDo88GWqd8FqrlQtoD9egpw6LGlh19u7n7Y88D7tyR61H85bYr4WignpoQcsjRhdhGvdTM6+NDcl3xPV95f2pF1IMiqvZmnUunwQwdyrcDyxIJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:37:15.6910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9fe1f4-c502-42e4-6721-08df3bd065d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

For PSP v15.0.8, PSP is initialized along with VBIOS. Query and keep the
version during early init.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c0ed3e24b684..548e017311d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -191,6 +191,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 
 	psp->autoload_supported = true;
 	psp->boot_time_tmr = true;
+	psp->adev = adev;
 
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(9, 0, 0):
@@ -298,8 +299,6 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		return -EINVAL;
 	}
 
-	psp->adev = adev;
-
 	adev->psp_timeout = 20000;
 
 	psp_check_pmfw_centralized_cstate_management(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index dcfc9be269b0..803414e0be62 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -36,6 +36,13 @@ MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc_1.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_rl.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_ta.bin");
 
+static void psp_v15_0_8_init_sos_version(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->sos.fw_version = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_58);
+}
+
 static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -507,4 +514,7 @@ static const struct psp_funcs psp_v15_0_8_funcs = {
 void psp_v15_0_8_set_psp_funcs(struct psp_context *psp)
 {
 	psp->funcs = &psp_v15_0_8_funcs;
+
+	/* Initialize SOS version as well */
+	psp_v15_0_8_init_sos_version(psp);
 }
-- 
2.49.0

