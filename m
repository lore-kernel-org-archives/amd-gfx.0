Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52091C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 21:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D960D10E0B8;
	Wed,  1 Mar 2023 21:11:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB4D10E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 21:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaqXA+DWZPAPG5CHMAZJ06pmf3lT1Rg+KYllXwVpEBm7EPlCO3G7Um8zapGIp2oCj4hWau+zTEjKvrMb/v0oFMUFZaGF/7E1t/LtVFlUZOorNKptMerhmtfYg5zZp3OvD6lDh1mGvSkfi3Y48QPCfeaFDuoJ8I9OpE3ajYfAMy1tvjM/9qMCwPqPSxeUbBgE8kceEKQHCbcaknGu9TnKn3c6xpJhEo6j+KkFCBZKEkt0E6tQyNZIFM6Mybf/Mun4cLK8N1A8r36CFprTxa3MSZPE6Hi2igLtfsdMosTxy/TTHHvXT9o931/976QmaJtOAtYsatuGmfc4Eojbk/81iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzYg/1CCC15SogozNPQ04bs/ksMdFtObfkRA2Nj+Qa4=;
 b=ognPJ9ldHWmrg0b0kr0Xr082VmrLuejpUYdB0RnYEKPN4mFv8DE+6IddhKi85WHW8796HuL334dKuqBVby7y4WKsY6xeKu+BtOUzGvUjzlJEB+gyQnbrdGaEaSiYMSdeMUaBSR83qXlisbwFowcNgGm8/YOW4dDhUf8tcy39TIjqSNrfvtpvINPG6nLnOFOj1GQ0JHQw+5/DS6ucH+S3M3g///Occ040fCxgr/4wzGr2FQF4SEw25e59FMVxOMT0skHZEfPUX1vl1Ow8pLLX0BxlT7A6s82RpXCTQZQp8tcBUCj5+QT59Lk4GTm13I6PwvYkRASuWqAn09EOqsJCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzYg/1CCC15SogozNPQ04bs/ksMdFtObfkRA2Nj+Qa4=;
 b=sA6Mb1QXHFFlYiCUiCG7P20tS9gBfPeOu45nTNp5mX+jXQpSuLrlItXw85x2U6Aa5S2+cW+d65xRrxSGADY9C0/8o1owj8pc8vzxAY04u1gXNku2UoT49gSs95yzWTOVT5Z1S/580gSWpgHKw7vHadBEkJQfW4Hl8zkpGR7SL2E=
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 21:11:19 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4a) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 21:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 21:11:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 15:11:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: skip hdp invalidation for HDP 4.4.2
Date: Wed, 1 Mar 2023 16:10:46 -0500
Message-ID: <20230301211047.2098597-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e07f95-98d8-4c96-9bda-08db1a998053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tQDl+Zh0wFseVW+/PhlKN41/x6TI8vCXRXl7/ahqNY2fhMwse3wprqkk0L+EDsoIXT596tWt6zfsT4gx+rTZbme9tMBFfxj2NG7jf+L9kPMunaZtj8XJ2PNsg0BrjUy/hncDKzBUreGjKKbUXfbl8ELsF1/d5D9RPxgeLIbHwmFBv52jdxChOfrW2yfs6CKkHj4rWRGlNVCzAv5I2VZAhYd/LD67in8DN0cFE2COgFYUZE4JZA4JsEF4u+V5ZPOaAvln/TiWqEg6PG0hM4T1ayR4hWsRX/hK400nDD1c7j8t8WXb10bW/oV1bQy83TCAq2u6sXocZx8LDIjRYSXdDlCMSXlx9E0JhpkFcYmMK0CqYw8ohXdG3bwljrWmgn3jts9CRIU4bJTapah32M7eI5F1Nt35WmaEjuN3mQoANoLWUsLxEWEwzYPh4IAR2uT23b/Z51hmbYF5n8tBKEMz13UcvH228GPgoNeEJX3nDmus5kkblUlneO8RG2MaRTbnReUFkBI0QjCehy2oVORhiIHRLeeducyayCgP9/atDKOapwTc+QKdHfAUHBte+tzGa98mcN4k42SO3/VjN4ghJarDjvXWys3IApYUM7bAdZlImpU1f/pMYhZ6poHbuYoyQK2t6RYSwyLIlwpm2IUQt9y4aSUObPcypQnu/RukSwtqrJjX5Jqkt15Fz0jZa9hnD1H5/RfMCaS8oELfG86p/tgocRA72P11tpnw5gE+5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(86362001)(356005)(4326008)(41300700001)(70206006)(5660300002)(6916009)(8676002)(2906002)(4744005)(40480700001)(82740400003)(8936002)(81166007)(36860700001)(7696005)(478600001)(316002)(54906003)(6666004)(47076005)(70586007)(82310400005)(40460700003)(83380400001)(426003)(26005)(336012)(2616005)(186003)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:11:18.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e07f95-98d8-4c96-9bda-08db1a998053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

No mmHDP_READ_CACHE_INVALIDATE register on HDP 4.4.2.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index adf89680f53e..ee09cf1b8e4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -49,7 +49,8 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
-	if (adev->ip_versions[HDP_HWIP][0] == IP_VERSION(4, 4, 0))
+	if (adev->ip_versions[HDP_HWIP][0] == IP_VERSION(4, 4, 0) ||
+	    adev->ip_versions[HDP_HWIP][0] == IP_VERSION(4, 4, 2))
 		return;
 
 	if (!ring || !ring->funcs->emit_wreg)
-- 
2.39.2

