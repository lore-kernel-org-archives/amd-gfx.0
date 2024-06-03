Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D227C27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6480010E1DE;
	Mon,  3 Jun 2024 01:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J+IugXox";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1605710E1B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS75DJalsEiQD510tk0ab0hGWC2nKz2Yfw8AUbkeiPIp2qY0tLlwReVOA9PPRoTI+dCaJ6jV84LHpXPj7WQYtwQPIqXhJJ7y9wmmCgSzLmAYURbhOAy/fPfc4dO3kV0H6EoXKZnt9WNLO2FTFVQqTgVnV6HoC7E+Og5sL1A20EDgFVKHwDxwmZ/sFUxGvB1rqQOlHUdqOhYMfPzvrMxBcGZZvlmKwa6SJwsbMW2SofScEBhx3gxbkGt3Buh7laLtov8ES6NUFLzVKHs1S//jGYS18QFpdJQOM9nPejpbb85IBomuvK2TOqP5060jlnS3G/vR8y9opGoV7tv7crmSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfuEgt7sy+V62aq2Sii76qtSeeEumBtCCs9/SownSMo=;
 b=cNL3G55gIsWFn789lczgIEYLYqrcEbs50vsStZ81LBblKdjWdIO+re4yb+lGTtfiKAjhn3jEL1cyO2I3uBp00Rkitfsajbq4rsZT6V8vUVev5O2RudIqe6+4VXMUlqZVrLb4jRbZDFT1JYN3HnDqQ40Tll7CSz+3qM5PosYW6057CpSyfKccTLql1oTMvdb9E3De8FyA+sa9EQr26tBjLsG342dhYvMh7rTuUoM8pwEXtYnF4pjYvyD74kzRFyTJQDOiT3+dQVBUIhjFm6oA65NjyEKY/MOQkNtmzTL4b51vElsnoWL3McVORSw//A5TgvMY2IBms4lRU/VB6LJGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfuEgt7sy+V62aq2Sii76qtSeeEumBtCCs9/SownSMo=;
 b=J+IugXoxeuLbt9C9XHutGnA1oF7XdnsnuKDMx4O2PfpewwjNrnZFhZmR1pgL6J2a9QpTYQgMyH/kTGXTrwSGrLkQH8j0uTS82b3sif/M45G5QiCki34HBYSLq5xrOBc74br6DOjKq0TgQU8Tskn40yRSLmpKrXK4UaBV9w9ac+E=
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 01:42:44 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::54) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:44 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:42 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 03/18] drm/amdgpu: refine isp firmware loading
Date: Mon, 3 Jun 2024 09:41:57 +0800
Message-ID: <20240603014212.1969546-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b080d4-225b-4440-f9f0-08dc836e7704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ktEBTS+7lsKzKixssugaGX1OV+nUEGZqopU/T7FWwkMqQd3cnu/JQwe8gml4?=
 =?us-ascii?Q?tkVbhJOskmXkS39tqJxX/PQcakGkgps+RZsPBpKaNezRs8mV+5212YUOvv9B?=
 =?us-ascii?Q?zNzFQcB1MZ+2SgOaYUR/OsGfUi0dqJOnRl3o8+nvMtqLlWswvopXtaminWro?=
 =?us-ascii?Q?iuxAKodHasOUOy/H0D2j3ey+k+h6z2Kr8aeW3unyGTzHxPeV9DZVfwzKdC7i?=
 =?us-ascii?Q?MyHNWQrebUPqNoP00j2m54Bn6vPGjRD3JLrsb0+psiF/wAbez83IhHv4W44j?=
 =?us-ascii?Q?1ufuuMGOSLI9CiOT9eCijOxc8Zqwn2NhJlfjLKg9ohXVhJUjgW4pgGjHmmeA?=
 =?us-ascii?Q?7HhxH9UFv4KabAVTGaluItzBgmz+aKMxUucaOIN6XKlA5azRaaWBD0HwcifO?=
 =?us-ascii?Q?eRprXlWb+/52IHkadejshkINvfDfQmVE2ytgADp+QpG22tX1jUkfCt6NGuRp?=
 =?us-ascii?Q?4XI9YTwSDr97/U6UGOuWsAt0OVkaCDp7anCihn49oPlwipZr9ddnZh4nGHk7?=
 =?us-ascii?Q?fSecmFuqweJX7G8a7FzH2/oEg6Ev/xeqk30ABEP7FtwRXqn4yENXTX0MFO5N?=
 =?us-ascii?Q?BSZFQf53wYci3tbjHsBSfAjNUx2djtTxlYfqouh5k1/WlHRcsY225gqK6X2Q?=
 =?us-ascii?Q?0Ls56wm+k60j5GCK7CqKtn3L+TJMl0BKgE4lkhFyjUOcwLKGpX7On/LaPd8h?=
 =?us-ascii?Q?Wc5e5T/1AfbtWZxNIg7RvQepN1MxvxzSjCO/sQ+8us1OlMUIC/mf0rtBmMy/?=
 =?us-ascii?Q?OjKq182ahfPZ/UKUl0HzxbsorjW6VNKnCdCj1KDZQGXD8R1Llq1VuBL/tZzF?=
 =?us-ascii?Q?rXGzYIUeUMA5CYykhY1hB0PjJRGv0s4S94qGNbhNrvtYv9xSAzAbEzUN1hAF?=
 =?us-ascii?Q?YE3EUDz9U4nOcnJdwWjXZKBitBiQ9kIF+rmSIQeAA24QKezBykaCqjEQYZOV?=
 =?us-ascii?Q?Z8msEeqS1hmnKg8TjxXNkT4uhxRdtTjgJaKh0E9QeSxaDlQGrUy+lBV3wt1A?=
 =?us-ascii?Q?rhFy1KQnOcdfB+HNS9sxliMj7uAcTzNCFmAvDg6Y2jFgWEz8WMie0AvH91c6?=
 =?us-ascii?Q?nmjgiI0ILRZmgEiwKIWviyGe8nhIx6prNuSHs1AVVq6rvMqaG4Y/MT+unil8?=
 =?us-ascii?Q?tskE1ylkE5YDrZAzeUdngKsoMPiHXAQUahwsXMTYr7wrVuoh1j0GEjcaX6HT?=
 =?us-ascii?Q?aQ9TnA7yHcYQSmKMKw9XX/+qYvuuSRUCGYOvuj0syKwfbtaBhXBk9IBwVTCj?=
 =?us-ascii?Q?25688ERxmW6z73w474EnSUrWPAdJX7XIS1MS1sKnX14GHi5MdXkl6ZXurdTJ?=
 =?us-ascii?Q?vGv7yf8OCmkJbXAqwH2QNNNvP8C/hvYjvRZ6bJk+CYJCV8spR/N73JuEEgkk?=
 =?us-ascii?Q?77OxpV6+dnSA2klkoi1D9FSQEM3z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:44.5130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b080d4-225b-4440-f9f0-08dc836e7704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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

refine isp firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 2a3f4668cb9b..215bae809153 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -97,16 +97,14 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	char ucode_prefix[10];
-	char fw_name[40];
 	int r = 0;
 
 	/* get isp fw binary name and path */
 	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
 
 	/* read isp fw */
-	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
+	r = amdgpu_ucode_request(adev, &adev->isp.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
-- 
2.34.1

