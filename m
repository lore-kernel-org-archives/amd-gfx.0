Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA38C3DA6E
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jan 2024 00:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37F310E028;
	Sat,  6 Jan 2024 00:41:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3488710E028
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jan 2024 00:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM4JaKilFlbrkiaXR/ffDOBMkYlDthXmvuMi1R3Dy34EHO0U7E8AAHR6vPn5MhO89dxsnNBMM8EV7xKpZVqgUrJ7RCIg9M7TPgk6x6KspCnwtBobjrcYvgb0xqZiMk6xOvvYoxfG4xRPLofZ0F4ZdERMBl9uH/OCu+LK0mtV3w8k0NDjYupf9l1ekmp4xRxkFxbe+uGe/uDN0hAHq5uW4VYWu2i78gzC4LDtDxE37NO9hVFj0OOh9/5+Tw3je8JVuor6jNQDVrrmQ09pzpQTO/unYFkOkd3AWYWsqlg9YfdCe++sDp3I9XQC6GDcF5cVJjhOXuwdxU3oEM/IKDqnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNu5v2LdJo6whSEnZoGNQDPXhluF+MQ1OTAXK2/rKG8=;
 b=VeyDd/qIP2YvE5/YXdCK9djxXNap5ychNwRYKEpfrVDiC0MA4OpjCb38pcBQUFhxQukfG2L438bgIy4RgjwXCigO3ACY+ZTWoHoi1w8cUiFM1TUMERGCnJlKdWtymLB8KGL0NMpy9aXOX5fgtE8THSKx3S9k+fwYQWeFUYV9YIbNVqx1nS8jXYh2LpBVITklnLjMaNET0R9whYUMp+y1SAioWmSxvgxx55MKdpy3xAgqaMOugr5M29J1lKQij1e6zE864hUpkf6SHiQ7P9Zr0/FRkx87yp4tuZUTbtHU6Fgilcq1SPAIE+U9EX+W7E6a9luWgkaAkS16qEoA1XesVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNu5v2LdJo6whSEnZoGNQDPXhluF+MQ1OTAXK2/rKG8=;
 b=d1+eIEvAkPsJq6YLMcAE7BCWgEZSJM7ofPeSU6V5v7qqtcpcEIvJfIpnMNg5e1cXt0bWxr5z3xJf8ZuHUQjTzN42Ig3u2Ltnv9LHeYjjt2U3nvs/1pBj0XPcNvhidR1JL+Mh3s7AaPYUZ2jkLWJ6292lrrknSQFsIyVI4fiFX3U=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Sat, 6 Jan
 2024 00:41:37 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::34) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Sat, 6 Jan 2024 00:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Sat, 6 Jan 2024 00:41:37 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 18:41:35 -0600
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation failure
 on DCN 2.1"
Date: Fri, 5 Jan 2024 19:40:50 -0500
Message-ID: <20240106004050.1506869-1-ivlipski@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: d81b2fb5-38b6-4e6b-b1e3-08dc0e503d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0eymnhEDztBDQiBHgdsq7JeYfTPx6WxCMI0vEwA9XAqQT0heX3G0YeN7pTLT1em+rBCtNirDR2IwPhMg4Vk3yDURiSHfD+OGcizpKuB62faamzX5fEsB8f0U+Evf0YoKn9Jis5JuYlgmTI5bafR4WJKqrh1mD5Mq0OK6ml0gOq37xXIiYBQfAVNBm7jKJlfPxdR2T08WYKz5Wb2DU9eXGRV9LalfQIqyY5NKfYZ3JOsSO0o6QZoSpwiq0iwYLPymmJewp7+dYhUsB7samOfmxP85CX+R4iJKaEi4wG5jtWD8pIVYPJ8pXw9biRP4uBxTJi2NuwY2AgHgEmehhvsuROaIdiKMkH1iZ+VFOIItpDBqUUfsmM0tFdXv1xXQjvGAzdpdoj2Ro9BcdB/ywAq2UrTlhuVcxwoyXkBby+wPQnD2ZzeBRus3ZXTrW0lEUNt1h8PSSBRCj2nnZ9Sy01VAVs1/pI3D5OMW0E0WdnNj0dZW6TJRWN/j6x8/SR3hj8KEe6/da8fYW2JtcueaXiD0Tex0vpFQdhPPn4dpAUqi/JlwelHE68lSHLvmpp6iD14Gm6VnN0ljAaW3F4rGgExQC67J5SBGsFhxrOHW46aAl+OtuQrlQPlMfoLkBGMEFisMMZejbuhb47FjXKdAbQ2xvIid8gwVcpKxNCHUBUg2rXgt47OTSRzYURaxBuK7z6csQgPqihBe0owDHC4vzknhsE3jZ7awxSnyXcSXliqzBOvGuHAXkNql0780tQKdY6SIJ1isFz/KUR1Csn8SRpjVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(426003)(2616005)(26005)(336012)(6666004)(478600001)(1076003)(82740400003)(36756003)(81166007)(356005)(83380400001)(41300700001)(4326008)(2906002)(47076005)(16526019)(36860700001)(2876002)(6916009)(5660300002)(54906003)(70206006)(70586007)(8936002)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 00:41:37.1704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81b2fb5-38b6-4e6b-b1e3-08dc0e503d99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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
Cc: Ivan Lipski <ivlipski@amd.com>, Melissa Wen <mwen@igalia.com>,
 nicholas.choi@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 alexander.deucher@amd.com, rodrigo.siquiera@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivlipski@amd.com>

This commit causes dmesg-warn on several IGT tests on DCN 3.1.6:
*ERROR* link_enc_cfg_validate: Invalid link encoder assignments - 0x1c

Affected IGT tests include:
amdgpu/[amd_assr|amd_plane|amd_hotplug]
kms_atomic
kms_color
kms_flip
kms_properties
kms_universal_plane

and some other tests

This reverts commit b7ebd39e2922f642c7ee63ade4a4a5a1ef675d84.

Cc: Melissa Wen <mwen@igalia.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>

Signed-off-by: Ivan Lipski <ivlipski@amd.com>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d77fc79f3542..111c6f51f0ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10752,7 +10752,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
 			goto fail;
 		}
-		status = dc_validate_global_state(dc, dm_state->context, false);
+		status = dc_validate_global_state(dc, dm_state->context, true);
 		if (status != DC_OK) {
 			DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
 				       dc_status_to_str(status), status);
-- 
2.34.1

