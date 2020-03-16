Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD4CC2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04B22051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1J+B311E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04B22051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C81E6E462;
	Mon, 16 Mar 2020 13:50:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D74B6E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHjCcdnd8xt718odFiafwDFxL4+ulSM6M0VQcZprEmQm/26RQKoMKENiy7sjS1HHyKK99WbWKYiJK+v1rWRSHXPboSWpkDxg5GkNSCmu7tw4t8KZXxchYnVdPVjQbj3FUgYmk5Bug66FaFFH9gscNuP6SF4irA0YjxLrrT5Pxi8o6Ijt3We21ad+A4YngyFHP5mktDcATOa9BtuBtvpqBzPYKeIslsuRQII20oBjYdSVHsD0nvTy5DQ4cJlwAW0+3YUGsL6EdS1IlH7dFvS9ihTE9kab8qJQQZtt7/7a5hE4a/lb3Ldf9lzKzxaWO87vtatRD+kqdPkSfJvxk6fLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJZ3xW86FDL9+UE3imXkh+FOw07vMndXV+lLsxNzxc0=;
 b=KWJmBqJErhCrafw7Ku9qu+fH7INuEYHlCd/CnPRzO1laySxchnXIi18ewz+UsW3bj41iDhAphqs7zuyEfuY+c5BBNJpMfTvHmQY2IXhs3fdQ7OxumMEvIVxHFNTkBmwkLRQXiVkPaChwDD3cr472yVeCR2GNX2tjM74WkiYdSHTQXVWW/nRDUTjlnmLiAWBod7cvgL8IacVz3r2cRQQJF5CZPa/zQadGP4DKwhLnOIN+RdXOQMHR4+epuPycC/nmMKSVfUMhVvU0Bo2QrwdGvX3ZJKlsSJGRbwAnsFzuVsZ1pnjPAHCqfk1Yrg4obUE2gBdqDlplfnQ/GBVaUh711g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJZ3xW86FDL9+UE3imXkh+FOw07vMndXV+lLsxNzxc0=;
 b=1J+B311EQLpCA6InDKGhZonzr5Dtv2V6yHgjFtUBZZaonDGQ/VI24YrVm9P33RJ0XDf/bg4wVLqsUmxdMnpT0FBZs28eLxfRGryl/01pyXaDKQUS/KQHLWpKvLGEoHhZaO4mz/Pcfr5/yJGt/eINqwCa8a2ELLy0nLnAccfrMc8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:00 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/19] drm/amd/display: Remove PSR dependency on swizzle mode
Date: Mon, 16 Mar 2020 09:49:09 -0400
Message-Id: <20200316134920.2526155-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 953af3f6-c1cd-44ea-6a61-08d7c9b0eba6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396D02D70116701450177DB98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:274;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WUV0sJJCMvaoxJaCT5r+ETiMoZZBoDJxyIhaWAvEmIql8Gvi0QHdYNLEHfKWvykpbnJu0hlIz/pXBWUB4yWUIxhCOmT0fZTKpALLXXZhWAMA0H5DwDxYCAh5K2tlx7bSEjDvqSMQoXgynPBky7cnAwNP77ygSHp4ctFyouTsxgJxFuY6kU8KWRX9D+TMqGioNnT8gG7gSu0dd1dMLxZtlpC4vs5tsQXj70lLP1ck8NMv9EbVoVHWZF1348gH0Vdbx+l8+qi1xas+Y0XSyyyvA0Qv51XKHlbh2TK2QkgaLkZnSkdOjCzCrGEv0QhCzJo4OUmX2S1Nd6HY9zYEO7NUrrsuarUM/IsFsn8xUcY93LLLCpGqnrWGFrc5ApdVkV4uSyZxsWx+H0uCWNdUlvLfjXwXTPhB49zhIUEFH5sa2yV/fFayaHWfEbtx1jTMEYf
X-MS-Exchange-AntiSpam-MessageData: cnZCZQEY7XVHpCZDoMs9t38FUulPswrdb0xVmK2uRKi8HLi91k/MmVGlELUOLNfROIA2bQ0UMiXKdPH2i9UtPNE5M3vtivrdhMTxE3KQh/S0c5wVbVfL3tt6elUzsOnM6OUw3F1BRQFuV1vNQ8yyAA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953af3f6-c1cd-44ea-6a61-08d7c9b0eba6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:00.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsqJOxiSVcLNGCCloPAUcxA0p+QnH9SxRQwMvRCmgwweWqk8LNEJmH3V+PK3VyVG9qMQR2CILxUlMcFOloM0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <roman.li@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
The PSR enablement was dependent on swizzle as a workaround for
non-pageflipping fb console. It's no longer required.

[How]
Remove PSR-enable dependency on swizzle mode.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index db578d8092d9..676ec4d797e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6639,7 +6639,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	uint32_t target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool pflip_present = false;
-	bool swizzle = true;
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
 		struct dc_plane_info plane_infos[MAX_SURFACES];
@@ -6685,9 +6684,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		dc_plane = dm_new_plane_state->dc_state;
 
-		if (dc_plane && !dc_plane->tiling_info.gfx9.swizzle)
-			swizzle = false;
-
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
 			bundle->surface_updates[planes_count].gamma = dc_plane->gamma_correction;
@@ -6898,8 +6894,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			amdgpu_dm_link_setup_psr(acrtc_state->stream);
 		else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
 						acrtc_state->stream->link->psr_feature_enabled &&
-						!acrtc_state->stream->link->psr_allow_active &&
-						swizzle) {
+						!acrtc_state->stream->link->psr_allow_active) {
 			amdgpu_dm_psr_enable(acrtc_state->stream);
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
