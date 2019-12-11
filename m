Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9512C2D0C9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F57D2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kVTaOg+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B776EB87;
	Wed, 11 Dec 2019 15:33:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391976EB86
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kURJk8Ua6EnUELfORhPFh32Yy4Z7/vip/2B4o+lWiCmjIPe9CLbHA0M22NpTYWG8rT8VZhwplM101gE6FgBuvsPP4ZXBNkm5n5GJNjwXH35OJHkl5ZgeKp3C8V7RKIMaHNnmrTC46fqB92lEWrHvBQ0nbf/uK0s2LakA5y1dO4cvZoeSXU9xs8ryDywyW4gJonRbiymxY4X3Z2VllJOz9t7iN7OwmuPdc70a5uJmX7LwBMBRIP8tMcl8zJfkvQRPM3cRvNnkXEDqAi8XURmaJNiTTHE0qo6wL0ENmSd2XAek19xnwHu01gMQ61NhMk7J/fGR35AfQcDE7DQVYZFTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uuz/L5UHujiJ1GC+Zh8XbNNzYpAvCrTELcQQqUqHWps=;
 b=G/3sFL/K/b3m2AwAhuEFL0Xj4iV64Uri1pI1c0DTyJehK1eNgP+ll5uV9cXt/85agYWOdEzUkWi03Ox+5D9tgXd+8x3rD6zMn7q0EaHmHgX50ACnnzdwP3QJv+euBaSur0CGrJ9HGLnAwV077ooEi6VJMfignhzSOwYkhHpLYddbNENPkZsdOvQI/sAu5Q1rzUUcQKiLpN87rujvx9KIS8szHLMpYz9XXG2zKjbQjbUjIhbk8mpubSn7CEf8xlwYOvLJKp5a3sEfMDPtgfMrutLddXbv8rEdz+xI8Jedqy1V8U//+VHXUzH0pmDWJCHT0XCsnjkq/JlUZ8fm6+X/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uuz/L5UHujiJ1GC+Zh8XbNNzYpAvCrTELcQQqUqHWps=;
 b=kVTaOg+62+Caiarf0z69TaryhT+gSd4kDEyfahLxZgRy2/eUivPLUl9tpd9LsxNi7v4YGUC0V2w3BlKKNt9ggR4HY2PQIfGwF4CrIID3i5+nYk8Nb31K2zBzU+EQj/fZXDJtiRKkv0apYXc0Qt44Scnji3/QKrZxABrrIqC/5vs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2570.namprd12.prod.outlook.com (52.132.181.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:29 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/39] drm/amd/display: Default max bpc to 16 for eDP
Date: Wed, 11 Dec 2019 10:32:28 -0500
Message-Id: <20191211153253.2291112-15-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e33bfc51-895f-4f74-a085-08d77e4f78bb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:|MW2PR12MB2570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257076E060CB7DB1388EE497985A0@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(54906003)(81156014)(81166006)(36756003)(66946007)(4326008)(478600001)(316002)(66476007)(8676002)(186003)(66556008)(6506007)(26005)(1076003)(52116002)(86362001)(8936002)(2616005)(5660300002)(2906002)(6916009)(6486002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2570;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfQ55aqmYtetXHEweVNk2ELyWbqFWo/zpOGbsvDIEm/CU2dO16a5lBtI/lng2h/iC0OpfnVPkjDfkSfLc8l+Q2pm0LTDx40B2Fhaxc9z1b0IyKCYdO0oaj3Fge3ckNwP26YKnmbw76MeBvxFfeK3a4Q/R+r4Q+Ts+FmT+Jj3NpSQxlKSyOp6ZuYNk6/fUo9kphPl7Cl2cKUhKD8utUHDx8OQiWUVfQjVN/s9KKR9uVdl8edTIJ2bZLOou4q3J+cNp2tQEsfP+LQeoqVS0PJ807S5hHM37IEpGFGptbVMJC8fgtVSusBFz7JR8gTIP+6kE2pbqqkhQMRzRzT7Uw8E6A3rhlNYX42evaWh+O1yEPQ9WVLYGGlxi4UgBCm2URZ1CwfAoucdSVAjKiaS8kqlsR4pmKvIUXC1vtOzDx0cusuXIzkdZX+LtEWi5A958yCV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33bfc51-895f-4f74-a085-08d77e4f78bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:29.1021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y82zQsI2s/5r0cdysX51OzOqHEJVU1OjJaSZEmziYMCBOd0u7DogLxsxNjU2Yy+qURu6aHUf0uNgq/S0fwAWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Roman Li <roman.li@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Some 10bit eDP panels don't lightup after we cap bpc to 8.

[How]
Set default max_bpc to 16 for edp connector type.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 455c51c38720..7972286bac23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5647,9 +5647,9 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 
 	drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
 
-	/* This defaults to the max in the range, but we want 8bpc. */
-	aconnector->base.state->max_bpc = 8;
-	aconnector->base.state->max_requested_bpc = 8;
+	/* This defaults to the max in the range, but we want 8bpc for non-edp. */
+	aconnector->base.state->max_bpc = (connector_type == DRM_MODE_CONNECTOR_eDP) ? 16 : 8;
+	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
 
 	if (connector_type == DRM_MODE_CONNECTOR_eDP &&
 	    dc_is_dmcu_initialized(adev->dm.dc)) {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
