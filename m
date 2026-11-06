Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E4606D807
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CWZP1HjC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E62410E384;
	Fri,  6 Nov 2026 11:38:55 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6381810E384
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 11:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmmiblHaYM6fNFw3kcIVd4c7aU3aUkENw0+rYgkRKjECAJr7+zHndH05eNkdPfftXZPJsz++tziBSWeYJuiP01qXwuU0sqy+MdAdSf1ZVw7FkQ/e91CMiRSMMxdjO5eB8B7STBd2OWH4RO4F2wllmyXAXEFZLlUY2zY9KzXuIBv06M3fruO/0zDLGudm0U+lUoCpJImWu8rwfC0NqmhyBM1ou0ODDqKRCDhRx85D7cxHd4Q+GLx9ZW086FMLi0qZTrJYeHZlx2G51pv55uaGtYbSDhWn5pLvFvFv8RLGGZgzlckjHOB7iHMd1kq999+W0rQ0495i8CdPVzHDvq2ecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usOkuAyuTVFPIiaF0c8+NSiuIv7Pb/KJ8saUQ6vA5QY=;
 b=dE0fH2W4U3/nOsum2C0GnOBZ1PuXP9Jj52765IONqaNvs5MjxzwCI6gW71y3HuRV5UCw7bSUs92b5/VYElNeWbDGJDjgQAW/SZWg5RlXMMODcLDMqzyzo5wOVGT9uAQXtu66RAk/ZzsmETBf1i9C/0fv7d1xPIbdwGe8nJ98GFwRUGVLW3IQx89mgPI2h3iRpUvbTrdQDgkJcQaN+3JvFrKNr9cvzssCd8s06uyD1ZpmherdAyAV05XiG4nL08tE4ZAUetfyQKbqmpmHoBCg13PbwdDrV3zwVfVML4E6dTzxjbxat5O1dqCkVwopZJS9aZo7E6MdDk8R7YGdn76H2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usOkuAyuTVFPIiaF0c8+NSiuIv7Pb/KJ8saUQ6vA5QY=;
 b=CWZP1HjClMdv9A3zyyGg9WnpFU3gsBEN3dkr1FcpkG3P+n132dsQN4jQYrxMPkWTBst/ufmvt3KQoOfWkJvwt+vHT8KN3K2iWNGW5hzVreIUOrimxnCDAnRRHzdbRJ/HwImBrbf6abkPY/luVFfW+dwF5P6/hG81XNsxS5M6ON8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:38:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:38:45 +0000
