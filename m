Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DAC48BE6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 10:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F2E6128B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 10:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F2E6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D40D6E544;
	Wed, 16 Jun 2021 10:15:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA86F6E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 10:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Erab3+h1ENu2/LXiA+22gSiLzVsYBsDVDpFi9iQv76mHrou/cJsL9wO91mbGKzvSwqvA0WnBW2jeZBxwP/XiJastZ9Ny3ZCwUIubsZQZU2fnkthfy0xwNX0OcqEk4LB3f1Tfub8eq8HPM49jo1Alora3JBz/qApZCfme0nDgBgVopoeEopCGvqWUNLNBnicowqN/bB1Y6PxyfspENaWieWTcxtG8PqP/4adoVwW7BCMPaFLAWblITL4dGNNgyAoB1RDPQszzlLzgYiWaYfnee8xZNtF3tEPN0Fp+A7rpng3CWPxaJxSrTr/33g1eNQ1n3/HCYGW9EDCRvT6CELNiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXrls2AzTeNv409eRRuFOfklP7KitMn6Do9Dv8r3cwM=;
 b=Jgt1YoqOqhxM1VUeva1ur92jr7lPaW4gE+Uodam812gK6Bjw2awQCPk2RHnBMtj6xc3dqDG/vzJM548nA38VcBsNyEF0QrLdQzsJCI7C6TDydjT8l75DOFqibI7x67Ollp6Ce15tITRoAGLLZt8hSbEYGqTwUwN1fYAvhwM8P+doLvEEVp5Y3qBKSaMRZqqhoirunYzDWhFR4pmffmfVAhacjW2c+GaS8UbYu1cRhVwc4Go68Ekp3+vTkxLPTtq9aQKCD261uTZgBbkrG9FDD8sczvmnO9ro7NWz0hxNPhcXspHj699nQ7sluT0ijww/2GBVxIBvtcYRQGWx8BapMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXrls2AzTeNv409eRRuFOfklP7KitMn6Do9Dv8r3cwM=;
 b=GCkXj7BIpw5dEp8H+o2ajzxcpFHhSdjzVp/JcjY2vbfzZPKsmCuo4ctD9VGwvZ0eLdjxtTlhjUREu+4RCdrwc+XYOLbCO8SDM2EYEjWkcaIOGFB09ey9XXByzs3xj8c3g8yUqBJ57GSwHiTj9hHHQlPneykQ1x3Tn47eO4a5exE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 10:14:58 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 10:14:58 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: Ray.Huang@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add gfx rlc enter/exit safe mode through emit
 ring
