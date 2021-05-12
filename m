Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A8C43618
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B15761429
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B15761429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35A36EC79;
	Wed, 12 May 2021 17:31:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB946EC6D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrpwjZmLxmG2VtL91wNGTlPG2aLRBKbJZ9e4kYWCJjNnl2BFYEe19l0jXoidDauYXHXBH3yZPMCf1Mmn4MpjhIsxwKKe+GdK+PzCT6hV54OYo1hGemAhEFvEH6I44GoBxjRiiQN7a+YWUmO/7yRA48QQKUvuW0T4vnxn+PFa7yQp9m1/pVaEb3dntA52RbDImUs4Yv65WUIl7Gvi3wT6V12PiepdxgkbnB5nhoR75qxknqa1SUAchG8L0P4YfUfmsdkpUy0DA55AWT6Hm7s6ZCebCLQGqmUi8wROsODbwAxXQpjp3qc6VLX0+jn24g2/zNpBEr+VKX2iAdaLKBusrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI4x7avlJ01NN3bxm8ZQ7zlYXcQaHo1/jhBW0+YW1rc=;
 b=DHuJuCcVWfZTy1mp1s8sVszafyUSFi2ppSt/JLC3rgz/T1mv17hYtdKlKsgty+THQGfxlVl8rGQnxQMIFk35bjIzSozv22wtuAV9RINYfYlo+okbrtvZfDw94Q85YderISF+l6l9/n7A+BFNLbzsQfhGkWyGatwIx5S2V/bHHyA06IQeGDCFjeIoxszbe+tMHXF1lgaFaQtxWnh25Xd+dJkkcZ0pS892dT3OcAhz2R/krMjVqv/ATmZj889ZNN5kf8LAV9IU46r2bt+OUm20q5JcrskgdNdJoTiHWIepG03xnFFXWwr1iwfvRMi1cHSJm4b8RXZsG8M0grpZroXJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI4x7avlJ01NN3bxm8ZQ7zlYXcQaHo1/jhBW0+YW1rc=;
 b=IwiZIRdHQois4y/JUTWP+aP6ybrM6t0+boYyRnoQjjkwcgQ3g+gV6mmjjpdlH9qXk7BFoVuoPezSMIh25Txi+HoIhGLxE9MSPCiPdjxHd+2mcfZXcIR8WbK8KVN6cw8omuVhyggG5Ph0E7GYOKP9wJaOpeLxsL+4mGObLwRnAYk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/49] drm/amdgpu: enable GFX clock gating for beige_goby
