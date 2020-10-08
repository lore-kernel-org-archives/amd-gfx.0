Return-Path: <SRS0=l8SD=DP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E51C433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 01:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F36520B1F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 01:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p+iZ+6WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F36520B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEA86EA13;
	Thu,  8 Oct 2020 01:35:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F746EA1A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2020 01:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9LD5evdZkRaY+kWXStqsduhG38yAfKFMC48b/B1raQqW/zCjxgywJsPa/95gXTKzV+s58j/gTsaGlcU7WfE75ymTv+4NvGJDPzaHjtQXorirjLkq+m7Y5QP0d13WdGc7Q0oYYA4/mc8XFOMh7xoYHbcRSVN9LJMMAIBl/4d/wL7l3YEBrR9BiiTlGpo8T/TOtXxBT5K3QQ8lBHQAthSCKohvWLTXIBBkZttsXLvvz+A57qXFkYubPuFX99DCom6ydbFHXNvr1giy51zU3AtiN2ohnmzkg7pHJsfhBRDMj3bH7H8kcgvrmn6wYXGnPABqapgFrmYJ1cFkN0dVmIDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIhUreY0R1dOlrJ+c8yXokTREGF1Us+gKVfOGnEfW5Y=;
 b=PoXoVswZxRin/3YrqOjT1Wh+Ly2avdv8KaRoFa45FZMcHfiaW7hQUaRfzJK+HJUVQ1ZumjbTjIhDe1sFQuHysKyHFGDeYk6asXr/0ENqcJLuUEf7rIS/vPE2r1tY4A8+gwC1NmMDlutsf7kYMUf27pAmonSVZXO3vSNg/xZ3KSWc2Q+Ld6+9ZNabIN/+j8SklPO93Lvg4a/f1eoELg2M2zcClTUgCiI4bU7+3GQsxb3SbKWByIuisO1E0FrjHX/PUn5R74fDjTCqYNUscdut1fdta3lLzBv3CLFW/QMohYBTCo0QRdQSVNAC69pBGnvxBV2L9whZ66iOzD73nHmBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIhUreY0R1dOlrJ+c8yXokTREGF1Us+gKVfOGnEfW5Y=;
 b=p+iZ+6WM06Lb7kJ5M8i4POo455xxYnlb7hdXtq/LnEB5WmUnaHk66iH6U3ZJf/uHuXD+fdoaRp0K78DKj5nEQqooAyVniCXIns4wq3vCbOnBY69LRYTucpW09GENaZBzsM54jEg73KZP038Zp52ra7dT9XcUkY7536ROjT8E2Tg=
Received: from DM5PR21CA0031.namprd21.prod.outlook.com (2603:10b6:3:ed::17) by
 BN7PR12MB2785.namprd12.prod.outlook.com (2603:10b6:408:2d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Thu, 8 Oct 2020 01:35:19 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::1f) by DM5PR21CA0031.outlook.office365.com
 (2603:10b6:3:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.9 via Frontend
 Transport; Thu, 8 Oct 2020 01:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 01:35:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 20:35:18 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 20:35:18 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 7 Oct 2020 20:35:17 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove warning for virtual_display
Date: Thu, 8 Oct 2020 09:35:15 +0800
Message-ID: <20201008013515.769531-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e42ccc9-b1bc-4fc9-d3ff-08d86b2a6a8b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2785:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2785986779092BB5C09E1CEE8F0B0@BN7PR12MB2785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Txt0IQGxh/j6CrcixBV5JyCAT+AGcsitnW8n+qTvzg/DBT6QgjFKxxN3HeQLuhQT0oPyETM/NQ0adz9GyxvLhKaWKsrzUZdomT96UjM2Vexn/JvVxUtWp88dpCnbJlIGU+/VJn9ytkk8hEAXN54LxpWAP+b95Pfzlji1BPVf20Tuu9n8wpGCxGKrlvc/XsjXYBmMVuLPvn09PkzBMqLibdBPpk9ehLQchwuS7l6mvRqNY4DBKnDJoxnhmECpZHWCDCVTBG8IUXQKHsxeR7MB95OwxleAR86fEOQL066voeP2qT8mixaj/1C8NeNTnYoQ9rswupqBXzkyJzRFJWgWHiVtoB05Bga5KFRn/4Ku8uuo7wt9FlGf+zvxXZKrWuiueLm6r1tbRP6Vfa4qxfVtJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(86362001)(5660300002)(82740400003)(47076004)(336012)(426003)(478600001)(70206006)(2616005)(1076003)(4744005)(2906002)(70586007)(8676002)(8936002)(83380400001)(81166007)(356005)(186003)(36756003)(4326008)(7696005)(6916009)(316002)(82310400003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 01:35:19.2292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e42ccc9-b1bc-4fc9-d3ff-08d86b2a6a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2785
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the virtual_display warning in drm_crtc_vblank_off when
dev->num_crtcs is null.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I755150a32478d8c128eed7ed98a71175d2b3aefc
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 52d40b5e14db..fcf61d94fbc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -189,8 +189,10 @@ static void dce_virtual_crtc_commit(struct drm_crtc *crtc)
 static void dce_virtual_crtc_disable(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
-	drm_crtc_vblank_off(crtc);
+	if (!dev->num_crtcs)
+		drm_crtc_vblank_off(crtc);
 
 	amdgpu_crtc->enabled = false;
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
