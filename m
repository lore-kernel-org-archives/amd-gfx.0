Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CCBC28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 03:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC61A10E6EA;
	Fri, 21 Mar 2025 03:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLbV/BLp";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E6C10E6EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 03:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrkT5cSvojFsnMW4AfW2Ihzg7eW1rMP0o1kfhakyKPSO1LOrEXP1iZoEPEtm1qwSmzUAX6RMYuvhhLhDjqk2V955vzY9jI9g6J+qFLQzw+aUE1PXmwxRTS2/lQvbi5amsw0EpQpUQI48DBClDbCe4ozwKK1ocE8KUGAVAx1XmdNjYQj6x9TQMEFwuqxvttHp4Y0Kg41B45OXbaRPx96vgqXjVnK9YNf0dvzlhvG0H3khcAFWk7EX0Nbch/ueSfzttDuiPfSbcVCpqHzE7gB1fL6ajb3kDx6RIFU/QYAf0VL2VjFgz40m5gGzhs2XQRLWAEXvjxVLcDMJ4HdvGW0RDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b/Fo4d6pJ0zntr6vzMcEGz8CL2ZXTEU0VEVBbl8uQ8=;
 b=WUlkPQ8CU7xmidVk3LPQs1/T72vYHC9dEYDDq20NdBxEm2hvt/xpEQIl9umt5cYbqDTDXUQaKAM+y4017TagJblw6LaObUUI8HD995O+282eloRVz3HmJZzemb27TtupbTOM5OM1U4IpvhF1mcnLXP3JlAsaWNhOEc1BZ30TUimYixOp9kDe8tgon22WbsgiL2WL9i9S5gYTDCvLbYlp4PWjDbMGzXbG2s2kqTKKCkASnwfve6HNk58OWK8oI/zNivZH7uVCqZNinNOHLfQBhqAqc0KauNGiaiueFRbEvQls/+aMh/LD+Cn4gkEZatTyxCgJyvXb2GldafEkc/N9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b/Fo4d6pJ0zntr6vzMcEGz8CL2ZXTEU0VEVBbl8uQ8=;
 b=SLbV/BLpcU9GVbx5ZQYdIw/Geppj4Q9oAq4gKKrYOp5iQoyAgl8HyffmMjE+cNemuJmIRNDdn7VUHUBk5nyu3PrTWPLT+ibE9+5YZ9ldaXoWWcrQb9Yp+MXs0vGhSKYSInBA772H5enyN9D1Buwj4Rg4h53OZmkf0ea5/Zr3wi0=
Received: from SJ0PR03CA0154.namprd03.prod.outlook.com (2603:10b6:a03:338::9)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 03:27:29 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::8c) by SJ0PR03CA0154.outlook.office365.com
 (2603:10b6:a03:338::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 21 Mar 2025 03:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:27:29 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 22:27:27 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v4 4/4] drm/amdgpu/vcn: during dpc recovery will corrupt VCPU
 buffer
