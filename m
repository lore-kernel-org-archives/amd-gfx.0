Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E73C43460
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD906120E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD906120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACD16E908;
	Wed,  7 Apr 2021 13:05:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDC36E908
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 13:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZDnjnLV0LW/K+IxMTwwcLKn+pR/+8l8uy00XElFtSNWDBzCXawc1OVlFXsqOY+z1CDYnzEOYkBcDdf0oHzcGzSyhSSA8nO9uOfjXKHvLwhjn1++SpTxCDKUZQoEZZv+DGGT7Ze7077cZqqJhG4iNg/cdJllwH3N5sLvjDXxXPI6irnYNbuS28CIO1dB99hRGM2xb0zf5DLs7a8WGKVEE+n+vcnb9RcvBXiXsJWXOCzWjcpHwWSpsVP9RPa2zo4cNHuD2UGETuEVmKZT7yvecSXGg3AdTOZt8FZWY7ttPIvvnhB2zExNN2jQr9/9SYHkrQr2EqA+P7iYHXSSM/l8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN2OO2D85AVVKBWRBFWsywjuEb5Dj7iwoEBquGxauMA=;
 b=Ri0ZTcdhH+KfrhJNpsboEPFH1quXrfnh4/RFs2tCH+8HnlhTHjzWbtdQFj8kRZO0pYe4oMV7RRdBu3W2GkDRUYl8tT3opvq4P636lpItSIsQIk3WGeAVsEgj8F7AyOAOG/PezfV+COYm6AcA1VPom1j4QA/4AxVMZU8pFkbmWHEdXXNRxLazOVxsH391+Divj9kCKos/miU2JFvaMrsNGQ7fWlYwIDTTuB2tbQ0rTysYyG9MsGQStLCc7ug/J1BfAO8YU5hyZfs+yhQBrurTl0PYUu0KshVUy3dDCRmCi1bzDeM5r0JfHfQ9WR5+oyIgVAzSKPzabGgtxe+j8Jv4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN2OO2D85AVVKBWRBFWsywjuEb5Dj7iwoEBquGxauMA=;
 b=INeOOEx6FqeCmkHblfKT7ZPoquqYDwTO7s0DMKQ2azn+bR+aZKmPETQmb55xpnR6+/ywxxRO2VeCP6S8pyoGZPxOjZewsbg3uaq22puhtIhvSqe+gc+rEioWzfRTCGwkAWE2tpqzV1sh/Oyh7PoI2G9q4Z4sTtAKNIi2HVP+6/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM5PR12MB1852.namprd12.prod.outlook.com (2603:10b6:3:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 13:05:31 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd%11]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 13:05:31 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/radeon: Fix size overflow
