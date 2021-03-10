Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B1C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 01:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7857C650E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 01:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7857C650E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA8D6E9AA;
	Wed, 10 Mar 2021 01:26:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEF36E9AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 01:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZwWQSnHq5NSpnL6HdcRY3pWqrtwryJQ74zlFmgi1HyI0ouMj8zwS6NlHKb83UkgPAxl3LMa68NA/sOP2xgYkcJkX3Cv7NN6quPKKNLc6s19BIVLO/NsdhWJSOJeDRv7keeyt9WoAczP8i2VcmUdXnJFR4CY8mRW9PXNCMIGfWaLKPoIVL0YmR7E83Nmug79QY7gwhI1/b9hqKyYtVubOqU4anHt+i3p5cCZn6evoBW5v6JKkSIxa3SLcBmvHIHebj/fSXOBgXLq0xWRAT3CBBr/+lgVvJXv3WrAjvicfRJrg57NaNJg05JeIGX8+DYj7JCM2rvAg42/DNDHQajmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEA2GIYZmtXlpHKubvDUZpvGgqUDXUipFCdyPSkGafQ=;
 b=V3AwVUaSLqDOofWfoSZz7ZnKfxP1h+jNUASsXRi6inHeoGqzLq3WAGOnihw9h1NoqKgSjQZr76jLvRE47bh4gUryGoRLSIbmogkFyae4WLjXbBAddqi7BgGJ34/hsLoruGyNNCwNn47iEUxcUPWseCp2MaNPBNJLDCddX3ZesgoJYji1hje6rcp0+PGugTKWF2HmgXUm/i1LIKZxdU4dzi3xmqhhneaXXEyhfwqhl5DqCgj58AkVdqYkgEB15JHZPTiBFcs3ITFBdezHmoIDoypCFx9WPm+TWqY5EXDSpMDLGjbb/1mut0DzwXlwZcPo6Cfg634AlzsY9QPPM5ostw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEA2GIYZmtXlpHKubvDUZpvGgqUDXUipFCdyPSkGafQ=;
 b=TxIWRjU1KmGtLmQ4jV+EBoegngSTF58h4FtJo+rWcaHq2eW4Jf/yXoggO/lln/W2lyGoeyGgqMWhC9CMds5qTJ+h0KkGMnlS9G4e97ytISI6ZMMp7X9WxNB2IuTsCN2GxuPUUAQ8X/9slvDrT1K5/jwhlv6adyaChuskwSU/aQM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 10 Mar
 2021 01:26:52 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 01:26:52 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: skip read eeprom for device that pending on XGMI
 reset
