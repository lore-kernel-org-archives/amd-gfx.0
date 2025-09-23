Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A2CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 12:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F73410E60E;
	Tue, 23 Sep 2025 12:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YCZXWCYi";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990D710E011
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 12:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EASWTwYXN005d0Gg3FKxhaXQFX+rF6M/c6uborYl5cr/qOtrJLOloYG9fw/KbOlVOaqAK5fOAdDOUJTKjj0wlDWAKYsjBKTqqxr9ajh7rPpOEPf9RWLkhYPXvwvzf77Ur/wVe6eRy3E7IitSIyIKpHP8wZwANYiVkxqqg6mUcEFvEqCjC0UD+Y2eW75hp1EPcX/sw5yrsNXNvmSawnL8NIBuJ7z1U9BMYDHfBENAg9FPzSO47YCymjp7sJvltPMPkH60Lp3VjOoGLQx9vb6TLZyKZU10jCa4ARPYxnUr1qs/mvph63U76KBu7AV2xmS/ZoXD636BmcQ/5MGRLf9WYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjNgHLj7HiBiwwomFQvn9/2W2mZMQt7z/4r9W0j+Oak=;
 b=xTt2eJ0cu0aNktMyeW1DSMdHoLQ3045KVnUT28oziLgQZvVfIn1bLDLGJPr4djxwnBc9LdWeTQG6s/DNxsbzFobprwW8GpSycHthl8jR3d0NAfnghuQVm/w+kN5pCoH4Dx/ifo/3vWMZoBoOLR8CUR6fHUPsPTNRf6N8UCzZ5W7lbJ5uCUPluq8IA8xvVgHZEXdUAxJey4hf+HXCCEbp/OJJY/cWusnAyWpTFXOH2/M5D6I/HkiP7OgDgOYoTGp473FoiypGtTZbF0yQpKDmBrjzbfT1YzIX+uqiEHceDw09YjE9gusoNSvPVqayjZHdBnm0KctNuU6EGu3wQZhAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjNgHLj7HiBiwwomFQvn9/2W2mZMQt7z/4r9W0j+Oak=;
 b=YCZXWCYiyEJFnPpjg1NCsOyu9r1EnPj2naSd8EozaJtfsFlYyU3uk8sfGLSXFSBx6NCp6ip4cV4XHdSVlfADXkeoFpTf/n2ejjoYKT1toXJQNzpm5E/6TMKsSX/p6NjHWAYYCh5EKxjS2/WLRex1KWnOTU54VRDLYtmbc6cWLaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 12:40:19 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 12:40:19 +0000
Message-ID: <8850cd81-285e-4dbc-8de4-2895302bb4df@amd.com>
Date: Tue, 23 Sep 2025 14:40:15 +0200
User-Agent: Mozilla Thunderbird
From: David Rosca <david.rosca@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
 <c60ca7eb-ae30-4ed4-b167-9671ad6e445f@gmail.com>
