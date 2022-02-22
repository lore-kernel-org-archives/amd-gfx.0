Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4B9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 06:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437F410EC1E;
	Tue, 22 Feb 2022 06:03:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F6E10EC1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 06:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa8lQlpfl9clgvMkf5TncKgZ+jmfQLVl660sTh7Xytdx+ZsdOb8oegZ01JrOJWeS3htrtphWkuIwfT/KrTgCGEXiNBSsPQ64nqhGwkOUrMNYw6TubguXNEwAm68N2j6eV4usgwbYNeoXfRoa7JE1H3ePx3ykh5/RahKNGG7qjiXMSvQCjcPnQTmJe1rDX5QUY7hp8+pP+OLakQqW7SH+9/mBdsQDm1cOfE7t83yX/jwYvGMkhwZEYPdj9ESYRVrrOxwobPorlzqgXYAvs9N+3Q+/yxoYfn6m2yKOuTJhexWUYTLUHkAIMal+OqNQzS6frNpfhRQfe6mo8bIQy9rGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLvGD/i/ENBiC4M0C0lLfSFanMix+V5G4WCltxhIv2w=;
 b=jmrW5ILMCNp5oa8lpy7uGMaslM5DJekYcnW5PWDSAvI+v+bK+dMAYZjgSFdKf0rT/4wY4qNsXBz1KUNf+Z47U8n2ncI4j30YZMRJ/Jb3niXU7rtxj1fTXV7S9zpsUt3rSfzIckutRWqhlt5YS0+b/bhVlB8CTto8/MU8s2QKfGymh0a++TeQ5sgCNy2qFHvGm+utL7tblbxhUcQHszYKtEchMcbXy5FPTfNVE4sOdCp0CAnNoRrBGHdKd1+ZC799p5PwW8Y6MCv/2h9kSOKCyVUudiAANoJB6Yo06SiY45sAbTH+4oZYmWAX3EeXTqF9EvhwxEfLRI+so+BssSGcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLvGD/i/ENBiC4M0C0lLfSFanMix+V5G4WCltxhIv2w=;
 b=Gow5elPqN98A9PnpGUHkPPU0YpVnJakfw21TXha/aLXIlKPZyi7WS8h/Ay8eqSg2dOEI+sSZvgy6zmSczqbHOF03rabJq6igZIQ6Yhiu12ERYSe3HW1eNwnbY0LSG5hF9wBV/go1HNZzUXoHArR6Lv1ymqnpVbmH1/W1cI1ousE=
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by MW3PR12MB4585.namprd12.prod.outlook.com (2603:10b6:303:54::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 06:03:47 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::97) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7 via Frontend
 Transport; Tue, 22 Feb 2022 06:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 06:03:46 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 00:03:42 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: add GTT domain support for dcn 3.1.5 and
 3.1.6
Date: Tue, 22 Feb 2022 14:03:13 +0800
Message-ID: <20220222060313.856546-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e114de1-4013-41c3-82cf-08d9f5c916e7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4585:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45850EA45EBE6CB597006CA1C13B9@MW3PR12MB4585.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GV3gw309NsWsHPIoiQ5dGyjtXq+2I/SB3bbLlxaie2JZqwcJStTL2+xHQw4OpRkzvlHZTs6XEfrSESQD4nGBTobfYduUiZo3YssJcq9QHT51w3CyhNp8aztCIf6ZXun8rEakaJhgPBMw2mF1rt7O7VQTz8PXtyprFIR/dyYcSFfTULTK8rO9xKs5KmdTmckILdNNBEcToriDZ2kKiyqQy/leSZVj2DuCYeifGlNbSSOP/i7VngrJV9zTFS+JqNhTR6qStGvVIBJNeqBNFa+r/wH79qUfRRgMWQTYkR5Bv05t20MOfPRNEnYPlKGX+YXFyR8JNJI25IQE7KeDnG7C1W6c4wRxxZh41kFDlIBrjJxRg0xekDU+UgOCsAejRWJpstxAFJVN1CYsOA3DMiIYxqEZkrxAUUVQG0/XFh9u1nF90fYxGRlZus+AjQ6b5i5Tt33web5GY8+7TKYVOfNgXdOFLUd6UHnurHKBK6ZiGwchoNSlHh+Z6b2Qfrqp3ozypwJ1dstiFe3X79+4yZzRA25/kbqq1KLf8bzD5si+CSplKiTZ07V0tRT2SsUD1g+OUtUcrVegAExFEziGp3FMUSS+8SZTPMqLEr5bQChEyQe4zFptHFhcPi3xn0ATDs8Plzg12ZfiSpAIXljHP1g6F9fvMftKcXYuLna477IOdnrjbUoZ9z8N8oirkzeho3S2Tp/U5KcqQ5BMgtdvsAxuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(1076003)(16526019)(426003)(336012)(316002)(5660300002)(36860700001)(86362001)(54906003)(6916009)(26005)(40460700003)(36756003)(186003)(47076005)(8676002)(70206006)(82310400004)(70586007)(2906002)(4744005)(508600001)(4326008)(6666004)(7696005)(8936002)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:03:46.9263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e114de1-4013-41c3-82cf-08d9f5c916e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4585
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, sunpeng.li@amd.com,
 "Tianci.Yin" <tianci.yin@amd.com>, prike.liang@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

this patch adds GTT domain support for dcn 3.1.5 and 3.1.6

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9709368b4915..37f4da219a5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -523,6 +523,8 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 			case IP_VERSION(3, 0, 1):
 			case IP_VERSION(3, 1, 2):
 			case IP_VERSION(3, 1, 3):
+			case IP_VERSION(3, 1, 5):
+			case IP_VERSION(3, 1, 6):
 				domain |= AMDGPU_GEM_DOMAIN_GTT;
 				break;
 			default:
-- 
2.25.1

