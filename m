Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5908E10E174;
	Tue,  8 Mar 2022 16:40:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0368E10E174
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQszsTm0r6ga7I/8sAagNSvBKfiIwFnt9H4BEBp0DyIH4pfaluBEviMKZCYWTIepVPfNfcNrhK0PS/yxJL5em05SbZzuW2JuYFVlfX6TjqJw3vBI7Q08ZKl0IQOiyuNzlFqvFDLrk/FpLtgIyYwGFSJndBTODsQ1ZFnViTp1KWZhulc+ncZbBcFDskThy5nIrNYjq6JLhlLipk3HIlbJtCdeBaGChRioXsE5d8cienrpsNmP8F7jei/EWOsI1rwqLTu4a5z/VgVjHCwZcX31N014dOTmsdLJDEdEXYaxcpXcrv4W8KFB1JpUaRm6EwCwebNQXwWgTXpWe7+KT3Ei0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roiV5dyoqpezgP6/ihAiTscqW1PvLmxcg/lYoiZ5OOo=;
 b=A076alanv5Fph9DOUOoGrCR4hJQlgSVtKckLQv9W28Uxwx+rCjmyhopODNe7sYS+00EMvoZFyWv9CEQehKfO4Dx9xKqihyjP08pt/4CwwHfLXf/7Rfkgj2qCvEYWaPY8Gla4gGeXPhNpKMTuuXETUCLSBlbSJZ/FDm2YXFzm1Dlf7bfuKf4Rd6AwW4BAAUiBPJkwodXwyA68umXXoBNEXvys5644u6n+khjiESX1hQoGk0KywpOl0g3nTv30bAzMn8rHhJh31cZwsjgscYff7HN0bXcUijLfPq/u7DdoN9PvRSnkuhe2ILkmyA7qDjAVQ9AB///2fYDmHUW5VnPXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roiV5dyoqpezgP6/ihAiTscqW1PvLmxcg/lYoiZ5OOo=;
 b=DfCwPro3xX57E/9ASUMuaoPQA9AIr2v0KpyPtFaiIV1a130KYSLcBZHDBFI68oL+UWEGpE3ddSOI6cKch4wlxiyUROlJCf+QyuWEts4ZLLyYk5zAJZYccsknDGGN0gSer9kcA03YPR2pXz4IyHPs/IZjZLCjB95gK4xD3JvAwAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 16:39:58 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:39:58 +0000
Content-Type: multipart/alternative;
 boundary="------------CgvHoMff0QPYYfhgy2rbVDXi"
