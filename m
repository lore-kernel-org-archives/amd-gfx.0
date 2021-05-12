Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3005CC4361A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EB76142E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EB76142E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FA66EC5D;
	Wed, 12 May 2021 17:31:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FD36EC5E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buh1DeRpsEaEVo5DYaKVhNVynpJq0ZVWsUykh0gkaYdhbl/aAsPxh1N8XTNnHr1022f4+Yh6ctgRBVuv1TYCAY8vVJVDuzP0o/s5AxO1WZ5FeddG6wGPlOJUPCR8ZzO0FcheI0GJCrMixuvGj0pZQw2Y4/z4szZLM58JJLZvMK4VsfoIWSbKmxfKrJr5mphHiMQt2Uzg6ZAd9j8WYYGWkEgBljjziL48iRTxnCtXVFfvEMkV++R2cuncsRSta3nRHPcgPBcIA3NSS5AJA/b2Pscte2yl2VnlffLwSlCD0mtt2ptQzRYTzvi0CYy9CsTyUvfVZLGiwt0570DfBCrXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TDBh73sFsSxZv1zGl3/aFFrVgQjFIpoYHPgaH4J4Mo=;
 b=nyB/FUvOGqJrAOVKg/fdLeumEVZeL1MBgYS5gLdQx55llVJLJFepzBmFYscQnKhED6N1eK578/+Fvzro5/ZARf2oS8QcfpL6+QP628YWeskBOP2Tm0N78ygR4LBqbgqnowdmPzvipclAiefyMgxIKtowDXI6dEAFN/B87zWdwEF1maiVGro856mDxPbbJ0tC//3QzvUyi81C/PE58u5xmYUl88+CawKswlPv0iktXzkvrov06qcwlDkpU4zmLTcG1ItIxz5IKBscNVPwTDvrwBaSMXeQzEh7aO0KpZj623yVRJU4gk+Sbvp1r8APZFAyDswoA0OlGN/VI8Z1eKZHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TDBh73sFsSxZv1zGl3/aFFrVgQjFIpoYHPgaH4J4Mo=;
 b=Ge/8KL8oYJjwTv3h/hW7U8f0x2BOO9kyezd85LyxPTCr5W9kYU2S5GtycLZ/JKqRtJCYQdDGZin3zSQBJNp5O2oE7HLlfYdHid+HTGnEQEKHFFaJ7RwqSiD4oPdJ6l3GmPu2IJ379HCSwFxJBasssFX2VJH6u9En5ACut2/W9UA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 17:31:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/49] drm/amd/amdgpu: add common support for beige_goby
