Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CDC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BB52075A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pG08JmrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BB52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CC989EF7;
	Mon, 23 Nov 2020 13:13:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179D189EF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 13:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTiPEIYh+gwD6zVWZ+8xMd+Rrb9GgBDMKV11uL3+ugCpHnab3shwBVaEhQa+v9fcGnxwIU51+kuiQdPCCsHsRvx4DBA5Q0pyPUhZqpo/N0jKhtUZrAQLrFUYdB8pG2i+B1Kdcmev0GIkfMpyH7WLbBfAZob394XbuzxGOZzHlGYUyUgGFhNoq3gDxMZMGMcVU9QRPi/ccZROWrtDVW6Nl5rUxGc7g6g04hcr6DMXdAT1c8PBRR98o2gbYVrqhY86a/JXGDdK7wzWervGG1yu4hyDincAIM8/F75hnSVIRAYwd08go7nJO/u5V6D/gNrJS700afSDaCTEatT0/b/Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB0pHuvKYswJ4/m4zzgTAN8gVmNfL0Wvp8DSWJXqmQ0=;
 b=D5sQcXKWUY2/Pi1L601hroAn+R+z/+ErQQe5a+9CKgLaXktZgMsQS+ruTdriuU4OHd4Wg2ljm23P6yiDf3G6cpailX4skaegl2Tm2LETEVj5QJEo9fY91oYgquY/XDUGgKp3Om9FmA7cDEGAMAn+ui2Zs4AGxPAVA0p/B3oMKGQHSgIGIYw934abk+BghDylr6U4z/xuq8iQrFKFWIy/Mu4m841t4IkuQCj3jYdbdBBrj7hlfJ59hJRyMo6gXzecaN65M1FO+qUNJbaUuftGryIEUrw/WRFvvhYPwPIv1oKoknncNbYcv4PvGIiprg5ZHLN2EupcE99/00AtVeNpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB0pHuvKYswJ4/m4zzgTAN8gVmNfL0Wvp8DSWJXqmQ0=;
 b=pG08JmrAxzsjiBs/61kSUkHY9b4+wfHkLgqmv7Yf3o+6DEhyeIwB8jJI5pzKi98hBCBXsawL3QpGDPy7yNFYt6bkohicog1Ko28SffS+by6dUJtswZtKr5E6ZOs0it2l3660rtGpdlX5hVFQbl0/V2LcXzZRV3/AZDNKUNw6rjU=
Received: from MW4PR03CA0363.namprd03.prod.outlook.com (2603:10b6:303:114::8)
 by CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 13:13:38 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::ce) by MW4PR03CA0363.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend
 Transport; Mon, 23 Nov 2020 13:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Mon, 23 Nov 2020 13:13:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 23 Nov
 2020 07:13:37 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 23 Nov
 2020 07:13:36 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 23 Nov 2020 07:13:36 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for
 specified asic
Date: Mon, 23 Nov 2020 21:13:34 +0800
Message-ID: <20201123131334.21704-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 390fbf92-9e39-47d4-292b-08d88fb19739
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:
X-Microsoft-Antispam-PRVS: <CH2PR12MB49694C0750AA3215BFD5040B9AFC0@CH2PR12MB4969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMtexVECOQ01NdfXWwihNgUQd6M6sdZFnahNObnXIhurNSDqV8zVTW+FwJU7xbZPrHF8jFW9j3X7FoF0FWiry8sCFIDsd7ecwF8CSUZrWJdxV8erwdSA2AOiJtZ+Ky+CzP9b5rSTUEtwqEcGHa+pJdFWmNW+i3UyEWwkNnQvy7Wyp1c+Dt4RS8ZRnrSSMeOEfKM8Kka10r+SzBszLuyWPLoiPJmJwoKwbPwd47rg5rInYoWSSH5nagzmDWNjzlniVTZpG027HJAPADL5Kk0cD+xaNuh3UVPaheVVvuqtUIBBongiB5ZoWln9aGb9IHyZi5FFP1ogXwWOwI6bHXkqL7qLmgYNRbX1rIEhg0pBjUUeYjcnfcTN2Gf5Q+f8rdoAZo3/eBW/VgocCB8zDFQeqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(356005)(70586007)(186003)(81166007)(26005)(5660300002)(70206006)(82310400003)(36756003)(2616005)(2906002)(8936002)(8676002)(86362001)(4326008)(336012)(478600001)(4744005)(6916009)(82740400003)(426003)(47076004)(7696005)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 13:13:38.0295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390fbf92-9e39-47d4-292b-08d88fb19739
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

noretry = 0 casue KFDGraphicsInterop test failed on SRIOV platform
for vega10, so set noretry to 1 for vega10.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I241da5c20970ea889909997ff044d6e61642da81
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a3d4325718d8..7bb544224540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -425,6 +425,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
 	switch (adev->asic_type) {
+	case CHIP_VEGA10:
 	case CHIP_VEGA20:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
