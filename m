Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ECFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 13:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BF560E0B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 13:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24BF560E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7390989FC8;
	Mon, 25 Oct 2021 13:58:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C46789FC8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 13:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8j23qUawrIo4aBQvffB54pqVVq4Cz0XVXd0YKZdBDQzzkxtqVrJiAsVAat/fLxAQ8yEFWMfkzgpcuNpGo/hoLLeOi4MVFDfcdqLnUPG5PYaLsp0HzqVGk0HASZ4FHYFvLKLXOX7w9aTbTye2g5MlSVypNtVYn9kLI7WjTPEBb9VDPhC+1Y6EWdjnQKAdHfACf2+ngPjtM9b0vVoHLq9LcXEZLEWQj7RSeHfgMfZMGCMksXhGtdEIkDNlfGLsHNZx2f4D/puwMS6AlSGDTH/2hz60A+TZtwZhCwXh3gt4kByLy3gTrxzANnsCvauGB+8KZNiiwUc0kWEh1FMAWGGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oGr+CLsXKj6/hg5KJAtAY9ugnSdaVBjtfWFdeWlpcU=;
 b=BZGmJ53PfQ6CEsLoNs3+AEDnCm3u+wSQHEjMB1pz2TRkCDzAkZnA5zF6hvYUiAByMmvwIhmJKKjpcFvwbL3jVy3R/CPXr+Y3EZUo6WH1lxYp3Ai05rb4+xRSi6fj3pIWKR+KZHawHdSAfUn/g0p3CryjgI5bEZQXlrGf1tDddVB/OKCgogfRH3j9U9PtJmUilvm/fjLDJL9iDRE+b3vlo+ONNHrS9nr2Y6XdJiJlwanY7EbGwdYQbRZuI64RDunQFiLy6IkDCGWf387HQtug9nNW4oZKSwsGFWwrPt2LHiQtHpdLQoXVaaqRbcIsOFAZtU37Vhk97Vt5XF4qcIV42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oGr+CLsXKj6/hg5KJAtAY9ugnSdaVBjtfWFdeWlpcU=;
 b=P8d2dYXBC/x4koPwMHukA7e4INEj39y6scu6ypFs/z4zUUVoLZ5vu0X51bjnSdcQeGwU1mAMMTB7iOjDZki2tAbyz20FUCdxWofJl3z0qsvtu5LAapU3uKDZ3XR8t8b212rC2qL/zO46h/cJSgd0SdhEAmlvKthqfw7r6GIhLXE=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 13:58:46 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 13:58:46 +0000
Message-ID: <93093738-86a1-056e-08fc-803aecee27f1@amd.com>
Date: Mon, 25 Oct 2021 09:58:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 32/33] drm/amd/display: fix link training regression for 1
 or 2 lane
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aurabindo.Pillai@amd.com,
 qingqing.zhuo@amd.com, mikita.lipski@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, wayne.lin@amd.com, stylon.wang@amd.com,
 solomon.chiu@amd.com, pavle.kotarac@amd.com, agustin.gutierrez@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Eric Yang <eric.yang2@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
 <20211024133141.239861-33-Rodrigo.Siqueira@amd.com>
 <16010bef-7bf4-1da4-9f76-7b23d4296d5b@molgen.mpg.de>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <16010bef-7bf4-1da4-9f76-7b23d4296d5b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:408:fb::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.35.183] (165.204.84.11) by
 BN9PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:fb::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 13:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed0182e5-fd06-452d-3166-08d997bf8ff6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:
