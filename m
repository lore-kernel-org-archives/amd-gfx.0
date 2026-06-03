Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08EBCD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 22:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B2811244C;
	Wed,  3 Jun 2026 22:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wk8cwh7k";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8050911244C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 22:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I36XmoudXhmWGNlVUaJ6dB1MxAAwt43e0pdxNPzgDZID6gLSybw8Y4gUAK8VQktnXSfWKibcZAnbxpzoArqOwKkbE7g+EZl+DwcOhTylIcaXxpQg9CwpugckTRij/npZ6EaACDMr6pVEAgxmpfTRircwh0O2E7PBjDb1kaVWehBOJ6eUzsMqaNzCiqJ0cpH60zkVDQh8O+v8Ls/6//NUi9bqpX0CHQ3z1m4hFJvyZAKGqv/CorEGrucZndpvhIQ1RUxEPAtXntVp+3dWyMC5R5DAo6CkKdNP11FO6TczPNLLkAvjzQrnScci38jtvutXjmrzwEuPYAb4uZZUeIi3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqpet/7o1c35x5l2wT+S7cA7VzUb+sQWX7TPnYImruo=;
 b=M+dQGmogmjcj7E6XTaSoCwnj1TUN22GcT81LuV/tw0dxyhbKCZhmZ/oDZcx9phDiXMOOFBnkiANgjeyVfzO+cS0THtAXTLDAp4sAKOsSl0iOzKfH8FKQse4drnlP9oU8PmVbX+EIy72dgeTH/I10mIw2/KbX09oFb9X5Cy3qBM5sbDbXAj7m8tZf8DIUZ2lxPhbK7IuLUc7KQxIwpIfcsO2DR9aTkQyCZjjEbhn4mAjLKnNPHf8Xp2MJSmh9N39yvFqKuy3N8M3Mr90BXkqfu4SPG6g57ZbqBd3W94aIK3BDp0UkY4jqH+YIGTXWyNvHh+zMOjdSIDV6bOTC+n7Ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqpet/7o1c35x5l2wT+S7cA7VzUb+sQWX7TPnYImruo=;
 b=Wk8cwh7kUdqvzmj4KN1EfbG9cZzbZwHAfcJQc7YvJM08kgKFYHjewDt4NH9HnDLGjlHhJ9PxgwyubhpUOQS4ZO1GGChO183M7r+mzbJM54Y6zNuOrftiQlpmfY76NQ1uSG9/9AIq3/XMgJEneBu7HNsmySv+DcLppCb2m/7V374=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 22:51:21 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 22:51:14 +0000
Content-Type: multipart/alternative;
 boundary="------------G4K81NyQhRs8zg3UNcTjgR7X"
Message-ID: <d39183d3-b961-4c74-997f-885eb7a887e4@amd.com>
Date: Wed, 3 Jun 2026 17:51:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes
 SDMA0 permission fault on RX 7600 XT
To: Gerhard Schwanzer <geschw@pm.me>, regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 alexander.deucher@amd.com, Philip.Yang@amd.com
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
 <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com>
 <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me>
