Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812DE1073CA6
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10A610E431;
	Wed,  8 Apr 2026 12:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3p3lzLLD";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76C910E431
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/EMrwilJD8qm3+AaEqXbfTfQvrnph6F78K0hO/+JTxy3U0zxWXZkTPjRMUT4bgj7tKahb6dik5NuebEkF7+PpSYcky1lbGf1j7Lq2h/FlDdGB0LZgOp5mjAjf2mSDAw2gXJ4lniG83sAarIV7I1saP0H7NAAhh5ShgtYoTOrQWmtC0HVcj/aNIsjD+WLKAPfcJTFe2I0PoRj71XZnlyqYQswN640Tgt1ASzytPs4yBnLbofTu2Vo0eA6tNO6XV3B3X/qCt9lNBrGW2fLNhJ/aNJrs34UbZ35n7r16SgoBbcQkd/BSkZ1wvrYijuoopFO7aJx2GjEZM8TZMlgzvhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltj6lfUAoAT5ID9exDlY0TBI004K9iksBRxxO7gHQv8=;
 b=F/7dKsdClT+ivde4y/4/qVgEy+hsl/8B38OTm9UfI1ZX6KxcKj6f7GiqMuItEUL2BN1txIeFJvUsnoQq0VACE22ivBjMITk9pp70N182yBI5B3My7VWobOU5hU+RTKTOXoaONmVCdTbfPzaFQXwPZaL+3rf3oP0neP+OZkciqHBnv2pigaajCmBQ4pSMFczBSps6U0+KSRl4HXNnV+Qtk/Ku84ciO2ZZb0AhdKKjpIlJhZXQBhGgPO3NW0cCMCp/f/y33m/7VnySt36U2czrQ+P2YtODWNgeyp1uH1A+asvSDbLVZKNlLxAhV9s8Mx/it9z98BmuE0Ru9Cv1/LmMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltj6lfUAoAT5ID9exDlY0TBI004K9iksBRxxO7gHQv8=;
 b=3p3lzLLDz/IQ9sKuNkz3tNSxn57i5P3qXFuob3McieKwya0rdxpt/NGIeHtjEXZcJ8GEuSOJC+RKnFpk/WJfqahFsuYo8otQK0MsNl+eqX5OOFdU3U57UzZEKrsI2Q+g3miz5enITnzjiMIFr90tBW7t+wHBcnPVdfhFADB/QVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 12:27:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 12:27:49 +0000
