Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B9DC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E55064E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E55064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79CC6EB3A;
	Wed, 24 Feb 2021 22:20:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAA56EB21
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbeIQdNZXNkQTcic5fAEl2+EiykCObEX7BYsg/0vVu4J24ITC74+3D4Sr7DHCB3TysFwpTCsnxNIzTD1OsJs9/cVUNrponHpBxg0jT4sODALlRFz+P5bL3sn9pVaJIyJeAGGZO1s0PzDfuGDwQ3dhceq/98ZiKYManoarsPu3JOuNHCTaYiCxKJ8Vcj5Fj9Q3KmMBy4AeZkSinDKF6BQ7GgJ8f+z6KVcC8AXPk48vNoKQf0sYlQhgbigpcvwVfH55SH3iikC090kFPZnha4MIHdwoWOEa14doBdGUBFfI+/+ulAvQDJJVrNwO2c83K/lAL9PdG1u0BSR/3rf1uBZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inJv27ei++XHr+DIxiX79iPpLRdsFBkGKhEckVuLVcw=;
 b=cXO94xMbb3tT+/2CfsqFOM22/UeaTTYIaIAU2zYvwGZHv0miennI+o+xXZf95/hT8qHXdeR83JLqI6kG3KYRODKo85fk6d1LxwWRdfYy1RyB1nCKKgfi1qjyxHINJ8a9fpWk4pj7pLHDk39Stoqs7DHdxY2pbRxFKbw0JM6CeI+xx+dCrLs7sPlznr1cf6LF/SDPamdl2beEkrXwQMR6NhZ8a52e+VFyl1GIXzjQ5DSOakRLYl+uPRvMG6GUMM4zrwjG83PqbJElBYiCqEkmrJQ+uLkWmxCR9S3YGOAf72/40/axDeeTuV31P+LtlBD4aQOtfoH/2C6NMRqRcjrujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inJv27ei++XHr+DIxiX79iPpLRdsFBkGKhEckVuLVcw=;
 b=j8XrK1p1qE8dVd8T/x8PpvtgOGqnM4uIwFZtXZzDwNAh7PRQxop9EGEgJ+Th90mfO4T3TMGSDzljg4LG7YCA6BDmN2cNtTBS3kVnKx6XrwwKzlKf0Nnes8tJTKR9MY0PL97cbJbUQB1okehhYRgaMBh8tqdp26CdwJ0ypWlPYJA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 041/159] drm/amdgpu: support get xgmi information for Aldebaran
