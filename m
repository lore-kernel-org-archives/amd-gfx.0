Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DACC43457
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5950B2078A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PLqOg/1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5950B2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8156E9F1;
	Wed, 14 Oct 2020 07:18:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA22E6E9F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh7azocTUDGDCn7sMZmO48fW2Uf5dSSjOpurnswXJzPKD+UOlmsoT2bLzyEKgdrzJPTORKrGKgVXsX4vzdpFhyolHCjzBaRojB11jPOurwQlmTh/MeenPMGJCJRpEF4sDkuqnsdNYi8KDmm+BeIU5z/Uzho/SlzPOwlQaI57uiw044mWK0Squv1C5fN3mzig3F5G8/A2jF7Mo70sqXMLZo1UeFwivz5mMbo1R8tPlepQhkoHn2G8z+YS7MbSV6MHgtBNvIuR4OjbA9X28dag8lTvS1r1njAityEDcr0dTzz2w6eOOEoVFyn8EBoLYsbsdSaULovFfHpIVOmr1HUnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyDQrtTSMHpU6tz9zYlRu5DAYkfvwnkAK3JOHv0f4io=;
 b=c5SEitupXtYRDyUCn0se7p7oMgxp3y9qEiP7FLWv9jxPE4PIMBQNx1Bp2hWjF9Qi9nnzesNPN2ikvttTRE7XMMJq5byNFxza826hsmEJpWLH2wc+EbDS+1mm2wFHdioRul5T8RCEdhXX/3q71sjHr+664actk49ngjgh+1OJcl98lXgQ74F99B9sPEway7TnGBGdRQCn1yXGtsjxZg22n7gGb1VbAXW4cx1xpZwYPI55oOo8ORU5qo77ARXLjjo2AorkFjoe0+Ffmo6+Skmj6LyoAbd6rxOuh1oJAdGbehMgWqz4X8Gg5YNJfzIakaxEDHP6YeEDreLkAxbJLCcsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyDQrtTSMHpU6tz9zYlRu5DAYkfvwnkAK3JOHv0f4io=;
 b=PLqOg/1rHgIa9jzL7e7/bN1eXJqYMGebd2sKUSaENbpqS2w4Ty0hn8Tl16UntIFyqhgdrGJqVnaZhj/3xfm/7/JBQnJ7hVfHjynLHiAnjHcsyL3ep6qAsBfBwI4HbIh+MsHMN+NG3GqybTT6IybQd2P0OmLZEzLUq8K7maXNEjw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Wed, 14 Oct 2020 07:18:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 07:18:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: add interface for setting ASPM