Message-ID: <8319b7a3-75d6-4dd5-ac56-1825c83ae2df@amd.com>
Date: Fri, 6 Nov 2026 17:08:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/amdgpu: add support for FB carveout disablement
To: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Nikola.Prica@amd.com
References: <20261106112950.1281549-1-Dejan.Andjelkovic@amd.com>
 <20261106112950.1281549-2-Dejan.Andjelkovic@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261106112950.1281549-2-Dejan.Andjelkovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dad9fb3-d0af-4caa-043d-08df3bfa842b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: QG1db2FBxREpdd6SlKEtgm0Yaz/eG02HMFwS0dloEhO+8PxAid5/bnx8yfcQFqDZMKVKrvKCgbz9+uBd9uKO+mqKHsIhYqpfuCuDNK2fnd+AmKl4AOjmETrV1oTCe6W+XrPV1kKP4FdqiRGXEZlotVtILj736PW0smX6wKOurUVOBB+SCmXOiMhDqb8MkFUwpsqfH4I2pE1c34/e3dInnRePsuwQnHPDZ/fk8h9SIXubwJP5kt7HpCMvubds4jooXv5aOZlLvJ9T9DokbDp2tBywmweefNJ2RpzqCTaRvKpdff4emkBl3M2MEKzFazY7ry98+CEWFcvAf/aAFer6kXVQHT+nyIILbSAkcwOUEl0mCGJaoI6b++iOwa5vIwtRlu/w9m/73vhb4BgyYrIm9RYgPbl0J2eCmtp4NrwJNmAxU6u5EbMIUW/mnLQcd5CF/N8KASLNtD1zTzKCTnA5ZvZG3uYMPFnky9J4at02GY0eRNS/lje0qKDSu4Ko/j9BcVa6EJ7vP/vyXjh3KvJIYwF7K6VaFXGSPwt+6plxEtJt0PM1Z5nW848py17MGFZcIHZi9EWe/QpyrdhVIRdREhEskdSB/GiU3qBE2u9TIc1QJastRRr52OW/jRCYMt1Pr9e20Cr04jfwHFUBD1vNDea7+tMeb85KOFw9HXJfiP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhhZ1JrTWJMQ2xpeVZjT1ZhM1IyaDl6YVhNZkZXbWVxZGF2MDFvSGI4c0lC?=
 =?utf-8?B?QUlLOUVjZ1lCMEx6Y1d6NWxhVG1qSzlsMTV6bkNzeG1qSHZEcGc1V2Mxb2lX?=
 =?utf-8?B?SmJSb0EwN244OU9JVUJacFJLK1RxakpLQ0xqcG1NKy9qRTVuRjczWHFldWVP?=
 =?utf-8?B?VFhwOFJoUkN2WmtaTlNNZHF2ODhoVHhKQlNRWkVQTUxRWkZlNEI1NUh5Y3Uy?=
 =?utf-8?B?Z1FKd0VBWEN0SVl4SzZORFBXL09HMSt0T3hwOEpTOXZTTW81NUlZMEJnMVZu?=
 =?utf-8?B?YkxXZ3BHSWFFTFBwUk1odVMzaTBKeUgzeW5QTk5YR1lBUEZFbHdUR1AyL0V4?=
 =?utf-8?B?Z1NaSllwcVNzamg3ZjZzOURaRDNicUU1L0FSU2JOWHdTUWpJamZCWjU5eHJE?=
 =?utf-8?B?UzQzc3QyWE5MZ2l5cDBMMEQ2ZGdiUGNGR0Qzd3g1cUsvc1VudjdDY1lneHZO?=
 =?utf-8?B?bUo0T21BdFMrSDkvQWdsb3JHUEZvNEJNSDVSVmp2K2hiejlZcWhhNFh3VjN0?=
 =?utf-8?B?WGdTMExsSm5JMCtyVmExNGNZQ2crV0YvcTk1dVA5UG9KUXZCTmgvWnZvQ1hm?=
 =?utf-8?B?Z0hJQzc1Ny85bVdLc0h5ODRlRkNQL2REaGpPV3gxL1Jta1M5T3VSaWFvOVc5?=
 =?utf-8?B?UGY1MFBNb1R4SFBwY1JMMnNBdVd2MjkvODBuZUM5OElJZHpUUE9nOGp4RHJ4?=
 =?utf-8?B?c0s2Q3VyMk40b01hUVJzZEt4b3E0ZWhDK0lJSlROQ1pDdXhOQ1RJa0ttK3BR?=
 =?utf-8?B?NDNQRVpXUFpsT2FPdVZ4U0d1MVdYMVFwYjQ3L3paTWwrSU5WOXFWT1Fmc3ll?=
 =?utf-8?B?Undyb3c3YWd1bXdab1F2SzVrT0I2VGJHMk1rby9YdmRMeU5TdHNha3VoTnlC?=
 =?utf-8?B?QkpuL2dvQ3pFOVlRd050Yy9VcUJqZWszL1cyQi83bVZPUEx4bmU2WnhmWWh5?=
 =?utf-8?B?WmNzRk5nU01XR2pxY1ZwSFZIRHE5cXJ6TjJkSlFZZkxDSEdrSjV0UER1Rm1T?=
 =?utf-8?B?TlVrZEsrTXRkeXZ2VmJLakw4eEtkK2xGTWlndjZibmMvWnZubTlYZEFwR1I1?=
 =?utf-8?B?VTdsaDZPajRXRXg2dU4reXJlVWlFWVAxanNBYmdsd05jdGpqc3EzM0RWUG9l?=
 =?utf-8?B?SFJIUWNnUG9vNWRxOEZ6ZWxOdXpMTEpBb3RndU1ZbFhkREViNVYrODByeGY4?=
 =?utf-8?B?THdWOEZDME5naGtaemxSM2JVdHBDVnN1NHgyd3MvSFJyTGpCVE9nSC9QOEgw?=
 =?utf-8?B?VGJTb3hITS9vK0k4bXJzT25uMUFhbUZNWHRGd1lTeVdMWkkwajVXVGI0V1Zy?=
 =?utf-8?B?c0RPbWEvWUtKaC9qY3JJTENWVUZWTnlWNFNxNlkxZEFRSVhkLy9kUWhwaTF4?=
 =?utf-8?B?K08rL09Nc2lKNnlIK0ZtbGtTU0JMOEdWeWN2bGtQdUVFYzZqU01NMEgzcXVG?=
 =?utf-8?B?aEdMYVVpbm9QeXkxTWRzaExwYWV3VXAvZ21oekllNnNVWmRScmdSRTFhQ2FR?=
 =?utf-8?B?Sk40LzRPVWpZMXluZVpPRGM3eVpiNFpXUFFhOHFzMmZhcGk5UFNpSlRyMEpK?=
 =?utf-8?B?dWdXODV5aGdFNHZPR2xrYWdqQStvM1MvRklQUXFzTndlRm1HeW5hU1krdUVx?=
 =?utf-8?B?YzczSFlVb2NUdnNhYjhUSmd5VFFDZmFTL1VhMHhCS2k5ZmdyNUVRd084K3BN?=
 =?utf-8?B?R1E4aU1WWG51eWNMK0NCd29MR2pjK3dMbk1Vd3lmRkJSeGZYM3VwVTVsa0k3?=
 =?utf-8?B?ZVNSYzdQVUxqa0hzQXZZNlN5SUhhRmJRZG9vWS9PQUZ4V0x2M0VnWEhlSno5?=
 =?utf-8?B?YnFFSVp1L2EzT1NpRUp6aHliZGViSzFybWJrMHVoRE5DT0xJWjZGU0h2aE11?=
 =?utf-8?B?ZENoN2EweWFwdHdFSEFKdHVMSllZTDluUlhtMHVZT281YUJ1MENxZVpUN1pO?=
 =?utf-8?B?cmdrSjJDQ0lKTVNaZHkweHYxVHJPN0JMM0hvamgvY0I4d2pBTVhPbkwyeDF4?=
 =?utf-8?B?blRqdWZJdDh1YnRwdGdleVRrVjBKUm9JaGh4WDd1azBGcHJEYVMxdFlQdEsz?=
 =?utf-8?B?TkhCK01ZaWRLbHNLYnkzbEs3SHVXOVo2ZjNZZk1GNS9BT3ZRU0o1d2QveFh6?=
 =?utf-8?B?My9vRGxKMHBIUmxKWHNPL3VnSWg2dGZkejlxMzQ4U3NoeXhuV1pRU2xQU280?=
 =?utf-8?B?OERzS2NBZW5xSTgzamhlVXU2aEFlWHN0VDRnV2h1ZnlmTHR4RnFQaCtwYWJP?=
 =?utf-8?B?MUFSZVFjK21iWmh5M25KR2grTVZGNXhEUkVqdnpVMVQwdnJ6cFg1d3lGNEJP?=
 =?utf-8?Q?dpTuMVJbA6NveuyQ4z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dad9fb3-d0af-4caa-043d-08df3bfa842b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:38:45.7688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGCcI/Oxpf15x0JhmV+3JVuS4UGXTM4eIEIdiuj5/i6MscAsIHzAwlxirr8Q2Bug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 06-Nov-26 4:59 PM, Dejan Andjelkovic wrote:
