Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA1C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2A72082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ft539hro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2A72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1C36EA4D;
	Fri, 10 Jan 2020 14:47:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CA06EA4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyCVX7O2kc8GhaD/5DtqZxpn/Nmb9Lw3wMdmgjPeO/ReJ4Rv1AFhvAyXU3mifbrT14bxdrZc8k0tDn44amGmo0/3bhc4hIF1hdTuM8++eZql+WgrZ/wGC0ZgE+yQV9eBkeK4PUWmBtuHAgbTyPS0NFljH+Gttl+wWaOWr0T1EWhihzoEKcFmP167u1bSHmsrZPsu6dX3H71y/B1bvhKW915Y0uSd3RhNfM/oSZ7VhvuKsE7rAkmK3HFKuX9PM8FXjSKu694rccHiUyHVMSr0elPbKitAp8QZMa4VdwLBb3305ko/jtN0W8KxxSZKPyN5amMKqtaoZOBVTSsAOVzWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vi+jj1tyPCX1shSwbLryLT6c5k0ZVuuAISFJigVEK4=;
 b=Sg+qk6vAaTIOPzp7C5dFWZ9Nw8yy5lJxEOE/kG27OTwljiggXswlm4qWihybGvvPyAReRoK5bLYQ7W0vuGs5gp0EVCkDf7ra8Azag58rSrb+MpbX3+DepoDSvgbYgmPI+Vros5gg1dWZ0iQu+iOJX8xhdtXV/d7kmcu7hXICeNfCSLStbXN350OYQmS74v5T/Fv7CmI4qrdg2K8iLYSbmW+Qx5ExlQiJldfgfvoqoG/XXgdvuG0j3ggnsHiG0vVj52YJSxIea85FULwRf2uaptByYHYkbyHyDDxKisvAdq2MOXQdPGpkibMDz4wUIV2XWXkKlU+a+N19oUyJ179wvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vi+jj1tyPCX1shSwbLryLT6c5k0ZVuuAISFJigVEK4=;
 b=ft539hrowx9DceOFeGqdZ3m7c2knRX7XcuvSUDAIKSaTgVmscS/lweG7OzcveS+DMLx3ASy/Z2YSZfsBOmuWuxnk6J1IpdUzvtE0KE0ERDtYewCqkcvLrSEQlAFveNnFddt12YiY9eN+87Q8/hEoREYghRqZgPeahpCtjfkkT4c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:47:44 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/43] drm/amd/display: Add w/a to reset PHY before link
 training in verify_link_cap
Date: Fri, 10 Jan 2020 09:46:39 -0500
Message-Id: <20200110144655.55845-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:44 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4df5b23c-1ca1-44ac-05d9-08d795dc0d5b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB237862438F2A0D3A4A352CE698380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(15650500001)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdtfV4FVsitrxS7NuzQpY4S7oJ3aZkFF6W6OnDxOfvBYTD89sQLwcC/MEC0JZ1wl0KeIYm1V/2AtLDPeyHDLIhIJWezZ161oc/42blltOBzzbb/sSioycUL3FhTUuMB76/nl/ersndS6A6BBWZxpc7sw5m9uL4eM0FUIMxrojD/xuDFX575jvRuod0XU5e0MXUXmi+e+gVoGtB49MG3lxbqdba4DsDBY/ho89VGGtzI5mA8FgBOgPrrRcs5EfbciZroidsj9pyfFZ1Qr87btNrZbAnF42drcUNa6buBGl22ZezZFhNAll0+ONYEthZKl2JhfDQmoEVASBCq1Nsx9NEpJ+TjDUI/r4+W1nbfrbPfYTlXZSIbbwKU0eKHz2ulxnCRGKDO6ZGUfxKj9UKbAXmQZm+dbcnUQVpiGf/OQWdvaAvIaeUn//78Z4djrJCne
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df5b23c-1ca1-44ac-05d9-08d795dc0d5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:44.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdEWYSyz34OWozLS1XIExdHY9qO26BKITQK+A52GZThCWkdXbR5eufussWHq9lElJ7AQOWz7E1bu5xLldQfYpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 George Shen <george.shen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
PHY will sometimes be in bad state on hotplugging display from USB-C
dongle.

[How]
Add additional calls to disable and then enable PHY before link training
starts during verify_link_cap.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c      | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h                   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |  3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 46f16a77e3a4..ea5a09ca3334 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1892,6 +1892,16 @@ bool dp_verify_link_cap(
 	/* disable PHY done possible by BIOS, will be done by driver itself */
 	dp_disable_link_phy(link, link->connector_signal);
 
+	/* Temporary Renoir-specific workaround for SWDEV-215184;
+	 * PHY will sometimes be in bad state on hotplugging display from certain USB-C dongle,
+	 * so add extra cycle of enabling and disabling the PHY before first link training.
+	 */
+	if (link->link_enc->features.flags.bits.DP_IS_USB_C &&
+			link->dc->debug.usbc_combo_phy_reset_wa) {
+		dp_enable_link_phy(link, link->connector_signal, dp_cs_id, cur);
+		dp_disable_link_phy(link, link->connector_signal);
+	}
+
 	dp_cs_id = get_clock_source_id(link);
 
 	/* link training starts with the maximum common settings
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ecd2257de80b..8c7ff9e322f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -421,6 +421,7 @@ struct dc_debug_options {
 	bool disable_dram_clock_change_vactive_support;
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
+	bool usbc_combo_phy_reset_wa;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index f1ec3448c0c0..0c02120311b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -835,7 +835,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = true,
 		.disable_48mhz_pwrdwn = false,
-		.nv12_iflip_vm_wa = true
+		.nv12_iflip_vm_wa = true,
+		.usbc_combo_phy_reset_wa = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
