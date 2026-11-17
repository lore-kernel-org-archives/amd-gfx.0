Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9381606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NjD7iC7d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C9410E3D3;
	Tue, 17 Nov 2026 05:22:56 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80DA10E3D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 05:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjTOBhqgcqwe+1s9KWU8COlukbiO9AkJoaMjjnwN+DlD57j7Uc4NCtGm3fkdxFAvUFJyS4iaNzqErOM2koQx9+6oI8CWIFVDwHFn4Zdfa6SYJc7tPEl2kKaSKWlAIXdkvLJO53342NC0zjSvoZG3Ob+2p7DdmxuRSo63SCzkqq03zVeUirLqom83oF6Q1kQL2v/auFcxZnt5JcD+xfBA1ihyKUxZujJZx1KodT4B/v5CwjHrQp1WBj/apEAm7KvyaFvLnqhdOwuh9K51KW6JtvexQS7xozZE/rNKvKz30SrtFi6B8zeLlFnYV68SI5nEicV+M8h8qsgWtarkK0wTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtEgsv4/I/AO22CZR4b2z3X8F2O4HBvNhoC9Efe3Rhs=;
 b=Ng5foaNIEc/q5x7U9nGDL/05HmZ/pvKSOzz9CMZLHAG7th1hSKKfJZHLIO7ItZFDJtvlxK2Eh065goqdR5KYiejdpGm06sZ1wnMkign5eRv4aMLXXxEMaVqoe4X6ZOEyG49Rpw66cGb4pR7zUqcsnk7vI6AEgO9ynafdGxLMBnQUAjLgjL/l+Pa972PLY8nLAF0eUCGqhwKFUp8IUQl/xGWPu4IzJ1ULm9Mp0orq3xhAo8V9HbXo4suUMhsAGacB7apax2d3ypLtJqEUrSrAF/E/zl9t9FwrWQduftiuxre39Rf9BeRYq0sU/rZxR+vdCjz/u+32LtNDMW2AZ4J1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtEgsv4/I/AO22CZR4b2z3X8F2O4HBvNhoC9Efe3Rhs=;
 b=NjD7iC7dCMkrQBUVIhH4sbziENygJ4hubK1PG/B2mmt7ZWaWcYeWONf5bavyor6zT79kRdqF/4qct9vFwWTNapGjCbm2dAaA8ITEciIpgWoxFnN21DE0xGvm2tM0xqsyfYF2jAn6BnpE8hfBRwsmHsi7dZGOVLValK797WYfPYM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 05:22:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:22:46 +0000
