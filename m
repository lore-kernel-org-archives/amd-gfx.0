Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F513C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 21:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951EE10E9AE;
	Fri, 25 Feb 2022 21:23:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F333C10E9AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 21:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyTptHRV1FrPrz6YJuStVq0C+nnGCqm0Z9JKKh9XbXGT2fUJ0QvLloksrmdBAQCgM8XbD51Nrxvud0LzXvEh7nqE+x4eM/pLzPsOJ5CjK6VwhO5z/Es6OV7MHsh7m8DYqC7J+8l/nvI+J7jLOv8nFNjU2N21MfPPnpjJdyBuiYHQzjY/h/nvTMgPkwRe3oW/CeichLKnX6JNsyyKd8KZkXo+cemYFh7N0BwJeN9a40riI6Rl+qIvE4E4CLjmJP13nO9XLWdYO8BJ1aYR47nCKbMCJv/fv1WsJBcrRfaczyxVle74tffrWr/C5lM1RobZ5V+BQoLJkz0DiwlPllQdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzcmpH3ran9b+Cdd7od0kAfsgNJBBDgpgXy4HaQ8XEo=;
 b=VKxKAEivXlK6P+oS+fxXyUveytvPt5Io9VgtWsknbLnEpLiOLaSkKtdcJIYN8M5Be/yG7NxgU/cNspJAXjtWBDFI3Kl8zCloaim18UZ2OxxC8jO+nAKTIbiZp3U9JrBgZsvYHwr6b/j675EZGiNg5yMtSDCPj6MfY7827JP2OB+JKm0o3TIC00k8o8Fd7rpzHD1JwKRysK09gfkmO5yJtFsc6BUdhvWlgiL5zLoYeKj+CbqYAShoND4LCK3dw1V7gdbOPm3anhVppPCPNVTiTlLss6G5Wn2FSJXsfcANztUUM6ZMjDg0q9vxtOvAxlJ6ephefNFRLJP9HM2BjixOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzcmpH3ran9b+Cdd7od0kAfsgNJBBDgpgXy4HaQ8XEo=;
 b=oKl6UXtgOLJOkHAD5wnhXdIq2wm1qvwuj/WjpLYoHQ0K+R7/oaZN08dZTGLpQLTlUK9rFPx9zKJqN942uN7+lMt89of7BRjItkM9keZpDOxKGQwJsOmj+o9y+gt0yC2zRVZ+BENI0ez8PGNp7Kdshrqr1kSvkg4tfq52jcerSEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BY5PR12MB4854.namprd12.prod.outlook.com (2603:10b6:a03:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 21:22:58 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 21:22:58 +0000
Content-Type: multipart/mixed; boundary="------------UwIFBqoHO4Ie10fMTNiTjn3w"
Message-ID: <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
Date: Fri, 25 Feb 2022 16:22:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Content-Language: en-US
To: JingWen Chen <jingwech@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
X-ClientProxiedBy: YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e636f857-30c0-47fb-b1d0-08d9f8a4fe64
X-MS-TrafficTypeDiagnostic: BY5PR12MB4854:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4854ACE87C7DE80C6D2A51C2EA3E9@BY5PR12MB4854.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WrxPb+iOMtadqJd/Nn+6kiBuhtiBplQT6E3Lj573n05Dfq6/JZNZ0Qzey13nVCE9avsKWpClhpAZHyLUw9OdlniGDsHC8vfkZLUZXAZBYbo7SbVJPIiqm5F+42Y1Jc0Z6eS9iRq8ckCDVTF7aQHLw4dU9Z7GtoLAiQPHaUmq0Mrdc6IELk32elrLsELHh5GKxBEsyTwlg/UFnfRV8ilRLQ3yE/r9TUC1gK3D5yKH4y2lhh+utQveDtjP99PPSN4u1v4qPhiCSrVvCmuQy1ICQqQk3oc1aqNRNYy7YgzB9+UP1xvlcRs8vYdUe5NIIQt27qgPIfHNdwNHeehftknHvBmiP7Y75+W7LaC2Z9zqSUYXRFSNIpy8WDzJXTUooGazfaG6Y1VvvFB6bjTnSB/nRJUOX1pt5LmXbsHZ9HNBfx0rSnKJRfk+3EJs+zE8xldID5kBZ6Cclk54gpwMIuvfIp9ZDX7Nuo/Xjg6ZJ6ZL6JqQ8pccyPjK1+V5Tw25pe+KVm9ZsjLMEDJWwcQnUu8+m35CQPHhYPVIW/TqvJlrX7xC0GDLubw1Byi285TaiyvJdeKuUOJvbV4xeXx54EwJ1NG1bvSRrOvo76f3OKpP2sFWqwA7AdRqltYDsghauyjfC6Bnil45cWF8QLVrO/a1k1J9NhMd41+6oPXDxmNXJBTAsYmN7tqX06x5wDn7YOk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(83380400001)(110136005)(54906003)(38100700002)(4326008)(31686004)(316002)(66946007)(66556008)(66476007)(8676002)(86362001)(2906002)(186003)(2616005)(31696002)(44832011)(6486002)(36756003)(508600001)(6512007)(33964004)(8936002)(235185007)(5660300002)(6506007)(6666004)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVYrd3p6TE1VYUM2blZtYWhoT0hrN1l4ZUFmQU5hd1hBWU5KanFqbTcyVEw4?=
 =?utf-8?B?K2xJY2ZqOGFzWTZZYWF4cUpqWDV6VzdrMFNJZVExelhMTXA0MDJ4SXhGbVM2?=
 =?utf-8?B?L2cyU09USWsrYjN4OUw5ZUNsS3dVVXVya1ZYdWZ2cGQrclZpV3BnaGRVTU5j?=
 =?utf-8?B?aSs0eVFZeC9ZQjZ2NUo0WUYyQlV6bzZ4YndWODZjK1oyUXZCTHdleGdCNUNt?=
 =?utf-8?B?T2h3QnJSRHlpOGtITHJxU1hIR2RDMkVWWG5LSFZrTG13c0ZMcXg0VUZDN0Jj?=
 =?utf-8?B?RDBlakF6djEzbkIwc1pSZFhwTTJJVXNVaTdxVHFhOStPZzZ0eWcrUmNCdHRj?=
 =?utf-8?B?Mm9yNzNZZW1jVnlEKy83cTVEWHpoQjVIMHlUMFVTZGk1NDdEVjFFNkk0WVps?=
 =?utf-8?B?Z1hjcGFyaDBCQlBTK2RBeGpHUEZhUmttckhFYTFvUGFSSkJxQ3VWdEx0TE1T?=
 =?utf-8?B?MGtqNFQrcHhhbVdwOXdjWUZ0M1AxQ0wvU3BHdlZCUUlud3JSTWxxL2djUzZU?=
 =?utf-8?B?S0FrRUNiREhmOWQyMkd4SmlKMWtLL3puM2tCTEFhK1c2d0dPWTdFbHZ2VjJU?=
 =?utf-8?B?SWMzTEE0V1FuTldacm5zQlhCb1RTUThCbURSYlhsOGNNMHYzNXVCVXdMWktz?=
 =?utf-8?B?T3VDNE9QM2RBQVhBYjlUaUZEK2xlN3YxaUZ3QkErWXJnRXp2TWRpRXQzRFlM?=
 =?utf-8?B?Mmt3ZW9VZkozelo1OFVjRVNWbysrYkQ2ejlENWFQN1l5OUdHZlJVbGQxZi9n?=
 =?utf-8?B?ZVA1cC9Xa0UyRlpHcTgrdm1odzFVZTRDRFkxY1BGVDA5TXNyVlZ2RWQ1ZEdP?=
 =?utf-8?B?TnJHaGU4ZksvV1ZPUjkwaHJrOW9wR3VyYnJLc3k1dmhuOTB2aVZYUWJjNXkz?=
 =?utf-8?B?UmtJZnI2YTFCcFk3aDN4RzhadHlQUi9IbnhWRFdLK3VjRFNmZDEyaEZKbEI4?=
 =?utf-8?B?aVN2eHQwMDNyclBlaS9oSzEvTFJaaC9vZGQzMWJsV1R5cXVYYWZxRlFxLzgy?=
 =?utf-8?B?algwT1RvS2dIUHZTQ2thcTJWcDl3NWxPNjJneStjYzAzeFQ0MjlINW0xbE9t?=
 =?utf-8?B?THZwdmxzbWVSVHFqUFFsUUtPUGltR0NRN2czK2o3TW8rb0tqcXNQK1M4Wm1q?=
 =?utf-8?B?MWNCUDJHYzZvdVlmNGVjcmRaSUlXUVNSRm9TV3hhd2VydlhSRGdCaEk3bVZu?=
 =?utf-8?B?SmNmeWFtcHFFWjlLNU4yYkRTMWVUTE84RU5uUlIvMkdzak95cUtJeUgrdXNI?=
 =?utf-8?B?RWYvc2V2RWtMeFY0V0tZYk9qTFY1c2ZSUTZ2aHFhTEd0ek4ybG01Vmc2RStv?=
 =?utf-8?B?OU9OeTZDZ0IwUjFGMklJRjVpR2U4Vi8zRnUwemVScjdtQjVxUHlQWGNNa3pJ?=
 =?utf-8?B?S2Zvd1A2bkFhUW1ZY0t2TkhlN09JWWdCWVVuTCtuM3A3WkZpcXAxYi96SjRj?=
 =?utf-8?B?bGgrdm51MkM2MmdkOHQ5L1B4aVlLMHlPTmNaOW1KNnFHeFpqRFExblJBeU03?=
 =?utf-8?B?UFROemJ4N2VaQmVqSHhwTlo2bjFsVDRLRDM4U25TM2VIakkwL0lQRUNnTEtx?=
 =?utf-8?B?OWN4M0ZWY21FMGpuMm4xalVCcXQyYnVyeTVoZ3hRblE5YnRiOGJxaGtEcmRC?=
 =?utf-8?B?L2xxS0ZMN29IRFA2eXh4Y3QydXpzalE5Vk9lU29sc0c0cVhjNW1jZUQ1QTdD?=
 =?utf-8?B?clZTNTFESzUvbzNLVkFza3h0SWZXdjJGYjI3Si9reTdlZnB0eDliMDNMOVo0?=
 =?utf-8?B?UExvUy92Sm9lSUZ0RkVRbCtBMVp5bnJ4MVR1VExuZkN1RCtDd1hWUmV0WDlQ?=
 =?utf-8?B?dUpMY1c3YU44VDhSc0hCNzRPbThFay9VSlIxUjJOQXJoTU5VUmV1OWpzNDRu?=
 =?utf-8?B?RmptNTN1Rlh2VS8vQVZiTUxlSCtwZzdOOUVwT0VKbFZIcHluc2ZtRndsOWFJ?=
 =?utf-8?B?ejJaNnRDejU3V29ORWZQWVltYXh3ZHJMVDVYNWpPN1NTM2lXWlk4bG1jb1dD?=
 =?utf-8?B?aDFPWXBmSW03SUh3RitWdlViTEV3S0JJZkhyMjJYUVV3MDR6cC81c09lNHFQ?=
 =?utf-8?B?VlNEbDQvODZqUzJFVDY5MlROSEdMRHJEUDJsS3ozOWdNbXNWbnpkMmVqMU1S?=
 =?utf-8?B?ZzQ5ZkJwSmtpK2lZVjVCK1ZTNzJIWFVVVE5yVkxZOENrZFhIek1iZWprWk5V?=
 =?utf-8?B?eGg4RitLYlBIMElyMGtEMytiYUN2TkZkQmpTUnBhQk4xSzRvTlBjQUlnbW9m?=
 =?utf-8?Q?I6TE/pblsr+MBNsGPnR8cJwNevEwQiRR6AU8q4Fb8Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e636f857-30c0-47fb-b1d0-08d9f8a4fe64
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 21:22:57.9410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeJLME8Ahs53xNuLwkNmZhJCwTjbEbFIjYbM762DZZLXl8o/lEFUp/oDF+yV+JqwESebHUJIHc8xONAOGz7bpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4854
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
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey, patches attached - i applied the patches and resolved merge 
conflicts but weren't able to test as my on board's network card doesn't 
work with 5.16 kernel (it does with 5.17, maybe it's Kconfig issue and i 
need to check more).
The patches are on top of 'cababde192b2 Yifan Zhang         2 days 
ago     drm/amd/pm: fix mode2 reset fail for smu 13.0.5 ' commit.

Please test and let me know. Maybe by Monday I will be able to resolve 
the connectivity issue on 5.16.

Andrey

On 2022-02-24 22:13, JingWen Chen wrote:
> Hi Andrey,
>
> Sorry for the misleading, I mean the whole patch series. We are depending on this patch series to fix the concurrency issue within SRIOV TDR sequence.
>
>
>
> On 2/25/22 1:26 AM, Andrey Grodzovsky wrote:
>> No problem if so but before I do,
>>
>>
>> JingWen - why you think this patch is needed as a standalone now ? It has no use without the
>> entire feature together with it. Is it some changes you want to do on top of that code ?
>>
>>
>> Andrey
>>
>>
>> On 2022-02-24 12:12, Deucher, Alexander wrote:
>>> [Public]
>>>
>>>
>>> If it applies cleanly, feel free to drop it in.  I'll drop those patches for drm-next since they are already in drm-misc.
>>>
>>> Alex
>>>
>>> ------------------------------------------------------------------------
>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> *Sent:* Thursday, February 24, 2022 11:24 AM
>>> *To:* Chen, JingWen <JingWen.Chen2@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Cc:* Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>
>>> *Subject:* Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is ready
>>> No because all the patch-set including this patch was landed into
>>> drm-misc-next and will reach amd-staging-drm-next on the next upstream
>>> rebase i guess.
>>>
>>> Andrey
>>>
>>> On 2022-02-24 01:47, JingWen Chen wrote:
>>>> Hi Andrey,
>>>>
>>>> Will you port this patch into amd-staging-drm-next?
>>>>
>>>> on 2/10/22 2:06 AM, Andrey Grodzovsky wrote:
>>>>> All comments are fixed and code pushed. Thanks for everyone
>>>>> who helped reviewing.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-02-09 02:53, Christian König wrote:
>>>>>> Am 09.02.22 um 01:23 schrieb Andrey Grodzovsky:
>>>>>>> Before we initialize schedulers we must know which reset
>>>>>>> domain are we in - for single device there iis a single
>>>>>>> domain per device and so single wq per device. For XGMI
>>>>>>> the reset domain spans the entire XGMI hive and so the
>>>>>>> reset wq is per hive.
>>>>>>>
>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>> One more comment below, with that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>
>>>>>>> ---
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 34 ++--------------
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>>>>>>>      3 files changed, 51 insertions(+), 30 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 9704b0e1fd82..00123b0013d3 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -2287,6 +2287,47 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>>>          return r;
>>>>>>>      }
>>>>>>>      +static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>>>>> +{
>>>>>>> +    long timeout;
>>>>>>> +    int r, i;
>>>>>>> +
>>>>>>> +    for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>> +        struct amdgpu_ring *ring = adev->rings[i];
>>>>>>> +
>>>>>>> +        /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>> +        if (!ring || ring->no_scheduler)
>>>>>>> +            continue;
>>>>>>> +
>>>>>>> +        switch (ring->funcs->type) {
>>>>>>> +        case AMDGPU_RING_TYPE_GFX:
>>>>>>> +            timeout = adev->gfx_timeout;
>>>>>>> +            break;
>>>>>>> +        case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>> +            timeout = adev->compute_timeout;
>>>>>>> +            break;
>>>>>>> +        case AMDGPU_RING_TYPE_SDMA:
>>>>>>> +            timeout = adev->sdma_timeout;
>>>>>>> +            break;
>>>>>>> +        default:
>>>>>>> +            timeout = adev->video_timeout;
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>> + ring->num_hw_submission, amdgpu_job_hang_limit,
>>>>>>> +                   timeout, adev->reset_domain.wq, ring->sched_score, ring->name);
>>>>>>> +        if (r) {
>>>>>>> +            DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>> +                  ring->name);
>>>>>>> +            return r;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>>      /**
>>>>>>>       * amdgpu_device_ip_init - run init for hardware IPs
>>>>>>>       *
>>>>>>> @@ -2419,6 +2460,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>              }
>>>>>>>          }
>>>>>>>      +    r = amdgpu_device_init_schedulers(adev);
>>>>>>> +    if (r)
>>>>>>> +        goto init_failed;
>>>>>>> +
>>>>>>>          /* Don't init kfd if whole hive need to be reset during init */
>>>>>>>          if (!adev->gmc.xgmi.pending_reset)
>>>>>>> amdgpu_amdkfd_device_init(adev);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> index 45977a72b5dd..fa302540c69a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> @@ -457,8 +457,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>                        atomic_t *sched_score)
>>>>>>>      {
>>>>>>>          struct amdgpu_device *adev = ring->adev;
>>>>>>> -    long timeout;
>>>>>>> -    int r;
>>>>>>>            if (!adev)
>>>>>>>              return -EINVAL;
>>>>>>> @@ -478,36 +476,12 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>> spin_lock_init(&ring->fence_drv.lock);
>>>>>>>          ring->fence_drv.fences = kcalloc(num_hw_submission * 2, sizeof(void *),
>>>>>>>                           GFP_KERNEL);
>>>>>>> -    if (!ring->fence_drv.fences)
>>>>>>> -        return -ENOMEM;
>>>>>>>      -    /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>> -    if (ring->no_scheduler)
>>>>>>> -        return 0;
>>>>>>> +    ring->num_hw_submission = num_hw_submission;
>>>>>>> +    ring->sched_score = sched_score;
>>>>>> Let's move this into the caller and then use ring->num_hw_submission in the fence code as well.
>>>>>>
>>>>>> The maximum number of jobs on the ring is not really fence specific.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>      -    switch (ring->funcs->type) {
>>>>>>> -    case AMDGPU_RING_TYPE_GFX:
>>>>>>> -        timeout = adev->gfx_timeout;
>>>>>>> -        break;
>>>>>>> -    case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>> -        timeout = adev->compute_timeout;
>>>>>>> -        break;
>>>>>>> -    case AMDGPU_RING_TYPE_SDMA:
>>>>>>> -        timeout = adev->sdma_timeout;
>>>>>>> -        break;
>>>>>>> -    default:
>>>>>>> -        timeout = adev->video_timeout;
>>>>>>> -        break;
>>>>>>> -    }
>>>>>>> -
>>>>>>> -    r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>> -               num_hw_submission, amdgpu_job_hang_limit,
>>>>>>> -               timeout, NULL, sched_score, ring->name);
>>>>>>> -    if (r) {
>>>>>>> -        DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>> -              ring->name);
>>>>>>> -        return r;
>>>>>>> -    }
>>>>>>> +    if (!ring->fence_drv.fences)
>>>>>>> +        return -ENOMEM;
>>>>>>>            return 0;
>>>>>>>      }
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>> index fae7d185ad0d..7f20ce73a243 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>> @@ -251,6 +251,8 @@ struct amdgpu_ring {
>>>>>>>          bool has_compute_vm_bug;
>>>>>>>          bool            no_scheduler;
>>>>>>>          int            hw_prio;
>>>>>>> +    unsigned num_hw_submission;
>>>>>>> +    atomic_t        *sched_score;
>>>>>>>      };
>>>>>>>        #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0012-drm-amdgpu-Fix-compile-error.patch"
Content-Disposition: attachment;
 filename="0012-drm-amdgpu-Fix-compile-error.patch"
Content-Transfer-Encoding: base64

RnJvbSA5Yzg3ODM4NzJmNDJhNTMzNDQwZWVlZDU1MjdmNjQxOGZhZDdhYWZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogV2VkLCA5IEZlYiAyMDIyIDIyOjE3OjI0IC0wNTAwClN1YmplY3Q6IGRy
bS9hbWRncHU6IEZpeCBjb21waWxlIGVycm9yLgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKU2VlbXMgSSBmb3Jnb3QgdG8gYWRkIHRoaXMgdG8gdGhlIHJlbGV2YW50IGNvbW1pdAp3
aGVuIHN1Ym1pdHRpbmcuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5
Lmdyb2R6b3Zza3lAYW1kLmNvbT4KUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Ckxpbms6IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRj
aC9tc2dpZC8yMDIyMDIxMDAzMTcyNC40NDA5NDMtMS1hbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmggfCAzICstLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgKaW5kZXggOTJkZTNiNzk2NWExLi4xOTQ5
ZGJlMjhhODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
ZXNldC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oCkBA
IC0xMTgsOCArMTE4LDcgQEAgc3RhdGljIGlubGluZSBib29sIGFtZGdwdV9yZXNldF9kb21haW5f
c2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gKmRvbWEKIAlyZXR1cm4gcXVldWVf
d29yayhkb21haW4tPndxLCB3b3JrKTsKIH0KIAotdm9pZCBhbWRncHVfZGV2aWNlX2xvY2tfcmVz
ZXRfZG9tYWluKHN0cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluICpyZXNldF9kb21haW4sCi0JCQkJ
ICAgICBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSk7Cit2b2lkIGFtZGdwdV9kZXZpY2Vf
bG9ja19yZXNldF9kb21haW4oc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gKnJlc2V0X2RvbWFp
bik7CiAKIHZvaWQgYW1kZ3B1X2RldmljZV91bmxvY2tfcmVzZXRfZG9tYWluKHN0cnVjdCBhbWRn
cHVfcmVzZXRfZG9tYWluICpyZXNldF9kb21haW4pOwogCi0tIAoyLjI1LjEKCg==

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0011-drm-amdgpu-Revert-drm-amdgpu-annotate-a-false-positi.patch"
Content-Disposition: attachment;
 filename*0="0011-drm-amdgpu-Revert-drm-amdgpu-annotate-a-false-positi.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiNmEwMTk1MzIwMzgwN2EzNDFjYTcxMjljYjVmZTFmZjQ3NzNlY2MzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogVHVlLCAyNSBKYW4gMjAyMiAxMTozNjoxOCAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBSZXZlcnQgJ2RybS9hbWRncHU6IGFubm90YXRlIGEgZmFsc2UgcG9zaXRpdmUg
