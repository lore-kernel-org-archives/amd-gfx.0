Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C8C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83F3610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83F3610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627416E42E;
	Tue, 20 Jul 2021 15:44:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F1A6E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0gkgBtL5TubK7ZobnlpZIJuIiqzBehI0Q9fNY92PiU6ujyTf6tqFeUcsIYu3inC/MNBUrrjdOBtXFzdyMnWFzKXmx8kVdwOT0JanZ0g0YUmrfdDQTB2F1ZD0GMfs5j5SMnADkZdJlhmiVGmFqyPCCLqmBszAyvlmdDlKC/kGGWmn9eld5or5dIWhgvbrjmF2fgA/SlHgOXP5Z/k86JwoC9CUiSO/jbIukhAFy2T2gvjN717r482sDOm/tPKqVXwqGa7uoLesPMdQIYJHvBvk726qDIo0s+zk8QdbZxxuqNfgoJvqMOhVOUpfDJFqoDMvrwagK/9uaCFlLFx6ArAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hD81+WZX6GGR4QoNKE88FlBmL+/oF8/Nz8g7Yeu8MU=;
 b=Hc4AY9lpgxa+L4/a1Pw/2OqGTBUzGB6qsGybIujyYNHoBA1PNvFNo4GmQkOaAGu4A9MDpbbO1f1u7N0U/sS2CbK/f8fdMuieYz5fsE3jGXDwo4kOVcsKf16NhKQXUH3kzpXtLWZDAKFZBMs/tgkWNPWUXVnFx7mmvCZnh5Az9gBvjpE+rxSWchp1dbNipbCVdWNK4HZEv0Gi70kCZ3FDD8XueYhwjZiVthW0IIlO3QRtJqiAellYbw/W+PUQPQa+kc0LxWrbsFwTH7KEv+RpAXPGUCzep/oPv6PaRL+54zAbqo9qvkJCJzTq3Tfyhxs1GdjBveVytg1vyameL5o0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hD81+WZX6GGR4QoNKE88FlBmL+/oF8/Nz8g7Yeu8MU=;
 b=qOuVwdm82owaPsuR15PDkSC6wn+qx3tUaXUUKyVx5Sx4O4mPZFSA2Bki6h7dU9EPnVctTpXehjiEZxYvDs2lzL1iMfZLVjmUP8YWOJ09FAB6tKWpSf5MG0QkjDQ6jKdNNn+/65OYX/as3aPamJFYkH+ljHSLjWPyWUAGsPUx6Vk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:10 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/29] drm/amdgpu: add cp/rlc fw loading support for
 cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:27 -0400
