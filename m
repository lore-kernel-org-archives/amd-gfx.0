Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6760BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2787560527
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2787560527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83656E98F;
	Thu, 28 Oct 2021 15:08:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33AB6E98F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 15:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7oFQ3k8hsZgE2tqxxsVWLzGkFRBjGAP1JfIi5nl7tfwHzpunEogg1tY8IRn8D4BVPThbqifvV7Pzb3BcQAA3rw8ICaw5fgJSDbp8VC8lKHumTwG7PVQtbwzKQnQnco5u2IGZqa4nkdN1RAx29Mo7HN7aW3BFIjH+yRLpyWf4sDEYpBxsSgrP9tO8dEXqLbgTnqtg7GCeyzTqCdSM6q5b6M3inkSsxnbW1i6fvlkoMpjmpCn8hjqWNIq9kSMDxcZbfS+vhMh/wlnqiVJc3NJMFbrfiM0iW5vRxoWRit1FEn39cYLQYBkbpiw27KdmfFW4FBiHt+HSmM8NRoVeEaKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGOB8O3RTu9cso8XYP8KpsU+EnL31GHayhJ9tTRRnE0=;
 b=k3zHgrHRaE+9EsxWkq6NGFnY6wKPz4a2ayrUaPCtvq7vdpShUUWJoVGNvCmHhHOLFHpHxjde5TOPc+d0RRTlvwE+KGlYLh6ghvhs2dS0Xb/C83CGS5dt586B2TO5L8bAXrVvepT5py8gMU8XiE/W0bCHL+qgdYzMklEzEnnVsL0noMDifzprldYD9xhBTx8tNYeR6Uo61BzQslNHkCi7p05du11ZEYVsc9Mp7PhRiMOaznBeYJEwVWlvfwXVqvNhaidXahDrfTIqbDB64gURLrG5kYdY9bGlBGbT494o2m6jB0W/u9Nu7sq7KK4rM0v8+t4LGBBS23vMfqvSlawf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGOB8O3RTu9cso8XYP8KpsU+EnL31GHayhJ9tTRRnE0=;
 b=WIwEZ0btZeQ8wCS3p0Pqa0x5ALvU/L9vKQg1gcZARUkIXRpFbZlsO60LLo0AXZF4adTaSAsIYlg/wHMptjRNkdXHxU4S8SJLQJegiG4rswGYXEdoSCpafzURMYh9qqfoNyrrfOnOoWZYecY1qRJ/qJcf7hSFvml6JFSRkaSIJs0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 15:08:40 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%7]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 15:08:40 +0000
