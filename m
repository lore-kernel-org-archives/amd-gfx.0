Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FF9C28B24
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612A810E335;
	Wed,  5 Mar 2025 20:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xtF8b9ul";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC10810E002
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGbB4+IUvOu2tlsdb9uzXoSK43//U/+zDWw6sTCQ6gVmgUgKoTsLrcbZyAp5igP75es2pqU1mlAy1VnCqI0eTYyqD/0vvrmEgcjhg9i4GnvFjjvMAqBbT1csfZvXyWmGj8xClt7prhIptkhFpy8z1D0cosRqCInS/4W/lDy0ezoGhmmY+BuHeB864H5LgGS4koZgpD2cyJcNCvXjsJ3cxyqTud+YqYXs1m3Fd0PfJU9Z/eXjXEou//596hbcRXqnMJxm69qLhJwsX2PxBBKP95ysOANhHpk7RPNVwxxG+ufscNy0AFyk6MfPK4tr+FsGB6UE34BtvIPh2k40+gcrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pizwKA2r4Le11ChRIRPDV6ssuQv3PG95yVu1Ak7L5s=;
 b=oQCV4SGA+iCnPYNSh3o80Nix5s3zdc/7GT24g5FW9rSM9ekzfr5KcM20sF7RQ0LXJv+UuzsLUxObngfT7NfgghiGPYKt7cMdjKrL2uGmgdQZFf2qw/h0f/lKBxuUmtV7IVjyuushcKRPAkvw68W33SBYTq8jiHwIdnEWk0v0srPs5GrRrep6tDP3kiYiW+JJVn3t7NEu/SKoazi7fIRbniZtO1ZOVZ0IOVp+mEglYXa4Bk0iahjE/LPgjRIMu3mSSjrwsc647lDgCmkpS0hIZw5BuJ62SL+c0ikbieJP1uPqng9yV0BYLapfY62e8mb7EilDIJkfCdEcElSNkO0dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pizwKA2r4Le11ChRIRPDV6ssuQv3PG95yVu1Ak7L5s=;
 b=xtF8b9ulvPhXyduo4ltFyNRPoLaRp17oUO9WA0bcBXvWRoEdGsnXrSFQnt5sqH8dvFdCv4cx1BOIdZb57NtpiZP8VwX420lQTXm87EsrYqI0C9YoLKXH/U5I/jfHwl1tSCxnoaokGC4ju44i1RlPyQrTaBSBRjTjDe8+Y4U+hPk=
