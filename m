Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29584C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 11:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DA110F121;
	Mon, 20 Jun 2022 11:45:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0044B10F117
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 11:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7BEPKP8y+rZvdhFEndqUesFcA/aYuj2wBnd6J2VKmZ59FQeUWDT30g9Iz5eEVxev6wMQxZFqNrNjr556WZ9z7VRzSheAfKzkaCoWvtvD90axHNQYj0+5myKakbBtxLBgs8f2F1rvVnsU7zto4AQebqsjOsoMuZrtvwviuQ0lpEefPCmVO4veuPVEYZTskXbdKjI9S05fPX1MnnxmHz8HWlT7GslcRPATAhWrECJdZxvwBt77xX+NVzv8IL9W/tFvxBPXJ+osw/K3kB/1lj1XQyXAY/0ZTamY8CRGmY0xvqTlRNWFLk3SzeI3QFkXUtCDJaTMBmLkAyyR6aSg5gOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWv1ozUsH2Pu69NYpFbnDlmDLzad45Bag1PIMUvID0w=;
 b=Bzsot/dlvqeQOoxSd6xVWNs+tlCi/difKgmIpohyW+W2998YKj2M9Q4FaYDT06MIV9B+O8LnkJra50e+shGJE1wePy2HvuxZszWdzQxRh0AVSRsHdaA1n3WOkstP5jzp/SO8/wwbbItT+vWeizoCjDhYmPhLUSV9H4whkEpqKq5HBXm9IBvYClCskTk6ln35fpCHX5RuyhCSB4F7cEtOGRG3ZMVdxa4JPFOLlEAUDW3hSkl+eu2Nw2ns5j9Ie0GRKSUggx+cTGtus9se3X8TGAW1cX5ZvSowmi4zp+cYnme3YbuGNHOKIMxyXywFEY4karZvHWxXRhI8VMWaPplxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWv1ozUsH2Pu69NYpFbnDlmDLzad45Bag1PIMUvID0w=;
 b=TCju/ounhpQcUqFsJzh/Dofy3Dz/A8Tp+FtrZGtvacDGKGxdxZ7xRNLUfWxfwDqG5l6Gej8SFzx7WU+hCcRdgddDfp6xtG0fEHVM1O3bfa5cOvndXBxbMcTfeOTMmL3atLAYI4Kc2u1q36YDPBl0jCMKPbe2Tn7k5cWEqYMn0Uo=
Received: from MWHPR12CA0038.namprd12.prod.outlook.com (2603:10b6:301:2::24)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 11:45:38 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::d2) by MWHPR12CA0038.outlook.office365.com
 (2603:10b6:301:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Mon, 20 Jun 2022 11:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 11:45:37 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 06:45:35 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add LSDMA block for LSDMA v6.0.1
Date: Mon, 20 Jun 2022 19:39:34 +0800
Message-ID: <20220620113934.2967402-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80c83153-354d-4334-7752-08da52b264d4
X-MS-TrafficTypeDiagnostic: DS7PR12MB6261:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6261FE9D631334EF681DF3DCC1B09@DS7PR12MB6261.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZGb3VIGSs6YPsbTC1Fy0fkUq9rr8bnKTH0Oml2GyQuZek5rdmcMpkvy6wjwJjE6DGFIL/lwYi0Xy1nY/yyANB/MK7wOv68SZneHwq6cu/ntlZTDd4qLZWhqkMyV6/Ak02T7wzfO6O7Bl9EEUKr3+Nt3GNMZBxB+5HZ2sRbSPCFe3nti5LuUYCsVYWiIZxSbWcd0JvSDDZikXXMViLnhOjd2BSlBROOGgnKvyge6FmIbCbll9dmW82mxH3INkq+ZJlQ2OViNUC8b8g3SN3WNqTPY8EU+tgQ7N1zSHlf6nRgMdj/Lqbl4FSPTSLrXXJAG7ahL6n3s+i8X2vqmwMr7KUm+WN8h6U1a8+2JBgMhVzMCxlg+8RCpiCzqBTknZyCvxzMrWAUMKyXyn4jAa3JCDHZVxPdp5g8yzl0D+3LGJFc05lKqvn00qdV/VwLg+WzRgpyEJrqJDjOPJMt81ck0SrqNRC4plgYJK9lVFEVJRME2glcFhWS+g4XwxIlKrYoWAkUFevqlZYzI+ie1JQESiHryCGyJdaj2+Fq6Ic2if6whDqn/HvLHicpHLaqs5SchXpSxIiDC7mFkiqbQoGIwRIJucE26RThBd6Tbz+lkxtKTy+h6bS9LkvISwqIfRqSlg/RZUdWIWHQ9RKOt2J/gJUb1E2qgLJ/T9xO5A/9hDqCrGJ2QvY+1eUS5ZbYfVXsb//0pJQqJoaTi9v5Q4UxXO1Xg/oHc7mTauhp5Uo1glSkexdinw92bHaz8WRBNWQCy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(136003)(40470700004)(36840700001)(46966006)(426003)(5660300002)(4744005)(336012)(478600001)(81166007)(82740400003)(8936002)(36860700001)(1076003)(83380400001)(41300700001)(2616005)(40480700001)(82310400005)(40460700003)(16526019)(86362001)(356005)(54906003)(7696005)(47076005)(186003)(8676002)(2906002)(6916009)(70586007)(70206006)(4326008)(26005)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 11:45:37.3773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c83153-354d-4334-7752-08da52b264d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Ray.Huang@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds LSDMA ip block for LSDMA v6.0.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 11bbd76c581c..37234c2998d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2333,6 +2333,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[LSDMA_HWIP][0]) {
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		adev->lsdma.funcs = &lsdma_v6_0_funcs;
 		break;
-- 
2.35.1

