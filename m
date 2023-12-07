Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23F4C10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D5B10E9AE;
	Thu,  7 Dec 2023 22:54:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432FD10E226
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui767HgxB0cbZEzEBEZUQHQuworKKZac5ZWWWikikbTbCYZsJovOciIfJEPocXdx69B5tTh9h9SGxwCXXL2vsH5nEQ6rk/8kNHJ9SRQBBqPIMGlZsKOmtUn+UxlSx6UZzOEMc9OYf2h8HxYdjBC7ZJcdll2HUqTLR40PzIXs2nClgzLdNfwfAW4H5/l9WM7GtdL21hdOd+OuR8j86djX5kYc4uyVob5Rkpq9iptrQr6nRLqs2TM6TrZInXSHzTjQkUuZCtnfQ1I+mqBun7W/Spi4xQPkgsW5Frt2g1Zrb/4optuq0c0mx4FCKvtj8rDqh02uIiDjlFlQqMO7B8okaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEM29RccBBbd1xNSCYLa8APCVBeGTb5+dOrmRfFZVEw=;
 b=SXlgprabLCBpYFBy+fM2LwkvFQfLeMpo3ZN8Vlj0LL082tQ612eBHfbR4RD81blH9v8mPBZfuF+vAKpB0lev1RDclD8AZwC/ioAPbA9tEBwyOPnTWQDjDvIGNPlypufSbaSorlYDpABEs24UXHDHzIYThEzQy/TFNB1/rYZcCSZtjOEW+unI1DTQk/Rx3mcd2mDbsRePQfiUkXOuOjJtPw6urEJd9VXFBpbvJcQJTFLvjugJd6Uk7kbP9NPKPwJKvHdpYNSjmUBZjqHCvUNjl89qrRxiuA2tEDDhQxmqDkq28eWX6g0gESX477tI4ue8KxjTav8GzuV+DBE6NbdEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEM29RccBBbd1xNSCYLa8APCVBeGTb5+dOrmRfFZVEw=;
 b=Fi+gLCmRVhgSxV1uKUbcZxHMb8uQ+w7Bf4EFuLhsobqIeH+ztmjmNOsvqAI0M8l7P33QtVF3RHzIcTE0I/O1iDOVUCqJYPt+lz7VJu5e8q6ULMx19dPHXaVM7wZh6c3yZX5EYvPcIuCEs6Aw3REuviAk1rm2Bw1RkVaIgT++gnI=
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.27; Thu, 7 Dec 2023 22:54:51 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::69) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:51 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:48 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 23/23] drm/amdkfd: bump kfd ioctl minor version for pc
 sampling availability
Date: Thu, 7 Dec 2023 17:54:22 -0500
Message-ID: <20231207225422.4057292-24-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cd77d8-5846-43d9-409a-08dbf777855c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDxFg6C2bhfl1JN9xx3GzNRGRsPg8UT6ib2Bzt+GGoyVrD38Wo8Fk4qoLXh7wGLKJjsfa6REDtW6mpqVzQYwoFA2SgTARq9utvZKgzLqkUI8BBB//Kou+MlL04H/Ob7QK1RKu4gqvuaq7CBP0OyhHSmgfvIy42NEji6nIYz7sESVfz/l1FsoZwB+/YFdO85xPrf8LqTTbBOGXAmcyZkXLXG3JoIzYseBLPnzUzEB03lZXef55jW6RYbvJ5rrH+NwHNBHqJXHi2e6sd4U2gOz4Bpc+B5z3cBalU1z4OBEAb+d7rkAL3sC2cvF0AOCRfXBD660cwfr+D4WMabLSH1d0nT3LkGCoK7QKYoWClio0NKQWnXtQazRGJZw5FjWtUYKLVuSUCQYoCmsZ/o04m+BF88mEovoofYpyfZWlfA9vUMxSXT5ehGR5nxAuCLQkgDcTlDX04H5n0NijAQbNxjEVYc232uiFqUauu9WF8Uo/KFmbaD7eWPmoGN9y/diKgOIN8zuiqooG0LM4Kme2zh0Iyh/L4P0OiJLrqsvltgqI+v2827LrsKleb6J5ROGkVqWDGLGXLSUippxJBpNlcMZR+wGTv3ddiyamDINMEILNBYi1sqnq2bc8qrVd2j8H7L+XwA2hWERC8KdvX+TGc1u53EShZ+APT996YCenYTzV9QeToNGzwdqXUOaJRy1UDix0x22LnuSyiOwltvZXDZgO4EPDE1fw1wbZ65cjx/zXjZ9uRU7ubIJMKDsZjc7pZ8ATVdXt6kufewORB/qaL7ZUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(2616005)(336012)(426003)(40460700003)(83380400001)(26005)(1076003)(16526019)(86362001)(41300700001)(4326008)(2906002)(4744005)(5660300002)(8936002)(8676002)(54906003)(70206006)(36756003)(316002)(6916009)(70586007)(7696005)(6666004)(478600001)(47076005)(40480700001)(36860700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:51.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cd77d8-5846-43d9-409a-08dbf777855c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    Bump the minor version to declare pc sampling feature is now
    available.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1bd1347effea..62d8642d3d1c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -40,9 +40,10 @@
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
+ * - 1.15 - Add PC Sampling ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 14
+#define KFD_IOCTL_MINOR_VERSION 15
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

