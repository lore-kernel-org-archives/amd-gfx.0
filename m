Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA2C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4440561440
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4440561440
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92FF6EA8A;
	Wed, 29 Sep 2021 17:45:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492076EA8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 17:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU+kLwV511Pc+yEJeIog8nSzGHqv2TIwwQQw2GDSdEbZ6t7yyIEoOPrqjsO2USc8bZdaNIOeKk+1i5L7kzWYzyZfFSkrwHj++vuoR/SZwOanrRWCWDU4tlm1oF6DPdflaZwaXOl6PWfAjOSDDoD0/zEe/x1bGeSmX8h9LcQOwgloWTk58AKJrQAwDwf/VdthpXIUMLEIAn1SxwICCnM0X3DR8rLCyE+/EqgwTvBiFzoXkEUtYhYkvPL0mWzvnBjz4EFGtGzN01Ugzj1iPwC3yhaGZB8Lhd6IWNvVZC9X/Bcjkkysbe5uaMPdyhnxdtY/LonfzLAmkU2fasdHQenHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ECxce/XcWxm23DKjNEYDZXWNGvW2ivELM5vrl9v2fbw=;
 b=dallWwd/fvCun+x5FdHEhm3FyOPGHLoSixvjLZfmc3N9tr6yzuSxzTDkNE/fwp3B600kps8Pxm3dRT7pIuy69ffTCy8qezIMlbfCo9BgvkeRwWLskKXa1j1JMsHEMjVwaNNWkDwfyuACvHaVJOKTKhROGE9Vo0xJD/tZlWVZ0RzSh1goDW32P3Rr28jMQ/GJ/M5uh6755mNlB8rK/xJzjRMamfQ6NMOG87n/J3/ywdgxYoN2c0SdKfADmKmM0h0UTqacmt8rmC1+ddnCcIvKH7/2B1WxZYvguxOfE39e1dAskCf1nbUc/Y82psr1SkWRnGYrLUpFPVJtuvTudm3JIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECxce/XcWxm23DKjNEYDZXWNGvW2ivELM5vrl9v2fbw=;
 b=XBwRXbdhGs0sHCF7utgoGfF0oJBomgZN9Oa7msJjhuZAvYAeZEcIPNwJT7AV77XQ587RoJBkS4PIRL3F4DymIK1FR2vSSd+P9DkaYo2JOdnEm7TK92GLASbxZoxM6gL6TJdr1sKQ5BbGGNFJ1rLwPxSyCsLdfPqHd1cjPBGaygw=
Received: from MWHPR19CA0003.namprd19.prod.outlook.com (2603:10b6:300:d4::13)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 17:45:35 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::85) by MWHPR19CA0003.outlook.office365.com
 (2603:10b6:300:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 17:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 17:45:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 12:45:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Documentation/gpu: remove spurious "+" in amdgpu.rst
Date: Wed, 29 Sep 2021 13:45:09 -0400
Message-ID: <20210929174509.1640343-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929174509.1640343-1-alexander.deucher@amd.com>
References: <20210929174509.1640343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e67fa57-c71d-4d5c-e999-08d98370f10c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5318C24B599F5F544C97CE7DF7A99@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXTu5i37mkd/kkPsJTZ1ZRwskzKcEkxVTtRwkX8WYy0Ipeu73I3T4Adsgdg1pDk9KKhHLzqRCs3CbfYpjlDqz6hH/fFG6xrp57W9FCMYdRSH0JgbuK90c39nNa5R44JGWJ3emb8+reRGEJKDO9nBh8GfAnoFFbRJdVwLsHtczSDFEkW90S6OHSFvRGnSO166ufc609GCYRefD2laTmjNmQ2rTEof9/gRoTodzkTRadnuR52QqhrmjnCddH1R+xmI3pOd1ELQjUuJ2Pic1VzS6S/NUGXt7r5pMeo/vUe3UQAsn4oTx/BJYSFa8PHQ+MxVQTSLlfIOvd6UDxcGDDnz/l0MwwlC7jgweq4m8W54lNRXv4cutDMoeY/CJ+5Yj7uMgHgm0BmMQwQnEAH2SyYvXa9k61kNrdlfX03+uu7m/bW7pajcGwvwADWFbVQLQV2mpAQQaxi/0qv1qTMhY4YsXJLs8uCT3SSs4oUy8DUYuCgmrG6WDIQnr5jeo/jLa+iXLRP2xKhV/0MeB+xhxDzb2kBEJj32+kPq6wsWeYuZfGAYiUerKmffS/fPoCiWYjvGsnxfrNLU8eudJ9HO4fPj8EoyMHpaf1uctLrLKmdGwuIUi9YE7CMAmwX3TfsSUghaVEi7lfI5FiDJYX7OTMtr4DpwpkO14s6SF2d/4LKw3gg6J+PbdGVpAK0qr2iIXn7fIgJpzgI8aTTQzBxGoWHROnB+IRcbYoKGqlvobKz3N9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(508600001)(7696005)(47076005)(2906002)(2616005)(4744005)(5660300002)(86362001)(6916009)(16526019)(36860700001)(6666004)(8936002)(4326008)(316002)(356005)(70586007)(336012)(81166007)(83380400001)(36756003)(8676002)(70206006)(186003)(1076003)(26005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 17:45:35.1917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e67fa57-c71d-4d5c-e999-08d98370f10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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

Not sure why that was there.  Remove it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 364680cdad2e..8ba72e898099 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -300,8 +300,8 @@ pcie_replay_count
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: pcie_replay_count
 
-+GPU SmartShift Information
-============================
+GPU SmartShift Information
+==========================
 
 GPU SmartShift information via sysfs
 
-- 
2.31.1

