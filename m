Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E1EC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524DC206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nl/n64uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524DC206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82C889E9B;
	Mon, 10 Aug 2020 05:23:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B519E89E9B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMoWb282ooRT8UUQimPMEb/X6DjEoi8ahwQIMQO2L+VVmYfGYoix22S4No4GPMRb8RV7ioHNcnd7awM2vDUbXezUCQIdi/lNcpXcL4IvjytlBIuWdKxaUKQ741DlW5wUbwIvdw0Ir29zfh99rDFV43dTKvu1yX/b7Lr7Mk8XS5FAIy22xZE34aez50BMXrBRPDIYfCOFJPVI02WKC3r+XYVzClYABH9cDX6245i01fuj3nhGBQH9V+/aIZAZ7g1DYtl16LSX35IHde9GjxJfmCJo8Q826NvYbd0Si/4lE4BXR6PwtTCnzzghNChhroRBRi0dUdY0/tvHAxpb+T4RHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qPeuKVOY4luriw3VLN3nku4N9HUmCszye3YKpJEaJw=;
 b=LbLQlemaufInP0wUldZ1H1c4nvV2eEbn5m22zQoCtW1I92nYRf2uEEBJwU4J00hLvCIoJz42XK4CtHlIfe0k0/DD1Bm/12HSkmhXCKMDPoHe0u8UgmkTmKCMOfx+avaI0D1OIm7AAzW+pYpYgyB7ZmolTjvKOGmZyTLrg7hhDT+T461VdJoUr9gDIaGAP9/2deRsblRRseYYk3zk+P2kSy4ns6RlxEOoFemIcHVKV0GwJikz+4BeP4A3rxv4BWIgqIvAQVFFNv+0RjAW3tJTFuiCQvImWV6I+awKp2cq4473udBQboRwCpfVVOBdCC0EzxPx6VkWxc6IL5BpLfbXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qPeuKVOY4luriw3VLN3nku4N9HUmCszye3YKpJEaJw=;
 b=nl/n64uQx2Gqy9ocWgddbX9lP7XEtqQ5yy2PUD59tczP/WebqyHFK+3sf/2ygVMPNE0FZf/ui9bBgcIikS83cl0qfxZ7WNF+N7JJimgGid1usKEq2ONrZDFuh9VVNvdyNoTlmJ7+BNcHJL1R653wb1qczhmqj2L6Jq+0s1TSriw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1574.namprd12.prod.outlook.com (2603:10b6:910:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 05:23:48 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 05:23:48 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 lijo.lazar@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 1/2] drm/amdgpu: bypass querying ras error count registers
Date: Mon, 10 Aug 2020 13:22:57 +0800
Message-Id: <20200810052258.27961-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.6 via Frontend Transport; Mon, 10 Aug 2020 05:23:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 160c499a-0fe4-45a4-3f99-08d83ced8f29
X-MS-TrafficTypeDiagnostic: CY4PR12MB1574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB15744A2A0AE8823A1FC85642F1440@CY4PR12MB1574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bkg+Lwap120Mf2LwTpeLqtj4/cybiXwjjgiNRQKpENz6EQAW36iQcaWv/dGcg/pSXCYGdKzP7rl+4T05oVcdO/HcCisNQIUvXKJCkACpLq1EJ/M2yNWa3ipgUFbVzsN6M7jjlTvzywNYcWKZNUOq8ryiuLwXW2qZgaJPXW0MZgmbrtnmU3JBekt5oXKtenInU3Nj+2Ps5/Pcd/6hgMGVsCUgWTA2PqrPzISWVZnxzKq4fMvZZpikJT3BrA5/8om/5yJRvfaKKxtURAVPYdE5joPgz36Ec+lYPg269VZ7njyrbNHPlW8916DgnFor/jeo3kCPGyeDIKl0HQmcjl6bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(83380400001)(6666004)(2906002)(186003)(1076003)(6486002)(16526019)(956004)(8936002)(52116002)(7696005)(478600001)(4326008)(6636002)(66946007)(2616005)(66556008)(66476007)(8676002)(5660300002)(44832011)(316002)(86362001)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y4emmjbMJX66+NOzub9mufAawBByrWgY/dTDtdC8JE9cRiMjQnzkQRGVyo37EhHn4asf1KVVtaSxBkVUBa8LtmAOdsYZCK1Jx9GKGHIId9wDWsAsWDJGObskUkijQ4GvLAQo89OyMkUg3o5gkDoO4FNX5Orbz7oEpuEFuBcMQxWjIpvWpiNIoaP6UUktHHF+0YHWgk+l6L9cmA0as61D7bIPUYpJz+VHZMvP1MGUdVAMOC/F1TSTypxRptEtcnpW0zyk1Hd6TkrRwYTXu1EBlnf9CpgM25t4ioels/MDxdShCJR/NooxZLHzi4RvGXRoHaNcpQjAUwqG4/GgGsM52FGBiJ/H8I+f33OjbVkS6tSyizsNoTPO2+1fQs0yO5mfE596L0BP9tqXwJEDtcLqztr8og3mr7bCn7ZFHWt4jMXF2gOy8bhrVriTmcBzta5+8e6F/9WttAaT1aSu22Zt3BbmSrfshYGachHJE94pkxIMomHDHvM9n46LRL5ZheZvWDsfwFW49X/TghoLm3RiUn6bGGoBgGOzUv80X8Lp9FzG2xAGZPy2G3qL9vRuf96zuuYn0WbBdXGyzgZfsaJckb5uxIHnjhNvo2fHTSmJX36OEhkRYpN7BPqGfdVLZafrvKI8Rp+4CyiJYpqPoiUaGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160c499a-0fe4-45a4-3f99-08d83ced8f29
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 05:23:48.2824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdTkBn5sKZvfbU1HdtkXQ9v5SojflOfdQ/szxNY0ENR6ovypDvNS+dlqxufnwjQ8QY9K1YlJH4d3wKDEAa2w1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1574
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once ras recovery is issued by ras sync flood interrupt or
ras controller interrupt, add this guard to bypass or execute
ras error count register harvest of all IPs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  | 48 +++++++++++++------------
 3 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 89cb0ae9da9d..e6978b8e2143 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1547,17 +1547,19 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
 
