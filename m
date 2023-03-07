Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4276BC678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 14:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1AB110E498;
	Tue,  7 Mar 2023 14:02:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8DF10E498
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 14:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO/NTLzk9bfTrjkMZpvLSKj6HB6FiipgStQT+pJn3+8DXHoT0E+13HlkE/GNJcamUQ8yI3feV5aJtriUEABUklv9Tke58Y6NFCkBMXLlflgjd+GnW1fWieMyWd7cc6hzv3yYEPHExLV0gy/xKKUr5M3azRg2YCZYMTaKT4Cx+jfcaxyBsbpEmPTkety++0a9cb3PMcDDRzPAukIUVyD+r3FlY5fkRpICCb+NxykAXWzClFa/Rtx0zQ9w0LUHVwRtODR07dI/tkoi2mSgvAOp4HBMSpL7ScR5uhbOzadDTBBKSE5MvAqbIbaG+iWNNKbQ0fnMH112B9AEyPVNST4s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7KZT0p+AbCkULHHdSdm9sNbKZAgXR/zGQKu+3OC/D4=;
 b=D5kyxOjxGHGNh7/qeW2eu1ADsOoeBdVJTwv0r1n5TbFSq2VLMMmAGjjezxR7TbA9QXC5qUtCa/ZwnzX+WtukHrNlBQU6x/PwN28JjRpwTBItk42GZtb1Q6qh/3wZajF1YCqQ5V/EGO9uAtbICEXKG7GBKt5jBnife706+ByC35nH0nXtiLOBPbAHVuMYc20GcGclJh1K7UIJTEIDzE0XkIrKC3XUB6RJuCccehEsiwxtBEhf9XSc8NqoAG/hDtsHstWrZOKpOGdS9HzUiDR400bwZS7Z/W8smng/+5ZuB/Hk4vps8exfDOaMOHbkrOmc1a+CsZjzEOBNcqL/6in8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7KZT0p+AbCkULHHdSdm9sNbKZAgXR/zGQKu+3OC/D4=;
 b=4LXbQeVQt/2ZwZEiBsvVyKjko9mUn3QiX5HBd6d+4YhhZykR73dw46GE4ttf5FqgTli7J2btpkuAMG+2GpAK2/auR0f1FDZ9noYzRN5apGIwMFaTRU0kTfY+5giJExFs6cks7mWVBFJLyLtZTkFvCMaR9zbHub6TLGOuAzsD2iQ=
Received: from BN9PR03CA0600.namprd03.prod.outlook.com (2603:10b6:408:10d::35)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 14:02:11 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::a4) by BN9PR03CA0600.outlook.office365.com
 (2603:10b6:408:10d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 14:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 14:02:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 08:02:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix error checking in amdgpu_read_mm_registers
 for nv
Date: Tue, 7 Mar 2023 09:01:57 -0500
Message-ID: <20230307140157.912755-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8c1f7e-0ee7-4d1f-b7b3-08db1f148c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFp/BJcVtgK/LCfHAOCme2PrHOBMVHWMBWsxE1MYfpGz4Rai5RVqvhKWjUaNmWE3mgz7uw2/rnR2sZfJTh9Cbfv6S64zVAK9QObOOutJGNKXH4NJA8EduUvksS39nazkymPfJXQjpPdBEWRho8vOU2lDmkndEgxd+ERXEcuna0DvT00P9akIbgfsEGwKEW5UPYhWptiFaMdWVNPOsw7VoFgHoKXCgWAII0hdPi/muynetq9v1wF7zz08jckxEO1A6i0cYTKGz6jwrDV89bucd/4puxNQzg69qLQQrjsIsVvxW17NPEbUs10k6IB/cuv31X5OisIlv7q8B9BjeStiYiS01vn5oYii/zdhEZ3yXEys3ev/nv1kJp2yT0Wnduz9LwJPp8GwRC2ICp4R7vtrd0d0WSPgjUfW4ZhCgFUay7Sy/15Ndv0jjECBwEhMa5gNse4QpUcvryRt4sQxgnp2HsKbL9zLArAD00jnJzX64FDh0p6FSc7xu8c7PA7yyMAFx2rQqdHLBq28roq7SxyHZ6ZzQYHo1QR/OT8cIxzXISNsn2AKW9CZijZIr9OMxA4QdoqRdoKeB4mH6yu1KieumpOenCuhlfy8Y9gIWMcvOFuDpYRsaHx28oSjR2Owec228K3yfNry7ZX6J+RYrCeyGs1e7Bb5qITiq0tExW3EQr6dKZg1mMAVz50LInW9mqjf0NuIe/SMApauyEYBbML7L0v3xTwYyU9Oh4APDOQqusI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(84040400005)(451199018)(46966006)(36840700001)(40470700004)(316002)(36756003)(83380400001)(40480700001)(82310400005)(86362001)(336012)(40460700003)(16526019)(186003)(2906002)(4326008)(4744005)(70206006)(82740400003)(6916009)(8936002)(36860700001)(41300700001)(70586007)(8676002)(26005)(47076005)(1076003)(2616005)(426003)(478600001)(7696005)(6666004)(5660300002)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 14:02:11.1474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8c1f7e-0ee7-4d1f-b7b3-08db1f148c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d972025f0d20..855d390c41de 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -444,9 +444,10 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
 		en = &nv_allowed_read_registers[i];
-		if (adev->reg_offset[en->hwip][en->inst] &&
-		    reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
-				   + en->reg_offset))
+		if (!adev->reg_offset[en->hwip][en->inst])
+			continue;
+		else if (reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+					+ en->reg_offset))
 			continue;
 
 		*value = nv_get_register_value(adev,
-- 
2.39.2

