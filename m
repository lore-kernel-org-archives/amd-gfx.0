Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26318C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 12:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB42D61163
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 12:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB42D61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6374F6E196;
	Wed,  8 Sep 2021 12:40:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776956E196
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 12:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/GLRgW6gbRe67r1ChniFQOCmiddeO6dd5xqYkkYdR5h2HxHcTYgIWwpPeIc030Kaz02Bbz7q7NexkYqks+wnSr5Te8G8Hp4O5kz8PXNV7ETRq2xGoQo7S+XLtBW6pGITU3qwk1JltogPbg65+v5m8uz56ntrypCKyAWYEGt4UhRjAwYLOP2mAet7L62OSjzN53lPjLWMcK4O7c50DPeWuYc6jW+pHMk5jr1kfIrhicH6gqNfEX/KU2Xbp93tJPFK1h96BgExABXd9aDRhUlchTWfPWZzu2p3enczW4aQlenF5itzXnuSGBB6RDgrL5H6phm7dDWdjM2Zp4eeVvEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1nd7Rdfr1t7qFTPeLlaS33B0tJK6CHrNHwNCOSpfVrc=;
 b=d6IxfL356lNn0MbLk+FkABPgpsJmdURI4PkqzLXHFIGSxSJvUoM4OYufOMIoPGPdJ/7Pp6XIQkuG0YPrDClJRu5iu4p+Reuj8DBWCRVQWJDRdAmIxJMzUIFpBbwaqp9xt3yVZ1SJL3Z8SOPqEqvHm3TuBMZCyOlIhO7MtRVziv1N6z5McLcOGvZjCfuiUzfV89AUu517g9gFzXjloD5JxL3f4MHbjxdHLSfMenkfCGzFDEuO7+KGin2shLcgFMEJFlqnjIco79drc8IAkrSY3lFFoH2lmdgWHjV5dWP1NbdTOn8V76u36qb/5KmPxjhW8es5KP5tNUw0tBHukezzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nd7Rdfr1t7qFTPeLlaS33B0tJK6CHrNHwNCOSpfVrc=;
 b=feO4nNa9xt0Oy8U0cz7w0j3/0/EiSIt7zrXOdpyQvlqAeSA31GLT9dG5ttubkgHzEXYgLcfrztelyG9Ohg0lLU7fS3QDP8E67ts2d+GSd7foJPezvhHZRHuJpwqqup3ZJpnuupZuLeI8+R7KbjPBblMydsCoLtmrYHS1AvO8Fqg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 12:40:23 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 12:40:23 +0000
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: "Yu, Lang" <Lang.Yu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>,
 "Powell, Darren" <Darren.Powell@amd.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
 <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
 <DM6PR12MB42503D11F0508C47B5735F61FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fc3af46e-65fa-7156-3c83-08c08e1a83b0@amd.com>
