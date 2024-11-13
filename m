Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ECDD41C0F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670C210E34C;
	Wed, 13 Nov 2024 07:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hB1PC7uk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3316D10E26E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 07:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0fiAlpMx55ArdpKfBo+gYljge8rudgkv0wI1mS1IajfcywIWEWmN7B+Kuj9VuQulBPy4H6cViuZ3CibaaIdbYbC4CfCZuhbKycFFy8DiYfvrCsq8/C4gotNFZscNkZtLpTT8oiXX1NiY+FyWQAmr4qc4krF/x+SN9W0lteAzuxhpie4msZvvLcoU8uV1jsE/PikS0fI/RMLq0SlLFNwJ0QHL0n/q85YS7efgKWHuOtfhVzIG0H/CTaahu7p5DUGu5X88Q8DIJTWsXjoAHMEF3SjnnowL4fg1UzExgk9hqc30ug4EYvDr78pdb6S1LgDn8nArT2wJKzB6uDNQsoCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9xGGBhlvbvYH5+/61N2XblJx4caRoAc2IkCvThRj2A=;
 b=AeQ7qFdS8p5qYo2v87sIPWZbDxutM5C0hLVS789mLvg1UB6mKQkkxZNgHSt2Wk5TUGlQmNjqsr3waODvhPNNi/6BjRCnZfxTca3n1SrBM8LuD547lDo6WY9t1hAX0arGx/ltbq+H4w99nkv4Qte5ZSiYOqUWaRsTPnx/PRrs9FXfl8TMhMu7ZxG1p/yyOArPXFrN054X3WEsyKQBzsFxjRggX0pOlIrhd/vsfA5FmLUfDhpDXbVj7I31XehXn8Er+CRdcoWHQvylmH4mm6fjmuLprdl/jDQOf8mvkqb+PRlpaONWRcFlxlyrtK0R4vHnnu9JskMLpu8ew+z6wdVJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9xGGBhlvbvYH5+/61N2XblJx4caRoAc2IkCvThRj2A=;
 b=hB1PC7ukrIXZBJnEUxa1swqPFIdEkfwEBzVVMI/w2teXFUKgOLhk9XqVn8NR+/kApgABEpjVhI7Am/qp5uqTi2b+60AI64bPMQ3pWPiv/unrRx7a3gX99Kmw1vwzhLxOz3+NF5NcQUo21jhWoDrMeNcDxubDvcKpMj0FAiBFT7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 07:31:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 07:31:00 +0000
