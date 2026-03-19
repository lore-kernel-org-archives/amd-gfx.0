Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6806A1088E7F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 05:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E4610E0D7;
	Thu, 19 Mar 2026 05:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WOjtvmOJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD61C10E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 05:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGFe5aRntrOx7jjb2qejVMPAsUHYqy/v2t12ddEczp1+fL36yp8vu9XZnpvMq5fNEiUH5AxgJVbtQbE+fjNGZeS7XyBtSUZv8owMwQ0DHDu/1FWQAKUhYtbeGs5bZ6YU6CI3iB7qqZzkNq2a35Elb7WUTgqJjRNvy1pnywiAAYCsc2ZAU1Jk6j4iBEDDlOtVlqQNEaR3/w81X96f1dZQ96Str1aDPCNfVgrPZhlyvhLmI1LDNL8k80/ZJq2Ptr/dEuzVMGe7HUnstyHSjrJNvyP+zRFRhCO/Z/WFCC0hhOPwzNvwOqVCMLAw46U0Hu27W25vK3f0d9keIWlGSRL8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3tj8aWxu4QQzax5xMVLHYm32KODWb6fx89SWK29vAY=;
 b=S7OsreKS82vXcTJ+PwraEz36uvJIfOBntMMRHNV3W2sIO7rW3Y9XCUd+/GrupYZFzMCD1EkPUiosqimhjzZXPXOvbFQQPr34sXK1b+gmD3UNwE9RCw/cN1U1i8huRbuou3L4P8e+lWetXHJP8pklhlEpxVW8aBwQARhInIUHPY0ZoiIvH8HcV0CljknSdwnQgeglNNyQr6SKL5NpkHFEfOHZkZ84ZW5qMVDb86BEE71cq/Rw+cZpYlHOCjLgD+Wj+71wQ2Hyoae5wwt6nj0xZaZ/Xx75WgTvxZ4LF9A8jpHh8qsOeG+6eGpUKdWrz9jO7BykhWg6JE5CnXmRQRMNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3tj8aWxu4QQzax5xMVLHYm32KODWb6fx89SWK29vAY=;
 b=WOjtvmOJXn8tEuW7eZPYit1jP3r2a9L4bUSA2yNzODmDQQ7DfIN9A4dRoHp4jcB0yZyqTE3l701KPCQ3yDM8NuqOyX8stqocD881zUZgfpvh6uVHx7YRkzCq5xNPEtZeV1V6v8kOacmu9z4gyXToDNITVyQi6ZMSdrUxTjsZNYI=
Received: from BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 05:48:15 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::40) by BL1PR13CA0021.outlook.office365.com
 (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 05:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 05:48:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 19 Mar 2026 00:48:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/2] drm/amd/ras: Fix helper dereferences and add input
 validation
Date: Thu, 19 Mar 2026 11:17:55 +0530
Message-ID: <20260319054757.1987819-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: eee7be03-0dc7-468e-179f-08de857b1d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1EQUPRHSQXap94Vx516XjsyaHeyGKjt2HjGsmYgngna5++Kb27ofK/hJdOSZhBaz2ZHvEm+U0OQR4YzkKf1ltnY2VCJwD2ho6p3IsVtLE/+EWxYywq7Ae/U5obTze611jkk5qsaDhyKrk3v8Tjcfq2Vz7kLnzSocqjumQnnW+r2kKm1CwtM0NUkFfkiIn7ODYyfIVLhjiYOezjPmxigVJ9uX5GZVc/8O19icCef5d/IOwX76UzRtvaw2jUgvdMXxzZX5FXeOp9rhJzulrx3nIjr42OS6QLG8orMbToSLODGviJJS33tIgzHNulD3u9EbjHu2lUPa7sZahGWr5HMHk4tHDYcvLlJVVZAF0geNmAen19KsHt1OMUcaieD//XTuszq6egnet3n6NdvJZYgtyk3wFjxdCAX6cAXjwEUsgfSHEvLGsPMGqxG6gAPZvtlnbV+FxDRIBUnCNrZMvV7JV4GrFDACIxUsc3LSTNXiTsbtOQXPMUxPPY/F8NoAFRO44ycj4LwXRaaAD1mexCGvCQitFMmy9zU8R7LHqi/IK+6EeFB6plz9oBT8iRvYFdXMJIJqlvGYCHnUbUzPW/e57ZPygsxk1gcpGTCfYeto26nrGoeHDNpxaYHnLWEqRxPX6UxddzeQKyzRV54EJRKBhhVsrQrfxkX7QOBDBgXazsj5fnZtNdRAHZPd/KOyQ0ARdfYv+6tGHvhLHcSLF+sqLnOKMW3e7DqQZYHsCI+Ig5BGGsOHgSOacOIOo+n36B/bZj62euQ+p5VVOPwAc9h82g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mrvx0Hl7ZQN/6gsQfxk7Hr19F9WlqMPR0VOiPGfKM9sj+66eKBG0uXe4Vxg8+z1N0Ohi0WTxOTgFnqGbX2eee4i9OtKKK9mTOczsCi/j+8mmGz3mpgKOgro+QkuG5XYCSslp6jf+7pjNFRYLIjykxCFk+ZPxfqpdIcJ4OI9emiU29bFRaz9ADefkQHWc4riu44HYOCS7vZ/JdkBzUkI7xIg0TgaXRZ3uGXmEPj6hHIdh3Gtcb38SCRtrfOVuaJaF/XqoGRQr72CTHrBSNXg/n74QnaAMn/9OOBmEiUjT0WUdqGxYbe6oIEJYqzCnSVWl7wBd7t0e22t0lFyrjeGuAwFunV/LVTYMOrLdAstGGX4XXai9hMSKeyGfZoQUxiZzap7I0d9epy1msHdGn1h1+m6NwydBZ7JdIPs7vdTE52UkL2OGobhHcpintujk46ET
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 05:48:14.9178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee7be03-0dc7-468e-179f-08de857b1d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

Some ras core helper functions access ras_core callback pointers
or directly dereference input/output parameters without sufficient
validation.

Srinivasan Shanmugam (2):
  drm/amd/ras: Add input pointer validation in ras core helpers
  drm/amd/ras: Add NULL checks for ras_core sys_fn callbacks

 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.34.1

