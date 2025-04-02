Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BCEC28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B7310E822;
	Wed,  2 Apr 2025 16:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X94rMFah";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EA810E830
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Np9JHp2g9Ku1pg3fs6drWveQrRYALhCPigv0V2hW+pC9xYP9FFxt8Gywlnbj/QANUGApaZzSccW//muIR/7fyDcNzvVRKRwjDRJCHLNUWa7xvyHuyv3RsaoLeZ0rvzgy9HxldDn9lNMEKSTmvrAYNpVuZXyHeHSZJblgJi6HDHSK/DBDEUW3IuuzfDvdYGMj6RQXAxYtkshAKpGkGC0AePfZbnCwZix7xIO2OsK1/vBq+vLLwAyiKPDG6sNkOUy2+E6ZvabjDf/lPrqIZYlXB6Gdi2tHozgJGP1AR8bE2aYYQ0wzuEajGfy9uO/qM7Vq8dG8+0bTcgQmzRo6TNVhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NimfZIPUf07qfQ+pBrmWMNj8u9bkYIIK9KfeKQcqhCc=;
 b=enwG8K0ETgiYU4NhLG+b0TdlVN5lb4S/jdCc6nvcjTaAOFHH0UjlhNacu3zZ3D8FMFGwUTgxfOwJb66q9A6di1FXtDS/0u06GSiL83A2MTRqp0kcK4aw4OemFHGA4J1BJ0WPScbYisP85ncUMX6w831KTII1vMipAjHkmISyEvDFlUuRoHy3m+/9Zkh1BA9cGtvyX0e0FO2tw4tLVXI7+6naFMBq1BtuTaFJmsJCyQtNLmgTTEcipBa9J7NEwYzX55Mj7fGixcISIKhDuQcXxRQ3SDrgMXFpNjm9frUR3tbNp83z1DhfC7Rw6UxUEWr0DDzujAMV/5EKactdrtDJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NimfZIPUf07qfQ+pBrmWMNj8u9bkYIIK9KfeKQcqhCc=;
 b=X94rMFahpkLHhbU5LKyFn4nUiR3rVN1NKjHMQvdqf1FtC+pTKUMBaHGsLLN+UPtDmnwfN09ETF3ko79iAlNgzC0zGnB/obUozHTCKt2yGgROVcy6i3oqbtdENn5kntIU3jvdUizF5CH+2DgE8VAgPKvJ19xuekk3WVU2MWm5QCE=
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:13:54 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::8f) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:51 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:51 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 14/16] drm/amd/display: [FW Promotion] Release 0.1.5.0
Date: Wed, 2 Apr 2025 12:13:18 -0400
Message-ID: <20250402161320.983072-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c7a8e0-062b-4c43-8068-08dd72015d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UDEnnvjomTRn/LZxdDkNtnkAuUUwRSZbSN4eXq+HATaJ5jofz0exxcgxnpY8?=
 =?us-ascii?Q?PXg4DRl/Js30BuRzuwVzofv7rWlJJ8Pau8FePeZg0fpssrYlEMulq4qsg1zl?=
 =?us-ascii?Q?PeXlT8NPeRWZ8SzXacjZbEdNVfqxY5c0JZVY2is1UuOFzPYt4lYpilh+OeS6?=
 =?us-ascii?Q?8OUJs5anULFAxNLrkJUEc2M7aIO1MShhH3gROrqKiTnp8WvdTMF9xX7oGfBd?=
 =?us-ascii?Q?7DiVbkl3Gh5k3NFddIkTWeJ1vRQougISdgFq+A5mOGnYDIs1rb05riw91rqh?=
 =?us-ascii?Q?eidHmpuA3JrHSIYgItnmLryLBiufeUpWNmPkXdv/hvL/068HlwaZvxi9C4rg?=
 =?us-ascii?Q?nJUeS6B+P2YomMtEtKIsp/DTEZ5iHFtg94Qh9BCoQ3o2Fr3wEhm3Eao7pKjI?=
 =?us-ascii?Q?Kf0ZvysSzDIFmIgX6Oo00n8c4Us+TUqkSS0MIsKI83w7R6KfqazyHnignIM6?=
 =?us-ascii?Q?DbwUlAjco7IPle9odTv0ovQn5KLHGmsY4z2CqjvdfY2ucl7aCKeYu9Mt+UGi?=
 =?us-ascii?Q?X5YpClVBVwEW5i5IqqA2xseVVClYHd8QL+udQFsMIjkkSZ83KsT9Z5WAyhmb?=
 =?us-ascii?Q?zMb/286uzAo+1aYJ78LZXxWlk8I411LefEyoDJTNPKhznYiG6OAHFxZeI9hm?=
 =?us-ascii?Q?a437MeV5LnhOThtLmKXMTSekeacpYBJpILy8IT1+HiXmM22Jv8HwRVO3g0cP?=
 =?us-ascii?Q?T5rS9bULARbYQ6I1sj8KPYxqL3/HBor19HiTwSKfQGP/Vr/KuZfdAx1L+Y/2?=
 =?us-ascii?Q?0jUSj07ox7ysYz7QY9mYp3pC4dNrrK0T/r25vkWwB3G7BXs0eakGJqUSSGkm?=
 =?us-ascii?Q?sdPCcGeRP4CgOxko9mCD+EiY0c+eoEneJ+5TqFJC34snIhbQfyWT7ryYNCJK?=
 =?us-ascii?Q?VodXp4GGFF4czYLB1YXMzBa+BfyI8QsFCRAKQkT9wrkaw1wvuzMtOx4DShmL?=
 =?us-ascii?Q?c8qKVZJxDUnXl+SGczRrtdxikKzYUWVM7InrqxzGwtsB/pvL87tA6VSX7J/V?=
 =?us-ascii?Q?WqoHWc4jgpDy+qpV9JSjdyjpXj4yu2mKP2BjX9ziy6kwV/oPociCLh5uDcNS?=
 =?us-ascii?Q?uGc/V08oHl6CmQfiMJMrW76emb2c+iAr1uV+JV+QMJzPk+iLyOrewTyRNX8u?=
 =?us-ascii?Q?/oweZqiIqsIsu5N01mvzj3ic5OfdSSU9Xw8K8ZUUNSMhpOkoW5lyT2obdW9i?=
 =?us-ascii?Q?Bj1YPX1xbZWqsg2VfHX7K8f3eLFvc+twXh0sVauR7kwP9+jcyloYNrYS2Hee?=
 =?us-ascii?Q?o5ILcnLDqgYE3bQH5CPSBAn4ehG0szJhtd/Fpra6/9RSMaiujGKxsMZkUYdW?=
 =?us-ascii?Q?BWdjQDUymG5msjA3BP2OZMa/EBlCHYIogU+1Y/7A/q3ZueIGvER+wOG3yu4I?=
 =?us-ascii?Q?R31exqb4DI50U8HmndGJRCa6E114Wlx/AetgvvYnYZ4LdJd8RdxyNn8etMq+?=
 =?us-ascii?Q?o5u6lFvSCGTPgY55rd90fD04yvLyvHSZ6jZhvSu+JRRSjfl4C/W4Eg+xDSno?=
 =?us-ascii?Q?gpPHsiMp/5XImFk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:54.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c7a8e0-062b-4c43-8068-08dd72015d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Aligning dmub_cmd header with dmu firmware release 0.1.5.0

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4a4e98068893..b11cf41c2d51 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2636,7 +2636,11 @@ enum dp_hpd_type {
 	/**
 	 * DP HPD short pulse
 	 */
-	DP_IRQ
+	DP_IRQ = 1,
+	/**
+	 * Failure to acquire DP HPD state
+	 */
+	DP_NONE_HPD = 2
 };
 
 /**
-- 
2.34.1

