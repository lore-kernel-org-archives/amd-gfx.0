Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7F4EEAA41
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 13:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8202110E288;
	Thu, 14 Sep 2023 13:38:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E406110E27F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkl/LZTcUMVtt55vev1SXN6Cs5DTlzPur5I0VpKyQxKDRB4OTsu3K1H1pU4kCUtIG/+IryJZF4hm4YW7G1iLkdyvq9QWCHknMVR/ltuervRXKFar9vwNlqAt6qc4WdK0AYlPZjzr71anVrDpO2165B9/w+l3jaluk63gF5O8V9fnL72tEIpQbBhJ+SsMjHKudPOiUCOJ8K6oprCQ5vEB1NtXIaGPE+uMxAKRBPuiR90LRP5rfgVG3YzcUjVYS3Vt8l45poDJXXh2y42crwT0ri/nxVUTJ/gExCJ15CA6k0vviLdw2TSRf9DEBe01q3BJscxUdNBUrnS+gmVikEYMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG+OcJPB2jz6W644ZpQuoI7UghyOGOcr9MedwjNDcKM=;
 b=Nj3WXcbbd4wyCjI9tcbeA9g1UihyCW15Fv4uPIXg1HMwbj+/sLDH+h1OTQfKbQZCnJ38i3511CZA2DIa01xT6Fa7C5Vpmu0XGgJUO6Lojkd5TbG6aXPOvxv929Xp9wulStv3wdNiAi9GReL2Xl+D6JJGUknGOgqUAeKmnOfu2N5JzJgpAUsxSMLBL5NRXT578w3M/QpCkyE8MVLM+dpXz7huPUQ/g8SXMu12E8skItrGicGo/tresKFAT6AbgNPwDZvDAsq8V20NyGJohKabQFNjJDCJsHGpeEdl6qN50cTHNIA+B2DIksBGebtuJotcJ0iRCGF9yeiYZ3hjoNS3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG+OcJPB2jz6W644ZpQuoI7UghyOGOcr9MedwjNDcKM=;
 b=QA9AnC6rEmbWBgRtoMEjy8h0dYEWhNLw/YNZ4f54xmFpJqhmlRWLAA5hmVYgyPHx7T3WSFEWadh8BupsYULa71EUz7lgKSVYY1hPWIj+9SqMttcR9jit+6cbFJ4FLtlVMIgBGvJYYybfd8uXBaTuhhX6j4Pz2jm9J5Jl0AGg9ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 13:37:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 13:37:59 +0000
Content-Type: multipart/alternative;
 boundary="------------0m1T7HYw0TPx00znvnhuDQ9r"
Message-ID: <c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com>
Date: Thu, 14 Sep 2023 09:37:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
 <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
 <59d9927d-5216-e2fa-22cd-205e4a35ebaa@amd.com>
 <DM4PR12MB516507AC620DD2812610C11287F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com>
