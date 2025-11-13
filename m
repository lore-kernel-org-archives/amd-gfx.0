Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D508BCD4F5F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7558E10E686;
	Thu, 13 Nov 2025 08:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f4TPGuEx";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3905810E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcYSdPSeAoMrslfkSGgQS8xMH8cSmaH6I5pjw3Ra1JERlsw1JwDYsvGpbPhaE0HXLcPFdQtePMjP203XN2eKE6KXaLpYcTgXtvUUQHG9jC0JMxUnavw2jUVJGMA22iXAqDJBWp/G/mLkuU+mMrVe6fFycmGl6cWCfLB08U4DtiTCG9/1hRnWeV15CoZZcX/aIWRVOrj1+lbD4qk0SkyZkn3NN1doLbHJPfR71eYxmQjZGoi9AUaQRJpUYEMDn/jduDFFpaSiXFM1Wny3oR0+2rbtiFCAmqolicXqkQVHer+df+vRd2u3e5/BZVVeed7l4y3bVX1dHvypFI3Rh1noVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gWmFLxTMltGLVKHd4RKrtWnUMAby6kobE0Dl2ztm5M=;
 b=lWjpMvH0OFkA98vUgbujSzg3zf7TuoE2Z9Thpk2KjkdeKyyG+//qpbS6LJIrZzThWcWDes17lEpQZl0SNvvfAkgMbAGIKu0qFDswPi58PTKGKn11cI2Lle1g8eHdd/t8Faw0K9fvQT/Hh9jyZov/LH/k2ioKXIRjqSJg0Bm599/A8dtGqskl2ctybfIztBRy8TbVHrCsD/vENklnRvD0dPZEoWn4ELCIy9Qkpo9GFXTMCPCE6okmqCyLh4ygCAXnX3TwhJmCAaccWMUSPBgIIMoEKzFtwo2n3+cdy2FcTw1ueRMAKG+dU3wMvrtviHdBmq+VABkhTTg0uUXRmRwKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gWmFLxTMltGLVKHd4RKrtWnUMAby6kobE0Dl2ztm5M=;
 b=f4TPGuEx2vaMYF4B3MvGSd+E0EirZ+K4HR1dhSyCcUoFlCSY4CvLwr2hi2K5h9HpnfWCZQhUlZpC/QYkjdFB5uuvoEyprzbau8Kj6iJh29txWnOfPEkUfH9kv/kUvhBguP73WSfuVxQ8iUsAoEW9ubL3PRs12JGYLFZh+jJCyh8=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Thu, 13 Nov 2025 08:42:54 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::64) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 08:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 08:42:54 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 00:42:51 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add lock to serialize sriov command execution
