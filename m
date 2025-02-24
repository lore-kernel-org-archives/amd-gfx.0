Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47109C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 14:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9E789BAE;
	Mon, 24 Feb 2025 14:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vYw2YKgD";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BCB8995F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 14:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCPw9GNOKsPyh3ig3vZ3NX8ssR+DB7RM2pzzBkLFWvngmufWhzcO3NThR/XDXdXz0UFCCadUuutVlcFmsGyHZCjxLx0DGJMyn/rPsyITVCYo8ZoT7ZPSH5AVI/H3YZpHYPuT4NOiVIlg57WoKchFL5fB/kITiTTyXuIhoIXTo3JOdrQyzqjtB+9wEaJBQogDv5iyWcORRXDgcI+v1h6UCO1mjEK8F7V+uqPaEowg6rP2cvWACNyfdQnqWDRhOuduHFPIwXHIu2IMyzovOzzndBGi7LAxrjAOg1jQoZMygGCfw3uJ47ZDjgk7pIXohY8Yb7jPDDVJQ+h8ZH/34lxb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6qYCmh8nw1CkrOzllhMRMgpYnswnKeOUXIhKwcJmT4=;
 b=jK9tnRtPctuaeU0E+NAW/ZIQ93h+SIbYxO0+YARbspvfjTLs7c+9r7eRd/2px/wfKntIClAVgSslpewV+Q4/BaXrwkRD8LppmtIgVhvdgDzVy0FZw0Wlz388dcVVfqRhSkwpVZcdJSztMMVXGACt7XKw97EC4oAtkSg8/4clXIiUR0wxNUtMUxEWRkfU8AFILhGkzLS2VBjj8y1QPvYcKNz6xYB3bA4KbayRJ86CDnelzIgMrodgBTDgxRnobDXktuFIGYNjdbGJ7Td44M0G+qq4vnGcSfM5dRuNBSE7fk06wMzq9ADbZj+5/8j/a6egKKUHuSE9ilRKfyl5Igadow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6qYCmh8nw1CkrOzllhMRMgpYnswnKeOUXIhKwcJmT4=;
 b=vYw2YKgDv6OfZU5quyYyCYYfidTo1piF4IFxUYlVTFhOhNbLniGSvxSRvAY71k/pyqQ6gKRiEHy2OaW9NWf6xnKrgwXRUP+NfmqyWttJc7oEa/R1730TFMl0Y6Ubu6RyOt7ty1LNMofewgxZw9sNJjLL7PDGL4QE2M4KYTN9NTE=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 14:53:52 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::a1) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 14:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 14:53:51 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 08:53:50 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mario.limonciello@amd.com>, <Harry.Wentland@amd.com>,
 <chiahsuan.chung@amd.com>, <roman.li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Disable unneeded hpd interrupts during
 dm_init
Date: Mon, 24 Feb 2025 09:53:28 -0500
Message-ID: <20250224145328.18126-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cc41c1-983a-4b39-c428-08dd54e30d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uqpb2sJaEKJ4Aue1yG9vt5w7dmj92JM19kYagUEuQj29obqDjqU/TW61+JyZ?=
 =?us-ascii?Q?oXR8BBCb7/KAJhn6XQ/LfMgXCm/aBrKnlz7rmpsXfhyAgMFEdFGIX8JSOjRk?=
 =?us-ascii?Q?XZwruw+GW81UtHzZWDwQMdT6qEhUVEb5GsPM41StLhCzUoERW8bMmvxlGfUQ?=
 =?us-ascii?Q?3orkAC9U1u23+uA+TGC9mZ7LDajz4zwHpMAkkacuyPB10CbnuM8OpH8gvK/r?=
 =?us-ascii?Q?Es4iXv6XW4O1f5vjs6gLi3EpcLe0znSrRGU0Gv4q3242eBYM8Rb541tgLQGD?=
 =?us-ascii?Q?vt7kVGCTEtwF0jZBZ2jKI/aGhVOW8WjaTyoO6LyD5HdLA1wMHxQLyP+ELDBo?=
 =?us-ascii?Q?F+u3eFwSNcOpNRDS+Rc0Qp3IfEHkH2N3D5Dapc3ohz7cBKONfw+7fmp/AGvx?=
 =?us-ascii?Q?gWW80WA3QeoUxiZTSPpO0WfadMG3u2hEtGd9Oc/faYw0XYvfDe0/OX9V/H9E?=
 =?us-ascii?Q?WG1LswOrRUyzfTK4gKerUMQBajF6Fr9O0R6kEcHjgQKY4VeBeN2VPbSttVpE?=
 =?us-ascii?Q?7bEZpYvOoxNCSVKronbDa0mD3UFM0NR1xGe58rNb5Fd2y/g5AyzDfR9y/Dq6?=
 =?us-ascii?Q?Xu0UfRLr0QTZgXW8tH+xv06vnsf0BSxio91rpBp8BdrlR9XTyzWraZh7d227?=
 =?us-ascii?Q?CHgxSGJjh9BGYxm68GyaQB++SIln2to6M8TfWy3nhL80nGl2aGpAp5aj0L9S?=
 =?us-ascii?Q?8Y1/kI5OGpP+rW1scpMyMU8zgfJaqmEqaJ6LQhwYV68Iv1X7wNikPBryAAeU?=
 =?us-ascii?Q?YbnR3ZHAKpMI30zxU9j8hpW8i7SPKZskop5bycnV0tvid1O+OEBeOShBgJdC?=
 =?us-ascii?Q?PkQN4MruHWtxfALaSAjrrKNcbJWYQUG+i1iAsnI9mRqLbh+lMBJnUXmShlOC?=
 =?us-ascii?Q?5IahrShKKKfGu+5FvvMw+NPTUK9Vd8rYNUEflmvLKrYw4Arnog5uYgiwIXOA?=
 =?us-ascii?Q?BFGDUdpapL3mgCUtJ1aHLZOi039I8GbRvDlsOI4Q51MPG0XG8YWaAQ1pmdjO?=
 =?us-ascii?Q?KLdM0ECRkb4PLkkhPE8KEe/ka67thMJkXl/V26UPz7ZwQhRZWHVlE+PtjxsE?=
 =?us-ascii?Q?pP9stbdDBxUd1c8QnQ58rRwbeNWRL8zPj1eaRiTZuNibe7qg5kNBsDHLfyxm?=
 =?us-ascii?Q?Npv9DYcPZmPyvCz0sMMbq9ddpQX3S+KDaYFC0VvYMBRsOQRpeSE1KddrQL/4?=
 =?us-ascii?Q?Uy3FT7nfNCk7BF+25EitNSra5RDdBRT+WitVz3PgpP/5SJMZGJ1dgA3V8O/V?=
 =?us-ascii?Q?bhD6wNmYVgwNGtJ2cF+UNJP08mOQhK6vG4ze8FP91/9w0KLoHCO0gn/oSLbO?=
 =?us-ascii?Q?bI7VGeNixgYhQ9CZ9b8ZMoL3ykLeZrfJAyVhdxlHN6fiMUxEtlUjQsYxnDh6?=
 =?us-ascii?Q?hXznd6HiywTaXCC23jDB5fUw4fBrYIxrPGGjz+xQV8+DAJpOOcR+ukffXB5S?=
 =?us-ascii?Q?06dX1aNcYyQ01OWisHt8cGmMqhJ6y2kWVKW+WdSNxrx93KKVCG2MIR3gY2h+?=
 =?us-ascii?Q?KrEQcT4I+AuSm/s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:53:51.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cc41c1-983a-4b39-c428-08dd54e30d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

