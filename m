Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB4AD75BBD
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 17:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB2510EA15;
	Thu, 21 Nov 2024 17:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQgMtguJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B77E10EA15
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 17:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyY7Yx1Kj/G5hJQZYfDY32i2Fl0OTytXmL1AJlbQpX5EPbWUB2sHQEqZtsGS8LBpYgCrlgm3BnYDOrk6x5SkFNb4gnSfna9InI9R4O7dJY1QVP7Nu3ax81e2pdutVJZ5g/snsSiB8ZCYS3dI/5KMCxtUFmrzMpIBgSWyFkfLtHNzn6vSR/vRfCxerphNERL6igpL3x7JfRQS57PMgFhHr80APeImJILCti6TX+K4719rx3HwNFNvMxntld5kyZJki6ouzjwxR2JczApPVxGZu7fsfX91671pJtwGvc6lfOBEx6phlIZnzpUhM+CNc6GPhkEp6AdfwHuKJDucCvoIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7S00IhhP5xkmiRwpaGoSahI2RGygO45ZsBSp/Q76I6w=;
 b=mQJxeDbztsg4iqH6MeIdXEj5nqj57VbD6u3RIXmcFGBLShgL2vYlRaTOzUUOSybHo5l3UTEft5bXGRjRc9rjjGd7QUY7mtwL8OI6pM8LaMcNo5x8FHgKgbb98St5+3tH4fN69Cr4jT5uoPgDQGNN92GcyeOSbLZfxqnniutYaFeSjMcmwnBbeUeI8WvPPmZkLe9TqR/4hJWsd1Ernj7/hkcuaVUwQPYIeAWY7tCYneXcetZpy4dL3hcKaXEdaRDh/FriiJFfqPnmiV5bfd31ns9fnmk/7RVA3ARaPRQ5Fq6BN6rXDbAD7dXX1odG/CAUX2yEyRmost5Hpb+IH9qFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S00IhhP5xkmiRwpaGoSahI2RGygO45ZsBSp/Q76I6w=;
 b=AQgMtguJHOdYiFlXPOHa/xpcP/M/Fq/31g33QOFIKxvVUPRS1wADG0so8g3p+WSISNuNcx6w1y2AlNP1nnq2eEXBPBTIiynZ1xekGHWt4L6Ohcf+97wLOp8JqtJLjCdR7tkeu5qet5KTBK7aQKzEAuITOL1b7TqyPFJcQ/UwLPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.27; Thu, 21 Nov 2024 17:50:05 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 17:50:04 +0000
Content-Type: multipart/alternative;
 boundary="------------llih2Dc0qQQGO6j3iVxUHq8A"
Message-ID: <13bb5e55-a4e2-4d38-a4f3-d3b2cdb39908@amd.com>
Date: Thu, 21 Nov 2024 11:50:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Differentiate logging message for driver
 oversubscription
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20241112182549.88964-1-xiaogang.chen@amd.com>
 <9776c960-4c8c-4aea-86f6-6d70f19d8476@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <9776c960-4c8c-4aea-86f6-6d70f19d8476@amd.com>
