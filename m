Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65FC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 15:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8931710E299;
	Mon,  6 Mar 2023 15:54:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ECA10E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 15:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4HCe7tJoGg4GP4TGBpXMK0wK/DUJlI3TUbBwKP5Vqn+CYNy3/mNM0q975G0FwNktXzqjCpkHGAq0N8UdGV9FnkG4HOtmtbxyZX3OEwnIdGPcCdwwEH2gesfuYLnsV6EoDZXP7YWAVVDW2qvO+YNxKhSDI6/BmZlGC3JBKGwouH6k5Id+uQX8ymdfYRNS1tfXvjYHaoU4botGbK9PJ41fWKlOZ3FiHDSKycPAdw20jhlpGpgu2cX6wqmsvJSZr5O81ytdXEft9M3LLFmAtwsTSTrFg03etAw7/M2Vkz8HEXyoK/3XkGrnQLf7UZyz3V/ajEs79x2cWjfoRYGwqv4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E3gbRZDFiC4wYWY0hjzX3NxNO3g8YQIhJ4HffmXpqc=;
 b=PTBqqCFIUERTT7KmvxkgyNdpjgIHRnFO0kcvHOLierk78ElN+IieMiSfU4upMDu9eDBHhKEoRpUAXS6N5auQbB7TM0Zl0GyPNVS9jdI3szrqNtRAxhR8XS4Z3XEd73lNsLmqRyD2vVa9t5zo9GZ7zPJnzKtMirsO4PanohVjtyVoWK7sZSRfMt82z2QajuNkzpzzpK6wtK2s1FwEnIhjwuqWvRrWFc4AOZ800ysS6QqcSoLTBWcYVZh6XX1wQI2fMSbw3gvuDGygJN1wR5Sj4biucS0h7mF73VimvE46e0C+bVmJdhbh1aTHnd02yhe/25xeo4zX+hEEam4rGHPuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E3gbRZDFiC4wYWY0hjzX3NxNO3g8YQIhJ4HffmXpqc=;
 b=1CM9YTAGXttURuCqa+UNiB+ZViWMtMVVFQ9FGmkvBW9wahAoTAkGLrBZjn8JDsHkoRycnvoVu+TOwSVHK7XhbJ+PquOMYl9Xixcn/EYm/A+itWMZcPUzb/it1ZnqeBVgIYA7NgGXEgc2/6M2YbYFHYFSq3CtoJNIBXkTp6/H+TQ=
Received: from CY5P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::11) by
 CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Mon, 6 Mar 2023 15:54:04 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:4:cafe::1) by CY5P221CA0040.outlook.office365.com
 (2603:10b6:930:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 15:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Mon, 6 Mar 2023 15:54:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 09:54:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for soc21
Date: Mon, 6 Mar 2023 10:53:48 -0500
Message-ID: <20230306155348.41081-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306155348.41081-1-alexander.deucher@amd.com>
References: <20230306155348.41081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: d437c435-b3cf-4322-11ef-08db1e5b0313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4m2x66XQ/IiOTf5OBktHGEFXijIsXMtMxVQr+xT8y7scldU6oRaQdIaERs6wIkbyfS6Nixul+dfwfDH7rHuJ/78IV7Ifp4USbSlldMgAIBqyHuUYzcOHVbdr8KQpdgw9o7dTkYrek9D50Eh/2ejpTG4d8SPrh5rhyQmW91QfqbRLg/og4o+WdR7YpzEqVp+Q2pQvk0taB9qHbPYbUgOxm/XKZPKGqTzEgP2ik4e/Q+wig962Tf6INe81hUX9413IXPn1OzU8JXz7zh46A8D/UyhtaLlJbhoQGor3Vjy62Q9UrZbq0L7Pfm+13aFppBaPPnYbrCVNRt4xZ+zLlJG8XjgaxWgbNPP+srSLIZOMgW8pU7bGxcdleghJYG70skt8C245DG981OZOx9W7kpVEf9uJ2fIxTPLS8Wj4BaMjz46wl9UNOQ5GtbJmZA8Y3UoPDKXanQH14HfHw6RQLG8+9djTofms70F/MAvnfK0Vre9a1tA8nUBJiY774kOgBizy5NMd9UfVFVklVOwVXy95iV3gfI9AaCY7mgDrUFM7hTMCjDioy2/KgP3epOiqjzp/i7LO4TW8DdLlhfekC8FIUFrRiuC02CES3OhtYGiOPLPhTfvYFkGNyqNVqmZgS1oSBV1LxOkvWcyboWAulpO5htOQoQZ5gstHui1PKmgSs24286zf1yRUyxUoXX8G7aD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(84040400005)(451199018)(46966006)(40470700004)(36840700001)(1076003)(966005)(6666004)(36860700001)(36756003)(426003)(47076005)(82310400005)(356005)(40460700003)(83380400001)(40480700001)(81166007)(86362001)(82740400003)(16526019)(336012)(186003)(2616005)(26005)(41300700001)(70206006)(70586007)(8676002)(4326008)(6916009)(2906002)(8936002)(5660300002)(478600001)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 15:54:04.4402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d437c435-b3cf-4322-11ef-08db1e5b0313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly skip non-existent registers as well.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2442
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 620f7409825d..9df2236007ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -291,9 +291,10 @@ static int soc21_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
 		en = &soc21_allowed_read_registers[i];
-		if (adev->reg_offset[en->hwip][en->inst] &&
-		    reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
-				   + en->reg_offset))
+		if (!adev->reg_offset[en->hwip][en->inst])
+			continue;
+		else if (reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+					+ en->reg_offset))
 			continue;
 
 		*value = soc21_get_register_value(adev,
-- 
2.39.2

