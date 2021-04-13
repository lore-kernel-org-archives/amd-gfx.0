Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4190EC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A9261220
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A9261220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC9056E1F1;
	Tue, 13 Apr 2021 20:51:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC89C6E1F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buZqHbLGryLRcFB/APuJkVuvKSSkYZeyUdIK2jc2fCnfSGzlRxjV36g8VHi7b5aG8CkqyOdClsnERT7dRNBLCIuiW61fiNJrNNunZwF5LM1tQywNSKkFfKdTcB3HSc5t7c29D5NwGKJIQPs79ruyKaZLhPzqRORlYW3gIp9IXD3shriMot2pgq1QAvR3iiZstgguBUya/KfkfEhkBrxNrAo8MLkKUKNNhpSYrVEmn/syXv9daJ6+r3bx+nWIspHixp9GODwB9L1NgWLY4cq5JZUb0gCuhCQnA2R/1CqMUQn/B+1kyD3wp2CrA/hCu7urzBOroupu16zfn/UbK43O1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTYXYPktxi8JG5fIt1zA/0h0WrlVHmsI+1G8H68lnQ=;
 b=U90+Iq9uZolr4AqkLrXA9mQHIBsL8XzSbNXD8KUtM9lSeQL9psk5B2+4eH8DO5xZ408tLIWcj63XCGG57L7silFSl+ho84uUp2Mp+7//MYjYQDSgwivgL4kSf5mbhJBUMg1z8x5dvSyG5YeDF0WSxH9xFE9nsKCv0ODBdGT8TF2iwT2+EZBP3c6WPpDddVXsTFQFkKIJZVbE3QHtulGvC1nhYhARQpU2fetx8tv4YlbKF5boPNcklpz0n5baOXoC/AfKteLQHP4G6C/bSIYCKFHz8N9m2JhK2eUw/jmYgFw/rO5x1tMGIZj6yMAPjAfuybAXcGwXfBd32d5FC2WzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTYXYPktxi8JG5fIt1zA/0h0WrlVHmsI+1G8H68lnQ=;
 b=dmK1SvA5c/cLtMU5orTZNtZfiZKx86j02XHliILT+EaPLuH9c0nSYa5iAj+8p9LLyR8XHTyuFjWcYSNGCz7cRqJ0Q2d52cx/DTFTM5NHRxg0HsPnjSKX47AoWJ5GrFeT68Pi95KqBlIE6nSUcnVlweE+ojwP4NzAkAE5oee+UrM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0198.namprd12.prod.outlook.com (2603:10b6:910:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 20:50:56 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 20:50:56 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2] drm/amdgpu: use pre-calculated bo size
