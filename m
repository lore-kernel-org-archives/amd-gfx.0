Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27932CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C6A10E908;
	Wed, 10 Sep 2025 11:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WE2zqDJD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF26110E8FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXjVbNQODWtgnZdZwqLDO88400Z80w6hubbSid9zgBRn5FjYmXy/6DePS601SdsswmFuoH36YTtNOlKS0nOoidtokQJVcp23oU+Y+4PmlmuaiRNuhphTuWUzdBsB1MgZYeQlUXXs8CwvukQz+710GKf6/WdQyfgUx5NJRZuWroFOQy1EUUkcs8P/nH+Qc+Y8KYQOtrkz0AErB9lsYvv9wrJdxf6iMywZkFRQ4Ww0/Iw7w+eBodJNdv+GRAS4Hd7lRfkvPeeOk7bAl4UDCTqyqID7Di29qorqDC75YGLLU2mDbxI6R7zet8h//LDlaGQaRYOZvT5int3xz9n9dYAojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHdZLaglnvMf/5Kwkf+lLgzDhk/i5YfumfW3vv91HLA=;
 b=paPk/8lipAQ855LpBe6/51uQ+qPriQf2wcR940RDqcB6WukHqOwENsASyWIUFLIsd2OvxEdkoahp7I06NMCCQm0KHyxCUtiV6wL9UEzXsxgOxpiTlIgG6a5hHxXHP7rRPGjIbkHm0miBV/U/ZY3cCxCFchwxKyjfja+5R5Gamw2e4RBE1eFGn5lRnTA6bGQ3fRKZVW25lSyAbnoqvbqp2kPU6y9zPFRKUWqtGmCTFSY8zlR1i18/U0M1sua4B7li6n5B9iLf5ljyuvml8s0ngIH2kWJnVOU42GVdkPeIhqg11bO5Knnt1s8o6QdcMsCwoONPkjBSfVhHKNYvAn3GlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHdZLaglnvMf/5Kwkf+lLgzDhk/i5YfumfW3vv91HLA=;
 b=WE2zqDJDXhMKpzw5CbQ/CudEDRiPQCS3yKBp00ptzZFLjOT82JBgnXTcq6WUBBrzL/qAEI5uwipQ5OXHRlfDKWymzQvYXwrU10triaVcfv4+jKnnTg39d4/AEcHkQV7N6eNehx9EAPHeO13RtyH47s+PAKvMUbwz+HwR+Lc1Lt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:46:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 11:46:42 +0000
