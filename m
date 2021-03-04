Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85699C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 19:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280AA64F8C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 19:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280AA64F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762866E105;
	Thu,  4 Mar 2021 19:31:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276F96E105
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 19:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZyKkhKU9rVKG4zK4ypAjgHYVV5i8ZAzfiM2EBsLK2qC03l/j0zGPuk5/tE7ajcqb23xqWCS6XSuH/Y3wED+hrfby3ejMALIs/aLJxdLqfXs0Tcx3C4I3dwwhrzUCw+aXRMEhSB3ZYirCD6iFvVy6Y3E7Tb8DzYxfo77uGfio3G5JJnUltAgA1NeCQWOhOxzeMumUwboy6vcEFn01vS/gFaxrfHOeX19hhuV1qGIfS6ybBWeIdWnHbxpnZvAQl8ReMdQcYg3GlYqeVmNk3BIfcB6gZjN9zYs0iK3SGCcTB5AghvBhiVUzLHfoMhAtEyomYn0eajPy9IeZprfgSHy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1RjQ1wUV9RY8pA01xPKdN5RnEKaGqV7/+p9FdLpkKY=;
 b=JCOFx+K0gB3SAO3sbfd1L564UmjU2eWzBXGR1A3wq3TlaMAT2TvEKv+zhpwtoPHM5lYUkYMUsYqSFhaetx/EQ5xu+XyAppXLh7gjv5zmygciHvM9saPjNQ/JvxFrz0fvgMWxOlmYe6WssZLloDUsIoD3O71kYayo3WihfaJb/yxDfIWvTBtvO2bANmjMlNt5hv7KearVt+v0r245P6az0REyxR5SzwikQVBaj221Lt7lJbwCJ7QZ5te7RjztriWUYkAjN430pzIT1TLkuij4LQSgPgiv8VfbnniSngjqqhd1ZATzlUnG6IUU0jIP6WI4c7WqwXT/1o3XLyVlofxfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1RjQ1wUV9RY8pA01xPKdN5RnEKaGqV7/+p9FdLpkKY=;
 b=1eccr1GImDKNFaSVroy8RB71rewsI7E9nqGVODRgrsMGDS8qP6U2IJR1vZdQsHaJ5Lkw8KnLpukQJdzy4S5MZSsPqNNZFNv+2Yg5JqasGZaeETjvbZCGbBRPRIvV/HB9sUMZApG0aKAOlyuN0j2LgD9s/k84X4Zs09/mpj2hiyQ=
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 19:31:10 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::ea) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 19:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 19:31:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 13:31:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 13:31:08 -0600
Received: from leo-VirtualBox.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 4 Mar 2021 13:31:08 -0600
From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
To: <Rodrigo.Siqueira@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: add DMUB trace event IRQ source define"
Date: Thu, 4 Mar 2021 14:30:49 -0500
Message-ID: <20210304193049.3368-1-hanghong.ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b198b9c0-d5aa-4daf-6c98-08d8df440ff5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25240860B2AFDDBAEACDD773F1979@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47NHtrScb3+Az5n67B1uVN4Fu/bUno7x+jfVYe1j35F4Y5uaVfzFQ7wEgPboq9JBkEoZSDZ96o8dPAD7yBaBkAXb/SwkUZAxvw+BDSMIGqC9wIs65F2uRHbEycpdF6P1rNUHGxsJprKbsr4McfBHnSLXLQv23WXe6FIGE/Frb/Ln7fhtvFmol/lr4QeOGyXembdKG2Ecfk2GTy3H1NwsKjrBjFQetN12C4AcclrdDdpHmYXNiXt50QWTwpo90gXFMz7x/ASBVVktDjSs+Mqpvf1VMC8VlU5knzW4NiHPiC9+GZgT24+vrczVYwhcjm1RFH5JRAK4/IlXFnznW7Rci+IRxFh5WidcgTxPMM0h9GL2yT2KZLQuGxwzUxNY5fH2j6zKmfBVNOBjJPEPby6C8j63KG5gAMjfzhLaDnV9ywU5A3/4SVBplOIMJtRBVKKpg7o8qvJe4xvUoZhqJentLCqOF64xOn6Qk698QmoL4XA3dL5q6ITVK5tsNXWrs2RSLFERBHBPgDWgmuNEz6UUAMLfzgw0evL4R0/+gndU1sbkG3HGtK0VW1eWLL4yYsT1gvbzK9YhETVf1AI62sdjVfaOu8fIbkJiTgvXPWVcVByLPk2osW2UpMA9qjlEQxhHUi8oGuAixVzYX7+2rHS5rdpr5OhPzFRZ+rLmt8EuHHzCFK/hPn1kTkNRA//aLjDy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(1076003)(8936002)(86362001)(36756003)(5660300002)(82310400003)(2906002)(2616005)(8676002)(478600001)(336012)(426003)(83380400001)(110136005)(316002)(70586007)(70206006)(356005)(54906003)(81166007)(36860700001)(7696005)(82740400003)(6666004)(26005)(47076005)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 19:31:09.0138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b198b9c0-d5aa-4daf-6c98-08d8df440ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3590cb311815b3f82af04e2ff1f182ca919af3d3.
The patch is applyed mistakenly before code review.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 -
 drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f01b75ec6c60..1624c2bc8285 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -912,7 +912,6 @@ struct amdgpu_device {
 	struct amdgpu_irq_src		vupdate_irq;
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
-	struct amdgpu_irq_src		dmub_trace_irq;
 
 	/* rings */
 	u64				fence_context;
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
index e2bffcae273a..ac9fa3a9bd07 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
@@ -1130,7 +1130,5 @@
 #define DCN_1_0__SRCID__HUBP6_FLIP_AWAY_INTERRUPT	0x63	// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP6_IHC_FLIP_AWAY_INTERRUPT	DISP_INTERRUPT_STATUS_CONTINUE17	Level / Pulse
 #define DCN_1_0__SRCID__HUBP7_FLIP_AWAY_INTERRUPT	0x64	// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP7_IHC_FLIP_AWAY_INTERRUPT	DISP_INTERRUPT_STATUS_CONTINUE17	Level / Pulse
 
-#define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
-#define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
 
 #endif // __IRQSRCS_DCN_1_0_H__
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
