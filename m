Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D5FC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 10:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9766910E38C;
	Wed,  7 Dec 2022 10:04:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FA410E386
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 10:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4b9RueUbPHZCrCA5fTX9DmaOYvbgot4+XRE06q6dcHXGj/Xu/rSBLFafuDvkgYMoNulfdvwhfszJYw670mSQpAhHcPpP8Yce+Svd6MZdR5XhGZi2TmU2eF8SmW3OBTfPvJqXMWuozqYAph22pN7sBBA+4VWoXn/zGdPIqLnaoF+loiX1RV+mohbvDnXe0vwWReil7zGUB68PICO1S30b23PZNA3lHhjLEQS8Lp0USufvF/LV4vy87IhyaTYzGvlX2ALbXUO8X/8X8UiFY5805geAb7WxWgXrzFEy1VdaObOpXLSSHeLkSyic0dJiNsqv7dLjL3aZp1+nHhDeGjUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXuUBTggYMgAOpofJXm+uta3ug/fn0FQk+zz7mprcbA=;
 b=NANmcA+3FDhSSboS80g/TbfiIAinNS7vl0cGavTGTJZm92+HtlvopW7cZTJ4Ef3gq3f/tbMrYIV+YKzgpo33lA64SKfbawWeMbyY8GKZnxiZwooW7lht4Lvyiky8SCOgE57ypu5b10glizJrYUa9aiTkgnOtiWJlhwSgQGORGVBboqj+LlOJPwEGCo3Fy9ZXQ5NG6uGj/JFlt8nb8CcPOmzdNVLw1hWAvhI0+uWsg8WVE75wKsQAw7KicFvTKz+HSCL16uzn3sRaY60p0wC81tlUKeze+y45ai+Pi7ATF7n/XqPksqrWDYg4EJtcTThimaSaNNx+QkcBBOr+bzcRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXuUBTggYMgAOpofJXm+uta3ug/fn0FQk+zz7mprcbA=;
 b=sPUfqhMq9nJvTD77Q3arfDDa461PbGQ2ACjHp7WQEEaHH3jko52DvbkRdREGaqObA3SNoXlPIwKYwvkyc+EKWG0iAQ3D7Oa0eHxoDxl9wyGMHhXwViqd+ul8n6tKZEr+4hw6MUBA1lJ1rgnt+3CNfJvStORLvnpS1kL6q9EA6lQ=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:04:00 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::52) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 10:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 10:04:00 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 04:03:57 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: skip RAS error injection in SRIOV
Date: Wed, 7 Dec 2022 18:03:39 +0800
Message-ID: <20221207100341.15356-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207100341.15356-1-tao.zhou1@amd.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce1b0c6-309f-4563-fa78-08dad83a5cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCS8IUGOofvVguNwyZUAtvdwq/4xxajzD1GN2Z5Lf2SKT5bzrJdk97JkE/9ni1WFkLLi+Al14GrU4n70K0k/i8pbVFc3t+T46h0a4LY0vGen5fuIOQxDjgHXnA7XQdEwjutwkVPbf51z0M22kEKSltCTYorsSbC7HpOgn4agbMjxZU1+MmTgyH2euiCzDUwSiMzKp6NhydoFW307E6ea9LuaKf6Lf+ENR6CbdhlDOwrG+gf54swP6Fv7zdNu+D/UYRxygdMmV6MipnWS2wHgtOqRGqaLQlVP6zFvH0KK8KWMSY8j1s4v9vfa9oeptjB9oMPmO/MZ4uXaY2QZv/m3bwuu+Q387/LT1G800KQQ/lOcAfW53s5R+NRm6/SjHMWbYO4G1V+QoME+OXPhG/GRnVMD1qfvghIMGNe8n4+8L/7DZ8wT+bQr6Pwb/dp2fJJjK6zAo0JrLeZJiaJbNAz5Z8u4uOpscHzlZA08vsgU4pN0lNP7IMfjkYdXSMnoShgimoIgrZTeQIBS8CeJH1YFj4r+FDGYPCToxBDR6l+xIOkH8BulpHwrNRxhddkL7J8O4/b+KEaV7bXKOWV/KgJlZe4+NmglFerVdtmxiWqBxbyg0rcZIuysqDWVJqx4i/pV+QihUSEqn50hPQCNfToP6MZfBsx8yA1KSmXZGWwvrCQpg+yrRgpCKe6A1RyrvKTIqkzkwygRTbt8b+fYiPm3rhygvRjIjna2DmKUXUw+TCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(478600001)(40480700001)(70586007)(70206006)(4326008)(8676002)(356005)(6666004)(81166007)(82740400003)(186003)(2906002)(336012)(16526019)(26005)(86362001)(110136005)(83380400001)(7696005)(8936002)(47076005)(5660300002)(426003)(36756003)(2616005)(6636002)(316002)(41300700001)(1076003)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:04:00.1343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1b0c6-309f-4563-fa78-08dad83a5cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And return successful status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ad490c1e2f57..854cff9e7ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1103,15 +1103,24 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							  block_info.address);
 	}
 
-	if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
-		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, info);
+	if (amdgpu_sriov_vf(adev)) {
+		dev_info(adev->dev, "RAS injection is skipped in SRIOV\n");
+		ret = 0;
 	} else {
-		/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
-		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
-		else  /*If not defined .ras_error_inject, use default ras_error_inject*/
-			ret = psp_ras_trigger_error(&adev->psp, &block_info);
+		if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
+			if (block_obj->hw_ops->ras_error_inject)
+				ret = block_obj->hw_ops->ras_error_inject(adev, info);
+		} else {
+			/* If defined special ras_error_inject(e.g: xgmi),
+			 * implement special ras_error_inject
+			 */
+			if (block_obj->hw_ops->ras_error_inject)
+				ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
+			else   /* If not defined .ras_error_inject, use default
+				* ras_error_inject
+				*/
+				ret = psp_ras_trigger_error(&adev->psp, &block_info);
+		}
 	}
 
 	if (ret)
-- 
2.35.1

