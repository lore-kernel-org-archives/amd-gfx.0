Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC49CCCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 16:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8080810E39E;
	Wed,  8 Oct 2025 16:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IHDvNk8M";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7039810E39E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 16:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph0ctUGDTVN5lDnilvMKg0DoaAPqoBrfmS2J4b6x+ksBUJgFGBnK4Gc0zP0Iz2+lji5CTAvOhUNqVLN2bve2QpSx1fIWB1ISMK12ziie0QYPwklBDy7J8oLZvFRCInkSVQZhE0CYBX2HZPN74gF5HsCRC5BKa1Vm7G0Yu4/ZsUURCjB0D9HASPcXsH2M4/NmBPe+faCUvRp4pr6ZFBs1lMvY2H/inD+CcLI37sogtDk9g7VRFGbj+b4KOVR/jt4NBO00YkMhrlJz3jP/mu+D6Q272uS/Ron2sk3tJ3r3fB5KbmiCkuQYK8UAqhHXjqeH41oErOEaEu9jjGjl+qRhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/0VsVYmFG2hho3s04USOB1xFKtLmhO764ecBRXTmQc=;
 b=BpL4RN65jBXJ1ypnFFPxS/n2ZpFDUoOXU0UlU+VPNQ0X2bXxD7ZZ1lgXuWiqdQbDoASnYidZ8nsFLKC7pPiRxIXRV1beycdLoF9fd3OmUhyCCiIp8C5BQB4enyU/UopqMAbjqB8Yl4iW6mYzeMvesTr2vOsX3uHiasRGOTZFqlByL8hyYDWiIekN+B19D7Vjn+VXyYaNa7xir2QqKG8RqEp9W+lexINgjSDHBYbPkI1Td81MV92oe0bdGkRFrebuxq52tH63mZMnQYt+Azl5SrVceFVUHOm34luC2DoyLxnEqViG7zZUM9aJSoFMjYAEEuA393Nxhc3khe67mmaOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/0VsVYmFG2hho3s04USOB1xFKtLmhO764ecBRXTmQc=;
 b=IHDvNk8MY8T+iisYUsU7wZr+sE07u/nMoyx4CNQurTy/8Vw07oaY2fq15DXcbRKjVGusl9E6tDwM44HocQsnJ8GD3rX6NEUuyoR7MS+PL7w1+kIzDdIhIOv4eKSR3eGgLLR0btq0DbnUkFiVcw7yUg9jdJ3YzhahLT3vBRH+31Q=
