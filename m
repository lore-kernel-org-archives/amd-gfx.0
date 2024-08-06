Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6EDC52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 17:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B1410E3CF;
	Tue,  6 Aug 2024 17:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DfH8OWKH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C074210E3CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 17:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9Cel2FMwf9MKwuWPL2FyfrT/FLTNeQbYcqSsJtXle0yTLprY1Db1GeMUPfyN1EuZp3UVEm2lN2p/JikXCB/6uYBK/TVvMGRKJ8R0xv1LmM8q4W7TtW6D5mqJNTjvmseFE3771UaiUvOnPf9fwUi1qDpPOf46+5XTwY6vMKSlS/1iNYl/3FiSYvapzUMdTxOwxL4h/xc9yL47pbCEmTQpH7UDMUMldbPvhmjTNJmRnM0OHR54vGk9vmGxrEhTGw2i7C9tLe+drsBiC8AIfavRmxqhOoqPLUK5sTVhs5t+PT3HauTSxorItJ5xlULc7w2nmHqYGR/zU0dAhOxcaUUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a84vEpK5HQcl56DXxAU3iEWkNB9QJDJXKuT7n18RCJk=;
 b=m7elVMTI7MZKjxvQXdRABF2IlWcnc3HeQYGNcCkMvJj7jhJdyCyLTKh+EzDOBrzmmR6A2SL64wYqg01OkGziu0tL29pjA3OKR9BpBENt4BlzHb4+inPCbLCCqrJQHVsF6nHfKId/u1BoGyly6cw3qrfueXm2UuLjqdKtTtbK6vGAAKCOOvZXAzG8KTnlYxBB9Gb9hwG+9f5Pb93T/ftO9QvxtcRJWwOK0Sqk6a2zpONGyqxs6hyPpGQUGT8JQMbX+JS08VGY9DmZrDRCMXDeAo7wZ9LeOafQ3o6sv5JB5CzNqhw4Bqkeb/Et2nukdj9NI2nOPmxeVq5xmhwcRV7xJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a84vEpK5HQcl56DXxAU3iEWkNB9QJDJXKuT7n18RCJk=;
 b=DfH8OWKHmkidAfOokJqhuLQIi6ExvihrsoqwazTOdt307gC0WcOMqGFA2yNUX65OZkfTRvwfCKbB/1dJW+4THGnQpP2+Nn1ZfWJB4Ma/I1LV/W9TuWgfc5e7yuDYd8Xw0ko9YOZVDZbjcPL2Y5q9Ee2U6uzncTdeZ+536+4LxaM=
