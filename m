Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC1C5B552
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 04:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAD710E533;
	Mon,  9 Jun 2025 04:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="25EEk/Lr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A981510EE87
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 04:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baUC5Z9UhL6nk4kzwi+UsOhUxWETJSoOgs3sScc6X22qJjYqjNKt5kY0A+y5/XW38/XLjCJnfJ30fsNvbYNyqaTZjan99JJ84LX0bxv171SCF91MXXmlvIQcVGjiqAxoZ5QJ+thxlPf/+HtvkAY90fMCI/srQJckn+4l45VbTYSd4/ux0ShaXXKFugwNS0vyL6PN4oaHTql2Rtk/7OEKiDskUYTdSFY2+ZK43Hn6QvZ8bPZ8TSwKZkjhzIahTbIB01ggMKSOD1FJK377hcTKYB6Q2fALstlau8l2y8qtANvBjYF9yya/hu9m7zykmb7ylM9h3L+teMOMRnJ7mW8z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI2N/d0aDy0P+Vf3FlPJQOh68Y2nM/lL7YclXtojSbw=;
 b=nN0A1XyS5vp0rWnhwdzXJYYmyHfI31YfXY+zUDMjWna6qjyc/T8iKzZcr+p5k2cH8QAXw8w1yfi1OWEI8rkLRTNmtfjQiqinar3bDrjEFLz0gw7KrEK/KOoeYMp0wlTfGCf0px8FmWI9JHxtyAMoqNm1I1jkaEJvDK7PXVRzy1Dpmv/iyC1tyhY1/UXK5W+Xv3Om4w0einB7j0/UV30PjgRRIAio7h7TcNko823x25EjCGSJ5kCrzNUEtuLTEWe5254JDCBNrYdHDWhgR9Gnqe+BR0a62cZ4Ervz3XYJxFgGOy2ssMhvPOtemN79ZvK5eh9fsNIOMbSGgPB++oXyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI2N/d0aDy0P+Vf3FlPJQOh68Y2nM/lL7YclXtojSbw=;
 b=25EEk/LrXizs3suQaP3YAs38wU38dB7Xq9RSrOtW2wdTrm9polScEOD7t+Ui3YbwrTQy4TjzydNXQ2SNkrvV3AApw5X15cTAYIlXtl1/Oq9zH682BIbhqj9Im9Z+PEWm7sQ/DEC/TbNxmhjdYZqvi9BAK2y/THPxa2WIYhC7xDQ=
