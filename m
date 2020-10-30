Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2BC4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F79620728
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j1FQZ3q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F79620728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FAD26E9A5;
	Fri, 30 Oct 2020 11:05:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CAD6E9A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D83PJL2ULCwJqOVJe8yoqZXByx0owEOo0B+An0RbsNbrRbSRMvMYKyQzreK0LglIVOuXb8JSwLvjrFkVgWi3OX2cJQH/YjWmg+JDBKCyom44bA64WCs7LJA6My/84/mik7MpCghxKMI1VvmP7f/iTDKEBe1j0F3nQEX0SKbNiN4AY7CcnzjgDOrx1KOGXpvm4Qu8dMtzR9EXpsxSVFzJkX7KSZDP8RK43W4pSzrH1potccaHzNJpHC1hqEmLOK6WIzp/17WRVnY3SCgI7VErwbb4WVtJ/xksmeH6ZLQ9wSpTa8w003tDm3xt7Zi1oY3VL0sKzAqISg4+eFO5Rn/OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfLamZARfFuYvXeLZi/sRTXX+GLQYlkEh5AhuZ5CW+4=;
 b=TFOImOC74bMVo9+zC+5dCAyUDLK341PtUg6YuceAD4iqDIjPiJjzaOyfDcc/ftjj/TuJybns9yWVZTL1qDzkcr61WZ8FbdPnQB8hwSL35RJCHArEOpi3C28zDeTbUEUu/plb4IIoODGLQkgowh1c170o46EJxqzsROlJoNAvzA9WsV6VKV63uw1SBfDZ5KGBxTTctiDuvP/9n6hbGXyHLJZbUOvzqraWOLbiXBoi5hgpTR8kasXJWgymfui15f1WFtMhCaUoZIo7LxLTn9KndZF5SQnDOJvS8H6MdIAs+qx/ZZRr0SqtiY6wsZcf01kKbsszfaHCnTovS23rO+L8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfLamZARfFuYvXeLZi/sRTXX+GLQYlkEh5AhuZ5CW+4=;
 b=j1FQZ3q2a/jAp1VPE+qONaTFU6nFOT8Yh1HMRooDSRauelUaK8zOJ3m8f7/ezniuRyLwTXRnv6OcdLnCQggAx98YJ/hyu49qwTLnJXbGXTJCQ0SYW4QYbEvCe9XIW4h0AMiS0f8eUeW5o/5yAm9WwtMEp1L2+BvxqV+mXQomLsw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Fri, 30 Oct 2020 11:05:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 11:05:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for Polaris
 only
Date: Fri, 30 Oct 2020 19:04:45 +0800
Message-Id: <20201030110445.1662217-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 11:05:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b85a05de-9be0-45b6-905e-08d87cc3ade6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2794B5D27E647BF7048AD974E4150@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPoosZjshjY5KLlgnTZBQY+IYieL6xTcSfWQH6YBHPepo2EUsiRYKgNhFLVs6FIsQTKGrLUN71yWggvHFe0rzbafF3gJr2oiywa3LVbW32xwLgx5Cp2XzBDHpkUylZdeulADZ1pklex8QIBmlkVfNGsJvO4qjtKKcKnmNxJ8ZOXr7tZdGUxMYx6/RzQPnbPC5HuRyDe5WbY7tkMMyMbrYVMS+G8Xp/HUInl7JlzLU67vWjJTKaUbK88gASwYFV6t0niXH14Ro+6CQxto9fkRHJY/3CKIvqG+44FfrqIClTLnhBFx2WAREvMoxPRM3IdNt4/sFF6UgJgPs2I34ga0aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(2616005)(7696005)(4326008)(956004)(2906002)(66946007)(44832011)(6666004)(83380400001)(478600001)(66476007)(66556008)(6486002)(52116002)(16526019)(316002)(8936002)(1076003)(86362001)(5660300002)(36756003)(8676002)(26005)(186003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sjt4LqtYFroxUiz5iovit+yfMyOXFIB31S5mmk8vtoPyq522+YPFOq/n3w0fCrjzglhoOEVhc4LQB3geM0lh8gNKBTq/KHq61RpksxeGGNkvvkoImaXwlUR9uIFmcYE9g2U3fWAWp9oiteOoL8IAaxRafXmm0qg1TMhmDLl7MpsIMiMwoOAvzHob96i32FhRGFLEYIimKiSmPoVnP3FqH6/mqjZkJp3UfOuyuV0YMTdwHuJWlmQXiYMgtsZfTi4m8t95C/RoVlhgP/QUUKNOXcmcdVmahVqididtJ8P5X3cZ8eALCqNArfMWgEoM/EBw8a93xLTJ3/jsn6g16iY6Q+zQLdQPfU9yhVFJ7M3qEDWIlN9wq8G5qNPIptMKVfAWo3Y8cYk88UZuP6DK+ot0XPUwfnbWpWdFgUkciuHGPNDWogWQQ+M/zhk5+6M4IDVxWnzzI+csyYd6XCtDuDSmivMDAaAbIlf5gRg9eHlHAR7tA4KJrARmmucE6TLH3i0+zwmJ5ZgqNyVIXeKFNxNVpf3HjJSlIrQgNTf2DqrRE/hvVnG9XXT3LPcsIkOh8oRbG7aCl0MItXHb7i+GV9txtzaZLJ21s9Bi/5c9jeJEClvyYz5KuBUjK0cx9DuOTXLckDpt7eOdbZ7aIzJriwbFfg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85a05de-9be0-45b6-905e-08d87cc3ade6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 11:05:15.4368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf+m87JCOdn42fvgK/CT5oeVbE1ypCSdInH7M6PQSomvt98pxh6b+0qUAiYtC26q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Will expand it to other ASICs after verified.

Change-Id: I03e074ea0e921a984eb819b222e434e88888e375
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index fd39dd67bfa4..84065c12d4b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -462,7 +462,12 @@ bool dm_pp_notify_wm_clock_changes(
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges) {
+	/*
+	 * Limit this watermark setting for Polaris for now
+	 * TODO: expand this to other ASICs
+	 */
+	if ((adev->asic_type >= CHIP_POLARIS10) && (adev->asic_type <= CHIP_VEGAM)
+	     && pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges) {
 		if (!pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
 						(void *)wm_with_clock_ranges))
 			return true;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
