Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAD3C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F7310EC1A;
	Fri, 11 Apr 2025 16:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkUOLc8I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B2B10EC1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQBoPz0QDrnPQYHkZ3c5fbERAAtc5NGN6/oAXSPXl7nGkgti8x5cNmQX+K8BApr75KJZPfTVehiRc5orXCj24HdPk8twJapmRhVIXvi8+1YIMOhCqXomzf304SC4yAG/xHhOMIzNJl8rR+2bsXpOvq9crsmZdxY+EJ9uDlpZqqQn2DE8nriCelybEPSjztJUiVEhau4Z2mhjHC4iD4ElXPwEFz+U53N6KKjsa4NUs41yhXKbjEphVtaAbfOQU4MCt3O0gLNbVL75nLK4XC3fcMdnngufOafFXtKLqyohFCF1+XiYPIcCzfPBxytE7OIuR7QoX07aPu+O4Ql5lidZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk5c18bE16p+tBFh/7yy9kunZj6iOZYYuD9aGQoUm8Y=;
 b=h/588Nnb5zkHdHcVjh2QX7ywOtj8vnpyiT5yMd+S/0cWO96/tlz+YDUn8MCzEttZ3bwqhIVKG9SQM4jo5MRaGiB4h045YG2vH12RN7edzcfbDZQlo0t3I/6IoCYr+RH/fzdEltCUw5jWahtdlguqQ6SVVdUihlwkA2hxzFpDlBK5Dk4QDsvIjKY1jQMwOyoCum9dpPPmXnzvTEXdt6PO+eD9Ln/d30wo6YMfja5/ZI80/QHi+u1uNhvK2r1MJNRLKNGBdlVRg9J3I92ymlBl1hHWKvDGTZg+Kicws3sCinqFdzaeyh5ui16HuUGgLD6FWGqeeZK8J6/gK2lHDDWf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk5c18bE16p+tBFh/7yy9kunZj6iOZYYuD9aGQoUm8Y=;
 b=KkUOLc8IfLdNL/90yoLmMP2QTiqrhghnyOdZO8ZMsYEHbD+R2n7JuLqAzkSne1pU7fYoRjQyuTa/xFTmYdpEWXE84AkqCYmXE11LjUa4fap2tVGGA+DA8hv74f2TRR8FgX9ZwxL2BwEhZaZpjLkqEidDI2EbesQDLSC2siDDdVo=
