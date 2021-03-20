Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6BAC433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2076196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2076196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6196EB1A;
	Sat, 20 Mar 2021 04:18:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4836EB1A
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIrBuuErYkpl1L49cmA6h3a22uLSjH3saxvfgZkC6yqn+WnZvPJqAKnxyAA5Kz7SrlK2rLnR1rk4x6J9jH0QQnJgUeuOHL86hYZOfle3Yt7BNPpoa11aYhj2EmcAyHoz9IY1YR2qyZEX57hP4AXFETHUC6zee6ZAUnDMHHixip9QCx5hWkaEQ77X2VeRflNaOS0LhNWyEnsQ2GBme5+aMsXmSYYgVmWBLnn9kcjBsOzFniMsGXP+xcFRwfXbdLliDgt0QBPYdzKwY29l1I0qZ5QSno9yvRx5qZaCVbHEPWZmgflH4SY+ITE/EcDDd9C6Yt9eYsU7RccVRwDNSQX2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvKQfW6XYzajn7CPw3L7W0lCKZBCat1NWoxvgAeAAZE=;
 b=OSUl2yEZMoeLq3wHzh94iP86YLhV0VieVR9Ju4uadxLcIvWX0ZxPVdiY54qsTB0hu8Wx7O2IAeLZbB5efh98jqkTuYaeNxKlFrt3jbRUJnYXk/oj91KOjNmp8T5oQJEdHY5syzK/FWjedfn+PaXcx0vrBsYdSGPlH6sKmiNn8IeDYpK5dW1PVCH2BEJXhfYIGHt0CWKSu1NOvYMCjaljsOd3Jeh/nTWeYg0IbxUl5AyLcVB++u/XV4LpcfqatYJs+QbzKVALD1VpCHtJgLkQ9iPFcjXw2dC+GxgH4Vq20vFxqUXRNwMmLe51mdMpwKyOsj4hRnMocXk27XA1fT3vMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvKQfW6XYzajn7CPw3L7W0lCKZBCat1NWoxvgAeAAZE=;
 b=mM5pResVtka0zgh2B+qdng/XiWztroT2YpTSN/dVzhEcpd459+s2b/IG8c/TUcGzqcgmimuU18uqQNcc0sxd4HzhAhXJbrhOQ7xPIW+gntI448+rrq6NyMPAPTGa/Z1qAy8ShsrFKkzL8q7UZsYcmsmHQAspYaStcQIvDQlMjPU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:18:54 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:18:54 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/14] drm/amd/display: Add kernel doc to crc_rd_wrk field
