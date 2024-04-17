Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25741C001CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 16:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB68610F717;
	Wed, 17 Apr 2024 16:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HBStX2z5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9A111366B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 16:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyhlol/iI40u10q9aLpHMD2uQ/SE44g/qF1gTTGYbd1q9T2hAbCtn7NGMu1jiESZlqJkS1MiKGEMmLnKNrV1nfWL3mNysfUEm9LUrptTgtVMS+BSc7LMjmVglJqoo8VmfH7ykKEYBaeQLfzc2PWoVBk6am1adx87RIg7HowzxWzE1h0S2DMvfSO/1NE3rfbh52V3XYgVBTPbIdUF144BOiFbCwD9zzrFHGU/TSXrJ4basMHs1QSoWnvxVj5Qbk+VtAw6q9hPkyHujrLYXz3upplEUrm7Ygv/ubjeRWmSgf/a4sBn0TlgPDzwofbi+ve+jHG1LHN2rgSy0zkqrcBBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxE51G3PbCPl8/POyfcu6HSUDpu+NA9N+Vnxah3Z0Dg=;
 b=ZKBYc8wi+bE1sQ/yWzSFzlS1MFH4VQp0WqJI0hg7VMliBA7HOZxNjCqUeb0q+sGY3VJU2tK9Gmrt60e8RiUHPSTqz/o5QPUN/NeKr0QlGRTT1Wnu9966hVkcTRNXYFP8HyWpcBVLSc28+NRJTu+/RpmmwHO0cStFuevZuhQzAPjbjH5KAgODVfSjC1GRnf1TDhysW+rkjmV5wnVtbGXMQcaY5586GPG0Rz1BH+AbmBVios7X7Y3xS/X67RXNMGlrOAn8dwbs7ZB0oVKdqkqA+oLV9MBS61XKyoH+27onAyp66mU6oGYgv7TKHib5l3FzN68FTKS3qx9faifxlVb35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxE51G3PbCPl8/POyfcu6HSUDpu+NA9N+Vnxah3Z0Dg=;
 b=HBStX2z5Ct1apFvtzzR8TPAayBwrfMkpkn8O73zliOfAGAydM85sO/Kh3b1pf7749KbLNLDPpeXldnufEnPeivF5i1oS8Uy6jqdssl+f3qGwySz74a48ceF6HwZUaFVtiHwitPTnTG7ouFpIknYECmEjgY4Qoc1NdAgfboQ69YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:01:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:01:45 +0000
