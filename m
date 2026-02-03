Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEE7E87842
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AE610E6C1;
	Tue,  3 Feb 2026 15:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="javZ3X4y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575EF10E6C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThCUXs0YGLwjrMOjgrWqzJ32W/4MtzDqubyS1vLvbmHkSdvF1fGNis48P8d++DxirSS+8GQIIL46K8kUPW6yCZyJrS6ESxeoYM2dWUeGvwVnbszdLZprNJeXfSZDteZFgOTgNI652EaZTAMOy8eLxvF9cfk9uTaEqo1bBPgxVmdZEGXaazItEh0LN3xLavEwac9YCFSWzJAMkJO15MQ3vixVBlDY+tOfew7dgJ8X17E5aukPYabxdfqxLng2XOFEwVUW3WBPEW1PZY9sYAikDHpQUm0mnu1q/HejplyZw1YRpKWfE0EV1o2YqmHVeDIzWoUtkh7UQ1/3rwwlEThZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT1T32Xyh1ifVVUwN/KTk1FEw1YHJqUKbt5c/x1mkMs=;
 b=WZfinvnab6MXj0AOVwGTvT2rrbA/z9An5mR6dwBAY/TaP1svRD7CcJ+c/8rACmMG1VykPN7Mpgd34hS0TKXrXcXqKg7miYRhiADizOYpW31YPFIaddZH76zl/B+Q1aMjy3IhbETVJpvOAhc+n9PMNMyfqASlpi/b9UfNqd0jAuxU4T2ZQUJ3EEZDDpybtPn8URQxdL5NuBOdL5g/U85052WjUYdFuYYqydpBs6u7bGbQZveN71/qJWEkC+ytsjuiHTyj8h/M6412vHyraNuBKM2Hhfa7IrX/Or3rZuQAi2M7KseTtfqaMpQ4MY0N2vSyFSsH034knZAcPQ2W+43yPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT1T32Xyh1ifVVUwN/KTk1FEw1YHJqUKbt5c/x1mkMs=;
 b=javZ3X4yTrFCZlusDu7fR3ou7JPlrn6rvy3/2J6WvEMlpG90mwx4SUuw/KFjoCJUzrPk/ZRJqU/DxWGo472T4+kaspOVXKbIM2Kglr7wMiCgTUv9kGBOyWerWJ8B4Z825i46a3Zda2kKvChUiOxUUYh0tyzOxtu40fJLLqLio/g=
