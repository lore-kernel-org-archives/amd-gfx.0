Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8D6C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18E410E21B;
	Thu, 30 Mar 2023 11:07:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7896010EDBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dizc7tSqyY28HJ6gCO87bZTusVNlJ3or8bEuApWyysHcs1wAEYVQ4hykHkF6pG/0DdSlzjQkv5QYgkqX71B951oZonAPMrfbIIVhncw+Wb2Leu66HxMdvFTARnp2A6EvirPENGi29iapj73HdRnCzvxSa6BZ/P9L+ZW/5OE62M34Nv6UsWLtZtUmAAgsstaqfPpo7/AH33+ftpT9jCzvT7fdska0kKBza3efkcgbJBLwxPFD9rKbgTkFhhl6uQDK9tbOZNODDoyYUsmwM4G07XrFB1h5riS9uJuup0Pv5G8p1r9qQ6Nvq73jiXejhyzDFfhMjs811RRzbwnQFrPYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoeGM1pk/08GpexcYrWbgEeoOTIZhcxnZBMskHjz1Iw=;
 b=l31KpQ2T55VxUwqGICS5S2E3bRSunF40/NCbngdsakRKrr+0Ml/rhI2KpZMjnt4XrguAnCPd21D8K0sSl/9h+pXRqA7ifarg56xQeuOGynM685A7OwgLZDTuLS4lDrSeY7fTWDEWzK+g3Kx3qVUVns8libAPM2m2mEpZK/Cn+vMk3nnGtf+4a+ncB+SR5clCnI4H1KJhIaKucd7qKiXqWB2GF23qLbdXHXpKGR8BhYQ3ENrvbOOPXdE89/9xGQPPNUtIWusrq6vz1ZPIYkSZcgPhcqQ8fgchkjqzGfmu/Tf0ir093bncyXOJtW0NwOAuD4mOP3iCn2DqJxp722QpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoeGM1pk/08GpexcYrWbgEeoOTIZhcxnZBMskHjz1Iw=;
 b=Hv/1Yf8IAZ+6UfnaT4KWBFWqPZcJMaDHfug74M+WLfhI8ZzzUwGo5rLZMVdgghhuWHJirOeMuN72BCyvdO6h133eiw8YBATry3a0/wEpD3Sf1lS1FMlWPJuPNc/ETB/m7d3rXxTNnU016Dln/I1YhJMclEc9OdTlxhGSSEjnd6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 11:07:11 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:07:11 +0000
