Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9E4CCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AA110E936;
	Thu, 23 Oct 2025 16:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Rq55RNa";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F7510E936
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3GCA+LSuQL++T3ruFJLSUNDSKAFh621nUh8XnjzY/lSxetekFKXjliWlXh7Q+JP2wrpWs5X4/Staghp66qkp6OFVPVwYgM7usgiFrKqQuuq1DhqkQ0ihQYYdV7x24Z00HZNRizE3zRR4lBLwD6fcn3C/P2t0JCiilB0hd0Ud+zumlQNjze6LBxkmXScyQyTzyIIs/Zacvw5JlHrL3gS4iu3wWEYQyrm5yKy4Qk8+JAmt1yd5gAOMJ5FuNsZ2Him6FLRKBgEHdsA0XHQNqLOOZr+lf9130Q2pKYzESUUP2tvqWmEUlfzEJvRVJ2qOEd7wT5k3CAXJw9gaNA1d1Babg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycZChZ4KnfjZPHhTgdFE8HqZ6SjKOcq6E+2QQVkQ8mA=;
 b=ojp3yjO4hK6pPIVA3yNHf/SD5Df7mv5ACiV+dObA5aSj0giYMQIgR5BWFx15zofWMCwiSmU2O1lVLWElklhuQsn96or78Jt/yfPCy23B3McwsGljoxhuDmR0mu4xaZhfmz48MQ2+mGGTUVNdEx4JGxVmSqqorCTjDmK7jmCgcAos+O2bGDNEmZbWbCW9zOIEhwBBuCJxuA7tE6LT6XwuP74nr921EZKz7S0EMB4l5nArIwrFB24im5Jate++EhKWZPgQT/BjZ6x2xhzyC9xjy20YNyzvCW2SAA5LycOX69tDhIHu85wqQDfiRXY9zW/j4g5d0XjbXoEpCjACvOhi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycZChZ4KnfjZPHhTgdFE8HqZ6SjKOcq6E+2QQVkQ8mA=;
 b=5Rq55RNa1qhNcr7Dmq0VdKvXNkL7wIW0KyY9qH6IQV1s0SfI020No8gHz07iIvBnk6as5+hRExXDCvIycdVHK/5fK/gofOPWCBc/3ccmSWHe++ZBLdexLI9utt8z5UEskVyil8losLJzKXzZn+IORVjV2JzH8b2eNVSF5HoHYns=
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:52:58 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::f8) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 16:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 16:52:58 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 09:52:54 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/2] drm/amd: Reset the GPU if pmops failed
Date: Thu, 23 Oct 2025 11:52:40 -0500
Message-ID: <20251023165243.317153-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023165243.317153-1-mario.limonciello@amd.com>
References: <20251023165243.317153-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a73c64c-8c4e-4f6c-90b3-08de12549efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDRmVUwyeVkxdXZTRXpvQ2lHNWZGbUN1MDkwaUcvaUFhbmxlamY2aUJPbm9u?=
 =?utf-8?B?OXdCd0Nva1QycVM5VHFvVGtpb1lsdm9JZW8vWDhiNTYzdnlrL0M3WC9TdllY?=
 =?utf-8?B?d05VaDdEOFUvdERvdDVIakRXalZQWWx5cG54SWQwMXlVY045SVA0aVVVWnJS?=
 =?utf-8?B?RFd4RHJncEMvMVJ0Q2NnTldkeFVzNlFJejBDMFRXVHJlaG1rUmFxd1REZFJD?=
 =?utf-8?B?SUQxNlAzbGhZTjZLeit4eHBDaVdtNGFWVTE4NlJ4WEpNdEFiNTVWUHZIVVZG?=
 =?utf-8?B?YjM3YTl1ak1ZWm5LeW53SE5ncVU0SmlJaFpOV1liZ0lhU0ZJd0g1T2NQajJX?=
 =?utf-8?B?T3N5eUJnWk9semJhRGNyQml5aE84KzQrY2NYNUxWWFFXcjloQkRGU01KTHZU?=
 =?utf-8?B?Tk5PaFR4R3BrbWRraEVxS01GRkVKMy9KWVlCWko1aVYzNDZUV0F6MVdPUFpn?=
 =?utf-8?B?bkxxQVBtaUxMUHZ3ZGRFaVdMRFRhNEhqYnFBME5VanI1QThwb3ROTFZNeW5M?=
 =?utf-8?B?VGxCd2VhV3dmTDM1N0x1VzRuMWYzSEwxTHJlMm9VSEtwT00zWEFqZnRoWlVU?=
 =?utf-8?B?eldMd1ZqeWZLWHE5aHZxQUdxSEU5WXdpcUtnSWJ2YVVWWjN1Q3BETGpaWFZw?=
 =?utf-8?B?dGxHSEtmaTZYaVFUVE5vMllXMzh6ZmlFVHE4OHExdUZhLzJrTTRvT0wrOWtK?=
 =?utf-8?B?bkphakxsd3ZYOHlqV0cwdStwWGFVYWJZd1hvK0Z4RVZITEpRampUK0ZXL2lK?=
 =?utf-8?B?MFlQRWdkenFCUE9SRjJTUDVzVThpWjMxWmM4anZIcFpUazF5K0taZUpRREZq?=
 =?utf-8?B?RWlReGlzd2Q5WGptVUZudFA0WFBXSjFlV25MTkNocGNjZHpzSnBlMEpzSDlQ?=
 =?utf-8?B?clFSUHlyYXBOQ3VuR3pmOGVUZS9qUFpNclNSMWJLN3ZwOSs1anorb0UyVEV6?=
 =?utf-8?B?R0tDTUNRNEhWM3V1WFNTQWNwNWF5dlBFZ2d2NFBaOC9Fd3BGSnYrUHJvZ1p6?=
 =?utf-8?B?VWYzVEJaNloyYk9QNDhpQ2VEK1EyQlc4VG5nWCtjNVl3TnU4Vk04ZGVOVi8x?=
 =?utf-8?B?SFhUaWxYcHFoaFdZUXdBa2VOeGFsRXh5NHUxY0NTb2VhN242aXdRajdNdUZM?=
 =?utf-8?B?ZkkvdGdESzgwY0JTTXYwTU4yNVhzbWYyMmtERW9yL1VFVUJZbGtsZXQzaktW?=
 =?utf-8?B?YTZLNUV1VUtHN1FtcDF2eGpjcFNSMVJYSTBMbFFtM3F4SldlRlYwZGJyZmVD?=
 =?utf-8?B?eFdvK1RGSjl6VVZDUHNSTHdIamx3cEloZnRnaCt0YVE3SXZUTUdaRVNJSDhD?=
 =?utf-8?B?Z3Ruc3RXanlYV1hTeWJuR3V6UENKL3FiTEFwdGdZelJYTXhrczJsMm00MEhM?=
 =?utf-8?B?Z1NtNEJwN3RxYUNGcDVydld3MVVSNy9GMzlyMmg4blRGOXErZWpIbmtzd21n?=
 =?utf-8?B?SFc4cXFsZ1h0dG1jY2lKa0pzN3JKVmhJMHU0MklHSXE0WHJQYkZiai94eXdX?=
 =?utf-8?B?NytGQWNKR1BTbSsyVmsrMHAxSFdJbm8rTkRiR2V6OGhxcjFobzhqTEpnYVlr?=
 =?utf-8?B?MG51Uk5pUWxZSy9kNzI2ZHF2cWhJTCtSMnJoaTVhRnBPWTlycDFTbTRYS3JY?=
 =?utf-8?B?dkhoajVOelFKcmNtbk0vdkFBc1E4Qk1Jc1NRSWhmSVdHZHVHM09ldUpWemE2?=
 =?utf-8?B?MWFtOExNcldGNTJLMFByQUNUL3ROcHdFeUowVXlzNDJTbFgyUmtjeXU3Vzhl?=
 =?utf-8?B?Sk5iNmE4ZGRTSXZuZ1l0aGJpU3BWWm8zeC90aVF6S2ZFQlNPNEExWVBFTUtD?=
 =?utf-8?B?eTVhVGRnQzhCc2x5aDZxQmFZc01Hc3dpLys0Nmkzc3k2eC93VVJwLzY3T04x?=
 =?utf-8?B?N2NWMDJwYUpvM1dvUEdpV3lsUGtnUnJuZFpFMmtsT2hwS0tLeGU5R09mS1dz?=
 =?utf-8?B?K1o4TUNHN2hUVFhCbm10L2dCeU42WUFtQjFoYnFpNVlVR3d0eCtnbjg4aW90?=
 =?utf-8?B?eUxaL0hnZWRuR3JqYWJXdHU2WTFMcGwxemdkbDZhMVM3YzBwRWthTFgyTXZD?=
 =?utf-8?B?TWExS1ZkVXhKNWEwdHBXS0k4NVRyU3QrTWVxRUJ3MDR1ZTBmajVxT3N2QU5m?=
 =?utf-8?Q?Ew3M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:52:58.5693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a73c64c-8c4e-4f6c-90b3-08de12549efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

If the GPU fails to suspend the return code is passed up to the caller
but it's left in an inconsistent state.  This could lead to hangs
if userspace tries to access it.

The last stage of all pmpops calls (success or fail) is the complete()
callback.  If by the time the PM core reaches this state the GPU is still
in suspend something went really wrong, so reset it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a36e15beafeb..e2d598dd462d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2590,6 +2590,17 @@ static int amdgpu_pmops_prepare(struct device *dev)
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	/* sequence failed, use a big 🔨 try to cleanup */
+	if (adev->in_suspend) {
+		adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
+		dev_crit(adev->dev, "pmpops sequence failed, resetting\n");
+		amdgpu_asic_reset(adev);
+		return;
+	}
+
 	amdgpu_device_complete(dev_get_drvdata(dev));
 }
 
-- 
2.51.1

