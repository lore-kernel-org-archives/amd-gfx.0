Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D16C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A240210FB99;
	Fri, 31 May 2024 06:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0SIQh6mz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EC81132B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9aSW8d2F7tjTO7ooz4poBaDNeK5KslSZj+F3yIaOqslf1G6qZPF9GPCXD/3Ej5DpZeoWysvQ20zeB61Z4f0gEPVyCMT1CRw4A/kxYT5ucEjAd+r3MQyDMA17AN2IlrYbEqPk4uq0i6wtW80HBJiNfbdksbWQad34McHey4YbqVdZMMZ7mucpk38xXc3yj1/3r7LobZrv4PhpClft3Fdhx5s+pimOePdcPuKwg1D5DCQKu2F4fEWmJj6w8E15RlgYlTv8NdhyLwnK0C/XjzG5shp3LIMvZcjNbdLhhOtW2Whb3+irKBqtcpU0kI7+fumQzlStwYiVmC6SuM0ln/09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viZg8SI8wF7xKy4CjlbkuGCyNi0jrPD5z8xmHTrwmnk=;
 b=VrUITmksZDB6k5gsaZxowQ/lH0/9hvHSMFN4Cqz6tds/oLexfIcYZcZjj7ILaLuvP7FiIGSMF+Fk1mlk4/cDOeUEzK+DnelGUfRYzG99AlwUZTijHOW/LCI4OhMiaRq+kETZaifEZHzz5roqXqHm1K6az/hl3jhMlx2+Iji9h9CkDpOZrNlYAOEyAfa3J794MFA7a/NwxofLtRpLyBu3wTNn6phCVljnfku2hYrunPo4dco0kCrnKBH8mU6JZZkk/l5xiWjB4KzVF60giDqlWzyL+GUeI+LhOq5zwqyRGrSZ8UfEUA1uWXEkZt3lCN1+Izu5e69pD0xIOEz2rXCQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viZg8SI8wF7xKy4CjlbkuGCyNi0jrPD5z8xmHTrwmnk=;
 b=0SIQh6mzJUbcJYN8Fd22JYVrAPubqZSVA6j7nxjM1qvayyVrUxZoTwNbx42Ol5BPAo/PxyJnUJUaqXTmiFv0oWcBm+hiOyuccCBeW7M9taOQjeX2YJts2PeRX/3mjeWs+pQDZbqCfBiVHcIJ/Bo1k/8b10+TwUuAnN+askmvVRw=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:53:29 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ea) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 06:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:29 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:27 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 18/18] drm/amdgpu: refine gfx12 firmware loading
Date: Fri, 31 May 2024 14:52:49 +0800
Message-ID: <20240531065249.1746350-18-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c8094b-b5e0-425f-7ab4-08dc813e60df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PboWtqK5DuT4WnC5kBmJSah86PGm5Y6A86zlRQjwcniCdpOmoMnc+tS+MvJJ?=
 =?us-ascii?Q?2H+kNDUzeYJ0KoOk1XAVrp0w3p6TVH8qasOBcsMp0zMRhDPUqaUvxO584cfY?=
 =?us-ascii?Q?2bOor65AP/HViHDtYxU9whkRW6htkdFfYis62nK/J2x3D7anBSoN53uEEHSz?=
 =?us-ascii?Q?3cAAQRVrxRqHKuwLyl89AdlSicGPp/SvWTZ1cTtHmDte4iiowQYDVXqwndxO?=
 =?us-ascii?Q?QQP6UR6jlv34zB9t0I7f1DEQ/s7oSTbd+q8c+/mECvg0QQwJK9zx2Gx4p1Sw?=
 =?us-ascii?Q?sisY7k8Ik1sD+7aoKcW+hTzWs1+PaY6Bh7N07GURCROMe0SsDSHWZgNPnM29?=
 =?us-ascii?Q?mGL0pkcjgHH5GjOp22GtmK2/FrYfVG+z7hU7OcZFpFloqvOHfyIbfv/g9qyJ?=
 =?us-ascii?Q?xJ6FR8YxkCMEr0VMy6wWXhaSvttOliHmvDutVA2odqAW8gQk01Tx7ShzhtFN?=
 =?us-ascii?Q?rXC/Zjl9ebluq37k+EiFCOuzPjefuqJdhJfCuHtlOiYn+XWGIhHEK2SQDM9I?=
 =?us-ascii?Q?S6pq7SRSzZAziWkvPnZoikDSB3AbQAsl5xfA6pC7uWzyTAG5BWyq/eRjGIZv?=
 =?us-ascii?Q?LM0xxlr4ut6X0dVEmfCOxGnIqT7aAqSUTyP7bwfmqM9vmyRtnJndV0Dh6Mzh?=
 =?us-ascii?Q?j2h1YxaTAOFDsjmbkQi6wWurY72WYfBFgxTn+JcwnKrulEB8lBzTzEsScInK?=
 =?us-ascii?Q?bRaindx7ts/xllVFcu4ZZc8Uj3RDSF1lnQplS21ezSeWXj50yBJ2BGDdSPNY?=
 =?us-ascii?Q?qv6cfZ9NzosX7jQ8xgq45IETNbFzBTx6K5UIk60HgKCDJIknFwwb0ibX/VS7?=
 =?us-ascii?Q?SJc8ZNrOZVDovGrgEBiWSTc/u9/4ExqXsYnjRHlITayQ5dBSCHj/boZAjHSp?=
 =?us-ascii?Q?VuwjTqSV3njQ1K1oKnAuTZ64DuL/WHkvE/XrMY0SKHrr+QTHdIY3acpAGibI?=
 =?us-ascii?Q?7rIuwWYiif7xgoOI4PygPHqF2u7Pto8RY8gj6OFKe7HHRCm8YcGcb+UumB1F?=
 =?us-ascii?Q?bu3yt5qSwxRPp9jbwO+C7lGtjr3xaZUNjmNh6CA+27UADQEq60or/ua7A9ej?=
 =?us-ascii?Q?4Y1aV+4+/fzD0ylpGh89lJXxhCX6nQo07rhINH/KPrT7s1gRGmtgM6JZr/T4?=
 =?us-ascii?Q?ltDRbj029pPhfwO6L2yWhMAqY/o1nJ/RfeRsjzpFDlRn9BA5OXoyowznnknZ?=
 =?us-ascii?Q?0Tk08f3tF4enSwuHn1lmJOLxe3dMMq1nsG3UOadJmzx9HjpdYubVjSPE1bbt?=
 =?us-ascii?Q?w/FKwY83QW0xsAQQs5mIjESQ6TKIZn9Mdinvb2cP08fDHewFqMY56qEIZKjv?=
 =?us-ascii?Q?sqHa2ciQKlA1P/pGqqBNHMWGWU24fmrSiuAnKoVxafiQifEcPyXlPr2UhA7I?=
 =?us-ascii?Q?yiHvmMg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:29.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c8094b-b5e0-425f-7ab4-08dc813e60df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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

refine gfx12 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6419f98e32b6..f37cfa4bfb22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -386,10 +386,9 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 {
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
-	char fw_name[40];
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
 
@@ -407,7 +406,6 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 
 static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[15];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
@@ -418,23 +416,23 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -445,8 +443,8 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC);
-- 
2.34.1

