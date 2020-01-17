Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E1C33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 07:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455F820728
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 07:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tL6RWryV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455F820728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34696F3F0;
	Fri, 17 Jan 2020 07:48:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869A06F3F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 07:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8zMM1sO7xJ7Dur554AtNE9aqHOnCLgBRJjvriO70Y2Lj5QTLKKmgA5Exsek3xLmnpyorhii+yNQGas4z+cqcn1AkFXVO72pDZUAQC5qzdXiHxMaXLMYQsKw3TDE+R375XwLL69SXizYTf6gz1qFb4xj0ox/ZZbTrkXtunvz0UcMzvJxttL62W8Fo7rdacG+M2lDlEx952ZB3iZQd6Qjl++VAQs6TrrNXtpIO7+KKBxG6s7tChR5iJ60vL2kpxlfB2zLf//yZxLfznqU3aSm4VDJpf1zECBAGqL14aqAJpOiF3cVGVAWKkLUP9tV23NEUfH9qLhVdXNuBl1Q+KaKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI8+c5yDuM5TS/qLBD89zCh9nPQgr/RoS9JEl1VqAlo=;
 b=BTDLFwUqa6o4jEkvP6WyBv0j1d7X/hqcWfpbDw1kWKgxgYiuLct5HsnaKl3gi4ihYTERaCcJbfysibQp78j50z33TBZUpeBddQbmy/ZXndAvnMO7Q7BUW40dkOsxsc2GW+eQayzMwnCFSRDF4dXrPwygiWX8B+vIynw6G7CVdHi9i1eGUIV+jsCNsKih5tsTVJmQtJPi6Q5qltAo1oNU4zBNd5V2pJJwsKeUlIkvPb01YzYhhxTw2qYl22wFitPCgX3u2uBE60El4MkigUigBobHbGfqa4v8hD+zEyzx8BCfk/F5AICQPBm3gXU1nNyPKKRIa2mpsBkp6f1a/cy+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI8+c5yDuM5TS/qLBD89zCh9nPQgr/RoS9JEl1VqAlo=;
 b=tL6RWryVqgzLcZEAbDwyYufwH4Yh7CxGLJbRuVG/7Pka/osoIm46E6XHfG45IrdUF/xG8hlq6Trc9uGZSdQdVc8qLNok3uUt2gfGbrI61/tuvalkxEOX+1+FlL6paljMkxoGEmqqwe6mmXSuwRe6ela9TqReftkDVBAViy8oM0w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3454.namprd12.prod.outlook.com (20.178.242.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 07:48:23 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 07:48:23 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove the alignment placeholder for secure buffer
Date: Fri, 17 Jan 2020 15:48:10 +0800
Message-Id: <1579247290-16320-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.22 via Frontend
 Transport; Fri, 17 Jan 2020 07:48:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0207147-4e00-494c-e434-08d79b21a0d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3454:|MN2PR12MB3454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3454BC393987808938462CF0EC310@MN2PR12MB3454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(6666004)(316002)(81166006)(81156014)(54906003)(36756003)(86362001)(26005)(6916009)(8936002)(186003)(16526019)(52116002)(8676002)(7696005)(2906002)(2616005)(956004)(66476007)(66946007)(66556008)(5660300002)(6486002)(478600001)(4744005)(4326008)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3454;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMBnjeSPnb3u0ohqCGffNZ3m8uxmzOOzt+GmQs6UJSSwxkhujsMkZGxEBQSCbYDPltO2PimSRpLf2IPZ/48fT4fHqUF1BQnPNUiIZEXy03DudKpTcho3CabDQSGNSLxnKO+EFguMc8GmPfKpj4Kf2RwZwfj/M/ytjze/tbhb1N7GXIyYDyfd/3zbjqHYq9O4XtaMmucXo8fMOD3d79wNvxdmu1/c+z5NhL316N4G4C2vxR8XEgPuVDG7W3A0HSuu7xfvkcpsMKlKwJXY6xPOWSi6sH3EivM5NqgjVH//3RXDiiRr53GtV2GLBqWSd9iaDD1hH2oDeSN47lUYv+VLaR+hmrCukITpo1GE+pBCDYJvr1U/hw+gEOpC9zfFzsGYs1ooVZGwki3/lkezX4Pw+cLQiBHQxq/q+7jX3nXBMWCRw3IrK/aTqZ3Sm63UHeWOFuRQrS3Dk9zxCc5LiQSlwm0al3PUimAtWkojqgn+Az23OafKdC2R1Dtu6uWoMuyw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0207147-4e00-494c-e434-08d79b21a0d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 07:48:23.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuZsU2/GCIw1aiNZpGwHGz4uji27NphwpbRETPVrnmjJ/2mqv9FSvpwgj0iobTYGz8KCbFSxelZ2V+P2W3pi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3454
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The alignment should match the page size for secure buffer, so we didn't
configure it anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f39012e..41d49a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -261,10 +261,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		resv = vm->root.base.bo->tbo.base.resv;
 	}
 
-	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
-		/* XXX: pad out alignment to meet TMZ requirements */
-	}
-
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
 				     (u32)(0xffffffff & args->in.domains),
 				     flags, ttm_bo_type_device, resv, &gobj);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
