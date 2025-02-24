Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2533DC021A6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A982710E3E3;
	Mon, 24 Feb 2025 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OQwk6Q8C";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5720310E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 04:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncvIoqdS6+3vfiOmZdA1iNB86Vz6ikfO/Kp0UzHJQp/PHxoHHF9xaKm1fJJp5tzcSSP5sToJgouDmN80i6ypemQpUuJkgnypy7xOwpcJEXRS+VCq2GwvKNCz1Jg5Saf1ul7QP0k76F/XPio0EdAzXhYjbI+fafB+GpPBIotLAHVSSv6KOQ7oppKbWOAlznIiGBFG0U8BPiEdvAYB6blj4QEfBFMRYZoTStx4Z/7jJsjumsCYvXPbOccnqZzLs5p/5QCNRveYzTeeYkIBA8qkShwX+K1zX3ZmEJG3DcW48Pm1JcOnLlZrpe6akTBeybjuY1UhsCmFLAVM+UEKUaFrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXFwKgzFfWMpSqmwKCgHGIFD4aM//kw3TXkH7uG46ZQ=;
 b=G2jII4GyCKKeQGKDFdyIHTvQjXe//GkEKswxz55l+6zt+wvApZHeZjGstl9OlyrTu+raylEhH+qEKvJieXyX6Uw6wCnTraMGnU9jorRezbVgd2qHaEyN9h6S6LLItQPUAQD0Jg3TaiYSrlSQMRgSyvSqpToKllf7zkFAK64FoPbEkCdLiNERqbSVpcnorUvFY5T4G57/0013XXLEot7vjcmRCp5PxSwz1UG9hdfec2a9gVMK8YbH55HE++D+Z4T1jLvVMWknYpTS/NaqLrrFmz5GTTNTFicebggM4p+togdTyyI+wzq0cRTexvDw8jP20R9fAL79ahO3ZUQe4ryfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXFwKgzFfWMpSqmwKCgHGIFD4aM//kw3TXkH7uG46ZQ=;
 b=OQwk6Q8CObod6xn7zc6gc1VMxZ0amHG4L1sg3xUBytYK58IP4QL7YK2J2drMG5OlvXagWvu52lPlzYz/+67C3dgo5S41q2ZPXMeLYXi39tTW/trMTWkNrjl6CZezrgXn40DTX4wjl2/qgL/39i0YD+0nfiPllnjCwj7DtnxzaQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 04:07:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 04:07:14 +0000
