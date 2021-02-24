Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA00C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C175F64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C175F64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E3C6EB53;
	Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8626B6EB52
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EScUplOGhZLmU7T16PWaeYTG31OKX9x1dDzr/pcOBb5VtLXyFsWzEeF+822OASG0gySejy7rkdUPKB2oMbNc2NIuOPGxESY6sH51/9nZgshxiCGcl1YmME62of6nBW8ApD46ctosscONN5Y9XkSYtf3JTy1doe1QW3gygkpYyWPZFbb1IZUfXcHs2BXjoQaJmYZkk2Tpmlt9ERCBj5my/XWTrduVQohyqvJk6s7L/QWyof934/S/8AVHte4lHxnbC2jkybgRkTOyAL87y1dxMl8GC2HD77g7syPnHisYz4pJ2u2nz0riiYSTY3J+BKyqRyxQ616dM9/eqOJtjL1grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCw0mVpqpzVDkw/gFY4abOHlY9Un7NAR+eQCZHWSLpI=;
 b=oQpb8VKFgPTJ9wIRRYfDsOQple3dbFT1VVoNC1bamsfeZ7spLh9AOnP0BdHvWBiB9bd0gpOZLqZoIWkymqwK34mf041AhNJmGVlOJlRqfUJv6Dbsda8a9woUxcGD0W4uuMlrBf51ly+10Y3bwgn26M5e9DgBQT6Qigpem7TsiJsRbYCSqKQ8xl7qZ9VluTwCfaql4UofVcRGoVMUxzm2KinyrQW1/zh3UVLZHuy75WkG6PmuCn/Qn140AbQaI6KB5Kt0j7ImXD/8cGk2w9vqhSYMojL2hWtL+TZKImiAvYChWUml9hHtCmyvApRnF0lxUiLQIHeLxgG7zIhCzwlGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCw0mVpqpzVDkw/gFY4abOHlY9Un7NAR+eQCZHWSLpI=;
 b=aj7dGGwrInLMbj9qMJiL4AChNGrn91dBPOLL0/2uKMlc8FOzxOI27nWtVs2goh3efDTtzu86tiSDglCk9vC/4vpxfjQMXaMspHKpzU1MZT6mgGTrJkgAgpfSVK9zIhVYHtOpYMjjjQMJ1vyROktnE1+AKjpKAwbQW63yDVBhaw4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:01 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 069/159] drm/amdgpu:return true for mode1_reset_support on
 aldebaran