Message-ID: <29b528b0-be09-6f91-b2fc-cbe74ee74176@amd.com>
Date: Thu, 28 Oct 2021 11:08:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN
 is not set
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20211027223953.1776162-1-alexander.deucher@amd.com>
 <CADnq5_NkHjMYMJpXMirvd7KDaOH8kF5t+XE9qiVoeR_DcfMxiA@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <CADnq5_NkHjMYMJpXMirvd7KDaOH8kF5t+XE9qiVoeR_DcfMxiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::25) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 LO2P265CA0301.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 15:08:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77609a35-361d-4f54-41c4-08d99a24d300
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5325F0B1B1B5E2AB8918DA7EEC869@DM4PR12MB5325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4QAkL/zrXznM0cLQS3W/TxDFZFbLd8bbdFoRxwLh2SKIYJuZbR9W+k1ZbD1hEGet6Bj3ROSTPrxb6BHRdWKT7wpMrCQ70cdzK7Ccn1bQiVKaBA6o8sV0TLuVoogNTptsRS1RfJ44F25UMs901VEMYqQO3huz69NQE3kYDziHCbqwr96cH6rehlUhFSBN4vDziO8OGPmjWRIpd9CFJDQE0J/YBJYW1oQnR8D5nC6nKMB4YzzV3Nj0QJClHVVcrop1wKjRMhksyF43Q/MWaub03BkZkgUXt3dJnA28LlvuLI38TW1NQZmWe1a+Dx4EfCC7n3L5NZcxSDeFQg/9HU9+HMnto4oW1TS300UnAgVVqMETOL7cMb2tIU26ehy8tf1UnkOR9YW+1Q1+1cYL7qUAGgDMjHjELQj3TyV9I6MCWQ32F1LqY5Yml1AaerJ5lBQmi5kNhIcjWcNYIji2+EWVI/hlo0qkMZJ27OGlW4NBDBxEZRpQsUO+5myD8TODLSgs8Hg+om/NO/2V1meRNC0Ckw6+juowKpVxbWM5rJDjA0u1frgxtZUX73zNKalOnAj38JckD1km+Nmnr6NVQ3TYLQq9C+rDnvWaR/8kTM66qd6OvR0YjARcT9ayHwm4fDhj6EhjLAGoOSk92ftsTEpVqZ1Q9bMsBhywGylAt1xTSE7xZLTkVCA84y7woUhlYqtryu3cWWjGFVdSJ52BJS1/73r9gRQLR6RBhSwaGU23w8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(8676002)(86362001)(110136005)(36756003)(6636002)(4326008)(316002)(66476007)(83380400001)(66556008)(956004)(66946007)(2616005)(16576012)(2906002)(8936002)(5660300002)(6486002)(508600001)(38100700002)(31696002)(26005)(6666004)(186003)(53546011)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVuWjV3TGZ6bSt0WkFhd3JpOThUU2dZaWVLTExibDFuZjBIUCtvOFQwcUVx?=
 =?utf-8?B?dndWK1BlM0wrdE5TWkMwTUYzVW5EbUpjdXZvcmNSb3B5bTkxbzVBV3pPQUlw?=
 =?utf-8?B?eVVwOFFoK29qcC8zWjZNd1ZJUkEzR3FTN1hyZUdsTGN3VWN2QkpjUXRPMm00?=
 =?utf-8?B?Ry9JYmRwQW1RWTh3WHlvZlZqMXAwMXcvWldycXpHVHFQQStueWI3M0F6V2lv?=
 =?utf-8?B?eGkraWpzYXNIeHljbUhNZTVoVmdqN3hDdkJETEZtVnNvcTRJYVZJWmw5SEU3?=
 =?utf-8?B?V2Y4OWIxTnhNQyszWDlrTWhuZ3cvdlU0R0VPUVllUC81OXpwOUo3b3NLV0g1?=
 =?utf-8?B?NDVUZFhTU2kvM2pUblNnRHF1disvQXBsZytiV2hFWkRaSHZaYXhIYmswNFll?=
 =?utf-8?B?Q1kyYWZ4R1JRU1VKUTZ6bTEwNW93NFl1alpMT1VrZEQvMFRkanlXM21FZlkr?=
 =?utf-8?B?czYweEQ1SHF3WU9IeVVaWFI5eDZTK1JnWWcrOWh1R3VLMUthL2hXcWVqNm5L?=
 =?utf-8?B?RVJmLzhISjZWWFZjcWVWOXF0M2RhVVl6cUlYK2dLK2pBcDRNd21GSy85Zi9H?=
 =?utf-8?B?STA3Y1RjWXUrRWVyT3Rtd2pmSmlWbWY4YnpkbXhWNVViVmRzSXpSSTE5OUhw?=
 =?utf-8?B?bTQ5RlEyR3l5ckV6WC9PL0tDMjlFaGdjVDUxNElKYTRidmtTUEFFY0NGcC9F?=
 =?utf-8?B?K3ladXR6bTR0ZnhuWTZFNm40eHZhUXV2cWtQQ1A3TEJVOXNWdjh3Q29Mc010?=
 =?utf-8?B?VUV3bHAxNWZySU5NclJPMXhjOUxiMlovSlVkQWpwOFJ1ZGhWZ3V1bzBqTlE5?=
 =?utf-8?B?Rnp0S3dwZzZaM2dSV0tKa3lyQ0ppbStQQkVwcGFEcDBvbGYzeHdEY3dSUVhD?=
 =?utf-8?B?bmlJSkdMZ2tmM0NtS21nQ3FqQStwRCtieUJnTGZ4RXdlSitHaXd0M2paaFBL?=
 =?utf-8?B?L2RoWUM3MkVRRmhqWlN4QVhVU2ZpYVNYcDlXMmpQZ3hQSXgrMHRtcE9McVRD?=
 =?utf-8?B?SzlmaFJwWTYzeVdIYXQ1NmF0Zk1hQUo2Rjd2aVBWZVI2SnNxTm9VdWloWEp5?=
 =?utf-8?B?dUF6ZGtkbXRheFlZUkIrMG56NURDUFE0WGVaemdjbWJFYU5seVVBYy9wNFBt?=
 =?utf-8?B?ZGJscVFUcEhtS0x1S0ZmVGh5Y1llQlhSdnZOZWl4UGFpc1kxa2IveHFic0Fl?=
 =?utf-8?B?bU5RbmNMamZjelhXSnA1SDM3bmxnNmUrc25tbGJXdjNEdS9BR1FDMFZlbmRj?=
 =?utf-8?B?cmhSVGFCZ0ltRFFrbTZmMUYrQ2hJcTlPM2hxTVBidGRGa2JrQUNBdkkvbi9D?=
 =?utf-8?B?aHBJRC9uaDlXYXhpOGlVMDZ1ODVlL3lHS3hlWVIwM3kwdVpqdElxOVF4Q2Vl?=
 =?utf-8?B?NDRmSWdrdXJibDBJZDFEK09wQTNkUlNjUlBoeWVoYXhWMnI5QkM1S3NnQXFQ?=
 =?utf-8?B?Y3E2R0J4UUswRDVKOVp4V2Q2a0d6YXlSTU4xcXNCTXhiaDNmK1NKbEVXeVF6?=
 =?utf-8?B?TVNHUmR6aWYyM2xwRUUwOXE0WDRxYW83NUErS1RqSzNQSGt0ZkhKL2ZqZVJx?=
 =?utf-8?B?WEpKT0UvbmFXMW8xbVVHeHJPL3MxUHQzN0hSNDJaam5WcnJEWVhkUDVocTkr?=
 =?utf-8?B?czd2enBzOVlOcHU1QUR3ZEZpMHhmNlA2aGV4MmErM3AzU2t1SVVkd0FIeHhL?=
 =?utf-8?B?cWRpZXpoTytNckl4OFJhemlRcnJBVkR1WmhzM2p1VkRxL2Uvd25FWGNVWTVJ?=
 =?utf-8?B?OWZPQ1ozNk9lVEZURU1neFRaZWhac2MxMEpPWTN3THR0UHQxRzhlK0xJbUdM?=
 =?utf-8?B?YWFiRkpuY3Evd1loV1pTc1F3SVB3K2lqemRVcXUvdHRtdHZ4V2VLUjlJbWlk?=
 =?utf-8?B?cXcvbGVsN0RMZTVwTng3N2RHRTNPNWxZSjdBdktaaG1janllRXZnTFpjMFRv?=
 =?utf-8?B?L0FYUHgxZmY1TDdnRU9wdEJTcThZVWlxRGV3VFFINDI1MnZLQ3dtc2Z5ZnYy?=
 =?utf-8?B?NnFmSEhUTHVKSXFlamUyUWtKendKRklROGVvN1A5ZzYyUVpqVVFIRm1xYUdH?=
 =?utf-8?B?Y3RYSEE5ZHBBWGdIazllaHlUc0Y2V2x6L0VYRXlCeWYxTFE1M1ZNQTlPLzBn?=
 =?utf-8?B?RlZCYkdZd1FDMFhoVnNGNVUrY2t6Znh6OXVYTHlYZnRsQ3dxNnhLTWNoT1Jp?=
 =?utf-8?Q?SleO7a4KtH9N/DLkO6lEGOE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77609a35-361d-4f54-41c4-08d99a24d300
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:08:40.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP4+Blb29ooeESnvjzhMMbTKZOZbyPIn58JyGtO8MTAWWIYnQpPUOW7ipuJy9bUMLEPayBxlq5co38KQbWR89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

On 2021-10-28 10:46 a.m., Alex Deucher wrote:
> Ping
> 
> On Wed, Oct 27, 2021 at 6:40 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Need to guard some things with CONFIG_DRM_AMD_DC_DCN.
>>
>> Fixes: 0c865d1d817b77 ("drm/amd/display: fix link training regression for 1 or 2 lane")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index a9e940bd7e83..49a4d8e85bf8 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -840,9 +840,11 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
>>          uint32_t lane;
>>
>>          if (lt_settings->voltage_swing == NULL &&
>> -                       lt_settings->pre_emphasis == NULL &&
>> -                       lt_settings->ffe_preset == NULL &&
>> -                       lt_settings->post_cursor2 == NULL)
>> +           lt_settings->pre_emphasis == NULL &&
>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>> +           lt_settings->ffe_preset == NULL &&
>> +#endif
>> +           lt_settings->post_cursor2 == NULL)
>>
>>                  return;
>>
>> @@ -853,9 +855,10 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
>>                          lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
>>                  if (lt_settings->post_cursor2)
>>                          lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
>> -
>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>                  if (lt_settings->ffe_preset)
>>                          lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
>> +#endif
>>          }
>>   }
>>
>> --
>> 2.31.1
>>

