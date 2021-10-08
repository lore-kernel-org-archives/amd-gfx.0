Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2050C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 13:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A753760F23
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 13:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A753760F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359246F501;
	Fri,  8 Oct 2021 13:39:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6F76F501
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 13:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrlLTysg5hQItcP4O20TpWF5nMLdZWk/pxuP8VztbhvDMi8LrrqbM8qgrnEJ0xsatCXWdMd17ks5zOJ8AsK6rcVwg1DUwCfPYegniuzuzVFwWWU8CFWb9NEXdAx8KEejnecpfSD6x0UJ2Qqh1vpPjbdGJtarT5MaoshlzYFtol0Qjxy6HMPTozQnn0Ci2CIJUJdSYfOraUGzX4md+gr5K3in2TE4SY0Lvw70RgGPO3avSI7oV2Vqvt9jMlfyfPi23WructqKYqbcLrxTmGjTgYhVjaX2DZOu8jdsMO8ariVRmCmeOD06WdSMH2TnUgVtTHC7NY+V0F9l77r9MDa3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWLSxOBkrRM1vNezCQiHFeJfSU9oqos+kGdyxP65z1Y=;
 b=ncbae1UeQr9PmAnE3Ysr4SBqbXPbDrJQRjio0Pb+PPu/JYaK3TUBARNFyVAmaq4vvfVmA22h7ELXv8FQ9dRCXdqgxXREDHlwBHVJg3VsI1iBaqCfsLYOlJwbKainFCkHrTiRt209MLf/NNHEfZAZCQmg36vc7DkT4yIvFue1T4CLvngOPIJBI+ma73sRr04UK4wKsmdUKTxVFe7PVAdySF5BBfd/RFIlT24kdSjz7ig/8UNyUtHRioeOb+TpCXFpW+F9TRAbf+i3MDbUugKjKp9N1fZzFu9EG/yDjQyLPrjCwx3lys4B63Tl6f/GgWA14m8iVxfaXcNhpnwWi1JhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWLSxOBkrRM1vNezCQiHFeJfSU9oqos+kGdyxP65z1Y=;
 b=IYtWOdi7LEdQTIfTZNTimzb+Gld7X+40h5sDAkI8nkZtlTOvGDw4xdcHZ8ZxwYXG81gdfeGO7N3JT5D413mbLiK6Egxv2j8rypbakROaX/1cOk/NRDAj7Yk1t7XVVF0+SMMoorEcQV9J15JmACpNWV4f5pnUEwHKMq+sYnNX+ak=
Received: from DM6PR06CA0049.namprd06.prod.outlook.com (2603:10b6:5:54::26) by
 MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 13:39:47 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::85) by DM6PR06CA0049.outlook.office365.com
 (2603:10b6:5:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 13:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 13:39:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 08:39:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 06:39:44 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Fri, 8 Oct 2021 08:39:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Harry.Wentland@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Nicholas.Kazlauskas@amd.com>,
 <jude.shih@amd.com>, <mike@fireburn.co.uk>, <Jimmy.Kizito@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH] drm/amd/display: Fix Werror when building
Date: Fri, 8 Oct 2021 21:39:40 +0800
Message-ID: <20211008133940.1251892-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ad6ba2-9d19-4524-2237-08d98a611812
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR12MB409502266EC400695D62398FFCB29@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqChnUf5bVVvVpDZU3vVeTuG3PJG3LtQN8QKVwtd0635oMCLe6wM/GxBxKDIuoHNGsa++feAGgvJc8gCv1qYnNJC4DwTjQfwIJfZ7Xhtg9/W2Ia4ci5f1ce86I0MSi76i9vSf4+dsRxRvpyqGzA6PFsXTUiDDKxIYZfJAG2rVJRius3F1ZyKY1JaQLciwqlIv6gUm5dZFkTWGubZa9XowjnkOi3CK33LbG6GwUEr2Fv7T0XhwP8EFVyidrqPaDpl6riDPW5ubV+U1Oh7QayeCy/U0x17RpyvtuwVRz2k6tAcCWnTKwww7P5lfHcXK+lg+rZ162W+ZfN17HrSL/UlsZyi5C0eMXZ0PG1H7Ba08iK2I6qtFJUVVxovKjgQ3GtjAZ3AYv5K4OV8t+Rmbss4EhrC2LKyHpBQ/qDmV0wQJqesiHRuFSCSnY5qREeoS5PQ9U7AGAlDWlJCG8g5iWDwyUj9e60qYuZDjmlKCwLl39wQKvZNh/VpUzZzEwjmmh/BeDoaJSYQN1POXyKb7rdVKrkGxMkafFf+3BPZkgSGj4AoH3sI5sO56nLddmaazfc3zMs92gs1pefcQDIytmglOC9RmwnselBntxSyuGgij2TeJRPlC6M8ZNYA+HaL58dxMIGa0cjAo8FxdWlBL/w0LcJMbObyfwrBOB6W/MvHK2OMNDrHdPpO/PwcmNMaYMAUr+JufmzkUiOnTEvFTdmYlj4e+uVl5c9VAYz5aCT4gX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(81166007)(4326008)(5660300002)(8676002)(7696005)(356005)(54906003)(6916009)(2906002)(1076003)(47076005)(316002)(508600001)(8936002)(186003)(26005)(36756003)(336012)(86362001)(82310400003)(2616005)(426003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 13:39:46.9148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ad6ba2-9d19-4524-2237-08d98a611812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

[Why & How]
Got Werror when building with Clang-13:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:195:2:
error: variable 'ts' is used uninitialized whenever switch default is
taken [-Werror,-Wsometimes-uninitialized]

        default:

        ^~~~~~~

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:200:9:
note: uninitialized use occurs here

        return ts;

               ^~

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:180:2:
note: variable 'ts' is declared here

        enum dpia_set_config_ts ts;

        ^

1 error generated.

Fix it.

Reported-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 6936b9d549e5..64d2461953c4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -193,6 +193,7 @@ static enum dpia_set_config_ts convert_trng_ptn_to_trng_stg(enum dc_dp_training_
 		ts = DPIA_TS_TPS4;
 		break;
 	default:
+		ts = DPIA_TS_DPRX_DONE;
 		ASSERT(false); /* TPS not supported by helper function. */
 		break;
 	}
-- 
2.25.1

