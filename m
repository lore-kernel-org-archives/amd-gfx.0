Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B26961130
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B26961130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70906EC05;
	Fri, 17 Sep 2021 07:05:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F5F6EC05
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 07:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbec9fyGwBCQoVqw/PZnuOLDQ6VlwVOJ8/l57h/l9igbKvu8cARFWUUrDH1ZKRPxar0Hk20PKEhYh7XYWzOAW9KEJReLn/f+slowjTQrsVxc5uPGCGNu632AxhuhMysfN6hRBecdsd3htNNQYoMeDnlwK6F2V5L9fnV0Cu8yUBu+6TStfitg18G02ZUryq/HB0ChnIfV4qc0pIyYsHhdU5R3cFOX3X4/uAicIp4a6nK6KdMZckzt7H3oCx4N0ywc8ed/MmGFq7h1VnUL95BtDsEFR0oD1RR41+/nAbIgzeXpzm/ZnJYCWlaqRDmFyZPgWcQztbt8CaOpTBU8TZBrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qeMnzDkhuPZqNx7D64V1zob6RoO/g4geae0J4Ukmwfk=;
 b=iMMKb17j9UgZntr+7DXruuDUn9oNwAsLM56zWjEulBTsp0jTbnHNGWbOcuKWOtU1X5RlWIg5RXSPNiMJEDTJQl4ZFfQvTsL7qmwZSxArNsgQh/EHj4smaeRXswTZbgHo9/cRb4bdYpdFUWP/kymF1rE/Xw3Ng+3MDqp+FycjOm60SEy5m614frvXZrMup/oGpsf7U5u6yD8GvYcR8AuhSMpsETLor7aWeiqVwxbEPNxeZdTcwwfHHkEZtni48cBnRFo4IF0nv/VlMUyzCHX8VHRMpZLtEBwb6iKN8K4eIqWrzXDZPR3FQt3owaikjGRWeRoEx+sTAFECeGAYTFJjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeMnzDkhuPZqNx7D64V1zob6RoO/g4geae0J4Ukmwfk=;
 b=fmvesCad0WEHmt0FGFiknoqHMpT+WW7sRFNxZiCz4TWSARFeMUIOZuCdDdQsNI+z38hdbv8Tv4QvuG9zanHnzicgXzvRKN+lophTgsoHK3K8Frp0rI/9FPNfvJTRJgXJSokSIVW/2V03PZtZDaeevyiS+HA5lRfTV0CH3B7W+rs=
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:04:59 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::67) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 07:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:04:57 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 02:04:56 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Let BO created in its allowed_domain
Date: Fri, 17 Sep 2021 15:04:44 +0800
Message-ID: <20210917070444.4867-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f00f4f74-4bd0-472a-bf0c-08d979a975a6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR12MB43061C973615D6DCF203B8E387DD9@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 246m2OPeQwVFo3QynGraQrWWi1NksdDi6oJENcP6WjN0Y2gUdHZmjCd5kaBwYhlJ4wiIKWecsnpqLU5elkNjEzIR5K/f4FZdd934EgtCKEFkZgcOgt2sMFcgsWwarmFxG3elR75DlZ4TNcOlmf3xf2jM3uLWREiBgfY8pQ68ce/Ys/KLl8AUWPMg++ydh29Rj6iu0NeIfagIjXtEPS7Sc8D0MmXXkyMaLY7u1ysFaocrts8Ej/0x4j+jqOipa/574wzCXdrrDIQMyfJHavp7F3/BFRiScigKbrcLyPYBLy1R/ojW9jq5kULxVf23hsfJmWO2ixwdGDHcbziMTuvT0/J4rzVgDeIVVPRGxl+1nx4wqRkEyoJO9M3czxvvkcNOx16fbEKVfwUPrOvYvquZ948fjOpGW3R30qhS6TJLmimv1grtq2bx/+ZlQkQ+zY2QzrzZlIvM2WgEVC1LnTIXKVFwnhoo238fV2Q2eTT8+bvJ5dbm7l6e1QK4OxXrQZc14OKXV3UOOuEsnGJoqScsbaXMhfn9D+KuupzrW3YwBts8NNzZ8q0DOz3B/CG/DEKq74jkZjvsmkWOKO5SKJnSu6nf2VZ2Ekc2wJu9x2WEXyIM1KaolU+k4CRiVOc29fsJIApS+1RH0ZSdxT6OqFqfvRSW/D/CToYHlS1GzMjtnwBH0dF1eZrSywBQdOqhNXHAQtkGKXVqE3FOYyLqhTyMg2zX+KkgqlbnjR+Y51qjlNI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(63350400001)(63370400001)(82310400003)(426003)(70206006)(47076005)(54906003)(83380400001)(6666004)(81166007)(7696005)(336012)(4326008)(26005)(1076003)(36756003)(86362001)(356005)(8676002)(186003)(6916009)(36860700001)(2616005)(316002)(5660300002)(82740400003)(16526019)(70586007)(8936002)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:04:57.9492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f00f4f74-4bd0-472a-bf0c-08d979a975a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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

For any user BO, it is allowed to alloc memory in both GTT and VRAM
domain. That means one VRAM BO could be eviced to GTT.

Now if device is already lack of VRAM, this BO could alloc memory from
GTT directly without evicting other VRAM BO. In this way we can reduce
memory evictions.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 66bb8a53bb20..9a547bb38cda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -579,7 +579,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 			  AMDGPU_GEM_DOMAIN_GDS))
 		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
 	else
-		amdgpu_bo_placement_from_domain(bo, bp->domain);
+		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	if (bp->type == ttm_bo_type_kernel)
 		bo->tbo.priority = 1;
 
-- 
2.25.1

