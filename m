Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3269C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 20:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799E461153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 20:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799E461153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D796E0CC;
	Mon,  7 Jun 2021 20:29:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1336D6E0CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 20:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoPtifV8SYICLjHFcv0ZEdP667jL9bX452o3cRLjb014fNnYgdNbv5tQcrSSVIuJVTWGFePW5ClR+Gq4gK5tMe3UJjHBLmaMPDczBbv/UYD/CIwW59NdZS6RVuCG7qOThqjRDfaK7jByO746DBHnnJ99OiD5glibuz46kAGp2kFG3vZlPACw8P0U2TGzgNHYr4XRe4VyWk7NluMXOofhQemZDCmdjQEASAqvlfz4Dx1yGUc9JeuIv0XzItf6YLoCRgnjvKSUz7FSty2oW+bCR/xOgiANQ/LzR2vNRXDUNlqdOjtXoiOeJPFXqSv7Su1LG7cMCG5j1m4IFb4gKlJQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEJjVrc3ujQ8cTgxh6de3kg6trDS0JR/vjOZk8kHJUs=;
 b=cXxb5qBJAGJI3ZFxLYbCmWdWkCSZC/l4D7rfNFLDpYZ2IVb9lomSLtp3U3zCnf9o/8d1VD5Tzrd9OC5ZshdrrcsacixU6IX6rqBlFBirPwJv/zpZQXC1XYa0aTXYGR0yRA6+5qbrPQzeATYfBfYpINjvd7ziEfBpuDMo095PUXttkxB2fEQiAScDSC9hD7Hk7OjvkRPT6uoftri5jgbBVZe4ael4MIXue0BjxsYrHSwr8ICjg0O0gRErvmh/oknp7N7T2Ob3il3r/jQ3wTHZRnOJXcXU4qejB3zauUGfqYZHUDI8rmYWJ8kX5hOkfPCKeMFt12zeJR6sVkchnKnzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEJjVrc3ujQ8cTgxh6de3kg6trDS0JR/vjOZk8kHJUs=;
 b=uODeu7puxBwVVzLerrx5l8QQsb6Pha0BMwSF29y17vPkVQJbSTvzZhrNtIV74gvmqsCsfzjVgOSFasMyYark5NMnhtQOvavPAs3gr+s5gxhDUr2POrXP6M3z+jsQjaQRL4bPKKic/+YxOJ/E9stNx1V2fpe6OMMDuzBbxUOIFIg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 20:29:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 20:29:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