X-ClientProxiedBy: YQBPR0101CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: eaedf239-5186-4b40-9f38-08dbb527cf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqiTf+yu4jVKO+OIJx2e/95OLUKNhD+xsSuWPs0n80narysnOxf9C1kaMeziXoKuiEvJ78zFmFh0EsBBiu6W+EodNoWxwD3+8w4kekpmRbpSBrZaOlDry7MdveGewR1RA0X41oNOGNANorir8AViRE5oYk2qZAc1vlvuCi/QUnvjyWAPb2ms9XrrsQcQNjaIc/m42ofAeyhKPRjbxEg2AGeGGXzTG0Ge3o1EEv3VAS9yjrZQtdffFjDrDtZBmdvjfSV0ll5s8NVCFmq9SCgEEoMFNpHgw5ft2xCC7yb1IfyeRuWcDMukUWyukglzgjij2+YeG9kOF7a7xOYj77dFA48NTMGRpY7pIP2FMDCxrF0kTydk6OHgs8HJOhPFdfhxt85E99KYNXbcxp6Sb5/xeXIfvcutKSz3rrJxyN0dGiIyuRvK4fi9cx5R7oV20fAOd0x4WMZNqLd2MEa30Z2BzZiirz1LSf5ARUNxOEjmm+yBLS5fCum7E/05KHaGzcjacanBDCa6pBU0q8ItWbdWZZkl1Degv8foXMw6LTWYtnzY7lMlXK4R8D0K4XGlTGPnT5jMWfs+2J17qYODJQsg6y3lB9dX9bJeHEH/ybQKzVwnfIkGY9nDe90cbe3r7uFKKWCPtuLJ0O1Tnq8cZoSOoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(6486002)(2906002)(6512007)(6666004)(86362001)(2616005)(33964004)(31696002)(6506007)(478600001)(53546011)(26005)(36756003)(224303003)(38100700002)(66574015)(83380400001)(41300700001)(4326008)(8936002)(5660300002)(110136005)(31686004)(316002)(30864003)(66476007)(44832011)(66556008)(15650500001)(54906003)(66946007)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdwcUNMYk1GTytOVEsvV29sNXRqN3VvckpBYTdVck1SdHRkUEVNUXNFNTlt?=
 =?utf-8?B?c0ZjNHFwRklZY1lqOGoyRVovdWhnSlA4am8vTmNyTG1KdDhuUkZldWdyZWNP?=
 =?utf-8?B?S2s4Vi9SU3F4SURNWDFRa3dsTTZYMXUrMXQ1b2tkd0RZaWcxNDZpTCtvemFM?=
 =?utf-8?B?UlRHeS9mS01oQUJSMHlWU2kzVGF3b0FvNlJGSVF3LzdSZWhXWm9DZXNFQWdq?=
 =?utf-8?B?elB3ZnJ4R2h3OWxjeEVPcjhRSEt1Z2tSclNPbXp0bjNkdGVTM0Z5TmI5MFpw?=
 =?utf-8?B?a0MyTzM3VHZON0xrWjRkcWFZdzlWMktjZS9ESFlZeWN6ZHBoTnNvNWtRdDll?=
 =?utf-8?B?TVVmU2JwMER5SEtNMGw4bzNQY212dzBIaXBaK0lEaHBycHFYR0E0NkJ5UE1u?=
 =?utf-8?B?bmh0MExYQzYrcGo5NHV6amlwMW5BdTYwRlMwczNoYVNGWXRuK0NPaWJFZ09p?=
 =?utf-8?B?SUVvRGE4V3lQS3RVY1k1MDA4QWVMSHJPSDJOK29TeG5acEVjSmk5Um5lc04w?=
 =?utf-8?B?N25BVmh3aG1uUWdDVEd0Q0xBRk9hZXM3WFdpU2JYdC9QYndCY2xjaUJRdllW?=
 =?utf-8?B?UUtqQlYvSDJwdnZDR1lsQkJyZ3lJeUV1V3FrTVlNQnovQk5rV0ptallHS1dV?=
 =?utf-8?B?elJmYVVYdGM4UjNaYzVsQ0ZkblVDSTJ4VjZxZlc5MkR3dmZCUVZUUm9sQksv?=
 =?utf-8?B?ZjRpYlY3TTBZWFhCQ3NhME1FMlVYMzZIOGtNOWVNZDg2ekpVT2M2NStad2Fz?=
 =?utf-8?B?bStTNzB5WERhVDI3Rk4vaHZ4Y0k4bit1R3ZqbmxLaHViQlM0WVhvL1kxL0Ju?=
 =?utf-8?B?amxGN0xwQnhTN253V2l6N0ZxV0RjaGhFV0Z5WExBUWtZeEpvQUs1emlXaWs2?=
 =?utf-8?B?ZUlJMWt4cXNrbUphL204eFExRTRsWWxaYWZ3cWFOcVQxbm5iTWU1Qk51ZlNJ?=
 =?utf-8?B?UWdkVUtDajFpR0JvZUtrOE1mVnorWlhVSlZsL3ZUZlhtaXdmZXFjclBJNTgz?=
 =?utf-8?B?MS9wajJoK0xSMHlURTZyS3Z1bUdpYy9ma2NVeGhIVExaRzQ4VGhtL0dCZy9u?=
 =?utf-8?B?VXc1STRSdDZJbmt4WUplc3QyZWFyVi9Vek5JMU81U3NBdDhQVnBUTm16QXY1?=
 =?utf-8?B?NEhUWjQ2VTZQZ3QrN3hJdzBNb0VCZVB3V0xxUFdnTy9Xd1N2Z0FjSys5NVFQ?=
 =?utf-8?B?a0N4bmVCR2NpRjA4ZXlrMHhnWGxVV0g5WUtLRDQxb1NOT2VVbEdDNmFJRUZn?=
 =?utf-8?B?RjRZa2Nzdmgvb1NrdldHUlhFL3lsM2NucDIwODRaaEFoZ21RTlNiNTlHd1Rp?=
 =?utf-8?B?V2xNdFhudlVvUkVpZHdDQU0xNHNPNmlJTDZ6QnhGeHMvbGUxR2pxWUtqVktU?=
 =?utf-8?B?c20ya1pnVUVsQU9wNU5UUjZ4dElTU2pudHlPWGNTditIK2pMR3JGSmJzejEy?=
 =?utf-8?B?Sk94d3JTNDJReDlremd0NDhiVndwcHRPWFZTaVNnMWs5M2RCbHcyVjF4Qks1?=
 =?utf-8?B?YnUzSi9xcFFCYjhiU2NXYWw4RHFLUVRodWtGVHdoa0NiQjlUS0tpcHBUM0o0?=
 =?utf-8?B?c1NnYVBRZUNNNmNKa2krb0tVZU1ub2pHRzdRK0VBTEcrNUV4K25hdDRuNUdB?=
 =?utf-8?B?RmhTMHlpM082NnhmWlZaRTNBS3FXeENjRkNRNGJ0TlJtUDVxRVdmQUFiRFlt?=
 =?utf-8?B?aDhoQ2tuOTNhMGxLYUx6NHFXTDMwbVViM21qQTg4dUJERU9TRkplaFdEQmJz?=
 =?utf-8?B?Yjc4dDRGK1JRcWRSNzJsSzJGUXp0dll0Nmh2QlZzb2twWklhTEZyTFFTSklB?=
 =?utf-8?B?ZFlpRTA1TmF1Y1R5UFRFVFZETVJqN2poVWlEYmIyNC9PSEg5NlllYzJLUmc0?=
 =?utf-8?B?V3ZRcDlIS1NTa0tpeU1qVWZiZkExZFdXUDhzZlV0N3BST2VsSUR2aHExZE9K?=
 =?utf-8?B?ME91UHV6RHlITDJqUG5kRitEY3VZQlV3N1pia0YyR3laa24rWWYzcDlEY0Vr?=
 =?utf-8?B?a0VoWERVb29LbDI5UVIzbFVwWCtWeEx0amVvUTRLRDU3WVZhZkpOQ0J4VWMv?=
 =?utf-8?B?Ty9LNG1hdzYvQXJzRThVSjFlTUR3UDdySzFmWTZYZFFyR2J0alUvaklNZ3Nj?=
 =?utf-8?Q?djWfMk3r/TUXBmbmPajg1MxYE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaedf239-5186-4b40-9f38-08dbb527cf63
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:37:59.4969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxJbXjZK0gw37oOetozv3PG9EtiTqk136c7m7yN7P3sfMia+nWChcQj4nh9chZAN5XSJt4QS2YH6Q1IVE96wZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Fan,
 Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------0m1T7HYw0TPx00znvnhuDQ9r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Userptr and SVM restore work is scheduled to the system WQ with 
