Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39B7CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6D410E0E8;
	Wed, 24 Jun 2026 18:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5V54FHK";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C63310F014
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7k5YZrzpCJZBZwdoeN5kNhMpxE2o47joqXYwPL08ULAInpIKz/x5W80o1hSlybuGJ59Rac4banzWzkObcgD2hMPYDwwhEtyrrvjWn3kfl4C7g5q39i8dEV3JZZ4/wUPKkZTutKbS34aZvdtRQMiQTCLppFSyxwy0w8OS2UoSncf3h9H1bC6cf7TGFTQbDzTsJWnFKODCKITZlxuZsipTBrBWnpogXtPJHsLOabO9LXzfXfx6/9gl4cyxKz1zZQIva4llTw50SrmoEov+gzS7VxrQ1J8v+w8BhfjizvdRKaHs1iyW1z05elH5BJKtOnm5pnKRC2M73yz9YrfTzuTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx0EndS6Gfp0XKEYb3x+laD5ew4wREVwFXmtZCRFZpI=;
 b=f1zJlBQBL/SNrUQP+CRC/oAevdNEnb4OWv+XkIGYCj/LkgfAzrdhrEyNY6M7bJvYBP/LCx2oRorgPRnLBtbbldBcwEk+eECAJhP6z9Dy5+C99fEJ9+3CrvXLLwk6N0wc68btKXUs2mZHRANuw6wBsFp59AgqBbg4ZISYMUYDBTPaU7TMss7vlBBGfWFiZHdJmklCMeUk2hAW55Tz/YfvLMyzS2MU9IH+eMLgASvcQBXzyNfqr7wxZzjuv5Tky6aS75WWtOzLbjYNbcH8jhvbhXPof5azMLvaRwi/g4yjymR3dgdu0qfTkGMnZy3d56vbndTmfIsLP+CmlKwhVP44Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx0EndS6Gfp0XKEYb3x+laD5ew4wREVwFXmtZCRFZpI=;
 b=M5V54FHK41jPAejDULOb2VPvJ/VzNIx8W+ykc1LSgxT1Tf5P4TjJbKsng676KPpNTDpM8SVmxRLDWEF4IBj3YcNDYpkESNtUDVGTAleJoi3Z+EpH64JGGPx48smnupu8jMIb+RhLj7bbPEJ1YBkXkt+vcdr1yAWk1lEhfuCVV+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 18:54:03 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 18:54:03 +0000
