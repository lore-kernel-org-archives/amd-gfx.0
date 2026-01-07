Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9D4CFD65C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD97C10E637;
	Wed,  7 Jan 2026 15:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TgFzIxc1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460E210E62A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhlUFBq4MRMc+52N7YKm4SPjmiOV8YUWXQ8LYG6IVm9KiY9MrV3E7nNC5VhnyfjX5y7cjFJvvreoXHrvccPOPBpLJiCzVfbSmDKpNvM2UIH2p9pCKHWSiKskPIBx50G+NpNjd/BTlgB6QtfnSu+CGeFMolZcu3noNFsLmW7YycVZ7gE/otOXs0K3TKlP5dJm+8UeqrBGNweFA/NksXNBIYh+l8p4yUdMVHBOy/6rOzrFeZKdwh9lZtT+g3fnqW7z6V7QSumNmAmMpq1C55ofi0+teth51PslhnLRurqrPuxqGZeLRAsnRi40qx89UdbVSuzeJdxvh83P3X5XRk5Y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbaI6ZZfPwBK8Py2B0op3uMISbGxjT+oi+pUFD7hTdE=;
 b=sMIaVCw07YC08TLiHRmHYTm21BuZCvzlIq9VS+56gNYJ0gO15seNROpPndS1NG5PJ7jz5FabBcvZzR8OxOdeRYLoC1m/SeBAoIazSeEd7tY7k3f3gAMZSaEAtFzlqQap4v5q29rt5QkEU9hJXUIy5kSJmZWN62mFOvTYSZbowBHX2lJhnljCgDL2aSFInhzhuqyFW6Sp5SrPhAZA4wosLh2KhnZuDsXtiAYYdiOcAv5QwWJUD3gR72lD7RYoe3VRvzTODD4MamDpju5gjISzkmzGNCqifuPs/+zR/qK6/t4ppmnIKw686A7+orWpop/554hcl8U4x3WDuXTuVuCR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbaI6ZZfPwBK8Py2B0op3uMISbGxjT+oi+pUFD7hTdE=;
 b=TgFzIxc12zHKOtS3UW1EsVpD+gVSE3gkHzr1qPBMMdc0UhD64IUDwTS0c2fqPKq2yU89jxdrD95OikwiOir4bHsJHbevY9dBRTPGZeSW7RMvuvsEUARWsdgzcN0jiC2lHCcJBAGdGjYwBI/z+C4tJKLGedKP80WxUn2s6O0bIso=
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:57:57 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9b) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:57:55 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:55 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Matthew
 Stewart" <matthew.stewart2@amd.com>
