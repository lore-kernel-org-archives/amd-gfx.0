Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080A6C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E6510E280;
	Wed, 30 Nov 2022 00:03:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C58010E280
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Q4fKbCDCZuBCYpSSfaIKDnkRH3rlGLKewnr2Asd3b24Z0RY3VAQVQ64SLvoPOoN2TPsG5olrDVEkTBHcAPyDTWFdGgt27TAylli6qiSl0HU+sIYp2bes7HoB70DzsjYA2nmQTrTusDjRZgtBn7zr+XX1vYFgZoj7Ezpf4qPqwFYVCvAUd+aBHg+4rVz4vufTlZSOSDViQwdz2VSamyUNKBMcX8EO0tjA0pNVVAocDLKnOMsJrmH/RQVcwaAMUbRk3YXoS8mlWeeRi59Cc9+oNwqEBGQEzWTwL94+LZFEtEa+wfIVJz7qHtJkxY/wW2E9j1+uOKQ9IC+jHWUNpWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzQEhbwVsWbC74gCwkQxhIOfYMAhQ17ein1FOAR8yNI=;
 b=fkQ35iF5FYZg68nLQczoUuUxHgZr04ZKJTX92pYT3B+tDKY9amJxTunG/JLVbCKf9uh4nvZr2/e6h+dD+5vt9ypJ2Pjpd9om12QZIe8q2MdQjzHMhtUEmC3Cl+vnKmCbNcM6ZEz2kyWAhDGtOQ2dOE6Ms32LGwEexB1xrjmwiDkIv1TvbdPScDp7WmvZlhOTo/QCOyObSHonFWVdhNSMOpkIrt186VXTobYM4rY+I3N3Ndawg0OmAMUTtuBo4miDfmFNG+J+abROUdQv5wJxatdAdiz5xO1VLG29aiETeVYmciU9U6I6osTgovnnHuBktaunTDn8Awtl13P83wdL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzQEhbwVsWbC74gCwkQxhIOfYMAhQ17ein1FOAR8yNI=;
 b=q+mVXqBr2cSF8eaco0HvyON9wvdTRRoJ6hxyvvwMt5o4PLE3KmqHXZb36X2M/CAL54wTgdPS5IzJr/e3jn3Ngx1Z9+YoEnZPDodBvmORYW5vp+MQWpeEyC1QtYvg9kEApSaaIqLXq75kHysvCqmWgDBFc3pQx+bPTkVzhzzkrbo=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 00:03:14 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::42) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 00:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 00:03:14 +0000
Received: from ubuntu-Golemit-RV.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 29 Nov 2022 18:03:13 -0600
From: Leo Liu <leo.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable Vangogh VCN indirect sram mode
Date: Tue, 29 Nov 2022 19:02:51 -0500
Message-ID: <20221130000251.6824-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9c1edc-346b-4f74-1342-08dad26646e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEXNUXb/q8sPhzg+gFZIQ4xXyzQgoSGIxEC4QR2wSiKsgE2lMFbSpQTgTWkS8FaUtUU/59xTdIqLPMtYuQjonuL1S1mZ65baI/U5IZIrHukt/hge9PlLj4krVg0xMWG1FhW0QWdxK83yD6iuzhzcvlLspiZZPY0YC1VF9CO5bxILTRzkwescUzya9rysYmmvHK8yhq9FmWAY79flbv9OaW6cykg/kWM+WeDLlHXok0XrTBlA16ud9AQ2BYI9Bk9h/YDbqFkNvPzkOiYdIzdMPF6nVEYFRZ2qSWBqoXxtvLVfTEWppFQuLKDmAruoTNhrYfAp5RakMQSXXUu8hDiLkSWfv2YRlAWnejZwBj/bdgCoorsy01vZXYG25RI/VciXg7WZryIGwRG10yL4BRcF4qb/YX16SEjy5OVlWOud9b+J8QyJghK1yoTQNornlwSTzK7GfjXHJFrqNgRWAv4ZjUm9/NYsy4KcvfUNip0mRBlbygcC0wAR4/EX2Z96a0q0EkHnjX+BGpqNHHMSXHnIRqEPiYKHu/FEXHstTOe5llQGPwXt9FpvGfKjubSxihzSBgIdeG3/Yi9Xk9/yTWTlEoHt0e+Q1LE1HOHig88xQYL04JEAVwInv/nS4CAvl+Lz6qqNo8fIdXReo1xT5aZTYVdwwfGiLjoaW0LKfvwvC1uM68B4xCfzDbOARWsFMABgk9tgcp3KAPTDqvGEfW63Lhur6MOJ0V5xjyx24FEQIFc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(4744005)(44832011)(8676002)(4326008)(8936002)(41300700001)(6916009)(40460700003)(81166007)(356005)(36756003)(54906003)(2906002)(478600001)(316002)(70586007)(70206006)(336012)(86362001)(26005)(16526019)(2616005)(186003)(7696005)(1076003)(36860700001)(82310400005)(426003)(82740400003)(6666004)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:03:14.3218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9c1edc-346b-4f74-1342-08dad26646e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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
Cc: James.Zhu@amd.com, Leo Liu <leo.liu@amd.com>, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So that uses PSP to initialize HW.

Fixes: 0c2c02b6 (drm/amdgpu/vcn: add firmware support for dimgrey_cavefish)

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c448c1bdf84d..72fa14ff862f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -156,6 +156,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 0, 2):
 		fw_name = FIRMWARE_VANGOGH;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
 		break;
 	case IP_VERSION(3, 0, 16):
 		fw_name = FIRMWARE_DIMGREY_CAVEFISH;
-- 
2.25.1

