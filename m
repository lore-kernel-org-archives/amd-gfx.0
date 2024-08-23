Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBC3C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 13:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5F310E90F;
	Fri, 23 Aug 2024 13:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oqPcXjDN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687D610E90F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 13:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUDcUmx6iebjx/x2WqNBqxhhcaN3n97ciSNNCCI8NSE0CwTI4I3+KDiV3Tro3pviBwQg+u6QyRFfVCWvUbyN39kOCLkusRufMkSw0/fLsW51+lZ7I9pU7sLB4FJ+PhIXY8FTcN6hId5MxIJmbWkB/ZM5tsziPqf0eLVwbPjWbuj70tQaH5y58ksupq7zXpUrMMnEr4B8VjgiOR3N9x+yPd+fzhgNcM5y4eOac7JeS4bUU3DZpAabXoK1lCIWr7A/WjkAz9IMrkw/jzW++67eroywhAw+JQ0QKFJdsakzWMgwzEfPPBCH9p2FgPyri1Ek+ySLBrOyYpW4IPl2mV8Aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOpjouR/4eQI9yTiJAFYTMG+CWMaP8u7jjp3Ae7GC00=;
 b=K5MAUlQViKdYug8D0RsI5wtuhBRSX3QYK8awzkAc9rh/EFkoDuv1MofpaaS/JAwJNxkfgoG1pdFYGcQecyYgQRsXrrzlPc94J3lH3rIAlMfv5KeHQABSoCyK/Bujh7HxYaNaLWxhPhD74yQVXE2B6qzHgMXHN6RVoC7u9WM4GlKP8vs3IzWh519Ahk0cpoTnfMwi8f7cN/Ojlo5i6mOEyBXfvF3V+bTbFVToahoV/nLkR86mTWQG+8vSCHmSlCngvjep9Tl7yp1Q+xXdrNbVYIFFj7yg5R9MAHXTa0LhLKNhQvlcpJ7oPD8WBZpnSI0lFVTk+4Ifz7E8n0cI4/yQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOpjouR/4eQI9yTiJAFYTMG+CWMaP8u7jjp3Ae7GC00=;
 b=oqPcXjDNv8g7JdjnsbcfScMykbCABbC76hgXA613W1kq/dtkyDOQN851bL2KKWI8sCfyYM/hKhCgWzv6RZR58M4u9d5n3C7CqKmt457ujDKeSYH4jrl2YPkfq1/hA+oqaIItobWIbI9XqT0CDtiHViuw2LyLYe0duEcf5hY9htk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 13:57:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Fri, 23 Aug 2024
 13:57:58 +0000
