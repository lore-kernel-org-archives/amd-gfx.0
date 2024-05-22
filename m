Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973B8C25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F84E10E622;
	Wed, 22 May 2024 06:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhptJfKz";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C7310E5D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJB3UUjok1JT5+si9DIUtbdpKG/unwczUhluuLk7uPN2ajNaUBcpAeIksPPe036p+Z1wqa+If3BEvDMlAOcqtz8X52GZd9ReqkgiQpf/62OO1Qte1Ux/uUgrkev73iS+WBWdfaIUw1yZhKo4PtSKQ3uo7iJCImA1gj+ZYZo1qZSaH3VwQpkX29rVlmVGx4UR7a1bzEjNMHSM8I/5t0kjuA35uKnjYYPHP2nCTN24GztDVWSX8hPjQodSgK1ibWQUptK0tEtN72c5tll9OkGFAlwTtXBNQZ/a1hK46xY6or5GuRJq2oJDeVQGEy5gX0l6i/QIb2UQRUT0++MaYWYAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaE0qctz4QcACD2bW6y8KFa81HmUnU6hkcN1YkLhSoA=;
 b=IHfslC+qphGYJ6gZijWG3fZDyzCKIMrNu3KnAn7hSTwhO0sCNVliklROPv7nClNAQE9qUXOTvIMFRRcu4qe5JMeEMYqRQdMRFjv9MFHgqmYJeRcYtfBKyMIemUubNpspdtC8lt8BHGdv5vLUsQeXf3II3LBg7nc/uUpRxZCE4gAEYmckBxKysCJ7LkUw0PN7XfGXzqyLmDjzpEpKQwFSHbCNv+ixKh6IX9WcDxWCuJ8G69ShCwWUbixlBPBqOKMkpHOzEoXwOfWBDzeDLFi4cLwQy8oPZFSaMbG9ylMtd4PI2odno0kZbcFcYcjykBdXLzYdlVn5zd8S04NysEZHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaE0qctz4QcACD2bW6y8KFa81HmUnU6hkcN1YkLhSoA=;
 b=XhptJfKzgDQPGkQg1ZyiKo1EglXUQa2otofRmMSYgbw6ZbQo3GYj2H6uBiCKYMyoVG5u/ZoNg+gCc4A7M8QD/TlUfa7KWzh+k0xOyJ4vfmuc2VmjMQOz7SyPneFIKDPd5dOaynDWpRRb5H3Hwptu1dSBcWHEXNBnO/aM7NEN2vw=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 06:31:01 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::f9) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 06:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 06:30:55 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 01:30:53 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Akshata MukundShetty
 <akshata.mukundshetty@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 1/6] HID: amd_sfh: Increase sensor command timeout
