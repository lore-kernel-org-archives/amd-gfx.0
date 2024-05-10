Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C3C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D0810E187;
	Fri, 10 May 2024 02:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AHin7Ry8";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9CD10E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI31n1YjqnQ8caNFWmrWKZMdWPHSo+Kh4Y9rGq6sjItqy/j2uh77bluGRi4vMKlkhBf0s0ntJg1kowytoyKJnaWovNQgINY0T3Jo5r4n1Mut9fbyYERr8w3joWKuKvJbi3C5gMplr7Jx3pB8LcOkknBGPKKic9O03O2vOgZnPDYIgVLt9FhyUoxP+qU2VapAupxj6TyXCqbko7kF7eFBYXvqkKJYHfxA2eA1YUppQS7BjRUW4Bu+MXYqPMplm0xrNpWndJTYZ1J45Hbb6/gSRsrLJlpVH/sxNlIY+SeqTKEaAHiOsrPZVH582329XpawPiEeUDQ8rSwcJP5TzmU1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ZIC2dzzpsfnPUxINSxnVdv0SVEpA97fwyTUk/0kYw=;
 b=R2fCrn92mxOKk3FfLGLD57lKsawBXdQ8EZScv31JQLz/8bv0Jn797ZlxvptHd0iVf5BegEUfQLGyQB/jOQh6brjP95XhW6aEDCvEwwf3cffErokAxa7Nh1ag8llDoEj+XxmSKiNV9+0lLpGNzLrW18nPQYWuAbj2Kljc1+Bcc03BwkM0V47403SWvNA9/+8EGw7bzU62xygKYLXDl+y0aMtMHRVNRx+IvzNxoNq7xmwPQDOaZFjmLYAyNiWgnKswZqy0RlWp4ALSxZTHbOD8TUdV2nePbiIrdQDnYrirlWmbvfyIE/aN8KuRO5hjrqlgKNWq2J6g/a0tqBAbNhfRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ZIC2dzzpsfnPUxINSxnVdv0SVEpA97fwyTUk/0kYw=;
 b=AHin7Ry8y0GNFoy/kuSRDoCeojqkXq367x2L6DKUrl2hUC9h9r9FeU+LZPVx5V1qEeZ7Ld2frT2igcOVWF08XLltWukhnHTBLIBZC4xdcWsoRp7HPko7PHGjNksQup4l+GuGE4m2fKtRg37VjvTJK6g7dy6LxIERMj5UWzv7iqM=
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 02:53:54 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Fri, 10 May 2024 02:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:53:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:34 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0
Date: Fri, 10 May 2024 10:50:31 +0800
Message-ID: <20240510025038.3488381-15-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6d5f3e-a953-4c0e-35c6-08dc709c6dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zTb8U245flZRrlELy8DPIpcT65qE0ja+OsmQR92aVXaxwyZ8HmKivhjqf8V?=
 =?us-ascii?Q?s7D1rFw7bPi06Rr7vFgyfL5rJzpNQEC2EP9omgSBjRPjAxkik99mxXH3/cnH?=
 =?us-ascii?Q?Liz+bg9UDCDHcgPIEfH4vzTGlEiEpTVB9vTBqonYtFKvXVEUyJuBXJ52yMt2?=
 =?us-ascii?Q?0EQzYtiHoMw1+kSFKlMPcRU7zV+ZWxhr/jHeouTxky6+AKaiSmW2PiVbZuiR?=
 =?us-ascii?Q?iBJTvzwFmOM10lwLGIhfLpT46G2UfJIp39IS+uadj12ZfYMbp64TaDwVU9MH?=
 =?us-ascii?Q?A6JdAzWoQDyCpxTsFbY6OSq4DOKUV0s8bNu6iQjioSJmMKC7IC5UVwUSrHYw?=
 =?us-ascii?Q?wIOtdLFIwCskKHG0AzN0XnZeIb3Ne8BZ2FyTCsn3RlvAd0jzCu9VYyo2HHMD?=
 =?us-ascii?Q?Sm6GsRuin+r9kMHm+7cDzkanRdvstMRZYh0nOSvUUZcMhook5AQd5NjjC4VY?=
 =?us-ascii?Q?1yuUSnf1j/2FmPvu8i523ZKX0TA2OgATJybnLth7pD2wjdj0YRjfLpbfHy34?=
 =?us-ascii?Q?SnmIvVYgzynmqAYhzStQvMBVUHHJO7nhtACNTS2bdl2hd9yhQLYbyvBynDn9?=
 =?us-ascii?Q?zEkIl1r1vOSFylaqwnXcUrjAzYZ+/z1Gf2OB0vaokb5jbqQg9U9blbtt1wy2?=
 =?us-ascii?Q?IRBt9T6F+sZj/hXnDK+kvHsnfceg/4tyvsd3e7Wff8guosGO2qkummQQ/kYl?=
 =?us-ascii?Q?BsnOf20abpSjmbYefzXCzj1UiYV6X3HsadKSndLUZT/eiLbHjy8R+IBGlJOq?=
 =?us-ascii?Q?FY/uA9UKrks8+Juk5GAirl2cppULUxvwJ30cf6XwhPyuHJJNfRo9DqPYLoru?=
 =?us-ascii?Q?oPIdpQpGFaqmqrHEeNZI+K0CUxMzJJM/ykyoYbmJy+k5hUb56ErDc3tcJb9C?=
 =?us-ascii?Q?fzSRYCtRRIlRpl7yBiriIyKAGxOkZNoaDl6Xu+TfJo5Wib/FqDuvsJ1A82mm?=
 =?us-ascii?Q?QcLRqLsoTV1vUL+xTSbyyE54ASMbdDvFw3QlUFUyrObrhA12kB8xfhw32hb1?=
 =?us-ascii?Q?VJTheWNNsA3VXhmbSM73yZ7R/50QrX2HeonJ6H80JVOGoGgNejeb8DWSd3RR?=
 =?us-ascii?Q?jcMw+XuYFxC1CaR/d3sJGFc1yJsspt6fRfU/TfUvjGiUMBZgclZAgdz5o9rZ?=
 =?us-ascii?Q?mPwHg3piiSAbHfywR6vu7Gq5IwktxKWqrNKNSfxtlxtnY95utuPjJHgiPYv0?=
 =?us-ascii?Q?+HmGIcE0+nbdJX6/EoHdBENJNO1dEf6a2SxZysgmxWD/sJtt3eY1ruYb8ncD?=
 =?us-ascii?Q?wQRxAM356wdMihugMdvLaCGySpPs/DH7shaKQt1sQTcfKL7LMeZTqsHyIdKK?=
 =?us-ascii?Q?DsBkNVNuwvpfZeRjbE3JwlFRt/yxC/1wCjV/wI4ys87moHpgNARIoD1Z9ATe?=
 =?us-ascii?Q?DhLYH5PGSODAnL0JegihZ819mXmM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:53.6687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6d5f3e-a953-4c0e-35c6-08dc709c6dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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

This less-than-zero comparison of an unsigned value is never true. feature < 0U

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 6d1c3af927ca..d439b95bfb79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -760,7 +760,7 @@ static const char *__smu_feature_names[] = {
 static const char *smu_get_feature_name(struct smu_context *smu,
 					enum smu_feature_mask feature)
 {
-	if (feature < 0 || feature >= SMU_FEATURE_COUNT)
+	if (feature >= SMU_FEATURE_COUNT)
 		return "unknown smu feature";
 	return __smu_feature_names[feature];
 }
-- 
2.25.1

