Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F1C6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 09:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5F360FEA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 09:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5F360FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9937F6EE0A;
	Thu, 22 Jul 2021 09:03:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD8A6EE0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 09:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6TvEcUvYcEl1jV5mrD9G4E1IaYrhmHoZrdl5mLKRkB1Q3zME97fF9aD7RmBm9pEhbFezilTs8C9rDLkGRNK+ZNtohkEEXMsnLsiaN/k/tX5i6TpdXFma76jkRqRIbixMPaG5NUT5osd00nz7B/Scbu474BqWGkqE+5ur/Eq2OzDARkHK2uIWRYNAkE9cn9zLpgsx7MyC1hZMjFgJ4YOJSGGMFkZr8UBS1UHjcYRuEsXovja1MHevnPd3zmn3HocFumxhOMLhbjYQcCiWdAPjWKSc3EMU1qzT/M9vUXx2D/YtLPiuz3iokC/Bq14DTwJ5oK1LbObvBsCiCOdXh8+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voHR6B4bX6kfMXTA3ptSI4cTnWiRJfTaXSiHCCfypB4=;
 b=jvzgltpx1PVpxu1S5Ki0fEUpIO9MSCWL1PPYX8vTBcXFQoLQaZWDgg9Kh7vKvNkAAPs+wvAw65aqDtYwq9XDINbj9OKZ/7bCVtQi75LmJlIjoZqVLOlZinQ3uN4QJnbgp3E6tC0KubA4xo6GSNb9tvhyrhFZqb5t2YVR6sgfV5w3a7XqoY04AIpCmj0MP74M71ks4LAbG4dKybDIBGHhLqthGkt3NtZ2QFAeWppxFhstgtbJtYBEj8/7VK7+8aLUN272UPJdp72PwXVvE7xIdU1obUDGAbz4oRRhRvDIRRFv6kKpWrdshM73nDshOM612VdVcbqCmbp96Nu62+fz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voHR6B4bX6kfMXTA3ptSI4cTnWiRJfTaXSiHCCfypB4=;
 b=vrxixexjIw93kgTqfa1taeAVZZiXkzIb2qiyNQzxHc7YxQlcw53cYdh73AlcyNPk+oxlKnDKDr8kvSGZlAJpq9oxPybN/crbYzNy0+FLjh3r5AsLKAbOXjTMZe40Kso6S7A9IKA2kKWzs3h81K1gC3bH9f/pWVeGsQZnBv1sqrU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.34; Thu, 22 Jul
 2021 09:03:33 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 09:03:33 +0000
Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210722032046.767094-1-evan.quan@amd.com>
 <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
 <DM6PR12MB261987F64682AB6A0A337A30E4E49@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <47ba61d1-d76e-b10f-acb6-fa25bb4c4d44@amd.com>
