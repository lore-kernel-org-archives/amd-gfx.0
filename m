Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A0EC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDBE10E255;
	Tue, 14 Feb 2023 19:02:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A57C10E23C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O40sODwyx0kA6myG/XGPG+PDMrjQl8o78BeU4AsihjexIVcjSTEVP+QkUmuOjNKQxcAIFPCiRM23YGwbPZgB4On4ZqRGxWxfh/5UwDybcKn6G6ZOR7CdvM63bbaHmialCux5WYb5rGLXtLXsYpANcRABM6JrmFZeLBU0giFUAH9aiskt4Mhsu9mfOE8PcmtplL7zr47IfJfPYnhoopjnep9V8xAcIBqjegAQPhG6elKoA7AIhKZbVaCBddUWE7UTQBfZjlFhkzkteV3lk0zyHZ+wYYBxCaO0EjrTnA92vfLGEEKXztZrSWtz76lsdeqwo4mkaeuxjib9s3A9I6+PiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vn+yfNTBe4Q5DX90AfdSszHFuG6QbDdZevq77bqyQlk=;
 b=I8sgWKw+7LU/ldQ0P5ck6x6ANj+sHyaQzOAmGEsuKz5aWPY3ptydnJM1zzsc90BrjY8iBEVaoNcYx633q/fEiAm71/UReZPKp3XS4rBym6kVGfsqSGXeRBVZutU6tTVowhqR52wzOq7FTYNa93BoFZfeOYP4vX8hJVXY0DxTwD9lFzJeLmZyYpxLh+5llesFSc1J0YtbAt90AdnAenAfmr4O9DxX9IUJmmBBpmplFt96y0aPMcv1cjzB+O9HBnEAIKeCCBMmUn9MkXtHw3XZbx1D4ZY51a4ODX/dD8IQEP2aqR2E6qmn1qqGPE8C21SSVOMqos2qRXOj4QAKsSfi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn+yfNTBe4Q5DX90AfdSszHFuG6QbDdZevq77bqyQlk=;
 b=pM58bQY4Tb2Hdc5RzgClIrfWbKvUQhwHA/IBDlOvMnip4IVK/+NO7420OW+qZK3B4HZbuYky4ool0NoH6OJvwyiqbv4Lu58X+rVIAAt2rVaROVlFeD33sVg7oht9CGtRVHzWt8c5y3OyA8gU6tDPJmaaE4PNjkc8rQQ+WNA8AHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 19:02:28 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:02:28 +0000
