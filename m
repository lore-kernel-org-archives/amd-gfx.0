Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AF3C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 06:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC03811A199;
	Thu, 25 Apr 2024 06:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZhgApFVL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75BF11A198
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFCaXI8kd6FqOwtBQ0ixjzXYw6R7Il88YspEZou4TU1czDnM3RxhurSWgiNtWJe5/gSxXzYrLJGbZm0HV7a9EGcA/ACcYrPb91lNv/fMmcu0zKYR/Y6H1pNHc7skq93dL2ZdPuhEyM8eoE/WqtBlWUZcOuIccvhG1F2noFNlPcV7HKznxmOMKXbcU6QTGqqvyUnQDCUsDfFLIyIQt8dNDiafQAs3Evqm0OnTjUriC8y1xC9sCfCE2CgbYeepgesW4rKKGNNKgIRAJXzh+4263chs9nj0eitm0pSAsAhQiFFi58tcYeIr+6ycw3dAk2mCwWY7XFBwSK3y83lR8m4Sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCaSXzGU9LYAOM+FeBpS9ytiIanw/GTKZ20T8hdV63U=;
 b=lWIm8+Y8JxT+hovbrLcff/Q99F/WDPN5eMHFqkrAyjmq0wG6ECQW8Ss1rIDYUgDrCr6M22+7fIZZyrBwZqW/Bl0EkKKZM+tbnyXJ8eS7Y+w+Pb8gDYDdSbW/4pXQPwaKCTPOg4ber39obcOAywFBId2pREC6z+WdxsKzCj9IJpyaehe0qmn5LdUWglkawZbcLMFd4tdrty62A6oDVvrLoP6jNxXO/5V2fTdy0ygXN83+Zcf5w/Sb+mv+oLr7PaLLowwgVY5Qy6JWqZYwNWwJ8LuKIB57K2OVY2lEl5s2xSdR54SS7oqdUedjU0C3mnnh11MOL7om/fgpivMMtSpWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCaSXzGU9LYAOM+FeBpS9ytiIanw/GTKZ20T8hdV63U=;
 b=ZhgApFVLxSpmGJWTnBJeTISwQqIknc20A7MsQLMjOHcbafdc3bhkDTTdss/1BRWif9B1NDO7A1M8iX/QV+D/oTwMZgLiZ9Pn/edp75U5YYmbaXChin9dsb9hmGFSn9+0fpD5BWPskc1Obs+bCjZ+7BclCmpNDIZ0SZAS1Ex0Rr4=
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:20:48 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::3d) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Thu, 25 Apr 2024 06:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 06:20:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:20:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:20:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 01:20:40 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the warning about the expression (int)size -
 len
