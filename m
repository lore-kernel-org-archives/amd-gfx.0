Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6085CF34B5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A9510E631;
	Wed, 19 Nov 2025 14:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FkRUPmq9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EE210E631
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZawjhPbIicWRj9yW6gWmbh+VoF/aDm647IV9aTeDbKKCFMz8lK8NcxEQtnGAow1AW6R2e9pl25qBjDQqNPhz2ZbFUL1BBSeyP4VY1BGAyHFWCmUgBAE1ruVv8iXSzuwL+7qugVN3vosZgCcANQg0YDVSO05K0goCcBC75ZdzqYqrnM/72RDGIEZn9tehrhcmv7+9sh0Yu0OuCJxJqipVSwiCzKLF+3ux+eBsioF5lKnVrEBCTohLr3CmSALAV72TYgE8TLvHhhw++Noha4rLturQ3ICOu6y+TA3y115Xm0XSFg6g1EmQuE2mSJd7MP94JZF4/xm09NByiFKTw2z26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaFZQbLcNW+JZItNzvCqs1dDjfxFp3Lc/tVmVpv/Uj4=;
 b=BW1EmFM4eVlO77Urphl5j1501wc3VzZcc29gOpNc1NFFPLlZ3YoIcg6MaU42YJNHNWX/eCSjd+aPsVAP2xo7RyuV/CRr6TawdMbw8kq988qWI6OgBzZ2teNK+Z+r3O0jPuiqAHb5XHv23moBmMVJnY1Aq34vaaj660hNGTHQA5Ihf5R/hLnVZwlxUp+3NguOa850C+s94PfK5pf3Ukj/ttzSsoz2K6UQSgt3oQ+ELPYd/dbnEVdNmZvpCx9YhVUDXQl6VE0LElBtsby8qn1z2L+abzvy9TeJaVGDnbaX8PDuPfbV3iBEFYqiwUxR5abujp52r9AVG4huLYpVMDtM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaFZQbLcNW+JZItNzvCqs1dDjfxFp3Lc/tVmVpv/Uj4=;
 b=FkRUPmq9XJMnCmqFddnzO6ueM8doX9SFafQcHt3JbZuCbpQLYurvwviaITXe42Xgy35KrRnnmG5++UdmFNKLttdUKkrRTxEPocMG9oDEkZvsQcigpXtyCBU+GbWh+S16vr5POyba0FulWd/waH7v/MOV2FZ7a9C2Q83z0ue04SQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:14:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 14:14:09 +0000
