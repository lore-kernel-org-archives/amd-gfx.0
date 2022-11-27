Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A858C43217
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Nov 2022 07:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EC110E04E;
	Sun, 27 Nov 2022 07:34:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CA710E04E
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Nov 2022 07:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB95Id/D3nTJxfks/ExV5bYqzA6jv/3FQFJCF0oq3VxlQe0CpKfId6MR45vi8n5g4xhuSid12mks682QLg3Pejn0kgKCC6X1+lOU/m/SzbeuUpOuX/sI9e2fT801qAJtpS9UGDvftmW86AwMtxQxLSN+5HBTdSEdtyHmlhJw0P+S0gJAp3RAahFt2eRODAMNO3XtTQ61nIAarsJe5ZCHgraObAf9yPQi7cNIW5yFhzU+AM+XXXhO87cdOCs+bx9qlYmeoeg00q1zRMcSvAuiLm6KVmXfJhZGhB6miJ+AkjNtgDXo3yuB15jjWet4Ok109gb3APMSw8syCdqmvaZBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgGc91ir4sty3VpQIRAXO+26XDeLWxKXSCTzPC98H7I=;
 b=Zl1uXSO+J0MRs/3MknbVuy9Mk7WigjLNNEE3gpj0GWPFYuakbMg0x1FsRx1pkgiT9oaycZKe2wgASr3k7J24gd4vCX+FZbJDcEr4ycZ/QcZuReAQDhNsvcEZTfHqOfOE/kNM9TQf/KoQkOkwfu6zZ0WX7xS6T5Odh5tGOsSm7vVoSnkk5F6v0DwUQgVXyXWn2jEEQGnCr3uO/9RCo69+WS8tOwzXY0zrZ/OSrFzd7wezlUBREQiKz792Lzwj9pL3Oe5XON0W1SCBEIv311OKcEuk6N2k+HQ9t6UxjeOnRDPiwpPYBTgFPBAdAbvjFd3Zn4x1ovqLJZasJGlBFTl/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgGc91ir4sty3VpQIRAXO+26XDeLWxKXSCTzPC98H7I=;
 b=mnt4PCKirx0RzSTtvsm5Daa93xKrOgUajfTOVojkF75vpaTwF6GPnrsiwvqczlvVbeRvGq/gXXvEAgLyH0TIaVC7rvH3yicoWQxZwmFGqET4z1Vh8Qqe79PHT3CBqR0v7JOFtTHh/wFPFM/Tl+pw1BhEcKrK9608pecfBcPupBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sun, 27 Nov
 2022 07:34:19 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e%9]) with mapi id 15.20.5857.021; Sun, 27 Nov 2022
 07:34:17 +0000
