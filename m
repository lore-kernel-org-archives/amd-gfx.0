Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A97FC2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 11:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2BA10E0EB;
	Wed,  3 Jul 2024 11:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFk23q4z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9AEC10E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 11:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz2aZVeOqfpYKJnfaXfx3DQlZFohnBX3582Lp9AlSTK7xfIg17K8TY1a66PxWnl4qN0vYLy07RbkdN8+7Saz+ehRPXLkE83f/W59IItOAQFrcjPYdbni1y8gXE8SD0rR/Ot4vaLoIi8rNqr6jDH4luhNpu/BaJJl0Brg91x/rx+BpG1raByrRICut89vwBgImdgWfHK2YXuG5exfUhVlxNzDwOIhvM0gZxFcFpGT7IpHx2zA8ScXnY5sEHKpXGOyMhQVYW03QXdct/dhH56t4CBlRFcwQdjLRT+dclR/O3Sq4IBI2ABndLnVo6b3GcAsXrMJd5mw91bn1Ra7IDw1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11dOAIRp6LCkonz8wzX4wyQrZFTcFEiqLMqeKOEN0dE=;
 b=G9enbejzxjEmx9YpWrhLjvrUSZ0KS5Y1Y4qY1zrVp1L1v4EYXpWvsaHon7YSnylxBkGv+6B8jKaaNZX5InW1CZVNasaqwiLOJkaZvW+bPnFKECU1+3Tl6wOy8mAn+kxQZAH0bVp6tULcluMiXDSZkhWpQa0tIZtQwL86O+8QfWJtpkE7YoUioTb497ToyoLUwVr0EM/sjpIr608j/ZkDONvG6vSvlyZtqDCm28/iAZSUs4wBYRDNgymRd1MAsN2vs+MmVXfUqMobBwINXijHVdDKru/58gkNBGtcni3BsPPViQmB/7uCs2NJif4qImOr7f/E/SQg+RCL4n/ntjwiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11dOAIRp6LCkonz8wzX4wyQrZFTcFEiqLMqeKOEN0dE=;
 b=HFk23q4zBwR0EBN17Lu2HwMOfBiZLjhqI81bvjafwrDfJ1SA+Zpev2l6aCzw7UidEP6TTw+ddsD82oGZxrit0TzfNOXlIOwAG1euGJYZVqXrg33nEc4whEb40fI24Vhr2B/RdsXiEaRRd5vZBLRpHgFHwbybTiql6JEBAcbgei8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 11:17:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 11:17:32 +0000
Message-ID: <a2bafcfb-047c-4dec-a011-5964d3d8e0eb@amd.com>
Date: Wed, 3 Jul 2024 13:17:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: : Fix the null pointer dereference for
 amdgpu_device_switch_gang
