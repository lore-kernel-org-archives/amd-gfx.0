Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA52C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1D1619BF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1D1619BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D038F6EDC2;
	Thu, 25 Mar 2021 16:38:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086056EB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPlpgxOweMXupvZIFygJxTvTPa9XWBxwgJpdRR6sTmgBswUcIELTncnu/XYPuHg9qWcSerNEht8LbXWKpfeYl3wdmNniouYJi1Tbf0kXW2YaCqxyepvC2orTGj54Klj3nHooyXd0eCJHjC5A8la5D7OGG9o3U0GoHSPC16xXlbBKto9TpQWqJif3P4LHHAXsFKxyfNODiAcW0E8T7yXu5ZuHrxO3XD8Hv9GpGql4lEilYdg4tc0/9T6Yv7rGNt4f+WXTwIWzo7OLli0SA5eAJSmkI/my5vk4p6fQtfX6ktB+PXMvT9VqF2y7rTj3nlZc3WunquBhy/SuPm+GDDssJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUGEY+pBlyBIdebOjsE8qh8esL1aV9NRIhgGOFGt0GI=;
 b=nBGy/JsECm5B+VXJ9QSALAWd/gGaJtX+ysBB6AIynuzf1AxJAjF0EmunmiJ4TsTNafV0DK3sdaWqxyMkTpZLr+mPJ2ost7mfUl8acHhQ35XEQqIXH/KAwZw4i54twrLmw1YW9PKFFqkHnkS074NKJyHWtfELZTbUapD1y02Fc4RIvXAnm3bdqf9Vi7YVVO4C9EsMkqp4+V57uwRXZIM5bwcLchai/BwVRdcvkaLAx84VHbGnG7IyZl9jldbUW1Kf8RUav0wdnuSiIXcwnxKkL7ot3qaC7hQM/hN4zk8H6ipPUyjIkQN/xNIFBer+aXtMSBuoizvMSRL5rLtnlZKmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUGEY+pBlyBIdebOjsE8qh8esL1aV9NRIhgGOFGt0GI=;
 b=nb+TTRfc3Ot3xZcIyeQ1FyxodaDw0QBNdNalPEQlvof4EM2obqbcFB8bPHSoWPtADRr8YuDt1uy+3l00xQRsm4L08SiXuk2KhDU/vW1YLrxV6r6Rvp/rhcx3yXk3EOUHgQrFR2T8S/Ci2fKDeO2z70WGCgVRcm0EUIPbOucZ3OI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Thu, 25 Mar 2021 16:38:47 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 16:38:47 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Introduce new SETUP_TMR interface
