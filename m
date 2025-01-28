Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7CDC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2874610E3F9;
	Tue, 28 Jan 2025 09:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fmyg6N51";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011DC10E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+9ib4+bmE+qnlA3mhr7L4nCbF1KpdBg2Ts88Fk3zoeqmXphRNvOCVQQoJ1zpxYp+xw0/gSYgboBvYUmt08R6nM/RhkXRJOms6ZukBc6ZY0Ij3t2rVaIo0h+OZgz1HFAN+f9rJ4+a7fFczUBfRgDxOd89HoAAZcTmafcf8FS9plwQiJInXXtqESFnZ4KDvIZjR8UKqkWy8n99xbfvqGnKxTi4vM7CoC47ieEV8Fc+2Ykr/x/1desD24MFKcy2F8D6fe8oDcSyAQwxgeGdh7ik20BXPTNRKMgcdEMh36E98qxd+WI0YF84JRuvajslQT6rUhgJOZsNgi9i3x0794awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf6kbuJpr6d/qDbrBdMiMp3L6dtQDte2Docg+PG9dP4=;
 b=UTQjP2XAzALT6027zSB0AXOQH/BB71mUSKsmxzPoZAGCV1Y/5mkHN4mAsO2LOep4vRUwCWHClQMaXB3u3ji1WCMWr0T6LJ3EyTpMExWpEY8Wu8WfdnfU5A23hWsQlke+1ZlbTYvFb0bmWmBWvUmAkLkBfBQ5qMntBJHL6Pw9TMDIWOi3956pqygggGLunMPMVC/vQ8XjJ5lnZDZZIKk7kFg91ZbX2+hNaUY9chX/Ol4TgMbBxjCn+VQKn/QcPaZv5A35HIOAQlz5zXkyxTcXX4uNODF5fBUc8RQW/vfjJCDzUIZpQkPsthW7yNAsdOgGkY8Gr4XCVJ0UFi0BTDH5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf6kbuJpr6d/qDbrBdMiMp3L6dtQDte2Docg+PG9dP4=;
 b=fmyg6N51GpaTxGM4NH5UZDkY7LZfKQvxqDTGomsn3vy+lFATpXpPz8HkF2YCHVqlk6GbxH6Zj8nYzX68rLxwKP92p6oyGKYuKf4SLFMhfcE/DOsWDf/EFJruvKsaJ8KbIpc/IXQ6rOkCD28QBNjEfe/J8qfrVBGy8bP02sinC2k=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Tue, 28 Jan 2025 09:10:01 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::4a) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 09:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:10:00 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:09:58 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 0/9] drm/amdgpu: Add jpeg devcoredump support
