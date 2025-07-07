Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3F2C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE3D10E527;
	Mon,  7 Jul 2025 19:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0QOK2wI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD11110E524
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2MyOIIjUGPCpdRsdUsi7e4cFnCjuM8pe/CFSRL5aJEE0xa9J2sywyX8SG/OTvYyn6JFJS7I91FplyY0u8m7kUhxSpmq0WHSKj1IGgOjmTq4l/kdkGK4vd/2Ii+6CdxM8lVYgYrrfZFpOb4JQTCMobCSI+XxC4WEMFZjQLmHV+cIkr1ONMI253gld1wrTai9DBuoEqEO0yx0teO9h7XOPZVthMSADwKW9OROGCbdKdENNsMiraORDBL+2adkE9L6cEWomDjRHPywH8w/zL+2p13XWM3vRi5tOf/np5t1Qt5fa+EH3RFE20x3Ne8to7GGoz9O5uOoc6Rw+K5b446mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C2k9FmiY8Gh4AX31DOQmAHINNKgxGuvoaNHUoD8/fU=;
 b=d+4mEpVYYTjgwLCm60nlp4jdwKIbp+rhyKYYY3wtENcpFuztkEZf7qYUGt9y0t8ymXilGb6iJV4+gwV2F6yoCVcG8jXe0VrPTOVoO0O9AzBOYd9UBRXBbCaRxotsswbvXUovfyGp51DCWp3a4OOG+5Etv4qeEvp9E4c8fQFz5F90a/ESKZg7dQqfyYylhFhPf1q6FDyRPa+3gMk4lDHE9bHL/1Y18CLg2RtvN1yH3vmZ6Tgk6AkSsyYIBkd2SB4mwSkyS+6RcXtzs4FV4TXhrrs8wkNHyTb6A7bAxpM7wpKlcVUUtM22561Ln7HW87bK/EGanhvR1zspwkSwtLVUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C2k9FmiY8Gh4AX31DOQmAHINNKgxGuvoaNHUoD8/fU=;
 b=W0QOK2wIjEbJn0HjI/+jIl/c6feEm+bdLDec3SfYJspXnZD9xg97HRGAfupTH5xPtzZhJlwWy6Hk9/Gzd7mts2ND1MSGVsW7RhhkAC/tMUkyZkXuCXqQDS5jMDoF7AaZfSAn4es7n21X+Oq+cwEjpBQ+O4WEqTc2KTo8IXd5bLU=
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 19:04:12 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::df) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 02/36] drm/amdgpu/gfx9.4.3: fix kiq locking in KCQ reset
Date: Mon, 7 Jul 2025 15:03:21 -0400
Message-ID: <20250707190355.837891-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: dccffbc9-380e-405d-0fe3-08ddbd890ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fAeS//pWTjFQ26F2+9h0PozRAOaLqcVLiQWiXF++vEXSl9ifQuiqzhf3fcKd?=
 =?us-ascii?Q?3giriNWDrgDv7+aESTnuSQ1PSEjd7OsFFbxXK3vAXkqs7qm/1sucXhBe81oT?=
 =?us-ascii?Q?sWyNLD7x27Wduoi3XfPlDTcFjh9KDTXTz0fdj2Jyf4BHPSesAp+Yx74W41d1?=
 =?us-ascii?Q?7EkrHlW9CYUE7v8LQP8os9cPGWFioAbFRUjGi69FS7vXYz9hPEy3eHNKoSiI?=
 =?us-ascii?Q?kMYKXVDdo85UC/mN3qmWHFiihMzR2gcgbiC76pZpekJsGmf3+ew9dCJDuwnz?=
 =?us-ascii?Q?7qgrJdWaEte+fJgWhae1LW7RiuU1yy9mF2+uytVht8DX4NOsYYPsOPZaldP1?=
 =?us-ascii?Q?CUHHa8m3MZejgrZuK2N4+/2CfISUpa47WkiwwGAoafU5HUQjEhHTo44jL7uF?=
 =?us-ascii?Q?ZsKMEFGs0CZkOsa5HaGyVX/1w/SnyRvbVGWsgzPkcX7i4NSanKG6JvDvpl5U?=
 =?us-ascii?Q?3OtM59UFt4pasNYKYq2VXhgcIHHfFdPEMq2zH4wmLbboNYG1g6fnwlOEwBsC?=
 =?us-ascii?Q?eky3y157+nzg5Bi6zfPmKMBx765P7ElLEmM3NCPsiLtdpx6dDeaI6wacmEMv?=
 =?us-ascii?Q?dSArQ74AbnQT/ydUcKHFXUKg+xYookekEpiHjhpiKBwNZR1cJuqs/ZVXZrGM?=
 =?us-ascii?Q?NwQpnMBdARuBSziKDWnYB9w/NyvxQAI7Im3x0wKxvAm8wwO67rqSne5Ne54s?=
 =?us-ascii?Q?zPOLjTnwek6H6CaAV7sx+hFIWVGx3wWx0sDw/0yJQ/1uPh08zz79PNSKjOnN?=
 =?us-ascii?Q?49E+wzpbosLy5iNPhnKVNch/R2yhEZn/3F9NN5ijvVWlx3GNcgCjDVBbH09f?=
 =?us-ascii?Q?8/7y9/cnnmhqAeo3OE2inLhk3/lZWX22RS4TmdbvWGd9u4K7geTMGUnKwOyk?=
 =?us-ascii?Q?i3K0XYlmvZLlm6zcGnr0NEx+GhWw//OccWIHbDvblm4gvwKtK6vcUrro0KkL?=
 =?us-ascii?Q?qyUmdpg9eXtKdmMoTYIvZZHz7lNGjXkcoARmPsSFdZobjCmrPNu3N+jkyO6h?=
 =?us-ascii?Q?aioi5EamREQkcPfVbTIkeCXNQ+A3RBYtDzR3ns1lwrXAL1qzM6CQT+oGLPDk?=
 =?us-ascii?Q?/AfIvZb4ZfCSldLlvQ0D6aDKsk/NEvcMA6u2jn/YGnTkW54nnVq7cy/cBSlX?=
 =?us-ascii?Q?7vCrzFx4GTykhZxqwe8ixhsXLVnTcIMC6L24VIb+yWWhSvorptgMnh02pr1s?=
 =?us-ascii?Q?OGls9KMEea2REaGLQrNwEKDmqLV5pO8V2mBR6wp7HNzG5tMWij/mDzeC1RD7?=
 =?us-ascii?Q?VMAGHSX1kvUHZWUPMheaek061cKWP2ww6Ub5XhqVKOrEO7AC/Kstn7YcEiBH?=
 =?us-ascii?Q?z1mq3haa8ISoj9uzq2pNUqGNhmkVPSSXdyFP7J9turYqCIbFPXh5UA6k4feZ?=
 =?us-ascii?Q?S8nMd1fh2SVluPf23mBSQUPRpjhWsW5+fa+ULJCKxyyFVpvrLtkuWHWFgksE?=
 =?us-ascii?Q?3KyHWGSOV9nAkl6ehU//YfTIPf5egRAb3t0xroSNQFQ/Sj7lEqbeSpJoKbff?=
 =?us-ascii?Q?hB5/ccpZkK91Xazjq2h9z5/zeb4T7iPz4nlE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:11.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dccffbc9-380e-405d-0fe3-08ddbd890ebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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

The ring test needs to be inside the lock.

Fixes: 4c953e53cc34 ("drm/amdgpu/gfx_9.4.3: wait for reset done before remap")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index daed0f187bda5..5f92975cc3058 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3615,9 +3615,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
-- 
2.50.0

