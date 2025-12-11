Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145D0D3E78B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 04:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DCE10E06F;
	Thu, 11 Dec 2025 04:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2Bl5U2l";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4E710E06F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 04:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaA16Ql2E9i/N3e/zGtOQ0NEwl5CcEZM8M2uwuTsOwEQldSlQt4f04N4E+sfaYTKAaZ03XBl8GXuaNOksjAOoCeJnHXL83wtXPUKoAzWVHGam/H4EJ3onCsgZDLPOTH0K/wiA7c5bB3kYhaFMxFk6WD8yjwOZFGs4nlJbzTv54ZKMyHk1sGZOBmgv0KFmLp1F1nc4ZQf1ZPWmSXVNk6Gj+HsfW+tmWsNKQQ3wR30aWQNVbSsKug1uKdB13BmPGlNCXaflpKwAV2FNsvnd+SNaJLsaiKDppTqTBmP6K9CEs/W5Ec3lf9MFCneLrstv7JHzDA8+BDSshoGzYlRK9OqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtfxEWkWkZprgEO3p1ow/IKbju5A+mCDrwFi9OPeJFs=;
 b=yoAyMao19aSX4ncOWv6SykKZXJ50wr15bCvItwHLzcJImwFnNggmbpf0zsYisuBKHuCoV1Hbzdb3XXt/Sl5TzVJF9IteBu2xznhXA1ILFR1uQw9vFmHo69CThiFggGyyCC+gcSdm7Doo+j643AOexqYNekCaX8ClWhIm11yVLjDZ7TMu2mU68TB448nT2SIyu1rMctYzb4THA1h8VtvexLkkJ6LTEWX0CNgz6Vshqm0as4jsc4GH2wJ2F2VfpXT8cdNpugj6NmVxL7iDtkT7DpFL/aBxQRjC1YuuwtI5SueofXvYzrmwdc28o/0XM1NSJaGyCP9x1cBZl99M3SZB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtfxEWkWkZprgEO3p1ow/IKbju5A+mCDrwFi9OPeJFs=;
 b=E2Bl5U2l2a6oBdRgIVVT9HXJzaBrAaTYCevAEi3U0/2FxlfxE+sTF1McstwCzUWRI8QFFXhzbieOGW72xDAk6IE1K77/wOtmT2n1y4uFN4AK1Nl299qDRWyb8+1G2tCQpdirKNzhXtrgLplTy+/tsVfNPgK0SSEqhEgfW33xCaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 04:01:13 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d%3]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 04:01:12 +0000
