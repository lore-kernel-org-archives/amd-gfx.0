Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6FAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 13:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008F810E168;
	Wed, 22 Dec 2021 13:51:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C597110E168
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 13:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZhkt0eEB2j76GL+hNCmLG+QqNTFKerDqBXQ0K6YjMZCkw3x7gwNoogTQqh2IVyPITBItCrBtIoj0YvlboaPaXwFA6N3Q2MZhS3gL++GUmTkiJfo8zHzXgGyKrCUQyZbbSDY1+0zVOQK2Nkv0K/lopaa7nC5vFSo6XLC7IynTPWHBHoiseZBtKGqWPlhcudN3F07AJCXqn6Bgyd6ZOgIkc4nS3GfedFgwRZ3RmdzJ4FEJXvag0GOc7ULVfr9JZPBS0t4fXrWUe2/H4Tac5/VRvNLFeGkyNHRW+IaYkhwoET3eu1PVNirN78mav2fi5GRvbfutOV8RZ3OB0RnU7AcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R7+psov/LVU/ZnaKeVGZXp+nk1KNIHw+e7AFdVBU40=;
 b=PfDr8FB/bj1rMIuUMCIaME3fxa3MAcUJtx1jhFqBMxYynv7P9F01NOaHjyM8mg45YlrAtstBLTVUBx+0Brg13BmMYd+wNJHbxq2zua8HpArUaZgGM0d9FYaN/+KEfEHx7y7OKEFLiUC3AkaQh2NCrRWlN11oqBLjAx164LMxxOvvBTm8foOnmQOy5jHcNgGqebNv+iTcKm98/nmEUrMjbGP5SgOUSxVnqOHO6amhk3qsrtN7xG2TcllTLoaVf4dSIYZiOXjFgIj+9E9pNiA08Ar4Uv3TpjvvveUzWmu+QvfAvdj0xeP5m6qQGu7sj8Cd1g40SLOdzyohGSr/EE8IQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R7+psov/LVU/ZnaKeVGZXp+nk1KNIHw+e7AFdVBU40=;
 b=f1mzkPUPXSxfoM3kZIXlirfhjTo59thvxNJDv41UQ3vb+p7AHNKVK5gOQELkQg+9UwAnphTdxVHe38i7gAPtnl1EqUfSt7Bl3DmEN4mwB78gGbdPsJWMpbMjrWhlugqyOegxYQPXm0UQJBUKhizt70ayVEp99d5KYgsNJ9bgSsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 13:51:23 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 13:51:23 +0000
