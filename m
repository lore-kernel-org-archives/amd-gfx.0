Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382ABC0650F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A376113CA8;
	Thu, 18 Apr 2024 13:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tZSCBfK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F75C10FC8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDlNXOiG91/O7+kCC64qv49YKFtl6T2wZK6CTjmBg9JE7vL4WXaazDONF2cR0EjVSgLNlOr0ONCNlRstwrnjXNIq2R+UoI5gRBO/yjTkTgY7gqEu46DBVGbmKb82XPh72e5zjLS9uO5nxYHnVTaPcmi7Lp4NW/Gn2/3sAdfwqWF6TPcbdmGkX3mRn82U43Xv/Dy0jzWvxPqCrYmg+nT9jPcD/rRtwpn9G0Njx4SW1IZrYdclbaw1Ev6xKOWxzWVa4qjLTuGsd0hjUqL/49/91d++SEBuGon6jyrMDtq7Gk88Os4uOS4Z1z11VjxBrL3cqyzI7C/HtYja3eF7qXJEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHeH5v/BfvbWUywyd1Irv2fzuXiKXtF/VG3+Ikd6htw=;
 b=VkEV8nnQEaRpy+9ko2ubXMhgAD+dFzjLJ/kJd+MmNhmJigY4ovGQMf8oWZqEPqJgvybO27ETbo8aLl3Y3iEo2vGjU8XdD4oNYalkLXGNlCGmERag5j4zqtyH0lXZfiX4p/XDkWJD9JWb9NldslFhmY2PloAfJSEM1N97coQAOBGGBQGsIXfHS+IvN4pr+i/zWiSkjFigb53p4s6UAJRPm2lBXmj7uxJ3xjaPaORt7Rl2MKI59Cqb08wKk0RnroqvY8Fs9SOj9vq1XrbplYjWjnT+mO5B0Z1cj09ZRky0/jNZp/Qv/nCbXiFkgbH77HoAzCG0u4cclzlBfTj+p/l5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHeH5v/BfvbWUywyd1Irv2fzuXiKXtF/VG3+Ikd6htw=;
 b=3tZSCBfKaG4cwfh8Ep5Xz+H2V9yPdLm3gtGBBcaXOvs/28O/opNG64PV1MbKoZYGepZ8tL2GNc9IeZ79hFTE+FBzRXu9oSFPpxs1TSTrRunJ5tW9Bn9t1v5jaW+A0mvMiKgB5O0kz+lYdhlDcPCK9kJqt2TOyhUe8wjkh5IvmaQ=
Received: from MN2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:23a::6)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.54; Thu, 18 Apr
 2024 13:58:42 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::fa) by MN2PR03CA0001.outlook.office365.com
 (2603:10b6:208:23a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:37 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 6/6] drm/amdkfd: Bump kfd version for contiguous VRAM
 allocation
Date: Thu, 18 Apr 2024 09:58:03 -0400
Message-ID: <20240418135803.17365-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418135803.17365-1-Philip.Yang@amd.com>
References: <20240418135803.17365-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f20b0bc-22c7-4da2-8bd0-08dc5fafa7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEiQ41L4SOl2GoseqYD8qgLiFiwq3zvhl9l3S403eyP/16yNbtvWpGWVXSBMvvysNwaNmIxZRSpjZ1OwUChRqOQf+M/GyWNqxxCJXeB3oOG3gsIMNw+E6zrOzVIlnB3oXpPpZhVtg1Muvmej0BNfA5blX4KXYcc2/1KJ7i/6t+o+L+WzVw3tCXEQUpgcvOYtKbrjVQ+077qKUvPSPZ7qCiAxVp1FJrpNLq319pXJelAKcoeRZB9GekESrP6yyJmcGkJMZiiHrVvjCjvYsFof1+azCT5W25/kkuTgkaCDH+66K14SqB5Saks1kYI2hMkV+z0T8245Z9OHKmfLTxeGVl4wSrf1bZ+hhifvwz/wCie/iON4IHmAt48g2c1hTr6nP26BWJHWdy8Hqq6XdMh/QL9BvcsxDscAJ/jDkvfASEogRL2gg1BgQQ3ce2Z7X5HhS8seNIeKCKHaDEAwjKlLhPw9cHLp/eEMFA/5WKj4f1vaFa5Ta5H4HgJu0yzEc8zJDeYjpdM5P9U399Gg5GcF8Xls95wVebhwSx2mofxeZE1mojMRKIxqmH4YW6LqrNXeDhTvU0vaLgH4EZsoO+tbml8gfzyeHFOKAsRNyOYDGtVIoh/Mfx8xysU2KWKCudoh8JpCmHVxzvpksE2Oaz21YGhpt/1a+kcDmAYqMvr2DNlNy3SL3tU6D//pQ/ha1fEOVv41fS/UCeUd/uYcAOAEmL6He3Gh/bbUIyUL+39HAGv0kFGOZbTaPbiCR2QW4Ioo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:41.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f20b0bc-22c7-4da2-8bd0-08dc5fafa7b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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

Bump the kfd ioctl minor version to delcare the contiguous VRAM
allocation flag support.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c1394c162d4e..a0af2ef696ea 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -41,9 +41,10 @@
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
+ * - 1.16 - Add contiguous VRAM allocation flag for RDMA
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 15
+#define KFD_IOCTL_MINOR_VERSION 16
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.43.2

