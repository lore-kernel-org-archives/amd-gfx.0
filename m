Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECBEC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 19:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E428A586;
	Thu, 11 Aug 2022 19:45:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB9F8A3C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 19:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NefkxVoCIhr2/+xzoe973HtQ3b83FvBRLPkJsWS3EgmIFzgD+ar0p1wZp/r9cY4EoTZKT93AmNAzN8Zoyc/pDP8jZyWby2i6I4MrmU+hwyMNLqof1eaC52/W+K5pKdDQSaR3T8+TnR8oujjAyEwN9XxJPn1kwcmcw6jkd2VA6cOIir+gOE2TynP6gAPavbo6WP18YhpKRBVKCNmp3nudaAFSRm+WlkPSQAswXnDk84d76ubc/KHK/B7Vz/qyQwze0USANzqaxihMsKBKWGmEb1RooB0PZiaoPrj1+6caN/8xJ05bvKTD9IBqngG6/BNcJMdM74Ha1APfcauG0DJ/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdstkj3qz+M++wF71SQxkHZzDyMccoB5oZuebSEAm1M=;
 b=QuSRoYPnC1yZLI2qkhgDc+0I1Q02aZ8pIdQpLnbHwnUAGJnv3P1aagEO7VpqZk4t0s9LYwYU+jgenH7G7Nr7wq0vBssEah3Go8dqQ7XelDREizLinAO1dbHmwqN+PGv6vbaXpi+EOe9KMIqu6vzOWBwPwvtzxr36Mp25RO/nuuJfeZlr2V9gsaLLaBU0AxuCai2z0sWq1tGypKQxRPdt3oNf8S5F7j/FOaEWuYZr5GSh81R1bnzJ6StD4Y8uGYFRghH1Wj9KtVrZHVyM2kfT6PZw2iTnX88XPbZIr/vFi3K9RKkiecpIy/xu5rtX954JbY60AolvXH/r+OkVQItQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdstkj3qz+M++wF71SQxkHZzDyMccoB5oZuebSEAm1M=;
 b=rpeHytFwiclrYvykGoQj/Xm2dWtSZymjAOB1a11I6bafgBfti2essayc5+v+SwJbi4hnP53Fh2YbG9PrvAMj9aGbD2PTmWrRcpYuMRytVmaHzTpupmEQEK6xn9ye0IRS7NXxD1sQ9C8rarXterPWRLljkcY0EAETy/E6J873nRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BYAPR12MB3030.namprd12.prod.outlook.com (2603:10b6:a03:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 19:45:20 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::399e:2e9f:fff3:38d]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::399e:2e9f:fff3:38d%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 19:45:20 +0000
