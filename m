Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290CFCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 03:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5F110E0BE;
	Tue, 12 Aug 2025 03:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1yl4tnA5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7987810E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 03:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozx8jAfIo+5TUJ2GbRkGtj7XWzy2LlSd8qS0fStvBTqsdByIJU8aTjQ0Cm8/y1NWvyZE2gDDhFN/Hid+q6h+ZZlXaX2M7tfI6kMvjmNqfQgWKBlLO9PBbnzwStP0qXGSD5SKk1iBykqNl9OWfS2ffMBgIekCTj9EAnDeHVM6oPLnXoBGUQfnBZdivuBbqeM0muqdfsC5dvkGkAc3avjgOmmv7e/fXFZD8ZP44UKQ9tyHJBLA7v9WwMPlzLyhoPENjZyEGNcNwk0Q+BlgpV6EiFdtyaaDu6SZUTdBr9SGEUpYRhitoTeDfYGZckRVyYKj4WquLX+59D7x3JKVHYlwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYWGXeHLp8l5UGpn9RZiR6ZyzU+RBAqHT27xsO2fVfw=;
 b=PyrjAl6IEXQ7xC+0la7G/DyAUWZcbfUXN6gXpxWI7NQTmaQM/Ux4rQSKZRvDKEyaKsRcEygifSUGj4dHLjVQAqPrYsWIzDwuPhmKx9T9d8BeCj2/MqP/c/K2Rs+8hoe3D7RueSnz2TmfDqp776YYsWl01ST8T6ZoKMFFWyGp0AgPoKhyLAxGtrgZ/1rfVDQTsTEUBwCOHTlfOzuon1ptcxIZ6zGi/tuCVfDuqueaoJgfZRcoPBjgiXeMyvl8Fzkkx5P5Gnd7+1GxjUZ5BK0thI1VlfUSNTJKyjlenCBOlsr/ECdcQY5jl7i8Lx0JXIDF8sRPwjp1idu9W5Zm8we16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYWGXeHLp8l5UGpn9RZiR6ZyzU+RBAqHT27xsO2fVfw=;
 b=1yl4tnA5c3XsEjvxJD+bIc6BXK6G+Px9ppY7HI0fLQ1/VOfk/BsazEuBgjT0lqmzmnUnDAAETfZ4COkvp34QByj8bJ0lj+hOi/kWeese69tAeLLnxLTgwm7w5ODOO8YH0nUAJ69myYAe9QX5P9weWM1GAWMyXAX4uPCuO2PbYJY=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 03:57:39 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:907:1:cafe::3d) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 03:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 03:57:39 +0000
