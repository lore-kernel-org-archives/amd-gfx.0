Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DFEC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9741710E806;
	Fri,  1 Aug 2025 08:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcjnCDpT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C330C10E7FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJNwWfUlPhJa91IpJf6EK2IhaAkEn6jF58ZLljq/QNWbM6Osl2TDxhj8xOSiTM1NxLJWHIB06SRJksO/iRvASw8nTlTmtRINpzZ4i5kKKqfbS67EC9qMWhqSGCohdvBluLOHeRmo3FLsIzGZfT8uTcviC25Z+vxRXDk4DG02EbIstiRORAMWgg7V5gdLXSmZj4pBWEKibbSymReMXUZIKz7F9sW6jG68FIGMoDah4MyqzBImW7gwSEKyshQPaQEB9AZzcrPC8L7h54jV4RA4DnRqqXCf+Men4GnldzBzbDg02/PMc3vi5qfi4zyDBSsWDSmkRRjzPZ/aivsK0vuiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6/N85KQtkYe0eQl3x5EHmKNo57OfqM+7p+bFDhUFWY=;
 b=rcvmMKqCp8k0jHvZzH0eDsuOPNHXQHvIEjtEcKDP8rXP6x50Zvr032jyzRYhWhGF8mvJP6jMsD3wdqXfiUH89X+CqiXYRtb9eMqQes9zc/2tZx6hGnhnTt5Lv+ci/tjhw55CVDMh10zdsAkoCd9K7ibjgCOmk8YF3yqkese0Fl9ety2aWgU137nk0jgPFCK7qDozqI/8fz/rqgxhhmKU1xRmeYIV5cdRVSuh2WTCi7ggSV8kXxHMQwC9RYqMJxrCwuJGi8yf3NCuvfqu5ZVgEVLLH2huVoeJoS3tUbmBoVSbiAz2KFHm/qH3Q5zLgzHvN4/blgI6pVHvwonAuBlzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6/N85KQtkYe0eQl3x5EHmKNo57OfqM+7p+bFDhUFWY=;
 b=KcjnCDpTHIJaV2Z00pg9Y6dPhNRXp+2mbVXj/VGJCwWb2OfStWl6nHGwzpjFO5Wn71kCsebeBnrEABQnzpRn6ejBXf7wJjy7wzLFI3t2NSzOFPFx8EKFTtG97+XbqvToqPO8pYRNHCQzjWySh+h3HLasYMxUyh5qe3xdJeF/Siw=
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Fri, 1 Aug
 2025 08:56:30 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::10) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 1 Aug 2025 08:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:30 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:27 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 06/10] amdkfd: process svm ioctl only on the primary kfd
 process