Message-ID: <4fa5bfaf-ac9e-1f88-e9ad-dad342e63614@amd.com>
Date: Wed, 22 Dec 2021 19:21:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V5 13/16] drm/amd/pm: relocate the power related headers
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211213035223.772700-1-evan.quan@amd.com>
 <20211213035223.772700-14-evan.quan@amd.com>
 <9520c003-0321-0d5b-ce06-e2449d52e079@amd.com>
 <DM6PR12MB2619ED055BF01FE71E8C462FE47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619ED055BF01FE71E8C462FE47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::21) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c5a163-8105-4042-fa00-08d9c55223e3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435EDB52B30CFA0F6A016D6977D9@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSHSPHjueLtVTVw4mhjCgbpbmLbpZhTT58yUXG8V9GjIHsVibRXM1rQWflbBFvKR60/l84+gPUVxDN8wR7kgzgyTEpKomlHckjzqe2/15pvxZFbygfGBBxY9HXZdufmTxFSIdySxCRshiigbCtKR2vcLtWPlUnqfpE/g6XIwysI4DTUTaweIfWOFIJg9YQ+aRMzhmIjCDqX9WbyXpy4ptBY3ikblIu9+/gSr5flEi6nTDYGU+VMw9PMUZgOT0qT2R5mEoTXtgVytf06vJiwtnW5r/NXA6LjPvdiQcheGY2YrexYU3urtALRK3yav+7QSd9BXYWN6ZP+DkCyZA4YOCi6RdUyvSyqDUG52H0eqxhdvN7fAVX7LlZmH7vEfOklBQrJWmG+2W6pmj6wFwScp8DAEO/I6r2OrrkWXC3dN1y9N7SwPUvAVTjQXsUvoJ6zSxY0Z5QCHPj8DGBGPGprp1SinRD5f++IFD/rKDJHbGgZjD+kzO/+KZJDO7vwTkPlZJZqscKGJey+lP1EdcYDJsWoT3D5PLeDS/F+3eycZgwunkIpRg4ix6JUAlYdj4Mt2FUGMEkGnCSIp+mtCnUKS7QU1Zq9bNg3AP6wLjtB96NfGfPlgi2gU4O67ALx0bBHYzGNC7QCK0Ar0sqT5RUXgpYr2tmsPK4444AeKF+GZJgjf4QMsQPy8imQzpG+lFccz5tID9pRKn0PgL3iDUES9AxgH7Yecx9QYip2p3EfK6+PuHsLGNGLXNSDU68LAKO0A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8936002)(30864003)(66476007)(36756003)(31686004)(110136005)(26005)(66556008)(66946007)(6512007)(53546011)(83380400001)(31696002)(2616005)(316002)(38100700002)(508600001)(86362001)(4326008)(6666004)(6506007)(6486002)(186003)(2906002)(8676002)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVzQ3hEMmNrdVZ4N1dkNFc1NmR5Z0RFN2hMQ2hNSi84Uzc2MlVoUFN3NzF3?=
 =?utf-8?B?WURHSXZLQUloS2xiV0Y5c3lLdWhaYnQwZ0xFd25sd0lOTFRRTnNEQnZHbHd4?=
 =?utf-8?B?NEdtNnpZS0RldlBKYWNyL3RzTVBwU0N1SFYxOUU0aU93WCtwK1FFVVZIZTJE?=
 =?utf-8?B?NTZIY3Z4NkNGbUZYRHlLZ1ZZRXZNKzRXZDNmdnVHSys0Yjdjb1A3V2h0bTBB?=
 =?utf-8?B?ZGg3Q1RSeXI1VTVpYVM3Qm5Za3o1VkJNemxXTzdlS3o0bHZiMGtvdVZUMG0w?=
 =?utf-8?B?L3Z1b1dZK2lTNWxJWE9INjB1L0lrMVJ5VVBBYW5MbGtvQzlneFYzY2dYRHBE?=
 =?utf-8?B?UHhXTXFIcWVFYStjdkVtYVRocDJCTlZ6eGVRWStLVTIrQm1PcjdiNVZoMWt2?=
 =?utf-8?B?cU1hdkxpN3ltTGp0cVM3MjdlOVZSN0N2VnZkWmdzK2g5MVJUa0psZ0hkNkJM?=
 =?utf-8?B?RFFsQ0dYQkw4dUlYcUFyQkd2c0YwS0c3WEdmTmR5dnZHSkRURVRjVVRlVFl0?=
 =?utf-8?B?K1JORkxBL2ZibDNNdVkvVGU3cmVkeFJvL2IxMm5PSm9OaXFJOUdDUjNZaVV3?=
 =?utf-8?B?YlJyVEVMb0FlSWFvL3FEYTJlMFRyYzVkL29wcnVOOTNhcWFDa1krS3RpeG1i?=
 =?utf-8?B?UHdGQWowbmxMTGxxNXNCYnNMQ0VJWlNVTitqUzNUZlBqQW92TzFOa3liU3VD?=
 =?utf-8?B?Um84ZW5RZHpKNHc3ekxzUDl6TDMyNG9lb0V3UUVrSkUrMzJBN0hKM2dOTUpQ?=
 =?utf-8?B?MXdDS1d3OEg1ZXNjUzFBR3VFTWxPVWVCNFFwSzRaSmxtcEVqQXcxK1ZSaENr?=
 =?utf-8?B?ZkpMaVJTMmNkeUxLNThVZGNheGV4bW5MQzYrUElXb1U5LzY4Z2pZUU5sQld0?=
 =?utf-8?B?MVVzQUlsU3NDcDJacHBXT3pqaC9ZS1M3YVJOVWtJeVN2TzZRUFppM0hVQ2pL?=
 =?utf-8?B?SEdibGE0VzBVVDIzNFNQL3VtYkUrbVNuSnVnNzdaQnFPdUFMVHVlcUJjRWVS?=
 =?utf-8?B?ekFMWnNCdDZ1TVpmVGMwUXJJQnlwNXNOcmJNcTRQMXlBcmNVMWdoOVBUU1Br?=
 =?utf-8?B?ZEhHQjl3Y0ZqTmJGVlpzM2hmOUJXV1YzSHR6RElEUlE3aHN5Vml6MVN3a1hP?=
 =?utf-8?B?ZzlMc3N4YXJiMWNacW5Oa3BZcDV3bEJZbHgxU09pTjVaMjlSaWVkSGJsVmRi?=
 =?utf-8?B?eEUwa0VCNnZFRXY0WDFBRU1wTlIxZVBVVDRLOWxRVUJZTmU0WnVjaElTQ3Bw?=
 =?utf-8?B?ckRCTzc2Q1VXT0w2d2Q5UG45bTZBZXpraE9HYTViejNsRGtHZGdOQ2M5cGNi?=
 =?utf-8?B?ckxNTkQ4Vm81RXYxdnBCM0ExRmJjR2xhbDBpdldyb2tOL2NmMkZ6ODBGNEV2?=
 =?utf-8?B?M2ZReit2RnJZTHFBWlVwRGNIaFNRKzRhcHZjU3I3V0kzUkxndlU5eVJNVHNE?=
 =?utf-8?B?bDFiM0EzdUI3VjU0eGpxTUF0ZE8zRTlZNFE0eC9Dek9VSWpFTUtLNkJhV2gx?=
 =?utf-8?B?b1AyUTFERzhBNUxVS25TaTZzWkIvYVNwT2Y1SnlBbzljRnJYSW5aQktVV1g5?=
 =?utf-8?B?RmFTdUVkWGU5SzdtbnpzZlN3b1V6MDZXVnJ0a1A0NXlGVVpZcS9XYitkZ05Y?=
 =?utf-8?B?eWRwaTdTdkdiYThNT0IvVnNydGt1c2dXcGRjK3lsR0FVTUxGWTlsbXF0Q1ha?=
 =?utf-8?B?YTd0cG1xRi9WcFMrcCtkQk9pc2p3UmhsM3Jib0toWitJOUdGNU1SVEU5U0Rv?=
 =?utf-8?B?U2xhY2lGeW8vcVVlV05PbVI0cnhNMC9Ka1hNc2k3M1MxY0U4Um9EdFlJS2N1?=
 =?utf-8?B?aEdJaUM4RzJEUE0zeUh5UWdObmJJN29JMlk2WXRsYlRkc2NUL0xTTS9xQnFH?=
 =?utf-8?B?TERtNnQwRUJsSkxYT2krSU04SHJMeG8vbndXWjRNZmVOaUFtY3dNeTlla1VN?=
 =?utf-8?B?MXhWTk85aHJVcHhhRzRmNEJPaTdjSHM4VXJadVoxejlickJQOStpRk1obmU1?=
 =?utf-8?B?bVNEM0IvK0JOZEphcGh1NTQxcVJxR29rWXRuclJWZ1RwdHV0VzFERS9PVmdj?=
 =?utf-8?B?U0RpU3E1OVFmTHJDVlUxQjZsM0FMdkprSzhXSXE2eUV3OFEra3dyZy9WTzRz?=
 =?utf-8?Q?pxuM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c5a163-8105-4042-fa00-08d9c55223e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 13:51:23.4236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4KrEjulaWXYo0ZXEXr86F+bsp4TPm31iVRhgUaSBYesdXDAEbhVhVNHbXaX/Ckl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/22/2021 10:53 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, December 21, 2021 2:22 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH V5 13/16] drm/amd/pm: relocate the power related
