Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747DC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8114E61417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8114E61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3975D6EC5E;
	Wed, 12 May 2021 17:31:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720986EC62
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gen4dh2QegWL4ae1ZlfBOw1QWDIF66HEzcZEEB4mr1MRD+lGZ2bRUZ3eKIszDtFFvUBUZUUEcHlN+4ze37sDU2rdJRcw+5RdioepZ/1Wv+d8GQDQTYhUepLZPSLvEjcO18MDnSuVlTph7Bz3zo2jvVYK51WQTR2YTpgIYe/hxshuUvZtDfKuwec1DbZQardjPHBunyUZeLcLuWB77uc2jwW+EwEiUHhbDPDZZHHYBnnEuUtkFe558cPF9DniLS6oywA3u1DPgFnYSsE2ofYMPk+5RVwrwfYluxHN6zCAVFXUm9DTIP2vzoBiTMX3Bxuuj+OALvTjs7EH7WmSjOWtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6j2bre9hhkVjJoO5HSvc8+nLz88xsURfwTUojXLBbU=;
 b=HUhmac0RdCpUbxXjq8um79CSLadT5/iMY/EdeLuMyzF6j78ZD9HsbEJuPkEYIe0z8OV0l/uXZPJdITD7JvWGOnDZJ9/J44zJ2EjQ2RWNW0+NsNINEcN0ywXrzogA7odRcXcd5LZx4o8VUQaVMuiKT+PRCKzFBGgoFA7G3FR2y+DKNPtoZx990B87HDSe/2VhaWsSf4Aq7WBxlQ0x2ofcKq9OMKm+A/eWDheeAHORTlOJCo8hv9KGwn31Dhfy8ZSwsHlDTbebEzajDBvDhYthjoapWT0WzsOfqXdY2UR+pBC72znT1eMw9tnu14WCmbR1u6SABKMW59qrvvD9zVEf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6j2bre9hhkVjJoO5HSvc8+nLz88xsURfwTUojXLBbU=;
 b=n2qQ0T/hzXUibZGDDXcTvbDejjDxLxibttH4i7mYA9FFDXdoWyuL7l8E8K/571ON8inUWDttS8XUhxLjUdehs9lhKMqsjZeEOjU6L7DdToRcLBZxIwS1CifZb+cTWzrgUdyc42PGuIqU8kpsK7a/sIOcjsaCr60RMRiOeg0d8J8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:31:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/49] drm/amd/amdgpu: configure beige_goby gfx according to
 gfx 10.3's definition
