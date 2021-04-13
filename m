Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDDA613B6
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDA613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEFA89D56;
	Tue, 13 Apr 2021 12:56:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2E989D4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTBjKUJJFzDvdjCZlfECNJVXgiPCbsux999BSNVL8ZzAZczXaYHXSV9b9rRuPLsIQK9Yio7eINH3EPbEs2h25TMNLnU5ff8IZVabPX5O7IEBgXa1lKPSyv668SPA0jXWBP4jeSodzMFBqRU1rAC0FVDxwolcOHK4h2dkb/CL5ocCrGzF3nt3zRwXG4kKbGEro9RO7D+oHmjj1sYpXG7TxoCActXF29YZ9As/WmqTtesPBC9LhytjIPBT6cM6FtIBCkblnXR1uHhRE2gdQegBxuXwS1WU3Tc5qUhkEh+RI63SdWg4gUeEUX6u91p+Iskn1mI3KBhO6avMFh/G3ldvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLC0MisTVD/j118+DC9R84PE45+uyNDljvYMDtODQzw=;
 b=jtwWe3NfX0tHUIsL6teY8l3JovnioDBZontmcLozgTQBORkxj6/hupzTvU+bquVoXFVm3OCM7GDxIQUUg5rKbmi6D0yJ3OGG4+raFCEE8R9thYIORGQno3mOLuUsDCUjLEMlG29fFM7X1hg/qcgt5i8pniMsT2jM+ezxANwnOG7LoNL+yXard4SvRkGnZrgxGtrqF/fD1czeyoHZU0lyWXSnO+4+LK8o3UtoAsF3GnTjXsSan7ZUdlaxdRtpWY+u3DrfDEjRH9+ECObywHyrU2Xq2YpYkXUtM53WLTaYw8PLS5bCFUQd62DqArRtKStco3+fAcPjuqDn2F7hRJu+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLC0MisTVD/j118+DC9R84PE45+uyNDljvYMDtODQzw=;
 b=M0HyWdae/G7iuZKBRLYMlOIpTct12/iDt1hoj4S/4R1QIiViOiv2ttR17Q+N28wC7262+vkD7esl1XeUqLDYFuPv9wqMaFatUGwBCIPoVe/wRQgn3QSxlUpc6XKyHCGmmGrjhlawFzBwmYETSsdtDv6JgA5Xx9tQE7Q7fBd0aD4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 12:56:21 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 12:56:21 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs interface
