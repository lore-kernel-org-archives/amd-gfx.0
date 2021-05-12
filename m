Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF0C43140
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9376E61420
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9376E61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843A66EC65;
	Wed, 12 May 2021 17:31:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488C06EC61
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpzFnbLqb1LstLHRpLlkt3YsHdrYYZMvQogtyvupi6Wede9EHKDMuNEPP/OwsX4Il0wqqT9YyV7gb/+hRqW260YEJceOMxIOs5my2YMrVjA82eE1Oy8fnCgnUMb81CpbzNLH6fNgyE68aTlEw0BDi4yc8T9osvlSIRVS2N5PlTIxHSkjhARY0fZXQ9XWYPIBzYOawLUzAPAb3nHbqf6nAc7T3zPhK+Hd+MZkTQHShpc7gWGvWE7iE5m4Mta+WEWSEiMS78Tq3ep9CJvLHcPDzHaJyEoDnYKA6M01AOPiqfzD6BAs16bO+PaLcvyaNyzdTASRJxcu2aj5ZamOY3MUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsKOYSGjRp0+aYwAcaqbzhmQa/Oi2c4W0IFXl9a+deM=;
 b=ZydyjjBWA+sFBi1l6ahdTWoiKjmW+QcD87Ct53pe83vRXnQ3XozSL5z912KP7sOdLLIG44ustzHd4O0al/D9x7ySCUSLCRGsG6J114QOyYBzU320k2FPjUwAUpzkwQ04dHmyqeAmSusmcRUHufauuv5Qr6RyJsH9wOr1inqMDszB50HAdCSTPV9FjcmGdILpIs7bkruBGXhv3kk3/zfbXsmHYb1wWSpW/kB1UWv7ZLTp74s5Bulj8/o98kOWutR5xdIT2r4gFkROMISa3uIb3ilrem66nrTYjHvAF/R+N4E9YZzgUXOZzESyDO6GatqbJ2QIvn4RYc62+bcpVLBxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsKOYSGjRp0+aYwAcaqbzhmQa/Oi2c4W0IFXl9a+deM=;
 b=rr/w4ZE+f4xWxKmkcGeTLRN8LsLL0A+Tulrqkp5CO0Xm6HuM5t65VpyIyy53D0LAIAuNLX0jWJD7EG4WF8aybAWiQj/a8vZHIpJeQMUbqRfd/gto7JGxYLqUExN0fF9D0Z6zBDUy41bbjzlFe04pBQElRc3cfcn/vdIdjIoQf+c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:31:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/49] drm/amd/amdgpu: add sdma ip block for beige_goby
