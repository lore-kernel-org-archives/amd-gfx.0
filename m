Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96FEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BBF611CB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2BBF611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254406ECBA;
	Thu, 21 Oct 2021 15:57:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2FC6ECB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 15:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtTxFcYcaaCWJwmlULQMe7HMmvfztZIo1iK+hnKSJ9v2wBsOIhm1i977z1CqzG1ZWaFtM/EU5r/aLc4TEpWWL1ZWnxbqX6XrSyBErp+BJhLWPfvag7Oarci1fxZeyRMxDKlRYX4oewA9V6MO6TMymqCrifuHr9Nm2eA2Pv3Kg0ZkJk8CeS+EtRATmWFoaVy4SzLgh7WHgWDslCOVpjQ4uF0jnE38IuXZHnuGqSVUA8CzNowXOxEAtLtrQ3xdCmBRl7icfCNmzJd7/KrbWhYDcddpeVd10RicfwQF+1TZ3RhGZ9xJpGAy1NJdtalgCzf7De7XIcOgUgNQ0IvtL6FMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAn19MpWLczqjN67FJeHSpR93C0k6Vlpi4IQRY7boa4=;
 b=A8JBeISatxf9h94aoq6S4N3FekWAerriol+4aoa+cCNJTjnsy1+C77NyCiogOCC+RY4Bt2skQJ/unQnRyiIOE7l/DAaVlihhh/1/m65jM1/ttNlLDfJtpXPO1Nr8NyUr1PlYRWxWva8c2XQqtyCdQn8I1o17ZuKVVnB2Dl8qg3CaRKSidbiFKmj8/fiINse30qy0KP9+10Ae5NkwPFv2oNfw2/IuzQfcuphNJHYZMPJsj4TLiVPg6gvF5dZauGwz8Sgd5QwZbArbI7xrKhuts0W9fSJORLlx+NLfwXTxNkb+l6f96dcpZFa6HrpDVvnzxNPsBp1RvB3PigJtxu3TcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAn19MpWLczqjN67FJeHSpR93C0k6Vlpi4IQRY7boa4=;
 b=HuhgtYXfV3V0iiPbWNat4yh+CgrhfYs/Mp2VVH3avDiV9ICJky9Sr7jiiQE3uHM8vBkqFcJd1qXgTaoBwaxShkux240NfyPJL4A2cxt4B0oys05Bbsxuf0jww4fQpWfQZfo4bmusR7NnYp7XQbTJoWEbWfiqI3Hx5w9Q6OAqU5Q=
Received: from MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::26)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 15:57:32 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::9b) by MW4P222CA0021.outlook.office365.com
 (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 15:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 15:57:31 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 10:57:30 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90% threshold
Date: Thu, 21 Oct 2021 11:57:10 -0400
Message-ID: <20211021155711.1191830-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e8bfd03-39a9-4ac0-0a95-08d994ab7dc1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578290EBEF677732F4D54EC85BF9@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wc8uHXB5duVPzFXDW4NIv7BGbX8ifE4uB/O6BUiuHc34WKV8EnxbiUkD26rWCGdknQ11WHmanVToRSfH/Omzz9zxGriFJSI+df8XJwwbeCe6qCHbvjUhoraclnHc+4otR454cpfEIsU5JV9tYG0N2WDMGWdi6ua7SUOQQ9y5RcvmyQu2aak0/miT0WPdk/wI/V+MFXNBSpdsm7ZGn5Ti7vxgvJEK4ah+aMvtbMPI+pL15iWfHyM3crWwWhtms6c5Neeqc8Att0YXv/pir3Nkjd1oknZYZsBtK84plAHh9fZkfhXyT6GR3c1odpB9ShsaqbHA8qaCAALgYlyMvqom4v4oGmB7YPOolT4ZJ8VrXS/vsi1eqflQD/MsGk0Zc7lVbAhtHaViezc49mFVhJzga97dPjvtiu04hpx9GtrXZuwmmF377+tNuOnGf+3QUhX8Helc8QDggky6t0UWwYhgRU+RDRueFBdXgEZItXSOcR8HGviaGRqMBvRUAnllsxsECuMGj3WkJAcJdgYok/f2My43aq+h+hq18G/vMNH0jKgfB4dVFicoC4+TOdvRMt00r0UatDQnd53cpwz6GGpMPbalicxO8KNfMCNTXSOZ3bY1wRd64g7Wmit/R+UYpWLav0w7FpR0C0k8C397ti1x7Ds6+cuxxqNWpdJODSUrsNR/iEeOcCxdF82lQ7kJ8uN7rFE2rt9roZHIroUX4zuhEcytqV456vV/dO9OiqWLOtM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(26005)(36860700001)(186003)(81166007)(86362001)(6916009)(426003)(44832011)(336012)(82310400003)(54906003)(4326008)(5660300002)(47076005)(7696005)(83380400001)(316002)(70206006)(1076003)(70586007)(508600001)(2906002)(6666004)(2616005)(8676002)(356005)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:57:31.7968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8bfd03-39a9-4ac0-0a95-08d994ab7dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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

dmesg doesn't warn when the number of bad pages approaches the
threshold for page retirement. WARN when the number of bad pages
is at 90% or greater for easier checks and planning, instead of waiting
until the GPU is full of bad pages.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4c05ff4b26c..ce5089216474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
 				  res);
+
+		/* Warn if we are at 90% of the threshold or above */
+		if ((10 * control->ras_num_recs) >= (ras->bad_page_cnt_threshold * 9))
+			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
+					control->ras_num_recs,
+					ras->bad_page_cnt_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
-- 
2.25.1