Date: Tue, 13 Apr 2021 22:50:41 +0200
Message-Id: <20210413205041.6355-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413204213.6405-1-nirmoy.das@amd.com>
References: <20210413204213.6405-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.119.233]
X-ClientProxiedBy: AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::33) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.119.233) by
 AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 20:50:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418d8806-f387-46b8-0ba4-08d8febdd5a7
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01983F971201A75F0A793C948B4F9@CY4PR1201MB0198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFbtZ2bbAd1tUWsh4XR10jTOWFskKCcnF5tB85gcXQxDzqNx9+HROIZzGC8fcTp8+TuygkV1SYqtuE+dSflS/N6uupiuJHgrD1W70ylHVePNpfCGHuS9vMTMVsL+GnIIrv90wBTvlecm8sNlMLUSVs2k+RthbFlWbr65ubgxQUISffKzBYgGw80epkj0XWIdbAvUdhjJcjDdOTPTZLRYk8K/Jz0r/EHExlGJdWHfoNe7WC/tW43d2I/N2a195cE0aNUpRt/LIeorFEGE3oBGuRY2/eY4gXRg4AKb1OYSu7uizWZjjYA03CUFa3lN+McA0TQ+RoKzYFAiOXDJMQBNTYu9EyVTUMZQ8ff3V3x+2mpMI0E1UZNDnysTa1MNzx8SMdjAp30eUm/cFLLXQ/eIcsKCgefvpasMKiOC6dxb5mVesBS452SxZwAYfX2vEGPeHBuSo+DMmme2dLIdpOdzFV9DUPvSkPND7WbW9nwakAx1yrLsxOsHlJov70ak5ONHiur+wgIvodMXjQa2F4mYHBefKZqB07w/Xp2BA8ETvOkoctwfJ0pfmZpTAJehjIXMEa8bV3KdwYkMxVTXHwlIsC/nf9o9p0mst+ZoM9Ne91kHT3btFnpFX+AEAWkJl9yif+9pXG8ePr1lthkZ18Uutn3BgNyVSZApLunqMm184hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(34206002)(26005)(66556008)(2906002)(8676002)(83380400001)(66476007)(1076003)(66946007)(6512007)(6666004)(2616005)(6486002)(4326008)(8936002)(44832011)(36756003)(86362001)(16526019)(6636002)(37006003)(316002)(52116002)(478600001)(956004)(6506007)(186003)(38100700002)(38350700002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xmuP0RZpjYzwGDejcTivIGSfPFQN3akjYIMKUnD0wrPKUhOnu5AydMvs5I7S?=
 =?us-ascii?Q?mZJQhHQbbDJweASQnycwDmV+VvIwwbpteR0VIWmnY8dvPawK6BOly6nYzlAy?=
 =?us-ascii?Q?8OjsQWOODDOQvM/6tY5xw0ZB3o/pe1ZkVAtomJq44+kPcWDJzW7C3cd/PArg?=
 =?us-ascii?Q?0lKqzeFpmvXcmJpfWvNuywwVe2NA2d6A12XUCSRrjWHa5KrQz23i4gvk3yqu?=
 =?us-ascii?Q?dnzjQFj3a2SFQcBlt73tltyj/JKVEttc6xqi4pA2RYuMsYjkz9Q1LV8wUzof?=
 =?us-ascii?Q?TQcKCrj/xPDsRTYxAnIjtpb6j1+hmj2MkaLDqjzjDevZTy7KVQGCm7+71Y/l?=
 =?us-ascii?Q?je9CwlPceSHl/5ws5/M+U/mrYoSGXQO83ipMKAp8HXfY0u3CaGN15L43z4Ca?=
 =?us-ascii?Q?TY0JO4YbO3j6s8qZfuDjWWMwgwluL7f5Py+B0+jXFVmb6Z6yuyXRbBzyuLoo?=
 =?us-ascii?Q?h23gAL9SdblMwtR3XIYKt76N+KtXqLv2sRp2WiIdWlvIoph2lBbi6wWldld+?=
 =?us-ascii?Q?8MFLvSSI/QNugtuCcivp9OzWWnRp5nGxV4W4H7YZ5zKtF/jbiPUxxhGZrX09?=
 =?us-ascii?Q?fJx60vC3h7rrLdMWcUWk0HXkTWFoanD6UNgLOB2qfPXUuVYam6gURNVADmHc?=
 =?us-ascii?Q?3Sl1WDoqC9Rj3wD+L8bY44OyGwxFcnKIjuERv0tr0IhysS0Co7PMWuLevSrK?=
 =?us-ascii?Q?Q1loPmTbBRpdpBc1jsCM7HhMPHICTdtOS0Xa3eWwYOITbQX6v3iTMvw0EAMc?=
 =?us-ascii?Q?2I0W8iOXSR63sGeMU7okD0HWo48ilv0S/vj8Xn9wApHD3t1r80zvr+ZnIh9Y?=
 =?us-ascii?Q?c4Rorb5vxWJ5JbRYwwM/5CUXENYKYf/6IvWnPpktXZbpvQ2bzTJ7EK8Y3CJs?=
 =?us-ascii?Q?FyiatLb78htfW+y8PK2/MzHUOZMlGmHFOnTDcCCb6+rrad4Bu1tOuWku4wnl?=
 =?us-ascii?Q?tPbPl6BVARtxwqF4MW1kegWcukVoXn0WWhoYje9l9ttJMAhKQexmFI0EL7Vi?=
 =?us-ascii?Q?v/x58AkHsI9895oBIff/boFX2/F0yJrBtZu0UFjswwhqZP+nXZliwW3J7KX6?=
 =?us-ascii?Q?iyxl8T3jX5E2scJXYGqPfRbb8NUx8wRpV2brAdtW7R7fdtyMXnM1uNPV5KyI?=
 =?us-ascii?Q?WmbfRr/7n5a2bC8tfn7I1LdInQ0bmjodFMU5xMArnwoztPAXR8+NthsBLZ69?=
 =?us-ascii?Q?MIx3KlTnmLfONGv9n3/ErgnXXzAJWSe8ACMBZvsi3WrI81RnQm+Itr2bLF9g?=
 =?us-ascii?Q?nunc5e/8Gra+MqCf7GQnaOkEe8C+vRzuSx87TpiZdcr1ixWD64Yfnn6MFH7G?=
 =?us-ascii?Q?oyY3KRYcIApnV2uokXImn55C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418d8806-f387-46b8-0ba4-08d8febdd5a7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:50:56.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8a6jLEF25NbuvJj37gxhn0dsqdRutDYH9CknnY8KYo5SPgAlr3ctQGw5PSTim/gv/R8j3m6jzf8ntonAdJAvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0198
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use bo->tbo.base.size instead of bo->tbo.mem.num_pages << PAGE_SHIFT.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1345f7eba011..74ecc0c1863f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1371,7 +1371,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	if (bo->mem.mem_type != TTM_PL_VRAM)
 		return 0;

-	size = bo->mem.num_pages << PAGE_SHIFT;
+	size = bo->base.size;
 	offset = bo->mem.start << PAGE_SHIFT;
 	if ((offset + size) <= adev->gmc.visible_vram_size)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 936b3cfdde55..26deace78539 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2048,7 +2048,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			return r;
 	}

-	num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;
+	num_bytes = bo->tbo.base.size;
 	num_loops = 0;

 	amdgpu_res_first(&bo->tbo.mem, 0, num_bytes, &cursor);
--
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
