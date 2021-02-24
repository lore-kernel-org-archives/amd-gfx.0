Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D8C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0281360233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0281360233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB99D6E0BA;
	Wed, 24 Feb 2021 22:19:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F9089DC9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhwZ6y8+P7S+GO53XfpyqFax2KZSyeaZScla5dVbHBq6lpxXAuYmXTTSS52o3EVG7rImgzu0Wn/9QnyMPMZamOB6L9qTAqLU2CDvdbMbt2bOK9j17XDpvC8dt1rc8WK0Z9S8NgAqJ25KKTSzt8CFyjdL5hHQJkfkrk7++8jRiMYEx5R3rgirWlCAtgsya9p7f/FogVxphlnlIQv++Nxmu0x12PmZPgfEjPkD54gfgG/CbECNm1W+FO97PEQzy+A0j7eo7+yxEQeCugDiMXTwtBGMb6blNEMtgtKmhACamJDt7+3wIxIH9UBztKK470wVfBBbf++FnFQOyYVkAaNJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xddk7rpPQMA1DNP0Yep/205Sdqv2OLxiAh1iudT7SV4=;
 b=Y/hk4nCqKvhgWMeFaSg6xN+SYy4BXhQ1e2xUddfH7YN1UNBVSUiNt0eekXCx/zlthXhr0DcVd4xbgi1hP+EK1agBQ3VQKfsMEWf0tBtBSwHLicHuER3+LQUnAmxfcK5HbdRmas8rNWUgAsQw33z/9vROghrKL5OGPOVoRM7RcV+WBZEpotMDOAcmPnvFlZWc2ixNgmE9uly3Os819q1A87n0MnTaOVzWDik3qG5m6OdN8PEwehnVSfr4NEl4A4kW4Vj5mLWKVEV1unN7D+pX9QkrBJ4REfWsq31PD74Up8bQ5yMeOmlUI4s1N7tAbx0758rKygPgt/C/gsHkBju7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xddk7rpPQMA1DNP0Yep/205Sdqv2OLxiAh1iudT7SV4=;
 b=GIjbxy7v5C91PpKvzm9LE/bUt/AKwJ6Q4gAXhdf/lgtssTEP9Z6uURZdmXEGu3tKRUJf18e1ZRWRGtTK0+WRxL7s7uIIBo876ayYy8b/xDDGD/skZU8KPUUs+RvlM7bmbVQb3jDn6tIXt44uU8aNiA9RbLh3twhM73HBCPAz1WQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 018/159] drm/amdgpu: add sdma block support for aldebaran
