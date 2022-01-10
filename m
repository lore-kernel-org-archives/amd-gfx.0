Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DA9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 11:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90929113BD4;
	Mon, 10 Jan 2022 11:46:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349CA113BD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 11:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiXos04HDfspZ1Hrb5Z28Cxuy/8u9m9MBPtVqF+jcPG4RCNS79EiHzYPGM1HSxGgKxfKDCUVoZU1/ZtN/i5t/O/94Rrw6lUjhG8M5ywkF/HYSeKkXidkIODMCiJw6JFG84/APj9LxpJ6YDdTsgfWtUzmhEru7k80T/LD7kfVjPTik5VVXyHyshNAGZZEStQaFeQHQv94hQyu/461P4RhgA4pZTBT9r8UeEtyn8F8l7GXzZY1Z9Pki4uzI2Y/62tLkGcFNS+m7aMqWILmdaRndrXMWU7vor63HHr+wIvxWVV38qj8Ec5nvlA8pYnZn13nNISU8aXp8NYN0PU4JWTMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDzr+7hv/of6lyJGZZsSlaL14d0quspl1r780lKWlbU=;
 b=NHFI/gbYIAY32b/2k7novb5CPOoR+FEj8Wsbo8k/pdJGT1FhR1yWmZ7sqlTyVBX2Quc8log2SwCOQCRbFstezU/PVFBE07jYGR0ZwyakNjXv+pyDF7rvvFUtKoJqFZqXUZ/FInBneSoK41o/IuUcAZ9FLCx3XnUDLaVpqeaxI2mHeCYID5dztyceHFu+dCTBLUV+b44TLT6VVtpf5HvicYqKb62XszWGTSjy7QAZtiu0z9UsOPPSmV+yhS3AYcqsXTmqAsoGjyniTbG+EWNzizxRHYf5WNsBTlc3gbnuZUnY1hfEhNTBDRUb7Qa256ujTMY0EcSUQCDY9v9pNRSgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDzr+7hv/of6lyJGZZsSlaL14d0quspl1r780lKWlbU=;
 b=pDi/wCuLH/lrIFa6pgbR0pbaxenkBSfBNKNpIiCrG//ABlM4paRFii7T5TBlSNNH1WhEpaKbsJnAT5c9FPjw2jujR8SAug2yO5emGEQHxGIpNotbLvpb9qhwr7/xF5cMCuVBexiCijo9wCfvzCtlIdikxWd+LoeLI75OjCXb/lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Mon, 10 Jan 2022 11:46:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 11:46:22 +0000