> On passthrough A+A the PSP keeps a framebuffer carveout the guest
> cannot use. After IP discovery, ask the PSP to release it through the
> GFX mailbox.
> 
> Define the enable command so the interface matches the ASP header.
> The PSP locks this mailbox after the disable, so amdgpu never sends
> the enable.
> 
> Grow the GFX command id field from 4 bits to 6 so these commands fit.
> 
> Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>

Series is

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v5 -> v6:
> - Drop the post-wait status read in amdgpu_psp_disable_fb_carveout().
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 16 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    | 10 ++++++----
>   4 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9326f811c500..7ff97861f8bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2058,6 +2058,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> +	if (amdgpu_is_spm_passthrough(adev)) {
> +		r = amdgpu_psp_disable_fb_carveout(adev);
> +		if (r)
> +			return r;
> +	}
> +
>   	/* Check for IP version 9.4.3 with A0 hardware */
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>   	    !amdgpu_device_get_rev_id(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 50861175d661..bbf4264dd3c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3396,6 +3396,22 @@ int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
>   	return ret;
>   }
>   
> +int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev)
> +{
> +	int ret;
> +
> +	WREG32(mmMP0_SMN_C2PMSG_64_MMIO, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
> +
> +	ret = __psp_wait_for(adev, mmMP0_SMN_C2PMSG_64_MMIO,
> +			     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> +			     PSP_WAITREG_NOVERBOSE);
> +	if (ret) {
> +		dev_err(adev->dev, "disable_fb_carveout: PSP cmd failed\n");
> +	}
> +
> +	return ret;
> +}
> +
>   int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
>   {
>   	struct psp_context *psp = &adev->psp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index fe3d053d9924..e747eb47c47b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -690,6 +690,7 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
>   
>   int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
>   			      GFX_CTRL_ADDR_TYPE addr_type);
> +int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev);
>   int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
>   bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> index d13ae1756887..f42dd8ab5350 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> @@ -27,15 +27,15 @@
>   #define PSP_GFX_CMD_BUF_VERSION     0x00000001
>   
>   #define GFX_CMD_STATUS_MASK         0x0000FFFF
> -#define GFX_CMD_ID_MASK             0x000F0000
> -#define GFX_CMD_RESERVED_MASK       0x7FF00000
> +#define GFX_CMD_ID_MASK             0x003F0000
> +#define GFX_CMD_RESERVED_MASK       0x7FC00000
>   #define GFX_CMD_RESPONSE_MASK       0x80000000
>   
>   /* USBC PD FW version retrieval command */
>   #define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
>   
>   /* TEE Gfx Command IDs for the register interface.
> -*  Command ID must be between 0x00010000 and 0x000F0000.
> +*  Command ID must be between 0x00010000 and 0x003F0000.
>   */
>   enum psp_gfx_crtl_cmd_id
>   {
> @@ -50,8 +50,10 @@ enum psp_gfx_crtl_cmd_id
>       GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
>       GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
>       GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000, /* Copy IP_DISCOVERY_DATA to host-specified address */
> +    GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT = 0x00100000, /* Message runtime VBL to disable FB carveout */
> +    GFX_CTRL_CMD_ID_ENABLE_FB_CARVEOUT  = 0x00110000, /* Message runtime VBL to enable FB carveout */
>   
> -    GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
> +    GFX_CTRL_CMD_ID_MAX             = 0x003F0000,   /* max command ID */
>   };
>   
>   typedef enum