Date: Wed, 24 Feb 2021 17:17:01 -0500
Message-Id: <20210224221859.3068810-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 046fe2c2-4d29-4782-9ef9-08d8d9124c22
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4865BB3F3731D0D60158CC7EF79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzD2qzV3PA0qFJ72EG3RcTurosn4anpgjNgrsci7ByzwDqUSOIDLHItKgEnBbgGKwgpAGGpjkLY5I2yN7eV8lNesGXKBUe5PBMAIRNVEq5fwBsNUNW2xFy6sMtFOe8pZo+Pnt2m8s1msw95wXa5818H7gOfE4tIi95kVY4wGWMq94bVfxdZocWXokPTG3tH2eT1jFxEr0/0aaF4nUVD8k9XMxqOGXtkjBupj+adlk9o16HA8xzBTUU4ExEoqUNzWALoFsMgaftahe7dnfwWdD/JnSkWTZBWCYsSv9YyEVq4NQk7ndDLfwjtSjbpLq7uF55IX3m28laMwqRRKbDS8wiQY1ZtsjXji4LHexq0w933uvXYmjJ2oBpdwF5KTDM6g1ITu2XntYF4JusS8LoHxOkm4Z5Bvz0lkNcXAf0Ce9DuhsJda+UW/xrg2nIkKvvxL3sUWw1KiQ2nxb63P8dLEArYIuU8xbQwpLtdANVhwDlvS9rEGYAdeCXkoukSAwtP187ZzTvSuadan4BTQBk4ZvZer76CYvy4fZuCrQPtTHwPAeFsjRMdRixVXnEuIKOqrskcEF8N6GyKVGxKbnc14Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C6Sa+J9gYAiNqn5Lwn2GEwty9BSEfxTXVlfGqFuh+Y/QQzKprp75eSe5KErs?=
 =?us-ascii?Q?jiFKQ7mcLjbBHO+tgSmAqaMLC4eVuwGAtQgxgNd/U+y0T1fmCgJ70ylUKbFz?=
 =?us-ascii?Q?t+G9jfTuIF/poMrhHiFXqZsWPw8CHjCtLdXV/ZLFO35sNePIV3XNXuYwWO5n?=
 =?us-ascii?Q?wZA7oAtPftICPCz19GAOE6kNLURo312dRb3e2BBmp8s8ObDh1zxDabgJYdGX?=
 =?us-ascii?Q?uX7oBC8T2B6ioxztUu8I/Oh87eWqJYn5tx8w0FrzoBBV1D1v0jfxx0CEo/SC?=
 =?us-ascii?Q?f/9Nlz9tCOtxTrOjApjayjtFwbMJIIiN5FvbuiTNuS/VttJbUAQwdRMX2gWr?=
 =?us-ascii?Q?8FAxcbphWivVP3PtjpNE7iSseg/f/CTjtlVI7l9r7FRV5jkzQ+kpLZuY5rjX?=
 =?us-ascii?Q?eStNYGkeDphFkH8dw1NHuVapiOYAyvE8acl5kVl6k0Pn/Fvgs4r/OXV3lHYG?=
 =?us-ascii?Q?q2wVtIXNUZT56jxuHS/rfD5e5v9AUpkn4tNRSyjzKWsOowRO56eKdlQtmeTk?=
 =?us-ascii?Q?YN93wwDjPNFOCvGo+bscRlxEpt+dw8Os4oq70QKvIvgD8YZ/cmPFc6p8g03m?=
 =?us-ascii?Q?3HSzsknfaNsbZSMct/Adxos9VWAIxxtqkNB95FacUqvUgaE5aGsIif/4nwWS?=
 =?us-ascii?Q?eG4hQOPuyc8WHM0EjcQT+EvVhb6etMqRgcsHmngkJHNI6PpGW8TYOXNEjycr?=
 =?us-ascii?Q?myAozOgIZmzNkg2kWAGH8t9kngyzNtlvLZiLdmGNd+xo+O9Dt2SJ6N3cQSh6?=
 =?us-ascii?Q?9iCD6prL9DSvJunKJplUp4Z7kG4mX4PweNcsiKWVoTXrnEsOz+Lb2G8SAGQk?=
 =?us-ascii?Q?FF/ga2QqVvGz2B3iu4UpwcMvSiOweoVHqblvlxURvFjohTCkzsRaD3y15G8f?=
 =?us-ascii?Q?ezO0qDFBVSWKZOvw8w62HfNRGoyYS6/oJP0lc46wSqCqqkgPSLHnhGsuRyHm?=
 =?us-ascii?Q?il/riFDwpRA4C1VQRcEs6pyEORH1WUS0PD4DyHYZshwO9lU7cL+TlEd6DM0k?=
 =?us-ascii?Q?g8bvO9c8r5e29+BzuLNjK/bypWk+R8n2R9XWcuA3sGdqMuEOSG3iXxk+vArz?=
 =?us-ascii?Q?a8VzHw/iolpt08bViQ67tUW9RNucJ3dhTF0N9VR8J0qINTFD6isMvCxTa8Ff?=
 =?us-ascii?Q?zTjGH2XPxmWoS3UCgAZ5jfTQaoa43BUpGu70k54462hBU2rR8yq+UA8ZLpEn?=
 =?us-ascii?Q?CiIFtqUGA9ACFYluSCqMV3FVw6cODBx7lqsNjiEgOuJdECrFZR9swri9j6DY?=
 =?us-ascii?Q?94kSv4O8NiQDmkdchuy7J+HSo9YQnB5phiDZZMwtSRZ3eE5ILbbvJvTf5gzY?=
 =?us-ascii?Q?3lS708XYmB8Dz0QIbvg3OTe2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046fe2c2-4d29-4782-9ef9-08d8d9124c22
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:48.4563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oDWCQ5eMRENZrZGyuE6zFBCkBUF/oaUKPASBE8S2pJcJFw9zZWLvAWduVXMRrrptVFIJBKTBGkoQqXv1SjUFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Aldebaran uses registers defined in header gc_9_4_2 but much of the xgmi
related functionality can be obtained by reusing the exisitng definition
from gfxhub_v1_1_get_xgmi_info. While adding support for Aldebaran, also
refactored code to better handle the new scenario.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 58 +++++++++++++++++++-----
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
index c0ab71df0d90..3b4193ca2a47 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
@@ -28,13 +28,42 @@
 
 #include "soc15_common.h"
 
