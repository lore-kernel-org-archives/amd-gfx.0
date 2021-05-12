Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE4BC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B956141C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B956141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409A96EC75;
	Wed, 12 May 2021 17:31:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A372B6EC62
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2ymedvwVZqg2R79eDOnuNBcTn+UHFTDHvciq4o+5W4R6FGBcOn37CBPTRkZ//sK8nSGB1i4O/1wR/LCkQCUwN6R4G4v8ydMCf92c2OUU1gfJLkYCvPusTqURIPlrSotd/iv5gCx+wf3nfnydntgOuP8iOj4kpeEqBAE+VabY5iMBabLwZg1Y9it6jCSBEzwk0jUu6ZUZBx6aKMs/ig23zDRQBNbD66SLci0WSniL9KHMw35FyjCJ6cbkTNx+FqJq5yQhaZGL2d2UabZRjRW8wLaMKjkGKUnUqQ948/t8aQK5FgFXyIYQrU5E+5urOrnqTlfzONfl5PDW6buK8yWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ+GKWmin/B6Fh7geGKKYcWYtQD5jujJnM1tHqzpS00=;
 b=nmQar31NPS/N/uF0VG3hy5YfFUIGUQeMqSlpD4ebgZDwzekdRLc4z4YHbZaVScTkXxS7ThNkMEgkIxkYUE91IRIC1Kz+hcAEjK27jN/kIY4h9I4G/iZl2SzkgVte+0qEfVv32s2fSgtJz0mtMr0EfN89+Nj8CZwwvIN0mNbuhapXTGbmwvCKGbXcxpglIpK/+nVoIGKf1URRl7Ab+iUDt643qFSOA9FVWORGMVpJUVaK3HlIt9PsvG4AMFSq9xndj66ltUrUSPvUMzbVnHgGZE9i/SBdi8JAfsVfKOuCtSQfGkoixKDqG/lpCvavkgOlxgJMQVHEW/d9pEZFK3J05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ+GKWmin/B6Fh7geGKKYcWYtQD5jujJnM1tHqzpS00=;
 b=FzQkyY0rrLH2HUOUN2fUVqb26RW6r9FNVcjoqtHM0kW+GF4KeFRz5KT1+QxWKnPWMZ8ozqECBD6/3p18YZpZ4F5gZVb8s/tbM6U/lHkmIHducvM7Jqm1ElxIOyoYfGq39zSl/ZNfCWyE6pw6WRUSr5Lt1uuwejEIKszFps4HfkM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/49] drm/amd/amdgpu: add smu support for beige_goby
