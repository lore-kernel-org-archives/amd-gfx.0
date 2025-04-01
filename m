Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F187C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 21:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EE010E169;
	Tue,  1 Apr 2025 21:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIm7jIyh";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4599110E169
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 21:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqUJLCkFVV87te+mNUWOHGk6fQ2r4YoXfG5VxJQqfQ1AMyRESW3sl+xCzqEzthpT4QMquBF/cMx1oVXCPcA1Z09CPf/Suqpio/I450oGvc8PfTPGbkwmvUzr8zlgJIqxN11UFcFGueWUohXGed5vANv1LD4gXpUnoSnw08aWgUi7ChqIcdteyCA6LNKATM2EB3wM8M+lmcOnAAdtjyYzOLRPRCB0LmBWvktCNCs21V05wYhFybSJTHavs+X5Qz+s5tYhlpkDBi9TsQq6fAM/Fg8DqfyRh9U9owQLL64sMwkM7Y3y8owW2AP/zGYKUWJrpxyKIJCSjf1QtxQ8LNYEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAgMRFUJZFfTFw9O1sOy2SkVq83StoW2KQM/8ybX6bs=;
 b=kyHHVIayANZU4cWrfgAgiTWTpGLnnr5aHye51gkHoyRRYp4FPYh7E9esi+KG3/BcgQc4vR+hfgkmm4t2iRL2ybYy6s/7klcvcUllKReiq8C/Z9r7emX5R0f57AZ4dOysIPaj/R68ovQ8DNh+0UQDwbatnkBZ93k8IiLq1AfcScgRKqJmExnvi8UEq5jKSSDbObZAl5oruCO9bqqOzxi04uMlYXNieiFUXldkmrHceARlikTtZXJKGHwVmHfaHkfA9UV3RP4j3HUdQBwWBEzJDLqeqsf9i43pHN62msUXKID23YsHB6VsRo0ZFtpDkHkoCLWMgDUkaz8S0ofcNRRdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAgMRFUJZFfTFw9O1sOy2SkVq83StoW2KQM/8ybX6bs=;
 b=AIm7jIyhUmBWyJvAsroW25WESuw02ZLzvWWXJ4ZKZ7tVWk6Vi0d47QkN5R5WpRKIWTTKTXLFLOD1NUJn04ZxID3gfaHDZ6oTG2vXeR8MGS8a559FRO4cTh0LAHEsTTWNLPk3e1xN7yXRrlu206UTz2VdbSIQNUfhXUYd85E6XfA=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Tue, 1 Apr 2025 20:59:55 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::80) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Tue,
 1 Apr 2025 20:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 20:59:55 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:59:54 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Zhigang.Luo@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Victor.Zhao@amd.com>, Tony Yi <Tony.Yi@amd.com>, Victor Skvortsov
 <Victor.Skvortsov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs
