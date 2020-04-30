Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D5C83006
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D959F2173E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y7e6s7Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D959F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750AE6EB46;
	Thu, 30 Apr 2020 06:44:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A406EB46
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 06:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge0kEsH3zZu+JyFUydsmaLXQKgm0XXUu/kxGRZhlsBM8gcaFnCDeibzStVqA4/QHLqyXT/4yGzOMwSNSoh2xIa6xx3b9SKWYBxQ7CPEPeqIkKUGX80/IJpO0/h1pHivxdgYvqDBJj898HiNNKMtkHyWfVtPf2qw3FcaDP0tDwh4LQI3vViVaUUQSLKLSOr7FYY5yrHfEWpZWb589LHm1qMX4OzBRM361VdfZyZieg85f19F6Qualdf2NGqAnAUIgH4ZBCTzIgs37echQONjLN7B9PuMtJJM6Fiht+E8fhfOLranruGRC++naEwaKNYGT00BMxUllD/O5ulQC/bdGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg9regYj4VyqEGinRA6Jzdamn2SgxAyXhUmjIsnIBug=;
 b=cXgvkb1W9trCdQ9ZH2K8AbcVxuc3DL1/ahOJuMMDMC7B39Acy2mBlycmFL7AMqVsw2z3BBHmuEaX1LaPHeIMsAsgf504wiDhqa4ChW2Hnf8DeKh3t6OeoU6xRWxz//X/DnyiERm3nY7UpFZAMUnOyCioeLFpgH/WsKdryjI6wABSrZVUN6U9gJiB8KyOMPdRd78Rn8Yg47Set/tWw0xsfThpbO2ccV4YQS9pi7974du+FTaJjjE7sqP/YpmT3aIRgmkpBQOdkXY5mPRtNB3VLqfmXNL4Tavsbk17gKIzbD5AfZpajwYbpC0DzWVsPATvQkfCFl80xufY/5UieU77AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg9regYj4VyqEGinRA6Jzdamn2SgxAyXhUmjIsnIBug=;
 b=y7e6s7HzE79cBopyS3327UEIW6haTB2YsTDU5UhuxuXDzMnjRkXpmEHRLnotcBl4kSRnfl8hdIc+ij+Kb+q4aFD95EqnTdGMEEyfEWqM2qxUsERPGWjkJ3clTkW12sXqkl7D0R/NbEXCgM5ctxWpmfSpWN/puagIz3z0M4k2abg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Thu, 30 Apr 2020 06:44:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 06:44:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/powerplay: perform PG ungate prior to CG ungate
Date: Thu, 30 Apr 2020 14:43:31 +0800
Message-Id: <20200430064331.23502-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064331.23502-1-evan.quan@amd.com>
References: <20200430064331.23502-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 06:44:00 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d3a3ba3-68c8-46f0-53f6-08d7ecd1de0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:|DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114F141AB5716214E9B887EE4AA0@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpJXKRpo+05yuIEFIE+ox+hWOaG+5FuNejAK71YXKnKBF2nwCD6ohQdqle1I187nNLlQCx3Hg0oSiorouxid3WyXlgphCVQ8Y5V1zAYBITvt2wObmmnZwlj6UcO6JTMtCGB0NL8QlD680pUPH9k4Dk96zwPxQDe6P6Q5yygbVfl+NrlFYKTD1nY1lKIMokrxml7WAJluDzbddb/TaSJX8tERXgssfkiqWgfj2h804clhUACHFlZ6/PJPI85WFEpidr1NYyol8GbEVruYVhyMKWsxMqx0YUv92029MtYOYPs/c26Y5u3dLztgZXvYaoKVYKk7ndKtwwvJyiqKw53uHkdI+RhiKFe/eGZ1ZhMEwpaoGt34DpgdgHz4KTXsUianFnrdbwSBSpUiGVBZbdRKUaIdj4tKnHDTIskPCdkiYTqwSf0B5Kw+OyyBMuuTLeS8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(16526019)(6486002)(186003)(8676002)(8936002)(5660300002)(7696005)(52116002)(26005)(6666004)(316002)(86362001)(36756003)(1076003)(2906002)(2616005)(956004)(4326008)(44832011)(6916009)(478600001)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: l3GelcLFzte7woC/nioQnqFAe/31EFIgw3Ww5xhEtHPkNU5Na/kE8FoFVqfJFh68Ksb+gsr+WsowqhWMkrUGLnvKDaEn0DUnLkOXggCQ68gug553zS3JOUgzgyYiVScTPsTYoGwKXuGbH9kj2eKz42bf/iPsLrRBir+yN4iWJcP1nGHYoQn1oNYxLANfQ+euK1ipKONusvAfU7Y/+dhdgoFzuuCQsm4qb6oOVWE/9JOwLADma5job7cZaGCsSTGh+F6/jfY9O9wiiPu+XODVdrdIIQHkEnifvp7p+26YKBb0QWJWgHcNaxh6bLSiRc7qYnYyf6H01/mt98qsKIuq+7ZjNJMSbsImpqFthBe2qIGqRJEVKdvbCTm3XQboARc9svBU2fP3YoBBWpKdJw0vtN+BagA8SmzFi+0MF3BJkiJrGOtxOnNVRmSono6Z5lKc9BaB5Gc4IYGg/sQZRGOHl8tYZ1jqiQzhgp1N4Jba40GVlmpIv7i1fjYVrYA8o6udo/RnIo2sswnDo2+zE2l17Qgcgn9Z4ZHqkPyVB1vVgmues5KbOePSdwweNd/8LdDH/XI7MU7rbVcv0hvWKlgOgLgIoZrbGagSKnGGy69SEU8KGm1OsipWCAftjWytFy5GGRRQ4KHOkuqwmg7UvGB/qekd18e9rDKEc0DolnycI5XFL/eUdDCp1oaOkVPXSfu9k1WlKvVCTcEgzu2dQdICzOce/WtA6pw1IrZIOeoBbwyemjCqHIahRG4oYK44vGL9zFya+zF8uVWJjwC8oJbV0Z/IV2JB7UDwU88OcVnxUkw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3a3ba3-68c8-46f0-53f6-08d7ecd1de0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 06:44:01.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDjLkLojVDxvCxK+774mkY6YY2Jeo5S5hNncFOYv4UbevLaKec3GP4GumSKQMLSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since gfxoff should be disabled first before trying to access those
GC registers.

Change-Id: I5bf0fbe01fa05c89bbb392ef40e11c07edfee039
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 6 +++---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index fdff3e1c5e95..96c91bb70df5 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -322,12 +322,12 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 		if (*level & profile_mode_mask) {
 			hwmgr->saved_dpm_level = hwmgr->dpm_level;
 			hwmgr->en_umd_pstate = true;
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_GFX,
-						AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_GFX,
 					AMD_PG_STATE_UNGATE);
+			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
+						AMD_IP_BLOCK_TYPE_GFX,
+						AMD_CG_STATE_UNGATE);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 12810fd81d5d..e6252bcaa641 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1780,12 +1780,12 @@ static int smu_enable_umd_pstate(void *handle,
 		if (*level & profile_mode_mask) {
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = true;
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_PG_STATE_UNGATE);
+			amdgpu_device_ip_set_clockgating_state(smu->adev,
+							       AMD_IP_BLOCK_TYPE_GFX,
+							       AMD_CG_STATE_UNGATE);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
