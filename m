Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3397DC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 14:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A1F112EBD;
	Mon, 18 Jul 2022 14:56:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CBF112B03
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 14:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4xpRZuNhWR70r/+Qe8ETCBvDPWWVGn6F/Q4wuXxsN1zyOr0Hx5W6ExO89lIo3JMBfjfmzlbOWyDOlXxRqwP8hKIsLsPhsYaLcETMyGO/qdjkqUFJSfnX399exn66aYOp2MfIKJW/hjt9xgukHhYAy2BBZ+CxbpmDHMQjtEYJtUY+ol5qPxoe+xz3A36BXoWqlC6NUNOokY7fz9WemqRYbeqXn6BxbJ1ujQ1ISQ+t+6L9G+uTuOY4qrCmsVN2em0qA7ac9+8/TNRG4f9FBT/SShtZDZEnEX+yNetO2J8FoiVZPmXEkRSUEqsMIMA1pNrqLbNm8Yz04vXBIU2vxpOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vClflKTeazoE5UxsKLV/CiFzZkllU8WEARhftRxb9bw=;
 b=btxVy0AqrDy3Yb2ACZqZWu0H6cXITt7b3ZfLBGf0kaMs0FgYB03k9Z3PxX+8XuRK6AI9zkb8oqXD678fEfvpCLXtMC5pTPvvyAzHcvkQikb553VDiEsaauaOI1QOS0c6AznCdt/6TEHiP6CKuQnZmsqd5o7mjsdZtRM8dbeY1+QGRveAcxmCkCU3EN9zlYEwUt+SQ+Kzy/3Wt2NOSo3h0DwehtyvsqWw3XsmpJ6LaD0I9Ais1SQZb47L8lGEC1GpoHYTqT2gxxq2Ph72n6bKqNNyQ4Kbcl0JPb2YY1M46XT4Lwn+Wfm4uiZ8sX7t4DqRs0Hcg+jmLOl65aZMtSU7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vClflKTeazoE5UxsKLV/CiFzZkllU8WEARhftRxb9bw=;
 b=PEbG/7OXUEtu6MKaYbaF3aPjl28u2r8IuXAZr5jpj3jnklIFGkYCpsjL9cW+BXiJrsYjDJfT4SzWOHYK2LhTsDAs0vpMO5xlFEup3rtEWcWwv6cIRms8cIDWluE4hqw2lyJv8dhWB9LvS0DnZGBUNQvRI/DGGE2RohERo92Fye0=
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 14:55:56 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::27) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.24 via Frontend
 Transport; Mon, 18 Jul 2022 14:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 14:55:56 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 09:55:55 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amdgpu: add comment to HW_IP_VCN_ENC type
Date: Mon, 18 Jul 2022 10:55:34 -0400
Message-ID: <20220718145534.49027-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d89167d6-a87c-4196-ef91-08da68cd9ec3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW/CAvYNUhNvkGikucX6vlbeEWzNupwZ2D1NNFQKFed2B3sYza0UaJcUXFGErW5b02ExzRLl8GcpZG66IGQM+QIHxoubsaIcoYoTp5OpQZA6moiWcPzpdT7P7eBsI0SiCbL3jplydQfvnHvCFX/+DpFQAqQowIyLfZkupe78mY/YyZsAxAcpQuyouwrSbOLBDEx4xb5yTYIUrRwT3g6NFGbbFtWNMWbp/wPZCaflZMUvAV4QKyI7pBex/szqnX75W4fDP+KKfYtg59ZlXM5MO1rBMIRud229xpvwgNlDGPs9Wcbs15xbMTHP9LTmpuDFtXtj9zL1JRwFmRYtsPIskgxttzx+kzDGDhOoUMiNvyNeJWkpxF0WO03R/8febohb4vKFNuw1MeF2tYbVwx3kvvI8IbPl0ik81R6qKEbYulSf3tGtypBuSwjQZFhf5SJo009mH+LKFjlHr3J8J+4eQVapuNmhhToAfNfoc3GIcSJMB5C7XOyx+zkrnI/BQ1pGuuDmcycilKz96izHa9yr31LMGkrK5ki47YZO16EKg84F48tVIRawAGn/frZW+CL74RWYQSbPL5iQUxNruyAfATHoJ8YEAiifSCq2/d5CCU0ukM14zzzrqW6HjwyvUK7Sfxyn64j0EanEP/0TuW9votAA8iD89urI4lsPUOk275Jiz+L0sWKp514cNYDNPlRmeYre74eK7doyXHC+2OKQ4vFi4yFqHzl4V4mxPmZNXJCNfks8qK1GpZyrTgIjRmWMcXN6Vf11t+f1eCBWhZH8f5aY/vDQ8LgF+lb/s2lGxGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(316002)(8936002)(81166007)(86362001)(4326008)(44832011)(4744005)(82740400003)(70586007)(8676002)(356005)(7696005)(83380400001)(6666004)(5660300002)(110136005)(16526019)(1076003)(336012)(2616005)(47076005)(186003)(426003)(41300700001)(54906003)(26005)(40460700003)(82310400005)(36860700001)(478600001)(966005)(2906002)(36756003)(40480700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 14:55:56.6478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d89167d6-a87c-4196-ef91-08da68cd9ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From VCN4, AMDGPU_HW_IP_VCN_ENC is re-used to support
both encoding and decoding jobs.

link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits

Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 18d3246d636e..63de71f53110 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -559,6 +559,10 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_VCE          4
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
+/*
+ * From VCN4, AMDGPU_HW_IP_VCN_ENC is re-used to support
+ * both encoding and decoding jobs.
+ */
 #define AMDGPU_HW_IP_VCN_ENC      7
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9
-- 
2.25.1

