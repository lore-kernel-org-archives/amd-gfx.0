Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B8CC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D938910E59E;
	Mon, 13 May 2024 09:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cFNUI/9K";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A3C10E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoLVdOILgGhOviTUCBlwi/bKQ5WLLiT2njg+ybwi2CNReuYcuZkMaqtjRVrRbcz4PXhVY5G+ETuzvGQ4nI/lpWg8lYWKICc3RRwtdIhD5vyXu/IX6FqkTBRbu/9lmNPZSIlsKjFsrhus5SytwAdGLI+lFKGGTX3amNgtPGoTqW/l9KLmEvrLPeD7PpVWHb4ps69DuSONNLmV+/ehcG8Jn13pscYY/Rgu7KosA6KSDSe+S5r3GZs32FgSbIK0Cil0We6qRmz/JBySnyhrbA7143fbIwcYRlvfyhNTVzrMh6RnmP4n6M4s/DlzWI84N6QcCEGhby81CAmoRtjrtHjHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD7nk9FHTZCXF6FSS+nHRTzL1+Ppbd+nwiBk5CINbSo=;
 b=JzL552Du3SyESweQ+5QWMXjwzLQ7XlD9Bvs070HhmyZTzhdAbLieKiYv5OMzZokFb/7h/EuhnwMujbmPKnpb9Y3hcbFwiSdWdG5CggblQfEeqcaSowwIFFBsMxpHnq6js3bFZvecNyHxOaJ5zhGNs0/9ckd11y5oyXTeaCzTqO+pG0H2lhH8wMysx+D/1Okt2omlFRFFEVcMq7sIrs3WIQNKZDhGO1pmdlw8bdMrULhjtnzUax5gy+eQp5CVgYOArukjWPAmKNGw6NTzO1FiHC/FD5ReKoaKFH8UPCSrDpcbUIRgOHEft3a2qyZ6SIdCxOgfO7Zbv1hRZbgKJTgPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD7nk9FHTZCXF6FSS+nHRTzL1+Ppbd+nwiBk5CINbSo=;
 b=cFNUI/9KDnOZ0xncCwdOX4A8EJhlRoTK9pUaetZQGH7dKalaq6MaDP8awwpP5u29R9c5NyZBEX8SB1JAOFbm5MQT3tJdVSfWeepQaVBOendxzJTJ5fSreu96MpiZNctexQSNBoBv9sF0Z8rBtzDFmnTTBvpJtHtFdl6yKCSoORg=
Received: from BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) by
 PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:48 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::9d) by BYAPR01CA0037.outlook.office365.com
 (2603:10b6:a03:94::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54 via Frontend
 Transport; Mon, 13 May 2024 09:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:45 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 10/10] Documentation/amdgpu: Add PM policy documentation
