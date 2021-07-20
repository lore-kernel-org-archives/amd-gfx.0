Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579EAC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7B3610F7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7B3610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CD76E432;
	Tue, 20 Jul 2021 15:44:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CA46E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myhuzq8eSowvYnsXYQBsGw9avX7LAnqpPokA2h/vfdjag9Lk/RumDINpxtnYAV/axvTYLQSBBBqCwJ2zYRWy/TW/Jgo9Qr4SuQAd8x0s5D6AYammv83ieufTBRmuHR1CO93iY3wSAcwsHCzU9TATBAw6K2DFaa1bNJiFuBvF++qsPhqkas4epQLfoDCnHtcGsFCgrXcgo1qQnT2bXKz3RY3kQxkkIm9m8fVgq5Yp5FZJXdS4C/aUkCrmlmkgfA/E3Y7HuyUO+BGkmaDcQy3TSIfJ96ruieEYCvYu+Vwt2PjQEABsKJ20M4YZ6Bqi27UB+1ScUlQ4PaDc0svatguMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8HUD+JHguvsQWLAfJwBGazJCGyVS96A5+2yQZ4a71U=;
 b=KDvHq45KKUwRaWuAkdu8v44Jfr3iHWIA+Ucv8TtRwVo54YjauwPdxFRnKbjsN5jAnkNRBKkvmNK3ZcyxxRtz8fDQJuITEqYSq9WIc7but5yCIMA2j/0eNMiyUYFjRK45jn1BgGmw7rwFDHQGkdETl+IouI2MY02Tbz8ku1yDxb0PIxxSeW5liJja8iPRhC93gj2t0Uf46fboNoqvVGnK7gZUXnUBjUx+HDoy+tO1BHFBKNJFcxl4b/DbwFW0In1hnbxVlp6WldBkFMtY9QbXhcO1gG5s+OoFU8LQVnH1xNikihyy+0WG6Ujn1iedYvQqSluF534PWwa7aGwPUyplAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8HUD+JHguvsQWLAfJwBGazJCGyVS96A5+2yQZ4a71U=;
 b=FXYwWPoVQkncJyg6i/GkBkjCx2NGaXLPBqP1XxqAKzWzFMdMJhur44s35JjQOu9jPDRBH0+eXn/859YsA5tLpvVKCqvak/4WrYYZkt/XOZ6kPvh1ZPAe977EhDIkK64O1wK3i9kXoxnVuDR4UyS4ZK0h8U1fP1fbjXj3qRpjpJ8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/29] drm/amdgpu: add cyan_skillfish support in gmc v10
