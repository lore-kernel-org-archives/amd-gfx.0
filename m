Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF69FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 14:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A1010E178;
	Mon, 16 May 2022 14:12:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DC110E178
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 14:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbOd0Cpdq9PTowhYfJseuIm9r+iI/hJ2s5hm+1NGo3Ssd7RRKaROfPUTdJIukgbcChaZyTmF+b7TT6kewasvhnZlGJ3/GPf0HnmG2/3rBDdYPRa9CyCkOYrU1gErF4wrriMGwgU0vKqnc8pyhji5kFM/ichUNqFUx2G8cLjYYchDdHOauBMAJWuq/53+PqeO36ezlLexvZbUYdOg7411oJvnn6i0orRmnMBhE4jDOHaHepSEbtL7bM+NYAYx4kwBjdrnX7T7BU0sQF3uw3PCWelMsqZHU5abo3YQttmz0UTzCxHnSkN7N0mGoqyc+u9YJpmrjbBVPUXf8GblFBTVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke8Gwg/ll7H23WmjWESMLJzXqralEh6vBHNe0eqdKPU=;
 b=jIrOaA8dGb+RPq3FapjhJVAAm/zpJpm2Brf7bOkd01wp+AeltAB7g3uAcUaOADzAKkXQd2M0yYeC6bn8EczvJGH6soumJGQpE9D3BcLVNOfoa1nhPSWrq04fRcP9avi+8ZYdvd47BH+Op3bKBbGUQ8/q5zuH48VifvBEE/auHBjOgHj+pLINr4FnebMwhefQN5KkXDqFm+xiK/jf9PHrVosTf4x2w1Xi+5tNzVktIo4Vz4doOZ98oLh8qN3j/jYE44Qj1XnEEQj2bEehOB7q/qtzfRJlRm+JHmMqBevk5VQ/7fABgA/kfSnZDEKBVaipEvH3VOcysc98YckZFuKwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke8Gwg/ll7H23WmjWESMLJzXqralEh6vBHNe0eqdKPU=;
 b=XhFpTD4UFVfDpDMNe+OEqfy89cdr7zAtn059NCfY+B6vJq2zjQLEELUteLPiry6g7Lqr2Vhwr7/FzCsjLhVkP0rKCKRS4d8rfyIr2J1KM/+lzFTxtg9F/BnMocjqLtSFrBJbCnn8h+NKDlypMhJAcd3fR0djLRyWnRzPomh1ycc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 14:12:17 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%10]) with mapi id 15.20.5250.018; Mon, 16 May
 2022 14:12:17 +0000
Content-Type: multipart/alternative;
 boundary="------------8EdBbDqkdX0G8jAvBYHoQS1X"
Message-ID: <cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com>
Date: Mon, 16 May 2022 10:12:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <b9fd9cf5-1ae1-a599-576d-74f13b0351d5@amd.com>
 <4e88f5a0-11b7-ac14-ce77-7e69c2ce75c1@amd.com>
 <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
 <14483921-e454-1ad7-ff45-665366158504@amd.com>
 <0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com>