Date: Wed, 12 May 2021 13:30:11 -0400
Message-Id: <20210512173053.2347842-7-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01ab7639-9ac1-44a1-94e3-08d9156bbf26
X-MS-TrafficTypeDiagnostic: BL0PR12MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB469234C58B8D318F5DE09C28F7529@BL0PR12MB4692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zk5vlkQCxGblyb+8LvRWIWsVqnM7jrDm8waBltPa7e+2qbkk3diSWS/9u1wd2pr2z7nWFRZpUPbZYsUIKXweBoSy4FKxNREpkzTy1YTfDuXetFcqM8rfqbtVGFA2AIrEA4Rqpaw3ZBrM/ooGp1AHpy0p6o/6lrSPk+MCBgCrAIsfDjNUtok+sOuOE12XZ4XsuW5UUNcNgT3ZchOjlXQHEvUg0bGDJ6mEYaSprR0gcDBWEXnD06xgBgVtga/5/ursBskpTam2J1qiZBVe26s41FO9mE7TcQoyXzRc/DcPFIyXaN4s/Y2YnB5DQUVXZfJcsaQtqP7FajDfeRKoChS9QUZOBAeRQYyNcsaIsdUrRvsomvsL03Vlf6bZU4Att/Aw7K2sfz0an5/HQksN/0J9J5aYy28v4dv911sS0mwwXkG3M0HXoNS4bRjNPdBvoHF6eyaWQMA9cwwVlrVU9Ug7fIe4TCiRuNxHMj0zbXKizg37rumbMcyOI1TmOqW5Fe5B+bwDy4wKdAtj00MXcSlDS4URLV6EIc2XkJJ4ruhn9/BLFsdW2mmkVBhkEGycf5IxyMhR2WT0BgZ+Fp0W3/JOHbsBsqm547eqb/y+14wmOMZmEsw0bx/vjH/RoMWpY9F5ZeLN2TzMx5QrPVA1E+eAs5PMPGaMHhdfBDFprRr5Lldpd4HSij3Q/KIj3ias2G6e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(4326008)(2906002)(83380400001)(8936002)(6512007)(16526019)(36756003)(2616005)(498600001)(66476007)(186003)(956004)(8676002)(54906003)(86362001)(66556008)(66946007)(1076003)(6486002)(26005)(38350700002)(6916009)(6506007)(52116002)(38100700002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uCtReJMZ3L5Fd+xHgt/li/qLKYDPgT0/QVbwbdD5YDvv53HzgDtu0emO2fNm?=
 =?us-ascii?Q?Lt63oQdkFKzrufY5qbDYSmu4AWEJVmc0xuhHxs2RySSD6aR5hzsUBnQx+qM3?=
 =?us-ascii?Q?j+47PTQ3IGzAzzA5V1NvPlFFIw0MOnA49sCoTcFdFN4gNRB+2eU0ypwi0VID?=
 =?us-ascii?Q?uB3krAi7dbHMnXmgmVRicnj6SoNj7iPrCJ8/e5mHI4QvW0llaf6/l/ytcl0a?=
 =?us-ascii?Q?bUNPuXBvqEfDfTNRYGsyzLlNuKWV7bzw0Mp9f/UmzpHu4fsPRk6qDjNeSrqy?=
 =?us-ascii?Q?k0HjvOZCIEBv3up6PwxgRkSkrZPw+nynGm7FQZJclU1OkTFN9dUMmORgZF8h?=
 =?us-ascii?Q?7/+YAMculqn37fGgPx267GSLQ21PecOqofPofanPaUDX6rvDQM6hfsZGzgTH?=
 =?us-ascii?Q?8W4Pdse0yIPBwBTRArv9I+ulL0itKNzX1ukhcKRlpwl+qjZ5qS+udAKA3XEO?=
 =?us-ascii?Q?y7JU9WKhyaFuAUFT7aVhsqc7Q5X7tX1seXMIaAQDVFwat7IKrwZW2n+jY2NN?=
 =?us-ascii?Q?MUL1p9GN2Jh7LWV0L/OvzJsDLYsudvJHLkcWWhur3qAGKdrX1O+lVNqVdAi5?=
 =?us-ascii?Q?CHY09RV7pgbcyuVDXQjHdvvq0OeduWfeCYjRq8QpkGGBYsYKlJi7rAqM1kys?=
 =?us-ascii?Q?OfU5stNd9NrsMcu/wJc8MlpFPRIhYeJIf6mnDlQV8cMwDTu+rGF8EGIvkZCY?=
 =?us-ascii?Q?w2EHgr0IhY1nJSNDxcT4ZSAbaM2Ruy9rjMd2B7ebsSbVD7nEoOocYIsMVVSS?=
 =?us-ascii?Q?hysYDn3redGLt1Fw5oasjCiHza+yDQiFyFRuSSQXc+p8LLr4GwVl1yJwQbl2?=
 =?us-ascii?Q?R+YpQFQBLwRmUKM/1aMkIuwXkQCEbjmU+uZia3wnmj3pMHjucngtOA74TkVA?=
 =?us-ascii?Q?GWrv5xTZjI4IKY/CL8tu4wcHcdZpKUpLszgWgAmrSjm2nAmi+z14KFSC8bja?=
 =?us-ascii?Q?d9mQ2TU88bHkAFUOw1ahykQy8h1m2WGGjzUe2YciBzrFdt2trF3+Zk41763W?=
 =?us-ascii?Q?AhVUs0dyzVEpkHkL3GGpqga9S04eRcdvCa0tiCj7jE9jEr3I0/e96M5W24j/?=
 =?us-ascii?Q?p9j44+ZEm5zkiTlkwbTnRm1GBRW7xT9faWy4xxuxeIOXlsyw8IniGTmCj7yE?=
 =?us-ascii?Q?gtYz/CImNaJzZvwqyP6v+aP+9juGJehUBY7cwlAibJ75r9nSC1onmbF9qu41?=
 =?us-ascii?Q?GMIsvfe0KU1a74mXcOmkH22ImGjhD1BDzzwP6CgmhWuR5e0LRhKcV3RxJutu?=
 =?us-ascii?Q?P5bhi8Qb42LIIUUz31GJ3c0fXdYoi/4JETzSGGR95hYnAZuurkVd9eZBJcxN?=
 =?us-ascii?Q?ALEOCLeUrXjM215EdnpqmNba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ab7639-9ac1-44a1-94e3-08d9156bbf26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:16.3889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz3iO0797jdjZgck8c4G+zbY6TMozTOzxqW/YLcG7kseoMsBD+O+2qwUwetvLzI0E3K8jvd+uBb+H0nypTdwSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add external id and set clock gating for beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82a380be8368..2042ac4912a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1149,6 +1149,11 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
+	case CHIP_BEIGE_GOBY:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x46;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
@@ -1263,6 +1268,7 @@ static int nv_common_set_clockgating_state(void *handle,
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
