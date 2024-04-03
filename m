Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAF7CD1299
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871F5112E80;
	Wed,  3 Apr 2024 19:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rhsqrMKM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3456E112E80
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmNOnZQ2ffiJgHH0YKdbbk1kSVmZx44HIf1V7pqeguy2vEiOxV8Tn/JMHE7CyOz0Pzes0Mvv66rZ6x+uo0G8ptDFppM8mwSkjNcZUVvrSJJHLUnU/HGgWFCqQNecTI9BIrSEmvF5kTTODkNeRxha5BNuFzsr2IGUj5TLQcrlv9y5NU7xa/NRQkJEkSnj5qy0LsSzQW+baRwtb5Xwr2/DEDuf/En2TQSH/dl4rz6ADju8CCIb2pszXV92qvt0rjcX/1aAGeVBkoQEaIo+y4SKGzYqGkbWiaO83g7DzgDezaqkBoCw1efxhMKBXLDho0ZKE/lrfIKUOgJ+76BAvkRMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enV0ncS0/1dWrfuHA7vcqgfThfi6QriUVTriHS/KcJc=;
 b=iiUq+430SAZfqGe0UCH7cAeHDuMUSRrKvu4z5yR77q3yFZQtvRucdV/N0QCeIn0kqdG0YdnbrW+Zgrvs0ecn42g+W2l8qmm/nDbFkX/k9PErsiINqNZ666SWEjTHl8vKxfhtiuPdQaFNeiGzUuB7gg5Lnx6cVEwDFlIuSbMeA+2UKBCp2O5lXVRXci1J5doeMGE089icRyu1WR0Fuu8Ggc5KKJRdfK4gN8iPvXzyNSEI/7chBxTe4g6Q6hNwMPB+Kr+r9+q4m1/xld8YzGYhed+4GhavCkrxHAvxU3Pa2+E/xCh1MWAOXaWrz8tGu7h5CAa+PCUY8Vqg8ukPeVwbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enV0ncS0/1dWrfuHA7vcqgfThfi6QriUVTriHS/KcJc=;
 b=rhsqrMKM51IOHxABqJbBxrPQvNN419CNavfSthaRaNHA2VAVFq4/DFdvgvp+0QEc1KD4WK5/dmKfGnM+BQXfM7+UcGa8oeXxupvTIESP5xYAKrubNOUrH8/VAR4lbIY3TUA3LMP/GlcKwcnPvZYLnx/cadEIly9Khtnmscmwefs=
Received: from CH2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:610:20::17)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:51 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::58) by CH2PR07CA0004.outlook.office365.com
 (2603:10b6:610:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:50 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:45 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 16/28] drm/amd/display: [FW Promotion] Release 0.0.212.0
Date: Wed, 3 Apr 2024 15:49:06 -0400
Message-ID: <20240403195116.25221-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: c606d4de-a469-4d7d-b09c-08dc54178144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aT/n2+PCUTdBpjcxqaGDn99kp/VtZhmfBg85Xnu/qungZF+H7zmBrLrQQC/QkbokOXnhJ1T53jLVLr77E/cR8HcsDT22Zy4Bfvz/m+Zh9kdymwvNDb+IfJ9k9E+UV9Cj2dYCLlRc+qRIq72r2n8SjE9omE2y122MSJ0QNpAxzGIMeyZimaGHU/5qvRNWGm5tnZXrHGHkRKsx/yNvXJO1lgkkNp/FHUbGywLnWJC7lHJo/hRQo8EK40oIqSO4Rql9Bk8dHz/mS+cXGsdzq7mm8P6jaA7QT2a8odKAiq0WNvLl3+fNd0hcGSbKZFDQk2vh3OIg1P5fzDb+gHBtFiyIbKuBVthHMmq/Aif02FNHgQ31GLJPQNaE2Njg4SvgAEOhpe+mroYG+ppofiAD2eMQhXynS4OAveRfhlnfWgdP48hHd3pN+gM7OtQGcf3Q05oKm9RZkmx7WXFxQRRJzlM4r7Q91JkepmcN5zra2HS9sd4VPGmr2/N5o0vz8s9gMV0ay7FTZ9e8r0joCugWzvRQQNcMKiauaUSTs/Szdgz1RSRdLT0PWa1B3NrTivBKAWibsZ7SFFh4/XtaNSn/vCHoTBZnqMohxV5C12HJvc2bCDoYASfqjxNrbhRfYkA8LHr9rFUILaPurR3miuxo20Wh/DzeTXqTLM9zUYdtbR31JAIYabklp2UFhoZ6+rwtF3JWmHtzo6vYwfWlWEw6tZ7OP8gK6ynWOzYHscvargtGiGdbleCjUiX2mFnY/DBvHf+L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:50.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c606d4de-a469-4d7d-b09c-08dc54178144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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

From: Anthony Koo <anthony.koo@amd.com>

 - Add boot option to change the ONO powerup flow, impacting
   the order of power domains to power up or down first

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d0b581b8331c..944f14307517 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -662,6 +662,7 @@ union dmub_fw_boot_options {
 		uint32_t disable_timeout_recovery : 1; /* 1 if timeout recovery should be disabled */
 		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
 		uint32_t ips_disable: 3; /* options to disable ips support*/
+		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
 		uint32_t reserved : 9; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
-- 
2.44.0

