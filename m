Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FBCEE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12FC10E7E7;
	Fri,  6 Feb 2026 14:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjNy0Y2R";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5B010E7E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sowqU7WNsF1uLUJEuMyADeHJvklFZZCRr4gND90T5arYTKxpZj+h6J6Uc3XsXUsyrAXyh85bHNEew3m6H8piLmIk1saa2cjMpCqR64KVo3Vkszh6YOZhn6SzTlQWWV8uQ8UAwtb32yd0ziMu8Z17JqbaEWqmWvsPcrqQ/7lahS7bFYRXf7pJXvyAY7GAb3k1aXFv4dkSFytE2X2YRI7FspAz7wJXdJuXhnRUvWLAnSbxgN9Is3CFqwceq1w6VDLELmu11mnNhJyWcLsIefcpsTf6vJg31xmbqM7EeRO1iuKnYtZl6Bx3J1yAFOAg/nAbtYesCkHJM98umuZeBSsmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3jHQzv7N0W7pl3jeaoEaSuLnCF8SLRaiGi+vzVMhMA=;
 b=LHpBnB1d7m3waaFitnhAVYdhkKKEEJ3zz1s55zBfc8LMw5CwAGFcXZlIXtEUVQJ453DATb/yydIV+7XRA5GfoKCgHYJIZNR8vaOuzqYMAQuqCH57mn+CuTuyyIidyaKU4IAdGdSXt6LClMDp3jWufMqn+JfApndkAvpKM9QMSvU2wGXibHmtBtKaNnvC4Rlk/6UsX040amJ9wf54ACB4d47EGwy9nBUEw82U8yO7tbRlLTmlfiqnszzi/fE2JhSygDIeIIRBCS4R7JocrHK+7Qa0AoaJr6tNlIKOiUP/Nj3Re8pHBcUW32gcb1P0iNiiWItW12Az4NhG89NlfszRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3jHQzv7N0W7pl3jeaoEaSuLnCF8SLRaiGi+vzVMhMA=;
 b=SjNy0Y2Rdv/uwCflm0l1nwBgBfVt0suPZTldM0LUINm+C0uMxtGJe5ZkmvbznGoAUIIBor0LJuNpd4jLIHNfwTgohU1T3r7UOc+QeVN/s4v8Xt31P6Sg9OZfkkMPa3WVB0gWMjkPaI7Ht028i0NGoumZSEm1tbB/Ma3sYYRoFDg=
