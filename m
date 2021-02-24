Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899EC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E483A64E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E483A64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F786EB4F;
	Wed, 24 Feb 2021 22:20:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA356EB3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5uaEhg+nMKpo0zpLkqpec6DnYiW3LJzl4zR8PzNxhT8VJ5e9CKm0BOtDLHy82875stEDEH1rGeq5DHaYk0mYI8hAbeU17yaxLi0HnlMPfsQPq4kkDQ8BX96Hm+aeqPVdBAc/KxUEp0pSBkL9GI/VVae6Cdp7o4ak+3addwWUg6EZ2pnKIQhcafNKYivhX6IT9aeXgrjwB1n47nipdTkb+X4Tz1AJV3DMcKz877963XheHmWJYZ6ghy5wnCJHKNMZGOyJzGHsm07f6XkJ2uW6X6AxOURKDhCczENLk1uxEwNEdDTD6PagqgG4OqMN84uW6MpGDXHzMC8hUiRg7lRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93uBj6KKZGaivflRIOhz/Ym9N3gB572KeD6616e0yP4=;
 b=Ynutsopwh1gb2oZyX4phMzJlVsEs6Ck6Cg+av0fcDo7skejg8GZ+rDblArhXzHhQ/4ccmK34fEoiStnP7po2tvuACmKU/ROiV32oSmqcXaLbhO6QNCy3mS5RejE9WCUL5kIoaMvtTNtIzteeLGzEUGAJes5soZchL59E2w2Oq7Vax6P0/ci4LvQLNaTc9CUVfGAZL0orks9e06rnsQyal/WXRy1Ub6TfeOgZjhFTgCQDJoNzC9dUmJMgc8SdRNJ346H1tAV2CF0S75+BLz0G6plHQ8YrPGxS7fkxBAbvA9GiItwXL8Ky2h9i4pZcncBFkQ2/Hxlv9h4rVNuuEdMlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93uBj6KKZGaivflRIOhz/Ym9N3gB572KeD6616e0yP4=;
 b=akBMFpkCSVGfUziBzfIMuOlt1p8kbvAMIaqopnWrnPHVRS+Ceo0t0UerFaJOUwcOnBdI4mqsSlH06Lj3bN58g0z074NcTl4ics793kmSd8HoEJ5r6Chf6TLcXZ1kQmB7wxZoRpRmAfCPywV2vjFnmRfbdQNA6zF5xHJVAjG5CmA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 062/159] drm/amdgpu: initialize external rev_id for aldebaran
