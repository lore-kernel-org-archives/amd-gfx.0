Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6489DECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A459410F2F7;
	Mon, 29 Aug 2022 14:30:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C6710F2F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPLl0tIV1c8d9orQhyfLV5X1ro7ye6LwxC/vln1uhOXXGMlieTPqmatnSlF7MH5BeOk58crMDUVsL0qDOYcefLLs/A7epLsc+xOfPyUI+3bO013ODUyIDDd1pNrwhDqPxDACuRAw5JF4B8/NM2sB8zIxW4JdZxkRtyjnwLC693/WDQTRWp+IC19PmQUpHVsEzoMGV7r5fKBhylIB+4ljQTURIVeiFZQTHwjleUvAjwUOO7y9Y5m+bU0w9XTHtUTxRcUJgs5pwKgao2B3/4fNRn4l3PmUIwO2jhw91+pL2pmzjd2jpSYylXB72R0Tperlcj6g8FalSi0h+93ihjnvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FqOgNuKREe1uVi4HauBpphoMuOdN9+vsWBJ5YIF0YA=;
 b=jH/ot4bsK4w6Fh9Pi5WZpBN2LS8g/rDTWHLOyEw45/LQLdpqw9+j/igAkxFaxpKla6oge7uGqc8tuBdYDoXmIrVm8H7/AX/PI0cZZeArfShOcbkt7bV73Y3Tbj1UBZojqbANhhunGM2V+K+YwvygVa3MVvddUFYm0Ub13nCpXDRuBQiMrsU0uOHnjqTmPBMcNBh/YYYR+46+YRA0YxUbq6MadU38ka83gE1FoWi2cz7PTq2NeJy+8oC7ymrwjWuhWU7LquBuR4L2nH6a1GuJlFfgHHDefTSS8XC6d3CMDI0hxDuuSxGgl/6STRnY9rhxEVNEvwLZXx0SGQ4teW9e+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FqOgNuKREe1uVi4HauBpphoMuOdN9+vsWBJ5YIF0YA=;
 b=SO2nh8d8qkgY1/A6gsonZGOnypLLqgJHJGZya2OpSH1o8gExwxbgtt5EcEXkYwUngkLNceTWexGSjkV4i1WaNtIv6GOqyGJhpCh9ULqfVyB5DTv9WMrbxPfl2omC2hktiW6xMkDsHy/VSgk5UnY7oETQ7S1hgaN9D7tnwrhdzwo=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:30:43 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::a2) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:43 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:40 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/29] Introduce AMD GPU ISA Debugging for HSA Compute
Date: Mon, 29 Aug 2022 10:29:57 -0400
Message-ID: <20220829143026.1509027-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d4ee85-a20c-43d5-2074-08da89cb0e43
X-MS-TrafficTypeDiagnostic: CH0PR12MB5154:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsXLML0jxAbKOV++CjrAWN6Qgf6oPy2F3IU/QjHtWhdv/ExHnt1YN8LWbI5/N98yWtrz4rYksfS/fj96JyLph4Hc0CmckrsOrkojG8AjrgDcjvkb0Q0IILoWXGhWA/rI3Kzcz2FrJxCIMjL5vH8I0yGQkVHI3VQaHAdh2AhUcOiCWibzLOARCRISQf46zTa12mCZhI2YNwRkpi0e0zbTPaUbP5n/giFKoHQDqnn/AQnqkZSJpJ4A95MfkmeZtdSpaeONS9fOl0sGaOI9DEo7/mtGYy8Pd3jCbd35oQmM/loUNdQn5OJOZ+4d6GdgX3ZnIU1j46ZvTMBO9ilyeBDAsJDjIFMwC3/u/jvrzlIZfyQBxXfJJC0vM/JvOz0ExyhZUefiaaUdNctU/T1TtFiEj5MdycW41OlBtAtkrBCE8uKbcEfBaPuGQ24w4N6hkjY9YtufBN/2M1231/Bg6yEn4V+qoFLqf1GIS8tphED8wSZgeHz6+o4yHXe6hjB0nNK3KEiABKHDCk0pQjmO2WOqZmfrPfrl56LuBU+qnVsiUn4wLS0VxnkYWhREwn07mO07dm5NojgJjM+XWBJhQiWaUZKvoyXifkBWJvoMALDHjuA/tj/uSCOexhP1wL0vyRl7mIoJevenHOFQG8OopWmGBRTD1rwdCG6iV4c1+cs9kwyqL8HojOUAcJfoSzsgpEeoo0A+WciZfExAUYOts5FvXn3a1nCtObcDyQrUrVPciokCPRUq1FX3ooPnB1feC55ZUTTHkIMzJo3T4xSXnqCQHf7xn5aHX9GGxKPXhwmdnl0+k8S6FY6CPvDgnHm7Geoc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(40470700004)(46966006)(36840700001)(86362001)(70206006)(26005)(82310400005)(478600001)(6666004)(7696005)(41300700001)(40480700001)(82740400003)(16526019)(336012)(186003)(356005)(40460700003)(81166007)(83380400001)(426003)(47076005)(2616005)(36860700001)(6916009)(5660300002)(8676002)(8936002)(54906003)(4326008)(2906002)(316002)(36756003)(44832011)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:43.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d4ee85-a20c-43d5-2074-08da89cb0e43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series is to expose the required KFD IOCTLs targeted to enable
ROCm's extension of the GNU Debugger for HSA compute debugging.

