Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD67CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 09:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783E510E761;
	Wed, 15 Oct 2025 09:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLt347al";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18E210E761
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 09:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub/mBipKxUsWQWggg2lQKUHHoaZYTGU9sFpeymX9MMsUX3qzwrTWMFOndU169FMLdxcqBhHGe9wF3xkesMs4RfjBlqJ1doJekUWNelYkxwjGTEbAvI4ALA9WmifgUbxYCp2RnuX2SYNjr+z+iVcDDN6+dy2l519oAMhRmn7AtNyRygUTMXLe+UVmSRsrGh5Qpf6qBAesbKUT6SsQaEnZzeGyxeD4cBr/jQkGK8qUpTIBkET0mPHIh6w500c426eEKUJrLvxtxb9Euu6mhdVjjUtCfnUiQyJh3bLyuVZe/MvOo1tg3n6O3xhAUv8BLh0DhUh4OQcu3iIejccTkjFVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aQt/L8Kv6hGVtHjQAm5WN+QMhhZIcom/C1cvu5wilU=;
 b=N16EecpWxeUsUHiIBeM+XaIWymuCQvVFfqZRhxYxS7lj+dWXmdQ+PurhsVouMKj1beWSQuPmbTfVcH8NWGTHkkaEQpDPUBZk1+6POGH2xqs5o6772sNxvLLgOP7JL53jpBs0iPYDI/oJ2pKLMZSWwxIxrGurZvVE/TBCykL/sOAXaRsNkhYQsmdHcOLE6fN6HTC4n8kPudZK0ltIaEdQNLkdzlAKyowvgKkyR9mAgbBhhLHhWc/Zj24pr739UCgW98c3aC6rQjDWYNCv6BF0AsWXu7vep20huIlscc0KC7rFuetwNUApggGlqbplxSzbUiVEJlItczbzrbcQgOzN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aQt/L8Kv6hGVtHjQAm5WN+QMhhZIcom/C1cvu5wilU=;
 b=dLt347alC2pACSFTYRhG0N762uiGaDg+NNkN53IXax2YFVdW1tEnou/O2PvCDmIByUVwBuROT0/LT95FmrHLGqd18Xtw6Ff2HVd7W/9UTxfDoP38QMiDYiJwwBU0L4mz99gYkODRivG5TMjXV7QOE+rBvcQfijVbihrhtIvyvZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 09:09:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 09:09:55 +0000