Date: Wed, 22 May 2024 14:29:12 +0800
Message-ID: <20240522062916.705147-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b4f484-1d25-4ef4-5774-08dc7a28bc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6rTcRUEnEb82Ucy9bPT4uTVehAp7pqARN2/KoG067SYrQ9VE3gwcwL2XQl91?=
 =?us-ascii?Q?Nkl5/vOD+1ctEozbmfkRpDDXzw+8NK9AccOYn8I65gXWB1tEOQopt1uOfbUU?=
 =?us-ascii?Q?WJRp+Eux0WUoMvH1xV+f78m7JJEojGimMF6g4hyeAWFSpt1J3uT4GVKlBxR+?=
 =?us-ascii?Q?RWi7kJG39AQxlwOfnNnVvBi0v6ghG7mf6WAlSNJF3AHOQrznVmX+LlLFMqej?=
 =?us-ascii?Q?IaUJ89QE2RC60h4sua2GRqiSJTsElDXEdx0K2L/t27/+S0rHgLmkiYeQVp1Z?=
 =?us-ascii?Q?bm1jLpRY78GuSbPfj4aEPk9BlsF6h+cost05O7770ZH/SYCIXK22yUDuAUkb?=
 =?us-ascii?Q?FXE56WYtSOmDkXlO55T7A8DudTZ03Tke3ocZO8HR/fvHvZmCSeOaWtwMjcWH?=
 =?us-ascii?Q?sqj5ZOWzvBxwfBHnJPiWtIgfSnnJ8lCRTlJ7o+MbUzS/G5KMRCGUftkNePx2?=
 =?us-ascii?Q?4ohb6NU4xX7Cej+8NyuUurZvagIo5F1ajvtZIGfTR9btvGd8IxGgxGMoJC8i?=
 =?us-ascii?Q?ET6PQIvtIf4+l62YKqPYxcZkBcfZo2pD9K2i4S/7OJBOKugF6Ykjn/MlwwBE?=
 =?us-ascii?Q?ZXHq4V19C5JTdRI1wIll7ADytDU59/zrzbE7NuW8sK/3QwmC74sa8xf0BYzy?=
 =?us-ascii?Q?9Qwm19umH5/sBH7MLUwdN4x/Zll/NMqFOD5JoqTh0eHF2GPKW9SOGFy1jr+i?=
 =?us-ascii?Q?MN+DXLmXe1U00CQMlvb+RHwV6aDudaGOV3/I1pidMiVJHEg8VwRw9oYjPQvR?=
 =?us-ascii?Q?BlMX5eCq60DVFWjzTA6AyWUlChdlEBGZXjthl6m74bOA28K12Aqs7uimGmft?=
 =?us-ascii?Q?0hg4j6sXetZ+XMZjSkPvSGosRVWakDqbXWfuhWQbsIeTVaE7YQ9K/8Z/4M0y?=
 =?us-ascii?Q?nOU2RSIwsZJTMMvHomM2cGpnFLhDcXnZvc0XmCs6/m2VupvFrkyx+E8NxAb8?=
 =?us-ascii?Q?Rjj9BSd7/I68Lwu2CoUHpCgiMmgj0NsQxIUmhLYfLboCT8eyPMm37c5wXKoz?=
 =?us-ascii?Q?iOSORUg3euWJ02R1/olvYbupG7NTIMK4JcX5hg0QIVSBLcxpW3BCVO3H+fvm?=
 =?us-ascii?Q?z+9hV+gIO3CIAwHKlWIiLoJ/e5GR0DVWFGTBZ+7qWQE54G0KpjuMq5HPRJhE?=
 =?us-ascii?Q?Bk31Nx4P4R37OseplxkRvwd1/i8uNgQ+B9uyGcS76qp1coDxlU7WwRYleN7/?=
 =?us-ascii?Q?6G9RWwxncA6Sa3m8qOO0v39mxtwn4eNNEy9kfnWX5Hl/QmBCj5nSL9F5BYW5?=
 =?us-ascii?Q?BC6UXfElpxvBsZSDdwCyPGuiJRwmaWeoWah4WH1sXM7XeuGmHGsm61hRm5a+?=
 =?us-ascii?Q?nnz1FP9Yt1mv6BIgNBvZ7/l8FJMqs25boSw/gka9qwc5oPIVRo0zPQlSRifX?=
 =?us-ascii?Q?56s1to7mat9bcA6StklhsjEyMV7d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:30:55.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4f484-1d25-4ef4-5774-08dc7a28bc60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

During the initialization sensors may take some time to respond. Hence,
increase the sensor command timeouts in order to obtain status responses
within a maximum timeout.
(Li: backport for s0ix issue, these patches have landed on 6.9)
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 333861f4cca6d2c959ca2876587c42767853dccc)
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 2530fa98b568..8a4cd793d021 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -39,11 +39,11 @@ static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_
 {
 	union cmd_response cmd_resp;
 
-	/* Get response with status within a max of 1600 ms timeout */
+	/* Get response with status within a max of 10 seconds timeout */
 	if (!readl_poll_timeout(mp2->mmio + AMD_P2C_MSG(0), cmd_resp.resp,
 				(cmd_resp.response_v2.response == sensor_sts &&
 				cmd_resp.response_v2.status == 0 && (sid == 0xff ||
-				cmd_resp.response_v2.sensor_id == sid)), 500, 1600000))
+				cmd_resp.response_v2.sensor_id == sid)), 500, 10000000))
 		return cmd_resp.response_v2.response;
 
 	return SENSOR_DISABLED;
-- 
2.25.1

