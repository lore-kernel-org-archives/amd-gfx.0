Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BF0CCF2F2
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D84B10E1AA;
	Mon, 19 Jan 2026 12:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2a/hvmak";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F7C10E1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG+TVoaSqIP06UNAH7RfHkThLvJxAiHOlcNDWr4FvJmFxkeOdKvijhW+PgXDOUgF92sp/vFI/sWLqiZaQ2YdwNu1v0Rw4xFJzM9Orv4vIuiFNJSOf1YhH5b1lP/p4XmN8Uv0Z4gN9eODNtfrksd9hC95llA9ngvkQxhi1kz4y5oHNsNXWtHnnAydr7awJA6LwQIkd3vICS7BtVYjyEsQcynIZPl48QJFDBtfq+B0Hdx/L2B/it+53gR/H30zIq9ck+ZZCowFCIPwWdlOEJZcKr7+TZo4SKr1Er8Qeuu6rNtHphkZu+DrkKq/0CUKfEduadg+vW3ZXTeC18XkMsSdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+nAPLqbDAzm/ij+dOjK7spCDoyWsDZMsHy2L38sPic=;
 b=qnhTOMafNVmWW7RFpk2+y8F9nsixtrrLDehuBvLKtREd6zfohW+njRDT3yXZGWcB/HfQoj07yMmAEYb6idRc/PAi5y1vdwpBiSay6RfVYIxiTjOnFm6/3dZp/9o1JK7stj2ptPP5xsZSF8QU/pkuOnoYXEMptM888ACYk3LkB/v8vMKl+fgYbu/LTC1d1QZwa8r52cJk708nrfyEc2Zc29pXpTowM/6oXa46XYe/dm5HXNBv6IKl8IMnDP72rZkqHw9NIeW9ztnkiocFVYBcy52Ku82uDAEuiAIqJz3F9dRv3kfhHwQ7zvy2wbuo8Uhh/rJzpkJgdKSIQnCcWUULhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+nAPLqbDAzm/ij+dOjK7spCDoyWsDZMsHy2L38sPic=;
 b=2a/hvmakrvlRpkED6Hp/H++CgfPerO2ZXq44M4IC/jUuIrQhuUsPVPhCsblPZbiwg3uJODsupmm+fjqIQRuOtZ7ocB2VWlkY5Bk0Pz/0+vgptESFB67fGeo6cclQy/ifqrXq6y3v7meOFAe6Rk2RyJQdlbCaxKocmHbWEkrBdIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:27:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:27:08 +0000
