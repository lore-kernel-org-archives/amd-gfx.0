Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F048EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 21:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88A261208
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 21:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B88A261208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631B36E4CD;
	Thu, 21 Oct 2021 21:51:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE886E4CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 21:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxBYIh61umJNRLFKOWqegsReO/5FPmak5xU11GO6dEWZEtJS1xYlXxMCUW/JwI/Y8KUvuMi2VilZ8+gD+GzZ6lNhX/BoRuSaRQ2sMo5378jZCj/scrRWmm2N3+WBKkLzFJXh+JHOwNNLwH/iH4TSEDAsbEohNp7owfXQbWYFCneUB5zkyQd5IB9IziVAA7nJ8edw9vym15yAtyjQGP+OMP5Oo12BR4QvgIiEeB9M/9F2z8esNhESRFWiEmIfsOnd1p1mOoqTlfxEPGXqQUw8d8iBvyWIy9njLhcY753x9tbFbQ8QM87D+cFTLTW9T/te+WPDrc8OrlMjFWxUEa+//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MAFG94Y6h0Y+rqlC1Wcrvg5JRvfaxVSRV+5keMKc+k=;
 b=dv/8hlXbJ1xS4lVddNSS/OnzbKBrHYM9P4DWH6Meu6e+m+9GnNimXBn31Pe72i0xGAFlUrpGHUY87wGfpua18HD1nJleAcJxHtjQ37W2l+yAq140NVPzvdNzfwKD4JBbSPh6b9E2fbF83dj0kX29a56FgceebR1l3x6bvOfgYKJoEZ3oDA7KDoqbTx9yphkcTICjii90rao9WHYhENzwoHIP6CO1x+lE1qGb4aPVSdZz036xslU71HutrdcREnIStBaE7bqvGNAk9lle4IADOZNpp/jdQpWe5WVUZYp+PUq2u2wFpYTJL023ZbJSCtAxgmbnfd0k4bdKnX0AYkfJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MAFG94Y6h0Y+rqlC1Wcrvg5JRvfaxVSRV+5keMKc+k=;
 b=NNVTaBHfyLgn0+Eumirc+rsI8zmCkQpYl7G1msTyryXV0US1sXWP3cV+i5l8Ttu4AJ0Ylq7bfb74NUOJh/GOdbfxme50ZV8Jc303CCgdLqiEtGgGontTiMUjw846ySMhiNM9tDBHF42T6k7aH0GU3csjN7lBu4901wSeYITR9mg=
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 21:51:47 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::a7) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 21:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 21:51:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 16:51:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Date: Thu, 21 Oct 2021 17:51:33 -0400
Message-ID: <20211021215134.224476-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25fe5058-555b-43cd-d69e-08d994dcfa95
X-MS-TrafficTypeDiagnostic: BN7PR12MB2674:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2674F8B1D6781382DE81F87CF7BF9@BN7PR12MB2674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoz/O3mmpepxx5X4QuNb1Kwbfpx015rPMW57J5xxlvsEhO9drqjyfGlTKzf8ofkMYOeoDVSXlpw+ESbWwjb9x1xE6W/wZF3a0SH1KnxSu73o9G53JPUCKJg4tIBoGAU3BPTYKw5vPcOLXrfkHvYcU4yZf1qrtL3t1UsiBvu9pX317/3r7/YIKK9VbIHkVXEFInwyfrbXzVag2E4XwlUeZDWzxYmgC/m6CfVU/NPWPrqzJSEZbwoWWXDzqMojJXgZ91Zg85td25TcJyZ0PNu5eLo98HRTBr8Bkox95pHi8VFsSCuG/BfAkHwZl9TL5FgI+DGyPZnGJjsMDoU4wGPe4yojHunk5IKKBw5BvJtAWtu/OLWLx4gZn8SBZiHAslcxteikadhxuiMZsz5CEKz8keRPEtCqsU210+NiXT9gZ5HR4zqDJ8rvjIszH4AzU+FzAxGz8QcjC59N5mkxQQXFh5cUasnXkymIjcD377OO8ZcOFfRPH0FHxs0c6Xe6VUMxHz7vzEe/48riNkfniVVHKxLoOrS6SDifHcCqokEIQh7d2lSy72g33l12M04gPxzDML+3Qhe7wKDWmllo1BN7GK6ypfuk8bYWja1Q4KAVnmKewk3pvsoQZ0oxUWHtV9zaQsjWtI/HDDuAnHwebqys7QSH1RiVQqk7RPcydhtC6KKlWNK7ZF9/KgC3bhpXZPA4Hi5UW7qJk1B1b2qWH+eahDKrQdWzjMH8/8ibWRkko80=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(426003)(16526019)(8676002)(2906002)(70206006)(86362001)(36860700001)(186003)(70586007)(36756003)(356005)(6666004)(7696005)(5660300002)(82310400003)(81166007)(336012)(966005)(508600001)(316002)(47076005)(6916009)(8936002)(1076003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 21:51:46.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fe5058-555b-43cd-d69e-08d994dcfa95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
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

Some navy flounder boards do not properly mark harvested
VCN instances.  Fix that here.

v2: use IP versions

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index dfb92f229748..814e9620fac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -507,6 +507,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
+	/* some IP discovery tables on Navy Flounder don't have this set correctly */
+	if ((adev->ip_versions[UVD_HWIP][1] == IP_VERSION(3, 0, 1)) &&
+	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
+		adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
-- 
2.31.1

