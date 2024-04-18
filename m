Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E2C001CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E8610E3C4;
	Thu, 18 Apr 2024 03:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OTSTwnSN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9013A10E3C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfqxWvr6TL1yKBrj7IzWlDWVa9i/JX0vv2bEmnNW2BFRlaqd8RfmBPjHTM8x+YUCOdjnL8CB4MjZMa5rpxeGQvvwrEmrvTV+Lt8sS+Yd+cgNANUYy0ArW+HwKU5hntewDRDE+FIumOEhGgK/uFXvptSeQyT0p359n2y+X81iujmmg30cBR+H0IuEO/1PLtyL4im5xJPdmzmpJEm4KakHMFH48arJ2vdlVVli2oFYWPyDhrgT6bZG7x8UaPn0N09FwQeyZss4YX5U/ZtWNVpIJ2q3i6rmDj3ZohZMhAKRESV6n8fTh2/jM4oD4eqR7qZL5BAjPpQZX5XHR9uf7skqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mbECAH3BBY2Iyn2kwQg4HrhXExpM6YB5DZ6++9pC2M=;
 b=GwItb613kRUkH7cgdiWFn5coa3NIlmFQZiCZuhU5nXD3XtxzE6B8z8VAuZIY+EKjZps+PJ5xrEQcxppPOBkPpUacJDCiyZ3LjBZkq19y6onOOF7RUqo1TM6HLL558euMSplSPd4G0Nnr4kB8YUCvycK0DxwfLPMTE0F2uTqQPpgDhnoMHRyMAEWGgOX3GF1utY5QlqZjHwjG+4PUeFHUiTdXnareKZ0Su2E6nLu3HjJemVKMiYflsotqpCvqNbpn+Yl3OphjDTLpVQIkPIoowxFXKAh2xwnKpEnh/F69klpJtSl98M4THxZUAb3r7HxFWjTCSIDEudIuQdCjKZyJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mbECAH3BBY2Iyn2kwQg4HrhXExpM6YB5DZ6++9pC2M=;
 b=OTSTwnSNjuVA21kg8VqX4ntvZUQjipZ7akKEyzBBmVYj4gfPA4hS86pq7TEQPjkfnXoq2W6CAVr0W76cvuKZXa2X4WXLUK9zWV4HlDyMPTGkagM/EkZPG0YSWEguklDKdXHQv+NaZ6+eZ7sGQOFAM0uACLUhg2qY3I8gCuDIhbQ=
Received: from MN2PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:c0::30)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 03:02:22 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::d5) by MN2PR05CA0017.outlook.office365.com
 (2603:10b6:208:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 03:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:02:20 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:02:01 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 13/15] drm/amdgpu: support ACA logging ecc errors
Date: Thu, 18 Apr 2024 10:58:34 +0800
Message-ID: <20240418025836.170106-13-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 49100e57-a4cd-4419-07ae-08dc5f53f6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AzbSr+B/Io73LIVbRC/auBBjODgdthMj958/Rju+axaX0/nt8n3ZP4mWRPckqyJiPF51QCjDOGdl8PKxMYTMzEkCCcuMgtWBd4mNF18a+KcjrVzmYI88lIS+DDBjlW3EobeTlpnCo8fTUefTwM1x84Wnwu4GwEuNsB8zaFj5BjmBhSFZjSQ7y+9RjcOmZo/cSTPRM1Zu3bhzRq7UQBGIAbAgSMsKjHadAI7Ix8Fe+2OsqWsEcgEIrDte5NFUvGm2i/nUALQ+0C/9GfezVrBtdaHd13iDnYrA+fSeEdC+Fg9sKwM0zvMTDQAi2JdffnkujHLlI/HvCzB6GVa5cWAvAepjbE9bbJoHkdIZ2/TchfV+14TrSatvRlxsONvCS50NITcEoEDT/rKOKGHxjVV5PUpVulEu7V3jZIel58LNaicF6bGSjMQAFfpqo+v5rNcT34yqMzwkOcTZfPzntkASmLQCFAAcBIINWbgHzVBIU3OMNMh9iiKKieLOCbPzIlSyN1JUME17Dka2caYzv/a4wsrVRhIdJFCrjO5eBsJAnwatkJVT29kR/cLonARZb55TQUQtLlOV0AvDluMic95ngiuXLWnMFRexa53yuil5u7PbptL1rnevguPZrJvakhOE+OvozDjbH++0LZOsN13huPq2j+Dsdcl9hCbujGB4FkrIXdiOxDjpNsPM8zESYPxD9XBPNF4h9WDu9qclJO2qwBHGe8lIk+0H5NrKwVFFdfznMfIhLSbJmhqCsHyABDV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:02:20.7334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49100e57-a4cd-4419-07ae-08dc5f53f6e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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

support ACA logging ecc errors.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index bd917eb6ea24..8df84feaf046 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -508,6 +508,11 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 	if (ret)
 		return ret;
 
+	amdgpu_umc_update_ecc_status(adev,
+		bank->regs[ACA_REG_IDX_STATUS],
+		bank->regs[ACA_REG_IDX_IPID],
+		bank->regs[ACA_REG_IDX_ADDR]);
+
 	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
 	count = ext_error_code == 0 ?
 		ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
-- 
2.34.1

