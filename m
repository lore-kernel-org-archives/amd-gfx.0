Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55694CFC272
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF57310E2B1;
	Tue, 15 Oct 2024 07:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhjBJo5u";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285E510E2B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcsGs42p8PbDlUzGmsNoc+4PWeBDE/ivLozSgzLrXxH3ThvegQn1Voa+XLKyuscmy5la97n0ITlHkE+yzJ+ySlQcI6QRL422XgqarQ+k1Srm50s++UNluEkhLd/nkN9sI/e/d9GBNX/YX5l4VrdQh0Xpb39NFhNR+5gvivqJvkF5qAZSVLlQ/W2itw3pb4iLefprX75T6/oCClak90L+qnt6WI+8lK2aztmc/ESTqQRW7Zswofh75+YZfZdSFlpCLVUz+C5yenIkuEFZIw6EVHqwqQGgrtLnPvcrdJrNHKVPzFCPpBvzoAzdbhDgc7uFVGS+BrHyvoFkESBwY9seNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyjaxHBkYqYQ3iNtmYg6Lp3MXnf8jCh/0RCmlguA03o=;
 b=HJ5LLMVw/kgbrl+81NJBZ/YYN13+w2CRnQ9DJ0niQ7PmCq51xKX2KQVBYfMygHNk+RUuwMp9HWybgg5LcdidV67jFYHH/+UE2Hlq4chmGdgickoEHOPCGOVEh/KrPLrXiJWo7NmWCF1vLLrn0slv8QNRJlKGz7zsMgujOihHZk+eUzZgsNJGNiMHQF+M0EmjokQ18eU/KHrm6vPZyd68tkngME7kMM43vgpSORntLyWbdGlxsK5RMDVTfn7GJFX162avI+TbFhefG7TPhY+IOgHFpFC4sAHNTb9pvIeuY3jvn8zh+REUA3ykLDBjDG53dBMle8ibM3tO4yfokCNITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyjaxHBkYqYQ3iNtmYg6Lp3MXnf8jCh/0RCmlguA03o=;
 b=KhjBJo5utmE/i+DDDxHCBeIiizgDOseu4uu4ejEdLCYTt4maReeeHkuQnitzTB0mdInza1RVDnlwoJ7QI5PXYvh8HIrGLwIgws37Hi3n7p7vsAUA7JcMWSr7cORAdcmFIHlJT7u8raOFrmX+J/YuHA5/zFIfYbiNcojUy0I9brg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 07:26:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 07:26:38 +0000
