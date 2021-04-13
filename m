Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A0AC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 22:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FAA61246
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 22:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FAA61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A716E8B1;
	Tue, 13 Apr 2021 22:22:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E636E8B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 22:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwpYQ/75z1ggXekleEcaZmv17SQe5l0csUYMlTnZF8TthQPURautLiVyFOlFO8CguZ5ei4xa2nnNQeO3jSAmwIHOXo+iiI4iGkOIOZJ0idMPTToP1Z7FyObPZ/RpOjL/MmLafW5AF6wTKp3kQcyQq0kdfv9NPrGKIsML4HbOp5iijR6pmy51fu5DiHlTb0dLg4OSZ7XOtn3SfoESnU5boEVPZBklhWqttPE506tBzhJx3Vh+GFQP9D0GAQCwtZZGptDLuvrW/HlhqoH1ez7oK47DUyW7AIz7SNiQ/zX92MCMzDlaC3QTWGW+/5KR+XO06r/zwKU80vi/3QfmeYCPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjH6FwOKxXWsPfuVBK3I+mTPwon09ilzXuB0Pmd/rzQ=;
 b=K4DG3ocawqvTYRjt4TMqGWj/pBSgxIdpt2X+37gxy5mJLs3sHagkgppiTmtWS4w0KBn0IMwcPhL0EVgKQwl8u4p3uS+RUxIuXvketIWGB7+z2rCS2MgN0HbWgUCxMYTSLhOup/Yibb1Hyp1lXc9TiR8W0LMJtrKK0M9twLtu/uXjOoyQ2Q/x90pnua9bqJhZykVG2ajwBM9vRDnqmJsjYxN8doEfu35BNic2bvEy2gYa8k0N8CBu4QKrxZeAnnbYs1MX4GIgRA6DPkLATuJR2xd5Pc7ss/awk2z46ePCA1zCmPPLrMGcKgqk2/dkqYGsB3bB1Wcnw+EnE3b7N4oRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjH6FwOKxXWsPfuVBK3I+mTPwon09ilzXuB0Pmd/rzQ=;
 b=GvAS8ldsSDvTj4b1eFIXq41QZBJ8Kna4YJFTDfcPfRXUVyffthdXqc0bItHxaomBjjtwddsl4NL+vvWr9gwbCtSZtCNUMRoo9fomFVmk27vqnbkWiN7L89DuMXT1IT9oLpK04mfk9K2PYPjcCWRY5BmMESmnvajMwMBydP8BTe4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Tue, 13 Apr
 2021 22:22:52 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab%3]) with mapi id 15.20.4042.016; Tue, 13 Apr 2021
 22:22:52 +0000
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <159a1ebb-07a1-f50d-5a6c-f4345eb97c3f@amd.com>
 <CABXGCsM7z9Vmsh420MykJ8FzaCiSMWdSGCCvtYG2XrQKaw+SLQ@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <f253ff1f-3c5c-c785-1272-e4fe69a366ec@amd.com>