Date: Thu, 25 Apr 2024 14:20:35 +0800
Message-ID: <20240425062035.905275-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6cdae6-5345-4477-c5e5-08dc64efd965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ggEqD2Ysk9L9GsLd5utz4dpQL49iMbUKxULiuC1czOnUGbmHEDcB6MmQ86RU?=
 =?us-ascii?Q?RcD5SO+dEXplGJ54c7gmDu/dnmmoe6K9Av4RwKEDErDy3lcxXO1LrXgsDhOI?=
 =?us-ascii?Q?puqkPGvR5q+y5vnyg2ohbI8F4Ocq4V/bZ1Hhwz8qnOGIOQ+7OV3ADag511L7?=
 =?us-ascii?Q?xxUsmjjUNGYMiTQxk+ejaM/sD4xXlUf4SfPgMVN/uTgeClvgGCjEhXMslylB?=
 =?us-ascii?Q?0OXvg5I4ElqMPwqqwS+YPQxoHLETs2erhShGSALoM0wniUEdxJuLoQ8tP+ea?=
 =?us-ascii?Q?bPLxixS7JQZZgFv0JbJsibmdl9cdleIndobUnAqWXA6aas8gFLXFePI8pRH5?=
 =?us-ascii?Q?NCB3URd0eURQRyA51lG7w8hUXAzCptbsWxj9v4XscGQ4UrAAEJn4SvcqPN6e?=
 =?us-ascii?Q?MJ6Cl2548Kto4T3kT4MNQ8vGlibiJ+jUcwqiDPg4N2hOM2qpVI8nhtGqu7pR?=
 =?us-ascii?Q?6SuX8fKBFjz0f+vTue1zx/LdG2Hrp+r3gqIne2GGcMpwBC00CFkabd793jgL?=
 =?us-ascii?Q?tBc7+vxvpa873Zo1Rs7CsD5dcPk+GuSwMJmFKY3OXDSn+c2ls6KuSLQGSEA8?=
 =?us-ascii?Q?MQw4u162xJLbfoXohAXIITRnuLlkjuLu3TkjQV3uEaa3+ZwYEZLxVpY7GR/t?=
 =?us-ascii?Q?AXNe0rFu5P4MxdmCpZ2128JRnRWmRIlYACsjzI76Pz/9G2l+BEKkeaYAawah?=
 =?us-ascii?Q?vkWRIVEVYlxPIO9ks1/l4NkoJT5e+yk6efPbN/DNcBXVa+MvY7e0GByjNhuG?=
 =?us-ascii?Q?lJhDfYQLcpqFei9LXrVt1g/1/ZWUooWLYY8BaJuMdQmjxDLT5PoCkqKOdvK8?=
 =?us-ascii?Q?hnx2t+zyf5BgzwNi387GJZzePwLYeFUWu2BYpAzFNsRbyvzvzcMM5b+cRqye?=
 =?us-ascii?Q?um0Ou8G7XP024uFCuKxvm07D2atBWI2/Pfo/1o2zYrkU7VpKmMTaqe4TcjMH?=
 =?us-ascii?Q?NwQe0TXgUb1R8m+DDcAoh/ylxS0yGOtgFS5Y8v4Uu6NgJGFAmtahr0FXLvBj?=
 =?us-ascii?Q?bfBoYoSmb6vFJRetEw7fidXwp/LBhzV8NUG+5RXL2D+ZXln82Fa7gDHwQrYE?=
 =?us-ascii?Q?UEYjCMTCB1z5RmaNb9chf49rd0TyvN1hegjL8/sLtz9g7B49vuF7JGIr3VDR?=
 =?us-ascii?Q?4d+1Nky0MsXtshnqx/tAW3axXb+rZKPMKqdpzteO5bqRai/hkVVjo3Jebus2?=
 =?us-ascii?Q?RCWTkQ00EmLbuXO9zoC+MY7LYXwIoVB/enMqpVTyQQN6Jr1caDIH9L4LJ9XY?=
 =?us-ascii?Q?XOOnIafLDl5LtqVj7XE8+D3PI8CmWvQBcJ0+WhAdlxuDlc/Eg2Ht9iz90lgc?=
 =?us-ascii?Q?6J9+MrKBRGxb1nLUYQu1X61xDcYEUtIa7dGKnMvecEpMbM69x5mkb/gtl4+3?=
 =?us-ascii?Q?XBAa31Gr1coLmqOSjSFsdqS13A+I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:20:48.5492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6cdae6-5345-4477-c5e5-08dc64efd965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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

Converting size from size_t to int may overflow.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f5d0fa207a88..b828aad4f35e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2065,12 +2065,13 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
 	uint32_t *new = NULL, *tmp = NULL;
-	int ret, i = 0, len = 0;
+	int ret, i = 0;
+	unsigned int len = 0;
 
 	do {
 		memset(reg_offset, 0, 11);
 		if (copy_from_user(reg_offset, buf + len,
-					min(10, ((int)size-len)))) {
+					min(10, (size-len)))) {
 			ret = -EFAULT;
 			goto error_free;
 		}
-- 
2.25.1