Date: Thu, 22 Jul 2021 14:33:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM6PR12MB261987F64682AB6A0A337A30E4E49@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 09:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8717663-48a5-47f1-c83f-08d94cef952d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB538010BD3025B7D2A9D3739597E49@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOMyUS/8xTuBIzIezx7ZSrwYoHZb1OQ224ipWjiTDXfBfZo3+OATuP0EFT/3CrN6GnbVD7jTocjmdBHQwocPhAwrShWoUczMODnhvvQKZoDvz592wwW5MKTPbw72vFp0fofSBJCt1qMnpaudbrrs8+WNWecHSN4NuyuGVuQNZgIdoGrlIYDjXEl4pTCBqCLQ9FEreq5r+EvsakDxU/FjrafYAHlk7Op2oU2DJ5ZVmqcn6Wnvam7yZy+UspveqfRLm/7P2DPLa6n83nV+kiJzlJHcZgUG5HyRDSCHgfUGU+4LmZe/GIYwn3W1FyxsX7sfkA5M265yHuIU7+vbIdIGLw0We26xmZd6BsjBbxdf9qk2CefOQK4UTyMjb4BXGj/wi4DGHWNxKvKTTnJxE0YDQNq1Da7OXu/uXo8ZS6VUnbmc/fGSaaJI5sIUCeDJ177AamWlhL2ferUWu7bPxEHJGxdWcxZgZjg05vVSyNy0DM8FSt6+5S/wHSzBmdAwzn5qZdweeM5dpPePT2rpsWlHA8RrD2wCyFyFtsnxLSgHb7ERzvjBQlBktBDKxPdSStWMYt44fpWG36z0k+OrhC4YiFTfL6sUtPU3jpgu5vgxc05MgBvGppuqomMjk+WXwUbydypFFPiSPVmJBMCCB7URX12a97foacpcZcd8jIronQ/fxIlIoDhpvdDdhvVQBORTDRfufm45O5ESIl5YgWS6QAEEeAzEbJgYGFFJKi9XNkz4EnT9GCvwUtSGf1QRUyDFaINj/qjR9YFUCGvkoikvIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(186003)(86362001)(6666004)(30864003)(8676002)(66946007)(16576012)(31696002)(8936002)(26005)(66574015)(4326008)(316002)(478600001)(83380400001)(31686004)(6486002)(2906002)(38100700002)(2616005)(956004)(5660300002)(66556008)(66476007)(110136005)(36756003)(53546011)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdVODFRQ1pnRDQ1S1BSSXlHeUxITlA0c2x2aDJ6WEltc05TbDY5Ukp4Nk9Q?=
 =?utf-8?B?emRLMng2Snl0VVZnajRiSHdTNTZVSDNkVDVDTXVWQ1FnSzE0RDZpWFJSQUY4?=
 =?utf-8?B?eiswbDQ3aC9lQnBxNC9tNHRwV2NMeVdacU41RGxZVTQ3Z0dQU1ArM0F5d2ox?=
 =?utf-8?B?TWtXeDNON0xaZ1VDamVVbnJnQlR5SU9qYTBGYzBJVStrb2FwTEoxanRNanQ4?=
 =?utf-8?B?SHdUZy9MS2NMaDBjeEw1bThYQ1ZRdlpyUnl1aUdzK0JqVWl0bEFQcE8rVThL?=
 =?utf-8?B?NmlNME5MUjFsUmNhNk5LUXBpRWdqSjVBc3MrME9NU0sxY1NYM3VHbWxXOGpJ?=
 =?utf-8?B?TDluV3ovZkpGY3RXc3E3dE9uQTUza3BaTUJqNCt6VDN3YndPQUpQNnQ4eHVP?=
 =?utf-8?B?UnIyT0VsUFBpclVaaEVmWUpFQ09BNXVLekk4ZmxieUdMNk5KRjJHWHVOaGFV?=
 =?utf-8?B?c0o2bXUvVml5UGVyaTRhSUcxeGtHUDFQaUNWZURNREE5YlNmV2wycGJSMjRM?=
 =?utf-8?B?SHQrWVZXdk5kWnNZV0p3aS93Qzh4a1NRYS9lR2htcDhUY25ZWCtYSjVEZEM1?=
 =?utf-8?B?NEJZUkNWaGhROU9Pakh0ck9Mc2xSUENvWk1DaDF6UzhuSzJkSmZIellvVzlj?=
 =?utf-8?B?cE50UDRpZHVUTmN6NEUyLzFxMXZZdGYrVmdHS2E2ZXFCMVJBNC80K0FNbjBL?=
 =?utf-8?B?Wlo1MVlralJtY2pqYlUxTVpjWU9NNEZoSVFVZHBRMlVkQ003SVhybUxFVTVs?=
 =?utf-8?B?WE0xeXZRcHgxZkp6YkcvMGFRODA4UlJNNWJPMDdGTDMxK05PekVUVW1iZ3M4?=
 =?utf-8?B?Vm4xNVZNbnFvNnFhYkhCRU4wZGJvOXg3WlZWOU5hcFM1Nm5JenBBcDgyVHBx?=
 =?utf-8?B?dTU0OUVIM3JlaWdVVnQ3Qkd5TTZOTkZ4YVlpaEVaMk5mQmVWU0U2NXF2bVk1?=
 =?utf-8?B?RUlsTE5md3d0ZytmUXBDL2xIWGxXZHc5dUllRDV1dGlRYUlrcjhXVFEzc0k0?=
 =?utf-8?B?RFVVeWc1Z1lKRWE5UlUrZWNDbHhzd0tQdlFqTFNSRmRwTmRNZEF4S3N1bkJr?=
 =?utf-8?B?eE40NllnSUw2dGkwS2NOUnNLTEVpcEZyWkNHQzJxVGQrSjZQR3M0T2ZFcUFY?=
 =?utf-8?B?MTFqTlg3UHNBTFB5SHJocEF1QzZOUEFYRzRWT2NLREM2T0dBeUhIMGtkY2pI?=
 =?utf-8?B?VHlNODU3R05tRWFBdTJEeUhoK1docjRZOVZoSEJSVlpFMU5TVHNTVFJKSEw3?=
 =?utf-8?B?ZFRjd0c0enlSR0E0bk5WYW9SciswQVh4Ymw3T3JlRXBpM2dwblcxeTVXdHpi?=
 =?utf-8?B?cG5JbTVMVUQ5SnB0V2ZzenQ2ZTBrQjlJMXhpeFIzaHQvRXQzYVFKU1pJSEFF?=
 =?utf-8?B?MHBOcDF1MG1ITFJwZ3lFcEdXT0dQYWp0MVRLY2JDL09COVdWS2orcGFhVnpK?=
 =?utf-8?B?OCtCdGxjM1ZRYWVsUSswdG1TdjUxY0JXUlowbjRwQXNUT1dISUxhVEtvaXRh?=
 =?utf-8?B?eU1WbTNYQ0ZjanZ3ZFd5Wmwwb2tMVG1kc3lVTE9tbHhnR3h5eUR3Ni9wbVRn?=
 =?utf-8?B?OEFaYW9oK1J0WHRwOHYxZituRm1ITEpwYVNuMlZwc3RRdXo3bmpHaFBFaCtl?=
 =?utf-8?B?S0cwYWw5UTlwbEt6TmVZOWV4WjA2cTRmQVplYlBsSWVWRGtyL2R6M1pHYnR5?=
 =?utf-8?B?OEVyWVhqNGlNWFRVcHk5Ky9YcUN0QlNtdEpwMWJibCsvSmxhVXF3d0Fwb3Np?=
 =?utf-8?Q?oa9XOxM6lVD/qnf1rnDafed6q9B/39/DJmjHH8b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8717663-48a5-47f1-c83f-08d94cef952d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 09:03:33.4779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUnxcO0WXHCBLYPYh1WK2ofMHRJRL8eMn+dKF+CtLo5JwDM42vheup4DGLEyPxSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/22/2021 2:03 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, July 22, 2021 4:10 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
