Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA2C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 07:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A37D10E66F;
	Thu,  8 Aug 2024 07:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XeyjPF2d";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34FF10E66F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 07:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNXPHQhvEA7+2Xp19FRYsTE8Bip7mkybqyaCb1Yqh110+DXESCLPr3aE/JGrdK7/J0rjRuzR2srKBUlFlT+mnDoE5w9GUsSHCbmWsb8R3RzyG5w+a+fBfJ1w8ypQnDfsIhblzmqB/UhW/mYI0ifcdljgHa/weyM/mU2JDKSzZFfuSxGcihxyJiCf5V4XQJOiOVhsEV65mHsTu0Uh/49wWrjpKj4iW0w2Y4vCFMC0HzY9ScxGH2QCZGFi6kz1Auc3Le/KXBDMMPdTqYuV8BmNzEgurgO5T9zifjqK+eWMc6uyURJbxq/9GLZAgpYVxthoZIqsSaJOQWw5lHWYSj7K5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjaxXSSpNhXTJUZKB8SBb8b2xrLrqGjoBP1Powwoww4=;
 b=oWVQZ+Bph3s2Or+t4gz6sXb2RkreH3n59fj1g0D7iLK0sFrqvWa30aVee9QlXwmZUaCqhD6jLWNW6UoPMl+fIE9uvVeBg+KlS41Y91lwWM712jpYM5WRYvqnlFYdTjfI3ol2AiezORlWbmyV+rQlhWWwXOmmhq8FAVAOYzEKqvxmNwlphPZUSecq5e19dKC7MJrvbrZGbWzICtrwE/SwRf4WAQusAr5tlx5F1OPoFrlO7H0ukdnCMBzxUS09jxaNslMVqvO5osKB+wC4e3Gyi8xch8fNwKNBfbGXwhKIE+AUNK+aXcrnqMkdwPqFVE9yJC27+hgEjvi1Q6RfrCN3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjaxXSSpNhXTJUZKB8SBb8b2xrLrqGjoBP1Powwoww4=;
 b=XeyjPF2dGUiajMve7CdQZW+YRFPfy/IY9Gdk85wglT0f5ilp+qVpzz70xTppkzIOSaIjpwL4th3iIvmaXKKLg1jEpQifpFB+c1Ul9FMj4020Wdjl5ZEh+HPAb15UehxOYbpLKGkMZuAY4GUySLpK8VLAMECpgNfTSxEKBKOyvn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.14; Thu, 8 Aug 2024 07:15:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 07:15:02 +0000