Date: Wed, 12 May 2021 13:30:34 -0400
Message-Id: <20210512173053.2347842-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4313fc72-4b29-4906-5c3d-08d9156bc8a8
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340C5AA8937D7E5841C0BAEF7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCz8Qj1vYR2ZnyR0F4veQw+PiUlzTplqWl8ZFwdrofQXhh9cPRu1H5rR+V3ODzxRMDVnah61bCn5EHkNqwpan3tksVe8n9IzBd3tWDtGvuXcuREyJOJqw3zTJTVfNqLg2D6YPFq7QFlwMUPXQzIMIUSguJx07C5a6fvGSyoGfEZcFvAj1XNbyc0U+ELSOSHXnXbMSveEFL32xhsJcOmBQNVZB3xRN+urMNdEaGkF8ZFvnvwxLynLLpVTHQEGftPJdnsWwx89o6jnEaB78R3EFq5ZQJVl7GWDz2OVkxvGMT/EuGJzgcwWEczemR//eQoSDTSnq/1EpoFDSplBQqSrp9tXpHtl2iO6W36fxxRRwlFHPjGkozt9aPE/qhneMgc+Ynw7ux9A0PDAeSRAo9MztF8G0G82V9Ft1BdRLqRrf9OiMvajVIniHwdCX7NJvDbfNR8wKeUarHGmpRUocKV9kUl6AymDXHlpmZpIDy3PlaGSlOBKSozY0cHAG3+xerVlpZOA7r5AYJ2H9zywGdnG+qDKiyDL6TQtDkw4Ywhk/SqE8cyEr8k5mwlMFNMtyVwZqSB6/6vmwZm8ClV427Tq35qEUyUcEugdFYkxx8kT5zybQpdd477mz8LaOJE8cEHtksYDnPqVssW22n7X5kEFEZBWo2ULZBgWxunN1F/xtp0XTWFuCUcpbHcRpJRs6tMv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(4744005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K7KS4rVHCHATv+N9bEiaaB+/DHWI7r1hC/vHnLzsWkLnf8+/X4JR+xN/sbTG?=
 =?us-ascii?Q?wZxx46aUl7xsw8b7Q7a0T1yt6JGszakhbJx/qZxVozE+4AoFIa15fwXqGjfb?=
 =?us-ascii?Q?QlGPqP2sUJelEIBB5HRJfZK6KHskerimuQhb7hTL8PKGdQcw2K3DCLEGUx8u?=
 =?us-ascii?Q?dX7FRzw8poBgml6VDQVhATqkIdmgpBYkbTUdRH6bfummjQDvdLlK/5kJuyn6?=
 =?us-ascii?Q?kmHYdoSTqcBrIN9zT1cB8LiYl/nb0uH1x0YIhG+n+HCLSz8HwRmqvc+54rHl?=
 =?us-ascii?Q?JBoeSqMwVaADRPxkGAa9SbHN7N0NBiE/w6mK1hak1HnfX9TGVN3bnYk2nEI4?=
 =?us-ascii?Q?uX5Ds4rEdW9U2qMD23Yin09aeEaaOCAh20o7a1N1op+HhUAsXIYfMkeVqjoc?=
 =?us-ascii?Q?wfYtNb4UW2k210xoimuLoB3dDWRaFwn8bUy3mN0lkmeyf/rE0lq8TxNlIfL7?=
 =?us-ascii?Q?xZ8Iw3FLbY1KzpWigx+pc+dFeGtnR7eFaRLA1folZZ4FHrtP7fgViVwflIS0?=
 =?us-ascii?Q?/Q6psMx/HtLTc8HGwc3b0CvUtQII3L5a4B7PQuWsCOmPTeZQ7AiqDykoUU+1?=
 =?us-ascii?Q?hvuIn7gmDOsE2gifiyzQru9wg9Z6U8hchKy52st2jK6kZ2exAf8Uer6b8S7A?=
 =?us-ascii?Q?KPTg+w5LxbJBq4WVgjXqEIXviFmjS9iSPZGZasarnOi0dWsu2pFP2ulxAptB?=
 =?us-ascii?Q?yMimDWLEGwXhXjtBSIlILDF6hKKYJHm3zdNe5a8UsCxeNgjOmnQY23yyFhQA?=
 =?us-ascii?Q?T7qajx6ipEi1X2F1Fh3+/h3bD4JOyKOF0vB6BThGlDNg3f7eSqIWYbDzqBPl?=
 =?us-ascii?Q?BEQ/bxRQITENIawV6D98RHpdXRKJuGQr3imqGz8kpcXY2mub8LfTLnaERD56?=
 =?us-ascii?Q?fOe100BoBv4LTDcWER9bcTOpbDYcA2SYuZvhlcQVD13PhTb4H7wZjAwizEAx?=
 =?us-ascii?Q?LRzZSxLROOZw+yUPoFcbjj4a2b5eA6Ja3y0BXZtluOACyuqna1flM2ro4AtZ?=
 =?us-ascii?Q?l4nxxAqAJwUkbGc88lljtr4pJMmpTUa29FIKOg0Cbe3l6JhdufPz93gEKlR2?=
 =?us-ascii?Q?4hiXJ72lHXByzfcTd3lbgSQ/VpvDcqtpsGHWnf0f+vWcAWU87dkvGzRUBiVX?=
 =?us-ascii?Q?tJSKOkPjvli2l9eOim+jSRJbymsE8OhCWqNQ6aHRS/M98ZbP5zalG3+iQ1Yo?=
 =?us-ascii?Q?JU3nkf00jnovQRK57DkdyUc5YGHwn92xZyVFyjP8QqBuCR4eCE5726i2Zz8Y?=
 =?us-ascii?Q?1r7/FMQDgeftnCdswlv+Khp0i6u1eX8aepr4tIy3vj2ubYy9gGJXjTlodPR5?=
 =?us-ascii?Q?9B8AdRpTUTY6f1J/U0zROOts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4313fc72-4b29-4906-5c3d-08d9156bc8a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:32.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWtS1hxFxYKBDbUzU5DpVEm1q+LDW/fUNMp2aVvU0zx9h6rRDEWI9kgQLAsUtjvy/G0Y7Mz9oVAHer9+zBxxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable GFX MGCG, CGCG and 3DCG for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 58c58067c3b2..8327f3d14e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1172,7 +1172,9 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	case CHIP_BEIGE_GOBY:
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x46;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
