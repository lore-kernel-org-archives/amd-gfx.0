Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F808C47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E477C61C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E477C61C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59EC6ED65;
	Wed,  2 Jun 2021 16:49:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C1D6ED1E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSnGPSHqBU3SjI24m4N+27FOWszOGj7F5gWFhzyx6Lke6dfxlFJFU+HOj5kKLs5qbRtO7zZgVenm6gvStk/9vgYdiOS9nCIwoVm7NCSX0Ze6UdovDOoJdO53ylCkLQdSfTJM2mV5ymnBth4Umaqeydmju1k1MYfUnmU0ONcQ2voAbGVEY1DlLeQ46al+yl998Cptg87PMPvunKuDpuZ0VfEvtY0rUOGEmggXB6m80zgSHdwpqp4YLcX81xoEf60AMvFaxunRXtagGM4cqwFGYVN5ZOIj6z7egZpSb9OaBoR3CaPLu6Sej3kuoxXl+aB4JfnFth+t1geVCtZzrBLeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVR+PEcsIswD1MnzaqtTZ4A9RoMZO/TsL4UdIywOKgU=;
 b=NVz8nfasgN/S5rDKX8timX6bWPY3YPojZaBH14UkgXy8gLyOIM/28TaK5t5DiXXEz4nwt7v3ezAMjVrquw3+PN+G31c4qW/aW6HlW9dO9ttr/9+lDMIJWtI7Ij5vr3bjyPxkXxnZYWPswck5Wi0D7be9Duz3QkwM0sOcRla2D8RjWK7S85pF6clAmoS4ptp4BCtCmiUSFoFCJ6CfFQeGJom6np66/x4XzBaJez7ZX4eAngANSh2UWC7Gc9EgaC2quwxmfwa5RQrVsWnspF5PkQUY/5JRb28b78jWvoQ0bai+0IvFRoNWtl3lrrl02zh8yVs6kCpXx++IH1yMm/ZHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVR+PEcsIswD1MnzaqtTZ4A9RoMZO/TsL4UdIywOKgU=;
 b=cc9qNsGy+meEcIXmDOWwDn1yGP1x+6fYUc1RUMVvH+E6pDM7oXgf45eBS2+qkgd+Xb0KM4KUkmXvBIKJChf4nHw9bPXYr36a2XXfj4mOqcHqsAmn4lgSLZLtvAQkn40gl4lX2jqusvtnqJOrNlLgipSnFnMX2n2TY1OnXXLEato=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/89] drm/amdgpu: add gmc v10 supports for yellow carp