Date: Wed, 24 Feb 2021 17:16:38 -0500
Message-Id: <20210224221859.3068810-11-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5b17654-01d9-49b7-fd56-08d8d91241ae
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41756159746A869FFAA6A47DF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o278Hg3PU38sHaQ1zEI97QxAiKlOcVtTmm0tm7qK3VUimCcOP0S4VNf8gG08ztXppNF1LVPHnqSfOenU+hcvZm+AJFbHYGgFAlWZBaREZodF1fk4TAdaoXjmp/J6WvNDraDKvtgaTqPuiOFz7hi+TmFoddYD5hyrZ6Y1ue0C/ImqqB/9gscWzeRlIoOHBz0SYdmoYWmZPxgCKkeYj4Vnldx9gmKrASPxIcXmwBI6lWffNtOT9tuJGqs0gUE8VQ3vKwA4NZcW2Xi5VUSwjYgjVV0lu8kgDUVgSyYtUZdbGziQxxieBs/ewNbIh3EJ1DnFmrVuE4h//WGFOKmiGLoJA8rAmMmnJ3csHJc62hzqzrdIsrcjFOvb0ds9FsKUW154XhUCIOJAxvt7Jd6EDpOWWcTd95Zm4Q001VjXVwuqKUKMXpln/OjGQfL5Odw5u5Sbz06h9ZZ+EDs9oTXiXEFGJW2MdoDwdYh5hMOXPU/aoJES6SVubhXVd821Moth8+5Ls4NHHAFCw4vmlheIh4vYWAYiCRk5v8OSK7dyDm4so6Dm2EkWeUMR7NCTJwmqtXd6zNpTcgC6VQZ/8VECyOY46A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JgPWS5XG8HnH064COa3ZkN3IuQhiIWMkDMnStewfNRetsMP5ZIW+3mv5hSjH?=
 =?us-ascii?Q?EA2kDKsU2AH7Qk797j9lsN5Gqq/Uw+0eIvpimPa+Fi4397Lb/vPBKkKIkB0N?=
 =?us-ascii?Q?Y0nJHi5G+AeybAlP51tzNFe8BDxkr1onkxWGMZOgiDxgInugpOrXlXRvEFbO?=
 =?us-ascii?Q?xP7hrlZNPIeTCXywtdXoL7hww7Gf5eXyPusLcMVkqOCBoZv4Ef/SNeRhKwXt?=
 =?us-ascii?Q?QJi3uZngyt7/o19YVpyOqAEbi74mypG00JkQU3CImiUMiRnfpuuZeP6XMwVB?=
 =?us-ascii?Q?dnvHcb3fMJ5ci77Gbz9AYCt3DFFroIiYlxHud7DJrzgZE7rw9vIhycXcZ2L0?=
 =?us-ascii?Q?5Jl0LpqnQh1onKqydv8uSncYshEbAlw7nq4TStR6eWjVlOg/ZcR2rz+C/Mot?=
 =?us-ascii?Q?cfCjrCesEIH3lgG5lZV53qzxWQ3sQDb3/x+SPbLD9s3WESTEOR/EPUbRxUZ/?=
 =?us-ascii?Q?hLoMQbjw2kmSLLsHOvFynj7j83s8WZVp6srsdsJAKmvpDqO5J7K0B5XIm+h0?=
 =?us-ascii?Q?hkOco+z2UKtmrZbHYjvg/NHMBZ2rFv3xdPkxRARs0LNGvvXr0dxiQFh4SriW?=
 =?us-ascii?Q?XEXGz33KCWSBV66mvJBy2f3+yFTfmhDGX1tBdOwDbx7AOtEhG+p648dyIiAs?=
 =?us-ascii?Q?e6WBzMj9sichWnIFYMI3q1ObkrYFN+29fXawQS/tSxyk687PX+G5FuEN5TMk?=
 =?us-ascii?Q?IG+vNI7b6Otj19jaF8lO5T6g4jIz5M/v88ZrDryR9tVI/oE6o7Hb1qQbGFs5?=
 =?us-ascii?Q?Bn5RlwbkEFTeUb7rKw1jjDEyov7COFme4CWsM0BYf7xYeEGx7W89/yCPJ/Dt?=
 =?us-ascii?Q?d8MkZ89CZYllKtXxIjdt1gpUbSx7lzxNLunfv5L31MrbfpUWW4mwetEPIsEm?=
 =?us-ascii?Q?lpMciEUrpv4jQBcT723iN4yojuNq9ApY5IFrGjp5kMy87O006EQ1r638C5aa?=
 =?us-ascii?Q?7WW6yMjlB9JilROJJLc7FYK61NAqJMQxF0lTVFuGhSGeTLkBUY5bwDgid5XO?=
 =?us-ascii?Q?sGALe5yX7YqbBobano1MBCITjdDRwtA79PcOs8M2otO7zgj8Cr9wfCjY55jz?=
 =?us-ascii?Q?JOT5NGsG9PNMKgPKRyqzX/xW/xR4OzBXJg+EQf41b9bw2erl5MErdQStlyZ9?=
 =?us-ascii?Q?ICVMfrhR063TiedKtvdAGuypZ+TSMG+q+S1DXlTzoCu/acYPeWecE40+FGPw?=
 =?us-ascii?Q?qTcbRK8tB2KFtm19q2QL9RsdsFe1naizZT1X9UiGMkLZYWLSaR+7GsEVhaF9?=
 =?us-ascii?Q?w7gLf7255NkKR1G7WczBfyF7DpdPhjtnfjT8pmV4cP3BifP7Zx4lsUaka4RS?=
 =?us-ascii?Q?eOCMU0Njst7l0PZ/UnWDpk54?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b17654-01d9-49b7-fd56-08d8d91241ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:31.0338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXz0ary/EAdY0KyHB0N/KiBSEiVDhdbgMYrsN760EbdqExUNuWVMnLbGvoxPMDwYnAcEcdb9Qbk2EAwSEA/EXg==
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
 Evan Quan <Evan.Quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Add initial sdma support for aldebaran, and this asic has 5 sdma instances.

v2: remove adundant condition check

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <Evan.Quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c8c22c1d1e65..5b5081cdfa3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -621,6 +621,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 		else
 			chip_name = "green_sardine";
 		break;
+	case CHIP_ALDEBARAN:
+		chip_name = "aldebaran";
+		break;
 	default:
 		BUG();
 	}
@@ -1825,6 +1828,8 @@ static int sdma_v4_0_early_init(void *handle)
 		adev->sdma.num_instances = 1;
 	else if (adev->asic_type == CHIP_ARCTURUS)
 		adev->sdma.num_instances = 8;
+	else if (adev->asic_type == CHIP_ALDEBARAN)
+		adev->sdma.num_instances = 5;
 	else
 		adev->sdma.num_instances = 2;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
