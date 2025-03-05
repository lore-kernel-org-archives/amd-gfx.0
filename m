Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C96C282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 03:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCD510E3F7;
	Wed,  5 Mar 2025 03:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37iWKHH4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46A910E07F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 03:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXsWKMYaBt/ETYGEvaFOePnm2ghsxqJ2kxWYpgn/Xs7ctzAw4NF1wbW+UI6tWxxYGUmZRWE/E+/8ZhFBQ4qLVe1L26rE6HcHPyPEsAwlE9VjEgeimFTMwT90n8EpUokLKBi5BO9T+E8BYFjT+ThLJBkvSu5/5OdvsLgMoe+mWWzQZdWLq/47wLNgbF50gf2ye51hqobG4+yfF0w+d126kmcxdTe++XkDzWrdBozyvCuOmPqGANu9O2v191GZcstA4cZrZQHrDLU1y/W4HG/GEmf+Z4Om66VXMVZN36iyOP8MSOeHFHA55SvMKKy1Q0wvzbzklDSuoJ75hRbfxvIhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmuJzy+YKxOLMdrfn77foDzFpzFCRZn8E7WUIia9Grs=;
 b=ZxF/WAdhg4jJeWhC5gkhs8RENzQivDSFU7CINTEPQb9RHc77cjk8uPLPA/eMzBP+MlFOvGbtebW6+0j9juYz0uw0eZ8M6qUTDOv9YtoQJbmOD/AkeILl8NFwieMBQs6N7CLlN6kmP9aqX7/20gitvjlEPSDoG3kQK9UjOpk84nZuuGZhupGfE/zjd1Tf46cDZGstbZLhK+sP20htPvlKvqkHaXsUsYhFrABEVjWUE6dBzLOq4LjwpAXm/eAEBtEC4ml40ryOb57tSksZemu59siWQYR8Ui1PXtyOQhdm9HConEr5hoSNN6K/tHKp0xsBPlvKIElFqKMkc43c1EjgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmuJzy+YKxOLMdrfn77foDzFpzFCRZn8E7WUIia9Grs=;
 b=37iWKHH4HXhfgWfyfLYC7gqAPXzhG6HIDAJQLr7WtjdM+pCfvOoyvWDeMwLOHfRj70HjICXdxQy27e2cxa5CHtViOFaEHQwLm6z5aFkif9rieAH0cJj5oB39qjfIIcP+c46sM5pr0YNf/h7mmwZJOqdPk+AImoFrGuhKAkSH+qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 03:11:14 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%3]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 03:11:14 +0000