Message-ID: <fbf4f592-77db-4087-9dcb-3d9a49302164@amd.com>
Date: Wed, 17 Apr 2024 21:31:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] drm/amdgpu: add support of gfx10 register dump
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-2-sunil.khatri@amd.com>
 <CADnq5_MkYKO5Z3LBRdJsTO0+Wf+YWVgUONTt5Y1Lrm+6SXJfTQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MkYKO5Z3LBRdJsTO0+Wf+YWVgUONTt5Y1Lrm+6SXJfTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fea407-949c-4195-14d1-08dc5ef7adbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hA9lquylJNRW2GeyMFKp1t7RoVPlfF2ezZranN+Ot8pHtTnVs9ptYlMIFpLalCL/JOd7Op3cDC/hcXZgOfBwYaCKuJ+jY1ScAEebP5vLpQ+jjtiICnxA7PTRAzbIpr9UxCGZZSzhxhaIvEU9nqJnmWEPK2A3hrHdPBIeY5ZwPmd+yCAwlx8pTgCqdsArgVgCKw0Uh4rrkwRSU5lnqdxc/qgET/axsIYidlFvhUDvmit429H9xN+0QppELdy6cUXKNn745lXFqhpH1q4Lay87xji0DAybSXq2qRtBhf1QiKnipWpjuHVqNG3eMSk0Vjt8xgQdRC6nXDK/CHoXRsAnOtR3P1b8SS056Vrd4Od/OeyDTKBymnGGdHZ6ss3sWHjHUoUONVRzrjb03Bmx6jkMGe/Bxg86rsufDOoRIQoKwH5sDISM/W9u7gii4KBL5H5fUupeoE/fkmXXNtmYPWuIXSPlK3BLna1IneQ7fipt/GEDz5L1rMvCUDftjvVAaA6y8oyBPj+I9+Qajj7d39kbR655cH2IPxlrw7v60nbBytAktOKI3bibg+kbHOM1fiCJx3P615LxP90XqC/+Unc+nfkBi74HxL6YPJxk/TFW+EMELbkN7HKe4y4t5a4VPNRg85iCROKgLwfUEKBqlWn5rir4JWsL//+CUsRc5qympak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXh6bDlLUUF0Y285K0V6YS9weDNyRmI1SlZKQTR2UGFjcC84WmZKN2x1bnoy?=
 =?utf-8?B?YVh6a0hiMjY4Z0R6RFRHaEQweFdFS1lPYzk5S2ZwRUJmS2Y2NFlqcExIK0xD?=
 =?utf-8?B?ajFmbTR6NThycEdpNFk3TEdIQ2Y4N1g2NzRWVXpEZkRodFMrZHYrMCtnR3g4?=
 =?utf-8?B?NjNmRm1zRGdicTFnNC9TZUZFVEhORHB0WldDeWFBZEQxNU5jcFVHMWFSdXUw?=
 =?utf-8?B?UFJCS1hwc1NYam0zRTB1UWpSOXMwbTVnY1VjdHRLYU01eXVJWlVZUHpFNzRs?=
 =?utf-8?B?REpkeFRTUkVRUWlVT2NsaUZESnlpVVdVRjJndWpaRTRWVU5rYnNLeW93VmdL?=
 =?utf-8?B?UWROdmZzWTEwZVljRHF1dXV6UzJkVjNMYUV5NngwemR1cWZwR1ZnNERLVE9U?=
 =?utf-8?B?OTlKekNPcjlIUjFvbm04d2tmZWc5R0UzalFDNmJUYVJZb0Q4UzBlakZkT3VX?=
 =?utf-8?B?M2pXMjdkQVdLRjdicnFUQ0RmaEdFTkVBL1RSYjJrbWcrbVg0d1k5MkhjbElp?=
 =?utf-8?B?dUV1QnVsZnJtUDFvck83U0lVb1VwTDErd0c1VVUxWTFpRTJvUDllcEhIQ2Js?=
 =?utf-8?B?c1FUdU9MTjlTckhvWndPdmY2R09GdnRpekNtbHpiZ25aMkRCMFFyMThqR0U4?=
 =?utf-8?B?SHh3WVpBK1hOWnVnMTJIVm9NeG1FRGhlaTFnTkFENDQvamlJZDhiUnN3S2Jp?=
 =?utf-8?B?RlVIVG1HRXdlVmM1RFE3enMyUXl3eHc3YWtCVWc2NXhnMHlUdmQzeFpsRDZX?=
 =?utf-8?B?TVk2NDBNZ2xwR3ArTiswZnBvTGhVRDlnOXpUb29QcThSR3k2WUFkWklJS3o3?=
 =?utf-8?B?bW52Vndvc0NJb3NyeEFnaVFkb09VV1JySzg0MnNmUVZjdjNjZWhrTGxkQmVq?=
 =?utf-8?B?L2JTeStQTWRyU2Y2UUdHY0VqN28rdEVSaGRUS1htUlNkS05sbzlsNVhBVXVn?=
 =?utf-8?B?Wm5TRksrejJFSFU5cXljWmJmcnVTc21RWGhGaDQwU2hMNUJQWVNGcktaUU83?=
 =?utf-8?B?UFpJaFZlUWR4eHBVRWVWeUF1eHlITk5zK0J6ZzZTemZFbUpIcHhxNFJ3R1BZ?=
 =?utf-8?B?Wmd1a1NYSTlRVXlvcmJTOUZreTU0ZzZCZkU2SUJLZFA1ekQ3dnowZE12a2Q1?=
 =?utf-8?B?a1M3dnIzSEFpb1hUZWJ2WjhPK214Yk92UDdaL3ZDekM3OGpBTkdNMWtSTlU0?=
 =?utf-8?B?b20xVWxsWVN0YlVURmM0Y3E4N2xKSHVQcHFhMW9ObC80aHljNkF0SHI3TWxk?=
 =?utf-8?B?TjdhY3dxTTV3VWNxUHJ5SnE3UEZ4Q1JKd3k4eEJRU2hoTGR2ZG5ab2RId2VW?=
 =?utf-8?B?UTdWcENaUXJ2ajI5bEFWTXRJVXNMR2RjUnhBQ1h4RWp1bHpyVGZMaitPbERq?=
 =?utf-8?B?NGRhN2lGUTgxMitJTDhTVzcwbEI2VHZVRDQwQk9YbDNZMEo2TkZQV2pId0x6?=
 =?utf-8?B?UFcvRGpkTW9GZXRPamxudzlYY1k4bjdPT0hhL3RBR09VL200djl5U0FYSHRl?=
 =?utf-8?B?VjhpNlZUc1RBbXRTalpRcUtoSlhtMGhEUDJxM1VDSzZwQkRVcVRLRWQ5RjBG?=
 =?utf-8?B?U1l2cmo3aU5JTWU4cEdzaWY5ZXRDWFBOa0JwSTZUVnhraHFqR1J2d0F3c0J2?=
 =?utf-8?B?US9CM21sa3ZQZm9lMjZ4MDJwSzA0WTkyNjR5RjVxeWhCc0pDc2w2aFJVdFI1?=
 =?utf-8?B?OWRSa0RUMHY4akZiT3BUNHpxTG0wZ1poVDBrNFR3V3o0SUMyaGQ4aVBkVXVE?=
 =?utf-8?B?S3RUR2ZXYkpTSnQ2aDU5Z01GbFJWZW9DVVhLTkQwMWVYaitKRFZtMThKaG9E?=
 =?utf-8?B?YlJWNkkyMTJFWHN0K2NzSFBsaGVjeDFzeGVKMkRPbDZ4OTZPTHArYWVoY1hT?=
 =?utf-8?B?ZGE1R00zMUxQY0tUeVM1YzR2VEVPclJjdkRKYy9hc0ZSTHJzdW1mUUFmM1R0?=
 =?utf-8?B?bVZuUEozaXg4a0VGVWoxNTJ3ZnN6RmdaRG55NmxxU0RPcll4SisvRXVRcFdu?=
 =?utf-8?B?SHcvWE1IVDRVNzBXeVZoZjd2OWZ6VC9RTml0M0l4UytoeFZ2NDRiSE5YS1Bj?=
 =?utf-8?B?bk9jRUJ6N29EbDBkYzJGNUNSNHNhK1NrRk1pSWg3Vkczd1NyMTBUb3lKNStP?=
 =?utf-8?Q?nm4++QdIQMBjCgFhs6CJl95sI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fea407-949c-4195-14d1-08dc5ef7adbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:01:44.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAyqQXTYvImzQ/M1y785+3GCybPyB4YFw+GTdztSipMbw5xp3JfYbxS20Vd5qso1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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



