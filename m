Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D55C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE24C22269
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2kHwY/XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE24C22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB6F6E8BC;
	Fri, 20 Nov 2020 15:41:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA266E8BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 15:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRu8PfR9KvSYqu40hbZ7nEq9RwxJTS99Ht7T3R0ztMeAkFHNpjOEAW0iqQR9p1Rm79E57zLQYcWxRPitYqqjR9sIEeMynUWQY80ZPVROU5hrDOfuI7d1gD0GyucRvrnfBthVHIaSlG2W7YAVxLq8tO+pse4GbB/kP84OLG615FFY5A9ccY1YSOlvsC8hbMOLveV3EJwF1pAHM/zVxSVShnLT/VQCNUf5YFLpDEXSYbdO0q9UwRhwCcqPSks+1ciJ+e7BS8NBNZtMmvwYNOoFI46nPtLVnOoWqoL+MLLsaNN3e6uIP1VQNtQEhH8YKOkGavgU4Uw2d2o2Q59hXKLezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhgBQPuhdt8bhVCKvnJEad/G86p6I/b7YFCckV4FQEk=;
 b=H3Mb0G+4NSjDgepuVKU0vyUt7rrKbDEPwkblnkyL4PanBTs/V+0xFyFRJ3ggM9mTC+Xr2oUt92MyHkNkegNMEU9vYZoB4QcJ+hqqQ1fuq1SPy2ZgxlV8K36geBIGLK4ApEkgjfDevbkN8uPg9+q8x66VkFfYefFG6de/sH6y4fj2qWtnBjNs9pvD87vUqpkAPuLm3M6upeIe4RxTue9XY+HYP7qujGlRxogMzUaNWHzK+/4d8VlwVf9TDn8Pv2anjwC8cjeQ38ZbIXrUKVlkL+TuvjMU7ht5Nf39QhVkqb3LoXiu7x7nb+FFjuQ9FjjI5yNTDtZgLw12Ns6V+Ro53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhgBQPuhdt8bhVCKvnJEad/G86p6I/b7YFCckV4FQEk=;
 b=2kHwY/XDNeSaJ7PvAiqBaHlcsGyMGCqKmPH4hxGf1QLJiuw5QSPRLBc6TVzaeTn6BxcN5uvnfLwDD9hu+2hwyBWnCpzWyI3kIl9qfxFy9TE47U4Sx0ZjwIDWXqPnCvYcYL0USm6ac6aEk1waAzScllEOg+50nT89cZsbo0bXpbk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 15:41:22 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3589.021; Fri, 20 Nov 2020
 15:41:21 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: use generic DMA API
Date: Fri, 20 Nov 2020 16:41:04 +0100
Message-Id: <20201120154104.37432-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [217.86.122.114]
X-ClientProxiedBy: AM9P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::20) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.114) by
 AM9P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 15:41:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b522f07-2544-45f6-a2a9-08d88d6abada
X-MS-TrafficTypeDiagnostic: DM6PR12MB4975:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4975C07D5AE2921627CC4A388BFF0@DM6PR12MB4975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h92LRVF0N+O/2ToGW6gzQ2SLmEgtJWbc0WKSwPu6673OrOS3KPu6hM50TiuGSj0pG/6wSfPYmY1ZjPi3Lrih4om2KB7ClsNlitlETR+p2twHLsuXC8t5NHffM/wKIk4FcKWvGjX2ayqLqYfMsdmb/mHx7zq970ZDseb5I4vZSHwIrjEgWnxsuStqibLaS8gFlHeryzGLMuS8K1+2eePI5hORow2rwfhQRxWsBD3wjDNHtYTMHXOrecTEpPbl6Ow+HvW29KK2aUbxQutKawiRr0TocGx00D/xtkzm0vwr4oDs6XdvaCa+C673sXxlw6tNUFunFdtP9luxpebVrBypxAIOQ+GXnI7/kpkAKwWqjnNkpsI8rf1CnRobBzrQUyxW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(6916009)(186003)(36756003)(16526019)(4744005)(8676002)(956004)(52116002)(26005)(6512007)(4326008)(5660300002)(6506007)(6666004)(478600001)(2616005)(66556008)(83380400001)(8936002)(2906002)(1076003)(66476007)(44832011)(316002)(86362001)(66946007)(6486002)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fwPg/ctSIFYMijsO3Bb2Pr3T0dBU+FkPM10PcxRDrEvdRFrP6wZba7DaTS5p23dHj+FTmbf1EcPt4MpwrufF8o0SyeWWi3IDYk/JBiDz+3V+MPv7icWpQzCdgoGu0h8gfZatrI7CfA+r6dqgFs0IUfvfk7UekFUQlFMORFcu/qyB/aL0WZ836uYsDFJPkVLQOr3kD7K42iAIXg8RXjVonLC2qhhfi2HEYCHAzIeW2ARbgxg3ZX0iAd7rHrzIWQ96c7+Z/1Hh4AcB5awHx9jzMw9kaYhFGz9L19KIvR0aillMy2iENO+jw8QDJkBbAJsGq1Hp5N7EbcdtEnp7WaoC1ByMSjwSt6aXT6cx03dQT/3sHVc+hF4Uwifps/4lKoVPZQn1cHSSlX9A3upEOsxLsnd6kbjuXc+FSipusOwHiFfEuP3qRulVB+aymah3JWkIpCb+M/HvkcvCzwAGgKlg5LgzkSCfTYDUCix17pKlDSn+vNPstohAYg9kdjgo1z4BtIhSbYCLbxa3CTShhq1DXaQPvfXvlHdKqbC/zkB9AUD10I40rA9ALMPc5kegeFXFSVELyw3KbYql+0qudKw/T48K/+NWrxtDketWEReD4gspXggWI5YDngZyofyITVsa5Phk15/nL00pk7vpd1yJROjHeZjxK0gi4g5gRz4UGe7KQ1qddHY2Tv57dVBbAFlp8DsSQYXlhIVhetdl+apdLDLsZMPLNonsSo3/lIBaRj32nYuLH7C1vAOUj4nGP2/mizynztiIsZYN1QPbHhnCyecq43P1WrXn+MWeipNeBwMohAUiuWU3/wiXyxaQopNp17A2wxGJvLTQeDheZkmqbweB4kka9tFJrRjQLN5KiXeq8Zpb7twzMzoqdIsCskmSEtvHFNKg9ch6L2fwxKIDeg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b522f07-2544-45f6-a2a9-08d88d6abada
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 15:41:21.7183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niIVAymVDHzyGzy+FwyilHGAjDSjJ7viM+bd4C5VABFwrdX0hSLtEazxRqCDjhpH+HaB5fh7sivQSBnss6dNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index e01e681d2a60..ea55d66b3ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -75,7 +75,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 
 	if (adev->dummy_page_addr)
 		return 0;
-	adev->dummy_page_addr = pci_map_page(adev->pdev, dummy_page, 0,
+	adev->dummy_page_addr = dma_map_page(&adev->pdev->dev, dummy_page, 0,
 					     PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
 	if (pci_dma_mapping_error(adev->pdev, adev->dummy_page_addr)) {
 		dev_err(&adev->pdev->dev, "Failed to DMA MAP the dummy page\n");
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
