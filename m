Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45519C25B75
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 14:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE0410E1F4;
	Sun, 19 May 2024 14:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vD+gemLx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B438C10E1F4
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 May 2024 14:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udtlq0X98JLuzGzBOXLnZP7TT7lCJegu16Z972EyOA0pLelQEMILp1B28HRs9VIctR+prS5A3ZC2Wa2rMiTtoeBMbRhxOpcdt8I1REg6Tozg5CuJwEbCaBFxXOaryHSmMBXuOIqXtI+HW6LjalRfw/xGH+891Up50okJKrkVFpxXuWIdYbrUL50IhXhfUNMCi6g9CiI+YQYxGUEatwkVoScHu5JPi8+adssuA/DVjq9Ri0hi7BtCSKZUg39+TToEGw3J5xaC8/20LoVVHbpuLsPLvVRo8P8T/ibyD63BI0jGWZpvjAhoggZHBTXWlgvoBjzUu9kMz1yBO77B3TgoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA/oAz8Q7BDoNhWl8SR7NnHW5DAfvJMJ7wjgcikL96g=;
 b=FkbncdQPhQwt6K3Rm7TUqyc7O3iRcLtN+TK1eyRxpqLYE7h9+ofRxEMcKsQ2k1Iy98SlzA8LafSEw7VTXrkgfuPceUucGa4WFB9eG6Ht+ydWcan+rJKz6k5IDUSvpe+XM4MXxxrOhjq404b6xME/pvxDsz/9R+fdOmyA9yskjDZLyrf0wjFerY5sT1swcP4P8WOx3UszYp0lNspk6gqjPPueldWBRZUiS6Ceu2I2Eye0QqcBbF5y3RL6t/HRFoYJk2h68zyvnrFyj3QCD61ADM4W6W3dSPMb5rlsHr8eoG/eLpsW4hw1vzUchJAXv8TWR+3JWZLhFHnB/ifGDwO7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA/oAz8Q7BDoNhWl8SR7NnHW5DAfvJMJ7wjgcikL96g=;
 b=vD+gemLxynQcp3Q6Esqch2LDF1hRfbNYDLErLIxQ47d2UVI5oMXzDJ2ShjIbzVGgecAszAimO+nj8Kaopd4UFqJZ7fEg9JtoROHCxFyrLGh4L5e7qjrJa6w8yBZwukN2wqCmERmcbTJSGQDA9STCPTedB2i+yfPlrDPNUzlPScs=
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 14:52:39 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::cc) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Sun, 19 May 2024 14:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Sun, 19 May 2024 14:52:38 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 19 May
 2024 09:52:38 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Extend KIQ reg polling wait for VF
