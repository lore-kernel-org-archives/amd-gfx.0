Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E3C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6520164F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6520164F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AA36EB31;
	Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486A86E0C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEYu87HPhTZSPWQFzUedVKtpuKUFEs4x0CJTbia4azPw7kWD9J01cYe88GKbhRrPYJ+s6jGJLoFp6NWKtJJC95NbdyfPod7qu9EhDkCTl2HCBWCfOtBqLzYwla5ISUw6PL8z9q00hYTmvhbph+fzKMGTOa8PTGnsI/f8a0nWYilcqpz/AWNePuq3Br0ntwsnFXCrLouwxM6iGRX6JX1V6jJZ/ChOt2ZqS79IHQYd/rRk32eSXjIBsgMWjHMcqZUI5r5NLx2HFlQZMD66eBEN09RTKlheTItzWfrZ+M4nruB8vsCYGbpHZRyxbBDuMWiK32omL20htgJxBhWz+uu41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ywJlGg5NzFVmRYHNSLfI3JAkTA4/j0HPWhG6qLqB60=;
 b=FifJXGBK6lFktBftVIwn3N3zC1FdwbQdhg/3FAzKuIwB9LpZ/NxcFrR3ns+SW3LQRqitsGtcNjDVt1Zx5UKoUcm9f3Ecg6BQbUUdz9WtyQZZSyAOI1VdKzRfk8E2l1HhyMDVyYKy/HF+/AqOxQwtys7YVYVn8p2+mEUhZH7d3elZtz6v37GreRhjgLoyBlRoc/2yY7hXI6Ts8u9ZYq1clEp491wDhLeAaTM62YazrmMgvSxkaamp25+3SsdHtSIZRvqxXP7ojhlqzR+b351aKtq742DL3d4A1FTxTjoaXqyJBoxP4gTdPZgBUifhXhDVGBRkzcC8fL6DA4ahajaTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ywJlGg5NzFVmRYHNSLfI3JAkTA4/j0HPWhG6qLqB60=;
 b=Pngwk0XAcdPN2m/2e6WaW6Ni8InPrwxx60hZ8jCKJcOn+f4MCKC5WY0ysfnmok40GPaqXi4FX8EWXxnlbEUaGnqclJfhCLxV2MJW8nGWDgRbiKK8N4E0+hm+vWiBOh3oM9Z9+o3IKziKJntjXDWr4H869iCVNFRUcnuoVZgrnYc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 024/159] drm/amdgpu: Print the IH client ID name when vm fault
 happens
Date: Wed, 24 Feb 2021 17:16:44 -0500
Message-Id: <20210224221859.3068810-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aea65d13-1044-438c-0854-08d8d912442f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41742FD375F11C7510BEBD7BF79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRsQWwmEZwR9HPc1DQiAYD0NNv7+1Tpn+aNwyLttAWJxQmyYhm9hew6jwtPMAoweDsc/fFnPvM2COukHHp294yHHQ47UoBWK+sru20z9P0qF8GK58pEW4D//uc7FXr51Bha4MgsYklQ3hd2LsJJS4OeH0/u1pYwofBV/qhZ/1x/CtJQ2Fuo+NsGM9d9sy82+kCbZpQJ7xYsnXl+RPJiDS0+D7BPAqYrLxk58LSwKUqPn7HlWHamo/EFJAnB/iWgpxOzlWfaZBs7dOo6MHs8IByIAiNUVK7LShFJ/PzeK659Xy254agCpqxlnWYn+cf/LgiMNuHJx6hUKpMi5JEag1QNUzwGxfblYTPsFcvBOreN6rYcAtPp/9nzwS6+T8PlQeXK17WZDgQKYB23fe0aCL5/yb0y6IGp7w/I7VpivfEWGLz5GSuIydnVB3Qo6E4vIBFAcyQ0cDVwJIi1tjAR25iheUk/c+tQyrIklvlSl3XMWVt2a8s3OqxtulTK3pH4v8fwIZudlVFwoLsk7fX5q2ZXvfn2vVUhgBTXixsVhSD5oN8TKQwubNaydEZrn4gDtVpyKMEyywWEuUkkOogXQPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EPI+w3HUBuznF3f03p+RnURKLXA7z9VgFL59t9gmUSqN0znNZ82mge2iMMv+?=
 =?us-ascii?Q?XEPG4SSaKB8kF5P2UDXECYe1Afx65jrF/PyEmSFh/PkQMTJlT2IL+KN8lkU6?=
 =?us-ascii?Q?alyRSCB3tdcCRsgIofwj8H+HU/HulWh0mFslhp182CyNSnIkQ1fX0mMC0JWS?=
 =?us-ascii?Q?XDHjBkVbEDG/hosKBvv5K53xiYYFj+6LuuLleZowhEba/3HJzTCuY1oROimK?=
 =?us-ascii?Q?+3IIs4ye4w0MxSvZhGW9rZipThrQlvy/G41YHLvqfP4O6PCcZoAmbDZ79alu?=
 =?us-ascii?Q?8nlyOpsHot0Tn17zSrAvteD3fYfXzrj3xyWRlhPewmthge0Qr9dXNtxw0w5u?=
 =?us-ascii?Q?xvhHwDZcDwRnNE7ZfHSj0hCbVMXlK815lFlY5oKEXFC9GHuEDVEzNYmAfUyx?=
 =?us-ascii?Q?VnoXEzGiUHqd4xd5jY1v8po+iGiZZa4nRFzM693jBcwM387altIj71NnBNKJ?=
 =?us-ascii?Q?STqoPH0EBxtrDi7yssGtCqO9W12fpvgISKtkMx6XJW+7uqDmfxVlO3tpmgLj?=
 =?us-ascii?Q?LOTyFhhSmDJ1eEVsjjGXWbULUfFrEVBqQDS1iGhHzFy/It19UZed4wTEqMDA?=
 =?us-ascii?Q?nvoW9eh0XKhRLtIVRuHeasJCBiGF9K3chx/wADerizZFmd3QGZO6UgCpuWPH?=
 =?us-ascii?Q?f6Aczs/IoPLOG19gI4oaqS3lx/gx/yGmzYj0uxc43aiAOAB9moCsfRmq0ZJM?=
 =?us-ascii?Q?J934imPZepgwCyvWGcSM9DlwJd+rRuQewGLx43YDf5SdRY7xIvhpswsE9+Oh?=
 =?us-ascii?Q?kJ8ke7x8H12VbxDoNLU5ol1gdBalUzYWydDSLKBYH0LdzSoyVmj0IJJfgqxQ?=
 =?us-ascii?Q?OgzzzXKb9VMq0CPf3NN/9XBPP8EMSdvKw2xSqJCIMx5cP4olBgz0CEyuoQLA?=
 =?us-ascii?Q?bg98LSSCSi+qX1D6DDNtEW8uwgXSWi+rFu5KPukTEC3THVCtUIiCZRbbcv9n?=
 =?us-ascii?Q?F7U7+tQSeHRz2+lHYtWguQahZCeZ6fACB8mfIjehWesVBV/y+X5IOaGWoRlD?=
 =?us-ascii?Q?SDq4n7jazUQMk8ZGEmzxn97+xQJJJiOfy4Jryb2wIul5f20pxymmfqlBFged?=
 =?us-ascii?Q?Br2pqlNfqkG6tDDO52u7Xg++RNvth/Zfx/NHXwgnmdXUAKVEVzuZ+yCixQxv?=
 =?us-ascii?Q?82ocKV2yaZ6lMu0klO/sI1as51lG1mVfYnJdJugU2yZ9WB5+ZhLVLmXhTP0C?=
 =?us-ascii?Q?FNuGsnHf20LH57L8UulF/hQoaIRIczqfXHxkFGEx2T/zYIoTCWVpBAW2q1a7?=
 =?us-ascii?Q?S6DpOLMAeeC35WGuD/1UD9J5todR2AiyC31X74nE3dUEqD664C1yq2xj0w98?=
 =?us-ascii?Q?o+CA+NUlknpQR8zE1L4h8OW+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea65d13-1044-438c-0854-08d8d912442f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:35.2304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNlOqdFQyVonunkT+bk/cK2MBem8puDiBxq232YyPA77UX3qhrPS5DE+88DMWp5tDLKHxO4xUYR+kwXxqz/FKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yong Zhao <Yong.Zhao@amd.com>

