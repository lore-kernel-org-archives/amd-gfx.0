Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DFC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E1064ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E1064ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4AF6E44B;
	Fri, 26 Feb 2021 22:37:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E537A6E44D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgMi0u9MxGOXlHlZQ5Wnorsc+OGu+Mve9mpqWEQk7JWLXYRoaQD3Ich60lpUm+aLS0iWNXe4iv0Zl8dMVkoEhKNsgRGOz+1THLvMmEZbStnNg7QsJ5hHBV8uXKdJaCrVDHi7fGIblTZlWjGOS9w3NMWiaeT6hFt6XK1QW0x/SoafI1EavaEiQNfZ0YqZGyMgrJGgPePyFfiHvjZJrunNYdhOAxeNn3wK/anWMYP560wCSwYwmuVbLdg/U/yW0ZrSnTmEaLIRSTn1amXpE9XX8Ayrf5k1j1V409JQPRPa9ISnDYr11E3QnVNBDwwp3bcmr9Jcihljqfptpnv+2W9sZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzhqBMu0fgI2dDyUwYhOpSeAnvbYlY5APvnCdD/mN+4=;
 b=T0TwhzcTvSgCcrzqEaSaYKVpLSm7TJ1tGv78EkGV8bzeO3/iEaar66izcWKSqTSOpDdXy4KBQA3NGTEA4mwEdtQDx4fxRuYVOx4y/wYaUmcJ2Mv5XoOcHE78APwXmeGxPs3gk9YC3+mEtMwWhEnVNg36SvramF7OcxhAaAOVCZzKnqjUFkgU7vNk4/gNKUP+AzVmIPZ8so+1DDQzSdb1u9crPkpX6oNzJo47ws/2A+91ASQDSDUhnStnyjt3spEF2kosobn0bACJo8fxCFm76CbjAGAAyzWwP1yrpVqYaq8W+xazDBDaGbWx12PFLz6GpwDx782geP4pVvraioAeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzhqBMu0fgI2dDyUwYhOpSeAnvbYlY5APvnCdD/mN+4=;
 b=sx7TFD4Ml4MIdwwMx3X7O8OHZNapXKLmpQZO1Mae+443Gs4QtRm+kRefdNKKmhTk7MkGe+r3/aG42M9vfWnm2b8S4r/uj9jv/B7vjbvU4zAsLiV0iR8/zlG+65wpBDLTs0i9zRmJ6bFFCfluUkD3AYb1IlMTzifKIQH0yvjmRYk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:47 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/amd/display: Return invalid state if GPINT times out