Date: Wed, 12 May 2021 13:30:25 -0400
Message-Id: <20210512173053.2347842-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d003f2ca-510c-495a-3b44-08d9156bc4ed
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340B8ECAFB654D7346014B9F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+vL8UlarSJCZPEv9pi/Wq5iqNrisJYRWEPlvtu3Q3tTBdt65hhLGsRrKGHT4Y2KWU7p2FI4nbvxmQf195MJzCh/mZ1XDbLSYjA/SWD0WH/DaPRrMuW8N4FCfW7LOyzJlNlpeMvm+KZ6HD8fezqjgyzjr8ceBr93ecIKzQFNDVOwZfts5zswE/0PM9K7RF/Ug6+UMMk18PmR7U8wvp4c9aPsBOGPnWn7Imnr2WBCR4Nz4YVSfJJA0qFPfPglsUj9Vl95G8fGgWarneWak0yd0826Vjf+kYtWkEvGdV2fGJ3xCuVFzVBWsSLLL4+aCzFMSDQ1d3UFZdhil6XljXjD2cUf+evyoZOg9ObiDStHKXi4IkGNm6Nrkq69LzF2+XQDi3ir3hPPBUDNPO8r+jZYliyUFmmtXieDEicc5hApwr2N06eRqWlocFqCo78p93MWeEnRexjX5HuBA3L2g3cKXlVXMHVt5rDz59heV6gSlermhtZ2Jb5uKkVymWp8bh7niHeTvvkzeuawzK3p/QONoEtZS5wZ2Mz6z5V8GMci/j4RudQZV82EUS9rb7tukAfpM7oW/g1pe2BJfPzOjiSqmXnOnKvL2EOOw9zZEjGg/bt1CliTdTuO6AeIBYLNblnnhq6UiuKpJ5JrP4Syb3mM5mUjimOADYfOXcByPtwjJzzHf0crdv9tGVFoy0bNLtay
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J8fb/AwMuOw7nFn3svGhaJeLAsv71stle3SBOlBwn5SPZKAwl7GxxvRqYCHc?=
 =?us-ascii?Q?6Qm6ENNQBKujW3jN3SWiudIZ0yW6LdO/FixNAEISFfpiJj7V2oY3y7HCbbHD?=
 =?us-ascii?Q?idkuNVEKNbzW6w43zDK8NoJhbRCAeYhe/0XrZS7qBSmPw3lhxPyyC2FRIrV+?=
 =?us-ascii?Q?U544aqTzs+OZDq4CGQGFSA591TfEH3Ek8DQIDHaHY+SHsXModN2SeKFwqqaZ?=
 =?us-ascii?Q?53/LLKOSNYuOg1wxRIAtELZ1waWd3KByYdudxo///z67GDgaQS+2EBOF8QXA?=
 =?us-ascii?Q?Xk9sWVtBEfYNMdIjCAH+M9yXP99cCM6kyM4ZAffF51P3H+gLvE8+bEGKi4XU?=
 =?us-ascii?Q?lNZO46tjaRp3GxsnP1kMT2u9VSbc+P34YlKViqS6jElpqcPv7fOUr1o5ARu/?=
 =?us-ascii?Q?qbdzsvdjrWYHu/a0Bc6K5Z6nIIMiiwodXUD8C8Phky6QKflJzgIdHeG6lmCz?=
 =?us-ascii?Q?oJ5RVE38yIy/tthOGV5twqPBEImc24A4lCLR1vbA1eCt/+/uQPAuYru/a4+f?=
 =?us-ascii?Q?agBAPBecM0jJF14L9yWi9KTmgdtqgVkR12zQ4apj528pMiEDEelUEQieE68h?=
 =?us-ascii?Q?dTW1B7R383rQrjlPzS6QuHGVmyxf/StSAP3KFhpGTSgd0/181lL/bBRmKW8H?=
 =?us-ascii?Q?HjAFgQU3OshNwI626fGFmNY0A8EU66AgyzR+P8gagS4VDbi9kCFAkwsAoy8o?=
 =?us-ascii?Q?osTLuDZpVh3a+ezVUXe3C3mwuu5+GaJDCYfdGWx7rs5ab82Vspq1tAHmbeU4?=
 =?us-ascii?Q?3Qo6UPfvdY2HsXdZwN9lSY4QiXn3UJ6lRchu7a/h5bfV/orqvYSd4s9RQgwm?=
 =?us-ascii?Q?ICA3pHbmeGpnetAIssYenNW43IU/kgxDAarm4h1eXRlrZQgAqFSoCl7zPQOF?=
 =?us-ascii?Q?7LDviuXrJB87jijz4vz3lTPBF04TYX3Nd6hqxupy8MfWiQC57mUIW9OBIdHw?=
 =?us-ascii?Q?yVTTalz7egdLpwY30xinI+W34biv2l+kdLO0sVix7OyZ7QubDXdunQCgcfyT?=
 =?us-ascii?Q?HA7YtLilXSJX/WPLwvqYCtr4tS0/bU493Kj4CrNXnxZHsfgscrUVOaQ+vvR9?=
 =?us-ascii?Q?8wQk+ZIauhKR6PVjC0i2kZteBl+8Xir74j43lcKcdtTgg84U4WCJ1Xwdb4CX?=
 =?us-ascii?Q?gTFKxCSZEJp79J7Xo/9+fQhl6UV9RlSlccgdDRaB45XJ/+zBrRPEoKleOeO7?=
 =?us-ascii?Q?lz6WInu9WC5B0fdduvz7KQzhVvT6UMT3IViuYtU+XVHgg9jPXrGWI1bb545x?=
 =?us-ascii?Q?mfhS5GS3rimcW1TAQdfalm5vmJ/yRQrwSGyi/DMg68wCJW2PYOttf3wXr+5C?=
 =?us-ascii?Q?Do79sufySYaPHRzd2qanYTRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d003f2ca-510c-495a-3b44-08d9156bc4ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:26.1431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKhmucXa/a2LkPHL6fsKMdM/ule4qMxd32L/NH8KWz8a6Macx9wOVhCgrAmt48jq2yfJYEZ1t8+IbCLDuJgnaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Use soft-pptable for beige_goby

v2: fix format

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c                |  3 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h         |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 ++++++++++--
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 3fd81da00ab7..94336a3cb698 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -853,6 +853,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
+		    is_support_sw_smu(adev))
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index bb55a96f98e9..83caa9a62bf2 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -34,6 +34,7 @@
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
+#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0x7
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c29d8b3131b7..16390300af4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -570,6 +570,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		sienna_cichlid_set_ppt_funcs(smu);
 		break;
 	case CHIP_ALDEBARAN:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6274cae4a065..af8f4101c523 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -63,6 +63,7 @@ MODULE_FIRMWARE("amdgpu/navi12_smc.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_smc.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_smc.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
 
 #define SMU11_VOLTAGE_SCALE 4
 
@@ -115,6 +116,9 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	case CHIP_DIMGREY_CAVEFISH:
 		chip_name = "dimgrey_cavefish";
 		break;
+	case CHIP_BEIGE_GOBY:
+		chip_name = "beige_goby";
+		break;
 	default:
 		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
 		return -EINVAL;
@@ -259,6 +263,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case CHIP_DIMGREY_CAVEFISH:
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
 		break;
+	case CHIP_BEIGE_GOBY:
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
+		break;
 	default:
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
@@ -341,7 +348,8 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
-		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
+		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
+		    adev->asic_type == CHIP_BEIGE_GOBY) {
 			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
 			case 0:
@@ -729,7 +737,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	 * display num currently
 	 */
 	if (adev->asic_type >= CHIP_NAVY_FLOUNDER &&
-	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
+	    adev->asic_type <= CHIP_BEIGE_GOBY)
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