Message-ID: <d0cffe1d-8e33-d59c-1dd0-114228f37023@amd.com>
Date: Sun, 27 Nov 2022 13:04:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgYW1kZ3B1?=
 =?UTF-8?Q?_vram_usage_information_into_amdgpu=5fvram=5fmm?=
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221124054945.3409867-1-KevinYang.Wang@amd.com>
 <7ad77cd9-6c35-1785-6f5a-31397d8432e7@amd.com>
 <PH7PR12MB59978C83CEDB8D1AE8BB8D80820F9@PH7PR12MB5997.namprd12.prod.outlook.com>
 <dea21b09-35ff-a180-7f64-a5b12adcebf1@gmail.com>
 <e40d1956-0fb6-2972-6a85-193f4e89c328@amd.com>
 <PH7PR12MB5997A6344ED0CEAAF8CDAC42820E9@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <PH7PR12MB5997A6344ED0CEAAF8CDAC42820E9@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac7e37d-13b9-49b8-9ff7-08dad049c9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVqVVO1hHNwFcXh3Rp+E8zDhsJv8Pju/VqSW4wKYDOmXeHIfxlX4j4Y29lyG13y3K2w/D4u6admypq1cg7yP+d3jE4/IPrQ5ZNl8E8e4w6aUL6/EeDpz1jr92Z+hVxX4HZfltgwXu2s4fJtinOimPwSrGbEO36oAL8QMrDXLrq/xIO9lTtKdz/UdTqi7bNRLzp8pyIBMf2aeI1wvG9DiHD4SqYET7MMCLrfF75VYmbIZ7tf0veIpX4NqvyG1+ShCPGO6QLXRC1dg5S4Yg+Y2gvS1IfQruP9O1HY+4C9OVP0PdnCgNZKtZLESI8JHyKoa0YAd1SwRCxA9aKCFRcBIjUmM0RZ/ozEyBKUVxkyZMbVw2VdkqTSTZ+iiKGDGs+YN+w3YjjiWRl9pK5SnnOL/QTw8Z5AAC+MP7BGW0uML3AXcxRloixMl/KFIGCgFLTyCDJ2QetPXv23Gn14/LAr/4xozG/5/YPSASRKdGI+tSNv/O0RX4kAh5qPWKxLS6e5HLkot4hEcmk6KAsZ2nGLJf+mrlQWqeN/InrqJb6/s9LyeFHmQfhkzvAGBy3RVTXbOXAkIdI3G218eJecQ6TLKy4StHSo7MjduCajHr5ANp/r4TA1DstjbK9g4N8+xR6TVI1+G2A3a05ODN9bni38kI+OlovkTcVT7YzbXv7fB7pfLZ5QQR1SyJo1QBLe3tst0ea7FVZIOk2iJZJkGAzKluhz4wDqnkzGgX1TVQZHUQHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(31686004)(36756003)(38100700002)(2906002)(41300700001)(30864003)(83380400001)(66574015)(31696002)(86362001)(66476007)(66946007)(316002)(54906003)(6486002)(66556008)(2616005)(224303003)(110136005)(478600001)(8936002)(5660300002)(6666004)(26005)(186003)(6512007)(53546011)(4326008)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFd4WWo4dWs2Z1BPN0NPOFl0dWllNDlBVFlHYUsrRmFzcWtPSUdSQmRPOEMr?=
 =?utf-8?B?dkUwT0EvbWlUY2FPVUMycGlCNFpkVlA5WHZ5UnhQT3dWTzU3SHlSY2ZkY21v?=
 =?utf-8?B?Z1JNSUErQUNTc0ZyM21OOUswTXB4cUFvVHQxRTFSM2JTL3pqNkY0OHNIUUFJ?=
 =?utf-8?B?NFFRMExweml5a1Y1RCtxemZlSGMrczJBZDNsQnV4MlIxQlBLUHJSa3BMU2c1?=
 =?utf-8?B?V242YXdGeXR2QW5TOHV5SmlmYTVaakJnYnlXWWY5eXFrWFJNUVpSNWc0Njgx?=
 =?utf-8?B?VlFZOFJTbDExblJqT3Q0V2FVUGo4TWxFY2tza0p5YkptZE02dTZhQ000UlhX?=
 =?utf-8?B?cjRTOEFMS2Z0ZHJGc2tHRTBWdzV2Vm43eStScmJ0NnFsV1MzcGNBNDhGL2Np?=
 =?utf-8?B?M3c0OXV0Tkh1UWNSRkt1ZjhCNC9HbVprVWhCZkZoT1lvaEovNzhBTXJLOG9G?=
 =?utf-8?B?aE5VYW5kR3NpbFBNYSs3am5GWG83ZmpBUmYweWxIMHhkL2NncVA1TytBdThr?=
 =?utf-8?B?dWttOXkvYldteEhtSGcwakNjTUY5SU1lcmRiL1RYdlNDcis0QStkSlh3S0tN?=
 =?utf-8?B?b2gzTjdzaFFSaU5RVmhORFpJOUtTRTRROFRJT2NqYkdYN3BRbzVWZGhkS2d1?=
 =?utf-8?B?MlU3LzhaMFU4UTVadlF1MW16YzVYclY3STFMQ1R5RURBZHI4eVNTVDcyL2Yw?=
 =?utf-8?B?SjNnNk1OVzBQd3pQZWJpcW9XbzlpMnZ1WnN2cy9OZytYL3ZKbGh2K3U4YXR4?=
 =?utf-8?B?U2J4N2Y4VUEyTk00dEZiakY5cWh0aEZ2dStGWFZ6cTh0enlkQi9CZE1udnMv?=
 =?utf-8?B?em1JeU5KMUVWc2VpRGM1SW80SjhwaFMycjZzNE0xMVhvcWJZcEgzbmFJdUNs?=
 =?utf-8?B?TzZabFpNdkFuR0MzU3V3cjBZSFpHc2hFcVpFWmFNbVRRUm9UNXV2Zkk5bUdV?=
 =?utf-8?B?Wkk1a3pKYmZvcWVOVGFuU0U3RWNVK1VYYVgrdUlFdlNteGxOMUZvZjNoUzNO?=
 =?utf-8?B?NFdHK1d1SVNya05ucHVmRlppRGtqMUdYZjU3cFhDclJLZUZWNjhhSE5lSnhp?=
 =?utf-8?B?d2hxbk8zcXlraURGMVpkTDlYckxGYkdPbi9zOFQvc1B5V2NTb0tkOUhLcGds?=
 =?utf-8?B?d2JwN0EzR1QraG5KRno5WFNHZGJhZ1djeld5QWNJZTVpNlA4Vk16VFUveGdV?=
 =?utf-8?B?Y0llbU5HR2gvTXdWSTNFNlFPME16S1RxeEJyOUZNQ3UwTUR0N3VGdWhGN0VS?=
 =?utf-8?B?STAycGxLUXpISkJVNUs3NUp5cFNnQXdmZndqQkZobXRPcHdIZEsxcnhxU1hP?=
 =?utf-8?B?RUo5K0V0M256T0JNeHRNVUtPODNicERDS3V0anN3d0M3cUw3Wk5zNlJsVmQ2?=
 =?utf-8?B?Q3dURzR5empibk9GLzNRM2R1a29ZVWNqNWdKd25HMlorZmRnZVBkd1dzUlFJ?=
 =?utf-8?B?YU56S3RYb0FSV01qQy83ZE8vMElONjU1YkI4dG9vYjM4SkJ5ZEdTVm5mdzBH?=
 =?utf-8?B?L0hrZTVOeVQvSDIxQnh5WFpzaDNNRkovMGlJaHU0dTNGWXJRRWRtRjJpNk5h?=
 =?utf-8?B?UkhiU1dHblBKRkdhYTk2bk1KRDdTZ2xlc0FtWUg0MXdMSTRPc1lNUUVQUXRG?=
 =?utf-8?B?VDhSUFhhdGhWczF5Zy9kQjRkVUU1VFB3SHNzelZCMkl1RXhEbjVHdE1NeGpk?=
 =?utf-8?B?bXZwR0hzWHczQllBdFJSK3ZHQnBFbkV4L0g5V0pxWVkvZW54RjY3YlFoS2px?=
 =?utf-8?B?SE1jdDBjd3VKVVdnZFR0VUNpWXV4ZFN0ZjZjc0lnUDhnY0pHV3hMdGdOYUFK?=
 =?utf-8?B?SUpmZEFCbnpKSzJFRjBVRXI4SUpHVlRKY2Z1enpKQ0FVeU1YMm1NcnNXTmc5?=
 =?utf-8?B?YjBPUndoTklMS1daL0M1R3RReUR6M015dkQyRjRMbGFyZ09mVDBSdm40dHJj?=
 =?utf-8?B?TVhRVnpuY05SRHRYemh0OGtGOHplSldsSUdhbFVoTXdDRXFoWlJaZGl6OXc5?=
 =?utf-8?B?aXdnaEFSdmpxTTQ4ZjQ0L09zYkFqTXpjQll0a0pwNFljNHZEeGhPdHU0ZzFL?=
 =?utf-8?B?QTNyQUdwWHVUcnU2cHZ0V2pES21LR2pKdEswRlpIbG5kVXYzR1I2aHRNV2ti?=
 =?utf-8?Q?7Xju6mvat5OTsQ2xKUxW7gDwM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac7e37d-13b9-49b8-9ff7-08dad049c9f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 07:34:17.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULOSUg9IK+WIvS0NM5hgih/aVGMEG918okuTO/X3II99I+XGK+KXu796HpemN+GyoOLsHRqqSWPH3Cr9yPP04A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/25/2022 8:05 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
