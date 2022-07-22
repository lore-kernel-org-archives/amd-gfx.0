Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACA4C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 08:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD0918A92A;
	Fri, 22 Jul 2022 08:20:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BBA18A873
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 08:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etEYNM08bC59JypT+k7CwB9P8XptxhB+0R/wv4hxXCPfsB/Mt3YJsNdlejJZqltySYvzWCalc3iRXY28LO/PIsDmXuF2ucGgosCaG0A+K64KmF8UTcmi9YT6OesgioJdwqs8Tnp9F4F0fh/rpwVCuBAH6hH2X1JOvihfcvADZZl37BfsNaxuNV7ymakR2WIp/Bx/2cvqF45zgh6n3qAHUyS53OikNk4Fe3QBPFeKKos8wnjTcGBirsk+bP9a97Pf+QV4phaO7X7jWi1lkKZKjrje13P1Hzggmhdpkduu5nxLuifCwxyYzCDL2QhVWbIPzGNWq7lMhVC4zNsR9o0HKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilhxExSXuF4jyQLAF3YCFkXkVYxCdk3ihMv0zgHiuP8=;
 b=mJZ17P2F8go6o/BVI11TBlhHiy2J0fvvMnXCXwCqVgxSLzfBYIvUDn6h9HtsrE+TdHSlWRdjuCcV+FCs39kTqR7J9V5uspu4mx+8D1i5zPOfX2x49b8K3YQtkQHGoGXpoHWt8UcULbdss6j5qjQqJ+sKumAaZXgTOlECRzY8Dd0yuQTVggJdlEZJx0WUM68JvoJLP3/gnwvkNPbVEYlOps+4s1GJqihIUXWhSAGhnXgMu+PaShX0v0u18nJ5Yj5sSixpvMDzXkmoyfl7vMr+vGbxYfXYX1pvOthL9Z2RZwYhxgEyxXZQqvu3zPj7wl+/izAaqJgQ46M1y3HmJGMQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilhxExSXuF4jyQLAF3YCFkXkVYxCdk3ihMv0zgHiuP8=;
 b=HgUTOKV5qPPrImOyfsTumONepF3dZZOMuyYQI49eC0KzfebrgL6RQJx6CiEcYXCUO7hoEJjOk6goYNK493As8POzWRQW4YGlgCHSSCt6BiSulAoVRes8Z7N5D/90rr7KV0mSmk+n42wYUbLwCu7z2+i6LSi+FD2nVb5RyT/z5uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3722.namprd12.prod.outlook.com (2603:10b6:5:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:19:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 08:19:53 +0000
Message-ID: <30f6ef1d-a1b3-3228-37f5-3cfede6431b5@amd.com>
Date: Fri, 22 Jul 2022 10:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] drm/amdgpu: add debugfs amdgpu_reset_level
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-2-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220722073403.5171-2-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d7f5d0-40d6-409b-9cd3-08da6bbaf470
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Vy4mywinysAk8EZJDoH9jEsaMPOAZix1hTjpZJDe/6WdxVKXa5PL17UhdHAzfIbyMrh1lLmltN8C8ASU7iU3klH78yM7RSb4zzMCitW6QKZAfEgsGHT8AY4uwnVcxBVmzBamRojuFaf4z20bdVec0dzbT3DTYUMkLcdJiDGdA+FMuz8445yAdpxS5Q2oZnxVwE3n6rSNWVnO7fK+aiYbReaXDKmnDvVbYu2Ep5+IvZGlyAt493FiUIc9jqI1HTsWJYiP1XlZJJNRhU4Rpden//ov3hV5JOVOfh9AwGZgwqysZI/X74WM/Rbdwzj2q9B0HI3cFy1X380y6D5F8bKKWz9sDU9UdDlzJdX5ktgJAttTyqaX/Q7XR6Q04w9FsPoNLRNy1fsKBCP6/TgYhefZJYqjVvMjDh9jnZZzgAsF9c9dYYKHFVVFLb15SX84n74OSO+PUjqFyy3Dx/1NlwtRvUY8MpyoAYsIlRCJ1D0zJPTET+1E14dsIyL6e2K8SNduocjlyAkVoNne7/JLB0c3hH98yfbCGRDai7K2LcXgtmLv0KI9STa1/i5ub3BbSPHWMm1vpbVGCHHb8cPYBsqGyqWfY7OhsOqPd1BaiFMtZz3UkBLJ6GAo1fad/zy6IoSdcsfpBOClYiBhRT1sZgdJMGoDl3EK8PltlyvpXZOI34Rl3zejQNzfM/Oc3w4abW2BilhxVY98QonyQtQ17UZpMCdplkyWXbcvakjpYvmuN3nEWJe9uNkr0gI9WkvM4nH0SMo/suRAdvJ9c/DtGkVGf1K49yDdt7AdAqKg4WZ2+GzvAjFlEwdcxaoFTwNTEeFm3yDGcSH+VPAmuCjsvqfEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(316002)(31696002)(86362001)(8936002)(5660300002)(8676002)(4326008)(66946007)(66476007)(66556008)(186003)(2616005)(83380400001)(38100700002)(41300700001)(6486002)(6666004)(6512007)(478600001)(6506007)(2906002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZybkxuVHhjK2kyTzB2ZHh6dTArTzJqRTNHeC9rc2IzelkwNGdvV0x0SFg0?=
 =?utf-8?B?bTVrSG45Tmx2dXA1TTBIUm5qMVhMTkg4RDZ4c0NNRWZua0hCWlliWTlXdWor?=
 =?utf-8?B?dG8vUWdoRzF3SGRWa1orTitwVkZqUHFMNGJEQjZrSzN1R2JMTDJlRVBFQWIy?=
 =?utf-8?B?WkF5ZURLcE91akU4L05LaWpTbWMxcmc1c3ZUbWNheU9nMTZpdDZPQ3AzYmZn?=
 =?utf-8?B?MTAvWi9mN0Q4Rzg2dG5CdUZhdWtqaHZ5anZKYzcwaDJnNDBrbmU3Y2xCYkhp?=
 =?utf-8?B?Z2VlWklsVWZNYm02SzN3bDlRNlhjWStYNDB0NzkzVHlGM0NObUZTcU8yMk8x?=
 =?utf-8?B?WHJRVEtjSjZyL0FLN2t1Qzc3R2MwV2Z6R0duQWNobStKVldoZXp0ZjltdkZF?=
 =?utf-8?B?aElKOS9qVlBpakNDQmQvWHp6MU12VGtiOTJsYlFEYXBjVDRBWmhwQnlqSmlO?=
 =?utf-8?B?Y1l2NFBjeEg1S3JrcEZUKy9ZV3ZwelJsVmc2UVJFTC80cnpwbWtXU0pEdzE2?=
 =?utf-8?B?dnp2cUZGc3NVQ2tYL0p4NGdKMngzbWdXdlo5OUVUWjJsc1Yxd25xYklUUENK?=
 =?utf-8?B?ejBjOUpRR2JHNUNFNEZlblpFTjJIK09rMk9lQ25JRGwwdDgyd2JOQUttSm84?=
 =?utf-8?B?c0lDYUlkQjlTMGJlOHBwb3pFWFlUZnVaaDhtcHRMZWNQTC9JVTBOV2pza2pC?=
 =?utf-8?B?SCtQcmE1MTFsK2xxZDlGdTBaNXAvYXJVSTZHSmVWSzZCN09Ld3BqcW5mZ2xh?=
 =?utf-8?B?MkFxQThkbzhnMWhtSE9JUmY0eGxqWUFnRTMrRU9nOG5aOVNWajNKdmFDLytE?=
 =?utf-8?B?cTZFUmxaVkFNSm5FNVRGU1ovRDRVdmhnUVhZcjhNUTUranFVdlg5YW5hQ0d4?=
 =?utf-8?B?OE1KcTlDQ2Zsa2JxR0lDN3E3S28wNHMycDFSZExCbkxHaFA3UDdRK3R1N2F4?=
 =?utf-8?B?eFJnaEhZUTNTV3JEUENCN2tpNloxR2lSYjNFdytFb3h3ckZIWTNJb0NsV2Rn?=
 =?utf-8?B?empuUG4vcjR0MkRBMmZOSytDREFkTTg3cjJqSEkxaXZIaWtNMUNxc3g3cVhu?=
 =?utf-8?B?aXdEdmoxYkd1amVHRWF1ZE9iSkplTHZhYUl0T0N2bjhPeHVCNVN3UmhYWGVP?=
 =?utf-8?B?OUt2TGE1VjdvelFqVk4rdG94M2hNWW9WSDByVVJ0Y0ZkRm03VThPN0h6TjFo?=
 =?utf-8?B?RU4vd05mWEF4ckJMWE5SY25sS3JtMFNkZlRPS1R2Y2JPcTN6b3RuL2JRVTQz?=
 =?utf-8?B?dnRJWmUrM05oT2lrN0N6d1lRVi9lUjMwMlZodUVlYjBtbDVDNVEyZ0R4eXh3?=
 =?utf-8?B?b0ZTcGtWVzIvU3BMb2dBaU0zQnh2THRLN3dMVnF6VGJ0Zmk1SjVPaVExR3Mz?=
 =?utf-8?B?NU82cXVuY2llK1I2M2ZRRWtFUGJibW9VYzNpcld3M2RDWEJTYURQNnFBNnJQ?=
 =?utf-8?B?WXg4Ky9XWkI1T3VTb2NKSHR5RG5Ma3NUTVgvbWZSejR3TDk0a3VBYTZjamRm?=
 =?utf-8?B?T0Z1K0JxU3hjb2pTTW1xRDY0aUF0RS9JZkVxR0FjdkNrenh0dkhUMEova1p6?=
 =?utf-8?B?UHNvR3VLbGpXZW5BckMwUXBVNHhxdWQ5Ym8rUjhmdXZJWlZmMWNLQ3BqRk4z?=
 =?utf-8?B?b2JDT1dRbzF6Vy9xOFkycENScjFJR1kvT3IzV3NpWE92YkNaVllhb3ZuUVoy?=
 =?utf-8?B?bWwrV0dXdmRQbjd2N0NpVE83djBtUUIyNXdDYUxXN3FONmNuenNjNjFMVCtJ?=
 =?utf-8?B?Z3NSL1l1Wi9sYkZXVXpxbXhFeFM3cHpDSDlpNStCd0ZsTi9ZczFieUZKOXJW?=
 =?utf-8?B?YUduelY1eXNvV2hvMGJvdWFYZEJ0VUhZRTdpVzM5YldqQ3NxWnVhNk9XOXBx?=
 =?utf-8?B?Sm5BdTZNb0hudG1EWG5MeGF1WjRDZko4RVloV053alNVWisrSXdzKzNwV2tp?=
 =?utf-8?B?dnBoaDVqdlpST1pnZU1TeGs1ZWNQbXFSbk9rVndMSnN2YjVRTTFnODk4WTBx?=
 =?utf-8?B?T0tJTnZ0eklLQXhCeEJlS0ZpODRnSXRGbkIyZDl0YnZ6clhKUFZmRUtTc00y?=
 =?utf-8?B?aWFNMDNnQUJRbUFIWU1wNHFjWlVmVnZZWXlNTmROTTVvYVJqOHdXNTJKZDly?=
 =?utf-8?B?MGpBdWg3VlhVYXQxbFdCYjhKNytoYUVPTTZTTEE1M1hMMEpuWVZORy9kQUx1?=
 =?utf-8?Q?qb8AmkTt8wc1Fmmx7uA6of8kHtKWAOEP2zXwyY4o9Bud?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d7f5d0-40d6-409b-9cd3-08da6bbaf470
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:19:53.6706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0wahyTei+r5uhFEuKv1p2weRz22opTefDHpyF3Ipb044aolaI9IPrYLlrw6C97N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well NAK to the debugfs approach, stuff like that is usually a module 
parameter.

