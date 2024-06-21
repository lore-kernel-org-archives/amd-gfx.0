Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0820BC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 09:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B22110F135;
	Fri, 21 Jun 2024 09:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDNtdSOR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2101D10F135
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 09:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpypouDh/rTMAKTpTJZWGBaEQuToC26//btzPdiUyvoSvsV7TYbMYro2VWrBmyUbPsl0jTP0fou8Ib5eTxwmTe43It67XmJlHf3l2G36W0jzAawuIrnmEsj8U93c2RAxuePNVHPs7Z1og3xKlU5NqjJofEOD85BO8TYHdGZazWJJl8xeGseC/ce4EbhwmnP8xULGaYFBV3r0deEb5occqP5hQbADsESw8ULBZhIaC8233XPfYHa1AJHOto29GoT2d9l8E82/skN+oThlAYwa4DN8ResaWOpVnVLyZq+6VsiaLbGhJcVm+Y2iQHaXF1PNDnezl9NopHd4+TIphUYVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiI90TURudgdkVHt5bv3QgD0NtiICEkLgtTRwx+Rm3Y=;
 b=nAQDCqFp+Dbm78/FqHzzDJDkh7o+tWLMG++WXQKKLVbnMehWQ+/S/I3E7bzbwVFUANT88NW7VQu1BJUsH7k4xM1NVHRp7axQ1fI7tUA5Db9dVUJupl0PZ3aMK9AhHe87OGmlbbNluTidJOI0f4b1ZgRDLsnLz2qmj2uWPXYYiGNYdSlSS0tRjcCivre6cxXNDGLYVeTw3aLaxJkSSEJeI0FqJFMZu1VMuJITPJEa3cmCD80Kfh6OS/7J0ZBwgtYihrauSTY1ZgeFFiovqrMz7VZDa0bog81pZM1yA3ur7O9SPGkjsttjTC05jMa2V+Jzej3XQqxvns/7tcoNL++h8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiI90TURudgdkVHt5bv3QgD0NtiICEkLgtTRwx+Rm3Y=;
 b=ZDNtdSORTjLSz8VmkMh/bsLnUmDIE78Em1U9d1l198pjyi4cl8CZfUrle6loSz2NPi9gv+j1+fHrkEXLiv8zOftcyzmo+dI2IeUCKknjLOYPmuZrD8++VE938uVnDgHHI0QCbkQFUCGOTDB4T0HbxaZngLc7Kf4bnv3G5JqMnXE=
