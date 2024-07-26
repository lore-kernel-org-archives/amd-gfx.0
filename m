Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F7C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 14:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A1010E086;
	Fri, 26 Jul 2024 14:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnsKfSsB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ADC310E367
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 14:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY8eW8RbzsyMIZdcYCWaGLAEKHsdPaJtkS3nfdlxkSat0eBPxoWFE1JbL/i8xDYhwnGrwIPq0E0EDiG06iEtzoIzQMbXRry91sCI09p3TxWWzm+sTwKVzRgKMaP8u0SYrLTioudBc7uTBz9jwuCdJMH+gCNXje6VBrYjlVVDCGuK/ErRX4dyC8qgqorI5zWUaa5GVhb5JcbsjBStlKiOZLpb8KMtOQ0mlZOSyMTAZVVr3s8gkVt5GqWU9wi4MZ+LZ224X7YqiuCS0Tyct+BLnwvIaXwSy1+IU9msI6u5zQCGk44NPznJEsPIboZ2kKivlbwuwu96Cshh8C+4jGpWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU8BZGeiPwYfw4pJYOZd/ePgln8a5SsPiM2NK5Oqq7A=;
 b=u43PQhZ92OpFvjwcP73zdMEQorlkLu1yuQ6Dj+T5xwIfQrvGRDv82X/l0tP/8SN7R4hj78fII5RDPmCQbT9FisxccL+WQXdbvCC9tvUKouIyBiZVmFk8wqZCyy/vViGJnNSdBrJN8gErnJhh2S5pKKpPv4szuMMfZ/4wkxvZzLakAI9/Tv+8sbZaJkz4WxTrix2tVEkMafx1ndlkfzIwUTeisIBcUn3tNX3/u5/H/4Z44CKDSzqgvhD0itizi56l+3dp3uyQkn06HQkoauh2i3btIRmO7N1oncj4TLmcy0RlgtAupO/uCFWvqoyRL79PZkD25OyQBAfBYQdQHt0whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU8BZGeiPwYfw4pJYOZd/ePgln8a5SsPiM2NK5Oqq7A=;
 b=wnsKfSsBzaVmcro6KFodziW0JNQ0EHOURRuvPPf4T/D3nGCeb20VvZUaTlAkJlyJJqPz7EjmTyeuwPjL7Yp1Zg+eWGuD2aeATD5gLWZMfoJndF/F+e3X+sS2LhRNRzFsIpXz9SH0GFNqAbOv0jhvo1Va3vRr9BswplJ4Zwix9co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 14:41:50 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:41:50 +0000
Content-Type: multipart/alternative;
 boundary="------------FpOtFbBvS4P5fCPtWB5dQod0"