Received: from BYAPR08CA0035.namprd08.prod.outlook.com (2603:10b6:a03:100::48)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:24:56 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::99) by BYAPR08CA0035.outlook.office365.com
 (2603:10b6:a03:100::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:24:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 08:24:53 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule() error
 path
Date: Fri, 6 Feb 2026 19:54:45 +0530
Message-ID: <20260206142445.1476609-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 7255fe36-1dcc-4470-1bea-08de658b8044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dENEQlovWVQ3Wm5Scno4dm91aU8xM1hCMFBFelNVYVpVeHBmZUUwUjJMcERa?=
 =?utf-8?B?aFd5ZTVVOERUOFBuYkJEU29ZbkJ2R3V0bndZYk9iOTVxcDRKRWhyU3d0dmJB?=
 =?utf-8?B?SDZ2SlQ3YkwyMU5paEI5YTFRbmhUVXhPcnFZVGVxcFVOU21yTkZuNlFvYlpq?=
 =?utf-8?B?QWFpUFVxOHRRYzhQdlBJaHg4eG51QmhTNytDWXVUQmdpdFJXNDJrb2xtajl2?=
 =?utf-8?B?QXI5KzI4QlpNSGFKcXVEeDhrYzJLVnVGY0FlVkV2czVqUy9vN3grYmNMeGhJ?=
 =?utf-8?B?MHAyK1oveVRBUU5YLy9ZdlRPVkZxT3JSdWc5eHRRV1h5dUxNVkVxR0VSa2pw?=
 =?utf-8?B?V1J4bUdQeHRNOVg5UnhjNytlQUJNYXhxZ3djVzdBMXhmbldZZVYzbEhBdmI3?=
 =?utf-8?B?bkxxcVptSWxGa3RqWmgyNlpMMTF0MjljYjB4Wit0cnhhZHQ1cFpOVm5sVHJI?=
 =?utf-8?B?ektHQU5HMzByM2s3SmZMUGU0UDVBV0krV1hNOUE2WHgvN0oycDNhOVQySDJE?=
 =?utf-8?B?QlFablNoNll5OVhLL28yemxPNks4eGp0ZUZRdkFJSnVWTzhSc2pKaUpMdEdL?=
 =?utf-8?B?cWVOSVFMdE9NQzhUaEZIVWM4b2hqa3g3SHdjYndhM1FSbTdrNVdSbjJlTEt5?=
 =?utf-8?B?WkdMblFQM1ZEZVFXMlRFNWNJZDJleE5ETFd2VGdWRFE3bmdKSUZZeUdKK0xs?=
 =?utf-8?B?ak5NNS96QlM3Z0xvVG5kM29rdW1BeGF5NlQyWVE4VklZc2N0TGlzVTlFd1Yr?=
 =?utf-8?B?M1BXL3VwcStTZWhQcXpxTTRGbTlvNzlrUS9LUFVzYzRNLzB1UXhnalVSV0Rn?=
 =?utf-8?B?bklQZFpFWDZHa1VBYmhCWjIvZEExUld5ZDNIalJPaEhnSWJNc1YwdXhIU0Ix?=
 =?utf-8?B?ai9wRWtQMjZ6ZzJjTHhhL2xvc2V0Tk9GdmlhVStOb0ZwQi9HY1ZOMk5zdlho?=
 =?utf-8?B?MzFsWjUzK2c5cVNmQkFMYmlzK21hNjdYMEMzYUtDcDhsUmJsWnQzaUFnTHFx?=
 =?utf-8?B?VS9aaWxCVlU3VnNJaGFicUVvMDVWZHRnYnAvRnhmV3BrSWtkZytEYm41ZjVT?=
 =?utf-8?B?MGlqRXhOL1pOd2tLd3NMVGM1WWQ4UDlsb1c1c2djZ09PSGhjZnk4M1ZvWXMx?=
 =?utf-8?B?QTFPVHBXM0wxNHN3cjJQQXcvYmlOWUlWNWdyZG5uV3QxcWM5VWszRlBOWU5S?=
 =?utf-8?B?aEh1WjhxUGVhL0ZhVWV5TlhwOWFPQ01kR3IzZ2o0ckRpemhSQXVnVEtXdWtt?=
 =?utf-8?B?SlV1WUpkdVRtQ3NudEVLUkJpMkV3U0J3WTdyV1NFcGFQSkovNXNmdnRocE42?=
 =?utf-8?B?SndwU1c4NE5JblBkU0hTRzBkbkI3UUgwRU00ajlwbEoyOWpLNEdyaHVxUVZL?=
 =?utf-8?B?QWZtM1BGa1orZWQ1OGhMbVpHWHJhbnRUOFpqYWZ5elQ3dlRkdmJmZ3ZuaWxI?=
 =?utf-8?B?Sk1rZm5qVDUySWx4VFZFTkhVbWZoT2o1ZVNWUG43K2lEbkdid09uc05Ka3RF?=
 =?utf-8?B?M3lWdkt1Q3Z4dk9BM1E0RitkczNkTm1GM1daNjRsWmVDMnJtMWFHNXd2eXds?=
 =?utf-8?B?akVROUdYcFFNNXJPZ0hvY0NvemRhQlo5OUtlTUlYUnAyQmc1Q0RCK0t1dTNM?=
 =?utf-8?B?alVHamM2Yk9GRVYraDdvR3RTVWJKM2FwellOUENVRGkzRkN3bmtUemdSeUFB?=
 =?utf-8?B?UnBrUzUyOU9NSW1UUVJJdldxQTZHREZuN0YyN3BVdDJsYjlWSis2a2RTYU9M?=
 =?utf-8?B?Vk5rRmFoTGQ4UmtBNDlzNjlDVlNQbnd6M2dCL0lXcW10MTFnN2JOMThPM1JB?=
 =?utf-8?B?ZEltTEtmQkVwNmE1TjBzRXh1dFJITjhrTnRIRGRidWdmVk1GeGFuVU5zcXdj?=
 =?utf-8?B?b0hkd0gwL0IwOUV3MGsrdlJ4ejZKUUwrRmkxK1grT2p3MWpJajJWRXV0ektu?=
 =?utf-8?B?RWlGNGIwR0FMdnBVOStUMlI5ZEdqQVBmSjBRVlhiMmhVMlJwM1k0Y0hndDR5?=
 =?utf-8?B?RU1kYk45TStkTlBQajFhWno0SVBnekh4ZGwvNHhZUzNNWUszaGhNNUExZUo1?=
 =?utf-8?B?L25qRXkrL1QrL2FzMWxSTitBN3YzOU9TbFgwbGc5U0RDZHdGL0FCc3dyVXFW?=
 =?utf-8?B?MEkxcHM0cVFJeFVoZVpSK1oxZU42ME1uT0s2VTNLeXFNbVlXUG1DNEF0UUVC?=
 =?utf-8?B?c0FMeGprWWpQNFdlQTJ5a2ZlZzk4K0N0SGVVTGhqS28vQXUwS1NoLzhPUHY2?=
 =?utf-8?B?ME93Q3dtajh5S0tzcDRjRXpyZDlnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XyrfKMVleW5tvjiHVIJFxJwqwtx/r82hUR5OMHNXKmE7Kot3RaxKNc6xMhqaNIS1WLhcsGWNwF6UCbGehVOH/XeMQ7bDjWcNL601poel4ieZgQm7fqy2PHSPO3qcRZT/uqYf5T6RJx28FNpBfcwsnwAfACTkPsDpC+i9waIxxJJYzUhIAXWIdQoxqSXuSnxiQ9NOUJVpozLukRnUOKx37NPF8OKYxf0QZKjddvDtP1ewfMKQVQWYVlDGWd7Uxn5Ewd9JTzTPdU+pZeb/dyHmfhmR42+7PxX+E0D4/KAC9UWGf3KlaE6G3IS2Hap2AVqWSHX6A39kRMo2oCLFBGyJdbjRO0T/jviq2AUMH4fU6HRNtoQM8YhZ2VM6qkVU1qlfCtgkshMc5TA+c+MjxYG1tvPqTU6kk/iHEF0ZmI7hdK9H7/+u1xRCmTQNWWN/XwQk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:24:55.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7255fe36-1dcc-4470-1bea-08de658b8044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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

If amdgpu_vm_flush() fails, amdgpu_ib_schedule() returns early after
calling amdgpu_ring_undo().  This skips the common free_fence cleanup
path.  Other error paths were already changed to use goto free_fence,
but this one was missed.

Change the early return to goto free_fence so all error paths clean up
the same way.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c:232 amdgpu_ib_schedule()
warn: missing unwind goto?

drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    124 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
    125                        struct amdgpu_ib *ibs, struct amdgpu_job *job,
    126                        struct dma_fence **f)
    127 {

    ...

    224
    225         if (ring->funcs->insert_start)
    226                 ring->funcs->insert_start(ring);
    227
    228         if (job) {
    229                 r = amdgpu_vm_flush(ring, job, need_pipe_sync);
    230                 if (r) {
    231                         amdgpu_ring_undo(ring);
--> 232                         return r;

The patch changed the other error paths to goto free_fence but this one
was accidentally skipped.

    233                 }
    234         }
    235
    236         amdgpu_ring_ib_begin(ring);

    ...

    338
    339 free_fence:
    340         if (!job)
    341                 kfree(af);
    342         return r;
    343 }

Fixes: f903b85ed0f1 ("drm/amdgpu: fix possible fence leaks from job structure")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 44f230d67da2..bfa64cd7a62d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -229,7 +229,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 		if (r) {
 			amdgpu_ring_undo(ring);
-			return r;
+			goto free_fence;
 		}
 	}
 
-- 
2.34.1