Date: Fri, 26 Feb 2021 17:36:59 -0500
Message-Id: <20210226223704.400472-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63dd4377-16c8-4231-e55b-08d8daa72418
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883924C6DB21F09BAF341DF989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/hPeiOXJCivsFvJ8c0Gu9MJy3qDeSipbksgZ39gbvOxipA+NJrHkSAK4hX530gPp6Ves+P6aWYoHgAZ5zWZ9FOS2EqI3ugi6lxiRape489jxu+RloT0ClyLL0nRVXPcupHepcGkuEZeeOdH0jS2Avs3haLxSLHzespfh8GVVThBTrDl8NV2fTk5V3qmbQ3UxI+4HjQNVeLkh225dFODCjb4Rnbff4PkfXN60MPSLH7P/XtBfzBnGYXtzDwbkaFh+NTd4PzSAIk64kjaS0QCbC1+grSPYWPzVlW3VBHGhKnQDv11iW9Sj375dabkJUJDmjVbbu/SGiZLK1kBqojdgwnsN9pH/BAYIWv9kd5+QISd/I8rPOQuyqCtXe2aGobI3O6VGvl88WF7d+KUhDAk7gVigpoI5JF9a6ztNbK720AKPDDbVuu2LGLc0lUPh9wxsEwufwDe+MIKHoPG6/BbUNb0Ud8hI4crBo/+et2bBIV9aRb1YuvN67g3HidB0TerfnbUZdytNO9ImkTTjrVnOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2Yt8Y8G6bHeDE0iIYM73iTbV+X0p8JtLmsB4+a3BO/LlMGJ/Yfzw7U0pytG2?=
 =?us-ascii?Q?dgCgVcT/o6oNumZ2ATWL0kaMD5XPuoC6BvlgjkWLX4NG5+xKNdHrOD+zL9LN?=
 =?us-ascii?Q?BIu+YY37X7gVTSnrcvisZFO6w5oc09Kv2ZtXbARnbz2F+W4pAlFKHABGmSdb?=
 =?us-ascii?Q?8Zr3bFN+jOj2eOWEJSkMf7+/Bq/LSetUK64fkCsJmeGG7XuSF+xktQtzqP3m?=
 =?us-ascii?Q?1Af/RJ11VU+Pwn0ywQkSU8RdiPYzypxRH4VydyRuyo4n9V5fAf0j4sMFRiHW?=
 =?us-ascii?Q?s5z44BZxVNLdUVHo2qtyP01xcrtVRb0BXpYb4FRjdX955jVmzsPq2u+JSMM3?=
 =?us-ascii?Q?wem81ydh4i1YrL/NVmPFSrOOwKH5fqEvzacWo4Qn8ftsc6oqFk+tWh7gRCUe?=
 =?us-ascii?Q?ZL1XssE4ykqoWMJCpTH60ExyCX3MA7r2N/eOzvekXw3+jsFHIrj7WB3WG8TZ?=
 =?us-ascii?Q?Unsjx8bypNYSyjx+OQtuFfSulB4VRB81059Y/C1//GMGEvwPye8Fst7wA8uT?=
 =?us-ascii?Q?OBRPwO/Lx8oyh3dw3J6I4zvlj5ei6l52CQTCCP+2jW3GZTW2DuZ2nZABXSmY?=
 =?us-ascii?Q?AEJ3Smfaihuw9V6o8/wIRSJvMmnvRLqgx7zgiBiR1zd5LMOwfLthP/urvYty?=
 =?us-ascii?Q?hBFhBwW8llIGcA3dJN0Q+wzsuD6v76gQvFJez5s9vtrZURcmYmo/YFljs42i?=
 =?us-ascii?Q?6uUkeObSOMMJ58zE7WGnW5N5NmzM2yj+dE3Skz8qFqrE6CfhNSsS9+jcqikt?=
 =?us-ascii?Q?94o9ca69OdWg2fPR1ZOvNhTmrsc05KCL2nw0TUtSXWbQFK6vOzSXfVPep3W6?=
 =?us-ascii?Q?iyF/Ldb9Np3omfkBYmu+sgAwEcaLF/tqFIQwkQdzwT45ZPFjllouwAKjA87s?=
 =?us-ascii?Q?doozCLPLUTgRTm5dwvmHnliwXw/wbWnIwe1iRYSE7elIc8eAKL5XBIhZtzxl?=
 =?us-ascii?Q?0Lat0uP1L7hUsVDm8YPIN+ti5GE9OKzwG7mqlYnU9mRjiCiOwuRoDdD9tIS3?=
 =?us-ascii?Q?3mTyRRxslMzNV7UTp+7QSiwxQZAgdqT1UeOSu0gA9xeM5cnLPbivknaYGoCD?=
 =?us-ascii?Q?cXvbd1E6QdKLXXsbIIs6rLCTAq9c9L0Xgv5Ao7j/kCtgjH0nv/w274Pygvhb?=
 =?us-ascii?Q?+0PbOZy0QaR7mst8Eahct9eM5whG7eO3lClZMcxYUruMVr34a83PoU1fE5ly?=
 =?us-ascii?Q?r8S8t1AW5pX9fAfY54/KRXC8qWIuY0MNqa+nYD/9si0b2+mTAdtY4hFVSR5s?=
 =?us-ascii?Q?sk2EArM0dUVomN2Cb0WGNXzj8Qet2/XVAmt2WUvelC1VENJZR4EG/+pFLybd?=
 =?us-ascii?Q?3OfNxyR1l+srU55bP/5oMToVfn/jnagJax5sXPLY1tmP/MXKsS4puE8NZCBO?=
 =?us-ascii?Q?0TXBnY7gPIYa2yFaSxPF+MiwvPVk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dd4377-16c8-4231-e55b-08d8daa72418
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:47.5358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT/q84Bud3E0/VqYKxGMQsTnfu84HUN+bRdhkAwuigb7IDuD2dr8b8k+I/a11eVNSk58+DrnTR5DCeEZgpsOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
GPINT timeout is causing PSR_STATE_0 to be returned when it shouldn't.
We must guarantee that PSR is fully disabled before doing hw programming
on driver-side.

[How]
Return invalid state if GPINT command times out. Let existing retry
logic send the GPINT until successful.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 62c019fd326e..03741e170b61 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -81,13 +81,18 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 {
 	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint32_t raw_state;
+	enum dmub_status status = DMUB_STATUS_INVALID;
 
 	// Send gpint command and wait for ack
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
-
-	dmub_srv_get_gpint_response(srv, &raw_state);
-
-	*state = convert_psr_state(raw_state);
+	status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
+
+	if (status == DMUB_STATUS_OK) {
+		// GPINT was executed, get response
+		dmub_srv_get_gpint_response(srv, &raw_state);
+		*state = convert_psr_state(raw_state);
+	} else
+		// Return invalid state when GPINT times out
+		*state = 0xFF;
 }
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