Message-ID: <a77a5934-afa8-48e5-bb15-a7f55087c245@amd.com>
Date: Wed, 10 Sep 2025 13:46:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
 <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
 <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 722ef4df-4feb-4659-87f1-08ddf05fb5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STUxVFhIOHJJT0ZQL3VMaVJqNXNRd3ozU1lSL2JuVS93YmxYaWE1cTcwNkM3?=
 =?utf-8?B?WnVSZkFoS0tkb0hMWlAxZlM0aGdpcGFhOGtGR1puaEI0d0YrdlcvZDd4K2hI?=
 =?utf-8?B?c3NWVmsrNWY0Y1ZXTXBZSE4xY0xqQ3dLS0VXQVlYVEx3M25xN0EwZ2NOVnNu?=
 =?utf-8?B?eHRhM2dIYUsrL1NhbjNBV2c5SldmT09PRUd5MjlaYWJvZ1FVc2FYZnFlaXFR?=
 =?utf-8?B?aU54TW11eHZCZlU4bFlkM3ZDN1pMM0tzZ1NleWcrV1MvdWN0MEJQNjJzMWVJ?=
 =?utf-8?B?aXIrd1VBZlB5RXRmcjZyRS84M0VrN2I4S2p4R2NDY3UxSS9yWkhydGF3RjRS?=
 =?utf-8?B?WktMMzljSi9PeHJqZmxzaTRyeE5WUmhZZndIeW9HQ3FBZzhPd0x2WEE5KzVq?=
 =?utf-8?B?Q0x5elZmT2hHeXhQNFdZVU5Bd3BiMTROaENRUHJEeUQwczloVW9zR1dPbjFO?=
 =?utf-8?B?M0NzT01wSWRFUXVxVlF3SW9PVTZpMStoV01nSW55NjhrbVQxSW9WOFFmMTBC?=
 =?utf-8?B?NkNWZDhMalR2MGpPQTZLUHdHTnU1OVpWNmJ0UHFTMS9UaktXMmdMU1ZyWnJk?=
 =?utf-8?B?MG5pRkhwWG9RVVNxd0xobDZxUUp6VFRmVWxzNFNyd0JjcEY3cjlqcFF3dzRk?=
 =?utf-8?B?eUtlSTFqcUZ0OFNpZ2ZkNXFOMjNZdm9nUVJiaTlJcy90bTBESXAzQXRJTE16?=
 =?utf-8?B?MGNTUUZxM0JLdDN1QmpxUWlVcWxoZ2FxL0p3a0lZMDJRUk90MHBBa1NOVGxp?=
 =?utf-8?B?TkFpV1U1TzdVRGFYcG9IcFo3VWxhUFFKcVdiOEJxY0hLNmpSTGtUS0hYUHZM?=
 =?utf-8?B?TC9wbXYxbnJmY0dtMUdQTklwaHl3Nm83Ym5pdEpxcUxGVE9VUEtyOEdsQXRt?=
 =?utf-8?B?dmFqdWVwd0EyWVJYZzg1Q05wRGp2NWdIS1MxcktCSWljTUZjNHk5K2J5SW4z?=
 =?utf-8?B?MzBnZFF4T1pkd1lSblNDckErQjdFVHpHT1VjdEd2bTNoNXBWcFp4RnFDNzh4?=
 =?utf-8?B?M3JRU0hxVU13blFEYS93cFJvT3N3NUFUZ2oyV0ppdzBDeWgyVzc1OFdVY2dw?=
 =?utf-8?B?QW1HWXdIODRiZEZHVWxUQUlSUjlJVDJ2b1NPOE1RQSszR1IvbmlHMjlXTzVG?=
 =?utf-8?B?dVRNNmc4NjhrU29NYTdIQU1JRXhBRDNjOFNabys2dm5qZ21CZHhnMFFCcXFO?=
 =?utf-8?B?M1d5cXpBUkxub21UUGZobGtKQ3VLZzg1VEN1ZEZiZDZiSzlmMWtIZGhUOFJJ?=
 =?utf-8?B?TXJFbDZpRURTZjdZZDQweHVTQ201RHpyckIwV0RmUW9jRkJUYXZZR1g1bHRQ?=
 =?utf-8?B?NG9aaFdLMGpZb3N0VGdkU0ZuVFNFbktRQVhFaEF1L3RPRHEzOGR2ZEcwbmw0?=
 =?utf-8?B?c3pVVXRpOHJnTDVjdEQyVTFUTEZsOHR0VnRJbmhCb3BPUmthYm9jU1I1U1dy?=
 =?utf-8?B?MU12M3oyYzA2cVhvM3F0VmJyTVBaRFdwRDQ2elFaZHlvUEtJazZUNUVsOXdB?=
 =?utf-8?B?d3AxYUhobTZFN1NtOGQ2M3NNSWM0bks1UHB5T0dtZythZlNFVzFEandPWS9M?=
 =?utf-8?B?RVM5R21kak56WEdSTXJCY0JNeTFoM0U5QzJQOUhHaCtzVjRzVHhiYVQxL3lZ?=
 =?utf-8?B?cUFNM1E1bXREbmVYaWMxQ2g5RDg2cytRZmdaQlg0SC9qeThNenZkVWtIQ0J5?=
 =?utf-8?B?dnlmWVVJMzI0YktVSThPdjFPZHQrMHZpclJkWTlXS000U2VmbndyQkRMSHVI?=
 =?utf-8?B?eUhwbXRXZzZiUVkzNmMyTzNWUnZpVE10SmVWVjZMSkwwL2FNaGlBRGduQ2Qw?=
 =?utf-8?Q?Mm0tFuXl/xgFbGFw71Z8F08/2o11CaDgh75Z4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RkK01ja1VuWENkK1FWd3FJZVM0Y1RCRGRLbUszMDBDRWxCQzFGSFBUWjVm?=
 =?utf-8?B?bzVqZkVFcHVvUnFDSWgxbWFweWdtendyQSs4U3lrTlJKZ3pDbVprN3VrTCtv?=
 =?utf-8?B?U2pKUG9QQlpDa1g5RkNMLzU4TldubE5hQ2plTnY1SEozaUExUVlObXhnYVN0?=
 =?utf-8?B?cE8wUHdPOUpHLzRTNkh3NGZMaDRVS3cyKzFDcEhVaGVudGVONGFUYlpPVDE5?=
 =?utf-8?B?cGhQSlJvdnVHVEExQTdyRyt0MTBtUnNSemt0RGlVbnA1SktTSU02dk4wdlYz?=
 =?utf-8?B?QlFFRHBuZWpUb0lrNDJpc0h5eWZmYXRSa2I3RTJxY29nSlgyS0tjRStJNnZt?=
 =?utf-8?B?WU5oVVFKeHh6eERHemJEYXZYbjNvV1htc3BVSEVsSEZLT0JlK00rK2pDZXRI?=
 =?utf-8?B?eTlrZ0x1YzFZcm9GS1NRbEx2amVmWVhCakt0Rmt0QXBISWhOQXE5RUtJL2pl?=
 =?utf-8?B?emxRUHJBRVdIUkxiNE5CYWZrNkltNUpsWHB5OTRRaWloVit5Y3VmKzNEZHp2?=
 =?utf-8?B?RVd5VzVPNlpjQm9rWWJIakc4SlBKaWJpNWQvNVBJOEJBQUo5NC9LZDRvRkJz?=
 =?utf-8?B?aGJwM0xPRjZ4NEdoNDkyZjZvWWJsMm5NS0JyUnhackxLL2c5UUZINjRiVkhE?=
 =?utf-8?B?Q21HUlFBemlYNE9ONEhVWFZVaDNSMHdRazM4eEdnUGt6RkQ1dnZNOUJsWDdS?=
 =?utf-8?B?TXExSTExSXJMV0NoTlN1K0EwcnJ0eTFPMW85akJ2RWhwY2JTQlNUL051NXkv?=
 =?utf-8?B?SkxXaUlhQ1VzSEVpMC9xUlYrL2szU2hmaUU0WmMzUmNKcHRxQ3lZdWEwWlkr?=
 =?utf-8?B?TVVoM045N2RvNy84a2hzRERaK2ZBdkREMERHL0tjNnJBY1NwQVBnSWlaWmRn?=
 =?utf-8?B?T0xWWFBPOW91SWlBRFlmd3J6Vm9YVkphcE53M2JkSDJUZTg2U1FBZTluQjQr?=
 =?utf-8?B?c0gvZDh4UVlSbjNXL3JJanlPYW04MVhURWhoSU9iL3lHQ2Q0cUpwVUV0TVll?=
 =?utf-8?B?bldBWWp2N1JnTTMyK1N0bU1vbGRXVUt4MDZsUjVMRnZtWW1SRWhMbExaOGVK?=
 =?utf-8?B?RjAyQnk3OTd2dEZuWkdBaWNONCtNcFRDMjBmSmFoMWdTRkhLUHdTRzdraU9S?=
 =?utf-8?B?TUEvUm1NcTFiSVFsQjNlUHNRWlgwRVJ1UDk0VGxSMTlFTEc4b2FQckNnR0ZL?=
 =?utf-8?B?Q0lCVkNqaWxNbE1rOXBBeUJLemlaeTYxV1V2Nnl2elRoLzhiVzNhVWJDZWRs?=
 =?utf-8?B?L1Nmd05QOFlYWHFRMkk2K2duSG16bnpCdFpJUFNZMlh2em40TnVTL0xKY29v?=
 =?utf-8?B?Y05aVmo1bmw3aE5ReUcwWjlRbzRuL0FHbFI1QlRuOEkrYkc0WXVQeGhyd1po?=
 =?utf-8?B?cGhWbkcxYTQvQXlTN0pJdVhOd3h5QyttOFNVcmUwclhWZHU4bnJTMC9KWW9j?=
 =?utf-8?B?SUcwRUZOeE12Yld5djJWN2JHWS9iUkJ0cTE1ckIxbkc0NVNHSnN1cDVaNnda?=
 =?utf-8?B?dHBtNDhVcUk4dFBuNlFQNGM2RVZoQU41MXhtUFF0OFRTd2Z0Y3VZOElESE05?=
 =?utf-8?B?ZnE4MTNHSk9zVjJKOVpsb2pvaU1hait5YTJ4NzZ2R3ZJMUFWVFRIRm1BS09i?=
 =?utf-8?B?K1pFeTVuZ1QzYnpRL2l1T0tIeWFmSGhUUldoN0hhUGZBeTlDcGhQWlNHTnFj?=
 =?utf-8?B?VW5nT0FybzhyNmVNY3IxUzNWN3JvYlBSZUhsYS8xVnRsVFdTemFBZmRQWitR?=
 =?utf-8?B?aFk3a2owcjFPdHRTQUxZOFRxSlFaa2tvOVhhelM4UDVXWnlKeXZ1aTRGd3Ew?=
 =?utf-8?B?dmdsNS8zUTZvczQ5aEVyU2NueWZZempVeGJaY0wzM2VFUERKMEs0SnRJQ2hZ?=
 =?utf-8?B?L1BxTFFxdnIyN1MzSEprd1RCdkVkZGRGUHYrYTFDSm9XMzhxOURRcUhSZ2h0?=
 =?utf-8?B?MjdCSGNiNGVTRUVhUVhPT3Fqa21qK3Z0M2VibTlNU1VMclp0VCtyQ09xcFBt?=
 =?utf-8?B?NEk5Yll1VnZpY3p0QkYzcHZOeUpmWW9YWTdCaUhYM2lJN2syV2RQeCt0V00v?=
 =?utf-8?B?NWJWTnBIM3ZwSlowOUs0SThHZ0QzY0dCVHZhcjlaaHI4QmNjZFlGa0piU01u?=
 =?utf-8?Q?LaDnzzxrMr9hF9DboBQcUhuRW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722ef4df-4feb-4659-87f1-08ddf05fb5e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:46:42.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJJiasSNUEfamnJwcDkPs6idjmfF2M38773ps6xNC9YK5rZjOfGPs9kXsGqRI5Pf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

