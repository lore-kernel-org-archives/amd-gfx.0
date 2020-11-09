Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2FC388F7
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 15:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C22206C0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 15:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0PsP8hZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C22206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD7E899EA;
	Mon,  9 Nov 2020 15:47:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2573A899EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 15:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARKRoBfic5SsXM3a3D2J/aAKCgKlAz1XlNL2Ol85LNP+F6fR4jzsm3esLwQpjG+u8BzOtkING7EljiZ0J12Knu+grhWm+9X9sfOJTydxV1HlhqiVflAckE2uNkkPV7Luh7aIbrHi/yEuCtX8fpaHO0e8Pdty3l2xd9z6h9QHs0VmVloBALKZ8b0WL3teb5VXmUYzNtm5Ek7nyg4ewv5tHuRHUv3tqBtJQ+nGtBHAjeNxSsff1Rib2kfZ6uHKdjUTTk68CQ9t9WUBzwUaQTdX/aBLGBAUrVXsp3p3xCbwHpfEZMA124SUDYV9qjjscjSTr1R4dlXdeq6LNbnhd2/rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqJRGKvb3HrxJvwh/NA2YhTXWwi8fXk0hFhw8fSzvV4=;
 b=Ln9JcMChNYlNfwOfDcwAKk4QChljR+rUgt80RzQzwDf9oW6WQAG0oeN9rweSEBDqxCFuFnSHJyVWHRmuRAyuhdD30uE9a8PTDNNfgsBlFg+6oRInfr0BEXxqgfxmsu9UBB6Yb2wQWtGmAcGUJilTz9O6ooOL1/9xjQtV/wdD6/lGHThFQoFXTh0sgI1dm5KpN5phh90sQB0dmgzeSJJSAyfvm36eGlIT1qn0dKpJDTU+P0TN7QfQ7cYA8sixR5KnRHomb1hAAjeJFdhLvI2D1Tvv52fOeVdVYaRYYgAQw0DKraOdSziDxNaQKkGiuJkIx5mEwrpVtCbqagJVFQNt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqJRGKvb3HrxJvwh/NA2YhTXWwi8fXk0hFhw8fSzvV4=;
 b=0PsP8hZHwopxwvXpjY7e/yoCLX0FWH6u5fZQH7ZQKZPXODGWgGU4c/xzZtdzDp5k2bvdmu7lBpnrHn+cG0sRqFmh56P/uHdK4mm7TpN5+1ciewWMIdBqYiT1U5gY2ucMpYfiIoTScFWrEz/16mKYBOPU3muM8qjB3FyPy4HVKj4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB2778.namprd12.prod.outlook.com (2603:10b6:5:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 15:47:56 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6189:19da:5195:201]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6189:19da:5195:201%4]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 15:47:56 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Update mmio read/write access via debugfs
