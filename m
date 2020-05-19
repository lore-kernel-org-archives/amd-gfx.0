Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 14:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11286207FB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zKDFkblx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11286207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B712F89F43;
	Tue, 19 May 2020 14:41:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FFC89F43
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 14:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFEP8Dckv31TFY3+uXBELo+9MSa4qgXk/fJjrfqsVNv1mNMJjoD/QZZD0yU4m04iCwYHU7UgCqZnnXUMYgh0D3SKK0ktqVCbH9bw15A3/EOwc+y3fWznpngobC1uizSaV2VEfdibEila+L0DySKCXq3l+eX4hjEHHE6qXThBjaAq7RLkrB+QE4qA2BzLHXkBXhc2ExNYkTzSL8M3E2zXkLlhQK2SBmy/FGK1XzkmS1Be7zUiqRH9S0BZl5pBDyqh0H1bdVV7rGU9jVA8lemq/mZ1TAo6TNBDo94eztTPivagMNjZqY+lpWKCOF2D6zfWMN5/tDyLySDuWTu34MTXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH/PxFcmzVCMYJrrRS4eOcwfAhz1IwfZh16m5KYsbJA=;
 b=N5LkZxKppCK/3k0Qs0oMklAnE8/E0L5VAtnWL751Jn4ZfjLAVrtdgd9BbPWeDIw6KfaOHGnxyc4TVtsezKzO550zH2fotxcip0H8Y0swRGil+IUXu//IxINd5q+BVbtD3uuYmzGaZYfMM42jtwj1396GXkdWELi/+3jFHZ0l7mUhCznq3OcwXjmSxbRTdnL5kWR4wHOLvTdYWKgwKRkapT0FhuPJ0i6wJDsZ5HwjLZyjasXMrikcU7lIWFGPw8jo9Xwa4801gRttLby7zEalU5bUeGqwQ8MNZuAVl96/cLLs/rythC5ozRl4HsgW6ZJgPVY5YB2JygZkcN8bjkPLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH/PxFcmzVCMYJrrRS4eOcwfAhz1IwfZh16m5KYsbJA=;
 b=zKDFkblxZ2/XNVAtO6Fb0gGNtK2k6F4lc+BjTAHeUMdqK69/IFXMwr2847oUYmjiqMWoR+T6YIpiQsBY/ZZUtBVeiSPRMvAs1tD8tFTsoOoIDqphXxLTIbE35N2blTwAQfWBMRpz+n4zHdnhob1LeWzN93Ea+aA6Y0eSU2ENHBc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1370.namprd12.prod.outlook.com (2603:10b6:3:76::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Tue, 19 May 2020 14:41:45 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 14:41:45 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/jpeg2.5: Remove JPEG_ENC_MASK from clock
 ungating
Date: Tue, 19 May 2020 10:41:36 -0400
Message-Id: <1589899297-19138-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 14:41:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8099a759-c4e7-4c39-6c7b-08d7fc02c08f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB137039A4AFB71A5F8678E635E4B90@DM5PR12MB1370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dw99T8nxn8QGnbAv/Xhif0uXEHIueMvQC876ytcBIsSR93a5SZ04j+5+ZdiqMpR7bwYzid2WOFGnBYivW4zfY4eRxjjj1Sn0Pu6edb5ifTfvzYtH35bBys9ZzqFU4P47B/0q3SQj3ZnbTdBxqvghksUU9vDZd/T97PJ9LeCNEU4Yhbs36w3P0bheLR4dvhNvMn+6SQ+vFQBvMBlEk1hA2ZqxzYAPhzDJiMeYNOh30tyUhd4QCgKdnrecbhb12/DwvBiwAE6NWq8Z+hANU+KXyChZf6v88vTTN601GySVtVHWZmOyXInU+wkb7w23xe//SCTAV81VeCjnCwjCy+Q9UDsNpgNb+9Pe614PTiyZBKSOUrQy5YeYB02H/zyNiWoM3ofCj/b0IJH0wIVSoTtPr3HkkAg8z+Wb06CWnfGxlISt0NnNF/as6PQzso+WPs9n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(66556008)(66946007)(478600001)(5660300002)(6486002)(4326008)(316002)(86362001)(8676002)(4744005)(66476007)(2616005)(8936002)(26005)(36756003)(2906002)(186003)(6916009)(16526019)(956004)(52116002)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RynYu5EVie2aB+PJpD8z8996uZXNpBLzhipEg2QNe3hrtYNxYhtJy1j4/vJVZcfA9etrxy2HQJ2mVEAtxVDrX21eMevxHo2ShHErwbdioGx6OAiF/j+V1pQELXDDS5uwFdVMP+mgrL1ISXct/bm1bVAkUS7p48tcU9mD/KxN4RuJff/iaHHMVnTo9F93yqHbt6xTbbe/Vd01Tl4WhkkxtJS90FFZG2R5baORJJsJmj+76Nq5KcgAzARPphLtTm4KZJQg+QifcBeuAf5xwfqdJS7RtM/4+76pHauBQo/dAf/Gq9JEUq0T41q9qgZ5q7kOHzdtuDX/33WgI/OvrJRIocJbcW92kZcLI24Zs1uqjYISBq1LUGbPGOovf2wfHi+Lz7hc4+Na1wtv8QBzmhvS+nhrnI8mYaFl+iZ4JF4xBJAyRaX8mEI4CJbQY6feimjpnmm0MA80s6n76UZ0fcwKl0JGiVGQiB+lLxd1tOV5IK0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8099a759-c4e7-4c39-6c7b-08d7fc02c08f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 14:41:45.2420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CjygYR+JTdzOoxYKhnqEhXWL809ozqkg6Z7ZrEMhja/2E8L/x233f+VVnJsnSNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove JPEG_ENC_MASK from clock ungating since MJPEG encoder
hasn't been support yet.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 37df3f2..713c325 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -268,7 +268,6 @@ static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device* adev, int inst)
 	data = RREG32_SOC15(JPEG, inst, mmJPEG_CGC_GATE);
 	data &= ~(JPEG_CGC_GATE__JPEG_DEC_MASK
 		| JPEG_CGC_GATE__JPEG2_DEC_MASK
-		| JPEG_CGC_GATE__JPEG_ENC_MASK
 		| JPEG_CGC_GATE__JMCIF_MASK
 		| JPEG_CGC_GATE__JRBBM_MASK);
 	WREG32_SOC15(JPEG, inst, mmJPEG_CGC_GATE, data);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