On 10.09.25 11:34, Timur Kristóf wrote:
> On Wed, 2025-09-10 at 10:34 +0200, Christian König wrote:
>> On 09.09.25 18:56, Timur Kristóf wrote:
>>>> Even when we apply it I think we should drop that, the value the
>>>> kernel uses is correct.
>>>
>>> Hi Christian,
>>>
>>> The kernel and Mesa disagree on the limits for almost all SDMA
>>> versions, so it would be nice to actually understand what the
>>> limits of
>>> the SDMA HW are and use the same limit in the kernel and Mesa, or
>>> if
>>> that isn't viable, let's document why the different limits make
>>> sense.
>>>
>>> I'm adding Marek to CC, he wrote the comment that I referenced
>>> here.
>>> As far as I understand from my conversation with Marek, the kernel
>>> is
>>> actually wrong.
>>>
>>> If the limits depend on alignment, then we should either set a
>>> limit
>>> that is always safe, or make sure SDMA copies in the kernel are
>>> always
>>> aligned and add assertions about it.
>>
>> That's already done. See the size restrictions applied to BOs and the
>> callers of amdgpu_copy_buffer().
> 
> Based on the code comments I cited, as far as I understand, the issue
> is with copying the last 256 bytes of 2^22-1. Do I understood your
> response correctly that you are saying that the kernel isn't affected
> by this issue because it always copies things that are 256 byte
> aligned?

