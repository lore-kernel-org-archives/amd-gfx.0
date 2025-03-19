Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3600C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B5310E548;
	Wed, 19 Mar 2025 16:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GdGmfP6k";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9EF10E548
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glE5K+UUK7ad9e8NM8uOZwZRe0gKVlZo1XRK7PN+gVugB2d4SeiMp+e7BppOCkMQNafR0ZYcx+an/TkCppxE0nvISyJ4yMVOuwFUqKugUz9HPVA3j4Ol+UVm9v8GAz3MH/ZRS+vxCfjvWc/vBFO2UFzt52m481WEleTOyszF6vAdtYFUoFP30VEyrkWzFJ1AOEo3QtLKDSIaBpPvCZeb+lCeGEjgn08SB6LUTx1slypDJ2/A+MnjVLTRFDvd6jhj1zPnl4KvhC13vj9uLg3i/33lnQ+e1+FozPXYxWJK7CYy1lWZ5iODb5aH+FOpllbpE90H6qzNopSYmk/SwcOrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzhjsekkhGEiPdlQR8B5+QpoZG81+goA6lB9FLzc+S8=;
 b=AAvXBVmf0699DGrO30BfumVaYF1EGLPiIHw11K5m56d8VpAmDZCeOcjZKPbnOYFaxepoHuIR27zt5sjX4oqPCj5JEA9Lq5CvrY+Dj7Kme0WiRx7rBlaAJYdOGU6TCSTPnZVzBGwqs6eOvb2FqwgLh6Dp0lpY9ZUDRswT445C4tc05ctsItuhCXU2wLKNTKkfOUUL0hLAAjGFBS3rPjpAEVxRVPRMsOauWT8TCaFEKNHD99KUa0pBlm5A9OYwg/AVG6O56aqA6iFl+vh5vFIO7aE5k/8wKF6IsvLls0wSr6chTxNtI3bEul+R7ECCVzLKKJP0nVdNiruMcxkxxq0zJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzhjsekkhGEiPdlQR8B5+QpoZG81+goA6lB9FLzc+S8=;
 b=GdGmfP6k6i3f+DltdliXP4XfoHdek8CNMjKyOktdeoaWUK79zZYm+QiRKk5onQ2sasP32wXk49E1TAzgodbnQGlYbRfuJbUPrqn05WO4FL947dlcjEPfvpzD6BXrV9TooM8FR/kV/e3J8DO5DMjUvn78b/JVh7aprWgzTZrpv8o=
Received: from CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:22:45 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::60) by CH2PR11CA0016.outlook.office365.com
 (2603:10b6:610:54::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:22:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:22:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx11: fix CSIB handling
Date: Wed, 19 Mar 2025 12:22:25 -0400
Message-ID: <20250319162225.3775315-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 525dfd13-1837-4048-9261-08dd6702485a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2j5pi9iw15Rdn1piDJpjJSYsoWyHzKhVB6CWwLelR8G/spkMcD4RNuKUxOHS?=
 =?us-ascii?Q?eWo58VviOXEwaclX7TTFS5MxSW4nY/LDixoMP7N5sFZMPYqPSyQUl8HlWSh2?=
 =?us-ascii?Q?fUjCYg+wTro3T/Ay+UEnQoYm4hXyPuCx6szMhJejDPXt7Z36ETaiigeevncY?=
 =?us-ascii?Q?rTEw+RdTlXcdExWQtVRNklyzwemedg643K0hu2ELzGm2SxxkB9Ehvt3aY0dI?=
 =?us-ascii?Q?Eha8Q2C7O1OADANH1C2f1X2ANN8tClSb1icRf0e6ubUWk/PgZsoaYrvA8oyx?=
 =?us-ascii?Q?OzLn6AmbMrF4SR/ie+/FZzD/df/rAIHSWIFokK0iE9SDg0bQnTq0DAhh1wLc?=
 =?us-ascii?Q?gp44kd3zn9USU07ZcUAT51+xTnhlaQueLxxa4k9624I/1gixZkIoQD8i2ugk?=
 =?us-ascii?Q?qKrXX+Xl654A68pvLE+jv/oxEeuS+leJc+DvGoLgFPunN8CZotiRau3Ha/AK?=
 =?us-ascii?Q?XoRaYKHZViFwCjc5D1FIsaEAAEBYRrBo2ehBrNxRpjaiwZJuU+T1+ntXgxDP?=
 =?us-ascii?Q?A318ejSKqh0YG7mXFYC59FduZzQ191g0LsghK0wpaHRTSBxuuQPvGLhtlM9H?=
 =?us-ascii?Q?y2UV36xvgkDG9F/0j0IcFR6G7MkAZPxRCyyVaEid74bbqwZqkeqXGlqEXtEU?=
 =?us-ascii?Q?LP/rkwe2Tf9MaT8zkfvgGQcn8h3yyXrDSU5gX/pL6K7u8bRElamoQxYVvrWi?=
 =?us-ascii?Q?B8je6cKAUQZhyzEsjpEucSlDcf63yDmaHuY4n7C5fKobNog1W+E/atsUhNeU?=
 =?us-ascii?Q?kgA4MNxDMckt0O8BSBWix7GLSh8oyKLUTXyObDp3xhCkukQI1l3lOXOEyHJD?=
 =?us-ascii?Q?ip/e0iYSLOol5/h1Qz9fX9yt5KlOa43HH+zFd7/2t5D1LSH0zvJBgUm1i8IT?=
 =?us-ascii?Q?9KVqN17ECUiatFvExs5irX0xc7JXvN1tHW5GFZ7jUF6uWKEcJWq/HXixOkU0?=
 =?us-ascii?Q?rZUfxUA4JlnV2j0pHHIsiOhyjTvNI5vsG/6inSKPFQwd8hudwRchXTMl+Cye?=
 =?us-ascii?Q?40SimyWHmN5DmJVo1Iea39fvDZgEHdJSuz2SfqCmxlnDwePxHvpSsn4QT5pi?=
 =?us-ascii?Q?wyTqWXMAAfEsSHYa2kmZQ3my7ctPTErZAOjFTBkDDn7TreOOVPwOPao4hMbL?=
 =?us-ascii?Q?wMKMb5vmkePtBR8uVfUSn/fjt9kkgIaihRnk4WpiepIetUyo5UY1KIvC+Y4O?=
 =?us-ascii?Q?6kJOSGqTUaRMNiD8lAXD1pOaUZoo5GTEitpvVvnHneXGLcbvsLhWLCLA29c4?=
 =?us-ascii?Q?3UfVnA1IH1bQWRZxuMyE5EcyIp46jNny0VMZvg9Ln22D/kkJgYNNZTN0VsES?=
 =?us-ascii?Q?vjUWowkZujim9AB1fjjPVZS+Se3krvyDCZhv1oWu5FDnunTomqR4tnZBTuOv?=
 =?us-ascii?Q?QrFQrJBqeraaIBK5JNVY5DMnKuRA49zyKcRVtW0hrQmkj/S6g4t+AtmwlV1e?=
 =?us-ascii?Q?7SrNl065GhyEX3WWjwE6ltiMTTBZk0jgKErOHa6sTrqwZPxWtHvUAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:22:45.7344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525dfd13-1837-4048-9261-08dd6702485a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5961fe15a3e26..d4646e5a52231 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -861,8 +861,6 @@ static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.48.1