This gives more information and improves productivity.

Singed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  5 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  5 +--
 .../gpu/drm/amd/include/soc15_ih_clientid.h   |  8 +++--
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index afbbec82a289..eea2bbbbb3df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -65,6 +65,40 @@
 
 #define AMDGPU_WAIT_IDLE_TIMEOUT 200
 
+const char *soc15_ih_clientid_name[] = {
+	"IH",
+	"SDMA2 or ACP",
+	"ATHUB",
+	"BIF",
+	"SDMA3 or DCE",
+	"SDMA4 or ISP",
+	"VMC1 or PCIE0",
+	"RLC",
+	"SDMA0",
+	"SDMA1",
+	"SE0SH",
+	"SE1SH",
+	"SE2SH",
+	"SE3SH",
+	"VCN1 or UVD1",
+	"THM",
+	"VCN or UVD",
+	"SDMA5 or VCE0",
+	"VMC",
+	"SDMA6 or XDMA",
+	"GRBM_CP",
+	"ATS",
+	"ROM_SMUIO",
+	"DF",
+	"SDMA7 or VCE1",
+	"PWR",
+	"UTCL2",
+	"EA",
+	"UTCL2LOG",
+	"MP0",
+	"MP1"
+};
+
 /**
  * amdgpu_hotplug_work_func - work handler for display hotplug event
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3b7c6c31fce1..58352ca3d4f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -152,8 +152,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
 		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%012llx from client %d\n",
-		addr, entry->client_id);
+	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
+		addr, entry->client_id,
+		soc15_ih_clientid_name[entry->client_id]);
 
 	if (!amdgpu_sriov_vf(adev))
 		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d9f4955f293c..ff4a2e0a1ad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -521,8 +521,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
 		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%012llx from client %d\n",
-		addr, entry->client_id);
+	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
+		addr, entry->client_id,
+		soc15_ih_clientid_name[entry->client_id]);
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
index fb67bb55ed79..e3088c10bfff 100644
--- a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
+++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
@@ -24,8 +24,10 @@
 #ifndef __SOC15_IH_CLIENTID_H__
 #define __SOC15_IH_CLIENTID_H__
 
- /*
-  * vega10+ IH clients
+/*
+ * Vega10+ IH clients
+ * Whenever this structure is updated, which should not happen, make sure
+ * soc15_ih_clientid_name in the below is also updated accordingly.
  */
 enum soc15_ih_clientid {
 	SOC15_IH_CLIENTID_IH		= 0x00,
@@ -74,6 +76,8 @@ enum soc15_ih_clientid {
 	SOC15_IH_CLIENTID_VMC1		= SOC15_IH_CLIENTID_PCIE0,
 };
 
+extern const char *soc15_ih_clientid_name[];
+
 #endif
 
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
