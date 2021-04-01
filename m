Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB4DC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCFC6108B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCFC6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57A66ED07;
	Thu,  1 Apr 2021 19:36:54 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3024F6ED02
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFaO4SefbxcUvGn0tNyMa5R+NnpZlG9h6FROaSu186IDEFsEVBL1lQTFqmzlKu1cHXqM0vBSPzTr1WIUIfEnMpZVzwejbyHig07eFcnsedvARRB8yGtEv5xJOW6pAmLIrfeq7EDkeSDRIhQKm9djMaQFDUl4rBCYRYIUS+9oJ6PtV9VMKBzaEqTnMD53yAtayNubk55oFqnrw1BKwixZLmWeue8OE1G67yYZrBNj6zZxtYglw/EG9y/KMdjWGtTpvPZJfymJ59Y+JtYg0LHi3RwrxSViOG2yNKPJXuJE75c/aJw8ss9j/fWGxm2yZLcRg3ad3DfOfYHVSgAh/MzaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxdvQCCnonqOQJuLPaFqQMJfqBq8el/UG6N9qIBW+Ok=;
 b=j6MFRWIXRBEZ1r0ruWFUFvOCBpIkpuV+f3WJ6VXNfhYxVTu809oTIiLGlJmLTBGe4oAtJhJH9GQ9qzX+O+4stFwkFLRi8yQOBylSwsfArQ5/gQLkbYsL23zZ3cVjflP/s+YzTIOXU3AVEbMfpnBwxXZTlVEN2/gO3A5gms/YSFcEH66/XiXbnUvLoW/vppLOiDN9auR8pz9dgVpGfgNEVFWIJzyfiTCth1/uLKTTt/DkBS0UkNx80f8au9Fci5Z8OlvodHKc6NzkU3DFsB72tNiiki0Y1lYNKeaeqWv/zdlqOGuNCDrz1ZaYKUGDiIbMPbykuLxwghRP4Ag+YI+5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxdvQCCnonqOQJuLPaFqQMJfqBq8el/UG6N9qIBW+Ok=;
 b=DWB2T8XBYkqk5/LRaO1iADLZmsPhpA8Z7NDEsom2+NWPJkwjwYotembT3Lv04WMejYUADRbpi77rVEDOajajOva/MyVm3nZGqgO+BpyPLZhIvO/1GU2BOTgJ3dqUOwOWQywwdY1Q5E1mJ3XhMkxThspy64EfHmxIBNczI/9Y01I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 1 Apr 2021 19:36:52 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 19:36:52 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: Introduce new SETUP_TMR interface
