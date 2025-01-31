Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0158C0218D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 10:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8057910E0F0;
	Fri, 31 Jan 2025 10:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTRpdY6B";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E81910E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 10:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUYbBlxmxN9mlZyx9kj1XrDXnF7rqM/G+Ef6blsNU0HB20+iW32XxDSzG2Fsms+oDsdwY3LhhkNmTbTtv+O7OEqUtMiyLi7ZP9sHSwi8pBF7mudYuWJP00aLk68PVXiotlw8tyUpedwbnK+E5a9N2FFo8uGnHx9u6BCqPgglCLgfJlv//3RnZteBDO+AYMFrfsDAb+almjAtgfPum78Leao5y47t50tjD1NfViH+xxeIL1jFRWhAgpf2j4BB/M1Xd9nV1eTvzoqMLEFevL9+Lpv41/3Cet3R+zFuDQ9k2UGafxxskY+TPM+ucAsm8ONd50yjcr736MSyCNzTVsPRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwIBTxFZ7kJm29bd1HVegA+DjpUgEj3V/AxFAyYQDNk=;
 b=ULMIXMCa0cwDjXTrbY7LiAlA9T4M/U4tEdUtVmoJ68DLiHA0QgHR6dGwFF2iw5JSjK30OcrVi7N3bnMwIXNDPkMaAx7aRKBfebh91XhVvA/YwxTy/aGfadNIqzjpDBSiVUY7N7h7dYyUjKwDWZHKsnW+FpnmAejkpOCUV+/B4VHXBcCYDqFnWgKQu9aT0u3stHHVoIExFusXsRQntgRt82+cqwkch5qnzGLK+d1X6cH09AZu8ttBzQMaYtjVokSoIpNwZMV9KupfmSZixpHcOTgkylx7HiIQNm1r9pf+mQ0tz2oIGYygfWZj0AU938ksNFTvARHuZZ02UlBFcU7Xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwIBTxFZ7kJm29bd1HVegA+DjpUgEj3V/AxFAyYQDNk=;
 b=JTRpdY6BWEnStWUCKPNgC9RwjNNCqKUVqdXYgXrwsT5ge8axtNd/VtjcIcVx3o4k/+DzDz3Q7tHUadRUNOL1eaSylsx4nCCu2a4LcJ9hY+BipZH7YCK/4idcu5ZStoyl99MQSLOO1XDt4gl8qtwmdRowONUAo5Aj3PLZG9dXrFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Fri, 31 Jan 2025 10:38:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 10:38:02 +0000
