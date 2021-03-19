Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B89C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 07:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7692964F69
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 07:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7692964F69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184496E247;
	Fri, 19 Mar 2021 07:04:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388026E247
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 07:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGl24x0GozV2yEaU1oVjgFtqXI5tthloKvfnw3HF+YnRcMK2MRzjD9YD7k6JpVXyec4kjC+9U7bF7NPqqhvKq83PUqncfT3NeS9OFpUFd8kazVdtgXQQtUjq4wBWZFTYdlmel7O02ccPXqgLZDLOEKVv2XWjHOW/squ4x7+Vqh3WWZOEBivNITFoRLL5MZOCN94SrIiIVQRGBWvuFtjg6d6MUg6KHJPDZzKd4nlPIJh6qr16y6zd8U4jlz2sRKk3BfXq6BvEBCGQiRKQ/EnshTs536B0zsw8BhgRrAaiNCfaf/H9coLBQHc7D4NetW3LoVJeh95Ofmri5Kz2obtM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbU0yttTc+MScehTiHxB0G0QQeX0TWsblz8gAKOIxa0=;
 b=i11E7WoOdGZNi8PFVouVhysfG69P40WqBJwMLz8hyIPsuRM9v8cRGAUb12Z/8DVvq7VbaVMmlrRFN79M5255TJzTWXdjXoL1fX1lCnjxW6DHOQy6dbSUwJltPG9Wmn3HNt8NGjOgDOVnOl+VzZ28NuDsfU+est0afh3rS6g+zJ8C2npKilz8snbTTDfaAPB2ZUNHV4+NnEBqAZsE4ViMbEmvYrjZ1kzawBUbfc3NWyjjWyjqMgT6Xo9rUZ7ahvH15SE53GPZ2jyOOGhKzafvP+zVCFEguIS0cu4AfzaIpJc6J6Fi2P8kPQLEldhQj23GnD98l509t+EC3+FmoULAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbU0yttTc+MScehTiHxB0G0QQeX0TWsblz8gAKOIxa0=;
 b=P9nj/LT5fhWZOu43iEEG14+4IbFXtvesB7KKzFH9Y/dsVsvYGKwdshnZrqpDCd0OeB8IqCYX4MRYhX+zgDLgNnGRywhQptQdAgy0LFIVwPbK2XQd+ODNuqbtBif3b+8sJalVMQu8f+0cHZyVjR7VEBflWVHJ+i22lS3p4Bp18Yg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 07:04:37 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a%8]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 07:04:37 +0000