Date: Tue, 28 Jan 2025 14:39:41 +0530
Message-ID: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f73d616-ba9a-444b-2daf-08dd3f7b8b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE8vQUs4MmNtbzdHZFJ2ZTI3eUNMZ0MrN2dKdXBTS2pvdkt4Q0lldmVtOHUy?=
 =?utf-8?B?eERwQnFoK1hzbkhlMGFxYitNYjY2Q1J1d3lIbkoxZ3IzaGd6ak5oV1dSR01U?=
 =?utf-8?B?bUlnS1A5b2drNCttRysrTnpLSUw3VDd1SWZQV3dBOCtXa205bzFEKzFpTVdZ?=
 =?utf-8?B?ZTBkOXI0Z011S2hRaVRCM0VJdE1aWWhCWnpCWkRTUzdEQ0d0YWdxdS9OUTNH?=
 =?utf-8?B?RFJ0WDRWdjM4bkVabS9OQ04xekJBaksyR0ltZ3VrczhKdFZlaWZwZ1ozU0VR?=
 =?utf-8?B?czZ5Zy9KNG1kZDZEa2pIaFprRmYxZU9tczZsNzBQemxTdHRwMFVuY00waldN?=
 =?utf-8?B?UHNsdERHNldmMld3TWNFakFtQ3J0MzhITjlzeTN5elhrNXB6U0ZGbGFBOHEz?=
 =?utf-8?B?MFBEMkJBb0k3aUViTHJPQ1ZaYi9jWE12eFlZRTluTVVmd3ZjMWdndGNrVVFh?=
 =?utf-8?B?TWNyd0ozNWRmaHRqSUpBOUxBcURoaXdmaFpEMzY1T1hCYngyQzVpa3BsMktx?=
 =?utf-8?B?dG91L3hDOFBJaFRtdkRoQ1BZS0kwUWxTbnVkcTNES0JadTBxa2x1M3JNSlJs?=
 =?utf-8?B?em5RQnBOaVV5a1lCakZjU3pJdkZIUWl1QnpNVWhzallGSEhPaXRLVXhKV1Va?=
 =?utf-8?B?a1pEZERZS2ZxTFcrNytlWUFkVzFEdzE3UWZCTnVGTkYrNldWV0VGbnVWQ3RM?=
 =?utf-8?B?UmMvOG1PREdYOHlWMWxOWG1UYTkxYWJ4OGpqeEo4bzdEQ0ZpZWFPRFlmWmVi?=
 =?utf-8?B?aE1VbWdHM2t0OTJ4YlU0V1NTSi9VaklVVVhEZ2plVDFYak1RaUFzN1luelVp?=
 =?utf-8?B?cS9Pd1dydERxbVZIY3VjSHFnUktKbkJuWFprckFrSE12ZThib1FuZm1uU0Zi?=
 =?utf-8?B?djhQR012THZ4WXFVWThiekxSb0JxV3I0eXlaRHJvL2VTVy9Ma0N1cEtBVG5v?=
 =?utf-8?B?dU1Jc3NtMW4rZnQ0NEJQYXYwdFUwaUwvc2kwazdVZ2l3bERIanB3SzcrdGVC?=
 =?utf-8?B?M1NmclZJTWN5M1d4TjN2V2Z5ajYxK0lDaU00VjlPTlA1dGE3bDJJZDBaK0hy?=
 =?utf-8?B?cUkvRjBONGc5a3BpaXhnU2ZsclptbU1laHlRVXUwUFdteHhJU2V2TnEwaVRn?=
 =?utf-8?B?WDBpMkFTM2NQV0oyMDVxa1FnZFQ4azBoM1RGdTJVVHgvV2FtTCtob20xdlFQ?=
 =?utf-8?B?NDlUTnpmUDVEdnRYT3dUV1VSRXdTc3R2aC9SSGt6VlMxSlBTQ2QrOXk4R0RH?=
 =?utf-8?B?VkNMVTlnZHJjbkVRbkhtMkVoK0pFRFdFYmw5U29NQnVHUGpRdUUvcElCZFBS?=
 =?utf-8?B?M3lFclBQU2xqbXZPNk5GdXc0WVVNQS8zeVZhUHAwYzgzK1Mrczd6U0lLWDFR?=
 =?utf-8?B?bXZvWFhwNHBhekZMZ3NXK2c3Um8wempOdWFycHo5Z2dBV0tDcDFzcmdPZktG?=
 =?utf-8?B?eWZJT3h4U2s0a1QzQWpLdjBENmRMeEdJR3RSY3ZCNzhQZ2dPWHlFTFIxVmEx?=
 =?utf-8?B?TEFyc1AzZytDSG9zczVWaE9xTjlPL0JpcXp5TFQ3NjZZMG11T3hZelVjMUxC?=
 =?utf-8?B?NklNZXRVZXcrd1lyVEl5MHltWlBXWmgweVh5MUVGcEg2S25CQ0doaFBtU2Ro?=
 =?utf-8?B?NFhlL3ZHQnBjcUNzTmVxWXl0emI0Yk1nVmpsakV1RlU2TnBmK1lhS0lrdVpn?=
 =?utf-8?B?MXFqdEhEMnptWmNXQUhwNHovalpyWXJFcE9ScmppR1NoUTdvbDJUckV0ZVZV?=
 =?utf-8?B?ZTJWT1VjK0lZeVRId3hIdGgrK2hKdXVkTnBTSnpoZ1NwVjgyRXRwZHdGTFB5?=
 =?utf-8?B?UFI0YUlQUkFGY3RJamVSOU80dDVIU3d5S2dNNFFWdHQxZWlQL2l0VFBZWTZo?=
 =?utf-8?B?aFhCYXFnSTdVeEMrNFJQTm5QUis4SGdPQm9La2Z1M2Z5SnQ5K0tVdVNMN0VQ?=
 =?utf-8?B?RC9CM2VWWWdTVUdYZ0xWNTU2b1YwRjgzS1czZEtvSlpqRnZhV2RoTnRHUXRt?=
 =?utf-8?Q?1eK/6cdXUup5muq2sLtWZIyrXLh3Yo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:10:00.8493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f73d616-ba9a-444b-2daf-08dd3f7b8b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
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

This patch-series enables jpeg devcoredump support

Sathishkumar S (9):
  drm/amdgpu: Add a func for core specific reg offset
  drm/amdgpu: Add helper funcs for jpeg devcoredump
  drm/amdgpu: Enable devcoredump for JPEG4_0_3
  drm/amdgpu: Enable devcoredump for JPEG5_0_1
  drm/amdgpu: Enable devcoredump for JPEG4_0_0
  drm/amdgpu: Enable devcoredump for JPEG4_0_5
  drm/amdgpu: Enable devcoredump for JPEG3_0_0
  drm/amdgpu: Enable devcoredump for JPEG2_0_0
  drm/amdgpu: Enable devcoredump for JPEG2_5_0

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c |  59 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |   7 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  38 ++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  41 +++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  39 ++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  40 +++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 112 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  41 ++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  65 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  61 ++++++++++++
 10 files changed, 469 insertions(+), 34 deletions(-)

-- 
2.25.1