Date: Fri, 21 Mar 2025 11:27:18 +0800
Message-ID: <172184600af4057a840109659a8e39912ece63dd.1742526761.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1742526761.git.cesun102@amd.com>
References: <cover.1742526761.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: e577d952-609c-49c9-be8a-08dd68284f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jd7Edo3KbESecaBX8dfqIc5NgT2SvylFwvmI18e1An7Vbi1N7gBh4v9aV/JO?=
 =?us-ascii?Q?+9NrAbCgfmeorKmHg8T+xkqY/TWzA78Y9gAsCdCD/H+CQH0MvcKG6Kx9rW20?=
 =?us-ascii?Q?OF6a6XFp8bEH6RF7YDPK/nzk/TU7AgisydKI4fZ5IPJIK8R/K8bYHwwAb2lo?=
 =?us-ascii?Q?Ha5op341GBUNeiiRjzckLvDRXKaA6oCgu2qG/dPilRWLacjI/2hL7VbgdjH7?=
 =?us-ascii?Q?gp0608hN9eBKQhAl9I0FxFoYKIE6oJTcD5SZEUQzuoElaSinRJ/C9XGp2+6q?=
 =?us-ascii?Q?OZXTNbLMBh5oV7QcOP5CyQ+8bRUwsiVse/Hn8iQMFWCViliKiM0BL1G3zb4j?=
 =?us-ascii?Q?euhbAahvMZfrPYCyKdAAv6cQsYA5owqe3SCuyibgY8MbeWDqNPJ1Lbeijjr+?=
 =?us-ascii?Q?fbFJ0wOhUuTaooFoWUajWMi7JnObWNGmYDBkZsIStUiWS4wZzMZqte1ku/ya?=
 =?us-ascii?Q?JQGhvVW591DBv7jxh9uaxEIcBfj9gn29SamB32sv5BdUrxPwjWjpXPsvQR4T?=
 =?us-ascii?Q?MXXwn9vKO1i5c0xmjnVMUlcRC9Yb66QSDWJST/+RtxEHALEEUy8bKu71dpMT?=
 =?us-ascii?Q?GKF4cbgLr0IqMbs/LKp6QvyphLrxV6b7WQYzCK2ohRcDP1+Z23/EvnFyLwoG?=
 =?us-ascii?Q?oovZQoay6Kv4Zyx7TodS3XANHeHuKPl5d+lTpDXnJwxPMsHVnH3mUBLMXDlC?=
 =?us-ascii?Q?ikt+0/yCt7UuRh8CeWnk9pFUGOTAMJjkmQcPCBIjAslFsOj/K/AoLlZWLaaR?=
 =?us-ascii?Q?WichZ0t6qlkKKGSfSpyUARJFKRWdfvXZkrg7Yq7bfPbnSIqR/tIcHihRvoSx?=
 =?us-ascii?Q?DB4Dp4mU5eRmGYM0U0ca31WOO8vteVPyPwxJuDKVN3afcBslNamTVjhIWm6D?=
 =?us-ascii?Q?P9V039KLsjV03bOMkvF7FXaDht6suMcsl7aQkz3gWHBydkHtMru7/D8+r2hV?=
 =?us-ascii?Q?7ib0d3TIbJDs7gcMxnav0sUEMZEQpJvoLQPBIUkZiYlewQiy4iGn8tqDet7I?=
 =?us-ascii?Q?Kiam7R4W0dfXPmkTWcjBDPWRWW4aXWVTiGVYLxg1852o/iUb25YVvYOAuKIo?=
 =?us-ascii?Q?6NkTlFF2GnErkUsclE67GPDPvCjVPcX86u9K1AbmzdD0RPqNGRrOwO+E42Vf?=
 =?us-ascii?Q?CyI3vEglEFJVQcjt7oA6beTu810m/pvLZBFZ1evugnULJnBoUc/cd+8rIKsN?=
 =?us-ascii?Q?d2f9lbTCqePBo5gGU9eqB4TbaX0FeiNsWawaLBUo7+yloB6aJecSh8YxLkuG?=
 =?us-ascii?Q?0o9uTNX+xWjPE5Vn/usuOPtb8a5k5xe4x9IybGbhElCFe1ISrW8dunNvZ5Vs?=
 =?us-ascii?Q?joXsf8l6Zc+I7m4WGSDLgStSRj+cpfoHhcH8F+XwVC+drpqBGiJcfMWmHb64?=
 =?us-ascii?Q?rnp3RNN95I3Zy8H70pHvIczRcF1VUnr8fG+LWUIYxrZHpw6941iiUYNp1ZVp?=
 =?us-ascii?Q?ctXeRU/M/kOMX3DrL0oksZuu3HeGaOUIEvusYZCeGDeaaNZYikpJhYaxfwyz?=
 =?us-ascii?Q?2yLfAaFYx7OukgY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:27:29.4505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e577d952-609c-49c9-be8a-08dd68284f5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

err_event_athub and dpc recovery will corrupt VCPU buffer,
so we need to restore fw data and clear buffer in amdgpu_vcn_resume()

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 8d8b39e6d197..d8cd5f08ef05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -353,9 +353,9 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
 
 	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
-	/* err_event_athub will corrupt VCPU buffer, so we need to
+	/* err_event_athub and dpc recovery will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
-	if (in_ras_intr)
+	if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
 		return 0;
 
 	return amdgpu_vcn_save_vcpu_bo_inst(adev, i);
-- 
2.34.1

