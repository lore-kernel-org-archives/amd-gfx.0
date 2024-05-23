Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B8C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 20:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2AA10F37B;
	Thu, 23 May 2024 20:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EqbwtaO1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA14810F37B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 20:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hafSi2dmSOLAAxAJrqEZOEiLmptnCKyVVqhHkmsoMy+/9BplRA49+9RMJcFS0bL4pcIMRZzFqyY24mFVYaUvGxTbaAdOyShK5yF/zEqLL9oqRJYQZl5cnxe18VLAIOCVwGeE46A7V3deGy5wcxUmZ6yQgXxf1Xi398HFVl4W++U398ksPBV5SRIcouYBFj69nlKmKKRuQPyUt2LLKkNVSxWsC2LaRW0vnC8Y7oJWdD77eCk9+c2D7NHf2gTDtr5IwLY+fmixp1JGYkFUjq0N38HZlWAlqAQ3l18MAKO0hriTC3USOJ02yEoFeYNrkvD+XvW1iV0eigpqbpRxeSdsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkPckrF/Y0lcOJtpfHrI8LXTtthypUhrON0bGHVSSeM=;
 b=XmewoH5UbfVE4hMbxeYBev3Axwq/omTOG1ONt1Zsjz5bj79qz9yzBdRbtrdQX8oUelikT96+kHnwIcVO76vfCIaXBKqgWoOLEJRdGRtqAeW+sNDiW5s/veu62hTfhp3BYmRfJ08K00/9y7PV+xMK4q9QFV0vKwuo6RiY7i+BUK+4/kfU30pbmeGEgODcSRREA2gtcgA6cWA64YPDe4GqV3NR+rhKrWGYCl6+PREY3VKzTgJ/jxnuLvvnDUobCMZv70TSl6h+C8p0FvNhBlsU2JtjIzn8TlH71I6VZUEtT8E7zvfY9E/Py+1fVpgkM/HmBMeUUgmuSB7P6rVCfxXmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkPckrF/Y0lcOJtpfHrI8LXTtthypUhrON0bGHVSSeM=;
 b=EqbwtaO14dF4+s0m7oOO/pPI1+HeY4yIm4uM6e1nNMa2lCqtumBfPAoUv0mMbsUKNc7YvusKSGmSaKMxX1lrtezPpPAuWi8mETN+nwYWqWBlUX08b5fL7y0kMS+Hblsn7LTq80yroLjcH09nrggWWnjarWh0T7H7wjST5SbIESI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 20:41:31 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 20:41:30 +0000
