Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE46C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AB12389E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AB12389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E586E0E8;
	Wed,  9 Dec 2020 04:19:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06D36E0EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 04:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS9VpO5GNVPAnTwgZF7xSNtoRY9jEfUxNCssl3qpQW6J5+iLD125jWKIPH/V8KFWMBGaH0gTFtkCJ0ZXsv2pGkF9ToEklJSKrSZIt1NHpRm9H+99oM/R/YtPg2+BT3GZugXtvEAt8F6ONgSzh1aY1MZTswFneX6fbY48PTcliKXEPoblHisLXSSzFv2STXPj30AB9SBGqZbyzDuI0tXaNaZZ2bMOXUnw0TX5nTbXMoUivh80SZ/oi2SisSq7Nz6cLA2h3J+dFGwbfduE8fI1Y00mplN3IvNj8Mo22KE2Xac70g9vO/fMbLrCcEGjrN70vz47rCRn454NYEUjndISCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMEjB08y2owH3qGU7lVEPh5jLXMqmSYhcCRnmFeFIL8=;
 b=nH7W/UBpsAwo1UfEx4xtFZ8Qc+wefyehWxiC4rPvcZkOg1VGYt6ixAUe4qdFx0GLLPs9RhF8VCiBTJzpcfK9CfiLqVGqcqJku51CORvLZIA9LUYQXMRkubOBfejyTBiHEVwv8/0qYt4HmNRRfMN0zedYNNeAsshvSQHdMcgGEADRnLJg0hkK9F9dgY12ZjMZULpJzUMrC8U00pQHAFHKHkQeFBWd9V/42kqr2KYTDbWgINM6vWb0wF0bj6AzU9gptty0uqIVOm34WaKAZlPdCWsIssoavM9v+3FhPNGEdXD1MiWcABfANbzwZnvIioloBo4vUtycbi3qyYmfdCy53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMEjB08y2owH3qGU7lVEPh5jLXMqmSYhcCRnmFeFIL8=;
 b=PXw9RHfRdjeTYyWgyginxUQuKiZp9Tnb6957GN9acx0v0cdV+rVtifd2CbjZEg2q/W/aS6W59WNcaB93ekN57I0/dt12p8biVYnNNELg2Z6qDofr4L5A9aLbiYHiToK4XutKFVU4EkhEMQu6JUirg54PNphhobSkHBCqwvLjynA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 04:19:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 04:19:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amd/pm: expose the firmware_capability from
 firmware_info table
