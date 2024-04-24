Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA52C25B10
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F42113C15;
	Wed, 24 Apr 2024 15:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQiGyp2i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789B4113C14
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey0vRym6XDHkTk/1TwSWHz2NoC5bc/qJtkwr6QQV3pfZbj+BrmDqevSY+x5rpwIbKYme1Jz3IbLXXIrVXVZw4OswA7mNSROOXibR1JlfdlxAtHM4wAFb9m2c5dFkSDq19D2wZpW0DK5GBReZSCAmyfnhCp5xUw/JqXbqi3uWLb/X+ZJhu1UG8z8Dew1nMmQL901DTkwQV/HBt+rGfgu1Bb2TkI1jNUpQjaCuGMUg6/TZghRLst+JRRu436WIHgWkNL99hXwRsnqjC+epj3Xts59P6KwrkB4dDS4b+3ZzJrlAm4s2ScXdPcso1LMtEHBDrmSzK6i+h2QAZ+8dZau6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ehlAh38rOLeOX5KrnZD9JhA5Nt427RBG3gGfmBXjww=;
 b=fwGtxV4zEaqLOm7lZcbKffWwjVRI3tow1GR39RxZh8TUKqXn57tMyo89luar241mdjCLWUdtIQfTTtqhDnVkh2/87V8QY6ZvXVaeICMxxjlBu98IvBs1dorChM8G1Xbl4Sg7BUHrLOoN8wyqePSujnT9YoAXtxL4vMinP1LNKIfx9zkOlN6qHhIePWpXOh7HfZTtPo/OXWBdq6qK2oHuyF5SvMxsT8SbkkV+UArz0J5BVYuO+R9jxpGugWP1WOVunUzxxpXrvkgmD4JG28vZ4NFA8A+dUTnz+Y63An0lXUn9Wi5ZMDWOYIQTZjwLS4Ue8WA9OBfZSWJj/6jRETMyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ehlAh38rOLeOX5KrnZD9JhA5Nt427RBG3gGfmBXjww=;
 b=jQiGyp2iUniTVfeHASByBCkMWtKkmymw6xWmZlZJwiNitN1i4vDxdh/wYCkcS69V/8WcQKYFQnwUQIDyYFJBZN37OwpzxGFz6srTl75Zbluu1vqQDHhe19aZ58V9R8UIrojTAgQFbHu+SfZ7Czre1o0Ze/ZkugS0TqFK7rUjO6o=
Received: from BY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:180::39)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:34 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::94) by BY5PR13CA0026.outlook.office365.com
 (2603:10b6:a03:180::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:29:33 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:29:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 5/5] drm/amdkfd: Bump kfd version for contiguous VRAM
 allocation
Date: Wed, 24 Apr 2024 11:27:49 -0400
Message-ID: <20240424152814.9608-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424152814.9608-1-Philip.Yang@amd.com>
References: <20240424152814.9608-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: d05ace2b-d708-4c51-9a9d-08dc647357cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J8a3LetSNTEDFi2XBk6WHUaECGX9qyK5kDLp7egmAeFE7x1jeEtexpxbwwzL?=
 =?us-ascii?Q?qWdq250kCVTL6YTNIvGqNkOYLDijc9tZ73i4dgFGEKu1xB8G0HVDD74ePORi?=
 =?us-ascii?Q?cgCKAMXFl0dORkyYuyz7dlP67+t/hVOvakUvPo+6KD+il4CbG5QfTTkXYSWZ?=
 =?us-ascii?Q?JBKT3BCKZtB+tSz4rVzOTtpb0EjJWbE2g4yu95UMkipJxZrz1NmkOlya5QnX?=
 =?us-ascii?Q?e651UowNVGJJOcxNMiQ266dMKIqcX3OkEwIp9BPF82lqsaBUSOVqDxe1ZTEa?=
 =?us-ascii?Q?PqrYGGAe9ngnufYwsZZ0D+3E+2bwuLEnLEQEDbut48GDmaH30TUSWwYQvu/u?=
 =?us-ascii?Q?b9hhCzyx/c3eY+Lo8rOnDiaPNEf01BiTvv6oKVZVzgcXT+AIiuXdo5yAMzSR?=
 =?us-ascii?Q?AhWclbn0/JpfEw2caIHSFPsA1XScTpLfJrtWuzPy9EzdjBkDUMNIzcDDSaut?=
 =?us-ascii?Q?HQAM0lGZEbvcYAFaF3OgLL1MoWU3UPeQ2HBpeMfoaoFW/zPM4SQtMavzxpVP?=
 =?us-ascii?Q?/H8LEzx9T4lSDhL6D2QBAUStgbKVY2rXpSGtikfG58hbCJuKUKaK90BqxhFp?=
 =?us-ascii?Q?IT0Ay7Ycd+BU8NQR+G7hSNJJtj2s0HJPTF4l+IB9v1b0AqM1BNVQY5iFRuhu?=
 =?us-ascii?Q?uhxQAxTaO5z7tgbwCL5lP2cY4Tb8U9ELs63D1ZNC3H8qpyrQU6NGXWm4DmJ2?=
 =?us-ascii?Q?oeIECZgua++WPBZydq78l/1nuJc5QzFmMaejkGCL7J94HOmWvrA8CJU80GuC?=
 =?us-ascii?Q?1CUTFIEw71UQve0nX0To9PNpfZpLiePQNrBrQikvNM76GVHJEU3+Xi8gds1t?=
 =?us-ascii?Q?GLK5hpRb7AEXo+XrrCGJ3dZbPniCZwN9c0ZOukDQUmY1v+Drlq1TbDmHLsDW?=
 =?us-ascii?Q?m3znBUQO+Xilh+KxhIXfkFCg+aD0XJpJwnIf9cLlMgt2hAbqgFemyFfjaO/x?=
 =?us-ascii?Q?QDV8o0WbOURUDyT540lxCIK2dTHiHMIIp3xTYs9zPxHnOYwS6w259iAaSeZf?=
 =?us-ascii?Q?4lOFYBpPd9UATOH/YgD0KlHVCCEbGA/V+LN3nnesaFL7B3mkhZ6+R/0AYDkI?=
 =?us-ascii?Q?943VBWihlcCFd6sUvJTfueQbQEWu8OucrctKzDxk/9N0l34vyF1EIw2kbZN+?=
 =?us-ascii?Q?kFlYmblJHT75mR8uzZbo4aEkU7Q1qLiBs/gef2mKYd19EiyFBVGZ8mGDoqDq?=
 =?us-ascii?Q?UCtc14ssciEbQ8NSOqEN6Tlflpsc49fXn7rhz1Uo+DRdJrubZINkeicnL8mh?=
 =?us-ascii?Q?Ah+YdrhejHwN+7x00TtlonsT62t7gz70QbgDIXgAhTG43gBK+ZB7DeXSRLf4?=
 =?us-ascii?Q?ic4GMYF1D/00wBRJPdaKeQqYNk+dUGAxCm4ijwXpeFWhpNJeRrAQYg22f1Cn?=
 =?us-ascii?Q?NMZ05Tair0LvbQsaoM9R5twB9K4F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:33.5626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05ace2b-d708-4c51-9a9d-08dc647357cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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
index d09c4a18e571..f8e9d3c1d117 100644
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

