Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F40D1951A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873B610E481;
	Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cI/t8WYf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB2B10E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keimKHqrgXjdlp61rSBkd4p87bonNdiDe+M9wnmNCcuF36c1IO+1ekbmGpdiAFl/5q7bW08gUC4EnyFcZ8sbXswYYzlvUMQXKnZ2rOY2WsMjS7NSL+vPxQnsrG7UbFdPSTPyWOoyFmYotxS2GYrIaxNIJnlXrsJZwV+1Dc0TY7C155Y2s11uzXiMw0JbOQdxrtViKjZuNKm+xzdQ2lw9irxkDecWk3nD6QAaJqvoSTui5APkyZhu3MVguGlBodzK5NiRZcguY72Yyz96nOsCTESUffOWE5m8/Sxu1QEQU16xmfo/NecCRZ9w5qeYRibPMzIGcJ5dy1Ulu0XXWVej8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUxXNTBSbok65oLrGii81WuGQiCo0GMjJ1+aCHuTAfI=;
 b=lOk52q5trzPHdk5iIBHrV8aUqMb/E6iDewL82S4bd+ItmowhF+pVjHoxl4IoN2jRO48lPrNOCOWbmfL1rHihJpAvG8FyT8Cq7uo0k5csJ1G0fohiKgRepkZDetQSYFgniGvstik1Gi0B0GPdalr3/IwLqF1IdTogFOyU2Yg9+tdIvg3FRSBziwg2j31RIpM+aMdPzGFtm1rAl6lxphHO+tyhF7n74f+JzpzgqvEVYZeTHGvha7Z8LtYgds03kRUZEG8MpBKvRt4G8mMgOxrCAGtZtOVwG6wBR2NarNpEIoUKz7Q9fAF8G6Ei7L+5b+VRF30eNjl+xXZ8dF5yYGVZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUxXNTBSbok65oLrGii81WuGQiCo0GMjJ1+aCHuTAfI=;
 b=cI/t8WYfO0mve6ckVIoNyhpOMvXQGZM2897gs6Cm9DYaWzzUDNdUA4r1oqainuJL6mY2CEOnu1I5OhkNPYVj9JUbAN/dOFZvSxyK6UwsZHicLEtTJ9q9xq6A3D25hDt9o9Z/utdT+qNRjD+h3sC43lzBfQ1AAtDK4SpNxAo5mbA=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:08:08 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::d3) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:08:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:08:00 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:08:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 09/12] drm/amdgpu/gfx12: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:44 -0500
