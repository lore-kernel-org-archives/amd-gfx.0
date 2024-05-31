Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF65C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E273B112323;
	Fri, 31 May 2024 06:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5SHOrsh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABC810F49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip5gW21Bz8jq7oadCNkNY0yWxUXklTtKxsbfrvKQZR/Lelj4X7mKWqy4Zr7E/M3s7nr/bBj4WUdNkuxxjo066QOTqKBSYDq11bUvTiIMFCuJSAZbovqm+1Q0e6VjgqOZwPbZ0PvOvrDBftzpEqfId8O5wtAcCgDkGJwooDnS0lL1wtvY1cyvmWtKLH5dh09wcTNzbVY3WrGZrA/D9ZcPIJwYEH4cayHai+JONjV2q4MioX9jmM8qB9oqxHJr69o2pWlB2502xVCOGQJR0xAmZfJuot8HLtFcPncnL+/WqgvL3ZndVD64H7DiqB0Q+T4Xhhm/ghyULyGGVWm+nMN1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfuEgt7sy+V62aq2Sii76qtSeeEumBtCCs9/SownSMo=;
 b=Lg+B6mKbkv53LGryqPH/QHqopIpMzr4dZRWFROD8KGIimGgfet8VK1V9tGZXymZwnTwkS9VdLzmtZ/6znIGtJb1XD4CykSeHNvK5sOC6UXv25NgJchTIlSdj1FRZbldcSDR2sSiKoPBS96Zb8A3GbAD91wR5YIXILI0gcP+yWbRr0vLDvOPVqpsfYU/IuZQr94FAVm4mFpGK8N1M5AgOE7KcxyU42aH3mTTk1/5fmQ1vwb+CKj2Znq9of3I/ZuU6cr9iq1ZJxKDdwYfhJzsbRRV+tjUtLPEPmiehtzyuUgATjbLa8yIK0F+yFUcc5HnNVKF9WFq6PM5fy+/vpZamAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfuEgt7sy+V62aq2Sii76qtSeeEumBtCCs9/SownSMo=;
 b=K5SHOrshUuE+HVXJUbi0WNZfH6LDAZZPWwCuMSMhUqDdJ61xlwBGjzoTCIFmgWebj3/uhmvdXcY+4LsxqnCTFXIAkPwMpGviWxecyA86C7NhUaOrh/If+s4HQcDoHkrjqlHlNKzu4raaQGRCuBT3bWDLxNdQRaCkm+0AuvVC8Co=
Received: from BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 06:53:06 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::4b) by BYAPR05CA0052.outlook.office365.com
 (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8 via Frontend
 Transport; Fri, 31 May 2024 06:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:06 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:02 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 03/18] drm/amdgpu: refine isp firmware loading
Date: Fri, 31 May 2024 14:52:34 +0800
Message-ID: <20240531065249.1746350-3-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3c8ce9-45cd-4404-1b34-08dc813e531d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uIZ5VCpE3hlBqMIUewLHaeCSjFV7/aeLTWHYZlDWc4sXDiZ8ij+dB+4oFf4S?=
 =?us-ascii?Q?lkRZPAlWUAszNEj3R963LAjC1lWAMQuCSynbiNwPYcoP5/rVwEBV3nsb0WXf?=
 =?us-ascii?Q?Y8byn3WYrT2YoZrc6FzvWBlS9CalgrXc12DcXwVZtMSa5KeP8XD8UwzS8VmC?=
 =?us-ascii?Q?VrpvzUTHrec7uAmCtyYBaa6GTGkH8LnTECe6KTDSuMCI3ULubILpM87kcx/s?=
 =?us-ascii?Q?SmR8oBGZ+orIvyGyVrEfSIEDolJOwkdLNUz9y41IStTaf/DyapZS+S0oyKvb?=
 =?us-ascii?Q?BHL9bTNdgng01XQ2kUjh1Ud6Gs95iFay85Vun1vIDgqAeDcKYZXtryfIZyTo?=
 =?us-ascii?Q?esnflfiE8dnMgRuhYrdNK6eaYMKHmkXtCzMlpLy24EtjRt8sswWNsPTUmGmS?=
 =?us-ascii?Q?cOpoSZO4w+eRlQQtJN/8g51gyjUDhyx2++7d0bkSUHMqAsMmRzNQyFDhVG63?=
 =?us-ascii?Q?2LF5U/nrPYWFUsHo9R9MIKHZwo3zHV7ym0715ye09Nv0XELHpbLriJFbrn7j?=
 =?us-ascii?Q?hSj6SzRBnDc+E+8mvYNip5Cvg4sSE9DhcnxrJwwx8OmhClx8GmwsbPjqaBJz?=
 =?us-ascii?Q?d0e/RjkgQomdD7B9ZzE61kWZLb6an/nTvOUw17RcP+/N2cMZVE2sSttJQPca?=
 =?us-ascii?Q?CR3aKvkWMMNyN2Omb3V2K0NGXGuZ4HrfSv3EQDuyD/r5cYRb0x2wcuZQfE+/?=
 =?us-ascii?Q?sQLGwbaAM5PhQKyeU53WWicEKXPJdgsV2bmFJDT96nfHSdc9U3dqfWD7PO5a?=
 =?us-ascii?Q?ewg4+jQi4n9hTex7RpXXd/ruGXIN9Ggw2lqtpw9xNpXZB7MedpKVd1zigipr?=
 =?us-ascii?Q?YZS7CLVf3X2DFaYwI8MO7+GvGgfolCPPiDSN6Iy5nk2/B23sKU4NHGdlRjyi?=
 =?us-ascii?Q?YWt/0XZQP9UfqeotZmZNdqziOQmo1A1mZDwTICfJ/1IkpJ3FLzj3cLFF97ZE?=
 =?us-ascii?Q?5+P0shubMoirbHP9htipycodFZUAUshIqy+9kwpsZKBdE4oS2GAyYdv6FD5k?=
 =?us-ascii?Q?MdGGNiZeBiZYr5EbGaQkVdkMuO7zKefN7vB6hs9kByN1U7DdmtCcpzZ9YUVF?=
 =?us-ascii?Q?u3cHdoMPnNu96O4+5dBfiNo0Tq0aP8gfpqGremNdYwa+Ooc680U3Az9cSD0a?=
 =?us-ascii?Q?o0RjdhnG4QmrQEdhc1OVdJb0bn8s/lZlIWvV0Rk2e4vZpFn2jmnWzbgoH9mp?=
 =?us-ascii?Q?bwhAjyDwiDo1s7pw4FiWwPtHR9o3U+hIoL+iqel2bAINfhB5iE9ZdvNUcVGo?=
 =?us-ascii?Q?h8SUC4ovZbncQlfaDEM/LzGOcP9g/8Gx4ubVZVoThlHvpQRoAi5d8aqAY7Db?=
 =?us-ascii?Q?rVn5VqfJId3zHulEnUCd1ZpQM8/pV3CpPQrOLSbaB97XhUZQWvE1JImY/7tY?=
 =?us-ascii?Q?Dl6sxSjjpm5x/5E7QjKb0gov0MOL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:06.0733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3c8ce9-45cd-4404-1b34-08dc813e531d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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

refine isp firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 2a3f4668cb9b..215bae809153 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -97,16 +97,14 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	char ucode_prefix[10];
-	char fw_name[40];
 	int r = 0;
 
 	/* get isp fw binary name and path */
 	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
 
 	/* read isp fw */
-	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
+	r = amdgpu_ucode_request(adev, &adev->isp.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
-- 
2.34.1