X-ClientProxiedBy: SA9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::18) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1587d5-5a35-4d4c-edd3-08dd0a54ee42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFkxN2Z2Z2lUYWhHOW1aTWNzMENSNHBLcUxsQVc0SE81RFNxa2tEa1pTRWRS?=
 =?utf-8?B?azNEU2w4SEtIS0dWSjlkVHdJUmlvNkFheEkxeVJGUXIrN2gzNjRiN2V1Q1RU?=
 =?utf-8?B?QkxPZmRsK2pUaTlKSGZoY3FCOFVIMGFUSDFxT2ppZElZbkJxVVRNYWFQNUNV?=
 =?utf-8?B?Mjh1U0ZkVDUxWjVFMFBaU1l4TGVTUW9JdllBZTNQblc2RE84MzVhSWgvTnNO?=
 =?utf-8?B?R2UwVUc0djNZS1A0UjVHdVpLems5TUs2M0E4aE5ZL08vU092bHhGME44UjUz?=
 =?utf-8?B?RnlMdC83bXMzdlU1SUZmZGxhMHFUU3NxSmU0TDBnaC9SVHlrNkJjVEJkdG95?=
 =?utf-8?B?a1V2Q29jdlN6KzdhcU90dllIWkJYN2dOaXM4aEhkVC9zM2VtT25NK1FCblR0?=
 =?utf-8?B?VCtIMUE0ZUx1R3NXUlNQN2tTdWkxZ041Wm5zNHVtOWZxZ3FlV2pWUFZ3bVo0?=
 =?utf-8?B?NTFacXZRazhIRE9uZFVlb3hCODlMNDBIT3JCRlE0S1diTG4ycVRnYW9PZndq?=
 =?utf-8?B?ZWpmMXg0eXI4MWpRVW53Z0l2TUJCalZibGJVRjRMOU5jdGg1akRSS3JXMVJD?=
 =?utf-8?B?NDBWNm9EbVFpVVBoS2kvemZTQmg2RndOQW1ZeGFOZzRTK091Q29temg0eWto?=
 =?utf-8?B?cUVmMW9LWDVFelhFZjZtYXpVK0U2K3Yrc0dvVzBBRWtQR0NzMXA1RG9Da3ox?=
 =?utf-8?B?ZHdjZlljK0h2SWhlVXNuMjlBMHA0OVhaNnFCazhjQkk3SGdiZVB0WEcvb1hr?=
 =?utf-8?B?aTI4NjJtZnFZWTFtamtiYVhuViszbFNIZXBLeGRlazlNTllFMkQ0QWp0Yit5?=
 =?utf-8?B?N0pLKzlKSWk2OTB1NFZKY1NDd0NEZTNnVDRIYmdudWVmSWpKY2VpSDZYWDlE?=
 =?utf-8?B?eDByVm5rby83aG1TUkR3b3ZUbWxyMVVDRVhudjduK1R3ZjZHUk5kUlhUZHpB?=
 =?utf-8?B?bnVVNDZwTW5JTFhHZmRZUnpFRVhrUmgxSmhraFlHK1pGMDlXRXNqeFlQRWJY?=
 =?utf-8?B?N1h2NklmZkpaRjUwem9HVUVoOU9Oa3hWN0tKUHRMZ0JXU1ZjOHVFbWFQVlRH?=
 =?utf-8?B?RE5NY2lQZ0dxdWtCcFFpNGRLQ2RxUXpOeXRNU0p5Ym1zRVBFdStmOGMra0x2?=
 =?utf-8?B?NjJpYnduTGluWlRmR3VUa0xmcHBrUWxqaVBVRElpb0oxcDBVbU5SWWlGYmVw?=
 =?utf-8?B?bmNGQ1pQcTR1LzhpdmNRTCtyNkNHOE1KZFByZ1R1Y2NiZStPVVphbVc0akZq?=
 =?utf-8?B?Sm9yMjFkR0svYitHWmpCYTBEUlFhcjVvUitUWnV6L3hGQWExd0VwOElhKzIr?=
 =?utf-8?B?cXFLc3k1dzhaK2xwbzlLeFN1M1FhQm1weGlXWXhuNXNrd1k3NEFsMWdRRzhi?=
 =?utf-8?B?SFFHZFJ0NmVXYk5hMFZhM1NrSW83eEFQT21CWU9VcU1uVHlNdTNOUmJzazcy?=
 =?utf-8?B?UHBvcm1vOEMvVlgzOU42b1dGMjBFWktpVUpVNGFwQWhlL0I3OW1Kd2VOaC93?=
 =?utf-8?B?dlNBdWxEc2E3S054N3Q3N014N0dFa0FIL3RIRUVNbHEwZnl0N1Iya0lkdmsw?=
 =?utf-8?B?M1I2ekJBeWFWSnAwRFh0eHNHdXdaRURYWnZFTTRtSWRlK21DK0kvTG1sWU9G?=
 =?utf-8?B?MnNkTDhiTzNPR29qb3RleXJnQWk5Y3g4WHFBU3h1UFFwU2orb2t5a0c0azZL?=
 =?utf-8?B?Q0puUGFmTU1LWkYwejYrVWFNTVZ0UGdGTnR1Z2Nzbm5Sb2hJWm05Q2dzZUxj?=
 =?utf-8?Q?eMwscO0o+o75HQO7D4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBwei8reWpCOXY0dnlBZnlJaXpwR2d2K2dmb1ovQU9Va1JjOWU5VDBTd1J3?=
 =?utf-8?B?WGJmRDlzZENKbWVpWWh3cEk1NENpQnl0OUhtb2xzaDVmcTJhTHpXTkQ3Z1pm?=
 =?utf-8?B?eUxKUUNSWDNRbGwwYkMzU1VvVnlubno3cldoT0J4Z054dVc2RmNSUkFxblhW?=
 =?utf-8?B?bDh1djNWL3Q2b2wwbkdBQ2dKNEFmaWxNbFg3K3VGa2hzUjRMd0RIWlVORS8w?=
 =?utf-8?B?OU5LMXpGWVRkMHNrVi9Bd0pqdlMzVXBsZEZRSmw1WmdHdnR6SEVhelNPa09L?=
 =?utf-8?B?VkRqRkJwRGszcHBDRTJ0dmRRRnN3bHo3NTNTQ1BpZmVUZ0RBekZiNDcyU3d4?=
 =?utf-8?B?dGVQU1BYZWZzWEhFTDVocjF1L0wxYlhxdlRoZGp6VDVpR0N1bFE2dUVCVmFE?=
 =?utf-8?B?U0taS0tMdFdoRlpZT2hENU9kcSs0ZS8zU2dqY1lackJ4TU00QldXb2V0b2RR?=
 =?utf-8?B?N0xTUFM4V1NHdklpUWQyWER6NVBad1ZOc1FGVXBGeTRCalA5UnAyaWU3WkRR?=
 =?utf-8?B?SWtkQnNpMTk2VFFWV3MzMjFZbTBIWUs5Q1EyV2M1bjgyRkw0Z0YxclhLaWw5?=
 =?utf-8?B?SmxyUnFoMDBzdnN2TGxDN21ZeU5XOWFUNkVMUTNoOE03UEEzVDJFU2tOalFH?=
 =?utf-8?B?Y21uVDBtSEFYTkZ3KzVjcFVadFNMUDF2OGZuRGU2TWxCN3hncnhMZEdiZ2l6?=
 =?utf-8?B?YVBUZWpqWFE2eW5yS013by9MSkhqRVBLN2MwMWNSS2lvdzlXZHNjdEhhVlZF?=
 =?utf-8?B?U3NrOThyVVNHZFlFK2NSSC9RWHlSL00xamlZTnU4SU9oZ2x6ODRCQk9wVXp6?=
 =?utf-8?B?ZmJwL05idjBPMnVpQndSMnp4MUhXb0lRU0NhK01ISFlMYWQ5ak1JWlJQWmxL?=
 =?utf-8?B?SnNDUGx0RFhTTktWRmQ2NGw4MlRHRUowSWdVMWpSRkR6WnQvb2FzelpZVnI2?=
 =?utf-8?B?MmhBYXBWQmswYzdGZ2gyK0xZY29VYVd0RitTTkQ3N2dZcVBHTU1aOHZETXRz?=
 =?utf-8?B?T0JCRGJlRElQZlJPYnRkaHVZcW5HbSs4NkJud0Jhb29XVHpnZTRXd1NnWGN4?=
 =?utf-8?B?RUkrK2FUMDQwNXJlZjZPMDhCWktlSEFzTEtrMElsajR2ajRuMVRhUWlacjBP?=
 =?utf-8?B?L3MyL0g1OXk4NGZPQTdsS3FWbjcxNU5YcS9TNFNJd2xxVGZBblcvdS8yQ2sx?=
 =?utf-8?B?NjlNL0NCVXdRdkJ6RHA3aEExMmpZVG1pbUxEMXI1enpSU2hhOW9MbGxqS2li?=
 =?utf-8?B?UzNTOHExQzFKbEJKN0J0Z0YxUVJ5LzBuMHVhZGljT2RtZFludVNCbzYyMERR?=
 =?utf-8?B?MXpnMnpWU0FlQWZHc1NHZ0NkaVVjNnBqTmxuNnNCWEZUdWFoQjg3OEpVVkM3?=
 =?utf-8?B?Z09BMWRiT2hGZUZnMUhabkttWTR3OXdrdU9YNlE2OVV2dVk5SmRRZ1lWS0d6?=
 =?utf-8?B?Z01GSUdrSUYrWStMdnoyaXByZ2t0ZkNXMEE1Vys2U3V6WUd1U0IwK1l6NVUy?=
 =?utf-8?B?MkJiOEZYSS9nbVZMOUYvRFl5U2RqS2tVVXpWVUYvUUhMdmcvRDRVRTVmeEUw?=
 =?utf-8?B?R3IxMGlMRWVUMCtzR3dyeXJ4YzNWL0NaWXNod3pTY1F0VHpPR0t2Rm1WZXpW?=
 =?utf-8?B?NUUyZVh4dUFWQXBRcHE5amdnWEZhM3NUeXV5OEI3TU5aUnE0d0g3RTZJMDN5?=
 =?utf-8?B?WDQ1SjJ0MXdLQ2gxWFdLSHNPOEV0SEhNNnVDWnpWd3B1c1R5LzA3ak5DT1NQ?=
 =?utf-8?B?RkwycmZxZlkrZldKR2FZUE5UVFlTTGkwelQrMWxJcTBsNXpyb1h2cTh3R2ZG?=
 =?utf-8?B?aXVFdnBIQS8zZitGdVA1OGd2bmc0NTVHeDhKbDNiY2h0QXpvTVpVRlJhblFD?=
 =?utf-8?B?NzR2bWtybmRuZkF2cklaZ1RVeVVHUXdaOExxOEFxbnphVk9ha3hJcVptTWVS?=
 =?utf-8?B?VDdTSzBwY3ZTbENaZTVWZHBJN1RXQnBHM1hJSklacWcreDRQRnVNblN5bzM3?=
 =?utf-8?B?OTd2S0FTRnpSb2hmbmhocDB5WXdlSlJ3WVdFcFRTR0EwVXNoTTQ2M3ZnaXhU?=
 =?utf-8?B?QTBoU2huMTB5Qno2Z3hLRnNnZS9XbnJXWGlqa3JXY3BXejNQa0UyYmdkeEgv?=
 =?utf-8?Q?obDk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1587d5-5a35-4d4c-edd3-08dd0a54ee42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 17:50:04.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiON/3wzeE73OvYadq990VRpe3VugwgPfXBR3ytkFaPmL6CrZm/DK5Al3FxMGb7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

