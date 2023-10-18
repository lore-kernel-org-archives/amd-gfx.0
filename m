Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4F8CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 12:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E49510E3E2;
	Wed, 18 Oct 2023 12:39:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4586B10E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 12:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C54kk1F021AYSWNvgZeaEH1/Md02MfVJGHCCI11SQkPz0LmhbtriPG+0T49KJSXkiSXBel+9QVLr7jR7tWzrYnyCmc9gSDoHKmA79yjREdNz2CAq6vGQmBiqexoGGnABHP1zlzxMUr7HUlHjiLMazl1H12cNtf/Wnv54AaT2QG0wosbc5zkOlmYXSxNE51Kba0H4Oe0iqokoGSzOlPp4TRj2jmRzzPk4BXdCc2BuIr9EK47pByROdzC1+NEyYH9mcFoQY359xPNTfTWUdhy20Q1ME2+DQHYumObv6w/J11KaqkFaEYogU81pgp64LMBrdKoxFPs70KW6fk15my5CjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/B7Ya3XBMh1hpHfh5bPc+5UE7i80LTi5BL8cqHaXXw=;
 b=d24y6Vnur5bm/e7RynpgFE/lkt3Sp0s07Z5de1r8B3CDVlA6g9BlXb4YzNAz9NbN1ZwlqCD0mBNFZRlLRURhFmnnbvkRfyA+S6/xUcMR04EhVJjC5vLw7BwkcOGHfDVFHcRZSZUn2Hm7ekxGkFHYkdREqdh0ckMmwpH5V2kPUkE22hloeSQ0KJZJmwMdcw2PY2zd66IpdzVC0Rnjd4EFXb6PIZCZ4ClAX/VthF4O9d44BYae/+9JgLea+25EEyuZzyPUyjviBsHp4y6awQjV+tVoBpKfr8hkB/eL6+ngBN2IFLPxlE2lXzX0F8taPWXfFysFA8T2u8T3/UzveeQruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/B7Ya3XBMh1hpHfh5bPc+5UE7i80LTi5BL8cqHaXXw=;
 b=DRW9rz0qZ+lkl7JI0AGFztM8sne2O/S7LElxae3xx5lz2pn8ddt0Bqehw90ifhajTji6YlIW2daot0uezx2s8CA/6ZjZTsvzb6Xp4yyfW8OwkOLQ6Psg08VUyORI2nIx2xiQO9tTdRnI0BBKsTN42QqacEBU0522qttzh3REzGw=
Received: from CH0P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::7)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 12:39:12 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ea) by CH0P221CA0029.outlook.office365.com
 (2603:10b6:610:11d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 12:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 12:39:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 07:39:11 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Wed, 18 Oct 2023 07:39:10
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>, "Tao
 Zhou" <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable software RAS in vcn v4_0_3
Date: Wed, 18 Oct 2023 20:39:06 +0800
Message-ID: <20231018123907.14772-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fe3122-dc94-46d9-f8b1-08dbcfd73b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjaIu3/FGKXsruYBWPlvZbV9uYYBVcCPbUrcH93QAGpEC0sIJCXIZfk7q9C7sZGl1Xz5yBUmB+HQXWwSdN+z/ARhoQaRIMyo4N8D0rdD+oh/Rtyn/sJgRWhGm5mWMCKG0Z+KU2HPz4vM6RIu6EfXtAwkyyH+VLunI13hSHyVzFM8W0XJoA6AgbYSjHaQiE4AUS1zABNSkkuqPoAG0QhTLIABwMk6e6ZvO6QvURPAQ+ER3lizlBOfFyIczoVmmvRAXdDhwSsXhQAjxgT+eaDW4U2SezOQJvRWaDzOen2u+t58mDFH98PX7Pj2+6CcpFPqGKCJ40ZFEEEvcB4yxC+xegiX4MkR/hHpU5pz5JkvAjZYMjZ+TROPdN6XYLQboSs3xA+IEHFejbiFeuFdUZj9Sh6qAd1zN9q0nacbzHWRLa+/RqIxYStJei6HPe0ySnzOP8rd1kN1LwbMLEcwP6JadlA3twgHknqiyU0a1z6VedEzYKyn7GDNJRNCSPcsAqi5CBcarCOULwHYw/VFS0hHYiPcJlYhCnrHeIGtaa++Ww5ZtcJCjfVtqt6hchbi6uQDeeBMDknMSGY8mYQEECJG70BWKBiXB9ghrxsAet73SZQAlPJ1IIBTCRbQajQQXhaPrCsB1Mb8KOs803d1g7k65vndPmZIVgtolxuHMd5w01V4cc8/N9X0QDkdZSLyWmviiuBXFIjej10Cy/N1eVwmYRN9my3GhY/w5CzpCrb3Hhvb62+ordxeEajmeUWXQltkKDm6JB4iMXO7Z6O0AZm5jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70586007)(6666004)(70206006)(110136005)(36860700001)(316002)(478600001)(6636002)(356005)(7696005)(83380400001)(86362001)(82740400003)(47076005)(1076003)(426003)(2616005)(36756003)(5660300002)(336012)(26005)(4744005)(81166007)(8936002)(8676002)(4326008)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:39:12.0551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fe3122-dc94-46d9-f8b1-08dbcfd73b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set VCN/JPEG RAS masks to enable software RAS for
VCN and JPEG.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 973073e07b2a..7de1eb7c959d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2606,7 +2606,9 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 			if (amdgpu_ip_version(adev, VCN_HWIP, 0) ==
 				    IP_VERSION(2, 6, 0) ||
 			    amdgpu_ip_version(adev, VCN_HWIP, 0) ==
-				    IP_VERSION(4, 0, 0))
+				    IP_VERSION(4, 0, 0) ||
+			    amdgpu_ip_version(adev, VCN_HWIP, 0) ==
+				    IP_VERSION(4, 0, 3))
 				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
 							1 << AMDGPU_RAS_BLOCK__JPEG);
 			else
-- 
2.17.1