Message-ID: <3b75ee7a-7e8d-4274-a16d-b32e844afd5f@amd.com>
Date: Fri, 23 Aug 2024 08:58:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
References: <20240820020435.472490-1-superm1@kernel.org>
 <95874a48-3b75-44ef-9ee3-5b05d47982f3@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <95874a48-3b75-44ef-9ee3-5b05d47982f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:408:e6::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd8bf62-fc17-4a10-bc43-08dcc37b9848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3J2SFRVR1Z3VDdXWlVoeXJWMXE1SkJCK1E2NE5XQWE1SmwzK1pGcU1OTkFH?=
 =?utf-8?B?eXlZd2ljci8rVDFLbnEyeVN4a2hXdHdLd0xvdGdONjUzUG44NDBVMTBzRGxk?=
 =?utf-8?B?K1BSSWM0MHRJaXpsYmhScVFtRm5kYnlINmJSVlZnNXJoVWkwSXBNSC81SUFB?=
 =?utf-8?B?VVp3S3hiWUFWRlpGODNkOUtNWlBvL2d3Unk5WWlJS0N2eUV5UFI2eU0rNmtu?=
 =?utf-8?B?Z2JPZHhlU1g3R2hrVUFBQW0yN0ZJTWZ6U0lqdnhZcTN0d3pteUZRK05pWVdi?=
 =?utf-8?B?VTVwS05vdi9Jc2RraWFmaGZmT1M4QlJpd2NtTHBwcnB5RzBGR05vc3RNRXRw?=
 =?utf-8?B?Y2x5N1lOQlNNemdkSGhPU0FIOW5jZEQrejZ6bkptRzVlWjB6eGQ4YWQrRUtK?=
 =?utf-8?B?MkgyVUd0bTVsVVgvNUhWVlUwdnlnOWROY251UnZGOU92cGFrenhBeExFY0xJ?=
 =?utf-8?B?MVY4eDZTUXdoeEJ1d2huQ2ZKV0VoMEs3aEczcFlxb3JLU2Y0WUNBSVNpRU4w?=
 =?utf-8?B?c25DVnlBUkV3bFhsVUlQcG05QkVvZmN0b1pCQ3U1WWFUUTZnQWx0THhhVHRN?=
 =?utf-8?B?eWNPNkJBZ3pvWDZJNjZlZlJZSTZrK1BTcmtJaytIUlJ1YmNLUUE2UklBOVpn?=
 =?utf-8?B?NlJZUE13QmkyNmFzc0ZQdm5sWlh1NXh1L0VaZU10b2F2RVliMkJIdXlBN2hD?=
 =?utf-8?B?SjdnSCtqMDNXMnZNUWlLL0RUM0VBRHpGNjk2c241Y1Qwa0MzOWJvZWM3YWFr?=
 =?utf-8?B?US96d0ZVQ2tvTjdVdWFQRDU5ZUhlR3JhVEc1K0xQdnE0alFXeFVreGFFVEZr?=
 =?utf-8?B?UjhleWNkOWlFajRuVUlFZmQ0aWdPWDJya29Xa1pGZzcyNk9oNzFnV0tSbjVY?=
 =?utf-8?B?ejVOV0NqK0tOZmRLcWdld2I4aTNvKy83TkR6WjJpbWhSMjc0SFZBb0hXTTd3?=
 =?utf-8?B?UE5reER5MVBwQmdpNGhDcjc3RkprODFBWVpkTGlsU2dqVkRlVEFBK2QwY2lu?=
 =?utf-8?B?UnR2Z0RXbWJZY01DNFBrU3dtWGROMzhxTEQ2bHIwZ0RQdGw2eG96M29oQS9h?=
 =?utf-8?B?VDVQalBKTExYQjZBSEtVSGMvclFOTFZkRlIwZ1NLMmNmemxJRGtJMk9UNHBk?=
 =?utf-8?B?T3YrZThRejB3b1hCQUVoYVhBN0RncjJlUmRjZXF3UytpU1k4M2lScVp3VzRa?=
 =?utf-8?B?dHRWTldiTTc5RW9ja3pqYUFzTWJnSXZPVjdDOEpoclJvaDV4by9TQVVIQ3Fs?=
 =?utf-8?B?UTA0K28wL3F1Y1ZkdFpiL2JMaWpkbm9jZkptRlJZOWpydVAzWmFFVXhFcGlF?=
 =?utf-8?B?QWR4cm1NREdJSTRXSlNQWkFKTEhkZWJYLy9hcERGaEh6cUN0UTJsalNRcisx?=
 =?utf-8?B?UHNvd0JuVnhzRE9vS3VmSVVHejZ6ejFDQm5FcHozczQwdy9xb0lqOUZzL2U5?=
 =?utf-8?B?WGNhVFVWZGFSTFJmWE1hM1pzWFBzTldXSGcvTi9UR1VYaDBlQVZjU0pSN05S?=
 =?utf-8?B?eXArOVBRbm5ac1h1eTJOOVd2RlFoVER0OFkzNUJ5ZUNiVEVOY3ZnMWgxTnpN?=
 =?utf-8?B?b0U4bTJHSG5SazNwVWQ1aURsSmpGUjI3ZUIrSE1Ea2dMQVF1eDRXdWVXMkJp?=
 =?utf-8?B?UysvMWZFRFNHQ1Q2bG0rT3pGc0wzdFAvSWJNVS90Y1YvQ3YrQ2tmZmlldHpa?=
 =?utf-8?B?N2RMamIyOGE2M3N6WEt6cjh5TTRCWS9BL0xNM2ZGVTJmVTJoL2trNXF1ajhI?=
 =?utf-8?B?R2drMkR1ZUlKMnhlaTM0dGZsdTY2R3hJbVBIenMzZnRGSE5VQ1lqaHdmbTVC?=
 =?utf-8?B?Q2JZQUhHUk5uNEhFazJOdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdWVk5UeStCQ3EvMFpqMkYrcEdtWlllWEMzOEFCY2l1Sndza3A3NTM0a2xB?=
 =?utf-8?B?aUJlbHMxNHVWVG9TUm9BUVVOZ2h4dGZ4cXBPdlo2L3RQZlVUb2Z0MlNlNUJl?=
 =?utf-8?B?aHYxSjJzUnBLbnNLYlhzd0syWFN6QUxjSHFKSTZkZ21vaExkazg2ZFRwMHlU?=
 =?utf-8?B?MERvQ0hEaFBjRW84SVZSeDNEMjc4MWkvOFRiZ2gvcjF5K0lkRUZEaDlsMnVQ?=
 =?utf-8?B?bjJ3NTE3WEYxTTlGYUVFeUhqenhuRlFMVEN3ZDFFV2JXQTBHTDF6VHZPZjZw?=
 =?utf-8?B?cWJaYlZFWjhRY2VlKzB0Nm5WdlNJNmFHSHRrRXdiak1TcEZLMFV5SHh2VTJ4?=
 =?utf-8?B?MCtxMitWL3IyQjlia3BWam9YQ0EwZnUrcytKTytXYXozTmg3QTBBdW9NVG56?=
 =?utf-8?B?UzFzTTJQNXhvc244ZnFrQXpYSi84Tk9HWm5GZmd2bGZqL2NTSm9hTGxhZUtG?=
 =?utf-8?B?Vzk1ZzhOM1VQNE0rVHBBU2hhSUlHRUFnVWlPTENqTXY3Uit5V20yZGxUR0l0?=
 =?utf-8?B?U0dEVmsrY0VKREFDNSs0TXpaV0ljd3BtanRpNm9NY0VQQWdKV1Y4M2RmRWox?=
 =?utf-8?B?NlAzaHRxdWsxMWg1VVgreVUvNWEyaWJZY3FTTGJTelNSdmZ1TjI4bC81N1VM?=
 =?utf-8?B?VThJN3pYNnJaTzRaVFpZclFUZ0NoVnpJN1QxbFFSaThvQU81c1BXcTh6ZTJC?=
 =?utf-8?B?ZmZiRmVlQzFqNld3ZlVEeTJxQ21leVJzbU9kSlpGam9Tbzl2c1ZDN3hUcWlo?=
 =?utf-8?B?OE03eDUyYWVYb09wL2NhanB3bWJweU40YjZOckVOZFUrN0JTT3c4UG1RaFRC?=
 =?utf-8?B?dm8zV2hpU2RERittWk96SVFubWhxVVk0V3BBOUpGNlhXMkQzY0dFUjhYajFh?=
 =?utf-8?B?cUtNNDdDRVI5Z21vQ3VzVU54VitBWmJkcDFxUUNoSHk2clpZUnlRNDJPbnNH?=
 =?utf-8?B?TlV0Sml4TlhldXVjVER3dmtkZUI2SG9iNG0wSDh2OXp3OW9DUU1nR1FMZ3pB?=
 =?utf-8?B?L1E1dE5aTGl6RVlDNDI0ZmNtMkNLYzhhOGUvVHMxT256SmNjT0ZNcXowcHZv?=
 =?utf-8?B?a0tsS28vYlF2YVZTRnFCSGdxU1l3cHg5a3hxRFJDKzd4cUx5WTlMR3VteU04?=
 =?utf-8?B?UXNnSFpRVG9rKzZZM0ZSUXlhRXZkdFZOa2dXMG42ZytxeHdHTFZzb0YzVzRH?=
 =?utf-8?B?cUF2RHBPQ2JRYTkyYlJ1dUhyc3IybHhoZWdIZnZEdzhUa1EwcWZwT1A3ZXhC?=
 =?utf-8?B?MjFyWkRXQWJ5akhjQlRBL2xpR0FUdUxZbkNDRWRJaWsxdU9tMFVta2RubzJS?=
 =?utf-8?B?S3d5ZCtEanhwVmVJMDhzL3JLQ1dYenFTYmNBR3JVZVhvZVlac2RvSEJENlRv?=
 =?utf-8?B?ZmhjbXF6MGVqTjNiNTdlclhubHdBSmlMSEZrWENRZFY5Yjczd0hxck1TYTdo?=
 =?utf-8?B?OHZkVmYxWVpwYTRCNkpmRnJ5c2hyd0tscEFocXc5SU5hZitLRW9CU3dQSGl0?=
 =?utf-8?B?RVE0Y0NRV2wyNFZZZEhQSE14OEVzdXF2UUhIQ0M3SUhYVDN4dGZvdk9jY1Z1?=
 =?utf-8?B?RU13Q2Y1NVNKOXZFaTVuMFFDS3VEMlFpTVRHaHdnYjRZYW1RR2ljcHBVM2ZG?=
 =?utf-8?B?ZUwxZS9nbTFRVE56cTVXMHBmYlM1MlVZOXVyKzhEMU95WnBUNTdDQ2E0c0Jv?=
 =?utf-8?B?Z21yUU9pS1ZJc29IcDc0bkZ2TUdsM3F0NjNOMS9BZ1RmZDczS1JwYUJBMnhQ?=
 =?utf-8?B?eUZwVERtMjFZYjhOUFF1N0J5bndKNDExU3o5TTBZQmhQYzB1VDNwWTk0Q0JW?=
 =?utf-8?B?aTdLL3J0UGwxSklSYmp5SmVXWk1iMk14TlAwRUQxLzFCaHZ6RmMvQ1h2NGQw?=
 =?utf-8?B?cWdsOHNFcko3YVZhcnRvVnRNM0ZMUXgwdzAvVDJ0YzBia0hhT0NWTHpPeWJK?=
 =?utf-8?B?ckx4ZFlGYUNOdlYwMlo2dGg2bGZmaDUwRWg1UUgrVDJ6bzRqVzYyMjg2WjNN?=
 =?utf-8?B?ZHJnNVd0UmhEa25vTVVLVThoMGVsNzNDVFozaVhiVFFIdVZUbisxNldybmRP?=
 =?utf-8?B?ajdkRUIwbHozSXRldDFiZEpSTnlTM3hZRnZ3WGppeWtSdm9YK2t3MDRCbTdu?=
 =?utf-8?Q?cGodSHitkeD6HjaKUG1NM3AyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd8bf62-fc17-4a10-bc43-08dcc37b9848
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:57:58.4647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPBRZkXLYrxtCzq62h5VriYK9ryUEhyrjGLJsoOoC4LEY9LkPXEjG1kPA/AWFdhqVi8mDxnks/1WG+nVjOGrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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

