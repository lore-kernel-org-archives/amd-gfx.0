Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D44F61547
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D44F61547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE9B6EB9F;
	Thu, 18 Nov 2021 14:40:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988D16EB9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK2auuet16hP8fmW9FdEPqibK0T2Jn8dzNYvNuR/LDh+UWr8tAJwIiNM8aVegw2GZON0jn7HPOXuzdlfQFBh1wDak3EJn9Hh03eLYEQ32JsucWmOYtxz0GK89UshDSaQiBn2S1qn+y2DkvZy2ncVAPiZkTSKUNESPJDBpW7c+uTYHIrc/k/jtLH/wDRz6qY6BoHXCy8CaPsT0C/F1qj2tzCzW1jTIXTevr/+Ehp9CkJ4apltWayYuZpy21OSMNowF3/sGeNKb9SV8MIi7aZ8JvpYXsugp42JIuQDnUkKQQXHYqI4nIQuae+8oAgBfvvKf0NfKHl2PJKknYGEQS6JsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lWBFh8PhW8wO9Nr+MCCHxCaA+YIK+wIVADyvccN0wI=;
 b=eIMEioqMeXMQuO2iyPvAHWJtQZ/KT374rXkXYrEebv+/dEXPmEGtkESfOpKBVYePT6ybLdi5NfG+aD8LM76Cm3bw8WOxr3/0xWgew4znI5d9YkBFmB+ZtdEx0mPZBP3Hrwua2muUFM2xcA398zyijtbYMN6AnsCqvru8vkNAGiTTwlJ3v5RfvdtZ45ddHGVXQ0FBWBCG6CvnjqahkjNuMQkgDFbWnXACg873IlvztzdqNh/LAmXS2JzJk2qOMdrSHRHGjbr5esYSYvrqvWOhOFGNeBZ22e9CzLdGmExGSOH1aaMQKY3PeoKIEI1zlxu86JH9O6jCoG4tl5xjXkTwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lWBFh8PhW8wO9Nr+MCCHxCaA+YIK+wIVADyvccN0wI=;
 b=rnUChODLnAXo+bbLPE1qZZdb9Rmy8fqWEjPsHUNvJtdbPT689pp8MO09Z8FxEPmByp1oD13ztaIjCo0LyoJMCWb+S1/jMaHzJK9tfOIbglokgyu9bkpBfSNy7UwpEbm28Hr+aN+lPCMvYhQBvHUokAJxsgQaAfKNJASvJSWs4MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 14:40:56 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 14:40:56 +0000
Message-ID: <d7e8d2ca-e167-7c1b-3f18-45208b8ab4d5@amd.com>
Date: Thu, 18 Nov 2021 20:10:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIFJldmlldyAzLzRdIGRybS9hbWRncHU6?=
 =?UTF-8?Q?_add_message_smu_to_get_ecc=5ftable_v2?=
