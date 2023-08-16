Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C68C04E69
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 11:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9424310E361;
	Wed, 16 Aug 2023 11:33:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F1510E361
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 11:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtM0FPcrmxKAkWobHnHX2UCz7ixW2cfVaEvg7kdGXrzH46biF7UowU5K88rDXM3m8tditgyZPZlFa9BZZgpu5fwurTEh79ZbA2YNAgu0Ycm5ylNY9mA/KcviQb7vuxgYbf2K6j8BOtQnHeHNkEh0xu74cfz9BaAk4u1DwXXqYEVUmfwI8opOO6WP3Io5HvchOXT1N0jtWx72xC5tuaqwQq5/RWkzWJRSqOgAF1Co4IFf3Bq/8ULSPENgMSLBhwF5t7LBsQ6m06047glyG73NhipLrKlACGZy4TO3E/2G/1uTYDnohjGLHoG8H0z7l1actGbt3WjzCZqdfyRKSEvOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bcDIfIGpK3fixlcqIxxdL4SjUCv7nieODw0VaqK7o8=;
 b=coLa5icdXC6V4kYzQoDWCXD/nXnTpezBSUccIDd++eVPF1elvByNunC+9H2Fk2nBRFex/Tn8V/CuZwr0kLqM+gnzT5VubKbCEMV23hCNiNLlu5Bo52ZQja+wKMPFEWCyJmRCVxE2q8PkmADz+wI9SIxMq/UgD4Ez1/yKNILCYM67rGoTwzv6laZxBG4zybJEiaBfdtT0NqwpYCTmtQ1MO/vgLKCgOas3dFRkePSfro2YTn92VRDfGpjQJ3bGSRj4id8pk7wTOmD8LJmx+qSSCA74v3zEwFlwqxq6OZ57J3Bk5OD1bxxDmCj82Rv4Yz+Ez9Kpd/IQ6+plQdnNQEHQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bcDIfIGpK3fixlcqIxxdL4SjUCv7nieODw0VaqK7o8=;
 b=zqu8gjaYdFhNlEBraWkZaKCRwr8s6BFGeEpDoHdSd/ExAcUwtUPtID2SiYoVmXGrH9NjJo9tr9/Azgm+KV2vsqiBCELrg5f6EzX+dkZRYg+S+5pW56HiD1Ey/l/4lTsFhILLxs18mLoC1yxIgvFEHyZ9Fv/cqJHTQ3sleUNtt7A=
Received: from SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::18)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 11:33:21 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::7c) by SA1P222CA0119.outlook.office365.com
 (2603:10b6:806:3c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 11:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 11:33:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 06:33:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Update ternary operator with max_t() in
 'amdgpu_fence_wait_polling'
Date: Wed, 16 Aug 2023 17:02:12 +0530
Message-ID: <20230816113213.716108-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
References: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b79771-e1c0-4f8c-2db0-08db9e4c9874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYqwbomiMINx/KqFQNcFlmbrRqjrhdVkGCq0gIKnWhTLQTZrv6Qy+6eidGrfGCyV7XEHuQD/texODUIPftH2a5Nf6B7Wb5M0bc1D2B40tGCLrGhD5Ry+Bxcff7QGZi52BxiWfqfo35ZW9WU33j3+4JetG5syBmJqeLX97cBUEVwDPOWta2rdEpYC7flwPT2NFp+27HZMBdLWkdN3QdThHSemZbZgt+reeFmLUUMvIgtGI59YTjphlB01dMiK2co9lzSBava2OPqzDlgAtIQUfMllpzAIJN3Oybto1tYmlBS6MW8pfdtVW9GgnCeVZeXzbYXZwPmU5/rrE43G1265kfORr7Lxr63+QRc1QF2iEbqWVyJKfLFIu4zhPLMtKsJQ34V1IJ0Vav5iEUSGvaytBzzAMcDRFjgfKqyTHzD8yUlmQMsdW1jLqhgiygnch7+iXptlsJ6dbkGjeRU6NdcSbCvrIB+NRAdKtAx1hagcJflTHqc0YfdbdLuu5dHLcmGxxx6ISJdOErSjXKKuFz9f6lwmh2irjQ2RgpNCGsTGwI2S1S9vCRYHof267Vo8a9etz+4XOsc0hdvlgGqFoM0nNMZU2CHkG5yBTJ/8w/eoY2QMQg6+2lVVTIavZlVwUWLysXHGVkS7r3LZbL9s7rQpjq++blX9IDzKD/+7Ly13K4njF4fyZIsY7qMK5vHYqbPGNsVMkFhk/Ey6CnPu8zjUI0U8CjINrqkqAG8GqSzd6jzm+ypaV/8REku9YUcS1fV1iiUMSli0NgiT5zCd9Apn0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(54906003)(356005)(82740400003)(6636002)(81166007)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(44832011)(66574015)(47076005)(8676002)(4326008)(8936002)(40460700003)(2906002)(4744005)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:33:21.4885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b79771-e1c0-4f8c-2db0-08db9e4c9874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:384:16-17: WARNING opportunity for max()

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c694b41f6461..8327efe24b48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -381,7 +381,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
 		udelay(2);
 		timeout -= 2;
 	}
-	return timeout > 0 ? timeout : 0;
+	return max_t(signed long, timeout, 0);
 }
 /**
  * amdgpu_fence_count_emitted - get the count of emitted fences
-- 
2.25.1

