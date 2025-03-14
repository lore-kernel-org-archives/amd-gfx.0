Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3F8C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 07:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F5A10E975;
	Fri, 14 Mar 2025 07:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zj+p9tI9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D1410E975
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uros79+ILpfjvFJUAd9T/Lc3PDu4XP/eGnipul0eBDSjRkHuF/VWBeHehiA1e0iafalFiAuMDbYiHELfllrmmxcRB0cks5tzE8QYcnstLod0uqnbZy4Nrtb77lP9h4A5jm/ecofdJWHdQ+Dftfu8zPNuWBS4EGlkMHx41vt0uDFQKZS/54OokqXsYTWPpvlLTV2jAjYCgFPWj5NU7XK/xvNWUGxIRLS3aRu9Tfqhb5XavVa5S59QHc7XH/sobvZ6wZeMjrEpDaeTZSV0yxr/v49/UZhun02Rfl5+D7+hJd1zBn5IwHuHCGMnRXypAWDtU+mHbgQvqCzP8ZsU8mqGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDVLg3FQwvIUW5ay8hw0XbPDMTVW6RR96armjTur1tI=;
 b=IFPRUKx21LnNZ1zFQ3xy/r/qBHV8sewuNJ2KN56CtE6f7VJT7QzHxpneKusl+zWRSEadV5yaOF9svEuhJCF/mtKK6divfZ3QGnfhdMGp5/5uZxQQFIoSZNtoQocViVYrLAWQGd/AkbuJgtPDd77DbvQvQdYyGDPnACRkCO/nUP0xYci3xNDsE8UWo3CrF2dIEXnREppVQqOrMm/yIsna+WRFapBaDsGDQNyt4pDzxdaheRGB1IHQEDavuvBjAGffVqOab3BjisQ9ZtVUCMfmI5leVerUX+JRfGz1G5Yj0lbgzY/7gH5IyWamrNBOcIdGAaIVCXAlD5FdA1vsLv+jyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDVLg3FQwvIUW5ay8hw0XbPDMTVW6RR96armjTur1tI=;
 b=Zj+p9tI9pwQ2PfuaQ276TvBBGtpz1btlq8oIx7w5ss5889DWCcKtlSdm0woWMLduauhp9V/zPU4ZZDhapHlwoVeFdfjWNDuMEg5G8Hvecl6A2YqZBCUsZfuUP7p2YNGfAOKU38NuZXl0/nIJSsinJFn1Q4FMFBYcK2DTbQPvA4M=
