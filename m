Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A5FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 12:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981BF60E74
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 12:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 981BF60E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEAF894C3;
	Tue, 12 Oct 2021 12:10:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A39894C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 12:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKZ23+GQZQj7hv4AK19az4aOE4+8KebjEAgGkvl+hjxfcFGvSn0BHA/Z7FlDoB1Gbog3iEIbsMlhNfIixsKIgJPCsxxOv9Hel5c3dLqRau2CDtnDjejeJ/ZwcZgX0P+fti/8xs1oJwZQ8Kj9z5Fi7UVzs95dU6RA++xtrhzGkMTtC6NlMirs1VTcprMrgtKkZ/PMbFzWjDntokaSM0HtnhKB41vsjJ8NggXnx6Fo8AnVLeQJpfSKeDL7S6EffjkZJFigrO3LqsLobe6mBCsPaCmS6iyU6q9nMh6CvHrRF0+I32xU48SE35ZlzGxgbxbQBeU6HBIIRLTPUwTJJK4TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAtBHpFCW6iHoadzZMXpZCtMoIzPsA932l+o5fCbpX4=;
 b=GcRsB1Y44NlwBSrjtdEoTXRMeGaklQ7Y87vRI923ffpMYmlrxxshYmnF89gCX8EoCge1CIVmALMJ2QbR2OqWGrpzoolA2yIhIviBkYj4uJ1BVW62lkw5hXIpXUpikFh+kuxkfN4PHhDgaza7gvpLLvUf0CmxNCQ5O6syYHwwWP6S/U1FtfTfxco2APgX3liJKtQEwo9+SrsiUf/QeFfqkHdFPNPvpBrheO5RSP4+Kv8FsnyrFacJnq/6ftxNkpS3WrnXKiB699fSqvNmhbxNhWj+/swp4vgrmSJWBjLgT+G6EVjymOmhVCft2mPQDzL2t9KWN6X+2H8uCtodmh8gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAtBHpFCW6iHoadzZMXpZCtMoIzPsA932l+o5fCbpX4=;
 b=sgVJKWEp5PtOtwAnBnijDQkaBZNiQhQLEjV1Djshb4aQHekKE5egwhaJusFMjUQJvC+IZZi8T11VPKE2kACqzDb8inW58mxHDWfQaFAVj41lym3G8+SK6fEuQLOSDsx3q/1iGFAKkR7GeQhDKYON1s1QcVzhuE9d5jSUjqC9QtE=
Received: from MWHPR17CA0071.namprd17.prod.outlook.com (2603:10b6:300:93::33)
 by MWHPR12MB1951.namprd12.prod.outlook.com (2603:10b6:300:113::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 12:10:31 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::b1) by MWHPR17CA0071.outlook.office365.com
 (2603:10b6:300:93::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 12 Oct 2021 12:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 12:10:30 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 07:10:28 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>, zhang
 <botton_zhang@163.com>
Subject: [PATCH 1/1] drm/amdgpu: release gtt bo after each move test
Date: Tue, 12 Oct 2021 14:10:18 +0200
Message-ID: <20211012121018.81693-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63f22027-1f61-4bc9-8659-08d98d794963
X-MS-TrafficTypeDiagnostic: MWHPR12MB1951:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19514278C9DACF12E9DDAF708BB69@MWHPR12MB1951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONLvDDqnKQMHsrTzXKk2Im5S5zuy5FEb50CzMVa9a3VBZPQeUBWoWhEJjr6ldyCNQEKG+CAAXZcoeh2fc2QDd9SP4giX7yQu0Xb9SdmuWllcB/Kbm26lWHbWEfSdP002L3x7fgThrydM9XWQGpnfdQdXSTnjOYpH332NSp62Qb9BTPNJFw/nWGi1i/Hgl2k4mYV8CrzFvcOHZgULsI48Mw0MTXK0hYV+0Se+T9PcVnZcgYBZz8auXgl5bFIygE5htzfAI513JGuqDN4bo5YTFaK309m/P2mcnJYtG11y+jrkBNdrne8md/GqZvH1KviPFo/Hy/4R9gURIGpOuWUKWMZDmJGsVF1BT41jpgF10YD54VfZZlmXwYv9YJc7Kg+FRnUtQ8CqgKw9g5ELNexJy7u14rjBbKJGDMarbk1Qu76yl+EtBftzTnN1yj5HymBvrm0xOn9JxWkA4Mf0b5BoWeLp9Lkdr2KfLOGN1NZo42nZBXkDzFL3UruXNNWd40sKxwYEBqMdt6POYMUJNEyqK5gvIx/y+X99dGAtgaoMAsgPPbVkHij/kL4Ejd4t6pFa9FqqEm3HzdiqIXWy2i6Z3dyqXe3w+F0KsiHHhhZYtmT2rqscqYMGiFlAWvq1kzgCW/jC/m7xrSMOogwH3XapzOQWV28F2Ivfxt3OADKlvoar/z5CfedwtFoQ7LCjowzuggNSAEdDQLkO7sH2Oh4NuzZVkxnUNIs+OPW/4PkSkOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(316002)(426003)(6666004)(36860700001)(81166007)(6916009)(82310400003)(8676002)(5660300002)(83380400001)(2616005)(86362001)(44832011)(508600001)(54906003)(356005)(36756003)(26005)(2906002)(70206006)(70586007)(186003)(1076003)(16526019)(47076005)(7696005)(336012)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 12:10:30.9358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f22027-1f61-4bc9-8659-08d98d794963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
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

When gart size is < gtt size this test will fail with
-ENOMEM as we are not freeing gtt bo after each move test.
This is generally not an issue when gart size >= gtt size.

Reported-by: zhang <botton_zhang@163.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 909d830b513e..0cf2a560d673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
 			 gart_addr - adev->gmc.gart_start);
-		continue;
 
 out_lclean_unpin:
 		amdgpu_bo_unpin(gtt_obj[i]);
@@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(gtt_obj[i]);
 out_lclean_unref:
 		amdgpu_bo_unref(&gtt_obj[i]);
+		continue;
 out_lclean:
 		for (--i; i >= 0; --i) {
 			amdgpu_bo_unpin(gtt_obj[i]);
-- 
2.32.0