Message-ID: <2984c377-2371-4429-ab94-12a30a650891@amd.com>
Date: Tue, 17 Nov 2026 10:52:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amd: Select the firmware signing scheme the PSP
 reports
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20261114160925.390350-1-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261114160925.390350-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: d56a36c1-0855-4faf-b921-08df446ad006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|261009223027099003|11063799006|5023799004|56012099006|10067099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: Bq0HoXHeJad3QhUW7sH7tMl21WsgCxkGZE7X/mKQXdo5KYqaBuaUQegdDp1eTkOHCvha/wy7R9HhapGSPBd7EWy81UMcvEgs2N7PLPfgFKYRq1rTtJIcVfasNsXf/vaqjDdEf2znWVmV2Srj3NydTohvH7vE/Wtg3TnzgoFBM977UjrFsHwpbI071MoF3DX0SGv07DzCgq93IgLy6NMvzYmtnBZAr4O4SbbR0i74l/lpYqYV0JNTHf0w4ZrHPWtKWbc9XBajNrr0c1JAZQ5ENiv04Tzpv+fiZw2MhDqNpPChc1UV1AIw6u4CfjLU3oOaFDeJcPNds0rW54EIkkW/WYclZ8qz6LbtKAlSpV1+Yggtf20flxkblYRSkNl8FOdIZgqPA+aZiNK+NHECFMh5FtMWosisTdfj8/QIGlpmWC3euuELfxNScuYAkpFRttzXFVYLH/+dKaU4AFrDme0frAb7urrRktZ0xNTn04uawlkemZ6EdokT7bZdvMpptkpLlg0wh2EZxAtDqiTqCbUs0iS9alUF8e8b8n4/5zHt8xJtFxwxTnKlB/IVuv4vVbTPswedI3AWpZR57MRwFr3JK5dryvW2aNWuCzizTaUBDhF+UotZ4+/2VxLaN4DgMSy9yTmg93Xll06s6ChaWfqq1p24b9OcvwDKS02cFmrNtaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(5023799004)(56012099006)(10067099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b21PaG9xNmMrdGg5MlhQNWNaY3paUklzTFNqckljdjVOZmN5SHlmOGFvV09t?=
 =?utf-8?B?RTgxTkhGTzg5ZW9DSDF5eTFzUUpxRk41NTFvUXZpWEpiQVFWM1ZsVjMyWUdI?=
 =?utf-8?B?OTluR2xvZXdHSHB1SzlGU2o5TE85UkhXNCtwWmJUeTNOU015Q3VaS1RhU09R?=
 =?utf-8?B?YmNGeU15c3dBQWhYMFk5eVI0N0JUdHFmTmIzZDUrdXhYWlVVK3VXMHRvM1do?=
 =?utf-8?B?MXRGWEY0Z01nc0NrbmJoeXdvcDRnSWovSXVXd2pPWDJORGtxZXdPNGZVOVA5?=
 =?utf-8?B?R2hEQytHVk1pc3hqMUNGTkNtbzk4eFRnRkNQdFlDeFQvVktCZlVrdGxOaUpR?=
 =?utf-8?B?VVdkVWlaWVY2L3N2MHhlWUhyT1hQeE1Ka0V1bFJuanBmcE1JMytsU3VLZUk3?=
 =?utf-8?B?eHpxWmN5Z0JlL3RtVHExcmc1ZFArK01nVHRNNnRWNmY4QVRlTzBqWE83Kzd3?=
 =?utf-8?B?cU9laU9WSnpQQnFMSnhqd0ZWaGFQMDYxUVoyZGJOUllzS3hNOVl1SGJqTVZ2?=
 =?utf-8?B?eDhsMlcrclB0ZDNoNERZTW5aNjdvbzgyMnFNWGxzNjkrRWlCZHUwNHZLeUxY?=
 =?utf-8?B?Uzd5OVhRN0haTlBTOWpHWFZBMDZHcnhjeGIyR1MzQVdIVmhHYXV2YnVKeWtz?=
 =?utf-8?B?NXZTYjU3cjBIbHZiUDBKWkNJWW9HMkNHODRuR0tRaFk4U1FKU1FneDNuM3lY?=
 =?utf-8?B?blNxYXRsajNNLy9LQ2orY2JITE9hSUl5b2I0L1JDQmNjempnNE9rWmw2dnYv?=
 =?utf-8?B?Z1Y1aXFqSTl0SnpxYkNIeFk5cFh2TzhJMnFlWUh2eU1WTjdrZ3lNMTI0T0lL?=
 =?utf-8?B?VTluWk01VlgreDB3MWdCQ01RTU9PdjJRUUhWdW0wdDU4b2VlS01FakE2Q096?=
 =?utf-8?B?SnZnbFU0bmwxeGllK3FTc2VBR1RRM2NORUg2NUJ5RjcvdnBoQUhjMEZXdm9T?=
 =?utf-8?B?Q2VFeHJpWS9nRG43UWlXMkZ5eTd1Y3RFZ1JzK0RHbEpZL2UreXhyMlp4UGpL?=
 =?utf-8?B?RWVubExCeFdMNXJSWm5MYkUybEVMUnJ2RjlqOFRrNHlqcWhlcWd3YWZmcXNh?=
 =?utf-8?B?eTZlMzBaNkdZU1NyY2hkTDM4Y01pT2dudS9ndVpPYUVkODhIS0tjbkJjS25X?=
 =?utf-8?B?a3pGTDFHSEFrUXBmaVBIQ2FzUnBkQlZlNzRCa1R1T0FJRHZUeXVkSkhYandC?=
 =?utf-8?B?a0NIbzg1dkJrKzd1K1k3RlpWNjBzdG0yRnlxOTRhajhXRVYzTHJRQXVldjJp?=
 =?utf-8?B?cG5nNXdHYXJ5QUgxQythd25ocERrcUVPOTRVNDlVUzlMZWl0MFU4bkVsemYy?=
 =?utf-8?B?WmhHQis2SEljdk9GMDE1ZXUwTVd5dCtwUGpTWEg2MnRrWDJkWHZJMDdtb3RW?=
 =?utf-8?B?VEJuL3F6WWRoaFhVSWJaVUVlVjZRWXdMVUYzdFdmZGRXNGxIalY1WXNkRTJF?=
 =?utf-8?B?Z2Q3K0Q5WU1oOG9mVi9XWnpFRkdQVXErWWRLTWx1YytFVmxmU3IxU3VkQ1pS?=
 =?utf-8?B?UjZ6UzZqcERyY3paaW0yU01QRVo3cmtZeTQrVW9FWGM3MWtTY1MxcmE2SHJX?=
 =?utf-8?B?NTBEcVpTVW5nMVkwMmhSc1BQdzFyWEtNZUZVT3VyMlNsY0V2QlZPemNibks2?=
 =?utf-8?B?dmM4dXlMNGRIQ0FVa1pqcjd1Q1c2MTQveUFTakpmckMrWUtxeCtoNlpzbldB?=
 =?utf-8?B?WkRqUi9leDhyVEM4TlhZbThadXFoRUltWUtGMG1kQ0dWUWVTamFUSXB1NDFN?=
 =?utf-8?B?Y2s1aTFDMHgzdXlJNWhnNk9iQlFxSE9TNU0zcGJ0d1QxMFRISzhoSFEzOUtS?=
 =?utf-8?B?R0hRKzQzYk5zS1p6aDVpWVNvT0RWSFRxUHdJYUErNFcxNGNnNlI1bDM3eHlB?=
 =?utf-8?B?TXNqTkRKZ3Z1dGZ2eExJamNUNHhLM1VicHBDelRTdEJ6K1hkeDRGWW5kSWl4?=
 =?utf-8?B?SUl3ZHhjZUlZaWpFbzVvbHcweDFUZEFUdHcyOEJGQWNaMXpLUUtFN3pwbk9Q?=
 =?utf-8?B?UExHZXg2VStDL2tqUVVOWGNUbjljZzlEaUJjL3hoR3VBK0J5UlVUZGIvbWVt?=
 =?utf-8?B?QVlheDM0MXNKUERkb3p2eW1vRU5yWHVPd1FVVVM5cy92WEc3R21OZ3VZdThO?=
 =?utf-8?B?U1ArRnQrWUxFblQ0Tks3R2QzZEVFUk1lbjlENmFZT2VzZUdnbE9pYzI2aFBa?=
 =?utf-8?B?WDh5UTNwYmR4QUZoaHhEQWpzRzFkS2dFT2hJOWVjWTdVdlZEQkRGVE9EZ1Zj?=
 =?utf-8?B?Wkd1ZUxlTzR6b0ZTejFMaDEvWnRVcmRqZWtXek8rZ2NrUkVKQmdla0F2cFJO?=
 =?utf-8?Q?V1dAmLv9MWNrcK2NZM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a36c1-0855-4faf-b921-08df446ad006
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 05:22:45.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUhCQJjZ7ayWtBZtlh6M00whtwSXuopWkPMlIm8yYt2InwjoJ7f3mhTO1N20BnPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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



On 14-Nov-26 9:39 PM, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Some platforms ship BIOS with either a default or an alternative trust
> authority, so firmware for every IP must be signed with the matching
> scheme.
> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit
> 28 whether this is a preproduction part, which needs firmware of its own.
> 
> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
> own MMIO, and keep the result in adev->firmware.sign_type next to
> load_type, where preproduction is a type of its own. It is initialized
> once, after IP discovery has populated the register bases and only when
> firmware is loaded through the front door (the PSP). Only MP0 15.0.0
> reports it. For all other ASICs, SR-IOV VFs and an inaccessible register
> (all ones) the defaults are kept: AMDGPU_FW_SIGN_DEFAULT. A preproduction
> part that also reports the alternative scheme is not expected, so warn
> about it and use the default firmware.
> 
> Firmware for preproduction parts is named with a "_p" suffix before the
> extension and firmware for the alternative scheme with an "_l" suffix
> (e.g. "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on
> the default scheme use the plain names. Do the substitution centrally in
> amdgpu_ucode_request() so it covers every IP that loads firmware through
> it (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each
> loader having to care. There is no fallback to the default file: it would
> be rejected anyway. Declare the variants with MODULE_FIRMWARE() so that
> initramfs generators include them.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v6:
>   * Return errors on unknown firmware combination (Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 35 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  9 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 +++++++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  8 ++++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 47 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>   drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>   15 files changed, 157 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 19a566187dfb5..b24ccdd958a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2101,6 +2101,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
>   	}
>   
> +	/* Needs the register bases, and must be known before requesting firmware */
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
> +		amdgpu_psp_init_fw_variant(adev);
> +
>   	total = true;
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		ip_block = &adev->ip_blocks[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e1..6d693b5249ddd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -403,6 +403,26 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
>   	return pos;
>   }
>   
> +/*
> + * Which firmware the platform needs, as reported by the PSP in C2PMSG_63: the
> + * signing scheme and whether this is a preproduction part. The defaults are kept if
> + * the ASIC doesn't report it or it can't be read.
> + */
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
> +	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
> +		psp_v15_0_0_get_fw_variant(adev);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   /*
>    * Helper funciton to query psp runtime database entry
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index a4ec60f6c3170..7d8fc8eb2b125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>   
>   int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
>   bool psp_is_xgmi_ta_supported(struct psp_context *psp);
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>   int psp_xgmi_terminate(struct psp_context *psp);
>   int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
>   int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index d2ce526dd95cc..1632eda91acd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1527,6 +1527,37 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>   }
>   
> +/* Add the suffix of the firmware variant before the extension: foo.bin -> foo_l.bin */
> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fname)
> +{
> +	const char *suffix;
> +	size_t base;
> +
> +	switch (adev->firmware.sign_type) {
> +	case AMDGPU_FW_SIGN_PREPROD:
> +		suffix = "_p.bin";
> +		break;
> +	case AMDGPU_FW_SIGN_ALT:
> +		suffix = "_l.bin";
> +		break;
> +	case AMDGPU_FW_SIGN_UNKNOWN:
> +		drm_warn(adev_to_drm(adev), "Unknown firmware signing\n");
> +		return -EINVAL;
> +	default:
> +		/* Default variant: the name is unchanged */
> +		return 0;
> +	}
> +
> +	if (!strends(fname, ".bin"))
> +		return -EINVAL;
> +
> +	base = strlen(fname) - strlen(".bin");
> +	if (strscpy(fname + base, suffix, AMDGPU_UCODE_NAME_MAX - base) < 0)
> +		return -EOVERFLOW;
> +
> +	return 0;
> +}
> +
>   /*
>    * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>    *
> @@ -1555,6 +1586,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>   		return -EOVERFLOW;
>   	}
>   
> +	r = amdgpu_ucode_set_suffix(adev, fname);
> +	if (r)
> +		return r;
> +
>   	if (required == AMDGPU_UCODE_REQUIRED)
>   		r = request_firmware(fw, fname, adev->dev);
>   	else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 35277b240f25a..0b2d1bccb999c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -571,6 +571,14 @@ enum amdgpu_firmware_load_type {
>   	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>   };
>   
> +enum amdgpu_firmware_sign_type {
> +	AMDGPU_FW_SIGN_DEFAULT = 0,
> +	AMDGPU_FW_SIGN_ALT,
> +	AMDGPU_FW_SIGN_PREPROD,
> +	/* Unexpected combination of signing bits, default firmware may not work */
> +	AMDGPU_FW_SIGN_UNKNOWN,
> +};
> +
>   enum amdgpu_ucode_required {
>   	AMDGPU_UCODE_OPTIONAL,
>   	AMDGPU_UCODE_REQUIRED,
> @@ -606,6 +614,7 @@ struct amdgpu_firmware_info {
>   struct amdgpu_firmware {
>   	struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
>   	enum amdgpu_firmware_load_type load_type;
> +	enum amdgpu_firmware_sign_type sign_type;
>   	struct amdgpu_bo *fw_buf;
>   	unsigned int fw_size;
>   	unsigned int max_ucodes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6c12d8aa3c769..1df2725d31e0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -66,6 +66,8 @@
>   #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
>   #define FIRMWARE_VCN5_0_2		"amdgpu/vcn_5_0_2.bin"
>   #define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
> +#define FIRMWARE_VCN5_3_0_ALT		"amdgpu/vcn_5_3_0_l.bin"
> +#define FIRMWARE_VCN5_3_0_PREPROD	"amdgpu/vcn_5_3_0_p.bin"
>   
>   MODULE_FIRMWARE(FIRMWARE_RAVEN);
>   MODULE_FIRMWARE(FIRMWARE_PICASSO);
> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d5f428ac19bf3..b42733d85ea89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 09dc01a425d13..a409911939d38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 0895c29899d2b..c76a6c4e69992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -61,9 +61,17 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_p.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index abaa40b6def90..94b3fce1bc70a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -32,11 +32,19 @@
>   #include "mp/mp_15_0_0_sh_mask.h"
>   
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>   
>   #define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
>   #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
> @@ -108,6 +116,45 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
>   	return ret;
>   }
>   
> +/*
> + * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
> + * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
> + */
> +#define PSP_V15_0_0_FW_SIGN_ALT		BIT(6)
> +#define PSP_V15_0_0_FW_PREPROD		BIT(28)
> +
> +void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev)
> +{
> +	bool alt, preprod;
> +	u32 val;
> +
> +	if (!adev->reg_offset[MP0_HWIP][0])
> +		return;
> +
> +	val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
> +	if (val == 0xffffffff) {
> +		drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SMN_C2PMSG_63\n");
> +		return;
> +	}
> +
> +	alt = val & PSP_V15_0_0_FW_SIGN_ALT;
> +	preprod = val & PSP_V15_0_0_FW_PREPROD;
> +
> +	if (alt && preprod) {
> +		adev->firmware.sign_type = AMDGPU_FW_SIGN_UNKNOWN;
> +		return;
> +	}
> +
> +	if (preprod)
> +		adev->firmware.sign_type = AMDGPU_FW_SIGN_PREPROD;
> +	else if (alt)
> +		adev->firmware.sign_type = AMDGPU_FW_SIGN_ALT;
> +
> +	dev_info(adev->dev, "PSP firmware: %s signing, %s part (C2PMSG_63=0x%08x)\n",
> +		 alt ? "alternative" : "default",
> +		 preprod ? "preproduction" : "production", val);
> +}
> +
>   static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   				 enum psp_ring_type ring_type)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> index ebd612103526f..081be8e8268bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> @@ -26,5 +26,6 @@
>   #include "amdgpu_psp.h"
>   
>   void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
> +void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 4845588c4c247..2586d49f1e940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>   
>   #define SDMA1_REG_OFFSET 0x600
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> index c92c5fc59aeb9..cefb8d739faf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -31,6 +31,8 @@
>   #include "vpe/vpe_2_0_0_sh_mask.h"
>   
>   MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>   MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>   
>   #define VPE_THREAD1_UCODE_OFFSET	0x8000
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 383c53afd1f67..7cd08a9a957d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>   MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> index df3e776c1ad14..219e9c0427441 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>   #define FIRMWARE_DCN_36_DMUB		"amdgpu/dcn_3_6_dmcub.bin"
>   #define FIRMWARE_DCN_401_DMUB		"amdgpu/dcn_4_0_1_dmcub.bin"
>   #define FIRMWARE_DCN_42_DMUB		"amdgpu/dcn_4_2_dmcub.bin"
> +#define FIRMWARE_DCN_42_DMUB_ALT	"amdgpu/dcn_4_2_dmcub_l.bin"
> +#define FIRMWARE_DCN_42_DMUB_PREPROD	"amdgpu/dcn_4_2_dmcub_p.bin"
>   #define FIRMWARE_DCN_42B_DMUB		"amdgpu/dcn_4_2_1_dmcub.bin"
>   #define FIRMWARE_DCN_60_DMUB		"amdgpu/dcn_6_0_0_dmcub.bin"
>   #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"

