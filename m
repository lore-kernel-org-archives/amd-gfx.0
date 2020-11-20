Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD85C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 16:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB91122253
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u/FEvYPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB91122253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012EC6E932;
	Fri, 20 Nov 2020 16:04:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FB789EAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 16:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnJ/JiJZJu3qkjZj62ALY63TIPmKZyDhQpPtVAN12ZtDGMluv5HZlHw16IVNbKi+8oyOi444E0V6AkSmc6Ya3sKNvzLWfuJ5zzbTu+HZ79cJPAWquu45ieEsrFK5Z7vqOCJJDM3HF1Lh4FOCdEPHN4p3Vg6+wfiKAPtdSS//ecUvEFhQlxpzzIM18npzRmGnMiAPZYKY2gfbQXW/StmAeA573HH3TzNDe7t8GzcOCb8xyav3163nWDXSqe7G7NJwX4lMKWpsmoOgVYEQfjD+yocHw/4GUgHcpolck1wxdEYixWi9WyQLi9GwtVpxtqXm/ToR1c/IvrtJA0034zEQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81YFH3cRsM+sbCUsPGrIxQlNdIAIEwOcj9enFCfmFeI=;
 b=L+0AC2zo2/4QyJ+sUUm15Jy6IXrW3aJTemPyYN7eQVOL6zWgpKA7wa98JrD1wFGp0XpyZuwx3Nexspp+bJt6pb83uqtfi51rfqlov5kYIL0lz2hUZJ9MxkT78+8faHl9K2AP9J0UmFn5832MKgAW1pAqbkFHA637fnss5coOPT5wuWvPQkMh6tR59Wl7PXwKreDPH6RhYn703Kx/g++NZ1dadB9eSId1MNkmkPG/n8VUPjXHLvdTGOcDV9qD8zBiuSRvLJKnZREW4AlclnyifFNR9SX6OCS+E7YeWVPV4ZvoIOCD5UYz49/pdMyjgRMI3gN86gKZSpkrF1UTtjFP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81YFH3cRsM+sbCUsPGrIxQlNdIAIEwOcj9enFCfmFeI=;
 b=u/FEvYPAXF+rXHZ//CN8PLNXf+Ag6I1aVX0uxjTgMz46mM9WB1EEWKP7QNX+l0RN1uUS/pZiaNLJiYDFjy7NHQMi92yLsYmRPVY9IgxPoNQGtDKlawiTdr2IXGa3xGTs8DyaVakuIafOC88CNijEQoSoHEgwAbsazvtqwP7M4P8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Fri, 20 Nov
 2020 16:04:37 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3589.021; Fri, 20 Nov 2020
 16:04:37 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use generic DMA API
Date: Fri, 20 Nov 2020 17:04:11 +0100
Message-Id: <20201120160412.48148-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [217.86.122.114]
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.114) by
 FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.13 via Frontend Transport; Fri, 20 Nov 2020 16:04:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a7a9417-006c-4846-ff67-08d88d6dfac9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2454B3BF419B5048447549858BFF0@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ARmz6p64ri26iYPoD4WfjMZKbk/7hPwCMJsySpfhwnsb/fUmjLtAu/IYeIfkYQL0OKZ/3WGiaGFiZOcesp5qDS2FtjSqj3f/ZlscCbz1fnLFYLSxkSe7kO5Wdxii0TaQRjJcPMAVbVB8IjOYJClqMpJwuy3zUDnNejRfIEMMytmK4FnARgMiT7AFUEeidxg7S0cE/r/FQWpoZL2Zpwb5D6Vdyro7UMS9Otlf4xEGBivKW932wpeKWnzMdG6DRyJ296Q89Q6+T7IDnoGV7wZVYmpdqeHazqnmSFvrkV6KkgBck+81oiacNHgNnUm2f6yV4k0Buarb1sE7yo816G+zhdCxUoqMCY7Hm0e1XUF0+WzcUf6q6zRnw1WgXgCnM+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(66946007)(26005)(186003)(6916009)(6512007)(16526019)(66476007)(52116002)(6486002)(6666004)(1076003)(4326008)(83380400001)(8936002)(6506007)(8676002)(66556008)(956004)(36756003)(86362001)(2906002)(478600001)(44832011)(5660300002)(316002)(4744005)(2616005)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 627Wzq+MQuQunvpoAUB0y3SgNcXA30ZenSU+Ye4sGpbB//FOUK6vQD+yEstbtX6haEJySMehN1xHMswPe0B3OWgEcGgibZWJJ7l2ECeznoLp1Y+T/qQPVjM1//mlcmNuNCFakRtDmORznyiAS+WocR9wEAzDp4MT1CjozLQf2Fp0v8jgZMEpqZti0MPAMdWFAc46lwbIhAskecVvUmHWK/HZ6p2439QNP2QfkALM+OIN8S8/tkNnWizCFf7zLS8zVoNOyX6w6mRoIRmsaiDdsgl2DAEJE+m8QxW3j2eo/K81IpFPpRXyICBFQqtM5bIVMg0pJpX4JZMvc4ym1dFdhdGJX+P7AnejkoX0xc5IhSaEv9PjJgPEgs2w3yjkd3IwFsEpPLD/QKYpWPioQrR1+nF/K9dox8sZB16qwfXp/mRjY57bg1ZK8YBp3qBfmf/TSc1EY/QObkQjOPBKzNsq8zmR3YPMkVkNluCf1ZkmBF9E8reeCobtn76b/TRcq5WLqvZsBrJtZqtJ2FmpescqeEMjd76TRgno4e1ELgZn5oqT+N7UHxd4k3PEQ/73lH2Ji0uyryufnQHTwyVf5+6+gQhbzOC6IzR0khHSMkL7VYOFCX+3gF86ihdNrkT59vsERDdI6cOYZFf0Ks9XfIKSH3bTs0r7atJvLgCEj7KNe2fGaA34PML9bnrifrEyqwDgVJKR4Hha/SEe4Hhlpf9iU0M6jAWydUf9awkQ54v6x98VRP4NHtkQmZGCG7O+KBdI9bN3fR1oM9wR3gmklZDTufIDjZsfoXG2nlNICxYFeReeGXSLHtMZu+PMsHKjtmh8ShXjDkvk0JRH/12R+nOa4YozaJoo4Jv9QSjdGdcic6YXAkrGRFIakI4sYUt273xFdSxZg7S3CLwG6am5IARgHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7a9417-006c-4846-ff67-08d88d6dfac9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 16:04:37.4157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7RqdO38syrMocP+U1Ib6NoLJt4W8HIAr6B8p7hlG0i9ePt9ECANzhBr7ByDj2HKb/H01AngyynJM2p3p1wFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use generic DMA api instead of bus-specific API.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index e01e681d2a60..0db933026722 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -75,9 +75,9 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 
 	if (adev->dummy_page_addr)
 		return 0;
-	adev->dummy_page_addr = pci_map_page(adev->pdev, dummy_page, 0,
+	adev->dummy_page_addr = dma_map_page(&adev->pdev->dev, dummy_page, 0,
 					     PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-	if (pci_dma_mapping_error(adev->pdev, adev->dummy_page_addr)) {
+	if (dma_mapping_error(&adev->pdev->dev, adev->dummy_page_addr)) {
 		dev_err(&adev->pdev->dev, "Failed to DMA MAP the dummy page\n");
 		adev->dummy_page_addr = 0;
 		return -ENOMEM;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
