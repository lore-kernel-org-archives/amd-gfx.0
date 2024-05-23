Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00170C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 15:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25B010EA81;
	Thu, 23 May 2024 15:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzqtIFBV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE9910E9E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 15:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDkwzX++YiF0L6sIq4e0huu8Px53aAHABT1MGxXH7+RE0KWolgTrWkDpG/b0V5HhmtXAr1vR7GnZWfcT6zMazcHGDBi2ZwdFlNpaBnBunZpMwXCUpY+lEU9BDH8ehdPyv9hVBGN1KAUxxaPVZ4BE7N65CHatndeaPfkTYTMsBDKM3/qvIrS82lsZwqA+WLlFIw3vTgn0PK+yXgbIutqz9REWN1+74aM7lXJ1yyy7yC/n0nlhEJwcJbM0Y4HG9GWN7WePFaC/012SvaYCCT6Th1R3+yXdLXThoLrzrvrta25M7BqoOwBGSChRW4L0lCmnZFuacZJh990GMc8a7/o1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0St8FkX2c8xOYa5O2PneBAY08nF/561wfheyiqkNo=;
 b=X9SvSN+CWP3vp0e666P/iReCZptXn5eepIycIGohv4x/ijCOknYb48NCFhE33+HFhJdQ8ZQ9kUnZ8majJYwpo0FN6ML1V5X61P9V6/sIqbyG0pAhgVf5trWm1cEmC8iLahUqbIfy5YHx0mbCQOxfi0oROz9fDVMS4sIu2nv7Lu8O05+DxO2XRmN80qr82DawBkiW/oGZFEs7l++ttUEXeag0hRMRpXa7GQNCJb6oVeiGCTL7zTryIWOXZhqUuVmgTxnPEyCDlqum6lSeIGiCE88vSWcYHBRprC00rSFOrr+YFBCYC79HqFTDdOWaWZxAq2hp1CAy+0TXDCcKqsEHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS0St8FkX2c8xOYa5O2PneBAY08nF/561wfheyiqkNo=;
 b=hzqtIFBVlip16Pki+vEDR1u2HuNS9+INXsitjOhIcxJ1wPOTjdqf9w32CnUlTyF2Gs1ftoULfT/2vbaxCp//nowPz5TKT43U7glRB/0n0Q+GHnkfUeeo7hNe6XDLfn9HdluwqPMWRETWhWe2rqBFxspFoCZf1aBhFSv2Iyw/Frw=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 15:04:50 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::2d) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 15:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:04:49 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 10:04:49 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Date: Thu, 23 May 2024 11:04:39 -0400
Message-ID: <20240523150439.3274992-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9388fe-4102-41c8-d156-08dc7b39b16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F2PfM7eJurxAOhOOLSchmg/lTml7J9b6RYMQSYN4Pfa6i0YcDkllgCKvtzhi?=
 =?us-ascii?Q?VdchD7v1r2QH9DuajDEalzPFs1MA+whZTrVyDpHiZ4SZgzZsCbJxfSa6feB8?=
 =?us-ascii?Q?w4oulDmJMri3b+PcNaecq/h2t+l+U3gurZhI8O9cR5icf4B2Hy6qgqfDba+D?=
 =?us-ascii?Q?XYL9lnewfYyAMSsBSJ9fk1IIKjGeHYImoyKwDeHUsAFfpkuVWxEPSxuW1yo4?=
 =?us-ascii?Q?8Mxs15aRuL+0R7R5kCjbReZlOKHL76kgk67GcVbj/yOF+U8MnkjKD0pdlwoi?=
 =?us-ascii?Q?INhyhGaSIU74wAar50sN/JFjhniAsp2ydNsVyhLIPVFnWvqH9XmJRREySgVP?=
 =?us-ascii?Q?22mcpuaeLjDcWng2dgUeIGYEubZanVAC4bfbcQthjx0PVZXzPOHKr0slldKf?=
 =?us-ascii?Q?4Ihhay2QrlC0ctlUM7vW7wVutlOKikyuXWMaFhZIZf9noq0Z4iTyHR0PZngV?=
 =?us-ascii?Q?OMFwuzAOBesutd/Zx5R16wUxKGl3ycAmXky06pyjqgtUhRd248Cj0HGo+ICE?=
 =?us-ascii?Q?1JwB2VvqqbM774+fIsKGEcFfPouUEwOuZy7W6nzMa9QS2FJMaKDeR8wbX+07?=
 =?us-ascii?Q?4uFnZPzooZV0QEacaa9rA+9SmQnMYYy9gS+yLc1L96i2kN2GR8+N8IwWCm5L?=
 =?us-ascii?Q?f3EhnKYXOs2ZxN3Xa3w2qqtNLY6Q/LAiToKqmDLKifdJHRuCy7tT8AJkzlRR?=
 =?us-ascii?Q?d3Q0IadUbjnR9LuXVim/lhJGOOSeNZOMAY1CJqlfIP5C4GLHMy7zw0+rrlUU?=
 =?us-ascii?Q?JQUR4Mln/GkYWw3Z6VL0uqVFHTTmds0xT++JtNV1lp2O8yrZf4bqCOMbETFl?=
 =?us-ascii?Q?edGw2i8QQw9+fj3TE98PVhYUkOQcHO/g/QRzCB3FpjkRLKaL3UuCSF3sCW/0?=
 =?us-ascii?Q?3QwB+Srj+QCb9eGg66DqLCuBMW38g+bo/dxgNJsCIEc9Lx7KE63lx2go7igi?=
 =?us-ascii?Q?QCnSBWRAMiZEISNagrPQZrwwCEPDFa5DKxhO1uUC0BT2jOxHyGCidJDtdQpM?=
 =?us-ascii?Q?PI/WPZu+MuqZR49MZ5N/DxTQhH2MJYw0lzjCZe0rDRWDILOCH6g09tcB+R3+?=
 =?us-ascii?Q?j4u0wMVX+q4V+iYeVJ5il6IY+40i5drgni9CE3UlXY+eedNpnXKAHy82zDEr?=
 =?us-ascii?Q?XzJM/AZxhsnEbFJ/baNabEmrE/Y/8hCK4oMiQPLvgnRx93xV9obPdroO9t9x?=
 =?us-ascii?Q?E5VTsfX3c0wzoIEreXBIODIurT3Xo1EN9z8JkNESYQCsJGkmPUIw/jwfw2lQ?=
 =?us-ascii?Q?RRHf6SwmpIU2XsBBge6AjibphRsNxi6u/SKkgDU0yK8VeEWiWPqJL8fQ1fmR?=
 =?us-ascii?Q?euQOCQzTBpcauGndH1ltwakza5fbu+0xO3Jrbw3Gwjc9xYkk+TndLN2c4bsM?=
 =?us-ascii?Q?Jz4a3L8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:04:49.9037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9388fe-4102-41c8-d156-08dc7b39b16c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

We have messages when the VCN fails to initialize and
there is no need to report on success.
Also PSP loading FWs is the default for production.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +---------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b89605b400c0..5e2b7c340724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1078,7 +1078,6 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			    IP_VERSION(4, 0, 3))
 				break;
 		}
-		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 64c856bfe0cb..68ef29bc70e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -145,8 +145,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
-
 	return 0;
 }
 
@@ -549,7 +547,6 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
-	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 36d4ca645c56..070b56610c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -200,16 +200,10 @@ static int vcn_v5_0_0_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	return 0;
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
-	return r;
 }
 
 /**
@@ -1122,8 +1116,6 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 
 		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
-
-		DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", i);
 	}
 }
 
-- 
2.34.1