Date: Tue, 13 Apr 2021 08:56:01 -0400
Message-Id: <20210413125601.50387-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210413125601.50387-1-luben.tuikov@amd.com>
References: <20210413125601.50387-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 12:56:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68880844-a85d-48ec-24c7-08d8fe7b8957
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB183688CCC648D2F9B90E1EBE994F9@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKnuYKD4wwnT6/hDbwwuD76vbh9+lCvfjUc9ymK0XQMYxZW2dNN8M2DRNvfVhFGjmiWBIrradizh276RqLahFMC6ugM/YF+ZY1IPEPD7Vl1Xj+pZ5DeEoyhSHVSSbgqwOgWHiKTZ/16zq60GXXjIWaGNRE/L2LmGjVwpqhvmwx4hvlzRD0GmWvTIARY9ap+dlgQPnjKlBrjIx58lcbkgYrtgRA6qebSUjUmtsWClP2iT0QNkeiZnVV20t6ZQXphnA4+2j4XnVh+Hx1Bh8QbZ7UUv3M1yMdc+wh6RNDLapFAWGLgmH9npLnth7DLkonIWCicUS/+YnkOgnZDcgNHMKVRO1eW9ns1a0424nyd3PAdmyx2fqGE/BIjrajnV1rJR+LWbRIDbypDK9y4auQ+66t3KP1+OWW/kvc6hWxwLgzX7oaMPbqPgAon/MtSm031Cr/2nbXKWCeXGU1UXV3a95YCtyA8NMyg5U/9g3T0g0vx/RW2C4UtVphSUDIRLmqaubJpkrMeXE3wO604cQd3M+1dEqbmUAtgnrs8Yha8DKYBTgmoMnC9wq4Ut6DZTEAUZhGO+71+JRovQ4DfWH9Jm6oh0oBlmVhYHrlt5eVoNjX/j6/coStk4ns1GH8v+Y9zjHkSEMbDuHI27UQRtlI/zUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(8936002)(7696005)(44832011)(6916009)(38350700002)(26005)(4326008)(38100700002)(478600001)(5660300002)(16526019)(8676002)(86362001)(6486002)(66946007)(316002)(1076003)(186003)(83380400001)(52116002)(66476007)(2906002)(2616005)(54906003)(36756003)(66556008)(6666004)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O+ILSMpQb12a93uJ1zsZzcAb26C5ZVPL0ASHRLW8IrIMsFdQOEskhUF4UYyk?=
 =?us-ascii?Q?pbJ5B52v0L6ltIeFNkW5qd3MK7l+xb1wsezDW0InhHrKnFc3SFk0Eijx3jso?=
 =?us-ascii?Q?9SMq9ryhk4R1LF7hClDRYFZ9a38m+hAWrSyyDkBEQV6Di6oVE5bW7FtHxz5+?=
 =?us-ascii?Q?nSyz7GMFPbg6hERDa7yIgkKyHQCI6PAdeV95vZhx/dDeGN/HDDniCFrJ+2a0?=
 =?us-ascii?Q?uTmzbuJ/EM6NKSbFX4Flpb28SXtNS3ov7GN0/JXjESHuFAkw8wdKUfK8Zt62?=
 =?us-ascii?Q?zdgW1M+46F4tH4LawYdrQUt9ixBrlBLVK0ODoGh9DJXjCc0/KvH9OR2MnMxd?=
 =?us-ascii?Q?vorm6mzgTlclUhxIgCgHyeoVpxpgg/16KvSge9JXQQnDplW6Sr/UIiSPjjXk?=
 =?us-ascii?Q?wKstTQK7Y+7MzB8niifqVa9/CePssByxqDWwDkxmOuUXr2JR5QDHsSfPaabI?=
 =?us-ascii?Q?09Rgam+1bcSWIsOA7q0d/11m2vxzfnI3/EZzdm67kPi/egQ+CfmHFAU2CpZK?=
 =?us-ascii?Q?g90qwZdMI82gxAPNVneUq5OzWTpa7F1Lp5LO0uHSFqiBax3v4ocXVdGgABlW?=
 =?us-ascii?Q?YU46qYoY5JqT3g3OCcohpIqQ11Djg87dqu69YqDNlZuy9SOUBlaqMO1eM3ly?=
 =?us-ascii?Q?/iVSUnGA8CPJ7u9J/0Y23hwWHIaG3uiVqBX+ZDOIiqWcRCQjGM0GS2V725mh?=
 =?us-ascii?Q?uXfvYCt6uwHb6P9WNUxeKsuXdbd0Knj0sUp6pAgLGc/FyxGJ+sTX4StvsU2J?=
 =?us-ascii?Q?FR0OvmgBJHFZpUf9tWiddw3FomIAQ8pmj2mPI0HJ/lEWETdFj9grQdwOciaZ?=
 =?us-ascii?Q?HkhG3TqW5ZUGScvX4RVgb9rG//wy+7+HQUacnM/3ebMKS+wPi9V8xhHnuxKh?=
 =?us-ascii?Q?z6rZabn134RijyoiowA7mdZOjtenjEMxM5p7J7fjUEEuhEjJYeIMiBXbPm4S?=
 =?us-ascii?Q?gsnrZ3keHH5RQW5likZZ9GdNijqt0ONYBCUmxao5DZ6vwcoXBFo2WhM+DKvP?=
 =?us-ascii?Q?wAqjI80D/HoPxoDBt1p6QBMlk9PZqc/OxUTDx3w+kxFMbPbDw4cet2citbKH?=
 =?us-ascii?Q?Di9hc53KjvgkJ0nNeSh1+v9A3rK5dF1sX5V+9oSGDMd8sVZlrcaodWFEM7xT?=
 =?us-ascii?Q?qPW7OLenUsyMtbHmjP8TPRnG+hnvPLbAMS+rMKxTURqm9RcSbFDo5Xx+EJZ6?=
 =?us-ascii?Q?JOTa9K+237AyJgEPljmVXZdfUlto/0IRdVN6B/BxsRqCJD23Yyw+YOZ47KCD?=
 =?us-ascii?Q?Sq0I6dLtOCc/7A0ZGkTX8TniPPmv9W3IA/YNk/gcPZdC/wU59DG2E/rfxzmB?=
 =?us-ascii?Q?/ri+hwgKrDDKRb8r+qZ41VF7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68880844-a85d-48ec-24c7-08d8fe7b8957
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 12:56:21.3945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIYMEgL6XaI+SjIqNJZPniruP98lxwCDWslkF0/MwICg0JYj0fiqTU7M9L4Zh9X9
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
 Luben Tuikov <luben.tuikov@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Imporve the kernel-doc for the RAS sysfs
