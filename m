Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8050C43457
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601F52072C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q7StgHKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601F52072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DABA6EA1D;
	Wed, 14 Oct 2020 07:04:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421406EA1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9UAaSDv6eTqjXLhItmpZ5JcqO/JwaU6rgaCCyz/qKX1KC6iQFPQxoxYXYy1W0XZTh1N092PjAeheux9UykQIjjjcYwK6wgpkKCpWX5X0oLF1GU1OG/HcIJRH06pKTs0HYkOHgnojcmcIbjyGP2KdtlUh4CJi4dW34lHVLza14lVKDq85eca0zcXyt90phonaUrnZBDm+OiOWE/1JL8h2oYpkM410BXPtzoOmlZIAWkan2MBjEwiDwlvwqQTwQXjKmjB7XSTaPYnpS5XrIhnLXYdqyioWrkgJWjRdikPgfCLfaMcvnrHl05TpLTez/nmMedhMHpWyvOdrAtq+ghdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8YzqEGg9FL2hK5uNutkmm012EfhXdVwW7HSvt4N5dg=;
 b=eDGaT1+a+KwcLtzyTaIAIj29VTAqGyBdYAGnuqqmwhMyeiwfy8u26DkaruG53VeGNHMLaYpYObKItWYxjjCOufRXAmqxEFpIvnHFsAiWJYIlkDpboUysgBYsN8Gi8TiBBYrhGCxL4D16d/gAhPcLuEESb97mE2O0riMmxiulBtxnwrgsHYyUW2T39GdAwZnH6DdFgFded2glNQd3HkBqKwmw8ZmJQBQoFzKZHxo4O+m2mzonVOiIzNwjqZLwuZaHxC+kR1A1S/7gG1PHxvpD8ZYkSNRGfdb0cOMtTWw9ldA4uubs0McrGUd8oMATPSh42tXb1krVoljPLcX2tqkGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8YzqEGg9FL2hK5uNutkmm012EfhXdVwW7HSvt4N5dg=;
 b=q7StgHKqRL9OgYla7bwFVlcX7WyC8wQImvpihARI2XqMmVr1PbCt6DvcgqFHmwWHtty104cpcAByQoG0gZl9XVXWqek1NIfMFJqEFwJjzvX50jT/5/UrEx9EYji5rdLX27jtkELGYh/fJ5eVYaV68S3YFzxS27F+/QZHEzzdV3c=
Received: from MWHPR1401CA0023.namprd14.prod.outlook.com
 (2603:10b6:301:4b::33) by CY4PR1201MB2550.namprd12.prod.outlook.com
 (2603:10b6:903:ce::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 07:04:46 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::10) by MWHPR1401CA0023.outlook.office365.com
 (2603:10b6:301:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Wed, 14 Oct 2020 07:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 07:04:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 02:04:44 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 02:04:38 -0500
Received: from yifan-AX370-Gaming-5.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 14 Oct 2020 02:04:37 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: add S/G support for Renoir
Date: Wed, 14 Oct 2020 15:04:31 +0800
Message-ID: <20201014070431.32207-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014070431.32207-1-yifan1.zhang@amd.com>
References: <20201014070431.32207-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73fa080e-8f73-4329-4bda-08d8700f6ecb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2550F98B8DD18DC427281FA2C1050@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30J1vWFgyylqx5NGaadIxJ5u53rv2wtlJ84Ji5U3D4IWpS7Zr8ajxdEgkt6POUvvlVgdBUVb7zBMo67XXafBTX+15KssNg91mpFFOts2MAAeV6eM5pClfxmWpfr+w+MxwPquAO6NRUHX9p/PgPl5bBufLFCMWIR5/YiQBljrn/KvrcEY7tUabFgxLhmAjy07qctio+7cDFDFWJQTPDeNzNPOsuZz7sjEdlHumXiKplWwlTihKzKHc6/RyIhJL2vXu+JGqUZsg/Fhf99Znjko731ZYDBye9KFetvJYxHe5pg1mMD/QorOOW0vOVdL9fa4rJM+JO1dkkNxbWxEhkRRBTLN+rLvPhOtE90CqZblQ8acdE3K2O2NbnZJnQHXq8ktZimN3aQzURCl+renW5aq2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(4744005)(8676002)(47076004)(4326008)(8936002)(70586007)(82740400003)(70206006)(81166007)(36756003)(2906002)(356005)(478600001)(2616005)(5660300002)(1076003)(54906003)(336012)(7696005)(186003)(26005)(6666004)(316002)(82310400003)(6916009)(86362001)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:04:45.6853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fa080e-8f73-4329-4bda-08d8700f6ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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
Cc: sunpeng.li@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: I382a5eac1002a6cb80500c08888e593cba95e2da
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 8e1d1aaead7c..9e92d2a070ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -528,6 +528,10 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 			    (adev->apu_flags & AMD_APU_IS_PICASSO))
 				domain |= AMDGPU_GEM_DOMAIN_GTT;
 			break;
+		case CHIP_RENOIR:
+			domain |= AMDGPU_GEM_DOMAIN_GTT;
+			break;
+
 		default:
 			break;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
