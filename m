Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99202C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 04:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDB464E77
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 04:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDB464E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DEB6EA8F;
	Fri, 19 Feb 2021 04:26:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426726EA8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 04:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCH2Lnjbs1CjJpDnv8m70N+VTLl2iwGevGbHHSgZYU5ZyDYQvk4vLqKpJEBJQDUCO4IqLtWBvEhibFJaWxc8KpTIe6W07v6WlI02dsf6MYpvaH0vj+5Ju1loR/FEUgNTCIFuox2YKevRc69yNK8ofHCnXj3Tq2XBzyQ0N+oGh6EvuWGX0sHRC35Kba+Y6BUOW28evKB36C2o8Z4qWxVAZinLrKkT7bwyU3rnLHDthUwhgfe9i2e+fUUBRA7w6uZt1qn6Jmun10MffnOad22PqcIr6LAqIV9K2k1KpX2K7iCTkol5dzE7+geWLjUqIvhv6cbJlkBZZh/Y1gUb4RDltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLW4MSMOrSeNfqsi4fdlc/YdSBkEqqL/Y7nhkVVuoD0=;
 b=W8/CRJFvgkKSqN8iBAqbRtlL76oMK9og3q110nwY9KdgvoMG7TP3TDaI6r1DgOLm8kMCLwxo/HHJo9TX5f05otIH6EE0GYz8TpZi9K5ecloJGuxjEy+2ivBdqqrY5EeqA43Fh4FcwkMc5/5MbXt7RSjp+jism2exuhlViZnCcvusYE29dwnchSwammrXFlU+e8SDNUWZSiqlA05p7juvjPf0/Vx2BaNIJ2tiJOqYkLHlC7wa7yoy0ifCg9J19hvHGXrKMILJTwD38HPrTElXe6EANEOLtzCyQyrpALpF9/1Yelu0BnIgkrtx8YS4MCrskjuTffUvqyrmTf0I9GPIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLW4MSMOrSeNfqsi4fdlc/YdSBkEqqL/Y7nhkVVuoD0=;
 b=ZHrnQ2PZEcTWyvf+uwTYeaNQxNr+ebE8hgVryGkLiVCRhvB6O7g7w/7ugLtumtjwL1mlAsU5cFbNbZehgWWH/h2TD5+1+CFin68x110F+/YuAOVhEnaNUi4oamKjUxn3qc9xr2iV78yo/tHchBtTyPwbySS7COrdjLe4VhiCYMw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM5PR1201MB0252.namprd12.prod.outlook.com (2603:10b6:4:5b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 04:26:29 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::f555:6b20:3e9a:64f7]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::f555:6b20:3e9a:64f7%5]) with mapi id 15.20.3868.027; Fri, 19 Feb 2021
 04:26:29 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/ttm: Fix a memory leak
