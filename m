Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AE3EA3F18
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFC810E4D8;
	Tue, 10 Feb 2026 08:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RRsCYXp3";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5813710E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 08:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxyXTWzd75a7St1ZfwOEy4Yv7uIBsbp2NEpc8+0p2xMYaPauOj11lfmvEHjtZj4S+VHERiEb3DBJt5OrbgIxcTwoqOZP0zbKHVrNqSjGfqNYSExSODtPrQgjAAVAacQR16vOP/PJgWU2RRQjUkXXn6AeHV0pipjE9fABhhp2p+WonVLQOMOkiO9nTOu/xKY2KMBuNmHurwgLx6vMFDf1o4vMK/HKdYGOn5n4fRLqT//V5rO+wq/lFOVeMnVxZmgXMhB5HuTrvTbieGwwbFF8tCdFv84rAndnPzm81tTongXTEJN1xOrTR5Z4BPAsU3M3eAFcY7OHMJuSv/38zXglcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldz9hlaSizVl83xXI9aOqz9tj/fSYcaZr69d0WTwGc0=;
 b=DVTm6Wddb7sbqI2lRpLCopDZPrVtQwrnYmSClXnWEVajhwfi8SfOTMloH6J8ISXv8avyNTikMR6ROH0PKVCVikU1PfPxYOQTS7RxxtnOp9ERlYP+LGnVwULl6cqDo6TYgkGBde3EDkQF865k4UfJx7UZA3olA6goNfrWtA+GoH6R3tILXyFQU86484MEkLSSJcoLfmUyzmYt0tOdJ6oc6DQCbJx6AqK8H6p0F/CM079bq2IXsXe/nZzFyzzZc8/2TQNp3QDY/XXPWfVh8ujuO3vmhkmMtv1fH3buxMCXc1qnkVSJdCggUj2xdf8Z3I/C5ODdCHwdlxYmZfKP6Ne5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldz9hlaSizVl83xXI9aOqz9tj/fSYcaZr69d0WTwGc0=;
 b=RRsCYXp3klw/WJZCtRzxeWbpiRwdoeBUYWsuT+eVR3p4hYZTkTnj+J0ItLlddTbl4YJUrZ3tbxVKCO/yWbEQZlPeeZ3oqDk7UFpDXqvlQxvUUfLBJ33ibw9XKh4Va2WxUymYXUkx4rHX6B+7Iqsd9uFsSUxh0KgBcrFfEP6fthM=