Apart from that this series needs to be reviewed by Andrey.

Regards,
Christian.

Am 22.07.22 um 09:34 schrieb Victor Zhao:
> Introduce amdgpu_reset_level debugfs in order to help debug and
> test specific type of reset. Also helps blocking unwanted type of
> resets.
>
> By default, mode2 reset will not be enabled
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  3 +++
>   5 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6cd1e0a6dffc..c661231a6a07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -238,6 +238,7 @@ extern int amdgpu_si_support;
>   extern int amdgpu_cik_support;
>   #endif
>   extern int amdgpu_num_kcq;
> +extern uint amdgpu_reset_level_mask;
>   
>   #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>   extern int amdgpu_vcnfw_log;
> @@ -274,6 +275,9 @@ extern int amdgpu_vcnfw_log;
>   #define AMDGPU_RESET_VCE			(1 << 13)
>   #define AMDGPU_RESET_VCE1			(1 << 14)
>   
> +#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0)
> +#define AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
> +
>   /* max cursor sizes (in pixels) */
>   #define CIK_CURSOR_WIDTH 128
>   #define CIK_CURSOR_HEIGHT 128
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index e2eec985adb3..235c48e4ba4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1661,12 +1661,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>   	return ret;
>   }
>   
> +static int amdgpu_debugfs_reset_level_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +	*val = amdgpu_reset_level_mask;
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_reset_level_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +	amdgpu_reset_level_mask = val;
> +	return 0;
> +}
> +
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   			amdgpu_debugfs_ib_preempt, "%llu\n");
>   
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_level, amdgpu_debugfs_reset_level_get,
> +			amdgpu_debugfs_reset_level_set, "%llu\n");
> +
>   static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>   				char __user *buf, size_t size, loff_t *pos)
>   {
> @@ -1785,6 +1802,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		return PTR_ERR(ent);
>   	}
>   
> +	debugfs_create_file("amdgpu_reset_level", 0200, root, adev,
> +				  &fops_reset_level);
> +
>   	/* Register debugfs entries for amdgpu_ttm */
>   	amdgpu_ttm_debugfs_init(adev);
>   	amdgpu_debugfs_pm_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e8c6c3fe9374..fb8f3cb853a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -198,6 +198,7 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>   	.timeout_fatal_disable = false,
>   	.period = 0x0, /* default to 0x0 (timeout disable) */
>   };
> +uint amdgpu_reset_level_mask = 0x1;
>   
>   /**
>    * DOC: vramlimit (int)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 831fb222139c..f16ab1a54b70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -74,6 +74,9 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_reset_handler *reset_handler = NULL;
>   
> +	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
> +		return -ENOSYS;
> +
>   	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>   		return -ENOSYS;
>   
> @@ -93,6 +96,9 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>   	int ret;
>   	struct amdgpu_reset_handler *reset_handler = NULL;
>   
> +	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
> +		return -ENOSYS;
> +
>   	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>   		return -ENOSYS;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index d3558c34d406..1ffdc050a077 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -405,6 +405,9 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>   {
>   	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
>   
> +	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
> +		return false;
> +
>   	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
>   		return false;
>   

