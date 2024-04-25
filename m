Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F075AC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598B211A214;
	Thu, 25 Apr 2024 07:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pcwGbIrB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC68112AFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVQGMvOHItA/PWtjisWnNtzJEKimGeiJ0IfUtixkZxOvj/m0ymHIlRUPoaJKzS+AIvn3/9ecenA3O7aPwmYVBQWO8Zxts3P5r5zk8Fjq4YcQ10H4OAPK6xkMoOtjUSZrh1TOZbUkZjVbpLXBKRIsSzCdpeeCl+WIlM6nSBMNoAlBOEEWqmJCbmrWuPRNuu8NweYkfX4Pgzfjf1+8d1SPRL6I5MUhm9Q6kFNF6BkDw2mqn00NJbidh/98nv2d53H3v47Hh/27l69fG9n4Rgw8XL9Lp52KhHBFavz+o1DqzNmwhnTmVUPMtYKeEVW1F4r4WfHmjWcEAXoz2K63NLlVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bpIs8sLincbOgu3BVr/61Ak3nVmKFIH+BKctfAzlag=;
 b=OgWc9n4MaIYPaFCUMKxf2lk4P+tNGmzksM0vUmR6TrL9/tOfbTuSLal058mGXCTy0Whv8o529jF2WegLz1e772M4NMJLu3oBELzWUswIcO1McvTliE44MlwGDFD30uB1jA5pUzIZpTc0GISZ03akcMVg0F/b6WrV+ISZTQ15NH00hnkV4e1JstYEYohUBEo159Lus/YlQNo2YtiNCbYChQj2DMpMtyoGOLReyL3ia715yeoi7MaKfCmpBN7xqrFCLXMipxr/LLEUwpT3Wsna83C4CiRxbONhywb6ZA39gzfz7Ct2L2pL7dE5A6vhUzh6oxZ73dVBRljfxwxsG/CePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bpIs8sLincbOgu3BVr/61Ak3nVmKFIH+BKctfAzlag=;
 b=pcwGbIrBIml8G1zUIiV7C0r3DDtNomFwAWgW9N1RYU8NH50W6+6/0vMEny+SnyF64w9wwkL6qs11Au+s5Vj9rm0iiYGwPEu7w6ja0IPDMpvzpHOOBeXNFAhL88kYoP4nCPnQyCUcbuJPKcoj0mqtTp/xcFLaOArwjF4ZLuqCV9s=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:17:50 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8e) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 07:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 07:17:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 02:17:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 02:17:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 02:17:42 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the warning about the expression (int)size -
 len
Date: Thu, 25 Apr 2024 15:17:36 +0800
Message-ID: <20240425071736.907300-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3b420a-1912-4980-b1c7-08dc64f7d0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bx+O+83HHEU0tzjflntogvbK614suAdLz57xlZAOAwDHRYXQCuwFIla2SmI9?=
 =?us-ascii?Q?QtfAJrtQKlS+ITanmVgN85I1JwyA70zl/3gkBfp90dn19VH/4XGnPpN85nLq?=
 =?us-ascii?Q?YUZZKsrBWO7lDKeaDI3Qg5ICQyOHBFN+Tgi9i6MexXpyBL/p+EF5tBDS6qF2?=
 =?us-ascii?Q?Fwg6vVwAU+hFfT5uxIWZcCYSVt3QRga7Av/C3C/bBC5sQUXcEVqaSfYOgeyt?=
 =?us-ascii?Q?siEZHLVYx54TcwyfTD/Ihmhc9YPGAx/19mWsoMzngGC9us/Rl9i6xvn7EHbv?=
 =?us-ascii?Q?sesFpyresMEQJAANw0rIgILbvFicaXyrX5fEWyd/iLKCvkiYYWWSliMv/nw+?=
 =?us-ascii?Q?IhaBBoDRjcraoMQwZ2cctPua7V9V2jZPlzCTtmEEEReZdgraa4pBK+GAUA2f?=
 =?us-ascii?Q?/DX40vb0fQeRClgoecAujvHoFqVpCM1hdoawQdghUUSkzGYrHXuZABITQfHw?=
 =?us-ascii?Q?irHh1NajlJN1/ihWzcwExRs1PAMele9/RJWOsVh32TmyZDoKnYN8Hj2yg0a+?=
 =?us-ascii?Q?lmZRKXArg5hi+vrERVc7l/9lrqeBVkR1oQ6KBw8m/rXHNHabUyMa+Bpt3CFn?=
 =?us-ascii?Q?JX7T8pboHcIGopMOm4QBoKkAwPej8fP5l1y5d1H9wMhiePCTZquCWldIDz0m?=
 =?us-ascii?Q?F2KAUFpWzIdvji+lBT5XQUnUYiyWwew0eGgqz4YJQt3CufRHIfCoWtEZTH8I?=
 =?us-ascii?Q?JoXYo+B9H0klruLEi+NagSabnyj26s1ZMo4XOKN6mF5wXmTaxnAJ5aK2CZOF?=
 =?us-ascii?Q?UjnfvDi+xUeEKUG1EEg4eeWLainjbR3bga9TIV1uZh60YdH/XZgUmq6pOyZp?=
 =?us-ascii?Q?5GFOyHB/waKlImyKb9liMlQsTz6KSsKfVRi9hcBSzgxYeCRzdUHiqgnQX2An?=
 =?us-ascii?Q?H/myoC7bx9oVggOlL568V8lusP71zEsqkrjbGitC5I15XMRuSLGlPAF9qqyq?=
 =?us-ascii?Q?ZkOmVLorHpsyrOpcQDrXSKhshj0VC3P6EKHtAZ+2Lq/kEJZ8Rwby3e4ozgic?=
 =?us-ascii?Q?qK4cCt9wvcyP77s3x/GAHIsTtZfS9s+ilTXV+BK1/Y/pbqtzruT+Oox2HTas?=
 =?us-ascii?Q?NKsIA6XxbkZncOt4+ZRJuXDvN1WXoOxIW6sggX0oA0mEm+dOZNcv2K8wJ7SA?=
 =?us-ascii?Q?+7F3YV4c8mN2YqkGgnlC0kbfLUwlnFGxekXykNvgYJXBaqwB8KihXFQc2rG+?=
 =?us-ascii?Q?38ntG/F5IjZotLkX59TK2zxfc0QhXm5yV3MQqbu5CZ1Z88Ky3PSdb9e2I5Hl?=
 =?us-ascii?Q?7B1invehMInYabcJPEXWg2ELR3DQooSiBCESFBYxyXnF9Fc7kcnIjdaK7YXY?=
 =?us-ascii?Q?Z+pfWFcqsPqFX3PenplMHTc6GGQjtMuxJE0exlmPGtq51HsX/JTR6N4hHIcw?=
 =?us-ascii?Q?X4guzRv5FItFTdPDdeziviktHweN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:17:49.9609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3b420a-1912-4980-b1c7-08dc64f7d0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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

Converting size from size_t to int may overflow.
v2: keep reverse xmas tree order (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f5d0fa207a88..b62ae3c91a9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2065,12 +2065,13 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
 	uint32_t *new = NULL, *tmp = NULL;
-	int ret, i = 0, len = 0;
+	unsigned int len = 0;
+	int ret, i = 0;
 
 	do {
 		memset(reg_offset, 0, 11);
 		if (copy_from_user(reg_offset, buf + len,
-					min(10, ((int)size-len)))) {
+					min(10, (size-len)))) {
 			ret = -EFAULT;
 			goto error_free;
 		}
-- 
2.25.1