Message-ID: <4a813e2e-d9b0-089b-89fb-ef5ff6993fc3@amd.com>
Date: Thu, 30 Mar 2023 13:07:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] drm/amdgpu: include protection for doobell.h
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-3-shashank.sharma@amd.com>
 <fb8ca9ac-c9a9-21ed-50d9-3ca0ebea6e5f@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <fb8ca9ac-c9a9-21ed-50d9-3ca0ebea6e5f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c115f55-1372-41b3-221f-08db310ee890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5B8kUusdm/3xujr0O2uiHC10pJjF2lj+EhU+BcjuwnMwXyf7jOqWrFiRuEzvKN++nHVsvJBjfXp1Oz0xS02qoZOMK9+T6sdWTpFU96PTNrBteDyz4PCgoPLysQzjfz6b4YzOKUW4LSUJssOP5o7TKXBNFKszn4f3//aUhbH0NyVpYDW+rK6JqLK1eIMbIYS4TDMseGu83wm6bNkqhmqgs2Yc5+Pmp+Zwy/M3r63T9iI+9+MdHSXFAmpQ9b6bhiZbMq2XvNPpEI9/zsC1uz6zDft2qgxMnNyMO2766PpcH8YlrDG7zQ/bjAYJC1bMdqBo/Pi8/wnpOQC2OxcNJF3xQ0drRovs9s/QaBe8Awjli/qn6z2oWp7Fsng4DSPhFEUqhdnJocfHIsKcLzlhbuIFwWvmgqP1HBYUElFxorrMtGG1ujs0XXC7haYthov2QLvyyaoyWoUcR5f272gueasZbx+FTrpl9DmzdI9ewFqs/RO1NPSJ3A2WpJXPS7KhUT034l9mu6Ptm/kigmpPf4Ei4wbtvtgOd6hiFPu7w2//48Sbjf96TXrmfCEsuOkwpWeC+iTh7tYLFb2QCyvfVV1mq/2jbOvoM6IRC9LxybnD9WhYVnIO2P/7AeyynLQNIKh3CgImneuD/3QlZ2DdEGKGQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(41300700001)(36756003)(186003)(6486002)(31686004)(6506007)(6512007)(2616005)(6666004)(31696002)(478600001)(86362001)(316002)(54906003)(53546011)(4326008)(66946007)(8676002)(66476007)(66556008)(26005)(8936002)(44832011)(38100700002)(2906002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGVXK2wvbDZHUENEdjJRczFXd0JJYzJ1NGpKaTZLR2lUc0pYYUZWMFR4TGxi?=
 =?utf-8?B?WlMyMXNTRWIrTWY5RWtjeXQ3T05lZ00xdTM5OEN4UmNRU1JDWUJ3QWZvZW5T?=
 =?utf-8?B?aHVuSzNydmQ3MmlQMFg5QlpqQ0dzWUZWQ1B4VEVkSlpQUVdaSnNCcy81c1V1?=
 =?utf-8?B?Q0VjbzVwZ1NoMk5yUStHNjlTUHBYS2dHNGVwS3d2TmYzd3dJVXlHaDRTUGdJ?=
 =?utf-8?B?NjlkcGtoNVVTdytKb29yczc1bWNyUXJpcmZDempRYXpBZWJRTVJTbXJoRll1?=
 =?utf-8?B?VHlCWnlTTitEQ3lsYVp2d0VGQWhMUHNGcjB5VXNJenhjWllyTDFmRk9uMzI1?=
 =?utf-8?B?L2tvVkROWGNYVUdnRjFvNVB1Sm1SWjI0TnArODBTazJWdGYrcHBFdmN6anZv?=
 =?utf-8?B?cFljOW91Um96QVg2UEFHTUkvNGRpa1BGZHJSd1Z3VUE1T29GOFFHbm5PaHhI?=
 =?utf-8?B?S0x4dTJrR29NcnJQMVpFQkxCaysxMXhST3R1QTJvTUk5WThsa2tPOCtENGhR?=
 =?utf-8?B?NzJPeHJOU2JwM01kSlhUdmJWbmg0bk9vZlpwL2Y2b0p2NUsySG5tRlc4SVJs?=
 =?utf-8?B?czFMb25WMHRZdEd0TlBXcXNQUG9rVWc3ZVhKNUpFVkpDZXVJeVZMem53Vks5?=
 =?utf-8?B?ZkNXZjRLUEtxMjlJdUcyOGFycmx5UTc2THVYZDhxU3RrK2dQdCtzN1JRc0xF?=
 =?utf-8?B?anN3Q2ZKblVQQVErZFJWWmhIa2RCdFdXVzEvcENvQjdQSUJRY1QveHhpVmZD?=
 =?utf-8?B?bkxKcnhrLzJiYXVudisxRVYyWm1Zckw5djY1UllkK3FPT1hpRTZkaGhuSEdE?=
 =?utf-8?B?SjcrVTRVZ2U3SHlvUnM4YlEySFBnQzdBaFJsT1RKa3R2MkJhc21abUs1c1Nn?=
 =?utf-8?B?YUNDWEdyUW1jbXZGcDFzWmdkc05oRjN6azcvU0Izbkt6MHBXRVZYUjdrQ24r?=
 =?utf-8?B?a1BJY0o0U05sMTdLNkc5ZTNwQnN2WTZVQ2lVM2k3anlEcXFWWFhweXlIUXlS?=
 =?utf-8?B?ZDdINmo4K1d1Vmh5TXRvNTJNRTNHeFMwV0V6M1grbkV0NlRoWElDNTNtYnhk?=
 =?utf-8?B?RnoyT2wyWUpHNExtM3o1OHF1VDFMcGRoOUVveExmVzZVbHZiYWZnc0xWUElW?=
 =?utf-8?B?Y1h0SjVIUDJvaGpqUnJqVmpheHRYNTBYQkJJK0s0VmFIOHJyY2tTM2d5Snhn?=
 =?utf-8?B?dWxZbTRMOXNFbHB1OTlLWFFhNkVvaXZOeEluaVRPOHhxZm9iTjcvekhxcjNR?=
 =?utf-8?B?QXdaZEx0YkpGUXJlUDhtOWQrYmZZbStpTllXTUhpYjBHWGlSWDY0Snp3Vk82?=
 =?utf-8?B?RTJOK3p5d3RrY3pWNUpxZWFCNmRYdUwxQUNHenF5YlY1YVo1aC9uSlJMR01G?=
 =?utf-8?B?bjg4T01URzBFS24rd1U1WVRQZ0d2UzhhTnFPVGJ5ZjN0QzZZN2ZCQnl4WklS?=
 =?utf-8?B?Ym9OSC9Kd0V1T0E1dmZ6bmtuSzE5QlM2ZU1OTEZTSWlSSysrc21idFRZcklm?=
 =?utf-8?B?bDRKQnZaR2IwcWZmelZ6ZUZGeGdUQWprV2lVZVBPNlNQYlhkcDU0Z3VsSC80?=
 =?utf-8?B?ZUdObUtuR1gwQ1RuU1E0cTBpeVREVkk4OStkaWhIakx6dXg3VEtCTDd1RGQ3?=
 =?utf-8?B?OEtqSE9ZWGpKaFlsdmtteHlpSXQ4UW1nQXVsYzhGeVByS0J6K1NqMXhpT1hv?=
 =?utf-8?B?dzNDNW10cnlCUHAvbFlhNlRKU1pURU1LZE0wS2ptOGpMeVJRc0xqMnJkd1U0?=
 =?utf-8?B?aFhSblliYkgyWmk5MDlpb0x2Uk95cTNOcHJjNUNSbC9kOTN6c3FuU21YUG1n?=
 =?utf-8?B?K0d4em9mRXdDUWIzZHp0b2JCTVMyaEtuZVIzMDU5am1hWG02RWRmQTIzTHBF?=
 =?utf-8?B?LytjSTMzU2NrMk1JQlpweDJoK3lUY0s5akFsNTZhTnlqcEN6ZElMTlgzYW9F?=
 =?utf-8?B?d2dWRFhGYXQxZERqZUNoZmZRSUJFZTRRei96Slc3d09xUVNzaVNxNFo0T0pk?=
 =?utf-8?B?UW5GSjN5TkdJNEpHdmdPV01FQkJEY3FlVlFIb3QwOVloYXZEUHJwcnRBZ0pu?=
 =?utf-8?B?WEtzK1htQm9YSEtYQ2J0UGllazNLU0hMemE5MGxSOW03NVY2TE1JcmpuS1o3?=
 =?utf-8?Q?224xNqtOKaWzkGLpeAubsJLCT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c115f55-1372-41b3-221f-08db310ee890
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:07:10.8723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/9jlJdRi8US2AaNsEhwCLi7d30S9wswA09lCv30NC69uOeZ79eiv7xlXn7AvOkeOJZc9DQ2CTYFogD+r6UDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian,

On 30/03/2023 13:05, Christian König wrote:
> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds double include protection for doorbell.h
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> I suggest to get this pushed to amd-staging-drm-next ASAP together 
> with patch #1.
>
> Christian.

Noted,

- Shashank

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 12263986f889..6064943a1b53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -21,6 +21,9 @@
>>    *
>>    */
>>   +#ifndef AMDGPU_DOORBELL_H
>> +#define AMDGPU_DOORBELL_H
>> +
>>   /*
>>    * GPU doorbell structures, functions & helpers
>>    */
>> @@ -308,3 +311,4 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v);
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>   #define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), 
>> (v))
>>   +#endif
>> \ No newline at end of file
>
