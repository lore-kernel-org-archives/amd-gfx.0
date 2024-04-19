Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1826FC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 15:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A1410E7DF;
	Fri, 19 Apr 2024 15:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qp5i9rC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B714310E7DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 15:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcrXuZuV7F5XZ3yQYb0Neiylasxih6MoQUBLDTXsdm2pcNMQdGFlH9JKcqc2Yo4H1aoHolgQNjqEIDvN1rH3pHxvswJaLEyshRHXGrmcf0JmtUmtHU/A7FNl+zDh/b4S1kgmf4dsfUOfRjF5fbL40ZJuJtJq1jiSZy8TLM/dW8ohWm9LAmHZoMrob11lB1ax34r12qKMi/92LUkYhsB/pNm7ZjMYU94TyUWwxEThmu989x/yPLwLtjr9vLnsxU7SXoe3waUQp9GrGdbeKPsPDB18S33lCoz4fJyFQKOFZKRIoVjbnyqLVke2RkVLsp8GACkxowNkhEcj2rMgot90Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZW6qC0mQjB03UCpIo6HDLJehsqvA2Wv50CNvj44x3k=;
 b=n97tDK1f1lybH1IrM6Tae/9GEs7clzORYKjP9fYO46+DTjWLAQ/PYDq04sfq1UNDSlNNuK/zAT+3bvMSo6roPqKTSbEfEWy1ODQ9UyG7l4E4awIKNtrJwGOYg9Apz61d2J3/gkQsQI1YMmlDwFUnHVH+JUAuOxyLKpG59PPhthvv2JRknpDl7UUIEyYZn0cnAZ1mRl4dPkA8CjDRWhvq9WcztoDoFhEu7kgQYbvsA21bCwVLKa2+qTbizYw1QL8fDENtIrRMrOeDWznE4MVj+hyPkDloMPb3iux9IAphiW9Z+0ZgRbvqDMSxgLByswBUffAjmgPixQ56pBjoCO3y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZW6qC0mQjB03UCpIo6HDLJehsqvA2Wv50CNvj44x3k=;
 b=3qp5i9rCUPk9CBJfGAlMwN8dsg8VRPs9RBagOqf5KhteHThNMMcRxk8MCfIj1fongGpqMpVexiUyzcIoECpFQEq9B1x+AgT1E0YKVmVil7eeEI5wUX2QiLbpQ3stkQETxR7lJE0jY9h7gs4jMQ5n2+IOGXXbIJEv8rhKw+E7aCY=
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 15:39:47 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::bc) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 15:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 15:39:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 10:39:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Li Ma <li.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix snprintf buffer size in
 smu_v14_0_init_microcode
