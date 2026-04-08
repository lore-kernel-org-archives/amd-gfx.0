Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7C11073CB9
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F5710E340;
	Wed,  8 Apr 2026 13:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hnoJMc+/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB0C10E66C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOi5yJ19/0qIKo0+ZUV/zgtJra/TTlwBIrRAgpxj3WPmd7KLWFIycA2r0tRqGTsv3g3MyuaDseJd4HNO3B0DPwT/aoyi4gwXogLQxjQ291Pt7Fk+sM4O9GKe03SJ4Corh+LJNYvRQen5e2QGmlxz7numZbxag5VPJOVrzYLInNUoTJXEBA5cGhOz9/VDECVNFgqCcESWYJ3WynPb4yeqd7HD2MIp33oDdnAr7tjIE4qQ5NomDwKHLYhEx3ofquYm/aisvwUy+nYeHrUcd5QDipsDNtiQiaq3PTW0nfL0WVRQYYfF01KvvyeNJPtBIavAcc761NPOW5sOX2YVeDImvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZkpd0xMn3xxLJ0rxw8WWxEDK9SQI3hiNVxCX1Wl994=;
 b=XtmYREayArot84OtWIcnz3ahB2pv6jAOvZ9aLkebAKizoonPoc+1VhszFCTrFeXXJ6AKz6Sq5QFF6hvJ3ZVMnoB4JOCeZZeqQAMwfbm7V1qvS2ZsDq8zEWxQ2qZrVHD/pw87BuAgpqWdMXFbE3OWZF7us3f8vu+Huit0diGNJpQrMYVfcyWwfEc2W5vhd6dPlcpfqy4ki/0VZ40SVlzhOIGKK/MUy/Or9UZ9CAJreOdXSA7fFJvWZ5NDJBpxSNGGotILOslqwv4xs6Fu7AKsxXWLrepLlbnYbSnd0uNcCE3OCW0JSMYVKeZ7YRx+Ebq8N9SnFBYq6sXAEahp6+ulUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZkpd0xMn3xxLJ0rxw8WWxEDK9SQI3hiNVxCX1Wl994=;
 b=hnoJMc+/xkxwjAREzdvHuvDTOU7pgPTLgC+tkvWLpp0QvEIlOWTt5S6NRf3hr4u7K3PnCjQoI5stmMBorzF5aYt/cKbPSg4XdZ90HIMJDwTpR18h/m3MW++ige2SVtVpvAWY1o6AMUn4rTKvo+0Vh5zIX0JpOYVbJYqQUvujkfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 13:20:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:20:12 +0000