Date: Fri, 19 Feb 2021 12:25:47 +0800
Message-Id: <20210219042547.44855-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.2 via Frontend Transport; Fri, 19 Feb 2021 04:26:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36ed6c00-3182-44ec-f125-08d8d48e86ec
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0252B07952C7945AF6E78A5787849@DM5PR1201MB0252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iNio7zUvJbf3b0u1vtLh46UqOTz8iI8WvPLHYzIflvgObP8uhl1PYA6PC1DQ8cqX6shLxzoodOrC8WYqeGFOTSphEMIyNpfxsWEhUXPuOCNymW/Z8hHmpP0yrC4VJGUR9ml1VJkZMZG/Y+5ic0JTSiliey9lL0UgExiyv6QMKXXkkj6MwXg7jJBmjSVvn+rlj3UyZPgShGzDm7aNf/PXWDR8XESxsUBITU/l2Dnp8a6BMrCow8sW9R0NadVUDpK2166/fiQRMqn1vmqYz1tz/MJtY42vKP18kf7zFmi56znXEh5D6+RBGZAn4ZBnIZ5aU6vuQ2n5BGK4UdZiTlYGHZ5anJSRs3FgUpvh7yQPvh06441LpOVNyutRgkSjYmObfinBYEOtfWMFkSm0EKMS+9vL2eQR7tKmhlBRLjn+oiwqp8re3F4I4XVl3BfekJo/LAqaddPFwONlLFtA/QWnR0+OBsQZKp4YVWwieg6999o9TdqieJuxgBiFGQdtzmTjZCFuHfazJGfMxHj19BBxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(2906002)(83380400001)(478600001)(2616005)(36756003)(316002)(16526019)(956004)(8676002)(6486002)(26005)(66556008)(66946007)(6666004)(52116002)(86362001)(66476007)(8936002)(5660300002)(6916009)(4326008)(7696005)(186003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dcb2PnsZCB0Y1hvOqhtaeNDDlStwUH7Ld9Ep6CsxEaZ8tBXO8NgNpVvKpS23?=
 =?us-ascii?Q?jd37j3LOoJg4vmTz7STWiMJFkbVTgomtBr442PUKVYV+qpF741MtvK4u5qCY?=
 =?us-ascii?Q?SacQX6TwmId6JCzOe3z7ZgC6RjxkiZoSZD1swCGw7BdbWAui/21Fs6PLUjW7?=
 =?us-ascii?Q?jiIeqOiPjq8iC+YmboBy379X3blnxGQOoJJxrSfQJreN7KRFj25pvXxkmIbE?=
 =?us-ascii?Q?rfWS9vpUseANROOL+g71HyH4NS5+f2++1dxJ5IdP1BfMNdttT0EGtdARMXxR?=
 =?us-ascii?Q?28OCkI/N2vOuSOmuJ9V/yqZ3+zgWqJpLfh42Dsw6Y21g6D7B7Qvil/3uzuTn?=
 =?us-ascii?Q?V6hB15ZW29NrNVof8FsV51zLEeItOCDB1N1a/fuw/nfQZW9iVAFQURy2aXXa?=
 =?us-ascii?Q?nxx35fzRviO0hlXxKNlxTlHX6vzOQFDKprRMuKj8qGEAx1Ydj6VpjIo6Se+f?=
 =?us-ascii?Q?vUZUIqGz129G+410nVOZ5JTjdrdVE4a56NCsBbmH2TaP+Oq121vy2Iw/Uq7H?=
 =?us-ascii?Q?PODE2FEkenxrmSaiMmiablXhllYUgXnGemgCWqBtgJEtNZqJ3BKEcbuyPNmz?=
 =?us-ascii?Q?6gQLC59iyvnzJIOpwHmbEOBYhzhNcefahOsatRmHEEVAYTt40hLkTLRj2ixQ?=
 =?us-ascii?Q?c1Wf/ZOybZ76tkbsr1JnIkDP1zKPz/BVZOjiRkWFmQRzcRIQ+XCdDyapXyOG?=
 =?us-ascii?Q?l6XfKSoGICcQAxZ+eRWVcldiStiYYYhuIiALhjINq4S23rjpjaRQLXHOsK1t?=
 =?us-ascii?Q?WuczjWJObeD4M+hXtRnl07z3+xTNaL0nXh7i7TZKVxJAENSQVrHxewudUhDs?=
 =?us-ascii?Q?CyLW6kbnOWlM+voaxxzTb1INIJU+7q3afKqG76ifJ85WFnYOAD2xr7pU894S?=
 =?us-ascii?Q?WVoRzO2r25e0k5LJlBm632ULRXEdA5fJAk2tcdX54rE0EI7rYctgLmIobXRA?=
 =?us-ascii?Q?eCJhRHpYTZMVGqUUhq+4zolFu39XbwsAjQGICd4T0wrpFOcULHL2SrkzclIY?=
 =?us-ascii?Q?lJdS7Ho3aeLfF1BQVGJaqseuncJH9qsi6MZFgaTNiI0gouodLaIQO4eawM3M?=
 =?us-ascii?Q?/UwEDpFZntqC8n0NLTSZzYtEN9lU2eJaQ7f5MejtU5LIi157v3zY42CpxOqt?=
 =?us-ascii?Q?tVon12Bgd7EEyEpeeEQYu67C49mayyfsiIzEK41QoIRXHiCA+EOyDrwHVLoT?=
 =?us-ascii?Q?VUjihafCjOCxclhQ8C8dAgCAyVwNLfVRlRtyhM0QNcO306s8ovVKf89IGbMp?=
 =?us-ascii?Q?jmyeYIn5j23A8tyHvhLvHMmQymetfJuy4JaDDabHK4d0uu5kspUsIs6xStlx?=
 =?us-ascii?Q?FodjJvRhelNFrzKUjgSJ/8Ay?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ed6c00-3182-44ec-f125-08d8d48e86ec
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 04:26:29.0598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86LYnVjPHkpbgiRY2Mwuu44AF97kgJAv4AzFUYbdhQ9KS3UhugpwljGJNkFnj3S6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0252
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Free the memory on failure.
Also no need to re-alloc memory on retry.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index e38102282fd5..a97d41f4ce3c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -906,8 +906,10 @@ static int ttm_bo_bounce_temp_buffer(struct ttm_buffer_object *bo,
 		return ret;
 	/* move to the bounce domain */
 	ret = ttm_bo_handle_move_mem(bo, &hop_mem, false, ctx, NULL);
-	if (ret)
+	if (ret) {
+		ttm_resource_free(bo, &hop_mem);
 		return ret;
+	}
 	return 0;
 }
 
@@ -938,18 +940,19 @@ static int ttm_bo_move_buffer(struct ttm_buffer_object *bo,
 	 * stop and the driver will be called to make
 	 * the second hop.
 	 */
-bounce:
 	ret = ttm_bo_mem_space(bo, placement, &mem, ctx);
 	if (ret)
 		return ret;
+bounce:
 	ret = ttm_bo_handle_move_mem(bo, &mem, false, ctx, &hop);
 	if (ret == -EMULTIHOP) {
 		ret = ttm_bo_bounce_temp_buffer(bo, &mem, ctx, &hop);
 		if (ret)
-			return ret;
+			goto out;
 		/* try and move to final place now. */
 		goto bounce;
 	}
+out:
 	if (ret)
 		ttm_resource_free(bo, &mem);
 	return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