Message-ID: <9ea11548-0c86-21d5-517f-0fbe263c3f72@amd.com>
Date: Thu, 11 Aug 2022 15:45:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] Documentation/gpu: Add info table for ASICs
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
 <20220811154819.3566210-2-Rodrigo.Siqueira@amd.com>
 <DM5PR12MB130852E9DF9AFD42861235B185649@DM5PR12MB1308.namprd12.prod.outlook.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <DM5PR12MB130852E9DF9AFD42861235B185649@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:208:236::32) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6764a05-639d-425a-a123-08da7bd205f1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+/9ixiNQOGM+GI32k2UuDDOs3VgxTzkJ72GKp5jEJ2NuichismLDQZrEcGVkWxhkmNnrkN+9BUORb54Nu1CsGjAfUUuDXdoAmBO/RuMaEIWZDtQe8L1axV9FokhAXlMuQvWk52nx9z47+2eYNv8BtDeZQrvDSOV5VBQDK4ho0/IyuSSU+F3nPkcN2kAbfrE8BCbIqfCGAqJY5FeEOuSuGa1HkmeDk35cskQsju9JDf0JfF9Qt9AdHk8I13hbAGUGD7q0xe9HlF51cw0bNvI9qmcgVguBwZtssCC0DgOQpLIdHZQEv1VREOoMf5B0m7hhr5ik3kVn5pl57vDiY+E7mYisPtcxpE6wnrNtuyORWtboZNlWjJHlB4urdLxVpnK3Xck7KMwJdUbBqto57b6S61UGTvX3T3CwSbCICw35aF4XlhiNc8VLvUo2jCnNCrIIZb+wjR47wBfQ7e/+2TK2uUPVfB/xlISrB1bpIHXUKcugZfwZJnGOsbG84nFxzDDOUqJFwRUT5RfCYM45t7JagdvFsq53dwii6l9QvjmCmGmFYcmGEnnIB1jbtIulHaLzZi2qIK0TaxwIv1ZB21bttrbkTF+U8pa3JHMQ/zFZRiynsSyNlONEmUHew5kksEBnZ3zIvuZOEga+QJm5higszCdHwJfFbFS+mGLobCOkDKaFhdNR7ybbo/lXa6wj+S9/+zcxwzmYe/1STTu3qwClHsIYt5ah+fyFb7mQsB8KMR+rVXGQJGGbvM3LoX3PsGEp95iALQW7hivP3WeqDkG0prTIWwm5P2LsbCKSgdPP8Iyc6ZD5t/QlZs50TQFRAHYQSvSqpK21wUDIL8KcQZZjVs2ioquZOOeonKmSkyofPXWwI5chmwKzhMEAr4o5mXn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(2616005)(186003)(26005)(5660300002)(53546011)(41300700001)(6506007)(6512007)(36756003)(31686004)(478600001)(6486002)(8936002)(38100700002)(110136005)(31696002)(83380400001)(86362001)(54906003)(6636002)(2906002)(66476007)(8676002)(66556008)(4326008)(66946007)(316002)(545624005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZqelptcmxUNUdEU1lzcCtVNVQraTlCbjVMRVl2ZnJsTis4U25JS2NSdGlt?=
 =?utf-8?B?c0lPK2xKcGJQTGZFcUNtU2dmWkFwU0hKSGNXNkYzaXdscW41WGVGTHBic3ZC?=
 =?utf-8?B?bW5CWmJVK0p5U0dwaFBvQXdKN1pRb3RRVnBjTHR4QzdtWFNqanpUK1pUWDkz?=
 =?utf-8?B?dmJNT2xhTFhZRUZ5T2tYenl4TWIrM0NkUmphZTN0SnZ4eUtEZjFGQjlWRWps?=
 =?utf-8?B?d0cySDVxeDcvcTFKcUVaL2thdGVMbEFwNUdubEdpTENtc3ZmeFJiTDhtdE81?=
 =?utf-8?B?bnFUSFpNcE9GaE1MNndzV0JwcEZyYTRRTS9pWTFlOVVFWVVHWHR0OUhnRW16?=
 =?utf-8?B?YjNuYjJSZXVmSVhwNDh5eUlmcFptUXFaOG5DZE5kd1k3NDk2L3o2U1VGWjZW?=
 =?utf-8?B?Zkc4MndkTzhJKzA3djFKTDhUVEtXTjJSNEhTTXF0VDFtWjVKZ0ZKbXFYUjV4?=
 =?utf-8?B?ckFQeVpIeDlzTCtYUFR5YW9JenJhamdQRmhsWGtYcEY4THhsVWtEY3liUHIy?=
 =?utf-8?B?dHpiMS8yZHM5UVBUTkV1THVOZ00rcm1TL1RmbEU3dzZXTWdZcXI0eENlZnQ4?=
 =?utf-8?B?K25UUk5YbktkUDNsK21ZS2VsYU5pYnpIQytrVzZmQTJacU9oNlcvQWFtc09H?=
 =?utf-8?B?bERRUE4zZGZNcG5RdS9WUWxVZHYxTzNHdjcrNEJ3c0VNU2lqNGlISmJ1Ky9o?=
 =?utf-8?B?elk3VCs2U090aXd0cmViZ3JoTmRudGF5cWZYYUxMck1MbmtBVXRVeDlwTitP?=
 =?utf-8?B?MHhCZDc3eGYrcXBrcmtoem9vbVk2TGpXWHl5YVQ5S3BHblNWVTZPdkFLRHlp?=
 =?utf-8?B?WWtTUGpLaDRZRE94NmNCNmVwOFduZGdUNThCdHZKK2NtYnk2ZXNJTFhCdG04?=
 =?utf-8?B?bUYrSHNBdjFaOUVQU2JpR3E2bm1Rc3NFNW9WdXN3bks0TUxjOVpGUTlpOThH?=
 =?utf-8?B?bXFHY0pyeEVRQ04zZml1UXNia3FHWnZyT3BtRVZFb1FHZFN4VEJiRkxQdTdj?=
 =?utf-8?B?N2pZcm5PMFRtZm5YV0Z4QUdvSU1YK2pKQW1vRkNPOTdTNVRHVVkzeWdQNmQ4?=
 =?utf-8?B?cTY5NDM2Z1B3L3dhY0NHNEVQTTh1Ni82Y0hGZEJ6UFFqUlZpMTVBZXJTQ05L?=
 =?utf-8?B?eGxMK1VpcjMydUUvS0o3R3BqZ3NjTmtKa3d3SW1hczRTdFBDK3VEVUE1RUh4?=
 =?utf-8?B?RlpYdVJVUmVpNWxDd2tSYWUraVZhSlJ2THBGYy9XTGxDRU1WRVhBRWc1TlRW?=
 =?utf-8?B?bTRITnBFeCtUdEY0TFFWYmJTT0N0Q3E0MmNtaW5pWXBhbDV0TUFsbWVBdlFx?=
 =?utf-8?B?eUxGZFVuZUpWVGhlc2I2MUowc0NGQmtBb1Q5ZTFKY1Yvank5REM2dWdHa05Q?=
 =?utf-8?B?WVUzZysxSE9RSkNTRllKbmd2Vlh4VkZ2WnMvY0duZkUzMFFscG5QZlMxalZZ?=
 =?utf-8?B?TVFjM1FSNGRxUTVOTnI4enFFQjRCUHBOL2ZQWldjbVV0U1lVMlVkVjd3dWND?=
 =?utf-8?B?Vm1ueHhCdVZqOTJpWnJLWGlrVjBHMUh1dkNzNVFrWjRKRmEzRk1nVk1yRENL?=
 =?utf-8?B?K1oxemxSSlRyS3NLdXBZeHJQeXJoMEJ4OGlZVTltdTZGOXBHSFNVN0pzelBm?=
 =?utf-8?B?WldSVERXR1FCYWZ3UWF2OExJdmVhck9VdjRDd0JtM0VRNDRtTTJSVmF3WE05?=
 =?utf-8?B?azlWQ1JnSjROY1JBRFQ3MjVrNmdhVXNaMFVwOVNpQjNodTEzMjV3aUVpRDdU?=
 =?utf-8?B?YTFUQisyZzQyRmNzRzYrMmEyWjBGOUlYb1E2OEFwMmNrNVdJVk9RbExQL2FS?=
 =?utf-8?B?K0RJRzRrZk14VVY2WUlPbUlwL2xnYTJpVlN3SnFwdjJydUw1QnMwWU5FbHR1?=
 =?utf-8?B?T3pPQ2xWYU9QdDZGcXdBSTRrUEZpVFN4YjlaUjl0elpMUnU1Y3FYb2ZpU1Rp?=
 =?utf-8?B?cGNjZ3doWlF6dEUvVnJYSzU0NUpPN0UyMlZmM2VnUWI4bnVNN0QrRFBjUVVu?=
 =?utf-8?B?UjcwQXFaWW40RkpramptTWg1MWVKdWRpT0dBKzlOS0l3cjV4NnlROXd2dVFy?=
 =?utf-8?B?ZDhIdlV5NDR1YWpRdDNNemY0d1prZkw1SHFFY3hUL1BKKy9WWk5McENObTRl?=
 =?utf-8?Q?kZXf+urKXU3RHkyLbAktXXKB2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6764a05-639d-425a-a123-08da7bd205f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 19:45:20.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMoi+kzlwtv4oRU3LKFpciNm2Pjs1lmrOMdgn07/UYA7NFstTKSV6RWtgVNuxeX63WwhEGSu1kLUVRGbvXx6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3030
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
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>,
 Simon Ser <contact@emersion.fr>, Sean Paul <seanpaul@chromium.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Kent,

First of all, thanks for your feedback.
See my comments inline.

On 2022-08-11 12:02, Russell, Kent wrote:
> [AMD Official Use Only - General]
> 
> I noticed that you added DCE and VCE/UVD prefixes in the columns, but not GC or SDMA.
> E.g.
>     CHIP                  DCE      GC             VCE                           SDMA
>   BONAIRE	 DCE 8	7	 VCE 2 / UVD 4.2	1
> 

Are you referencing when I added it in some specific lines? If so, I 
added it because we may have a different architecture for the same area. 
For example, DCE is our old display architecture, and we replaced it 
with DCN. That's why I added DCE/DCN in the label, and in the ASIC 
description, I specify if it is a DCE or DCN.

> For consistency, should we drop the DCE/VCE/UVD prefixes and add a separate UVD column, so it's just:

Iirc UVD is the previous version of VCE; in that case, I think they 
should be grouped. Or is UVD a different component?

>     CHIP                  DCE      GC           VCE    UVD	SDMA
>   BONAIRE	 8	7	VCE 2	4.2	1
> ? I know that from a compute perspective, I'd like to have the columns represent the fields, so there's less to parse through, but I am not a display guy so the DCE/VCE/UVD relationship is a mystery to me.
> 
> Also, for VG10 you have SDMA 4.0.0, but Polaris it's SDMA 3 . Again, just consistency with trailing decimals. I don't know if that's just because we didn't do point releases on SDMA <4 or whatnot, but it's something I observed.

I also don't know if we have a good reason for not using the decimal 
part, but I can add it to all components if it makes sense. Maybe Alex know?

Thanks
Siqueira

> 
> I am not staunchly steadfast one way or another, I just wanted to hear rationale for it. Especially if we're maintaining it going forward, and for when someone inevitably starts parsing it via automated script and needs consistency. If you're confident in the format and can justify it, then that's sufficient for me.
> 
>   Kent
> 
>> -----Original Message-----
>> From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
>> Sent: Thursday, August 11, 2022 11:48 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas
>> <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet
>> <Bhawanpreet.Lakha@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>;
>> Hung, Alex <Alex.Hung@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-
>> eric.Pelloux-prayer@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
>> Simon Ser <contact@emersion.fr>; Pekka Paalanen
>> <pekka.paalanen@collabora.com>; Sean Paul <seanpaul@chromium.org>; Mark
>> Yacoub <markyacoub@chromium.org>; Pierre-Loup
>> <pgriffais@valvesoftware.com>; Michel Dänzer
>> <michel.daenzer@mailbox.org>; Russell, Kent <Kent.Russell@amd.com>
>> Subject: [PATCH v2 1/3] Documentation/gpu: Add info table for ASICs
>>
>> Amdgpu driver is used in an extensive range of devices, and each ASIC
>> has some specific configuration. As a result of this variety, sometimes
>> it is hard to identify the correct block that might cause the issue.
>> This commit expands the amdgpu kernel-doc to alleviate this issue by
>> introducing one ASIC table that describes dGPU and another one that
>> shares the APU info.
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> Cc: Hersen Wu <hersenxs.wu@amd.com>
>> Cc: Alex Hung <alex.hung@amd.com>
>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Cc: Leo Li <sunpeng.li@amd.com>
>> Cc: Simon Ser <contact@emersion.fr>
>> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Mark Yacoub <markyacoub@chromium.org>
>> Cc: Pierre-Loup <pgriffais@valvesoftware.com>
>> Cc: Michel Dänzer <michel.daenzer@mailbox.org>
>> Cc: Kent Russell <Kent.Russell@amd.com>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   .../gpu/amdgpu/apu-asic-info-table.csv        |  8 +++++++
>>   .../gpu/amdgpu/dgpu-asic-info-table.csv       | 24 +++++++++++++++++++
>>   Documentation/gpu/amdgpu/driver-misc.rst      | 17 +++++++++++++
>>   3 files changed, 49 insertions(+)
>>   create mode 100644 Documentation/gpu/amdgpu/apu-asic-info-table.csv
>>   create mode 100644 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
>>
>> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
>> b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
>> new file mode 100644
>> index 000000000000..98c6988e424e
>> --- /dev/null
>> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
>> @@ -0,0 +1,8 @@
>> +Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN
>> version, SDMA version
>> +Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3
>> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
>> RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
>> +Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2
>> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
>> RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
>> +SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1
>> +Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1
>> +Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3
>> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
>> b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
>> new file mode 100644
>> index 000000000000..84617aa35dab
>> --- /dev/null
>> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
>> @@ -0,0 +1,24 @@
>> +Product Name, Code Reference, DCN/DCE version, GC version, VCN version,
>> SDMA version
>> +AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series,
>> HAINAN, --,  6, --, --
>> +AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --
>> +AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND,
>> DCE 6, 6, VCE 1 / UVD 3, --
>> +AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN,
>> DCE 6, 6, VCE 1 / UVD 3, --
>> +AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M)
>> /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
>> +AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE
>> 2 / UVD 4.2, 1
>> +AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE
>> 2 / UVD 4.2, 1
>> +AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2
>> +AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA,
>> DCE 10, 8, VCE 3 / UVD 5, 3
>> +AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3
>> +Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100
>> /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 /
>> UVD 6.3, 3
>> +Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11,
>> DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
>> +Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series,
>> POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
>> +Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG
>> MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
>> +AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD
>> 7.2.0, 4.2.0
>> +MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
>> +MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
>> +AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN
>> 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
>> +AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14,
>> DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
>> +AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0,
>> 10.3.0, VCN 3.0.0, 5.2.0
>> +AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0,
>> 10.3.2, VCN 3.0.0, 5.2.2
>> +AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH,
>> DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
>> +AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN
>> 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
>> diff --git a/Documentation/gpu/amdgpu/driver-misc.rst
>> b/Documentation/gpu/amdgpu/driver-misc.rst
>> index e3d6b2fa2493..1800543d45f7 100644
>> --- a/Documentation/gpu/amdgpu/driver-misc.rst
>> +++ b/Documentation/gpu/amdgpu/driver-misc.rst
>> @@ -32,6 +32,23 @@ unique_id
>>   .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>      :doc: unique_id
>>
>> +Accelerated Processing Units (APU) Info
>> +---------------------------------------
>> +
>> +.. csv-table::
>> +   :header-rows: 1
>> +   :widths: 3, 2, 2, 1, 1, 1
>> +   :file: ./apu-asic-info-table.csv
>> +
>> +Discrete GPU Info
>> +-----------------
>> +
>> +.. csv-table::
>> +   :header-rows: 1
>> +   :widths: 3, 2, 2, 1, 1, 1
>> +   :file: ./dgpu-asic-info-table.csv
>> +
>> +
>>   GPU Memory Usage Information
>>   ============================
>>
>> --
>> 2.35.1

