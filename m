Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D25D6ACD4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 09:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65AE10EC70;
	Thu, 18 Dec 2025 09:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LrZ+Q8mO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F0A10EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 09:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHp5U+T3lvf+G8q+LZEZ/pOEpOgjX9ppdwU1kZ0mf5tlJ9pwWTM8/xjYg2NIUtWnRtvHWeQRo0LgQxzr4PHsjx6gkLUSncqaHz29LqcwDLKi+uMY/RSM/4NPcp7VTilSYNbG82cecjGzROuGhOoqXRnuuC2lo8nwno1GvKoUpakl+IBCEbkG9ploURpicoOXJ5mi53j1NaP+7cnbhsYI1vNff+zg+YvT+sKSgBIwhwXG+Vqbhsp3x/H7WkIFcAeCH1nD7s2AzSLsyG+1ZyjpxPsHvnCWF+2uHPBK0XvSW2Cy9baPtE0q92kA8MIcHgpL+JHFTL9GPjJl4ZafLY/Dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4aFNegNX0EYa8DuqDH0aWusQCtF7K4la5NXb8CKX2c=;
 b=Chb4cNOzA7DTP3eWL5H49JTu7GhHOwbG6aKHNoMTmt2AfjqA1eg7izJvV+UnShw/Bgu4YtnRR6vWSt72DXfbxkwwzfGGS8+4eG47pNafaIFVsqqXVFM0Ud3JcyBnb4JPhlOpgA2fIqfhMV2WBE1Mjmvp94HS1ceHPrgK4kKl6KbM9dEp16KiOf4f4jDlBHu2iStMKUtzX0orMFLa7fZXF89mnHt6TPSBcRWKdjhizqVn0xQTcjYoksm3zpQ4zHanSGg1+fgSKQ3Mzi0+lVW9fqLUZqF498Z3hLVOL1khd8eOBYKIsJTJHZQjULsA2UhDP3TyW6Ld2MxPn4heoG5kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4aFNegNX0EYa8DuqDH0aWusQCtF7K4la5NXb8CKX2c=;
 b=LrZ+Q8mOg0iK9J75hl0hIonRuciJuxYFEUwL5sKnsUU8R5elQ62Nkdv+5vCX5LWsBVuTUQpzziZuZlE48dDqYpDwz+bCwCOrrcIQiTZu7QCAOkrxNKAxt59C3n7o4aEiYeBnrdaR2U6QQRBOzBoBPi0jawWjHUfHG2yXsr/V0BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 09:35:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 09:35:52 +0000
