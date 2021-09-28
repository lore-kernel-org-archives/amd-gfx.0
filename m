Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C07C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD5A61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AD5A61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1DA6E8BD;
	Tue, 28 Sep 2021 16:44:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD8F6E8BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDr758gb3DI/FKGsxhQDAeoxu4wPa77pDrh1Eo9SDkjh8FCga+zKm8QfeZHRpfElU6BT+3h3GjJsw5XUeT4DTg9nvFs8KoG7qnGA1T4xHGQKdRnEUs6lT/d0JjGm2Ul6XXN/EZCXrhKgNLU/y/kwcOoX+tjQ60f3RqpAKPmySZps54enTnSORFWwqbKIMaSe+/MWWIBrEwh0t7v8jEW7o7Prs01Osiqb9DLs5+aIZi4J4jtHOqBo3buNSGJSge/mDL04j1zMFBH7IvHCezYl1kBWCIxWzCZQvkmEs5BbX9sbjeCtDhbMXSEjAIwmsCtzJXTH2FTI9GwwwcNj+Gb1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UoqJxwXR3ZHORyG2OVEB6zCDnbsKTxiGIPJLECPNZG0=;
 b=nA2x33gBOgztfbkH2WMBhO4Hkg6RGY+6kdLjhYansh3AoL7attwL476No5P13qaJS0kca8fWzaCZpUlabpf1Qcb7NMvdiMbNwrBC3tA3DCB19pMFQTnTCpw7nxcgvV946JC7wgbXO+ZzhpdYlTQjSpMNqYvKWbV5836rdC9kovbG2YgOvIwc1huRNcRY22YizDeI6CjtzxSLzTiD26mY6RcIN3PD9dKx8LQWE2U9zYhT4teoVpWH5QIbUSUTdlK/LhK597T74MP7lj1mzNde5zV6QuDkmf9jCy5Jv0BUegXu/CghiUZETs4tCdTgZOx171Xtfcu6Udgq7yR59dVtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoqJxwXR3ZHORyG2OVEB6zCDnbsKTxiGIPJLECPNZG0=;
 b=qpY5fkPsoRyE/Tl30s+lfzsAu4xWcSecJzPLWAu+gXoUwlFhdLnathZQXX+zIh8aQhrfkAN/KrJk9EOwo14SwyPrSF/1xXN68xa3dI3YK4kLeHOaxsY3FE+ECz6V/vL7qTeOmHMpAl3QOghh4+9QUt8jAx/IRIgVztavUb06q+4=
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:44:49 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::5d) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 30/64] drm/amdgpu: add DCI HWIP
Date: Tue, 28 Sep 2021 12:42:03 -0400
Message-ID: <20210928164237.833132-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4333e3be-1aab-4c7c-370c-08d9829f4953
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063F30289DDC5E1435360A2F7A89@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZC9bxi0wSktEBgZlFQ3gF4h1lryczHjJhXyyvtfcBm47+uL9FXThOe0IhHxgbAY0U0VWPECql04FzuhABt06SGmc+0s4M2GTHLvgfJM2C3J0T/fK8cKd8sU/TNd1fnEL5n49PiQZiqyXgK86/GsLV3P3hVocnRxyIQfH1F8tBOPvixhXjPyuXfX0Ml6FSCWRVpmIFeoHsvAjqxlYt0M4x2Gu6ilb0brJbfTRSPeVkED9UaMhZiPPxMUN36GswUdfKnRqpx7FW0j5c85ymNAQQDMWbkE/uxR5jrLS9BLfUojkgijKrv4E5tPP3O1wc0Vj6aAb72KV2SY3qEMqcxyqZ6iuxL83AqBysBvaK+GGeMxZoLcKbLcZNQU65/3YUsY1lk2RBSQC3VZlNHc8qCFRvRA0ykj5ZlN9PTN7gCuWqtpNS7ECx3wGi8WAzekwtlukF6PWUFwXKwpyAhjGcVoLsy4g1ZOe2yGNa83VKVvbAoTn3243mTeuW6MOEwHXqZtWUdjX6n4eOSZqKaBc/eKRfjOWvjQ+/91t2gWAhS3mqLjahlmjpMeYbCdhUTDq4XWdJMaaMiTe46WHgLQ4mLYz9Qe/eGqgl0K9ENUv77vUZMcZcWYlWz5hBi7HZD7Q3z/AHy3S4d1nDpJw9V71B2KSd+CcQY4tawtafXs6O7vSHr5l+hG2a3jb9maPmAMHw95QpeUUNItFv5LtmmtD6xpAjI5RrDcQhskg80kemw5b60=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(26005)(83380400001)(16526019)(186003)(8676002)(8936002)(1076003)(47076005)(66574015)(70586007)(6666004)(70206006)(82310400003)(5660300002)(6916009)(336012)(54906003)(7696005)(86362001)(36756003)(356005)(426003)(2616005)(4326008)(316002)(36860700001)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:49.0387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4333e3be-1aab-4c7c-370c-08d9829f4953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

So we can track grab the appropriate DCE info out of the
IP discovery table.  This is a separare IP from DCN.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8df4be702870..815db33190ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -756,6 +756,7 @@ enum amd_hw_ip_block_type {
 	UMC_HWIP,
 	RSMU_HWIP,
 	XGMI_HWIP,
+	DCI_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0f8e12e7bf5e..c67edba56490 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -149,6 +149,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[CLK_HWIP]	= CLKA_HWID,
 	[UMC_HWIP]	= UMC_HWID,
 	[XGMI_HWIP]	= XGMI_HWID,
+	[DCI_HWIP]	= DCI_HWID,
 };
 
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
-- 
2.31.1

