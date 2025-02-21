Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7436AC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 19:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDF210E285;
	Fri, 21 Feb 2025 19:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hK7Xf+6/";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04C410E285
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 19:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7+55Yl1cxCAs7fYH71S+q9G300HXuaWUVGe43Fs9wIeZ+57f+pHKw1fx7dcDGoCKtrs6fnmKheus8crEo646NwMTL4+prTWqESxMGnHS9pyK/diPUQT5c4/1686t+oCyn94Rkx2v8QOrC+ztni7awbw/V/o7bVsWoo+jINy495VXL8C7DbZWfw0rgKrL7DLOKQR+5qTASPqm/XhTpmS/6JslBqqGiX6DL0kcx+rrZ7tD9BdcPGJv8yuUH09k18vEjPoH4IMpSGUc/v8F9xToLuxFWcnar+zT7o+inITHiMOPYV80+nFHhiPl0m0/bZI5tVaBicO/q2S/iMEWo2bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/DZyd4BFScAmdPLW/V7R+0ylY3OJD0ZFWrt1xwK4vw=;
 b=vgVlrZqF0qcA0wej9b7jn/M8enDH7ZhNo3YfGmy96fcJvZmCwWRjzFqz5fhE33aaz6aPjM3a7QEpXAWGGxha87EJbtle1kJyIg5ROPPuHbvrKE4C0Cz+NrmGyvJGsdbjm9N1JIXzg3q4EERtOLJJPIhvHvWjXIuOAnF6RPlHRlI+w21ShlX3rOQtY2aQ/WfJX3H6nojw1UaYdKQ19d2/UdT2s1wxEDbj1shnsWgXtMAVNKNM5H607XTQJuRtqHpcK6kU+PdUYCWVbqkcIb0q0w6CMipthicBk7ZrQ8dHjp3mQUIG+0v0SPbr/CeFJ3fqP/LoQFC+7whW7ZKyIeIFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/DZyd4BFScAmdPLW/V7R+0ylY3OJD0ZFWrt1xwK4vw=;
 b=hK7Xf+6/jkxQlnuLsP+RCXdtUyxHQBUoaLfPnmob8on2+6nzc4edS/xl+z60wOUzM/jW/Gy2+TTAhwI7ZgyOrtYgo31OY7ifGppBhpT2lddvfl6qnm8ivfxSgz2EcBoS5qYCUdiSqNjT0coWpNocyfMoFGb0+9kvM6j3zjvuDOA=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 19:25:14 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::25) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 19:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 19:25:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 13:25:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 13:25:11 -0600
