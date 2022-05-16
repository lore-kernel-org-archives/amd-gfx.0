Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8127C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 16:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814EB10E3E0;
	Mon, 16 May 2022 16:23:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F050D10E325
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 16:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvfxlklBCzvsdkRAuEC1XMIVMHdrK1aPVW8JsbDHoeEcKMUlEmxR3/GqIDAWQs3oMK8XowyHLDD8IPSvff5w5bsO8jjyQkLwfUx8Thd2p9J9XDgDVj6JfyzF4Ktb9mHFhtLjJ20MRq8dLGyKVH2Yrv046GbgR9zsBs1Ao8kR9VhFlR54crl416cwCbK7LbBU33W/9caFntE+F2mmw4HX1J4GdMbEqZmURy/acXBdlQQ1ccuhF5YWJEWF8U0FXM4xjIgqParHXpgA09ZTXPu8vwGKFuj6U80FsynFxzfah/XzIjBimeJpJ79Qt6qtVS3XPk8QGVBW7PWGAwS1FZbiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cJ48CM34OyfIOIm+gsgb5aMr2xGtIydxWr0WFlu10c=;
 b=eyUALY0xUXAY5t/Zj7NHD2XfnF2qXlHJxuvSZHJqB0srfYaD9dIWqpvRfUx8UiL7DncBgwUP43hDSJF/ZxrUDKmAvzHewvglp2Tb5P16hXeAg66IGwARRwFbPY29zcFQm4WEqGqMpbElZgQn2aR8GrivkdJHMs01g+BnN3s1YnUgUh5xB7P/bmYf6zd1TSLxHHpvMGv34cRD/ugEfgoP4H/FC6nVbuDdY0lgoqOzeVSI9i9digrHFIuaonynkQH1nN/vgDoB5LWv8vJD1xaym6k85fgO1Y7EFtCh1J3m7m2qBwQKLRxPQ8n1NSXJ+2wa52xJjOEc99Hb0LaTjoa5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cJ48CM34OyfIOIm+gsgb5aMr2xGtIydxWr0WFlu10c=;
 b=sA00v3TRUzwXPKn8ycuWFF0y/fCtQd3+sr0c+wu4P/Kqfx2wSqbPoCVGuboBg7dh4rC3pQ54KdC4+m3pt+xn7ZXD2kIjw8tWqfQaYc7lL02n/ODJtBI/B8InsHTqGbRaUc3vddguZ4DXWn/yBLy/64t/TkjQAL3hlcfEFExlOHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BYAPR12MB3464.namprd12.prod.outlook.com (2603:10b6:a03:d9::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Mon, 16 May 2022 16:23:23 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 16:23:23 +0000
Message-ID: <e956c8a1-08fe-6e46-5d3a-0e3be4e80692@amd.com>
Date: Mon, 16 May 2022 12:23:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
Content-Language: en-US
To: Daniel Vetter <daniel@ffwll.ch>,
 "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
 <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
 <CAKMK7uGMsxAJGaPbPR9fhmdwKgV=hOG73H=Ju0hYU9G=8hfa7A@mail.gmail.com>
 <BN9PR12MB5145FCDE79EC4C5600CFCD858DCB9@BN9PR12MB5145.namprd12.prod.outlook.com>
 <CAKMK7uEkTZzTc+WU+6gFh7nrCuywpb4e_K=J4Row=Od1sEaPtw@mail.gmail.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CAKMK7uEkTZzTc+WU+6gFh7nrCuywpb4e_K=J4Row=Od1sEaPtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::25) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe4ed36-da47-476b-096f-08da3758658e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3464:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB346440B1F4D19B85765199FF82CF9@BYAPR12MB3464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hK7PJZuAThbYQtddioxSsJ1xryshLb6FNqEdGs01SqNvY5xeVSfM3f5gY4L/jhxbWjkKCAW7CL5hy1N7c8X0JG1JoU7724FZIp92oi5QU82fLAPFZ32e7QBdNkz6TTaQOOEYkv1066eLcvFsDMdabcAZ/AhhuSV+NdmmArdEmCEagJfGa/CJJFWIiDGXPW2Jvhf3Zf/tHZEWvecdhrednYFZH3c8zeKK9+q4Ybqul0l+ivy6uHsxQzZbXORecLzloZCHNobtCV59bqa3OGCyS73aVusUtY9Yo506/YmsZS2AJJhdXv8zbHgISrOTdT2gyaZ35tpEO6WfDYtJhGOtjOz8trdw4YrwSn4t0lZWLdCV3/MshMtetKyGu2vxPk7brmy9bzqtYJ/isOuSDhtedYPmo6xK5/PwevfryGfEvns1WQMxXj18vBzOZz17qSdJO0Llvc0knHTwR244Udqc820rnAjOo9Gv+qdVMBD2rEYRHLjF5jx2Qv+oEUOXIpb3h20niWoNlCMVH4z5txpmlnlhnsbVXRcGW4ajgo+MVcOLvnRu9H32etu6sVmudgfhrdIQhNUygNjsUl/zzIk4VU18ZBbPXEX6jo6rxE+cLq4n7dfy34AY9AbUwoeSlMpEe/0ElI4r6CCSYVNAm67EGyusMxCQGkYSzGxfPjlZ+IuSVgCloqNdTGiX8N2QLHMNbqnIW3fBmTLTzOW4pGUFamnGSqDLoieDvbhPXiw3F+WrN3JTI5mIZ7YltPTOSidQRXprxb7MMOwYdNG21Efln6ba3240H3pHjAiHGyZ8Ru+2UOaPXjLDWM9Ns/joqDeq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(316002)(86362001)(4326008)(54906003)(110136005)(36756003)(5660300002)(31686004)(8676002)(8936002)(6636002)(2616005)(186003)(6512007)(45080400002)(38100700002)(31696002)(26005)(6506007)(83380400001)(53546011)(2906002)(966005)(508600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OERkeVRpZzVtamc2dExRbGxnM0VublJBekw5RW5IVWhGOEZlNkF0bFlWUmN0?=
 =?utf-8?B?eFhvalQzczhtSHlHOFRWMHdCNTB6TW4wQ3pacitQVFlveFNtRDJxN3hXVFhl?=
 =?utf-8?B?eGQ5ZWliQUFWNkJsL1dTamFPY1RDbHF0SmJVY29QZUxqeDl3WUZLUTdZanMz?=
 =?utf-8?B?YzNSd1E0TzFwalR4SklFK3ppc2J3Z0NxaGpTazNudmpyZjJTUXFnYjJIcTVk?=
 =?utf-8?B?d0M5VEwyc0tPdHVqYUx1V2M5bzY0Y1pxNlh6cEpyVHR4SkVSU0x6ZFpHVktF?=
 =?utf-8?B?OHorSUJ4T2w1RTdTaUQyVjFvRE9SdDY1cTF5MnBFTm9Wd2I3ZEVjL1UwSVl0?=
 =?utf-8?B?YTU3UVU5a3BQTkhTVVdheHNvMGlYWnk0VU5JRXBOLzFUaHdQL21XbSt6NUQ1?=
 =?utf-8?B?VFViVFRkWlM4S2E3WFJveUlXbXdWWitNNVZHQS9OSFdJVHRDcDlYaXNyYWw5?=
 =?utf-8?B?bzRoQmNjY0cwdG9wRnVhVC9WL1pXbDNySUwzRVN2Y01sNWtsWXNiR1NMNVI4?=
 =?utf-8?B?TjhwbTU0RXd5NFpwNmgvQTh0QnY3eDNPNnZGS0ZEaTFDSS8vTlNBQnhwZ2xV?=
 =?utf-8?B?S3AvMXlnTUczS1RXSXRoeUFhQmNZRlhPNGJNMWVVRmtmM3p4eU5NSWxPVDlq?=
 =?utf-8?B?aHpGSTBhSG1MQ3dsOW9tTkgxbXZwaWZLUW9xblVHQnRxejFuRkZZbVZweTQ2?=
 =?utf-8?B?MTZTUnp6bHBrbzdza2tKTkNEaTlGTkNGck8xWlZWSVVzSHZObktPZzk1L3JK?=
 =?utf-8?B?c3ZabkJ1SkduNWQySGk5ZzNLMTgxbUhGWVVYMHBRcjhFVzRGMVFNUzgvbkc4?=
 =?utf-8?B?TlZqQlRuaUhIaGJnemtDaFlJRThvTkkxS1RROSttZ3lFL2Y3RUNjOXNHVEhB?=
 =?utf-8?B?RmlYV0R4bEdqd2F1bnJZd1RMblllVWZoUmlCVmtqSjFPRWJ5emZ2ZEExRjV3?=
 =?utf-8?B?cDNTMnJ0SmZFZ3NnV0hBTmgxaW5IQUNVZFovSEVtV1pvT21kVWNhN2tJUGd3?=
 =?utf-8?B?SjNIZEZ0L0lGRGZjMHBRbEN5YUVCMUtHank2dVIxam1ISFFOcjErVjdudGZ3?=
 =?utf-8?B?aTlUcmxBV1o4c3VYN1J3Z0NlZE5hR05jZE5NdVVqUG1pTSs5bWxDaFFQeW5R?=
 =?utf-8?B?YWQ4UVhYMTRWL1JJY3hTVmpTZFJCY3VDeU1EQnhCZWRxRm5JVnRrK09OODVT?=
 =?utf-8?B?bXpFbitKSEFMSDhCYTYreHh4aThvWFdEQTFRbmRmWHJrWDdrMTBwYTNQQisz?=
 =?utf-8?B?N3oyV24vbmUxUWFFNmpud0tVN2lDTCtISEozZWdmdURCUDFpdVNrdUhPaDJV?=
 =?utf-8?B?L2h4dC9VUm44S1dlQWs2Tmdta2tCRldNcGw0enJFazhTZnVVVEUwYVI2OFJn?=
 =?utf-8?B?bjE0U0RhTld0eTZOYitZQm8wU08wajJhMVFTMmg3Z2pSQWdhK09nOVVFNUFT?=
 =?utf-8?B?WlFRUDZiQ2JFTzMyaG9wek9JWndqd25iZkRHWHI3NVNCK0l2TnB0QmNUMmxB?=
 =?utf-8?B?TlF5V011MldqbmxsWTZqaTFDQXVibm5nZ2xDMDZrVUd6RTlFOW5JcjRVMVlY?=
 =?utf-8?B?SVBIdXpVWFJXeG45YTlpeGVud0RoaXR4T2M3MzBKek04UnV5WnVDeXNFa052?=
 =?utf-8?B?Mlh0NnJEK0tlQythN2pHMGRibjJkekx6YlJJYmtpOXF1bHJlQVR6eW96SEFw?=
 =?utf-8?B?b24rZE5tYk9Idnp1cnlqalE1SDN5aWo1ZUgvOGdzWTVEc25aTTNPdVBSeXd6?=
 =?utf-8?B?VWF6YkZBMXRFZlpWcnJ3WnltWnlhRGRuMC82elQ3ZjVxdFNkdzkrTUNGb1NB?=
 =?utf-8?B?NVIvRkVPMlhMYW9iNWxZL3I3TnpHcEIzRWNnYjV6TEtRSkFoQnZ5UDdQVkRN?=
 =?utf-8?B?SmRyeXpXZmpWdTFoNEJnOFhOZTVIMXFZeU5reDREWk1ud1pySEF4QUU2YU9y?=
 =?utf-8?B?dDlVQ0gvSG1mamFGckc4MVcrd1ptU3NhcklEZzh6Y0dRYXpIOFNlODRTRkFQ?=
 =?utf-8?B?TjlsUlBVM3o3c25uYWRzeWNYY1VvemNIMXhTRnlqdzBkcnpRQThwZGRqL1cx?=
 =?utf-8?B?YzI5RVQ0a1ZDdmo3Y3pWK285VitIWmt4VVNrWDllN1BzeWl1d0ttZk9iNXBG?=
 =?utf-8?B?bTAyRWhlTE5La3E4SjZYVHlkbHRUS2U4LzkydXFDc1lSbTcyUHYwOTNGL0Z4?=
 =?utf-8?B?S1hxREJ2UXhsRWY2NHhsdFZYMjRtZjlVVm5UeVNqVlBoVjYrWHBZVFRpM0Jq?=
 =?utf-8?B?YktGRW94bnZ5MWlMQ1I3R01DczlaOWExZ2t4WmRDQ0lxTjhndzNheFcrQjlD?=
 =?utf-8?B?c3ppR1hFS1R1dnFBVWE3NjRXYmNMUm9zTkxBeHd5TFRXZVR1SXREZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe4ed36-da47-476b-096f-08da3758658e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 16:23:22.8065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F21Va2exOmqqGxWUDOazHRVHhP3F4ksmo7NbbGXWFMd5UYvMxms96iNJQJgPO7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3464
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-12 13:39, Daniel Vetter wrote:
> On Thu, 12 May 2022 at 19:22, Zhang, Dingchen (David)
> <Dingchen.Zhang@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>> Hi Daniel
>>
>> Thanks for your comments and explanations. I replied in-line and look forward to more discussion.
>>
>> regards
>> David
>>
>>
>> From: Daniel Vetter <daniel@ffwll.ch>
>> Sent: Thursday, May 12, 2022 7:22 AM
>> To: Alex Deucher <alexdeucher@gmail.com>
>> Cc: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
>> Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
>>
>> On Wed, 11 May 2022 at 17:35, Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Tue, May 10, 2022 at 4:45 PM David Zhang <dingchen.zhang@amd.com> wrote:
>>>>
>>>> changes in v2:
>>>> -----------------------
>>>> - set vsc_packet_rev2 for PSR1 which is safer
>>>> - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
>>>> - add DC/DM change related to amdgpu PSR-SU-RC
>>>>
>>>>
>>>> David Zhang (18):
>>>>    drm/amd/display: align dmub cmd header to latest dmub FW to support
>>>>      PSR-SU
>>>>    drm/amd/display: feed PSR-SU as psr version to dmub FW
>>>>    drm/amd/display: combine dirty rectangles in DMUB FW
>>>>    drm/amd/display: update GSP1 generic info packet for PSRSU
>>>>    drm/amd/display: revise Start/End SDP data
>>>>    drm/amd/display: program PSR2 DPCD Configuration
>>>>    drm/amd/display: Passing Y-granularity to dmub fw
>>>>    drm/amd/display: Set default value of line_capture_indication
>>>>    drm/amd/display: add vline time in micro sec to PSR context
>>>>    drm/amd/display: fix system hang when PSR exits
>>>>    drm/amd/display: Set PSR level to enable ALPM by default
>>>>    drm/amd/display: use HW lock mgr for PSR-SU
>>>>    drm/amd/display: PSRSU+DSC WA for specific TCON
>>>>    drm/amd/display: add shared helpers to update psr config fields to
>>>>      power module
>>>>    drm/amd/display: calculate psr config settings in runtime in DM
>>>>    drm/amd/display: update cursor position to DMUB FW
>>>>    drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
>>>>      support
>>>>    drm/amd/display: PSR-SU rate control support in DC
>>>>
>>>> Leo Li (1):
>>>>    drm/amd/display: Implement MPO PSR SU
>>>
>>> A couple of suggestions from Daniel on IRC:
>>> 1.  Might be good to extract the "calculate total crtc damage" code
>>> from i915 in intel_psr2_sel_fetch_update, stuff that into damage
>>> helpers and reuse for i915 and amdgpu
>>
>> To expand a bit on this. There is currently a helper for total damage,
>> but it's at the fb/plane level for drivers which need to upload
>> buffers (usb/spi or virtual) drm_atomic_helper_damage_merged(). That
>> one probably needs to be renamed to signify it's about the plane, and
>> then we need a new drm_atomic_helper_crtc_damage_merged() which
>> (extract from i915 code ideally) which computes total crtc damage for
>> stuff like psr2/su or the command mode dsi panels (unfortunately none
>> of the drivers for android for these panels have been upstreamed yet).
>>
>> <<<
>> Checked the DRM comment for the helper `drm_atomic_helper_damage_merged()` and
>> quoted below:
>> *****
>> Drivers might want to use the helper functions drm_atomic_helper_damage_iter_init()
>> and drm_atomic_helper_damage_iter_next() or drm_atomic_helper_damage_merged()
>> if the driver can only handle a single damage region at most.
>> *****
>> Currently for amdgpu, the multiple damage clips combination (merging) is handled in
>> DMUB firmware. And the DRM comment shows that the usage of "damage_merged()"
>> helper is for the driver which can only handle single damage region at most.
>>
>> Since AMDGPU is capable of handling multiple damaged clip (in DMUB FW), can I
>> understand that the group of helpers of `damage_merged()` in DRM is not mandatory
>> but optional?
> 
> Ah I didn't see from a quick read that this was possible. How does
> this work when the plane is enabled/disabled or resized or moved?
> -Daniel

Hi Daniel,

When a plane is disabled, enabled, and/or resized(*), PSR is temporarily 
disabled. The mechanism to do so isn't in this patchset, but was added 
when PSR1 was first introduced to amdgpu_dm.

In short, amdgpu_dm will disable PSR whenever DC requires a full update 
to program an atomic state (needs bandwidth recalculations and/or 
shuffling hw resources). For DC, enabling, disabling, and changing the 
scaling of a plane are considered full updates.

When the plane is moved, both the old and new plane bounds are given to 
FW as dirty rectangles. (*)Resize should fall under the same bucket, 
though DC would consider that as a full update. I think disabling PSR 
would take precedence... will give this another spin to check.

Thanks,
Leo

> 
>> I also think that the split between dc and kms is a bit funny, I'd put
>> only the resulting damage rect into dc_pipe and do the computation of
>> that in the drm/kms linux code outside of dc functions (or in the glue
>> code for dc), since I'm assuming on windows it's completely different
>> approach in how you compute damage. Especially once we have the crtc
>> damage helper on linux.
>>
>>> 2.  The commit message on "drm/amd/display: Implement MPO PSR SU" is a
>>> bit funny, since if you use the helpers right you always get damage
>>> information, just when it's from userspace that doesn't set explicit
>>> damage it's just always the entire plane.
>>
>> <<<
>> The current implementation to mark the entire MPO as dirt RECT is not the final
>> version. Our next step is to implement the translation of DRM damaged clips to
>> DC regions and pass to let DMUB FW to handle, which is able to handle at most
>> 3 damaged regions for each DC surface.
>>
>>
>>
>> Yeah so that one was just another reason to use the helpers more in
>> amdgpu for this.
>> -Daniel
>>
>>>
>>> Alex
>>>
>>>>
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
>>>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
>>>>   drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
>>>>   drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
>>>>   drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
>>>>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
>>>>   drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
>>>>   .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
>>>>   drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
>>>>   drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
>>>>   .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
>>>>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
>>>>   .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
>>>>   .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
>>>>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>>>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
>>>>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
>>>>   .../amd/display/include/ddc_service_types.h   |   1 +
>>>>   .../display/modules/info_packet/info_packet.c |  29 +-
>>>>   .../amd/display/modules/power/power_helpers.c |  84 ++++++
>>>>   .../amd/display/modules/power/power_helpers.h |   6 +
>>>>   21 files changed, 887 insertions(+), 19 deletions(-)
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>
>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=05%7C01%7CSunpeng.Li%40amd.com%7C2e39f7cf022f46ee917b08da343e5867%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637879739624499442%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5Scos4KwScr%2F5MRPprq%2B0uyp76QRPDNRDt04afOVm5Y%3D&amp;reserved=0
> 
> 
> 
