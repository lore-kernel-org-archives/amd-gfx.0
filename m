Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B911C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 05:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C215010E387;
	Tue, 23 Apr 2024 05:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4vLi3Zq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6BD10E387
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 05:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlSyKlgPvhZglcge1nUDHikbdGrKuA1+Zsd95HkE46InSmHv9BTWNAZaeAmZK/463x00mAvK7IrpfPwr5x2PrnroWdIZ+5RD5aT0Ihu2Cyj5sdX0eysfhr1wGPk4zAx9K6vhGPsMzH1uyR+UYuPYKx8y8seJa6ttj8VOwCUqW5sjxXsahkMVeWTaKq5v2LO+yb6W9xrBdpEb5F43oksa+2wd3JhEoFu/oD/HXhKKsMJZBl+orrevJgc4OweeKKYtCmx29zyA/sJeD1dEwFGx8Euc7jrCwuRqXF2XA9kXhYUUQNVUN7OZ4Kn1KbMLBrd2szasQ7VLFCcMNUjujwCaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnYMbzK4HnHTm/Ag/cdUUKYJMid9nIpK/mEhPBtqsSk=;
 b=jnPWl/n0tmlnxeWpoXsg3hOWlIFSRixWhTNvHqwOzzmVGgitFypTp01yzqHfyDRh0n8yAN/R6inpeNqSg3aUPSQpy+2G6k4tu25ZY+eWTc7CfsYrteEMKzSJJ7kEMOOWD0XMIR/J97Ma6OnyhiyLo5edNtvGX/ugXej9/E6DZAMmFrRHdOJ/WZjscKv3zfr92fW37JMvTqb9Et6/8b8lpNg8wJyFpJxTlpcXiFld1yvABM+qQzihcA7ClUs7RsUXaGSUhqp1xjehT1a7CSBNAaQ2NDxJyOJmfthZMlO1KPmspQIS/LSuiniCVOOLZQYAJFLgzYgw8ADm9AU4DQAOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnYMbzK4HnHTm/Ag/cdUUKYJMid9nIpK/mEhPBtqsSk=;
 b=O4vLi3ZqJMN4w4bHf1Ee/CHaqjQaR/Nf1sYTP7J/WcvZf017dkh5IJ1mSSi1i/Us2kuLiNbdRgx3u+2s8aSbstIW7wXyOYG1Mu3DYX4Ly0Rpj1nUe6XS00pWomZnIIuk5JfdOcuj9ycrvhVR58ZS/dw5oM2sLxMnYeDKpCprXX8=
