Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD77C6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 07:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF59310E579;
	Thu, 22 Sep 2022 07:11:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C6810E579
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 07:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8KFU8hlvHjW5hbYhSS1BLGzL6fH2+2xLISEa6xAUvIje9bghsI74SoMmTkhh8lLBXyRWWzia0YHPr5pmiVFz2r2UkMKcJYw4DiUAcyzlYJFW/ObyJSbwzvMNyirvAdmXNHjNJhF+5L6JbYceJZuElhrbJHi/1JoIAxWzO0LCcSrvOAdQERTSjfUbIFeN07ZpR5pP/bv8651i6geP2M1AAS6pIDp8oa1aSlKJg7OeOyQc2Gw0VmgGKqari+VW9fNvU4o/YKqjD/+LEejp0Sn8t2o/eOP1SL6A243JYYK3QPjSrw+C7Lcm9pwZKBp6PI3tQSynsRUsIBAr6i/4g22wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NttDAB3ngpxH7TxySJ4vxs9vUTMAHrwW8ME1LL8LMLg=;
 b=a9fu7Nuj5ePuzo4N/XJq05moTDqeBbVl7WhYtgux+Svf321bMizbX/31WktW3/6PS9BAnPSDKZf1K0KhpLCnaARwNt9cefyWU732HIote7IB6UB8+e99IdkJ0eK1/q8ibCw6w83ePPGk41Zbxv4IjSt5Hf8CcQ6CBkXoRJFJSGFJ4bg/4svtXUvj33GjGnuszVLoHtvT8D2o/JDwIutE7rX8LnTQzOZ45t9fqG7IeooTH8n6jWJswCx3dcQNdJdeCgei3OVWSs7THUi45e8S7nN9MwXACdqaDw2RfpWE93wNoDRlwtcQaGdw8tOVNfVJOe35JI455Bwhbm989dG5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NttDAB3ngpxH7TxySJ4vxs9vUTMAHrwW8ME1LL8LMLg=;
 b=5FqqLpkDMPGD8mfQcB5EeH32Fre6EkolkbX8diMAA1WuP9b7EOj/8nkdI/E6+3LvfV7LmyrTVMKwhMYPv873Dv75/9aAMmiKUbhPikxcssltRp2PK4r8HnASasqFQsu//deriEsrK0BDvVhxuIEJh8CCHqRJ+UxFObBwTS3Iq+g=
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 07:11:52 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::2) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 07:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 07:11:51 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 02:11:49 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous pages
 under xen dom0
Date: Thu, 22 Sep 2022 15:11:33 +0800
Message-ID: <20220922071133.927436-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: d30efe45-5c9f-41c8-4df0-08da9c69b8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqCwP3PKn+0sJYqLrtlc4FhIsSXDRmHouFszWmpsCIGCaQ71f30KLr2NDKyef0dsLMt0KqOd3cYJuAE4ZL0TmFYpUuEdiUtMDwINoJoBaLOAqZcgiPdAnrxFlSAqCXng8iT8a3ZNU7JJiG/xQghiICTjYqSVK03ImGmR+X9QElvdDFxMd6gpFWYyRrF+v2wmG35xj0icNcRgKZhLyzCD1u88BFjtKfXSQ4TiL0xVWqGeVTBI0jVm3DwcPppD7R35q/zTrd2VLseYb9GwR32ZGgeVB23NTK9k1XlNrRpHTsSJN+aNWgCcM6/8KMJmS63SWaZ4aX9xcRgE9IMfYz21NCpNgJ6f+JDz8/8Ef7txbiTafZgSv9AfAU1jPrmg/m6ck0ggt54npFCVAw/QlgqDDgcdWXX9wuSJhW2SFYxeQTc71eMLhOJ/RcJJg2/02Vp/lOKly39NgQmEcGV9XuLGNg1SeoKns28PDPRnbdF/mlOvcvkiuGcJKAZNoqjvGxtas/0yiKJ4Yx4qb7bemd2MshHy3vdmIreBWXDh81kH/gnp/0fkOLUZki8l4b93imn++wiqpbaGW0eNLEbDENhKVxYCtPi5WHrUviSyPIVcIpPF+f846fwJ+oIrZ3NZtfsfJy6AhtGcWmx5Eg5ewE8cdYR0i+Kh3eE51A2wsPQSDUZVduUy3Ql+Ah3+AjMumHd3CCGWzcc07lexHZ4bkr7J4TFGdchjR5TJ39sEb/oWb3HlYCyNp0+f23wrNTzKiPDaF1lS/8l/nZjKd0cFLY0wHuxcu8h6Y6ELtu/XbK3+8kYIYe7KWoUqfeozvXMaRzbT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(6666004)(70206006)(70586007)(26005)(7696005)(82310400005)(40480700001)(8676002)(4326008)(6916009)(36860700001)(8936002)(86362001)(81166007)(16526019)(336012)(186003)(2616005)(2906002)(478600001)(36756003)(41300700001)(82740400003)(44832011)(316002)(1076003)(40460700003)(356005)(5660300002)(47076005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 07:11:51.1431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30efe45-5c9f-41c8-4df0-08da9c69b8e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Shane Xiao <shane.xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
sg_alloc_table_from_pages alloc too large continuous PFN pages under xen dom0.
However, xen should check continuous MFN pages in range_straddles_page_boundary.
When range_straddles_page_boundary return false, some cases fall back into
swiotlb process and the continuous allocable page is not enough.

[How]
In fact, xen swiotlb set max_segment default value as UINT_MAX and
xen_swiotlb_init_early already change the value to PAGE_SIZE under xen dom0.
However amdgpu driver doesn't use the value, which may cause issue such
as swiotlb buffer full. Add amd_sg_segment_size according to iommu setting,
the details are as follows:
	iommu setting		|	amd_sg_segment_size
-------------------------------------------------------------------------------
	iommu=on		|	UINT_MAX
    iommu=off && swiotlb on	|	IO_TLB_DEFAULT_SIZE(64M)
	xen_swiotlb on		|	PAGE_SIZE(4K)
-------------------------------------------------------------------------------

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 134575a3893c..d081fcd22d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -80,6 +80,23 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
 				  false, size_in_page);
 }
 
+static inline unsigned int amdgpu_sg_segment_size(void)
+{
+	unsigned int size = swiotlb_max_segment();
+
+	/* size=0 when amd iommu enabled */
+	if (size == 0)
+		size = UINT_MAX;
+
+	size = rounddown(size, PAGE_SIZE);
+	/* swiotlb_max_segment_size can return 1 byte when it means one page. */
+	if (size < PAGE_SIZE)
+		size = PAGE_SIZE;
+
+	return size;
+}
+
+
 /**
  * amdgpu_evict_flags - Compute placement flags
  *
@@ -760,9 +777,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	int r;
 
 	/* Allocate an SG array and squash pages into it */
-	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
-				      (u64)ttm->num_pages << PAGE_SHIFT,
+	r = sg_alloc_table_from_pages_segment(ttm->sg, ttm->pages, ttm->num_pages, 0,
+				      (u64)ttm->num_pages << PAGE_SHIFT, amdgpu_sg_segment_size(),
 				      GFP_KERNEL);
+
 	if (r)
 		goto release_sg;
 
-- 
2.25.1