Message-ID: <6bba8e00-325f-450e-aea2-18e17733df80@amd.com>
Date: Wed, 15 Oct 2025 14:39:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jeffrey.Chan@amd.com
References: <20251014201346.9422-1-yunru.pan@amd.com>
 <20251014201346.9422-3-yunru.pan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251014201346.9422-3-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0054.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d885db-d42c-42cf-0c4b-08de0bca9b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWF5T2xaU0xCUHA0cU5oMGdBU0VVSUQybklwQmk1em8rb1ZvMkpOazNtS1JR?=
 =?utf-8?B?a1h5UW4yRHBuZ09QVllsLzBlb1NoVFRtTmhnYnd4QnJkT2RLK29YT0ZFY2lI?=
 =?utf-8?B?UDBSa2FxZnJ1Z0JLTUcvc21odXlpRDBzanlUTklPak5BWWhrN1NkRElpR2hy?=
 =?utf-8?B?Z1JlUjlxQys0eG9IdEVhK0t6T0VLa0JUQStJK3VQTWZYVkNqcGVnZXhSd0Vh?=
 =?utf-8?B?cUZHczUvdlRJSnhTR2k4T1JJTW00QWFQMzRUenBQeWI1MkpuYVJuTzdxUEFE?=
 =?utf-8?B?VzR1UVB6bW85dFExazhuK0NFWm1OQkRHUTlEbVdRbDlzcjBoS2U5RW9pOEdw?=
 =?utf-8?B?OWRDT01FWXZ2UVN0Mm1UVUhtWmEvOVVOM0FOY09sZHppTjdmZVpPMUI0N2hT?=
 =?utf-8?B?dENPSEdVOTB3aURka2NyWFUrSFFsTE16WENRNmxLa2FOdkxpNEswNGhkeUxG?=
 =?utf-8?B?MzRqSUhoWUdzRGQ2YW9MVXV0akI4VUsyK2EvN1dOS041NzMwNWVTUEpDWEFE?=
 =?utf-8?B?WnN2cTVyVzMyM0hYZVNYUE0wUU5PRjNnQ0NqMGtDY0VMN2V3M2s2NzBuYlg0?=
 =?utf-8?B?b2kyK2g5VmxsOUowSVlkdDFyNlpSS2pwZUxWNnBpT1BkV3V5Y1RjVk8vNkZS?=
 =?utf-8?B?L0RFRmVSUFZ2N3Q2T2RLVWk2TVNkWElwN0wyOXhFeUJIMWxFdm0xU05Nd2oy?=
 =?utf-8?B?aS84QnhKYVh2WGZhcXoxdG5jWXdYcEI5b1RUa2FvT01lV1RQa2R3RVVKbUxN?=
 =?utf-8?B?bFhYUEJGd3UrZ3NMcVRvcWdvNnNvTnI2MkRDSzJ1Z2NubWVJa1NVWW80UFBy?=
 =?utf-8?B?NHZnL0JhYjJRdENtQ2VLNlR6MWdtenJvelpvY29oSk5WVEg4TURTam5rYVFV?=
 =?utf-8?B?L3hpSHNTRm5PbjhUSGJ6QkwvdlNoTFZjbjc2UElRQkxoRnRXcktxWFRmRjE0?=
 =?utf-8?B?Ris0bDFmbWV2eCtKU0hEMFFmd0E3a1dIMFh6alcwbHJMKzNxSEtGL0dWT3NT?=
 =?utf-8?B?aWZ4d2FiMSszaXpodHJQSjZscGxWMlloZmRiUHQvNGRVRDlONlF2OUF2YVlW?=
 =?utf-8?B?d0tWSVF6OTI4TTVxeVhIWmJmdWt4R1NoYXFNR2poMnNYeW9DWWh6eDloblRD?=
 =?utf-8?B?bW5ra2lEbnRWMVdRY0YvRmw3MUJWam1CUHhWNlp6WUFlazhhY1A5QVY2cXlF?=
 =?utf-8?B?amxKUW1EODYyU3UxbUJKTDlqc0E4eTlMemlOQjFZMUJDSEdmVFFhdjllQjho?=
 =?utf-8?B?WTRteWZXY09LdGpTRm03c0xVNlhqaVdwWXhuMlUrdGhoVlVBZHJHc2R1ZU81?=
 =?utf-8?B?NGQxaThCTDg1M0Q2ZDBlOTd6REllZ3dJYjdDOFZiYVllQXVSSDNzSjBjYWI0?=
 =?utf-8?B?KyszaVYxWVZnYnY0MVZNdEExMkpVaG5OZDhnMDI3QnhMaFBjYmFESk1yQ2J1?=
 =?utf-8?B?aGVYdFNJYmV5NzRVMSsrV1phMllwZ3FBTDhVUjVMTG9CMGd5bFhPRCtUN0tl?=
 =?utf-8?B?cnpUTzdTcE5QMW5CSkUrQ3phRDJ1RktMcnpFZVpqa0tKU1R2OFJBZUc5bGlW?=
 =?utf-8?B?TWZIczdDc20yaEl6dEorNHR3S1dyQjc0aGYrTXBXWkdkT3BtLzNJU2tNKzhB?=
 =?utf-8?B?bzZvUWd4UHExWlhPV09MdUhZK1MzNzlNa0pjZnJVZnZsTHhHSENsWHF1NUxv?=
 =?utf-8?B?QTlqbXhQQkpKYjg0T2swcTdudy81OXJEaFRqQmVNWXBjeEMxOCsyRDJ3RzYx?=
 =?utf-8?B?Qm9LcUpCZTAyK01haHJna0JWakFwSFZSOTlBUkxlaG5WSWJGOXdDbmFIT1pE?=
 =?utf-8?B?UDZQOTcyR1dlckdmUUliTXI2anpKSWI1TG11UnNYQkJCYzd2dUI4Q1A1YllQ?=
 =?utf-8?B?WlRhd3E5c1ZVUENvYkpRemd5OURmQnVScVpLZnNBMDRwdnVtNmZvZld6MUcx?=
 =?utf-8?Q?7UzEXpAQuWCevd1uYa3LdO1acX23GZov?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWovVFBtaDJZUm50eUlVbjJydkMvVVV0WjJxU2J1bHM0RThCQUd1QkZpRit0?=
 =?utf-8?B?MytQTi9NdU5LMHhWNzBjS1dXT1VxZjE3SENSTkFHaU9pMkpQcmlFcU41OFZL?=
 =?utf-8?B?TURSSUtPUnFTeUdkQjUvYjRXYlExR09EZ0pQODFJSHlGdStuQUhrR2JqaDd2?=
 =?utf-8?B?cmEyVkZaTktaOUNMVzAwZEdWOGkwT1JzSEpEditKczF1ZFNteDlad3doMDdF?=
 =?utf-8?B?aTNrT2R2N09rN0J1bGczOFVYdzJ2S2RWcFFSRzJYaExLUE9TZHBBbTh4ZkhY?=
 =?utf-8?B?aVNQSk1PWHF3dlExTVU4b2RYZGlFb1AzZ3pMV2tjK1FiS3hRamtZN3dNSUVm?=
 =?utf-8?B?UEZHRlE4eGlyWkdST1NBdDRmQldhakpVSWpIWVRjeFhHb1NhbGxkazBjbWNs?=
 =?utf-8?B?MmswUjVzb0x4QzNSdUNFbXRubHo1NmhmN0lJb2IrNkxYeTJ6SzVNT1RpaER5?=
 =?utf-8?B?dXBBSkRtd2FDRGV1ZDZ3VFc3aFNSY2Z1aFZ1b0Z3S3lTYnhlcmVjTjBmV2Vn?=
 =?utf-8?B?NkJ6RFRFQUdqZWpLR3NYbm9HZ2VkSjloNTA5QUJKRFB2aXovcTlhb0lOTUx1?=
 =?utf-8?B?RnFZQzVEb0EvRSs2djRuZ0hYS3FaUjdrZlBMYW8vbmtIWHFSRWx1dk9Sci9T?=
 =?utf-8?B?cWJ3MW5HL1FMZnkzUWU0QmNuSGk0blJqbThrc0M2R0ZZc2VERXJuejF0S2oy?=
 =?utf-8?B?RGMxOWZ0VDcwL2kzR3JzUkpSangzRUpMZldrWExBeTJHZ2lBZmZIOU1UbDdj?=
 =?utf-8?B?U2V5NTNCM2Y2UklCZFI0OGN0UWRYWU5YbGpLSHRoZitLY3FkSnZrRTR0N2Nn?=
 =?utf-8?B?bFBGakp3Y2czLzJWMG5GeUE5MmZSVXFEaWs3NHVCU05pOFhreXNPTUJRTEVZ?=
 =?utf-8?B?VjY4eGYxRW5sVVRkc09sUmFnVktNNC9hQXBUb25wcWtXNHhUQ2lRMDI5cll2?=
 =?utf-8?B?VlJZS2FyTkZJbnBZR3c2SGJNbGlLeG05ZWMramwrTHdpUkdFRnc2WEZFUEpM?=
 =?utf-8?B?SWpVTTlmRFRaMUFTTnNSOEpyU25QTVErNnQ4Rlh2TE5SU1hRMEZKTmJMVXdB?=
 =?utf-8?B?aHB3ZlkvV1pEUnFXcHRXemVZMTM1czhyZmpGQ2lUSnl3bHNTNWZpVnpOdGxm?=
 =?utf-8?B?VU5FMDVsd0xxcWtOK3lHODdkelhLTVlpQzhYVWVFeWZWRy92SlpSSEM4L0pa?=
 =?utf-8?B?Qk5GM1VuRGlaY003dGl1UnpGVlJmYStLZjVhRmg1Tjd5ayt1ekQ2T2JPUitS?=
 =?utf-8?B?SjVmN1hrcmRJazVpUkE0bU94b3cycUQza0dBeWh5K0haODFpVExjUGcvSnhk?=
 =?utf-8?B?SUR1cDJNN2R3WS9helJqc3I2SnNXRzlsMFdFdExiNWJtNVQ5S0FSZVZvYytN?=
 =?utf-8?B?SG95VmwvMFJTS0g4am1TR25rSEdxTEFSY2tCYzgzQXVjLytrRHF3TVJOYUtG?=
 =?utf-8?B?ZzQzU1NwYVhGTWdWaXB2ckZSMWpwWCtBeFlJV20zUzlOS0phWDMzVWJEMlhX?=
 =?utf-8?B?SVRSM0F0QjNBaXJzQlBJeVZGVHZ6M1hBWWpXUjBnL2FXMmQ0RURyZm9jNVds?=
 =?utf-8?B?MTVtRDhia2ExRE0yU3I3aXdyTzh0YUJ2dVJwa0VFMHNLUnV2SWZIbFBwWit0?=
 =?utf-8?B?NGdwZTloVksraE1jSklaZDRqUmx4MWJ0MXZFR3BWRWhFK1JYdXlIYnlnUmg3?=
 =?utf-8?B?TG4yQzdEOVg3RTdEZ3VUSk1RZkdmSk5SNDRLbDRXSi9CbzN6VFlNQytXZ2Zo?=
 =?utf-8?B?NkZDQVQ0UTB1NTAwTml1Ymozc1luN2lLR3hCWDM1VStiYzF3RmNhdW96bFFK?=
 =?utf-8?B?a2hRQnp0Z2l5UGlYVXlnTW9WYTJmSExFbmVnbEtiWFRsSm9tUEhvamNmcU9G?=
 =?utf-8?B?OU44T28vNzVZaXJQRTlKb21LMlpzeWQzQmJoblpQZGcrRU1mZmtIWFhuK0J2?=
 =?utf-8?B?T1Z2WTRYakdEYnFkM2pWNWZvR2JqNFowWEpCYXhHU21ZSmxHRjZYck9PMUFH?=
 =?utf-8?B?NS83a1BmVGJReHYxQk4vR2VHWnZqVEkyNlh2UzFPSi84a3dKYVhFN2MzNlZp?=
 =?utf-8?B?TU0rSFNvY0pQVlJVcUJENDAvcEo3Y0F4QjZ2Vi9RL2wxV21nYTRZWW5pVjVF?=
 =?utf-8?Q?XdfO8I9sXTtBHP9p97269mtGo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d885db-d42c-42cf-0c4b-08de0bca9b5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:09:55.5209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaBRx0Ub4M3mmVW8bRBur8zKXZiUGbOxzn4kpGBYSKw7BDum44CQFFcfazCHkwU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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



