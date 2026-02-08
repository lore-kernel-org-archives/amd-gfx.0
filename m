Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE67EF06E3
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C463510E2FE;
	Sun,  8 Feb 2026 16:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jFuHg7lO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41B610E23E
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNoLJyEQ/8K/jRLU/fChFiA8hrCXPkQbODF/c1/2+XZ2+tb79+QazOzAgKAGZOH+CmQLzw/O0ZVvmQVr4cI65XGnviXq/Y4o06GxWWeWALxgWdKm8AWG77dDINs7PG9wm2DdvaYqnCJy30EtduvUwoD451DYQOE77H6PutBt4yWnb/Z07cX2UgfK8xLcLPc4OlutWSBOMD2Dzoeh1g7b58hJhh2GNhm7nDUKzd6j1SopjruEKY8z7qWOcOo82g04gqfLHCOFZ+5ElJMJnmUP3bIykZMBwtX3OKl28+h3MrTakPzRa9mWzMTpLTlE8SH5xjxjc367xJUm8Xghj2Q4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0vGAAh9WMxAT0wRuje85x9fjnBPxgMYOE1BzLy1M2c=;
 b=m38lsTRzspzrxhWpLVykqwaZHoXUv71SlTS1z1MDA4x0mh//szE2jbp6iUUeH2eTaEEYWxja73X/Pwp+D6pCOAcBkOLqthbW1LgpC3W9gZm7VRWlY1U06RtaX0CAihwwT43cI/j7rCpkToTWV3nex+O0CZ4KTbJCqntKj5RaD7hjvU7u33bRi+tB2SXa7R98S9hnu29FFpZcXBW7F5QYVm48TTuqYW4EO3Gox721LgU80ijC0ifQJe4IQkaclhW5ffOza/kz+VLi5DK291N7oYrfLDXxk41mYeRpCWikxppADo6BUF3uzc1u+31uGdLJ8VX+hCzQTI9Cml46zJ24RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0vGAAh9WMxAT0wRuje85x9fjnBPxgMYOE1BzLy1M2c=;
 b=jFuHg7lOFBSPWHZWdEUicgaAuJVbEzIkxGvgVUeFPpTAndgCl9Mxkic2wZBw13dTIcovCKfOn7tQqoYviN6v+TIL6X3VkQjTSJuwpH+rSzIw+uz+J1+73vmltDYq6f7qT+LK8cO8W5SMX+5EIinvT9iwUZwohWwGylSKvgb6cQc=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:53 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c8) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 16:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:50 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 13/13] drm/amdgpu: Wait for GFX idle before PTL state
 transition