Message-ID: <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
Date: Fri, 26 Jul 2024 20:11:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
In-Reply-To: <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
X-ClientProxiedBy: MA0PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::6) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e58cb16-1de6-4be6-17cd-08dcad811522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3dVcWdhbDdyZ1ZEQ1J4SGRIZ2VPMHBHLzJ2K1RlTjNlVXhTKzhUM21kMU5M?=
 =?utf-8?B?bk5xU2hjd0RmdTJQanVyTWIzckQxTFcrY29GZnhId2VDMlc2WE4veEQxSzlN?=
 =?utf-8?B?S1QwcU90Uk5jdDZCbXcvazluVUlUZlpHbGxQOG5zNXVNUjBqWXlFbjY5dlhM?=
 =?utf-8?B?elZCOG9vd0g0K2h4ZFNkU3JwdHRiWXZwYWRmRzh0ckF5RWRmeHB1bGxvRTQz?=
 =?utf-8?B?YTJNMHZWVHZEZjBHK1FVNnpac254bG1sLy9NWHBHcC9JSjNUVndCSUo5bWt4?=
 =?utf-8?B?dnVLbXNhNmZ2ZS9QR1BmZG1yN0NSTG82VE5uV1FFeHdSQkJnSjkvQ0hCRzl1?=
 =?utf-8?B?WGlSQ0ZEQSs3SDdZb01EenAvYmtBTVRka1JVUVQrTllyOVJPZXE3RHZnbHEy?=
 =?utf-8?B?eDBacndxeW5XbjJnYk5uMGNiNExYM2NDMWZDM3FHSG5oTTZ1MVRMMHVOalR1?=
 =?utf-8?B?WjZGRVM1MldtZHA4TS9qREJpYThqTWpreEY3VG9RRDY2MHUvR2VubkJ3SmJs?=
 =?utf-8?B?WHJyV1FBYmx1cUtHbUY1YUR3cHZFQ3Jlb2F0UTU3bXd1VnJJenQzZnVPL1B0?=
 =?utf-8?B?KzlzM0ozZVQxZnZheGlxVFptb2cvcDhwVzUxbEF5dlNVVWFCR0daelY0WXFG?=
 =?utf-8?B?SFBLUDR4eWNZdkgrOEFYU1pGdmdHRy8yMnkzeHBRVStUZlM4RTArdlR2NDVW?=
 =?utf-8?B?ZFg1MWsvQmE2VExYT2NpRStwWVZ4cURqd21mdUMwaGx6dnZ6S1VGWVJ0bjgr?=
 =?utf-8?B?djZGbzFIajRmd1psQUR2WlpBYTR4bGJERDJOQzBVRFFSZDRpaVE3UDMrZ3RZ?=
 =?utf-8?B?SjBtSzE5cEgzamRuVHJWWDd2Mmk1TlFncU04Nm9zMWdiR0R0NnNyRG9yL1BB?=
 =?utf-8?B?L0c1Rm9HeVBQcGx1MHZNUXBXaE51TVRpbWNNcHRPUG8vUFRiTmxWR0lwR085?=
 =?utf-8?B?WW9UajMzTENUZ3ZnYUhBalNRdGpJd1pTam11RzBUSG41SVFwQ3JudFRFdDc2?=
 =?utf-8?B?Rys3QklOSlI4RXpsWXpnOFo3d1Q0MzRhTUVyMVRNekk2QllXMkhKTjlicVZZ?=
 =?utf-8?B?WkkxdW9SVG5jOTh0VDB0dTVEdUZwR0tBQVYzUWRNaDlzZ2MxTi9aWjF6R3JN?=
 =?utf-8?B?eTBxZjFsUERJZ0dlSm9ZRU5FMTNPNmFNRGpGdmdrcmIwWERTdlEvRzQxMUZh?=
 =?utf-8?B?NHVEODRvL1h5SnNTcXZ5N2RlTitFQks0bUhkYjFqTU8wc25rSXB3clFjaTdu?=
 =?utf-8?B?YzlsMi90NTlvVlFjQkUrTUtHbFR4T3dVdzBtdldPbVhlQW1pWTBFNzhTbldn?=
 =?utf-8?B?RkEzWXBJODAwVTFSWkFNelU0T3pkZFM5MmRPZk1naHRrb3pwQWZiamgyRnpv?=
 =?utf-8?B?cW5SYVFrMktIVlJaSkVHTWJLZkhzL1pHZzZwdlhibWJJWWFMT3FlWWl6S1ph?=
 =?utf-8?B?aUFyakk1M2N6T2tZTVA5VFRldkRuUTlIdkNtYkpOQkJ3bm9SK251VlFKc1hQ?=
 =?utf-8?B?TmlGYUVvQ1J5VFlFVVE3Y2Mxd3k1MjAybHBOaXZMOVluTUxMUjUzN3NZemlF?=
 =?utf-8?B?YU1FQlZhTGZyOTlRUnR3YU5pN2oyVnVGY1JObXpDZWpQUWhpZWU5UEpkR25y?=
 =?utf-8?B?ZE82djExWHpscUlsUDVreXlUc25YUDZjaVI2OWxNSGhOL3FsOXkzTWthZUVM?=
 =?utf-8?B?K0I1azJyOG5HT2tlcCtISUQ1UzVoNXQ4RXcwbU1CMnFHZW9DWTVSVm5GdUNl?=
 =?utf-8?B?M3plNXQzcVBINVVGczg4M21DVU45bzZHTHZKRVM0UVMvcU5GLzFibTF5Mmlw?=
 =?utf-8?B?Y1RvNEpEc09odnkxQ2lIQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kytib1pZT1cvWUJWanZDTnM5dW5peE1HS2p1RHJ3TkF0R0lJQ0JBRWx2N0da?=
 =?utf-8?B?ekVjYlIrYnNwTzNtWmlnM2lVRGNuSVRBMkh2VkRRY0xqcVQ4dXhiOWxMMGh5?=
 =?utf-8?B?WGJZei9mSG40MHdnOHdXTWduR09DZWZ2ZklJVFlQalRmK0NNZXl1YmdUbjE1?=
 =?utf-8?B?eHQrbGNOSUFPa0YzSzNqb2FTZm1PY254cFlQbXAxOWN5RVUzSWgweGFud2pE?=
 =?utf-8?B?clFOQndPbkVSVGJUZUtsYzBSOTllalNJWm5nOE5VU0dlOXZxdzU4SUdEdHNp?=
 =?utf-8?B?a1V6SFYvM1JPcjdWb1NMa2dUdnhJWXUwckxPTGMvSkdvemNudC83L2UrYVFx?=
 =?utf-8?B?czNoa2pUSlkwb2R1Z3YrL0tCR1VqbTA0b3ZVaXdkSkEvNFdEZ3VESHdvc29z?=
 =?utf-8?B?UW1ScVcrMXJXNGR6YVFBMGthQnV5SDMwYXYrQit2TWxTQWtMR2w5TnVCTmcr?=
 =?utf-8?B?SjAyVkZXaXRjaDJ4VVgzdzJaZUdpNWxoV2FVUFFrSTZBYkFNTE5sU21Mb1g5?=
 =?utf-8?B?L0QxY01TcDhibTlZMjdFYjZVNkMzVFo2TXVVbG8wWDVBZHJzTk9NSUhGd01K?=
 =?utf-8?B?S2pBenZHWVRMT1RWZ3VSZ0htVk54Y01TNkdQQWhja1EwVWNQcW1ic3d4ejZ6?=
 =?utf-8?B?R0pLdWRTQUZ5dFllTFB1NHNtMWg5UHJwN3J6WUhUYkYwNmhkcXVZZHc3WThp?=
 =?utf-8?B?RkFUNFBqWUhRdTVqbWpFamhaVFNLYlVXWWcwZ0RpQXhSd0xhYkZTQ0JTUW9X?=
 =?utf-8?B?RjZUcjBYTnZXZVZOTDd0eWhEVXpnWHBVWE1sK1ZEb3duVWh6RnpabW01SHd5?=
 =?utf-8?B?aEZ3WU5lWkxpV1N5eGl4NTJSWXZGMWQrOFVjZmpaZ0o1RnFFVWh2ZWk4TC9I?=
 =?utf-8?B?UHdVRnFDaTdvNzhKZ24zdjJzbXdKeUJMNC83YjVpdm5jdkozV2hsMnh5UE8z?=
 =?utf-8?B?Ui9DQ1VnR2VUZGRsWXdCZHVRMDhJU2wxaDJQRU84SzRUaUJ0U0UvTk16YWZJ?=
 =?utf-8?B?aEptSEprbGVLckVnNFNzUEhtcFhBSVhnSWlpV0k1eFE3UE8vZlphYVVIU0F0?=
 =?utf-8?B?WjdJdTdNUDY1QTM2cnVzK1AzeWlsanMxdDE2dGc5V0pCRHVSWE1rNm15eDdC?=
 =?utf-8?B?RUMvcXF1eTJ1ZGF3V2Z0cDlPR2pCL3ZqNUFrME9EeGtoTE4rdE0rL3VDSjR5?=
 =?utf-8?B?QzZvaVYvU1RTWWsyTGpxV3VTeWFXMDlYUVVTK2JTWDc1NzJHSkdoQ3FPK0lj?=
 =?utf-8?B?RHc3Z2dZTmJzUE5uYVl4MGNZcGlySTZhVHRlRGRTR3RXaldNblpnVEhVVzd2?=
 =?utf-8?B?YkErSWhvSGx3d042cVBGc0k3WGRrSStnQ3pVYklYYTA3RUo1L3YwNU9uK2Na?=
 =?utf-8?B?TDhMd0tMZ2FtS2o5Y1dRNkdTcjlXR1E2VHk4dVUxUCsxVTNjNnBhWjFGL2J0?=
 =?utf-8?B?N29Cd0R5K0p1bzY4K0s5SzRsd21qeHBHSk9udFd0dnNRT0RnN0dsZzc5dGh3?=
 =?utf-8?B?NmdiNHBROGswVE8rTWh6d3hoRXROaVZQbm1URGtxd3RucStFZ01DNC8rbDhZ?=
 =?utf-8?B?MFo1ZVdwenVBbTRaY2V2bnpIMG9VRmJnUE03YVQ4QXV3MUtGTlhRc3BxaEZh?=
 =?utf-8?B?SENDKy9YclB3QWJFMWdMbHNzMWkydlJYaXNYYlZoK08yR1JaUzJwQ05IMGJB?=
 =?utf-8?B?UEpkTitMTTlXSEk5YXMra0k0dEZkTkNvUFp1YW91NmlxN25nL1ZPR2NyWThj?=
 =?utf-8?B?ejB5TnZLOE11WVRiTEdhQTZyb1g0bDl0N3RINU5BbjJrNDNYZnZHRGFLNEJu?=
 =?utf-8?B?dFFXVXZyUTVpRFhHcVB3Q2tHb1JLYkRmUTJlM0Jpa2o1cW5oamV2am96V3RQ?=
 =?utf-8?B?UmVyYkU0RkVSMXN2K09VLzhvNTVOaWhBbWd3MExLOVhwZ0R0UktML1NjZk1u?=
 =?utf-8?B?Z2ptdzdDVFJiS2xHOERkbkgweXoxSU1SRjhTSHdkVXV0T2lNWU5wVS9QMitM?=
 =?utf-8?B?anZkcys4dEZFMUxlUWxwd054TFpldnBMeEt5ZkZML0tMaTFNeGszNTl5dUNq?=
 =?utf-8?B?UDhCTXhzZk13ZXZTTkh5Y2dxaTNMbTlMc2c1dEN6NFhqUE1SZXdkcmhONWN3?=
 =?utf-8?Q?y+PgzHxW7XDwqcI0SL2vkOEi4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e58cb16-1de6-4be6-17cd-08dcad811522
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:41:49.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WA8eGKOy1HqyiA8w366mlKA5R6BR0fWEkIV/yN+vaONru96r2t2MDkggInwGfZxoStKJ/gG5FVpEapsXGzL+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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