Content-Language: en-US
In-Reply-To: <c60ca7eb-ae30-4ed4-b167-9671ad6e445f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::22) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e715b6-15ee-4431-3756-08ddfa9e5add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0Q2aGdSR2x6SnJwakZxaHMrNXZRQm91TGFTZG9FNUJGNzdmaXUzazNJVVhw?=
 =?utf-8?B?QjZjQytLd3ZESklOOVoySTQ4N0pabzZ3ckRDUzVpRzU2enNsUlo3em5YRWEz?=
 =?utf-8?B?T1cxYTdLRG94RnU3MjRvR2t6dFRuVkpGV28yV1hiNTNlRzVKVU5Tc0NqYysz?=
 =?utf-8?B?b0M2eXMyWDJtdEVvVlJWc3dhUG5aQ0xQOTBRck9Ud2xSYVlSNnk1VFFQaDla?=
 =?utf-8?B?RXlmaG8wdzdRVlIvbk1QVk1qM0FzTWxpSVVwSlFqeGZWUVJqc0ZkaHhacE9D?=
 =?utf-8?B?VFY0d2lFRDkvRFNiSWxMdE1TM3c1SlY1dnVpdW8rN3dub3U1Z2x6ZlBWQTFs?=
 =?utf-8?B?T0wwWEFNZnl1UTUySTUxL25RZnQycWsrU0t3VkdJVUJnU2FYSVJEY29EQnhF?=
 =?utf-8?B?dElyQXZDVDdFcjcwYk10RkpIVmMycE5lZU5FWU44OGtkNUlocTg0bHJ5ay9T?=
 =?utf-8?B?bXlDNlMxS3p3T2NOdlJnSFptbzNTNVpLRlBvV2RyNTZMLzBoZUJRdGxLU3N6?=
 =?utf-8?B?d2ZaelVUdE5ENHpkSHZsTGd2eHFBVjJnYi84RlpNMTAycmJDVytuMjR4NXlT?=
 =?utf-8?B?dExudFlmV2NKeVhLMGhsdmZkYUZNL3owSk9BajNtR1ZnVzhoa1lTSFdmN3VD?=
 =?utf-8?B?VEFjdWI1NG53TlUweVprTmF5VkJabTJxYTZIbHViWkVYN0lwTEdCT2dObHRl?=
 =?utf-8?B?ZW1Obm5jOEt2TWVGZ1BYL05nYVArRUxDU2NQb1RwaG9NdHFpbEQ5dkRNNTJ5?=
 =?utf-8?B?QmRNVkFacEovZXBWR3ZkN3ZEMGpLK0xwRERJWU8wNmJnTHFsa0E3c1VKaU1G?=
 =?utf-8?B?bys3c3dodk96K0psK00xaUkrNUE5dUJ0Rk0yUHVPV0NWcjMvYkF0VVV3OWtT?=
 =?utf-8?B?T2FnNnY3N2c4TDd5RTJzSHJDZ2R4QzhZV1B0eTBnL215NlJuSWxLUXBERWJs?=
 =?utf-8?B?eEgwWXdQWHdhRHJoSjhvRS9IYmxTNVYzbkRsa0VRUVVLVm9kV0swSmE0VFJq?=
 =?utf-8?B?TVd0aFVWVmRicy9KcHQ0WU9MeGVZWlZnRkZIVDFsWnJ4aTA4bWhtQjQyWEMv?=
 =?utf-8?B?ZTVHVHc0RWlFNTViRUl6TDhOeGk3dEhnOFUrTkZBejA2Nk1nSDNWRUxFUmhM?=
 =?utf-8?B?cmZzbDNsRXBGUVlmQW9ya2ZIY1VYSHB4L05ESXM3MEV3NjBGMFpGQU10bVJX?=
 =?utf-8?B?dUNhM3cvMVZmT080dkZHb1lReHc1Zk9IK010a2dZblgrdXhIQUZ2UjZTWUlW?=
 =?utf-8?B?L1FwNDJ4Ulp5cWFwTkMvM0M2OGJPWHg4RUFJTjhzdTh3UzAyaU40OUFFcUQw?=
 =?utf-8?B?aXJIUjk4c0tMcDJ2b2lhYWdFWGNoOG1yV01rT2ZvblB2QU5uWENqZ1F6aFVV?=
 =?utf-8?B?WUwxZGs4ci94SWsvK0ViMXplSVhlcXRYcFUwSFdNMTlUZ0FyUnUrb0xUT3pN?=
 =?utf-8?B?SCtRUVZmd1NCVlk4czNXYUlkMnVzTDZPdnNIZjE2aTFoYkovRzlSOCtNS1NF?=
 =?utf-8?B?cm11SUVzS05JVUlRTzNQRTFtYy83eVBqZzlkM3FUUWt0a3VrWUw5SVZFSjdG?=
 =?utf-8?B?R0l1TERCeE1jZTkwWkxuaDdqMlhpdDNKcnVaQ3FwSWpjcVQ3QXFGa1k4Mm9m?=
 =?utf-8?B?TUdZTDlSS2JzUXh4Ukw1VUlubzdUOE5qOHIyV3BIanNsWFpTUE5MdXZCUFRP?=
 =?utf-8?B?dEdoNzVPZXoxTXkxSklreUUrTGRHV1ZpL3Q4VElnVERGWndranlidlhmZ2V4?=
 =?utf-8?B?VWdqbWZ5elpyT0hSNnhYSGhvbjI2OHR5RkhxLyttQVZ3amx6NnltWUx5alEv?=
 =?utf-8?B?OFI2cG9IKzh4UGM2UDZoa0w2N2M4L1dvb2dNY2Uvc3JoOFJzVjhBZVBFWmJZ?=
 =?utf-8?B?Nkw4YS81T1dvNXp1Z2MzT2tkcDJhLzUrNjRFTGpFMmZ3TTJ0cCtFTWFIS2Rz?=
 =?utf-8?Q?Utj7bxBWqFg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdCeWsxRE9xdTFSZFBQSk9sQ3FJaXlURXBLTnRzdUpDcG9vdEhWczhSYXdr?=
 =?utf-8?B?ajNoN0liamc3NVU0dnh2TzNibzFydUV3Q3lpT3ZRY09jQzBvSGpNaWNIY1E5?=
 =?utf-8?B?T2xiaHZtWFV6d2tkQ2ZjNUhvOGZ6eHNvNnpXT1R1KzBvSGhRei9XNVpWZ0kx?=
 =?utf-8?B?LzJXdkNmZGZSbXlCRHczWG5tcXpaQVMvbkNrUFZlQWt2alYrd3NnNzBSNm9h?=
 =?utf-8?B?Ym5jWUk0bnByVS95bXV6QUhwVktCYVphRjBHSUVmaXVWTDI3djY5eXdJR3FW?=
 =?utf-8?B?bWhmYjQxTUtiVWwxb21SSGJSQ0hwT1FTdC9FWFQyYVVwNStuMVZURjk5TDN1?=
 =?utf-8?B?S2s2cXZvNXI4dmFmOTMySnplN1dYbGxyRVRlNU1jVURHbTJhaGZSWlJueCtZ?=
 =?utf-8?B?aWpqWlRhSTVyYjhDK2hXaUxsOWpYOHo0elVEelVxaVA3WDFXNEprNWsxRHJV?=
 =?utf-8?B?VndCb1hGa0VJTmVDbmtTeWFyblNGVEJLYjIwQm1VQ05FTWh3RmhNRTM1UTlU?=
 =?utf-8?B?TEg3SHczd2xPSnJYRkpmd3I1MmVyTnZXSjk3MkVVVWtsVHR1aWx2T0NEeVBs?=
 =?utf-8?B?SnhLMk5WNUxESVhtUnhkOTRTMGJoVDVXOXhacytNRnNYZHNiSUxMeGs4ZWw1?=
 =?utf-8?B?dkNVOTVLTlhCQ0lYY1hIMkc0NHVMU0kvVncxeUxpNXZZbDZURTJHSlN1cUtt?=
 =?utf-8?B?a2I1ZkovVEJTSHVwTHFwS3J5c21DYUxQRjQ1RytIdU9OVlFxRG9abXdhU3FR?=
 =?utf-8?B?eld6WUNKalovRDZrMHpkVlVnREdZWXAwcUpjcHNSTnJqekR6S2NkcUNlclRo?=
 =?utf-8?B?MzZaZXRaM3dpQnh1OGZVS3h6ai9KOUhxbTUwbWR5WUlRS01LejlmR3FuSy8v?=
 =?utf-8?B?aWJ5clA0UUhKQ1BKeTl1R2c1RXc5ek5WMnhJV09rQUVWeGc3RCtLNm5tMTdT?=
 =?utf-8?B?bE96UlVkU2RxV3VJTUxkY3VIaGFSSXYwenN2QVpDUlM1YVY5a2FKN3VhQms0?=
 =?utf-8?B?dmRpdUI5VUhzb2dZMTdrYWhBQXFGVUd2MDE3amNFMnFwMXNhRnhIQlZ3OTYy?=
 =?utf-8?B?K1JoT3doZG5qZGc1U0sreXVmNHFYZWJJQU1jTHdxYzJpRG9ZTmFhb2ZnZFFy?=
 =?utf-8?B?QVY2MjRBVlNIL3dIRDVpUGgwbnhQb1Q2WVZueG9hSW1DdXdLNlRta1pZSnhE?=
 =?utf-8?B?VDh5c1NjTm91TmlZVUlQM0dvRVlXR05TYTk4cFBieXJSVGZxcmtrRnA4SE9j?=
 =?utf-8?B?QmxnZDNLT3E0cmlwTFhhS21WbGdpN29IbTFVU0NmaXFlK29mYkFWbzdFTDRL?=
 =?utf-8?B?TXFiZUdmMmJzc1RlVDlOZjZJSTJpY2xvMjlqRjBrN01zcERKcXBYblFUdzJO?=
 =?utf-8?B?RW82NWF6Nk9ndDRuQ1ZBRWxmNGpEWGVPdlhMTFpuKzJTSm9KUGtFZ0lJamR2?=
 =?utf-8?B?Y0FUOTBaeEZZKy9SN1cvOFpFYi9JQ1AzelplTWZlR1RFcy9HeFhFVW5BYUY4?=
 =?utf-8?B?ZUsyZHB6SEx6d3V5ZVU2QkN5L1gwdnZiWlI2SWN2YlRXYmkzaHkyc2VnbW1s?=
 =?utf-8?B?d0VubGxrR0Qxa2J4T3YyeGJneUJzc2htQWRPRnVTOGR3a0NRN2QzVFdXRG5U?=
 =?utf-8?B?ajBmOGZOdGFNK3BYVkZrTzcxdkVLdjY5S0V6Q0ZDYys5NjBxbk91Unk4NlV4?=
 =?utf-8?B?dW00SWhGSVVuM3QzMHJxQ1FHT0JLT1lJRlEyUjhPK29ZVEpjakQ3MHdET29Q?=
 =?utf-8?B?TGY1YWxnQllpOUozTFFCK2hjN1FaRlNnU0g5OW82OHJpcnRvK1NUb1pIbmJm?=
 =?utf-8?B?U29uMko2L2ZPa21OSnBtN3dSeWFaWVhhbUVjZ1dBSlhZUFpnRTRUbFRtR2o1?=
 =?utf-8?B?NUNnTWlvUkVKL2s4Yy9TNi9JLzhsaStvZ2dBNjF4S2tlYVJLaVJ4V2ZUVTAv?=
 =?utf-8?B?SktQY29ISDgydk11VmJWL0RERXRuUmlWbWZrbmxTVWpNMlRNcHZrc0xFMVVC?=
 =?utf-8?B?SEt3dG9RMTRiTXpmN3EzK3ZUdWNrUzNKYVRTVUFNZk16Qkl5QVhwRDRwNnU5?=
 =?utf-8?B?cnNWTk5lMkwzVGlZUDhTalFMVWtTMzNqTk1wbzJ4QTRZbkgwN3NsbDZqR1Fk?=
 =?utf-8?Q?HQlq4T7zDOGU8g2FHg5TOnHmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e715b6-15ee-4431-3756-08ddfa9e5add
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 12:40:19.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkzGr1smRMcC597mL/3k/gu1xFM/98sfkMqS8SKLihHPGynRhb3J94H1VgssFFOmim7FvPJjZeqO2JZaOs1DUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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