Message-ID: <95614ce0-656b-4c15-a5b2-6c5997dc9a95@amd.com>
Date: Wed, 13 Nov 2024 13:00:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth Feng <kenneth.feng@amd.com>
References: <20241112202847.8509-1-alexander.deucher@amd.com>
 <657e02e0-3dde-4ca3-bc4c-9e3b9ace3f8f@amd.com>
 <CADnq5_MA8vZCq0cjgw4ctch2YfG_nj=ceSK5H4AdVAC5QEDiNQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MA8vZCq0cjgw4ctch2YfG_nj=ceSK5H4AdVAC5QEDiNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: edf2aa40-8d9e-4de9-993c-08dd03b51f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjN1MGNBcytHSmN3bmZrL05VZ0Fpdms5Q1hzVjNXMHdVLzlWb0pseFNKcCtp?=
 =?utf-8?B?Wm5ISHlMS1JIUzdMUmNqdDB4aXYrYzJKcWpQK2Q1MDdpYit5eWNIS1JMa24x?=
 =?utf-8?B?YTdicFVPZUVZVWR2NmVFdEtaeTZSM3ZxMlBCQWIxNzd0My9YKzhxQ0JPRk9F?=
 =?utf-8?B?azdOTnFPT3hYYnVEY1lreXU4bUtvRFNyYzJyY2Y4R0t4NDMwT3VIM2xJdERS?=
 =?utf-8?B?Y2pxZGkrTnQzMXFRRVcrSCtocFNmRjZxdUdHT2RVM1Bwejk2TndIMGMyRDhI?=
 =?utf-8?B?NzdNQ3g4c01GckQyTDdhL3lxeGd1T3J3TFBERGpQbmVsSWhRTjh5eWVEUmhO?=
 =?utf-8?B?a1JUNFVkMFRGWk52RFIyRjdZQitOejZXTE5mS2xOOHZFNjZ5YS8wT2ZhTEdD?=
 =?utf-8?B?RkQxRXdnaW05Si9JaWxxQVJWb1Ryclp3a1ZtN1c1S0xQYjdzWnYxL3M3azFn?=
 =?utf-8?B?VENEbG54cmFhUTJVRGVhcHpXWm1wc0pqcVFYWGx1RGxmUDc0UUlnOE5TRGVh?=
 =?utf-8?B?TWpZczZEejVjNUVkdmFqelBhUzBDQTcxQ3o5WlA3Zm9OQURuSVYrTC95L3hN?=
 =?utf-8?B?MlowVzljWXM1QmVIYnNpQStJNXBYRVMzUUNsNHN1bG9keVcyK2RiTU1NK1Bl?=
 =?utf-8?B?L0c4Y2E0UjlpbGJXVFlOYmR6R1BVRFFiWm1CdG84ODFHNkJqT1l4Ync1TUZK?=
 =?utf-8?B?andNYVN6ajM1dCs0VE5iaWFOdWNqdWhUOVcrWGVvMlRlM1R5blBLY1JHZnha?=
 =?utf-8?B?b0djN3NxTGJDOVNNZUdJRVhXUkE0bmZxTjZVdS9ZMHJ2cVNucG5vd0xWbENr?=
 =?utf-8?B?RWxVeFBYcm1pelNyZVN0RCtwVllnWHdNWTV0RkEyengwakRLdTMzSUcxU2Q0?=
 =?utf-8?B?S25QRjYzeTU0NVZGdFNhSTNwTmFWTjN6dHpLcWFoZ0MvNWVpMjVvcm5mMmNW?=
 =?utf-8?B?M3BwTE82Mjllb0JwQmYzOWlrMWloU242S1RLTlpyRlpqeFhzNFE5V3h5cXA3?=
 =?utf-8?B?bXQycUx2Wmp3ZWlrK2lNTHA4YXFRYmdxSDQyOUIvZWM3QUFKbExPcktCYW5V?=
 =?utf-8?B?N2FDeklBZFlKWUpqZUhSVXdUS3VjTFdjNklySnovR0pLbmptZEUvbmhoa2Zx?=
 =?utf-8?B?c0NpN3FReEEwNVpGWTFPZi9tWjJVTHhTUlRnTm5yamdoSHg4TC9RSmVhK2RR?=
 =?utf-8?B?Tnl6NDBkckF5cEVhL1NTZHY5cXhIdVhXcDdIYTU1TkpwUUpHNjRzdHJqUyth?=
 =?utf-8?B?Tlltd0JVeVpTR2kyckFPZUd4UTg5K3B2WXk1Z1p3eUYzS3lpQ205QjlUR0VP?=
 =?utf-8?B?TWc1ajNwTHEycytyRE1UQjNvM3RRdDREemd1ZFY2K0VrZ2V1K3l2TUgrSWpx?=
 =?utf-8?B?QkUzSXlpMWdxbjdCTVpEZjFLQTQ3SjEwcGk2OExyRytyVmNKcG1xRzdVZ0pB?=
 =?utf-8?B?Q29aMFk1YTAxTlVjemdid2doWnJtLzUrazZZbU8xT1lKaHBod3dmKzZIbkVE?=
 =?utf-8?B?aEx6d2xjaUhPNmtaNzRaWndtRWtFQitkbWd6VFVTUXRaNEg3TjBXTTZDcVFR?=
 =?utf-8?B?MWVzYjdOUmJNeGhVZWVDc2VFc1Z5NmFDSkFwT0xwU2M4RnZBQ0JqenJZTVVs?=
 =?utf-8?B?WGQxTEVFVjBrTU96N3IyWUlqenpqYW1DQTdxVzdoRkhWNWNmQ3V3TndvSzdX?=
 =?utf-8?B?aW1OYUJGNEFob2R6cjVnSXRsdHhNWHpkTEZtQ3J6SFlDVFVRMUxpMWNXSUs3?=
 =?utf-8?Q?hOUz6WHNVjX0XCNPuw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVTUDhSNmhoWnJHdEl6ckZ0R3AyemY2aDkxaytPWFcrRnU2VDFVY2cyZXhn?=
 =?utf-8?B?bnBicEk5SWFLQzM1Zisyc2tOem85dTJjckVFSURuanpkSit4Ukk2N0Rpakho?=
 =?utf-8?B?RFdkWEJ0TTNiajl5MUg2VG1oaWluYlJpdjliaVdFa3FzV1RKemxkTzVZK0RM?=
 =?utf-8?B?MTVpSldMVXVFaVZnNE40L2h3RUJHaXVYTFA2cjlpa0w0SWJjY0xDdlpNVkJY?=
 =?utf-8?B?QUE5bzFLT0pONTRrOEJwNE9GZkVoOS95R1JNYXRuVXR0UXpLZ0NSQWVYelQ5?=
 =?utf-8?B?U2l3MHVLVFBuMXpkQUM0Rlc1Ykd6dW9RS0F6aCtPVDRkbFBSNVNtQVJ3Wm05?=
 =?utf-8?B?NGp6YTZpNVpkTTBwK1pNNjE0ZU8wcVFSOG1Mb2R6Uks3dDNPMHQrRk44YU0w?=
 =?utf-8?B?bTJTNFJvVytOckRtNnBEeDFGZ0ZGVWU5YTNubGN3VTkwZlhPc0FzUWN6WDJW?=
 =?utf-8?B?MU5PY1kwOEcwN1NkaWVYYXhrUGE0ZmlLL0x6dVNqbXlXQU5GcmFKWVhnWTA4?=
 =?utf-8?B?RURUOEFPdjNZajY5Nm5WNFpGSU5iRTFPYXVIZ3ljZ2UwaFg2bXBTdVR4ZDJF?=
 =?utf-8?B?TFVuN2hEU3dleW9VV3hNamRpZ1owMUorRzlISGFCcHZLWFJkMlQxdnpSek1o?=
 =?utf-8?B?eTBGTGFVY09oYmVQbE5CK0xLRkltTUpaeVhlRFpweWFkTjRtZzZEV2dRbnd1?=
 =?utf-8?B?R2ptMTBQaGJQR1FrUm5RejA1ZGtVT2tibW1tZkxWczZIUlJOUzdPeXFyU0Ir?=
 =?utf-8?B?NDM0UzNybm41N3ZPU2dxZEdSSTFTUmRxaGJPV1NmcTFXVWxPWUNzaFdOOVRC?=
 =?utf-8?B?T25KVng4dVJqd1lmb0FFeURzUFZBNjBVV2FDT0I2clhacVNlWG9rQmJDSndJ?=
 =?utf-8?B?VEdab1RpSW91UlJ1THZZeEN2ODM2RmNTeFRVOWhqSER5MkorMzIxZ3QweTQ5?=
 =?utf-8?B?QjJVOWliUTllK3BCWFFzYWFMZjZqMmcyU0c4U1JMemFOaElyUjBJVXBOeVpN?=
 =?utf-8?B?OTZJMEJ0cTV6WHZvR3VaQllQNDA2eUZEenUvOUc0SWdybzJBbVRxcUF2L0FW?=
 =?utf-8?B?S3ZvMGo3YVRvVG9OTWJuMjN2dFVDMk9vZzFMaVQ5REE0WTJKZUliRXhPd1Jp?=
 =?utf-8?B?eTRwWFp2ZVZqMFVzSy9aWmdvRW9QMmNLYzhvYyt3dkI4amZQVUVRaDRaUkZ1?=
 =?utf-8?B?YS9tQnp1TW1HNjJueVh6eS84cldKYjI5OEdBUml5Qm9hbDBkQnpuUm9xRHhV?=
 =?utf-8?B?ZWt6ejVYUlRBZU84NmJHYXl1a3U1Wk56YlF5QVFOb3ptMDhRMXI0WFVsaHdO?=
 =?utf-8?B?cDI3NDdENmdQdW5pSUt1ZW9BWXllK3JxMVVEb2x4TExUaEdydnRVcUY2TFVh?=
 =?utf-8?B?TUp4ZEd3dzhYUmJCWHRpejdwNmV6SEtpN052YjlQeDducTdOUkZrQ0c2RHNu?=
 =?utf-8?B?SzZIZHduOXB1MUlxczBLc3RXUzNSU0NPWDhNWFV5V01xOWF1WnovVGtVWHFT?=
 =?utf-8?B?aWUwNnhvcXE0QjBTWHlyV1NnTUNLZUlWVFRJaFRYZytSd0NPZTdraWFETzJz?=
 =?utf-8?B?N0dYNjhTSzBSOHBMSWdlbENIVEVTVGlYa0pXWW11NDVKRll4c25DOFN0akVH?=
 =?utf-8?B?Y253azZqR0xROGpJUnlqUUo5aHFZc0o3R2x0SXhMTkJQK0RLcERoNldxSlM2?=
 =?utf-8?B?YU9ERVBkL1ozaGtYVGJLaU5nRjNhT0x2TGIrYnRid0t5TE5ZMjdJR21INENE?=
 =?utf-8?B?OUhSV09NZllPd3NCbzZmZGVpRWR3VlhwOEd3YUFHVmEwNUxCODB1aTYxR0VK?=
 =?utf-8?B?c2YvZHV3blRBdUEvKzNzbXd2Qm50NG5OSlZDVVFwYWJYcWdYSlQzS0RQY3E3?=
 =?utf-8?B?L1JCQWR1OE56ZXRQTVlSR0tLTFJxUFJvd0FzRmtTVHFpN1NJZXBxQXdhM01Z?=
 =?utf-8?B?a2VITDVrdmFWZTJMVGhSUmpnbGtPZFpjRENRZWVlMjZlMGc1cXM3NmhuZ2Nh?=
 =?utf-8?B?OE1EY1VYaFZMeWs4M29MOEdFVUtmYnBGOGpZai9JZUdPOXRCUWdSOEQ0bEt6?=
 =?utf-8?B?M0VXQ3dEMG95U2FJOHdGN1FVKys1NDV1TTloY1hBNERMempsbXlBUUEwSXdO?=
 =?utf-8?Q?EXzJL/hv86uuTWTAFb+VfJ94y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf2aa40-8d9e-4de9-993c-08dd03b51f08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:31:00.4605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qk9zo8b51DVjx6Hw88/Njgn/sUuIfC4COWGrKn+45jFScDR77T718eldx7SXZQpZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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



