Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB65C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 02:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427D410E303;
	Fri, 17 Dec 2021 02:26:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A1610E303
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 02:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqETD7VJ1vkqFjw8z7LK8LP1ojUaSiEihJpzUxnlRRzqJwGznBOx5U6vhOW1Y2MW6kxeIw5psibdPlpxdANpBmqSjylQC4Qy5NFM8wFj8kvua6GWNODvcQQZBHYeiN7arnCm3txTiTyHmqPizxRC8Jni98GCawEw8HVEZdynkkUYBkFBXNalJtm78onKUX+RVUrzuGXOj3EQpCoiJHqWrouRryps+QgAgZzTaRHqpikGzdcpm3Xqdy0aleY0luF2uw9V8WROsQWmnJVMUDk51AuDlkRhGN75V9qUFGHrSetvzW/pC2YwHaRhXInZi1pFFV/1M1jGLPw1gtb3AYaQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GakkTCzuDJtkpCzetFyfU3fORMX7/tGvs7nStsrtZBw=;
 b=Xpx2L+ai2LzaWYoJFr8/0MTkdahhRdMFuhg+nEWB510RhGEHl7YD1N59Jch0qi3fa6JsFgFxljv4glndBam3epa0GnbnCoVYs+AFIAnj+4lTdcUhLQpkVYedfmAK/3dhK/4YQh5BixRMGtfn0wKjh/dlIvRAllDsFLocLsEf+tfQgKlw2A+76ZWIEzdNrZArYhQXYNL7KEShv1T2hr66cMgHUJuot8rFLUrdddal78Cc+naP00HllLbq2nrhPbKV2qurOc6CWz3mR5FGfqO4CmHYknnaMY5WBCo5wkDbPI1ldReiJ2GZLyGGvFCpMcFo2Wd9bszJqQJH/mKYOEoSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GakkTCzuDJtkpCzetFyfU3fORMX7/tGvs7nStsrtZBw=;
 b=DzgLwHm9bpgD8SlQge96C+IngmoLLFJ5rGF150YjyFkopNXfQX527qWp74nnDQKLZCEDdmU2Bsy7Dzje0jAeUyddGtt9E/0EHHjgsK5LbL0idmfIkffFoNRb00k5EpCWDwOEMqw7cWcW3tw0qPeaTqp63NZIUQXF8KIxQ1Fd3zk=
Received: from BN6PR14CA0044.namprd14.prod.outlook.com (2603:10b6:404:13f::30)
 by MWHPR1201MB0255.namprd12.prod.outlook.com (2603:10b6:301:4f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 02:26:22 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::f5) by BN6PR14CA0044.outlook.office365.com
 (2603:10b6:404:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 02:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 02:26:21 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 20:26:17 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <andrey.grodzovsky@amd.com>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device is
 unplugged to prevent crash in GPU initialization failure
Date: Fri, 17 Dec 2021 10:26:01 +0800
Message-ID: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff63ff9-ede5-42b8-1b70-08d9c1049d4b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0255B603E8C8A481D12DBACEE0789@MWHPR1201MB0255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dl5QRMwm77YCeraVQbGR0BM02MeGX8KoF6S035tX1MnJCzgLn0qylNFOG7fBI64imtP8937q2v3tZmntzl8IqXGrW5Cdk9wR8w7IQ9pO3gLojncQI+sFJchpkKEOhXmkbW+smQoyRX7AbMVdXvzPUJ0GmCHFD+mYTg9HlR7tx3IVCgZ4zciSdkratwMTuS9LjDauvQGHtTv7G7+OrkOzTaWz4gVgI2E0rks3lqhaRAaOYOghO7ReqQECAdfxHpyHxTHD1IU2Abs7lTqzqAoKjBjJCfbdGz8zyY/tKqmMbUGqILKpFJkpGyYVrUC4uPGjvVH/cCm+JfXDuxMuOU+AI8vtQiG9G0sYR3VNxo2BlQsUMx4ppxKrfBQNk9gXVf1BNny9r+oHAzuC/IjgJau82b/bTby+HcQ++w0sRaLRdbIWOg75V0ep71Hn/XS/U/3uF6huhIT+64C/qnm9K8NH30Hd+Cad0AR81ELrZNd0dGIqcmxrgVTdqKspe4WGX5U8lsqQxA5rpTJRx3N0RcuvmYJt/ZPBnHgamvI+bTlfoVnlSOtFar8PBv3ngCdOFIMKsehRluxUQZ+raOYnSu83879wrdNd6nDA85ZCtQbneqzeWZekW/ANBGSCq6XmNsIztO9lWMn8MItN1TchSuSd+M732OzCCn9ikoGXbXJ/cKj+hpZtTgxUkAfST4NyVRm58FE4rqf4gZTwbFcKNlZUggmlINI1KmXNwqLAbSep9psFim0K/wsYj9/3k+s1rZ+o5dPHPBH9tJEfxuactuAAyfZuQihHltnig8Z+W33GoTuIrFfqTJbYQLPHfopUjrt7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(86362001)(16526019)(81166007)(6666004)(36756003)(1076003)(26005)(70206006)(356005)(36860700001)(336012)(8676002)(5660300002)(70586007)(2616005)(54906003)(2906002)(82310400004)(8936002)(426003)(110136005)(47076005)(316002)(40460700001)(508600001)(186003)(4326008)(7696005)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 02:26:21.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff63ff9-ede5-42b8-1b70-08d9c1049d4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0255
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
In amdgpu_driver_load_kms, when amdgpu_device_init returns error during driver modprobe, it
will start the error handle path immediately and call into amdgpu_device_unmap_mmio as well
to release mapped VRAM. However, in the following release callback, driver stills visits the
unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

[How]
call amdgpu_device_unmap_mmio() if device is unplugged to prevent invalid memory address in
vcn_v3_0_sw_fini() when GPU initialization failure.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f31caec669e7..f6a47b927cfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3899,7 +3899,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	amdgpu_device_unmap_mmio(adev);
+	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+		amdgpu_device_unmap_mmio(adev);
+
 }
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
-- 
2.25.1

