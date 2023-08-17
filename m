Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AC6C05052
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 01:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4AA10E0C8;
	Thu, 17 Aug 2023 01:21:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69EBE10E0C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 01:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNjKofBzBXCc630nWcudhja3EECGYonUUuaCyWvK0pYpEiuS+O4eKhqHL0liVIZHAto1qUkIkouiA5MWHnBp7FAFtsTW0510eyQDhNzkgw0nXHgs1CXB1zXGonUaL42o3/IqOmzaeUwcR6nru2NNFNA6YlgwcjTVVDQq+OyjRXW+zTbtKgSG6R26X2u0VJLqMHCeA13fh5ZMOn3yb7RmKpB0F4KXnzHbpT99hM3gsnrgsXDBVjC7z+Y7qvnAOW3WMTHvBzqrxtjHEY0dHr04mcx/nC9/248sNDNOEupB61OV6amt+khsobbanku7rK/w3YGzYm5MxrUbcgjBPj8kBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHaV4nlZ2/TgKnbbdzZuBBiftBMmoe6cDgMWBzR+Vsg=;
 b=cmqO3O1/XkPKMVQzs7zmcSJHD6Db7IVGVBZwI1NZdZENaYtUTTM9k+iVnqPXPdgXFMQkHqYCtk0G6kRO/a6/OHzc//HU5yKIdPDrycqMsFZ0bh6DiM4QyLooQglSrw9WupctBDTko1mYfbYxE1OT2r6eZSFNe/Hr0vf7Gd8ahrsJ0y9qTgTckVb/I9Csak+UpxZsDZz37YKJUsA6jZ9u/TFu+ANYjunl7x/Eq9pv74jFLCK65LZ/qzMj9yqooAWUAAwDVwdZM31SoMI/kFhF0v9it4MA4poDDzG4bQLs3jVFH+fFg7XD7cqhyo0TPK1fNAdl+MqReuSyjrsHStYZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHaV4nlZ2/TgKnbbdzZuBBiftBMmoe6cDgMWBzR+Vsg=;
 b=A5Og+j0VWaxPAu4AQwS2SyteJ1q43kU0hRI4ojd2KGQlGYErNsu2p01bw3ADwWiRVrhKeu5A1XDJr/y3lQy0pbpnm2xDNtFL2CNAqMFQALFwfUw92TTCK6iIs5pa7BM/P4ry+H1DQFtpG512G7G6K0096/T3autZQQ6uQv9bWqQ=
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Thu, 17 Aug
 2023 01:20:24 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::a2) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 01:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 01:20:24 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 20:20:22 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/jpeg - skip change of power-gating state for sriov
Date: Wed, 16 Aug 2023 21:19:57 -0400
Message-ID: <20230817011957.639883-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 22375391-ff5a-4fdd-799c-08db9ec021e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjfyMy2lRAuKLma3trvU5X73bMUI0KBygGNgxxfBcaSToJzR0pGck4c9yo8dOZl4uuhy6gEw6vCe6YEcu4TNC5VEbgpLho0vt6aEvew4GCDFrsmXyc9v1jFlzFD8Vx28ZAMIniNxzYu4w0wgLHBFOTjYC1EOPw4dwpdh5pF70qonuuW1+L9nRHCi7V/HlJdI20cUpVBGd0WG5EvZzmsHkgAbyKOB8mz1FZ3DAgWyiQE9dNciXqUUhKT/UJQOysPK2t9zTSWIw44VS67qRLkHEKEL+iUSWreLULcrkG9EArmGLJgpMvLVDcel4DzVxFpQKMbXAW+YMCi25BsMmi/UpvyBLHHz3V2eTRCjVdJrZPdIEJL6Qk5XSMvWo40+f9q05MGrfSyrnY3QmjTLjpKTYw96H5kZcXSVV9zQeFKHzNdo7og7HQs5O7UwwV4e/brB7TorodV3sPUAnub6MDcOoIT2yyIsJJaobs0wY+hB/NyQ3qg2h6cDI+h/h3FP1KmfsstHplWUpzdZp7r+UvrQYgzt8Z/7i+VTeTXY9rfMAVooYmPuyGw4QY46amBW27EoPPSLoycY30ny2yecqepwgA21Fz5h2IgbWzhcDnym6B9af1rcPCxEz+vpZosQsJA60F8+3DeGPCZ/X/BST1V9ioYrRgrtEpSCDIrvSZpqX2bgr+fAUvndhXaqI9jK6EEqI4lhbMkPhyOhuyUq7JcGaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(2616005)(426003)(336012)(83380400001)(6916009)(54906003)(5660300002)(70206006)(70586007)(316002)(26005)(47076005)(16526019)(36756003)(2906002)(44832011)(1076003)(7696005)(4744005)(36860700001)(6666004)(508600001)(81166007)(356005)(86362001)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 01:20:24.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22375391-ff5a-4fdd-799c-08db9ec021e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com, zhigang.luo@amd.com,
 Samir Dhume <samir.dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 15612915bb6c..1de79d660285 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -360,8 +360,10 @@ static int jpeg_v4_0_3_hw_fini(void *handle)
 
 	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
-	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
-		ret = jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
+			ret = jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+	}
 
 	return ret;
 }
-- 
2.34.1

