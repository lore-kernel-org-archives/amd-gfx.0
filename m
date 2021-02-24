Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A69C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796664F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796664F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696F26EB83;
	Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCFD6EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LssSt7EqH95zfVBRRs5iyvHifKd5tIvD5sJfpfRXynLLne/XM9wDTeSZReCtGZMmU9qm9WMJRmwqt4unmCiZEfzqNeZ8FhF+raqY323uAbyY00oySMaZZYeMhXNAHc7b+P/LtJ/rC18m+riP9PRLFpkQOJcImTb1iOP+PLAWG7tjQJP+Ee7NIZHqwGwWwO/Eo9zLEtgFkcyW2CVgc0GXsCHywZNv6Z5RhB7u8HZk0P7tkwsqy4uQlszZE58z9ZaOGDo3wKA5IhocUx3GVrgb7v72J5Bm5yYj2ZI50/JRERW8REi1vqo3T8cJifhis3eNwHzow+dSHKSpC4ZeMMULwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9pvrK5x9DyjxSXmEVZJ0R377XsBq6lhVnKT6+KQpwU=;
 b=JAIj9jovHkH7wyNhcOuqKfvWfKZANzw6xFXN8xI4KGez1pWGE8Wqb60BwcuDA1oMkpzDfyC9o0rU71zY/TLQ/E18Yy7r9pWQe1l2wnW+/Qucbxi8NjYBSDa04JqK9hDMR3fSeMD5dC0MYCyHrrMu8PC4olXYrl8951COVudn3o7ar/owoT8B9HT1dGaY6lhLgd5X4KG2soMbV0Suseyaa9vw2NlW9Jn3PdQAGmEvGdKdP0aHn0swhj5RUAd3ymORIaJZTTEEsL8vx38clqICgngQrN/R411IuNdKZV5qiV6mmU+nxuBffg9FP5gQOi/10/ArGJt6Fansk/hdyUKhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9pvrK5x9DyjxSXmEVZJ0R377XsBq6lhVnKT6+KQpwU=;
 b=5eK3rP6AF/bWEMSSGLZTKVSEOrPESUd2OyFd8GlvKPRKS0SODX2U1///LfPxyAJ7yGAnqKr06KLS0/UkqFG4C3qkg4JkTANXk8/kZTrSjOiRk0xBucbDZdz6cPLICIOIhVpnCyWTHBrRiWT/TpoQdHWy/6tmUnoNwkcsGkjxjEQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:21:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 115/159] drm/amdgpu: Fix aldebaran MMHUB CG/LS logic
