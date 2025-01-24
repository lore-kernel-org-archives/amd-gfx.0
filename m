Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E9DC02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 08:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B5D10E2CE;
	Fri, 24 Jan 2025 08:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGSMmHPn";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEDD10E2CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 08:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBPbvdpTa7QWnWBnIktqiu44s+wh2qCnA6KsrHHO8lFU7O4RzbbtvrKSe6GPQS5lP5Ki/E38uDQrkM44SDD4wiP8E5h7ZdiRPoh3B6Xken27RDZz+7nWvZNRscXSQWJyZHoZK1aGMvJkQp4Jj+00fHFzX3axMumWsWxsAn32XTGeNTlINMUsOFUktdrJO3nYs1aa8nUQs2KIB3TRQd5Pl/V/AhnxtVnDlPTCayD/Crus9EOQFABhVSBJrzcfgu14YaECQfOFsjGQPiipUweRn60XOsrJMIxn50n304z/esAVvUTmpSS9UOIStjNi8GompaJAkTE28ZE+UfaFkSJp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXBeF6u6iE/pVjU5mnvFM1JnUD1WobWaKaEVx5m6mt4=;
 b=b96km8g9mBw1bUWeMIMdgS27RXCG+Jlho1vMfvwheow4yA45/UplalcgmLjHGxWhgd+iVVfY1sLzVtVgeVZnQcH3QJbiGhvq+2vs9cXMvwe2AdzV1FxfVvrquIJHhaq+d5Jnc5EltLWAdpHx9MZxImAwRqDF4yfAnPYq9RvqV9P2QDCvNweRWHVjWaHDuMczYi28XcMM7ujqYb9/H1tpHl0QdHg9pbpC13v+DF0NVjab27r7Fg8JTghx1jCHszTeRtUsBUDcUoicR7F+FTAeduMgL6D2puWTOxsuwGJxucHUSLMiuP440GZaKLz1i2jmEzF+0473UwLcWeZfOpYj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXBeF6u6iE/pVjU5mnvFM1JnUD1WobWaKaEVx5m6mt4=;
 b=eGSMmHPnUjmEiJjASz91jC6lE5+SFQdbSVm+ZtFvXe3w+zDogdI4SPeQGXd4MIdo3w0LKd9orUQXV8znbzq2vTqN9HLikgS5ZcgZc6aL17UMcGx5g0wj5SD58DQLyWgc+Y9WUhR1JCs1f/+SjDu+8yhL+eA2r5KuVp1/K0OvIYw=
