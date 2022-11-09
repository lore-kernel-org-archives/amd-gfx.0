Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6796C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C16A10E58F;
	Wed,  9 Nov 2022 06:18:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD34810E58F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTE69ZIqQNI0mZ+uLZ7QJU1s0+OpATiexqIGWbtrIjLKAVC/NsNcIPJHZm7rVQa3km2clJ0j57GcDS3yPW4EsRq92NfCjmBfcr+GGD9XfIj3I7NQ6AmA3iaVAW8QkDlkdeRoscTwKoTi2oPuywMxgqe6sG7EjHJX51oJ96oQspJkIRxhLu0rBnSBZ+5JjrWjrVh381UH8u6e8m2Bjg3khhY2CyIvv4TVgastjCENP+PFBFuNuX9C7Nkurh0gQbzvckLZM2WqB7Zj9HFmJR2a4pNq0IHiMEIF/SYlz9QXAz5eH5xfeHHj8elLY5y+NmobfzQF2mQrxLCbLzEA14fHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fspQmCAh0eqQ9M8pOJkoby3FuoWH8SvjqQiW61q6DAk=;
 b=E3CbgTXGabrPBXIZz465sj8EWnsaRNmcdxlXJ9Vu4XibcZPMrKwYRHH5tLkc5Sa+IcEre0yNYwSEPuRuUL06CmFn5tMluCmnni1KV6TbiUVf7CiGNMPkqYJnSNNcgI4OVDPE0v/1Go12f/x/Dd6kOBKKLS3ex6z5y8GT8WZI2TPjKsqkfmfZPukkUPg+0bp7TBHDcPOUdz9EmjUOn+9/gIB6TacHWGz+UkmxPtKskouCuYUUHBqdiMLOjKG6RjmY+oYgXCOghgCYm2JmudIOZ82/UrHhg4kfqWqQnZpH/pOVMnRXn1Dqq+lSKY1Ls7CY1a4Retyygh9wxfgU5YnvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fspQmCAh0eqQ9M8pOJkoby3FuoWH8SvjqQiW61q6DAk=;
 b=ffjPjxz1FHz0x+TvpFJ+cwl6taQAoWsaODNLTNCc3tDfkm3t1NMf/xz/SLEEaJ/1pPFwjV/RuX/qHrRKX6zgbcbHDZX7WTQ8qnA7lhcDZxcPsA2ZNEhbjlZePdIiYUoBMOsi+M8yLA+rW3A4Z4wmIQ6GVoI4CAnyNTp36OAVlsQ=
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 06:18:47 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::d2) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:18:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:18:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:18:23 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:18:18 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/29] drm/amd/display: [FW Promotion] Release 0.0.143.0
Date: Wed, 9 Nov 2022 14:13:18 +0800
Message-ID: <20221109061319.2870943-29-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: cc65cf53-d7de-4e18-f8ba-08dac21a4278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC8CzN3tdjOKpqba6lP+pmpg2fCgDr5DUGFYm0RW/CLIKh0KiJCv9/8DoPdMnL9J1U5pUUwV1yFkrYoJwQdaw9KCAlYebWQjSFxVzPNU04E28OKVyIK/dwH++VxETv1a1+5KQ11/Gm3XF/di7GwbIloHupyYWy5dtp4+2T12iThb0OtBU8HCR82Q0rvkhPruF+fXVx049Do4FdpI+EqDvMN+OL5h4ZDO+2DGTwAm9JTdHvs472gVzkHolO/xRR6fXacVyhjrY6zXqN3uXtKXJnEdJ3/WNaGQE9dy/63Ol+HTLtHRAN+tERrNZ382zT0YE+n7XxR8gVyWwblZtdyaSyoI/ze3h78C3KfjtDPXjyaj10SAURJr6fePFO27HE5PuCxMk2QhMbq3ymLzjdGW2Tpj+NXX0rgCueHY/JCxEr7pPMMuOLpujvBUi2wvNtUGmah7qDNgjGd3Y9vt7HXRRWFWZYWpzkXSsqJFZlaz9A5mXb8ysHtQDZi6HBh+XEMLeXpYVML4JhRtTNA18xw9rNs0aFcjGLOXZ/uAum30T/qL818sTEOYewUWv12HvzVv3qWXWeeqbkpUn9obgwebxQ4nEcG5qF9aZagNRd/JeyvjNCZf3PICgFrmc/pp8Blzqj5fAEUrEh7U2DCeM57FWU49LcORHnTQkSTgQTGFuHJqUl7X68sK0NBa8iaJV/cQmxQKfZ3iIXffCgICTLrbJ479I1IP5MW5yR732m9T2Dns/wfBCJdHYe8hkkOR/t6rI3edmi0y3bX9COic9wm7pfbNXJDIfJJiUX5w2galH+fl+92iorHULHRWbiQKvM+7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(82740400003)(81166007)(356005)(86362001)(83380400001)(47076005)(40460700003)(40480700001)(2906002)(26005)(336012)(1076003)(2616005)(186003)(36860700001)(7696005)(426003)(70586007)(70206006)(8676002)(54906003)(6916009)(82310400005)(316002)(4326008)(478600001)(8936002)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:18:46.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc65cf53-d7de-4e18-f8ba-08dac21a4278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

 - New boot options to enable USB4 DP BW Allocation mode in DPIA

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 34b03bc7f838..795d8811af9a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -407,8 +407,9 @@ union dmub_fw_boot_options {
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
 		uint32_t usb4_cm_version: 1; /**< 1 CM support */
 		uint32_t dpia_hpd_int_enable_supported: 1; /* 1 if dpia hpd int enable supported */
+		uint32_t usb4_dpia_bw_alloc_supported: 1; /* 1 if USB4 dpia BW allocation supported */
 
-		uint32_t reserved : 16; /**< reserved */
+		uint32_t reserved : 15; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.25.1