>> properly for NV1x
>>
>>
>>
>> On 7/22/2021 8:50 AM, Evan Quan wrote:
>>> The customized OD settings can be divided into two parts: those
>>> committed ones and non-committed ones.
>>>     - For those changes which had been fed to SMU before S3/S4/Runpm
>>>       suspend kicked, they are committed changes. They should be properly
>>>       restored and fed to SMU on S3/S4/Runpm resume.
>>>     - For those non-committed changes, they are restored only without
>> feeding
>>>       to SMU.
>>>
>>> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
>>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52
>> ++++++++++++++-----
>>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
>>>    4 files changed, 69 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index 3e89852e4820..8ba53f16d2d9 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
>>>    	uint32_t power_limit;
>>>    	uint32_t fan_speed_percent;
>>>    	uint32_t flags;
>>> +	uint32_t committed_od;
>>>
>>>    	/* user clock state information */
>>>    	uint32_t clk_mask[SMU_CLK_COUNT];
>>> @@ -352,6 +353,7 @@ struct smu_table_context
>>>
>>>    	void				*overdrive_table;
>>>    	void                            *boot_overdrive_table;
>>> +	void				*committed_overdrive_table;
>>
>> May be rename it to user_overdrive_table - OD table with user settings?
> [Quan, Evan] Actually "overdrive_table " is  the user_overdrive_table. It contains all the modification including those not committed( the commit is performed by echo "c" > /sys/class/drm/card1/device/pp_od_clk_voltage).
> The new member added refers to those user customized but committed only settings. That's why it was named as " committed_overdrive_table". Any good suggestion for the naming?

As far as I understand, the problem is overdrive_table can have 
intemediary settings as the edit/commit is a two-step process. At any 
point we can have user_od_table keep the latest user mode settings. That 
is true when user restores to default settings also; that time we can 
just copy the boot settings back to user_od table and keep the flag as 
false indicating that there is no custom settings.

