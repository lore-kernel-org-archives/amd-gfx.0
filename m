Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AC606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xJmf7uh8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5252510E102;
	Tue, 27 Oct 2026 07:00:58 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B3110E102
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 07:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1/UwL5ldM0RPIZ7ScgzSBg6Oy1f7QJyrpHiUHGi6gAGrqUUFuXbzwUbW1LYuJ9+JhDRNG72SRqFR3NjjUXdgD1fNE/Z5JYCWPaDfEwH4h4qYb9UiAv2FBNS4o8j1z+B/83wtqEPdLxa50ffo5pxm/E6TDu8EKJS3RpJuiz/dFBM3BpksGUhXr9PbrUe3FSQFdhJ+EKrp3DOKzdoa9RYzxcg+2TrdQ01XvJu9qdDDWlFjneH4cuQKvitQ+DHhfcvcwFTsvYdeofUdVRU0H7BOFfRpMv3Hk3D672lRjV6tixH0ELQC91cWPSaeBfWes/67syryly0I6uzRZCjL/m/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08UnYKNxd50YDjiscCZr5FRD+xgfMTsNGNbovzbSBcA=;
 b=Wvge6Sa6Lm1EoDASnAwLSvSvPR5DPVM+dLcHiCJfuW8TG9NxPry0F5ryHeg6+GP9fFnMabPwqxQdnKEmwve8dzh0wRXJSFpiGdNtlOeQsmd48yEQE8FfwgpVnKE0+eUfZpVxLQsDDpfmN1yWAo3VppjbwuH7d4qVgDTAkzAsgBLn3U76AK1yMW/vumT6J6IHO3dNbnUdug6gX+MRrehnHH6DVPyqbMLxHBUeP+14hrMBgDabP0Jdc3b2PWtO+iExP2Bx7zStnYkLm49RmPSwBY2/AzB03ZPSYt+fH5+o0+hs1SVdf3qOS+o6mUK8VgoPUlTPl4zgILG3qY8U3rTIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08UnYKNxd50YDjiscCZr5FRD+xgfMTsNGNbovzbSBcA=;
 b=xJmf7uh86eFYEqPq34ztdCHfs9TQ6SQ3c2bj6v5kuwA7LP/nh63Zumt8Jrkbxsr2qwxsy1SnYqogBNK7alUJRDXD5bPK8kuvqv6xovi2AfAJc4WYHRqbxCzHcrHJyVHqwvAa2DisXe+YDl4wKbS8KNYlbvji7RsoiK2SpjbGECg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:00:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:00:45 +0000
