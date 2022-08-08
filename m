Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CAC00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 10:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A413E14A1DB;
	Mon,  8 Aug 2022 10:32:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9E310E58D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 10:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+h9rqTD43KdBKiWHNhlC6+bk0j2vWBPe2AxUFK4/kEm9EjPeyjBQ2KIh7PbKELP0Ig33ggNCHiQsFCtPvbpmldJ+rtjlFuPwcwAwlDC+h8IVmwQBJh8s7wQHR6zJGWhj5VYMiZAS3jmpWN4o3KBmeAwaComU9MGpujYNNLf9NznmGcqHvmXaIVXGOrqViP95rmic9G/LFNbbhr7948SB0D/RPQveWXzmsBtF2XBOfOiLM2bgZD3NhJzckBzPZOy+3xeZTfHgA4ZMHlW/tEX3e84U5QsSSCc1URyi5hdaljj4bU9ikrtCTuF8mtRDPy5LV0Qna+hGGH3xIFUtvuG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VljGI0bhNE+zYBWCs1bhe2ZxuPMQ0ZBoBYVfSBhgPNo=;
 b=aQc/CqBfDCAofDU6gsF/iJD6Yn5HZ1A90K7PYGEZSJojhu0hfKwaxVxjvr/T3B+J1rQBUW37kai4DJYDQOuc9ZsYKyaIGbJToN2Mv4IflZ5Vjh95ckZmb5qnh6dioib6utQpVZyLnHSnjwLqSlVn4bK10fpHUGkHlBMpIq9Rvu13tAP6YI1TTTQEtXCxfUyA4wO56DXPoPn+dDtMTU9e+VN8i+lmc74gV3j+5WTcSZRxV2uaWbnA8kyWP0p1M8BNwqY+ZrbSQXNQD9fvygnsI4BZI5Od4p623uHh6ON+WSc1lBVF33AKRBY4VK1h41ni6NFH/mqGFaT44Cd+mn/yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VljGI0bhNE+zYBWCs1bhe2ZxuPMQ0ZBoBYVfSBhgPNo=;
 b=BqET2c8X5h2ud8/in4pfTvwEulf4VsYaXC92QF+JFWTh73xzRgG0Ne7sgMqtnPaZaCouh/fE112f3XjneEc8wRUTKiQE/1xHH6VeXenSzI0HiQaw++4O6HLwR2LYMFU2o5kACgMbT6I5XD6vgMlmmP3HMOkuJ6vpcNurtnCW5kM=
Received: from BN9PR03CA0375.namprd03.prod.outlook.com (2603:10b6:408:f7::20)
 by DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 10:32:14 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::ce) by BN9PR03CA0375.outlook.office365.com
 (2603:10b6:408:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Mon, 8 Aug 2022 10:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 10:32:14 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 05:32:12 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add GFX Power Gating support for GC IP v11.0.1
Date: Mon, 8 Aug 2022 18:31:03 +0800
Message-ID: <20220808103103.3143927-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808103103.3143927-1-tim.huang@amd.com>
References: <20220808103103.3143927-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc96b6a-dd81-4af3-85f0-08da7929429f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4603:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/JFi/fvnJO0nP7bJmWuEWPxXToRm9xmV2/c3dZO+LwEZqGWwpPNxc4ZPVHDf/cpdtU6SdqY+kgxKy2lwRh6ypYgWXmj5IkUXWT603FcAP7kzmdvrKYFj9MqYZU3giYYIJM/dsHx8FdIppy/HGh14QB5EKOdVr2HrG95KEF1Z8B8PnomiFqvkM8D5QmFi25H+CYosJ8+IBrXgktF90P6Gz1dYAJRUxebsLiebj40gzdQRNdx8PGAjADWQRwlCQqGDHfqepYfq81ESHa246mlYz5Lt1y64ODfqG3qs2J0U34NGSzOR6m0gkHTNKC0iWnacPjFkH3Rxfd+Q5Jf5GS/xgi5YqJzi5zkyRCUT+CCZzGKQJTnPGZl/ZZIXYMo9hgW+fgECEVLnQRs9VEQgA9xy1QKMcI+jGwvjbsZsT/roYkcanzPm+SoU5vQ7ff1ffT3F2Mhep1y5x6qDWQrXNnGqMFIAV2jtSoSVKK3fsgzH1WhxpyMknKlJPZvPnfKLNYOPNDzK/U4NvyXxsMKMHf8/lAIOHU7DXO3c4lxwKne+nLKP99ukPf1OcwWbw4zwTQ+4/vPHnRtNblIXF9i2UR0CKSCtXQUU99LiEdfpCTvvG9FiM320lyCTAnH+E7OEKgtghRpLWoNxbF4oBHNDh01Q+C4FNeLXMdKsITJ50XtjMYs3GW1VpbsgImRJvoq0lSnrWy1HhsIw9kbBvNVR/3bdLFVcYRyw7I7OMVegdfKwQam3FqKbsiOFaPs/cKFFr2DJ1xb3l5yOWRo6RbxcSqOMi/o2HX9KwnmO3+CzKKj6w/zpp7isfBGcr6W8anPnxYMeMc1O/0RKy+RnnQ5Z3eEvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(40470700004)(8676002)(8936002)(70586007)(70206006)(36756003)(4326008)(16526019)(186003)(336012)(426003)(1076003)(478600001)(40460700003)(316002)(54906003)(44832011)(6916009)(5660300002)(86362001)(4744005)(41300700001)(26005)(7696005)(6666004)(81166007)(2906002)(356005)(2616005)(82740400003)(82310400005)(47076005)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 10:32:14.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc96b6a-dd81-4af3-85f0-08da7929429f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4603
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add AMD_PG_SUPPORT_GFX_PG support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b700c6cb14b4..bbbf760f8ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -595,6 +595,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
+			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
-- 
2.25.1

