Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E909C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 14:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E338310E002;
	Fri,  9 Dec 2022 14:37:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D69410E002
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 14:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9W+kX2KJiyRJIVVEe0Oo1DCGaMmZ92bZTWQwe5JeNOxtyzNqIiExPaMXjzUeX9ybeM8E9C9/sydmHW95ecBUxrQIt5xiSt+PW3gIvYppLwVLpJBLFjGeRSIDrNpzLt5Z9lLlBcJLolE7brwTfNIuoqDD8xVIr0k/02rbxYWpJ6HmnBRHdrEaBqDmGp6Fyov29Kz9e1LR0hFf6LsAKAMQ0sObN+CPoulF6L/odhYjPmrtGuYDjIjW0jVMnl56GRSUqrAjC2lTaLLjCrveDvgHcbdqEXbTAWnSoZ2Fl1GExnTFZj6VqzgxeN8La/9LjjBiyVe4X79S2SNGbovMHVUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk5rPpM4o1VLpiV4RIE0qdnbI403zkaOpPOrNDUXzUg=;
 b=WoBMdJgTAt3eNtzOYo/wnbwuK36OKSyrGDHlekVrtL5Yc/36yHqru0ihv4InR4QyGg3KWZffacSo3HGqZF+xY4agOigx8ka2uqvuhLT6a1SAudYv5t3eEi8zEmLsXvywBSG1CegirCUVW46d/8JZ5C8HhGPQF+fAiu0o/Smw7WieAdlz4IxpWBQlN0R5jaMwnMgdoK7eN9ker/ngFB7J7+5uMOrYRNx3tlNhLx73xC59Bitm8/XhyjcHhqmaivsVZ5YjFTb4TApIVZNOc8QLpTnuTrzvk91grVqqM8zDJBtCdr6acnp5Pd86brBXZwXRXdwYN2kVWUmpsOWDNXSqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk5rPpM4o1VLpiV4RIE0qdnbI403zkaOpPOrNDUXzUg=;
 b=wCC3lJB4wsUPdPUJBNvsLArjzpKRGoXGeM/7ZCh6bKi8DZ3OgDLMZb7IIuThGIVqqx3Ix2JCgqUmAfT3cfJXkS0D7KSLGZdEnrSfVtne/7KkQuMFFXs1GX8hIIEWBqRdvxH8qLmWTBAnVdPOVWHo0TozjDFGYAybOrZ+pVD8m7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 14:37:13 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::3abd:f044:1e8e:4261]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::3abd:f044:1e8e:4261%8]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 14:37:13 +0000
Message-ID: <c79dcbb5-5c8c-2620-1b92-15b643fb5530@amd.com>
Date: Fri, 9 Dec 2022 09:37:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bug][vaapi][h264] The commit
 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 on certain video files leads to
 problems with VAAPI hardware decoding.
