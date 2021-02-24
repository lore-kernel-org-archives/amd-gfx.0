Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0FF64EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0FF64EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16FA6EB72;
	Wed, 24 Feb 2021 22:21:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BED6EB7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwQ3+vwnLKX6rRM2mtqNfa76LHIoq2nQVpfG/0ZXAM2oPI0SG37DCm7wxnlFHVDSuLdZoIZnEBlJY4CIIq2YoHwNvdSvEiIoVMODe/+/mSeccWEO5ZQq7ghjdNXDoAQjsEqnCFs6R7WUR9kKiC21sIdWagfEkbK0sUN+4lPz0MmkLzCnAtir3wg1knpMNjwdae4E1fJO4an3C9jI/Kd8Kzz1ipVnzgWuuFJIbL3gRdik8jVAuEcgW3tdmoN3ulpvgt22Cz8BZRcEgtct825K28KI7WjG/lhBNSEPBU8urPtKd+pjz2d+vEjaiYyxM3AC62JKRH+9H8bhEp6nI6RgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHvjt4GuQeBJN89NO5flAgFIrLJd2amNv6dkBsuXFXk=;
 b=m4SNQgMD4a8rCQ5LiTl6I5fG9X0bBWQ1foflFJ8p2nGA4dd4IPqVhNoqwqJvJvskio1r46aVlO+zLZyDgWKnMOjFCIJFtPWuZpjuU42eMb5I7MyrC3R14NRT1eG9V5GdvGxdkzUiLAbDLtnvmUu6jezOP/IZZT/XPR+lVmIOWPdaafCKMK66TGVtiew82244WhXlQT+VMeX9Q4SJxCYaUi5UsYpNpZd0LDkLhFy9otfYu6HcjROFeTnAdAMsA1yARKKAyGmNmRh4f8p4Rbd73QOjLYLSFLWY6MtZomYJYfyw+nhe70n6JlSg5cW/ynpshsjR0Nh6n+VNwJVzRFuTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHvjt4GuQeBJN89NO5flAgFIrLJd2amNv6dkBsuXFXk=;
 b=lxwtQipupDhqCDcIbcRtzlRZawURX0V8cRV1/dSlKxqP4XdydKcuYf8V7VtHkplQ6OLzKvZrwPCnVpwMwj9IgdGc7CI6z9Q0ZxtHToBw8Iww1h60eIrn27QJrwapUGhD6EXvuTMlYLsAkRn1bu5ATCTr4hZwa7fwRUhoXFIGscs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 106/159] drm/amdgpu: enable vcn and jpeg on aldebaran