Date: Mon, 9 Feb 2026 00:42:12 +0800
Message-ID: <14935a0d254896bf8c9888f2624b6f6d7a103165.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b21db9-3da8-46c8-aabd-08de67313e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WGhO0FsFQXV+110b3lItVM34MZske1csrdluO2XiRaJnbVqIx/r8MjzXtwIT?=
 =?us-ascii?Q?EHuubPtySZLjXA576Vz0dYTGHdHV0qXBEOYempuq5xcb/X7eGgEzjjKpK7pa?=
 =?us-ascii?Q?nvduY4ckLYohG79prk22K0cC1cW+FTR3BvtJmWQRKl9/GOigwRoROMdN3t19?=
 =?us-ascii?Q?jtEZ9fh9YUEllvMgdqWp3sydohUnhu/j0IS7qWAJcK2IIzX4PtFk9mxgUita?=
 =?us-ascii?Q?JGgEGTwXheMb3ggEnlFBOuPhNzB2nSG8DH2NB+oQb2Bahz1Qsg3sGkVIe/vt?=
 =?us-ascii?Q?PY3N9VERCc5azoOgKeULTT2SptsZqre3UVfZTHmuaMvhOBVhW+z9vYHBMhuw?=
 =?us-ascii?Q?8nl3+TU4T/EE+ExwiLp5pyurxlBNBJgwwj3HCI/4JwOvovp6gsz21BgyC0BX?=
 =?us-ascii?Q?OW2EGEAvkXrvW8wUYB/ke8zGVcY1TduLk5WdSGgsWgYgWcdsXOFGhlfwRkTy?=
 =?us-ascii?Q?iGTWLY+Ss8+L6NHzXusK9MgDHQzHjXB+QbaHNTUu64/pCctniLQr3nECCwLr?=
 =?us-ascii?Q?K/WHhc2MW89RQKQzpFQrO8WMuDTuPv/FacALnwQZ7oSLabJmwGwKxnOYjhno?=
 =?us-ascii?Q?qimLpGoSC/pV6zoR2sS5yAa8y/8q3h5+CEDc/IiRvonSrRZxXKfWwbD7me87?=
 =?us-ascii?Q?9eBEZtjUcCqI/c7LKNth/L1wSnpUcMDDP8rbO8LCLZ8LiYu42/3G/RX4ta7B?=
 =?us-ascii?Q?Pdj5mV/AwGQIkZc3oIWA3uq32hLDYBlg7u3gWwipnGpOLtDRIllRnZ7i+skN?=
 =?us-ascii?Q?yuhEs6uEawoVSkqdNayPQjFyLDGDoVe6erf1VRxYo16kA/up0ZEM2m21cmpD?=
 =?us-ascii?Q?UM6pEqW8D2F9Je3/THTTgz4PB4mbtdIT5ne+limXn9rOEUU9aPb+RA1m5jdu?=
 =?us-ascii?Q?5+65KGf+xm74SgjzAl+PA2qdQl/3N5czhy7YebwY3E1Gzk+lD+gikTMOU//3?=
 =?us-ascii?Q?xIamvSFxWX/JDLDbdnWYIxQCrZAeekJwV0LBukP519sxlOAaxwhdnnKXnyCd?=
 =?us-ascii?Q?gKyIgIhjK5gizrHhnsQHc+6IKm464YV3JdfsxF8r/H1xFd2Z7JxCDhHrzdNx?=
 =?us-ascii?Q?CuITn5ZDRI62Y9ee/VhMF0ZiR539LwVAnPnG8ejJNAVxmyQErqcZblqo08d1?=
 =?us-ascii?Q?sG1ZR7EhnItTQOCzXWfwOKDhXk62pDWCt9cP40WbHBKkudBaxHECT+rDEiks?=
 =?us-ascii?Q?QaEuikULSwmRPe0O7hKbVBeThKE3UJt3MujUvJLu6ZIDHz9+QA/Z7E75dbLK?=
 =?us-ascii?Q?D5AV3LDcxmCgSEFqfVLN5kXaaXsr8jTIc2Bpry9izAUzypMaWEdVNmoSaCdZ?=
 =?us-ascii?Q?pA/uMACv4T6TrQAa7CPUiWeMvlkxJhZDo1eiPOcjK/dlxgMnKBdc2wVEa1sZ?=
 =?us-ascii?Q?7oczmkahtl3NToSX6V1X3n5eiR9c39WgidzBYbpaXX9iuIbunbyZsHkIM30w?=
 =?us-ascii?Q?xjUMm+5wsVboJ3pUc/4szq9A27OgTnBnVf0UEnW+jzxdRFmBvoMGMFr/f++x?=
 =?us-ascii?Q?/FrNcodXxRazlmk8NsPEeswGYxkOZoXRhM6dJCOUCASShD/exaUSWycz8ee3?=
 =?us-ascii?Q?M4ENFJX5p0Hg1yPipLId4EJYtWmgHfYqEM3EfBYzMsI5M6uWgYp0N4VbmGbr?=
 =?us-ascii?Q?dVjLbi5HuhN+fNOhSzf0JzyRk2zIBrKvKxozN41yhT1x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Nwx5JdgO0aejxHcd0bq3aY25a+VrnRExVc8Y0vIOgJMvzzyt24GxsTnYtrZGcHocsUPuBPxo5h0KAC2Q6llpCNm1FWtkAEbV7a5wBXklKaxk4tvofEe9KbT3QHiQz+JNl5rnORJ852X/bgZTu6QJnVwlWCWitgUi4U5Sa7YIg5ua9BArL2OMprG2gu5F8tun92HD3fNFnIAk2k6Bsd0bdlOHN53DcsAdWffYqijbuV5JTqNG0+X14rP6tHatssmwZj+kWSohD870qCK8hJqJAfGwu7LF/SQX5/x/nnyE+e1yEgaRX978RtGmKDE/bNqQd+NvmdLS1kyuLXhmJjFJ9sfgX9I4sNi1fNO0ntrI5iapUZElVm+vTZOjNIM18Ee0Qaa/0eRGlOFO7poOwKq9EUnuPbp0XkqXvg6M19nAApW+ofGhEUd2Sy7jSHM6Sh7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:53.1464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b21db9-3da8-46c8-aabd-08de67313e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
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

Ensure GFX engine is idle before switching PTL state to prevent
register access violations and CP hang. This addresses the race
condition where in-flight GPU commands could conflict with PTL
state changes.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 4498de4aa925..775afa1b4989 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1783,6 +1783,11 @@ static int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 	if (adev->kfd.init_complete)
 		amdgpu_amdkfd_stop_sched(adev, pdd->dev->node_id);
 
+	/* Wait for GFX to be idle before PTL operation */
+	ret = amdgpu_device_ip_wait_for_idle(adev, AMD_IP_BLOCK_TYPE_GFX);
+	if (ret)
+		return -ETIMEDOUT;
+
 	ret = pdd->dev->kfd2kgd->ptl_ctrl(adev, PSP_PTL_PERF_MON_SET,
 					  &ptl_state,
 					  &pref_format1,
-- 
2.34.1