To: Alex Deucher <alexdeucher@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Thong Thai <thong.thai@amd.com>
References: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
 <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
 <CABXGCsO-GLzahLgNtbzsM-HiPk7cZvHu56ckSMLD7XeUvf28hw@mail.gmail.com>
 <CADnq5_NMuc=moNDgL1bx9riUtkfuPvj4sLM-i3Qmf-rtAHV+=Q@mail.gmail.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <CADnq5_NMuc=moNDgL1bx9riUtkfuPvj4sLM-i3Qmf-rtAHV+=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: e30ba6df-cf0d-4457-be94-08dad9f2dc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCTPRuMXPYTg5q1ft37nDMUuW/Z6bfwiCj3OTUByNi8IsjXxKf5b39awSy17KcY3+DGWYuMKnFvfcN16j3hkIv3P0ILVC5bdr8FjzYIwNsVBBMiqHxoTX2RcAawipVRXcjJykzlXnkqT78yfYKbMDkxmNba+dknK5s8VuTPbS8eEsS06RXvdMXeTDYsLa952ArBXgypZXFXrof6uNObUVDzF5IjHyOdGvO4X1p7vfsrNwzP/xdxPsdMwyg1fnnFZv5Vl4fN9GYRbhxr3YzJYRYOkUcmhsCJFtpqpagzlvYkUwbrxbO4N5uIx+LHAOxf+vZ25V2hDfCmxquOLkdiWhmowGmohWiJ4xuzvnGdnKxNgIa/IFhZ5duHi4oRG169l9r19prNGJ/hubyJARDk0Aw9ZvODhP/PGULbTmMdMhJGpEUBrfm0C2731XHl2gHkEw0HsVFYTRCNRUzq3Gn8hJRxA8wNSjF1QQDJc6OF9fyiZhjmWAfaeYBKh60dBopBwxSNqOwTCfwhhQJYLwvcM8PHTg7DrVj9V6T28N9Z1zwNdeDvn1bbwiEjrvYZxY5xb+dnUBUvmCAKDKtEbrMb97lv512pdW8pYDQNqTh2ET7f2Rmeo9whDn3mvZeTTwWEFuVdmEy4l62sURdngePW6tkxlhEF+HQFbFBMR8YOs+HGmj9Tpf/A3TEhFsvAk47tn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(2616005)(66946007)(36756003)(5660300002)(66476007)(41300700001)(4326008)(26005)(86362001)(186003)(66556008)(19627235002)(110136005)(6486002)(31696002)(6636002)(316002)(6506007)(54906003)(53546011)(6512007)(8676002)(478600001)(966005)(83380400001)(2906002)(38100700002)(31686004)(44832011)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RJTEZMSnU3bU05ZDhBS0h0ZGhZMnFmNkZ5bVNqc0Erc0VJMzUyYXlRdnNW?=
 =?utf-8?B?VnBOajM4YUNhd29GYTI0aFE5NTRBd0J4S243NjhaQ2hYYlF6ZUxJVmU3SEVU?=
 =?utf-8?B?QkVoejFxK1hQZVcvVVJYNk4zdEZmK3daOHdVamRtUVdKU3dhNDZkdnZNZlZQ?=
 =?utf-8?B?TlpEY2k4NE9ScGpsRVN1dlBJdk1uN0hyMkE2VEVhL2RqeWZYVm5ZNjVzd1ZN?=
 =?utf-8?B?dmV3ZFZVVUdoaDJ0YUFtMnQ1eXlGRTNLVnhpcHI2ZUtlcXJESVBjLy9ndkRD?=
 =?utf-8?B?dkZMTzk0TmdjRkFTTDhlaEZYYk9CYWFkbC9qRXo1aHVNeVBydEJsNnVqYmxq?=
 =?utf-8?B?M3pkbGw4U3FRTTFXRnJBYi9iQ3FmSjJZM0JLYXFkdWNoTnIyM1p4Yjhyd1pN?=
 =?utf-8?B?QlBhb3ZmN25NTmROZFdkOWU0dnFtTVU3QTBod0JYZ1l3bEo1NTBOSDM0NHIz?=
 =?utf-8?B?OWh4V0Iyb3NCQU1NbWh4VW83bzFuT29hVmJtdVZlV2NPK2NoWmRnZWxKYzlO?=
 =?utf-8?B?QXFRM0ZyeHROWS9IN1F0djRWcmpFL1FhbWFnOHRTSE5RdEw0ekQ3LzJMblJF?=
 =?utf-8?B?TGpURnNvSUZ1RWFZNkxlZlFQWWtUUnVoQjhTb3FPYzZ0QTQ0TW04dnM2YXVV?=
 =?utf-8?B?c2ZEV25GWkprZ0U2KzBIQXdLQVhjT3J6US81TloyTWdHdm1NcnVQZ3Y3UmhD?=
 =?utf-8?B?UDFEdzdqcDh0U1lQbnNZUGxzcVdCQjZCNnE2ZzNKWTZ4SXR5SHl5ZThYOU9J?=
 =?utf-8?B?c2dTd041TjA5V2REL3JNU2plQkVxTTh2aDJPRit4aUpxZVBXK3R0b2J1QWZX?=
 =?utf-8?B?YnZwOU9iQWZGcHFHamJRR25XZUhRejJ2bFdzZFZXNy9BWUM4emwzREl5QTZ2?=
 =?utf-8?B?eDVnaHVkbGdvUlBtdks2Z2xobk45d01ha3hQbE9SUnNoaXBZM3ZOa1A1UkVH?=
 =?utf-8?B?T0JyYXBjNjZ2ZHpZZk96cktCY0tZaXRSbzV2OWUwa2dwVnpScXFFWHRVdUtj?=
 =?utf-8?B?WHRFTXdLZExxSHFkWjFMd2RFTWJkTkEvZTNwaVRDd2d0azJDSlU5VmlVUWZ3?=
 =?utf-8?B?Q1BsNGlQQWJaSkhFeG5GdjlMNS85UXlXUVRTRXF6cDg3NEhrNmR0Z0dYVUtq?=
 =?utf-8?B?Ni8yK3FWaGtadU9tNEJDdUhNeEFtZ0piL200K3FuODJJTUlUbUNIdlFkejRI?=
 =?utf-8?B?OG1JN1BXR1cxeG9sTTVpSjdIc2ZSUXovekcwMDlMU1BYQmE2ZGJNS0MySmpp?=
 =?utf-8?B?TjlXb1FKM2I2cFdxQTNIVEZFaWxFQVEydlUwTmtxMWlZeUVzQVV5ZUZ5MnpW?=
 =?utf-8?B?azBIWTBqdmJqMFNvQmRWUit4NmNMU1VUUjRYdHFQL29vcUk0SnNIT0hGOStS?=
 =?utf-8?B?dkI3K1FTbjdwQVRjenRTY3NWSmpRYmlTempOSnoxb1NUR1plN05TMUp4NHFx?=
 =?utf-8?B?TzBwM2dhR3E0ajBqNmdsZFVXcGhBRFFxRlBEMWdlem5Nbi95Wml5aFpnenYr?=
 =?utf-8?B?KzFSRW1yUmxCVzgxazRWRW9Bbkd5NndjYm5vN2ZIQkJzRU11eUtTbzhHMGpa?=
 =?utf-8?B?TXQvTXArcjBEeFh4dVYxb1NXdUdVRGtKRms1K3VXNlhidzdobDNmRm9reVMw?=
 =?utf-8?B?MGp5QTB2Q2FKVjZDdllHUktkU2lFWHdWQVNwdTNKTkR1eWxXQ0Z1L0NkZlNY?=
 =?utf-8?B?Q29vWTRZNE1WSlNHNXJ6eGd2TVBjR2lhOVArdktnQTJlcmZ4dno3QklGZVVu?=
 =?utf-8?B?U0lxcnhpV1g4L2ptenk4Tm1pUFZrQnB0VnZURkpmazhHbjV1dGRMbG15Nmk2?=
 =?utf-8?B?TjVjcGVQcUg1WU9RODZCNUUxMENtS1hvcWU1YUtYSHlrWkI4UE9HL3ZwNkc2?=
 =?utf-8?B?WVREdTRaZTY3aUUwWnZOWnpQU1VJVUJDZkpLT0xSMExyRTJkRHdoRHpmdUlM?=
 =?utf-8?B?N2liN042eko0T0ErVkFIUkovRFNGSW1UcFBIYmcxR1NVNUpWZUhwa3JQaFJT?=
 =?utf-8?B?QzJYMWlaUjNJY3llamc5YWpHa3VJd3d6aXgwcjhJQ3ZvcVNkZkcveXhPYW5J?=
 =?utf-8?B?MEhkeXVuMmVKbmJDSmh0dW1wa0R3QWdIcER1ZUxPN2lDSjJuZnJ3VndKdkEr?=
 =?utf-8?Q?gEMU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30ba6df-cf0d-4457-be94-08dad9f2dc0b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 14:37:12.5916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBTutv/Q+IN8bFsJNjfouNFLsiYiHkOdVjwZ5uHQaWiKC7PfiIR1/lZjv23rsWy3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, James.Zhu@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please try the latest AMDGPU driver:

