Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968D5C02196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 14:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BBC10E87C;
	Thu,  6 Feb 2025 14:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SKbGTPmp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D3310E228
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohS2CEmI3R5ZpL9S2IICaMVJj3ByNCZL8kss5/aM7k/SjhdaiHj8BuITI4FZF4dHlZsagb+AvWg/u07TVvt0MTSdSjt9gXZVaLdQzhG64Gsl/i9xUSjIM4SySizYpOd7FLimU6gByq2LxwiK9bA9PJP8A9J1Uwu2f3HnZ95uSwiPKZHeJnO46SE6ikgBTMZE2hJgQETi3POHP4FuAE+mhK57zfZtaGRhW0/BZm+aXeVwd7oER0EkoAjp6xkrRUcJhLOH6hfjX/MEm2zAFJ5FWnegSfRHnMx7yt6gOYjflF/sk5RUONyGBNMxyWlfcbCQuC2AtGM7rRaQm0BiGJPXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg7XT54DhthrRUmxuD0dk+x//l29uB0gbN7MqT11xDU=;
 b=X9fLnq/XPyCdlL8NQ8gSG6juN0UwYmEtbCwTJ8SILBVBhCUfNN6fxcWNm8N2TM7cfVyWe7Megv/f70eefbduiGla70Gceikgj48U++Yf4Sww5o9j/PM72Yognj9ykLpkFjLaVWbm66Ic9bj5s0/0mzJ25huwy0rmo2QWibEWj47PdNc5TYyl5VQN3RwZZThVOs9oOu3Gj/ycUSf3V7kTpbXlJjsO9S9FG+6XFqKqFb7w9LReJR4YnKQg1uZz4kYk1pSp8LzwF7J8QNO6yqs9ZZUrwksSgatomO8EKyITaWVxSpHW5rdpBlRz4OPYdl7dXIIZhWY8i7oqoX9UwsITIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg7XT54DhthrRUmxuD0dk+x//l29uB0gbN7MqT11xDU=;
 b=SKbGTPmp3C7iyFE5cM/bBxUZpW739GlG12wrwqg3H54ZcCZl841GMC/331b9NX0z+6tnGl+vhF14D2S+692pQR7ut7n/nfFV2v/AJD5qjNObMH5BawJGe0pC2g62RzREN8fa9ie2oZZwCM4rqPL/e9Hde1IdjlDSHZ6Ch6IHHvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 14:49:09 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:49:09 +0000
Content-Type: multipart/alternative;
 boundary="------------8athN1xKtvT0msGbVifwJv1V"