Date: Fri, 1 Aug 2025 16:55:52 +0800
Message-ID: <20250801085556.8504-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 423044bf-2ba6-4db1-a7b6-08ddd0d94e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLRKBGlHIt9OQ9XOSSOD5dt93gTRYaZfEJVvlgSEOv40HYD6AKVpLey934Us?=
 =?us-ascii?Q?Ni6wN2bky8duI+bauWTKE1aY0rKVfY4r2SJL82OOyDnWs00szPfaJwMFApjG?=
 =?us-ascii?Q?PBeqCLABKyRmelQY785tZLrnvzwSOTheWH9rHpUYuizMPJ/CGykuzq2uqzCy?=
 =?us-ascii?Q?1snSK8q/KWZ4WLCTDpJlLcu3Ag43KOQHflfAWaZDWkbQfsuWMf0bPDXeiiLt?=
 =?us-ascii?Q?2JFxbHLwC0i7VENpxAUiuJPyQe3j5OgH2oc7FkvqsFUrLE60XeCjSWA2rX/y?=
 =?us-ascii?Q?VpTAGxiFNcrCPfZmnIp21F12uauOLf/PZjNQWXZpfrXtJRYGZ0QBSVaF5ZBN?=
 =?us-ascii?Q?onMfQ1uYZvod1XCilnCl5lwze+4BGGZ/EO5Feus2e58u808QlYX/OO1No5qG?=
 =?us-ascii?Q?UIx5LMfp1r3chCvCUikhadIRRiPmc4Ecj5TZh0mNQ5B+/XY0SVpoM5uQku1r?=
 =?us-ascii?Q?Er/yNMp8ca1acGqy6nqlKLbx8vkAXpoINB6Ji7vM2nHPu0BgloporVikY4jK?=
 =?us-ascii?Q?WziYmBxotb+s41iYZawmXYPK+cKAD+2Z2VWO3YzNsWqrKwzBNy1qp9vpjRvn?=
 =?us-ascii?Q?OrPl0OrlIE3qjiLf7/0beJtwtHsuVgZbe/+tELTs8l9e+SeIPsdveeh+3jR7?=
 =?us-ascii?Q?h/oNzymTcnh07ap+6/TaICChURlBdc7KzxhAKBvhl3TppzHsIBYwMy4lFm1h?=
 =?us-ascii?Q?3+9AkemcDeCx7wQPpbEeZJcjzxwDdmUBgSDemHk2n1YD8oR61w97KyouSDUc?=
 =?us-ascii?Q?ySOkIB64CqfePIayMuvWarNrnzAS0mHs+UyiK2JD8G9K0HPu05fWCjnYWasx?=
 =?us-ascii?Q?jnF+E9/3kWdQRO9vmYdSsyhetzBbld6MzKDdSQ1czrlomdSJrEUYg7MNzliW?=
 =?us-ascii?Q?fy9a5krfP9ZoJkdQY6RT9YhFlou4fE9x5OTbXaqUDpkTjABZNMypZyc6yro1?=
 =?us-ascii?Q?vlD0itZnpPntLa+PHfvj3AATSPpCG9fc0KnORTauqTwgs10zwBGdAfhY1MlZ?=
 =?us-ascii?Q?sVundEkYmpTjx8FIUTMjYKbKIanLaS5Iy7JxcPxSGRd16qbtoQA3YCC05snM?=
 =?us-ascii?Q?yoyhA5DgtMr4P4vlwvbEst0Gx441puN11bxykAcV6YJwWDD+r7RcP82H1c/u?=
 =?us-ascii?Q?yzjh5uR8ro6ZM24Y+2M2E+kh4ZRD5uS9y2B+NBihe7jit9ULTGf/mET350Bb?=
 =?us-ascii?Q?D0a56ogcjqBbIVGcjxokXetoqRF0CvJoehNxROHd0KaHZ2OLUteP0nk044Ut?=
 =?us-ascii?Q?puB5YRBgk1W21gO/cXwwFrWYcHF2bGx05IW69W8vAeoPlMTtryGboua90hrU?=
 =?us-ascii?Q?LhVcYH2WnB/v3Iw1z4oP6Za6Np/2GFJ4whve/IH936Y5gtFtzDZzxxv2InPn?=
 =?us-ascii?Q?Uc8S88qoHW6aIGiiX5HUS393FB5JCL9J5RoDb5wUS8m4zNKCvZwz03hgVSpU?=
 =?us-ascii?Q?EoOVF26WrXe41e/BCE77ue8MlN9d/luJLhpGhddCvX3fTPPSJGJwi5Ja1S0t?=
 =?us-ascii?Q?bXwedW0Dud5WIJsifN6WdiRoNkmq1neVRvPk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:30.0115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423044bf-2ba6-4db1-a7b6-08ddd0d94e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

svm ioctl should only be processed on the primary
kfd process because only the lifecycle of the
primary kfd process is tied to the  user space
applicaiton.

Another reason is in virtualization the hypervisor owns
the primary kfd process as a privileged one.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ec9bc359d5be..b1ab1565a4cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1720,6 +1720,12 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
+	if (!p->primary) {
+		pr_debug("SVM ioctl not supported on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
-- 
2.47.1