Message-ID: <0d435963-799f-46cb-805c-3dfd739bdec0@amd.com>
Date: Wed, 19 Nov 2025 15:14:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu
 is reloaded
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <superm1@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20251119002348.4118647-1-siqueira@igalia.com>
 <20251119002348.4118647-2-siqueira@igalia.com>
 <462b1556-264b-4ee8-afb9-e5e0869192f0@amd.com>
 <CADnq5_PvUGYZiHr3572cqeQxCHTNFkDodaZDbmOg02tMV=vuPw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PvUGYZiHr3572cqeQxCHTNFkDodaZDbmOg02tMV=vuPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef58348-b835-4629-de0c-08de2775e7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVh6bXdjL2xtbUx6QTFiNzRWQWhENTBnZmRJc1psR0Z3RVozWmVvRVFzQkNs?=
 =?utf-8?B?SmdYNEJyTTIycnBkQURkb0J2RGJBR1ppRXB6QkFMODE4ZVBtMXl2aUZ0ZHI2?=
 =?utf-8?B?dVZWUUNuRm1oUU9mWW9HNVAwanZmbnB1TDBxYVh0emIwOVBJUkVUODcxdFdp?=
 =?utf-8?B?OEFiWmNWckFhM1BnQnlJeVg5eDMvTlhZNW9VYUlsQU8zT1hmMzhvZDJXYkwr?=
 =?utf-8?B?M3QyY09Ud0V3ZjFJL3VIQXJoand2elhGUkY4ek5VdFAxa0pHZ3lWck1qZGRi?=
 =?utf-8?B?M2RVUWRUSVpXeVRnZ05vRndYOE9SUUd3eUd2NjljZXJPYW51ejBCLzgzaUFE?=
 =?utf-8?B?bHdXREVrQmhZQ2Nvc29NdVJXSjBHVllGMi9PL3RDNC9ub2VPSDhKQmw0cDk0?=
 =?utf-8?B?ZXdtdU5QcWRjbFd2emxIK2sySmdlcDlyMXlJa29NZ2RYbVBOY0FDcjZPWFM1?=
 =?utf-8?B?aFJCRlVjUkRuMER1bTJFdzMrWkVhZlhCb0d3MzM5SW9yVHNaY1NkNDZjbFRy?=
 =?utf-8?B?V2hLNmtDeU9ETFk2OU40TkVmU3ZMUGlQWmRGK3RySzdHTEd4Z2ZqYzRYUnJJ?=
 =?utf-8?B?ZGRkWEw4VTNQMVN6c2svcVQ1WFdCR3duZWZKSkR4a0JFa05heFRkSUhNTlhN?=
 =?utf-8?B?WDUzMFZ1TkpCcXMyWG1rNitrb3RyYUVtSHh5SFhtN3M5RSthM055eWVDa091?=
 =?utf-8?B?YlNtZ3ZzT0NhWjBsSEkwV0NWR0ZRTStocHJBLy9tcHlLWThjUWhxZDBPeTJD?=
 =?utf-8?B?SENRMHd6Q1hFTGhseEZHWk92NjZMOG1OWUFaY1p2c0tpc2thOG9BQlljN3d3?=
 =?utf-8?B?RjlCUmNzVjBzRnJlYVNRU1NCRTZrZ3pmakhDeUFXbXNQNU0rUWpyUlZzN2p1?=
 =?utf-8?B?a3h0V0daTksycEY3OGZrSkNmZHVXUkZ0Mkp1UWJMMFhpUkYzVmhJcWt1Y0Mw?=
 =?utf-8?B?Q29Tc0g5Ykg2WlBTbkJRNFhybmFzWHhXdHZxZ2k2eXZXdC9kWUx0WjFHenor?=
 =?utf-8?B?azNFNjFrdTJRdWEybmhIYlNaK29hQWFOQmxhR2JmZitGYjU1bWFRRHRBNnBL?=
 =?utf-8?B?WmpENTFkbUVydDMyUzRjTlBLcmZXNm5ibTBhY1NrU0FBcHUyZG1pREh2QlYw?=
 =?utf-8?B?YmNLbldWRVVNUFlNaDl3aVdhbHJzQTQrbWlkNDRUL1lNNU56NXo3RHUvV0Fn?=
 =?utf-8?B?b2lVaTI3VnczU3JZU24xdnMvaG1aWXBaeVNwQnE4aDA3aXErQ1E5R0dUZUU4?=
 =?utf-8?B?Wkw1ZmFyWDNMT3ZGdExVMkFXWVhuSE1Jb1VKT2JISU51enpDcTV5dDZOT3E2?=
 =?utf-8?B?VkowcTNjTnJQQUR0Y0ZDa0NPZkdiay9Pb3V2VG9KTnE3K3NpR21xb0lmVXYw?=
 =?utf-8?B?MDYzQVltM1ZsbUZKeU1RVkdncGRCMUdXYlRpc2M3SGFJVzFkMUJVRU0rQlRX?=
 =?utf-8?B?dVlnU0hMcDdNQnQrQ3JlZHF1OXIrL05xUzEvZjU4RHVUVVlKSjZFUTdWaWMr?=
 =?utf-8?B?ejFpczB1QjRMVmY4MDZsUlRnYzlSUTFZbHV1R28yMnRvbW5oQU1TVlpYZGwr?=
 =?utf-8?B?YVhsS24vUVU3cUJBK2lEbnFkUW9JUUlEL0V3dEVVTHlHRk5FTncwV2RMNHJL?=
 =?utf-8?B?MExrNzVRbzhhZmhaYnNsWGhSZTRycHQ2ZnpwOTdxd0MrdVhZSEJwcmFoUW51?=
 =?utf-8?B?eGdvNkpYWXYvRWJxNXVmdVVPZGRBY0NOZThzVlgwRXdGOXMvVlV4WlFnK1h6?=
 =?utf-8?B?YVQ0REdITytla3RnamxNSnI3WnhzcFQ2azBtWGFJUXNtb1ErakdqcVVJQ1hq?=
 =?utf-8?B?cHBEbXhUVy9tNFpOZEtnR0dXOGxwVXVKdWRaSXpzZGVqM0pIekVFWURQeXd4?=
 =?utf-8?B?WFRjbUNYMnBrdzJJLzVOVkUxbTBET1UzY3NSUklIV21OTkdWWkx3aTY5VlZa?=
 =?utf-8?Q?dSUGfe0AWIFYH1i+ekvH223C5ZG9T4Y/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulc1U0VIM2lWSmRsdVhoUUU2N1liejZWTU9jU3FKWCt4OWgwSWpFK0hubE5v?=
 =?utf-8?B?Sk1HdW8rVEFJMEl4djNaMFFmUnQwTkVXeDlKeUhtUi9SNnpMQVRIYTExME1L?=
 =?utf-8?B?TFNJeHpmb1VBUkNkZ2UvQTdGMFdqdEI5Y1dTZzVNcUtRSURRVVY5WWMzaGFp?=
 =?utf-8?B?bHNnWCsvRW5xOTNKcTNEQXFUVFFtMmJ3SDZUNm9yb3NEVEVPQzlZNklLUisz?=
 =?utf-8?B?RmFoYjRISHVpR0J6NFh1WldudXFsTEhIckhDUU5BWldYUWFuZ2ZZVXN2Mkto?=
 =?utf-8?B?SURqY2ZHTEhtUXYzQVcwOEhTMklKWXBlc0swYnRoVm5oVmxiMS9iU0prZVA2?=
 =?utf-8?B?dTZXdHBxZDZrdVNQNlZrZEptaXNheHQrUnAzQVhhQlNEUWxKRU04TFBITGdK?=
 =?utf-8?B?MHY0VTk3b0I4c2s0RHpqUW1ZaHVudjFaUTJ0bFg2R0ltWkFLOWpLSUZvb3BH?=
 =?utf-8?B?alc3THNZODlwV3VDeDdtYUthQklhQlovRzR6dm44VWl2L1pDQzFDMlhEaXhs?=
 =?utf-8?B?elk3UXNQUDRHazV0cTcyU1Y4OU5Wa3pKWWdXVGRiWk1EeWN3dzBwNkZlYUdE?=
 =?utf-8?B?NExqbXlxaHFsSVY5MFZmWjBIMFdseW4wTWlBRDYwZ3NxdCtSTkIxVkxHL3VO?=
 =?utf-8?B?a1VwSFhpaGdxTHhRT2NnYnhiM0hlaVNRcVdkaUJMTHlYRCtINXNjeDZhWXZF?=
 =?utf-8?B?c09UdXE1NWtLYWlCbDd3NUZSaFFJZXRDVmFuTGx0WVoxM3JqZVd3eUJ6bGlO?=
 =?utf-8?B?ZGpZWU1OU1htbnUyZ1NvLzFsQ3QydjZGcGIvYU1qVkh5ekZOMnFyWmxJWVBa?=
 =?utf-8?B?UkJrK253dWZWM28zM2E4b2kyWndmaHVNY0E4NDFGeHl2TzVydC96UitOTmQ1?=
 =?utf-8?B?MHVWS3ZudlhKdDdMUVFrQlRDV1I1YWZncHBvY0tPeE5HM3lkMlU5VWIyWDgv?=
 =?utf-8?B?WjdNa0xYTHo5dkQvL1VBRk9YVEs2TlRlYUtUaVcyVUl0MTU0Y3o3U3JrYWhp?=
 =?utf-8?B?WExBY3A5SDRZK0tsZDhVYjFqb2FyWWIvUnJBOUNZNlNBUVk4RkxPOGZaZjBx?=
 =?utf-8?B?dC9uc0JETThRTUVZS3ZsZHBaT0xzZ29RMnBhOEYrU29qMmRRZ2gzaDlKRGhh?=
 =?utf-8?B?QnhqaWxpYWdJUjBwbThoZkdSbWQxL3JkWERlS0k0SEVDK2JJdUJEMVBob0JH?=
 =?utf-8?B?Q3N0L0plQ0I5bmNrOHpZUUJGeUF4SlJrTzNrRWVURkx5TGZFY2VoZ0dQbnlq?=
 =?utf-8?B?dE1LbEVBb3pNa09CcTJxZGdjWnR5cHExUi9EZWxERk5NTDhTUXlBdEltZWRW?=
 =?utf-8?B?blRBUkc2NzB6RjZuR3VsNXE1N1lIVVl5eEVjeHhydlV3anp2dGwrYi9HTzFT?=
 =?utf-8?B?dTBkZGVMTUM0dFBQVCtWSDd5U0hma2M2VktiTXRBSWdSSS9IV3RSczNOMnlS?=
 =?utf-8?B?NWZCSUVCM2hOZHhYbm91Smk0VTRWeTF3RjFUbkZ4RTYxY0Ztcm5UcnBoaDRM?=
 =?utf-8?B?aHY5bTIrRUE3SVFMN05VT3E4M2xEdHpjWFpjQ09ETlQ2bzVBNDF5TUlMbXVp?=
 =?utf-8?B?OWUrV1gyL3MyWDNUZjQ0ZTlBSjR5TzhNVHJtaTRSK1grNEQzc2R6cVQrVFBs?=
 =?utf-8?B?ZWczSlZJRUFOWnN3NGNUSE1OSUh2YkF6UFVBN2lnL1pVWE15VWRCQ2F1bDBK?=
 =?utf-8?B?dFJlaXpBRW9KTFcwL2kxQ296Qkx3aUp2ckY4T0tRUDczeU9OSFpOOWFhdWEr?=
 =?utf-8?B?aVdMcHVVL0RDR1NzcHFNYTJnZjlkWDFwN1FUbGs3eTd5RFdpc3dmSGdoc3Uw?=
 =?utf-8?B?Z1Fudmd3aCtGaGx6WVRmNy8xVzZKbXNFNTI1ZzMrVG1KVWpJOUJqQTBkRERZ?=
 =?utf-8?B?REhRc1FrOXU4cW9FdGFyTkN1VXROOXo1SjNGZVUzSHpGb2Noa3Nzak82cHZ1?=
 =?utf-8?B?ME1hQmg3azdHQ0VVRDk0VE5kVWdZYUxZQzlKbDhFRHhEeERXOENuR2JCL2JP?=
 =?utf-8?B?aHdkV205OGxTb0VyZkk0bTVyeXprK2Q2WTFNSm9ieHhGR1Z1Qy82Z2Vibk9C?=
 =?utf-8?B?dnRqVHNJMmJOMWN4MEpseUN2TDNUZmV4MnJWRVUyOS9QUFB2aUFXbkFLc0ox?=
 =?utf-8?Q?zg/N8DEibwqZbdFUPer9JBWwI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef58348-b835-4629-de0c-08de2775e7e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:14:09.1390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghAl7U3613RdQPkQItaE0tJT2Oa1Pu5V6IN6AZKNEc1WfXBYIaBFd7tnzcFDjQc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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



