Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73225C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 01:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A0F61207
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 01:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A0F61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918576E02D;
	Mon, 12 Apr 2021 01:15:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF996E02D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 01:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+X5RJ/PljLI9nNrU99T8+ryOI4/Eu6gobr2cQMiPPtqWPtjsEe/WpPBN214R1dc3gqR+U1yPWAowzLv7H32Ovn7YWT4X/6uHINw6/EFqh6xI4lEWW4zIZImvnLCRohO/T+xN0Y5Wa4PnWQs7jI36Dxa2ymxX10Ip1X01pFm0eEqO5mP35OX544o6RlRRVKwBN4IT93UK08vNjo4FfcHLtsBdFcDF1GDthHeZyVT/JWDxTowRW3SKIJSjLfE7Ymt5wAhs9pbjM2fNDIq4eE0MlPz8LbHoeynzvAaJJOopcRodC3lGQiTLFpJZozWxf854q/W5JutyxoL/+gFdIXG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0PRFfccPJ+jakfYvcZ38Qyp43FHon0ZwewkBTCEQtE=;
 b=bHn0Nft044HnLi8Tf/GoD3NNp+YExhXwUXz+/PvsZmHnpGGl8HUNoBd1MzAyc3bPf+K/+hwIvFkrRCrtyoXsIPa2UfHxG+QUlh/u8Yrw05slgyysgWu+Y6kLmdUX8k/3T2cvAjJN/UZlJDEwwoL8j9V7uBkT3a1671DKOQi0jfDnFz32b2HcfKRx2ns6GHlJr371ZXLuAHsffonOu7jA7NhoLzJtD/QJBEeQawohsxZS1JcMuZns8APQhHDMQUaQQLXStcaeRs7e1iytPF1HSPxvUGzwGyinI6yMZrRoDoGveM42X7WLbVyRp32WFKeZA2sHgYRz2gq02+MEG9loLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0PRFfccPJ+jakfYvcZ38Qyp43FHon0ZwewkBTCEQtE=;
 b=r/YrCLIT/py0u+cgkG3u2wcz3w3EJoHZD318T/WNh+Fe8ECLRnLhxWPpesZd/OSqN6TuUJg/9KggkWURbAM6aM3Ki4iV8QurNl3tio7cur+YbYWUWvMAVO220L1SEpNMVpTHBLYJUb0/Q+ESuIcVvEdOi4eIAoSXLipx8EB0LrA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 01:15:27 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 01:15:27 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix checking return result of retire page
