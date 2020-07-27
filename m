Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041AEC433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 03:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DCA204EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 03:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NmbdbiKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DCA204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C98E6E108;
	Mon, 27 Jul 2020 03:04:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0099489FD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 03:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2z/WK+H5rvYc1tH4dTbe3ns+YRTfH1xrU/G/GlY53UZL+bA5Unz/g30T4eMufNgPahECNTgceUaufP+d9px3JPsd/SeKpqslzaTcETzi6nv+Tb5/eVhfuo7AWWEdA8ElN3MKwdhWNxpdLkOiHKNCVrCV3FiNivsL4NDkNRknQO1DLNreAGzRj4fYPYaQHyCI3T+Sw1WWx/B4rIj46oMlH2mQQA0hXzqTUZSlqT+XN8YyP0CF41UwycDMhPWREAc2VRloHC6EolKaal+6k6aIe9R7St2A3JQLSLP+h7c8EYurzLik0F0UAAkshLTveDOwtHsYEhMPHK3h8nte9+QDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9WpGI/9az8fpdE4p66nnFht+eV2NqclNDQGdnEeWBE=;
 b=E5RBtGkdj/buU3kOTzDCcvazCPKkFyz8CnP7ouC+vzgGsMrALZOlWBuFeMP/Ni6OriUVwNHK3o2iM1Ccs+VjVmgmdERCnM/WZh5Dh0+UTLekfhGl5F1TvogQDdowaVhnoO82Lj2btVfNUWY/Uv1hiW3ptt6VAK2Ouym23yEvG9b1SOn/8p57rcy326YStynTxnsy7+UvkgTda7NUpPSJaJlAq8PqspdrE0ERlpG4zUQkdxhzpcUNd42LXvr+PWEGIiaWpNPGK2ZsTjw0SRSj0eWLJX5ZMDaJNEiQ/ANSUIDtpiLWgGwmNRMjWb9LsBnSMXFS39jQzwXujmdDqggi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9WpGI/9az8fpdE4p66nnFht+eV2NqclNDQGdnEeWBE=;
 b=NmbdbiKj/gRpi/M/g/8MIbVjS/aCK5na+xHx27AFwZIrNN9yPafrn1d2AGl7bWmuqZz/i0K6sH9dOZ4QyQedoGT9cTZrEq8omfMeikZeedQg1FhuPCIrt8CIq9mQ9MD/NyB9orS2A/tGaye5ZdcBFCLPAqc6ua1gjZEl696Nt9I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 03:04:25 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:04:25 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/swsmu: allow asic to handle sensor type by itself
Date: Mon, 27 Jul 2020 11:05:27 +0800
Message-Id: <20200727030528.586004-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-pc.amd.com (58.247.170.242) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 03:04:23 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f858b8a9-2cc6-470a-c9df-08d831d9c48b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3598:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3598539852B4F4A2CFE70665A2720@MN2PR12MB3598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6h0iY7sB3AoBkKwridwq+8CwCdruHPY1jwrlDAEBeMTqZNdf4Bi68svnIKJHD6X204Y+pI+R0N7+RzeWbD/RqLjpRwqyDE/73sKPkf0Byh4w3gmJjibzDOLUi092HxcvZHk5IGC3F/2WcxksIH7802Dji3zyqCtApJMAYUm2C0JSul1hzdtEU5l1ua05DsRSeVxO749N8aP2r7Lauer75spm2vUtCcRlLwXxlGpl/K/2gpOUYlr8Fbr5vjp0G+CFa2uF9Kno0UcYnc0CBubLEFfBPCRhlqKZUGWYhlB4aAz2SoCvEgijW56QEuQ5MsPiMcKrulSe5lYRrIuZV5pZ1weNtto81LRa+9a+UsJKl7P8yRfQ9VAUCLMt9bV0EQy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(5660300002)(66476007)(83380400001)(4326008)(66556008)(1076003)(16526019)(186003)(6486002)(26005)(66946007)(478600001)(52116002)(2906002)(8676002)(2616005)(86362001)(316002)(6916009)(36756003)(8936002)(7696005)(956004)(16060500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GkWQQnTCbYzLsRntPPgN5Ha9IEyPUjSENguBLyacwXP0yoPKaL/XKJJsiOkFi2mIo3vY6B/MhuARYOYUjbxjDn0i8sZnKAQTbL6EYv9t38EgcXpHOUD09d8I5C/jgUgT9Hd+vh3AwpB2QFJ4huQn+qGvxtgFn1o6/K4XZq0acX8cDBcsW+QLRsV+GBYdutAc+xZtzfB434Bs4SRuUb3h6zWHoQOCTX0vOBw5zoNDqatDCWRq4OtZ8Yzk2uDXR4X9g9XdFoND8Ibfu0NlcvF4jhIIE5Wt4gStVhK1BYsBstYTyKhkwGwiJmlGShWGWj7cJIdBDu4cmrb55dH4V9RKBGcV0rTNFbsiMWOqI75sYgUJkrSIMgpTHHCUVGd5culq/wvM9gmWyqHNnRy7UaRJBqKGTVxIIz2hBEzACorS+z1YyBCJ9wDIzaVTjBUOW3NLjvOjy1BIwEVgGcscNLDaUBqTRWjUnhxAw//sQjOrNPnAWbx9+5vqLnTWNkCp6qNn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f858b8a9-2cc6-470a-c9df-08d831d9c48b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:04:25.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +132Rm1yRp6vpNq/fCuxEUK4bgq9SySWaPfIoreAqR8DMZuQuDbUHEIrocBJRW+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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
Cc: Kevin Wang <kevin1.wang@amd.com>, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. allow asic to handle sensor type by itself.
2. if not, use smu common sensor to handle it.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 3b427fa099fe..55463e7a11e2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1948,6 +1948,10 @@ int smu_read_sensor(struct smu_context *smu,
 
 	mutex_lock(&smu->mutex);
 
+	if (smu->ppt_funcs->read_sensor)
+		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
+			goto unlock;
+
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
 		*((uint32_t *)data) = pstate_table->gfxclk_pstate.standard * 100;
@@ -1978,11 +1982,12 @@ int smu_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	default:
-		if (smu->ppt_funcs->read_sensor)
-			ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
+		*size = 0;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
+unlock:
 	mutex_unlock(&smu->mutex);
 
 	return ret;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