Date: Mon, 10 Jan 2022 19:46:02 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: not return error on the init_apu_flags
Message-ID: <YdwceiDQckXpejCs@amd.com>
References: <1641781557-32516-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641781557-32516-1-git-send-email-Prike.Liang@amd.com>
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524c5596-6ed8-4a4e-6c44-08d9d42ed319
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678F86E0498BC1C1A75B2A8EC509@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZdg9KsEx/+DFWBbJgL4N9klpXTeh3YHx7uZ40woqQjalUz1f0WPP8yV/b/e0dy7L4gJnlY3QmoZeUQ9Wkv+WPdXTUzHPqE0vpoA9IXqFeKzknC1t+2z3V0bhbrNIf0cmJokOQGl1sbkPaAxFD4j9dzBZkYP4YsiZyzbymQxv6+YvWe3DvJ8ed1tw4SEN9xr4AjA020YEdgmP9aqm/2ki5hsTJyEJ1ITF4FwY0/5DTp3uk413Ak1qh1Ig7f8Dx+YqrHR1SeyttpWBb2J1CbCQE0aUSGInhh1/3L/0hZOK1r092aUiqZazyQFGnUlWqEem0mSFyt8PW6FcTezMWrnRZZ7YuVPZZMcCyGMKkEoAyhck0uWAuPZuk9eVa0cqDxEGhh/kZr9gnHV5BWKKQ9eo3RvNqX2yMbCVNRDb/a5W4lWT5j/MgbXc95h5NtbjYuWss5AUB2vINO2LxGWUc1UwVKiPw2Nz1BV8VZlHRn0B5MOYLpEpDTTZpCX7uuJJ9VP9SxxZuxMeg3JPkGU6O7ZNW5RbeJ1/OYRmdiMtRNlu/Yr+Z51mZ3DPWcq0hvTgdRd8yXVFSMEpOj2Fsdcsh95sbB+dWgxHRMgCdImvTh9PDgL08ni8oz+x7MvJSzoQhr2kDjLX+OdycvjdssHfl7WFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(186003)(4326008)(6486002)(66946007)(2616005)(38100700002)(86362001)(6512007)(66476007)(66556008)(5660300002)(37006003)(8676002)(36756003)(54906003)(6636002)(8936002)(6666004)(6862004)(83380400001)(26005)(316002)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UjnGS/a0v4kwj1tVceAVPTsT/XtePCynfTWHWJn9wa/j/X9rBmy0QfN0CTS8?=
 =?us-ascii?Q?6uJUPWJhxl+WZxiNFaAZjBlHuqZOWZZpRPHj4wpdcktxBA3PC1yPM/DSSw0i?=
 =?us-ascii?Q?ZyjpdUkIE7kHp26Bhl51XM86yAoTpo/y6JIMT1yRS9wakCXqNwpqzM1hetaE?=
 =?us-ascii?Q?ZyO2Sf5btJCdrUVxy69z6aH89fIl5K6ZqWqbcM0uRRzDZIRfYwDt5LMq4Ma2?=
 =?us-ascii?Q?S5msomAhXEc4r5IoM6Ketpy+hB8fMr3B1zj08fLrI1daGpcqty1Pb2ujSzrg?=
 =?us-ascii?Q?gNMXmONDdKubGLUA/TR5enyqd16FFSvYZISFHWwddcPOUic6aGKA2pyN4xgt?=
 =?us-ascii?Q?v8umU0icRIknVa97rtXe78UqGJy/8YC0udKmYR7zI8EKp84afcKO57+f4ziz?=
 =?us-ascii?Q?RNsYqSWe0fN4lh+c+2jACt9ZTqASQmUH5IGX1X0FMme6q7sIc+hHsUPTyWME?=
 =?us-ascii?Q?WvCAlJVsPqidP2HVH/PNAsMJDvj30OZQCsuv7QCk1ODTzSQIG7QMSWFP43CY?=
 =?us-ascii?Q?rWFec9mDqcjacScwzPPUYiKFvAJz+u7FN9CxJM6v+zgHVqPLH1ST9QI1RRSF?=
 =?us-ascii?Q?iUVjPsahkf4oZMPrcX57DIrxGJ4IZKqelMGVpFgeX8xWUHUtcOKIeLPQgs4Q?=
 =?us-ascii?Q?2keeOnwolYUlp3ATxQcjZm4UFTgSylomlG79NsMN80m5ss1Q6LAKbzZg67nR?=
 =?us-ascii?Q?Hpuo8PHnqEbW6jz5842w6SXEEbtnNt1pI1sU7Q79MZXj0GUyO0GCqe3Y5s9S?=
 =?us-ascii?Q?iTg4+cM6zJrDWww7PURDfmS2iShmu/3NNMf6J9IW3qRJFKjigb3rBhv4uGT9?=
 =?us-ascii?Q?R81M7hLDDjrvbOWfECdLJ13bmTu96DjKZGl3Qb2KK1AbMLWUI0B6j1+Lbk1g?=
 =?us-ascii?Q?x0NXK6Qtqj4/phgWMFZV2xKanIg77RwezEfIsQG7PIlMSYe3xGXN/OuUr3L/?=
 =?us-ascii?Q?MRC0ApXrf6NBa3B8oaAMJhcIN6Hja3vCEqKinIEUqInLKm3TwytiP+z7oRaZ?=
 =?us-ascii?Q?z+B/Ne0EL8o914Ccvks9DkwUAFco/LfC9zd8UrSnI6BipW+zFk31dP64xNsk?=
 =?us-ascii?Q?KJTDnj3nRtvRnaA8GomXLmof/q6CMc+Wzde1dD7qbVRq9UWkv99+9pDHOSdS?=
 =?us-ascii?Q?zg2OECV8r+EGXegX6W7IrOmiTw0Sum5buJ+rxhMCmyYKhl10IXHRFzShAoQi?=
 =?us-ascii?Q?UMLn2OkIPC5a+BMoOJyBvDPRJvaJu1VPMzfWBEvOryH3id8T16lOGd6/ESXi?=
 =?us-ascii?Q?pGmKwWJXmhLC2FkYPGfW3HRLkC8LJ9rSokzZjpDXxbj8cxWE1p77qTAT7Xjg?=
 =?us-ascii?Q?7MYEirF1I226GeFpKXR1HwSnHEDkVtcGHqJO90qW8zHy+59lK44y3tr4QC+a?=
 =?us-ascii?Q?yo71Pq/hclJZs9E+pe6gWmn9Ez7a7zhlP0yQBwTb+R6Q4+ds9y6s9tmImDzP?=
 =?us-ascii?Q?6BVt2NgR3YBB0tsohzsCVJDQ7eEGHqi5Xe5OfprfBiNxPBhhtKKuBVS/eBys?=
 =?us-ascii?Q?tMp7ltcxF3O2AwbK6aMEA02E3e3hirIuD731Pj2kc+wU9Ir//SGv1C8PM5k2?=
 =?us-ascii?Q?BcASiEcOn+I1caspRFEonIJKHL2iJG3I5wVZ9m8+u1wF/fmguwNPryIY718u?=
 =?us-ascii?Q?SyU8VOx30PSizzNOuwR8J48=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c5596-6ed8-4a4e-6c44-08d9d42ed319
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 11:46:22.8315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/3OS4iGwopYoBs/nAnqKQJg5RoORPYSRtWRwtbHiePVdTVmSjCvUGUFzWSoluJdndqjfp/UyEJDxomr9pm9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 10, 2022 at 10:25:57AM +0800, Liang, Prike wrote:
> In some APU project we needn't always assign flags to identify each other,
> so we may not need return an error.
> 
> Change-Id: I92c1acb9ffbdba7e9a68469163911801db262412
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Please remove the Change-Id. With that fixed, patch is
Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4322d92c25c7..2a6671f37336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1449,7 +1449,7 @@ static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
>  			adev->apu_flags |= AMD_APU_IS_CYAN_SKILLFISH2;
>  		break;
>  	default:
> -		return -EINVAL;
> +		break;
>  	}
>  
>  	return 0;
> @@ -3497,9 +3497,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->psp.mutex);
>  	mutex_init(&adev->notifier_lock);
>  
> -	r = amdgpu_device_init_apu_flags(adev);
> -	if (r)
> -		return r;
> +	 amdgpu_device_init_apu_flags(adev);
>  
>  	r = amdgpu_device_check_arguments(adev);
>  	if (r)
> -- 
> 2.17.1
> 
