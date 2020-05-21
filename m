Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC96C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 03:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215BC20678
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 03:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ub1eitNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215BC20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD61E6E8F9;
	Thu, 21 May 2020 03:34:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D539E6E8F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 03:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo3uqW/XHG08WmCHK08jekwHqcRuRJoxUyJg9v1XsSl02uHUPgWNJ14aPofec3CTpZ5zY7uzKWblKpzecvfaeSrRXGkkRgcHSAixWsFgvKqrwujuE0HT6QA1HGo116A/mAIbPZQzitJNyFdq6V9PNt2KhvLXFH3gz348/ABhmT6k8b8zngfY4+EMybt7kqmvB14Z6fFDItFipGk71KIGsCScGx1tmvJLfRbdCImAaavVgKHSHOMJCfL2lpTBogz0n3uvaBxiADJqY+5MhGrac4v5oA3nX0G0h1IWk3hYBeQVevbRsog7uEZam4D+k4nHhRfa6C3P7bq0rC3B4D+Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1JLs9uKUNujPE8CusjsSEuAkbSAxrR+rZr+d3CqDOA=;
 b=UrAHAl6XDBjLftJz8cr4SaDidBDScTuSm7JuQU368PiSWoUomf59R6/4G/6QAJkR7eg8Qool5Yjy7UxxsT0nAuNB/xSTl9I40y2mEF0xBlU0IPkyM0MlGRos/hzjitmd3s24eJ0NlWl9bJuMJPZsHB+RktBhtXglW/5+RjdCqq9aAuwq9WT1U/KG/bkMAkA+nXD038YKu9xTGGPSmbSeJP5N315bvkR9yxknFZeESoyzV15sJs7qSoKpS3ZhaWGLpsnKcgZkiCONKt65G1pwbXLQf3uipuHaJ5wpvpJRIkE0eYELvuQRoYtPr6GB+d1f4boQ3mLCgo/sW4GIElsAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1JLs9uKUNujPE8CusjsSEuAkbSAxrR+rZr+d3CqDOA=;
 b=Ub1eitNN9nTL3yhAAMC+dmdeY1AyOHt9ykHnjmgE5mAEGm2x/NtyicP5NANNjQoSrKxwBa9yJbR6WxEaHdV0NAe4kK103d+2OfISjyC+1w73KyuVVEZwLT8fqo2eORIJM8tomL12F77Cuuxm9XusBSSuIIE9jwpxqNraTKxBGQE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Thu, 21 May 2020 03:34:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Thu, 21 May 2020
 03:34:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: report the real PCI bus number
Date: Thu, 21 May 2020 11:34:14 +0800
Message-Id: <20200521033414.15111-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Thu, 21 May 2020 03:34:55 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b90710e1-3062-4c03-bad5-08d7fd37ee81
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3068537BDE3C4DB1030C370AE4B70@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0I7TC5h0nof8vE9Xp+CV0vXO3YaDYElrTco/j8PaZVTMEOLemW7tUVTKK7YDFjhwIkH/x0AZB6KhgSJaMubf2dFgo//qmNEGpkW+y84Jwbqz/PdvAn40USuS5e07gTr+mLG/sn3Jk7Dc1ZUUkcwp/VFLngWHqd6CY/db33hrbobpfrIWjhUmDo5F06jOuRKBYvN7CSkFGewBd/THXMMR8Xn0M+cvtuSWxr4KCiKnfIuUMyQsDjVcQTbZpSLQYbX58x7jA9KrBbHQzgSg0obYlQpTyUmFRwPaCwvG0Rf/lPu37BZuawTq1LjF0U9oo2ufb55sgNPkHPAw7HmQtX5a+ZNn5roGh3Sr4fBe9dge1BpsHPo02FhqMRYc7uPiecaB9Xc4L0cKWiEy0/8DTh06gElDL3q6/ZBBMUe/vOTORT6+jZXx6MORB+kNVRrBP6Lh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(26005)(8936002)(16526019)(5660300002)(316002)(6486002)(36756003)(66946007)(4744005)(66556008)(66476007)(1076003)(86362001)(478600001)(186003)(4326008)(956004)(2616005)(44832011)(8676002)(6666004)(2906002)(52116002)(7696005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BGyZmaKKT68H974e+iWcCyUai5zbofe2qnTGied5rH0fSaDt4RO+HvtEJwzmEh217fu4edqHC/biJuca7DOTfP4G1Th85Hgg5P/91Whak4/2dczwgtpEzjeXLlsSqeGGlLNhdW/Jh7TF4oxx4N3zjSCkSocyugtYvgoAxOBI3tkeg6AWZ7+3FxKoIJ4OPZKcg33Z89kXfAEuYVG4Kf+d0ownYjfmAqC5+zteIaZ/BEaEu3aumPhbUsDX+uPWe/CTt0a4hy/my8vXEUiu71JLTIbKOV6Pi4pad9qIdY8LwjFx8nesPiviM3zY43r1m4PP/GikszBs+6/py4vvJl4Kbm/RAYQ1XqWDKIFXu2D6/ESY3oXv6ARsrMVHdUrz5F5FriTZRwNaXXelptR7U6Y3dPAcq85yPQgxruikny7KCozbqqYQ/ziW9C749aoaAt9rDDmrgGrzfoE5Dp8nABEZ+SG8PV9mUJZoelh1rOcHrFshfauJsa361uPXtWIvdJB0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90710e1-3062-4c03-bad5-08d7fd37ee81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:34:56.7779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o0EO0eu8BCYsbT3w8GP5tNXCGoOow0dqZDRa1D5dBRDXqLudqAwOS0Sxzo9r7pQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the PCI bus number retrieved by PCI_BUS_NUM(pdev->devfn)
is wrong.

Change-Id: I882a8531a65cdf91be20e34a034aca1f43f658b4
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 8d871514671e..7c8786b9eb0a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -192,7 +192,7 @@ static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
 
 	dev_warn_ratelimited(kfd_device,
 			"Invalid PPR device %x:%x.%x pasid 0x%x address 0x%lX flags 0x%X",
-			PCI_BUS_NUM(pdev->devfn),
+			pdev->bus->number,
 			PCI_SLOT(pdev->devfn),
 			PCI_FUNC(pdev->devfn),
 			pasid,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