Date: Sun, 19 May 2024 10:52:20 -0400
Message-ID: <20240519145221.623701-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0b5702-b154-4b81-88db-08dc781353f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i1fBsl5GtT4O1dXGsTjAu7OwPrf3WPtrRl0CIw27f2POhaovhGYBfc7RKo/M?=
 =?us-ascii?Q?Ns0LdRCYoXUSmGpUFD64I+qfwnqQN08I8bnzu+7GHtsbmlMSsfaLC7kdZrbD?=
 =?us-ascii?Q?N2Q/kxZ/9WoxRlnXXFyErKeSU+YiZxVoIeIrku9VMgdlLViIYtoAOERz1qfM?=
 =?us-ascii?Q?1OcLCVNnbRoDaenLdWHVbaaQ+GhQnFrHNhaJImBEZiJf2I+5dzSjtd1w1wGo?=
 =?us-ascii?Q?fmWd3GsSBtw8LcRmGlsdpbyuASrxxUJEh8qcqTLDcX5p6xxO0fkIXJqXK7dE?=
 =?us-ascii?Q?fGWiNPfV34CMl+5fVtzDPDHJvFdYObzsrnHtIpMKc+G55T8yOSutbXLmm2kU?=
 =?us-ascii?Q?0i2oENtt93KJh3JWJKHF+GTSub706a3opgGI0XiCTy1lReALnhSjHeUr3APk?=
 =?us-ascii?Q?kUweuLSDpdn5vYgP0hCuN0Ayw0VvQdi2NiUuqItYnCj5E6LxQIJgI9kOM/KG?=
 =?us-ascii?Q?ZPjYqccZkUqDCfu2H+B6MMdUXcPkk7U1z6l1PwqfqlJ4VIFS9MUUZLWEX2jZ?=
 =?us-ascii?Q?PzOP/kL3uxxywhdqnkTWBlblpjgoAximMclJWd4rIdiPsN7d0ezvaSIhUsOy?=
 =?us-ascii?Q?YYrAxGoJ2jtzoPDawjVCJYD9NhF17cI+w+JeF2CxRX6RHvaeT5UQmgeDjph3?=
 =?us-ascii?Q?YrNKio+l/OLIk3kjPyYlYLCuZhfWuHg7q7GM5qFysJwlZ+mdCz4Voc8Po9F0?=
 =?us-ascii?Q?977LZ7wBZuDqZ5Q8V3jtMbRRrlMEm1s8mEJ17QQVoE6P5efeOcm0Z+LBtQ5S?=
 =?us-ascii?Q?g1+/u7l+gHvquCj1HPPc0vVr49KI3vZvShd6VzeaT3571a1O07P6fSEzCSaD?=
 =?us-ascii?Q?6t5WWMck07VimqBjeYIGsaJI1f8p+5crlDcqag58nMu30Fkuxo79hWXb/0Wo?=
 =?us-ascii?Q?KR1Ezsz7N2l1WaeI5YXm4bldrPRmm/BNYxDgQGAABENjYsOTDXPPTlC7rx2x?=
 =?us-ascii?Q?ikirmCGyHFwm37TrG1SZT+sQHEbAndiiRIJauJm98S13kg/CQ0v1uYzRnvOa?=
 =?us-ascii?Q?8mykZoMq+Iia7tZP9U60NogdxHbCO9inUDdwGDdobju8WsEj4qwCvu5+xNGw?=
 =?us-ascii?Q?ix4tyr2649MoOsag3UXnFwlC5zeR+QFxBDUsCmtXWv2/BNBd2UaFkz3HRUqX?=
 =?us-ascii?Q?8yom5EfHLt5mEUW4K2RZ4JH4ZHq2ufWkTQfa8Ot6fjeOL3NhvX8xKgnI++Pg?=
 =?us-ascii?Q?9y8+7u/h8fn54Vxs77nm2bZu81mR34igtnYSwWcmpY/1/j5419TlpSzVYTP6?=
 =?us-ascii?Q?ZDME4O2iddqj9GehKExUw162Co8dZUssLoHb0snlGK41YKhAUFd58mnYPzvL?=
 =?us-ascii?Q?x9biRuTMbxM28hDoSdhEB9CM1bYTVwaXZsUqijjWhS0PmVJYq/140tgzvBaB?=
 =?us-ascii?Q?LToabs0Hz/mCG0sew5feS5IexZeD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 14:52:38.7348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0b5702-b154-4b81-88db-08dc781353f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

Runtime KIQ interface to read/write registers in VF may take longer
than expected for BM environment. Extend the timeout.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d749c6abdc5e..e8980b6009c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -348,9 +348,9 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
-#define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
-#define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
+#define SRIOV_USEC_TIMEOUT 1200000 /* wait 12 * 100ms for SRIOV */
+#define MAX_KIQ_REG_WAIT amdgpu_sriov_vf(adev) ? 50000 : 5000 /* in usecs, extend for VF */
+#define MAX_KIQ_REG_BAILOUT_INTERVAL 5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
 
 int amdgpu_device_ip_set_clockgating_state(void *dev,
-- 
2.34.1