Message-ID: <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
Date: Tue, 8 Mar 2022 11:39:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3490316c-9aa2-406b-cc7b-08da012248a1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0268:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB026841519541735EE3E23C81EA099@DM5PR1201MB0268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHqB6eVqQJ1sYoLehdqLkPew/H7gggMeVKXKAlZRN7grmFNddmcyEpjxtSMUN3NtbfS6v3ejrQhHs8LgQjCUn1zl2T5NdsfKaAF0cWV4kO6gi9+2BGhX7P9Oazcm4xDgvTwK18BaeDQj6YpJgkTVQm+VMeuxiLCq0dZiA7oMtbhLaPdJhP6lHqbHzqXqUl8S8DDQnesw4ucl07YLGNZ+1wnO0LjKqeFX/vUwOD2KG1YZUifd2TsuzZMI8FqmbVGfamzANwU0Kgmt8GwBgvAszuN2hPzizyw3hCNdNP/Xi4mEO3T8KADu5z7OtntBenu2aaE8+dMwO5MNsZEms5exi2GXmdoTXWziwtoAC/JFd/JoZcbrtSOZ80kInZ3INqvJz3Q78Kw0msYi3j7s805pHv7OU3v5ybIhWPXJR7QwsYqKm5xK4snUefL9qGF+0TLPe0vCklwpAXzkmzyZT7sonOczHv2kvjXjkkPFBj9lG28jaVLAFPnUWLw94R8aZxfkyHjJcNWgtMRJeSi30zkdQNt3cg/ZuAoHvAZLptjWJQcWe57N4i787iwVnlP9z8E66Y7FQTK0/yxxcI+t3/eKugpr4be3rjAZfyyjTjKJ4Or3e16PyyGho9czg0H1Zur50CekEtqMqYpdRiOs64NLLUXkl09HDJ+kFfLWZ32UL3jrT8BFcD0aUrCR0J0RAwITYB7/uRF4zJYa1uNlZcyioo7lvQFIsVi7XvN9wgkwDP6auWPbEmAACpeP+WCKhGK5XCHKzX1WTnqgtSTGna0vRLAxH/OAVEiLzcWnJSdw0RK9zR0lagL9IIHDgYRFHHm4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(966005)(36756003)(38100700002)(45080400002)(31686004)(8936002)(6506007)(6512007)(33964004)(316002)(66476007)(166002)(66556008)(5660300002)(44832011)(30864003)(508600001)(110136005)(54906003)(8676002)(4326008)(53546011)(66946007)(86362001)(31696002)(2616005)(2906002)(186003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdRVENrRTJXVS9sdWE2RTRoaHBYWjZNcGlzN3JsMFBFb3VGV0pTUjhYNkZE?=
 =?utf-8?B?SVR1TFg1RGhad0hNZ3JUVmFSc01XQzNUcVdocEVBaU8vMUl4bFhkbHpWRXd1?=
 =?utf-8?B?ZkkxNEtJYUtHb3BBUW9ZbjlsbXNWdzd0SXp5aktYOEdVSjRvSCttTWJNK0x0?=
 =?utf-8?B?VXI5Qy9BYWVscGdYK3dXSmFOOTgzYkxTL2w4ZEhiaUpmRW9RTjBuTjk4WHFO?=
 =?utf-8?B?dDZ3K3lYL2xROUlRUzYrd2ZXYzZPK0tTV3BuUzQ1L09zRFFZU0RhMU1pRVdB?=
 =?utf-8?B?cnN1SzBnYmt4bkdKRzR1RHY0WXo3eVphWlA4eVVmd1M3eFdhRzlBaXJobWF5?=
 =?utf-8?B?QStYNTVwYUJEejl6Nld1a2pnT0JhMHlPZ2ZmWkt1ck4yRHBWaHk3MnhBUlJ3?=
 =?utf-8?B?OXptRUF5aUl4OVlGUVJyMUVjVFRKMzRxMUlSVUJ3MmlkZ3pYSlZDd3A4bVFh?=
 =?utf-8?B?eHNSYWY4Y29vU2pBKysyZWQyNHJYMDJuSURRdkJxakdGWHJ4aDRwbjBUK3V1?=
 =?utf-8?B?REdxblBCQW10TmloOFhnQ0FSVDZQV0VlRzNZOS9JOTFOZS9KeGRuamd1TXVj?=
 =?utf-8?B?aVlzandhYkYzZ2Q0R0V4NTljcWQrQnRlL2xkeERtaUZtamNPQlFPMmtFNCt6?=
 =?utf-8?B?NUY5cXJncXU3VFhxOTRSekN4QVpVU2Vhcm5NRmR1ZC9oNFZlSEd0WUJrSmlD?=
 =?utf-8?B?TnZ2WkJDcnZBZFFNYzVBQkpvTUpFNkJjNHpKc2pkTmVBR3loSy9nUXViSUxZ?=
 =?utf-8?B?T05wL3A1Rk15aTdCMXpUM3BwT0NLSGlCc1ZqbFdqNVZJV2ZhL0FVSUNiUTJC?=
 =?utf-8?B?RTAxdWlWS0FKRXZ0azhYekxiOVFCUmFIVkdTWG82Q2JvMk5tMWRyZ1Z3S1Zj?=
 =?utf-8?B?R1UyVUwyV2dRU2xmQW5FWUQxVGwvVURXRjZBa3I1Mm9zYlY1STVnaS84ZkJ4?=
 =?utf-8?B?ZVB3REtGYkhRUEc1M2JZcitDT1A1bHJ5U2V3ZkNqaERsdXJxRUsySFFyOXB3?=
 =?utf-8?B?cDJyTVp4RmVET0JtMFpHeFZpN1RPTzNmWnRMN2YwMjlBWlNDQ285TitHeTE5?=
 =?utf-8?B?UEdZL25ROHU2VFYzaUVzZUhNU1htdlo5K0Rud1F6anloSUVyOC9jZ3NpUG5B?=
 =?utf-8?B?Rlg2eEFjYy8vL2FiWUh1a1RKOVp0NktOUzFSNG53L1NaT0Q4VnlPZUxsc2Yx?=
 =?utf-8?B?VVBVdGxqZ0x4TUxDMjMxN3R0cldDMVJGRkdWbm1aV25DVGlRTUY3QVBOVklZ?=
 =?utf-8?B?bWJ1ZjB4bWxobW0vdFl4UVpiNlozVDZodk8yQkxkN2trU01NbkFsczg5R3Fl?=
 =?utf-8?B?WVdROVlLeXdpMnFObWVrRGJnT1dzSXd4TjVrTVdtWGtIaHBBMHdSSzg3aFNj?=
 =?utf-8?B?bTJVZ0pKTUNwT0E2d3RzaDVSSnFIcSt6OGhIOVRmUThpNHdJZWIzZWRMNEla?=
 =?utf-8?B?S3liUmlFOHpKSGFJRktZd2xFTFhhQTYzWmZSa0NGVGdVbjhEVVZLRVRjMkdj?=
 =?utf-8?B?M2ZPMkY3c1VNTzF6d0wyOE9VY1ZqQThyTnRBQ3p2aCsxR3Fuc3JPTUNnMDIr?=
 =?utf-8?B?UkljTTRVWlBZUG1HVXJZQVFKS1NZaHZFKysvZVY2ajNTVk5YT0FYN3ZpNmRL?=
 =?utf-8?B?M3kzTGNaV2VaMm5yV0NXdEZsVGUzQ3pRaUJXSlRTVERIbzYrdjJ5ak9IOHd0?=
 =?utf-8?B?RXQ0WEMvQWp6SFpLTUpQdVJrUFhxOThlV1BSUFp1NitxTVU3OFBvbGxzZ3dH?=
 =?utf-8?B?RE1xOVBTMkxmbWQwTUpCeTV3UGROTHpVZ2NUS2RwOFVnaSswTDM4c0pKa0dH?=
 =?utf-8?B?bmpkT2RyQUpNb0l6Q2NJWVV0aVlaUlQwei9BWGc4a1NoRHhyMll4ck5yVmxT?=
 =?utf-8?B?a3M2VlM4OVJNdVRhK0xhMzBDeWRyRHRpTXp0T2c1WjBqVTNsZWUvbWtudmNl?=
 =?utf-8?B?ZjhPWU5wWnVHelRkTmduajRVNDl0R1NtN2ZMbDdQL1dudCtkTHdjRXpFemJn?=
 =?utf-8?B?UU1zNmVFYjRVS1ZhemZSVUxoR0VqTzZzWEo4N3pxTnJudWFvTHhPY05Tc2h1?=
 =?utf-8?B?cG1vT3NsQWFQNEN4TDBFU2hzcGsxTzRMd2tEMExkVzNWVFBQaFl5T2FSbktS?=
 =?utf-8?B?b3ZKVDRoNC9IZGpPcndpQ3hFc2hCUTZ6cFBpTkR3azlIWTZjbnVCcGJTK24z?=
 =?utf-8?B?Vzk3RWE2U3lYazVucSs2OUpReTFJdHhLYjRMVVFWRFY0aVlvaXhNYXl6R1Nj?=
 =?utf-8?Q?w79uuvatALb5FzxnI9we2bHrZ0BdPBgneMK9VdUMrc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3490316c-9aa2-406b-cc7b-08da012248a1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:39:58.6362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcwcTBi+Ast2JYU0fOgNB7H0VswSJ9san+q9Ol6Z+35bIOtwI80YDPZLO5KVAjPa58RKSKrDcyUd2bhgbUd+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------CgvHoMff0QPYYfhgy2rbVDXi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

As long as PMC driver provides clear interface to retrieve the info 
there should be no issue to call either amdgpu interface or PMC 
interface using IS_APU (or something alike in the code)
We probably should add a wrapper function around this logic in amdgpu.

Andrey

On 2022-03-08 11:36, Lazar, Lijo wrote:
>
> [AMD Official Use Only]
>
>
> +Mario
>
> I guess that means the functionality needs to be present in amdgpu for 
> APUs also. Presently, this is taken care by PMC driver for APUs.
>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>
> On 2022-03-07 11:26, Shashank Sharma wrote:
> > From: Shashank Sharma <shashank.sharma@amd.com>
> >
> > This patch adds a new sysfs event, which will indicate
> > the userland about a GPU reset, and can also provide
> > some information like:
> > - which PID was involved in the GPU reset
> > - what was the GPU status (using flags)
> >
> > This patch also introduces the first flag of the flags
> > bitmap, which can be appended as and when required.
>
>
> I am reminding again about another important piece of info which you 
> can add
> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
> specific but
> from what I see there is no problem to just amend it as part of envp[]
> initialization.
> bellow.
>
> The interface to get the buffer is smu_stb_collect_info and usage can be
> seen from
> frebugfs interface in smu_stb_debugfs_open
>
> [1] - 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0>
>
> Andrey
>
>
> >
> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> > ---
> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
> >   include/drm/drm_sysfs.h     |  3 +++
> >   2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> > index 430e00b16eec..52a015161431 100644
> > --- a/drivers/gpu/drm/drm_sysfs.c
> > +++ b/drivers/gpu/drm/drm_sysfs.c
> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device 
> *dev)
> >   }
> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
> >
> > +/**
> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
> > + * @dev: DRM device
> > + * @pid: The process ID involve with the reset
> > + * @flags: Any other information about the GPU status
> > + *
> > + * Send a uevent for the DRM device specified by @dev. This indicates
> > + * user that a GPU reset has occurred, so that the interested client
> > + * can take any recovery or profiling measure, when required.
> > + */
> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
> uint32_t flags)
> > +{
> > +     unsigned char pid_str[21], flags_str[15];
> > +     unsigned char reset_str[] = "RESET=1";
> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
> > +
> > +     DRM_DEBUG("generating reset event\n");
> > +
> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> > +}
> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
> > +
> >   /**
> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
> any connector
> >    * change
> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> > index 6273cac44e47..63f00fe8054c 100644
> > --- a/include/drm/drm_sysfs.h
> > +++ b/include/drm/drm_sysfs.h
> > @@ -2,6 +2,8 @@
> >   #ifndef _DRM_SYSFS_H_
> >   #define _DRM_SYSFS_H_
> >
> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
> > +
> >   struct drm_device;
> >   struct device;
> >   struct drm_connector;
> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
> >   void drm_class_device_unregister(struct device *dev);
> >
> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
> uint32_t reset_flags);
> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
> *connector);
> >   void drm_sysfs_connector_status_event(struct drm_connector *connector,
> >                                      struct drm_property *property);
--------------CgvHoMff0QPYYfhgy2rbVDXi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>As long as PMC driver provides clear interface to retrieve the
      info there should be no issue to call either amdgpu interface or
      PMC interface using IS_APU (or something alike in the code)<br>
      We probably should add a wrapper function around this logic in
      amdgpu.<br>
    </p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-08 11:36, Lazar, Lijo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div style="color: rgb(33, 33, 33); background-color: rgb(255,
          255, 255);" dir="auto">
          +Mario</div>
        <div style="color: rgb(33, 33, 33); background-color: rgb(255,
          255, 255);" dir="auto">
          <br>
        </div>
        <div style="color: rgb(33, 33, 33); background-color: rgb(255,
          255, 255);" dir="auto">
          I guess that means the functionality needs to be present in
          amdgpu for APUs also. Presently, this is taken care by PMC
          driver for APUs.<span></span></div>
        <div id="ms-outlook-mobile-signature" dir="auto">
          <div><br>
          </div>
          Thanks,<br>
          Lijo</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Andrey Grodzovsky
            <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, March 8, 2022 9:55:03 PM<br>
            <b>To:</b> Shashank Sharma
            <a class="moz-txt-link-rfc2396E" href="mailto:contactshashanksharma@gmail.com">&lt;contactshashanksharma@gmail.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Somalapuram, Amaranath
            <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Sharma, Shashank
            <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 1/2] drm: Add GPU reset sysfs
            event</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText"><br>
                On 2022-03-07 11:26, Shashank Sharma wrote:<br>
                &gt; From: Shashank Sharma
                <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a><br>
                &gt;<br>
                &gt; This patch adds a new sysfs event, which will
                indicate<br>
                &gt; the userland about a GPU reset, and can also
                provide<br>
                &gt; some information like:<br>
                &gt; - which PID was involved in the GPU reset<br>
                &gt; - what was the GPU status (using flags)<br>
                &gt;<br>
                &gt; This patch also introduces the first flag of the
                flags<br>
                &gt; bitmap, which can be appended as and when required.<br>
                <br>
                <br>
                I am reminding again about another important piece of
                info which you can add<br>
                here and that is Smart Trace Buffer dump [1]. The buffer
                size is HW <br>
                specific but<br>
                from what I see there is no problem to just amend it as
                part of envp[] <br>
                initialization.<br>
                bellow.<br>
                <br>
                The interface to get the buffer is smu_stb_collect_info
                and usage can be <br>
                seen from<br>
                frebugfs interface in smu_stb_debugfs_open<br>
                <br>
                [1] - <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;amp;reserved=0" moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;amp;reserved=0</a><br>
                <br>
                Andrey<br>
                <br>
                <br>
                &gt;<br>
                &gt; Cc: Alexandar Deucher
                <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                &gt; Cc: Christian Koenig
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                &gt; Signed-off-by: Shashank Sharma
                <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/drm_sysfs.c | 24
                ++++++++++++++++++++++++<br>
                &gt;&nbsp;&nbsp; include/drm/drm_sysfs.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
                &gt;&nbsp;&nbsp; 2 files changed, 27 insertions(+)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/drm_sysfs.c
                b/drivers/gpu/drm/drm_sysfs.c<br>
                &gt; index 430e00b16eec..52a015161431 100644<br>
                &gt; --- a/drivers/gpu/drm/drm_sysfs.c<br>
                &gt; +++ b/drivers/gpu/drm/drm_sysfs.c<br>
                &gt; @@ -409,6 +409,30 @@ void
                drm_sysfs_hotplug_event(struct drm_device *dev)<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sysfs_hotplug_event);<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; +/**<br>
                &gt; + * drm_sysfs_reset_event - generate a DRM uevent
                to indicate GPU reset<br>
                &gt; + * @dev: DRM device<br>
                &gt; + * @pid: The process ID involve with the reset<br>
                &gt; + * @flags: Any other information about the GPU
                status<br>
                &gt; + *<br>
                &gt; + * Send a uevent for the DRM device specified by
                @dev. This indicates<br>
                &gt; + * user that a GPU reset has occurred, so that the
                interested client<br>
                &gt; + * can take any recovery or profiling measure,
                when required.<br>
                &gt; + */<br>
                &gt; +void drm_sysfs_reset_event(struct drm_device *dev,
                uint64_t pid, uint32_t flags)<br>
                &gt; +{<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char pid_str[21], flags_str[15];<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char reset_str[] = &quot;RESET=1&quot;;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; char *envp[] = { reset_str, pid_str,
                flags_str, NULL };<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;generating reset event\n&quot;);<br>
                &gt; +<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pid_str, ARRAY_SIZE(pid_str),
                &quot;PID=%lu&quot;, pid);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp; snprintf(flags_str, ARRAY_SIZE(flags_str),
                &quot;FLAGS=%u&quot;, flags);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                kobject_uevent_env(&amp;dev-&gt;primary-&gt;kdev-&gt;kobj,
                KOBJ_CHANGE, envp);<br>
                &gt; +}<br>
                &gt; +EXPORT_SYMBOL(drm_sysfs_reset_event);<br>
                &gt; +<br>
                &gt;&nbsp;&nbsp; /**<br>
                &gt;&nbsp;&nbsp;&nbsp; * drm_sysfs_connector_hotplug_event - generate a
                DRM uevent for any connector<br>
                &gt;&nbsp;&nbsp;&nbsp; * change<br>
                &gt; diff --git a/include/drm/drm_sysfs.h
                b/include/drm/drm_sysfs.h<br>
                &gt; index 6273cac44e47..63f00fe8054c 100644<br>
                &gt; --- a/include/drm/drm_sysfs.h<br>
                &gt; +++ b/include/drm/drm_sysfs.h<br>
                &gt; @@ -2,6 +2,8 @@<br>
                &gt;&nbsp;&nbsp; #ifndef _DRM_SYSFS_H_<br>
                &gt;&nbsp;&nbsp; #define _DRM_SYSFS_H_<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 &lt;&lt;
                0)<br>
                &gt; +<br>
                &gt;&nbsp;&nbsp; struct drm_device;<br>
                &gt;&nbsp;&nbsp; struct device;<br>
                &gt;&nbsp;&nbsp; struct drm_connector;<br>
                &gt; @@ -11,6 +13,7 @@ int
                drm_class_device_register(struct device *dev);<br>
                &gt;&nbsp;&nbsp; void drm_class_device_unregister(struct device
                *dev);<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; void drm_sysfs_hotplug_event(struct drm_device
                *dev);<br>
                &gt; +void drm_sysfs_reset_event(struct drm_device *dev,
                uint64_t pid, uint32_t reset_flags);<br>
                &gt;&nbsp;&nbsp; void drm_sysfs_connector_hotplug_event(struct
                drm_connector *connector);<br>
                &gt;&nbsp;&nbsp; void drm_sysfs_connector_status_event(struct
                drm_connector *connector,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                drm_property *property);<br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------CgvHoMff0QPYYfhgy2rbVDXi--