Message-ID: <23b65bf6-0eaf-b7cd-8d92-fd67d7323248@amd.com>
Date: Tue, 14 Feb 2023 20:02:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/8] drm/amdgpu: add UAPI for allocating doorbell memory
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-2-shashank.sharma@amd.com>
 <ea06006b-c537-2fe8-d5dc-1ed07162ccad@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <ea06006b-c537-2fe8-d5dc-1ed07162ccad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a06dd2a-a1c1-4a44-ff99-08db0ebe0431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2QQg3BOTsGOCuG8fDyJunHrijnU7McNfD7j9YlrTlT85p807RbDLt1byDmgg3+eDuWCArIOWS4KL4ajBwDXnLiajxiF7NlSXqUBujRBbpi/UtxaK1O9Sqx+kkpi8aOM8KJlBhBCkFO5VY91Ixd20A4mEfqHtM359R8hRUFzQ87ssQ0FcveC5K3hINliBBTrF1jbSnjXCl/aKecUDhzkPKOtf6XZNjAigViYFgb7LvegyiawVs5XGSaYykugrWBH1HK0O9f03VQUHSoj8tSGGZ+W4KACm8us6cuZOTeJHeJOYz15k+Ar294eoVsaOE4zKTeJ3YA3g6crjq/yGIeteLVVY5gPY6XQEMDKLRcWZJ8Jllr6UCW5HsAsUnqHa3OfZgs2swuAmpw3YePX9UyRQX1vxS6GAjxME0fHfhQn46Qptnzr1GyGeTCy+JnHoQ19dJTTYQRED8YtEWyEElB03aYhnJeVqT4aliFmqnRGnq066Bz7TIgpiQ8f8J78IqvYGKe2ChMK9Mj+mR5xX3T3llRbnFP+p9TBSmtBU0CQjaf3JhyBLbTLdY82zeRUOw64kFw8ro8FCcE3qHvs4VolytAs9/M/PIHkVUohnGISy4soUHtLzm5+ZMucnHWdz+96Gvs9NirN2+I6rsNbeik0rLtlePieVSoXu+6GIM6ggzSTdNydbz+uGTEEIiqR1+FEsPXEw7vDsfPXeEI+GQrMUwkFEI6yuQryB8VHIo+cHFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(31686004)(66574015)(83380400001)(26005)(31696002)(2906002)(44832011)(36756003)(186003)(86362001)(6512007)(6506007)(5660300002)(478600001)(53546011)(6666004)(8936002)(6486002)(41300700001)(2616005)(66476007)(66556008)(38100700002)(316002)(8676002)(4326008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEU3UWIwaDhvZ0FDcnhaT0RGeGVWVkJMVjlrb2F0VEhkNFZvZzZMZmZVR01O?=
 =?utf-8?B?S1FsbHRXUE0xTklFRHhlWkZqT1RLdmpRZWsrYnNJN3ludnR5dFBXcHZmZ0l5?=
 =?utf-8?B?SDB6VlJ0T0EvYW15U0tpYVZ5MDBmUDRxaGJSVzJ5SU5uVW9VN01IVWRRbkJE?=
 =?utf-8?B?ZkRmcmQyMTV1NUY1cHVSVFhuWG94b0lUTit4MHhCYjN6dGNFQkFwdXdXWGxX?=
 =?utf-8?B?N0ZHbVFqeE1ZRDBNNnl1SlVOZXRYWDRTVVlhVjh6MXJQTGpRNHhjaEJ2SURo?=
 =?utf-8?B?clB0SS9YRmQ2aXZNeG94VFBRTHVQdlI0SUs1Tjg3RjREMTN1cDNGZUZXVHMx?=
 =?utf-8?B?UnIvT0VyYk9vd3VpbnlnaDVSR05UYnRXMFN6aWZ1TzFRSnlBUXp3MXhaSktq?=
 =?utf-8?B?U2JPdUI3b3RvS00wcUdOVCsxTE03TXVZS1h6b0VtaU1sem53QUkvc0NKd1VF?=
 =?utf-8?B?LzhwbmlvYlRsNExFZm43M0xsQ2RRNnl4VGRSWkZ2VHQwTVFIbEZ1ZnF5ZWFy?=
 =?utf-8?B?d3hsWXp4Y3RSOXZGQXRsMlNJSjk2eEtuOVJTZ0lIWXM2R1lPOVVLdEVCUXdn?=
 =?utf-8?B?WHNGTmZlNkExSkxLVnVLVThBQkZFQVdGR3lPaDZFS1F0M1Q0bDdoOHVWWnZr?=
 =?utf-8?B?VGVYWEVDRnp0YTBGcGFvUWFjMGtpV3hqSmdiNVpBMURrRmtyTXdhMGlPK2tn?=
 =?utf-8?B?RmdJa1lTNnFKNzZhRGNHdkl3YjdKdHBPa1BRaEZ1THYxUGZ4K0FnaXBtQ2NW?=
 =?utf-8?B?bmw4VUZkT2hXNFU4K2tmeVkrUnlicjUwOEFoSFhmR2NIME5kdFJYbUM0aXQv?=
 =?utf-8?B?Q2prU2ZKWXlDSEdQc0R4VEM4dUQrVi9ZelVSSmhjeHBPcHhBMnVqS3NWQktr?=
 =?utf-8?B?blpFSzJ5aG05ZFlDVHhhR0QyOXcrMWMvakJuaVpUZ3BhT3ZIeUVZcEFMOVVm?=
 =?utf-8?B?WFZ0OHZWSk9jZUV3UmVHZWhmcU45eHQraVFiS0duSlRPZC82YnJnaGZURW4w?=
 =?utf-8?B?NDNFcWNxSGZXVnNSaVNPVDdXcXd4QnFid0JrRkNkUGdmS25CODVwV2hza0Nr?=
 =?utf-8?B?Wm9RNFB3QXVtbXBML3NYZ2ppVGNMejNndFduaVpWRWxpb3pISG5ZK2RCeUlq?=
 =?utf-8?B?SG9McklBeFZ3MEVRK09wREpScm9zZnlSOHRoazhxNlBObWl1VklpWjYxMG5m?=
 =?utf-8?B?SnlScTg4Y3dxZWF5TndheHNvTnQ5NlRIUlpHd2xRSEUwR3VxbndXYlVqWEpG?=
 =?utf-8?B?OVFvRWM2bXR6U0R6NndyVWZSSlh0WDJUazlMbS9NazlHR0FJUWs2YzJzQkV3?=
 =?utf-8?B?ZDJsQWdLbmpyR3YrTmZreUw4VHkvUHpyYzJuTlN3WjhWVUZMV1I4SzRIV3M0?=
 =?utf-8?B?NzFSaU1ZLy9ZWlFKWC9ZVHB0TVB2N25MRlNIcHZhZWw2dXNkS2loLzJUb2M2?=
 =?utf-8?B?VVdHTlFWVEcxdjZBNXZ3VTBOVHlUZXU2dUJmeDh3V0hteVQxMXprQThhYjdE?=
 =?utf-8?B?NG4yK0pBS3FDKytKSmpQdjZmNUdZZHByVXl0Z2JBaEZLQ1F6VDRrV2UwRFVR?=
 =?utf-8?B?N1hVQWxJa1Brd1VJckFWUVFFMUtrajRnQnNsdlZOL1FUdHFaeWE2Sll3NGlx?=
 =?utf-8?B?VW1QVG8xc21LQnh3dkVNeGU5aEFYb29GKzJhQnpZMjZYMURzRFh0QytzL2ww?=
 =?utf-8?B?NWxXcktxbXRvR2N3c3ZYWWs0Y01KdmxlVWNXbUpDYWtYUlduV0E5WHNoUjBY?=
 =?utf-8?B?dVpVbzVsN2g2YUpMa1NNNmcvSGM4WHl0Um1FR3JkWE1yNWxoTlczUjJCaDZo?=
 =?utf-8?B?eU1lUnF0ZlFDUk5SRktjakFObWtUTDRYUW5mdWxxMExucW5INUlMNW5SWHZB?=
 =?utf-8?B?QlBUb1puc3B0WTVvTTdrVmJNb0M2VFl6V20xaWxSQ0JkcTRJSEpkTlJ5Q1Jk?=
 =?utf-8?B?U3hLOHVoaGlza1VhZllQSjA1akhnVHhMY3F5TDUrQXJEVDVBU21aUTRBcEZL?=
 =?utf-8?B?WDlQUVNiMFdQeUpEZURWYmlxT3VGQjg1MUFWMTN3RUFwdEhTamNyZVlJUkt5?=
 =?utf-8?B?bVEreEQzSXQwdk9zQWtFa0R1UkpQT2x2dkpvVUdmU2ptbkl2aVpNa2Zoc0F6?=
 =?utf-8?Q?NxHeP0fnzHgKYkBGPAJ7rfpXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a06dd2a-a1c1-4a44-ff99-08db0ebe0431
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:02:28.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDvSepmUzBhI9oOOwFNNDdNDRM8H2Xo7tJCNqQYSxl+ji8HYJ/82FigaDtjxf9nrLi+8/47wWTSBwqE0MI4Tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 19:22, Christian König wrote:
> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
>> in the UAPI layer.
>>
>> V2: Drop 'memory' from description (Christian)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index 4038abe8505a..cc5d551abda5 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -94,6 +94,9 @@ extern "C" {
>>    *
>>    * %AMDGPU_GEM_DOMAIN_OA    Ordered append, used by 3D or Compute 
>> engines
>>    * for appending data.
>> + *
>> + * %AMDGPU_GEM_DOMAIN_DOORBELL    Doorbell. It is an MMIO region for
>> + * signalling user mode queues.
>
> Maybe write "for signaling events to the firmware, used especially for 
> user mode queues.".
>
> With or without that Reviewed-by: Christian König 
> <christian.koenig@amd.com>
>
Will add that, thanks.

- Shashank


> Christian.
>
>>    */
>>   #define AMDGPU_GEM_DOMAIN_CPU        0x1
>>   #define AMDGPU_GEM_DOMAIN_GTT        0x2
>> @@ -101,12 +104,14 @@ extern "C" {
>>   #define AMDGPU_GEM_DOMAIN_GDS        0x8
>>   #define AMDGPU_GEM_DOMAIN_GWS        0x10
>>   #define AMDGPU_GEM_DOMAIN_OA        0x20
>> +#define AMDGPU_GEM_DOMAIN_DOORBELL    0x40
>>   #define AMDGPU_GEM_DOMAIN_MASK        (AMDGPU_GEM_DOMAIN_CPU | \
>>                        AMDGPU_GEM_DOMAIN_GTT | \
>>                        AMDGPU_GEM_DOMAIN_VRAM | \
>>                        AMDGPU_GEM_DOMAIN_GDS | \
>>                        AMDGPU_GEM_DOMAIN_GWS | \
>> -                     AMDGPU_GEM_DOMAIN_OA)
>> +                     AMDGPU_GEM_DOMAIN_OA | \
>> +                     AMDGPU_GEM_DOMAIN_DOORBELL)
>>     /* Flag that CPU access will be required for the case of VRAM 
>> domain */
>>   #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED    (1 << 0)
>
