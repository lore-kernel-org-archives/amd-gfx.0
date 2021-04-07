Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792CFC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 08:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2992B6139E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 08:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2992B6139E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6CF6E079;
	Wed,  7 Apr 2021 08:26:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34786E079
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 08:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeFEdE7OLUxdJBhul4J1rLGJ8xJLMX1ak4nWdftFHHeplznOCZg8ry7lRtzg27d1HFxCTJqg4FhaWF2naFZE/6k+6Zvw2Yuda2StrXgb/DJ+VGeDS9pVtY7ZsGNVj0mUJqM4BRUeAHbiRQr1eMpcX1RuGfnVi511SHQBzFZyNomOuZ4Q6szaIY63WZwQIBGeMVxBKIbOoqdOHtkdtzEh6OlTI8Bljbmvmch6Ut/odrW8XOAuOXHSpUsJKE3GtM3c03MXEkw1kznGuZYKmwSPZa10HyKxpxdb9LFVvkxxJbJCACkKRwttJdn2EcfDpJATlE+z6OdfC6eqEoagp7XZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RToIMZFUnKU6WfdY8rU7qfQ4j7yVMnQnS3RBoRB15NI=;
 b=B0a5BjvZ2zldUllekCWFjLx0I2/imjiCHBM0BHGL0l5HMwy0Yi4uckvT2ZvwfccUcxX4XOfkiAz6dsmZZb4XEx1tPUDENRrMosidnjvfYqTp9M87KBxHp1QeJBSWk4HDGRHnVAbOkkvGFd10cI/wBEbk9tJ96ldI7bHqIRwxCgSBhUQODrQFyL6F6jAgu0DET4XzVUlSRrXsAfABXgMb/Jm1v0gNXgnnvMvBrVzj1ud5l+vnM0dLQjfQ9Vi4a91kg0hJLq7UdddZ2e/l2tK1Xk7P0BoCkZk+qZCMfaA3t83wBYYRT3SgFM9gILe/xw9KKa0Yuw5ZCcp/695HlFgKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RToIMZFUnKU6WfdY8rU7qfQ4j7yVMnQnS3RBoRB15NI=;
 b=JxDwVA/BeR8rYKOW8L9gqvz8AMv2dr7S9Lr6qk9xVofCFLBbcsc1Nftxo3Fzaq7+SWSM13zJcmluOtb6Atn0eXc0rtEBQa9rQhdmK9JcIZUxEIXBICs4qVorNGWTPggZ8QsmRc/QTFQRaoAw7J2eXQ5X7MerS2FliO6xgnTKxEQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR12MB1699.namprd12.prod.outlook.com (2603:10b6:404:ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 08:26:14 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a%6]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 08:26:14 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add the callback to get vbios bootup values for
 vangogh
Date: Wed,  7 Apr 2021 16:25:51 +0800
Message-Id: <20210407082551.3773040-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::18) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-vm.amd.com (180.167.199.189) by
 HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.3 via Frontend Transport; Wed, 7 Apr 2021 08:26:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a4fdf7-e14a-4c5f-24e9-08d8f99ece92