Message-ID: <0aa0204e-13f3-4ae2-897b-4d8cd1cd9ba6@amd.com>
Date: Thu, 6 Feb 2025 09:49:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/44] drm/amdgpu/vcn: use dev_info() for firmware
 information
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-45-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-45-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::7) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 35fa82ef-c616-467d-f2e8-08dd46bd69a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzA4L1ZCdVJVYWhNOHZMMnVUMnBzZVhNKzJ2UjZ6RXF0OTZWSGh2ZXRtTHkz?=
 =?utf-8?B?TDY2SUJLUG5aODJkUCtIbzZVcGUxU3hGbnVObVNtMk5rdG5vWVA5VngzRlVN?=
 =?utf-8?B?a0Z5SEd6bVk3MFZZNDBLbERHMEdWeVNaN0ZLT0x3U3JWS2haanJNYzhucXI4?=
 =?utf-8?B?OWJ4OVpUM2xSTmdVUnRoOG1zVytKZnp4dFpBVSszZTB3VDBOL3FaTHBnemJD?=
 =?utf-8?B?TGJTam1QQnBJNDNNelI5cm14ZndsNnoybmR4WU5UczB3b1hYM2c5N2pvclU1?=
 =?utf-8?B?NmFib0tKMFJTMUZtOGJ5SEtacDJjd3N2d1UzNHJ0dm9LYXBsUitaWGkrYlVm?=
 =?utf-8?B?bWNPZkZvdVl0Sk13cEIvOWZLZEMxYURMVFhhRFpuam8xaWlYOW02MlJWTzFT?=
 =?utf-8?B?TWl6QjBjamZid1htRnVvM2F2ckpBR2Vzc3V1cE14QjZUYWhvNVJMakFuVjFH?=
 =?utf-8?B?WVVaQ2FYellDZ0pia2JTL2NGbktJWC9QcitkdVE4RDhTMkROQWlYRmV4TFhW?=
 =?utf-8?B?NjBHWTYvWlJUNUZkcE5Ga1BKMjExRFRMR0NMSlRONWgxUTFIWVRLTWRlb0hh?=
 =?utf-8?B?SENscmRVbVJsaWt3N0tYTzU3SlVUNExLNjQrWUJwRDIvcFRYTk5aZ1JTenRG?=
 =?utf-8?B?VXNEVTFYbzdwWVRMMDNEMUJUYnRQcTdQc3l5L1B2Y0p6WmNIYXIvQlJVcDBt?=
 =?utf-8?B?MFZyV0ZmTXIzOEJ3S01xRU5mYWRUSnJmeVZKUWxvVWFqbTQvK0JDd0lQOWsw?=
 =?utf-8?B?Wkw2TllNbm54ZUMrZktrQTBoNFphUnBrem9Hb2lMbVBsb0tzR3JnT2JKUHVa?=
 =?utf-8?B?eWFTM2RBbk1wYTBGTVlTUnQ4akdLTDNqejdNa1U2NFY4UkRpRFQ5V21lMUJZ?=
 =?utf-8?B?VUVGWjFXcjdNZ21Rd08rQlBWd2RHMnF2Zm9LWWZWOUZxOGR6cHFHMWR2a1g4?=
 =?utf-8?B?aDhlSUw0cVR3VHNpYnpQQ2g3MTBiVUlyRkEvWndFelBRUjhoUlk5NlJaK3h4?=
 =?utf-8?B?d25pMVhOYmhxL25nSDlpTk5WVkFnVVNVYUZSMkFPSEpGcXNXQ1lqWExGeFNU?=
 =?utf-8?B?ZlpWYTFLekIrM3JZdkdack0za1NXVDlmMDhCallmRW1OTzNCamRtUDkraExp?=
 =?utf-8?B?eG00c1VLVk5laEM4QWRtSVlvSThjODZLWEFnNDZZd203cHMzQ2piTHFsUE5L?=
 =?utf-8?B?N3JXdTF1T3NiL2UvZWdwdWphK3c5elBQYXkrckFOUTRHcTYvS3RVcDlWUDlZ?=
 =?utf-8?B?QjI5QnZIVGVUM3RZcTV1citVZlNjOWpvS2k1QkcxdjVmdGd3Zi9tMDAxbjV5?=
 =?utf-8?B?Wi84Zy9TNjl0Y3JJY3pHZENaOTNwREZmWVhkYUVGdExBZGcyOHVZRGZTY29u?=
 =?utf-8?B?eFUraUtrL3orYkpheUoveDhYZG9uR1lmaFlKZVBqdDFxc1pzUlZCZjFVemNU?=
 =?utf-8?B?UUpKeG51MlIyRUlhL0MrVSt2Wkw0RUIycDFhNFVHTGlzQ2p0Z05iZHlJb3Jr?=
 =?utf-8?B?MVdlQ2YwQ1ZMdkc0VVZyaEpEc3Ixb3ZIWWJYQVVlNk10TkhQSW9NSnlMTFJM?=
 =?utf-8?B?ck1lWTFFUG5YcWpFSW9qNWVYRkw4UW5TVXFrdkZpaWhvZDZ3ZmpJanA1d1o0?=
 =?utf-8?B?Uzd0d3lZajdWb2w0ZHQ0TXk5ZTFjYUFSZHFhbERrTDkxTnNISXRPd0FETFNp?=
 =?utf-8?B?cEZCb1ZuZHppTVlXbHdOZnBwR25Qd2FOTVRYUTNNTlJXZDRtdzlBZXQ5N2FO?=
 =?utf-8?B?MU5BSktkMlMrZjMzTUQzcUtOMHRDT3Zxc2hINStkSmVMb1psQTlCRXcxc2Zk?=
 =?utf-8?B?MHZLb1dKQ2dQUUFTWkRyWm8rZTA3dDV5M3V2dG93aVJpS2hvK21zN0owbXRT?=
 =?utf-8?Q?+RXiNNSTQcTmX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhxNVFqajd6dE1PWnhhVDFxdWFFM2pSQSsvQ2Z0M1c4OE9qOVhSZFNjVTlX?=
 =?utf-8?B?d3NueUFFdWNab1VlMnhXUHRzVlhKMXhLbmprbU9FaEw0TnJydFczMFhjd2tx?=
 =?utf-8?B?WVcwYVlNc3A5Y2E1dDFMWlpVTVk3UXBHaEQ4M1V0VCtKOFFDVCtTWGswd2Yz?=
 =?utf-8?B?N2ZTaVdNOXJ3azRONnkxU3ZjbmdWeXdpbzhXbnYvbDZGNXl1Zk5LREFFZEZq?=
 =?utf-8?B?SEdITXVTOTNUVnJiTzJoWW9vVnRqaHUwNW44bWlSRTR2RmFiSGcwcFI5Wlc5?=
 =?utf-8?B?MHVLSVE0R29EYkRBY2hnbS9ld2lBRFhndkMrMWNaNkZmSk9saFU5QklzZlhw?=
 =?utf-8?B?a3NWMEpVNm5pWFB5cWYrcllGVnZNSUtmdnhkajBRM1dYc09lYTVyamt0U29V?=
 =?utf-8?B?a0tPOGJobjNVcmVqRzg0dHRyamxNSXRsRzFnbnVnaWNMODc1andKN004eGwv?=
 =?utf-8?B?cisrSis0S2l0OEswNG50amlhWnM3bGZ5Nzg2a21laVBsR0ptQmhDZ2d5ZTJI?=
 =?utf-8?B?Um5tR0xxN0FBOEY4cWV1OU9scVI4TGtpWjkxSzhScld5ZzhXMjFReGE4RE13?=
 =?utf-8?B?VlQzaUpVTDRDaExSd0hseDZESTR2eDhEelBSZHByM285NDI5WkIrRStmWmox?=
 =?utf-8?B?ck5PdWV3aDFaU1J2T21Fb2JucW1LNmZRY09yYmJhSU5pWDRZTTZDeTY4N0hu?=
 =?utf-8?B?ZnRLaUROdWNzc1VtQTJ0VVp6U0xuaEY2TUtaZkY5aVNjd0VTVUk4N3V4Qm1y?=
 =?utf-8?B?WDI5dThTeVkycW5oVlo2NU5XWXV5Vndqblh6NWVrdGpyaXliQnczRUVHTTFh?=
 =?utf-8?B?MnRaOGl0TVE0K3ljRmxoWUcwendzQzRZUXd0OWxKRExuUXBxOXhDLzlrL0Vx?=
 =?utf-8?B?UWlMQXM1K21kdG9tT1BjSlEyOUsva3pVQmtoS0NPTGM3aUdpR3M4NGl1aDUv?=
 =?utf-8?B?MWFOcWRLTEhRaklyNWVxSDR1SzVoL2tLRlVjNE9tTEF0RllyM2Fvd09JSWJ3?=
 =?utf-8?B?ZHFjL3REZTczMTIxelMwZGNwaUpPWitHTmFCbUN4U0drREZGMTdjb0xXS0c2?=
 =?utf-8?B?T0ZGOG5aaHVnK1YyV05zaXV3dTZGTE53NUxxdzluYW1jRUZ3dHpsditaclI5?=
 =?utf-8?B?MDZFS08yaGhibVVpdlpJeCtady9WRXMxdCtmclRldW8wVEV3RUxmLzhodit0?=
 =?utf-8?B?Nlc4T1c3c2xnNzFYMXY1NU1jTmpxNzNXYVlQVXA3UVdONWdncU84NDZ4N2NV?=
 =?utf-8?B?RGpyeEtwbEYvR2xXcXNEZlZZZ0QyRmRMU1FLVHcvOVVMWVhWZWJ0VTArRWJO?=
 =?utf-8?B?dndOZHYrcW1TK0dLdW9mTWxFdnNWd1JLcnZHQVdCb0RKNDhXYzRrNVoyYk5m?=
 =?utf-8?B?Tkt1QnpqUzhOZ0F0blZxVFJGZkJoSzVkNDk5ZTA5OTVHbXNLZkROV3VjTkFQ?=
 =?utf-8?B?bml4RXRDRFFjaUFpODgvelIySTV2V1dBTEw4d0I1RmRkVzlOZWVZU3U5NHNU?=
 =?utf-8?B?QVJJUXlYOWlQdGRTbzZBV0FtalNkd0o0S3lFTjY2b2lTRld5eHNHMGs4bVNN?=
 =?utf-8?B?TkZBcjFGQ1RXVmVvWlNRTkM4OUJsS0Zubk5LMlJXT1UwdzljZkEwTHI3QWVo?=
 =?utf-8?B?bUxHaHB0aE1XMU9JNUlRV2RnMlE3ZlhLamtoTFUydDdvSGdQL1RxbnlFcFRQ?=
 =?utf-8?B?OUh5a2hYRUsyeVdjS1k4em5mbHNqeHRWTW1XK25XTm5kSVJPZDZCRjRrUUNB?=
 =?utf-8?B?SFZHbWFsSnYvOGdiSTZoZStCREdDTnBNa1RjRWYwcVZGQ3NvUUc2WjJSQ0tr?=
 =?utf-8?B?KzNjRXBRVXo4K0lmZmJsYk9MNnAySGxMclBGWXNBWENQRGV2eW13YzhRRjdH?=
 =?utf-8?B?Z3pvWUhEcGFIWUg4UTBpR3RBb1RrUUI2VUFKYnV1WmtCZlpCU1FUNUtvY2tz?=
 =?utf-8?B?cDR5MHhNRlhMalQ2dzlDUDZQTzZ2QzdjWjJVQmUvTTRCTU03R3ExVHE0bG5B?=
 =?utf-8?B?NXR2SVlVSVh4cXMyS2NJdE1JVldqRHdjNjcrd2wxcUpiVmtibEFMT043ejla?=
 =?utf-8?B?WDNUd0N6YVl4bE5IWERHZTJmckF6UFRqVktXQzExelh0NnhQT2FyUmNMYzdt?=
 =?utf-8?Q?WJcliiD+DSX9fNtElaIsdU7Qu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fa82ef-c616-467d-f2e8-08dd46bd69a1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:49:09.3766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpiGPkRzTQFrDIIS9UrE1PYTZfVldbveQZH8MNWBFg8h9shfOuDf+5vFIegKLhqjkQaovDSUsD2Iwli9r8i5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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