Date: Thu, 13 Nov 2025 16:41:53 +0800
Message-ID: <20251113084154.115932-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113084154.115932-1-YiPeng.Chai@amd.com>
References: <20251113084154.115932-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: a19642f3-d3de-44ca-1eb9-08de2290a333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hNwhRDEVrzdGyp+PO6zkDrYDzE3gaOlE6QvScuQ4unzwGbm+dNEqDvxirIvK?=
 =?us-ascii?Q?425S+Ype9nKhw+4P26OyySZXLLJ5OmjD8l8AucOYNcnX3EXLCCYvqzGHCYG3?=
 =?us-ascii?Q?QICz1q7g0iRELEt/ueBuKlufcIIiw7KDEfA0nOLTIPTa3ogGw4hoeO1UyQMg?=
 =?us-ascii?Q?CzS4q4nYlGKuToqTnCqjk8TcDD+k5rIjwMTQ2Bj7QKHdBRTr5WCykUG9Vwp6?=
 =?us-ascii?Q?3Bnwmo+qGxg7VGZL8s+REllNny/fwtvGelEpGd67sv7ZIT6y2mBBMtWSwzA4?=
 =?us-ascii?Q?NgCl19tWE2roq0zu6QmPWzWVcdEx82d97ORnTiDHyh2NVzHgUbOC3xZNMynI?=
 =?us-ascii?Q?lHnsCFR8lRcm8Egf/8A8gY0L8ogZYYBiMgyA0HadV/gcmupCo6YSkj7sMVGv?=
 =?us-ascii?Q?DEOHAhWZ535zCJyHongvOPRl2RGsn4Dr2iiPkfh9o0WXfMt48kmaIU7nOx9I?=
 =?us-ascii?Q?JMQjcFm5W2kHzZUKwfgTlBr+SbtGdXoF+uy7pzQHtPb1PUshpsTT+R+wdhmu?=
 =?us-ascii?Q?KuB4SHzL1XZOFs2fU9N709Gjf5cvh8HspH4C/IjmwNRqzkmBhAkt7ljmOIOC?=
 =?us-ascii?Q?VNOYfk81HY/U2+5RrDoATrM5iTqfCarmMttYrgaMHwVvHgj0z+u2uAUzP85f?=
 =?us-ascii?Q?/UeNynIjVOLb5Yl+pFuoB5QUYytikAreoI3nUv2CxhVpvk6UQ2ahx/udN49g?=
 =?us-ascii?Q?li9cw6My1v/y8xKq3wbcrRcAmULn/N5c39DY2c0OS/1b6kuJ03W0S6hO1RPN?=
 =?us-ascii?Q?ZmwUsyzewT9LPDPWh95x3nl2OIVt/E7GIgTzP2K7jdO2beeXHL/r5pgYEduk?=
 =?us-ascii?Q?jhVzAlP68TXjBrRkrR6OXlMDqL7G8em8Xf4wKQN5nXKL+Nq70ayqUmEsVR1n?=
 =?us-ascii?Q?Ql4rIGYjxRExo3jbMsOXuMcAAXlpaTnXxVsVzheGp4lRvwOquuRuIF2DNWtg?=
 =?us-ascii?Q?a02l2XKy+FYbJNt9ABeLNEx5D6B7ycidTPfo3hLL4nsOTxyrq4E2P57wEG3f?=
 =?us-ascii?Q?x9v5g0sJyAT9aIbvDzkEH/O9yyL+8YnExWRE9RO+BAtLzLt4eXEuiNCl5ew6?=
 =?us-ascii?Q?BE1l/iuBe0HJU5e4nkQExNq7WvrrdVpXHzA/6EVJR2/RfUUmYi80J/dI8X3a?=
 =?us-ascii?Q?8QyvgSKDXtcdn2gMH8kzMwcvpMDdTgE0A+C4CP4IalMQNVI2oHhoYrHiu3mc?=
 =?us-ascii?Q?r7alz2iVOiK7RpwYfi+Y+jSy9DwZ5oRp3IY3Fku2bk/gink9Z3U2R0cu83Pb?=
 =?us-ascii?Q?3LX4mqvqfwmTjKakvduHt2dFAS3YuHgPJ8wJOSkUp8FyU78MvEwP/lZ6r2vX?=
 =?us-ascii?Q?1ZStyuhTK/geDqmNLPDtxteDS0Il4CSsvU0mdtmA1UhtXKlakq2phNKAGvfu?=
 =?us-ascii?Q?wHYks12mjBGKsyi0CBWPCifafo4ogB+t6dh9VNaMHB+fjEMM0YQvkKfCu2nh?=
 =?us-ascii?Q?bdOFVs+lNthBTF6GYl9la+Upgwl5AYQQo2HTdm9TTKBZKxp4OPIcdutn37wJ?=
 =?us-ascii?Q?iqbSPEfEH4RNctTRVA2j9KxgYctCZw3Mxi5aQEwxp0sYBEIHcQKQ85Dni2aC?=
 =?us-ascii?Q?RBugLGrf52EFLahR+Ds=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:42:54.0526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19642f3-d3de-44ca-1eb9-08de2290a333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
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

Add lock to serialize sriov command execution.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 17 ++++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f2ce8f506aa8..47a6ce4fdc74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -917,6 +917,7 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
 			    RATELIMIT_MSG_ON_RELEASE);
 
 	mutex_init(&adev->virt.ras.ras_telemetry_mutex);
+	mutex_init(&adev->virt.access_req_mutex);
 
 	adev->virt.ras.cper_rptr = 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 14d864be5800..8e61cf52c946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -324,6 +324,8 @@ struct amdgpu_virt {
 	/* Spinlock to protect access to the RLCG register interface */
 	spinlock_t rlcg_reg_lock;
 
+	struct mutex access_req_mutex;
+
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
 	struct amdgpu_virt_ras ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index cd5b2f07edb8..e7cd07383d56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -173,13 +173,17 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 			enum idh_request req, u32 data1, u32 data2, u32 data3)
 {
-	int r, retry = 1;
+	struct amdgpu_virt *virt = &adev->virt;
+	int r = 0, retry = 1;
 	enum idh_event event = -1;
 
+	mutex_lock(&virt->access_req_mutex);
 send_request:
 
-	if (amdgpu_ras_is_rma(adev))
-		return -ENODEV;
+	if (amdgpu_ras_is_rma(adev)) {
+		r = -ENODEV;
+		goto out;
+	}
 
 	xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
 
@@ -217,7 +221,7 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 
 			if (req != IDH_REQ_GPU_INIT_DATA) {
 				dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
-				return r;
+				goto out;
 			} else /* host doesn't support REQ_GPU_INIT_DATA handshake */
 				adev->virt.req_init_data_ver = 0;
 		} else {
@@ -246,7 +250,10 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 		}
 	}
 
-	return 0;
+out:
+	mutex_unlock(&virt->access_req_mutex);
+
+	return r;
 }
 
 static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
-- 
2.34.1