--------------FpOtFbBvS4P5fCPtWB5dQod0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>
> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>
>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com> 
>>> wrote:
>>>> Problem:
>>>> IP dump right now is done post suspend of
>>>> all IP's which for some IP's could change power
>>>> state and software state too which we do not want
>>>> to reflect in the dump as it might not be same at
>>>> the time of hang.
>>>>
>>>> Solution:
>>>> IP should be dumped as close to the HW state when
>>>> the GPU was in hung state without trying to reinitialize
>>>> any resource.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 
>>>> +++++++++++-----------
>>>>   1 file changed, 30 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 730dae77570c..74f6f15e73b5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct 
>>>> amdgpu_device *adev)
>>>>          return ret;
>>>>   }
>>>>
>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>> +{
>>>> +       int i;
>>>> +
>>>> + lockdep_assert_held(&adev->reset_domain->sem);
>>>> +
>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>> + RREG32(adev->reset_info.reset_dump_reg_list[i]);
>> A suspend also involves power/clock ungate. When reg dump is moved
>> earlier, I'm not sure if this read works for all. If it's left to
>> individual IP call backs, they could just do the same or better to move
>> these up before a dump.
> Suspend also put the status.hw = false and each IP in their respective 
> suspend state which i feel does change the state of the HW.
> To get the correct snapshot of the GPU register we should not be 
> fiddling with the HW IP at least till we capture the dump and that is 
> the intention behind the change.
>
> Do you think there is a problem in this approach?
>>
>>          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> Adding this does sounds better to enable just before we dump the 
> registers but i am not very sure if ungating would be clean here or 
> not. i Could try quickly adding these two calls just before dump.
>
> All i am worried if it does change some register reflecting the 
> original state of registers at dump.
>
> What u suggest ?
> Regards
> Sunil
I quickly validated on Navi22 by adding below call just before we dump 
registers
if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
amdgpu_reset_reg_dumps(tmp_adev);
dev_info(tmp_adev->dev, "Dumping IP State\n");
     /* Trigger ip dump before we reset the asic */
for(i=0; i<tmp_adev->num_ip_blocks; i++)
if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
                                     (void*)tmp_adev);
dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
}
If this sounds fine with you i am update that. Regards Sunil Khatri
>
>>
>> Thanks,
>> Lijo
>>
>>>> +
>>>> + 
>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>> + adev->reset_info.reset_dump_reg_value[i]);
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>                                   struct amdgpu_reset_context 
>>>> *reset_context)
>>>>   {
>>>>          int i, r = 0;
>>>>          struct amdgpu_job *job = NULL;
>>>> +       struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
>>>>          bool need_full_reset =
>>>>                  test_bit(AMDGPU_NEED_FULL_RESET, 
>>>> &reset_context->flags);
>>>>
>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct 
>>>> amdgpu_device *adev,
>>>>                          }
>>>>                  }
>>>>
>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP, 
>>>> &reset_context->flags)) {
>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>> +
>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>> +                       /* Trigger ip dump before we reset the asic */
>>>> +                       for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>> +                               if 
>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>> + tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>> + (void *)tmp_adev);
>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State 
>>>> Completed\n");
>>>> +               }
>>>> +
>>>>                  if (need_full_reset)
>>>>                          r = amdgpu_device_ip_suspend(adev);
>>>>                  if (need_full_reset)
>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct 
>>>> amdgpu_device *adev,
>>>>          return r;
>>>>   }
>>>>
>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>> -{
>>>> -       int i;
>>>> -
>>>> - lockdep_assert_held(&adev->reset_domain->sem);
>>>> -
>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>> - RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>> -
>>>> - 
>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>> - adev->reset_info.reset_dump_reg_value[i]);
>>>> -       }
>>>> -
>>>> -       return 0;
>>>> -}
>>>> -
>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>                           struct amdgpu_reset_context *reset_context)
>>>>   {
>>>>          struct amdgpu_device *tmp_adev = NULL;
>>>>          bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>          int r = 0;
>>>> -       uint32_t i;
>>>>
>>>>          /* Try reset handler method first */
>>>>          tmp_adev = list_first_entry(device_list_handle, struct 
>>>> amdgpu_device,
>>>>                                      reset_list);
>>>>
>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>> -
>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>> -               /* Trigger ip dump before we reset the asic */
>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>> -                       if 
>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>> - tmp_adev->ip_blocks[i].version->funcs
>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>> -               dev_info(tmp_adev->dev, "Dumping IP State 
>>>> Completed\n");
>>>> -       }
>>>> -
>>>>          reset_context->reset_device_list = device_list_handle;
>>>>          r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>>>          /* If reset handler not implemented, continue; otherwise 
>>>> return */
>>>> -- 
>>>> 2.34.1
>>>>
--------------FpOtFbBvS4P5fCPtWB5dQod0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/26/2024 7:53 PM, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f967ce91-dd88-4542-8340-1e61813eb780@amd.com">
      <br>
      On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 7/26/2024 6:42 PM, Alex Deucher wrote:
        <br>
        <blockquote type="cite">On Fri, Jul 26, 2024 at 8:48 AM Sunil
          Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
          <br>
          <blockquote type="cite">Problem:
            <br>
            IP dump right now is done post suspend of
            <br>
            all IP's which for some IP's could change power
            <br>
            state and software state too which we do not want
            <br>
            to reflect in the dump as it might not be same at
            <br>
            the time of hang.
            <br>
            <br>
            Solution:
            <br>
            IP should be dumped as close to the HW state when
            <br>
            the GPU was in hung state without trying to reinitialize
            <br>
            any resource.
            <br>
            <br>
            Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
            <br>
          </blockquote>
          Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
          <br>
          <br>
          <blockquote type="cite">---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
            +++++++++++-----------
            <br>
            &nbsp; 1 file changed, 30 insertions(+), 30 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            index 730dae77570c..74f6f15e73b5 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
            amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
            <br>
            &nbsp; }
            <br>
            <br>
            +static int amdgpu_reset_reg_dumps(struct amdgpu_device
            *adev)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            lockdep_assert_held(&amp;adev-&gt;reset_domain-&gt;sem);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;reset_info.num_regs;
            i++) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_info.reset_dump_reg_value[i]
            =
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            RREG32(adev-&gt;reset_info.reset_dump_reg_list[i]);
            <br>
          </blockquote>
        </blockquote>
        A suspend also involves power/clock ungate. When reg dump is
        moved
        <br>
        earlier, I'm not sure if this read works for all. If it's left
        to
        <br>
        individual IP call backs, they could just do the same or better
        to move
        <br>
        these up before a dump.
        <br>
      </blockquote>
      Suspend also put the status.hw = false and each IP in their
      respective suspend state which i feel does change the state of the
      HW.
      <br>
      To get the correct snapshot of the GPU register we should not be
      fiddling with the HW IP at least till we capture the dump and that
      is the intention behind the change.
      <br>
      <br>
      Do you think there is a problem in this approach?
      <br>
      <blockquote type="cite">
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
        <br>
      </blockquote>
      Adding this does sounds better to enable just before we dump the
      registers but i am not very sure if ungating would be clean here
      or not. i Could try quickly adding these two calls just before
      dump.
      <br>
      <br>
      All i am worried if it does change some register reflecting the
      original state of registers at dump.
      <br>
      <br>
      What u suggest ?
      <br>
      Regards
      <br>
      Sunil
      <br>
    </blockquote>
    I quickly validated on Navi22 by adding below call just before we
    dump registers <br>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #d4d4d4;">!</span><span style="color: #dcdcaa;">test_bit</span><span style="color: #cccccc;">(</span><span style="color: #4fc1ff;">AMDGPU_SKIP_COREDUMP</span><span style="color: #cccccc;">, </span><span style="color: #d4d4d4;">&amp;</span><span style="color: #9cdcfe;">reset_context</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">flags</span><span style="color: #cccccc;">)) {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; </span><span style="color: #dcdcaa;">amdgpu_device_set_pg_state</span><span style="color: #cccccc;">(</span><span sty
 le="color: #9cdcfe;">adev</span><span style="color: #cccccc;">, </span><span style="color: #4fc1ff;">AMD_PG_STATE_UNGATE</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; </span><span style="color: #dcdcaa;">amdgpu_device_set_cg_state</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">adev</span><span style="color: #cccccc;">, </span><span style="color: #4fc1ff;">AMD_CG_STATE_UNGATE</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; </span><span style="color: #dcdcaa;">amdgpu_reset_reg_dumps</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">);</span></div>
