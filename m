Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF798C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 07:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B7510F089;
	Thu, 24 Feb 2022 07:09:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCD510F07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 07:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF5S1qwWHOeLAXWqu04Jmpq0eFDqPGYiOOSqDmNe/Y6yzv7HWxnGO54Jkx6JjKf9eG3IvMnkxrAl3iyCnfOkw/U1Vov+SR4URGVf/okLmdgDQhIi7O6vfUYcIsNfk2bzFiWabnaB1l1QbKqFajlESZSYu/zh9UjiUNu2WHLeFNqvnJ2xXMgCiunHSSA1z8qnab4xUd/S/EAr8ZpYLZ3i2zhb1HR6+6Pja8rVYjgHBwlJpb3w7CzB8a0NW2/Y4bIJr0LM2MYZqYADMyLjMfiFQyeC2LzHixfvwEQq85naoCuYq5+JdLuqxpCIzl0OI0yMXbkj5Am4Zp3lZAZ9i57GZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qcI4l56Zu8rIQNqb5hlcjtlDAn0H8oS4Eve1Na9wk8=;
 b=i9NUCQxLn1iKNiNNLFEsXq4NGqUGZzhT3dVFSSWa9Z4lJ1HV/jCDU0ZF96zOcy83LTGJWgYLubB2Dd3ge+Bnx4ABEsmW375B63lik8CWSFNqfsTXONnb/aCHk/6WUhuzqFw3dtB6H0eTK+P3Ow+QmwkM9i+t4ihm3aFx0KKb31k2Me02X0rqtFCQLNm+eUHwiX+QUGRueqRlXjAZoLlR5np9OsZRsyd83Vfuq+GzppJvVwhheib8iiKjK4hcuOzrvDjc6I+J9XDNvNPDJH+bGzkuQFXEDUw3woku8huEcCbHcQ0Et+jGo0Hd+TCxWwr81x7fAuF6xb0yZ0iByHsv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qcI4l56Zu8rIQNqb5hlcjtlDAn0H8oS4Eve1Na9wk8=;
 b=fePO+9DYql+3Yv+biqQzs58lAGnGP3itDoXJ3hPaErJrj8E146RNelSSGLrhxgRS5v/OT9s6lq8XdCzJzeip14iv6Hnr5sLgacLLCZWboGs/LWrKgGIB+q/i8KapnWnEz6a2KwDwlnn4nEnt2kFd5JRUEJtzmPXOnzUQ5Q3Al+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 24 Feb
 2022 07:09:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 07:09:03 +0000