cmVjdXJzaXZlCiBsb2NraW5nJwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQv
cGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKU2lu
Y2Ugd2UgaGF2ZSBhIHNpbmdsZSBpbnN0YW5jZSBvZiByZXNldCBzZW1hcGhvcmUgd2hpY2ggd2UK
bG9jayBvbmx5IG9uY2UgZXZlbiBmb3IgWEdNSSBoaXZlIHdlIGRvbid0IG5lZWQgdGhlIG5lc3Rl
ZApsb2NraW5nIGhpbnQgYW55bW9yZS4KClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5
IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpMaW5rOiBodHRwczovL3d3dy5zcGluaWNzLm5l
dC9saXN0cy9hbWQtZ2Z4L21zZzc0MTIwLmh0bWwKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgNCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmVzZXQuYyAgfCAxMSArKy0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwppbmRleCAzODliNGIwZmQyMDkuLjA5ODlmNjgyZTBhNCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtNTEyNyw3ICs1MTI3
LDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXJfaW1wKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCS8qIFdlIG5lZWQgdG8gbG9jayByZXNldCBkb21haW4gb25seSBvbmNlIGJv
dGggZm9yIFhHTUkgYW5kIHNpbmdsZSBkZXZpY2UgKi8KIAl0bXBfYWRldiA9IGxpc3RfZmlyc3Rf
ZW50cnkoZGV2aWNlX2xpc3RfaGFuZGxlLCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSwKIAkJCQkgICAg
cmVzZXRfbGlzdCk7Ci0JYW1kZ3B1X2RldmljZV9sb2NrX3Jlc2V0X2RvbWFpbih0bXBfYWRldi0+
cmVzZXRfZG9tYWluLCBoaXZlKTsKKwlhbWRncHVfZGV2aWNlX2xvY2tfcmVzZXRfZG9tYWluKHRt
cF9hZGV2LT5yZXNldF9kb21haW4pOwogCiAJLyogYmxvY2sgYWxsIHNjaGVkdWxlcnMgYW5kIHJl
c2V0IGdpdmVuIGpvYidzIHJpbmcgKi8KIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBk
ZXZpY2VfbGlzdF9oYW5kbGUsIHJlc2V0X2xpc3QpIHsKQEAgLTU1NTQsNyArNTU1NCw3IEBAIHBj
aV9lcnNfcmVzdWx0X3QgYW1kZ3B1X3BjaV9lcnJvcl9kZXRlY3RlZChzdHJ1Y3QgcGNpX2RldiAq
cGRldiwgcGNpX2NoYW5uZWxfc3RhCiAJCSAqIExvY2tpbmcgYWRldi0+cmVzZXRfZG9tYWluLT5z
ZW0gd2lsbCBwcmV2ZW50IGFueSBleHRlcm5hbCBhY2Nlc3MKIAkJICogdG8gR1BVIGR1cmluZyBQ
Q0kgZXJyb3IgcmVjb3ZlcnkKIAkJICovCi0JCWFtZGdwdV9kZXZpY2VfbG9ja19yZXNldF9kb21h
aW4oYWRldi0+cmVzZXRfZG9tYWluLCBOVUxMKTsKKwkJYW1kZ3B1X2RldmljZV9sb2NrX3Jlc2V0
X2RvbWFpbihhZGV2LT5yZXNldF9kb21haW4pOwogCQlhbWRncHVfZGV2aWNlX3NldF9tcDFfc3Rh
dGUoYWRldik7CiAKIAkJLyoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yZXNldC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0
LmMKaW5kZXggNjkwNjE1MzlhMjBmLi4yNDhkNjQxNTg3MjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCkBAIC0yMyw3ICsyMyw2IEBACiAKICNpbmNsdWRlICJh
bWRncHVfcmVzZXQuaCIKICNpbmNsdWRlICJhbGRlYmFyYW4uaCIKLSNpbmNsdWRlICJhbWRncHVf
eGdtaS5oIgogCiBpbnQgYW1kZ3B1X3Jlc2V0X2FkZF9oYW5kbGVyKHN0cnVjdCBhbWRncHVfcmVz
ZXRfY29udHJvbCAqcmVzZXRfY3RsLAogCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2hhbmRs
ZXIgKmhhbmRsZXIpCkBAIC0xMzgsMTYgKzEzNywxMCBAQCBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2Rv
bWFpbiAqYW1kZ3B1X3Jlc2V0X2NyZWF0ZV9yZXNldF9kb21haW4oZW51bSBhbWRncHVfcmVzZXRf
ZAogCXJldHVybiByZXNldF9kb21haW47CiB9CiAKLXZvaWQgYW1kZ3B1X2RldmljZV9sb2NrX3Jl
c2V0X2RvbWFpbihzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqcmVzZXRfZG9tYWluLAotCQkJ
CSAgICAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUpCit2b2lkIGFtZGdwdV9kZXZpY2Vf
bG9ja19yZXNldF9kb21haW4oc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gKnJlc2V0X2RvbWFp
bikKIHsKIAlhdG9taWNfc2V0KCZyZXNldF9kb21haW4tPmluX2dwdV9yZXNldCwgMSk7Ci0KLQlp
ZiAoaGl2ZSkgewotCQlkb3duX3dyaXRlX25lc3RfbG9jaygmcmVzZXRfZG9tYWluLT5zZW0sICZo
aXZlLT5oaXZlX2xvY2spOwotCX0gZWxzZSB7Ci0JCWRvd25fd3JpdGUoJnJlc2V0X2RvbWFpbi0+
c2VtKTsKLQl9CisJZG93bl93cml0ZSgmcmVzZXRfZG9tYWluLT5zZW0pOwogfQogCiAKLS0gCjIu
MjUuMQoK

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0010-drm-amdgpu-Rework-amdgpu_device_lock_adev.patch"
Content-Disposition: attachment;
 filename="0010-drm-amdgpu-Rework-amdgpu_device_lock_adev.patch"
Content-Transfer-Encoding: base64

RnJvbSA0OWI0MjFlYjY5NjliMTcyZDk3YmY3ODJiYWRkOWFhZWQ1ZTgxMDllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogVHVlLCAyNSBKYW4gMjAyMiAxMTozMjo0NyAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBSZXdvcmsgYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYKTUlNRS1WZXJzaW9uOiAx
LjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDhiaXQKClRoaXMgZnVuY3Rpb25zIG5lZWRzIHRvIGJlIHNwbGl0IGludG8g
MiBwYXJ0cyB3aGVyZQpvbmUgaXMgY2FsbGVkIG9ubHkgb25jZSBmb3IgbG9ja2luZyBzaW5nbGUg
aW5zdGFuY2Ugb2YKcmVzZXRfZG9tYWluJ3Mgc2VtIGFuZCByZXNldCBmbGFnIGFuZCB0aGUgb3Ro
ZXIgcGFydAp3aGljaCBoYW5kbGVzIE1QMSBzdGF0ZXMgc2hvdWxkIHN0aWxsIGJlIGNhbGxlZCBm
b3IKZWFjaCBkZXZpY2UgaW4gWEdNSSBoaXZlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6
b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ckxpbms6IGh0dHBzOi8vd3d3LnNwaW5p
Y3MubmV0L2xpc3RzL2FtZC1nZngvbXNnNzQxMTguaHRtbAotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDM3ICsrKysrKysrKysrKy0tLS0tLS0tLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jICB8IDIwICsrKysrKysrKysr
KwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmggIHwgIDQgKysrCiAz
IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBhOTY4Njg5OWI5Y2Eu
LjM4OWI0YjBmZDIwOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwpAQCAtNDg5OSwxNiArNDg5OSw4IEBAIGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1
Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUsCiAJcmV0dXJuIHI7CiB9CiAKLXN0YXRp
YyB2b2lkIGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAotCQkJCXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlKQorc3RhdGljIHZvaWQgYW1kZ3B1
X2RldmljZV9zZXRfbXAxX3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewotCWF0
b21pY19zZXQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+aW5fZ3B1X3Jlc2V0LCAxKTsKLQotCWlmICho
aXZlKSB7Ci0JCWRvd25fd3JpdGVfbmVzdF9sb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSwg
JmhpdmUtPmhpdmVfbG9jayk7Ci0JfSBlbHNlIHsKLQkJZG93bl93cml0ZSgmYWRldi0+cmVzZXRf
ZG9tYWluLT5zZW0pOwotCX0KIAogCXN3aXRjaCAoYW1kZ3B1X2FzaWNfcmVzZXRfbWV0aG9kKGFk
ZXYpKSB7CiAJY2FzZSBBTURfUkVTRVRfTUVUSE9EX01PREUxOgpAQCAtNDkyMywxMiArNDkxNSwx
MCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2xvY2tfYWRldihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKIAl9CiB9CiAKLXN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfdW5sb2NrX2Fk
ZXYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCitzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNl
X3Vuc2V0X21wMV9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlhbWRncHVf
dmZfZXJyb3JfdHJhbnNfYWxsKGFkZXYpOwogCWFkZXYtPm1wMV9zdGF0ZSA9IFBQX01QMV9TVEFU
RV9OT05FOwotCWF0b21pY19zZXQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+aW5fZ3B1X3Jlc2V0LCAw
KTsKLQl1cF93cml0ZSgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogfQogCiBzdGF0aWMgdm9p
ZCBhbWRncHVfZGV2aWNlX3Jlc3VtZV9kaXNwbGF5X2F1ZGlvKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQpAQCAtNTEzNCwxMCArNTEyNCwxNSBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVj
b3Zlcl9pbXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWRldmljZV9saXN0X2hhbmRs
ZSA9ICZkZXZpY2VfbGlzdDsKIAl9CiAKKwkvKiBXZSBuZWVkIHRvIGxvY2sgcmVzZXQgZG9tYWlu
IG9ubHkgb25jZSBib3RoIGZvciBYR01JIGFuZCBzaW5nbGUgZGV2aWNlICovCisJdG1wX2FkZXYg
PSBsaXN0X2ZpcnN0X2VudHJ5KGRldmljZV9saXN0X2hhbmRsZSwgc3RydWN0IGFtZGdwdV9kZXZp
Y2UsCisJCQkJICAgIHJlc2V0X2xpc3QpOworCWFtZGdwdV9kZXZpY2VfbG9ja19yZXNldF9kb21h
aW4odG1wX2FkZXYtPnJlc2V0X2RvbWFpbiwgaGl2ZSk7CisKIAkvKiBibG9jayBhbGwgc2NoZWR1
bGVycyBhbmQgcmVzZXQgZ2l2ZW4gam9iJ3MgcmluZyAqLwogCWxpc3RfZm9yX2VhY2hfZW50cnko
dG1wX2FkZXYsIGRldmljZV9saXN0X2hhbmRsZSwgcmVzZXRfbGlzdCkgewogCi0JCWFtZGdwdV9k
ZXZpY2VfbG9ja19hZGV2KHRtcF9hZGV2LCBoaXZlKTsKKwkJYW1kZ3B1X2RldmljZV9zZXRfbXAx
X3N0YXRlKHRtcF9hZGV2KTsKIAogCQkvKgogCQkgKiBUcnkgdG8gcHV0IHRoZSBhdWRpbyBjb2Rl
YyBpbnRvIHN1c3BlbmQgc3RhdGUKQEAgLTUyOTAsOSArNTI4NSwxNCBAQCBpbnQgYW1kZ3B1X2Rl
dmljZV9ncHVfcmVjb3Zlcl9pbXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAKIAkJaWYg
KGF1ZGlvX3N1c3BlbmRlZCkKIAkJCWFtZGdwdV9kZXZpY2VfcmVzdW1lX2Rpc3BsYXlfYXVkaW8o
dG1wX2FkZXYpOwotCQlhbWRncHVfZGV2aWNlX3VubG9ja19hZGV2KHRtcF9hZGV2KTsKKworCQlh
bWRncHVfZGV2aWNlX3Vuc2V0X21wMV9zdGF0ZSh0bXBfYWRldik7CiAJfQogCisJdG1wX2FkZXYg
PSBsaXN0X2ZpcnN0X2VudHJ5KGRldmljZV9saXN0X2hhbmRsZSwgc3RydWN0IGFtZGdwdV9kZXZp
Y2UsCisJCQkJCSAgICByZXNldF9saXN0KTsKKwlhbWRncHVfZGV2aWNlX3VubG9ja19yZXNldF9k
b21haW4odG1wX2FkZXYtPnJlc2V0X2RvbWFpbik7CisKIAlpZiAoaGl2ZSkgewogCQltdXRleF91
bmxvY2soJmhpdmUtPmhpdmVfbG9jayk7CiAJCWFtZGdwdV9wdXRfeGdtaV9oaXZlKGhpdmUpOwpA
QCAtNTU1NCw3ICs1NTU0LDggQEAgcGNpX2Vyc19yZXN1bHRfdCBhbWRncHVfcGNpX2Vycm9yX2Rl
dGVjdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwY2lfY2hhbm5lbF9zdGEKIAkJICogTG9ja2lu
ZyBhZGV2LT5yZXNldF9kb21haW4tPnNlbSB3aWxsIHByZXZlbnQgYW55IGV4dGVybmFsIGFjY2Vz
cwogCQkgKiB0byBHUFUgZHVyaW5nIFBDSSBlcnJvciByZWNvdmVyeQogCQkgKi8KLQkJYW1kZ3B1
X2RldmljZV9sb2NrX2FkZXYoYWRldiwgTlVMTCk7CisJCWFtZGdwdV9kZXZpY2VfbG9ja19yZXNl
dF9kb21haW4oYWRldi0+cmVzZXRfZG9tYWluLCBOVUxMKTsKKwkJYW1kZ3B1X2RldmljZV9zZXRf
bXAxX3N0YXRlKGFkZXYpOwogCiAJCS8qCiAJCSAqIEJsb2NrIGFueSB3b3JrIHNjaGVkdWxpbmcg
YXMgd2UgZG8gZm9yIHJlZ3VsYXIgR1BVIHJlc2V0CkBAIC01NjYxLDcgKzU2NjIsOCBAQCBwY2lf
ZXJzX3Jlc3VsdF90IGFtZGdwdV9wY2lfc2xvdF9yZXNldChzdHJ1Y3QgcGNpX2RldiAqcGRldikK
IAkJRFJNX0lORk8oIlBDSWUgZXJyb3IgcmVjb3Zlcnkgc3VjY2VlZGVkXG4iKTsKIAl9IGVsc2Ug
ewogCQlEUk1fRVJST1IoIlBDSWUgZXJyb3IgcmVjb3ZlcnkgZmFpbGVkLCBlcnI6JWQiLCByKTsK
LQkJYW1kZ3B1X2RldmljZV91bmxvY2tfYWRldihhZGV2KTsKKwkJYW1kZ3B1X2RldmljZV91bnNl
dF9tcDFfc3RhdGUoYWRldik7CisJCWFtZGdwdV9kZXZpY2VfdW5sb2NrX3Jlc2V0X2RvbWFpbihh
ZGV2LT5yZXNldF9kb21haW4pOwogCX0KIAogCXJldHVybiByID8gUENJX0VSU19SRVNVTFRfRElT
Q09OTkVDVCA6IFBDSV9FUlNfUkVTVUxUX1JFQ09WRVJFRDsKQEAgLTU2OTgsNyArNTcwMCw4IEBA
IHZvaWQgYW1kZ3B1X3BjaV9yZXN1bWUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJCWRybV9zY2hl
ZF9zdGFydCgmcmluZy0+c2NoZWQsIHRydWUpOwogCX0KIAotCWFtZGdwdV9kZXZpY2VfdW5sb2Nr
X2FkZXYoYWRldik7CisJYW1kZ3B1X2RldmljZV91bnNldF9tcDFfc3RhdGUoYWRldik7CisJYW1k
Z3B1X2RldmljZV91bmxvY2tfcmVzZXRfZG9tYWluKGFkZXYtPnJlc2V0X2RvbWFpbik7CiB9CiAK
IGJvb2wgYW1kZ3B1X2RldmljZV9jYWNoZV9wY2lfc3RhdGUoc3RydWN0IHBjaV9kZXYgKnBkZXYp
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCmluZGV4IDVhYjcyYzNi
ZmJkYS4uNjkwNjE1MzlhMjBmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmVzZXQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmVzZXQuYwpAQCAtMjMsNiArMjMsNyBAQAogCiAjaW5jbHVkZSAiYW1kZ3B1X3Jlc2V0LmgiCiAj
aW5jbHVkZSAiYWxkZWJhcmFuLmgiCisjaW5jbHVkZSAiYW1kZ3B1X3hnbWkuaCIKIAogaW50IGFt
ZGdwdV9yZXNldF9hZGRfaGFuZGxlcihzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2NvbnRyb2wgKnJlc2V0
X2N0bCwKIAkJCSAgICAgc3RydWN0IGFtZGdwdV9yZXNldF9oYW5kbGVyICpoYW5kbGVyKQpAQCAt
MTM3LDUgKzEzOCwyNCBAQCBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqYW1kZ3B1X3Jlc2V0
X2NyZWF0ZV9yZXNldF9kb21haW4oZW51bSBhbWRncHVfcmVzZXRfZAogCXJldHVybiByZXNldF9k
b21haW47CiB9CiAKK3ZvaWQgYW1kZ3B1X2RldmljZV9sb2NrX3Jlc2V0X2RvbWFpbihzdHJ1Y3Qg
YW1kZ3B1X3Jlc2V0X2RvbWFpbiAqcmVzZXRfZG9tYWluLAorCQkJCSAgICAgc3RydWN0IGFtZGdw
dV9oaXZlX2luZm8gKmhpdmUpCit7CisJYXRvbWljX3NldCgmcmVzZXRfZG9tYWluLT5pbl9ncHVf
cmVzZXQsIDEpOworCisJaWYgKGhpdmUpIHsKKwkJZG93bl93cml0ZV9uZXN0X2xvY2soJnJlc2V0
X2RvbWFpbi0+c2VtLCAmaGl2ZS0+aGl2ZV9sb2NrKTsKKwl9IGVsc2UgeworCQlkb3duX3dyaXRl
KCZyZXNldF9kb21haW4tPnNlbSk7CisJfQorfQorCisKK3ZvaWQgYW1kZ3B1X2RldmljZV91bmxv
Y2tfcmVzZXRfZG9tYWluKHN0cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluICpyZXNldF9kb21haW4p
Cit7CisJYXRvbWljX3NldCgmcmVzZXRfZG9tYWluLT5pbl9ncHVfcmVzZXQsIDApOworCXVwX3dy
aXRlKCZyZXNldF9kb21haW4tPnNlbSk7Cit9CisKIAogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yZXNldC5oCmluZGV4IGVhNmZjOThlYTkyNy4uOTJkZTNiNzk2NWExIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaApAQCAtMTE4LDUgKzExOCw5
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBhbWRncHVfcmVzZXRfZG9tYWluX3NjaGVkdWxlKHN0cnVj
dCBhbWRncHVfcmVzZXRfZG9tYWluICpkb21hCiAJcmV0dXJuIHF1ZXVlX3dvcmsoZG9tYWluLT53
cSwgd29yayk7CiB9CiAKK3ZvaWQgYW1kZ3B1X2RldmljZV9sb2NrX3Jlc2V0X2RvbWFpbihzdHJ1
Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqcmVzZXRfZG9tYWluLAorCQkJCSAgICAgc3RydWN0IGFt
ZGdwdV9oaXZlX2luZm8gKmhpdmUpOworCit2b2lkIGFtZGdwdV9kZXZpY2VfdW5sb2NrX3Jlc2V0
X2RvbWFpbihzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqcmVzZXRfZG9tYWluKTsKIAogI2Vu
ZGlmCi0tIAoyLjI1LjEKCg==

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0009-drm-amdgpu-Move-in_gpu_reset-into-reset_domain.patch"
Content-Disposition: attachment;
 filename*0="0009-drm-amdgpu-Move-in_gpu_reset-into-reset_domain.patch"
Content-Transfer-Encoding: base64