The series is divided into the following sections:

Section 1 - Drawing out the interfaces and preparing the KFD for
enable/disable calls
  [PATCH 01/29] drm/amdkfd: add debug and runtime enable interface
  [PATCH 02/29] drm/amdkfd: display debug capabilities
  [PATCH 03/29] drm/amdkfd: prepare per-process debug enable and

Section 2 - HW initialization and handling the per device HW debug mode
enable/disable requirement
  [PATCH 04/29] drm/amdgpu: add kgd hw debug mode setting interface
  [PATCH 05/29] drm/amdgpu: setup hw debug registers on driver
  [PATCH 06/29] drm/amdgpu: add gfx9 hw debug mode enable and disable
  [PATCH 07/29] drm/amdgpu: add gfx9.4.1 hw debug mode enable and
  [PATCH 08/29] drm/amdgpu: add gfx10 hw debug mode enable and disable
  [PATCH 09/29] drm/amdgpu: add gfx9.4.2 hw debug mode enable and

Section 3 - Preparation for HW debug mode setting and event handling
  [PATCH 10/29] drm/amdgpu: add configurable grace period for unmap
  [PATCH 11/29] drm/amdkfd: prepare map process for single process
  [PATCH 12/29] drm/amdgpu: prepare map process for multi-process debug
  [PATCH 13/29] drm/amdkfd: add per process hw trap enable and disable
  [PATCH 14/29] drm/amdkfd: add raise exception event function
  [PATCH 15/29] drm/amdkfd: add send exception operation
  [PATCH 16/29] drm/amdkfd: add runtime enable operation
  [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to TMA
  [PATCH 18/29] drm/amdkfd: update process interrupt handling for debug

Section 4 - Implementation of the HW debug mode setting operations
  [PATCH 19/29] drm/amdkfd: add debug set exceptions enabled operation
  [PATCH 20/29] drm/amdkfd: add debug wave launch override operation
  [PATCH 21/29] drm/amdkfd: add debug wave launch mode operation
  [PATCH 22/29] drm/amdkfd: add debug suspend and resume process queues
  [PATCH 23/29] drm/amdkfd: add debug set and clear address watch
  [PATCH 24/29] drm/amdkfd: add debug set flags operation
  [PATCH 25/29] drm/amdkfd: add debug query event operation
  [PATCH 26/29] drm/amdkfd: add debug query exception info operation
  [PATCH 27/29] drm/amdkfd: add debug queue snapshot operation
  [PATCH 28/29] drm/amdkfd: add debug device snapshot operation

Section 5 - Final version bump for interface access checks
  [PATCH 29/29] drm/amdkfd: bump kfd ioctl  minor version for debug api

BR,

Jon