Message-Id: <20210720154349.1599827-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca0fd92-a6df-4e29-f936-08d94b953748
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB534972788E6E40798D7C6A9CF7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIs8oV1fy9Zo7EnFtWMjwl1FcR7n6x8NGzU/y14e2on/tLEKCRhuwRdzP39uupNz/iq1BZ1BKmxdj5HG9+MFO04VCI3+TMnm7AyInfhTWVz+X1+pRByI53rXGOyDrhMidYah0sFno/hOIqmSruDvfMGwiynWQKmz0gGi1W0aP5RhB9umoDYb4Q6NaxSaJgWdqwpW4nYfQWJLsDkrHkp6tPNvMRImmsBumILdl4D6I0+25WPwR46+lmCjAHxnXgCIOcNEVi8QFKQZTEW55zQ/E2CFWgg7fwzxRzSJMdAVxzZCx2n74Ts1xyUl/fQsbp3ZsCWAYU49LXqxgppFsHMkgj0wjtfJKcZL4KY1CadNZrUl8RTetl6CEz9JrT1hG9L8XeQ/00MpNcKiv96GLchsQIs3KCZkftg3qxZ3/dXDYlnt3wKCPHwr2MxL/UaiAQUXZlDasL+Wm+/ZmNWaPU8IMQZtjTgXz++oexutIgUd6SN9uaNN2qoTedmpoJY/rsr+mxxAWRTsNN8OCbgSMQsKQYZg+KRM9irG+8nVCAeyKbUGxA2Nd9C2068v1xrJ9+gPQFrNImRzdi7bUiW+SMvpam7vCSCWxJBmTcJxKlg9vuZ2OCtRQgts6IuznJ7ROFENVmPMPVJmXNwpX/vcy2iRWjqAqqxyrzcj1jf0mScGrDtYMceMzJVDQYwHSdaqhWpl9gJfz1Qu2flWcLojKR4EAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(83380400001)(54906003)(6666004)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azluGLULxTxUyOGiaVU8ZsWR+p9tsQ4TjPNwBWDar5FE/I8ihfQ3cOfBr2TK?=
 =?us-ascii?Q?joA+O7DeU7AW/ng7oSZbfSo9YS4gJG4g2dyE69LbD5so5kTH6LdxrplahvbY?=
 =?us-ascii?Q?vUJuBSVSe6U3rwaTLC9dIvUG3LfZbV94fdITMn+/3hv6IsGJtnxSvGRz2weT?=
 =?us-ascii?Q?jT6aubMBFqqMpP+pMCPhQQoFVaUllU0YvpS+MmhSM6tnrAkJU1lePq26mTqs?=
 =?us-ascii?Q?Lr23A62sNxTFz/tSFvc6AnzFidyl0xc8UNhFTJ7l+UZr17Qd9S9GMcJ4ubjT?=
 =?us-ascii?Q?hgsxQfYwol2UKOLCnaq0XqCHQtKAamIuGuDH9ZBZmxM/t82aeMIuRx5UX8Xz?=
 =?us-ascii?Q?eFBR39+K35PxGpfXqd27AvbMwtntAG/yzJbZcyBsADZ3mOpwL2iDm2ANwfKg?=
 =?us-ascii?Q?f2zYbxV9ilXwuL7C5MidvRgUKx9bt9juyC2BbmjMQx8TFHVvaHrHE9SjPnfz?=
 =?us-ascii?Q?bzF8+iAbTn+QijhPlWw6XVAFmYuu8ayw6XwOKCqb7zqAelpTP7YQYDgsOc+3?=
 =?us-ascii?Q?x1j6wsvdbiQ4qkGa+qOGJQu2xFJNLiM+jSHoHXN/VabblBgU1YC1oyzrfjJL?=
 =?us-ascii?Q?cF983kdDrMeeB30VrwZEoP1nOvUfgsr1xsnLKKJdbInI0lvs75X7KcGATPu1?=
 =?us-ascii?Q?r41+Qt2/v9OeBaYSt5rjVTimNP3EZgBDW096+ZupCYgJ2Ng6+oBV3UHiVdK8?=
 =?us-ascii?Q?fRVVIaiTPE1I9Nmn6YHXCLwekoN/U5i5sngOyuDEaFQW9THvusd15knj3c0i?=
 =?us-ascii?Q?eNkvb0zw5v97GwlmFfDhM/ag6henv0pasEjt4DB8lIGJPQiVGFJBvgqkRtW7?=
 =?us-ascii?Q?HqfZKYbsI/QgGv6SBt31GMmHHezFzSSOXRhgWIPF8EEsJ4yoOTAQSevhkRM0?=
 =?us-ascii?Q?YLQoWBswJ28e6Qd07pBQfQt/LRJjA4QaBaI2fcrEwduBgkli1DgIVzvx9K4X?=
 =?us-ascii?Q?6JSNlwtmQ7Rs3QAFjm569nQJG8x+TzMqpKp9IuQYMv0IiWnVjbAGMXohB8+F?=
 =?us-ascii?Q?ex3TJ0hWnrsf4Wky0lmWbD+HPZscWe7T/PkkHbNliUUZgw7aPDxqYQ/Bql2O?=
 =?us-ascii?Q?UdDCXcsNm0NoNLWKjUl9LBrvEvQtFJHZrrEtSvKDIF0K3KA6nvdOeqFYP4s5?=
 =?us-ascii?Q?N9InmzG6HBSUoZf2sNogH5rs9eqqLw+/IXw7BZ8laUexCSFEowoB9GK1gkJx?=
 =?us-ascii?Q?jJ6jUjBNLAdFINPde5K7eSbkAsvzQcsIdFr0cHoRfMq8UFBWhHQPssOOhUy8?=
 =?us-ascii?Q?Nb13srscgkrnO02+HMhWBmtritKaF/6HRJHFAzmRTk7Cht9Dj/ksWmpAawRz?=
 =?us-ascii?Q?EAVwJIhGF2zF0p8Ql9XMSD9i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0fd92-a6df-4e29-f936-08d94b953748
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:10.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlNQ4KRkjZeIC/v0wPLNIU2SeSFiF7yF55tmU8tjQBdTNsA9bQwZHVkkteY6Z81/jLLC9Dw80D1rzw7No809Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add cp/rlc fw loading support and gfx golden setting.

v2: squash in updates (Alex)

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 705fa3027199..47b348a7fbab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -253,6 +253,39 @@ MODULE_FIRMWARE("amdgpu/yellow_carp_mec.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_mec2.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_ce.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_pfp.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_me.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_mec.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_mec2.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_rlc.bin");
+
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_ce.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_pfp.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_me.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec2.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_rlc.bin");
+
+static const struct soc15_reg_golden golden_settings_gc_10_0[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_INDEX, 0xffffffff, 0x00000000),
+	/* TA_GRAD_ADJ_UCONFIG -> TA_GRAD_ADJ */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2544c382),
+	/* VGT_TF_RING_SIZE_UMD -> VGT_TF_RING_SIZE */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2262c24e),
+	/* VGT_HS_OFFCHIP_PARAM_UMD -> VGT_HS_OFFCHIP_PARAM */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226cc24f),
+	/* VGT_TF_MEMORY_BASE_UMD -> VGT_TF_MEMORY_BASE */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226ec250),
+	/* VGT_TF_MEMORY_BASE_HI_UMD -> VGT_TF_MEMORY_BASE_HI */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2278c261),
+	/* VGT_ESGS_RING_SIZE_UMD -> VGT_ESGS_RING_SIZE */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2232c240),
+	/* VGT_GSVS_RING_SIZE_UMD -> VGT_GSVS_RING_SIZE */
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2233c241),
+};
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -4026,6 +4059,12 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_YELLOW_CARP:
 		chip_name = "yellow_carp";
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+			chip_name = "cyan_skillfish2";
+		else
+			chip_name = "cyan_skillfish";
+		break;
 	default:
 		BUG();
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
