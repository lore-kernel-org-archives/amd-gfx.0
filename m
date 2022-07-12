Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEB7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 06:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3974D113307;
	Tue, 12 Jul 2022 06:38:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FE5112671
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 06:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEAOQYdAKaQ2Go03HBrGGdX/wh8dgWei0Wek3XUCowynxoxrE9k8BHSWvxxy0q28IGNrgPV4wSf7iMVcF244tS/q9V2DzfdAm59maMeRmNnG2p56bCNuYrhpTeot1MEvysnNX2ILtd+d4sovbRNfjfnLUw6RBHE5iJV9a8PdlGQwE2PzNTiWRYKnFW3RMK4OLb/bfwkzrnYBL6LtP+TX+cn/vZnKTHG5UKACnrerOSqW54D3C8j/A7Ki1o4wR6keLVxQ+fuKMLHmnLq34n91WqwcAshtvSxQbqNQq1vlR2TLs5i7Gz0dcog9SICwy64yN1FMI6wWbOWiyVGMIdU1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H38tn/hXLa1muX7UmzCdgYHpIsWPut6QmwlE0fskKa8=;
 b=cdONKaLXMzewHYG+PMqNY8d62uu7KqJsuE4TPg1n4uOWdl5YzWXkfX7P1EikoZ4fmz6lsu/CW7ainmsOCsxpgkRppUxsFYPIpFgLofubpf4Ig86gXovHWRFFv3Sd43qO42D1YUtLMrg+U2MBmazRgpnoeYuxym5yREL4SR3VOZeAaai03Gfvjy/vDig63tfbn3Ug+cI8iKETAzt1N7BmYB/QgXeNrEJf4tMRDT38z9YvqWpOXTMgI6XlQ5NbMepNlcQP5cj0Z052VIqxWFhAQxYVN2OP1wSBvpn8r1mdtkjyLoBNqyYOnoHl2oDpFRMDeaUWUKXOj+nq8HM+WrmVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H38tn/hXLa1muX7UmzCdgYHpIsWPut6QmwlE0fskKa8=;
 b=npg8WkxMWrLfTKrtONEs/2N3L7lXo0+RqO/eqAElijjEx7RlXsl0c5DW7zlg1ONX09k1YUXksPlVdpHcV6L66G0R/HSJdodenIIH0jnIy/Lq/rEfwmuHrPajXsCO8qJ2xupkGjdZz1cXCZZen+lQthRanFfOSJUdrDc8eAjharg=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:38:16 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e0) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 06:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 06:38:16 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 01:38:13 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case (v2)
Date: Tue, 12 Jul 2022 14:38:00 +0800
Message-ID: <20220712063800.28090-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c492a31-c25e-4716-a160-08da63d11a15
X-MS-TrafficTypeDiagnostic: DM6PR12MB5566:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX2WSx7DXX2qXJMifkdvXAv79kkbYH6B37m5jz1gs9euYlqttEyYug4+1OzUSD4/YgVVLS3qDhcFdqbw6KwEq4QyDH4mwe6udgttJOwd0nSzCHJMWBJX6r7Dnot7UWcL5ePhePej0kdicPre1XR6O8VHvQyCRLIkVjoJLJ1NKXc9BBnn6z4prCc2gNZHmqtyrXC+1SQrw6RolAPpn64a4UkvuubpQwHosY9Atr4ThNpiQ61+UC6AUcHr7Ez1N4U2+WMYUg7BeYr3apJk5xaRDSIiuakSHhNcyznpgg+rHD0KjlMwvA2JIoNeAUt+dT/39zfdhJ7wanlCVeq/Jmj86YlRfxu9t4dMRMjugx6HDHR2STQwq0MoRiokYTb1Dp++BHMcCtV0rFMAVEhJ6SrE8HUAz5gOel6joSyceOFeVcIrVicsTgG1QORmwDLIZmME4iFMDrPsL5JFOAHrerUBaWzmct6irxqc4DZRTmn0sKbF+KbaiP6y/KH2FxPOEMQrUC7JlXkGUS1eIecNVdGCVTsvP0XscWVUUq5IFz5YVxlKIX0RALpwXOGw8GvA8mllac/g4BfL9jvhQhD4hs8lYGcSYDhGkV8TMqMo26iBXPyQwuyvauFAh/W5CTAuT2By978YwVhFOcGxbNk2PYnHN8qrq2SJq2C8nE9Gy2yAQytQBPEsI2Y/4Uvq74EeAoD4ic0csogVcCYRuk10ndtLr2QWjqFLjIrXWr8LXTA/EKsCFv+5q2iXhjtNbRGG+9/h8GH7SHXT+ekfcrhkBP6o+Gv4F6pYeXR6rZ7iOI5R48eSksO4h+XKj3m+vycRtd6XVuEFLRndWKr2dSHsHhigbEQa/cyR0eIqKRzNVcEdijQwZdBae8h9N/t5KjZcGFtp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(40470700004)(46966006)(81166007)(186003)(1076003)(8936002)(5660300002)(8676002)(4326008)(6636002)(16526019)(82740400003)(70206006)(70586007)(316002)(7696005)(2616005)(41300700001)(6666004)(86362001)(26005)(426003)(47076005)(2906002)(478600001)(36860700001)(336012)(36756003)(40480700001)(82310400005)(40460700003)(356005)(110136005)(44832011)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:38:16.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c492a31-c25e-4716-a160-08da63d11a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU is always alive, so it's fine to skip SMU FW reloading
when runpm resumed from BACO, this can avoid some race issues
when resuming SMU FW.

v2: Exclude boco case if an ASIC supports both boco and baco

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88b..de59dc051340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2348,6 +2348,14 @@ static int psp_load_smu_fw(struct psp_context *psp)
 			&adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 	struct amdgpu_ras *ras = psp->ras_context.ras;
 
+	/* Skip SMU FW reloading in case of using BACO for runpm only,
+	 * as SMU is always alive.
+	 */
+	if (adev->in_runpm &&
+	    !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
+	    amdgpu_device_supports_baco(adev_to_drm(adev)))
+		return 0;
+
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-- 
2.17.1

