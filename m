Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74403CA0EC0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C2610E4BE;
	Fri,  8 Aug 2025 06:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YtqFBPod";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0783610E4C2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjlGjVNr9fCNJ5Fm5MDrLNQ+xm+EVIw6vB67Z8s0c7pn7+QW3xlFUgv6jhIrGGqtsP8ctgOIthRMkt42V/AKjNknFB/x1T/8neJTYesBUGvP1ic63FmlGzNiQhF5tO5a3C28BD0YvItW2FMX9mFt5GrNCEKW5IfQZ+h9QGQgeicwA11mrLc5rdPRfeyCE4TCQ09waA0yggZ+9eAD7AKzj33OL3lf9wXPYJHfETazQgxOIGxCHSdC6zYJW3zK3/T3wNlsMM7WgfJlG7u3TWQKSCE3kjP5m8QYB7eKCEzmYJd5LjuJH0zlPVQ40Q+0ZwNNauvCuB3MwQcI9fY8sYmHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpHgvVe78MBTs1ZWTswpQTGHqv463fbJaRTpw2s2IvI=;
 b=AqJiTnIj91crfbK/eLOLIPnoJ666jCdStHxvD3u7BKLJXIUOjLoITVq+lVll0RHIHXGntzq9rpSQ+v5NwPnQqdCQ6MoLj7RdIEwhE430rwdo0QRocRvUQ7+c94jErJjVL+bIaJYRvEfBXgXNgFmQhE02s3Jwmq5mPaEIZTVo3ImPtbTwOjekdScQz+Unt1GDbDikzb8p+LctUBuARwvnqtJ/r+8KEFsi4rrDFmqqqXRCm/S8gfCN59s6OFDc6LChYBFuwD2VxN5BFh3Sy/ae6wNuEc7CEMsxOZvYiDDbtqaoUS2oUrLZ5alMaDPOXg+F2vhRi0x2yTatvzy16KWagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpHgvVe78MBTs1ZWTswpQTGHqv463fbJaRTpw2s2IvI=;
 b=YtqFBPod8rrkB/PuJKZpamwPPADmNOqGVonKyH1OzRZ9Qh8J6tcUKrWRnga3gMn5EMuxSGfenhVO78+1i7iNc5aXFwXTYX6CWcRD39VwoAzvuslUceKgW/0l+QOzpJoNKRcH64fMzY5Gl+ubBA+8c1N0Gxo/XOSA88mNsnrgqJM=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 06:29:45 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4d) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 06:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v8 10/14] drm/amdgpu: validate the userq va before destroying
