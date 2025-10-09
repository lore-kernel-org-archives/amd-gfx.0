Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E3ECCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0C510EAED;
	Thu,  9 Oct 2025 18:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDrF4zXe";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E751C10EAED
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6KFzzJJjbBBaqtgtYIlIxwp3isoKjf7SILAIOmdZU362f07HYItzx+FQ/7HRXa6q9559QAyHpsaay2ZGswZUCD6daDQLNT4KlsNXAo97h2x/cVVATBO09tw3BxZ0YKA+W+oksXLoDYqbbi2wbUsWd2GYHBXVz6LjcsiXRg+GHFJL9zDi/LnhXF1ddf3WzOqn8IFxO5zocnw2MhXJb78dFK8AnloQ1ETZGqacCr5RQch4kMN04AA+/WjGRwfEZYsf3Qrw0t384I1A0SwJAL6mAsF4z8LSqXfOy9liPrHdmRQzDOshmrHoOT4nf/Yhnmclq9W6yawpFPBQjfyE/NXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGWSQ+HuACkpIOsw1sUsPjS07F3sXxyungi6L43Pnhk=;
 b=yQ8pyetp2gDtT0ikcbDSu+xt9v0I6ZsYihaDPrAkfSTr0reH9zTimpZYbcdhWc2sbN7UdCtDi6RGmjhagLy5otFfmtzhwrvfXyiFhq1JC/PhDNkE+sRCObUbx8KaSDEDriDDYdoGgdbX8M0G2ea3alio9i8Y4lrdL7FIBAyTXEt0U0uNx1hfdpp9LAcnmE2PbTWLR/CoDBPp3utea4wF1owF5SoWKWiMFI3usdNCjO7X88qIaxI64ggkdlRGIKqshLloczVxe5P1iPwcM+CarYAt5og6ga3UHbg8pHJgLlU5Gt7lMXJxMqSsU/tBwZcE74PmMjXYcmki04FI3K+mOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGWSQ+HuACkpIOsw1sUsPjS07F3sXxyungi6L43Pnhk=;
 b=NDrF4zXevScdjcFoakXR+uGCLZJBuVZZkUDQRjeFfkXTXNq1ttxpfgOnG3zSHklMa1JMnmuc2nK2tEunoe4pFeX8dGQlAM8YFS6t6Xcgag9o4bhnog9RWeWZbCcureECs4bQz5sTo287WzOgOIsa7vC1foN92HV1h+5GUthTB3w=
