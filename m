Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240AFEE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D4A10E44B;
	Wed, 23 Aug 2023 15:51:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE89910E443
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgRZjQtTg0T4V9Ou1kaWR3OBhEY2ne0rUlOuPSesIs0DRbvoQWZid4OgJh2Bd7nx6E2F1mpjGFZRINbZWZqWnDPv/tFk8ijXYGp+ru0yBDBVSc3qKiO7xoeH9pUsSJkYipr9mG5jTdOhLu9HKqvU2waRWnfxke/jCrNLy+Sa49AowSs/8tG75zff8cvEg814w5qCLaRo9NqTpCRTVgvAlYWeQbIJuCTFQOgVUueO1X5Ec78wQ0I69IMfEKNARNhJ4tx2CwDF2YwpaOHM/0giTJ86rIP7clK24bkpPNbrJeiX3j4RyfvIUoiIX5rGBbHkND2FpGLKaprPF3yE5i1Dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHV9RtXri23bA1bKfADIcTI5CQNHH3rlDcVkyQeykKA=;
 b=hDcmIsDvCUfoEW6jctoPZa6t9NoyhxFaUOx/RkrrZeD0TQK3HhOWSbh9A8yhYdIjU8PbD22dY6uXl9faUrI91+mQvJuyEe7aEDCx4cdzsXqiselisYga6zNYtlOBhB4GjTiRrmBdfV3KZvghooL3XqwBLZuoTQyXXwNijJ5xk3NzSqQejrIGtsIqXDjh6NzuWo5ukoGERdzPMbvq+2UuqcXmDEvwNAqNXnXaa0M++WG1URVNB8cS6IFevoatIL9dejBocZpIggkhvWK8HFlMXQW+fEsv907lwFXjsGIi+sHKoYFYEgYfC8YfJTLQN2nxURz99CAyT8pJ2Ih9z8a1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHV9RtXri23bA1bKfADIcTI5CQNHH3rlDcVkyQeykKA=;
 b=nmzo0eqFUFKyJ6WjHStLgiZ9rviSQGAXo+c0pRI/efwBaM0ktUlRbD3GcHMf29Vjy5qNSKU9N3sz1NWvElWX8hSmLSOeYvSSClKfyUjcnOqMzPlKIuRTqNXm7wnrV08KjDqaDipQ+H1GS+xCJaDSaGdA4fTs8YPYN1mEp6aPuW4=
Received: from CY5PR19CA0053.namprd19.prod.outlook.com (2603:10b6:930:1a::30)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:28 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::d2) by CY5PR19CA0053.outlook.office365.com
 (2603:10b6:930:1a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/35] drm/amd/display: Add DCN35 CORE
Date: Wed, 23 Aug 2023 11:50:46 -0400
Message-ID: <20230823155048.2526343-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 4136c14f-faef-4f5c-7dbc-08dba3f0d01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQ0qkMQdhyVglA4oa8brZqTn14FN9PkkuI+YX4SbN9JbMqsZBRC/6X6jvK39tOB8uh2p+9Fs/hOgm4/VAZom4OuAFfGuPgypOlD9zF2+g9B4nq4U/PxTXuJJnaeFbVPfqMS+lAftdfCbOrgOtyUuZF87tjJmaO2lj0wQ6mFayG3/b0YOU5yPSgd9D2n05Lx0Nu01wDAB6nYo9m7oX6bkh7TaFXhgZCdNLPsBbCNdqQnnh3fbFyHx9G9hTdOjP/khvJSRh9ndZabVKpjj0kqInEjVgwgh6jUjMW4yeeOaXQNkvCxdOmpD8DcOwfFPZkCY7fR1tWRHzvBM3CPzWAO+zvipiO+orHQ3iZvbom7w+7T+aQnjNLDzTrnoqpIILCXJavimXdEgMEiJiJyTXqzhAw4QmUz0wwf0CqQy1anaBNQuZ58eFwq6DLFGdANbixvuAoW+ATBrS9SaF6fY4av6TtIMxlCxsqmVLcTVUaocIENevf9na5M2w/I0f8iyQ6Bty4wpCjmiqUk6lcfCVZPDsM2oXZHXctx9T0q++N1Z5gFPMluYtaMNeQDFKEBIoaIZ0jiFRkH+P/qUbobKlskeRzSmsgKgqjCyw/9bSfYvS2LSzYCeFUCkwLwKfB0ONErYg+Ajx3jvImbYVjvHnhl7454L4tS7A1rCRhmoA+JFl+8UVAIXEY+y637nAKN/1KvIT7+GG/pZkotXifq/1zTE72y69Ypinzx7Z1yLJ5CKLgw141YZolaWKnqapLmaX90cNRpVbhkIRcSPFD9eZqQbGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(478600001)(86362001)(316002)(7696005)(6916009)(54906003)(70586007)(70206006)(6666004)(81166007)(41300700001)(8676002)(4326008)(8936002)(5660300002)(82740400003)(1076003)(356005)(26005)(2616005)(16526019)(83380400001)(336012)(426003)(40480700001)(36860700001)(40460700003)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:28.1166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4136c14f-faef-4f5c-7dbc-08dba3f0d01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DCN35 support in dc_resource.c.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 5ce64434b31d..f516ad29cdfa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -71,6 +71,7 @@
 #include "dcn316/dcn316_resource.h"
 #include "../dcn32/dcn32_resource.h"
 #include "../dcn321/dcn321_resource.h"
+#include "dcn35/dcn35_resource.h"
 
 #define VISUAL_CONFIRM_BASE_DEFAULT 3
 #define VISUAL_CONFIRM_BASE_MIN 1
@@ -189,6 +190,9 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 	case AMDGPU_FAMILY_GC_11_0_1:
 		dc_version = DCN_VERSION_3_14;
 		break;
+	case AMDGPU_FAMILY_GC_11_5_0:
+		dc_version = DCN_VERSION_3_5;
+		break;
 	default:
 		dc_version = DCE_VERSION_UNKNOWN;
 		break;
@@ -293,6 +297,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_3_21:
 		res_pool = dcn321_create_resource_pool(init_data, dc);
 		break;
+	case DCN_VERSION_3_5:
+		res_pool = dcn35_create_resource_pool(init_data, dc);
+		break;
 #endif /* CONFIG_DRM_AMD_DC_FP */
 	default:
 		break;
-- 
2.41.0