Received: from SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::30)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:20:00 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::95) by SA9P221CA0025.outlook.office365.com
 (2603:10b6:806:25::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 16:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 16:19:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 11:19:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: Cleaner Shader Management for GFX v9.0 Architecture
Date: Fri, 11 Apr 2025 21:49:41 +0530
Message-ID: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 9870a369-78b5-4401-6d19-08dd7914b45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NS9PZjlsRC9raXNEUkk0clIwZFVONXhIVUkwcGhScGNJak1DRllFL29EQ0Vw?=
 =?utf-8?B?TDhjZUtteTcxWm8rL2hNMmJwNHI5OTk2MkxOTFBCRUVETEs1UFVWWG10UXEy?=
 =?utf-8?B?Qm5QNWljYVRYNTIrSXVSNzh5Y1Y3WjM1TThuVGUrbysweDl0cGlSMkVHU1FP?=
 =?utf-8?B?RzU5cm1vdWViMlR6VHI1YmMxWFhSNGIvMVdnNkJUQ2tYa01wN044Y0dwcW5y?=
 =?utf-8?B?R2FuZjJJMjFHVTlnSDJybXpZRFlXeXpCYmR2MWFTS3lRbGhJcTNwT0EzVGE5?=
 =?utf-8?B?NXIzQnpraGh6TjVQL3pOSXloR2pKSndydWMrbTJocmR3S2x6aUVIV0ZKUy9B?=
 =?utf-8?B?Y2ZRZnBNVFF3SUc5bjlxT21ZUHZNY3pKYmlibVNXd1Y5ckZNYlNGcjRsbFZ4?=
 =?utf-8?B?S040aCtScmRTUnY0U0Y5SmlKQ3puQ21QMGlxM1MxbldjakZPeU44OXdIOHFJ?=
 =?utf-8?B?cFhhMUcwT2dVeWwxMXUwcWxNWXFLSFYrSlFHYVZndWh1ek1jV2J4OEt4Yzc5?=
 =?utf-8?B?RTVQd1BENERjQ1R5YkhxVy9iR0szZWh0d0FKM3pURGR4UUFlRWxXZnU3eERI?=
 =?utf-8?B?blcrS2liNjR0YTFIWEZ5QWpGdHlYVjY1SkJOWTRsRURiTWFyN0R4aGxTcmg5?=
 =?utf-8?B?MUJ1Ni9YTisyalBTYm4yL1RZc1lpUm1nK0hGZGhodW1yOCtJejFZbjVqR25x?=
 =?utf-8?B?anhYbXZPQU9ONWNxd3ovVEp4U3hiaWxqZkJkc3ZmT3MxSmxZcGhaak1QZ0x0?=
 =?utf-8?B?NjRqTlZHMk51T3hKT3R5enEvaWhnM0pES3lvSnI1dFptdCs0SEpXWHpFNEsz?=
 =?utf-8?B?ZGFQYWt6UENUZmxQQ3dCaExRY0VOUWFYTkw4cFlUdDVTa0lNNnhIRzUrcG9t?=
 =?utf-8?B?Z2R0YmZ2cGx4RGJXbVB3VmpENXM1OEVLTWd4eHFnUHJoYnEweTZGc0JpcnhF?=
 =?utf-8?B?M3MyQXBGTzVDVEpwNkIwQnJqMXA2ZThkVWFLREFuNHQxemNqQ1hKL0Zid3dO?=
 =?utf-8?B?YlNTMWt5RGxyL3FiWmgvcFpUZE1LdXFaQVJoRnlyNEt4N2Q5aEp2bjZsamln?=
 =?utf-8?B?SDh2R1NTbW1HajlDWHA2d2pLdTQxc1pBRURGd0xPOE9qQzZONm12QmtYVnlv?=
 =?utf-8?B?SVNMcDQzN0djZFp4T05haGtCVWNZaUpIaXBUdDhyMklEekJuN0picm9JWk92?=
 =?utf-8?B?QkxJa2FLVVp0WlVxcnN5S0o5S0l2M2tvN2NlWURWdEdoZW5LMkh5ckhDUVZ0?=
 =?utf-8?B?QXlKci9WRGJJbVY3TkhIcklBRFJEU0JESllhRVNjNjllSHA5b01MVjBWQXA0?=
 =?utf-8?B?OG04Y1VJTjhGMVprazQ2dG1yek1kOEZnQ1VzNy9lNGRmcHZ0aXNTaC9Bcm94?=
 =?utf-8?B?L3ZHczM2TktaWkZDU0ZZVmVoM3JPcEthaXQ3aW5QNmpoRzkrV0xFckE2bnY1?=
 =?utf-8?B?ejQyY2JKU2RHMWY4V2FYa2pyM3o2UXZWSGFBQzg5L1VaalRsSWJQM1dzbFRB?=
 =?utf-8?B?dmcvcHoxU3pENEE5N044bVNMSFhZZVpNMDVoMDE1WnducGF5VTZUNHdLSVcz?=
 =?utf-8?B?NEY0TzhPM0Y2MzRVb2NBcW0vaHFqZ2htRDc0bWVsOTgrTHFXNU1FWnhQYnBJ?=
 =?utf-8?B?V3huY1RrcEx1YmZjMWpEcDRJQSt1UGlVbU1yYjRydDJUYm9ra29DaDRmaHY0?=
 =?utf-8?B?OGtoMVR4SGJIU2VHTk1EM2doNjh1diszTkk2dEszSU5JZUd1K2QvM0EvWFJM?=
 =?utf-8?B?azRtdStrV0l4ZXYwRkNVZGxPY3lvdTB1SGtDbGcxZ29zWDRUY1ZHRWhjYUhi?=
 =?utf-8?B?bUxMQUUybDQrU1djaW9VcjUrRmNCa0FnV05DOHo2Ulh6L2lCcGV4Vm1rYWVU?=
 =?utf-8?B?YkxZK0h3eVdmS0lzZ3EvTGlxQjVMajBNZE1oZ01QU3ZscS91aHduMUkvZ2hr?=
 =?utf-8?B?ODZIWGd2VEdIVHF2NnNRZ05JQk1rUXZ4dXR4alNabVpzRlVSUmgxdkFZUHRw?=
 =?utf-8?B?NHhJdjlWRFFUeTVIbnRST3RMenorZU1uTktSTThva1pScVBvMTBROFljbExh?=
 =?utf-8?Q?Honaff?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:19:58.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9870a369-78b5-4401-6d19-08dd7914b45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

This patch series enhances the management of the cleaner shader within
the AMDGPU driver for GFX v9.0 architecture.

The first patch introduces a new packet definition,
PACKET3_RUN_CLEANER_SHADER_9_0, to ensure proper execution of the
cleaner shader for specific GFX versions. 

The second patch refines the handling logic of cleaner shader emissions
for other GFX v9.0 variants 
  
Srinivasan Shanmugam (2):
  drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER_9_0 for Cleaner Shader
    execution
  drm/amdgpu: Enhance Cleaner Shader Handling in GFX v9.0 Architecture

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15d.h   |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.34.1