Message-ID: <731b81ab-1a44-48d8-a325-80d4c9ad0b30@amd.com>
Date: Tue, 15 Oct 2024 12:56:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
 callback for sdma4.4.2
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241009072249.546857-1-jiadong.zhu@amd.com>
 <20241009072249.546857-3-jiadong.zhu@amd.com>
 <754c08a4-6e0f-4633-aff0-572175108d5a@amd.com>
 <DS7PR12MB633353B24969C14D287197ABF47F2@DS7PR12MB6333.namprd12.prod.outlook.com>
 <BL1PR12MB5144EF78FC6C55A508FABC6CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5144EF78FC6C55A508FABC6CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0059.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f3::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: da807caf-e813-4785-eba2-08dceceab510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFdLQVROTCs3QjJPM1FCZTFVN3FCOGxQY3hFWlFTdy9wUEkzN3NHNkNqWHFG?=
 =?utf-8?B?QkRSS2R0dk5EbGMrTGNDdExtR2hkY2g5MEJiOW1RcXBSUHVXbG1OanlmbEM1?=
 =?utf-8?B?ZmlMOXc3UFFjdnEvalZET29yaFFTZ3NPNDhNVDBBS1NjNWlTZnExN1Q1dmR0?=
 =?utf-8?B?VEJKQ0lmMys4c0hCSmtOZkFLUTRrVjlXK2dwVjgrTlRXSS9qWlZiempqSXBV?=
 =?utf-8?B?OFlkWUhlVUx1SUM5bGpCRUMvdTFnWnozWjEvalFVSjFuWmUzNDg2dnR5R09y?=
 =?utf-8?B?OXQ3MUVRajh0N0NSTlQ0UGNuWTkxR1Z3OGRqb1Vqd0JWamxsT3JjUm9GOGNq?=
 =?utf-8?B?KyttRXphWXBnaTRhdThSNlJZWHN1aDJEZWptQXM4UnZiSWl4Mk5DaE95d2FH?=
 =?utf-8?B?MUZZM1J3eWdMUFUrTGFXdEQ2OHQrc01rM2luYi9uN1dwc0RaVWlEY0x0OUFu?=
 =?utf-8?B?b2tDSXNwaHlvdVhYZW9mOHpPSDZwRWRrREdNSld2QjBoV0FSeFBPUDlsYXFl?=
 =?utf-8?B?bitMbW16SDJpYmlGdFhvRWFyaE1sTVlQRjVzOEp4Y1hXU0tFNjkzbldGbk1i?=
 =?utf-8?B?Y3BFdXBmUWk3end4QjRKVlZ6U3pibm0wUkY4UXFtKzBnY3NManJBNnpxekts?=
 =?utf-8?B?Vlp3MEJSTW85Slpnemsza0NSS2E4OTlWd1AwRmxISWdkV3UxUU8wZWVEbWdQ?=
 =?utf-8?B?KzlJS1V0TGZmdDdvYm1IcnRpVTgvOC9nOU9jKzk4RTJuYmlpRGpSWWdLV09R?=
 =?utf-8?B?ZFA0REFIemVxQzFjYU03WmFtOUswU3NZTDJZTm9ZQ1F4b3UwTXN0b0krcFMr?=
 =?utf-8?B?Y0x2aG5uN3g5T1R0dUpkb1NWT3RaRTVMS2RDNHl2Vm9zSjc2bGlONy9XVmor?=
 =?utf-8?B?ZkQ2dDZKYzh4TzJDRXlzNGxJMVYrUnlUOHU5VWN0QVozSWxHT01sTXZVaENx?=
 =?utf-8?B?YkZuaFAzQ2ZKVTZNdERNWFJ3MDZjME42ZU05M2Rpb0lLUTJxaWh3aWZXdnhQ?=
 =?utf-8?B?TVlvUWxqYlk0SHJsUVVuN2p2elBZUXl5TFZKQkh4MHZWbndyOGRDYXpFaW4z?=
 =?utf-8?B?UlBueXg4bGlvUkhQRzRvb1lnRUhRMTZKMVNBUWVJM0F5SEJ2cEk0R1FkSVB0?=
 =?utf-8?B?ZGpEQWVxMEl5WVJ2cUpFNUp5QVRlQmM3RnhoVWxzU3diNXRtUHh1NWlRang5?=
 =?utf-8?B?TUJwdlU0aEQ0MUlUeW13bU5Fbzhkb1Qvc3R5WjZxTXJYT0RhUlR6SlhIS0hh?=
 =?utf-8?B?TjQ3WFFpM2lGQ29PS2lqUitGbUJNS0tWamNZeDh3dEtmQmFnbzVOazk5dVJU?=
 =?utf-8?B?OWVMbFpPMDZYeWNHVWlPazNDMDJFekh0RFNVbWhjdHpackk3UEQ1Rys5WGlh?=
 =?utf-8?B?bWtLTStrY0hVS2hhZ2RuS0NyL0NjV0R0bUJheUk5SG1DQWFmdDBEQ1B6NVpk?=
 =?utf-8?B?R0JnY0p1S3lwYnZIZGlJNG1EalBRL1dHT1MycURpcU8wbE81UUlMQWtvMjNn?=
 =?utf-8?B?Y1YrUGhpWTRGQjgrb0lHaDk5YW5XUHJQQ1VIcVU5NHFzU2VFQUh0Y0c5eG0y?=
 =?utf-8?B?QTB5akdWck15Y2IvRCtxQmRUcFZKYW15RE9Tdmh6YVNHcGtKaks1TDc1RStU?=
 =?utf-8?B?eVhGZkRWVGszNVg1aUdDWGRGN000dkJNVkpRUXZWbWFPa2ZSTm1aS1RuYzlN?=
 =?utf-8?B?QVgyeGdXVGs2cjkxdWlIb1NwT1VhUXRnMGtMc0FPTDBLMUlKdGJCeGtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJFZ1R0UDFJQkprcmVDN3FvNmJibDQ1TkpGU3dMSllVa3Ruckg4Y054ak5o?=
 =?utf-8?B?dFhKS0Z2RnhFRjZkZ2s5THJNRFN0NnR0SEhFMG5kM3lWdHBpbDlnQk0xQmtx?=
 =?utf-8?B?SGFZaVRLMmM5NEZsUG5TNmUwNTh5OU5ldjN4L080bUc1WS9nNTFrR0orMU1a?=
 =?utf-8?B?Nmp1Q2FCeTREeG9mUzkxeGtqZjgxQUYzUlZuUTlHSUNMb2h5K0pMSFBMa1Bo?=
 =?utf-8?B?NzNGZlQybzRKS2o5VExzSUdhblFpY1J1L1A4VVNOU2Z1UDlJNXNUTFQrUlpE?=
 =?utf-8?B?SG5MbnNKRHpXQ2hwSFVFT0poOE1EMEVteVVSVE12N2ZqRnB5Nm5xYmRSUGVP?=
 =?utf-8?B?bzlkTTV6SGRiNE55ZlhSK3p2Zm1PWVR1OFBibDBkVUhwSmk0OXEwcGkvYVoy?=
 =?utf-8?B?QUZrU3VQRkhYWHZ5QTdRdDJaZW1zN0w3QUJqV2FmWFpXdGFhZzk0eFM3MnRj?=
 =?utf-8?B?aDF3UVFLRGRHZVJWRmo2bFlRam11VkNHbkIwSXBZU0VqZGNmVkxqTUF2NGln?=
 =?utf-8?B?K2RsL2M3T2d2T0cwS3o4dUdGV0xRa2RJa0xvRUpqbGpGczdkd3pyUElxQzdG?=
 =?utf-8?B?V0xEY1FsOGpvVEFXRmxvYU9yT0hCeFBMTndtMUxzYXB2akZIN3VSaUNxd1hK?=
 =?utf-8?B?WWd2dGJBd1g3OUx3YTBoYkw3WEtFQURKVVMycmhZb0p2bytpbEJuUDlhZnkr?=
 =?utf-8?B?Z1h0WDhvSnZiY3JHZURTYTVXNHpTdHFReEpkOGlLOUh1aHUwVmZ5M1VMdk0z?=
 =?utf-8?B?Nmx5SEJPaVQ3VEtVa1BoRkszN0hZNytXYzJKM285QllHNlpabDJJYzBWTVpV?=
 =?utf-8?B?blRMVGpwbkdNWTNYbXZweXVvRGpxV3dZdnoyN09CSnJHbnE4WkJPNUtlZ1FI?=
 =?utf-8?B?SUpwaHp3cytsWENyZTdFdzVaejBIWmFCakhMU2NZSmkyQjlKYTh2cHczemJ4?=
 =?utf-8?B?bTB4dmhxYlNFejZKNjNGekJ2b2pqTlRkdnlxNjNBNnB0SjhOdkttbzRQZ0Uv?=
 =?utf-8?B?QXVhNjNIandoRXNwcVF6NGt0cnBWcGlnRmlSV2M4MmIxbHhXY1J3QnQzUXNm?=
 =?utf-8?B?L0RQV0JhWHFvcSsxdllQSUxjYXNTTEtjY1JvTytISk9HUmswZFFrdENOR0Y1?=
 =?utf-8?B?SWJFU3NZekw5azB5bDY0ZGc2VGNEMDBRajNUMzNRNmhGbnFPSTRvajBnZEpn?=
 =?utf-8?B?TWJUZ1BkUjM0bmxQNUtlVEJwN0laY0tEY0kzQkdTYUgvV0k5TjYwSXlOSFls?=
 =?utf-8?B?WFcrdWdGeGk4ZnhvMTczYWRNcisxV3B0eTh5NmxsVUd0Yk96bER2ZmZKQU9i?=
 =?utf-8?B?ZEZMQmJpMkJQYWpsY1h4Sk13bUlFNUdROENBSEN1T1BoRCtleVhxbWEwTE9v?=
 =?utf-8?B?VUh2Y0JEL2VhUGwwSXFaenBjTHd2amIyT0JDSVBjUVBrWmZRZ1hkaTRWUklL?=
 =?utf-8?B?My9oTlVoZkpMNE1tQklURVpvckVhczRDZlN6Wkh4eS9WMDYwNUM2UWNnWE1p?=
 =?utf-8?B?UXZlcC8zc2FxRW9peVRRcWh2L3pzaUY2dkdnK3F2aEJONCtkRnY2SllqcEk0?=
 =?utf-8?B?Wkl6SC80d2RnczdCN3Jwa2kwYzQxVk9hYzE5UGtJNjhSbThISFV1TW0wNDll?=
 =?utf-8?B?b0k3MGprR05XSHY1YU9SV0tNcDVPdk0rVnVqQTBIMWI4d0UxM2JJaU9DUVRQ?=
 =?utf-8?B?M0wvSUJjVVpHaWdlWlNrdi9rUEY0ZlI3S3ZCb0srQWF1c0dTZytXcTZ5Ry95?=
 =?utf-8?B?VDgzUWd5YS93aHA2TnVrNEJneDZzUDRzby9ocjM0a1lJSFNuemo3clkyMXVy?=
 =?utf-8?B?THQ5RllDRFBZT041MDFxRVBvNkVvTUlqTG95enIzbW5VZmtMNDd3RHluQlN2?=
 =?utf-8?B?YzRmaEI4dDlpcDF1cjJ2YW9jem01Z1c0b1lLWm9DclBlZWFSQ0xPZVJ2OGhs?=
 =?utf-8?B?d1I1K0UyY3A3TVhieEZKN2RCc2IxakFpdGJHNTlXSTRqZy9YU2pLdzBBSVNX?=
 =?utf-8?B?L0JUQ0xuSDVLL1dRNjRRYUhqbDNnb3NrRXFyWEZUUm1UR0JZSEtWaXVoU092?=
 =?utf-8?B?REloNjVLTEJZTlZTWXNJUmVFcUdFNHh1SHA1KzNQUGFTSzB5K1ZzNkdwUElo?=
 =?utf-8?Q?/10oRMdxoZql2Sgeotfn4WNyb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da807caf-e813-4785-eba2-08dceceab510
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:26:38.5412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqJJ28nsHXMXE+yRrMOCW1eK1rboj3D9DFVGj2xZHw/SDQ1DAZVouBY16damFzWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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



