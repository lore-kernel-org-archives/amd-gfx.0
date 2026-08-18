Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B36C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 17:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C21410EC1E;
	Tue, 18 Aug 2026 17:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WevkUlR+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D5510EC0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 17:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gism2RESV78mAtK0DmRuxOwALxN10Po8SGt25V/CQvXIsrMGm1wrYFVlflW90B++QM4o6o/hVTBtBzLeDOEOmTFAzZj89YxGlzHFL1krANezID8LoZ0ndX1BjXtBj+b3YbTa9YxPRnNPZe/800drEr/jWEA9GraAmKhYfBaroQRE5SCvCa+Sa7xQTD7alaITMw1b013YJZbIpTvgg9b84+TdJUu7MmIy/xlfrXirm2cxkjBfN2ibUHs/34qE/U1t8ChY1fZa61+lCcRLexUwaDlGfpsvJ3u0tfgJkr97TgRgOILb78b4FZp7aNTfykxOKoUtC05ODvf8uUtd7FRs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCqeRChDwZXUVrET1dZ1y+vENGRh7x8yzT/i+KSnnaw=;
 b=a85SB2GNTjcnlzDLQJFcemwJROYqs/4KVa5LGxYAzdNRuuMXrh4ckWCDQGrs/GOBxVDkC+bBzLhanrtkCP2RNYR30FEz1rQgI7khZB0F2oV4V6u35uaSZI7GdvfoC1LYxVLYcS3NHCVtABVWUtXb5LMcbFiiPB9vOOUQ9/RrJfFlQPsELWXtLBA2YpfWVY2PeYy+QHXFv5YZ4JWjMnblB2ZMECAzDYQXNq9p6FSnz3LFfKlrvCi4A7Kjcp2yq7l2QjXwB5J4VZ7J8O7O+b/B65tNDiSGCA1sMvLWYSeEdulAvWmHhkfbLGuALxjJQ4/+WkOVvvPUIlsUxIejtGyVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCqeRChDwZXUVrET1dZ1y+vENGRh7x8yzT/i+KSnnaw=;
 b=WevkUlR+nT6+hVoN9G0j9YNS8SKQT/3wGAA5uYHOPhrNDzyiW+p2VANg4dZGKHt2Lgm9DZeaH4iNbzDQfEBmx4tePZGSggZcFa76XzzHs8vQE9EAgrtXv638/uYH0ZHhqp2gVwkobTZ/DIe5Eyhlenyi9Rg5qie9p1sMA5XflXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 17:19:32 +0000
