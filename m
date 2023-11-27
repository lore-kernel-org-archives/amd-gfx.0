Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E703C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 18:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BC710E3E9;
	Mon, 27 Nov 2023 18:30:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A57910E3C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 18:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G48Rud8FNQr0fUjQciarlenOPEzav/HCUVKkAW147tXP92PEE8TZ6w2lxrmsodHG8HKpnqDLuNgIjGHBS17AmPzv9Y9i0PU0TVHQM5V2k12c8qiMQQhA1b4K21ygJgFx6nQA2DOau5c1Ni/GLKAxwx7UVDJ6A8LCXGw3gdc/RZid4DChUzza/ZIkj5mCWbIEwEpw8H1Ni1H0Ky4PwwNvnYTea3yfK1D7/iZoIQGtbmMhbFn38eBuNRoqq+JbqQcmF+m75+Lkxxv1Z3g8gYmFpbn5IdzrKrBW8YW9azL1axd+YuaCZ7h0XZ7padp2sfG7v95gNkZrboVv3d3wP1XoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94StRxAv4ttIYuke1WkxxXXAb/LKnEIzery7PSVm5Nk=;
 b=OSV50OmmwveHlr+c0nx8hXvPjlRv2UoeKf/Es6TuQQQfHQ3jXDTYo31pvKp+ezyHy8hbZRGxjB5cluzHV0zfVSx6RMKLWiMV7rMX7OPCb9daWm8NtmSOmr2V6A9V0EAIvQdS8ziOp0K2v9O+PuxmYVWaN82JURBLcoNAvA11fZRoQ3+iSw/QxADe8D3bpciWXqpotj6qaXC6hDHe9F8jmJTmZ7GeIRHj8j0TGCNu0QAWBftuXgGdzOiFnhJhA87/yRn3PXwpaAJUjqEkwqhEbVbXQnszKcf2VM+GbXQMYJ3kVRQy6D2bGxNHmkY14TWdQ5da2NKHO9+lCXScdOAtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94StRxAv4ttIYuke1WkxxXXAb/LKnEIzery7PSVm5Nk=;
 b=1vg0OHm4t7JA1Ta/umjtR1hDNsc9GyfE/AUSAWvxx6TBckl0Rp+pcuDFvnNgfhzCT6WkPBFTMhb52Lzk00qBVCMJ/z8KHfTbnr97Ztnd/trxmvMD777BgJuQtpQaYfbIQvj/OiCBsUccdiA7MT2mqwzA12lL+VYvcaV4VVFmWus=
Received: from DM6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:5:15b::31)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 27 Nov
 2023 18:30:03 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::2d) by DM6PR18CA0018.outlook.office365.com
 (2603:10b6:5:15b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Mon, 27 Nov 2023 18:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 18:30:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 12:30:00 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix uninitialized return value
Date: Mon, 27 Nov 2023 23:59:45 +0530
Message-ID: <20231127182945.1109556-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a899357-5a4c-4dad-4983-08dbef76ded9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3CmwAjbz878BZvbJJ/qIaZ+N3LojGAl2s/jOB1PgRo+JfhFYZU9YMCs0bdZ5OaIn3Ma6PaMMxGlIv+jAT/2IqvA167zc3jDHwRENqZECB4tsWtpXwFA5yhtvLvXaGpygZqpjEc+UCnDEi2wC5nJ3AeIr/NvalD7XnTlvM9RzdaTY+F+zHL2niQ81lgvNobcLGuE9E90oBC80VXpfGPckCr2vXHH0NxzmNCPilFkEXEH5FAZjJylKSombt+knLPdt+I8CzySmkS6Fk13dlJ9GuHNy3mfIWKVPsMHTNgAc/TMu0Fu+ngEsTgONiiXTLZVWMuNnywvLI1kNp1FkothRb14o/TPT/5bD24IL4dvNU7Ij9J63ZjCW3aHQENF31EJdkN5ttrcXm4qfcOYEu6ZYzQIEYopCB216SjfuVpvSyLbyEqHEZxTDNCTBoXz4okf3P3J7T+Q997WhPEtAEd7rbc79wVslKINtKMMSzRkPZfrCbvhPFFO5ZAq3ivBALXs211QViO21PqTUszY0RdgDS+C6lt1UVUKItIB6Ej9l0IxYKqNEDSq3nGGQjU7xBiwZXQlcmoHqSrA7GZ20UkHLSGLZLbHl5RuyjemWA52xPH9JnJNi+7utWuTpJdfvhLyJCBItkcgwBxc5KE1tTdRsKJ8elyjZt/UUSwDTgiGjetTgTpDc1jarzkNt8VHqA3sVujqlInf02QD0J6tB0sR9ohop5ppL6rzN+YJ+DXh+zv8BIM3dj4dyBIrZV12TyTC+zui/tEWAJ/M58DmwJgfJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(4744005)(8676002)(4326008)(8936002)(2906002)(5660300002)(86362001)(44832011)(41300700001)(36756003)(426003)(336012)(26005)(83380400001)(81166007)(356005)(7696005)(36860700001)(1076003)(6916009)(2616005)(47076005)(82740400003)(16526019)(316002)(54906003)(70206006)(40480700001)(70586007)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 18:30:02.6081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a899357-5a4c-4dad-4983-08dbef76ded9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The return value is uniinitialized if ras context is NULL.

Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1a8668a63e67..f6b47ebce9d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	int ret;
+	int ret = 0;
 
 	if (con) {
 		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
-- 
2.25.1