On 11/13/2024 11:27 AM, Alex Deucher wrote:
> On Tue, Nov 12, 2024 at 11:59 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 11/13/2024 1:58 AM, Alex Deucher wrote:
>>> smu->workload_mask is IP specific and should not be messed with in
>>> the common code. The mask bits vary across SMU versions.
>>>
>>> Move all handling of smu->workload_mask in to the backends and
>>> simplify the code.  Store the user's preference in smu->power_profile_mode
>>> which will be reflected in sysfs.  For internal driver profile
>>> switches for KFD or VCN, just update the workload mask so that the
>>> user's preference is retained.  Remove all of the extra now unused
>>> workload related elements in the smu structure.
>>>
>>> v2: use refcounts for workload profiles
>>>
>>> Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Kenneth Feng <kenneth.feng@amd.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 128 +++++++++---------
>>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  13 +-
>>>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 +--
>>>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 +--
>>>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 +--
>>>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
>>>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
>>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 ++---
>>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +--
>>>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  33 ++---
>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
>>>  12 files changed, 162 insertions(+), 171 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index c3a6b6f20455..41b591ecfb64 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
>>>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>>>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>>>  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
>>> +static void smu_power_profile_mode_get(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode);
>>> +static void smu_power_profile_mode_put(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode);
>>>
>>>  static int smu_sys_get_pp_feature_mask(void *handle,
>>>                                      char *buf)
>>> @@ -765,6 +769,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
>>>       smu->user_dpm_profile.fan_mode = -1;
>>>
>>>       mutex_init(&smu->message_lock);
>>> +     mutex_init(&smu->workload_lock);
>>>
>>>       adev->powerplay.pp_handle = smu;
>>>       adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>>> @@ -1268,9 +1273,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>>       INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>>>       atomic64_set(&smu->throttle_int_counter, 0);
>>>       smu->watermarks_bitmap = 0;
>>> -     smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> -     smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> -     smu->user_dpm_profile.user_workload_mask = 0;
>>>
>>>       for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>>>               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>>> @@ -1278,33 +1280,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>>       atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>>>       atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>>>
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>>> -     smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>>> -
>>>       if (smu->is_apu ||
>>> -         !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
>>> -             smu->driver_workload_mask =
>>> -                     1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>>> -     } else {
>>> -             smu->driver_workload_mask =
>>> -                     1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
>>> -             smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> -     }
>>> -
>>> -     smu->workload_mask = smu->driver_workload_mask |
>>> -                                                     smu->user_dpm_profile.user_workload_mask;
>>> -     smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> -     smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> -     smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
>>> -     smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
>>> -     smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
>>> -     smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
>>> -     smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
>>> +         !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
>>> +             smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> +     else
>>> +             smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> +     smu_power_profile_mode_get(smu, smu->power_profile_mode);
>>> +
>>>       smu->display_config = &adev->pm.pm_display_cfg;
>>>
>>>       smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>> @@ -2252,24 +2234,41 @@ static int smu_enable_umd_pstate(void *handle,
>>>  }
>>>
>>>  static int smu_bump_power_profile_mode(struct smu_context *smu,
>>> -                                        long *param,
>>> -                                        uint32_t param_size)
>>> +                                    long *param,
>>> +                                    uint32_t param_size,
>>> +                                    bool enable)
>>>  {
>>>       int ret = 0;
>>>
>>>       if (smu->ppt_funcs->set_power_profile_mode)
>>> -             ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
>>> +             ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size, enable);
>>
>> Have a different expectation with refcount; not expecting to see
>> enable/disable. I think only switch power_profile_mode is required.
>>
>> Workload mask is then created based on non-zero refcounts in this array
>> - smu->workload_refcount[]. If it is different from the current mask,
>> then it's applied.
> 
> I tried that originally, but the problem was the custom profiles.
> They need a bunch of extra parameters so it seemed easier to just
> leave the set_power_profile backend API as is.  Although thinking
> about it more I can save them off in amdgpu_smu.c when I update the
> ref count and then just pass the mask to the backend set_power_profile
> API.  