Message-ID: <80be9075-991e-4102-a21c-56aac3570a36@amd.com>
Date: Thu, 23 May 2024 21:41:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: gfx12 context save/restore trap handler
 fixes
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240523140809.1135226-1-jay.cornwall@amd.com>
 <20240523140809.1135226-3-jay.cornwall@amd.com>
 <6572dc07-fa47-412c-9ad3-ace0c3914cc5@amd.com>
 <4f0a5ff8-ba6b-4db0-8e61-4e8a3b74fcc7@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <4f0a5ff8-ba6b-4db0-8e61-4e8a3b74fcc7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: de590432-46ac-4c71-0d23-08dc7b68b9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q21sOUsyNlRnVklPbU9ET0xFbGF1R05lekRuZnFaOHJFN3V6RUhFQVAxaVVH?=
 =?utf-8?B?cFZQK1RUbEhEanNVYXV6R3JnTnUrWkpHZWhrYUJlRnBtYmdCUlV5cDkwa2d0?=
 =?utf-8?B?Y3NTRFZsTjFSZ2FsM0J5SmYrTERkSDJGQkhHUDA0NGhUb01BYUo1LzFLSC9V?=
 =?utf-8?B?Y0llTnBqRlZHZVAwNmZFOUE0Q0VYVmhGVUdpZS9vZ09LUmdPVDFIamhmWjVG?=
 =?utf-8?B?RkN1WXdnUDA4WlZ4eUY0VzJZcGxFSmxDL1FGMzZVN1M0ZmIrUjY2cE1BOGg2?=
 =?utf-8?B?dUw0Z25QdVpsLyt6UGpad1NyMWEvdkRJNmNNR2JwaUpxZU84dk9kTE1hbFlR?=
 =?utf-8?B?clVSVDEreDhUaTVPdGhzRlI5QTNXSFV1aXJBbVhuVjZsUmU0WW1aYzhIR2VJ?=
 =?utf-8?B?Z1VQQnhMSEZkdTdTaEtONGRlUnhkaTF0TVR2eG1MZjNNNWZ3R0N2Sy9NSlQv?=
 =?utf-8?B?NFc5Z0FYeWlIOUZYN0ZmYkw4ZjJxOWJYT0E1R0Q1QjRTL2lTU1RETTJ6RjFS?=
 =?utf-8?B?RVJjTTEwOFFvRGZka0JUeWpSTEhOdkU2Si9XQWhXaG1lZ1lGb0dIY3FwTjRm?=
 =?utf-8?B?NG1aRU1LbitBWU8zNXNidDZKRCtNVkFZNkRSTm5PcDRDQVhMcUQ0ZGZFSTZJ?=
 =?utf-8?B?ODBIUmNuSnNBck5heG1qQU9XaTlHTGQvSVdUNzB5RmhKMzJ1RytudVJRQzha?=
 =?utf-8?B?N05RaDNsT2RaZThZVlVyQnVlM0txa2ZVWEw2R3dKdDhObm55L1ZDS2dSRkJ0?=
 =?utf-8?B?eklmWVU2alY2R21tcW52MDh6R0ZBMHNQd0RVUSthd1NKY1AwWWVpU3FoeFQx?=
 =?utf-8?B?MG83d1BHVHplbHdCeDZGWkRUVWlIajFKSjJIRkU1VWo3aStNUllyUFNGazR2?=
 =?utf-8?B?S0g1dmxCTm9WUkJOZ014MnFERW5ZWXN2WEw0NmUwOC9qTVhWaTJnQ2RNc3Ra?=
 =?utf-8?B?NVRzNUhFT1lHZ3BSZHVLOHVJZktoUHpnZmdsMW9XN2RQdWJsaGtlT21pVElo?=
 =?utf-8?B?VnExRG9DYVFhbHY3cytyelBUVDgvaG1UMVdjTTRpUloyUEdHbnRpWjFncnNt?=
 =?utf-8?B?WlNiRS9RMVQ4a0lSbFl2VFJvNit4bUxqUmFCa0RyeGRBb0FQVzROTjVtbVVv?=
 =?utf-8?B?QVFoVkZmMEg2VGRiNjE0Mk5MK1ZsWTB3UkxhTFZOOC8zSEdvb2wrSjRzMDlP?=
 =?utf-8?B?bzh0b3BDdTVSUk9sUGRUREJ4Qm1QcXZ1VzhHUnBhN2l5RDY5N2JlcytpcU1Z?=
 =?utf-8?B?eklFSndEek5EelBpNnZQN2tFTWQ3cmRQRW1vN21qcmY5cG5JNnlqQmFLMzdi?=
 =?utf-8?B?R016OGRPOEZWTzhlZTBHTDF6TUlhNkw3UnFFSnNZN0lSUlkvRjF4UVkvRno2?=
 =?utf-8?B?Sm5pdERyREZLd3VFck10UUUrdmhwTi9CVGRHVm8wOXcxSVJZRm5CTVN1b1VG?=
 =?utf-8?B?YWtXazFEOHpGaERCVlgyY1k5WW9XYk5LR0szT3JWdXk0Njc3dm1FclUzUGgr?=
 =?utf-8?B?VWVPaTRDc3Z0T0h5SSt6eTMzaUs5dGo4Zzh3Y3k5UFo2S2tkSkw0b3l2RGlh?=
 =?utf-8?B?L0lqeWdHYUZuZ1NUbHRmVWNkdTBOMkpmUUtwU3A4VjdVMHBEMTJid2F2Vlg2?=
 =?utf-8?B?eXNFcWNwS1hHZW1zV05hSG83aGM4dGErbGZvR0diYUljaVpuek56enZBcmVu?=
 =?utf-8?B?OTJCaXJDK1FiY01PS3QzRk5IM210QngzTVY4QzEzKzQ2R0tQdkRiamFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZUVUlvNmZVcHA4N0VhQ3MwS256ZkhQYklwbGx3TFljQ0hac3RMNXhUakdm?=
 =?utf-8?B?OUVoaEtWaDZLeUhTQnJYWDhacEpCVXR2c3Rhd3FWNjN3SjVTeC9saUhabzlG?=
 =?utf-8?B?KzlXTmgzSXpjRndNNXdkRWNGRUsrZWZoK2prejRDcFRpNEVzSmg0WjV5WE5H?=
 =?utf-8?B?N2V4VUFqTzZFRzJDTnFHMFZEY1JXVFUyTzZKMTZoUGd5SWJVaEF0ZzA4WTNT?=
 =?utf-8?B?OVcrV2JpcnRPbjRPU0xaODYyQThFNE9RQ0RSTXJCdkxwdW9mTXM3UjdwUE9J?=
 =?utf-8?B?VHlUZXhDOTN4SDNZSzhQNSsxLzV1NDd3Y3ZMbVFFd1Z0QkthMHlheVJMYWFp?=
 =?utf-8?B?NXFud1VPMmJRUzk0T2tseS9TYXljYnVwdTBrSUlJVjNFQ09FOVdRR0puTi9Q?=
 =?utf-8?B?MHlFRHdxSjA3Rng1TE9NdG5MWmFldHBYT2VGZ0pxdmFwbVY4Q2ZETWwzZncz?=
 =?utf-8?B?aGRkWGFib2JzS2RMdlZjN3hmUkZGVHZqdVRoRjhOaVpHNDloMHNjN1dDMEt6?=
 =?utf-8?B?N3VuUm5HVkQ1WnJhNUQwVkVEYVdsZ0Z0bHhEU0Q0Q1ZiRHV5cHZFZnBhL2VD?=
 =?utf-8?B?ckUyKzZENldiZ2pNREgwbDcrcmp2NmFMSFF6dlBCa3FOQUxndkhkd1hLbHl6?=
 =?utf-8?B?aXdVcHNRcmhBOVpBZVZ0Z0hlTHEzaWRsQUN0VWVYMWJHajJGclJSMHowTTVn?=
 =?utf-8?B?NStTQmlTWVhLZ0pQd3p2RU0xNVJyYUhVdHNxeDVIRzFQRlNzVEl6TWNtSDBV?=
 =?utf-8?B?VjNkUEhrUTAyWkd3VHpBeDhjcDhpanltVjR3cGMzV2t3cmpCUVZkWHp5T2RF?=
 =?utf-8?B?eEVic3NLY0gvczdzamZMWW13VHVtcHlxOHQ3M090aGs2aS9tM3B1dlM5anpa?=
 =?utf-8?B?R3lHbnZsYTlONDRtV0V0TlcvYlRkU01xR05ndGpNSEMyZkdhemhrWHAzMjFX?=
 =?utf-8?B?eHVLK1orWmY5TDVoL203N2ExL2VUcUk3M29lZnZqakJYU0NVYXpWaWJzYktN?=
 =?utf-8?B?cFdGbG9CVi8xeUQ1aSszVWY3MUdndVZBN2pTVDB5aHI4Z0N5aCtWTllMNElw?=
 =?utf-8?B?MHZyQVFTOWNrbHV3aHNaZjkzRlRZd0V0MFJxWjFwcHhoeUhEbmJGSHAyZ0lD?=
 =?utf-8?B?eGo5Vm13K2xOWVZOeU5NWmMwVXNXOURDNWNZL005ZUZIdEwxNjZ5Y0tTL1lq?=
 =?utf-8?B?NzVLcEhuZWVGWG5FSTFvWTk4WnB2b3BoVWdGWEQ5WXluZGxrWUM4Z3ZpSHky?=
 =?utf-8?B?ODNzbEd5OVVURVNiVFE4U2hEZ0ExOWk3WGhmMGh0aEV4VVBCdk02R1hWQ0xz?=
 =?utf-8?B?OVBnSkZIbW9VN3pKTW9iMlg1MG1GUG5jbzVWTVdjdTRIQXpoUEROblVzTVVN?=
 =?utf-8?B?cDJ6QnczUVAxVktQOGpMd0kwSUN1TXZKM05BOGJqSGVTNGo5cllpTzh4OW1o?=
 =?utf-8?B?WGhnNnZSRC8rcmI3RDBPOWNOWDNabER1TlIzRkNXV0RIc1h3OFpHS3MrWFYr?=
 =?utf-8?B?a3FrK0c5Y29EYW9CZ0ZVZlpZVjlSa2RzazFZTVB0V3dUUzBLNUlzSmtYdHVx?=
 =?utf-8?B?cGRKVFR6L1N6MEVKaG9najBxb1M2OVpJa1pBdy83Mm1sbjNqOFhWMzBmZTdO?=
 =?utf-8?B?VEZWTWtSb2M4emQxazJrdDhaRlN5UU1tQjRNejIzV3pNU3QxRGQ1M2RQQlda?=
 =?utf-8?B?ZVBhKytySklGYUFxanBNREU3VFdlY3RIbjgvZ1M2dk5mZnJrQ25IWG1iTmpv?=
 =?utf-8?B?K2w3dU5yZXNBSG8vZWN3ZTNDVmJOem1FbWZkVjE5QXBQSzkwZjJHQlhMdDla?=
 =?utf-8?B?R1Q0VVVuTS92YWQxUlpJRGNVT3ZKd1JTTHJlNHVobmJ1RVdCNGtIN09yK29u?=
 =?utf-8?B?K2o1c2puQVp6SzR0ZGlZVEdhSkNsc1ZzZFhrNkdXczFVaWU1TEx2bmxjNW5N?=
 =?utf-8?B?TklEbHZiejVMVlk2THB4b0xZbnNKNmI4UnY0NUthWm0vbTVwMnpWcWtPTTM0?=
 =?utf-8?B?MnZtM0N0bEREeG55OVB1Nnc4RTNhcm5xOWJLaWVESWtCSEsyZWdubTU2bE1Q?=
 =?utf-8?B?dHRjTzJBRmRpN1VlTXJvYks5VENXU0FqZXU2S0ZHVlgvcmN3Z0g4T21vT1pw?=
 =?utf-8?Q?QYc2DHfEla0eVotV7EfUMyj7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de590432-46ac-4c71-0d23-08dc7b68b9e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 20:41:30.7237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjbhAzo6+T7E/YgQM45qBJxGYREQob+Z/5v4dG0W4UJSWE0nhh2BtCjniQvjiWdaUrj+IuJaMbsCKFtV3xqsPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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



