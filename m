Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C3C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 02:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9A061056
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 02:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E9A061056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F4889DD5;
	Tue, 10 Aug 2021 02:05:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79ED589DD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 02:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP12pQQMuuMz35fNoErJmAbC8gLhGKHvy8D5BkOHI3Z38ZajfJejkbagW+JnXsN1Cdg4QUJNJyGPsDYwE1dOKxpCaUWfxapCc/K2WPggOrSswKovIHZcbY+kBvt314pZqCctrrOjdmwSLFcFBfenCboRuDtTr//0ZXYuKOS5sRFy1zhHPaCwcDQGUSf1eayhq0AzhorR0OMRRmr67IkbwTgjLWrr78c1MSkFFViOezuYbdD/EyLc9Otno25YvmWZ/83jM7ok5AIHT3Rsle0HvHQoNUTpkqbHRmMJ1h4HZrMiHkcu/wFqikNyOSmhuUIrO6NjlIovGwPGbLhHcdlfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvh7tkNIddqoKG4yymVD6Ytqa6CoXGa/PpwDl+ALpWg=;
 b=PEAsBIntX3R5y0kDAYj2v1XBYhibjhNjcbDDjso/q7BA3dsRAVS9G2d7m+EqhbwhnNsU3br9AgMxxxCe0wMJtHWn65q+H81r9gNcCcl/iiQ6rWamI72MZtGmYVwk7SFXVMV2gM5D9VqX59SK+1Qf8QQexpv9jmPi0skpceZcc7i+16irJ1iYUDGvITL2CLNlzN+QqlJ0owiL00WIEGKC6pUQvaadt/qAS2FQQy12GzRjQdeanRGYnKA8aXCIFnmXbTRAxRtxg0ThnazTh08KAmIMEiIQyTMV/O6ZYq9pE/yDHHX/oW2Rmq3zNFvXXz6KKlVKMiwkfBkHYbDgOOkcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvh7tkNIddqoKG4yymVD6Ytqa6CoXGa/PpwDl+ALpWg=;
 b=Vs6MjG3glXhIbxDW46J1CUMfvIqFO3Lmx8Sdfvrxt9WIRXu1leDDVg8BlCcPz2MZjV1ad/kIWh+giZZJk4CvtddNGrUCQSlgVPjar7bFU2tjCABtuAMTdvQiDclHJPXyUD7vP7p81aj26kYs7i77mYKC+Musz+VtDBNy4jsWj9w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 02:04:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 02:04:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	James Zhu <James.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: handle VCN instances when harvesting