Message-ID: <7daf0e03-29be-486b-94b5-5cb77af3b892@amd.com>
Date: Wed, 5 Mar 2025 11:11:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: initialize svm lists at where they are defined
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250221092355.336312-1-lingshan.zhu@amd.com>
 <c0fd1f01-ed4f-494d-8e9e-ae092a6ef1e1@amd.com>
 <13836d37-3f09-4278-8599-ee8f3886e255@amd.com>
 <ea0821ce-11f0-4747-951e-2b9e8a35e549@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <ea0821ce-11f0-4747-951e-2b9e8a35e549@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 14784767-f096-41c0-193e-08dd5b93633f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUY3UXRBcGNUNmU1cXpHd0pJekp2dHVqMUZnRDJjc1V2TmFIRm5iM2ZNc0Q3?=
 =?utf-8?B?TTVlZU1sbE4rMnluRTBOZURHRCtqa0ZuaGdpV3Y4RGRKTHlVc0hkNFQ3SmI4?=
 =?utf-8?B?RXZGYmYwWHVZNnFtczdmcElyQ05jSVRONGQ4cE5Hd2dxcWllM3ljajZ1N1Mr?=
 =?utf-8?B?S2xtYzUvU3pSd25MenBrdlNXK2RVODJpVSttZEtCWERrOG44bWFkbmdKSTN6?=
 =?utf-8?B?WG1YQmo4d1E2V1dxaGM0UkhtVXZFYVJzTkg5QThXYUZ1ZHV2L3lmNDIrV0FD?=
 =?utf-8?B?Y2l1MDdjckkyMU5mNm8rUmpBRi9FU2hncExIb1BQTzJqbnhNWTRkQ0R1ZlVD?=
 =?utf-8?B?M2VYcitON1ZkS1VUUGxudnVsTzJWcWV4RlF5REdJaERsd3pYRkpYc1dNdFpB?=
 =?utf-8?B?elF0ZnlPRnVVbER5U3VOOE1mZFltNG4xdW5vRDMwK2txaHVaNFR3WFplbkxN?=
 =?utf-8?B?ZlNBSU00dlJsWjJONVlGRFZHZnJPQllIdFdiMVZiWjlGQ3YzRmtRQWNaS0ho?=
 =?utf-8?B?c2xJYjRTeWlYTE16blJ5Und3ZzBsNW5wMmRLZm9JL2N2NnpnaDNFd3J3d1dD?=
 =?utf-8?B?b2dPOWhPdFB0ZjVDYkFCWUhUQjZHTXZzcVhtek42bUR3Y3k4QStmQVVYVUNr?=
 =?utf-8?B?V29LVkZYN1VzMnNlT0hRNW5qclZyVzRkVlVnZml4Sjh1TGVqaTdMZldxNG10?=
 =?utf-8?B?WEthL09IOUJOMGJkVVVPZUx4U2doQ1FjSGVXNjhJMEx5NWlTV3FZckV4SXFQ?=
 =?utf-8?B?aGpCRXdtN1hicHNBVXRwekRyMUJ6VXVLeVdCMURvYXZNL2VYVm1YYkE0ZVpE?=
 =?utf-8?B?d0Z0aXFJTnlVL3NCZzRXRmZNQW5oNGhtME42SUJIWlVHV0gzckUrR3JSU3ZE?=
 =?utf-8?B?a1JRWk5SN2ZmYVpsVEE2Y2pTeGJCdi9ndzljYlVkM2J3YUovM1FZRXhKQ0pj?=
 =?utf-8?B?eHFienA1TjdzK3o1aWpvMXVQNEJZa1Q1bURtRkVkb3Fra3FlUXJZSFlkbjFI?=
 =?utf-8?B?ZlJJU2EwOENmcFE2RU9OMHo4OUtLVy9sV2h2YzhZQ1RYcy9YY0dwVklZUHEr?=
 =?utf-8?B?ZUZGb1ZxSjU3cHZHTU1pcWFIcG9qMTZMbzNQYzNoSldVeWdmM2tXbkxXdFJU?=
 =?utf-8?B?UVlXaWtVbWMza1BHTEN3cllBSEQ2OCtWaUIxUlpZVERZbmczL2c2NHhkOWJS?=
 =?utf-8?B?RTltUHN5UWRYWC9QNWo3RjgvaHJFZmtaUlp4cCtXS2VYdEFQM1BiT1cvd3hM?=
 =?utf-8?B?SWZKeWN6TmhNWjZiT01mU010OEEvN1dRajBTOHFueU9malZUWXA4VVVpK21U?=
 =?utf-8?B?ZXNBQTVONFVHNUxWTkZPVUl4RGNHTk5Pd1V4bjNkRWhDNnJURE1aOWlRZU8r?=
 =?utf-8?B?UUxKVkV6NFhFeFUyWnlrN2NRR3ppVlZ4YWhSK1NuZkZiZ0EwdTd0OTdFR0tx?=
 =?utf-8?B?S0V1ZnROeVB2OWJXbGkvTTE0TWYweGtQU2pBTm9HZ3ZoYS9FNGZXbTkzMEdv?=
 =?utf-8?B?cTNCRjNHNlFGejl2MmxnWVJMaVZVWmlBUlY3NkgrOHVTdThodlBaVkFJNjJs?=
 =?utf-8?B?MFFEaU5iYTIydDVnY0ZjajMrNlJuOFBQWXVRZE5WUms0OFkyelB1Q2VmOG5h?=
 =?utf-8?B?SVI4N0w1bzV2aFNNM0xIV2VXaXIwRnk4T0lJVWNPWFVsdkRaem1MTjE2ZG5Y?=
 =?utf-8?B?cnRPbTB4S0tNUzJKdTIwMnM2MTQ1ZGtmUDB3QmNwb2x2T0lCM3ozZ0ZLVHRJ?=
 =?utf-8?B?OFVFSWFJTG5HMFljYlZicEJsVW80M2NZdFpHNnd5Z2o2YStLakhIOStkZFdq?=
 =?utf-8?B?NEVtRHlEeHNMTEIybkFaNGNBditHY25GUmtzZjdyaEkvOEc5YmNnQThYZFhE?=
 =?utf-8?Q?iZMTGUcjtKipL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9RSjdlM3RGOVhCOFQxM05OMGZVWm5kQ21IVncvUjlRanRmYUpMYUJJUnNq?=
 =?utf-8?B?WGdmUmRnK3Z5UzdJbFZjekxXTDF0TWt3UGNlSTNCTE5pQnZ3cFAzckJQdjgx?=
 =?utf-8?B?aEpuVWdQbUNXUGJnellsRXVZa3pqcUZ6cENyTFRRazZ3RWw1TS8wbUxQMUlQ?=
 =?utf-8?B?bW9aeHdoK2s0QktrajBNQzJUMUVscXZzUklnTUxMbVZIZVpvdUxxUVh5OXJD?=
 =?utf-8?B?ZFVVS21oOVVqRTJIRCt0Qmx4MWpEZHhnUkVyWmFjZENvSk5xME5rMEFtM050?=
 =?utf-8?B?cUVPWllicE1DSGxMWG1zNWRUT0pLMU5JaGs4WkM4Y2l2bnZsUllUTXV1N0Vr?=
 =?utf-8?B?Nlo0WGFyUkxBNEM3a0ZVUnFtYlpBM01zei82OCs4VzFvUktHTlZuOUFpMGtS?=
 =?utf-8?B?MlNldzI3WmVZcUp3ZldQdUxYL0ZEUm4yOGgyQUkvcjVBRmdqNnpKZTQwWVhz?=
 =?utf-8?B?Q3lXckdGM2g5WEFEZmJQTWRXZEpiU1NhUHIwTDBOSWVsRy90d2VoZzB1aThk?=
 =?utf-8?B?bXJJVnJGdkY4cHZXWDJwM3RKdTdNczlPTktXYUNMazA1ZTJRd2pUcmdPYXJB?=
 =?utf-8?B?UENpemJXaVVvbW00U20xV3h4VDR3WWo4M2ZTTzh6T3lxUHByVzM3NTFkV2x6?=
 =?utf-8?B?SjZiM2JQNlI4Mlg3R3dHWDNWbjdXV1FjTkgvWm15NHZ1WHNLeHlObkdLTWpR?=
 =?utf-8?B?MzhTd3NMaGNSVm1sQUQ0ZlRBT1lCVktmNDRIYVdiQlBHaDNIendOV3FUZHhl?=
 =?utf-8?B?RWJaYTdBZE55MlhZZnFVR1lMWlMyRnVrZkpaRUxFOEd0bW1ISDBIbVVUN0Er?=
 =?utf-8?B?MXBuRmgxb1V4ZndoV2ZobW1MazJaRVlJL3VVTEVwcEQ2MmcxOEJYclY3cCtt?=
 =?utf-8?B?VjVzSjFZM1AxeUxHdkowMjgzWXBQclljQldjTCtMTWd1eU1BM2lZc2YwOUpF?=
 =?utf-8?B?alU1N25qS3VCYVo2OUpoSlZEQkRETVphRkZSdWUzeUM3RzBNUGZYV2hmcjBk?=
 =?utf-8?B?cHlGQWk3eGthUnMwV3M5VHhGU2NBc0RTTTFvQ3RtL2FFeHhOMmgvRi9nL1NR?=
 =?utf-8?B?d05YWTlLUVFua3Bnc2dWYnVYa3Q3UnU5cHdkUGl6RmhlN1VnKzZ4SVJiNytW?=
 =?utf-8?B?NXBmQ2NMV012d0k4c3ZHd1IrbVpBZnRiVVU5N3FBTnFRVTI0ZEVNN2NUbmFn?=
 =?utf-8?B?eStyRnpnc05mOVNYSGhMMUEvSWtYWEtUMlBkb3J0bVBvaHdtUTFFZWVhOUpa?=
 =?utf-8?B?OUowcWhCQUg4N3dYMUtjQjlnNFZpc083K0w5Q3RyWUVIaFVuOEZ1aStVVGg1?=
 =?utf-8?B?Wlh1a3JRVzFHMGt2cnhxMS9VS2pUY3hLRzBINnN5bGF5U2lHYlAwMnNpTUhD?=
 =?utf-8?B?VmsyMFU0ZHBYYjArOTNnK0U0K3VXTlBoOUl6MTZhQXdUOXJqWUg2QjBZNlhy?=
 =?utf-8?B?Zk9kYVl5Y00xZmovamFVbWV1RTdaa0VGN3pjWmJFZWV6bWlTS1hyV0hxQk81?=
 =?utf-8?B?ajduOEtqT3BneFFkVVlxV0xZdEZQVmRPRld3T0VpU0V6WHIxRGwwdjBTMHQ5?=
 =?utf-8?B?Yk5PMkIrbFh2L0dsNnBqUUcrVmIzTXNIZmpMZ0U5QW1tOTdrN3Y2Y3RqZy9N?=
 =?utf-8?B?dmRjQUg3RDl4MXk2eUhQZG11RC93UVlabDFBQkVUM1JXTzk3VXZmYnVWWk1P?=
 =?utf-8?B?b0V4MU1rS2xGQ1o0ZXlqT1R2TVJENVRZc2lIcE1MMVRLQ0xHUXkwbzB3U1VU?=
 =?utf-8?B?Q1dYNk5YZVdRM0ZZVjdhMnJKMFlEalBLNThNYWVyWGQrcm9Mdld6UGxFckxO?=
 =?utf-8?B?enBHenFxS244WW1DdTZQenFGVHB3QUMweWlLSlhhRy9WRU5yK1VhRERUaEpu?=
 =?utf-8?B?WXJPT3E0bncrUUNsVjg4NXc2ZkxWT1VnRHQ4bEo3Njd3NjlGOEVmOFJPZU5Q?=
 =?utf-8?B?R2xhSDNpdWtKMlN0QXhvVE84d1lCVWthK3lWK0xLUzhDMm5MVndQKzJsK0dL?=
 =?utf-8?B?blFDUHhaMlo2MHlNNUxHMiswd2F2Q0JhcmR1ZFdyUUtISXBwQjNUOHUzc3Rl?=
 =?utf-8?B?Y3J2dHRIdWVOMUtVbGZoY2MzRllya2w3S3BVSEk1dC9WdEtEWVpVL2NUUmp6?=
 =?utf-8?Q?LY6L9zD6ie/xNDTTQjTdraD54?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14784767-f096-41c0-193e-08dd5b93633f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:11:14.2038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBjeP9po6LAaLmO/1t9g1/s/493snl9Tv9SVm2Xd0q4hXPVSACUCKGgjIpmBAmyVBr0qujLkHOzqjV1zDZeoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