--------------8athN1xKtvT0msGbVifwJv1V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> To properly handle multiple GPUs.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index edbcb11c382a2..8d8b39e6d197a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -182,7 +182,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
>   		enc_major = fw_check;
>   		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
>   		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> -		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
> +		dev_info(adev->dev,
> +			 "Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
>   			 enc_major, enc_minor, dec_ver, vep, fw_rev);
>   	} else {
>   		unsigned int version_major, version_minor, family_id;
> @@ -190,7 +191,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
>   		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
>   		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
>   		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
> -		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
> +		dev_info(adev->dev, "Found VCN firmware Version: %u.%u Family ID: %u\n",
>   			 version_major, version_minor, family_id);
>   	}
>   
--------------8athN1xKtvT0msGbVifwJv1V
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-45-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">To properly handle multiple GPUs.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-45-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index edbcb11c382a2..8d8b39e6d197a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -182,7 +182,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		enc_major = fw_check;
 		dec_ver = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 24) &amp; 0xf;
 		vep = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 28) &amp; 0xf;
-		DRM_INFO(&quot;Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n&quot;,
+		dev_info(adev-&gt;dev,
+			 &quot;Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n&quot;,
 			 enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
 		unsigned int version_major, version_minor, family_id;
@@ -190,7 +191,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		family_id = le32_to_cpu(hdr-&gt;ucode_version) &amp; 0xff;
 		version_major = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 24) &amp; 0xff;
 		version_minor = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 8) &amp; 0xff;
-		DRM_INFO(&quot;Found VCN firmware Version: %u.%u Family ID: %u\n&quot;,
+		dev_info(adev-&gt;dev, &quot;Found VCN firmware Version: %u.%u Family ID: %u\n&quot;,
 			 version_major, version_minor, family_id);
 	}
 
</pre>
    </blockquote>
  </body>
</html>

--------------8athN1xKtvT0msGbVifwJv1V--