Date: Wed, 14 Oct 2020 15:18:09 +0800
Message-Id: <20201014071812.8396-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014071812.8396-1-evan.quan@amd.com>
References: <20201014071812.8396-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 07:18:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f315625-7425-4253-9683-08d870115e0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB289178C264998686D11274ACE4050@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRMiMaw0QniOdEXCeRXDqKgwtTm8NEnolTp0teo+tQKal7/XMROh8alGF6fmjlOyfIR7IjfZKithPzUQM5Mn1S/xw6Btgh0eNK5Zde8/vYI5EA3m7fKqJboyCv3xDcQFlFj8PtOKv20chmfWKmS+MVM8KQMCdnYYksZqyo7MwrAE1ZXBTBg+S8bJ7joH90mZyKATh0lZbQ2B/k6l+lBtS7BR1tehnJVJE+3hG9cvZtPfzGvs5pfRgWwSa05LW45dVzBPo/z4aJOxsK+sAg5JNdb+d5b08Br5ETMqVp1bPMO3WJVKITePv99OaqNn6ttf9pJuXfycFyJ2wPSAZo+XiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(376002)(136003)(44832011)(4326008)(7696005)(52116002)(86362001)(66476007)(66556008)(66946007)(6666004)(26005)(16526019)(316002)(5660300002)(8676002)(186003)(8936002)(478600001)(956004)(6916009)(2616005)(2906002)(6486002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RckXNhvJj8xejnG3LalWIsvpt/i6f3tVIiLTxMouwwTh8g4RK3RPRaBYildwduq9bpPVUKAjZDgBbNGRz6NelQeRq6r+ZOQSNoZEziY7dKODLzLBt8FEtJRep45+G14+/cQiqmUOAGzHs3sd56zt/2y1LHy5sfx1ERuorqkbCnDwWR0O5yqW1ZeGEofq9J0nUrfHt+fo3VXpg97vfjD561idE9LScMA7G4q6b/f+5ENPXz0DqxRV5aRuXy8Zo9iOrVRjPHLvzIGxF1MvgtLDBd4+aHLaax2GxVRTGoB6ILG8Io/exYiQfEjiZtAEtSXLzuEJ0l+pnt9gaGiF/VVkoWKgjnb1TgqxnjzLeAFRLAkORjM1Vzi43wpbc/3eKESde0zD0Z0UFesisueSYz/X3DZACf4PKOk/jCOpOjFVgelaebAupeF9OZcFyy673yomw4QBITX1KMfXaS5M0ovcYDswxSVf0iAcvVnknLS14L0OqSc5m1iejsezOLLfWzZoAT1Wpodafz1O3Gg46qmxsxp0eC5QVTAJZ+W8Iv2TCCWlWg98xRhjxYzJcZGMHq+40AAhJ1ozMlzpOMUws15Lk9kGkAp562tAQ8w1jfpu2PJhRsDeIcC0oOAY8Zw6F4CcozTLKGc6QxHD+H3yMOQaKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f315625-7425-4253-9683-08d870115e0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:18:36.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZuB/WOB7lt+8h66/QLTVdhCRLh6YO9y6QhdjBBwbt7MPCib8lTUvb/5iVVhmfKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support NAVI10 ASPM setting.

Change-Id: I0c9410951e23b1d4a30bf8e373431dcb16a4573b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 39 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 483834a62436..e62cc0e1a5ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -87,6 +87,8 @@ struct amdgpu_nbio_funcs {
 	void (*query_ras_error_count)(struct amdgpu_device *adev,
 					void *ras_error_status);
 	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*enable_aspm)(struct amdgpu_device *adev,
+			    bool enable);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7429f30398b9..e0048806afaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -28,10 +28,12 @@
 #include "nbio/nbio_2_3_offset.h"
 #include "nbio/nbio_2_3_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include <linux/pci.h>
 
 #define smnPCIE_CONFIG_CNTL	0x11180044
 #define smnCPM_CONTROL		0x11180460
 #define smnPCIE_CNTL2		0x11180070
+#define smnPCIE_LC_CNTL		0x11140280
 
 #define mmBIF_SDMA2_DOORBELL_RANGE		0x01d6
 #define mmBIF_SDMA2_DOORBELL_RANGE_BASE_IDX	2
@@ -312,6 +314,42 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 		WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
 }
 
+#define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
+#define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x00000009 // 1=1us, 9=1ms
+#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 4ms
+
+static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
+				  bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
+
+	if (enable) {
+		/* Disable ASPM L0s/L1 first */
+		data &= ~(PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK | PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK);
+
+		data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+
+		if (pci_is_thunderbolt_attached(adev->pdev))
+			data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+		else
+			data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+
+		data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	} else {
+		/* Disbale ASPM L1 */
+		data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
+		/* Disable ASPM TxL0s */
+		data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+		/* Disable ACPI L1 */
+		data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	}
+
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL, data);
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -332,4 +370,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.ih_control = nbio_v2_3_ih_control,
 	.init_registers = nbio_v2_3_init_registers,
 	.remap_hdp_registers = nbio_v2_3_remap_hdp_registers,
+	.enable_aspm = nbio_v2_3_enable_aspm,
 };
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