Date: Wed,  9 Dec 2020 12:18:33 +0800
Message-Id: <20201209041836.143264-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201209041836.143264-1-evan.quan@amd.com>
References: <20201209041836.143264-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 04:18:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bc95659-1b40-402c-2def-08d89bf98e90
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2505DF551FF693D550FE28C1E4CC0@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDsGp5HID/FBzi9U0rHTCyMxJM3T+Jq7ehknRXiYKVuxrXutDb10KksQ1ewFSecXh6aCzJaoVgx4t/Giiu3E8oUliTCPEf2E6tRLhG0kboq7rayFC594O9nqPYKmdb3I5y2dGQ495gxg7BErKyrq1jnu0obiJ8uTbO7kSdkRAeak4meEggiXQFSMHaXiuJVE41EuGN85TeHMjTpuwR7Pkat4KjtxuqHF0c+UbnryhKfz6OLemVW1fInnIZFO07m/xPba0akp3ENPIYOhJesqViQWslf0nXW0NXxFBvvcIXDsZKD5hKpUT6CJ+F7G6Ik1RIcuoafNqhPwbakRBDkKUar8sAOJooEbOPeH5cRphI05gRR6auniFRYnqa0ASS8z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(8936002)(7696005)(66556008)(66946007)(66476007)(52116002)(508600001)(186003)(16526019)(44832011)(6916009)(8676002)(6666004)(1076003)(36756003)(26005)(86362001)(2906002)(34490700003)(4326008)(6486002)(5660300002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ALQZo6E1lfQYT5l4QfqKhFGaY6R/McqeDjhjUf6MRBlr5evsybCtm/qLxJA0?=
 =?us-ascii?Q?A5JJaUqJmolJdwxxLHeCHIOgL3ZTC4iMQPgVMghIUjL7JFfHgO3aIiRbTYaQ?=
 =?us-ascii?Q?tbA2Ddz8t867zWgfPwZTqW8CWzHITXgqH3rHOW4NGSZwdPWJqEHOYCJBVOS4?=
 =?us-ascii?Q?TiInamPIX0qAsEtA/ZBDtk9xTV4iDH7PymZwqM2bfERcgXXECOC58xPPalKA?=
 =?us-ascii?Q?B7itKzH5kOBPikOEVSuPf5EMPizicXcZyMe8XN5g52yZe3k8mW4i4vaQCBfS?=
 =?us-ascii?Q?CQqY6PA56sDAW3P1dGd1ZUZNlNA5bsq24zG7QFMRFFuhMJ2kgxF8AVz5N4Gq?=
 =?us-ascii?Q?BD1yAa5rBTgfmpVqD4bXVa6DEtkDqPKCaTD7vkaa5pCxdA6oXml0YVB7HKAr?=
 =?us-ascii?Q?YcziHE2EVtMxS3AcSAW8JB/QB2mN7hZwFmPsMivivmvmuid6gZmBBZiLwqwv?=
 =?us-ascii?Q?jg1jPRUuTg7k6gbubgFCfkYleBMJyneRMdcZCwSPeK6AkMEv3W7gGtwfKsAx?=
 =?us-ascii?Q?1Svie001MMdozjakF/3kmhZruxF9AbqLvxhK+SMwy5zuMPNP5OHfK4Lk1hOM?=
 =?us-ascii?Q?tNTnMn+xHXIRBdqdW6Bf68Rsqsw3tP0pVokpMK0sIg9KYF8au9r/tRxEgtP4?=
 =?us-ascii?Q?3m1t+NrvfB1SIKyX4AV5ZHzUjrhN9S6uuSrZ5CoL8CmShoe5Kp3/uuJhH+Xr?=
 =?us-ascii?Q?Wwc/eOrCGJ/1Z6sCZYfSQOjEwfFNUOURgbMHiB6vg0HXSzBBDGHK7VY58FTu?=
 =?us-ascii?Q?01lqfyfgi3Dw04muKS4Ebkily4o8oR1DzHV6ePFXYKPU8ExsXRZw045utsY0?=
 =?us-ascii?Q?aI55BNwn1ZryJlVkxGQBLfDxWuzBHxH7OPNFl9uHyDbwn8tPpkwOw201bSvk?=
 =?us-ascii?Q?oCwIhXrc1anHNQeAV4dCtyVGh7IQ7xdrhwyf/380/by8EWEZ9LsNOsoIbFe2?=
 =?us-ascii?Q?pf+psWhwhSwqOGnG2vT6ikM5dg31uWzEoL+j9nCbxln98pStjBM/9lXeRHAO?=
 =?us-ascii?Q?n6gq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 04:19:01.3011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc95659-1b40-402c-2def-08d89bf98e90
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6saST86JOps45KzivGJf2lZUdmyNIU0CF5jkakGD2O3OJxr/lKyP3nD9upFi3Z7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That will help to determine whether 2ND_USB20_PORT workaround is
needed for Sienna Cichlid.

Change-Id: I3852e7c8cb11c12845ca81e7967e332c499cb470
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 971c7fe4af37..cb96466605d5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -227,6 +227,7 @@ struct smu_bios_boot_up_values
 	uint32_t			content_revision;
 	uint32_t			fclk;
 	uint32_t			lclk;
+	uint32_t			firmware_caps;
 };
 
 enum smu_table_id
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f2565eed469f..45ecd0386e9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -554,6 +554,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_1->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_1->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = 0;
+		smu->smu_table.boot_values.firmware_caps = v_3_1->firmware_capability;
 		break;
 	case 3:
 	default:
@@ -569,6 +570,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = v_3_3->pplib_pptable_id;
+		smu->smu_table.boot_values.firmware_caps = v_3_3->firmware_capability;
 	}
 
 	smu->smu_table.boot_values.format_revision = header->format_revision;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