Received: from SN7PR04CA0108.namprd04.prod.outlook.com (2603:10b6:806:122::23)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 16:44:16 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::7b) by SN7PR04CA0108.outlook.office365.com
 (2603:10b6:806:122::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 16:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 16:44:15 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 09:44:14 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Date: Wed, 8 Oct 2025 12:44:08 -0400
Message-ID: <20251008164408.850834-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c83a0cc-6552-432a-49c7-08de0689eb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iwSvuzowDG7tWCM+OBWONUO1O3Zr39gll1CcnfDSOVRwLtjgRJ5kAboHhND+?=
 =?us-ascii?Q?MCyUoLk7b03AjJIZ4N+ba/xteb4lBiv7S9TCiitlBrjKO0/CX9mO5O7qttoJ?=
 =?us-ascii?Q?qNIL86k9yHt3oYqcRzhKqWJJ6X80V44yeIkI0Xl5lxLQxQh3uxGo4kgjlW78?=
 =?us-ascii?Q?NecKBPqlROsQuePRYD/8FvlymsbNJiOnsoIEE0XaOawLtwdPTwzf0H+cAvOO?=
 =?us-ascii?Q?6uGOUNhU7rQXv9L2vHoyVzVUt/i70IehaWlbVm3gAKkf45PV7lwgUoCaOxMH?=
 =?us-ascii?Q?2MJuZRpYktQ8P5cMWft9gR9iU5xJGfKZ7V19zMsEPc8yl4bsh9/bHx/VqF2Y?=
 =?us-ascii?Q?xxDsBPywMkY9g9EWEsoEHYUImBx3NPZ387Kinq3CugSGhr91vCgD9Bde/5FO?=
 =?us-ascii?Q?w+r7KaWsPbIPo/AzgnPy0IwWRdmnyJVRDdPICiiix76oapvMn9e/oS1DkgBW?=
 =?us-ascii?Q?Eu0dmrWcPoYVD1XcUZtYxUugpoRcqFca/hsUWc4H/pgz1OQA0DnY7nXb7R1/?=
 =?us-ascii?Q?t+/TvBfBo4avQeF2dxkT02gsyylX2fJGvAfLJpe/pg2/pbEz4tqYvwM89adN?=
 =?us-ascii?Q?u2KdsGg7tvLHaXr1/hBpDSYRTHy/rkHpyfUtirQMRxTK9Elux2m3mC10JURA?=
 =?us-ascii?Q?Ih/dg/urudlK1S2XVFoJs+tNA4wya5suWrZSqlc1SgAefbwFF4RviQj4+p1n?=
 =?us-ascii?Q?Qudf7xWNJVY0UDvzOjlOTTcFoqZaUgq6OlramLXAUmRwM50RzAngoNVnqi0R?=
 =?us-ascii?Q?v26RYMJn53Oix2lmnM5vncyXlfbDqcrPiKSu8jjale/BF5mjuSwWeOjNcqWJ?=
 =?us-ascii?Q?9mmqjqkFhEYJWmdfmNzkD/konQi9YnF6cl+F/pmyY56QO8Nbt4KgEyIqWOdR?=
 =?us-ascii?Q?zCv1ToZgP1uAH2HTH8NtkL+r7Sp0KCizLbJBkf+mOgh5ub3D78mY/4+VdL+r?=
 =?us-ascii?Q?Kq3+DbogMrQx9t2IMsBg8mD+G76gdZSmoY2Mj+GgWkeUO+/KJ1ntX0CQ6usP?=
 =?us-ascii?Q?beFp0o0KUlF1eYleUWxHTfZYhcLbKfw3xCOzx66VvjN9mxTSQ9JatbyTNpm8?=
 =?us-ascii?Q?GaShA5o685efpLMR2i8IuGN9m8+1MfQ3Us+kCzCMLfuUrGyXgVafMiRUNreP?=
 =?us-ascii?Q?AOxpgDrl7nY22fdmH3CKWOBB7FNWn7r8CozohQreiKD977B/3IooXMHtzxtp?=
 =?us-ascii?Q?v1JDonIx2iPOwM2WfymGv4Z8oWkFKkKj12g8l3RmtOyRMhOZiTdCJ4fSo6Y+?=
 =?us-ascii?Q?TTuSroj0ETRnyIcsd5rDr7enFG2NkvNVgiPbNrARf/stTFNL7XTdtaqIlJC7?=
 =?us-ascii?Q?Hs+sktEBpg/zxuOP64QJPM1/nrRB4dm4xhj8qKUVODDLh6XFEl+RDMODvyeQ?=
 =?us-ascii?Q?NlfaL2VP3J/FubnNz76iqrALPwVlJM6b+icgoh4MR9ce6UdYGAsstnQleOpr?=
 =?us-ascii?Q?0q8ce1+4S9ntzFurykfG1HKsvNmDv1I+s9aPfLEuXsY5C24J+Kj8m8XzJ9Dr?=
 =?us-ascii?Q?cJehC6Ij1q7Cj6/H+eYB4hZTj1CQX4szaq8bcL7/Oz5cAKqQSoa8sscxJUKc?=
 =?us-ascii?Q?Ji3R0krFMqiFeglEG88=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 16:44:15.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c83a0cc-6552-432a-49c7-08de0689eb25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

The driver currently only checks that the MES packet submission fence
did not timeout but does not actually check if the fence return status
matches the expected completion value it passed to MES prior to
submission.

For example, this can result in REMOVE_QUEUE requests returning success
to the driver when the queue actually failed to preempt.

Fix this by having the driver actually compare the completion status
value to the expected success value.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index aff06f06aeee..58f61170cf85 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -228,8 +228,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !*status_ptr) {
-
+	if (r < 1 || *status_ptr != api_status->api_completion_fence_value) {
 		if (misc_op_str)
 			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
 				pipe, op_str, misc_op_str);
-- 
2.34.1

