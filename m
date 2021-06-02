Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83089C47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5033B61C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5033B61C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6696EDCF;
	Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5806EDCC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnlEOk348YWgiU42HCtiU9ni0FYuCTR6c/tACwdtkNBhAJkuPGmjnxnFFfudTheHUGnhXv0mr6bm1yqCfh3dLWfCVWIAHKKKxxqka+vLB3l+eeY0OV91bqPyQd5NSjSOwPOQzbAlgWNXAQ4Hl7evLZl3EtHF9Vf2S9XXvUGtXFQ8j4xFeUdywJEwJmcHOJ0K0KncHz7yChESc6deseW/iaasOwh6v1K9igbcmh+Tl9tr7+EyCPaR0ab9QgqbPKt8MTfz1qKR/4w12Km1WP2jIa4TU85g6mJWPnwTNuh4Ttzp7ao1iSsfF5UQXgYe+amOVwM+Q3ROaT3km7U0PMV/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8deyxxlqA0BM5kpsc8/YkjO43OGAAOGBaOW07Q0kU8=;
 b=Hi3BgJsslZog+Ga80VVZwk2myVbW9imOYnQ54lCho+3TLbc5SooTTRmkHjQWVkI4netBuwB9cH8dEzpYpyFyOHgtcwTlhSCki3E3PkXlnuOQyqgdSti57LPvt5wvuI93KxGnewNOXFgnt3+sh7i2L5h8V8ohuK2eTOfio49/72bGEPd/LafagOFDkuzF/SgmLlk7Pp2p0bHdQpKW37lph0duR5hSF/yRTdumAJ6iw8n8A6FmlktvybzzzfcX2g7vpbh+MwVHg3F0EIZ/P4VFwZXmrbsoRv+rqBebeH16jKgSINlohsOO0xZS8QKCmmsZ1OrAcLx2BYXSvVSMcmW2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8deyxxlqA0BM5kpsc8/YkjO43OGAAOGBaOW07Q0kU8=;
 b=CGewr+FKSWQbQW4jt6db+KV2yG4k00gB8zXZglofISavI0t1kVoydcjBZ7uO8GW1jMja3bFWaOd7h5BA1zUTil+AK7UWkgwskdSEq59FJlgkylKUjIVp584Itk/pFFtW/JMgETEMJMzU6xUai4PKX4lB6CZw1R0cO72GHfcRuXg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 64/89] drm/amdgpu: correct the cu and rb info for yellow carp
