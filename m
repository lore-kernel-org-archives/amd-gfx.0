Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABB0C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 05:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D160D10E2C2;
	Thu, 20 Jun 2024 05:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/iutZqb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB05210E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 05:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP240TF2TBc4AD8mZDcqvcgcvPHpL9C0EIludxtNnZrX/GYmmij26BjicLDMxjS5s3BYAHGBLcynlGYDBzsRu45S/lieP3tPZerrQTipwEGzTiRgYVDtie9NmXTYGl8g+qXcE5Z1u/eznXfnyPx0mBavUrWiviutON6TaWZfQIKkUUOcQ6f1TjaRIse1+0u32jqWk7pHMoc2O4Rci8iyJI3/GS47cx9Vl982ZXEVgaat9dXdtVJ5FRVH+m0JaBYqe/lb8UnnYp0i7wfXlyIu85elUNAUYOvslcKyROZdikQSt3L3dW8/GgJK8ICMOQ9X8FifiSfA1fawyDOrDZH7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnNBOmalLW1jOpQe3+jWD9VHSuJt2RprgJVLEjGuOEk=;
 b=S/A5gDizUfN1fFdf5yGAzMqQ4Mba27353vJ5Emy1c5ewhrmz+9z4OV9k08mtgDvGJ0MXWXupLmG01NTNFTCOQZLUOx6LZSk9nqU5ZQ1GFjp3tekbtXYy9u3yN+6wsw0uNA8zIGsCwG7tISFwRB6xAyt7KZQB5MV49m+5UynwMP7A7fl9INr2YyNrd75PseFuBLDPS7Y4PC8cSfXfq/KNHBtmWSXvc53mrLGpNccg45ZRnPrrsRiZIypwxkxLIvV4PR/A57yIYmoTtZSIneddrhkr3khYEP+NvTTFXNnyNybJcTq1MtBiWQuvFT1rrP+Vr7JBrTkES0/nUbbwO0JChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnNBOmalLW1jOpQe3+jWD9VHSuJt2RprgJVLEjGuOEk=;
 b=z/iutZqbYvG53mlcnce3hOb63PCQ/9A06XSxgFZ/9xNRCjmlxtWp3enf8jHOJtvxKQ2pMJjleI48kycH6KIOgYzMEOUG8qt/yuWkZc8SqO7y7XR8r+ZeZ6SOm5+s95z0JEZzPn4aLoxp5oYoAUfFWbYk8Jh8F2kB/DNqHOQ0VBg=
Received: from DM6PR11CA0026.namprd11.prod.outlook.com (2603:10b6:5:190::39)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 05:41:28 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:190:cafe::b6) by DM6PR11CA0026.outlook.office365.com
 (2603:10b6:5:190::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 05:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:41:28 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:41:25 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2 4/4] drm/amdgpu: add gpu reset check and exception handling
