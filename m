Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC82C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5275F10E4E5;
	Wed, 31 May 2023 14:20:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6981E10E4E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUbn10/7RZMCVewIGnojpPiScSIBm6xgnV8Orley6RSHjQBkEojvRDAQ0dgs0F3KYQ2F1cEU2hVkdsPqY4SmAzHxFpADJIP8AYFdmZ5YXgX3/yi4CeyurbEqf88pwNp3Utn9/J3w0NlVWezxXYXLWtw+5WC336v8SpIYSUzw7pT0tD5ahPVajCSFbgYcbDq62mCJiXyaLbMUAup6CG4ZBC2ywBwsqy2F8omWM0oLwUW53/2M9aLIKJ9Gz05Ow/5B5woNAw1OJhLBXOia2IYWUknN2BzBYGtg/dwYiKEyfd7e7y1XuCxP6WLkj0v6wzOi2oOMtiENIlH+ieH6ny/Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FII4cIsvxm/cS9LNA2vP4w2mDGqKKKF0Kc76ot0/kQI=;
 b=ODOvLkETaj287CYGiA3O2pV/7W5DxBKe2DJJ6uKLngONDscQfqzUspiYYVu30qXZSp+hlPDrZyNMxPGtMETPBNsWeijycqKpydIYkqM+L6Jho4HcGCwGCQxXOqrq8hI5ubP0CR+2Tmn/x0L1IWciLF/VJyhJUIzErS3Qmf89V43wpmKUT+7iWL6cP8o7lm2LIKjghsoo+i3C/EtIxVIQnGmk0rtpOqSybTrS6PV8G0lhSqIPQDywEb94RqtoNZ50/nyrwbSkbDWru6rzjN5UtoAQXkUk9RoASgS2NHDVkA3/qZkVUm2VRXM3HPDHkHVcFiLjLhNqvdMYfsmgciut3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FII4cIsvxm/cS9LNA2vP4w2mDGqKKKF0Kc76ot0/kQI=;
 b=AXN/7w5toftSo60ymTx2tc3xtx+1gtvo5S0zDuWX19y2WCLrmmBq4R5ntzG82SwEjiA5+noqFstIiVs6lKKAf8TYgCDUIaDnTrzkETrb2HH54rOMu5TTLuVy+6+xDAmBN+pysEcCwOVb42hsYnN3MR2+HGIzadyTISmWkOyet80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:20:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:20:04 +0000
