Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBE1C56202
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 17:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555AC238E6
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MV7NUK07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555AC238E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E7989CBA;
	Tue, 17 Nov 2020 17:14:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3398689CBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 17:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNDQIlXqwLvI2BRvTBmkfssnccyQg8G0Ec4bduMDija80ARUXrsLpqe70PnueeTGGyatBbx//IU9PKIOD8zvATsW7OxXdWOfiX+4/Bw7Mz9HUb86d1S3ozLDG4mdn8qmsvsW4M2a2h1ZGVGPGgVBaOgtL/hUImoTVNqnCJgmlZXm2k41pKBs2Mi7Ep8cwQzGyIuoaY2PLKJzPoPUthLHCIajnIjKwsfLq4k+UBwOjlL7taGa7j/r5qYLosqQg0VqnFTXHbtJ1hxWLKhWHx3NBbQy1GZ7tFJ9CPhqxoETIq4uRi5btI64a76xt0yFRRt9IDYD4/HH4FwTI9Ez847yTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaJYmWHTYdkyXq8D8VSVBTwmxXtPKVMmyow53eqQ8B0=;
 b=aL72OIrAvWrO1sv3+ZX2mvruIVgZA5h8opAagJc0UoPgtsLDnoDt/qX/l9HekgSrfHL7xUiBMqGVmGfHTRdw2cEVIcL+wm5LOIWAPM6YwWOokH/0Sr2RFouR/Ni1KOqAj2+dx423VZ++k/8Ktw+inxEjYNoEXLh3UxIv2uE2Kf4KzvG8/s5XugGnZfVDjIY7Uf7NexQfk6Aj/xAXCD1MncvDQGO8knO0OxJk/2yLK4kRVW/UUUwKvIHLopTx+HOZUW+dkXBZRKZnL5CIt3awTZ0Yg8MJSAvImj6AohlZnu7L/AarugU+cyOKHgB1NRzMA18d6V2+o+qgbypqCALivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaJYmWHTYdkyXq8D8VSVBTwmxXtPKVMmyow53eqQ8B0=;
 b=MV7NUK07/Ezpwz539QVzHgRjnVVlxKqQhYX/BQbsm0DA7dum7ZBCek3//MoMXCFWfuBglJN7HwMO1kmxQrCIzYt1A+jWiN4qlpomObaUGs855Z9nyqrxFHyb0SWDjSPZYfNWUGkNnKfa5/gW2+FfzxwicJarLuFL8x7KqvBtzA0=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 MWHPR12MB1887.namprd12.prod.outlook.com (2603:10b6:300:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 17:14:27 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::18) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Tue, 17 Nov 2020 17:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 17:14:26 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 11:14:25 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 17 Nov 2020 11:14:24 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Add comments to hdcp property change code
Date: Tue, 17 Nov 2020 12:14:10 -0500
Message-ID: <20201117171410.330150-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117171410.330150-1-Bhawanpreet.Lakha@amd.com>
References: <20201117171410.330150-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd99a5d4-04dc-411c-ed11-08d88b1c3c80
X-MS-TrafficTypeDiagnostic: MWHPR12MB1887:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18870917DDDFB35F5988F579F9E20@MWHPR12MB1887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6G9aUuNON75v6pEB1d+Fa2nhB2HXTizC9n0W5lGQAjtAqmd0fdSaYHih3fVH+P5PZn7Tl5xvPw+ikbhsXSdLjWfxM98BlmQtxFUQcg3RWIQSWECArFyJj+9Fp3WLkbDV70MzT5I9vl/F+KuXdMenaGWxW2uPok8SYA+V4BUK9c9PmhIU4QEhLhQLsUHyVKhjzuluSkgjtGOo3bD8Lv0m5YiHVOl+8u7NrFXD32iKV0TWRgd9L/zBcbuEJ+wl0Fn28cWX46/T+Vdj8LIufcsJSV4JJQ8PMz1U7r+iEQrU/5bqXEM1eNkvlFI1B8/jVNzjRbf6f4FIa4AE1ZbPpaek5dgzfZHhJtHgn22JQOBnTk9hTqDmEMeTYhwg+QjIka1ahDpzlUTCnl+PPNp5VxJSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(70586007)(70206006)(81166007)(356005)(4326008)(47076004)(82310400003)(6636002)(1076003)(6666004)(5660300002)(36756003)(7696005)(8676002)(54906003)(82740400003)(8936002)(2616005)(478600001)(83380400001)(316002)(6862004)(186003)(37006003)(426003)(336012)(26005)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 17:14:26.2333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd99a5d4-04dc-411c-ed11-08d88b1c3c80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1887
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
Cc: Zhan Liu <zhan.liu@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
These comments are helpful in understanding which case each if
statement handles.

[How]
Add comments for state transitions (9 possible cases)

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Zhan Liu <zhan.liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8df290388d8e..59052498119e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7326,26 +7326,35 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 
+	/* Handle: Type0/1 change */
 	if (old_state->hdcp_content_type != state->hdcp_content_type &&
 	    state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
 		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 		return true;
 	}
 
-	/* CP is being re enabled, ignore this */
+	/* CP is being re enabled, ignore this
+	 *
+	 * Handles:	ENABLED -> DESIRED
+	 */
 	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
 	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
 		state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
 		return false;
 	}
 
-	/* S3 resume case, since old state will always be 0 (UNDESIRED) and the restored state will be ENABLED */
+	/* S3 resume case, since old state will always be 0 (UNDESIRED) and the restored state will be ENABLED
+	 *
+	 * Handles:	UNDESIRED -> ENABLED
+	 */
 	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
 	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
 		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 
 	/* Check if something is connected/enabled, otherwise we start hdcp but nothing is connected/enabled
 	 * hot-plug, headless s3, dpms
+	 *
+	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
 	if (dm_con_state->update_hdcp && state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
 	    connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
@@ -7353,12 +7362,25 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 		return true;
 	}
 
+	/*
+	 * Handles:	UNDESIRED -> UNDESIRED
+	 *		DESIRED -> DESIRED
+	 *		ENABLED -> ENABLED
+	 */
 	if (old_state->content_protection == state->content_protection)
 		return false;
 
+	/*
+	 * Handles:	UNDESIRED -> DESIRED
+	 *		DESIRED -> UNDESIRED
+	 *		ENABLED -> UNDESIRED
+	 */
 	if (state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED)
 		return true;
 
+	/*
+	 * Handles:	DESIRED -> ENABLED
+	 */
 	return false;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
