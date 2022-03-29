Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 07:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE6E10E7A6;
	Tue, 29 Mar 2022 07:49:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C56F10E7A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 07:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb11GuELfCxGeXEtc1RXv9kdc3E4KKva72oOtoZRIVrGnnTwdSJqhf7lkDtWCBwYSiDvF1yKWb9p9b9U0g3cNXejHPZCXDOtjw30YIM9vnQSASeAaxQ30oZjrx5ueiV9NLUw7QwBUpMrv7Xl/85fn/QiOksoQSB3pn7bJ6axbsvSPg14XN3HT00eqmKa2f4PcHt8/KcKrbx95OSdfh8XdtIqyjM0V4lb7XNGSEame7S/hbx/6Uvr727BQvbSRib9zf+2TbTF/qszWwujcLb1ymny+Av2i334VX7yJW7d5nu6lrunIUcb3z2H+Ut1vgssys18Rd1iSsjOQHjSoqoj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAZ/UrsCbOOp+8FrDBye9VoRE+LKt745Yj/x57fTaos=;
 b=ahoAYE8kMuF9/h4J3sbIlG/z4kPkjtOnA25hq++RUh/+g7Rki1hBLQCrP/Fq4/fl+yrns24wPaQBxWTqQ2c6aD12jn0zSUFNGuHO8EKRXV7tqNICqMpus93ylEJkDfRaSDk5oyuD39Jpd5niuMNlncZNipKOlRhzWaBwURLuW7FVD15ytUEevu0YgVr1Z6hnr2S0XBigvHAjnc7YReVnhyHSQrpgja2mtC034DfWLWpsFGfgW6KLRahZfwcrool5rfdZMFWht/fqQknp1A3tAg2cvb6VTeJrTahXhNuZUFIH8g6ShRSlHiUyHXu4sDxhw1oTnKVzh0pFtaomnymaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAZ/UrsCbOOp+8FrDBye9VoRE+LKt745Yj/x57fTaos=;
 b=GqhyN48/qfLvjOvx7/Ly59M+SZuftTkbDq6xm/75zMvkhJ9UY2B4VeNmDJeZEvXl+Fw77wsfRWXVL+jlS39fEZFMaqqumxmYxOZMp3unM1v3CavL5BdBHwERAEO1yRICA/zpxpwHJ77FbHFxoJ66u0yPvCTQkkwoR7l6V6DxnhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 07:49:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:49:17 +0000
