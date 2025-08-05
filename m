Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F2DC87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 14:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699E510E385;
	Tue,  5 Aug 2025 14:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FHKicPN0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C4710E385
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 14:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0jM1rH4Jf7SMZ2B2+u5AN0u4YScikRyT2xbnhzbFYk3VBdxqaKf1S4NJkuUWf4t1hh56UxTQwQIHsaQkdFO+VxCjkpHU7ZQc8x1/p9/1yB2t/68tykX+S+uQAxD4KSZ9aEESQgHL1jM0Mg5wMgsSqL/N8bLn6INvZEN8pRXklyWL2Wpr0xIyiQJeylRZePC2JOeESCx1A4ouHzxyhcVzULQLQZYpBbb+3x5P1PiKjFDwSDjUIDtvYpjwckZnOeyXULLc4u6ciiKjxq+LnKzOWevtAGx/ZBn+j8YQt4rPWn2zpC4I+/Qf3VDvkysEmNX2AA0VBzD2rSKOasHIEfFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJuZuhLzzkmwi1O/2DCATW1WxQPrtqh9XqL+/QpYFlw=;
 b=B+I735MTCIMxv+rgTTFaVk/Wqo1FsZgbVVNq958MZ3vG/FPnxmm4lI++Yn5+DL4LD8WRF9eCn0dWbjjvRT+R9ER3nRMh+ATq+XBSN6HOaTmBkPsLma9RT3bYjAM2W47EBP5ia3FFPkXRfF1aNlbMhraNkYcefx+b9Fum1Qm2Ty9C2ZmwPdCxu80aLlgfFWjajNBb+3+Bs7EqMDEMJyRjlWnGrdnRr5jGbxIr0anccBJirNIL84HSc63dSj2M5gCh4B6JgNhEXg0GZWCOyG6X9E3eVdU9H1FSHZNXUfmH7XiKzTwL+Skaq485Li1ODba/8jFSe0h+HD9q8D2rxrFYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJuZuhLzzkmwi1O/2DCATW1WxQPrtqh9XqL+/QpYFlw=;
 b=FHKicPN0dW83hLgrfg1Euxxzs7uLhR8fodYCLH5y/Rww1B1t3xuZT77iL+0knRrwjnZvKQJZf6ExdEtiyhpgVYi6T3mCv5lwBdrt6clL+s3kPawzd01HPYUVTqIOj3RTs7IcbQFE5OJJGSXliyQhbl4zNfUQ3T0f23vJik8nRWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 14:31:38 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 14:31:38 +0000