Message-ID: <952d351a-58fe-93e2-db68-2f4abab66b37@amd.com>
Date: Wed, 31 May 2023 09:20:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0018.prod.exchangelabs.com (2603:10b6:805:b6::31)
 To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 62acfdfe-35ae-4450-27cf-08db61e2209c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL3Z7mMIdssAHCD7jwvlOv64P+yu0e3t1V8wqzWW2c+QXlCWq4LUH+XV51NU3KTKax7NLpMwVwWv16J1c8H5H0zH34FlhmhvM5poqi/oZRs/69I+fA3sranRekjEhkA1PJt6nR/83UEo3phzt+7xM9tkuOcV6X0ykKApn2yj/z1GtO3+e4KvOmBIHhXUeMFBOZv6U1uAwdVugoVHYuwCKTFDo+1eFeBJnM2t8ElSc0XhYVCtZ1t+pRDC/HmgofMLh6ABGOZj8tq6GKPNNcwwGEPXJTjGkYDIn8esVbU5vP+JkpBN2GxjMp4ulqvbH4tdm6caT260Jxz4z0ekTD37kj5lMKv5RZ3ZkBRJY/BwTvQEKNpb4E9uFmhA7WEYdsDtfwIl5pugnIu/Qzr4XlNmODWDxyYrP2/B4Qd0TvDFftezac5AesRGfxfmM/iMrpN06xYgKwjhl+ZVb7b1IEoq7JIYu9q+qG0Ya069ue+r2jE2WPyIFrD4rC+kzP5RMyd8rhkcvjENW4Cj8Xy6GotimazeYStJba8F7q6ewyJAwJ9omk/K+NOObzMr+/wGxp66tU8DdF44hC9DqaDTuqrsvav+Lh1PYRs5H3hWKLjT1AvtnYIRETmALckPAajPznnMpApN5n5Ekbu8Np6urwbFWgISUrb/JILGnqPZIrsY9TQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(66574015)(83380400001)(41300700001)(6486002)(316002)(6666004)(186003)(36756003)(53546011)(6506007)(6512007)(44832011)(8676002)(8936002)(5660300002)(2906002)(966005)(31696002)(86362001)(2616005)(38100700002)(31686004)(478600001)(6916009)(4326008)(66476007)(66946007)(66556008)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm93VkVjWDN0RWk5QlEwQnNLdlVXOW9EK1daMGpGTDUyNWkyUzNheUd2Ymwv?=
 =?utf-8?B?aWVBVU1tWWR3K0Riblg5QVZLN2V1VjEzNS9YR1E3UXo4MWVVVU0wb2ZPbjFO?=
 =?utf-8?B?ZzlEencwM3RvNmRrUE44M1U2Q0RSWXJycTZ3TmcvRXU2TkxuS1lRZGJUaEdm?=
 =?utf-8?B?NnpGcFU1dnl4ZGJTenIvMlZNaTNBTUR4bWlLRUh5K0tkZ3NTUk12Nzg0dE4w?=
 =?utf-8?B?TjF4ZHZsaGNybG83bFFXU0ZtaWI0UE83Nkd1ZW9zZ21lamVNdGhvaDFNZGkr?=
 =?utf-8?B?ZjM1M3NvV05oQmV2VnhXaUxSNENldzZGZmpjcjlQa21IWWh2NmU0ZUxMaVBt?=
 =?utf-8?B?WVpNMkxQZ2wyME41OU40WS9IY2R0VTlsbDZKSTYyd2RMd1g2R3EySFRJQ1p1?=
 =?utf-8?B?RjYzSkYrUzBuY3ltamhNNTJHOGY2ZThNWnFhNGs2K0JKV1BvZWdNUk0xYnJT?=
 =?utf-8?B?TEtlb2J5T1JFSkV4Y3UxY2JBT0VOWThuOGRteTRhdlFMNjVidXQ2NjJxVkhl?=
 =?utf-8?B?djRwb3RqejN1R0ZENjllMEVjZVBVVzZMdHdZQ2NTZjJocHViY0twWGRLQi95?=
 =?utf-8?B?ZU0vN2IyYlNJaFNhSkkza0FuQ21leVhxcmtrZ1ZFZmVzdlFVUHZXbnBVMXpu?=
 =?utf-8?B?dUlZS0VyZWUzOEQwb3dLQkg2dS9GRzVpdVcrTnZzSUR5QlV6NVdBd05lT3Jz?=
 =?utf-8?B?NmJVaEIxSU9lQkt0cnhhL1hQajVMVjNUa2JYY0JSZXMwTy9aOVJYOWVwdnBZ?=
 =?utf-8?B?a2NNY3dwMHM3clhmQWl4aEM1VWlPTWs0RTZ0T0VCK3dJbXA5NWxIY1NnWUxl?=
 =?utf-8?B?bTJNenBFM3JqODg2THJFSFMzanh4ckQ3SXhHTzhMZm5MbFVCeitrNUx3eHdB?=
 =?utf-8?B?YXVKLzIyb1B1cHgwVFlDQnRjMVh1Ylk5OHphdTA5SG1jemkyVXRxWUhkUm45?=
 =?utf-8?B?UG1wUmIvR3o1TmRnZ1F2alRRRGYwQ0FXcTA0ZzZqTStIUjdXVzc1L0lhOUVK?=
 =?utf-8?B?UDJ0VC9laUNIZE5MdHQ1RXltU1BQWnEzZ3pZWkYzdTBNbkVBTHlnd0Q5YUJG?=
 =?utf-8?B?YzRLcGZ6RGxNWmhROUZadEVuZVBCUDhzYWtDYVY0SVZXbDJpclU5UG00Yitu?=
 =?utf-8?B?RnlaSU9HMHNlZmZjSG9iNDgzb21ZS0NMWjVxVXkwQS9NbUxQMzB3dW1JRGdZ?=
 =?utf-8?B?TWZpNzdwbGJVa1h0ZGxSQjhUZE5VdG9mM3QrVHNCQUF0WFF1SnAraXRJaU42?=
 =?utf-8?B?MzlBZklzVlJpcmozTWZ5WHFtK0xwVjZyVURFcHplMG81Umc1aHlPbUR3cXlL?=
 =?utf-8?B?Zlh5bHFDaWNUL28welFyUEpiWlE3RlRhZUd4clVucnRIU3d6a3ZRa3lRR0x3?=
 =?utf-8?B?cmp5Q0d3OVR4TVdLcGFtQjFIbml3VzljdERtYUY4UGwzRmRmZW93akZidHJW?=
 =?utf-8?B?N25YS3lPOWQzLzFMT3BjNUpnL1dPaDJ4V2dZVGJ2MWhrSHpQVVVkajk0TTgz?=
 =?utf-8?B?STNBdWovZEp4Qjd0VXRqaG9hS0c5RWRDeXFERFFXOEgxaDVVNmU0TTNTTW9u?=
 =?utf-8?B?cSthRDNIbGhMYndTVVdWNDRsUUp0ZGIzaC9Lb1lwMTJPbFg0YmVGZm9HWk1L?=
 =?utf-8?B?S1ZXUEwxNWhocFhUVURRZzl5dUR1MXJUYVlyYmIzYWp5T2N6cGVVejEwb2xB?=
 =?utf-8?B?OUJraTRWUmZRRG1iUHFOQjM2L0lqL0t3eG1ON1ZqZGhJT3ZOOUxjQWVrMU14?=
 =?utf-8?B?aHFhWmp5cjZjcnI1SzVqRTBkMHRFaGFwb1pOSCtpTkpndHNRUTJoSVFiczN5?=
 =?utf-8?B?cUxkb25veVpCTFVYMm9YWVBTeHQ3dDVydXFYZTBXa2pwNXZxejc5aFIxZFdY?=
 =?utf-8?B?d2xZajJMOWxJMXFCblRkTzB5K3pJa040OTN3NCtwekttck1udERWVklzZUdL?=
 =?utf-8?B?OGZGclRZTHVCTHVWWlVvbkozSmZsRmZEWWp1UFNFYjJJZGlpR2FpVUVFT1RJ?=
 =?utf-8?B?ME9yRVRFdHJrWXpJak9GZEJ5V3hpQ1JkY3Y2NEdqS3hnVHA5WE5qUldObEsw?=
 =?utf-8?B?WnZkN1FORkpFeXNKdVdrMDRpbG5zUzFYN1NKSG0zd1hsZ2FzQTZteENwYXZ1?=
 =?utf-8?B?d2FUMkExVUZDTkcyczBxMHNYZGo0a2ZjcWhpaEkvS21jaWs3L2p1NEJERkRj?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62acfdfe-35ae-4450-27cf-08db61e2209c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:20:04.2339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAa/rV1wtRVrv1jMOvmRTBul/zXTHeaxWzsF807qVejWYbPv+tW42N/7dpBrgZra1ijXnLrLOcq1zyMcelS+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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
