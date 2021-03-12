Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE351C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE87364F70
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE87364F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF8A6E041;
	Fri, 12 Mar 2021 21:24:48 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680075.outbound.protection.outlook.com [40.107.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E36F6E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 21:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoT/3aX7G/nv9Sad1c4XdLNNNk5BgGCgjH9xpOdS2CZGrcVd234zQxBftwy/MMmnQGXd9bF7deOk9uX8DYON0Uwgxaoa2XzVWJ5QUhYMDdGa44sb7w9xuMwtOp94fpY/I8r81GZd8X1yySu8NxxPVmpKm+p1RmzwJ7TzW91B83kIPreeneD7VtXqoE6Oa4Xj04n/mS8jKHiBaifcgAy0EiZkxz7FkMXydwKqijbV5dTj43YCSfcHredxSZbwFueIn/aEubzQ9uMtngzbb2qqYKQ6qSTkCsr8DmTCmhuo7Xd6Y/5T4uoKkgNLbZTwxUjmAHqaiefwcNLjJNijpdRdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gewuxac6fAkdUgNRqwJkxXxr01JiRUTBU2Na3VTLnCU=;
 b=HOQfMhkYZwB2YI74JpUFy9S9ncEnnuP8q05ZS34pJnDsnQk0mDwG3NUenZvs9d6UNNHKJ/7Ihx1EPymuwATRdq4qdZXX+n0lL+jFOc92N3yMkrrDsMPmQnxTfs0CpDUCt50VokqrTDQfQOn720GHY5hhnzYzZFgTItTSs+9wiAyP4eRIM9G7SASH4TZ/+7jUD9xZ+JpYtku7jNVYNZucFhLk7qNZ/1mvHY/B9Jw37Tqi+w/7yqYXCsnLVCyfiKXs/VpDpmcWXihrM0qtG6CA+jRFSF19ZAJ1FDsNPm2U38H2Cz0vp27Pxjx5l8RelQyIBq4wu1xiT1uFobs8ZDhM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gewuxac6fAkdUgNRqwJkxXxr01JiRUTBU2Na3VTLnCU=;
 b=salUqFeJCMaQW4YNpOl9UmKsOTrpH1kmrh/rwgf8taUp96V1GSmZWq0PSbazgmzk+LAIWG5ZCnUEKT39HXIHQR1B1chD+ZcvrijFsavi4OdpNnuiHYTNsDrQPLjiXhcoK/7ZmYTt3ht/iRO3nF54es1sqTz3GcACA1Rri+pQSf8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Fri, 12 Mar 2021 21:24:45 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::45a1:94ba:f88c:92e2]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::45a1:94ba:f88c:92e2%5]) with mapi id 15.20.3890.041; Fri, 12 Mar 2021
 21:24:45 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Date: Fri, 12 Mar 2021 15:24:35 -0600
