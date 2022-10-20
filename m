Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3394CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE2610E4C4;
	Thu, 20 Oct 2022 15:48:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B55E10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMmMuBp/eFtgZ/FUh+VVatE/eaVfTBUkqGuFaHx87wV1BMRPi0ZjuN4/m5C+kU5W9e/CYqJAlT98CHAEN7tUfBgM6+AWQIuIPEr0LmYdEl3TtiZiSyZpwhKkgynyF6nXIKIM3mKbWAOFqScTfXhdII+uO437zkM0vfuHOrgNkhVsM1+SIvUZiMNAiE9StRfF6E97ejCbWcLtnoXGq8Unlo6RMEJBKDhKW1AUla/MVgIWmgBIuVMDxoZdn35rAoeVEI4OhovNszYtbByS+0vSwxRShKvLVm6jiS1eMKC4X5iKWjryPXtWwCITecEAwdweTwnBrpcbhm26iMCUegKwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4zXS+rxqlyxZXY1gsr94EY10HSsI2HtzmY2dlL1b8=;
 b=mrBaIS2ODgtQmWY+hL1ipESUkpTUtS46bgj1jWsY3esP1p1f8JnZiti+jB7G7379Sj9mATFdnl5OCSSBDrQgkIdXX6QsWryFnbX0gTnSNoTEgEediHEJISQFZ3TPCN587G1aUNl46Kat0P1RgzZ4auDkvqzbvZ2DtS7qcNlxBRedOg5LReIR51XOXujnEu7+DVU5w22ouT45Y3d1EgiHEAoUEU6M02S7tU+xqgL07VjH1B+nvIAxTNf0T9fboN6uZ2RXMIgkZ8Ak+CvR//JorxnGVpOk6IFYMrmjKj/VLlw+MTsTnCB/kHAIQhPCtTs36LyF+TeVFFhN1ozQyQCoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4zXS+rxqlyxZXY1gsr94EY10HSsI2HtzmY2dlL1b8=;
 b=wYe+hAMlhjkrygm0rDjA8+vs85bFhG92V2wUX42xWgRFmShYepl/rOonJbYJZJOQossNpiottRtEfx2OTDWGmtBnlKN33gim4UPt2EbQ1qFBQdKwH7exGuefS5EHe4B8mE2KZ8kRJaqReSpk0jzZJa8f8493AuQf+4UY22XvPdQ=
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:47:50 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ee) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:50 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/33] drm/amd/display: Ignore Cable ID Feature
Date: Thu, 20 Oct 2022 11:46:41 -0400
Message-ID: <20221020154702.503934-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|BL1PR12MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f286cd-6f17-42d1-1991-08dab2b271aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3dsScsJxyquj7otnrBq1ioUlTNNS/+v9Rb5zKCSQwCWK95ke1r0dfUqWmZmzYF6K7NrhDR7ZpBzJrMg8oNPNMu+mtQqEZHU3VcEV9RDOyjaI0nrBs9XZy7XJvbNJWAbamrA5kqLZuj7rZSjQxkX59TJq1NvRB8w8qH2QnCAgGkuxvx9zwUmudKUYjFIEYe4NZoyl887AaALZtgMjcdEnYGu/n0skFkbuHUc1egzs8r5A/SVk+fObzAa+pK06bXelDpsy6BARa+jYU4Le30HXa8G/XK16v5LMvB2YSvy2l4hYOG3cImL68Lch+uyM2iphcf0YkUYXIOIt/kfNMn+IYeHNPNb2uApuJFwUzBeZWuTLQic8co4vpb7S0v9m5I/USIKQkt/EU76tPyzgCrMIP0w0Qn5KEMs/YCNSGdPy5HFowHHP7Mk3wC36avoFRjhLk64pxicp5PBCM/t3+75nXYov7L549RZjBitLnh1gEi9Tokvvzolzla8cLMX7BokZ/O5I2z6qVbX5ayuzvXHnMc3EUMbyejTu2zzZmmj7zwsACd8ajVLPvHfswhzj99Af5+xUpLwlUkcCehnSmTS1eZdtBMU4rfaD/mWb9DQYFl5wERLQ+TP740HQTviWBQA2MA5hYPDaubPB7lBpjyRntS9EDOMeFJLiAbsV4A6gzw1OiUuiASuXgR0idan5kClck5YedtB+8FwK8PubPVbW3focZq3TW9mG7cMWgdFvivmXGk4OI3LxRD1jGG1VT9s6edAdECjUnHEaL7u9fqharnQiLOZpb0jC/FpA7q1skp6dJFhLALIv2uNnDrl6VPU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(186003)(82740400003)(1076003)(336012)(2616005)(6666004)(26005)(16526019)(36860700001)(316002)(47076005)(426003)(7696005)(40460700003)(2906002)(83380400001)(5660300002)(4744005)(40480700001)(478600001)(82310400005)(8936002)(70206006)(6916009)(70586007)(8676002)(41300700001)(4326008)(54906003)(36756003)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:50.6461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f286cd-6f17-42d1-1991-08dab2b271aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Disable for DP2 receivers that does not support the feature.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 17a9108f8186..0b5e9fb0012d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1544,6 +1544,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
+	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
+	adev->dm.dc->debug.ignore_cable_id = true;
+
 	r = dm_dmub_hw_init(adev);
 	if (r) {
 		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
-- 
2.35.1