RnJvbSAyNDMyNThkY2Q4YzNmYmQ2MTc5N2YyZmEwN2M0MTgzNGM5NTVkOTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogV2VkLCAxOSBKYW4gMjAyMiAxNzoyMDowMCAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBNb3ZlIGluX2dwdV9yZXNldCBpbnRvIHJlc2V0X2RvbWFpbgpNSU1FLVZlcnNp
b246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1U
cmFuc2Zlci1FbmNvZGluZzogOGJpdAoKV2Ugc2hvdWxkIGhhdmUgYSBzaW5nbGUgaW5zdGFuY2Ug
cGVyIGVudHJpcmUgcmVzZXQgZG9tYWluLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zz
a3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClN1Z2dlc3RlZC1ieTogTGlqbyBMYXphciA8
bGlqby5sYXphckBhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpMaW5rOiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9h
bWQtZ2Z4L21zZzc0MTE2Lmh0bWwKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaCAgICAgICAgfCAgNyArKy0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgfCAxMCArKysrKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmVzZXQuYyAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmVzZXQuaCAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jICAg
ICAgfCAgNCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jICAgICAg
fCAgNCArKy0tCiA2IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggZjg3OWRkM2Q4MjU2Li4w
YjBiNDQ5ZWFkN2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0xMDQ0LDcg
KzEwNDQsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7CiAJYm9vbAkJCQlpbl9zNDsKIAlib29s
CQkJCWluX3MwaXg7CiAKLQlhdG9taWNfdCAJCQlpbl9ncHVfcmVzZXQ7CiAJZW51bSBwcF9tcDFf
c3RhdGUgICAgICAgICAgICAgICBtcDFfc3RhdGU7CiAJc3RydWN0IGFtZGdwdV9kb29yYmVsbF9p
bmRleCBkb29yYmVsbF9pbmRleDsKIApAQCAtMTQ4Miw4ICsxNDgxLDYgQEAgc3RhdGljIGlubGlu
ZSBib29sIGFtZGdwdV9pc190bXooc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgICAgICAg
cmV0dXJuIGFkZXYtPmdtYy50bXpfZW5hYmxlZDsKIH0KIAotc3RhdGljIGlubGluZSBpbnQgYW1k
Z3B1X2luX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQotewotCXJldHVybiBhdG9t
aWNfcmVhZCgmYWRldi0+aW5fZ3B1X3Jlc2V0KTsKLX0KK2ludCBhbWRncHVfaW5fcmVzZXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOworCiAjZW5kaWYKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCAwMjc5ODI0Yjg1NWQuLmE5Njg2ODk5YjljYSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzYxMCw3
ICszNjEwLDYgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAltdXRleF9pbml0KCZhZGV2LT5tbl9sb2NrKTsKIAltdXRleF9pbml0KCZhZGV2LT52
aXJ0LnZmX2Vycm9ycy5sb2NrKTsKIAloYXNoX2luaXQoYWRldi0+bW5faGFzaCk7Ci0JYXRvbWlj
X3NldCgmYWRldi0+aW5fZ3B1X3Jlc2V0LCAwKTsKIAltdXRleF9pbml0KCZhZGV2LT5wc3AubXV0
ZXgpOwogCW11dGV4X2luaXQoJmFkZXYtPm5vdGlmaWVyX2xvY2spOwogCW11dGV4X2luaXQoJmFk
ZXYtPnBtLnN0YWJsZV9wc3RhdGVfY3R4X2xvY2spOwpAQCAtNDkwMyw3ICs0OTAyLDcgQEAgaW50
IGFtZGdwdV9kb19hc2ljX3Jlc2V0KHN0cnVjdCBsaXN0X2hlYWQgKmRldmljZV9saXN0X2hhbmRs
ZSwKIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQkJCXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlKQogewotCWF0b21p
Y19zZXQoJmFkZXYtPmluX2dwdV9yZXNldCwgMSk7CisJYXRvbWljX3NldCgmYWRldi0+cmVzZXRf
ZG9tYWluLT5pbl9ncHVfcmVzZXQsIDEpOwogCiAJaWYgKGhpdmUpIHsKIAkJZG93bl93cml0ZV9u
ZXN0X2xvY2soJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtLCAmaGl2ZS0+aGl2ZV9sb2NrKTsKQEAg
LTQ5MjgsNyArNDkyNyw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJYW1kZ3B1X3ZmX2Vycm9yX3RyYW5zX2Fs
bChhZGV2KTsKIAlhZGV2LT5tcDFfc3RhdGUgPSBQUF9NUDFfU1RBVEVfTk9ORTsKLQlhdG9taWNf
c2V0KCZhZGV2LT5pbl9ncHVfcmVzZXQsIDApOworCWF0b21pY19zZXQoJmFkZXYtPnJlc2V0X2Rv
bWFpbi0+aW5fZ3B1X3Jlc2V0LCAwKTsKIAl1cF93cml0ZSgmYWRldi0+cmVzZXRfZG9tYWluLT5z
ZW0pOwogfQogCkBAIC01Nzc2LDYgKzU3NzUsMTEgQEAgdm9pZCBhbWRncHVfZGV2aWNlX2ludmFs
aWRhdGVfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWFtZGdwdV9hc2ljX2ludmFs
aWRhdGVfaGRwKGFkZXYsIHJpbmcpOwogfQogCitpbnQgYW1kZ3B1X2luX3Jlc2V0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQoreworCXJldHVybiBhdG9taWNfcmVhZCgmYWRldi0+cmVzZXRf
ZG9tYWluLT5pbl9ncHVfcmVzZXQpOworCX0KKwkKIC8qKgogICogYW1kZ3B1X2RldmljZV9oYWx0
KCkgLSBicmluZyBoYXJkd2FyZSB0byBzb21lIGtpbmQgb2YgaGFsdCBzdGF0ZQogICoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmMKaW5kZXggYzA5ODhjODA0NDU5Li41
YWI3MmMzYmZiZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yZXNldC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5j
CkBAIC0xMzEsNiArMTMxLDcgQEAgc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gKmFtZGdwdV9y
ZXNldF9jcmVhdGVfcmVzZXRfZG9tYWluKGVudW0gYW1kZ3B1X3Jlc2V0X2QKIAogCX0KIAorCWF0
b21pY19zZXQoJnJlc2V0X2RvbWFpbi0+aW5fZ3B1X3Jlc2V0LCAwKTsKIAlpbml0X3J3c2VtKCZy
ZXNldF9kb21haW4tPnNlbSk7CiAKIAlyZXR1cm4gcmVzZXRfZG9tYWluOwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaAppbmRleCA4MGY5MThlODdkNGYuLmVhNmZjOThl
YTkyNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgKQEAgLTgx
LDYgKzgxLDcgQEAgc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gewogCXN0cnVjdCB3b3JrcXVl
dWVfc3RydWN0ICp3cTsKIAllbnVtIGFtZGdwdV9yZXNldF9kb21haW5fdHlwZSB0eXBlOwogCXN0
cnVjdCByd19zZW1hcGhvcmUgc2VtOworCWF0b21pY190IGluX2dwdV9yZXNldDsKIH07CiAKIApk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKaW5kZXggNGUyM2MyOWU2NjVjLi5iODFh
Y2Y1OTg3MGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2Fp
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwpAQCAtMjU5LDcg
KzI1OSw3IEBAIHN0YXRpYyB2b2lkIHhncHVfYWlfbWFpbGJveF9mbHJfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCiAJICogb3RoZXJ3aXNlIHRoZSBtYWlsYm94IG1zZyB3aWxsIGJlIHJ1
aW5lZC9yZXNldGVkIGJ5CiAJICogdGhlIFZGIEZMUi4KIAkgKi8KLQlpZiAoYXRvbWljX2NtcHhj
aGcoJmFkZXYtPmluX2dwdV9yZXNldCwgMCwgMSkgIT0gMCkKKwlpZiAoYXRvbWljX2NtcHhjaGco
JmFkZXYtPnJlc2V0X2RvbWFpbi0+aW5fZ3B1X3Jlc2V0LCAwLCAxKSAhPSAwKQogCQlyZXR1cm47
CiAKIAlkb3duX3dyaXRlKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CkBAIC0yNzcsNyArMjc3
LDcgQEAgc3RhdGljIHZvaWQgeGdwdV9haV9tYWlsYm94X2Zscl93b3JrKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKIAl9IHdoaWxlICh0aW1lb3V0ID4gMSk7CiAKIGZscl9kb25lOgotCWF0b21p
Y19zZXQoJmFkZXYtPmluX2dwdV9yZXNldCwgMCk7CisJYXRvbWljX3NldCgmYWRldi0+cmVzZXRf
ZG9tYWluLT5pbl9ncHVfcmVzZXQsIDApOwogCXVwX3dyaXRlKCZhZGV2LT5yZXNldF9kb21haW4t
PnNlbSk7CiAKIAkvKiBUcmlnZ2VyIHJlY292ZXJ5IGZvciB3b3JsZCBzd2l0Y2ggZmFpbHVyZSBp
ZiBubyBURFIgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1
X252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jCmluZGV4IGY3MTU3
ODBmN2QyMC4uMjJjMTBiOTdlYTgxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9teGdwdV9udi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252
LmMKQEAgLTI4Myw3ICsyODMsNyBAQCBzdGF0aWMgdm9pZCB4Z3B1X252X21haWxib3hfZmxyX3dv
cmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCSAqIG90aGVyd2lzZSB0aGUgbWFpbGJveCBt
c2cgd2lsbCBiZSBydWluZWQvcmVzZXRlZCBieQogCSAqIHRoZSBWRiBGTFIuCiAJICovCi0JaWYg
KGF0b21pY19jbXB4Y2hnKCZhZGV2LT5pbl9ncHVfcmVzZXQsIDAsIDEpICE9IDApCisJaWYgKGF0
b21pY19jbXB4Y2hnKCZhZGV2LT5yZXNldF9kb21haW4tPmluX2dwdV9yZXNldCwgMCwgMSkgIT0g
MCkKIAkJcmV0dXJuOwogCiAJZG93bl93cml0ZSgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwpA
QCAtMzAxLDcgKzMwMSw3IEBAIHN0YXRpYyB2b2lkIHhncHVfbnZfbWFpbGJveF9mbHJfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJfSB3aGlsZSAodGltZW91dCA+IDEpOwogCiBmbHJf
ZG9uZToKLQlhdG9taWNfc2V0KCZhZGV2LT5pbl9ncHVfcmVzZXQsIDApOworCWF0b21pY19zZXQo
JmFkZXYtPnJlc2V0X2RvbWFpbi0+aW5fZ3B1X3Jlc2V0LCAwKTsKIAl1cF93cml0ZSgmYWRldi0+
cmVzZXRfZG9tYWluLT5zZW0pOwogCiAJLyogVHJpZ2dlciByZWNvdmVyeSBmb3Igd29ybGQgc3dp
dGNoIGZhaWx1cmUgaWYgbm8gVERSICovCi0tIAoyLjI1LjEKCg==

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0008-drm-amdgpu-Move-reset-sem-into-reset_domain.patch"
Content-Disposition: attachment;
 filename="0008-drm-amdgpu-Move-reset-sem-into-reset_domain.patch"
Content-Transfer-Encoding: base64

