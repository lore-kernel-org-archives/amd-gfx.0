Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E25C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F82410EC58;
	Wed, 29 Mar 2023 20:26:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5094710EC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciLC7/zDdU1bvon88EZGWLa6BV2Q+k5EWhWhfWjcmebFACSfOB6zZ2OA1ERpBOpbWO1DRkF4JKHQmhsfMmUb8AdEXLcfcnbee6wwVgNX0Acm2WTHLAMVR/i+MdL9w4gnSREAYciDZoectCoDxTrO4w7JFz8osAy8UixP0IoVstyZskrNOOenXe4bXUpKbXHbs5mPanky9YciRMoknsTy+jQGHltjP38rmKLXsNCVoQHAx7lVb8t+mLtHt2QDUAHNl9pL1AUnAkziTAsDsjf1XRMq5GKa9h3lP5hUY1N16PcrRETU/4Hj7+A6mOSvSUPQHo20roZm6gz3WIMplGyI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EREW04fswB8rbNs93Caf7zh6gPTeeiRwK5Rb40/Gu1M=;
 b=Zep+mWnRhfwFPxKHyijtpKuBczGscbqZflBIAAoK4Hb0PTMBpxPhFblMh6KwtXr1gszcDxQo5J08yobyHgvL6ZRyAxf0T+7mNS5IPGhFe0N52waYHnSZgYkLcWtWr61OQPSJj0NfIdprYPYW16+6/OLVEN7vYn8nyeV4w1zRW+YmbfSF2I/hUY60pO8QyjQW4hPrbnvmO3JPYDRCmPiMlbsSSs/f29M3GwqUKmpN5gr5BpkN4+stK01V+T6iVNy0tqbvkECDs6yE2PTQ2r180gT8oIlwRFcxvHFW5sEd50JDYL7osdj8BMIRx2n+0cpIFMJaYGxy0U/KsHN3rDjttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EREW04fswB8rbNs93Caf7zh6gPTeeiRwK5Rb40/Gu1M=;
 b=GophVnjpnJwqNCWqEUMFNj3A8CfkOO1yud/QV9h//f/jxgL5xRzpFkkZCADifuqEHdAVqhUP2YVYpHZVuHh1E0cAYom9d3IFCC+h20qTYRObFvVaPF+0sBy0kGe93EqLs++6XF3yFun4o8F2BkYs4IhrrFbcFAc5Xv+JOjSu8R4=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:02 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::d3) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amdgpu: update ip discovery header to v4
Date: Wed, 29 Mar 2023 16:25:36 -0400
Message-ID: <20230329202548.1983334-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d987aa7-990e-4b34-2637-08db3093d0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6PEPcFbUC0elSE8Q1Zbk8M0MiSx986lXjnmO/2hWbvDzrIhsEOh+iJAfWg/GTM/vT/2pOzMGREmhTTcfpuZcjJeQPTCVBrOF6syaSusErMj9zp089BWYCTQyKp2mwwZ0KTrtX3qalB0yFzWTtewmRiMRL9UEfGyMhG1P95Pi3DHTPcbnIQ3VNYkeC+qJlUvKhap5btgzNwk3udT0AqxMUuQnpCyajPxmEIs+slk7fRFr85E8JTZGHKUoqKWnm0ct8LJKvkdVxpF5qDPTFSg7lcIaCFBHB6tHQWwnqoa6pYzFrn9KFVWZtQ5VyPxKABvsVBy0HhFcJ9Sz94bAh72cjQF4j9Mp75paaIDeo09t60agDVft6E/X2GDv1iwyDL6L1QOTYaxdOylkV2o0bYQoE4Qp3+8x/LLl/YFAgz5EZ0G88OS1afha4MN2y1nb+5pOQSGokFZLjwbEWchYzo8WALAGoMwuMDa6hnxj7XwgwYXtv1aG7/Lm/ZhH9MG4LM/f6AX9Ip90cvbl0VJluWBiGQyNZ1LQBstAWO07NtIsM+helNb2Amx2EPxOPC0RHmOB9l9Bu1nelvdLNKF2Ia26Aml4KWfZz9g1aUloc7eAWMGqSIbkK0ZApSP7yHLJsGdwbo6NCiRVCzVmRYN6Sdl2ugyFh1E88pv9jL2/wAnAidOzzOrKlXbhpbalgQPDdkYWlG8MWdTYAzW5HxzGr+lSYvY39w/nu7BQVTlXVhpQxA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(26005)(6916009)(1076003)(478600001)(316002)(54906003)(186003)(47076005)(36860700001)(16526019)(70586007)(70206006)(336012)(83380400001)(8676002)(2616005)(4326008)(41300700001)(8936002)(81166007)(426003)(356005)(5660300002)(2906002)(40460700003)(82740400003)(86362001)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:02.1675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d987aa7-990e-4b34-2637-08db3093d0ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
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

From: Le Ma <le.ma@amd.com>

version 4 supports 64bit ip base address

Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/discovery.h | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index f150404ffc68..9181e57887db 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -79,7 +79,14 @@ typedef struct ip_discovery_header
 	uint32_t id;           /* Table ID */
 	uint16_t num_dies;     /* Number of Dies */
 	die_info die_info[16]; /* list die information for up to 16 dies */
-	uint16_t padding[1];   /* padding */
+	union {
+		uint16_t padding[1];	/* version <= 3 */
+		struct {		/* version == 4 */
+			uint8_t base_addr_64_bit : 1; /* ip structures are using 64 bit base address */
+			uint8_t reserved : 7;
+			uint8_t reserved2;
+		};
+	};
 } ip_discovery_header;
 
 typedef struct ip
@@ -118,6 +125,26 @@ typedef struct ip_v3
 	uint32_t base_address[1];               /* Base Address list. Corresponds to the num_base_address field*/
 } ip_v3;
 
+typedef struct ip_v4 {
+	uint16_t hw_id;                         /* Hardware ID */
+	uint8_t instance_number;                /* Instance number for the IP */
+	uint8_t num_base_address;               /* Number of base addresses*/
+	uint8_t major;                          /* Hardware ID.major version */
+	uint8_t minor;                          /* Hardware ID.minor version */
+	uint8_t revision;                       /* Hardware ID.revision version */
+#if defined(LITTLEENDIAN_CPU)
+	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
+	uint8_t variant : 4;                    /* HW variant */
+#elif defined(BIGENDIAN_CPU)
+	uint8_t variant : 4;                    /* HW variant */
+	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
+#endif
+	union {
+		uint32_t base_address[0];               /* 32-bit Base Address list. Corresponds to the num_base_address field*/
+		uint64_t base_address_64[0];            /* 64-bit Base Address list. Corresponds to the num_base_address field*/
+	} __packed;
+} ip_v4;
+
 typedef struct die_header
 {
 	uint16_t die_id;
@@ -134,6 +161,7 @@ typedef struct ip_structure
 		{
 			ip *ip_list;
 			ip_v3 *ip_v3_list;
+			ip_v4 *ip_v4_list;
 		};                                  /* IP list. Variable size*/
 	} die;
 } ip_structure;
-- 
2.39.2

