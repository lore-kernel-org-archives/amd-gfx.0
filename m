Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F1C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE60C10E381;
	Tue, 22 Nov 2022 05:53:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A58010E381
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXhDIiPHirx4Pf3r/iOpmUGFTe2Grlqpvs1LKEll5jBCv04fyz8abpiM07UcJnxWBhMto6JaTtYTgcN42z+RmST6HzKZ9EfYgSmAPMNnMq2E9MErPxxFzpX/5R4EcFZ3VRt0tvE+X+wIJ1616/W325w0yxpEcIsVgVJ4DTzB8zwEZiUbDpiafArKpzbeKsaJn9Sdi+nRJNfufAINop5jWYy/NXxHTfSKsp2OwTa5b2HcWgj1PbEzXTee1aoDvBq7rv/Cmck9hpZIxwUPmomWB+rjyNFy1fuu69nTSDl1PtYfkyIL/cfBlOH48Qhhr3JKDGOi0CBLejFfg4QdwGktPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3Z2G4zV7HkbFHGFeX2VY4GrsHB8ls9W99A8T9mkLbY=;
 b=HePj6/xn/uXH7QIATX8IZIAUiz6PfW3+u0ZNc/IYP3ZNFDnMEGXSdflvQbfgaldCbPNhRXtFrk5M6pmsawcm0CWG5rz5etnT8J0pr0Hz9G/QnRacagMgVcIuRfo6enan7IANQCvkk6yhd9ZtyQjYO3qFP4zOgC5lVGqp2hGepAo6wbn+lbCE155r83XrYq4aVrEHV81R64G3cyKhBp4uBuzCIiQxZxeOL0vbJSmUgB9QUeIh3ELBI6y/FkMxga/majKUBtK+ob1E3OrKJt7SvZka7RyVk6P6Hu/QrzrLaoFr54oN8CTjSmSCXsVhDoSCLfjAxg8zzLM1zQo9/JpxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3Z2G4zV7HkbFHGFeX2VY4GrsHB8ls9W99A8T9mkLbY=;
 b=KVeB5+8RpovjOnevJe9/5725DTtRLREv+kBh83QPZo6GHAjqX3UJagPfLVOyyBZn60Zj+oT0jmsHLjxKBHDfv/OMQTml23ORQZAOvaJyBpOiN/PxpuDaSCqdwhAEDsVlSe3x28wdR3gk5wxwc/cp4UDSteawN4dRaS5enF/Ld8s=
Received: from DM6PR02CA0090.namprd02.prod.outlook.com (2603:10b6:5:1f4::31)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 05:53:22 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::97) by DM6PR02CA0090.outlook.office365.com
 (2603:10b6:5:1f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:21 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:53:02 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amdgpu/pm: enable swsmu for SMU IP v13.0.11
Date: Tue, 22 Nov 2022 13:50:18 +0800
Message-ID: <20221122055025.2104075-12-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe4db26-ba74-4a13-76b1-08dacc4ddd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu1AIpESqn35XiIZ5qmSNyIBDdtXB9p0WYLhyfNOKlAIdtoQzfsshYc96ZORkDSbDullzSePHaFYWn0/LYZpsKqB0id2keANh5trm0c0MTP0ZwTF/CqoqucsuMstD6A14UryqoK/4R4xeuHh6b+5hedy4wld6qA9rz2U2su+qCuLYEOE21mb1tlRRk39B28UZKmR9ncQwcK+iG6rQY4EEUVNmb0xvsa7r2caG1bp5f34xQX8cSweof7vQ0XviVy1JnGpu28aVGjbtptYZwsK3c2UYVqH6ZinI767wIAWN1RHtrra98IskqmK/LqlscEs1tGjA4RGqfqQ2OjwHtaxLTLAhboru7D0HGI43npua9w2KFUvI1RF3Dmhp9J+JdNn84tevTnlnffm6pX0Yd6G+y/NMS3G4s/2hPwUVhtsrNWdv72M2Zf3dU2SZHXdiM+GcLlLgAKG3X66UBm0crPgAPUK0d63lI/AQXFvDmqY4liSYdTcm2DBzfNALW41YQi5DW5M9EiTZazHALHNvaljYezk1wBRSlT4EUTkCfewzr/wPvUAbTQUOc6U9DpOJenqbKypVBXuzc2Ub/U8KZ2WgObeN9kH3Rzblr+MK3XB6OehXNSFy+dhH4L29uetA31igPkKF78hcHVvY/1BTNGB3dXqikKfuFIyf4Hj4Qy6qiIQms5zbhZMr9coUWZR3ivuJajl8Yt6fqUzffmfA1MHnVgNo6Xr91kyE9VQ3HOV6HA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(186003)(2616005)(426003)(36756003)(336012)(1076003)(478600001)(8676002)(47076005)(70586007)(81166007)(5660300002)(70206006)(6666004)(6916009)(356005)(16526019)(82740400003)(36860700001)(40480700001)(316002)(54906003)(41300700001)(8936002)(4744005)(40460700003)(86362001)(4326008)(7696005)(2906002)(26005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:21.8760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe4db26-ba74-4a13-76b1-08dacc4ddd0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the entry to set the ppt functions for SMU IP v13.0.11.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 20e5f66f853f..61eafaf09912 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -585,6 +585,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		yellow_carp_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
 		smu_v13_0_4_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(13, 0, 5):
-- 
2.37.3