Does the requirement translate to always do a force update if
smu->power_profile_mode == custom? If so, this can be checked/done in
backend.

Thanks,
Lijo

Additionally for resume, we need to make sure the current
> profile gets sent to PMFW.  Once again, thinking about it more, I can
> just clear the backend workload_mask on suspend and then on resume, it
> won't match and will update.
> 
>>
>>>
>>>       return ret;
>>>  }
>>>
>>> +static void smu_power_profile_mode_get(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode)
>>> +{
>>> +     mutex_lock(&smu->workload_lock);
>>
>> I think this is not needed. DPM calls are already under lock, not seeing
>> a case where it could do toggle get/put at the sametime.
> 
> Will drop.
> 
>>
>>> +     smu->workload_refcount[profile_mode]++;
>>> +     mutex_unlock(&smu->workload_lock);
>>> +}
>>> +
>>> +static void smu_power_profile_mode_put(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode)
>>> +{
>>> +     mutex_lock(&smu->workload_lock);
>>> +     if (smu->workload_refcount[profile_mode])
>>> +             smu->workload_refcount[profile_mode]--;
>>> +     mutex_unlock(&smu->workload_lock);
>>> +}
>>> +
>>>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>>>                                         enum amd_dpm_forced_level level,
>>>                                         bool skip_display_settings,
>>>                                         bool init)
>>>  {
>>>       int ret = 0;
>>> -     int index = 0;
>>>       long workload[1];
>>>       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>
>>> @@ -2307,13 +2306,11 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>>>       }
>>>
>>>       if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
>>> -             smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>>> -             index = fls(smu->workload_mask);
>>> -             index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -             workload[0] = smu->workload_setting[index];
>>> +         smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>>> +             workload[0] = smu->power_profile_mode;
>>>
>>> -             if (init || smu->power_profile_mode != workload[0])
>>> -                     smu_bump_power_profile_mode(smu, workload, 0);
>>> +             if (init)
>>> +                     smu_bump_power_profile_mode(smu, workload, 0, true);
>>
>> Same here - not expecting to have init check here. Since workload_mask
>> is 0 during init and workload_refcount is changed, it will set the right
>> mask on smu_bump_power_profile_mode().
> 
> This was to cover resume so we apply the current state to PMFW on
> resume.  Otherwise, the driver would skip the state update because it
> thinks the state is already up to date.
> 
>>
>>>       }
>>>
>>>       return ret;
>>> @@ -2361,12 +2358,11 @@ static int smu_handle_dpm_task(void *handle,
>>>
>>>  static int smu_switch_power_profile(void *handle,
>>>                                   enum PP_SMC_POWER_PROFILE type,
>>> -                                 bool en)
>>> +                                 bool enable)
>>>  {
>>>       struct smu_context *smu = handle;
>>>       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>       long workload[1];
>>> -     uint32_t index;
>>>
>>>       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>               return -EOPNOTSUPP;
>>> @@ -2374,24 +2370,16 @@ static int smu_switch_power_profile(void *handle,
>>>       if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>>>               return -EINVAL;
>>>
>>> -     if (!en) {
>>> -             smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
>>> -             index = fls(smu->workload_mask);
>>> -             index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -             workload[0] = smu->workload_setting[index];
>>> -     } else {
>>> -             smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
>>> -             index = fls(smu->workload_mask);
>>> -             index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -             workload[0] = smu->workload_setting[index];
>>> -     }
>>> -
>>> -     smu->workload_mask = smu->driver_workload_mask |
>>> -                                              smu->user_dpm_profile.user_workload_mask;
>>> +     workload[0] = type;
>>>
>>>       if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
>>> -             smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
>>> -             smu_bump_power_profile_mode(smu, workload, 0);
>>> +         smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>>> +             if (enable)
>>> +                     smu_power_profile_mode_get(smu, type);
>>> +             else
>>> +                     smu_power_profile_mode_put(smu, type);
>>> +             smu_bump_power_profile_mode(smu, workload, 0, enable);
>>> +     }
>>>
>>>       return 0;
>>>  }
>>> @@ -3090,21 +3078,27 @@ static int smu_set_power_profile_mode(void *handle,
>>>                                     uint32_t param_size)
>>>  {
>>>       struct smu_context *smu = handle;
>>> -     int ret;
>>> +     long workload[1];
>>> +     int ret = 0;
>>>
>>>       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>>>           !smu->ppt_funcs->set_power_profile_mode)
>>>               return -EOPNOTSUPP;
>>>
>>> -     if (smu->user_dpm_profile.user_workload_mask &
>>> -        (1 << smu->workload_priority[param[param_size]]))
>>> -        return 0;
>>> -
>>> -     smu->user_dpm_profile.user_workload_mask =
>>> -             (1 << smu->workload_priority[param[param_size]]);
>>> -     smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
>>> -             smu->driver_workload_mask;
>>> -     ret = smu_bump_power_profile_mode(smu, param, param_size);
>>> +     if (param[param_size] != smu->power_profile_mode) {
>>> +             /* clear the old user preference */
>>> +             workload[0] = smu->power_profile_mode;
>>> +             smu_power_profile_mode_put(smu, smu->power_profile_mode);
>>> +             ret = smu_bump_power_profile_mode(smu, workload, 0, false);
>>> +             if (ret)
>>> +                     return ret;
>>
>> Here as well - no need to call twice with false/true. Put the existing
>> one and get the new one. If smu_bump_power_profile_mode call fails, then
>> we have to reverse the operation though - this is true for other cases also.
> 
> Good catch.  Will fix.
> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> +             /* set the new user preference */
>>> +             smu_power_profile_mode_get(smu, param[param_size]);
>>> +             ret = smu_bump_power_profile_mode(smu, param, param_size, true);
>>> +             if (!ret)
>>> +                     /* store the user's preference */
>>> +                     smu->power_profile_mode = param[param_size];
>>> +     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index fa93a8879113..da7558a65c09 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
>>>       /* user clock state information */
>>>       uint32_t clk_mask[SMU_CLK_COUNT];
>>>       uint32_t clk_dependency;
>>> -     uint32_t user_workload_mask;
>>>  };
>>>
>>>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)    \
>>> @@ -557,12 +556,12 @@ struct smu_context {
>>>       uint32_t hard_min_uclk_req_from_dal;
>>>       bool disable_uclk_switch;
>>>
>>> +     /* backend specific workload mask */
>>>       uint32_t workload_mask;
>>> -     uint32_t driver_workload_mask;
>>> -     uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>>> -     uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>>> +     /* default/user workload preference */
>>>       uint32_t power_profile_mode;
>>> -     uint32_t default_power_profile_mode;
>>> +     uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
>>> +     struct mutex workload_lock;
>>>       bool pm_enabled;
>>>       bool is_apu;
>>>
>>> @@ -734,8 +733,10 @@ struct pptable_funcs {
>>>        *                          create/set custom power profile modes.
>>>        * &input: Power profile mode parameters.
>>>        * &size: Size of &input.
>>> +      * &enable: enable/disable the profile
>>>        */
>>> -     int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
>>> +     int (*set_power_profile_mode)(struct smu_context *smu, long *input,
>>> +                                   uint32_t size, bool enable);
>>>
>>>       /**
>>>        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> index 4b36c230e43a..1e44cf6fec4b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>>>
>>>  static int arcturus_set_power_profile_mode(struct smu_context *smu,
>>>                                          long *input,
>>> -                                        uint32_t size)
>>> +                                        uint32_t size,
>>> +                                        bool enable)
>>>  {
>>>       DpmActivityMonitorCoeffInt_t activity_monitor;
>>>       int workload_type = 0;
>>> @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>>>               return -EINVAL;
>>>       }
>>>
>>> -     if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>>> -          (smu->smc_fw_version >= 0x360d00)) {
>>> +     if (enable &&
>>> +         (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>>> +         (smu->smc_fw_version >= 0x360d00)) {
>>>               if (size != 10)
>>>                       return -EINVAL;
>>>
>>> @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>>>               return -EINVAL;
>>>       }
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>       ret = smu_cmn_send_smc_msg_with_param(smu,
>>>                                         SMU_MSG_SetWorkloadMask,
>>>                                         smu->workload_mask,
>>>                                         NULL);
>>> -     if (ret) {
>>> +     if (ret)
>>>               dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>>> -             return ret;
>>> -     }
>>> -
>>> -     smu_cmn_assign_power_profile(smu);
>>>
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int arcturus_set_performance_level(struct smu_context *smu,
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> index 211635dabed8..d944a9f954d0 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>>>       return size;
>>>  }
>>>
>>> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int navi10_set_power_profile_mode(struct smu_context *smu, long *input,
>>> +                                      uint32_t size, bool enable)
>>>  {
>>>       DpmActivityMonitorCoeffInt_t activity_monitor;
>>>       int workload_type, ret = 0;
>>> +     uint32_t profile_mode = input[size];
>>>
>>> -     smu->power_profile_mode = input[size];
>>> -
>>> -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>>               return -EINVAL;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>>               if (size != 10)
>>>                       return -EINVAL;
>>>
>>> @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>>       workload_type = smu_cmn_to_asic_specific_index(smu,
>>>                                                      CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> +                                                    profile_mode);
>>>       if (workload_type < 0)
>>>               return -EINVAL;
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>>                                   smu->workload_mask, NULL);
>>>       if (ret)
>>>               dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>>> -     else
>>> -             smu_cmn_assign_power_profile(smu);
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index 844532a9b641..4967e087088b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>>>       return size;
>>>  }
>>>
>>> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
>>> +                                              long *input, uint32_t size,
>>> +                                              bool enable)
>>>  {
>>>
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> +     uint32_t profile_mode = input[size];
>>>       int workload_type, ret = 0;
>>>
>>> -     smu->power_profile_mode = input[size];
>>> -
>>> -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>>               return -EINVAL;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>>               if (size != 10)
>>>                       return -EINVAL;
>>>
>>> @@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>>       workload_type = smu_cmn_to_asic_specific_index(smu,
>>>                                                      CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> +                                                    profile_mode);
>>>       if (workload_type < 0)
>>>               return -EINVAL;
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>>                                   smu->workload_mask, NULL);
>>>       if (ret)
>>>               dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>>> -     else
>>> -             smu_cmn_assign_power_profile(smu);
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> index f89c487dce72..b5dba4826f81 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>>>       return size;
>>>  }
>>>
>>> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>>> +                                       uint32_t size, bool enable)
>>>  {
>>>       int workload_type, ret;
>>>       uint32_t profile_mode = input[size];
>>> @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>>>       }
>>>
>>>       if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> +         profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>>               return 0;
>>>
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> @@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>>>               return -EINVAL;
>>>       }
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>>                                   smu->workload_mask,
>>>                                   NULL);
>>> -     if (ret) {
>>> +     if (ret)
>>>               dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>>>                                       workload_type);
>>> -             return ret;
>>> -     }
>>> -
>>> -     smu_cmn_assign_power_profile(smu);
>>>
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> index 75a9ea87f419..2d1eae79ab9d 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>>>       return ret;
>>>  }
>>>
>>> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int renoir_set_power_profile_mode(struct smu_context *smu, long *input,
>>> +                                      uint32_t size, bool enable)
>>>  {
>>>       int workload_type, ret;
>>>       uint32_t profile_mode = input[size];
>>> @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>>>       }
>>>
>>>       if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> +         profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>>               return 0;
>>>
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>>>               return -EINVAL;
>>>       }
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>>                                   smu->workload_mask,
>>>                                   NULL);
>>> -     if (ret) {
>>> +     if (ret)
>>>               dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>>> -             return ret;
>>> -     }
>>>
>>> -     smu_cmn_assign_power_profile(smu);
>>> -
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> index 80c6b1e523aa..3cc734331891 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> @@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>>>
>>>  static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>>                                             long *input,
>>> -                                           uint32_t size)
>>> +                                           uint32_t size,
>>> +                                           bool enable)
>>>  {
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> +     uint32_t profile_mode = input[size];
>>>       int workload_type, ret = 0;
>>>       u32 workload_mask;
>>>
>>> -     smu->power_profile_mode = input[size];
>>> -
>>> -     if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> +     if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>>               return -EINVAL;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>>               if (size != 9)
>>>                       return -EINVAL;
>>>
>>> @@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>>       workload_type = smu_cmn_to_asic_specific_index(smu,
>>>                                                      CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> +                                                    profile_mode);
>>>
>>>       if (workload_type < 0)
>>>               return -EINVAL;
>>>
>>>       workload_mask = 1 << workload_type;
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= workload_mask;
>>> +     else
>>> +             smu->workload_mask &= ~workload_mask;
>>> +
>>>       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>>>       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
>>>            ((smu->adev->pm.fw_version == 0x004e6601) ||
>>> @@ -2658,25 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>>                                                              CMN2ASIC_MAPPING_WORKLOAD,
>>>                                                              PP_SMC_POWER_PROFILE_POWERSAVING);
>>>               if (workload_type >= 0)
>>> -                     workload_mask |= 1 << workload_type;
>>> +                     smu->workload_mask |= 1 << workload_type;
>>>       }
>>>
>>> -     smu->workload_mask |= workload_mask;
>>>       ret = smu_cmn_send_smc_msg_with_param(smu,
>>>                                              SMU_MSG_SetWorkloadMask,
>>>                                              smu->workload_mask,
>>>                                              NULL);
>>> -     if (!ret) {
>>> -             smu_cmn_assign_power_profile(smu);
>>> -             if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
>>> -                     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                            CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                            PP_SMC_POWER_PROFILE_FULLSCREEN3D);
>>> -                     smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
>>> -                                                                             ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
>>> -                                                                             : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> -             }
>>> -     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> index c5d3e25cc967..1aafd23857f0 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> @@ -2528,22 +2528,23 @@ do {                                                                                                  \
>>>       return result;
>>>  }
>>>
>>> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
>>> +                                           long *input, uint32_t size,
>>> +                                           bool enable)
>>>  {
>>>
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> +     uint32_t profile_mode = input[size];
>>>       int workload_type, ret = 0;
>>>
>>> -     smu->power_profile_mode = input[size];
>>> -
>>> -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> +     if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>>> +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>>               return -EINVAL;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>>               if (size != 8)
>>>                       return -EINVAL;
>>>
>>> @@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>>       workload_type = smu_cmn_to_asic_specific_index(smu,
>>>                                                      CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> +                                                    profile_mode);
>>>       if (workload_type < 0)
>>>               return -EINVAL;
>>>
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>>                                   smu->workload_mask, NULL);
>>>
>>>       if (ret)
>>>               dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>>> -     else
>>> -             smu_cmn_assign_power_profile(smu);
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> index 59b369eff30f..b64490bcfd62 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> @@ -1719,21 +1719,21 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>>>
>>>  static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>>                                             long *input,
>>> -                                           uint32_t size)
>>> +                                           uint32_t size,
>>> +                                           bool enable)
>>>  {
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> +     uint32_t profile_mode = input[size];
>>>       int workload_type, ret = 0;
>>> -     uint32_t current_profile_mode = smu->power_profile_mode;
>>> -     smu->power_profile_mode = input[size];
>>>
>>> -     if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> +     if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>>               return -EINVAL;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>>               if (size != 9)
>>>                       return -EINVAL;
>>>
>>> @@ -1783,23 +1783,24 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>>               }
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>>> -             smu_v14_0_deep_sleep_control(smu, false);
>>> -     else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>>> -             smu_v14_0_deep_sleep_control(smu, true);
>>> -
>>>       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>>       workload_type = smu_cmn_to_asic_specific_index(smu,
>>>                                                      CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> +                                                    profile_mode);
>>>       if (workload_type < 0)
>>>               return -EINVAL;
>>>
>>> -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>> -                                                                               smu->workload_mask, NULL);
>>> +     if (enable)
>>> +             smu->workload_mask |= (1 << workload_type);
>>> +     else
>>> +             smu->workload_mask &= ~(1 << workload_type);
>>>
>>> -     if (!ret)
>>> -             smu_cmn_assign_power_profile(smu);
>>> +     /* disable deep sleep if compute is enabled */
>>> +     if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>>> +             smu_v14_0_deep_sleep_control(smu, !enable);
>>> +
>>> +     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>> +                                           smu->workload_mask, NULL);
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index fd2aa949538e..63c4f75fa118 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>>>       return ret;
>>>  }
>>>
>>> -void smu_cmn_assign_power_profile(struct smu_context *smu)
>>> -{
>>> -     uint32_t index;
>>> -     index = fls(smu->workload_mask);
>>> -     index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -     smu->power_profile_mode = smu->workload_setting[index];
>>> -}
>>> -
>>>  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>>>  {
>>>       struct pci_dev *p = NULL;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index 8a801e389659..1de685defe85 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>>>  int smu_cmn_set_mp1_state(struct smu_context *smu,
>>>                         enum pp_mp1_state mp1_state);
>>>
>>> -void smu_cmn_assign_power_profile(struct smu_context *smu);
>>> -
>>>  /*
>>>   * Helper function to make sysfs_emit_at() happy. Align buf to
>>>   * the current page boundary and record the offset.
