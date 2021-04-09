Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7309DC43460
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074ED61001
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074ED61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4756EC38;
	Fri,  9 Apr 2021 14:52:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA866EC37
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 14:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxKnth3yz8wpiLsTnzpLEC0C8jDGbietdM/J75wjhXeo9l5ywsZWHduzo1Ruz0Ha3v04hEPZpuraHuOml/yOBU9eQDix66NLTamFfG5h89KWuNbX6G9s/xCPbnl9gz53Gh2Po8SlTL0yWso4f8VHkAfzLQKBo0pybVezEtIVUouSu1YaKYJx2kpvwQKUNSoOx1Ytehg3MAnd8HaDslyh7A4asKK4BCK5bSovxdP9jvkUbCY7oT/KAnEu77lMvgTuVLXWrVKQF5sqC1jhRb5qlXVXv5/cG7PRwz+EXb69TCCVYIhuuU7iQ0+YUx+9rBR0xfDVAEqnoA7OpJmRHBPwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJfcXkCMN/nWYDDBD37/p+GWfwqPP8n3nujYPLHnBVU=;
 b=OC7geYh+iNTrXWANZict50I/Lnuz2yqaQbIpphkhehNmu7B+Mxs5FnbB2JOkK+dbvEa0Dx7l4DArxRkHwfv+sunQBnn0GZgrtaMV8mXuF4mMW6AQCRpVVvuq8NnzEuJevRD3UH0ofR0qOv0y1O32z1Vs2mqPIHG2BCli5sJg7YU+Lkgv4tGF5o7MV5pnRodLRaBEaIspxYpAIzvvQ9eaXjzjTczSlCIYLRo+GQyTVfZ5lXwrN1VhCdCl7RmDessBhJwwiI4powkk3Ntg5kal05ZJg8tjiariPLg4G7x27TzOLPNUsag0RkS58T7BFqEXwb9mEDwaBcKbrOHAboZLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJfcXkCMN/nWYDDBD37/p+GWfwqPP8n3nujYPLHnBVU=;
 b=gC290DISF4+TDZGF0NQWlgpM4vXMvtnIGifwefkEh8Qoa3l+I4MlgPjS9AdXN8dySglycGk0Vf87E0/3NZCknOriP5AuypBKW3KBQLwoIZjoJamhKEBpjkIEoakRE9udkGxoDlwmYkJgzXuP/ID+X/kcY0npJ0xtUsUJh0MyU3k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3994.namprd12.prod.outlook.com (2603:10b6:5:1cd::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Fri, 9 Apr 2021 14:52:37 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3999.033; Fri, 9 Apr 2021
 14:52:37 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: Introduce new SETUP_TMR interface
Date: Fri,  9 Apr 2021 10:47:33 -0400
Message-Id: <20210409144734.1591798-3-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
References: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Fri, 9 Apr 2021 14:52:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e3bf00-ef7b-435c-cdf3-08d8fb671bbc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39947D11D2D6D59A5A412C448C739@DM6PR12MB3994.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W39nPb0pz55pZvKHDS3xcOqPAC9xmHo513UKF9BcyC4p0Mk8XPB8IIZgCWgtUVzUpbwaaiVEyc8XnMjC5EpUKD237vTHml+nEYW4LleeUa8KVRbg/i+GVdnroNJJQEzQc/AMj4IQtzDNzBAxonHcSBpTsQzRXX/bW9dMOXUhfxmh2iOlOrSqhOxHphzB2PgIXlnASZouSFkczJRw0p7WPKpOqxlTxLFqmoDEjRcyrSX6sF4GcAKHGHnAx1Puuyyv21xHSC3GrpNzDevq5Dw4tlu3L5lxUWQWpl+BW8tPiybXMmmhNfKcwbwrZ5YSWQ59es3xli0R6gZ6fEIP84n/N3Q08zeGyCRaQBu46BtvXYS9lHT0euY8h/s+kdZStDYaPt/R5jXVm8Ug9xdVUC65tQgKb4eCYmjt2wfiCCOD7zYWo7/iOApuK9Hl4/ORxrJ1Nt3TjtQbxQFQOsV7IG2PutP8Pu/ATsP5NfbWv451m/MMCDTbYvHlclrEJeY5yg3mfuVsj7z+oECTXV0r+L/WoLyV6sZoBRhqoTS3Jq4+Vfy9qbLKLJ84lvh2HgYkG2fDU7XaNzQGEuWXH/AHFewgB4fCIpy0S5DnQjwl5UkjSPL8DG2jdKndj8SBOUyhFQhQX1XjynD5w1Khpubmzh57CT3it+CsxbKtETbrcJZ/grtXhYQHZGs1BgLdUeZwRxUv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(36756003)(1076003)(478600001)(4326008)(8676002)(38350700001)(186003)(83380400001)(38100700001)(26005)(16526019)(2906002)(6916009)(66946007)(86362001)(8936002)(2616005)(956004)(5660300002)(316002)(52116002)(7696005)(54906003)(66556008)(6486002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?psLPZ4YEEH4g5q6LBDaFNssEOcPfHMv7LynTopSKwe7C5Xo0iQaIIFNehg0A?=
 =?us-ascii?Q?BGVDdxfRjNOvHMbO3XUF8sJboyhpSZ63l4iIDMuVKwPWNjn9ww6B0Ct1rXuI?=
 =?us-ascii?Q?XxRtIX5aHy7ENAsCoVgX5SUWyt7pjkhe7V8mBp8SuUqajTwY4HQRYXjGrIkz?=
 =?us-ascii?Q?e0V26loF4YB0Pzi9cO/7a3Vg8tDC7zEQ13fzhEDyH2CNR0PZQSLGJfIntsP9?=
 =?us-ascii?Q?UCUSz7Ce3N4jj5rA4goOhtPdH1b4mNGLsF+QSynsgjfk3lHzB1QdGuwBpsW0?=
 =?us-ascii?Q?RsaMlPpPqKQTWEc0E/N/uwBg7cZKZKyKQXjBK2Ry1gA20gDyfiwt+RK1Xtma?=
 =?us-ascii?Q?qitRALDG41bTByatOABwRZKeUiP1xfZi02sOgMYDOPlPt56skReF8e0TQCKx?=
 =?us-ascii?Q?zRsE0K3ZWOePBWpgqTfRnlLq+vRrimKWyqeCkutTkWOyZJK3iVCSFkl+bOY3?=
 =?us-ascii?Q?L2QPE9SWCuT3KCCUr1KEHFLmDj0LkYbwXjZheZNeKWq2X5AlJwTw/E+URy5Z?=
 =?us-ascii?Q?pxLRM/d/zl1ElBQ06qZfCMN/N4C9VT+zHuRMM9X1pInVHJsvzt4bLTMwn0Ki?=
 =?us-ascii?Q?5vy/ByCzrBbg1aeU1ZIBtDKmMCW7GgPmvLBsVKRt5IQ4lfDndCdh5HqRE3m+?=
 =?us-ascii?Q?6NJ55iUuRC/gRgYb6zg+VHY70iETmv3hqOzCLuQr6vLKD+7s09PmxgPNBhkh?=
 =?us-ascii?Q?VwPbs4LCmNJJl73orE9LxSgaY9+QrBipvvkw9O2cpHlH+PmsQN2CeY5g+U4Q?=
 =?us-ascii?Q?DRJ+ZR1DjWDUco9mrEiMdsasEBYKsUGbnL3OJv/hukqvbW3PDesuebORSAOY?=
 =?us-ascii?Q?m0vytzpXmxzfx8gdymtE1MSTN7+f1JjuEhrhvmnSuyxTUihiVWBu/HrbThIj?=
 =?us-ascii?Q?rz7vT7Q2Zj3zAFbiSTmFGnDh3+K4pSi1D6Jgn1sM+jLHNANwYKPOfGC5QjGJ?=
 =?us-ascii?Q?YfKDakOqxBPjBFDFrkxElgOuNKLipaxnNQc7s+Gz43788InP7YRm+eKDueV4?=
 =?us-ascii?Q?UkyZV1sBgYeGykd5bzlcfjIJcykbekzVt9MPHaWbdgF7HK4oDtN3pcs6f71q?=
 =?us-ascii?Q?VASZD+0uaiWdwHBdbpaqYFV66ydjqseZ44mbTQa+11nCAkKtmoXgpKORzzQZ?=
 =?us-ascii?Q?yandAzXHxWY8APEDU/O77nyawIyAQvnNqorpFlMTEtMh5EgEyMXGBuOnP+hQ?=
 =?us-ascii?Q?RxdJr7g70A3UydoIsv7iSEswRx5te1YWBuvm5fEvvgY5KUwloLdBzO3u+bOD?=
 =?us-ascii?Q?llvQeWaPSliDiImaJRySckUBsPEOHUnc3tYIF3yR5cMHEuvLImAWfSpCEnVI?=
 =?us-ascii?Q?YXIpAgUUvr2Byqi5gYX47h5U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e3bf00-ef7b-435c-cdf3-08d8fb671bbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 14:52:33.9676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyH5k+FGW6GbScTZjMbPlR8Jpw58KKEBn1SuAMBAWlKLweYSeTmc1KnKkn9Mg20D2xCm1vYiWAJqoUrZo03XAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3994
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
Cc: Oak Zeng <Oak.Zeng@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

This new interface passes both virtual and physical address
to PSP. It is backward compatible with old interface.

v2: use a function to simplify tmr physical address calc (Lijo)

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 11 ++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9e769cf6095b..123ab3156f5a 100644
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
index dd4d65f7e0f0..96064c343163 100644
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
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
