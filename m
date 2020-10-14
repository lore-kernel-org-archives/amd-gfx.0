Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7905DC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 05:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FA920B1F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 05:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WLP0P+HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FA920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9EC6E9D4;
	Wed, 14 Oct 2020 05:20:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31416E9D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 05:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P00bSUynfwE42Va4JUqBoGLsz3aOs8s7tH6UkTpRw6yreVGImlUQOFNGCnxwg8SdkEbumqf3ZE0ps435gRLZRZzJk/wRtkQII5eqJCiXh6IXAtNByQcGnIx+8RaU7bIT9YvmM+JldhTW5vqzbGl49JBi9qx7XG87z/HRorar748NZw9jN1yCS28LDCqdEd72ZeO7VAJQyjd+SrKOYvp1VT83gKyPkLmDvQ9BQZpyWwJXnKLOuJ853m8HK0SFgUzfI7whbWAUGw/TYNL9mJuppl4iAoYO8vWyvU+50ph17v4wR4BdMg56KrILYFS47bILRmCHj3yLXgFiDuPXGytHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JpLZSNDZ3MF00KqKhg4dk7j4s2S+vQ9AWThlBzVXQM=;
 b=RzXWcCxjUa8G/yZm/x9mkelWtDir7cKXEqUKWeaXGEeWnoxjccP21taKpFSYgG1HOvPFE06Niw7p67b0m9WaXcEfDPju8F32DsArmNe3mPI6ePBwvH1J91YJcg8jkeusXz1WFcMo1N3JPb3ll068j4EPbsgf4+LixtU8WP2ovLhy1ScSCnsu95MTWGrOL/3LAeyzC+NDxZfupAZ9UVZbPKQdM1aXq1B9ihtq+kO+1cCriTp3w5usNDhp2rdA25h3eJpvvwtA1RND4sQpFi3Nx5fjStJrnbNShZidF09IDnsEqIffmqJD1tkGn6cKoK22EMXshazkY6pcewEVAQL+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JpLZSNDZ3MF00KqKhg4dk7j4s2S+vQ9AWThlBzVXQM=;
 b=WLP0P+HWlLH5+oiCGUZSzK+SuBL4pPiUhPK8hkhElHXSH30OjnjOdjZIxz7FzgZg7WWFeB+o+ZTIy7fZevqCM1RVKCas7ahN88mZ4QKg2X60+FkcrW2kLO1RoPXodwLIuDroYQfljcU/9+5xB/vWUqVNKjopt8kvdVKymc+PSxk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Wed, 14 Oct 2020 05:20:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 05:20:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: populate the bootup LCLK frequency
Date: Wed, 14 Oct 2020 13:20:22 +0800
Message-Id: <20201014052023.7085-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.3 via Frontend Transport; Wed, 14 Oct 2020 05:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11c18039-f234-48ea-91c2-08d87000ebc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3468B9E551137280E1A9BC2BE4050@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuGbGNwsdUDWmdXPlmy6UHFpuaVCTzFdhmR1RmvHipf5S6xYDGojxmEbb3yWNEw/Y3POQQPZyjfWuKUyeavR15sTWvO/Iq6i1B6pviLb52WP81yTK5XZyIsAIKJatQ5Xa1D1mxkox67z8IIx20tqryc5Wb/Pxn35Mb1Mg2JM6X2wK5nwc68r7rjHfXa2Sf+Y/w4vcx/wKzROztSvMavDX6hZAxniQGrLlPJX53dNAjEDW2X30X1MwzWFGOzuvhyHS/cbDo00W/EuaDMuutk67UAO7n92iv/aRBiZl1A+OORcWGBelH1aQm2L4SvXzYRglf+G8pcuk3untTUzExn0zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(6666004)(4326008)(7696005)(52116002)(26005)(36756003)(8936002)(6916009)(8676002)(186003)(16526019)(66556008)(66476007)(66946007)(86362001)(478600001)(2906002)(316002)(44832011)(2616005)(1076003)(956004)(6486002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QkzyL+ZQm0N6SJBMp41U/CbgAzknnf2LPdqecAOzCfOqTZFSJG8zK6q4KxQFT3PatX065z69yOfVC52sh6zEaxzxUOvYA3CZ6V2h76IjHHkZn7mW5rGJkgulpp7yGgp8fwyEx+K+CwxPgeLi0vFnF8sA4xPo8qx4RzUcXwWTU86z9pau+Zqpyy75CtBh4zH7YAbbhMYITX/ob8ETjrpc1Z9X9V7E+wAFVJXRpTJCxR7xdpiFxhJKu+bVAZZx3rhagKUkdJdEjI7eyJ+hJltjAkng70JH2d4fCZ45/ezF4ZTTcKHMTtN509aWqipUj8OrVq9NWFISwi8iSqDERHouhwbPHCBq+0abkkvmDoCZ5LfU9v85nlZwkcDxkjnfGnkQ6IczlAFrhnVJrktbc/s8dhhL+G/d/sSBv16BJ8aSnWiB4J4dZw/q4kfcvNoNZJAY+qaSfWBi5fjQxkIJcrh0i5seQw5L0bRJo4gXFGgbvCEZ5IGwxxTHl6ks/0XtNrWTKq4Ea9BcsRWOi6b145CSF85LdTEtLR+SJJopdMWDjaT4tDz7ZMFTSJA9RbVefPNEnSYaqnbyQpV7w/+P6xe3JPqxr4JmV+J2JcowCCOyQBnCQXTAraF9zGGwoI/3P8jPOtbjGqTaKz/yLMKl3z3DmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c18039-f234-48ea-91c2-08d87000ebc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:20:53.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiYStFOsOkhG98Z7LKAh612rsxBO86b33lOIruxUrevHNfQhGt4LHikXsX58tEXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As for other clock domains.

Change-Id: I0a78c133f00cd11133bc755bf0443505088f024c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index fafa9c57e32f..9fa9473d418f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -226,6 +226,7 @@ struct smu_bios_boot_up_values
 	uint32_t			format_revision;
 	uint32_t			content_revision;
 	uint32_t			fclk;
+	uint32_t			lclk;
 };
 
 enum smu_table_id
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index a057d1d15087..fbf6d3e35173 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -603,6 +603,11 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 						 (uint8_t)SMU11_SYSPLL1_2_ID,
 						 &smu->smu_table.boot_values.fclk);
 
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL3_1_LCLK_ID,
+					 (uint8_t)SMU11_SYSPLL3_1_ID,
+					 &smu->smu_table.boot_values.lclk);
+
 	return 0;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
