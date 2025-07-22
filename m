Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6770CC83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1144010E613;
	Tue, 22 Jul 2025 07:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rqZvKN4V";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6824C10E611
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA6sQheC/p6F8kS6zz4/gIEGF6mXShOt2fjHAZbNI3KYcVprZ8QLEA6h3pVsN9R3R+KfmxeFWys8hn4FAHzZpH4OaQJKrVy5VeIOhUxlgqsQWP7fbaFprTMz4PUdrfJRT+4MS/zmE8iM/Usnp4WHD5XnGEuoB1oTy+PHPt7YDuWm1o8huOo2byfMguQRpu8tA0EB9+qIXeTfloUMAfbhRUKu4J9K836Sn3ofC92LGIqSaIGlI+EkF7gp3RWLd+qAmEsRizfo7/x4D/+5O/2Bsjf1jJ+uPkLeJy/+dEDa5rIOeGvOcy37En4Oez6sIYesafL15dTj81XVoceO9h69eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBFbz4sQIUWB97/EJ2DAWctQ9sWEW5uQWYr81R4BbGY=;
 b=pin63kPsHGcNph+8QjrDMtvXP5L0kZ44ZREljXI/4GGHA2BSH11CGXkzyG46A3QTPOPT1GFsSnbltBLtoaKc0eFgZh0NPvLNOP/duASI3cMlrwnzSsrVifOatWdyQnBORkJ+aXszi4+qhgdJ1Y6843fR8qRYXyCS7X4EYURatwKaNh6TPX5gxkvDbxY+uwQ+yPA0nVBIRDXkJJwOXyAv9WICZ1TC00eItk4Chq24Y4FMQUNt8mgdwrnHVbcJZjCe4ilAxkJQ/49DBHwxPA6Z+BR5/uALEkeIcEjcRK5xmHP8i77Ugr1hUI4MlejVcOpmiAHQwOBwjhOfRFDz4B8x7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBFbz4sQIUWB97/EJ2DAWctQ9sWEW5uQWYr81R4BbGY=;
 b=rqZvKN4V8n6w/z5xG6mH66hKBLBJxl2Upu2QsSgRWUu38MdiP64+x+kXOojPoe6bxkEsPHHMqiRXGlOx/+ougOgZB5esmj7qx82fywCUNIEAF7PXyFWlAq4RWfEVYMsA4mW/7ZEKyZcbZQdsvI0t4uMTXl4agcgxlDVDNawSh6g=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:54 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::9b) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 07:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:51 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v7 10/14] drm/amdgpu: validate the userq va before destroying
Date: Tue, 22 Jul 2025 15:46:19 +0800
Message-ID: <20250722074623.1464666-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 81085eb1-9b50-48b7-616f-08ddc8f3eda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pnz00hSkSiSdKXbWTnP90bgsmTTnh46lHbjWK0tcq03TiS1BSQ4e5RTGivbL?=
 =?us-ascii?Q?yHBTJk/+L5aTvYcR3CYF0qKLPwriFxDW+MGiDk+rXFcBjCAGqdUm1tx8GCWV?=
 =?us-ascii?Q?m8Q9DoD25UYhxOFiErlYNqOuXJvkS7VCV2zyaY6lqoJ3u2xx9jB5KsKiz7Yv?=
 =?us-ascii?Q?lmsK0Y4attF9ZilfYhoD7jSZKlUOjvLxo9SrzyVBLC+DxPmMmWeBQZW6QjIy?=
 =?us-ascii?Q?8YDGoRwWW7Uwd7gkpk/eNqCw0ENib0mcn0+Ia+vDidVpZ9ArpUFg36Y5SuQD?=
 =?us-ascii?Q?7B4MJx+6Arlq0moKquCS17wjMg/7+6BWb0oegYMyXoZg79sQwsM7ntbcVfx4?=
 =?us-ascii?Q?oYawyT3y+cLHPmcaxzPolJtaa86XU/nwF813l6YUX7rXWOuAtoJeI1AHXZ9A?=
 =?us-ascii?Q?+owu1lAoUrtBf4zv77nB5q3F8p5aTYTYk2VnDCzi2Y4POEmEHkbScK6HIPtN?=
 =?us-ascii?Q?NvGMYlXuwRPxjnIgCaP1Bxk8RpKCLDEcwUhE1XBjS1CxNLwGHcBVUYTXGafr?=
 =?us-ascii?Q?07gKTsaqOH/29MdcuFGITyNlCiKuc5MwCKqzrOimdFC8uCU8ml/zEMo0FM7q?=
 =?us-ascii?Q?bk909CBpVZvKu1BBePooDCl4VOo3F6ll9hIpOmGyaJ6JEgu4loiRw5xVLtUw?=
 =?us-ascii?Q?JGN6RHmefr96y00kUFLLmQb9dFCa9NOdKTcOZsF8jEQFWg4fZZ4CEs7laf9V?=
 =?us-ascii?Q?EN1waBv48aBA3K1jwzewfZUU6E3om+MNm9cHaVKpWzzlwWz1DAI+Y3ZKCiS/?=
 =?us-ascii?Q?CO7WUJmvOApY9HuWmSm070AIqfYRBNqNEWyFxPoq3GSE7U4QvIZrz0v0c0wR?=
 =?us-ascii?Q?fQsWJV725y9wl9lWRp0ha+SFxwPBKeKbvx74+diyVzY9fhfUJkybJnlkwRLb?=
 =?us-ascii?Q?0QxLW6wiwTESdxgRy9DQqVN/lzCI9HBWjE4yydLJxi4mBJbaZZDN3doje5nX?=
 =?us-ascii?Q?OWXeAGah5VSh/ZkVXNqLcvxazcetfH3pmHLL6d5oqiOtgTdRi6Bw0uX47Kjm?=
 =?us-ascii?Q?4DInNfRZ8EhaCyGB3mjdgXOgGCOUf8+oPAWRMlWUIvJhyGbamkwnpWmD3H7/?=
 =?us-ascii?Q?/VfkZZuO4+hYzUVVN7lXq4DK2KIkKnspK8hN68YJ1s5DCShT5OIn//4MfZUG?=
 =?us-ascii?Q?E36z9JGtPXrtFGEURK+OBT7vcwNygI+9Oh30/8ffDNENT72ZH5k9mUhgXSAS?=
 =?us-ascii?Q?dVEdwAoZuW2yLQLPKKax9jAhnBgfDP8HrIF5WOKSn8Y65vtD2tyn4sw/lTv6?=
 =?us-ascii?Q?Wr0PI9b52mLk1WiBfM1+s4atg4vz5uOhtD+6zS4ag19N1lnpU+sD1zz54MQZ?=
 =?us-ascii?Q?GWAvruhShd48uJguprvJo2bpB8annLCyRYyuOo3E7w1HsPMpakRQBlP7JE6b?=
 =?us-ascii?Q?UzUnMea6W9iNuqZPuFvFqZ34V8jP5txUtcv6T0W2mzp0/UemUGub7CoA6/UF?=
 =?us-ascii?Q?AGLd73sZhw5PS/DBDZBFvbE+e2Rz+ZaGAHVrMjwUqRui2jnleg2NawzyGfni?=
 =?us-ascii?Q?F4zPhBARjqKOANl+zCleG2V0jawWHTik5J+2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:54.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81085eb1-9b50-48b7-616f-08ddc8f3eda2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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
index b90504b6f6c0..693130bff339 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -516,6 +516,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
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