Yes, see the kernel always works with at least PAGE_SIZE buffers (between 4k and 64k depending on CPU architecture). You never get anything smaller than that.

The only exception is the debugger interface, but that always copies < PAGE_SIZE, so the SDMA limits are irrelevant.

> I checked the callers of amdgpu_copy_buffer and can't find what you are
> referring to. However, assuming that all callers use amdgpu_copy_buffer
> on 256 byte aligned addresses, there is still an issue with large BOs:
> 
> When the kernel copies a BO that is larger than 0x3fffe0 bytes then it
> needs to emit multiple SDMA copy packets, and the copy done by the
> second packet (and other subsequent packets) won't be 256 byte aligned.

I've just double checked the documentation and for SI it clearly states that the limit is 0x3fffe0. Documentation for later HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the worst case so you end up with 0x3fffe0 again).

For backward, tiled and windowed copies a 256byte bounce buffer is used instead of the 32byte buffer for the linear copy. So the limit is then 0x3fff00.

Looks like that buffer is also used for byte aligned copies and that limit applies there as well.

>>
>> We could add another warning to amdgpu_copy_buffer(), but that is
>> just the backend function.
>>
>>> Looking at the implementation of
>>> amdgpu_copy_buffer in the kernel, I see that it relies on
>>> copy_max_bytes and doesn't take alignment into account, so with the
>>> current limit it could issue subsequent copies that aren't 256 byte
>>> aligned.
>>
>> "Due to HW limitation, the maximum count may not be 2^n-1, can only
>> be 2^n - 1 - start_addr[4:2]"
>>
>> Well according to this comments the size restriction is 32 bytes (256
>> bits!) and not 256 bytes.
>>
>> Were do you actually get the 256 bytes restriction from?
> 
> The comments I cited above are from the following sources:
> 
> PAL uses 1<<22-256 = 0x3fff00 here:
> https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> 
> Mesa also uses 0x3fff00 here:
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390
> 
> The limit in Mesa was added by this commit:
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411bc0d41c095004232ed
> According to the commit message, Dave added this limit when hitting an
> issue trying to use SDMA with buffers that are larger than this.
> 
> For SDMA v5.2 and newer, a larger limit was added by Marek later:
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259
> Which confirms the same issue copying the last 256 bytes on these
> versions, although in this case the kernel isn't technically wrong
> because it uses a smaller overall maximum.

Yeah, I mean that totally makes sense. When you want allow byte aligned copies as well then you have to use 0x3fff00 as maximum.

The PAL code even has extra checks to speed up copies where src and dst are byte aligned, but size isn't:

    if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
        IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
        (*pBytesCopied >= sizeof(uint32)))
....

So it totally makes sense to use the lower limit in Mesa but not for the kernel.

Regards,
Christian.
