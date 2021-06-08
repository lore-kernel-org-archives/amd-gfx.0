Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D095C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002A9610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002A9610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04DA6EC60;
	Tue,  8 Jun 2021 21:41:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145CA6EC5B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDS+Ml/UN4wkdRc9X3hLa+UurNO1mwQOZwnWTteL8vD1N4jRXGlwdmKYyoofdjVX7Dfnt25/XQ5wAGZHzNK4KnyC15g0pCahGqEeoCrmzLfHml4TDLTzW1AyHKXRArmFUIUmFiQeSQPJIthru3PV6RC1puJ+0P0knVdqD1AYHbFuOE+M/Oqi9IpNrXLJHDt02GBWI/y8sRP8udNxoOeDn6HAOFWvOGkxNFEDeTVsfChs/DBDITSYYlDL/64Cyy+ALxwYaLq+cJ2+FATOuwZ7oqK4RvmZuJqmhDU/X/MdtGi2HumRRu0rsnK4RH3GpxKUiDeUH6BMAivB5EC2+WG+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BiFsor6OzHveHYNaGjTP3CvCqczobLPsBvNix6V/LY=;
 b=fzJt5+WptKUNgvUjXY291X9vw3QKXchf5jgIulj7P3rxWLMNVvV7YDiI4NjAbL6vH1mjRsQi4qUWSEFUmWTd2Knv/MeQ7kh4eVymZtCK3tMwS8kS7arcItkJQA8YhYKJoJNhhQsxiJeOiMLna6NzDNBlNduQUdkTgUp67hcE31+bmuarWLTVegJW3b5O2/g80b1vplwEWOPsVUtbnHX9Y3PRYwR1hvFUoF8v31YVrnwhdnXa+f3vCYMEhvICypjN13eu/0UCsGex53wp5y/kWkq6q/r+Wd1Gn6vyqrud4VSaGuUqr1Ljlajs4Qoo9CeAefXjShqGNkb86cIEeHYTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BiFsor6OzHveHYNaGjTP3CvCqczobLPsBvNix6V/LY=;
 b=j7TH4M5fYddVTVxoosRo62s01PQxHPKD4hQJxYmGGhMQZmmAz/WP/JBhRDx7DvSE0ZdhByKR7wfnROBsd18ehX3OrQ3hyK7f2l0py1zFQc3NBicOjmW7SGq7DJW/iRY80QG4bqpghl3iTK9c8ZS7RNKds141jogda8TGYIJ/boU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 21:41:14 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:14 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/40] drm/amdgpu: RAS EEPROM table is now in debugfs
