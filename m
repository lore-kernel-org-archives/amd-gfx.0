Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDCEEE0213
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 06:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECB210E184;
	Wed, 11 Sep 2024 06:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WYANqmMO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31A810E184
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 06:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz/LsBLlyUEJa8D95MoqLBF+ZtKAj1bC2V522dE+JFR6KgZDGmLzqP4uW6S2N+XfsQCFCuzq04kIaMtlhA5hdYieK83+QO81KLNNLsiNDdRiNCJeX8qPrZD2NmMoLLb+5jYT4dnUwkT3341HA/xL8RxK7Gk8eXXt+SO8ncnDYA7mZ/gV4WeeF5XiLcM7M86Fr2RYBLHg8sZZDrqCQr2OdSjd8RlqjU23PexrRPs26XOIP2zcsWvLGLGxdt3Y55zhZHhnVUhlmHnA0ocqvpH4shwfuw6oT+SKUB1ECYvwEmci+VUIWf65m5it9c0EYqImLJiavHmH3FLq7urLMylZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SppbCma4PgSF+j14TQfJjOy3JbT2GlUs3V7T7hb1mM=;
 b=ApSFFt7+bTip/918lQ9Uh4sqPeejyQoUmUxw/4eULnRo/gXgI8U0N/8AwdgIrkZT3S2ZLb0DAoSDlnMIIAtZXT3OZ5bGiOtcC3Sr8CGDhAAMVAnAJdKNhw6/TZ0cB2B4gt28dHaZUOQufv4xMO5q4RuZTdyD5E/TjQNGlzXgMAPH1mgUIlYXbk8m572S8W5wiPjdVI9tzXuFxYGUvmIQ4q6tUeA3ez5UlqyrE2glYpMgbsvrinfszG8+thBueczt0hc8fgX15iWe/cfbyZehGMFZthpnfnBbiMQCXn/qgmL3Qpqlvue1uiwX8/17MZ/cUBquevCoKVaPQwJ6hXtiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SppbCma4PgSF+j14TQfJjOy3JbT2GlUs3V7T7hb1mM=;
 b=WYANqmMOP6OY4Bws+5kO5501x+UGMN/r53bTfh/ZFp06slijrawyhA+wUr6WLzjdU7fmGOLM45Y4mZUBOxtkh2xRg4LuBXXuP8BT5QhI8BEWfaWmI1XPMKT5G/pIgOOQ0kuP2Fk1z4PiwOvtIrotpT5g3gg0j7/IdEDYGUjqQ30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 06:47:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 06:47:42 +0000
Content-Type: multipart/alternative;
 boundary="------------TKaTZ0oRYyic3TXb67rFfHDB"
