Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F414C71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088B810E5B7;
	Thu, 24 Aug 2023 21:31:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9039F10E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOJjhJ17Ux2mZoLkdv7H4erNFz5dANtVThoKOdHoW6fOKmYNbm+aXbIArclIW+7v6/uby2vDnaPze8D0/KEjj3oEtocYAI+CQLEiF1LP1geEfUza7SAQl3DXwQrb9SoUmEHbpiu7/BRZsBSLTdy4CKwtjZc80ODa2MspmxAxcmyVDLMHbnTux6oEJ9cNZTEBdJ5dUrT0z53q13fVTrC7TweyFSzKwffttvH9tciv6BeC0FuOvGjyVyOheog4ieCCb38XcENTAZVIRuAsTID0chJlmAVxq5t1wnmhv1R5Qb9GnKn6hwAqbLwIWAGhPxA6YxVfjOfadq6twBmpdBlfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2O3MtJ+LGEpsZvXp68krCMeoY7xGfmMLace3Cq+NrA=;
 b=UmvzGIJUGCSmdorm9fmzZOn/NKCNFe3uoqiZCBrMHkTRU3SiAoIglPSnIfAWSEjpEMJXM89NrSHZl6jMbNnCeskHH8bf4C6NG04ZMCK1UvuQRb2r5hoR7FN66HQW3/EdVSh4YRoKOsa2ugWyN5ByrhJ1cVxnjSlKHSX2gqckPZ0qeyPNTR9ov9pN+pEDp5cmcL2ZCc3olAei/LBmUOJw3nqqOMQoco336HD8c01vGRRH7+T3ScnhDgvtmZVTcBhnFP55L4Ypj36rl8UDD39NoSbTv/N68CKlkc0I3UOzkNG0NZgzSG7/Nt83QCabZHxNFXmGaMJZBdCpvRacS3AIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2O3MtJ+LGEpsZvXp68krCMeoY7xGfmMLace3Cq+NrA=;
 b=mdG5bSsOxIj7/3rlBn5UjjNM+gtzFP9rYzPR0mxAibZh1H8AoplgnVxofBlcmLyZdcY+YvQYtctiNXNADJIIWGvjXUxoInqKne+lka8B+T/ti4UOdNcmVjZGILm4PvRcxrHRbH3OB/Le/AnfPkubF1HeIbh+wffAuBGKVTTMVPM=
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:46 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4b) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amdgpu: add VPE IP BLOCK definition
Date: Thu, 24 Aug 2023 17:31:10 -0400
Message-ID: <20230824213127.2725850-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: be422517-c475-4ef9-fd02-08dba4e984a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZ1mjTECPOIjHwsm3jqp1QzDtSm6o3AYw78azUGNc31lzdxRYNSdwN5t6gTkWZGIf0lNgkCkM2AG+DdeuOBqGyqkBRSyBPxcLw/cHV5OpcuEbPfgnPpTNTXpwWeu6A3RxUY7NJjWF7r6NWfNiZMDrfI9+V2XOvh5lwCPQeQcVUZIrDUm8SyAmWwUnDbP2num/39ySkeJQi7eosOkzW4tw+aUgRiiHNBK1iARQ2oOyDd5HV7WWzwmE+KTso1ZTDa7Y4pKhm7VM8yXgOEF+jVBRrMVjgi0QqFYpiN/qJ+99Ib7fLpNCoD08eCbSvxhv1m7az0KYCHZRU/YNqugp5EqLEpA11C5KNugzWlAFf35sA9zt9yF9Xx2D/8W2p4I7gr6+zBAI1TBRi6sopgVvjVZVW4TDZ+fvPIpQTIJwjioLY/eeSAooW2O8L4C2+Ib2B+AT15oyjYHg2iHza1AbY9zA+xCii4fujPC9TNIxtphlLLHFrvw+M5fIzPlRQK4goed+OdJhmnf4QpkRT4tCz/k158vqHcCb5qvzC/EUiyYprAv/VXnlkF9xVL4OzcrG0k6auPO8kc11W3SOZDuX8w8j3Wi2y8MjL729igtW9rNIdKzkqmmxRVDwnSqTl1t0EETB8OlWyMKvJn1NV3AnGABoNyPmQQIV59uiort0JdqkHcGcZuFFQEVHQWdXX3guBE929uB5BIz76xioCfGmVvLFR2kuzSi2N/35U4XpoN4H6+HYYPE7rM4j3vuOTh9UOxcmvFDH4uiusEj1iz6nQ1xog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(83380400001)(2616005)(1076003)(47076005)(36860700001)(4744005)(41300700001)(70586007)(54906003)(2906002)(6916009)(316002)(5660300002)(4326008)(70206006)(8936002)(8676002)(478600001)(6666004)(7696005)(40480700001)(86362001)(81166007)(356005)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:46.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be422517-c475-4ef9-fd02-08dba4e984a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add IP BLOCK for Video Processing Engine.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 67d7b7ee8a2a..bb49537237c2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -100,6 +100,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_VCN,
 	AMD_IP_BLOCK_TYPE_MES,
 	AMD_IP_BLOCK_TYPE_JPEG,
+	AMD_IP_BLOCK_TYPE_VPE,
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
-- 
2.41.0

