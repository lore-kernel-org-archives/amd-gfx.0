Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 18:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A1910E3CE;
	Tue, 25 Jan 2022 18:40:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3063C10E365
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 18:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlpYE5HvKGxPmBgEbNQRjflIUvMfOcXNGyTwptbgUBHELIrDu+T3sBmrTx7sWgc5M4GFHKTruR0+rs/4gE6PoDiSHRLUtqleC4PLPBbJUdhQ4S7YC2w+onFE/FG/mk+216pXdqLY7VGxd1TEZCpqiWZaWmb+5NZH0+6bW3hpmx7BkGZYQbEWt6Hwy3/OtpoVib/sBaRc+TV7zoVL5WCHGafmczb+PBk7WCjWG1zJzh8X6+II8vNoS9v4OV6jDNzP6GlGOQgi0tm8IkMFxdPjBjbFrUOJUJrsvjrnCWpuY5kLZ1rIwkMJgkj4lJsuulfwcoLXGgkyYdDYhh4AjuPo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BdcXUr7lBiu5+jpiZ6fOC2pBOObvSyjLwx91wi6MUw=;
 b=FIljo4P6MuUR6+7OpCgMKLU1nUYvJkDF2mEyBWn06hUFONeLb5LiuvCR/Z4kg7VDgMHC+bmnmtgJ7DkPHGc6uOeitNkkuWPBQEQWaG1uKs+8RGgSNxQgHNnwJaCFbC//fmBAvLFysXRSNTkXJJCtpYfhIdHS4iKypjJQ4AS87I60f3MwhBMY2VfNO2dlRjcFSNCxi0lJ09kkcf+exiNpAWfJfRf6V3qGYjlao7bMgPJ9hIkMYyCx1l0DJ27py/CN4dgpHaRg1YKu5DHZiVqs2QZOCx9PE7YV9hwxbmiPp51k/veFWyHEi02Q9Ywkd/xvt1n7dttpF16Y0A541EcuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BdcXUr7lBiu5+jpiZ6fOC2pBOObvSyjLwx91wi6MUw=;
 b=uk/FSjfuLjffOL2fsw1mVZMH8vxwmceIAOuQwAP33Ede49hiuGE/L26Re15bivvinAyNitQ/vpvu8Th9bwsT5oCGbWUMlsadKIfKtQ+8V9C524PzI+kjPyWIFYldKcE/qNph15JwfvgKvb0L2vz74ipu9gZI/+V73sp1thKODFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 18:40:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 18:40:50 +0000
