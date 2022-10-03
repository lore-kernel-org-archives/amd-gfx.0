Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B77C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 18:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F79310E453;
	Mon,  3 Oct 2022 18:02:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C5F10E453
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 18:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y31CJeHQpFW+zpY8gOTnLBOU2GQI9ZPjsJw+f32/keHi+0rHZ027SRRT/D9ymILTymzdzgjMCgzYvBuzFi+XaSRF4LjFVI9/xSxgkdJjq+u6j42KE1xaDYGKP/fLZxGXdooFwveMxz0KdXrnLZGjNkehMwPkE/ZWwfVQBCiLT+xVP64+fZgP+J9kLqI/sgRJIK7FKLOZ7Fog0klFBBC1CpkYwdsQTcpCzy8tOXVJenrfTYrOVcmAOqnjW6xzsEVMsBwkITopTJ1BiGPxBDq58o/ZinkIG7p3UxgY3UbXe1woX+zLH11zqRmo9iE3ps2w/USbLYwcCGyEjHjsBQt84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZugQJNHoYGcZypa7HpX5ZuAP4OI/+H2lTQP6xW9Go8=;
 b=SK38rlXBKkATBRCi9vnpM9925nvnioUD1+mKvQsUdOWA68R6yfX9AszrxhjMqAslK52vnobCflku9OLMA/OFr3iYnZ+C2451I/OfFzWhEVS8/zjMZzGb2dHFHElTgtbDUQeLKo4HRohFmga3V+XCSySJfawdJdF3F5qOBVUgzA7Qqblji+DuwYPkBfOD9u5tTon2Hp6l0O9liU0fiSQuyNtYqTOzb7MaBvSsBd3fvm8lWpN8FSvJrwSxh6RO/QwTqnKetN8qbtikH+SfIVu/wXA56bvQdb8eNcJPym9hsqAB1y14uqFu0V6dkH9OJrG+Z7IoDICynQTb6ecee8I+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZugQJNHoYGcZypa7HpX5ZuAP4OI/+H2lTQP6xW9Go8=;
 b=BYcbwVnvj3y9zXpKZ1Xx21Kc3AOmoHgK1/M3wMP52RariCsX0HspDx35Xw62hTVIUbH5m6/ETNiS+cTUcikRSjCkelprY9jJ3MxTmd2KMESg0ehJ8eyKPHmc4V3Mh1TtobOGm3sSuFFaBq/yZqG3G05j8jkqFCEQHNROvHkCp8w=
Received: from MW4PR03CA0359.namprd03.prod.outlook.com (2603:10b6:303:dc::34)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Mon, 3 Oct
 2022 18:01:55 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::54) by MW4PR03CA0359.outlook.office365.com
 (2603:10b6:303:dc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Mon, 3 Oct 2022 18:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 18:01:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 13:01:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 11:01:10 -0700
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 3 Oct 2022 13:01:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <harry.wentland@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Enable dpia support for dcn314
Date: Mon, 3 Oct 2022 14:00:48 -0400
Message-ID: <20221003180048.26686-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: d52a1493-d6e6-437b-b61f-08daa5695ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Qy3aofFe9p69zLOVc9e/vC1HU/05HEAysrZomoWGGOwaNzEXHqkQlqPyZG2Db7yayS+JoYS3vs3r0uv6E0VeNBjGfqfL8kVMLaQoqxL/wakcJaNd1Hv+r5Npdrp8sy8ND51k2swcNBoDSoPOjbK3/8frtK9trgMlNHAOQdVkeOwBxJSqoxkYvviJksc7WXr9Jpnw00kKjUCs+ZQa4tnHx7tIXhXTWzh7K2SOxpCIt+g8UL53tTKV29NxMFqvZ9h9b5Vo/5z1jYq18XySMwA+/FNnSEVOAgsnw9G6ulFpRZCiDczp2eVq8FIo4cc8uUl/M0lbbIp9nFG5e7Jj7lZiSfS7wzzJhxzLX/7OSZZFhJgLjlJAm9Eb58zjuxCLjNnuvKqYAEjxfgDMYbDcAqSWX8qfOh6oMr1F7Ja2/pIrFZXStKWTE27Uqjz07+5rtmgTDnjAD4zAAst/8/hir0qq8W5vFfiW8et96ETsolpeT5NqUMoto/d9JdarRW9Ehs0W694i5L8UsW5ao3NSh89UfGheMcpe4AhxFIzD3CqhzqF1YT5v8K5LrhcwV0sNaoXON2IQuCaPvLxX6K+wJUu1dTm+raz5EQTKyL+tOqtZhIlDnecf8qoVTqERakfCbBaGJHKJFYPI6wjS9VUTyFDjr+YaT6MtprdarYLaHUCP46JokyC+aT/xCkrogUO+ytOv0zvILHqa/QOfN/mL7bRiIoSEcnI52rF66mahqAc6cbLtW8bxw9tvoatTYjMlpguVg77rSJkaXPWkkMOTpSUChkr+CELkq6yIl2QIbZI9x9eq6uePW6Ws+PsvidUEa5IwxL+qabMeSU+2lMYlTVF8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(186003)(7696005)(110136005)(26005)(1076003)(86362001)(6636002)(2876002)(36860700001)(8936002)(426003)(316002)(2616005)(2906002)(336012)(82740400003)(47076005)(83380400001)(36756003)(41300700001)(70586007)(8676002)(4326008)(40480700001)(70206006)(81166007)(478600001)(40460700003)(82310400005)(6666004)(5660300002)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 18:01:54.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52a1493-d6e6-437b-b61f-08daa5695ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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
Cc: Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
DCN 3.1.4 supports DPIA.

[How]
 - Set dpia_supported flag for dcn314 in dmub_hw_init()
 - Remove comment that becomes irrelevant after this change.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ece2003a74cc..8471c21496c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1105,7 +1105,8 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		hw_params.fb[i] = &fb_info->fb[i];
 
 	switch (adev->ip_versions[DCE_HWIP][0]) {
-	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
+	case IP_VERSION(3, 1, 3):
+	case IP_VERSION(3, 1, 4):
 		hw_params.dpia_supported = true;
 		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
 		break;
-- 
2.17.1