X-MS-TrafficTypeDiagnostic: BN6PR12MB1699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16993E0F8237859526510529F1759@BN6PR12MB1699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQq67YrfjJyFIz7iu0sI6uBnRtYrPp5xcCDRV70ciqkFuXoFLifuAWHMv+5sgyCzyH1Sh0mwW1xCyNQwoNYKp1ZBtaygoiWlN09cg6+8FLCLrJWdIYG7Yw3LQ00cBvLXMh+vLeH4T2RRT7shp5C44MWkuvsHtAM8CJxrj7BzUnP99j3cjesZ381XVNCDABMQu8sOb9y7vb+4fcz738zbIP6a9l7M3YRRJX42ybbqW/xlh7nF5SX/goCIinpchtaBOjvwP2X7dfmSfbhBo1eLJJRybQozDRH/3qSrAtR6yaXWP0EKCaeRZX31HR2gK0gDhxZH2iP/YqyTccDpLlzUczvjmpzO5g+vqEhi1FHP3U9MsUdCFl+LvlBCrYFE4mG87PzTB9EL9lsbI40sznHtZYcHa0e+iQ4+bt22+6v2S35PmVKOez0PQ/CY/BhCCfNFgLu7mM8tfSariSg1opPSbC/NSjkzRGKSbfS3PhFLju0AZXPhcYyi+dajz/s72VZs2CQpWB6bCtZ2+L+NgVO8jGwL6DmEFSLDAFyujS6H6fqYsWxfA8LlBdCZKXUYN+lwNXqFdI32my8RnYUdMBlscwlyG2807OStpFibrzDIxziETn90/N6sMl9Bgh1pVyR/FzAaPr6kN9TDWjBMdS5/E9n09JsNRo5D6h7p0KtSYBC2NDkOMb5H7Qw/9tVfGUEd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(36756003)(66556008)(66946007)(66476007)(86362001)(478600001)(186003)(8936002)(6486002)(316002)(38100700001)(956004)(2616005)(6666004)(38350700001)(4326008)(52116002)(8676002)(7696005)(6916009)(5660300002)(16526019)(26005)(2906002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+HzpFaw5nfTI6VDvBUB0jvzr0jJUC2Zuc+XXNa/ZDqo2dWhvLVy//OkOlNwx?=
 =?us-ascii?Q?AsH4TDQj4ED43xZotJJE2UEZ9SyVRlvTaB/YVHgOko4HNGlUufTdjJU6sOEH?=
 =?us-ascii?Q?9nTBGb8axIoGlUawy1CypdDIQ2+w1G5px+HyMLfJJ+FS6oQr+AsewxckEmPB?=
 =?us-ascii?Q?2YCI6e60fFtiFnG/NgWddushQEWR0yusSZ2lCkN6qL/QaqeN1VeHYBcNbdEU?=
 =?us-ascii?Q?8Ndj1MRy9QqoWEaM+RRQc0QlkLymywX1gvZvlUW7GqqyPONlaEM3dBw/yoIS?=
 =?us-ascii?Q?dyhGIf2LUEqndQiQtk5VCrCaMRe+Nud43TKgHtNaD752xoLs6dwabG2F5iZA?=
 =?us-ascii?Q?Z8ueevLzBep/7DGKr36FFs1io0lUUiFy6yjcQqdFR9hCFGxR63NqIRZQEUnY?=
 =?us-ascii?Q?d623EzXRCn++pvjZTArypdBpdj8stiR9eZbkwmLqmKsBxcf6f2l8vADVLxZ5?=
 =?us-ascii?Q?MWA5UwqpU2A5drNEtOpKaK15ypnKXr8nK5e0c79b/pcXiUL5wjfsW6kOD6YL?=
 =?us-ascii?Q?Pm8z5y6iOGwPWBJQGo+EOyiclpmstJ3CN8Crd6hHBkQ5SDofN8HhzuDCZ4Iy?=
 =?us-ascii?Q?4N9NzPHZCO6d9mTPDjM98mIY7XpdpRcou0/gs05N/84PMq0u57Rl8yu+jhyr?=
 =?us-ascii?Q?aQ9OWF2B4uz7/RkZmMHg+nOuQdeVtE5JPbWPOBHXTwzZ6+s156m/ptIw2pwQ?=
 =?us-ascii?Q?Xib1vWS53ERZMkmohVIgd2wXn0dknfHDtHGPs4ounKG+qV1qNPEZwd1RGsvP?=
 =?us-ascii?Q?JCibFq2nfY9HtsUBNM/yijehnjB0vMtx263FV3AICUYNlOCBQOIhH/7s9MQS?=
 =?us-ascii?Q?hVEjSjtETUIvybX3x7U5MVkGv2oZdQIA6KD+LNL8fA2U5Ffeu7L8Hg9bGtZi?=
 =?us-ascii?Q?A/X2GGRrUR52IIzvoSLIFh8oG4JC0bEGTqjAHcy+aZkwJXkqnOUVBbIVF1Y1?=
 =?us-ascii?Q?8K410ZH95CKx6b/4OXOITuzmxlGtDCbu8djcvE+P9ZnU4TxQfVUDhH7EMp7P?=
 =?us-ascii?Q?SiyhO6vkfEgxwUzbYZ9aBu0VGZ0Fv1PEWTd/WhVfV6tkT19nU1+nKbgLh9+Q?=
 =?us-ascii?Q?jWJdHfQ1cGK/UpdY+5VqhhCDQArYhOFYPGW7np9LZtEueWVKs/IPt/RAtVdW?=
 =?us-ascii?Q?80ZXEjoGEY7B0tL/dhrCjZt3jEl9wREnjgrtjnDTou9E8EOZ6ghhmffdOP7+?=
 =?us-ascii?Q?crrKN0OSNZVF0RNPQ6FKkdqq93uTW/Uky5f04EfZaPQywoV1/0dwO1bmW/Ao?=
 =?us-ascii?Q?XM3FXKTPn1vW4u0rAmwxjbLqcaRFNGh25/1EfJnaq6zl+QLSyerZIw9Xe7Sr?=
 =?us-ascii?Q?HpeXpCkhWinMtBwksHCiT+ty?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a4fdf7-e14a-4c5f-24e9-08d8f99ece92
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 08:26:14.1417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyg9dF6wmhT7oMqTBf1p3Y1yGAvedzOrS/LGHGSezPfZ6/Ax8CAgSNN/OTOx1zbzYxzAIavxwQCcDCy8SJviiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1699
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
Cc: kevin1.wang@amd.com, ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>,
 evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add the callback to get vbios bootup values for
vangogh, it will get the bootup values of gfxclk, mclk, socclk and so
on.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0d137af1a78a..6274cae4a065 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -561,6 +561,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.firmware_caps = v_3_1->firmware_capability;
 		break;
 	case 3:
+	case 4:
 	default:
 		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
 		smu->smu_table.boot_values.revision = v_3_3->firmware_revision;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 5aea67637bd8..7bcd35840bf2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1894,6 +1894,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_ppt_limit = vangogh_get_ppt_limit,
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
+	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
