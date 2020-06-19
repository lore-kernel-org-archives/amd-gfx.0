Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE69C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B30208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LxSlmjWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B30208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805B56EA72;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B93B6EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+ew53LrnAdqrtAB06Dh1JYu+n2AqzY2iR5Vi8OQXsd/FPLxCX4xJCMQLQ5msqzIzd5qKLcRkAHU7oAmND/emkKvf987+PBOjUVaa4LOgE33nNOrrPKbiNrKMq/u1BHIqPWD1FtnHPIOld0BlPwia2jFDjDnzen2fwNtVRIHdORcNVNB5slSUjULG1fLBgfIL4US3Jy4ISmJCr6of5EMIypDCf4UIxLEBW/3vUECRWBlDoIT6lxAZRIk5CmQdDTHIbNsLaCzlPfWixa4jhubO+IWR1C1svl7eoAGwhUfGU50Ka/Q7hIAIGfJhhy5IxaGT8QF7MeM2fw7XwfnCYUlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd1qucrW5zyi9BBoWo1tQitelGnCB7S7ekUR1yq4zoU=;
 b=eUSuYQkUqUmFIOgaUTdkFzF/Poq4uZ/N7y3lR2Q45goN2mBafbQ+k2gKsS6kXgSgDLL4efusCaJyEO8MYoF/nGTZQ4Cvvr9yRDEJRxqSnryqd6sheo6V2W0KEpFYkt1xzR/FogUgCALxZPZb4t3kJXinlGSqbXB3vPcP2yPal26uypharEzehDk1WnTUsqaYqB3thj3OqrZ25yYMfr+opoDoe0Dx+AdnMfbnFtlOEErjaiymr2FIoT+svSx98tP8Fa0I/pqT/Lw3I2FCC40yDkUXP//5NNlm3va3nUJ3UQ8AgaSHx5ltD2UKJfwYk/UP+q2fFwUagDdxzB/laEAdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd1qucrW5zyi9BBoWo1tQitelGnCB7S7ekUR1yq4zoU=;
 b=LxSlmjWPsl0apPwXnBrVYi2NiSqoXZlxGOMc99fdc41pcpBG1SHjCfimPJStldkkvUDt8e/f2DfvDxOv3xNxZFYv/we9Xc+C1wsIx23YfdYrNe50vPPK8hzUWe3YV/uLKoRbFi4bPbF6e5sAcIBIurKZxYCefnel2Q2TdKVhtcE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:08 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:08 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/30] drm/amd/display: Fix ineffective setting of max bpc
 property
Date: Fri, 19 Jun 2020 16:12:21 -0400
Message-Id: <20200619201222.2916504-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01e31768-0980-4e7f-0500-08d8148d2e8a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40876A5FD4E1E9FA7FC9CB4498980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDoInORlJjanQqKhSXQX28wEvhcZpa/T2DED/lSCXUfqvPxvnUYvD+JifmKwo/khDqcBl0KnDp1oe5DA+PlGI44D5fLR4sHec1Zrh8vXPmjMdBOCxW8a57joPBa7aqt0vU5bhIy8jaPAIAVj2rCgzmCJP9Tr1xd3yHXmSrxW2ZZXG4DhQW6qgE9hIeeAnGSGvjMvJNBeKk3rkt4dvc0UpDWm5bgBhQeFfsVVI7S14UAdnf8xJsX22WFK3+NQZk5U1DdV21OEwwOavBxevm8CAJZxF1o+0qlEglh+K7aGOwq7g6wwOa+yyAlz76Atk+nwGRxFbdxWecWmLdhu6dt//w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /3rfVWxi7BPichCJrsfrcIXFJfJ842qcMq8cptGIYFACbk7oG3HFm4V2k21Meqf2F020JYwjWpOGrNwU5i4hdXWDFPH8m+es70WEuMqIgcMdmMsbc8p2G/0xFUB+5CUf33iqefvULyB2TRcB11cPVaGIxuvKu97ebqV9V+vK1fHTrz2PGgdqZaSzNJ1fdw8Cq61fEVNMWQ7fXWljBIlNDzdEoDTXl765hH81oVFxMm2WqCWJsm4prNGvw/ASDWqeEeaClLqmLx2BM+S9kRcZy/wwivqUBsvhZwFzBvVEoVYcGdVJC9XSXe91nw/scKTpCRwlQl7i+JD63ah22NyMK7xyzC6am/HvwqhjX/f7ysPAm1U/OoBHBm+Ja7qFB4s85N10H0Vy6UKcgpAVLE1vL6+KLe6os8T/wCvBANgIv83SxMhNW8T9FpUg3YzTZQlooE8rdzR6pglbgsbHeDGlqXymWehVRZzatqX5/zYmKvTI7XiyqjZ0tq6Be8SPqFHtIrZM+aDgJPM9adwKkRH63g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e31768-0980-4e7f-0500-08d8148d2e8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:07.8837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zmk0ta979EnN1Lye7JZnaOPOYqHVLJgA5rkoZKC938HVgiuCrLT6GqFLubCf515NpUYs+RFz6TNqV2oGgEpZ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Regression was introduced where setting max bpc property has no effect
on the atomic check and final commit. It has the same effect as max bpc
being stuck at 8.

[How]
Correctly propagate max bpc with the new connector state.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e35fd2225972..b3ceba072643 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5135,7 +5135,8 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	struct drm_connector *connector = &aconnector->base;
 	struct amdgpu_device *adev = connector->dev->dev_private;
 	struct dc_stream_state *stream;
-	int requested_bpc = connector->state ? connector->state->max_requested_bpc : 8;
+	const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
+	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
 	do {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