Message-ID: <2ec2f11f-2f82-4db5-be2a-2c597717b141@amd.com>
Date: Mon, 24 Feb 2025 09:37:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250221182359.2777228-1-jonathan.kim@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250221182359.2777228-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da7302b-bfae-4701-5cba-08dd5488b82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUFENzBMKzJWZjlsKzJONTcwbjhkbHFCemY4UWprVDA5blMvVXVmL2ZJaWIx?=
 =?utf-8?B?Y05ENldaTHhwaWFhUjRIY3YxVlhncDZVaitYQUxMNzRQMVFMNTFhbE5SaGxl?=
 =?utf-8?B?QTZsM2lMbzlMN2YraXI2WDdOSUhYVEttSjRPQXFuU1d2cWVKb1BOcXBZVXRX?=
 =?utf-8?B?NlRCOWtBMXJaL2FPZ25XcEtmcWFIVnp2ZXArQUdQTXF0NzlpWThpNEFOSGZK?=
 =?utf-8?B?Q1ZaT0N5Uk0yUHFiWXNSaFZ5U2lsS1YyTGlJUk8ra0ZwbDd4bXJxY1pQRHVM?=
 =?utf-8?B?VFROYTJZcHhHem1SeUpFeVp3VTBJSCttMVI4ZWs0V21GaGxVR05QS3IrQ3hs?=
 =?utf-8?B?OUV2b1dPZW1jNXk4TzRhbVRMRitrS0JPY1RnMVpSVmhjOHlqMFQwOU0vRmtE?=
 =?utf-8?B?enBlZE0za0M5T29DK3crREE4YzNkVWlwQ282ZjNSR3VoZXI5WGdiUGNmaGZa?=
 =?utf-8?B?SkFDR21KeTk5V3FHSExKWlgvY0RHb1F4cTJBbkpKTmVQOHIrNW92d1ltMWNT?=
 =?utf-8?B?bUxpbFBpQURTY1NqSWgrTHdSYWY5SHYxMkNmdGRmL1JpU2k4VFZNbDIvN3py?=
 =?utf-8?B?eGdpREhZSDZLWlB1d3dmV0gzdW9wYXVoQnlFRHlvZUZVSC9IMUc5U3NEbTk3?=
 =?utf-8?B?OHkzQWdWWFdkNTFTVzNNb255dXNPNXc0NlR2M3lrUXNkYkdoU2N5ejJkaG1k?=
 =?utf-8?B?MFNUeE5SQ1VtNHQxNy9teXVLQVBpS3dJUnpscjdrd3VOSlhqZ1djeWN5aW1E?=
 =?utf-8?B?SG1tZTAwcjVHb1UwbHRyR3BBNVBzNWpqUUhBdXZ3bTdIYUZWZkpZNkdkTDYx?=
 =?utf-8?B?cExPOWxSL2NFQ0ZwYitheHhXRG00Um5sdjZ6aGw3OXYwQStwR1FWQ2F4TDJs?=
 =?utf-8?B?VjZDTGVZUmJMU3ZNdkw4MGlaVEZzRWNKamZpQ0QvL1VhVEJsaUxqQXp3VlFF?=
 =?utf-8?B?Z0Fwa3R3WUovWWVvWkl6ZUVPb2xhanZWTWhEUW81T1h2cUl3Yi9hZW5Cenl1?=
 =?utf-8?B?WlF1L2lUYkx2TjZ1MXBDd3FaSTNvWG5ldUtMMTdicGRja3huOU1XekplTXpW?=
 =?utf-8?B?L3h0VEJwY3dwMTdndS9FQ3ZWcFp3UFV3bWszV3B4emN3YTN1Smw5NUN5d2Zy?=
 =?utf-8?B?RmhoSWxqRnBMSS8waEFpdWZLVGhNOTN6OFhlYXZ3NkpkTzlXL3d6UmtmQXZm?=
 =?utf-8?B?ODVyWUh4TE10ZkNGaGp5dWEwU0MxRnV0bEZqdGZlc1liT0FreTRHdDErMlpU?=
 =?utf-8?B?Z3BieWhoZmZoTGxIWElqT2RPcFhyT3RvRFNLWnhuQmNLRUpCb0QvVDVyVnhU?=
 =?utf-8?B?d2tyeE1hbytqeTgrZmJPMzY3WXR0d2hHRGtjaFUwU3k2bmVhMmZvNUxyaHNp?=
 =?utf-8?B?THBUMG5PcE0yR3lFNXFZM296dlVqemxOVTBWUGdaSHVlT3pGc0dzTmw0YlJR?=
 =?utf-8?B?czFZN2dCaG8rcFdDRmhURnFsdEVDNEJqT1ZmOHVra0FpcUVsUjZ2VUtHVUtt?=
 =?utf-8?B?R1BmTWxzV1V5UXRseWNoS0cxdCtoeEJLbloyd0VxN05heHQ1VVdJazZ6cEkw?=
 =?utf-8?B?Y2ZLSVcyTlNGaFZKUXNXTXRtU3ZWMFFKQyt5azhrNnZON2k1am5iWkZML2VP?=
 =?utf-8?B?cUpOcjEzNm0zQ1gzdkJnY1FHSkhETnhXOGNsa3JrVXhuQWhucWZTTVFXcDB4?=
 =?utf-8?B?RmIrclhoanp4N2FIQ3pxK3E4Rjc4Tm9vQ0hsZWczOTZWYkgvUFpid2VtUUJO?=
 =?utf-8?B?Wkpwd2NFQzh0S3llU1VVdXIzY0YzUkw4M1ZiN2lSNmpTbGdDaVZsakk3bUtE?=
 =?utf-8?B?SU5EelNnZ2JseTEyZFNGZ1ZsMkZPWkk5TWV0eW1ocXJncFRtdWxOeEJJSHNr?=
 =?utf-8?Q?ACHejR1Iei/SA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTF1Y1orN2RwODNWdVEzS0hrQUwwTUZsWnJFQk5yUTVjTTBoa1Vrc2hnN2ZB?=
 =?utf-8?B?UlIwMHJjYlBOT0pSaVAzaFNzd290Q3l6dU9PblF3SytxU0d0Q3huUzdKYjl6?=
 =?utf-8?B?VVFkekdCNWRENGxYWVV4Tkt0SVJLYVd6RTN1Mm1HN1FvSXBLMEtzS3VRSlVJ?=
 =?utf-8?B?NEJudkZZTG0zVFRrbno3N2ZlL25xa0l5eVVKWDc1T3d2dUF5WnZxdS9mckc5?=
 =?utf-8?B?cllwUllaYUxOUjJSRVR0M2JBd3hBVitjQm40Z2dleENpSUNaclBTY1R1UXF4?=
 =?utf-8?B?dkc3K25ZRjZnRjdWbTRwaWd3RFMwUmNsTEp2YWpyOU1oK3U1ZlJGSlU2U3Ro?=
 =?utf-8?B?SEpSaXVXdzRqbm5UVXJ5aHRpbFJwQ1J1QlBhQ29wODc3M0p3ekQ1QS8wNEJq?=
 =?utf-8?B?TTRlbWdJRVg4MTRHOC8zVUJ4MVRRSk45SW1ybklXSkxIdkhkZE1wbGo1anFo?=
 =?utf-8?B?dy92ZEExdzRzZUJld1ZTMVhTOGlKSURGZDY2ZGJFQVFLbG5PWUl1UFZ4QkdV?=
 =?utf-8?B?ajhZVm9VYmF2WXh6MVVnaFpGVGMzZUtSUU9GTzNnMXpVZFlxbnk4MlBPMzYx?=
 =?utf-8?B?a3BBbkU1bVErZWpNUEYzWmRqV2ZMdk51Qngra3YrekpuMndZNzNFSUxyQ2Uv?=
 =?utf-8?B?THRLZGt0YlFVdFkzZzd2ZFpkTnZZWUx1WUh5eGZiOTZPY1dOTVZoTHIxOU9M?=
 =?utf-8?B?NTdLWnU5aVhUUlF3NGFHZ283anRrQTdvSXNwNW8yUjBobXJRVWQ1anBYbWVB?=
 =?utf-8?B?WmczNFdiM0VianQ5WlpRN2Q2eUZQKzRwcUtsZWhQazMwWS9sUVhrZ2xaWFNi?=
 =?utf-8?B?bEZudGZPMWFmbjFweWwyMzBERDZDSzJCSkZnU2dySXFicUVtbVR4a2pQN0tL?=
 =?utf-8?B?Q01OMm1KeUQwN1FsRzZlbEwvSW5qZG00aHFOZ0VxSVRDWFJzbTVVTUpQeStX?=
 =?utf-8?B?L2E4RXhxZWJldGtNZE9WZE1OTmtCV215b2ttczJIYllQNFlsV1daMHFOOU1K?=
 =?utf-8?B?aWJLeUxTVHZyRkoybCtCMStlZ2tLN3Nybm9aeHh2RExkYlJGa1JQTHhEUlRM?=
 =?utf-8?B?VHd3ZWZxV1o5M0tzeVN1L2E3eHpwNHhsREhGZnhIem1aWDJZQVFGa2IvQTh2?=
 =?utf-8?B?aFl0eEQ4NHBlOUhsSDQ5ZFpGcDJCbkg0eU9abW82aFY4V3ZHTmd6bng2NHUv?=
 =?utf-8?B?a21mNy8ya01obVAzNWpLRHJwYkFKS3c2TE9vaWlVSW85Z0FTQ0JRakg5bk9v?=
 =?utf-8?B?U29DWnJOZGNLRkh2eUppMzh1L0RIV0RwNm50YnNVUUNwSTY0bTY0eitPTVhN?=
 =?utf-8?B?MEhsUlV3VG9XT0VhdHF0ejI4YXdtVzFJTFZXTmFCZXRaaHhzWkF4cjF6ZG55?=
 =?utf-8?B?dlpaVC9nZXo0NHI0SEp3RStwMytqZ1Y5Zzk1bWtVbk5aQWU3RnFraFRVaXB5?=
 =?utf-8?B?WDNCZW82Z1EzNjRMY1VMM0g3SUhFdFh0aDFiVFhHeHhKRTBMZm5iNDV0ZXJR?=
 =?utf-8?B?V0tLeVpCT2w1elF3Z3liZnBsTlBPUFdqdnNvWitDSExzNjN1STlnNnZyM2Fo?=
 =?utf-8?B?cUIwTGtrNnJwWWxzbmkwa291eTB6SDdlNnNqNmFBWDgwRkowa1h5MjN1RjRU?=
 =?utf-8?B?SjdnVlJDSlRESmtqYmt5OTkrSDZRY1BpU2g3RkFISk1tZFp4ZHVYSHRVUjVZ?=
 =?utf-8?B?bjhPNGtKZTUrcGMrNVh4YUxXbDh3OVVXVlliUThkbmJtNHhTNVBmajVuMXRY?=
 =?utf-8?B?YUpRbG5HYkJJUzhzMEsrckxOODJ1TXExamJBNi9FU0hhdktsMXdYdzVrcWty?=
 =?utf-8?B?Q21LTU9sVzBweGRHc0dpUGRQVmRRZ24vKzBWelptMzF1alBnbDhxMWxmbmRm?=
 =?utf-8?B?dDRpVUhxYUFONnhwOEF4aWROS3lWQlFYTTc2aDRtYU9IZDUxMElldEs1OG1w?=
 =?utf-8?B?ZnQ5b0hVQjBmU2g0RmQrUGlWV05hNm5Nb1kvNjJQNWhzK0tYblJSNy9GYndw?=
 =?utf-8?B?R3JBZWNFdUdwZDBPbVcxQzlzZHp6eGNPVTdkR0o5aGFxNFZ1R2dnVUl3eURr?=
 =?utf-8?B?QzNKVXNsOFhUK1UzVTIxVVo4QlpiYzJRemh1Z0RYYWlET1FiS2ZYcnI5L3pB?=
 =?utf-8?Q?q4MDQvENN4TsAl1ijwL2Gz0NG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da7302b-bfae-4701-5cba-08dd5488b82e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 04:07:14.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEqHQul3nTOr3GVbf/AVj6deabjOFCVYBaPUhp0j86yGwgLcmbbHnfAOf8ksPO/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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



