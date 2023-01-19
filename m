Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46D1C00A5A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 05:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D70410E22D;
	Thu, 19 Jan 2023 05:00:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FAE10E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 05:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieoq3Ptl9e+tv+bMQWQZnH32qwnQAZunaSHjqR1D5xAeFoOoxUPh/vklSABlGkeX1Lw0HdFDrFCDmXS++aS/XdH8hUJQnS3Shba7urZRuJ/Didp+FsSDkrJzl4TwRCOuZPQui4NEefGVbTs/E6iqEK9EUGAv5xadn7HuegqiXFsJEF03l8xRdfzRHn2BYCFZzS58bLfPQpudKlb55GDR5gZBl56U7FdmBGppnwMv2Fvw+19wOhIIeuxjns2OygEY+McCuG8OANQomnRPX/oDDFJhcnCL0kt2ZPfun1F8xb0UHrEw99JWLlXdAgXpJFPAbC5VSExnbHkmC5N/697G2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paqJtThK8bWFEbSqwSd1z7fiJOR4ba8zdT6D4GnKmX0=;
 b=mdoaojG/FsvGhzTscoWyhta6AJi5ltVyHGPhIOJw9LV6CIt/V0xSzwmSuJjjsHvCnPR68rNtUzOVO/C4rG3gJKRdmVKsImPNqeY2JTVcg4AnTk3WrFMjZBIs2dYmbNRxcv81POPpn0EDk30IZ3BxkGqHNmexTyoFOPDWnVQ50fN//kX53sITC55btnwMeHx0+TCHjGxXMU6VwZg8fwnp1tFv3CUOHUzxJIt66laM4jLaTZVR821BeuseTLxesAF9U32r18/8X+CXdgrWsCuEyCiqxRv0NCaOXENB6rinnNjaLUT09bS9SqNrL4dCpuKqStLQEDlWrQpqerhjyRKBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paqJtThK8bWFEbSqwSd1z7fiJOR4ba8zdT6D4GnKmX0=;
 b=l9DtYhZkKUxctvN+G8ODksApbUIEDdrHX8oc7MhXRV9dmi0Z5kXQKBL/yRNy6xNZ2bkC1HCnH0rXeto/FyzUJdagWOfdYEPsadLwL7ftFgGbDICG3ZGFAnt7sUyOSrLSCm39cv6ideBQjSH5+F4JjIONrBjEl5Y5xu0lRORzsmU=
Received: from BN9PR03CA0961.namprd03.prod.outlook.com (2603:10b6:408:109::6)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 05:00:13 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::34) by BN9PR03CA0961.outlook.office365.com
 (2603:10b6:408:109::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24 via Frontend
 Transport; Thu, 19 Jan 2023 05:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Thu, 19 Jan 2023 05:00:12 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 23:00:10 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Optimize sdma ras block initialization code
 for sdma v4_0
Date: Thu, 19 Jan 2023 12:59:31 +0800
Message-ID: <20230119045931.576688-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119045931.576688-1-YiPeng.Chai@amd.com>
References: <20230119045931.576688-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a90eaa-84ff-4e07-456f-08daf9da0c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjdREeiCzPemTfIJ4k5vqS9ByWzjJTlzBx0i8dNHkWXKOilMCHdnTfq6fqrT0H5y/b9NSCihEpuO716Aff6cls59Velz5KLRTCj1lvpBd+8xPoKpb4YFgBq2VGNlCm1LX4ppD2cAY/n3gVkNvkkuKcEu37xVLpoxVxDxjRDD/cBLzAdAPwjPAKBQ3omGfdMpFHoDB9z8WKSmpOI13djFxNzsd76/4ZGxbsTGIq5BdJtfVoGHRxHzqrabwsI12zcscXHqi6ReOCA9ZhBbRNhyVOqdFc/dGeHUdufzSNigfSz2dMhD20ek4Qt8VCUQ8onvnWJcdcrMOiNnO8ZqpA+K7O49bdMJWwPW2Qkpan5mom2SUxIDTquV6WwNy5ebZ8p+rXHhzBpvnnbGQOImrVlCjbOj+V3SycUTMcPgGcByljUn9lUIp/jWU6pxN29VSFkCf9EIo7o9MaWHbh5mXRtEVpW3Nrb/pdMw2N+a4DdueOvQTo0QzdgFK8aj5kj3LHI8NL+YlVl05fmV5SVEvsNgDe1jy5cAoO+nSu0omqVzkIkV1FaL7/76XCzTDN0Q/zzSeaBH6a3VmCrekPsFCe22/fhw8WW8Tz5EbgmEnOrolaG8z1gXaApmkTlcKyumy2Cj65b3v3P+mt6y9uqqdakhLzdJskRLU86RzjE0XkwEVudlZv1vZpw7ek4ScL3r7QbjgAZ0j1qfTZtwlW/IHRxclCZt9obWxTQ3FhXEa0Rqlwg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(70586007)(4326008)(2616005)(41300700001)(6916009)(47076005)(26005)(426003)(8676002)(186003)(16526019)(70206006)(36756003)(82310400005)(5660300002)(336012)(36860700001)(83380400001)(82740400003)(478600001)(8936002)(86362001)(7696005)(40480700001)(316002)(54906003)(1076003)(356005)(81166007)(2906002)(40460700003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:00:12.8514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a90eaa-84ff-4e07-456f-08daf9da0c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize sdma ras block initialization code for sdma v4_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 017ae298558e..b5affba22156 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1851,6 +1851,11 @@ static int sdma_v4_0_sw_init(void *handle)
 		}
 	}
 
+	if (amdgpu_sdma_ras_sw_init(adev)) {
+		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+		return -EINVAL;
+	}
+
 	return r;
 }
 
@@ -2688,22 +2693,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->sdma.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
-
-		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
-		adev->sdma.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
-		adev->sdma.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->sdma.ras_if = &adev->sdma.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->sdma.ras->ras_block.ras_late_init)
-			adev->sdma.ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->sdma.ras->ras_block.ras_cb)
-			adev->sdma.ras->ras_block.ras_cb = amdgpu_sdma_process_ras_data_cb;
-	}
 }
 
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
-- 
2.25.1

