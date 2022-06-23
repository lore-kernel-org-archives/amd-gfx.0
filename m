Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5762C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 16:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9E310E080;
	Thu, 23 Jun 2022 16:41:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D18D10E080
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 16:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np7MeXvNKZe6LIY/2q+9WsRT0Sv82aWjinN5lkh7J011KlZU3MFYE6IscOCMagEDCYsgw3XrX3s0NUT/56zBh0sJ8Cox5kH/ASOEDXMJ7Gdo11gin9aeZbYLuqnqCXOfvgU+PvosjVP4gmMhpt1SqyL1Z7ELsQXo6ftvyt2Fq7ZG68V1JJPf7TK96ZIMvpKQoPxy64+NzAMvXi3XsZsMoaNQY8bdXOTAvK7pOtLv95q6h3yEvAG2dpkzlNBofLtc+DlO6iVyCW5+k8HlE1eP3UuE8XRP0Bt1btR4c2Xn3Yg54P+ToBJrTgSKFxSuM1COQv/74zo21c8H/a52h/qirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6hnboWVEyRY8B+YhQgHREvGtR0FBwMqzC2R+4IQHaA=;
 b=Fk0MRuCZyrWOa5o7/TfbChvKBk++xHahTeIoazNBOE5CRotY9VyWgxUXsPaRPzSIJNI0JNopsWZCNX+GOJW5S3vurtYJWG5gn/mveJSM0k3xDkzIxXGu55C71+h9ViuE9cPQLqxxZxEu3sqNNVsV5ORO2uz4r9Ri1QM8c/rYtp98ohagfxnSXabaWfXOsczYHa6jdmtnSiOqLozVd2FFNbtI9IS994ZiilkIOqtKwZrwuZs9AnA1vt5oK0FKbl/VrNyH/JiZ5S5DfX67o8xd/MhXDB+UiY2Z29uao1g2Woqo04X111voGhYe1OJ2zrT25S2GrWiCERf6pmIlw6zaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6hnboWVEyRY8B+YhQgHREvGtR0FBwMqzC2R+4IQHaA=;
 b=GJP/mQ4LZwa02vNMChKNtKqdFyAevna4E4VixuWBy1iZvuUZALKaqz23LnGikYTENbYPcO5covRonOjuTkL/ySuOXqxdHd0W85EiJOGrSLE+I42VWH+nEDL1MnftpnIYYFtJ6KM7wRqrt0Fq1n3NBm5JH5vW9m5io8luiyV4W0Q=
Received: from BN6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:405:70::22)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 16:41:33 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::9b) by BN6PR12CA0036.outlook.office365.com
 (2603:10b6:405:70::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Thu, 23 Jun 2022 16:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 16:41:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 11:41:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix documentation warning
Date: Thu, 23 Jun 2022 12:41:13 -0400
Message-ID: <20220623164113.1503249-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623164113.1503249-1-alexander.deucher@amd.com>
References: <20220623164113.1503249-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17fb3a72-62d6-4981-ba40-08da55373b1f
X-MS-TrafficTypeDiagnostic: IA1PR12MB6116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWguuqIOUF4W74qmHQOkOW9BP4vxSH9cBuUUM/N3GVSAYXGLAVuvXkSdOBB7QxjS31OjwU22wf+rioA4mu3qO2HyNmKrqDAi0nP7KCGd+TV/jDFbXwubF08WT8L+MH3lKMICnohiBSQz67rJN6cqcCPrzTx33Hyvu0fSe9WdNeALgroth79MkUiTgjptalg4/wJeJt/y/KAVOvFnjMkqpTYm5VfdBziNE3Uzwp+dL1ynS7WACICVztEhQ5FmHsNWzl2MfSoyqkgTbPG5mujgilQtUSkX1yOxWhLR6kN6MKav2oRID8rfObUBAZTDvhh+uTuI602QWAMAlMo8/NmDMYOqAZCYYTQp7nUoJiKhALep4RzuP7QFzqWsJR8LsNIx8tBggi9U5lzV8do5gcUneWNiFKeLbxMUMWXtyPF6vs/Jz/7VAgAqQwwpjYAZaj7YJZCqIxM6zDVHNCWeH8qHJIruZltILWTFvuFvPhUsiWIvz46mw5DJjZ29faUHUjGUW6Wvg7qQSLrpWpdFX1F9aYGwJ3/ngsr28OdPy+MzQbJIEp6HonLwRUOpj/GExShPXJV3VIStIkyTdOC8ZwVB1AD/u/lQUa0tkLmkexwQ2flpj3Nv8+9d6F8+bWd5P5GXSwdNW2Q4ZSvIpUANYrAKHDEiiKQg8I+LnV8vjVybarzHzqmTfnkG6UClR4rWyAdAEwIwN5+j6WZXOjCtjsTICX1o/3udSN5DPxj+zISVAlXJDY4RDrITO5eWQ27fJa0DWNmyQD9zc1wlSzR7xhV3n9s3cJxyxMPy7Lbqcq3i1Y1+pf+swFeRwZVfsciRfFI3WdSum0r5nzVBOPlzjzsGRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(40470700004)(26005)(81166007)(40460700003)(5660300002)(478600001)(7696005)(86362001)(356005)(8936002)(82740400003)(36860700001)(40480700001)(70586007)(83380400001)(54906003)(41300700001)(2906002)(47076005)(186003)(2616005)(82310400005)(426003)(336012)(316002)(6916009)(6666004)(8676002)(70206006)(1076003)(4326008)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 16:41:32.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fb3a72-62d6-4981-ba40-08da55373b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes this issue:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5094: warning: expecting prototype for amdgpu_device_gpu_recover_imp(). Prototype was for amdgpu_device_gpu_recover() instead

Fixes: cf727044144d ("drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to amdgpu_device_gpu_recover")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f2a4c268ac72..6c0fbc662b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5079,7 +5079,7 @@ static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device *adev
 
 
 /**
- * amdgpu_device_gpu_recover_imp - reset the asic and recover scheduler
+ * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
  * @adev: amdgpu_device pointer
  * @job: which job trigger hang
-- 
2.35.3