Date: Tue,  9 Mar 2021 20:26:40 -0500
Message-Id: <20210310012640.2380-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 01:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9eaa6a47-a5c8-4893-35a2-08d8e3639572
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4780A2B336096D8E7443CA39F4919@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLLLcLM+O1TI+Z4vk/LXyD7Dk9/CpyVnWc9f7oofGNB9NKSNhUzfwTNTVWMXQAyUgG465Z+YsuvSDjCvOgwBuZ2r6kuVQ2NMlYorr8+wQgL72yAn/KNd4v6+berwh2VzlGDVGY/qKcoyH7r/XQyC581dZXHkgTXmW91z0KCUB136hLUlu+XpV5IPt15YVEt4YCC7+9/qMb5Mo2sEOAbkZuF4tMEnvqYmlnWHnkqz63bnCOKzRIuYMvB+RlybW+moS5o7uUgaW7DcbwbvFDXiepyHMa78avhY/UOK+o+slsud3r084fuvLSvEctxtOys5UGRmzG65qzQh/dRNvog/MtYwAcV9uhSVQVABARf/HtWlxWWVfk0Ztnho8bhyRnWoMphyIyK7TT4SKU096Yzy+YIxwqPQVAwXGSD4qgiROwZIYw2MNXf+3rbLOY56v2MItb4TAt5V0aEBG6mFOD+szFHkqSrYyyPxC++nZ10V6XS/AJ8vcNmNbhBZUHpFPPqx7suXY4OUwg/lowdbgcTjHRRAvHed6Rqa70rtkERZBgioxN4gbdtR8UP7AU6D5iJM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(316002)(36756003)(26005)(16526019)(1076003)(2906002)(6916009)(83380400001)(7696005)(86362001)(66946007)(956004)(66556008)(4744005)(2616005)(8936002)(66476007)(6486002)(8676002)(478600001)(6666004)(5660300002)(4326008)(186003)(52116002)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WKl+G/7f2VX4LNXSLaU6uQJ56jNqJy7FIzs36VUjaK/oHyl9MW1X8ISuCOC5?=
 =?us-ascii?Q?sa2fVvoeXvwYGywe0XnyNn92qvtGtUTaQvZS8bSfCcdTZDbfLMBWQ6VW9xt6?=
 =?us-ascii?Q?a0cxYMkzlez7ezefvjOZXIuLUurDApPhLuMWlgiWvCxyScuGM6tufasVTlLK?=
 =?us-ascii?Q?9mH1UqpI+mrTxTMMJnX7Gn07+N26PZcmyGyDB65RStXScWwmJ4ZL0cGVNetV?=
 =?us-ascii?Q?Qzcn6/F1ixlRuO6c7PR9s672UJR+Iklm+14qDFQEBk2tkBxxeSSGRqW43YPk?=
 =?us-ascii?Q?tq+FDlbnNU7DifnIWnYnPqrclvnCmx3u7MOwNAcYf8cNLy+wcEf42OEmUci2?=
 =?us-ascii?Q?xG8VQSTRz6KuhaHxxqwVkWrcsH3ZQYaWqoknIAv51g1lurhc22JGmhTM5OgD?=
 =?us-ascii?Q?+z2k7/qbRk+CGptBRfMK0wSUDAo5ZM0twsh9YHqWGCkeklt5g57Y2mOL9fcY?=
 =?us-ascii?Q?4D1HkxfbBVeP8E02i8z4JW/5av3GFY0/64nUo9s7KgZBPW0+DKLR4JYII/nW?=
 =?us-ascii?Q?GgsSehhDxHj8IkuCcyU8t0aQClx65YhNGZXufCqg8rsFv4ZsAQONiZyN0ECs?=
 =?us-ascii?Q?ZVAaaKGPjTqnVzRNx1Z0TrtD83j7Kli3kILSmFZGF+4Dhp7EpGZGuJvklRQO?=
 =?us-ascii?Q?y1ghI682alPODHivwMNiUn+uAQEtBZ70krB+EXsw6Spbu+mFJLS0xFP2VR1b?=
 =?us-ascii?Q?DXaGQUvRSDRE5B8LUGLF0mfgik3LGhXOb1az4lOcZ3Mdv/ztgZMas4inWThQ?=
 =?us-ascii?Q?llFE8V4RRqn+lF52CAjmKxbdcChgpJwW851UAf5swU2x5ODVxui+eSGnPfJE?=
 =?us-ascii?Q?BPJvATtyaJryVzPrrMqg8/Zuz3WxCZnxFILmaZMZmQDOy/bZzXFhsaROFDpZ?=
 =?us-ascii?Q?eTo+ItxLXQUovS3mwO9y0TbVYaeUbe2r1sH6iM2y9suceTLHIoYXZoOIl9IQ?=
 =?us-ascii?Q?CpKHxdx+Ht2Q09hXlalgrrYHpR5wXleDpxhi8ybHL0Rw4fAGQY37NFDXH7cR?=
 =?us-ascii?Q?piYbXKhZpImJlTi5RT/6qnDJzGVpP+2TZN4KRf90iSgKQ2inVzkGIaSuZ8sj?=
 =?us-ascii?Q?XJvMLvRnarnglqQ6bYe3yHSMIEY3C3o/vgUZ5k974KlTvOQtp35dZLtGCcC+?=
 =?us-ascii?Q?6TP6vzwqCxfLujQDrnckhgckCH1HZ6S34fc4huH5uka9hmx60CUoQ5mp2tMu?=
 =?us-ascii?Q?WdruK6BxjJgJR726BiNqIQ5hGa/favfRn/cSCFiF1gOpevfSdUg+nX5ySmR7?=
 =?us-ascii?Q?0ukXDe4Qk/EbjIjwC7YxgtuEXRCiDhh95/XyVwmX6WmqFNJ3O+RD3xVVLiwk?=
 =?us-ascii?Q?iPVIqHlO3hvnuVtXiS80NsAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaa6a47-a5c8-4893-35a2-08d8e3639572
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 01:26:52.3511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tzcJ2MhFAJ0UWWBoEFmBlZk3PyE+CAN/1kc2qWs6del0d0kZKuWELkmr3gXexyfae/UTg452kwNHtA/z/QroA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Read eeprom through SMU doesn't works stable on XGMI reset during test.
skip it for now

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Id864b96a9da5b0d4dd5ffef9858997dd9f52de25
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c669435ccc74..a2ab8ee251f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1822,6 +1822,12 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 			goto out;
 	}
 
+	/* Todo: During test the SMU might fail to read the eeprom through I2C
+	 * when the GPU is pending on XGMI reset during probe time
+	 * (Mostly after second bus reset), skip it now
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
 	/*
 	 * This calling fails when exc_err_limit is true or
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