To: "Zhou, Bob" <Bob.Zhou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Huang, Tim" <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240703090144.11241-1-bob.zhou@amd.com>
 <918275d8-788a-421e-b791-3d9537dbcead@amd.com>
 <CO6PR12MB53947BEC03CA815372F6E37994DD2@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CO6PR12MB53947BEC03CA815372F6E37994DD2@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: fa06d18e-633b-4016-5799-08dc9b51bb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG1WTE5wUFgwZGc5aEdkZHRaeUU4ZVdpNGFiQ09KN1E3ejRkUDk1bmt6eTdE?=
 =?utf-8?B?anFHMjU3MEY0YWpSVnpwVE5YbzNqWlMvM2hjRHEzaExyYWl0MTA0d0R0Zm1O?=
 =?utf-8?B?RkI1UDhxNitOR0VpZ3hVM2Z0WGxqWmwvVUVJS3RXUXhXcTFCY09tQkJoekx5?=
 =?utf-8?B?dWE4ZUdOSE5LZ0FXaExaMm42WWZTS0w0NWxOVUNwSHFGQXN4bmZTRHgrNnZO?=
 =?utf-8?B?MzJNWjVTSWE3LytwaG9hUVA4ekRLanhkOUNzaWx6Qk5yVjNkbU90VXRUZ2xo?=
 =?utf-8?B?L1ppSDZuV01SMDFCTW85WTVrMW9KUzl2MmRNaVVSS1dnS2MwSFlhU2Y5eXEy?=
 =?utf-8?B?WWd0bUFDSDRJNkg0dENsWSs2TnJQZkN1SkFFZFhMNGVXNlEwMlpXU0NreXZr?=
 =?utf-8?B?NE5MOGgzN0Yya3kvWUhzSHFTb3RwVGxZTEY2b1dmTlBRd2plUkt3ODRwdTZs?=
 =?utf-8?B?RUtNKzFjN1JpMTd5RVhDSHhjVWN3MlFLMHlFRG1ULzRWQnlLSlhWaEhJVXZY?=
 =?utf-8?B?ejVGQ2h6QjNsMXdxZlYyWEM0YkxCQ3poaGZUdUM5TzhCY083NEk5VVlkL0FG?=
 =?utf-8?B?bmVBVUdnL2taa2xsNGh5dEZXM1M2eGlsNkNVdldMbUsrbHFWQlA5Y1c3UHdo?=
 =?utf-8?B?SXc2Z3Z1SUpHeGRPZy93M0RWQWJBZ29Ra3BSNGhYaVlWN0tZVkVoalY3Y0VB?=
 =?utf-8?B?VUlDS0JOMG9MRW1NbkNLZm93ZVJtZEJNdnd0MUZ2ME1MTWNTTW1ZcVlYeEZU?=
 =?utf-8?B?ancxcklFcmtJTXlOVHQybHBMMjh6RlFqMWhheXF1NEJrMDRBNXJET2NTTXdr?=
 =?utf-8?B?Um5xalBSSHFBN3VtVTlGdmJ0TXBBeU82Q3ppSlBnLzlPS2QySnFvbnUvSEY2?=
 =?utf-8?B?TU9jUWZPOFh0R3RxWVN0MWVsOVd3Qi94SHFNaFlEc09hUE1iTlRiWkhpOXFC?=
 =?utf-8?B?dlEya29iUDQwbmFzYmkzaXZTM1JOY3NGSngrRHRpNTRKbHdDRUtndzJ5RGFk?=
 =?utf-8?B?V21Yb2dDVXd2YWZKN3JJSFdTbjNLcnQzTDIxODUycm8rNFlJQmN5WXI4YVV2?=
 =?utf-8?B?N256bmNJUkthNHN4bDh3dEREQlpuTUFGZ2p4QUJaVUl2WmNpTHR3R2h5Z3Az?=
 =?utf-8?B?bVR0QVYyOEdUQ0RjTFVpZ0RZOVZuRUIwdzdDbzFVZXM5WXUrRllsSTQ3SXlW?=
 =?utf-8?B?UW9zU2c0RjlqZytST0NmWkhudmtkNWZ5eDdlSUJSK0kyMXJTYmFVNjRDSm1S?=
 =?utf-8?B?QlpEaGl4Q00yYmxSZDVIZmRyUm1PNE5FV2c1c2lYK0V2VVZyTzl2SE9vNXYw?=
 =?utf-8?B?dnJydUhrNnE1SE1EWDdnRzJmZG1FcVZUNVd3b2xUL1lWVGVIYkJLbzE0Z1BG?=
 =?utf-8?B?cVFmWHZiS0szemc4d3ZiZWgrV2dQWko5eElnWW5uemFKQnFuWGt6ajU3dktu?=
 =?utf-8?B?bnQyK2ExQUd1VEhycmJYV2MwUEZkc3d4NlhKK2lrUWk0MG1xN2xiTWRCQ0FG?=
 =?utf-8?B?dHVnUTRXVjBNQXhhK2ppOVcyTnhxZkZLTE8yek5CMlNpcVBVTWtWV3p5QWNU?=
 =?utf-8?B?cDVNcVZrWkpjZjN0VU1kRlA2dGIwdWtyOHVqbmUrT3hPUUFGNjJTdDlSMlJv?=
 =?utf-8?B?VXhpeFZIeWZid0lHUWZFd09KSk04Y0plK3hwWk1kMFV6eVpuaURJNGhOVDJJ?=
 =?utf-8?B?bGhvdU1wRGtuZElZSjRneDEvT2Y3OEtNSkgzcWRpZG1NWVQ5VFk2VTYvVXNB?=
 =?utf-8?B?SUpMTDlCbzBMYTQwR1hmVFY4eGlyTytFeExFRWdUb3B0d09IL2N5R2lObnkw?=
 =?utf-8?B?UlI3V0tpZUU2WjhhdmhMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FrWCtOOVNnTHUzUlJET2gvWCtGcnN4c3F0UFFwNGsvU05ScWxVVUhPa0JJ?=
 =?utf-8?B?cE5ISVRqbG8yTU9HZ1UxbENDTVViTFY1SWZJTXZCK2c1VzZPWTg4d3M2Y0RO?=
 =?utf-8?B?WWRRWEExN2MyZ3NLKzlqbGZFdlJhZ3FDWFFKRUgrNS9Dc3NwbklZZjY3NTVU?=
 =?utf-8?B?OHF3cWI2aUJiYVlKb2szWERTckZaVCtBMmlFR1lPSFd3ZGRGTCtwVkU4SHM4?=
 =?utf-8?B?elBPL0NvcldURytxOElmaDVDZWpNUlIxcHRJbkVQV3VPcUg3STl5ZVFZQjRr?=
 =?utf-8?B?ZkxEZjF6NnZndW16RzQ5RkJvc3NydjU3VStrTnZuOE9RbXFBcXM5WEp5QmJJ?=
 =?utf-8?B?R1lGN2VrUDJScnd2T1U4VW5QTE16MEZkRDlTdzl1NFA5MEY2YktQTi9zSzcr?=
 =?utf-8?B?MytpZWxFUHVYQUY0ckgzMkJVd1QxSUZjMDRNTE1BUWhnd1RFQnVtNWp5WllH?=
 =?utf-8?B?NDVVK01CM29GbE1FNzBWOTZJRzAvV1pVUGlSZm5iQTZhRFJBdnlDYmpvcFh1?=
 =?utf-8?B?TUhsclRJRmNtMjhSZmNkWmtJbGxhckJzeEd0MC9EVEpRQ0JwZDBXbkZJQ3V6?=
 =?utf-8?B?Mm4vU09xTzI0NXArMENNaXlPT002c0VhT1E2NU0wM1VFOTNjajg1TE5YWEpq?=
 =?utf-8?B?VHdteTR3NUlEWVFNcFJVMG13bkJxSFBYaStFcC9rSjRyM0d0citucm1xSk1U?=
 =?utf-8?B?TlJlMGZsQW15RG5yZDNWTjFTcFJZeTRNcjc0ZmxjcDlQb0xsOGVEamwxakNZ?=
 =?utf-8?B?Y1hOUHh1RjdnaVNrcWJjS2NhZk5aNFMyNWhxNGFWdDJqalMxMXl1QVRmK2Ny?=
 =?utf-8?B?eHRLcUxDbWtMT2dNWGQ2cVdqZFdzdU8wQUg2bmVYS2dhajVscEw5K2FHTUwz?=
 =?utf-8?B?a2FTV2hiakdFNm9xZ0lualhvWGlPRzF4Y2VORWhzQjBZTC9BbWZTRlFMdmM4?=
 =?utf-8?B?ZlpnaXhnS0JiL1RLRVJtU01YbEgrSlJIRUhvN0c4OGlIKzBDOWwxNFRnSXY2?=
 =?utf-8?B?SzZ1NTF6ZEpKZ1BPNkc4WUJLdFMzTTRMK2ljM1Nud1JGdis0a0RQUkZQRXo4?=
 =?utf-8?B?bktVLzg5QlFDbExJYUVpUkFlVFVtS212RXdkVGJYWFNxMk9iQ0JLVHUzUE8r?=
 =?utf-8?B?N3FKQndOeG1VVkJVelcxNWtxaVkvUCttK3NGUnFpL0Zvb0R4NWtDUDFNWlBs?=
 =?utf-8?B?L2R1UUFiREUyUUw4dlM3c2tvbndjN3gwc0x1NnlYaUp3QlJjazU3b3BmVWZx?=
 =?utf-8?B?Ykp2Ri9QclZGcmVMdHFpbTF0c3JlaEdYSWs4d0ljUkV4MlpMaVlHR25wbHN5?=
 =?utf-8?B?Z3NadmZPQ244UmpjTTFQaXF0cnhhZmx6cklEL29JSDUxRUUxb3pScWdPa3JH?=
 =?utf-8?B?c1ZFaThHcEwyNTZNZzI2MVR0R1h3c0FscTlTMG5lRGlyWlV2OGJKOEtFbHo5?=
 =?utf-8?B?YjhZN3NBZjlzZDVScDN1TVZydkE3bmY5cjF5UlVFcGRQQ2NSMjlLMmVHcFVj?=
 =?utf-8?B?ZWY1aGVnMmxCakhEb1JRTzBscVV3UjMvWTR2OU5MMzJ5bHpCUHAwWWxiNWdN?=
 =?utf-8?B?UUUwMklPbjliV2ZXRXpITngyUytMSzBRc2d4MTFwellZL25KeWxJMDQ2MlRL?=
 =?utf-8?B?RjJMdFNvNnIreW9NdWc4cFBWOXhPTGlYSXpnek00WXV1NnhBakRocjFHLzdX?=
 =?utf-8?B?R1IveTBLeHVKWGlwbmFSeUZobmVuNnFoL0RYL2xDenpTQzZXSElNbUdlT1E1?=
 =?utf-8?B?dWw3QzlYbFhkU3Ava3FBREVOZ0lXSC85ZUhzeEEzeFkwU0xGRjZzVjRrVldh?=
 =?utf-8?B?TFpmMzdDakVKZGl4bFkrRjBzYXUva0dyWCtlRENlaVovS2MrSGxJeXJGencx?=
 =?utf-8?B?MjN3ZHNQek1ZUm1QdVNHZW5BMkdnMlRSS25ZY1YzUXNJa0ptSEJtU1RqNis5?=
 =?utf-8?B?NmFORkpCQ3N1cUVKWS9HNWtrODREREpmWUN0MFppcFNKZnoxQlJVZWFPcnRm?=
 =?utf-8?B?Vm00aVlhRTA3bFFiQmpVcTRJRms4K3lUZ2xteElYL2pOR3M4Q1p4WlhwdVFr?=
 =?utf-8?B?K2pkSjNFdG4xOFF5amd0L0hybUhYR2FEemh4bkgrWGVta3JKVjFFdkFlOGZP?=
 =?utf-8?Q?MgxkAS5C9MFJlj/Pl6Hh2mIe9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa06d18e-633b-4016-5799-08dc9b51bb5c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:17:32.0860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkkDnCyodYLDFolxRUgn+yQHlQXb2R9UWUf92+nVvCeGpRApaDwoF+8pGrf/BrQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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

Well Coverity probably can't know that and will keep complaining.

Maybe we can add some extra code to point out that old can never be NULL 
here?

Regards,
Christian.

Am 03.07.24 um 13:06 schrieb Zhou, Bob:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian
>
> Thanks for your comments.
> I miss the before logic has limited the generated pointer.
>
> Regards,
> Bob
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2024年7月3日 17:26
> To: Zhou, Bob <Bob.Zhou@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: : Fix the null pointer dereference for amdgpu_device_switch_gang
>
> Am 03.07.24 um 11:01 schrieb Bob Zhou:
>> To avoid null pointer dereference reported by Coverity, so add null
>> pointer check for the return of amdgpu_device_get_gang().
> NAK, that's complete nonsense in the first place.
>
> The pointer is guaranteed to be never NULL or otherwise the logic would have crashed long before.
>
> Regards,
> Christian.
>
>> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bcacf2e35eba..c1d82c346daa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6569,7 +6569,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>>                if (old == gang)
>>                        break;
>>
>> -             if (!dma_fence_is_signaled(old))
>> +             if (!old || !dma_fence_is_signaled(old))
>>                        return old;
>>
>>        } while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,