X-ClientProxiedBy: CH2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:52::11) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bb0113-29ef-40d8-ecf9-08dec1c29d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|8096899003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: gA7T0CkJIQSDK8MNLmPM1/xrhT4aDsujSsLcfQt+s62MUHLkVBNAgn1Mqhbg447sSC2TN5EjQCAcVJpgbl477llHXtvUeM5vec0tRRDmw7SpqIbD4OpOwAiybDRmlfAAqR4Bc2usNktsFmvN317qYRJM1rgdy49H60lJoI2jmJ3n22a7mXkdx0ROSwuV8lloc1WbV/tLv4h44Xd6a1XY/cURuznI7h7lZsweyM+casMJanR8KbHXjYh24X72uVHihpQPpFmMzZ5CTJd5ngRbkODDVzy1ci9bf0nX/poKyGNHHw3pygPNLxt3rsYI14qWy/SXDYzx3zVix8wiidU+k5BZM+2phjqpwD2dN3zdO4ldKMd1rQR0goQGVslEKZDYtpl2ytTwaymTIGC3jKItw2nQHj4sYKq9ljqTD7Xl0OpzdyByO4joN1G0WzbJVasZkLXCD4ob4gC/ba1I4K/n1/dg5HDmEkomufbsHizfKgh/qwnSviCdOCnzPRBQaGYMPQ4/tPuVNqwqhuRP+94hTO9NZwMY6e/nMK+1+FNnd7ug7fVzBZUkgYbm6iVy0g6UcZxwFOhNLAuwLQOvOXczcInuRJ4xZ0x/EuZbCLWADPcziLo9g4zzhFQgjkyMJTiDY/1rIhFOZuuo3H61QqvCfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXVETHl6RW5zSmxUYk5JL0JieEIveUZlckhVMjhJK1JHbHlJWCtKL3VBWFFO?=
 =?utf-8?B?Tmp6OWY0dEJIdmxFalIrRFE3Ri93ekVPQTJhWkkzSUFKUURwYW0ya1FIdWZT?=
 =?utf-8?B?QWkwSTRWMnFrV3VWNWNWKzd0dHJ3TWFKalFpdUJOZEdoVDZxekpzSnBXSTRw?=
 =?utf-8?B?a0czcDRWdGJBMjd6VE5Rak9kVkJmdThJcm1nd2krVTJQU3F6TENOa1hNaStI?=
 =?utf-8?B?Q2liZWVsS1NGLzU2WHpWT1lSemcxZzhDbUhDN3g1VXdEVlAzdkcybFZQTWJ3?=
 =?utf-8?B?Z0c1amQwNm1OWjRPUnIwc1lvRE8vNkxjUU14UGJoYzFMV0Q1Szdxa3RrQmFy?=
 =?utf-8?B?L1JYNVdGMS9LVVlNSVVBbGh0bXlRcEgvTHdIaFVMV1N6MXNmSkE3Z0xvSE1Y?=
 =?utf-8?B?NzR0R0tWTnNJZTBWZE5FeHRET1BCSnBpZE0xN2R6TVhaYUZMWTU4cnpHSFZn?=
 =?utf-8?B?VmJWQjNDUk1uWS9wZTV5cTBHb1NLV082TTY3RStMaVpyR0ZhcEZkcmYxZUZQ?=
 =?utf-8?B?eThqVUtrVkZZTXZYRU41VDNNdm14bklyYkxEbzRVcWFScDZwL2FkMHkza2F1?=
 =?utf-8?B?VXBHdGlsTjlxWnJMelBycTRaMThSdCsvTERIK2RuQVJhTEpEWUk4VHBLTjlt?=
 =?utf-8?B?M0dtdWxSbzE5OHZMNHNOc0dsNWdsSGx3ME42cHdSS29KSThzUG92MVZtRDlL?=
 =?utf-8?B?N3lUeUgwYnpBUFJXbHBkVGpIOElsRStqSXMvcmpNMCtyWDFiWmtHcXNodFA3?=
 =?utf-8?B?cXVteDNkeStiMDBpVFVHRXFUa0lERDdFZmZKRFFIWkgzN2x1RGtJRWhDNGVJ?=
 =?utf-8?B?eWVmZUlkOW1WUW4wWWJtTjJNNXFpYytwTGxrNmV6VHJrSm94Wnp3UFB1NnI2?=
 =?utf-8?B?OXQyVGxtTVRKYXJzbWM0c29SZm5qMDBiOFBrb2VXbkdzdDNaQ3JUb09iRWJz?=
 =?utf-8?B?dnluRGxxWWlOVnpyQ2tWNS9hMkZKeDZqQzh6WGl0a3dQbXhpaTJicDZBYU85?=
 =?utf-8?B?M05Yc3JUaDNlRitzcDE5ajFsVzlFWVgzQ3U5SHFCQWIrdGl2NmFSUllTWHVk?=
 =?utf-8?B?Q3Q4MTM0SkFncjhnd015ZlpieVo1NHV4cDNjN1NQMGlZQzVsYStwZVZ0eHkr?=
 =?utf-8?B?azJJRWtERHhLdG9yS2QrL2E3b0xYcnh1THU3N203TGtYSHkxS0dIN3JiZ3di?=
 =?utf-8?B?R1BYeVBLbFNRSmVXcUhtZldRbmNFZjF3VGg2L20wb2lyV3ZDRFM3N3NUSnU5?=
 =?utf-8?B?MXVHRHhvSFNJSWxsOVhDUmlrRFpJVG95dXB6UVJldWthMmRWeEJBVkUxSXJX?=
 =?utf-8?B?amdiYlNGMmNSUU11aFJrNmVVVVJMYXZjeDF0Tmo0ZU5VaFAyeGU2NzY2WGVh?=
 =?utf-8?B?MXRaM0p2a3BSY240dDNzZkV5TWVmL3NnakR3MmUwN1Q1am5oZWxhLzBuTW9k?=
 =?utf-8?B?ZmlUWEtlVnJzdktPUWtJYjlvam93S3pFT2hZQXd2MG5aeUcvc1FsTjIzb3E5?=
 =?utf-8?B?SFV2UndKUjlObXdnbGZ1bGx1QTZhUDlvUEZIY0hvYzQyZ2hKdElkMEl2UTFK?=
 =?utf-8?B?WlBMZHdoeFplMGxrRGxFQ0R0MW1YeXBQSFVYU1pvRUNmNWdid1Y0Nm8zTVVo?=
 =?utf-8?B?em9wYUVLaGwzNk5CWU9DOXBYajA5cTV4UkFSaVk1bFZkVy9vcHpIdXFUQ0tU?=
 =?utf-8?B?ZlVHYk9qb2h5MWpZTGhGK0JKaUc3d216NEkyUHdNcStEdThWcDdSL2VhSmJw?=
 =?utf-8?B?eUpCeCs2Q3VHeEIvUCs0cS9RaU5FajhCdkdDem9nVEo5anc3RU5lTjdaYllK?=
 =?utf-8?B?WDBHUm11dlBsK2J0aWpsSTR0K1R2L2t1c1p1STZWY2FNZjVreitud29ncm44?=
 =?utf-8?B?ZzFaUU9RVzhSbm5lVzVpZm0wSnRSUHluN2FabGJaa2kzWDRQZnA2Y2hsNjZT?=
 =?utf-8?B?M1BucTJZczBXMVlacDEyVGVzMStiR2JCVk5KV0FPQ0NlWEFwTWs3enFnQVo2?=
 =?utf-8?B?YjlDdVoxZDB3dUw5Y04xa2lPVHcyNkhJSEpWZVVTeTMxNm1abEJaYTBzWGEw?=
 =?utf-8?B?cDBzU2pVV0FKNXluYTdhdXpTdSt0dmVwbUE2UEZSZW1xYm45ZDhKdk1XMmZv?=
 =?utf-8?B?STVyRlBPMnI2RklSOVAzTjZRRXVBNUZIb2pWUGFwdlpUeld3cTJRVDFOUXlF?=
 =?utf-8?B?S2tjZ2dPVWhQaWRxUXB0YTlVM2U1NGIyM3UxMVpRUUNEOUFFNXRPZTR0Wm1s?=
 =?utf-8?B?TXlDaCtOaHFHZ2Vua3V3Q0pIUXdNUm1LZnpRb2M3aTVESEtKSXJqWW1DbXk1?=
 =?utf-8?Q?jX9l8LJpUS26zU4ifT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bb0113-29ef-40d8-ecf9-08dec1c29d87
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:51:14.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtXs2DJPEkHh18hg0mBP9VvmRra9MFl93B4ipM2LrEP00DS2XE8MxOrE2f0doI+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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