Message-ID: <e3dde88f-8362-4e80-9e48-c6fb99035861@amd.com>
Date: Thu, 8 Aug 2024 12:44:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
To: "Khatri, Sunil" <sukhatri@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
 <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
 <a35d84a7-3d8b-4ca3-9157-7d8d48a54b02@amd.com>
 <2ad50a00-b443-47c4-a9b4-04fbfdc67be9@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <2ad50a00-b443-47c4-a9b4-04fbfdc67be9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea64211-9237-4b8b-e029-08dcb779d227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZaTlptMnp3SmxoYUtOTUtJc2V3VEZqbXR3MlNBWVNIcCtHMVdkajdxYjRN?=
 =?utf-8?B?T2tIV3dvQkhtbktocnpmSWFpM05DV3BBbWZqYnI2VUg5aVZTWXRFSmtFTFBp?=
 =?utf-8?B?Qk15bXJuZ0pzeEFjTWprNU9KMDVteURSNGRwaHFyVnRwY2lqS2JFWUNQdC84?=
 =?utf-8?B?OGRTeWZXVkx5RnM4dy9waTYwTnpaZVRLU0RoSkk3Y1h3Q29kY0tlZ0svY09s?=
 =?utf-8?B?d3d6bllsakh0SW0xK2M4WCsyWkludDd0SGE5d0YzK2lQUXFpL0VmQlZHaVRR?=
 =?utf-8?B?K1dlaVM4c1FtcGI3SisvQmtLSVNEamJZQ0RKN2x1NDhkK0JFaW5mOWpyblk4?=
 =?utf-8?B?cVNyUE95U0FKYWFta3JEZWYraGdtVThqZmR3dUNsMnArZmZaZW12MjBac3o3?=
 =?utf-8?B?TU9qUmF3SHF1Y1dJa0N6Vi8rTWlUUGNydkYwZkp3NENzdng4cjdrSHd3cHFH?=
 =?utf-8?B?Nm9YeVB6blQrOENDd2RwUWZuT3lReGxvTzMyQ3V2SXJ0RzcwUllOWktYZHNs?=
 =?utf-8?B?Yzk0S0J3RGw2WHcvdDhYY0dYSTFzcEppajBpY3luZG03T3EzM3BhVFlRMVQ2?=
 =?utf-8?B?WVY2bmh6a1FKeG1Sd0ZYa3BJakxLSHRqWU1HcWhEVFdJVy94SG4yOXA3SGdy?=
 =?utf-8?B?MlMwOC9QM3R3bTlZQitMcDJXa1ZrQUt3L0d6cDBRTk04cTdNRUZOQ2dZL3JX?=
 =?utf-8?B?ODEzTlo0YTBoeEpuRzE1bmRudlhSQmpVZEljeFJLYkY5V3pJazh4cWlDSzli?=
 =?utf-8?B?N3R4OStDQkRDTHlkamdkQThDcmVZdFVUaSsvYUxJN3FRNHpaUFVFdWtIeURk?=
 =?utf-8?B?elJqWmpxcW5nUkZ0L2ZpZUh5RndabHArZzU2RkdYMm9LdXR2L2NXWHRLY0pK?=
 =?utf-8?B?cDV2cTk0V29wQS9YVUxOMUgvUjZCU3NZWmJubEFsWTlSTlA0MXVmYkJTU1lm?=
 =?utf-8?B?Sk1Zc050VVlCUEpyY2wwTFVhR2NWell0citlazdYYkY3OUwrQmRjV3ZKamYw?=
 =?utf-8?B?UlR5RnVsYnQrbmt5MkNBb3hYZThMZ0I0aUl6OEJXKzFsVnM5aitYUlRRU1VR?=
 =?utf-8?B?NHNVVjdIakpVd0NQV0hoMzJzRDdwV1lsa3FWSmJVQ0lCS0VTUXA5RjJJQUJp?=
 =?utf-8?B?QklmRjNzWjMySmZLWDRyWDFRWFFDZm8rTEtLZnR1QXkyK2VRTENiRHltaStT?=
 =?utf-8?B?ZGtzZ2haQ0tZN09OcWJyK2N1Mk0zSGZDaXdZaE1qZW5CaEdRbzRjM2w2TlBN?=
 =?utf-8?B?RFZxTDRGMFdhYVRHRzRXcFZXMkJjNUt4ZzU5a1NBUW85ZVJwT2hpOFVQWTdV?=
 =?utf-8?B?RXEvbmwxMysxVUMwbVdTRkZib3dGMG12QURTbi9ZcmplcHN6Q3NEeEoydWhF?=
 =?utf-8?B?cVFxS0xPRzFaZU1TenEwMVNGd1VyaWx6LytMYW1EU3NqMVNWcW95emVWenFv?=
 =?utf-8?B?ZjRKNWNIMytqNHZSV1JjZ1RkSm5FSXd0NjNHSzR0UW1aQ2cwQVVGQy8yWDZm?=
 =?utf-8?B?UUhsSjRGeUQrUU1IMFlERGVkVkFGR1c3WnRJQkhhdkIvSGdOOGFDejV6REVh?=
 =?utf-8?B?eXo1Rjl2MjVHMmNyVFJaNmsrams5R3RveXRyQityQkhVZXlYd29BTkU3NUdQ?=
 =?utf-8?B?REpRaGRBWjBQeGxCYjRGS1Z6UFlDL1NYa0JWR3JkQmZNRFJUSGFvU2pmUkI0?=
 =?utf-8?B?RnI4UkdKUlNVYUViK3duc2RrRDRSRTF5NjBLem8vMjg2S2hKQmFkeVN4VDdt?=
 =?utf-8?B?NldhOHFQTXQ2S2o5bFkycjJZRUN4U2s3OXF4R2gyQVR5MjNJb1k3RURkbzJv?=
 =?utf-8?B?ZWQ5VGdoa2IrZldUeGpYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxKa2RhTkdYWGR1aU9VbTVZYkNoNFU0TzF1U2MydjV5cGFqVk5jRDB0Rm0r?=
 =?utf-8?B?cDlQakJGeTNHRWM0elRWV0VuVW1iMVd4QWNmcU5EVE5CTjRPdFFzTWovQlVq?=
 =?utf-8?B?OFZuRUF1MmRzMUVKNDVmbDdTL0t6cTFlSStQMjdyTEkvVk5qL2xtVTVBZDdF?=
 =?utf-8?B?TlI4WndydXJtQkl2V05EczYwcG9pZ2xldzhKQjNmWlg5cTU1TXhWV0ZWSm1T?=
 =?utf-8?B?VkdpbklxNlUwcStneFZLOE9GengrVnM2TWhLQUcrcW1zNHV3VlUvbFZ4SFV6?=
 =?utf-8?B?MWJCVHYxZUpjenlSYkZNZm1yTzVPRmFhYmdtQTdhUWQyb2JqZ2xlZWZleVIy?=
 =?utf-8?B?azJScy81WlVTcHBubDV1SGxIYlFzbTJrc21GSWc4eGYzc2ZuM0JhSkxva3V1?=
 =?utf-8?B?bFNrQnI0OFBOVXNJb3Zqc0hwY2hHZEJyWlYzdmU0V1VpeWk5RzZ4bllML1JK?=
 =?utf-8?B?M2tZT0szY1dxL3FiZnpnUVM5QVk3T2gxa0hGaWZteVBpeHpWTEZkenlENm9i?=
 =?utf-8?B?QlE1MHhmMWFHUENFVTBKSnN5NS9UelZTNGZtZWxDU3l6aUc2ZlFDMFRyQk5r?=
 =?utf-8?B?a3JZVTFPR0VodXNuNnN4RVFqbS9qTFBYTUJFeWtGNXpSZUtvYmpiWU9NOUVN?=
 =?utf-8?B?SlpnUXVuR1BiekhYTjlSNFdRSmVTVDJnbDRTNmczYlJ3QzU0R0VzYmdZblQ1?=
 =?utf-8?B?YnhEajA0cFhNRzF0QTh5KzNCTmY0ZjdMaTN6akN3ZXp1TlJLZFRhVytRK3pv?=
 =?utf-8?B?REQwS2tiYjlGOXBFUURrcmNQd1hWKzd3RUNBdkN3UEhLR1dmVTNoZm9qR3Rm?=
 =?utf-8?B?cEJ0QjJuMXN4OUNPOE04eVRwaUFETmJlanJZc2F3V1hkSWhPZmVMMFRGY0o4?=
 =?utf-8?B?bS9oT0xBQlZ6ZmNEck1XQzkrYnc2T1Z6WVRvM0dzT2ZleEdKcFJpeG9lZjNW?=
 =?utf-8?B?U2NRcXlkeXNvS3MyYkdnazVaYW9zazlDWldJcUE2cXpJVy9palllWFNhZmU5?=
 =?utf-8?B?TnJqR2VNS0FOWmIxMnMwckk0VjZRbWFDT25nTkRYR0tBT3Q4bDdvYlhid1VJ?=
 =?utf-8?B?bDNJUkFBYXltcmFrQnFXdXljQW9WSWFXSDN0RCtkV25xUlJpOVJWN3RvTXJv?=
 =?utf-8?B?SEMvbXRhOWNxRkNYRUsvSVBZcWoxSTBic0JMamhYSUhlOFhYbVRaMmpwbElQ?=
 =?utf-8?B?T0JHK2RpMmZkbjBoVHhlbUN0RkJjeDlwblRmMjdTQWFzc0x6aEE0SWJETFVk?=
 =?utf-8?B?bmFiMFJzTmlyNzRkc1BuYU9ibnVxMG4wakxyeUtLdHVtQitGbVhSVXgybi9t?=
 =?utf-8?B?RFRRUkxVRGhVTG90dlJZV0liVzRNTEhKMXdrT2Npc3IvN3RUNEFuNEJUekRE?=
 =?utf-8?B?NVNldklsUUZhMHdTVnRZTFdmQVQ2VC9FZFR3MzZyR2xiRG5uSTJha0J4Vmpt?=
 =?utf-8?B?aEdoYjVyeXBlTnlIcTdjUTg4UGw2WjhCelFkb3BOc2VCU0xNS1ZwNnZzdWFy?=
 =?utf-8?B?amZWREYvT2RPbW1Vc3RSSHJkaG93VWF1ZEFiYnlJWHQ3SWVsVHB2S3RTVmgr?=
 =?utf-8?B?ODUxNDY5VGRpc2FNdTRRYzVobEFHK29SbXk2Tmd5UW80Y1hZdVlaSGozR0ZF?=
 =?utf-8?B?K2hIZG5FUmJ0WVVvcVdSM1ZJajJaMFVMMllUSWxJR1JHbmgyRHpYTWpHU2pR?=
 =?utf-8?B?ZWoxOWcyQlRoN2J1cFZpbDBOS09JcUlrYU5XMjRodTVxU0ZhWS9xb3gyMDdI?=
 =?utf-8?B?S211SjM5cXdZN05zOWRMTEVpUUp6T0hIcjBVa3R4b3lIQ3ZRVGt0RUhpTndP?=
 =?utf-8?B?RTJGcFZyb0wrV2tsSXNnTWVHNXdRNnRzaVN6K3JZTHlyNjErT0RRMGVEWW9C?=
 =?utf-8?B?YmNnK3dBMXMvSFFrcjZTdWlucmQzOTAwL1NVdVNjRFVPRmRzMzVkc253ZU1B?=
 =?utf-8?B?WkZ3NzlnSytZc2Rid1JLU3hrdFd5dzZ5OWlodHJMWUoxYlZXRWZlR2dZNWxW?=
 =?utf-8?B?cit6bmxBQmNwYXNoWEJMc3FEeUszcnp6YXJta1hiYWZ4elE4WEd4OSt4bDZX?=
 =?utf-8?B?SzY0SlNYY2hyeEl0YkVDcmxFT1pMOEFyeU9IZWlqN3Y2VDk5QVRvNi9hWlB0?=
 =?utf-8?Q?/Bae4Zq4G+Wd993EcbAGbh1nU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea64211-9237-4b8b-e029-08dcb779d227
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:15:02.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqRW3hh5DdDk1F/d2c6igzLBVDVfNPlvyuLgZW6UBo2Y+gcd4rbGlcv46SFgwUD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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



