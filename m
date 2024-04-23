Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15037C10F15
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635E31133A2;
	Tue, 23 Apr 2024 13:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VFD+z68L";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4BC11339F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBUFReJwewsHd/wlEgEM1hLPO14tqZoZrvBr32Br6uW4cBNsaO62JnHs87iYZpOkHiW72SfBlLOUMUGCtc5kJ1EMNyg71x8Vrc+WQBICIc1GJZ84XQkqmzrpffPFCzgPYmJ+xds/HNP8s3MIH7BmZ4kTTiJsOr5ArZFQYcH61czbp/KryfxQ3qhpoyVsAlaqgZOhYzDYnZKVaOLtgMTd8llmKYObQ6DzAMOukJ0qNdePnKOnrubqph/HNWhqjjF96Fj0YNZeOUPvMDJ6ExkblkJtWodYNQtcgfbWRSoCphr9jSMMxPlECP+DuJwDQjTD8ecy8U96Q3XyClzL7HmTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iIreQ1+HJmiev1z2bEWU39E0dFuGu825c8ykSAWQvI=;
 b=YjFx5PKL9VJOr3f9vXy11ThxnNAJPpQoyJmER0C2Fz4KJo9VIYApUXMnlb0Su2lKxfcMArPJHdaR+nFyjAM524+eHpAQBX4ts57iGsbpljDOiEEAF9Jqe9ILxghYi0VgQPQhbOXnKqkPC2fsQWSsi709vVVm7URXki8dLd+EMh595sADBOrCkUIHapJAiTUKQ+vA8dx34Qp3QwRotJDF1bjgEf+QL2wSwzRxCdQGUYqvZ9A/qNkNWS0J6UagqHzA5Zd01Pf4I+24Hq86FYMZa4mK1ngL18up2SKUd+/XC5bRlu/dw1yzlLGYQwDVLuyR5v6BT8XreOahMjOKXVMLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIreQ1+HJmiev1z2bEWU39E0dFuGu825c8ykSAWQvI=;
 b=VFD+z68Lo5G2TyKVv4sPu+uyC7MTqIwXnQ9vDcVn4IY8RMz8FYwtn3l0LpKx7KRTDjfSUFq0nD3IWl74NwsvKRPeqHDAWjOgIchgaIg04B24vnainEjN+XVz13sLfNsfcWl0mO2YcfoGp80xeRIPi3DAs4ROXfRoMQZX3sZqQU4=
Received: from CH2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:610::41) by
 MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Tue, 23 Apr 2024 13:05:50 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::d5) by CH2PR05CA0028.outlook.office365.com
 (2603:10b6:610::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Tue, 23 Apr 2024 13:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 23 Apr 2024 13:05:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 08:05:42 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 7/7] drm/amdkfd: Bump kfd version for contiguous VRAM
 allocation