Message-Id: <1615584275-16432-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615584275-16432-1-git-send-email-Oak.Zeng@amd.com>
References: <1615584275-16432-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3912.26 via Frontend Transport; Fri, 12 Mar 2021 21:24:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1af89cc-2409-4c29-4da6-08d8e59d41a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB402892ED5DCEC23911C54E8E806F9@DM6PR12MB4028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83aHfW5Xx9jxr1SzvgCLFvzU0zde9TCVkEekZ6hxY1raDgrzg4mE4hIs6Ibd/ovW922IHYmgqFd0Ax64iYNnouASmbbIqdmNmb259UD/A1i7CGPGZQHyw4tCqF7gJbXVpDXU9M1Pv3i6C28fgIzFZjeF2h+HWcRZRBB3nkCNe7iuyTOuQdFikthgAmTRsGZAlWFJXWgd2KMz0eznyVAvMH5qCFmI+bPBVGOyEvKd3gkls5npLWfgEiuv/mzBcxyJU/TlXEFJRLijx8Z0fFmn2edXbYPouEnUe1nR5O6+XhhGuFP279H/ANQ/uXflZuMBgElpywmYHPgxS0iiVB2q/jYCJ6glBHB/kr7UleEUlFXO7ttrxcGFVRIZgRutMEKvikstZL8lx1GlUHXEihufxck+cWL12uGxbQ4Bnn8uQLbV6hTaWvaS9NtScpWVrTD+t/ynWam+rF+nI0gsfJgPpNCeHWvTtZxrI1GfVYtdu+1rdsPaTXUgTXG925rDdLkBStQ/FZzoULvArTpowM5Uxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(6666004)(7696005)(66476007)(6486002)(478600001)(52116002)(86362001)(66946007)(2906002)(83380400001)(66556008)(8936002)(956004)(8676002)(316002)(186003)(4326008)(5660300002)(26005)(2616005)(16526019)(36756003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kLXq1tfeFEe+5oAbjnAAsUk7GrOwoyRgkk+u0oBLqVIuKCRyI1y8ctmEmyex?=
 =?us-ascii?Q?WWSK2kDViFLkjpP+7leE+VidXH0f0tgmfmq8nvGXu6RRDdbLieBOI+hxtx6k?=
 =?us-ascii?Q?i8P6DYR/4K4e2NgFd19LmjV77fCUEJIbIqjAFn6vmF0I4meaux4mJ6Nlp46p?=
 =?us-ascii?Q?RdFZwIWOUDSc/5/yuZ2qwMYGrD2eBdv9LYrjoV8M6LD0UWLbq/ieoBXGu5Uc?=
 =?us-ascii?Q?8tJ6tVGwnmeFaxXwdGQiHx357T/hvPEt0ikmJG9dAKKu5OG8QeQHH3fyBMip?=
 =?us-ascii?Q?irfaXEmpgRwwHQIW44FIB0l3QFBctGj8IrMXKO5SM88KHoZPb3cP4upVTl4+?=
 =?us-ascii?Q?uQCdrzyt5+r2sMCmRTu8By2LRJl8QqXUlPmRRQ4q1TYBKBud1OgmOzj4Oo1L?=
 =?us-ascii?Q?Fh6OYxW1MS7iJg/hLRGJYEURNdQdSN75wsQKFeE7sB4Rwnm+tlsGbYArT8NW?=
 =?us-ascii?Q?RJHJNhsD6NJ0ml5vk9e20DtF3RopeCU45x99xFPI3dPttlSXyCWaqO5oGHnX?=
 =?us-ascii?Q?v/M1WycaFzDZfAFx3OTMUji5TQNxINCtoie/yuedk3Ye5Xg9dJrLkezARnDc?=
 =?us-ascii?Q?d7FUfdo/BREzWrS9JP0ZAyAM7krslWg+Hfwkk93LdcwYR7D51t0+9upjP82L?=
 =?us-ascii?Q?sxF8k3jO0CNgEV+oVArst+cPPHoiB0DHgS26LhtLtWxub9z9DtDHNyrwyGDs?=
 =?us-ascii?Q?YsqTlhvOhZwrCwoCfH/K2ATzDfjq7TFroUCs4mDGsv4yVgxZHzw8I1ZEHVWl?=
 =?us-ascii?Q?rceWNLjnekw0MQl1ph+Nz4RffqnpQLbprJeo1ri9el/Ish76MZwQrkDNOCC4?=
 =?us-ascii?Q?zszqyXkirfkNRCtrymiLxQKFsY4BVzwB/EtlTsdZQ65W8OgM6OWzbznVQ/OB?=
 =?us-ascii?Q?+rfWynzh1PZ4Ibr+Q0BPKM8mGtKsO/1fqsb6b3zboXQq3CzifrfM84t+xf/F?=
 =?us-ascii?Q?9IClY9f2lO+8voYmdNSD1fIAvgMm8C71fL7yoWBjHdpliX9tSPJ7FMdpQMOu?=
 =?us-ascii?Q?QhrpIDdI2WPmnWwHNaa10OTADmrQiIjcdOR3wjE7uNRycb6AqJk7PS57m35R?=
 =?us-ascii?Q?DFakLlp22OKZHy737qMXlT3y9zih0/P39gSkfUIbHFeyJ1AY7QCFIbuj52jF?=
 =?us-ascii?Q?nOnBqfJD9ASIBahYINuQiBiSqq8RkHSQTqNGP4ioowkWi+uIZDAC9IwPruRF?=
 =?us-ascii?Q?gNQ6exqeiWC+tB5ADRhMgaN2urDyGeUksBvybhyVciES/1cAuMS25ybJJaZx?=
 =?us-ascii?Q?phmkIcHS8ZelIyg4kMYaccKAzKzLgfn3DqHBdhpLX6IJs/IP3DwaXK3TDCHj?=
 =?us-ascii?Q?RZDnl3vpGX8gXUYvl5RQr/X4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1af89cc-2409-4c29-4da6-08d8e59d41a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 21:24:44.9177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvV4k1pK7nTr5nrXSvmWyGtfNRm/V8bR4eYN9+INGCR6mqNEq+7PyfYdWefXX3B7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4028
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
Cc: felix.kuehling@amd.com, Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This new interface passes both virtual and physical address
to PSP. It is backword compatible with old interface.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 11 ++++++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cd3eda9..99e1a3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -328,8 +328,13 @@ psp_cmd_submit_buf(struct psp_context *psp,
 
 static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 struct psp_gfx_cmd_resp *cmd,
-				 uint64_t tmr_mc, uint32_t size)
+				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t size = amdgpu_bo_size(tmr_bo);
+	uint64_t tmr_pa = amdgpu_bo_gpu_offset(tmr_bo) +
+		adev->vm_manager.vram_base_offset - adev->gmc.vram_start;
+
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
 	else
@@ -337,6 +342,9 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_lo = lower_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_hi = upper_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_size = size;
+	cmd->cmd.cmd_setup_tmr.bitfield.virt_phy_addr = 1;
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_lo = lower_32_bits(tmr_pa);
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_hi = upper_32_bits(tmr_pa);
 }
 
 static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
@@ -456,8 +464,7 @@ static int psp_tmr_load(struct psp_context *psp)
 	if (!cmd)
 		return -ENOMEM;
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr,
-			     amdgpu_bo_size(psp->tmr_bo));
+	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
 		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index a41b054..604a1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -170,10 +170,19 @@ struct psp_gfx_cmd_setup_tmr
     uint32_t        buf_phy_addr_lo;       /* bits [31:0] of GPU Virtual address of TMR buffer (must be 4 KB aligned) */
     uint32_t        buf_phy_addr_hi;       /* bits [63:32] of GPU Virtual address of TMR buffer */
     uint32_t        buf_size;              /* buffer size in bytes (must be multiple of 4 KB) */
+    union {
+	struct {
+		uint32_t	sriov_enabled:1; /* whether the device runs under SR-IOV*/
+		uint32_t	virt_phy_addr:1; /* driver passes both virtual and physical address to PSP*/
+		uint32_t	reserved:30;
+	} bitfield;
+	uint32_t        tmr_flags;
+    };
+    uint32_t        system_phy_addr_lo;        /* bits [31:0] of system physical address of TMR buffer (must be 4 KB aligned) */
+    uint32_t        system_phy_addr_hi;        /* bits [63:32] of system physical address of TMR buffer */
 
 };
 
-
 /* FW types for GFX_CMD_ID_LOAD_IP_FW command. Limit 31. */
 enum psp_gfx_fw_type {
 	GFX_FW_TYPE_NONE        = 0,    /* */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