Date: Wed,  2 Jun 2021 12:48:43 -0400
Message-Id: <20210602164908.2848791-64-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022e462f-5c67-4637-1612-08d925e67ccb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24349C555F315C57F862DAB8F73D9@BL0PR12MB2434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XY1KDbZFmzBXiBhAmw4pUZedjoSOIe8dOjQfCslv9dHQctAYshx17VuZup4pDxPuJCyuXZAlo4ug65Ev5Hltu3txrr70X3foh+elY6MX3N57jdBXG8WcVrRONRXz180IWD7b1awc+Z+lyspQPxliCkJL/2+h5KbTM8Ns69HyS/tdUL5TJQDlvWBXBvFaPsM1Ce8DhaDvt1AZ2dTduZPj8ZIK/nVquDgIQbLLefse1Fax2eM7b9Gp53m2ro2olvOyZaWvR4bloXpwOtNYSy5oBDESq4cr6CmQ9pNMYlMe1wZD3VghB/Sn/FcpCWlBn/H9LHXYl+OsRPiJpK0JhOrYahiffGeSqvtCSiVN2WDF8S83VOTW78EnygBO3Z1Kk6F8L8qfFxSf4IEe3L4hJA1ST1Sm6ra7FDvFfO384tHBBxVMcxIkquVcLL5UyBEMJAecU1K38kB9l3fEn84mtX+5NmQB9ozKgae/FvHm11svHVQOnxTokS+KE2KdqTzLivA98AIYUpedJqApvVTBu7sKcJ8yznd6A8smjqxjoRigx6B8vzxZSbggWOG5BCaMW08ErPwavzI4TyNlcTLIgmbWUNyHx1DARe4T3g1q1rkFyRTZlXNpNSXpw1w3iCsdySBB4Z75z0Jrq5sPnE0nbj1NEjSsg2JCCSVG5Pc7OckT2M5I38oqUbgy193sHMLeBzQ2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(52116002)(6486002)(6916009)(66476007)(66556008)(316002)(66946007)(36756003)(54906003)(86362001)(5660300002)(16526019)(186003)(6506007)(6512007)(26005)(6666004)(83380400001)(1076003)(8676002)(956004)(4326008)(2616005)(478600001)(38350700002)(38100700002)(2906002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ileAaOSKG0aXeRlADuZi1Zkk/kgtFYe4AX568CYwt3omP95pS5X4UW1wWzEl?=
 =?us-ascii?Q?JnSEiALqbLp5FLrClxIRwpZxUfagKKam7H6Nsg2ciXgPWI8PQ1URpSqpWxtP?=
 =?us-ascii?Q?ViKn3YtfGtSi9LKCwRqFcB4qhxFeKuo141CUaC3mSUD8slyNhoHE0xx1Jg5j?=
 =?us-ascii?Q?BK4qJkkwG/EXf3M2Uey94/YhMAVevW78/DSu1YmKqX4DEzhb7rWc18pxKNvW?=
 =?us-ascii?Q?TER7DaEIw8/P5vqATloGy04YlA817U64hqY3ZHSz9MXl5TVrCDckcQcszKfc?=
 =?us-ascii?Q?TgJEzg2ggzQN6Rs6K0IngzB7qna0bfJNlX/X7Nc4uGTRMcG0yWwvnFaD7bRq?=
 =?us-ascii?Q?h4t05bkym9dGl93dGMG6oeqyG5uZBYORR96u0jWBq99qODiS73iNBrcGIDIO?=
 =?us-ascii?Q?zHHRMA1BD8AFizLjfBp2Cb9ZX04WgG/tZv5CTMl0wfAUqF/+mEZS6smKuPh3?=
 =?us-ascii?Q?ncn439IiXGa++nLNs6sdJHmUbQxWF4Hm5fcS0nSskcW/cSXfatjF5vb+Sj7S?=
 =?us-ascii?Q?52qNPFSkNgwYJECPo74R4LEqigid01DtfayY6nsslIPHQonDFmasQciuqU5Y?=
 =?us-ascii?Q?RWexJyrale4NzdyHVQqzSs/RSut0p0UjoxIgTHxXviVuNXQHTj/8fCuP7DEi?=
 =?us-ascii?Q?+6QFVEKJ+COnf8h5/DWqtPhwWo1nOAxvBdNQygNzRhdwepA27CyWbe4ejopt?=
 =?us-ascii?Q?n4gO2LlfKl/zq6fZvKgt8izG5+cMDWoiHzZejBxq25S/9dY3cVbOXyowLe8e?=
 =?us-ascii?Q?WNeSum/iO5WaeOjN2yjof3hzrhEhQhj13YDIW9CKZ8C1PvZcT8Tv6t7jAbf5?=
 =?us-ascii?Q?0F0ARNloX7pH4rALkVXxKNqqWL85YskgJtH1u1Ajwezr911n9RtRRixeSnw8?=
 =?us-ascii?Q?58g4u6HE+x/cSqTqpgzxtiGtRXfKZuO3AT4H5itrvxDKiUm7el52u+4iNnDH?=
 =?us-ascii?Q?OV6N5KQVULSyJPTit6VekGmhsm/UPtGLHJDSMrIk2tfyq9XroBOqadbgh8/V?=
 =?us-ascii?Q?SzXdV2ZUOZe0+sveJeia5XgWCOgs4+HGxNO5LW0GcfHb57HVA+xmFtg/rNdh?=
 =?us-ascii?Q?UswN7fId1ESgMh3CHWSJAy7vCDWFS/Z1S/9MREy69OY73adCPZfylIM5VrYh?=
 =?us-ascii?Q?DVJNbFcDc/hxCI3yiQ6n1clzPJGE+u9Lisl5p5tcaUCzwdbQmIRLeMScledq?=
 =?us-ascii?Q?eH53VupEJpq0QjW/TVQ602qQh4Xm6pSLoFHklX6syst+urCSbWXj6OawiIoG?=
 =?us-ascii?Q?JyIIsSXvH4DYS1xC1nfqJ/zCyPlhDKkGy2nyPiMB3CxTPTijJ1uHJX6HYaMa?=
 =?us-ascii?Q?cugu9BoFQLVItFLN4l57DGrH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022e462f-5c67-4637-1612-08d925e67ccb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:11.7439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltQUue4WZG+pY1IU9k7TtzXWgdCayg0Lp44Jw+Gn1YAon0V2GKGBpEsNef8ni81XKUeBZQVnHQ/kSN16V8FDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Skip disabled sa to correct the cu_info and active_rbs for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Suggested-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2b166dcedcce..c0b397b31c61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4944,7 +4944,8 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			bitmap = i * adev->gfx.config.max_sh_per_se + j;
-			if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+			if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
+				(adev->asic_type == CHIP_YELLOW_CARP)) &&
 			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
 				continue;
 			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
@@ -9358,7 +9359,8 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			bitmap = i * adev->gfx.config.max_sh_per_se + j;
-			if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+			if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
+				(adev->asic_type == CHIP_YELLOW_CARP)) &&
 			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
 				continue;
 			mask = 1;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
