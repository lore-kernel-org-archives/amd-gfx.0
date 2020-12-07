Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7590DC4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 09:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364E323447
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364E323447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D551989DDD;
	Mon,  7 Dec 2020 09:22:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690086.outbound.protection.outlook.com [40.107.69.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D04989DD3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 09:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhEpp3oQH1Vv/QS5eyJRZ8zdqYFgWeooHvrg2KT8mFo6PBPFx9YQKIMGs7RnQVqmwFWijiDlp26LyLH94FIiU8tisWgjLW8hLStSEdfAN9QdEjlRCBlOoY5lFun+mdwJzDBn8kH1InN8KxBC4mSXG8swnG5k5KVK/rfhHrO+qUt2qPHkVz4v0PkLdMTCCEp6RoPKlbSKG7QFHMa0xicnJnt5122wjcVtllrw1B8z7nJ5IArEwdYvgSd/MsrMjsCUwxCgf6fS+/S3GugICsE3Ob+M2OoCQFrUiNbcPR6afT4PNgZo1mYAdCA1JuwFCD6vA45GrEiVpC+RJZAmC9Umqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H3ifpa/flD1XPNhTY9yothAtk13qqyUpdsxoIVBoZI=;
 b=V/XgJ08GxEKh2O3ZSeHtY5k2kqrvOaYSX51ybMaQ/IQQtJQPNgPO+k4YsB+XhRjrl+hdBH+xOFMZnfRNMIczYShsEMxIuEdGTR+PHCyVwqNiWOIPWHDuc8DZVD/3YsB3FXOH+WxfxR0dYxggu9jDeAmApHk11h/MasxmiFnBAyrklzHIjfMUSTeuu66c9SEwYC3X1E5DOo5TN95UhIxYUDp7uE3Jqmd0o+z5x0vwsQ55IEy0jyEfo+iN66PTIzL4v3ek7mwCpND3AX5p/UxnQIzpq/LYIxynjh4HAu6WCmUjdg8kq0jVhCnL8+yFygSNfrAQUTyfGM2abB+ylszEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H3ifpa/flD1XPNhTY9yothAtk13qqyUpdsxoIVBoZI=;
 b=Qwr66kaQvPosymlGOyTwkuJxobOtH+sKPPYHAIPjGsAWPFTR4VK2dfaIhAHZuTBCCFjJRp4bnHinX0uBCVNGzj34xLy54dnojcBxNUngvI8HatLJKgg3N9sL+GuRG45Uvkdqa+k9Bx74BnsuaP1jleaFrEiASiRYx+BMiBg8Xr0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Mon, 7 Dec 2020 09:22:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 09:22:52 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: support power source switch on Sienna Cichlid
Date: Mon,  7 Dec 2020 17:22:31 +0800
Message-Id: <20201207092232.81415-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0117.apcprd03.prod.outlook.com (2603:1096:203:b0::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 09:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e11f5e3-a7c8-4cda-777f-08d89a91ac43
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4075E96200795B921D43F851E4CE0@DM6PR12MB4075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:318;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6Dt5T2i/SjVjDL1PCJdV5j8Zw6dMy1jSv4MPrG80sssLvh6zw3L/UPJqKdiOWy9lkr1F1cQVaUQNhtlaEz5s883cUfVjfpEAjLGwBLVY8xdts5fKfxhffqWT1Iqearq30WhQ0+NRX3qP+Aopr//+X40XURZXufvZYYIcuHls68KWLT52+CrX+A3prBwCIomkYNqrHnTNxW82PPdfjB/lqj7TnHsncwa9jPsPGTYyRbTrx4I8rOZXygUl/qsk/CwNIJN/NuBCV6woKhT82uak+KWvBOdbngPaiCpArFDRsT1gXgUYFH+G4PQoyA9Ksglw9Tj/oW5Gc6e0OtyHUYndg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(2616005)(8936002)(8676002)(4326008)(52116002)(36756003)(66946007)(5660300002)(26005)(956004)(316002)(44832011)(66574015)(66476007)(6666004)(6486002)(478600001)(2906002)(6916009)(7696005)(16526019)(66556008)(86362001)(186003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7NRd7a1wByTN9fWQWZYzbygCygqIktBDsuuymDskZ1sQLLaz4V68F7qNuA2z?=
 =?us-ascii?Q?51H4cxDirN1OCJo8JN5q2LRl4Q/sRxiGO+6Ua4UuZ/HmnCWa1xq02s76kTev?=
 =?us-ascii?Q?5CZ8gkraWeubfYDE+wwozFsusITp+oqO8jpnpATkmJ8AL9svLlTFDCJJ3Gy1?=
 =?us-ascii?Q?6rMu9X8Bm+4F0P76kkL4x37FOLqBKKZ/gay1QYvVN8FstFk+hTXS2G+UO9Qz?=
 =?us-ascii?Q?6U9qIj/wMGzhdNJDPPFaSN4tFyvdAMekc0ETPwLJzB1XGzmesvTMd65P/F5z?=
 =?us-ascii?Q?6AyGCLyRRZ86T7Df6894y3pRRr8SXGFMcpUDro6l06GCOFXt8YuahB+ZUehf?=
 =?us-ascii?Q?Pr0klY4bQ2B9R2x/lTanDBHqcAQY3Gmm6YU5C94LwgSc9jH+Q7e2/FprC7c7?=
 =?us-ascii?Q?QVj+/frLsk/CBhtbUm0vgjYbTGdM1znKv8Qe/aHr9I14iP0ZUToxZ9GqWT3Q?=
 =?us-ascii?Q?M6gdhudsgve5YqocevNesVuDPvzh4ZI4lZySgczfIzo8yXvRsbb03pKZV4d2?=
 =?us-ascii?Q?pFEpPeEj5muFf6QFyJhwdznIPKLCICqKRQUtfrDESPVXrkbX8dM3lRYqgnjw?=
 =?us-ascii?Q?w9THtzAyuU5GmweQRjL4fjuJ1rOdNq8NGM0juzD3XoU0VuOaaDjqkjWKqrDB?=
 =?us-ascii?Q?/OFiy0BDgIaLxgNxRz2JOvcZttHfpyKiKV1nr0xDD2FmOYqyuXQ399ZkNLz1?=
 =?us-ascii?Q?KvVIxFc0gdbC+x6MJaatGpwgUOxoWGtKbNbfjB6Le+gIa+ZLIlAvPNzpkse9?=
 =?us-ascii?Q?hVaG70bzfIxU9LGgIuTYRxF7FAcACjuSI0mP7xYqWMaui820fyC0NfgygD33?=
 =?us-ascii?Q?NCljz83Ot1T2YBEeUblCZ65yIwvgxKDzRSRKJJYvy4rPXa7MyTOuLc6tISV9?=
 =?us-ascii?Q?xC5mum8VZFZJIMBbUG18znSY0l4ZvVFXijx/9ICl7bLG/lR26fzANqVbjS10?=
 =?us-ascii?Q?qIof2ySA76acafS5GbNJCKahNUWhzoTdvzPAOkeagUS5M4crn5UVQSuMaCbD?=
 =?us-ascii?Q?9DA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 09:22:52.3203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e11f5e3-a7c8-4cda-777f-08d89a91ac43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQMGSm66iWAaZl8gHhH17/91GUWUrUhbBVTlt8O4rxQXwrF8ICRgSh/dNtSKO8P3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable power source switch on Sienna Cichlid.

Change-Id: Ic48821c61f3f1f65f7f5d78bac28e11ce400b4b2
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 84251f4826e6..822ddfc42360 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -354,6 +354,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 	struct smu_11_0_7_overdrive_table *overdrive_table;
 	int i, min_power_mode, max_power_mode;
 
+	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_HARDWAREDC)
+		smu->dc_controlled_by_gpio = true;
+
 	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
@@ -3296,6 +3299,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
 	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
 	.run_btc = sienna_cichlid_run_btc,
+	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