>
> -----邮件原件-----
> 发件人: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> 发送时间: 2022年11月24日 22:57
> 收件人: Christian König <ckoenig.leichtzumerken@gmail.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> 主题: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information into amdgpu_vram_mm
>
>
>
> On 11/24/2022 1:17 PM, Christian König wrote:
>> Am 24.11.22 um 08:45 schrieb Wang, Yang(Kevin):
>>> [AMD Official Use Only - General]
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Thursday, November 24, 2022 3:25 PM
>>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
>>> amd-gfx@lists.freedesktop.org; Paneer Selvam, Arunpravin
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information
>>> into amdgpu_vram_mm
>>>
>>> Am 24.11.22 um 06:49 schrieb Yang Wang:
>>>> add vram usage information into dri debugfs amdgpu_vram_mm node.
>>>>
>>>> Background:
>>>> when amdgpu driver introduces drm buddy allocator, the kernel driver
>>>> (and developer) is difficult to track the vram usage information.
>>>>
>>>> Field:
>>>> 0xaaaaaaaa-0xbbbbbbbb: vram usaged range.
>>>> type: kernel, device, sg
>>>> usage: normal, vm, user
>>>> domain: C-CPU, G-GTT, V-VRAM, P-PRIV
>>>> @xxxxx: the address of "amdgpu_bo" object in kernel space.
>>>> 4096: vram range range.
>>>>
>>>> Example:
>>>> 0x00000003fea68000-0x00000003fea68fff: (type:kernel usage:vm
>>>> domain:--V- --V-) @000000001d33dfee 4096 bytes
>>>> 0x00000003fea69000-0x00000003fea69fff: (type:kernel usage:vm
>>>> domain:--V- --V-) @00000000a79155b5 4096 bytes
>>>> 0x00000003fea6b000-0x00000003fea6bfff: (type:kernel usage:vm
>>>> domain:--V- --V-) @0000000038ad633b 4096 bytes
>>>> 0x00000003fea6c000-0x00000003fea6cfff: (type:device usage:user
>>>> domain:--V- --V-) @00000000e302f90b 4096 bytes
>>>> 0x00000003fea6d000-0x00000003fea6dfff: (type:device usage:user
>>>> domain:--V- --V-) @00000000e664c172 4096 bytes
>>>> 0x00000003fea6e000-0x00000003fea6efff: (type:kernel usage:vm
>>>> domain:--V- --V-) @000000004528cb2f 4096 bytes
>>>> 0x00000003fea6f000-0x00000003fea6ffff: (type:kernel usage:vm
>>>> domain:--V- --V-) @00000000a446bdbf 4096 bytes
>>>> 0x00000003fea70000-0x00000003fea7ffff: (type:device usage:user
>>>> domain:--V- --V-) @0000000078fae42f 65536 bytes
>>>> 0x00000003fead8000-0x00000003feadbfff: (type:kernel usage:normal
>>>> domain:--V- --V-) @000000001327b7ff 16384 bytes
>>>> 0x00000003feadc000-0x00000003feadcfff: (type:kernel usage:normal
>>>> domain:--V- --V-) @000000001327b7ff 4096 bytes
>>>> 0x00000003feadd000-0x00000003feaddfff: (type:kernel usage:normal
>>>> domain:--V- --V-) @00000000b9706fc1 4096 bytes
>>>> 0x00000003feade000-0x00000003feadefff: (type:kernel usage:vm
>>>> domain:--V- --V-) @0000000071a25571 4096 bytes
>>>>
>>>> Note:
>>>> although some vram ranges can be merged in the example above, but
>>>> this can reflect the actual distribution of drm buddy allocator.
>>> Well completely NAK. This is way to much complexity for simple
>>> debugging.
>>>
>>> Question is what are your requirements here? E.g. what information do
>>> you want and why doesn't the buddy allocator already expose this?
>>>
>>> Regards,
>>> Christian.
>>>
>>> [Kevin]:
>>>
>>> For KMD debug.
>>> The DRM buddy interface doesn't provide an interface to query which
>>> ranges of ram(resource) are used.
>>> It is not easy to debug in KMD side if driver create BO fail at
>>> specific location.
>>> and from the view of KMD, the VRAM at some locations has special
>>> purposes.
>>> with this patch, we can know which range of vram are actually used.
>> Well that's not a good reason to add this complexity. Debugging
>> doesn't justify that.
>>
>> Please work with Arun to add the necessary information to the buddy
>> allocator interface.
>>
>> Regards,
>> Christian.
>>
> Hi Kevin,
>
> I will check and list down some of the necessary information that we can add to the buddy allocator interface.
>
> Regards,
> Arun.
>
> [kevin]:
>
> Thanks,
> but some information is AMDGPU specific, so I hope we can add some flexible interfaces to adapt the different driver's extension.
We have a debug interface in drm buddy module drm_buddy_print() 
function, it prints the available memory in each order at any instance 
and we have
drm_buddy_block_print() function to print the address range of each 
blocks and its size. Please check if it solves the purpose.

