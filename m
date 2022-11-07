Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06A2C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 06:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2904710E1EF;
	Mon,  7 Nov 2022 06:00:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9679010E1EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 06:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UouZ03rlu+sipFx3PBzeDW0ot15FbeeHkw5f4yI9wQ5be3MUGdnNeo1itim+A+mZNaa4tyAxlLe45jbKGZS1vBEDbbbWiS+KHJ6tZP76oJRNzd86RROQx+gI4iBDr1FBAGI1kMJSTJpvGBfPsgn2D1o2YbCKW1rngAyxIOVcZftsablhcDIEyt5TQOqh4f3TdBWR3T7obl+E0Y72K38oM3lxb/1lhEB/NTe/n+UUkxcA2QkpLZdGpePyTb6JCSb6aM0rBpUzOatQGryXseEhFKFjghPKo03za3JGfDA9rY/pA5ivWbYIqYQBiV/IAnXVE5m06SfZ69JCU6ohgyZ0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH5KOsLMca+ODtfu4VoKbZi75eHKWq0Mf/aYxyLvytE=;
 b=jv8l6/6UYi4K275fPF6joDHT7mC+1J9bV7ckIxUStls/zisVgqHXABIIA5Fxah017tePIF27IPdm3rpHUDcFnNYy+2fHQgpHiby7U0UAYBjU7FDy9bV3xryc9T2p2fBEFu9i2dXX1eDH1SLjr7NQ7dJ/nMnamusA3qQLzIZXk0D4u8Qd/XWOvrkyfsgYOWHJRFjK1o3HdOnDOWRPMrbQpDTVmD7dRXYPdhy2hqXM/dVE/qoolMmcOIkqFiBezg2FKTNoXpdpqfAKUl0MHLm05p1gJ/3w0vzkdgKmubntX+y1cqud3gX4OIGCtqaQRtRmom/VKpn1oLfN/E1eiMnEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH5KOsLMca+ODtfu4VoKbZi75eHKWq0Mf/aYxyLvytE=;
 b=zzv1Tp8735CMr+WMU/gvq9A+XqpdbzggXAY0LKhU7EXldFQbP7nptYOMJ2f1FmD392nMnMTXLRhEGmcUO2BNiXdMtO7RpBqepT5kvuH7uytr7ycRT7EY4zONE6ITSXtxK9wAMdsq3pkoL+VEqrUtvDg7deAlB3MogLgva3muKzE=
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 06:00:36 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::6e) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 06:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 06:00:36 +0000
Received: from ETHANOL-3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 00:00:30 -0600
From: Harsh Jain <harsh.jain@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>
Subject: [PATCH v2] drm/amdgpu: complete gfxoff allow signal during suspend
 without delay
Date: Sun, 6 Nov 2022 21:59:47 -0800
Message-ID: <20221107055947.3119507-1-harsh.jain@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a352a8-ed50-49c1-3e90-08dac0856405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPO9n/Q7kytyXBl6rf523rc0vh+/Bm87n0QzNr7FmUgemlPRdCch41gAPkcuTD2pvftaaE+28reGA59iGUthyh1gmXvkwaUXSOewJPNqPO5hH8Q6a8VHtp3aC6+qWpEWx8YfaqNp8GVVEObYCAIdGqrBRwWS6QMoFkug66eBryqhefw6rEvtnxjr/h9xf4XqKHdWj6wFW4+t0IB7k8rvRm2OoULIhAXHVAbY4hwFW/pngswmRCbqFCeB+XFoTP5pScWrAIfPODySMDkUPKpUDulFnlz1vbevgD7GxbQ23Z61Q1xDTAqDdtiHtXfmwP22KS36Lf/GIMfO5w55upPb4PeeHPs/VP9OiwaqHgAcWMxtWuFnD7TY11DcI/A6oZ8gKKj36xBBw9NO6tiygCUjX4T1gntU9h1tyuPRvki2UPoROolEBbHm1kp8S6OUKrWUqgRZJ4kuyvGWj0aDitVE7i62xzeAWXdmP4+80MOidsvZk52mr0CB+lFs4FYHoIYJln6vyxaRujqVhowZImgtAnoYHblFyoBdnXpf1Zomt/WT7jwDM/hJjoiMpCWqFlgh7LIw1xYla2aBrlQn8VvmyQStEgUw7Uv5K6S8uv7oRbDOqiophtXr71LxC0Asiir0f4H/81i9JWHl0xusaeZJa6jwkUYXgvzRwyiA6THrMTijE/W2KXKp3SjGejm9qwjOqPGrxqqDGdDdYZ63NRSWzn6KIyu2zbX7uYLgojdJkt3J1a0blRI5vGD1/67+ygSvavjTrChErqnrrRx2peBQYXhs630bj+P+/jnqD8RWyXHu5PANlAWRSRJKK7oNT//2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(86362001)(356005)(36860700001)(82310400005)(26005)(15650500001)(6666004)(81166007)(8936002)(478600001)(336012)(2906002)(6636002)(70206006)(70586007)(316002)(4326008)(83380400001)(7696005)(54906003)(110136005)(8676002)(5660300002)(4744005)(2616005)(41300700001)(44832011)(426003)(1076003)(47076005)(40460700003)(186003)(16526019)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 06:00:36.6813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a352a8-ed50-49c1-3e90-08dac0856405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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
Cc: Harsh Jain <harsh.jain@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change guarantees that gfxoff is allowed before moving further in
s2idle sequence to add more reliablity about gfxoff in amdgpu IP's
suspend flow

Signed-off-by: Harsh Jain <harsh.jain@amd.com>

---

v2: replaced flush_work with direct call to amdgpu_dpm_set_powergating_by_smu
and edited title
---

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9546adc8a76f..a843804a94e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -584,8 +584,11 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 		    !adev->gfx.gfx_off_state) {
 			/* If going to s2idle, no need to wait */
 			if (adev->in_s0ix)
-				delay = GFX_OFF_NO_DELAY;
-			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+				if (!amdgpu_dpm_set_powergating_by_smu(adev,
+						AMD_IP_BLOCK_TYPE_GFX, true))
+					adev->gfx.gfx_off_state = true;
+			else
+				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
 		}
 	} else {
-- 
2.25.1