Message-ID: <4e8e2533-be59-04cd-f979-53beaeb31a41@amd.com>
Date: Tue, 29 Mar 2022 09:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Content-Language: en-US
To: yipechai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220329073843.772795-1-YiPeng.Chai@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220329073843.772795-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0389.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a24a6cd0-3288-400b-d6d2-08da1158a069
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB518177059791B88096FF33E7831E9@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkNSVObpFuNI11pLYJDROrAQhHC2dJnxLowDBXkS0RvDHf7Tejs6IBL0OjJDzNzDhbbzjEGmvTFBp5oSlkMYRArER8FVUwAVGu0Feo5vv4Xr3huF3ovN/dNXX7DJ6LZHB8FdEMOJSt1eyuJPUsIS7HEA0k2PkgfMMZ3yPKa8quFQyPdIoEMs8PhaNDGtLewXigbZMOZLif9b15cXpV/o1yoRKGAh6klUdinO2dyr8T5waK6YymFPHYOwPgH7sz7jGUQKEfkd4+D8U/+pfKbhNQM4rHjFF54KnAx2pvb7B1pw25V9K2grLfPsbjeWrVwNj6RHiLZxUgNC4J4tNj+LT+IVuyErj5zk88AHSnvIjNh2enfzz3OueSyKrsROvZr9NiT0r41WAppDQ/KsVEJChJoz1ySlfRuzl18xHMDW/q8bTwitLBDTiXyIYl9tNDSPwHA1Tam3oXIl2aJbY5uqcpwVkhHOy6ZGH5dnfKOYByL68+bV+W7eVeSrPIu9QwmNsAI9bPo/8XFcDd2449d9A9c+ulMYn+v38gE93J84Gb9FwUHbbo9G+nqO8PZemfREgg9ALpbYE+0qsMxR9jrGxwy8tphsHJo/rMqHswguADQ10l1todcqdpv5EgH058ZI0scNjk3HB0T/zml+x6Dd5d0AXii+Hdsz8lXQ312UUDhfD5SanXBx+tvxeleT1TjCF+lKTH4iJZlgyjTXdoDu8vc6AIAq0MAILy8oawrvV0i4ONVogfpjNsJfUDrbfW49
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(316002)(38100700002)(31696002)(86362001)(6512007)(6666004)(5660300002)(6506007)(8936002)(26005)(36756003)(2616005)(6486002)(186003)(8676002)(4326008)(66946007)(66556008)(66476007)(83380400001)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhCZllQRXA5eWU4Zml1ZU51UUsxVk9BTExCeU9tT1h2eXlnNHA4OGU3UTBC?=
 =?utf-8?B?Z0lIS2ZManVXaFdRUXRkQzJ3RG1WZlVralo5Q1F0QktPZ09BQ2NjUElNNHM5?=
 =?utf-8?B?dXh6cGdLd1J1TVE0UkgzY3VwcUNhNVYxYU1wZ3pQOS9JemF5N3FhbTUwMG5v?=
 =?utf-8?B?ZDB0ZTJYV3M2bktzS21vblUxdVJDWDRDWnNuZUZwSlh4MmoybDBQZm5sN1pU?=
 =?utf-8?B?dnZCVUtQL0lVbEp5R1lpWGxUYXZFaUlGa0tFditJSGd1TEtEYjMxUldQOEZs?=
 =?utf-8?B?ZGhmZ3d6OC9LaURsSDRLVXQxNEcycHBBa0lQKzlqTGpPcnpWMlZyNGxudVdo?=
 =?utf-8?B?TFB0bHpXSCsvVXdWK0FWY1pDSGM2bXp2bmJLWjdjK0FzeDJJZjZxTWxGOFBv?=
 =?utf-8?B?UUR1K0ozNC9VNVhtNUVyckhlMkFtWlE0WGJRK1pibWpxOWR5UWlBMXFuc2ls?=
 =?utf-8?B?SUpuNFBjdmxMNXc1S0pDc1hrOGxFek1MR0dmME9DR0wzamFUZE5oUFF6ck9D?=
 =?utf-8?B?V0FhUjNJVkV5MmhvNnRSRGNCWisyTHZ3RGlDUUw4aG1HTFluM01rb1NXaFFE?=
 =?utf-8?B?N2RGTGtsMW92S1ZnNzhhUkd5QjRlano5MmZHdnZPTklMWEpvTVB2bjhBdE15?=
 =?utf-8?B?ZVhmV1NwWFVVMzc0blVQRlowam9UMmx0YW4rVlcvMTVRQU5lWWZLdkxGbHFk?=
 =?utf-8?B?N3lObnVZdzh0YnJJV1dTc1JzSGpHR0EvTUkyMFgzTUwwZ20yVVUrMzgxOGE3?=
 =?utf-8?B?cjFXT1VST09ZSWxDdHRmdlNnVFlEM3Zla1Bvc0wwUFVIMU94OEdXOVlLT2h4?=
 =?utf-8?B?YWVKOFpCSlFDZ2VnUFRGa2tDZ0txU2RPQWdpTXVLNGpXV3V0Rjh4alVRQ3VT?=
 =?utf-8?B?Vm1LRlROWVcrbWhHZ0xOV1RMcUV5QU8wNVc5cXFmRXlVeGJDcGpsNUkvZnpK?=
 =?utf-8?B?Y2NBWGVuS3NjOUgzNnJqdVJaNHh0Mnlqa0VtOXJvNTFJQ1dMMWdKdTNJNkg0?=
 =?utf-8?B?MTRDbEd6ZWNVMDJLRnhFKy95anJNU1NaOVZ4NHNTNi9LQ1BBckRFSFY5RlQz?=
 =?utf-8?B?VlgxVm43Wm9hZjFjRHVHUld6bEJwRjcvL1U5RGxWaWNmck9zOUhsQ0pSbEhE?=
 =?utf-8?B?aStPYUxSQk5RVjBjclFtMzBDWk12QTlZU1llaEZrSHk1VjFVajNiS01nUDRB?=
 =?utf-8?B?QkZiaWI4eHBWMGpoTkE0QUpFMGwwUDBYb2h2cDFnK25yakZHOTlQRkFWeklQ?=
 =?utf-8?B?Tk1qV1ZjaVUrTE81L0t4aERXZ0RpbFZIL3RNQnNrMjFlWWwycTBTU3JZWEJE?=
 =?utf-8?B?TVc0Sys1T2dDczdrT2dVQndUeitEQ2x5aWRMTU4rbjBKWEZ0MDNrWkd3YWdJ?=
 =?utf-8?B?eWZ2Y1dKUy96cjc5TnVFRnUwUmpNYWdYdXFzSzV2bGhDdmdRQVJSUnlHREMv?=
 =?utf-8?B?eGFyU0l6NDE2Mk9Gd25KcmRmNjZmU2dOUXdtRGJoamo4K2lNZGxXSTVNSXBp?=
 =?utf-8?B?dTg5azBjZXBoeE8zWHB2QUF5QUxGbVRENmZiMTdtelpNSXNacFpxTGtHajFp?=
 =?utf-8?B?TDZ2QnJQODNwU0xvbDlMcHdoOXU0MC9YWnJ0L1MwYUQ2MGM3M2xKaUhiQUZV?=
 =?utf-8?B?Q3REMTZYTVI4aGNsSGpQVzR1MjF4Z0EzR0VEY29Zc2sxcHZkbFlEZHFBVUQy?=
 =?utf-8?B?RlNwL1UzL29WNmRaYi9BL3dybkd1bXI5REUvOHdFc1BmVEE1OFFWcmhlYkQ3?=
 =?utf-8?B?MkxRRFhyRHNpWUV0dkFiaXEzTFJkSDBVRm9ZSWNCRVZwQVRKeldZUVpCS1gy?=
 =?utf-8?B?OUQveElZbjB2dDVMQ3FDY09sd2ZiYWlzM0RBOG9kR0RuVlNsaFJGRStXUVA2?=
 =?utf-8?B?enNFRWtsaVZTQUVlWFJyRUNMdHZ6TkJHRjBBWTFQMFFGOVVGYzJYaGhFelRo?=
 =?utf-8?B?SlUzRWtpWjRlTVlVT2EvQldLSHZzSjhCdTE4RUtPYjJHS2VqR0xlOGNUTUYx?=
 =?utf-8?B?dFVxS3VHSEtVY0FVNjZIeWRnVU5OM1RLNUxzSDNMazA4MUdERFgwV0MrYS9B?=
 =?utf-8?B?d0gzRGUzYnZzY1pjTllwWnNuRmlRM2NYaVY1VEdIWXJmdEhieVhwckxQUXRU?=
 =?utf-8?B?Wjh2RFkrRmxoVThBS1JmeUNFM0V6WllFcDlHcWJ1akh2WnhiVkQ0VGE5dzMr?=
 =?utf-8?B?ekl2bzRiWloxODZMRk5iRVJUemNXU3FZNGxLOWh4SEtyU0VqWUVmbHB3aDBz?=
 =?utf-8?B?U2VxWEFIOGZSUTRLMjg1LzZWODgrbU83YzBGTnQ4dUJMblJaZ29ScjdWdXdO?=
 =?utf-8?B?UEhkWHRocmhTWStySTB3TE8veHdlcFBMQThXSllxVWQvUFV6Qk9jUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24a6cd0-3288-400b-d6d2-08da1158a069
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:49:17.6025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcnLR8rJD1Te7MrTHlKiI+Rt+2LudSxFWuLZIpzx8AK7FKj4COfCEzoqkUvM8JMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.22 um 09:38 schrieb yipechai:
> Some AMDGPU RAS debugfs operations like UE injection
> can cause gpu reset. Before doing the next debugfs
> operation, the application should call poll to check
> if the gpu has finished recovering.