Message-ID: <436f03eb-0b19-4eb6-b884-c45a79a067e7@amd.com>
Date: Wed, 24 Jun 2026 14:53:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Charles Munger <charleslmunger@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Hung, Alex" <Alex.Hung@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
References: <20260619045904.5872-1-charleslmunger@gmail.com>
 <BL1PR12MB514432F894701A3CBAD341E9F7E22@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <BL1PR12MB514432F894701A3CBAD341E9F7E22@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bde796-aa82-4105-dcb3-08ded221f5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: yD6mED80N2UxvvMMre32j7cS4cUOEdeCXOg5vXza8vi10uhqLUbyqammLD+sUP/9zhs+Xeu6XyHu2hbG5Q5bYrfXKQyN+maC+hy5zdfrNf6ZTHZo+VHEFUZkZCNr34gXaIKAjv/MN8+oiHYerhFIwwtwSbEWyZ0ps5s2ShYs4iR8/M4PPgnpqi0Rblepniu7Hp3TuoSA2JsB1+fcZVNGxx+QnYnL48yIhqGBX9H7unrfGRTjdnhesHaLtXUqlTB9RGUTh9iOu+/wHhxEeLAJxezfWjRqrJWIOk0w5aqG9Xk4vJlD8Py4HzXOp7cmK9nA8hKzSfXR096QAbRro2+3yTeKeZ0/dXxF29LaVnkX5Z1dufUnvUb2R+bAH4UjfNfVrEqNpctEPOb+LflltT9gpM3WzsIM075+uzgPcWxzOh8y8Ji4H5UD7DE1i7ux593Td9Dch3oEckYHxNvSQJ8wU/xZnHZd7/S2H5TFcOrypjQ61tkc21KsKH+2YQol0MrDFA3B7Dsa9jhLeMjGwVCMOb3AJBxckM3FF86R/TC+ppqf3kszFO47HRrCrQ365l1/dR3aY2Kg4BhQzQoDutoz1n44p5cu1spaVy6k66Os8ipdw0dp5Y/reT+bhyJcAoBB3ntZFJghMhtvD2cpnqZ8OgJmgO15+ZqA6YZIvc2lG2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1jSmNZZXVKMDNvcVNSbWpLOUpYZ1IzbzVKcnVlTzB4dHNaWFJEZVlWYk04?=
 =?utf-8?B?ajJ2b0dadDdZSWdLdlFKZkM1ZXVPQ25uNGh4VUZteFYwbUc1ZUNBbVN6eXBX?=
 =?utf-8?B?Yll5eVFXT2J4ZkljWGh0VEgzeHJ0UWYwYW93YmVZbFMrNzRCMURXdjVvbHl1?=
 =?utf-8?B?K1J5NXJETE9ibm9xVjV5SlpvbkFsUW9TUXlKdjJGN1h0NkpTS09vbURoYmlu?=
 =?utf-8?B?c2xPTGlQTllodFR3dmJlS0hkTG5DaVNPd3llbEVvZlVIeWhZd0xvM0tKbG1N?=
 =?utf-8?B?VnBZbk95Z01zVkw4WG5FOGl4VTBycW1BOVBxakVuc2F2TGxzVStUN1RsaGYy?=
 =?utf-8?B?YUl2MGdNOXlEeWRlNlBpZGxocWJzNG9iWjB4QlFmVE52NENUVEFhdlpLTnhF?=
 =?utf-8?B?TTNPWU5kUXRrQTBWWE1GMy9PR09Xd3BPR0FqRzBnK0E1SkxBdUZRREJseGti?=
 =?utf-8?B?Q09CRFV1YUo4cWVPQmxXMUVuQ0ZwKzJQVlM2dHl5RVJwOEE0VTdpUVZHalZm?=
 =?utf-8?B?czEzckd5cEpNaGthRkx4MVVOZjZhZnQ2NlFFdFkxTHl4elQwVkNMK0NUODVW?=
 =?utf-8?B?QklSRUxoeVE1K3RvZEFQYjdwWnBoMWRFMmlUcU1hTTZuVUFZRGpVOU1JZTJi?=
 =?utf-8?B?Tko1eUxFRmZMay83NFZuT1NrR25hK1FRNElmenhlVGw2QmRnR0NBSXA2MWJB?=
 =?utf-8?B?dWppNWJ2ZmU5RzRYUlN0UC9EdVF1VWFjd2M1YTQ3Y0NVanl1ZGJXQkNXRjg2?=
 =?utf-8?B?bGd4U1JRaTBydTc0Y3BDazYzWExFNUR3UGhNS1UvUzR3d0hRVWpwejBUTzly?=
 =?utf-8?B?azBkWURDUHZCYTBqSmp0U0V0Y1Qvb1V2ZkhpdXJlVzZoODhVcnB3aHNOSGVw?=
 =?utf-8?B?bElxNllYc0hsczBJVksyNVlQaWdCOHc5WUFjUDBwOTk4OUduRUlqQ2NrUWo2?=
 =?utf-8?B?WjBiaWtLZlFadFlSYVBicTRUNDdSeFVwVDlROFpReWRzaVJQMXcrcHJSMWho?=
 =?utf-8?B?MHFLZDB2aDNFdHgvaWgxdkUxTVgzUnBJRzNYenBIUEx6RUptcDNTaXJGNzdY?=
 =?utf-8?B?alMvTGxPek55d0NwbUYzUFNsV2RNRHY3YmZ2Y1IxYUVLbzVYbk1PTTl1ak91?=
 =?utf-8?B?Y3NFb3FtSlJ6d0dpSWhzNTMyd1JzeXRiK3ovbHZIOXpWblRvWWZ5NmpyTlVq?=
 =?utf-8?B?N3FlaDNOZDFhVTNFeE0yOHZIblN2UnNLWldzSitlSjR5Q0hWdWRweHF5M2N0?=
 =?utf-8?B?L1ZqQnpnd2x1dHZuSldFSm44ZE1JM1pkMmZIVGUzM0xpZ2dMSU9LdkN0ZVp3?=
 =?utf-8?B?Q2RlcWh3eGxkOWJaZFR2TEtGZHh3YTFLRVF4VVdLWVNLNnlkR3RzL3hnMDdV?=
 =?utf-8?B?bFJtem9XTkFNY1JoWC8zM2MwWFp4ZkN4N1U0RU0yWmswVHY4Q2R3QmtqV0VN?=
 =?utf-8?B?eU9wWWMreUtlQWtadUlGWkhRU1pVbkJDMWNHZkthNE9zWDdVSGpPbUZLallj?=
 =?utf-8?B?VjNSdjhxR0xneUR3cFpaRGtvYXFVcmkrbThNejZPODJCQ1k1UWF3YTI5SWt5?=
 =?utf-8?B?RWQxUUdWTFQrYTZJZE5tRnJOTTBpblNGcUFwVUVQWTJkRy9zdlZsamhmVlZX?=
 =?utf-8?B?bExCTGNhZ0lYTzZyZGtlVVdhRUNrN24zUU92Z2VIQjIwYjdELy91TnJhak1G?=
 =?utf-8?B?OGFybWNOMVpJRkVrQ2FDYzVNdDFqdk1pR285WSswZThvSE5CdklHbmwzblBy?=
 =?utf-8?B?SHo3NkNaR1VZeHhXc0c1ZEE0SGdhVUV0VEpLSkhpL1BsUkI2M0sxb2NzWElM?=
 =?utf-8?B?dXRSYzkyVHY2N3ZoVnE2TkVkUGlzc3g1YWJxWTl5RkdXSjhGM3hScEU4cGtN?=
 =?utf-8?B?WmxmKzhaZDdrR3hqLzlRalBKSklacVVxalF4WDk5cGl6cDhOdmhqWW14OVdh?=
 =?utf-8?B?eUJ4ck1taFdxY1MwemplaHQ4Ujl0ZVhwWDhoTFRnaVJlZXROajdFNVJ0TVpv?=
 =?utf-8?B?RU8xQ3gyRmt6dHFPU3lFWjFMdjZDUFdRU0VCeEo3ekx1ZTJBTUsyQm1aNWRU?=
 =?utf-8?B?Z29KamloS004Qm5RaE1RSkpCS0VYL3JzcVF0eWVhTmtkWHFlTnl6ZU9ORUZn?=
 =?utf-8?B?b3pZNi9UVXJsRHo3OHBCZ21YWEVQRlVCWEI4YWROYjJCbTErV0k3bG53MmRs?=
 =?utf-8?B?T21vWU5IWG44dE5GQlUzMnRIL2lHcnhvOHZpM2xlYkljczJOVXFJUmdSYisr?=
 =?utf-8?B?N21KSXFLeUo2eGE2YjgwbkkwQTh4WURpWk04Zm1tR0p5Q29NOTJ1RFU4YUor?=
 =?utf-8?B?c3dLUmdheVpRUzBaMzl0R3dIUU1Bb2Zab25uM0l6Q2N6dVZ0OGliUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bde796-aa82-4105-dcb3-08ded221f5ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:54:03.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tm2LVfe+ShF/gM5+DlmKC4z/76AQwuYkyGkRemhH25FzTahtjaIhCxM5MbOdA1wot7P2S2vwZO2kAJpOdJ1W/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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



