Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F089C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 10:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34397AD417;
	Fri, 12 Aug 2022 10:20:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BE9AD3E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 10:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuwF8V+VhX1LHHUw/Hro/Eqkci4lK1xWDhS1iM1Lcvy2hY5Z6t2fZ3VQGMeBmptA7sNOaqMBddDeegEm4wuUKwk4cYvjDm3vgQ49vp29D3mrQxKGKKEoSBV2w/NB88Uax7ZwmxBbei8ekNnS6Ri68xW/OBgVSY9kvHrgmcdMTLFlj7PQtyOyy2Sj+BbwP7ewtlMv21Ohm30n6C7Ai9SEVnAhs6WzaHWcNNd2TqaI9K6R3RajaLk5/JXbemtWEqqeQE16sKPiUIMOnYTrkyyA3I/+5EWVGQBxK4nOkW8mBu4+CRU9v/WaZQz+Pe7s9Kys8o9WOaUuNTeSb/3Ck5bcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNPd62T+ifzTaAK2WckBn35UCAh4lbQ58TLEj0SeYhA=;
 b=AnkS23JQrvf+EvS83QAqbHJuxdES6fbKJfrZRMrMH4fdowG0mAIrOJU3kyMxxKXzL2BR6ReypXFOdFJMPzfOcCGvAkjUYnhC8iZNDIzhuthSnUgdHkrFSCeJH5ojl+0yRvTGx6rrmwHJ03p0ElkyAnjpPq80UiAzsTCj+YHAgGBFkAhDza+Tu7tBVbJ4cDpqzVhwOIZBCoCynjKzAsjbfxLH2JfnvxrYZ2LcFqszTHluTePm8CMaWHFfZIpawKFe08W8devfk9vEsHNngNa8TEqIwUhKdyTuOabuJvgV/TJu/N2OZThpVbb6D7aLX1LMiNLqhH2Lsn8WJiFQVqfFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPd62T+ifzTaAK2WckBn35UCAh4lbQ58TLEj0SeYhA=;
 b=Ui7sqdT+XLKO+Ox9PMAQN/FY5Ql0m+vbGeve7tdB08abfjsJDMDUEEqYfoZfSNNo61YER3F0g3y0WaVHHXz2K4jz9UmXohjyhFrIjVUy+zd/i86j4ZPTa6QMTybyleFsqiqEMUzv5QxO9OGMgSKzxv8REQe4WYQB5VAivsTcguQ=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 10:20:40 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d7) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 12 Aug 2022 10:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 12 Aug 2022 10:20:39 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:20:37 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: Enable GFXOFF feature for SMU IP v13.0.4
Date: Fri, 12 Aug 2022 18:19:53 +0800
Message-ID: <20220812101953.3884354-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101953.3884354-1-tim.huang@amd.com>
References: <20220812101953.3884354-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d53d214-8300-4a9b-671c-08da7c4c4e2f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmQqq+XPXcIt16107Jv/KeAyNMAGnNLBh+eCPL4TCujKYkZXFAbZQwTduD4uMe6FdvptpRWsW1kpiUybIZfOzjUw3JYDA01RonhK4/3mvSlIZsOMPSgA9G9g+2AW5DScj1hOD3FPekKVXDhwVhrJ/KaUAAxykGnZ9FDQKAVV9S82+mlKf9u3f+aERVgxpucH87fWSNFgtADJc8MblCYrQmdGhrVTWiLNdB3XeiH4E0MQTTCJiwZcAN5AlynjcUrCyB2WN7vqAcBSQT2s6rDnJNiB7z8LQEz7R2ku3XHfuXcuVu0onhF3BaCCl8f4imOFBCvL26z/p1s7MslE0X7YSo57V9IFER9fpebyK4kuBKba2CYS5mwR/OqAZV81RqYVucSmaRzC0Z9qOUJKfPdEFtZ9R0hcqmba+jTCOLGk9v70DdGEnH4ZapKLfXRHaOxycA+9zUqkdk5dgs/gPHNRUDEX0D9LZXtmkgA9L+1UPc03mXW+qeaQU2baPAy66MFhjgPpxDMmZFZEr80q5ewqxZVpQaM/i3GcSOEX6sB8V5cfEPdmw/1fuUaoj0k5A5faRKIHzwFh6gCswf6/5eYlGnsPMYu6xWofwryNwUx+7mY1Ot8ipwr+ICwmaMMdgLeXzQRg/Uj7Ksw1deQfUbs1VrgxynpBMwAQoZreAxoGPAitxwmL8fc0s30dADrx5pfKN0rh9OuDEBCWhz52LNrxzbf1l3Me+2K4ASyXbKA56+KTBJj5fv+tFzIUjiBLfB0Ed8jAZaG+WGtMFnpcZhB7L3VZ1Lvtw4wfSwN6M4EXKIc4E2yEQ+6T3JQF3Dm1sWwHuUh4AE7UiMjhZaRwWG631Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(40470700004)(356005)(81166007)(47076005)(82740400003)(16526019)(186003)(1076003)(336012)(2616005)(26005)(41300700001)(6666004)(426003)(7696005)(8676002)(82310400005)(70586007)(36756003)(40480700001)(86362001)(4326008)(6916009)(4744005)(316002)(70206006)(54906003)(40460700003)(478600001)(5660300002)(36860700001)(83380400001)(2906002)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:20:39.6809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d53d214-8300-4a9b-671c-08da7c4c4e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver needs to set EnableGfxImu message parameter to tell the PMFW
to set the flag that enables the GFXOFF feature.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e56ec06012dd..3651f6f75068 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2345,8 +2345,8 @@ int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 					       SMU_MSG_EnableGfxImu);
-
-	return smu_cmn_send_msg_without_waiting(smu, index, 0);
+	/* Param 1 to tell PMFW to enable GFXOFF feature */
+	return smu_cmn_send_msg_without_waiting(smu, index, 1);
 }
 
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
-- 
2.25.1

