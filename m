Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6896C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 13:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9FA20B1F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p16AWvXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9FA20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570C96E161;
	Tue, 16 Jun 2020 13:28:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22E46E161
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 13:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdX9R5lCZFNVexZTUavlukQfkc3+1dSYCaz5x+jFc5uH49ln26i3CHs7Cffm/7blnROfiNQ2/8c6PULTMEWB7DUK0jo4EYVuR6j/5wHVGbD1RG59rJM8rp9o7Byy95nkQut9s3t6XeAuHzI3AP2zXImcYh/qhCdCbfleAxEOQaJrJx8EcvxOhPYvLRyox5ukpwTgHPz2iK+ZtxxFgzDK7WVYEDnOKS5QjoVVbV8XEL8LqZQ4RFQBt+BsY1dVmVVQapdQe4IulB9vV0g1S8FczihVrNo1cLJ4c3sycuDmK7MUHps9RKup3Nqf5cfCE0xeHcFg8Liug1wdzecRAfzx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm8BpnoY7RgIug9xxXauAeT1SoXqBg+cV3+OLCAAOGw=;
 b=erRZ1kQNQgeo/KaXG50daKPjCvpMsaP1CQo9YCwNbjWBjE9Fc9/Mb/vvyvzj8EiEWtL0KKf4LakgZmNZImZD6yMuzW+C6Lz9PXYMTSf+bpUYaCVoYnHNF9KRg72B9R4cEiMbhYWOaigHH2s2zUM7Kh0PPw3BeH5QBPAI6S0/MBGCVq+e/lkulxw0kIyE9ZaYI1mIdc5oc4y0fWing67hARBN+gWU5Nqc9xG3z5ZnH5ao73uwp/MccwX9zXZ00rBxXcc0VykS9f2+Jf4MPX9wBpJSoQvYKw2ue1OCVMYuEB6mP3xARlVXZN0VaC85fXXGTisQDqfnauNiEe9954Cd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm8BpnoY7RgIug9xxXauAeT1SoXqBg+cV3+OLCAAOGw=;
 b=p16AWvXqyPlQp5Qock/Li3DLh5VSjfWmNK+1ff2ViHHt+tEL+eVZh4MoOVJM0cnOoA/RDP7nXy7UVftIAygaOFrXYcYfhBnvz7KGqVQYERkDx+fvdZtMxwhKkhlkEiw4cEJ8RGH34vYIl4dhbW90lvFQ5+N0FM6EKHPuXnPqvDk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3450.namprd12.prod.outlook.com (2603:10b6:5:116::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 13:28:48 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 13:28:48 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix offset for SQ_DEBUG_STS_GLOBAL on gfx10
Date: Tue, 16 Jun 2020 09:28:39 -0400
Message-Id: <20200616132839.2338756-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:404:13f::19) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR14CA0033.namprd14.prod.outlook.com (2603:10b6:404:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Tue, 16 Jun 2020 13:28:47 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80961379-2bfa-4cc7-3441-08d811f9337f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3450D47A90107FB9B9026AB2F79D0@DM6PR12MB3450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQ4MVJwnyz48rzLCZhAqP05SMhNl/ZtB9qWr7NXHLbo0C2qBKbW9KWASpiMWWBL2dUrm22Lj0844sF8iOW84MyrC+ytbvP0zW5LiiwGWmXCDNt+bqy3C7S4b7OEf7L9rDHfmTDmnt4y3ZyWJqYJhoOfE7EZDEuzgRO3W73Z4QDu+BqhlJY5ygqLGVQUrtKD3v8t2ITMcRZh1TiQuLXf5btzcgpOQqbi8SNmObOWFvzOtMix7ZtaW3fIDwvLk3im2hUoVDTntvEYlWy0cy+v8eI7bwwSZoYrFHBXg35B0SGVsuqZKMXvULb7rlQr10Rrdh0+zliqwpsv7t57giSBGdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(316002)(8676002)(186003)(956004)(83380400001)(16526019)(2616005)(4326008)(6916009)(5660300002)(36756003)(26005)(6666004)(478600001)(52116002)(7696005)(1076003)(66476007)(86362001)(6486002)(66946007)(2906002)(8936002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1LwvgjaBgn1thty2Cj0mqR7QceS2mU0Un5VGd0HNNKMB2YXF6gEJN3dUSX1fKRaNa8XCgtQ5CvsbzvU1He2+L44aiZh+ypsVjVcUqTkPdF8PU8UJuAC+SPjztI/+qkyUkjL6qiEFSvnE5ZQYHtVmwnSxwck2+uF5psKMi3c/XABXWDLQkm0fC7/Sn3ttUTeVDCUiEEdd1lfmjEddAWXlrlLCCdtNWVtKH3dzWkT0+PrcGUKoQ0+evjMlbEHVdtTmEgCSCr8b7EchsY9hQ6bbZu61j/dH1zxL2aD2+1ojlfM909NyVlKn6mVXOzPSwX3S+ZW8eXTtBLetIcMqy0BlQh7MpM8wHtYlru/V/r8gLpXuukDCGKUat2WbetDy0780GL0yxRWy5UtPUr2g3Lg2VXRBLgcqVMfffWzfVC4eD3J3tv8uggo+5CSZtDLlltMqUz4Qs0IkCerDh79gJyDkz7o8Vpm+ONel/cNauH7hbkw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80961379-2bfa-4cc7-3441-08d811f9337f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 13:28:48.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkrCgDRyoASqmbEowainhBgqDs54WGzUQjIMivaZE03+u6A+/8MXdsLmrbx+1+wYRR3us2GxDXW9/Ir7ggd/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3450
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Despite having different IP offsets the computed address of the register(s)
are the same between gfx7..gfx10.  This patch fixes the offset relative
to the GC block on gfx10.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h | 4 ++--
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index baac40fa70e7..c737d90a8d31 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -21,9 +21,9 @@
 #ifndef _gc_10_1_0_OFFSET_HEADER
 #define _gc_10_1_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x10A9
 #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10AA
 #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
 
 // addressBlock: gc_sdma0_sdma0dec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 0bde3b4e9567..09ad21dc2d8c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -22,9 +22,9 @@
 #ifndef _gc_10_3_0_OFFSET_HEADER
 #define _gc_10_3_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x10A9
 #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10AA
 #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
 
 // addressBlock: gc_sdma0_sdma0dec
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
