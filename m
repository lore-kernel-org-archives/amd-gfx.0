Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4952C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8972E61155
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8972E61155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE676E882;
	Wed, 14 Apr 2021 14:02:53 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D306E882
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 14:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLJFWI7Ua+Vh0cWFClvN3z0awiMA6GtVWRZ1s6Q+49nKXz6cUqD/Q2/LbOREwuChG2Dxmj5WxmoJEaE12GXO+HLX+E7nyJ3T4BV1X7e3yujJtS3r70pGeuYiPb8BT0tKRL4FVKF+8PyMfUzfn2Uo1XGTGOaImpoq7WeRV84Iu8Dmb1VWZXkEvKUuQcm5WQkdznmxFLooA3hs6H8NzfEgbDzvCXSXziGFSESudKJtNkAIuQQi0EUy6ocjgq4nw6L5BolAAAHHHWh8G+rQ1zxtsIggQ6Xn8iWi6n6qVMltfWS1U7afqQbtHgFjXIj0wgmkvgVIXS9K5GKGoM5sVuQiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SD+jbstT7B8jyES2BZvPgWRg9gmCKKTFwRNvk0WmOo=;
 b=OGQEEKamVaA3saJBMJsOj9hfnew3ZTkTKlCGeLmC+kPtb3vvhferWptJsBm6dmw9OZS7Mq+qnLsYPIQkAxTi9UMFTTne3n3fboQi2Gn6mjKfJwYVi3FoxzJUF2t1+xKDs1TvjpM6JAF0Ab3W0UzvnNtVTxpb7dRn32iYK74ZzHwnGvfDZ7pXTKBijSzmpmENTeURYlsrjWCEbo4kLdgxdHeL/LiFFa/kMum0jaqycbqkptR7lItcfety8Nrpq2l7CXVYwtpUrkwBacS3hPESQyyK3AfJuyh0/etyxroLanqNeLmgWyBBLpuISBnt0qJGDJ67v4MbwNZ/x4JkwCk1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SD+jbstT7B8jyES2BZvPgWRg9gmCKKTFwRNvk0WmOo=;
 b=aAgd78r3n5OHwoHyS7r08zRvdZPZiwLPTHKTOjAIh2z7J2xyODXl9BSgO2U5wgaghlfjt17+0bz0x/hu801swaM0q0AyOz0u4PejiHyHHbtHA3hXYItpudxRAZiwI/QJ2lS/RJCHdMLokfoYvN6Id1tP4dLhhsETyxjQ8VERvZI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 14:02:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 14:02:49 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix checking return result of retire page
From: Luben Tuikov <luben.tuikov@amd.com>
To: "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210412011508.35024-1-luben.tuikov@amd.com>
 <CY4PR1201MB007214EEE4658567FC2B1C18FB4E9@CY4PR1201MB0072.namprd12.prod.outlook.com>
 <291d8e06-5d32-f3ce-2949-1125879bf1e8@amd.com>
