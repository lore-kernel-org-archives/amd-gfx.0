Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288BACFA474
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 21:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBAF010E866;
	Wed, 23 Oct 2024 21:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+tjSDvH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913DA10E865
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 21:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqNwS+WUP0jm98JpRB1VTCnrSrwszy2j37DggEcFnPMNMcynNV8vNBkSgqNgBg1Yw36pY7yuYxsndyC40wTgzTWBU+8rqjFrFRjeIEbMS4xYra0u0sPWw+V/Gxx4mKekhlZo7LS/Agq/Hp09nIqIWficpECY1uWtUPo2hkCZo8J1hgPGBoph80qqs5aZ5ZropIH/+j6ZQHco1dxKJWLQzy99/J3p3ENjqlyMMlWQgfr4so22/bY7g8Q0vUsEFiLWnQ72NHHPT1+8QdQpAOngTUTAqKWsXF9aJ+bJutvfESneEFlOU8Oetr9eODlLx7IKXGzA1KV1xrIhK8OTzoikdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+WlI7ium83M+NLdfMdHkGX9oAHRE2rwQVidrnG7w2A=;
 b=KuLp9vQh+3gv2IW4bPCQPeyQgmC/sfx1zabIHIFZPRrhcAkmdE5HRWFOkBLBHl3Q8G0PXCAWz8qFMADQmxj/SXXh2DNvQDydsH6Mb6j7+GI72SjbKnWR9UK50QXk4G5JeddmrLOkyfZkO1C32/QzKizhnQ1h2uR2V/JcjYEgJDLawOWNcqpAj7vQ2ZJff85E2pt6QEWpCZSqiNwQ0XZgRCHmfiICXR+d7Ke2MBIz58+UYZhCbpUpcKlzoi4q9IbaXifqqgaSijmgF2qMGBbDOZ3wFEea7KS18S5sbZYlHTzaTVfOlLQxy3DoGh1oUs2ksF0a3dPmXAlczHE1eafUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+WlI7ium83M+NLdfMdHkGX9oAHRE2rwQVidrnG7w2A=;
 b=B+tjSDvHFpQCgikreq3yVL/Qj6VjkjWSpXvGJJvle5eFqisHHpMQeXgaNsQHBl+V9PAJLLWQPW7AELbcyO+ey75d5BEcAzFFLKsvaTLpIYdhr1kC9zVlS6Zb2VU9YM84T06pv/1xmPkE2knmzQmdLIQEIx6KJ4VZRCHFlxmINfM=
