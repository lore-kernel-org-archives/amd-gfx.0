Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B25EC3064D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 07:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE3210EBB3;
	Fri, 28 Jun 2024 07:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NbFtVlix";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28DE10EBBC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 07:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnHd5DlpbK9dLlpzQePwnzcBPigZqjRp6tM3t1JOw3f+b6n1j/JJ373KgypLv5eKav2Tfm2OKbz7MpLCelnEIKNTKtHoJAFaX3iuSBbdmGtaEIymIETauafgQJTamJUX/w68hOvlPL2M6PDyirHlkQ0CHt6N0gUa9wZkzVyqPpW3K5xTRWsKbccxmQGRt52o9/9Vs3FaFPTHAs/lg+Z2yTqSe6x3UA0P3wJOtENGSHWiigCpvmMAA9cBYTtM5h8VGbZmK3AG6DwAXLJZfqJsUvWZgoqr3/njPhC43vXr/CxF8YeQbLoID+tIuWT/riKkhz3yVVYEPnwVocfI+bQJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7/GNfgl2TY48RmOluLQoSLqtn9rdXMonFWQhPXYssg=;
 b=VyEpd4NKZXzkb6X/TlLW4i8wyGL/aYEgQfVpcZj51kE5P8jcfSm45ONU498nc1pNOdyd4SKJzHHWaUYByR3TEaU5hKbF7h5fhMht/UbAs0+PZwA4e3HzbyZT+uqv6CfuxLHmqNyDLeOcDiOyA7ZN9LB8ualiacry5vo58qSJmQEkXtXQQc1w/YopvK2hE3/ZN1lLvctot1NY5pS0s0/OjZkW6eubxMAERyOUrmKn8FKrHgcfUbQy/hiG2HcrqqMfxPcoZVeDBMx8k5l0GL175+NoP2SNCbjX0YZAMPLwEK4dj0Gagz0jy2ZS9/OfL4TU79NBdIbBAa8xY0ZP55aEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7/GNfgl2TY48RmOluLQoSLqtn9rdXMonFWQhPXYssg=;
 b=NbFtVlixiL2J0GiPzsmoMNZ72cW4OjM0EzavJTA8w5411B6RDM7ctFdR1/qbJB3vMtjWUrzalAADUqomwmTXK4lkxF5fE6g/F71ukXjCRSzTJJbNom5bsAghZb4Zb6dq5zZ52AUnsEVBhtb51wkC0rwwcvKdUw0N/m+eiEkni40=
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 07:31:33 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::7b) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Fri, 28 Jun 2024 07:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 07:31:33 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 02:31:30 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: sysfs node disable query error count during gpu
 reset
