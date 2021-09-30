Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45134C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 09:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF03261131
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 09:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF03261131
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E006EB6E;
	Thu, 30 Sep 2021 09:48:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17866EB5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 09:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsBykdVcaLxHlpmiOZSt/yCOSPDRK087MSNiBGSqFY+qxqJnLz7hQ5o9jR8ByvDAbX2rs9g4+kGNfJlIVxxc1SsCGZh7ictdU6vTKRGxLO1TYDFnYz9PsVZG9WHu3nWNtjcZtMF6FrdyPo0eY9qY5sYw1TWPKEXSU9KjDn/UYW0SZytR3gqx+utJGvIJjlHvJsZIr8m70AxQGHbc2WfIoQIYfkl2IakwKXpq2AmomsGOsqMOcqTOhs1prBJH/jX674HyJf+digEcEDLhsq01zVGHUciXBQbSaUI+OxF1i9tNTS4DtY30Wi3eaKUOpGWZUV480n4kgBVstXR9o61ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mj4Vlr44mCsRbMmsajEV08g5DmBbe8Rok0NuHEXTl5k=;
 b=STYIFEehszHLXJqyP7sN24WH8iyi2OQQfJCakbszJCHmVMjXXZCyMe6qqs3IgaN4b9gFVpBWz/+QlWUD6ojoiz1SDRaU80p4xd1GE2n/8n6DK34hIFBbzMXxy3eKMrzLEhGmCAF4P2gCSf5gYGZWfiJXm/CvstU6KkA8ZATT3Qb6bpW3qNGMckd6tg8jpUOTElvjMSx9vBGKwp8i5Zx2Cf5CDK1J9zOnYmQM2n5/2k5eWkCPji/hE4AC4RZzr91PE0Chdz/c4BqgxZY4tRGDuUHG/zMX9xolQjYPipRflfEfspgKR8iUGUwK3aJVIcGgwqyz0bTuIzbHcVfcERL2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj4Vlr44mCsRbMmsajEV08g5DmBbe8Rok0NuHEXTl5k=;
 b=bonmm8bmfSeirzz1oKxaTuoYiRZ34IfpkW1khsDriQ/f8I+Z193PDJnoY6/TLBJmuyRwrWpLATmBnYy74o0R/fSypypbn6rycLrm1uc/ig15Y+8Ly1oGCiEi+NVJsnovrnq1jJAwYLvMZUavWTUGvrPaeu0KSrNipgQJ7iuS5N4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Thu, 30 Sep
 2021 09:48:32 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 09:48:32 +0000