Date: Wed,  7 Apr 2021 21:04:51 +0800
Message-Id: <20210407130451.47920-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407130451.47920-1-xinhui.pan@amd.com>
References: <20210407130451.47920-1-xinhui.pan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 7 Apr 2021 13:05:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0479bca-0882-4b33-740d-08d8f9c5d2d5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1852F5DFB8EAEA90EFB35A4687759@DM5PR12MB1852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBoNXnRF7PYug1B21rw3QQVhAMdtAMPBL+eUL/9LQBlQi1fu/qrr1dMbMpMLNWtD9b96w3Np2+yNbc3+5bSc3rAeFF0pYtP62r/rsiryv4WuCqQBv1ZAoLAehBp6e0Hs5UXfW7DXYT4aciiQVcL31BT/gtCvi6/mCQRjfnNE0HJPg/RRAO5bvSqWAfGN68QoQs9codeeK87gnct7UIhSMcR69yo4Lcl88DhUsLargORgdPO6mt5uJfCv3BmShZpRwwNIkbTwgBZo6XvxxYSOREpmPXPwehpyMROuPISjbag77GbAGBuInWOvz7SkD/i5f4at/TN2H/f7LFW4pkzgITaMINrEC2g/dYHQbrNNJJEP5svkpxNKwk6fa2cgJynhnUhEK4FF79//fFWPXACH1l3eYM6ZfUdeFfhRFH/Ak6EEMilbqzzTfP8OV35W55CAfwS9/WLuWmGV4sbluLCju9LhFTMosKg0XAKse1nzVLifPNnW1lYQdHH8OAsezbUY+jSaUlON3PICjulsoYkKOqBurTRBQd1VoAjACoUHKfhojTnvc6/3h8zxnrNJ132aIgDtnxwBQ5Bvk1CWW+hhn9Rn6aTgmMbEMsFuzQp4Z4+afXszcwF11mkOggdSvyvwqi+r3CB1CPP8yuXhDSk+lIZPNNYKSzTk0fjESD/lj7Bcx0YYJHSyeRKhFM5f0dsB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(16526019)(2906002)(4326008)(38350700001)(83380400001)(1076003)(186003)(478600001)(66946007)(8676002)(956004)(38100700001)(26005)(5660300002)(6486002)(52116002)(6916009)(7696005)(86362001)(2616005)(8936002)(316002)(6666004)(36756003)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1WW74LMB2y7sqgZnSid+nwnq/bYVm5CtnBzuoMYwY65/7/RZzhEs8xThoBdw?=
 =?us-ascii?Q?EQIjd2K6QhYa7XrK80g18bhwNU8m9YUTmcn4w2w2qA7mHNOgVQJNKiU+dG4M?=
 =?us-ascii?Q?EujKZE7dNAY1YOsTWNfk/tBcvBeoOe0DKH+0POwu4h+yQOOKDXF9QkTYG/v8?=
 =?us-ascii?Q?BGDTW+6/AVNk6imCXLlnm+qo29xlqYIW27w+PkU6l7Zayn8tjBCtfu64Cpie?=
 =?us-ascii?Q?KUHdiePSKJyPutxPFIqdpUHkPkFdR/IMEyjf5UvNszpC5N75pRlq1jnQq9fy?=
 =?us-ascii?Q?O0rfmDPpQVembskATM58m46Lg8AfIxZnmfEyBFm1OEcRVzIX7eVzFSOS1XTY?=
 =?us-ascii?Q?7ygmMvuPLLUXQZAazP9hjgEgchLY+sO7T3p05SzXrzHgD8jELsdAoH3kXtUK?=
 =?us-ascii?Q?TMOQ9fm/GHludPB5ho9ztWZO+zkZiVjWwNZsx02pkKgge9HUN4fHUabGU7oK?=
 =?us-ascii?Q?5LKUJWbR/gL+3yyJqmQRe+prbq56jZPxs8p0kIdPj16ltlhpHcGbnzSrVEbn?=
 =?us-ascii?Q?uXMWgkwKS7C+sa9+ZCgEZAbFPwU+mnz0VLxygKY5s+SaIPx4fOTgJhUucxlI?=
 =?us-ascii?Q?CP0GyvYiyD8UAFf85v0zipgEFXl/SeXN39/NUXOm9dQ5l3WEHrrWsSEDyf6P?=
 =?us-ascii?Q?Hd+zCP1KMYc3yppBTfHdF7Vpnxnl52Xl6HMoMZcbFCAHTtvbbT4rkjiXSxy4?=
 =?us-ascii?Q?CVl5pqlo6Tuhuk1Q86C7K1dcgx+npgYgyWYYk8lle0Gpz21gzQ0DlXC73OO/?=
 =?us-ascii?Q?8rmnUrH0A1S/nEd4aSOUKJGXTiS3Edd2xNjtEj6Mo21uO4+muFQyRPZ/7hsY?=
 =?us-ascii?Q?Exj+AmuFaefpUYu8SfK9/VruG9Onw1Ysi5JMxGbK7aPnbV5L/32Xx9vzqbmR?=
 =?us-ascii?Q?KWw9RjoHmmBqHgIRNw4n+Fi2S9R5WBRBsQq0zRwJ/A1Zl7iIqh1ObRyiSwQm?=
 =?us-ascii?Q?+Q1f93PKbme008UzO5SlYrQd+6zkpJA/VbLYBWSXzy56Pn4vHGmGRYjLR/Pi?=
 =?us-ascii?Q?aaIJ92rvlcLjtRkLX23VgvjKaCEMLc7SNChzkxwGxQJrHZc5sjw7EofdbtQ3?=
 =?us-ascii?Q?3ImBm4WNHqIK8+Bu9QXSZ25V5ler2jXBFVKTNf+dxONBejuMaJVDLrvaJzMj?=
 =?us-ascii?Q?3d+Oh/q0gtFysRJdze0qwLhqwOAI3VU7OkaY72tnoZwcvQQ4+t+QkV7YY+up?=
 =?us-ascii?Q?ZqDqO05JTcQOifPJiJWV2jmO/1l/u8hiyQYUbFGvLF/RFOdIm6J8LSNSuA7U?=
 =?us-ascii?Q?HHdqRiYmXPArLnLLCb2zLxJdcvm2bszfIIqufIH3eFJ3IfSGwwHWvod53oVx?=
 =?us-ascii?Q?G/B49/4Dd3Ssl3/qvbkePWKW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0479bca-0882-4b33-740d-08d8f9c5d2d5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 13:05:31.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsW1H4CVEqukvzeTN4qMWLFalSh0Y27+p8DAqHR82Pfbxxote5LsSptYUZxfRafx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1852
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm->num_pages is uint32. Hit overflow when << PAGE_SHIFT directly

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 2a61cff325e4..b3fb84b45923 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -360,7 +360,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 	if (gtt->userflags & RADEON_GEM_USERPTR_ANONONLY) {
 		/* check that we only pin down anonymous memory
 		   to prevent problems with writeback */
-		unsigned long end = gtt->userptr + ttm->num_pages * PAGE_SIZE;
+		unsigned long end = gtt->userptr + (u64)ttm->num_pages * PAGE_SIZE;
 		struct vm_area_struct *vma;
 		vma = find_vma(gtt->usermm, gtt->userptr);
 		if (!vma || vma->vm_file || vma->vm_end < end)
@@ -382,7 +382,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 	} while (pinned < ttm->num_pages);
 
 	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
-				      ttm->num_pages << PAGE_SHIFT,
+				      (u64)ttm->num_pages << PAGE_SHIFT,
 				      GFP_KERNEL);
 	if (r)
 		goto release_sg;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
