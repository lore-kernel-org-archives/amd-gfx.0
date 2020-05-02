Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F94C3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234CA2072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U3e/bAmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234CA2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35966E124;
	Sat,  2 May 2020 21:35:05 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A7F6E1D3
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqVxoFHfRxYcPFCF9B4aZ4xTjhmh/0n54oX322r4HvG+frkWaKzs5C12HcPiaQV9hn5wxLfHJqmiRcTU9nPwN6XoBfESYiIpqIm68kUsc5zNOzb5NcT1oceVIW80gA5ergBCTB1H8jdAce1O4yLYYCLlwfVqN81hJZOGU4XcSPkt5JZ8o0mMKmohisfKH5kMux6czFXIeSvCNfDsNC9cwIx5jhsyNhQWPfS38+TsMCAcdCHzIlumsyIFJQr5m6BR0kgYu76+qnhAZ/8uAdxyypgVVtz6E+0KQQSDMc2XiWOyFgL9oPfbxL2i1XHQp0xv8PJeuL96VUgusQUj5k4LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgfrrffBYZPlGW9yiiGup0Cw1sIqiUGFkE5hH5XYobY=;
 b=mF0lFYry0DLtRzhBmQ0BKvqFUdVglDmxX0R5HQKRQEgK7R3nzLTWJlLazruXsn4B1amrWZWKP7ECdqSOLXoxwvnXEGnwMuAz4iwls8eJ0TA7kKXIsfxT8dOfYqzj2SiyXHy2hHdT08Swlb3yU3RmBA5Mkf4JFJxmf5jpExbCRkSZ3aYD5F43s+GN2OTSWP2BLv3c669a48OYBYoHqkXe2+F7rIF0GIuVmLVeJRoP7vVoUPNWs4rr9ECLHc9wSHbWFrMh0+T5vVp3VaxaZ+MJXQO1rxShfyzldVRGcwuQ7lGUCtcguCo2KQYkGGalTyg7tpXNBfhGzl8cdM6ljB7XKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgfrrffBYZPlGW9yiiGup0Cw1sIqiUGFkE5hH5XYobY=;
 b=U3e/bAmEhVN9aLb6JCpmA/WpiU7GMHT+CxktUnCGW7nVFsrDTwcbRd923cxW17ExcbsF04Npnmf4Oe9FmaDZhF+yEhVK2Vr2ZIbI4ORHqSbhUPQPYg9iCwIi+qWRwY4jPGTV/5nGZtmYV7TyY4bVFT1NlBYam9QBsBQtSVJ/oSI=
Received: from MWHPR1601CA0008.namprd16.prod.outlook.com
 (2603:10b6:300:da::18) by DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:34:59 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::75) by MWHPR1601CA0008.outlook.office365.com
 (2603:10b6:300:da::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 21:34:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:58 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:57 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Check DMCU Exists Before Loading
Date: Sat, 2 May 2020 17:34:39 -0400
Message-ID: <20200502213443.39232-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(54906003)(336012)(426003)(4326008)(6666004)(316002)(70586007)(70206006)(6916009)(44832011)(81166007)(356005)(82740400003)(82310400002)(2616005)(47076004)(478600001)(36756003)(2906002)(186003)(86362001)(7696005)(1076003)(26005)(8676002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f65bdf2-237c-437d-8a1b-08d7eee0aa5d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4401ED166190D5997CEE1F078BA80@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1SQdU9vd5EyYBRozQ9rCETaimaj2nFrdyt/gGLZoJAQLVJHt03lcZ3W0bTMiLI0jdrTox6eDx1nYICoe8c3rILYLjvBtcgUnxAxy/6YAJopHhW5gr4qBhqMf3fFEPsB1rpsefvkgS4T4Ws/OTANe/N+8eIoMlNsJrtFBKdBGbIN7upVLMEIQWh5eC0tXjrt4jTBMBqPVh0C3O7KqKzMizPzgG0+rQbojYdBs8Jw6kiTStXB4bzj0apgu7EJD/xsh/nI09qB+7KWIRIir8DZFiEOi20EdTyU+EXnJgkEdeg3OwvMLM0lpRWf1oe5myWybsyTc69cZLJBsL/3xzZBeTO21XwXU+acunZxIoHobNxRDCykC39qCyVSIzjjwtjGyCe5V3dCjHyr4icgfkgFaM0Ze+YTfZlAJJhibRwVC0r/THmzUpSPUDUG94wMdxFPApQQpIfO36m3ClUCLbH771MaXY5a2OC+nOIUuvcvZWZMn+mJKZaI+7GIcNBBwlPE4hfB23m8aimZJ39vXWXE6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:59.2867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f65bdf2-237c-437d-8a1b-08d7eee0aa5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 "Jerry \(Fangzhi\)
 Zuo" <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c56e240cc8a..065d5d7686e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1389,9 +1389,14 @@ static int dm_late_init(void *handle)
 	struct dmcu_iram_parameters params;
 	unsigned int linear_lut[16];
 	int i;
-	struct dmcu *dmcu = adev->dm.dc->res_pool->dmcu;
+	struct dmcu *dmcu = NULL;
 	bool ret = false;
 
+	if (!adev->dm.fw_dmcu)
+		return detect_mst_link_for_all_connectors(adev->ddev);
+
+	dmcu = adev->dm.dc->res_pool->dmcu;
+
 	for (i = 0; i < 16; i++)
 		linear_lut[i] = 0xFFFF * i / 15;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