Received: from aaurabin-cachy.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 13:25:10 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] MAINTAINERS: Update AMDGPU DML maintainers info
Date: Fri, 21 Feb 2025 14:25:03 -0500
Message-ID: <20250221192503.320868-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 49749539-32bc-4107-5276-08dd52ad768e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtZf6zkF74j6QMXRMeAsVG/TdHJvzkTOhQrCWdvd9YV1IM4Mlb72Q1XAzEwB?=
 =?us-ascii?Q?xY8D/WnBuQs61vayJzi/INhPFfnLJY5g5SQy1CkQpxx5ygqSWhSAjJc+zv9Q?=
 =?us-ascii?Q?Rq1BdMwqEyc+o2ENlHzxc/PuRa5xxXG1Pp5lc1/wHd7SW1a7SSOtiS8eZj/z?=
 =?us-ascii?Q?vl06KsyhbPgCnFIAHf4/m7wVcxGztcOwQfD+Bgs6fI1IosYki+hsQMRNvKEu?=
 =?us-ascii?Q?vmW4Hn8oSZhUuiF5YdBU5KEA7j8bC3crI9M5+kszDTcAVvLut6/uZ/1UEmXw?=
 =?us-ascii?Q?Fw89Zwn3hrNw+yz60HZf5r7fwYmXtStC9z4N5cZpqbp8vrbGvhcbdRsGQcRZ?=
 =?us-ascii?Q?XP0qpwH+lukAVldpjjmzujX7S/PMVVYPdtPWAI5AOtZiJwWZJ0y6pRMeqi3p?=
 =?us-ascii?Q?jG46mgk2FND9VSL0T5iXrJvchndZuz6Am4g7ZOc+ec89kZrPMYpSm3PvwdCu?=
 =?us-ascii?Q?/sNtzIDGN+L2sBWCFsHTKg1y7MYSUjyt8Pixjp1J0zfMHOuJeMMxaGn/J78H?=
 =?us-ascii?Q?ednMfR7GYqfC/pFO6eY581xupDewnhSeZqebqIgjAcSVyVIJGPeVPKiF7pot?=
 =?us-ascii?Q?EAzy4uZBbJwIsYOVXqH4BaXkmv+E1LNdeVsKvhfKEF0ni0r/di8C+ThxiKZS?=
 =?us-ascii?Q?OzUD3WIRpZq69pVlgrxwieHduYA0qfBVismRAcCrzqkZBj/A6srmW1eUY2EM?=
 =?us-ascii?Q?iHJWl8LugwnjQWvR71cPSek8Abe0DjwTDJSuU+YZZzz3NTj0r/Y0CBR4b9mq?=
 =?us-ascii?Q?qjLXx5uSnJMXzek79zpuMo28TJafHVZ6IoK8oHrjY885t1858cCFITQ5t+GM?=
 =?us-ascii?Q?Y/E43a7eUrVayb6BR2JJIH+JG4C3Vl49To+erxC4GcGn++7WY6ynanYiEaiB?=
 =?us-ascii?Q?nAt+MicXkgOcUlMzQWGCPx1hQgmMXoV4sK+N17jZ/mXk4GZmZabjBMosfjz0?=
 =?us-ascii?Q?mxBahLWd2botxvpRGe39M2xUA3wzG8BnwndO6MY7jL3ASBqZlEAJNo40aRwv?=
 =?us-ascii?Q?1Xb0joFuszY5jlLOX0JqwbSc/14za20ZKesEc/weFdR0MMEvDxvP8Di0dHiY?=
 =?us-ascii?Q?X/8vKgMqecdU/eCAR72SupoUQfSl0URMu4SzdwXRWlKmvMxLNrfFG7xtDlN1?=
 =?us-ascii?Q?eEpmBS5fEwhMjpWmuG8pI9fXJw9ErQ6EfMnkO+7hCdq22eIdOdwK85UD9aoe?=
 =?us-ascii?Q?6sc8zNcXHP96muF1Rj+m2nQcPlKNjOb+YghR4EoRJ+wA+02AqFM0WKPJlDyV?=
 =?us-ascii?Q?GLnEia3QU+4tfhzJkFwPi2cJnFQDQ3TFaD9Svnqw8km4OW+HTVE7px80WdVw?=
 =?us-ascii?Q?0yikDS30UA4q+Pk+Mh6JNnF8wfCBqW1gboyAtQgfLjCj2fnY0oywRuWP5PKY?=
 =?us-ascii?Q?mVgG8A+0l8vudFB9c5YbK3O8reBC4M7NskGWp/fCyXYhjMZrgL9Z8VjTerlu?=
 =?us-ascii?Q?ymWanc7siG4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:25:12.6618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49749539-32bc-4107-5276-08dd52ad768e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
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

Chaitanya is no longer with AMD, and the responsibility has been
taken over by Austin.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8b35ca294a0..d167946f88e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1031,7 +1031,7 @@ T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/display/
 
 AMD DISPLAY CORE - DML
-M:	Chaitanya Dhere <chaitanya.dhere@amd.com>
+M:	Austin Zheng <austin.zheng@amd.com>
 M:	Jun Lei <jun.lei@amd.com>
 S:	Supported
 F:	drivers/gpu/drm/amd/display/dc/dml/
-- 
2.48.1

