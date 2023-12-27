Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCEC46CD4
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 04:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF0E10E03C;
	Wed, 27 Dec 2023 04:36:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985E110E03C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 04:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhY6uMpXCZ52ed/duDd6txcPPmiCQB5iPNY5oet3PM5zYol9iZkWOr0hRrGKcoenQB7r7zOnBrrNmkelY/6UY5YNxRxwZCkODUVZuZJ91I15YnqbiOgL2tE8bHwVQZbD4TEMYKPoA/N/63nMyrLRz4OzGHnwpRYsjs/c2NVHk8fKay9xmphkOt6fvzPuTUJDmkmlRPOK+kO7t4C2PCdnMexbD/A0IOwZ5vld817tAEEFh0JgoCzYGhGbzzp33HE+8LyLLWZJyc1Kkb+22cTHgoALg7Aj4WTsReW5fFn7o+2IpdY9E3X2X59LLGeD55vZeNFuDfiPNAmrLMKwwiOyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhXLUFzbyt6a8QWXp303F2Y47bVl+AAVYK7hDcB54/k=;
 b=NwVOB4moYSRuS4iOg0f890povncPwy8sktT4DUBJvYbJwKvN3um/TvQmR17G/tjJC9DTHBOhz0xmvOJWEGp+h5hxKt4XwlM1Wn7sHY9htJc8ex1GtomRTRZUmtSAMzrHzSE4AQgXiGxam8xJqM9Q0KkRg4GERTtCiPcHoEztV9Yl8Ef8YsaHyw0mhqf034Gg+tBBBSofnonviFJ1YBKu+9wyn9Nq3J5Y2bdlJLGbAJkzxe1LDZtKxrkLYCw2ytAPE3Z7xyugI16Xbt7cSSrnV1flA2AG9JQOLfTFJdpbcyrsCCbB0v+TRGDKqZYRvHz43CL+R6Z6CbY9LIgLUA73Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhXLUFzbyt6a8QWXp303F2Y47bVl+AAVYK7hDcB54/k=;
 b=MIj6MSvY3D1SwQEVxQCQJasALWRPMo+V5dt1X77Y7b9L84g5wA9neq0P1mvQRmYg7VQoOVuurjaEWtznPu8KqOVF8hpHqAxp3O6aew4jnogFBVmKNW/8GVhYmb6GVKNQZ4tZKLQavtNSXKTqTXgRV75v0CpcD4cKS13we2LTjYM=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Wed, 27 Dec
 2023 04:36:49 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::39) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Wed, 27 Dec 2023 04:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Wed, 27 Dec 2023 04:36:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 26 Dec 2023 22:36:47 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Date: Wed, 27 Dec 2023 10:06:34 +0530
Message-ID: <20231227043634.3413963-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: a559a073-2175-485d-ca4a-08dc06957123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8N1WOZVzxOVLz/ZxH4VZvaXe5hWZ6BwP5WMGnfIvVlrN9VaBqa8ai3vyUhG520M5+OeOZNcFtSoU7LJLR5hQSNFr8vhAvZ7qjUd6Jr+BZKdK4QHf24ugbj408mN1xZzxY9+QcHOCXz51UXG/g76kVtlzFS4yfJa/Kve88/J5958/PxUyYJ3oqIkUu448lsRa/gdAWkz4U56JHzW05HbbYdduqwVw50eWWr0ItGs+XucuCHieOkHmqTgLlH5rGwhCRkWNQVVR97uSTpnxFgGRT3XTHoa5G6PbBykULqaBlC2QdxcjbMeuZENruYYSHNrGX6Tf4yFK++dzwAV0drTm+udIKRzHsvCoej5MeN+81IuZI4Y0s4Vwly5i72QuewxFlb/wP/cqKRhdc0NuvZWlWYaaZ5AM5TBankYTSpoiTZMbLyTNvBB5D4Dzf0dH3K5n8QnbItKc7FGYGUkaDz/eZMQ91VeqKdQzoSffQUvsC7RJ+ty+4W5LXSWqW547cAyptkgiiIT+ZK54IqKGqwg1+uxia2WXPfUxfyyUkPn2XSIiNdHjW0KOEAFiwdf5YzU1VT4IkjQSEJlDaRE4jqT7amI2dpQQmQgeSj/M39pI0Bzsh9mZa6sdBytngg0OshIrcCFEUjVmktvIDk7SJgoE+sudM/cb733WfRHW0eV7v54471DP03gTTOS5glKVECXdQwRBwqSIAZktd5fdblvixe4rV+YzXcUg7Ba68jq88HgNc0BHltNBhdHDgb8vdJ8wYMA0aK4C0fZXAjE+sYp4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(356005)(110136005)(40480700001)(7696005)(36860700001)(426003)(336012)(70206006)(70586007)(6636002)(81166007)(316002)(2616005)(54906003)(82740400003)(1076003)(6666004)(478600001)(47076005)(86362001)(8936002)(40460700003)(8676002)(26005)(16526019)(4326008)(44832011)(2906002)(5660300002)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 04:36:49.7520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a559a073-2175-485d-ca4a-08dc06957123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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
Cc: Tao
 Zhou <tao.zhou1@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return invalid error code -EINVAL for invalid block id.

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1183 amdgpu_ras_query_error_status_helper() error: we previously assumed 'info' could be null (see line 1176)

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bad62141f708..9c4db031e5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1176,6 +1176,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
 
+	if (blk == AMDGPU_RAS_BLOCK_COUNT)
+		return -EINVAL;
+
 	if (error_query_mode == AMDGPU_RAS_INVALID_ERROR_QUERY)
 		return -EINVAL;
 
-- 
2.34.1

