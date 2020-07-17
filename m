Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B7C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEC420737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QXQBTwUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEC420737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374656EE18;
	Fri, 17 Jul 2020 17:38:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB406EE17
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAnjL8IpOYPKr0qqcijf98fn0cHA/vo44pdnlcHWcFcH48nSj+yvmcw9sD84cIbjJ8Awv/6IoMmTEaRYIN9ECTOhRPxFpKQSSgub6w55qB7DEPrxBP/ppfgwnRqqO+eDL66EziuRh22YqZtVK05Va0GgurB8UyN3HBC16IkN3apWrQYaKUHeoMy6FLlaQy7n0BynXNsTuAd1VMjrn6/UXDwKFOGccuDx/pXMAdbuOKLD66DXqzur+8mq0Iw2neM5kl0CdN1+rC5Cf5W9zQjvE2IfROjQ720z8QtKNWUWkRVlJLVMV23thpRvLG4hBJvS47gkltw2soBaOBvfSraE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWdOB1uCisSc815KcMBAx0NB8l/QZGizjgPyehAWWDw=;
 b=aT1nUJehk/jIuRwmYw361Vcz5ePtv5MyLYgil7wU0Nz0Ioi3AH5m93NR2smyQoxaAQB4QvfnXW6cYfDIU3uRNMmurRDvYOPLWyayRpoJATlrtoY38T1M25knGN1vtws4gF8IF16+SP+fjejOtn99EHNoIG2fmErCUPyADVMypsI04zIhZCwYo7VeippVN+EQ/+PmkLulawvA4c2Y6xA+j6y9gohshTPR6voZEhCdrNk4IOG6oZFXqJXrvDJNbKqTqBwcC1DZMuUhedKtp5NTWdsu4RPVpO/rTzpWrVErmYfoHV5sesKK2f8fdQL60Z4zurGjvNkcxgWxjZXFSzY7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWdOB1uCisSc815KcMBAx0NB8l/QZGizjgPyehAWWDw=;
 b=QXQBTwUZ9EwfnqaivPnnIuOd38RqZn29Wx3rWyYpbub2BAxMaeeL+865JaLN3xutnEOQoTE9p/S3iPMRZLVz0QPwfgOAqfkkr8uWq3m+LnECiCsr/isMEPxZehdnkPfD3PKlegfgQ2rEmEabCp1vjXL/BBWDNGi+qA4hDEJtaiM=
Received: from CO2PR05CA0101.namprd05.prod.outlook.com (2603:10b6:104:1::27)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 17:38:23 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::c3) by CO2PR05CA0101.outlook.office365.com
 (2603:10b6:104:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:22 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:21 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:21 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Decouple ABM init from dmcu
Date: Fri, 17 Jul 2020 13:38:05 -0400
Message-ID: <20200717173813.11674-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(8936002)(8676002)(4326008)(478600001)(1076003)(47076004)(82740400003)(54906003)(83380400001)(36756003)(81166007)(316002)(356005)(82310400002)(426003)(2616005)(86362001)(26005)(6666004)(186003)(70206006)(70586007)(5660300002)(2906002)(336012)(6916009)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f33b90-344d-48d3-fd74-08d82a783416
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40758F47467BA9267C2768C1FB7C0@DM6PR12MB4075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yx4rVdCBwcymfaIVBKs0jgF1UT6yTizZ22OuOPSJePrXccFCjdlZafnvix56NLW0YFVMbvcvERCXKu7A6MAlt43QqAuYHpwB1JGznXIQ9PVMmi7Zuha8jJ74XNMqY9hL2ia9HT/vyXO/HDu4mc9aRJ/ykGcJhjOWtpTxiY31wVZhD2mwEILZo4LBFzuFovy7ED3jXFtTvhZIRqKg9RoXulgyCpvpbqoxWBWbVgW0AVBONw5fervc6P660dLjkHFg/g1OvEfWL6pa29KPICZBXqaxa+mNhoYgS6l1lUk6lkCb0vnvQdAX/ao15MDeBZ2cBxlgDm/IybTeT5hkxDS2C9bNKVHNKIjKYfib/F8jov1r2sOSeYnQh4j/QKhKXO1kvG7nbGYKm8Yt5h8O16YQ4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:22.9730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f33b90-344d-48d3-fd74-08d82a783416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
With ABM implemented on DMUB the ABM enablement
shoudn't be solely rely on dmcu. Otherwise it won't work
if dmcu is disabled.

[How]
1. Decouple dmcub config copy from dmcu iram copy.
2. Set abm connector property if either dmcu or dmub enabled.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4c033952eb01..f46db2f3c620 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1374,7 +1374,7 @@ static int dm_late_init(void *handle)
 	unsigned int linear_lut[16];
 	int i;
 	struct dmcu *dmcu = NULL;
-	bool ret;
+	bool ret = true;
 
 	if (!adev->dm.fw_dmcu)
 		return detect_mst_link_for_all_connectors(adev->ddev);
@@ -1395,7 +1395,14 @@ static int dm_late_init(void *handle)
 	 */
 	params.min_abm_backlight = 0x28F;
 
-	ret = dmcu_load_iram(dmcu, params);
+	/* In the case where abm is implemented on dmcub,
+	 * dmcu object will be null.
+	 * ABM 2.4 and up are implemented on dmcub.
+	 */
+	if (dmcu)
+		ret = dmcu_load_iram(dmcu, params);
+	else if (adev->dm.dc->ctx->dmub_srv)
+		ret = dmub_init_abm_config(adev->dm.dc->res_pool->abm, params);
 
 	if (!ret)
 		return -EINVAL;
@@ -6318,7 +6325,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
 
 	if (connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    dc_is_dmcu_initialized(adev->dm.dc)) {
+	    (dc_is_dmcu_initialized(adev->dm.dc) || adev->dm.dc->ctx->dmub_srv)) {
 		drm_object_attach_property(&aconnector->base.base,
 				adev->mode_info.abm_level_property, 0);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