-	/* Build list of devices to query RAS related errors */
-	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
-		device_list_handle = &hive->device_list;
-	else {
-		INIT_LIST_HEAD(&device_list);
-		list_add_tail(&adev->gmc.xgmi.head, &device_list);
-		device_list_handle = &device_list;
-	}
+	if (!ras->disable_ras_err_cnt_harvest) {
+		/* Build list of devices to query RAS related errors */
+		if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
+			device_list_handle = &hive->device_list;
+		} else {
+			INIT_LIST_HEAD(&device_list);
+			list_add_tail(&adev->gmc.xgmi.head, &device_list);
+			device_list_handle = &device_list;
+		}
 
-	list_for_each_entry(remote_adev, device_list_handle, gmc.xgmi.head) {
-		amdgpu_ras_log_on_err_counter(remote_adev);
+		list_for_each_entry(remote_adev,
+				device_list_handle, gmc.xgmi.head)
+			amdgpu_ras_log_on_err_counter(remote_adev);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 70a6fca73617..6b8d7bb83bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -343,6 +343,9 @@ struct amdgpu_ras {
 
 	/* bad page count threshold */
 	uint32_t bad_page_cnt_threshold;
+
+	/* disable ras error count harvest in recovery */
+	bool disable_ras_err_cnt_harvest;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index e629156173d3..eadc9526d33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -302,6 +302,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 	uint32_t bif_doorbell_intr_cntl;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, adev->nbio.ras_if);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
 	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
@@ -312,28 +313,31 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 						RAS_CNTLR_INTERRUPT_CLEAR, 1);
 		WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		/*
-		 * clear error status after ras_controller_intr according to
-		 * hw team and count ue number for query
-		 */
-		nbio_v7_4_query_ras_error_count(adev, &err_data);
-
-		/* logging on error counter and printing for awareness */
-		obj->err_data.ue_count += err_data.ue_count;
-		obj->err_data.ce_count += err_data.ce_count;
-
-		if (err_data.ce_count)
-			dev_info(adev->dev, "%ld correctable hardware "
-					"errors detected in %s block, "
-					"no user action is needed.\n",
-					obj->err_data.ce_count,
-					adev->nbio.ras_if->name);
-
-		if (err_data.ue_count)
-			dev_info(adev->dev, "%ld uncorrectable hardware "
-					"errors detected in %s block\n",
-					obj->err_data.ue_count,
-					adev->nbio.ras_if->name);
+		if (!ras->disable_ras_err_cnt_harvest) {
+			/*
+			 * clear error status after ras_controller_intr
+			 * according to hw team and count ue number
+			 * for query
+			 */
+			nbio_v7_4_query_ras_error_count(adev, &err_data);
+
+			/* logging on error cnt and printing for awareness */
+			obj->err_data.ue_count += err_data.ue_count;
+			obj->err_data.ce_count += err_data.ce_count;
+
+			if (err_data.ce_count)
+				dev_info(adev->dev, "%ld correctable hardware "
+						"errors detected in %s block, "
+						"no user action is needed.\n",
+						obj->err_data.ce_count,
+						adev->nbio.ras_if->name);
+
+			if (err_data.ue_count)
+				dev_info(adev->dev, "%ld uncorrectable hardware "
+						"errors detected in %s block\n",
+						obj->err_data.ue_count,
+						adev->nbio.ras_if->name);
+		}
 
 		dev_info(adev->dev, "RAS controller interrupt triggered "
 					"by NBIF error\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