RnJvbSAyZDU2NzllZDZiYjc0Njc2YWQ3NWJiMGNmNjZlMjc5MzUwMGQ3Mzc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogV2VkLCAxOSBKYW4gMjAyMiAxNzowOTo1OCAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBNb3ZlIHJlc2V0IHNlbSBpbnRvIHJlc2V0X2RvbWFpbgpNSU1FLVZlcnNpb246
IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFu
c2Zlci1FbmNvZGluZzogOGJpdAoKV2Ugd2FudCBzaW5nbGUgaW5zdGFuY2Ugb2YgcmVzZXQgc2Vt
IGFjcm9zcyBhbGwKcmVzZXQgY2xpZW50cyBiZWNhdXNlIGluIGNhc2Ugb2YgWEdNSSB3ZSBzaG91
bGQgc3RvcAphY2Nlc3MgY3Jvc3MgZGV2aWNlIE1NSU8gYmVjYXVzZSBhbnkgb2YgdGhlbSBjb3Vs
ZCBiZQppbiBhIHJlc2V0IGluIHRoZSBtb21lbnQuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3Jv
ZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KTGluazogaHR0cHM6Ly93d3cuc3Bp
bmljcy5uZXQvbGlzdHMvYW1kLWdmeC9tc2c3NDExNy5odG1sCi0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgICAgIHwgIDEgLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyAgIHwgMjIgKysrKysrKystLS0tLS0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgMjUgKysrKysrKysrLS0t
LS0tLS0tLQogLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jICAgIHwg
MTggKysrKysrKy0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0
LmMgICAgIHwgIDIgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5o
ICAgICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jICAgICAg
ICB8ICA2ICsrKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICAgICAg
ICAgfCAxNCArKysrKystLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWku
YyAgICAgICAgIHwgIDQgKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5j
ICAgICAgICAgfCAgNCArLS0KIDEwIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDQ0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggNjRhM2Zm
MzFlZTdkLi5mODc5ZGQzZDgyNTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBA
IC0xMDQ2LDcgKzEwNDYsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7CiAKIAlhdG9taWNfdCAJ
CQlpbl9ncHVfcmVzZXQ7CiAJZW51bSBwcF9tcDFfc3RhdGUgICAgICAgICAgICAgICBtcDFfc3Rh
dGU7Ci0Jc3RydWN0IHJ3X3NlbWFwaG9yZSByZXNldF9zZW07CiAJc3RydWN0IGFtZGdwdV9kb29y
YmVsbF9pbmRleCBkb29yYmVsbF9pbmRleDsKIAogCXN0cnVjdCBtdXRleAkJCW5vdGlmaWVyX2xv
Y2s7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwppbmRleCA5
ZWI5YjQ0MGJkNDMuLjQyNmI2M2U0ZjFmNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGVidWdmcy5jCkBAIC0zNyw2ICszNyw4IEBACiAjaW5jbHVkZSAiYW1kZ3B1X2Z3
X2F0dGVzdGF0aW9uLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3Vtci5oIgogCisjaW5jbHVkZSAiYW1k
Z3B1X3Jlc2V0LmgiCisKICNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykKIAogLyoqCkBAIC0x
Mjg0LDcgKzEyODYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX3Rlc3RfaWJfc2hvdyhz
dHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnVudXNlZCkKIAl9CiAKIAkvKiBBdm9pZCBhY2NpZGVu
dGx5IHVucGFya2luZyB0aGUgc2NoZWQgdGhyZWFkIGR1cmluZyBHUFUgcmVzZXQgKi8KLQlyID0g
ZG93bl93cml0ZV9raWxsYWJsZSgmYWRldi0+cmVzZXRfc2VtKTsKKwlyID0gZG93bl93cml0ZV9r
aWxsYWJsZSgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCWlmIChyKQogCQlyZXR1cm4gcjsK
IApAQCAtMTMxMyw3ICsxMzE1LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGVidWdmc190ZXN0X2li
X3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp1bnVzZWQpCiAJCWt0aHJlYWRfdW5wYXJr
KHJpbmctPnNjaGVkLnRocmVhZCk7CiAJfQogCi0JdXBfd3JpdGUoJmFkZXYtPnJlc2V0X3NlbSk7
CisJdXBfd3JpdGUoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsKIAogCXBtX3J1bnRpbWVfbWFy
a19sYXN0X2J1c3koZGV2LT5kZXYpOwogCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldi0+
ZGV2KTsKQEAgLTE1NDMsNyArMTU0NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RlYnVnZnNfaWJf
cHJlZW1wdCh2b2lkICpkYXRhLCB1NjQgdmFsKQogCQlyZXR1cm4gLUVOT01FTTsKIAogCS8qIEF2
b2lkIGFjY2lkZW50bHkgdW5wYXJraW5nIHRoZSBzY2hlZCB0aHJlYWQgZHVyaW5nIEdQVSByZXNl
dCAqLwotCXIgPSBkb3duX3JlYWRfa2lsbGFibGUoJmFkZXYtPnJlc2V0X3NlbSk7CisJciA9IGRv
d25fcmVhZF9raWxsYWJsZSgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCWlmIChyKQogCQln
b3RvIHByb19lbmQ7CiAKQEAgLTE1ODYsNyArMTU4OCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rl
YnVnZnNfaWJfcHJlZW1wdCh2b2lkICpkYXRhLCB1NjQgdmFsKQogCS8qIHJlc3RhcnQgdGhlIHNj
aGVkdWxlciAqLwogCWt0aHJlYWRfdW5wYXJrKHJpbmctPnNjaGVkLnRocmVhZCk7CiAKLQl1cF9y
ZWFkKCZhZGV2LT5yZXNldF9zZW0pOworCXVwX3JlYWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2Vt
KTsKIAogCXR0bV9ib191bmxvY2tfZGVsYXllZF93b3JrcXVldWUoJmFkZXYtPm1tYW4uYmRldiwg
cmVzY2hlZCk7CiAKQEAgLTE2NDksMjMgKzE2NTEsMjMgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1
X3Jlc2V0X2R1bXBfcmVnaXN0ZXJfbGlzdF9yZWFkKHN0cnVjdCBmaWxlICpmLAogCQlyZXR1cm4g
MDsKIAogCW1lbXNldChyZWdfb2Zmc2V0LCAwLCAxMik7Ci0JcmV0ID0gZG93bl9yZWFkX2tpbGxh
YmxlKCZhZGV2LT5yZXNldF9zZW0pOworCXJldCA9IGRvd25fcmVhZF9raWxsYWJsZSgmYWRldi0+
cmVzZXRfZG9tYWluLT5zZW0pOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKIAlmb3IgKGkg
PSAwOyBpIDwgYWRldi0+bnVtX3JlZ3M7IGkrKykgewogCQlzcHJpbnRmKHJlZ19vZmZzZXQsICIw
eCV4XG4iLCBhZGV2LT5yZXNldF9kdW1wX3JlZ19saXN0W2ldKTsKLQkJdXBfcmVhZCgmYWRldi0+
cmVzZXRfc2VtKTsKKwkJdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCQlpZiAo
Y29weV90b191c2VyKGJ1ZiArIGxlbiwgcmVnX29mZnNldCwgc3RybGVuKHJlZ19vZmZzZXQpKSkK
IAkJCXJldHVybiAtRUZBVUxUOwogCiAJCWxlbiArPSBzdHJsZW4ocmVnX29mZnNldCk7Ci0JCXJl
dCA9IGRvd25fcmVhZF9raWxsYWJsZSgmYWRldi0+cmVzZXRfc2VtKTsKKwkJcmV0ID0gZG93bl9y
ZWFkX2tpbGxhYmxlKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CiAJCWlmIChyZXQpCiAJCQly
ZXR1cm4gcmV0OwogCX0KIAotCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7CisJdXBfcmVhZCgm
YWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCSpwb3MgKz0gbGVuOwogCiAJcmV0dXJuIGxlbjsK
QEAgLTE2OTcsMTMgKzE2OTksMTMgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X3Jlc2V0X2R1bXBf
cmVnaXN0ZXJfbGlzdF93cml0ZShzdHJ1Y3QgZmlsZSAqZiwKIAkJaSsrOwogCX0gd2hpbGUgKGxl
biA8IHNpemUpOwogCi0JcmV0ID0gZG93bl93cml0ZV9raWxsYWJsZSgmYWRldi0+cmVzZXRfc2Vt
KTsKKwlyZXQgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7
CiAJaWYgKHJldCkKIAkJZ290byBlcnJvcl9mcmVlOwogCiAJc3dhcChhZGV2LT5yZXNldF9kdW1w
X3JlZ19saXN0LCB0bXApOwogCWFkZXYtPm51bV9yZWdzID0gaTsKLQl1cF93cml0ZSgmYWRldi0+
cmVzZXRfc2VtKTsKKwl1cF93cml0ZSgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCXJldCA9
IHNpemU7CiAKIGVycm9yX2ZyZWU6CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKaW5kZXggNjE4MGQ0YWU1ZjhhLi4wMjc5ODI0Yjg1NWQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTQyNiwxMCArNDI2LDEwIEBAIGJv
b2wgYW1kZ3B1X2RldmljZV9za2lwX2h3X2FjY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAkgKiB0aGUgbG9jay4KIAkgKi8KIAlpZiAoaW5fdGFzaygpKSB7Ci0JCWlmIChkb3duX3Jl
YWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfc2VtKSkKLQkJCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3Nl
bSk7CisJCWlmIChkb3duX3JlYWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pKQor
CQkJdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCQllbHNlCi0JCQlsb2NrZGVw
X2Fzc2VydF9oZWxkKCZhZGV2LT5yZXNldF9zZW0pOworCQkJbG9ja2RlcF9hc3NlcnRfaGVsZCgm
YWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCX0KICNlbmRpZgogCXJldHVybiBmYWxzZTsKQEAg
LTQ1NSw5ICs0NTUsOSBAQCB1aW50MzJfdCBhbWRncHVfZGV2aWNlX3JyZWcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJaWYgKChyZWcgKiA0KSA8IGFkZXYtPnJtbWlvX3NpemUpIHsKIAkJ
aWYgKCEoYWNjX2ZsYWdzICYgQU1ER1BVX1JFR1NfTk9fS0lRKSAmJgogCQkgICAgYW1kZ3B1X3Ny
aW92X3J1bnRpbWUoYWRldikgJiYKLQkJICAgIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNl
dF9zZW0pKSB7CisJCSAgICBkb3duX3JlYWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfZG9tYWluLT5z
ZW0pKSB7CiAJCQlyZXQgPSBhbWRncHVfa2lxX3JyZWcoYWRldiwgcmVnKTsKLQkJCXVwX3JlYWQo
JmFkZXYtPnJlc2V0X3NlbSk7CisJCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7
CiAJCX0gZWxzZSB7CiAJCQlyZXQgPSByZWFkbCgoKHZvaWQgX19pb21lbSAqKWFkZXYtPnJtbWlv
KSArIChyZWcgKiA0KSk7CiAJCX0KQEAgLTU0MCw5ICs1NDAsOSBAQCB2b2lkIGFtZGdwdV9kZXZp
Y2Vfd3JlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlpZiAoKHJlZyAqIDQpIDwgYWRl
di0+cm1taW9fc2l6ZSkgewogCQlpZiAoIShhY2NfZmxhZ3MgJiBBTURHUFVfUkVHU19OT19LSVEp
ICYmCiAJCSAgICBhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSAmJgotCQkgICAgZG93bl9yZWFk
X3RyeWxvY2soJmFkZXYtPnJlc2V0X3NlbSkpIHsKKwkJICAgIGRvd25fcmVhZF90cnlsb2NrKCZh
ZGV2LT5yZXNldF9kb21haW4tPnNlbSkpIHsKIAkJCWFtZGdwdV9raXFfd3JlZyhhZGV2LCByZWcs
IHYpOwotCQkJdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKKwkJCXVwX3JlYWQoJmFkZXYtPnJl
c2V0X2RvbWFpbi0+c2VtKTsKIAkJfSBlbHNlIHsKIAkJCXdyaXRlbCh2LCAoKHZvaWQgX19pb21l
bSAqKWFkZXYtPnJtbWlvKSArIChyZWcgKiA0KSk7CiAJCX0KQEAgLTM2MTEsNyArMzYxMSw2IEBA
IGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJbXV0
ZXhfaW5pdCgmYWRldi0+dmlydC52Zl9lcnJvcnMubG9jayk7CiAJaGFzaF9pbml0KGFkZXYtPm1u
X2hhc2gpOwogCWF0b21pY19zZXQoJmFkZXYtPmluX2dwdV9yZXNldCwgMCk7Ci0JaW5pdF9yd3Nl
bSgmYWRldi0+cmVzZXRfc2VtKTsKIAltdXRleF9pbml0KCZhZGV2LT5wc3AubXV0ZXgpOwogCW11
dGV4X2luaXQoJmFkZXYtPm5vdGlmaWVyX2xvY2spOwogCW11dGV4X2luaXQoJmFkZXYtPnBtLnN0
YWJsZV9wc3RhdGVfY3R4X2xvY2spOwpAQCAtNDcyMiw3ICs0NzIxLDcgQEAgc3RhdGljIGludCBh
bWRncHVfcmVzZXRfcmVnX2R1bXBzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXVpbnQz
Ml90IHJlZ192YWx1ZTsKIAlpbnQgaTsKIAotCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmFkZXYtPnJl
c2V0X3NlbSk7CisJbG9ja2RlcF9hc3NlcnRfaGVsZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0p
OwogCWR1bXBfc3RhY2soKTsKIAogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fcmVnczsgaSsr
KSB7CkBAIC00OTA3LDkgKzQ5MDYsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2xvY2tf
YWRldihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlhdG9taWNfc2V0KCZhZGV2LT5pbl9n
cHVfcmVzZXQsIDEpOwogCiAJaWYgKGhpdmUpIHsKLQkJZG93bl93cml0ZV9uZXN0X2xvY2soJmFk
ZXYtPnJlc2V0X3NlbSwgJmhpdmUtPmhpdmVfbG9jayk7CisJCWRvd25fd3JpdGVfbmVzdF9sb2Nr
KCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSwgJmhpdmUtPmhpdmVfbG9jayk7CiAJfSBlbHNlIHsK
LQkJZG93bl93cml0ZSgmYWRldi0+cmVzZXRfc2VtKTsKKwkJZG93bl93cml0ZSgmYWRldi0+cmVz
ZXRfZG9tYWluLT5zZW0pOwogCX0KIAogCXN3aXRjaCAoYW1kZ3B1X2FzaWNfcmVzZXRfbWV0aG9k
KGFkZXYpKSB7CkBAIC00OTMwLDcgKzQ5MjksNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNl
X3VubG9ja19hZGV2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWFtZGdwdV92Zl9lcnJv
cl90cmFuc19hbGwoYWRldik7CiAJYWRldi0+bXAxX3N0YXRlID0gUFBfTVAxX1NUQVRFX05PTkU7
CiAJYXRvbWljX3NldCgmYWRldi0+aW5fZ3B1X3Jlc2V0LCAwKTsKLQl1cF93cml0ZSgmYWRldi0+
cmVzZXRfc2VtKTsKKwl1cF93cml0ZSgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogfQogCiBz
dGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX3Jlc3VtZV9kaXNwbGF5X2F1ZGlvKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQpAQCAtNTU1Myw3ICs1NTUyLDcgQEAgcGNpX2Vyc19yZXN1bHRfdCBh
bWRncHVfcGNpX2Vycm9yX2RldGVjdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwY2lfY2hhbm5l
bF9zdGEKIAkvKiBGYXRhbCBlcnJvciwgcHJlcGFyZSBmb3Igc2xvdCByZXNldCAqLwogCWNhc2Ug
cGNpX2NoYW5uZWxfaW9fZnJvemVuOgogCQkvKgotCQkgKiBMb2NraW5nIGFkZXYtPnJlc2V0X3Nl
bSB3aWxsIHByZXZlbnQgYW55IGV4dGVybmFsIGFjY2VzcworCQkgKiBMb2NraW5nIGFkZXYtPnJl
c2V0X2RvbWFpbi0+c2VtIHdpbGwgcHJldmVudCBhbnkgZXh0ZXJuYWwgYWNjZXNzCiAJCSAqIHRv
IEdQVSBkdXJpbmcgUENJIGVycm9yIHJlY292ZXJ5CiAJCSAqLwogCQlhbWRncHVfZGV2aWNlX2xv
Y2tfYWRldihhZGV2LCBOVUxMKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzX2VlcHJvbS5jCmluZGV4IDJiODQ0YTVhYWZkYi4uYTQ0ZjJlZWVkNmVmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKQEAgLTMxLDYg
KzMxLDggQEAKICNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+CiAjaW5jbHVkZSA8bGludXgvdWFj
Y2Vzcy5oPgogCisjaW5jbHVkZSAiYW1kZ3B1X3Jlc2V0LmgiCisKICNkZWZpbmUgRUVQUk9NX0ky
Q19NQUREUl9WRUdBMjAgICAgICAgICAweDAKICNkZWZpbmUgRUVQUk9NX0kyQ19NQUREUl9BUkNU
VVJVUyAgICAgICAweDQwMDAwCiAjZGVmaW5lIEVFUFJPTV9JMkNfTUFERFJfQVJDVFVSVVNfRDM0
MiAgMHgwCkBAIC0xOTMsMTIgKzE5NSwxMiBAQCBzdGF0aWMgaW50IF9fd3JpdGVfdGFibGVfaGVh
ZGVyKHN0cnVjdCBhbWRncHVfcmFzX2VlcHJvbV9jb250cm9sICpjb250cm9sKQogCV9fZW5jb2Rl
X3RhYmxlX2hlYWRlcl90b19idWYoJmNvbnRyb2wtPnRibF9oZHIsIGJ1Zik7CiAKIAkvKiBpMmMg
bWF5IGJlIHVuc3RhYmxlIGluIGdwdSByZXNldCAqLwotCWRvd25fcmVhZCgmYWRldi0+cmVzZXRf
c2VtKTsKKwlkb3duX3JlYWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsKIAlyZXMgPSBhbWRn
cHVfZWVwcm9tX3dyaXRlKGFkZXYtPnBtLnJhc19lZXByb21faTJjX2J1cywKIAkJCQkgIGNvbnRy
b2wtPmkyY19hZGRyZXNzICsKIAkJCQkgIGNvbnRyb2wtPnJhc19oZWFkZXJfb2Zmc2V0LAogCQkJ
CSAgYnVmLCBSQVNfVEFCTEVfSEVBREVSX1NJWkUpOwotCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3Nl
bSk7CisJdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCiAJaWYgKHJlcyA8IDAp
IHsKIAkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gd3JpdGUgRUVQUk9NIHRhYmxlIGhlYWRlcjolZCIs
IHJlcyk7CkBAIC0zOTAsMTMgKzM5MiwxMyBAQCBzdGF0aWMgaW50IF9fYW1kZ3B1X3Jhc19lZXBy
b21fd3JpdGUoc3RydWN0IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNvbnRyb2wsCiAJaW50
IHJlczsKIAogCS8qIGkyYyBtYXkgYmUgdW5zdGFibGUgaW4gZ3B1IHJlc2V0ICovCi0JZG93bl9y
ZWFkKCZhZGV2LT5yZXNldF9zZW0pOworCWRvd25fcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5z
ZW0pOwogCWJ1Zl9zaXplID0gbnVtICogUkFTX1RBQkxFX1JFQ09SRF9TSVpFOwogCXJlcyA9IGFt
ZGdwdV9lZXByb21fd3JpdGUoYWRldi0+cG0ucmFzX2VlcHJvbV9pMmNfYnVzLAogCQkJCSAgY29u
dHJvbC0+aTJjX2FkZHJlc3MgKwogCQkJCSAgUkFTX0lOREVYX1RPX09GRlNFVChjb250cm9sLCBm
cmkpLAogCQkJCSAgYnVmLCBidWZfc2l6ZSk7Ci0JdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsK
Kwl1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CiAJaWYgKHJlcyA8IDApIHsKIAkJ
RFJNX0VSUk9SKCJXcml0aW5nICVkIEVFUFJPTSB0YWJsZSByZWNvcmRzIGVycm9yOiVkIiwKIAkJ
CSAgbnVtLCByZXMpOwpAQCAtNTUwLDEyICs1NTIsMTIgQEAgYW1kZ3B1X3Jhc19lZXByb21fdXBk
YXRlX2hlYWRlcihzdHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCkKIAkJ
Z290byBPdXQ7CiAJfQogCi0JZG93bl9yZWFkKCZhZGV2LT5yZXNldF9zZW0pOworCWRvd25fcmVh
ZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwogCXJlcyA9IGFtZGdwdV9lZXByb21fcmVhZChh
ZGV2LT5wbS5yYXNfZWVwcm9tX2kyY19idXMsCiAJCQkJIGNvbnRyb2wtPmkyY19hZGRyZXNzICsK
IAkJCQkgY29udHJvbC0+cmFzX3JlY29yZF9vZmZzZXQsCiAJCQkJIGJ1ZiwgYnVmX3NpemUpOwot
CXVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7CisJdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWlu
LT5zZW0pOwogCWlmIChyZXMgPCAwKSB7CiAJCURSTV9FUlJPUigiRUVQUk9NIGZhaWxlZCByZWFk
aW5nIHJlY29yZHM6JWRcbiIsCiAJCQkgIHJlcyk7CkBAIC02NDUsMTMgKzY0NywxMyBAQCBzdGF0
aWMgaW50IF9fYW1kZ3B1X3Jhc19lZXByb21fcmVhZChzdHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21f
Y29udHJvbCAqY29udHJvbCwKIAlpbnQgcmVzOwogCiAJLyogaTJjIG1heSBiZSB1bnN0YWJsZSBp
biBncHUgcmVzZXQgKi8KLQlkb3duX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7CisJZG93bl9yZWFk
KCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CiAJYnVmX3NpemUgPSBudW0gKiBSQVNfVEFCTEVf
UkVDT1JEX1NJWkU7CiAJcmVzID0gYW1kZ3B1X2VlcHJvbV9yZWFkKGFkZXYtPnBtLnJhc19lZXBy
b21faTJjX2J1cywKIAkJCQkgY29udHJvbC0+aTJjX2FkZHJlc3MgKwogCQkJCSBSQVNfSU5ERVhf
VE9fT0ZGU0VUKGNvbnRyb2wsIGZyaSksCiAJCQkJIGJ1ZiwgYnVmX3NpemUpOwotCXVwX3JlYWQo
JmFkZXYtPnJlc2V0X3NlbSk7CisJdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwog
CWlmIChyZXMgPCAwKSB7CiAJCURSTV9FUlJPUigiUmVhZGluZyAlZCBFRVBST00gdGFibGUgcmVj
b3JkcyBlcnJvcjolZCIsCiAJCQkgIG51bSwgcmVzKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jlc2V0LmMKaW5kZXggOTE4NjQ5NDcwNjNmLi5jMDk4OGM4MDQ0NTkgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCkBAIC0xMzEsNiArMTMxLDgg
QEAgc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gKmFtZGdwdV9yZXNldF9jcmVhdGVfcmVzZXRf
ZG9tYWluKGVudW0gYW1kZ3B1X3Jlc2V0X2QKIAogCX0KIAorCWluaXRfcndzZW0oJnJlc2V0X2Rv
bWFpbi0+c2VtKTsKKwogCXJldHVybiByZXNldF9kb21haW47CiB9CiAKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgKaW5kZXggY2M2MjVlNDQxZmEwLi44MGY5MThlODdk
NGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oCkBAIC04MCw2
ICs4MCw3IEBAIHN0cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluIHsKIAlzdHJ1Y3Qga3JlZiByZWZj
b3VudDsKIAlzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3E7CiAJZW51bSBhbWRncHVfcmVzZXRf
ZG9tYWluX3R5cGUgdHlwZTsKKwlzdHJ1Y3Qgcndfc2VtYXBob3JlIHNlbTsKIH07CiAKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCBlN2FkZDIwMjBkNDguLjNkY2Q4
MmI0OTQ4MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKQEAgLTQ4LDYg
KzQ4LDggQEAKICNpbmNsdWRlICJhdGh1Yl92Ml8wLmgiCiAjaW5jbHVkZSAiYXRodWJfdjJfMS5o
IgogCisjaW5jbHVkZSAiYW1kZ3B1X3Jlc2V0LmgiCisKICNpZiAwCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNvYzE1X3JlZ19nb2xkZW4gZ29sZGVuX3NldHRpbmdzX25hdmkxMF9oZHBbXSA9CiB7CkBA
IC0zMjgsNyArMzMwLDcgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCiAJICovCiAJaWYgKGFkZXYt
PmdmeC5raXEucmluZy5zY2hlZC5yZWFkeSAmJgogCSAgICAoYW1kZ3B1X3NyaW92X3J1bnRpbWUo
YWRldikgfHwgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgJiYKLQkgICAgZG93bl9yZWFkX3RyeWxv
Y2soJmFkZXYtPnJlc2V0X3NlbSkpIHsKKwkgICAgZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJl
c2V0X2RvbWFpbi0+c2VtKSkgewogCQlzdHJ1Y3QgYW1kZ3B1X3ZtaHViICpodWIgPSAmYWRldi0+
dm1odWJbdm1odWJdOwogCQljb25zdCB1bnNpZ25lZCBlbmcgPSAxNzsKIAkJdTMyIGludl9yZXEg
PSBodWItPnZtaHViX2Z1bmNzLT5nZXRfaW52YWxpZGF0ZV9yZXEodm1pZCwgZmx1c2hfdHlwZSk7
CkBAIC0zMzgsNyArMzQwLDcgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCiAJCWFtZGdwdV92aXJ0
X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoYWRldiwgcmVxLCBhY2ssIGludl9yZXEsCiAJCQkJMSA8
PCB2bWlkKTsKIAotCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9zZW0pOworCQl1cF9yZWFkKCZhZGV2
LT5yZXNldF9kb21haW4tPnNlbSk7CiAJCXJldHVybjsKIAl9CiAKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCmluZGV4IDQxMmU0NGFmMTYwOC4uZGYzNWYwMjUyZWVhIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTYyLDYgKzYyLDggQEAKICNpbmNsdWRl
ICJhbWRncHVfcmFzLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3hnbWkuaCIKIAorI2luY2x1ZGUgImFt
ZGdwdV9yZXNldC5oIgorCiAvKiBhZGQgdGhlc2UgaGVyZSBzaW5jZSB3ZSBhbHJlYWR5IGluY2x1
ZGUgZGNlMTIgaGVhZGVycyBhbmQgdGhlc2UgYXJlIGZvciBEQ04gKi8KICNkZWZpbmUgbW1IVUJQ
MF9EQ1NVUkZfUFJJX1ZJRVdQT1JUX0RJTUVOU0lPTiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDA1NWQKICNkZWZpbmUgbW1IVUJQMF9E
Q1NVUkZfUFJJX1ZJRVdQT1JUX0RJTUVOU0lPTl9CQVNFX0lEWCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyCkBAIC03ODcsMTMgKzc4OSwxMyBAQCBzdGF0
aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1aW50MzJfdCB2bWlkLAogCSAqLwogCWlmIChhZGV2LT5nZngua2lxLnJpbmcuc2NoZWQucmVh
ZHkgJiYKIAkgICAgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpIHx8ICFhbWRncHVfc3Jpb3Zf
dmYoYWRldikpICYmCi0JICAgIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9zZW0pKSB7
CisJICAgIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkpIHsKIAkJ
dWludDMyX3QgcmVxID0gaHViLT52bV9pbnZfZW5nMF9yZXEgKyBodWItPmVuZ19kaXN0YW5jZSAq
IGVuZzsKIAkJdWludDMyX3QgYWNrID0gaHViLT52bV9pbnZfZW5nMF9hY2sgKyBodWItPmVuZ19k
aXN0YW5jZSAqIGVuZzsKIAogCQlhbWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KGFk
ZXYsIHJlcSwgYWNrLCBpbnZfcmVxLAogCQkJCQkJICAgMSA8PCB2bWlkKTsKLQkJdXBfcmVhZCgm
YWRldi0+cmVzZXRfc2VtKTsKKwkJdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOwog
CQlyZXR1cm47CiAJfQogCkBAIC05MDAsNyArOTAyLDcgQEAgc3RhdGljIGludCBnbWNfdjlfMF9m
bHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChhbWRn
cHVfaW5fcmVzZXQoYWRldikpCiAJCXJldHVybiAtRUlPOwogCi0JaWYgKHJpbmctPnNjaGVkLnJl
YWR5ICYmIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9zZW0pKSB7CisJaWYgKHJpbmct
PnNjaGVkLnJlYWR5ICYmIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNl
bSkpIHsKIAkJLyogVmVnYTIwK1hHTUkgY2FjaGVzIFBURXMgaW4gVEMgYW5kIFRMQi4gQWRkIGEK
IAkJICogaGVhdnktd2VpZ2h0IFRMQiBmbHVzaCAodHlwZSAyKSwgd2hpY2ggZmx1c2hlcwogCQkg
KiBib3RoLiBEdWUgdG8gYSByYWNlIGNvbmRpdGlvbiB3aXRoIGNvbmN1cnJlbnQKQEAgLTkyNyw3
ICs5MjksNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWlmIChyKSB7CiAJCQlhbWRncHVfcmluZ191bmRvKHJp
bmcpOwogCQkJc3Bpbl91bmxvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsKLQkJCXVwX3Jl
YWQoJmFkZXYtPnJlc2V0X3NlbSk7CisJCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNl
bSk7CiAJCQlyZXR1cm4gLUVUSU1FOwogCQl9CiAKQEAgLTkzNiwxMCArOTM4LDEwIEBAIHN0YXRp
YyBpbnQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAkJciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcocmluZywgc2VxLCBhZGV2LT51
c2VjX3RpbWVvdXQpOwogCQlpZiAociA8IDEpIHsKIAkJCWRldl9lcnIoYWRldi0+ZGV2LCAid2Fp
dCBmb3Iga2lxIGZlbmNlIGVycm9yOiAlbGQuXG4iLCByKTsKLQkJCXVwX3JlYWQoJmFkZXYtPnJl
c2V0X3NlbSk7CisJCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CiAJCQlyZXR1
cm4gLUVUSU1FOwogCQl9Ci0JCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7CisJCXVwX3JlYWQo
JmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsKIAkJcmV0dXJuIDA7CiAJfQogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbXhncHVfYWkuYwppbmRleCA2NzQwZWVmODRlZTEuLjRlMjNjMjllNjY1YyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jCkBAIC0yNjIsNyArMjYyLDcgQEAg
c3RhdGljIHZvaWQgeGdwdV9haV9tYWlsYm94X2Zscl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykKIAlpZiAoYXRvbWljX2NtcHhjaGcoJmFkZXYtPmluX2dwdV9yZXNldCwgMCwgMSkgIT0g
MCkKIAkJcmV0dXJuOwogCi0JZG93bl93cml0ZSgmYWRldi0+cmVzZXRfc2VtKTsKKwlkb3duX3dy
aXRlKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CiAKIAlhbWRncHVfdmlydF9maW5pX2RhdGFf
ZXhjaGFuZ2UoYWRldik7CiAKQEAgLTI3OCw3ICsyNzgsNyBAQCBzdGF0aWMgdm9pZCB4Z3B1X2Fp
X21haWxib3hfZmxyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCiBmbHJfZG9uZToK
IAlhdG9taWNfc2V0KCZhZGV2LT5pbl9ncHVfcmVzZXQsIDApOwotCXVwX3dyaXRlKCZhZGV2LT5y
ZXNldF9zZW0pOworCXVwX3dyaXRlKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7CiAKIAkvKiBU
cmlnZ2VyIHJlY292ZXJ5IGZvciB3b3JsZCBzd2l0Y2ggZmFpbHVyZSBpZiBubyBURFIgKi8KIAlp
ZiAoYW1kZ3B1X2RldmljZV9zaG91bGRfcmVjb3Zlcl9ncHUoYWRldikKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9teGdwdV9udi5jCmluZGV4IGU5NjdkNjFjNzEzNC4uZjcxNTc4MGY3ZDIwIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252LmMKQEAgLTI4Niw3ICsyODYsNyBAQCBzdGF0
aWMgdm9pZCB4Z3B1X252X21haWxib3hfZmxyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQogCWlmIChhdG9taWNfY21weGNoZygmYWRldi0+aW5fZ3B1X3Jlc2V0LCAwLCAxKSAhPSAwKQog
CQlyZXR1cm47CiAKLQlkb3duX3dyaXRlKCZhZGV2LT5yZXNldF9zZW0pOworCWRvd25fd3JpdGUo
JmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsKIAogCWFtZGdwdV92aXJ0X2ZpbmlfZGF0YV9leGNo
YW5nZShhZGV2KTsKIApAQCAtMzAyLDcgKzMwMiw3IEBAIHN0YXRpYyB2b2lkIHhncHVfbnZfbWFp
bGJveF9mbHJfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIGZscl9kb25lOgogCWF0
b21pY19zZXQoJmFkZXYtPmluX2dwdV9yZXNldCwgMCk7Ci0JdXBfd3JpdGUoJmFkZXYtPnJlc2V0
X3NlbSk7CisJdXBfd3JpdGUoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsKIAogCS8qIFRyaWdn
ZXIgcmVjb3ZlcnkgZm9yIHdvcmxkIHN3aXRjaCBmYWlsdXJlIGlmIG5vIFREUiAqLwogCWlmIChh
bWRncHVfZGV2aWNlX3Nob3VsZF9yZWNvdmVyX2dwdShhZGV2KQotLSAKMi4yNS4xCgo=

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0007-drm-amdgpu-Rework-reset-domain-to-be-refcounted.patch"
Content-Disposition: attachment;
 filename*0="0007-drm-amdgpu-Rework-reset-domain-to-be-refcounted.patch"
Content-Transfer-Encoding: base64

