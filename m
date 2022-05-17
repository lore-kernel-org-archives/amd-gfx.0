Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA756C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2745710E052;
	Tue, 17 May 2022 16:29:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4463B10E052
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+yrokdWSAF3GR7volcyPLY1mB+4vYyt0nSTNdi2mIL3GJlPSfa4S5djHy3lJVUEEUzhG30mqi4RS+9TH1EWFP6gMDh0j1QlY7EdfKybd1BUdHTIUaPkG1ybIHkm+/beO2dMzsJGN7pAVWO5HE2wEjA1kXXIGI61DQTkpNmocPUmkcPQxsMFTrsioIa1u5AffThmO+1kyyZrCoVuy8M1GvHQ2APFe5HiQLD6BaninWRGs5tMo9bTZu6uvqrOgf68s5/7t+aaAhKE9JhwmXHKQ+Y9ekRz6BCxJTvD+142amYhISD8qg0aCFHcV7puAyjOtgX9Ao+MQ4E9VUTWVlkHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rnYFVGViq06/WO5OXFKu19FgZ5fH0yJ/o429dR6pxs=;
 b=VDOx3qFEQ86OzObIi2j19sDe164sDjRSPHOp9c7HKq/Sf+bdDf9pSon4h7WdWqnuv+I/47exvkInoD6TCGux2BxQ04h7RWIb2qXEogbxhwgOv9fmT+YGA797pODK6qqp5Z1r/jaCXjKZtxsE3YuIES93ipG1uLXN9pfthl2VXVoXnBReuqFq/7rG631wp/PHEQXIzfD3raXbtE3VPueFncU8JdU44MrGj5MWs0c29JCxW7Nl4GP1ITNzJ4aGYwvjUoj3h+0fTVtiXRKgcope4V6KgAwJqmF24VEzu1OI/lyqnmRPBccMhCPTqYFk2wMFdMtjIHuopGLDbXcfffJ2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rnYFVGViq06/WO5OXFKu19FgZ5fH0yJ/o429dR6pxs=;
 b=a91yIticLVWJEQY/wGAFNLPEr/HlvSvwEY81q7ZcfKzSXF6bep7kWWdfqN7TYUb5BMQXc7+0BTmfxwb9K85PpzzyZZUcicchwtEr9+8Gm7PrMLXyjvozl3Bp4ACYzwDB1Du/qEM9EgzUGEESuzE6uMuxu5MN7SwFQn6jPls+kMA=
Received: from DM6PR04CA0021.namprd04.prod.outlook.com (2603:10b6:5:334::26)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 16:29:15 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::4b) by DM6PR04CA0021.outlook.office365.com
 (2603:10b6:5:334::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Tue, 17 May 2022 16:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 16:29:15 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:29:13 -0500
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: move amdgpu_gmc_tmz_set after ip_version
 populated
Date: Tue, 17 May 2022 21:58:52 +0530
Message-ID: <20220517162854.1017207-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2544248a-f79d-4b13-7173-08da3822623a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52296E73110A2F3E32CCAC6193CE9@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/RvlkhZQ7TL3ZytTpKsbKiGhNcuX7xizuNojFXazSkZWgR+OFj+TANJdW7yEv+U7IntKs4+kKK5BmyHi5uVoPCQ842P+FCQwVfVUX3ZG72vSPB9J0scTspv5AziakAmos2kAE6qNR7itjZrFyk27T3O0+WxsuZXqCoDqrCAh8uJa8+xYxeANX6Fv2N4SATsqRq5LmQiMD10OEBFzV5luGqjHLV/oqzKT2rSeW99z+DNHK4Y1tfE24QF3AKhadqoGG30SQ/LVpJgaN9qn93Z3u+lpQ6YRyVm5fsAUWTeb93M7/9cMe02+g5f49V+dRv7pa/0s7rra5m3jzw/E/Yq0ieqAdmuD71SUlD3uIe4HVBMIxKROSu3ahUSnpQh5aE029EHxvP+NXbRKeW1Fu2Z0XLRWmRg8KZLeYGQiBcdg2wumXpwVJVYo67kPTiA6IUgJMVdQEv8wb+WImTDv4bUZtVRWRLYWFS0V6EGdyog8P41mNKHdLxbm9RgiQRS72XFKSoFylJXssJAUM3c4Q6puPz2mjz/3BVsprC7K5JfXDd6cKL+HonkHm2oQtkwzO0cOVLfUxGppFlF/l8S8IChotvR4/KY8gHf271Jb6cJW0M9ZOI6wdyBs9P/F/t6GlM88qpa5fr1AEYtODZ6fFtZ4DhTnGKdyzLkb9RrGUhvn5b19ev+sIr3tWQ40daM4Q8sWaVrB4bUlTJ9gfPvTpeoxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(83380400001)(44832011)(7696005)(6666004)(316002)(40460700003)(1076003)(16526019)(508600001)(6636002)(8936002)(70206006)(70586007)(336012)(186003)(426003)(8676002)(2616005)(4326008)(54906003)(36860700001)(36756003)(82310400005)(110136005)(86362001)(26005)(47076005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:29:15.3293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2544248a-f79d-4b13-7173-08da3822623a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To enable TMZ feature based on IP version needs adev->ip_version
populated but its empty. Move amdgpu_gmc_tmz_set to a place where
ip_version is populated.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b583026dc893..f9684e9e79c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1556,9 +1556,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	adev->firmware.load_type = amdgpu_ucode_get_load_type(adev, amdgpu_fw_load_type);
 
-	amdgpu_gmc_tmz_set(adev);
-
-
 	return 0;
 }
 
@@ -3700,6 +3697,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* Enable TMZ based on IP_VERSION */
+	amdgpu_gmc_tmz_set(adev);
+
 	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
 	if (adev->gmc.xgmi.supported) {
-- 
2.25.1

