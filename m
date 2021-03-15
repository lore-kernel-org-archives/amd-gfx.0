Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C05C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D23064DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D23064DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B9A898FA;
	Mon, 15 Mar 2021 11:22:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3306898A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATzZHY45FhAgw1jbqlxeR6yX59XGdDQKaC+PnKIjP2xW0pxhw9WtIsYeuK14zfL81+al9bsJlYSfIvVA8NyepGHsbGZcLsxIvBI8WaiqT+/982z4ShcRu37Cz2HKsJdIj4PP8GnW/w7/Y/O0OrEXPocokjkhxoS20pSLPJdrAn2IttmLP/Vb9gsMDS6aWSjlfoM1cihcn6X/OP2qOYTvl6qVR66V96uch7i5tynF9UCI8TFEAVCgzB0qgg7oq4HCRNDkCSDIx9fCMgjTnp1HBFI5ni9tsSHvF6sUrC3WlJy7MhSB1kR6WJdpR7gEosLPMYq7rPQ2EMA084zDyZwb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20dmNhlldzc3oNLUjIYWYaDrzrkWqxfgoyCdVZXN2l0=;
 b=gIGneRRYJkl+zHveDLRzkaT3FiNKCQieKmEwmgQ0CqaHXoAlsDYDg338Ly38XO2jJu9mTvoucxnfh8Exk9sjp6rOKCoh53O4DxHaq7W1EWdTyJHV6lses9qPs9K4TjKUCOaFMacUYkGWkXCKnBvFNY/JQ0nxVUjzqh17Xj+6OytR4YUdcCSrORUNN8u+J7oZRlR1MB1LV0mNk5TpcO8Fr+39cg76ebuCWbpNwFlFe4qPv5XICdSriWhxarcg9LyHPBngZgqRybLdkEBOmviqhjQch8UiTFSubBsRJ8l4+58vpl9xd3tprTKqysLExuiX2VZapqhvnBigQMTWqW6uxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20dmNhlldzc3oNLUjIYWYaDrzrkWqxfgoyCdVZXN2l0=;
 b=26VUHrvjo5lj6Ul+aAzT9NhwzAc7v3Q/F3lr0HH/thByrVSE+MlpeRUMn7w/3nCjdrH3dNF66BInEvFftekUP8pQgPrhMsHDxYEI2yI7D1A2x1i5FNG/KJLTdeANGJLR6NNZ/nFIwwxRXzjfwWTIKgFnLjuoeQT7UBsz0JlSss4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:24 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:24 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/23] drm/amd/display: Add debug out when viewport too small