Date: Wed, 24 Feb 2021 17:17:29 -0500
Message-Id: <20210224221859.3068810-62-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c3b6c2b-a9cc-4dd3-09c9-08d8d91257a6
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB249738C0BF2C60C8D65C0728F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2bT3VblTTeYuqevzjt937+OqnqiMrnY9dG4sGAaCWCOd/ltpUY46t9a3D7uxyVGa1YdMnVkVihY8lr22QmLGoL8a9zpAoy1XCYJ0A3+bUU/7g8UHotDoHoVwdPaTRM+n22HO2XArwqAw3D/nlGrItw55pIiZyabE9aabkNNG5gqZhPj5X75eU661jfWkx16e9u+8AhohXHDctpCKaipuJXqfsPfLt5n8mLf4q+bGr4iO7EjoSMDS2MGvEhsu+n2H4N6400tAmekXtbgZSdL610tfAvp7S12sJtruSDbHsqaJW2bXKN907afERoQB182D/68JeqYnWK1swAH5+q7HfWbHoWv+68xr3Sjg3wSKeEkvi9RE19TBkrDAsUAirx6KQ6MgRI8a7wuqzT9Woocr76oH7LE1L9ae+5JoLhw/UVmoDCvwpP7dX8LFmTzG8PtLV3DBGeKn8PC2Z3m95wuY6gJSzgjIPpRohBOzeGcg4oOSEV2/pk/T52OrStQ1z0E4BTWnRGnX9hkTLstngLS0F9SyaDX9kg1sKIoCBxqXvpeBeJgBi/3dxeS71C9lgATzgWEc8Rd2rOoOVw0pgGOpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TVX872aNVve0EqqEPv8PsD3Y6IUNb6IxCdsIoQy/szJylQxTKu/pJq/ycT1k?=
 =?us-ascii?Q?zSPQ+HcJSZJ1/qlbbzMbUZKIgfbhyYg0aspTXPlSXBaLv7Tq1S5ENExe9mkH?=
 =?us-ascii?Q?eoFvdx9JZCdC9p1scp/75m73LD91O8cH5ATSXiTfV6CiO3iCEjgikGiLfHZf?=
 =?us-ascii?Q?9mX8kh3pIDy2l1k8y0KBqystwtYumtIRK8Cs+UunS1BBe2wce4VofXgx1NH0?=
 =?us-ascii?Q?YPNNlZD7qI3LDSJ1NQ1G7lpz1FENd2/vrX3d1cRBmUx3YIvGSCVz7zsnCC1d?=
 =?us-ascii?Q?zbkiNtlRYSc0j4EJQcfExNBeRxTWmV+PCKk4yQkyn+BhBXY4Nl4gG9rUKqVG?=
 =?us-ascii?Q?eoN0XtU7hIb7B53q55QAfYdQ0a8icOcQ87RkLcwQCxpJ4HBNG+k8NCo/Mu+i?=
 =?us-ascii?Q?/m+0mg5l6PEMgOCe6blfDONhTqC4pwg0xE4fK8o6C2slxqlkL89BX0q64Nl6?=
 =?us-ascii?Q?cDrnyxhVm07ymWXieGX/lRxPoLdKQTv+F8Yo+v4Y2hl2xkk1+OJiKi76fpjb?=
 =?us-ascii?Q?pMIhT/iMsQD6NZDwaymrQWq6jMsKFIgN0Soj3UW6KK34jVoTBsc3vnQeS3vE?=
 =?us-ascii?Q?Fwoh1e6n8lPY6mJryC+2iMBr7koKsSrJy2EGa3oNqv8UEeRofqV/Nwmou51I?=
 =?us-ascii?Q?2/Sf8RQmcz1YEHJBkpW6yKJcyjfhLNkcZn305AJyBWJ28KKGGbTaugDeAwE9?=
 =?us-ascii?Q?iwmPNA7SPLDTXsRVF/BGmlyJqwoOD+RunHtIo/HepwOj1YSuAyyLwsy2g0gc?=
 =?us-ascii?Q?FvNf85zDFLNwTNylcpT27H5fZMwOa5kl8Ds+LZ0v1S6ZxyYQYYrBDeRRnCgi?=
 =?us-ascii?Q?21gG1TlOI9i9pwngaZxyEK0fZ8nRA98ft4xaa4EpaQmfPi7evLjm48UOD/YX?=
 =?us-ascii?Q?crL+44hY13Qga6xIq1wrTbqHBzOFlZh60Iv23Q2tIFjwZPSWEmacnsfPvT+L?=
 =?us-ascii?Q?bYhIhNaVefYGEjOYuwseQHva8SIG775MVTJ61ObBAAxqvBaSzrM8WpBxYFIq?=
 =?us-ascii?Q?AfaWMV9kz6/Zeq6pbhXmnzhOKagBZvJlx5/rlcu2v/PVQGx5yBVa4KVXQ0GB?=
 =?us-ascii?Q?KyUvRQOUDpiEkPhAs7n5FsISKPBQ3lTlIhDY7z2PncTx3KdFXYnOGGtRDz9l?=
 =?us-ascii?Q?nKv+/6ehdf86ScgXPHYWGh5QCRiBFK0nI+1C0PnWYYTgO+NiCNCDR7GX/7Se?=
 =?us-ascii?Q?8Gn2W+4ufSsS29ngEYLkN7yS42UxNC/stTCIwOZelaKtUxsG+2ePCBMk9ZZX?=
 =?us-ascii?Q?a6e56sPY0ttzHqJQv8/wvcJW/xhLxzISzGBA6Ira5MuTS/scK0HPnB87Anak?=
 =?us-ascii?Q?8xzG+L35i1lhjp8RPJ6J3134?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3b6c2b-a9cc-4dd3-09c9-08d8d91257a6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:07.7944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8/BfcRhoP3NST0iYgKLwS3KlCiSZdD0XwroM4KFD4jQAH3oALu/6S/8+HgrUPTuPvBwrlEg8ZOhx0YnygIc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Feifei Xu <Feifei.Xu@amd.com>

Will remove once validation finished.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 475bd5aff6c9..079b5dd719ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1253,6 +1253,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 {
+#if 0
 	struct amdgpu_device *adev = smu->adev;
 	u32 smu_version;
 	uint32_t val;
@@ -1269,6 +1270,8 @@ static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 	val = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
 
 	return val != 0x0;
+#endif
+	return true;
 }
 
 static bool aldebaran_is_mode2_reset_supported(struct smu_context *smu)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