Date: Wed, 24 Feb 2021 17:17:22 -0500
Message-Id: <20210224221859.3068810-55-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c00c5479-1ae9-4901-7614-08d8d9125513
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41752EFA169B608C0894394CF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Mw4JkSVBDn/w/EyvnAgH914fztXOUcjQExB3Azs6y87LTbV4g8BZPRDq86DWRlKeCMFdzR1NH4ukFJYAzQRioc/j6PM1yDzEopdiZnM7ik1cNKst1QQYbGyFYFhMID+oUalXZKlMnHU+taDRVPxFROWChkK4Ij3qIITioNTppYf8JePrnQsno+FYS5sa6xSXnjxKexr2LxraeLVy7Sf6+Gds/YF7fIpS6PTcxYZeLWGqXsC2ALt0LP8MZBe/Kj1xyg8RQwejPc/n1lbkDrlAdNUdwPXBEnmE0ODp6nqSxT2Uxd/Y1oPjSZeZJeY/tW5k/VhQGDC0FFie99Yv0oZIA0QXgMYl4hKMG3C3pyGUT6cQOB7egLVvSwzX0uszv3ZYjZFjcnT//RUeX4uygly8sfZ9hOrMeuTTNiYYhEcbN12j7RC7RVW2nt6XtddkHLHIIMmoqw3gwkw31yYE2HWjU81Dp5SP9yjlgc0sDKFslIJ/B0NTHQbmHK094x0EQq/4Ga4KnkVT20zhPG50IYkYLUEoFd57atnWsIPz/SCaXTxerr7TKBh6E01eMMd2e0dWYuE0HFJx0xB+hZOICkUYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gJ208z49c1hNMVQmPMdzPJVCMB5O2IZbdLq5FeFKXlF1c6wTcU+ArZQWPjh3?=
 =?us-ascii?Q?Mmt3bUiiKUoILPNXj1Rdp9Qv7bQ50/m3iIUsnZMsEuSMZw4Z4/LiNiOGKyl+?=
 =?us-ascii?Q?4MFbd5B/S5tmWjOU8mIvVWHqM/pU4G//zGMr8ZqzZtVeRPgCc4byIe6yZMSt?=
 =?us-ascii?Q?gvjlSmlsrZF+YceZzUqSolLvwv+YqyXZMoNX92KwHtU41y8AnN9gaQoJV68Z?=
 =?us-ascii?Q?7c6lGmKQl4rVoxMpOLQN46BK48kl8Q9GhrZYXvszUmVB9dQs8V/AGIH2B3Jt?=
 =?us-ascii?Q?+L9vi0L/tnrGYE8yFmCio4WxSA4iSNf2D6mKBTpJ6y5OEoXhL3uqI7Mg0Qk/?=
 =?us-ascii?Q?Q3Rh9D8rQjajGPVYSNngUDzlgGRZ+5dl9i92WAQNMJunKIXtn7guRKEUMGCe?=
 =?us-ascii?Q?dYpHdxqVcJCuok/IQELWn0VZDNCw++MUd+vs1wrPE99KpMijbmUJ3dHEvRoj?=
 =?us-ascii?Q?6bkU7i0tVearRNTyMhvl+8T8AnXTOr7CSj7WfCcoxwysEbSFlLyY+LQmJxWQ?=
 =?us-ascii?Q?1KgYw2pL74I+hJUx6KM4SDkYK9781h6gSmi2ljYHXjTctMPMVWiAUHDrDmQn?=
 =?us-ascii?Q?PQ7E5ZpX5DQVVkNvpgV54h5X/419//t0PhXr2e4c8lhAfDsJigD3TQuWzZhh?=
 =?us-ascii?Q?T+FaWCQ6N3qLWt9xNxM+8pP2WYLUw9dHO8r4qAjkr4mOzquQLQPvIq7SXXGG?=
 =?us-ascii?Q?eb5ZVSWrtIewtJlAuXJOawqM+z9Y9GlgshZ6Fck8EaViZhkEqGQmPbekctLx?=
 =?us-ascii?Q?HY4POKVGQNNupme6lWyZka/YgRJTn10xvem/s5mAo0y+6xHuJ2HMlJ2NaSM7?=
 =?us-ascii?Q?qBK5zq47u+ngC7UmxYzVRVIFXhPSHR+P+lESygtbbvc+4vHzqYBCRnoIToR+?=
 =?us-ascii?Q?wRjbw/MT2Iik9QYihAPNglMve5o7r07AQm78/WuoqZscIg3KtGoqwW2tHmJ2?=
 =?us-ascii?Q?DSuinb2aW0NuxYkq78I/HTrYCv4R3qQWx5mVrhXDRU0Eu9fEVGhVDIAwTX6i?=
 =?us-ascii?Q?NH6972GzDn5Y22lmJ2bLbxodNapDeClebo24/akZE2lrYtA2LEyMvHRPRDvg?=
 =?us-ascii?Q?hmeiLvVxbLthabntQI05+s4xw3WXSgDiI+LUyapFjOGglrPoeXX6tT9zn8OO?=
 =?us-ascii?Q?/ES8Qi4xIZNtzS5+EXrBf2Xod7WkxdHQOnYLScJs1yf2wK8T9lZVFVx0Qkp+?=
 =?us-ascii?Q?K34XfTl97p8TyJoghAekGHIRp8GkZErOW/Vwn0ozfuTDB/hxHdVokdAWsgAD?=
 =?us-ascii?Q?SXlQFUj+OQ9V4XxBsng1/SufYADmibexAvBbjyZaz3WyfvYWiLHjw3v8Mg2o?=
 =?us-ascii?Q?8qHbOsQNxxWbEyoui5lnOhvn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00c5479-1ae9-4901-7614-08d8d9125513
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:03.4764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0UD51JdiXMXX1GxeaRi2PoYUoypMMia7ZY9/h3B7UN6x0crJFcOQ4Rdj3E9wzv5rcraUuWy/JwqOyZL6/qcCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

add exteranal rev_id for aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 14c6a27b2934..c45904b4ae23 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1274,6 +1274,7 @@ static int soc15_common_early_init(void *handle)
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags = 0;
 		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
