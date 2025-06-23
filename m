Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F16EC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C075E10E343;
	Mon, 23 Jun 2025 09:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VUSV+zdT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D862A10E343
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXkeymH4qeKPAYdBEY1VPqdP8FKj/vf2yTm+LgFXKbzo8O4uh3pvWupnIxt1NimFIQiWjhoRXoHhahjLla+g3Id78cSFjBnrzW36aKXo6QM6lgg0ywUP8Y5RLdVOrbYJq7f5eOQLwNi1e7QkSn+fw4jNlNxDH5n8Ot2F8kdO7cKFHV964vczL/ExEkAB6vxmmLSyYx9lM5Y2BPkK0W8uAyX8Ew8vnXzroq7L5u2Czz4G3/8SJ/7RAQW5jW7EqIgMZN334jmUzI9JrQUoE+o7Iehzz/LAl9MI7Y4Rt5/azl0pRtrCZS7z8Ucf5/UmkWvvP9m2OnMX346QLT+XdMMu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTbsS+t1QnIXKfZLAImVQvlc6r5CTHaX/UCDNMmUAck=;
 b=c8kNsuWi+zK4EzV5gONfvFuLj0V08j/bPj/G1kZ03vfhMXACQlZjbsasqGAefl1ki/Q6vrrOWAUqTPC1C2t+D5B3HzHVwraXm2LgQRL+8SWNr8ZrPiQoZqXcw9IFrQr3UuGyWoHrTemT+CfbmMIH4y28Ir1vuaHNh4L2JyZjAs+kwwbHkvQgIP+r5YG3xkY4UxmpYOM85ha1AIGnjuXbaOhyByUrMTGDbV7Y6dGx4Ioh9pxLbxhbNw40GG4cq0/Vjr2/aUk/UYBZ1s4Y7/M83zFlxj2k1D8e6Jo4Dx0bALvHyqh2MFrzi+8MWdrUMEbOefcikmtOAcwqExlCT02piA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTbsS+t1QnIXKfZLAImVQvlc6r5CTHaX/UCDNMmUAck=;
 b=VUSV+zdTDu6IlmfvPPrfCgPr55IfhtMLaecEupPwamlJhUmCzL+LhrnxFAaB2T9/sshCf24n3SY7HGMeVwA0OIrb1BxieReUvaq9X/ih0CdeDNt4OOpIGDp3E2xLpTgojLwgLouV34e1Szp+ioazo9sOuo8NtRtZHswy6voXIHM=
Received: from DM6PR17CA0018.namprd17.prod.outlook.com (2603:10b6:5:1b3::31)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 09:52:09 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::d) by DM6PR17CA0018.outlook.office365.com
 (2603:10b6:5:1b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Mon,
 23 Jun 2025 09:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:05 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 02/11] drm/amdgpu: validate unmap status for destroying
 userq