Message-ID: <8a148179-7d10-4640-8b2b-b79eba9f38d5@amd.com>
Date: Wed, 8 Apr 2026 15:20:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 Ruijing Dong <ruijing.dong@amd.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408125426.2118644-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 7082f105-e966-4160-dc1e-08de95719060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: PMHgMZZOvThJXsx2CUW+DD7HRls8eP9JWuLh7T5smmzZTGhevSarqBnhjMtfy1Ldzs0PnTvIJWc6iH1qF9KllbUaSRE7s9IYvM2jyqEX7Xa/zksFdqG0dx3JK+jhmhP5j0ZZc2gCWQBx3OtJAHDm0zjo5Q9sLYAe9XmknGM88CEfZYBE7JRNCBhdTFi/GQRLl15t9G0puG0GaOBrvYNRygD64B0S4c0DuLpzqIWvce3D4jNIw4gpEpvt3ziBALZvMlC2R8vN62fCLyZZaiBaISyyvFXLN6Fede3fVxMcdVhyNkc4SvzSO1pP0XmOXn2Ytwl3qXdY0okD1x2pYhtqQoIc77pvi5a3AdCkKwzsDHxRWiVg3Wqb26zwrBda1qZ0kWl3oOPcd+I1WjT2ZStx1NIBxFxPIhk14vLP7NhokgEiVfk/kdfKWBTiWGEZTY67mEwdWa7+Mu8s5YaaGCy/Vd3tEJeOCKSyyjxatldTMO5c7GXwGamx8kB3alBMNafBsg8jA3yqbXIBhQCNjbt2QSczT3TtkLh3lRpDav32DHH/ebxD+k1wP0mCI8PZ51+MSEt7OmO3I0gRC2PyykhcIOsyDAdhE5Bv7OljI7YhI4QQjkhHnR8t1YjgwJhNAGMscAaUBXjzojP9hxBFScbjrTVeU0oJYqjC4LdSnpBLG53oDIBR74tZ2euy3wqaHnrl7yRHlGdICtHksflTmVMp2svmkQc5D1mrQTiraXU9P2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZjbVFRVURJa096Y2pvS3A0YUkzUzludmtDcjB2ZHJuMnBRRFV0VUE5dGx2?=
 =?utf-8?B?MXZ4Q3ByTlRQWFRLTWVSSEJHMEZ4NTRQWjdCcEFhakh5b2IvYTRtYm5xNU40?=
 =?utf-8?B?cjJDL2JCWlBZd25BYmlNRzdvYjE2QWl4QzVUVnN0Q0dpMUdOdHpsczI4cW5D?=
 =?utf-8?B?ald6T2JJN2dsUTNuUE1KTzRoZlNxWlIvUTJpeittK0xzS0dDV1VHdi9MOXVQ?=
 =?utf-8?B?MUdGQW9TZ3ZwU3piVHlENmRSVWFkQlUrenhvVmJQaGZ6bWhiODgrWGYvZDg1?=
 =?utf-8?B?cmtoaEFRa3hXYnZreUROVTlCSU51dXl6VWduNnhycjdhTk1SWGVZUTZtcDRy?=
 =?utf-8?B?Qk9oSjlvR0pmQTFYeXpTZE13ZUNIZ1FTTmVEeTdtRHV0aURrMlhvQkU0VTJZ?=
 =?utf-8?B?SHpUdkdPV2NYMzhGbzZzLzE0Vm12dmwwMnUwN2VJOGFveDhIdTZZTFVXcEhP?=
 =?utf-8?B?VWJhaW9GN3poMXM3ZHBMd1lhbTFpbWtCTGNxcitCVWluMnlkcnB4cHRxemtu?=
 =?utf-8?B?d3lwakVMRlpwWEVZMUR2RzZDQVJHS0ZCMzhhOWNvNzFUc2pzVXlJTUFQaEh4?=
 =?utf-8?B?ZDF2dWhXTXBVcEcvYVFOcWtlM1NHN1o3dmVpSXRLd21XRGZoaHpTdEd0b0VW?=
 =?utf-8?B?MDlqUlJTbHdPRGJ6b3lxWldkb3BwNkVNSzFRYmZSWktUN3hrNU44bFhtUm1r?=
 =?utf-8?B?S0g4ODFsZ0QrOTRzNHF3SXBid2NGbDduRnNvSmdFYlk0bUhIdEJFMytpaFBR?=
 =?utf-8?B?WTFnUnV4enZUd2cxMXRLZGpxZ0wrZElHcTFITnJETXc0TlJLUDNQU0ZKWmxE?=
 =?utf-8?B?L2l2dEhEKzYrbDd4WVFuYVpoZ3RpT2QxWDZEb2dUZ3NNMlEwM2NzdFhvWC9J?=
 =?utf-8?B?MXkvVUp5aVF5d1BjNlFITktzWWdNWnl6V1VQemNtUURtQ25oV1RERm5zSWI2?=
 =?utf-8?B?QkRqL1NKMU9XeEtFeUludklGM2lvcXpRbFdzWmFUdzRweGNSMWtET3doWnh5?=
 =?utf-8?B?R2U4cVhOUDNXd0VHa1ZyN21QdzV0L1NQY3FhNjFCR0U0Wk9NQ3VXQ3pCQy9C?=
 =?utf-8?B?Wk43Ky9GM0NUb2tjOG14NmFmVlhJTlIvMTNwd3dURGxRblJvTnlTdGgrSXFh?=
 =?utf-8?B?MGVEZ1pFa2tTRDVpMElMK3hpdHV4c0lrUU03MEVFMjNXSWJNcHkvVkc1UVlt?=
 =?utf-8?B?RnNZUDd0eWlFbjZMemVvWW1KR3FwU2x4eTN5VW1OMXArTkZjZzRDZXp4ZFJG?=
 =?utf-8?B?U3pmcXk2d2VBSU83OS9WdDR4NzJYNUt0UGpjUTIzUFQ1Sk9hM1JObHEyaklD?=
 =?utf-8?B?YmxlcUVRVTN2TVNRcEZsL21QdDFQS3cwTFZNbVBQNm5TYTFpWXJMbFNoR3hO?=
 =?utf-8?B?dWt5c21GamZpVEgwbk1xcTVtOW9ETUdMeC9XNlRuUnpPVWFDRDlKR3N1OVJh?=
 =?utf-8?B?WFV1SnEyTURldlExWUdaUFhNRktETE1xZkRtN0tiSVpZWTBPa0p2ZE51SVFk?=
 =?utf-8?B?b2xMQ1dwTHAzdU14dFFKQjBzaGZFd0FWcjEvZnBTVHBucVFJTTQ0cFlDclZp?=
 =?utf-8?B?N2FRWlFoQVl6NUlDUUJIRmlja0RrS2psQVBESlp4d0NhMDlqeXgxcTR3Ulk0?=
 =?utf-8?B?MW52UHNSeDV3emFibjJzRkxWdUUwajRCdkpodUhsWXdrYWh6b2RDUmo3VU93?=
 =?utf-8?B?WWVGM3ZoRUFRQ1RrZXFSejF3K0JJNzMwWk1GZVYzNmxueUJ5dGNvSitiSm5K?=
 =?utf-8?B?L2dBOXR4RXlLVUx6aW9ISnBZNXQxMXpENDdjOTVOWGVGQTFXYS9MVHBETVBv?=
 =?utf-8?B?M1BTNyt3eEIzR3VsbURkYURrWkJ5b05od29jWmN2NkR4ZEUwYzNPdEFNSFNi?=
 =?utf-8?B?NXllR2JuVzFkblZQRE9UREwvWEJxSVI2NnVGWmUzNjlTbFovM0FGaVY4YTE0?=
 =?utf-8?B?T2k4ZjNSNVpYcUN5UlpveEtkUVpid3lSaTZxOGNnZ0ZmS2Z1N2VBNm1tSEJK?=
 =?utf-8?B?bnNsaStOc0dYeFMrdHBLZVpKcUdoNVBGUEErTUl1NkJJcUJWeW5hVWNVNmhI?=
 =?utf-8?B?ak5NN3lPNVJaUzkwSlFTTUN5MFNVaStMMHF5V2ZoWE1LVWF2YVo5T3ViMGRV?=
 =?utf-8?B?bTZSMGtBRHdNU0k1cjlrNGkxZ3ZnMG1NS2ZzTVVjK3NNVEtFK1puSkdsS3hI?=
 =?utf-8?B?SGpzQzhCcGMyRzBCcWJWU2lyN1Rtbm83aDR1eTJEZDFFVWRpQnd4amJYWGNs?=
 =?utf-8?B?RDdRVFVIbS8rQi9QdmUxNFB2THQ1VnE0ejhWZngzU2ZkbUMxUkVEYk8rUVFW?=
 =?utf-8?Q?+MUhvUTD7IO3alsNx7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7082f105-e966-4160-dc1e-08de95719060
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:20:12.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /80G5RpZfUOMxNEzAlX9cGXTOA/65irY5znmYFdi9Hpyrn9a9UoelWqpwfFLwg/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

