Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E579C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CED10EA4F;
	Tue, 14 May 2024 11:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfsPR2qC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0EA10EA63
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghTMCEByfUGKR5gjqgPT3hRagJi5nvtomNsiLMp0KBJ9y/oY0DWS0x7+YRIzak3vMAfF/KSpSD9kgVKwspwJ81LZv3t1yGtj271mlRqp6SZoGg6vtVNLAePaLnS1yMrh4e5utQxlFWkZv9Am7MXjvb2tq6yJTZEQRc/aCM3ar06yDksoJpr51o6PfnXTupiZV79sitGZDAZQLsDgbZ1YIbRyjXhrSHX6xv90Nx8N7tn2fNHKpsi7sRrsqBUQW9gG0yGQXd8Nc9XJacVXqZ9XvP6EU7K24Wun8koEn6X1/97GQVn0WNvK8gK9rJsS+EJh5Nb+PWoS9R1PET8CUcMjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MePXl5kX3+sLEk2tEglElMea2XxgAQwYlabtAPr8qXI=;
 b=nwmWnPSZeTcH+9az9ZebU5zSOWeXaDXKAhura1kml1ouJYbMQ8ePC8M2XIxTzBlNw5a+/gHvJ9sz37XKaoBvjaLWwl5Ail4rQvui6IHtZUfGjbAPFrYXtGS3wZK0iNMxq6c0TER9yx0GixkJKxFJSLk5gCCjcHM/hxv9bS4rG1mZXakMi6ETxWlY72RJJ9BTFJdGCBemOBskk0A4wyw7D0t0D3bDeuLk0pH8FFM4OUzERxgw7E+eGlqFCXB7ubq8fmW84tMnj/EzWaJ+bTAmi3Ca0ghZWTEZU0+iPKRijMYqsa/1QjNvflUSixhcwMCbPMpTQB6ppC0NY7D+j12BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MePXl5kX3+sLEk2tEglElMea2XxgAQwYlabtAPr8qXI=;
 b=NfsPR2qCXQ7LjIwGHwluCyuq7oMD42+FASIxf2vkxMbHiygpBcARkhTwDzmjIU1l85DcP3cWvjdK7TCPAezgRhe8uIEvvBEVvc1f1bnICvDb+9VUKHryVzZrWQAP69UBo4jVPZ6otDTeh5o5wpsBiY7JXoHcpJk8VXDAF1LmLM4=
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:06:43 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::34) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 10/10] Documentation/amdgpu: Add PM policy documentation
Date: Tue, 14 May 2024 16:36:06 +0530
Message-ID: <20240514110606.396234-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 078d78ab-8c47-4606-a6a1-08dc7405f043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aESagU4RbqqR10AT1DTuOReBziOLjykQpGe/hYSB89XYgu46Bpw92iBJFSl+?=
 =?us-ascii?Q?EtoHUoto+SjJWLjZoAEla/cOJW10mTWtZoITb/MDX4MgdqJXV+RXMtob4lYe?=
 =?us-ascii?Q?6Y9GBB1lBszPCSkkCnaZ+kEWeWhINscgr77/+z8PBQjO2lqzhgcol55syIlH?=
 =?us-ascii?Q?77zLSKrReMtIW93iIPOkTmhpiJS2z6RwAv0nniTdSZ7hOtZYnyC+L+RbfGfK?=
 =?us-ascii?Q?9QUdpTkuZPVk0f4g9gLGfDiwcSB8WivEw3ggZd3BmAQhHknMLXUE5Ef23Q0U?=
 =?us-ascii?Q?NVj/HU7Rgkrp7x9g9YEQJVKxHQXzrnKGtfWC+4yJm067aeqdpQP6mdKBvFD/?=
 =?us-ascii?Q?gx8vIGrfBujebfv3GWZqAfh5e/deyDxo2Plehwl28uC3k+EN4l/Z4HuEnxnU?=
 =?us-ascii?Q?aGvClyi1Wue7w/QzA/kCI9pVS34K7qXqPEBiQlfQM7RcAYLgGIleHEWXC3w7?=
 =?us-ascii?Q?FE19uILe2CvEqpkoeCjLLtI8O5vSgjVnSG/xrbl5RSqhj1Lyz88CchuNtrVS?=
 =?us-ascii?Q?xQ2uxfNJ73PaHkyMF64P5z3N3XcWIJMflvQvKNcI51XVDFFrHccxMRi5PyXs?=
 =?us-ascii?Q?q0Hvbczdwf1ovd9+gmCg3vgvylk3LYw6lQwfQN3xGg2aDMUvTz4G4MxzwwiZ?=
 =?us-ascii?Q?niv8vZNs+a2zMNyUcHxdXjVTKshrWv7WVhhWZjbjIFLtAuOLJ9/vrpUYbFAt?=
 =?us-ascii?Q?5OgicSJ2jwMEI1+LTUujc5sdlXjh4b0aO1PE8qx3sn/yzJHa8+CusUf/Bv84?=
 =?us-ascii?Q?O5vssRv8292TVQw3Vj+PdGJXoHp+h9PSaP0BqjRSqfzijyPerpJ3rV3za5i4?=
 =?us-ascii?Q?fTm70ngL9oNJ2yqzuj2C2U0Qt3lT3QcABPtBJXSGcNDU9cJK+NvmPH6Wvq0f?=
 =?us-ascii?Q?3COdbQYpmbeHGQrU8HK2jWLRommOePJs7RKqf+oSfH7xH/yIj4HSYQ0ZJaTD?=
 =?us-ascii?Q?nHJs9cgJDiJj8vj7a83ZFzCdyufohoVLeCiqDLW6f9HOvEqFkCjO4otP2E0h?=
 =?us-ascii?Q?8bvlfRQPYXCsFTKKoYaz6ikApKYw9kTbkczgcqLTwFO/qbPtgbayRpdcKlm8?=
 =?us-ascii?Q?wNt15P+e3ranK6Xi9noXbQJNgnxYvyDUsuAjWfttOQewJW2cbD3E51uWZ4r7?=
 =?us-ascii?Q?ypDiYPQGw3RDPRyHRroVq46RepYkKuJoJBR2cp3CF96KAsVIKYk6WRpJBvZb?=
 =?us-ascii?Q?EeEdXbI06m02iWSoXBLAykvAnbfQrQMiNrcHqmCWZCUBcgk4SniLBq9KKvwA?=
 =?us-ascii?Q?DAKB/tKULDaD81LC6yhAsISqm4ZNHiWmprTt9s5viH8DCYo9PuPmYposlLGq?=
 =?us-ascii?Q?Cq3w7ALzAUE8meKWBGeDqiIBxf5eDerglP7HiQz6dm3tcyvDfsFlUHBNtTMa?=
 =?us-ascii?Q?mjt9eavOZwVouJ/TpPAEuMiotMSE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:43.3922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078d78ab-8c47-4606-a6a1-08dc7405f043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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
index 5c92c041d0bc..be39276181a1 100644
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
+ *	soc_pstate
+ *	0 : soc_pstate_default
+ *	1 : soc_pstate_0
+ *	2 : soc_pstate_1*
+ *	3 : soc_pstate_2
+ *	xgmi_plpd
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
+ *	echo "xgmi_plpd 2" > /sys/bus/pci/devices/.../pm_policy
+ *	echo "soc_pstate 3" > /sys/bus/pci/devices/.../pm_policy
+ *
+ */
+
 static ssize_t amdgpu_get_pm_policy(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-- 
2.25.1

