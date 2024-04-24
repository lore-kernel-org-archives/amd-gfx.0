Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E54AC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 10:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7AA10E8DE;
	Wed, 24 Apr 2024 10:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W6omMTlf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C1010E8DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 10:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuJCKKGw2+j19TtHaMIupE/WYwBlbuT4aMyP4j89UDIWZmU65xwoe+wS+jij7liXx7sbuLft7Cch8SRNOAAeDOnQb0mlLRb3HDuo/rtcTeHkapHBw1cVrX4dPLwVsTJDLL4Sgqdj7sC+81h09G5bFVzkqwlj7BdHfpiT03QI2HFnC0JRzcKw8yYOKK7YXo2JfHH58AWbk2sG6J1Z3yoSOxQr483OddJv1f26tm2Q9OK/quwDftpr36GOQ64hUw7bHgf2udHqW0zetJEWeTZuFElWsDQAxfyYrXpy+BHy5fnlQFPPcJ33OE2ESfTbJKxmD0XSohIc6Hsic54n+ePOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtXVxgCKUVsn2V1fyQdyo4WVrJStUpCOjOv+ktAQU3U=;
 b=l04j4eyh5K2PhM67oSf9J2f5PCzWzLWdPFWDpZBD3Wcd0QEES9OULh0ZAB2zaiZPL29GjgoKR7QuvuQ98a4OHlLK06RFsyn2UywrOef0O/b+UdLKG68YUFYQUN8jeewue4kCekAPDWRZtXwtD3mj78wdeRJh3KnPpAG7bzj0oKIlEnQTAGRQFhPmJjwUnGd3VXmMZURszSEzJ3XKoz1fKvhagxGT9I0W0o6D9u8NyVJtICuWKZ1TZ22ruFXmW1XLjjXfhEn3Q3dM7JIkzfHhlZxCrMkGyi3qLuNDtn3zdJyVRkZ7vuWfoA7aWORSpDglIvAkFC0fmLE1viXNlNWI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtXVxgCKUVsn2V1fyQdyo4WVrJStUpCOjOv+ktAQU3U=;
 b=W6omMTlfIB90rTc+b841ZPWN9usmZO50bVQfpKavog74quMVHi+M62+K/vfxcQL8+7aRKk4DmFbDHK7cQQkrG/7GfoYO8ReuMXHfV1GtndL03okJnHmPXg7fkqW8Ns/Z1ZxCumSQRFxdgbcWMVlUYg9KflRtEylf00ZkMqusMyA=
