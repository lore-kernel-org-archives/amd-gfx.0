Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B48C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B7264F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B7264F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0784D6EB7F;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FAA6EB79
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDrHLDQ1lZsuX3yf+pzuMK/thN/MR0+MFQzdupOQRbg7M//zPJeUkxoIPongW07je+5xavPvFpzi41S1t/XzZjyI7zLaez26ZlN7Arlyxu8EsxTleozKxittMIWerWatMRNxVLEVTjLmyGPv5aG7xRnB+22pOEIHL3kFIstIa4ozr0rUSBbO/nDkBgNSQ0bYQLdvgXsVagI+eSlv7ePllLz2sNfMRxFx8hEtS9yzpoIf9hlUKsEz0LGS/CcfAYQnUSbzAOWIJuhjF9JpYE04B4+QFxKN+Nfd439/t3xyh943waRU+KTiP3OjA9xYhRD6q7BywdsSpda+ssgoFIgXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ga+gUF7E6hNS2hNC5x8wr9ERQVmWbbb69TUzrVSdS0=;
 b=kVAxpsPQHt9OeSXFCf1fzM5iQcQRSAiHPVPKKD/t7ObQnFBguSNYQzJ/JdCiBMKLsDj3B8nt+dU7VDQFlaWwW2fzM/jQGbNQxOXfOKXrvP5uHKjXYpjcWuUwWKmF+IjMBRJcCWFaeoGiq4frOb6/H7j4W7TZYiLAmv66Q+L8dEcEaVqLEWXmTwtiJrbMW9P8gzKHIZKl1tSv/RtIEkiDyF/SKZXASAFCRfyOQOPyuj8Kd2z+Mi4Bc5JKhJrTo5Fa/nAOCXf5nON/KAFba6VWsmVpYxvtmsmyUZ1wTKkbcUCexqrNX43dBNjuaFWx5NawSJPOGJnwV6gj39nKkuverQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ga+gUF7E6hNS2hNC5x8wr9ERQVmWbbb69TUzrVSdS0=;
 b=U5KfHTXant86hATgVdxSdvy69yw7+JxaTuUntPNCuMy4ez+34MGmyjR0xWi4sTsSYeKFxdMACCEf9R0/z7YoxJ6io9AOqq8B+hvupXVpkiPLNP0KtO/BV9T37iENnZLQvdUbAHwe4idNEQVJCQ7usmzI0BThw0ZUcsULu/X030c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 103/159] drm/amdkfd: Fix saving the ACC vgprs for Aldebaran