Message-ID: <8cd9b639-be48-5b2f-bc3d-d6bd49be1830@amd.com>
Date: Thu, 24 Feb 2022 08:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
Content-Language: en-US
To: Cal Peake <cp@absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
 <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
 <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb6fe06f-6cf4-49b5-ba72-08d9f76489ea
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2431284CB5C31230DE739F44833D9@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGaMoiJFwjmevWTpD3qmo6hf43QwEt35mhIPzUTfm06+PBRYBpnIGtQBAKUfXdbpiTkQD/SMcM2Vyrdj63iQMal+zEE/mUJxjE0YqX/En1UNQ0ZqmKwDwjftMuelWoc53JNTkH1ktXW1SZVM2gSPoB06rCvIE5TdZ+l5jlyHYawh3Jp5ZqStw7EDhYUQoBFgaIG4chgysi4TEaKuZf3ZIF3saGnP5aa7P/7mktOV7mjf/yEDficA7l4iyvM8sqxsmtTFGeIr/3hCbf9WAdpg7Ilc6rnAB4TmDk33oEYuBVXvCUIpkBpWseJ+cxm7MyV35leNFtJi22/BEeF8X2hZsOXiiecGZCzatiw6U5cjGKr5YdjMG7RnqoEfsKhNfp+/k0fi72fqiuuH1NWFTazaHWfh793AYPOQhdssAvwx0lcMgFQvwPg4S+gzBkSbccBiBYZkcX0zOHCnb0S3TQfmY4JRcrZRwXqML9ml45s816dtOddiZR/yVYcgD7IKgN89QPzLSETvK2NpHpF0dku8psoS01onnhM+eq0mZtAaQHrjFz/ta7Lhe6QCjxM3OWOxM6dqAHpE4RhbWsrwNOAdEFk33nu6E0J4NNGG1eS8gxISlG8foGl5m8vdXAXohCUe7AEfTc+B5PsyAr3W7R7ijnpmRwj2IvC3ntdazFYpwchnm0sNUJjaF/JZZoaitBumDctl0sx6Hk+jQRVpPAMjgPjLaqEyJttWVg/LH8dxRdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(66476007)(6486002)(66556008)(66946007)(8676002)(4326008)(186003)(26005)(6666004)(8936002)(2616005)(31696002)(36756003)(38100700002)(316002)(2906002)(6506007)(86362001)(5660300002)(31686004)(6512007)(508600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3R3MWJwWkJhcjJRWGhkdXJkSHIzTnNjUFVCNEJ6Zzl0LzFFenhNMEZxZEs5?=
 =?utf-8?B?K09SaUE0YzVtcTI2TTd4SUJ6a1gyRDVwVnZMUWQvMW1lK0JZdWNmNU5Ec3dG?=
 =?utf-8?B?Qi95UmM3WVlERk4yMjVaU0dBZEN4Tk9NeHNtS0NBTGZieWQ1Mnc3aWx5eHE2?=
 =?utf-8?B?NkNLVUdlUjZYaUd4M2IvTnY3NmN4RW1CMnluTEhoejdJOHpYMTFiajVOMGsv?=
 =?utf-8?B?T3dDbFVObW1kRFVxVmx6ZzAyTndnb2MzM09KeGJiVmJ5c1hlS3Zud3ZldE4y?=
 =?utf-8?B?QUFrMFNjdUJqV0lsdFV0WS9zSGhhNVFoSXlwblZxdHgvbEo2YVIxcHd0aURO?=
 =?utf-8?B?a0NETEN1VlEraEpPQmZPK3owcjcxUXBBYTU3NWp3REJiNThtUHR3REJNbytv?=
 =?utf-8?B?SkNXREMwTUQwWXpYMGZvZzJndW15ZWZ3ZnZGMWUrZmJvcXVhS1FJcXpDYXc1?=
 =?utf-8?B?RVZ5RlpCbUFqakY0UlRWdFNJakwxd2FzczdyNnc1SmE2M0FPNUxFTklnb2NE?=
 =?utf-8?B?a3VaY1FKWnY2WEp6VVk0MVk2cmZVKzNZazZNZFMxbzhtb3c0U1l2K2ZnOFVu?=
 =?utf-8?B?dU5lU2FTNVRGNWRXNHlQNzVyTTlIajhyNzcvMlZTeDhKa0pIWkdab3N5Tnpi?=
 =?utf-8?B?S25yNGpvTHY2Q3hablkzeWIyUTNHOG42Z0ZzSzExOExMRjlSZ3dIV1hpSVVF?=
 =?utf-8?B?cUtjZ2hBbDRvNm1UL09GTVRGdWJ6VlRqSjJ4cDc3S2lMZTZ3cHpoQnF4dEZX?=
 =?utf-8?B?WUlsVHlNYXYvbExJd2hHbkRpK0FneEZ6QUQzZUZWNytIREJXTUs4ZlYrRjZ4?=
 =?utf-8?B?ZGtpWlNBOFNrbEpQYjJCZ3lKNWZXWDhqVHFzRUl2NDg3N3k5Tyt1NUphZUpS?=
 =?utf-8?B?TzU3VjJWdnNlR2FTaDB4NEZpRnZuMDNXallsVlpLMzhLa1RhK1JpSG85dG04?=
 =?utf-8?B?bXFXT01lck5JUDRndGJiS0hXTlh6RVpwbXVBcEp1dTcySzFRRGlOQ0Vjc29N?=
 =?utf-8?B?U3NQSytwVzRFSml5djAzdktucWU0VVBzVGJ4ZWFmTG0xQ0t6aS9CamNmWnBt?=
 =?utf-8?B?TzJYeVkxeTZqa2gxRDBzQ05BbXZITUdTNnExaGxaa1d4WG9lYnlKNjdNK2lY?=
 =?utf-8?B?L3JJVHRWMlRSUTlHNHZOK2ZxSjJ3R1daeUp3bVlLRm0vLzlRQm5haXZock1n?=
 =?utf-8?B?NTRFRTNaanZENDcrdDhLRnl5VDhibGxiVEl2VktiRjlNdkZUZnFTMFRxek1O?=
 =?utf-8?B?ZkNiVTh3aURGdm8rNndGMURNMms3ZXR4MlRQZ0w4RnBhRHQ4VWZlYWdxWWJ2?=
 =?utf-8?B?VlFSK2hBeVZtVU5wNERldGtnMGthOEdhNTJhWFVWL2xpck9xc01yWXFwVGhp?=
 =?utf-8?B?WHAyMGtuWVE1K3dudnZYTVE4VWxaQzFZc2FDNGZQY0lLem50NGM3VHlMamFi?=
 =?utf-8?B?ZGRWK0t0VzU5TFJGbkE4cTR5YXFDdHc3WW9vRmJneEtrTW05dTJIcTJxcUxY?=
 =?utf-8?B?SHhDNFRTTk14SU9IWlF1elhmTTJiL1lkdzdqQWo4MlB2TlVkbzlndkRrY3Bi?=
 =?utf-8?B?UWdFdURQMCtra2Rya3d0TnlqUnJzQytYU29OOWwyQjJVeEF1M25CRkwydGM5?=
 =?utf-8?B?M29hdG8zNG9ockdxWlVLTUVXblRzNDZEWTZlbWhOSjZrMk5Ia1JlT1I1VHRF?=
 =?utf-8?B?aVFQUzRZM2lGditLNzlzWTM0My9XQ01kK0JmdHBTNXhPNFluQkhkaVh3Nk9r?=
 =?utf-8?B?NGNGNlRJV3AwNExWa01ZcWF5enJOdWk2dm04Ujd2YUhlU3FzOUZzZ3VSUWxH?=
 =?utf-8?B?Yy9yVzdkRVJ2N2l6V2MzbDJpTUY1bmVQRVRPVFZzS1Q5SUd3eURWcGdRaEJo?=
 =?utf-8?B?dGhtMXpBY01VSWJNTUZkTHdrV2hqT3M0cy91a3cwWXJNRlhiWFcrcXdZb3I3?=
 =?utf-8?B?OGZFZmlveWU2SitTS3Rmb0YxRnpPdUlsb3pJNG5JanVsczNmZzlwUFRWd0tV?=
 =?utf-8?B?U1E1aHdhQ0YrVzlLTFBJMkRNaDRhM3djL1VKVFF5ZzF4WndsMG9mNGNPS0Uz?=
 =?utf-8?B?K3JDd3pJdTN3YXRlMWxsZm5WOStmNExPMWJiL1lMMzkyMFNCOXFtbldkRWFk?=
 =?utf-8?Q?exL0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6fe06f-6cf4-49b5-ba72-08d9f76489ea
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 07:09:03.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFgv9RfJFL3lyzpWuKbATqGQSA0aIrjwr6/7Gwvspjmn/u4w1w8NguTypqmlfO21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.02.22 um 23:59 schrieb Cal Peake:
> On Fri, 18 Feb 2022, Christian König wrote:
>
>> That's a really strong evidence that you have a hardware problem here.
>>
>> BTW: Where do you got that hardware from? Is it used or a new one? Was it
>> maybe used for mining?
>>
> Nah, this was a brand new card I bought on launch day from a reputable
> brick-and-mortar.
>
> Since I was getting to the end of my 30-day return window, I decided to
> just take the card back and exchange it for an RX 560 -- the only other
> card comparable in price that was also in stock (thanks miners/scalpers!).
>
> When I got that card home and tried it out, it had the same problem. From
> there, I decided to take a break and try a different approach. First thing
> I wanted to try was stepping through the different BIOS revisions
> available for my motherboard to see if that made any difference.
>
> That's when I saw ASRock had a beta for the next BIOS release available
> for testing. Flashed it, configured the BIOS to my liking, and incredibly,
> no resets or crashes.
>
> I've been under the weather for several days so I'm just now getting back
> to testing things again, but so far, everything seems to be good.
>
> I do wish I could have gotten to this point a little sooner. Exchanging my
> overpriced brand new GPU for an overpriced 5 year old GPU is a little
> stomach turning :-/

Well really sorry for that, but there isn't much I can help here.

Interesting to know that it turned out to be the motherboard, going to 
keep that in mind if somebody else is having similar problems.

Regards,
Christian.