Date: Sun, 11 Apr 2021 21:15:08 -0400
Message-Id: <20210412011508.35024-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::14) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Mon, 12 Apr 2021 01:15:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9a91f9-c46d-4667-4591-08d8fd5074a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42203084ECEBC2B85261DC3D99709@DM6PR12MB4220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBKu6ubfCm3UB6Thk16XWoX03ZLZVNEtr3vxgLs68cwYYqxEkaiDSQrIUodx3Zs6CXatEEpUPYJ3dqVOPA2a+VJniTjacvoqegJz9m6M2tiUjtks/moy0vaoIyn7dQL6fyYqkjrfz2xEzeZhMrAPfLwI7iAts7djiNNrAkdu+UUGO/KomytQ18V64PXWLJaGbUi9gQYBd2/DM7T9Gq9uKmbZG8OsvOvKiajZfC03NW1FlZ/o7j93iDAGxHDIscelabR/Ivz8AqqP9cKc3rzZ5YtZnrcDacHqOqBj0Q5MPTR+fHd8o3KzDpLqdkHX4gpuUwrdr93uqvekk7OsvyO/W7BYivJdhJkd6dLGRapqNbnVFFbEEYHnTEFqb1O4uFrCsGcxKTNKxwV+uKuaZ3MVqNSpwmq+pOlm50glMtJ809d2c1bf7uUlMhW0ddqV31z3NJHM1IgZEs9rDmbNkBoENPrc/btmzpt9tPDOlQUVXCE28oQQo+F/mgp1Y9aezO5N4tbr6SRv6LwI6FW+A6LLWcFb8fZmN5M4s0FpV5d5VoRNvg+xmxP0WtdGnZL+hPl2zU+16P7HRLDJzA05QoXLml78VR4WOnV5zHm9/VTcfYja1m4s/USX9bSzhnDqknS/GbFLEocRmkwfEuZwJvqlJ5LZaC66JVpm5Wt8c+ufgEW7WgH5F5PY6uflG/b8uDEG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(26005)(2906002)(54906003)(8936002)(956004)(2616005)(6666004)(44832011)(1076003)(52116002)(86362001)(478600001)(5660300002)(8676002)(38350700002)(38100700002)(6512007)(186003)(83380400001)(6916009)(4326008)(16526019)(316002)(6486002)(55236004)(6506007)(69590400012)(36756003)(66476007)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aP34bUQS1TGEzh1TtNQJlWFKz3+4LIfoyQAHKWmj8A3frDHScF2fcx/f4ABy?=
 =?us-ascii?Q?5nC60C7nnwpHQqTGyAq6c3DJOJ/vJeXEU617HeexaTKfxPoYrJ8OlbxIRxjO?=
 =?us-ascii?Q?rtl6Pxow2zB4plbr3kDAOUgfeWQAy/laRH4tSCIH2lsERUAiz5lU86TZ7Obd?=
 =?us-ascii?Q?4EbhTbyZoIEBH31k8c5RxqVSrlqMxkEesdWGVjG984moS7xhPjED+65KUmuu?=
 =?us-ascii?Q?vB7nPCJtwlUVJ4T3K+e2CtGwN2wxIWscQ/5RJHKl9QdpDglk16fY+efIOHx6?=
 =?us-ascii?Q?7ORMuXerwlAulv59dEtqiQqr1dkf1Nf3aO56QjmC8Ww+Luw7CQk9hy6x/KNn?=
 =?us-ascii?Q?i/qfK7X/Wl5wYgkg9EWCZKDi3Xy/u4cnN9pWXsIdg4fnNkSTTsne+MVcSqZm?=
 =?us-ascii?Q?EbRixGqOWbKSC5eitG2lrA9CXQ1dxki7qCscZ/Fbk1m+prFx93LV3Yzd9jNY?=
 =?us-ascii?Q?YpEOc5r+3vSSCLPQ09Pw6e6bCpMcmfLda21An3eumLBYw39TbQNpcgwPEHvb?=
 =?us-ascii?Q?n6vPVwRDVArl40v0juoqc69z5s+83POdLtHB8gFyBfcGz4zX7K4GzQDG4UI8?=
 =?us-ascii?Q?+CQzZjjZX3V+HGFrkRvEysMmoZuE5cHz0c8GUSpy8l8AQhnJDvgcTNrFeMTl?=
 =?us-ascii?Q?Sk3jPkk2gT6m32cXpLr0QGKWrulj0S0RDagctKa700AJsumkyNIiZ8nWi/P0?=
 =?us-ascii?Q?j+BQXrqakcW8fShMNpd6qS7vzr3NQalRSPziUAGd2r75kTmLWapjnWy6cL/l?=
 =?us-ascii?Q?3yvze2S8lsgPBM5LhgaauDKx93J3Xb3iX7RawIIUq2NQ8zEIASMPnpsYprNM?=
 =?us-ascii?Q?ZHJnCGAHvuQf6A2G92pDKN/PUeXY4s7bweQAA/1IIUemXxS8lhT9u5Om9kf9?=
 =?us-ascii?Q?8oODmFeIx2FJBGVDJ0u8o8D5WZXrLUQQpgOGHknGP4iDhoSqNhkAZ/uoG/8G?=
 =?us-ascii?Q?mqjgWrum9lmM6ZJ6Rcx8aKYyTCf0DjPFjRBPKXnCKwg/9T/6rwYCUmuZXgt3?=
 =?us-ascii?Q?edSbx1+qzhI+ZlGDI0jyl1JpwVnTQ/3Qy6P1TnrYz5H/k2z0p9pPS3C+w1hv?=
 =?us-ascii?Q?Rmb63dRyLWCWmEbDIxgwoK+4NVAMqKMRLg0O5GuHm/zZtt8JlDt4oxSXj4gd?=
 =?us-ascii?Q?2v4o9ELmMkx6ocTERndR49aaPQ8JwmwytrySqe5NPbVXPBCJUoUn/VNX0J0k?=
 =?us-ascii?Q?kQEJUOxlFrr/dfR6ciRRFs+H5KhT7eUtPUfRga6UuiLTRQjDJzZiB74pha/e?=
 =?us-ascii?Q?oX/2RNueNdHCYCO++6TezgriaFXLFrvcXMSMmp03tZNFUpInZiNn+cBGs8XJ?=
 =?us-ascii?Q?8k2BNiWgpJOh1K3OH+ws9+Fd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9a91f9-c46d-4667-4591-08d8fd5074a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 01:15:27.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at37Ge9zxjGc27vVPYLKWWbch3hQf9NasK362LnuBpKLQIncxWgv57nJCMxWLwAS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

