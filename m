Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5075FC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60D610E40A;
	Sun, 23 Jan 2022 18:21:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3DD10E29F
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhU4vS9z642JOLjf2f4F6VLNB5lVMjwwQSqSgRvYJBrxZ5f4w/+yo8oi8GCXqOyjU7GyZJZ/ykqVNvEtmEuqoD1zycdxLB4Tc6Er8drzksd5ji5mCz2aUdxYDEnkxWa9wh6qxD5g/fVRzmN4WsN9jvSJL34aIAmLtqaWS2PqSL3Xf/qOJc5TIXiuBWKdnba1bUCC1W4o4mIYAFWaxgn7llI87c3YpUPvDyrPexVGAfdz47N8BwNtbAqYoTKZDEpWidpiBIi0D5DBI8QBYW88yOYiR273baM54e7Wp7S/KGV7aNYqzvkqCdwGtKrebucPkH2ZMbnDaDWo6UKn6NvFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzz1CI7gjj33yzvSjZQals3/F/+88wXUvfulXZ3y460=;
 b=FxXzTRo0as66Ld0rjb4OlDr8fTgS4OzY0Fs9E509qiv+IlgnjSmyhbWN4ORyX/CtG8OlVyjvlCQXnVQVL4e4d2i+yrOEJ31ubmarAl6G0niqstvEjjQrYc2qrq+VmYHhUcYaiiQK9kuWmICvCTSOsF4gD8HBPG6GVWNylmXS6CAuZ2EqVTEG6nCgdnu8L4sHzi2ZDUUdSeGxNHPXnGKqpPP6uT2cGcr0FVFlSDF1L2VciEIMuj1N3fh5TSftXeZMNxnScDugQ3DDtBWABvXX8bXTC0Q82zfrFgGPNd3G23fazvgBfXgRJedFuUbKB5xmgtSHcgqrLEtjiIMLnR8cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzz1CI7gjj33yzvSjZQals3/F/+88wXUvfulXZ3y460=;
 b=2YgcdwuVG6+6SSBN+80015JqgBGK4H7VYJU8EjUIOFLR8hL4EpuAgb0JAG/4x7eKe6mscLeaNSjGCuSdTmWnDpdcDIgF99Ka9+XELZRJo0PTr/MvSoky6xE69EX9dEQeBdjLpB98Q5YHTWafZ63zw58iLOIsYUfyammMkInKfCs=
Received: from BN6PR14CA0009.namprd14.prod.outlook.com (2603:10b6:404:79::19)
 by BN8PR12MB3524.namprd12.prod.outlook.com (2603:10b6:408:68::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:20:59 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::6b) by BN6PR14CA0009.outlook.office365.com
 (2603:10b6:404:79::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Sun, 23 Jan 2022 18:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:20:59 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:57 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/24] drm/amd/display: Only set PSR version when valid
Date: Sun, 23 Jan 2022 13:20:02 -0500
Message-ID: <20220123182021.4154032-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c5a113b-675a-4067-391e-08d9de9d1b16
X-MS-TrafficTypeDiagnostic: BN8PR12MB3524:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB352441ACEDD14579D7D30C7F985D9@BN8PR12MB3524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItPaSVfyQG72DgpVEaUgmaRiAzVnYCpZJbKETwGa/4yHrhlKn1IiBM5hfS2gLWh3qfVwYqQMsiY7CiNa/1XHSne15vk2fu07+NTqjv2or9rBojwtkXeTSdDQyei1rZmozgKNtqBNNayNWrBX56xCBIMQG79RLXFVK/PZuG5TLGCd2yw3EOz01W+OUumG4htDPLzcRKCaO1AEKAA8fnzEoOFD2qv9LkZqpVWhnXhm9iCNO+toGUN3UJUMyAofdoj6HQ6xtEdTHCu0yVEaK3k4lHhe2rj7g432qDjoM39BMPHUwCnv0yEOnuVZvIoRIe8yGh1KVjIb64SvUgkEdK6enoC24TFkTAYVJTxFPJsc5VymtICOzVE+jkv8yrXrlgpyp4hfEVtvB3P8EIUxMax2COHV9VUEE0XOkYOVLOcGQ2U8uqMIUtiiZen2ppTDN+tZs81ZyjHeqzlhugRE8A+tougHgDmNmjMovMNdW/6dnIhdkgSU7pgGx1M6cx0Pj+BWHKsFnQpPCsKvRDLHZgaHBYa7hJyBAiUsANgNuVx5ajEIobSxttpfmp3NSjLEn54JarlURzI/dQNaZ0vrSd2X+G+86AobizFAZqM8y7L9ESi8TICV3Oj/NJVfmjtFxs95qHnhjPEj+Tv6fTLS2ncpMQKi0voee7HZWUaMTvXDc55+0FXcw17GNu9byw42VWN0AWAuU8Yr7V+oW7dhLmdaHwiNWjyweDcP+3DUG1IkQordJlLDlZ/uw7hNcWzfIXVQ1OjQB91GxdyCD+ty1lISuwF6eCRTR4nkWZrmYjQFN3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(316002)(8676002)(70586007)(70206006)(2906002)(36860700001)(4326008)(356005)(81166007)(54906003)(8936002)(6666004)(1076003)(40460700003)(508600001)(336012)(82310400004)(86362001)(426003)(36756003)(2616005)(6916009)(47076005)(26005)(5660300002)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:20:59.4840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a113b-675a-4067-391e-08d9de9d1b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3524
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DMCUB will hang if we send a PSR unsupported set version command.

This can occur if we fall-through into the default case in the switch
statement for PSR version.

[How]
Add an unsupported check after the switch statement.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 87ed48d5530d..8bd265b40847 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -138,6 +138,10 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_UNSUPPORTED;
 		break;
 	}
+
+	if (cmd.psr_set_version.psr_set_version_data.version == PSR_VERSION_UNSUPPORTED)
+		return false;
+
 	cmd.psr_set_version.psr_set_version_data.cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
 	cmd.psr_set_version.psr_set_version_data.panel_inst = panel_inst;
 	cmd.psr_set_version.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
-- 
2.25.1

