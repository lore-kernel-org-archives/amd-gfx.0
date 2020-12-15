Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B17C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 10:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0F220888
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 10:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0F220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7086E169;
	Tue, 15 Dec 2020 10:23:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96A36E169
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 10:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFEcEAgqzAA9dOviIjM7wyfDj6hQjsDNVx9X/pgOjrIRJa+6nZC6vBAkNiqiQNAmkHc+7lZr5rliVddtKLDeEm59Qb7TymGbxbAmqLv8+Gngbwie59oTidny8uoAxy5QDGORo9FLdzF9ZKsTGNL+4x6LnYzAUKIQieo+mIm6xYK13WIMGwA395+xmKmsIxoV+EdVfmRhqpvsoDao8Wp85lpY4sfSU8yFnbTAHLA7lk9gxNEt1KwNM6CO3lqrqsmTldJMBDQZgexewhy/03hiUTMcnlXeCqrt1HpeMEIteDCY/kgs7cPHFOBT4PK5S1eHYBEDMda8sRxsmWvv/eHTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEGhOZLu6j5Lqy26G8bDppsQ6i6Qty+xQVFtdXGyH84=;
 b=hNsd/tZXsh11mDeruC1ZMEH7IG6asX1BX6AdN4s1ezdVRASFxsDNB6vVGkeFOnGVpx8FyMip27ubx9OlI5XWMOwUC4HO4kok0aHgE1eBlucCQOX++hron2m/1hi8LXnT+mFw02/L+kqcg1kgXISKO+JJccLyumqBYEps8BOZS/POiywemsoKaT2G07NXLs3tLDdxm22FbNnQKIbmdqPm3Vw5CmbXwUKyKS6Cfln4NZaXP9c3wPgD1HucE4DptQq58VZYIOL1un/ozSQVn+uhu/MFyzbU7NLIeamJE/zrtex+M2dAgvxLfYQkJTrpVtmSwQqHVc66a4PWRgF2RI4UEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEGhOZLu6j5Lqy26G8bDppsQ6i6Qty+xQVFtdXGyH84=;
 b=13DtiRTpDXuDx6tdtf3kodp1fmMW4duw2oLtJXDSs4igvjp9m7mIbBBlvbdvtbQSN2/unHLIqxKKQ3twnjJ1n8rhz7inMlFN7trdUSaZlKeRY0iwwPbchqnMiadGdMuV/GFEnsN6a00u+OgVtkzPH9wYnHSoZ+xB6ZLgnhJHLGE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Tue, 15 Dec
 2020 10:23:39 +0000