Message-ID: <7be5e89f-8b38-400d-b189-47893cf91d86@amd.com>
Date: Tue, 27 Oct 2026 12:30:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable IP discovery via PSP mailbox
To: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261013145525.1251002-1-Dejan.Andjelkovic@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261013145525.1251002-1-Dejan.Andjelkovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c5d7e9-0f99-4a19-6408-08df33f805e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: pOMnfANJkW8ROwRyB87pbechT/1jj0md3PrDZiO/Wvo6A+fncwKFwhSM9UMMiKwOBheHemRRtqUdZRh2Q9J6Do/4WVgIRFSCLQ906yefS9INo+rpP04HI6+gM/sa/aDVbIDvzkhfV7kU447QdBu29rvq6Hj4lhgEenRha37G8NisoXQdGYP5PJ+9PbjC4tqJcamKhFv24qaQTFIbQ02guHjEtMUMU72psY91c6GGiG0pKgRPPSp6FkOfBtSL+5hu/Y6+a3pymmdPfv+tC2oioxBbJUGqvBTJsKOVTeefNPUCD7MYs6yOFnsifUP3GX8YjPOKmRj0cdcfKH9ssZjiFRggz/g6hS6M/u7w7v3S4pNwWOMb31EV5S31R4c9StGGo5E3V9zXxw4uMo9HtrGuaBDw4B3ufNRtyNZKzGfC3fdupE7d2NWJdD9eDPNkxFCr+2UxYHA13+gX49+DS9OUKFacOrlyP7v9H8Uq+MsgMHRjYjVKEy72XxswfBCzT6f/58SBjzl8YP1FvLIYCWEA7PIBdKdsnx5YyT+Ah6g/KYhoYCcr25ac5CqI9GuKvUNu0jSLwq11f5OMs6NTwC6eiBDW5zMoml7Q/PcGIU2HneaGPhNQ+HWNzldtwsEuEVM3cnUP3nhqCbBfK+er6K367cbGiIhkzPSnCL6prX9egxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0FMSEVHSlRiRXJGQm5CaTdsQ1ZRMjFBTFpLamovdUJyamV6UWVENGxTc01S?=
 =?utf-8?B?MmFpR3FQMFFlS2VRbmlIbDlxWlhmZ29hUnhNY0dNVmdhcGoraDJlUEF1OTVv?=
 =?utf-8?B?RExMOStMSmtabjk4RFZES0c3bWNySHBhRTBrZHNGUWhiSDBjSlJtM3JSL2sr?=
 =?utf-8?B?dUMwUGRBQkdGZWNMQ2lRdmNMZndJcmNxWW81c3pXc2JYL2VvZ0VwWEhnTHMv?=
 =?utf-8?B?MlhrN1pWdGtORXVmbFdEckdSMnZiUTJVMHBKL2NkWE43UVFBdjV2K1FHeE1q?=
 =?utf-8?B?ZVljOWh6ZU1pNGdLMUxrdng1ZnZGZzRvU25UTkQ5YkpVYnY3bFROVFdPemlv?=
 =?utf-8?B?ZXRBR1hvemJ0elZsdkl1cC9CVWxPdTZvVGxqbE54QytuYlp3djdPYmpIdmRP?=
 =?utf-8?B?VW1nRVF0RmtrcHJ1QXBlL1pEelBCdmo0WWE3NUZpK3hlQjZOSUx0UWxkaDZ3?=
 =?utf-8?B?aWt6TVJSdTJDTFc4L2hUeGhzZUxrSDNUeDk5clQ0MFlYMCtaemdIcU1MSmNo?=
 =?utf-8?B?ZTdOdHM5YzhwWHQ1MkFFZkpjZ1BvakVBZDRobnpQWGVHVEZGMEdvL05Qa1BX?=
 =?utf-8?B?TlVtSURmUDVlRkhnOXJUTFNNM2p3T3l2QmtpSnlTR2syZlJuNXMxSEd3Y1Zm?=
 =?utf-8?B?d2wvOHdrbXFiQURXcXFkc1FMUnZzY2dJVVZybmlwRzIwZENaNlg3V084dTFY?=
 =?utf-8?B?NHdSOC93OG91Y2phdzNsMjNaQjZXMitMYzIzNWI1bU03SnRBRDlDekltYUMx?=
 =?utf-8?B?TzdTdFFmdTU2WHdOWXpIeDNlQVRRdTZ6dTdlT09MbUhPaitVSDNvQlBUVllD?=
 =?utf-8?B?UnoxSlZ4QW96MytrMlE1cHhNSjIwQUswOG9jcWxUOE9FaVBCWFFWWUF2L2Jj?=
 =?utf-8?B?Qk10UGRTYUJ1d0lPRFNzQ1FZbmZrcTFkUVNtRUZqdjVtRHBBVkN6bU1vczZk?=
 =?utf-8?B?SXkrRk80bEk1aFdDVW9nNHY1WTMraGdqaUlwZHVQYW1ma2k2UThIOEt1L0xK?=
 =?utf-8?B?TU9XUmlMOVBqbElQdTdEV0x4YjQyUEtvWWdsalZoaVBERTdOQ1JWV1QrbHZl?=
 =?utf-8?B?RkJjcTlya29hT2RHaS82VFlic01TN0tjRDJKcndybmtLWUh0MDNwK3VwWHh0?=
 =?utf-8?B?Mlk0OWVYOTRWVWVMTmVoSlYzUk9tb2tob2txVWZmMXZvMWFhT3cxZWg4QUtT?=
 =?utf-8?B?ckJFRExFWE8wNklmUExNTjd6WEwreUxNc09BTDZQanFibFp5VytQNnhmekNh?=
 =?utf-8?B?di9iYkhBd1E0NlM3UGd1MWJ1WUN3eWx5YmhSM0dUd3ZxempRQ0M2aEw2QVBO?=
 =?utf-8?B?eERrREVWczhOQ1Rqb1liVnBKTlJDZnU2SWdJQkJ2S2NIS3F0YUlvT0R1eU4w?=
 =?utf-8?B?OE1BNzVpWVlzSU5qZkc5QWNvRTYycEtqMTVqdWljRndSQ2txbDZrelVjcFA5?=
 =?utf-8?B?eEp4UEg1YXBQclZVdUNQVjNOb0I2MkN0VEtqbjNPVHdlUXhPRzZVWUtPMzRS?=
 =?utf-8?B?UFMzVE1lWGUxM2RZTXArRkt5QW44a2VmUm9XRmlaRWs5T3crSGIwd1hyNUVS?=
 =?utf-8?B?cW5ESnQ2WGhndFE1b2V5TFU5MVhqREtXekh6V1AweWNtVisyaFFTRk5GYmxo?=
 =?utf-8?B?RGIxRXZnZkJUWFVjOWVtTXRlKzJiQ0pJM0t1U3Z2NW9iWlE2SGVvT3FMaVh6?=
 =?utf-8?B?ZUMzNlJ6ZGpNU21qZWV3S2hNMFYxOGJ0YVN4SWRoNEF2SEd6bFoyaFdqdDBR?=
 =?utf-8?B?UW5WN2t5dXBXdTVqbWh6NGpqeitMc0lzMENOK0cxam1nYjJRNjdSTlFQeFRM?=
 =?utf-8?B?Tjl3Q0hweDlDdkhkVDFWZm51cWJSQlZpcXRFRlZSSzhlaitKZDV3VnNXRHFi?=
 =?utf-8?B?UHJIeS9DMXZpSnlxWjFMZ09CZVpQVStRV2dsWVJQbGw5R0tUSUxjc0NvNWdy?=
 =?utf-8?B?NlVHR00wTWNOODdIM2hGY2RRNWpIbG5ONjBEZlpiL3pmRGlRVkl6bmoyQklp?=
 =?utf-8?B?Y3pmV05qVjZpM1RVQ1haUEhPTzh6RDFVMmZrSTdhSGlYZDYrdXF1dWxEb0pm?=
 =?utf-8?B?K3NYeE9iSWUwamhydnFlWmF6L2pMZ2Jwa0dEQlBCTUx2blFyZVllR3BmQkth?=
 =?utf-8?B?aGgrd1dkSGhtdW5LS3l5eml2dktweGEwREdpYlhvWncrL3FacWtPSmNSLzAw?=
 =?utf-8?B?SWhTMytYMSt1VHRpdkpBWC9ZZ2c1VzVoLzF4cGIzbkpHZml5a0c5V0RKK3RT?=
 =?utf-8?B?YmVkMGpiODJrNUROZmxjU0UrQUZ4TUo0Y3gvSmhLbFBRdWVPTDBBNGl0SUJT?=
 =?utf-8?Q?Pgl1yhsLrEr2ys6mQ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c5d7e9-0f99-4a19-6408-08df33f805e1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:00:45.4652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKyOguQtBHxUdczYlxdxUS+EgaQrYDPVVblFhAWLxs8iviS2VTSvAAp9HxlB35Rs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 13-Oct-26 8:25 PM, Dejan Andjelkovic wrote:
> Adds support for IP discovery via PSP mailbox using guest phys
> addr for passthrough A+A.
> 
> Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 58 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  1 +
>   2 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 5564850e3ff4..3372de34149c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -28,6 +28,7 @@
>   #include "amdgpu_discovery.h"
>   #include "amdgpu_ualink.h"
>   #include "soc15_hw_ip.h"
> +#include "psp_gfx_if.h"
>   #include "discovery.h"
>   #include "amdgpu_ras.h"
>   
> @@ -149,6 +150,10 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
>   #define mmRCC_CONFIG_MEMSIZE	0xde3
>   #define mmRCC_HW_DEBUG		0x10c01
>   #define mmMP0_SMN_C2PMSG_33	0x16061
> +#define mmMP0_SMN_C2PMSG_64	0x16080
> +#define mmMP0_SMN_C2PMSG_69	0x16085
> +#define mmMP0_SMN_C2PMSG_70	0x16086
> +#define mmMP0_SMN_C2PMSG_71	0x16087
>   #define mmMM_INDEX		0x0
>   #define mmMM_INDEX_HI		0x6
>   #define mmMM_DATA		0x1
> @@ -410,6 +415,46 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
>   	return -ENOENT;
>   }
>   
> +static int amdgpu_discovery_wait_psp_gfx_ctrl_resp(struct amdgpu_device *adev)
> +{
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		val = RREG32(mmMP0_SMN_C2PMSG_64);
> +		if ((val & 0x8000FFFF) == 0x80000000)
> +			return 0;
> +		udelay(1);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int amdgpu_discovery_read_binary_from_psp_mailbox(struct amdgpu_device *adev,
> +							 uint8_t *binary)
> +{
> +	phys_addr_t phys_addr;
> +	uint32_t length;
> +	int ret;
> +
> +	phys_addr = virt_to_phys(binary);

Does this really work?

> +
> +	length = adev->discovery.size;
> +	length = (length & 0x0fffffffU) | (0x4U << 28);
> +
> +	WREG32(mmMP0_SMN_C2PMSG_69, lower_32_bits((u64)phys_addr));
> +	WREG32(mmMP0_SMN_C2PMSG_70, upper_32_bits((u64)phys_addr));
> +	WREG32(mmMP0_SMN_C2PMSG_71, length);
> +
> +	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GET_IP_DISCOVERY);
> +
> +	ret = amdgpu_discovery_wait_psp_gfx_ctrl_resp(adev);
> +	if (ret)
> +		dev_err(adev->dev, "ip_discovery: PSP wait timed out\n");
> +
> +	return ret;
> +}
> +
>   #define IP_DISCOVERY_V2		2
>   #define IP_DISCOVERY_V4		4
>   
> @@ -768,16 +813,21 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
>   		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
>   							   fw_name);
> -		if (r)
> -			goto out;
>   	} else {
>   		drm_dbg(&adev->ddev, "use ip discovery information from memory\n");
>   		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin,
>   							  is_tmr_in_sysmem);
> -		if (r)
> -			goto out;
>   	}
>   
> +	if ((r || !amdgpu_discovery_verify_binary_signature(discovery_bin)) &&
> +		amdgpu_passthrough(adev)) {
> +		drm_dbg(&adev->ddev, "use ip discovery information from psp mailbox");
> +		r = amdgpu_discovery_read_binary_from_psp_mailbox(adev, discovery_bin);

Instead of fallback on failure, can we make use of DRIVER_SCRATCH_* + 
passthrough combination to figure out the read should go through PSP 
mailbox?

Thanks,
Lijo

> +	}
> +
> +	if (r)
> +		goto out;
> +
>   	/* check the ip discovery binary signature */
>   	if (!amdgpu_discovery_verify_binary_signature(discovery_bin)) {
>   		amdgpu_discovery_log_bad_signature(adev, discovery_bin, fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> index 49aa95c76745..bc777f53a193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> @@ -49,6 +49,7 @@ enum psp_gfx_crtl_cmd_id
>       GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
>       GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
>       GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
> +    GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000,   /**< Copy IP_DISCOVERY_DATA to host-specified address */
>   
>       GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
>   };