Date: Tue, 20 Jul 2021 11:43:30 -0400
Message-Id: <20210720154349.1599827-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8ac7ee-9b62-42ad-c87c-08d94b9538f4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288B1326C5BD450CC17DDC7F7E29@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsmT1XBCTCtvNYmnSzhzyscKiFS2ZEkOU0Ya17BNsD8lq7ixm8Oj0SwKnzupfb3EMvuJYjuISoBG9KcURKqrXWiOPPrIfhBd9DGKQrH95saSObr8roYKPbNtTqRIIcLgFkhUnZ/rE/NyrS31TSrN1j6VI9/i3V/OFv05xs8LwI1Giu8E9BFawSsJkZQtnc4ZwhmUwUwafY7hMYI61JbZFKah0jUwB2Rgsld2kVEVJJFKOlSsAHb0TLscu0jW4YsKIvjFSw82lIak0vEXHh4A7YNWfWvH0t050/jJjPKV3IJlrPh5arUqAeE/wMU2qC45UdjFjRYPzJbtHS7T/LzqdIGVqI7bFwSwcKlm5eBerS17dgmiF/WyuRwxxPP9tcwXntdwsL2MJF64yoRuKi50OX6G//wQFq1r1U6bYwrYyhn357h3lcwNVVh93mVHF1SAqrwo5jlXGQ5FokLiONFQ/w8IGmrdI3yLvBo/xlN/tbuRjzC3g+LGR9toRR+oKignlDJ8Jvi9w2hV3/J0s8LkGaFyzWgihKIKgQiikaZlFkNlRVMJvJUNnQ4i8aJDOmBuqyQBm1CbitbLLqQdbpD4A1FG2bw1uRvGU0PS1jXuEnvEBa5toN9NeJBZPqWMHUDETQbN2aqMw1bf+gQF8CFVZ+2GklUmNgFC0R4hFRktNrA/r+kX8rn8YWtWRK9NxSN+xeCYC3yhPTMzqLxRBab7hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(6666004)(66946007)(66476007)(54906003)(1076003)(86362001)(2906002)(6486002)(38350700002)(38100700002)(8936002)(316002)(478600001)(36756003)(66556008)(6916009)(26005)(186003)(5660300002)(8676002)(4326008)(956004)(52116002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GDDQzocaC89wyZa9MdDK07CEiP5QWkWpXPXn9A/+Tk7PnOecJngqz/4rsYHd?=
 =?us-ascii?Q?jcMOTPJGUC6/G3c9E/6BIuU8D+Ow00YfQ8176XwvS9aPQ/TyJ8XIuQlJTvjq?=
 =?us-ascii?Q?7+0ctp2m9X6gFt22YO5sPeIG0QsDJQiRdMUVBOAxhpu2XSq6wuXUnleVUgYQ?=
 =?us-ascii?Q?CDrDdJu0B1nOBbiHDoinrwOxPMXzTNL8Y2gUaw4M0Rd7J+iCMeIcn9MgfN4r?=
 =?us-ascii?Q?hs/C4Vfhv6Z0HuewoCT8kzIEdia9xLd7Ae4BKmrjakG+L1/K8X4mIWRwXOzF?=
 =?us-ascii?Q?oQTtMjNX6X4/RibZ44cjQ+w0/Dz7Sb7deWm/s6zF9UDckFtHY3vyBewvtYeO?=
 =?us-ascii?Q?yjv48+Nh9lXWvW6rI54alO+Uw1W1SYzMvOTAN+suVD8n57F5ZnY+xnvnL/og?=
 =?us-ascii?Q?0szPJQAoaCE9IYd8BXspj5YjT4wfEn+N+g4JyXHt/SELD1hWmbuCtEDga1Ss?=
 =?us-ascii?Q?5Hxd5DTEE6ub4Gjdkw5UZSt02XseLbTyulCj+x/qN8A4E5jAAG3FT6ehrc3Q?=
 =?us-ascii?Q?5r7xE7nMaHk/NQCluOKCpa6AqOCrxWD1EDg2DlfNipqYq32hGNMwDgyDShXz?=
 =?us-ascii?Q?CP1sz8GZZ7YDT2+EqRaZfacxbYpg9gSzFidZxH09Rf+NY8OO0ev2DoukrV5v?=
 =?us-ascii?Q?uQLVBPd3yi3gYjjC/L/kcWFdTiTwIJs/D2FWgIFbMZ8chzMI8g3Nb1qhxQsE?=
 =?us-ascii?Q?lC5wED/QFgKgOT1joqGW9ZFJlCnyPhxEK3MNDzPfGSBrcCewCu0Am4t2bl+U?=
 =?us-ascii?Q?uYOeyibfhzWIzmN2hfX6rSJ8v7jkBifVnstk7Sv7MFRhZwCXy8jSEpl/aaqa?=
 =?us-ascii?Q?y4Pa7NtHLi+r407lRpUnQOoz6EovR9Qo24rA26WbZHvey8gdBNOOmn4jXX1/?=
 =?us-ascii?Q?rJqiNdaF3Dgg45abknYlt9XB/FaoDUBz2TSS9a58+plp9h3dRVMwKzPeYs7x?=
 =?us-ascii?Q?yNzJvCnIqjsJ52F673SBVb76zJNd4rXLUYfyH9G0OLGlq7Sp9YPRteEVElgQ?=
 =?us-ascii?Q?D6RHlqYIw7bD2zWVTgzsfnGkSritFTKKakjlm4h1TC6CjQ1NzmSOJzdDDvGR?=
 =?us-ascii?Q?WT9OU8HXOtvnbC6Y1O5QNn7gL/5od2HHGTMzuMTOcO2N/1leHmUYQXBf6taP?=
 =?us-ascii?Q?WhwiDIH0fwN+LdA5L4JOcd7P4xd82LP57kSp3rMPvKzeVTjXnfbd/Jx/J5z1?=
 =?us-ascii?Q?XZjUFY28GCzs6cNitXip0hFoRrc35+UjxC/Hrq7S/zc3NuCMaMVXMSTH6O/8?=
 =?us-ascii?Q?FH41EsdEmOADxFP/CMiCmtXeb4yz8Jc4vCOXrzxOt5ONfRDzLQsSn4gwuESJ?=
 =?us-ascii?Q?OGJTzkolnk0LtcRIy7IqMtXV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8ac7ee-9b62-42ad-c87c-08d94b9538f4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:12.9931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSxRMF1qbNPlOpuPlHX62wLtXk1k+ou3WPbmR/UO6HgCMLAK8aqi77dOzqMEYxTAX0UDoqCRw6SC0IuNVdSnQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add gmc support for cyan_skillfish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a3dc730eca4e..1bcc69fec11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -810,6 +810,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_DIMGREY_CAVEFISH:
 		case CHIP_BEIGE_GOBY:
 		case CHIP_YELLOW_CARP:
+		case CHIP_CYAN_SKILLFISH:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -879,6 +880,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -997,6 +999,7 @@ static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		break;
 	default:
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