schedule_delayed_work. See amdgpu_amdkfd_evict_userptr and 
svm_range_evict. This would need to use queue_delayed_work with the 
system_freezable_wq.

BO restoration is scheduled with queue_delayed_work on our own 
kfd_restore_wq that was allocated with alloc_ordered_workqueue. This 
would need to add the WQ_FREEZABLE flag when we create the wq in 
kfd_process_create_wq.

There is also evict_process_worker scheduled with schedule_delayed_work, 
which handles stopping of user mode queues, signaling of eviction fences 
and scheduling of restore work when BOs are evicted. I think that should 
not be freezable because it's needed to signal the eviction fences to 
allow suspend to evict BOs.

To make sure I'm not misunderstanding, I assume that freezing a 
freezable workqueue flushes work items in progress and prevents 
execution of more work until it is unfrozen. I assume work items are not 
frozen in the middle of execution, because that would not solve the problem.

Regards,
   Felix


On 2023-09-14 2:23, Christian König wrote:
> [putting Harry on BCC, sorry for the noise]
>
> Yeah, that is clearly a bug in the KFD.
>
> During the second eviction the hw should already be disabled, so we 
> don't have any SDMA or similar to evict BOs any more and can only copy 
> them with the CPU.
>
> @Felix what workqueue do you guys use for the restore work? I've just 
> double checked and on the system workqueues you explicitly need to 
> specify that stuff is freezable. E.g. use system_freezable_wq instead 
> of system_wq.
>
> Alternatively as Xinhui mentioned it might be necessary to flush all 
> restore work before the first eviction phase or we have the chance 
> that BOs are moved back into VRAM again.
>
> Regards,
> Christian.
>
> Am 14.09.23 um 03:54 schrieb Pan, Xinhui:
>>
>> [AMD Official Use Only - General]
>>
>>
>> I just make one debug patch to show busy BO’s alloc-trace when the 
>> eviction fails in suspend.
>>
>> And dmesg log attached.
>>
>> Looks like they are just kfd user Bos and locked by evict/restore work.
>>
>> So in kfd suspend callback, it really need to flush the evict/restore 
>> work before HW fini as it do now.
>>
>> That is why the first very early eviction fails and the second 
>> eviction succeed.
>>
>> Thanks
>>
>> xinhui
>>
>> *From:* Pan, Xinhui
>> *Sent:* Thursday, September 14, 2023 8:02 AM
>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com>; Christian König 
>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; 
>> Wentland, Harry <Harry.Wentland@amd.com>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
>> <Shikang.Fan@amd.com>
>> *Subject:* RE: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
>> during suspend
>>
>> Chris,
>>
>> I can dump these busy BOs with their alloc/free stack later today.
>>
>> BTW, the two evictions and the kfd suspend are all called before 
>> hw_fini. IOW, between phase 1 and phase 2. SDMA is turned only in 
>> phase2. So current code works fine maybe.
>>
>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>> *Sent:* Wednesday, September 13, 2023 10:29 PM
>> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Christian König 
>> <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; 
>> amd-gfx@lists.freedesktop.org; Wentland, Harry <Harry.Wentland@amd.com>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
>> <Shikang.Fan@amd.com>
>> *Subject:* Re: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
>> during suspend
>>
>> [+Harry]
>>
>> Am 13.09.23 um 15:54 schrieb Felix Kuehling:
>>
>>     On 2023-09-13 4:07, Christian König wrote:
>>
>>         [+Fleix]
>>
>>         Well that looks like quite a serious bug.
>>
>>         If I'm not completely mistaken the KFD work item tries to
>>         restore the process by moving BOs into memory even after the
>>         suspend freeze. Normally work items are frozen together with
>>         the user space processes unless explicitly marked as not
>>         freezable.
>>
>>         That this causes problem during the first eviction phase is
>>         just the tip of the iceberg here. If a BO is moved into
>>         invisible memory during this we wouldn't be able to get it
>>         out of that in the second phase because SDMA and hw is
>>         already turned off.
>>
>>         @Felix any idea how that can happen? Have you guys marked a
>>         work item / work queue as not freezable?
>>
>>     We don't set anything to non-freezable in KFD.
>>
>>     Regards,
>>       Felix
>>
>>         Or maybe the display guys?
>>
>>
>> Do you guys in the display do any delayed update in a work item which 
>> is marked as not-freezable?
>>
>> Otherwise I have absolutely no idea what's going on here.
>>
>> Thanks,
>> Christian.
>>
>>
>>         @Xinhui please investigate what work item that is and where
>>         that is coming from. Something like "if (adev->in_suspend)
>>         dump_stack();" in the right place should probably do it.
>>
>>         Thanks,
>>         Christian.
>>
>>         Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>>
>>             [AMD Official Use Only - General]
>>
>>             I notice that only user space process are frozen on my
>>             side.  kthread and workqueue  keeps running. Maybe some
>>             kernel configs are not enabled.
>>
>>             I made one module which just prints something like i++
>>             with mutex lock both in workqueue and kthread. I paste
>>             some logs below.
>>
>>             [438619.696196] XH: 14 from workqueue
>>
>>             [438619.700193] XH: 15 from kthread
>>
>>             [438620.394335] PM: suspend entry (deep)
>>
>>             [438620.399619] Filesystems sync: 0.001 seconds
>>
>>             [438620.403887] PM: Preparing system for sleep (deep)
>>
>>             [438620.409299] Freezing user space processes
>>
>>             [438620.414862] Freezing user space processes completed
>>             (elapsed 0.001 seconds)
>>
>>             [438620.421881] OOM killer disabled.
>>
>>             [438620.425197] Freezing remaining freezable tasks
>>
>>             [438620.430890] Freezing remaining freezable tasks
>>             completed (elapsed 0.001 seconds)
>>
>>             [438620.438348] PM: Suspending system (deep)
>>
>>             .....
>>
>>             [438623.746038] PM: suspend of devices complete after
>>             3303.137 msecs
>>
>>             [438623.752125] PM: start suspend of devices complete
>>             after 3309.713 msecs
>>
>>             [438623.758722] PM: suspend debug: Waiting for 5 second(s).
>>
>>             [438623.792166] XH: 22 from kthread
>>
>>             [438623.824140] XH: 23 from workqueue
>>
>>             So BOs definitely can be in use during suspend.
>>
>>             Even if kthread or workqueue can be stopped with one
>>             special kernel config. I think suspend can only stop the
>>             workqueue with its callback finish.
>>
>>             otherwise something like below makes things crazy.
>>
>>             LOCK BO
>>
>>             do something
>>
>>             -> schedule or wait, anycode might sleep. Stopped by
>>             suspend now? no, i think.
>>
>>             UNLOCK BO
>>
>>             I do tests  with  cmds below.
>>
>>             echo devices  > /sys/power/pm_test
>>
>>             echo 0  > /sys/power/pm_async
>>
>>             echo 1  > /sys/power/pm_print_times
>>
>>             echo 1 > /sys/power/pm_debug_messages
>>
>>             echo 1 > /sys/module/amdgpu/parameters/debug_evictions
>>
>>             ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
>>
>>             pm-suspend
>>
>>             thanks
>>
>>             xinhui
>>
>>             ------------------------------------------------------------------------
>>
>>             *发件人:*Christian König <ckoenig.leichtzumerken@gmail.com>
>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>             *发送时间:*2023年9月12日17:01
>>             *收件人:*Pan, Xinhui <Xinhui.Pan@amd.com>
>>             <mailto:Xinhui.Pan@amd.com>;
>>             amd-gfx@lists.freedesktop.org
>>             <amd-gfx@lists.freedesktop.org>
>>             <mailto:amd-gfx@lists.freedesktop.org>
>>             *抄送:*Deucher, Alexander <Alexander.Deucher@amd.com>
>>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>>             <Christian.Koenig@amd.com>
>>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>>             *主题:*Re: [PATCH] drm/amdgpu: Ignore first evction failure
>>             during suspend
>>
>>             When amdgpu_device_suspend() is called processes should
>>             be frozen
>>             already. In other words KFD queues etc... should already
>>             be idle.
>>
>>             So when the eviction fails here we missed something
>>             previously and that
>>             in turn can cause tons amount of problems.
>>
>>             So ignoring those errors is most likely not a good idea
>>             at all.
>>
>>             Regards,
>>             Christian.
>>
>>             Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
>>             > [AMD Official Use Only - General]
>>             >
>>             > Oh yep, Pinned BO is moved to other LRU list, So
>>             eviction fails because of other reason.
>>             > I will change the comments in the patch.
>>             > The problem is eviction fails as many reasons, say, BO
>>             is locked.
>>             > ASAIK, kfd will stop the queues and flush some
>>             evict/restore work in its suspend callback. SO the first
>>             eviction before kfd callback likely fails.
>>             >
>>             > -----Original Message-----
>>             > From: Christian König
>>             <ckoenig.leichtzumerken@gmail.com>
>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>             > Sent: Friday, September 8, 2023 2:49 PM
>>             > To: Pan, Xinhui <Xinhui.Pan@amd.com>
>>             <mailto:Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>>             > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>>             <Christian.Koenig@amd.com>
>>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>>             > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction
>>             failure during suspend
>>             >
>>             > Am 08.09.23 um 05:39 schrieb xinhui pan:
>>             >> Some BOs might be pinned. So the first eviction's
>>             failure will abort
>>             >> the suspend sequence. These pinned BOs will be unpined
>>             afterwards
>>             >> during suspend.
>>             > That doesn't make much sense since pinned BOs don't
>>             cause eviction failure here.
>>             >
>>             > What exactly is the error code you see?
>>             >
>>             > Christian.
>>             >
>>             >> Actaully it has evicted most BOs, so that should stil
>>             work fine in
>>             >> sriov full access mode.
>>             >>
>>             >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra
>>             evict_resource call
>>             >> during device_suspend.")
>>             >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>             <mailto:xinhui.pan@amd.com>
>>             >> ---
>>             >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>>             >>    1 file changed, 5 insertions(+), 4 deletions(-)
>>             >>
>>             >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>             >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>             >> index 5c0e2b766026..39af526cdbbe 100644
>>             >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>             >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>             >> @@ -4148,10 +4148,11 @@ int
>>             amdgpu_device_suspend(struct drm_device
>>             >> *dev, bool fbcon)
>>             >>
>>             >>        adev->in_suspend = true;
>>             >>
>>             >> -     /* Evict the majority of BOs before grabbing the
>>             full access */
>>             >> -     r = amdgpu_device_evict_resources(adev);
>>             >> -     if (r)
>>             >> -             return r;
>>             >> +     /* Try to evict the majority of BOs before
>>             grabbing the full access
>>             >> +      * Ignore the ret val at first place as we will
>>             unpin some BOs if any
>>             >> +      * afterwards.
>>             >> +      */
>>             >> + (void)amdgpu_device_evict_resources(adev);
>>             >>
>>             >>        if (amdgpu_sriov_vf(adev)) {
>>             >> amdgpu_virt_fini_data_exchange(adev);
>>
>
--------------0m1T7HYw0TPx00znvnhuDQ9r
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Userptr and SVM restore work is scheduled to the system WQ with
      schedule_delayed_work. See amdgpu_amdkfd_evict_userptr and
      svm_range_evict. This would need to use queue_delayed_work with
      the system_freezable_wq.<br>
    </p>
    <p>BO restoration is scheduled with queue_delayed_work on our own
      kfd_restore_wq that was allocated with alloc_ordered_workqueue.
      This would need to add the WQ_FREEZABLE flag when we create the wq
      in kfd_process_create_wq.<br>
    </p>
    <p>There is also evict_process_worker scheduled with
      schedule_delayed_work, which handles stopping of user mode queues,
      signaling of eviction fences and scheduling of restore work when
      BOs are evicted. I think that should not be freezable because it's
      needed to signal the eviction fences to allow suspend to evict
      BOs.<br>
    </p>
    <p>To make sure I'm not misunderstanding, I assume that freezing a
      freezable workqueue flushes work items in progress and prevents
      execution of more work until it is unfrozen. I assume work items
      are not frozen in the middle of execution, because that would not
      solve the problem.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-14 2:23, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com">
      
      [putting Harry on BCC, sorry for the noise]<br>
      <br>
      Yeah, that is clearly a bug in the KFD.<br>
      <br>
      During the second eviction the hw should already be disabled, so
      we don't have any SDMA or similar to evict BOs any more and can
      only copy them with the CPU.<br>
      <br>
      @Felix what workqueue do you guys use for the restore work? I've
      just double checked and on the system workqueues you explicitly
      need to specify that stuff is freezable. E.g. use
      system_freezable_wq instead of system_wq.<br>
      <br>
      Alternatively as Xinhui mentioned it might be necessary to flush
      all restore work before the first eviction phase or we have the
      chance that BOs are moved back into VRAM again.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      <div class="moz-cite-prefix">Am 14.09.23 um 03:54 schrieb Pan,
        Xinhui:<br>
      </div>
      <blockquote type="cite" cite="mid:DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com">
        <meta name="Generator" content="Microsoft Word 15 (filtered
          medium)">
        <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
        <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}@font-face
	{font-family:"\@Microsoft YaHei";}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
        <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - General]<br>
        </p>
        <br>
        <div>
          <div class="WordSection1">
            <p class="MsoNormal">I just make one debug patch to show
              busy BO’s alloc-trace when the eviction fails in suspend.<o:p></o:p></p>
            <p class="MsoNormal">And dmesg log attached.<o:p></o:p></p>
            <p class="MsoNormal">Looks like they are just kfd user Bos
              and locked by evict/restore work.<o:p></o:p></p>
            <p class="MsoNormal">So in kfd suspend callback, it really
              need to flush the evict/restore work before HW fini as it
              do now.<o:p></o:p></p>
            <p class="MsoNormal">That is why the first very early
              eviction fails and the second eviction succeed.<o:p></o:p></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal">Thanks<o:p></o:p></p>
            <p class="MsoNormal">xinhui<o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> Pan, Xinhui <br>
                  <b>Sent:</b> Thursday, September 14, 2023 8:02 AM<br>
                  <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                  Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                  Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated
                    moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                  Wentland, Harry <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com" moz-do-not-send="true">&lt;Harry.Wentland@amd.com&gt;</a><br>
                  <b>Cc:</b> Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                  <b>Subject:</b> RE: <span style="font-family:&quot;Microsoft
                    YaHei&quot;,sans-serif" lang="ZH-CN"> 回复</span>:
                  [PATCH] drm/amdgpu: Ignore first evction failure
                  during suspend<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal">Chris,<o:p></o:p></p>
            <p class="MsoNormal">I can dump these busy BOs with their
              alloc/free stack later today.<o:p></o:p></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal">BTW, the two evictions and the kfd
              suspend are all called before hw_fini. IOW, between phase
              1 and phase 2. SDMA is turned only in phase2. So current
              code works fine maybe.<o:p></o:p></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;
                  <br>
                  <b>Sent:</b> Wednesday, September 13, 2023 10:29 PM<br>
                  <b>To:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Felix.Kuehling@amd.com</a>&gt;;
                  Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;;
                  Pan, Xinhui &lt;<a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xinhui.Pan@amd.com</a>&gt;;
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                  Wentland, Harry &lt;<a href="mailto:Harry.Wentland@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Harry.Wentland@amd.com</a>&gt;<br>
                  <b>Cc:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
                  Fan, Shikang &lt;<a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Shikang.Fan@amd.com</a>&gt;<br>
                  <b>Subject:</b> Re: <span style="font-family:&quot;Microsoft
                    YaHei&quot;,sans-serif" lang="ZH-CN"> 回复</span>:
                  [PATCH] drm/amdgpu: Ignore first evction failure
                  during suspend<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt">[+Harry]<o:p></o:p></p>
            <div>
              <p class="MsoNormal">Am 13.09.23 um 15:54 schrieb Felix
                Kuehling:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <div>
                <p class="MsoNormal">On 2023-09-13 4:07, Christian König
                  wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal">[+Fleix]<br>
                  <br>
                  Well that looks like quite a serious bug.<br>
                  <br>
                  If I'm not completely mistaken the KFD work item tries
                  to restore the process by moving BOs into memory even
                  after the suspend freeze. Normally work items are
                  frozen together with the user space processes unless
                  explicitly marked as not freezable.<br>
                  <br>
                  That this causes problem during the first eviction
                  phase is just the tip of the iceberg here. If a BO is
                  moved into invisible memory during this we wouldn't be
                  able to get it out of that in the second phase because
                  SDMA and hw is already turned off.<br>
                  <br>
                  @Felix any idea how that can happen? Have you guys
                  marked a work item / work queue as not freezable?<o:p></o:p></p>
              </blockquote>
              <p>We don't set anything to non-freezable in KFD.<o:p></o:p></p>
              <p><o:p>&nbsp;</o:p></p>
              <p>Regards,<br>
                &nbsp; Felix<o:p></o:p></p>
              <p><o:p>&nbsp;</o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal">Or maybe the display guys?<o:p></o:p></p>
              </blockquote>
            </blockquote>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
              Do you guys in the display do any delayed update in a work
              item which is marked as not-freezable?<br>
              <br>
              Otherwise I have absolutely no idea what's going on here.<br>
              <br>
              Thanks,<br>
              Christian.<br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                  @Xinhui please investigate what work item that is and
                  where that is coming from. Something like &quot;if
                  (adev-&gt;in_suspend) dump_stack();&quot; in the right
                  place should probably do it.<br>
                  <br>
                  Thanks,<br>
                  Christian.<o:p></o:p></p>
                <div>
                  <p class="MsoNormal">Am 13.09.23 um 07:13 schrieb Pan,
                    Xinhui:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                      Official Use Only - General]<o:p></o:p></span></p>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  <div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                          notice that only user space process are frozen
                          on my side.&nbsp; kthread and workqueue&nbsp; keeps
                          running. Maybe some kernel configs are not
                          enabled.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                          made one module which just prints something
                          like i++ with mutex lock both in workqueue and
                          kthread. I paste some logs below.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.696196]
                          XH: 14 from workqueue <o:p></o:p></span></p>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.700193]
                            XH: 15 from kthread<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.394335]
                            PM: suspend entry (deep)<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.399619]
                            Filesystems sync: 0.001 seconds<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.403887]
                            PM: Preparing system for sleep (deep)<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.409299]
                            Freezing user space processes<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.414862]
                            Freezing user space processes completed
                            (elapsed 0.001 seconds)<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.421881]
                            OOM killer disabled.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.425197]
                            Freezing remaining freezable tasks<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.430890]
                            Freezing remaining freezable tasks completed
                            (elapsed 0.001 seconds)<o:p></o:p></span></p>
                      </div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.438348]
                          PM: Suspending system (deep)<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">.....<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.746038]
                          PM: suspend of devices complete after 3303.137
                          msecs <o:p></o:p></span></p>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.752125]
                            PM: start suspend of devices complete after
                            3309.713 msecs<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.758722]
                            PM: suspend debug: Waiting for 5 second(s).<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.792166]
                            XH: 22 from kthread<o:p></o:p></span></p>
                      </div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.824140]
                          XH: 23 from workqueue<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">So
                          BOs definitely can be in use during suspend.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">Even
                          if kthread or workqueue can be stopped with
                          one special kernel config. I think suspend can
                          only stop the workqueue with its callback
                          finish. <o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">otherwise
                          something like below makes things crazy.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">LOCK
                          BO<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">do
                          something<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;
                          -&gt; schedule or wait, anycode might sleep.&nbsp;
                          Stopped by suspend now? no, i think.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">UNLOCK
                          BO<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                          do tests&nbsp; with&nbsp; cmds below.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                          devices &nbsp;&gt; /sys/power/pm_test <o:p></o:p></span></p>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                            0 &nbsp;&gt; /sys/power/pm_async<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                            1 &nbsp;&gt; /sys/power/pm_print_times<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                            1 &gt; /sys/power/pm_debug_messages<o:p></o:p></span></p>
                      </div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                          1 &gt;
                          /sys/module/amdgpu/parameters/debug_evictions<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">./kfd.sh
                          --gtest_filter=KFDEvictTest.BasicTest<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">pm-suspend<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">thanks<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">xinhui<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div class="MsoNormal" style="text-align:center" align="center">
                      <hr width="98%" size="1" align="center"> </div>
                    <div id="divRplyFwdMsg">
                      <p class="MsoNormal"><b><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">发件人</span><span style="color:black">:</span></b><span style="color:black"> Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                        </span><b><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">发送时间</span><span style="color:black">:</span></b><span style="color:black"> 2023</span><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black" lang="ZH-CN">年</span><span style="color:black">9</span><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black" lang="ZH-CN">月</span><span style="color:black">12</span><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black" lang="ZH-CN">日</span><span style="color:black">
                          17:01<br>
                        </span><b><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">收件人</span><span style="color:black">:</span></b><span style="color:black"> Pan, Xinhui <a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                            amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                            &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                        </span><b><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">抄送</span><span style="color:black">:</span></b><span style="color:black"> Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                          Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                          Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                        </span><b><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">主题</span><span style="color:black">:</span></b><span style="color:black"> Re: [PATCH] drm/amdgpu:
                          Ignore first evction failure during suspend</span>
                        <o:p></o:p></p>
                      <div>
                        <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <p class="MsoNormal" style="margin-bottom:12.0pt">When
                          amdgpu_device_suspend() is called processes
                          should be frozen <br>
                          already. In other words KFD queues etc...
                          should already be idle.<br>
                          <br>
                          So when the eviction fails here we missed
                          something previously and that <br>
                          in turn can cause tons amount of problems.<br>
                          <br>
                          So ignoring those errors is most likely not a
                          good idea at all.<br>
                          <br>
                          Regards,<br>
                          Christian.<br>
                          <br>
                          Am 12.09.23 um 02:21 schrieb Pan, Xinhui:<br>
                          &gt; [AMD Official Use Only - General]<br>
                          &gt;<br>
                          &gt; Oh yep, Pinned BO is moved to other LRU
                          list, So eviction fails because of other
                          reason.<br>
                          &gt; I will change the comments in the patch.<br>
                          &gt; The problem is eviction fails as many
                          reasons, say, BO is locked.<br>
                          &gt; ASAIK, kfd will stop the queues and flush
                          some evict/restore work in its suspend
                          callback. SO the first eviction before kfd
                          callback likely fails.<br>
                          &gt;<br>
                          &gt; -----Original Message-----<br>
                          &gt; From: Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                          &gt; Sent: Friday, September 8, 2023 2:49 PM<br>
                          &gt; To: Pan, Xinhui <a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                            amd-gfx@lists.freedesktop.org</a><br>
                          &gt; Cc: Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                          Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                          Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                          &gt; Subject: Re: [PATCH] drm/amdgpu: Ignore
                          first evction failure during suspend<br>
                          &gt;<br>
                          &gt; Am 08.09.23 um 05:39 schrieb xinhui pan:<br>
                          &gt;&gt; Some BOs might be pinned. So the
                          first eviction's failure will abort<br>
                          &gt;&gt; the suspend sequence. These pinned
                          BOs will be unpined afterwards<br>
                          &gt;&gt; during suspend.<br>
                          &gt; That doesn't make much sense since pinned
                          BOs don't cause eviction failure here.<br>
                          &gt;<br>
                          &gt; What exactly is the error code you see?<br>
                          &gt;<br>
                          &gt; Christian.<br>
                          &gt;<br>
                          &gt;&gt; Actaully it has evicted most BOs, so
                          that should stil work fine in<br>
                          &gt;&gt; sriov full access mode.<br>
                          &gt;&gt;<br>
                          &gt;&gt; Fixes: 47ea20762bb7 (&quot;drm/amdgpu: Add
                          an extra evict_resource call<br>
                          &gt;&gt; during device_suspend.&quot;)<br>
                          &gt;&gt; Signed-off-by: xinhui pan <a href="mailto:xinhui.pan@amd.com" moz-do-not-send="true">&lt;xinhui.pan@amd.com&gt;</a><br>
                          &gt;&gt; ---<br>
                          &gt;&gt;&nbsp;&nbsp;&nbsp;
                          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9
                          +++++----<br>
                          &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 4
                          deletions(-)<br>
                          &gt;&gt;<br>
                          &gt;&gt; diff --git
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt;&gt;
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt;&gt; index 5c0e2b766026..39af526cdbbe
                          100644<br>
                          &gt;&gt; ---
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt;&gt; +++
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt;&gt; @@ -4148,10 +4148,11 @@ int
                          amdgpu_device_suspend(struct drm_device<br>
                          &gt;&gt; *dev, bool fbcon)<br>
                          &gt;&gt;<br>
                          &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_suspend = true;<br>
                          &gt;&gt;<br>
                          &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Evict the majority of BOs
                          before grabbing the full access */<br>
                          &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =
                          amdgpu_device_evict_resources(adev);<br>
                          &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                          &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                          &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Try to evict the majority of
                          BOs before grabbing the full access<br>
                          &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Ignore the ret val at first
                          place as we will unpin some BOs if any<br>
                          &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * afterwards.<br>
                          &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                          &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                          (void)amdgpu_device_evict_resources(adev);<br>
                          &gt;&gt;<br>
                          &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
                          &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          amdgpu_virt_fini_data_exchange(adev);<o:p></o:p></p>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              </blockquote>
            </blockquote>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          </div>
        </div>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------0m1T7HYw0TPx00znvnhuDQ9r--
