Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14608E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0A310E27B;
	Wed,  4 Dec 2024 15:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SAfenicv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F7210E27B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL317ZOlnedB4dZcSLL9j6ktD4mzNHUqqNylK4L65vXtxSZXtoQp1Fr1VJRKfZVMey0cZX8QsAPMAj5q1XkXjNVz3SKTCaogwNmLCQ8HPobX4R7fG1N9VOzKFU0nfUbcrH0TTINGyP4iRnZMW+NwLfC5+7FZrVcqmnICLajXt7q73MBfMVYA7g+1ExxrnBhztUaxO320j8MEePNBGWAkHiSUqh79CPesF13jrj+X5avPIPIWFy/3LP0V8fDRT002ivfAvSY4w6Ys/EB9m997X40GrSnjQKCSu5eB+V3OQiU8g6HnnMVDgeEhGGX0nFTRKQaqz+W1FF0sF22IvZyThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0q0zU5AcLb6danFXZUAy05EEhREbZc17RcNCNFe8M9M=;
 b=ip+0Xg3cefp8shfP1h0lNUPEyuLzsAmAk2D4eYg27ClK9jjDsR1O1OJ0QK/WNyehGfebgKIYnVQ5dEMArgAvIzgF9Luahe92v3gn/abG5VJwUOdmngRid+BtTNbaH3Dex0ncJmdaKisr0qCrTRPl3wMM8DZWKH/HGI9ZD7sPMiXnmhZSqkt3ZjquaCcWrJYVkz9VO68RnjxfWLIMOTlxPzEa2XjCN1B8xRxOXIdYmxRYMSeMSE6C0zVRTL/xLZMVlnxkZJKwH5PtIt5sqaL0UlV8gS9bRCbf5cOVti5WH7EPfCscl9i+6WJu9kEd6c2YIgrCZu6W/PzBewtsnpHaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0q0zU5AcLb6danFXZUAy05EEhREbZc17RcNCNFe8M9M=;
 b=SAfenicvgu2sMlr+u9aaPMQhy5Iouale3FzBr7IsOT9ZQO8KwtDT6HAtDrEYBA6ZikqAaoL3MojGj+vjjsKQElG1IYc3J8ZOO9Eibo8tmkxUin8wX6XbmiyjVYarxYtABotIoYLtpSC1nSsCLqQtu7o9z0pmId/9Phxw4ouwwiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 15:56:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 15:56:29 +0000
