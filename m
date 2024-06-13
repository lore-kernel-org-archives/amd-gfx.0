Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC0C27C6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 02:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2C010E95E;
	Thu, 13 Jun 2024 02:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klmFQ+6H";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9BE10E95D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 02:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7weAyo7Kq004OC+v8/kgknVWKrA4oXNiJP3+J/87XDkxADqiXjFNur7qYV6gDY/MXmm2rBgkEGBnORh/jP+O0+PE1TLMLIq7d2XzGnaSBnBAn1c4owyCjgNAj9MskHOvW5lNavaN95v+Ve7uERN6hWMMKyr+Dba5+UaUVSnKJXAGJxpf3HbO8ovnPj1ZJHLaUVjos8zO5WIIgonYQckY8WNRVs0rfE4GOHM5ZOIs8hDd+awBAgO+4k151s99hgBQuXsxAt2uiBJxqDJEzs4SNLLObeA44ff2LafBXL2r+bvIAFeSUh9canbETOGXXbQELzTNacnqlVLEYaRh18dXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvcVDBhYUVoFCdhBKZojOEY6Mv8M+NOrRSZJQ9OpJzY=;
 b=iOEJhhR7T0RyFYmtV8Yw0g5cBTQYMZwbGukELcEBt51hLx8aLL8NxYCzRmZNG7QrD5qGjW+mjzBDeXD5gMoiBfhz22QOhRvtUkbH9hkxMC3QTRJ/wG0KLzz8Okb/asH6mCdqYX7ka1AEeJhpd1KcmoozB80I1w5jGqYDMoI4pvmzTzaxY3zZqiJm2YGYc4cePES3Z8HVtP5UII9Oc5PQeOXCSrp6WtQ1BdyZXlqgNxEr26d+pa+8YevZ7b+7Twg9ubEqm2s05eGwuLTuxFOymmhDf/OdwSuTw6CXkhbWBf76gF2ZXhnUM6gj0AIFFxZBLaROS2lV0so7DXIl7dfIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvcVDBhYUVoFCdhBKZojOEY6Mv8M+NOrRSZJQ9OpJzY=;
 b=klmFQ+6Hpw3fdT4GLd+lJXbSQ7ObdMg0PxxNC4wD8HYLRPnCBC/FyqMcrHdOzJZhS+wvtXNvIlylKRVD1wNTkL1VwfW6f3gPXRVhtbt5VfzL2nfZVsQhiNI81MAe0yVQmjPTvVzYIXIFnOLW5zW+9dktJjVzcQgsbDmP1jcddFg=
