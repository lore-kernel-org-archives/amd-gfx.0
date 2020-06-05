Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C19DC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 13:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127B7206E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e3Zql1Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127B7206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEDA897E3;
	Fri,  5 Jun 2020 13:04:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A05897E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 13:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBvxqu67pgp2ir56ka9fnYgoVfvtWl3CrbFnvrl6c8AQ2CvB3EpcjUHMyjU58Q5MH+qqkFC0qWr+AdEJ4uZRWA2yW7KkpF0dq5taT45Ad/aL23N6vpicM1ax/0dsDTva7TMwlim6EZH5etORPsV1bOn/rzEE0Jb/v9qHH0/8LzkNe7hc3+Eeo0xxRCx7uvQ1nhED/oA9tCMpdgspnLuRSa/7NNNysC8TjLomTRl66nVoxnCHwixN/rRAx4lV+qYicpz/S/QObybU37cQ0adeBc/ra9hdij+AFXuakYYxUNyzUxbupfq5svzjwPh+T/2NaT2V5pzEIPDVR2JT8deTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/0kXUkwa/TflCBNLKeYDh9qz4QSwdMeM2Krl+sgDKI=;
 b=cL7RzhYhUN363YiyZn736ac5njfV6pTfdalEyoqWj1jEeXzS9aK1tAVQwkdj8JW0rO1KwjDR+DAYSi2yjxLjQniqzGcey//HlBBEgC9tRKabUroUeUeSTJqB6d4VD4tzA6cgVX4UoAZJXN977DJiXNu3YEJG4tnNhrm+YT0IPg1C5iADdMjeY3IjdUZXwpYFjVvtVww8ziEDv/GT8fQ4zQxeZc8lXXJPq8EgktP/7BVk2QcdS+Aub1NFnQqI/itFEIqmUd2ZibsMp0XVgDhyNNksst3xkt0IG15gzar8fWXH+j8xdb+Enb+78DPxqzxm3syx4moWjyJaCBKrxMRfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/0kXUkwa/TflCBNLKeYDh9qz4QSwdMeM2Krl+sgDKI=;
 b=e3Zql1Pes9zC1ms9IZZlJpVzlnAtZGfmjaYdbXdsa+C+Mydtd5PRjOTNDMmyW0Qtd6zXBPUxTQ+NrpC6cS1WKU6tpFYFBfIBOBbiiqUGrye9skQXlOVkjVSc+Av8SZEIjHveuOrtNYc9cxMgIlysddpiLVIn1iqfp2NQqTr8S68=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB2485.namprd12.prod.outlook.com
 (2603:10b6:903:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Fri, 5 Jun
 2020 13:04:30 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30%5]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 13:04:30 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Date: Fri,  5 Jun 2020 21:04:12 +0800
Message-Id: <20200605130412.202089-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR02CA0180.apcprd02.prod.outlook.com
 (2603:1096:201:21::16) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR02CA0180.apcprd02.prod.outlook.com (2603:1096:201:21::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 13:04:28 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d84a3dd-71de-4d49-ce06-08d80950fbce
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB248586F5B96E2D771472F45DEF860@CY4PR1201MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bba6fNe1d24hiCnRxEoQSQx/PKw29XVGCNsva9nWKsMyZdmfu6cowzfvRabBGETzTGa6bBmXRqbGk5Zx4X0O1RgwixV/EBTqwQAyogX3JqSKu3F3net82+7+hgn3m6fIVwX0SuVyATBNNG67AdBf1FRV5ysGsacWPHyP+dtH5lmMoua+eMhPXN75iNXjA4Fiznkc34SUZOC1MKZpYMSTRzzIH2KlKQoWzcFDILzvP3JurS5e3bhwIXNvSnNjbzdP2iFLxCnHWaI9hPktzVTk8gukkXrZc/UlOB0RgDbpebfd8uZCnZritoATrjv3O04A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(6916009)(26005)(6666004)(6486002)(956004)(44832011)(2616005)(5660300002)(478600001)(8676002)(1076003)(16526019)(186003)(4744005)(2906002)(8936002)(66556008)(66946007)(54906003)(52116002)(7696005)(86362001)(36756003)(66476007)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mye5uiCgVUIfSjthH/V3Kywv30WqYXS5wARmwot0xwUe5kORuMhh/2Zrp5rblVWRWVbtWSY2eG7H2vnHA42/cskZ1UEQLizqmuqjXEP8gbCmy1JQBLhAE8E5zTV32WdAbpI1S7J5onpB56M4t4C71pO3YQ7kEzIYRLRJ3HdFh1rTOu/JhSmuEm4rEiZstGFMccCIA+idXfIfPPq9k82FDUZrpIEgdgncnd5RAyAioGQVaR4Ej27PbHycNSIytIVt+aSE0FQsxR7G9GNE3h1MGXFI10EoxNskGfp3+L1kay/3CV4deu7FZ46Z/ZUA8qXCEGNYZBmX0Duq8E64wndiSYD1Kom0vowUDFnQZwyBGViceQ0V55PZFqeiV43xRY9JXKpOxcPCN8MqbAjGtVxtfkz3eeyABXpJwoa+Avnsepq7Kh+3PBxN0VuRYZ3H4dWXf82WbpUn30VGzMOXyaEe61uasyQXD/WYu/R0iaADv1rEoLoqY09JIxsn2p8MITqL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d84a3dd-71de-4d49-ce06-08d80950fbce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:04:30.3081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwryDQ/VTQjqINAcwT3aZF+CZUNXE+F008e2nobXkN61NJcbVNcZc2dJ+BLLMsNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2485
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Skip for reserved fb size query for the ASIC older than navi10, as those
asic do not need for TMR region reserve and may get an invalid value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idbc57805b8070f27ba6c3cf22f1892d6dab92f06
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index a9adccfda4c0..e2a64ae7bcaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -603,6 +603,9 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int fw_reserved_fb_size;
 
+	if (adev->asic_type < CHIP_NAVI10)
+		return 0;
+
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 			firmwareinfo);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