<div><span style="color: #cccccc;">&nbsp; &nbsp; </span><span style="color: #dcdcaa;">dev_info</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">dev</span><span style="color: #cccccc;">, </span><span style="color: #ce9178;">&quot;Dumping IP State</span><span style="color: #d7ba7d;">\n</span><span style="color: #ce9178;">&quot;</span><span style="color: #cccccc;">);</span></div><div><span style="color: #6a9955;">&nbsp; &nbsp; /* Trigger ip dump before we reset the asic */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; </span><span style="color: #c586c0;">for</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">i</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">; </span><span style="color: #9cdcfe;">i</sp
 an><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">&lt;</span><span style="color: #cccccc;"> </span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">num_ip_blocks</span><span style="color: #cccccc;">; </span><span style="color: #9cdcfe;">i</span><span style="color: #d4d4d4;">++</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp;  &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">ip_blocks</span><span style="color: #cccccc;">[</span><span style="color: #9cdcfe;">i</span><span style="color: #cccccc;">].</span><span style="color: #9cdcfe;">version</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">funcs</span><span style="color: #cccccc;">-&gt;</span><span style="
 color: #9cdcfe;">dump_ip_state</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">ip_blocks</span><span style="color: #cccccc;">[</span><span style="color: #9cdcfe;">i</span><span style="color: #cccccc;">].</span><span style="color: #9cdcfe;">version</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">funcs</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">dump_ip_state</span><span style="color: #cccccc;">(</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (</span><span style="color: #569cd6;">void</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">*</span><span style="color: #cccccc;">)</
 span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; </span><span style="color: #dcdcaa;">dev_info</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">tmp_adev</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">dev</span><span style="color: #cccccc;">, </span><span style="color: #ce9178;">&quot;Dumping IP State Completed</span><span style="color: #d7ba7d;">\n</span><span style="color: #ce9178;">&quot;</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">}</span></div><div><span style="color: #cccccc;">
