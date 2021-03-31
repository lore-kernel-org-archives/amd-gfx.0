Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE14C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 02:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9287961928
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 02:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9287961928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283E589DF7;
	Wed, 31 Mar 2021 02:28:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0786889DF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 02:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHhqVXYqDT7aNrS5i33lxXL3t6xi/MRaAEt7Lv2n79bioV6VxC2+sjrWiULAb937YxxyUT8lEc4g+aCAyFZs0NUfziDby4iqqyWXYzWmn8/ziPmkzJKwedkZjgsiOMu3ik08COT9hfOJd1N4ZnQpIDSalm7mnGq8azF+jzbor79sXc8wEOg56MZzjP4ax59+dSIUrMvDBKiBGWfIJCFl/4XUoi8vmyYF2UBqUfrlL8GkJpnZ9MMb5bmO7tipBPWRNmpzJrAwBXAdmO7lZH17gYQ+UGat4QYqtNIV/2LvEKjwulwtoB4oZDnbjeD/WelsnH66gget+Hz+EQ1oYyqjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyinEufKoVh196JfgIthQPRx3NxcDRinVelpKSnDenw=;
 b=f0vt/cyInmy99WFrQiphbqbV8OdRJDZWCi3BoM6jSzcX1Def+FxmMeFMljNbEVAx1zYNCY383P0J3pSXxOAWPtkU3B6NoKOeGJCppqBOi40F/GESiTLQ6xS0A9q2vvERqbMtzv8f75OkhkUZfqmO1uog6HfvefL+zidpd8h47zoE9OhPl4onczjPbQV1nuFI8Y/kZzfPl7DGT8uOtcYS8JBk0E121e78YoKJ75KRcHZfBq1ERlghwCShgVwLfVwIp9tYafKQydtr6iC69nuh7DReBw4Oem+INn+MFWw/AyxU7kngML8jvg9qGA+qbP4nDsEaf/Jp7ICTq8JJ5Ab6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyinEufKoVh196JfgIthQPRx3NxcDRinVelpKSnDenw=;
 b=Q2l4POw7m1uwk1W52IbMnqfFrzcEe+VgfuJaQf8zLxtwoFT0q76Ld+5KcN1cCas8d1GzRqYKRwsZjkk9gg1lcNHB5jeMu+jst7OpgDwoRZRbzmnu7iTtcL1452tQxLydDzl49EmFIgMslSGcxJgipffGdKjwsLcJMhwyfnKezDs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 31 Mar
 2021 02:28:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 02:28:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: guard ttu_regs with CONFIG_DRM_AMD_DC_DCN