Cc: =?UTF-8?Q?Rafael_=c3=81vila_de_Esp=c3=adndola?= <rafael@espindo.la>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/31/23 08:26, Alex Deucher wrote:
> On Tue, May 30, 2023 at 6:34 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") showed
>> improvements to power consumption over suspend when s0ix wasn't enabled in
>> BIOS and the system didn't support S3.
>>
>> This patch however was misguided because the reason the system didn't
>> support S3 was because SMT was disabled in OEM BIOS setup.
>> This prevented the BIOS from allowing S3.
>>
>> Also allowing GPUs to use the s2idle path actually causes problems if
>> they're invoked on systems that may not support s2idle in the platform
>> firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fails
>> for any reason, which could lead to unexpected flows.
>>
>> The original commit also fixed a problem during resume from suspend to idle
>> without hardware support, but this is no longer necessary with commit
>> ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")
>>
>> Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
>> to make it match the expected behavior again.
>>
>> Cc: Rafael Ávila de Espíndola <rafael@espindo.la>
>> Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L1060
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Patch 1 is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thx.

> Patch 2 seems a bit much, but I could be convinced if you think it
> will actually help more than a warn would.  Users already assume warn
> is a kernel crash.  I'm not sure the average user makes a distinction
> between warn and err.

warn and WARN are two different things.  I think you're right about 
WARN, that does look like a crash to most people.

Modern versions of both util-linux (for dmesg command) and systemd (for 
journalctl command) will apply coloring for different message levels.

For both specifically there is red coloring when there is an 'err' and 
"bold" white coloring when it's 'warn'.

> 
> Alex
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> index aeeec211861c..e1b01554e323 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>>           * S0ix even though the system is suspending to idle, so return false
>>           * in that case.
>>           */
>> -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>> +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>>                  dev_warn_once(adev->dev,
>>                                "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
>>                                "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
>> +               return false;
>> +       }
>>
>>   #if !IS_ENABLED(CONFIG_AMD_PMC)
>>          dev_warn_once(adev->dev,
>>                        "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
>> -#endif /* CONFIG_AMD_PMC */
>> +       return false;
>> +#else
>>          return true;
>> +#endif /* CONFIG_AMD_PMC */
>>   }
>>
>>   #endif /* CONFIG_SUSPEND */
>> --
>> 2.34.1
>>