>>
>>>    	uint32_t			gpu_metrics_table_size;
>>>    	void				*gpu_metrics_table;
>>> @@ -623,6 +625,12 @@ struct pptable_funcs {
>>>    				 enum PP_OD_DPM_TABLE_COMMAND
>> type,
>>>    				 long *input, uint32_t size);
>>>
>>> +	/**
>>> +	 * @restore_committed_od_settings: Restore the customized and
>> committed
>>> +	 *                                 OD settings on S3/S4/Runpm resume.
>>> +	 */
>>> +	int (*restore_committed_od_settings)(struct smu_context *smu);
>>> +
>>>    	/**
>>>    	 * @get_clock_by_type_with_latency: Get the speed and latency of
>> a clock
>>>    	 *                                  domain.
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index ebe672142808..5f7d98e99f76 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct
>> smu_context *smu)
>>>    		}
>>>    	}
>>>
>>> +	/* Restore customized and committed OD settings */
>>> +	if (smu->user_dpm_profile.committed_od) {
>>> +		if (smu->ppt_funcs->restore_committed_od_settings) {
>>> +			ret = smu->ppt_funcs-
>>> restore_committed_od_settings(smu);
>>> +			if (ret)
>>> +				dev_err(smu->adev->dev, "Failed to upload
>> customized OD settings\n");
>>> +		}
>>> +	}
>>> +
>>
>> Just thinking if there is a need to handle it ASIC specific. The flags and table
>> pointer are maintained in common structure. So can't we do the restore of
>> user OD settings directly in this common flow instead of having each ASIC to
>> implement the callback?
> [Quan, Evan] The OD settings restoring is ASIC specific as it performed on OD table and that(OD table) is ASIC specific.

I was thinking in terms of final logic that is being done. The below 
structures are available in common table context and we have a common 
logic to update the table. If there is no custom OD settings available, 
we could handle it with the flag.

+	struct smu_table_context *table_context = &smu->smu_table;
+	void *od_table = table_context->committed_overdrive_table;
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
(void *)od_table, true);

