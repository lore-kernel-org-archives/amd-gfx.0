Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD590C83F1B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 11:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4591510E803;
	Thu, 17 Jul 2025 11:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CcknJZst";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09DC10E803
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 11:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP7QgQc7zDPN8JUKYUrjZtfzJbdl5BcfJFj6b4qNZT72CZnev2gvCduleFFn4jgBdu1sr/dO0Vt4HHlLM/hVenk97H/sRB+pLk37cE/daWAwPvlGU9NZ3GvQ17dmPnFXZvBPMwBGGQY1L9RO+evtYLvZbuRf98tH/nuvcwd2VojlRA+NFu6AS6yYgLdR0goK1On4a9EQYPCKUDhdY52SpIaNAW45wWvYrR3DyVvJXeLdZzVS5wCRlXYcqN6ltOP1YGMYVwB5/wNYznhrfQIjP1Tf6XgBcC9yxPVKtCCkyPiusWpdtldBdFQG5BHUln0A4HZiPUi69NCg9tViXMQ6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc4kYccaRpfdEGJnAq96gplRGh/DzBPTJAAusoefEgo=;
 b=tILhUn4xyRlSC0G5ARl95i4CJ+zxn7bH50jbifjkUzho3/TeTPlbTU1ArrHj5cguNn2yBXWP5Byler/OSS4G8pqIbDmATtT9VMneH5v5vTCEbckCkZ5bQ6zx7uU38GwFK11+h3B9aQvaMnyqt6zECX4B8rWhgdrpm+NcsTDbEPTCbeWifaRam41zXEz4VURRYF/gi9cW4G1Lg+w88uHrbsAIQO/92jiBWkBHm321LDWjmX1+ULmYFflVggyYldrVJoacFLsLaMknKclbD5qBohT8F5denmDLOO4HqtsFl/WNyS3Jd6za1TJ9o3osVveI5pT/5C1aMtEUmjLGt56VLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc4kYccaRpfdEGJnAq96gplRGh/DzBPTJAAusoefEgo=;
 b=CcknJZstJGDAFbzHELXHW5Tt4tDV7L11209BusZIGf8B+PuiB3ioqYE2Kl632DpXp7D0Aas4cJhH3L3KMizRsaiFOWCg4VVE0kKA7Vy7tKbYhauspSIEL++PAUbZ0Rqx9B7nmdt2FxH9LPgEOFbntSzGfFRpoXpqRwOlUYNVtVI=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 11:07:45 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::35) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 11:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 17 Jul 2025 11:07:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 06:07:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add description for partition commands
