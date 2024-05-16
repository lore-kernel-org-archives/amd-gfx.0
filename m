Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A80C25B7B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D72310ECE7;
	Thu, 16 May 2024 12:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BJ7LJwRa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA41110ECE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwghcXbFKy4bv96iJFykgRZH9FgpgnIxYM0RTXXJ4B2LsIDqGczeV1XXys7zSA3ogMo12ZFOf+CBQxeF1X+mmWC2fACYfP3lA6E8EENA6MXNVNFgnQedUPjq+w5GljTUF/Qv6ulT39pSoKt+AAIsTbbbFqwEDmRQSGZZyLNtkpcxwSqkhKq9M8UGFYYrRn1ZLAu7g0Y/2v5L/e6bU7cQmrOLjnyKFoK9enmrlXxsx7g9d+D5mO7jSOrnrsW8Hd4lknmLeEilr59vzbudaZC4qmHf+mM/9BBnLr3LUAduHx1blLucl7dNmTg606YMH48LFTYM7S4Blsw13GbUgxi/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bei1wf85uPu+8jXRMVfiNB2hAPtROQxtztI1Q5GR52Y=;
 b=aSpEUY9tYZF2YvLU8HEmGvvNmsgA0Tttv4FZvDIs91jvFjsVYhQ/MyJm7/gh1waUjBvx5LQOYZYT9CJRsNiZGLQ7/1cJKM8Jo1wKbkLe1d/4ZcW9iPGbxLL2CPhToFN5eIn/g8Y+UcEonYvq3dc3SjFbtVGhoFCGRX4O+YeuD2HyKaOldZvk6euOuD6ukJOVP2pYQDveOM9Km2tJMw9LWQFNjus70pwzvcgWH2rSfnuHsTk9GQ73ZnqZJpv0eQ17X9+CyC/ksyxAmPl58eyoiUK5PjefHq6PtIpUtLpycBP8v08VcvccRIendY+mam+S4XkvWc+4Pf9B56I9KAhmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bei1wf85uPu+8jXRMVfiNB2hAPtROQxtztI1Q5GR52Y=;
 b=BJ7LJwRaKXBPJE/jHMKSou44QZDBw5TTqJQ36OIrVuQXKvXhAWGOezbRJR6rPi3+xjuCqbHVDR1WWSR312G3izkOPAogXEwZLbArVM6yM75Z67U0nhfEFRJ+zitYrak3zpKIT2rF58/HjcKqGvYZovRb1DHM+3wRIBPvtky+5b4=
