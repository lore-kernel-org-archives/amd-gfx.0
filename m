Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D60C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6EC61C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6EC61C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901116ED90;
	Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97E96ED90
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay079TOiJa0nXz2YYtW6KLsok/dZwgXZdTvo5f2Gclaja9rT05nOqxvD4MsaSc+flQYNU7qUH1dcnc1pg0h2IjU2LTeEg3afcR6cuOFw54t++2yKfShthuHF59Lr3apSDvNj48OzjrgVrg7l3E4LZrxOLeA1sYP0t+Gpl6elt1p+uMoqfz0w4+Iccmc9ro4HKu3KbRImPQRvhFK1VC7pKPqGAGQYiQ32s14YIu+T8Ii0n7mYb6EpNYjjyuxrtrhhJsWNuGeRfm4buHOlPqihOgH3f2ZFs9DeJxYOYyNnQsmbAypywp2O48lHbmLklil2RYpJHZc6aweVWNIg/Xsisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH3S4QAanww7qEDxlIzqB9o7KiOdGb4TDwQjeEzjMmo=;
 b=CV3k8HqD3j6Hk302bVHkyLDUxxMVlBxfr3Hed7a2vRAXzwzPvw+cUyhxkm5C0vPYbci8OnsCjFtyvCV5fikvZZAoUhIwLYvico4Unjo41t1qHcO+szjIUAxZC+uyN8XRkw8VPA7LVz+lgySmwGGrg+XleJPdZHN6IkOrbVkioH3XM6jvIWSmxlJFY9JueWkKxik5tZ/QNLAWzpCFaqA48PW4FB7q4kYCUirXQ/6PCHUYyZdQHfP+8sNAsvGQkOOmbSMnGbq4hdzsIxE8D9dpFBnUxQnNdshGAn85VtVFdsbu1ng/7PULFApHfuu4no0Cho5JgcQYIwMhE8dzjtLKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH3S4QAanww7qEDxlIzqB9o7KiOdGb4TDwQjeEzjMmo=;
 b=UFxtMDe9PII5D3B4kAl1g5cyFo8I2l8clfCUroCGW4de4HaXuMgFZhXa/Py8WztMyMUDDnvNcg20pIPUdVODr3NTOdi9BvMhkZZkLE4z8wjQqxCbVIzxRfcMmna9hw+ROiDRwICI6YY4QS7s1mBpci8F5B1LDzEJd8A8xaMe2Vw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/89] drm/amdgpu: add mmhub client support for yellow carp