>> headers
>>
>>
>>
>> On 12/13/2021 9:22 AM, Evan Quan wrote:
>>> Instead of centralizing all headers in the same folder. Separate them
>>> into different folders and place them among those source files those
>>> who really need them.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: Id74cb4c7006327ca7ecd22daf17321e417c4aa71
>>> --
>>> v1->v2:
>>>     - create separate holders for driver_if and ppsmc headers(Lijo)
>>> ---
>>>    drivers/gpu/drm/amd/pm/Makefile               | 12 ++++---
>>>    drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    | 32
>> +++++++++++++++++++
>>>    .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |  0
>>>    .../pm/{powerplay => legacy-dpm}/legacy_dpm.c |  0
>>>    .../pm/{powerplay => legacy-dpm}/legacy_dpm.h |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |  0
>>>    .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |  0
>>>    .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |  0
>>>    .../{powerplay => legacy-dpm}/sislands_smc.h  |  0
>>>    drivers/gpu/drm/amd/pm/powerplay/Makefile     |  6 +---
>>>    .../pm/{ => powerplay}/inc/amd_powerplay.h    |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |  0
>>>    .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |  0
>>>    .../pm/{ => powerplay}/inc/hardwaremanager.h  |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |  0
>>>    .../{ => powerplay}/inc/polaris10_pwrvirus.h  |  0
>>>    .../amd/pm/{ => powerplay}/inc/power_state.h  |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |  0
>>>    .../amd/pm/{ => powerplay}/inc/pp_endian.h    |  0
>>>    .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |  0
>>>    .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |  0
>>>    .../pm/{ => powerplay}/inc/smu10_driver_if.h  |  0
>>>    .../pm/{ => powerplay}/inc/smu11_driver_if.h  |  0
>>>    .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |  0
>>>    .../pm/{ => powerplay}/inc/smu71_discrete.h   |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |  0
>>>    .../pm/{ => powerplay}/inc/smu72_discrete.h   |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |  0
>>>    .../pm/{ => powerplay}/inc/smu73_discrete.h   |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |  0
>>>    .../pm/{ => powerplay}/inc/smu74_discrete.h   |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |  0
>>>    .../pm/{ => powerplay}/inc/smu75_discrete.h   |  0
>>>    .../amd/pm/{ => powerplay}/inc/smu7_common.h  |  0
>>>    .../pm/{ => powerplay}/inc/smu7_discrete.h    |  0
>>>    .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |  0
>>>    .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |  0
>>>    .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |  0
>>>    .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |  0
>>>    .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |  0
>>>    .../pm/{ => powerplay}/inc/smu9_driver_if.h   |  0
>>>    .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |  0
>>>    .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |  0
>>>    .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |  0
>>>    .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |  0
>>>    .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |  0
>>>    .../inc/vega12/smu9_driver_if.h               |  0
>>>    .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |  0
>>>    .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |  0
>>>    .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |  0
>>>    .../inc/interface}/smu11_driver_if_arcturus.h |  0
>>>    .../smu11_driver_if_cyan_skillfish.h          |  0
>>>    .../inc/interface}/smu11_driver_if_navi10.h   |  0
>>>    .../smu11_driver_if_sienna_cichlid.h          |  0
>>>    .../inc/interface}/smu11_driver_if_vangogh.h  |  0
>>>    .../inc/interface}/smu12_driver_if.h          |  0
>>>    .../interface}/smu13_driver_if_aldebaran.h    |  0
>>>    .../interface}/smu13_driver_if_yellow_carp.h  |  0
>>>    .../inc/interface}/smu_v11_5_pmfw.h           |  0
>>>    .../inc/interface}/smu_v11_8_pmfw.h           |  0
>>>    .../inc/interface}/smu_v13_0_1_pmfw.h         |  0
>>>    .../inc/message}/aldebaran_ppsmc.h            |  0
>>>    .../inc/message}/arcturus_ppsmc.h             |  0
>>>    .../inc/message}/smu_v11_0_7_ppsmc.h          |  0
>>>    .../inc/message}/smu_v11_0_ppsmc.h            |  0
>>>    .../inc/message}/smu_v11_5_ppsmc.h            |  0
>>>    .../inc/message}/smu_v11_8_ppsmc.h            |  0
>>>    .../inc/message}/smu_v12_0_ppsmc.h            |  0
>>>    .../inc/message}/smu_v13_0_1_ppsmc.h          |  0
>>>    .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |  0
>>>    .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |  0
>>>    .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |  0
>>>    .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |  0
>>>    .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |  0
>>>    .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |  0
>>>    .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |  0
>>>    .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |  0
>>>    .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
>>>    .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
>>>    87 files changed, 41 insertions(+), 11 deletions(-)
>>>    create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-
>> dpm}/cik_dpm.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-
>> dpm}/kv_dpm.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-
>> dpm}/legacy_dpm.c (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-
>> dpm}/legacy_dpm.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-
>> dpm}/r600_dpm.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{powerplay => legacy-
>> dpm}/sislands_smc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/amd_powerplay.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/hardwaremanager.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/polaris10_pwrvirus.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/smu10_driver_if.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/smu11_driver_if.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> powerplay}/inc/vega12/smu9_driver_if.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h
>> (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu11_driver_if_arcturus.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu11_driver_if_cyan_skillfish.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu11_driver_if_navi10.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu11_driver_if_sienna_cichlid.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu11_driver_if_vangogh.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu12_driver_if.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu13_driver_if_aldebaran.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu13_driver_if_yellow_carp.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu_v11_5_pmfw.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu_v11_8_pmfw.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/interface}/smu_v13_0_1_pmfw.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/aldebaran_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/arcturus_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/smu_v11_0_7_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/smu_v11_0_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/smu_v11_5_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/smu_v11_8_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>> swsmu/inc/message}/smu_v12_0_ppsmc.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{inc =>
>>> swsmu/inc/message}/smu_v13_0_1_ppsmc.h (100%)
>>
>> I didn't mean to separate them to two different folders. Original intention
>> was to group together FW headers as 'third party component'
>> headers in a separate folder.
> [Quan, Evan] OK, if I gather all those pmfw related headers into a separate folder named "pmfw_if", does that make sense to you?
> 
Yes, that's fine.