interface. Fix the grammar, fix the context.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 47 +++++++++++++------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 30cda4b8a461..44dfb3613e37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -274,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
- * It accepts struct ras_debug_if who has two members.
+ * The control interface accepts struct ras_debug_if which has two members.
  *
  * First member: ras_debug_if::head or ras_debug_if::inject.
  *
@@ -299,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *
  * How to use the interface?
  *
- * Programs
+ * In a program
  *
- * Copy the struct ras_debug_if in your codes and initialize it.
- * Write the struct to the control node.
+ * Copy the struct ras_debug_if in your code and initialize it.
+ * Write the struct to the control interface.
  *
- * Shells
+ * From shell
  *
  * .. code-block:: bash
  *
- *	echo op block [error [sub_block address value]] > .../ras/ras_ctrl
+ *	echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
+ *	echo "enable  <block> <error>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
+ *	echo "inject  <block> <error> <sub-block> <address> <value> > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
  *
- * Parameters:
+ * Where N, is the card which you want to affect.
  *
- * op: disable, enable, inject
- *	disable: only block is needed
- *	enable: block and error are needed
- *	inject: error, address, value are needed
- * block: umc, sdma, gfx, .........
+ * "disable" requires only the block.
+ * "enable" requires the block and error type.
+ * "inject" requires the block, error type, address, and value.
+ * The block is one of: umc, sdma, gfx, etc.
  *	see ras_block_string[] for details
- * error: ue, ce
- *	ue: multi_uncorrectable
- *	ce: single_correctable
- * sub_block:
- *	sub block index, pass 0 if there is no sub block
+ * The error type is one of: ue, ce, where,
+ *	ue is multi-uncorrectable
+ *	ce is single-correctable
+ * The sub-block is a the sub-block index, pass 0 if there is no sub-block.
+ * The address and value are hexadecimal numbers, leading 0x is optional.
  *
- * here are some examples for bash commands:
+ * For instance,
  *
  * .. code-block:: bash
  *
@@ -332,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *	echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *	echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *
- * How to check the result?
+ * How to check the result of the operation?
  *
- * For disable/enable, please check ras features at
+ * To check disable/enable, see "ras" features at,
  * /sys/class/drm/card[0/1/2...]/device/ras/features
  *
- * For inject, please check corresponding err count at
- * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count
+ * To check inject, see the corresponding error count at,
+ * /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
  *
  * .. note::
  *	Operations are only allowed on blocks which are supported.
- *	Please check ras mask at /sys/module/amdgpu/parameters/ras_mask
+ *	Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
  *	to see which blocks support RAS on a particular asic.
  *
  */
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