Message-ID: <f315db0f-2621-463c-83c1-93fb13df26bf@amd.com>
Date: Wed, 8 Apr 2026 14:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 Ruijing Dong <ruijing.dong@amd.com>
References: <20260408122456.1787039-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408122456.1787039-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: aad27c90-126d-4f46-c65f-08de956a3ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: W8Rg31uzntJ3FpeVZFj+lIjT6YwI4Q2SU2wgYdKKJZ2YY73J7sbc1jzue9TT2gZL14OeyFmT6obpTNOVzg8OvffihLBPOyAifz0HLXlYzKe97//e0SX/DMXd2wPMDWmgEwGgJJYP31afaQeq+1RV7J25VRr44q5ycnDBPkKY2PMfBmSyuc4ohoXXNNt/gZc5XiIcuQ/mNk5K1hLx4629MHk3mGQ9INJMPt+wINfhpMk0a+xBJlzMuFPNBl18F9nNOsM5RhXs/QKBWfn94QcRbqfszXe3345q3RjllKokJU2qINOyNdlhZw/GMrl8ClnsjfQvsnJolrN8f2vjUZiljDG0QsTD/f6lgnnjQTi8RTrIS5h/6IcZyGI6QTPJITW8LiyTdPHN1+FXACwlQaRFb6suDNqi8qYZBFCk9ZbGsV6ho4KDI8pyThMdhY+3GMuZdmgDrQ8XxiQh8TPDirn5Ne8YmdWjSW5s/orF4bsPq9J9Xp39t3dmGZj+2sF4raC9+yG7ZJR1iG4QHwVdjbchubsobLkB2+KzyOzFbBAvsgDM6uCLCNo1PwAH//v5SftbVIPhM2iYDi9lPsuhjisA4bUrBc10Ok7+lhPMa4JCKCJUIOKfTRLh/QsGGL0E2raQyRvrS8HHhmWrYrdcuTe0jTJIgYbhDAS9zmO/IpyPLtC9De9Jf7FMECW99lFRSMEj73k3rxjPJCobUTDbRCJ0DLCxz68Fis225NQU5g386lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9JbTEzWEM0MkZDVzFaQVFSeVRFRGMxTi9BRDVjZ25ickFKa3YxR0syazc0?=
 =?utf-8?B?SU5oY2ZlMzNWZE9uTnhUUVZNOTJNOEEvWHJoeTRNTDFROUJvNThRNjdkcm1r?=
 =?utf-8?B?QVYrMjMzTC9PL3dZalUzWjQyVjVDeXN3KzY2TmJQbG0zSmQzSVZwZTJsWCta?=
 =?utf-8?B?YlJkMW5qUGxDUHNWN2RYSHNIQ1FSaXY3M0ZsK0VwMUx4cHRWZ2M0blVOL012?=
 =?utf-8?B?V3NYZDhhck1VSmhWK2t3M2pmZm90ZzhxNHgrenJCV2greVBjcEZpS1pMaE90?=
 =?utf-8?B?UlFXK0JXbk5DakVDVWlHY0tEZUlsOUV3c0p2Sno2ZDJkYXA4ZWw3Q3JyVnpR?=
 =?utf-8?B?WnNaTnB6Und2NzgxUFN6QkFSSlBDWklORmdmeTNCMnMveUxrMkNITUgwalFn?=
 =?utf-8?B?WUE4bmVzWEFQczlaZ0FwSzhtQUF0aVR3Qi9wV3h2bXFJTTR6K1F4UCtoNThO?=
 =?utf-8?B?S3hiQzNtV1FNQ1F6QVZodTNUWjFBeXYrNlE3OVlReVFZNTE0R1MvaHhXaGU0?=
 =?utf-8?B?SXRBcDFTdnc0MUI2Qy9hdFFUZjJsT0FmZ3pOZDZ4V1o5OW9uUVlramtjTkVR?=
 =?utf-8?B?WnRaRGFTVWlsOTN4TkFTN2tOeEZ3eGFBeTV5eDE1Yk5Fc3Vqa0dRb0tvV1Yw?=
 =?utf-8?B?V0dVandoMjY3MGVheTlDdXYydE9rYVBTN1dCTzdOQ3ppb0RtWXJIdDR2THhT?=
 =?utf-8?B?Q0JQT3dyaXF1dUxoWEVqRy92TGpVRC9UK1VYT052RmNIZDFBazA1dDJyRHJn?=
 =?utf-8?B?R2U3NkJZc2c5UFl6ZWI0YXlwbmsvdGhiaTlySmNqZkNYbDVWMWV2TnI4RW1u?=
 =?utf-8?B?OHBtS3RkVDUraitETW91TUhFQnRFYWNLUFBVTlBNeDN4Z2ZHOXhnK3EyOE5W?=
 =?utf-8?B?NUdoZ1VYK1E4bHJzVnExUEhuVldGWEdxbC9zT0xvQXI1WHQ0VmRycitIbmRr?=
 =?utf-8?B?MzQ1bzBRUWpoYURVcWpDdHZOM0RUV1B6azlMNm0xc3B4aldGaldpcTVCdjZ4?=
 =?utf-8?B?Zk5LUHdmWCtSVnhKOWdpand3SnpKZ0dLbStGc3VkbWZQRFhlalRlblIzNm9D?=
 =?utf-8?B?eHNJaEM3YlhYWmUwYUIyZWVvTGVOM1BuVis5UnB4OEJna0h3WTRpME9kUnBL?=
 =?utf-8?B?RkcwTUtUQnFvdXNNUXRxS04wekVYbmxydldNU0ZkaitBZmNpTEFVcG5qdHYy?=
 =?utf-8?B?MHdkZDhNMkV4eU4vcWc1S1VZV2VJS0FlazFPZHRJRC96WmtZQ3RlS2F1dzJW?=
 =?utf-8?B?eU9FcXh3bkd4ajR3LzB3ZHFVSWNSbU9UODdVSEw3SFU4ZUlsVmp2Tis1aU9l?=
 =?utf-8?B?STZEY2psa2xmRE9rZkg2NmJDTkFFaU80U0s1N0xiTlRLalZxYmVOUThoQ21M?=
 =?utf-8?B?d1RNeGpwRkY4NFpka2d6ZXNjMzJXNXRrVWo0MVlWbFIzN2VQVk02eGhHZ05z?=
 =?utf-8?B?SEV4QkcyZVFMakMveDRVem0wRVg1aEV3TVVJby81TjNnV1RSazlRdEQ5cHFS?=
 =?utf-8?B?bDIwaE5WMHp0NXdOaERtTUVWbEt1cnNjL21hRXBsL3E5bmRkRlBLcEx6clFr?=
 =?utf-8?B?SjBDbTZqa3lkTWtHWVdOVXJrZnBZTUZBUlpadE1wM01ONEtBRlB0Y1pINXVU?=
 =?utf-8?B?WFdmNGFERkxHQ2pKMnRRM0FkWWRsSW1aYXRuS3UzOEkxNkswUzFXRWV6OFRY?=
 =?utf-8?B?cnhCbE9QczFmeTB3OWxYSTJTY0NvNDZDNDlFNlI0WlArM1pxUlFzeDVwWEl1?=
 =?utf-8?B?QUxjVUZTZG9sbjVOR21VQkNnVVlnb3lhTW9hMjZyc2xuTDZkQzg0dUUyYy9Q?=
 =?utf-8?B?UFVTdGlFUUEwQUVmWTM5dnYwcWcxaWgxbGVyUGRoT3ZRU3NycTcrdGFta3Nx?=
 =?utf-8?B?cVpNYkpVRFFPelZyc1hXZlEyOWNNZzJ6WlFVOTh3MzhNc1V4d0pBMHcvWTJJ?=
 =?utf-8?B?MnpNaFZuajd3Y253bmFvSThGRWRjMEFXekJwZ1d3NW51bHVUOTd3QjUyWWFz?=
 =?utf-8?B?RTZJRDRYYm9VamJlYWpQY1FlUFo1VzFUR29tZElJbGd3bjBiZWhwNVByeTNo?=
 =?utf-8?B?bmhvWjNNVDZ2NG44N3U4YWRhcjJKUkxMMVI5VlNXT2F4a0ZlSFowb0hqd1Qy?=
 =?utf-8?B?dk9yTW5KQlVhc1pTZjMwU2lQcm1nQzJMNkVoVnIrUk8wQ2h6amRqNmYzdU1Q?=
 =?utf-8?B?TlBiVWE5dUNWSTBWZi9EMnBvN2NKNGJMYjlUTDF3OUNxUTlveE5lVFJMSTAr?=
 =?utf-8?B?VHpaL2xxeUtTaUFhdldhQ1dUSzBiMlNtejNVWFpoRGVTaEtia1VERjhLQW1q?=
 =?utf-8?Q?N/xS7tk8ccq+G2CU0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad27c90-126d-4f46-c65f-08de956a3ee4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:27:48.9336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z8isAziRlPkjHoR/sIQ4IanveMbW5o0AqxYlfee7GkerYynaX42rX1ZN1ezExQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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



