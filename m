Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0711CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451F910E4F1;
	Wed,  3 Sep 2025 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pLy6AFr5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EAE10E4F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HydVPeeuoPm/HCWFqqLfYOlBPDd7zPOOerwd8ryFIzCidxiI1cPBsmnjcd7GawRCj7MdcU3Qx64hzj2hmtXdqI4eEt9jk13KaY5tzHR3Imt2VH2vf5KNF76ItEusNCLsBrxkv7zzc7aI9we8zadejRnAdStyk0S3UD1/PEr+siaWJCdjSW4IWLhXOE40fbEC0+uBtmZgj5FkOJwI7zyvc8Hazyy8zbj8759DD3ErAtM/+r07qD89Q1/i2/ZnTZSUbobugqZaK7z6aMkzeSATiE1fO5lETY+l2rCJ1DYxgIsqJx7NktFJ28EEJSeI+/xxXa5BIQdldUAPbO1HzhUEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=Skd6DSu6EkFBR2J/rXcK8wA5oypiJOa5Tbc1N2F2QCXHw4JALO0EfuCcL29w8oovmCqSKm0Kljw3VEK94l8030Ypi41qFecGCksgVFe+nlZgSCWNFf1Pds2fopzz+puRD/oKVen1UG5odF7RMGEE/qicSu+RC4G2fOvqkN93114h0WYrlxbXPIQavdr3AJO+Z+An/+LmWLDd85WczR+ZrcJhi6HErJj/4sFHEuwaJ5IRTGM/OmIjo+4Rz0HwpFIKMW6Sz2xA0MawjvBytQEtsS/xI56eS6LdkbVw6TrAEIRfxntliiYBgb0ogu4PitvZEni2PVixy1vQNNko+Cj6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=pLy6AFr5UdJKFKxr+UccZK9tuxW/SGmzYOlvZcBJgZCyYe5LQxwY0uyxdysZcoC+eQnE1ktuxeHKGb7w2BCOFFR0lTJSzrHZLBGkgSxuJjPw6P6eCUZeaLzFqNwdJbfdkS8KoB7NkjHMbm20fThqT2PNt0diFrw8BBUrQJMrRuE=
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 3 Sep
 2025 08:39:22 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::c3) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 08:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:39:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:39:21 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:15 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Wed, 3 Sep 2025 16:34:19 +0800
Message-ID: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 622d4b9d-522a-4800-8b02-08ddeac56163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UNfAVkJB+6h1aejQpJndVtwiUgiE6wx1/on5PKhBKSzQLWVfwcqNE2C/eWqA?=
 =?us-ascii?Q?qPhK+n9mpK/pQ6oRr+LgLByUaQBQFmY3IIcrcE9Ar8sVE5kUxV114AY/73TK?=
 =?us-ascii?Q?LXFY20/7tMVaZYeb52G8MT3F5WSBrdHlE0+2g7EOw0hWIwLUXG6QUDGprhdv?=
 =?us-ascii?Q?xi8cep+bpICA9yKiJV8B0lgFIEhZaW4KWkoHqc72q2i6mbTZo7b2a2fROg1Y?=
 =?us-ascii?Q?N5VT/nbrjEoDfXssivfnr8/KvNyQCINACBixBwzmkmiqMxyjGvx96T/xOwrH?=
 =?us-ascii?Q?dCJrYzYepLWI3ku2+OKwpIjccTCGQWroY5bvnd1IAbBphpwSY+CKFeAYcs2P?=
 =?us-ascii?Q?p3tvw2KxcFwqvc1ca2lmkA6J1WR1k/humQu/xN9fQL3T8+RFBeK/5o0g34hE?=
 =?us-ascii?Q?iDINretGwDFyqD+wEqTZOUxoK2hlkRem9CDZ6FLpZmqiFh1qtGxE32NGqxOn?=
 =?us-ascii?Q?ltm9yWazz4P5SrPaw2gyLkMiPMdkuzINoHDvdhilNkgvwlbyGLf+2Iif5roY?=
 =?us-ascii?Q?plyfkgKXtMHEcjm6FY4d6jmkBpQJOGTknvxAueEYrzusIwR6EFJV0H8WksuF?=
 =?us-ascii?Q?F/OZnX3i5apQcXyjAfrHgNZOMmJLEU5KXwMEAQ9jHqm18MHgLYcbjHgHKRJx?=
 =?us-ascii?Q?CvfHRALmNirwNhoPK3+NhiApdtUW+0knVLNo3xIVZ6pKUieeZ0safFm+ILl+?=
 =?us-ascii?Q?ui4RpxgNXd4ZM51wzLOT3megaEE4qgpBvweL2ANeJD3G9svX0n9tVaRhySjO?=
 =?us-ascii?Q?S4nDkVG4ICKnisEZyhoEXfquRnwgjn+rW6Zuu6b5IpzIJSRlSvvL40Yz0mpi?=
 =?us-ascii?Q?w/DmHicYpA1w5LMgWsS4NW4oAcU0CCaN4RjvJ/bYoA59XOsika2sBJIvujEk?=
 =?us-ascii?Q?z5kthReCBImYpkllaSJ8DD812zk7eh5+9UaeQiicHwT//iwmqsDGFtabWyZl?=
 =?us-ascii?Q?4BCGLjgghdZIYmliGCQheOvhNpNbOMRLAEiS0szQ3zjqHAQHe0Pag8X3P+wT?=
 =?us-ascii?Q?VXbO7iuf0Gd3KoRkcC5P50KEzHB8iCz7SWXxv2XcJUSuaYMke2hWif/bpDS4?=
 =?us-ascii?Q?9c1pycnOXKoOB5u9o1oBcAGFw5n5WAWvjwdiIDAIJIUkPNzTk8fzsnutb2Ts?=
 =?us-ascii?Q?CeVI2nVDiVSF2QOIC84wiO88zbareoCHa8DOup5f58UV3ENtyniTYteAITsd?=
 =?us-ascii?Q?KOlZjXMa4Y8h/IWFkIvq+pdzPrE8fG6egYsOV6zY1XbCCLIGoCXz1b2WNPSo?=
 =?us-ascii?Q?Ef8/gIilQ5aEm92Q1LYBuSMtEGeVlacRelt9EuNIwdQwro0ETEZrO3HlCe3O?=
 =?us-ascii?Q?rQWXpyuOfDodTE7IVdYDPF9v2rkPZjRsOl4OIXXooATqTyCWNCS4NV0YpZ5x?=
 =?us-ascii?Q?fqhP//VJke8SOriaSclJe1W/vdKs+O8iCozJxI8/x4WT8gKwTH7u6YcgFzqZ?=
 =?us-ascii?Q?2DFOmhhDbtS25qInITj0vQka2I4RDs7gi1PuXHnjjyLRTbsMDUAJ6zILRfev?=
 =?us-ascii?Q?xQpf4MfQHCehTLa2lRANyx234V+Zvh2/ofEZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:39:21.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622d4b9d-522a-4800-8b02-08ddeac56163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