Message-ID: <71623908-4bff-4819-9ee6-6c9bc7557e06@amd.com>
Date: Wed, 11 Sep 2024 08:47:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240624140815.18085-1-Yunxiang.Li@amd.com>
 <20240624140815.18085-2-Yunxiang.Li@amd.com>
 <59ffec90-f8c5-4759-8794-df03067a5128@amd.com>
 <SA1PR12MB8599EF01801E282D63C16754ED9A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599EF01801E282D63C16754ED9A2@SA1PR12MB8599.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7cebc2-0af0-48f8-c01b-08dcd22da273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjVBa2NaZlpsL093NzRKZ2NZSjFGQ1Z5eHo1Y0d3OVBsVzRLbjJFYmtKRFVC?=
 =?utf-8?B?aFIwdytpd3lvY3o1NEhMZ3FENFArY0xWQ29wNU9oUGVTNGtkVXZwd0VaSnJC?=
 =?utf-8?B?R2w3Y0hqWVppenYxQjczTU9mMjB2Z2R0alV6WC9tM0JydTBUbE1RY1ZFZFV4?=
 =?utf-8?B?MUFlb1p6UFVEeTF0OXFhWGFTeEJMZWFrNFoyZFJMSUFBMzJvZUV5S1ZYdzdB?=
 =?utf-8?B?cVhqb1pvdW9Mc2JuSHAvNjJwd0M4Y09Va0diQTEwVmQ2TUpMTDk1OWRBR0tj?=
 =?utf-8?B?dTloQVhVNERhbVlTdEM4Mnd3Yjc4allhREVZczIwbmdHR08rSnA0MVVEekcy?=
 =?utf-8?B?N0FiZkhnNmpHYU02bUNnMmJjb2NYUWNwNGN0MzJoblMxOEhoaFhSN0JBQ0h4?=
 =?utf-8?B?UXVWV2hmMzM0ZzBuWmd1VHVBbmFTUlBGSk9RaHdaMnErNW1PVmE4bHlvLzRr?=
 =?utf-8?B?VVF1dFZWZnRLVTF0VjREeUVUcVAwVWZUK1ZDSG5Td2lXRDRvOGxyOG9oN0tR?=
 =?utf-8?B?N3BuVzVCZGs5MHpFSk1Id2RqU3ozL1FUWS9HWFppQlFxMkoyK0tEWlcyLzVh?=
 =?utf-8?B?YWJuMlpRLzl4QWZvbTV5dWhJYWM5UDZSZGNhOGFBOUdrOWorSFh5NTRhRU1G?=
 =?utf-8?B?cHRkcVhSRk9Sd21adW5pa0tlRmFtTW5FazZjN0xUWTI0TWxmeHdQcTZqamx6?=
 =?utf-8?B?R2NMZEJ5dzRLNVd2VHgyRHhjQkcvdVc5SFZEZTFOeGFpdi9ZMjVubm1MM0Vs?=
 =?utf-8?B?SEV2TFR1aFhSb3Jydll6eWxKaUZRcFdBNFlZVlZ5U3pVcjE3QldKc0lIN2lG?=
 =?utf-8?B?dUowdnArb1R3cnFZekpnVkxpak9kODZSbVlWaDFkWklGNGxaRmNGNDJiQUd0?=
 =?utf-8?B?SGJxdGZQYlRCcW91NXkxbGtZMmIvMEExdjAwUTZtemRtL3c5QkJlRENVZG0x?=
 =?utf-8?B?aSsrcktkd1FNeWRlZFN4SnBoTDUzTVBFYzhDdmlYQmM1RWswbXdCUjNkUk5Y?=
 =?utf-8?B?QWRBT2ZwUFJ4ZkR6QTFQc1c1dmtkN2hoNVpuT2Zqb2JuTDVkWm9zSnBsTkxF?=
 =?utf-8?B?V3lpTFMweFZzeE1KK081RmlseU1Kc3hDUHo3Zm9hTEx0aHg1TmEzRWNhaVcr?=
 =?utf-8?B?cUFxTlphQyt1eWdTVGFSdUVJcWxRNk14cCtZODZuZ0kzbGxNOVJ1TUsvZjU4?=
 =?utf-8?B?bnBST1M1WGhEMUdLVWI2L0pRZFFKYUVvTlBxRElIVmhkYjJYQjNUTTkyaEJz?=
 =?utf-8?B?RDFEUG9QRWVZa056QzJPa0ZRZTkwS3NRek1saGxseGNqS2x3cDAyem9yWkZ2?=
 =?utf-8?B?dWE5K01vNmdtczRhOXJFcXAvdjZuR2psTUZRTGhnd1hWeFIvNHk5bHNxNFhW?=
 =?utf-8?B?ekt5Mit4YUhtRVVyT2wrRCtmd1FnZkhuNDRQMVBtcmg0UFEyaXI5cWxLSXRM?=
 =?utf-8?B?djZSU3lZN0VNdG5wVzlPb3YzcDEyZU96VmNrdkNNc3pWM1ZRV1k0OW9scWsz?=
 =?utf-8?B?Ry9ySTBNaktMMitlVFFwZFZKZnRxd3FKMUd5MUo3TU1vWWpCVGFvSThKSWV3?=
 =?utf-8?B?M3haYlVOSUFlOW1xeVhHc2FycVM3QUxXTkltWW5WY2wwYmFxTm1wY3VOc0wr?=
 =?utf-8?B?SEkyeHNRVWlPbjNLcENRdW5sM3BFanpRMHdrUXdTMWZ2RCtGb1pRcUJFY2RS?=
 =?utf-8?B?ZjdXMjhydEthZnlyVHVzaERNaUJZem5tQlYyVHRpdTJsTnlkN2Q2eXlTbmd1?=
 =?utf-8?B?VVRMYXlMS0JXQmxYMDdvTVFYNmNjY3g3a1kzdlJ0S0plYTVlaFg1TC9BTi9y?=
 =?utf-8?B?MmZPeDFRMDFUdkIzQjNGUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndYemdHY0dvZkVLVGxyTWpxSm1GaGZvS2NKb0VRWjZrNzdpQm5xT29NVUdN?=
 =?utf-8?B?c3FLSnlhSGlQRGtqQ0hnUHdTTDdoTTk4UzEyb0xlYlZlM200K0FIUFJtVGtm?=
 =?utf-8?B?b3Q4UDh3OWdiYWZVUnBSbnNob0YwakUyU1h0cVRpZTQrWWcvRTQ5TVpsY0ZM?=
 =?utf-8?B?OFdGWnZjZ2pNd2EzRWJPejlxbThrd0dxcTlJMnYzaXBWNmRzbW1Hak1EcDY3?=
 =?utf-8?B?TVBRb255STE3bFJBNVhoN0srNUtmV3l0RG1YUnpxbWNHaEhoR3NDZDFyMk5q?=
 =?utf-8?B?dHluMS82V3h5a1c4aU5UV2RWZnA1b0pSQmlUY3VhVkRuTmVoMGluUGRKVDky?=
 =?utf-8?B?RXZtWTRqWVF1cVh0VVI0c2NXcENIUVl4ZVZwZ3M2RUsrd2JqRnpaM0xzNjk2?=
 =?utf-8?B?L3FLYWszSXNkakRqS3IxWVBzOXJKRnJkbkN1eXdwbXpHZWdva0hSR0FQa1BO?=
 =?utf-8?B?bnRxeFpMVUlFUXlVYlJIMkdrWFZVSUpZN2lUaTJpTzRkeldlNUloWGx6eXho?=
 =?utf-8?B?YTJsMjlscTJjMi9vZHphYU5RVnUyOGVpQjFDMC8zbFpNMmdGOWwwLzRIU2Rp?=
 =?utf-8?B?OU5rb2NoaVFUbHVwcTVGa2pOWXJCeHZBQlVHc1JWTWIwZVd2RDVGL2JEbkU4?=
 =?utf-8?B?bW1TeDBWbUE1a2lVN283VEt0QzMydTJoZE1pWkdFVmZNalFhbFcxUTBlNHNa?=
 =?utf-8?B?KzU4SGxPMGlUUi9UbG9LdE45dlpqNzhoVkQ2L2R0TjhmZ1lVMHpiMTk4MGFr?=
 =?utf-8?B?eDM2OFBwTy9lZ0hOUGxrWm9XTzRpWUZJSHRPTDN0WmUvOTZteXhVT292Z1RQ?=
 =?utf-8?B?am43Rlh0ZzhQZlZwV2treTJBY21seWlQNTdFNE1WaDBRMjNyYVZnV3p2VHFL?=
 =?utf-8?B?VUVXUGZyU3R3cDJqZnoyNE5md2NvemNCWXFaaUpsWHhidkszRGVYNm4xSGtU?=
 =?utf-8?B?RHlpbGpGOE5oSEowQmZTWU9NckowbzhuMnJ2aWZ0L2tVbXc2K1NrblFvZFZY?=
 =?utf-8?B?YkFMdk0vODZJSllxc3RwWTZFQnYxZVJkazVKaFZKai9QQ0JEZDZKZWs1RzRa?=
 =?utf-8?B?VGV0eGhLTmtEeCtXNDIvVlo3LzJZQmJrYTZIMEtPU2lzakZBakdmaS9YUXRN?=
 =?utf-8?B?eHozOElnQmpNMGdkR1MrRXZQQld4U2NnNWs2SVZHeDE0SkFNQVc5c1hyaXZQ?=
 =?utf-8?B?WUdjWHJ1UzA0TWVEWVpjTm53MlQwajVoZjlnTFZobU9jakRvQmRCU0dmU3NQ?=
 =?utf-8?B?VHVFSnlKaVZJSmpqeEEyTkVtdDRvMFh6eVR5bk1LQWdMS3o0Ti9RbytzNDE5?=
 =?utf-8?B?cktZTGgxSXZsQjdqcGV5MkNyOTZxVDRJZEN6OFZiS3JBK1h2bW9KUmFhdmhW?=
 =?utf-8?B?MFZ5RkpIem0vTERVUnZseFBUMFpleVNZSGJ2RVpuWlh5N0tFejVOY1V0bE9t?=
 =?utf-8?B?aDh5eXVHSjNTajErY2RJNmVwYjFhdEZ6SkJWZk93b09pWEkvU2laOHBXQThC?=
 =?utf-8?B?R0NvMU41U20zTzA4S1NENy9GNVBVekNGLzlsdEt1RjBYaStGbzVPbno0UTFM?=
 =?utf-8?B?RUtyTWpOUXBFMXhJZFhrejlrOGFFSW9yQ0ljMWtwNTIzNEpwZlhGblNZenEr?=
 =?utf-8?B?N0xMMi8xUVlFNDk0cmZqUWoySUtnYm1EZzg5V2hsSkNsZUtsVHJTdUtxR01B?=
 =?utf-8?B?ek1NZDFBWkRYN3lHd0lWTkU0QThXanIxT1lLWUltLzZtOTZ0MGtTdFlvL3JI?=
 =?utf-8?B?eklmMDZZbnB1SXhFTmw5MTBCOEZTZlRzV1pnL0NaSHN5OVR3bnNIbER5Sktr?=
 =?utf-8?B?M3Q1TUV2Mm95QkNCLzhoS21hTE51SjVpeVp0VTJic3c5K21ydkk2Z3h6U0RI?=
 =?utf-8?B?SFpDdkdwQlo2ZHZWOUNkK05pdnIvVFE0bWdVb216ait3VFJQR01oOWl1czZW?=
 =?utf-8?B?UUVsQkROejhUWmFlOHplM2tKQXUxc1Y4b1owRUFQNWN1MkNUSS9SZDJXWGVT?=
 =?utf-8?B?S0pSekVDOFlSK1llblhibm5CeVhKenk2NmhCTTJwaWdSRU1ZQW16ZnhSeTZC?=
 =?utf-8?B?bnNzMVk4QUNGaityV2RUZ1UzZXRaaUtiT3d3VEVEUTdwMm1pUjJ5V1M2eWkv?=
 =?utf-8?Q?Md2hpeCoQUF8nGbpqJHNKxNK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7cebc2-0af0-48f8-c01b-08dcd22da273
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 06:47:42.2472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfiFYlLp7BMFqrD1SoWrdPpTPCvTnWpl7Dh0YRU7LQFZtGQ7Mctka2AJHo4fpGxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