Date: Fri, 19 Apr 2024 21:09:12 +0530
Message-ID: <20240419153912.233829-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
References: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff9acb3-2772-4086-7bbb-08dc6086f10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDBzTkEzUEtRY095LzFqQnJmQ3IzMUpLaTBLREw4cmhndzdEVVlqbGN4THQ4?=
 =?utf-8?B?YllKYlBHZG9qcFkyOUkyQjdnTkRiWWJIbUdXeGZMNXNCa0pVVnN2cFUxbEtY?=
 =?utf-8?B?ZUh5dldQTTVDL1ZGQzdsVzg1Rk8rZUo0VFBtT0xsT1BDemMzczJNS05qdDFy?=
 =?utf-8?B?SU9YNmM4dEkzaWd2b0ZiSW5JQVA2VCswNWtEMk9RbnBTWnRwNEJtcEZSdllO?=
 =?utf-8?B?TzR2QTMvNXNwK28zemc5bnlwaG05RS8zVVZFbkhHWXQ3a0JZaGtzY2lKR0sz?=
 =?utf-8?B?bDl4OWRKRE8rK2FlTlM5VzVVTjNrbG1uVVpWcUVjQjVrZGtWd0xFMkJxdGhl?=
 =?utf-8?B?MWcwVEJ4dGJMYzJkTHByOWZhZ1ptaEovcHk1eW5oY3NVZXk2ZzBDK2JoMXdE?=
 =?utf-8?B?MktJN1ZUc1h1VWpHMlp4bXdveEpqbEh0K1dkUEEwVUZtMzhMR09iWGhIakFq?=
 =?utf-8?B?UGxHcDNPeWFnZXNXRmRabSs2dXZUL2QzQnowVzNPNUxqSWFmR0RJdTNDaWJo?=
 =?utf-8?B?SDFUUnB2RGhzVzJ5ZEJBeXRJaCtFL3I4VlJWeEI1NmJ0K01ocUU2bW8wb2Yx?=
 =?utf-8?B?SDltLzQxaHhOb1h4Z1lPdURWNVVtbmk1V0JpcGJzcUdHMnArVzZwNlkrM1BQ?=
 =?utf-8?B?NmJqbmZWdm9ZRklsczlZbG5tSWZDVmJVWExjNzJqNlRvSnB5WjR5Nm4wa09C?=
 =?utf-8?B?RXNlRWZlSkFmbzk2UFpyTnMvSnE5akN5eUhwUEVYU1ZwWnJBUjRUTFFYSUlJ?=
 =?utf-8?B?OVU0ODB2REJoSGlaYTFsV1M5c3E2WEhZbjBKVENsWXR3dGNWWkxLeU41VHIw?=
 =?utf-8?B?SzlWSkhTN3I1cTlTVFNqd2MzbXdjY2lHbHlMM3ZidTIzNWMzdStHUjdvVDR3?=
 =?utf-8?B?TUh1bUNQQXNOemVkN0R6UnpwTDR5cDFzZnptL1ozTEp4Zy8wN0kyb3VRQmEy?=
 =?utf-8?B?eVNvOUJBVnFjOFBabWYzYlNPWDNYQlhQSEh6alcxZjBPODhXV1BZK2szNUVs?=
 =?utf-8?B?Zlhud1pvLzZuVlE4Tjh3M3dvWU8vRVJxS0huaWxEZXVtRTVoYzJVcm1RalJ3?=
 =?utf-8?B?TERNZWQvUVVvUmNIdTlLaTh1SVlCcGZJQmZIcUVPVTB3cFpiUzVoWjc4RVpC?=
 =?utf-8?B?ck84K0djY1c5emdnd2hnSVpHNUVSRlozYzM0NC9oL1UzYm8vQ3M0QmpsV0xq?=
 =?utf-8?B?bkNYRTcySUJueVBWTGo3V0pCeERrcS83d2Z6RXhBWk0xVElOZnpDK2dzQ1l6?=
 =?utf-8?B?UU1IUzhkaWJwVWlKZTVuL294RWV5R1JwTVJLdzZpV1ZVUkJNaEtKQmtuMkpN?=
 =?utf-8?B?YmpxUTFQa1I1VmhqS0dLTzR5TlF2WUFhK0hWQ1lIKzZRUWRiUXZZeVUrOWFK?=
 =?utf-8?B?UjFJdzhWSlNwMG9GUFJCMkJVRi82SGg5T2NIcGtyTmFEQTJnN0JqekNaZ201?=
 =?utf-8?B?UzhPN1o2LzZESFY5VDg1TGJnR2R0NjkxZjVic2NIcm9IL3BHODJNSmZzc0lh?=
 =?utf-8?B?bGVicXFEckVzdGROdlhlTFI5UVpQeWM0Z1pkVHdsUUF6Um5LOVBTZi9GT0pM?=
 =?utf-8?B?V0QxdDBuRVJOVVJ6Tml3R2o2YmRUNHA4MWhBa2xjVWg4WG1JN3gxVlBxMTF2?=
 =?utf-8?B?TWlxQ3E3c05VSGgyb1VQazJQUys0NUFZTVNKM0ppUUZpUjRVcHZQRzVOcXNV?=
 =?utf-8?B?R1VkREoxUXVoT2djbUM2VmZYSzZURWdOamgxcEpIVnRNZDJhKzhDR2NQYm1P?=
 =?utf-8?B?NHNodGpaZGFYUzkwWldJL25SRkU0dHcyMGZJTWZkcjNjVUFPdTc3a0lsQm5O?=
 =?utf-8?B?Z1o5UHJhVndabm1acXVDTXZ1TFdaamsxcVhPVXZ1NmVJeFpTODFIb1pMcU56?=
 =?utf-8?Q?oO18uH05QCAew?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:39:46.5128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff9acb3-2772-4086-7bbb-08dc6086f10e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
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

This commit addresses buffer overflow in the smu_v14_0_init_microcode
function. The issue was about the snprintf function writing more bytes
into the fw_name buffer than it can hold.

The line of code is:

snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);

Here, snprintf is used to write a formatted string into fw_name. The
format is "amdgpu/%s.bin", where %s is a placeholder for the string
ucode_prefix. The sizeof(fw_name) argument tells snprintf the maximum
number of bytes it can write into fw_name, including the
null-terminating character. In the original code, fw_name is an array of
30 characters.

The string "amdgpu/%s.bin" could be up to 41 bytes long, which exceeds
the 30 bytes allocated for fw_name. This is because %s could be replaced
by ucode_prefix, which can be up to 29 characters long. Adding the 12
characters from "amdgpu/" and ".bin", the total length could be 41
characters.

To address this, the size of ucode_prefix has been reduced to 15
characters. This ensures that the maximum length of the string written
into fw_name does not exceed its capacity.

As smu_13/14 etc. don't follow legacy scheme ie.,
amdgpu_ucode_legacy_naming

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c: In function ‘smu_v14_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
   80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                    ^~       ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 30
   80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: fe6cd9152464 ("drm/amd/swsmu: add smu14 ip support")
Cc: Li Ma <li.ma@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
v3:
 - Reduced ucode_prefix to 15 instead of fw_name size increasing as
   smu_13/14 etc. don't follow legacy scheme ie.,
   amdgpu_ucode_legacy_naming (Lijo) 

 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7d2055b9d19f..5d9335cb8530 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -64,7 +64,7 @@ MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
 int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
+	char fw_name[50];
 	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
-- 
2.34.1

