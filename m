Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC380C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 04:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9998210E454;
	Thu,  8 Dec 2022 04:14:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2ED10E453
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 04:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdiB4wYPaNHjSzzKO+WqA0ftuJi2lkDTep0vn/IYMK7mZ1IUXYVpt2vtgNmkVpvSFBWDkGqZicz5Ctltr3Dk8Zju0HgPtZ9apgj1XT3zR+pYDDKRiFEdgnyoX6m7Xv3nh5xSWNOHv1XU1+Kj3LOjGu66PyBdNpMQMGnt9MR9juZQd3NoL7RPOTUPTwfSM0BrrQB7Bg9X52N0UezAP5sdU/47sUQleWOYQZq1hWwD0PCye8QJ+XWAV/SIdqdlk4scJcGjosfYr6rSEvoqN1D59R834gyGUC/7KO7nHLXs/GjN13nXtR2gRr0gB4k6r1qiMIC8sVZL/o6X9ep5VxJROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZJIH4AoNOfgnaWCHyT6PwybNh6UI4quf/sdtMdAZ7A=;
 b=Fel5TSoVa4ZM0t5VohfMPoTL2+itFfCeu8Ys9YFKWLMfGyUxLFlR2isdrwpu3niLk7ItHhWPNIU3MWVhBZO+vh1d2kCGfcM1FcC6RLZe8zZA4k7VrODgBxTPHifNGdHEsoqtBVwZBhI1WoBXVMPnOB89CjpEAMIv4iSFxsyVYvcuHWBV/qA4GL8JBAinM+tMZNX0AcHRMgDnEzG1ymUbpawtcCzXy5xhc79f5FH/aT1MsNQ7ukHCw/WtTqIbIyemmsvz0DXK9aTivG3rmZ+KVz4fy8F15Lk04VsRzv++aBlsndPk6J40YYs6vHLJKMXtVMe0jPmJVVpn+TKAQhmOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZJIH4AoNOfgnaWCHyT6PwybNh6UI4quf/sdtMdAZ7A=;
 b=jlF1DGrpEGmakkjbBmTLjoX5MFgRWQDX/2tuQ5uE6RlHVV492LCL2oc7rC0VrAvZ/H9KDRjWUVFEIdwVCq00AYIZBhjNvZaz4Cj6VX3ntWhIrQJKEqRGx1CEFiqTvGN1e1ljkrhVUrzJDqKrmzMyqW1rcmcjwry16HIyv2dVAQ8=
Received: from BN0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:408:ec::30)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 04:14:27 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::25) by BN0PR04CA0115.outlook.office365.com
 (2603:10b6:408:ec::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 04:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 04:14:27 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 22:14:24 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add DCN314 display SG Support
Date: Thu, 8 Dec 2022 12:14:05 +0800
Message-ID: <20221208041405.3992585-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 007a4926-adb8-40db-7b2f-08dad8d2b23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU7Ywd8oI+Dm8CLoLiDLWoO3e6vkPWO6I/+4tZjgHOnklpTA9nkopCRe4FVTMlgqfoBic4G5wjN7VsvES3lSjXEHpU1+xPwpRCE9GNBj7+h1JjZ6o9DBH/yByZSJUuR94Funwl6q372obx9BliJDZUZVFiRf6DAoNN1GPYd8SwO0EtC+A7Pid/9lbZt+N7Tgl0sZhdeBbuh1uhGqr6IsxJC5bAHnQ5/20ftx9TZClU7w/kJbflULD3bQbO7Ir+wdi8EqmzyOvil3ygcyU/mKjKAqI22zfnVUh0nkPJUGGPMDhPbgV5ukik4ZWNLRIqrqBZYpQGSiFVcntQ+XFmMqWYur7GN1bwuGFJKqQ8WCtp24RgqifKJLVqoxx34kagPt1RvR9FJdeeB37aidCVnR9GPNEey6UHEmx4k4xGrD8CVb34nd1/H2MIzquJWXS3/LaRHnIQdpShZELW3+cHpwVb2p6kUckkdBaEf9CZoewQTuMGALIkSzdB8NliS8pKeqBEwA5t5I+ONmcej7ZOj2L70I7MqrETS0j06vINpkfFlOso7d8/VLLcrcKYpWDnU2MTIpTyksQaRfamC2m6pngcwQGsLrayTO0bXOzHnCPF/NNnsEwkwbOqbIyjhYm2Z85z+3QTm3ooOxXkzhzDkNYtfiogUNOYQcO2TMarQNERSHV/moVuoQbhrUmG+4sRxjmkFxQI0fput60eddweOoZRV1NK9GWWDsGqhZ0CGmY+w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(36756003)(40480700001)(8676002)(1076003)(26005)(6916009)(47076005)(54906003)(7696005)(6666004)(70206006)(2906002)(336012)(86362001)(426003)(70586007)(36860700001)(4326008)(316002)(186003)(81166007)(4744005)(40460700003)(2616005)(8936002)(478600001)(82740400003)(41300700001)(356005)(5660300002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 04:14:27.0917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007a4926-adb8-40db-7b2f-08dad8d2b23c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
 Harry.Wentland@amd.com, Roman.Li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add display SG support for DCN 3.1.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0f391a147354..6f1e5f787af6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1504,6 +1504,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
-- 
2.37.3