Date: Wed, 24 Feb 2021 17:18:06 -0500
Message-Id: <20210224221859.3068810-99-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92180f25-d854-4c49-e0bd-08d8d91268be
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798A04CB1694B4696563F98F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2d1p351ejhsf+m4E/A49c/f3Zgbd4Ggn88maZJNFsD+rQktZQMufqNfgHSSq7idTUHrlb1TRU76xwVQbhYMQ29QU9j6mCNHZ7EINp+8vs4/qGrB4pmvGF6c5mfSrRrfqiFhq4N2pruR1dauW9ziSpvw50apny0qSd+P7wuRZOcS8qk8SG97CvaNCl8cMzPWq20CqSMKFjfA5iX+heQ7TvmPBNwP1ahlYGyOVETY4awObU9GSX5T7ell3TOuD0UDfmKOcSvBp2LDVP5q/+CxbAdfsEwsxfMO6ZseXvpYLdJMRUB8zwhqKchhLRd7azAJ8DUekR5dPdGf0YhxvDXDbocnZvZuACmwmmsM+0rOAotQtAib1hPPMajELFhktcvIAOLcIN6VQnIG0UuNp0knvSoPqnyG3D31oNneRNceP5cDbkbA3sUUD4sZ38OZgCSU3yTVY6cuh2HXON6xDTBrRjAhhN5s8/Wr1gyCmSDYzawHecXFBuX0vfdoZZZ5ZnBqWLQNcKrGRbtvz8K/CnkTR3tUDaIvyf5jICVl7xBzvYxSkobMIXMhT7uVzGVLa2uFlH2eXwCrS2UTh7+5YAKgOVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R4RBkTKz+jJIAaUq/gcwjM+KX+x5tSbtzuzayrdIbyL24WJ8lzleEFd19Kpy?=
 =?us-ascii?Q?BND0apzXmf0WlbaZol6WXlOaC8kODF29aD3Sv/rJthz74ZTCAh1g7Moluvya?=
 =?us-ascii?Q?G60F0raZe7tvwfEfhknSGZgtAAWkhGq0drKUDbwNjZ/NqzLk9uwT+mWGGfpr?=
 =?us-ascii?Q?jivMDhS4oxrmjYhMc2V0GWb6T1OXqsbizHir0rPS27Cre0uJIGzHuuoRB+xi?=
 =?us-ascii?Q?wkXCeo0vRx5YQOarVHxiOCiA8lnf2U3Q1d7yI+vIPwXXizNzmpzstihKCzQL?=
 =?us-ascii?Q?KnFnrnn2+1g29qZB+HspRGH4GNVnycn1kQKvSjiS3rLOzyrR9oVQtFzogNEd?=
 =?us-ascii?Q?poVOuYKhfyIo1BJoiK+hgzrZ++LJVYausSAegoYrojEnDmYcCpvu60KdYaqc?=
 =?us-ascii?Q?dOKx+1tAu0VD41canIoa4nrlXaTQTPFk8xqwS631zI1E70UKtlWXrklk/e1I?=
 =?us-ascii?Q?+fuynmgreWuWORo+NJ3nSwapftEnfUDHnSU6Rcu7KyqX9/zOZ6bos7u+pGCM?=
 =?us-ascii?Q?e8NMEDqnT59wPCPrYaBxvJB5nnjb166bHxk+LYftkHqlFzYeqYvdADueW/LR?=
 =?us-ascii?Q?KfKiI3abdV4CB2Yq6yaxSTa0G4u/xvxrukaSFBrrVuDQB08zGbGzGBWZxCRl?=
 =?us-ascii?Q?p1weBszmpW1JqDe6urtLuagZLBNdq4mVZdLb3hF4jH4xtkfghLTb9cXaohIw?=
 =?us-ascii?Q?qrLZfpwLjWzGBHJdA427oi1/TeSZ26Nyy2m6oZ9PXXJpYKp1yo1T7xHp2inP?=
 =?us-ascii?Q?x2h1duO6A0bO1jjJfbbJiFLPf2baQ7HhAVvBDptlji6UJ9S+UK0BpnKKe8eR?=
 =?us-ascii?Q?y0+JGRP8w3AsulzC2fAM9E6SVggRrgwvUT0SaDyte1eeSywuWpCjNYXUDGje?=
 =?us-ascii?Q?X6mEkQvJAgimVCMfCsrvQwY6jBNf1AGqwJ3q5u6M3kRYj1U+V96HoT0NmybA?=
 =?us-ascii?Q?HyhMOAZMW2+11fTAs0iV3AA+XH9jetBXyYTY0t/dO8a5e9KOdZPDFmWatsPx?=
 =?us-ascii?Q?3bJ30PqWEAj9oIcuYp+PcZCWxvh5gxHaNxu93ILVhQoeyOfzc7LI3K0DD7U7?=
 =?us-ascii?Q?c+yfKfTKGaC2vz7Sy+TMr447uyrX9e36m47ZQPsFkW5xNffqddOJjINaIy0c?=
 =?us-ascii?Q?X5TqbHnSrAsizIBQGut7GX9WZfzCTaFwzy8YFWZXKeM4ffTnXpV72vPKu/vV?=
 =?us-ascii?Q?VAOF+mSID2Mx5T7YWTrIMxOfuF2ayGXiqP7SgGhl21KQV7xN86jiTq52Ethv?=
 =?us-ascii?Q?RfwlyvqHP4UF00QA14nL8ae0EMH1Ok6b6CuTvs9hiEI8omJ6DbZ0RNyllLY9?=
 =?us-ascii?Q?PcUkvQLL75KW7077cN4zJ/rI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92180f25-d854-4c49-e0bd-08d8d91268be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:36.4636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POFH26KjrOuDrAERiZB2WYV/69/CXIS46UGwJ/4tPU2RqDlDtdfkKCJmiJujaeK6/VMcOWtVnnJbUU2DxyDv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn and jpeg 2.6 on aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 441dee71259b..ad1cead197a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -832,8 +832,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
-		/*amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);*/
+		amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
