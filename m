Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C047C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A6B10E224;
	Fri,  9 Dec 2022 03:49:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8059A10E221
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avuHztmG3pDYocduRRTiRMNdC9LM/fhi1LF+3YVmQ/H1OvXafP11oZto5ATIU6Mzne1fFMF7wbmIpGGanxXI0aW2SWsHfp1EDcUWLIdMNWdCcko82ny8IPpvxRAVqS+pMm8dLOoGA5Hg77FK6N9McrR9YlA9DOlKGR8g+1mdpoBZPdm8msN0qP79rn7tY7qkEQXxIALOSAjpA6Nhsi/ruDDRtEfY+jL6tvfRSgW4kdCh3ldyx/kiIifwvPDtV+Xlv6AZn2ca+bgHCvZ4GzdSHF84SuBfhtsWrHFxWjbq8pEnm7KydEQI0ex9M7BSoeahpbc/sdujbfhPOpA3/drHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UQJXPqApJ/qAUiqXLy1TQ/8c0QZBD56nzJfGeIdYVA=;
 b=g+OScEZJ6Lm0KKqyCVmuUWGfCUCIdGUonkPH8WnZDA34K6JCaTpCCtkCeKk9BWN30B8ADyuQ5r036/AjMnRefir/gF7auzEJXvnlOE5tDCeLlxOVk0ClcXwBEJagaA8gUX5zYlfPhIjqDzKTPyd/cqTfq9kGCpWyajoYxAyzgshi8U7wzmDy+Rzyx63SddfhhUW/Hxr6Zhxmiid6UJt1LiobUp4yfiyIp/kZ0lGnxOzX+tqVmFC0Gn+5WkdZiv/M78K7+1uqWyH1LA+5SH/i6aQJBIs0fvaiNo95FwwpPLjOrKPzv6mU5QGleEkLYEnY1sqHOxWdEIlTikClIi1k+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UQJXPqApJ/qAUiqXLy1TQ/8c0QZBD56nzJfGeIdYVA=;
 b=QcfpEUzZg8IkK3kfsPf1awf39z+uP1YMa+IS5Q/oaTmvtZolwVh+prIF/GJg22iUfuWYfRDgmCBGKTgSboK+Onhbv+DiwFa4vThpNQuxysa2jCKXag+5je57KYi1oWDe1LZOqUEa8EvXxjv4nh2nB6w4nA3VrPrH6Dw083Ok/4s=
Received: from BN8PR16CA0024.namprd16.prod.outlook.com (2603:10b6:408:4c::37)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:11 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::e3) by BN8PR16CA0024.outlook.office365.com
 (2603:10b6:408:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:52 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amdgpu: expose peak profiling mode shader/memory
 clocks
Date: Fri, 9 Dec 2022 11:48:10 +0800
Message-ID: <20221209034813.2373727-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dad0b21-6a2a-43d7-bdfb-08dad99854ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVfkEy6Tpx8NqPWYbhMHT3i9C3SHkQdXJo1q+fLx+md+S+K9LUmejWH7K8Q4LIBnvUDZ6nIVxWiW6QcwqUDQSAt0Hz3mblZ82BV366U5X3I5ousvYPQaKjTYKjmj3liakv26FtUuFLBj6DMc2j9w+yj+FTnkkMJEgqTcNEOL9G519MMYoMN1KZHECOmm1rEPntd40qBLSuOytYBEzHVS2pu6LsPymlZX4Y9Ev2+KyiN0xL8burigVmlkXwADoo5FzJ1gM7XfyMfH7dsKD9K8V9WRxHHP8jnA19J/wqoHKxvqPLJqo8Ght/V1LsqOqmhi5dR0t3sS+JKz2fC+lAW3ePli4GGGEhEmQmYEp1X9QtGmYG9QjCPpzXxkusnjow3bpEk/qY484OBhyPGA7piYUk/76lhN0scU4qrGphSfcPCeS4tRLi2ymFkKsf/T6JMfZDKh4kX4MiYRcRH+VL/jMD5PUCtymHRS+PEUOrln0YFqiFeKFQ+KeF7cKRgCTT2mGKT+XqLtW94GXwHxqs2J5ZsiB4/Z8jE6qAU7BTYqnbx7U3julPY1+uh2mbHGwWG9NYPlniWwFmBg3c+F+6MidbPl5oHf0D4XKzUW5pVAMiYEVhFZfOuM7IqvZd9QAW4DheXfKwDqLyiYykkiwUlTfB489mzZ+Sj9mi72nKYfrgC+ydln9qRg9TA4OOaLw6l8//I9tg9qVUI7wUHf/aAvBTIOgbx0I2r6iltLj5Opwwi3uo2L+UJhXLVWzraV61kVqApl6AbWM02pM4jR9puSBDWtvdYwa8aGS/KKlv/0x4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(36756003)(86362001)(356005)(44832011)(40460700003)(2906002)(81166007)(41300700001)(8936002)(4326008)(83380400001)(36860700001)(478600001)(5660300002)(2616005)(316002)(70206006)(6916009)(54906003)(1076003)(70586007)(6666004)(40480700001)(82310400005)(8676002)(7696005)(426003)(336012)(26005)(16526019)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:10.6656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad0b21-6a2a-43d7-bdfb-08dad99854ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose those informations to UMD who need them as for standard
profiling mode.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7f60c17cb53846a73f43f0f847a32317f84b2861
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 ++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 150b431fc426..ccb80f0a7fe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1052,6 +1052,24 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 			ui32 /= 100;
 			break;
+		case AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_SCLK:
+			/* get peak pstate sclk in Mhz */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 /= 100;
+			break;
+		case AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_MCLK:
+			/* get peak pstate mclk in Mhz */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 /= 100;
+			break;
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 				      info->sensor_info.type);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9bae36b82806..038153f2f4cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -893,6 +893,10 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_SCLK		0x8
 	/* Subquery id: Query GPU stable pstate memory clock */
 	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_MCLK		0x9
+	/* Subquery id: Query GPU peak pstate shader clock */
+	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_SCLK			0xa
+	/* Subquery id: Query GPU peak pstate memory clock */
+	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_MCLK			0xb
 /* Number of VRAM page faults on CPU access. */
 #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
-- 
2.34.1

