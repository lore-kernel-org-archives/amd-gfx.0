Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6DC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 07:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7AC2080D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 07:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GVjFgvnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7AC2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FADC6F382;
	Wed,  4 Nov 2020 07:35:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DD96F38F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 07:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSg57nxnJ8czIAke9aBFA9GxZcbIUtZMH5ChRBV1Qipbhyz+gWFWKQw4ntBEtd1XfdCZjyfolUdYynv02JZV3uueUb2865A2+m4s/Pf4j5MLWO4/OJTHOEGmexcIHvGYSuKUD6Hm/fbUfjSOfD7VCJLwABKux4rrUyYC5FaEXrYJCsotM0ZjhFKGoSCgLhrKSULpBZ1YtALaURJWliAsMkQXoaS97qxtLE34tSHPMmLMaTU2A7ULX/BQNmUwSfymHuDyC+m+VH5IIZ59HSt2Zd5qNI8lzsvcURYOQElBN8WkVPYIzN+lw5IggkS3TmkRrwhCqxAnKIboFCtwaKB0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxP4p3l7ysDmFJ/ktxIRcTehxKKWR4dxXui7bTrbCSc=;
 b=k4mul2hsPoCePIvAThUX1vvzSq8kJ/KjscqyN3e+vxWlT6Nh57RadYE1wMcEZwAMt3tABPycLo3q30NDs10d1WlpoE9fEb+8HVTlSlgdVCMmTFycshu2L25Mnf3VHsY9ZudFp5etAItvutvjWxGZaFGFty21cyxam//30++44JGPc8vfwie2I17Vfr62FNK4G2Ofg/1VwlhY+qw4wsgQY0l8jmRAFMlvQn7ddNIHuwQ/jQDb62yhk/HoSShjZtLXvnH0boAU4FoPh+c8jCr0Z4EKywGiJNgqzbMxxLl9+2NH/zCfu146xl8Pi7f+N6gd0Fktgptj12Wg/ySTGc8M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxP4p3l7ysDmFJ/ktxIRcTehxKKWR4dxXui7bTrbCSc=;
 b=GVjFgvnKYIgiuxukuwHgL1MH/axqhHMYoGO5+4olq/TB8RlQqctnBvQffpmxKUB+776zmafQQ1i9GQq2/z9RSWl1+ITulQ7IcpS9UPkGxcqpTEcIH0VN08nf28505Lv4wzFrmuaqdqA1I7RRT+BnFAPeNCrupWW4tQHefGZ2jIA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3230.namprd12.prod.outlook.com (2603:10b6:208:108::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 07:35:52 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Wed, 4 Nov 2020
 07:35:52 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add missing clock gating info in amdgpu_pm_info
Date: Wed,  4 Nov 2020 15:35:33 +0800
Message-Id: <20201104073533.26365-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Wed, 4 Nov 2020 07:35:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 751c7261-f95b-4ae7-d57a-08d8809441bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3230D417FF1B4E2B39D25A38A2EF0@MN2PR12MB3230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H42YONrN/SxdPMfxFcSH3isCw8slOjmVOSPsY5U3YbQg5kW3vsBAZn6ryokRXl0s247G8ZcNA8XnmzppdTs/EAMltGnhPSgrlUmDRcpgDsQoEUMBcvRbjAvtS5kRGDk57ZTgAEZv8ISOcK+N/HP/IfWrpOQBJWNWEieZ/hbi6GVctXUA4S9YuHQK4QwlKY2zxS2QEaD3Mnt8luERJShTIzFMBcjroyGuO3T2IrECYXXVfHdU4D3rt5dlADsLRDz4SMHj3XcJ7uymFXbZVuMboZlmfDUQc/V2bIfqUghUr3StDKN3ZVO752aTNwOSOcBCygHoYUsjBPOiGyr71ceJcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(6916009)(5660300002)(2906002)(52116002)(66476007)(66556008)(7696005)(8936002)(478600001)(6486002)(66946007)(6666004)(316002)(86362001)(956004)(2616005)(83380400001)(26005)(16526019)(8676002)(36756003)(4326008)(186003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nlRg2g6h+2tKoIrXOuqXNvk8pB0IaYoSVR0h1vlCBCkq778pJsYKbRvZCVvivUTAsY37LAkwAhzmApl7b9C3ZPce2RG5UwE34EQkPs9WxsL5JlHYHcYYVC7YBd0I8SpX2TM+Br07v1KDrz1dQzM5mHrEdgCmWuOri29+MwtP9ElIjXn25rdBASdeWjmHG1uVmY4HBOxAXULXn9mfGSDdtAg9xoZmvbrtsA8XGEDMWP5ktaAvv9kJdji7pzTiMU39UtRW7eRg2DsIxCsQAUQDRwSUNoC8qs+c3mWgGo1PZg8D2VMWkNx1IjEpybg+lB068Qs4VSaxpNAPPRFjh7h3bQqrtr2cvQVD7rIaT+cTAqBcqhhA7mytZ59mb65bBGA0wPFsIvd+6fAmNTM7atpS6dbIUZ+we96zeeig8XyHIVwU+mSaBsVZVDqRyN337dTmcfEVdzxcJ/i1H/ikcV4LiqzA/jQU0gIjsAexqfFiS7WC87Wq5WJBPMl9995qUXLpMdFbKyTDrfCfQ8IQxhLcDbvFvzGAzstuOPfOukdbv/1mTpMP0owdlAOrePYpd21J2TIrr1SCiKOInwjNdPHilLCLCtGLc3nLM7qeCHVFqf0Q1PyD1lem1mVtm0reYzkQO00x6f63+N/T/WH/BjunAQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751c7261-f95b-4ae7-d57a-08d8809441bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 07:35:52.6760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pegt6Z/Roe3Z5ufpRShBiAyRZk4hseCB79siGwLwleLfDdfmgywu/dUNt5UL4mQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3230
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add missing clock gating informations in amdgpu_pm_info
1. AMD_CG_SUPPORT_VCN_MGCG
2. AMD_CG_SUPPORT_HDP_DS
3. AMD_CG_SUPPORT_HDP_SD
4. AMD_CG_SUPPORT_IH_CG
5. AMD_CG_SUPPORT_JPEG_MGCG

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a33b1cc50008..7b6ef05a1d35 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -64,6 +64,11 @@ static const struct cg_flag_name clocks[] = {
 	{AMD_CG_SUPPORT_DRM_LS, "Digital Right Management Light Sleep"},
 	{AMD_CG_SUPPORT_ROM_MGCG, "Rom Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_DF_MGCG, "Data Fabric Medium Grain Clock Gating"},
+	{AMD_CG_SUPPORT_VCN_MGCG, "VCN Medium Grain Clock Gating"},
+	{AMD_CG_SUPPORT_HDP_DS, "Host Data Path Deep Sleep"},
+	{AMD_CG_SUPPORT_HDP_SD, "Host Data Path Shutdown"},
+	{AMD_CG_SUPPORT_IH_CG, "Interrupt Handler Clock Gating"},
+	{AMD_CG_SUPPORT_JPEG_MGCG, "JPEG Medium Grain Clock Gating"},
 
 	{AMD_CG_SUPPORT_ATHUB_MGCG, "Address Translation Hub Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_ATHUB_LS, "Address Translation Hub Light Sleep"},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