Message-ID: <71fa82a8-602c-b05e-ea2e-5a3733562648@amd.com>
Date: Wed, 14 Apr 2021 10:02:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <291d8e06-5d32-f3ce-2949-1125879bf1e8@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0120.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 14:02:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6dfb2ef-46c2-47d1-f005-08d8ff4dfcb6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB235959833E9FD348D30EC805994E9@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5DwRs+EmN8DhoWrtqJF9QHJhVN7BXPZmMVC13HXcZvBB4QblXit4mqAOtyo52oBD9b8N0rZkadBc2Nn15Q2YD31f/vZB4ubve76W8vXZcQTte6+tFIwagh8z4+RkClzFNOIgifBYU4VE3r1U4B0kH7mAkblRDSDcRfYJ0wnsnPAc13z3DneCxv48iNn/aOhpoplSuQFsZ+0KzIU+XlNJxG1WQffmTTNiklJMr0t6GfX06CNiuJUhk7BO5Bp0Xoe+to+sk2FZtYJ22LD/zva7VxFymrYEAFfBYyqpDIH5sbgebWXRbZoKDxWhd1jmt2BUU3wdwiNA3Z6AvadVJRBdLT3KlVqq0Vf1zJnZQAFYm6GDPlk5q/VxQGUHa6KIPaqlueD5adiqMwOjp/1mwo0ektqBV5WP1wosKnWEvy0CLnd/X0G1eAQoEij8jQSAJj3UIW1ZxRTPu80kRFIRAB2D1KcMrI9P2KyH+vOFGO8gPXQ7wJ9/bYW0ql+vGSrGoLabd5xrOeD+WH2B+6SlXouduPy0BFt19P/C213FlzTQ3q1kGqhehBWZe/x/YsjC2jeN7VXJ4naFcv19IUDpHm9sArSGQwuguDllnH9S6DfyiSonKWo2IQxZnKSLpYqK3wla+U8GwJ3+uTDRN4MeGq5HYdZmCXTXz9jS6arx/oOleEU4jDpj1fP/67KMtK9mwou
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(53546011)(6506007)(8676002)(44832011)(83380400001)(8936002)(66556008)(4326008)(66476007)(55236004)(5660300002)(26005)(186003)(31696002)(36756003)(54906003)(6486002)(478600001)(2906002)(38100700002)(316002)(16526019)(31686004)(956004)(2616005)(66946007)(86362001)(6512007)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WHhHYjZCR1FTc2JYNDcwNkgrQkJmWTFRQXZsdFRnSjAyN1VISFFVYnJpTnN6?=
 =?utf-8?B?MWZEeVJPYmVab3RuRk13bDNDdForRTlvWnRLYnphNHVSanN5Y0ZMOWViZG16?=
 =?utf-8?B?RmN1ekNjOWlGRURDd09HSUVEU2pVeHlLSW9PcWdrSkR2cnBjTWFMZWxIWm9a?=
 =?utf-8?B?V1NQM1dDNHZtM2t5TXVkOWpvMEZ0QWxVSWRNVTVkWEdNbkxzSnBCM1BxelVV?=
 =?utf-8?B?ZUR6Wlk2eDZpZjkxelRsZzFZTE5OdmVVRkd2MXJ0V2NuL3NlZDkxWmdqMTJB?=
 =?utf-8?B?bWhRaHgvMHRsL0huRmxRVEhvdnUzTVpOYlpqVytEVGQyWXhIUS9ZemoyeGIv?=
 =?utf-8?B?VWwvSnlDb1MyeWRyNnoxbU04T3dtNStidVZkRkNYZHkrN0xkb3luMHRVMzhM?=
 =?utf-8?B?aXVaRS8xamhpd2dIejJ1VS81eFkxbXA3NTduMXJleEF4eHFFcjM1Q0pjcVZ4?=
 =?utf-8?B?djBNZDkwMFFZQWRZK25MYzUwT2QxOEtra2twYmVHSlVDT0V4MEMvZm9PR0lY?=
 =?utf-8?B?OFVxbkNCZWM0dDhrTzU1anNsNCtNUU9WRnd3QWFld3ZvclZvVXFqaHE3RjAw?=
 =?utf-8?B?MEVjS0t2Ukd5dVNVajJqLzNENTcwVUQwSkhVWmFmeHVYbXR4a1lieG00VkhP?=
 =?utf-8?B?QWFtWEsydDhKV2draWtrR1BxQ2hVcGJ4aXNGVVB2RG1SSHowd1RPcmlsOXlh?=
 =?utf-8?B?TmYwRWFNeHMvYXdSTG9rNDQ1WWREWStvenFlOXVJNkwwUm96QmtWaUc4MDBN?=
 =?utf-8?B?eVRJcTV2NGRnYVVMa1ovQ3VNeHVaY1c0MHJXMUdISHl4bmZKKzBSazRJbDNt?=
 =?utf-8?B?a25HYXBxeDJMU0J5Y0Z5WE1YNm1tSURFYm1oYVZVQ2ZLYWxtcERIV2ZkOXNq?=
 =?utf-8?B?QVd1WVFlUVE0cG01bW81MEF5NkIrQVBudG54WGNRa0I0dHJZVndzYm1pR0VE?=
 =?utf-8?B?U1Q3Y01rOFdFVmJna1Fhc2tvdndHNmtDWnFsVXZsVUpwdVUySmkyV1JsSGVp?=
 =?utf-8?B?ajc1Q0xFd2N4MVJyWnIxaDBtRWVCdjNDUGxnam5DOFR0NjRPdEdKQnMydzRm?=
 =?utf-8?B?YnFHS1kzZHlVcFNPUGNiWXdhMmYzTUI3WnFBNnZsNzVOa3J2Ykg3cFJhTTN1?=
 =?utf-8?B?enJuYTlweWdkY3BLbXlReG1HaFFBTUlaaExCTEF1a0ZIaElHWlZLc0N3Z0dP?=
 =?utf-8?B?U1h4N3VSMGIxaER3SzJ2RjU4U0oyWXU2cUpLaHVZbEl0MkJCMGVnNXpRL1lj?=
 =?utf-8?B?UWZXREwxSnNNVjBYNDE4V1ZqZkVaZDRRUHZnN1ZkQkpNVURmcVUvQXB5UXJW?=
 =?utf-8?B?dkhzTnhBTjJhMVdiZE41MDFGdmZxUzdadDJENTh0WjhadWF3SDdXQUhQNVE2?=
 =?utf-8?B?Vkg4NXNhaTZnT09ibkpiczNObzBhQUxKYXRFNERZekNyR1JwdWdhdVpndXV0?=
 =?utf-8?B?S2VnZDczeS9RTDZicVovZDFCekVXYmJibWVqYW16ZDBKNjA2UjV3cnBvOVRS?=
 =?utf-8?B?RFdIM1gvSmxWNStaNHl6clQ5RE9YTVlhb090Y0tUYUZrYzJhNkNyTTZhcDVq?=
 =?utf-8?B?aFJpZjV4M1hjV0Z4eFM0MFY2R1pidmdpays0MUgyRk53eHJDbGVzd3dzdE9w?=
 =?utf-8?B?dU1kU3lodE5KcVlBaXpvNUJ3MnR4VWdRL3E4eEFXSU8rMjgvU1lhUyttVDFo?=
 =?utf-8?B?U21Bc0xSVW9wZGl1Y0l4cG1BYW0rQXl4YTdkcmtYVlhYUUpqK3Y5bWYwM1M1?=
 =?utf-8?Q?SKf39Rn3PVm+iUuItYp8pfQjReMXGrq9Ye6TfUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dfb2ef-46c2-47d1-f005-08d8ff4dfcb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 14:02:49.2446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED2jeeb6IQ0Ucgr+HfA7B5c1uRZ9crEq0IkDpkBU+58AqXnXgvNwnM5gKnfRk6Wc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