Subject: [PATCH 04/21] drm/amd/display: Show link name in PSR status message
Date: Wed, 7 Jan 2026 10:47:56 -0500
Message-ID: <20260107155421.1999951-5-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 270f27be-665a-4dc1-46ac-08de4e0586b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGM0wz7ALZfbH8To22ZOA4veMADuEU0umWSvsPeaCsGLWOBqy7PnEngE+/pP?=
 =?us-ascii?Q?vRfZVbN6g3FIudGAChrW5AAvGKCAUnOpdzQMXTEv8yyejnV5zO50RM5QbTuA?=
 =?us-ascii?Q?fpXUYYmmLJtGciPXybzhbSNb5Zc6R+9c4aY92PfP8QlrOeL454rLV42Vvbso?=
 =?us-ascii?Q?/zapxxSUuh8lVlWD9m7HnJbpFyHPiqPCc3uVCcVDhjC1RSyMZg7BO0pI2MrK?=
 =?us-ascii?Q?oOEs3zX7KWnXzEnZExpU+AlKi2MjigDOY1jN3foKo75rwg0brURpKwyPZpht?=
 =?us-ascii?Q?fFGWjAGML5TSRPg2bvaSVWQ6gRhNbZWBSMRN5AQZkILg7MSPmKVSUANK0Etq?=
 =?us-ascii?Q?QHvBurtU50AT2UwIp2swFuBh1QaqfulwnGU7CRxxftSixZ5SjXOPDav4w9aQ?=
 =?us-ascii?Q?XE/3Nk6PXhzlymdlYwKao0n4MFAAo+KtmyEpkjZxf5NBrXwicr2Ai+W8imKi?=
 =?us-ascii?Q?IEmiUEohzeZoIBPLq5wrdzLB7F3A/C4gzyqL50gqNTcXFLZOyHFVNDwScAL9?=
 =?us-ascii?Q?9pi4vtUUJbtRKb0UxgDm8C1xws0/wOqj0KJhgk5YYV3SeOfmilSKHU6zuULf?=
 =?us-ascii?Q?o5LnQ9JecKUeDA0sYd9Z+yp2OeO94XtO2RdkU8gdQJxaSUBw0+fJIOERc8dS?=
 =?us-ascii?Q?zMgADnxOCoWGeNp74GyokbGw+vKMqZlsyXZIBHU0jAux4tk/y7/+vSq1ytiW?=
 =?us-ascii?Q?b1l4b6C8+mtjpYavkrZDxZQg/8islWQDciZwdWvRSxe80WN5PwQZM4pDyWUv?=
 =?us-ascii?Q?L0A+sgq2mOHdiuDVEU8e4c6ZBVuzR5pRTD4RM0nPTw0M92OzUnCJL/GbuHRh?=
 =?us-ascii?Q?H9nNYCw7AGD4tayApSr5Y3zqXfLm5osU8W7+F3VVDhkWTRX++cITpZyDUbY+?=
 =?us-ascii?Q?K+9K9BbapKwjzXOqPRl7szUbfokQGNBIUyyeb3BRQfm8a8pV3fyPQsjbKieT?=
 =?us-ascii?Q?Lowz2ABSF8Uan1iAnG5U1ubgC7bbm+QJ0EmOy9GGSgRUlp8Rn6geHOdMvW8z?=
 =?us-ascii?Q?iLsLhhYCazd6og4p4DF+/GyITJe6HAtpUW+9T//SZM5hbVHVQwehJkOPp7RI?=
 =?us-ascii?Q?KUwHD21xzuAKc/SsFaoXy6ECC8JoecQEPziNlP6wOS8xJzkVdb1aOS3J6xFA?=
 =?us-ascii?Q?4a/dfdT95G7FI3BhMirhuBugDX9BPx2edfPD8u0GBg0B1MCuzJ0SSiPTXAu8?=
 =?us-ascii?Q?iK0DcPtFrwzCEwaFFbpqeJwOxtv4u99irt+j57Y5YaN+AlaL8Y2DknTnJjMd?=
 =?us-ascii?Q?x1KuZT3ugaqmdssCpgpQ/yTH57K63hHA8TrcZpXIrem/H1pFgFSXuJHEPbHB?=
 =?us-ascii?Q?FVD+yjm6aWnyHTRvbAQRJDPSGYkrvqeN9qrirGVHMMWQPkBc9pIOQl261gA0?=
 =?us-ascii?Q?atYusqIX/YodeO8onXuKox+FfxshfLVYYVcTC/8AloFf01TAsgKidGvwsxNy?=
 =?us-ascii?Q?lAsM3fxMztef9Z2yRzsCZ82JcJVy6yiGq78I8SqqzLCSqgX0evzcv+cEPsmv?=
 =?us-ascii?Q?QpKhYERd9q+dfEUDLYpsvEJnsNFE83d0Rmbe6S6BKEb7uVWgWvu4xvMUK3lg?=
 =?us-ascii?Q?aoCShiucRda5vCmNRPE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:57.3656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270f27be-665a-4dc1-46ac-08de4e0586b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[Why]
The PSR message was moved in commit 4321742c394e ("drm/amd/display:
Move PSR support message into amdgpu_dm"). This message however shows
for every single link without showing which link is which.  This can
send a confusing message to the user.

[How]
Add link name into the message.

Fixes: 4321742c394e ("drm/amd/display: Move PSR support message into amdgpu_dm")

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 354e359c4507..2963c75ca18a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5618,7 +5618,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 				if (psr_feature_enabled) {
 					amdgpu_dm_set_psr_caps(link);
-					drm_info(adev_to_drm(adev), "PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
+					drm_info(adev_to_drm(adev), "%s: PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
+						 aconnector->base.name,
 						 link->psr_settings.psr_feature_enabled,
 						 link->psr_settings.psr_version,
 						 link->dpcd_caps.psr_info.psr_version,
-- 
2.52.0

