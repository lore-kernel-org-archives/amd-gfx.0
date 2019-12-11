Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF0C2D0C8
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7A82077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OVL3K/xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7A82077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2F66EB70;
	Wed, 11 Dec 2019 15:34:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C6F6EB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfWDp1pMSDZQ2+4+DzNaAnVit4wEKfXbvwqFdc4JAAzMQqHhq7vgpbYk8Xh0enldIZz3K93xPWMnhkZJ8DRWaACWQ/moQzKKA3guX5wEL/NyUC7JPpCOTpcwhLq3BTB0vRpyIJ6SbfgTZI/7Df0JveiiLWKH6BcYxge/MTlYw4yenrPQwbmTnxr6X+czJD0N+drBpi62EAgXvZi6+90GpjD7jwuPjyu8C4cE9g6uN1aPdN5y68dFwTewUtMuTiyG+q4/xm1zb0U9Uc0wdf3KnVmjergxs/QPZ1I422eNqkVHFQ1yU0p+BxsmVXoPIsXY3CLcZAzMtjWpClRVUKwMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGWLkTWCWJVQCIr5cQHhJ06N+4YAmD42CLVAgD0LfWo=;
 b=KRVj+ISlH9dvZu/wlnBjCl1JmVvnxL2JSwTNVvLFJo8b7DQY7xu2tECA0EyA4MeBCsIGPjnm/afmlntmlmF7FFKnYYT3AfwTQdgakGvvF49bvDM/ETJxARjhjD2jhTCrnwLJTOUvrX8YaODwvqAydS+vCRFk4y+MbINMIqA0ueMye9SnR/nyOXCmGbzGcDv4W0z6Dhc1vKCfpnsi8S+BLDyHPKYuNp8aQNP4NjkvqhBPfrwIyqHuZXRqFTZmfdEmdahgVijdMtJ8hRiqcF+P858vpIbfu3/XR6g6G3Aco3jExcKkg0MHJTEr5VdMhuyQIHAonwoYy1dE5sihujxSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGWLkTWCWJVQCIr5cQHhJ06N+4YAmD42CLVAgD0LfWo=;
 b=OVL3K/xmWqNHkCWHIwO0JHX4pxvlVZBKzFaYC+1kolDCFux6vVtp2aos8QpBHg2nPSZpS0Fl9eeTeRS2niVYbMDLkumPQw9S70alL3MUq9wgVGWIDR/CO2alhumlvEiBicwAvSM0UaaO4qEmUpQhCTOsZzIwdEEoPTySppvDFu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:14 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:14 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/39] drm/amd/display: Update extended timeout support for
 DCN20 and DCN21
Date: Wed, 11 Dec 2019 10:32:46 -0500
Message-Id: <20191211153253.2291112-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 782dba76-df8e-4d98-0cdd-08d77e4f824a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491EF9705C979CDFAD4D236985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43nTBDX+ly7C7WinMmncgqji4RgUuo07qFgLFIxlsZWXlYbo+dzyiGLdVR14NEt/TN7cIYjUuxDpwRMF5qfCKVE/ch3Pwp6v7y4mcLYwPcMJ0MX/vvQX7L+DIBH75ZaiB9YcjaRNGzhN2e4OXlVV+aWRCKm4jX2e/FFgdNqLNAlf91oxoKK3ArhmXYhyYOSo2E5kgdNLp4ktXFYCYBc3sdh3pbQ7oGqytvJIU8GpOuhJJqyz9lCCtw+pV0740gW9x1id6zOyrxp6E89mINpk+XtpPpDbCPUeOOhVHSlgWE/zgJRVwA+9PZZwVQ0g2NifkMUFv8d7Y8zIKcSS5b2ErwdZf1MSCqR9ryFdiYyvuN9xyI/vZcjbQpFq81mcFoetcLlPUOMYdeYOKW7WGZs3zFYrOra4JxYux2/TDEJvPQITltkE/JFmeGD5C5aaA/OD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782dba76-df8e-4d98-0cdd-08d77e4f824a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:45.1510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN1M5UNcVEEhIAv3N39RUdFJcF9xd0aopFaBmvwKYGxdJNajSUTnPExe4ZY14qGfmG2RzZ3jgyoxg+aLnpRkSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
 Martin Leung <Martin.Leung@amd.com>, Harry.Wentland@amd.com,
 abdoulaye berthe <abdoulaye.berthe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: abdoulaye berthe <abdoulaye.berthe@amd.com>

[Why]
DCN21 and DCN2 extended timeout support cap is not set correctly.

[How]
Set extended timeout support for ASIC families to their right values.

Signed-off-by: abdoulaye berthe <abdoulaye.berthe@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1368b74d1124..cfc69919ef9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3467,7 +3467,7 @@ static bool dcn20_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hw_3d_lut = true;
-	dc->caps.extended_aux_timeout_support = false;
+	dc->caps.extended_aux_timeout_support = true;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 111f2c30c6b7..990e88cdf1bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1670,7 +1670,7 @@ static bool dcn21_resource_construct(
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
-	dc->caps.extended_aux_timeout_support = false;
+	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
