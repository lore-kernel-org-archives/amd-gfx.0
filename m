Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30000C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 18:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C4310E662;
	Tue, 11 Mar 2025 18:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzvYodh9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4E210E662
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 18:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr3Y/+0pF1D5tIKYwkSawVgYEKWdkkTj0EB5chdSFBYRVSyCmiUrv0CvpDA+SdJzzhGXWQPcEqYnKyzatnOmLS9NR47XCvvZU/A5LeR3+NqiM5j6Fo8dzN5e9Er0kHwVpKV2ww/yqsMRWrcxeTSWVffIjlveKukJDLmk5saYawcNbU8mLMgAUP9du9Ap/VdMl3kuXJHqacnCEjfPFpsw701Vxlq17HCjhTsZLSJOJomkoG/IkubAtOQpj/k9E6alfH7Q8WIvscvwK6jRILGVQi7swWZOf4s6MZlTt1BPiNrYOr9RY64joF6/ILVICGZjfrj4aXyss7BLPDdDEnrvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxukFRwFBbU6WMYZoNerGopk+ee8EsbQ4R+bc9x/hXA=;
 b=vQcBr36F0nHrlAYkhT1XqWjdxL3R1qr3cAJJGz1szaFvYK2IhaR/mJKLCtrBWXheDRNunn0gNA3eSNWbiryawmzl+vbEumdhWw3L/JgenD4Yl3j6UL7YqugV1216+947OonAyJz6VH3jRhtOLaHJbGOytwTJwzJQ3yovd36ObmsMhmsqfqcMVepanz1wbjwUhkE8wwpF/SD8Ku/XN5At0uIUXy6TzjjHqGzcVNeyTYpMdKkL5Bt3u/D87EiUGlnAxKi9tgmmFpTZCTMUm8GTPnvgxmaIjeXWGdzkQrJjb31WzeKjXG7P9bgukYwC6gKmJx7HK35C64YnmCDNWdpn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxukFRwFBbU6WMYZoNerGopk+ee8EsbQ4R+bc9x/hXA=;
 b=QzvYodh9mJa5Wd5Np+XPjZnun4gsS6OWI3/tgER3be5wPURFVNyEwZz7APLiwtPEg5bCBuk6L2QYaJyvuQzobvB1A7+whS5d08G2CrqPwjzD6fwPrHIbI7Ml5p8Jl00uwJFhBqS3aZl+xQxsQuNBmBszQs2kiuSJbSfIMwd/Reg=