--------------TKaTZ0oRYyic3TXb67rFfHDB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.09.24 um 19:40 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> Ok that looks extremely ugly. Please just add a separate function and call that
>> from the TTM move function.
> Should I still remove the adev argument? It is never used and causes a few call sites having to find an adev unnecessarily.

When you have time then yes, but please make that a separate patch.

>> Please either drop that or compare each memory stat variable separately.
>> Byte by byte compares are really frowned upon.
> I think it's probably a good idea to check for zero here, otherwise there's no way for us to know if accounting have some bug in it. I'll change it to check each field separately (maybe break it out into a small helper so it's out of the way?)

If all fields are u64 you could do something like having an union with 
fields and a dynamic sized array (e.g. u64 array[]), this way you can go 
over all the fields without naming them explicitly.

And yes separate function is probably a good idea.

Christian.

>
> Teddy

--------------TKaTZ0oRYyic3TXb67rFfHDB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 10.09.24 um 19:40 schrieb Li, Yunxiang (Teddy):<br>
    <blockquote type="cite" cite="mid:SA1PR12MB8599EF01801E282D63C16754ED9A2@SA1PR12MB8599.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[Public]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Ok that looks extremely ugly. Please just add a separate function and call that
from the TTM move function.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Should I still remove the adev argument? It is never used and causes a few call sites having to find an adev unnecessarily.</pre>
    </blockquote>
    <br>
    When you have time then yes, but please make that a separate patch.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:SA1PR12MB8599EF01801E282D63C16754ED9A2@SA1PR12MB8599.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Please either drop that or compare each memory stat variable separately.
Byte by byte compares are really frowned upon.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think it's probably a good idea to check for zero here, otherwise there's no way for us to know if accounting have some bug in it. I'll change it to check each field separately (maybe break it out into a small helper so it's out of the way?)</pre>
    </blockquote>
    <br>
    If all fields are u64 you could do something like having an union
    with fields and a dynamic sized array (e.g. u64 array[]), this way
    you can go over all the fields without naming them explicitly.<br>
    <br>
    And yes separate function is probably a good idea.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:SA1PR12MB8599EF01801E282D63C16754ED9A2@SA1PR12MB8599.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Teddy
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------TKaTZ0oRYyic3TXb67rFfHDB--