It seems HPD interrupts are enabled by default for all connectors, even
if the hpd source isn't valid. An eDP for example, does not have a valid
hpd source (but does have a valid hpdrx source; see construct_phy()).
Thus, eDPs should have their hpd interrupt disabled.

In the past, this wasn't really an issue. Although the driver gets
interrupted, then acks by writing to hw registers, there weren't any
subscribed handlers that did anything meaningful (see
register_hpd_handlers()).

But things changed with the introduction of IPS. s2idle requires that
the driver allows IPS for DMUB fw to put hw to sleep. Since register
access requires hw to be awake, the driver will block IPS entry to do
so. And no IPS means no hw sleep during s2idle.

This was the observation on DCN35 systems with an eDP. During suspend,
the eDP toggled its hpd pin as part of the panel power down sequence.
The driver was then interrupted, and acked by writing to registers,
blocking IPS entry.

[How]

Since DC marks eDP connections as having invalid hpd sources (see
construct_phy()), DM should disable them at the hw level. Do so in
amdgpu_dm_hpd_init() by disabling all hpd ints first, then selectively
enabling ones for connectors that have valid hpd sources.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Cc: stable@vger.kernel.org
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 64 +++++++++++++------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index c4a7fd453e5fc..a215234151ac3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -894,8 +894,16 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int irq_type;
 	int i;
 
+	/* First, clear all hpd and hpdrx interrupts */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
+		if (!dc_interrupt_set(adev->dm.dc, i, false))
+			drm_err(dev, "Failed to clear hpd(rx) source=%d on init\n",
+				i);
+	}
+
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_dm_connector *amdgpu_dm_connector;
@@ -908,10 +916,31 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 		dc_link = amdgpu_dm_connector->dc_link;
 
+		/*
+		 * Get a base driver irq reference for hpd ints for the lifetime
+		 * of dm. Note that only hpd interrupt types are registered with
+		 * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
+		 * hpd_rx isn't available. DM currently controls hpd_rx
+		 * explicitly with dc_interrupt_set()
+		 */
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
-			dc_interrupt_set(adev->dm.dc,
-					dc_link->irq_source_hpd,
-					true);
+			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
+			/*
+			 * TODO: There's a mismatch between mode_info.num_hpd
+			 * and what bios reports as the # of connectors with hpd
+			 * sources. Since the # of hpd source types registered
+			 * with base driver == mode_info.num_hpd, we have to
+			 * fallback to dc_interrupt_set for the remaining types.
+			 */
+			if (irq_type < adev->mode_info.num_hpd) {
+				if (amdgpu_irq_get(adev, &adev->hpd_irq, irq_type))
+					drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n",
+						dc_link->irq_source_hpd);
+			} else {
+				dc_interrupt_set(adev->dm.dc,
+						 dc_link->irq_source_hpd,
+						 true);
+			}
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
@@ -921,12 +950,6 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-
-	/* Update reference counts for HPDs */
-	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
-		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
-			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
-	}
 }
 
 /**
@@ -942,7 +965,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	int i;
+	int irq_type;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -956,9 +979,18 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		dc_link = amdgpu_dm_connector->dc_link;
 
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
-			dc_interrupt_set(adev->dm.dc,
-					dc_link->irq_source_hpd,
-					false);
+			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
+
+			/* TODO: See same TODO in amdgpu_dm_hpd_init() */
+			if (irq_type < adev->mode_info.num_hpd) {
+				if (amdgpu_irq_put(adev, &adev->hpd_irq, irq_type))
+					drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n",
+						dc_link->irq_source_hpd);
+			} else {
+				dc_interrupt_set(adev->dm.dc,
+						 dc_link->irq_source_hpd,
+						 false);
+			}
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
@@ -968,10 +1000,4 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-
-	/* Update reference counts for HPDs */
-	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
-		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
-			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
-	}
 }
-- 
2.48.1

