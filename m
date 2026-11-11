Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59B606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zDBjqq2x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DE710E94D;
	Wed, 11 Nov 2026 03:21:33 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F8910E393
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 03:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8OufWKuu9ztwCyao8eb6qrA6FvTyJUooPsgL7JJapcxn2Y8OqNlqwhtqzawe0+zck8gLygLbE5fhQ0zTJfwEne/xvEo0I+gSSa82DFNZIkHL95hcwjepm35CeuqoPCocCtXktx7CMZO+iIHzNMGB4YcrEvAeID9ZI69EZDki28Bcg+ZpHQbYbYiGv97QKmQTyYrZgbBKs4cPY6L1gWhCdF5fQ2wr8V68fwBh8Ed49Q/m6OFOjOAfr3H3GaA9CBofyuPuk0ao1KxVBWzyQ0mDk1PWRhXh1EcKCOAxI++Ue/wIxwnjgBUeYaY2QS+SKi8BeQ52gtUE6Dqfqf9N4MdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd9KpDwC5SrqAAFM9sQimS6GlXVqcVwcf/hzyWfwkro=;
 b=j8n14AMkH7X2ZbDj2H7NiS3kFbf7m6ckQeZ2LzPzYBfOb4V+A3zx+YSWSX3cwaND1NEinhoP/KcqvwyEG/y0iLqMpfVao6U0DO6J2kNvdyq/i7p7ChIjaUPfUrLgnpJ5e8cDa+BnaVd/WkNixg4s7fmMdO8qyijJLHFzpfyKSzmHGdLNJyPIL0z89p8MaReRiLht4AliEILm2yUsYnvgbkYDVSmOKzDz55MSfBZCw0ZPwOsVS48eXVljmQfJ56mVstQU95nDYhexHrmYdfT1mvichRurU+7ogZc/wMy5hW+wBgrrZZcgPD9utIRTLf+Aenp7k+0dyhkhG4vyf0XODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd9KpDwC5SrqAAFM9sQimS6GlXVqcVwcf/hzyWfwkro=;
 b=zDBjqq2x9GgR9iY27Ti0kMMCEl/XIIkSW1SyJxeFCUnIThg8f1l16pbY7BVqXlWLvJhLhTbivZxy3yKhv79DnT3ZXxqDgD+Hln3RVRQFimog0+kMeqHVAAJvtYS+i0OQKLA1RxSCmK6DE7IWvFLb5tyVv74zZG6qxEeKw7WqUUo=
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:21:24 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::28) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 03:21:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 03:21:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 21:21:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 21:21:22 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 21:21:21 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx12: enable the GFX pipe reset with new
 enough CP firmware
Date: Wed, 11 Nov 2026 11:21:03 +0800
Message-ID: <20261111032115.3787085-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 679315fd-9d3c-42f4-c5e8-08df3fa2dd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8YSaGqR2aUJ0mYj43WVhRfRVm42Bii/lmt+JZrRBggVnxWFkiTnP53ZciGLT54j3n3Q+qqG2+BLHT5opD0koRs0doTIEoaFJ7/ry0XHHFRipSfR9dK5Ls4viKsNwIr6uelPQmKl1iAawhUizboR+K54BWIx/EluQSOl7slPfQbLVZ0VKHpG2KE7/N/juxodU9/C2dLC7cAdxh3JLurmUiXTOCwTpxEEXQu4uGLS3I7BtbkSAD0O+UBjuUkoJaWm+Se8+qQ542SuKY5527Pbex9tVI5te5tpjOvhcCUATBTBal3KmYCEViH8HVQDLSuhkEKmAvA/Cv1RIN06l/W4VCE2OrSXVQKy+Ob8JZLKtblHtjXlM5TuGc+8oSuMHOY+dU5FQE3+kHUFB9rpOyjMNkWEsMoiFxzFvgoIJ5Gx0401F0MdGLyzGwvZyGugWnoN/WruRMZi9tvQrkw7p3//k/OwfaxltfTxllLORcr9JWPOHuF3x5z/eS8GXQDK1BuF4qLg3fEXQWaOOKStDXMzYNVF8/HJQqqmV8Yd+c33e2RNk8Jsga/1HfFlIMvMxPpNeEZo/SkKqAkFCNScogl2ZQWEDvej3maNmgDOzWUmKqh0vjGlP8LOer4ZgvgVpfGeY15vjz3u+KLUF79bsW489aiefZPGw64wqRhdGlUd+DTpfsktZSPqfshMpkGsOu/XAlesWMlg936Zu+lCPfRm/pQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ew+l4BRkK6sVq9DCalDYsMi6V8VUpiiQi0A4ZstUp5AQTRTo+K2KpZVAoyBJWaWXPqfCt2j/hvQcfHcVsmIfvGmG8Iib2HnX47QZLF+6FPdoH/BqFhlcKw4Dt7xZdeCwt3GfjXsZJoq2l8tkW9Nws8pWYuWn7ssJISejEXNZ+Upo4jqyhXmruO7OkN8p3IhLjyXWIqXPg1riaQ6cOn8TzntDqbKgAhfjF+GFiVOqIOVWtm68CZRMbQvV7AUcRGHcGfksSNevAwIic7xuw6DSF0KuZ/HcAcewi6+EL+iwTMb87FqvZQw7fhbmgqfDQArlJY2WwdQ84Stpqw1vNPKneUnDTMKi8Om+L3FdyQ1UPGxkoSDy3lqoTH1oHq0/Eg1uNEX8771Pv13Varzt03mmn5U0yQULEIHh9WRD2iLAcxLb2phcbYBSB+IN8uOqVDlh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:21:23.8009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679315fd-9d3c-42f4-c5e8-08df3fa2dd35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resetting a GFX pipe needs support from the CP firmware. Advertise
AMDGPU_RESET_TYPE_PER_PIPE for GFX on GC 12.0.0/1, on top of the per
queue reset, when the firmware is at least PFP 3220, ME 3120 and
MEC 3490. With older firmware only the per queue reset stays available.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index df2fb09bbcd8..6c48451ef8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1582,8 +1582,11 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-			/* TODO: verify CP warm-reset support before enabling PER_PIPE. */
-			/* adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE; */
+			/* Resetting a GFX pipe needs the CP firmware to support it */
+			if (adev->gfx.pfp_fw_version >= 3220 &&
+			    adev->gfx.me_fw_version >= 3120 &&
+			    adev->gfx.mec_fw_version >= 3490)
+				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	default:
-- 
2.50.1