Date: Tue,  8 Jun 2021 17:39:52 -0400
Message-Id: <20210608213954.5517-39-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01f1fbb5-b230-47e5-c32a-08d92ac6126a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12584F557FAF61F67EB8D19D99379@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dFVr6dSzutfF4CvoAVTyqAdGdvh1ozFGhAujSijbC1B0WmKsu/mRJwz5qhL9K5Z87aPsVXh4t7LDQGp0vE47bInl0uFbdovp5yJ93x95LUVS0W4LvqTJNZcCCmbSDzz0M8WdbMW8C4cBKYSPBydtuW/QYOU+kZQSpLti7jaCnTAFxpX/iBjAmJN6V9LMsAXWJh0WGs8b2y4W4BDUehd5BJWk1yToRFqEOaQW+gVl1PTKm/BEkyqpFxzRb4pye64xM49w0WNW4LBzDsQqJD+j/bJX3fuW1CGtEHE2QhDIHC2DNNHWtJ+EAhAXxoNy3KStLDVB1vNnkXEL+AFVznWBrJzrTNZcEP2FvwY5jgJk60QfiQGLEB7JGTRRV7HSP5HfAEs/YV6t7ZVxuGbPrep9L8zeg1+5WnJBkhMIehNFbZIy8JYgMkk4TLEwax8GCF9OqR7sCpfqxU9VKN8kO7NBRxAehVkiy75Rns7uN5fnqTZjy2XS03JYHfWAXsUn0ARbxdInZs5hzWXMoH4BCWg4qFrlE/pVXd1bRPZy8W+SpxKFmxvY9KJcLErlgWOMtMsUaYy+/EdAfmoEXKwgTVn2NBMu8I/38c6cyAUa5ez7DFTwhq1qSO58kzND+MTdVXfIHm3lrVFu9iCrhdfd6Ldj7QJ9qgVabnEhABOk+ra4Tn5BQQgfq7uYUlAPlfYD2NT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(66946007)(2616005)(66556008)(86362001)(54906003)(4326008)(66476007)(6506007)(8676002)(956004)(6916009)(38100700002)(44832011)(1076003)(316002)(5660300002)(38350700002)(8936002)(36756003)(6512007)(16526019)(83380400001)(52116002)(2906002)(478600001)(26005)(6486002)(6666004)(186003)(55236004)(30864003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvLTgeWIyNytizexws8Xdd1G1NbEtWbHxO1FSOwkeZteLdD67Ii8QtN2EP5/?=
 =?us-ascii?Q?1kTS4heA/Q2LPWJ/gqXRZLDXWh2wJRzXaJgqljOp43F0fsGQUP7yiqZ844E2?=
 =?us-ascii?Q?uWOZTX7LGONvkpG1fAWk41JMYxObRSpnB4rE6E/TeUCSFi3Jgab/HjAN22RJ?=
 =?us-ascii?Q?IgR1gk4ERl17kBqW/ycYsUcr5whXWUC0TJNLXW550hJFmnO2rMBEKqOXG9tr?=
 =?us-ascii?Q?jwVWXpjwfvrmkAsPPEMZw5yEj00vxtfvCeZlY4RpfkaBlG4v3eBc4o4aoNkN?=
 =?us-ascii?Q?gf1VY2CT0dLip5OEpZMolx06nmF4DSVTc2qQKXCw5PYuNyVgcTdaz1eetgxw?=
 =?us-ascii?Q?0HyUuI04GERd/itxGI8yn1Q1Fj7b8jJbsuTCqg031XGpdQsdr9XBLXloeTr8?=
 =?us-ascii?Q?m95urXoc/0BjVRojsy9ZCYSkrZ+GrrUZMrGRtFrOvNx3/7QVcSqJecL8EthO?=
 =?us-ascii?Q?wm9p7RO4q05ouOI5YWcu0so7VgmU6mWtvKJLlTTltSi6UHjRDprxi/GFPh2k?=
 =?us-ascii?Q?V+95DxAmnUKZu4HCtSgWynV9AhofOJUDUuNkmKSpXaCkU+5MCM+igG/atlrt?=
 =?us-ascii?Q?vbKfxC39ZaiI55RujuOvpxMj61tqd+M3yWMHb/lcI0bi8CXcH0iwVUJTB2Dt?=
 =?us-ascii?Q?2EuBb7B4IVQ9sUR4mskMTjUflf0O5mmwiOGu6RhKn7h3pktQeIB7+R6Ik64Y?=
 =?us-ascii?Q?c5gbNyoWNdruev4uhH8HcvkGQ9gbYCKnY/iBNBvlf6cHtepN/vhqqRdVikIe?=
 =?us-ascii?Q?8Mxyt8lzSm3VkTDbLKe+qz0tQIlKQ+jCnM8nrvh+wq28d9+1krL3CR6nYYQr?=
 =?us-ascii?Q?LJpERlP9+jeg3UAVCvyonGcU+3wqQIPiYzYy0nYOOr8/UQo8VcDn6ZUOwKOV?=
 =?us-ascii?Q?nQB5NoHVJg6jPVGxZI0gz1kgWm6iBUEvbQ4bGettynrQabwxFJSche0cD3qQ?=
 =?us-ascii?Q?95NMw8eOUIO+PgU7KOLVftfpyWiwgS8/Uu4jPhXHFVKwfSKVeW3nHPig2TJp?=
 =?us-ascii?Q?8ziTr1CWUaPX5kpm05coeDf5OufHBko179CkwHUWTLz12M7z2wSv2pmrjbfx?=
 =?us-ascii?Q?Dy9qa4hF93nJC+3e9dLEthdjXbfZ57UUX+TJCMXIFFHQOBvS1ezOy7PbSMgG?=
 =?us-ascii?Q?Z8FcPYv7ZToRcinAwLQZzyDHcSKax+qyAfeT52m+fLx1U/G1iZ587SifGa3j?=
 =?us-ascii?Q?gMjklwNFE9nKOMaIGZCzdtREmdX4lql/nLXLN3fW5WRc0s1wX2+Ba47A7tTt?=
 =?us-ascii?Q?id1moENJ3jJRVytTc4qznXH660+Ifys+5TWLBKag2C+Ndm7G0mQevd8KxZVT?=
 =?us-ascii?Q?mAAqqL0jl+dJYd+QvhHLZsxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f1fbb5-b230-47e5-c32a-08d92ac6126a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:45.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLwR8iqxy4aKzgnCI6YkOUWnAF2lBDEhD/ucdRxSk+7QICUjupHJ6XBOyflmn37h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Xinhui Pan <xinhui.pan@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add "ras_eeprom_size" file in debugfs, which
reports the maximum size allocated to the RAS
table in EEROM, as the number of bytes and the
number of records it could store. For instance,

$cat /sys/kernel/debug/dri/0/ras/ras_eeprom_size
262144 bytes or 10921 records
$_

Add "ras_eeprom_table" file in debugfs, which
dumps the RAS table stored EEPROM, in a formatted
way. For instance,

$cat ras_eeprom_table
 Signature    Version  FirstOffs       Size   Checksum
0x414D4452 0x00010000 0x00000014 0x000000EC 0x000000DA
Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage
    0 0x00014      ue    0x00 0x00000000607608DC 0x000000000000   0x00    0x00 0x000000000000
    1 0x0002C      ue    0x00 0x00000000607608DC 0x000000001000   0x00    0x00 0x000000000001
    2 0x00044      ue    0x00 0x00000000607608DC 0x000000002000   0x00    0x00 0x000000000002
    3 0x0005C      ue    0x00 0x00000000607608DC 0x000000003000   0x00    0x00 0x000000000003
    4 0x00074      ue    0x00 0x00000000607608DC 0x000000004000   0x00    0x00 0x000000000004
    5 0x0008C      ue    0x00 0x00000000607608DC 0x000000005000   0x00    0x00 0x000000000005
    6 0x000A4      ue    0x00 0x00000000607608DC 0x000000006000   0x00    0x00 0x000000000006
    7 0x000BC      ue    0x00 0x00000000607608DC 0x000000007000   0x00    0x00 0x000000000007
    8 0x000D4      ue    0x00 0x00000000607608DD 0x000000008000   0x00    0x00 0x000000000008
$_

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Xinhui Pan <xinhui.pan@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 241 +++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  10 +-
 4 files changed, 252 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1424f2cc2076c1..d791a360a92366 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -404,9 +404,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		/* umc ce/ue error injection for a bad page is not allowed */
 		if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
 		    amdgpu_ras_check_bad_page(adev, data.inject.address)) {
-			dev_warn(adev->dev, "RAS WARN: 0x%llx has been marked "
-					"as bad before error injection!\n",
-					data.inject.address);
+			dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
+				 "already been marked as bad!\n",
+				 data.inject.address);
 			break;
 		}
 
