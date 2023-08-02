Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F5C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E05E10E4AA;
	Wed,  2 Aug 2023 06:52:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DE910E4AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiflMrbr7qe8j2fnh1WoX8yvWlQ6n7UJ1jF9dW8tb58MZyXE1z2PAPRsffpttbY3E3L3XxJmzyl4aYheUpuqdKoyjrmQVgXXKCCqj/9yrgPNpZsfqRwu+tr8ypK8hPfc5KSO5KizUA1FMeooWbIrKuqtMGaAlaTjcVv9slFwl+5odAFGH/L9EgzdohPg0si+7PZwXrcNyTJrophsV2+q6GYG4A89mc1JzFUmXtXFHqMxPgo9NW3J5p02fqcWeLAIaeeza4vi3NcML0RiY4XQakJwwv16Gm5kmlzTRgPpD+8jpKQUuSj4Ma3eSAs8gZr/M/WsGvqUrmwYxLyilEjVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASoi0pTlsNsxwMFzh5sFqen6EqqkMQnICALhv1pRo+M=;
 b=FOL1WEuHKDQChaRKei23o4YgB47tAACTEi+ZjTzTVv16M38io8RxKgYsaR0zRAFSPfyp0S1tMQty33FQucDAa74jKgOyp1RPFba1hztayz3mWBuZ7HhfVB3ASHcWXeHWPUay8iMq21fYDzHZLOEE0MDe+hvvPcmJfUb0z5JCi7FrqZ1UDLShXnbjWVTX/c080R9DspbYiu+ntxcPoa8On2v9gh4fBH8V3oRleEuvdCtM4zEWGatoSmOn4T41VpNsryVZzoDCGbuFk6prVn941DKF1PmmDXqUZ7r4X5Oj4OE3gEJar7vq4en+Odbr5sBAuIoyRRPUuFAWLv3aWoeQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASoi0pTlsNsxwMFzh5sFqen6EqqkMQnICALhv1pRo+M=;
 b=5EpyqrGsLkJYrty6SakvHW8wc0Gp0Mo76Gv5xAWbWVB3bQsiQFbtt8xk2YziNEDVAGI0yUwfta8DClHGkgw/SeQQTPWWOoIGS1vrfB+xRoBzlz4G1pO0zD/A6BkjMqYNV/wHLVOM+9J/d4R4qUeVditLTtYzsZVoTjSDC1beoIc=
Received: from DS7PR03CA0339.namprd03.prod.outlook.com (2603:10b6:8:55::18) by
 DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19; Wed, 2 Aug 2023 06:52:14 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::b9) by DS7PR03CA0339.outlook.office365.com
 (2603:10b6:8:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Wed, 2 Aug 2023 06:52:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:13 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:05 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: Enable DPIA trace with DC debug mask
Date: Wed, 2 Aug 2023 14:51:13 +0800
Message-ID: <20230802065132.3129932-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DM6PR12MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b266c40-b975-4924-243c-08db93250103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lK07JwEiIzdZM/3powklkdGDSKXltxbX1mpFcqzqmnOAZh1Yba9KeJi49raeGvAQogpljx7i7CwEteBWOweYy36m0cGHDtpw7wQfMyOpEyPjcT0cc3jciY93THVeJy1NpfX8UjisBKr8ZE6qP46AznjYaE9dHCeWBNJCcvdox8a5BGcdCgrzckCGNw/CLv1wks46zFdjlENxT4AJuiqYPc2icVjN2RwdOOSRP6Hy3jVmaG1ZZ3YdrNn+ULOg2MA2WRm5xA3urLZ37esQPqcXfjGuibvmuSVCAjTW8Fi0eEues529YmJ3YzQwBI4e+UHiz+o9ryNYDuyuqHlFbq/iN0fCvvpRYaC27wi4q+KiB9Xr69ZmsvwslHOT8O9pjVNvoYeaHBqhpC3Ux4WDyYWcwiRFzZkaeZB2dLp1qBCBeQXFj6h3be7nMFGHqiUj80QnxD6+m0bTH61KOZwepgltkUN3pNGiaGGxZSLBbqNYfU2zoYUxktgJg+yaO5oImGJrfYTOae/L4UhZcqTpM7q8NPzo4NYBSXBHH5p4wygLNquM73yMivaFvrmJpf0kVJ0n0HyWyzckM1xl1NkoXZzwj7HnaWzjxUYP3jq6Xm+HYsBKwU/2KzLUGmzpFpfzKo/IxDkQmtQ7pixpkXE8KnREBuaDb0t7NkKFLXWzNQSBRTXrxlLTNTmr1XizOdV9NRHdkQGtywTKgbB9fNDua97EDji9h2dJcbkYeCP3B5se6gXHEH7ccfJBHpdHm5s9/ELwtCschUoO+gy0zjt7ORmcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(4326008)(6916009)(40460700003)(70206006)(70586007)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(478600001)(36756003)(6666004)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:14.2488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b266c40-b975-4924-243c-08db93250103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
DPIA traces from DMUB is not enabled by default, which is
less convenient to debug DPIA related issues because we have
to resort to other means to enable DPIA trace.

[How]
Reuse existing DC debug mask to enable DPIA trace log from
kernel command line. This makes debugging DPIA issues easier
especially when system power state (suspend/reboot) is involved.

To turn on DPIA trace, simply add "amdgpu.dcdebugmask=0x80" to
kernel command line.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32fb551862b0..d21241af1aa5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1822,9 +1822,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	 * It is expected that DMUB will resend any pending notifications at this point, for
 	 * example HPD from DPIA.
 	 */
-	if (dc_is_dmub_outbox_supported(adev->dm.dc))
+	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		dc_enable_dmub_outbox(adev->dm.dc);
 
+		/* DPIA trace goes to dmesg logs only if outbox is enabled */
+		if (amdgpu_dc_debug_mask & DC_ENABLE_DPIA_TRACE)
+			dc_dmub_srv_enable_dpia_trace(adev->dm.dc);
+	}
+
 	if (amdgpu_dm_initialize_drm_device(adev)) {
 		DRM_ERROR(
 		"amdgpu: failed to initialize sw for display support.\n");
-- 
2.25.1

