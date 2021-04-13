Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F9A613B7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F9A613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5E0899B0;
	Tue, 13 Apr 2021 12:56:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845DC899B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKEPdLj5TOHjE00lo9S9l8pT6kIzJ3xUEeQUsfNQEe6dZz9ZUEqrOP4FFiIjI+QXophRe+Q5cQcSKh0rX1MuQZXp3ylM8TNEBUdTPkOH78MLmZ3wJiQ/aWdRUFhRJ+dF740ht2HWJplWxLALqK1QVXsji8UCo0BzoIugwZlZLEyExFOq7xrWtvQNxMAAXSvcySULr9na9826S49TNVUpsS7WOt1gT16JJyIwMlRSYRetKcfKNBrj3VOCQ9+S5FhmjA6Ra/Ya9JvueqE+JI4riGDfVzp1OKrvyj32skcA8ozuM2SGzKSGiO1Hjfm8j0axmdU6fEzbMTODZ/gQUjtN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeaeZxkGz8cGFuK1XnPRdJNU4QXXBxUIJPbQdo3Sq2w=;
 b=DvBltAmVlRvzjSL1XnZ7bwAiTfTgRu+SHmCz0ujM6g2FJJXi4dBpQlmDiNQSFVKu1f/4FDvGzsYSU/Vr+4Jdap4UGoEGSTDqMRaxbhu7YIBFLG86JpcsAzMMptb45v9YQK3+n+g0bZlNeWTaw/DM4jq7A5fngyD0HURplie8K6mb42gjlbt7rqPowMKSiDjjSE33cahCb8oEIs+N6Xt5NdFlJ80abNxC7WO5CbLdMDA7/bdx4kvnVvO5lGQibXnKeeA9o4Xfd3wukrRhaJ5tR06BSi6NfZJJvItXbDGAozgqPHO2DljazEwvp0Om9daXgtzrLY8q0VgQ9zQOihW0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeaeZxkGz8cGFuK1XnPRdJNU4QXXBxUIJPbQdo3Sq2w=;
 b=a1GODYX4FDwSjgiUhLslcJukgFks+OfnvOW+545I7aRROOzPGnPgBF0P6EDQxHZ8mk/qK0tKbIa6Uk7QMoLH/RK1sRNVYEn4g3Ug6YZuNOe/p6+eGfbzBY2U0W/8grYyRYVY6G8+6EBL3Qjq06C3O7l2pLSoSuLYkfwDc/HqAwE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 12:56:16 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 12:56:16 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Fix a bug for input with double sscanf