Message-ID: <ac216196-6774-d500-9c54-ae8a27aaf198@amd.com>
Date: Tue, 25 Jan 2022 13:40:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Don't take process mutex for svm ioctls
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220125180420.3022-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220125180420.3022-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d54878-d6a5-4d74-df64-08d9e0323589
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB414050850253E5C486154454925F9@DM6PR12MB4140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sh61/v4QjrVUzQmISMEBp0nL5oIG8PdZcpbys3X8U/QjdqAUYLgojZIL7c+aqI7ZlBazcjpP/m1cLoQAakycAXi7k7PpeeQLlfCS/XdiD3hwIfhZrZU8zkO9rx+Sh2/AduADYn36l+mEuEQxTIZPvkAq22LDPKuZdK2H2WoFXGBS/nTw/7nVHO2HXHA7ZeMrBhsNE6fAFgIVZmFErjb2MJ9n9A4ESxJu/38fBVGCQDwHiLXHlFTo8ObyA9B7vNm4e33moPNcbMjyunLvjI7flM7qvt8yY2jJBPD1xJ+WgEubmgeGEPnz1EaMUePYCViRSEWOABtmdst3TQBKiglVnMxqwyu6hEKYI1fp1TxvRh3EQT2Di/PCXHYUu3229D26ykgvSE45Cn04cEc9SySbrIojqESviMReBf0zWIdkJzbvIBL8fLjV7ZiKds212ToU44oaiExl8CViE8MdaBoVom2gxNl0GfljNiRcqj46pbn5MBJVnMMpiHg/obOPfJXgxcsKg9eXT0JdZKBOqfXds0mWkuSbvqXzJT1sIykv7Ua1Q7bUQWOW06syd19Zy4Ss6x9aSnRMP7/G87I2iBn/BBlj0dHcJzehc1PmK0a/FuiZ2ghXDRIrkvnYxI/m4xMLrDYABdEfrmCdNf5U3gl8SwVdawxgHR+COoihsUQgBejJnJJJu5ZVdy6h3gbRitC9iPb3CMVleGDOqjJOXodkWlLjUsdQhcEIKrWASxeswXrGHofzkMCcWSMFvMSkVoh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(66556008)(66946007)(8936002)(44832011)(6506007)(83380400001)(38100700002)(66476007)(6512007)(6666004)(36756003)(508600001)(8676002)(26005)(31686004)(31696002)(86362001)(5660300002)(2906002)(186003)(6486002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnp3a0NWRGF5alE1WFhiOFhvblN3a3FRSTNzOVFaRmlWNno3cGJGcXdmUnYz?=
 =?utf-8?B?bFlDemhVbmpicWxRVkM1NjN6T0xZelpOUlFGTVo1VFFMWGV6UlFYa1NwbmNQ?=
 =?utf-8?B?aWMwMWpiN05FR2lwa0RhRitGbzhMSmhGNzAzNVlGMTI5ZnFEYU8rcnBjSDFR?=
 =?utf-8?B?R3BGT3R6Z2xhNUhpbzNocTh0UUo4OVVaVGJVUUZ0MnJnWjg0UlUrTlo3NThF?=
 =?utf-8?B?QVRtdEc3NGpPWENndllJQnIyb0o5M0lVMHVXSEhicVdmUnNQQ0pHQTlvbXc1?=
 =?utf-8?B?Q2pIeTFsQk1Qa0dLL25Jdkxod1RMK1NDcDZWL1NRa0YyTWxieDkrYWJsKy9P?=
 =?utf-8?B?L2pKaVAyS0U1K0JJNUgzLzdWaWhQYTNXQStlK0JzNkkrYUVZWTZhUlR2TWFl?=
 =?utf-8?B?ZFJIR3U5TS9MczF4SUJ1VmlBbDhwMUdBQmVNWElFZnloUWtzTkorL1VnRVBW?=
 =?utf-8?B?NlpXTkVwYUtEUkpBd3U2UVBpekhrNlFpU2FwMU9YL0wrNU45UDA1NlJ0b3FD?=
 =?utf-8?B?enJtSEJCbXVlelVSMnhPQld5V3FuNGRrRlp1dzc1MURLb3lLSW5sRERNVitv?=
 =?utf-8?B?YUl1NlFyajV0WkNYMjdJKzkza2NJd1RMRzI2MU93YXJqU2RGTFZ2cEUzajE2?=
 =?utf-8?B?dDU2RzNxZFZNSEl3cnlRQThZcUI3SUo3QS9HbWJZTVlOZ3dtMjNYaExCbDdl?=
 =?utf-8?B?ekplV2RrNVgxOHhoaCtzekUzUkZBQ2tyMnF0elFtWThYNjRQSWVtMkdRZEU2?=
 =?utf-8?B?TVRPYTI1clRzVFhqZ2xrd1NhNDNKTmZNUDQ3ZEN3OW5wSFMrR25YOS9sbUZL?=
 =?utf-8?B?bE1ucjNQckhEQzJPZVNYR2QwR1poZnluRHFLTFo1Tm0yWk41cWRmM2lLNEV0?=
 =?utf-8?B?LzFEb1RXUW1nNkd4aG9sSGhDbnUxWUttMjhIM3liMSsyOHY5dFZaaEdRK1Jp?=
 =?utf-8?B?Q29TRktHOVRFMGF5RURLdDlHL2pQWFJjMXpxYjhZN0dlVUIxRlp2VjlGbksy?=
 =?utf-8?B?cDA4TG8reURrbzBQdW0yeUE1Z2VvMzhBdWRNMXhadG41Z1lCcTdMVzY4U0tF?=
 =?utf-8?B?YXhHZVBoRmI4c1NTOWNQTGdxb3AyS1luRjBCaExlNnlNVFk1bUVxUCt2RWFV?=
 =?utf-8?B?YkhDWHNkNFdiZ0NqZ3p3czVwTm92L3NYWHdFSHhiWVhTU3hLV3JqczBHd1Ba?=
 =?utf-8?B?ZytoYUdnSkVZb0wvWllDU3R3djBRRXZYNGVQNm5jZTRiZW91M0Zjbk5ySCt4?=
 =?utf-8?B?Wk9ySmRvdmtLOHUvUHVwUjdVcG1ORTlKUW9pR256a0JWTEp5Q1Joc2o2cHc4?=
 =?utf-8?B?TnNBVm1RbWg1KzJsMXZnb1NIUE0vSTV3Tlpra2I1UzBJZ2NsYXZBSnhOTzJY?=
 =?utf-8?B?TXl4RDhWbTArZ1NTdUgrZWFWZXJua042aFhndy85aGpiWXJRYWJUM0hDRW9C?=
 =?utf-8?B?ejJwZXNQRldKTmFZWDhvRE9pcm1ER1pSSkZoRWphQ1ROK3dFSnJsKzdneU0w?=
 =?utf-8?B?clRnbUZ6MUFzOXhRTXlEL0gxYWI3M01EL3UwSVlpeTNvS0tVYnNrQUJYYTRj?=
 =?utf-8?B?T0NMQVloK0UzQjlKR1RYZzZ0a3h4aXA4TlJ0YzVucEY4QjdDMUtSb01nYi82?=
 =?utf-8?B?SEZLbUFiNUM5U3FSYzNheGpoLzFpUmFpVDlweEhJNGxTVm5XbFNacDJINlA5?=
 =?utf-8?B?Z2NKY2dmQVhPNlFCRG5MbkVQWHlpdVp6ZXppOUZhK0dWMFg4Ynp2MGNlYTAx?=
 =?utf-8?B?U09UdzJYNEZBS09uOVJGWWNMeHJzdzgvRHFLaEUzQTFORWZaY1VhZFJFMVF3?=
 =?utf-8?B?Qm1raWdmT1RuL09CZDZaT2NENHljbklNcEtaRXZranJpajc0eWZ2QkZReE9W?=
 =?utf-8?B?VVVIWXN4cGZkVzJzUzIzUjZrbHh5SGhmbkk5aG9Xc3BYZC91LzZkWlRWNksz?=
 =?utf-8?B?ZlFsMCtHR25Fc2FNT1BORlN3VFF0T2oxUXFuZ2pHOWxHVERpNXh5UXNVZ2dD?=
 =?utf-8?B?MFRDQTN6a2hpSUpLK2s2U3BXZDFPaHpuV2V2eHNKM050OEQ1MkUxSDBiQ241?=
 =?utf-8?B?akdmMGtUdGpyRENGeXh6d2dJSnN6MktzV1RTcHd1RmdJSnNvYW8xYXpRdzZz?=
 =?utf-8?B?OWc4b0ZHS1U3aE5IZ3E0dXZEelNjeEhQb0gyTW82bEtydFlkdGFDb0IrcTcr?=
 =?utf-8?Q?PMu0+bEovSA3RcafgUlXD/o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d54878-d6a5-4d74-df64-08d9e0323589
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 18:40:50.2725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5ymSxRTzI/LtsECfOu8DeyOEZ7rkNKNBvVj8wGjPYvLMkdujeWJ6WeqTJ1UwCSW3owF2NyIcNdRznyqIFOZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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


Am 2022-01-25 um 13:04 schrieb Philip Yang:
> SVM ioctls take proper svms->lock to handle race conditions, don't need
> take process mutex to serialize ioctls. This also fixes circular locking
> warning:
>
> WARNING: possible circular locking dependency detected
>
>    Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     lock((work_completion)(&svms->deferred_list_work));
>                                  lock(&process->mutex);
>                       lock((work_completion)(&svms->deferred_list_work));
>     lock(&process->mutex);
>
>     *** DEADLOCK ***
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 337953af7c2f..70122978bdd0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1846,13 +1846,9 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   	if (!args->start_addr || !args->size)
>   		return -EINVAL;
>   
> -	mutex_lock(&p->mutex);
> -
>   	r = svm_ioctl(p, args->op, args->start_addr, args->size, args->nattr,
>   		      args->attrs);
>   
> -	mutex_unlock(&p->mutex);
> -
>   	return r;
>   }
>   #else
