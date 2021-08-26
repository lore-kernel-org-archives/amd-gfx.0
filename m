Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E50EC4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AEF60EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32AEF60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81136E847;
	Thu, 26 Aug 2021 12:59:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F5A6E846
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4OWBuwo+qcUCvIJGcPlvqZgVprdBLbU7jRKdUw0LXo+FNZ1QDlCHCaQIIC7aGY515mNem9yUO8rPb8bPcLu1CUOX5tJv6VKDEJbW/Z9B1BPuVZ/ECjHnKAvmkNytav0vb58cPTJzMU8QXoc0wGi+zjrKd1LYbIAJgfsF3yGlTisQLluwNCc1OgW3MSegVC9WYwbP2W7USkFu6ziVETS7U7QKfHVHvfw9uWvYREJ4VuwQvhdTms+MCOB/3RgNT7kb06Wy+86dWuApO4RCE8338V99EDIt2ZIMdbky88KDHd4KILDGQu+KpQvFNYWOjPmgFVRqZlVI1Brx6idjCRP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRUYo3Wv2oLWd6/QZUxGUzmEJ0M2db0mlsP2f5PUlSM=;
 b=a38T6xQ4VPMFZ30+1PN7qrKEadZSCS8KlxS1cYIIem7JMMP9XjPl3swBOO9v2B2XFENOjy77rv0jP394Ss6EpeRbc/UtZWi0YnHFFgK/0KSrF43LZHqLcGpCsXl8/NR2bHW852ZBc5BX//vn53J46GOUGlBNM+ePIQd8LhoS+9WDKZAxaE9vyLXULbn8YmpPSsNzjIEh/cGOQWevIaaTZ/X3InTFN1dnFN8BPHN7WFg1bhi+Nc3s3wxk6zfYJyrpTUc38otR93hv9JWBw2hGPUe/OS74HwWwXZ8+5E17nyvNFcSwQVd0dFFT4ZdqHFLxNrM5/LaWEXam615jTNvuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRUYo3Wv2oLWd6/QZUxGUzmEJ0M2db0mlsP2f5PUlSM=;
 b=CD7D9SsEoytdNTaAVLTcrolsKJwI1YJX/QHCN8Pwg+VZhiS7PfZMTZK9kIgOFwLM8thWvnWoX2xF3fE0F0W2v5kBxTyed5DdhkscaH7DLgGqDMQIMDRNC5Z5t7nm4SDkzKbK+FVocZ40m8cyQ70LiWbVcSbktQriRrwuSzJC0g8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 12:26:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:26:05 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-5-satyajit.sahu@amd.com>
 <f6c013a6-1d88-6360-57c7-6494a92f7648@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bcfdb979-0788-1cb8-8abc-46fe6e88b517@amd.com>
