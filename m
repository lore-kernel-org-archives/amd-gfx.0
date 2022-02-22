Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F2DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 08:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8EE10F4B2;
	Tue, 22 Feb 2022 08:27:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185D810F4B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 08:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2dSyLg9qvVg5t/XcnbHst/4PGv44rjJLrCWBaoWOl1Juz/Nf9BxL9ACAacgXvMJq+sW5FTrz4Dn0vm7i+ltSl6aEoDDPj66XuUb5jnkoaRpkKEVrZIOv7pzGwQ9W7H+DV+Ql53x5iT0ZTXpvKjQSDiKWMaNHOKGyVuEkkM48pXzzrMTvkQW1vx1VZRgwwu8xjuEvrQu5IpN/fJZqruhENmMrl0VAg+2dhvPdCX0dF+fAtHooajzo1QHA2g2qF+JuqmJXdiaS3rZNgaqYn8uGHtFW5NK9DcnqidHag3LqYT3Qc3V1NAMfno3F8veqd6c3JQ9PamgGOjjgfIkwO6Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHttHKcbW+XqT5+OwuYIIwSC0pGsK+slKA4OVKo7hTA=;
 b=e0eARubf5fsL+g3q18VB3qp5xS0O3LUF+4kSmHUmk4zmFjO4qfghoN+MGyEhigWJoRqYzNNUKAEcNFcaKhdxbIw31ZFjwQktfV0tckMd+0a/l02WN8lW+HP8U3BU/aG/1ab5k2gR1htjyLMBSc61aEArUn7utJ91iCVtbD6owxePM9iH3HhXmPSXU7nMulRB958nFKXc+4nhgd+g9ohn4QbfMMe0muzsFr/KAr0EkszE7zdNWkhhD4+mkAwgGQxpbM80EfLKluN27HGeiaaO9dhoVdy+VNtK02ijqRf/zobGWa63CCNRjTceona7lm22JV5g7k7hKjJPdNmB7RfC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHttHKcbW+XqT5+OwuYIIwSC0pGsK+slKA4OVKo7hTA=;
 b=mcy1tBOitEmzknXusqe5+V2R1O99kxk+EJRYBpE97AScJ5XFL7neHtpNcL83gpK0mYQHoVztcTFfSVFdM2l6zRwXFB8fLw2sKEXZm+PpkT1B2BBEDS44YtfBE6UBl08xzW+ejLy3DVfbmWbE3FRVJ3LXXtOww1X1Vm/071KnJ6Y=
Received: from DM5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:4:2::15) by
 CY4PR12MB1464.namprd12.prod.outlook.com (2603:10b6:910:d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Tue, 22 Feb 2022 08:27:00 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::cc) by DM5PR10CA0005.outlook.office365.com
 (2603:10b6:4:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 08:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 08:26:59 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 02:26:57 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add mode2 reset support for smu 13.0.5
Date: Tue, 22 Feb 2022 16:26:22 +0800
Message-ID: <20220222082622.862279-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279f5267-c45f-4cf5-de13-08d9f5dd1878
X-MS-TrafficTypeDiagnostic: CY4PR12MB1464:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1464A38BA2B55376D137A599C13B9@CY4PR12MB1464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bw/jXH1Q2MnigwoBQ7lYkzsCzEQ0ZCdrsrD2kHSqe4QW5yawsY8z3JRDslIz9ldFfYAYh2+Zi6M1OAgdJl6f7/yzlA6QTorHLymPKwlJ3cWi9SH7V4tOyav3+O8KD9paJblcBS9EgEB0wyK/ZYR0YUX66J85pXsoROlekZqVVKwjwnVP2k37iOmcCrATUEmhDGJEux7mWdqm6kA6qVRXq8/PZojHy2c9wf5gzvrGCWppwwX+yaVZ1GH9bJNHznM3H/nnvl/zoGOHGYqg2p9MvuUV/3rP4aX9XY2TB2vD5rLqZTNqoqkoyoC0+y26SZe/E4odMA/i89CJ59ZH3DOQH3XIyzV2XfejrvQf/dtLnRTP9wucOpnwnBWG8TsFKlV5+Xm6Y5OnBqwDJHeSDoeehIkS3r50irA9JT/273e4aCiJuMCDtC82tWJGiy7+HTEJPuUFxyh7EGtGGF7uX1VoLoSBMcYoItKw3qy10JgTGtFXcoxfl1xKTHrykeF9l8XPlszMSBFkjXvWj4LuKNmJul3ksGfdmiNG6uUFbjV7Bv89ajHVbnL4b7+SfzdUNy4JdZ1ubpyT37VHcYFrpbRjtmyRtBRoAIGG06kZ5Z2b1G2tbtccrOTanG2JFHcpx+m1zpp2uTlFE8BWEVVvDJQonfJLSXUqt99ua0AiuJ9FL+7V4I0UI9g/e9QXKXhCVIzX2T/58cBMjcDljf3frGx+8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(6666004)(40460700003)(2616005)(7696005)(508600001)(47076005)(2906002)(36860700001)(86362001)(1076003)(16526019)(5660300002)(54906003)(26005)(8936002)(186003)(6916009)(316002)(82310400004)(426003)(356005)(336012)(81166007)(4744005)(70586007)(70206006)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:26:59.5850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279f5267-c45f-4cf5-de13-08d9f5dd1878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1464
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds mode2 reset support for smu 13.0.5.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 74e0550d00bd..80caf73bc2ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 		return AMD_RESET_METHOD_MODE2;
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
-- 
2.25.1