Date: Wed, 24 Feb 2021 17:18:03 -0500
Message-Id: <20210224221859.3068810-96-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5df1b39-1fd5-4583-a167-08d8d912678a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798AE51155741EA677F3133F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:249;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7/Y363ygjZ5edq0/Ck3cIrw21Uz87hcO+GXavd8mpnxlSQi7datwgQSZHsaZP6lT5mWjWvvjznp6qMPWdECa4bLZv/FrEChzRH0Rwr4/cuZbaHVuvVlbHgviydqcnbDV+Grz+NC5SDtxLa3f/so7S70M6kJgkWtxGzZAKTdWjN2yigSTTVKEDmfozz5Lrd1VQZTR9UkvNIuVpbykl6aSfwpTFe9lW+pYNLpdZs/L2BW5ZghwWUcCAqScPiRbUwFkbNkUWxPATDzT9VY7Xng0niQw+2LBwQeRFk0x8W1wzbY+8lC92GQR/0UHG9tK+RzrNOYC822khRASoL9aMmziRp8I9WMhpaA4BfeWDeB1PnmD/YQk8dpxZ7YxC6EvAM3x5LeKCA965fXf75kzImgWh7f1gnyLE3JwmpInl38DO6DNoC+GvO4PUJr20k7ogLK+yH2o+ehBLI24vC1UUtqsDwzS31+BcOjUQSkJGrWG6wg0P8GSdib83HxWhOq4Ugx3U8adtc9xFaA5aLWHpAhlQHa52YznKWbuhFoWSU4VBL4/krZxh3yxV8+tZjvwirP36v6A/p8A4qeJfZaG9h0bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l+y9YsP6EDXPorUEdo80SJrhK8iM8fem1NpJqKNUOQwwo+FmVJs0pq8t+oOl?=
 =?us-ascii?Q?5bEGZWl/Fl4afumUTW90LyNPIGaNhx2rbwDPfXgzYKv2FHWEJC1wvI8YrohJ?=
 =?us-ascii?Q?2QQ3o4yGLt+gc7G5RrlFPAakM00zAXzHIaCGLiwbu0C11zpR6pKXIZQKsHce?=
 =?us-ascii?Q?z92yZXhv9MRoTm12WZtnHZeMINf9bytlb9OQJ2WpXkMQlpi2SpRCjTa7A9er?=
 =?us-ascii?Q?3/4YJiPZChKczHZ6onJQ1bNsZMhx3QQ2gC3yhSH/q47trOml2t+ELVyvPVkR?=
 =?us-ascii?Q?ITg18YMhSAgPjdCjYNBCKiWhYhQ//uytcDW2f+pIQQuDY17PeV63mDpNcpUW?=
 =?us-ascii?Q?vfIfa0mt0+0rZP2Oddt4R8KTMDgirdM4BeqRSeD/h99OtDJ7mLC2SsXh9Skx?=
 =?us-ascii?Q?kKfXz9ckPnD+Wztcvxx79g37z4cuI1Mdz0crfQ7vsfpoMWNljq3CRC43rSwK?=
 =?us-ascii?Q?vNVoe6fkexk7lsMD2PQyNUSodSzjXCjEkNdm6Xl9eW7hDuUSnnmPahk8phSl?=
 =?us-ascii?Q?/0c+DxfbxelDPYx4+50utOu0v30fk7QGEzGjbvP+Yu16T4AhRtNxWsoM/wKD?=
 =?us-ascii?Q?kGeh3YF7uqLWDQSFDGL3REFQ8wA3n1mlKOAR9kJpxznw3OGM4cn6zy2Z+Bmh?=
 =?us-ascii?Q?u/EXRNQBGqPwHEa7ieXbRaLShdfwp4taTbY3LLH7LKHZwUDrIZ+Xy2Vonh+P?=
 =?us-ascii?Q?Q+aiMWQ4y10GwnTv6mAJsr9smdhnReozKoUWeydIETRjFXTqTUxWlFiK3xV0?=
 =?us-ascii?Q?rfRFP9c7M7LTr19nfA+inriQo/RYAXmvAS3blRCS6zXPwr4d50ZtXgo+MrRA?=
 =?us-ascii?Q?bZwFIj12rblvJhHbDvFJfdupFTeNvNOo+O/KdmM//QYpxcC0YdSVCeWChH6Y?=
 =?us-ascii?Q?LA+5IsyXtRVJaobCm1T06mE7pz1+M+ABP3yFeRVf6ZqilhVK+zqp1vGRZlXm?=
 =?us-ascii?Q?HFQV49kEVhE1OR6DCNGKcilNYWYhO31KsGvxo3K5L4M8fxcWvduQDw3Hrw4M?=
 =?us-ascii?Q?QZhL1xHe3PHprUYNn51VOHJvg/uqOr5/oYea3F2cpDWm7c5a3tN6gUaMSPHe?=
 =?us-ascii?Q?fSiSP3RkmpJ9Tf/FHckmJAKnW/3OxeqrDC/F/y+QsqpozyvYhY71eJjD/Ru7?=
 =?us-ascii?Q?JAw4Jdwd1EjcxDpqbkqNVgTvyK4PRMQrs57WabkFV8cjgvDRwE4eAKanlOmL?=
 =?us-ascii?Q?siANsnRYAcIOW9/q+Y2R0xYN7lQtltEfCg0SGnuIsWyg15T+P09pzGO20P7L?=
 =?us-ascii?Q?reuc36D+oBBRoYBA9EWMVnqZytM1AVGGNoAO4m7BC7lhjGwYglen4471VBot?=
 =?us-ascii?Q?0Ggkv0ivtxEuVoyX2B1I4mEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5df1b39-1fd5-4583-a167-08d8d912678a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:34.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzsTNFupT8FzEqjP+mkH/A9/Ek0D4t6wRCJzdGJTHIR79+mkLoSdMJfxZ4x63EOZAIyuzb7/H+Dmt8mmubzmFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Laurent Morichetti <laurent.morichetti@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Laurent Morichetti <laurent.morichetti@amd.com>

