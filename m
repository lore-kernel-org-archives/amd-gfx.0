Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F72C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D209961184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D209961184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E2F6EA75;
	Tue, 21 Sep 2021 18:08:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19576EA96
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvSdUWcgmMQ5xh0Jc6jAzLH9MSKfSnnaX4lqmqtR7E8X7nxL9bdrP86g46M8T/n23He8S45P6jyERuCTasobtTWOiJLcrUgnbjBbjzy9id+TkRgG0YVhK6j5awmxrXsJVUvdKsISTRHDo45xA7c98T1dlRXp9GqSoyXz8oGOGd1jYe7F0LR3CY5qGbxFI/SBux4O21UqXTnIkFcDkxDtk/48WFwEpZiOmtPU5ADWyMykwtI0tUDbzqi2XsVhX04HPLskltUJrBJCymEopPqwEX+8IVoIOcfl94Jr8ssAJfvwrk8xbkSBQWILgHReACRiyg9ZwRzp9kqjWJyhFgXudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=L9FthaPCtCUoElU+CuUnbASnu74TxoNqATSK9mpVUeI=;
 b=YXaj5x7lY4n6X4GaZgKrY7q85Mj0MKg15X7l2A7JuAOp9f043A/ilu1dZePaAdImZi/km0Gz1pe4QPzBPtWOZ5921ChlBnoknMS1cz9Un13EXGBusasVsEHQnPLzoiLECFOjRN72CkVovvLHLsAbswjkony75urbsWszyx/nL/qnUbaNasKmpAbvIpPyLyT0voN+LUnykcqKAUiaezr3QBuUpFP/jT1MzTzjxHVCz5UGelAY9Jj5ZVuo46jUD3tdOZzmUPuH9dLacyFcL+fPsvu+Jwh0NCDp0rZKkHmnX97oU560mVIZgJbgK6Eb0kWdHoxfPZudpmqg42bMcUMMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9FthaPCtCUoElU+CuUnbASnu74TxoNqATSK9mpVUeI=;
 b=mUbpTEPCPnROlSFZQYl1XxdlIoKGKYGFCOLnjWNislBClTyRbwdc90rWdmSTbvoKekIDAlAfRMY3J4sMEmii1L1FUtVfHiH2WZUz8hOBcAsPD63HOGyzi9zH9TdMrGUmEZZHJ2xAUb8nz7UWTw+xEDxjoJm6xAJ3324xkrOskw0=
Received: from DM3PR12CA0066.namprd12.prod.outlook.com (2603:10b6:0:56::34) by
 BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:08:08 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::84) by DM3PR12CA0066.outlook.office365.com
 (2603:10b6:0:56::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 59/66] drm/amdgpu: add new asic_type for IP discovery
Date: Tue, 21 Sep 2021 14:07:18 -0400
Message-ID: <20210921180725.1985552-60-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e177ea1f-2433-4e60-3809-08d97d2ac43e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2917:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2917F4BE9DE385ADBFE15BEBF7A19@BYAPR12MB2917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K02A8eC6Z8IfBTajJWcbAOfu7uK8ibvSHMuwV2uJjr30Csoy0mRO3OPWBKKsHvXZumNeW/M6262oMb8fC2ox2Nd5neZCEsYOahqXX5zUdTBXfuWddFxxlyatEV0sW/tn/ze6wwsR16i+bkGvTYViLI8rhlZPvW0xoNak45tIYcM/3K0h2pzgW8cVm+smGvL57Z3TUbiPUGnr+8ymAc6zgIUOeeBJBxakvARwJL1M8f3an7nyRX0m3dwkrwJ5tjC7cKE6yLEZk7Hrnj0i2YbmfldsFSZZLcQB7f4ErpE4YyyENogfPwow+4ZzWkynYBUThMcg21fX4O0Gbdn8Ni0BDiXWGxg+RPCELtXAtal30nNfCe2MOgZlSqnMUTBvpEX/tra+3p8F4SIiXqol/PG+8wwW6fZehZNkXRi1zDaGGhz0/61WpB26VWKY9hLj9Enf3ZPDkqZy/76n+9MpO5bCrUy+0hFl8Z9Nfza2BMRvvavdaDd5Y4TElAAKcIIDsZxpRFdWzEGKr+gmDQieiRtlaVdabJxQ3YVVDOEkbNMFrvVvRac1Ov6qcuXvA7IoffQOiItaLZ0YA+d8UfQ5q3UxwotxtHWy/DmNYpFL1iVVLa4PiiZx5krrog0JM5DPE8f9aUoIiEHzRnMr6INMJXva3avaoriJU50VeL9s3605Wliljt5868OYzhOptOjdHBvyTHrfIgznM9ajT8eSZWVj18+8J3qd+UgKoUmDjmMsGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(508600001)(36756003)(16526019)(186003)(47076005)(336012)(426003)(81166007)(82310400003)(2616005)(2906002)(7696005)(70206006)(5660300002)(6666004)(1076003)(356005)(4326008)(86362001)(36860700001)(316002)(8936002)(70586007)(26005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:08.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e177ea1f-2433-4e60-3809-08d97d2ac43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
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

Add a new asic type for asics where we don't have an
explicit entry in the PCI ID list.  We don't need
an asic type for these asics, other than something higher
than the existing ones, so just use this for all new
asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3f2686296f5b..0adb6e0f9f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -125,6 +125,7 @@ const char *amdgpu_asic_name[] = {
 	"DIMGREY_CAVEFISH",
 	"BEIGE_GOBY",
 	"YELLOW_CARP",
+	"IP DISCOVERY",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 0f66a0d9f06d..90b69270f2fa 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -62,6 +62,7 @@ enum amd_asic_type {
 	CHIP_DIMGREY_CAVEFISH,	/* 33 */
 	CHIP_BEIGE_GOBY,	/* 34 */
 	CHIP_YELLOW_CARP,	/* 35 */
+	CHIP_IP_DISCOVERY,	/* 36 */
 	CHIP_LAST,
 };
 
-- 
2.31.1