On 4/17/2024 9:21 PM, Alex Deucher wrote:
> On Wed, Apr 17, 2024 at 5:38 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>
>> Adding gfx10 gc registers to be used for register
>> dump via devcoredump during a gpu reset.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 130 +++++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
>>  .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>  5 files changed, 155 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e0d7f4ee7e16..cac0ca64367b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -139,6 +139,14 @@ enum amdgpu_ss {
>>         AMDGPU_SS_DRV_UNLOAD
>>  };
>>
>> +struct amdgpu_hwip_reg_entry {
>> +       u32             hwip;
>> +       u32             inst;
>> +       u32             seg;
>> +       u32             reg_offset;
>> +       const char      *reg_name;
>> +};
>> +
>>  struct amdgpu_watchdog_timer {
>>         bool timeout_fatal_disable;
>>         uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 04a86dff71e6..64f197bbc866 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>>         uint32_t                        num_xcc_per_xcp;
>>         struct mutex                    partition_mutex;
>>         bool                            mcbp; /* mid command buffer preemption */
>> +
>> +       /* IP reg dump */
>> +       uint32_t                        *ip_dump;
>> +       uint32_t                        reg_count;
>>  };
>>
>>  struct amdgpu_gfx_ras_reg_entry {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index a0bc4196ff8b..4a54161f4837 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>  MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>  MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>
>> +static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS3),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HPD_STATUS0),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS_2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL0_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL0_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQG_UTCL0_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL0_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_CNTL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_3),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_4),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_GPM_STAT_2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SPP_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST)
>> +};
>> +
>>  static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
>> @@ -4490,6 +4583,22 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>>                              hw_prio, NULL);
>>  }
>>
>> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>> +{
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +       uint32_t *ptr;
>> +
>> +       ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>> +       if (ptr == NULL) {
>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>> +               adev->gfx.ip_dump = NULL;
>> +               adev->gfx.reg_count = 0;
>> +       } else {
>> +               adev->gfx.ip_dump = ptr;
>> +               adev->gfx.reg_count = reg_count;
>> +       }
>> +}
>> +
>>  static int gfx_v10_0_sw_init(void *handle)
>>  {
>>         int i, j, k, r, ring_id = 0;
>> @@ -4642,6 +4751,8 @@ static int gfx_v10_0_sw_init(void *handle)
>>
>>         gfx_v10_0_gpu_early_init(adev);
>>
>> +       gfx_v10_0_alloc_dump_mem(adev);
>> +
>>         return 0;
>>  }
>>
>> @@ -4694,6 +4805,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>>
>>         gfx_v10_0_free_microcode(adev);
>>
>> +       kfree(adev->gfx.ip_dump);
>> +
>>         return 0;
>>  }
>>
>> @@ -9154,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>  }
>>
>> +static void gfx_v10_ip_dump(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       uint32_t i;
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +
>> +       if (!adev->gfx.ip_dump)
>> +               return;
>> +
>> +       amdgpu_gfx_off_ctrl(adev, false);
>> +       for (i = 0; i < reg_count; i++)
>> +               adev->gfx.ip_dump[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));

