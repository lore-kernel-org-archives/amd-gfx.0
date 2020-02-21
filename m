Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA2C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D9D2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1+U5Y9xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D9D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495E36F4BF;
	Fri, 21 Feb 2020 16:04:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3966F4BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFR9gk7nkeLZNobeuFBXRpWHpWKIzhKQ0LRcb8fV/UBziOGpgBacX/Z3UvEMqzJNnwWRx4c5VmDftkdA3eNNm2Xe4eV6p2w0sEAk6KgKjCaP9ENWUawT/ZZLMVJCoHnT9F4D/7qqIpb4SxAic9HHSJauHpCrGHD02B1o/+1EB9olRd3DGaN3+koRRIW+ffVrLfXnFsT1lNOWVJVGvSEwlO2xwfUSKMqbfuMx/6hFTpFJhbBGbfBmq7zz91+zDq32Nn8Mf20dy/0H91FJNTn2ToOhoKGUQrYm7t4DkaVQMqwE5RUDigaE4IR+HssJYQ84Co1lKCDAONgvwXOseXJzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scB0EJwbwy4z7wO6oA2AMzeRGn/9UAbS15dDAX0o41E=;
 b=bOM9l8oShNH1Z5KejLIa6vH2wuJgcK/CO/M0q/9/Z5tc2XbmYzNLgS0/Gj8aD+OKdgwsDTU6tG+WB6P02n3yKdzKNWt4WKq7g1WIH+TLYd2hWE7nJ3o9u9r8377K5ZpholZVE36R+7SXqAL43jdCP+uEHnIjV0CW2dWYrvr4k9vLNTqTqZ2wQVVOgP1+l0eb7cK0XV5GoaDI52yL2p2N0xHR+S0u0fhntCeu+nR5CthsdFh3eNKBggYsawAepK7r6gE4I/+/C1b3I9qO+fn6nyHR37LH3kD73N/F2Oxw3KAzKS7XveXuXJgD6CC0p1rZMfxA1mTH5Gd8vgFe/9Kqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scB0EJwbwy4z7wO6oA2AMzeRGn/9UAbS15dDAX0o41E=;
 b=1+U5Y9xit/WulakfE8BmEbDM1Q8niFoNEtC6GicCzy1svUbFs/6CD6bd/oB1wwneMTg7xUSGMVSNls8LrG4HWHFe35Eeu30s/FHzwMKADhRmG+1bIeMUcEjRrddu2jlu2bEwyqTgAaYQQwfbGx3M3LaaKMyBJv/jR2SCARqg8sk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:46 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/35] drm/amd/display: correct dml surface size assignment
Date: Fri, 21 Feb 2020 11:03:19 -0500
Message-Id: <20200221160324.2969975-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:12 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfef39c1-df42-4fa6-e034-08d7b6e7b17a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572598AE77803CAC07952F698120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUK/MC8Q/8yQv8RHXgmmSPxwkDkMEAs1fv8xIAwhR7YOZL3L/nyFYb+CXg++qX3FSoFmwHPOn8ugelR19oLohqrTv9xOEtfWWd2n8VI6TXXeUOusHr0/gd4PAIFdxC+y+gzt5z1JHJZ1sRdRRv62Jj5yiSU4l66r7tup+UmRD3OPEtGilIbhJRiawbnzLoZJ8QH2FYODLCZyBSYBEZQ45Vcl9bjMD91zdB8EbX/daLt2A8mXiuYO5gZ0EElmLekFbvQgZr1yA1FrwFPACqW3lEgByCJN2u75+ZKQHbbiNYc1pfZCyBzWqPE2KxgQrWWb9Rlk7bcnlS2l7nSTPxti7/Pw5aAbVc2muhftMapmiNhnFsrWVtTHHXg9kXm2Qb7XCk5XUZzssvgk3zcCI0Qg6VnvSYbACQdkBZd5pGL7aPW4yDAOdFK9QMspX1oksSjN
X-MS-Exchange-AntiSpam-MessageData: tU6Lu+R6oVkHRLeLNECvmliAPmDz038MQ0IEQSOYbgHW3jNg8Fb8l3ZdMUJYYD1NW9FlDlVgqcmdkuxQORb/+7Ayl+eR4uhsVFFNMKcfuB9KKTtiNfpCiX+DWzyWbfXfWFPkX58y7dTHhk7q2tZ1pA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfef39c1-df42-4fa6-e034-08d7b6e7b17a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:13.0083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEmeadAhaencqWZmNzqk3rHJN2zsM3is7ZnjjGx2/vc8gE8m8zTsf9MVH9Z+RstNr2X4L7xnewVNXoYct+Sj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Need to assign surface size rather than viewport size for surface size
dml variable.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 193cc9c6b180..6b525c52124c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -393,11 +393,11 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.ViewportYStartC[mode_lib->vba.NumberOfActivePlanes] =
 				src->viewport_y_c;
 		mode_lib->vba.PitchY[mode_lib->vba.NumberOfActivePlanes] = src->data_pitch;
-		mode_lib->vba.SurfaceHeightY[mode_lib->vba.NumberOfActivePlanes] = src->viewport_height;
-		mode_lib->vba.SurfaceWidthY[mode_lib->vba.NumberOfActivePlanes] = src->viewport_width;
+		mode_lib->vba.SurfaceWidthY[mode_lib->vba.NumberOfActivePlanes] = src->surface_width_y;
+		mode_lib->vba.SurfaceHeightY[mode_lib->vba.NumberOfActivePlanes] = src->surface_height_y;
 		mode_lib->vba.PitchC[mode_lib->vba.NumberOfActivePlanes] = src->data_pitch_c;
-		mode_lib->vba.SurfaceHeightC[mode_lib->vba.NumberOfActivePlanes] = src->viewport_height_c;
-		mode_lib->vba.SurfaceWidthC[mode_lib->vba.NumberOfActivePlanes] = src->viewport_width_c;
+		mode_lib->vba.SurfaceHeightC[mode_lib->vba.NumberOfActivePlanes] = src->surface_height_c;
+		mode_lib->vba.SurfaceWidthC[mode_lib->vba.NumberOfActivePlanes] = src->surface_width_c;
 		mode_lib->vba.DCCMetaPitchY[mode_lib->vba.NumberOfActivePlanes] = src->meta_pitch;
 		mode_lib->vba.DCCMetaPitchC[mode_lib->vba.NumberOfActivePlanes] = src->meta_pitch_c;
 		mode_lib->vba.HRatio[mode_lib->vba.NumberOfActivePlanes] = scl->hscl_ratio;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