On 10/15/2024 1:08 AM, Deucher, Alexander wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
>> Sent: Wednesday, October 9, 2024 5:23 AM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: RE: [PATCH v3 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback
>> for sdma4.4.2
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Wednesday, October 9, 2024 5:13 PM
>>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH v3 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
>>> callback for sdma4.4.2
>>>
>>>
>>>
>>> On 10/9/2024 12:52 PM, jiadong.zhu@amd.com wrote:
>>>> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>
>>>> Implement sdma queue reset callback via SMU interface.
>>>>
>>>> v2: Leverage inst_stop/start functions in reset sequence.
>>>>     Use GET_INST for physical SDMA instance.
>>>>     Disable apu for sdma reset.
>>>> v3: Rephrase error prints.
>>>>
>>>> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 97
>>>> +++++++++++++++++++-----
>>>>  1 file changed, 79 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> index c77889040760..9a970a3cb908 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> @@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct
>>> amdgpu_ring *ring, uint32_t rb_cntl)
>>>>   *
>>>>   * @adev: amdgpu_device pointer
>>>>   * @i: instance to resume
>>>> + * @restore: used to restore wptr when restart
>>>>   *
>>>>   * Set up the gfx DMA ring buffers and enable them.
>>>>   * Returns 0 for success, error for failure.
>>>>   */
>>>> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev,
>>>> unsigned int i)
>>>> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev,
>>>> +unsigned int i, bool restore)
>>>>  {
>>>>     struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
>>>>     u32 rb_cntl, ib_cntl, wptr_poll_cntl; @@ -698,16 +699,24 @@
>>>> static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned
>> int i)
>>>>     WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
>>>>     WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
>>>>
>>>> -   ring->wptr = 0;
>>>> +   if (!restore)
>>>> +           ring->wptr = 0;
>>>>
>>>>     /* before programing wptr to a less value, need set minor_ptr_update first */
>>>>     WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>>>>
>>>>     /* Initialize the ring buffer's read and write pointers */
>>>> -   WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
>>>> -   WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
>>>> -   WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
>>>> -   WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
>>>> +   if (restore) {
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring-
>>>> wptr << 2));
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI,
>>> upper_32_bits(ring->wptr << 2));
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring-
>>>> wptr << 2));
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI,
>>> upper_32_bits(ring->wptr << 2));
>>>> +   } else {
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
>>>> +   }
>>>>
>>>>     doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>>>>     doorbell_offset = RREG32_SDMA(i,
>>> regSDMA_GFX_DOORBELL_OFFSET); @@
>>>> -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct
>>>> amdgpu_device
>>> *adev, unsigned int i)
>>>>   * Set up the page DMA ring buffers and enable them.
>>>>   * Returns 0 for success, error for failure.
>>>>   */
>>>> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev,
>>>> unsigned int i)
>>>> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev,
>>>> +unsigned int i, bool restore)
>>>>  {
>>>>     struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
>>>>     u32 rb_cntl, ib_cntl, wptr_poll_cntl; @@ -775,10 +784,17 @@
>>>> static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned
>> int i)
>>>>     WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>>>>
>>>>     /* Initialize the ring buffer's read and write pointers */
>>>> -   WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
>>>> -   WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
>>>> -   WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
>>>> -   WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
>>>> +   if (restore) {
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring-
>>>> wptr << 2));
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI,
>>> upper_32_bits(ring->wptr << 2));
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring-
>>>> wptr << 2));
>>>> +           WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI,
>>> upper_32_bits(ring->wptr << 2));
>>>> +   } else {
>>>> +           WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
>>>> +           WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
>>>> +           WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
>>>> +           WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
>>>> +   }
>>>>
>>>>     /* set the wb address whether it's enabled or not */
>>>>     WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI, @@ -792,7
>>> +808,8 @@
>>>> static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev,
>>>> unsigned
>>> int i)
>>>>     WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
>>>>     WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >>
>>> 40);
>>>>
>>>> -   ring->wptr = 0;
>>>> +   if (!restore)
>>>> +           ring->wptr = 0;
>>>>
>>>>     /* before programing wptr to a less value, need set minor_ptr_update first */
>>>>     WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1); @@ -
>>> 916,7 +933,7
>>>> @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
>>>>   * Returns 0 for success, error for failure.
>>>>   */
>>>>  static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>>>> -                             uint32_t inst_mask)
>>>> +                             uint32_t inst_mask, bool restore)
>>>>  {
>>>>     struct amdgpu_ring *ring;
>>>>     uint32_t tmp_mask;
>>>> @@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct
>>>> amdgpu_device
>>> *adev,
>>>>             sdma_v4_4_2_inst_enable(adev, false, inst_mask);
>>>>     } else {
>>>>             /* bypass sdma microcode loading on Gopher */
>>>> -           if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
>>>> +           if (!restore && adev->firmware.load_type !=
>>> AMDGPU_FW_LOAD_PSP &&
>>>>                 adev->sdma.instance[0].fw) {
>>>>                     r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
>>>>                     if (r)
>>>> @@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct
>>>> amdgpu_device
>>> *adev,
>>>>             uint32_t temp;
>>>>
>>>>             WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
>>>> -           sdma_v4_4_2_gfx_resume(adev, i);
>>>> +           sdma_v4_4_2_gfx_resume(adev, i, restore);
>>>>             if (adev->sdma.has_page_queue)
>>>> -                   sdma_v4_4_2_page_resume(adev, i);
>>>> +                   sdma_v4_4_2_page_resume(adev, i, restore);
>>>>
>>>>             /* set utc l1 enable flag always to 1 */
>>>>             temp = RREG32_SDMA(i, regSDMA_CNTL); @@ -1477,7 +1494,7
>>> @@ static
>>>> int sdma_v4_4_2_hw_init(void *handle)
>>>>     if (!amdgpu_sriov_vf(adev))
>>>>             sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>>>>
>>>> -   r = sdma_v4_4_2_inst_start(adev, inst_mask);
>>>> +   r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
>>>>
>>>>     return r;
>>>>  }
>>>> @@ -1566,6 +1583,49 @@ static int sdma_v4_4_2_soft_reset(void *handle)
>>>>     return 0;
>>>>  }
>>>>
>>>> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>>>> +unsigned int vmid) {
>>>> +   struct amdgpu_device *adev = ring->adev;
>>>> +   int i, r;
>>>> +   u32 preempt, inst_mask;
>>>> +
>>>> +   if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
>>>> +           return -EINVAL;
>>>> +
>>>> +   /* stop queue */
>>>> +   inst_mask = 1 << ring->me;
>>>> +   sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
>>>> +   if (adev->sdma.has_page_queue)
>>>> +           sdma_v4_4_2_inst_page_stop(adev, inst_mask);
>>>> +
>>>> +   /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
>>>> +   preempt = RREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT);
>>>> +   preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT,
>>> IB_PREEMPT, 0);
>>>> +   WREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT, preempt);
>>>
>>> Confirming - should this be RB_PREEMPT?
>>>> +
>>>> +   r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
>>>> +   if (r) {
>>>> +           dev_err(adev->dev, "SDMA%d reset failed\n", ring->me);
>>>
>>> My earlier comment was if smu_v13_0_6_reset_sdma() fails, that will
>>> result in this print in addition to the error log in
>>> smu_v13_0_6_reset_sdma(). You may drop one of them.
>>
>> Sure.
>>
>> Thanks,
>> Jiadong
>>
>>>
>>> Apart from that missed to ask one basic question - this looks more
>>> like an SDMA engine reset rather than a SDMA queue reset (ex: only
>>> reset one of the SDMA RLC queues). Is this intended as a queue reset?
>>>
>>> Thanks,
>>> Lijo
>>
>> Yes, OSS4.X does not support to reset a queue for sdma, thus we implement it by
>> per engine reset.
> 
> SDMA is single threaded so it is effectively a queue reset even if the entire instance is reset since there will only be one job active on the instance at a given time.
> 

Even if timesliced, I guess queue reset purpose is not to affect
processes using other queues. I was thinking it is done through some
sort of forced preempt ("should this be RB_PREEMPT"). Jiandong clarified
offline that it's not using that type of mechanism. Since the instance
is getting reset in this method, that means other queues are also not
usable during that time.

Thanks,
Lijo

> Alex
> 
> 
>>
>> Thanks,
>> Jiadong
>>
>>>> +           return r;
>>>> +   }
>>>> +
>>>> +   udelay(50);
>>>> +
>>>> +   for (i = 0; i < adev->usec_timeout; i++) {
>>>> +           if (!REG_GET_FIELD(RREG32_SDMA(ring->me,
>>> regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
>>>> +                   break;
>>>> +           udelay(1);
>>>> +   }
>>>> +
>>>> +   if (i == adev->usec_timeout) {
>>>> +           dev_err(adev->dev, "timed out waiting for SDMA%d unhalt
>>>> + after
>>> reset\n",
>>>> +                   ring->me);
>>>> +           return -ETIMEDOUT;
>>>> +   }
>>>> +
>>>> +   return sdma_v4_4_2_inst_start(adev, inst_mask, true); }
>>>> +
>>>>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>>>>                                     struct amdgpu_irq_src *source,
>>>>                                     unsigned type, @@ -1948,6
>>>> +2008,7 @@ static const struct amdgpu_ring_funcs
>>> sdma_v4_4_2_ring_funcs = {
>>>>     .emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>>>>     .emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>>>>     .emit_reg_write_reg_wait =
>>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>> +   .reset = sdma_v4_4_2_reset_queue,
>>>>  };
>>>>
>>>>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =
>>>> { @@ -2160,7 +2221,7 @@ static int sdma_v4_4_2_xcp_resume(void
>>>> *handle,
>>> uint32_t inst_mask)
>>>>     if (!amdgpu_sriov_vf(adev))
>>>>             sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>>>>
>>>> -   r = sdma_v4_4_2_inst_start(adev, inst_mask);
>>>> +   r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
>>>>
>>>>     return r;
>>>>  }
> 
