Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32EC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45C564E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C564E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D08E899E7;
	Mon, 15 Mar 2021 11:22:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA7E8997A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc0M5UX6U/HFWcjocKeEEBN75lJPaf3kFPcvp5crDtzE3AarLml4NWEotW6IxspA8G1RsJJvaSWzyg59n31947LjBCSr02+j4r6M14KzrzMhhrFW4kbFf1GMIN5os0H66UJKFux8aCVITX+z3e2+l/3mUqJMrZfrJPPGfttIqdHixA2FJfwJF9vvncv4HpBsygQ28rg1/ecq1yteB75wDyltEmdp/3pq/VxJ0IuxyMGBNGgSaKPstSvwqDtJNOYkjMXylgNReySdkmM+jUyk565B5LGRv00xxW46YintaQGuZqWoOOcL1LmvC9zDTkiHPY9wR8UYMrG4R7/01foIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UH+e7VmRrHgN/7/PWzUBC9FgOCVdjBME+jENsvaxlc=;
 b=QBDpwKUTT3DbsVubRfBVaGkSMLqFLMIeZvqe6302Lsnf7i+oaFMoxVGndyep821+8OCvK/bMTO/qClrw7O4e6gUXkNLaSd+Tu5pWs/nyEgaDpFtMs5BWU4JgATgCIzZygD2mTAbeOKIsJXNm8s5JyoFCqRyc/ZAmofQ47mf7JGUNsBcZOa3yzgs5IvaaZdkvQ+/P2XpVEpx2bY2GOo9lSZABOfv66cUJ9n8WQaljdtLG8sw/LTor8c1iciwK28nUKoOJ2Nw3HFE5HmmTZIaBddeijbr6dSLvybSm0YWzf8D7eGgrUkjwWM6RPxCnRyqeoGW2WcnKdjjPNmJ+yADLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UH+e7VmRrHgN/7/PWzUBC9FgOCVdjBME+jENsvaxlc=;
 b=LGNcyNIZ/Vowyb/W0WXIc7yoG3SYJn7UMvNo9PmoikbWa3X0CM1JEw6KtVFk8yzNpux5Pj0Xjv6oPGjw5+/DMQvaKHTgzSMywzKz61JysnziSxRuD+abXtd4XqZuzPTgwhQNJRvBUBYXLYAfK+yPLOTLMWakI4npXNF/VQ8EM10=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:36 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:36 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/23] drm/amd/display: Fix UBSAN warning for not a valid
 value for type '_Bool'
