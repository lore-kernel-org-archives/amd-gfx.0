Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C7DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBE510E385;
	Tue, 22 Nov 2022 05:53:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188BC10E383
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz8JKdUQ6sAgQZ3g6fFNnw53OsgTlLe1icyJq39lgVrdkK+QcUzKq3oXPuVZ2Urv3EKwKhZYy0U0eeV3lavHWrsLUAfiR5WK0FnVgvXpfKjC3R9odUPqtuNE24GgCObqI2x9QeVvlxh5q6UHp4D9xBLurQ4QpWBJrH3hi7S7Y321Cx76wvck2Y5N8wEd/g5aaWr06+k0pxU5CuM3LJxr85uIoIkDmxme8U+wyr87d2oWhbU87+drvBkiwXpg4r1gg/TuMePTnUy54He2opBM3V0pGlnOwgAN/v9IPCppN5iXfhhJMiP627ywNmnxV98g8A1cy4zFRLzzeu2Y8E3f5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH9vSZkSO1CumxBkdBvMYUcpPWFqENBIuW1kxWq+ddU=;
 b=jVgy9894T1CsQRiuqqewOSrAmktBazL0SwAKmjTxOj4Iie7aDnPpWtCD3yuaReNS+JTa+5gTbu1LDLkZs5GPiiQ8PyQtESpY+rbTSSN1mSDs8NFKTLXvUo3KYLlgnztB3jqVWdgdx9yUZclHQPTXmUbEGz85dbaRz7Qj96jV/5k1nBvKT1BCIcGZJrhSHdGSS/tDFIML5EGeT9EDQgXu+esVzu818lae27joZDdvXXv+UTwKyhC3NdWTugBkNjokXrvkXEe3btgDP3ogXxIHGGcPUr3/P7aXGJTyERM5FHH12Vur+i4F3oldSYJJdjwpTF7LSWfUsXK53+iyXwqhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH9vSZkSO1CumxBkdBvMYUcpPWFqENBIuW1kxWq+ddU=;
 b=fv/mbMomJVhLw8u9MQ/quxFVMCWRRA1NxrNhI00tHqAXXMCY3LuRASwRuVTi7p7Ywn9HqRDp6FmUh4COlZCutjqF7uWe9G4vi6iUrWzvZqXZL3bcNvJfYfqBTaOVZyIkMuJTCYhGQFuSZreuu6GJQQfeVYFEh77tjb2GZzUrZfA=
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:27 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::e3) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:27 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:53:24 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amdgpu/soc21: add mode2 asic reset for SMU IP
 v13.0.11
Date: Tue, 22 Nov 2022 13:50:21 +0800
Message-ID: <20221122055025.2104075-15-yifan1.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0dd4c5-28bb-4e6f-61ca-08dacc4de030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alsn/8822N4z7mJJwP6mDYmbLObTO2F9/JSrLeI8jziFp69dh5JwBE6bB1P75ZAeBh5sAyGJL2Yb3j3oqmDZvktxerQfZvb/dKzx4uiTSFyVh1qqxwC36HTZYn7lPQ13iKCux3vknMi5L2PGNBaskx0bV3AkT8tO35iBU2RTiQ1vamEzWVPWmJlH/D1uwjf+ieHgpEdLg8bzEp1TmYTuGyuTX30BHfVyAM35au0iNnjCiYnfhHxrsVMS03gcoLscvd3PySzcr4iMyFUXIAec+tlT1IPxpA+0Vie7fSMGpACLuMqpQYpYXYvegmFKlB5W5WTYZptsnOu7WND4jZTI8ryHdn93w44wccojAx1OhWTfn1N9osiVXi4d4Xn/JrPgKu212ZpN7fq8GTwMIebq5IQTHkjPkgswyxVLbvfRKaXvumEjdoQRb//W0NIfuvm5TOZVZDmlUHw+JZXWIq8SoiUhwPVXY4tv+XJ7gVLyF+Y2pwgLPdSFHbGgFGWd39fB/jo6lWJUBHFs64mvv7nr420RSbbv7wdfdi1QTaHeKdyeUgqonkg9sy5g6DDlN927+wgq9C6kyUZGgTeUcQNGzIpAo/azNoe2lQ733D8EWHs9HfF2pXIADuvGpxTpNKdGAL9KpFam7Wwj65TsvacK7XQIuApUB8TMmL1XKn+sMgLLvK8y1Ad3B14emSQDFyIaieV8Sn864p/05E57/u6EfQ0xR5aJC3ydOoMMPObd2p4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(1076003)(186003)(47076005)(2616005)(426003)(336012)(16526019)(81166007)(356005)(40460700003)(82740400003)(36860700001)(4744005)(8936002)(2906002)(5660300002)(40480700001)(82310400005)(478600001)(6666004)(70586007)(7696005)(26005)(70206006)(4326008)(41300700001)(6916009)(316002)(8676002)(54906003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:27.1380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0dd4c5-28bb-4e6f-61ca-08dacc4de030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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
Cc: Alexander.Deucher@amd.com, Tim Huang <tim.huang@amd.com>,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

Set the default reset method to mode2 for SMU IP v13.0.11

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 69dac2aa8151..ba11e06d6941 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -325,6 +325,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 		return AMD_RESET_METHOD_MODE1;
 	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.37.3

