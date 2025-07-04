Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E05CC83F05
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC4010E9F0;
	Fri,  4 Jul 2025 10:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zr3eZhJJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A187F10E9F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Foe7saHwq8kYP2S7PrVotwM4tYLstScfCjrU3cnLr+RCcyrMtrjrefk4+UERwTcotAuAp3gnp6cS/bnX8NG1lr4hPVT5hh+1d1umpQrPTBVA5Z3XMMGqR1hDIqTNhB4MeYQm1AClQdTMO9kM1vbgC48ssXYVTGXPi17MriimCOZmt2wUrODnY4+qZO1AUfhaqFSmVK4OV9QsGRwZAbqS05venYeacXWC9wwtBWvsvTrXld65Mu6aha8HWlRL/SjPifudrJ2zUJsuvH1cJpoYUArboRC+lttP0P5m16h3XbLa3rUZ6CGYFn91vfeAuaASZoADyajK5kvVz8PcRrWGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUCt7QcBjmT/N11DAOFwq1SDv9FAC2MCJSw5ZGhxDcw=;
 b=diSmkZdu6W8LE57jhTmAaGiGTO5Uzdb82nOnhiQlc+pXz9Hhf/tKwGK9IKYHum1zzhpIGv6DuPSv3Es1jiTcgkXECY3mRlUaTk/GVRSJOMPF6CLnBwQqh+6qD7ISh7v9/HR7etz7YsbaaFquSIlks7Mtm0ag6dvHkI/LYgCygRJQRUtMZSnsr6bb5RgJtKDdbYVXHidAeEFijw8L/yx69TcHNAE0rsoDig699AHiqoTzgvkWggk/tiaCTmZ4145Fa+8jOaPDnYxiUZd01lzJC23b/oSbnkAkDMc3GySdBaRKQcyOkxB2AQOgr71HjDBJJugVRK1sBugNCdBX7y5vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUCt7QcBjmT/N11DAOFwq1SDv9FAC2MCJSw5ZGhxDcw=;
 b=zr3eZhJJ1hGAo4FUC0MgkCD8pM8DTIbPNEkMccjoyH2zJ4KD09G8mDKGeFHeUpUZDjRq3q5k49tmD3/bHL5wXQ3+WD3W8a1XV1rE0bVOggUzmLbbW6Sg/1NYC2XdBEXAGKxGmAUMVaAqLBxdINERbCxw4Kp4nSxSdL1cOtWMJMY=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 10:33:22 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::c6) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Fri,
 4 Jul 2025 10:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:21 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:19 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 2/9] drm/amdgpu: validate userq hw unmap status for
 destroying userq
Date: Fri, 4 Jul 2025 18:33:01 +0800
Message-ID: <20250704103308.1325059-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bdb6c8-5bbf-48db-36b3-08ddbae63300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IsuD596hr/lBmMwXjN47zt1+TszSiTIiQ0bYZMNEH5tVnW31ORFWupTubpWo?=
 =?us-ascii?Q?En0Ay2yy6ihhgOhMJvFKYeoywe/EzWuN4rEb7Pvd49O2KNX5rtUAs8rhkwt0?=
 =?us-ascii?Q?e5fT/NNO88ldxcKCGfmNuo0IoZjnSZ6QCJkOq9xnpYtL08QiwG+w0YBxUbp9?=
 =?us-ascii?Q?GBwjfb7CnZOL+9I9G60JamnhkEQPyX3+VY13OF2NaxHHQePsrB5Q6yUcOg/l?=
 =?us-ascii?Q?Ajt2RQ0vXC9i2RJtjv20gZnRVaubzRUj7U9Qe75g+2HkP4StXH58YgY5s+uh?=
 =?us-ascii?Q?OAKpTdS8pCMnMrRQc0w/9ERIz30vWPiqiV5M4kLT6CbP9ppJX+y1qGym2jDJ?=
 =?us-ascii?Q?4Xlo4myLyxg7wocDjiqu9RRrKwH4LvEzF92re8Qb8Z41Yss4qccgHUePclH5?=
 =?us-ascii?Q?QUG4kaghLr+w4KvhR/isxfyObGNk1gUD9aVOexJbqAnOgQ1bTzR8fujnC+KV?=
 =?us-ascii?Q?t3vroq38/fMfRlFZx0aasT0dMcX0OuVkMQUPJxRno7sU1gFePm/05wC3VKNY?=
 =?us-ascii?Q?iiCxfR+uAnPas1e5pDvo4z30a70cK97Rz+6C6pFrUy/Sjffegaeqt09MFOIP?=
 =?us-ascii?Q?0Anm+BT6+po7ki/lIRJOgK8913kLpSeGlVQvluv0dIEQW9HE2iCa+OY3szml?=
 =?us-ascii?Q?RaktBQdP2RmI9xAYgPXcYFGhwvtBLGhQoNOiiXzosclwj2gmT7kMO8wQywBv?=
 =?us-ascii?Q?Dot06IRMuzpVU+fkrBEB5FvJCZaapS1Obf0jxWourTeL/LYGXbTFVhft+PmG?=
 =?us-ascii?Q?qmtgIhX7Z8x+Ig44XS6SeqGoiiiJYP+PZYTHUi0dawp8Rhv6wAHxIfFVYdos?=
 =?us-ascii?Q?BZXEsiSvegkOFHJKlG8YW+5KtfOo3EplIedIuhBQdGL6a2bQVvA0vodGUNOa?=
 =?us-ascii?Q?oOevQ/B8lNkYG123ICej4KSzOT9mSSPfZevJWq1TXPp3DuO74azAszgJHjTW?=
 =?us-ascii?Q?lI+vRa6+mWhF/BcND/aXPWPKFxHn89BCJ4VxrdignjPYstblIbFzqmxI8KZ9?=
 =?us-ascii?Q?5nprAe7JuQVCAzxDaLmhPPYg80pvfhpYLb0tfCTaAmWMpbQRoZiwGqPslYcq?=
 =?us-ascii?Q?loTjJHDvVBZmWLkOotV/Mi+xLjxzCQBip7vN/u559Tg7pH5lxItf4sZeqG7S?=
 =?us-ascii?Q?rEd3/phAhFhWYjPnjJ70tlXLvzBdpq9yj3SEW8VIbPN/enIQovur7Z4mEDKo?=
 =?us-ascii?Q?0oMKdUDUTS7/kxLQrkvLrA1BKZVTL8ms05EvPOMtiluf8Olrn5ad/6GyqFmU?=
 =?us-ascii?Q?lzRAtgZ46wcUg/GE84KaO7peXWM/gtUDdEQ/hXumKblh89h6x0/2GzVDPXbW?=
 =?us-ascii?Q?aGAXwUytRYARm+ltM0SCSPAgHuXOvF9NC39znaBqh6sQKzLSXrThGu5IyqC9?=
 =?us-ascii?Q?NAB33PZnE95cQ7EUs0GeQRVDEdyjj8q2TJAg3nTYp0V3Nd130bIF/hEpv4Oe?=
 =?us-ascii?Q?wxC2GKtEt+0bF8jm7dEuXst/hFv+gBqHFUHMn+opiRwdjdvsCT3ElfLqgKwa?=
 =?us-ascii?Q?YoQKqPQEYWXVy/stdjv7AeTATDdw0ZQov+4X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:21.6026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bdb6c8-5bbf-48db-36b3-08ddbae63300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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
the userq HW unmap status and ensuring the userq is unmapped from
hardware. If the user HW unmap failed, then it needs to reset the
queue for reusing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..3d2a7f8946cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for userq hw unmap error*/
+	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		r = -ETIMEDOUT;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

