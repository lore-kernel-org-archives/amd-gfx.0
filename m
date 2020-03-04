Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F19C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46291214D8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 08:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ai3nMfGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46291214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB6E891DD;
	Wed,  4 Mar 2020 08:18:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760080.outbound.protection.outlook.com [40.107.76.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6756891DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 08:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEwgHeMaKkDzRKyG37i7/78HVSi4HhtlCjlCUuDYpjroUA67uCxTE1FmQWefRGgbcCfqB3u1JwNNVOux90FbuZR9ayFirhzfVXVhew50BSondEtMbp2MpjbYXMlnUl/OQ9yPZmC8jPG52MAY8GSpFmDo9nFeeDB73fm1duA/fZxa8HZpQQc0/X/EWH23RY52HGRMknmO6Bq6DzD+/QQvVmGV9WeHXzu7K+YEoCPpn58RLRP9HsHFJ2xX4SYyY2HEyWTl5V87XwKzxRc0UhxVhLw+gCJiQ3vV1Sq8csWTP89kzhwWaHVaQbTaYcA9JkuILM8hrnh9BhWsuGqPSUlt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRPY15NioyR6O4l0qughZKbTg0w/t0DWyivDuKahLJI=;
 b=AE5jPYpxPS01rQWbDUNmKjT0sR5sgDfvBKdyV7TprZsWPt9pmtUJQepeMOOAgVpIgab4x2umUhK+m0Z9o3sRVy4WSqVjby7YOftE2L5BLo7Y3CEewSPb6SvGMV5K+3nJFrYV7m2l+PpYx5LGgwI+3j8SC1ZgHipbv0n0L51Yvy46vWNaesDA96yUdQ20+Xh0RPLZOA9+sSy0pahZo2SfppTskSbwB580TtuFh0CVcRc7lmgT8fVMRqbqvC+MF4gNZ1pCxbF8fi/xgDI5Y2edHJCbu7aW+o2Lw7cyvz74OFRCLkSbRuco6hapOM5OBzmc/oNJnB5m3NS8BrrruLjqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRPY15NioyR6O4l0qughZKbTg0w/t0DWyivDuKahLJI=;
 b=Ai3nMfGU3t1O3qEOc9uKoMCodv9sdl/RCsCexlZsKhlX+O+1KBCFxMi0/lbcyRoZV4a4t9drrLqXS/PKDlcFQzotvwL259r6G3B+hL/96esRZxb/jE2i3do4uzbRq30Fffv8/XgegYqFBcNcMv3TzlWY7tOy1Nr7TwUEL4dxoFg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 08:18:29 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 08:18:28 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: honor the BACO setting from VBIOS
Date: Wed,  4 Mar 2020 16:18:07 +0800
Message-Id: <20200304081807.466-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:202:2::33) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0023.apcprd04.prod.outlook.com (2603:1096:202:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 08:18:27 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1e7be20-40d1-4058-55db-08d7c0149e4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4343:|MN2PR12MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4343C2E12058B03519A5A37FE4E50@MN2PR12MB4343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(86362001)(316002)(4326008)(7696005)(6916009)(52116002)(8676002)(8936002)(81166006)(36756003)(81156014)(16526019)(6486002)(66476007)(66556008)(66946007)(1076003)(956004)(2616005)(186003)(478600001)(2906002)(44832011)(5660300002)(6666004)(26005)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4343;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAeMGx5GodRfp5OhfrkjloH+b3g1uEp3dkSwjHqLM+1qlQyrnG/RDomJs00+9LiBNoKQWRbfGrC8dcOjk5i0x3e4GJ+EwQDZ1eTZb3LIVZAvherzhS8hDX8qGgzZZEduttAwbrOCDtZsVusMiC1WKgmRNcIg5LHGJdQwTaqz3iKVJSLtZYLVLUD5A7p/P2UPl2En6qAkNcyj1NDJr9ZDp2cuHa9RcuQNNAHjGzUkKMg+/35yQLMz0kCoM/SYtdcjlzVAcu4SeiEQvC+OnGvUWAx6y9xyg1jk2Q+/ynA/kugOEzgH3cmTbBcbuI3xt5oqC2w0FzQxWm87Kr2Ql/oLH8mjCW2pf+uCwGlnt5t8pk+B+s3ut0jVa27QTBjUvB9FbaKt9hwj2QW0OmWaabIiBNE17I+3/s8T+GBoLHA3CZiogJG1lbctsscWUvHl8AMM
X-MS-Exchange-AntiSpam-MessageData: zF7Ns8TH9iuDBdHCyC7XpMaFEk/uQhohCopeZDQZiUjv9JSIt/jHzJ6hmIZ7sLCMw8T0Yr2ga4Sv0XsZ8HaCuDXxABJC2OtbAaQUG6WQMICmxRevdTmY3K2sdzWxVxSqsOOpU+8N3aN+orDNO25DHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e7be20-40d1-4058-55db-08d7c0149e4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 08:18:28.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZs9tqe6z7j+phRkSa5UlRD5ZOxb5kIthg3Mf9NyElTA/5UlxbuwLUpPI5SSP+ov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Should not enable BACO always on Vega20. That will
break the VBIOS setting.

Change-Id: I2609fc3f86dc785d385d9320574446810b5b693d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 08b6ba39a6d7..eed4da1131d1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -182,9 +182,6 @@ static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_TablelessHardwareInterface);
 
-	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
-			PHM_PlatformCaps_BACO);
-
 	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_EnableSMU7ThermalManagement);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