Date: Mon,  7 Jun 2021 16:28:41 -0400
Message-Id: <20210607202841.2120465-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: BLAPR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:208:329::16) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 20:29:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2dac7c5-de99-4be6-91e8-08d929f2e536
X-MS-TrafficTypeDiagnostic: MN2PR12MB3981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3981165B2D32938D24681E5EF7389@MN2PR12MB3981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LAbHDwdAgOgGrPNQuUqLQiLyr41HDTTk08Hs6ZddYzNondljB6YyHsVL/03gJWuw6/i12SnQo2U+8SJW+QnEFlzNhloJkP0josj+PU64c2u8eaynDoBCrHxnJMUsHzaALPR0FoYr69nqNSQ/z5AS77vh6OPqsl4Nz/gQ+ZWxV6PqZjv6DqBmL33K2UJwXYBfRY31SwbgIRLzIPE2OXL/l9i9WEPQ8deiD5z5NGvCB6nd6FLxq54V2ShAx5M2a+6doxTjxk7iOVVVVoudDfOfvtcva+R+A2BYJp2aS6Sef+NW9cuoSR756o7bG284X3bkmkoUwYALz3/PEOzxoxMskvMw7GOLFco1jvCGi/0sy4a5bZSGyDgB2pyh+vnEGWPdSlIB/9EjY2SZF6NcfF2e+6zsHQuVD5kwGYsKS/XEyK4sBxvm//zL7BifHkhB+/bkO3QR7b0CC8pyxaOOhXPBNaoOQlgCbgLRL7FKcHWT7UbdNjhq5RCssaTo1TZ8AbbsVy31SLvHo6qq509ms+MbvpwNN+pDGhaQDBKKySeC/EOKQqBhL8pnQYf219rrm25OMSxJZ2BYJzQADnrzP+Oh3PqAsPZBR+ZQ5ZVXNHbXLEXCFfOZWF+tNFcWKBKKpTES4RtRt67ZUP0BHzmL6Etk5+dkLianlJJ6zDZ1RAHQAcNcsBwa40TPyHv+8E14UA+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(2616005)(52116002)(956004)(86362001)(38350700002)(186003)(16526019)(38100700002)(4326008)(6666004)(316002)(6512007)(8936002)(8676002)(6916009)(6486002)(478600001)(1076003)(5660300002)(2906002)(36756003)(83380400001)(6506007)(66556008)(66476007)(26005)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PmSscmwAI5gJEfrWWgQuUwsRZjHcaXGmiiAzaFqESF3fFERhBJucbS4Ydj4Q?=
 =?us-ascii?Q?Ki0p3nva8oC0f4ZnT56gnbuhm2zeFkUwc3CXplf/FhU/jpMch4Im6w+5r6VL?=
 =?us-ascii?Q?pbe+TSgy03/Mmi9ec1lXuxFentLMr/BQ9B6n9PUTvs9RF2tCyYmPQZ9N8XWG?=
 =?us-ascii?Q?8E5d+hx+nYNwsWmDIb3mURJ7BfjzcawRdX+Zwy4HbKrv9+SaVPZyVEuS6ASd?=
 =?us-ascii?Q?KV4vsUFRCFAIy0djwgHONjNLAuYnZ92c9ef164Z7QWXH9vu2hvneDNas7yqF?=
 =?us-ascii?Q?ZT10qUIsbJSsrduSuZ+ZjhBa/imNUifDCSTKXQRo7JbLrxSZhx5iUE9IBVWc?=
 =?us-ascii?Q?/fXdCayE7pzb1UmNYJdnNEJCyEqAjcWbrJcFKhdV6Kom917CGbj8kC7UbzoA?=
 =?us-ascii?Q?qrQCJZpJ93WgPzsmq1o9rjowpl2XUq5A/wSVA68wsUqftG2dsu2SpwlVVXaD?=
 =?us-ascii?Q?jXXfqlzOwkIr+pkxPSp0/qEU5KCtW+Gce0ndk6doL1+Zpr3a7LOqdoazI4Hg?=
 =?us-ascii?Q?S5dByEfM4yoDvPSYBviyq8IJfB6G++yaa36Iht4qAioyi70WC6Sk0LqHcUji?=
 =?us-ascii?Q?Hdf+Nunm95fIsua+f5isK/gjAYLMKfZmXJ3dCA3QhN0Fqn6ez1WmmcXLmVIg?=
 =?us-ascii?Q?FBPEwi8DlZF65aRWSVVBNPdbS6/5gNUl3s9bL81FehZTdqs+wiMuZgNxuD2k?=
 =?us-ascii?Q?B0B7+wil7pRG4Azb9SA8sSRc+JvV3cWny9Z2GRNsy7ACzvRVb+keSfgiNu+F?=
 =?us-ascii?Q?c0tg4craI1L4CpSatjr69teAjGvDxOqoTUjpaenNRL7Y1qWIEwDr8+MswOk3?=
 =?us-ascii?Q?7tC5AmToKu8YyczBPPHHerZ4Or/Vq7q2MNj2RdbmRDbceeFPDvwasH6+zu3o?=
 =?us-ascii?Q?dBEOaNgfHBGf6811QnqhkrE6RQidc7VtEnx1EhwH4Smo0tNQFbA3DuiAg9/l?=
 =?us-ascii?Q?lroXg4S1EtI1oZJpzXK+F0Vm1azey0nJeoFHLpMxd1RWQwe8K1wb2pRPjID1?=
 =?us-ascii?Q?eaZBLwOD9DiZ1AO74Qx/6Vr3bgW98HWjtUMs3DPCPkPzwZt08WRiG3VQhq3m?=
 =?us-ascii?Q?oEUnFpFKXcVrES23oukaZIq77IJLuDHfHeNtzHSdvDfRRbrgorTvGCjRVxAn?=
 =?us-ascii?Q?p450o0R2bpkd92VP9WdvU5tOveOS78fBuk3biT88aiar7ndSPOVv0DTfQQ/6?=
 =?us-ascii?Q?n9C6H09EORJj6SxvvCib0JFuCbdhpt2EcA7ibdTwC0epJ2EAvbj3Yfqb28b7?=
 =?us-ascii?Q?gnFuQvj8680so5AQKBEu9ohB50pCvVZUqMsIxBPNLWJgrtVxslyQ4lbJ2WV+?=
 =?us-ascii?Q?YBj2jIsmBZ6R+riAnyWwjaUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dac7c5-de99-4be6-91e8-08d929f2e536
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 20:29:05.5522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QqMnz8TM2/IneOJAwLz+r2Da1FisIq5UzjiHDvMFcykNMyKEXC46+AwVe2euxRxS4Hx94rac9iyOrlfGitKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop disabling of gfxoff during VCN use.  This allows gfxoff
to kick in and potentially save power if the user is not using
gfx for color space conversion or scaling.

VCN1.0 had a bug which prevented it from working properly with
gfxoff, so we disabled it while using VCN.  That said, most apps
today use gfx for scaling and color space conversion rather than
overlay planes so it was generally in use anyway. This was fixed
on VCN2+, but since we mostly use gfx for color space conversion
and scaling and rapidly powering up/down gfx can negate the
advantages of gfxoff, we left gfxoff disabled. As more
applications use overlay planes for color space conversion
and scaling, this starts to be a win, so go ahead and leave
gfxoff enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 1dc11dbd62b7..647d2c31e8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -393,7 +393,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
@@ -413,7 +412,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	atomic_inc(&adev->vcn.total_submission_cnt);
 
 	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
-		amdgpu_gfx_off_ctrl(adev, false);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
