Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7046C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44F110E378;
	Tue, 22 Nov 2022 05:52:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F8310E375
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0w24FbDWICbYHV6vQL5SZS2xahbwCL9mZyfpKg9rXrzaUSxa/6/VpzN50GV1IEYO6ZKLkQXthRsVR37BsiRxR/1zumnQ2k4o5kmJ2LARTPXbKcKm7m1nEShLyRkaKwts0ldEFs02+F2ScorNUAw5FcExLHQroSfuWMSbpcSa/KXXSowmIsWE3ke2chAFYNsRu7DPawlnM0Xyacc80v9Wm4Yu/09+01RhO36XT3TWhWX+okzkzS7ESBKn7RLjNBOxiTGNx7MyXdwkYbpNcBOWg5ZVAYeDS8HTKZwP1+slG/o85chpLUfl4CLbep+kQYlBnTQg3yVCXdOYPuq3du0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ltoZ3DCb9i9LZEdXZ53fnfCwoMmquEFRxdHGnSdQpQ=;
 b=CGFDPFEKeYkwXYJisIG9w8rxSohIZecLm40m7elEl7q/wHJHZB5IzIGtBs+NmqoKXoKoUwXmtAUfCvCvlIn23kF0UJrg4UmHs7DLctzN5upNlsLnx1mFrrv0VPLX44iyQ4GxJki0TfKZ4OQWF/yO+Jn+k53Sb2zkbGr1kn85avdyggbKdZ099sCoYLqvD7Op1Yvsgky7DbttdLnyUEG8YwqigurJMZvKJXFPRtAWwLla1u1sYbjTiNnPHgPSJvZtvf0hYN8xx5YSrIPNQjq+vzqTpMXQ89KSOSQm4AQy54J1tr0v5+/tn/s2pdHICIZxadgaq38z0kkBy/ka98Bihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ltoZ3DCb9i9LZEdXZ53fnfCwoMmquEFRxdHGnSdQpQ=;
 b=stwuujafhD47WwjUpCigQT+3WSWW3d5OBx45q6haNfuMuarqlWUJvbvBK5BpbWcVwk+6MmrhTYSDQqBuRM6pGe8CHynUqOoh6nf63hVtafLMCi3cD7hBZB2NJjzsljFwaP5cGY5gnARu0jhxWSoDpZaF7GJS+JHHvZmsxoqvbAs=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:05 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::12) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:05 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:51:20 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amdgpu/discovery: enable gmc v11 for GC 11.0.4
Date: Tue, 22 Nov 2022 13:50:08 +0800
Message-ID: <20221122055025.2104075-2-yifan1.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 168bfb3a-831b-4ee1-9ab9-08dacc4daf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXDjSz+z2dY7cIHlY+EkpdeTroSmD0ziBWIF9t/PYi8GFg7rFByEJNMlOyP+d8UoA0A43tTGPZ+JLU6Qa9SM9j7HW9RT0TCNIFKAYl6TB57+xQMTh41N99CtRF0ZpdgxH6CMrKebyQCTemmjXk41IgPnrugGIJ+r2vCRihI0JJo3D2gPC/ci1U1V/OmMTmhNuRT4n8KklSI1dW6B9dQM2+wcsa2e3f9ypSv/mNhvj9kOVHCNc4hTOkCce8bM20fsN3Sil3GlOeCcfMBn21kpvHYSkPEfjvAuQRy10E+cXf+KCipFuVq66v8zatIoMF+VD18xSwMz1xRKSRNq4CdZhW6rqOTKbcS8CyQHhxZDKl21WvK5V8EmasWrbVVAYACkrWZVucMZryf+6eNI7EbQd9H80nnlz+1DU0D6rEbltimCI5sqxW8tBvyWa6uxC6Mq0GthRdi3qh1N9ZHQC1NQUX6gXWcGPut5v9NIUQ7nzA2U/hlsuhryYLeKBq9N0+k3H7tXUSS4DUh/4vq2vah4k6SnArtO8g7ag3+Ea22Rk6N/uHMMjyNjgCMq2JQ25+JGbNWosZO8sFImscsLq/DJfeZ6HMBch47A+VI0sZEiBBaZGX0i+5326Azz7RQrlBvsxM7kPAXmFiogA9xkvzHLFU/6DgQhUrSFkz5+mfv10lBzRcZvfMg2s/8ZGwSScXLzL4LGwR8fVHDxUoTTtwqPTsTR/ClDXR3j50VPrb1xlu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(26005)(36756003)(2906002)(86362001)(82740400003)(83380400001)(8676002)(6666004)(81166007)(40480700001)(40460700003)(70206006)(4326008)(356005)(36860700001)(41300700001)(70586007)(6916009)(54906003)(8936002)(5660300002)(4744005)(16526019)(316002)(186003)(336012)(47076005)(1076003)(82310400005)(7696005)(478600001)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:05.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168bfb3a-831b-4ee1-9ab9-08dacc4daf3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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

Enable gmc (graphic memory controller) v11 for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b8db6184dcbd..a047db7f8ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1557,6 +1557,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	default:
-- 
2.37.3