Date: Thu, 26 Aug 2021 14:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <f6c013a6-1d88-6360-57c7-6494a92f7648@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P193CA0047.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1f1e:4529:2fc9:1857]
 (2a02:908:1252:fb60:1f1e:4529:2fc9:1857) by
 PR3P193CA0047.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.22 via Frontend Transport; Thu, 26 Aug 2021 12:26:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82a0e0e3-3343-4d6f-7740-08d9688cac6c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB409496FDB02D5283E39CD57683C79@MN2PR12MB4094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZeQJ63t60vtrI5fJWnsJF9tRY7O9z1+kJ6TgSrQ6g6NYbV3BOX8xRI9JXfGfw0H4K5Na6l789A7adtnvaB3P4DpWAJ2srkyqWyj5P9+gZ/lrjVbhemQSROzaUNbnWM/nZG4JrmJyDmQqi4cG0aAOpiXv1L5M9YB8+VEKMN1pl0onuWt3aKdZFhZwhThwTsSBCPoKuVweNmjGvdWHzEJ3H/qVEqIi6SC15ppUljXlv5Tr7x4Waxb0bwsI5yAAvIlfkGDkHtCood+d0zpmW/LkYbHZVxJBe+f3z7cEX8oYe2Yxq1xxFqrqA295I9734OsshuO8SI0LQ25DwXGICkb4YsId1t1wplo6nCEvqtV/R/aYc5xRHwVQQn3KiyrB+6DJN4gmLTHOdrOz3dBv/wfAPXFRogNK/BxeAjQBoE4lAE3FjkieabdfedBCeEX3Wca4pHTkJoJd012DjSHWTKgeQJXgpAisyl6pJ5MnxLBH56kCz5/C8EE/8hAo6ZiWVpHT2fPjvomQ4gzELomt6fHX5F79lgcs7Vnj9XmRsfoy9rKuWA1yp8mkHVmMqSOwuKWSSS7XVR0T1kiBcH8aFb6Eq+IolEDa1VW2EEqd33RNwrtIjkvJsUqGJBcMBhagc7Qjvz6U2hRkXwMvAorEt3OTNI6V3pgVdOMjUCjzi0oM9bob7EdJw7PQ4YxsUhbYlrvV2FtkoGbvUWuPopafkrGmTNJ0POJumhKwsBZP5Nnb/jUnu7UPCJQme7G/J4gWp+L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(8936002)(5660300002)(186003)(38100700002)(31686004)(8676002)(2616005)(4326008)(478600001)(53546011)(2906002)(6486002)(6666004)(86362001)(36756003)(66556008)(66476007)(66946007)(31696002)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJLZ3k0dWk0Mk9iUFN5b0JJN1YvK3pFODZTVjBNckJwSStEejRTenRhaVhT?=
 =?utf-8?B?SldIMFc5UE04Zkg0SG9EZCs2ZW8yVHdFT2JLbDh3QUVZTDBlOXdVTXhrVkVt?=
 =?utf-8?B?S0t0TXMrMDA2dnB5ekJ4blpiaUhoekFNN2FuVmhYY3BkekNaRzJtZTJEaHpn?=
 =?utf-8?B?WEoxRDVrZnpBNTA5dmtScmNxL1lSdlhETTBXYUZVWFllOWllbFRFNnpkc3ZU?=
 =?utf-8?B?Y2RUbG5xY3h4c1VHSDhsRWdPTFBCMFhWZHhXbHVMOFJnUVAyaTJzTm0xaWFs?=
 =?utf-8?B?TTNFNXpYZHNhTGY5c1hrZmNTQjNDb2h4SGFSak9hMVU2QVRsNDliZmhJYVox?=
 =?utf-8?B?UWlnaGM0MDJod1Y2Zk93SlBxU1dGZHhxbENRdW5UZVR0akhuRlBDT1BQOU9O?=
 =?utf-8?B?ZDNxeGl5VVZmbTUzclBpQlFKVmpONW9pVTIrYS9VSUp0dEo4UUtDMDJKeHA5?=
 =?utf-8?B?TVdFM0dYUVRHc1habnJaSXdtSXJQc3NBUkZ4K20ybGhZUW92M3h3UVFTMFA1?=
 =?utf-8?B?d2pESTB4am5XS2tPV09tc2QvQ29KdEJ1OTl2aGRDdmdlbTl3WndwRjRyb2pi?=
 =?utf-8?B?TjNYWFpSK3dFakJaeUZIVGEwOEo2NVMwVndGeW9WbDRWYXQ4Vk8xdFZqSGtG?=
 =?utf-8?B?Snh5cmJOb3ZyUk1sSWljVmxqRGFyUTM4RGduLzdKTDNZODh6c09KQzRkN3F6?=
 =?utf-8?B?THdnVjdCMFVjMDRsbjdGaDFWSjJiY2JRYjdnb2dHbENSRzdCQ2dBVVhHQ1Zp?=
 =?utf-8?B?T1F4anYwdWhpNFhOOTg3eWhlWTFvQURwM1A2Y3E1UzQ3UVhZYk9GZDRBYThV?=
 =?utf-8?B?R1lScjJSZWtKby9iWk9KMWIyMkp1b2pZQXlSOUpWTzhLNWp1eGVDS2V3T0ZT?=
 =?utf-8?B?V3RLQ2E4WlE2aFk5b0UyWjV4R2swSVN6VlJiUG1leGtCczFkSmZibTkyMGVk?=
 =?utf-8?B?Y2VZTUZJYXFuWkp6U3pUdlMzRE9yN1A3WEorUXlqR1VKcDNkcUhLa0l2RlQw?=
 =?utf-8?B?RUtNVWlUcUZxeGlpa3VZUnpnZFphL3oxU2FIQ2tNS1lMWUxHNm9ZelBoWnNN?=
 =?utf-8?B?Ky9WdG1ZK1J0a0twM2huTFRVblNQcS8wTHVWVmxKTUh3UVRGMFgrRk5PcmQ3?=
 =?utf-8?B?T2F5dHdLRmZpT0hJUXJZcWFhRUVnUGVjVjRkSUlndGg1Z3NaYTg5a0hRNU1T?=
 =?utf-8?B?U0hjUk14bU9tdGJwRUE1aTAwWkNxdUVTOS91ekIyMmhCbERCVkd2clpFZlQ3?=
 =?utf-8?B?YlN0WU4veU5GUUNnT2tMNFFmOHNXT2RIeTVLSVVGdlg1dUtHSjRvS2JVa2xZ?=
 =?utf-8?B?Q3EvMEpGaHFna1R3OU9SR0NEeTJOS2M4aERSaFlxbDgvelNDdkNmNzIxaWx5?=
 =?utf-8?B?YzlDRE8rWkxaQjcrWjY2YkVKVUx2UjgybjI1UGl4Znp5WUgzUGt6Snd6Y05D?=
 =?utf-8?B?RHlYZmw2V0ZOcWUzamNoNEJmREJuMEY1MHNKd2duYmsrUm1BOVJiSXNwZWZ2?=
 =?utf-8?B?cXFmZ05nUjY0YW9FeE5IbzVMUWF5SVgyK2ZQcXpOd0t2U3czcFpqRXBkbWdC?=
 =?utf-8?B?dzRDUnZiaGhxZGNqMHFmRXBSQnlUc0dESDJTaGpQMGVMSkxKcE5hMzhGZXBJ?=
 =?utf-8?B?RFhVa0YwTXlmN0ZwMmNhbjZQd0dwWHVyOFp5Q3dQSDk1OFBFdUVLQjlFRUpH?=
 =?utf-8?B?VE1zM3F2TTBOc3hqOGRtMGVmR3ZRVFFIMS9nUmVnZ0Z1TjkzWkVJL3J2cVRh?=
 =?utf-8?B?SFhvd2VqTWhQQ0xEbGxlZE9WU1BzUEl0SWpZYVYyYmcySnAwWVNieER2Nnh2?=
 =?utf-8?B?UWU0OGVDaFJNVTRvb0JndWNqemZPNGtvVjVTbVNtSWhRdk5TRnl2eFVJM3My?=
 =?utf-8?Q?ZtbZi/iq3sOzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a0e0e3-3343-4d6f-7740-08d9688cac6c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:26:04.8304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsndYIIghChiuenPaBDpV4dirg/EWybh/qFG4iZSXWJ1SGoARe/B6ulTWYxzzASK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

Am 26.08.21 um 13:44 schrieb Sharma, Shashank:
> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>> Schedule the encode job in VCE/VCN encode ring
>> based on the priority set by UMD.
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index c88c5c6c54a2..4e6e4b6ea471 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -120,6 +120,30 @@ static enum gfx_pipe_priority 
>> amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>>       }
>>   }
>>   +static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)
>> +{
>> +    switch (prio) {
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> +
>> +static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
>> +{
>> +    switch (prio) {
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> +
>>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, 
>> u32 hw_ip)
>>   {
>>       struct amdgpu_device *adev = ctx->adev;
>> @@ -133,6 +157,12 @@ static unsigned int 
>> amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>>       case AMDGPU_HW_IP_COMPUTE:
>>           hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>>           break;
>> +    case AMDGPU_HW_IP_VCE:
>> +        hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
>> +        break;
>> +    case AMDGPU_HW_IP_VCN_ENC:
>> +        hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
>> +        break;
>>       default:
>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>           break;
>>
>
> IMO, this patch can be split and merged into patches 3 and 4 
> respectively, but is not a dealbreaker for me.

I would rather keep that separated. The other patches add the 
functionality into the backend while this one here modifies the frontend.

Christian.

>
> - Shashank