On 11/19/25 15:00, Alex Deucher wrote:
> On Wed, Nov 19, 2025 at 4:29 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>
>>
>> On 11/19/25 01:22, Rodrigo Siqueira wrote:
>>> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
>>> set of errors happens and the system gets unstable:
>>>
>>> [..]
>>>  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>>>  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
>>>  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
>>> [..]
>>>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>>>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>>>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>>>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>>> [..]
>>>
>>> When the driver initializes the GPU, the PSP validates all the firmware
>>> loaded, and after that, it is not possible to load any other firmware
>>> unless the device is reset. What is happening in the load/unload
>>> situation is that PSP halts the GC engine because it suspects that
>>> something is amiss. To address this issue, this commit ensures that the
>>> GPU is reset (mode 2 reset) in the unload sequence.
>>
>> Mhm doing that on unload sounds like a bad idea to me.
>>
>> We should rather do that on re-load to also cover the case of aborted VMs for example.
> 
> That's what we already do for dGPUs, but for APUs, there's not really
> a good way to detect this case on startup.  On dGPUs we check to see
> if the PSP is running, on APUs the PSP is always running because it's
> shared with the whole SoC.  Always resetting on init is not desirable
> as it adds latency and causes screen flicker.

Ah! Good point, we need the reasoning that the PSP is always running on APUs as code comment here.

With that done looks fine to me as well.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 860ac1f9e35d..80d00475bc9f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3680,6 +3680,15 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>>>                               "failed to release exclusive mode on fini\n");
>>>       }
>>>
>>> +     /* Reset the device before entirely removing it to avoid load issues
>>> +      * caused by firmware validation.
>>> +      */
>>> +     if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
>>> +             r = amdgpu_asic_reset(adev);
>>> +             if (r)
>>> +                     dev_err(adev->dev, "asic reset on %s failed\n", __func__);
>>> +     }
>>> +
>>>       return 0;
>>>  }
>>>
>>

