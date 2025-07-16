Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9C5C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE87010E79F;
	Wed, 16 Jul 2025 11:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uo357W4d";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AA810E79F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgqV0153zoc672yalTXb6lJ8Sib3y5PhSLu4zeGRRF0P9YcKYAoznbamx3idSf5T3CtwKjicnBgZcF8b2+MjxAGr4taz3VF9TEnlS4xdYhKXLepOy/U3i0RSn+KUEhpLpC1MQYEZJ8G1sYg1x3zhk7l2yyylyTsY3aWgbBxeT7ZjUQHLCHqJgYP2bkLEVIaBORdOd5IGCgtSpRs5LdH8jf2qw9p7EqFZ/fjBPzbeUayTmbKmacmv89SXcq4m695L5uJH20GBm+8tXKOacpnmEE5bGLgtfTc2WpL3KGdoj3V50PW6BkQBIgJJyhOzWZihRSgVrDhKbXYZei4IF1tPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiVOM2wvJgotqJ6Cf8lqX7Nxbez9ynmEHXuSdlFn29Q=;
 b=LAqZrXqXWadyyKt9kf+MYUy9QbbmnfdeT+gU5mfnL0jGD5/9x2owhJEtfYe6qWmJBxPIQCyilPmKAfYucnmWkPfn/ieKrJ3yiXM92MTl+L1VVuB1+9XmSRihmcHnVMrP2oRGcP2mlS/XzrKoIedwkgBnQx2X5GNDb++MhV8txiGmpNq+aExYEGuO5vyO92scCnvK3/LhErrSVJwoXht/RtgOwtfmJlKoXilENjdSyQKxDKt2jUKl4zHTfEvoYThDwYvhfHLB7DGitWamz521GBUFCioI3vsqW4nPkjdIQUjxikA7mBwuOkAZr1kxnnVMkgseYxDdl5h9Qp1XgV5RJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiVOM2wvJgotqJ6Cf8lqX7Nxbez9ynmEHXuSdlFn29Q=;
 b=Uo357W4dqZk1XaDVtAWMdofP4nMJI09SRQa88SNMA8/2wYIJvnWqBAYcvGyXfAqu6uyeWr9ZXI8reuyk6iNBD5F2uk4o3obSRAHNkG6JEmuFgXA1n+PjjG/+jUFdwZdQMnEGK4Qcj0l6JO3vqGf2EXyYJR/XjtLOZf3gHX1Y/RE=
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:00:44 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::ed) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 11:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:41 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:34 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [v4 08/11] drm/amdgpu/userq: add callback for reset
Date: Wed, 16 Jul 2025 18:59:28 +0800
Message-ID: <20250716110011.1670654-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c91be9-dbe4-4cfc-2b7a-08ddc4580271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE4vSjJpbEp4WWF1QUZEUEdGMWllQ2NFeFFydDgrd3JaUFNkS05VYTVHS1c4?=
 =?utf-8?B?R2EwdXptZ3ZTVnI5NjNYdXRLU1paV0FoNE9qUjkzVTE2WUVzL09xTGVtdlZF?=
 =?utf-8?B?TjRVSElvWVNJYmFqLzBySzJLSlloNzJuTUkzOG5kNExPb05VRDZxSE5uR1Yr?=
 =?utf-8?B?T0NKRk1RYUYwcXUxSWtyZU13emlYWXN4N3hkRnVGUmhZVE5mcG10aGpjSlZI?=
 =?utf-8?B?YjQ0ZUpYWDUwZkVqRnVDYmNseVhhMkIzT2cxanhVYlJVMlAxa21zeTN6ajlo?=
 =?utf-8?B?bGdOdGFPL3JmODQzN3pRSWxZajJDZWZsUEtqRCtxMlZEaS84QzFJOG15aytj?=
 =?utf-8?B?L0pHVCswaFBTb0RnejdsRXdQN1JZaHRqOGRWWjhOTnF5c1IrSU95OEVZYzY4?=
 =?utf-8?B?dHhaMUdHOCtHS1FCUVB0dXQ3bHo2d2ZkaHl5eVFsT2d1QWZDOFZNODJDci9R?=
 =?utf-8?B?SE1weEorVjN0WG0yVkM5YS9xZm9wU1VZb04yU3l1OE9Ubmtrbmh0Q2FDOWxY?=
 =?utf-8?B?RFZ3VjRtV0E4NzdqcmNHamF5Q1JNZ1pUUUl1N0lzaDlRbFRlOUpFTEVndldj?=
 =?utf-8?B?N0txL01uWWcybFNBTVNCSDBHRE5oS1dwWi9qY05ISnYwM0I2dWV6cmJTb3R1?=
 =?utf-8?B?UVBnYnJVa1JMWGFpWjE1elE0VEtnV3VZaWViR1F6bGx6Q0FCQWwwR1lqYkVF?=
 =?utf-8?B?cTJqTXc4U2ZkSlV3em0rL1YvYUpxZHpFYklMd3gwM0lFcWFSZ0RldDF3ZzN2?=
 =?utf-8?B?bG5iWDNkRFR1VUFwVDNMcU5SQlUrU3FiaHdkNUxzMEk0QXYvcXRTS28xVXZW?=
 =?utf-8?B?NzNxd05nbXpydjMxZ3EzdWJVL3RCK3lSbnQyMnJkS1c3U3c4Mm1Kb0NCb0xU?=
 =?utf-8?B?K0ttNUJuVitEVzVlcDFjeUtqV1B1dE1PdHVXVXBJOW96SHRxWGtvSEtnT240?=
 =?utf-8?B?WjdLRitxV1lBdTB2MUJYWDJwa2h0V0F6TXFHQ3JEWU9VNTlGbXdxTjRlazI4?=
 =?utf-8?B?VGFKMzdiTnhCMWlMcEdsMnlZbS80dlc2S2cwWURzSkd5eGx6OU1wV2ltRVVq?=
 =?utf-8?B?d3hTQ092YWpKaXRXQUhHdm4vanN3WERINUp0L3FFZ1RPcE9OeW9Iek42dEVZ?=
 =?utf-8?B?WUZFMFpRTEEwTHd2TlBqTmNCT1gyYWNJS29hbEFvd3NrbENPZlpLSFJWWHRh?=
 =?utf-8?B?ZENlb1ArMkc1RE93T2g1aTZZZEJyNCtLSG1sRll0RU9kTHdWUGUvTVIzNU9Z?=
 =?utf-8?B?UlR2MU02Sm1yeWI0bS9XcEo1eEZVcjBEZndGY3hkS1o5eFQxWGNwZXI3L1FB?=
 =?utf-8?B?Yktyd1JoTElzWmIxaVo2WXdsbEY0c1UzOGtzb0drTFNKeTg2bVZkTUNlRGF6?=
 =?utf-8?B?OEdBaUMxUHdNVmxBeU54N09QbHFOSEIrQXdpTW9acnA2MFNEekxoUDhQNjdx?=
 =?utf-8?B?K2VWNTVyTXNYdXFOdnkyb1YzK3JkRDRnbnZ1NlM1SjFnUmROK3EraHE1OFhJ?=
 =?utf-8?B?bmlwZk0vQWdmWllLbkRqS0o5clJrKzBZaVJ0L0IwQnFKT3lVMSt4VTZ5a3BU?=
 =?utf-8?B?akh0d2UvUWdkSmVqK3BJT3FYKzFnY2xnenN5TittVXJaekpnamIvN09jamhM?=
 =?utf-8?B?bmJHaGJtTFpGYjRnOEZrVlh3U0VQRzJVTnNOV3FsVU40emdaMW5pak1LSExy?=
 =?utf-8?B?K0FwVDlGN3U3UGUyY0o5KzNjYUcxMWJ1MmRxN3UwQ3hNZTJiVFdjMGdqRTNP?=
 =?utf-8?B?TkNHL0xIdFUvTHI1SHBBdVh6ZTJidkdnLy9rMnV6SGF1dmREb1F0YTVpM081?=
 =?utf-8?B?TWNCUHJlSWdVVFBMU3pkek1lVlhhQWpJdm9oV1pMNDMycFdHL0IzYytOWFNJ?=
 =?utf-8?B?WUc1dElvWFRJRHhUbFJkajdOdkRnVkcvb21tUEF4Ny9FWFpsK2t6OU9DZzAr?=
 =?utf-8?B?bXpDUVFFWDlRcnBGb3dNVjUwWVUySkFiZTJ2OU9uUWRqbEkvYW1UdU5oRll1?=
 =?utf-8?B?dzhMdkpqK1EzcnhIVmxlSzFjOHE0NEE4eVFhNEpTTWdaak43R1FtcE5ocEtV?=
 =?utf-8?Q?nCq0o7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:43.2875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c91be9-dbe4-4cfc-2b7a-08ddc4580271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
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

This is used to reset a queue.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 0d44d7a3b7bc..28bf7857facf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -88,6 +88,8 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

