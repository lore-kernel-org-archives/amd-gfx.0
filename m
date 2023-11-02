Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42BAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 23:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A17710E10A;
	Thu,  2 Nov 2023 23:47:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E837610E10A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 23:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsVgSzrzi3ziJuOB9ug+lxJcB6ZGEdMr0Hms/iaTtbGNN2Gy1fPQhMz5lb2ZHHoA+3azHg7JNtR3Q4foN3GX7L/KLIvPzd9SP6faHsD6d7njcwpXZv4vFDZvrbYeRLQDcfH6U7l+WN9D8wn9oEKuFUUPWCvThV1rVaZfqyFFcbOHEoe8PFhpHXOPkgCWOi+42r+YfnFbslMQDT9zpAPY+TlN+QyzOX26Tf92GKuWEYu+cIH3sy600mJ6XPOwsaJ7H6nw+NMJZitkoZvctaTcU6lZdsDZCJpeHLoJt9ETnXPn6+24mCr3HpcMfGOBtyAIxJGzr3SbfeAjghqiqgrKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+32B6LPRKT2++yVGQvm2mXE7URlemhEMDTs1t5bav2Y=;
 b=iqQNeP1FATIZMGs8h4Cj2qJ/vB5QkCMtTMziBwuHjfBLPlqLGs6wiGKeBidEBYSszIZJqAzbr9KFXB1LpaCvVr9nhCSxMj31/EWoM23mpoLxSwBEtCunXv1ApdOzhi75RtEu/J/GlZWshWY3BALoNfRe6XtPoQnmioYTiATkZIWafi0CWFJrYXOxopEXm2oIJbenWdDC/QGUegs+RrhT59dk3EdnC4uvmAngszJlwL6lIPj83cIOC/I7Wu59+ESWeuUzYLI/ozDgCBCYTizYoGy81AkvRClgXGMnR+MklSHYHPhtCJpBB0R45SzIvrD99B+D70f+fdwK1jE5vkwD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+32B6LPRKT2++yVGQvm2mXE7URlemhEMDTs1t5bav2Y=;
 b=AeM3gyTq5debADWb9dWw60DzZEjnqDVdup4wjTuVeXZCmFGkRo9v9qxP+K9aPq3fJ41O/bLtNxUK8zQS8qW/01cx1NWDpcqlc09i6k6QdVL8LnywBSGBiHwXvewoIb0lJcFoDZXqGacJ6RBiMmjoNEOBrs70TtoIxxHjg9JU3vc=
Received: from SA1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:2ce::21)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.32; Thu, 2 Nov
 2023 23:47:10 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::df) by SA1PR04CA0016.outlook.office365.com
 (2603:10b6:806:2ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Thu, 2 Nov 2023 23:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 23:47:09 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 18:47:09 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable MES to handle doorbell ring on unmapped
 queue
Date: Thu, 2 Nov 2023 19:46:55 -0400
Message-ID: <20231102234655.391451-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: f6db085c-f3b9-4184-a3f7-08dbdbfe07a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdRRtwQEOAbd6r5PBUdbfcEBDJFnc7EDFr0T1TElhH540bvuqyTJEsTLTKrBPqz59q1yz9wq63B6W0DfAzpyDUVrhjHQnuvmLFkvpjK47T7FA8XrwX4XvlwKA7CpYzccRe2xHLkByJmB1+3jyRfYIMuS16oFBT6kUeskXaZLN+8xcZIRzzByyWDzq7jK5TYs8mrvFe1sAB+1DadNNb1+AswLoL1aZBdfabXzURsDwP3fO1xEDsjNpUpkkpsC39wMtpFim3n5Oo/04ZbMGNTWyVd0Zc1uHrUo+Ln7vEiQyiqegHs7qrLtIX9lHPeCkE6tjIdCXODYNVZMkY7iQtnEjz2h7KC0vmhJJVs+8qRMeL5fNB8mbfdV/utfL+E9O+gfBUbLd7y1qZ+QrX5coLJnTStjDSR9NwJabLPz2dR9+iYhPVbwlKQftT15B7SS3Tk5C0q1/Yk9sExcQV9ATvciWq/d9MAUxBv36X/brx6T16UErpjKlQHjEq+CfgVO25Xd7bIDOnW80UJ5SHiwqMD0v9oVFGWDFus68FgRr8I/+0r7fHzv/fPD1UiLdjXVRnTVKH+sNJEM4Shd04HYpY/aZUchOfgt5TvaYn8RUDXE9/lOKvGG9dkDw8OSeSv7OvG6fXmrlDyqfU2Qcgcenodg5+mqrAqdSaTXwsEQPgQFZ32pylUgr69Arxt/C9xFgT71Yditurv2CIicJ3/RxaEqGKMW6k6m0dYfeP9mWSrOM2uJnCwhDFZi14EN1L5AM1fVqHlvuQ6c/xXLtp3vm+onsRZuoh1fhMuOZ5pKC2KeFhU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(41300700001)(81166007)(86362001)(40480700001)(47076005)(6916009)(316002)(478600001)(26005)(356005)(4326008)(70206006)(70586007)(5660300002)(7696005)(16526019)(2616005)(6666004)(426003)(8676002)(8936002)(1076003)(336012)(2906002)(36756003)(36860700001)(82740400003)(40460700003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 23:47:09.8576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6db085c-f3b9-4184-a3f7-08dbdbfe07a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On navi4x and up, HW can monitor up to 2048 doorbells that not be
mapped currently and trigger the interrupt to MES when these unmapped
doorbell been ringed.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ac41c649caa0..eac34ed1a504 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -455,6 +455,27 @@ static void mes_v12_0_init_aggregated_doorbell(struct amdgpu_mes *mes)
 	WREG32_SOC15(GC, 0, regCP_HQD_GFX_CONTROL, data);
 }
 
+
+static void mes_v12_0_enable_unmapped_doorbell_handling(
+		struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t data = RREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL);
+
+	/*
+	 * The default PROC_LSB settng is 0xc which means doorbell
+	 * addr[16:12] gives the doorbell page number. For kfd, each
+	 * process will use 2 pages of doorbell, we need to change the
+	 * setting to 0xd
+	 */
+	data &= ~CP_UNMAPPED_DOORBELL__PROC_LSB_MASK;
+	data |= 0xd <<  CP_UNMAPPED_DOORBELL__PROC_LSB__SHIFT;
+
+	data |= (enable ? 1 : 0) << CP_UNMAPPED_DOORBELL__ENABLE__SHIFT;
+
+	WREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL, data);
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -1235,6 +1256,9 @@ static int mes_v12_0_hw_init(void *handle)
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
+	/* Enable the MES to handle doorbell ring on unmapped queue */
+	mes_v12_0_enable_unmapped_doorbell_handling(&adev->mes, true);
+
 	r = mes_v12_0_query_sched_status(&adev->mes);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
-- 
2.34.1

