Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF3C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 21:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049E62087F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dY5n3m+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049E62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE47D6E135;
	Tue, 28 Jan 2020 21:44:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A846E135
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 21:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3qgajA6DRxr84vttpVqNNHm+HRqk/nkOMp7WIDgoZPIMf9vC0HgbbOVsen4ZKtGFfHZVEMd+G+Hg75HbuURpLdwsaomofAgKUJPEPbqjsNRB4T85Aix/ukrrw5dPzYkdNdupix8IewJhCnGmP1j2VIBvHhFpmirzOqXDxO0t9mIwEesSUh+jxW6N7qTN0xGc7rZDRc0/7A3j7PSPXD2o6sHADdQw+XpRJn7K2K9zBNI+w2WxThOpc9t1sBPx7z/QjPmOI8ubuMrBpe9/lngAl5Ih9UN6hkv/zmHFAsgJ/4eenCSzSQPoOLzcLp3zS/M9cR53jA/yOSsWhwZu+GMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocj6sSi0PWzQ7Loc3BvFeM6bYSutPtm2ydUg1GY3EWw=;
 b=KHI5ZU3J8ynlt3Ud/7fHO7tTi2i9KyuCGX/BUgRaRBl7AdI4DBLVIXm5h6wtOMFMJqQGNE+gpBi6F1DQVDXHVV4uf7caH/h0xJFQ/m9Rc5E+upl/wM4YazomTLUXp0t0oKcpuuK6roe4D7oaHDDqGNWwozHItQVeU9OibiaMuGMwH6RS3gA7UCej5qBjAM1iMmduQbqwzy7avzAG17zGVyI6wl3wo8H02lmu4Dk3kPi6D49XeXF9GI2mh/aZzONhUoEroxjJkS4tNwrm61sYp+j68mXlgJ+JiTrLq3/HmQtYagCMmQZdyvZu7fq2VDoKh+eRKCPWCQz6t7do1/CGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocj6sSi0PWzQ7Loc3BvFeM6bYSutPtm2ydUg1GY3EWw=;
 b=dY5n3m+gM9Zq3OsCSuuwFspG8DCo48KY+KGxe/72H7bQhBQrGzdyRXJUvs5cDYjlb0DUEDibrlcE4kNLpZ10ULEEfCaw54bCN4GQcWf2QDPVRGJqw3dkYVtmsRgrOKXvnEG2d3Ab4TbI6mnol/AVx/WTm6oCOvf1W/rHFiiaQ34=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0139.namprd12.prod.outlook.com (10.174.247.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Tue, 28 Jan 2020 21:44:37 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845%9]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 21:44:37 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Mikita.Lipski@amd.com,
	zhan.liu@amd.com
Subject: [PATCH] drm/amd/display: Move drm_dp_mst_atomic_check() to the front
 of dc_validate_global_state()
Date: Tue, 28 Jan 2020 16:44:24 -0500
Message-Id: <20200128214424.43253-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To DM5PR1201MB2554.namprd12.prod.outlook.com
 (2603:10b6:3:ec::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (165.204.55.250) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Tue, 28 Jan 2020 21:44:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d4344a3-65d8-43c1-9e99-08d7a43b4563
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0139:|DM5PR1201MB0139:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01392DC86C81AE7F1B6DB33E9E0A0@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6486002)(186003)(5660300002)(81166006)(8936002)(81156014)(26005)(86362001)(6506007)(6512007)(1076003)(16526019)(316002)(52116002)(8676002)(6666004)(36756003)(2906002)(2616005)(44832011)(66476007)(478600001)(66946007)(956004)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0139;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kir+5xVkpFbRolECHjxEVqBC6g6JqxmPg+jbg0dxL5ObbCD2IyXlGCFoWNTsM8rRyowkCEcjkawNDeuBz2KVCVmQnSUR2N8vLVEJBqa8lnAi95c0e0I4r0HayNAQyIF9TDbR1nBH/5ioCEGlJbargPzK496+lK8Z1pnXDwRII0z9Zp6WqKomsJYyNFyY6XyAGA5LIUJDIKOis0SdJsOuRZLVZA/cOZKHZo/MvPepurniLE3NOOpU00NP+LgBv88zsQzu21Abf15A5fPOSQVHJFjswPKJQc/F4hjd57hC/O1slFtec7/lySMnxw51Ktf1U+boFi2mo2V0sWLpunV/msq8mrmdTCZL1/lQTAW3Y7eS6AvEFoDvTT7RtQFqfgx96HMVi7sunF1Tpl3EfB+MMhn5aq+qTb7cU2lVMqpc19mVKr5FwGYTtZAraLsIUlAQ
X-MS-Exchange-AntiSpam-MessageData: TnArv0+sFe86CFD0KQtBrMu3gOF53iUUR2gy/U5a7nJxz9I/b11iPYxMkgEA6zg6Xz0m9OSHIBp+XxyscZShg0KVYXTqqRFqcow4RcWOSno3RGyp8mfGPJ57Blcl52IunS/WS2axDjT3+3vprCxL2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4344a3-65d8-43c1-9e99-08d7a43b4563
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 21:44:37.4015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uU45O6L8c/69nxlKOQL6MF5VQ+ls9lyysqoZU8muzpfntTRc2vPgnKlgBh65F5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Need to do atomic check first, then validate global state.
If not, when connecting both MST and HDMI displays and
set a bad mode via xrandr, system will hang.

[How]
Move drm_dp_mst_atomic_check() to the front of
dc_validate_global_state().

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eed3ed7180fd..805d8d84ebb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8256,6 +8256,16 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 #endif
 
+		/*
+		 * Perform validation of MST topology in the state:
+		 * We need to perform MST atomic check before calling
+		 * dc_validate_global_state(), or there is a chance
+		 * to get stuck in an infinite loop and hang eventually.
+		 */
+		ret = drm_dp_mst_atomic_check(state);
+		if (ret)
+			goto fail;
+
 		if (dc_validate_global_state(dc, dm_state->context, false) != DC_OK) {
 			ret = -EINVAL;
 			goto fail;
@@ -8284,10 +8294,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				dc_retain_state(old_dm_state->context);
 		}
 	}
-	/* Perform validation of MST topology in the state*/
-	ret = drm_dp_mst_atomic_check(state);
-	if (ret)
-		goto fail;
 
 	/* Store the overall update type for use later in atomic check. */
 	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