Received: from BY3PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:217::35)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Wed, 5 Mar 2025 20:47:40 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::b5) by BY3PR04CA0030.outlook.office365.com
 (2603:10b6:a03:217::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Wed,
 5 Mar 2025 20:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is set
Date: Wed, 5 Mar 2025 15:47:15 -0500
Message-ID: <20250305204721.1213836-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a579fd-79b1-41d5-bcab-08dd5c26f89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqQTNU2Tazu3oQXJC/RTZLM/QcH9CXKRKlDP4plmmJ8vc9u/UAsHuBLu5rGm?=
 =?us-ascii?Q?okDggA1Phwnmz1tQnrPeIOYIOA7ObSH5CMYltnQeYqbzBujDo8TLkIRz1Hy6?=
 =?us-ascii?Q?e/Ao9y+kMievZ20jPkPbTX48cTOn5jAk9Q/DZxhfGAJL3D+LKzQC/tkkuEJc?=
 =?us-ascii?Q?rsqabSbtZhUcSfAQHA7KRO0r/QtqTUTn7Yki1sxoLXszrWc71gHTFQaKQ17O?=
 =?us-ascii?Q?i36iFZRDwBjRtnsymbNAthMTfH0pARW/i2/KdjWIgt5Ui8x0boa3tQdJEgXQ?=
 =?us-ascii?Q?hvox3Wsth9Cs0YV3qsj+fyTrD4c5wseUIfFdwZp+FbsRuVBJeRJ3gKECQMUz?=
 =?us-ascii?Q?YtGC8UAqwRnXlk34sL9paS03ODs981jXc6w54R38C4QFIHxLynVSBsk57y+R?=
 =?us-ascii?Q?1UNj8PAEUysxfMxvVLyEJCbCokzTyRigeRPyzNF22PpfFcQVj2cIFImRLWVM?=
 =?us-ascii?Q?GgHmo79pQcoYj8AzYyFOknUG0cxOCPsuahY5WjEQFX4B1t6a7HNU5FE5l/8Q?=
 =?us-ascii?Q?rbTljHcrBWAa5AT2JggjOJdvmJXRr4CsxZ414u2nK+snhxorpN7xSJOlPO77?=
 =?us-ascii?Q?HGHCsMBSIhZT3iQ8gofw6GwmJPjkDiqZZusO1eb2Bk6tI7DjpDKW4ya8S/S7?=
 =?us-ascii?Q?uRJVMHpRQ2XrCgb1Ve6dh3mubl5JhqV47BUmZ7kN1jlurAlYAJ8pKrM/9B9P?=
 =?us-ascii?Q?znsZ7qsMIJojOYD04raEXqL0ibczmUlDCbUYsQgLCuR9sgf72Js7BissDnXB?=
 =?us-ascii?Q?cdkYCgDQc7WM1IiQzeNxsfJ8ViqVQH9zf8LOVNKMlYWKgc7AsQdDikADFoWX?=
 =?us-ascii?Q?OMwItiokMwev0N7EXVdWFYp/s5C28T6F2L7jibDpyImpiC+CyNm+EhfMgOVr?=
 =?us-ascii?Q?lOzeyTAHXT2kN/GXZ1LHbEbcNn5i2fi1lCxCa03v+5zhZ1RuOVW460xA3aCM?=
 =?us-ascii?Q?Pn7WU9ScicRjYdRqXgAcFyVFMyZF2JRQPzeuZpg9UxvXv3muNw2qSRipcx1q?=
 =?us-ascii?Q?cj5FQ0U3iabrMTnOc0dnVa45cFGI/jUgxqZX33UM98Xurvh8XtM0LT9lcp/x?=
 =?us-ascii?Q?HtNB2z9D7ue60xSyasPC5SYiv3ONRL5jCsIG9GpmdPFBYxVy9fx+Yhq10KJU?=
 =?us-ascii?Q?JXTpeaR53gngwsrlN2nWs4feFc2/5xaKIbd/E0guoz0ebXbCaY8o/sfRO6Sv?=
 =?us-ascii?Q?Ea+CH30sVjJqoICnCZROjLvyoJ4UUfAvJb79H3C9qJqa7goTwxnjyS/k9RD2?=
 =?us-ascii?Q?joRjPdlve08tlUwBkVaHE0T6bZ7v7uV1+nS/bN5QEpr/VbWlorZelm9UX8oi?=
 =?us-ascii?Q?hkN8y4zFlqdOxt0jQm3UM08FtM4lDxbyk46MqQr8MKI0WzC+QvQOMCHdIovd?=
 =?us-ascii?Q?BLElAAcbOcWoi5KTZzd9LcuL9z+pgvUd3ABrJnwL1H5vK7ZV/Zu4n2SXX6ye?=
 =?us-ascii?Q?WsMF2oOU2vz7DYp56w6tsGs4zGXuI1asf9dmxPlQMlOtMJs8JYfAdBLI9Zk3?=
 =?us-ascii?Q?eg4gqHzaui6htdQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:40.4072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a579fd-79b1-41d5-bcab-08dd5c26f89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
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

Make all resources available to user queues.

Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index afc2ce344df52..71dce64a0ea32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -157,14 +157,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 				 * Set GFX pipe 0 queue 1-7 for MES scheduling
 				 * mask = 1111 1110b
 				 */
-				adev->mes.gfx_hqd_mask[i] = 0xFE;
+				adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
 			else
 				/*
 				 * GFX pipe 0 queue 0 is being used by Kernel queue.
 				 * Set GFX pipe 0 queue 1 for MES scheduling
 				 * mask = 10b
 				 */
-				adev->mes.gfx_hqd_mask[i] = 0x2;
+				adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
 		}
 	}
 
@@ -172,7 +172,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			continue;
-		adev->mes.compute_hqd_mask[i] = 0xc;
+		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-- 
2.48.1