* Remove double-sscanf to scan for %llu and
  0x%llx, as that is not going to work--the %llu
  will consume the "0" in "0x" of your input,
  and a hex value can never be consumed. And just
  entering a hex number without leading 0x will
  either be scanned as a string and not match,
  or the leading decimal portion is scanned
  which is not correct. Thus remove the first
  %llu scan and leave only the %llx scan,
  removing the leading 0x since %llx can scan
  either.

* Fix logic the check of the result of
  amdgpu_reserve_page_direct()--it is 0
  on success, and non-zero on error.

* Add bad_page_cnt_threshold to debugfs for
  reporting purposes only--it usually matches the
  size of EEPROM but may be different depending on
  module option. Small other improvements.

* Improve kernel-doc for the sysfs interface.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 67 ++++++++++++-------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0541196ae1ed..c4b94b444b90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -114,7 +114,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	if (amdgpu_ras_check_bad_page(adev, address)) {
 		dev_warn(adev->dev,
-			 "RAS WARN: 0x%llx has been marked as bad page!\n",
+			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
 			 address);
 		return 0;
 	}
@@ -228,11 +228,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		return -EINVAL;
 
 	if (op != -1) {
-
 		if (op == 3) {
-			if (sscanf(str, "%*s %llu", &address) != 1)
-				if (sscanf(str, "%*s 0x%llx", &address) != 1)
-					return -EINVAL;
+			if (sscanf(str, "%*s %llx", &address) != 1)
+				return -EINVAL;
 
 			data->op = op;
 			data->inject.address = address;
@@ -255,11 +253,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
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
@@ -278,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
- * It accepts struct ras_debug_if who has two members.
+ * The control interface accepts struct ras_debug_if which has two members.
  *
  * First member: ras_debug_if::head or ras_debug_if::inject.
  *
@@ -303,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *
  * How to use the interface?
  *
- * Programs
+ * Program
  *
  * Copy the struct ras_debug_if in your codes and initialize it.
  * Write the struct to the control node.
  *
- * Shells
+ * Shell
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
@@ -336,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
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
@@ -367,11 +364,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 	if (ret)
 		return -EINVAL;
 
-	if (data.op == 3)
-	{
+	if (data.op == 3) {
 		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
-
-		if (ret)
+		if (!ret)
 			return size;
 		else
 			return ret;
@@ -1269,6 +1264,8 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			    &amdgpu_ras_debugfs_ctrl_ops);
 	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir, adev,
 			    &amdgpu_ras_debugfs_eeprom_ops);
+	debugfs_create_u32("bad_page_cnt_threshold", S_IRUGO, dir,
+			   &con->bad_page_cnt_threshold);
 
 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
