Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA4C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 07:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A17512BE81;
	Mon, 15 Aug 2022 07:06:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFBEAB720
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 07:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkWrWDCTVgOMBpUEAx0oEvKAAL1K2tBwDpaCrNNVdcGX3pi2MkzHrTi5cA+1CdsIh9M4KztOIiqANCBxqIOJ+tPFFZtgi78LUbD+RgZ3x1kFjEIh7otnTzHUqzj8/rYp3BTnpgUEChr8jnZF1YO397WVgoGXNrjgvAEnSyerG4wslkFq54r2ScttE7ChpHGWBive2hIZ5pHhlQkQcadbVBWab0Yj4q0asqW3zLRC+wP+pIaLgkA/Nq7u/0D7yfoqBORbzNstuR5c6cOaG8LsbA35xOXd5pOtzeyR65Tkg07kzC/tpQaHG8zxF+WpLIfLefbyP6qBYPPiednBj2qxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwdRQnXNW0rqy0cS1NcB8OLzk+FJeYPgUHZdvWXjQm4=;
 b=igZ7FfF/jwXKjTYMBQaBJoNtB67hh1Me/8Wm1eVgTgin/Tv4Y3wKjKQhIZByfIOZFdn8jC+5ujYuNSRjza1Kt6lI8oqfAySsUwZPxjsdY9McvbXPs8K5YXQIft6YbZu9hDZDVDKIbWObc2dEMx3yqDBfXJp4fX4DxtFF9A5SllP1jfwtpnFUQi0uWsmi2n6zNC+EFqGsN/1V8TbyW1qQKPwTJOD8SIFqXRV/gYuKNsvSlQeoCxNKkcnZKG4VtE+FYuh50bBnowlJo+x+yxsDFmYXRM47b/4IGUNAcUBPyBjsqUZP4yL3wSspRXtHD1a4XvZyLQ+VI6BGoNLWFyKvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwdRQnXNW0rqy0cS1NcB8OLzk+FJeYPgUHZdvWXjQm4=;
 b=SOxM0bNLXmNrQUkQC92Q0E44dv209NCU+ZwxOJJWzmE3bNNVy7/ESDEfHcJyPgNoRQ4MdoTURWDAapLz4aVyGWE4Fn6aGmAYSk4CqAOYBDpIwYJkynds8x0jiEvkAg3En8FWyPRXU+9XDc8V+VfSflai+wjEFnJcSRkjp7fCm4s=
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 07:05:45 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::38) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.15 via Frontend
 Transport; Mon, 15 Aug 2022 07:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 07:05:45 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 02:05:41 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: TA unload messages are not actually sent to psp
 when amdgpu is uninstalled
Date: Mon, 15 Aug 2022 15:05:12 +0800
Message-ID: <20220815070512.452430-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4767ded6-5c59-4e76-5f03-08da7e8c9339
X-MS-TrafficTypeDiagnostic: BL1PR12MB5850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /09qFK4O3u30IArOUBPdYOHvN4bws8OnvfISsMuquYZbXFMvmZS9+h4ymJtdycjP2CnNekGggA7z3WoPA2WcDyDCzzn18uVwAtesEdA4SkMS4zwIzwKKw+/862+Vv7um/M6cNReI8zwxf/7rnaGZFRnBrP3B6gN7R1yUtloxlLU0/kK3fYoMUe9B2Ct23VJVMS1iIRJsRUgTtskXKgQ8mO2rz/r1bCfK16NpHzo+/8FHUrtypURdxMhgZWrz4Euv+bT++hTReB/cNFwew/eUSLwAAPd616Q2tDrW5whczogvCoypPVyE5IBOlLgMUDgxUgF1KxpcO+Wi9pjaXcDrBqJdqVXjdvJg9TNXyu63XcY/OEizxOclgYX9A+UREXCrzziHR1Eo0oOlXNIlMH42ZPHy9IVSm9WkHJ7jF/h3T5n7HIP+yV63uTnStZxuygWHpwPjEZV5hxO2+GMGV3tyfeNaxSrSw+7L0KHYOA/LWtUVHylfYBFEexPneNB+sDZ334I5upX6Xh7sJZuf8+r/ageVmb92y6JhvKiCKnrZQ1jOjrmsGwHGsBDbADr2qj8amdwf300kwYDgTxZWHf4iuWUC67l+RKoHCHddtU72LBTXMmMMyJL5b2nRWR4372Fy29SP4b9NYAn9BGMF3YpbNW8S05AHGBNNA6p1TiGtc9gwPs6fhc3Bu3E1D4Yp4DkmW0KH/e2eFpXGryUCWRFaJ57s5QXvbBrZonkkeEYClF0PIXVpyskpR8pZsKHLQv9ilVpBy8LrhTAuqbyIfNfuBSmAAhH/+4BjFM/FdBezXm3miwYp1Bz0Eg/4QwCvM/EqZJStvQOhs+F8Rh1c57A1QQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(40470700004)(46966006)(2616005)(7696005)(41300700001)(26005)(478600001)(6666004)(86362001)(81166007)(83380400001)(426003)(336012)(16526019)(186003)(36756003)(47076005)(356005)(1076003)(6916009)(316002)(54906003)(82310400005)(70586007)(8936002)(4326008)(15650500001)(40480700001)(8676002)(2906002)(82740400003)(36860700001)(5660300002)(40460700003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 07:05:45.5003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4767ded6-5c59-4e76-5f03-08da7e8c9339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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
Cc: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking.Zhang@amd.com,
 Guchun.Chen@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The psp_cmd_submit_buf function is called by psp_hw_fini to
send TA unload messages to psp to terminate ras, asd and tmr.
But when amdgpu is uninstalled, drm_dev_unplug is called
earlier than psp_hw_fini in amdgpu_pci_remove, the calling
order as follows:
static void amdgpu_pci_remove(struct pci_dev *pdev)
{
	drm_dev_unplug
	......
	amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
		->.hw_fini->psp_hw_fini->...
		->psp_ta_unload->psp_cmd_submit_buf
	......
}
The program will return when calling drm_dev_enter in
psp_cmd_submit_buf.

So the call to drm_dev_enter in psp_cmd_submit_buf should
be removed, so that the TA unload messages can be sent to the
psp when amdgpu is uninstalled.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b067ce45d226..0578d8d094a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -585,9 +585,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return 0;
-
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
 	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
@@ -651,7 +648,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.25.1