Content-Language: en-US
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
 <20211118093344.4361-3-Stanley.Yang@amd.com>
 <491af5a4-e6d9-6210-6819-1817f04d7700@amd.com>
 <BL1PR12MB53349DB7D7FC5FF559F1906E9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB53349DB7D7FC5FF559F1906E9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:96::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22 via Frontend Transport; Thu, 18 Nov 2021 14:40:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee3d1770-8a9a-4ebf-27b1-08d9aaa16e2c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12424A04172D01DD040221A1979B9@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REuEhFMbkZxQpkO3Mb6fiB6f8jkeeBdw6MrnJ+eBfoZjTxqfVegEFHodJd336KktqvIFRL+IqRB/oM7RXP4qewJE86uDxyJyUCqV81dm1B9izDwACNOi0AcIpB9gGXtxANwbXtrslKFYjFcQHtCqn3YfhzmjA8tuXHNXyUvUhFDbQvkLS4vPda7qZNum4pYs1R0RnnS8fF3cxJLcwjMvVkduJ66zQK8+e2A4vG9ZVuQkgAyu4+3nguwPV90DVtK9tXqPAKTRJZrslMQjhb4jHH2nutoRvGOTSBEz/0BzKU572kcho/kL+yEiZfFrmvwCPk1XyfMopt2QTKyS4V/PzHh79BlknYPnzKMegRUa/74Fxe8GmD0i62RLNvEHaomtjwlUpQ47dvnhVFj2ZOF0uMzH8duJgijqj122a7zKC/EZAkqD/tIj8RUG0TFkjPT0R25dsydfKDC80uW8tJJ8yivrzWBhBi9NV6XjfDsPOqojvrvJ0UIIL3A7SItqLgU7FpujteWOS0DYudEzRRoSmcPrCO3l9EskZX4kTtAPsoSOVVauumykX8tDeOg6Qe+jAQVsOPTokcUDqKMfd6sWuHpAAB+ccvOTBStZ6UUrAMd6FOTBC4tDLPFgWy1g78iUF7YpdXByU0Th/65LdJNCnequUbY4B1eQqTFQxgpMokrdnZkPFQt8stGH5CztclPj3T+xWAlHgdpyb+lreuKUbYOzRzU+wVVpqXMuWavSdua0IGEhVbPorAC6+/yHdKPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(83380400001)(6636002)(5660300002)(36756003)(110136005)(956004)(53546011)(66946007)(8936002)(921005)(86362001)(2906002)(66556008)(66476007)(6486002)(6666004)(31686004)(31696002)(508600001)(186003)(224303003)(38100700002)(316002)(15650500001)(16576012)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndBUG9RaGczTi9WRGlGYkRLRjhMbjhpS1dWZ251QlE5bWVYUkoxZmxmNnR5?=
 =?utf-8?B?b0RvM3EvQW1ablFrOFV2TGJGTVgxbVE0RC96OTczM0pnM29WblVsSmxwSmdF?=
 =?utf-8?B?WGR3UkxGOFZNYzh2NHd3cjlxYUFWMmhlMGZ2Q0JvOVl5MVNSb1VtOERMaXMx?=
 =?utf-8?B?a1p4bW1EYkJ1d1gya1RJL2hzdzRVRys0RFdLeEljZVk4eHZxTTVCQ21uRXd0?=
 =?utf-8?B?ck9ITGNLR0tIWEd1SkNFYmlQbVl1b0NMSGtmV2pheTVNL3VqOER4SlpXdFFP?=
 =?utf-8?B?ZnB4SmtXVkc3NFI3ckFoK2VrTHk1N1dPUlJYc2lYTHlLOGQ5U2J6YW9RYk1t?=
 =?utf-8?B?M3AvdmNNemE3dnJSOHpHOWVKbU13YUF2UHVJbHFCdUgzQ3U2dnppUVJNNXJa?=
 =?utf-8?B?Z3g1eHZGUnZoQWNiSkhWT3VLcVkveUlJc2hXMktCS0tTRTFGSWJnNlBsZURy?=
 =?utf-8?B?R3BRSGZKUjl4YVdJTUsvdXhYWXRaMlAwczBGT2lEM3U2eFRRZlFMLzAxUHFY?=
 =?utf-8?B?Ykx6MU9Za3dZMUpiSlJEUy9CdmhUN0M4c05GRGJMejI1bXFmc1QrUW5BeUVZ?=
 =?utf-8?B?eGpJSms5bVdHV21BUkFoMmtNUW5LczdWdnVLWkUxQUh5ZFM1Yjg2N2NuR1pC?=
 =?utf-8?B?djIycFM3bm1tdmZzMloraEZsOWtKVzllVFZVNUxhNk9DY0ppWGZlcEF5Kzgz?=
 =?utf-8?B?TU83U2JmZlRhMFRGajlVd2J3c1BQNTJmUUk2UUM4M0FxNWdseGIySFg5Y2JV?=
 =?utf-8?B?Q1JzcEhwbk94L2ZhSUxtUjFFejBaYThBOE9TV2VSS3hXcWUyMzVmemRhSW50?=
 =?utf-8?B?WGpGT1pkcmg3UVBjcFlwVk52RWl0blpMM2ozQ2t6Q3hiY24xNWtEV2dJeEpm?=
 =?utf-8?B?MWduYUlNOFdNbldvUVdibmNpc2hWVTc1QnZIYTdCTDJUcVQvR0tVcmtyYnc2?=
 =?utf-8?B?Qm5lOUVjV2ZWZmVub3NRbm9yK2E4V2dITm9YRktsdzVldTRBS2JTSG1ZNWdM?=
 =?utf-8?B?WUxsdnN4SVh4KzBaL2RnaEdEUHhPUUlDcy9lTFJ3b0xTdG11ZlIrcXBBb2lm?=
 =?utf-8?B?OURWOG9lempEOGRMK0tRZitmdFNHbzhpdWtUOUZyYUJUZXN2VWNHWmlmVml3?=
 =?utf-8?B?WkpwYXRlZ3BESm1NdjdyK2g0N0NvSnM0Q1ozRnh2SHg0ODlDbWFWRldDaTRw?=
 =?utf-8?B?T1pmYmxxYURDdGtwQTJiVExGTGpNdCtndCsydWc4TUtzeVlCNDdjMnhpb0g2?=
 =?utf-8?B?T2tyNk9uSHErWjNIdEMzaHIzdm9PT0lHeXdCUjd6UWtUZHRLSEhReE1EdFFr?=
 =?utf-8?B?bUJpQWV5UFh4K2F6ZFd6V0JrNzV4eW52ZzJSMzhDdUwyblE5K0M0V3Nzdm15?=
 =?utf-8?B?eVFNOWxxLzIzKzlxN01GSDBlUC95Z2M2MEl2QVRQbWtnZFFVd1d1UDhMVHJa?=
 =?utf-8?B?MDNzY0E0dGNxYTRGdSt4KzREVi9DbE9nZHlhUXBQdjR0Y2hyWndHdmtVKzYx?=
 =?utf-8?B?aGwwM1pxUnJLbVZ1R3ZHTkRXajBaa1U4OVF1b1lCdHZORHc5T0MxNzdvQjdI?=
 =?utf-8?B?OG41QTBJN0VlSHBwSlBuMTNSbFVVVXJUdDFVZjJPK1FxMVpJdU1nYlVKZVU1?=
 =?utf-8?B?M1RpOHVzTSs4LzBaZU9KUFVKU0g4YmVxVFZoOW15bVY4OUppdFFFQ0gxcEE2?=
 =?utf-8?B?MUtzN2JXUzJxbGJyVE9jTWFHTlQ2Q1pQeElpK1NBbXRER3Bta3FBWk0xM1hM?=
 =?utf-8?B?S1NZUWtQL0M2RWZjZmNRNnFGamYrYlVSQnpRRjhWOVFGb0tnbUFFQVZGeWNp?=
 =?utf-8?B?VVF0dEh0NEJWSFc2M2NTOWR3Wm8wcGdRMlpCdkphdUkzU3V0OEhCUWRaOUow?=
 =?utf-8?B?UFR3dm9QY2NnV1lDUmVQTG9uSC9WZDI2NXlrYUZmZFVyMk5LNUl2OXJVQXg0?=
 =?utf-8?B?V0NVWnYzd3pGRS9HMi9HRWd2YVBHZ0kreU5yOWpCSUNHbGpxblZFSURzZ1VS?=
 =?utf-8?B?NGZqSWFzZHVUb050ZnUwQkRoTDdMUStQZ3Q4Vk1na21EYlpYVFZhZDQyTHFp?=
 =?utf-8?B?OUo3V1dnemJwVmhodGJ5THA2NlMra0RRdjJPVVR6ZklTYWFsTVRCYWd6M2dB?=
 =?utf-8?Q?qx4k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3d1770-8a9a-4ebf-27b1-08d9aaa16e2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:40:56.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5zfOSlfP5/YdNoI8k64yPoF2aefolDhI7wV73BBwFeqTrgzziirrEBMP8OW1trC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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



