Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3AC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5138264EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5138264EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208D56EB82;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F412C6EB79
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAk+OT3Dqdiesm1kx5RzyuRvyQJejLCxYtgfIXoTs2awLWcYMoaBmVOSz1cm3Hw2TddDjd7NPeaSVLZrArBw7tVLMde6pr8f+TyM76n2t5AMnc0Vn+H57NyGC6pI6BnZ5odjkji2xKeLCTZ03R9JsRd4P4YUSLJSzi1pHd/Sn3MnmOOld1uNUkmfHLTTUWAj5rp65EFBAToXN47Isqse5tzxVeRylZWEoL035p3lfrOCl6DfRcn12LDf1zrgFVi1I1NmeWVH0uPK/H/6xEe01X0lKup1bu8IC0mudR5kMx50aT8tKoViHHHGO7jLbUolZqRwqZ6Kgc/JL5soO9T0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeo8gCBQAIX7WmwQoQWAL3g/KGkiIMp05JtynqCdXPA=;
 b=HWJM6Y98HwSAatIXVj5MRQckQEG5xBfYo5jWOdZrBF7bJjpniYJbM/UJ5tm2rn52cRteqYXLC11cZoBqw2PgaVH5CsQMu2zWSLuIxWBkk/Ejge1g7ZtLg5XvOWFBdABuuGJSxaFlkledw3FM+TZwR4rSFK3yJCl1/iaFtj6l2GXrmhH0Vh+IF7kbP8Y7vci3tsYf5QBuCVU8ksiP8k0YY/Ir82jvK4Tyn8vCNyi6uwg13cywUMT8Xc+K59HwYCq3w6cWQA05aZ1HhJlxeWFeMSNV2UNmQQ5E5wRTo6YnIvSJ4WcD73TdaokETPKo9824E2gHWe7DLJfvsklssIME/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeo8gCBQAIX7WmwQoQWAL3g/KGkiIMp05JtynqCdXPA=;
 b=AJq406u4mdQGUoxPi4CuiO3rmB2iq9I7rn4BG5X4TcjllWnnKI2pRDlKtAghAQwuRhdTS15Q6Hd5uAQcUHQHM81r0B/8JvdtiP85Eo1A++PeAJUeqSkHqU7MAXOesc4mBUqsD2xSwvJ8da13fYt4R4NnFr0yOoKnaUyTTXvu9Xg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 112/159] drm/amdgpu/pm: Fix reset message mapping on aldebaran
