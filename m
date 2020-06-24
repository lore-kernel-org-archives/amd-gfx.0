Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830FC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A63920738
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OEhTMq1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A63920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9B86EB83;
	Wed, 24 Jun 2020 14:41:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72626EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4ugNvFm7nv6FobX2N+pva5PGfQ8LWmMUePyb2ECwYSZSa2TghxMXmUhnaV44QnRKIhbCn/BS8KSLKtzoGto781sSDLDN24eWHyOwkPM+MLlYqvPtiRt/lrpr2onEx2M/VUHtydLww03ZMkW61doS0b+1T3pjkWY+v10wRUzpSf0Kzqr1vrntfEoTlj/UXEE2CtBsRwgBOdIIVWx0ZTMNJBt/LxniaZUHC0nnAJgxx9fKuH6WIEPz/ZVwF5A2QqOnqXFiB5UiPW7w9GKc84LM0dT8+Bj3EJnOunLoNeSuiml2B4z+6HRzKYxFXPpJp5xMi5NyyNVNcFMhASgMTcI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn5wOEijlvbp7yZI0acJVYV3p7B+RPn4QlpGa8/mz+0=;
 b=L4b1iot9bKV7DGPQW348q72+9iIUdEeUEJAUrQSj9VvTOLbkft70GN7/c0WbC2rWU53CqYftS8pmjbHmRmNImPMywFCuZ0BqZZLhm1Rp2XSRA2+vGb+N+HS/rz0Z3QWwCQAIvMbpJqDAKYpYkd3qylsdvAAxnq/Bx61c3QtYAXQn4gFqChxRymAMpaM+eHM4LBt1YGsTMJc4vDuth+DqFW/TVo4+99gOsuOziFu85kys8uV8/fejR6ovMeTEm8ZcJOX9mqbyNLk2aJT+V1UYYmHeQB/TwtQTE6sAQfr5a0w3SxeeLlIJ6TsFCLtQmvtO4ann75jUHL4DHNYWv8nc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn5wOEijlvbp7yZI0acJVYV3p7B+RPn4QlpGa8/mz+0=;
 b=OEhTMq1KkkyWJEopqSVZY3uUA3iZnWXJlN0aqoaiMvNFoNm7xblD9qN2OjlwB7nFBMC6R6Cz2suS4iFK9wJpzbK7dVJgVIsMVl6xsb5UUwv34QTRbUpBMDS4QoSQYz9n0e8tv24R3B7Gb1Bcy2gkcuY1pDJjW1KzU+mWi4crQiw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3863.namprd12.prod.outlook.com (2603:10b6:610:2b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 14:41:13 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 14:41:13 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: move reg base init forward for soc15
Date: Wed, 24 Jun 2020 22:40:19 +0800
Message-Id: <20200624144021.4297-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624144021.4297-1-Wenhui.Sheng@amd.com>
References: <20200624144021.4297-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR02CA0157.apcprd02.prod.outlook.com
 (2603:1096:201:1f::17) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR02CA0157.apcprd02.prod.outlook.com (2603:1096:201:1f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:41:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9062b97-ef40-4a1a-69ea-08d8184ca48e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB38636B24BB0D5966B1C302638C950@CH2PR12MB3863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAL3l8vIWPFbKkd+KssT3KPyIBUrKPrWiaR7wOdITkL5Yx/I/XGEeWbaNavNoNtghG4nVyM4zlQQyUPc9wFsPqkOe0v9n3gKvQAVMuZnlpkwdZwtDki7tVfPgitTt4jYvPyr6PUtUAcS/KdujN2Jl2mhr3t54i3hEiVlWzvv8VNajvZJRX0dw900I+QyB++JU8bxmSZ4U7hBZTT4XYnzNUZpF/pqSZYtSSKRnspUwCx4icimjqcvCA+OodHy+5laY39BixA9xvN4ZdKs5Ruy49dEXy4XVpdNAsTTjSH4EtYgySoq74VRvCmnIxZuiY8v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(86362001)(478600001)(16526019)(186003)(83380400001)(5660300002)(6486002)(36756003)(26005)(1076003)(4326008)(6916009)(66946007)(316002)(8936002)(66556008)(2906002)(956004)(54906003)(52116002)(7696005)(66476007)(8676002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oZ/ip3+m9S8+6OBYPJEV/F+9QMnuyYLHqx9bgVoLjPaAueMvpsOGcq1ygrjT/6K+72mHbolVvEoD7Cbhs99szHfiMH1xQ4nkX0+9h5RGO+CoQKY0eypK8cHPSfsNNe9OXr//un7LQ+y/3UQMwiFm0xMuuYqRjpob8FQPuoF1Yk/n9FABw3EyRnL8KFakaVInCy3JSCbAyOJnDc79gcxe5RhnUV4fBaI49EeA8eK1zohkuZ5RWSQTIxa1yG7iN4O3gktDxulfkAbB6b6ba2zTwAv+EUtuhKloLgnc01JHfVJAQCiihakV4ZXUvVVkxzBZqwMMCEOejJ4a9up1Ywbh1zAtPxDagkO+zIEO5NImamHG2Z8LdGPy0nwuLzwD+HNSaYFxnSZGqma/HkbKGdTTac3Wf3vgY9lT+uEC/J4PWC7cY2n6W4tvYOC4ZGWRZrSdy9E+DZEc1X/QnY9/JPN4OtxRduwo9p6m3BTEBtsfUQ5mlzknlrulaqYRCpFkP/jl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9062b97-ef40-4a1a-69ea-08d8184ca48e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:41:13.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuUQ/t47bxqHvezidJsmRqd8VbZDj32847mmtf4e5nmcJcvXTs95uLU3JX7VoWq+nu4Xb70bt/tAteKXGxFuqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3863
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

Init soc15 reg base early enough so we can touch
mailbox related registers in request full access
for sriov before set_ip_blocks, vi&nv arch doesn't
use reg base in virt ops.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0a3031fb90f2..21a5e8aa42b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -669,12 +669,7 @@ static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-void soc15_set_virt_ops(struct amdgpu_device *adev)
-{
-	adev->virt.ops = &xgpu_ai_virt_ops;
-}
-
-int soc15_set_ip_blocks(struct amdgpu_device *adev)
+static void soc15_reg_base_init(struct amdgpu_device *adev)
 {
 	int r;
 
@@ -686,6 +681,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		vega10_reg_base_init(adev);
 		break;
 	case CHIP_RENOIR:
+		/* It's safe to do ip discovery here for Renior,
+		 * it doesn't support SRIOV. */
 		if (amdgpu_discovery) {
 			r = amdgpu_discovery_reg_base_init(adev);
 			if (r) {
@@ -702,9 +699,23 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		arct_reg_base_init(adev);
 		break;
 	default:
-		return -EINVAL;
+		DRM_ERROR("Unsupported asic type: %d!\n", adev->asic_type);
+		break;
 	}
+}
 
+void soc15_set_virt_ops(struct amdgpu_device *adev)
+{
+	adev->virt.ops = &xgpu_ai_virt_ops;
+
+	/* init soc15 reg base early enough so we can
+	 * request request full access for sriov before
+	 * set_ip_blocks. */
+	soc15_reg_base_init(adev);
+}
+
+int soc15_set_ip_blocks(struct amdgpu_device *adev)
+{
 	if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
 		adev->gmc.xgmi.supported = true;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
