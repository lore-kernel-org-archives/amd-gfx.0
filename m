Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D2FC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE0420658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U3MxJJ1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE0420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D8C89ABA;
	Wed, 19 Aug 2020 09:58:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799FD89ABA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 09:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNKjZXrp6LErkBWQRXKjukq34hGeb+G7yotzYnaZ8fnmrUYRwovE9YBEoPQNG9wCmsARL+k0xph/bpC8Y/B6OxH98w8f1dsIuMzzOGqvATPo74/1znJSAglHNk41hQ1YlLD6zogizS4wkdzl6J7dZ4rYoGr/uJuCzYIjUMB1bhHN0mNFlANqfyCiwHtBoH71ifOnTnd/iZ28mkKlJRK6V35xMJPEuAexdO5Ed0ggfwMx/lMz+2Z0tyr2BwCa1mBCljgJnIXvDyCijOaRf7lbpD7jkVXZ1zGtxkqNJuz1bJZoE4LnMD8zSrnNLBFDceKCvea753v71cBh2aqC4PtXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBTYOTTDR7ivw++U5OMhTWK5UTAe4EqjMezcva2sE4Y=;
 b=SoCnKqyRg333drvJ+hx5xJKhzHwXJgXXt4l6l+7HbH64w/1jEKYaEJDj9Vh38/E6F6J54g22DdR2dN0gdzop8qisTxlabUNIWf4hQDlaQB6lIS3JmnZN7zvhgNAa8dqeT/Mxow2LL9/5gcx91PqfOMpAhrNpewO/WpO5lpS4LTpcJLu8XCQRNdEN3DMnsCkX7hd41BlWiUeN+dL9KWe8rN5K5Lnf/wgutqYcTxkwnjN15rDFjffO/CwC/y6+DvT7JmShM8Q9qSA7DvMbFOfLmBSHA0UIqEOJHhgfxpuzbTtqp7BrSqdYdAGKA39cdwfIKfFflmDf9RYQMIWFbBRwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBTYOTTDR7ivw++U5OMhTWK5UTAe4EqjMezcva2sE4Y=;
 b=U3MxJJ1gMVoLwvhv9VXE+DnAMUjgexTgZsX58ShepFLWKmJ5VZljJ/h8HoC4EdVQ9gR0oghbKOgR5n7WIkFTQFllys1M0DGi7BjZmCsPubmkptZk5scm5GvZd/UNO73N0Jf4kGd42gbmX7JmLckHwxJ74r0bt6f4fRFq39ZfYDg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.24; Wed, 19 Aug 2020 09:58:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Wed, 19 Aug 2020
 09:58:55 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add interface for setting ASPM
Date: Wed, 19 Aug 2020 17:58:31 +0800
Message-Id: <20200819095833.11420-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819095833.11420-1-evan.quan@amd.com>
References: <20200819095833.11420-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 09:58:53 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3b0e927-8ca4-49ea-31b7-08d844267bd6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02188D3924295BB8DCBDC76DE45D0@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vX62blKDb5vHlE+j51GejsllvBrrdYoRy463yy5ZHlZnq1xTCCpFa88qF7/Xmgsr+DdrBg7Te3CVx2Mpe3JZS56oGQlK4oKaLJIHIM9G+CYPk/WefCMisfugKN44WElxicwSQgAslBVcxhhVh+SZeYM3KYbnkbICP9NNsjBgAO90IdliniGVHnpjf95wiSwhuef5AU8L/1rBfw0y1YIwiEMuU9Z5Gc5N7V4jjknS5GSuJ6PVKjfRwoh2t+IU8wLRbRBVofBXxssnQKNQq06QnEMcYIzdkdSeF36ZgvKDsxDooRM8xOT3f+Qu6o1LHbhStdMg/2Cq3n83i2d5yWLfLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(2616005)(8936002)(8676002)(1076003)(956004)(66556008)(2906002)(66946007)(66476007)(5660300002)(6666004)(44832011)(4326008)(186003)(36756003)(6486002)(6916009)(86362001)(316002)(7696005)(26005)(52116002)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9Nj/kU6wSqF12lCfJLv86Jp3TOd4VOqfC4P9XN+AqhfcR+ffygu8bVeaOyZ4k3gE+FQPlC8rC9+lH410yR6sp9X737JFA54RqdfoeLv0IxecyKao+txE2aNViyCpCuCxPpTHLBO4Zy9SFYZSHmMI1R0zo49gpw8GIQy8Q1qgcgg59XMgL6X6bhCnV0XZEpYa/0UT5mlJqaOFKxOPN2aoubTRLb1FhZiJlxctnerXmwEY+XZXv94vIDb+rShd1gfEHPtzG1Ju3sFrwllmT1iBpb8WyHqRSyKpURqyhKnR4afFprPAkFh7XN6invf6Gsvwq+H34hdlFBeG32dRFLFe+jdxgzms5/a4AAcsMKeMhr6hkXT9Kd7n4JVV++NjCU6GbxcJasmbSprKD3zNDb7EXFlULSjBy6sMs6UL6MKwo66CLO1iKv3WZogu+h3opIM9v0IH+oqyXW2EPOS8qHTWe0MZEavjjusVa8qekdX25Qh2M2e+OAJK/ATgQv6gecFhfPTQhy7pCiog4GwDodYESFRKqlTrXxRSA9gHNu6yupwA8bvoUtD9J0pjVaNca8sdjrCplihyFpjCSumbzHpFKfv6aRM138lNAl+7mYZNfUaz8GIXRQz+uaBYQaNFtr7jrHhpUpzF7/Aha4AxU2Dzog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0e927-8ca4-49ea-31b7-08d844267bd6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:58:55.2664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUkLk1Bu+aYZXIqK7I1MSABVYxBdfK6C/TqJMhBVBg8T7h8lPgcaRxN/khIQjq4r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
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
index edaac242ff85..344faf39b7dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -85,6 +85,8 @@ struct amdgpu_nbio_funcs {
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