Date: Wed, 12 May 2021 13:30:18 -0400
Message-Id: <20210512173053.2347842-14-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39540948-e2c5-47db-0e86-08d9156bc253
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564A728DC991324C88886C2F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EasvxGK3vInUzC9Ym0Jvj2GLoj8EnHqaNyLfJn12t4FsfPIB0T1CLmMXE/YZvnvwFYZPCEJvJ1ijTownKRx2/xOWRTa79eCZSxITgSwlOlBAtLwxKuzoeWCXVJVedfZz8LmpOAJuNXIfH2KwyEzYHq59t8/L7txO9y45KYevhUV6rRoZSlrGX80rl7RE+Z/9LfOp0WlCC06YBSnaonTyFFraYsNogsTEOQx0Y7ESX3fr1VOQOSu+dkc/q3Xk6xYeFSXgjbSwSkiiwDAkjyHO8Ao+weKCvyTelveW4BvVu919pDJj/HpGcd2TxMyYeqcxKgEJ7cGBHWE2JbJrxi5aG8UL9DSff11e4N6TWx6RWfAHXwgwlYDTOlKrr1qSTKm8k1QhhnOnXrMiPTszTJsuyLaWA0KL3AjoSib5SZYF9tGTDinCcFGosGftfQgPX3sEz8SOqBTAyIW8i+k1SmaP3LNO1q1SWvwsTOVZZshpVnHFUZ5cSaMOuon/M577iL0GOUla9HZ0Py6SBPlxRJLeNKmHq1sOfHSd02IhLRqp8d3ccVpFXi6isfmCSKlEly3GIOEDFQl+guJkxxtLcRXwVRS92mdCQSJpHOMgxFtG9fSCyJ7Ip5cV/Sf8UMuqZ+wnDswPrXaWI6Oy3f1ZumLKj0+p7I2AULPWQRxHFhh4Yl7+P7P4Il+V4Y/GIHvfDXp3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(2906002)(6486002)(1076003)(6666004)(66556008)(54906003)(83380400001)(186003)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(6512007)(498600001)(36756003)(4326008)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zzywsNd1uphdkJrwm6s4b6Esr52XOe1lX2k2IEy4mmlfom2X74rvlB1tYT0A?=
 =?us-ascii?Q?RKMGD15q7cnfslpvsBWcXIv9wrecuuUi4TH7UGbFcFMVzOquFCav8FppN4TY?=
 =?us-ascii?Q?i0rboFlQ/Tj50vDf6EGyZFXexOzF9sKmBLsk1enxgYeRx2EpuEXK//4mXvU7?=
 =?us-ascii?Q?l1pr0ASjZlnf7QLeHPMI6zGVpmiRBA7cCPvnV8fhsd1z9AWXVEBhFgbZSxbA?=
 =?us-ascii?Q?Xw3XLuFsQqD6UJQyK2+pZPH3yWCy9aIsj6bG/3kcfncX+nIRZTGeZuXmKXjV?=
 =?us-ascii?Q?vUmeZZ6wAP+VXTTCWfefkmcE3Hhcnxkvk/gqdurzmEDu7v8HINtqvR0SM5m8?=
 =?us-ascii?Q?7uYv8hbAQjGd+lj6d3FN+9Cd2MU3M56+hAQAAUCrr4+tgvJveyn//WRRiD7F?=
 =?us-ascii?Q?5xCUfTIDPuP3vOOxD8PCLYB7MbJhekYYGDq3AcHmkYZjP0MwITeYP/0xkuAt?=
 =?us-ascii?Q?5SuV98T+8okqyn029Mm8rIYhXuGlc2SJDtOj6t5QFcuvuimAcLuAEF67f1cp?=
 =?us-ascii?Q?8ZPXDUFjDGqom7r+K7wOrVvWbrdp74jA0SsE2OvqzE4e4bW4ZKV0xRELJV9U?=
 =?us-ascii?Q?qKPhOSoau/LleeydvuyhI9XMZn0m7cptxWnHZXZGDAY1Sm/rIrDHJ9rhTRqo?=
 =?us-ascii?Q?ULfi16mY4hT2XwQO5ujHeKPyxGAs6yCqejr3SjPpyHJ6x1iNNO8AlZx3aPRf?=
 =?us-ascii?Q?gr/XfStrc8C5jrHs4ksiH+zLGoHPExWNTXy3uEZWZsDlOM0i2mNQYWgvVizY?=
 =?us-ascii?Q?h8p9OPrpXwnm0UEejjlDY+BUxvJ1krR9sx1kacZrWpC8WtLrCUEt068o3PWP?=
 =?us-ascii?Q?bEu2f48UO8aVmxQZMKc80JxkAvPHLfw5XO6Twfo+SyUNTAk8CdcNjAOzhlLY?=
 =?us-ascii?Q?MRuC89VCBK584NO12LcEnud049uat+vABFXceF+AhPYneIhcRIfFECFxtbDo?=
 =?us-ascii?Q?eOH7/UN7Ty+CpjSsR4xLKk/xgI4L6LEo5/fmUiN6lxZ38WKfd+WEDLjMT+O5?=
 =?us-ascii?Q?zFxalxAeqvgS0tgwV6ufprwFtdDo+3bdG7oi35HBrm68Mp2VszELQFYwXHDc?=
 =?us-ascii?Q?7lb3NhQ6/k7Rz68YBZ7t+ttouw0FLVB0UR27vE7gI8DUT0oikjDBgEfkadjq?=
 =?us-ascii?Q?vKhHyyywd0Wa+hfY4dgQRtbj8/vdFhkIO6xPc43N5S2ymL75XEpCAVh7PSgg?=
 =?us-ascii?Q?Qs1ZkxKx8l1dipz76cqP+YWgUXZg2P8wyA8wcxdcsy1G6m/VtMSTJfJRzDf3?=
 =?us-ascii?Q?sPZKbm+uLZFiHSqeSl8Zj0MheUpxPiH1Ixyq4qHqZK6frYZuUimPRT3Q7wvn?=
 =?us-ascii?Q?VuNSGzS2bLYNeF/twgwUpZgf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39540948-e2c5-47db-0e86-08d9156bc253
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:21.6737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcRyKF+0kKT2RzQrSVg0EDT+XjBeIH03U80hnauNLmBhyTJ0dF+cEExhhrL5nCB0rC9CpxtEqlfP9cGFi5r4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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

Enable sdma block for beige_goby, same as sienna_cichlid

v2: share the same setting of sdma instance num with vangogh

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 224b2add60ad..2966775d4663 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -850,6 +850,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 7c4e0586e26d..0c93361ac9c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -47,6 +47,7 @@
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sdma.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sdma.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_sdma.bin");
 
 MODULE_FIRMWARE("amdgpu/vangogh_sdma.bin");
 
@@ -92,6 +93,7 @@ static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		break;
 	default:
 		break;
@@ -163,6 +165,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		chip_name = "dimgrey_cavefish";
 		break;
+	case CHIP_BEIGE_GOBY:
+		chip_name = "beige_goby";
+		break;
 	default:
 		BUG();
 	}
@@ -1228,6 +1233,7 @@ static int sdma_v5_2_early_init(void *handle)
 		adev->sdma.num_instances = 2;
 		break;
 	case CHIP_VANGOGH:
+	case CHIP_BEIGE_GOBY:
 		adev->sdma.num_instances = 1;
 		break;
 	default:
@@ -1628,6 +1634,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
