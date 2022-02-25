Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E3AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 07:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A819110E503;
	Fri, 25 Feb 2022 07:43:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467C710E52C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 07:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8Nzu2//b91tKUIFaE8fzl6N8hU0dGQ2K/p3P+vlWRa57sf5reTi10TE0HrLFPeD9gmMTwMZuKb9rBWTE6dCQBzG91HwwMixTrPvVt+p4lN9QbbIiKKIvnAY2+Aeda+CprWvIzTMdsfwXyrCFho5Mljy4TERFyLxTMmTKygmKT0bSdyFdudCFgUe61Zw3qU7XU487b4dQlvN3Y8r3qpAxAZfORlxdgBkkXFikWscm2adr115Ip2kXDeDRqhtrOZyEkd0kyf92jHMXyNnCciRfQIyltxq9jBwhVO8qENDRNlQetB9ScTEs6vM7v5dDuXPXmMivNTYctFDnHKFoU0kSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNkrw/aGsOjvrnu1wZ3Zj7I/1nUyzIo8+cSR0iiRQo0=;
 b=WGNaJifrKJPWoTBbCFH5ZNe2rcxOxAXr33PVd6fznDl/mKrABOBSVZqQOlpn3yZrNuHDVe3ArqFjeG/utCyMQDLJmXjHoGnoRUnAyns/8BppqZKyezjnmQ7YSV69pV7c0JgIch9q2h1mqM6HrEAKh773oLOXvZoct+4c23aJbYn+V6Q+0maUxvvWB8BHXEfV5AqnaP2ib/x2TRYsJmzh8FHXYhgGAzc+buDtyJfmTC8zxNjrFW8rJEFuwEPFXTuemSegkOz0xVEuYFQAlz/h2o2xOHDjcdlcq1Q8XJgzsSkWzKF3TamX01N2bXCBH4hbl35QIAWJH5SlXMAwrQOyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNkrw/aGsOjvrnu1wZ3Zj7I/1nUyzIo8+cSR0iiRQo0=;
 b=WnQN8o/dtenobZcWaak1hx+onh+HWTsMW1FtsvIV4eckQPL1yUqQKU7nIQOxyh3yV21P+XhS2Mb5NtwDP7BuQEh8l6kKZ2EzLPHdBsN9yBlY/R4D5YCtZv1yOxsuD8MEurviL0ONYDEarM0NaSNU9RncHeLfx4dgBwZoLl0YLL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 07:43:29 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 07:43:28 +0000