Date: Wed,  2 Jun 2021 12:48:04 -0400
Message-Id: <20210602164908.2848791-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee81bc7-da9d-41c3-0ac1-08d925e66d11
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063C9AA941215ED0093EFAEF73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clssbvxmEuHNyrhW2Xd0qSWlv3fSXtvBKQMq3UupRL1HnqZUYZCfhVRP8USAYeglUW450oT8+BOPVvAz6F8w82dpvibAuti+TKQ5nS4aFP/3Z4DxkLOhBUGjRKSHqlAT3xYXjMBbJebloo/nyLhj2a3p1oOy3ufjstutVhgaMejt8iOMUtWJiDB/weU3DYn0ZU8gSw0Qja4jXvfUa/TDL5mqZXOsydFio/CqpPerkxkGspYjlbSPrmoDpEQrIh+Cs5cn2nUwGar4Sqis3c3tmD7shaKAsB+rsK3boq1H59+77N6eQKZVQM+O2CU3KNssjQPCBkn5KKxj1F2x6gZKHhJCWh2/gM09WTD+i9wFTpLjv2qO2746ejsxaSVz+t+DHqtaxfuvI5IPRJvNmXa9H2vZv0F4Go/iN3/UaXgkT9tytyzQTID4972WxdJDutld6GcqH0mSoiP3Dv1+b5i2p1VmHXsQaNBATgSlGfI3kvvuYcdM2GMLUvHRG8X8RBDuhqu6cHxFTDJR029hE7t91xVFYB7mUq83LfymJppUos4FGULWlwkgQUnDhLiMrm2+YKkxKLUpEYioRxfqSDY2R9EFeeClBPhiC2DEmz0cb3nqs47mfuiuap/FkGCXcq2R6UjYwJ3IjEGDKA/i4WR1kWVkFgpO1dfu8ScUb3TID64S1t47igpTO6NVuPm/lVtT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(4744005)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hMNSD0pAGu2lqvn8nFFc47Wuoqv2pohbTePRDkM0JMta6gWugCxP7hNkA8xv?=
 =?us-ascii?Q?3GrQOHSB5+Q16qCgGoH/HVoLX0IWiQFQp3M3wyP8+Tnl2+MkeqGPuwQWwIe7?=
 =?us-ascii?Q?YTzJzV+GbcqG4x/OPelHywScUngJ34m2WrulHnqEEs+jxkq+V8k/zuabt/fi?=
 =?us-ascii?Q?Hfk9xyQWVEoQLu/7OWejs0sDVS1yTASC4BMPq2TzCarxpIzqdKgQSmqsnzQ3?=
 =?us-ascii?Q?I6HtTHB2vCQphAkXGriOLy3pz7krESxY+0yLiYkQAAf5Vorh1iAGA27qWpQx?=
 =?us-ascii?Q?SSX5Thj6RVUz2/GbiNupP2y+BckqLw+x2kwJnx7MIbfGjTuKZqSp+HSX6/tl?=
 =?us-ascii?Q?z/Nadsuyq4wptQ8iTGDhWzDBK3kM8TUX2skibOBMXPDw7p7IRw008myO+Ol2?=
 =?us-ascii?Q?WaBSKq8TxUpA4dcfna+biyXf0lpJiaNgqlGTBmAloba1LbLo+hpZGuIXDmVL?=
 =?us-ascii?Q?McacvU5IZPuNQ/5jfo3TAxdnFuBtQIisUjeb/pp7cBLXiUUyvGE77qXPeMEe?=
 =?us-ascii?Q?FsQbrLqXR9fdOdN7vvmaEC6j8IFwCQHjoze27SpEdD+3JB4VrqPVljr6cDGW?=
 =?us-ascii?Q?F/Vds0iG5TmN8PklbcyNF5qLF0n0KbuVR2vEQFkhn0ESroVCDOBqqINLwRZx?=
 =?us-ascii?Q?3egfUZc8V+oW3Y66CGRjgCE4FYjUsZcmQP+nkO7hNBNfJr5xDK1c6Kr8JHOx?=
 =?us-ascii?Q?ilvpEqDPQTdk+Ovw2xhTiO92aA1WcGgMG+yAzw386MWZfyJ0Cab9bpdzfV3y?=
 =?us-ascii?Q?5Ke30dfSCgzHRHhcWGDEtM6oKe7xdRUIVU4HRumcAjQGihrLPNzpuvaXzSme?=
 =?us-ascii?Q?uP5M7BK5s0k8V3ycS3jj/hFoZIyEJm3TqXOGLZBZw0xXV5a8L13wYVgPpQcn?=
 =?us-ascii?Q?Y0imHBRuxrY4Y+4hBgQ5NQPugnb2tgUP40uqBmh+pIt5z/NTq+ORDux34DI6?=
 =?us-ascii?Q?fId9Kg7lKR6zuzX30/1kttgE63jCKJgZwt153AFavbpzhaSMjT375IPqf2S6?=
 =?us-ascii?Q?Wm3QNUNQJur+3mA/jZgduzI/LSH4Gq3Af+dE/izAR0RNhjz7QdzLvK6Flf27?=
 =?us-ascii?Q?qhmAvYbATdqnQVuaG1iIPz0Fh3mR+BarReF3AfTvjtQgCN6kWKYJcuZhcrfP?=
 =?us-ascii?Q?igFX4pU+fpYD/mjtAE8BpHcm6+boSZdU9nJ4SP7gFuvTU+je07qrTuLSoYa3?=
 =?us-ascii?Q?EoQzeN+ou7f/5EVUR8T9GgEVzbP0hd/mWXFZBdx5pM1vOhx6YPCOBO5Yat46?=
 =?us-ascii?Q?spD4ugwg1iOdT8cymYngOLMt26qaWjeV7vXtDo0ddpX5tsTJK3taJXTNUVpK?=
 =?us-ascii?Q?Cg1OwroX5srp+xV9A9eGTx2r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee81bc7-da9d-41c3-0ac1-08d925e66d11
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:45.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrybY9YD0M856aExdg5phJvinCYlqhLic/iTlNs0wLXcCC9Kmtm8HuHbcOCwYPdksSi/s0Sg+GNj36XN8Ucsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To help debugging GPUVM page faults.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 709ac576ac7e..88e457a150e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -92,6 +92,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		status);
 	switch (adev->asic_type) {
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