On 4/8/26 14:54, Benjamin Cheng wrote:
> These defines can be shared. Move them and prefix with VCN_DEC_ instead.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
> v3: Renamed to VCN_DEC_
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ---
>  4 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 82624b44e661..e72687246235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -57,6 +57,9 @@
>  #define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
>  #define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
>  
> +#define VCN_DEC_MSG_CREATE		0x00000000
> +#define VCN_DEC_MESSAGE_CREATE		0x00000001
> +

That looks better but now we have two defines which sound mostly the same but have different values.

I briefly remember why that was necessary, but we clearly need to document that.

Christian.

>  #define VCN_ENC_CMD_NO_OP		0x00000000
>  #define VCN_ENC_CMD_END 		0x00000001
>  #define VCN_ENC_CMD_IB			0x00000002
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6fb4fcdbba4f..64531ad56c48 100644
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
> @@ -1957,7 +1954,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  		goto out;
>  	}
>  
> -	if (msg[3] != RDECODE_MSG_CREATE)
> +	if (msg[3] != VCN_DEC_MSG_CREATE)
>  		goto out;
>  
>  	len_dw = msg[1] / 4;
> @@ -1973,7 +1970,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
>  		uint32_t offset, size, *create;
>  
> -		if (msg[0] != RDECODE_MESSAGE_CREATE)
> +		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
>  			continue;
>  
>  		offset = msg[1];
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 5dec92691f73..a89e316a4add 100644
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
> @@ -1874,7 +1871,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  		goto out;
>  	}
>  
> -	if (msg[3] != RDECODE_MSG_CREATE)
> +	if (msg[3] != VCN_DEC_MSG_CREATE)
>  		goto out;
>  
>  	len_dw = msg[1] / 4;
> @@ -1890,7 +1887,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
>  		uint32_t offset, size, *create;
>  
> -		if (msg[0] != RDECODE_MESSAGE_CREATE)
> +		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
>  			continue;
>  
>  		offset = msg[1];
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