RnJvbSBmYjk1Y2Y5YTUxOWI3NzAzY2IxY2M1NGRiY2U2ZTBhZGM0ZjRlNmUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogRnJpLCAyMSBKYW4gMjAyMiAxNzoyMzozMiAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBSZXdvcmsgcmVzZXQgZG9tYWluIHRvIGJlIHJlZmNvdW50ZWQuCk1JTUUtVmVy
c2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50
LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpUaGUgcmVzZXQgZG9tYWluIGNvbnRhaW5zIHJlZ2lz
dGVyIGFjY2VzcyBzZW1hcGhvcgpub3cgYW5kIHNvIG5lZWRzIHRvIGJlIHByZXNlbnQgYXMgbG9u
ZyBhcyBlYWNoIGRldmljZQppbiBhIGhpdmUgbmVlZHMgaXQgYW5kIHNvIGl0IGNhbm5vdCBiZSBi
aW5kZWQgdG8gWEdNSQpoaXZlIGxpZmUgY3ljbGUuCkFkcmVzcyB0aGlzIGJ5IG1ha2luZyByZXNl
dCBkb21haW4gcmVmY291bnRlZCBhbmQgcG9pbnRlZApieSBlYWNoIG1lbWJlciBvZiB0aGUgaGl2
ZSBhbmQgdGhlIGhpdmUgaXRzZWxmLgoKdjQ6CgpGaXggY3Jhc2ggb24gYm9vdCB3aXRyaCBYR01J
IGhpdmUgYnkgYWRkaW5nIHR5cGUgdG8gcmVzZXRfZG9tYWluLgpYR01JIHdpbGwgb25seSBjcmVh
dGUgYSBuZXcgcmVzZXRfZG9tYWluIGlmIHByZXZvaXVzIHdhcyBvZiBzaW5nbGUKZGV2aWNlIHR5
cGUgbWVhbmluZyBpdCdzIGZpcnN0IGJvb3QuIE90aGVyd3NpZSBpdCB3aWxsIHRha2UgYQpyZWZv
Y3VudCB0byBleHNpdGluZyByZXNldF9kb21haW4gZnJvbSB0aGUgYW1kZ291IGRldmljZS4KCkFk
ZCBhIHdyYXBwZXIgYXJvdW5kIHJlc2V0X2RvbWFpbi0+cmVmY291bnQgZ2V0L3B1dAphbmQgYSB3
cmFwcGVyIGFyb3VuZCBzZW5kIHRvIHJlc2V0IHdxIChMaWpvKQoKU2lnbmVkLW9mZi1ieTogQW5k
cmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+CkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ckxpbms6IGh0dHBzOi8vd3d3
LnNwaW5pY3MubmV0L2xpc3RzL2FtZC1nZngvbXNnNzQxMjEuaHRtbAotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICA2ICstLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNDQgKysrKysrKysrKysrKy0tLS0tLS0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmMgIHwgNDAgKysrKysrKysr
KysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oICB8
IDM1ICsrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
eGdtaS5jICAgfCAyOSArKysrKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3hnbWkuaCAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1
X2FpLmMgICAgICB8ICA2ICsrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfbnYu
YyAgICAgIHwgIDYgKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jICAg
ICAgfCAgNiArKy0KIDkgZmlsZXMgY2hhbmdlZCwgMTQwIGluc2VydGlvbnMoKyksIDM0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggMTBmNmFhYTYyZTky
Li42NGEzZmYzMWVlN2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC04MDcs
OSArODA3LDcgQEAgc3RydWN0IGlwX2Rpc2NvdmVyeV90b3A7CiAjZGVmaW5lIEFNREdQVV9SRVNF
VF9NQUdJQ19OVU0gNjQKICNkZWZpbmUgQU1ER1BVX01BWF9ERl9QRVJGTU9OUyA0CiAjZGVmaW5l
IEFNREdQVV9QUk9EVUNUX05BTUVfTEVOIDY0Ci1zdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiB7
Ci0Jc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKndxOwotfTsKK3N0cnVjdCBhbWRncHVfcmVzZXRf
ZG9tYWluOwogCiBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7CiAJc3RydWN0IGRldmljZQkJCSpkZXY7
CkBAIC0xMTAzLDcgKzExMDEsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7CiAJdWludDMyX3Qg
ICAgICAgICAgICAgICAgICAgICAgICAqcmVzZXRfZHVtcF9yZWdfbGlzdDsKIAlpbnQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG51bV9yZWdzOwogCi0Jc3RydWN0IGFtZGdwdV9yZXNldF9k
b21haW4JcmVzZXRfZG9tYWluOworCXN0cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluCSpyZXNldF9k
b21haW47CiB9OwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNlICpkcm1fdG9f
YWRldihzdHJ1Y3QgZHJtX2RldmljZSAqZGRldikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwppbmRleCA0MzVhN2U5YzNlN2UuLjYxODBkNGFlNWY4YSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjM2NSw3ICsyMzY1
LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2luaXRfc2NoZWR1bGVycyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAogCQlyID0gZHJtX3NjaGVkX2luaXQoJnJpbmctPnNjaGVkLCAm
YW1kZ3B1X3NjaGVkX29wcywKIAkJCQkgICByaW5nLT5udW1faHdfc3VibWlzc2lvbiwgYW1kZ3B1
X2pvYl9oYW5nX2xpbWl0LAotCQkJCSAgIHRpbWVvdXQsIGFkZXYtPnJlc2V0X2RvbWFpbi53cSwg
cmluZy0+c2NoZWRfc2NvcmUsCisJCQkJICAgdGltZW91dCwgYWRldi0+cmVzZXRfZG9tYWluLT53
cSwgcmluZy0+c2NoZWRfc2NvcmUsCiAJCQkJICAgcmluZy0+bmFtZSwgYWRldi0+ZGV2KTsKIAkJ
aWYgKHIpIHsKIAkJCURSTV9FUlJPUigiRmFpbGVkIHRvIGNyZWF0ZSBzY2hlZHVsZXIgb24gcmlu
ZyAlcy5cbiIsCkBAIC0yNDg5LDI0ICsyNDg5LDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rldmlj
ZV9pcF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWlmIChyKQogCQlnb3RvIGlu
aXRfZmFpbGVkOwogCisJLyoqCisJICogSW4gY2FzZSBvZiBYR01JIGdyYWIgZXh0cmEgcmVmZXJl
bmNlIGZvciByZXNldCBkb21haW4gZm9yIHRoaXMgZGV2aWNlCisJICovCiAJaWYgKGFkZXYtPmdt
Yy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKLQkJc3RydWN0IGFtZGdwdV9oaXZlX2lu
Zm8gKmhpdmU7CisJCWlmIChhbWRncHVfeGdtaV9hZGRfZGV2aWNlKGFkZXYpID09IDApIHsKKwkJ
CXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlID0gYW1kZ3B1X2dldF94Z21pX2hpdmUoYWRl
dik7CiAKLQkJYW1kZ3B1X3hnbWlfYWRkX2RldmljZShhZGV2KTsKKwkJCWlmICghaGl2ZS0+cmVz
ZXRfZG9tYWluIHx8CisJCQkgICAgIWFtZGdwdV9yZXNldF9nZXRfcmVzZXRfZG9tYWluKGhpdmUt
PnJlc2V0X2RvbWFpbikpIHsKKwkJCQlyID0gLUVOT0VOVDsKKwkJCQlnb3RvIGluaXRfZmFpbGVk
OworCQkJfQogCi0JCWhpdmUgPSBhbWRncHVfZ2V0X3hnbWlfaGl2ZShhZGV2KTsKLQkJaWYgKCFo
aXZlIHx8ICFoaXZlLT5yZXNldF9kb21haW4ud3EpIHsKLQkJCURSTV9FUlJPUigiRmFpbGVkIHRv
IG9idGFpbiByZXNldCBkb21haW4gaW5mbyBmb3IgWEdNSSBoaXZlOiVsbHgiLCBoaXZlLT5oaXZl
X2lkKTsKLQkJCXIgPSAtRUlOVkFMOwotCQkJZ290byBpbml0X2ZhaWxlZDsKLQkJfQotCi0JCWFk
ZXYtPnJlc2V0X2RvbWFpbi53cSA9IGhpdmUtPnJlc2V0X2RvbWFpbi53cTsKLQl9IGVsc2Ugewot
CQlhZGV2LT5yZXNldF9kb21haW4ud3EgPSBhbGxvY19vcmRlcmVkX3dvcmtxdWV1ZSgiYW1kZ3B1
LXJlc2V0LWRldiIsIDApOwotCQlpZiAoIWFkZXYtPnJlc2V0X2RvbWFpbi53cSkgewotCQkJciA9
IC1FTk9NRU07Ci0JCQlnb3RvIGluaXRfZmFpbGVkOworCQkJLyogRHJvcCB0aGUgZWFybHkgdGVt
cG9yYXJ5IHJlc2V0IGRvbWFpbiB3ZSBjcmVhdGVkIGZvciBkZXZpY2UgKi8KKwkJCWFtZGdwdV9y
ZXNldF9wdXRfcmVzZXRfZG9tYWluKGFkZXYtPnJlc2V0X2RvbWFpbik7CisJCQlhZGV2LT5yZXNl
dF9kb21haW4gPSBoaXZlLT5yZXNldF9kb21haW47CiAJCX0KIAl9CiAKQEAgLTM3MDAsNiArMzY5
OCwxNSBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQlyZXR1cm4gcjsKIAl9CiAKKwkvKgorCSAqIFJlc2V0IGRvbWFpbiBuZWVkcyB0byBiZSBw
cmVzZW50IGVhcmx5LCBiZWZvcmUgWEdNSSBoaXZlIGRpc2NvdmVyZWQKKwkgKiAoaWYgYW55KSBh
bmQgaW50aXRpYWxpemVkIHRvIHVzZSByZXNldCBzZW0gYW5kIGluX2dwdSByZXNldCBmbGFnCisJ
ICogZWFybHkgb24gZHVyaW5nIGluaXQuCisJICovCisJYWRldi0+cmVzZXRfZG9tYWluID0gYW1k
Z3B1X3Jlc2V0X2NyZWF0ZV9yZXNldF9kb21haW4oU0lOR0xFX0RFVklDRSAsImFtZGdwdS1yZXNl
dC1kZXYiKTsKKwlpZiAoIWFkZXYtPnJlc2V0X2RvbWFpbikKKwkJcmV0dXJuIC1FTk9NRU07CisK
IAkvKiBlYXJseSBpbml0IGZ1bmN0aW9ucyAqLwogCXIgPSBhbWRncHVfZGV2aWNlX2lwX2Vhcmx5
X2luaXQoYWRldik7CiAJaWYgKHIpCkBAIC00MDYzLDYgKzQwNzAsOSBAQCB2b2lkIGFtZGdwdV9k
ZXZpY2VfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAoYWRldi0+bW1h
bi5kaXNjb3ZlcnlfYmluKQogCQlhbWRncHVfZGlzY292ZXJ5X2ZpbmkoYWRldik7CiAKKwlhbWRn
cHVfcmVzZXRfcHV0X3Jlc2V0X2RvbWFpbihhZGV2LT5yZXNldF9kb21haW4pOworCWFkZXYtPnJl
c2V0X2RvbWFpbiA9IE5VTEw7CisKIAlrZnJlZShhZGV2LT5wY2lfc3RhdGUpOwogCiB9CkBAIC01
MzE4LDcgKzUzMjgsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAogCUlOSVRfV09SSygmd29yay5iYXNlLCBhbWRncHVfZGV2aWNl
X3F1ZXVlX2dwdV9yZWNvdmVyX3dvcmspOwogCi0JaWYgKCFxdWV1ZV93b3JrKGFkZXYtPnJlc2V0
X2RvbWFpbi53cSwgJndvcmsuYmFzZSkpCisJaWYgKCFhbWRncHVfcmVzZXRfZG9tYWluX3NjaGVk
dWxlKGFkZXYtPnJlc2V0X2RvbWFpbiwgJndvcmsuYmFzZSkpCiAJCXJldHVybiAtRUFHQUlOOwog
CiAJZmx1c2hfd29yaygmd29yay5iYXNlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jlc2V0LmMKaW5kZXggMDJhZmQ0MTE1Njc1Li45MTg2NDk0NzA2M2YgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jCkBAIC05NiwzICs5Niw0MyBAQCBpbnQg
YW1kZ3B1X3Jlc2V0X3BlcmZvcm1fcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
cmV0dXJuIHJlc2V0X2hhbmRsZXItPnJlc3RvcmVfaHdjb250ZXh0KGFkZXYtPnJlc2V0X2NudGws
CiAJCQkJCQlyZXNldF9jb250ZXh0KTsKIH0KKworCit2b2lkIGFtZGdwdV9yZXNldF9kZXN0cm95
X3Jlc2V0X2RvbWFpbihzdHJ1Y3Qga3JlZiAqcmVmKQoreworCXN0cnVjdCBhbWRncHVfcmVzZXRf
ZG9tYWluICpyZXNldF9kb21haW4gPSBjb250YWluZXJfb2YocmVmLAorCQkJCQkJCQlzdHJ1Y3Qg
YW1kZ3B1X3Jlc2V0X2RvbWFpbiwKKwkJCQkJCQkJcmVmY291bnQpOworCWlmIChyZXNldF9kb21h
aW4tPndxKQorCQlkZXN0cm95X3dvcmtxdWV1ZShyZXNldF9kb21haW4tPndxKTsKKworCWt2ZnJl
ZShyZXNldF9kb21haW4pOworfQorCitzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqYW1kZ3B1
X3Jlc2V0X2NyZWF0ZV9yZXNldF9kb21haW4oZW51bSBhbWRncHVfcmVzZXRfZG9tYWluX3R5cGUg
dHlwZSwKKwkJCQkJCQkgICAgIGNoYXIgKndxX25hbWUpCit7CisJc3RydWN0IGFtZGdwdV9yZXNl
dF9kb21haW4gKnJlc2V0X2RvbWFpbjsKKworCXJlc2V0X2RvbWFpbiA9IGt2emFsbG9jKHNpemVv
ZihzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiksIEdGUF9LRVJORUwpOworCWlmICghcmVzZXRf
ZG9tYWluKSB7CisJCURSTV9FUlJPUigiRmFpbGVkIHRvIGFsbG9jYXRlIGFtZGdwdV9yZXNldF9k
b21haW4hIik7CisJCXJldHVybiBOVUxMOworCX0KKworCXJlc2V0X2RvbWFpbi0+dHlwZSA9IHR5
cGU7CisJa3JlZl9pbml0KCZyZXNldF9kb21haW4tPnJlZmNvdW50KTsKKworCXJlc2V0X2RvbWFp
bi0+d3EgPSBjcmVhdGVfc2luZ2xldGhyZWFkX3dvcmtxdWV1ZSh3cV9uYW1lKTsKKwlpZiAoIXJl
c2V0X2RvbWFpbi0+d3EpIHsKKwkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gYWxsb2NhdGUgd3EgZm9y
IGFtZGdwdV9yZXNldF9kb21haW4hIik7CisJCWFtZGdwdV9yZXNldF9wdXRfcmVzZXRfZG9tYWlu
KHJlc2V0X2RvbWFpbik7CisJCXJldHVybiBOVUxMOworCisJfQorCisJcmV0dXJuIHJlc2V0X2Rv
bWFpbjsKK30KKworCisKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yZXNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgK
aW5kZXggZTAwZDM4ZDkxNjBhLi5jYzYyNWU0NDFmYTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yZXNldC5oCkBAIC03MCw2ICs3MCwxOSBAQCBzdHJ1Y3QgYW1kZ3B1X3Jl
c2V0X2NvbnRyb2wgewogCXZvaWQgKCphc3luY19yZXNldCkoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKTsKIH07CiAKKworZW51bSBhbWRncHVfcmVzZXRfZG9tYWluX3R5cGUgeworCVNJTkdMRV9E
RVZJQ0UsCisJWEdNSV9ISVZFCit9OworCitzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiB7CisJ
c3RydWN0IGtyZWYgcmVmY291bnQ7CisJc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKndxOworCWVu
dW0gYW1kZ3B1X3Jlc2V0X2RvbWFpbl90eXBlIHR5cGU7Cit9OworCisKIGludCBhbWRncHVfcmVz
ZXRfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBpbnQgYW1kZ3B1X3Jlc2V0X2Zp
bmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCkBAIC04Miw0ICs5NSwyNiBAQCBpbnQg
YW1kZ3B1X3Jlc2V0X3BlcmZvcm1fcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiBp
bnQgYW1kZ3B1X3Jlc2V0X2FkZF9oYW5kbGVyKHN0cnVjdCBhbWRncHVfcmVzZXRfY29udHJvbCAq
cmVzZXRfY3RsLAogCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2hhbmRsZXIgKmhhbmRsZXIp
OwogCitzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqYW1kZ3B1X3Jlc2V0X2NyZWF0ZV9yZXNl
dF9kb21haW4oZW51bSBhbWRncHVfcmVzZXRfZG9tYWluX3R5cGUgdHlwZSwKKwkJCQkJCQkgICAg
IGNoYXIgKndxX25hbWUpOworCit2b2lkIGFtZGdwdV9yZXNldF9kZXN0cm95X3Jlc2V0X2RvbWFp
bihzdHJ1Y3Qga3JlZiAqcmVmKTsKKworc3RhdGljIGlubGluZSBib29sIGFtZGdwdV9yZXNldF9n
ZXRfcmVzZXRfZG9tYWluKHN0cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluICpkb21haW4pCit7CisJ
cmV0dXJuIGtyZWZfZ2V0X3VubGVzc196ZXJvKCZkb21haW4tPnJlZmNvdW50KSAhPSAwOworfQor
CitzdGF0aWMgaW5saW5lIHZvaWQgYW1kZ3B1X3Jlc2V0X3B1dF9yZXNldF9kb21haW4oc3RydWN0
IGFtZGdwdV9yZXNldF9kb21haW4gKmRvbWFpbikKK3sKKwlrcmVmX3B1dCgmZG9tYWluLT5yZWZj
b3VudCwgYW1kZ3B1X3Jlc2V0X2Rlc3Ryb3lfcmVzZXRfZG9tYWluKTsKK30KKworc3RhdGljIGlu
bGluZSBib29sIGFtZGdwdV9yZXNldF9kb21haW5fc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yZXNl
dF9kb21haW4gKmRvbWFpbiwKKwkJCQkJCXN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKK3sKKwly
ZXR1cm4gcXVldWVfd29yayhkb21haW4tPndxLCB3b3JrKTsKK30KKworCiAjZW5kaWYKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCmluZGV4IDY4ZTY0NWZhZGIzNS4uOTE4
MTdhMzFmM2UxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
eGdtaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMKQEAg
LTMyLDYgKzMyLDggQEAKICNpbmNsdWRlICJ3YWZsL3dhZmwyXzRfMF8wX3Ntbi5oIgogI2luY2x1
ZGUgIndhZmwvd2FmbDJfNF8wXzBfc2hfbWFzay5oIgogCisjaW5jbHVkZSAiYW1kZ3B1X3Jlc2V0
LmgiCisKICNkZWZpbmUgc21uUENTX1hHTUkyM19QQ1NfRVJST1JfU1RBVFVTICAgMHgxMWEwMTIx
MAogI2RlZmluZSBzbW5QQ1NfWEdNSTNYMTZfUENTX0VSUk9SX1NUQVRVUyAweDExYTAwMjBjCiAj
ZGVmaW5lIHNtblBDU19HT1BYMV9QQ1NfRVJST1JfU1RBVFVTICAgIDB4MTIyMDAyMTAKQEAgLTIy
Nyw2ICsyMjksOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfeGdtaV9oaXZlX3JlbGVhc2Uoc3RydWN0
IGtvYmplY3QgKmtvYmopCiAJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUgPSBjb250YWlu
ZXJfb2YoCiAJCWtvYmosIHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvLCBrb2JqKTsKIAorCWFtZGdw
dV9yZXNldF9wdXRfcmVzZXRfZG9tYWluKGhpdmUtPnJlc2V0X2RvbWFpbik7CisJaGl2ZS0+cmVz
ZXRfZG9tYWluID0gTlVMTDsKKwogCW11dGV4X2Rlc3Ryb3koJmhpdmUtPmhpdmVfbG9jayk7CiAJ
a2ZyZWUoaGl2ZSk7CiB9CkBAIC0zOTgsMTIgKzQwMywyNCBAQCBzdHJ1Y3QgYW1kZ3B1X2hpdmVf
aW5mbyAqYW1kZ3B1X2dldF94Z21pX2hpdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CWdvdG8gcHJvX2VuZDsKIAl9CiAKLQloaXZlLT5yZXNldF9kb21haW4ud3EgPSBhbGxvY19vcmRl
cmVkX3dvcmtxdWV1ZSgiYW1kZ3B1LXJlc2V0LWhpdmUiLCAwKTsKLQlpZiAoIWhpdmUtPnJlc2V0
X2RvbWFpbi53cSkgewotCQlkZXZfZXJyKGFkZXYtPmRldiwgIlhHTUk6IGZhaWxlZCBhbGxvY2F0
aW5nIHdxIGZvciByZXNldCBkb21haW4hXG4iKTsKLQkJa2ZyZWUoaGl2ZSk7Ci0JCWhpdmUgPSBO
VUxMOwotCQlnb3RvIHByb19lbmQ7CisJLyoqCisJICogQXZvaWQgcmVjcmVhdGluZyByZXNldCBk
b21haW4gd2hlbiBoaXZlIGlzIHJlY29uc3RydWN0ZWQgZm9yIHRoZSBjYXNlCisJICogb2YgcmVz
ZXQgdGhlIGRldmljZXMgaW4gdGhlIFhHTUkgaGl2ZSBkdXJpbmcgcHJvYmUgZm9yIFNSSU9WCisJ
ICogU2VlIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FtZC1nZngvbXNnNTg4MzYuaHRt
bAorCSAqLworCWlmIChhZGV2LT5yZXNldF9kb21haW4tPnR5cGUgIT0gWEdNSV9ISVZFKSB7CisJ
CWhpdmUtPnJlc2V0X2RvbWFpbiA9IGFtZGdwdV9yZXNldF9jcmVhdGVfcmVzZXRfZG9tYWluKFhH
TUlfSElWRSwgImFtZGdwdS1yZXNldC1oaXZlIik7CisJCQlpZiAoIWhpdmUtPnJlc2V0X2RvbWFp
bikgeworCQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiWEdNSTogZmFpbGVkIGluaXRpYWxpemluZyBy
ZXNldCBkb21haW4gZm9yIHhnbWkgaGl2ZVxuIik7CisJCQkJcmV0ID0gLUVOT01FTTsKKwkJCQlr
b2JqZWN0X3B1dCgmaGl2ZS0+a29iaik7CisJCQkJa2ZyZWUoaGl2ZSk7CisJCQkJaGl2ZSA9IE5V
TEw7CisJCQkJZ290byBwcm9fZW5kOworCQkJfQorCX0gZWxzZSB7CisJCWFtZGdwdV9yZXNldF9n
ZXRfcmVzZXRfZG9tYWluKGFkZXYtPnJlc2V0X2RvbWFpbik7CisJCWhpdmUtPnJlc2V0X2RvbWFp
biA9IGFkZXYtPnJlc2V0X2RvbWFpbjsKIAl9CiAKIAloaXZlLT5oaXZlX2lkID0gYWRldi0+Z21j
LnhnbWkuaGl2ZV9pZDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV94Z21pLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5oCmlu
ZGV4IDE2NDlhZTRjN2UwOS4uYjRhNzA1NTQ1NjU3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV94Z21pLmgKQEAgLTQyLDcgKzQyLDcgQEAgc3RydWN0IGFtZGdwdV9oaXZlX2lu
Zm8gewogCQlBTURHUFVfWEdNSV9QU1RBVEVfVU5LTk9XTgogCX0gcHN0YXRlOwogCi0Jc3RydWN0
IGFtZGdwdV9yZXNldF9kb21haW4gcmVzZXRfZG9tYWluOworCXN0cnVjdCBhbWRncHVfcmVzZXRf
ZG9tYWluICpyZXNldF9kb21haW47CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1X3Bjc19yYXNfZmllbGQg
ewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKaW5kZXggNTg2OWQ1MWQ4YmVlLi42
NzQwZWVmODRlZTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1
X2FpLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwpAQCAtMzIs
NiArMzIsOCBAQAogI2luY2x1ZGUgInNvYzE1X2NvbW1vbi5oIgogI2luY2x1ZGUgIm14Z3B1X2Fp
LmgiCiAKKyNpbmNsdWRlICJhbWRncHVfcmVzZXQuaCIKKwogc3RhdGljIHZvaWQgeGdwdV9haV9t
YWlsYm94X3NlbmRfYWNrKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCVdSRUc4KEFJ
X01BSUJPWF9DT05UUk9MX1JDVl9PRkZTRVRfQllURSwgMik7CkBAIC0zMDgsOCArMzEwLDggQEAg
c3RhdGljIGludCB4Z3B1X2FpX21haWxib3hfcmN2X2lycShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAlzd2l0Y2ggKGV2ZW50KSB7CiAJCWNhc2UgSURIX0ZMUl9OT1RJRklDQVRJT046CiAJ
CWlmIChhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSAmJiAhYW1kZ3B1X2luX3Jlc2V0KGFkZXYp
KQotCQkJV0FSTl9PTkNFKCFxdWV1ZV93b3JrKGFkZXYtPnJlc2V0X2RvbWFpbi53cSwKLQkJCQkJ
ICAgICAgJmFkZXYtPnZpcnQuZmxyX3dvcmspLAorCQkJV0FSTl9PTkNFKCFhbWRncHVfcmVzZXRf
ZG9tYWluX3NjaGVkdWxlKGFkZXYtPnJlc2V0X2RvbWFpbiwKKwkJCQkJCQkJJmFkZXYtPnZpcnQu
ZmxyX3dvcmspLAogCQkJCSAgIkZhaWxlZCB0byBxdWV1ZSB3b3JrISBhdCAlcyIsCiAJCQkJICBf
X2Z1bmNfXyk7CiAJCWJyZWFrOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbXhncHVfbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252LmMKaW5k
ZXggNTcyOGE2NDAxZDczLi5lOTY3ZDYxYzcxMzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L214Z3B1X252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bXhncHVfbnYuYwpAQCAtMzEsNiArMzEsOCBAQAogI2luY2x1ZGUgInNvYzE1X2NvbW1vbi5oIgog
I2luY2x1ZGUgIm14Z3B1X252LmgiCiAKKyNpbmNsdWRlICJhbWRncHVfcmVzZXQuaCIKKwogc3Rh
dGljIHZvaWQgeGdwdV9udl9tYWlsYm94X3NlbmRfYWNrKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogewogCVdSRUc4KE5WX01BSUJPWF9DT05UUk9MX1JDVl9PRkZTRVRfQllURSwgMik7CkBA
IC0zMzgsOCArMzQwLDggQEAgc3RhdGljIGludCB4Z3B1X252X21haWxib3hfcmN2X2lycShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlzd2l0Y2ggKGV2ZW50KSB7CiAJY2FzZSBJREhfRkxS
X05PVElGSUNBVElPTjoKIAkJaWYgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpICYmICFhbWRn
cHVfaW5fcmVzZXQoYWRldikpCi0JCQlXQVJOX09OQ0UoIXF1ZXVlX3dvcmsoYWRldi0+cmVzZXRf
ZG9tYWluLndxLAotCQkJCQkgICAgICAmYWRldi0+dmlydC5mbHJfd29yayksCisJCQlXQVJOX09O
Q0UoIWFtZGdwdV9yZXNldF9kb21haW5fc2NoZWR1bGUoYWRldi0+cmVzZXRfZG9tYWluLAorCQkJ
CSAgICZhZGV2LT52aXJ0LmZscl93b3JrKSwKIAkJCQkgICJGYWlsZWQgdG8gcXVldWUgd29yayEg
YXQgJXMiLAogCQkJCSAgX19mdW5jX18pOwogCQlicmVhazsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV92aS5jCmluZGV4IDFmNGNkYTA0NDdmMS4uN2I2M2QzMGI5Yjc5IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L214Z3B1X3ZpLmMKQEAgLTQyLDYgKzQyLDggQEAKICNpbmNsdWRlICJz
bXUvc211XzdfMV8zX2QuaCIKICNpbmNsdWRlICJteGdwdV92aS5oIgogCisjaW5jbHVkZSAiYW1k
Z3B1X3Jlc2V0LmgiCisKIC8qIFZJIGdvbGRlbiBzZXR0aW5nICovCiBzdGF0aWMgY29uc3QgdTMy
IHhncHVfZmlqaV9tZ2NnX2NnY2dfaW5pdFtdID0gewogCW1tUkxDX0NHVFRfTUdDR19PVkVSUklE
RSwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZiwKQEAgLTU1MSw4ICs1NTMsOCBAQCBzdGF0aWMgaW50
IHhncHVfdmlfbWFpbGJveF9yY3ZfaXJxKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiAJ
CS8qIG9ubHkgaGFuZGxlIEZMUl9OT1RJRlkgbm93ICovCiAJCWlmICghciAmJiAhYW1kZ3B1X2lu
X3Jlc2V0KGFkZXYpKQotCQkJV0FSTl9PTkNFKCFxdWV1ZV93b3JrKGFkZXYtPnJlc2V0X2RvbWFp
bi53cSwKLQkJCQkJICAgICAgJmFkZXYtPnZpcnQuZmxyX3dvcmspLAorCQkJV0FSTl9PTkNFKCFh
bWRncHVfcmVzZXRfZG9tYWluX3NjaGVkdWxlKGFkZXYtPnJlc2V0X2RvbWFpbiwKKwkJCQkJCQkJ
JmFkZXYtPnZpcnQuZmxyX3dvcmspLAogCQkJCSAgIkZhaWxlZCB0byBxdWV1ZSB3b3JrISBhdCAl
cyIsCiAJCQkJICBfX2Z1bmNfXyk7CiAJfQotLSAKMi4yNS4xCgo=

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0006-drm-amdgpu-Drop-concurrent-GPU-reset-protection-for-.patch"
Content-Disposition: attachment;
 filename*0="0006-drm-amdgpu-Drop-concurrent-GPU-reset-protection-for-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkYjhiNjE0YTM0ZWZhOGM1ZGY0N2ViNDAyZmUyMTQxZjQ1ZTQ5NDE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogVGh1LCAxNiBEZWMgMjAyMSAxNDoyNDo0MyAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBEcm9wIGNvbmN1cnJlbnQgR1BVIHJlc2V0IHByb3RlY3Rpb24gZm9yIGRldmlj
ZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRG
LTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKU2luY2Ugbm93IGFsbCBHUFUgcmVz
ZXRzIGFyZSBzZXJpYWx6aWVkIHRoZXJlIGlzIG5vIG5lZWQgZm9yIHRoaXMuCgpUaGlzIHBhdGNo
IGFsc28gcmV2ZXJ0cyAnZHJtL2FtZGdwdTogcmFjZSBpc3N1ZSB3aGVuIGpvYnMgb24gMiByaW5n
IHRpbWVvdXQnCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6
b3Zza3lAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KTGluazogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYW1kLWdm
eC9tc2c3NDExOS5odG1sCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIHwgODkgKystLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgODIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCmluZGV4IDIxZDY0NmUxMGQ4OS4uNDM1YTdlOWMzZTdlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC00ODkxLDExICs0ODkx
LDEwIEBAIGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2Vf
bGlzdF9oYW5kbGUsCiAJcmV0dXJuIHI7CiB9CiAKLXN0YXRpYyBib29sIGFtZGdwdV9kZXZpY2Vf
bG9ja19hZGV2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorc3RhdGljIHZvaWQgYW1kZ3B1
X2RldmljZV9sb2NrX2FkZXYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJc3RydWN0
IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUpCiB7Ci0JaWYgKGF0b21pY19jbXB4Y2hnKCZhZGV2LT5p
bl9ncHVfcmVzZXQsIDAsIDEpICE9IDApCi0JCXJldHVybiBmYWxzZTsKKwlhdG9taWNfc2V0KCZh
ZGV2LT5pbl9ncHVfcmVzZXQsIDEpOwogCiAJaWYgKGhpdmUpIHsKIAkJZG93bl93cml0ZV9uZXN0
X2xvY2soJmFkZXYtPnJlc2V0X3NlbSwgJmhpdmUtPmhpdmVfbG9jayk7CkBAIC00OTE0LDggKzQ5
MTMsNiBAQCBzdGF0aWMgYm9vbCBhbWRncHVfZGV2aWNlX2xvY2tfYWRldihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAkJYWRldi0+bXAxX3N0YXRlID0gUFBfTVAxX1NUQVRFX05PTkU7CiAJ
CWJyZWFrOwogCX0KLQotCXJldHVybiB0cnVlOwogfQogCiBzdGF0aWMgdm9pZCBhbWRncHVfZGV2
aWNlX3VubG9ja19hZGV2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQpAQCAtNDkyNiw0NiAr
NDkyMyw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJdXBfd3JpdGUoJmFkZXYtPnJlc2V0X3NlbSk7CiB9CiAKLS8q
Ci0gKiB0byBsb2NrdXAgYSBsaXN0IG9mIGFtZGdwdSBkZXZpY2VzIGluIGEgaGl2ZSBzYWZlbHks
IGlmIG5vdCBhIGhpdmUKLSAqIHdpdGggbXVsdGlwbGUgbm9kZXMsIGl0IHdpbGwgYmUgc2ltaWxh
ciBhcyBhbWRncHVfZGV2aWNlX2xvY2tfYWRldi4KLSAqCi0gKiB1bmxvY2sgd29uJ3QgcmVxdWly
ZSByb2xsIGJhY2suCi0gKi8KLXN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9sb2NrX2hpdmVfYWRl
dihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhp
dmUpCi17Ci0Jc3RydWN0IGFtZGdwdV9kZXZpY2UgKnRtcF9hZGV2ID0gTlVMTDsKLQotCWlmICgh
YW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9k
ZXMgPiAxKSkgewotCQlpZiAoIWhpdmUpIHsKLQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiSGl2ZSBp
cyBOVUxMIHdoaWxlIGRldmljZSBoYXMgbXVsdGlwbGUgeGdtaSBub2RlcyIpOwotCQkJcmV0dXJu
IC1FTk9ERVY7Ci0JCX0KLQkJbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgJmhpdmUtPmRl
dmljZV9saXN0LCBnbWMueGdtaS5oZWFkKSB7Ci0JCQlpZiAoIWFtZGdwdV9kZXZpY2VfbG9ja19h
ZGV2KHRtcF9hZGV2LCBoaXZlKSkKLQkJCQlnb3RvIHJvbGxfYmFjazsKLQkJfQotCX0gZWxzZSBp
ZiAoIWFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KGFkZXYsIGhpdmUpKQotCQlyZXR1cm4gLUVBR0FJ
TjsKLQotCXJldHVybiAwOwotcm9sbF9iYWNrOgotCWlmICghbGlzdF9pc19maXJzdCgmdG1wX2Fk
ZXYtPmdtYy54Z21pLmhlYWQsICZoaXZlLT5kZXZpY2VfbGlzdCkpIHsKLQkJLyoKLQkJICogaWYg
dGhlIGxvY2t1cCBpdGVyYXRpb24gYnJlYWsgaW4gdGhlIG1pZGRsZSBvZiBhIGhpdmUsCi0JCSAq
IGl0IG1heSBtZWFucyB0aGVyZSBtYXkgaGFzIGEgcmFjZSBpc3N1ZSwKLQkJICogb3IgYSBoaXZl
IGRldmljZSBsb2NrZWQgdXAgaW5kZXBlbmRlbnRseS4KLQkJICogd2UgbWF5IGJlIGluIHRyb3Vi
bGUgYW5kIG1heSBub3QsIHNvIHdpbGwgdHJ5IHRvIHJvbGwgYmFjawotCQkgKiB0aGUgbG9jayBh
bmQgZ2l2ZSBvdXQgYSB3YXJubmluZy4KLQkJICovCi0JCWRldl93YXJuKHRtcF9hZGV2LT5kZXYs
ICJIaXZlIGxvY2sgaXRlcmF0aW9uIGJyb2tlIGluIHRoZSBtaWRkbGUuIFJvbGxpbmcgYmFjayB0
byB1bmxvY2siKTsKLQkJbGlzdF9mb3JfZWFjaF9lbnRyeV9jb250aW51ZV9yZXZlcnNlKHRtcF9h
ZGV2LCAmaGl2ZS0+ZGV2aWNlX2xpc3QsIGdtYy54Z21pLmhlYWQpIHsKLQkJCWFtZGdwdV9kZXZp
Y2VfdW5sb2NrX2FkZXYodG1wX2FkZXYpOwotCQl9Ci0JfQotCXJldHVybiAtRUFHQUlOOwotfQot
CiBzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX3Jlc3VtZV9kaXNwbGF5X2F1ZGlvKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogewogCXN0cnVjdCBwY2lfZGV2ICpwID0gTlVMTDsKQEAgLTUx
NTIsMjIgKzUxMDksNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlcl9pbXAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJcmVzZXRfY29udGV4dC5oaXZlID0gaGl2ZTsKIAljbGVh
cl9iaXQoQU1ER1BVX05FRURfRlVMTF9SRVNFVCwgJnJlc2V0X2NvbnRleHQuZmxhZ3MpOwogCi0J
LyoKLQkgKiBsb2NrIHRoZSBkZXZpY2UgYmVmb3JlIHdlIHRyeSB0byBvcGVyYXRlIHRoZSBsaW5r
ZWQgbGlzdAotCSAqIGlmIGRpZG4ndCBnZXQgdGhlIGRldmljZSBsb2NrLCBkb24ndCB0b3VjaCB0
aGUgbGlua2VkIGxpc3Qgc2luY2UKLQkgKiBvdGhlcnMgbWF5IGl0ZXJhdGluZyBpdC4KLQkgKi8K
LQlyID0gYW1kZ3B1X2RldmljZV9sb2NrX2hpdmVfYWRldihhZGV2LCBoaXZlKTsKLQlpZiAocikg
ewotCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJCYWlsaW5nIG9uIFREUiBmb3Igc19qb2I6JWxseCwg
YXMgYW5vdGhlciBhbHJlYWR5IGluIHByb2dyZXNzIiwKLQkJCQkJam9iID8gam9iLT5iYXNlLmlk
IDogLTEpOwotCi0JCS8qIGV2ZW4gd2Ugc2tpcHBlZCB0aGlzIHJlc2V0LCBzdGlsbCBuZWVkIHRv
IHNldCB0aGUgam9iIHRvIGd1aWx0eSAqLwotCQlpZiAoam9iICYmIGpvYi0+dm0pCi0JCQlkcm1f
c2NoZWRfaW5jcmVhc2Vfa2FybWEoJmpvYi0+YmFzZSk7Ci0JCWdvdG8gc2tpcF9yZWNvdmVyeTsK
LQl9Ci0KIAkvKgogCSAqIEJ1aWxkIGxpc3Qgb2YgZGV2aWNlcyB0byByZXNldC4KIAkgKiBJbiBj
YXNlIHdlIGFyZSBpbiBYR01JIGhpdmUgbW9kZSwgcmVzb3J0IHRoZSBkZXZpY2UgbGlzdApAQCAt
NTE4Nyw2ICs1MTI4LDkgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXJfaW1wKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCiAJLyogYmxvY2sgYWxsIHNjaGVkdWxlcnMgYW5kIHJl
c2V0IGdpdmVuIGpvYidzIHJpbmcgKi8KIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBk
ZXZpY2VfbGlzdF9oYW5kbGUsIHJlc2V0X2xpc3QpIHsKKworCQlhbWRncHVfZGV2aWNlX2xvY2tf
YWRldih0bXBfYWRldiwgaGl2ZSk7CisKIAkJLyoKIAkJICogVHJ5IHRvIHB1dCB0aGUgYXVkaW8g
Y29kZWMgaW50byBzdXNwZW5kIHN0YXRlCiAJCSAqIGJlZm9yZSBncHUgcmVzZXQgc3RhcnRlZC4K
QEAgLTUzNDEsMTMgKzUyODUsMTIgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXJfaW1w
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlhbWRncHVfZGV2aWNlX3VubG9ja19hZGV2
KHRtcF9hZGV2KTsKIAl9CiAKLXNraXBfcmVjb3Zlcnk6CiAJaWYgKGhpdmUpIHsKIAkJbXV0ZXhf
dW5sb2NrKCZoaXZlLT5oaXZlX2xvY2spOwogCQlhbWRncHVfcHV0X3hnbWlfaGl2ZShoaXZlKTsK
IAl9CiAKLQlpZiAociAmJiByICE9IC1FQUdBSU4pCisJaWYgKHIpCiAJCWRldl9pbmZvKGFkZXYt
PmRldiwgIkdQVSByZXNldCBlbmQgd2l0aCByZXQgPSAlZFxuIiwgcik7CiAJcmV0dXJuIHI7CiB9
CkBAIC01NTcwLDIwICs1NTEzLDYgQEAgaW50IGFtZGdwdV9kZXZpY2VfYmFjb19leGl0KHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyB2b2lkIGFtZGdwdV9j
YW5jZWxfYWxsX3RkcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLXsKLQlpbnQgaTsKLQot
CWZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kpIHsKLQkJc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07Ci0KLQkJaWYgKCFyaW5nIHx8ICFyaW5nLT5z
Y2hlZC50aHJlYWQpCi0JCQljb250aW51ZTsKLQotCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
JnJpbmctPnNjaGVkLndvcmtfdGRyKTsKLQl9Ci19Ci0KIC8qKgogICogYW1kZ3B1X3BjaV9lcnJv
cl9kZXRlY3RlZCAtIENhbGxlZCB3aGVuIGEgUENJIGVycm9yIGlzIGRldGVjdGVkLgogICogQHBk
ZXY6IFBDSSBkZXZpY2Ugc3RydWN0CkBAIC01NjE0LDE0ICs1NTQzLDEwIEBAIHBjaV9lcnNfcmVz
dWx0X3QgYW1kZ3B1X3BjaV9lcnJvcl9kZXRlY3RlZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgcGNp
X2NoYW5uZWxfc3RhCiAJLyogRmF0YWwgZXJyb3IsIHByZXBhcmUgZm9yIHNsb3QgcmVzZXQgKi8K
IAljYXNlIHBjaV9jaGFubmVsX2lvX2Zyb3plbjoKIAkJLyoKLQkJICogQ2FuY2VsIGFuZCB3YWl0
IGZvciBhbGwgVERScyBpbiBwcm9ncmVzcyBpZiBmYWlsaW5nIHRvCi0JCSAqIHNldCAgYWRldi0+
aW5fZ3B1X3Jlc2V0IGluIGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2Ci0JCSAqCiAJCSAqIExvY2tp
bmcgYWRldi0+cmVzZXRfc2VtIHdpbGwgcHJldmVudCBhbnkgZXh0ZXJuYWwgYWNjZXNzCiAJCSAq
IHRvIEdQVSBkdXJpbmcgUENJIGVycm9yIHJlY292ZXJ5CiAJCSAqLwotCQl3aGlsZSAoIWFtZGdw
dV9kZXZpY2VfbG9ja19hZGV2KGFkZXYsIE5VTEwpKQotCQkJYW1kZ3B1X2NhbmNlbF9hbGxfdGRy
KGFkZXYpOworCQlhbWRncHVfZGV2aWNlX2xvY2tfYWRldihhZGV2LCBOVUxMKTsKIAogCQkvKgog
CQkgKiBCbG9jayBhbnkgd29yayBzY2hlZHVsaW5nIGFzIHdlIGRvIGZvciByZWd1bGFyIEdQVSBy
ZXNldAotLSAKMi4yNS4xCgo=

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-drm-amdgpu-Drop-hive-in_reset.patch"
Content-Disposition: attachment;
 filename="0005-drm-amdgpu-Drop-hive-in_reset.patch"
Content-Transfer-Encoding: base64

