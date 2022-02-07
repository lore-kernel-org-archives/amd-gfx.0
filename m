Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19181C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 02:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9407C10EF7D;
	Mon,  7 Feb 2022 02:42:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF2610EF7D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 02:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2VQ2LKQIhimP8EmAArVX/AFMqj87t9igGbE7b4nhTKW8xB8gZcRK9WBU4kj+hazbbEPIjkLHbZbQo6A1sv275EkUygCL9mzotizf9Ut44f8gp8nubCXqH1+9wPDAVVH2+rmLB11iP9z8O7mBsNaWB1cyhzvWWm7cjWIQG3v/18rJj9YRwCR0GI7Ut7Dmbf9O+rNYYnJdKQKcNr6JevISSv/tEof74QqVYklriDMQDoDo+PNMysmexvdZu+Q3Y8EWqf4BFCWdwg5fYy+vbLJyqTve+mPoDFFrFwRPpCpMU5Mh0rPusNAJLzh174NRfu6NVT5HzzZ5HfmVeMFMowNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaei9y0DqoWkGElNTyoIXKo9oUo3N4+B/o+CyNQjJB8=;
 b=B6W0IcDGyMTyUVHK9+WTzvKIcmX2wxzzfQTHRR8v93eLFqT1CNz/o5glPMidoHwTMAYSjuF1rukJjoOF9h+gZmiGOjpebkYS86d+ttwK5pd522bYLSfYeSk0Osq50E6JTC+c7peez2dUVYSCr4HQgI2+QFiLSmOotuIftXqOdEV6QfraNV7Y5g4tgnP7EdGktdb52nNkraQhT/8hFMadxEqqstvT96/E4zEe0gQ1yf2AvOHPV46FSGiC20za1UuvfDeibxhIHkGyDuuclZ+PDyF8jgCz/KSiyeaSL8PB0NEGjCuilMpfDkT9M3BcrG03zl2x5rhAwg9MWaljMBzXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaei9y0DqoWkGElNTyoIXKo9oUo3N4+B/o+CyNQjJB8=;
 b=Robx9EmQXnrsOww5iJQQrA2oLMk+0w+0xOUC+YkLuHBoom4VaHNBHTMBqLiwU3xqXhgLXjfiBKzm+oZBbuZxITZpORtVIMGUgKrJTkw8I1KNiA47be5dnB+wmxrYRmfID88s7UHxu3chJu7FWLMPikp9FBvqDZg5pzvrM0cRypI=
Received: from MWHPR11CA0037.namprd11.prod.outlook.com (2603:10b6:300:115::23)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 02:42:18 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::1a) by MWHPR11CA0037.outlook.office365.com
 (2603:10b6:300:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 02:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 02:42:17 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Feb
 2022 20:42:14 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: check the GART table before invalidating TLB
Date: Mon, 7 Feb 2022 10:41:55 +0800
Message-ID: <20220207024155.414712-2-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207024155.414712-1-aaron.liu@amd.com>
References: <20220207024155.414712-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78797c69-00f4-44e3-a3e6-08d9e9e374f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB173737B146D4A6153512FEE5F02C9@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLB1EZ6OqA0t99eO62L6MU5EM2o7mYyZSE6s12ZmrxeXd+Vo7YfQ1VhSEfJPqgX226lRKdlp+c+d9uXkFPef8UZw1GhmyNg7nk7Ph5Erc6w92wxxuEs09yi+AfVjF6JZTc7o4+AmvzBskZ6Zt62S3iohGpVbtCVANIb90Bz+h/wgOlPSDk4y/LYmZJ+jAWWhGV9jTBd/IMtiTgjWlBXyGb7/g8RzlKYmtQVQcvyIZdfblr/FZo2blZU8gC3dDk8kAfgU8fyLljqVdmQehVzUAL7fTuJdAz6O5Hvr/rDewySe74oIci9hMVBXuO12MnxkKavhXB2y2yXBm6HbCJUqknU3nR5nQ3Kk8QS2Zu9pMSRnJTuoYgNMIQDSttY++cSdSpiIt5KWcW+/Y3YpJzEFdTtRtPYoMvlaEYcnoZ1tLTGiFEqyBYhRPlA7XBe4JNnWkWlGN/HKIMFugJS3ANvrVtgEfuFNS/E1T//f78rlzoFiDONQTNHxAqbNywaAx4Djbn9WdnEpVuwuu8ZcGcM011I2B2N9MXJAlfZ2Z0hXacziANO5D6dw0IOYmiO2i7ypJj+p8oQpMVmetPdBo9HyLCwPVGLggBZpnC3Uo6rZ5Mv+WXZFnVg3/+TO19Omvuo37+hIxQ0t8caF/v4Rr+YR8s4HpG8Qa0pHzAKfwwELjEHgLwH69n9k45fGZ33sQUb6gcPSo+zgB2w74Qvxr0Mba5OCg82b/cTVm0+sV88MT23TXriJgv6Kj6aL6oYGpcbo+CapAdOS0tf2hASDRvI6ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(47076005)(82310400004)(86362001)(7696005)(83380400001)(426003)(36756003)(336012)(6666004)(8936002)(4326008)(70206006)(8676002)(40460700003)(5660300002)(186003)(81166007)(1076003)(16526019)(2616005)(36860700001)(2906002)(44832011)(6916009)(54906003)(316002)(356005)(508600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 02:42:17.6602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78797c69-00f4-44e3-a3e6-08d9e9e374f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, Ray.Huang@amd.com,
 christian.koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bypass group programming (utcl2_harvest) aims to forbid UTCL2 to send
invalidation command to harvested SE/SA. Once invalidation command comes
into harvested SE/SA, SE/SA has no response and system hang.

This patch is to add checking if the GART table is already allocated before
invalidating TLB. The new procedure is as following:
1. Calling amdgpu_gtt_mgr_init() in amdgpu_ttm_init(). After this step GTT
   BOs can be allocated, but GART mappings are still ignored.
2. Calling amdgpu_gart_table_vram_alloc() from the GMC code. This allocates
   the GART backing store.
3. Initializing the hardware, and programming the backing store into VMID0
   for all VMHUBs.
4. Calling amdgpu_gtt_mgr_recover() to make sure the table is updated with
   the GTT allocations done before it was allocated.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 91d8207336c1..01cb89ffbd56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -259,6 +259,9 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 {
 	int i;
 
+	if (!adev->gart.ptr)
+		return;
+
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
 	for (i = 0; i < adev->num_vmhubs; i++)
-- 
2.25.1