Message-ID: <20260126200747.13527-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 228608a4-dcc7-4d60-563f-08de5d169fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NWBhxc8VgOxjnxPQXukOSFoAqVsfAmM1i7nrJoSjLrDw9DjDT+DanSHEnPFb?=
 =?us-ascii?Q?zg9H8rn+oOX4JHpMQxVkrW+yCakczUjKWwB9yj3eaK1kC0Mv6YanWvUL1l4s?=
 =?us-ascii?Q?MsrJTM63aVKC+leU5kvK/b5w5YIoBcrtUnKZQ0Oqk3RmGEiS4aDEVNr+YF/N?=
 =?us-ascii?Q?m8xSXxZycVnWf1EVCYPuA3Zccm9Vh1tQ926nL1gNpzsK2SVkbt1V8gPKJZja?=
 =?us-ascii?Q?CAstI4IpC4Riu/q+LQ5+SIsiSZwfpPci5G8WO7eWJG5Ml44o9D111g/YDyWj?=
 =?us-ascii?Q?pN7brxkZmPqPuykuGJkeu4/Vn7DJz6aK7NgF71q3jnFr7yrq+f0E2PNv2p60?=
 =?us-ascii?Q?hrGItMriHMWKyneSwTO+lw+iaC/wCxcIkXY0Mdzy3TfoC3P4+YAtq5i3xsu/?=
 =?us-ascii?Q?wOO/WaO5I0ZZOqgSIPH1n2TC2O+YzuRJfKkTBA/PkQmreHy9YxCecJqCtT4e?=
 =?us-ascii?Q?QqwywTRNY9K4+eRIu2VWydVDs3ORVYesf6LQWpvYC2a+ThTFCa43kGgYCtzV?=
 =?us-ascii?Q?1cgD4zyzJFge/bDls0tRbenxIX0QM/oBk/1EiHTQtlqZsfFolD+5GJ8xO8XH?=
 =?us-ascii?Q?eH+aFHkZ6jlKxLk0E6oDSpHGtgV36jUThSxjM2OQtTVatFd8eOgPAs6taelx?=
 =?us-ascii?Q?IkWOYl3D9kChNXkf9oGGZEoHZweb28/7GengLUtXtu8DTNj5XU7kGkeCCfel?=
 =?us-ascii?Q?od1+hF0cjVtPv2EsZPwiix1yW8C5VeP05wBY0E4vT2XEcRxvzZnT2zs4ivro?=
 =?us-ascii?Q?8cWpJcL9QRuhzSL8uDacjYROqcLzEs4LH0KjVlRaKn7UTbX0Cq7C+RhKai6I?=
 =?us-ascii?Q?17kD5haK5LsK1v6EZbgFJk6PZPRjWK2yRBkeA7GaIpCTWtj3r1H4+6kYvFGC?=
 =?us-ascii?Q?I1hbgbgbtLjNM+cHJtjyhCJVyzHvedPxBR+saUsUME4gxnWvDF65rB1Nxirj?=
 =?us-ascii?Q?cQpH+uSbL1gUnJOO2SGS/cRDFSCHbn4o9wZRCaWw1H1IFf47fAJq8E1luO8E?=
 =?us-ascii?Q?KNhtr0q9epRjYw3b+s/ftX8U7cBvrpxLN3cjW8suD5mDdEhwMf6vQ4jdZKWs?=
 =?us-ascii?Q?UI48hpdZ+11MgrOA6UATy8+oWE9heoj01uJUnbH5AhzbjB8ukCdEkCECslOh?=
 =?us-ascii?Q?qTzFGYldrpC7fNzbQ+NRQvPah8/AYmoxOgYh5feQKeH8vmhL1Mub0SyKJRUG?=
 =?us-ascii?Q?23Rj7GYfd4LzBTBnYgfo5DmE8qGOjcUzK7tD939QLP6qxeFBTViQCbVoUhmt?=
 =?us-ascii?Q?wKilGgfBaC5LTvFxWqiGn/1f9yCtgiwKgU004ASqNM9V5o24Bb4vo+DhL+bE?=
 =?us-ascii?Q?feDz2l8WBHBSd16TiZxMZdwptzlAVZTV0+e7XpJY5x63sqnzJIK0OWdkv81S?=
 =?us-ascii?Q?w1NzovK1lcrHbUPlCtoCklR7lkXp1bZm/Wa1tOXUaQz8GgB1bL77VJLPOb+R?=
 =?us-ascii?Q?Wss8h+1JAMUWZzJ4hynMXtd8i9wOSXUBwxnJ7+r9lLLbxgjKG6z83G11ouOJ?=
 =?us-ascii?Q?bPteWWTJMzumFg5GxPPhSNOOVBC4wip2FTMOjOpqiXHlRxq3RGyD4U5sjVAq?=
 =?us-ascii?Q?WwXKis2Nq51G0rQaQIxBVvwpQu5qv0v/lj4s3iEau4KKMRvNiRrHLRAGSENv?=
 =?us-ascii?Q?4rnSEETfWJ9hebwHOPCfRgznHaq9OPJPcZqmyfCvaY200ljMVh9ZY8komp/v?=
 =?us-ascii?Q?3GaXRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:08:08.3794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228608a4-dcc7-4d60-563f-08de5d169fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 4d5c6bdd8cad7..d5ca57b670cd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4787,6 +4787,7 @@ static int gfx_v12_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    unsigned type,
 					    enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (type) {
 	case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
 		gfx_v12_0_set_gfx_eop_interrupt_state(adev, 0, 0, state);
@@ -4809,6 +4810,8 @@ static int gfx_v12_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -4873,6 +4876,7 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -4907,6 +4911,7 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -4919,6 +4924,7 @@ static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -4953,6 +4959,8 @@ static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -4964,6 +4972,7 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -4984,6 +4993,7 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