From: Shirish S <shirish.s@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay/smu10: refactor AMDGPU_PP_SENSOR_GPU_LOAD
Date: Fri, 19 Mar 2021 12:34:15 +0530
Message-Id: <20210319070415.27873-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::24) To BY5PR12MB4885.namprd12.prod.outlook.com
 (2603:10b6:a03:1de::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by
 MAXPR0101CA0014.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Fri, 19 Mar 2021 07:04:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 100e2c2b-d0eb-4095-7a48-08d8eaa541f1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3651FC102A4BE2B6B205D543F2689@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwjX/Uue+PU3Metg26v5mopwFiylj04k6AZ+DeqhEkNiqPqg0wEhtONDntB/FGv+pCE7Q0H0oOjK/JRl6V0/ZOK+Yu7Bm1cTJxZd+bh7Eead8PdlbUmG9jX11Vcc5F2yiEycWgdFyH0Gi8RHrVNsoBqLutOBUwF8wRkiZmCNPnVhM4TLpU7I5YkHpUCqAMyBf/TebUC8ewQ/yY8Gfanmq1/tiYOMBw+/LeZ8EnbysnxuBlA6k8iN/MlIvSmGt64kK1A6stYiWkola2iWHmTru0wkJUd5mlqr1053xCh9TkjAVVudV+qGTT+J0HLDteJ5JerVhezqknnn8IChkKOB8swCNVw1mxinvTjENdeDDD/97vpcDxVxgc0J1uWFFcfNgTm5RrFfuF3N/aQ/zZ8PHdbfiK4Isa/rK/KLk/wmaPWCFwJehlV0wsz6iKmcHL7DCqWBdonq9Eyo/fxTRwHqFlMHolGhRSXLHHK1CWvWyo31YBCLK/6cR1SifeKqYrXzEjXW7+ZhNC9GyJsOYSPodEukUWmVqg5HsVMflr/du5Q5moDBzODUUiW+rvINBIPCQCipd5MmpKqzyoy5K+ZpUc0AbtGNtYtWUlR1r5CwHZyqCHiX7YZ3qwqLRHu/mSDqLo/kzZ89hqqDXuyxWulEsi5gW3DuRBEPDvmhS1+Zhso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(52116002)(6666004)(478600001)(2616005)(83380400001)(4326008)(86362001)(6486002)(956004)(1076003)(8676002)(66946007)(26005)(66556008)(8936002)(38100700001)(2906002)(16526019)(36756003)(186003)(5660300002)(316002)(7696005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JLDTx+5VS0OoQPZigGyAhMlsdBnYXULprGaeIFW2oiU3iGZ7uWPQ/RFPH4Bq?=
 =?us-ascii?Q?xNSLuzwZMxP4z2OypdLm01oI8ih+cocpB7Hn4veLF8pkVamk5xsrTB9qlFWi?=
 =?us-ascii?Q?F3WJXgxFB6u4hYA7SJYINLU6+B1qZCL0DWqDwF29MVrYKsP0uvmND+LTPkb+?=
 =?us-ascii?Q?jkA+Ypm0oOktUMfGmkUcpH3jwXxXIshqc+oNwBIDt6FPWtDJOMgewBxKFEM4?=
 =?us-ascii?Q?1Ciwqrok/gSYSgBQWqioSA1Lcq43qwT6vvbMgZYD+CP31YS3wLeSFqUJwXCE?=
 =?us-ascii?Q?SvmUTm8vlwAKucZ3hFIpgB8C6+rXBTidHAjanetTKC2mpYqeGPLoXflCXXOB?=
 =?us-ascii?Q?/PFJFz7AngOrynva6/uKsycyQegMTJ6R29M0gbPMkZmDgnAajVtMQW+p81Fn?=
 =?us-ascii?Q?MMGXfbY3EZdYkBBVfiiZ/wkkhQnS/I+ucEgv33yRoA194QDZH9wagDrQX6Bg?=
 =?us-ascii?Q?vKlnuyjIQPj6EguopL+ZBFCX9HSb2+DeQRPEINcIQ5j+RNqSXu0FyMHLmk/e?=
 =?us-ascii?Q?atZ+73bepOmr7yfapLGNaK1rk2LusqHhr5SP9xiSHzNbDAz0F8MH7ILFUvBQ?=
 =?us-ascii?Q?blEpnxU2ODIh1fL+carXTNdwbvnHmydjx+SqH52BNjx5WjhrFVEvENzegznl?=
 =?us-ascii?Q?rnWxiS2KMPoAtkmphjm+1mEmgz3b/leVbfYJJWqDDMmUeYtYzHswH66YyE1C?=
 =?us-ascii?Q?pjg8SzxVfD5RgswNADwdOELjPI1ZZwxZgqVdn8KSO/LetzP4ASLbnawt1Jwb?=
 =?us-ascii?Q?bLtZBH36iF1F2aSCbWFERfitChJUGAJm32tUSVVeF2NilgKZO+e9Y4J+08LC?=
 =?us-ascii?Q?dwr3HR7iXtC7rglzbyzlxmixn8hkcY9MMcSyxcQnfGP1OSvh3RElOoRJzp0I?=
 =?us-ascii?Q?nHmDfRReyPHC2dqPD5JJjoRUDCxofrbT6uUmhkZ+iXMMUF2TEjlMjPrZ4Eq+?=
 =?us-ascii?Q?Dzu7YhNWFMZLV0k8P3W3e+x7cSb3dSRU3g6aGKSd3G5iPPJvpu4u5tuqrfAE?=
 =?us-ascii?Q?BU3G8RgCtBq/i03x0PxWviRSN8X81Cm1WMG+0h0+Y2SgZkyU0kurBD6bbjHg?=
 =?us-ascii?Q?iOgx0WTf5ptYwcKLozljrG0dJSXoe+dzyNB/58oquv9jpFqa54PjiMD2WDOp?=
 =?us-ascii?Q?axVYD7xtkc/mz8zk9Cg+8V0zzIHBnJz7xEZgSMOJAKh7MV4Ng23BbtiRdLyz?=
 =?us-ascii?Q?Ryw24nfzY4wm68VCkAWXfzuzip9jO9zUdqYrBkWCHHbEf9j99f5I+Dcj63pz?=
 =?us-ascii?Q?MUS90aWtBg8nkA+qixKIm4mPIqUqi+Jyq/AyC/tvOXIzvaZqDF7tqO8D8k+z?=
 =?us-ascii?Q?FQscQ6epPKDpKaNT0lPM/Nt8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100e2c2b-d0eb-4095-7a48-08d8eaa541f1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 07:04:37.3148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXefSaGerLbedWkaKOiWkWUpPI1vFtDSdsl+ToV19O5TDjzfmLapZy9xnfhdHZPZnJt0pUxTZkIhszdxtVxsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
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
Cc: Shirish S <shirish.s@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refactor AMDGPU_PP_SENSOR_GPU_LOAD to ensure code consistency with other
commands

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index f5d59fa3a030..f5fe540cd536 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1297,19 +1297,18 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		if (has_gfx_busy) {
+		if (!has_gfx_busy)
+			ret = -EOPNOTSUPP;
+		else {
 			ret = smum_send_msg_to_smc(hwmgr,
 						   PPSMC_MSG_GetGfxBusy,
 						   &activity_percent);
 			if (!ret)
-				activity_percent = activity_percent > 100 ? 100 : activity_percent;
+				*((uint32_t *)value) = min(activity_percent, (u32)100);
 			else
-				return -EIO;
-			*((uint32_t *)value) = activity_percent;
-			return 0;
-		} else {
-			return -EOPNOTSUPP;
+				ret = -EIO;
 		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