https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next/

On 2022-12-07 15:54, Alex Deucher wrote:
> + Leo, Thong
>
> On Wed, Dec 7, 2022 at 3:43 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>> On Wed, Dec 7, 2022 at 7:58 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> What GPU do you have and what entries do you have in
>>> sys/class/drm/card0/device/ip_discovery/die/0/UVD for the device?
>> I bisected the issue on the Radeon 6800M.
>>
>> Parent commit for 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 is
>> 46dd2965bdd1c5a4f6499c73ff32e636fa8f9769.
>> For both commits ip_discovery is absent.
>> # ls /sys/class/drm/card0/device/ | grep ip
>> # ls /sys/class/drm/card1/device/ | grep ip
>>
>> But from verbose info I see that player for
>> 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 use acceleration:
>> $ vlc -v Downloads/test_sample_480_2.mp4
>> VLC media player 3.0.18 Vetinari (revision )
>> [0000561f72097520] main libvlc: Running vlc with the default
>> interface. Use 'cvlc' to use vlc without interface.
>> [00007fa224001190] mp4 demux warning: elst box found
>> [00007fa224001190] mp4 demux warning: STTS table of 1 entries
>> [00007fa224001190] mp4 demux warning: CTTS table of 78 entries
>> [00007fa224001190] mp4 demux warning: elst box found
>> [00007fa224001190] mp4 demux warning: STTS table of 1 entries
>> [00007fa224001190] mp4 demux warning: elst old=0 new=1
>> [00007fa224d19010] faad decoder warning: decoded zero sample
>> [00007fa224001190] mp4 demux warning: elst old=0 new=1
>> [00007fa214007030] gl gl: Initialized libplacebo v4.208.0 (API v208)
>> libva info: VA-API version 1.16.0
>> libva error: vaGetDriverNameByIndex() failed with unknown libva error,
>> driver_name = (null)
>> [00007fa214007030] glconv_vaapi_x11 gl error: vaInitialize: unknown libva error
>> libva info: VA-API version 1.16.0
>> libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
>> libva info: Found init function __vaDriverInit_1_16
>> libva info: va_openDriver() returns 0
>> [00007fa224c0b3a0] avcodec decoder: Using Mesa Gallium driver
>> 23.0.0-devel for AMD Radeon RX 6800M (navi22, LLVM 15.0.4, DRM 3.42,
>> 5.14.0-rc4-14-7cbe08a930a132d84b4cf79953b00b074ec7a2a7+) for hardware
>> decoding
>> [h264 @ 0x7fa224c3fa40] Using deprecated struct vaapi_context in decode.
>> [0000561f72174de0] pulse audio output warning: starting late (-9724 us)
>>
>> And for 46dd2965bdd1c5a4f6499c73ff32e636fa8f9769 commit did not use
>> acceleration:
>> $ vlc -v Downloads/test_sample_480_2.mp4
>> VLC media player 3.0.18 Vetinari (revision )
>> [000055f61ad35520] main libvlc: Running vlc with the default
>> interface. Use 'cvlc' to use vlc without interface.
>> [00007fc7e8001190] mp4 demux warning: elst box found
>> [00007fc7e8001190] mp4 demux warning: STTS table of 1 entries
>> [00007fc7e8001190] mp4 demux warning: CTTS table of 78 entries
>> [00007fc7e8001190] mp4 demux warning: elst box found
>> [00007fc7e8001190] mp4 demux warning: STTS table of 1 entries
>> [00007fc7e8001190] mp4 demux warning: elst old=0 new=1
>> [00007fc7e8d19010] faad decoder warning: decoded zero sample
>> [00007fc7e8001190] mp4 demux warning: elst old=0 new=1
>> [00007fc7d8007030] gl gl: Initialized libplacebo v4.208.0 (API v208)
>> libva info: VA-API version 1.16.0
>> libva error: vaGetDriverNameByIndex() failed with unknown libva error,
>> driver_name = (null)
>> [00007fc7d8007030] glconv_vaapi_x11 gl error: vaInitialize: unknown libva error
>> libva info: VA-API version 1.16.0
>> libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
>> libva info: Found init function __vaDriverInit_1_16
>> libva info: va_openDriver() returns 0
>> [00007fc7d40b3260] vaapi generic error: profile(7) is not supported
>> [00007fc7d8a089c0] gl gl: Initialized libplacebo v4.208.0 (API v208)
>> Failed to open VDPAU backend libvdpau_nvidia.so: cannot open shared
>> object file: No such file or directory
>> Failed to open VDPAU backend libvdpau_nvidia.so: cannot open shared
>> object file: No such file or directory
>> [00007fc7d89e4f80] gl gl: Initialized libplacebo v4.208.0 (API v208)
>> [000055f61ae12de0] pulse audio output warning: starting late (-13537 us)
>>
>> So my bisect didn't make sense :(
>> Anyway can you reproduce the issue with the attached sample file and
>> vlc on fresh kernel (6.1-rc8)?
>>
>> Thanks!
>>
>> --
>> Best Regards,
>> Mike Gavrilov.