On 23. 09. 25 13:51, Christian König wrote:
> On 17.09.25 11:59, David Rosca wrote:
>> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
>> Scheduler expects normal fences as job dependencies to be able to
>> determine whether the fences come from the same entity or sched
>> and skip waiting on them.
>> With fence chain as job dependency, the fence will always be
>> waited on forcing CPU round-trip before starting the job.
>>
>> Signed-off-by: David Rosca<david.rosca@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 2e93d570153c..779c11227a53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/sync_file.h>
>>   #include <linux/dma-buf.h>
>> +#include <linux/dma-fence-unwrap.h>
>>   
>>   #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_syncobj.h>
>> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>   					 uint32_t handle, u64 point,
>>   					 u64 flags)
>>   {
>> -	struct dma_fence *fence;
>> +	struct dma_fence *fence, *f;
>> +	struct dma_fence_unwrap iter;
>>   	int r;
>>   
>>   	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
>> @@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>   		return r;
>>   	}
>>   
>> -	r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
>> +	dma_fence_unwrap_for_each(f, &iter, fence) {
>> +		if (!r)
>> +			r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
> You should probably add an dma_fence_unwrap_cleanup() function which drops iter->chain and sets it to NULL and then code this like:
>
> r = ...
> if (r) {
> 	dma_fence_unwrap_cleanup(..);
> 	return r;
> }
>
>> +	}
>> +
>>   	dma_fence_put(fence);
> That is superfluous now, fence was consumed by dma_fence_unwrap_for_each().

dma_fence_unwrap_first() gets own reference to head, so I think that 
should not be the case?

Regards,
David

> Regards,
> Christian.
>
>>   	return r;
>>   }
