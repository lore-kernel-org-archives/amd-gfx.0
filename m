Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825CCC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 15:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C6D10E0F0;
	Thu, 21 Dec 2023 15:43:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A76B10E0F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 15:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgscWsXvc3sOWnJDnXo5cP7X2SGA6D07+xzAqULTXz9Scp8nVRZKkPrdUta1riyuP4Dly1pPmki0jxjcI6T6fJN9C8vrQ/KhOw/kATbdemCDginUolq5EDhQMSwtGMD+OSoIP3s3n2e6Ka0h9Ko/dFhxp41ulr4c6wbe81HqRqD6iOEFwS3B1vauASaLy5xcFo6udvBNN5HLl9ivOwhkc7/Y/YYblphNa4EUiwJWEvng3rWTLSPd+EYiU8FaDKM/g35p88ipsu4on0XbA0j5egSDklRf08qEb92kZprCmUNm0o7CxfB8yyZ/44ecJi138F+exCCrD5AA93xGkhuWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNUc+7l4gGPs5N4g/sgYJKRHOIEYEMrf4yldKfxGZRQ=;
 b=f3DavXOUvurP/jQ5Q/rC09x+R0SpX+iyZsiInred8cMHKyQNJaMXiGCSuQDBIpEpPSCx47Cy3yLgHjq8O8a+C5U9LB5rBoeGfYzEESG5mK9D516CHT6kuBMKQQeXOkopFalTIKg3q6hsSrsZN3eNSGOGpkQ3obMQtwkdd8ZSG2FcJDyRrRaLAGEPENvdAwjTy0h0liy/pYNif6G2WXCN4iKbhc15BrHbz85FKnEZgc5sFNoLXgkMEkIqXSUZt4JxyOcvww9cCXTFsciGefEw8JiplQJ5pXREb9Yv6L9tYuliIV00LNqs9Y+fzdpGjsQmAvGeyBmlAUn02U+pHaIqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNUc+7l4gGPs5N4g/sgYJKRHOIEYEMrf4yldKfxGZRQ=;
 b=SuE3ZefcrA7FIWxlK64s1Yky3kgysw9KTTKHE0LYOdmuBUrG8rhCen4EWjOsgVpLhrl8x6HGRMBmdiBRqABIcWMxwmfYvm3hpX7xtHYh0GsxmisZaScSbp9kSm4S0TfYNV4MNx+7f5+gzuBSVRZATF9WXXwP9GiGSCj8uNS5IbM=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Thu, 21 Dec 2023 15:43:42 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::d0) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 15:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 15:43:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 21 Dec 2023 09:43:35 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH v2] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
Date: Thu, 21 Dec 2023 21:13:21 +0530
Message-ID: <20231221154321.1369933-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: a650c763-9793-4749-86d0-08dc023b9be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhWQkMrsWQRxazd4NLDSNQ0R5KgcrZ4HBOZ6w1XCcYYGwoS7wZEPhjz220BffLMEO8WCtTupHJL/uId9cEgc7ThAmlXEPAQBJeh+IiX2i0uxGsjg/nPn2ZBh9fWhAyMwP7hl6Pbpc6IufHaB94PwXeTjSl93RkTlOgFmJQaTal5266nB9XxK8boHeEqaARBO1JrbbK8lZ2qx0x7qNae6kWim+CdAmh1AK9wVoihM1N0C5nn9d0Bb5OjSNr/TTP1e/FPo0NXm6FgcBTRtiqul3D0K0bnCYhXvvhLH02HpRDDgX9VnWidW1dUb9SgcWPYQGwpGq/rp4Zut4Yiz1tQCQ025nnF5WsZ5RV61thvWI7h6rQ3CNCT9Oc7g3p4KWN1QSVgoJc1HhmyTmCgaQ/5Sx5ewdwXAFSPCaqqm2GQK10GjSwyiALWE3yoUuQb2wonpQ2TKrmEvLegh2LrWUly640p6Jpo6LK1HfJylNlCohPe+F2XO0GHcTL8pkQDwHBySGkDisqiFut8MirjfTvNeKO9E6tk0jC8ilhOyCU2ghHArXb+zncwqr3w/Eoth+SrD1b+uUgzynB6R0NBZT+RrPfxI+78KPmB/yZMX23fbaNm0oCgWFeKCuHbNeXzSubF3DyA3J6aXtQCNk0LFRyR/nv1ymT2b/WdkVqOQIklHK8J6zyIi5POKRNIOdiN/VcL5tbIveu0hfZHa2+ZjNUG6Sv/I6MZwUNN/NTIXCViWbFcZNvUiYklxO7melollgmtxqfPFDX5EnNQWZ4nOnq6G2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(110136005)(70206006)(70586007)(6636002)(316002)(82740400003)(81166007)(356005)(36756003)(6666004)(86362001)(41300700001)(7696005)(1076003)(26005)(4326008)(66574015)(336012)(426003)(5660300002)(44832011)(83380400001)(36860700001)(16526019)(8936002)(2616005)(47076005)(54906003)(2906002)(8676002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:43:42.0732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a650c763-9793-4749-86d0-08dc023b9be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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
 Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
'adev->pm.fw' may not be released before return.

Using the function release_firmware() to release adev->pm.fw.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.

Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..f2c3d7ebb218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1541,11 +1541,11 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
 			/* force vPost if error occured */
 			if (err)
-				return true;
+				goto fw_release;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
 			if (fw_ver < 0x00160e00)
-				return true;
+				goto fw_release;
 		}
 	}
 
@@ -1568,6 +1568,8 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	if ((reg != 0) && (reg != 0xffffffff))
 		return false;
 
+fw_release:
+	release_firmware(adev->pm.fw);
 	return true;
 }
 
-- 
2.34.1