Received: from SN7PR04CA0189.namprd04.prod.outlook.com (2603:10b6:806:126::14)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:32:43 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::98) by SN7PR04CA0189.outlook.office365.com
 (2603:10b6:806:126::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 05:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 05:32:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:32:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:32:41 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 00:32:40 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings
Date: Tue, 23 Apr 2024 13:32:39 +0800
Message-ID: <20240423053239.884297-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: e4da3f81-004f-4087-3540-08dc6356cc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IZN7PfzbPfA103lJlBP4UrtKvvKPXjGMNB6ZIOStGOsSCCjQeCgnbPfAZQmd?=
 =?us-ascii?Q?WLlqU48RW6zbP2g37vRG3uggvSBEJTvRUCIbDxHhTwZn+sedoGgH5wu2GXfp?=
 =?us-ascii?Q?dP/GyIkbsL2UL0aeGukSBbB0vpTXCtCrR3bw2ylNm8wo3+K9yxHh/eZobwjQ?=
 =?us-ascii?Q?sSF7KcIoROO5OTfqu0vZNBIJbhq32Lpd6jy3dRfp/DgehT5vmay4DklRp6Bf?=
 =?us-ascii?Q?shVIoL9VxERv+s9sX1rO0mNf4Kk3w6oo4w25KjRTatcYocQ0q/D6n4RmLs/W?=
 =?us-ascii?Q?QzrJEvpE5tL7s4KG8FHfA6FqZmUQPnO2y0HrhYh53ztm0n+QNb3d6Twkb2v6?=
 =?us-ascii?Q?X9I45mxewH7jAu4RkAsLy8ewP0ttYr6Ws9oIUUe0O9/XzbX0Z1aS0ll53rgW?=
 =?us-ascii?Q?QgnRoTMXFMux89neGQry7VWRM9NEGvhqWTZQzO7TMc5BjqpXMb22+e5rirK2?=
 =?us-ascii?Q?8EjV81BDuDKDw9WpeT0Pu/oD9gI+Z3LqwCLmsaK3ruoZD07fsHn+mU8Ias5/?=
 =?us-ascii?Q?i1ds9CdTaonxv9T5QqoUddPQVVbbZQqsqwdS1tBvUdGvPAxXgYJorRGeQ+iI?=
 =?us-ascii?Q?JVkcKNpUVyIuOGArNCykqIoEsTN9ycZKyp07vHQkxlHF44B15ZzNdsRQQIgh?=
 =?us-ascii?Q?GIUSHan7ep8xQu42X3Vo+I30uEu2TCcHjBCXVY4/lUnzoGtgN3mCIYF1R2Ey?=
 =?us-ascii?Q?/nzH93nIPF3gzAcTGeR0wQutI+78t5wAnmeTRUo/6+0nrhy3Yv8avcAcnKgI?=
 =?us-ascii?Q?tspbYGOaJN1tloDaaRvEPmVbQ5WC8+qvJjSTQvrHVPOsr3NMKtep0k3A0lIJ?=
 =?us-ascii?Q?vSRffQV1kHcJV6ucunY4n1edy2eR9PVZ6UTzN/FRNe53tcngAEaTQUFsghBF?=
 =?us-ascii?Q?/+CuexIffjbz1ZIl1nIWpJPM2AbZXllQ1QNEEj/a1yNY2xg62c6lPKrvZlDs?=
 =?us-ascii?Q?3r4h83UCXvo6CWUEmEIHv41C4wAYUhNG+zOWYTXBu5T5f1sKQfMDC5wwb8FP?=
 =?us-ascii?Q?ST15NYKWPCZ6RwLBzCKRJKbhlO5xFycOY0+K7zK1+dymtdUKvOKmK0CfpOcB?=
 =?us-ascii?Q?rI+LbxH25OEfTIpiRg0ePLBWp1/Q7uGoCdCWRiyE5u9L2/7PydPTdTig0pfi?=
 =?us-ascii?Q?fatHYQXDrPQoB4jMNMY1X7rUp2mJ7TjLxKcTTFPi1tDVedPmM8AM/2YIXe0D?=
 =?us-ascii?Q?I086hJ/iawr3Kl/ci6LtdLrUfIPP6WUj61duKwxfz5O8DIgkM49/4MVoWs2i?=
 =?us-ascii?Q?L1/v241ht32HxTTaGMXvnYlJpgJjNsu+5fpj5mKd6wIinE0TcXyo6S9HMSeV?=
 =?us-ascii?Q?rbKulZ6pSwhf+pvD575HtTCa+T3DNrAvOWZafw3VhWhICClNe4CQVC5eetm5?=
 =?us-ascii?Q?qrI71y0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:32:42.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4da3f81-004f-4087-3540-08dc6356cc47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

In amdgpu_umc_bad_page_polling_timeout, the amdgpu_umc_handle_bad_pages
will be run many times so that double free err_addr in some special case.
So set the err_addr to NULL to avoid the warnings.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f486510fc94c..32e818d182fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -170,6 +170,7 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 	}
 
 	kfree(err_data->err_addr);
+	err_data->err_addr = NULL;
 
 	mutex_unlock(&con->page_retirement_lock);
 }
-- 
2.34.1