Date: Wed, 12 May 2021 13:30:19 -0400
Message-Id: <20210512173053.2347842-15-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 976bd9b4-4eee-4588-42e5-08d9156bc2b6
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564A38805DAA6F5A41B6FF5F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxeH0aJjmT/cz4YDZPEbJo5PtowhPRVNXWcfw2jI1p8gdgz9psjNvDo+QLPtcPZCMGX0HDGzp7Wu0oio+0NxQgPTu3SvtTra6t2ADMsF+CSR2t8L6YKppwtbURw4uyx+4qfF90xbVQDy68JU0xP7UOkwyAeeekqo3mlrkScQTi0hStSYnhD9xGcVykDMiAngd8cDRdAtolJtRs5/TzdsVAreKpQLRWaNHPAhJrw+pFf+/F0QF3+1S9a3uCUHsQ3nWHuG+gnoQY9V7BH9YAmfZAC/q3oOD86uVXe1YIMP+0yLkawSxjc5bw5p/2Dpk8M0kO7yQe4rXx1gq1IxPksy4UKk5PodXq2e4HIveYKYveZMmlLcXe3gOU3KZm++O8y7C7xJn4GRk88/dD/id7yQ68UbbkkdBZPEANFQP8bjvTdXey3/Qa1ZeWOHJXKU3u3ePc4ZDVZDpWsGN0IHP0z/2CEHoLqCoRlqm9x/E0nrzFliF4B4o+ctqJDNvvPywsp1UBM87U77aLUXPzet11wVRoDrl08EoYW6vKiDHrzRJHAS/D+ub1JvDcv6DTAVv5KrS0Nci9WD9ldL5PpSFGgZg55KQvYuRVKltXRC7we0kswoffXksyOlGBw7nPdWLxrtq+DfmYFeepLo6ALUy9zZU3kRnfbZjxP4YKlhtpkoiTsfa88HBzhGmG11FXjUuwVE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(186003)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(6512007)(498600001)(36756003)(4326008)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TJ+2Pn6OI+E30hNrF6KlrFJ9Ku9IQursN3p9OwAAEAj9n0xj6MRPsD/ZAiZ4?=
 =?us-ascii?Q?mWd7q4d9RjYLaHEkxRV72rWlsBH1YRqcDxP580Ckx8WoTrFeVjXZkvfcR6a0?=
 =?us-ascii?Q?yItW02davA0HvJhr7KBd80J2hp0OZt+X20A40IiC2+9X8ZFeuCcbgV4US+Pr?=
 =?us-ascii?Q?RsaKs6VxAVIcXMC2BQOdDGepTsLTFNUcW7zJ3eADfPi4LkL3R4owPK8q01y8?=
 =?us-ascii?Q?fgh5KMKFqJPT5bNDh4sLdvw/D3uAlJ2T+0+qfPXzS+F4rw0ekjoXNnNOr9Hk?=
 =?us-ascii?Q?anDVSa7Jo7H7AuknKknuttS41nmvG7TzQPlh4rooGSwzGYlb4FLyyj0dvwmj?=
 =?us-ascii?Q?LQ994PmUJJfP7X3pjEdKWTtj9islXc2klNeVIIENpoBtBQ1BqxR18VGI/G1Z?=
 =?us-ascii?Q?5JkM6/Mp+ePFivp6/pGZMK7L1IVi2duZ9zEaxIWO3I8Ndxa0LCgoNa00oZcU?=
 =?us-ascii?Q?OQS1/go6u+NVIygSYc1SSsBX9Ba1TurmxvSdYD4Qkq5qkHIZm8aXzC6TyMuz?=
 =?us-ascii?Q?KKDgUYlqi9AgJE1fZ5h5snfNNrzQY153+lunaYDOPh6DCuF3KzETmeN263AV?=
 =?us-ascii?Q?H3lHgBfwDxTRscfT89dJxmdclEnYicUb8Dpi0tJpo7UOJ03IARytzz/AZgtN?=
 =?us-ascii?Q?fTgyJqxBkeZc94XHjD/I4mi5UjVWAAXxFVQ+5Www20cUl3KC4bktv5LT78rP?=
 =?us-ascii?Q?9pUPtAFwzDpgFswokLROgziufRTbgm7hwwIMFL4SIL9h1e6t/L8NsSd7Iiaq?=
 =?us-ascii?Q?SxCvtAwBtbl5GGn8TsPLct7G8BYCW+HAn+bxyoin67QvoWlcn6AOokFEWY3j?=
 =?us-ascii?Q?vpqXoAlzV6H+V/0wwp1EYIEDfu5RxI8mSxeQOta6KUknyYR87W9mddxiAw5M?=
 =?us-ascii?Q?0iPeyncEV2WFqOKyLe61t2PN1/dAFGhBN88qxt/zhvOkzZdQaOfsdPvpO8T3?=
 =?us-ascii?Q?J3FOfnCtsmTeHC/MZHwlmcqZAdrs6ha9KnTwgmkRJXEO8E/NnDQRZAxsu0+v?=
 =?us-ascii?Q?zQWvID+izz152ew4v+gre5q2ZPkSYRul3FhpiZIeJ3J0Rv4kKLP7AeuQptIF?=
 =?us-ascii?Q?3YUna6b6eSCPV+JQnkIh597J/d4MdWqRTS24nkqzwNaBIQvfFRTXyeMqgNRi?=
 =?us-ascii?Q?rG2Z13kT8ajhqcKY1V5QUKOlgD3zaWbn2NIsfsyPAXeuTO0B18efU1avWFHL?=
 =?us-ascii?Q?sLTntQS3LzY55C5qJ9tx5Un24vMPEle6YbyZBrhFhaOkflfHh6YLNtlgFS9l?=
 =?us-ascii?Q?jJw3SNP2KRUjVkCHpCtwM/37+eDpebxZobci1tB2D+40wk+F0QFy97AK4Ecz?=
 =?us-ascii?Q?ZjA1TycbVuYMyWfkVka8SDZa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976bd9b4-4eee-4588-42e5-08d9156bc2b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:22.4623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJyCNSVSXV4uW03rDUDCHAhqP23BwkG/CTk606dVxt4fUOiMf+lLXoJO2uliztwO+zEAqT7Agp5lq2FmuGh+gw==
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

The gfx version of beige_goby is 10.3,
identical to sienna_cichlid,
follow the way of sienna_cichlid

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 408691ad100d..771d8af4dd04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6139,6 +6139,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
 				    DOORBELL_RANGE_LOWER_Sienna_Cichlid, ring->doorbell_index);
 		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
@@ -6274,6 +6275,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case CHIP_NAVY_FLOUNDER:
 		case CHIP_VANGOGH:
 		case CHIP_DIMGREY_CAVEFISH:
+		case CHIP_BEIGE_GOBY:
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
 			break;
 		default:
@@ -6286,6 +6288,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case CHIP_NAVY_FLOUNDER:
 		case CHIP_VANGOGH:
 		case CHIP_DIMGREY_CAVEFISH:
+		case CHIP_BEIGE_GOBY:
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid,
 				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
@@ -6382,6 +6385,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
@@ -7096,6 +7100,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid);
 		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, 0);
 		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
@@ -7139,6 +7144,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
@@ -7448,6 +7454,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY_Sienna_Cichlid))
 			grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
 							GRBM_SOFT_RESET,
@@ -7614,6 +7621,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 
 		/* wait for RLC_SAFE_MODE */
@@ -7648,6 +7656,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
