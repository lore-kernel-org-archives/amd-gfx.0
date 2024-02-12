Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0232EC48BC1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C4210EE7F;
	Mon, 12 Feb 2024 17:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+ZdfLy3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBF810EE71
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoQGBxHCsEmWk6N81eE8CN3fKCh3LPRzAkGbTKRqHwPkOFSUSXjHyGYHK+wjSnf0xSYHmwssGsbcp5o8U49sFMGRBPerdKLfpma6MrRcZD2jAHxsy0wM+wU/ua+1j9rZw8dZCASik3qDRXZ/0s6jG4udXxCizPeNGTyqvuzdJ5FUALEgmWDoRbo/bjt8fE3CPv4inPh45d0m69f2SddkcbRCZEhY3hgybu4E226NI2BMmCulp1wiqGv6ODgX+4PH6HcdSFrgjqZ52hQSGmY13tmVCLhwBGPBHQTJ+jMHKSDMqebInw3Qp3tLVNk7xIuoCOnr/UFGl6er3jJI1k1OgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZsPY0G+UitIBQWi6ggdNA9T0jeX9EMh6CiGAwhFxkQ=;
 b=nFMrh95Dl7g3OLe8x2q4UAk4zLSv0+GDAjVFWD9tM6TWr8KDrcXEnrdYaJXW5UpqL0ZBZMt4kh1zzPS+bR47sa2hsK1jolqpsdD8WHzqeswYhcDo5j5H6zeyKx7p2OHZ6XPeEfJsvRfQECQI4wJtDgclGPXe9R37rvqlWS6zbcLbhDyTIvbJjrE6opbPGZESq+MYA9VUk4L2lx3R3YUq08aWIlWecQRW8BVGt1AWjDTd/PXXDXOkG0fivqpEJ8n/4h7Mg0eR33F1A5NBPZ/QrLBhz+lTe2+OaiNlhf0Jr/anHueQBc/URMNyJkOmc0vbIsTzDMxbPiOBGhhv6yVxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZsPY0G+UitIBQWi6ggdNA9T0jeX9EMh6CiGAwhFxkQ=;
 b=z+ZdfLy3sX3mkt6c2MH7V02IbvE43nZguqRFydvLWnnra/TZsjFsXZkULN+glgyXUQU0Cloj2jo+MfG1kVN5yGRJ31rdB6ZpjOcWCN5uxlduziVEEtgH9zzUUFc3McL4LH89/2v5eyeCucWZ3ZG6vGte4UuPW26AL5Xm6l2VtXw=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 17:59:09 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::1d) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: add psp_timeout to limit PSP related operation
Date: Mon, 12 Feb 2024 12:58:48 -0500
Message-ID: <20240212175849.433812-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: c56150f7-f620-4543-a88c-08dc2bf4501f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNp6xiktnsBq13yzPOmFQZeLJDo1Tj1GnF5/vRcs7QJn8gQkit4ZV+CM67WLvi8dRFfvS4mmDgORHDnaiiUZhCNhtFJRvixK8X3wVNTs5LloZjpK0fazQztCDSw9UQV8Om5Umd/6Cbfhe+RQTrXH0rl5fdFt2LJgqtWioMtBAaxjepYGBr3Z54fn0LWUJyqXlH7Vu9ehzHVl5zDHJaGkwb2B7hWKHsFiMDj06wt1fGnPddT3m4GHfQ3TeYlQjT5IrTsQk397ukAM4bKlIva+JJEhYcgDpanZ1HB5EwdZ4Oz/FEcIKb1NHqAk38zVzxewLuZsQJVO1EmDib/EC5OvysZf6ik2nZunXhAXGXP9d8Y+koWlgTzlGOQavxSbDLLQi+sgJegpXkrLnBN012b/Uyf+dKL1Uj2KPmSEB/NDlzZts4MOUBQ9xb+gmlP4mfTWsgJZLI1kcIAzPitMd8AtZyLrdZtWLen6w1NADQDXv3ibV6isMIBDHuJXueCkhtSOWqxPorRJHoZhggXE5aMiFKyA1K7SAdX2tXSE4Co3o0ebJSeNbibJgrjAHY4zcA/HxU3pKG8D2RfhB9neTkhJfo4gKO+z8e74XtmlrcZ3uYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2906002)(8936002)(8676002)(4326008)(5660300002)(426003)(336012)(83380400001)(2616005)(356005)(1076003)(16526019)(26005)(82740400003)(36756003)(86362001)(81166007)(316002)(6916009)(70586007)(70206006)(54906003)(7696005)(6666004)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:09.5253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56150f7-f620-4543-a88c-08dc2bf4501f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add a new parameter psp_timeout to limit psp related operation
to unify the timeout limition for psp.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a3f12bae823..d105e4084ced 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1096,6 +1096,7 @@ struct amdgpu_device {
 	long				sdma_timeout;
 	long				video_timeout;
 	long				compute_timeout;
+	long				psp_timeout;
 
 	uint64_t			unique_id;
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2151636d579d..f4fcef335b44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -239,6 +239,8 @@ static int psp_early_init(void *handle)
 
 	psp->adev = adev;
 
+	adev->psp_timeout = 20000;
+
 	psp_check_pmfw_centralized_cstate_management(psp);
 
 	if (amdgpu_sriov_vf(adev))
@@ -636,7 +638,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 {
 	int ret;
 	int index;
-	int timeout = 20000;
+	int timeout = psp->adev->psp_timeout;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
-- 
2.42.0