Date: Wed, 8 Sep 2021 14:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB42503D11F0508C47B5735F61FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM8P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:e9d0:54fe:9083:60ce]
 (2a02:908:1252:fb60:e9d0:54fe:9083:60ce) by
 AM8P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 12:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08276720-e676-4504-8867-08d972c5d34f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048A2EB47F4F605D66637D883D49@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIyPCEBLAiLo+TRGBRCJk+wHayszsHx/cnm1mQpfZBUSek23urql4TrZVZPEi+Kgz1a8fEw9xpcamuKnxWqwcU6b+ZjG5C7Zfk5GTNmYmcX0At0SBbPEI06h8C29oxAp1foicd26bhTvZq7bhJs8Hru4yU9leoztGE/YN9ktN5rq1l8C0j2QDH9nDc+Z5vGREIBquyTzFLiUEbG0OITvFEQ2G6SUNypreIznwA14A5+kyjX3uSjDtfCjNRmBXYvMis1Vd6D+ci0S7Oa8y2Ig3MQi+CGfXJXDWz3p0AKsNsgJm6ACRUUFpMXg65KJ0e8+XqA4Sk4Z9SLLd9ypVDyNZHVZwHIFIKJJBN6GAQYSpAMQ0xVfzIstzeTDExfIJQmDT2M6b3/UN8jxegbdglxye46laiONU0lMDkher7WiMudDJMHG9YvWKYpXe2mBC3YFeIg6T9fl/zU6FdazB0QOpGfzptbrJRCaFJHfUDh0mSEJTHOpGr99TnWp3+P4N/Kac4IqKOU0tLl4I8PFMkWN2T9ol6kv6YmZFbzhWAqjiSbYQZivTmwnNeUH7n1ebNrvU+BBnKRmrTLbbTljxcSmA/Yim8X0ns+i3a9NkGDlXV3HP0EkLaqhhVHLyMFDBu10QZ8GfesfgUzKZ2rN1SbI0Dk41Au5d0bQJEkzND8n4nPgjF2L3MSmBxvAfQRIzT37y6tNyoz02a4iToJG5gAu0827SSnXvPXIdJssXdj57a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(66476007)(66556008)(38100700002)(36756003)(66946007)(6666004)(5660300002)(31686004)(8936002)(31696002)(478600001)(86362001)(66574015)(83380400001)(316002)(54906003)(110136005)(6486002)(2906002)(2616005)(8676002)(53546011)(186003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNYalN2WmxYcHJaSTAwMHJBSkZNYUtMd3hlUTdvT3dabFdRTCswZ2VFNUNR?=
 =?utf-8?B?OFdPZWFaTFZqc2FLeUN3RThyQnZoT2prakZKV2x3S1RkMXJxR2o2S0VJeGM2?=
 =?utf-8?B?Q0x0cGlLRklRV1RFWmRzK3pzQ0xRVmdGRTBoSUNtRDB4aFNvTHBwS1Vmd2lQ?=
 =?utf-8?B?ZnZEb2MwaE5EbHdQaWRVa0ZPcGJrRVcwK3hzV3YzY21LT3Byak9LNmJoa2hz?=
 =?utf-8?B?RjRvRjd2Z0ZWZjV5dUUxVVpubEgrY205MnlBNWtZbkhRbEUybFdvb2FvZDkz?=
 =?utf-8?B?a2VONFdXcUlLQmpYaEtRc0RieGlBNTRNRzk4eXlMU3drck82ZjErUmhiekdE?=
 =?utf-8?B?Y0VoRlpHZFF1NUtSRnlNQWFWUHJzWkdjcW9yVTVOSCtvSjhreTdpS3pVWlgv?=
 =?utf-8?B?TkY0b3NoR2VsdmJRY0NkYlBXbjR4SFBZSmpMVnIzUW94VnMxSmkyVCtzeGl6?=
 =?utf-8?B?MjQ1OFJDVjMvSlYwSCtHeWhpaTU5d3M3cWxlZUt1MGlUS3NvcDJiV0Ryd0c0?=
 =?utf-8?B?d0hTWWZNblV5SlFlTVo5N202a2F4aXcxSnhFekMvN3RuMkdOcEc4YU05WFdE?=
 =?utf-8?B?M1dwL0dyekQ2R1VMNjZaQWpiMkxZaU1yY2FTRzZrQnFXQ21QYVM2eTNwMHFi?=
 =?utf-8?B?cEs5aWtieERsN1g0aGlQTVRZZ29Zc005RGpMV2djWkt4cERNVjhmMEswVkZG?=
 =?utf-8?B?VTRVZVQva3BReGdwdGlJMFZWSS9KWW9YaVJBS1NoUVBjaVpWTStINkttK1Zp?=
 =?utf-8?B?QzdFSTdIZG4rZit6Y2ZNSTlmbjNiS2FDSEp1UzJqS2t6L2JsbmV3TGV3YnBP?=
 =?utf-8?B?ZmhYTjh0UU5iUEs0U29XMEZYMkNEbExaZ1l4MXpocmY1dThtNkkzckI4dlZh?=
 =?utf-8?B?TkRNUy9KNWJ2VVordWFodi95TVdpc25uOUNQcnc4eUV0bFp6aTl4ZENRdjlJ?=
 =?utf-8?B?YVUrRlgyZHNrUTNSUHRzNW5yMU5kOE1rNG0vNGFmeXRhYTRMa1BJbWZDN25K?=
 =?utf-8?B?L0lzcTJuTnNUZnF3Y0prQjkxV2pQY25vL2pRYWhmYW9vMDZNOG94QWt6Sm9P?=
 =?utf-8?B?LzFDS3g3YVNMc3p2MUFZWTZEcU42VDZaRWljeldRRG1UOFE3ZE1wWUQyV3JT?=
 =?utf-8?B?b3VqdkxnWkt4V2p1MlBGZG9ZT2R3L3dpUnRmalJkaUVSU2VrQXplZTJVYWIx?=
 =?utf-8?B?U0lvNTJqT3ZSZHdqQ1AxVGdoLzJ4d1d2aWVjZjF4Tnhza3RVejdjSEVRVDY1?=
 =?utf-8?B?ckxDVHcyQWJQckFXVHFjeVlkNjdXZTNsOVlwK00rSDRoUG1OdGRRbC9ZelVl?=
 =?utf-8?B?cE5YeExKdWltRERFNlNlMUplenhpVWlSKzV1UWxKL3lqZ0dGME1Va1JCc29s?=
 =?utf-8?B?UFBvZitIczh5QjQ2Zk5sWjJYeEJPZ016ekg4OVlRaitIOXpjUmVjWmR3MkJw?=
 =?utf-8?B?NXlkMlBpZlZQWkl4MjI1TWRWNGY3VkEzTTZrVXdaUlN5ZWxMbzlza1VPWkkw?=
 =?utf-8?B?Z093RlZzNnV0cjBUbzdQOWxFN2JzTExHT0ZoY1djVlpNZGp2MW15SjFUZndj?=
 =?utf-8?B?L0hRVmpITHE0SGFtQmhVSWNyRERpRExNLzZYT0xXVVZFUkg2NUs5d041TmtF?=
 =?utf-8?B?SGpyTnovb05lMlpNRGo2T1JDWjBOSlBCNkRVS3hoQ2F3Q3hTeG9Ha09STis2?=
 =?utf-8?B?N1huS2VxVFZGZFJxQ0dERzlwdHlQUDFMNkJMK2tqeHhGejdiMitnSEZjV2Qx?=
 =?utf-8?B?ZTFJYWF1RkZNd09xUnhwMjJJdWZYcERFVGpERWhPcWR5NHdkMW5CTVYxZS81?=
 =?utf-8?B?amRNTFJyMWVScnNIVnJpWkF0ZWd1QVVDYVNyZUNZZlJDZDFRU1lOQnZYRWVZ?=
 =?utf-8?Q?5tdwYqBWgp4H4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08276720-e676-4504-8867-08d972c5d34f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:40:23.5301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtCKn6YiiPU2+gvq9CXOcFERG2myjTDfrrJ3UGh3cR1+VVe7z9tPZcyc3jsmNK2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

Well that's complete nonsense, in that case we should rather go back to 
the s*printf functionality.

The problem is that we are not using the sysfs_emit/sysfs_emit_at as 
intended, e.g. something like this:

offs = sysfs_emit(page, "first...);
offs += sysfs_emit_at(page, offs, "second....);
offs += sysfs_emit_at(page, offs, "third....);
...

This is usually done inside the same function and not spread around in 
the driver.

Regards,
Christian.

Am 08.09.21 um 12:55 schrieb Yu, Lang:
> [AMD Official Use Only]
>
> Or try to send a patch to remove page boundary aligned limitation. Any considerations? Thanks.
>
> int sysfs_emit(char *buf, const char *fmt, ...)
>   {
>          va_list args;
> -       int len;
> +       int len, offset;
>
> -       if (WARN(!buf || offset_in_page(buf),
> +       offset = offset_in_page(buf);
> +
> +       if (WARN(!buf,
>                   "invalid sysfs_emit: buf:%p\n", buf))
>                  return 0;
>
>          va_start(args, fmt);
> -       len = vscnprintf(buf, PAGE_SIZE, fmt, args);
> +       len = vscnprintf(buf, PAGE_SIZE - offset, fmt, args);
>          va_end(args);
>
>          return len;
> @@ -760,14 +762,16 @@ EXPORT_SYMBOL_GPL(sysfs_emit);
>   int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
>   {
>          va_list args;
> -       int len;
> +       int len, offset;
> +
> +       offset = offset_in_page(buf);
>
> -       if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
> +       if (WARN(!buf || at < 0 || at + offset >= PAGE_SIZE,
>                   "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
>                  return 0;
>
>          va_start(args, fmt);
> -       len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
> +       len = vscnprintf(buf + at, PAGE_SIZE - at - offset, fmt, args);
>          va_end(args);
>
>          return len;
>
> Regards,
> Lang
>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, September 8, 2021 6:22 PM
>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>; Powell, Darren
>> <Darren.Powell@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
>>
>>
>>
>> On 9/8/2021 3:08 PM, Christian König wrote:
>>> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>>>>
>>>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>>>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>>> warnings
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>>>>> [AMD Official Use Only]
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>>>>>>>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>>>>> warnings
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>>>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned
>>>>>>>>>> buf address. Make them happy!
>>>>>>>>>>
>>>>>>>>>> Warning Log:
>>>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0
>>>>>>>>>> [ 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>>>>>> [  492.654805] Call Trace:
>>>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu]
>>>>>>>>>> [ 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>>>>>> 492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu]
>>>>>>>>>> [ 492.659733]  ? preempt_schedule_common+0x18/0x30 [
>>>>>>>>>> 492.660713]
>>>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>>>>>>>>>> dev_attr_show+0x1d/0x40
>>>>>>>>> Mhm, that at least partially doesn't looks like the right
>>>>>>>>> approach to me.
>>>>>>>>>
>>>>>>>>> Why do we have string printing and sysfs code in the hardware
>>>>>>>>> version specific backend in the first place?
>>>>>>>>>
>>>>>>>> This is a callback meant for printing ASIC specific information
>>>>>>>> to sysfs node. The buffer passed in sysfs read is passed as it is
>>>>>>>> to the callback API.
>>>>>>>>
>>>>>>>>> That stuff needs to be implemented for each hardware generation
>>>>>>>>> and is now cluttered with sysfs buffer offset calculations.
>>>>>>>>>
>>>>>>>> Looks like the warning happened because of this usage.
>>>>>>>>
>>>>>>>>                    size = amdgpu_dpm_print_clock_levels(adev,
>>>>>>>> OD_SCLK, buf);
>>>>>>>>                    size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>>> OD_MCLK,
>>>>>>>> buf+size);
>>>>>>>>                    size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>>> OD_VDDC_CURVE, buf+size);
>>>>>>>>                    size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>>>>>                    size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>>> OD_RANGE,
>>>>>>>> buf+size);
>>>>>>>>                    size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>>> OD_CCLK,
>>>>>>>> buf+size);
>>>>>>>>
>>>>>>>>
>>>>>>> [Yu, Lang]
>>>>>>> Yes. So it is fine we just fix the caller
>>>>>>> amdgpu_get_pp_od_clk_voltage like
>>>>>> following:
>>>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>>>>          struct device_attribute *attr,
>>>>>>>          char *buf)
>>>>>>> {
>>>>>>>      struct drm_device *ddev = dev_get_drvdata(dev);
>>>>>>>      struct amdgpu_device *adev = drm_to_adev(ddev);
>>>>>>>      ssize_t size, offset;
>>>>>>>      int ret, i;
>>>>>>>      char temp_buf[512];
>>>>>>>      char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>>>>>                           OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>>>>>
>>>>>>>      if (amdgpu_in_reset(adev))
>>>>>>>          return -EPERM;
>>>>>>>      if (adev->in_suspend && !adev->in_runpm)
>>>>>>>          return -EPERM;
>>>>>>>
>>>>>>>      ret = pm_runtime_get_sync(ddev->dev);
>>>>>>>      if (ret < 0) {
>>>>>>>          pm_runtime_put_autosuspend(ddev->dev);
>>>>>>>          return ret;
>>>>>>>      }
>>>>>>>
>>>>>>>      offset = 0;
>>>>>>>
>>>>>>>      if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>>>>>          for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>>>>>>>              size = amdgpu_dpm_print_clock_levels(adev,
>>>>>> clock_type[i], buf);
>>>>>>>              if (offset + size > PAGE_SIZE)
>>>>>>>                  break;
>>>>>>>              memcpy(temp_buf + offset, buf, size);
>>>>>>>              offset += size;
>>>>>>>          }
>>>>>>>          memcpy(buf, temp_buf, offset);
>>>>>>>          size = offset;
>>>>>>>      } else {
>>>>>>>          size = sysfs_emit(buf, "\n");
>>>>>>>      }
>>>>>>>      pm_runtime_mark_last_busy(ddev->dev);
>>>>>>>      pm_runtime_put_autosuspend(ddev->dev);
>>>>>>>
>>>>>>>      return size;
>>>>>>> }
>>>>>>>
>>>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe
>>>>>> another arg to pass offset along with buf?
>>>>>>
>>>>> [Yu, Lang]
>>>>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>>>> Though it's not a problem based on codeflow, static analysis tools
>>>> might complain.
>>>>
>>>>> Or we just rollback to sprintf/snprintf.
>>>>>
>>>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took
>>>> the effort to convert these, he may have some other ideas.
>>> This is not what I meant. See from the design point of view the
>>> print_clock_levels() callback is the bad idea to begin with.
>>>
>>> What we should have instead is a callback which returns the clock as a
>>> value which is then printed in the amdgpu_get_pp_od_clk_voltage() function.
>>>
>>> This avoids passing around the buffer and remaining size everywhere
>>> and also guarantees that the sysfs have unified printing over all
>>> hardware generations.
>>>
>> The scenario is one node used for multiple parameters - OD_SCLK, OD_CCLK,
>> OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with lots of nodes). On
>> top of it, the parameters supported (for ex: CCLK is not valid on dGPUs),  the
>> number of levels supported etc. vary across ASICs. There has to be multiple calls
>> or the call needs to return multiple values for a single parameter (for ex: up to 4,
>> 8 or 16 levels of GFXCLK depending on ASIC).
>>
>> I don't know the history of the callback, mostly it was considered more efficient
>> to print it directly rather than fetch and print. Alex/Evan may know the details.
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>