Date: Wed, 24 Feb 2021 17:18:12 -0500
Message-Id: <20210224221859.3068810-105-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfc5bc64-23b6-4fb6-3d25-08d8d9126af5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40463DAA468FFD6E177CF641F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2h0GmMVBqqxVBztyVRCCwSE1cXgVw4VOXHT9nR78lOhTEY8U0Nq4fqfZJER74qXBxiYQK0/HdY5j1SfM+WkAajXORUcVXTEGQ30MSt/5sAUK7y4gGhET2CA7E+JRGuZswNzv9NDIdgDBh3cdW8XC+PxaTvwQLE/0+lP53PNbPexFIQvH+gwF3GusUG3j+Hy+ihqkL3rLz5dLRZuXgYZLNaba1nWVAMOiFW/uCdFKdZpqeDvIESsOYCFh06l30w7+6jqVjLMVF5EIwSDrNzn0jHU9LLzDgqB1TQurnb5brMW9zJ+lDpOeLxhj9q9xl4pjgTavLbdA8kSy6kjlgUCH8fR0RsScHdTg3mfoNm5ARpPam8vDbWOBVNQR0q8fLdSBl21+OC1BN0JuoOuQL7saWWVaBc2n99meR2PxUvx8k1c24OvgG9vz94Jy8ndV8WdhCtWZD9pCEfZw1HCDcj1Ss1IAIN+UNhsxFaaJdWIct+a9ow6laEORWacXbv2LyAM849BFJwfgmY3rbHHu3MNyABV9eOijMAsxXyKWD0HQxHO/+aw7Lm93PVFmTrzc76IVs3Fd78Aj46B4bmM6s/l+4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(15650500001)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oxMzvzpOZwWjcndNgjhnlZzGqCKANTfdcPgvhiB5yWqjTp+KBUcnh2hdeNMb?=
 =?us-ascii?Q?23I9OS8G1MFeSqUQ4o+4VLJ4R3GlvVBK4lwWnIBMicUo8NXA7c4TRo9CktlT?=
 =?us-ascii?Q?/isv9oApUGDkX/bIY//DZcpHz247hgGLsfskJv+7doTKKerS5fJA84XXaSP1?=
 =?us-ascii?Q?4Ih5hmvyIsKhcLs4IDWJcKnwEtmEiTOe0p2FVQYcHTkb+JXQuVpwTONsqm/G?=
 =?us-ascii?Q?YcXrxsdLSC64pad1FTy4TvsQUMR+BtteZ5kxR9LJ4HWENDETlkv2Y8aD3x56?=
 =?us-ascii?Q?9bJLg4tJJ02VGR0iPExa/gBO9nX/jZOStaeZISzjd6gy9NthNnJxnjd/RiqS?=
 =?us-ascii?Q?vgFRO0S3E3JTNg+yptI0akiI1meB/VBbO7Xrdx9NAvwXjYxvStHjlE9Na9IB?=
 =?us-ascii?Q?ONKGXHittcUF2vptRfAoqXdU3wgzfmT8+9QqDTCH0vPreNmgidYh4PdVIlZ9?=
 =?us-ascii?Q?se2Mcfva0GoCB+fjF0sx79WNzWPqXptCWze3OPoOnpXOw+AVtNKi4Ws7ro1Q?=
 =?us-ascii?Q?AemaWTsz9WVDvmqSNtZkMtLo25H3ca6oq33kKNBs1lxxMdzeQTsZV3U/dKD5?=
 =?us-ascii?Q?Wf4QQh9/y3jpYhtrqb3n533dFq3xawOMJVRTGPIYXJQ/5NzKA3hxPuIIVbBF?=
 =?us-ascii?Q?QGoIZlyH2kQMSIgEZ0hBMgOdQEfGzjFwNFw+OkJlXeXp4bOoJU2ru1nadnkE?=
 =?us-ascii?Q?6h7EthuLqz8yc3ORd9toMn+QDrT5bxuEFSfQBO2jFwdrWFu58duui8mzt06K?=
 =?us-ascii?Q?fH3mIb0C9iOVz1XNfR+LdyPYtl6Hop0RvB52L2/ARvzO+e0kbqlUFJtpUoof?=
 =?us-ascii?Q?sw4k+1Ng0UGYvoM+fPnMxQpjJV1+VQCV8zO9ucvBP1u/Djp/NMY1HsSU++1n?=
 =?us-ascii?Q?SAzuhOS+YQfbTxuf/2ImsdjaeKbaZdpohPMsGsdecBzRBCt3oEsoyEsIN8/M?=
 =?us-ascii?Q?lPrEg2bT/M3d4ATrDnVAJL2WxN7B9KWaytJElClTd2BPzMdFfNBVEvd+Tndw?=
 =?us-ascii?Q?zxCf/fKvX0UVeR/1VshI12t2CTH03NiHsc3kq77iV1QMYzYYW7zuSVj8Dx3Z?=
 =?us-ascii?Q?xNitJgihDbvvAQ0lCrlW52DU3jNDCLZC//tULgmkDPd+SLuu/BeE/lHhyaws?=
 =?us-ascii?Q?Er8GvBaSTJjIKNYNlcaaMY6c/R7QTYtoPySi1ADJPlKzM5V1G5Ty6N1yTuOy?=
 =?us-ascii?Q?4uDIOwABg8qRGe0EFpRqqXOKsBEGHwjNEb4694qzPqGofL0BXYOzn0q66LnV?=
 =?us-ascii?Q?Z941PDEyqXhuWxo8G+cFg3nfv5tYvt+8oypEAFDukoAtMn33JbOLNjeG3Wja?=
 =?us-ascii?Q?JS3FtJtnSuFzBRkLBtHcbvXE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc5bc64-23b6-4fb6-3d25-08d8d9126af5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:40.2260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MphnkDsmn7N5OgUbmlbsCOURuly1Nh/v2wucofwl8+0Guax8MPGAwlbTqGMrPYu0EInLuagSvfUqwgEfrxqbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
 Lijo Lazar <lijo.lazar@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use the correct mapping for mode-reset messages on aldebaran

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index b561c1eb4678..2810cc0a958c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -108,7 +108,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
 	MSG_MAP(PrepareMp1ForUnload,		     PPSMC_MSG_PrepareMp1ForUnload,		0),
-	MSG_MAP(GfxDriverReset,			     PPSMC_MSG_GfxDriverReset,			0),
+	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			0),
 	MSG_MAP(RunDcBtc,			     PPSMC_MSG_RunDcBtc,			0),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
 	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