On 2/21/2025 11:53 PM, Jonathan Kim wrote:
> Deprecate KFD XGMI peer info calls in favour of calling directly from
> simplified XGMI peer info functions.
> 
> v2: generalize bandwidth interface to return range in one call
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 58 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 24 +++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 27 ++++++----
>  5 files changed, 84 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 0312231b703e..4cec3a873995 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>  	return r;
>  }
>  
> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> -					  struct amdgpu_device *src)
> -{
> -	struct amdgpu_device *peer_adev = src;
> -	struct amdgpu_device *adev = dst;
> -	int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
> -
> -	if (ret < 0) {
> -		DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d and %d. ret = %d\n",
> -			adev->gmc.xgmi.physical_node_id,
> -			peer_adev->gmc.xgmi.physical_node_id, ret);
> -		ret = 0;
> -	}
> -	return  (uint8_t)ret;
> -}
> -
> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> -					    struct amdgpu_device *src,
> -					    bool is_min)
> -{
> -	struct amdgpu_device *adev = dst, *peer_adev;
> -	int num_links;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
> -		return 0;
> -
> -	if (src)
> -		peer_adev = src;
> -
> -	/* num links returns 0 for indirect peers since indirect route is unknown. */
> -	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
> -	if (num_links < 0) {
> -		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
> -			adev->gmc.xgmi.physical_node_id,
> -			peer_adev->gmc.xgmi.physical_node_id, num_links);
> -		num_links = 0;
> -	}
> -
> -	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
> -	return (num_links * 16 * 25000)/BITS_PER_BYTE;
> -}
> -
>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
>  {
>  	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 55d539967695..b6ca41859b53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -254,11 +254,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>  				  uint64_t *bo_size, void *metadata_buffer,
>  				  size_t buffer_size, uint32_t *metadata_size,
>  				  uint32_t *flags, int8_t *xcp_id);
> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> -					  struct amdgpu_device *src);
> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> -					    struct amdgpu_device *src,
> -					    bool is_min);
>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
>  int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
>  					uint32_t *payload);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index c98b6b35cfdf..a4545edfed8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -818,28 +818,66 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
>   * num_hops[2:0] = number of hops
>   */
>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev)
> +			       struct amdgpu_device *peer_adev)
>  {
>  	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>  	uint8_t num_hops_mask = 0x7;
>  	int i;
>  
> +	if (!adev->gmc.xgmi.supported)
> +		return 0;
> +
>  	for (i = 0 ; i < top->num_nodes; ++i)
>  		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>  			return top->nodes[i].num_hops & num_hops_mask;
> -	return	-EINVAL;
> +
> +	dev_err(adev->dev, "Failed to get xgmi hops count for peer %d.\n",
> +		peer_adev->gmc.xgmi.physical_node_id);
> +
> +	return 0;
>  }
>  
> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev)
> +int amdgpu_xgmi_get_bandwidth(struct amdgpu_device *adev, struct amdgpu_device *peer_adev,
> +			      enum amdgpu_xgmi_bw_mode bw_mode, enum amdgpu_xgmi_bw_unit bw_unit,
> +			      uint32_t *min_bw, uint32_t *max_bw)
>  {
> -	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
> -	int i;
> +	bool peer_mode = bw_mode == AMDGPU_XGMI_BW_MODE_PER_PEER;
> +	int unit_scale = bw_unit == AMDGPU_XGMI_BW_UNIT_MBYTES ? 1000 : 1;
> +	int speed = 25, num_lanes = 16, num_links = !peer_mode ? 1 : -1;
>  
> -	for (i = 0 ; i < top->num_nodes; ++i)
> -		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
> -			return top->nodes[i].num_links;
> -	return	-EINVAL;
> +	*min_bw = 0;
> +	*max_bw = 0;

Better to do a NULL check also.

With that change,

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +
> +	if (!adev->gmc.xgmi.supported)
> +		return -ENODATA;
> +
> +	if (peer_mode && !peer_adev)
> +		return -EINVAL;
> +
> +	if (peer_mode) {
> +		struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
> +		int i;
> +
> +		for (i = 0 ; i < top->num_nodes; ++i) {
> +			if (top->nodes[i].node_id != peer_adev->gmc.xgmi.node_id)
> +				continue;
> +
> +			num_links =  top->nodes[i].num_links;
> +			break;
> +		}
> +	}
> +
> +	if (num_links == -1) {
> +		dev_err(adev->dev, "Failed to get number of xgmi links for peer %d.\n",
> +			peer_adev->gmc.xgmi.physical_node_id);
> +	} else if (num_links) {
> +		int per_link_bw = (speed * num_lanes * unit_scale)/BITS_PER_BYTE;
> +
> +		*min_bw = per_link_bw;
> +		*max_bw = num_links * per_link_bw;
> +	}
> +
> +	return 0;
>  }
>  
>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index d1282b4c6348..924da0bec509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -55,6 +55,22 @@ struct amdgpu_pcs_ras_field {
>  	uint32_t pcs_err_shift;
>  };
>  
> +/**
> + * Bandwidth range reporting comes in two modes.
> + *
> + * PER_LINK - range for any xgmi link
> + * PER_PEER - range of max of single xgmi link to max of multiple links based on source peer
> + */
> +enum amdgpu_xgmi_bw_mode {
> +	AMDGPU_XGMI_BW_MODE_PER_LINK = 0,
> +	AMDGPU_XGMI_BW_MODE_PER_PEER
> +};
> +
> +enum amdgpu_xgmi_bw_unit {
> +	AMDGPU_XGMI_BW_UNIT_GBYTES = 0,
> +	AMDGPU_XGMI_BW_UNIT_MBYTES
> +};
> +
>  extern struct amdgpu_xgmi_ras  xgmi_ras;
>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
>  void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
> @@ -62,10 +78,10 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
>  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev);
> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev);
> +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct amdgpu_device *peer_adev);
> +int amdgpu_xgmi_get_bandwidth(struct amdgpu_device *adev, struct amdgpu_device *peer_adev,
> +			      enum amdgpu_xgmi_bw_mode bw_mode, enum amdgpu_xgmi_bw_unit bw_unit,
> +			      uint32_t *min_bw, uint32_t *max_bw);
>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>  					struct amdgpu_device *peer_adev);
>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 70b3ae0b74fe..4a7180b46b71 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2133,9 +2133,6 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
>  		int mem_bw = 819200, weight = ext_cpu ? KFD_CRAT_XGMI_WEIGHT :
>  							KFD_CRAT_INTRA_SOCKET_WEIGHT;
> -		uint32_t bandwidth = ext_cpu ? amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> -							kdev->adev, NULL, true) : mem_bw;
> -
>  		/*
>  		 * with host gpu xgmi link, host can access gpu memory whether
>  		 * or not pcie bar type is large, so always create bidirectional
> @@ -2144,8 +2141,16 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
>  		sub_type_hdr->weight_xgmi = weight;
> -		sub_type_hdr->minimum_bandwidth_mbs = bandwidth;
> -		sub_type_hdr->maximum_bandwidth_mbs = bandwidth;
> +		if (ext_cpu) {
> +			amdgpu_xgmi_get_bandwidth(kdev->adev, NULL,
> +						  AMDGPU_XGMI_BW_MODE_PER_LINK,
> +						  AMDGPU_XGMI_BW_UNIT_MBYTES,
> +						  &sub_type_hdr->minimum_bandwidth_mbs,
> +						  &sub_type_hdr->maximum_bandwidth_mbs);
> +		} else {
> +			sub_type_hdr->minimum_bandwidth_mbs = mem_bw;
> +			sub_type_hdr->maximum_bandwidth_mbs = mem_bw;
> +		}
>  	} else {
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
>  		sub_type_hdr->minimum_bandwidth_mbs =
> @@ -2198,12 +2203,12 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
>  
>  	if (use_ta_info) {
>  		sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
> -			amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
> -		sub_type_hdr->maximum_bandwidth_mbs =
> -			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
> -							peer_kdev->adev, false);
> -		sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
> -			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
> +			amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev->adev);
> +		amdgpu_xgmi_get_bandwidth(kdev->adev, peer_kdev->adev,
> +					  AMDGPU_XGMI_BW_MODE_PER_PEER,
> +					  AMDGPU_XGMI_BW_UNIT_MBYTES,
> +					  &sub_type_hdr->minimum_bandwidth_mbs,
> +					  &sub_type_hdr->maximum_bandwidth_mbs);
>  	} else {
>  		bool is_single_hop = kdev->kfd == peer_kdev->kfd;
>  		int weight = is_single_hop ? KFD_CRAT_INTRA_SOCKET_WEIGHT :