X-Microsoft-Antispam-PRVS: <CO6PR12MB539683BA99BAA3928CC394878C839@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H313/l3NlMGzbickLihkM48wJaWvloIz6d7jZOowql6CJfEMRwAUBBFi1hmrmJbKXqZG/oxCV9TEBpdAOUHmMiprZlwet3QQNPUW7TE8kjLynrFBavwUrCD0IPiWA+3C4DYq6fPjFeFtVRtHd7ZlvYIGL3YaSzMbXjNPIhWfVQnAN57QddXjFONvkD5+8JUwXC9htIA3m6T2JZaZkjAGRVp0HIT9X9qa5/SFPV3lp7To291cdSlhXBzJ44lWp0AxevslyXFXfuuP6gFswU9iWWXzg7BdR0wMPWP6JjatqOYNSyFITd9nG7g/ZQlwqcDG8lGSoxvc/4phPChn1/0P/MhMh9OeEzCtEF1sOskQxcN1SBvxegQRvKdLOKw8YaBh1pWTG/WYhoshcGuiAzMqsKw6Ci5kj8mM4UWOaGELMXsBguJpVIaa4Mmloqc7/1sN9IOWhdrO97PkG4rmT1CyyYv51Q2IDp+/AlQJ2eJKyFaeqjNyA+zWQzGWdfBHcTG25825Ob+7dLOQ1PtYMvtz9yrv33apL+16Glso/eYfLD1/Z65JEU9FRalMc0AzdIXrZuJuddRYomfBcCz+f0gsbuQ80NNOnn0sPl+mYtghVF5xs7bc/oV0BcXOXWGCmjoSDRFYKRRAhhtBpNbWMzH5BdnlhcL7Ab6ic/CdUt8s0yfL2xQmKW/GeZJMEXu0PzVi4HnI6MS4+xQ3sKue9Eq9pXpi+kUG02w5LvpfpeJE1ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(31686004)(38100700002)(54906003)(26005)(508600001)(5660300002)(110136005)(31696002)(2906002)(4326008)(6486002)(4001150100001)(186003)(16576012)(44832011)(8936002)(8676002)(36756003)(66476007)(83380400001)(53546011)(66946007)(956004)(86362001)(6666004)(2616005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTdRRUo5bVdBb3VMWWxiR3ZWRjBjVkJHQkxNMEs1SkJuK3NnVGI1R0Y0ek1u?=
 =?utf-8?B?TVZwT25Rdnc5MytaTWFBZ2VuNjkxNWtsY29LZWRFVEdTZzhRZUw2YW1CUnlz?=
 =?utf-8?B?T2JBRnRqSzNtb3JrU2swL01Kdi9DMUZ2MEdvb0grK3VkNXYvWHNYT1ZYM2ZG?=
 =?utf-8?B?dVZMM211eGwvcWhxOFN6RzBWNXE5eGxiMkNPVG91eEh0VGRERTI5ZW5vSTJr?=
 =?utf-8?B?cERoaXdrSHRGYkYyOFpYL0VpK25WMThLOE9SRFUvWVQ5Vk8rblFwRjRia1hK?=
 =?utf-8?B?TXJ0cERiYlRvdG9SMEQ0Z01QYU5WT2tPRVhSNEJxdExidlNaUG42Sld2Y2F2?=
 =?utf-8?B?b3JxallCWmtCVzhQY1hZNFAvWXF3MFp2elFhWWd1LzltdEdadGhIZUdZWnpa?=
 =?utf-8?B?U1JLUGdCM2xSVExSZjFKSHQ0dGNJdmtJY0dIbGRyeHVYZEFlbUswc01zZFZX?=
 =?utf-8?B?VTBUVk50OVdrOEkwK3RoTTg5U0FFOHVqeFhJeG5jSld2WHN1RUJhZVRUdkIv?=
 =?utf-8?B?S05oRXdDWE0veFdpcnVjbW0vWFNsWGZaOFZ2RkV2VTEvbTJPZHB0WjhIbjhp?=
 =?utf-8?B?aEJiUGQzWld2ZWpmbFdVdDVhTitLQVNDVTFlWGx2TzdvT1Qzd3Rsay9QYlIz?=
 =?utf-8?B?K29IS3gvcU9VR0FjSmpIN0JJY3Mvc0toR2JKYVRCTnMyaWNNOXRRWDh6L3Nn?=
 =?utf-8?B?dlhNQituVW9tSkkrYW5LbGZFVnUxRTFPNm5FQU56M2dIRlREM21xUUVVTFJP?=
 =?utf-8?B?elNvMG5Idk8yUWxsTFA0TzdCQ3FjZVQ0d25ycm5sNXp3OWRTeWxRSnNxVVFn?=
 =?utf-8?B?T0xjWVNmZjcxbFo0WldKQjZRMDlDREo3eGZDQmxOTUVKM1FSOGJ1UjNxU0JC?=
 =?utf-8?B?Sk5nZG9LemVGeFNYMWw0Wldoc2Y4dUc0Q1VJREJqYmpYcnZRa1A2c01aM1NU?=
 =?utf-8?B?WHhIVE9WL1hiNGRzdU9DU293SmhNS1Q1ZUR6dzZTdHllVUJUMUVBbWNJU0l6?=
 =?utf-8?B?bEkrOUNQWDZncXZ2ZG10amJuMUp0ZExrMDhrNnZZNlkyM0Z3dkxybUsvUm95?=
 =?utf-8?B?L21EOUJ3NDNleWlnYzUzNG5Ob2pVdkRrQ3JQWGp5cUQ4cTNYS1B3LzdDK0Fr?=
 =?utf-8?B?dE52T2k1SjdGeFBWQ245MTd5TndFbEVLZ0Z2WDNrRFhtanZqUE9EczdxQSta?=
 =?utf-8?B?V2I1d1Zla0FtVFQyeWxlbzN6d0hPZm5HSnBVZWV1VUdkQ2EybWFMWjRQSFFy?=
 =?utf-8?B?M0RRdmVlTE8vRk12TTNhdi9adkI4TW1oMUpSVzQ1MmRGZzFYYnVTVzFPZkgr?=
 =?utf-8?B?aE8zNVYrcCtuRGYyckVpV3VwMEZPL2xtRzR6MEd3YmZKd0lYYVhJSWdmQi9Q?=
 =?utf-8?B?SVFSczAxcWVxdVZiRE9lKzFwa1VFTHQ4VlBKQ1JneFJTcnlYdGEwMmJqTUhR?=
 =?utf-8?B?SFN0V2IzbmgwVk9najQwNFFQNVVLbDk4TENhRUVBU0pKQTRQYzF6NUUxRDgz?=
 =?utf-8?B?NnNodTF1eUVqaVd6MFAzcDJqVmFmM0ZKQU4xNFpZTVJPWml4b2NWMU5UMVd2?=
 =?utf-8?B?bWlkY0Z6SlNBVW93cXRPN2NIaFcwWFpybFBxN1dGMGNyUXBidlZJTmxtOFFG?=
 =?utf-8?B?VkZmYXJkUWRjTXBNU2hqUWZvVlFGWjV1bkptTjg2OEVJMzVBWWMzb3BYUm1t?=
 =?utf-8?B?ZmtoNXdLdStEU1pHaDF6d3hkWnNjMHZwMWpLdHVsQytUOEJqbHRrbEZXbGhz?=
 =?utf-8?B?Q2VFYUxWa3FVNFdZTmFIWGRzQ0NSVE8wOXFhWGhTam5PQ2FDQkJ4NzA0OFZ6?=
 =?utf-8?B?VDFvQWwvM1Z1UnFjNUh0dmI3Tld1WGwweW02UzZOc0VYVUhhc0pxSlp3TFo1?=
 =?utf-8?B?L2c1aXRCaGs1ZDBhRWlwbVFDa2FaUVVZd0lDWlJRQklINllKejdkWEdjSVAz?=
 =?utf-8?B?WVdCVjVQaFB2VWZhZitnUS9vWmpLY2tuV2c3S1hrVHp4OTJKTmx6U0grWWpF?=
 =?utf-8?B?b3c0MmtvNkluazJjWDhMbGRCWXBwNlJQODVGUnh0SEFQMlhsU244WTUxaFRR?=
 =?utf-8?B?TkRmdi91bzVSWE84OXJBVnNkdnh1RXN3WWhTUVUrV2djVzhYWHRsQnV6amVN?=
 =?utf-8?B?Q1ErZzBCWU1UZjdzeDJBbURzNWo3cGF4SUNQQ2dib1B4L21LeUJBOGJlRVVx?=
 =?utf-8?Q?RQq8cAZt8AyUn7gBmJGET40=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0182e5-fd06-452d-3166-08d997bf8ff6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 13:58:46.4219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPytMt6kmNOo3MB/ONy0dbudL206qsBPmXlHH0coqq645bwr7ZZ7xT+gUZ01ASxRCQhScwG89Vcu7nJeLGfzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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



On 2021-10-25 07:25, Paul Menzel wrote:
> Dear Wenjing, dear Rodrigo,
> 
> 
> On 24.10.21 15:31, Rodrigo Siqueira wrote:
>> From: Wenjing Liu <wenjing.liu@amd.com>
>>
>> [why]
>> We have a regression that cause maximize lane settings to use
>> uninitialized data from unused lanes.
> 
> Which commit caused the regression? Please amend the commit message.
> 
>> This will cause link training to fail for 1 or 2 lanes because the lane
>> adjust is populated incorrectly sometimes.
> 
> On what card did you test this, and how can it be reproduced?
> 
> Please describe the fix/implemantation in the commit message.
> 
>> Reviewed-by: Eric Yang <eric.yang2@amd.com>
>> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
>> ---
>>   .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 35 +++++++++++++++++--
>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index 653279ab96f4..f6ba7c734f54 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -108,6 +108,9 @@ static struct dc_link_settings get_common_supported_link_settings(
>>           struct dc_link_settings link_setting_b);
>>   static void maximize_lane_settings(const struct link_training_settings *lt_settings,
>>           struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>> +static void override_lane_settings(const struct link_training_settings *lt_settings,
>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>> +
>>   static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
>>           const struct dc_link_settings *link_settings)
>>   {
>> @@ -734,15 +737,13 @@ void dp_decide_lane_settings(
>>           }
>>   #endif
>>       }
>> -
>> -    /* we find the maximum of the requested settings across all lanes*/
>> -    /* and set this maximum for all lanes*/
>>       dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
>>         if (lt_settings->disallow_per_lane_settings) {
>>           /* we find the maximum of the requested settings across all lanes*/
>>           /* and set this maximum for all lanes*/
>>           maximize_lane_settings(lt_settings, hw_lane_settings);
>> +        override_lane_settings(lt_settings, hw_lane_settings);
>>             if (lt_settings->always_match_dpcd_with_hw_lane_settings)
>>               dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
>> @@ -833,6 +834,34 @@ static void maximize_lane_settings(const struct link_training_settings *lt_setti
>>       }
>>   }
>>   +static void override_lane_settings(const struct link_training_settings *lt_settings,
>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
>> +{
>> +    uint32_t lane;
>> +
>> +    if (lt_settings->voltage_swing == NULL &&
>> +            lt_settings->pre_emphasis == NULL &&
>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>> +            lt_settings->ffe_preset == NULL &&
>> +#endif
>> +            lt_settings->post_cursor2 == NULL)
>> +
>> +        return;
>> +
>> +    for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
>> +        if (lt_settings->voltage_swing)
>> +            lane_settings[lane].VOLTAGE_SWING = *lt_settings->voltage_swing;
>> +        if (lt_settings->pre_emphasis)
>> +            lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
>> +        if (lt_settings->post_cursor2)
>> +            lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>> +        if (lt_settings->ffe_preset)
>> +            lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
>> +#endif
> 
> Normally these checks should be done in C and not the preprocessor. `if CONFIG(DRM_AMD_DC_DP2_0)` or similar should work.
> 

Interesting. I've never seen this before. Do you have an example or link to a doc? A cursory search doesn't yield any results but I might not be searching for the right thing.

Harry

>> +    }
>> +}
>> +
>>   enum dc_status dp_get_lane_status_and_lane_adjust(
>>       struct dc_link *link,
>>       const struct link_training_settings *link_training_setting,
>>
> 
> 
> Kind regards,
> 
> Paul