Date: Fri, 28 Jun 2024 15:31:12 +0800
Message-ID: <20240628073112.1291140-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: d0da874f-f1f5-4d76-a1af-08dc97445606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiVaaeFiZ5EdvyxNx4KGVi0ClpUi1RZVAXKscYzx6nP27BW5WcLsx2e8nUdw?=
 =?us-ascii?Q?KgsSm8kQIDL2S+wqBZOQtqOTNr2tM5z28TVa1S0VeOQSh+jelK70pZwRjk/6?=
 =?us-ascii?Q?HXEQ3eHAXDxrYiyRNlI7Hsywn0n68xcACK82TqkjxMBn0ggPMgPzU3lRGcSG?=
 =?us-ascii?Q?pNX5/nZCYKKyaYM5rWYuOvYGAnFRIjjYJW+fFmy50Y3bHvAK/EbL0ZeZ01rs?=
 =?us-ascii?Q?/qHg+O51GFd+UYBsK7JJCsWSQxfxjdodThCNrO+mCpdQBaSA0FU2IbXt4PrO?=
 =?us-ascii?Q?1lTm4rUOoNiUeQNmVKr7NKuH1pF6sM+3Hs2gdyJmmpLnHUl3P0bL3PPb7bhY?=
 =?us-ascii?Q?l5ULJAgQGhFaWuNfG1wXn6NIHjGA6mpl/pRD5GQJp0cyLknz8HQYrzsPs98I?=
 =?us-ascii?Q?RSZYxldU/lAFTdbVfyVZB6pKGW6p6i++o8AOg/pvWGPzAWRV360dJ+GayDVq?=
 =?us-ascii?Q?7DomNxacF+LR/XSmBCRuc6LaiCJtnYF+VmU/XNh9833+j/GdYda4Zpc0AkVG?=
 =?us-ascii?Q?2MsFgJ/8Wf5kkgSR1YIWHnrQrq0boFvNA2D3IfjBR5v1p0eeRN8QKEsZ905n?=
 =?us-ascii?Q?oaLnsoKMnfSfa6ORZ3ocodWw3LmhzTqQRYzPfhlmVz99cYhemdm7NX7LbMnl?=
 =?us-ascii?Q?QycJVe0aK1LA9ngwAan3nRnJNG8yaIN6klqUY9I26bJN7MChhx0f0PxhjRuw?=
 =?us-ascii?Q?Wgd/iMYn17X7asc5jOm2JQL+aWpi4eqEXvLvgoP4DSPMZlBlMSydTOuvey7p?=
 =?us-ascii?Q?H+uy3h14WPhzw9P2Jr0PAD/b/KYn3j1zzmoZJHzTOANeWuX1uX6BvYPMc1WC?=
 =?us-ascii?Q?hLSJX2fXkmAhQSJLG/Vkj36bX9zetY5sXPgrMHVRCrpMUm1vP8C8pKwtVl6D?=
 =?us-ascii?Q?++ulR15nfMTBzYpSeoRnq/D6lPg0p9msuyWH4rYMzvLzrhbhvO0QlAJXDPp/?=
 =?us-ascii?Q?tky+gPgxZku7ZzmJBaiSjB3MSrDQUQ/5dFhXhxOFNu376yI/dmJgkvn9kFKc?=
 =?us-ascii?Q?yRv6N2viPV8dJDSdTnTtrlsC7Aw2LOTymoun6hzw71Sk+Wn4xCHjECy7kkKw?=
 =?us-ascii?Q?/jdOUBhM+bisNXzDLTE++NfWSylinNZlHhGbpMRv+BDNhJGFR++iJL8Fdv4r?=
 =?us-ascii?Q?PyKwm9q99xlu6/guYqJ8nejO5B92URG2pQrNjAza6Q3KeJ+1+8mhbXAGwFOZ?=
 =?us-ascii?Q?Jaaf3ktUhDrn/1oM5xtYeb9FmYahpEvLqjqtiJtNSR1ayn1wIv8nbxX2w/Dr?=
 =?us-ascii?Q?UkUtzzh5DVLfy3YeXvfIMYJ+WIyMB8focpHoygx4VAOQ5EzUGxr5IqHdxt8Q?=
 =?us-ascii?Q?glDyCfpJO2tzkJQICqNn3xlebZKzHfO+BAttmm8TwINxYRkOdX9FELvdeIeR?=
 =?us-ascii?Q?BColatE5xB9F1X9kL3rt2jQ/yE86gIFEqbPOwDoQqvqXcuG4t+Waeie4eCqq?=
 =?us-ascii?Q?Q14i0CeKgvdsETXAkqlqHk0ZnzeSolER?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 07:31:33.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0da874f-f1f5-4d76-a1af-08dc97445606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
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

Sysfs node disable query error count during gpu reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac7ded01dad0..ab2e11e1639e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -619,6 +619,7 @@ static const struct file_operations amdgpu_ras_debugfs_eeprom_ops = {
 static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
+	int ret;
 	struct ras_manager *obj = container_of(attr, struct ras_manager, sysfs_attr);
 	struct ras_query_if info = {
 		.head = obj->head,
@@ -627,7 +628,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 	if (!amdgpu_ras_get_error_query_ready(obj->adev))
 		return sysfs_emit(buf, "Query currently inaccessible\n");
 
-	if (amdgpu_ras_query_error_status(obj->adev, &info))
+	ret = amdgpu_ras_query_error_status(obj->adev, &info);
+	if (ret == -EIO) /* gpu reset is ongoing */
+		return sysfs_emit(buf, "Query currently inaccessible\n");
+	else if (ret)
 		return -EINVAL;
 
 	if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 2) &&
-- 
2.34.1