Date: Mon, 15 Mar 2021 09:39:52 +0800
Message-Id: <20210315014010.16238-6-solomon.chiu@amd.com>
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
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 349b88a8-2722-43e9-a66d-08d8e7a4a2c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB461740004C6A33C4EC55D49C976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TlIs8tM1bFWsx0NiWRXBctMwXGt0vlVxW5RQvQ7hJw1b8HzllPwhb6SdoUGVGZOBCs8uggBdLlBBYe8vNQn+EjEjYj/bJ0kz6qivU85aRaZ7o898q0pbvT0sfRpyWEIbYv3ZH9eT8j/b9CmHJqFV5vlUGIySeoUJvMV8nTunI22SJQRfBedUkF783NyURIFAsOdgNELhd9Tb3VYRi3gZrOcpsVMzDKInC+Ok+8YOSh9qaGIlPt/DKB9o0mEp20feimFfJJf1h1A2+Js+TJ4XpfUUWuk+U6wQ2S73cFIlSEZnI6vbJkshvnfflaRUKIpuC7Ntc8oHFyTJM82POqFhMkd+LLYnSFzqr/Fw/f3vFW6ObDyOiznR/djvE498UuJH0YPqAtK+Cr0xqasC0CymCDGzQOJhQ9FkqIfk7bSHkqqQnLUi6yfBJAxTzCUY+9sVg4mqUMH/AtSokrzzkxLRvqWCZAZNrA485qf0JvIK8/E164w9VWR3ZFzwiOJy4X+BldbDNhV2S8EUVyhbqtm9XpbfeV1pIQchYnbFE8RYk+AflBFiVkOaH9FR6EBkEkx4p6W/GDggDW5SbBJHJdzmkVld4DE6PgqnIK1lrpFyH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(966005)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kC9kOIc3X2YmWvocOKRvNP4sLRZsmr9Drz/AvwwgA5XfprGsI7W/xgZtUfHm?=
 =?us-ascii?Q?HgDinx68b/r6X4Owt3dAvn/Pq3IxaS2M9Nl/pnZ1BRO/lwPb9nGhUKo5xnib?=
 =?us-ascii?Q?8GtzPvMUNChgJKIkGRYMGcplF/LfDynEdg2GGZBltsSowiwp09cKkM+NWtqT?=
 =?us-ascii?Q?C1AiFm1UJxM/EarxTfV96I/ZBxdEsSCQwOxre37/tzmqMDZJ0tR5gol+8xg/?=
 =?us-ascii?Q?EKfS8tQPnBYBoFCa1H+uhgYGuJOUVm/bNW9gzhfc+7M9d4XOVIksxLDuzkXB?=
 =?us-ascii?Q?n+oDXvj+pMvkrxsViDbPCInlpK9OJmvspTpw+euM6wPjz96eLrH+0L6v8/uL?=
 =?us-ascii?Q?R6ovuOOLCbrFSXpb0xsEW30wDVvqcwRVdZr9cFWQ5U0xgPFdzxsN7/8cJFa8?=
 =?us-ascii?Q?VuRQwycorCXTLeAiwKDqTs477idprs8GPxHpeq8/8mclFnyDHLf7eVfPB5+9?=
 =?us-ascii?Q?TczIxlfazCCbcOIcKYIpSC4tSEvmVJv4em2pOIX1Lt8v8gFnc6mfWB7JM3Ed?=
 =?us-ascii?Q?aRZVfqn3GUWkGhLCuqhFgigCoY3lsLtfUAiOc9LXqdwAH8av/vAaZLN96dOy?=
 =?us-ascii?Q?SiYCHPQPw5QTeuUVGbUVgjPk7KkQW5NIi2MMvAO4v0IfVKQk/6Gc/ahr6Lm6?=
 =?us-ascii?Q?d+T874WgE75w4VcNrQ8xId2gqRj08WjhNbXll2n/V0jN99aCcHDgTeUy3Ki3?=
 =?us-ascii?Q?TTafPhS1muAQKI2sJnKMkfKRHSWkhkS2EHy3WU0AnSgLUgQMeKzeiU4AGr86?=
 =?us-ascii?Q?luDAKg4XjI4Mjyw2ov82uiS9E5e65e9Skh3mTV9x1bhXgDWM6TA1USrroU+u?=
 =?us-ascii?Q?+UblRdpAJaX6x7D3dRPnjmdFNMqYTKa5A1LkHZiWwbMzWWIYsq0Bcv1+PDKE?=
 =?us-ascii?Q?YfCh5/R7gJK8Xp3m4P5gIvJluedjw1PEhQoi6WIDbLU8ljpVsFKlqjMjXSO/?=
 =?us-ascii?Q?lnb4ssiDt5kJKWZLitEhLrgxiVi62C8bMROApo/i5PaR+Yat2V5Ghh2QO2sf?=
 =?us-ascii?Q?vc/2CUdU9Wb7sRDySRqdGjwGHRtz3qNZzVBTNa/63+6MDV5tgVs8HMK8XGJd?=
 =?us-ascii?Q?JboMBdzf6kMCl95fQ6wf4W/wVG8mo4jGmg0n9ZmkcF6fA0cmUq50853PN9IN?=
 =?us-ascii?Q?nI6ZbWJ84B2hQZXSc7cQB0CyBfkMmvfBIOHunhDYMGcJP5OFVHfH7XCJQM5M?=
 =?us-ascii?Q?DT3CQCIBS8/Bq6yTfpWHBWiDULXLdFDlgcBnRz7jhGc9usXCMjfmnfxN6CPy?=
 =?us-ascii?Q?ICf34ihCsDXTY4yxItk5z0XfGaJw1So0wk7dElD+wH4KSYlET+Og/TQ5VKde?=
 =?us-ascii?Q?h9kU/fWuw2hjTFNNfwEKqf1ltL+JqcP2FQML7R8TgGIhgA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b88a8-2722-43e9-a66d-08d8e7a4a2c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:36.6596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laEFquZmO72h2HTjhPWya74lD0QykkRiwGGDdRpZCN57btWZHjYgOY1Kn5OGyfCZpvz8jgnNaKRxxu3dJo+V4w==
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anson Jacob <Anson.Jacob@amd.com>

[Why]
dc_cursor_position do not initialise position.translate_by_source when
crtc or plane->state->fb is NULL. UBSAN caught this error in
dce110_set_cursor_position, as the value was garbage.

[How]
Initialise dc_cursor_position structure elements to 0 in handle_cursor_update
before calling get_cursor_position.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1471
Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7347a3dd66fc..df060c354eb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7612,10 +7612,6 @@ static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 	int x, y;
 	int xorigin = 0, yorigin = 0;
 
-	position->enable = false;
-	position->x = 0;
-	position->y = 0;
-
 	if (!crtc || !plane->state->fb)
 		return 0;
 
@@ -7662,7 +7658,7 @@ static void handle_cursor_update(struct drm_plane *plane,
 	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint64_t address = afb ? afb->address : 0;
-	struct dc_cursor_position position;
+	struct dc_cursor_position position = {0};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