Received: from CH2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:610:38::16)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 09:54:30 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::eb) by CH2PR05CA0039.outlook.office365.com
 (2603:10b6:610:38::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Fri, 21 Jun 2024 09:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 09:54:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 04:54:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 04:54:29 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 04:54:27
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Frank Min
 <Frank.Min@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix smatch static checker warning
Date: Fri, 21 Jun 2024 17:54:25 +0800
Message-ID: <20240621095425.27355-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bc9df1-14a7-41cb-05c5-08dc91d82525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|82310400023|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FOlkA7TmorTmUbHRcldkAzrZfXqg8e8UdFPqme5gimJOTeNY4VapQkmwG+Gw?=
 =?us-ascii?Q?dDl95yhOlIsrtHWqm7rQW/8OP6qNmesINNoBu2LfK3KXrmtLrW8t8cQZnIcd?=
 =?us-ascii?Q?IdzrEgDOsx3WWRhWOKRVVstALAr2V8FTwUDC/2dMa4HJU2x8Cu3FyCEdOTMz?=
 =?us-ascii?Q?TsnPzKswiLpC00yt2F2LDRbTlhVyhoW4CFj799U6n5VA+V9OwDsPHtTGShWa?=
 =?us-ascii?Q?5GWxyJA7AfZ7Cq6eMaGxryM/haZ3poV3bI4Wp1tf/wGVzyVrmElycggVogcd?=
 =?us-ascii?Q?WsgxQ085H2e6ENTnj4iBJOPbKJ1cJDsKcUBxgLVdsj+q2nXKucD8MtVS8G0N?=
 =?us-ascii?Q?balq7vL5/Vk7y5Kr0a5Kam7pfKroUL1hM9YvW3mft6l3O+Po6X+cFRX2X6M1?=
 =?us-ascii?Q?ULK+L3tHlhJQvOBZ9FwvTq0iD+fm2+rLaBAb8MdyZ7XjlKFwfHi5cvzx5+fl?=
 =?us-ascii?Q?g6uLTHsV817kavc/fEmiR6VCmnp7wkXYuZz6TiIExqPmXKpUIQpcY7tQOiLE?=
 =?us-ascii?Q?BnmycrdJRrcAia2+BfTCin0VvjqjllqpD+SLqcDbcap4ec2/Q8CzAAAK9v1V?=
 =?us-ascii?Q?dvysL5Qs0xi9+S8ea066hvutWjjEycHsMbV4Se71b+RPGF0NS33z9YH4Aoqd?=
 =?us-ascii?Q?Dgn4YDG8Qtaa+RIMC5mo+1oXg4kNu62seM4fXb2Q9ulqR1h0vyTxc10DZ5xV?=
 =?us-ascii?Q?ZM6nzi/T0t06GN7QiQV+CIIVz1cwz2T5l/b7FovNV+emKUu6qVlstZd1jVrP?=
 =?us-ascii?Q?odL0iz0BhtKjqir+QZ9eWCnMzIvQ5x7nRl5z11aJN3+ziN6cPmXvWsL5gVDl?=
 =?us-ascii?Q?y/7xP5lj0Y+p6IeriAo7fNJhDSpVFrue4QOqtjlBIrCfBmcatR6CwY4i4xt0?=
 =?us-ascii?Q?+2trvV8UjtB3LBWx3VS4PhKp54QOyGgoamp+s6/SdMi3F7TpPYEHs/bP0bm+?=
 =?us-ascii?Q?v3sm+GAG+TAWNRFTdNe3K7JKU6zMjrrBzKl2Td6Vn7p8CaY7rgwhwtlrX0hW?=
 =?us-ascii?Q?2bnIC7+SrgMtTHZta4LWHREbbS6J4EQPJUurYWVyh+PJjdBOcgzRf4qgxKml?=
 =?us-ascii?Q?mrsUqsz5i2KVgU+3If0rtD4xfzxXjW2c8toFI6oYjU5TS7KQU0fE+OCIJJFj?=
 =?us-ascii?Q?po37ltTPs3ED1s5OeZUpgueq5ILs2/QJwX085CLLIyrrRVdWTo+RJAWTxWtd?=
 =?us-ascii?Q?eQGDOWDJhhZbSI2JYpHoM8gbys/1a5+aoslmmL5il3L8gk3HcgpNVCpCt2Nz?=
 =?us-ascii?Q?d7eFpvFmhlbwvhg+s410AxgY93nu50GpM9j3IogaFXpKVCe00ypPk7GkDhH7?=
 =?us-ascii?Q?MzlEZsvq1+K7OXeVNVADcBp7WDvxXYK95N4kGteWsZ5uoLh5YQ1sSsGDIGwg?=
 =?us-ascii?Q?RZH77l0LtZos3wQliCtoYemWG/VtpkOreRMKgaM0nVfRuLWBuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:54:30.0820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bc9df1-14a7-41cb-05c5-08dc91d82525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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

adev->gfx.imu.funcs could be NULL

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b4575765d7a8..5c17409439f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4498,11 +4498,11 @@ static int gfx_v11_0_hw_init(void *handle)
 			/* RLC autoload sequence 1: Program rlc ram */
 			if (adev->gfx.imu.funcs->program_rlc_ram)
 				adev->gfx.imu.funcs->program_rlc_ram(adev);
+			/* rlc autoload firmware */
+			r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
+			if (r)
+				return r;
 		}
-		/* rlc autoload firmware */
-		r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
-		if (r)
-			return r;
 	} else {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
-- 
2.17.1