Date: Mon, 15 Mar 2021 09:39:49 +0800
Message-Id: <20210315014010.16238-3-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74b2472d-9b49-43b5-9f8e-08d8e7a49b3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617FCE98186B62F767B0706976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55KpJE51g8OpLf8syHlrAF4h+mBkCt83HyjA+44AXZEG4Kw+HTLxzy8IcHW/Pe+eCHUNvC/jKR40PoKE15fW/xg1GAQv3nmk9UBS3oDRD21AjxfvvKVe3MS5lZ6Y+B1gTzEC9f7ulzL32ygB4cw//8wgr2VEmJg+NtQ0TMY7fVMtGMzOEc/LwEM/B2Ns6XrJBBhK9EcnfznPDc71mrjv6zd0snUgBXA01uR1CvEquC1DI8uKJy0frQT9X6Zt+/gOe9aROkquMwD05aT0BHdr9uPyfNpxweFfax0PugixM+3KBePZAHSGN1FOzsWihv93OPF/DUjrzSmhMyaUar1lE29t1ruX6gC40fLEyLIBeB8o2I8cmYIU60BXCz2zWewR+WMoHqj7seE67+FRwTxqowdQA5pyLFihNJGvkWlcNoZREcQe27BXsfd4eUkqlnO8ufwWxT9ydY8um2s6jHrR84yfeUqTcHjNLw3u/mmoOKvjvrPZ3r6Pi9kDfSS61TBrvIG4KyByoirSGzOrLahYucEyRNwIq+jMYsTOs6S9UDWmB76B8DqR2UTz5lmSf3sP3nscCV0LsZqwH/HjIB9Op8Frc7hQNpoIPpqHv/O3IxlCMaBOMlUZkI2nPTxlQpDhS+GKaLF89x3SdCODDRvmiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003)(160913001)(15963001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?brTUiEn3Y+vHC9pJ6Z7UDx408IAAC3nf4DoQaXA0GygRgXzLXhh6uhFej4Wr?=
 =?us-ascii?Q?1PAJ+7po+gG2eyc6cL6d+fAxBQaVj3DAf6tJK1TQLbttHVRC41S4cAvmeoVL?=
 =?us-ascii?Q?qZe0DpJ4kWmLvs83h+OcyWdbiQQ1N7IDRW4wvr08GwLYmGEPYmMzlh5EZIoi?=
 =?us-ascii?Q?rogO9YlTOnmg72yP9JWaQ8W9ONXBMoXCioN6cGnsusch0OV4mw9pCLxZMXak?=
 =?us-ascii?Q?hCEyw4MGch7R16N3Qseo4ZESV0Oq72EJYavPe+9FCopnM4iOgmdyddxCpXt4?=
 =?us-ascii?Q?DzLTjM2NFNaBBNbJ1K5KlVxDDQolGt9H8DWURindTcqYL0RlP0YOp+9Gz4Js?=
 =?us-ascii?Q?4gCr4w7e2D6F0/rj+CRBj7dD2xIfWn3Y1bVhjtJ2QECu/QEClQMbYgU/n/zA?=
 =?us-ascii?Q?7H/lc1tlSuVd52+5uOSfvMnbidRnsSKNwow5PuVT8NIPyXDmRzwkYFfN1a1o?=
 =?us-ascii?Q?mVuwhThWVCTrig/1VOxzPJImX0sJcpQ5FS0ji4kPxkO6dTmyOmy5k/41H+gh?=
 =?us-ascii?Q?PdHNbitOiflWmfOpt2dkEhJp4fdhS1jJleKFFib5FoH0Gj46EJDPVa+K4sGQ?=
 =?us-ascii?Q?oBWhPk3cTu3xfIfSxhj2dquMF+EJ3zBxOkB/XTRMoVAD598Qzt1FROEFpoU4?=
 =?us-ascii?Q?YN6WNHk66qQdes0DjibSvelYQ5ez2jShQqCJ43vyaznbGbpfUfTkVfLJsGBd?=
 =?us-ascii?Q?04H7hX7RhZZ7aqFKUC5T39Rm5qGZ0mtmIoeKRq1PGgD1NWnqmPMXhYK+J1w6?=
 =?us-ascii?Q?T9KwMFDizCvhxinwv+Ako3bi9kP4ZVZLlYsvgdQ5Ebvcer/I20jtm0IeXBQ3?=
 =?us-ascii?Q?3taRJbaTVD7s+fbbtzLIiB78/mETXt5Y+CQG/CDTdNjr80rNsIHMIRMPGilv?=
 =?us-ascii?Q?xyO/65fHJRP6CDQE7ynlRt76iwmcv/5QfsWXPOPlwWRlEBK0J+8rGgO/2n1+?=
 =?us-ascii?Q?5oc9GXOGj7NMNoNstGbu9ACWJ+udGeVDicxHeVOLMKYOUpLz2eaejPn7cKkS?=
 =?us-ascii?Q?B3ixHgvJyIrZ86/SebZUqCRM3WKohGEWEowBNEzDuZkGp1vgavAm9rvdd/Jh?=
 =?us-ascii?Q?v94/W0V76AxgfB8cX+HyOPd+VBddPxXSdyiwWfLpvybbNFQV5JBLGTQqrYYo?=
 =?us-ascii?Q?qsk2fJ4mw5zK7P8IwFfEc37yjIIK8AUDM+m7QTTSba0Q7pKk2lTfRLL62StX?=
 =?us-ascii?Q?Qfwt7RG+iN6II8SDGVRr5GFSIdIT5nMQr4iOcMHkLV1d0R6hB6SIX6tRUvAp?=
 =?us-ascii?Q?LHgS8wYjOs3ps2g+fU09SwUeaISxGGZMNt4HoarczpTfNKgaeI4i99fDmLL4?=
 =?us-ascii?Q?y3QI6owLQ0DE5lS7NyoKNNoq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2472d-9b49-43b5-9f8e-08d8e7a49b3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:24.0709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8fE+XwnAVS72vHIuA58vM76iKAouY3nmcpMgXmIwq15mm/hsyU0NwToIDr6ifNzEEpD7pzSPou5oxDegaJd6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why] It helps debugging display setup issues

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2506e85a19b6..7347a3dd66fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6656,13 +6656,17 @@ static int dm_plane_helper_check_state(struct drm_plane_state *state,
 			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
 				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
 
-			/* If completely outside of screen, viewport_width and/or viewport_height will be negative,
-			 * which is still OK to satisfy the condition below, thereby also covering these cases
-			 * (when plane is completely outside of screen).
-			 * x2 for width is because of pipe-split.
-			 */
-			if (viewport_width < MIN_VIEWPORT_SIZE*2 || viewport_height < MIN_VIEWPORT_SIZE)
+			if (viewport_width < 0 || viewport_height < 0) {
+				DRM_DEBUG_ATOMIC("Plane completely outside of screen\n");
+				return -EINVAL;
+			} else if (viewport_width < MIN_VIEWPORT_SIZE*2) { /* x2 for width is because of pipe-split. */
+				DRM_DEBUG_ATOMIC("Viewport width %d smaller than %d\n", viewport_width, MIN_VIEWPORT_SIZE*2);
+				return -EINVAL;
+			} else if (viewport_height < MIN_VIEWPORT_SIZE) {
+				DRM_DEBUG_ATOMIC("Viewport height %d smaller than %d\n", viewport_height, MIN_VIEWPORT_SIZE);
 				return -EINVAL;
+			}
+
 		}
 
 		/* Get min/max allowed scaling factors from plane caps. */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