--------------G4K81NyQhRs8zg3UNcTjgR7X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gerhard:

Thanks. I can build the app now. And I saw the regression. I am triaging it.

The purpose of this patch is to remap split svm ranges(head/tail) that 
were mapped with huge page mapping(pmd), but cannot be mapped in huge 
page mapping after split due to new svm ranges are not 2MB aligned. It 
seems the remap decision misses case that both head and tail ranges are 
from original range with huge page mappings were used. Will check....

Regards

Xiaogang


On 6/3/2026 12:54 AM, Gerhard Schwanzer wrote:
> [Some people who received this message don't often get email fromgeschw@pm.me. Learn why this is important athttps://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Xiaogang,
>
> Sorry, you are right. The source I uploaded was not self-contained, it still
> referenced trace_history_replay.inc from an older local replay mode.
>
> I uploaded a self-contained v2 source to the GitLab report:
>
> https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c
>
> The --upstream-ab path does not use that replay table, but the missing
> include
> obviously broke fresh builds. The v2 source embeds the table and otherwise
> preserves the same source.
>
> I re-tested this v2 source before uploading:
>
>     - clean build from only kfd_svm_split_hsa_copy-v2.c: OK
>     - ./kfd_svm_split_hsa_copy --help: OK
>     - good/workaround kernel: --upstream-ab completed 10/10 runs, no new
>       GCVM/SDMA0/protection-fault messages in the test window
>     - broken kernel: --upstream-ab reproduced the SDMA0 permission fault;
>       the first kernel fault address matched the planned split-tail page
>
> Validation summaries:
>
> https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c999439411f29dca/good-kernel-validation-summary.md
> https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd426b59edb32a9/broken-kernel-validation-summary.md
>
> The intended triage command remains:
>
>     ./kfd_svm_split_hsa_copy --upstream-ab
>
> Generic build shape is:
>
>     cc -O2 -g -Wall -Wextra -pthread \
>       -I/path/to/rocm/include -L/path/to/rocm/lib \
>       -o kfd_svm_split_hsa_copy kfd_svm_split_hsa_copy-v2.c \
>       -lhsa-runtime64
>
> If you still prefer a binary, please tell me the target runtime/distro. A
> binary built on my NixOS system is Nix-store linked and likely not
> portable to
> your test system.
>
> One more thing that would help me test any replacement fix: do you know what
> specific failure or workload 448ee453 was intended to fix? I would like to
> avoid validating only the revert side while accidentally losing the original
> fix.
>
> Thanks for catching this, and thanks for taking a look.
>
> Regards,
> Gerhard
>
>
> On 06/03/2026 Chen, Xiaogang wrote:
>
>> I cannot compile kfd_svm_split_hsa_copy.c, there is no
>> "trace_history_replay.inc".
>>
>> Or can you  send the test binary?  That should be enough to triage the
>> issue since it is a regression as you mentioned.
>>
>> Regards
>>
>> Xiaogang
>>
>> On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
>>> Hi,
>>>
>>> I would like to make sure this AMDKFD SVM regression is tracked by the
>>> Linux regression process.
>>>
>>> GitLab report:
>>>
>>>     https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>>
>>> The regression was originally reported on 2026-01-27. It was bisected
>>> to the
>>> same functional change that Alex Deucher's revert patch later targeted:
>>>
>>>     448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>>>     drm/amdkfd: Use huge page size to check split svm range alignment
>>>
>>> The affected kernel line I tested identifies the same change as:
>>>
>>>     bf2084a7b1d75d093b6a79df4c10142d49fbaa0e
>>>
>>> Alex's revert patch:
>>>
>>> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html
>>>
>>> A small C/HSA reproducer is now available in the GitLab report. It
>>> does not
>>> require PyTorch, ComfyUI, Docker, model files, or the original
>>> workload. It
>>> uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM
>>> SET_ATTR ioctls, and an HSA SDMA D2H copy.
>>>
>>> Single reproducer command, same binary on both kernels:
>>>
>>>     ./kfd_svm_split_hsa_copy --upstream-ab
>>>
>>> Same-machine A/B result on an RX 7600 XT:
>>>
>>>     448ee453/bf2084a7 active:
>>>       1/1 run faults with SDMA0 permission fault
>>>       GCVM_L2_PROTECTION_FAULT_STATUS=0x00841A51
>>>
>>>     448ee453/bf2084a7 locally reverted:
>>>       10/10 runs complete
>>>       no ROCr memory access fault
>>>       no new GCVM/SDMA0 permission fault in dmesg
>>>
>>> The bad fault page is inside the split tail and inside the SDMA copy
>>> range:
>>>
>>>     critical tail: [0x722429d61..0x722429dff]
>>>     copy pages:    [0x722429b30..0x722429d70]
>>>     fault page:    0x722429d65
>>>
>>> A full ftrace/PTE run with the same C reproducer/SVM sequence also shows:
>>>
>>>     split_tail ... current_remap=0 old_remap=1 missed=1
>>>     MISSED_REMAP_CANDIDATE split=tail
>>>     no amdgpu_vm_update_ptes covering the fault page after the marker
>>> before
>>>     the fault-side GET_ATTR
>>>
>>> The suspected code issue is that the split-tail/head remap predicate
>>> introduced
>>> by 448ee453/bf2084a7 can miss tails inside the final 512-page block.
>>> Since
>>> prange->last is inclusive, ALIGN_DOWN(prange->last, 512) is the start
>>> of the
>>> final block, not an exclusive upper bound.
>>>
>>> I also sent a short follow-up to amd-gfx with the reproducer/A-B
>>> summary and
>>> asked what original failure or workload 448ee453/bf2084a7 was intended
>>> to fix:
>>>
>>> https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html
>>>
>>> I can resend the reproducer source and summaries directly on-list if
>>> preferred.
>>>
>>> #regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>>> #regzbot monitor:
>>> https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>>
>>> Thanks,
>>> Gerhard Schwanzer
--------------G4K81NyQhRs8zg3UNcTjgR7X
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi&nbsp;<span style="white-space: pre-wrap">Gerhard:</span></p>
    <p>Thanks. I can build the app now. And I saw the regression. I am
      triaging it.</p>
    <p>The purpose of this patch is to remap split svm ranges(head/tail)
      that were mapped with huge page mapping(pmd), but cannot be mapped
      in huge page mapping after split due to new svm ranges are not 2MB
      aligned. It seems the remap decision misses case that both head
      and tail ranges are from original range with huge page mappings
      were used. Will check....</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/3/2026 12:54 AM, Gerhard Schwanzer
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me">
      <pre wrap="" class="moz-quote-pre">[Some people who received this message don't often get email from <a class="moz-txt-link-abbreviated" href="mailto:geschw@pm.me">geschw@pm.me</a>. Learn why this is important at <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]

Hi Xiaogang,

Sorry, you are right. The source I uploaded was not self-contained, it still
referenced trace_history_replay.inc from an older local replay mode.

I uploaded a self-contained v2 source to the GitLab report:

<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c">https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c</a>

The --upstream-ab path does not use that replay table, but the missing
include
obviously broke fresh builds. The v2 source embeds the table and otherwise
preserves the same source.

I re-tested this v2 source before uploading:

   - clean build from only kfd_svm_split_hsa_copy-v2.c: OK
   - ./kfd_svm_split_hsa_copy --help: OK
   - good/workaround kernel: --upstream-ab completed 10/10 runs, no new
     GCVM/SDMA0/protection-fault messages in the test window
   - broken kernel: --upstream-ab reproduced the SDMA0 permission fault;
     the first kernel fault address matched the planned split-tail page

Validation summaries:

<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c999439411f29dca/good-kernel-validation-summary.md">https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c999439411f29dca/good-kernel-validation-summary.md</a>
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd426b59edb32a9/broken-kernel-validation-summary.md">https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd426b59edb32a9/broken-kernel-validation-summary.md</a>

The intended triage command remains:

   ./kfd_svm_split_hsa_copy --upstream-ab

Generic build shape is:

   cc -O2 -g -Wall -Wextra -pthread \
     -I/path/to/rocm/include -L/path/to/rocm/lib \
     -o kfd_svm_split_hsa_copy kfd_svm_split_hsa_copy-v2.c \
     -lhsa-runtime64

If you still prefer a binary, please tell me the target runtime/distro. A
binary built on my NixOS system is Nix-store linked and likely not
portable to
your test system.

One more thing that would help me test any replacement fix: do you know what
specific failure or workload 448ee453 was intended to fix? I would like to
avoid validating only the revert side while accidentally losing the original
fix.

Thanks for catching this, and thanks for taking a look.

Regards,
Gerhard


On 06/03/2026 Chen, Xiaogang wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">I cannot compile kfd_svm_split_hsa_copy.c, there is no
&quot;trace_history_replay.inc&quot;.

Or can you  send the test binary?  That should be enough to triage the
issue since it is a regression as you mentioned.

Regards

Xiaogang

On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Hi,

I would like to make sure this AMDKFD SVM regression is tracked by the
Linux regression process.

GitLab report:

   <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/work_items/4914">https://gitlab.freedesktop.org/drm/amd/-/work_items/4914</a>

The regression was originally reported on 2026-01-27. It was bisected
to the
same functional change that Alex Deucher's revert patch later targeted:

   448ee45353ef9fb1a34f5f26eb3f48923c6f0898
   drm/amdkfd: Use huge page size to check split svm range alignment

The affected kernel line I tested identifies the same change as:

   bf2084a7b1d75d093b6a79df4c10142d49fbaa0e

Alex's revert patch:

<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html">https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html</a>

A small C/HSA reproducer is now available in the GitLab report. It
does not
require PyTorch, ComfyUI, Docker, model files, or the original
workload. It
uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM
SET_ATTR ioctls, and an HSA SDMA D2H copy.

Single reproducer command, same binary on both kernels:

   ./kfd_svm_split_hsa_copy --upstream-ab

Same-machine A/B result on an RX 7600 XT:

   448ee453/bf2084a7 active:
     1/1 run faults with SDMA0 permission fault
     GCVM_L2_PROTECTION_FAULT_STATUS=0x00841A51

   448ee453/bf2084a7 locally reverted:
     10/10 runs complete
     no ROCr memory access fault
     no new GCVM/SDMA0 permission fault in dmesg

The bad fault page is inside the split tail and inside the SDMA copy
range:

   critical tail: [0x722429d61..0x722429dff]
   copy pages:    [0x722429b30..0x722429d70]
   fault page:    0x722429d65

A full ftrace/PTE run with the same C reproducer/SVM sequence also shows:

   split_tail ... current_remap=0 old_remap=1 missed=1
   MISSED_REMAP_CANDIDATE split=tail
   no amdgpu_vm_update_ptes covering the fault page after the marker
before
   the fault-side GET_ATTR

The suspected code issue is that the split-tail/head remap predicate
introduced
by 448ee453/bf2084a7 can miss tails inside the final 512-page block.
Since
prange-&gt;last is inclusive, ALIGN_DOWN(prange-&gt;last, 512) is the start
of the
final block, not an exclusive upper bound.

I also sent a short follow-up to amd-gfx with the reproducer/A-B
summary and
asked what original failure or workload 448ee453/bf2084a7 was intended
to fix:

<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html">https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html</a>

I can resend the reproducer source and summaries directly on-list if
preferred.

#regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
#regzbot monitor:
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/work_items/4914">https://gitlab.freedesktop.org/drm/amd/-/work_items/4914</a>

Thanks,
Gerhard Schwanzer
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------G4K81NyQhRs8zg3UNcTjgR7X--