>>
>>>    	/* Disable restore flag */
>>>    	smu->user_dpm_profile.flags &=
>> ~SMU_DPM_USER_PROFILE_RESTORE;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> index 59ea59acfb00..4752299d7f91 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> @@ -2296,39 +2296,45 @@ static int
>> navi10_set_default_od_settings(struct smu_context *smu)
>>>    		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
>>>    	int ret = 0;
>>>
>>> -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
>> (void *)od_table, false);
>>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
>> (void
>>> +*)boot_od_table, false);
>>>    	if (ret) {
>>>    		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
>>>    		return ret;
>>>    	}
>>>
>>> -	if (!od_table->GfxclkVolt1) {
>>> +	if (!boot_od_table->GfxclkVolt1) {
>>>    		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
>>> -								&od_table-
>>> GfxclkVolt1,
>>> -								od_table-
>>> GfxclkFreq1);
>>> +
>> 	&boot_od_table->GfxclkVolt1,
>>> +
>> 	boot_od_table->GfxclkFreq1);
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>>
>>> -	if (!od_table->GfxclkVolt2) {
>>> +	if (!boot_od_table->GfxclkVolt2) {
>>>    		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
>>> -								&od_table-
>>> GfxclkVolt2,
>>> -								od_table-
>>> GfxclkFreq2);
>>> +
>> 	&boot_od_table->GfxclkVolt2,
>>> +
>> 	boot_od_table->GfxclkFreq2);
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>>
>>> -	if (!od_table->GfxclkVolt3) {
>>> +	if (!boot_od_table->GfxclkVolt3) {
>>>    		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
>>> -								&od_table-
>>> GfxclkVolt3,
>>> -								od_table-
>>> GfxclkFreq3);
>>> +
>> 	&boot_od_table->GfxclkVolt3,
>>> +
>> 	boot_od_table->GfxclkFreq3);
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>>
>>> -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
>>> +	navi10_dump_od_table(smu, boot_od_table);
>>>
>>> -	navi10_dump_od_table(smu, od_table);
>>> +	/*
>>> +	 * For S3/S4/Runpm, no need to install boot od table to
>> overdrive_table as
>>> +	 *   - either they already share the same OD settings on bootup
>>> +	 *   - or they have user customized OD settings
>>> +	 */
>>> +	if (!smu->adev->in_suspend)
>>> +		memcpy(od_table, boot_od_table,
>> sizeof(OverDriveTable_t));
>>>
>>>    	return 0;
>>>    }
>>> @@ -2435,6 +2441,14 @@ static int navi10_od_edit_dpm_table(struct
>> smu_context *smu, enum PP_OD_DPM_TABL
>>>    			dev_err(smu->adev->dev, "Failed to import
>> overdrive table!\n");
>>>    			return ret;
>>>    		}
>>> +		if (memcmp(table_context->overdrive_table, table_context-
>>> boot_overdrive_table,
>>> +			sizeof(OverDriveTable_t))) {
>>
>> Shouldn't this be - compare against the edited settings and last committed
>> settings, overdrive_table vs committed_overdrive_table?
>>
>> Basically, user_od_table can be initialized with boot_od settings and the flag
>> gives the indication that user_od table is being used or not.
>> Before updating, check if the edited table (overdrive_table) and the current
>> user_od table are different, then commit the new table.
> [Quan, Evan] Yes, I also considered that. But that cannot handle the case below:
> 1 user made some customizations  -> 2 the customizations were committed -> 3 user restored to default(boot) OD settings(by "echo 'r'") and committed
> Although there were some changes between 2 and 3, there is actually no real customized changes compared to default(boot) OD settings.

On restore to default, just copy the boot_table settings to user_od and 
keep the flag as false. We are using user_od as the latest user 
preferred settings and overdrive_table is only used for intermediate 
updates.

The flag decides whether to restore or not, but at any point we can 
refer the user_od table to look upon the latest preferred user settings 
(default or custom).

Thanks,
Lijo

>>
>>> +			smu->user_dpm_profile.committed_od = true;
>>> +			memcpy(table_context-
>>> committed_overdrive_table, table_context->overdrive_table,
>>> +					sizeof(OverDriveTable_t));
>>> +		} else {
>>> +			smu->user_dpm_profile.committed_od = false;
>>> +		}
>>>    		break;
>>>    	case PP_OD_EDIT_VDDC_CURVE:
>>>    		if (!navi10_od_feature_is_supported(od_settings,
>>> SMU_11_0_ODCAP_GFXCLK_CURVE)) { @@ -2499,6 +2513,19 @@ static int
>> navi10_od_edit_dpm_table(struct smu_context *smu, enum
>> PP_OD_DPM_TABL
>>>    	return ret;
>>>    }
>>>
>>> +static int navi10_restore_committed_od_settings(struct smu_context
>>> +*smu) {
>>> +	struct smu_table_context *table_context = &smu->smu_table;
>>> +	void *od_table = table_context->committed_overdrive_table;
>>> +	int ret = 0;
>>> +
>>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
>> (void *)od_table, true);
>>> +	if (ret)
>>> +		dev_err(smu->adev->dev, "Failed to import overdrive
>> table!\n");
>>> +
>>> +	return ret;
>>> +}
>>
>> As mentioned before, not sure if this is needed as callback. Even if, this can
>> be something common for smuv11, there is nothing ASIC specific in this logic,
>> right?
> [Quan, Evan] Yes, in patch2 of the series, it was made as a SMUV11 common API.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    static int navi10_run_btc(struct smu_context *smu)
>>>    {
>>>    	int ret = 0;
>>> @@ -3262,6 +3289,7 @@ static const struct pptable_funcs
>> navi10_ppt_funcs = {
>>>    	.set_soft_freq_limited_range =
>> smu_v11_0_set_soft_freq_limited_range,
>>>    	.set_default_od_settings = navi10_set_default_od_settings,
>>>    	.od_edit_dpm_table = navi10_od_edit_dpm_table,
>>> +	.restore_committed_od_settings =
>>> +navi10_restore_committed_od_settings,
>>>    	.run_btc = navi10_run_btc,
>>>    	.set_power_source = smu_v11_0_set_power_source,
>>>    	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask, diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> index 0a5d46ac9ccd..28fc3f17c1b1 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct
>> smu_context *smu)
>>>    			ret = -ENOMEM;
>>>    			goto err3_out;
>>>    		}
>>> +
>>> +		smu_table->committed_overdrive_table =
>>> +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size,
>> GFP_KERNEL);
>>> +		if (!smu_table->committed_overdrive_table) {
>>> +			ret = -ENOMEM;
>>> +			goto err4_out;
>>> +		}
>>> +
>>>    	}
>>>
>>>    	return 0;
>>>
>>> +err4_out:
>>> +	kfree(smu_table->boot_overdrive_table);
>>>    err3_out:
>>>    	kfree(smu_table->overdrive_table);
>>>    err2_out:
>>> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct
>> smu_context *smu)
>>>    	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>>>
>>>    	kfree(smu_table->gpu_metrics_table);
>>> +	kfree(smu_table->committed_overdrive_table);
>>>    	kfree(smu_table->boot_overdrive_table);
>>>    	kfree(smu_table->overdrive_table);
>>>    	kfree(smu_table->max_sustainable_clocks);
>>>    	kfree(smu_table->driver_pptable);
>>>    	kfree(smu_table->clocks_table);
>>>    	smu_table->gpu_metrics_table = NULL;
>>> +	smu_table->committed_overdrive_table = NULL;
>>>    	smu_table->boot_overdrive_table = NULL;
>>>    	smu_table->overdrive_table = NULL;
>>>    	smu_table->max_sustainable_clocks = NULL;
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
