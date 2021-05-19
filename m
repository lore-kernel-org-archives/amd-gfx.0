Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49138C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C84611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C84611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A2C6EE1A;
	Wed, 19 May 2021 16:22:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078046EE2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUL6R+CwsyyBXSc5DoXYe1Zv6RgT/wZPv+A0f3bfrhbEDaAcPAQK5m+mxphQUTYjSqS3OeJVHFROGv0ZA6oA2zcKGbZXquk2GVtxkfcKbD7BLC9sIBg68R/rM2KdcVC4vcxKoVSKjJBp8EL/9HcvTGNH1L6hD7ht8YOregclOgACmjvaEO8Eb7P5hlZiin+wyn2hQPi02KGaKApcd0UVZIUt2lnChl5I/joFu8O4VDzKOQy0/u0bqk0KKI1juNAb5DAPvYNZlKLekeBevYyeHWs/7hnWE7lp1xW8ciuXoGKPxWXZJpE67kEsZbBOrPv0AIE2UDkbSSVzwidvsPwnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/ll5nM4pLojFgw6KAziMZeWeZiodfQ5EpQpssOup14=;
 b=QIDPn8QZS1edFFgSynVOZG1Ycp14aR0pinJvyEejmwRo6yokmNwo55cFPjrccSIdwddQ/is2TR5HnNnXXZ/2FfJpLhjxjAtl3GSYBcw7kuna4F1AUPklw8C4eW8xcawaH2+SPSX0a0GDQef2uF3PQEs6b5amdXn9U0orwXD758AurFBilGMzA9rv91isbPcmTon+l0xBx03Es/c9i597Ga9gm1+u44aJLPTJpvh5z9zcsVO2Fn/JSdjMF0EqIE0JPVAz/q/4F1xZsCItjmxFwXkDFV06oHfWRv6hTjvJ2R705/nTU7a03ynlkao/JFXAHAroNZj01weWm8wgcbGK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/ll5nM4pLojFgw6KAziMZeWeZiodfQ5EpQpssOup14=;
 b=3wGCL+iq4GzSeG+yFj1lIKfCnhejBFrG1q4aztCtNTodZF1E4CZ7uu9bZhMETnu2NxZ89lYLmd+1oBpgK7KVcaFTXrOYutc4IbvL5kBwNGd7qm1AkM2PwLx91OwnbImBCr9rGyUG54ImqZ+XaxC4pPqwVv5GXfkZDxH5TFPtE1M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:56 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:55 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu/vcn3: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:35 -0400
