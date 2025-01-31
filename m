Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608F7C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CB010E37E;
	Fri, 31 Jan 2025 16:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wlqq7Khv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0D210E37E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVjYDN8Z94qZ16lfCe9R1zfdtZHWjUb2Kzydvt3e38vQpUAMxA3CKTneJFCft45X+T6WArZeCz60WOQthOVXzjspTHb1V/PtAoTW7I+Q+mNTtP6x4SxQFHsi74FKTQIvfFX2Xuepvkdhg5jGkeVXpVQ8FmESZizi+u8Sag2N0qJpd4JZ5nxJ7CxiAhl7avC/auNcSNeakyTnoVa4huOf6p8CXdUa8obJKw37Pa5L/SJD+oe8YvYBkXV2O6qK28PuLnyuPoPkWzxOgypVexYC/87Rm98h+Ll+oBRBJaMP8FpX99l9n70MsCpvZgmLxx6GfA/vlMPyxoM2QWA/b9slRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVCICU1ANOHAqXno/IgkBmRZfkezIIzbz7FYoSNPlG8=;
 b=tvAnqHxJwpvFzGOh8debagK6yL2o4wh2ldvjg9gMWThTz0E/+Mom7VxNW2OulOWEmrUoYW2V0oiMLfYKX4aBRjkx2ig59gJEy6eMvj2Bke6sa5RkQLjt8kM82tGzR0hR3Et04f5Q7WtFWz+6VHyDcRSVE/ii4fp/zOep5jlnLC72SPnBNrwiiJ1ba+DkVIOKzwj+FYbDh0ypUMO0FsXrGDb1O7PFmkzntQ9jprZ/PKvZ2qXrSmUygxQNPR/ru/fwYc/Ay6lMnw70rlaGcHMq7xuvgeNkYAp18g3lx+c58dslTtVCkXXehLtnVkw4tcoS1sjrr9vBtiFCWt8fSqpLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVCICU1ANOHAqXno/IgkBmRZfkezIIzbz7FYoSNPlG8=;
 b=Wlqq7KhvO0Z/upncbBi2RAT4specKoeOq7o/oyVNmPLrBwCBlzg5l00dDp4u//NMAcU7zGHhG59dAHwDU5SzZX9vefCV31leth5RKxu0icREzdBZPGGmYalUPR+DrmxiBJYwTsp4tE3lYrDzoORWgq9K3vfiDUuLMdX6Is0TZwY=
Received: from DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26) by
 PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:23:33 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::6a) by DM6PR01CA0021.outlook.office365.com
 (2603:10b6:5:296::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 16:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:23:32 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:23:30 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 0/7] Add jpeg ring reset callback