Received: from BL1PR13CA0157.namprd13.prod.outlook.com (2603:10b6:208:2bd::12)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 08:54:44 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::10) by BL1PR13CA0157.outlook.office365.com
 (2603:10b6:208:2bd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.11 via Frontend Transport; Fri,
 24 Jan 2025 08:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 08:54:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 Jan 2025 02:54:42 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mario Sopena-Novales <mario.novales@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Extend Cleaner Shader Support for
 Additional GFX10.3.x Versions
Date: Fri, 24 Jan 2025 14:24:29 +0530
Message-ID: <20250124085429.3129121-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: e17a0a5d-7c16-4b21-a9c2-08dd3c54bf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjErRnpQQ1YxV3Jjc2k0WkMzUWdPK2IxNUQyTHRkTFRFcGVwMlhRd0JsVVlB?=
 =?utf-8?B?OC9RSVhvQnRsM1ppSGZYVEIyaXIyQm10VmZWMm4wa3IxOGl3ZGlEQ09vYnUx?=
 =?utf-8?B?TDhHTTNvT0w5bnNqUkJmcDBGdlBpNFFDQ1JDQ2F2SlN1TDdVYVo2M2hZU2F4?=
 =?utf-8?B?cmZXZXRGMUhoRXhqd096cTRzRTlzLzBEcFRMRTltWkw5dlBaZnFFV2c3dTVl?=
 =?utf-8?B?aDE2L1paZDBWNzhJUTM4aS95NTAxb1VpdFU3aUZNdFpud2R5OS9vR3RsdmxS?=
 =?utf-8?B?ZUtybi9XMzdrdHpuUGZxaDlHSzFDdm1nZk5veHZFUWxWTVluQXlkZHF0ZFZi?=
 =?utf-8?B?NnVjM2NEV3F0bnVSZkxpU1VqdHp0RlVRZnVHNWtJZ1MyWEtOWUc4aUU1NzRX?=
 =?utf-8?B?Z0Y5b05NUFhqdnRhcnJBenBLbmN6MkpPdFZGbHYxb0dUenJjOHdnQWRwTG91?=
 =?utf-8?B?eXFubmVtS0daWFUzZG1BV3c0R080aDZQUXRRUVVlbHgvdmtuZzUxMHJodjMv?=
 =?utf-8?B?QmZadmZVdkM5dEtxOGpLUU5pUW1CdzBMbVZobXRKYnZoTlhnL0xybHVlcFBW?=
 =?utf-8?B?cmpvSkc2c3dxN3NSVlNhczhzMEF6d1hJUWxad2lSaW5DcUkydXVXcW4vVTVz?=
 =?utf-8?B?T21FeUk0bS8zVDl2ZVQ5L2hzMlIzekxySVgxVVJHZTMzYWVhVTBkQzVSSlRQ?=
 =?utf-8?B?UEdXVVVJOXRvRG5EV0Z1SFNqdnhDVzU1L2F4aWszU2xvbE12Wk5VREZmVjhl?=
 =?utf-8?B?NFNLeHZWb3dwb1VqOXZJV2Zpa0xtQ0hIaWZ6d3JmSnZjSE5MWmlwS0lyb3hh?=
 =?utf-8?B?NEJVV21vMDNaSFdzS3Rabm9qNUdjSFpraVVKOGcxN2tPd1JPQXNTNnQyQS9t?=
 =?utf-8?B?YWlVMXBOeEJuSzdjMWxvaHNCRG5PaWtSMGlSM3dDTy9VTTJpVXBoV3dqTTZN?=
 =?utf-8?B?MEIxZTR0cjExWVJXeXBOTU03QzhtbmJCOHc3K05CZ1BhbHJFQUhqQTExV0ZQ?=
 =?utf-8?B?VWlkbjZ4ck5RRVN2NzVnZTBXL1UwbHhEZFpYaEdrSmdsRE1lOFM2cXpES0k3?=
 =?utf-8?B?bTY2T0JrcFRRNGQrQzI1YWhKZkpxRWI4L1AzeWd0Wng0S1NyQkFlN1IwcnQr?=
 =?utf-8?B?ZXI0dTgreWg3M3lYM016ZHNFZGtIS1V6YVdBbHNmaDJFM1FVaElFR3Z1MjVV?=
 =?utf-8?B?Rk1BYmdwNVM3RktLazNnLytROW00Q0FRUzkyTFl2UHBQU2JnRTRXbnA1eDdH?=
 =?utf-8?B?S0V1Z3pkNEtOMFZ2dkM1MThDMXcxSGJVa1VycVdjR3drQUFHaUh6NWZPdDJR?=
 =?utf-8?B?bmRRS2NkZmVCbEJvSmRuSS8ybFFWV0JYeXU5QjlGOEdTOEZPWE9sODhyNjFS?=
 =?utf-8?B?ckdIcGwva2N4a0ZNeEYvSzhyYlpsUjlFcE1LMjhTb0dkSWxyN2ZHaFdjbFpn?=
 =?utf-8?B?NllSbDhLdjhLSXorYXJYeCs3VjBXc3ozMDhqSmNLbEQ4TUl6TWdWUGpOVm0y?=
 =?utf-8?B?NjZvR1lISzRVZGxLR1ZBMUhjM2MwdTBKWlRhZzJ0Mkp2U0EwUkk0djd0SG5Y?=
 =?utf-8?B?OHZmQy82MmUwTnNKR1NLR3ZlT1BkdVVkN3FYUXJaOTZ0Zm0rQjFMNHFwM1Ew?=
 =?utf-8?B?SUI4QU5oaUZSWXQ2N24yZVYvYnM0eGhIUWJMK0VUSUJlMExkWU9mTStHTW90?=
 =?utf-8?B?UmZpb0s2QS9sMUtLaU1SMFRjL0NNNDJMRE50Q0RiLzdubEI3KzVOSk5iNkll?=
 =?utf-8?B?WGc2Vlc4UkV3ckRSbnpXcnBxcE5INTVVQUtwczlSRzdKTWR3QWpYSDVGcDFj?=
 =?utf-8?B?L1JVMmQrZDJ3cU5LempxaTNZZUovMU9sWm10SlRDY2FLenFpWEFxaC9KNUR1?=
 =?utf-8?B?eHhKSllSSXFSVEE1RDVCL3ZvMHZ2QjB0NlRYTHpiWU5mRVRmS2VuSmRhZzk3?=
 =?utf-8?B?UTRqcjV1WVh1S2NDZ1R2cmpvWG1aMTgzRXR0M1FaRE5KRGU0b3lmQStyV2l0?=
 =?utf-8?Q?H8P9SJNLrW80a7VUEFCKbN/oAKElOE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 08:54:44.2539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17a0a5d-7c16-4b21-a9c2-08dd3c54bf6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

This commit extends the cleaner shader support to additional versions of
the GFX10.3.x series, specifically including versions 10.3.1, 10.3.3,
10.3.6, and 10.3.7. The cleaner shader is important for clearing
leftover locals and ensuring process isolation on the GPU.

Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 938f7d60a0ee..9816e2a4d62e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4811,9 +4811,13 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 		break;
 	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
+	case IP_VERSION(10, 3, 7):
 		adev->gfx.cleaner_shader_ptr = gfx_10_3_0_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_10_3_0_cleaner_shader_hex);
 		if (adev->gfx.me_fw_version >= 64 &&
-- 
2.34.1