</span></div><div><span style="color: #cccccc;">If this sounds fine with you i am update that.

Regards
Sunil Khatri
</span></div></div>
    <blockquote type="cite" cite="mid:f967ce91-dd88-4542-8340-1e61813eb780@amd.com">
      <br>
      <blockquote type="cite">
        <br>
        Thanks,
        <br>
        Lijo
        <br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite">+
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            trace_amdgpu_reset_reg_dumps(adev-&gt;reset_info.reset_dump_reg_list[i],
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            adev-&gt;reset_info.reset_dump_reg_value[i]);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; int amdgpu_device_pre_asic_reset(struct amdgpu_device
            *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
            amdgpu_reset_context *reset_context)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job = NULL;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =
            reset_context-&gt;reset_req_dev;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset =
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_NEED_FULL_RESET,
            &amp;reset_context-&gt;flags);
            <br>
            <br>
            @@ -5340,6 +5358,18 @@ int
            amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(AMDGPU_SKIP_COREDUMP,
            &amp;reset_context-&gt;flags)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_reg_dumps(tmp_adev);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping
            IP State\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Trigger ip dump before we reset
            the asic */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
            tmp_adev-&gt;num_ip_blocks; i++)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state(
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            (void *)tmp_adev);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping
            IP State Completed\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_full_reset)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_device_ip_suspend(adev);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_full_reset)
            <br>
            @@ -5352,47 +5382,17 @@ int
            amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp; }
            <br>
            <br>
            -static int amdgpu_reset_reg_dumps(struct amdgpu_device
            *adev)
            <br>
            -{
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            lockdep_assert_held(&amp;adev-&gt;reset_domain-&gt;sem);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;reset_info.num_regs;
            i++) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_info.reset_dump_reg_value[i]
            =
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            RREG32(adev-&gt;reset_info.reset_dump_reg_list[i]);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            trace_amdgpu_reset_reg_dumps(adev-&gt;reset_info.reset_dump_reg_list[i],
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            adev-&gt;reset_info.reset_dump_reg_value[i]);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            -}
            <br>
            -
            <br>
            &nbsp; int amdgpu_do_asic_reset(struct list_head
            *device_list_handle,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context
            *reset_context)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev = NULL;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset, skip_hw_reset, vram_lost =
            false;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Try reset handler method first */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev = list_first_entry(device_list_handle,
            struct amdgpu_device,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(AMDGPU_SKIP_COREDUMP,
            &amp;reset_context-&gt;flags)) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_reg_dumps(tmp_adev);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP
            State\n&quot;);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Trigger ip dump before we reset the asic
            */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
            tmp_adev-&gt;num_ip_blocks; i++)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            tmp_adev-&gt;ip_blocks[i].version-&gt;funcs
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dump_ip_state((void
            *)tmp_adev);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP State
            Completed\n&quot;);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context-&gt;reset_device_list =
            device_list_handle;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_reset_perform_reset(tmp_adev,
            reset_context);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If reset handler not implemented, continue;
            otherwise return */
            <br>
            --
            <br>
            2.34.1
            <br>
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------FpOtFbBvS4P5fCPtWB5dQod0--