Date: Mon, 13 May 2024 14:51:11 +0530
Message-ID: <20240513092111.341168-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1b070f-d526-4846-ad8f-08dc732e1d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/58QpQa7Dtt1Cjdq36rEjkdiBSVOsqPpMsIDnUZEzJgMDiKR3TbZUeZZFk9?=
 =?us-ascii?Q?BpmlERj7vqlXeiV1YWsgMUmSjyHoPn+anD/NIfesyy5QjKE+l/5jHjjEPc9l?=
 =?us-ascii?Q?LpTYiWQoM5lBWUARp6KGqhySww9g59yeNFhUlfls7QTNmXLl1BRLnZnjDKgG?=
 =?us-ascii?Q?gdR2dSOruSkMiX5ic816RLXMWwq6Lne0DzExuax2nA7E9z3fiAKpfaJCIPqg?=
 =?us-ascii?Q?+YZ92hIg/r7yfJwv4Ly9UYGVFmHW2uOy9RRnUOuHZvy2FvRJQdp0naFaiOSU?=
 =?us-ascii?Q?eVaISu1IyLrHMPNf/m9jAD2/MYzwy84p0q87jHQtyI4x1MFfRZruAHbKxLh1?=
 =?us-ascii?Q?6+BfxFFUERoF8uXw8NyscnjJOvW50xlBa2K5lWDR32iHYTYfcGtqstrF8dIt?=
 =?us-ascii?Q?FUU3nx4epTdDx27rfmVg+VR4Ug9EEDtniGPquxV4GP+tPnCOzmOkoGUt2qLn?=
 =?us-ascii?Q?5HWfuP6CVF7jOU6GRjokeCHgP+HM3oQRex+4W9cetkaQcN/e0n/cOIaydSTX?=
 =?us-ascii?Q?gkbs0deuG/aRnRV7qmEHy877oVEuIoOq8/PbnWOqhYBG9a+3H0uGxqT3FLhz?=
 =?us-ascii?Q?ieszOBU0EIWFxmeoZm3JPBt+L8AMJMNDIQWHab7WzaxnKTgGYAu7ilcreQHP?=
 =?us-ascii?Q?RtwMGe6ukUN9w1ZnpOURa5iQrRt17aqthygzZlitPIz4ZdAqdbvdiycuf40S?=
 =?us-ascii?Q?7b/um2cgw7yoGjIgHwroON3h8oh3OewE3uZcmA2Fvdsuiun+R7NXita+3frh?=
 =?us-ascii?Q?L+/ozJpv78a2iO8hIUHagPy4DOD1OyTdVfg4IvpXxRMU0yBLUkCRsyhLTaYy?=
 =?us-ascii?Q?S6ecVGIEB/LiV5JpSJRyRGO5HyPXUpLhWvc0V+xpLmo0PLV0dZE6OknJ4JXp?=
 =?us-ascii?Q?PEkfsb6K8jxbV+w/vdK8I/PoHDVasmGVdR+DpdJLEYJ9FRzl99ySwiCUDtw/?=
 =?us-ascii?Q?GUyAT1eWv03wHeikiaCv7STIUQlcF/eZBvAt/5WKAyjhlrSOZodLinYZjYzb?=
 =?us-ascii?Q?rxugToBWpY7dmJ/69Y+Jp8bQh5ScDGVBJqugvqL1LES04lFU1IUolZJ4QBqy?=
 =?us-ascii?Q?88IrcUflIPR6k+isI32lt7RP9y0pB3PaBshYL8wVbGynQk/49BCM64Zzvd2V?=
 =?us-ascii?Q?BdzviD/flA3hqUra8hrtF972gHeiw8BYig+PEooPnlG+dRzTdI8e5zTfXgqP?=
 =?us-ascii?Q?55d2mQ5kksCV5gfQE77ptr6fm1ziQ+ELunHaUcd7kqk6K8wXgR1OVU89vv6z?=
 =?us-ascii?Q?l4t6JWkVjsFGL/IsBurhh7OWGnYJR9pXOs/B5VFaN/IVUMMwjjtdzBgrKw/D?=
 =?us-ascii?Q?CxcLFTaJcFDK02j0GX9XYQBLShUvu35sjMunsu8OcgdKJOZO1GkqBj47mboN?=
 =?us-ascii?Q?4Js+ZWucmndDiK1SBVsTT7gf6uqi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:48.0016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1b070f-d526-4846-ad8f-08dc732e1d88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
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

Add documentation about the newly added pm_policy node in sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 Documentation/gpu/amdgpu/thermal.rst |  6 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c   | 48 ++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 2f6166f81e6a..6d942b5c58f0 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -49,6 +49,12 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_power_profile_mode
 
+pm_policy
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: pm_policy
+
 \*_busy_percent
 ---------------
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9cca4716ec43..45766d49f1f2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2214,6 +2214,54 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 	return 0;
 }
 
+/**
+ * DOC: pm_policy
+ *
+ * Certain SOCs can support different power policies to optimize application
+ * performance. However, this policy is provided only at SOC level and not at a
+ * per-process level. This is useful especially when entire SOC is utilized for
+ * dedicated workload.
+ *
+ * The amdgpu driver provides a sysfs API for selecting the policy. Presently,
+ * only two types of policies are supported through this interface.
+ *
+ *  Pstate Policy Selection - This is to select different Pstate profiles which
+ *  decides clock/throttling preferences.
+ *
+ *  XGMI PLPD Policy Selection - When multiple devices are connected over XGMI,
+ *  this helps to select policy to be applied for per link power down.
+ *
+ * The list of available policies and policy levels vary between SOCs. They can
+ * be viewed by reading the file. The policy level which is applied presently is
+ * denoted by * (asterisk). E.g.,
+ *
+ * .. code-block:: console
+ *
+ *	cat /sys/bus/pci/devices/.../pm_policy
+ *	soc pstate
+ *	0 : soc_pstate_default
+ *	1 : soc_pstate_0
+ *	2 : soc_pstate_1*
+ *	3 : soc_pstate_2
+ *	xgmi plpd
+ *	0 : plpd_disallow
+ *	1 : plpd_default
+ *	2 : plpd_optimized*
+ *
+ * To apply a specific policy
+ *
+ * "echo <policy type> <level> > /sys/bus/pci/devices/.../pm_policy"
+ *
+ * For the levels listed in the example above, to select "plpd_optimized" for
+ * XGMI and "soc_pstate_2" for soc pstate policy -
+ *
+ * .. code-block:: console
+ *
+ *	echo "xgmi 2" > /sys/bus/pci/devices/.../pm_policy
+ *	echo "soc_pstate 3" > /sys/bus/pci/devices/.../pm_policy
+ *
+ */
+
 static ssize_t amdgpu_get_pm_policy(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-- 
2.25.1