RnJvbSAyMmY5MDVkYzc2ZWUyMjU1NDJiN2QyNjFiY2Y2ZmY3YjcyNGQ0MGU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogV2VkLCAxNSBEZWMgMjAyMSAxNjo1NToyNSAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBEcm9wIGhpdmUtPmluX3Jlc2V0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5n
OiA4Yml0CgpTaW5jZSB3ZSBzZXJpYWxpemUgYWxsIHJlc2V0cyBubyBuZWVkIHRvIHByb3RlY3Qg
ZnJvbSBjb25jdXJyZW50CnJlc2V0cy4KClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5
IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpMaW5rOiBodHRwczovL3d3dy5zcGluaWNzLm5l
dC9saXN0cy9hbWQtZ2Z4L21zZzc0MTE1Lmh0bWwKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxOSArLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jICAgfCAgMSAtCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfeGdtaS5oICAgfCAgMSAtCiAzIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAyMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKaW5kZXggYjMyZDQwYTg3MThlLi4yMWQ2NDZlMTBkODkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTUxNDEsMjYgKzUxNDEs
MTAgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXJfaW1wKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCWRldl9pbmZvKGFkZXYtPmRldiwgIkdQVSAlcyBiZWdpbiFcbiIsCiAJCW5l
ZWRfZW1lcmdlbmN5X3Jlc3RhcnQgPyAiam9icyBzdG9wIjoicmVzZXQiKTsKIAotCS8qCi0JICog
SGVyZSB3ZSB0cnlsb2NrIHRvIGF2b2lkIGNoYWluIG9mIHJlc2V0cyBleGVjdXRpbmcgZnJvbQot
CSAqIGVpdGhlciB0cmlnZ2VyIGJ5IGpvYnMgb24gZGlmZmVyZW50IGFkZXZzIGluIFhHTUkgaGl2
ZSBvciBqb2JzIG9uCi0JICogZGlmZmVyZW50IHNjaGVkdWxlcnMgZm9yIHNhbWUgZGV2aWNlIHdo
aWxlIHRoaXMgVE8gaGFuZGxlciBpcyBydW5uaW5nLgotCSAqIFdlIGFsd2F5cyByZXNldCBhbGwg
c2NoZWR1bGVycyBmb3IgZGV2aWNlIGFuZCBhbGwgZGV2aWNlcyBmb3IgWEdNSQotCSAqIGhpdmUg
c28gdGhhdCBzaG91bGQgdGFrZSBjYXJlIG9mIHRoZW0gdG9vLgotCSAqLwogCWlmICghYW1kZ3B1
X3NyaW92X3ZmKGFkZXYpKQogCQloaXZlID0gYW1kZ3B1X2dldF94Z21pX2hpdmUoYWRldik7Ci0J
aWYgKGhpdmUpIHsKLQkJaWYgKGF0b21pY19jbXB4Y2hnKCZoaXZlLT5pbl9yZXNldCwgMCwgMSkg
IT0gMCkgewotCQkJRFJNX0lORk8oIkJhaWxpbmcgb24gVERSIGZvciBzX2pvYjolbGx4LCBoaXZl
OiAlbGx4IGFzIGFub3RoZXIgYWxyZWFkeSBpbiBwcm9ncmVzcyIsCi0JCQkJam9iID8gam9iLT5i
YXNlLmlkIDogLTEsIGhpdmUtPmhpdmVfaWQpOwotCQkJYW1kZ3B1X3B1dF94Z21pX2hpdmUoaGl2
ZSk7Ci0JCQlpZiAoam9iICYmIGpvYi0+dm0pCi0JCQkJZHJtX3NjaGVkX2luY3JlYXNlX2thcm1h
KCZqb2ItPmJhc2UpOwotCQkJcmV0dXJuIDA7Ci0JCX0KKwlpZiAoaGl2ZSkKIAkJbXV0ZXhfbG9j
aygmaGl2ZS0+aGl2ZV9sb2NrKTsKLQl9CiAKIAlyZXNldF9jb250ZXh0Lm1ldGhvZCA9IEFNRF9S
RVNFVF9NRVRIT0RfTk9ORTsKIAlyZXNldF9jb250ZXh0LnJlc2V0X3JlcV9kZXYgPSBhZGV2OwpA
QCAtNTM1OSw3ICs1MzQzLDYgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXJfaW1wKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiBza2lwX3JlY292ZXJ5OgogCWlmIChoaXZlKSB7
Ci0JCWF0b21pY19zZXQoJmhpdmUtPmluX3Jlc2V0LCAwKTsKIAkJbXV0ZXhfdW5sb2NrKCZoaXZl
LT5oaXZlX2xvY2spOwogCQlhbWRncHVfcHV0X3hnbWlfaGl2ZShoaXZlKTsKIAl9CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYwppbmRleCA1MzY3Y2U1NzJiMmQuLjY4ZTY0
NWZhZGIzNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hn
bWkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCkBAIC00
MTAsNyArNDEwLDYgQEAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmFtZGdwdV9nZXRfeGdtaV9o
aXZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCUlOSVRfTElTVF9IRUFEKCZoaXZlLT5k
ZXZpY2VfbGlzdCk7CiAJSU5JVF9MSVNUX0hFQUQoJmhpdmUtPm5vZGUpOwogCW11dGV4X2luaXQo
JmhpdmUtPmhpdmVfbG9jayk7Ci0JYXRvbWljX3NldCgmaGl2ZS0+aW5fcmVzZXQsIDApOwogCWF0
b21pY19zZXQoJmhpdmUtPm51bWJlcl9kZXZpY2VzLCAwKTsKIAl0YXNrX2JhcnJpZXJfaW5pdCgm
aGl2ZS0+dGIpOwogCWhpdmUtPnBzdGF0ZSA9IEFNREdQVV9YR01JX1BTVEFURV9VTktOT1dOOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmgKaW5kZXggMmE4OWQ4MjBhY2Vh
Li4xNjQ5YWU0YzdlMDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV94Z21pLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWku
aApAQCAtMzMsNyArMzMsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyB7CiAJc3RydWN0IGxp
c3RfaGVhZCBub2RlOwogCWF0b21pY190IG51bWJlcl9kZXZpY2VzOwogCXN0cnVjdCBtdXRleCBo
aXZlX2xvY2s7Ci0JYXRvbWljX3QgaW5fcmVzZXQ7CiAJaW50IGhpX3JlcV9jb3VudDsKIAlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqaGlfcmVxX2dwdTsKIAlzdHJ1Y3QgdGFza19iYXJyaWVyIHRiOwot
LSAKMi4yNS4xCgo=

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-drm-amd-virt-For-SRIOV-send-GPU-reset-directly-to-TD.patch"
Content-Disposition: attachment;
 filename*0="0004-drm-amd-virt-For-SRIOV-send-GPU-reset-directly-to-TD.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyYmM3OTNkN2RlNjIzOTQ0ZWZmNGYyMmJmNjhkN2ZhNWNiMzlkN2NjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogTW9uLCAyMCBEZWMgMjAyMSAxNzoyNzozNyAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kL3ZpcnQ6IEZvciBTUklPViBzZW5kIEdQVSByZXNldCBkaXJlY3RseSB0byBURFIgcXVl
dWUuCgpObyBuZWVkIHRvIHRvIHRyaWdnZXIgYW5vdGhlciB3b3JrIHF1ZXVlIGluc2lkZSB0aGUg
d29yayBxdWV1ZS4KCnYzOgoKUHJvYmxlbToKRXh0cmEgcmVzZXQgY2F1c2VkIGJ5IGhvc3Qgc2lk
ZSBGTFIgbm90aWZpY2F0aW9uCmZvbGxvd2luZyBndWVzdCBzaWRlIHRyaWdnZXJlZCByZXNldC4K
Rml4OiBQcmV2ZW4gcWV1aW5nIGZscl93b3JrIGZyb20gbWFpbGJveCBpcnEgaWYgZ3Vlc3QKYWxy
ZWFkeSBleGVjdXRpbmcgYSByZXNldC4KClN1Z2dlc3RlZC1ieTogTGl1IFNoYW95dW4gPFNoYW95
dW4uTGl1QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXku
Z3JvZHpvdnNreUBhbWQuY29tPgpSZXZpZXdlZC1ieTogTGl1IFNoYW95dW4gPFNoYW95dW4uTGl1
QGFtZC5jb20+Ckxpbms6IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FtZC1nZngvbXNn
NzQxMTQuaHRtbAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMgfCA5
ICsrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfbnYuYyB8IDkgKysr
KysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jIHwgOSArKysrKyst
LS0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwppbmRleCA1NmRhNWFiODI5ODcuLjU4Njlk
NTFkOGJlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWku
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jCkBAIC0yODIsNyAr
MjgyLDcgQEAgc3RhdGljIHZvaWQgeGdwdV9haV9tYWlsYm94X2Zscl93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKIAlpZiAoYW1kZ3B1X2RldmljZV9zaG91bGRfcmVjb3Zlcl9ncHUoYWRl
dikKIAkJJiYgKCFhbWRncHVfZGV2aWNlX2hhc19qb2JfcnVubmluZyhhZGV2KSB8fAogCQlhZGV2
LT5zZG1hX3RpbWVvdXQgPT0gTUFYX1NDSEVEVUxFX1RJTUVPVVQpKQotCQlhbWRncHVfZGV2aWNl
X2dwdV9yZWNvdmVyKGFkZXYsIE5VTEwpOworCQlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyX2lt
cChhZGV2LCBOVUxMKTsKIH0KIAogc3RhdGljIGludCB4Z3B1X2FpX3NldF9tYWlsYm94X3Jjdl9p
cnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCkBAIC0zMDcsOCArMzA3LDExIEBAIHN0YXRp
YyBpbnQgeGdwdV9haV9tYWlsYm94X3Jjdl9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
CiAKIAlzd2l0Y2ggKGV2ZW50KSB7CiAJCWNhc2UgSURIX0ZMUl9OT1RJRklDQVRJT046Ci0JCWlm
IChhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSkKLQkJCXNjaGVkdWxlX3dvcmsoJmFkZXYtPnZp
cnQuZmxyX3dvcmspOworCQlpZiAoYW1kZ3B1X3NyaW92X3J1bnRpbWUoYWRldikgJiYgIWFtZGdw
dV9pbl9yZXNldChhZGV2KSkKKwkJCVdBUk5fT05DRSghcXVldWVfd29yayhhZGV2LT5yZXNldF9k
b21haW4ud3EsCisJCQkJCSAgICAgICZhZGV2LT52aXJ0LmZscl93b3JrKSwKKwkJCQkgICJGYWls
ZWQgdG8gcXVldWUgd29yayEgYXQgJXMiLAorCQkJCSAgX19mdW5jX18pOwogCQlicmVhazsKIAkJ
Y2FzZSBJREhfUVVFUllfQUxJVkU6CiAJCQl4Z3B1X2FpX21haWxib3hfc2VuZF9hY2soYWRldik7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfbnYuYwppbmRleCA0NzdkMGRkZTE5YzUuLjU3
MjhhNjQwMWQ3MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVf
bnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jCkBAIC0zMDks
NyArMzA5LDcgQEAgc3RhdGljIHZvaWQgeGdwdV9udl9tYWlsYm94X2Zscl93b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykKIAkJYWRldi0+Z2Z4X3RpbWVvdXQgPT0gTUFYX1NDSEVEVUxFX1RJ
TUVPVVQgfHwKIAkJYWRldi0+Y29tcHV0ZV90aW1lb3V0ID09IE1BWF9TQ0hFRFVMRV9USU1FT1VU
IHx8CiAJCWFkZXYtPnZpZGVvX3RpbWVvdXQgPT0gTUFYX1NDSEVEVUxFX1RJTUVPVVQpKQotCQlh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKGFkZXYsIE5VTEwpOworCQlhbWRncHVfZGV2aWNlX2dw
dV9yZWNvdmVyX2ltcChhZGV2LCBOVUxMKTsKIH0KIAogc3RhdGljIGludCB4Z3B1X252X3NldF9t
YWlsYm94X3Jjdl9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCkBAIC0zMzcsOCArMzM3
LDExIEBAIHN0YXRpYyBpbnQgeGdwdV9udl9tYWlsYm94X3Jjdl9pcnEoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiAKIAlzd2l0Y2ggKGV2ZW50KSB7CiAJY2FzZSBJREhfRkxSX05PVElGSUNB
VElPTjoKLQkJaWYgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpKQotCQkJc2NoZWR1bGVfd29y
aygmYWRldi0+dmlydC5mbHJfd29yayk7CisJCWlmIChhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2
KSAmJiAhYW1kZ3B1X2luX3Jlc2V0KGFkZXYpKQorCQkJV0FSTl9PTkNFKCFxdWV1ZV93b3JrKGFk
ZXYtPnJlc2V0X2RvbWFpbi53cSwKKwkJCQkJICAgICAgJmFkZXYtPnZpcnQuZmxyX3dvcmspLAor
CQkJCSAgIkZhaWxlZCB0byBxdWV1ZSB3b3JrISBhdCAlcyIsCisJCQkJICBfX2Z1bmNfXyk7CiAJ
CWJyZWFrOwogCQkvKiBSRUFEWV9UT19BQ0NFU1NfR1BVIGlzIGZldGNoZWQgYnkga2VybmVsIHBv
bGxpbmcsIElSUSBjYW4gaWdub3JlCiAJCSAqIGl0IGJ5ZmFyIHNpbmNlIHRoYXQgcG9sbGluZyB0
aHJlYWQgd2lsbCBoYW5kbGUgaXQsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9teGdwdV92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYwpp
bmRleCBhNjQyYzA0Y2YxN2QuLjFmNGNkYTA0NDdmMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV92aS5jCkBAIC01MjEsNyArNTIxLDcgQEAgc3RhdGljIHZvaWQgeGdwdV92aV9tYWls
Ym94X2Zscl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAogCS8qIFRyaWdnZXIgcmVj
b3ZlcnkgZHVlIHRvIHdvcmxkIHN3aXRjaCBmYWlsdXJlICovCiAJaWYgKGFtZGdwdV9kZXZpY2Vf
c2hvdWxkX3JlY292ZXJfZ3B1KGFkZXYpKQotCQlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKGFk
ZXYsIE5VTEwpOworCQlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyX2ltcChhZGV2LCBOVUxMKTsK
IH0KIAogc3RhdGljIGludCB4Z3B1X3ZpX3NldF9tYWlsYm94X3Jjdl9pcnEoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCkBAIC01NTAsOCArNTUwLDExIEBAIHN0YXRpYyBpbnQgeGdwdV92aV9t
YWlsYm94X3Jjdl9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCXIgPSB4Z3B1X3Zp
X21haWxib3hfcmN2X21zZyhhZGV2LCBJREhfRkxSX05PVElGSUNBVElPTik7CiAKIAkJLyogb25s
eSBoYW5kbGUgRkxSX05PVElGWSBub3cgKi8KLQkJaWYgKCFyKQotCQkJc2NoZWR1bGVfd29yaygm
YWRldi0+dmlydC5mbHJfd29yayk7CisJCWlmICghciAmJiAhYW1kZ3B1X2luX3Jlc2V0KGFkZXYp
KQorCQkJV0FSTl9PTkNFKCFxdWV1ZV93b3JrKGFkZXYtPnJlc2V0X2RvbWFpbi53cSwKKwkJCQkJ
ICAgICAgJmFkZXYtPnZpcnQuZmxyX3dvcmspLAorCQkJCSAgIkZhaWxlZCB0byBxdWV1ZSB3b3Jr
ISBhdCAlcyIsCisJCQkJICBfX2Z1bmNfXyk7CiAJfQogCiAJcmV0dXJuIDA7Ci0tIAoyLjI1LjEK
Cg==

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-drm-amdgpu-Serialize-non-TDR-gpu-recovery-with-TDRs.patch"
Content-Disposition: attachment;
 filename*0="0003-drm-amdgpu-Serialize-non-TDR-gpu-recovery-with-TDRs.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSAyMjg5NjM5OGNhYzk1ODk2NTg5NjQ3MDQ0N2E5OWNiNzE3YWUyMThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogRnJpLCAxNyBEZWMgMjAyMSAxMzowNToxNSAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBTZXJpYWxpemUgbm9uIFREUiBncHUgcmVjb3Zlcnkgd2l0aCBURFJzCk1JTUUt
VmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250
ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpVc2UgcmVzZXQgZG9tYWluIHdxIGFsc28gZm9y
IG5vbiBURFIgZ3B1IHJlY292ZXJ5IHRyaWdlcnMKc3VjaCBhcyBzeXNmcyBhbmQgUkFTLiBXZSBt
dXN0IHNlcmlhbGl6ZSBhbGwgcG9zc2libGUKR1BVIHJlY292ZXJpZXMgdG8gZ3VyYW50ZWUgbm8g
Y29uY3VycmVuY3kgdGhlcmUuCkZvciBURFIgY2FsbCB0aGUgb3JpZ2luYWwgcmVjb3ZlcnkgZnVu
Y3Rpb24gZGlyZWN0bHkgc2luY2UKaXQncyBhbHJlYWR5IGV4ZWN1dGVkIGZyb20gd2l0aGluIHRo
ZSB3cS4gRm9yIG90aGVycyBqdXN0CnVzZSBhIHdyYXBwZXIgdG8gcWV1ZXVlIHdvcmsgYW5kIHdh
aXQgb24gaXQgdG8gZmluaXNoLgoKdjI6IFJlbmFtZSB0byBhbWRncHVfcmVjb3Zlcl93b3JrX3N0
cnVjdAoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Ckxpbms6IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FtZC1nZngvbXNn
NzQxMTMuaHRtbAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAg
ICB8ICAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAz
MyArKysrKysrKysrKysrKysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfam9iLmMgICAgfCAgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggOWY4YWVi
MzBlOTMwLi4xMGY2YWFhNjJlOTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBA
IC0xMjk3LDYgKzEyOTcsOCBAQCBib29sIGFtZGdwdV9kZXZpY2VfaGFzX2pvYl9ydW5uaW5nKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIGJvb2wgYW1kZ3B1X2RldmljZV9zaG91bGRfcmVj
b3Zlcl9ncHUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGFtZGdwdV9kZXZpY2Vf
Z3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICBzdHJ1Y3Qg
YW1kZ3B1X2pvYiogam9iKTsKK2ludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyX2ltcChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJCSAgICAgIHN0cnVjdCBhbWRncHVfam9iICpqb2Ip
Owogdm9pZCBhbWRncHVfZGV2aWNlX3BjaV9jb25maWdfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpOwogaW50IGFtZGdwdV9kZXZpY2VfcGNpX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKIGJvb2wgYW1kZ3B1X2RldmljZV9uZWVkX3Bvc3Qoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
CmluZGV4IGU2ZWJmNTI3NmNlNi4uYjMyZDQwYTg3MThlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC01MTA3LDcgKzUxMDcsNyBAQCBzdGF0aWMgdm9p
ZCBhbWRncHVfZGV2aWNlX3JlY2hlY2tfZ3VpbHR5X2pvYnMoCiAgKiBSZXR1cm5zIDAgZm9yIHN1
Y2Nlc3Mgb3IgYW4gZXJyb3Igb24gZmFpbHVyZS4KICAqLwogCi1pbnQgYW1kZ3B1X2RldmljZV9n
cHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKK2ludCBhbWRncHVfZGV2aWNl
X2dwdV9yZWNvdmVyX2ltcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgICAgIHN0
cnVjdCBhbWRncHVfam9iICpqb2IpCiB7CiAJc3RydWN0IGxpc3RfaGVhZCBkZXZpY2VfbGlzdCwg
KmRldmljZV9saXN0X2hhbmRsZSA9ICBOVUxMOwpAQCAtNTM2OSw2ICs1MzY5LDM3IEBAIGludCBh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXJl
dHVybiByOwogfQogCitzdHJ1Y3QgYW1kZ3B1X3JlY292ZXJfd29ya19zdHJ1Y3QgeworCXN0cnVj
dCB3b3JrX3N0cnVjdCBiYXNlOworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2OworCXN0cnVj
dCBhbWRncHVfam9iICpqb2I7CisJaW50IHJldDsKK307CisKK3N0YXRpYyB2b2lkIGFtZGdwdV9k
ZXZpY2VfcXVldWVfZ3B1X3JlY292ZXJfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7
CisJc3RydWN0IGFtZGdwdV9yZWNvdmVyX3dvcmtfc3RydWN0ICpyZWNvdmVyX3dvcmsgPSBjb250
YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9yZWNvdmVyX3dvcmtfc3RydWN0LCBiYXNlKTsK
KworCXJlY292ZXJfd29yay0+cmV0ID0gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlcl9pbXAocmVj
b3Zlcl93b3JrLT5hZGV2LCByZWNvdmVyX3dvcmstPmpvYik7Cit9CisvKgorICogU2VyaWFsaXpl
IGdwdSByZWNvdmVyIGludG8gcmVzZXQgZG9tYWluIHNpbmdsZSB0aHJlYWRlZCB3cQorICovCitp
bnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
KwkJCQkgICAgc3RydWN0IGFtZGdwdV9qb2IgKmpvYikKK3sKKwlzdHJ1Y3QgYW1kZ3B1X3JlY292
ZXJfd29ya19zdHJ1Y3Qgd29yayA9IHsuYWRldiA9IGFkZXYsIC5qb2IgPSBqb2J9OworCisJSU5J
VF9XT1JLKCZ3b3JrLmJhc2UsIGFtZGdwdV9kZXZpY2VfcXVldWVfZ3B1X3JlY292ZXJfd29yayk7
CisKKwlpZiAoIXF1ZXVlX3dvcmsoYWRldi0+cmVzZXRfZG9tYWluLndxLCAmd29yay5iYXNlKSkK
KwkJcmV0dXJuIC1FQUdBSU47CisKKwlmbHVzaF93b3JrKCZ3b3JrLmJhc2UpOworCisJcmV0dXJu
IHdvcmsucmV0OworfQorCiAvKioKICAqIGFtZGdwdV9kZXZpY2VfZ2V0X3BjaWVfaW5mbyAtIGZl
bmNlIHBjaWUgaW5mbyBhYm91dCB0aGUgUENJRSBzbG90CiAgKgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2pvYi5jCmluZGV4IDQ4NzBlMDkzMjEzZC4uYTY2YWMyZTZkMTg5IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCkBAIC02NCw3ICs2NCw3IEBAIHN0
YXRpYyBlbnVtIGRybV9ncHVfc2NoZWRfc3RhdCBhbWRncHVfam9iX3RpbWVkb3V0KHN0cnVjdCBk
cm1fc2NoZWRfam9iICpzX2pvYikKIAkJICB0aS5wcm9jZXNzX25hbWUsIHRpLnRnaWQsIHRpLnRh
c2tfbmFtZSwgdGkucGlkKTsKIAogCWlmIChhbWRncHVfZGV2aWNlX3Nob3VsZF9yZWNvdmVyX2dw
dShyaW5nLT5hZGV2KSkgewotCQlyID0gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihyaW5nLT5h
ZGV2LCBqb2IpOworCQlyID0gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlcl9pbXAocmluZy0+YWRl
diwgam9iKTsKIAkJaWYgKHIpCiAJCQlEUk1fRVJST1IoIkdQVSBSZWNvdmVyeSBGYWlsZWQ6ICVk
XG4iLCByKTsKIAotLSAKMi4yNS4xCgo=

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-drm-amdgpu-Move-scheduler-init-to-after-XGMI-is-read.patch"
Content-Disposition: attachment;
 filename*0="0002-drm-amdgpu-Move-scheduler-init-to-after-XGMI-is-read.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4ZDVkZGM3MDM3ZmM2YzY5OTY5MmNkYzhkZTc5OWIxNTgzZDU3NjVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogTW9uLCA2IERlYyAyMDIxIDE0OjU5OjM1IC0wNTAwClN1YmplY3Q6IGRy