Date: Sat, 20 Mar 2021 09:46:45 +0800
Message-Id: <20210320014656.23350-4-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e6d7f13-6f2f-4938-8516-08d8eb5744ef
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704768716760C70F49E2DA797679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFru4gO1kcaml5kOCba24dWAMhxgS00XeiXdOjSGFfILmCcd2tsj0YitO18nE8x10Cc/qjZ8425/ZWPEOgt1MULH1a523H4kXoyAHwCWOYWZCIuXdQ1xp3QGqCPpVxo/U3octBnQjFjQuJhW3pkb1ypZuW8fKlM2AM6/wxMK06uxhnOo6gvzRp4CGTE04PvOXlMwJ+UEHzVz83ty17D/RubQVu5XIDCroz31P8nPKesmgyhmj6LWkPukg0++X3O3XjJlbRn0r3OWG/smtwWuVRLQlaXprm13izVwS5OResc4zCh6ACQKbVqIB+qZX6brpiXChcbrPPKZrNuP2plo3X2a0TIgS5WKtrDz3os/Uvsnxt3Mn0uVHz1D7o9K/PgFoh9Ys/TwPlioRM0wQeBZA7bJTlPCSdyD3Z++OVRlJuJTSQV4haLCMDm3eNO7sYcJaBrTGsQXOjyYld74s2CWAdCYEYq3kj0jdO/CNxUdDugndbEWqn/OCAJKhvtB4TO/7E1gwUU95UY4Kn/GNMkA5z6EpFkyAHtNb6k4eqfX4/eHYJTjnmNAEpGHzvU3Qanjr+B/WFv2L3hsDy5BWCs6opWYhFkOoVWqHIQYllGT2HpWg+7RWjgZ2KneaYrsLWp6lIJCLKlP33ERA2IsizAJbGuPkJ/LAaSioTNKA14Qu+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tjc1At/a0ukKzkBpkkZ7f5PLBZbWh6udDALB+Yb9f84LFKA6hY1pXrKt0QfW?=
 =?us-ascii?Q?CS1n82VDsoDiksX4QULrXYuBTM/J51jLoVeZsSwaUANmKUCjiaIDgv+fRyxC?=
 =?us-ascii?Q?6KpJ/SEZ11hJ8OOVnRQYofhZUp+1h4PWE4pF0khpgdXQ0PU5ByCHceHDwE8+?=
 =?us-ascii?Q?Q2DifjHMHorg2ghrRK9uxOUUgrfCWnIfcfq4t9vvEeODvk1GuIoJXOQjcdCR?=
 =?us-ascii?Q?dPRISbEp/Q4qM3Wsrtr3E2/iZrBG3UpC8Hoo5QugyalviGbiwaMHyhL944rw?=
 =?us-ascii?Q?qttsXmWuA5I93dt8LayYO4hxxkzuHi00gxmjQQUY7VifI2i5nhprIOyk5rwC?=
 =?us-ascii?Q?lym+SyPFArwK0fMYaG1DU6K9g4SK0iUkXcodTu74HKeJY+ht0HYGIn1qrSjI?=
 =?us-ascii?Q?sZmmFJnOgVhXO53cXb7CrRGLfmcAnuEmlhaO37GSUzfVTE1as3ymLJZ2iFPD?=
 =?us-ascii?Q?wbPQgayz0SM4sLVPrQkxkXOJeVQJuSBz6FeYY8jEJVGnlFlzjOmVs3R0ud5O?=
 =?us-ascii?Q?5EA/ubkU5d6WNjGBgf439+JDriZ5cclUg75UeBPlbDDXu2KE/bwQY/dwr7np?=
 =?us-ascii?Q?Wts8iD0PngHLGdd4T5VrTE9OSRh98YalcE6FiWiQVt4T2vQ1WUwQc8kTYudg?=
 =?us-ascii?Q?+PM3c1wVVwDFN8KvntMOM3nCaEtV6jmdpq+qJaKksglPKRTavRLf03h/6BN0?=
 =?us-ascii?Q?6df5snuc2pVRcF3E9qkEZDr2qVaIbqzVtJv9btMXH26+72gCPRIRR5RD02Qf?=
 =?us-ascii?Q?G2hq7sKbNcRUq/vOYU/hfSyN2dHNeipGRnGS1Xc85gfqcl9gUg9AvB08FFPI?=
 =?us-ascii?Q?oUHxXb5V5AzqAnXe+bHiRprA8fCW0oaDoG+CycjCQNmvJYBiLbi1yRx0g2vo?=
 =?us-ascii?Q?XxBxkDeKI+4pqeDZZsabMiz8NT5KKaVopokeerk4KKL95af72cldanb8DCbK?=
 =?us-ascii?Q?XNMjFcrnNOhU5PqG9H6dCK7IMHFH2o6V82Q3cIVdrmJq2kYrUs/GZcDQq+fO?=
 =?us-ascii?Q?OGOnbfkNjpBbh+4nIrYmWmmn8E9DGe0VXoCU63z2WNql6yoHuL9lJL/Aa573?=
 =?us-ascii?Q?IEuZf76qi0fzTensHYWnXb7bwvT92rtlfvmTunk5cgoRjsm5xJjflMqKBVRw?=
 =?us-ascii?Q?za7kEuBKgxm0yZp7HpUaBTPGRcV0MuaBhGD9HwafMYZqyfg/U/z8D/SpVxzA?=
 =?us-ascii?Q?rp6C8FzNltP+YhCxmrLfHXlyD5WHOw7TyXjtnwuMKKl8pzC+05IQANkpsaBy?=
 =?us-ascii?Q?XnaG6Xkhmogh7jfXIURkyfQIuQbcLiHPWgPYgSa5cFB8rWZN95DGkJ94+qHU?=
 =?us-ascii?Q?u1FavWrsgts0RF2O1zf32B64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d7f13-6f2f-4938-8516-08d8eb5744ef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:18:52.8562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vKitPvbYruNnN7CelU+4OaWYT9fg/WmF4ABENd3S4Wov2+owsv1LSDZjEPc43zS1MiQ5tlK0OnyIxksFa4DSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Receive warning message below:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:380: warning: Function
parameter or member 'crc_rd_wrk' not described in 'amdgpu_display_manager'

[How]
Add documentation for crc_rd_wrk.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2c9eed78f6df..f7f0680c1fa1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -385,6 +385,11 @@ struct amdgpu_display_manager {
 #endif
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	/**
+	 * @crc_rd_wrk
+	 *
+	 * Work to be executed in a separate thread to communicate with PSP.
+	 */
 	struct crc_rd_work *crc_rd_wrk;
 #endif
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