You also seem to be missing a leading parenthesis.

Regards,
Luben

On 2021-04-14 9:58 a.m., Luben Tuikov wrote:
> I'll take a look.
> 
> For the time being, you don't need parenthesis around != conditional as && has lower
> priority, i.e. the parenthesis are superfluous.
> 
> Regards,
> Luben
> 
> On 2021-04-14 4:19 a.m., Clements, John wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Thank you Luben for re-organizing this source file and fixing those bugs.
>>
>> Please add back support for decimal input parameter values, maybe something like this:
>> +			if (sscanf(str, "%*s 0x%llx", &address) != 1) &&  (sscanf(str, "%*s %llu", &address) != 1))
>> +				return -EINVAL; 
>>
>> My concern is that there are tools out there that use that interface, so I wouldn't want any side effects there.
>>
>> Reviewed-by: John Clements <John.Clements@amd.com>
>>
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com> 
>> Sent: Monday, April 12, 2021 9:15 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>> Subject: [PATCH] drm/amdgpu: Fix checking return result of retire page
>>
>> * Remove double-sscanf to scan for %llu and
>>   0x%llx, as that is not going to work--the %llu
>>   will consume the "0" in "0x" of your input,
>>   and a hex value can never be consumed. And just
>>   entering a hex number without leading 0x will
>>   either be scanned as a string and not match,
>>   or the leading decimal portion is scanned
>>   which is not correct. Thus remove the first
>>   %llu scan and leave only the %llx scan,
>>   removing the leading 0x since %llx can scan
>>   either.
>>
>> * Fix logic the check of the result of
>>   amdgpu_reserve_page_direct()--it is 0
>>   on success, and non-zero on error.
>>
>> * Add bad_page_cnt_threshold to debugfs for
>>   reporting purposes only--it usually matches the
>>   size of EEPROM but may be different depending on
>>   module option. Small other improvements.
>>
>> * Improve kernel-doc for the sysfs interface.
>>
>> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
>> Cc: John Clements <john.clements@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 67 ++++++++++++-------------
>>  1 file changed, 32 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 0541196ae1ed..c4b94b444b90 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -114,7 +114,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
>>  
>>  	if (amdgpu_ras_check_bad_page(adev, address)) {
>>  		dev_warn(adev->dev,
>> -			 "RAS WARN: 0x%llx has been marked as bad page!\n",
>> +			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
>>  			 address);
>>  		return 0;
>>  	}
>> @@ -228,11 +228,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>>  		return -EINVAL;
>>  
>>  	if (op != -1) {
>> -
>>  		if (op == 3) {
>> -			if (sscanf(str, "%*s %llu", &address) != 1)
>> -				if (sscanf(str, "%*s 0x%llx", &address) != 1)
>> -					return -EINVAL;
>> +			if (sscanf(str, "%*s %llx", &address) != 1)
>> +				return -EINVAL;
>>  
>>  			data->op = op;
>>  			data->inject.address = address;
>> @@ -255,11 +253,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>>  		data->op = op;
>>  
>>  		if (op == 2) {
>> -			if (sscanf(str, "%*s %*s %*s %u %llu %llu",
>> -						&sub_block, &address, &value) != 3)
>> -				if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
>> -							&sub_block, &address, &value) != 3)
>> -					return -EINVAL;
>> +			if (sscanf(str, "%*s %*s %*s %x %llx %llx",
>> +				   &sub_block, &address, &value) != 3)
>> +				return -EINVAL;
>>  			data->head.sub_block_index = sub_block;
>>  			data->inject.address = address;
>>  			data->inject.value = value;
>> @@ -278,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>>  /**
>>   * DOC: AMDGPU RAS debugfs control interface
>>   *
>> - * It accepts struct ras_debug_if who has two members.
>> + * The control interface accepts struct ras_debug_if which has two members.
>>   *
>>   * First member: ras_debug_if::head or ras_debug_if::inject.
>>   *
>> @@ -303,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>>   *
>>   * How to use the interface?
>>   *
>> - * Programs
>> + * Program
>>   *
>>   * Copy the struct ras_debug_if in your codes and initialize it.
>>   * Write the struct to the control node.
>>   *
>> - * Shells
>> + * Shell
>>   *
>>   * .. code-block:: bash
>>   *
>> - *	echo op block [error [sub_block address value]] > .../ras/ras_ctrl
>> + *	echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
>> + *	echo "enable  <block> <error>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
>> + *	echo "inject  <block> <error> <sub-block> <address> <value> > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
>>   *
>> - * Parameters:
>> + * Where N, is the card which you want to affect.
>>   *
>> - * op: disable, enable, inject
>> - *	disable: only block is needed
>> - *	enable: block and error are needed
>> - *	inject: error, address, value are needed
>> - * block: umc, sdma, gfx, .........
>> + * "disable" requires only the block.
>> + * "enable" requires the block and error type.
>> + * "inject" requires the block, error type, address, and value.
>> + * The block is one of: umc, sdma, gfx, etc.
>>   *	see ras_block_string[] for details
>> - * error: ue, ce
>> - *	ue: multi_uncorrectable
>> - *	ce: single_correctable
>> - * sub_block:
>> - *	sub block index, pass 0 if there is no sub block
>> + * The error type is one of: ue, ce, where,
>> + *	ue is multi-uncorrectable
>> + *	ce is single-correctable
>> + * The sub-block is a the sub-block index, pass 0 if there is no sub-block.
>> + * The address and value are hexadecimal numbers, leading 0x is optional.
>>   *
>> - * here are some examples for bash commands:
>> + * For instance,
>>   *
>>   * .. code-block:: bash
>>   *
>> @@ -336,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>>   *	echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
>>   *	echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
>>   *
>> - * How to check the result?
>> + * How to check the result of the operation?
>>   *
>> - * For disable/enable, please check ras features at
>> + * To check disable/enable, see "ras" features at,
>>   * /sys/class/drm/card[0/1/2...]/device/ras/features
>>   *
>> - * For inject, please check corresponding err count at
>> - * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count
>> + * To check inject, see the corresponding error count at,
>> + * /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
>>   *
>>   * .. note::
>>   *	Operations are only allowed on blocks which are supported.
>> - *	Please check ras mask at /sys/module/amdgpu/parameters/ras_mask
>> + *	Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
>>   *	to see which blocks support RAS on a particular asic.
>>   *
>>   */
>> @@ -367,11 +364,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
>>  	if (ret)
>>  		return -EINVAL;
>>  
>> -	if (data.op == 3)
>> -	{
>> +	if (data.op == 3) {
>>  		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
>> -
>> -		if (ret)
>> +		if (!ret)
>>  			return size;
>>  		else
>>  			return ret;
>> @@ -1269,6 +1264,8 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
>>  			    &amdgpu_ras_debugfs_ctrl_ops);
>>  	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir, adev,
>>  			    &amdgpu_ras_debugfs_eeprom_ops);
>> +	debugfs_create_u32("bad_page_cnt_threshold", S_IRUGO, dir,
>> +			   &con->bad_page_cnt_threshold);
>>  
>>  	/*
>>  	 * After one uncorrectable error happens, usually GPU recovery will
>>
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