Message-ID: <772c2e4c-86b6-4200-9cbf-696e4652a6c0@amd.com>
Date: Wed, 10 Dec 2025 23:01:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
 <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
 <03db9561-f7e4-4157-95b3-7d32bdafe15f@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <03db9561-f7e4-4157-95b3-7d32bdafe15f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::19) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: db97602e-ff1c-4089-ab3c-08de3869ec96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TitjQVpqcXNBaG94MnZoSzB4NjFaWDY4aWNSOEY1Z1FmY0I4cExQV1JDemNL?=
 =?utf-8?B?bm1nYWZnNWVoZHoxQVYzaG9xWFd5aGZzRVZIcUxjRlNqRFowMCs5ZjNBelpt?=
 =?utf-8?B?U1hRMWdWejVYNmZ6SiswYXJ1eTlPRHphOVB3TjM2Zjc2bEovemRVcU1pdXhB?=
 =?utf-8?B?TkxFS2hVS2hyeXo5M1dJME9BU2FzTDNDRW1qSEV2bkxXVGw5M3R6UVRVdHBE?=
 =?utf-8?B?dWpieFVLOWJSNVZWNURvc25hYXlkRlh2VTdKUk1Lc1Q0LzZiRExVSWdGTzR0?=
 =?utf-8?B?Q3JqQm4wTFdRdTB1VVVkNlNabUc3MnBwaEx2b0pqRUZnZUVrR2VzNmQ2cU5D?=
 =?utf-8?B?R0pJcWxGUzlFdmJpUUpvUEFJK05oOGpLS3JQTEkxNmJnWWFXLzVEcldPUSty?=
 =?utf-8?B?aGN2Z1NrNTBoTXRQVXpyRDkweXRpRGJqaE1oamxKcDd5bnNMU0xlWDNlVi9h?=
 =?utf-8?B?VUlhVnJJa0syT1pFK2VGSWhxaU1HeWZzNy9JbTIrVTlrMk1RdldCeFM3WHk3?=
 =?utf-8?B?UWlsL29abjFMYWxZL3ZiYUVrUlpkVjkwdjBvd3JNQ0FRYVdTUmV2Y3Rnb2FF?=
 =?utf-8?B?OGZSYWJYcG9ocWpiUVAvcHpXWWZrT2o0SlFUZDczeWJzS2FCWlE4Vk9TQ0ZO?=
 =?utf-8?B?TnYzWnhRYmxHZ1A1UG1wN2Z0TklUUENWSVYza3FPQjhieHVjTlhNeVJJVWhu?=
 =?utf-8?B?d1JIMDJwVHRuMHBqdnM1V1NzZ1NKazExeWRmNTNNSWtIa0hhT3h0VHR0ZGha?=
 =?utf-8?B?UXlRZ1hYVHF2TmlqQWNlTmV3MjRteTJSV0lINStmUks1OEdCdnVGWGQ0NkZV?=
 =?utf-8?B?Q3BoMDhvY3VHSUNyZ3ZDMjRwTG1KV29NVWcxMFRVTlN4VEJQdjAvcldxYWxN?=
 =?utf-8?B?dGQrbUxIWHQzeVk0cjh4R05jSEZuVFM4NTZKd21mRzVDTHhHcWRlOVNZNUFi?=
 =?utf-8?B?dFVTWUpuRytiS040Z2tycWVwOFdsQXZJblQ5VHZUWCtmRUVUWVM0cUdwUStM?=
 =?utf-8?B?a0FMSklEakZoQmZSZHk1OHZFYXNqUytRTDRzcVo1cURwV09SVWx2Y3kzNjdq?=
 =?utf-8?B?MXdKOVVKWFNJcGpEcEVscGlZRUNKTS8zc0dCcEdSOWtkbk5TUmVxT3lCcHVO?=
 =?utf-8?B?R2lGeGwrb1Z1SEYvK3Z3RUhIclc1aUZHRFAzbytjeEQvSHVoanQ0Y2lLb0kx?=
 =?utf-8?B?Vm5hU2d5aFZFbHZpdGZ1N2ZXbUFvTnUwL3FxT3BqWjhtblhCbnRZNjVxdVVq?=
 =?utf-8?B?S21GZWljT3NETWxKVlp1dGpjQXViZlMrTFFkR2o2SFhzQ2wvMDRZUGpEMzJ6?=
 =?utf-8?B?cGpsbk9KaGdaNFZuelRPUTJkV2hMNEt1ajdIdmZ3b25IVVQrWHpUYXozYzFI?=
 =?utf-8?B?QXNadm5ZUmd0d3FuV0xSSjdlcU9RQ1lxWnc0b3l1eTNNa3l1Nk4xVmZYbGpw?=
 =?utf-8?B?R1hjTmhZbldTL3FpSEw1Ry9WQ1Q1VldTMzJoc2ZKRWtKandpL2R6TGhBQzlH?=
 =?utf-8?B?cE5KMk5BWjd0bThOSFl6akZyRzJYOXhKSW5pbjQ2L1c4MjlTemR6VHN0Nlpv?=
 =?utf-8?B?THBjKzdQOWYwMjNXck1LMHB6K1A0WGZLa1cvVVp5OEFsU1pSRkJ2NlpBSm5M?=
 =?utf-8?B?TytZMm9yd2EwcndzNWhnUXVRcWlOWmxkRWNuc2xTZEp0N2EyZVdBa2VkcmQz?=
 =?utf-8?B?OGhQV3ExSjB3SWFpS2Zud2xKSHUwMlZxOHlxUHVUYmZ5VHc5aldtZTRxZTJs?=
 =?utf-8?B?bTRnRFdHditMWmo1Ky82VUZKRkM1SWJmVTFkdGFmUzVucGJCVkdQVkJKWlFP?=
 =?utf-8?B?cTdPV3pxb0NsWjRVbmQ2VC9nTWN5S2lRcDFXQ2VyYzlMbHFiQllPNHpocnNp?=
 =?utf-8?B?SUNjWExHY1A1aE9IS3dYN2pGSk9BWjNNOHNBcitBWUVkZ0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lldEdlNldDMEpTanhwNmF4WUNSd3k5aXhQaFUyanM4azVNSzBCcm5LS1Fz?=
 =?utf-8?B?Qm4wb3dxcFRJT2txR3hzZXBvTzJ2K1E3MFQxaS92UHlnUXZwKzRJZ0hIbmFi?=
 =?utf-8?B?NitvUE5jQ1NQOVgxbEdKVnVITGowSU1QUzVNTGsxRkRxcXFXQ29BekoxZ0Jj?=
 =?utf-8?B?MHdUOXBQOGFkWjJUUDkxTGlJTDNhTXJyRi93WWhGTW0zeHdWUEloK2RWRFNV?=
 =?utf-8?B?bHZkNWxYUE9hemIvSGhYaE1KMlI2ODlMblNBWFVHWWRaTkFGTnNyMllDZmtm?=
 =?utf-8?B?TUFHaWVZejd2eGtheXlyUU5mMWRBOVU3Nzg5VkNlOW9qNFpka2RsNGsyTmFQ?=
 =?utf-8?B?L0xwVkk3UEo4YlpMd0ttMUNibkxCWHFBMlc4a2E4eERWVXprbTZJNFdsSkR3?=
 =?utf-8?B?NVBHcmpQa2M0dFg4NmlFQnRKejNrQWx1bzlwMWJaOVZXVmRydGtkbW1VTGVY?=
 =?utf-8?B?SUpzR2dGY0IzRDVEazBtL3ZaMjBGZjQ1VmdCN2QySGhjNnorR3kzZGRqN1Vl?=
 =?utf-8?B?VUhvV2t2M0x0ekdyMGhIVVNlZTN5dTcrWFMxRmdlOFRDTE9WdE9Qem9nZHls?=
 =?utf-8?B?T2tSTDZlY0wxbjg0YTl3aGFrVmh4N013VXRWU3dTbEQxZzQrYlBJYTVUNTF1?=
 =?utf-8?B?WHpvckZSYzFFaitjZXRUbG1rRU8wSnkyWUYyWkJOQXlPaWdtY3JSMW13ZXJu?=
 =?utf-8?B?YU13eDhqYnV5dERGOUdQY1lVS0hVUklvZEpocGxsTFVHcTlpSTFJaHBDV2Rx?=
 =?utf-8?B?a25RM1l2WFNQTjM2RjcrSWpodG1LY2tvTnNucDJIejZqd3ZpblFOR3JvVGQ3?=
 =?utf-8?B?U2ljcW5FZFE1WHNRTHVHM0dkUXFFYjlOQkgzRkNsOW9ITHNaU3poQlltb2ph?=
 =?utf-8?B?K0tSM1M0MldUSm96YVp5cWlBRFVTQkpwM1E0U3h3aG0vNll6VmlNSjlBOTVk?=
 =?utf-8?B?b2k3VlVuQlFUUStVWUlwZzMrWUtjRVNwdGMrZjBHNk95cnFaT0RwWTJXMVFK?=
 =?utf-8?B?Mm1yMldpTy90elhmOE80cTBTZ3FqSDN4Tk5MR0FXNXNjb01sMWErMmlGSHhR?=
 =?utf-8?B?eUdCU29VSXBkZUxzMDZoVE9tT3dLTGdNVnQ2bUUrWUs2bHJwc1J6UE8wQmF5?=
 =?utf-8?B?M041dW9UYWZXbVhyWlpaMElQTkprZGZwdHBUdkFNVWpIckhiSDVuVmJDeVBh?=
 =?utf-8?B?bHBnY0JUSkJveFJjd3VSOE5mM1M1YXBKaHpQSDdkRW9WUy9SZ1NLZ1R1UlNG?=
 =?utf-8?B?MVgramNkQ3V4MVBvUVV2QlBGV0ZaN1Ayb0EyZ2piZEdIdXpmUU5zL2o4enpn?=
 =?utf-8?B?WnFmSkhPNXp5enI5ZVliMTZzcnQ5S0pPVUMzYUhKUTFVcEhJamxCdmc5MFNp?=
 =?utf-8?B?c2ViQjZCRW1kRmNQRGxKYjRLVTNIYXRnL2FMRTJlalo5ekt3aFJUbDFLZTJv?=
 =?utf-8?B?UzA4WkExZlN6ZGJBaDIxeHJwbmh2aEVZT20vZWh2OTNpWjZYNEdjdm44ZHNR?=
 =?utf-8?B?SWliQUk0cmYwZ2FaTGV5cTVabFhaSkR1M0FwR1JxM0lDeUx3R3NCaG03V3Nr?=
 =?utf-8?B?QkVUSytOYXJ2R1B4bDFjVmhwNitpZkdYY3Q5MTlEZjNyNnQ0NTR3SlRyMU9z?=
 =?utf-8?B?aWNKcXJIeXprSVhKWVB6OExFbGU2eFJQQ2VzQWNyRjJtRUFxTzVtbEZGZ0F6?=
 =?utf-8?B?TGI5NHNJdkFtTVlLZ3RJT1ZDOUZBTUNCdnd4UVgycDNucjJmM2d4V3cyMjB4?=
 =?utf-8?B?eitjK3NlaHNaeGJRL0krUnM5OUJjc1FaZ1crdmpZYVVTYUI3eDM1aGk2emMw?=
 =?utf-8?B?c1lZcmZHOTNqa3Rlc0xPZ2Z5ZWJRL2Y3UDN6MHl6Tjk2N1dNV1dTSGFoTjlK?=
 =?utf-8?B?ejlnNWp1QVF0MHNYMVNmUzRpMUkxK0VyZTFWK1BLVFdLb0FWQllBWDRwQjJ0?=
 =?utf-8?B?eDllUTErR0ZBb3NDYVlCL2JVbHlhdndubi9Rbk0zOVlhOHhTNHN6ZjlmNHg1?=
 =?utf-8?B?WkF4Q0hyUzVydlNFclQ5akNST0FOZVFYd0UzM015RnAvWFV0dmh5bUU1b2lV?=
 =?utf-8?B?V3RoODZvRFF2bkdiUm1pZzZkZjdSVVU3MnNIVmRNZW9mQnFicGkzbDZrQXdz?=
 =?utf-8?Q?aeBZ/7GxywLi5eTDbU2XuiPed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db97602e-ff1c-4089-ab3c-08de3869ec96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 04:01:12.6834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZsI0K5B68GH0BXD/DOZHI0fUBzbwCe0VQSPGOaMLicuk2qo4KYaGasnMXV28dFOGPNkFXDTmuLLWdG5hPpf4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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