Received: from BYAPR02CA0053.namprd02.prod.outlook.com (2603:10b6:a03:54::30)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 17:03:21 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::b) by BYAPR02CA0053.outlook.office365.com
 (2603:10b6:a03:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25 via Frontend
 Transport; Tue, 6 Aug 2024 17:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 17:03:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 12:03:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/amdgpu/jpeg4: properly set atomics vmid field
Date: Tue, 6 Aug 2024 13:03:01 -0400
Message-ID: <20240806170301.2064080-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806170301.2064080-1-alexander.deucher@amd.com>
References: <20240806170301.2064080-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: ac58ee3a-ca00-4d01-073c-08dcb639ace1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rCuBPA69C7DIl4tS6wzvaZYYH4dhp22Hm1XOXToDsmxGljcIy8J+JCcW0EAb?=
 =?us-ascii?Q?R+6g6f4IWaYSsDtg51HwpPFgC2gLAAYLdjDdKJNgHsIa/jlU8kYFpnqaPa+v?=
 =?us-ascii?Q?5BHxltmi0zDC9XTIvXVg87iEbUJhayTybCLQN1pErX2a+un3rdLQy9VosMPn?=
 =?us-ascii?Q?c23pbcsEHGn/zA0jd7vT8h7pnDgqzSvfq1yxeG2kR0BXb7MH5/JNeLldfsyc?=
 =?us-ascii?Q?+G80vOB2yyXHsWEIG/bkuIegE7CgyYZVOgsjDpJu1yOzZc7mGu2JfOhP8lWh?=
 =?us-ascii?Q?++xPMfAXCmSuSqVT74TtCutQIXSELF+FB3CsjdRwduZ0yuLfM8kQ/6mzN4uJ?=
 =?us-ascii?Q?sFWKzo01N64MfFcsyxBhnQw368pqFwkDEPiF0f/QQPhJ6u8MIkzxo4Zb9RMf?=
 =?us-ascii?Q?dvKja4JhTpYG2FRzBbYtfgPBXL4VDrd/Ok1R9/b+pSRxC9JbiwbHL36rVlip?=
 =?us-ascii?Q?gNQgUzxEYHeJWNI5M6MkrrskX27L7YDKgP9U1O5EipKrEAa1imwr/b/KJlLd?=
 =?us-ascii?Q?PYruzcYMOqKzZK2VIngKbSsw4RIhySFV2ztmngZe5g3wtrqlTJardKDlxXsc?=
 =?us-ascii?Q?ArUybcIVkc8f8DZQA5rKbiSdL1JxOf/b3qbIKlsuVoC2SpYAIEG2ZXumOSXS?=
 =?us-ascii?Q?tbeGZWxAN0XOD4XgLWN7fL0LGKRAeuSuBR4o7z8IZbNJNTKFhLVe3NTX87uJ?=
 =?us-ascii?Q?TdwWO0PwwKCiIaDOG7bNA/67Nk3tl4yZHT++87NzBKRTEch+BKIeIkDp8E1g?=
 =?us-ascii?Q?MbemLxPYymUpteuGvN+BmClWdCQspgNr/LYeNarUVEyWZnVDNCW9cAIBl8rJ?=
 =?us-ascii?Q?iwjaJ9X5AlWwxBIF68PSC1WVUSd9REsn/CUiEw5ciU1gKE2x2khNRA7kEz7T?=
 =?us-ascii?Q?yJUiXTE9afih9Oxn3uv3NYBLks1pfcwADiktDeWKjDmS1O4n/A3bDi0hAStI?=
 =?us-ascii?Q?J3rf9eIuaTZlWMuC1Exg+FeKEPqqKsytnLPQy9F77SPJJni/z1LrZkzgJnkG?=
 =?us-ascii?Q?r7wjYZSu4B8r+0SrnS9ad7RvZ3FO/9NHqDOkAsG3g6HA/7Pbbvpn9IWLipMY?=
 =?us-ascii?Q?j+TWAcd0RamIN0bnr12eai2ymH+QuzqTB9CcYRp8tsPYN03rYdW6UdGH2PUC?=
 =?us-ascii?Q?d5w1/TxwWLP+M+bgKwF9S75uqjG0tDfKyq1Xvf0GXehkkkLFjFytQJZIJNBn?=
 =?us-ascii?Q?7hqHL6+oalmgEqnWnrm5V5EcDR70pDz+q2Z9RkTGtoWGT4BYtLBVVa1vAH9j?=
 =?us-ascii?Q?iw2dZQVh8fMXB1muan9NKfnp65VB/yupX4yfcT1nwv9TbDpxn6Zx6vO7kz95?=
 =?us-ascii?Q?IZ3AxnlgXYYuTrBXwBXua9iTtO4WJvqMPBaSzBMDzIODAHiEckhveeXD/2g0?=
 =?us-ascii?Q?XIdawlAp0SVk1JFoEJBQh3646hHdbhTAoqVtCP2hx5JiCnbnEnn1xwEwB6tZ?=
 =?us-ascii?Q?hK4fhrgnhVVOlKCrdysIyCmbICngI9t4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 17:03:20.7712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac58ee3a-ca00-4d01-073c-08dcb639ace1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
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

This needs to be set as well if the IB uses atomics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ad524ddc9760..f4662920c653 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -782,11 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-- 
2.45.2

