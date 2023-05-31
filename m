Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83601C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE79C10E4C5;
	Wed, 31 May 2023 13:10:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F5D10E4C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2cNd/jUbL4kFRxyNiavDiddYZcmVKlDrtSx93x/XIx/UPpHXLMoHYK/AqRMmK8ljG/7coIpmkBMzSUHqgJSoGezfCIobUQHBCWJryWMXo0Xikqbc9tQSoHDfGex99gCiOWIbYZHN5IslNBWooKqt//MdnG7c/mcN9jO/GiiRwF06LLLuMizqc4wsgJgKyJUqv31EhKbOVh5LzMugF8O1+H0G2c1zq79nipiLWt3q0fBQ/eIwt7aaQO6vUyRsbHjz7E2pP6RzxGRTMEGenTUupT5/nDdsBrmpS0Tkn29dLRH0/FY4E3I1fpFngWAw4VHnTFtlL23U2RsN2J1U34g+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW6kCM9qvv1mBM+fACDlArWzmJrNFG8TF2T5FWFHNTg=;
 b=VZay3s6BiLZDDy48R9y42f/CDRBapRmoexFzQDepbdNJTAN1IuI7SQa9R5BrDWjyYVIAgkKKAT01RZc7p7XhW2jkdTmwSIYiuU1ZBoctaFK0AAjWeFVK7QX80afxmj4ewUiwMcGdgtJszCX4B2P2XkehDNff43eks73uvzGmeHtz3Z8tpr858goDmUfsIIKRMU8TNvEtfAS1jOISpLdd939m+MatsIQmF/ufhAHPBGdVWigTx3vYOMGPvu669/5fMBr/eNjrXgypSuGiHJDchmghlt0XWCViReeVNcGpXQRJonVtKBrUviESYPSM/czZlyKFRop0yQCwmlPLxS2k4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW6kCM9qvv1mBM+fACDlArWzmJrNFG8TF2T5FWFHNTg=;
 b=n6ZkDjEWU06ueTgrSOOPV6Yuo3O3G4LtLwrTk24Tm/Fx6jTtYvR/EsBxN1vBFnMqo3sHeul6x4jryE7YwWrXyTp1K3E1RWBMw+XyMwUILo73LjJbdGhbPZE6XjrtOPzqXr35wfr1OI9IiPCEihtgtHlmWpz7negjrnoeK+dD3X4=
Received: from BN0PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:143::17)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 13:10:06 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::9f) by BN0PR10CA0013.outlook.office365.com
 (2603:10b6:408:143::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 13:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 13:10:06 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 08:10:03 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: Add throttle status in power context
Date: Wed, 31 May 2023 21:09:45 +0800
Message-ID: <20230531130945.720648-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531130945.720648-1-asad.kamal@amd.com>
References: <20230531130945.720648-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 66eaabb8-c42a-4bdb-7be3-08db61d85a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auel4pJZUapCapvSnCPZ3JhCYdkqIF2JU5Zj6+w7YsKnK0xNwTLsESRixtIvYHFa0QNGXAtfWmIjRy1ujhgyVnRknnGaOlAqkKIuH1jYeClA2mpR64HN9ARecDUtUScwf1QPxy29EApykUOzVZT5RejMVrtbZiNP9u3B+2HIba/L9+yJ4YVYucEKxnqAdixz0yixe4hMJMFt0jYozRB1jwu8X8JssKV120eI1HK4PG3sHEwgpeE1FzIQ7H8Zi5oFRrH3TN9KirVwM73bm/y9UPgLlD0az1637FA1xvcc/7Jji92EaZuMdL4P9oVDXcgTCcS2BZgujRSOwDI2xBoRpevk6aVm8JxtygZvvTJdiZDEiu6z5BXfJTILjAgE/pDYYZykDU065lOAgk4Cs6y9YYUrD36sBElnVXNim+Zgcxk/MkmBt+A9gADsBx/L37CE1i61TgALe1jTFLfnBYZAJ5U7OFFw2cynpE/FYytsamAkuAi8CWGQKfC+ZDhyQZeomaZGKaQyc7izYAyC45TnVUR3iQQ9yUsjAMZznKQ+3ith9muv9Lm/3FKuJ1A4D7J6Z9hIWhIsZazLEULhOThQxuONUURrNZc9gZ04o0E7xwwIqSo5tBZW4weLXwdoELV1VPdY5xg+LFPc19WKpRGrivqrMHkSWaoOGfmN1iQxYVgCNXqhtXlVOacKAdHnJLP94gxmrbrjMjeb18yrA4W4bydIW5a8VLeWL1/9pm6uEauNZjfh5JBUmM1HujW83Xsb6zv9DXd1u3UJmVNtvohR4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(70206006)(6916009)(70586007)(54906003)(4326008)(316002)(478600001)(82740400003)(36756003)(36860700001)(47076005)(336012)(186003)(426003)(1076003)(26005)(16526019)(8936002)(8676002)(2906002)(40480700001)(4744005)(82310400005)(41300700001)(7696005)(83380400001)(44832011)(6666004)(356005)(5660300002)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:10:06.3426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eaabb8-c42a-4bdb-7be3-08db61d85a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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
Cc: Le.Ma@amd.com, lijo.lazar@amd.com, shiwzhan@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Keep throttle status indicator in SMUv13 power context

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 7c736f1817fd..5e8063ee3dad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -119,6 +119,7 @@ struct smu_13_0_power_context {
 	uint32_t	power_source;
 	uint8_t		in_power_limit_boost_mode;
 	enum smu_13_0_power_state power_state;
+	atomic_t	throttle_status;
 };
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
-- 
2.34.1