Date: Mon,  9 Aug 2021 22:04:41 -0400
Message-Id: <20210810020441.995996-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 02:04:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ffeed5-64c4-4e81-6d0f-08d95ba34107
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128689CE41A74E4E8C7D663F7F79@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L013YKfRz3LNq2snOkKbFv/JnBQbR7r7E2Aw5ZY2FoCkd0NnS2Jv95kaY4N6IQuyNMoRoEr7nQgqWmQ1vHxEqvC/TdTv5VWXYROI1FNd78y6aWPqG2OVGRCgw7zl6PPPWkRF2RkbUifce3ZggoBAmwjj8+GO56Ru7vfFa2TsxkssFAwrN/y3Y7/XVSxDiLU3wjrI6ROYqucenz9SDdwBU2N46ZGl12Ron4QT6HuZDtl18zHg0ATw825UR/F8Gfiqzjxc6egNeWbaXLmPwnQT2tq1wQAaHFFRb+Czv0z7I3s5na7MBlEl1DcMGwY/RHBPyaZfMFj0G/ktLC4mHB575VH/CGAssg8H3YZ6mPpBPOcQ6ZDwQn9AMx4nX+zngpXPh76Gri+S+h5ugNfLuVK+o2uD9zIIHZdRIilKkIYZQfUQ2Ts3xF43rVue0qa7NDc6f0n5/ExIdbVi1kasfw94e+t8IiLfJZkcYiJq0L1Pu+yYJ+U01/9GMpTgPVgV9Wn5FjuWGZEcO1jqw5jai7huwyoid9793R6no8UjN3Q7CrlxECT9janAQ/jJpdhg1pz4caDzk0XDShNJ06rG0duZi4F2fsN8T9muAfdZ4f22laUdnLYgOFGIcKeK7amDtZOqbD170ixX93eDuD82C+uUuEa5a9h36B1RZcv2EZFwUkK+wzgNxLkHwtFV0Ga0wKg5UVjxTwkFfLcUnBsSR/kFyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(316002)(478600001)(6916009)(83380400001)(54906003)(4326008)(8936002)(66556008)(38100700002)(86362001)(5660300002)(66946007)(38350700002)(966005)(66476007)(186003)(52116002)(7696005)(6486002)(2906002)(6666004)(1076003)(36756003)(8676002)(956004)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLZUvzfEQ0AB2p3sGDdaKc528L7jvh1c5TKLgscX2i4UHedz5aOrSVZs4MZM?=
 =?us-ascii?Q?PqLeGkhQAYPy9M/CZMBxYXCzv7nlnEqHLkx2NyPBFd1+E+5JKj4uh4DAtOd+?=
 =?us-ascii?Q?KQbdAyRkdgDzR/+N7RDG9wljLzackTh6FazUIMBu1MZB6OCNQXgm19rRhUaL?=
 =?us-ascii?Q?VhFL0X87FQniCX92C50LwOXVBrJPAQntTVocHiy8hMKSbQQz9jIEvP3FTn/g?=
 =?us-ascii?Q?2CPo5rRNUnoh+LdtQLR3ziLKh4cLHKJYJvN8XZgpHk++Lk+5ts0CHOjO8yYQ?=
 =?us-ascii?Q?8ZJ3Yiw0IWKEYj6ktC3895IPvSeLq7IhMj/JoF5DMxIa9uZJikr8obCcytfU?=
 =?us-ascii?Q?sF2OrdQGwYUIRM1poOOlOaHMcBz3RRfDaXN8lYZvFkDEPHzxLEG/GHW/kcBL?=
 =?us-ascii?Q?AYwEk5RMoPACtfR3Ic2sqGP2gdUuKODRSik7eTYZC6mMN1gwrnBbx8BUwRxh?=
 =?us-ascii?Q?eAL3UruMuwsOd2fMYr21rZCKZJgckd/Bs0+VlvwwWqsGsuLUGpFwNiwizs6A?=
 =?us-ascii?Q?nGH2CmqG4tR2TxMdgMmABTTN5fK0sEwLonfTeljG9dhDqEFA89Uvy0ZBsqJ+?=
 =?us-ascii?Q?z01Mpo2rx9TV0lMrngh/09EmJlp6jYaGMa9GtdiMg5Kt/UE6dHF+23NXVqV9?=
 =?us-ascii?Q?DQaenU28KvyDgDke8pQdD9Fjy+U+V690ss1bXoaGfaDsF8ABXOrmxTAxzDXT?=
 =?us-ascii?Q?OgAHtHrEwestrGPfPXt/ix9P0DZx1+4xiWxeo/PJNvciIqey+CUIouLny3SK?=
 =?us-ascii?Q?VFnLS6rDd/4Uy+IcVRWaVJqT0dRZMLAVYpSBHtVlqYl2fjqACugMyvc37Xi7?=
 =?us-ascii?Q?oMgPZ+3/tUs8GIgSqnWvHv8V0OecU1y8oQYdMA4xhlfHg+dH3VPI2/su8IaT?=
 =?us-ascii?Q?JbK07PRDAky8uI83c6zUy4fvilCVxt4G8ocfg+kFvKDuAXY3BoSUHBrtrMF1?=
 =?us-ascii?Q?8dbCyj8AM9w10Mcq950rfaLiNTDxVWwNa8Th2TjUSqTwpZ3yDjZLBor5rUVF?=
 =?us-ascii?Q?OoE4aCTX+G9hU6lF/tBenVlIMGxCPV0tjLQsEl46AfuT+kIOTw7MzzEHoo9u?=
 =?us-ascii?Q?gzN9AlzAEfcW/iTa17BxdtaWuyz88tKDxPLO9rZXSEMq479AeyNBgaDfHVCh?=
 =?us-ascii?Q?/O+Ot8ztvw0oi326ANv7EY2tyKOxRoqn9k7FDAeasrCezjZXP/XOdy0km+k+?=
 =?us-ascii?Q?54X+GTeZf+z+xT8AR29619WiYg+ZzOb4T0m09RkN069lhjmXt3OgH9YRbWWW?=
 =?us-ascii?Q?/GdNVGYZt0s8K32Vg8kpEdIfSPh1d36amE2Nk9XPNaUahD9+lQlbLSKZ58YA?=
 =?us-ascii?Q?vj+S5N08meTg/Xl2c9c5/hlR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ffeed5-64c4-4e81-6d0f-08d95ba34107
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 02:04:58.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4sJAHbpqzbs0KvC/ARRElILttVCalm6V2AdLUuhGYwHtjnN147wZ3JX+YR9FHWlEGZGGnrg9W9Hil/9Sil4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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

There may be multiple instances an only one is harvested.

Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1673
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43e7b61d1c5c..ada7bc19118a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -299,6 +299,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				  ip->major, ip->minor,
 				  ip->revision);
 
+			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
+				adev->vcn.num_vcn_inst++;
+
 			for (k = 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place,
@@ -385,7 +388,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
-	int i;
+	int i, vcn_harvest_count = 0;
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
@@ -397,8 +400,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 
 		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+			vcn_harvest_count++;
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
@@ -407,6 +409,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
+	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+	}
 }
 
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
-- 
2.31.1