On 8/23/2024 08:44, Hamza Mahfooz wrote:
> On 8/19/24 22:04, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If the dGPU is off, then reading the sysfs files with a sensor monitoring
>> application will wake it. Change the behavior to return an error when the
>> dGPU is in D3cold.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++---------------
>>   1 file changed, 45 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index c11952a4389bc..d6e38466fbb82 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
> 
> Seems like this expression is used rather often, so it might be good to
> have an inline function for it. Something like the following:
> 
> static inline bool amdgpu_is_d3cold(struct amdgpu_dev *adev)
> {
>      return adev->in_suspend || adev->in_runpm;
> }
> 

Thanks for the review.  Not only in that expression used frequently but 
also the check if it's in reset.  Considering that I'm thinking to make 
a non-inline function for every one of these like this to drop the 
boilerplate.

static bool amdgpu_attr_accessible(struct amdgpu_dev *adev)
{
	if (amdgpu_in_reset(adev))
		return false;
	if (adev->in_suspend)
		return false;
	if (adev->in_runpm)
		return false;
	return true;
}

and then each use can be:

	if (!amdgpu_attr_accessible(adev))
		return -EPERM;

>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (strncmp("battery", buf, strlen("battery")) == 0)
>> @@ -270,7 +270,7 @@ static ssize_t 
>> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -309,7 +309,7 @@ static ssize_t 
>> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (strncmp("low", buf, strlen("low")) == 0) {
>> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (adev->pm.pp_force_state_enabled)
>> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       adev->pm.pp_force_state_enabled = false;
>> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device 
>> *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device 
>> *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (count > 127 || count == 0)
>> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = kstrtou64(buf, 0, &featuremask);
>> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = amdgpu_read_mask(buf, count, &mask);
>> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = kstrtol(buf, 0, &value);
>> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = kstrtol(buf, 0, &value);
>> @@ -1424,7 +1424,7 @@ static ssize_t 
>> amdgpu_get_pp_power_profile_mode(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1463,7 +1463,7 @@ static ssize_t 
>> amdgpu_set_pp_power_profile_mode(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       tmp[0] = *(buf);
>> @@ -1517,7 +1517,7 @@ static int 
>> amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device 
>> *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (adev->flags & AMD_IS_APU)
>> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (adev->unique_id)
>> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(ddev->dev);
>> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       r = pm_runtime_get_sync(ddev->dev);
>> @@ -2227,7 +2227,7 @@ static ssize_t 
>> amdgpu_get_xgmi_plpd_policy(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
>> @@ -2250,7 +2250,7 @@ static ssize_t 
>> amdgpu_set_xgmi_plpd_policy(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = kstrtos32(buf, 0, &mode);
>> @@ -2652,7 +2652,7 @@ static ssize_t 
>> amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2684,7 +2684,7 @@ static ssize_t 
>> amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = kstrtoint(buf, 10, &value);
>> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = kstrtou32(buf, 10, &value);
>> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2817,7 +2817,7 @@ static ssize_t 
>> amdgpu_hwmon_get_fan1_input(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2881,7 +2881,7 @@ static ssize_t 
>> amdgpu_hwmon_get_fan1_target(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2912,7 +2912,7 @@ static ssize_t 
>> amdgpu_hwmon_set_fan1_target(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = kstrtou32(buf, 10, &value);
>> @@ -2956,7 +2956,7 @@ static ssize_t 
>> amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2988,7 +2988,7 @@ static ssize_t 
>> amdgpu_hwmon_set_fan1_enable(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       err = kstrtoint(buf, 10, &value);
>> @@ -3128,7 +3128,7 @@ static ssize_t 
>> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct 
>> device *dev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       if (amdgpu_sriov_vf(adev))
>> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct 
>> amdgpu_device *adev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = pm_runtime_get_sync(adev->dev);
>> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct 
>> amdgpu_device *adev,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = parse_input_od_command_lines(in_buf,
>> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct 
>> seq_file *m, void *unused)
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       r = pm_runtime_get_sync(dev->dev);
>> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct 
>> file *f, char __user *buf,
>>       if (amdgpu_in_reset(adev))
>>           return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> +    if (adev->in_suspend || adev->in_runpm)
>>           return -EPERM;
>>       ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, 
>> &smu_prv_buf_size);