Received: from MN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:52f::24)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 07:32:58 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::ec) by MN0PR03CA0013.outlook.office365.com
 (2603:10b6:208:52f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 14 Mar 2025 07:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 07:32:55 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 02:32:53 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Add EEPROM I2C address support for smu v13_0_12
Date: Fri, 14 Mar 2025 15:32:40 +0800
Message-ID: <20250314073240.641799-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5661f8b2-bb7c-4e90-7112-08dd62ca6fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cOEqCW/cB3uMAo9CaqNIaGyoySiKnRmuP0kavg3JgFYyoNOexIV1AbHzdKpL?=
 =?us-ascii?Q?RlZSLY+OiiMVviyDLpM0sMkOme3JHR5g/qBN3AiDD2SaDXkKs7iky/IXJiOE?=
 =?us-ascii?Q?sIGuTO545wsbU9Po95/JFVzU9rWgOAY7Xt5R30xV5NVFWqdnkeq3TYYufEm0?=
 =?us-ascii?Q?KX6+nEH8eUtb42W1VAkNft3q/hxOz3otcfIOaMZsYnikdGAdweRvugfm8Bxz?=
 =?us-ascii?Q?UX6zTwpVlkmaPK8zdUorbDNFih0jN5hoB5o+8wwmmYrwsdon+MDnhZ4StKZ6?=
 =?us-ascii?Q?VPIjcZZ8V/6S7kKE7wqfYlQA/2bZidCOyRSd29t5jRs5Ilr+Mb5c0CUrTVuI?=
 =?us-ascii?Q?RcZNMaxvZXMbR2PWwaJxmUejwTWQznCKydSMwTKmCUF5QFOWwkmxJKyzG9Bu?=
 =?us-ascii?Q?P6Tj6R8uaIxJ6vO8fJyb220oiacDuOuFm3mGZO8u4IJezTGUuZAVAaStXggS?=
 =?us-ascii?Q?l3pEE2SEm6/uIJZU1IN/hSoYqTeJVynHIY36uv23/gzwHfpgocXGlvzhBUFj?=
 =?us-ascii?Q?pfRVxXE586wJBgtrCazZYKbmyDWofq4OmGjm6RN5p/cL6UULZjz2ZGj2UTv/?=
 =?us-ascii?Q?pzEsRy1cpzUBDx526fqmXFkqHzTCgOS4oiPx4VXKYoknqQfwf3Y1Wu2lDfoN?=
 =?us-ascii?Q?3ZaexGmo6XKujjnoU+Ib8pFQIBFKVUo3DczA8AsUvVKf19be4Z5cP50PFdv0?=
 =?us-ascii?Q?1c3XdmX7LblIyph80GrTB2F1LkkfDvuZQweEZ4cqSENue9Ur/lvsspsH4p1v?=
 =?us-ascii?Q?/LYDCMT6v2H6f4CYbO3rQANCME8N5bp4hv09KNMQKCDpz28dKCVmh58fQI2t?=
 =?us-ascii?Q?sFobzn+Ew28lPheosAXIsYzroQd5SNZ+oI4G4kz/OqadY3vae55RlzXm18AV?=
 =?us-ascii?Q?BjqVS4JBfO8WaaH3Uz9Cv03E6PIuIW6efFsEnNkmDikRz0Y1g9LFKrBmRtb7?=
 =?us-ascii?Q?EPtgl+xeY/t5KBf/NxCtI+Zx1rpAFxuToQ0IecJvkrRekxlKpSbcGN8Nb3gJ?=
 =?us-ascii?Q?0Xmw6PtCjh61smtM3uiodepikZo9rd+QBhON0tkuAIRpAX5Y6/idCzJ/2xet?=
 =?us-ascii?Q?PUxmiInaZ7oE2qAR6+V4B+OQQqr3Jt9TV5yc/9qNcdaRr2eOaQp/yNC1lNWV?=
 =?us-ascii?Q?r9Pb7rqORaFT2yUdvjWPyPa7QovUagb3/xU6QIJSREXoveU3pAW/H0V1KS1T?=
 =?us-ascii?Q?4Fsjq6yA0Fld4AZCOA1DH87WYVBkprkAr5S8KGCVc9t5HrhJMxe0OL3TLqL8?=
 =?us-ascii?Q?+PRq1d7ZOVNLU0F2xUcTIWK++MKADGtpbXLvNB6ShDHCKVOSAzQch6st73lg?=
 =?us-ascii?Q?nIidOpERSkfiwII8d85aO+DPIYfSCFUIQzcRVzEWK4Pa9y3mycjIx0Hytbuf?=
 =?us-ascii?Q?XK+euXLh4BnPN5AU5GXM+T8uxruvOTL3un8Y1t6WqahU63ruHV47RT/AtjHJ?=
 =?us-ascii?Q?02WEIHTjxEn5buBs1zQBs/TIfABImLaRsgUcxyhCQvEypk94lE7ZdwCjwoKn?=
 =?us-ascii?Q?IrSCYuL0CLXFJ+0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 07:32:55.5381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5661f8b2-bb7c-4e90-7112-08dd62ca6fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add EEPROM I2C address support for smu v13_0_12.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3597ecd9baca34..3de89e95a636c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -161,6 +161,7 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 		return true;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		return (adev->gmc.is_app_apu) ? false : true;
 	default:
@@ -223,6 +224,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		return true;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
-- 
2.25.1