Date: Thu, 20 Jun 2024 13:40:20 +0800
Message-ID: <20240620054020.434523-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620054020.434523-1-YiPeng.Chai@amd.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c1eb1b-de13-42cc-ec80-08dc90eba18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|376011|1800799021|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?grm1VILdpJTuKQPoUYeE6Vr4neMOTXmt089qYi0TVOi7P3opaLV3WjtkYlqW?=
 =?us-ascii?Q?H/gfA2X245sss4IeHU9+I1JH3CCWAwc+mGtjq2bHJXCTxP1IXTd2XVu23WWc?=
 =?us-ascii?Q?LRcbd1/eeBXfO46ywITsUpQHJPCIjiCLzhGB+y94tHRgvmK9WkTbOF/xTR4N?=
 =?us-ascii?Q?Jy9W6/Rr3agPIn2dmboHs1fK2q1YiXDPWSVMZht4aVb0yu+r9IAPbIspF9Xy?=
 =?us-ascii?Q?7w9v1zbkH1DDQvwqUsmuKfOCjSUpPcyXdIOBd7v7HE/kMx2Mvt0+jjX+/Sve?=
 =?us-ascii?Q?vj2jBKY6q/od+xXe5HGp1Z0IdgKRkl5e6JtolBiKHHHXVRsqoOL32QgzOyf3?=
 =?us-ascii?Q?nWNmPLttwAXy9TfQN/XPezwO40RoY1yvqJAqYx9qiIxxJ/4SuDEBBm+doVir?=
 =?us-ascii?Q?TCfiKY3v4jkEVSilEzHZTrFKx7bVDw1YHQQqFKgOp/q9/U0SgYV2oYbAxAlQ?=
 =?us-ascii?Q?AYD5dJI04ayjOkzfkUisYS+Dg1UBqBq0DfbwoMiDQ01WGOKcipeFjbtVyS3Y?=
 =?us-ascii?Q?SXdBSuKautfEO9riakUpS23h21lKDj+AJuDQI3TMklf9UitT7mRrt7NI1Qfm?=
 =?us-ascii?Q?b0C7JYlCNUCnMQAkCwZFM3gjhAAZ3tDHIUTcuaNvQI9j0ds8RPV+tU1XBMQ4?=
 =?us-ascii?Q?/RY/XIN5P50gTq11zir/b+BiGCfFfRfIvkAoKBURsJNH/jvIO/lhL1io2MZl?=
 =?us-ascii?Q?++kAd5PqgyMHusHnz65OXDmkEpgPnJmg0onl9218p4dNIQnNiF0Y5l1OXBOr?=
 =?us-ascii?Q?DdSpITbGOAVOHngfOcqU1/ugOfrMQA8Lx9h21xR4tR3DwJ+GY3G88cI6nn8u?=
 =?us-ascii?Q?SlwcRPUKtW1KyrwuU2Qk0T61rbnwBNtSBvLwcK8R9Tr6U1u708bBpJPJEF6H?=
 =?us-ascii?Q?DpInsh7Rh83ZK5JeaVpy6IGknNAbrSdYXpDYfWQmcW5b3j65ACBaMoUWBaZF?=
 =?us-ascii?Q?++jucdlwozawUDmAsjuw+Ym6/OeRYxzktIZwOCOEc1TlF+uWgJH4QMk7X9fR?=
 =?us-ascii?Q?UA3feZdMhOss5mDyZ26Y+nXuZHntcnTO9AvsNvC5eRayTrA5ABMeO2g6+pCk?=
 =?us-ascii?Q?uTbR0V6lOpvekAAxYL8X5JfhBAFSQoP5iZ8labCn3dXcNnvhTqAJEU6vdUKr?=
 =?us-ascii?Q?+a0bn9daPbPurjS9HpZuc/OvVBWxeIE1Rdv8/prZ7bgiKVCQ2iChR0HAij/2?=
 =?us-ascii?Q?4VgD9OySYmdlsSyPRblGN4zxnM6pv7y4ct2G3Zr8zsNSpeD+5iCjluRbNfiL?=
 =?us-ascii?Q?0s+Bxteg6ZYjvIPd23CZl0XbOglQ+FmMtzXg94wXBXwfHkArfQBXtlrU5CAp?=
 =?us-ascii?Q?QFwHUgfOEstnRplwOZFa8oroLhYeQzbMDd26i8Nb17tBb2ustXfZT5lslqOJ?=
 =?us-ascii?Q?EN9P+A3ov83TnelHvtBj1H58tGcNfn6I+BaCgYh0SsHMQtp0mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:41:28.1133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c1eb1b-de13-42cc-ec80-08dc90eba18d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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

Add gpu reset check and exception handling for
page retirement.

v2:
  Clear poison consumption messages cached in fifo after
non mode-1 reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a4030dc12a1c..ce7c7723e626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1384,10 +1384,15 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 	memset(&qctx, 0, sizeof(qctx));
 	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
 						   RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EIO;
+
 	ret = amdgpu_ras_query_error_status_helper(adev, info,
 						   &err_data,
 						   &qctx,
 						   error_query_mode);
+	up_read(&adev->reset_domain->sem);
 	if (ret)
 		goto out_fini_err_data;
 
@@ -2916,6 +2921,14 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void amdgpu_ras_clear_poison_fifo(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_poison_msg msg;
+
+	while (kfifo_get(&con->poison_fifo, &msg));
+}
+
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 			uint32_t msg_count, uint32_t *gpu_reset)
 {
@@ -2946,12 +2959,20 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 		else
 			reset = reset_flags;
 
+		/* If gpu reset is ongoing, not need to reset gpu again */
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return -EIO;
+		up_read(&adev->reset_domain->sem);
+
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 
 		*gpu_reset = reset;
+
+		/* Wait for gpu recovery to complete */
+		flush_work(&con->recovery_work);
 	}
 
 	return 0;
@@ -3000,6 +3021,37 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			}
 		}
 
+		if ((ret == -EIO) || (gpu_reset == AMDGPU_RAS_GPU_RESET_MODE1_RESET)) {
+			/* gpu mode-1 reset is ongoing or just completed ras mode-1 reset */
+			/* Clear poison creation request */
+			atomic_set(&con->poison_creation_count, 0);
+
+			/* Clear poison fifo */
+			amdgpu_ras_clear_poison_fifo(adev);
+
+			/* Clear all poison requests*/
+			atomic_set(&con->page_retirement_req_cnt, 0);
+
+			if (ret == -EIO) {
+				/* Wait for mode-1 reset to complete */
+				down_read(&adev->reset_domain->sem);
+				up_read(&adev->reset_domain->sem);
+			}
+
+			/* Wake up work to save bad pages to eeprom */
+			schedule_delayed_work(&con->page_retirement_dwork, 0);
+		} else if (gpu_reset) {
+			/* gpu just completed mode-2 reset or other reset */
+			/* Clear poison consumption messages cached in fifo */
+			msg_count = kfifo_len(&con->poison_fifo);
+			if (msg_count) {
+				amdgpu_ras_clear_poison_fifo(adev);
+				atomic_sub(msg_count, &con->page_retirement_req_cnt);
+			}
+
+			/* Wake up work to save bad pages to eeprom */
+			schedule_delayed_work(&con->page_retirement_dwork, 0);
+		}
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\n",
                     atomic_read(&con->page_retirement_req_cnt));
-- 
2.34.1

