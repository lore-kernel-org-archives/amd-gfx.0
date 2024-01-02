Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2837AC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9464E10E19C;
	Tue,  2 Jan 2024 14:16:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844B310E19C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx8qF2716ogD7fST4h+H2PREmdJMbMMNK7KhOr0VlajHxefyypQ3D4P/TUVfMPMhAfKi3TlfUVk3/cBg7LIUp+533mS7Zi/C2DRG1gicGS29ofrqBfrxK/Pyvmt0OsHCy7IiSHPEE7o3oVOxHYmXxXVU9qEAaJ8KtruDTJupkSLqjygoKIFEyttwnNkqqHAiMtSIoEzCe5h6O3oSwNUj9RpcEDuNgPEE0Sf85bKn4jHQKRifPMwT0dQLaKEt5DY9twmngsaAyjSDXv5OaO4745l6tHfEhVkbw/exF/UDi0ieBP3FsQy+t6tJ2rqZbwmSl+PBB/to46PkS1aWzUszgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AaTbFDK/6t7Q/yTEkc/ZvWnhUGVie7G47wJH2bjZ6I=;
 b=Oin0QUrQtPaPd+RbIUBPXN+7256OYfnYZCfCKf8TxyDCWTSyM8qQ8tjTCFPCrDBruIK+/RYD2A93EEiVMqM1526gPbzjgbwfB2zJqdZ7X/hg3kMisZ1YJ/BQbOzBiu/2h5unWqzBmdK9GMAWkv91BdZvVBwQx3qUR9TuWbCoh5RiS+1sBeVglIGKekwi9xFwV4/Er6q38yomszGZ5jI7l7p01W0qcToPadyxcrGu4cky3cscTa48VZudeX4mQgqDVTcIYRi3bmjoczZQkLyuq0AFlrjfv6Tl2BG/H3G2VqLahf6Gp26TiazYm5slFwwgzEpc2eV1OcER5BKL8Wxk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AaTbFDK/6t7Q/yTEkc/ZvWnhUGVie7G47wJH2bjZ6I=;
 b=ZrpbQI+KV3tXqqczk2KD0Clq0d8Fr3BpSgkO0LX+ThveMIm0OCQYALqtCnWcmGY7TMq0IW9d+13tCppyQ3OFQz6+N0LBXCjufXMgXQzw6V9ROg6UYhRfcpXgxiVofodneAWfqBo9YANa9yzJbSlY7o9Zug5QPcpSe4c87VBnP0w=
Received: from MN2PR17CA0031.namprd17.prod.outlook.com (2603:10b6:208:15e::44)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:16:29 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::c) by MN2PR17CA0031.outlook.office365.com
 (2603:10b6:208:15e::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 14:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:16:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:16:28 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:16:25 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Align ras block enum with firmware
Date: Tue, 2 Jan 2024 22:16:16 +0800
Message-ID: <20240102141621.29700-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fc2547-1336-4cec-327e-08dc0b9d6960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqnB/Nj22Cp6N75YCmpfcLen/8QhKbQuocDkN3nvYDPPNPDgc4BPzTI/QUK3s/7vWpfVUoZCL6wN2UJHkk/SjlH1ncOP4qPBzthcQHx2MuXh0hzlDdqlCE6rkLhhpal42ZL6RhJ0RMqaiIx6aJny/RMHQMUbDipPrnriEpDX/F78RlhFhAeOiaOtuNTlyQNyx/NDKdSGITZycXM5HgPFH3Dq7NTP64qQi174nIJjZu15ueM5Bo5VlTqYPp/6IqrTbM5i2ZIVpuIr5ydO6JYBW5sn96nWWRUvWjCl3DaaiGsiXLEhgfFZL6rePm8m+HSUfifeFYFxzxw76GL+OIpzd4hlx3LZCpU/M/d/tVTKAs4R+LMv8znHQxt//oxrjqsnY0OdJjAHF7axf7SAa4iUJtdlAX7iClXZSlv4rCy6iBpFJMKYFuQ8MI3mDE7KjYr+/2Z/1fMQFyrLdJdmc7/yLVCFzctiQ1NSe5Z2nALIJxtRurBJ/sLEpLJ/XlcJUFonrOOOSlW3jYeK6l8u53KeJ7KSTkP3Dd9KtrjBAQWQ5w7RGDB0EWMoZhJZsGzDVZIhGAJ62+ET742lRZJYEo1zxheXEvP2j4V5Txzkc1AAimLkitlNDs2Qmqs/EUFQgedW2eNzyiqsvpjtW09c/ZyyGNq72anwvu2S8X13qfPbAkIkHWQK02SWR3i5IOe1oAM1Mx4Uimk8PQ9g8gaBofsTBKoc7Cj/olUHi7g1dG1M3xhmsLeac3tlTgyswMgiWXXX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70586007)(70206006)(110136005)(86362001)(81166007)(82740400003)(356005)(36756003)(47076005)(83380400001)(336012)(1076003)(426003)(26005)(2616005)(478600001)(6666004)(4744005)(2906002)(6636002)(316002)(54906003)(7696005)(5660300002)(36860700001)(8676002)(8936002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:16:28.5138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fc2547-1336-4cec-327e-08dc0b9d6960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver and firmware share the same ras block enum.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 5785b705c692..8b053602c5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -70,6 +70,8 @@ enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__MCA,
 	AMDGPU_RAS_BLOCK__VCN,
 	AMDGPU_RAS_BLOCK__JPEG,
+	AMDGPU_RAS_BLOCK__IH,
+	AMDGPU_RAS_BLOCK__MPIO,
 
 	AMDGPU_RAS_BLOCK__LAST
 };
-- 
2.17.1