Message-ID: <38878190-c6e1-4bef-81c8-b58834e2c30a@amd.com>
Date: Tue, 5 Aug 2025 20:01:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Increase cache interval time
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250805142834.668322-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250805142834.668322-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::12) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa839a2-abf8-496c-8f7c-08ddd42cc978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkswVENjZTFTVTRUV0FiNm1RRXVXanU3TVlhTHJ4QXE1R1NxNnozaVgzNEdu?=
 =?utf-8?B?dzFPQnJoL0ZmUHhEcVU0M2hvU08wTGR4bjRTRlowbE9uYk1Id2wrWjNsY3E3?=
 =?utf-8?B?ZmlpaXkxQ0YrYmRIbURXRXUzdEttT0FTb0J1T05hK3NCSDBVQXN3MmJqQ2hz?=
 =?utf-8?B?TjVGeHpiNEorT1oyb2NHa0I2eUtHa1dtcExDWEhNZm9hZHh2WHMrTnRGT0NQ?=
 =?utf-8?B?UjR4ZWlGNzNhbGx2eUcxSnlUYnVYUlZXb0ZWVTllRXdpMGs2U2lUYitlQkh6?=
 =?utf-8?B?V2FnV0VyY2RVc3RENWhKSC9TVlRpWkJ0MXAzWHlDMGxmT2pQaWIxU2x4MmFV?=
 =?utf-8?B?NlV0QlhKVjFpRXJzL1p6TzZvVFlOVUk2dzErTXIzY3pxYkNVQkFIeWUvdkdr?=
 =?utf-8?B?d2lXNkUyRWhVL0hiYVBTRTc5dUhjWExES3NwTEFqajlpNlh0Yy9YbzByUWVE?=
 =?utf-8?B?TFlLVHB6eUVWTXlMYTB3QlVLQmpyUHQ0M1JDemNUMW5Md0FHbTZWbkV5eEdQ?=
 =?utf-8?B?T01MbmxMazU3Rjd0UmpXOFRhNlFjWHJCbC8zLzQyTWdsV3YrTS9iY2RUVjlv?=
 =?utf-8?B?QjZ0ZjRuOTFJTHAvc1h2VG9mZUdGN0xWTDN0eEhnOWwrRUpwVmFITnVRTlls?=
 =?utf-8?B?MVRBb0Z4TlkzRW1RbmlBWkhrWTA4eFMvc3FLQkVua25lc3k1Wit0eFp2UXE5?=
 =?utf-8?B?SUVobkZqVmdBTHArd1AyRzl5bUEzV0hVekN1UjJjRmZhUTlhWVZ6c0Jlbm94?=
 =?utf-8?B?ajZoV1NPZXNYd1B3QlhUN3dnbkw5UXE2eGVCMjc4OTR0RjZmWnZBZm1acVZo?=
 =?utf-8?B?WFdtZ3pzbS84UnArUFBzT0dIYVg1U3JRZmtJZHFGTjROSGY1WmladG1HWmlo?=
 =?utf-8?B?NXZzQjBHQXNnOHVtbFZMRU9vL3NzVTdTSW1SU1BjbTlTTCtlVFdJNHJmRS9B?=
 =?utf-8?B?Q1F6NHRYNHdqZzcxYjAyMjZrTFJISnpKUTd5TVBsRzdIZXlIckhYRGx2V0F2?=
 =?utf-8?B?ZVlTeWlGOTFvdU5vRTV4ampSZHVtQmZCdmFycmh3ZTYwSVliQ0dCSHFseHh0?=
 =?utf-8?B?by9DUDZESWtRaWJGZWkzNmlsczhBbDFPOTZHdGh4TnR3ci83OHNvMWpubkdy?=
 =?utf-8?B?WWdNVmRHenpPNTMxRVhONFpOQk1vRDZsVlJ6YjJXaHhsNWxtOXE5RnZPVEtO?=
 =?utf-8?B?ZFVVM2V2bjdtcXdudmp0OHdSQ2lITC9PZGsvVjlwelpRM0lONVl3aCtpczcw?=
 =?utf-8?B?ckdoVnlNd3E2TytOWTIycDlzak83cVlqb0dyeWtuSkNOczJiWm16aEtXcUky?=
 =?utf-8?B?SW1FeStaejhjdHN0UG54clhueWF2T0ttRjZDNXc2Vm1VazdYMDVNbzlkcTg5?=
 =?utf-8?B?TFpVVGJMeEFTWUtZNkZYNWhJMUdCeW8wcjR0N2k3OEJtaXl6cUNuTXBJN1Qr?=
 =?utf-8?B?Zk1ab2Z2UWIzYlQrT3o2WndqVThHZmsrbjFmNHZZSU5yWklDMlA0bDFtcWdw?=
 =?utf-8?B?Y0hxN1UwU2NhbDlmK3EreVVWaDYyRzVDTHIzdHQyaXI1QkdXWG4za0VGL3dD?=
 =?utf-8?B?Y2ZlWDV0SnZ5YXhOSW1FSjhMd1M2UWlEbTdPU2Z5YnJQSnlLY3dnc0ZSbFN4?=
 =?utf-8?B?aVFxVGxENTZta2VEWk50ZER6TDArVkRHTE4rVjltZERLYUp6aG9FckNmYUp0?=
 =?utf-8?B?WnQ5cVpUazFQMHhab3JXMXN5MUZtSnB0eitENm5wdlgxSExYY29jL1JIVlNC?=
 =?utf-8?B?aXdaTHEwZDNkMFRnNkpKaGxKeTlDUVprdDY3eDk4TDBBVWJTbHRBWURIQXhx?=
 =?utf-8?B?dEt4TFlnYnZVMzVrUkR3SDJ6Z0hVMDBUSjZBSDBISkxXYzc3NHYzWHl6ek1Y?=
 =?utf-8?B?ZUJhYUR0RVBNaHhMQUx1cnJEMnR0VHQ1aytQR2xVa05iWU1YcmN4TGtzVkts?=
 =?utf-8?Q?Ygz5FZDf+aI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1MxbDNVaVozWTFiUWRKZHhpY2d4OTNDOUdrWkpqOHFDM1JEOEFRRjd5SkJG?=
 =?utf-8?B?UDgwRXM5NnF1d09aR3I4TzROSytvYjBZWUxObzl1STl6SlpwS1pZQ3hPMzQ5?=
 =?utf-8?B?OVFCZTIxS3dwdURRRktOdkk0ZzBUcUg2UC9hck92SlJFL1lhMFQySzlsUms3?=
 =?utf-8?B?aERCK1ZmbE8yQWJHSFBNVlhJVXh3Y3FqNVBqNFNsMFNwYnVNeEJmT2I0STVR?=
 =?utf-8?B?QXE4VE4yK3Mza3NOektYcFpCam9sSEtGVlk4M2ZBaHFpUHhlYk52M1NNNEpD?=
 =?utf-8?B?NWw2UWU2MVliM2RTZ3JCYkZPWk1RV0N6UGdBUklXWTdKeGFKUUwwd1hWMjVr?=
 =?utf-8?B?dGpBK3ErQzFSd3dhK2JRL0VZUVk5SVd3NEdlTDlQSVZFVXFYK1B4L2s5VkM3?=
 =?utf-8?B?K1p4SDRjWTBCcHZibGs5VS9od09TYmVLeWpscXQxeUhLRkJVZHFleXdYTVpl?=
 =?utf-8?B?UldhdGtrMzAyUng0ZnREbzd5YU1PWWhRMndZV0dIcDBKNDlpUDdEZEZTUVY5?=
 =?utf-8?B?QVhTcUcxTnJZRXNBbjZVZ3RJdnRsa1g4VjBSa2o1anZwUGJmYTBkTWtaTjFq?=
 =?utf-8?B?ekc3Q1hvdkR0TnZVN21rNjY2M3hic0ZCemo2cnZxQ3VRNXN0YVJTMEVNWnc1?=
 =?utf-8?B?MDF5YUxTUzN2VE9BdkF1TzF2dTRiYjg3L0VmVnlRaUdZa0NCZ3JsMHYrc0kw?=
 =?utf-8?B?ZXJGUmdxZVB4OWRNYWtReE9pT0N2MHNpWUVaczkvbHRsK0dudk96bVZ5aTNO?=
 =?utf-8?B?T01KVDA2emUyVWxxazdVbTRPa2EvUVU3cG1VeXMwelhKcFFKb0lGcHdVNFov?=
 =?utf-8?B?Slk4NkdZbW5HOWFZNDQ5dWRVT2VPcWd0aTNlejlxRDk5T1Zld0RHSGVWRXJP?=
 =?utf-8?B?QVc3aGZoaTNxcXZDcjE2b0xjd3ZoQW9DRzAvbWZ2VzBMRlkvOUdVVjA2ZHoy?=
 =?utf-8?B?UHlISEZ0V1ZnSk5IZXBUMGhtbW54N2w4Z0MrZ0Q0QktRMnN5WFE0enJyTXlE?=
 =?utf-8?B?OFNIcTZoQzJyd2RLeis5QnJvOWJmL0pwNVU2RXNsYlk4WmtFNldmMHhuYi8v?=
 =?utf-8?B?MWJZUjFadkdHN1Z4bEVUSW9KOU5zTEptL1BFYU5oQnIrM2d1aC9vVEdXM2xY?=
 =?utf-8?B?S24rWk00OTVqVHBGR1RaYzlZdFB4RkFBcHhnTU1iL0c5c3Nwb1c0UVU3Y2Nq?=
 =?utf-8?B?akNVVFBMQnNSbk81RWtSRU96OE0xQmRPSTlrREJOTHExbmMrcWhFRjZ3d2tT?=
 =?utf-8?B?cEY4TStwb1dvZ3hWNUl6R2R5SHlxcjRINWhwaXpybjNLcmlIMG5lT25vVStY?=
 =?utf-8?B?SGUyYmNaVzdsbDhYbmZXR2RCYU1qdjg3NnFuZjJ2R3FsSnNqVHhKU2NRSDc5?=
 =?utf-8?B?c1BsbDJvcitwaVVvOEN3YXJNM3BTdjk4YU5HWE1lRGFFRTBlOG1nMFNHUFB6?=
 =?utf-8?B?VDA4U0U2Q1NCamVxZjNVZGRucWZMVlZOYktZUWduY2ROZTJKZ1RzR2N1aEts?=
 =?utf-8?B?Q2NxeThQdkFNT3Y5YytzTFRzZjhieHJhaVAyelpZRnBEZDBWUDdvdkcvc2Uy?=
 =?utf-8?B?a1piUGF1NkNJcE10WmYvTEIrS3NCaUp2L2EvQW1vOU5DZTA0bmZzSWxUeW1H?=
 =?utf-8?B?TE9DRG9nSVBEdXo5Z2EvNklpVWVldW16REVucGQyRmx5VHRGTGkyN3l2TjJj?=
 =?utf-8?B?cU5OSDNwSHo1dHhGSHdzeVFvazRlZ29KWXJmcHJ5Mnl5OHBtUDFuY1kxOHRI?=
 =?utf-8?B?dEpBeXpLN3JRdXV0b1BOOWJ4MFFQZU1DbE03ZjdaR1NVUThPVkRPaHBkZ0to?=
 =?utf-8?B?cXQ3bzZOT2VpTGl0N1BpMkRkMktYQWpxei9FazlOd0g0UllGNjZjR0p5RFpB?=
 =?utf-8?B?R216VmRsZTROZmVzOUlsTC9DQkZIRmxpcWoyWGVxZ003bWlkYzBsUkE4Tk42?=
 =?utf-8?B?OU9RQjlxY000ZnVJUU9wN1I5Y1AwRGxoV1k3R3RxcXZZYklOQ0dRdzVMT0w2?=
 =?utf-8?B?TXgzSXFmTkt5Zms1aU90VVllck5DUzNEY3UrbHo1S2JOZjJvc2xjNWJCbDBB?=
 =?utf-8?B?eWNmMmRrNGI0WGZ1NWdYdDBuMGhMQmZwck8zenVkQ0xRZ1MveHFRR2hMcnpL?=
 =?utf-8?Q?jSY8IEmm2+cPiC++VRkBpWcQ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa839a2-abf8-496c-8f7c-08ddd42cc978
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:31:38.3400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJi9ljKHz3uljmBbTPk4pQA3U+FsbvzzGYzoK5QL4zHg1s2ppUoNeZeL2c+OSdmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
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



On 8/5/2025 7:58 PM, Asad Kamal wrote:
> Increase cache interval time to 50 ms while fetching system
> metrics table for smu_v13_0_12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

You may add additional info in commit description like this data is
expected to be polled less frequently.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index fca50f6a8ef6..2ee61c7e8bc8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -372,7 +372,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *
>  	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
>  	    time_after(jiffies,
>  		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
> -		       msecs_to_jiffies(1))) {
> +		       msecs_to_jiffies(50))) {
>  		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
>  		if (ret) {
>  			dev_info(smu->adev->dev,

