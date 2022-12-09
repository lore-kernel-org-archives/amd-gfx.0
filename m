Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3D2C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F6810E571;
	Fri,  9 Dec 2022 16:37:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7167110E56B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avlGk5b+JsXscfaLJe5QotIWK4GgJGc2RZzLTAW2DbuzkNTJPkhBednsyeO8ADQkrJT1VxWgses4+TcuZcrlTcgxlbOzkrcl8C8/TxNDpH5lT3GA2F4WuA/oE/Cgjvs2bOKEpnYu7cU8U0ayKhBtXrbpuOVz7uhdrTjr/Qy3aHFBKBNimiITCaUEx4koBVREcVpyGLfhVWOQidfcruym1FPPlV7vVpdVOhDhJMQirxjQOPFDOL1deU6sMoXsQGzKPytNSJZG5ycAkxs2k+5bSX0btroQ2Yf9sl5So8NEHtjsSK/55KLka79eADG9pVScmrEQ/4I1PfyG1TYgCBMYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V42Y+4kOxLyWkWtWInuT9NHv/vJHrrDQHwc7Grg75wk=;
 b=dltMhi1ikx6tNW/Xkv3S7n5jVq7tAjDZxMi2FtMw5DK6572ZVC4Ef+MQhM5tCfifbZ3bfgYq3aH3nL2rA9YXHGmtNL56fnMzLVE3ZzIIYeMau2WsuDIFN6mgon21lJK4AjKn2Kx0egK6srLGxBuFfOAaD+Q+kpkx+06S9PGEmZi5C601HpmYEcgRcCt+UdoCL2vuANaIZVKa1IlcB3nn3tGzG+KQcrXV7RBIMlbBoTaw0mU69B7WWgVCCJ1zg6FsTzzunjAvuANs4J0S5B7Ql2rLi30JSPvH37PI8MEhIlSoUigSNaXxWhI02GAIMjTJe3e1qAHoDnNlQgnHlkSYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V42Y+4kOxLyWkWtWInuT9NHv/vJHrrDQHwc7Grg75wk=;
 b=3aJb+Hri+IaDHAd5DEriW9QcnTRxLQtbhcwE3UD0qQX/qHG8sXZcSLVnT7JufcURJ089AVa6r8ItjDTigQbI8A0dKkE5FQ9RUiayZYUeN+KlBbRs2PGTqF/CuWYHEZG42WJ0CpGd1b47V8WLUITB00aMZLo2epJXxV7nTYH9QSA=
Received: from MW2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:907:1::36)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:35 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::d1) by MW2PR16CA0059.outlook.office365.com
 (2603:10b6:907:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Fri, 9 Dec 2022 16:37:35 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:33 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/23] drm/amd/display: Clear MST topology if it fails to
 resume
Date: Fri, 9 Dec 2022 11:36:42 -0500
Message-ID: <20221209163647.25704-19-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbfb80a-0b93-42f7-183b-08dada03ad8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R18dK3w0eaVVbcNMPLD5RolTmRPu+V6vbkNXteNoQg+zbuWZD5xxaQfA6oEKYCFFE3d/tlkqbbTjQKDAEnJyG2rfoqGvuTchvpKitVgyQnkiM8DyUzauqU8HAg6gcAavkIi3cBRvCAowd/3qYVgXRbs0Ag7LBhdmNwQMQmcDfXIcK0d/qksAc97nrGze2y+3FbFjgEWlDAOiqkyw43sDWMpje2fJj8ZxprmLsW/hWdURNO8L3+x3yxmDx+WApmpbRGpiL2Dyuu8k2pGITO5OF9VxN2kUKELaR7INiLYDmDl6raJXs2hMZXgqrO4195g9a9iCCnM1poa47IunPV3kQ1zwknukgwo3prTCngZc54nSxnJJZHjvYrlO2H6n296b81nPDhHn/epbsknGlZ0D7iYMmVmOEGMr9HJ2+O+oie3xChT2g1wScvbbYjykZSH+/iAMkVYXOO/OmlOBsxE7ZFAetM5wuMOjVKAXAe+F5P3SWwWpiLg1bRw2akiVKEwOMkEfK2d/zGNro1TVFs8ZjMmHxj2Ygua4Uh8A4eqJMeGlugAjLOFv4LGizToqh+BvVdgK1Z/+/D2G2do6Jf6GEDWH31BT8p4uCeL4DM511z/RAucM51HEtbo8hcI8Euf3sHo24kko6Ni2p43g4G4GOzYX0vuQhYU4ypMAqI/BlD3RR4IOXhSK5LYvec9ijTEPZgcGalEQsiAi1KN5BsO/5bLE2wlcWAqJDOcKSZ4D2Ko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(36860700001)(8676002)(41300700001)(40460700003)(81166007)(4326008)(2906002)(8936002)(47076005)(186003)(26005)(6666004)(16526019)(1076003)(40480700001)(336012)(426003)(316002)(70586007)(2616005)(54906003)(70206006)(6916009)(5660300002)(82740400003)(478600001)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:35.6205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbfb80a-0b93-42f7-183b-08dada03ad8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
In case of failure to resume MST topology after suspend, an emtpty
mst tree prevents further mst hub detection on the same connector.
That causes the issue with MST hub hotplug after it's been unplug in
suspend.

[How]
Stop topology manager on the connector after detecting DM_MST failure.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 88474f04fa9a..2fb7de3b4f5e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2170,6 +2170,8 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
 				DRM_ERROR("DM_MST: Failed to start MST\n");
 				aconnector->dc_link->type =
 					dc_connection_single;
+				ret = dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+								     aconnector->dc_link);
 				break;
 			}
 		}
-- 
2.34.1