Message-ID: <0e20ae91-f39a-4757-aaea-cd388aabe905@amd.com>
Date: Fri, 31 Jan 2025 16:07:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
 <20250130095113.534630-3-sathishkumar.sundararaju@amd.com>
 <1fa96910-b574-478b-a895-072f4302fd00@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1fa96910-b574-478b-a895-072f4302fd00@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 84293486-e165-4801-c511-08dd41e35629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGZPS2o1REtnVU1MMFV4T2w1UG53YVAvVm5pd3drUFhuY3VEZm05Sm40c0Mv?=
 =?utf-8?B?cWEyOEgvU1JodTFOalpxdFBDMXhwWEZJN2xyUGRjRklzTzZuVW56QlZXaDJD?=
 =?utf-8?B?NDFhK29rSzVrRkVsNElwMEhDdllGVmlPd01IbWR0T0QydFk4OHgxMUZhWENu?=
 =?utf-8?B?YUMycjl4Z0JtcFVrbmhwVHcxU0lsalNvY2tERk41NkIwdFNxa2FNVFBqbkhS?=
 =?utf-8?B?aDRNOG12SGdmS01idDVNVlgwalhtN0EwVnNhUmNBTGZMTldVa2F3Q1FYNW02?=
 =?utf-8?B?VHY1eGFSUG91azdMWnZaVmdaVHNvODl0ZGl0UmlDU2ZKclVhZWJ2dU1CTU1E?=
 =?utf-8?B?Qm5uRW9mbUVNTXN6c3VDOHBVdk5IMklDSnV2dUVqM1FuVFVCY2FmVDVxSjgz?=
 =?utf-8?B?UCtyaWJnbmdRNTR2SDdpTEljZnZTMTFhT3FKUHJwZFRqSUJiSlhUYXN5WjBv?=
 =?utf-8?B?cDYybVJaNWg5cktOanZ0YzNubTZPL1RySHpsQVlLL28rbDdxYmMxdEtPSVN2?=
 =?utf-8?B?VGRyTG00K1dVRWdMSEVzdzJsbW1aSmxCWG9PMnpRVXlkd3QxZGRnWEtCRmdR?=
 =?utf-8?B?RmpTYlh5cTJLNEs0eTMzVlZ2TGVCbGZrL2lMNnpUMXNYY05pY1JXejBRNDV3?=
 =?utf-8?B?TlYzZGVmdWU3Z21NSUVNTHJ4OTlRTldVVUFOMXUycmFaQktrNmRkMWdqVEJB?=
 =?utf-8?B?Y1R1MnlEUndwMGF2MEd1UWxFZTBMNkYvQ2ZXTUoxaytCSEREb2c3QkNXSUJT?=
 =?utf-8?B?RUZLVUpOMzhnOTBRK3UyQ3ZYZ3pjSXNCVTJROGtyeTVHTXhPUXpMUVFua3p2?=
 =?utf-8?B?RlErRTVLZ01RVkJxWXZ1L1lqUzNYb3dXVVhhWjlNRHc1ZjZHc2d3dkFhVDRt?=
 =?utf-8?B?ZURJL2NvdUVSVG0zRmlaZzJpN2JpL0NUeEx5eUNueGo5bFN4T3AyZVhiQzVQ?=
 =?utf-8?B?ajF3SnZDKzNOTkdFTkJjZ3IrMVhTaWlFc1o0WmdzVFJvckF4NXgzYVMybktS?=
 =?utf-8?B?Mm9IWlcwcFZJT1pOUGwzajBYaEFZUVM2aExVVC9GRjgyQW02dFdBcTZWMDJt?=
 =?utf-8?B?YmxvNER4cTEvVGYzUlRoaEF5TjdjUXIrT3piQW9OTGwzc0pSamlObkxOWUpv?=
 =?utf-8?B?bDI3MFQybExmdGdjaWJNcy9aRzVrRGYvWnhYa2RiaHYwRXQvczIvOXIwMEZr?=
 =?utf-8?B?MU5ubkYzUGNPWXF5TFlQWWJueGlUekpFRTJqS2VHbkVmZVlvaXFLeEJhaFpG?=
 =?utf-8?B?UVk0bW4wUmtSNjAyRjVhQTd2T2FpVXV3YkRVR3AraDVhcENmL1l2K3FLc0M2?=
 =?utf-8?B?ZGFVYTR4RkJzQ2VISGorV20rRVc4MUJMd0IwVkxWWTdRUjNUOG9pRXd4UGdv?=
 =?utf-8?B?N09NaUNocTVCbGhGZnhzSkI2VHFBeGxmZHBBa2dsY3BJWGk3RGNycHkweWhn?=
 =?utf-8?B?TytkSjk3cTFXaG81eThCZTQzQ3RqM2RZZys4S081V2RuUGx0RFN5STI4NHdY?=
 =?utf-8?B?aTlqSkU0YUhiczJveW5veXhOc2QxcE85MlhrbVp1b0d2OWRCZmZVeVZ5UTBs?=
 =?utf-8?B?eGRXamgwWERiSEhzMHFSSVFGUTg3UTdrL1B1NUJVS1hNYkx4WUZVbWFmRk1n?=
 =?utf-8?B?VUhDeDFYZWxiMWc5Q0ZMcnBkRXhMMHlWNWpBQXk0dzJmNjdKMTBFNTZxcUl0?=
 =?utf-8?B?QmJkMEZWM2ZBUDFhdDB3SnRRd3pNRVlaWWtpSnBNOU16T1g1R0grVTlwTVlB?=
 =?utf-8?B?WEE0ZUM2elE3WHd0NTZ0bUN3SE45TUFqYWpwU0J1WUxlZ0swZER3SEhRUzR4?=
 =?utf-8?B?U0kzMHBJRmdTZnladlF2Nzl3c2VUVnpONXhmeDhtYVd4NlpqUElXaHBJWUpr?=
 =?utf-8?Q?7ssX4Zw86DNuR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhzMWZ3blA4eGxCNFJZeXhzbStvbXp3aTl0SFhQZUltaEMwTm9tVno5b3Fq?=
 =?utf-8?B?Nk02S1hFSC9JQ3haM2Z2VWFXeUNuWU1BRzNPOGcyZXF5YzhUWG50blF6TFN3?=
 =?utf-8?B?MDZJYktUcms1ekx5cC9PRlhpQStQMlkyL1B4VDVRU0I0ZVFIWWpmNDRkZEQw?=
 =?utf-8?B?Y2RCaksvTWhpZEc5QjRlOVRTSGhsejlOd051Qk81SGIrRHVoWE9yZFhOeU9K?=
 =?utf-8?B?RnczRm1HSEhkL2N4WkwyT0hXRGJBZ2ZVM2hxVWk0QXVCUXlUeCs4KzNBckE2?=
 =?utf-8?B?N0RQUHA5T2lIeU93SS8wWElMc2ExM0M0VEcrY0h6Sy9YdVJvZ1lSM1UwN01E?=
 =?utf-8?B?b0EwTWdaVm5iMHdmdXJpUEViMXMrdk80UkY4WnB6RnBmaEZGdTd2SGdoWS9j?=
 =?utf-8?B?eW55RmpTMFZ3dThvVzBYRGFRZnJ0QWxlaGpGZnhubGRBRDA3ZVpNMjJoS0FC?=
 =?utf-8?B?Rk4ra1k1c1hFdnV3Q0JpM3k1SWlTTjBiZjlJSlVrM0JXdEVQSEtZcGdaNmdT?=
 =?utf-8?B?Z3RDS2lWNDBBR285TURobTltNFV0ODQyMkxJOTFzZUQ0ZGQ2QjhZQ1RBaWZT?=
 =?utf-8?B?LzhQRVp2YU84R2pLdDlrN3kvdDIrOGxOZnpuMExQaUcwMjZ5WXdOYlNGQTIw?=
 =?utf-8?B?ald6QkpqcEx0M2dZZC9FSzJwQWt2VnIvQWxWSjhUeUNTNjlyOUpFR3EvUkRP?=
 =?utf-8?B?djc0bmhiQnFiWG8rRXNVRlRXdFF5VkhYU3J1QjMzSEYrM2FjTm16cGVFY09G?=
 =?utf-8?B?cHJFYkpkamtOTjlLV2pFYjZhaHlDTUhJOWs1cVh2Sk1rdGZzR053aWdDazBi?=
 =?utf-8?B?Z1d4NnMyN2ZNZTJXaUE0d1hNTlkwdVZ1a2xRMnQ2OWovQURlZWlKRTBxa3l5?=
 =?utf-8?B?dlJtVm5FZWhXRm16SndVNUhkV2M5MnZyci9pcmxjWStnOGphaUhNakJzM3RQ?=
 =?utf-8?B?UjJHaEZoa2VtVFZNdmI2SFNxSnpBM3QwUnRKT3VtQmJYYTNyMTkzVTlmejVp?=
 =?utf-8?B?aTl2dVN4ZGhOL09EZEM4ZWNXaTkyWXArR0hIWnJveW4yQUJ4aVdTQlgyR3Iw?=
 =?utf-8?B?VDlYcGxNK0hqQmI2T0E5eXZhWjVOdndOZDg3bTdjUDJrSmYvRWwvTTJZU3I2?=
 =?utf-8?B?OG95SmEyNDF2ejA2aUlUYWxkQnkwSTVBSnRWVytWM1RST2pZVVlPTm9Hb2lF?=
 =?utf-8?B?dVMyUXBHSGpOeEZNODlGU0s5YUNLVkhxNnMyNkcvbUhVeFMwRzJXTVozVnZI?=
 =?utf-8?B?bEZMRUNMRUF1NFR4MU00MmNqbmhQSEJtWW01SitmSGg1Nll4MGhTWWFDdDcr?=
 =?utf-8?B?MkFjNTNYMlVzejZRczNadUtWc04vcXVJSW5nZkFmay9PSERRdGkvb3p5SFJy?=
 =?utf-8?B?ZFZJQkltemxrakVFbHpGb3ZBV2ZmTkFSelB6bUF2cXdxOE8yanZiMExPbFJv?=
 =?utf-8?B?bm9mTU1jNUk4Q0xoa25vRFlmdHlQQURpM1Y0TEs3anp2N0pJelcwekZOZGl1?=
 =?utf-8?B?Q3FuUys5aHNhQ2VnamFZckVsbVJEWC9FNnBjK3JHcFFzdzVSSmJqdUdTaTJn?=
 =?utf-8?B?Zm56c2Y2OG53YVA0c1E5WUNjYVRZT2JnNkpldW0vemNaWHEyMTFPZ1RsUk9a?=
 =?utf-8?B?cW9zZGtUWmdOY2tTNks5cUlUeDRqYXJvcFRMN2lhZzBGZzlqSHVCK1FaWSt5?=
 =?utf-8?B?SEpUTTA5aDViQ0RNckwvTGgyZ2dXVGV5NCtpY0pnQkdZc08vOEZVV1pFcFcx?=
 =?utf-8?B?aHFVZkR2UnltQ3dUdkVYRmFvODhHd0xtcFFQWmVnZkhCMzROczY2ZXpQMEhJ?=
 =?utf-8?B?aDcxL2UydHF3Z1lxU0QwNENOY2Fvc2R5am1BS0JHMlZLL2xFYjFLRm1mdWFz?=
 =?utf-8?B?T2FBQldjSDNaTnZ2d1pmWHRLTDZkZlhzbTV3ZHpNQ1BOSmN1clJNU012Tk1a?=
 =?utf-8?B?Wkl4ZS82NXp1elFTazhhdmpldkkydXF4RGRtbW5VT3BRMVd5MFZGUFZiQXVF?=
 =?utf-8?B?dlVXK2NaSEFFaGRrWFAvUW1iUFdTY09vRjA4N1ZDbU5SSVBIN2VTZS93REJx?=
 =?utf-8?B?MnphNUc0ZmtHdjMzM0tvS2FDMkp3WlFQY2FVQWhIL2pxaU1iMFRQbVhZUEdh?=
 =?utf-8?Q?x21/Zo4PIujgcN0tjz3nKLOJ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84293486-e165-4801-c511-08dd41e35629
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 10:38:01.9537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVkItsfv8+ymALKzg1pcoVcmLsG/uxaho9qx/U+3kI+ECt9RMEShZ+6ca01XVONL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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