Message-ID: <9fc31b01-2d1d-4915-9c10-c140a754fd59@amd.com>
Date: Mon, 19 Jan 2026 13:27:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-4-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4a3be8-0d03-4488-5a84-08de57561019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE5LUEZaTXFQZXZpVmI0ZGh4S25mYnNTTFRkVklZK3VuTlE4anVCUjQxeDlW?=
 =?utf-8?B?RjZGd0xFSmI5YmYxQmhqaDgvYi9MNkVZdnZPbTdMY3NoRWRCNC84Ti8vNkQw?=
 =?utf-8?B?ajFwcUlJQStnaTdjT1g2UUdGUTZhUEhWZ2FwTjlIQnVuYTZBaHorSmY4cFFo?=
 =?utf-8?B?ZGxSbHpMckRCWnZhRGp0eXVxNys2RlVHN1hwbVNzY0xzSUFVemFLZTFremt4?=
 =?utf-8?B?VFhkSFJWbUJVUU1iRGFKNklicmpDZ1cveWk2YlYxTkZ4bE5iMUJPdVNvUGRW?=
 =?utf-8?B?UkIzelFuSVRZZnlvMzh0Y01WelpaTkRKZ3pVdVMvL0xNZVdhdEs5Ry8wNUJa?=
 =?utf-8?B?Y2F0TytMYzEzaGthMEJ4akZPMldTL2ZMR3ErWlFMYnJVSjNNUHFyQ3NEby93?=
 =?utf-8?B?Q2Y2RmFTbzZDSVV0dFhkaFBmU3BmUnpYdUg2M3Q0QmRONTJQL21YUE1iY0Vm?=
 =?utf-8?B?NHgzdjdubEJvbm1FTytPaHI2VzQ2VWJzNHdtcnQzVWFnWDVYYWswSURWcU1M?=
 =?utf-8?B?QmRWdDI4ZDNldW1yTWJMdVo4aGFkMk9Kb01lZ0xxWVZlRzBFdndCT3NBQ2RL?=
 =?utf-8?B?Z09jWGVEUGYzVUtmL3hsdml3clo3bmFseG5zYVgwTDFGeXVvaS9HUUM5OXJv?=
 =?utf-8?B?QVg1YzJuKzhMczd6V3lvdUZqSWwyVS9zbGgzVkcwN0lzVURnOURNLzRUdEU3?=
 =?utf-8?B?WnZOUHlOUGNDZ3RjaXlFTkViMUdUandvVEpuOVZRaUU3WUFieHNUZER2WXJu?=
 =?utf-8?B?bDlwTlgrQVQ1QUMwUWhWMCtQSUVGU1NWb3h5Y0tSQTJpZWcrcmZSbXNoeXZI?=
 =?utf-8?B?Y2JNb3MyM1lCaVVYaDN1dm5tZHFISkZEL1ZJRHplbHB6TDRlNG1xT2JhODVE?=
 =?utf-8?B?cHZVOXRYYmJ3QS82TGJwVkIzd3cvQ2x6UEhtWThESDBMUmtkK3BLU1AvOTJj?=
 =?utf-8?B?MzJIbk1mYXR0cENLRGh1MHExbnJucUY0UnlHQWRVeEI1ajloUStNWXJDNTRh?=
 =?utf-8?B?UkowcjZCSHIxK1J5WFFKWFVSSC9iRlQ1c24wLzE3Nm1QWUUzMTNxQUE0d1Yy?=
 =?utf-8?B?Z1NnREtDdTUxQzRGdWJGNGRmMW8venN6enNtc1BjbTdKY01iVTZRb0RQWVB5?=
 =?utf-8?B?YUI2MU91bDN2OVA2dTNyVHVwUldKYXhPK2xWN0RxaFJ4MloyQmlqVDJDY3BG?=
 =?utf-8?B?VjRPSUZTSnFTUEtla2x5K29TbkZFdjEwdmhHWURnQitDYXdWOUZXU2dINzdD?=
 =?utf-8?B?RjFVRUdOMXg2V25mbXFrWDVPUEZsNFVrSHF6LzV6VGFreHh4OHB4YlF0WmRF?=
 =?utf-8?B?M2RHeCtCWlM1aXNwOStZaXJRRUFJRXM2UzUrS1d2MzNzNkFqNGVwZDhXbm9y?=
 =?utf-8?B?d2NsTVZiMndybHQ0NENPU2Z5Z01SY1hhODRBR21kL1FrUThTdDREbE93SG1E?=
 =?utf-8?B?eTBHOG00d3NtQ3FRcTY0UVFPL0VOOFRiUGliV05kS0hGM2VwK3ptLzhlRVQ5?=
 =?utf-8?B?bWxKb3UyRkxWWnZMaUQ3M25KVGJSYk01cTZWdXFRWUJ3Y1NHd1JWYXUraUFZ?=
 =?utf-8?B?RG9iTUs0R3hGSU42TjhWUldqbUxvN2QrdytoME9TWWwzMUw4a2J5aXBjeWl5?=
 =?utf-8?B?a0RCdytHWEFwU01zczY1djN0cUhGSWxNOTJyemo3TytCQTZrMWpONTNmMGpv?=
 =?utf-8?B?Wmx6T2o2b1RvelprTnNnb0ZYV0YraW45VXpSRGR2dUdmTXl6cVgxTUxRcjcz?=
 =?utf-8?B?Sk9mTlRERUswSEx6ekZKYUNhZGlseTJVQkxlVFpGeVJ4Zm9ObXp1NzVPM0Nx?=
 =?utf-8?B?eGpMMFUxNVArZW5pc3piL3ZZRHorQXZXVlNFcFZMTW9PWlNlN28va1NRUDFD?=
 =?utf-8?B?ODZ2aGFYMVpmQW1QSnFkMFFXdjZEU1VEeVhBNEYwOWNJTnhtZFBPSHd3MC84?=
 =?utf-8?B?ajU2bHZUY1VQNlVRb2NnZXFQQUx2dmoyRnNDSHR2RENYNFduVzNJV0s3VFdL?=
 =?utf-8?B?SkF4VGg0NVhrMTZmT3dSanI5ZUlNRFVOdE9IZGVaY3lSNkpnTUd3SGFsRDFj?=
 =?utf-8?B?YVF3MG95Z0d6NWg5ZTRwa2YvejlTMWlKbm14N1lwYThQei9QaktCZENweGxk?=
 =?utf-8?Q?oWwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My80NDltNjQrQ05aalRkS1pzWWh1UFNxbGZnSVlHQWd0YXQ3c0lGcEZUbVRv?=
 =?utf-8?B?SzA0ZXFPVmpNcjErWkw3S3owN2tGUW5ZWHV5eWpqSTAyQmJDSmhlaFUxS0Vm?=
 =?utf-8?B?L1FyeVFLb3pJdXYwUDh0TkJzOGxnWWE4OWRhalRZa2plSUpncUJFZVp2a3Nm?=
 =?utf-8?B?ZHg2RW1CTzk3ZVFzTzBrQStpTHhacFg1TkdSd2NrS0dvYXRGaXlFQmpFUjNa?=
 =?utf-8?B?bTY1TUFxVGhxdEs0SXpRbVZFVlhCcjFuMnZLMnVkRHJ1TUdMQU5pZlJKendy?=
 =?utf-8?B?SjJocy9wVERHK1lFMkgyKzlaTDJCc0l3SDJEU1B4Uk95WjczMGVoQzRaTUo0?=
 =?utf-8?B?b0M5MnEyelRESWE1VUcvOGpQdWxtRnVGSWhmRE5LWm9oNkQ1VmNUY25UTnFo?=
 =?utf-8?B?aGhsTldDTGU0TnkwTTJTYlBlZnRtdzRmSTY0bGltalZYNHVINThUL2ZBQUtk?=
 =?utf-8?B?bmI1Z2ZDR0U5VWNaRTRQWDlPTFc5VGdHMnc0NDhoS3M0S2hjWWorU0J4VG9F?=
 =?utf-8?B?cm91bzFMdGdJRm4xclc3WVZQWDRGZVBYU2FlazhzSGZEeHVhdmJjQ1BsZ1Vz?=
 =?utf-8?B?SEk3WkFjU2puOG9NTDlLa0lVbFhZV1lrYWdHTUZsa29WQVlOUXd2b0V2RVRQ?=
 =?utf-8?B?bU5wMkhJMnN0eTArcG5rQ25QVnJsWUFCM3NLWEVVVUx1OVVHNy8yY25hbTlQ?=
 =?utf-8?B?QmpiZFUxaXN3SjlKU3hOMkFMR1pmQ00vaEFmSi8zenlTVkZtK2tKRUxxZGgy?=
 =?utf-8?B?QWRMVTB5T1NFbTloTHBRMUEzQm85dGNJVzV5NWpqZjBvS1VoeURkNG8zY0FJ?=
 =?utf-8?B?b3YxV2d0UHNLb0NBbHNja2lRZXZyRU9tc05aSkNhR0oxenJyOWd4UHFsZVc0?=
 =?utf-8?B?VVlQeC8rMENvb2NHc3MvWjNmbkRmYmRhTVZRdmZjY0hmaElHKzRqSFRRWm00?=
 =?utf-8?B?Z3hMVDI1TjhqbWJ3YkgzczYvT1I5VnVEcjVydFBWWWpManFWOGdXUG5URWJx?=
 =?utf-8?B?UHRjbVhtQ1oyKzBJWk5CYjdCb3RXMWNjWmxnS2UvTWNGS0JBbG0vUDRaREox?=
 =?utf-8?B?cnZ1NFB1UkxKb3pGSy9xZXE3TmZrdmlXVG5nd2FrNXlnRGlKRFZXUjlkNHlF?=
 =?utf-8?B?MHBMdStKWEtIUnorUTdZSitBKyttejVtVlE4WEdwcnBaSVJnc3BldGlPVUZK?=
 =?utf-8?B?ME1Wb25kZE5EQWxKVFhveHlCcnJFR3VKb2FMUmpuU1F1VUh5Yk1DdmZ0ZGZD?=
 =?utf-8?B?U2xuV0FOVkJIWTBzWCt6WXBFUkRoek5COUFSV1pvektXYkdkb1ZrU2RiWmlH?=
 =?utf-8?B?VldwdkkwL2VSeGVERnMrV2wxRjI1dkxndGxIQzFjczJxbCt3Q2hJV1hIUWtr?=
 =?utf-8?B?ckd2QVJWUER6TGYySzNLU1JVQVhYRVRUalVtMklLbXhXTC9RRUwwSklralR0?=
 =?utf-8?B?VFJqb214NGVqY2tCQ1VHb3AyOW1zVVYrZXV4THRSdDBtck5CdjRXWnFIa0s4?=
 =?utf-8?B?WVRnQSt6TzVER05MU0RYcEFvMGRPUmFHS1NUTHdjQXpEQnc3SVVuOUlWeEZ4?=
 =?utf-8?B?RmczbFFvTHREbjJERG5QbFdFNjhpbGlUb1duQ1hWNnErWFlnTVJsellKSFVh?=
 =?utf-8?B?azVndVJrN09kazVVeUpBN3pITHovZXBlbVdmWEtyQnJXeFZTN3dQUEpseXBz?=
 =?utf-8?B?T1lPK25VQlkzZWZGeDNNODVPLzl4K09rcjhNRWg3OHMvcTVnTnZ3eTJlNDNM?=
 =?utf-8?B?NE1RbUtPRElCTzV3RWpPTnRCWm1Td3lLemY3ZG14cG41Y2F2QkRsUEVSWm1h?=
 =?utf-8?B?cVRyUHZQb3QwdVJHbW15Y3B3K3Awem82eGtsVWZadjBGdGp5eFdITkNPdkVh?=
 =?utf-8?B?SThTU2p5TGEram1FWUxDMGVwSWFYczJLenhxdGp1dlBhQjdIR0RjOHFVTFZW?=
 =?utf-8?B?Yi9CVHdDKzhleGozYi9ESEtyNVl6WXpZODBLeDEwbU5LUFNycmZQSCtBcVVk?=
 =?utf-8?B?TWd5VFhBa0hGTTRHazkrL3EwT2V2ZG9zWW91SHBCZ2FscklVekI0VERRZ0pa?=
 =?utf-8?B?SEsxc0J1blpyWCtsekVxK2x4YU5KeUNmd2d0MjFUK0Vzdk5wLzF3c3Q2bDBT?=
 =?utf-8?B?UGxUVktiTHI0SndlalpYenZHWTdvL3YxcXFlV3lHOXR5ZkNyTENQVnEydnpG?=
 =?utf-8?B?MHFrbHptZXRBb1ZzbUVLTmwwS2VMWXd0VHVUV2xWeUsxMGl0Uk5HQ0cwT0Zz?=
 =?utf-8?B?K2xyUi9Dc3JBZE1DUXJVbTU4SmcycnU2VDdvazF2ODB4eVpWYWNmMDBXQmlN?=
 =?utf-8?Q?K5aj51tn5AnozIO596?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4a3be8-0d03-4488-5a84-08de57561019
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:27:08.5534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvB7nUjvSLvezpB+Le1m9P7RIYuOoI/CHcYoiy+JnNQ5I1iVtvh/XW8xJf1J8XG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