bS9hbWRncHU6IE1vdmUgc2NoZWR1bGVyIGluaXQgdG8gYWZ0ZXIgWEdNSSBpcyByZWFkeQpNSU1F
LVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29u
dGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQmVmb3JlIHdlIGluaXRpYWxpemUgc2NoZWR1
bGVycyB3ZSBtdXN0IGtub3cgd2hpY2ggcmVzZXQKZG9tYWluIGFyZSB3ZSBpbiAtIGZvciBzaW5n
bGUgZGV2aWNlIHRoZXJlIGlpcyBhIHNpbmdsZQpkb21haW4gcGVyIGRldmljZSBhbmQgc28gc2lu
Z2xlIHdxIHBlciBkZXZpY2UuIEZvciBYR01JCnRoZSByZXNldCBkb21haW4gc3BhbnMgdGhlIGVu
dGlyZSBYR01JIGhpdmUgYW5kIHNvIHRoZQpyZXNldCB3cSBpcyBwZXIgaGl2ZS4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpMaW5r
OiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9hbWQtZ2Z4L21zZzc0MTEyLmh0bWwKLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA0NiArKysrKysr
KysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2Uu
YyAgfCA0MyArKystLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuYyAgIHwgIDUgKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmluZy5oICAgfCAgNiArLS0KIDQgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwg
NDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jCmluZGV4IDIxNGFjMmQ0MjkzMC4uZTZlYmY1Mjc2Y2U2IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yMzM2LDYgKzIzMzYsNDggQEAgc3RhdGlj
IGludCBhbWRncHVfZGV2aWNlX2Z3X2xvYWRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAJcmV0dXJuIHI7CiB9CiAKK3N0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pbml0X3NjaGVkdWxl
cnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJbG9uZyB0aW1lb3V0OworCWludCBy
LCBpOworCisJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsraSkgeworCQlzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsKKworCQkvKiBObyBuZWVkIHRv
IHNldHVwIHRoZSBHUFUgc2NoZWR1bGVyIGZvciByaW5ncyB0aGF0IGRvbid0IG5lZWQgaXQgKi8K
KwkJaWYgKCFyaW5nIHx8IHJpbmctPm5vX3NjaGVkdWxlcikKKwkJCWNvbnRpbnVlOworCisJCXN3
aXRjaCAocmluZy0+ZnVuY3MtPnR5cGUpIHsKKwkJY2FzZSBBTURHUFVfUklOR19UWVBFX0dGWDoK
KwkJCXRpbWVvdXQgPSBhZGV2LT5nZnhfdGltZW91dDsKKwkJCWJyZWFrOworCQljYXNlIEFNREdQ
VV9SSU5HX1RZUEVfQ09NUFVURToKKwkJCXRpbWVvdXQgPSBhZGV2LT5jb21wdXRlX3RpbWVvdXQ7
CisJCQlicmVhazsKKwkJY2FzZSBBTURHUFVfUklOR19UWVBFX1NETUE6CisJCQl0aW1lb3V0ID0g
YWRldi0+c2RtYV90aW1lb3V0OworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQl0aW1lb3V0ID0g
YWRldi0+dmlkZW9fdGltZW91dDsKKwkJCWJyZWFrOworCQl9CisKKwkJciA9IGRybV9zY2hlZF9p
bml0KCZyaW5nLT5zY2hlZCwgJmFtZGdwdV9zY2hlZF9vcHMsCisJCQkJICAgcmluZy0+bnVtX2h3
X3N1Ym1pc3Npb24sIGFtZGdwdV9qb2JfaGFuZ19saW1pdCwKKwkJCQkgICB0aW1lb3V0LCBhZGV2
LT5yZXNldF9kb21haW4ud3EsIHJpbmctPnNjaGVkX3Njb3JlLAorCQkJCSAgIHJpbmctPm5hbWUs
IGFkZXYtPmRldik7CisJCWlmIChyKSB7CisJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBjcmVhdGUg
c2NoZWR1bGVyIG9uIHJpbmcgJXMuXG4iLAorCQkJCSAgcmluZy0+bmFtZSk7CisJCQlyZXR1cm4g
cjsKKwkJfQorCX0KKworCXJldHVybiAwOworfQorCisKIC8qKgogICogYW1kZ3B1X2RldmljZV9p
cF9pbml0IC0gcnVuIGluaXQgZm9yIGhhcmR3YXJlIElQcwogICoKQEAgLTI0NjgsNiArMjUxMCwx
MCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAkJfQogCX0KIAorCXIgPSBhbWRncHVfZGV2aWNlX2luaXRfc2NoZWR1bGVycyhh
ZGV2KTsKKwlpZiAocikKKwkJZ290byBpbml0X2ZhaWxlZDsKKwogCS8qIERvbid0IGluaXQga2Zk
IGlmIHdob2xlIGhpdmUgbmVlZCB0byBiZSByZXNldCBkdXJpbmcgaW5pdCAqLwogCWlmICghYWRl
di0+Z21jLnhnbWkucGVuZGluZ19yZXNldCkKIAkJYW1kZ3B1X2FtZGtmZF9kZXZpY2VfaW5pdChh
ZGV2KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5j
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKaW5kZXggY2Qy
ZDU5NGQ0ZmZjLi41ZDEzZWQzNzZhYjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mZW5jZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mZW5jZS5jCkBAIC00NDYsMjQgKzQ0NiwxOCBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2RyaXZl
cl9zdGFydF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKICAqIGZvciB0aGUgcmVxdWVz
dGVkIHJpbmcuCiAgKgogICogQHJpbmc6IHJpbmcgdG8gaW5pdCB0aGUgZmVuY2UgZHJpdmVyIG9u
Ci0gKiBAbnVtX2h3X3N1Ym1pc3Npb246IG51bWJlciBvZiBlbnRyaWVzIG9uIHRoZSBoYXJkd2Fy
ZSBxdWV1ZQotICogQHNjaGVkX3Njb3JlOiBvcHRpb25hbCBzY29yZSBhdG9taWMgc2hhcmVkIHdp
dGggb3RoZXIgc2NoZWR1bGVycwogICoKICAqIEluaXQgdGhlIGZlbmNlIGRyaXZlciBmb3IgdGhl
IHJlcXVlc3RlZCByaW5nIChhbGwgYXNpY3MpLgogICogSGVscGVyIGZ1bmN0aW9uIGZvciBhbWRn
cHVfZmVuY2VfZHJpdmVyX2luaXQoKS4KICAqLwotaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfaW5p
dF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKLQkJCQkgIHVuc2lnbmVkIG51bV9od19z
dWJtaXNzaW9uLAotCQkJCSAgYXRvbWljX3QgKnNjaGVkX3Njb3JlKQoraW50IGFtZGdwdV9mZW5j
ZV9kcml2ZXJfaW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIHsKIAlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7Ci0JbG9uZyB0aW1lb3V0OwotCWludCBy
OwogCiAJaWYgKCFhZGV2KQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWlmICghaXNfcG93ZXJfb2Zf
MihudW1faHdfc3VibWlzc2lvbikpCisJaWYgKCFpc19wb3dlcl9vZl8yKHJpbmctPm51bV9od19z
dWJtaXNzaW9uKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlyaW5nLT5mZW5jZV9kcnYuY3B1X2Fk
ZHIgPSBOVUxMOwpAQCAtNDc0LDQxICs0NjgsMTQgQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJf
aW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIAogCXRpbWVyX3NldHVwKCZyaW5n
LT5mZW5jZV9kcnYuZmFsbGJhY2tfdGltZXIsIGFtZGdwdV9mZW5jZV9mYWxsYmFjaywgMCk7CiAK
LQlyaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrID0gbnVtX2h3X3N1Ym1pc3Npb24gKiAy
IC0gMTsKKwlyaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrID0gcmluZy0+bnVtX2h3X3N1
Ym1pc3Npb24gKiAyIC0gMTsKIAlzcGluX2xvY2tfaW5pdCgmcmluZy0+ZmVuY2VfZHJ2LmxvY2sp
OwotCXJpbmctPmZlbmNlX2Rydi5mZW5jZXMgPSBrY2FsbG9jKG51bV9od19zdWJtaXNzaW9uICog
Miwgc2l6ZW9mKHZvaWQgKiksCisJcmluZy0+ZmVuY2VfZHJ2LmZlbmNlcyA9IGtjYWxsb2Mocmlu
Zy0+bnVtX2h3X3N1Ym1pc3Npb24gKiAyLCBzaXplb2Yodm9pZCAqKSwKIAkJCQkJIEdGUF9LRVJO
RUwpOworCiAJaWYgKCFyaW5nLT5mZW5jZV9kcnYuZmVuY2VzKQogCQlyZXR1cm4gLUVOT01FTTsK
IAotCS8qIE5vIG5lZWQgdG8gc2V0dXAgdGhlIEdQVSBzY2hlZHVsZXIgZm9yIHJpbmdzIHRoYXQg
ZG9uJ3QgbmVlZCBpdCAqLwotCWlmIChyaW5nLT5ub19zY2hlZHVsZXIpCi0JCXJldHVybiAwOwot
Ci0Jc3dpdGNoIChyaW5nLT5mdW5jcy0+dHlwZSkgewotCWNhc2UgQU1ER1BVX1JJTkdfVFlQRV9H
Rlg6Ci0JCXRpbWVvdXQgPSBhZGV2LT5nZnhfdGltZW91dDsKLQkJYnJlYWs7Ci0JY2FzZSBBTURH
UFVfUklOR19UWVBFX0NPTVBVVEU6Ci0JCXRpbWVvdXQgPSBhZGV2LT5jb21wdXRlX3RpbWVvdXQ7
Ci0JCWJyZWFrOwotCWNhc2UgQU1ER1BVX1JJTkdfVFlQRV9TRE1BOgotCQl0aW1lb3V0ID0gYWRl
di0+c2RtYV90aW1lb3V0OwotCQlicmVhazsKLQlkZWZhdWx0OgotCQl0aW1lb3V0ID0gYWRldi0+
dmlkZW9fdGltZW91dDsKLQkJYnJlYWs7Ci0JfQotCi0JciA9IGRybV9zY2hlZF9pbml0KCZyaW5n
LT5zY2hlZCwgJmFtZGdwdV9zY2hlZF9vcHMsCi0JCQkgICBudW1faHdfc3VibWlzc2lvbiwgYW1k
Z3B1X2pvYl9oYW5nX2xpbWl0LAotCQkJICAgdGltZW91dCwgTlVMTCwgc2NoZWRfc2NvcmUsIHJp
bmctPm5hbWUsIGFkZXYtPmRldik7Ci0JaWYgKHIpIHsKLQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8g
Y3JlYXRlIHNjaGVkdWxlciBvbiByaW5nICVzLlxuIiwKLQkJCSAgcmluZy0+bmFtZSk7Ci0JCXJl
dHVybiByOwotCX0KLQogCXJldHVybiAwOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuYwppbmRleCBhYjIzNTFiYTk1NzQuLjM1YmNiNmRjMTgxNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCkBAIC0xOTEsOCArMTkxLDkgQEAgaW50
IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywKIAkJcmluZy0+YWRldiA9IGFkZXY7CiAJCXJpbmctPmlkeCA9IGFkZXYt
Pm51bV9yaW5ncysrOwogCQlhZGV2LT5yaW5nc1tyaW5nLT5pZHhdID0gcmluZzsKLQkJciA9IGFt
ZGdwdV9mZW5jZV9kcml2ZXJfaW5pdF9yaW5nKHJpbmcsIHNjaGVkX2h3X3N1Ym1pc3Npb24sCi0J
CQkJCQkgIHNjaGVkX3Njb3JlKTsKKwkJcmluZy0+bnVtX2h3X3N1Ym1pc3Npb24gPSBzY2hlZF9o
d19zdWJtaXNzaW9uOworCQlyaW5nLT5zY2hlZF9zY29yZSA9IHNjaGVkX3Njb3JlOworCQlyID0g
YW1kZ3B1X2ZlbmNlX2RyaXZlcl9pbml0X3JpbmcocmluZyk7CiAJCWlmIChyKQogCQkJcmV0dXJu
IHI7CiAJfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKaW5kZXggZmFl
N2QxODVhZDBkLi40ODM2NWRhMjEzZGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3JpbmcuaApAQCAtMTE0LDkgKzExNCw3IEBAIHN0cnVjdCBhbWRncHVfZmVuY2VfZHJpdmVy
IHsKIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9jbGVhcl9qb2JfZmVuY2VzKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZyk7CiB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlv
bihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOwogCi1pbnQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9p
bml0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAotCQkJCSAgdW5zaWduZWQgbnVtX2h3
X3N1Ym1pc3Npb24sCi0JCQkJICBhdG9taWNfdCAqc2NoZWRfc2NvcmUpOworaW50IGFtZGdwdV9m
ZW5jZV9kcml2ZXJfaW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7CiBpbnQgYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIAkJ
CQkgICBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgKmlycV9zcmMsCiAJCQkJICAgdW5zaWduZWQgaXJx
X3R5cGUpOwpAQCAtMjUxLDYgKzI0OSw4IEBAIHN0cnVjdCBhbWRncHVfcmluZyB7CiAJYm9vbAkJ
CWhhc19jb21wdXRlX3ZtX2J1ZzsKIAlib29sCQkJbm9fc2NoZWR1bGVyOwogCWludAkJCWh3X3By
aW87CisJdW5zaWduZWQgCQludW1faHdfc3VibWlzc2lvbjsKKwlhdG9taWNfdAkJKnNjaGVkX3Nj
b3JlOwogfTsKIAogI2RlZmluZSBhbWRncHVfcmluZ19wYXJzZV9jcyhyLCBwLCBpYikgKChyKS0+
ZnVuY3MtPnBhcnNlX2NzKChwKSwgKGliKSkpCi0tIAoyLjI1LjEKCg==

--------------UwIFBqoHO4Ie10fMTNiTjn3w
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdgpu-Introduce-reset-domain.patch"
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-Introduce-reset-domain.patch"
Content-Transfer-Encoding: base64

RnJvbSA1OTYxYjIyMWNlOWU2MTg4MDk5MWZkNmMwNDBjZjUyNWNhZGQ0YTM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogVHVlLCAzMCBOb3YgMjAyMSAxNjoxOTowMyAtMDUwMApTdWJqZWN0OiBk
cm0vYW1kZ3B1OiBJbnRyb2R1Y2UgcmVzZXQgZG9tYWluCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpEZWZpbmVkIGEgcmVzZXRfZG9tYWluIHN0cnVjdCBzdWNoIHRoYXQKYWxsIHRo
ZSBlbnRpdGllcyB0aGF0IGdvIHRocm91Z2ggcmVzZXQKdG9nZXRoZXIgd2lsbCBiZSBzZXJpYWxp
emVkIG9uZSBhZ2FpbnN0CmFub3RoZXIuIERvIGl0IGZvciBib3RoIHNpbmdsZSBkZXZpY2UgYW5k
ClhHTUkgaGl2ZSBjYXNlcy4KClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRy
ZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpTdWdnZXN0ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmll
bC52ZXR0ZXJAZmZ3bGwuY2g+ClN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ckxpbms6IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0
L2xpc3RzL2FtZC1nZngvbXNnNzQxMTEuaHRtbAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oICAgICAgICB8ICA2ICsrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgICB8ICA5ICsrKysrKysrKwogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCAgIHwgIDIgKysKIDQgZmlsZXMgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmgKaW5kZXggYmJlOTk1MGJmNGRiLi45ZjhhZWIzMGU5MzAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC04MDcsNiArODA3LDEwIEBAIHN0cnVjdCBpcF9kaXNjb3Zl
cnlfdG9wOwogI2RlZmluZSBBTURHUFVfUkVTRVRfTUFHSUNfTlVNIDY0CiAjZGVmaW5lIEFNREdQ
VV9NQVhfREZfUEVSRk1PTlMgNAogI2RlZmluZSBBTURHUFVfUFJPRFVDVF9OQU1FX0xFTiA2NAor
c3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4geworCXN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3
cTsKK307CisKIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsKIAlzdHJ1Y3QgZGV2aWNlCQkJKmRldjsK
IAlzdHJ1Y3QgcGNpX2RldgkJCSpwZGV2OwpAQCAtMTA5OCw2ICsxMTAyLDggQEAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgewogCS8qIHJlc2V0IGR1bXAgcmVnaXN0ZXIgKi8KIAl1aW50MzJfdCAgICAg
ICAgICAgICAgICAgICAgICAgICpyZXNldF9kdW1wX3JlZ19saXN0OwogCWludCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbnVtX3JlZ3M7CisKKwlzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFp
bglyZXNldF9kb21haW47CiB9OwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNl
ICpkcm1fdG9fYWRldihzdHJ1Y3QgZHJtX2RldmljZSAqZGRldikKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA2MTEzZGRjNzY1YTcuLjIxNGFjMmQ0Mjkz
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjQ0
Nyw5ICsyNDQ3LDI3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCWlmIChyKQogCQlnb3RvIGluaXRfZmFpbGVkOwogCi0JaWYg
KGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpCisJaWYgKGFkZXYtPmdtYy54
Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKKwkJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8g
KmhpdmU7CisKIAkJYW1kZ3B1X3hnbWlfYWRkX2RldmljZShhZGV2KTsKIAorCQloaXZlID0gYW1k
Z3B1X2dldF94Z21pX2hpdmUoYWRldik7CisJCWlmICghaGl2ZSB8fCAhaGl2ZS0+cmVzZXRfZG9t
YWluLndxKSB7CisJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBvYnRhaW4gcmVzZXQgZG9tYWluIGlu
Zm8gZm9yIFhHTUkgaGl2ZTolbGx4IiwgaGl2ZS0+aGl2ZV9pZCk7CisJCQlyID0gLUVJTlZBTDsK
KwkJCWdvdG8gaW5pdF9mYWlsZWQ7CisJCX0KKworCQlhZGV2LT5yZXNldF9kb21haW4ud3EgPSBo
aXZlLT5yZXNldF9kb21haW4ud3E7CisJfSBlbHNlIHsKKwkJYWRldi0+cmVzZXRfZG9tYWluLndx
ID0gYWxsb2Nfb3JkZXJlZF93b3JrcXVldWUoImFtZGdwdS1yZXNldC1kZXYiLCAwKTsKKwkJaWYg
KCFhZGV2LT5yZXNldF9kb21haW4ud3EpIHsKKwkJCXIgPSAtRU5PTUVNOworCQkJZ290byBpbml0
X2ZhaWxlZDsKKwkJfQorCX0KKwogCS8qIERvbid0IGluaXQga2ZkIGlmIHdob2xlIGhpdmUgbmVl
ZCB0byBiZSByZXNldCBkdXJpbmcgaW5pdCAqLwogCWlmICghYWRldi0+Z21jLnhnbWkucGVuZGlu
Z19yZXNldCkKIAkJYW1kZ3B1X2FtZGtmZF9kZXZpY2VfaW5pdChhZGV2KTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCmluZGV4IDc3YjY1NDM0Y2NjMi4uNTM2N2NlNTcy
YjJkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMKQEAgLTM5OCw2
ICszOTgsMTQgQEAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmFtZGdwdV9nZXRfeGdtaV9oaXZl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlnb3RvIHByb19lbmQ7CiAJfQogCisJaGl2
ZS0+cmVzZXRfZG9tYWluLndxID0gYWxsb2Nfb3JkZXJlZF93b3JrcXVldWUoImFtZGdwdS1yZXNl
dC1oaXZlIiwgMCk7CisJaWYgKCFoaXZlLT5yZXNldF9kb21haW4ud3EpIHsKKwkJZGV2X2Vycihh
ZGV2LT5kZXYsICJYR01JOiBmYWlsZWQgYWxsb2NhdGluZyB3cSBmb3IgcmVzZXQgZG9tYWluIVxu
Iik7CisJCWtmcmVlKGhpdmUpOworCQloaXZlID0gTlVMTDsKKwkJZ290byBwcm9fZW5kOworCX0K
KwogCWhpdmUtPmhpdmVfaWQgPSBhZGV2LT5nbWMueGdtaS5oaXZlX2lkOwogCUlOSVRfTElTVF9I
RUFEKCZoaXZlLT5kZXZpY2VfbGlzdCk7CiAJSU5JVF9MSVNUX0hFQUQoJmhpdmUtPm5vZGUpOwpA
QCAtNDA3LDYgKzQxNSw3IEBAIHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICphbWRncHVfZ2V0X3hn
bWlfaGl2ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl0YXNrX2JhcnJpZXJfaW5pdCgm
aGl2ZS0+dGIpOwogCWhpdmUtPnBzdGF0ZSA9IEFNREdQVV9YR01JX1BTVEFURV9VTktOT1dOOwog
CWhpdmUtPmhpX3JlcV9ncHUgPSBOVUxMOworCiAJLyoKIAkgKiBoaXZlIHBzdGF0ZSBvbiBib290
IGlzIGhpZ2ggaW4gdmVnYTIwIHNvIHdlIGhhdmUgdG8gZ28gdG8gbG93CiAJICogcHN0YXRlIG9u
IGFmdGVyIGJvb3QuCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfeGdtaS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaAppbmRl
eCAwYWZjYTUxYzNjMGMuLjJhODlkODIwYWNlYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfeGdtaS5oCkBAIC00Miw2ICs0Miw4IEBAIHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZv
IHsKIAkJQU1ER1BVX1hHTUlfUFNUQVRFX01BWF9WRUdBMjAsCiAJCUFNREdQVV9YR01JX1BTVEFU
RV9VTktOT1dOCiAJfSBwc3RhdGU7CisKKwlzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiByZXNl
dF9kb21haW47CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1X3Bjc19yYXNfZmllbGQgewotLSAKMi4yNS4x
Cgo=

--------------UwIFBqoHO4Ie10fMTNiTjn3w--