Received: from BN8PR15CA0052.namprd15.prod.outlook.com (2603:10b6:408:80::29)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 18:17:02 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::ef) by BN8PR15CA0052.outlook.office365.com
 (2603:10b6:408:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 18:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 18:17:01 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Mar 2025 13:17:00 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amd/pm: add unique_id for gfx12
Date: Tue, 11 Mar 2025 14:16:49 -0400
Message-ID: <20250311181649.114559-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf21e4e-ff2e-45c9-92a3-08dd60c8eb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KjZj3qOnke+8trCOnjAYDrbjhYQ+i1DGdEKhq+aHAxwmFDyYK+vIp4InQWVx?=
 =?us-ascii?Q?ymuzk61UnuS518+ycyigGwNv1f23xB72UXkS1c+yS3bWAR5HcEtJOvtugUPJ?=
 =?us-ascii?Q?Lrjq6jJaMqNx+7SghaaGueGnrH9RPWSdNcSmt8I6j1gLSWhbQyj0V5mNVLQT?=
 =?us-ascii?Q?DSbQ59sblzAVW9F0s/u/CS1CFx9/9YgTtQpiEVAoNT08tOm2jPldL4negPMq?=
 =?us-ascii?Q?KwsA0F64H4syhhLjyLxrV4Zpmi1YRbiBnsPzdfVYxY7GKJcLF9QRz4OusAJG?=
 =?us-ascii?Q?Xp/lLVbfaJwuj41KVxyqbzHAuT0K5uVwwPFXmNaCP7nYOp7HR/Mx7YwJ0Zk/?=
 =?us-ascii?Q?97JE7j297jdQQd6NoFBaAjtb5IG8J0kmufshua/kRnrdtcc+wGlgQBmrtvmm?=
 =?us-ascii?Q?cWxniFg/Bpd9BpTrv7yvBJfDMe4xDWRswlVdzZ85m5d/po4x+RIXfMVN3CWQ?=
 =?us-ascii?Q?spXKVPiCNOX6WoSXSPXH0Xiq3+AHlsfAB32CRjt1ObBRYLo2/Qxc1ifn4p3i?=
 =?us-ascii?Q?Bp3O33f+hLwnq36RWqFp/oHxeW5J1hhNMC4Pp5AEKLfuhzco1PLwFAm2WOwn?=
 =?us-ascii?Q?2u/WW2WJLEDoW/sKjrA3NFme8R/UYCOxTPwGGU1ZLqZTOkC/1eFYyK0UlVKB?=
 =?us-ascii?Q?zrC+/lIDjpIRhC64cu33znTpjT/0TMxqpDib4oZUckzXbZ1caqEdJMekr4qd?=
 =?us-ascii?Q?AKkbHdzTYYqPqv/xC82VvZiwyV3VXLIeA8J0hTsYQy0fApX6jOo/4vqvw98o?=
 =?us-ascii?Q?ep55uLzBDNfbddvMqj6a0r8PMeRUFlKCizPXfMDUaVmCSsHephcT2sCSdD25?=
 =?us-ascii?Q?kJMlwMqpni25MeV7ygeragogGxxhA7uybGQScxFKFE7Bgo8CKKS81FKwoZgX?=
 =?us-ascii?Q?YV6dp9uT3TlVO9j1p4EVfwmeRbptl4IgaZPEppjZuKTt0owY+CWKiza2gWyk?=
 =?us-ascii?Q?iRSgmOEzhQmYZwtvCDQHsOH4Xq8cay6XdgO3dTRD+43tOI3dawOL/fAEkQi2?=
 =?us-ascii?Q?xjsg6+QcSQCnHPrEKk8WTMdti1lcD3embraiM2PTpYP9r5tVuSRZ1I/8Uztj?=
 =?us-ascii?Q?aQKqd4pPo1h56a+0qfdNFW61HHEM5e9ryMsCLogeK6mMXmxO9oyBHdbvgFbx?=
 =?us-ascii?Q?CC91QzT/0gBSQpKMbiF19jAkcRu4gSuAJEW65EI1ijDU9lO9w6PnbO9/skXH?=
 =?us-ascii?Q?mqacmjHKda94UhJXeiNK3TJ3yUUqs/8SSMLU45smRSYdhhMJN5oIJ+wNWSUZ?=
 =?us-ascii?Q?aCSf6XPKYeBqPCPFqi9Dh/pI8Y3SPSebkTHhjCwzDbEf6rQoHsynUkUlWVlA?=
 =?us-ascii?Q?6NGjLaPzn5LoZsqjXBH1ydclRnu8qGScvIGj7M6fobYt7mzH05qwSq/zdPnn?=
 =?us-ascii?Q?Ms4sS+3eYDdAIZ0rSXge7e81nusn4Ijvb3J1RZ6NLWx6w1eKzAes0cuSG/k9?=
 =?us-ascii?Q?XwOhznFf68qDHtEdrPQ/1QxVJ+XsrmtoWIpOuYtsXPtMQUCwQCkVZJMd90IH?=
 =?us-ascii?Q?gaT9FCXKvIfccW8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 18:17:01.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf21e4e-ff2e-45c9-92a3-08dd60c8eb5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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

Expose unique_id for gfx12

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1d04f1b79ded..2179344e78d9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2341,6 +2341,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
 		case IP_VERSION(11, 0, 3):
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
-- 
2.34.1