Received: from MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 10:04:01 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::d6) by MN2PR14CA0023.outlook.office365.com
 (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 10:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 10:04:01 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 05:03:59 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Initialize timestamp for some legacy SOCs
Date: Wed, 24 Apr 2024 18:03:42 +0800
Message-ID: <20240424100343.608218-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424100343.608218-1-Jun.Ma2@amd.com>
References: <20240424100343.608218-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f70a45-f1f3-4057-e991-08dc6445dda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUxJOFN5ZWpuUnN1RjMrTmJiUkN5NjhsT2NCYWd4TzhraENYZWk2RzJwZENk?=
 =?utf-8?B?MXdjdGZodWdCM3Q2RVpBUkE3dFhaU2p3VEhBUmw2dGhtU1k5MnNOZEJDSnNy?=
 =?utf-8?B?Skh4MzBRTm1QYmFMY1lZdzVwMVBPZ3ppOWdLVFZQZG1aTVBSZUJKakFEMU53?=
 =?utf-8?B?S2ZjRFRaMmRSZXpIRGpnN2I3WEVuNEdYd01hdFlRUlp1MTljeXV6bmhUbW94?=
 =?utf-8?B?czJSa0U2ZEFnb0t2N2xrRnpiSVRqUGRidys3Vi9leWJCUnNYVUN3ZkhPUHNk?=
 =?utf-8?B?dHdCaW1qcVBmNjZhTDJQQ2ROS2xjeHUyU0pHS2Z4WEZwamFLMm9oU2E2azEx?=
 =?utf-8?B?bGZrRWxMc2FTV2FmL1hPWmFoWk9zb2F2Tjc5dnd1S3R2NVFMRmdkREhnUnBY?=
 =?utf-8?B?Ni9SWStUQUtqVGU5QTYwL3BtMFRhcWhMeEpKZHl2QUJsREViaVlwUFJlN1o5?=
 =?utf-8?B?WlVJYTdKM1pFOXZVSENUUEh2ajgrUTNjaEt2VzBKSEFjZ1BDVDl1Sk9id1dI?=
 =?utf-8?B?c0p0bW1EK3BkRjc1S2orcFRoM2crMEdQdG9KZ1NodXkrSmZRa3J2REp5enl0?=
 =?utf-8?B?YUhMd3hzR0pFMHkyMTdlTVlBa3d2WG5pSDN1cTczeWlyQmpiNzJQaGtLWG9F?=
 =?utf-8?B?SEh3d0FWd0kvQ0lDWWdZODFpL3JGYUY5d05NNnhySkxlWlZtT0lRd2VvSTdz?=
 =?utf-8?B?R08rd1duWTU4aEl6Y0J0OEJpY05EOG1RZ0lOa0V2cE90R2NSNEZZaEFKeith?=
 =?utf-8?B?enNNS1B3a2Y2V3FudkVha2R4K3FjeXZpN2h1YmhuNnQ4czVlQjM3ZERCMk0r?=
 =?utf-8?B?K3ZPaGtBWEQ0VnRCQXlIdWh2UTJQbGRaRUVOcitzZUd2bllEVGkwRnRCMXNz?=
 =?utf-8?B?bDVSZjdVSlJ5TnFSSW1mZ0hCMm1OZ3RleWVIZ3c4MHQwNlM1OGRpWnVUbGZD?=
 =?utf-8?B?R3dPS2ttQitvVVNXdXdaRGhBN0R6djVYbWE4RkZOcVBYbE0wSGFDNFVFN3ZS?=
 =?utf-8?B?dHh2dExiOFFiSzd5RVhwRCtwVW95ZTZMSkppR0VmODZVZzZjOHZUSUNNcUFB?=
 =?utf-8?B?SG9RMGY3cDlwV2FLVlREU1NlMFJjc0RTZUFPUzJZTGNYUHNlbDQvKythcCt0?=
 =?utf-8?B?R0lIajlyUm9aQkt3SDRYNmIycWdLMHFlUW05aW91djZpVE8xeVJiU1BzVTJM?=
 =?utf-8?B?emdtMEt4OWo1OG01dVB3MTRjdzRCR0tnS0hqVTQwS2sxZVd3Vm1mM2lNbnRo?=
 =?utf-8?B?SHJvZzB0T2lEY1lhckltQk9JRVFQOXZMbTFnVzZsbE1BU3pMb1pORVN5SGZh?=
 =?utf-8?B?Sjl1TTVac2Nnd2paWFNPa0ZJQjZ6bDVqYjdDMEFoT1dtNUtPZUNuYjZoZGta?=
 =?utf-8?B?amZuelBORUx3V0hWbm0rZHNZQ0tBZ0JYdk1zYXNaSEswNEg4Z1Rjem1rM0Zi?=
 =?utf-8?B?RGZweCtYN3ArR013VWZvKzkzVndROEp1aVVnNC9BOC9xbkVCOXhxS3ZhVWtX?=
 =?utf-8?B?WWVKUkhpTFN1K1J2NTN5U3plRmVyZ1Z2NHEwczVrbU9YL0RDNnNMS09mUDdU?=
 =?utf-8?B?M2IyOEhzaXVvTmtPei9kVzFTZlJtU0Q5cS9Gc2JHcFRXL3diZDdWd2w5Z1lK?=
 =?utf-8?B?RlZIWEdqMU1CU3NSZExJcCtFL2FOUlRjdmtVTnFYMGhPNTF3elhqb3pWZGpq?=
 =?utf-8?B?bzNtcmxCTEZOWk1udkFhS01CVTQvUE0vaGlkV3laT2hLRGJ0L05oWExKUUx2?=
 =?utf-8?B?MVphNEE5UVlKa1haeWFqS3hDd2JwNUJmMWNlMlZIK0dvblV4dkIrclMyRlBZ?=
 =?utf-8?B?Y1lEQXptcndEYmRiWjNVWWF4S2piV2J3bVJ1RGRxN2h5bHFFZ3ZkMUZGejhZ?=
 =?utf-8?Q?Cpq/Vgs4qpH5E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:04:01.3326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f70a45-f1f3-4057-e991-08dc6445dda3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

Initialize the interrupt timestamp for some legacy SOCs
to fix the coverity issue "Uninitialized scalar variable"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 7e6d09730e6d..665c63f55278 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -445,6 +445,14 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 
 	entry.ih = ih;
 	entry.iv_entry = (const uint32_t *)&ih->ring[ring_index];
+
+	/*
+	 * timestamp is not supported on some legacy SOCs (cik, cz, iceland,
+	 * si and tonga), so initialize timestamp and timestamp_src to 0
+	 */
+	entry.timestamp = 0;
+	entry.timestamp_src = 0;
+
 	amdgpu_ih_decode_iv(adev, &entry);
 
 	trace_amdgpu_iv(ih - &adev->irq.ih, &entry);
-- 
2.34.1