Message-ID: <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
Date: Wed, 4 Dec 2024 21:26:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 072012f2-1bc4-4d29-4148-08dd147c36ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVJLZ2hHVmJqZXRwZ3M1bk1MZUJKa3g2STY5dVZRUXVyVy9wdUNnNEk0TENt?=
 =?utf-8?B?d0RTeUFPc0ovdVVVK1hCT1lxWElhVUxNL3QrUzVueVhiTWpLc0d5aysybGYz?=
 =?utf-8?B?U00wRFR3TEo3QWJtd0R6eGEySVo0cUJKLzZWK1IvU0ZZOEtqQmRSTVlCaUFT?=
 =?utf-8?B?THdhREtGYWZ1TExNKzA3SGdqS2xpYVZ1MXZYeWFPZW1kNGFWYm5oWG5xK0RN?=
 =?utf-8?B?a2t0ajgwQTQwYVZnYXh3RlJ2U0x1THhZdXZlRFlsVFdHNko4Z09FaDNUREt4?=
 =?utf-8?B?OGo2MmppMG9sOWFZZE0wRzZXVWl4a25KT3VlVmRpajJZOXFpckFrUUw0bmZ3?=
 =?utf-8?B?V1ZzMnJUMnhBTFBpUXovdEJpVmUyenRwVFhGbkdMc1dEWUdoZWY5ZUhGREVa?=
 =?utf-8?B?bnZldmpHWTZEY1ZUMUNVb0FHUEhwUWcxcUN4N2grdUxpMzlPRHlmd0FTdEVa?=
 =?utf-8?B?ajIzQzRrdWRTeG45OG5WVHF1QjIva25NdkNLbnQ0STQwREI5UHprYkdOcHFC?=
 =?utf-8?B?ZHZpNmd2NCtxOTlaaFdyYlYzRXBLNTBvSmsveVRMbkZhNGVNUGdOTlJIOERW?=
 =?utf-8?B?UEVvU0g5UXJjSllOVExBUWRsWkpneGJ6YU1XemtTVURLSS9LaFZ0SDRtSlls?=
 =?utf-8?B?OVlCNGNrZEc4SWltT0xZWGduaFhmbXVNbE1PSDFhSlhMRjZSbkZGQlRmNXNN?=
 =?utf-8?B?dmxVQnRUU0lCbnRZdlRTSFZEMDM1YTZsTXQxM09zeVlUNTdXZWk4dnJ2NFc1?=
 =?utf-8?B?WWJFNStLZXFpTDQ4a1Yxalk4bzNhSjJSa2lSQXU2L1hpNWpjVkZLOVBGaXZx?=
 =?utf-8?B?QlV2VHlvUlhxSFJaNHA1NS9CWU9rSWQyaU9PUEc3VnFpcEt6TGNPM1FJNWJ2?=
 =?utf-8?B?RVNJSFJuMGV3cmd5eVUwbFhGaDduMXU5aWl0Qm9Kb00xanVaa3hrMUhQWC8w?=
 =?utf-8?B?Ull5Z0t0R2kvQmVVUGFmYXJlN1BsaWZwejdkT1pxTHZFbS9hVUMvV0VjWm5X?=
 =?utf-8?B?TUtRLzZ4Q3poeGVSd3VWN1ROejNwbnp5VjJnczJUdmVBOWZUb2tFS2d4ZU5j?=
 =?utf-8?B?Y0hQMjFVejE0MUZjZ3pkSUlxMDNaKzVNTmpOUG5yMjlvajRzMSt5ZVozL2R4?=
 =?utf-8?B?Q2JkTGNNRUFGR01MeVBxSnZHZ2Y1YnVQR2ZoNDZDOHMzWERpcEdrNU9GWThG?=
 =?utf-8?B?a3ZQV1JmZTBuWVBKOHJzVHd5ZEtJeEQzTEswY3BhRktXZXFDdXliMDJGTTRT?=
 =?utf-8?B?SStoU1hyUzB4bkc3OHZFaC9VUktNekYrMW82WkdUN28xTkg3Nmt5ZEkrcmIz?=
 =?utf-8?B?bGtCNFRoSk1EQXNQREdMV3J2TkFLeG81YnA0dlZydDJLZlBrczJLamtNMTJm?=
 =?utf-8?B?UjBzSG9aN3lmZ1J0RFg1ODE2WUlSenE5N3UwQVo5TFI4aldYM0dPajNVcytJ?=
 =?utf-8?B?c1RHOU1pSnFzZk54TUNUUFkwcXZqS1NXTU5sYlRGdWlXMk9CZ1BUZXhqZyts?=
 =?utf-8?B?YS9sd00wbkZqRkl4Y21SRXNBemF0VC93RkhFYjZUWHArL2hiZXYzNGUzaU9r?=
 =?utf-8?B?T05KbkRPVUd6ZVd6VG5yYWZTS1Y4N1J0MVg4N2U3VTZPTlQvcE0xL1VpdVYr?=
 =?utf-8?B?WEFpd0xMSFdXekNjVytIN1pOOVdLeVNZZGRDdU9jMkc0RkpUeS8zT1p1WllJ?=
 =?utf-8?B?UXh4TVNvMGthVUZmUlg3M09yeTZHdDkrbldEbkNmemFWc0c5cDVJVzUzNlBH?=
 =?utf-8?B?ME1QUFptbWdFUFhrMmx5dUw0SHNJTFlqMkJzblljOVJoTE8wWHk0UDNhaXM1?=
 =?utf-8?B?eG1HZlI2cTIvREI2N3Nwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEYrZXdYcEJ5Qnp5b3hBOE91QVNabzZOYUpidDhEcnVDazJONVRxUXAxYXhH?=
 =?utf-8?B?bzg0Y2xseEpGL2NidXc2Z2MxT1pVY1p2bnpGVmJqWW82VUZHNDJGQi9sTUI4?=
 =?utf-8?B?ZnFvYW8vcVBuZ3MwOG8zRWRwSVpZY3cxbTBrZStVV2VCeGdkQldQeGZUdW9u?=
 =?utf-8?B?cFpvTTFIakVGWk9EM2sxRnBNQmgydERMUHh3UHBXWlY2NXhpQ3FnZU5Ybk9T?=
 =?utf-8?B?RW1iaVNaK0hhcWdJMG55UnZkUGhlekZiR096cEFSaXFJaFN5Zm5STnRuWE9J?=
 =?utf-8?B?dmswRGR6MWM1MGlhNXBXQ1JOVE1hYkpCUHp2Q1hBbzFkajJzNUwzanZuSGg5?=
 =?utf-8?B?eEZqbHhKU3dBMExKTkVyUlFFQXpMK1AvZ2RBUlRIaXBDTHlVZGhMNHJ5Z3B5?=
 =?utf-8?B?S0s0bWVXbkQ3QlhZVmE5K1Myc1I1ZjRRWjJIdFRTZ3FSMnhjTXZPNUZxQnk4?=
 =?utf-8?B?SU1JLzI5K3k0VXRYR0NQOFB4RTk4b3ZWbm5ENzdvYkI0NFQwNVVyYXd5Zkxw?=
 =?utf-8?B?RXdYODk5Q1BXQmNjZDFVREE2M1JBNmlHeitjV2dGaXJ6dHFTWnFYN0RURS9v?=
 =?utf-8?B?a1lUbGRvOGJyOWNsUkdpOXZrc0RYV3NzYlpzR1E1YzJsY0gzbWZmeWtFMkZD?=
 =?utf-8?B?V1JBMkpvLzh6UkNnM1pLbkt5Mk1TK2FjYzU2MjlBcHFCUDExNlV6dlViOWU2?=
 =?utf-8?B?b2N5am9MQ09wVzAva2Z2UXRzeFBVRExzZ3c1NHErWU1mT0x6MnFmR3cvZWda?=
 =?utf-8?B?ZndseFdMa1BvakdzdFRLVlNSZ0JGbElpbVU2WXVrZnF1OHltbnd1aHdBb1Vw?=
 =?utf-8?B?RkJEK3ZnSU95ckx3MVdGZ1A0UG5NdnFlTHFCWjdnSHZiWVZwQjlSMTN6VWtz?=
 =?utf-8?B?RUNsaklKL1NSK1lUSDd5RWpRd3E0QnBQN3ZqWEk1MW5FaGdkWGF3YjVFdHBq?=
 =?utf-8?B?NXFJcS93UWkwZXN0QmUwQ3cvTG81b2FKZG1jYkJ5RFpYNVZsenZSQi9FaXZs?=
 =?utf-8?B?ZnlUTmNFalhualZqR242VmxGVjlYQnNPN2NaVU9TK1VBS1ptN0xOSGgxVmM5?=
 =?utf-8?B?UmZzVytIQ1Y0VEVQeDF6ZGtXZ284VHFDMFNJYzlQYTRiRlphdmNvdGtXckJD?=
 =?utf-8?B?NmhwUVo3RGp6YzFYK3FhbEJSZ2ZLZmwzTStTVm1UWVdOUDF2RHdGZGNkeitP?=
 =?utf-8?B?Zy9BblpmRUs5Q1hSNi9TQURObVE3MFd0enNvYy9iYm16MkV3M0FrSWdaeHhw?=
 =?utf-8?B?ek5UWXBpRkdpbHV2bkdmRy9sa01zU29IU25kYzJXL3lNTjJGSm91a0NrZ1JE?=
 =?utf-8?B?UHlleE9ZcHJXd2tESTBQNUp6NElOQkUrd1hDQmtROXdNYlNER1h6RFI5bGlR?=
 =?utf-8?B?NUtzNWlGQlhKWi93SytyNWNsY0puNXNZakxXYWdQcXNtN1U0ME9zby9aaXc2?=
 =?utf-8?B?eFZ3Tk9BVVZabzJWbjlpdk1RTi9kdjQzTCtlQUh0K0RVUE1lcXdEVi9YU3hu?=
 =?utf-8?B?endNbFVqbTQ5ZGE3WDlyMEdhQXpqTGhQUEdNYXlnYnJDNDUrbzFMaDVOQWlj?=
 =?utf-8?B?dmtSZGVkK25BR3NQSldwL1RBOFJHOXNGWGk4RFNpMjQ3YlBXZitBYTZ0YzEz?=
 =?utf-8?B?aG9ML1Nsb0pqQlpiNXJOaG5lU0haOHpWSk5qNkRORTVpY3ZsZjV0K01jV0JV?=
 =?utf-8?B?NkE0YU1BM2FoWXRUL3lld3lFTEFaeTVqVFNJeWFGemxBR1RORG4wSWZob3JE?=
 =?utf-8?B?S0xqdkRMZ1A5eEYwb2c0bkpSTkNJK2ttWnUrZHFDTEd4b0dFRHdRTWZMbUZ5?=
 =?utf-8?B?MHBVNlhRMEE0bGt1N1FObEFrNU5qcHFLOEpJamhseUxIajZ4cUFFVmtGSjRU?=
 =?utf-8?B?UFRHejNzbkdTZUdRcktUSEd4ODhPdU13bHNIMm50MktWZThtQy93NWVONWNW?=
 =?utf-8?B?N0lQd1kvQ0dOL2dEMi9BemtpZ2Riajg2TzhGdWtZUXloQnNpRWdBRlArYW5Y?=
 =?utf-8?B?RnBxd1ZrMGpMRGxiZUIrc1Z0RW9EMUhrQWsvNXREYzlZbExGc3k2M0RZRTc4?=
 =?utf-8?B?ZHJ0VDZqSndhdGpobWlxSE9nSTJ5SkhJNmdQSmU4V3NnMzdFb25IU2VFY0lJ?=
 =?utf-8?Q?QrGURnJcxO0SLv0bZXX/zOkVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072012f2-1bc4-4d29-4148-08dd147c36ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:56:29.0378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/Eo6v2ErJ5DMxjkXixT53ci9a0A0t63zqUzPysns/wdshBOOjsjjx2YQybz6u/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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



On 12/4/2024 7:51 PM, Alex Deucher wrote:
> On Wed, Dec 4, 2024 at 12:47 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
>>>
>>>>> +enum amdgpu_ucode_required {
>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>>>> +    AMDGPU_UCODE_REQUIRED,
>>>>
>>>> Couldn't this be handled in another API instead of having to flag every
>>>> load? By default, every ucode is required and if optional may be skipped
>>>> with amdgpu_ucode_request_optional() API?
>>>>
>>>
>>> I guess this would be a smaller patch, but 6 eggs one hand, half dozen
>>> in the other?
>>>
>>
>> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
>> into the optional ones so far. The usage is rare, similar to the
>> nowarn() API usage.
>>
>> Also, as far as I know, the cap microcode is a must whenever used. That
>> is not optional.
>>
> 
> The cap firmware is definitely optional.  Some customers use it, some don't.
> 

I thought optional is something that can be ignored even if FW is not
found and then driver load proceeds.

What is the expected driver action if we classify cap firmware as
optional and then it fails on a customer system that expects it?

Thanks,
Lijo


> Alex
> 
> 
>> Thanks,
>> Lijo
>>
>>> Alex - what's your take?
>>