On 3/4/2025 11:16 PM, Felix Kuehling wrote:
> On 2025-03-04 2:40, Zhu Lingshan wrote:
>> On 3/4/2025 1:49 PM, Felix Kuehling wrote:
>>> On 2025-02-21 4:23, Zhu Lingshan wrote:
>>>> This commit initialized svm lists at where they are
>>>> defined. This is defensive programing for security
>>>> and consistency.
>>>>
>>>> Initalizing variables ensures that their states are
>>>> always valid, avoiding issues caused by
>>>> uninitialized variables that could lead to
>>>> unpredictable behaviros.
>>> The lists are clearly documented as output parameters in the svm_range_add function definition. I think it's more readable to do the list initialization in svm_range_add to keep the logic of the caller more readable. One suggestion inline that would move the initialization to the caller without cluttering the calling function's code.
>>>
>>>
>>>> And we should not assume the callee would always
>>>> initialize them
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index bd3e20d981e0..cbc997449379 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>>  
>>>>  	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>>>>  
>>>> -	INIT_LIST_HEAD(update_list);
>>>> -	INIT_LIST_HEAD(insert_list);
>>>> -	INIT_LIST_HEAD(remove_list);
>>>>  	INIT_LIST_HEAD(&new_list);
>>>> -	INIT_LIST_HEAD(remap_list);
>>>>  
>>>>  	node = interval_tree_iter_first(&svms->objects, start, last);
>>>>  	while (node) {
>>>> @@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>>  	if (r)
>>>>  		return r;
>>>>  
>>>> +	INIT_LIST_HEAD(&update_list);
>>>> +	INIT_LIST_HEAD(&insert_list);
>>>> +	INIT_LIST_HEAD(&remove_list);
>>>> +	INIT_LIST_HEAD(&remap_list);
>>>> +
>>> You could initialize these where they are defined by replacing the struct list_head ... definitions with
>>>
>>> 	LIST_HEAD(update_list);
>>> 	LIST_HEAD(insert_list);
>> Yes, this is better, I will use LIST_HEAD and remove the initialization in  svm_range_add because we don't need to init them twice
>>
>> By the way, I am not sure the lists are "output parameters", usually an output parameter should carry some information for other functions,
>> but here the lists are just defined, even not initialized, and are on the stack. Actually the callee only fills the lists and the caller itself use
>> the lists. I suggest to remove the "output parameters" in the code comments.
> Input parameters send information from the caller to the called function. Output parameters return information to the caller. In this case the lists are that returned information. Therefore I think calling the list heads output parameters is perfectly valid.
>
> In fact, I could turn your argument on its head: If you move the initialization to the caller, you now rely on that initialization in the callee, which may be a problem if the caller forgets to initialize the list. In then end, it's just a matter of calling conventions. It doesn't really matter where the list heads are initialized as long as they are initialized in one place. In this case the function in question is a static function that's used exactly once. So there is really no point overthinking it.
>
> I'll give you two options: Leave the code as is, or move the list initialization to the definition as I suggested. I will not accept a change that "fixes" this non-issue at the expense of code readability. I disagree with branding this as a security issue in the commit message.
I think it is just a simple issue of passing uninitialized variables  to a callee.
Yes currently the callee initialized them, works perfect now.

However, IMHO, I am not sure we can guarantee there is only one callee work on theses lists and every callee not forget to init them, most of the time the callees assume the input parameters are properly initialized and can use them safely, lets try not breaking this assumption by initializing them at where they are defined. This change actually provides better readability.

Accessing uninitialized and random memory address can lead to unpredictable behaviors, for example overwriting others data or kernel panic. Therefore this is a security issue, but I agree not worthy mention security in the commit messages.

Thanks
Lingshan
>
> Regards,
>   Felix
>
>
>> Thanks
>> Lingshan
>>> 	...
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>  	svms = &p->svms;
>>>>  
>>>>  	mutex_lock(&process_info->lock);