On 12/10/2025 9:19 PM, Mario Limonciello wrote:
>
>
> On 12/10/2025 5:13 PM, Nirujogi, Pratap wrote:
>> Hi Mario,
>>
>> On 12/9/2025 10:28 PM, Mario Limonciello wrote:
>>>
>>>
>>> On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
>>>> ISP mfd child devices are using genpd and the system suspend-resume
>>>> operations between genpd and amdgpu parent device which uses only
>>>> runtime suspend-resume are not in sync.
>>>>
>>>> Linux power manager during suspend-resume resuming the genpd devices
>>>> earlier than the amdgpu parent device. This is resulting in the below
>>>> warning as SMU is in suspended state when genpd attempts to resume 
>>>> ISP.
>>>>
>>>> WARNING: CPU: 13 PID: 5435 at 
>>>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/ amdgpu_smu.c:398 
>>>> smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
>>>>
>>>> To fix this warning isp suspend-resume is handled as part of amdgpu
>>>> parent device suspend-resume instead of genpd sequence. Each ISP MFD
>>>> child device is marked as dev_pm_syscore_device to skip genpd
>>>> suspend-resume and use pm_runtime_force api's to suspend-resume
>>>> the devices when callbacks from amdgpu are received.
>>>>
>>>> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
>>>> Signed-off-by: Bin Du <bin.du@amd.com>
>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>
>>> Who is the patch author?  If you guys worked together, there should 
>>> be Co-developed-by tags to represent it.
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 
>>>> +++++++++++++++++++++++++
>>>>   3 files changed, 85 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_isp.c
>>>> index 37270c4dab8d..532f83d783d1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, 
>>>> u64 *gpu_addr, void **cpu_addr)
>>>>   }
>>>>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>>>>   +static int isp_resume(struct amdgpu_ip_block *ip_block)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    struct amdgpu_isp *isp = &adev->isp;
>>>> +
>>>> +    if (isp->funcs->hw_resume)
>>>> +        return isp->funcs->hw_resume(isp);
>>>> +
>>>> +    return -ENODEV;
>>>> +}
>>>> +
>>>> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    struct amdgpu_isp *isp = &adev->isp;
>>>> +
>>>> +    if (isp->funcs->hw_suspend)
>>>> +        return isp->funcs->hw_suspend(isp);
>>>> +
>>>> +    return -ENODEV;
>>>> +}
>>>> +
>>>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>>>       .name = "isp_ip",
>>>>       .early_init = isp_early_init,
>>>>       .hw_init = isp_hw_init,
>>>>       .hw_fini = isp_hw_fini,
>>>>       .is_idle = isp_is_idle,
>>>> +    .suspend = isp_suspend,
>>>> +    .resume = isp_resume,
>>>>       .set_clockgating_state = isp_set_clockgating_state,
>>>>       .set_powergating_state = isp_set_powergating_state,
>>>>   };
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_isp.h
>>>> index d6f4ffa4c97c..9a5d2b1dff9e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>>>>   struct isp_funcs {
>>>>       int (*hw_init)(struct amdgpu_isp *isp);
>>>>       int (*hw_fini)(struct amdgpu_isp *isp);
>>>> +    int (*hw_suspend)(struct amdgpu_isp *isp);
>>>> +    int (*hw_resume)(struct amdgpu_isp *isp);
>>>>   };
>>>>     struct amdgpu_isp {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/isp_v4_1_1.c
>>>> index 4258d3e0b706..560c398e14fc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> @@ -26,6 +26,7 @@
>>>>    */
>>>>     #include <linux/gpio/machine.h>
>>>> +#include <linux/pm_runtime.h>
>>>>   #include "amdgpu.h"
>>>>   #include "isp_v4_1_1.h"
>>>>   @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device 
>>>> *dev, void *data)
>>>>           return -ENODEV;
>>>>       }
>>>>   +    /* The devcies will be managed by the pm ops from the parent */
>>>
>>> devices
>>>
>>>> +    dev_pm_syscore_device(dev, true);
>>>> +
>>>>   exit:
>>>>       /* Continue to add */
>>>>       return 0;
>>>> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct 
>>>> device *dev, void *data)
>>>>           drm_err(&adev->ddev, "Failed to remove dev from genpd 
>>>> %d\n", ret);
>>>>           return -ENODEV;
>>>>       }
>>>> +    dev_pm_syscore_device(dev, false);
>>>>     exit:
>>>>       /* Continue to remove */
>>>>       return 0;
>>>>   }
>>>>   +static int isp_suspend_device(struct device *dev, void *data)
>>>> +{
>>>> +    struct platform_device *pdev = container_of(dev, struct 
>>>> platform_device, dev);
>>>> +
>>>> +    if (!dev->type || !dev->type->name)
>>>> +        return 0;
>>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>>> +        return 0;
>>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>>> +        return 0;
>>>
>>> Could we store the mfd_cell pointer instead and just compare the 
>>> pointers?
>>
>> I don't think I can do a pointer comparision to identify the correct 
>> mfd_cell, string comparision seems like required in this case.
>>
>> Its because when isp mfd child devices are created using 
>> mfd_add_hotplug_devices(), it is not returning the pdev or mfd_cell 
>> handles
>> to store in the amdgpu_isp and later use in suspend/resume to compare 
>> with incoming pdev->mfd_cell to detect the correct the device.
>>
>> The mfd-core is doing a kmemdup of mfd_cells data passed to 
>> mfd_add_hotplug_devices() to create the platform device.
>>
>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L163 
>>
>>
>> I'm considering to add this function to check for valid isp mfd child 
>> devices that are allowed to do suspend-resume, this can minimize the 
>> checks, but still cannot eliminate the string comparsion, please let 
>> us know your thoughts.
>
> Well actually is a check needed at all?
>
> isp_v4_1_1_hw_suspend() calls device_for_each_child(isp->parent) which 
> is a platform device. Are there other children below that platform 
> device?
>
> The platform device was made explicitly for this purpose wasn't it?  
> So maybe drop the check overall?

yes, there are more children than the 3 isp mfd devices. Below is the list:

child-1: mfd_device (amd_isp_capture)
child-2: mfd_device (amd_isp_i2c_designware)
child-3: mfd_device (amdisp-pinctrl)
child-4: drm_minor
child-5: drm_minor

Without the check, suspend-resume will be called for every child of amdgpu.

We intend to call suspend-resume only for child-1 and 2 as these are the 
only devices registered with genpd to control ISP power.

I did a quick test removing the checks, device failed to wake up from 
resume, I can recheck and update if it is safe to remove the checks.

Thanks,

Pratap

>
>>
>> static bool is_valid_mfd_device(struct platform_device *pdev)
>> {
>>      const struct mfd_cell *mc = mfd_get_cell(pdev);
>>      if (!mc)
>>          return false;
>>      if (!strncmp(mc->name, "amdisp-pinctrl", 14))
>>          return false;
>>      return true;
>> }
>>
>> Thanks,
>>
>> Pratap
>>
>>>
>>>> +
>>>> +    return pm_runtime_force_suspend(dev);
>>>> +}
>>>> +
>>>> +static int isp_resume_device(struct device *dev, void *data)
>>>> +{
>>>> +    struct platform_device *pdev = container_of(dev, struct 
>>>> platform_device, dev);
>>>> +
>>>> +    if (!dev->type || !dev->type->name)
>>>> +        return 0;
>>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>>> +        return 0;
>>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>>> +        return 0;
>>>
>>> same comment as above
>>>
>>>> +
>>>> +    return pm_runtime_force_resume(dev);
>>>> +}
>>>> +
>>>> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = device_for_each_child(isp->parent, NULL,
>>>> +                  isp_suspend_device);
>>>> +    if (r)
>>>> +        dev_err(isp->parent, "failed to suspend hw devices 
>>>> (%d)\n", r);
>>>> +
>>>> +    return 0;
>>>
>>> Shouldn't you return r?
>>>
>>>> +}
>>>> +
>>>> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = device_for_each_child(isp->parent, NULL,
>>>> +                  isp_resume_device);
>>>> +    if (r)
>>>> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
>>>> +
>>>> +    return 0;
>>>
>>> Shouldn't you return r?
>>>
>>>> +}
>>>> +
>>>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>>>   {
>>>>       const struct software_node *amd_camera_node, *isp4_node;
>>>> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp 
>>>> *isp)
>>>>   static const struct isp_funcs isp_v4_1_1_funcs = {
>>>>       .hw_init = isp_v4_1_1_hw_init,
>>>>       .hw_fini = isp_v4_1_1_hw_fini,
>>>> +    .hw_suspend = isp_v4_1_1_hw_suspend,
>>>> +    .hw_resume = isp_v4_1_1_hw_resume,
>>>>   };
>>>>     void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
>>>
>