Message-Id: <1621441358-14685-4-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f758df87-837b-4a7e-436c-08d91ae25b70
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325939C288F867C55D5F3FE9E42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vT76Z2N37nHIV2G523cFCd+R5bGBZQ/+G1iGFDUm33OnUkboPfEEbfsscTtAXx60JvM/XvO8QvU82vX+rCyZnIsXt7H5Q/2zqC0wRVJgUGNlRy76N7dLmUWOrjkiO9bSjmmqpS7uinJnjRYbT/LC8F420URhsyPTSMncC2prS0mqAmS/MWAX29GjPTOpXWF05zX7JUVFP26M4ixPiTgxkHeMkxp0XyZFCkoR2OWvOqexViqcD1YQM4Axfas6T3lNACb6D5Ywmxd5f08VS0WpO0e57PhxZmGCT4He6QYWyGlvJNNa/SoolRYtc2H6UTWLx4T7KxPQwZ9B3N8qxKL0pyBC1+7+4+dHVDYAk/Tbj2ThjniHcT5FUvdXwq9bovcngOW0xg2LeJMz+Sy6VcL/r2IcG6Gly6ngZwrda5bD0bfOJkuH7+ETSeb/1didhyEIZU4F9GfiH8KiILCn2jx+hHMJZs42qDjzggMFFxreu+fJ4InwyspUEoekF3sILyrAYEXCc0bX3WqhMi7OhBw38hE8WTfdwceRIg2/deU64WDlz459QUIoCcV9xVRoRBcOAofmv/WkOGQGlV/9D+IOGs1aI9Y9LZCxt5LGPoUablO+e1ovQ8nD1l0uOVPoTIL6UvXKxiGxN1eXMzGvA67mzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xs4xRISeLgM/gimF7QF65dRdhzvgZLuTc4mH96VVJ1vCxd+1cnUHJxLJcKMr?=
 =?us-ascii?Q?C3WPraGIhhrRn27l2sxR1xkdTM1o2fk/SwktbgfvUy9gZb4HlSfSWOcWvkwv?=
 =?us-ascii?Q?nG83jGJ3BXx+jnQriPEDYjEtqqnjvaJbRKZ6vSZdKBq3zvfen4GeM3maZes/?=
 =?us-ascii?Q?iP1g51OOeq5RkhnvWaRwe+sOhK2sxMR2cLo8Q6UV11nJLYMspoZE5njMNOTF?=
 =?us-ascii?Q?9pntWt6JTF1IZERiY2fjjlVl+lbMjcH5WXv6AYQ9o1rLhlAbvzNpP93hU97s?=
 =?us-ascii?Q?TZw5dzOnHxSdkSrCfrNR/etsVu03cd9UncmcVDO9PFhNJ7hHe7ZcKgqfwCVN?=
 =?us-ascii?Q?lOuJWE1YmRzq4F8hTucXVlisawqMMXkrszOKsDsg5zbyPngKh3U+T8dbfBQ8?=
 =?us-ascii?Q?1NEJhcHf6CM9qJXF4GAWJHlFO6uDbesHS1I15zHmjRWl+rQi8z/A+W1pLeXo?=
 =?us-ascii?Q?gfmDjSTF1W5TuhBj5RlLExwxH57JCiosf9U6J3UWo8gXhIC8nxcs1XroyGPe?=
 =?us-ascii?Q?2cLFJ6bVMG8Ib84rLXvVUYAvCbmfR9n5svpNu8RiQ5kmG5t9cE8LFDqHm9Qb?=
 =?us-ascii?Q?nwJBgG9RFGyunT1p5Ezf26+s/JKt+XjUJ4ZDLoJbtH4urFHNyRFW5HVSh31F?=
 =?us-ascii?Q?3ad+Vntc0BZ1Gelr7vrSyJqm+hjtR+5FmgYRnX0bKCe6lIJgOFi/6mAoiyo9?=
 =?us-ascii?Q?xDSMIML9wxSLYOmfOHXklY7OMKP35YsjCTRYy9lvHtmJ4bWtVVOTdivgqDM9?=
 =?us-ascii?Q?AbwJh67AVhPZrvTinpy7c2rM2fATIYFDucS+o+5fZ9jEQQF5/MhbkbhcXpB7?=
 =?us-ascii?Q?bR8A23vmzyvI5ICYo04dgFUA+xzZ0GMb1mRfWzPkDVsRRcWqvN2PAiKdc6n3?=
 =?us-ascii?Q?F8OvDY/F5NWdeqx68KhybZnSMjfmZ/Wzv18oN862v/3xOT58AiMrlIO+tEZs?=
 =?us-ascii?Q?WRBkJW9JB0X6S68eZLuI/9xRpTevH3IiXUK/GkHxTckhV0Q9B/4GB9DjO7UA?=
 =?us-ascii?Q?4M3ZpAx2o8kurDsTdqbNy5g8KB82jeYilPYkNXwYY0alFqBl4GI6ucduFp0Z?=
 =?us-ascii?Q?oWS4sdPSWHH3ZcyiPdBgk4LVQbRrtry9Bcy4+yfIF0ypFbuDExGc7lQ26nDV?=
 =?us-ascii?Q?TvAz0BzinpCyz3SPadZxJ0QH990O6iynYUIvISYrzOKIMs/cI1qjRvaqyREw?=
 =?us-ascii?Q?kxChigh0N1i4GCMJVI/TBiQYDyuMlvShf81FiPnvHKp5R1SotU8NV4yb4DMk?=
 =?us-ascii?Q?YZFH2N4lYnusjJ1jtbsr1wAAmxvCt2EoA2EIcBAUH4QnPv1vLQEg94l421Av?=
 =?us-ascii?Q?yYDOK+SAwCYPZHIVfXXD4eBY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f758df87-837b-4a7e-436c-08d91ae25b70
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:55.0489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyIkFIWUiPYihjBaB9wKZba7BNYRksnCJprMZ96eBribQMU1GOkaNoZY5LxnVPAW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2d67cab..ce3c794 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -380,15 +380,14 @@ static int vcn_v3_0_hw_init(void *handle)
 static int vcn_v3_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring;
-	int i, j;
+	int i;
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		ring = &adev->vcn.inst[i].ring_dec;
-
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