Regards,
Arun
>
> Best Regards,
> Kevin
>
>>> Best Regards,
>>> Kevin
>>>> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |   6 +-
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   3 +
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 130
>>>> ++++++++++++++++++-
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   1 +
>>>>     4 files changed, 136 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 90eb07106609..117c754409b3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -53,7 +53,7 @@
>>>>      *
>>>>      */
>>>>
>>>> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>>> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>>>     {
>>>>         struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>>
>>>> @@ -66,7 +66,7 @@ static void amdgpu_bo_destroy(struct
>>>> ttm_buffer_object *tbo)
>>>>         kvfree(bo);
>>>>     }
>>>>
>>>> -static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>>>> +void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>>>>     {
>>>>         struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>>         struct amdgpu_bo_user *ubo;
>>>> @@ -76,7 +76,7 @@ static void amdgpu_bo_user_destroy(struct
>>>> ttm_buffer_object *tbo)
>>>>         amdgpu_bo_destroy(tbo);
>>>>     }
>>>>
>>>> -static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>>>> +void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>>>>     {
>>>>         struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>>>         struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo); diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> index 147b79c10cbb..3f6a687309a7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> @@ -332,6 +332,9 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo
>>>> *shadow,
>>>>                              struct dma_fence **fence);
>>>>     uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device
>>>> *adev,
>>>>                                             uint32_t domain);
>>>> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo); void
>>>> +amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo); void
>>>> +amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo);
>>>>
>>>>     /*
>>>>      * sub allocation
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> index 27159f1d112e..165f4f1a8141 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> @@ -23,9 +23,11 @@
>>>>      */
>>>>
>>>>     #include <linux/dma-mapping.h>
>>>> +#include <linux/interval_tree_generic.h>
>>>>     #include <drm/ttm/ttm_range_manager.h>
>>>>
>>>>     #include "amdgpu.h"
>>>> +#include "amdgpu_object.h"
>>>>     #include "amdgpu_vm.h"
>>>>     #include "amdgpu_res_cursor.h"
>>>>     #include "amdgpu_atomfirmware.h"
>>>> @@ -38,6 +40,122 @@ struct amdgpu_vram_reservation {
>>>>         struct list_head blocks;
>>>>     };
>>>>
>>>> +struct amdgpu_vram_node {
>>>> +     struct rb_node node;
>>>> +     u64 start;
>>>> +     u64 last;
>>>> +     u64 __subtree_last;
>>>> +     struct ttm_buffer_object *tbo; };
>>>> +
>>>> +#define START(node) ((node)->start) #define LAST(node)
>>>> +((node)->last)
>>>> +
>>>> +INTERVAL_TREE_DEFINE(struct amdgpu_vram_node, node, u64,
>>>> __subtree_last,
>>>> +                  START, LAST, static, amdgpu_vram_it)
>>>> +
>>>> +#undef START
>>>> +#undef LAST
>>>> +
>>>> +#define for_each_vram_mm_node(node, mgr) \
>>>> +     for (node = amdgpu_vram_it_iter_first(&(mgr)->root, 0,
>>>> U64_MAX); node; \
>>>> +          node = amdgpu_vram_it_iter_next(node, 0, U64_MAX))
>>>> +
>>>> +static void amdgpu_vram_mm_add_block(struct drm_buddy_block *block,
>>>> +struct amdgpu_vram_mgr *mgr, struct ttm_buffer_object *tbo) {
>>>> +     struct amdgpu_vram_node *node;
>>>> +
>>>> +     node = kvzalloc(sizeof(*node), GFP_KERNEL);
>>>> +     if (!node)
>>>> +             return;
>>>> +
>>>> +     node->start = amdgpu_vram_mgr_block_start(block);
>>>> +     node->last = node->start + amdgpu_vram_mgr_block_size(block) -
>>>> +1;
>>>> +     node->tbo = tbo;
>>>> +
>>>> +     amdgpu_vram_it_insert(node, &mgr->root); }
>>>> +
>>>> +static void amdgpu_vram_mm_remove_block(struct drm_buddy_block
>>>> +*block, struct amdgpu_vram_mgr *mgr) {
>>>> +     struct amdgpu_vram_node *node;
>>>> +     u64 start, last;
>>>> +
>>>> +     start = amdgpu_vram_mgr_block_start(block);
>>>> +     last = start + amdgpu_vram_mgr_block_size(block) - 1;
>>>> +
>>>> +     node = amdgpu_vram_it_iter_first(&mgr->root, start, last);
>>>> +     if (node) {
>>>> +             amdgpu_vram_it_remove(node, &mgr->root);
>>>> +             kvfree(node);
>>>> +     }
>>>> +}
>>>> +
>>>> +static inline const char* ttm_bo_type2str(enum ttm_bo_type type) {
>>>> +     switch (type) {
>>>> +     case ttm_bo_type_kernel:
>>>> +             return "kernel";
>>>> +     case ttm_bo_type_device:
>>>> +             return "device";
>>>> +     case ttm_bo_type_sg:
>>>> +             return "sg";
>>>> +     default:
>>>> +             return "unknow";
>>>> +     }
>>>> +}
>>>> +
>>>> +static inline const char* amdgpu_vram_domain_str(u32 domain, char
>>>> +*tmp) {
>>>> +     int index = 0;
>>>> +
>>>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_CPU ? 'C' : '-';
>>>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_GTT ? 'G' : '-';
>>>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_VRAM ? 'V' : '-';
>>>> +     tmp[index++] = domain & (AMDGPU_GEM_DOMAIN_GDS |
>>>> AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA) ?
>>>> +             'P' : '-';
>>>> +     tmp[index++] = '\0';
>>>> +
>>>> +     return tmp;
>>>> +}
>>>> +
>>>> +static inline const char* amdgpu_vram_bo_usage(struct
>>>> +ttm_buffer_object *tbo) {
>>>> +     if (tbo->destroy == &amdgpu_bo_destroy)
>>>> +             return "normal";
>>>> +     else if (tbo->destroy == &amdgpu_bo_user_destroy)
>>>> +             return "user";
>>>> +     else if (tbo->destroy == &amdgpu_bo_vm_destroy)
>>>> +             return "vm";
>>>> +     else
>>>> +             return "unknow";
>>>> +}
>>>> +
>>>> +static void amdgpu_vram_mm_debug(struct amdgpu_vram_mgr *mgr,
>>>> +struct drm_printer *p) {
>>>> +     struct amdgpu_vram_node *node;
>>>> +     struct ttm_buffer_object *tbo;
>>>> +     struct amdgpu_bo *abo;
>>>> +     char tmp[5];
>>>> +
>>>> +     for_each_vram_mm_node(node, mgr) {
>>>> +             tbo = node->tbo;
>>>> +             abo = ttm_to_amdgpu_bo(tbo);
>>>> +             drm_printf(p, "%#018llx-%#018llx:", node->start,
>>>> node->last);
>>>> +             if (abo)
>>>> +                     drm_printf(p, " (type:%-5s usage:%-8s
>>>> domain:%s %s) @%p",
>>>> + ttm_bo_type2str(tbo->type),
>>>> +                                amdgpu_vram_bo_usage(tbo),
>>>> +amdgpu_vram_domain_str(abo->preferred_domains, tmp),
>>>> +amdgpu_vram_domain_str(abo->allowed_domains, tmp),
>>>> +                                abo);
>>>> +             else
>>>> +                     drm_printf(p, " (reserved)");
>>>> +             drm_printf(p, " %llu bytes\n",
>>>> +                        node->last - node->start + 1);
>>>> +     }
>>>> +}
>>>> +
>>>>     static inline struct amdgpu_vram_mgr *
>>>>     to_vram_mgr(struct ttm_resource_manager *man)
>>>>     {
>>>> @@ -288,6 +406,7 @@ static void amdgpu_vram_mgr_do_reserve(struct
>>>> ttm_resource_manager *man)
>>>>                 dev_dbg(adev->dev, "Reservation 0x%llx - %lld,
>>>> Succeeded\n",
>>>>                         rsv->start, rsv->size);
>>>>
>>>> +             amdgpu_vram_mm_add_block(block, mgr, NULL);
>>>>                 vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
>>>>                 atomic64_add(vis_usage, &mgr->vis_usage);
>>>>                 spin_lock(&man->bdev->lru_lock); @@ -540,6 +659,8 @@
>>>> static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>>>                 vres->base.start = max(vres->base.start, start);
>>>>
>>>>                 vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>>>> +
>>>> +             amdgpu_vram_mm_add_block(block, mgr, tbo);
>>>>         }
>>>>
>>>>         if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>>>> @@ -583,8 +704,10 @@ static void amdgpu_vram_mgr_del(struct
>>>> ttm_resource_manager *man,
>>>>         uint64_t vis_usage = 0;
>>>>
>>>>         mutex_lock(&mgr->lock);
>>>> -     list_for_each_entry(block, &vres->blocks, link)
>>>> +     list_for_each_entry(block, &vres->blocks, link) {
>>>>                 vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>>>> +             amdgpu_vram_mm_remove_block(block, mgr);
>>>> +     }
>>>>
>>>>         amdgpu_vram_mgr_do_reserve(man);
>>>>
>>>> @@ -747,6 +870,9 @@ static void amdgpu_vram_mgr_debug(struct
>>>> ttm_resource_manager *man,
>>>>         drm_printf(printer, "reserved:\n");
>>>>         list_for_each_entry(block, &mgr->reserved_pages, link)
>>>>                 drm_buddy_block_print(mm, block, printer);
>>>> +     drm_printf(printer, "vram usage:\n");
>>>> +     amdgpu_vram_mm_debug(mgr, printer);
>>>> +
>>>>         mutex_unlock(&mgr->lock);
>>>>     }
>>>>
>>>> @@ -769,6 +895,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device
>>>> *adev)
>>>>         struct ttm_resource_manager *man = &mgr->manager;
>>>>         int err;
>>>>
>>>> +     mgr->root = RB_ROOT_CACHED;
>>>> +
>>>>         ttm_resource_manager_init(man, &adev->mman.bdev,
>>>>                                   adev->gmc.real_vram_size);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>>> index 0e04e42cf809..a14c56e1e407 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>>> @@ -28,6 +28,7 @@
>>>>
>>>>     struct amdgpu_vram_mgr {
>>>>         struct ttm_resource_manager manager;
>>>> +     struct rb_root_cached root;
>>>>         struct drm_buddy mm;
>>>>         /* protects access to buffer objects */
>>>>         struct mutex lock;