Date: Wed, 24 Feb 2021 17:18:15 -0500
Message-Id: <20210224221859.3068810-108-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac4a2cd8-e8a3-4cd2-4931-08d8d9126c39
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503A1809A7CB17020458263F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVat7NV61mfSl6xAhZnIC/C80VigRDAB+BnBNOw05gAGwQal0+CgpHpICbF7mLuSCbD0ZSJTHQpMGaZ5gJv4Dt/caufaS/1X5edx8WtKqdT1rkp5PL1SRzCRxQowTKGixlfMjFLjX6BXIYXB6hRJC6TAS50hBhWmszWjOije7CRKo/uDGA5AjDeNHHiIMeFAj6MpgnHYNbl7XeA1IpCGdrLQubq7nXExyEKPcQiIF9XHbo97EGcKazmMUZ0Tvk6UH565ZsHyqxEnWAAtxVvZ2j/j5pwxw3Tw8d/5f3PUTJG93WzuIKdY1zvnhbZBXxqnmY3K85/L5fzEY5TP/XG3BcLLU7QX10fF0t25GnRTU0F0vfdwCASEhhRu6G0EehbmQ5X5CqTr3cmZFMtYvRlBrivFQAAIaqNQrnuG5+dnj+g9zjfPBPaECMJy+FItdHcS1sFbRjhMmRp3hTOOmCNMR5raNhNjk7qcTW8WIsc+CTF/USjYjxVAiSLbvNdfcAIKZ5kb2xevVE399gEJwT1AALdHRpe/kbe7xbIwjhZx+iZNEf6rc0RHk/JjMmWTQhUs8Uj8d840GTXYgluaruSYBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3qDNxndLFi5TfPxiPUhOqM6D5ovu5CDfWCV6P8+Pylv+qXJDd9mofnyMEO9F?=
 =?us-ascii?Q?C/fyKAddYeF661qoSHm52TldzgdKZXw84i8UVpuLFjjnRKrDx6oVm2TTikZ3?=
 =?us-ascii?Q?3kn/zpdk1pil9yI6cnotpYYTr3KWPZN403SPlJYPWlYHL2w7XqF1W7J4AKlJ?=
 =?us-ascii?Q?3HcxmBz41J45J/x1VjrlIcwILLLycQNI0xk6o9NtKpdOrp3TQz0YLAgoj5ZZ?=
 =?us-ascii?Q?g7aLbtX1cRTRo7R8C1V0Zb9ETFZ2FRj70vg/Y4D0JVK60yytdnY2hRLYzCnL?=
 =?us-ascii?Q?1TmV5SAHR0PZCI528EX7lYSsX/YCKLIPNsvBl8tc8eLSYnad8puLiR1rWBwi?=
 =?us-ascii?Q?SZ+tUWA6lsCWyxsV+LdbxE5Ida7qdi/gNWw+ULOSWGo+pVzi1osJC+i07nYv?=
 =?us-ascii?Q?9yuqbITxZS5VrRR/4MlPaA7lXtzop0Wb/Lkv0nPx+o7VFkNZ/kzj7rZmo4OY?=
 =?us-ascii?Q?BgyaoWMxt83q7JcITl1ZHJqLwMmo6ipIt7UNifTolMNdA4drSZrF4eeyNtNw?=
 =?us-ascii?Q?7X9o2l2G11QMRcHv6iMSVqnZZaywuEsqa+aCkKPCvGFHiBvtHdjLnIVrQ6ko?=
 =?us-ascii?Q?31GXTALTM57WmWLL2flZm8xyZnahvOYP6XoacMHa4I7exYInkQO8GboOrEiI?=
 =?us-ascii?Q?Y0oe5479MxjL11J4pTkz/4crAuXR/2tW1vgGKNLdgB93cntE+c9GXRP7wEV7?=
 =?us-ascii?Q?xW10q6n6n30/ychnCATBUEOxHfYqDzn8Y2X7g6nzymIJVlp8X4j8LCTEhlFT?=
 =?us-ascii?Q?BTkQUf+uMjeaRiig5TrjmzcNOia1MPVeCMHfBmAQe5DL2LCqhwzBmd8aO5Qb?=
 =?us-ascii?Q?rKh+aPDbpSlW+Q85ctwmyfYMai4WYIpF/N4LBNqJqnFJbr455y6iegtx9CXR?=
 =?us-ascii?Q?xqZEkw7GwwPFZZlSh+f9zuO2x2qybHlBAQwmkjNdI9/dgR3iBhBSYVhcoDkd?=
 =?us-ascii?Q?e54QZ3zHZjRF12G30ohTrvA4T9QruGgGrrqNEQpFalM2pysAPE2ZxHKlGSco?=
 =?us-ascii?Q?HVvqQ3dFxQnYL8+FSvbB+xLoxzLhTsrn4kHpGt4Z2/9js9hSV0g6P0RIlxrc?=
 =?us-ascii?Q?sf6jl5tXhXEVdHDl7ZRJSJdeCpRNhL0zMx1a63yG3QBanv+9JP0j9kVGRYBT?=
 =?us-ascii?Q?Btm+RsSxa3kYpd3ljTO90hHuJBaQhscPVkfs4E51TKkDAu7fwCQKEhWpkWs5?=
 =?us-ascii?Q?jMqu0gunwp08g9hZ9y7JfkGY+fX/WgV8D7oPdu4Qvrpm5uenFMd+Ps+3hhnb?=
 =?us-ascii?Q?xWe0nFJgrLY0BgDRZw+Lr9Tk5vx4YkvtnfwWmZ5a9D1TM5Vjgfds7y3+M/xg?=
 =?us-ascii?Q?LwDSwHzaM9tRqU06+dvgm12r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4a2cd8-e8a3-4cd2-4931-08d8d9126c39
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:42.3547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx8oj80Ho1LEOPyMWhXWA0gDUzA8ooRzgkTtVGBIYFTvE9wUAGcIKtaceTdbITKE6uGWT5f1rWLf8tWHsUFcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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

Aldebaran MMHUB CG/LS logic is controlled by VBIOS. Enable the state
change logic only if driver is used for control.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index f7471f7d32e1..c3f3e755d4b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -430,7 +430,7 @@ static void mmhub_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	def1 = data1 = RREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2);
 	def2 = data2 = RREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
+	if (enable) {
 		data |= ATC_L2_MISC_CG__ENABLE_MASK;
 
 		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
@@ -481,7 +481,7 @@ static void mmhub_v1_7_update_medium_grain_light_sleep(struct amdgpu_device *ade
 
 	def = data = RREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
+	if (enable)
 		data |= ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
 	else
 		data &= ~ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
@@ -496,16 +496,15 @@ static int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	/* Change state only if MCCG support is enabled through driver */
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)
 		mmhub_v1_7_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
+
+	/* Change state only if LS support is enabled through driver */
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)
 		mmhub_v1_7_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
-		break;
-	default:
-		break;
-	}
+				state == AMD_CG_STATE_GATE);
 
 	return 0;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