Subject: Re: [PATCH] drm/amdgpu: revert "Add autodump debugfs node for gpu
 reset v8"
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Jiange.Zhao@amd.com, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20210930092611.13615-1-christian.koenig@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <c7eaccf0-8501-3957-47ad-9d72c26bb47b@amd.com>
Date: Thu, 30 Sep 2021 11:48:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210930092611.13615-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0121.eurprd07.prod.outlook.com
 (2603:10a6:207:7::31) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [172.31.54.68] (165.204.72.6) by
 AM3PR07CA0121.eurprd07.prod.outlook.com (2603:10a6:207:7::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.7 via Frontend Transport; Thu, 30 Sep 2021 09:48:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7c953a-d544-4b1f-31c5-08d983f7765b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5054CC690DDC4ED29700AEDB8BAA9@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzJQwf5qf8ms+OmCEnLZ1iaR4RVg3NH9cBMp8Ssxpp4A9rqz7YgrqHQDhvoeeP5PXWYdeFY93ixs9+mJUmKNBd/TSMd0j7odqrVigKgAQZn/tAYP5NpRsyFXgvSTmHf0YDGDtUmobHX7XVNU9i4Oqiu2XiAyogIrH1CF74PBZm7FRR/QKIxW2ti/pcNKKvX/GQPDo6+mrYVqiga+/N1qbqImXKBWMbZY048kUgKOARyGfZNJ7bC9cVzh4x0yO12JVpVcq0k7sk4af2b8odb1opi//RJjciiGbPChRSI4YqRRBw4lfR781Ks152yLNqmZt1yyAOVIbw6U7z2JX5gyGxwg5Hgl/xjHF+dM4ySyNphgk5pm7ozdCyt8lKls/vzuE2BpomsgJ4Tsp8oANadTUN5zgUZgdrr0ugmeKEE13o4HSGf/YvsxrOAwkM5L2sjm8X62sQ3UVYAyDtu6XnuXWuWaQtRqovzY0TBFoo5tSAnbnpjD7ri5/4uOSfMG4uYTGBH9bCNrvObFor/aigVNdkCGSeLk9po3/2wy9f4pDfqZ6xthuYnBpPeXe8tuzizC6rJSQeFOZVJN+h4MTEDQzj75MgrW8gMduQflubyg9e8j4JcKUjcJiFeGNHjkmrLO0KfGUBj6decrkORBzhnUkAWfNWceyjmtnJXTLuzxGlN/lJdx90kslo0HYnphCoJ/Naiia/TYISh1sWDOLwlccfhQNgPxOOAFMPwcW7+hEvbq1ZIrZe5Idz8khX9vDBO7PiPHpBRsCG0HO/qXyOfWjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6636002)(956004)(6666004)(2616005)(31686004)(66574015)(6486002)(186003)(26005)(53546011)(86362001)(36756003)(83380400001)(38350700002)(38100700002)(508600001)(2906002)(8936002)(5660300002)(316002)(16576012)(31696002)(8676002)(66946007)(66556008)(66476007)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWl2Z0w1MFBYcVBNVFN3S3JFd1dLYjBDN0swVEU3VGRBSE9DU3JPczljUnFj?=
 =?utf-8?B?QjZ4Qm9HbWR0VEVkZDhwOVg4Z0lTV2hZVVQzUUk5RmpIRDJaVm1RcVJxeTdn?=
 =?utf-8?B?SlZSMjFOUDN3ZmNST0MvRkF2MXlVdFRQUXJ1dFZ2SkJaSFE2TmQ5SWxlUDZl?=
 =?utf-8?B?RVc1dWlxN1pBTUpUcTBNWll1Vkt0R1dIMXdObS9VNGxuT3dHbnhUamJmb3ZF?=
 =?utf-8?B?dHE1Si94Y2Ivak9GSFZORDlvRWJiY002YjBBZk1HZWsvWlZhWjNWY1EvUmlp?=
 =?utf-8?B?R2FtU3ZScEF5VXVFcSt3cDl6ZzdReVpENzdwTFBVMTlJaWdSbFZFcHRBYmlr?=
 =?utf-8?B?WVdLeTlmczFJR3Z4YlEyZkR5SE8wazIycTBXTGtEbndLZEdPMmdtZ1kwZ2NC?=
 =?utf-8?B?ZEUyZ1NhQmNLSitwbU5KS1h3aTVEbjJONUthTDN5NG9IckhQbElXcGRTdWQ0?=
 =?utf-8?B?VmNneDVUZ3dGTVZPa2g1QmNlb3RiOENaK3NvRmlWKzc0dDRBd090ZFhYRjho?=
 =?utf-8?B?ZzhaYUU3eTFtbHFEMkJMUmxNVzZPUlh4dDBnUnV6ZmR6M1NEMEdmZ2d4RXg0?=
 =?utf-8?B?L2NkcVJCWFVHSitUVUhEWmkrMzVvMjJ2a3crT3U3Y0I4dHc3T0VvV0V6dWhC?=
 =?utf-8?B?d0l0eHl5RTgrNUYwU2ZoQUVDUTJnc0tFRE80S0tPMmFrOXRYRW1uRnIwYVNt?=
 =?utf-8?B?SnlmTlFQWWttNCtxNWpPSjJTeUlIWk41VWpPUVM0UTVNaGF1Yll4UEJsLzFU?=
 =?utf-8?B?Y0ZXRWxqTkZteDBCemJ4YWpjRlc5S1hka3J3dm4wU0lNQm5iL2Fra3pVakVR?=
 =?utf-8?B?aWNpdGkrZjdPM0VCakZHZkorRnJlS0tLQTZKNGlNV0xVRHhNOGZoQWdsZEhJ?=
 =?utf-8?B?TGFrZG9GS0xkTjlYKzU2SjI2NytGK1p4RzgzMkszTWpCTkhpRjkrSnRFSFA4?=
 =?utf-8?B?TE9WUmZCcmRPZFZCRm05RE5CMkNvL1BJTVlOZS9xemEwLzE0ajg2VC9jbC9o?=
 =?utf-8?B?VStEcHF6UlBBRDhhZHkzMUNWK3ZlbXVQdjg0N2VnKzJDSndDMTlybGtqbi9I?=
 =?utf-8?B?TGFmc1NXdWs0eVAvREJOcjJvMWxwODdmS1BlNGozbGE2ZklNaEtDNUh5VDBY?=
 =?utf-8?B?RC9lZjBSYWdLR09wMVQyZXpaSlpuSXlCS2FIYkFHQWpXSEx1VVgrMnlGYS9Z?=
 =?utf-8?B?bG1aYXdGd1p6UXJzdzB6U3cvMGFBVFFNWVBuWFVDbGI3ak5IbC9aRFU1eUVi?=
 =?utf-8?B?NFYrVGZoc1EycVFnVmZIY3IzeE9LMUIrQk5XNExXQUpIZ0xhWHM0TmM5ZC8x?=
 =?utf-8?B?bWdDWXNIZ3BLK1ltK3pZTkNrM290d1JWRlRRZVdVWCtITlhXK3lPUG5qdHBC?=
 =?utf-8?B?K0dQU256eTdlT3pPY05SS1p4Y0xPSCtkQk9jSHFvblMzeTgxK1QzblFNOFgw?=
 =?utf-8?B?dVR6K21OWTd4QTg5aXlzaWxEQk01Z2t0TXdiN1IzRlFnNEUyUmVGZWo3NXU4?=
 =?utf-8?B?QlpwOHBnR3hua29wNktNVy9EalM4OTNWL1N3L2dybU9qMUN4aDZNMWJNOWl3?=
 =?utf-8?B?b2tQK3NqVUw3ZlNndWs4S3cvbjJDcUJlNmM5TUZaSXhBWVl4Q0lBazJnWVBr?=
 =?utf-8?B?S09GejlLMXhjekZ3SnVESm16cGZRV3UrbFJWZFNDOU5Jdll0b2pjTW1nKzdM?=
 =?utf-8?B?MVRlajR2MVFTYVVDMnVSMGZzWTZORENsUlFxVUJrb2ZrblYzd2h2MWZUaUxX?=
 =?utf-8?Q?vlKmSw4jdpCVpNGloCB3HDr50dOrJWc6xjYcDRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7c953a-d544-4b1f-31c5-08d983f7765b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:48:32.1617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPXrdaTzN+oMnwYEvnCtODZmr2XCEvvSwOQk7yZ2P9jQHOueItxlTsVwaTVAr6d+fdpYfl5jBzY/o++8EPWUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 9/30/2021 11:26 AM, Christian König wrote:
> This reverts commit 728e7e0cd61899208e924472b9e641dbeb0775c4.
>
> Further discussion reveals that this feature is severely broken
> and needs to be reverted ASAP.
>
> GPU reset can never be delayed by userspace even for debugging or
> otherwise we can run into in kernel deadlocks.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 ---------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  5 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 --
>   4 files changed, 91 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dc3c6b3a00e5..6a1928a720a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1078,8 +1078,6 @@ struct amdgpu_device {
>   	char				product_name[32];
>   	char				serial[20];
>   
> -	struct amdgpu_autodump		autodump;
> -
>   	atomic_t			throttling_logging_enabled;
>   	struct ratelimit_state		throttling_logging_rs;
>   	uint32_t                        ras_hw_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..0b89ba142a59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,6 @@
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
> -#include <linux/poll.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -37,85 +36,7 @@
>   #include "amdgpu_securedisplay.h"
>   #include "amdgpu_fw_attestation.h"
>   
> -int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> -{
>   #if defined(CONFIG_DEBUG_FS)
> -	unsigned long timeout = 600 * HZ;
> -	int ret;
> -
> -	wake_up_interruptible(&adev->autodump.gpu_hang);
> -
> -	ret = wait_for_completion_interruptible_timeout(&adev->autodump.dumping, timeout);
> -	if (ret == 0) {
> -		pr_err("autodump: timeout, move on to gpu recovery\n");
> -		return -ETIMEDOUT;
> -	}
> -#endif
> -	return 0;
> -}
> -
> -#if defined(CONFIG_DEBUG_FS)
> -
> -static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
> -{
> -	struct amdgpu_device *adev = inode->i_private;
> -	int ret;
> -
> -	file->private_data = adev;
> -
> -	ret = down_read_killable(&adev->reset_sem);
> -	if (ret)
> -		return ret;
> -
> -	if (adev->autodump.dumping.done) {
> -		reinit_completion(&adev->autodump.dumping);
> -		ret = 0;
> -	} else {
> -		ret = -EBUSY;
> -	}
> -
> -	up_read(&adev->reset_sem);
> -
> -	return ret;
> -}
> -
> -static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
> -{
> -	struct amdgpu_device *adev = file->private_data;
> -
> -	complete_all(&adev->autodump.dumping);
> -	return 0;
> -}
> -
> -static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
> -{
> -	struct amdgpu_device *adev = file->private_data;
> -
> -	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> -
> -	if (amdgpu_in_reset(adev))
> -		return POLLIN | POLLRDNORM | POLLWRNORM;
> -
> -	return 0;
> -}
> -
> -static const struct file_operations autodump_debug_fops = {
> -	.owner = THIS_MODULE,
> -	.open = amdgpu_debugfs_autodump_open,
> -	.poll = amdgpu_debugfs_autodump_poll,
> -	.release = amdgpu_debugfs_autodump_release,
> -};
> -
> -static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> -{
> -	init_completion(&adev->autodump.dumping);
> -	complete_all(&adev->autodump.dumping);
> -	init_waitqueue_head(&adev->autodump.gpu_hang);
> -
> -	debugfs_create_file("amdgpu_autodump", 0600,
> -		adev_to_drm(adev)->primary->debugfs_root,
> -		adev, &autodump_debug_fops);
> -}
>   
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> @@ -1590,7 +1511,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	}
>   
>   	amdgpu_ras_debugfs_create_all(adev);
> -	amdgpu_debugfs_autodump_init(adev);
>   	amdgpu_rap_debugfs_init(adev);
>   	amdgpu_securedisplay_debugfs_init(adev);
>   	amdgpu_fw_attestation_debugfs_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 141a8474e24f..8b641f40fdf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -26,10 +26,6 @@
>   /*
>    * Debugfs
>    */
> -struct amdgpu_autodump {
> -	struct completion		dumping;
> -	struct wait_queue_head		gpu_hang;
> -};
>   
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_init(struct amdgpu_device *adev);
> @@ -37,4 +33,3 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> -int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41c6b3aacd37..4d34b2da8582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4458,10 +4458,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	if (reset_context->reset_req_dev == adev)
>   		job = reset_context->job;
>   
> -	/* no need to dump if device is not in good state during probe period */
> -	if (!adev->gmc.xgmi.pending_reset)
> -		amdgpu_debugfs_wait_dump(adev);
> -
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* stop the data exchange thread */
>   		amdgpu_virt_fini_data_exchange(adev);
