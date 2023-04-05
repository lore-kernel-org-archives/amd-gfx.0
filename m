Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B04C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 09:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A99A10E31B;
	Wed,  5 Apr 2023 09:46:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99A410E31B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 09:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLzG/7j+EBpoH6BwJ/9yW2gaaGSYeTfAh2Xshsaf3gQrkOW1EmVTr0goovGNy5ure3Dx2B7fdnsxXW62pAfTKNYhd/SGld5KTCfQyCC3yPA3+eE2U4cwjuQ/Aoaz8M2sLGiFKzqXMwIKq5mZoqZcUKhYOWbjS4La9Ene4gekI3szFoz4PotyPH5oV6Bt1gssltSzm9fkcmEDvAJpKDANV2+4N0jV32gfagyH4u1UoGUnBSpWnt62602fw0I4toSffL192tRG1pDu4GEd3KGm2dMRTiDIUjlITBmfL5EfqHQI1Uj26Sfp4P+EP1yoz0CazpRmPt7L7i3LTGmsetkyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WhUMkxKARIqLQ+vy2KBVgRxnv0ksgvAqO6CrR1upsc=;
 b=a1i2QOEPtIL2SUU6UO+jtB4DxwPwcfKqg+PVY9QWfrEwWHx6C1t9UKKJLdIpudVJMle5FZL3epxVXAT1LpCs8hQ+u1WkGuDSoXT9G3fnS2yVhY4Xgp025VVyKJpVaVyjViSfdldwvKFrJXc79hLeHAYCuE+bMuAuZ+z5jPJlbEcdennIoSefBl2GnXpooJfIZBhy3UuNk3nfYk7bXqFxWkEpJsX0RZJPljxuDV4QZHgYiimDLd1HGrR6zt9zV400QCWoA/XzEreZccduZ3Ilb80LinkQoBPkZHI0wmXStb0rHr9P++XR0gWSctncFU5T4wUveRpOLDSoqaZI7Vhe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WhUMkxKARIqLQ+vy2KBVgRxnv0ksgvAqO6CrR1upsc=;
 b=tFQq46yD3S4mSXO9JwPVuxC9eGqWpsopsIMuoJkuEN8ynmnCdZT70D+jXY786l6Cw0pa4RJTIBc7HeVwEy1Ij5lG61JePNyynUTzF1TAEpqNM9ymJNs2DOZNhPNq9Y/sxmRrEIruGTne76r0xokUBqCCn+rFniOuiGyjg0cm9Rw=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 09:45:58 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::83) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Wed, 5 Apr 2023 09:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 5 Apr 2023 09:45:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 04:45:55 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix warnings
Date: Wed, 5 Apr 2023 15:15:40 +0530
Message-ID: <20230405094540.2935900-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c8b7a1-85e9-4828-d737-08db35ba8ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYoY/wr9Ppukv+FZ+9QkzqdsvpyQsR8pyewrsVAkfjBIYVoE6KxVOPk6anGi83rUxadblhUTKMqqaYqieg2Vsv7WaR3lKKWayR3sVX5BK8rxza484oby/jRqUDzUZCl/1/XPDX6IU9rNOhwHXuN6mnSnp7tHW2gz6ifSfBkVqMhJFv6vLMPhVM229HxqKmERo0N7P7L/+yxjFTZ21WGgrC3PkeYUdDteAk0vVVvVMhqQLllIU98zJiUWRW+t9NZkeP92ZVOJu+Mg2p8xnA1ZP4ecQ6O7bCyW5s/taC/AlVG70rOSXJavInHrJBjIf12G1xGV/ulzbajMpDCGfjrtm2fcLaHxJTqj45Sj3QG8u+I+zHFwOUecl8QUXRifIA0dzYPMmH4Pqm2V4/5SitEmQVKBU2JH9Qi/g4WRyGYteEEUX/Rwg9u9iL+cNMJzpW2/kIQsJ1G0aNHBX4ljwNyCd2H9UU0Rm1w1tddpFgnaqZlmOTy80U8t1BY7K68fgwrAq+YsiIqGSLUNCym3YfOwaaH/F6B7aWmgnRo2bWIU79Y0VfU7a4mA/Dw1/eEQtYuyP9oQh/EwdbHa1QiHl3jP+YJ+63sMj0tbFtEZvIxRij0z/QWjnk72SzOyR2+lAnqwPMX67e8chvBXjLwVWMLr5kbyIDtu7/dTmsI4Dsdtc0ccaUNjrbpS6guKnCkswzr4088/UDZwCRK/SqQjt2DrPkrXwYtZnE3XEMJdTSMOPyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(47076005)(83380400001)(426003)(336012)(2616005)(40460700003)(186003)(4326008)(26005)(1076003)(16526019)(6916009)(356005)(70206006)(70586007)(81166007)(8676002)(2906002)(44832011)(82740400003)(40480700001)(41300700001)(316002)(478600001)(82310400005)(36860700001)(54906003)(5660300002)(8936002)(86362001)(36756003)(7696005)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:45:57.9539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c8b7a1-85e9-4828-d737-08db35ba8ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: Alexander.Deucher@amd.com, kernel test robot <lkp@intel.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below warning due to incompatible types in conditional operator

../pm/swsmu/smu13/smu_v13_0_6_ppt.c:315:17: sparse: sparse: incompatible
types in conditional expression (different base types):

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303082135.NjdX1Bij-lkp@intel.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bbac4239ceb3..376d14de7602 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1241,7 +1241,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
 #define amdgpu_asic_invalidate_hdp(adev, r) \
 	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : \
-	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : 0))
+	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : (void)0))
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
-- 
2.25.1