Message-ID: <769bdd8f-0dcd-47c2-a0c7-2e59ac338c1d@amd.com>
Date: Thu, 18 Dec 2025 10:35:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix signal_eviction_fence() bool return
 value
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>,
 Gang BA <Gang.Ba@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20251217095811.709295-1-srinivasan.shanmugam@amd.com>
 <20251218092959.742273-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218092959.742273-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0648.namprd03.prod.outlook.com
 (2603:10b6:408:13b::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: bb66a4d0-c924-433e-15e1-08de3e18d5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2pmRmcwUlI1cWhrZnhybGhMMWlHQ0tqRUZCbVJSMjVQOHExV2RBekgrZ2ZK?=
 =?utf-8?B?ZTFYLzM4aUNvMExtbkE2NXFLYWNBZURjdnpyZHl3TzZjclM3SHVNZU4yTUFq?=
 =?utf-8?B?ZkwwVFVhdG8zdHpNaTIxRXo4NVN4dnFYeUVsekxSb1dQRFcrZE0reFk4eEdN?=
 =?utf-8?B?SmZVeDdGSi9tdms1aFpnZW50TW5mWWV4WEpjekM3cmNsQVNFQytOVklldnZV?=
 =?utf-8?B?TnZ2MWUvc29yMWhNa0tVUUZSa0V3NHJuelFlTXhGM1VXZHRJOVl4Uy83QzY3?=
 =?utf-8?B?eENvQ2VaemxiTFIyNENNWFhtdGRWVm5vQ0p4TndLb1l0TDN0TWtXU0JocGlv?=
 =?utf-8?B?TjhGTlZPMWpxaEJWTm9rSS9yRkVTVFYvN0pkdE1Ua05pSm5ES3daVG9ZUTlR?=
 =?utf-8?B?SHZIdDV0UnhaZ05kRjNiT0VBczZ2bEtpbDdDSHErQStIbWJmbzR6R2IxNVU1?=
 =?utf-8?B?SXRxL2wvbFdneGlTMjBTdVlwN3Q1b2dOa2lxaGpmTGo5bm9HSlJ1MEpqYVIr?=
 =?utf-8?B?bndIb2FzUUFrYWNuSFV3MjZEREphaGs5TWJQR2FHT3ZLbzlHS3JQV2tReGNu?=
 =?utf-8?B?dVk0T3hzbjNrWk5EOUpaNU9YZmVOTWJCZlRtRlBqaFljQkg5MU9OVUQzUGla?=
 =?utf-8?B?cm5XNFo1Y2JLNlhDSllVdXhHbzNuZ2JhSGtINGVJT2NEZ2NxYk4xeGtpQjFL?=
 =?utf-8?B?U1hSTnR4Y1ZFNjZhM3BId29KZ0owd2pteVkwU0dJWDFvMUh3ZTUzVFh2TXJL?=
 =?utf-8?B?alBPMzRsOXVka05JbTQydmZBL3NKNDUrbExKOGFaeWVuSlRlMlg5Sjd6UjBy?=
 =?utf-8?B?bTlBQjVqVEVEVkhOZ1NuWnNZemVXc1Q2QmlBa2ZZYzEvcXVVWGpQZjhpSmNW?=
 =?utf-8?B?RDlWcXRLcmRyejdJVDdOZHFOcUJPSVBzQkxFQU1FUDU0WVBNWHo2QU9XUjlZ?=
 =?utf-8?B?NTlrUEVtUVBJLzFZK0lFZGpPQzJJalBRTk9rRHJSSWFVMmVQRGpvOVdmdTFI?=
 =?utf-8?B?RjU5SklYMEFyYnV4YURtcTNJM3V4eUFhUHVuRmpXN05ncVhGM1pGaVFLVEpE?=
 =?utf-8?B?ditSQzlyd1FFRW1ISEcwUUhtR1ZJU3BCZG1oTmlYb1NoRjN6dTFXb0IyMlQy?=
 =?utf-8?B?Qm5pb2tyeTBUZFd0Mi9xQjJML3ZxTGRVNDhoYWpzUjRDd3dTM2RJTll1c0Rw?=
 =?utf-8?B?UHhWMWtKN3JheE52WXFIQ2RUNGdteWNvMWpreDB2UmE0amtnMEJ3Vk5tTjBw?=
 =?utf-8?B?MytaMytySEhiaW9vRStPSkdGNXA5M0wrUmM4KzJ1NUZSaUE5WnlmVUx3YW5y?=
 =?utf-8?B?ZjFiQkxaNW40Q0lqQUF2Q3NqU0YvOHBzZVV2RFF1M1JxNTBWRkZWMytBMzFo?=
 =?utf-8?B?dlFuRnRFSFh6S3FQWkFQdHd0NTg4WFY4elV4UitRL2xUSTlqTEZBb0h0VThq?=
 =?utf-8?B?dzBBS28xMUVrYWdHcGFvQjd0VmdvSG85Nkp1bUlaeGVQVXpPUlArWkFjME0w?=
 =?utf-8?B?cDVjSFRjdWFvYkFKcGZub3lBOFFSSGQrWTdZWXdPWUlmbXFqQklIUUZrdUND?=
 =?utf-8?B?NXJwci9sbTVzZ1ZUNGZHWHpUNXBFVENXd1YrMHRjTm1CeEtRejdVMGlpSWlW?=
 =?utf-8?B?YTlDZmdxRVRhWmJzM3RxTDh0NjFnOUp6SmZOKzlJTlFDeWJCUGZZMmtMaWR2?=
 =?utf-8?B?SUtBSFkyZEV0dTFqUndlTVozclc2NjZIaElOMmhQVFlOVHdNeStrSWlNeVNw?=
 =?utf-8?B?S3E3dHF3QlRXUzJNbS9Cam9rWWxzZmx6czBGTkt6S2tLaTRNWkhSVXM5K3pN?=
 =?utf-8?B?Y3BrT0pKVk5tSzAzMDVZSFFLU1ZEL1h2Q2lUSjRXeXdlWTRMNTRqbWVKejJk?=
 =?utf-8?B?aFNpaHFlb2h3RGJiZnJ5MGVXQ3g2K2RnSXpzQzdyVkV4WHFHN3dNdHVVd1VY?=
 =?utf-8?Q?qVtcnbgppIT4a+ZRzvowYeqaONe5NVcY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1VR0RNTUFmQ2NvdXBtVXRLRXRpZ2JwYjZJMEZERzdaRUJoM2pUL2Jpa3NN?=
 =?utf-8?B?VmpxOHE0T2gxdDJZcm5VMUxubHE1Y05TTDdFeUFpMG9rUDdpL1RaUS9YWC9v?=
 =?utf-8?B?STQ5UU9tQ0hoUFZPNitpL3dKUk1ma2FGRkI4Wk5DSTVwTFlXYUpyczBGMGNU?=
 =?utf-8?B?cFZiVmJzQ2VLUHhjWTZYWFlpOUJEVENmV1I2MW9WaGU3bHhjMWtOUkpIZDdj?=
 =?utf-8?B?M1ZsQVAxZjhLOTVhdy9vT2JBWkM0NmoxZ1piNmo4VlY5bEtuVFlDd3BqWjFm?=
 =?utf-8?B?b1VKRmNhMm5sUXJKY0FHS1hqNVEyTXN2MFlUbDBXN3EwVkVPekVvQk9Ta0xj?=
 =?utf-8?B?dDRITUdqbHNhdFRmVG51RGFmM201WTFVRTFNcXBkYVhDZlJUZHRBZktocVR0?=
 =?utf-8?B?cHZ4YWZtTEkrcXFhWm5TR3VnRGN5RlVNQUpBbWt2cmY3UnAxNTJwZjZmdkZq?=
 =?utf-8?B?Q3dKOGxFZXlQaXpRRVJXUHd5cCtZQTA1RGlVY2pnMEZ5c2JHeEM0Zitnc1U0?=
 =?utf-8?B?a2czWWo5YmZLRFp5cUpCUTFXY1ZLRWRzdjdtU1hydmtaYy94ZW1qVzhlU0NQ?=
 =?utf-8?B?UCtGYkYxYVpJRWVTM3d2b0pvTTNLMEMwQVNGQ3VzOEVYaFRDMlVKa2VKaEw4?=
 =?utf-8?B?QjRXMXg2YVhpcnkzN0x0aEF0aEF6b002TFpjMUZaaXVVaVhqbXJiOFdsOU9Z?=
 =?utf-8?B?b1ZyR0lvZmtWK0pDTjVhNGxvbFR0UDROUk9YYytRUnlJRjhiY0liSTR6Zisy?=
 =?utf-8?B?Mk1OeUhuMlR4WUtVa3k5WTExVFFDdHhmWjhXcWFRdFpOREg0aGN2Qno0RFBj?=
 =?utf-8?B?YSt1OFlkL1hYcnNLREJOQ28zMkZ4aDlONkhMZmVNbHQwRHpBSVluL0JkNFAr?=
 =?utf-8?B?KzBLa2RQc1BOeFRBR0MzTVZlTDA4cU1Sam5KVlRnRTJLVnNkNE1Gdmpsd3Jj?=
 =?utf-8?B?UXA1ZEw4SUVCS1FmTGJydkhWWUVlc1NSa2FVYmNoSDlZQm1qR09LbnNxQ0Rv?=
 =?utf-8?B?YlNlKzJvTDNRa2tKR1Q5TTZseGhJVkhQUGdpM0c3Y1VxMkNYQmRyQnAzZFNF?=
 =?utf-8?B?Wk4wZWQyMmdzT1RTOXFQbEtXaSt2QkUvWkRhWXNmUi8ybXo4N2tjQjEycmtF?=
 =?utf-8?B?Q3k1SEFCUFNyYXZNWDBMSHl4K0ZoZzF5c2tjWGovc3hnblA3SE03OWtsTWpM?=
 =?utf-8?B?a1JQZkhaVGNIdVpXNjNzUlFyY1JwMUlKdnFhTjNyMlVnczhuNkRFU0I1TGdv?=
 =?utf-8?B?bXpLYTRQbEFmYmJzQk1rTTBseTdNYjBmcGswcDJsYUJXaVA5dzZRaDZLanJV?=
 =?utf-8?B?WUJSSUpqZ1pzYUpkcStkVGNNcncwWjdHdkZObEJxdnVMMzgzTytZeWpORUZi?=
 =?utf-8?B?Mk1nYmtBS04rV3ZKNzMxQjFnOWhoVkVYeEdFYXBINVhyakd6TnNvOTFjb20y?=
 =?utf-8?B?N25BYTB1aWNMK0swdkhUN2NKOFJiVzhXMHJCQ0szU1RSa1l1dERkQnc3cHY0?=
 =?utf-8?B?eXlFNzVBeHpJdXQzNW12S0pKWjduYk15Qkl5TlhqWGU1ZE8zTk0vVTBMQkN3?=
 =?utf-8?B?L3hXQkJNQzNiUlhWZlZVclo0UzBZbitqZG5oN1M5MGVSYy9ibTIwRHVXRnJD?=
 =?utf-8?B?STVuZ2w1Ymwzb3hkVjVjME1zcnF0VzJpbmUzbXdQVGdPYUNoWGk3Y3dtRTNU?=
 =?utf-8?B?bFVML2JpeS9Bd2RCSlFrWDBPM3Mza29WY1JlcUJReEplOTJlRHFHM3phemUw?=
 =?utf-8?B?bmNqa0lPR090RFByMDluOXhpWkxzdklWaVRGQjRYRHNDNjZ1eGl4Y2o1OVBW?=
 =?utf-8?B?M0llbHhSdTV5NDZGbC9kUWZmYzk3WXpuZ0NneVVkaVlXYzQwTHdZcnZVVGN3?=
 =?utf-8?B?VnhrQkhtV05EWlE5K0dESzd5TllFWDhhcWJ1VVpMY09tN2QzMjFFZ3EwWGEw?=
 =?utf-8?B?U1VwVVVTd2V5U3RhdHV5b1VyR21sVGhsdTRaVDJ1MG95RHJ3cXh0eGFBdmtn?=
 =?utf-8?B?OHRHSzlmMFlOZXJOb1pFd082MFZwSHN3VmUrSzROaXhqRnI3OHAwSys4cVho?=
 =?utf-8?B?bWhkakl6QlhmWFplOUxjU2RNQ09RdTlMekFsa0xEb2MwYVhDL1FHSmprVnNN?=
 =?utf-8?Q?ds+5y1WFnpotBSn8GVcULbkzH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb66a4d0-c924-433e-15e1-08de3e18d5d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:35:52.2304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXYpuxFj9ZF8p7liEFSgu7EHjXvLWMTtUGYU/7DnzrAPUI2t90SS4Z02w9pKw77m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
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

On 12/18/25 10:29, Srinivasan Shanmugam wrote:
> signal_eviction_fence() is declared to return bool, but returns -EINVAL
> when no eviction fence is present.  This makes the "no fence" or "the
> NULL-fence" path evaluate to true and triggers a Smatch warning.
> 
> v2: Return true instead to explicitly indicate that there is no eviction
> fence to signal and that eviction is already complete. This matches the
> existing caller logic where a NULL fence means "nothing to do" and
> allows restore handling to proceed normally. (Christian)
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:2099 signal_eviction_fence()
> warn: '(-22)' is not bool
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
>     2090 static bool signal_eviction_fence(struct kfd_process *p)
>                 ^^^^
> 
>     2091 {
>     2092         struct dma_fence *ef;
>     2093         bool ret;
>     2094
>     2095         rcu_read_lock();
>     2096         ef = dma_fence_get_rcu_safe(&p->ef);
>     2097         rcu_read_unlock();
>     2098         if (!ef)
> --> 2099                 return -EINVAL;
> 
> 		This should be either true or false.
> 		Probably true because presumably
> 		it has been tested?
> 
>     2100
>     2101         ret = dma_fence_check_and_signal(ef);
>     2102         dma_fence_put(ef);
>     2103
>     2104         return ret;
>     2105 }
> 
> Fixes: 37865e02e6cc ("drm/amdkfd: Fix eviction fence handling")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Gang BA <Gang.Ba@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 028853d39841..82109f939c13 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2097,7 +2097,7 @@ static int signal_eviction_fence(struct kfd_process *p)
>  	ef = dma_fence_get_rcu_safe(&p->ef);
>  	rcu_read_unlock();
>  	if (!ef)
> -		return -EINVAL;
> +		return true;
>  
>  	ret = dma_fence_signal(ef);
>  	dma_fence_put(ef);