Date: Tue, 23 Apr 2024 09:04:50 -0400
Message-ID: <20240423130450.25200-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423130450.25200-1-Philip.Yang@amd.com>
References: <20240423130450.25200-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: a09354f5-67f1-421f-2a3b-08dc63961981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6fh26dHI6NgXPKd+SLN558Y76V6GhlaKU/5NMgBEmVK7KcZVQufwLBzsGBxK?=
 =?us-ascii?Q?GRAAlq3adGDjnptu91pRzaV7JuneMjDWhsgqC1sv9HdWltj9AyaEgMR+xPn+?=
 =?us-ascii?Q?R94PxvVKLqmUDIAEbLE2pf1vKbPFMmldzmreqV3xpMM6AkS7tdnpbGPNzmSm?=
 =?us-ascii?Q?0jlhMaug96JRX3LCBA3LGd7SBdCAa8xPkjOvqBRyCLw5oDv5H8/v5Sir6/Cr?=
 =?us-ascii?Q?pu2KnZ1fUWXNYBmGRXt5edBV8SEjA7IqeYsUIlK2s78DPb97Wd2PD0pb5OGI?=
 =?us-ascii?Q?Y/sSn2TfY+bpfHCXeewOAtl1WvKbyeypmMMsRJnH+y+OiYg8yHIhsjapkNYu?=
 =?us-ascii?Q?IFCEP1MQL8n3gyk0BjJF46cicXCj4BPkoQDs/GPmm3n3AoA2x+nHgQSKEgNd?=
 =?us-ascii?Q?Sdf9nIhHJPI8S407Y9kJTOjUH/el079luQRCM777jJr/lkz9RdhEn0ipz/2r?=
 =?us-ascii?Q?KjQKbPo+EdUmP3MYnq6Av1CRQKPLIY+Yj6jjf3K7lsU80bR3CmYxiHPYW61J?=
 =?us-ascii?Q?ILyMMnF7V/Yub+N/v7lo+b8RUJA3YOF+7rkYqu6hY0vLAOezA+h96uU9EuOL?=
 =?us-ascii?Q?oAzNKddp4lc1+3Rzs1heX6JmTl4yDx01CVpX0iuaG1WXD070vEjLSjFfUg17?=
 =?us-ascii?Q?Gg7bdfmh1/VF3fvYB9KYg97k/mHIuUkbpiPo4Q5PgInS/RjC2bYYQZSn9ze9?=
 =?us-ascii?Q?aiZzgRlxzq0ECZ8o7kGb6r3M8QJQ54fJo3i/as+Ga7pCo7Tv4DnVBZ3f6PVr?=
 =?us-ascii?Q?dmIyqJyOAKBlF1ot2IFpf8RmOJ6HdFreYvqj7HtQY+1eVSD6ND3s7KCKhghE?=
 =?us-ascii?Q?lPJLTvL2x4hX/AnHChUlW04XiKEkB4c1dhBKK06fOTb3yT6dNnOoSx4q31k7?=
 =?us-ascii?Q?e54dNyHANMxDyyohxksoBeKavDjEtdlCDeAK0ZlFMFLzGQJKvoK/sWYRXtLd?=
 =?us-ascii?Q?vJ+JaAjPUVZ5hPs6zInJqgsDtc58+b3+xjDyDEEi8PrRlkgZrmedJp+X1ME0?=
 =?us-ascii?Q?u3/C7xFMrqY2wToyKA840owBSF6chhazbklmwGbUjYbiD7ucfYkns5YJL7IS?=
 =?us-ascii?Q?HvruTnPK106zhAXk4WIUbyK205Eak7Aa6qioNKgXBNPefMJF1Y2eRxdkG/VO?=
 =?us-ascii?Q?FKAiAJGlfw3k+e65XJsrp1PB2fR7UqihdpyrEdyAxT8vnGtD/mwQtAg0BrPc?=
 =?us-ascii?Q?wIxLNVpdEqlbUitaGwqVYylgMPEmEH1M4UGuvixQ6JqAb5wcidLwJ/aDq+Q4?=
 =?us-ascii?Q?zQ3b8qMu+bIZ8o/yj/eNbOqQoPlLNBUFdB9OFHn88ITJk2hCf9i4TXkPVQ6x?=
 =?us-ascii?Q?55/S6kRz9vo3cY7CcL7bsBO7dK5oFyvObr/lL9WK+4SV7+/75gB3y/xvJKsn?=
 =?us-ascii?Q?WupYxTVNeenW0xnnfIGv3snr+fJV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:05:50.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a09354f5-67f1-421f-2a3b-08dc63961981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

Bump the kfd ioctl minor version to delcare the contiguous VRAM
allocation flag support.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c1394c162d4e..a5ebbe98ff7f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -41,9 +41,10 @@
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
+ * - 1.16 - Add contiguous VRAM allocation flag
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 15
+#define KFD_IOCTL_MINOR_VERSION 16
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.43.2