Date: Wed, 16 Jun 2021 18:14:40 +0800
Message-Id: <20210616101440.11523-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To MW2PR12MB4684.namprd12.prod.outlook.com
 (2603:10b6:302:13::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (165.204.134.244) by
 HK2PR02CA0140.apcprd02.prod.outlook.com (2603:1096:202:16::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 10:14:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce08abe2-b242-4390-372c-08d930af9823
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0062B4378BC34CB17895F512FD0F9@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5VhBdvsJbcUzVhmmSSHYFcIQz+Tx5Wf94aR27awP2AcO9pqViAjvjjG0lSUi56Be69shMMwFnffbQO+VG60zKbRvjUO3NGxIkhKSlYQm98kGJizRGpcfjm4MF6zRZO8Ae1TRc5odoVlrcjXNqa9a6FV6x/PyGeA1Vh9lBf5NSMmHzmu+/RMITenjkR9qPNJg8DLFv2QKhgA6hUwxsAYUWqFeR1HqEZ8/N+kKwKoyDblQNcV8QOgAvDVPfW4FfYblpevAg7rXSXdOOoXLaIm62eYYBLZWO0lSa7TZinCD/1hp+9G0nafK9/BLucyQw2yHR7xSJYmSHqydCmf0C6rVqK3dNuaZVOjYVG9cS3tn682qo8CukFG13MInOzPmG/ClVnD1lvWqr1BvUUa3NtkEo173TUSL99jDhnYBrhSYAb77oZ8rI/HFoPQ1yDO1zQ/JJyKOVU6tWnZzf+B6su4tvJVnF3cmhliNJajwOsqKQ10qpWCcrsdtIk6lnVy5MDdFkWSb1JnqRnTUIz5H5n1HCDqPtMORJqQkmlpGZZfbO07gJaIJHS7RykJxIcKtlLdvhqJhZS5wJPxFsbUSZmr61ObvoT+9FfIvtIMtH4znAIEFzbizHYGtJmsL6XtFdo2R02HrDYnRzFOO4+U6kGGTbahY0TrH2OKM6h9pT8BsPxT656hzwd8VHvGj/NhS2v8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(66476007)(86362001)(26005)(2616005)(956004)(5660300002)(83380400001)(6486002)(2906002)(66556008)(6666004)(316002)(66946007)(7696005)(16526019)(186003)(1076003)(38100700002)(8936002)(52116002)(4326008)(478600001)(8676002)(36756003)(38350700002)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8/2VFxGqjzDUmrAKE0+gjcwfbEiJGHLUPqfFFpIhaE4qPbzeRLINqgU2zCP?=
 =?us-ascii?Q?slMtYZpOUv2XjXhKiIxrUbyR6+Ih7HX47UBAlFIw4h5HPWWcCYh0om3FcT0Q?=
 =?us-ascii?Q?mlmGQ5IOLl6dBqsPwXU8x/fRaxU779Vjr4DUJBAiDXakkgjk52Qs9J2WGQLR?=
 =?us-ascii?Q?cRyohPZd5Zwgoww4IiIxkpMlewmMm4at6qi8vqQ7/tzsA32Em8gFdLq14aui?=
 =?us-ascii?Q?GX7ACBAaxgH3cqblVaUCqFWCgZmUIL5H/+uBPjgYueQU+eu/AsGEomXigEtX?=
 =?us-ascii?Q?MImdqPXkHpdBUVQW7uiS7jbgNmUiwIQTbBkdVvtGUFTtf3TeFL9uSNCl2D+J?=
 =?us-ascii?Q?jsnaA/gafw7JSvP0yUO3oAU2YsnGSJC21CauzQbXxPQYX3+Z1n2zC876AiHi?=
 =?us-ascii?Q?5KZrnQxgOlAqkxncL54ynqYAMhRk0EemMKKLihydfiolGNN60bf7ax4K/zWS?=
 =?us-ascii?Q?oyen17pttLE5FTsya5L6gXlga4ycXcNFUUqYZ30XF4VvzIGnL0TFjkNwRXDb?=
 =?us-ascii?Q?zpw+Gne/PV70lBQ5Ubbar+GD1pwBWA+d+nG37qH0LCFUD5iiWmDrXIpar5qJ?=
 =?us-ascii?Q?kiT5RWfLDFjey46h58dt4rVbw1EKn1egAd/g5YAmT5aTzIOCrgm150nAKpgX?=
 =?us-ascii?Q?ePrIkOzT448iRek+z+1BrDixgWRCuRLw7BQUdMFJSREFwrWQNefaGtwJbizi?=
 =?us-ascii?Q?vD1cFj8laLshxDEdRL7QOa9Xv12CVNqrJpaWgqOzxFCjWIvTUigTINwHKo5m?=
 =?us-ascii?Q?bXavEYQ7X4/bBa4Sen6P+ZGku6TppCHlgHwRyguknx0kFhyF9Li8aWSHDfnf?=
 =?us-ascii?Q?ma72DZaler5DqTvP831azHKdAvGynoXv0xq91SKGbB/34koZMzkfletxwz0s?=
 =?us-ascii?Q?MedFhtFC8kI9QPxHww+3dDZROEa6WkOsD1kXU2Xvx4mtE5jPRi8gLm2mDx1D?=
 =?us-ascii?Q?mFotfHkFDy+8wKYCz4kiMX9C66b1McNhyprln//zqs77reSy1Kg/s56j35wM?=
 =?us-ascii?Q?30oZddHdlWEMsilYMk14o9HqtSeobenSDPEVCkhbw/ZlTaFHp+Ep1rg4nV/f?=
 =?us-ascii?Q?4qaFyXfUXNEb/UirRApZ8Ib8wIc2H5W1k+x+tK3pd+f39I/iME6balvBZy0s?=
 =?us-ascii?Q?pyfWbmW14MvySQrDUTauhxDZOl/4sJgD2tn2PV0ZP/iTInXLdd/7KYglnAYB?=
 =?us-ascii?Q?CW3KjUJT+oIZFRTgLJBzNmCxAD1+0PFzm3ZuyW5F2Xn1efH+42cFc5/NvVfa?=
 =?us-ascii?Q?0Y/5fiX/Pu4IJA/QdT+b2Fw8zthOYjsBNqQCsmMaMefaEdaF3lvVG5uGK4jY?=
 =?us-ascii?Q?kEdGSpZqN8g+16AVjCN65I3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce08abe2-b242-4390-372c-08d930af9823
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 10:14:58.1189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F9v9QK77MyEe0M5G0vMMRRwthZbGedOD36flJeZs99zkXXaYh1tlZh+Men0IW+phF390CwFs/yRVisbkAxR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

Change-Id: Ib6065f39d61872ac0497afd11789d98e56434b40
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 26 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.h      |  4 +--
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 6373bfb47d55..d5978c3a0e02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -51,6 +51,23 @@ void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
+void amdgpu_gfx_rlc_emit_enter_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	if (adev->gfx.rlc.in_safe_mode)
+		return;
+
+	/* if RLC is not enabled, do nothing */
+	if (!adev->gfx.rlc.funcs->is_rlc_enabled(adev))
+		return;
+
+	if (adev->cg_flags &
+	    (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_MGCG |
+	     AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+		adev->gfx.rlc.funcs->emit_set_safe_mode(adev, ring);
+		adev->gfx.rlc.in_safe_mode = true;
+	}
+}
+
 /**
  * amdgpu_gfx_rlc_exit_safe_mode - Set RLC out of safe mode
  *
@@ -75,6 +92,23 @@ void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
+void amdgpu_gfx_rlc_emit_exit_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	if (!(adev->gfx.rlc.in_safe_mode))
+		return;
+
+	/* if RLC is not enabled, do nothing */
+	if (!adev->gfx.rlc.funcs->is_rlc_enabled(adev))
+		return;
+
+	if (adev->cg_flags &
+	    (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_MGCG |
+	     AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+		adev->gfx.rlc.funcs->emit_unset_safe_mode(adev, ring);
+		adev->gfx.rlc.in_safe_mode = false;
+	}
+}
+
 /**
  * amdgpu_gfx_rlc_init_sr - Init save restore block
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 7a4775ab6804..9e0eb4882b84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -117,7 +117,9 @@ typedef struct _RLC_TABLE_OF_CONTENT {
 struct amdgpu_rlc_funcs {
 	bool (*is_rlc_enabled)(struct amdgpu_device *adev);
 	void (*set_safe_mode)(struct amdgpu_device *adev);
+	void (*emit_set_safe_mode)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	void (*unset_safe_mode)(struct amdgpu_device *adev);
+	void (*emit_unset_safe_mode)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	int  (*init)(struct amdgpu_device *adev);
 	u32  (*get_csb_size)(struct amdgpu_device *adev);
 	void (*get_csb_buffer)(struct amdgpu_device *adev, volatile u32 *buffer);
@@ -194,7 +196,9 @@ struct amdgpu_rlc {
 };
 
 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev);
+void amdgpu_gfx_rlc_emit_enter_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev);
+void amdgpu_gfx_rlc_emit_exit_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws);
 int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 14136de8abb8..3c93fcfffa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4822,6 +4822,19 @@ static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
+static void gfx_v9_0_emit_set_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	uint32_t data;
+	uint32_t reg;
+
+	data = RLC_SAFE_MODE__CMD_MASK;
+	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
+	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SAFE_MODE);
+
+	amdgpu_ring_emit_reg_write_reg_wait(ring, reg, reg, data, data);
+
+}
+
 static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev)
 {
 	uint32_t data;
@@ -4830,6 +4843,17 @@ static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE, data);
 }
 
+static void gfx_v9_0_emit_unset_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	uint32_t data;
+	uint32_t reg;
+
+	data = RLC_SAFE_MODE__CMD_MASK;
+	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SAFE_MODE);
+
+	amdgpu_ring_emit_reg_write_reg_wait(ring, reg, reg, data, data);
+}
+
 static void gfx_v9_0_update_gfx_cg_power_gating(struct amdgpu_device *adev,
 						bool enable)
 {
@@ -5121,7 +5145,9 @@ static bool gfx_v9_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset
 static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v9_0_set_safe_mode,
+	.emit_set_safe_mode = gfx_v9_0_emit_set_safe_mode,
 	.unset_safe_mode = gfx_v9_0_unset_safe_mode,
+	.emit_unset_safe_mode = gfx_v9_0_emit_unset_safe_mode,
 	.init = gfx_v9_0_rlc_init,
 	.get_csb_size = gfx_v9_0_get_csb_size,
 	.get_csb_buffer = gfx_v9_0_get_csb_buffer,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 034cfdfc4dbe..717abf73f718 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -28,8 +28,8 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 
-#define SOC15_FLUSH_GPU_TLB_NUM_WREG		6
-#define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	3
+#define SOC15_FLUSH_GPU_TLB_NUM_WREG		8
+#define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	5
 
 extern const struct amd_ip_funcs soc15_common_ip_funcs;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