Date: Fri, 31 Jan 2025 21:53:14 +0530
Message-ID: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: da1e3374-6a3f-42aa-1556-08dd42139ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXZBMk4veDRCT3o5TmkrNkNjdkVZUGxNYnpFNDViQmp3UVhSaFZsc0V0MXY5?=
 =?utf-8?B?WkxjUEtnNXl5QmZyOEs2SlhPSUg5cW1qdE5WL21CaTVyZmNOWnBJZ1Z2VEx1?=
 =?utf-8?B?eUlGdWo2OVc4M1BkUkgwRGlJSHAzVjV6cFFSM09FcXcvSGpBZS9RbFpVamwr?=
 =?utf-8?B?V20yd3VwVVBjK090RjdNamxDWHFtR081ckxZZDU0MFdHMERyTGZTZTBORHVR?=
 =?utf-8?B?VHMvUEhIQW5ROFF6V2JjN1ZISElBYkRObjRtbFJyMUxnTWJaejRNLzExZGxl?=
 =?utf-8?B?aFZPUjZLWnVuRmN0enZTaitCcVZrMWpkWkJnRDhodnY0cTM1R21ZYzdCblJ3?=
 =?utf-8?B?aWRZSTlSemNMckJ6TzQ0YVhhYzF5Q0ZnbzFrUTdKQkx3ckpNSERiLyt1RnNk?=
 =?utf-8?B?SFY5ZmhLUklPRTFMbmFTUXhxYTFWMWlNWDZCdk1yRFZWd0lndFJYd29UL243?=
 =?utf-8?B?V1M0T25Ha1grSlpYczBpQ1MzTE5Nbk5Dem5Sa3FNbzAxYzJCYU41eVNkZHJz?=
 =?utf-8?B?VHFtOWJySWxoZWdUb3Y5YUFNY3FEc2JMakdXcWJuaVpkejdSZVpsc21kczdj?=
 =?utf-8?B?K0xla0IrYlVTdS9lay9UTkxvWVdMN0Zpckt2Sk1PQklsMTNFMGUrNW5vYldM?=
 =?utf-8?B?ckJ3U1p1dGF6K1l0cnFSdktMU0V5WnM4Nmo1LzFPUFh0YzFlQ0lMRU1jb2pW?=
 =?utf-8?B?TUZHTEZUQ1pnZnZPWWVaS0lmUXVBVmsvR0lZTThyN1UvZmJxcytHcEVDZEU0?=
 =?utf-8?B?L1hyeEZ6NktTYjBQWTBvWTEvSTlzNFNrMFRJWGY0ZmkwOCtlQmRDM2tUQ2pl?=
 =?utf-8?B?UFpnTHBhVnl0N2VzUSt4bEROdzVKcWd6NGt5MEZMVHF0TDBGVjRPejdjRHhw?=
 =?utf-8?B?VHVQYVhlN2dieEhkV0VHcnpjNzBsQUs0VS8xcHFwcGc0MHI1VjJpcndKaGV6?=
 =?utf-8?B?a2lEbGpWU3p1MlhOa2NHRDNmdDQySkRvS2dTam9hWTlWc1JmRWRxWWR3R3pt?=
 =?utf-8?B?VnRCRSs1bFQvVWc3Z1ZMSlZmMDhEYy9LRUY1eWllTk9jSW5lK1p5ZDhxRENV?=
 =?utf-8?B?V3hWSVYyR1dTZzNGUW81Vi9aa0tNUU5NRW0xZE5mVkI1bmMxM2ZRRHJaTzJ3?=
 =?utf-8?B?Rlp3TStlZ3BxemJ5SlRQNEw2empJWXRBREVzdjE3MnY4MlI1cC9wRVlGeWgv?=
 =?utf-8?B?a1o2cE1DOUV2VUVlQWd2WGRSazFhVW5wVzI4dWJIdEJSSXErZndQejczTmhV?=
 =?utf-8?B?K2Z6anAzYm95TCt1YmdoRWZuMEtBdDNXdExIQnVadGV3MXFGV282c2piNjVP?=
 =?utf-8?B?Rmw0TzJUTVRQNHRrL1BCRjM4LzFBbmdLaXo1QjlKZERvV3oxYTRBVHYrRUJO?=
 =?utf-8?B?aWJMMGNSRmdMSXIyTWZUcXVmcElneEIva3Z2QmlSYU9lV2ZSTFJoL0I3eHFW?=
 =?utf-8?B?UkRPVjR5VUxoZGprUTVaRnhPUjJleCs5V3VEdEZ4eG5QeHFhVWlaR3FJZ00v?=
 =?utf-8?B?S0V1dndlWlBvUnNRZyt5bk5WbGhVenpaNjR4WTk4VW44OThDY0xLYUFCdnFl?=
 =?utf-8?B?bTJxV05hdTBkRVdvYmVQbnVyeUZDY3VXdE1IcFJPZUE3OFhoeHhaYTlwbFJo?=
 =?utf-8?B?c3c3TFpSUDRmTWJXcnpOSzA3VGJxQXBUaFVVd3ZtOFJ4UDZKVHRieVNBQ01P?=
 =?utf-8?B?UVIwWXl1WTFIa2lTd1FTR2l6Tm8rNGRyZmF5R1VEKzdVWnRZeUw5SGp2ZVZT?=
 =?utf-8?B?bWhnSTZoWVRDdmRDdDAwMVR1UU81dkYzYlpDZ2R5d0xuV3JHYlRRZVQ2THFl?=
 =?utf-8?B?MDFPNHJvL0Rmd0ZuQ0VMeDVsdFRwNWZINHNmdFJtelAzSWJ4WDh0OFVWTklQ?=
 =?utf-8?B?TGR2VmdnQ2hQeS9sZWU3NDRUa2YrSVlOa0hJNWlnUTNRcDhnRmYwZWx2VE9h?=
 =?utf-8?B?SEFRbmlTREE3UGQxRzdWNzY5a0oyVXVWem9Ycy9PNTREKzlVRDZOdEtlTWtx?=
 =?utf-8?Q?GxtgZbgd+54DdsHpDWwz53XLVOYG+c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:23:32.5573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e3374-6a3f-42aa-1556-08dd42139ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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

This patch-series adds jpeg ring reset callback function
to recover from job timeouts without a full gpu reset.
 
How is it tested:-

A bad job on jpeg causes timeout and recovers alongside
an unaffected mpv vaapi-decode(vcn) in playback loop.

Sathishkumar S (7):
  drm/amdgpu: Per-instance init func for JPEG4_0_3
  drm/amdgpu: Add ring reset callback for JPEG4_0_3
  drm/amdgpu: Add ring reset callback for JPEG4_0_0
  drm/amdgpu: Add ring reset callback for JPEG3_0_0
  drm/amdgpu: Per-instance init func for JPEG2_5_0
  drm/amdgpu: Add ring reset callback for JPEG2_5_0
  drm/amdgpu: Add ring reset callback for JPEG2_0_0

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  22 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 125 +++++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  22 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  22 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 250 ++++++++++++++---------
 5 files changed, 296 insertions(+), 145 deletions(-)

-- 
2.25.1