Received: from BN7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:408:34::15)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:03:58 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::40) by BN7PR06CA0038.outlook.office365.com
 (2603:10b6:408:34::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 21:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 21:03:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 16:03:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add missing size check in
 amdgpu_debugfs_gprwave_read()
Date: Wed, 23 Oct 2024 17:03:42 -0400
Message-ID: <20241023210342.685808-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023210342.685808-1-alexander.deucher@amd.com>
References: <20241023210342.685808-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 8203ca4a-b882-4419-4eb8-08dcf3a636c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vs+6+Bk/mxZMYZNuYzeh+IpNNmDp8K2GL5y69oIx+H9+YAi8aRH6mVsKX43X?=
 =?us-ascii?Q?MtUvjt6X+ueWy3L4jfCPzrfTQB0zDBFcWXjVrwOnrKCdMPmIzV3wze/qfXpD?=
 =?us-ascii?Q?xC9zMucAX4GCrWn2tirvok2N+G0p42iTZ7vkSc8m2acJPiSMAG4GudPsOhIx?=
 =?us-ascii?Q?X35DfHyChLvBkXCKX61EmGEGKUx8GDLNVUtf+eodaItxpTXE4HE7nh4TeL4a?=
 =?us-ascii?Q?Y08C0Re+Z9uXSoBsf4Ke36slYyN4NuVOdADm1WUkUDyjjBy4q63ClzmbZRfs?=
 =?us-ascii?Q?85MxZDbDzDBu63vAUSMWSaqJ3HL9DTlYGocMPy5hZGT6Qy6SVIUlrtM47bKQ?=
 =?us-ascii?Q?sy73avu80sVhVzPc1iJUp/FEw/2XwfEAViuYIYoD8C/g4RrxuxWIMI/f69EP?=
 =?us-ascii?Q?vf0887jtbDnTeRX+5RTIDKaP5YpPbEo7S0VE7+oIUbeh2KvzKhCIdBNVihbb?=
 =?us-ascii?Q?iS+15awGvhwC0QYdYyN8y4G0Kg/GOg2Puf5965BO1B5cHy+Pt/xPAcK0+1DD?=
 =?us-ascii?Q?dNcwf1aBQcCzr6nxSEBYNktjQ9EW9NUZ2t9xi6+KLavH1R5GsNrANKuEwPPJ?=
 =?us-ascii?Q?+DESoKRdlcYHh6JUi+oLu6tSZVlUzK4YadSi7BAbbrRraP0Ed9halwWemfWh?=
 =?us-ascii?Q?fkK/5lSbVWg7JaQdjmYlH8MPH3dXgBd0gb8SYQEYhPh/tseK99ydXOx7PH0c?=
 =?us-ascii?Q?97x68u9LDZ+m6vlMu8h+6a+Moj27KJUf5j7+8iJye1AAgIejI9H/MDBN+aO6?=
 =?us-ascii?Q?5r1W03TYKCEKDIndf5+6a7MOqV7r3MaDZ2XG6/25k/n5mH5PXrBB3aMlj3BX?=
 =?us-ascii?Q?2Yt0Io2ytXwnkc4LCv+xLCoXbfeWrO1vxb57hSkH06/SCk3ggAhbOgoHXyC9?=
 =?us-ascii?Q?74p0HOlB37VfJumfOZ9tKw5h+x+zAghzXprUO7t8T1UXYDodfAscY0toBFZc?=
 =?us-ascii?Q?UohMpFETuB8BvsTu+u3FFRfzNlo9lRgV0B2zKjyblqW0tOJ2K8P38Wtxc7Fi?=
 =?us-ascii?Q?EQHK7LPTeL+kDJP47s0OF2yEwJW+fHaZQ6AlS4cCghrXIyXCRu7d4xSeKb0W?=
 =?us-ascii?Q?0PRySZivBF6p/kyb7brTCDANxS/pY2uNEe9/IRpjswH3yvuxwxhyJGI1HN/l?=
 =?us-ascii?Q?9oqMxLxUfBkLjKnu8o8tp3FV1PEHTKdL/taC8PLs1F/s7cXaAo3TUdWic29q?=
 =?us-ascii?Q?t+BANdjYow9ZBFwLheHlxKH2E4UEzkYTgAocbe0P96R3pJ3tZ7sS4Zc1j4xO?=
 =?us-ascii?Q?wNLIwf3HZvUHMxxVFoYeS2QrfdP1OC39z4/Hogoxti8WUPVIALw29QdysLr1?=
 =?us-ascii?Q?0b8c3QlxRM5hTGfVFqSWUgiftZ4iuYrifs1Y7M4oHKibHkE+hKSXtWgSzbN+?=
 =?us-ascii?Q?j/BiUtoOOHbY3jH8rNVRTnqSKwUUNsJKjgKskAFQ69+1vm5vHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:03:58.7836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8203ca4a-b882-4419-4eb8-08dcf3a636c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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

Avoid a possible buffer overflow if size is larger than 4K.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2ef7bcfdb2e2..3a118645b4bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -402,7 +402,7 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
 	int r;
 	uint32_t *data, x;
 
-	if (size & 0x3 || *pos & 0x3)
+	if (size > 4096 || size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-- 
2.46.2

