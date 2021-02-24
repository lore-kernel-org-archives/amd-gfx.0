Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE92460233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE92460233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C6A89DC7;
	Wed, 24 Feb 2021 22:19:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7DD89DB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3JcTDoMtKFC36eqvDhUnSZfqFTD8x3BOQsVU14dcPCt1sHt3MPQJHH7qaWY++h5PD+9BKHirl7MYXPYn6NQAmDiEr3mMzqK9xGTd5qtDEPG4ob/afHEgEexnAe/m4K8mDo9SSg0pSNHXB00QcVYd67N7QwvlFgpKyhj7JokUvbdAA8uOzRpwtZkci2j9BG/NeuupxTGehjqbSMcJ5eF994xV6HriuAegMY4UJprxjW9KAX7Xakc7600Cj+ULVlJHojhU/5D4J8D7jbqDO4XIsX6xblgHLSZzqY7DiO6y5DkHOsXKQITQ0Gh7pyWczJ/FbCKYfkInRyr/FbJa1SCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TntNGacsigfFtKSoXvy8GPcuml+VzUigBL1/EaUppU=;
 b=l/SnJ2Y5KYahlqN53TRvvgrj4GkFbQOi4A0qPg3Vkbg5ktNJiRsu7xxUEAsbDzXCmVwXI59Ea6oBLs35AOBrz+yVQHKT+XW1eYMrrZ9Q5mPEbVQifkmW/pDF7Q/ANu8Mb8GOG+pWa9v/Z+lkHxpK+VfUxogl0VPUYYQdom54NoidfhN3yrlJ4rjynAEcRoOQdQZ6KwM0X3o2BtblUNjVAbgO0VVS3v7ySFu8TFjIFxfAR/LgssmW4PsnsT1uAIlSBsvOXDRVL20/zlswClgxJsGncsIJ/Hq/keav4hEwIzKY4zBbAjgNszf7LeCX44e/ZJUyyhraNT2NSuJ5aRUwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TntNGacsigfFtKSoXvy8GPcuml+VzUigBL1/EaUppU=;
 b=OQBLqkwF2+dMiPoryptvdA4Q8fjq3meYIKtZMShRzq3cQJ3VPtFPx+V6nqhgySpQdxnJnjxLGViSVrtV8c1ebo4YWsg2IrPlUF6imyRd2P81lvvUv2FKDNpd3TeFYGgi0xWTwA80BHFVdGqoBTMCx4COP+4W8GlQxCY9m/d8IfM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 016/159] drm/amdgpu: set fw load type for aldebaran