@@ -1301,6 +1301,12 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			   &con->bad_page_cnt_threshold);
 	debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
 	debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
+	debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,
+			    &amdgpu_ras_debugfs_eeprom_size_ops);
+	con->de_ras_eeprom_table = debugfs_create_file("ras_eeprom_table",
+						       S_IRUGO, dir, adev,
+						       &amdgpu_ras_debugfs_eeprom_table_ops);
+	amdgpu_ras_debugfs_set_ret_size(&con->eeprom_control);
 
 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 256cea5d34f2b6..283afd791db107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -318,6 +318,7 @@ struct amdgpu_ras {
 	/* sysfs */
 	struct device_attribute features_attr;
 	struct bin_attribute badpages_attr;
+	struct dentry *de_ras_eeprom_table;
 	/* block array */
 	struct ras_manager *objs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index dc4a845a32404c..677e379f5fb5e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -27,6 +27,8 @@
 #include <linux/bits.h>
 #include "atom.h"
 #include "amdgpu_eeprom.h"
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
 
 #define EEPROM_I2C_MADDR_VEGA20         0x0
 #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
@@ -70,6 +72,13 @@
 #define RAS_OFFSET_TO_INDEX(_C, _O) (((_O) - \
 				      (_C)->ras_record_offset) / RAS_TABLE_RECORD_SIZE)
 
+/* Given a 0-based relative record index, 0, 1, 2, ..., etc., off
+ * of "fri", return the absolute record index off of the end of
+ * the table header.
+ */
+#define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
+			      (_C)->ras_max_record_count)
+
 #define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
 				  RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
 
