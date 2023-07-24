Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60F3C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 15:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA1F10E33A;
	Mon, 24 Jul 2023 15:57:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEBA10E338
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 15:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSUFuaCXl6gSa+w5wSxtJ90zU0QscCld92V+wGHLDbl/mT3AhHNE/avAJ/7moplLIpIpVTSmD5RlErNopzg6cizGvVZsBbL5vhe3xe0jWYUN5RL/jsv9pD4tIa2842oYbS9EaaYXIEhpnZa/svkaPMiIrs0D5GLR5jOKSCdGQocT+8YBgtg3HOYbk8bbexhXKlMsAtUVomjyZNXS3uKcl2lacV4QJEDJyU9AKy57J8K2S88fj+rqcjWUtbvQQBUW+KIxvZk4yuePb8JsJEPCVUmJePrL6//GRb0oaRO2BlKht79Hs14+vMH9X+yo52M0vvnXuki63eWM8RDJvf+SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvDREIqtjYFl78BwKz1Kwc8THtg4VqpAsW677ObjGo8=;
 b=nTT9bd4I/5l0I8O32gj3ixWvQnHg2bPnJ8GHL7KynXTeAqNbua71RT3gVrCHZ9acIi6ea8TkOH2uhYTJeGti12ny5jTBKIlzrU4YkFJT9JGotiwO0n3Am1EcsdwrVM0Fw9uvc4rn0/ir/hx9VLUNjYSEq+zkyvHLX+vF0dqdwXaeit2vpvDuNSENKFAQvIulzmmzQxbuA737wLCjq6vdpfkLaIC9w6wHcJOje/7MjObhUFJXpZKtThgYOy1ubGum9kpM0zkBzOxCA/q+kb1tnkaR9+UmU916pN9yyMYo0iiGLcYAwi4P8+llj9AXYvuB2CD3u/J5ByOCleMrJCabvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvDREIqtjYFl78BwKz1Kwc8THtg4VqpAsW677ObjGo8=;
 b=xQqBqOZ4s3I0cAJMpsdPBlXPBKaKNcNUrKO/q+VbOCzVhp3otW0HZSgYNRay1Ed6IfZuf2Wwr+5An0EI8HxfrlRvLeb+yiwjywlaXPBxGk3jZPBiRa/FJCc08ajs2bHDRvdYzeDgioNB42hNSAP1Wv9luubEtzPMpsZQm2ffHWM=
Received: from DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 15:57:46 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::58) by DM6PR17CA0002.outlook.office365.com
 (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 15:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 15:57:45 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:57:45 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
Date: Mon, 24 Jul 2023 10:57:21 -0500
Message-ID: <20230724155721.1974726-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a36e2c8-35e4-4e61-4483-08db8c5eb8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkjhiWrFqLSvfJEDZFh2SuMhiCs1gjUR1NZ0nabI7G+R2jB7eaTLK1/vjSTBR9EtzCVmpC5QBDGdQCbybKzswksO1gVZJ02XQamJErzwPobvzGHYlS/+sCRjlzbWtqZ2GgdAK7x7IZzQuspAUxp+YarKAHecMfHFc5p5NiWMqVpF22UN6BSJ6cYmVqtu2cc0WEoXa87cvxWqLH8cFDcXagEka9SH8S/+wXr9PL+WaF2bGyshTn3Gt1miolrJlxv8tE9fSqcBy7LIDasW/spetC9wFkCL7PiSeCCvX/KczBrLBdqyzEjyH8nIRljxxZiT0SUu3hMfVT0CIc0xXVBtYa7VGBxjjakaezC+4l2jrCQUxFRdVN1/I+LQQU2R+MaT6UrOOdtEP9/DwciwwchFQYYb4JpHpc6jyXTurYIWhEclm7i6kx1DZbbnwQXPL2CTAf/BV1OS1iSVoQZesSlQmTfipWMOFfGPnPtAseD9z19iN8cfba6caRYRmMNtWrUU3cLSdhj0I89wzCzrXfiMNZbOQ7U6zQHjrujbCwoBuCtfUnZnbQdq4ZzgNpt3Ey2gS28D8qIvrzu4wnI2TsQCFiHLY6+YAoaB0Z31CiJA2GNe0N9kYFd67im1gxE5Wb2zCHZibDRnA/udQNaE5sq6o1jM66zuRn8bX31rHcgfg2HlJ9s3enwf1P+QbeDGTrHYVPRE8nR69yfFqcdSImThg3rnjuvx453F2XRmmrgFmnFWtqYWFhEeP4MAAjNxsuN7HPEBBx2+tfL9Jl1SJZdm6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(81166007)(36756003)(40480700001)(86362001)(82740400003)(40460700003)(356005)(478600001)(2906002)(1076003)(186003)(336012)(26005)(7696005)(6666004)(8936002)(5660300002)(8676002)(316002)(41300700001)(70206006)(6916009)(70586007)(4326008)(16526019)(47076005)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:57:45.6108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a36e2c8-35e4-4e61-4483-08db8c5eb8b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend checkpoint logic to allow inclusion of VRAM BOs that
do not have a VA attached

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 40ac093b5035..5cc00ff4b635 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1845,7 +1845,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
 			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
 
-			if ((uint64_t)kgd_mem->va > pdd->gpuvm_base)
+			if (((uint64_t)kgd_mem->va > pdd->gpuvm_base) ||
+			    (kgd_mem->va == 0))
 				num_of_bos++;
 		}
 	}
@@ -1917,7 +1918,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 			kgd_mem = (struct kgd_mem *)mem;
 			dumper_bo = kgd_mem->bo;
 
-			if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
+			if (((uint64_t)kgd_mem->va <= pdd->gpuvm_base) &&
+				!(kgd_mem->va == 0))
 				continue;
 
 			bo_bucket = &bo_buckets[bo_index];
-- 
2.25.1