On 2026-06-19 12:17, Deucher, Alexander wrote:
> Public
> 
> Adding a few display folks to review.
> 
> Thanks,
> 
> Alex
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Charles Munger
>> Sent: Friday, June 19, 2026 12:59 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Charles Munger <charleslmunger@gmail.com>
>> Subject: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
>>
>> There's at least two firmware versions on the CalDigit DP20-HDMI21 adapter,
>> which is powered by the ParadeTech PS196G chip. The first version has a bug
>> where it incorrectly neglects to set the DOWN_STREAM_PORT_PRESENT field
>> in the DPCD:
>>
>> $ sudo dpcd_reg read --offset=0x2205 --count=1 --device=0
>> 0x2205:  00
>> $ sudo dpcd_reg read --offset=0x0005 --count=1 --device=0
>> 0x0005:  00
>>
>> The newer one fixes this, and with this patch correctly negotiates VRR.
>>
>> [~]$ sudo dpcd_reg read --offset=0x5 --count=1 --device=2
>> 0x0005:  1d
>> [~]$ sudo dpcd_reg read --offset=0x2205 --count=1 --device=2
>> 0x2205:  1d
>>
>> So if you're using a Paradetech adapter and it doesn't negotiate VRR, check
>> that it has a firmware that produces the correct DPCD.
>>
>> Signed-off-by: Charles Munger <charleslmunger@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git
>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index 6c827e6703a0..f463495d1c87 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -1410,6 +1410,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const

Looks like this is based on the "drm/amd: VRR fixes, HDMI Gaming Features"
series, not directly on amd-staging-drm-next. I'll have to take another
closer look at that series.

Harry

>> struct dc_link *link, const struct drm
>>       case DP_BRANCH_DEVICE_ID_00E04C:
>>       case DP_BRANCH_DEVICE_ID_90CC24:
>>       case DP_BRANCH_DEVICE_ID_2B02F0:
>> +     case DP_BRANCH_DEVICE_ID_001CF8:
>>               return true;
>>       }
>>
>> --
>> 2.54.0
> 