@@ -77,13 +86,10 @@
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 {
-	if ((adev->asic_type == CHIP_VEGA20) ||
-	    (adev->asic_type == CHIP_ARCTURUS) ||
-	    (adev->asic_type == CHIP_SIENNA_CICHLID) ||
-	    (adev->asic_type == CHIP_ALDEBARAN))
-		return true;
-
-	return false;
+	return  adev->asic_type == CHIP_VEGA20 ||
+		adev->asic_type == CHIP_ARCTURUS ||
+		adev->asic_type == CHIP_SIENNA_CICHLID ||
+		adev->asic_type == CHIP_ALDEBARAN;
 }
 
 static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
@@ -258,6 +264,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	control->ras_num_recs = 0;
 	control->ras_fri = 0;
 
+	amdgpu_ras_debugfs_set_ret_size(control);
+
 	mutex_unlock(&control->ras_tbl_mutex);
 
 	return res;
@@ -591,6 +599,8 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 	res = amdgpu_ras_eeprom_append_table(control, record, num);
 	if (!res)
 		res = amdgpu_ras_eeprom_update_header(control);
+	if (!res)
+		amdgpu_ras_debugfs_set_ret_size(control);
 
 	mutex_unlock(&control->ras_tbl_mutex);
 	return res;
@@ -734,6 +744,223 @@ inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
 	return RAS_MAX_RECORD_COUNT;
 }
 
