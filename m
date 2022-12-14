Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F7C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C692210E479;
	Wed, 14 Dec 2022 20:22:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01AD10E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jutou3Pwo+dvVpDKbKhA0we3PwiP/eHBJaIYooMbmkZgBO/6YK4UFr1cVJDcLO/hwhSDqdDpMFtTklQCbPsvOiRm3kPcLVjSteQNid1mtGU8GSd0elPDw658rGBaoN76uFxgjZHUIFHjJMpymM1x99Teclv7sLXu0X6MfjzIW3C1XgjVmuf8iKYBvcfI1ZKukwg9ga7OBnJaBW7+Ftyw1EAPTCcqBEjB3b6IVLsGsZrf1v48g/Z80fWi+cad31iR7QHSlniFRiFc4dp9AwXz/TFLnADxnNfYzmPyQ5gBy58zNpcKXFuzlC9Icn5Bwg3Lzxz0uwbIx4+YY7NF7RrUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=netC+S+f/n7sFr3r7MCuQA2DPe9duljLvYgQrmfFeso=;
 b=jUf66okBE1GKcuulKaMB+VLShexssScrbf+t5CHkxHhl2riXKV6FSAYIjKUY+nQQHVII4QrojENaiojDnt8K82c5UAqcS7sszw5Pf3hxuywxt5My8aQfVD2Yh9sj4ssz/53TgSt/gXaSiznDCiTL39xoY0tE8HtmdqIXvmYIDCiXjagVEzlaYf/Y55uv8646nPlLlKpK9WcLvEr+eznIQyCbYEjKtlrSM7BPBsFF8Dm4+5VnUeyNf/N+1rcBiQqE8ix9UHuCwTc4uzzZj31IRdpKujcqRN78pz2ZH8LR95YO48enD1wCN4Liu/T4nj8bdIUVehxH12c85luVW29kKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=netC+S+f/n7sFr3r7MCuQA2DPe9duljLvYgQrmfFeso=;
 b=CcWyG6V5QU9q9bJPPLe5y4NCehf2AItUyNsW3rHZ5ddaoFBnrBdeMkPZp0VhHn59I+hOc69uNmvB1twNuTLaNsM/OKr5V2GLJ7TkWgSh1VkkxN1aNWWI5EH/WW9cFYeyRbD8b6TIB13wvu3Dn4lAUj0INad0BmxWfYPEozGtSvE=
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 20:21:55 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::b9) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:52 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:46 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/18] drm/amd/display: Improvements in secure display
Date: Wed, 14 Dec 2022 15:21:27 -0500
Message-ID: <20221214202141.1721178-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 994cca69-764c-4858-7fe7-08dade10d744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eld3wLLBxxRxYKKFaOrRGeW5HQRqfxn4ZOZmG8KDFHFdXDU+Xspf6bQsD9FT5q4mk8CP1i2upMUXBresXdp6LX08a4+paOunoHikOyONtRfVnVz8Dv7/n5MFv8XVqZcxE6ml8QqE36mR+ctf/V4Y7LAale9MD+qegEQuIsRiaC5YbxIBhNOBEyZA1eYZvldFqwNQC26kYqqGTfRcbdEv5wthz16n3Nx6inqdXkfG7gVe9Qn1f4XI9xYJQHbtTA7bwMKleUYN8KOKBywAB5oNORjQBbhNPAp3J6cq0NZQ6sPyGyYXo65Tb6oFhKCjgXW+HqZgFtBg2mYSIWmXhgSOAU1ZtuK7v6TAK0Qb+ZqZ9RyphTFeWfv1as1MyPhILnoUm9wjlu27ymk0YM1gWKiqFMaxeA6FM7769DEvRCautvly9KsavmQekAj1WmR8yPssa3ldJamzm6YGalu3hhkXhsObnJMHf2rHzPVokCKp1SzSJcDqLR3Ab6oTZHXriyR8cXZPtN4IQdjhV0OO9wh/uhn+5jHETxXr5l94XEobeLUlSR/rYDAVqBbxG551utwYZOw72vgjg8j/iKP05JsqtzEjixwh0sFvf1HtzU8uLRr2/guX+5wQU6eSdPcECtLkQkeTUu1uGQZVZo9suYwoX0uoDC7t7PezDKYB/AFiW1jT9RFy53fhjcLImqrM57oLHaXvafJ7VmnnEr50Niqe6Lde2wZrMrKabff0YXMUGj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(478600001)(6666004)(7696005)(81166007)(356005)(186003)(82740400003)(26005)(8936002)(336012)(2906002)(1076003)(41300700001)(54906003)(6916009)(316002)(83380400001)(40460700003)(44832011)(47076005)(426003)(36756003)(2616005)(40480700001)(70206006)(70586007)(4326008)(8676002)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:53.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994cca69-764c-4858-7fe7-08dade10d744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <HaoPing.Liu@amd.com>

[Why]
- Need error message when failing to allocating secure_display_ctx.
- Need to check if secure display context in psp is initialized or not
before using it.

[How]
- Add error message when memory allocation fail.
- Add check before accessing psp secure display context.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 3 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 24443547bd02..6b7a0f521f1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1644,6 +1644,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #endif
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev);
+	if (!adev->dm.secure_display_ctxs) {
+		DRM_ERROR("amdgpu: failed to initialize secure_display_ctxs.\n");
+	}
 #endif
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 8bf33fa4abd9..ad73e5855580 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -117,6 +117,12 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	}
 
 	psp = &drm_to_adev(crtc->dev)->psp;
+
+	if (!psp->securedisplay_context.context.initialized) {
+		DRM_DEBUG_DRIVER("Secure Display fails to notify PSP TA\n");
+		return;
+	}
+
 	stream = to_amdgpu_crtc(crtc)->dm_irq_params.stream;
 	phy_inst = stream->link->link_enc_hw_inst;
 
-- 
2.39.0