Received: from CH0PR03CA0405.namprd03.prod.outlook.com (2603:10b6:610:11b::15)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 12:44:01 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::50) by CH0PR03CA0405.outlook.office365.com
 (2603:10b6:610:11b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:44:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:57 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy documentation
Date: Thu, 16 May 2024 18:13:18 +0530
Message-ID: <20240516124318.508785-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516124318.508785-1-lijo.lazar@amd.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 71825213-1d99-43a2-00b3-08dc75a5dca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gAse2fWLfiqEpSMsNTPolY/K3leZ0ljXkhUX9AimX47TG4o2p66li0dJR7NK?=
 =?us-ascii?Q?DUlcSnCsVhcwIPy2D+XgGYYAb3hbttbb1L/Enru2Cefjl4wbeuEGNCu9hoSB?=
 =?us-ascii?Q?aPOv5O4Uht+zPsvUoh5nnpvBNF3OZPC1qCY4jHSqs8y/fgIMxCL1FTI/7DpU?=
 =?us-ascii?Q?AWUJVWFxCNyI4BR03hxeiXbklDa5JoTe1a+bUeixFfPLZTJcqNZANPTJAFlV?=
 =?us-ascii?Q?abJH4kcsKs2udi3WOI7u/ZpNWn80e9WaWTwg5gDu2dMmYSTmOo1sp6Dze1C6?=
 =?us-ascii?Q?KFhg73SK31d1wOMhTkfYap3Zqdgfh0Ark2S12LyRhhlGE9YmtvHMnK7jbjy2?=
 =?us-ascii?Q?SMOUWEtNnKubmQC2dUlNvIgnt1RpB3ECyZiMvpvTzxGvrU/o643gsiVtRrSr?=
 =?us-ascii?Q?bk/KrJoVk/ZNrTT+sSYsse+gXxALk0cMjHwLBl74wvJ9Kw1GI44ImBNbPS+I?=
 =?us-ascii?Q?i2idK6BAMzdhA9bDYASUWM66Nu95m2VsXFpuE16rorBZB71i77K9blB5WlSI?=
 =?us-ascii?Q?uHnCe71VPeAdwUafJINAoMHzv1QySJB2ct84vJQfMQHP7B/ezCSTlbTm4Htj?=
 =?us-ascii?Q?Ck60tcxgea5r0nm/hbsm9yS3T3lGGL+XmBwZRV7uDthmK4wYM/eAXvtZ1sJs?=
 =?us-ascii?Q?YBg2vt+191CQUo0hJQuUu+gt+JBATw34D/OgSZVaEoK3YkTZDtypTJj2CLyd?=
 =?us-ascii?Q?X6ouqN+4kZxbD+CgWgWePYTiZGJptii6uOJ7lCMSvAe3M9tssb1hHSNb6YKl?=
 =?us-ascii?Q?xNZkvvfJZASXHFqNkwkW+8RpSpwcDzEhsAVCdyKaar7oR8WILZEfcme0L5X+?=
 =?us-ascii?Q?gU/btmMD3S1JHgAjGnUsjrlTm+BbJVEZoWuNb0Dq6jrzqs3hbidQ5KvUqlYl?=
 =?us-ascii?Q?eScobu7s2C+/e24xWOYRedtI4P0EHxs0aMzvsdmVTSpyqyyjln7Bt63f/ZF/?=
 =?us-ascii?Q?gl519Acs4NrL8aYS0Ipcwp/JjTiG9rqIEKcr3QoXOBhwmI8WmLQvOCdeqa4r?=
 =?us-ascii?Q?ydgYOk+Tk62JumV+GOxs+9dUer6qC5ojPrqLFIwXCr7Cn+cJOpn7fTEGJPx/?=
 =?us-ascii?Q?8SHT5Doh/M6QlBvFhTNbYOv28k9RNKdjfLIzb+t83hpWHZS4yO82G+RXqLQT?=
 =?us-ascii?Q?B24zxAYey5yynKzmP/vyXwVtYQTrDGhIFnyRiEaj+R7NipCv3P29s4z2DJN8?=
 =?us-ascii?Q?52FDKQ7rg7e7Vp+82PuaBZvH6bEfMb1PkRWU0K2et+19Gcb5Ns6XEJOrjDYD?=
 =?us-ascii?Q?4f1Nhv5nSZt5kfi7ZNWvKt4aSWMNv8ed5RqAfk2imH9SSi8xTRjHJpB7N5lw?=
 =?us-ascii?Q?kJKDk6DBx7yPf/jkzPof5Kn81laygrwcNkPWz1XqM7u8bPK3XYOTbqI69WZJ?=
 =?us-ascii?Q?pt1kFh4881PTAfiN2YbJ9qKSEq73?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:44:01.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71825213-1d99-43a2-00b3-08dc75a5dca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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

v5: Update documentation to reflect pm_policy nodes and sub nodes for each
policy type

 Documentation/gpu/amdgpu/thermal.rst |  6 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c   | 53 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

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
index 5ff7783dfc43..3e5ffb83f398 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2220,6 +2220,59 @@ struct amdgpu_pm_policy_attr {
 	enum pp_pm_policy id;
 };
 
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
+ * be viewed under pm_policy node directory. If SOC doesn't support any policy,
+ * this node won't be available. The different policies supported will be
+ * available as separate nodes under pm_policy.
+ *
+ *	cat /sys/bus/pci/devices/.../pm_policy/<policy_type>
+ *
+ * Reading the policy file shows the different levels supported. The level which
+ * is applied presently is denoted by * (asterisk). E.g.,
+ *
+ * .. code-block:: console
+ *
+ *	cat /sys/bus/pci/devices/.../pm_policy/soc_pstate
+ *	0 : soc_pstate_default
+ *	1 : soc_pstate_0
+ *	2 : soc_pstate_1*
+ *	3 : soc_pstate_2
+ *
+ *	cat /sys/bus/pci/devices/.../pm_policy/xgmi_plpd
+ *	0 : plpd_disallow
+ *	1 : plpd_default
+ *	2 : plpd_optimized*
+ *
+ * To apply a specific policy
+ *
+ * "echo  <level> > /sys/bus/pci/devices/.../pm_policy/<policy_type>"
+ *
+ * For the levels listed in the example above, to select "plpd_optimized" for
+ * XGMI and "soc_pstate_2" for soc pstate policy -
+ *
+ * .. code-block:: console
+ *
+ *	echo "2" > /sys/bus/pci/devices/.../pm_policy/xgmi_plpd
+ *	echo "3" > /sys/bus/pci/devices/.../pm_policy/soc_pstate
+ *
+ */
 static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
-- 
2.25.1