On 8/8/2024 12:36 PM, Khatri, Sunil wrote:
> 
> On 8/8/2024 11:20 AM, Lazar, Lijo wrote:
>>
>> On 8/7/2024 2:58 AM, Alex Deucher wrote:
>>> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <sunil.khatri@amd.com>
>>> wrote:
>>>> Add support of vcn ip dump in the devcoredump
>>>> for vcn_v4_0_3.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170
>>>> +++++++++++++++++++++++-
>>>>   1 file changed, 169 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> index 9bae95538b62..dd3baccb2904 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> @@ -45,6 +45,132 @@
>>>>   #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
>>>>   #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>>>>
>>>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>> regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
>>>> +};
>>>> +
>>>>   #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>>>                  (offset & 0x1FFFF)
>>>>
>>>> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>          struct amdgpu_ring *ring;
>>>>          int i, r, vcn_inst;
>>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>>> +       uint32_t *ptr;
>>>>
>>>>          r = amdgpu_vcn_sw_init(adev);
>>>>          if (r)
>>>> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>>                  }
>>>>          }
>>>>
>>>> +       /* Allocate memory for VCN IP Dump buffer */
>>>> +       ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count,
>>>> sizeof(uint32_t), GFP_KERNEL);
>>>> +       if (ptr == NULL) {
>>>> +               DRM_ERROR("Failed to allocate memory for VCN IP
>>>> Dump\n");
>>>> +               adev->vcn.ip_dump = NULL;
>>>> +       } else {
>>>> +               adev->vcn.ip_dump = ptr;
>>>> +       }
>>>> +
>>>>          return 0;
>>>>   }
>>>>
>>>> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>>>>
>>>>          r = amdgpu_vcn_sw_fini(adev);
>>>>
>>>> +       kfree(adev->vcn.ip_dump);
>>>> +
>>>>          return r;
>>>>   }
>>>>
>>>> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct
>>>> amdgpu_device *adev)
>>>>          adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>>   }
>>>>
>>>> +static void vcn_v4_0_3_dump_ip_state(void *handle)
>>>> +{
>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +       int i, j;
>>>> +       bool is_powered;
>>>> +       uint32_t inst_off;
>>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>>> +
>>>> +       if (!adev->vcn.ip_dump)
>>>> +               return;
>>>> +
>>>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>>> +               if (adev->vcn.harvest_config & (1 << i))
>>>> +                       continue;
>>>> +
>>>> +               inst_off = i * reg_count;
>>>> +               /* mmUVD_POWER_STATUS is always readable and is
>>>> first element of the array */
>>>> +               adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i,
>>>> regUVD_POWER_STATUS);
>>> I think you need to use the GET_INST() macro to properly handle
>>> this.  E.g.,
>>> vcn_inst = GET_INST(VCN, i);
>>>
>>> Alex
>>>
>>>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>>>> +                              
>>>> UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>>>> +
>>>> +               if (is_powered)
>>>> +                       for (j = 1; j < reg_count; j++)
>>>> +                               adev->vcn.ip_dump[inst_off + j] =
>>>> +                                      
>>>> RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>>>> +                                              
>>>> vcn_reg_list_4_0_3[j], i));
>> VCN 4.0.3 supports DPG. As far as I understand, most of these registers
>> are accessed indirectly in DPG mode through indirect SRAM.
>>
>> Checking UVD power status alone may not be sufficient for direct access.
> 
> i am following what windows is following and most of the registers are
> directly access but i agree some might not be.

Whether Windows logic works is the first question other than the
secondary question of value in logging some of those registers.

  We are assuming in case
> of a VCN hang it should be in good power state and we should be able to
> read most of the registers. 

'is_powered ' - It's quite obvious that there is no assumption like that
:). Secondly, when there are multiple instances where only one VCN
instance got hung, and others may not be - this assumption won't hold good.

Thanks,
Lijo

> Based on further feedback will do the
> needful but right now the point where we are dumping the registers we
> could not make any change in power state.
> 
> Regards
> Sunil khatri
> 
>>
>> Thanks,
>> Lijo
>>
>>>> +       }
>>>> +}
>>>> +
>>>>   static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>>>          .name = "vcn_v4_0_3",
>>>>          .early_init = vcn_v4_0_3_early_init,
>>>> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs
>>>> vcn_v4_0_3_ip_funcs = {
>>>>          .post_soft_reset = NULL,
>>>>          .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>>>          .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>>>> -       .dump_ip_state = NULL,
>>>> +       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>>>>          .print_ip_state = NULL,
>>>>   };
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
