Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B39DC47259
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6AB2072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h4N/NcJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6AB2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF226E1B8;
	Sat,  2 May 2020 21:35:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984506E172
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6zvcjNsAjrbOSd3On3A5GfF27FgfuNFYUDyiMy/6orYab1QwHrQcN87CPpODqkQmC8baFqgt+UoC+IKWCfXelcslbTGw9+6P+wnVIOCWqq2qZa1ruIVFhCs32yGCKBTFF/VLh65hZ9Mqz+9RlSe1ltSbZrdBNl654U8dYZsLigXBSWXEgv7wqaUXXmIx0pLAoueMuifkxOH4bcZbaHFv4UtXY8wbdq/SGfXKGjV/CBsWaVzI4GXLGIY8C89ilx0q2crUs0WfO0qfMQy47bncUxTQ+wSt+UxKPlCPqlPHQrVeZw5IZXkxNzdnA1rHyJ9uUQRrmLs142ClkfE4i0ngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbfzZYCic3iiI73s3oqu7m+jSMQdbrS4FhvdGiqf5Ns=;
 b=Di/y9v7TkAHtGUQv4BeMBWyvbStkfPZ3/vNWXC65OyUZOj22jxZqRzVwSSyINS2E1hBZpJ2ngHRYEHiQavQlib78drIrwAFONIp+3v6UxEMjnJ9aDXXfBgvFuJGoApSiMSWqBSC17zTuzvOkaZ74YlpaFVYBAljTy8wkxc8B85o98/rsi4xKm9ncuZMZey6CuUinxxh6JvOgaVTU/c2FXL/Kuhr4glG/ERUf5tMdkAJ8S7NAjyIoMOLBkmDF1HeLKeeVYK8ciP6TLEF91vWJdX3uwOqICoGwPYhVBERJ60RdGL+Z5gpSHSPofQaj6Cr1/3dfaXbrQotFinkBGdF5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbfzZYCic3iiI73s3oqu7m+jSMQdbrS4FhvdGiqf5Ns=;
 b=h4N/NcJp47tfrq3dVpXkK069L2ciqou3QduF/g7jnOtqkp4O5U1xID5maC3d4JNve00EksTFy0RGetkNe0rtjzC/Zab6Fa9UN2Z42NlIW3NNhJQ35B7YtBdS4NwcB+gyAsg85z8pIfxSFmCScdNF4mz1uzmZptRTsZeo0qUgZZM=
Received: from BN6PR16CA0006.namprd16.prod.outlook.com (2603:10b6:404:f5::16)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sat, 2 May
 2020 21:34:58 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::90) by BN6PR16CA0006.outlook.office365.com
 (2603:10b6:404:f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21 via Frontend
 Transport; Sat, 2 May 2020 21:34:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:57 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:56 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Prevent dpcd reads with passive dongles
Date: Sat, 2 May 2020 17:34:38 -0400
Message-ID: <20200502213443.39232-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966005)(1076003)(70206006)(5660300002)(70586007)(26005)(6916009)(2906002)(8676002)(54906003)(186003)(82740400003)(81166007)(6666004)(7696005)(4326008)(86362001)(426003)(2616005)(47076004)(336012)(36756003)(478600001)(8936002)(82310400002)(316002)(356005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 850f3dd6-f75f-4a76-f7a8-08d7eee0a946
X-MS-TrafficTypeDiagnostic: MN2PR12MB3823:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38239CB7EADF6B9B10D3AB2A8BA80@MN2PR12MB3823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxuGEqXoLvKNvUUZarNg9mKWMVdVKdLdlU0AkGRCTgtAC8gkNJE7dm0A5BmN7JJsqmxrwMK+5xz+a12WPaDF5MOkMd9hll6kCeKmEJ6dd9jVeSQdL+Yd6hqykB7UzNXl2Z8RStHIXjfF//vTztf/8ja5Q3UZeUAW3v0OX0KzCsiV9k5XfqKAx3Xbhi7g2vo7KtM3xMtXOJQjYTS4XhV0wbQATQUipounBlq8c7AWyHikqPT7fgbWc5xPlaEzgJY8HIZgqFsxUfOQMOev6n9e2eK+MRfSN+IaZ2LiQWMx704sTg1KxZh63Ig4hBXZdulyAWvrXPNPth8i+e+8Nv5s8QhMTFpWj+jA/oCY1TPGCRPNQxBcaNmP1OdhhagKOkRMEi6syx/4UdKZNd7Bfnlyrwsab7CzIpPPpOOyC+oHvZU6M0cm9WwoSYBQBGl23utWf8mmU7a0+zGmibrcx8M04dqRBxexyC8QH1UyTUa86NMM6P/CBpJwHzLj2XpfiRkXMdUd3slLCK3g1qyDhqN+MQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:57.5880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850f3dd6-f75f-4a76-f7a8-08d7eee0a946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
During hotplug, a DP port may be connected to the sink through
passive adapter which does not support DPCD reads. Issuing reads
without checking for this condition will result in errors

[how]
Ensure the link is in aux_mode before initiating operation that result
in a DPCD read.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2b92f07e4bb9..9c56e240cc8a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2013,17 +2013,22 @@ void amdgpu_dm_update_connector_after_detect(
 		dc_sink_retain(aconnector->dc_sink);
 		if (sink->dc_edid.length == 0) {
 			aconnector->edid = NULL;
-			drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
+			if (aconnector->dc_link->aux_mode) {
+				drm_dp_cec_unset_edid(
+					&aconnector->dm_dp_aux.aux);
+			}
 		} else {
 			aconnector->edid =
-				(struct edid *) sink->dc_edid.raw_edid;
-
+				(struct edid *)sink->dc_edid.raw_edid;
 
 			drm_connector_update_edid_property(connector,
-					aconnector->edid);
-			drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-					    aconnector->edid);
+							   aconnector->edid);
+
+			if (aconnector->dc_link->aux_mode)
+				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
+						    aconnector->edid);
 		}
+
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
 		update_connector_ext_caps(aconnector);
 	} else {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
