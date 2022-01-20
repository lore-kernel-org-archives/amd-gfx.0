Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A507C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 07:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2E210E369;
	Thu, 20 Jan 2022 07:25:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B4810E2F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 07:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVeFuqORn2C3UqCBfp3CUMIUyaW/RZJslJH+UIKKUWP+00A6DwUjq6mXwkzcFOjH8Pq3+SGSw7fLOjGo4xb+TcU6IbOLzPhnrxHMJAw7910rcP8xHpttOgJeJVeQC9H0wCUypjOU/APLSkHemBmNDSla7JfRWolNdbGv9GGXlN3vE5KxXga8k9vW+bWVvONaAvkBwdzHV8cJnPW9tJDTsQ7YF2V1pj8Gjg/P9r8TJcrbMMlY5SD93UHTKVNC+5Wr1QegB5Mnx20VuZ4PhXBW7O23f2/WuyVKZSw/R+cIGTrUumIRbet61Ht9N4sSYW4GfU03kBSHOBaRzbC2TL1UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXnMdYCmAN1gfDFNiQ7d+5irofGAeOO8KzF+7gvH/Fc=;
 b=b5a5rkaylZ7G7KmWSmXfwYGHWJSWTuR9X/7Lc14P980yzAWbpQBpmvixYFCb62JcJdbxhvOYjwuZWIOxayyxpz0Qm6oTnE7mwqNKyI57pBc+8+Ov7xV/XPAICuaMkVDn/sDkuGmNp1O/Xu9pszuFCuQDFt40XgEl1pDl1COpP4Xcmuvp2fef2tqfBE2eZyeR5hRdtVQVjpPrIsjA8zs5DzHsFbQ99OGW28hR7wWcpHqXhn8ebqGaEIfgFPoryAdCYOhfpO8UNHzAZTdJ3GWgEtEwGeAl0ONaJZR5dSFuLI808F4upIrCGpwpnOqeffBAfnpt+xeIxPcQQbZ4cowbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXnMdYCmAN1gfDFNiQ7d+5irofGAeOO8KzF+7gvH/Fc=;
 b=j+SslsbuV1aJ3PX+55dravqHq9COwbLjfWt8cbt45Cej0o3gszPQkbl9oG+NG+8SYTUCk0XQaSqZfvFMlBm9Pf9Q75wGGsBpxl4AeVFp6BfGCseFW5ZOBDlESEZNCq0ZXEqvE79OglJYBp4j2mHf9buyUAL2ab4Pa31zuJWv3mY=
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 07:25:30 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::58) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 07:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 07:25:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 01:25:28 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: suppress the warning about enum value
 'AMD_IP_BLOCK_TYPE_NUM'
Date: Thu, 20 Jan 2022 15:25:10 +0800
Message-ID: <20220120072510.582847-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d11998f-ae76-427b-414c-08d9dbe60964
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280CF665A3718D5EAA8280CE45A9@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljT/RtrKASOn7byjFy5Yexv8WtqJufwbsXmkjc4ayVyb5JCzmOX+z8Fc52bfTTQ0poNVwMKhwasIET4DyPu/FXu/fDIj3V6ZQsWFyHg1niGeRARE7+b4M9GraNHfRmL6835otgm4RoxoGunf7SxvGIZPtPFJtUEsnoMfy7AtvYKZK7rzcW4o+B/t/+T2OVeusYDsKjNAzuUGxH7GlocBxuC9Gqrkf9EwI5lcK5JZ866CRy1rZmpDfJK6Qt7AP4Ml7+HFq8j20eidoeQZqcSjYPgwKnNqJzSlqOVzmPWzLkm9dKNcd7GN8+/1Jl+TO5H+5Mc0iCVX4zF21p8TS323q/6DWnxWbi6wOah8pbgiqHtqT4yYkhRmUEO2K0/wf8nMkDpL1f53OcSwRGbVjkNWZDV/5BjB0D8Jtl4sHK9pq4Hb2gKC9SObjMZwykhJhgxBP2oEwu0aTSO6wu2cJyMvu1Eh22orFtz5VEsR4WVLxkJczKstMc8bpWA1QhroaAdlPnbyHbPXBIoiYMfwjGYBcg6mpeK8DeG0N6g3CK9BZBT9z0+BYfDbb2mBRt9sN428UBLBCYoSrJyWQeByvb/3cTcExaBL/a3/eXrHS7kBFSlMyfHxXEpQe8woPyju3G5iEImrS7azUfauEKJQOs3glTncnOGZetFYdcQ8pSnuQISeIV/pf5emDv3OQWizRBXlejsQIEHGVbzYxBK6KrF9RMLCphUHfkSQyAaUP7hW2YDOSOHCcbJcZNIWssoq2UAWvEJUC/eAbF2QjPIkZGQYp4xJobmbMBV6mn1Ngg9RFe4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(36756003)(83380400001)(6916009)(54906003)(26005)(16526019)(186003)(6666004)(36860700001)(44832011)(426003)(316002)(7696005)(40460700001)(2616005)(82310400004)(508600001)(336012)(1076003)(8676002)(5660300002)(70586007)(2906002)(70206006)(8936002)(4326008)(81166007)(86362001)(356005)(47076005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:25:29.5693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d11998f-ae76-427b-414c-08d9dbe60964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the warning below on building htmldocs:
drivers/gpu/drm/amd/include/amd_shared.h:103: warning: Enum value
'AMD_IP_BLOCK_TYPE_NUM' not described in enum 'amd_ip_block_type'

Fixes: 6ee27ee27ba8 ("drm/amd/pm: avoid duplicate powergate/ungate setting")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If18eaa6e440cfa06ca41854c8c55125dd3e111d1
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index fb6ad56ad6f1..fe4e585781bb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -83,6 +83,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VCN: Video Core/Codec Next
 * @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
+* @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_COMMON,
-- 
2.29.0