Date: Thu, 17 Jul 2025 16:37:22 +0530
Message-ID: <20250717110722.1557961-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: baf62679-e7a7-45dd-375e-08ddc52227fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6bHxrhVHxNIicaOxXe4g+aZcKbxo8DsV50rIgwLtGRf3Hxhq/ExdLH75Wqx?=
 =?us-ascii?Q?boPiUL57Y7Kxb9x3v1J/JkwZjAuQPsDOCQ263pCftohD72eCZS37K5JjhFlH?=
 =?us-ascii?Q?Uo+9saoTvNrlcWWnz4RZMmtUiaH/XpKZnonitAU1ngyoYYwyCTvc4BelTgyG?=
 =?us-ascii?Q?ICxOdSS/onpkw4rlN0wjdGMaQy/1a7KwLwrujQZAE1xDybe7W4UrAjb099EJ?=
 =?us-ascii?Q?jF8z9dcLJhp4OYBeclB6mIx8vCR5QJCtopPtDLV3snKG+gN1fMFwJlErBYvI?=
 =?us-ascii?Q?33UeehKNkkKysp7AeU4uoRX5+7odIvNVLXYE/S6nIDekygQPJwurB2zyf+ga?=
 =?us-ascii?Q?u6OiUO/dYHMy0K9Y/q2p84/n5bOVAlywhvOvBYAjGiW302O2OdF7UgE1rj6p?=
 =?us-ascii?Q?hnuVxqW72fnxmuN9xsxoTla4t4C0JUDsTQNFCTDUkfTZeMM9rPPDOS46PEfe?=
 =?us-ascii?Q?5MYsn8G3jBDz8LXeLVRAeLebm9jPFD6hqPtMXdWAWlmxq33HDOjRGDDvOQ7r?=
 =?us-ascii?Q?Hgc/XW4xiGQ1QMp2xy4xCTwOPAh/psEFG3HBuAPihO5YCdp15baGjgO4uHWx?=
 =?us-ascii?Q?z3W3CUoCNjAIrdyUH6c0tEjiOSMqNQh55zNk/YdcIayy0ZsJNoNfuTQPqWor?=
 =?us-ascii?Q?MRTvtTlKom69YNpgbQPq7EyZyG8pBYO7RGojl+N5o5ASY/roXbLuLSa7wbGs?=
 =?us-ascii?Q?ATd/jrWGD+XVxH7p19Utaf+ghq7G1LsPSDG08jf0hoWNcCjFtLAlPCxULuJG?=
 =?us-ascii?Q?cn88ajm0vOE0r3o2N/smqH7VsJsrRT1f2HgjKmVF3AQgqGhToWkGiogJrTY0?=
 =?us-ascii?Q?k8TNIUUroxyUAzwd9iYyvcYhL5Njdox7BDEoGNIkQ60GtmYK1VV/33lS3ULr?=
 =?us-ascii?Q?LcUWZq5w+j5WRNqrwciGFXMBeWNCx3A/5g57m7+fEuRImf90dDGlI+Nswy8j?=
 =?us-ascii?Q?406/kP60w/HPIqeBbfx9rPEkEJeBXi5VRb7coiJLqNAXfYy09J+MzoIo/Q/L?=
 =?us-ascii?Q?E0bG1IrTynr/d5E0ZJ3w4JjeDHcOQFXJU3w4Nbxt/6YFasHmyktnzqL8VoUp?=
 =?us-ascii?Q?vC0YSyssUnb6w7YqIcofdgf/iHQQsthJmMkjxDCSi8DITV9wl0cRIvmZIemN?=
 =?us-ascii?Q?Rru64SZvfzwzkXcpcmSRTUPJmIsB56XdoOSNeQZDBYfYkLUfTr2BpxoVin2w?=
 =?us-ascii?Q?kuoCFJ3lJ/FKjFzDNYf5sKATJZyW79VwJkP3i6Ek6NSGfBVtWVk+NNhS3EeW?=
 =?us-ascii?Q?vL69H6KfssgqTK6Ana0iyHMZ+F9XoN/EajZ41d+KEtHipaI2YjXqXwtSfpE6?=
 =?us-ascii?Q?nGbpAIr/34vMZalvRYZKmrI8mu2RjsP7vPJy8NfuZiEkILRORONi6Jh9GOJ+?=
 =?us-ascii?Q?bpzqn7wSMVQqA60y5jfpw3YITTCX416a9H/ENbcbpmIQoxJX2JtUSaItCRj0?=
 =?us-ascii?Q?ECvR/s2yRhnx0iKuhHW3FiA5vbNZbPRTW1/4uVFPWXLcxAmvM34KWgo9PPbe?=
 =?us-ascii?Q?M4irlXt5d/O0RcVxfdusnw86NnnwykLysGHl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:07:44.6335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf62679-e7a7-45dd-375e-08ddc52227fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
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

Add string description for partition commands.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 25aa35de1e41..030d7db78b4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -666,6 +666,10 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "FB_FW_RESERV_ADDR";
 	case GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR:
 		return "FB_FW_RESERV_EXT_ADDR";
+	case GFX_CMD_ID_SRIOV_SPATIAL_PART:
+		return "SPATIAL_PARTITION";
+	case GFX_CMD_ID_FB_NPS_MODE:
+		return "NPS_MODE_CHANGE";
 	default:
 		return "UNKNOWN CMD";
 	}
-- 
2.49.0