Date: Tue, 13 Apr 2021 18:22:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CABXGCsM7z9Vmsh420MykJ8FzaCiSMWdSGCCvtYG2XrQKaw+SLQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:4f60:725f:82b4:ba1f]
X-ClientProxiedBy: YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::16) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:4f60:725f:82b4:ba1f]
 (2607:9880:2088:19:4f60:725f:82b4:ba1f) by
 YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend
 Transport; Tue, 13 Apr 2021 22:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5109a67-05ac-4ae8-583c-08d8fecaad92
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2566D9991E1B74F08BDB091DE54F9@DM5PR12MB2566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSx5K9E60fwevBWMxlNPKjcU/8LdGYhoO+dQFrxbcLK1H4i2Vpg1264cOAA8JW5LR8OIfvJfYgwsjpLehL97LV5SqDppPXAi2JV7uYukc5h40fBtU9LIwpA5Xhwl6Mz9RvPcC45VTEZrxWL9+x+AkO4jj69Mt5TNlGtBzuhsRsHFP9d8vfcLMyeEtkmcch8TSZIsKmzOj9faEF5rEw/ieeOXK++ElirqV/sms+24iW+05A+K6oojHFaw4TBDHowJwhsyAjnivuB2zcjLsSFGs4Asw0ietR13FNlCsH4pKkABX2NWIc7KI++Dx81QZoxZwnJVT2g4xLqs43wo+Y61WB36qWgnMzIh9WNla7zN9XbRvw8qfR7Z+83TPSXfsI5E6EHXL3IZaewdwJhxZsTDJ14xOsNp159cV7GL2sHAX5iJH7t3Vkj7qPrZQvRwb4Yjp2SFhSGLEwq/pb5uQEDL9nyuov5VZKB3m2xX/iR7U7WPP5QpfYLfDIV2dOgYCMaUBLPzizueXTu+OC0vl/y8QqoZ2Vb3KgZ1GkNyag6dipChQulDSCHHx5uaAAortmTAvVvNvpJf6XKNUkUKmEfydOuFreaNC6/Tx+XuSvZA9YY8r7rAA+jkWH6xBtlT+ARdpUWXDIBVpUuiJJh4bY+iMB6/hDm3dGje24yloe9jW0SNrQDJZXBtxqkpnRaKfzZDC46VSPHpRP585u1I4AFhDHlbO9e5jYLuBJWOqUdVfdTNKDpjbOxeUoeqmQ4445QJVr8mFeuHr7RscYSuRpmX8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(2906002)(8676002)(8936002)(6486002)(16526019)(6916009)(44832011)(31686004)(54906003)(86362001)(2616005)(316002)(52116002)(966005)(478600001)(45080400002)(16799955002)(38100700002)(53546011)(66946007)(5660300002)(186003)(66556008)(36756003)(4326008)(31696002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnkrM1JML1dHZldIbkF0OENBeGVSaVY2STB4V01IcXpTaGNXS2hZS09lY1ho?=
 =?utf-8?B?MGwwNDBPNFZDYlAzZzM1TkNFS1NTYW4xQUJUZzdzaFh0cWUzTkVuaU15eXli?=
 =?utf-8?B?NTJhUGNrUmo5WHdwUzg1YmZTZ29kWk1VTWFuMlFObnZoanlzZWhnOGtQQUpU?=
 =?utf-8?B?VGVBRmJ0VmVwM3VoNktZK3BOTm1MWldFOHU1Q1llWGxwOUlaQzBmTkpRSVpa?=
 =?utf-8?B?My85WG1vVDQ1NXBMUWl3YmtEa3VzL2ZLTXl4Um9ER2lVL3U3bThnQmhkZDl1?=
 =?utf-8?B?dG9iVlAxSmYrMnIxZG1hS05BWlRHQnJ1WGRrdHVaMzN6RVRhMlhoSGhla0Y1?=
 =?utf-8?B?SXZOTzhhalZ0am1XV0dCcE5oWldRMHAxY25jN3U0eGtqTWpmWjlhbytidDh4?=
 =?utf-8?B?Q3A2cy9ONnRxYlVuWlZpbThRd1ZrT1ZYSHo2SFRkaEdCQnREV0xPS0NKZjVC?=
 =?utf-8?B?N1ROMUEwYUhxY0tJZ3FvU3kzTHl2amgrTUYrT2x3aWRlTDdkK0hEWDNtY0lV?=
 =?utf-8?B?Z2VwcFdnV1J0WTlNbjJpU3A0bjlkL29EclNoYS9CdjJhOHZPenV4UzdiUEhT?=
 =?utf-8?B?WjZXTGlGUTJ0R0pQVDN2N1ZpZXhMVWJEa3l2dnRZcGJObU0vbzBNSHh1TmEw?=
 =?utf-8?B?Zytzb0VtTHVrRGQ3bkw4N0hFY0ZFQVRLMjVDenZGaTdaVElsNi9yWG04Q1dw?=
 =?utf-8?B?VDFNc0owMUozRHI5bk8yMEZLQTBRYTEyTmd1SnhIMWJGVjBGallTbVYxQUk1?=
 =?utf-8?B?Y1VuL3RQT3orRHR0NHhBd1F2eEY4VFZ6SW40R3g1ZG1SVnJtWXR0d092S1Rj?=
 =?utf-8?B?dGVsak5rYTJ2dXJYOCtuWUZyVjl3ZXcyZjhIbnNHUis5RmVQUWkzMnpaU2dk?=
 =?utf-8?B?ZzFLNUhqb3RMc3JMNW9hWlQzZjUvL0Y1dURCZnlUWmpyeDV6K1F0ZWtVWXYz?=
 =?utf-8?B?V1JreWdUN3B5aXZLQjgvTWF5NTdlUUkzZXAxZ1dhWXM4V2JTcm9yQ2pHNjlR?=
 =?utf-8?B?cWZhSi9vMTRYdndsUExJZDgzUmxGMTFLMnRBNFNDM3NkSzFSY3Z2a2VyR1c0?=
 =?utf-8?B?YUViemVGd2dOSXU1bitIOHRSQ0o4eWVKTWtyaEswMW9xbmdrbjd4cmhRMElO?=
 =?utf-8?B?a3ZBbHRUSjFNc0k5azEzd2ZVTGpNVGVydEF0Ty9xRUM3NHJrS1NvMXBvWHJK?=
 =?utf-8?B?V1c1Y29YdHh2c1VzSmM1ZkRTUm53L3lpdkczTC9kSHVDZGliSjVZTnlxSlB2?=
 =?utf-8?B?a2RZN1VVTjVNbUErS3JyaDl4NTN4eldqaU0zTUhDNlZ6TlMwU0ZBNzh4dGdk?=
 =?utf-8?B?SmU4T2xnQ0ZBWW1kVVdzeXVoZlF5SmpOM2s0RDN2dmNhdVRjenhoSEVVVDlR?=
 =?utf-8?B?dmxOc3hTeUR5aVdIem9HQ1RVelNDWDhtMFB6KzlYdyttVlppYSsxc0pWbC9E?=
 =?utf-8?B?WHhiVEYvYmhXek1HL1g1K3V1ak03dlJrN3krR0wyY0JNcURpcEN4ZVpxcUhX?=
 =?utf-8?B?TUd0Qy94Nk9tVlh3ZWZEWEkxbFNyang3Q2k0YlJZa3NDQUQ5RTZzbmhxQTRx?=
 =?utf-8?B?cHFNMW9JN2NDRVd0b3FnUDFwMkx6eDdYWFRNMklBNEo1OFlReGUyTDFzTy85?=
 =?utf-8?B?Q2FRSHFmcGIyR2EzdkhCd0RNQ3lvSXpnSWlMZjEvNEYya1BqM0RyTFJ2Zm1B?=
 =?utf-8?B?VW5MMG9nMVRTZ1YzT25nNVpLV3RzSkIvbGhMV1oyTWtlSjcwOE9hV1ZSczRK?=
 =?utf-8?B?RmJOSjlVbnRkRVhnTW85UVRMbHVtS2VzbGd5UktPYURzRzBHSUFoV0pkMzlI?=
 =?utf-8?B?S3VXYlNGdGUwR3J1eWN0L1BWTW9yYk1COWVuNzFaTEk4VnQyUDJ0ZDdicGkv?=
 =?utf-8?Q?RQ5N4CFCLxUyp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5109a67-05ac-4ae8-583c-08d8fecaad92
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:22:52.3832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lvv49d8VVUWlw4s0AmzWV70NV0uPfoCw6Dn5oXu29vlbZ5TLebdbXPBE3DCZh3ox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-04-13 5:24 p.m., Mikhail Gavrilov wrote:
> On Tue, 13 Apr 2021 at 04:55, Leo Liu <leo.liu@amd.com> wrote:
>>> It curious why ffmpeg does not cause such issues.
>>> For example such command not cause kernel panic:
>>> $ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0 -vf
>>> 'format=nv12,hwupload' -vaapi_device /dev/dri/renderD128 -vcodec
>>> h264_vaapi output3.mp4
>> What command are you using to see the issue or how can the issue be reproduced?
> $ mpv output4.mp4

This is decode command line, are you seeing issue with encode or 
decode?, you also said `ffmpeg -f x11grab -framerate 60 -video_size 
3840x2160 -i :0.0 -vf 'format=nv12,hwupload' -vaapi_device 
/dev/dri/renderD128 -vcodec h264_vaapi output3.mp4` doesn't cause such 
issue, right? What command line can cause the issue then?


>
> And of course, I know how it should works because when I encode video
> with CPU encoder (libx264) all fine.
> $ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0
> -vcodec libx264 output3.mp4
>
>> Please file a freedesktop gitlab issue, so we can keep track of it.
> Here? https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues&amp;data=04%7C01%7Cleo.liu%40amd.com%7C3cd466c3286e4303f2b108d8fec2833a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637539458675499474%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GbiA7%2FrkiLwh2E9js9tGhWkZyr%2B9TY57H6G6cL7ex8s%3D&amp;reserved=0

Yes.

>
> Also, I found that other users face the same problem.
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbbs.archlinux.org%2Fviewtopic.php%3Fid%3D261965&amp;data=04%7C01%7Cleo.liu%40amd.com%7C3cd466c3286e4303f2b108d8fec2833a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637539458675499474%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=YNnk%2BZnPS0DVtuDfttnTThYfHOvmP38%2BwNpNZ5voLuk%3D&amp;reserved=0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
