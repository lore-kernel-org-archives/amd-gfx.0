Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B789EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 19:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505F410E4C0;
	Wed, 13 Apr 2022 19:31:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD5B10E4C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 19:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsPIaK+66xFeKzFYtIRK0yKgjaCsXO0GlGyT0AMAgy9ODVv0bKFcQxgg1OoYQ5NZthDtDHYOSbB8/UDnkWgIDZzcu1GhozwWP+Rz+jM+8g9Ont7vufUg1uObNCznmPqjXK56WU9jXI5KG0F9rnQVCe9TuFSwO3dBE0atVZxrGCMafjRrMj2Yk2Qcq6BfkkCHYiXlSjQ4KxV2zbus6i+kbw48F7p6oNeIy0aReyjxceekfJVjcLDwAEqwX0t9icPsqgNT7UY6iIcT2xI+Ki0Ir6XtnjI+/UNAMFEtyKnZ9BZqWqUnu7QLUdF13sgth6PyubOt4Cvk7sMJSLddxvJGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82cddmxNPssfw6MqcC36A80HalOkvSinwKnbpSDlfMk=;
 b=NWrkvLkxSHQC4EH3FRG/jVluq3mTMBKTOICMYnHYZE+4hLAwizs02XIFpgDFzg/FyNj77nCvYjFsEzErHJqfe7iX9RIsVGXgj5t6CVDfllr0GkQaBGdSXJlWQpoO0i2ZO5KrwPvU+T2jN2htGHgxQG4rq+/TwPZwUk0MFpnm8Go+AaKwR9VTAUSmyO76g+c8QpioHkTHk8Zn4uMlS5Y/IxkxWpXRSJOwgBcqzCSI2+AjGj8CCHMcpYe07AZlHSExlLftrDsUb4ld+lFwAUE8xbZlkUEPx6zko2haqUmbKFc3ZnhcE+QsoBlY4eOqOf9b47/sOqBYWrUDpvOC6On8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82cddmxNPssfw6MqcC36A80HalOkvSinwKnbpSDlfMk=;
 b=TLfasonTZi2amGhtbRUqyNr0A4hfNmY/Dfo9HhWmtxbVfwpNKLmKBHTvwLmJ7bEZLnkttuNBQRKsLRouPCU6enok1HEQYCPfWR1/Br2nGpxNvXl+fGRaFc66WU9MaZqd7ffCbapLkgSheLcvN9On1qF5WrC3W+oz1IVqiBBepgo=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 19:31:16 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::37) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 19:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 19:31:16 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 14:31:15 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Date: Wed, 13 Apr 2022 15:31:00 -0400
Message-ID: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef05ee7e-8221-41e4-7e79-08da1d842d9f
X-MS-TrafficTypeDiagnostic: DS7PR12MB5911:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5911A690331CB478E546A79FEAEC9@DS7PR12MB5911.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDAC24lEshK8+xDfWJeOW5C7gWtIKvmUcJXSVG2td1wYxxY6hdrmAY1+1IXYB4lF9de7MD+Z8HHWZ3RulU4qvDetblODKV6eqY6TR7X8HRl3gDA3FglQQLNNlTFJpQIFp9WmIqsQdL4X/gTJB9NImHadRFeqZBWunDk8Q3hbUlkumiStLAxTrfd2TFLReV1pin4VO0nVtaJKkNaqnZqdFyoMV9akx/4DYFogj2QyNytKwFPRUiYf07JIUwX7t0Rd+DiSIBK0ZEyx9BOF/2ZZt3/KioBAUcgwp1kFQV7rcVsonBdkLJEcrCLEGRGwk/7mMzWxSU8Jkj15jnyMMAnv8YW38a5gwbjVDExJhYST3KtMvoY5Q3Qw0KceuumCy6hY6OSCPgqj1a91sYw0BeCw3v6NGTz6DMjyjU9bSX7pYJuoULpu4yc3waatwqKPBIhYxas+935D692EscA/By4LPfxRLNiVo+0Mxg/faWFsuVX8ydBFarhxm6DO8WlY5XdX0Z1O1n55U5/pi8Og+2eqx6DJyJ1G+pgFPiHTSTgzDip6zXKap4BmPNTSgOgt6S/1gdRfag5R4hcaUIFvLGCZIFn9yfI2bDs7lLWArNN+IBQzeeMRTovm0ICdzgGBejVvwNjYTSOdLwnqJA+BJSvSVBsxvGLm92g+3roMSoBM0w5GEU5IpJC/DXzUtODVWWKWg9gmgTTjsQJ/I4Obo3RvTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(8936002)(508600001)(2616005)(81166007)(1076003)(40460700003)(2906002)(7696005)(356005)(36860700001)(86362001)(6666004)(5660300002)(44832011)(336012)(186003)(26005)(16526019)(83380400001)(6916009)(70206006)(54906003)(70586007)(8676002)(4326008)(82310400005)(36756003)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 19:31:16.3568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef05ee7e-8221-41e4-7e79-08da1d842d9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, anatoli.antonovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Lock reset domain unconditionally because on resume
we unlock it unconditionally.
This solved mutex deadlock when handling both FATAL
and non FATAL PCI errors one after another.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1cc488a767d8..c65f25e3a0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5531,18 +5531,18 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	adev->pci_channel_state = state;
 
+	/*
+	 * Locking adev->reset_domain->sem will prevent any external access
+	 * to GPU during PCI error recovery
+	 */
+	amdgpu_device_lock_reset_domain(adev->reset_domain);
+	amdgpu_device_set_mp1_state(adev);
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	/* Fatal error, prepare for slot reset */
 	case pci_channel_io_frozen:
-		/*
-		 * Locking adev->reset_domain->sem will prevent any external access
-		 * to GPU during PCI error recovery
-		 */
-		amdgpu_device_lock_reset_domain(adev->reset_domain);
-		amdgpu_device_set_mp1_state(adev);
-
 		/*
 		 * Block any work scheduling as we do for regular GPU reset
 		 * for the duration of the recovery
-- 
2.25.1

