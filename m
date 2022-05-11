Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D393EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 13:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5733810E042;
	Wed, 11 May 2022 13:49:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568F010E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 13:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkfWLNBlKsOYsRtYd46ehoWhw1JkO1Ptk9MNzGD44xCW5m9aBDeVON9IOoKYy/wuNnzMaDNxA8mvJHNRwCG/brsBDnACci+Z5MU8TWYjm3snF5v/yiyJ17gjszCxZG1/AggPEzsoB5A8WX/sObrojSKaBhz0amCWYK08+mVyRdYcB5QZofPImqkJFcvl6tu8AUr2tqCyoF1JtSt9gJgRc0kSnpwOI4FV4R/Szsgp2K4T1KdQAYcpcCAprVCEhbIV4DiOdR9T0Ho2hvs62A1e7V+iQzUDCDVtnL5bVSRLeexKPpoXBXSWpv/mAIvwRwjQeGUQc53Yv9G+XtwT+Sc2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7+Y+IyxuvUwaTVWqKqR5ZVu8SXgJOu8FISN8WW4kes=;
 b=CV/FCVjlSHMohiXACvSZYSalQ8KbFgcMu2B27q/HNKAGftt/jwvAULiuC+6Z6GQlqFEKdvgeDInm7e9UmKg5QJdPlID2DhynpotTUitHzMQUV+7EJeUIbKSTl2uAGgm+y4Eh8Ic58md/LT4WMYJzhJMA3DsqGkl4CSmtkKGIALS43A2FTl27opKS2gU0xOPDMOzHgQsX4I+xr2biBw1L7/AnPVUcFJw2pOnBmaGYx6WhKoqyINMMG+WcmkJMkmwyv+6TPcYRyPzk6FKKHT1fmiXlsK1iifVPE+fG+auW38zv72zXv/icVql80uxqX72yKR+1x/Era1xDFFKCpzTZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7+Y+IyxuvUwaTVWqKqR5ZVu8SXgJOu8FISN8WW4kes=;
 b=Q1vZenuhir+fkuEx3Daztaj6Ed3iOpN3oYkm+QWYSZ2lOwZIFLG4CRd5mjhQU/xUx/wBtSZpb1diDqsOZD2V7Y8s+judsyZc3yJqpKrqh2vISgymMorbjk7qVh9bIssVGE+T2DLC+cztjmcI+yRErVzvL9erKHD82b5DzKUugWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 13:49:38 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 13:49:38 +0000
Content-Type: multipart/alternative;
 boundary="------------2VuBejBNwhiU0bKhkFrGlCzo"
Message-ID: <bb0fb1df-af73-8390-20e0-8d34078b6419@amd.com>
Date: Wed, 11 May 2022 09:49:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
 <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
 <549246A3-B326-47CC-92FD-608708E1876B@microsoft.com>
 <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
 <0d99be40-f6b9-b191-feca-d74344f03bf2@amd.com>
 <FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com>
 <66bf32d5-1636-ecdd-8a49-24c6254079bf@amd.com>
 <E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com>
 <15805b62-2e43-b469-0816-1083c5e76acd@amd.com>
 <E51808D5-5E34-420C-9CBD-F2BAE26E45F5@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <E51808D5-5E34-420C-9CBD-F2BAE26E45F5@microsoft.com>
X-ClientProxiedBy: MN2PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:208:237::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d97ef43-7eb8-46d3-a510-08da33551720
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6169:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6169A9F2D484B47388D7BC63EAC89@SJ1PR12MB6169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYDL9JBbktovpbEINtTyjX5k0tyi50GUfq7oWqC5ZB7HUyJtS6GfaM6WBwaZzSR1Z89/TBfNP7Q8iBo/fpZZHgNmYNToNEsgNfgW57h/Pj+pmo+eCcMxBW04oFhzOvRgNBdDLHh23f0ZVcqm3nlvfbHLG5DdLGD+T/DUITXXYEwH3GVco8SlFK4+whkr/54/vS4/5YDYtJO8eUwn6q6LOcbF/GhXqs30k+ngv6vXJXZ7G2lTi+xClHcdJK6Swflc/R93L9KsTLCbIHAYLL5DZI0bnsi/7sizecR3C3k0Xju50hJPFC3Kz6ivkJ1f+W98OqMbJnZwhWgUjY1MZkPc/hllAhGCcCd1AeJbL3aO9wKwNzS6Pefo7YhlEfPMSDjneTlVXe/ExENWfNaoAHlMgfHffLZoa4PGtOKKf3n0uzE/z4FUwxc8phwuwi5y70NSqR3sD4co181rbJhgItDJgH/sVOWcr8iMh5ZuOUyRjpIIn2Cp5GOIlE7odtMo5rO5Zdk47Da5jPilQPb10P8/8mCx0SAX+3c37BdjZlkVBsWN0dPuV3owxDEMsjHroThPpoyND1FUBS/azImYAuChTK/sY16p255ult2uaSIuQdcFEc3bi544bQSft5+vyf789f7S1Vq2vDAYENy7frABJ5wVD55SKj3Ahw/j16qiUXIbTKuuQc9uZDpEPQxlK48Ogt53SjyFdlo6aFMAieL15PfCdRzN3FgNz9XA3BUO6P7uhiWg5sf1CmBvPxhhUE5M3OjasDHTNVhN79S+npoC8C4LJ+MdDBRAxUUHADOtnGvH7ZEs6zbPOhRhiQJLDkWp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(2906002)(166002)(66556008)(6512007)(31686004)(31696002)(6486002)(36756003)(6666004)(508600001)(966005)(86362001)(316002)(30864003)(44832011)(8676002)(4326008)(6506007)(53546011)(33964004)(38100700002)(83380400001)(26005)(5660300002)(45080400002)(8936002)(110136005)(54906003)(186003)(2616005)(6636002)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJWZTFrQTBpM3pvODBmaUNwYWdwcFBjT2J2MUxaYTZMVU9PQjVOL0sybTZY?=
 =?utf-8?B?Q1dOTDZjSDBCdXQ5N2tsMnl6eTRmTnRDbGkwdEgxbVFrNGo2Z3llZlhXdG1L?=
 =?utf-8?B?T1VrZzdCaE1CWWVmZmhFZml3QlU1bnlqVWtrVE5hazZmVG1Cd1MvZFE2ZG0r?=
 =?utf-8?B?dUpwNDFOS1RYdXZaS29QUTVaQmN6VkU1Wm51UVAxTjhXbDF0Mm1rQ0VaNllx?=
 =?utf-8?B?NjVJMHZoMXFzVEluL2U0N2xFMHJIdEprb1h5Mjh1c3JzRFE5N0M5KzllQlhr?=
 =?utf-8?B?Q1ZsMkEvUzNqejFsTTd4NGF1V0FWRjVDOHlDRWtudGtmR0kwdHB6QXhVMldk?=
 =?utf-8?B?d1ZhbkxhVUJ2ck11OTllbzczZFQ5YnlTT2h2cTdublR5bkErNHBZMWpjdmxm?=
 =?utf-8?B?K3V2d1lNZGoxNHZSMHlyclRjNm5OZHFXR1hKMkpZVVpzbENuOVlVT0M4NUg4?=
 =?utf-8?B?Q2R6ZkVmWGJNUjlyQThqR1VtTzZNZlg2NFVGZ1I1QWhDL3Y3MGNxN3pvc2pG?=
 =?utf-8?B?RmhvdzJHOU5WUDZoeU5wT0JZZU5STFJtSGUxOFBaczVpOWZlcUpjRVFWdkgx?=
 =?utf-8?B?YmtUeEdMdGhqNHNzQ2dBUTkrWC96c3ZFYmJyRlVCSExkZFdsZm1rTnhnVE1J?=
 =?utf-8?B?akgxMkNlNG1pR3lYeUlNNDNsVmpRb1I2RWszT25QQWVySElMVVZackp1ckk3?=
 =?utf-8?B?eGxZbGtwbkV4RzBlVXNQZTM1d2JBM0JnaG82RjROMldBRFZmY3lVTHJFc0VC?=
 =?utf-8?B?a0RHQWpXTHFhUlByTDRJOVFuWFhodEk4bGp1RUZ5bW1pUGxiV2RQdExoRjRu?=
 =?utf-8?B?QUFOV2tHU1NJSXg5TXVpRkUwT3FEU0I5VzY2VjVHeFdnQ0N4NjloQ25WK0hz?=
 =?utf-8?B?NGFlTm5yRjlDM1gvZG9pK2VFSFhHQk9GaHBOS21WL3g5azBJMExaWmhLNy84?=
 =?utf-8?B?Q01STlFmV2JSM2tYQkpRVWVZSmpQOXJFUEhXYUd6QzZqMFhKZThNZSt0Ymxx?=
 =?utf-8?B?VTRQVmRTZW1Qb1M1VDB3Zzl6S2x6cTM0Vk9mNmxaKzVxRkczc2ZFdUJva0E2?=
 =?utf-8?B?aHE4SjNiTFhlM2d3MnZhbW9FTE1MeTdqOUdDVkFhakZnZUdHMVhPWm1kRWc1?=
 =?utf-8?B?VTh6UWZnU3ZVUlBkcHFNV2FZUEllTE14OVNRL251S29zN2xuM3dvbE1BRURC?=
 =?utf-8?B?Mm9wWFZuR1k1Q1E4d25tY1l4THJKSTI2V2x6K3VBOW5tMkN6ekxpUlRWWG1V?=
 =?utf-8?B?bkpCY1FzWjlraE54YVIrbWJhWUdBME1ramFVUmdQakdNaUVYWjk3MlZsOUE2?=
 =?utf-8?B?RWhMUnRxb2JZOWNEaWovSGJoRy96b3RJVUdmQWFLeXRydkNWcUJOaGJMYXI2?=
 =?utf-8?B?WmpkOUtGN3VZdy9KL005SWtGSUM1UnNLcVNFeTVZQlRXZWVaaVJ6TGlBN0Ju?=
 =?utf-8?B?OUtiTUlYVVEvZmQ4S1ZwUjN6VlRJT0t6bmRUKzd1VzEvSGZmeThDVXdpNytG?=
 =?utf-8?B?eEVTQjJMNEtuQUh5ZGtsTTYySEpOK3dRWnIraG4zenhFUmIzcTljS1RwSWZ1?=
 =?utf-8?B?Szgwd21wZjVmVDNEY3grVXlRdDBlQzE4N2MyK1BhcE1JUDgvRWZDUWdwUHNO?=
 =?utf-8?B?SUZ4V0JXZ0k0NlRNMFRBMDNYVU41eEN4NDlnTjhsL2YydFBDaUdOc0x4dlRv?=
 =?utf-8?B?bUZvUmkzRWxwbEJHRXpmZkFSWjVldG1XdElpd0Y4L00vRzdEdHdXYlNtN3hF?=
 =?utf-8?B?QVptOVM4MVFwOVFVcTEzdzd0WXE5WUh0eUxMVEwzMDUxSkF5L0swT2I2TFhq?=
 =?utf-8?B?dDZUYk9wTlVBQVJPemFnZEJhWUlhN0xLM3p0M2RwZS9BVVY3bUpNQkNNNHE5?=
 =?utf-8?B?OC9XdDRyNFdDWVVtS2xkQ2M5aVIrcVdwZUhZYVhsbTF6KytCWjNrSFhCMDZD?=
 =?utf-8?B?aWtCd0l5OTdUZVllVGdCSVhuQ09PV3UxODZ4cHkrN3ludVdTczF2RWo4cVk0?=
 =?utf-8?B?RkFWU2R3RHVhOGJDS3pTU2ZDSjY5aEc5cEFibkFoUklvRTQwNXE5ZU9RNThG?=
 =?utf-8?B?WTdMbXcyL3FXNlBPODFSVS9ZTStpZnRQenBJeXlrOFBxb21KZDRuWDFVWnJ5?=
 =?utf-8?B?NlRtOUwrQVdMc2c4WktEbE5FSE1TMHF1SmlCRjJsTVNVRWduMmduRVcwUGZr?=
 =?utf-8?B?QVM1R3Y2dWxkVjd5UXBPQm12WDNndGFwVEJkYlhaVWJEMTh2c3paVGdydU9J?=
 =?utf-8?B?WC9hUWtVaEZTdmlMSEllRlFUYXVzV2xqNGsvN01pRTYxaExlYVczQzJxQ0d0?=
 =?utf-8?B?Z2E3WCsrSFlDd0JpODREb2lBSnR6YmZYLzBlTGVlcGRIWVRwSFFZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d97ef43-7eb8-46d3-a510-08da33551720
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 13:49:38.1786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87cuIK2xtPs7HZLMOH9FoCfOZA4SR482MEzUvaGbGqDnKpQM311AhaWybh5wsEtbhrlsZUpQ8zKhyy1pqGighQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>,
 Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------2VuBejBNwhiU0bKhkFrGlCzo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-05-10 23:35, Shuotao Xu wrote:
