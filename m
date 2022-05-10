Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B42C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 04:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE74310EA8B;
	Tue, 10 May 2022 04:11:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A695910EA8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 04:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOFrb3UAPHlzrTd/HJWjl58abAd1ER+aQOnt9WUA1R49Wjmn6eVTRx6lPIkGUCVrkGMq+I9JXOs9cJf+X9bKx4WloQ6owiiaLRN/5I/BmNhw8Z1bYUqe+lo/Oo6kJ9JNzibGh0zj5kf2Gz9Oa2M8a+3yojG1Knsl93iDAWQqB13GSOA/1uIUqoNaCImZDVStdDphGMtJ/NGPF6wsT3aKkgxgDA8+kS7WuYqb4Ov/pNbEVK2aM/z0i9CKux6zDPoH8NbrtUDJe4587Y6LAfu6h7NqOr1i0FW7ISvQdMjPJLdLL+r/1DKU1bX7G3KL+ugq9z2CR3v4RLwCLqEKfIMvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaYTVfdkMNSqbkWjUPNFglcbiCQ0qYEKKhPSCic6BrA=;
 b=EG6JZaj/QrB0MWs9VHEk6CvKHH2hZXW7R9Su7gcO5aSBh8NcDBxSaz1A3BPsY3eqx7j2zesOXL22mbIH9BEYpXwmuriZpQTP5OfOSf/c0bzze9C66vDtURTqGuIpHorI6Yk1koFIXBo/fGjveNwWK+jRdZ293us4CXJ/KGU5EU+0CxoDAtMxSOm0CopV7xvzOH/KP22nNiCfehHT7CsBcBiuiOU0YwrjRY6EfP+8Joo1JH9swz9E/zGl/9uZjvQ60P8BGmpqfn+wptetRG/PnXuE6fYuEu7CqsSxxhPXfpOnVUpq8o5A8+9VWgFGP1C0Kqo8uqf+xlXxBZqVsF12PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaYTVfdkMNSqbkWjUPNFglcbiCQ0qYEKKhPSCic6BrA=;
 b=GaJnbpSTj1LVhSeyPXZBobKlX80HBQTe4Ge/cAOEX2BLbx+I6YA8EFxs75csJK9wN6nRoLiwZQtK/8MUfWACMELi/j5UwxgQv7W4H13NR03L/yfncsBHgUJnR30GzA1D+ZkNRGAxismURQBMfT31EPxxUICkjAtPhjrvCVWmwW0=
Received: from DM6PR18CA0030.namprd18.prod.outlook.com (2603:10b6:5:15b::43)
 by BN6PR12MB1827.namprd12.prod.outlook.com (2603:10b6:404:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 04:11:05 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::72) by DM6PR18CA0030.outlook.office365.com
 (2603:10b6:5:15b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 04:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 04:11:04 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 23:11:02 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <Hawking.Zhang@amd.com>, <lijo.lazar@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH v2 0/2] Add VCN and JPEG poison consumption event handling
Date: Tue, 10 May 2022 12:10:42 +0800
Message-ID: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e7ef2a1-0a5c-4e88-693f-08da323b1a2d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1827:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1827D5A610863D5B875252C098C99@BN6PR12MB1827.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iE7MX1pdtD1BcIG6/ELuniYE2+kK4xMUURNozJP7JLrKAEtlc1IuifNetbrZNtCQD0OexG5Kx7o36TS4aGqIvaUsoqEwqJ2k9p4P+49kMEx4XJ/SOIt9RKde87tl02LjGPsPS3ahH59fx1wW+nhKOQPem17yGeq2bsszDgLvSaq36r4bgEFGrUZ0Kod74VksIVWmFy4YPdPghOI1j3hfoQfRSJ662uNrRfNL1VmDwo+gO8FnGu4FQ9lYRVVeQme+hsX0MdIMpAkOI9PjliOb+rpuMB9fh4U2tpst8dezAmaCdamZ3Q1Ktj3AKA/93zlh/zVmWfLdIlLTitzLQka8tubg392Gslp/gOLBFO00fRkPznzteVibYDaslGEClrnGmcpXcXUEdnsSaaQlBNBNOKPzoExUp+ijDY5kbmj591jlLCoKCvOWAMV1Rs39xDG+YpNfvQ9o26FEkVTzAu0nd6kXgG4cTupzbYUJ3oQto2aNTw4uhFNcN6bzwsA9GavgaCvVCO7q85yavcSmPdX7Gq6iB6h5+1OaTwVq8wlP6SOnBfTf8cJDtLGKz8vDjwvQ7NzCz+hvyWV80dfglzrAgcXyvKmqzDhpKPzK3T7usPbzAMdhMUA0vA/OmmEamECZ6x3uhAZgbemxDqtzQZzVKhDzC8a9hceWnPgObzeF59cjccnyV5vJKEq3DGwXMt5fQ6H7gkKwjoX4OoTAHsrI6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(2616005)(70586007)(8676002)(4326008)(70206006)(508600001)(336012)(47076005)(426003)(1076003)(86362001)(6666004)(16526019)(26005)(316002)(82310400005)(54906003)(110136005)(6636002)(7696005)(81166007)(356005)(8936002)(40460700003)(36860700001)(4744005)(36756003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 04:11:04.8895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7ef2a1-0a5c-4e88-693f-08da323b1a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1827
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
Cc: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add VCN and JPEG poison consumption event handling

Mohammad Zafar Ziya (2):
  drm/amdgpu/jpeg: add jpeg ras poison consumption handling
  drm/amdgpu/vcn: Add vcn ras poison consumption event handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c       | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h       |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h        |  5 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c         | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c          |  9 +++++++++
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h  |  4 ++++
 7 files changed, 74 insertions(+)

-- 
2.25.1