On 1/16/26 17:20, Alex Deucher wrote:
> If we need to allocate a job during GPU reset, use
> GFP_ATOMIC rather than GFP_KERNEL.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 9 ++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c     | 6 ++++--
>  4 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 72ec455fa932c..136e50de712a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -68,7 +68,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	int r;
>  
>  	if (size) {
> -		r = amdgpu_sa_bo_new(&adev->ib_pools[pool_type],
> +		r = amdgpu_sa_bo_new(adev, &adev->ib_pools[pool_type],
>  				     &ib->sa_bo, size);
>  		if (r) {
>  			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 1daa9145b217e..c7e4d79b9f61d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -192,18 +192,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (num_ibs == 0)
>  		return -EINVAL;
>  
> -	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
> +	*job = kzalloc(struct_size(*job, ibs, num_ibs),
> +		       amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);

That's an extremely bad idea, amdgpu_in_reset() returns true even outside of the reset thread.

We really need to look at the pool type.

Regards,
Christian.

>  	if (!*job)
>  		return -ENOMEM;
>  
> -	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	af = kzalloc(sizeof(struct amdgpu_fence),
> +		     amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
>  	if (!af) {
>  		r = -ENOMEM;
>  		goto err_job;
>  	}
>  	(*job)->hw_fence = af;
>  
> -	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	af = kzalloc(sizeof(struct amdgpu_fence),
> +		     amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
>  	if (!af) {
>  		r = -ENOMEM;
>  		goto err_fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 912c9afaf9e11..7ee0cc46b4608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -339,7 +339,8 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
>  				      struct amdgpu_sa_manager *sa_manager);
>  int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
>  				      struct amdgpu_sa_manager *sa_manager);
> -int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> +int amdgpu_sa_bo_new(struct amdgpu_device *adev,
> +		     struct amdgpu_sa_manager *sa_manager,
>  		     struct drm_suballoc **sa_bo,
>  		     unsigned int size);
>  void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> index 39070b2a4c04f..fc13969f8ef49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> @@ -76,12 +76,14 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
>  	amdgpu_bo_free_kernel(&sa_manager->bo, &sa_manager->gpu_addr, &sa_manager->cpu_ptr);
>  }
>  
> -int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> +int amdgpu_sa_bo_new(struct amdgpu_device *adev,
> +		     struct amdgpu_sa_manager *sa_manager,
>  		     struct drm_suballoc **sa_bo,
>  		     unsigned int size)
>  {
>  	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
> -						   GFP_KERNEL, false, 0);
> +						   amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL,
> +						   false, 0);
>  
>  	if (IS_ERR(sa)) {
>  		*sa_bo = NULL;