On 23/05/2024 20:31, Jay Cornwall wrote:
> On 5/23/2024 13:37, Lancelot SIX wrote:
> 
>>> @@ -622,8 +638,15 @@ L_SAVE_HWREG:
>>>   #if ASIC_FAMILY >= CHIP_GFX12
>>>       // Ensure no further changes to barrier or LDS state.
>>> +    // STATE_PRIV.BARRIER_COMPLETE may change up to this point.
>>>       s_barrier_signal    -2
>>>       s_barrier_wait    -2
>>> +
>>> +    // Re-read final state of BARRIER_COMPLETE field for save.
>>> +    s_getreg_b32    s_save_tmp, hwreg(S_STATUS_HWREG)
>>> +    s_and_b32    s_save_tmp, s_save_tmp, 
>>> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
>>> +    s_andn2_b32    s_save_status, s_save_status, 
>>> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
>>
>> Even if BARRIER_COMPLETE can be asserted while we are in the trap 
>> hadler, I do not think it can be cleared.  That being said, it might 
>> be easier to just replace the bit, making it clearer.
> 
> Yes, I chose to structure it this way to make the intent clearer. We 
> don't gain much from dropping the s_andn2. Most of the time spent in the 
> save handler is stalled on memory instructions.
> 
>>> @@ -1351,7 +1369,17 @@ L_SKIP_BARRIER_RESTORE:
>>>       s_setreg_b32    hwreg(HW_REG_SHADER_XNACK_MASK), 
>>> s_restore_xnack_mask
>>>   #endif
>>> +#if ASIC_FAMILY < CHIP_GFX12
>>>       s_setreg_b32    hwreg(S_TRAPSTS_HWREG), s_restore_trapsts
>>
>> Wouldn't other gfx1x architectures have a similar issue when writing 
>> TRAPSTS here?  That is if TRAPSTS.SAVECTX is set while we are 
>> restoring, wouldn't we loose it?
>>
>> And for gfx11, there is TRAPSTS.HOST_TRAP that could have the same 
>> issue to some degree (not sure if we would loose the host trap 
>> completly, or re-enter with trap ID + HT bit set in ttmp1).
> 
> Prior to gfx12 context save and host trap exceptions are not delivered 
> to a wave until STATUS.PRIV=0, i.e. it leaves the trap handler.
> 
> The changes needed for gfx12 are due to a design change in this area. 
> Exceptions are now flagged immediately and cause re-entry to the trap if 
> any are non-zero.

Thanks for the clarifications.  The patch looks good to me.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.