Date: Fri, 8 Aug 2025 14:29:06 +0800
Message-ID: <20250808062910.1613453-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d54c61f-de99-40d9-20ae-08ddd644f74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i5JHZdjO3fwLdQC7Lv6cYjadDX7F5oWIAvIajSb4IQ4fs12nLlkZistn+nrc?=
 =?us-ascii?Q?kAQgFWvTyz/ZhXPen5Na2rDr6wuHmlSrtsKHEdYuI9kx23jq+nau68Z60Y2v?=
 =?us-ascii?Q?Xz30Cphn2z2Bg6z6sraK6AdBVxWBMvJbCVnGwwCgyHjV2yjOy4pUfyJjws6u?=
 =?us-ascii?Q?arh6i9VgYSdo0CSlRoD/LidRDUrgfNmit+C1LKHYtGVO6nEGf0v1olW4BbhD?=
 =?us-ascii?Q?wnEXjAoTwMmKLBgVFDTycfSIySvI45ndIiYkzUjB4tiIjpemvF3YCkJNPHxn?=
 =?us-ascii?Q?UuKlt/8vi9qeqfVxg2yFXG4XO/BL8t0PkdYHgR47UC3Bzn1EPibnRAJEnYpf?=
 =?us-ascii?Q?On+i6+Vs3zbuBO+i1PjjIHiH9pxtxKNID6yujUkssMrOpl4LrjF3XAsUvkDN?=
 =?us-ascii?Q?BcCcPybx1Z9O3qhWL68bmIPbafVNlm7m7qBbHXH9UwYyESdffhsx0XN1kPVA?=
 =?us-ascii?Q?WCS/Kb40tsWSk0BTpiD29jyySPQzJ8O/awN9l52wvFkqgb77vb6Kl0x+gU8D?=
 =?us-ascii?Q?yX5FuD7JgS0dSzyToDj3zeBR/wc7dnf6Do4vU31f/cfbgZULCfbUJoNTAdi6?=
 =?us-ascii?Q?qbjIyfE+LJQpPA0h5faKqKhSiW1k3kxoLKDT+kO/zHGUXPCPR9ahuNtDiMGn?=
 =?us-ascii?Q?FohyGfdB2I6uHd8Wp1Cl2NnruHMc6jvfbGXXJBlx1ksY/HZFlVKo5tybHNEr?=
 =?us-ascii?Q?YKv1yMFlOnEbOUYXyiB/HD6O3OQ2H0dG0uO93zlhx+ejshpzdLOKK0aFtLE2?=
 =?us-ascii?Q?A+4W6uBs898/XWwE5tpotO6QRrL2Dy7JZhuGFpgWmk5l3OKquyzLsvk7eYjV?=
 =?us-ascii?Q?JJX1rWqFdBWnAW2Ielg3HRdmaLuULEItKyzPi2J+07upPhM/IB7+NiwHXfUp?=
 =?us-ascii?Q?y/EIjswqDXRWOvy+rPvP5VIe5SP7H90MpH+bzSQqbvyXyaxUxXzq5rzCSShv?=
 =?us-ascii?Q?lyezecjKW5J/lRj6MOwnOSZgU1Zjy/RlYogL2UyK+YHNIivGwFMXLcT/zJVo?=
 =?us-ascii?Q?N5oRj6cxkBp7K9ZkM49PsoWYKL4NBjWlciNKuKdYGHxG3hfiK8Y0TV8qaxLa?=
 =?us-ascii?Q?hG34vEfJaZHr9sifxomxXjrMGpxV5HI8OguWC3SlwFrc3lUfXqn87+2WXukq?=
 =?us-ascii?Q?bVMUzH6DQGcOzDERAQ/4KPFsv7kuuSJwb2yCu9WdlT9ouXPrP2DF1LwvFyvp?=
 =?us-ascii?Q?OGtFCevsKGltA4AEnu+EK2iGLD3oTnGm6k8hJ3Px3naiPGTyoOLgxAj6r2hN?=
 =?us-ascii?Q?veABRZRWD38MsM0cxtCEh364nI7NpmYYpYNh25It+XirKhzRdEBa/DXvGbpe?=
 =?us-ascii?Q?67FLeK7utOoseMchtWg5r+FpewEFsVffXS0LrBWDqqK9JIVgemAd2d5y3OYc?=
 =?us-ascii?Q?NEagoSUUvLTzn1kJ7VuczGavnfbS/GDzf5RcVklPG9+W4HfEIJFf+NlmlpRi?=
 =?us-ascii?Q?7LnJOzRt/uG1SzP1ocF067/EXF9DXxhIaKMt4Ty+QSYwh5h1+edlWLPimUWD?=
 =?us-ascii?Q?H+xYjUg4RPbX2Ls3FvjjxVcXZIJUf2CeE7gY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:45.0270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d54c61f-de99-40d9-20ae-08ddd644f74d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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

The user queue object destroy requires ensuring its
VA keeps mapping prior to the queue being destroyed.
Otherwise, it seems a bug in the user space or VA
freed wrongly, and the kernel driver should report an
invalidated state to the user IOCTL request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6cdfeb224f6c..e5891674b4d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -520,6 +520,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	/*
+	 * At this point the userq obj va should be mapped,
+	 * otherwise will return error to user.
+	 */
+	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue))
+		queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
-- 
2.34.1