Date: Tue, 1 Apr 2025 16:59:01 -0400
Message-ID: <20250401205901.421291-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cd68c6-37dc-4d99-e72c-08dd716027c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oKgt4f5gwc14CqaaLhlEe9oXF02qxMmyBzq3Wl5fBvmkKUdPDGIzeDqB8p6/?=
 =?us-ascii?Q?yGAKCr9RMdYF1WY8j6ZQbMpYMWOYjR5pJvuDmnYUPwuDs1sSZ37RZT4v3kaT?=
 =?us-ascii?Q?BCjlj/e4+zahLfHDaxFAtXufrBTb5ll7SLbq9PywzB7FBit60CeSB6aVrMEM?=
 =?us-ascii?Q?TFftY4G7fMnGFTko8XQc2vJRxO4QE5TqRDGqgDPR8Cb0zQ3uQceB3MyVXzEe?=
 =?us-ascii?Q?CeWqsGDNgeylfR/H+H5+gUw24wwj8bETVhA5e3ibsB0iFul5n3UjwbWVJxu+?=
 =?us-ascii?Q?LZyEji6cD2sE/vJufaWRtbObkwrXsngP7bYQZ1nQFjrPvFmlbIs6HjTMuMH8?=
 =?us-ascii?Q?Ddwh/i8IoftsSA9OlUb/XUNlq5NuzO8LyYInb3gU16apukCGVE3xtb0+9myM?=
 =?us-ascii?Q?Gvmjkw6uI8Gs1alm+ML1OGCh6NF7ehQPPoGU0wIdQoKwaMUls6w5oKPbMeP/?=
 =?us-ascii?Q?C6XVSocKBknt62taTYuYbZ+fESSqAPbvqj3x2CdVOhhfBRX6AwVjejvIBDUG?=
 =?us-ascii?Q?ImmulNbgaWgg5bWTfLyrEUpiDWw8EzPGglj5VvWmRlykR+yD41s7IwNcQYA9?=
 =?us-ascii?Q?l52M9LzW/+oR7vjiH0r/s78Z2qJZGpiHBElfnlf6n9wfbOMW0/dkB+21ulLF?=
 =?us-ascii?Q?T5WwJHtK9gtPf+bywqRT6gmyjzGTL3QtZCnhhvJ+K+OLrznqxEZytPa+inK5?=
 =?us-ascii?Q?G7cEbAt83AAOc7J0LzfiTXNqOI6gBEv8bWvGbpGOOS5RU7eihj7bqEEe+pD0?=
 =?us-ascii?Q?WUnSdNB3b63/QZuX8ijuXVapit89d1FyKxMkpVcp/hyX4EVmMf1RboPYgaEF?=
 =?us-ascii?Q?XoWWBO1dQEXEfu3aRialeiGdoxbIUK9tczNkq6xHCGMRr2duZgkcCtvF1429?=
 =?us-ascii?Q?4aZ2BEB9wx6SPejBR0Fn/owLYJc6bnLBykbfJ7zURjOVUkBtKYx0ApfiXv+5?=
 =?us-ascii?Q?IuCxj5WkM5WpqvM8qGldvikLEtuUwQldPPIV8Q39u1N/x7J5YvlnZ0IGyXNl?=
 =?us-ascii?Q?zbAH+MiMeDsjmKsQU9LaHE7JtHyaDU9UDOCah8XxX530nImoYbvkJu2ES1FO?=
 =?us-ascii?Q?aIvlaUj/EYXrW1FhO625wyIuf2YxSOIurMDcPs4hQDH9vQYlC4bXKzwQ1QqR?=
 =?us-ascii?Q?t/CFLgQGL1/ED1C76RrVXirh2Qh+NYuwNlvlV1iFVxEYPtcxcg+mp8gFrbCA?=
 =?us-ascii?Q?y82Gmm90YO4kaKvAjP/TETmptDwARYgjdKRGA9hZ/y78uBbf4ia74chKUCf6?=
 =?us-ascii?Q?XmJKFWK8iy3FlqZ3yEPA+dlfHpllZUMYX3Z2IzrzMLSp9Wlc5JAHOGWqBDK7?=
 =?us-ascii?Q?x5HeFp6VtHmOtI2ttPfgB5ewzMtm/wN4IopcTvTEoerfUbbGrn+cXMuThMjP?=
 =?us-ascii?Q?Pxjg/Vk//wOv70h2roHlX4OLNEwgAe6Q8kt3KNuJNH+SD9Zanmz04LSZbud+?=
 =?us-ascii?Q?wjuvKfCgYzB7CSzEGlWo4uxOOsswlvnAaYZc8DLT673YNR0m+W1SlbhCfCOp?=
 =?us-ascii?Q?KG4S7/9uGgw1Kjo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:59:55.3359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cd68c6-37dc-4d99-e72c-08dd716027c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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

From: Tony Yi <Tony.Yi@amd.com>

CPER read will loop infinitely if an error is encountered and
the more bit is set. Add error checks to break upon failure.

v2: added function pointer checks

Suggested-by: Tony Yi <Tony.Yi@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc0..83f3334b3931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1323,6 +1323,9 @@ static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bo
 {
 	struct amdgpu_virt *virt = &adev->virt;
 
+	if (!virt->ops || !virt->ops->req_ras_err_count)
+		return -EOPNOTSUPP;
+
 	/* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich, the Host
 	 * will ignore incoming guest messages. Ratelimit the guest messages to
 	 * prevent guest self DOS.
@@ -1378,14 +1381,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	used_size = host_telemetry->header.used_size;
 
 	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
-		return 0;
+		return -EINVAL;
 
 	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
 	if (!cper_dump)
 		return -ENOMEM;
 
-	if (checksum != amd_sriov_msg_checksum(cper_dump, used_size, 0, 0))
+	if (checksum != amd_sriov_msg_checksum(cper_dump, used_size, 0, 0)) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	*more = cper_dump->more;
 
@@ -1425,7 +1430,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device *adev)
 	int ret = 0;
 	uint32_t more = 0;
 
-	if (!amdgpu_sriov_ras_cper_en(adev))
+	if (!virt->ops || !virt->ops->req_ras_cper_dump)
 		return -EOPNOTSUPP;
 
 	do {
@@ -1434,7 +1439,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device *adev)
 				adev, virt->fw_reserve.ras_telemetry, &more);
 		else
 			ret = 0;
-	} while (more);
+	} while (more && !ret);
 
 	return ret;
 }
@@ -1444,6 +1449,9 @@ int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool force_update)
 	struct amdgpu_virt *virt = &adev->virt;
 	int ret = 0;
 
+	if (!amdgpu_sriov_ras_cper_en(adev))
+		return -EOPNOTSUPP;
+
 	if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
 	    down_read_trylock(&adev->reset_domain->sem)) {
 		mutex_lock(&virt->ras.ras_telemetry_mutex);
-- 
2.34.1