Thanks,
Lijo

> BR
> Evan
>>
>> As another thought, 'interface' folder also looks good but for a different
>> purpose - to keep the public API headers of swsmu and powerplay
>> components to other components.
>>
>> Thanks,
>> Lijo
>>
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> swsmu}/inc/smu_11_0_cdr_table.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> swsmu}/inc/smu_v11_0_pptable.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
>>>    rename drivers/gpu/drm/amd/pm/{ =>
>> swsmu}/inc/smu_v13_0_pptable.h
>>> (100%)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/Makefile
>>> b/drivers/gpu/drm/amd/pm/Makefile index d35ffde387f1..3d17ffb77f31
>>> 100644
>>> --- a/drivers/gpu/drm/amd/pm/Makefile
>>> +++ b/drivers/gpu/drm/amd/pm/Makefile
>>> @@ -21,20 +21,24 @@
>>>    #
>>>
>>>    subdir-ccflags-y += \
>>> -		-I$(FULL_AMD_PATH)/pm/inc/  \
>>>    		-I$(FULL_AMD_PATH)/include/asic_reg  \
>>>    		-I$(FULL_AMD_PATH)/include  \
>>> +		-I$(FULL_AMD_PATH)/pm/inc/  \
>>>    		-I$(FULL_AMD_PATH)/pm/swsmu \
>>> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc \
>>> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc/interface \
>>> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc/message \
>>>    		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
>>>    		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
>>>    		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
>>> -		-I$(FULL_AMD_PATH)/pm/powerplay \
>>> +		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
>>>    		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
>>> -		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
>>> +		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
>>> +		-I$(FULL_AMD_PATH)/pm/legacy-dpm
>>>
>>>    AMD_PM_PATH = ../pm
>>>
>>> -PM_LIBS = swsmu powerplay
>>> +PM_LIBS = swsmu powerplay legacy-dpm
>>>
>>>    AMD_PM = $(addsuffix /Makefile,$(addprefix
>>> $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>>> new file mode 100644
>>> index 000000000000..baa4265d1daa
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>>> @@ -0,0 +1,32 @@
>>> +#
>>> +# Copyright 2021 Advanced Micro Devices, Inc.
>>> +#
>>> +# Permission is hereby granted, free of charge, to any person
>>> +obtaining a # copy of this software and associated documentation
>>> +files (the "Software"), # to deal in the Software without
>>> +restriction, including without limitation # the rights to use, copy,
>>> +modify, merge, publish, distribute, sublicense, # and/or sell copies
>>> +of the Software, and to permit persons to whom the # Software is
>> furnished to do so, subject to the following conditions:
>>> +#
>>> +# The above copyright notice and this permission notice shall be
>>> +included in # all copies or substantial portions of the Software.
>>> +#
>>> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND,
>>> +EXPRESS OR # IMPLIED, INCLUDING BUT NOT LIMITED TO THE
>> WARRANTIES OF
>>> +MERCHANTABILITY, # FITNESS FOR A PARTICULAR PURPOSE AND
>>> +NONINFRINGEMENT.  IN NO EVENT SHALL # THE COPYRIGHT HOLDER(S)
>> OR
>>> +AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR # OTHER LIABILITY,
>>> +WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, # ARISING
>> FROM,
>>> +OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR #
>> OTHER DEALINGS IN THE SOFTWARE.
>>> +#
>>> +
>>> +AMD_LEGACYDPM_PATH = ../pm/legacy-dpm
>>> +
>>> +LEGACYDPM_MGR-y = legacy_dpm.o
>>> +
>>> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o
>> kv_smc.o
>>> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
>>> +
>>> +AMD_LEGACYDPM_POWER = $(addprefix
>>> +$(AMD_LEGACYDPM_PATH)/,$(LEGACYDPM_MGR-y))
>>> +
>>> +AMD_POWERPLAY_FILES += $(AMD_LEGACYDPM_POWER)
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_smc.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/si_smc.c
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
>>> rename to drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/Makefile
>>> b/drivers/gpu/drm/amd/pm/powerplay/Makefile
>>> index 614d8b6a58ad..795a3624cbbf 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/Makefile
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
>>> @@ -28,11 +28,7 @@ AMD_POWERPLAY = $(addsuffix
>> /Makefile,$(addprefix
>>> $(FULL_AMD_PATH)/pm/powerplay/
>>>
>>>    include $(AMD_POWERPLAY)
>>>
>>> -POWER_MGR-y = amd_powerplay.o legacy_dpm.o
>>> -
>>> -POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
>>> -
>>> -POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
>>> +POWER_MGR-y = amd_powerplay.o
>>>
>>>    AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/hwmgr.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/power_state.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/power_state.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_debug.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/pp_debug.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_endian.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/pp_endian.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/pp_thermal.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu10.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu7.h rename to
>>> drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu71.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu72.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu73.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu74.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu75.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_common.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu7_common.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu8.h rename to
>>> drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu9.h rename to
>>> drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
>>> rename to
>> drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
>>> rename to
>> drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smumgr.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
>>> rename to
>> drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
>>> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_arcturu
>> s.
>>> h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
>>> rename to
>>>
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_arcturus.h
>>> diff --git
>>> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_cyan_s
>> kil
>>> lfish.h
>>> similarity index 100%
>>> rename from
>>> drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
>>> rename to
>>>
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_cyan_skill
>> f
>>> ish.h diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_navi10.
>> h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
>>> rename to
>>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_navi10.h
>>> diff --git
>>> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_sienna_
>> ci
>>> chlid.h
>>> similarity index 100%
>>> rename from
>>> drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>> rename to
>>>
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_sienna_ci
>> ch
>>> lid.h diff --git
>>> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_vangog
>> h.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
>>> rename to
>>>
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_vangogh.
>> h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu12_driver_if.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu12_driver_if.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_aldebar
>> an
>>> .h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
>>> rename to
>>>
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_aldebaran
>> .h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
>>>
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_yellow_
>> ca
>>> rp.h
>>> similarity index 100%
>>> rename from
>> drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
>>> rename to
>>>
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_yellow_ca
>> rp
>>> .h diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_5_pmfw.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_5_pmfw.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_8_pmfw.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_8_pmfw.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v13_0_1_pmfw.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
>>> rename to
>>> drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v13_0_1_pmfw.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/aldebaran_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/aldebaran_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/arcturus_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/arcturus_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_7_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_7_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_5_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_5_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_8_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_8_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v12_0_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v12_0_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v13_0_1_ppsmc.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>>> rename to
>> drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v13_0_1_ppsmc.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_types.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
>>> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> index a03bbd2a7aa0..1e6d76657bbb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> @@ -33,7 +33,6 @@
>>>    #include "smu11_driver_if_arcturus.h"
>>>    #include "soc15_common.h"
>>>    #include "atom.h"
>>> -#include "power_state.h"
>>>    #include "arcturus_ppt.h"
>>>    #include "smu_v11_0_pptable.h"
>>>    #include "arcturus_ppsmc.h"
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index 3c82f5455f88..cc502a35f9ef 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -33,7 +33,6 @@
>>>    #include "smu13_driver_if_aldebaran.h"
>>>    #include "soc15_common.h"
>>>    #include "atom.h"
>>> -#include "power_state.h"
>>>    #include "aldebaran_ppt.h"
>>>    #include "smu_v13_0_pptable.h"
>>>    #include "aldebaran_ppsmc.h"
>>>