Well NAK. debugfs files are designed to be used from the command-line 
and can be opened and read/written at any time.

If we need to prevent issuing the next operation before the previous one 
has finished we need to use locks for that.

Especially if not doing so results in a hard system lockup.

Regards,
Christian.

>
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 ++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++++
>   2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4bbed76b79c8..337e3e247a45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -452,6 +452,12 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>   
>   		/* data.inject.address is offset instead of absolute gpu address */
>   		ret = amdgpu_ras_error_inject(adev, &data.inject);
> +
> +		if (!ret && (data.head.type == AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE)) {
> +			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +
> +			con->ras_ue_injected = 1;
> +		}
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -464,6 +470,30 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>   	return size;
>   }
>   
> +/**
> + * DOC: Support AMDGPU RAS debugfs poll interface
> + *
> + * Some AMDGPU RAS debugfs operations like UE injection
> + * can cause gpu reset. Before doing the next debugfs
> + * operation, the application should call poll to check
> + * if gpu is in recovering status.
> + */
> +static __poll_t amdgpu_ras_debugfs_ctrl_poll(struct file *f, struct poll_table_struct *wait)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	__poll_t mask = 0;
> +
> +	/* For UE injection, wait for gpu to finish recovery */
> +	if (con->ras_ue_injected)
> +		poll_wait(f, &con->gpu_ready_wait_wq, wait);
> +
> +	if (!atomic_read(&con->in_recovery))
> +		mask = EPOLLIN | EPOLLRDNORM;
> +
> +	return mask;
> +}
> +
>   /**
>    * DOC: AMDGPU RAS debugfs EEPROM table reset interface
>    *
> @@ -503,6 +533,7 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
>   
>   static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
>   	.owner = THIS_MODULE,
> +	.poll = amdgpu_ras_debugfs_ctrl_poll,
>   	.read = NULL,
>   	.write = amdgpu_ras_debugfs_ctrl_write,
>   	.llseek = default_llseek
> @@ -1837,6 +1868,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   	if (amdgpu_device_should_recover_gpu(ras->adev))
>   		amdgpu_device_gpu_recover(ras->adev, NULL);
>   	atomic_set(&ras->in_recovery, 0);
> +
> +	if (ras->ras_ue_injected) {
> +		ras->ras_ue_injected = 0;
> +		wake_up_all(&ras->gpu_ready_wait_wq);
> +	}
>   }
>   
>   /* alloc/realloc bps array */
> @@ -2279,7 +2315,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
>   	atomic_set(&con->ras_ce_count, 0);
>   	atomic_set(&con->ras_ue_count, 0);
> -
> +	init_waitqueue_head(&con->gpu_ready_wait_wq);
>   	con->objs = (struct ras_manager *)(con + 1);
>   
>   	amdgpu_ras_set_context(adev, con);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 606df8869b89..aea6bbb71501 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -379,6 +379,12 @@ struct amdgpu_ras {
>   
>   	/* Indicates smu whether need update bad channel info */
>   	bool update_channel_flag;
> +
> +	/* UE injection flag */
> +	uint32_t  ras_ue_injected;
> +
> +	/* Waiting for gpu ready work queue */
> +	wait_queue_head_t gpu_ready_wait_wq;
>   };
>   
>   struct ras_fs_data {