Date: Wed, 24 Feb 2021 17:16:36 -0500
Message-Id: <20210224221859.3068810-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d8ac7df-4ad5-445d-b159-08d8d91240d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417552B56CA6980D303E23FBF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34j9zCYU5b+d3tAuHiJOAVwxyLy+3eR/6ExblM3u/GLu4U09I0LG4RcASmUh37jJjdQusc8bEg6FnoUqQeroj2m1zXCO//60bNYWk3GSp/VGJVA5A1DWplbzh4IB63tb5ULnCF+A3W7Rd5nh1tBDTkg43MFx6D/RvJX/K3aqpu+XVFgjj7Q6ussux+FRE+RCsJv0mcLAVRwHMj2h+OJopEyHS6+AltMWl1Zp6UPjhTGSqeLVjHpDTyIafBZYEPMZJ21iW+4js2vfcd6k4iw9Ln2f32dOUYq4CeJ9+iyyRltmrNH9C+5oIcL00m6kGDLFMAFxt9AJgZbhAyP5axvXHjdAGYjSjzzq45+gA5R8bCgNw+NirqQMPUnYsijqVfMQwigrKe5oDRLhFMFiukSRpObu5EA5TfMe89TIUYCGgMczMTdlJrhC56tkBduWJ73JLYq2Km7E3XUodrDrDMNhPigDvqAYofgknz1b+0Kw+b01w2kGcZTHq163nTzxAJTxjjVm+aMMyIyf+Bs3dgT9peL835FHh1LaKJwlecTFYFzwBE4gcPPGp6woS7bxRltyuXDhhQoujNKfHsfDdTxbSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pv45SN0x/YhwN8puKMaJAaksoPLlZJlTphYayeKTay8p1mHsNP443u39fFel?=
 =?us-ascii?Q?OQRlnxd2ywhqRlllssQxhfGlIEmpq9o6PWHWpoqQiqlcHEmcHeFw191OaKND?=
 =?us-ascii?Q?cXUVo6QjA/uUZOLlCtfn7bM/AjCP9vOupB8OyY2ymKD5+Ug7Qcrx8O31Fbrf?=
 =?us-ascii?Q?qGMRab2nGyTSdtsdNir9SFRuZiBuBs52xT2YAhaqemomAiaOVhtEoIEi+A9H?=
 =?us-ascii?Q?m4a5ScgQ7O52rls1NWoW6gD2vH0tmbnMi1aYEd/WuOqtb5LA5+aG2eaP5LBi?=
 =?us-ascii?Q?LjWD8rOb5d4VukRwOIDn0x6AURHgBIjrMbqDqsnjRVd2enP972WNQ37c+B2N?=
 =?us-ascii?Q?BZ1rFl5DsI/0luNQrSDDCUqNJMIpAm27npNwoOXl6ds7KdgWYhYIoDfGvNRq?=
 =?us-ascii?Q?bOxL+Q6+WOolwW/iiRLkOXKtl7HT881CoGJ6QWVm8/iaKOQHRhG/5REp8nP2?=
 =?us-ascii?Q?DXNO02hWijaUOgwEgPUcMMReVOVgcAUvA5qdXDg8Jnj/X3ce5N/m6e4nP61V?=
 =?us-ascii?Q?+rJSMc+9H/GcOBdBiu9NQEIPfRRqpuTHxrrxX0IYWhyCZe+QrDdgJNCBEc58?=
 =?us-ascii?Q?xUAQ/INulY3DSoIYaieBKb3K50NI50yyRtwDoJbImFdNvg16Zv88L1tAaVKK?=
 =?us-ascii?Q?YhmbjFpPKBBRDkgmrkHwjbBSRvl1vUHgs/pHq2ARXeXLHinT0XZAJXKOLKT6?=
 =?us-ascii?Q?xkWVOYCeSSqM5sekEdVVHc2P1wcHhtoAKebQQo8CAVYgJ0H6lgQg8TYterjW?=
 =?us-ascii?Q?55Ev7eDyYyTFziMY+H2Nl1W2HPELo9p4RqvXXvpwsiIJKR5bk9ZugdNSwJ3V?=
 =?us-ascii?Q?AGybU3x0ZUxkiyzxPUm25kIBREncQnQWyWN3q+X00PO3zErRJbTCfZxdCPDD?=
 =?us-ascii?Q?oDTKsk78Fp/DT5Ps/BSJGOn6BA4DQQlAZvU82a9GaWyd5oL9RPy7MBYR/faA?=
 =?us-ascii?Q?fJLtV3HI4Lm/e/lphSqZixMTqCeyW77mFWDTG/dCD25L5It11HtrmA3ZmxOC?=
 =?us-ascii?Q?sA/FOZa6BIhmdeVDIgjVdJEdh/5brHZ4S3A3A7+HUQBwI9YzOD2pMspX6XVm?=
 =?us-ascii?Q?ETb9OZ9i98QQVCV+3t/DxJXBssjdsgNlvgnt05ydmZ5yy7P2h2MV2wIU4Ztc?=
 =?us-ascii?Q?G1HJ8raxr8Z4+zS/jyGme4cIje7GC90L/0RBUKV+FxQ4taF67I6nXD7epXR4?=
 =?us-ascii?Q?4VbVwk0SFEsGFW0q+HK6OohiRQMBZ4fhypSWYoyWkXIjDXNce2V/P3RRZfv/?=
 =?us-ascii?Q?oyCoSPFXP+qHvifkIEnIUu+c2JWhheUWiG5CHAQcO2GYdoJOJPEQaW5k4BEV?=
 =?us-ascii?Q?LxtOHSxraz+ytefYpNEoZvif?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8ac7df-4ad5-445d-b159-08d8d91240d9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:29.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4KcV9/fiWAJoqWvSeyNEkEwiLMEbTdJt56biHbyLR8AwghowsSZUoI2a9gWtAQEJHCxpk9XGqcsuv0Y5EtSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Set backdoor loading way in current phase

v2: change case location to not break other asics

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 1beb08af347f..358134b29c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -406,6 +406,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
+	case CHIP_ALDEBARAN:
+		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
