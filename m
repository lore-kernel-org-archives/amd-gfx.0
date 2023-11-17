Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C598C197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 17:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6C410E0BD;
	Fri, 17 Nov 2023 17:03:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0094D10E0BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 17:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIkG0tQ8jVvvwZHNMy/2ab/bHd16SQOFrCWRfpmo30qHJFVejJwjeQwNM4qUTyperK+xZhYxTDQhwUGgZzTwG5pJnqeAR7xUpqMcBCm5PapJoJJp7Kt0EJZXtuy3ep+aZh3hIpmvENKUnkK2usnpsw2BAVeVuObLdQN4Hdzd98fuPSrX0FJRZ6PGQ8Hbj1Dk/LbJkLVnDhmEXQP2GZn01X7v8lkJJpArIF1UJ71YwpcvGUQS/wVdLQYnaTr9dasZaDv4hK5Oq/ZIv6zfyaIDqi4i2JTyvznTx657SwjdpTFccWTbvaN5WzFO/TAX7u3w7RW5FQlvA5BMNWjBEE4//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNmIznfUvSLZzEebAgp63Vx2wFbvTrHFCHbDLzQLSWk=;
 b=CjoIlfFe4Vq786b7tJ0P/QPgsHywVM0EwoxYpIl038xQ4ikN9DE4zAKc57ZNufTDTjEvFEVUudKmsb0/ZaKj5PyMdH9vs/LGtyoQvA7800rvQoYaq62fJtQyjSn/xAp91IQ7+HDJ8Wqikk7mKof2Q+mggqGhufi3Jr0qu41h6QnwjkiNdj81J0Xp6NWo0b8NerLDIk/m+CFBRKjqZkH7bMh8269N5z5lZvNNm7TRwiBtnYMhR1M7/bbNT+rg9TGXZvTPYAIv1laOF9ctUQ9bs11a1eXX7DvKSRN5kbejjBV6icQNLdv0SwX1C7w/j+KN+cDGcFnvJ6HrRHJQlPHitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNmIznfUvSLZzEebAgp63Vx2wFbvTrHFCHbDLzQLSWk=;
 b=u2ukH7kWXEp2dj63IijX9TFLaTAtwa52ciGH8a7xPWY83Bw7OTyhyARkmJjrvOgDqBtkhdmcVd2Bbk8XRxK1d3X60LSyrAEiRdOWT/6TvB72xDQKHc0YgOY4V2rQRSknsovGU1pMYFnoJ37lGjHArSEe4fLvcJvZr3NlEam1Qig=
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 17:03:36 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::69) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.11 via Frontend
 Transport; Fri, 17 Nov 2023 17:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 17:03:35 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 11:03:34 -0600
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update xgmi num links info post gc9.4.2
Date: Fri, 17 Nov 2023 12:03:10 -0500
Message-ID: <20231117170310.2917026-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bc34c9-4c88-4e48-3159-08dbe78f231e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjrcrUwOmF2hid5nntxu9h7mpijFdJAZlkhaEvULrnHgutGkTVyiE6+a1hDHztbwJdLB0pYmfH1fTMJapoCRwZT6bYQoy+0b73coyoLu0gD+ckeu8mF8xnimBf46OxZb5jbH8ctE08MGibpZY7TGUWLEIxYqVSCl5YeA3a2dwbW+yEt3qiYRUZpjNxtIbJxr1w+BZPT6TQrNSQcTW+qG1CV5xP/H2emFMf0hosJJKmGsEGwMPEq4VBmi6cgR9MBYNnj1V57cJqMza9FNY5nKxe+qf+MLgANhgGfMuPsir1AymrcMHvhvIKISwQYrzRLGxtym4Faw6Olu84aWIZW2YAYXiSBuRoilUL3quvUDEFXh+GVSObDyekOkDvIHQk7RvWn4f9Hi4QGCw74MoUjsOKWT8jRNLQxQEJaWhAVgi8Caes3lpn3Kswgb5s55bmNWr9kRqsKDDG9UQILPZsYYPdmmZQUfpkGsobw49VuzvJguW2YhoaS+Mt5HBO+kv+vKQMJNOrp5AoIYwJzGuUHGQcXG7wmzqw7sjqC0fQHtBD/0+/12iwQtWkFEezkFH8Nl1KSzJvYB9q4S4n4w8gRuoMMx1+ewVp6TvhCgL5IFD1NQHSctGp8cIkeaLnxRVJzwEs1S/tlvf3GbZO+xoMiF2JuR0hsFsW0JE96AnnTvpri4zMzOsEZ8C8wgGTuzEF0htqZRsAMt8oDt2ZQdAk/B7bg8GrvOaCvlNXTUnW/qbnpoPV5N34cH3yuadn4rXI1Nm+qmFuseRvvsWg3iGhr2aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(2616005)(478600001)(6916009)(316002)(1076003)(70586007)(54906003)(70206006)(8676002)(8936002)(4326008)(426003)(40460700003)(336012)(83380400001)(16526019)(26005)(82740400003)(36756003)(6666004)(7696005)(2906002)(356005)(41300700001)(40480700001)(36860700001)(47076005)(5660300002)(4744005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 17:03:35.8109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bc34c9-4c88-4e48-3159-08dbe78f231e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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
Cc: Mukul.Joshi@amd.com, Jonathan Kim <jonathan.kim@amd.com>, Vignesh
 Chander <vignesh.chander@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GC IP 9.4.2 and up support TA reporting of the number
of xGMI links between peers.

Tested-by: Vignesh Chander <vignesh.chander@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 6ab17330a6ed..2d22f7d45512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -547,7 +547,7 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 	struct amdgpu_device *adev = dst, *peer_adev;
 	int num_links;
 
-	if (adev->asic_type != CHIP_ALDEBARAN)
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
 		return 0;
 
 	if (src)
-- 
2.34.1

