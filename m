Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C38C47077
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31B210E110;
	Tue,  2 Jan 2024 03:44:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5E210E10C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug5ww56xzjo/nb/ul1AjsTb/pNqJqBZPJz4xzshBV6YcIgfwvU4y2Af3aYLg1C48hbaDMQ2LdeCBFIDsrmgLq4nPvOKaSxFuGDFN2LD2R9OEOoGONkU+eICuERocUHg8TgV2khPTxE2GAim+AUKpb8wmI7k3/tPVxD5HB2kU+b6/5RwzrP2b5ruaeaOP1wUZdRkTxFh7jwvE5j/ztnqpBsZk5YHKBYErbmqj7ZSfjGyPgKgv3hfn533XIl4NLnlxeXkmxNjAOK86h+LYIXPjtQoV2lC1HjnRVpnAo4nUZ8CMCJR1eAI2X4wkQVVO7DNqYWEwOyRl8Cc5aXZi20huAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AaTbFDK/6t7Q/yTEkc/ZvWnhUGVie7G47wJH2bjZ6I=;
 b=NG8dw5daxIc6ctk8HD/gmMWiOYwA54qHYDV9oGI58PLc8WGJMS8Ol0SpEXBAI1rLk8uEzkQp53ix+1M/ci48UhyK2ADGaaWNM5UJbQhiwd/wHvlEVepq/xgr0hJH6/tfHP4NT3T2eC53gUMDPHt2bH5EIMdNaLNvrc3od+TbSWESHiVHR6fzfLCdTfD1Rr151bzl1b9OzV/4MBmRXd7kRkSvEdtunBdjn0MwgrPJWGXDD3d0kdQQi3sEj35hoWVR3E2rH0jhHOZ+epVsi8WwLYMGpLCFcz0HCm7f5FCi+UvKMVA20A78GkcnyHCDaQV7fvEL2+zmulL3KUeNJTMggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AaTbFDK/6t7Q/yTEkc/ZvWnhUGVie7G47wJH2bjZ6I=;
 b=437Y9WLuPu/ICwUn1PNl77VLzJIKBQcr6R6pV2n7Y6PbNwyniifO95mlgomu4zf93MKgda7AQLTJ999udomHgt5OcE/5PwAS36tH1gPwU4qvzKXnjFb0hQpiYBSWiVdbTKg9RsIA1vT6wKgGAieSM4eJItILLvPd6gnkh53LVSY=
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:44:52 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::d9) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:51 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:48 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Align ras block enum with firmware
Date: Tue, 2 Jan 2024 11:44:38 +0800
Message-ID: <20240102034440.16376-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034440.16376-1-Hawking.Zhang@amd.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: cca1d276-1b43-4002-12c8-08dc0b452da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtOITCl93AJdPGdSRxXpzQTV8QwE+o0S4h8vyn1Brx+8yrWuPpQWiPpayD5RAJ/lz4LgQ/J8LOK9z5AFmjyB2+5a5x2HzZZYSdOQ11QhkaU5I54GPContNj01qdpR2f/vqr4rzUZMXXlUAJRa5rJcMqLgemAG1ecP8WGnot5wO9Bp9PtEYva9HKTrAO+bVD6ZPjI3A9Q8u/rvCNr9fvHGaa7LnDShT20NG3sv/681Kbc4vrMIDRhxFBGvFP+YCejDQtEc4VpBIaXD3Yv5StxmcuhkBOd7mlD4KGjhtTzcpPec2B7Schh9eS6VOWhSO90CKabLuLv7d9cARwgli5Al7aKS4E8OyqYXZCIo9vA9QXvUPkMSMOiWGKOqUzM3DH8LEjASrJfkk96AsaB/IDxO2xlwnn9mEOlSZdlo5LPVmuHMy2JNIEpcH5w88WiB2fVKemQRJT9FTPaAZP9LtbllzzUftVEBr702VE5JUjiXQ7Lj6y/Qf+bDs5Rgi4ErzwC/gnrNLNPsKYMM7fyTxtdIHtVyXvCltbPsMIzbca5ffeVSyjRqO2CkqlkE6wLjvtQtbJtl8mbFWfNbq1z4Xb/niT9yWm0yG0YWwpBWkAiEQvAr5ob3bEuSiTGxfwDCYYBQrpJ+h1Ga2aEX6zUXb7jqJrT8+IhoZ1Z1ny26xxpDAAw23YmyH0C+uzQeFNWT11ynxW9GOQ+lqMRbDYtZg0EsJPtb0WX/HXFTPZl27lYv56mYaovMn4f5ffJ9IZiRMRB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(478600001)(36860700001)(6666004)(4744005)(5660300002)(2906002)(83380400001)(82740400003)(41300700001)(2616005)(1076003)(26005)(336012)(426003)(70206006)(47076005)(7696005)(40480700001)(316002)(4326008)(86362001)(81166007)(110136005)(54906003)(40460700003)(6636002)(356005)(36756003)(70586007)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:52.4763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca1d276-1b43-4002-12c8-08dc0b452da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver and firmware share the same ras block enum.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 5785b705c692..8b053602c5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -70,6 +70,8 @@ enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__MCA,
 	AMDGPU_RAS_BLOCK__VCN,
 	AMDGPU_RAS_BLOCK__JPEG,
+	AMDGPU_RAS_BLOCK__IH,
+	AMDGPU_RAS_BLOCK__MPIO,
 
 	AMDGPU_RAS_BLOCK__LAST
 };
-- 
2.17.1