Date: Wed,  2 Jun 2021 12:47:47 -0400
Message-Id: <20210602164908.2848791-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 685de119-baa8-4b74-eee8-08d925e665f0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40774AF505621E582397A280F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sk3JFzLJXidIK37ka6uwra13a1UxEljADcCVFX+FTRVU+PLz3vwAzTYrrMgJ3Az3zoV8+tf4XbPBYL9kbElpa012PgZzz8ilPEmGW/c2WcceadXfDB0X8pfw4atMpHsxOBT3jgUCxIaEO5hR7U8f0CdB7qsVZyAYyMllb7U9f6zA8s6qfJrqjVJaix79Mqctuu0IsmuTeBaV4KBR+BJoIzFU8g7ouNlpafoBCF0c8Mdy+TVyach6QgMwDC4rs64G73bKObz6yznkuy+llN6v5UhY+Z8L79L0TL28cIySXh1ZZ8i4zwpmCbbK92M7UsHmvo/tSAqVy+p67t2CijePIGPt+KVLvusEhzDB2p6zyWdxZR/HSE6zvrj9+5WV+b1CebglxMLc0EfaLu449TNVZCcVQquhbZkMj9/CLwCXHoWkBLNDIMQHMW/sAGBSCGCqlS93zz6jvBLNpW0maN1x7xyc81AqaRB0bitBAOmLhJrpOOmFBAYdomyrYHkUqNA2BPVrYYuxU18F0tSgHtg78pVFeDfzNPzPmReW0t1GkBN1X30EQlu1wx64FcBpePFLfOoUd4TApav4zaidLcnmYMt0YXmj7z7YycoTK9DZzDNOimN/40RxHaQ2aJX5kGgrMoE1MmQUq/eghqdNv9b4nMUaXbMby2+lmUYjXnf4Vp2+6vt4aVRkT3Re86Kmtd02
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pJB8NPIfmMMd4SUbu+dnaBSbG72gfBhvS/2f+mjxH/YJwF/EdvkUp79yEiBD?=
 =?us-ascii?Q?2QV869jLtofv95cI8ykpyCrSu6rYAhGhSx6CUq7p3ESScfQFdyMM3WBX9VNO?=
 =?us-ascii?Q?Vm0hxBQLFlnJD4A/+b3xw5x38QB725hNiry7YNv+I7iMbC6gTebpmSAHnX8b?=
 =?us-ascii?Q?jNHEiEWD587lIV1H5H4JjeLgAOvLX36IJjmvJD+UHpNF1J/arj4avcHlb5S1?=
 =?us-ascii?Q?wm6zG0GqVNo452IVX0Rgs5h2iDr2HKuYRBpBX1fkbWQY/Zz6ucReGkydnY7W?=
 =?us-ascii?Q?RFnlMPyoH0qQkku5g15OV/dIVQnykzKOZvzmXFEALcKsYWqAnL112eL/mG4z?=
 =?us-ascii?Q?Wgqw3a7lvfp7xEanQChgMfq4ZHRTqtRVq0khVyUpoJ4btL0mnAyO1rtmt70m?=
 =?us-ascii?Q?ZN0fRwbHqDeL0rZ35dgdrcXG7wdTC9lPhKgfHsxUZ8Fx3fYLpf0JcMoqppB3?=
 =?us-ascii?Q?tVaYOihWq7UcCsrpkN35bB+UHL7MrrKxngmf0sGUnvxax9RpE/Qc0KEzAvf4?=
 =?us-ascii?Q?CE8/xU1oi/2mQv2isDQczEZUYNpCA+LUtsys/rbzQ60Ub/pwfjQw4cYW4ceC?=
 =?us-ascii?Q?oqB0DBn5KTzeI87slhIq10F2rze31pPoSos6j/K5XeW25+StqDFNgirIvGVA?=
 =?us-ascii?Q?5zoqFL+GM8c4xq6UjVBI953mfZLPNeEFwFKSkJ6Uu3+OdIKkEnPWDrosxugN?=
 =?us-ascii?Q?/P9v39vYFj/Pun6HyNXpnsrN1SwBoF2wATALfhB3jOp4A9EJTTQpiZMfQ92s?=
 =?us-ascii?Q?PmYKD2mchl7oReZZcyaq/SZKkeyMXv9IsEMxw7FaJTJMTTGdDxhmv+vjZh06?=
 =?us-ascii?Q?kuWrIDDN5tWfw87FGn86DHZ0kIaI6CiETD5j9c/UuugGbd54MAv4qQFsWDer?=
 =?us-ascii?Q?pPkcLtnkvkPX8Goi+hDy+1x+zVQE64Ww8e7paw0l0VEU2zIaagk6NGoLOQSl?=
 =?us-ascii?Q?DgWMEFCFr8kH5ArW22I1z6UnRR2DFFjdsN/Dd6U4IopF/dU1WtsKQ7WAMUzO?=
 =?us-ascii?Q?1NDAhMTNqGdCiLO7mcfR/njhJ+TdUTBK+uC0UO2+pWYpurJQ48iymAwR3L1O?=
 =?us-ascii?Q?rUeQyV0632KjxDk+m0y3OiVoj9Lb5xiMPDbvkIZmMX2gaaDPnLLJ4xfyjnNc?=
 =?us-ascii?Q?2WeLkhl4z7UNM4toou9rWs156BmWTu39QqW9bGBGDc2FXL530eLCMt08O7C8?=
 =?us-ascii?Q?LGFFh99YuJMRFZVYffTu3RP2VaajOtdxmu0D9aw3PdYgNJhYKWZnSbl0g3cl?=
 =?us-ascii?Q?SriFRpuBnpCZb4kExBSOiP5Wi3LAmMIn9l7qnMXOgazu7ECufDZbbPoTlN1/?=
 =?us-ascii?Q?54CK7kf6oVVXG9OzzQE7Onjr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685de119-baa8-4b74-eee8-08d925e665f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:33.4740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur7wyqRgsGU0UJiRh6F3P2KUdJE1ZFiU9MNLsXaC0KrV2B35T6/VJrIdk7hypkgjajOYM0TprZO9KeJ/TeYU1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add gfx memory controller support for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ceab5ef50790..e9fc8d21f3d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -675,6 +675,7 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		adev->mmhub.funcs = &mmhub_v2_3_funcs;
 		break;
 	default:
@@ -691,6 +692,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
 		break;
 	default:
@@ -807,6 +809,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_VANGOGH:
 		case CHIP_DIMGREY_CAVEFISH:
 		case CHIP_BEIGE_GOBY:
+		case CHIP_YELLOW_CARP:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -875,6 +878,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -991,6 +995,7 @@ static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		break;
 	default:
 		break;
@@ -1146,7 +1151,7 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 		return r;
 
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
+	    adev->asic_type <= CHIP_YELLOW_CARP)
 		return athub_v2_1_set_clockgating(adev, state);
 	else
 		return athub_v2_0_set_clockgating(adev, state);
@@ -1159,7 +1164,7 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
+	    adev->asic_type <= CHIP_YELLOW_CARP)
 		athub_v2_1_get_clockgating(adev, flags);
 	else
 		athub_v2_0_get_clockgating(adev, flags);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