Date: Tue, 13 Apr 2021 08:55:58 -0400
Message-Id: <20210413125601.50387-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 12:56:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f348e6-f84a-403f-64e3-08d8fe7b8678
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1836CA4F9A07102389C1D5F2994F9@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIffW7KB0LjRTWioeSEqjYuwZSeqt8ZAfkfTWkyVALfrRKPTZcbxxWg1KoyV90/ubSWLBO1e5KDULZpWOdFBbW08P9VINBJfNFxj6l/LoVybIbPPZF7qJNbC2LQ6jyLTCirSDNq/+fAA3pqjUch9h/qDty0zbxZ1//ov1bWClkgfP0y5//rGmtjB6xS2nlcgF/RyUM67Zdlw0t7tkoXhxqpgZIjyqqlnzlPn2MY3mBSbun5Fe4ZHqixy6FUFeS4yl7gsllMWkW61Npm0eSKQ3l7GE6WTK2w5i+yO0awIciJx4HpwvSoRoQEQjDLIeysof/34biji4txdBVWhDMPN2w3gv3f27oDZCF0gvT3Hk5JyHsa66vLlP+AA1fKM/YUEorpVbg82U/1D58Yy/15nj1YJZ1XyMA7EUCfNwStjyjrBaSpfbFDuZwz0tQ5mm7frTPQYuTvB7VEioZsWAKwxt7q4YJYrJ9WrgsIklTDnnavUrQ/TafXXkj+c0uF/Df6+Z2d3pM0+5nf9CY3VG7/9KLmOmfBF4RYVHAOHLFL808HI/Pd01eqLwlDgIJ22n2aICK+dcV5nSaKJ+7+CXtJbj60O+pb9By48bGOrXmCybZiuJ0RQ3eJdUPk1NH3EttJDOKwCoqhQUeD3WRaOOzAQXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(8936002)(7696005)(44832011)(6916009)(38350700002)(26005)(4326008)(38100700002)(478600001)(5660300002)(16526019)(8676002)(86362001)(6486002)(66946007)(316002)(1076003)(186003)(83380400001)(52116002)(66476007)(2906002)(2616005)(54906003)(36756003)(66556008)(6666004)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0p2D4qXyPkinJHdC0/aK7TfseUlL2TAHbSbWFBdmct7xwgGlPghh985fklOP?=
 =?us-ascii?Q?CTci5XQA+lujPOMSTlPxYnfUe4CmXGtMbhdjUaxqMe+LcU4bZkCKEbswVsAO?=
 =?us-ascii?Q?qeF+xiSTGhmBBynOkgXcJSIMkvXkxvDJkcssKUM3OgaM/63LP35gNkf8DjsF?=
 =?us-ascii?Q?DO3TL0WzJQfuZZw6Tbps/uncFitMV+FRjp6zPo6Ga39MBzDkVmMs6FyW6fzT?=
 =?us-ascii?Q?Eedbu45CloY6u4YB7EHQ2Fqtin8Qy5tdhsqjyHa2Pn7YNeglzyEJioilHFU8?=
 =?us-ascii?Q?16/Fjl8yv6QkQn0b3/+jdAKxyFvnO3S7ICAQwNQxDvxG6ZYGghdAkiw//VMD?=
 =?us-ascii?Q?6iC6JAkD4AG+q1Sl2UXoH3GcoQa6+jll7n+qyGHeXQVjomAk3w8LPz0j2uYq?=
 =?us-ascii?Q?pNe3VsK+S3VmMJse/y5wF2Du1mqZrrGDTBJY50o0LhcDGIKUUtNx0NKltbBa?=
 =?us-ascii?Q?5QCV74y3qf2uefrnsVpAYW9/HrtsKVSkVyRo0jQQTSiUnJKgr+EvdmBA2iO+?=
 =?us-ascii?Q?/sgfnCn/ByP+E5ea5lxEsR39AiBdFUIskMKYJJxs+3McBUvhoQXcqvIZm9NZ?=
 =?us-ascii?Q?PR5zwFiLI0jY4pRWujH3Di+JaI4PAqtEgBMgLfzxi2e3UX8g6OmtrhjN5tzs?=
 =?us-ascii?Q?8QCiEXTYpzqlUMGryDelLp4SiRGXQU3q9cEsNWbTCfxnbqpx6fOM/pvn+prR?=
 =?us-ascii?Q?VSM5d1/3cKHFAMQAl/NrVI7ugSKGd0ZR3rtalQsRu3pXZUAWE/83E3CwIVVT?=
 =?us-ascii?Q?HZ/MNTYDzuYHEfpAstTMDZmyF6f6KMilp9u+eGjmp9wz4piAjyThmyy22i4E?=
 =?us-ascii?Q?DJkj8MiV9cDH1SFvUVX8QSRD5Ja0eC3EhhNdj+5fNkb4Gc7Ud7TiINHXwVNt?=
 =?us-ascii?Q?Zh3osrvO3DDyogSvg1xcoimehSDwocWMz+S28NSYCZMboO2T34v5vFtIRuZ6?=
 =?us-ascii?Q?9Q5oZJqin5EiOBHqhoD1PCNm8/+mQCUd8v02/vadJTxK4ORbMiGOwfBR/ldS?=
 =?us-ascii?Q?hg1dxd0EHXs4ovNb2R3UAGoj/8TTk2eH6L4S5wrmNHCFzadjidEgyPZR5lW/?=
 =?us-ascii?Q?nKY/yZYRBABDY5+Mrfq3mzQjYFUMn0OKXtZZsORyS6FRL7lr+JCL+T1bcXy9?=
 =?us-ascii?Q?TVdoYiAho0dGdKsK+9ArSNNUP3QnQG39KUSuRWlnIpto+EZfryVJHK+Wovvz?=
 =?us-ascii?Q?ko2+h0ZMQRYdOGMGwwG8/trE3Pwp+akDZUVvkq4yyFMOzNSJV+iUDOoW/gCq?=
 =?us-ascii?Q?Qwhc1WqNTX4V4k09eJwIKNgAqKfN2h7g1EpXT/gYu5kmZGZDs0ymv7V3gtC0?=
 =?us-ascii?Q?VR7vPl4jHzDo0reSpUMS6hXy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f348e6-f84a-403f-64e3-08d8fe7b8678
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 12:56:16.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47RBHAhbFGIMg4cSemL6VO34VXTYyqMYJn1K8lbUMnb71fD/koWhF3MKEZhl48zM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Xinhui Pan <xinhui.pan@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove double-sscanf to scan for %llu and 0x%llx,
as that is not going to work!

The %llu will consume the "0" in "0x" of your
input, and the hex value you think you're entering
will always be 0. That is, a valid hex value can
never be consumed.

On the other hand, just entering a hex number
without leading 0x will either be scanned as a
string and not match, for instance FAB123, or
the leading decimal portion is scanned as the
%llu, for instance 123FAB will be scanned as 123,
which is not correct.

Thus remove the first %llu scan and leave only the
%llx scan, removing the leading 0x since %llx can
scan either.

Addresses are usually always hex values, so this
suffices.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Xinhui Pan <xinhui.pan@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0541196ae1ed..9041453465f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -230,9 +230,8 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 	if (op != -1) {
 
 		if (op == 3) {
-			if (sscanf(str, "%*s %llu", &address) != 1)
-				if (sscanf(str, "%*s 0x%llx", &address) != 1)
-					return -EINVAL;
+			if (sscanf(str, "%*s %llx", &address) != 1)
+				return -EINVAL;
 
 			data->op = op;
 			data->inject.address = address;
@@ -255,11 +254,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		data->op = op;
 
 		if (op == 2) {
-			if (sscanf(str, "%*s %*s %*s %u %llu %llu",
-						&sub_block, &address, &value) != 3)
-				if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
-							&sub_block, &address, &value) != 3)
-					return -EINVAL;
+			if (sscanf(str, "%*s %*s %*s %x %llx %llx",
+				   &sub_block, &address, &value) != 3)
+				return -EINVAL;
 			data->head.sub_block_index = sub_block;
 			data->inject.address = address;
 			data->inject.value = value;
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