On 4/8/26 14:24, Benjamin Cheng wrote:
> These defines can be shared.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 3 ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 3 ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ---
>  4 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 82624b44e661..fd9657ae6c37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -57,6 +57,9 @@
>  #define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
>  #define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
>  
> +#define RDECODE_MSG_CREATE		0x00000000
> +#define RDECODE_MESSAGE_CREATE		0x00000001
> +

As soon as it is in some header it should probably have an VCN_ prefix.

Regards,
Christian.

>  #define VCN_ENC_CMD_NO_OP		0x00000000
>  #define VCN_ENC_CMD_END 		0x00000001
>  #define VCN_ENC_CMD_IB			0x00000002
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6fb4fcdbba4f..0e8eb4f671c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -58,9 +58,6 @@
>  #define VCN_INSTANCES_SIENNA_CICHLID				2
>  #define DEC_SW_RING_ENABLED					FALSE
>  
> -#define RDECODE_MSG_CREATE					0x00000000
> -#define RDECODE_MESSAGE_CREATE					0x00000001
> -
>  static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] = {
>  	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
>  	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 5dec92691f73..00abac9c7fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -50,9 +50,6 @@
>  
>  #define VCN_HARVEST_MMSCH								0
>  
> -#define RDECODE_MSG_CREATE							0x00000000
> -#define RDECODE_MESSAGE_CREATE							0x00000001
> -
>  static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0[] = {
>  	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>  	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 1f6a22983c0d..cbbc02d68695 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -50,9 +50,6 @@
>  
>  #define VCN_HARVEST_MMSCH							0
>  
> -#define RDECODE_MSG_CREATE							0x00000000
> -#define RDECODE_MESSAGE_CREATE						0x00000001
> -
>  static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] = {
>  	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>  	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),