Received: from MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18) by
 DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Thu, 9 Oct 2025 18:49:57 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::fc) by MN2PR01CA0005.outlook.office365.com
 (2603:10b6:208:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 18:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:57 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:53 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: enable suspend/resume all for gfx 12
Date: Thu, 9 Oct 2025 14:49:27 -0400
Message-ID: <20251009184929.1038298-5-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009184929.1038298-1-jonathan.kim@amd.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cab799e-0f49-4aa8-1a7a-08de0764a48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hA3pAQJ2/PCzdphiVABL6hA6cdqMGJamalFw0wEXz7kZlxa7q4lsFqluFO2?=
 =?us-ascii?Q?STRsgJ8aqBulo/Z8I4dK4Cbf1ar6VHd9hsfRuaiwbYH72K1sLrk03GO+1GQN?=
 =?us-ascii?Q?pz3ERDxVd8nY3GrfKf70mCrETj2QeqXQtZTesKij1Bm6NMRi2bFMZXQofDXT?=
 =?us-ascii?Q?fPh60Cwp5+VdFaQpgKwXQND0OiuZ9okoN4kQz1ouBs9jp8145navbODEFnI5?=
 =?us-ascii?Q?RL5YjyHdBsitOiHbPaobnrlr3rDsTNEnBMk7Et+aeYn7C3pUhDxLxYAWMWIJ?=
 =?us-ascii?Q?8al2aWw4LbeyaqkAT/ZhBlwCKJLzcTG9ivXZhWn+iMVN/4Huo7OS4gLzH5dx?=
 =?us-ascii?Q?I2if3RKtF5hWDennV+sq3CBEJR2hezVE1bMIYJvGIvY0qPyVVle43acPl0cB?=
 =?us-ascii?Q?cz6DKK8o1t0MffqwdE1G1XibOiuM5js8bovWQukaAPCEoxAUFeSNXHnNQo7o?=
 =?us-ascii?Q?4K5G31RtZXjQZHIT0294Qj2h9iK+MyjP6XnJh9HeWvAnLPYH9aIG78E9n0k8?=
 =?us-ascii?Q?SVEWduh2OpxG2WvNKxZz13ZcLjLP83PK1wDKgQzXJNRbAxPbjT8ybZ7PqZHq?=
 =?us-ascii?Q?OI/fGSdnxq4d9ML1KPqgZmMUgfAfiUc+AqDW5naehdm0qMJIMZGTsiZwzKyI?=
 =?us-ascii?Q?TwFDv2I8SSgpNNYqShHBWXXLRPvK9lZFb7ePHadIVLIGoxvjlXbb0B1N6Cia?=
 =?us-ascii?Q?Fg2ZreiHwYseB6hINJDyKmWAzYin3pDIF9NZbSFTMxK5Fu8NAht/yiXIqA/p?=
 =?us-ascii?Q?8w+DaH6iGgG+8Vmjz3TAzjfHIg+0FjiV4+cPmKb3rb2MDpJeJSR6ncU8CGMK?=
 =?us-ascii?Q?/cpRRPvMi8670pD8/mH+ZNAJKdg8MioPALy/tZYSexzTlt7VGjzm5wj7lhks?=
 =?us-ascii?Q?5+QmqYEvt0pIUvTMTCRLfmorRsp1XuYS+WzXNC+/Xz2fko0YCJMxlEN+F0l2?=
 =?us-ascii?Q?bctIqRoAYTCBTfSfTWMR9eurOeZfZUmTigY/7U5XuoSSOOmJHfrsxplWADxh?=
 =?us-ascii?Q?7LOmdJd4iEcw7psJHKOomV0rHMPTS+D0iuGwM1eamRq4od98GFfJbjF0DTfp?=
 =?us-ascii?Q?/HzQVexwzt4Um8CsNduAmyDsGrnqDEMQm+Uq8xeBEWlmIE0lbLNe9vNKJAmi?=
 =?us-ascii?Q?ZaFbR4LWZNT0XsbwysQgTC12x8VoDPhopkde+2X1hVgAT1J6OZ+w0Ucr989g?=
 =?us-ascii?Q?mqoyZrFX76LSgTGmEZ0nFHaiY1kh+83b0ZSeTiNLQ5qlnwYh5gfCVI5vUe77?=
 =?us-ascii?Q?VlH1gFN9OFrDcwoRTFO5oGZQ5jT+iCqt1RXlVvUYG8iaO7b7q/O0A6GzJpKX?=
 =?us-ascii?Q?sISl0Td73CfPR18nhJt2iXuyOiDvpgQU1Ede7k/EAyybgJcXO/7CzByIhYWq?=
 =?us-ascii?Q?/M3N30rO50kcZi7Y64GU0mQ0YXxLnF3bpVy1ysFWgQbC9taNW7OWcNvR1Cfi?=
 =?us-ascii?Q?OXJhE0qSy1zeR6ifEYSzOHor8i+e8wNL9FyOpkZDPqOnYNgIEsh5MeF+6yub?=
 =?us-ascii?Q?lw4YlsYjbVtjix8jby6UIqUZWBZKCg/Q1C8opOJ0sjo9ECMdIiPFUOHIhSZg?=
 =?us-ascii?Q?/vbmfaNBJ3KpkuYi/ec=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:57.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cab799e-0f49-4aa8-1a7a-08de0764a48f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
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

Suspend/resume all gangs has been available for GFX12 for a while now
so enable it.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1af3ddb6f65c..b2f87bc29f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -698,14 +698,11 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 {
 	uint32_t mes_rev = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
-	bool is_supported = false;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
-	    mes_rev >= 0x63)
-		is_supported = true;
-
-	return is_supported;
+	return ((amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+		 amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
+		 mes_rev >= 0x63) ||
+		amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0));
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-- 
2.34.1

