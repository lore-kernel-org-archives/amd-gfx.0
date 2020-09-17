Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7525C43464
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 22:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F1220878
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 22:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M//TkjVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F1220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14746E0CF;
	Thu, 17 Sep 2020 22:13:40 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700075.outbound.protection.outlook.com [40.107.70.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0598F6E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 22:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdHHP+KUpK018Ai6b45qg4gZvPdmVr1hQkyV3wGwtXtKTTD9OEbO7xS8krCX3fCeOBKsgvCGwJRd4+x0bAkllsq0/qOhpyCEcjM8KOuPAzKpgcN4bCYvtCru1IpTPQaAg4Mv6m3H3vQ/sUZM+39QFxochmgmYi1ASdS/rwBHBqnn2iClb0BzVVo9pdrwXm+iHc6w7CQSiai8sTCOytcVTWr4IVth5Y+V5fPeZi9wJJDv0Dp+xkauzedW35Wkvt7q5QOiUJB8UNUNVg9C9N7peagfCkEj4nXfy9Qijjks53A+bard0lkTP5fPI34WxVEAO5JY+Uq5HzaT9e/zHczUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwFXT6KDZEURL5aHidT1RCirXZJj3G9xkKhQCiQ/SlE=;
 b=ijwaPrRc5h7d488oCkiEINM/C7YuYaMiW4b1yJO1UKaP1tQ8p7gndFzg/0xaTXggYNuYAgp0/ST06emyeWcpxyVLYGVFLoFTnDYhygiDGG7RkrQkjj3chm6R8t6ZsLH+zkserQxzkPCB0gCF8QrbXOcWpHldJGk2YR8Q9Gu7HAKSKtsWvz0t9uXwGY5lvYwMaB5Pk3YorgpI2a1ah02ZMwLBpUO9Mx6IgnHqJnGnTYP3TNtZDIMkSgJk+IS1BBVDS/QmhdtWu9Z5G2hKL2fMuAwbvyDbsdSOALIETjAKN8OuCu/FacJbI0fweBnossXGSpDshfI2+Oh4jF+zrHceAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwFXT6KDZEURL5aHidT1RCirXZJj3G9xkKhQCiQ/SlE=;
 b=M//TkjVpc/YhsE/52u0y/QlKG5LL9x+ky/dlYCaO0mz/cl4+AFYirtG6s/zMAaCPYUJwzMC3CGMxBz6BEhmGUhFgQ0kKOHXIB//wsEF9iNmJ2uneJOvMly70MDg84qvPaMfnRikXY2fl9Y+B2mQ01PIyKKhm52Ghw75qz5johoI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 22:13:37 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3391.015; Thu, 17 Sep 2020
 22:13:37 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)
Date: Thu, 17 Sep 2020 18:13:24 -0400
Message-Id: <20200917221324.520327-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.394.ge197136389
In-Reply-To: <20200917221324.520327-1-luben.tuikov@amd.com>
References: <20200917221324.520327-1-luben.tuikov@amd.com>
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 22:13:36 +0000
X-Mailer: git-send-email 2.28.0.394.ge197136389
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0186b76-af22-4c0d-d464-08d85b56eccd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37700679FAA654A368683642993E0@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAzr9QW5cYpT3eyXVG265Ehx7CuDeQyMtOZycuXdDQlyxVkf1PMy+/d+14docVId0QfTy4NYPvWKqevJugaBAPhj3tXWT5lwYe8MzETLzQ6GKJXaCeYEhRNoaDbttJ3jIfOXkguLCtSWC/LQcSZo0aytOSt6exqzsHUZo+Q9koJdMdPoI01pkevHcFbg2nQ/WsBtR8n7vOKMW81q68wgHXuiEEIEBdKkExPu9BH/O1gaE3Vkpa5z3u0wK1X4+a99rJAhtqhh5nsWViw/xszm1a/mcgOg6BL+nsYTmCZNrTp7lsGbboo3woLSd+Cb5+Ah07b1sRhuiLTZC2wXuyCnHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(8936002)(2906002)(956004)(86362001)(26005)(16526019)(186003)(6486002)(478600001)(36756003)(6916009)(316002)(83380400001)(4326008)(1076003)(44832011)(6666004)(66476007)(5660300002)(54906003)(52116002)(2616005)(66556008)(8676002)(7696005)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gEMvASxFF83vtDRgNAR1C+hgLDvTlQqHNEI2jXcaazobT+aHbBeF/idNxNL9cc/qV41Du2rVbwmHfb9hCS0zPFmk8hiwiKsyAJwhg1JBo/4qaJjKOhABV33Q7WQPnhTTg5SgvZnmDC0FhtEfNz9qDOGCHmsIo3Mi19ePjUUJHGR5HKdI0CS7k67EulJQKVUAqx8Ez0hfS5vWyKJXr1p2Peb8GvQa8HsJVmF3MKAkSeUfsoYPxtGW1cI7lW6/nLQk0MpDhuYs0XYvCuYPrKD6TPwzNI2UYkCxfXMwOwy0Zm0eeExzOIkvv2jO8P36aMjvmJ6qQz1mbEXj2PFKjl8s0kAndIuYuFd9iO7G2CodUPMIL9MxEMpYbQCHU5G3iPfEMcSWyHencjrAIEohGIlrksfCg9Y9lqfqltPx9CrG9R2hBljm17bOTs2xHOxEjUJ6txuaLyqN2HD7/E4I7ckzhUlrkN0m6lS/tp+HLNtWGDPRgUNvcoyuJ+MwtMyFLLnu00YP2jSfPti0EQnAtccQvW+ARYv45pib3YIo26qVXqGnwpDfIDlyqggfr4y4i9GxRjGPTB88WDpnXObZ6PYugE+z49Rk+XEdQDp+98Wj6rT+90czbDR8dIwg0W7CACDeFPpEgS8zCbBk0HarYp0Uaw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0186b76-af22-4c0d-d464-08d85b56eccd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 22:13:37.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+XhtT5Sy3/xzgnfVWcawZF9oXVLHTFwAekkAZp7i7S2Ke/wtMlulKetBI876kvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert to using devm_drm_dev_alloc(),
as drm_dev_init() is going away.

v2: Remove drm_dev_put() since
    a) devres doesn't do refcounting, see
    Documentation/driver-api/driver-model/devres.rst,
    Section 4, paragraph 1; and since
    b) devres acts as garbage collector when
    the DRM device's parent's devres "action" callback
    is called to free the container device (amdgpu_device),
    which embeds the DRM dev.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3f07d1475bd2..8d658d2a16fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1159,25 +1159,20 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
-	if (!adev)
-		return -ENOMEM;
+	adev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*adev), ddev);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
 
 	adev->dev  = &pdev->dev;
 	adev->pdev = pdev;
 	ddev = adev_to_drm(adev);
-	ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
-	if (ret)
-		goto err_free;
-
-	drmm_add_final_kfree(ddev, adev);
 
 	if (!supports_atomic)
 		ddev->driver_features &= ~DRIVER_ATOMIC;
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	ddev->pdev = pdev;
 	pci_set_drvdata(pdev, ddev);
@@ -1205,8 +1200,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 err_pci:
 	pci_disable_device(pdev);
-err_free:
-	drm_dev_put(ddev);
 	return ret;
 }
 
@@ -1223,7 +1216,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	amdgpu_driver_unload_kms(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-	drm_dev_put(dev);
 }
 
 static void
-- 
2.28.0.394.ge197136389

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
