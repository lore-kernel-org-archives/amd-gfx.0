Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE48C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 03:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4592081A
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 03:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zbJUviws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4592081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DC96E067;
	Wed, 20 May 2020 03:51:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAF76E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 03:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQWUZguIEBbnW1T+utVFyNrEITdoJiooKk5WpxzasAnvFWelGptSDah32hvEBl+yveDALLGvX40d4RbWZz8HULuWsQ64DmgVNVaVW8IILoK5a2+BJ3ZPSyp6TcATqejAr9FAj20ejsDR4TmfkW0KBq+3gSddDZr0XDsJKo0E1sk81p4aGXO/Y2xfJ8qKYeYunkQ+BfKDpG9Jrwh2NuqMT0n6xXvNLkGBuLHLoXlSGKLVyOED68Q1YxynDuZQUSxRsnPVapj0LTul3XFUaEIoUzU+GUAMShiD7ufQ0K656YnXXYh5MnavbFtFfnXG05Du2E+QPENbafO/G7q0JUHyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFJ6TFKtvGeYKnnAoec5IhcCnNdBJupZ8fOHIlk4HiI=;
 b=dLM5TlADYgiQfJ/7pKnFwvRrspGHwp9PT3NZPAOYmQ04mG9vgyBntKknhbUSSsmotpcyldetHdtZTb54rSctrHUItxRPyDHoRQyw5PSrBhSnx9fciOXF4zEwMuUuyaXPAqmmeTm3BfQ3O6G98CCAeUsDMiTkt3MfAHL1FMIk0cFELiC9BoOdKBur8vkn1bu1nFOFB6hdoMuHPSjkLEyc+rRqONPrFG3jgfNcR5C0KUEFy7seMhr5+FlK7YyxUdGpXEYV8N4fUdGkDepRhq/BMOXBkKrA5FLm5mD2kU2m/U65hiGmJTYptB0RNEAGFWyqx+fv10eUWgsejTa6KchZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFJ6TFKtvGeYKnnAoec5IhcCnNdBJupZ8fOHIlk4HiI=;
 b=zbJUviwseEE6oHLsR7PMqZX5s+BZB0Vlx8TDJoTHHt1CDPNYYjIAAuHnk9sAXlnqTbF0rcr1ekjse6BTA1aEZ+VI3ng/Rt/wCVsEA5UlBf/B0HpsiKEbs2c1BdD9nMj2NGU3J+hpNj2vms0yucxcBr2nh93fItuNYxcA9xqdqao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 03:51:08 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 03:51:08 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: remove the support of xgmi pstate on
 vega20 from swsmu
Date: Wed, 20 May 2020 11:50:47 +0800
Message-Id: <20200520035048.29899-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 03:51:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca83b990-ce9b-431b-28b8-08d7fc710769
X-MS-TrafficTypeDiagnostic: BY5PR12MB4098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40989214C65F44D17989C8F1A2B60@BY5PR12MB4098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiM+b6XbyPqFUfyar6Ad/3gEGjm/LkMDyq6xjn8htrQY4mvmkDF/+nZyLawS7XRHuqbkb+Fh1gPO5qRLMHorsolHJWLiOMAkqtiyaM7JCCdxw9M49eJMiCkVYQ/XJI04fcG/aYLzqTZbu+4Z4iPgcuF9a1GkVGNE0XLBh/6jeDib/k6/bmQSmW7V9NWM2E/Jw7i1KBQp9b5rOFT5GxpXpdkVj0ghbgmnQiM+TEvZCrh2x5SaI0qlseE3gsutrWhwGS5rhbBA1bFuqh+Q5dKBZXr4s435RRFZYF9tDVprnKh/QvDYvvP48cTUIrWYvzdeU2M9p8tsdh/WGP4oXzuTQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(8936002)(6916009)(6666004)(1076003)(6486002)(8676002)(36756003)(478600001)(66476007)(66946007)(66556008)(2616005)(956004)(4326008)(7696005)(86362001)(2906002)(316002)(16526019)(186003)(26005)(52116002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vYKS48Mg9XJ1Mzt9m1Ix32B8GdDPKMomMDI5nbHHxmqTqZ0tfOQBTb5uwkarAZT/cXClAYriTZmPbFFe2TdNtL3+P1wl1sRkT0pBnGdreHBVbQfISHjJbvY/Q4Fhf1fmy1rc9mYRAvpWZftdsP7iacsssiXuCHjHm0/pTDUOYiFmAMBfOmDTnDR8Br8TfhVa+UX0wXERDwoNcZbVDBGsOVzOHvpym1EpJc5KF+e4su3xbLwm3/1NbIDvCYQfGpQsQaIvOV0Y6lWY77ukSx5rxLW6MyB5uNap+PZrjiI5uEncEEfCUAHf/PNNf7cW2sA+d8HmkHx/yLV/hTddcMJiGcr0Fzaxx/F+jQu+vZvO/C+OUmU+wXr/sXo6L1QzMLI5oiO8aN8ZTm8LrEWuFm5w8bZrncpgedag9LQJPOhzL/jVibO31WSJnOx2B91crheMqampmzmqDwGsM8I4LRI7lNlVRvmbjrcy0dcbUyz2Y/Fo/ZV2hugyjhlqMQCgSNqq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca83b990-ce9b-431b-28b8-08d7fc710769
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 03:51:08.4241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tX6ZTdxelxhDFZq9sakWbCb7bebo1Cgl+Ow2PTekH0lmehE1Z56vt7V8ked70rfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the vega20 asic uses legacy powerplay driver by default.

1. cleanup is_support_sw_smu_xgmi() function.
(ony use for vega20 xgmi pstate check)
2. by default, the vega20 set xgmi pstate by legacy powerplay routine.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c        |  4 ++--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 11 -----------
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  1 -
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index f36b58a7f485..65472b3dd815 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1162,7 +1162,7 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 {
 	int ret = 0;
 
-	if (is_support_sw_smu_xgmi(adev))
+	if (is_support_sw_smu(adev))
 		ret = smu_set_xgmi_pstate(&adev->smu, pstate);
 	else if (adev->powerplay.pp_funcs &&
 		 adev->powerplay.pp_funcs->set_xgmi_pstate)
@@ -1197,4 +1197,4 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en)
 		return smu_allow_xgmi_power_down(smu, en);
 
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 1abc4be6b72e..9ad6f0f3aada 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -575,17 +575,6 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	return false;
 }
 
-bool is_support_sw_smu_xgmi(struct amdgpu_device *adev)
-{
-	if (!is_support_sw_smu(adev))
-		return false;
-
-	if (adev->asic_type == CHIP_VEGA20)
-		return true;
-
-	return false;
-}
-
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 4d1c2a44a8b6..bac7e13dc801 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -675,7 +675,6 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 		     void *table_data, bool drv2smu);
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
-bool is_support_sw_smu_xgmi(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