On 1/31/2025 1:22 PM, Sundararaju, Sathishkumar wrote:
> Hi Lijo,
> 
> Gentle ping, reg_dump_fini() is now moved to sw_fini() in this version
> as suggested.
> 

Ah, didn't know this was waiting on me. I was not particular about it,
thought Leo's R-B was good enough.

Series is -
	Acked-by:Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Regards,
> Sathish
> 
> 
> On 1/30/2025 3:21 PM, Sathishkumar S wrote:
>> Add devcoredump helper functions that can be reused for all jpeg
>> versions.
>>
>> V2: (Lijo)
>>   - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
>>   - use reg_list and reg_count from init() to dump and print registers
>>   - memory allocation and freeing is moved to the init() and fini()
>>
>> V3: (Lijo)
>>   - move amdgpu_jpeg_reg_dump_fini() to sw_fini()
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 84 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  9 +++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_jpeg.c
>> index b6d2eb049f54..dda29132dfb2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -33,6 +33,7 @@
>>   #define JPEG_IDLE_TIMEOUT    msecs_to_jiffies(1000)
>>     static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
>> +static void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
>>     int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
>>   {
>> @@ -85,6 +86,9 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>>               amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec[j]);
>>       }
>>   +    if (adev->jpeg.reg_list)
>> +        amdgpu_jpeg_reg_dump_fini(adev);
>> +
>>       mutex_destroy(&adev->jpeg.jpeg_pg_lock);
>>         return 0;
>> @@ -452,3 +456,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct
>> amdgpu_device *adev)
>>               device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>       }
>>   }
>> +
>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>> +                   const struct amdgpu_hwip_reg_entry *reg, u32 count)
>> +{
>> +    adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
>> +                     sizeof(uint32_t), GFP_KERNEL);
>> +    if (!adev->jpeg.ip_dump) {
>> +        DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
>> +        return -ENOMEM;
>> +    }
>> +    adev->jpeg.reg_list = reg;
>> +    adev->jpeg.reg_count = count;
>> +
>> +    return 0;
>> +}
>> +
>> +static void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
>> +{
>> +    kfree(adev->jpeg.ip_dump);
>> +    adev->jpeg.reg_list = NULL;
>> +    adev->jpeg.reg_count = 0;
>> +}
>> +
>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
>> +{
>> +    struct amdgpu_device *adev = ip_block->adev;
>> +    u32 inst_off, inst_id, is_powered;
>> +    int i, j;
>> +
>> +    if (!adev->jpeg.ip_dump)
>> +        return;
>> +
>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>> +        if (adev->jpeg.harvest_config & (1 << i))
>> +            continue;
>> +
>> +        inst_id = GET_INST(JPEG, i);
>> +        inst_off = i * adev->jpeg.reg_count;
>> +        /* check power status from UVD_JPEG_POWER_STATUS */
>> +        adev->jpeg.ip_dump[inst_off] =
>> +            RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
>> +                               inst_id));
>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>> +
>> +        if (is_powered)
>> +            for (j = 1; j < adev->jpeg.reg_count; j++)
>> +                adev->jpeg.ip_dump[inst_off + j] =
>> +                    RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev-
>> >jpeg.reg_list[j],
>> +                                       inst_id));
>> +    }
>> +}
>> +
>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>> struct drm_printer *p)
>> +{
>> +    struct amdgpu_device *adev = ip_block->adev;
>> +    u32 inst_off, is_powered;
>> +    int i, j;
>> +
>> +    if (!adev->jpeg.ip_dump)
>> +        return;
>> +
>> +    drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>> +        if (adev->jpeg.harvest_config & (1 << i)) {
>> +            drm_printf(p, "\nHarvested Instance:JPEG%d Skipping
>> dump\n", i);
>> +            continue;
>> +        }
>> +
>> +        inst_off = i * adev->jpeg.reg_count;
>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>> +
>> +        if (is_powered) {
>> +            drm_printf(p, "Active Instance:JPEG%d\n", i);
>> +            for (j = 0; j < adev->jpeg.reg_count; j++)
>> +                drm_printf(p, "%-50s \t 0x%08x\n", adev-
>> >jpeg.reg_list[j].reg_name,
>> +                       adev->jpeg.ip_dump[inst_off + j]);
>> +        } else
>> +            drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>> +    }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_jpeg.h
>> index eb2096dcf1a6..4f0775e39b54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> @@ -92,6 +92,8 @@
>>           *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;    \
>>       } while (0)
>>   +struct amdgpu_hwip_reg_entry;
>> +
>>   enum amdgpu_jpeg_caps {
>>       AMDGPU_JPEG_RRMT_ENABLED,
>>   };
>> @@ -137,6 +139,9 @@ struct amdgpu_jpeg {
>>       bool    indirect_sram;
>>       uint32_t supported_reset;
>>       uint32_t caps;
>> +    u32 *ip_dump;
>> +    u32 reg_count;
>> +    const struct amdgpu_hwip_reg_entry *reg_list;
>>   };
>>     int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>> @@ -161,5 +166,9 @@ int amdgpu_jpeg_psp_update_sram(struct
>> amdgpu_device *adev, int inst_idx,
>>   void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>   int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>> +                   const struct amdgpu_hwip_reg_entry *reg, u32 count);
>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>> struct drm_printer *p);
>>     #endif /*__AMDGPU_JPEG_H__*/
> 