On 10/15/2025 1:43 AM, Ellen Pan wrote:
>      1. Introduced amdgpu_virt_init_critical_region during VF init.
>       - VFs use init_data_header_offset and init_data_header_size_kb
>              transmitted via PF2VF mailbox to fetch the offset of
>              critical regions' offsets/sizes in VRAM and save to
>              adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 106 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   9 ++
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
>   4 files changed, 150 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 929936c8d87c..351cfe03a1aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2754,6 +2754,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   		if (r)
>   			return r;
> +
> +		r = amdgpu_virt_init_critical_region(adev);
> +		if (r)
> +			return r;
>   	}
>   
>   	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 39ab7d00379b..27235f3f3b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -44,6 +44,8 @@
>   		vf2pf_info->ucode_info[ucode].version = ver; \
>   	} while (0)
>   
> +#define mmRCC_CONFIG_MEMSIZE    0xde3
> +
>   bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
>   {
>   	/* By now all MMIO pages except mailbox are blocked */
> @@ -843,6 +845,110 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
>   	adev->virt.ras.cper_rptr = 0;
>   }
>   
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
> +{
> +	uint32_t sum = 0;
> +
> +	if (buf_start >= buf_end)
> +		return 0;
> +
> +	for (; buf_start < buf_end; buf_start++)
> +		sum += buf_start[0];
> +
> +	return 0xffffffff - sum;
> +}
> +
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
> +	uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
> +	uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
> +	uint64_t vram_size;
> +	int r = 0;
> +	uint8_t checksum = 0;
> +
> +	/* Skip below init if critical region version != v2 */
> +	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
> +		return 0;
> +
> +	if (init_hdr_offset < 0) {
> +		dev_err(adev->dev, "Invalid init header offset\n");
> +		return -EINVAL;
> +	}
> +
> +	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
> +	if (!vram_size || vram_size == U32_MAX)
> +		return -EINVAL;
> +	vram_size <<= 20;
> +
> +	if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate for init_data_hdr */
> +	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
> +	if (!init_data_hdr)
> +		return -ENOMEM;
> +
> +	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
> +					sizeof(struct amd_sriov_msg_init_data_header), false);
> +
> +	if (strncmp(init_data_hdr->signature,
> +				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
> +				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
> +		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
> +			init_data_hdr->signature);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	checksum = amdgpu_virt_crit_region_calc_checksum(
> +			(uint8_t *)&init_data_hdr->initdata_offset,
> +			(uint8_t *)init_data_hdr +
> +			sizeof(struct amd_sriov_msg_init_data_header));
> +	if (checksum != init_data_hdr->checksum) {
> +		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
> +				checksum, init_data_hdr->checksum);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Initialize critical region offsets */
> +	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
> +		init_data_hdr->ip_discovery_offset;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
> +		init_data_hdr->vbios_img_offset;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
> +		init_data_hdr->ras_tele_info_offset;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
> +		init_data_hdr->dataexchange_offset;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
> +		init_data_hdr->bad_page_info_offset;
> +
> +	/* Initialize critical region sizes */
> +	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
> +		init_data_hdr->ip_discovery_size_in_kb;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
> +		init_data_hdr->vbios_img_size_in_kb;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
> +		init_data_hdr->ras_tele_info_size_in_kb;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
> +		init_data_hdr->dataexchange_size_in_kb;
> +	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
> +		init_data_hdr->bad_page_size_in_kb;
> +
> +	adev->virt.is_dynamic_crit_regn_enabled = true;
> +
> +out:
> +	kfree(init_data_hdr);
> +	init_data_hdr = NULL;
> +
> +	return r;
> +}
> +
>   void amdgpu_virt_init(struct amdgpu_device *adev)
>   {
>   	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 36247a160aa6..5c1dce9731e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -54,6 +54,10 @@
>   
>   #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>   
> +/* Signature used to validate the SR-IOV dynamic critical region init data header ("INDA") */
> +#define AMDGPU_SRIOV_CRIT_DATA_SIGNATURE "INDA"
> +#define AMDGPU_SRIOV_CRIT_DATA_SIG_LEN   4
> +
>   enum amdgpu_sriov_vf_mode {
>   	SRIOV_VF_MODE_BARE_METAL = 0,
>   	SRIOV_VF_MODE_ONE_VF,
> @@ -296,6 +300,9 @@ struct amdgpu_virt {
>   
>   	/* dynamic(v2) critical regions */
>   	struct amdgpu_virt_region init_data_header;
> +	struct amdgpu_virt_region crit_regn;
> +	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	bool is_dynamic_crit_regn_enabled;
>   
>   	/* vf2pf message */
>   	struct delayed_work vf2pf_work;
> @@ -432,6 +439,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
>   void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>   void amdgpu_virt_init(struct amdgpu_device *adev);
>   
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +
>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>   void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index b53caab5b706..d15c256f9abd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
>   	GPU_CRIT_REGION_V2 = 2,
>   };
>   
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
> +	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +	AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +	char     signature[4];  /* "INDA"  */
> +	uint32_t version;
> +	uint32_t checksum;
> +	uint32_t initdata_offset; /* 0 */
> +	uint32_t initdata_size_in_kb; /* 5MB */
> +	uint32_t valid_tables;

Missed this earlier. Is this a mask of table_ids that are valid? Not 
seeing it used before assigning the offsets.

Thanks,
Lijo

> +	uint32_t vbios_img_offset;
> +	uint32_t vbios_img_size_in_kb;
> +	uint32_t dataexchange_offset;
> +	uint32_t dataexchange_size_in_kb;
> +	uint32_t ras_tele_info_offset;
> +	uint32_t ras_tele_info_size_in_kb;
> +	uint32_t ip_discovery_offset;
> +	uint32_t ip_discovery_size_in_kb;
> +	uint32_t bad_page_info_offset;
> +	uint32_t bad_page_size_in_kb;
> +	uint32_t reserved[8];
> +};
> +
>   /*
>    * PF2VF history log:
>    * v1 defined in amdgim

