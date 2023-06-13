Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF94EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 23:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967B610E3FF;
	Tue, 13 Jun 2023 23:08:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C302F10E0EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 23:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0vlVGLPz0WcRIBzJLtLCef5KXGORl08MH+sjJybNnW/qHe9n+MtFWFNdX6alHnm2lTCzqFQn+fQWZXHkGXYOt1u9zaQILKOO+gaesYHTrHpg2XxYy9ULNXgxZAhEV5wmqjNSCd/H0IdEf5WZ3umzbinWuHhdDIM9wl8gFAuFmfIKc1OfHPv7dS49R3MlHwGpGyr8G1j4llXsu5sK8d+mGRoPNiNDCoaWK+kAIxW/p8aYYh9lbVQH+bXrMlnf2d1EN3VmpcaYoivYftmihMPvMrRDV6kGKR7rouAC2fV+w7+2nydcmtGOwRB48YT75dPQnEVZM71qfdQayH9bZxOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fer/M0z8WX/tYMwgYE/YXiUHMnNmiWIDSCO1vHEV4k=;
 b=l5F93TP9NAIcBn6DVsmc9txd5w7IWHrtZR1rvvomhKQDidTAZaWk9vOfhcBOkmO1ZM/ti7A3N10tKacQe9eCxgvJTwuhSuwwL3bWerVT24iyz50JHFxwAoA84Cd2fnBjzy41rOALJJh1bMlM3XOSvJnWWxmGDCL9cKGddppFvxZhfaw0hhSmO24Q47KKNQLSOEieVKLErEQ8ad4gFEVP3iipCsroXM2F1bKT7bXq/p8ooZRpgiPTRcEm75AD8lA/CNNx4atyG8K6QuN9ikJuoZCCRnz2iWF1DXydrHiCrZjtp8W8dNea3nTSvfMgmfcC6pZ5Uh6t89n348GqlWb3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fer/M0z8WX/tYMwgYE/YXiUHMnNmiWIDSCO1vHEV4k=;
 b=GtXY6Cg7say9XRuq20rDAyULAPow2ZKi1bGDovLk85tjxd/4oRo8XjTFJD/3JTcz9qKISQZ3ZLYVmwYDARENdD6MoF2DbdEURGZdYyDYduiS0W4K2Whxjnnsv1uqa8tdjxxP7qfHLLIyu0vWCmMVjINtMLsBp4BZEBNlI5609ao=
Received: from SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::16)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 23:08:24 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::69) by SA1P222CA0012.outlook.office365.com
 (2603:10b6:806:22c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 23:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 23:08:24 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 18:08:22 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Update total channel number for umc v8_10
Date: Wed, 14 Jun 2023 07:08:10 +0800
Message-ID: <20230613230810.3499046-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bb5390-3546-42f1-3b7c-08db6c6316cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzLes0SumlDtkNJ06IT6rkjfzcFHorRKHO1dAAIPFIz8NJKzUxBNmrqL4B7PuPf3UXzFDk5Hl7K75KKMFA1cEnQDnIcjoKOF/NQFIvmVlvylc1NF2OLHpS2sP6nP5dPUU+LP7jRZp/1PTI/17lyh0+aogm5K1GVhBVWzBhk7/J8zbHJh4zqbvNpvMUsQ3+HIOHCdeOZ/TGO2Mdse+0ekotL1rhUe4ifPobWXkVIPWrfP1/KARAdUYimswlsGvZxgy5g1fMvXlAImxGB22j6WvgI2WfVRPkjpWuTnMCu9PjPqLI1fcg69MBZBFwFQAD176aLS2MAmWK4XMBZ7uOwRBEwwd6syxzemk9ne28WlrRHt2J8yT95Ib4wg7t72ErM3A8icG3qpSNYMLiKDaiJbtg9n7txHcFyX4WAYYIrXOyiF0pp2qKnHMD1MQ9NAMvLdm0ikjYWMC0JehQ1kvy0dhEw7vtcrTS9PkiTnQ+qJ9XLss3ML2PmDHV3O8Xwb8IY+B2mOfw5NmrbnbalzokcMvGRa+zNrVzRqZo/SpaoLFLSGwZAnqrUf8Z5wQFtH3o2gQ+NIA66cCZgkqln5usSn5kf6/NfBzPSCCpeZgo0/pe54ce4PiyRD4Z9A88A2de3l0s3fcU72HGNR9vZ8XfVqBT79PYwWvFuJn3GwOETfdMux8aamcmiBx6s1P3Sb8VmQKHH/P7tWgzKWH5fUq3Wryg+U25h9bmvHBjD+I+8SQ80fi9yrsEdNZQL33nK7z+BPW+v4A7Efhvp+Q/D4UngJtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(356005)(81166007)(82740400003)(70586007)(2906002)(70206006)(36756003)(54906003)(86362001)(8936002)(44832011)(5660300002)(8676002)(41300700001)(15650500001)(6916009)(4326008)(316002)(40480700001)(478600001)(40460700003)(6666004)(2616005)(186003)(1076003)(26005)(16526019)(426003)(336012)(82310400005)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:08:24.2633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb5390-3546-42f1-3b7c-08db6c6316cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update total channel number for umc v8_10.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h        | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 859882109f55d6..16cf7b199457e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1515,6 +1515,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 				mall_size += mall_size_per_umc;
 		}
 		adev->gmc.mall_size = mall_size;
+		adev->gmc.m_half_use = half_use;
 		break;
 	default:
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 6794edd1d2d2ae..56d73fade56850 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -301,6 +301,8 @@ struct amdgpu_gmc {
 
 	/* MALL size */
 	u64 mall_size;
+	uint32_t m_half_use;
+
 	/* number of UMC instances */
 	int num_umc;
 	/* mode2 save restore */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
index c6dfd433fec7bc..dc12e0af5451e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -33,7 +33,8 @@
 
 /* Total channel instances for all available umc nodes */
 #define UMC_V8_10_TOTAL_CHANNEL_NUM(adev) \
-	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * (adev)->gmc.num_umc)
+	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * \
+	(adev)->gmc.num_umc - hweight32((adev)->gmc.m_half_use) * 2)
 
 /* UMC regiser per channel offset */
 #define UMC_V8_10_PER_CHANNEL_OFFSET	0x400
-- 
2.25.1

