Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8328DC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 08:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B2310E3EB;
	Tue, 23 May 2023 08:00:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5205B10E401
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 08:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndh8MH1r9Qr00o3rhIL7Le8xgotnqLl957uy76i4mrVESsOAptRgo7FeSSmOfcoZJDrDCv5MkRYoT0r5IcSJImrNwDooUDlwP1uBI/TsLLYuEimojmwDrpLHGu26qiIlb2HLvrsvp/xyikSevoqjXJR3gUp9wCm/qqtz/RQuxZwK8m3MLVS0iNxDuh8VQmo+nWYvo5I0F/zUkeOlrFBkoyS2thveCp6q7tn+1cDJJQ/opUq0ZaEEN+ouILbPv9ipGcYagOaxi96+9S9CTQhP4MSkqOpSejimAtSJ35N00NxTb93cDeclUOcu0FNktrRdneHlvsO3XZa5ZMsDO9YULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZBKJYbT80GprHtH5l9fJtjrP+0c8MgPquK1CpGTLSY=;
 b=iD+rIXrHJa1LexzSwAwCMhtABN7Ghummt0JKtLHWis3VBcu8n3sTVuIPdnKdWYhk8tWmlfyTUW4s9qXRoyK8c50zgRv90uC+rfaCRMf+gdTAc1MvhYOeddavd2OoqcHxfht17imWvV2AFiy9JsGi/th+DYm25b1bBwTiyNa+a7Q//gxvji3W61Ar39LeiktUABXpHegP0sFCbpgol9jaOBWqtcFTqNblGpx4hz0Y98sAcFittD4e4TQSCZXn5OZC4jGaYx7QR59OSiARioAP27POGigslXF660NRQOVvyfR77Fnlogy4EqndRPAM2m2A3Ei5JfdzaivsWN3XID2qww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZBKJYbT80GprHtH5l9fJtjrP+0c8MgPquK1CpGTLSY=;
 b=u7g1cabwvZJvIs1kn/4EMOAT5YHsJMbns4e327ESXVZjSBnAOWunY+vMoz3BqqReRrRqqJSBKT7cLXMt6hLD97NSqA3OWjtZOfdTavqC9jeFv8TyI2GZoeFvhGLwLIq/UElJxBA+5yQJQO6SZKzgdJ6zzsIMUKsJnUKIn7qhxz4=
Received: from MW3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:303:2b::23)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:00:20 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::4e) by MW3PR05CA0018.outlook.office365.com
 (2603:10b6:303:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13 via Frontend
 Transport; Tue, 23 May 2023 08:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 08:00:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 03:00:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix warnings
Date: Tue, 23 May 2023 13:29:56 +0530
Message-ID: <20230523075956.532333-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5bca55-079b-4e18-9edd-08db5b63c0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxw1rtVH36TEQiAM28/tVzlX8ehN+zltVoDiRByl5vC3/3Dz8S46i/n3W4J/WNO3AQzLi5kTkLmfYLVyOpzvkHt9+/FNOig/Fm/rsmWfeFjcHY/CAoqF6gKosAzw/NcALSmC7+wRjEjk2VwgCMYhmcT0SO719BdSE/z20zZcgJwY3hVKXUTyar3JtnsusUNfm6DlCnADgzl8NahOBprgdpfi9XIVWEdi6Gq8oDsR6IRBlh9LwiPGi8MF1NnpX5yfLklvczNRP1DdjljoWVagWXavTxoDRIQf/bZdjvwvMzBrOB1jN3Dydpnm/kJ9goptHY3+htX1/uL2F4T5t366YqN+H3ly/GH5riMMu8jhX386oBtHCbInjl94fuMwZDhdd4Z7P8OdRIbRoYzJBpLCV2Ei220JHFX77Ftm11kNmkbhc9vh1sUuhc6IRp6nA5L7rc2BWSFt4OWFXuqCH/Nq7B1UX2yY/2bBJCktEYx5QzwI5UohDM+d9GNtklN9B3Z7oguFW+vnMIxeezqD9eDLdLM+pFrX/gm6QE6CgFRuu8YY8PKBlw+AysWKBLF3n8COBWy6Lo4zJc0c5ifyXSk7QQS4x0/0ZPB1cOUNdGEf6d6WVGsqdU8tGN8AJ7Ns3YZJ63+UJ7uJcUbd6qoYpSqk7Oqwt+2JFdMa35ouTMRlOlJbwKt2yN1ZU9tl+cw5Y42pFKbT7pB/kHPts7CP5fvyg9CUw6iOkUSg8qZbwE9M+POZPdagtjrCRJ5vUqPRpn1l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(47076005)(426003)(336012)(2616005)(8936002)(44832011)(8676002)(5660300002)(41300700001)(356005)(81166007)(40460700003)(2906002)(36756003)(82310400005)(40480700001)(478600001)(86362001)(54906003)(1076003)(16526019)(82740400003)(186003)(26005)(966005)(7696005)(6666004)(70206006)(316002)(4326008)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:00:19.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5bca55-079b-4e18-9edd-08db5b63c0d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
Cc: Alexander.Deucher@amd.com, Dan Carpenter <error27@gmail.com>,
 kernel test robot <lkp@intel.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix warnings reported by kernel test bot/smatch

smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c:65 amdgpu_xcp_run_transition()
error: buffer overflow 'xcp_mgr->xcp' 8 <= 8

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305231453.I0bXngYn-lkp@intel.com/

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index e9586a0dc335..fcdc0862d258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -65,7 +65,7 @@ static int amdgpu_xcp_run_transition(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 	struct amdgpu_xcp *xcp;
 	int i, ret;
 
-	if (xcp_id > MAX_XCP || !xcp_mgr->xcp[xcp_id].valid)
+	if (xcp_id >= MAX_XCP || !xcp_mgr->xcp[xcp_id].valid)
 		return -EINVAL;
 
 	xcp = &xcp_mgr->xcp[xcp_id];
-- 
2.25.1

