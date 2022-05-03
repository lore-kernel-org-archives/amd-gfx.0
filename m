Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7AEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F63B10E46F;
	Tue,  3 May 2022 20:43:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB4410E46F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkRVDXSS3dmApVyzoFoj4dBcu/gtovWCJnQ3rIMzwNvtr51xBrVO0xwLqhToaB8nuoIDyAUtxxtMw0W6JAToQd5SACGQyBULPrXupkJLb+IkmZmBpkd3ffh1F/s87EF+SWh3zJKluooewxq0njlSuNHHy6iOlZRCSIEjGYnV0eCsLJ6PqEPYQJE/ZZpdRU403MO3OOt781C/FmH/ObuHjINq5v1dxHixed9RR7wXbKPnUgms8zWd5AhxXImqU7GoGGEvwiTslWdmZPSXJWbABWMWlX12fo3Gix97OJhQMAGrQasa7/+giZsWIWuEGC7gIMpI5MZDBzA6ZxVsc7J5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpkNKVECDf/tZBlq9q1Bsv3J8ZssDgE3jtBTBdkHkqg=;
 b=iN0LZt0Vh1MPlfZH51i2xKYe83cxoZjhPxn+cQgbyVvvi2w94tFliJ3tSKEDLFM77QWOnjBEf1qg+LdX/eyovwx4V/SkBJUw1u4w5B627xKsKpOPJre2oRAxErc5EqRw5tkZXnq+osHOqtUDdQcCgNY+YNGde/lQHY3cBgK8bm8kONFQMFgRT/oPwpyXvQQGzm4ELFDwxNZtrtb+EoqCCx6q2B0lZ2rgsjm+5rx7YIhBdBefW4Lq7fNEmiyXHe80xPN4FAyqOcxNfy3i9j82lBCVovWQSj5A+mK5d2v06/zWvVEvgBaT8RSvBARddFwldq/leEeN/vSRu7Cd1Ftbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpkNKVECDf/tZBlq9q1Bsv3J8ZssDgE3jtBTBdkHkqg=;
 b=SaD6QbtwC0L26hFq6jXwHdM8cFhLGYpwWJJuB8RNeNYGdg4YCX9bQ/Zk1WUxS/wfu0ShAmCR6myyFaqzlel/ophe9SpMCI42xZJUOviB+DwpBcfL0008FidM4fvG9JnvYF0JL4gsxxohivit9UDsuQ9rbc3b53Db6TegkzsCE4A=
Received: from BN9PR03CA0492.namprd03.prod.outlook.com (2603:10b6:408:130::17)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:43:36 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::8d) by BN9PR03CA0492.outlook.office365.com
 (2603:10b6:408:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:43:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:43:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: add pcie port function helpers for SOC21
Date: Tue, 3 May 2022 16:43:12 -0400
Message-ID: <20220503204314.1250729-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503204314.1250729-1-alexander.deucher@amd.com>
References: <20220503204314.1250729-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c436a5c5-04a1-4ebf-13d5-08da2d4598be
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3260523A42AD33691E024F57F7C09@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZN7K6HSlv1QOYCwrpmQj6cdeBJUHQwyQWkuygyVqLWNtdA4LEUUbiJvqoHJtQP3GhrikZlVzZyl/1WbEuyruFT4UZDr3y4aqEmQxqzLa/IS8KtOBuA1Dkrft3jINAqF3rESj8ewuH/C0cFTA++wRHhCn9grIotrFINFGf83h3m7chvFgbIHRvfG2XRMGE1rU1c8xk5gvjltYQ+3nqHUauSXwG33znDS6QDDeFqMDoQOeKVTG2WO736b9dn5Acqu23w7B54+BSqiCrNBpVcK18lBUQbUEpiM9VYE/RO8QFLoQJRSjOi47vSYuOSTiwlTnDjl09noX799moW6uVVEqY34V8W5vgmXl6eFJ2jK9Fgo4Zmx57T6f2QF2mESMRyrn36VjXuFGglKUAZ54hcALwl36yw4dwMQiWGaUnJoTYWnf9/KYawKgrCfWhAqZnmcQQt7OIzJahDlVk/FL6z8HSEN7IHR7oYTj9xCVtG6qYyzpedWlkfBwz1wSzv8F3L8767ohTYqF2ye5vUH03JEIQJzQkBqb2r16fGkaqNBbjJ4X8fsjlUx7+Z02L4jgChDRs/gJhDsBI1bzGdnDi/1TCr108T6qlsVeBIX9yASBcyeQ0JmkJGvI57cGJLUmJOlhyC9+y7G2jdMi/11Ra1tszm1TylDZ9pVQmKNmY5FjwyZ4/IbTQrzvC2sJzskpMtUDOnx+4JHP1gfqqzKRCgnLZT8rRJAsEg1X5ix2NIlNw15daqsaMCnaZ7AmbIKEN+DL1qAn+Og3zLt55B3UmGgcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(4744005)(82310400005)(186003)(16526019)(26005)(2616005)(5660300002)(2906002)(47076005)(6666004)(336012)(7696005)(426003)(316002)(81166007)(36860700001)(6916009)(54906003)(40460700003)(508600001)(8936002)(36756003)(4326008)(8676002)(356005)(70206006)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:43:36.4308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c436a5c5-04a1-4ebf-13d5-08da2d4598be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

These helpers will be used on NBIO v7.7.0.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 29acc5573f56..9424020c0634 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -511,6 +511,8 @@ static int soc21_common_early_init(void *handle)
 	adev->pcie_wreg = &soc21_pcie_wreg;
 	adev->pcie_rreg64 = &soc21_pcie_rreg64;
 	adev->pcie_wreg64 = &soc21_pcie_wreg64;
+	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
+	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
 	/* TODO: will add them during VCN v2 implementation */
 	adev->uvd_ctx_rreg = NULL;
-- 
2.35.1

