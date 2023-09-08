Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197AEEE7FF2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 13:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D89610E8A9;
	Fri,  8 Sep 2023 13:17:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF8E10E8A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 13:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h67lOU0xXs2aecONMXGy8tIU7h03PkQeKRhSHJokeevLzsS8nJzkGp4wPArUnlBHhGaJqdEYgPjuQpHlev8GvRKPIf5D5OD1AJyOHS3DwxgLdU8Bx2EeYrfXSVh4uTwNkRxL8Ene9mTqb2si53cdQQdDLELtCfWbfPtD9y2fzPfKEzSCtJSMtDsmQqVTOJApUlKRySFp8rLN4clvpuNOeLMyiZ3pGL8FVeWQSEnLO32mO4HblnWB3n2+HN5e6RFyAgMXhGh+bvEwvtQyY/1hqtc2wCjlmcysbPWQ0HBscIFHfe6z0W2RwwDs61oL53jAmbAyZ8AFy1534hI1LuEKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1jkEdbJJdOHQiDAWdNUEsSBLsigXdP2iMOrvws7V7s=;
 b=IkaG2LQT2+w8YZIv4ZB7eX+STexdZ8Un4CSs6AizuWPzEOkgfmxq3rXui8hL7b4DJfXorjmagkDvIiy/rzmZV8JJfycCzVf0aXnlrFNm6aZ6G6Pn/bQLjnZWuFjavijqwau0BE8XPIgtNSRmVMolbjvWkhB4YSiO4pLmLASiuPB6vk2mtX2356HoSOBSRWa2Z/aMDxtQJ4rpD/CzcMVZynoii3DrsGGIynIJwfqXfeulk5zAFwwaaGBxNtMlVefJTYKCMTnQvQQ3zNLQeKsoVc/OkYwYl5NNAsbCzNkUlVNDQ8kO3fPskQnbGbu0xYOSWcDszRrYYqKuNODuHQsJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1jkEdbJJdOHQiDAWdNUEsSBLsigXdP2iMOrvws7V7s=;
 b=ImM+cj7kK5Ke14tGxAZ2yewvZO0bBcWzyng7n0MuZYEFfcNdMVhOLbQwb/SpduIhNXinH1Cksh+pKUXgm8wJqjWWUrFPIrnZK3Ho9+AfEkYXBvwDHoAtXVXlO/GTxZd6fP8nehX/8Od7IwaoTO/K24DqHQsbKLdVI7v1U1VJy0M=
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:17:40 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::b0) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 13:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 13:17:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 08:17:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 08:17:35 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Fri, 8 Sep 2023 08:17:35 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: fallback to old RAS error message for
 aqua_vanjaram
Date: Fri, 8 Sep 2023 21:17:28 +0800
Message-ID: <20230908131728.9401-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dead6a3-dc32-44e7-5f9d-08dbb06dfa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu+GaB7IiAX6RpkpNlatLyZ8gzcbqN3lK6FaGmnFCNuVVCG83s3bUWZVtDIweKx3DpHNlU73+vyFknQdjcLnVpA82QnRAHOHB/rOZu774l8Q2nh78FT5FxJktE2aHI1pfjXQwlPzMXGuYqh+74NdUWtZ62150lc2hRJ8bTc0u7G2bSZxCi53vEcaEaLCyHK2+0cTBrVYI0PWYz5kO4kt+JJlJ9RuWBZX5yPKO6i9LbLzW4reHK1ONWbR7znthqkuAbz1Xu2iGJSidhBmLwQlMyOfSmCmoKvrUHmJrceZeo2+mE6AXvTPwGn4c3USSNqCHjuprM6LBUic6ofr1bY2I5MY1S6ZXlrCDm7lh5YIsQhOTlTmlVAhnfJLzMBbObE34IjTPNnAIZEobqc31BqTYzbr8fANhqUXJvYK2gE5/Qn+uVlg5Gkx3G7aTCimstMW6PDFWeJnWXugMZfoT5VSJ7VOrC0QtqE5tFZjnosTxe3v/1wGw6lRZZByLZqO3tBfQUttm2UYKgFQHtbfwOqVFRkeTULJ42HCTJd9ddZkZJ/ymAS6Lou2RIbmO25SC15EFR3/z0oE8E/tBns9CwYsty6S2wrplg/2izrWhuvCb9iqQCaDSEgfuXVLbHANheSYk5kDa/MoGZD3WXVi0vvHZnjXz9bHdq5fDGoXIiKATY8uSALlIaNLABiEW75wgFMZtpkxiOkdpRam3mORMYqIjngADyHeQ2E0kD9YdA0jovQnnaHs9g0bRtIn7BZ+tQbWbsAppsF+JQnW4/YoJKjvDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(40480700001)(15650500001)(8676002)(36860700001)(40460700003)(86362001)(110136005)(70586007)(70206006)(478600001)(36756003)(8936002)(47076005)(356005)(4744005)(4326008)(81166007)(82740400003)(316002)(6636002)(2906002)(5660300002)(41300700001)(6666004)(7696005)(1076003)(336012)(426003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:17:39.9181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dead6a3-dc32-44e7-5f9d-08dbb06dfa47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So driver doesn't generate incorrect message until
the new format is settled down for aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8eb6f6943778..dee7b5b705e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1053,7 +1053,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	info->ce_count = obj->err_data.ce_count;
 
 	if (err_data.ce_count) {
-		if (adev->smuio.funcs &&
+		if (!adev->aid_mask &&
+		    adev->smuio.funcs &&
 		    adev->smuio.funcs->get_socket_id &&
 		    adev->smuio.funcs->get_die_id) {
 			dev_info(adev->dev, "socket: %d, die: %d "
-- 
2.17.1

