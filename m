Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FFDC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3568A2073E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9UXYwzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3568A2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736DD6E117;
	Wed, 24 Jun 2020 22:53:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527976E117
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 22:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLmpDKTwtlMJ8jE5IxpyAFRhvIDx/UJvmpInMZhzHpOo6Kbpj7VRapEFJgl3NHhwoxtnLQ1wyckb9Re5fpOZ2lVBdgrJ4cH/x5xdrFjFAqdfFx5nwVpgNqpc2PXE0att93VnKIAZhLqo0vIdu5doC/ZDSQdLjAcKfb7LDIVgvwjlYJw5ll4hEXsWTSkzCo7SqR9YgH43FY4d49DBHsPW6DR1/r5B07M4RZARbXFf4EjFveLXD1WuV2ucRhAKbgT/biBRmcGGSmuKIGtUG7IWIJ7zg+n8pvho5FKh+UtBnYr02nHGbl4LucsytNybIDWx0E5jPD8y6kjEVv4Bcfq6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NwBAYRvfQREKOcgI26CYGcjCQKartfvXV+ZLoQzk6A=;
 b=AHJYGJXLz+xodn6qEBTJlN3cM7sSH4Jhsqb1pQbduS9e9zo0x6a+ESIUdj/BHZUeeuVE3V5nwv2KioR4StjE4pgpS3ACJLiGjdIwXwn5raIYRRM+/VcdWnswqCWEF+QMImGGccxCbsC/diRbYQpwSA8fU7OnFNxPKP27UtTRfGoFQhPOUUNbfyFwndpIs/WzCJ6YcqyyR6rGX8vrBzy4/O+lGg2+le8xKTZ0hW0+YAvu1LqFvGbTkKDy1j6XqRSrUkz5iYi/Vpy900pcp3IPPkgzmSL3xBZ04HvFyFaZq4xfQqX+6yKO2lu/W7Vtltv6LM8+an/vEY+OIbCs9XLPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NwBAYRvfQREKOcgI26CYGcjCQKartfvXV+ZLoQzk6A=;
 b=a9UXYwzc4b7sE+y92Z3jShHJ2FDhbhGEfl6/fL0gOH4avfCC02CDP9dEB+9VVeqzPxI5uPPrMwT5qg/8kFxMMKG/5NGmZCdBGKapo6wwzX2BFGBo08iU/jZLUqPADtEShpKx6awHQzCzb/h0iPfQHWjshBk5SwTHtxyDyDDSsak=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 22:52:54 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 22:52:54 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: move reg base init forward for soc15
Date: Thu, 25 Jun 2020 06:52:30 +0800
Message-Id: <20200624225232.7616-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
References: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.24 via Frontend Transport; Wed, 24 Jun 2020 22:52:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2b14b4d-cb8b-4052-45d4-08d8189154f0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408519949E59F2CE1D01AA448C950@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4duhwnMsD7uv8Uc4zkAg/e8EXBTSG7sfYAAm/xXFTtUOyP+n9o9f0Y0M4gQcspwm90YPYnXk/btsWso8gqeX0/ykyYav7Quwkk5g3vQud29kYMo6h5vo1ihUs9dbyh5biRMmlcu4NIJUyRtU17sCXgqhcScUKVlUurETv6iO+Da581XlNqzCo/JOVDaYgbly80M2wQ8GRQYZBVNKdWfabIAioIDBLUgmvE9fpsVuZsXGHU+RjD/KMEdEoM/F58tp2APf/qVrArR7PLyLsrffjqcva5q5UdwBGRSC6zkEQ90BaWDjpMRVIGDgXKe1eYOV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(86362001)(66946007)(83380400001)(52116002)(7696005)(66556008)(4326008)(66476007)(2906002)(8676002)(956004)(478600001)(316002)(1076003)(2616005)(6916009)(6486002)(26005)(5660300002)(8936002)(16526019)(186003)(54906003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bs6SR+BBK7W7eQZbyRXVq27XSaAwt0qt697u44d93BQ+NxveuNAhAB7FvKFaxSpzMsrVZli8MScrQACx+tzQ2trIgt2w4nba2mVnM1Bcnt1lH//8Q68joxIz6+4XPDWWuOShb1X5c8vvyEyWYY/zYVHv4hhxofBHt42iJy9m2cNhWwqT/LLT8evyx7IDpV4jQktqJUucOtWk0fjO2fZsvVX4mdQdwV/QQqNrGKNKxVK1IkLTcrSgdwiC9SPpxSmwUmA5VwQYrGqrYZwPJzJ8EoFuk4wD9bZgiy0f4fo2LWKM/VrdLN58RjhQX8oyAOMODWCGXAGm2Xmuet6RHabn9PxbUW6MbvLNX0cORDTG6pWhTTHGYa754nf6kQyknYs+DfqPl3gflnzjycZYEm1EJ6B+A/CQ0OOAMW8YEViwh7sYXtu/oWseLwb5/lcX2m4DcyYDxKWbGbPnHkxud/KBoxPigxmqbUk0wqthcykAf/JhqD0oPqoPZexZFS3bzO1P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b14b4d-cb8b-4052-45d4-08d8189154f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 22:52:54.8860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDI5zUOjrc4dHFSTGBWJBj3ZMSG5zy0MZYwKwDX1poVgXRyw40AyQ8pXEV8Ku+cmB6iTuezRHAPS3bDssL2gyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

Init soc15 reg base early enough so we can touch
mailbox related registers in request full access
for sriov before set_ip_blocks, vi&nv arch doesn't
use reg base in virt ops.

v2: fix reg_base_init missed in bare metal case.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0a3031fb90f2..8c739b285915 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -669,12 +669,7 @@ static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-void soc15_set_virt_ops(struct amdgpu_device *adev)
-{
-	adev->virt.ops = &xgpu_ai_virt_ops;
-}
-
-int soc15_set_ip_blocks(struct amdgpu_device *adev)
+static void soc15_reg_base_init(struct amdgpu_device *adev)
 {
 	int r;
 
@@ -686,6 +681,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		vega10_reg_base_init(adev);
 		break;
 	case CHIP_RENOIR:
+		/* It's safe to do ip discovery here for Renior,
+		 * it doesn't support SRIOV. */
 		if (amdgpu_discovery) {
 			r = amdgpu_discovery_reg_base_init(adev);
 			if (r) {
@@ -702,8 +699,26 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		arct_reg_base_init(adev);
 		break;
 	default:
-		return -EINVAL;
+		DRM_ERROR("Unsupported asic type: %d!\n", adev->asic_type);
+		break;
 	}
+}
+
+void soc15_set_virt_ops(struct amdgpu_device *adev)
+{
+	adev->virt.ops = &xgpu_ai_virt_ops;
+
+	/* init soc15 reg base early enough so we can
+	 * request request full access for sriov before
+	 * set_ip_blocks. */
+	soc15_reg_base_init(adev);
+}
+
+int soc15_set_ip_blocks(struct amdgpu_device *adev)
+{
+	/* for bare metal case */
+	if (!amdgpu_sriov_vf(adev))
+		soc15_reg_base_init(adev);
 
 	if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
 		adev->gmc.xgmi.supported = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