Received: from 179.51.69.10.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Aug 2025 22:57:35 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect vm flags to map bo
Date: Tue, 12 Aug 2025 11:57:20 +0800
Message-ID: <20250812035720.1257216-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc8af91-4939-4d1f-ba28-08ddd954617f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GlV1Ts68xfWz5BoIcUCxViZ12vBzGccZRnpU3iwSPAqjd28t7tkJivYWzRbI?=
 =?us-ascii?Q?oi0DNiVSSbztw1o7kZUWyAlsu4kNdGg+a+sueYsw9qKkygAZwBMY1+09nAmw?=
 =?us-ascii?Q?GEUcaQxGaBIn3lUMqjitFPJ6Dhr+bXzB0hQnC96CqYvUaYnbRhZedO94I7bT?=
 =?us-ascii?Q?kGn97ss6syS8wTfLCNJ9u5hLurdbQfOnJbvO4v/2jqwpRdPUfzQj0H4dUq2i?=
 =?us-ascii?Q?99x4cGch9g3vzOg43HA+4qKiPGQVLz8iynrTz5zJY05CfD4J7IGHQBcK91Ho?=
 =?us-ascii?Q?uzwpRsH05wMk8DDikYR3Sh+jGtCHS0EBo0d9xOpwh5MLENhSYHKTKWOX8cBR?=
 =?us-ascii?Q?Z4jtwTVsMUdKxKXrQJFe05tAkC/Q8am1nZOJ9vZroM+srMZz/aZbSuE1Sd50?=
 =?us-ascii?Q?6tqRJZuRfsvZuCQBsFLWIjPHawNeXvdrcpoEIs6WFgWJbIT3AvZ2dOHU8qpM?=
 =?us-ascii?Q?7wjHtcF+bVEd8MiXFInPOksuNUFu+KV72LSxJdIspbpr9k5fCNmINgjq76NP?=
 =?us-ascii?Q?9LmV23rnfE5vBrsT4ckbrWbHdA607oA3xo0bfZXoalHAmSWpG691e21grx2X?=
 =?us-ascii?Q?yniMdTS81yj+vHhGCOD/1HiN1+zkn8VoNciAD3yernn2Cnpycp5sIq8orMkt?=
 =?us-ascii?Q?Qbp09YMVSCPnSQpwoLKIUuekwtsanTMUfaHHs3NZPhS8tPzfpAC7EncFWMNf?=
 =?us-ascii?Q?RQkk6efYzFsj7ifULaz5beaBMAYUTuteDb8CW+zazmexWXdwHNuSmdGiMQ0p?=
 =?us-ascii?Q?p9NTeqmH3bD4MbqxH8gCyw/FYzSyDEHc8TVbbmOXHoDMA5jfH2glTc4FHG/y?=
 =?us-ascii?Q?zCLGppuoWiAdKUbZJVElOEoMmuLA8L3MIdxKGnxGTaYfC0DSJHF0HGQm+e02?=
 =?us-ascii?Q?oAI+K+BJU99Ydh1GMX6ruBKvPhmbrB9MOEM83segX/wRnW0+7+SKIlLSPWy4?=
 =?us-ascii?Q?RDMP2NaeyHfEv7wDFCEMjPZMTWJed2YuPVlgdMA/CA1uYkYc5AZxbsDgJ3IL?=
 =?us-ascii?Q?XA65fDDueMQGWCr3/I/x32mW09B3sEEp6JwtDqWYTHX455Io/wIjqK1evViZ?=
 =?us-ascii?Q?pAPd/NzohfOqPxFVDPnpYTHPLbu1OEztVHMqGNNjLO3BBkdQYg4Z07QGOm1V?=
 =?us-ascii?Q?vBtog4oJeXcssa7ZZBOZ22g1g066qoZWVTiPkZOlTYpuULRSGwhZwh2IgkUV?=
 =?us-ascii?Q?GhQgiprGhVtZht45q9+YBEqbFV7hFE9aXHe0YUTEY7VXXGhewgtDSOxM2I99?=
 =?us-ascii?Q?1Zf/VhCep0QpZr+pNQ4zPivBvx1cSO4UeJIGm07o3Vp8RH/0ogHacw133xsS?=
 =?us-ascii?Q?9RkYrZOyF7P5aHqLCDo6pvzJrne+VtzdSw4+1Qane+NyYzC2hw8B3MFcwlBp?=
 =?us-ascii?Q?wrEZaHxsyVPqmj5z/Q4WHXisG9bgqnUGt7dpqfkYTy2e35L9Cgi9rrx+N4JT?=
 =?us-ascii?Q?ORhR8wpHMbuVoMQTkhMCtrTnIwa2XYR29M9nkj/s4nbmFVhCzBws58AtXo59?=
 =?us-ascii?Q?OdKLZwjMeg99qvisPoauz5T6vE3f+F5liCea?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:57:39.1328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc8af91-4939-4d1f-ba28-08ddd954617f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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

It should use vm flags instead of pte flags
to specify bo vm attributes.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 02138aa55793..dfb6cfd83760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -88,8 +88,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
+			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			     AMDGPU_VM_PAGE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
-- 
2.41.0