Date: Thu,  1 Apr 2021 14:36:42 -0500
Message-Id: <1617305803-5767-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
References: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.30 via Frontend Transport; Thu, 1 Apr 2021 19:36:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45035184-d0dc-4f15-9a0a-08d8f5457fbc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42031771649B40BEA96235B3807B9@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZmUqjJnMZF1bZgCgam7yh3xxXvJaciyIcnOpZzzOOpKCdylTwRuNQG8z1G068qA/BH32GJSilOE06XsUqNu3nDgYf0TSNijoOyU4Bsjg6JTPLKlXWKlBH6E3cat/BXuMBtx6WAMukHG6qNnzxwCUzrvuKmlvJB9EvmXEi60d0/Fyj8wJgDmtQd9wy1neBAaYx/8T/Q7KkXYcbTH3j9boXWTKBrH7/tefd5nZNBJVABeaEwxKLLyiGinZzOGAmhiyGDxLIVOlErf8dtp/pD0v66txAPgWgxMBRqcY4Hxlzbo9khq8fp60bML3dowzYdmTrVZnxSU0eocp4ggwNUxLbRId3FLHz6HXJ2q3ObytbrsLJxnDhcJPUFMGrLkM5D7a/NzTZIF6a+9eV0a1MUEABldrvCehMcaky3R+bw5lsH76Y+WD9BKFOXLLn9f1wAvdRwftzDz11Dv/pmCzcpdATLG3qr7a0vswGWnYlZ23dc1jvSbac1jcoIJBqUDF0Kfc1Wr0Rm5dE9UlWsc7WZHGklMZ1omJ5Fe74hajeskr9MhVc9+dSpQqZyKmB72SW8/DIaPk3AM6Zn2KULu1u0NLdtOf7GUI45cZ3wum54Enh7945OMxgHg/Ar5vjZOnlzV0oYjRkIxoKtSRoUyzEb66Pi8yH3QpQuEroEehC5GobE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(38100700001)(66476007)(66556008)(6916009)(66946007)(26005)(52116002)(16526019)(186003)(6666004)(36756003)(8676002)(7696005)(86362001)(6486002)(83380400001)(2616005)(478600001)(956004)(316002)(5660300002)(2906002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BZ/cECKqtqFH3iCfRe4Qygg6W7DGgJb2M15qtr6Cx7TrbuaNmUlzEhF95l2b?=
 =?us-ascii?Q?r7s54A0xqw6Eq3Hs7U7JqDsoysyvLF+8ioTOe4JT3ln2Qh64FGojTkGYisQx?=
 =?us-ascii?Q?o8mRfMqPjGOnaojf1mo0BrIAsOmKKz9KYidOC3C7QSfhZ05OCtT3UzMYjSnu?=
 =?us-ascii?Q?4faUun4dOCb/yJMIBhVUq7edZRp1O7AJIBeLTKt8QO3kMgP1V+xs6gZ5WUXo?=
 =?us-ascii?Q?3+eBid23uz7EA7OwBkt/tHEkfUSklpZSRtyDuEqAKBk0ui625DUl+6pemgcs?=
 =?us-ascii?Q?scUEP6Wbh7WOtpf7CKN6G1HlKZvnk9LuesFSsk8QYRH5/FEkmiSuXOTaUwOy?=
 =?us-ascii?Q?5/ODmduRe47tNPgO8jWJkk81n94HVSr80lI/Kcuf5I+ZcLvIIzghatifT1sU?=
 =?us-ascii?Q?OM/kqPXxAMJ1c9Aaer3UkETQnOsiVY/OJDd8lP7kCAI0jT6Ca9NPfPVKf7Zh?=
 =?us-ascii?Q?NUClX5VU6Ko5JB5r+4v1uZtKZggMzfM2LvVcCHUT+oUZIrMP6Ylql05Fvi5g?=
 =?us-ascii?Q?k3nijgp4gOqqor4a4JMQsbQ9eWgLm+0t8egNUHEdOhl8Vm4f28/wWZtOXeKn?=
 =?us-ascii?Q?xxMItPW7bc7FjKW6KGeBLbrSyBID2CTlOxp0bt8xQplnzohIQnuOKy1u63cS?=
 =?us-ascii?Q?iRuovc0yAtgKz5RS/E2Akn56sbv0tK2h2rSzV1jPSQwdaJrH6w7XYrEO6jqE?=
 =?us-ascii?Q?BFTZ2bxgakuS4aBzzpVqi6Ofz1GXTCUTY/eaEvFQxjZKtn/ROJ5kBwAe/wYX?=
 =?us-ascii?Q?2S9/v572Omt80AD8909HQM3KeZ8iVHIHCBC6xcWinnvWGYNsSRDzx9SZ9qMY?=
 =?us-ascii?Q?tlVv4rLcd+ME3FlStvoxZVGzoerFttQnxNans2rbTTtDVFxq4HtPLYoRzlmx?=
 =?us-ascii?Q?2rdAKlPyJHyJiJSg+vRmbJgdB1EvITqWJnemlI+ON03nF490n+quLviRo72k?=
 =?us-ascii?Q?NQff+S5bd0kHmvsYmEo2u3xsNRmp26Nw1NIYW/D8yFdqPIuXwxUybNwHKWJV?=
 =?us-ascii?Q?Prbju74b8rSERv2sUvYC+nncqQvpyU7yy2hVR7CWhW3JJEQaymHFmNdO5elf?=
 =?us-ascii?Q?uaaSfxag2M1w/bKCSyN5kmCxejJzQs/7hqMddDNHhiTNWVaA1FwtByhiEE3D?=
 =?us-ascii?Q?O52XjaawEw5f0f3sgXAqdi/4F/aw/XuTlyd9VwP7juSfZrqvYX5fGqjJO0I0?=
 =?us-ascii?Q?9DmISG3yq3DltzwphKi2EOiON6HX3Gc17zm9rw4e0dfUx7pauX86ZC5SnG2Z?=
 =?us-ascii?Q?UBPzMSoj/sH7AHk1oQ3JZ9hH7mGH05rKTKoyb7iZUnLSZsnnrnt2M+J4Fy5I?=
 =?us-ascii?Q?Af08aWcjBxVgFhjDJdbOe2pJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45035184-d0dc-4f15-9a0a-08d8f5457fbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:36:51.9459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKPSEeWOsZ+ODfic+88fCcembqB6MciD0gsRSOx2oSo/ByPYcVHlvNE0lQ50sgVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This new interface passes both virtual and physical address
to PSP. It is backword compatible with old interface.

v2: use a function to simply tmr physical address calc (Lijo)

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 11 ++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9e769cf..123ab31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -328,8 +328,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 
 static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 struct psp_gfx_cmd_resp *cmd,
-				 uint64_t tmr_mc, uint32_t size)
+				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t size = amdgpu_bo_size(tmr_bo);
+	uint64_t tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
+
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
 	else
@@ -337,6 +341,9 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_lo = lower_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_hi = upper_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_size = size;
+	cmd->cmd.cmd_setup_tmr.bitfield.virt_phy_addr = 1;
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_lo = lower_32_bits(tmr_pa);
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_hi = upper_32_bits(tmr_pa);
 }
 
 static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
@@ -466,8 +473,7 @@ static int psp_tmr_load(struct psp_context *psp)
 	if (!cmd)
 		return -ENOMEM;
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr,
-			     amdgpu_bo_size(psp->tmr_bo));
+	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
 		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dd4d65f..96064c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -185,10 +185,19 @@ struct psp_gfx_cmd_setup_tmr
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
