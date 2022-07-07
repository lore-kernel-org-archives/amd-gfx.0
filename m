Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995CDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 16:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E26D10E3C4;
	Thu,  7 Jul 2022 16:46:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0A910E2F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 16:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKZYVo/1rFOj+33fYol7BGHw06u7geCakE1r2qQr65MTqvBG6ZNOyHQg6oWZrydVTq0An+qq/6yF4e+E9wYMwkyKW34/g7Q9XHabUMY7+u+xYz0x8eBBw38KC+RvbjHKkreGnVPHi4rTxYEej8cxr++v8hH6A4yVu1hn6AtuBk0v0jJ8Q66pDm5mdwKjBEP+s/yUFiiCvfryeFcJnLXF/3XW96rx6Sp5S0QLab2hr75LsFGzruwwWsmPgw9IgA6MHihmjot8D/asx5Je5yyCPA6ok1RRHx0B3Mzfsjduu062obGcR9wPHiEPd318yHIjt9N+X8KsnLCDhcPCubAntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6gVcDrhy2Is1YEbwT36T14DTkqGtp5fiWN7IkRG9xM=;
 b=m0DYYqIByiQVQpukhP6iX7cH6VVgZt375lCEdefGISdrT2vHJrJ519ODZMia5S6z3i3nkOwN8ZwqNnjV9vMSpfecyfTDyePKCqM59krjw36t/dX6b7mkJezprROFNnFeXiUyYc8YQBG7iUhK8y2gKIAg01FPtwNMOSJZfkM72J/4u80Z5kWs7pH+lSANWCiQ/ieUA8UVogfsk17n6rpc8vLRd1e9UZztwZOFN7ZIr0h19q0DHc+B2Cx3sFRqOgYCqwX5//85CU/lDxVPPpCRQ5uJUgSE1u21Yn5F6Nd8TOM6NWzVqt9WNjscC2avXfoP8o5ierOW5gCK4L3KSyQXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6gVcDrhy2Is1YEbwT36T14DTkqGtp5fiWN7IkRG9xM=;
 b=KaJPODFCP8CH1wNLEObct6ilRS1/HSc3jCaB2vzUR/sxzhI+NHjZ3EVEZ+imZEgs1hTj4GD3UWm/C1RRyi6/1oIdWVmr4Ch2xr2MBBP20r07gxu2FGYCH82U+fFLZd4+T7Im6zyFbvIErDQ3SwZuCNumJHJwu+6eweIjY+sAKXw=
Received: from BN6PR11CA0013.namprd11.prod.outlook.com (2603:10b6:405:2::23)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 16:46:13 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::5c) by BN6PR11CA0013.outlook.office365.com
 (2603:10b6:405:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 7 Jul 2022 16:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 16:46:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:46:12 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Don't clear memory when PTB BO is released
Date: Thu, 7 Jul 2022 12:45:49 -0400
Message-ID: <20220707164549.4032-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6775df48-654c-4f78-7750-08da60383414
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peN4aPl6qtcSnPz8n8QnzEud/m3619XFqHUd8L7Qx6QmfNSZ+FL1MVV29p5fpptFiSxw6FpCCPOKEK8539iBqQJhfjd8cwDPRZ+WhqmqhDXaH5VV29OAJaJwYaFbsd7zWhnl5YED38Kn3OthN71EcTCOWrmH6wo1uincWj6B/zxXJwtLsFMQHOl+yArNopRWW7WEDuKwhSbJcgqIRpwJPPgA/eHZcYG1qoRbRsLr5GSV4QjNzxDlnwL5R4LPPe4SvFyuf508FM+/EfUmkc8bQjkdY0I9K5ACLK61EGZ0lzPYwI4z9fIRr9I0YrkkUaDbjGwbRTkUCAFBinuCf2AH5DrBTB1zL9l4Y580ddHn4liYbL82HCNyVcd87ZcG7PekvL5pkjIUNaIhc0P/OMVt1UAEtWQTuMYzdpwk40mkdJ+arVEHU0ndHbAcrx5RzkuD2FeOnjijVzBUeS16NOb0P8ZnOvczr6lWRPC5ckyXpgbQkI5xU7CfI/XTpnII+Ngqei7wHAp9qQpTItnqzNR1MC6Pu+kAZXfFkSb4TMUMbFgSgLV5RrARBCk0ntYcL2EcjLVoTWQ89DEllyxsn2M9r5EcjiFFbXKL+9JyzOODevOHpZzBOus9NKOgiF0LemJYT9/zSrHXhBDlBA0EyMfAb0iysm/ELc3JomQ6Xau1/KD4nEqM8FE68WXCCLnY102d0lpLOfmw1iRvtIniDCK3X6kS7xs4HOcBw8jb4SbLmNdNUWWOrmkN4GewiSWEYbReVR20k58IF/FCBHwSpp6IAq6kxZB3c8mEVjQ8e1tUx1Z0ucGgheDVypc46yoxc1H3U7bMeLNzqHIRoIDl8ntmKxqy7XUAkGFZUUnoklutA51FpQrIRBA5xgGvTV7ail/C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(40470700004)(81166007)(1076003)(34020700004)(8936002)(70206006)(7696005)(2906002)(26005)(356005)(40480700001)(4326008)(70586007)(5660300002)(2616005)(478600001)(86362001)(16526019)(6916009)(83380400001)(54906003)(36756003)(8676002)(316002)(426003)(47076005)(336012)(36860700001)(82740400003)(82310400005)(6666004)(41300700001)(186003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:46:13.3756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6775df48-654c-4f78-7750-08da60383414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMU notifier callback unmap the svm range update page table may free the
PTB BO, then amdgpu_fill_buffer zero BO memory could cause deadlock as
kmalloc may trigger MMU notifier.

amdgpu_vm_pt_clear setup PTB BO memory with initial value, and no
sensitive data in page table that must be wiped out before releasing the
memory. So don't clear the memory when PTB BO is released.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8a7b0f6162da..65b4ff6979ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -576,7 +576,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
-	if (adev->ras_enabled)
+	if (adev->ras_enabled && bp->type != ttm_bo_type_kernel)
 		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 
 	bo->tbo.bdev = &adev->mman.bdev;
-- 
2.35.1