Date: Mon,  9 Nov 2020 10:47:47 -0500
Message-Id: <20201109154747.137388-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:404:8c::16) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR07CA0006.namprd07.prod.outlook.com (2603:10b6:404:8c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 15:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e5b80b4-a070-4227-776f-08d884c6d36c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27789CB79656FDF2D74BEDA7F7EA0@DM6PR12MB2778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzqnDfslw5wOoF5IsiXbUPu9B4QyrVEYQAnE2Ds06aL7npnTxexvvJhsPEoiDqwuCHDt4voF8va+eMSEt1uBHkQyQz5e1G3REBsfUTt8q17cwrKPJQIt7rEZbM7OdWDhvuPLdRqSZpaQeRidQTTG21d4ZEq8KR8Ir3d+TBdmUFxZ0Yl74EjhYNKl29ubHdc05iDE3ZPhJLqRZOHrz3mAGNSlzpp+1ItI5p+3p8MR657GZVfvl4IQ4xaJkqgJkQWF0nfMJP6BEEvCW0U6QnB5CpE1bCuhPQf5uvP+DNffFhDbOj/LJ5gMUstUwu77scJJmWNnbUndaxMm8tsopS6lsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(478600001)(15650500001)(66556008)(16526019)(316002)(66476007)(6666004)(26005)(8936002)(186003)(6916009)(66946007)(1076003)(2616005)(4326008)(8676002)(52116002)(2906002)(7696005)(36756003)(956004)(5660300002)(83380400001)(6486002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Rva6eANPNcNInhSzxlqYzOxuWmoMlaJ9ZQ2ydeWzIJVp9LoeMepeV4lYTJ20dkkHeBd+xODkMAQHHRI/xb03U3wXvHWobkVrQmcg3SeSzU7zNQGYy5uDKTN0otZ4by43GRrl9EEk7yMFcXcuJNTFiGBh3331U7L5480YkaN0wCQansij598M7eHrPgQYmr8jcOkdJG/zYK27YC6TY6DoDlFpgJLmdbNw2k/i/Hw8xIymguNz3I6cx6VNLjl+VDmLnb5RMUK7ejxH58MDXcoQxd1XdOkQlaKtiSSocY82IDsGNmLo7Z1FyVWY0zUphLusjpjXdtN9roNBfLASLRuwu3QmV2nsd/CD1Tv2PvKRFx/uc9M8AwuXaIBN/FqaWNwj0UfVv9TT26pYHJKKJfvBKeUIqvWByB09AK6AC7vY2DgkE2jWlr85w0p7kOa0e9LPVDUOmLbeJT5jN3UWJs/zZkGhYxY3gNJM++Ak192EeoHB1ZeeYEi55wtgfvJZ7T09CNJo5IG3ddSAADcWlgZ0xRjSS8JjQmE/wel+XDUDb5W9l8j8lPz73tkvxkeGRxyLu9aTUEgGsOoxBzX2ccQ9mqahBzcVx+0c2eU6sv/BBDytFrN2q0ZuybfCF0+pNdBXCchGULW8J/V9NtHfa03OBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5b80b4-a070-4227-776f-08d884c6d36c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 15:47:56.2734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X9ctH3Yhrk9jw9hBZ6Oz+8nO/yf1jjJ8I3ZBOH1cFwtsSExH7YM8BUQDTxV6aVomsS6QZLV1gmYpEI1gHzmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds support for wide MMIO addresses (upto 32-bits wide)
at the expense of dropping bank switching support for these addresses.

The patch also moves the PG guard bit to bit 59 which breaks compatibility
with older versions of umr but only if they are running the "--top" command.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 68 +++++++++++----------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 41ca13f0acd5..dd9df90a3bff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -171,13 +171,14 @@ static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
  * Bit 62:  Indicates a GRBM bank switch is needed
  * Bit 61:  Indicates a SRBM bank switch is needed (implies bit 62 is
  * 	    zero)
+ * Bit 60:  Indicates wide MMIO (32-bit address), disables other features
+ * Bit 59:  Indicates that the PM power gating lock should be held
+ * 	    This is necessary to read registers that might be
+ * 	    unreliable during a power gating transistion.
  * Bits 24..33: The SE or ME selector if needed
  * Bits 34..43: The SH (or SA) or PIPE selector if needed
  * Bits 44..53: The INSTANCE (or CU/WGP) or QUEUE selector if needed
  *
- * Bit 23:  Indicates that the PM power gating lock should be held
- * 	    This is necessary to read registers that might be
- * 	    unreliable during a power gating transistion.
  *
  * The lower bits are the BYTE offset of the register to read.  This
  * allows reading multiple registers in a single call and having
@@ -189,45 +190,50 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	struct amdgpu_device *adev = file_inode(f)->i_private;
 	ssize_t result = 0;
 	int r;
-	bool pm_pg_lock, use_bank, use_ring;
+	bool pm_pg_lock, use_bank, use_ring, use_wide;
 	unsigned instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
 
-	pm_pg_lock = use_bank = use_ring = false;
+	use_wide = pm_pg_lock = use_bank = use_ring = false;
 	instance_bank = sh_bank = se_bank = me = pipe = queue = vmid = 0;
 
 	if (size & 0x3 || *pos & 0x3 ||
 			((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
 		return -EINVAL;
 
-	/* are we reading registers for which a PG lock is necessary? */
-	pm_pg_lock = (*pos >> 23) & 1;
-
-	if (*pos & (1ULL << 62)) {
-		se_bank = (*pos & GENMASK_ULL(33, 24)) >> 24;
-		sh_bank = (*pos & GENMASK_ULL(43, 34)) >> 34;
-		instance_bank = (*pos & GENMASK_ULL(53, 44)) >> 44;
-
-		if (se_bank == 0x3FF)
-			se_bank = 0xFFFFFFFF;
-		if (sh_bank == 0x3FF)
-			sh_bank = 0xFFFFFFFF;
-		if (instance_bank == 0x3FF)
-			instance_bank = 0xFFFFFFFF;
-		use_bank = true;
-	} else if (*pos & (1ULL << 61)) {
-
-		me = (*pos & GENMASK_ULL(33, 24)) >> 24;
-		pipe = (*pos & GENMASK_ULL(43, 34)) >> 34;
-		queue = (*pos & GENMASK_ULL(53, 44)) >> 44;
-		vmid = (*pos & GENMASK_ULL(58, 54)) >> 54;
-
-		use_ring = true;
+	/* is this a wide request? */
+	use_wide = (*pos >> 60) & 1;
+
+	if (!use_wide) {
+		/* are we reading registers for which a PG lock is necessary? */
+		pm_pg_lock = (*pos >> 59) & 1;
+
+		if (*pos & (1ULL << 62)) {
+			se_bank = (*pos & GENMASK_ULL(33, 24)) >> 24;
+			sh_bank = (*pos & GENMASK_ULL(43, 34)) >> 34;
+			instance_bank = (*pos & GENMASK_ULL(53, 44)) >> 44;
+
+			if (se_bank == 0x3FF)
+				se_bank = 0xFFFFFFFF;
+			if (sh_bank == 0x3FF)
+				sh_bank = 0xFFFFFFFF;
+			if (instance_bank == 0x3FF)
+				instance_bank = 0xFFFFFFFF;
+			use_bank = true;
+		} else if (*pos & (1ULL << 61)) {
+			me = (*pos & GENMASK_ULL(33, 24)) >> 24;
+			pipe = (*pos & GENMASK_ULL(43, 34)) >> 34;
+			queue = (*pos & GENMASK_ULL(53, 44)) >> 44;
+			vmid = (*pos & GENMASK_ULL(58, 54)) >> 54;
+			use_ring = true;
+		} else {
+			use_bank = use_ring = false;
+		}
+
+		*pos &= (1ULL << 22) - 1ULL;
 	} else {
-		use_bank = use_ring = false;
+		*pos &= (1ULL << 32) - 1ULL;
 	}
 
-	*pos &= (1UL << 22) - 1;
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