--------------llih2Dc0qQQGO6j3iVxUHq8A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/20/2024 5:55 PM, Felix Kuehling wrote:
>
> On 2024-11-12 12:25, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> To have user better understand the causes triggering runlist oversubscription.
>> No function change.
>>
>> Signed-off-by: Xiaogang ChenXiaogang.Chen@amd.com
>> ---
>>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 44 +++++++++++++------
>>   1 file changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> index 37930629edc5..1848578dd5a9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> @@ -28,6 +28,10 @@
>>   #include "kfd_kernel_queue.h"
>>   #include "kfd_priv.h"
>>   
>> +#define OVER_SUBSCRIPTION_PROCESS_COUNT (1 << 0)
>> +#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT (1 << 1)
>> +#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT (1 << 2)
>> +
>>   static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>>   				unsigned int buffer_size_bytes)
>>   {
>> @@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>>   
>>   static void pm_calc_rlib_size(struct packet_manager *pm,
>>   				unsigned int *rlib_size,
>> -				bool *over_subscription)
>> +				int *over_subscription)
>>   {
>>   	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
>>   	unsigned int map_queue_size;
>> @@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
>>   	 * hws_max_conc_proc has been done in
>>   	 * kgd2kfd_device_init().
>>   	 */
>> -	*over_subscription = false;
>> +	*over_subscription = 0;
>>   
>>   	if (node->max_proc_per_quantum > 1)
>>   		max_proc_per_quantum = node->max_proc_per_quantum;
>>   
>> -	if ((process_count > max_proc_per_quantum) ||
>> -	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
>> -	    gws_queue_count > 1) {
>> -		*over_subscription = true;
>> +	if (process_count > max_proc_per_quantum)
>> +		*over_subscription |= OVER_SUBSCRIPTION_PROCESS_COUNT;
>> +	if (compute_queue_count > get_cp_queues_num(pm->dqm))
>> +		*over_subscription |= OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
>> +	if (gws_queue_count > 1)
>> +		*over_subscription |= OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
>> +
>> +	if (*over_subscription)
>>   		dev_dbg(dev, "Over subscribed runlist\n");
>> -	}
>>   
>>   	map_queue_size = pm->pmf->map_queues_size;
>>   	/* calculate run list ib allocation size */
>> @@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
>>   				unsigned int **rl_buffer,
>>   				uint64_t *rl_gpu_buffer,
>>   				unsigned int *rl_buffer_size,
>> -				bool *is_over_subscription)
>> +				int *is_over_subscription)
>>   {
>>   	struct kfd_node *node = pm->dqm->dev;
>>   	struct device *dev = node->adev->dev;
>> @@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>>   	struct qcm_process_device *qpd;
>>   	struct queue *q;
>>   	struct kernel_queue *kq;
>> -	bool is_over_subscription;
>> +	int is_over_subscription;
>>   
>>   	rl_wptr = retval = processes_mapped = 0;
>>   
>> @@ -212,16 +219,25 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>>   	dev_dbg(dev, "Finished map process and queues to runlist\n");
>>   
>>   	if (is_over_subscription) {
>> -		if (!pm->is_over_subscription)
>> -			dev_warn(
>> -				dev,
>> -				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
>> +		if (!pm->is_over_subscription) {
> Braces are unnecessary here.
>
>> +
>> +			dev_warn(dev, "Runlist is getting oversubscribed due to%s%s%s."
>> +				" Expect reduced ROCm performance.\n",
>> +				is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ?
>> +				" number of processes more than maximum number of processes"
>> +				" that HWS can schedule concurrently." : "",
> I'd prefer not to break string literals over multiple lines. It makes it impossible to grep the source code for error messages. I've also seen that result checkpatch errors. I'd rather take long lines. checkpatch is OK with that for long string literals. Maybe you can also make the messages more concise. Suggestions:
>
> * " too many processes."
> * " too many queues."
> * " multiple processes using cooperative launch."

oh, I did not know checkpatch allows long string literals, longer than 
80 bytes.

Thanks

Xiaogang

>
>> +				is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ?
>> +				" number of queues is more than assigned compute queues." : "",
>> +				is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ?
>> +				" cooperative launch is more than allowed." : "");
>> +
>> +		}
>>   		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>>   					*rl_gpu_addr,
>>   					alloc_size_bytes / sizeof(uint32_t),
>>   					true);
>>   	}
>> -	pm->is_over_subscription = is_over_subscription;
>> +	pm->is_over_subscription = is_over_subscription ? true : false;
> The ?-operator is unnecessary here. It's the same as the implicit conversion to bool. If you want to make it explicit, you can use
>
> 	pm->is_over_subscription = !!is_over_subscription;
>
> With these nit-picks fixed, the patch is
>
> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>
>>   
>>   	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
>>   		pr_debug("0x%2X ", rl_buffer[i]);
--------------llih2Dc0qQQGO6j3iVxUHq8A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/20/2024 5:55 PM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9776c960-4c8c-4aea-86f6-6d70f19d8476@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 2024-11-12 12:25, Xiaogang.Chen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

To have user better understand the causes triggering runlist oversubscription.
No function change.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-abbreviated" href="mailto:Xiaogang.Chen@amd.com">Xiaogang.Chen@amd.com</a>
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 37930629edc5..1848578dd5a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -28,6 +28,10 @@
 #include &quot;kfd_kernel_queue.h&quot;
 #include &quot;kfd_priv.h&quot;
 
+#define OVER_SUBSCRIPTION_PROCESS_COUNT (1 &lt;&lt; 0)
+#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT (1 &lt;&lt; 1)
+#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT (1 &lt;&lt; 2)
+
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 				unsigned int buffer_size_bytes)
 {
@@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 
 static void pm_calc_rlib_size(struct packet_manager *pm,
 				unsigned int *rlib_size,
-				bool *over_subscription)
+				int *over_subscription)
 {
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
@@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	*over_subscription = false;
+	*over_subscription = 0;
 
 	if (node-&gt;max_proc_per_quantum &gt; 1)
 		max_proc_per_quantum = node-&gt;max_proc_per_quantum;
 
-	if ((process_count &gt; max_proc_per_quantum) ||
-	    compute_queue_count &gt; get_cp_queues_num(pm-&gt;dqm) ||
-	    gws_queue_count &gt; 1) {
-		*over_subscription = true;
+	if (process_count &gt; max_proc_per_quantum)
+		*over_subscription |= OVER_SUBSCRIPTION_PROCESS_COUNT;
+	if (compute_queue_count &gt; get_cp_queues_num(pm-&gt;dqm))
+		*over_subscription |= OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
+	if (gws_queue_count &gt; 1)
+		*over_subscription |= OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+
+	if (*over_subscription)
 		dev_dbg(dev, &quot;Over subscribed runlist\n&quot;);
-	}
 
 	map_queue_size = pm-&gt;pmf-&gt;map_queues_size;
 	/* calculate run list ib allocation size */
@@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int **rl_buffer,
 				uint64_t *rl_gpu_buffer,
 				unsigned int *rl_buffer_size,
-				bool *is_over_subscription)
+				int *is_over_subscription)
 {
 	struct kfd_node *node = pm-&gt;dqm-&gt;dev;
 	struct device *dev = node-&gt;adev-&gt;dev;
@@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct kernel_queue *kq;
-	bool is_over_subscription;
+	int is_over_subscription;
 
 	rl_wptr = retval = processes_mapped = 0;
 
@@ -212,16 +219,25 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	dev_dbg(dev, &quot;Finished map process and queues to runlist\n&quot;);
 
 	if (is_over_subscription) {
-		if (!pm-&gt;is_over_subscription)
-			dev_warn(
-				dev,
-				&quot;Runlist is getting oversubscribed. Expect reduced ROCm performance.\n&quot;);
+		if (!pm-&gt;is_over_subscription) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Braces are unnecessary here.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+			dev_warn(dev, &quot;Runlist is getting oversubscribed due to%s%s%s.&quot;
+				&quot; Expect reduced ROCm performance.\n&quot;,
+				is_over_subscription &amp; OVER_SUBSCRIPTION_PROCESS_COUNT ?
+				&quot; number of processes more than maximum number of processes&quot;
+				&quot; that HWS can schedule concurrently.&quot; : &quot;&quot;,
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'd prefer not to break string literals over multiple lines. It makes it impossible to grep the source code for error messages. I've also seen that result checkpatch errors. I'd rather take long lines. checkpatch is OK with that for long string literals. Maybe you can also make the messages more concise. Suggestions:

* &quot; too many processes.&quot;
* &quot; too many queues.&quot;
* &quot; multiple processes using cooperative launch.&quot;</pre>
    </blockquote>
    <p>oh, I did not know <span style="white-space: pre-wrap">checkpatch</span>
      allows long string literals, longer than 80 bytes. <br>
    </p>
    <p>Thanks</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:9776c960-4c8c-4aea-86f6-6d70f19d8476@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+				is_over_subscription &amp; OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ?
+				&quot; number of queues is more than assigned compute queues.&quot; : &quot;&quot;,
+				is_over_subscription &amp; OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ?
+				&quot; cooperative launch is more than allowed.&quot; : &quot;&quot;);
+
+		}
 		retval = pm-&gt;pmf-&gt;runlist(pm, &amp;rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
 					true);
 	}
-	pm-&gt;is_over_subscription = is_over_subscription;
+	pm-&gt;is_over_subscription = is_over_subscription ? true : false;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The ?-operator is unnecessary here. It's the same as the implicit conversion to bool. If you want to make it explicit, you can use

	pm-&gt;is_over_subscription = !!is_over_subscription;

With these nit-picks fixed, the patch is

Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	for (i = 0; i &lt; alloc_size_bytes / sizeof(uint32_t); i++)
 		pr_debug(&quot;0x%2X &quot;, rl_buffer[i]);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------llih2Dc0qQQGO6j3iVxUHq8A--