Date: Tue, 30 Mar 2021 22:28:10 -0400
Message-Id: <20210331022810.2590493-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0369.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0369.namprd13.prod.outlook.com (2603:10b6:208:2c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.20 via Frontend
 Transport; Wed, 31 Mar 2021 02:28:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d33e60be-9f1b-4f22-df28-08d8f3ecaa21
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45334C89008034416D6BA186F77C9@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxCtkP/gIdv7sD4GEHGoxvdajv5bo3o7M/Busk3zNTS/uZLRfkDbiPXZf0D7+W7ej6P09IsOhlN0UCnJ+IcVgVueopd+BEnONGpswV6PH6T4Ve+VT5wxKz3UtuCkbblQYpk/ObwB66oqXQlrnPoL0pleNGu4wHPL7UjmnjA05+A7VmBPYrb83RXvBPuffsG1MgHCk/Tw3nb//rsch+AYS89W1h9FEt/0rUCDsmx8p+lTEsjsONpPAbevGAWlBUCrGc3shG5g3MuG4emKJpxQJEguq5/lVbfIApeg9Q5dSTIBDaHoGZcbjfL+jcZFjq1rEDRQObrJd9y3tqSCPJL7U4Ms4veLzVpXgxGxazu+XXZ+cUBpnR2S26PI4R1WZtccD47Jb7ynyu9GjFYedbC4MKPX+KSIFuZEr7980QGyH5KyLrRIESXGwGAagQfcIqRsGvi7fi5q5rVO1dMwfBZTobZR7nxibu7/ej8B/9iwGNIJND8Ioo3sfIV11SBxyLh7MbYp/n/T0DgM68C5xpCi6oQBtXGlUbU5iENe2ZPd4hBRRQjd5bfhncqb93ArZV5Cff1wZcz7UH7O38kJIrLBG+Mxwdt6j9+qex3OeagOua8+TCa2JRzHWh87k1BrkYw2M8U+H9pAn6rgnlxYrw1iO8ar3aVkMX90T2esZI8OLNu86qhCBMLiU1j2YrFU//V/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(86362001)(69590400012)(6916009)(5660300002)(6666004)(8676002)(956004)(6512007)(4326008)(83380400001)(52116002)(8936002)(316002)(6486002)(1076003)(2906002)(6506007)(66556008)(66476007)(66946007)(2616005)(478600001)(16526019)(186003)(38100700001)(54906003)(26005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vXe95SzhbiS7TgSkj5ZS95d+wkK6ulNBYZO0YRFq6REo43vJuHVM0qKmTY4k?=
 =?us-ascii?Q?ONIea+H0NgfMt6W3WUMhjdKPByejGU7xCEG75KOJVTAqK+DZV25hxpW4wKIb?=
 =?us-ascii?Q?aI7hRI2otkQAgp0CaoXFZmuiIjTUZFteKLS1xKcLcNuO8kuoc7Qpq/26Jx6A?=
 =?us-ascii?Q?FPmzuJaFc5UvY3GK5lOLJPf9h5vHp8Lv8X90sb/kKlDANY32FGpIF/j/TOWb?=
 =?us-ascii?Q?Fb9g5nijup86191DEIeByU89ST/SFjhRlqHFzha2UnwazdNf2PdKJsGpZDXl?=
 =?us-ascii?Q?9zepzsG/rIQeshunVTek5FODyW7B8qPl0PrCa8ZOi/bVsDr4rFINk7rbaJYN?=
 =?us-ascii?Q?ksZC8oMz+xHExhbxpcTTJ5zFvw2ZNpdfnqG6xWqXvuc0wCYOFOepMVLz8FDK?=
 =?us-ascii?Q?1jZA0mMpgoyG0m0+UqizCr/oCDzcgWOaaKt0TQsUZbmKxfNyEZ5rCPMlT5ah?=
 =?us-ascii?Q?EfvSlqCKSOMP0kXN3skU71fo3+95DaGp4JM9AsrutwFP+DIJreDW2kRbNQ9p?=
 =?us-ascii?Q?3wEX8oPxAJNn9Y4oz35BLo+i4SI1LQEacjJVIwWpLzNF58lJ7sA2thdZriLu?=
 =?us-ascii?Q?6HLJbxqAfCX7D+kmOrFDzM5tPskz1fwpPicv3dkPLSYNrv3yebDW6mX2iM39?=
 =?us-ascii?Q?fhaung4QSUH+HoOxY03nCr9k+73KS5/lqJvakkjiVHncYB4rDC1I5mpmWyP0?=
 =?us-ascii?Q?bNneG7+zfP42TjHiCsGD2X4aD5YrPBYdh5TeYPyi7RMgfikAn7tNfAHTniee?=
 =?us-ascii?Q?3e/8qy6WEEz8NLkGz3RxTfax2KA+ZIRRJ+bAnuVBuTRwUC3Ye95FzxkfY1Zm?=
 =?us-ascii?Q?5lYwPcOCmM0OiVHdZG9w0WZj1OVyp+23rJ2mbOm+L95DrpCSiyvZf/IVWmEq?=
 =?us-ascii?Q?FEjJdtGaIBLqLrrUEQNajFSZdd5JPYfb0Zsg0UpUolx/gIxxZpRGMsNym+1/?=
 =?us-ascii?Q?KOByj6c0QLGyOUOmHbF+0rr/RoBg/4ehb1a/1c0AP2oIGEfHWWPtU6fNs3wY?=
 =?us-ascii?Q?U3j8mbRIISAy6iRNTxi4vbmQytEAYownY+Lao00dGiTzU/UV4IQRAKIsCxpe?=
 =?us-ascii?Q?AwJi8kOoB+ltqRROKNahvGwoym2tbdj/ilpMv6dA+U/K0eY/nKS3a2TEakzN?=
 =?us-ascii?Q?Nogou8gZZaxGErfZF/q6/CBB0/sdgIaXdLusKsSlFGBKLehCgeM2PQbeMYR9?=
 =?us-ascii?Q?lCMOwnk2g3cP+9JfgRnOxdW+Q2muGrVgNzsWi2N4YXVTL6+JTuQg1ZaKFL0i?=
 =?us-ascii?Q?PMSOHzefyOOUA6+drdZHeAOnyCVpHlQ97MG5LxtaAL91Pvh1WqNsoaa5IgPh?=
 =?us-ascii?Q?8MYiYqlTX/ljmpcMCgtUuEsO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33e60be-9f1b-4f22-df28-08d8f3ecaa21
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 02:28:26.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8LYBTakyN9B+9inIjWNxcWNlt4OYDpL41jgOBGyiTu/Qls6hnKj2agZyRBlz/my0JdqbeLj+aVZ1Zvg0AuO0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Missing check for CONFIG_DRM_AMD_DC_DCN.

Fixes: 752106f5c5cd ("drm/amd/display: Set max TTU on DPG enable")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d9ab134a178f..a270879cbaba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2599,6 +2599,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
+#ifdef CONFIG_DRM_AMD_DC_DCN
 	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
 		struct pipe_ctx *mpcc_pipe;
 		struct pipe_ctx *odm_pipe;
@@ -2607,7 +2608,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
-
+#endif
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