This may cause a bigger hang, if PMFW is already hung (in that case
reset also won't work, but a dump is still useful). To be on the safer
side, there should be some sort of return value for gfx_off which should
be checked.

Thanks,
Lijo

>> +       amdgpu_gfx_off_ctrl(adev, true);
>> +}
>> +
>>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>         .name = "gfx_v10_0",
>>         .early_init = gfx_v10_0_early_init,
>> @@ -9170,7 +9298,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>         .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>         .set_powergating_state = gfx_v10_0_set_powergating_state,
>>         .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>> -       .dump_ip_state = NULL,
>> +       .dump_ip_state = gfx_v10_ip_dump,
>>  };
>>
>>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
>> index 1444b7765e4b..282584a48be0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
>> @@ -88,6 +88,8 @@ struct soc15_ras_field_entry {
>>  };
>>
>>  #define SOC15_REG_ENTRY(ip, inst, reg) ip##_HWIP, inst, reg##_BASE_IDX, reg
>> +#define SOC15_REG_ENTRY_STR(ip, inst, reg) \
>> +       { ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg }
>>
>>  #define SOC15_REG_ENTRY_OFFSET(entry)  (adev->reg_offset[entry.hwip][entry.inst][entry.seg] + entry.reg_offset)
>>
>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> index 4908044f7409..4c8e7fdb6976 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> @@ -4830,6 +4830,8 @@
>>  #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>>  #define mmGB_EDC_MODE                                                                                  0x1e1e
>>  #define mmGB_EDC_MODE_BASE_IDX                                                                         0
>> +#define mmCP_DEBUG                                                                                     0x1e1f
>> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>>  #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>>  #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>>  #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
>> @@ -7778,6 +7780,8 @@
>>  #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>>  #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>>  #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>>  #define mmCP_MES_GP0_LO                                                                                0x2843
>>  #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>>  #define mmCP_MES_GP0_HI                                                                                0x2844
>> @@ -9332,10 +9336,16 @@
>>  #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>>  #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>>  #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>>  #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>>  #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>>  #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>>  #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
>> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
>> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>>  #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>>  #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>>  #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
>> @@ -9720,6 +9730,8 @@
>>  #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>>  #define mmRLC_LB_CNTR_2                                                                                0x4de7
>>  #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>>  #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>>  #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>>  #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
>> --
>> 2.34.1
>>