Date: Thu, 25 Mar 2021 11:38:38 -0500
Message-Id: <1616690318-3555-4-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:38:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 173f58b9-ee07-4e05-172d-08d8efac760b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44182815D74AA34B909C25C380629@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVGyTH+RkUJcEajEMtdJpeyQ4RZ8E6Ohi2OuKq5NYh/0IcJ2iI1zXRQWNLcOa6nCZi6MSJvV4H3EFSxLCopywcnyxKWc5FEfNPDU4HvJkKi7qSeo3elpCHhT8ggMC4DzvKmHdJOl95JI7BTdwWiSbu/qN10Gxm2j7F8gcDWD9RsjUcGbjZPAYNq/1EDjpEo3iDwoGzjkfhaunI4JJDRVEHhLZ1VOJxKm5EiqJHUB6oxOw/DxrkRqBRNTn3I97dmjbkvfEQ7aDd88wtYX+Iq/7O1D25QmgjRIyKCeIbUSKZKaZU1IvICXx3WTMGYT7APNg1lS3yxzKPXFJyrcvGYe62gsj88+vV/7QM3ChuvaN1JQtEX4oorplFptw5e1GnUSGTKc0zRkWBKaEj/HOi/dLpYoDHT1ZL99I8gBJ8iCD7uYEIDdOOXXIx36NF3bVbDTzuBb2N4RcCkbZI3ItlJyDeLHUOTPjUejxXCbcBUNtbg2DzwsZcIgUNEUYfQ12SmJ8vCwySn0jadvgZw8Ch31ab+htGjoyxLEVucffDnh/mEwaa8POqsN4Gvhmk/+jZfwJ/JV75XsBmqdVYik2ynAbGQQsp0aHFi7UgBrzfrj8WfOnrM0cItX8Xu1plKYldlkv0Bt/X6Kcts5gzTKwzt66zhbwg+wqEudSmzztUnXK48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(38100700001)(478600001)(26005)(186003)(316002)(16526019)(52116002)(6486002)(83380400001)(7696005)(2906002)(956004)(6916009)(8936002)(66946007)(66476007)(66556008)(8676002)(4326008)(6666004)(5660300002)(36756003)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aQgi2t5A3Kca3w23GsBUpUMNmk4+bjGd+uPNsqMbtHiyoRnEm4DtvHR/O72W?=
 =?us-ascii?Q?1VRkZGKGnYjkZetqY2WMHa1ytQMLOqhJ9gqtcOi94pk7DADd69QYN58Zu+ev?=
 =?us-ascii?Q?7WDYJ6+xoOSvKamuf3AiKaKgznaj929NIG2M2zNhHaw6CdCX3wUzgOXNShEQ?=
 =?us-ascii?Q?of+JD9JsnBpJb525Vpz11LPRUT6qotwItwjFb6o3m9bs7lhrl4fIhnZx/aft?=
 =?us-ascii?Q?+cTKjwl5QNuxODsZ9OY9dIUQq736W5m+FU9xe0tk1DS9YmKNNpEESvxSo7XA?=
 =?us-ascii?Q?3bDBMEKtJt2o2AzAJ8MFS6EAebS4pU/w1vcafTOObdEhC4JYeMigAfOOE9bb?=
 =?us-ascii?Q?ZngdMZu/S+dyR7/PMSTYkOI7HKLtOs8OiPxIJ6Ck4N/NSbpHAiaL4+gqW3AN?=
 =?us-ascii?Q?CcEWqUZ7SLWyeob0zNWNCCtJhYuk6pY8Z0wvhgBevAvnzCaFSor3jqOXXuJy?=
 =?us-ascii?Q?XW515arBnfYkrC27b/5puKFdyGLYBabCDAEqHsxi48QvWlyQhbEb4RZl0N9f?=
 =?us-ascii?Q?czCJEikp8i/DE5Psf9BuSi0cbKgTGuk80W07AnIoO/hqr8DczDTSLC0wuhIV?=
 =?us-ascii?Q?NUf802jS9UIXb09IXbcKKfOkv5yE1VFTzHGkfSS022eF5bPqjDjVYsMl7ZTA?=
 =?us-ascii?Q?afL4wYnj5BQhbmLHP3hNdsdqgAz2UnUxTTLfdx6fXls3HURd6I287QnHIZc0?=
 =?us-ascii?Q?h0XN3yNv5hzDO6Onc74ebqUPUxrZkyoKrYQEp6O6DgfS4Rugb9VZTlnt+6js?=
 =?us-ascii?Q?ogxF2gakWtPAHjOGznKfoVoz90n4m8C1OGZKRIVjfx9NiSXCE4fgI1qJ973n?=
 =?us-ascii?Q?mEymi9a+9Q1n3kW5yD6FEvOBjfHcF6S43ZU+TXRpDKY/n5x4/tKXpWBknPc+?=
 =?us-ascii?Q?FyQCSmiOHI4CR0XYUFdxbkUSH+jH9fPG6lkrAoELRNUoNbyQsVt7XV7zDdME?=
 =?us-ascii?Q?OqW5hPhGzitDLVmUI/eE936no77w09tI53Hckq5kc02mzpUyd2NdWVVpq48Y?=
 =?us-ascii?Q?rWJoyEb7fVk9Vg693L/tM3SebW3+9IhxhqHK6AmfhetBqpu3+A1skS4G5Q6w?=
 =?us-ascii?Q?Rz/Dw2gDPMajbtpAGHsgPjBKJ/U1BfFHTlLig4yMBAJZgeDVhnVTknZo6qDR?=
 =?us-ascii?Q?PekH9Nmiy/vbCyb+HnoEwOIyOCPCWsZ1NfE6BWrrqMdBW38dNKOK2LDGUU/p?=
 =?us-ascii?Q?+Jd+tilzYeIvDSnC6Gdg1+sixwX48hSTd8P/F/1R2J/mhbYKzn13XrpFUWLB?=
 =?us-ascii?Q?zN3E3EtaLUtPT4pY0EiGbnGwuJk0RQOvL8kzJCSTYcTMLh+9U/+fB8BvqmrM?=
 =?us-ascii?Q?K9yueGIvZYQPkXA+vj6aMgMT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173f58b9-ee07-4e05-172d-08d8efac760b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:38:46.8635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65Zucz03mbj4gH3swRShF2bSH+7kZDVzqC0ReQqkIBZ1Mcxy0MRrnEzOIfn30zaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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

v2: use a macro to simply tmr physical address calc (Lijo)

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 11 ++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1005124..d224c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -331,8 +331,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 
 static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 struct psp_gfx_cmd_resp *cmd,
-				 uint64_t tmr_mc, uint32_t size)
+				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t size = amdgpu_bo_size(tmr_bo);
+	uint64_t tmr_pa = amdgpu_gmc_gpu_pa(adev, tmr_bo);
+
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
 	else
@@ -340,6 +344,9 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_lo = lower_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_hi = upper_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_size = size;
+	cmd->cmd.cmd_setup_tmr.bitfield.virt_phy_addr = 1;
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_lo = lower_32_bits(tmr_pa);
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_hi = upper_32_bits(tmr_pa);
 }
 
 static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
@@ -459,8 +466,7 @@ static int psp_tmr_load(struct psp_context *psp)
 	if (!cmd)
 		return -ENOMEM;
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr,
-			     amdgpu_bo_size(psp->tmr_bo));
+	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
 		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 8c1d0b5..edc5d75 100644
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