+static ssize_t
+amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
+	u8 data[50];
+	int res;
+
+	if (!size)
+		return size;
+
+	if (!ras || !control) {
+		res = snprintf(data, sizeof(data), "Not supported\n");
+	} else {
+		res = snprintf(data, sizeof(data), "%d bytes or %d records\n",
+			       RAS_TBL_SIZE_BYTES, control->ras_max_record_count);
+	}
+
+	if (*pos >= res)
+		return 0;
+
+	res -= *pos;
+	res = min_t(size_t, res, size);
+
+	if (copy_to_user(buf, &data[*pos], res))
+		return -EINVAL;
+
+	*pos += res;
+
+	return res;
+}
+
+const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_ras_debugfs_eeprom_size_read,
+	.write = NULL,
+	.llseek = default_llseek,
+};
+
+static const char *tbl_hdr_str = " Signature    Version  FirstOffs       Size   Checksum\n";
+static const char *tbl_hdr_fmt = "0x%08X 0x%08X 0x%08X 0x%08X 0x%08X\n";
+#define tbl_hdr_fmt_size (5 * (2+8) + 4 + 1)
+static const char *rec_hdr_str = "Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage\n";
+static const char *rec_hdr_fmt = "%5d 0x%05X %7s    0x%02X 0x%016llX 0x%012llX   0x%02X    0x%02X 0x%012llX\n";
+#define rec_hdr_fmt_size (5 + 1 + 7 + 1 + 7 + 1 + 7 + 1 + 18 + 1 + 14 + 1 + 6 + 1 + 7 + 1 + 14 + 1)
+
+static const char *record_err_type_str[AMDGPU_RAS_EEPROM_ERR_COUNT] = {
+	"ignore",
+	"re",
+	"ue",
+};
+
+static loff_t amdgpu_ras_debugfs_table_size(struct amdgpu_ras_eeprom_control *control)
+{
+	return strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
+		strlen(rec_hdr_str) + rec_hdr_fmt_size * control->ras_num_recs;
+}
+
+void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_ras *ras = container_of(control, struct amdgpu_ras,
+					      eeprom_control);
+	struct dentry *de = ras->de_ras_eeprom_table;
+
+	if (de)
+		d_inode(de)->i_size = amdgpu_ras_debugfs_table_size(control);
+}
+
+static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
+					     size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
+	const size_t orig_size = size;
+	int res = -EINVAL;
+	size_t data_len;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	/* We want *pos - data_len > 0, which means there's
+	 * bytes to be printed from data.
+	 */
+	data_len = strlen(tbl_hdr_str);
+	if (*pos < data_len) {
+		data_len -= *pos;
+		data_len = min_t(size_t, data_len, size);
+		if (copy_to_user(buf, &tbl_hdr_str[*pos], data_len))
+			goto Out;
+		buf += data_len;
+		size -= data_len;
+		*pos += data_len;
+	}
+
+	data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size;
+	if (*pos < data_len && size > 0) {
+		u8 data[tbl_hdr_fmt_size + 1];
+		loff_t lpos;
+
+		snprintf(data, sizeof(data), tbl_hdr_fmt,
+			 control->tbl_hdr.header,
+			 control->tbl_hdr.version,
+			 control->tbl_hdr.first_rec_offset,
+			 control->tbl_hdr.tbl_size,
+			 control->tbl_hdr.checksum);
+
+		data_len -= *pos;
+		data_len = min_t(size_t, data_len, size);
+		lpos = *pos - strlen(tbl_hdr_str);
+		if (copy_to_user(buf, &data[lpos], data_len))
+			goto Out;
+		buf += data_len;
+		size -= data_len;
+		*pos += data_len;
+	}
+
+	data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size + strlen(rec_hdr_str);
+	if (*pos < data_len && size > 0) {
+		loff_t lpos;
+
+		data_len -= *pos;
+		data_len = min_t(size_t, data_len, size);
+		lpos = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size;
+		if (copy_to_user(buf, &rec_hdr_str[lpos], data_len))
+			goto Out;
+		buf += data_len;
+		size -= data_len;
+		*pos += data_len;
+	}
+
+	data_len = amdgpu_ras_debugfs_table_size(control);
+	if (*pos < data_len && size > 0) {
+		u8 dare[RAS_TABLE_RECORD_SIZE];
+		u8 data[rec_hdr_fmt_size + 1];
+		/* Find the starting record index
+		 */
+		int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
+			 strlen(rec_hdr_str)) / rec_hdr_fmt_size;
+		int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
+			 strlen(rec_hdr_str)) % rec_hdr_fmt_size;
+		struct eeprom_table_record record;
+
+		for ( ; size > 0 && s < control->ras_num_recs; s++) {
+			u32 ai = RAS_RI_TO_AI(control, s);
+			/* Read a single record
+			 */
+			res = __amdgpu_ras_eeprom_read(control, dare, ai, 1);
+			if (res)
+				goto Out;
+			__decode_table_record_from_buf(control, &record, dare);
+			snprintf(data, sizeof(data), rec_hdr_fmt,
+				 s,
+				 RAS_INDEX_TO_OFFSET(control, ai),
+				 record_err_type_str[record.err_type],
+				 record.bank,
+				 record.ts,
+				 record.offset,
+				 record.mem_channel,
+				 record.mcumc_id,
+				 record.retired_page);
+
+			data_len = min_t(size_t, rec_hdr_fmt_size - r, size);
+			if (copy_to_user(buf, &data[r], data_len))
+				return -EINVAL;
+			buf += data_len;
+			size -= data_len;
+			*pos += data_len;
+			r = 0;
+		}
+	}
+	res = 0;
+Out:
+	mutex_unlock(&control->ras_tbl_mutex);
+	return res < 0 ? res : orig_size - size;
+}
+
+static ssize_t
+amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
+	u8 data[81];
+	int res;
+
+	if (!size)
+		return size;
+
+	if (!ras || !control) {
+		res = snprintf(data, sizeof(data), "Not supported\n");
+		if (*pos >= res)
+			return 0;
+
+		res -= *pos;
+		res = min_t(size_t, res, size);
+
+		if (copy_to_user(buf, &data[*pos], res))
+			return -EINVAL;
+
+		*pos += res;
+
+		return res;
+	} else {
+		return amdgpu_ras_debugfs_table_read(f, buf, size, pos);
+	}
+}
+
+const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_ras_debugfs_eeprom_table_read,
+	.write = NULL,
+	.llseek = default_llseek,
+};
+
 /**
  * __verify_ras_table_checksum -- verify the RAS EEPROM table checksum
  * @control: pointer to control structure
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index edb0195ea2eb8c..430e08ab3313a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -29,9 +29,10 @@
 struct amdgpu_device;
 
 enum amdgpu_ras_eeprom_err_type {
-	AMDGPU_RAS_EEPROM_ERR_PLACE_HOLDER,
+	AMDGPU_RAS_EEPROM_ERR_NA,
 	AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
-	AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE
+	AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE,
+	AMDGPU_RAS_EEPROM_ERR_COUNT,
 };
 
 struct amdgpu_ras_eeprom_table_header {
@@ -121,4 +122,9 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 
 inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
 
+void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
+
+extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
+extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
+
 #endif // _AMDGPU_RAS_EEPROM_H
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