Received: from CH2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:59::15)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:42:29 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::82) by CH2PR03CA0005.outlook.office365.com
 (2603:10b6:610:59::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:42:28 +0000
Received: from smc-sc-di15-34.dh144.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 3 Feb 2026 09:42:27 -0600
From: <silouis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <will.aitken@amd.com>, <vskvorts@amd.com>, <lijo.lazar@amd.com>, "Simon
 Louis" <silouis@amd.com>
Subject: [PATCH] drm/amdgpu: Disable xgmi link status for VFs
Date: Tue, 3 Feb 2026 15:42:00 +0000
Message-ID: <20260203154200.21545-1-silouis@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd4f702-0885-4125-b64f-08de633ad63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Kc2PoFxY+yj40MwTe2dHDBO4X4ZRYvdrrxxuYpQlTxiUdnbQtIcBXcMHgH9?=
 =?us-ascii?Q?0TEDJHj8NRBAXrbG8xgjnQctSJrFeoPUv3rSj99ZuY8/JjZ3+7WWUKmvqIfC?=
 =?us-ascii?Q?sf7wnUuwczhb6ncZjFwBfWwMX6bgAag/Na+K9LleBBB0IFCV/YmIg3kP2fR8?=
 =?us-ascii?Q?TGudd1RCt5FTQ2/RFyHON5IwNgVvEYt5PDqk/EgYFY6KSCZWpABYHzAOA3hw?=
 =?us-ascii?Q?uW7VnAnj9jgaeyF77q8nUhFU96vp8rp0VX1FzzYWEm2SRLRm0pd235urIUpi?=
 =?us-ascii?Q?25+7nN7Fm2dl1un/qngaM8HwZ/zitXQaKh6OKl1hp++gdLttb87JW8Q9lh5u?=
 =?us-ascii?Q?huGFN8yL2TXgk9nbVSyk6zwpgBgg0mISayygfA1MKITL+MjFmGqA0txzUALU?=
 =?us-ascii?Q?+WTF2ZfCNWSm5hVDSyAHfFyZvQHg6smmrqQ83x85aJ3DAgIw/oMtQoNKUyMo?=
 =?us-ascii?Q?LT/XVwew7/zWK4TQ62SUOC3waUDin8Q8pcvU/OlkjYPHLpjLajppk0e3pemT?=
 =?us-ascii?Q?kBZiXnYMXYV/V4bFQJkT+Asy1FQ3tS4rftmbIPDojXMqcZNhDy77Kh+U4iV4?=
 =?us-ascii?Q?qi40Zbku7pRRtcK+gAXIdWRoYUfWqFwA41uqItdamvgolsq7Z/etWHSv6Ker?=
 =?us-ascii?Q?//2epVm6OEi6rGCx/rXi9+KA2i/mKzhyQy8yryishhqyHVau8FcXRdCSQ8Qj?=
 =?us-ascii?Q?2gdF424MgUxAq0tKrY+2tc9GnbGs0plkG/LLuWHy7jd8+61LD/1SDc0hL2YV?=
 =?us-ascii?Q?hScM7PRi6HWdAMe/NaySKTxw+fGpYVI5aYwBwtUo6/YwUby1kIgzI819C6Y8?=
 =?us-ascii?Q?KWyKA0dvTxcA22mKrQ8zaj8senWt6SG/amBb+Rl3ft4HGLkgSrbBTA8YbCyP?=
 =?us-ascii?Q?6PAm+mW4uJZXMMSbjlcUmIrIk3ws22poAl8yJ2L4v3JBhFys0gGkSJ64XX5L?=
 =?us-ascii?Q?FDe776uBRKe5tnVK57iJA34+ZCAQhlxTDlpCPQdjSCwZZWrcas5AgFyWoxQp?=
 =?us-ascii?Q?sbX8t+3Zno47TP9WqIzp440RNN9jOZ7IYCQsBiYI3NF8avmo9W/qSdy/6bXa?=
 =?us-ascii?Q?0OtznRaALaAnQgqF4PPiw1WnjerXPBWa7xHZ1ttTU+IfsxKNUO8z5iSycCpF?=
 =?us-ascii?Q?DYbQsKp+2vNvkcL3ju0VIUHW9AFOL4+49TYEMy0PVnefdcfdvb3LrAQ0qTY2?=
 =?us-ascii?Q?B3WJ2xPStysl/I2OxQ9ddIQ5SuLJCoXe2oOoy59h5wfI20R2m7XSMr51BL/b?=
 =?us-ascii?Q?D6afXYqHtnLOC5JBzy8KvMIcVgffhuLgsbGyrwYaEXv85c4VROw65Q9pVzk6?=
 =?us-ascii?Q?bXEw3mATcLQphvHU2PrIkhK3od/E0iahiBqZF31C7JvQe2Y4aTtCYbg1bk38?=
 =?us-ascii?Q?lgk2iLD6ULO3QDI5eaL8ruHGppGi1d79oA+IY1qgrbQV6BSXho0L08fmbswA?=
 =?us-ascii?Q?7LyHFi4+Dmd9qjfRrY4Z4UTSBF7F2xRPWubLChrJLD3nwEUBlA2m/mj3VMCH?=
 =?us-ascii?Q?EOHLD8+DJs6wY/7GLBZucgwsDqCABenT5YV+BeKnmyAEMOqLjIzxIQrWcw4m?=
 =?us-ascii?Q?ZQRhGCBkCaOJlLS49p93NtkZq6NrI/1Yiv2uKXbd0ackhF7EtykGHvvNPyH1?=
 =?us-ascii?Q?Wcf5lIv1gpVxs5TVGtUcvnGt8v3Y2ZUFChVUzKo58Pt07fL0d84cyXHvsFHa?=
 =?us-ascii?Q?5wChxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QlWqWJZLv3onaZlzcW8C9N35I8HKM5RJq3dV4OwyUvx9wzeCijzaLfgyfXgNsEY8B/K/M8JsBOWNz40i5+j6S8EL6hkBUFxbzthQV82rkofafHfOT/W+UwKRhVAkrQBjzus8ew+GpFxWtHdVBirCvoHbxKAHIP0i7bPwbpEPQV6HYuzlLijL1AhowR+fvpZfo+k2m2KX28uTv9FCezuxenBH7bKQxrGs06d3i/1piy2m4eefUKzT3ekrsN9KWiw/QH3dA0nvHeWw1ir5vP0+eeIRmDykaKjZMcQXxh8wom0RQDc2fO6+fQ+W/1fqsM0W9oV3DzHGmHk5zSJ34CJzAYMT3e4zFk5pXBH0zOp64/AR1DVYvXu57p1GcyzJ0GSzfI5ioCeTDOWR4nJYi0x/YBpfn3kx3iotYK9BEaWqwatH2leKWs/zUbUTXLCEoU9p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:42:28.6321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd4f702-0885-4125-b64f-08de633ad63e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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

From: Simon Louis <silouis@amd.com>

Xgmi link status is unavailable in guest. This patch returns
XGMI_LINK_NA for VFs when in SRIOV.

Signed-off-by: Simon Louis <silouis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index aad530c46a9f..7a24fcc41638 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -44,6 +44,7 @@
 #define XGMI_STATE_LS0                          0x81
 #define XGMI_LINK_ACTIVE			1
 #define XGMI_LINK_INACTIVE			0
+#define XGMI_LINK_NA				2
 
 static DEFINE_MUTEX(xgmi_mutex);
 
@@ -349,6 +350,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
 {
 	u32 xgmi_state_reg_val;
 
+	if (amdgpu_sriov_vf(adev))
+		return XGMI_LINK_NA;
+
 	if (adev->gmc.xgmi.num_physical_nodes <= 1)
 		return -EINVAL;
 
-- 
2.43.0

