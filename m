Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F288DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 21:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F8310E464;
	Wed,  9 Mar 2022 21:03:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEDD10E464
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 21:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeISy286EVXmWsELf9d2J1RYzrXWLNF1ahuvFZTvB/GkcWYFHZSinPgAe+et9PYYG+yLRAXZtyuu/MJwmJM7cUZ+UuJTT2gttp/YN+iBCRkPdApbHyhHFHUPs13wVd8iVjdIZeM+jyeto1Yh+HiDsF8DOP3seSPMJpnJ4E5dYMYpZXsU/gDcUtxmT5lvzVK3VCm9ie0LmmToDkBmttIWaJVM4I8hS72HYfmVmPxnM4RgrKsXkaYzgpofqxPBKCYVDvPKm6Zx3heebPTPBRF33FG9bl0YK5TXe3wZOAQim2m+rIXD6dciV5wDJ6JhIxjhFnFAyLG9bgWHHyp82HTeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sun41VY/evI3pbW0b57xd8lO2yp3ZE2LXuA7BFME3I=;
 b=TmNe1XwwESIr/ew3Qvw9EXIrV9cCzuP/jw1MJSq5RPkxv5G7Rq5jfbvSYpPsc3VqUTlLIUQ3mM3omR01ma6hC3gmwr5rNKNRVDPYH/0VnfoSq31XbViAJfRfNCewOjQsp4buQ4oVjsTjj3TjDUeEBmmQk0hoj4UQ581SyRFRsIjEt925lkLYViwKCzcGHHdFKEswK2duceEz/NNI1MKShHHz2OgwC8bLg9wEXoMc8hZVHcmodl3CiYCj508NYSYsqs6OUNRRRzn8Xvf6s52syreTlu8hsCoI0XSMSf5O8BkGPQaxf+H4xrps6NrzirqHg86hINQLPQjyNqrPDLDOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sun41VY/evI3pbW0b57xd8lO2yp3ZE2LXuA7BFME3I=;
 b=00eif1Cbux2V+5uQ3OpBLOW20fWtZvDtlU6Ss1Iyzr+bjH2zCjUdbLKAzaI0tCRbBPkFW90gaY1YrbwJsgyP3yV66FgbL8qJm5bpZZ6f0ov3CJEUy+0EVg/VCwAgScLnRyeHoz4MJcfQjKjJ4ExBq4WJm2MXMDenvdHu/SZbQF8=
Received: from BN6PR19CA0069.namprd19.prod.outlook.com (2603:10b6:404:e3::31)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 21:03:53 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::b0) by BN6PR19CA0069.outlook.office365.com
 (2603:10b6:404:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Wed, 9 Mar 2022 21:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 21:03:53 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 9 Mar 2022 15:03:51 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Dump STB during ASIC reset.
Date: Wed, 9 Mar 2022 16:03:30 -0500
Message-ID: <20220309210330.576809-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309210330.576809-1-andrey.grodzovsky@amd.com>
References: <20220309210330.576809-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b26386-d667-4066-7e0d-08da0210516c
X-MS-TrafficTypeDiagnostic: DS7PR12MB5791:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5791A5C9CD466BC7E764E909EA0A9@DS7PR12MB5791.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWEMM6F/YieqhckoyP8JcPW7oPPSRKuTAFE3EcNM2EAv5Ec68TBWJ21ZNdYTY51fRuL6zCWzgYO6gIBxVoFMeEMFs+iUPxCxxB5KacveyXnF1PCLLhbsVQl3SwHWMI1/LhtTf0YGxwiBBY/G4b2ChO45W+YjqeLGLUpG3s4N2Dz4uUayTtqGFtdMPca0Jvb17AqE7r6mk78kQiENhECc0dDgUVtbioHpiDLtMQXkwWWc2b9AwMF25LZIFiy0OamHgBRAiuqRVWcKdOzoEn615kfd9Id1eoaYXbNZTbb/7c1ZUbB2Q6Ojyd9w8OumMnOGyNubfWL13hWI7VP6PvWepLj1I8ewh/FEZa2KVqd2WqtqSSjVEu6/2Tj6T2nUhEwrCaas3W30QecFhF5bZ2lQ9xgr+JPhBW8rNGgDSzhHpQQqSnY3R1DKtEzEMYludsLeHMh1VveiaUSVxTrj+A2iiLAiNkgGe9Ipf1IJ6jHRXSknlkbmlbC1de4jRzdua0DhDiDyMfSUEJPF2+SQsODJnOviVA9vnNMTL+kRUKET0g2Sbm0asjzNe6qEouA9zYEpqUQk88QFH6odZkgNZlvVyUqEOBd4Dyg1HECeI74WPU2auVs4WSixvW8uZ8c/aHdNjiHyBhjOkmy1RhhDx79UPUy5tRBWWdVlBNC2VswhLJXpi+Y+eTEEZ4ss3w/oDgy9b1cMIA73i9coCzrnhyHq6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(6666004)(5660300002)(8676002)(82310400004)(4326008)(47076005)(356005)(40460700003)(8936002)(81166007)(70206006)(70586007)(44832011)(86362001)(36860700001)(2906002)(508600001)(6916009)(36756003)(316002)(426003)(1076003)(2616005)(26005)(336012)(54906003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:03:53.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b26386-d667-4066-7e0d-08da0210516c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Amaranath.Somalapuram@amd.com, Christian.Koenig@amd.com,
 Shashank.Sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This should provide more debug info for the driver.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7abdf5e3dc05..22caff7c98a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4708,6 +4708,14 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 	return 0;
 }
 
+
+static void amdgpu_stb_dump(struct amdgpu_device *adev)
+{
+	/* TODO For APU case PMC driver API is to retrieve STB is needed */
+	if (!(adev->flags & AMD_IS_APU))
+		amdgpu_dpm_stb_dump(adev);
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4719,6 +4727,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
 	amdgpu_reset_reg_dumps(tmp_adev);
+	amdgpu_stb_dump(tmp_adev);
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
-- 
2.25.1