In-Reply-To: <0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com>
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff5b0f8-ad25-4692-775f-08da37461562
X-MS-TrafficTypeDiagnostic: CH2PR12MB4326:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4326928271CD6F1AC470C312EACF9@CH2PR12MB4326.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8+kBiRh5P8HxhgF0ixyAO7l1y/kFWpn2qvtxDl45kCw+I1jWs+XJG2zqu5gAPqwMMMQ8t1dH6CEdHeDc0vtRwS6Y+VdTRgPtlX9GQZ8FzWocuGkLHLLW7QMqLmFb5XK1gIoiuI9cMXVLiHpXi4pmKVZ4Tp/PBEAkryI7WN5iFTOV7zz21rAzjT4M6+QSYZFWqczQ959l/6IIRTZrnMbxwGl2UGFj7hv8vaPEgsg10QacioHQMSXYxt3IqI2HTKO3fUYi1Uop3yW89rew18cHNV9tLFUo+LjnOj7ryCeeIWtjADtoNAb4ScYMD1sKEyO0LwUTxuhJpvWB/rvyq2u9jagAnsnYO8x5xyX+Nosu9YMpFxAERgPpVjTPZwUjtSChIXcIXPOc/4DJvQVSG4UdgGQDIzMYvKU/etw1bnAVLmgpvJjKJb8WgRMFAJEcNTaElzT4gzNnK7oEfotUKOkXsiRA7fJ19qkFCqwe713o7s5l98Vdz7ndBy/6F6lhYdo7CGDZ2jGy9pchDbOC28tf1bWecFIBBTgTGaMXrhYj8LbpbK6uYxM4XeAu1ViXMbcqJU4U6tKkg5ofjwj9B+9biKXcLTHqlbS0FE77n/D52ghqZUzU1BhYFb4YyigMU2hGzrZzcF79c1Ywu2NMO7shpBNhcWqbZrPs6ezGVM5nx2oMqwXaZd6DBi8wbpQvF5txkfC5w6v/lXk2BfVIMgd6I7UcJ4wGKhdjZR3ZBrLSmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(66476007)(66556008)(66946007)(8936002)(4326008)(8676002)(86362001)(186003)(5660300002)(508600001)(31696002)(6486002)(6506007)(33964004)(53546011)(36756003)(2616005)(6666004)(2906002)(38100700002)(83380400001)(6512007)(31686004)(110136005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y20xWVBBeHdaMHJaYnRtQ012QWtvTGVjdGRHK2VWWUgveHY1N2ZVSXo3NTdM?=
 =?utf-8?B?UEdlL1REMTJWUzVNTnVKUGQvdUUzSEZzd0lJWXJ0bE84T0xHZ0VudzlGa002?=
 =?utf-8?B?V29XYnFuY3JmcTRkUGQ3ZDVXVkhFaXZLczRjY2VYZyt4M2xTT3ZDM3I1Ulpj?=
 =?utf-8?B?amYzOEVpTlp1UGhQcU90R3pJMTNGZk5CWGdRN3NBVVdpZEU1OVNUQTY1dElW?=
 =?utf-8?B?NXV2Syt4MVBPL2RtZVZRNnhta1JCTDlXa1k4MGJGZzNQT2tqR3M4YmFDK1pz?=
 =?utf-8?B?YXVsblI3WUluUWdEWEo4ZVlEUmJkNjh4bDVEY3pnTXI5UHBOYmlpSiswQUdl?=
 =?utf-8?B?Z3FBT0RaZkpwTnJtbG5sRjl3d29tZFVGdG9qcjF6TnlDM0JCaFNLcC9GeXdT?=
 =?utf-8?B?L01kOSttUjBvSitnQmtKZzRHY01iM3JTYUNUZFE4UVhXQkhkVy9vSFVKSjBq?=
 =?utf-8?B?Y3QrYkFFb3o4cjB6OWFzcWZUK09QK0p5ZjZWSktkSTVoR0VpRm5RNy8yTmxL?=
 =?utf-8?B?UTBkeUdzeG1oZVpxSEpSOXkyVFZRYktBc1hRZ0ZvcXBFNHpvT0JwUXNOUEIv?=
 =?utf-8?B?NEgxbFNIMFlOOHpOaFg3Q2JCYmFSaGZHVHFxSGNxa1ZIdVVYdm5ieDgzRkJQ?=
 =?utf-8?B?Mld2UU1QbHRrVFZLa2hpWXAreW44UXg5UC9sblBDV0s1YW52cUM2cVE3aE1R?=
 =?utf-8?B?ZENrSndRNDUyQzdyd3JKSG45Ry9LMjRpNDlqaGF4QUdkV3luTWg5RmliMHAx?=
 =?utf-8?B?Q21kTCs2Y0ZSSDFkYW5DZW1JRENvWGhwQXA4cGZrKzR5cmpKd0tIRlRlM0d1?=
 =?utf-8?B?dXF1ZEhFV1ZodHZJbTJvZzNKMU52K2djYUROZ3pUd3FEdU9UNTVTS3FESGhH?=
 =?utf-8?B?UmFpU3RBdlFnUjZvNnFFbERhWUhsQVRNNnhYcENIaE52WDJRSTVrMEZKSW1k?=
 =?utf-8?B?VGFMa3pBZnU5UlZCdEJ4L21sRUlXTFRHWklMUlFpbUFhTHpzTFBCeVB0d21o?=
 =?utf-8?B?WGdobDB6YitYeWthTXcrUnRzQnZ6eEZmM2ZqWjNHUmg5Ym8yZUo0YUhXWUcv?=
 =?utf-8?B?Y2tQaUZwTE9EeVBNNW5VYTFweEIxVWdXQktUN0RsUTAveFpxV3poa2NIYmRa?=
 =?utf-8?B?bkVXeWkvZExFM0tTclFMZnRCUWgrNXhMWm5MdWtNd3hTaS9Ib0dEalhsUGR2?=
 =?utf-8?B?OGY5b090QVRPSU9nY0FINUN6VUhoZVRjbWNwcSsyeDU4MUJkWk0xK3ZFMXZa?=
 =?utf-8?B?b1ZvRUt6MS92REZva1Jkekp1L3dnQ01mUVdhajhCcTZ3ZUJjVTRTVG9PK3hQ?=
 =?utf-8?B?QzBidWlKUHJ0Q1pML0F3TE9jU2ZLVXZiOXptQkJ3dXpvUU53azE1cFllcVVY?=
 =?utf-8?B?c1JUZXVBbUhVb3lJQm1pck9rZzhKd242T0lLSDl5MjdHYlhiTVFheVRySE9L?=
 =?utf-8?B?MEdvbkNCVHpldlBCUk0rUHVIZU9mNFZYR0lta21wdzF6ZHdZMjczdVFFTWph?=
 =?utf-8?B?d2xiVGpWaEhrcnNRMnVGd2h0MkpCR0ZmclcyZE1IOVVrMG1ISm01M29KcDNM?=
 =?utf-8?B?ODVxcko2eDlPTTZXVjAraUtsaWgvV0U3MmhqZXY4WVRBdkN0a25ZckVteEM3?=
 =?utf-8?B?b0IrQUJnRFpCdVUza3kxVlhpYktWdlY3YVJQMWIzYkVLem5FTzZUTGFHYnNw?=
 =?utf-8?B?WDBwS01qYmZYc2xFQXh5YU5uMjlkK2hXRllKT2xTeG9BYTYwRzd4MkVrcktl?=
 =?utf-8?B?LzI2a0FuWXRkRldLTjE5UTRWcVVpZndJZ1lvbzVJV1cvZUpZYTgxZW5wVUhn?=
 =?utf-8?B?NlFQTVFmMTBOb2FYeVFYUGNOc0hWRmc5ZS81blFzVjBWbk5JTTRBOUFzZmxm?=
 =?utf-8?B?OFh1SUxkZGlCRGd1RVQ2RlkvT0NvNzFPZUlaeUhQZGtrV2d5bG5UVGtPa0dU?=
 =?utf-8?B?clBUZTR3OE85R2dRMzhHUVEvWC92eDcyUGtoR1ZDNzlRZ3lwUERweTkzNGxJ?=
 =?utf-8?B?cFFZd3pTd2FnMHEzTjlNdFpQNmI1MEVwVTBOVXlxS3hmSDlhT3pPb0tsd285?=
 =?utf-8?B?Z1JEdkhYYWJuUzRPdE1iTkdpZ05wTVZQdDZlbmVELzN2TUtNVkdqZXZhTkhM?=
 =?utf-8?B?VDAyVStMb0RLVjduVC8wVVEzOVVTeWczaEhpM0lCQVpLQWJTaFZMSHROaXdN?=
 =?utf-8?B?U0hhaGkzWFRaZ2cxZmlOVFUwRGlmYm9YbU0vb2o4WVNmc2dNa2FFRlF5SDZo?=
 =?utf-8?B?WFpxSGdCbTd1My9RMlVNajdwSzcwUWN2MU5iWm1UMThKN09MUWIzcGtyc1Rm?=
 =?utf-8?B?RTgwTXQ5S0F6Q3UvY2ZoTyt4OU1HTyswVThiY29rMFNJYjBlM3E3bXJpKzZq?=
 =?utf-8?Q?UEpgoku7uGFXVJ1JAsnN9imY0NT2hdDeYSwRhKG73V0YG?=
X-MS-Exchange-AntiSpam-MessageData-1: AVel5mrZy0FRRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5b0f8-ad25-4692-775f-08da37461562
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 14:12:17.5797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHUy6UlLJLk0+mgYuPHJrConGc4ygnxrbjJFRsCa5pqvXNa0RTGWtX2Jagkm3OUDgZ6qIx2EO2TK/RkkwVeDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------8EdBbDqkdX0G8jAvBYHoQS1X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping

Andrey

On 2022-05-13 11:41, Andrey Grodzovsky wrote:
>> Yes, exactly that's the idea.
>>
>> Basically the reset domain knowns which amdgpu devices it needs to 
>> reset together.
>>
>> If you then represent that so that you always have a hive even when 
>> you only have one device in it, or if you put an array of devices 
>> which needs to be reset together into the reset domain doesn't matter.
>>
>> Maybe go for the later approach, that is probably a bit cleaner and 
>> less code to change.
>>
>> Christian.
>
>
> Unfortunately this approach raises also a few  difficulties -
> First - if holding array of devices in reset_domain then when you come 
> to GPU reset function you don't really know which adev is the one 
> triggered the reset and this is actually essential to some procedures 
> like emergency restart.
>
> Second - in XGMI case we must take into account that one of the hive 
> members might go away in runtime (i could do echo 1 > 
> /sysfs/pci_id/remove on it for example at any moment) - so now we need 
> to maintain this array and mark such entry with NULL probably on XGMI 
> node removal , and then there might be hot insertion and all this adds 
> more complications.
>
> I now tend to prefer your initial solution for it's simplicity and the 
> result will be what we need -
>
> "E.g. in the reset code (either before or after the reset, that's 
> debatable) you do something like this:
>
> for (i = 0; i < num_ring; ++i)
> cancel_delayed_work(ring[i]->scheduler....)
> cancel_work(adev->ras_work);
> cancel_work(adev->iofault_work);
> cancel_work(adev->debugfs_work);
> "
>
> Let me know what you think.
>
> Andrey 
--------------8EdBbDqkdX0G8jAvBYHoQS1X
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Ping <br>
    </p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-13 11:41, Andrey Grodzovsky
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com">
      <blockquote type="cite" style="color: #007cff;">Yes, exactly
        that's the idea.
        <br>
        <br>
        Basically the reset domain knowns which amdgpu devices it needs
        to reset together.
        <br>
        <br>
        If you then represent that so that you always have a hive even
        when you only have one device in it, or if you put an array of
        devices which needs to be reset together into the reset domain
        doesn't matter.
        <br>
        <br>
        Maybe go for the later approach, that is probably a bit cleaner
        and less code to change.
        <br>
        <br>
        Christian.
        <br>
      </blockquote>
      <br>
      <br>
      Unfortunately this approach raises also a few&nbsp; difficulties -
      <br>
      First - if holding array of devices in reset_domain then when you
      come to GPU reset function you don't really know which adev is the
      one triggered the reset and this is actually essential to some
      procedures like emergency restart.
      <br>
      <br>
      Second - in XGMI case we must take into account that one of the
      hive members might go away in runtime (i could do echo 1 &gt;
      /sysfs/pci_id/remove on it for example at any moment) - so now we
      need to maintain this array and mark such entry with NULL probably
      on XGMI node removal , and then there might be hot insertion and
      all this adds more complications.
      <br>
      <br>
      I now tend to prefer your initial solution for it's simplicity and
      the result will be what we need -
      <br>
      <br>
      &quot;E.g. in the reset code (either before or after the reset, that's
      debatable) you do something like this:
      <br>
      <br>
      for (i = 0; i &lt; num_ring; ++i)
      <br>
      cancel_delayed_work(ring[i]-&gt;scheduler....)
      <br>
      cancel_work(adev-&gt;ras_work);
      <br>
      cancel_work(adev-&gt;iofault_work);
      <br>
      cancel_work(adev-&gt;debugfs_work);
      <br>
      &quot;
      <br>
      <br>
      Let me know what you think.
      <br>
      <br>
      Andrey
    </blockquote>
  </body>
</html>

--------------8EdBbDqkdX0G8jAvBYHoQS1X--
