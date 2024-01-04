Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD1C4707B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5835D10E4CD;
	Thu,  4 Jan 2024 15:53:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578CC10E4CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJzu2Hm5d7KMAp66ql2p4y51bQzDM/veSssaApKx/CAl9RpPItkiaTd7tFe3ZZ+PvNrb6oCTFuCyiYdaXh5xcmCPcU0SOCSLSsg8cKY0KVEvE54I663EWgq8vAjXnLsfrupLh1LJac4uWUNjY2Mn1tIQpflWFkdtuiSsAa35MHn/Czxj7VjovC2h3nuT99kLDMAruKfKeMQ2ni3UMlrRoKDVYy64BrSpvLYH4/sPoKziskoHyVoKw0dyXQktwVpVQrUR8dnhPe0wCaXnMCJGAFdzYOs1QLHWKfyU6pe7mwErRqaywNggqx/wsVfP2Fyui7Hjqm9tW8ZR51JgWBZJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csevnrADWp0+0PfzpPjsqsDH6lgj4SGyigX3/rP/B48=;
 b=SlJ6g1n6zk+VyEGpmtkER/3bfUcXNht8oeAvowKLjDl+/PeaprvaMSfTljWlVPXiORy6KH7tKGsxbZDVQYuX87HxP7nxcak/IF45Z809qolJ6k8R2CsxypsnmbdCFzoRMNwHVMCOBmqzm5ITCFQg2hSYMAl3aei97G+n247Q7YWiaZc5yzprncBWJOdjaLEMNdlNeK/EGRpgi/LwEaifFto5NlnQjBKgeC6oz2fgSjsEN9VMhexERsnPJBKXVqN0gCH1fWLkkEo0P/PvRwtJf44/h8lT9DpZ31xNrEWDuRjlnNObWuJvRRWWLwhmZfWXIzXL6BURoiICPrBFX2VWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csevnrADWp0+0PfzpPjsqsDH6lgj4SGyigX3/rP/B48=;
 b=AbZji4iqw2KovG7BdmhtDq/5HU5MaFAy+Hmasx3QywQ9PlF+soQCn8QFJjwaiJnWZIENDVzw/y0wxrNuzwcCO0zGrUNGCl5wsf7mreRfdPVeQeZAei6xbgPu+3HUDxucOVyQZKlhKyB+aJtKdL/a1O8TcnynfPij0TTk0NUYPmc=
Received: from DS7PR03CA0305.namprd03.prod.outlook.com (2603:10b6:8:2b::25) by
 LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 15:53:32 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::12) by DS7PR03CA0305.outlook.office365.com
 (2603:10b6:8:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:29 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amd/display: 3.2.266
Date: Thu, 4 Jan 2024 08:51:06 -0700
Message-ID: <20240104155238.454117-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: fe550e76-b59f-42aa-d2a0-08dc0d3d4d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9z+pFEMlrp0hSqYqQGSuJNbGdV9mOCoV6qeY2QtkYvnoj4LsyVkd/EzyQFxbTxrLS+IyN9uFmX12Qpx/xV5HaAtS35Rp4Nv7Ia+cUj1iYCee2IYBWITaQ6Pii76ehBpx19BWZuyU5cbCIn3LXk0hkxIAfvAFKYKj/oLvihSzL8jWr6e5CG0RRJFoTaENCCBUnTBJkZ06QgVuCHgjXjHLLX2SKi5zK8m/6oovBwxs3XevcfGGolLwNReZlKllsOJmh7NeU78zSXLimQ13kQ7M31o4tlnhulPFJMxkI7MOqppyJfcgWfTKlzzHTgxYCvHHfzcHGzGZ9lLfPzDMCH8pK6dJO7SRVN88FYEPmeHgZR//3OYJQT0db19JU0tXqHdY4nTAfqGl1mkgoFEfejY7owJhCpv31KamAAdp32+mm8XsKiaulBJeePP/lDtx3ulKxwdpBiC59BwalMC7XzF+A+JAN+e13PuzNvlBXk5ilEFdmN9mUvLGOp4dpGHyPsJibIm3205+XBXIiryHboCSNKuGoG/3D3oUfuM9oRmSNmx5hnu27B9hdxrnyIzSf+JirVqQj6Q6mJLyU1tanEGTn2BkrGBEjrCLlKTPpnQGUnVlR42QS++pVBn+ANWZ4b9RbGTTqsadoT8K28tf55z9h/9QJAxQ++P4SpMdFYr7xn8DqXT5q5LEGw1YF/EXhhrqQFm2mcBeFcWfaxAEwOzrPLfnAA3CmEkHMn9B92NKhoIVacI/ND0dnH4p4vspOJQ/kOgTPmPD2UJu9aoQS79NIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(26005)(336012)(426003)(1076003)(2616005)(16526019)(6666004)(36860700001)(5660300002)(4744005)(47076005)(4326008)(83380400001)(8936002)(2906002)(478600001)(6916009)(70586007)(41300700001)(54906003)(316002)(8676002)(70206006)(86362001)(356005)(81166007)(82740400003)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:31.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe550e76-b59f-42aa-d2a0-08dc0d3d4d2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Improve z8/z10 support
- Revert some of the VRR optimization
- Improve usb4 when using MST

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7222f63caf28..5d7aa882416b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.265"
+#define DC_VER "3.2.266"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0