>
>
>> On May 11, 2022, at 4:31 AM, Felix Kuehling <felix.kuehling@amd.com> 
>> wrote:
>>
>> [Some people who received this message don't often get email 
>> fromfelix.kuehling@amd.com. Learn why this is important 
>> athttps://aka.ms/LearnAboutSenderIdentification.]
>>
>> Am 2022-05-10 um 07:03 schrieb Shuotao Xu:
>>>
>>>
>>>> On Apr 28, 2022, at 12:04 AM, Andrey Grodzovsky
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>> On 2022-04-27 05:20, Shuotao Xu wrote:
>>>>
>>>>> Hi Andrey,
>>>>>
>>>>> Sorry that I did not have time to work on this for a few days.
>>>>>
>>>>> I just tried the sysfs crash fix on Radeon VII and it seems that it
>>>>> worked. It did not pass last the hotplug test, but my version has 4
>>>>> tests instead of 3 in your case.
>>>>
>>>>
>>>> That because the 4th one is only enabled when here are 2 cards in the
>>>> system - to test DRI_PRIME export. I tested this time with only one 
>>>> card.
>>>>
>>> Yes, I only had one Radeon VII in my system, so this 4th test should
>>> have been skipped. I am ignoring this issue.
>>>
>>>>>
>>>>>
>>>>> Suite: Hotunplug Tests
>>>>> Test: Unplug card and rescan the bus to plug it back
>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>> passed
>>>>> Test: Same as first test but with command submission
>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>> passed
>>>>> Test: Unplug with exported bo
>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>> passed
>>>>> Test: Unplug with exported fence
>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>> amdgpu_device_initialize: amdgpu_get_auth (1) failed (-1)
>>>>
>>>>
>>>> on the kernel side - the IOCTlL returning this is drm_getclient -
>>>> maybe take a look while it can't find client it ? I didn't have such
>>>> issue as far as I remember when testing.
>>>>
>>>>
>>>>> FAILED
>>>>> 1. ../tests/amdgpu/hotunplug_tests.c:368 - CU_ASSERT_EQUAL(r,0)
>>>>> 2. ../tests/amdgpu/hotunplug_tests.c:411 -
>>>>> CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2, shared_fd,
>>>>> &sync_obj_handle2),0)
>>>>> 3. ../tests/amdgpu/hotunplug_tests.c:423 -
>>>>> CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2, &sync_obj_handle2,
>>>>> 1, 100000000, 0, NULL),0)
>>>>> 4. ../tests/amdgpu/hotunplug_tests.c:425 -
>>>>> CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2, 
>>>>> sync_obj_handle2),0)
>>>>>
>>>>> Run Summary: Type Total Ran Passed Failed Inactive
>>>>> suites 14 1 n/a 0 0
>>>>> tests 71 4 3 1 0
>>>>> asserts 39 39 35 4 n/a
>>>>>
>>>>> Elapsed time = 17.321 seconds
>>>>>
>>>>> For kfd compute, there is some problem which I did not see in MI100
>>>>> after I killed the hung application after hot plugout. I was using
>>>>> rocm5.0.2 driver for MI100 card, and not sure if it is a regression
>>>>> from the newer driver.
>>>>> After pkill, one of child of user process would be stuck in Zombie
>>>>> mode (Z) understandably because of the bug, and future rocm
>>>>> application after plug-back would in uninterrupted sleep mode (D)
>>>>> because it would not return from syscall to kfd.
>>>>>
>>>>> Although drm test for amdgpu would run just fine without issues
>>>>> after plug-back with dangling kfd state.
>>>>
>>>>
>>>> I am not clear when the crash bellow happens ? Is it related to what
>>>> you describe above ?
>>>>
>>>>
>>>>>
>>>>> I don’t know if there is a quick fix to it. I was thinking add
>>>>> drm_enter/drm_exit to amdgpu_device_rreg.
>>>>
>>>>
>>>> Try adding drm_dev_enter/exit pair at the highest level of attmetong
>>>> to access HW - in this case it's amdgpu_amdkfd_set_compute_idle. We
>>>> always try to avoid accessing any HW functions after backing device
>>>> is gone.
>>>>
>>>>
>>>>> Also this has been a long time in my attempt to fix hotplug issue
>>>>> for kfd application.
>>>>> I don’t know 1) if I would be able to get to MI100 (fixing Radeon
>>>>> VII would mean something but MI100 is more important for us); 2)
>>>>> what the direct of the patch to this issue will move forward.
>>>>
>>>>
>>>> I will go to office tomorrow to pick up MI-100, With time and
>>>> priorities permitting I will then then try to test it and fix any
>>>> bugs such that it will be passing all hot plug libdrm tests at the
>>>> tip of public amd-staging-drm-next
>>>> -https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4 
>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&data=05%7C01%7Candrey.grodzovsky%40amd.com%7C23750571b50a4c2e434508da32ff5720%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637878369526441445%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=Ub4jMSDBchMgrgzlDu1vMiNypFnsfN%2FcPuZgqa7ZJk8%3D&reserved=0>%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uzuHL2YOs2e5IDmJTfyC7y44mLVLhvod9jC9s0QMXww%3D&amp;reserved=0, 
>>>> after that you can try
>>>> to continue working with ROCm enabling on top of that.
>>>>
>>>> For now i suggest you move on with Radeon 7 which as your development
>>>> ASIC and use the fix i mentioned above.
>>>>
>>> I finally got some time to continue on kfd hotplug patch attempt.
>>> The following patch seems to work for kfd hotplug on Radeon VII. After
>>> hot plugout, the tf process exists because of vm fault.
>>> A new tf process run without issues after plugback.
>>>
>>> It has the following fixes.
>>>
>>> 1. ras sysfs regression;
>>> 2. skip setting compute idle after dev is plugged, otherwise it will
>>>    try to write the pci bar thus driver fault
>>> 3. stops the actual work of invalidate memory map triggered by
>>>    useptrs; (return false will trigger warning, so I returned true.
>>>    Not sure if it is correct)
>>> 4. It sends exceptions to all the events/signal that a “zombie”
>>>    process that are waiting for. (Not sure if the hw_exception is
>>>    worthwhile, it did not do anything in my case since there is such
>>>    event type associated with that process)
>>>
>>> Please take a look and let me know if it acceptable.
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 1f8161cd507f..2f7858692067 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -33,6 +33,7 @@
>>> #include <uapi/linux/kfd_ioctl.h>
>>> #include "amdgpu_ras.h"
>>> #include "amdgpu_umc.h"
>>> +#include <drm/drm_drv.h>
>>>
>>> /* Total memory size in system memory and all GPU VRAM. Used to
>>>  * estimate worst case amount of memory to reserve for page tables
>>> @@ -681,9 +682,10 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device
>>> *adev,
>>>
>>> void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool
>>> idle)
>>> {
>>> -       amdgpu_dpm_switch_power_profile(adev,
>>> - PP_SMC_POWER_PROFILE_COMPUTE,
>>> -                                       !idle);
>>> +       if (!drm_dev_is_unplugged(adev_to_drm(adev)))
>>> +               amdgpu_dpm_switch_power_profile(adev,
>>> + PP_SMC_POWER_PROFILE_COMPUTE,
>>> +                                               !idle);
>>> }
>>>
>>> bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> index 4b153daf283d..fb4c9e55eace 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> @@ -46,6 +46,7 @@
>>> #include <linux/firmware.h>
>>> #include <linux/module.h>
>>> #include <drm/drm.h>
>>> +#include <drm/drm_drv.h>
>>>
>>> #include "amdgpu.h"
>>> #include "amdgpu_amdkfd.h"
>>> @@ -104,6 +105,9 @@ static bool amdgpu_mn_invalidate_hsa(struct
>>> mmu_interval_notifier *mni,
>>>        struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo,
>>> notifier);
>>>        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>
>>> +       if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>> +               return true;
>>> +
> Label: Fix 3
>>>        if (!mmu_notifier_range_blockable(range))
>>>                return false;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index cac56f830aed..fbbaaabf3a67 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -1509,7 +1509,6 @@ static int amdgpu_ras_fs_fini(struct
>>> amdgpu_device *adev)
>>>                }
>>>        }
>>>
>>> -       amdgpu_ras_sysfs_remove_all(adev);
>>>        return 0;
>>> }
>>> /* ras fs end */
>>> @@ -2557,8 +2556,6 @@ void amdgpu_ras_block_late_fini(struct
>>> amdgpu_device *adev,
>>>        if (!ras_block)
>>>                return;
>>>
>>> -       amdgpu_ras_sysfs_remove(adev, ras_block);
>>> -
>>>        ras_obj = container_of(ras_block, struct
>>> amdgpu_ras_block_object, ras_comm);
>>>        if (ras_obj->ras_cb)
>>>                amdgpu_ras_interrupt_remove_handler(adev, ras_block);
>>> @@ -2659,6 +2656,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device 
>>> *adev)
>>>        /* Need disable ras on all IPs here before ip [hw/sw]fini */
>>>        amdgpu_ras_disable_all_features(adev, 0);
>>>        amdgpu_ras_recovery_fini(adev);
>>> +       amdgpu_ras_sysfs_remove_all(adev);
>>>        return 0;
>>> }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index f1a225a20719..4b789bec9670 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -714,16 +714,37 @@ bool kfd_is_locked(void)
>>>
>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>> {
>>> +       struct kfd_process *p;
>>> +       struct amdkfd_process_info *p_info;
>>> +       unsigned int temp;
>>> +
>>>        if (!kfd->init_complete)
>>>                return;
>>>
>>>        /* for runtime suspend, skip locking kfd */
>>> -       if (!run_pm) {
>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>                /* For first KFD device suspend all the KFD processes */
>>>                if (atomic_inc_return(&kfd_locked) == 1)
>>>                        kfd_suspend_all_processes();
>>>        }
>>>
>>> +       if (drm_dev_is_unplugged(kfd->ddev)){
>>> +               int idx = srcu_read_lock(&kfd_processes_srcu);
>>> +               pr_debug("cancel restore_userptr_work\n");
>>> +               hash_for_each_rcu(kfd_processes_table, temp, p,
>>> kfd_processes) {
>>> +                       if (kfd_process_gpuidx_from_gpuid(p, kfd->id)
>>> >= 0) {
>>> +                               p_info = p->kgd_process_info;
>>> +                               pr_debug("cancel processes, pid = %d
>>> for gpu_id = %d", pid_nr(p_info->pid), kfd->id);
>>> + cancel_delayed_work_sync(&p_info->restore_userptr_work);
>>
>> Is this really necessary? If it is, there are probably other workers,
>> e.g. related to our SVM code, that would need to be canceled as well.
>>
>
> I delete this and it seems to be OK. It was previously added to 
> suppress restore_useptr_work which keeps updating PTE.
> Now this is gone by Fix 3. Please let us know if it is OK:) @Felix
>
>>
>>> +
>>> + /* send exception signals to the kfd
>>> events waiting in user space */
>>> + kfd_signal_hw_exception_event(p->pasid);
>>
>> This makes sense. It basically tells user mode that the application's
>> GPU state is lost due to a RAS error or a GPU reset, or now a GPU
>> hot-unplug.
>
> The problem is that it cannot find an event with a type that matches 
> HW_EXCEPTION_TYPE so it does **nothing** from the driver with the 
> default parameter value of send_sigterm = false;
> After all, if a “zombie” process (zombie in the sense it does not have 
> a GPU dev) does not exit, kfd resources seems not been released 
> properly and new kfd process cannot run after plug back.
> (I still need to look hard into rocr/hsakmt/kfd driver code to 
> understand the reason. At least I am seeing that the kfd topology 
> won’t be cleaned up without process exiting, so that there would be a 
> “zombie" kfd node in the topology, which may or may not cause issues 
> in hsakmt).
> @Felix Do you have suggestion/insight on this “zombie" process issue? 
> @Andrey suggests it should be OK to have a “zombie” kfd process and a 
> “zombie” kfd dev, and the new kfd process should be ok to run on the 
> new kfd dev after plugback.


My experience with the graphic stack at least showed that. At least in a 
setup with 2 GPUs, if i remove a secondary GPU which had a rendering 
process on it, I could plug back the secondary GPU and start a new 
rendering process while the old zombie process was still present. It 
could be that in KFD case there are some obstacles to this that need to 
be resolved.

Andrey


>
> May 11 09:52:07 NETSYS26 kernel: [52604.845400] amdgpu: cancel 
> restore_userptr_work
> May 11 09:52:07 NETSYS26 kernel: [52604.845405] amdgpu: sending hw 
> exception to pasid = 0x800
> May 11 09:52:07 NETSYS26 kernel: [52604.845414] kfd kfd: amdgpu: 
> Process 25894 (pasid 0x8001) got unhandled exception
>
>>
>>
>>> + kfd_signal_vm_fault_event(kfd, p->pasid, NULL);
>>
>> This does not make sense. A VM fault indicates an access to a bad
>> virtual address by the GPU. If a debugger is attached to the process, it
>> notifies the debugger to investigate what went wrong. If the GPU is
>> gone, that doesn't make any sense. There is no GPU that could have
>> issued a bad memory request. And the debugger won't be happy either to
>> find a VM fault from a GPU that doesn't exist any more.
>
> OK understood.
>
>>
>> If the HW-exception event doesn't terminate your process, we may need to
>> look into how ROCr handles the HW-exception events.
>>
>>
>>> + }
>>> + }
>>> + srcu_read_unlock(&kfd_processes_srcu, idx);
>>> + }
>>> +
>>> kfd->dqm->ops.stop(kfd->dqm);
>>> kfd_iommu_suspend(kfd);
>>
>> Should DQM stop and IOMMU suspend still be executed? Or should the
>> hot-unplug case short-circuit them?
>
> I tried short circuiting them, but would later caused BUG related to 
> GPU reset. I added the following that solve the issue on plugout.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b583026dc893..d78a06d74759 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5317,7 +5317,8 @@ static void 
> amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
>  {
>         struct amdgpu_recover_work_struct *recover_work = 
> container_of(work, struct amdgpu_recover_work_struct, base);
>
> -       recover_work->ret = 
> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
> +       if (!drm_dev_is_unplugged(adev_to_drm(recover_work->adev)))
> +               recover_work->ret = 
> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>  }
>  /*
>   * Serialize gpu recover into reset domain single threaded wq
>
> However after kill the zombie process, it failed to evict queues of 
> the process.
>
> [  +0.000002] amdgpu: writing 263 to doorbell address 00000000c86e63f2
> [  +9.002503] amdgpu: qcm fence wait loop timeout expired
> [  +0.001364] amdgpu: The cp might be in an unrecoverable state due to 
> an unsuccessful queues preemption
> [  +0.001343] amdgpu: Failed to evict process queues
> [  +0.001355] amdgpu: Failed to evict queues of pasid 0x8001
>
>
> This would cause driver BUG triggered by new kfd process after 
> plugback. I am pasting the errors from dmesg after plugback as below.
>
>
>
> May 11 10:25:16 NETSYS26 kernel: [  688.445332] amdgpu: Evicting PASID 
> 0x8001 queues
> May 11 10:25:16 NETSYS26 kernel: [  688.445359] BUG: unable to handle 
> page fault for address: 000000020000006e
> May 11 10:25:16 NETSYS26 kernel: [  688.447516] #PF: supervisor read 
> access in kernel mode
> May 11 10:25:16 NETSYS26 kernel: [  688.449627] #PF: 
> error_code(0x0000) - not-present page
> May 11 10:25:16 NETSYS26 kernel: [  688.451661] PGD 80000020892a8067 
> P4D 80000020892a8067 PUD 0
> May 11 10:25:16 NETSYS26 kernel: [  688.453741] Oops: 0000 [#1] 
> PREEMPT SMP PTI
> May 11 10:25:16 NETSYS26 kernel: [  688.455904] CPU: 25 PID: 9236 
> Comm: tf_cnn_benchmar Tainted: G        W  OE 5.16.0+ #3
> May 11 10:25:16 NETSYS26 kernel: [  688.457406] amdgpu 0000:05:00.0: 
> amdgpu: GPU reset begin!
> May 11 10:25:16 NETSYS26 kernel: [  688.457798] Hardware name: Dell 
> Inc. PowerEdge R730/0H21J3, BIOS 1.5.4 [FPGA Test BIOS] 10/002/2015
> May 11 10:25:16 NETSYS26 kernel: [  688.461458] RIP: 
> 0010:evict_process_queues_cpsch+0x99/0x1b0 [amdgpu]
> May 11 10:25:16 NETSYS26 kernel: [  688.465238] Code: bd 13 8a dd 85 
> c0 0f 85 13 01 00 00 49 8b 5f 10 4d 8d 77 10 49 39 de 75 11 e9 8d 00 
> 00 00 48 8b 1b 4c 39 f3 0f 84 81 00 00 00 <80> 7b 6e 00 c6 43 6d 01 74 
> ea c6 43 6e 00 41 83 ac 24 70 01 00 00
> May 11 10:25:16 NETSYS26 kernel: [  688.470516] RSP: 
> 0018:ffffb2674c8afbf0 EFLAGS: 00010203
> May 11 10:25:16 NETSYS26 kernel: [  688.473255] RAX: ffff91c65cca3800 
> RBX: 0000000200000000 RCX: 0000000000000001
> May 11 10:25:16 NETSYS26 kernel: [  688.475691] RDX: 0000000000000000 
> RSI: ffffffff9fb712d9 RDI: 00000000ffffffff
> May 11 10:25:16 NETSYS26 kernel: [  688.478564] RBP: ffffb2674c8afc20 
> R08: 0000000000000000 R09: 000000000006ba18
> May 11 10:25:16 NETSYS26 kernel: [  688.481409] R10: 00007fe5a0000000 
> R11: ffffb2674c8af918 R12: ffff91c66d6f5800
> May 11 10:25:16 NETSYS26 kernel: [  688.484254] R13: ffff91c66d6f5938 
> R14: ffff91e5c71ac820 R15: ffff91e5c71ac810
> May 11 10:25:16 NETSYS26 kernel: [  688.487184] FS: 
>  00007fe62124a700(0000) GS:ffff92053fd00000(0000) knlGS:0000000000000000
> May 11 10:25:16 NETSYS26 kernel: [  688.490308] CS:  0010 DS: 0000 ES: 
> 0000 CR0: 0000000080050033
> May 11 10:25:16 NETSYS26 kernel: [  688.493122] CR2: 000000020000006e 
> CR3: 0000002095284004 CR4: 00000000001706e0
> May 11 10:25:16 NETSYS26 kernel: [  688.496142] Call Trace:
> May 11 10:25:16 NETSYS26 kernel: [  688.499199]  <TASK>
> May 11 10:25:16 NETSYS26 kernel: [  688.502261] 
>  kfd_process_evict_queues+0x43/0xf0 [amdgpu]
> May 11 10:25:16 NETSYS26 kernel: [  688.506378] 
>  kgd2kfd_quiesce_mm+0x2a/0x60 [amdgpu]
> May 11 10:25:16 NETSYS26 kernel: [  688.510539] 
>  amdgpu_amdkfd_evict_userptr+0x46/0x80 [amdgpu]
> May 11 10:25:16 NETSYS26 kernel: [  688.514110] 
>  amdgpu_mn_invalidate_hsa+0x9c/0xb0 [amdgpu]
> May 11 10:25:16 NETSYS26 kernel: [  688.518247] 
>  __mmu_notifier_invalidate_range_start+0x136/0x1e0
> May 11 10:25:16 NETSYS26 kernel: [  688.521252] 
>  change_protection+0x41d/0xcd0
> May 11 10:25:16 NETSYS26 kernel: [  688.524310] 
>  change_prot_numa+0x19/0x30
> May 11 10:25:16 NETSYS26 kernel: [  688.527366] 
>  task_numa_work+0x1ca/0x330
> May 11 10:25:16 NETSYS26 kernel: [  688.530157]  task_work_run+0x6c/0xa0
> May 11 10:25:16 NETSYS26 kernel: [  688.533124] 
>  exit_to_user_mode_prepare+0x1af/0x1c0
> May 11 10:25:16 NETSYS26 kernel: [  688.536058] 
>  syscall_exit_to_user_mode+0x2a/0x40
> May 11 10:25:16 NETSYS26 kernel: [  688.538989]  do_syscall_64+0x46/0xb0
> May 11 10:25:16 NETSYS26 kernel: [  688.541830] 
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> May 11 10:25:16 NETSYS26 kernel: [  688.544701] RIP: 0033:0x7fe6585ec317
> May 11 10:25:16 NETSYS26 kernel: [  688.547297] Code: b3 66 90 48 8b 
> 05 71 4b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 
> 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 
> 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
> May 11 10:25:16 NETSYS26 kernel: [  688.553183] RSP: 
> 002b:00007fe6212494c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> May 11 10:25:16 NETSYS26 kernel: [  688.556105] RAX: ffffffffffffffc2 
> RBX: 0000000000000000 RCX: 00007fe6585ec317
> May 11 10:25:16 NETSYS26 kernel: [  688.558970] RDX: 00007fe621249540 
> RSI: 00000000c0584b02 RDI: 0000000000000003
> May 11 10:25:16 NETSYS26 kernel: [  688.561950] RBP: 00007fe621249540 
> R08: 0000000000000000 R09: 0000000000040000
> May 11 10:25:16 NETSYS26 kernel: [  688.564563] R10: 00007fe617480000 
> R11: 0000000000000246 R12: 00000000c0584b02
> May 11 10:25:16 NETSYS26 kernel: [  688.567494] R13: 0000000000000003 
> R14: 0000000000000064 R15: 00007fe621249920
> May 11 10:25:16 NETSYS26 kernel: [  688.570470]  </TASK>
> May 11 10:25:16 NETSYS26 kernel: [  688.573380] Modules linked in: 
> amdgpu(OE) veth nf_conntrack_netlink nfnetlink xfrm_user xt_addrtype 
> br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat 
> nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
> ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter 
> ebtables ip6table_filter ip6_tables iptable_filter overlay 
> esp6_offload esp6 esp4_offload esp4 xfrm_algo intel_rapl_msr 
> intel_rapl_common sb_edac snd_hda_codec_hdmi x86_pkg_temp_thermal 
> snd_hda_intel intel_powerclamp snd_intel_dspcfg ipmi_ssif coretemp 
> snd_hda_codec kvm_intel snd_hda_core snd_hwdep kvm snd_pcm snd_timer 
> snd soundcore ftdi_sio irqbypass rapl intel_cstate usbserial joydev 
> mei_me input_leds mei iTCO_wdt iTCO_vendor_support lpc_ich ipmi_si 
> ipmi_devintf mac_hid acpi_power_meter ipmi_msghandler sch_fq_codel 
> ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi 
> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic 
> zstd_compress raid10 raid456
> May 11 10:25:16 NETSYS26 kernel: [  688.573543]  async_raid6_recov 
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 
> raid0 multipath linear iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm 
> drm_shmem_helper drm_kms_helper syscopyarea hid_generic 
> crct10dif_pclmul crc32_pclmul sysfillrect ghash_clmulni_intel 
> sysimgblt fb_sys_fops uas usbhid aesni_intel crypto_simd igb ahci hid 
> drm usb_storage cryptd libahci dca megaraid_sas i2c_algo_bit wmi [last 
> unloaded: amdgpu]
> May 11 10:25:16 NETSYS26 kernel: [  688.611083] CR2: 000000020000006e
> May 11 10:25:16 NETSYS26 kernel: [  688.614454] ---[ end trace 
> 349cf28efb6268bc ]—
>
> Looking forward to the comments.
>
> Regards,
> Shuotao
>
>>
>> Regards,
>> Felix
>>
>>
>>> }
>>>
>>> Regards,
>>> Shuotao
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Shuotao
>>>>>
>>>>> [  +0.001645] BUG: unable to handle page fault for address:
>>>>> 0000000000058a68
>>>>> [  +0.001298] #PF: supervisor read access in kernel mode
>>>>> [  +0.001252] #PF: error_code(0x0000) - not-present page
>>>>> [  +0.001248] PGD 8000000115806067 P4D 8000000115806067 PUD
>>>>> 109b2d067 PMD 0
>>>>> [  +0.001270] Oops: 0000 [#1] PREEMPT SMP PTI
>>>>> [  +0.001256] CPU: 5 PID: 13818 Comm: tf_cnn_benchmar Tainted: G
>>>>>   W   E     5.16.0+ #3
>>>>> [  +0.001290] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS
>>>>> 1.5.4 [FPGA Test BIOS] 10/002/2015
>>>>> [  +0.001309] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>>>> [  +0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f
>>>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0
>>>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c
>>>>> 2e ca 85
>>>>> [  +0.002751] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>>>> [  +0.001388] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX:
>>>>> 00000000ffffffff
>>>>> [  +0.001402] RDX: 0000000000000000 RSI: 000000000001629a RDI:
>>>>> ffff8b0c9c840000
>>>>> [  +0.001418] RBP: ffffb58fac313948 R08: 0000000000000021 R09:
>>>>> 0000000000000001
>>>>> [  +0.001421] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12:
>>>>> 0000000000058a68
>>>>> [  +0.001400] R13: 000000000001629a R14: 0000000000000000 R15:
>>>>> 000000000001629a
>>>>> [  +0.001397] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000)
>>>>> knlGS:0000000000000000
>>>>> [  +0.001411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  +0.001405] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4:
>>>>> 00000000001706e0
>>>>> [  +0.001422] Call Trace:
>>>>> [  +0.001407]  <TASK>
>>>>> [  +0.001391]  amdgpu_device_rreg+0x17/0x20 [amdgpu]
>>>>> [  +0.001614]  amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
>>>>> [  +0.001735]  phm_wait_for_register_unequal.part.1+0x58/0x90 [amdgpu]
>>>>> [  +0.001790]  phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]
>>>>> [  +0.001800]  vega20_wait_for_response+0x28/0x80 [amdgpu]
>>>>> [  +0.001757]  vega20_send_msg_to_smc_with_parameter+0x21/0x110 
>>>>> [amdgpu]
>>>>> [  +0.001838]  smum_send_msg_to_smc_with_parameter+0xcd/0x100 [amdgpu]
>>>>> [  +0.001829]  ? kvfree+0x1e/0x30
>>>>> [  +0.001462]  vega20_set_power_profile_mode+0x58/0x330 [amdgpu]
>>>>> [  +0.001868]  ? kvfree+0x1e/0x30
>>>>> [  +0.001462]  ? ttm_bo_release+0x261/0x370 [ttm]
>>>>> [  +0.001467]  pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]
>>>>> [  +0.001863]  amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]
>>>>> [  +0.001866]  amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]
>>>>> [  +0.001784]  kfd_dec_compute_active+0x2c/0x50 [amdgpu]
>>>>> [  +0.001744]  process_termination_cpsch+0x2f9/0x3a0 [amdgpu]
>>>>> [  +0.001728]  kfd_process_dequeue_from_all_devices+0x49/0x70 [amdgpu]
>>>>> [  +0.001730]  kfd_process_notifier_release+0x91/0xe0 [amdgpu]
>>>>> [  +0.001718]  __mmu_notifier_release+0x77/0x1f0
>>>>> [  +0.001411]  exit_mmap+0x1b5/0x200
>>>>> [  +0.001396]  ? __switch_to+0x12d/0x3e0
>>>>> [  +0.001388]  ? __switch_to_asm+0x36/0x70
>>>>> [  +0.001372]  ? preempt_count_add+0x74/0xc0
>>>>> [  +0.001364]  mmput+0x57/0x110
>>>>> [  +0.001349]  do_exit+0x33d/0xc20
>>>>> [  +0.001337]  ? _raw_spin_unlock+0x1a/0x30
>>>>> [  +0.001346]  do_group_exit+0x43/0xa0
>>>>> [  +0.001341]  get_signal+0x131/0x920
>>>>> [  +0.001295]  arch_do_signal_or_restart+0xb1/0x870
>>>>> [  +0.001303]  ? do_futex+0x125/0x190
>>>>> [  +0.001285]  exit_to_user_mode_prepare+0xb1/0x1c0
>>>>> [  +0.001282]  syscall_exit_to_user_mode+0x2a/0x40
>>>>> [  +0.001264]  do_syscall_64+0x46/0xb0
>>>>> [  +0.001236]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> [  +0.001219] RIP: 0033:0x7f6aff1d2ad3
>>>>> [  +0.001177] Code: Unable to access opcode bytes at RIP 
>>>>> 0x7f6aff1d2aa9.
>>>>> [  +0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS: 00000246 ORIG_RAX:
>>>>> 00000000000000ca
>>>>> [  +0.001170] RAX: fffffffffffffe00 RBX: 0000000004f542b0 RCX:
>>>>> 00007f6aff1d2ad3
>>>>> [  +0.001168] RDX: 0000000000000000 RSI: 0000000000000080 RDI:
>>>>> 0000000004f542d8
>>>>> [  +0.001162] RBP: 0000000004f542d4 R08: 0000000000000000 R09:
>>>>> 0000000000000000
>>>>> [  +0.001152] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>>> 0000000004f542d8
>>>>> [  +0.001176] R13: 0000000000000000 R14: 0000000004f54288 R15:
>>>>> 0000000000000000
>>>>> [  +0.001152]  </TASK>
>>>>> [  +0.001113] Modules linked in: veth amdgpu(E) nf_conntrack_netlink
>>>>> nfnetlink xfrm_user xt_addrtype br_netfilter xt_CHECKSUM
>>>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4
>>>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
>>>>> ip6_tables iptable_filter overlay esp6_offload esp6 esp4_offload
>>>>> esp4 xfrm_algo intel_rapl_msr intel_rapl_common sb_edac
>>>>> x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi
>>>>> snd_hda_intel ipmi_ssif snd_intel_dspcfg coretemp snd_hda_codec
>>>>> kvm_intel snd_hda_core snd_hwdep snd_pcm snd_timer snd kvm soundcore
>>>>> irqbypass ftdi_sio usbserial input_leds iTCO_wdt iTCO_vendor_support
>>>>> joydev mei_me rapl lpc_ich intel_cstate mei ipmi_si ipmi_devintf
>>>>> ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel ib_iser
>>>>> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
>>>>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs
>>>>> blake2b_generic zstd_compress raid10 raid456
>>>>> [  +0.000102]  async_raid6_recov async_memcpy async_pq async_xor
>>>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
>>>>> iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper
>>>>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
>>>>> crct10dif_pclmul hid_generic crc32_pclmul ghash_clmulni_intel usbhid
>>>>> uas aesni_intel crypto_simd igb ahci hid drm usb_storage cryptd
>>>>> libahci dca megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]
>>>>> [  +0.016626] CR2: 0000000000058a68
>>>>> [  +0.001550] ---[ end trace ff90849fe0a8b3b4 ]---
>>>>> [  +0.024953] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>>>> [  +0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f
>>>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0
>>>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c
>>>>> 2e ca 85
>>>>> [  +0.003255] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>>>> [  +0.001641] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX:
>>>>> 00000000ffffffff
>>>>> [  +0.001656] RDX: 0000000000000000 RSI: 000000000001629a RDI:
>>>>> ffff8b0c9c840000
>>>>> [  +0.001681] RBP: ffffb58fac313948 R08: 0000000000000021 R09:
>>>>> 0000000000000001
>>>>> [  +0.001662] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12:
>>>>> 0000000000058a68
>>>>> [  +0.001650] R13: 000000000001629a R14: 0000000000000000 R15:
>>>>> 000000000001629a
>>>>> [  +0.001648] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000)
>>>>> knlGS:0000000000000000
>>>>> [  +0.001668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  +0.001673] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4:
>>>>> 00000000001706e0
>>>>> [  +0.001740] Fixing recursive fault but reboot is needed!
>>>>>
>>>>>
>>>>>> On Apr 21, 2022, at 2:41 AM, Andrey Grodzovsky
>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>
>>>>>> I retested hot plug tests at the commit I mentioned bellow - looks
>>>>>> ok, my ASIC is Navi 10, I also tested using Vega 10 and older
>>>>>> Polaris ASICs (whatever i had at home at the time). It's possible
>>>>>> there are extra issues in ASICs like ur which I didn't cover during
>>>>>> tests.
>>>>>>
>>>>>> andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test -s 13
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>
>>>>>>
>>>>>> The ASIC NOT support UVD, suite disabled
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>
>>>>>>
>>>>>> The ASIC NOT support VCE, suite disabled
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>
>>>>>>
>>>>>> The ASIC NOT support UVD ENC, suite disabled.
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>
>>>>>>
>>>>>> Don't support TMZ (trust memory zone), security suite disabled
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>> Peer device is not opened or has ASIC not supported by the suite,
>>>>>> skip all Peer to Peer tests.
>>>>>>
>>>>>>
>>>>>> CUnit - A unit testing framework for C - Version 2.1-3
>>>>>> https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Ae2GEM2LDQVGndNPKmUFvus5Z1frSIezgo%2BzQGF0Mbs%3D&amp;reserved=0 
>>>>>> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&data=05%7C01%7Candrey.grodzovsky%40amd.com%7C23750571b50a4c2e434508da32ff5720%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637878369526441445%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=kzNRa9d46sBwZCVhu9%2BEkK%2F3f7fyjAo%2BAADtgeoz2l8%3D&reserved=0>
>>>>>>
>>>>>>
>>>>>> *Suite: Hotunplug Tests**
>>>>>> ** Test: Unplug card and rescan the bus to plug it back
>>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>>>> **passed**
>>>>>> ** Test: Same as first test but with command submission
>>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>>>> **passed**
>>>>>> ** Test: Unplug with exported bo
>>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>>>> **passed*
>>>>>>
>>>>>> Run Summary: Type Total Ran Passed Failed Inactive
>>>>>> suites 14 1 n/a 0 0
>>>>>> tests 71 3 3 0 1
>>>>>> asserts 21 21 21 0 n/a
>>>>>>
>>>>>> Elapsed time = 9.195 seconds
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>> On 2022-04-20 11:44, Andrey Grodzovsky wrote:
>>>>>>>
>>>>>>> The only one in Radeon 7 I see is the same sysfs crash we already
>>>>>>> fixed so you can use the same fix. The MI 200 issue i haven't seen
>>>>>>> yet but I also haven't tested MI200 so never saw it before. Need
>>>>>>> to test when i get the time.
>>>>>>>
>>>>>>> So try that fix with Radeon 7 again to see if you pass the tests
>>>>>>> (the warnings should all be minor issues).
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>> On 2022-04-20 05:24, Shuotao Xu wrote:
>>>>>>>>>
>>>>>>>>> That a problem, latest working baseline I tested and confirmed
>>>>>>>>> passing hotplug tests is this branch and
>>>>>>>>> commithttps://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6which&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WJos5tofZ6Bc0PSnwKmh%2FX3a5FGCZJ%2BA3AJjGHggbHc%3D&amp;reserved=0 
>>>>>>>>> <commithttps://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6which&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WJos5tofZ6Bc0PSnwKmh%2FX3a5FGCZJ%2BA3AJjGHggbHc%3D&amp;reserved=0>
>>>>>>>>> is amd-staging-drm-next. 5.14 was the branch we ups-reamed the
>>>>>>>>> hotplug code but it had a lot of regressions over time due to
>>>>>>>>> new changes (that why I added the hotplug test to try and catch
>>>>>>>>> them early). It would be best to run this branch on mi-100 so we
>>>>>>>>> have a clean baseline and only after confirming this particular
>>>>>>>>> branch from this commits passes libdrm tests only then start
>>>>>>>>> adding the KFD specific addons. Another option if you can't work
>>>>>>>>> with MI-100 and this branch is to try a different ASIC that does
>>>>>>>>> work with this branch (if possible).
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>> OK I tried both this commit and the HEAD of and-staging-drm-next
>>>>>>>> on two GPUs( MI100 and Radeon VII) both did not pass hotplugout
>>>>>>>> libdrm test. I might be able to gain access to MI200, but I
>>>>>>>> suspect it would work.
>>>>>>>>
>>>>>>>> I copied the complete dmesgs as follows. I highlighted the OOPSES
>>>>>>>> for you.
>>>>>>>>
>>>>>>>> Radeon VII:
>
--------------2VuBejBNwhiU0bKhkFrGlCzo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-10 23:35, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:E51808D5-5E34-420C-9CBD-F2BAE26E45F5@microsoft.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">On May 11, 2022, at 4:31 AM, Felix Kuehling &lt;<a href="mailto:felix.kuehling@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">felix.kuehling@amd.com</a>&gt;
            wrote:</div>
          <br class="Apple-interchange-newline">
          <div class=""><span style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">[Some people who received this
              message don't often get email from<span class="Apple-converted-space">&nbsp;</span></span><a href="mailto:felix.kuehling@amd.com" style="font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; orphans: auto; text-align: start;
              text-indent: 0px; text-transform: none; white-space:
              normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px;" class="moz-txt-link-freetext" moz-do-not-send="true">felix.kuehling@amd.com</a><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;
              float: none; display: inline !important;" class="">. Learn
              why this is important at<span class="Apple-converted-space">&nbsp;</span></span><a href="https://aka.ms/LearnAboutSenderIdentification" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px;" class="moz-txt-link-freetext" moz-do-not-send="true">https://aka.ms/LearnAboutSenderIdentification</a><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;
              float: none; display: inline !important;" class="">.]</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Am 2022-05-10 um 07:03 schrieb
              Shuotao Xu:</span><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
              <br class="">
              <blockquote type="cite" class="">On Apr 28, 2022, at 12:04
                AM, Andrey Grodzovsky<br class="">
                &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                wrote:<br class="">
                <br class="">
                On 2022-04-27 05:20, Shuotao Xu wrote:<br class="">
                <br class="">
                <blockquote type="cite" class="">Hi Andrey,<br class="">
                  <br class="">
                  Sorry that I did not have time to work on this for a
                  few days.<br class="">
                  <br class="">
                  I just tried the sysfs crash fix on Radeon VII and it
                  seems that it<br class="">
                  worked. It did not pass last the hotplug test, but my
                  version has 4<br class="">
                  tests instead of 3 in your case.<br class="">
                </blockquote>
                <br class="">
                <br class="">
                That because the 4th one is only enabled when here are 2
                cards in the<br class="">
                system - to test DRI_PRIME export. I tested this time
                with only one card.<br class="">
                <br class="">
              </blockquote>
              Yes, I only had one Radeon VII in my system, so this 4th
              test should<br class="">
              have been skipped. I am ignoring this issue.<br class="">
              <br class="">
              <blockquote type="cite" class="">
                <blockquote type="cite" class=""><br class="">
                  <br class="">
                  Suite: Hotunplug Tests<br class="">
                  Test: Unplug card and rescan the bus to plug it back<br class="">
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  passed<br class="">
                  Test: Same as first test but with command submission<br class="">
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  passed<br class="">
                  Test: Unplug with exported bo<br class="">
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  passed<br class="">
                  Test: Unplug with exported fence<br class="">
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  amdgpu_device_initialize: amdgpu_get_auth (1) failed
                  (-1)<br class="">
                </blockquote>
                <br class="">
                <br class="">
                on the kernel side - the IOCTlL returning this is
                drm_getclient -<br class="">
                maybe take a look while it can't find client it ? I
                didn't have such<br class="">
                issue as far as I remember when testing.<br class="">
                <br class="">
                <br class="">
                <blockquote type="cite" class="">FAILED<br class="">
                  1. ../tests/amdgpu/hotunplug_tests.c:368 -
                  CU_ASSERT_EQUAL(r,0)<br class="">
                  2. ../tests/amdgpu/hotunplug_tests.c:411 -<br class="">
                  CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2,
                  shared_fd,<br class="">
                  &amp;sync_obj_handle2),0)<br class="">
                  3. ../tests/amdgpu/hotunplug_tests.c:423 -<br class="">
                  CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2,
                  &amp;sync_obj_handle2,<br class="">
                  1, 100000000, 0, NULL),0)<br class="">
                  4. ../tests/amdgpu/hotunplug_tests.c:425 -<br class="">
                  CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2,
                  sync_obj_handle2),0)<br class="">
                  <br class="">
                  Run Summary: Type Total Ran Passed Failed Inactive<br class="">
                  suites 14 1 n/a 0 0<br class="">
                  tests 71 4 3 1 0<br class="">
                  asserts 39 39 35 4 n/a<br class="">
                  <br class="">
                  Elapsed time = 17.321 seconds<br class="">
                  <br class="">
                  For kfd compute, there is some problem which I did not
                  see in MI100<br class="">
                  after I killed the hung application after hot plugout.
                  I was using<br class="">
                  rocm5.0.2 driver for MI100 card, and not sure if it is
                  a regression<br class="">
                  from the newer driver.<br class="">
                  After pkill, one of child of user process would be
                  stuck in Zombie<br class="">
                  mode (Z) understandably because of the bug, and future
                  rocm<br class="">
                  application after plug-back would in uninterrupted
                  sleep mode (D)<br class="">
                  because it would not return from syscall to kfd.<br class="">
                  <br class="">
                  Although drm test for amdgpu would run just fine
                  without issues<br class="">
                  after plug-back with dangling kfd state.<br class="">
                </blockquote>
                <br class="">
                <br class="">
                I am not clear when the crash bellow happens ? Is it
                related to what<br class="">
                you describe above ?<br class="">
                <br class="">
                <br class="">
                <blockquote type="cite" class=""><br class="">
                  I don’t know if there is a quick fix to it. I was
                  thinking add<br class="">
                  drm_enter/drm_exit to amdgpu_device_rreg.<br class="">
                </blockquote>
                <br class="">
                <br class="">
                Try adding drm_dev_enter/exit pair at the highest level
                of attmetong<br class="">
                to access HW - in this case it's
                amdgpu_amdkfd_set_compute_idle. We<br class="">
                always try to avoid accessing any HW functions after
                backing device<br class="">
                is gone.<br class="">
                <br class="">
                <br class="">
                <blockquote type="cite" class="">Also this has been a
                  long time in my attempt to fix hotplug issue<br class="">
                  for kfd application.<br class="">
                  I don’t know 1) if I would be able to get to MI100
                  (fixing Radeon<br class="">
                  VII would mean something but MI100 is more important
                  for us); 2)<br class="">
                  what the direct of the patch to this issue will move
                  forward.<br class="">
                </blockquote>
                <br class="">
                <br class="">
                I will go to office tomorrow to pick up MI-100, With
                time and<br class="">
                priorities permitting I will then then try to test it
                and fix any<br class="">
                bugs such that it will be passing all hot plug libdrm
                tests at the<br class="">
                tip of public amd-staging-drm-next<br class="">
                -<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C23750571b50a4c2e434508da32ff5720%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637878369526441445%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Ub4jMSDBchMgrgzlDu1vMiNypFnsfN%2FcPuZgqa7ZJk8%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux" shash="M88fDQPQX7qZp1hhhF0nh4VXT81IPfGyj324sEjqTi0N9soYqoRNrrL+WNqZC6CdG6VuBT2t5fdbba9mtvS4lNU0SwnoUhOJ8Ak/F6AZnWJxUPLnAnIkCCo9ICvxu5/iaeWZcVF+3Itmrrb/i+qvpq1l5JMzuWuwMJYEZIefFQo=" class="" moz-do-not-send="true">https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4</a>%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7C
 TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=uzuHL2YOs2e5IDmJTfyC7y44mLVLhvod9jC9s0QMXww%3D&amp;amp;reserved=0,
                after that you can try<br class="">
                to continue working with ROCm enabling on top of that.<br class="">
                <br class="">
                For now i suggest you move on with Radeon 7 which as
                your development<br class="">
                ASIC and use the fix i mentioned above.<br class="">
                <br class="">
              </blockquote>
              I finally got some time to continue on kfd hotplug patch
              attempt.<br class="">
              The following patch seems to work for kfd hotplug on
              Radeon VII. After<br class="">
              hot plugout, the tf process exists because of vm fault.<br class="">
              A new tf process run without issues after plugback.<br class="">
              <br class="">
              It has the following fixes.<br class="">
              <br class="">
              1. ras sysfs regression;<br class="">
              2. skip setting compute idle after dev is plugged,
              otherwise it will<br class="">
              &nbsp;&nbsp;&nbsp;try to write the pci bar thus driver fault<br class="">
              3. stops the actual work of invalidate memory map
              triggered by<br class="">
              &nbsp;&nbsp;&nbsp;useptrs; (return false will trigger warning, so I
              returned true.<br class="">
              &nbsp;&nbsp;&nbsp;Not sure if it is correct)<br class="">
              4. It sends exceptions to all the events/signal that a
              “zombie”<br class="">
              &nbsp;&nbsp;&nbsp;process that are waiting for. (Not sure if the
              hw_exception is<br class="">
              &nbsp;&nbsp;&nbsp;worthwhile, it did not do anything in my case since
              there is such<br class="">
              &nbsp;&nbsp;&nbsp;event type associated with that process)<br class="">
              <br class="">
              Please take a look and let me know if it acceptable.<br class="">
              <br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
              index 1f8161cd507f..2f7858692067 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
              @@ -33,6 +33,7 @@<br class="">
              #include &lt;uapi/linux/kfd_ioctl.h&gt;<br class="">
              #include &quot;amdgpu_ras.h&quot;<br class="">
              #include &quot;amdgpu_umc.h&quot;<br class="">
              +#include &lt;drm/drm_drv.h&gt;<br class="">
              <br class="">
              /* Total memory size in system memory and all GPU VRAM.
              Used to<br class="">
              &nbsp;* estimate worst case amount of memory to reserve for
              page tables<br class="">
              @@ -681,9 +682,10 @@ int amdgpu_amdkfd_submit_ib(struct
              amdgpu_device<br class="">
              *adev,<br class="">
              <br class="">
              void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device
              *adev, bool<br class="">
              idle)<br class="">
              {<br class="">
              - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_dpm_switch_power_profile(adev,<br class="">
              - PP_SMC_POWER_PROFILE_COMPUTE,<br class="">
              - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!idle);<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!drm_dev_is_unplugged(adev_to_drm(adev)))<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_dpm_switch_power_profile(adev,<br class="">
              + PP_SMC_POWER_PROFILE_COMPUTE,<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!idle);<br class="">
              }<br class="">
              <br class="">
              bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev,
              u32 vmid)<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c<br class="">
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c<br class="">
              index 4b153daf283d..fb4c9e55eace 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c<br class="">
              @@ -46,6 +46,7 @@<br class="">
              #include &lt;linux/firmware.h&gt;<br class="">
              #include &lt;linux/module.h&gt;<br class="">
              #include &lt;drm/drm.h&gt;<br class="">
              +#include &lt;drm/drm_drv.h&gt;<br class="">
              <br class="">
              #include &quot;amdgpu.h&quot;<br class="">
              #include &quot;amdgpu_amdkfd.h&quot;<br class="">
              @@ -104,6 +105,9 @@ static bool
              amdgpu_mn_invalidate_hsa(struct<br class="">
              mmu_interval_notifier *mni,<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct amdgpu_bo *bo = container_of(mni, struct
              amdgpu_bo,<br class="">
              notifier);<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct amdgpu_device *adev =
              amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br class="">
              <br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (drm_dev_is_unplugged(adev_to_drm(adev)))<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return true;<br class="">
              +<br class="">
            </blockquote>
          </div>
        </blockquote>
        Label: Fix 3<br class="">
        <blockquote type="cite" class="">
          <div class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!mmu_notifier_range_blockable(range))<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br class="">
              <br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class="">
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class="">
              index cac56f830aed..fbbaaabf3a67 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class="">
              @@ -1509,7 +1509,6 @@ static int amdgpu_ras_fs_fini(struct<br class="">
              amdgpu_device *adev)<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class="">
              <br class="">
              - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_sysfs_remove_all(adev);<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br class="">
              }<br class="">
              /* ras fs end */<br class="">
              @@ -2557,8 +2556,6 @@ void
              amdgpu_ras_block_late_fini(struct<br class="">
              amdgpu_device *adev,<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!ras_block)<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br class="">
              <br class="">
              - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_sysfs_remove(adev, ras_block);<br class="">
              -<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ras_obj = container_of(ras_block, struct<br class="">
              amdgpu_ras_block_object, ras_comm);<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ras_obj-&gt;ras_cb)<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_interrupt_remove_handler(adev,
              ras_block);<br class="">
              @@ -2659,6 +2656,7 @@ int amdgpu_ras_pre_fini(struct
              amdgpu_device *adev)<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Need disable ras on all IPs here before ip
              [hw/sw]fini */<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_disable_all_features(adev, 0);<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_recovery_fini(adev);<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_sysfs_remove_all(adev);<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br class="">
              }<br class="">
              <br class="">
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
              b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
              index f1a225a20719..4b789bec9670 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
              @@ -714,16 +714,37 @@ bool kfd_is_locked(void)<br class="">
              <br class="">
              void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)<br class="">
              {<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct kfd_process *p;<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct amdkfd_process_info *p_info;<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned int temp;<br class="">
              +<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!kfd-&gt;init_complete)<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br class="">
              <br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* for runtime suspend, skip locking kfd */<br class="">
              - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!run_pm) {<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!run_pm &amp;&amp;
              !drm_dev_is_unplugged(kfd-&gt;ddev)) {<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* For first KFD device suspend all the KFD
              processes */<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (atomic_inc_return(&amp;kfd_locked) ==
              1)<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kfd_suspend_all_processes();<br class="">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class="">
              <br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (drm_dev_is_unplugged(kfd-&gt;ddev)){<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int idx =
              srcu_read_lock(&amp;kfd_processes_srcu);<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pr_debug(&quot;cancel restore_userptr_work\n&quot;);<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hash_for_each_rcu(kfd_processes_table,
              temp, p,<br class="">
              kfd_processes) {<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if
              (kfd_process_gpuidx_from_gpuid(p, kfd-&gt;id)<br class="">
              &gt;= 0) {<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p_info =
              p-&gt;kgd_process_info;<br class="">
              + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pr_debug(&quot;cancel
              processes, pid = %d<br class="">
              for gpu_id = %d&quot;, pid_nr(p_info-&gt;pid), kfd-&gt;id);<br class="">
              +
              cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work);<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Is this really necessary? If it is,
              there are probably other workers,</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">e.g. related to our SVM code, that
              would need to be canceled as well.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        <div>I delete this and it seems to be OK. It was previously
          added to suppress restore_useptr_work which keeps updating
          PTE.</div>
        <div>Now this is gone by Fix 3. Please let us know if it is OK:)
          @Felix</div>
        <div><br class="">
        </div>
        <blockquote type="cite" class="">
          <div class=""><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              +<br class="">
              + /* send exception signals to the kfd<br class="">
              events waiting in user space */<br class="">
              + kfd_signal_hw_exception_event(p-&gt;pasid);<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">This makes sense. It basically tells
              user mode that the application's</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">GPU state is lost due to a RAS error
              or a GPU reset, or now a GPU</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">hot-unplug.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        <div>The problem is that it cannot find an event with a type
          that matches HW_EXCEPTION_TYPE so it does **nothing** from the
          driver with the default parameter value of send_sigterm =
          false;</div>
        <div>After all, if a “zombie” process (zombie in the sense it
          does not have a GPU dev) does not exit, kfd resources seems
          not been released properly and new kfd process cannot run
          after plug back.</div>
        <div>(I still need to look hard into rocr/hsakmt/kfd driver code
          to understand the reason. At least I am seeing that the kfd
          topology won’t be cleaned up without process exiting, so that
          there would be a “zombie&quot; kfd node in the topology, which may
          or may not cause issues in hsakmt).&nbsp;</div>
        <div>@Felix Do you have suggestion/insight on this “zombie&quot;
          process issue? @Andrey suggests it should be OK to have a
          “zombie” kfd process and a “zombie” kfd dev, and the new kfd
          process should be ok to run on the new kfd dev after plugback.</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>My experience with the graphic stack at least showed that. At
      least in a setup with 2 GPUs, if i remove a secondary GPU which
      had a rendering process on it, I could plug back the secondary GPU
      and start a new rendering process while the old zombie process was
      still present. It could be that in KFD case there are some
      obstacles to this that need to be resolved.<br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:E51808D5-5E34-420C-9CBD-F2BAE26E45F5@microsoft.com">
      <div>
        <div><br class="">
        </div>
        <div>
          <div>May 11 09:52:07 NETSYS26 kernel: [52604.845400] amdgpu:
            cancel restore_userptr_work</div>
          <div>May 11 09:52:07 NETSYS26 kernel: [52604.845405] amdgpu:
            sending hw exception to pasid = 0x800</div>
          <div>May 11 09:52:07 NETSYS26 kernel: [52604.845414] kfd kfd:
            amdgpu: Process 25894 (pasid 0x8001) got unhandled exception</div>
          <div><br class="">
          </div>
        </div>
        <blockquote type="cite" class="">
          <div class=""><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              + kfd_signal_vm_fault_event(kfd, p-&gt;pasid, NULL);<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">This does not make sense. A VM fault
              indicates an access to a bad</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">virtual address by the GPU. If a
              debugger is attached to the process, it</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">notifies the debugger to investigate
              what went wrong. If the GPU is</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">gone, that doesn't make any sense.
              There is no GPU that could have</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">issued a bad memory request. And the
              debugger won't be happy either to</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">find a VM fault from a GPU that
              doesn't exist any more.</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        <div>OK understood.</div>
        <br class="">
        <blockquote type="cite" class="">
          <div class=""><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">If the HW-exception event doesn't
              terminate your process, we may need to</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">look into how ROCr handles the
              HW-exception events.</span><br style="caret-color: rgb(0,
              0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              + }<br class="">
              + }<br class="">
              + srcu_read_unlock(&amp;kfd_processes_srcu, idx);<br class="">
              + }<br class="">
              +<br class="">
              kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);<br class="">
              kfd_iommu_suspend(kfd);<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Should DQM stop and IOMMU suspend
              still be executed? Or should the</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">hot-unplug case short-circuit them?</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        <div>I tried short circuiting them, but would later caused BUG
          related to GPU reset. I added the following that solve the
          issue on plugout.&nbsp;</div>
        <div>
          <div><br class="">
          </div>
          <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
          <div>index b583026dc893..d78a06d74759 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
          <div>@@ -5317,7 +5317,8 @@ static void
            amdgpu_device_queue_gpu_recover_work(struct work_struct
            *work)</div>
          <div>&nbsp;{</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_recover_work_struct *recover_work =
            container_of(work, struct amdgpu_recover_work_struct, base);</div>
          <div><br class="">
          </div>
          <div>- &nbsp; &nbsp; &nbsp; recover_work-&gt;ret =
            amdgpu_device_gpu_recover_imp(recover_work-&gt;adev,
            recover_work-&gt;job);</div>
          <div>+ &nbsp; &nbsp; &nbsp; if
            (!drm_dev_is_unplugged(adev_to_drm(recover_work-&gt;adev)))</div>
          <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recover_work-&gt;ret =
            amdgpu_device_gpu_recover_imp(recover_work-&gt;adev,
            recover_work-&gt;job);</div>
          <div>&nbsp;}</div>
          <div>&nbsp;/*</div>
          <div>&nbsp; * Serialize gpu recover into reset domain single
            threaded wq</div>
          <div><br class="">
          </div>
        </div>
        <div>However after kill the zombie process, it failed to evict
          queues of the process.</div>
        <div><br class="">
        </div>
        <div>
          <div>[ &nbsp;+0.000002] amdgpu: writing 263 to doorbell address
            00000000c86e63f2</div>
          <div>[ &nbsp;+9.002503] amdgpu: qcm fence wait loop timeout expired</div>
          <div>[ &nbsp;+0.001364] amdgpu: The cp might be in an unrecoverable
            state due to an unsuccessful queues preemption</div>
          <div>[ &nbsp;+0.001343] amdgpu: Failed to evict process queues</div>
          <div>[ &nbsp;+0.001355] amdgpu: Failed to evict queues of pasid
            0x8001</div>
          <div class=""><br class="">
          </div>
        </div>
        <div><br class="">
        </div>
        <div>This would cause driver BUG triggered by new kfd process
          after plugback. I am pasting the errors from dmesg after
          plugback as below.</div>
        <div class=""><br class="">
        </div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.445332] amdgpu:
            Evicting PASID 0x8001 queues</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.445359] BUG:
            unable to handle page fault for address: 000000020000006e</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.447516] #PF:
            supervisor read access in kernel mode</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.449627] #PF:
            error_code(0x0000) - not-present page</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.451661] PGD
            80000020892a8067 P4D 80000020892a8067 PUD 0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.453741] Oops:
            0000 [#1] PREEMPT SMP PTI</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.455904] CPU: 25
            PID: 9236 Comm: tf_cnn_benchmar Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;OE &nbsp; &nbsp;
            5.16.0+ #3</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.457406] amdgpu
            0000:05:00.0: amdgpu: GPU reset begin!</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.457798] Hardware
            name: Dell Inc. PowerEdge R730/0H21J3, BIOS 1.5.4 [FPGA Test
            BIOS] 10/002/2015</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.461458] RIP:
            0010:evict_process_queues_cpsch+0x99/0x1b0 [amdgpu]</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.465238] Code: bd
            13 8a dd 85 c0 0f 85 13 01 00 00 49 8b 5f 10 4d 8d 77 10 49
            39 de 75 11 e9 8d 00 00 00 48 8b 1b 4c 39 f3 0f 84 81 00 00
            00 &lt;80&gt; 7b 6e 00 c6 43 6d 01 74 ea c6 43 6e 00 41 83
            ac 24 70 01 00 00</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.470516] RSP:
            0018:ffffb2674c8afbf0 EFLAGS: 00010203</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.473255] RAX:
            ffff91c65cca3800 RBX: 0000000200000000 RCX: 0000000000000001</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.475691] RDX:
            0000000000000000 RSI: ffffffff9fb712d9 RDI: 00000000ffffffff</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.478564] RBP:
            ffffb2674c8afc20 R08: 0000000000000000 R09: 000000000006ba18</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.481409] R10:
            00007fe5a0000000 R11: ffffb2674c8af918 R12: ffff91c66d6f5800</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.484254] R13:
            ffff91c66d6f5938 R14: ffff91e5c71ac820 R15: ffff91e5c71ac810</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.487184] FS:
            &nbsp;00007fe62124a700(0000) GS:ffff92053fd00000(0000)
            knlGS:0000000000000000</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.490308] CS: &nbsp;0010
            DS: 0000 ES: 0000 CR0: 0000000080050033</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.493122] CR2:
            000000020000006e CR3: 0000002095284004 CR4: 00000000001706e0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.496142] Call
            Trace:</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.499199]
            &nbsp;&lt;TASK&gt;</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.502261]
            &nbsp;kfd_process_evict_queues+0x43/0xf0 [amdgpu]</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.506378]
            &nbsp;kgd2kfd_quiesce_mm+0x2a/0x60 [amdgpu]</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.510539]
            &nbsp;amdgpu_amdkfd_evict_userptr+0x46/0x80 [amdgpu]</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.514110]
            &nbsp;amdgpu_mn_invalidate_hsa+0x9c/0xb0 [amdgpu]</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.518247]
            &nbsp;__mmu_notifier_invalidate_range_start+0x136/0x1e0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.521252]
            &nbsp;change_protection+0x41d/0xcd0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.524310]
            &nbsp;change_prot_numa+0x19/0x30</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.527366]
            &nbsp;task_numa_work+0x1ca/0x330</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.530157]
            &nbsp;task_work_run+0x6c/0xa0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.533124]
            &nbsp;exit_to_user_mode_prepare+0x1af/0x1c0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.536058]
            &nbsp;syscall_exit_to_user_mode+0x2a/0x40</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.538989]
            &nbsp;do_syscall_64+0x46/0xb0</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.541830]
            &nbsp;entry_SYSCALL_64_after_hwframe+0x44/0xae</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.544701] RIP:
            0033:0x7fe6585ec317</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.547297] Code: b3
            66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff
            ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
            05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00
            f7 d8 64 89 01 48</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.553183] RSP:
            002b:00007fe6212494c8 EFLAGS: 00000246 ORIG_RAX:
            0000000000000010</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.556105] RAX:
            ffffffffffffffc2 RBX: 0000000000000000 RCX: 00007fe6585ec317</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.558970] RDX:
            00007fe621249540 RSI: 00000000c0584b02 RDI: 0000000000000003</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.561950] RBP:
            00007fe621249540 R08: 0000000000000000 R09: 0000000000040000</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.564563] R10:
            00007fe617480000 R11: 0000000000000246 R12: 00000000c0584b02</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.567494] R13:
            0000000000000003 R14: 0000000000000064 R15: 00007fe621249920</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.570470]
            &nbsp;&lt;/TASK&gt;</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.573380] Modules
            linked in: amdgpu(OE) veth nf_conntrack_netlink nfnetlink
            xfrm_user xt_addrtype br_netfilter xt_CHECKSUM
            iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
            nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
            nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter
            ebtables ip6table_filter ip6_tables iptable_filter overlay
            esp6_offload esp6 esp4_offload esp4 xfrm_algo intel_rapl_msr
            intel_rapl_common sb_edac snd_hda_codec_hdmi
            x86_pkg_temp_thermal snd_hda_intel intel_powerclamp
            snd_intel_dspcfg ipmi_ssif coretemp snd_hda_codec kvm_intel
            snd_hda_core snd_hwdep kvm snd_pcm snd_timer snd soundcore
            ftdi_sio irqbypass rapl intel_cstate usbserial joydev mei_me
            input_leds mei iTCO_wdt iTCO_vendor_support lpc_ich ipmi_si
            ipmi_devintf mac_hid acpi_power_meter ipmi_msghandler
            sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp
            libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables
            x_tables autofs4 btrfs blake2b_generic zstd_compress raid10
            raid456</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.573543]
            &nbsp;async_raid6_recov async_memcpy async_pq async_xor async_tx
            xor raid6_pq libcrc32c raid1 raid0 multipath linear iommu_v2
            gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper
            drm_kms_helper syscopyarea hid_generic crct10dif_pclmul
            crc32_pclmul sysfillrect ghash_clmulni_intel sysimgblt
            fb_sys_fops uas usbhid aesni_intel crypto_simd igb ahci hid
            drm usb_storage cryptd libahci dca megaraid_sas i2c_algo_bit
            wmi [last unloaded: amdgpu]</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.611083] CR2:
            000000020000006e</div>
          <div>May 11 10:25:16 NETSYS26 kernel: [ &nbsp;688.614454] ---[ end
            trace 349cf28efb6268bc ]—</div>
          <div><br class="">
          </div>
          <div>Looking forward to the comments.</div>
          <div><br class="">
          </div>
          <div>Regards,</div>
          <div>Shuotao</div>
          <div><br class="">
          </div>
        </div>
        <blockquote type="cite" class="">
          <div class=""><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Regards,</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Felix</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              }<br class="">
              <br class="">
              Regards,<br class="">
              Shuotao<br class="">
              <blockquote type="cite" class=""><br class="">
                Andrey<br class="">
                <br class="">
                <br class="">
                <blockquote type="cite" class=""><br class="">
                  Regards,<br class="">
                  Shuotao<br class="">
                  <br class="">
                  [ &nbsp;+0.001645] BUG: unable to handle page fault for
                  address:<br class="">
                  0000000000058a68<br class="">
                  [ &nbsp;+0.001298] #PF: supervisor read access in kernel
                  mode<br class="">
                  [ &nbsp;+0.001252] #PF: error_code(0x0000) - not-present
                  page<br class="">
                  [ &nbsp;+0.001248] PGD 8000000115806067 P4D
                  8000000115806067 PUD<br class="">
                  109b2d067 PMD 0<br class="">
                  [ &nbsp;+0.001270] Oops: 0000 [#1] PREEMPT SMP PTI<br class="">
                  [ &nbsp;+0.001256] CPU: 5 PID: 13818 Comm: tf_cnn_benchmar
                  Tainted: G<br class="">
                  &nbsp;&nbsp;W &nbsp;&nbsp;E &nbsp;&nbsp;&nbsp;&nbsp;5.16.0+ #3<br class="">
                  [ &nbsp;+0.001290] Hardware name: Dell Inc. PowerEdge
                  R730/0H21J3, BIOS<br class="">
                  1.5.4 [FPGA Test BIOS] 10/002/2015<br class="">
                  [ &nbsp;+0.001309] RIP:
                  0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]<br class="">
                  [ &nbsp;+0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f
                  3f 75 ae 0f 1f<br class="">
                  44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75
                  0d 4c 03 a3 a0<br class="">
                  09 00 00 &lt;45&gt; 8b 24 24 eb 8a 4c 8d b7 b0 6b 01
                  00 4c 89 f7 e8 a2 4c<br class="">
                  2e ca 85<br class="">
                  [ &nbsp;+0.002751] RSP: 0018:ffffb58fac313928 EFLAGS:
                  00010202<br class="">
                  [ &nbsp;+0.001388] RAX: ffffffffc09a4270 RBX:
                  ffff8b0c9c840000 RCX:<br class="">
                  00000000ffffffff<br class="">
                  [ &nbsp;+0.001402] RDX: 0000000000000000 RSI:
                  000000000001629a RDI:<br class="">
                  ffff8b0c9c840000<br class="">
                  [ &nbsp;+0.001418] RBP: ffffb58fac313948 R08:
                  0000000000000021 R09:<br class="">
                  0000000000000001<br class="">
                  [ &nbsp;+0.001421] R10: ffffb58fac313b30 R11:
                  ffffffff8c065b00 R12:<br class="">
                  0000000000058a68<br class="">
                  [ &nbsp;+0.001400] R13: 000000000001629a R14:
                  0000000000000000 R15:<br class="">
                  000000000001629a<br class="">
                  [ &nbsp;+0.001397] FS: &nbsp;0000000000000000(0000)
                  GS:ffff8b4b7fa80000(0000)<br class="">
                  knlGS:0000000000000000<br class="">
                  [ &nbsp;+0.001411] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
                  0000000080050033<br class="">
                  [ &nbsp;+0.001405] CR2: 0000000000058a68 CR3:
                  000000010a2c8001 CR4:<br class="">
                  00000000001706e0<br class="">
                  [ &nbsp;+0.001422] Call Trace:<br class="">
                  [ &nbsp;+0.001407] &nbsp;&lt;TASK&gt;<br class="">
                  [ &nbsp;+0.001391] &nbsp;amdgpu_device_rreg+0x17/0x20 [amdgpu]<br class="">
                  [ &nbsp;+0.001614] &nbsp;amdgpu_cgs_read_register+0x14/0x20
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001735]
                  &nbsp;phm_wait_for_register_unequal.part.1+0x58/0x90
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001790] &nbsp;phm_wait_for_register_unequal+0x1a/0x30
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001800] &nbsp;vega20_wait_for_response+0x28/0x80
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001757]
                  &nbsp;vega20_send_msg_to_smc_with_parameter+0x21/0x110
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001838]
                  &nbsp;smum_send_msg_to_smc_with_parameter+0xcd/0x100
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001829] &nbsp;? kvfree+0x1e/0x30<br class="">
                  [ &nbsp;+0.001462]
                  &nbsp;vega20_set_power_profile_mode+0x58/0x330 [amdgpu]<br class="">
                  [ &nbsp;+0.001868] &nbsp;? kvfree+0x1e/0x30<br class="">
                  [ &nbsp;+0.001462] &nbsp;? ttm_bo_release+0x261/0x370 [ttm]<br class="">
                  [ &nbsp;+0.001467] &nbsp;pp_dpm_switch_power_profile+0xc2/0x170
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001863]
                  &nbsp;amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]<br class="">
                  [ &nbsp;+0.001866]
                  &nbsp;amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]<br class="">
                  [ &nbsp;+0.001784] &nbsp;kfd_dec_compute_active+0x2c/0x50
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001744] &nbsp;process_termination_cpsch+0x2f9/0x3a0
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001728]
                  &nbsp;kfd_process_dequeue_from_all_devices+0x49/0x70
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001730] &nbsp;kfd_process_notifier_release+0x91/0xe0
                  [amdgpu]<br class="">
                  [ &nbsp;+0.001718] &nbsp;__mmu_notifier_release+0x77/0x1f0<br class="">
                  [ &nbsp;+0.001411] &nbsp;exit_mmap+0x1b5/0x200<br class="">
                  [ &nbsp;+0.001396] &nbsp;? __switch_to+0x12d/0x3e0<br class="">
                  [ &nbsp;+0.001388] &nbsp;? __switch_to_asm+0x36/0x70<br class="">
                  [ &nbsp;+0.001372] &nbsp;? preempt_count_add+0x74/0xc0<br class="">
                  [ &nbsp;+0.001364] &nbsp;mmput+0x57/0x110<br class="">
                  [ &nbsp;+0.001349] &nbsp;do_exit+0x33d/0xc20<br class="">
                  [ &nbsp;+0.001337] &nbsp;? _raw_spin_unlock+0x1a/0x30<br class="">
                  [ &nbsp;+0.001346] &nbsp;do_group_exit+0x43/0xa0<br class="">
                  [ &nbsp;+0.001341] &nbsp;get_signal+0x131/0x920<br class="">
                  [ &nbsp;+0.001295] &nbsp;arch_do_signal_or_restart+0xb1/0x870<br class="">
                  [ &nbsp;+0.001303] &nbsp;? do_futex+0x125/0x190<br class="">
                  [ &nbsp;+0.001285] &nbsp;exit_to_user_mode_prepare+0xb1/0x1c0<br class="">
                  [ &nbsp;+0.001282] &nbsp;syscall_exit_to_user_mode+0x2a/0x40<br class="">
                  [ &nbsp;+0.001264] &nbsp;do_syscall_64+0x46/0xb0<br class="">
                  [ &nbsp;+0.001236]
                  &nbsp;entry_SYSCALL_64_after_hwframe+0x44/0xae<br class="">
                  [ &nbsp;+0.001219] RIP: 0033:0x7f6aff1d2ad3<br class="">
                  [ &nbsp;+0.001177] Code: Unable to access opcode bytes at
                  RIP 0x7f6aff1d2aa9.<br class="">
                  [ &nbsp;+0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS:
                  00000246 ORIG_RAX:<br class="">
                  00000000000000ca<br class="">
                  [ &nbsp;+0.001170] RAX: fffffffffffffe00 RBX:
                  0000000004f542b0 RCX:<br class="">
                  00007f6aff1d2ad3<br class="">
                  [ &nbsp;+0.001168] RDX: 0000000000000000 RSI:
                  0000000000000080 RDI:<br class="">
                  0000000004f542d8<br class="">
                  [ &nbsp;+0.001162] RBP: 0000000004f542d4 R08:
                  0000000000000000 R09:<br class="">
                  0000000000000000<br class="">
                  [ &nbsp;+0.001152] R10: 0000000000000000 R11:
                  0000000000000246 R12:<br class="">
                  0000000004f542d8<br class="">
                  [ &nbsp;+0.001176] R13: 0000000000000000 R14:
                  0000000004f54288 R15:<br class="">
                  0000000000000000<br class="">
                  [ &nbsp;+0.001152] &nbsp;&lt;/TASK&gt;<br class="">
                  [ &nbsp;+0.001113] Modules linked in: veth amdgpu(E)
                  nf_conntrack_netlink<br class="">
                  nfnetlink xfrm_user xt_addrtype br_netfilter
                  xt_CHECKSUM<br class="">
                  iptable_mangle xt_MASQUERADE iptable_nat nf_nat
                  xt_conntrack<br class="">
                  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
                  nf_reject_ipv4<br class="">
                  xt_tcpudp bridge stp llc ebtable_filter ebtables
                  ip6table_filter<br class="">
                  ip6_tables iptable_filter overlay esp6_offload esp6
                  esp4_offload<br class="">
                  esp4 xfrm_algo intel_rapl_msr intel_rapl_common
                  sb_edac<br class="">
                  x86_pkg_temp_thermal intel_powerclamp
                  snd_hda_codec_hdmi<br class="">
                  snd_hda_intel ipmi_ssif snd_intel_dspcfg coretemp
                  snd_hda_codec<br class="">
                  kvm_intel snd_hda_core snd_hwdep snd_pcm snd_timer snd
                  kvm soundcore<br class="">
                  irqbypass ftdi_sio usbserial input_leds iTCO_wdt
                  iTCO_vendor_support<br class="">
                  joydev mei_me rapl lpc_ich intel_cstate mei ipmi_si
                  ipmi_devintf<br class="">
                  ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel
                  ib_iser<br class="">
                  rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp
                  libiscsi<br class="">
                  scsi_transport_iscsi ip_tables x_tables autofs4 btrfs<br class="">
                  blake2b_generic zstd_compress raid10 raid456<br class="">
                  [ &nbsp;+0.000102] &nbsp;async_raid6_recov async_memcpy async_pq
                  async_xor<br class="">
                  async_tx xor raid6_pq libcrc32c raid1 raid0 multipath
                  linear<br class="">
                  iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm
                  drm_shmem_helper<br class="">
                  drm_kms_helper syscopyarea sysfillrect sysimgblt
                  fb_sys_fops<br class="">
                  crct10dif_pclmul hid_generic crc32_pclmul
                  ghash_clmulni_intel usbhid<br class="">
                  uas aesni_intel crypto_simd igb ahci hid drm
                  usb_storage cryptd<br class="">
                  libahci dca megaraid_sas i2c_algo_bit wmi [last
                  unloaded: amdgpu]<br class="">
                  [ &nbsp;+0.016626] CR2: 0000000000058a68<br class="">
                  [ &nbsp;+0.001550] ---[ end trace ff90849fe0a8b3b4 ]---<br class="">
                  [ &nbsp;+0.024953] RIP:
                  0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]<br class="">
                  [ &nbsp;+0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f
                  3f 75 ae 0f 1f<br class="">
                  44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75
                  0d 4c 03 a3 a0<br class="">
                  09 00 00 &lt;45&gt; 8b 24 24 eb 8a 4c 8d b7 b0 6b 01
                  00 4c 89 f7 e8 a2 4c<br class="">
                  2e ca 85<br class="">
                  [ &nbsp;+0.003255] RSP: 0018:ffffb58fac313928 EFLAGS:
                  00010202<br class="">
                  [ &nbsp;+0.001641] RAX: ffffffffc09a4270 RBX:
                  ffff8b0c9c840000 RCX:<br class="">
                  00000000ffffffff<br class="">
                  [ &nbsp;+0.001656] RDX: 0000000000000000 RSI:
                  000000000001629a RDI:<br class="">
                  ffff8b0c9c840000<br class="">
                  [ &nbsp;+0.001681] RBP: ffffb58fac313948 R08:
                  0000000000000021 R09:<br class="">
                  0000000000000001<br class="">
                  [ &nbsp;+0.001662] R10: ffffb58fac313b30 R11:
                  ffffffff8c065b00 R12:<br class="">
                  0000000000058a68<br class="">
                  [ &nbsp;+0.001650] R13: 000000000001629a R14:
                  0000000000000000 R15:<br class="">
                  000000000001629a<br class="">
                  [ &nbsp;+0.001648] FS: &nbsp;0000000000000000(0000)
                  GS:ffff8b4b7fa80000(0000)<br class="">
                  knlGS:0000000000000000<br class="">
                  [ &nbsp;+0.001668] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
                  0000000080050033<br class="">
                  [ &nbsp;+0.001673] CR2: 0000000000058a68 CR3:
                  000000010a2c8001 CR4:<br class="">
                  00000000001706e0<br class="">
                  [ &nbsp;+0.001740] Fixing recursive fault but reboot is
                  needed!<br class="">
                  <br class="">
                  <br class="">
                  <blockquote type="cite" class="">On Apr 21, 2022, at
                    2:41 AM, Andrey Grodzovsky<br class="">
                    &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                    wrote:<br class="">
                    <br class="">
                    I retested hot plug tests at the commit I mentioned
                    bellow - looks<br class="">
                    ok, my ASIC is Navi 10, I also tested using Vega 10
                    and older<br class="">
                    Polaris ASICs (whatever i had at home at the time).
                    It's possible<br class="">
                    there are extra issues in ASICs like ur which I
                    didn't cover during<br class="">
                    tests.<br class="">
                    <br class="">
                    andrey@andrey-test:~/drm$ sudo
                    ./build/tests/amdgpu/amdgpu_test -s 13<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    <br class="">
                    <br class="">
                    The ASIC NOT support UVD, suite disabled<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    <br class="">
                    <br class="">
                    The ASIC NOT support VCE, suite disabled<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    <br class="">
                    <br class="">
                    The ASIC NOT support UVD ENC, suite disabled.<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    <br class="">
                    <br class="">
                    Don't support TMZ (trust memory zone), security
                    suite disabled<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    /usr/local/share/libdrm/amdgpu.ids: No such file or
                    directory<br class="">
                    Peer device is not opened or has ASIC not supported
                    by the suite,<br class="">
                    skip all Peer to Peer tests.<br class="">
                    <br class="">
                    <br class="">
                    CUnit - A unit testing framework for C - Version
                    2.1-3<br class="">
                    <a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C23750571b50a4c2e434508da32ff5720%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637878369526441445%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kzNRa9d46sBwZCVhu9%2BEkK%2F3f7fyjAo%2BAADtgeoz2l8%3D&amp;reserved=0" originalsrc="http://cunit.sourceforge.net/" shash="mz6Kzjf7NojqeE9BGVLrvEm3IyJe7NwKrHZoxg1rRxeFOTkcFC28UF09ES/2elRxC+ERNKHkdboZ4W5DbH9EHgOogBx8slEYJBRuLvkvHgddsx1Dp6ZmWcjLh8Wnq/56zpfAo1K0ihxSqsuFZ6G6ZtfXiggyJfwGpMRMoWAhcyo=" class="" moz-do-not-send="true">https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&amp;amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
 V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=Ae2GEM2LDQVGndNPKmUFvus5Z1frSIezgo%2BzQGF0Mbs%3D&amp;amp;reserved=0</a><br class="">
                    <br class="">
                    <br class="">
                    *Suite: Hotunplug Tests**<br class="">
                    ** Test: Unplug card and rescan the bus to plug it
                    back<br class="">
                    .../usr/local/share/libdrm/amdgpu.ids: No such file
                    or directory**<br class="">
                    **passed**<br class="">
                    ** Test: Same as first test but with command
                    submission<br class="">
                    .../usr/local/share/libdrm/amdgpu.ids: No such file
                    or directory**<br class="">
                    **passed**<br class="">
                    ** Test: Unplug with exported bo<br class="">
                    .../usr/local/share/libdrm/amdgpu.ids: No such file
                    or directory**<br class="">
                    **passed*<br class="">
                    <br class="">
                    Run Summary: Type Total Ran Passed Failed Inactive<br class="">
                    suites 14 1 n/a 0 0<br class="">
                    tests 71 3 3 0 1<br class="">
                    asserts 21 21 21 0 n/a<br class="">
                    <br class="">
                    Elapsed time = 9.195 seconds<br class="">
                    <br class="">
                    <br class="">
                    Andrey<br class="">
                    <br class="">
                    On 2022-04-20 11:44, Andrey Grodzovsky wrote:<br class="">
                    <blockquote type="cite" class=""><br class="">
                      The only one in Radeon 7 I see is the same sysfs
                      crash we already<br class="">
                      fixed so you can use the same fix. The MI 200
                      issue i haven't seen<br class="">
                      yet but I also haven't tested MI200 so never saw
                      it before. Need<br class="">
                      to test when i get the time.<br class="">
                      <br class="">
                      So try that fix with Radeon 7 again to see if you
                      pass the tests<br class="">
                      (the warnings should all be minor issues).<br class="">
                      <br class="">
                      Andrey<br class="">
                      <br class="">
                      <br class="">
                      On 2022-04-20 05:24, Shuotao Xu wrote:<br class="">
                      <blockquote type="cite" class="">
                        <blockquote type="cite" class=""><br class="">
                          That a problem, latest working baseline I
                          tested and confirmed<br class="">
                          passing hotplug tests is this branch and<br class="">
                          <a href="commithttps://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6which&amp;amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=WJos5tofZ6Bc0PSnwKmh%2FX3a5FGCZJ%2BA3AJjGHggbHc%3D&amp;amp;reserved=0" class="" moz-do-not-send="true">commithttps://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6which&amp;amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C97faa63fd9a743a2982308da32c41ec4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637878115188634502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
 C%7C%7C&amp;amp;sdata=WJos5tofZ6Bc0PSnwKmh%2FX3a5FGCZJ%2BA3AJjGHggbHc%3D&amp;amp;reserved=0</a><br class="">
                          is amd-staging-drm-next. 5.14 was the branch
                          we ups-reamed the<br class="">
                          hotplug code but it had a lot of regressions
                          over time due to<br class="">
                          new changes (that why I added the hotplug test
                          to try and catch<br class="">
                          them early). It would be best to run this
                          branch on mi-100 so we<br class="">
                          have a clean baseline and only after
                          confirming this particular<br class="">
                          branch from this commits passes libdrm tests
                          only then start<br class="">
                          adding the KFD specific addons. Another option
                          if you can't work<br class="">
                          with MI-100 and this branch is to try a
                          different ASIC that does<br class="">
                          work with this branch (if possible).<br class="">
                          <br class="">
                          Andrey<br class="">
                          <br class="">
                        </blockquote>
                        OK I tried both this commit and the HEAD of
                        and-staging-drm-next<br class="">
                        on two GPUs( MI100 and Radeon VII) both did not
                        pass hotplugout<br class="">
                        libdrm test. I might be able to gain access to
                        MI200, but I<br class="">
                        suspect it would work.<br class="">
                        <br class="">
                        I copied the complete dmesgs as follows. I
                        highlighted the OOPSES<br class="">
                        for you.<br class="">
                        <br class="">
                        Radeon VII:</blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------2VuBejBNwhiU0bKhkFrGlCzo--
