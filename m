Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AB7C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC2C10F00A;
	Thu, 30 Mar 2023 19:49:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A14F10F006
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpxMLrTMV2dqQHLEUhFv9SXs7hVcKQ4vVw6fbyo3tREMvyz8XQqqeNXUk7Jq5OCklfhc1hPbVisbFFwooXxXmF/L67wyMUXp+zSkONAgvNj4zFZrmYNz8Fj8xbq7eaUSgYs/WgA2MnJScLBuMo+MTLvgr9wWQaoaaruzJODfV1t6N9JcqRh2a5U67kZ2p8CBMGi+OMQza1/CZ0MuacPqLVWLBWQkOrn4C0IZlkORt6us2Vk7/vk0LKS/YuBRc63wPqZcORPnK0iPSog8rSR3BXsbBmgiQPhHQxndiyh/SRvUzcz48exr7LxrXZ6uGfF0mW9vpC+HYeNkxyyWqDwDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbieOMohzRhALhtlVBzDaq12vY0DhV1n3/3CMKiO4yI=;
 b=SXi6CduM5j0DyUW6Na37JRd+ExxBJb8bksKkWHM8LNpuNhIViLB+Sd3HvzM7CeAIvm7+9C91HSfswzNmUN9GwO/XuKvo/DtkxfWRFSfOgdmdBL7MQvri7n7LPHg/8EWplRNFEtKK1qCU63zNGppZ034YnY1a/acslmsJH+GYqs/qtQG/NoMFrx4YtyOYebSl7fWANfcmxW8ugzoWwkQs9en7AZIlStVDAjCt9mDAxRM2guK6FoDaOG+Vq00P8MdaAdfwnEseYCIfDz5ZoePraAQjSdOpQnSetQW35ljXaX7RbgS/nVSS9Fk4BKeUZzqp3TnjT1vejhgn0u52ijbB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbieOMohzRhALhtlVBzDaq12vY0DhV1n3/3CMKiO4yI=;
 b=dAXVR9oo9AUqgVtnwpX99CO3shJmmgSw8INWtgg8bWBTAQ07a68pN5NAM7ZwY5zoihxQlIL/yYFsZMK4kgsxE5mt+iENnTpsSewwX6/2cQIYPuTRkTxTNjLl0vYkzujru1zKUytIqwz3RvlKvAc+t9i9xjoNuUYg9eBYGKBeQKI=
Received: from CY5PR15CA0152.namprd15.prod.outlook.com (2603:10b6:930:67::18)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:48:57 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::3) by CY5PR15CA0152.outlook.office365.com
 (2603:10b6:930:67::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: add num_xcps return
Date: Thu, 30 Mar 2023 15:48:37 -0400
Message-ID: <20230330194843.1136162-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd7cc7f-9e6d-45de-b1b5-08db3157ccec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JZAKlWXr2uAETsqlNRfb5Om7gGl6fKYTUm9tHpsvR3Vn78B0Da190mFRljC0kROuNycOgK1b5cLjXN5Q1Z/nwcMS5NLJxALD6q3GOIbVKKvU+rUVLcEmEN6Yi3uH/a9+jZ8JqaBIWL5UP//3llEvmV+yg5yZDl4efD61VYFKviAFZAW0GubVjjVnPj1+vK+IjI5qD1JHyCazSjkzDPDQatE5fWByfrFjojLkN5TmSLWE2xOEqIZ4ACb7OV2Sz3YfOlXR3f9lM1KXC/egWyuAfHnf6ncp6kc2P72teba6ug2GvOY3j7d2M1mjdBAoa3vuiWwN1ZUaRKI2mhgztWQbCN8vlk5yiiVszWP8AZHrkEDyoCc05FyqvTbH0jjC6/Vyz1ZbuhECQQiLgIVgD332s7809P3+BpVkfN7rofd9GPQMl4LvEP/z6HSO2QeXhG1QfoPM4mAc0H1la1b80kvPLL4kA22DKLBrkAnVshCqbif06WZ3d0/HTKC36+7PQjmvf68sOxGBQ1yGNZy+u5HSoxinpIt2SnDUTR3hY8YFnNzwNUkZMP36KlFrIRRg96m5DqmJ1+Kd0T7TLeQTLjnPS1tvi7mvMNSnwjvz2L7KSQHB22s0g5jCGsdrtQPaDvv9gt2rJua6q+jFDg+k0uuUwW7XafvKmorHNkE1PvlCwBNqvgL6pWW4T9z18FXkBqJrHG5gVN8XfjgWoRsojACWGT/vlJXqoMJmmRp/iACUOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(336012)(2906002)(426003)(7696005)(4744005)(5660300002)(36756003)(8936002)(2616005)(82740400003)(81166007)(47076005)(41300700001)(356005)(4326008)(8676002)(478600001)(186003)(70206006)(82310400005)(70586007)(6666004)(40480700001)(36860700001)(86362001)(16526019)(6916009)(26005)(1076003)(40460700003)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:57.1943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd7cc7f-9e6d-45de-b1b5-08db3157ccec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add num_xcps return.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 0d7bc212def1..6591d39c6518 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -318,6 +318,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
 
 	ret = __aqua_vanjaram_post_partition_switch(xcp_mgr, flags);
+
+	*num_xcps = num_xcc / num_xcc_per_xcp;
 unlock:
 	if (flags & AMDGPU_XCP_OPS_KFD)
 		amdgpu_amdkfd_unlock_kfd(adev);
-- 
2.39.2