+#define mmMC_VM_XGMI_LFB_CNTL_ALDE			0x0978
+#define mmMC_VM_XGMI_LFB_CNTL_ALDE_BASE_IDX		0
+#define mmMC_VM_XGMI_LFB_SIZE_ALDE			0x0979
+#define mmMC_VM_XGMI_LFB_SIZE_ALDE_BASE_IDX		0
+//MC_VM_XGMI_LFB_CNTL
+#define MC_VM_XGMI_LFB_CNTL_ALDE__PF_LFB_REGION__SHIFT	0x0
+#define MC_VM_XGMI_LFB_CNTL_ALDE__PF_MAX_REGION__SHIFT	0x4
+#define MC_VM_XGMI_LFB_CNTL_ALDE__PF_LFB_REGION_MASK	0x0000000FL
+#define MC_VM_XGMI_LFB_CNTL_ALDE__PF_MAX_REGION_MASK	0x000000F0L
+//MC_VM_XGMI_LFB_SIZE
+#define MC_VM_XGMI_LFB_SIZE_ALDE__PF_LFB_SIZE__SHIFT	0x0
+#define MC_VM_XGMI_LFB_SIZE_ALDE__PF_LFB_SIZE_MASK	0x0001FFFFL
+
 int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 {
-	u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL);
-	u32 max_region =
+	u32 max_num_physical_nodes;
+	u32 max_physical_node_id;
+	u32 xgmi_lfb_cntl;
+	u32 max_region;
+	u64 seg_size;
+
+	if (adev->asic_type == CHIP_ALDEBARAN) {
+		xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL_ALDE);
+		seg_size = REG_GET_FIELD(
+			RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE_ALDE),
+			MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+	} else {
+		xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL);
+		seg_size = REG_GET_FIELD(
+			RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE),
+			MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+	}
+
+	max_region =
 		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
-	u32 max_num_physical_nodes   = 0;
-	u32 max_physical_node_id     = 0;
+
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
@@ -45,23 +74,30 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 		max_num_physical_nodes   = 8;
 		max_physical_node_id     = 7;
 		break;
+	case CHIP_ALDEBARAN:
+		/* just using duplicates for Aldebaran support, revisit later */
+		max_num_physical_nodes   = 8;
+		max_physical_node_id     = 7;
+		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* PF_MAX_REGION=0 means xgmi is disabled */
-	if (max_region) {
+	if (max_region || adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.num_physical_nodes = max_region + 1;
+
 		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
-			return -EINVAL;
+		return -EINVAL;
 
 		adev->gmc.xgmi.physical_node_id =
-			REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_LFB_REGION);
+		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL,
+			      PF_LFB_REGION);
+
 		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
-			return -EINVAL;
-		adev->gmc.xgmi.node_segment_size = REG_GET_FIELD(
-			RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE),
-			MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+		return -EINVAL;
+
+		adev->gmc.xgmi.node_segment_size = seg_size;
 	}
 
 	return 0;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
