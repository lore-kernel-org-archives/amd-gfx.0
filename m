Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F91C48BF6
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 09:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A6710E688;
	Wed, 21 Feb 2024 09:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AUvMPfNJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F1210E691
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 09:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvAC1NoE59u+6TfR0az7AzihcwKY8z1Z3J9dx2am58H6iMazTSQyGxFm9/UvK9ImFU221nDdmqt10fpsVgJmGsVX4u57XTWTfHvdAXZDdR8OmVa5dTmKLvkRqvSC+p73Zz7sNcLh12z8cOn/Zu6pIXN6JPw3dvjC7tQDDr3CBv3TeL+vy6Xq6uo3IDi0BJ0KnBh8eSeMNPgEZu+gjYKc2l3Col/9wIiKvXSH/s/qw6dElUxVY4Pmi066Qh0PSJf75p/+A+2SqUZTrALlRIT+Z4zwvUEGlYtc+8ILKgWVGEqcYCrbMDDosujNNwZsa/nAnaMPJA02bFW2xOeNGxEKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bos5KddEkzDTnAfcM8fD9p6H9VZrw0MZY1s7ymN2zw=;
 b=A34WStVRo0iNQO31N6RfzweutfAep/9LoyJsSTepj5XGlzXWWR3xEnYL1aOsXE0wtidXtS9S81Y/BBFxvKUW0mqgDvALzVHPvP2xOh4pKyp7IPmKblmz9Myno2yp5U/PFncBenzTqFESnvxtRxVMbxdUHNzKgZykZP5oyFbv3ukpgqzCPvUfGskkWk5U8CRm9imQKkrubp7+gDI3a4ll7iOAtOFo/utbDnSKEZ95K188OgX6CAGw041p8mlkyltVuVgnXOwyN7JzZvGMVNP9fFttNSIuJ4RwLhseihACaqc603KogufIP8vA8p1fWl+d+XdSSAxIDFHPZH4VkWQPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bos5KddEkzDTnAfcM8fD9p6H9VZrw0MZY1s7ymN2zw=;
 b=AUvMPfNJu/k1e+v7ZcZRKu3lDbnYNl6NroLE6yJLldkbj26UIiWsxe2glaakK33njDQKqzhG2oAgsBhX+zvVCB+RANgGJ5QrqjW+giNwZMx4MOXXuH5Yep7Dz9zNIwPmjPFaFc//0tXphLW7b2fC5xdp15u2BuaLJdkjNd6s4po=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 09:36:09 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a3) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Wed, 21 Feb 2024 09:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 09:36:08 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 03:36:04 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>, <mario.limonciello@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the runtime resume failure issue
Date: Wed, 21 Feb 2024 17:35:15 +0800
Message-ID: <20240221093515.1787230-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f38db99-5d7c-449c-eabb-08dc32c08860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUVzYZTdUl4WKsTH9aEb6fT75feX0JoWMGRPCv2Dfu/tw3/3v2wnqeVuVu60w/hm4uqI2IsmfWJwvYcOqrkkqV+JkAWLpqI+H5JEgLnlLzbo2V1xrGt66RefLICuKYV7AC8mOfilBut17Tu4pRNuIn8L2UFNrzwxX262gY4ucgHlUMBry/06WPl6M+9UeUZF9xcDh3e26CRAEOSsHaZ8L2kZdAEIDL8NGXWXIzxDYr4JkqOq5OPe5CDFiV5E/w7uAk2ErCIdzXeyGxgKwJWenkHNMtUE3tZsafodpdKy8n/79jiTr9oGkIpVZaDzMrGa5g4RweXATq7xQmEo4cA4cnUQTgH1Rx3JTt2RTfDayytWI87C7RFI2SVRi1fz/jW9Qj33PehglvmZRPtVxnhALWp4VDGKZXr5w02ggVSGrcSaAlvEsj14fGMrw8E8CqErC1vcTC6gZNTt/OZZZA1oODlsNYAF61cIVrmU1HOqFGO3N4wtN/abrqamvATEGfiRA0l88Uu3q+Waq6wRzMznqY4Mz+W9GUynCyaUg3RTiqxMLGaVdPA3Z+wBGVEbiimh2AKUvt4Tgk6KUy/Fg1Yww6F+RQ4pUf3qw6W6jBigvVaqqRMJwcdgMd5qYVn3iw47M1PhYakbR6I3U+uiq7wtUTILJRgNvN6gdgX/eb9Qu4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 09:36:08.1524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f38db99-5d7c-449c-eabb-08dc32c08860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

Don't set power state flag when system enter runtime suspend,
or it may cause runtime resume failure issue.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index f754e50e7b43..4f1a4435cee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1531,6 +1531,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
  */
 void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
 {
+	if (adev->in_runpm)
+		return;
+
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
-- 
2.34.1