Received: from BL0PR12MB4961.namprd12.prod.outlook.com
 ([fe80::b520:3528:f738:8006]) by BL0PR12MB4961.namprd12.prod.outlook.com
 ([fe80::b520:3528:f738:8006%8]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 10:23:38 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cavefish
Date: Tue, 15 Dec 2020 18:23:21 +0800
Message-Id: <20201215102321.20233-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To BL0PR12MB4961.namprd12.prod.outlook.com
 (2603:10b6:208:1c9::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.12 via Frontend Transport; Tue, 15 Dec 2020 10:23:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2963992d-5805-472f-2522-08d8a0e37d0a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4929:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB492988FBABFD0A613672C1D5B0C60@BL0PR12MB4929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYrwwVTBi7+SpdCJrOsjIcg2RwzvLPbtVdl7SQ7A5HHz6t+tqPcGOVr8EC/4Q0e9b371LBxtBnqb5W8bHO9w/LLT1DDonYn6d0nKTEBVNRH7kzt+KjOVtbDSGEyAwIoWBeTE2FENWw4c9K2QOpMUMWiq0Sdxe1HxLaYGLfl9PT4GAcOiW+DC+3DMy1+yN5NCvdFUtG1EToH2NBonia1xSlyFnzS5U8edB/73NoEepHMT3Qs2lGVMbfSitqeHTzejxDw8NU33u79ma1Y/FJeobM9QTj/gRTL5FAM2Evn+xQnjHw64TAyTARcQVGvrKHLkSwo7dcMVbSEU40vEXM1EjDvkejh/evbtpMhWofvjnfa6RAJMDlzS/Yk9MHOzxxVN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4961.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(2906002)(1076003)(8936002)(34490700003)(16526019)(6666004)(186003)(5660300002)(66946007)(66476007)(52116002)(7696005)(956004)(2616005)(36756003)(4744005)(86362001)(26005)(66556008)(4326008)(508600001)(8676002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+7UPl2xWGXF7B/EfMBJjj0Lbyl/dCe3l6epQiBRxQ2UfzM9VrRQ62mMOxPuT?=
 =?us-ascii?Q?WbQ8bSNInZDH00XEsOFwr79GLM9l5Statq4o1DMQXUaYVVPPT+LamhF1kbdo?=
 =?us-ascii?Q?ub6gLZtGwtCh2XFj3WL8FobvztZ1TgIipYdWSe0HnAFAFSN4lFBxo7T51LxG?=
 =?us-ascii?Q?lnEZ6kVVN7EVRLxP/E81G/+hZXgT1aZh35pOXxhEzxwon2o+1pthyA2tT4E0?=
 =?us-ascii?Q?6H0ggua0fhpiy4qD0I/7p6mCdworaZYd7K+TiDXi3x4Bf6quciLGyX5Bi+Fp?=
 =?us-ascii?Q?Y9omS/Anc0ds+klSt7aBBXsh62c+1vzzfi3S/u23NkYe9xqor1dy4GjmTens?=
 =?us-ascii?Q?vOtZv40KP2qpxz8+IL6j47LVJZp0myuP8QDprlIHvbwnKFUzD3TlWe2//IHi?=
 =?us-ascii?Q?0gRWxjOiQAPoZjuV6fWmSfYF/FtW7hR1uR74kAuPtXKB9dg9Ec2glx5a/iCg?=
 =?us-ascii?Q?b+nhvZUD3/9LmhQR/fkeGnFV6WswQII2kc+2JVVCXJZ7MgzTQKQJQW+ePLe1?=
 =?us-ascii?Q?wWP8/JFq180M6tIGOGzXV2NiEUfsrnr9LC6vKVt2HxlgPo+XHKxbSyJrYD1+?=
 =?us-ascii?Q?WBsXcd6g+MFRYXjRcn9dzu/pkWOKpy9tQtsMdC+uD3m1oQeVuVn4bzXA77N/?=
 =?us-ascii?Q?uNdS33jZRC1DpzTK3mRrD3WYTxGJSQGjcbVNc2L9Y+Bi+8G9i4X9XWWpkkMM?=
 =?us-ascii?Q?NbhH97HSJf1/myZRL9+C1Hj2Iv7sxGZ47M7Bkd5TltT9+UW+fpw2FHfN0Vsy?=
 =?us-ascii?Q?MzKHrX9pBLuCT50um7JpvbaeNP0tdAi0KY3LHF0lIy0USF0dk19/FJbBSNoc?=
 =?us-ascii?Q?NsKLspy39TVwUunDlr7/X5t77gNIqt+6MDUXErJBXGDU1su0Rvg21ZU+ySC0?=
 =?us-ascii?Q?GSs0jt+EpDe3VcMh6KNRn1s0oSbniR6+0tlFiReTfv73ybLcaJn3n8ak7Q+O?=
 =?us-ascii?Q?txyOtkXGObpkAnOXTpv2O60xxw8OuC9pwRh3gFCwwbI07EbGZW/D301R9XuO?=
 =?us-ascii?Q?PF9V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4961.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 10:23:38.6900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2963992d-5805-472f-2522-08d8a0e37d0a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmh2ZD6KZQxNdumoV5hP+BR/4GUXZ4r/Lir9gARAXYvu8B5HrDgCxmn66A0i67Jq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use mode1 reset for dimgrey_cavefish by default.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ac02dd707c44..6bee3677394a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -362,6 +362,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		return AMD_RESET_METHOD_MODE1;
 	default:
 		if (smu_baco_is_support(smu))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