On 11/18/2021 6:05 PM, Yang, Stanley wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----邮件原件-----
>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>> 发送时间: Thursday, November 18, 2021 7:33 PM
>> 收件人: Yang, Stanley <Stanley.Yang@amd.com>; amd-
>> gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Clements, John <John.Clements@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> 主题: Re: [PATCH Review 3/4] drm/amdgpu: add message smu to get
>> ecc_table v2
>>
>>
>>
>> On 11/18/2021 3:03 PM, Stanley.Yang wrote:
>>> support ECC TABLE message, this table include umc ras error count and
>>> error address
>>>
>>> v2:
>>>       add smu version check to query whether support ecctable
>>>       call smu_cmn_update_table to get ecctable directly
>>>
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++
>>>    .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 70
>> +++++++++++++++++++
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
>>>    4 files changed, 94 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index 3557f4e7fc30..7a06021a58f0 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -324,6 +324,7 @@ enum smu_table_id
>>>    	SMU_TABLE_OVERDRIVE,
>>>    	SMU_TABLE_I2C_COMMANDS,
>>>    	SMU_TABLE_PACE,
>>> +	SMU_TABLE_ECCINFO,
>>>    	SMU_TABLE_COUNT,
>>>    };
>>>
>>> @@ -340,6 +341,7 @@ struct smu_table_context
>>>    	void				*max_sustainable_clocks;
>>>    	struct smu_bios_boot_up_values	boot_values;
>>>    	void                            *driver_pptable;
>>> +	void                            *ecc_table;
>>>    	struct smu_table		tables[SMU_TABLE_COUNT];
>>>    	/*
>>>    	 * The driver table is just a staging buffer for @@ -1261,6
>>> +1263,11 @@ struct pptable_funcs {
>>>    	 *
>> 		of SMUBUS table.
>>>    	 */
>>>    	int (*send_hbm_bad_pages_num)(struct smu_context *smu,
>> uint32_t
>>> size);
>>> +
>>> +	/**
>>> +	 * @get_ecc_table:  message SMU to get ECC INFO table.
>>> +	 */
>>> +	ssize_t (*get_ecc_info)(struct smu_context *smu, void *table);
>>>    };
>>>
>>>    typedef enum {
>>> @@ -1397,6 +1404,7 @@ int smu_set_light_sbr(struct smu_context *smu,
>>> bool enable);
>>>
>>>    int smu_wait_for_event(struct amdgpu_device *adev, enum
>> smu_event_type event,
>>>    		       uint64_t event_arg);
>>> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>>>
>>>    #endif
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 01168b8955bf..fd3b6b460b12 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -3072,6 +3072,20 @@ int smu_set_light_sbr(struct smu_context *smu,
>> bool enable)
>>>    	return ret;
>>>    }
>>>
>>> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc) {
>>> +	int ret = -EOPNOTSUPP;
>>> +
>>> +	mutex_lock(&smu->mutex);
>>> +	if (smu->ppt_funcs &&
>>> +		smu->ppt_funcs->get_ecc_info)
>>> +		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
>>> +	mutex_unlock(&smu->mutex);
>>> +
>>> +	return ret;
>>> +
>>> +}
>>> +
>>>    static int smu_get_prv_buffer_details(void *handle, void **addr, size_t
>> *size)
>>>    {
>>>    	struct smu_context *smu = handle;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index f835d86cc2f5..4c21609ccea5 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -78,6 +78,12 @@
>>>
>>>    #define smnPCIE_ESM_CTRL			0x111003D0
>>>
>>> +/*
>>> + * SMU support ECCTABLE since version 68.42.0,
>>> + * use this to check ECCTALE feature whether support  */ #define
>>> +SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
>>> +
>>>    static const struct smu_temperature_range smu13_thermal_policy[] =
>>>    {
>>>    	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000,
>>> 99000}, @@ -190,6 +196,7 @@ static const struct cmn2asic_mapping
>> aldebaran_table_map[SMU_TABLE_COUNT] = {
>>>    	TAB_MAP(SMU_METRICS),
>>>    	TAB_MAP(DRIVER_SMU_CONFIG),
>>>    	TAB_MAP(I2C_COMMANDS),
>>> +	TAB_MAP(ECCINFO),
>>>    };
>>>
>>>    static const uint8_t aldebaran_throttler_map[] = { @@ -223,6 +230,9
>>> @@ static int aldebaran_tables_init(struct smu_context *smu)
>>>    	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS,
>> sizeof(SwI2cRequest_t),
>>>    		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>>>
>>> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO,
>> sizeof(EccInfoTable_t),
>>> +		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>>> +
>>>    	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t),
>> GFP_KERNEL);
>>>    	if (!smu_table->metrics_table)
>>>    		return -ENOMEM;
>>> @@ -235,6 +245,10 @@ static int aldebaran_tables_init(struct smu_context
>> *smu)
>>>    		return -ENOMEM;
>>>    	}
>>>
>>> +	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size,
>> GFP_KERNEL);
>>> +	if (!smu_table->ecc_table)
>>> +		return -ENOMEM;
>>> +
>>>    	return 0;
>>>    }
>>>
>>> @@ -1765,6 +1779,61 @@ static ssize_t aldebaran_get_gpu_metrics(struct
>> smu_context *smu,
>>>    	return sizeof(struct gpu_metrics_v1_3);
>>>    }
>>>
>>> +static int aldebaran_check_ecc_table_support(struct smu_context *smu)
>>> +{
>>> +	uint32_t if_version = 0xff, smu_version = 0xff;
>>> +	int ret = 0;
>>> +
>>> +	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>>> +	if (ret)
>>> +		ret = -EOPNOTSUPP;	// return not support if failed get

Nitpick - comment style

>> smu_version
>>> +
>>> +	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
>>> +		ret = -EOPNOTSUPP;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>>> +					 void *table)
>>> +{
>>> +	struct smu_table_context *smu_table = &smu->smu_table;
>>> +	EccInfoTable_t *ecc_table = NULL;
>>> +	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
>>> +	int i, ret = 0;
>>> +	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
>>> +
>>
>> Missed to ask last time. Since umc_ecc_info is a common struct, do you also
>> want to pass back the number of channels having data?
>>
>> Now this struct can hold max of 32 channel data. Let's say if the same
>> interface is going to be used on another ASIC X having only 16 channels.
>> Then the callback for ASIC X fills data only for 16 channels. Or, you expect that
>> to be taken care at the caller side?
> 
> [Yang, Stanley] : If ASIC X have only 16 channels, the callback only fill data for 16 channels, and caller side also need consider its own channel number to handle with umc_ecc_info.
> 

Thanks for the details. With the nitpick above and Evan's comments on 
the patch subject addressed, patches 1 and 3 are

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

2 and 4 look good to me. Hawking or John should a take look though.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>> +	ret = aldebaran_check_ecc_table_support(smu);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = smu_cmn_update_table(smu,
>>> +			       SMU_TABLE_ECCINFO,
>>> +			       0,
>>> +			       smu_table->ecc_table,
>>> +			       false);
>>> +	if (ret) {
>>> +		dev_info(smu->adev->dev, "Failed to export SMU ecc
>> table!\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
>>> +
>>> +	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
>>> +		ecc_info_per_channel = &(eccinfo->ecc[i]);
>>> +		ecc_info_per_channel->ce_count_lo_chip =
>>> +			ecc_table->EccInfo[i].ce_count_lo_chip;
>>> +		ecc_info_per_channel->ce_count_hi_chip =
>>> +			ecc_table->EccInfo[i].ce_count_hi_chip;
>>> +		ecc_info_per_channel->mca_umc_status =
>>> +			ecc_table->EccInfo[i].mca_umc_status;
>>> +		ecc_info_per_channel->mca_umc_addr =
>>> +			ecc_table->EccInfo[i].mca_umc_addr;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    static int aldebaran_mode1_reset(struct smu_context *smu)
>>>    {
>>>    	u32 smu_version, fatal_err, param;
>>> @@ -1967,6 +2036,7 @@ static const struct pptable_funcs
>> aldebaran_ppt_funcs = {
>>>    	.i2c_init = aldebaran_i2c_control_init,
>>>    	.i2c_fini = aldebaran_i2c_control_fini,
>>>    	.send_hbm_bad_pages_num =
>> aldebaran_smu_send_hbm_bad_page_num,
>>> +	.get_ecc_info = aldebaran_get_ecc_info,
>>>    };
>>>
>>>    void aldebaran_set_ppt_funcs(struct smu_context *smu) diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 4d96099a9bb1..55421ea622fb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -428,8 +428,10 @@ int smu_v13_0_fini_smc_tables(struct
>> smu_context *smu)
>>>    	kfree(smu_table->hardcode_pptable);
>>>    	smu_table->hardcode_pptable = NULL;
>>>
>>> +	kfree(smu_table->ecc_table);
>>>    	kfree(smu_table->metrics_table);
>>>    	kfree(smu_table->watermarks_table);
>>> +	smu_table->ecc_table = NULL;
>>>    	smu_table->metrics_table = NULL;
>>>    	smu_table->watermarks_table = NULL;
>>>    	smu_table->metrics_time = 0;
>>>