Received: from PH7PR12MB7871.namprd12.prod.outlook.com
 ([fe80::f010:1753:ce4:6cc1]) by PH7PR12MB7871.namprd12.prod.outlook.com
 ([fe80::f010:1753:ce4:6cc1%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 17:19:32 +0000
Message-ID: <58a506b4-291d-4e69-9ddb-931e51ecb4ba@amd.com>
Date: Tue, 18 Aug 2026 13:18:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/kfd: Add CU occupancy support to GFX11
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260817194953.97887-1-david.belanger@amd.com>
 <CADnq5_NdV+ZX-gTS-fL8rSRX3AQAc1LRU-mS9nTUG3vPGuu1WQ@mail.gmail.com>
Content-Language: en-CA
From: "Belanger, David" <david.belanger@amd.com>
In-Reply-To: <CADnq5_NdV+ZX-gTS-fL8rSRX3AQAc1LRU-mS9nTUG3vPGuu1WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To PH7PR12MB7871.namprd12.prod.outlook.com
 (2603:10b6:510:27d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7871:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: c049aefd-e081-4a71-f6d3-08defd4cddfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4bVh88hfWJk11QbtKurQp4SnPb2Luss9KHKB1pMhS7r5UZz1AvbjlEPMYe7hqd1e6Xrfa+q6/Vk5+K64SyT9APTGJd9Kcc5EwSlIQ6pI75REP8gXDDt0wyQfDH5ww5NJp/9TVfK6+iRS4M6kjXqMfxWhNl+tprkvoGf035nWx34IdogFB2QYfOQZpaL/kV4geBG9P05ox640EppSB6+e18pcETZObjm6hV0mFFnk/t9/edRr+pqq/8vpMAi/phiMflIDhKUCOQ4Jy61t/bMH60r8cw8ZvDPjW1egWRiNXcITvohRuGcjzlhS7qpkk/thRiVBi/oRYm9wH/IEeJ7Vl3rrjHrtqIe4Iu/3y/tOC4Uw0i5rxvgg8Bs48jLy+UjHqLWaY2CUreRUkcep/3wvaQ44DYX11bhNdLfefV/pGjU7TAD3IQQcsnaN/QOmbfGoWHP2WPd6iqsvSiQ8bXZu/m9MP3V12hxdoH7WoxpyasCFIIT0iWtXYZTVeqRQ3X39J1y0kRc7j4kW3ygHG87a9kjm8ydi45eRP5thWCqIYpl+oM/dmD7vCzKT7z+VhsNLsLcLfwdVpSPVWzr4ObxgfGiL8acsjEXx0pxch3AqUS6wFwlMfeQSW/XCnL3mvnK9S0yqn3n33zaHfvgEMYkN8FE1BpjxSMXRE6RMWW+t5rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7871.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckc1M3ZsT08wYTNOd2c0QXBEUjY5bHE0VmlLRk01YzBYZGh0ZFNDd0FLNzNm?=
 =?utf-8?B?UnZSa1JlN3J1dHBWM3dxQ0NhcWxPSlpXRlgvZy9Xeno4Y1RiOVlJMXJoZVpa?=
 =?utf-8?B?eXEwVmJXWFpJdldpUkNONWkxbTk5OGR0Qk1MMHVlN0x5TVdvbFRwSmcyTWFY?=
 =?utf-8?B?UVBJRlFBZ2xtbmdDRThoOHM3Z3VBZWxsdlFZcERvd01ERDJTaERqaFA0VWxU?=
 =?utf-8?B?Mk1XYTNac3hIempGMHpHTlN0WnhlQjloQXpqT1hvdkZiQ0svYVdsdWJtNmEy?=
 =?utf-8?B?bzJuTGZiOTM1UDk3enE0RGl2a1VZNy93U2E4eVUrT2pGZEZrMHVBVmVEWkRP?=
 =?utf-8?B?aENocnZYUWVVeDhiRHZrVjFQY0RobTRZRytwbjhSUTBLRUJ5ejRWWTFoRyts?=
 =?utf-8?B?UmpDNDAvTEpIeld6dWgvbXFORnhZdzVoQkg1NlNlbTVlZ3Fad01JaXRMeUxt?=
 =?utf-8?B?V1pIS2wwT0xyQ3dCS3dZT3lCTC9WSzNzQ3ZacUhXQjZ4MTFvZmdIaENhVlBE?=
 =?utf-8?B?U1lETXRTREJMenF0ZmFrbEJUdEhEU2ErRVpDSCtid0dPUEljNnZMaHZqSjJ3?=
 =?utf-8?B?elVicE45SWw4UXhTeWl1K0JZdjZsR2JKbExXRXF5NmxuNUxobzhsckYyT3Rj?=
 =?utf-8?B?R3R3R0liNkNJSVk5aW9Cc0dvZ05YUHZFTkpDYmFYSENBUHpvZWh5MTA4NlY0?=
 =?utf-8?B?RGd3Qy9TdnFSUHFQMDRmdWJyWFNPb2tKMzJWejg3UTRBV0ZGN3JyalNDR2tL?=
 =?utf-8?B?Y3pUSjFNMGdTeUk1S3ZMMVN3M21pOVFxSitUNmJiblBaZ0tjUWY3aHlWR2VW?=
 =?utf-8?B?eHZOVXJSME9sL0tHQVRKVm0vQVVWeXZmZG9GTUFLWFhIbXloUElWQjF1S1Z5?=
 =?utf-8?B?NDdmeWdheVQzK1F1L3lHQlByWjBVbUo1bTR4UGdKY2V2TEhYYVdSUW9NN2pE?=
 =?utf-8?B?U1R5Zkk0UmZsdW9BbkorWm5MeHBnK3gvZDJnaksxcUF6YXRDUngwL2pzUWQ1?=
 =?utf-8?B?dnlyc0NSNUtTNCtHdmY1cDVIYUZHUzd6R2xwTVRCNlVzNUxpV0dUODdYOVZw?=
 =?utf-8?B?aXNKSEhRQllJcE5xKzM0bHlvaGJKUS9VMDBLRTh1NXpsTHA5aVErWnBqaTkx?=
 =?utf-8?B?SGxEUkRTcEhnSDdWRThlU3ByS3Bpd3AwK3VmQ2VDUUF3enp2R2JtT2FRWTR1?=
 =?utf-8?B?SUsvSzRwbWpiUS9POStsSVM4VUc5MnJOejR1S1huWkZha0MzMnFzTjZXKzFU?=
 =?utf-8?B?MXhWT2FoKzJjeHJwU1V4VW55cGRCMndLdXRKTWZzcVBXWUFLQ1Uzckh5TFNh?=
 =?utf-8?B?Slh2N05BWVpNaHdmbXJ0dXFGbk45ajJSZ2dTbWNlekovWTVCYjBqTGdaWXRp?=
 =?utf-8?B?N1BuOWdYU1AwWDZKSGtGeW1jbFM2WTdpNk5VclZMakJBNC9GZURwQjJ4dmtG?=
 =?utf-8?B?Q2tPaWgvREIrN2YwYlQ2eTJRbDVvbVRKbnVSN3F4SDVsemNnVFFxZHplL1Qr?=
 =?utf-8?B?ZVdteUhVZnVMQk1kOTBEZ3MyRkJXZ0JXblljc29hbUw5Yyt6ampKUG5USkpk?=
 =?utf-8?B?bnRtTWQyUGFOeFJ3S2RlVTlPVHczM2o4bjdjSThrb29mNmE1dDZYNkNRTXBV?=
 =?utf-8?B?bW9EbHc0NDJkb1hoMWlSQmhBTFR6ODh3TzhqTmZXVUttNkxnNG5rMDhFZGI5?=
 =?utf-8?B?YVZ6K0lHMWErUmF2SlYrNGJLTEFtMDIvUFQ1Ym9kMklpaGdmYWNDRldYc2dJ?=
 =?utf-8?B?emZTWXYvWVRmdWNZbkZqdlV2WjNKcDlvcFRMY0VaMVpwbWVqZTBhSk9HV3BZ?=
 =?utf-8?B?Qi9MdmN3WDZvd0t0UTVqT0hsbmVtT1hScDJDUUtxRzFMblJPVFpFWmdmV3pV?=
 =?utf-8?B?NFhXeFdYTDBIczFodWV2a1ZEbXZwMi9ORmI1KzhGUFdPelUvVXJlR25oNFBN?=
 =?utf-8?B?cUtpYVZWNzliTEF2eUMyQmlKMTB3RWVDUWZ1RWR3MHV3cTRiUmszc1F2NUc1?=
 =?utf-8?B?TXNLSVlNOFRuajhyREx0OE1tR05kNEg0VEEyRUlSR2RRSzZIQTdjcjhUUnoz?=
 =?utf-8?B?b3I4UFkyNWZEdDlHSEVZWUgyN0VxWUlnR0dKZUQxSFp0cjVqZkVlRWR5STlB?=
 =?utf-8?B?NzVsUm9RR0R4M2N3QlBtamxNNnJLZjArV3BoM2VUenZyd3EzZkxiQWE2UG1l?=
 =?utf-8?B?RllEbnV4Y1VDZzMxYVIxRk44YXVZVW9uVkN2NThSd21KdmwwajA2cURsQUY5?=
 =?utf-8?B?MG1VNGZTWXFWc0F1V3JQZTEzWGZTc1BVOXExeTNaZytSZXNVZWdUZk1kZ0JQ?=
 =?utf-8?Q?V+ApWfaZiiKurTmBkn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c049aefd-e081-4a71-f6d3-08defd4cddfb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7871.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:19:31.9154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJMrUkxdfFSuwOhK/6KKZ/nH+7XvHaiksstE/P35WJmv3AQbVteW4cMLYHhwAIvBauWRdYg3gKq+d3ZCye9nPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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



On 8/17/2026 11:37 PM, Alex Deucher wrote:
> On Mon, Aug 17, 2026 at 4:45 PM David Belanger <david.belanger@amd.com> wrote:
>>
>> Port changes from GFX9 to GFX11 mostly as-is.
>> Minor changes to register access code.
> 
> While you are at it, can you port this to gfx10 10 and 10.3 as well?
> 

Yes, I can.  I am working on the changes for GFX10/10.3.
They will be submitted as a separate patch.


>>
>> Assisted-by: Claude:Sonnet 4.6
>> Signed-off-by: David Belanger <david.belanger@amd.com>
>> ---
>>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    | 148 ++++++++++++++++++
>>  1 file changed, 148 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
>> index 724beb96ed1aa..46042f72741b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
>> @@ -807,6 +807,153 @@ static uint32_t kgd_gfx_v11_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
>>         return 0;
>>  }
>>
>> +static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
>> +{
>> +       mutex_lock(&adev->srbm_mutex);
>> +       mutex_lock(&adev->grbm_idx_mutex);
>> +
>> +}
>> +
>> +static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
>> +{
>> +       mutex_unlock(&adev->grbm_idx_mutex);
>> +       mutex_unlock(&adev->srbm_mutex);
>> +}
>> +
>> +/**
>> + * get_wave_count: Read device registers to get number of waves in flight for
>> + * a particular queue. The method also returns the doorbell offset associated
>> + * with the queue.
>> + *
>> + * @adev: Handle of device whose registers are to be read
>> + * @queue_idx: Index of queue in the queue-map bit-field
>> + * @queue_cnt: Stores the wave count and doorbell offset for an active queue
>> + * @inst: xcc's instance number on a multi-XCC setup
>> + */
>> +static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
>> +               struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
>> +{
>> +       int pipe_idx;
>> +       int queue_slot;
>> +       unsigned int reg_val;
>> +       unsigned int wave_cnt;
>> +       /*
>> +        * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
>> +        * parameters to read out waves in flight. Get VMID if there are
>> +        * non-zero waves in flight.
>> +        */
>> +       pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
>> +       queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
>> +       soc21_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
>> +       reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
>> +                                 regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
>> +       wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
>> +       if (wave_cnt != 0) {
>> +               queue_cnt->wave_cnt += wave_cnt;
>> +               queue_cnt->doorbell_off =
>> +                       (RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL) &
>> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
>> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
>> +       }
>> +}
>> +
>> +/**
>> + * kgd_gfx_v11_get_cu_occupancy: Reads relevant registers associated with each
>> + * shader engine and aggregates the number of waves that are in flight for the
>> + * process whose pasid is provided as a parameter. The process could have ZERO
>> + * or more queues running and submitting waves to compute units.
>> + *
>> + * @adev: Handle of device from which to get number of waves in flight
>> + * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offset
>> + *               for comparison later.
>> + * @max_waves_per_cu: Output parameter updated with maximum number of waves
>> + *                    possible per Compute Unit
>> + * @inst: xcc's instance number on a multi-XCC setup
>> + *
>> + * Note: It's possible that the device has too many queues (oversubscription)
>> + * in which case a VMID could be remapped to a different PASID. This could lead
>> + * to an inaccurate wave count. Following is a high-level sequence:
>> + *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
>> + *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
>> + * In the sequence above wave count obtained from time T1 will be incorrectly
>> + * lost or added to total wave count.
>> + *
>> + * The registers that provide the waves in flight are:
>> + *
>> + *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON if a
>> + *  queue is slotted, OFF if there is no queue. A process could have ZERO or
>> + *  more queues slotted and submitting waves to be run on compute units. Even
>> + *  when there is a queue it is possible there could be zero wave fronts, this
>> + *  can happen when queue is waiting on top-of-pipe events - e.g. waitRegMem
>> + *  command
>> + *
>> + *  For each bit that is ON from above:
>> + *
>> + *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
>> + *    number of waves that are in flight for the queue at specified index. The
>> + *    index ranges from 0 to 7.
>> + *
>> + *    If non-zero waves are in flight, store the corresponding doorbell offset
>> + *    of the queue, along with the wave count.
>> + *
>> + *    Determine if the queue belongs to the process by comparing the doorbell
>> + *    offset against the process's queues. If it matches, aggregate the wave
>> + *    count for the process.
>> + *
>> + *  Reading registers referenced above involves programming GRBM appropriately
>> + */
>> +static void kgd_gfx_v11_get_cu_occupancy(struct amdgpu_device *adev,
>> +                               struct kfd_cu_occupancy *cu_occupancy,
>> +                               int *max_waves_per_cu, uint32_t inst)
>> +{
>> +       int qidx;
>> +       int se_idx;
>> +       int se_cnt;
>> +       int queue_map;
>> +       int max_queue_cnt;
>> +       DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
>> +
>> +       lock_spi_csq_mutexes(adev);
>> +       soc21_grbm_select(adev, 1, 0, 0, 0);
>> +
>> +       /*
>> +        * Iterate through the shader engines and arrays of the device
>> +        * to get number of waves in flight
>> +        */
>> +       bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
>> +                         AMDGPU_MAX_QUEUES);
>> +       max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
>> +                       adev->gfx.mec.num_queue_per_pipe;
>> +       se_cnt = adev->gfx.config.max_shader_engines;
>> +       for (se_idx = 0; se_idx < se_cnt; se_idx++) {
>> +               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
>> +               queue_map = RREG32_SOC15(GC, 0,
>> +                                        regSPI_CSQ_WF_ACTIVE_STATUS);
>> +
>> +               for (qidx = 0; qidx < max_queue_cnt; qidx++) {
>> +                       /* Skip queues that are not associated with
>> +                        * compute functions
>> +                        */
>> +                       if (!test_bit(qidx, cp_queue_bitmap))
>> +                               continue;
>> +
>> +                       if (!(queue_map & (1 << qidx)))
>> +                               continue;
>> +
>> +                       /* Get number of waves in flight and aggregate them */
>> +                       get_wave_count(adev, qidx, &cu_occupancy[qidx], inst);
>> +               }
>> +       }
>> +
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
>> +       soc21_grbm_select(adev, 0, 0, 0, 0);
>> +       unlock_spi_csq_mutexes(adev);
>> +
> 
> I think you need to disallow gfxoff around the MMIO accesses unless
> that is already handled elsewhere.  Same comment on the gfx12
> implementation.

I am looking into it further.

AI suggestion is to wrap it in kfd_process.c before calling the hardware specific function:

amdgpu_gfx_off_ctrl(dev->adev, false);
dev->kfd2kgd->get_cu_occupancy(...);
amdgpu_gfx_off_ctrl(dev->adev, true);

If it makes sense, I could submit that as a separate patch (as common to all implementation, including the original gfx9 implemenation).

> 
> Alex
> 
>> +       /* Update the output parameters and return */
>> +       *max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
>> +                               adev->gfx.cu_info.max_waves_per_simd;
>> +}
>> +
>>  const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
>>         .program_sh_mem_settings = program_sh_mem_settings_v11,
>>         .set_pasid_vmid_mapping = set_pasid_vmid_mapping_v11,
>> @@ -832,5 +979,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
>>         .clear_address_watch = kgd_gfx_v11_clear_address_watch,
>>         .hqd_get_pq_addr = kgd_gfx_v11_hqd_get_pq_addr,
>>         .hqd_reset = kgd_gfx_v11_hqd_reset,
>> +       .get_cu_occupancy = kgd_gfx_v11_get_cu_occupancy,
>>         .hqd_sdma_get_doorbell = kgd_gfx_v11_hqd_sdma_get_doorbell
>>  };
>> --
>> 2.51.1
>>

