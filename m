Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7F7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055C510E9D9;
	Thu, 28 Apr 2022 18:48:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39110E9D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1+uBRRpWM2lPkiXL5NraLU11vtG88DnsExD0lK3AUApWMVUHHb6zMQqBe5+qIbj8uf0s7ZJMrh+u8P3aToRS0ES71qUgGaEhXkfvDk29/NuXuQgiuzn/8YG39dUbdWnLRg60Q5x/E5v5QZVQUbvaGX+TNvvY3+hwVaWSyaHur7rqhi8UCESJBwh/HE0hmqgo/5rlTViyi2YQ5wwJ7jnvjnEo8YMKPmfqDx9ZwcBuWvJYkq+W4yGCTGZnQVopt0OcHpNtFGza7XqYLz/6VZJYQ9JI3j43eL5d9yMdJQoMq08ujLzY/QH9WDD3146KbAXHvsllhZvWMa1FAUTNqM4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExA+E6ZGPsPUNjN7Ra8CU2T39Rh+uGyPm83yC3LQGno=;
 b=j/iZmxia8eXP7AdhJUnQP5+2CKaGmaVczrmSTm93n06w15XdxyJjchfaD6ZNffl3RFtJYZZkRQdsaXEubLjo1vHQzdrAAylIb5ZGEPonUOCsg2wyzp6j6Ls0fvbp9nyyHPLX6CP6rEyu9SLQWuPHx2Cc55BeHxnC1pv+oSCZCyVDbAhFBUiEBk+feAdiaRHbLPrZC245WwVu3Itt7eajtAafyc52H2hzkq9Cf9w3dq7HoDO6tSHa5/qbfGh/e4QoeGlTOs9xM8e1qeDzxO1fgq2imlRDQWumbg9jwhgcD2Dj9+W8RyZzo3kTKr7AwnKXi4h+MrGAezF25xNrkO5GTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExA+E6ZGPsPUNjN7Ra8CU2T39Rh+uGyPm83yC3LQGno=;
 b=fBTLT3TpVcLnRrhsLx9y3+hybiPj0LPpqPH31evFL5c4vAK5WbinZ2n1yvI5HpMCAdDVV4wzv4rE/J/8/zin3QSFZQxJ6Eflpk/d815eJwxjFOBLfrrnQ9Fqs1/8LNOSPchFu+hiSh0M+cGrPDTMaQqrQEBlR867NmbAB8Sh4RM=
Received: from DM6PR01CA0006.prod.exchangelabs.com (2603:10b6:5:296::11) by
 DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Thu, 28 Apr 2022 18:48:34 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::e0) by DM6PR01CA0006.outlook.office365.com
 (2603:10b6:5:296::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 18:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:48:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:48:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Add ATHUB version 3.0
Date: Thu, 28 Apr 2022 14:48:19 -0400
Message-ID: <20220428184820.652153-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b55737ea-94fd-4cdc-2239-08da2947b2d1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0266D5193F08508BED3BA212F7FD9@DM5PR1201MB0266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viE36DYS6laaNCwGWhkN3G0rNAT1c0UFMaNDem8GVCzxO+xlWoAgZn8PCEFOPZv6Cf0QuGdyo1pqE9FKhGjavU9J7bPkxRfABokKARuH2KXaKzCV6+61hl3XgYBUo4hk/IKOaGDi/7LipdbtMORcheGhmjmc+/MCr0lSYzcaWkj8dawe2eXEefUDKSmgPKqvQwalWhg9o8HK5RurEoecJytAV10VQFQ0zWwOpu4ooAqQ9gmO8AYPvEw8pfXpF5TzIZx+INpa6BH/4UaNRx+Vz0oJ0X9rLLMt3mx9zacnMQwwzAYpwxlpOcSYYqUppMDpnOj1QSfrWAMLyO07dyaTo7r8yqFGwrnINgGb/55kaZV6D65nkRkSGt8fdIrXiRrJofleceCnTMVmuwlprHIoS3EkGD4sz+st3AraQDulI/IJTCWts8SDFBNAsEdtqeZwJFrdAq7QIPqXpbmKcK8OqKeBMGzBrghT/S1CoLNLSRqGSnseazbbN0FFZ6Fws1he30PayrSQ3hjQGVtBMvqipS/ZZT/lQPaGPRNsvVuSMH3XHZJNhOieVYjor2cpGY2UnxV2K3OPg7Viyo4nggq0W/BMxDok0p+9tMUiAxQnsDJjrxOgzsHu1sCyISTO+LtUaYKiSDNtyaBua42XcmF9nqtuWhleut4zkIfnb1M/irV2x3jQ0CLnn+qqo7z09rW+GEnChgYXkT8Q3PMdCzNhEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(426003)(186003)(508600001)(8676002)(36756003)(70206006)(4326008)(86362001)(70586007)(2906002)(8936002)(4744005)(47076005)(1076003)(2616005)(16526019)(26005)(82310400005)(40460700003)(5660300002)(83380400001)(336012)(36860700001)(316002)(6666004)(7696005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:48:34.4876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55737ea-94fd-4cdc-2239-08da2947b2d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ATHUB is part of the memory hub subsysem.  This adds support for it.
Mainly for enabling power features.  Patch 1 is regiser headers so I
did not send them due to size.

Hawking Zhang (1):
  drm/amdgpu: add athub v3_0_0 ip headers v6

Tianci.Yin (1):
  drm/amdgpu: add athub v3_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c       |   98 ++
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.h       |   30 +
 .../asic_reg/athub/athub_3_0_0_offset.h       |  259 ++++
 .../asic_reg/athub/athub_3_0_0_sh_mask.h      | 1246 +++++++++++++++++
 5 files changed, 1635 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_3_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_3_0_0_sh_mask.h

-- 
2.35.1