Received: from SN7PR04CA0182.namprd04.prod.outlook.com (2603:10b6:806:126::7)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Tue, 10 Feb 2026 08:08:19 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::28) by SN7PR04CA0182.outlook.office365.com
 (2603:10b6:806:126::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 08:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 08:08:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 02:08:18 -0600
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:09:57 -0800
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] amdgpu/psp: Adjust usleep_range in fence wait
Date: Tue, 10 Feb 2026 16:08:03 +0800
Message-ID: <20260210080803.3018126-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8c9b96-c7f2-4678-bbbe-08de687b8cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fYxk4/wenn1/tE8+Td3fDlvPM4Z3g8G+tjU3P52ZMcndNJVt2bx5C/2q225/?=
 =?us-ascii?Q?TpXQZqfFQmhnMAuxMVN4Q0XkvSH/4EyXqEFe6kXmPLjwXtmtPfKQ4EQCfhfT?=
 =?us-ascii?Q?VW3KcnXVOIITTxu1eK3rcAQUVblh5FuCt/RATl9/UxQNCj/+QJIbL0Zk0Rgn?=
 =?us-ascii?Q?ZuYJY3maC66r8QaNuVJrdQoteb5GA4oLlkAePacwNEv9voCVxaCd0TxroJZW?=
 =?us-ascii?Q?iCO3Q/FgH6YOyvE/RrHeSuTovnR+Un6wo7pS5FYZPTM81qqnrDoiebnWoT57?=
 =?us-ascii?Q?4QpXIdWIlR7A5Iq+wPXVfkDCzr+kKWAb/yVG/t1GJPiUSueZDVI/itoiGpM4?=
 =?us-ascii?Q?fqYhpsDXg8bfNYbBfzId0GSu92nzqDu44Wqvhgaj5Mtp5iO1f2PIKuFJ4zBI?=
 =?us-ascii?Q?CsuppIDxDVMwec6yFGJIx/23fkuH9GwLGWwfl546ntUJCXIApOYFkFN8u39f?=
 =?us-ascii?Q?EBDnkXsBZpFiYyPe2u1p1qkmuczneDSqYEbgE+tpxDoQH3R03+hCiTcldgqS?=
 =?us-ascii?Q?7u/lb0IUcm7W5RBguvZJ5UlV8ah6BXMiAQdLJ9hr7cgkNIEgR/nv1iPQNOki?=
 =?us-ascii?Q?ZOdpDuRTR+pOitTdtPsTU1FOn2KmBLjJKnWjpGjo9720qAr9KZlIRtV8Uhji?=
 =?us-ascii?Q?PM0p9vdamU1pH3wXEK+pz69lQ+mHrxmrudj2SwKzrgEmJDyPwkc8G32irDNg?=
 =?us-ascii?Q?Fk3hiimAMoP1TOZRTTjQhipEEbBwrifVt5sIsJmrTmmSqyygPns0kwqiZCwt?=
 =?us-ascii?Q?pBmVxWfIYsBY42LkeK1wxd7OreJG+nEd2t1FOd14Umw+28Jn2aZdq1l63vD8?=
 =?us-ascii?Q?TxYyhITIh7JClZ86OnC/pd6dT+/1vd7mihoroQWKcZCjoLZ7Zt2toBk9FdnA?=
 =?us-ascii?Q?Vv0vro3J5XkMoxmcJ0NeNdu4Rp8Jao4YeJBU822+8IzcfH5Iu5b+Tt9YJ+a5?=
 =?us-ascii?Q?P+4tf9FHL0TIsffRazT20lY2hOSDlJqggZGSBMzKfQQgaOgee40eTU79lPVb?=
 =?us-ascii?Q?dWLab64Wdzrosm1kGGQM5+RDYg3xWfjgsNALacBI0Uc9WNSvc1HUqcSwn9az?=
 =?us-ascii?Q?i2A01PXNbytOut79kz9SKCK7KJJkKByEn+Xd+MHzReXzbLVZGC7V44NCuyMK?=
 =?us-ascii?Q?BzPG1xrXKS7sVpIiB2589X9zNlHlRmyfsit1ol8KQmSHe684YCj81MFPqyPo?=
 =?us-ascii?Q?N0c76aK9iYCnQSecRWl7K40hICxLmzh9r3NH78PRWJKQ18/wuSNbz05HJ6xE?=
 =?us-ascii?Q?Q9FfxeXDG5oX6IKDG8w7UsnpAsfd9k/pWMpP/dw6FP40z7wb8MYq6oWHy9QT?=
 =?us-ascii?Q?+7dqK+cw+diTd6HC4VUDKIJwPgSPS8ECzVGebX6g3bS3fvNJmfpqXa+oGXj/?=
 =?us-ascii?Q?cTk76klNcZFi/BWPtPi59zQoEW4Psy2nHJFG2j/leXXTDgaSvok+JBEVuIKY?=
 =?us-ascii?Q?P3GqFe/287vZP9aQbt0WTjuXq5zqKF9Ypd8PAo2XltzF1tNaKEfsg3IC6T7j?=
 =?us-ascii?Q?ahbaIuXIgLnx9v4EDELGsfgvCvlbxugl41hhDCv2tYNy5LqYJZIIm/arnnT8?=
 =?us-ascii?Q?0aVObRymejILPEd63AL2Vkq6Hz8AzDJbofKuUNQxdVlqaTVJocBQ7XcTkqCz?=
 =?us-ascii?Q?t/dPP5Jv7d9wnyPmYJRHB5klDbFmCe6SqMtbeddjj3TZSvc75bOuBaUl35Lc?=
 =?us-ascii?Q?BCKQGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gQw3SVfwIpHqPcMdSkq4NzkxwLF5MjQPz0xg+QjugoulRQSjsM8+i405jsH9PxdBEi5uxv0wJliiBmZGKQyOE30CGy1DRiTY2mp/0WVhjejFlwfZ/AH2bskQ3Kd8hISp9rPTkqM+QhhZ8gaeDD2Of7Emr1Q9mAsSn5MzsXhfCHJ/gQ7WTxnMCRPICt83U7d/NE2ZEOkS/SQGNgAaklUpR6wxQhqAcx5RfhbopjnnZjpSzTtXn/q+igbF6biBLHfPHCOfF1PPtg54qH0uhilfhnTgtLQD31UBuS1QcHtu7Gtjj+Ti+xl0hKahmBnDDk4uoXvyK0BIrLiOoEAbgVnQwCWyNp2kY55lZEndXoo8M/clnfnBCYJRT6uxNv/LufkZ5szAUMFU3X3mLI3Fu30pspVk9Oh0RR4TKqJ3CMMkXu6Wi9fMhxALOGz/1iq9VNcl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 08:08:18.5725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8c9b96-c7f2-4678-bbbe-08de687b8cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

Tune the sleep interval in the PSP fence wait loop from 10-100us to 60-100us.
This adjustment results in an overall wait window of 1.2s (60us * 20000 iterations)
to 2 seconds (100us * 20000 iterations), which guarantees that we can retrieve
the correct fence value

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b0540b009e84..5eeea965032a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -735,7 +735,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		usleep_range(10, 100);
+		usleep_range(60, 100);
 		amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.34.1