Received: from DM6PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:100::25)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 04:41:53 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::fc) by DM6PR03CA0048.outlook.office365.com
 (2603:10b6:5:100::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 9 Jun 2025 04:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 04:41:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Jun
 2025 23:41:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Suspend IH during mode-2 reset
Date: Mon, 9 Jun 2025 10:11:27 +0530
Message-ID: <20250609044127.700014-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 15409a80-e627-4e5f-4431-08dda70ff4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fSeRs/s0qEYcmMDoIizvYJI8qIYiAcwTMoMvrG+b2bljmwQn3IcZQfocAPE4?=
 =?us-ascii?Q?wxjobKrgK1hOZvNurQhykAG1KWMbit4RmteGmWOt2vAufRtobMAO/kLWP7Va?=
 =?us-ascii?Q?CjI4L0NJpoXZNMvf5aKjuW4uOdFYDvqKkyYZ/Lx+PbRz3J0U01Z1VDHz5ByH?=
 =?us-ascii?Q?a7Um6Xfu/7A0xDACZVU5PxKpFDo3Wes9uPEm+AppyCLh0k6XfvwxQRwvda2u?=
 =?us-ascii?Q?E9l7TkrlEvCH/EWE6r+sp/2uJvh5JJ0YQxrbJTh6dNBFCTLVXr7/O39BRsAT?=
 =?us-ascii?Q?2lNMSv3sn+6cPNqjyQLLqPv1Jba9tDsmzsdZI9SfRRS6LJ+f4FRPGmrhJ77h?=
 =?us-ascii?Q?WX+DDehj0A3r0J6Z335Tenes8R/bltL3m7utDTA14So389xxB14YMhb9SVOd?=
 =?us-ascii?Q?onakIE2IUpUq0n0S1Lt+d2xQBfxPNDyCZXHvgnZr5KV8SmyNL42ImQdDHn8p?=
 =?us-ascii?Q?LIDAWkEEphwjTceMG3d/qhRji6EVQaULpQGIJDD2/PntnQi056L2rwDo2MNr?=
 =?us-ascii?Q?YYRDwssRISWS6mYFB96caGJwjoSLkI8F2JNqiy+f8VNO7zFHaG0XR5sjAXrz?=
 =?us-ascii?Q?35hv8d0k5WnRnHWoBTed15FpEsdopDSJRvhjaAFL8IBPRWbYdYjESbz5JBWB?=
 =?us-ascii?Q?nGh2RdQHeoIzhSjaneZkO9jkfF16ZLDXTgsozQ0nWXgsPQr1NxPvGFiRVExN?=
 =?us-ascii?Q?LlrH6gQ0ZmYhX/F6EBkoKFYbYKmjbjxQREw1ii5gh/u7mJlxiro9jsHxcL7p?=
 =?us-ascii?Q?Z+7i+opWu+sF0M7lTWoeH9KXlXF2B/pyaFy4EJnMDylwuVGa5TjW2Ew43Ch1?=
 =?us-ascii?Q?gdOf5SB7HEhktmrK3u/CIshtp/gfsGIEMNdt1I1qntF82MgPNDpJWhSAnUPA?=
 =?us-ascii?Q?VzNoB+CDaciDLZ5RURxCmmMeLOKu6Z4jZVqtLoMCeOC63hMkCMOG3Sjeo8VH?=
 =?us-ascii?Q?4/J7y7Q3F2I/c5nWUFeLxj6+r08X7z/wAgs0cGvC4F73Aa2itZh6WC63DXHC?=
 =?us-ascii?Q?TMFWIDnszjqplZ6wgyiY8BwWhWMflBD5Tv8WzwlXFUqp5+K2WrjtQjn+Ee/2?=
 =?us-ascii?Q?P3RWch8RHz5vZ6j22QO0tYktwcXd2jWAZCuKY9yn6ImtTdl55180xPbsJ4Y/?=
 =?us-ascii?Q?C+LGkW4JRO+uIEuFFPgHpjxu//IaQZzJJACXM4EZ3bwl6NEFJvLoeziOmWQG?=
 =?us-ascii?Q?It/oSHSubhErwgW/cvUZZU74/NW3lW8fPX0CvXkQd8UmiEc6llIBSjiKYejJ?=
 =?us-ascii?Q?17I/EjZ5rURLiaFF+xXICb4GvOhXVlEOMcRFmWm/sIpI88nsS4jr+WZsnxzI?=
 =?us-ascii?Q?MnSPug/G+n0znC0ViRgXPsQUwOpkhvTZzkBwViMnSKRaa5MaNmyBQsSNmy+D?=
 =?us-ascii?Q?w1W/4H02Kd4Vn8PjGz1IIEDp20NuSIUrD5yL9J74qUVErKtWVRGlzE7+FAn0?=
 =?us-ascii?Q?YFLyJXSigKlPRUWgk2IdrEUyIYLqExULQPKLQ1Oe8WH4/JTXREGphWDTJ/fk?=
 =?us-ascii?Q?NcjqRXTXZkIfEx1dLLzvTcF7GpOCDvQ0Ovip?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 04:41:53.0300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15409a80-e627-4e5f-4431-08dda70ff4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

On multi-aid SOCs, there could be a continuous stream of interrupts from
GC after poison consumption. Suspend IH to disable them before doing
mode-2 reset. This avoids conflicts in hardware accesses during
interrupt handlers while a reset is ongoing.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 33 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 49bf8f3a748f..48c09addb29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -71,18 +71,29 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 	return NULL;
 }
 
+static inline uint32_t aldebaran_get_ip_block_mask(struct amdgpu_device *adev)
+{
+	uint32_t ip_block_mask = BIT(AMD_IP_BLOCK_TYPE_GFX) |
+				 BIT(AMD_IP_BLOCK_TYPE_SDMA);
+
+	if (adev->aid_mask)
+		ip_block_mask |= BIT(AMD_IP_BLOCK_TYPE_IH);
+
+	return ip_block_mask;
+}
+
 static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 {
+	uint32_t ip_block_mask = aldebaran_get_ip_block_mask(adev);
+	uint32_t ip_block;
 	int r, i;
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+		ip_block = BIT(adev->ip_blocks[i].version->type);
+		if (!(ip_block_mask & ip_block))
 			continue;
 
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
@@ -200,8 +211,10 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 {
 	struct amdgpu_firmware_info *ucode_list[AMDGPU_UCODE_ID_MAXIMUM];
+	uint32_t ip_block_mask = aldebaran_get_ip_block_mask(adev);
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_ip_block *cmn_block;
+	struct amdgpu_ip_block *ih_block;
 	int ucode_count = 0;
 	int i, r;
 
@@ -243,6 +256,18 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	if (ip_block_mask & BIT(AMD_IP_BLOCK_TYPE_IH)) {
+		ih_block = amdgpu_device_ip_get_ip_block(adev,
+							 AMD_IP_BLOCK_TYPE_IH);
+		if (unlikely(!ih_block)) {
+			dev_err(adev->dev, "Failed to get IH handle\n");
+			return -EINVAL;
+		}
+		r = amdgpu_ip_block_resume(ih_block);
+		if (r)
+			return r;
+	}
+
 	/* Reinit GFXHUB */
 	adev->gfxhub.funcs->init(adev);
 	r = adev->gfxhub.funcs->gart_enable(adev);
-- 
2.25.1

