Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA53C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DDD20720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sVsK0eQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DDD20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBBF6EB70;
	Fri, 10 Jul 2020 04:48:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE886EB70
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef4PHkS0miwFanDdspUlKVEQDt0LhmBjg0966ZPtqBDwlkH0NB5W4M/t8Zi14Ike7GKTm0LQw3orZQq0jwG5jSS9dHqNRkz5MZEI+zXvc97WIBjZVFzcnfleGNGZnHrAsXtZ+1LDMQy8CMDA83tSP5da2h2GHslzjPJ0NBtNSvoNaUf340JnMqQOUZpqdEtSWRoh+EovH8yO4lR0bsWBp0wmqeqLNCZh7mrhYxz2rcuyPpHH4Osd0M7tjJ022z3OOyFifjaANvdCNGeZRLXXy2rTMyUre/p/uwcXCIhUIYcmxJhdNJCNJT1BJB0g8s1Z1rOH6l351VmVyLx1XHorfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwftwvGiU1xdAPUhiYDjQP1TjCVkKBas6iwOmy7aMrY=;
 b=AHv0dbDy4HYUYMvZjWFCJccGicO4P3t/t6XLSeWerPnN/9o/huyzc4GP2EigL0fVJuSRb6o3J8QKNVE1Luny+SqE42XR6+ks875pZF8jn6gvJR/ClhzvySzy4GSV9GVeGi3vpgjoT8qSjvXXMCsT6+0nxI5ZLKnQaBTbqnhW1uwdO2njOHx4z+3CGZkFfQtHDOMF99H3LMz6i+FRVgEnmiYhEG3sLu2SKq4Aku/7y3ZQ57162eH+q1xM6K9MA1Pc05TioZ+Wu1AAvIM2x+D8/4yBnoLq91Hc+hn0FzDH0gftcABumJge6tu4MnA1/dZ6Pyvd/bNH0O2yk/i3rGufHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwftwvGiU1xdAPUhiYDjQP1TjCVkKBas6iwOmy7aMrY=;
 b=sVsK0eQzx+oySAe6ci62f5znqlE5jg1bDP3X8mMEkd57Ype3pdjYN5EjOHQb2DHmdBPvAfupPveJ9C7MgTteCqdDFSVToV97YGkSxSjV9tSc+ipFb6PYiW/atk54GhUwC+f627MtmoIj01FPU7US9bpxHIczIoxd5YELEMxqUos=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enablement
 for all SMU11 ASICs
Date: Fri, 10 Jul 2020 12:47:43 +0800
Message-Id: <20200710044746.23538-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:30 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f9b51a9-a8c8-4347-d38c-08d8248c7ef1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360F3A1479D76076FABA550E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8e6z0hILEZ6y484RhrlFjRkpr47EtsSRL5JV0FyBQEi6LAkTOeNQKUOeWIYukiQLt1wX6ZsfmiEsgVb/kjFG3CelLv0tYko9fv3SFecE04KRWNfIW+m5phWnlsCM7zsEOR+PqciykoahNYOLNlGnXT7SiUU068euzojBYZa5orZsPzEqeA0Sn7Lg03qWIiTYOfzy0BffXVEjZkpaJNoHdl/haMmjjy3TTiloq22XKtIdwiMGRuAfODiA9pUTSwuuB8FXieW+Rx7Sbbt2Pbl/cNYoBHUoyNw042tl68N51ogsdCNl4hfx1hv5ZnUocMeXoIFvhIqH21TdJ/u2/DrRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 506ntEIQAXaJrqmKW6ITegVMayatKlXcq8+e+imhVi9sNI2UwltpD44HUk6mLOvLKuGj4TkEQMtNAexyZZVSVIu+NBC4zabe4oCvCRsN4Ww7ZEWNJdt/PMPeNBX7eG9cyH74FfdLisjBgA0864fYJiUF+tFHQlIWFQ2xyj4KKDcZffS9mtTPlcEbnb71IEoOQVSr74XJi5gW3S9P3JrCd5QuX07bf3VwxfX9EbNlrPc1NadM8ADdNxFnHd8xkWCxfFH+sHbBxAwJK5HF31dxkYiS7G9KHwiUmEp2U4buOPlr7YS5i6WDhmATj2B4U1pSmk7KDYAzmVRqbUKEd7HEequPri75fZe3VSn0/Gx0YlDMTmZQ+yiYWDU86kSC4s/5pLzfLAF2+vvq5WD/NW6uCqj4+ntiiH/c+PKH2cT6xZd4rNCX0nqvRi6L1Jz5yKnnoHiBJxC+s9eSVwcOBD90X4hqs1l8V6clfYKuXgv5tnYQP+0dN6zbxSZG4eWJnqz2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9b51a9-a8c8-4347-d38c-08d8248c7ef1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:32.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9SAbBdk8aVFHYPTtCqTB6+jdAX0jpkNYfA2TkOgm8JhOZ2F9uU6om9hn6P2kUd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before and after setting gfx clock soft max/min frequency.

Change-Id: I6f828da8de096ebc0ae27eaa89f988def2d547ec
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c2779d0b51f6..33e0718f2635 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1758,8 +1758,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK &&
-	    adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (clk_type == SMU_GFXCLK)
 		amdgpu_gfx_off_ctrl(adev, false);
 
 	if (max > 0) {
@@ -1779,8 +1778,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK &&
-	    adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (clk_type == SMU_GFXCLK)
 		amdgpu_gfx_off_ctrl(adev, true);
 
 	return ret;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
