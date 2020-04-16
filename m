Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D96C38A29
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1DB21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gCL+3QXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1DB21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB5389174;
	Thu, 16 Apr 2020 23:41:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCE56E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyUBe5A5PBA/wooXm5z4r8DzcYLh+p1WURLTprPe5kcOWx12vHvdvLYEMH7y/9XIgrKAnmVvjBvDD9PVIZmGNsSBkmDupvKiJi4vSUrBiWSLEhajZuDKduVAnUZdeCC6JCBKqFOkOzOzwgkcbQGq8QEZAaXAaPkoYw/RoMPHJkljulpxT9MwPCAGAFy1qR9E6M1Dt53w0sW+1bRcHXbiW00pN6s+NNSaYwOvtGVzQO7nAKNB6oHXds/Fpzg3iE/O+VT/TG6UfuwiLlPEfFyfJiXs5IWGrBPoy2jvKAMiIo/x+R2WQ8Ede9uIe2O8xDOBwfYnv4F/1Nm+A9wClbvu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFTcg/52lDozhWQjJLI2i22ycfQzdnyxI/moKRcZknk=;
 b=g+YfLIRjrfrLjbhLAWeKgvU8tddc01u/+n5r710QZ4f6CcDBYJ5ixUUt9F2ewdJ/zlkftxxevNmF1Kzv+SzOezhisdtfQ/80vFGRH9z6v6ap19dwqUrPsns+d4vKY7tlp0gPZ5xtLyhx2z5Dsi67ZIjjWQ3VNN//tY33rLhUnHaBG+f7P6vDsk92Ty+1+9sIcY1VGcigVlktJzv0iR0gJIacALHX769WxrFa0SKNB+qSswboMBX2T0yfMmwxIkHbSZ2cAAWcZMLpESb9rI9Ivb6SPrxCNbBCZllcXtKS7WfM1/6QFk1zReSMzkWt4FFwh2b8UJ9S4LAwAkubsAMupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFTcg/52lDozhWQjJLI2i22ycfQzdnyxI/moKRcZknk=;
 b=gCL+3QXwIxD0RjlQ5JDySbKkJlPOHKgcNA1m0M4uLLRhHmrFvHX6aIBEZlqpBofCKSf+DAIkeiLFpofrCOcbqkLgmtbFYEJv8irJ3VuHx9by2WI3P0ys0hFaR/j3WZ86phEu0U5hdMsyjRfpR9R3jIuiM+nCzxj6+mXKMfgWLkk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:18 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/35] drm/amd/display: Support plane-level gamut remap in DM
Date: Thu, 16 Apr 2020 19:40:16 -0400
Message-Id: <20200416234044.2082886-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:16 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79e8610a-43f9-42a0-1fa1-08d7e25fa8e6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24599ABAC56FED7BA11286AB98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGdu+y0zRIHYphiTXF8ytAnzYNyQh3KvdGjiTOEMeVCYTsYJ3OJdKcPMzrs3cAkVah0jZVWWTTxpbKiDo+G0d/08nCakBYyS7eYN/qz+uvLqVC3jw2lrIAg/F0iWI+7pXIpPjeRLftemZvMJ7tArOylVVBb0LaV5IN26N2i4SppOurE8QHLES2km9cHvkAPwWSGhrZHZgx0PtKfs80JYJYSg2jhM6ChJYjrUTs0DzktnbSpbGrMd7JwzNufR4rWmlSPNVLeLHidstDhZVuMd77uCKROd9poIhrHYqbuZRFOo6QQmyKUJyERV45ffgEzOVWSlpBCFkOBobnxtDW/v/ArsRbvnIzCIYX5lfElBbl/Z+uh9GWdMBRW4ihS6L8lV+oghxsxGYij01J/HNhPj4qNfoYJebqw86Hg7uCe+rRxNaTgjenuNFQtGwA4tGBJ/
X-MS-Exchange-AntiSpam-MessageData: WzmjZcsheVGD1r+9+3UDqomKt4rpZM1Mn2Kql6G7kBi0deotrWELWVKReeqCVHW8Aw/7CTdYmvqF+/IQUr9KRaHjvokNKq60Im/vZKpvAjziMpvU1GJAk2dLurLeHYjHeSbQoyv1VCv978xyX+lPIdBfc2wmkNKbQBjhknsRQ4g=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e8610a-43f9-42a0-1fa1-08d7e25fa8e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:18.2377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwAmeQkp+3/UKT0RvUz7DXc6l03dlAznOCysXkytoBhgELMSliIGhpNV+Obk/AN46vwh8tOuoiRU+77nIMDDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Plane-level gamut remap is not enabled in DM, which is necessary to
support CTM as a plane-level property.

[How]
Enable gamut remap in DM.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c86b32d4274b..47d12c38bc71 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6728,6 +6728,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (new_pcrtc_state->color_mgmt_changed) {
 			bundle->surface_updates[planes_count].gamma = dc_plane->gamma_correction;
 			bundle->surface_updates[planes_count].in_transfer_func = dc_plane->in_transfer_func;
+			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
 		}
 
 		fill_dc_scaling_info(new_plane_state,
@@ -8173,6 +8174,8 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 						new_dm_plane_state->dc_state->gamma_correction;
 				bundle->surface_updates[num_plane].in_transfer_func =
 						new_dm_plane_state->dc_state->in_transfer_func;
+				bundle->surface_updates[num_plane].gamut_remap_matrix =
+						&new_dm_plane_state->dc_state->gamut_remap_matrix;
 				bundle->stream_update.gamut_remap =
 						&new_dm_crtc_state->stream->gamut_remap_matrix;
 				bundle->stream_update.output_csc_transform =
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