get_num_acc_vgprs does not set status.scc if the number of acc vgprs
is 0, so use an and instruction to set the condition code.

The Aldebaran handler binary was not based on the latest version of
the sources, so this update to the binary is the minimal change only
adding two instructions to set the condition code.

A newer version of the handler should be generated and tested in
another commit.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 183 +++++++++---------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   2 +
 2 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index c8453dad4ea5..475f89700c74 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -1576,7 +1576,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 };
 
 static const uint32_t cwsr_trap_aldebaran_hex[] = {
-	0xbf820001, 0xbf8202cd,
+	0xbf820001, 0xbf8202ce,
 	0xb8f8f802, 0x89788678,
 	0xb8eef801, 0x866eff6e,
 	0x00000800, 0xbf840003,
@@ -1873,114 +1873,115 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
 	0xb8fb2985, 0x807b817b,
 	0x8e7b837b, 0xb8fa2b05,
 	0x807a817a, 0x8e7a827a,
-	0x80fb7a7b, 0xbf84007a,
-	0x807bff7b, 0x00001000,
-	0xbefc0080, 0xbf11017c,
-	0x867aff78, 0x00400000,
-	0xbf850003, 0xb8faf803,
-	0x897a7aff, 0x10000000,
-	0xbf850059, 0xd3d84000,
-	0x18000100, 0xd3d84001,
-	0x18000101, 0xd3d84002,
-	0x18000102, 0xd3d84003,
-	0x18000103, 0xbe840080,
-	0xd2890000, 0x00000900,
-	0x80048104, 0xd2890001,
-	0x00000900, 0x80048104,
-	0xd2890002, 0x00000900,
-	0x80048104, 0xd2890003,
-	0x00000900, 0x80048104,
-	0xc069003a, 0x00000070,
-	0xbf8cc07f, 0x80709070,
-	0xbf06c004, 0xbf84ffee,
+	0x80fb7a7b, 0x867b7b7b,
+	0xbf84007a, 0x807bff7b,
+	0x00001000, 0xbefc0080,
+	0xbf11017c, 0x867aff78,
+	0x00400000, 0xbf850003,
+	0xb8faf803, 0x897a7aff,
+	0x10000000, 0xbf850059,
+	0xd3d84000, 0x18000100,
+	0xd3d84001, 0x18000101,
+	0xd3d84002, 0x18000102,
+	0xd3d84003, 0x18000103,
 	0xbe840080, 0xd2890000,
-	0x00000901, 0x80048104,
-	0xd2890001, 0x00000901,
+	0x00000900, 0x80048104,
+	0xd2890001, 0x00000900,
 	0x80048104, 0xd2890002,
-	0x00000901, 0x80048104,
-	0xd2890003, 0x00000901,
+	0x00000900, 0x80048104,
+	0xd2890003, 0x00000900,
 	0x80048104, 0xc069003a,
 	0x00000070, 0xbf8cc07f,
 	0x80709070, 0xbf06c004,
 	0xbf84ffee, 0xbe840080,
-	0xd2890000, 0x00000902,
+	0xd2890000, 0x00000901,
 	0x80048104, 0xd2890001,
-	0x00000902, 0x80048104,
-	0xd2890002, 0x00000902,
+	0x00000901, 0x80048104,
+	0xd2890002, 0x00000901,
 	0x80048104, 0xd2890003,
-	0x00000902, 0x80048104,
+	0x00000901, 0x80048104,
 	0xc069003a, 0x00000070,
 	0xbf8cc07f, 0x80709070,
 	0xbf06c004, 0xbf84ffee,
 	0xbe840080, 0xd2890000,
-	0x00000903, 0x80048104,
-	0xd2890001, 0x00000903,
+	0x00000902, 0x80048104,
+	0xd2890001, 0x00000902,
 	0x80048104, 0xd2890002,
-	0x00000903, 0x80048104,
-	0xd2890003, 0x00000903,
+	0x00000902, 0x80048104,
+	0xd2890003, 0x00000902,
 	0x80048104, 0xc069003a,
 	0x00000070, 0xbf8cc07f,
 	0x80709070, 0xbf06c004,
-	0xbf84ffee, 0x807c847c,
-	0xbf0a7b7c, 0xbf85ffa9,
-	0xbf9c0000, 0xbf820016,
-	0xd3d84000, 0x18000100,
-	0xd3d84001, 0x18000101,
-	0xd3d84002, 0x18000102,
-	0xd3d84003, 0x18000103,
-	0xe0724000, 0x701d0000,
-	0xe0724100, 0x701d0100,
-	0xe0724200, 0x701d0200,
-	0xe0724300, 0x701d0300,
-	0x807c847c, 0x8070ff70,
-	0x00000400, 0xbf0a7b7c,
-	0xbf85ffeb, 0xbf9c0000,
-	0xbf820100, 0xbef4007e,
-	0x8675ff7f, 0x0000ffff,
-	0x8775ff75, 0x00040000,
-	0xbef60080, 0xbef700ff,
-	0x00807fac, 0x866eff7f,
-	0x08000000, 0x8f6e836e,
-	0x87776e77, 0x866eff7f,
-	0x70000000, 0x8f6e816e,
-	0x87776e77, 0x866eff7f,
-	0x04000000, 0xbf84001f,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000903,
+	0x80048104, 0xd2890001,
+	0x00000903, 0x80048104,
+	0xd2890002, 0x00000903,
+	0x80048104, 0xd2890003,
+	0x00000903, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0x807c847c, 0xbf0a7b7c,
+	0xbf85ffa9, 0xbf9c0000,
+	0xbf820016, 0xd3d84000,
+	0x18000100, 0xd3d84001,
+	0x18000101, 0xd3d84002,
+	0x18000102, 0xd3d84003,
+	0x18000103, 0xe0724000,
+	0x701d0000, 0xe0724100,
+	0x701d0100, 0xe0724200,
+	0x701d0200, 0xe0724300,
+	0x701d0300, 0x807c847c,
+	0x8070ff70, 0x00000400,
+	0xbf0a7b7c, 0xbf85ffeb,
+	0xbf9c0000, 0xbf820101,
+	0xbef4007e, 0x8675ff7f,
+	0x0000ffff, 0x8775ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x00807fac,
+	0x866eff7f, 0x08000000,
+	0x8f6e836e, 0x87776e77,
+	0x866eff7f, 0x70000000,
+	0x8f6e816e, 0x87776e77,
+	0x866eff7f, 0x04000000,
+	0xbf84001f, 0xbefe00c1,
+	0xbeff00c1, 0xb8ef4306,
+	0x866fc16f, 0xbf84001a,
+	0x8e6f866f, 0x8e6f826f,
+	0xbef6006f, 0xb8f82985,
+	0x80788178, 0x8e788a78,
+	0x8e788178, 0xb8ee1605,
+	0x806e816e, 0x8e6e866e,
+	0x80786e78, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0xbefc0080,
+	0xe0510000, 0x781d0000,
+	0xe0510100, 0x781d0000,
+	0x807cff7c, 0x00000200,
+	0x8078ff78, 0x00000200,
+	0xbf0a6f7c, 0xbf85fff6,
 	0xbefe00c1, 0xbeff00c1,
-	0xb8ef4306, 0x866fc16f,
-	0xbf84001a, 0x8e6f866f,
-	0x8e6f826f, 0xbef6006f,
-	0xb8f82985, 0x80788178,
-	0x8e788a78, 0x8e788178,
-	0xb8ee1605, 0x806e816e,
-	0x8e6e866e, 0x80786e78,
-	0x8078ff78, 0x00000080,
 	0xbef600ff, 0x01000000,
-	0xbefc0080, 0xe0510000,
-	0x781d0000, 0xe0510100,
-	0x781d0000, 0x807cff7c,
-	0x00000200, 0x8078ff78,
-	0x00000200, 0xbf0a6f7c,
-	0xbf85fff6, 0xbefe00c1,
-	0xbeff00c1, 0xbef600ff,
-	0x01000000, 0xb8ef2b05,
-	0x806f816f, 0x8e6f826f,
-	0x806fff6f, 0x00008000,
-	0xbef80080, 0xbeee0078,
-	0x8078ff78, 0x00000400,
-	0xbefc0084, 0xbf11087c,
-	0xe0524000, 0x781d0000,
-	0xe0524100, 0x781d0100,
-	0xe0524200, 0x781d0200,
-	0xe0524300, 0x781d0300,
-	0xbf8c0f70, 0x7e000300,
-	0x7e020301, 0x7e040302,
-	0x7e060303, 0x807c847c,
-	0x8078ff78, 0x00000400,
-	0xbf0a6f7c, 0xbf85ffee,
-	0xb8ef2985, 0x806f816f,
-	0x8e6f836f, 0xb8f92b05,
-	0x80798179, 0x8e798279,
-	0x80ef796f, 0xbf84001a,
+	0xb8ef2b05, 0x806f816f,
+	0x8e6f826f, 0x806fff6f,
+	0x00008000, 0xbef80080,
+	0xbeee0078, 0x8078ff78,
+	0x00000400, 0xbefc0084,
+	0xbf11087c, 0xe0524000,
+	0x781d0000, 0xe0524100,
+	0x781d0100, 0xe0524200,
+	0x781d0200, 0xe0524300,
+	0x781d0300, 0xbf8c0f70,
+	0x7e000300, 0x7e020301,
+	0x7e040302, 0x7e060303,
+	0x807c847c, 0x8078ff78,
+	0x00000400, 0xbf0a6f7c,
+	0xbf85ffee, 0xb8ef2985,
+	0x806f816f, 0x8e6f836f,
+	0xb8f92b05, 0x80798179,
+	0x8e798279, 0x80ef796f,
+	0x866f6f6f, 0xbf84001a,
 	0x806fff6f, 0x00008000,
 	0xbefc0080, 0xbf11087c,
 	0xe0524000, 0x781d0000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index 4b3f0762a779..eed78a04e7c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -632,6 +632,7 @@ L_SAVE_VGPR_END:
 #if ASIC_FAMILY >= CHIP_ALDEBARAN
     // ACC VGPR count may differ from ARCH VGPR count.
     get_num_acc_vgprs(s_save_alloc_size, s_save_tmp)
+    s_and_b32       s_save_alloc_size, s_save_alloc_size, s_save_alloc_size
     s_cbranch_scc0  L_SAVE_ACCVGPR_END
     s_add_u32	    s_save_alloc_size, s_save_alloc_size, 0x1000		    //add 0x1000 since we compare m0 against it later
 #endif
@@ -769,6 +770,7 @@ L_RESTORE:
 #if ASIC_FAMILY >= CHIP_ALDEBARAN
     // ACC VGPR count may differ from ARCH VGPR count.
     get_num_acc_vgprs(s_restore_alloc_size, s_restore_tmp2)
+    s_and_b32       s_restore_alloc_size, s_restore_alloc_size, s_restore_alloc_size
     s_cbranch_scc0  L_RESTORE_ACCVGPR_END
     s_add_u32	    s_restore_alloc_size, s_restore_alloc_size, 0x8000			    //add 0x8000 since we compare m0 against it later
 #endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
