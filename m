Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC121CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 03:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463CD10E2E0;
	Fri,  8 May 2026 03:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UucJau8";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E3F10E2E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 03:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpRR3ozU11860MH6ndHTghpSNSUd/vPzZSxF4htVTzLTKiZjTGGaK7hJu/1SgVT8/LxBsAiEuHO+gwFBFrU0KgBd8vOEaLaV9gFex8yaE20rzEeHzu+gK03ZNZKbX1G8GHbw3UC2N7DeCp15zEOmZcY4ltw68W5YU61i7tgpomBzTCtNygXdP5+Bvwd53DVFglVrLV//Pyo+UrZibDrVovqmLtDFaek6mq0kYkRJZSl7dJFD0l3jRyZ+9S1/GBsaN2pBVhv8hw4Fr0jelbTzPtbaFq7eUyKB+CcmEq7sJx6gYeEPQJGK40Oq8giFxTm7bJMkKoPbRNKiKk2R75ppsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkU6lu5WhOHiEDaG1ByhLFClnUvnquFkvAQLE/sCUas=;
 b=b0A1lPpnGwgYEq+ZjAxoRnuPU7Y08CNAJyKIluTCAhz9tj3UwDa/Exj0wxr1SEzSEzu1u0w5Q3/UiojIvwfXEFU8jzyPptXR+IHXDicgaQwKaFzIOQMzflISLXcMK6pZqrbXRqo3q5lGqpPwv2BO/1RoTSl3vWvV/tCAASyfW+sMhtxCT3T2BK5+bC7Fdx4VCdfQyY+nop0LsaEATn/5BH1QFJbnIVui3R5FNP4N5JMPxzqtj3DClOPaJLX8+IMXFmAhcX2fSj18LqpHHtWxq+rkB0MeqQnFI4jNGLxol4g+fT+2jnQvxQn+E+lJkbjHpSwxrkqFDrh1XU2OKssppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkU6lu5WhOHiEDaG1ByhLFClnUvnquFkvAQLE/sCUas=;
 b=1UucJau8c04UfT7NmkeqZ0Azi713n9G12FUHgWzLoS3B5Iaviu++STufUF6b3IKpUaA6GXz0FyBOaqIN7J6BdjVl6vvyxhvLHzk79SmsQvFpcGNylW9yY26aVhxWazRgP1ctg0V6cePyDjuGpNIeZHisfxHcsipjpedmsrAbVWM=
Received: from SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 03:20:32 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::90) by SN7PR18CA0005.outlook.office365.com
 (2603:10b6:806:f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Fri,
 8 May 2026 03:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 03:20:31 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 22:20:30 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran (gc
 9.4.2)
Date: Fri, 8 May 2026 11:20:19 +0800
Message-ID: <20260508032019.1617320-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 3689571d-fe2d-48fe-b0d8-08deacb0c2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9i+oaRGQjwi8kd7XzjXt9dG839HIZoxCONqIaOiBxu9WKahcErXSS7QGLMywq3Ta9Z58H1O6OrSgA2HAB4T1V0GP/A4hQ+29D1WAlecjlfZepMysxLXk2Ev0sDTbnm9kVexe1W3KMqYimayptq0vcJOxwzhLqNDkB/8fT0OC6Tn4yABiaWxQx7mWyRz7g13bOrnTuHThXT2UpkGRTAelCSQ0Shy7bk+MtYITf5vQwuFH35n9Y+jJ4FbVa3QNTIGnpfFajD3lUU1dvR2hGsvF9dJeUUUKNAWXt9lx6dVz0Eew7FtKXXc2whmf0kFvW1M05noJE9iU7Kk7LXYnZBreDzbFUNArB8ArdpX9VN5UDeaxBYYCkJgB+LXYeQbbLcHd1if4HoMYeGHMuIqiDoz6682tlizynHpYZ1Y/YvyAFYyhxAVHtstgYnVIXvgqeVkQjZ0bIqp/9OYukCNRNSSba8uGOF+q+UOXg2fSmjduZ1eB5qsctzgyDkZii3i46HiefpdJN7bWwQKJCUOt/Kh9xo/Hh9P4nqQN/2ZLnOF678AS2HJ1BpaNc2XfYBEguC2roAD8nMrFwGQ9lWM9u/IASwx/2s8CgzMVHoUlL0XRo0YWn2keH1WiHVkjZB2uI5N9XhUrTiqrnriimVjmOcyV0U2rF36u4tkDhH9ytY3F/FmyDU03tFJCXY9XrHsitDoD1QwRfTB16UXPqUmstol17W3DizXKyzwHUJmT3J9b6EI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(3023799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OmeDG8yI8EpBOm4XUvyWmHBS86rD/Q/WzDJB4Lt587j9u8N7VZeUgMZ5ew5LckuPg+7vrQMNOszgnJbR3RRWKmi+fIuBWKqJf/OlS5w6WYUhabjGojjrvApEoScBAzAAvtka2Ra++O+UlA5LVZVp0IqheUhiO/nO1YYOprfAk1vhGfZAAcU2NlioFfkNHnft+kyK8az6lZ+dzlEng+8GS1jLJmEMmIEt5apuBT7blOaN1AnFtL1dk3i7AhOEpseJBRarb32C8h4Y26drbLEmBZe5bv7FGXethiY+UU2o3HOC0Sr0HhTF6Tp/qpmvMF3q6Ed5iIhM3gfkSwaeI+H+FiaU6e3B93DITX2Nqlgd/4M5fNana8xqaaY0rsoD976H9SlhM8be4KGZuUhgx9JStaQ+e/ihKt4EM5Diptc1LqQhuMhPsO6z0Vx9rAmUqZlD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 03:20:31.6835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3689571d-fe2d-48fe-b0d8-08deacb0c2e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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

Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arcturus)
and 9.4.2 (Aldebaran) ASICs:

- Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update comment
- Aldebaran (9.4.2): Add dedicated per-clock constraints:
  * mclk/socclk: Only support voltage control, disable level setting
  * fclk: Mark as fully unsupported
  * pcie: Move multi-AID check into 9.4.2 case, disable level setting

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fd2e63530e8c..9ee3053973cf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		       gc_ver == IP_VERSION(11, 0, 2) ||
 		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-		if (gc_ver == IP_VERSION(9, 4, 2) ||
-		    amdgpu_is_multi_aid(adev))
-			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
 	case IP_VERSION(9, 4, 1):
-	case IP_VERSION(9, 4, 2):
-		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
+		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
 		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
@@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 			dev_attr->store = NULL;
 		}
 		break;
+	case IP_VERSION(9, 4, 2):
+		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+		    DEVICE_ATTR_IS(pp_dpm_socclk)) {
+			/* Aldebaran mclk/socclk DPM only supports voltage control,
+			 * not allow to set dpm level directly */
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+			if (amdgpu_is_multi_aid(adev)) {
+				*states = ATTR_STATE_UNSUPPORTED;
+			} else {
+				dev_attr->attr.mode &= ~S_IWUGO;
+				dev_attr->store = NULL;
+			}
+		} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+			/* Aldebaran does not support fclk dpm */
+			*states = ATTR_STATE_UNSUPPORTED;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.47.3