Date: Mon, 23 Jun 2025 17:51:45 +0800
Message-ID: <20250623095154.1150830-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: db32f017-8d40-49ef-6805-08ddb23b9eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mI4PyyB9qbR7j57/SX9h84xXrfPSeuzWs1XSeNfy37okr/yu/RoDBGUIE0iq?=
 =?us-ascii?Q?/Aru9WvTo0y7fUc/dpc00zNsZt3+jH1NKBvygT1H0xlI+AZEKgSJVvH5+NKl?=
 =?us-ascii?Q?Rbmxz32KEnGsm4O8FJMfhNDc4UVibmw3YSdRBTyYdIHjJCVukmi3hemkzLz3?=
 =?us-ascii?Q?BveNuCxe5sCR4QnFySyM2BBsZ+NfXrgoxMmVAw1O5vL2GyiTyuBwju3skfm+?=
 =?us-ascii?Q?g/qyTgvClkM9JcWOCSBl5V0fvCRU4micIrFzfm4w7iIQ89R1PT60/0IvypnG?=
 =?us-ascii?Q?vTLumZtUTQVtfrkinURk063RFxa27ZjXARzcyEVqVTT5njBCs2z36RuG+ux/?=
 =?us-ascii?Q?CiKeTR6SFK6MeVJemjsJgk5F+PpSNZJ3UYghHIcv7l6M1sSnb/AtXRrM6lYD?=
 =?us-ascii?Q?UPu2XIwkSD2vDPG9GrzH6EB44Lg0GyIZzOyY1YCvDocx4OO3+QyAgS5FSfLu?=
 =?us-ascii?Q?ybUHZq9KbgHiYd+ihBiNfh090FQZE5+R+2sLhkCKElOXjH9cBtkHmfNNrLW5?=
 =?us-ascii?Q?N+pVcxsiWr3fojAX3YBpPAleInviZmC/AGpSjsA0XgMcPPmpn62sgYBUtoZF?=
 =?us-ascii?Q?Zyg+zOXQXeQPuWZyYqRsQv/fayLdy0yl7N2lyX2s4XYZPQeju9IOMi9wQpx/?=
 =?us-ascii?Q?y857ZnMK8cuZBWyjAsbBt92q/grPAbGEMdcpJ+v10EpyJp6rS6abSYbxVxnx?=
 =?us-ascii?Q?V6bxXP3JOgixHxZri1I37HoT4/qDg99fjPtAK994wLiz3k3JLSgxBDWG78tP?=
 =?us-ascii?Q?P+7gOTzSwKqfBRpyyHVv7ly8s5dNxr15Qi2lyU5PbPEXv1S+dkj0uNnTurtf?=
 =?us-ascii?Q?VX+yo6hG/6j6eiZ+vUukmb1N71jp+ZzF2V95giMiHhCO9UEA07es1fN9DhGf?=
 =?us-ascii?Q?4+X8EilcumO+zhsPbF3qODwxv2LCk+Jp7WHBqMK0ohrAS6AHxcFXmqr0d672?=
 =?us-ascii?Q?/FSdCbyctQvsOnVCkyznDTzWy1la0c86J0F2BcDtUW+MzAluayPq+y4LAcGl?=
 =?us-ascii?Q?JYOhGPYr1+ry1QPL4hbBav+jbp8PC1APXQsCEyQLLPjatgln9VFPH3N7pNQH?=
 =?us-ascii?Q?MKn8vFSC/gMxFmQca4cot5x6PgQxf2u1vCCg7prQt4p2ecdxn31EU1xi/crm?=
 =?us-ascii?Q?5qNwn2D/UXnU28TCboje/3QK8lxCEjDnjdtQlzfpbgUJDQutzYkyWHmiGZv0?=
 =?us-ascii?Q?m7dCWtwTjjKsc380517o1Gg0eucdKnEtWymzuzERvLiH3aZUoQMiJNisAbsP?=
 =?us-ascii?Q?Kss/1Cf0FXf5BitEV71P3kbreWduf0z6WuJMFgRlj2z1vJxRaEVF+09hMX14?=
 =?us-ascii?Q?eupZa6xu5FUw2rejl/DLqIKTk3hhhqlRHah/mCaAm6iYCus3GzQItLcVdFFk?=
 =?us-ascii?Q?mJyaW77Jvq9HGuBT3AOPhmEbvFPqGON2AYup1uyJSccu0EH6w8xiV3U2h5aN?=
 =?us-ascii?Q?296XfTxHP3jx79vZK/E6awKfsw/5XodY+UrXyHEEAXHxslWHoqvl8Afg9P4q?=
 =?us-ascii?Q?4khe2nABMroqX0NPK/i+wkFtN1b2HWywjtkt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:09.1169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db32f017-8d40-49ef-6805-08ddb23b9eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

Before destroying the userq buffer object, it requires validating
the userq unmap status and ensuring the userq is unmapped from
hardware.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..c7c9f9e597f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for unmap error*/
+	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		r = -ETIMEDOUT;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

