Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566DC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4DF20738
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gZk08g9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4DF20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EF56EB89;
	Wed, 24 Jun 2020 14:41:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B1D6EB89
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhtz6FiZWWYaoWqLDqTw/NhUa+BCU0cvmvaCaAyhcrZhtor6ps53g13UkNPFHwqLUbHLadqnQBUT1b6scRj5tXQGGbWexePkuR541Q+zzMT/HmPJw+HbN+ogiAu1pyRMroW4HQ07nsCbGVI9kg0HnnaUTS07i29b2jjbmDPw2WP6B7C/KjWA9Rijzb3JDsMz9oGtEj+k+v+Pyaf15nGbEBfwmINw2e9InSGMbRD35I4pt8LpePSVAVO6SKlRsIzx6bkDNKAC1H4s0vdUwlBFybKwUBdze3A1vm3tJrsmiaRrrk29uo/7fwXL0eY62kqEUEN18OU0XJs1ybMH13yvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKL55PeEYLns2Rvb38T2d4FfOU1LC/wewWg/D1b7BF0=;
 b=Rbi85dsAKEtOfF65JOLplZHfGoAIl/U1mcDVUzzmEkuERj26XAxLcu660+QPAy7eoawrTiQTz4athNT6t26Yfx5ONAqVtDABizMLd7Gah6A/I+xxstD5G1fOMPdBDBlmJyn/ofXBJX9uOH63x9Y/IpFxx1nUnmgMwi8f2pZ7p47+8ALayfGySejVR6st2taAzSLllJ9vl5FZzgVZ8V5Pbj7XT72S0HeFgKX5cvnegr1gysbeQEMnPwMVx7GybpjmIM8ENXyIscXUYPIsrSQ5yxvppbBWjqQERdkYzCOh9BL1e1ce4I/a93YIrp6JTy6iEhl14XtauzqaTtn8XbHqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKL55PeEYLns2Rvb38T2d4FfOU1LC/wewWg/D1b7BF0=;
 b=gZk08g9+DK/xJZ9De/+jT7CzFy9iqLxXrXp1vxOPlWT4yfTRuUObBVuGSDwql4HW40sqPtobSR9L8Ww4dy5M/ajExIi+sotPtTbzWPOCnP2s+hNGvbssJ5GecI+NtF9zGwiYcVYOlyQ2QczSScgYIS+s2cCD/BYdh528yJ1NHgw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3863.namprd12.prod.outlook.com (2603:10b6:610:2b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 14:41:20 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 14:41:20 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: merge atombios init block
Date: Wed, 24 Jun 2020 22:40:21 +0800
Message-Id: <20200624144021.4297-4-Wenhui.Sheng@amd.com>
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
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:41:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6c78ccf-34f1-4288-c845-08d8184ca85a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3863DF503CF0300A17BA28548C950@CH2PR12MB3863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRXC5g5nZswICXGwPmoaIZBZi4p65ynVqrgpovbOJY8DAC9GOEWLuGEyIF+T5Vq2qYPP25IrtLKWLey3P6+eE+XtEboF8hsNL+ZvzAZsp/H2YUBA2BM4uUu4jL5AGRszTVLayNJJC53WgkzSAiVggNg4ZsWUzHXmnG++kig1lBW9Wr54AxaHPvqYt0hvfasluCF5JOcMJGgngAvUVi3S4d/Zlxlmc38YqwOseqiHxNvf64lZoW3IJAzRfDeV/GE1WnyeRycj3iGWjYP2hqxtEdJePyZoYoYReIZ6QKWaWClDvhiHL4+Jgsl3T0c+MjYQTWLevREnim3lKGCEfW3sVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(86362001)(478600001)(16526019)(6666004)(186003)(83380400001)(5660300002)(6486002)(36756003)(26005)(1076003)(4326008)(6916009)(66946007)(316002)(8936002)(66556008)(2906002)(956004)(54906003)(52116002)(7696005)(66476007)(8676002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZqMo8Qv+jaP7hTVz4rcBTtfEjFjzF3zRjDEgbd5Ca23eQk2PpDV1PqQUPtIeQOGNNRW+vf2duPL2ptKpoeC2qNU5B3v6p2uXljSxMDOpm7xE4uCWpY7tVGUkWu1YpheXCPhXfoTQpvqLE9cYfDHLN8WTx5jeH2s7NdWBL7RWp6W5pJaj+Y9vClmkx/YwTqy8QJhZ+zqQ/ts3OqBYfLwkySm92nBKMtyAJraRL3VvE336eVDDSQWcpvjgfVl0lbPyjWOPmlVR6yK3VaMc2MnxQP12HTtRVM1rnw4MwCHzOHgVicnfQxDqBU2sEnbdvCZ/ye5XU/cfd6zZgOpm+ELJ5el+D80yrB4T1y4kIGWOoPHCk3dMruF0KuEFqC4M90REJe+YxiAlcN/DQlio4Pive8vR/W9/BQOpmNFAY+QBwxsMt1j0dR/Ck7F336wG4XPBxvAV+p5d20ZvLJj2hrXzyEH3fx4ZaRxtSQp1+3GZxTuPVm03wqv83geRA6gLdEkD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c78ccf-34f1-4288-c845-08d8184ca85a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:41:20.0395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yKJehIdYd81fmrvLkEpmhZ1Acq8pqCX0YrNgMJ1aHtQvEiG+ccKxrBgJfDINIi1cpijunYWH4shF9YBYTHSgA==
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

After we move request full access before set
ip blocks, we can merge atombios init block
of SRIOV and baremetal together.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +---------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 138ace9c28d6..f40bc6b5be82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1723,26 +1723,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		/* handle vbios stuff prior full access mode for new handshake */
-		if (adev->virt.req_init_data_ver == 1) {
-			if (!amdgpu_get_bios(adev)) {
-				DRM_ERROR("failed to get vbios\n");
-				return -EINVAL;
-			}
-
-			r = amdgpu_atombios_init(adev);
-			if (r) {
-				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-				return r;
-			}
-		}
-
 		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r) {
-			amdgpu_atombios_fini(adev);
+		if (r)
 			return r;
-		}
 	}
 
 	switch (adev->asic_type) {
@@ -1855,10 +1838,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			if (r)
 				return r;
 
-			/* skip vbios handling for new handshake */
-			if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver == 1)
-				continue;
-
 			/* Read BIOS */
 			if (!amdgpu_get_bios(adev))
 				return -EINVAL;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