Message-ID: <955cd7a1-6a93-9043-d065-dc45d149fd13@amd.com>
Date: Fri, 25 Feb 2022 13:13:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
 <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <DM6PR12MB26192A826B2B5DF65ED8ED5CE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <2bb4e178-b224-ff6a-e730-47ab780e44ca@amd.com>
 <DM6PR12MB2619810DBC53C6430A03535FE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619810DBC53C6430A03535FE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15513dc3-6e7b-4c56-046c-08d9f8328330
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0256:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0256B5A94EA3CA4C6ACE632A973E9@MWHPR1201MB0256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYxWkl67Q//PtjQJJF3nYNEyGzWNfTtIJzgSeC1iEQnVWBvn4rr8Qiwy8nC8XEqZMyHz6HZxZfZTJLU5TZ9C0bZ3WBgl50uyF7mr+BNTuP1LTOB4Ion6SAPIZaMajDf414KOri6PS5MY1I2Xk3hiOkz7JdJ+wXEyGR5EHIgNvf1zuCLspbLIpH4Csnm5R7Weimg5kzlNt1a8Q8HpnCGP5ieI0EOko20AtVrvQCusjxxlhZqtsRve4Nt+Jc5KVYksPOoHs5tOsabfjj4oDa7AGgeFC/ux1hO1kJr7zZWn9YBrfQiS7kmfoPWbtGDgdlhrS4dZ//pcRNUZrJcrvYSUEfkzgPu8UZaJm4xxdvnPGFxZg4xOKmx71rGG6AfqOdIB+7Kjnjyh79NA87W+zBxJj2jp3I2X4tNvn+OdJQxH0cH8Jg3cdjvGsczfCcac/2VhHid5he+v4p0Xnozu/T8iJR5Ztq6dw0glxHCRKlq98PNVXtbRpUJGgHbEsw4peftCgUL7klAaxKzI1zm7i2Asx0EkwHZKvlHqMWqgEu8AIYZtWZ/YVquVYHRuSuL7EoIhNdRjzbqtCyUAFRVksT9umsYUcuRaGr3ltBpeXdFKVa3jALbX9fgg1Vc87pFRd2byh08CkydTdcJfkVWym2Ynxf0vsfGsxdsqET/Oij1wuSVnNET55qt5E4wh3s5HNa9xsExtcfarJYjGWYk/nGLZAXPvRAGWUg/22cfm5nlgzV1uOikEctWMAojjoolpf1FX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(2906002)(6512007)(53546011)(6506007)(6486002)(508600001)(316002)(186003)(26005)(54906003)(110136005)(83380400001)(36756003)(31686004)(2616005)(86362001)(31696002)(5660300002)(6666004)(8936002)(66476007)(66556008)(66946007)(8676002)(15650500001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFwUjhsYm9GUG52OEJ2VG5UNVlXdUo4N2E4bjczYnZHWFZXbTVodkppMnNF?=
 =?utf-8?B?RG93NFJ5WXZpQXh1bXVweWRScWs2UmdMditYU1VHeDlncTBta1dmNnp2L3ZT?=
 =?utf-8?B?TG9BblhaQ0c2b0cwa1RBRWlocFZYQ1I1Q0pIb3YyY3RXQVRsN2RNdkVBRHJN?=
 =?utf-8?B?UDdxZzRqMFB5bi9jOUZZU1NPckhyWEpYUVlUMkJDQk92dGFmejlMUDE2L1dr?=
 =?utf-8?B?QmxSd0lwRy9GcEdnOTJDTkhoMHloNnF6c1pQdGhzVk9Xck4vR3NSelV1MEZT?=
 =?utf-8?B?V1FFZzQwL21OUFBFOTZ1LzNremRPa01nbWdaMkx3bjBobDc1MzdNZ2Q1SlZE?=
 =?utf-8?B?aGM3czlBR1NuUkhSeXlTbTh0dUsrRFVna2NpZ2czb3JOWmdDRlYvWXF3MExk?=
 =?utf-8?B?cnVHZTRaZGJYaTR0WkVKK1BZbGFMckdTY2doWVVWTDQ1aXBLWEJyK092Rmhl?=
 =?utf-8?B?czM2VTFNc0RnRWtVazNhNHBJVE83YmFmOWpGSGZ0TGdoUGgvM2lzRFdsYWsr?=
 =?utf-8?B?UjFCM2ZpME01Nm4yL1VGRlNsVjVMUHZveWxMQWFkZzNCVFVwVkxGRGllallt?=
 =?utf-8?B?QXZYOU5hanhmeFk4RWROVGRXTXdyUCtYUkhNU1ZCTTJJMjEzTGdPSFRGZmE3?=
 =?utf-8?B?bFNWS3F4WldDTW9xMUY4TFZwSkV6MWlzNVVOVk5xNllNeStmbERmZnUrVmdx?=
 =?utf-8?B?YjRBOHFaZWN0UXNsbFJWOENPRm5pUnNiSGRtTk0rSTIvbFgzVGRHVjhmdThF?=
 =?utf-8?B?VW5qZjNpZmZYRVdrVFFLNG9QVW4wRVN6dVgzbm02OVlNMy83NlZyNkI3cktT?=
 =?utf-8?B?dzI5dkcyTzBZc2p5YXE2ZDcveE82UDR5S2loYkkxQlhvWm5qTnppblJzZVhs?=
 =?utf-8?B?YWdicXorakhmNC9QelNoUm1UdTlHaHh2dzlWTmc0TzJxeW5YcjJnTkdkWVVE?=
 =?utf-8?B?dEtVSUxlSDJjbUh1NUJlQTlSV3gvazJTSmRITFo3NTI0aERXbkE1cjdKeWhR?=
 =?utf-8?B?c1hFZWtJTWt6cWFEdlJKL3pzcXVmWDdMV0tHNzI4YndjdVc0ci80VnBBSE5i?=
 =?utf-8?B?MktkVmZrdXBBeDZNZzNpWnFGRlYzT2NLRWQ2ZU0rT0J1ZFV2WldoSk1JdldD?=
 =?utf-8?B?SnI5K1FBdGJQZldHQWI4amZncC9WazF2dHRTRS8zb2t3WVBneGxFaVJyTnlD?=
 =?utf-8?B?VG9ma0VGUHRMaWFXK0JqY3NQR3lEMXBMME1TMlFVSnYzaVRkbEJxZjMvRXlC?=
 =?utf-8?B?WDlaUllTQkVrYU9SZlVnOTZKdG5YK1BlTktDQmNFTW1VV3Y4Q3RQdDJ5N3kz?=
 =?utf-8?B?d1g2OUpCQkdZSzBLa1hYZ1cxSk95MVlJeXhVSTBZblY2bk1tZ1VoeVBQbUJV?=
 =?utf-8?B?T0FzZTNDNmdCbDJmandCQm1iNno3MkoxQWlVRGhpUnpIWUxQdUFUc2VwWUJi?=
 =?utf-8?B?N2p1VnBGMkF0NkYzY0g2S2FZRHRnUjJLaDk4QnFPN0IvZjNXQkZhMnlvSjkw?=
 =?utf-8?B?dXhFTk00bjVsWEJDQ2dZZnY2NzRkM0QwVnVuZTVudHp3UW9MelBIVnExV01p?=
 =?utf-8?B?bUJzKzhlTjhZbVZkZDBCdDlMNkUxb3R6MUdqMmJsUlhYWlI5a0Z4bktzM0Qw?=
 =?utf-8?B?SmFrbVAyM2x6dkNSbHhVRnNwekJuS0JZZWNqMFZYdjd1ZG5tOUZBYm9oRzdt?=
 =?utf-8?B?Q3Q1MTMwM1o5VXZBKzlBSTkrOW1GSmtRbkxPVko0Z25NaGtUTStIcjVUb2lk?=
 =?utf-8?B?VzBMQ0t6VkxSS1BxWXBVSU5xQXk2Sm43SlZaZ3FoVVR4a0Q5N0xYQ3JuT05t?=
 =?utf-8?B?MFJkQml1d3R6a3JZVitmaVYzcVErRmdvR3AzRGtVbVlVMXg3UFAwb3Y4ZHVW?=
 =?utf-8?B?ZWpxaTdyWjBEb0VBc2I4c0t6bWJvaDZHZUNYT1hqT1YzZHZpRlhEYzI5VWhn?=
 =?utf-8?B?WWdVa2ZRbkZESlZEUVZORUJsK0JhS1VsZHJaRHlDUXFNaU5CNTlWMzBTNjVG?=
 =?utf-8?B?eDBmb21nS0xaSUNoVFdIbEdrTVQ5RlB6dVBuZUV0VklLN3ZSb1VLaGwyT29T?=
 =?utf-8?B?enhlY0tLaGZJSWl2K2RqSDFDakFtMEJzRlArYW5Fc0p2cjFiTDZVeDFnQ0dF?=
 =?utf-8?Q?CXT4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15513dc3-6e7b-4c56-046c-08d9f8328330
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 07:43:28.7963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UID7330OjFdFqDjfNVhsEHQJKYhNq4nCRpF/6b45KchCkCT6uewUdFH7SPDZpw6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/25/2022 1:02 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 25, 2022 2:03 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>>
>>
>>
>> On 2/25/2022 11:25 AM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, February 25, 2022 1:47 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>> <KevinYang.Wang@amd.com>
>>>> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is
>>>> 0xFC
>>>>
>>>> [AMD Official Use Only]
>>>>
>>>>> That is the caller can perform something like issuing the same
>>>>> message again without prerequisites check on PMFW busy
>>>>
>>>> This patch expects this method. Caller may try to resend message
>>>> again. As part of message sending, driver first checks response
>>>> register. Current logic blocks sending any message if it sees 0xFC in
>>>> response register, this patch is to address that.
>>> [Quan, Evan] Yes, I know. But the caller here could be another one. I mean
>> there may be another caller stepped in.
>>>
>>
>> That shouldn't cause an issue to the second caller if it got message mutex.
>> The second caller also should be able to send message if PMFW got free by
>> that time. The first caller can retry when it gets back the message mutex. FW
>> doesn't maintain any state for 0xFC response. Any other message may be
>> sent after that. If driver keeps the state based on two callers, that is a logic
>> problem in driver. I don't think we have any flow like that.
> [Quan, Evan] Yeah, but there may be some case that messages issued by the two callers have dependence.
> That means the message issued by the 2nd caller should be only after the 1st one.
> The one i can think of is "EnableAllSmuFeatures" message should be after "SetAllowedFeatures" message.
> Although that should not cause any problem, I'm not sure whether there is other similar case.
> 
> What I suggest is something like below. We just do it again in smu_cmn_send_smc_msg_with_param() on PMFW busy.
> 
> int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> 				    enum smu_message_type msg,
> 				    uint32_t param,
> 				    uint32_t *read_arg)
> {
> ...
> ...
> 	mutex_lock(&smu->message_lock);
> 	reg = __smu_cmn_poll_stat(smu);
> 	res = __smu_cmn_reg2errno(smu, reg);
> 	if (reg == SMU_RESP_NONE ||
> 	    reg == SMU_RESP_BUSY_OTHER ||
> 	    res == -EREMOTEIO) {
> 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> 		goto Out;
> 	}
> +retry:
> 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
> 	reg = __smu_cmn_poll_stat(smu);
> 	res = __smu_cmn_reg2errno(smu, reg);
> +	if (reg == SMU_RESP_BUSY_OTHER) {
> +		mdelay(1);
> +		goto retry;
> +	}

I suppose the retry option should be left to caller. Regardless of retry 
or not, the patch is still valid.

Example situation -

rocm-smi is trying to get metrics and another app is trying set 
performance profile. If metrics fetch fail and even retry of metrics 
fetch fail after some loops, rocm-smi is free to fetch the metrics again 
after say 5s. That also shouldn't prevent the second app to send 
performance profile message and that app also may retry the same later.

Thanks,
Lijo

> ...
> ...
> }
> 
> BR
> Evan
>>
>> Basically, 0xFC is not valid pre-condition check for sending any message. As
>> per PMFW team - it only means that PMFW was busy when a previous
>> message was sent and PMFW won't change the response status when it
>> becomes free.
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>> -----Original Message-----
>>>> From: Quan, Evan <Evan.Quan@amd.com>
>>>> Sent: Friday, February 25, 2022 11:07 AM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>> <KevinYang.Wang@amd.com>
>>>> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is
>>>> 0xFC
>>>>
>>>> [AMD Official Use Only]
>>>>
>>>> This may introduce some problems for two callers scenarios. That is
>>>> the 2nd one will still proceed even if the 1st one was already blocked.
>>>> Maybe the logics here should be performed by the caller. That is the
>>>> caller can perform something like issuing the same message again
>>>> without prerequisites check on PMFW busy.
>>>> Or we can just update the smu_cmn_send_smc_msg APIs to give it
>>>> another try on PMFW busy.
>>>>
>>>> BR
>>>> Evan
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Friday, February 25, 2022 12:22 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>>> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>>>>> Subject: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>>>>>
>>>>> When PMFW is really busy, it will respond with 0xFC. However, it
>>>>> doesn't change the response register state when it becomes free.
>>>>> Driver should retry and proceed to send message if the response
>>>>> status is
>>>> 0xFC.
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
>>>>>    1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 590a6ed12d54..92161b9d8c1a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -297,7 +297,6 @@ int smu_cmn_send_msg_without_waiting(struct
>>>>> smu_context *smu,
>>>>>    	reg = __smu_cmn_poll_stat(smu);
>>>>>    	res = __smu_cmn_reg2errno(smu, reg);
>>>>>    	if (reg == SMU_RESP_NONE ||
>>>>> -	    reg == SMU_RESP_BUSY_OTHER ||
>>>>>    	    res == -EREMOTEIO)
>>>>>    		goto Out;
>>>>>    	__smu_cmn_send_msg(smu, msg_index, param); @@ -391,7 +390,6
>>>> @@ int
>>>>> smu_cmn_send_smc_msg_with_param(struct
>>>>> smu_context *smu,
>>>>>    	reg = __smu_cmn_poll_stat(smu);
>>>>>    	res = __smu_cmn_reg2errno(smu, reg);
>>>>>    	if (reg == SMU_RESP_NONE ||
>>>>> -	    reg == SMU_RESP_BUSY_OTHER ||
>>>>>    	    res == -EREMOTEIO) {
>>>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>>>    		goto Out;
>>>>> --
>>>>> 2.25.1