Received: from CY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:930:12::28)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 02:27:08 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::8c) by CY5PR17CA0032.outlook.office365.com
 (2603:10b6:930:12::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 02:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 02:27:07 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 21:27:04 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: add gpu reset check before page retirement
 thread runs
Date: Thu, 13 Jun 2024 10:25:04 +0800
Message-ID: <20240613022504.81787-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613022504.81787-1-YiPeng.Chai@amd.com>
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b4ea60-144e-4c45-41be-08dc8b5052d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jnMtNnfUAdz3696j0g9kCYA36xHIS8dpvpxjRSNdggju0sVZBgOsZmCdkoSL?=
 =?us-ascii?Q?GTEhvBrnMnVhHoCzpQL6WEN2GcqIsPXS5HkphAq4jyrp4fbye4Z0i+PUwdAN?=
 =?us-ascii?Q?szB3Yo7Jlb+OjTV9qABt60T3tkBgRmyUVqPLFqp9f7NrnIZat2mLCvAlSUiw?=
 =?us-ascii?Q?/T4MvlFB0iJS+AQc6LGckI4SPGO5sLROadf/bF2W6STGVTH/0PdinFpXlNpE?=
 =?us-ascii?Q?LzZdH68OAUHAksizF6ds9N39wHhBftQG8oiQhx+gblumjGHShpCmP2wvDz5g?=
 =?us-ascii?Q?XzvV7tzcmPyA43IxVculRXF8brHAG+YJ2lVOIF8F5uanpUgKmjGXwJ1L25jo?=
 =?us-ascii?Q?IE8iox4VaqS1rnpE0lXqZFNqgQEBcBr3+BuRsqDOl/8euH8GChZ1g7EunewH?=
 =?us-ascii?Q?3verOyNCWoz+CR9HBYkQdNgI2V15EZC0id6q+eUdFlZIQtxyFu9jwDHh4SKk?=
 =?us-ascii?Q?uESONzI2r7jj7ceogmZK4zpYbH+O7sZHW2OZSyObCbMLs625v6Qpy9Kcf2DI?=
 =?us-ascii?Q?sWlw1ueN2DR3EvAVWek+f+RxAmMomO11cbfnYRShGpWJYx8qz/YJtG7SFhS4?=
 =?us-ascii?Q?6gQYujjBOwgLFYSij6JaqiZlx7sMw+MRwCXWmFqOANMMWN+u9/K2hdBJor8C?=
 =?us-ascii?Q?MCc+hyVBDM+jYnG3qixc79/GeW4y9F13RnmK8HbaMmRHAw7zIDhhD0d0k+UP?=
 =?us-ascii?Q?Sx71xTO3ZrXqLnEJxfcdGSi9srW1Q6WWhHpnaZSY7YDoeUrNNtRlAzdl/aRG?=
 =?us-ascii?Q?pbOBD+LHPPakCkRum9UAaO/H0MIUnVrzX7db9gSkJdKa5ecxvZ7hK+NWfP12?=
 =?us-ascii?Q?ANBtUODHXPd7RXEcDPXS4qA3gSnMPVKL5ruAaqk4lS4hnHMpsmOdKdzT295L?=
 =?us-ascii?Q?gT8z7h7den/HjHWlMokAzSLKSQVXXg2q2WwhzCpoJpO/S5FcA58CQVwFH7kW?=
 =?us-ascii?Q?tTZ6R6gC0AZcwDKMc6GpMHiPkhNoZdgtD3s4GxX9VL3GD2YGBOpqnUqCBODu?=
 =?us-ascii?Q?YqK+CUChzblTQ7OvzxAApoax86hqMcFPIg0TuPpLnZbdomdxWASk4C/M+shk?=
 =?us-ascii?Q?K0bn3lKhu2nIVv0+sD+EnjleSPnGHPKuUc5Ufcpilfs9KU+v5Ea9dyZWJ0Rx?=
 =?us-ascii?Q?lhywCgFHwdzUvBmG1fmIdKxzMcWxzOV0H6GYAG7pEgXDq724CheO8bhKhWPQ?=
 =?us-ascii?Q?XlIO8QbT3c3fKgPIHsg/vORmYynq/GCbb3F9e0Hi6h1Sd5ij2XKXUiR8K2jK?=
 =?us-ascii?Q?1EgnlL/C6Ysej39cFy+7LtBF4HxRhQLzA0LRm5DTOjRqvW/SihfPlL8GGD6/?=
 =?us-ascii?Q?UKqmWY1kPlOATY5fr7OmsirbnSpvMZx0nDBGYSLxfJ+sluugsb0laoO3VVnm?=
 =?us-ascii?Q?CHE5aTriYrMgIJIs83QXqoqe3gMcqsan3XmBwDawS87Yz7tObw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:27:07.9823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b4ea60-144e-4c45-41be-08dc8b5052d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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

If gpu is recovering, clear all message reset flags
in fifo and wait for gpu to complete recovery.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 341c9bd0d1a4..bf4f8d439ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2982,6 +2982,18 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 
 		atomic_dec(&con->page_retirement_req_cnt);
 
+		reinit_completion(&con->gpu_reset_completion);
+
+		if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery)) {
+			uint32_t reset;
+
+			amdgpu_ras_clear_poison_fifo_msg_reset_flag(adev, &reset);
+
+			if (!wait_for_completion_timeout(&con->gpu_reset_completion,
+				msecs_to_jiffies(MAX_GPU_RESET_COMPLETION_TIME)))
+				dev_err(adev->dev, "Waiting for GPU to complete reset timeout!\n");
+		}
+
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
 		if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
 			continue;
-- 
2.34.1

