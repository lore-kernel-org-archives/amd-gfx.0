Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A57C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 17:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B35B61002
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 17:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B35B61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9D789F53;
	Wed, 31 Mar 2021 17:40:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212A089F53
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 17:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSO5gE2HExyBvKcwwXuKNf/7EudQUXt2ZaWGDnBTWp7CDt0Cl6VJ4vKQaOyQ6Vz2nG09pIK+WMRgRNVQ3I2CFhQblqXy7RhfFowmHSig11WNUPoAbDAUjg8x9YtfShEWQJYtIpK5e7F99zX1PMMEyoCUjVfIq92l6yAlpJm2mEIg7IwcQK6/z0CusUopfe828YnYOOIAX7c2LnhzxQdybOjNmza2xUwdGKkOH/oBvAB7AX3DVZjXI5a+Az5ytotYPJdwQIgv7ZwsTcwtbww4uTVK4lrW5ELWdbT4GdFRbJuajVSv+0HRxyQq4h2awauLCBddW/2O+rJiXMJwRaMxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cZ7Pt+XcjPpJsa5RCGLPXbHzO6TGVKCctyGlHaPUw4=;
 b=i+7KUrUg9SpjBKv55pvhF/6gyt+5v0JVZlQtqG/XtR4cHIxgN883tDncwCxJ67fONSbAJ9k43ZkIhY5Tglz6CjNaKDDz/WBXlWSVptxfsAlzpTW/PiNCJanQ4SGfy1P9N9fzdhbLJpFukdgw/n97nLJ7mMYays02EKcTB/wOGErt1cR0M3AWQl0Tt/ysbr2gNlRzOTR5w/cfkER6bBMS/CbRymyrw/B9/jhazi3R86NUln9xsP1LCdL+Sgg9mXlcTF9W2qnbhquI+VHQHizaRtTRKyVGTbvolD651Ou5N292bWpTy7Oh/zGY9+9VfW7oTSzQFXQ5dzpQPwHb6RKX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cZ7Pt+XcjPpJsa5RCGLPXbHzO6TGVKCctyGlHaPUw4=;
 b=e/fAbtJmsR+mZMOK8IhdatwABcDVWEXjWLorgcx0NpsvhpaknpYdTSve40bXz0FCq+i6fYbZKwmFDL93YKr8nQpBza7Oi+eddsHk8WgB3xkb+iPFINMScpm7Y6iEXW+V//epVI5dyqJ2K/KCUN5oNsw21hIDKvJmI4F1DhvD9Ew=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4992.namprd12.prod.outlook.com (2603:10b6:208:3c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 17:40:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:40:00 +0000
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
 <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
 <7914f67b-e011-36ec-3f6d-1614ce96e3c4@amd.com>
 <CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com>
 <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com>
 <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
 <0eee8e42-5da8-1ce3-bff7-fe6e2ab18cde@amd.com>
 <CAHJvkbvH+yf-O04Jj9CURjaFfaYE9CSzqBQPe5oPuy5U_f3hag@mail.gmail.com>
 <6a71add4-d2d0-c17a-de8a-6e2b6e248483@gmail.com>
 <CAHJvkbviwB3JLU84P+mb58rvxaKOahO+B9LPMw3n8nGKvTHAOg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e9dd4112-c0d6-8081-8f4a-e857b3097d58@amd.com>
Date: Wed, 31 Mar 2021 19:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbviwB3JLU84P+mb58rvxaKOahO+B9LPMw3n8nGKvTHAOg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:46d6:1b43:479c:c70b]
X-ClientProxiedBy: AM3PR07CA0126.eurprd07.prod.outlook.com
 (2603:10a6:207:8::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b]
 (2a02:908:1252:fb60:46d6:1b43:479c:c70b) by
 AM3PR07CA0126.eurprd07.prod.outlook.com (2603:10a6:207:8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.8 via Frontend Transport; Wed, 31 Mar 2021 17:39:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6aa802d3-aa40-4773-0a8c-08d8f46c01f3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4992:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4992BB5512D815D19941A730837C9@MN2PR12MB4992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XVHm3f7Ik3wn2yj/X4wepUGeeb7HYZPemUKhs6Ij94CKAROKhaDPRvXYK83y8eXr79og5N2gykOyGGF6/M2yxRukxHVobOZLWiwVGIsBkHDpYqN12xKnwbTTPWnMObUT841oIIey1G/dqXCrcjcewfFl+YWFsv/3GER/bQchuvVzgqgzFphh5eWe2jtCfDDu+KtSlPIiic4m5/+MZO9DudpetewNl4WRXWqdCBG+DdtFbTjV1uWwRe4/5mg2i5qXWSrkeJrnQtC9NN3QeeTVHbjmADCejAkKcfl8ZGJwMS1rZHBEgSjiqB38gDVpdqCF7++foRm/HZOX1G/y7+rM4mbTr6bjsVLkMbGj5kNCqPiMa+enCkjOE10kII7wOCiVExWw0VQPxmZQukVOj+F0sdG1oKaZo8dBQ6eYjUpUP3X5E86cPFZEnKsujPxXLvKuI+E04AsHTOgSC3laZYX9BevkJCBQHzpqY8fLn+pwMkGXPBA2Jv68t08h9lP3+iL8jCZaTzV+SsX6h+aTrpwtWmAIDBIifIWt8JHEEh5xsyUJfuxKpK1eGYMcdQklQ11sE/ZcQVGBI9+09+HD3awT0HHX0eVz/vxfuoVaeAmpKItCKu0nDhVemjKiL+Tnqa/XCSgaWiAwQt9+92a7gbyfNC8rGMVzlPgTGaVGrnR1dYqdJDhf2I3Dh1XrM78BazkDoxNdB8CsI0gKs1Yx4nGIlQ6cIbLUfkA//jq8Cz7U6/rIyPd5X/hQNQpgBKj8de3uYBLF0EVAdSlCWD8a86q5gqT/DN2/h2SeZ/uCANA2Kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(33964004)(166002)(52116002)(2906002)(66574015)(31686004)(83380400001)(110136005)(316002)(6486002)(2616005)(66556008)(66946007)(16526019)(66476007)(31696002)(186003)(30864003)(8936002)(6666004)(5660300002)(38100700001)(45080400002)(966005)(86362001)(478600001)(8676002)(36756003)(4326008)(43740500002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?azFQcUxEZ3E5NkFwbmJHeEpWazQ1c053RSs0VjlOVGxJa0tsRStJcVhtQ2JW?=
 =?utf-8?B?eDlOclNEUEZyUGdRSDJHN2swMlVueUdSVXRTRHI5TnJiWWVCaTFKc3pyTmtj?=
 =?utf-8?B?VGVyRmlwZDdkOHFoRVVlbXV3ZVFXN1M0RGFaaU51eVpCZmFwMEJURTc2K0xx?=
 =?utf-8?B?Nk9ydVh1R2cwV0tmUU9lRkNneE1lY1ZXZDA4Rzc1Y0ZRYTlUWFZVVDN5ZEI0?=
 =?utf-8?B?czVwTGNYK2E0dHZCaGpOd3N6ZFlObVRDWmhHTWlRSHJ5OWlxSmVodEFPbVdx?=
 =?utf-8?B?U3FsL0ZxanBRQ0E2eWorZUU1RmJ6bFdXNTBWejBMMkZjTk9oYWcveDVxdmpi?=
 =?utf-8?B?OUZPMWI5VWJWR0lGVzdQZ2t3QTVYd1h2MjZLQXZTSUt3SVMvcG5pMDMwL3FZ?=
 =?utf-8?B?VGkxUUhOSG5tb3NZcTF3S01vc3BienluM3dGaVY2aWRCaWxZcUFFNU9mcEhC?=
 =?utf-8?B?c09VUU1GVEtkMXJwU1UyTCthd0VEYkNMaTV0TGorZ1o1OUhiSy9zbG8wOGIw?=
 =?utf-8?B?SU5yZ05oR2NlakprMSt0T2FDNVp2ZVN0cXY4b1dIQm4vdmFVZGFZcWJBRzFu?=
 =?utf-8?B?di9McFpURXV4elh0SG11RkpUWEhQYTlYOUltSENzYXdSbG82WlVLbW5LdExx?=
 =?utf-8?B?ZEFMZ2NFSTdTcHdpVDFGb3FyN0VKVlJwVDVNK3owZG5ydEFTbmxoNm5sTkVI?=
 =?utf-8?B?QURjOFhyQVR6WFBWaE9IampNTDkrTUhtYXJaS0JvQ09IRjNjRE5xc2xXM0NK?=
 =?utf-8?B?bko3U1NacksvNlltaVYrbS9zZ1RVQUc3UytxT0pqdko3Z2lnY3dRR1h0bUEw?=
 =?utf-8?B?eE9mRE51alIzK2NweW1xb3QrcWRCYUNBU1drSUxrYlFDSWVTRzUzUUJoYlp3?=
 =?utf-8?B?S01XQWN0Rkd2aTRHcEd2aHNLa0Nna1h0OHN5ZDdZQ1RzdXg2R3JJQWVhME9z?=
 =?utf-8?B?cWt5cis0SjcvdkVZVGZIYkxQdUh0Z2dHSnNjMUFSM0dxU04ybUJ1dGM2SDQv?=
 =?utf-8?B?dEFzVDh3aTBVZnkrdGRWM0ZyQmsxZklVK2tSUTRaNU0vbGdyYXpsTVJESFdm?=
 =?utf-8?B?R3RVUk1TODAzSnBueWx2bVowMzhyOWhWKzV1eFNaQ3V1Q0E5V0gwWW92bk9D?=
 =?utf-8?B?MnJRRFZteFNXMHVQa2V6b3VSa0xWWlBHSSsyaGtDa0dyMGUvN2NSRGZRTy9B?=
 =?utf-8?B?bHk5L0VTSk9yWUI2Q3U2bnUrTnZvSlpPV2J2YUI3R3MwaWJnVzhhdnpER3Yr?=
 =?utf-8?B?M2hsR1I1VjA1L0JTK29NMEYySFRGeUFFcE5rQWxqbEkyWmRVWlVoakZwaU82?=
 =?utf-8?B?VWFWMzBCblNTWE5BeHBZcUNPRWhBN2NjSnNoNGhNUWZFYWVVOURGcDNXM3NO?=
 =?utf-8?B?b2xPVlhqOWl4R04vNFVNYXV3bzRHb2VvZ0d0TlRJY096RUxkQlMxSUZZS0Q4?=
 =?utf-8?B?bTJrOWV3bTQrTVFTVTFnUHZSNjgxaWVDa3N3NHpiRTdSVndManZJeDJhKzBQ?=
 =?utf-8?B?cnZFRFlCWG5EM0x6TUhkdEFnSVV5NU5OeHo1VmFQeE0xaVhPbi93d3BGeFI3?=
 =?utf-8?B?M3pqanpMQlA1djdKMk5TNkxabFlmZnRWY0xMOFR5eStRYzNaRVVTcUJSL2hm?=
 =?utf-8?B?MEl0dW5JVlQxQjFHZEdGSEVSSjRHRmhrWFRSL1RSR3BnaHl2eG1oTHhPd1U5?=
 =?utf-8?B?OFZlMkY2WGxILzJlZGY4b09XR1BjNkd1cGlsRjlqT1c3aWVHQmhCSElJdW9x?=
 =?utf-8?B?U0Q1OHIvZU9OKzZteDFMaXdqNHA3OGlEdW5icThTMS9tZzBMdGRKdVBIa2Vm?=
 =?utf-8?B?b29ZQklib2o2cVVtajF0b3dxdTJLMkd4N3J2RmpFUmx2RWRWR1hvMm9tak1P?=
 =?utf-8?Q?jbBnqsP8xSY9Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa802d3-aa40-4773-0a8c-08d8f46c01f3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:40:00.2503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSwdJ6xpF940dg6KNhAim3bLrRli2bFJSgShHzlxVE4nWK8uE/jL32Tfdy9utlEl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4992
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
Cc: alexander.deucher@amd.com, benh@kernel.crashing.org,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0455399306=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0455399306==
Content-Type: multipart/alternative;
 boundary="------------6974DE70093A7B5A8B7D80BA"
Content-Language: en-US

--------------6974DE70093A7B5A8B7D80BA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, agree that must be some kind of bug in the upper layer of the stack.

Most likely some userspace component is not handling the specialties of 
interlacing correctly (different vblank timing every other frame).

It probably only works on Intel and after restarting the display manager 
by coincident.

Sorry, but as I said this is a use case which basically nobody is using 
any more and because of this the different parts of the stack are not 
tested well enough for this.

Christian.

Am 31.03.21 um 17:47 schrieb Alberto Salvia Novella:
> Restarting the *display manager* service works and, more importantly, 
> makes the bug no longer reproducible.
>
> Restarting the *window manager* doesn't work.
>
> *Changing* display manager makes the bug still reproducible.
>
> Maybe this is due to xorg-server, isn't it?
>
> On Wed, 31 Mar 2021 at 16:55, Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Well the hardware is working fine as far as I can see.
>
>     Can you try to kill the X server over SSH and see if you then get
>     some screen update?
>
>     Regards,
>     Christian.
>
>     Am 31.03.21 um 16:52 schrieb Alberto Salvia Novella:
>>     Output
>>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F0f3d7caa23b99655%23CvUAikkFYSdQ9XixPHvBe7ebfaQ7nXcFVBhXAotYMPrG&data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640576009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=1RIyUWLBE8srNTGyf4VujAABOKYB8xMowLUXhShn2u0%3D&reserved=0>.
>>
>>     On Wed, 31 Mar 2021 at 16:36, Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Mhm strange.
>>
>>         Can you get me the output of "sudo cat
>>         /sys/kernel/debug/dri/0/radeon_fence_info" when the problem
>>         happens?
>>
>>         Thanks,
>>         Christian.
>>
>>         Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:
>>>         - The computer still replies to *ping*.
>>>         - The *journal* shows no errors, but a few warnings
>>>         <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F5a0bf22220398549%23D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy&data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640576009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=QFHXVQ9dHqxidVzjJ22S%2FxW%2FaWRuf4okzfoUZ0SlahM%3D&reserved=0>.
>>>         - The *mouse* doesn't freeze.
>>>
>>>         On Wed, 31 Mar 2021 at 10:09, Christian König
>>>         <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>>>         wrote:
>>>
>>>             Can you access the system over the network and see if
>>>             there is anything in the system log?
>>>
>>>             It sounds like the display stack has crashed, but when
>>>             the sound keeps playing the system is most likely still
>>>             responsive over network.
>>>
>>>             Thanks,
>>>             Christian.
>>>
>>>             Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
>>>>             What happens is this simple: after a few minutes, about
>>>>             6 or so, the entire content of the screen stays still.
>>>>             In some minor situations only the applications panel of
>>>>             KDE Plasma.
>>>>
>>>>             If music is playing it continues playing, so only
>>>>             graphics are hung. Yet in most cases the power button
>>>>             won't shut down the computer, as it usually does.
>>>>
>>>>             At least this is the case using kwin on x11, and not on
>>>>             wayland. It only happens on "radeon" and not on Intel
>>>>             or "radeonhd".
>>>>
>>>>             On Wed, 31 Mar 2021 at 09:48, Christian König
>>>>             <christian.koenig@amd.com
>>>>             <mailto:christian.koenig@amd.com>> wrote:
>>>>
>>>>                 Correct, but a TV is intended for videos only.
>>>>                 That's why it implements only the lower HDMI standard.
>>>>
>>>>                 Interlaced transmits only halve the lines with each
>>>>                 frame, so a 60Hz mode effectively either becomes a
>>>>                 30Hz mode, halving the vertical resolution or
>>>>                 adaptive motion compensated which the know visual
>>>>                 artifacts. Depending on what the deinterlacing
>>>>                 setting on your TV is.
>>>>
>>>>                 You could just add a progressive 1920x540@60 or
>>>>                 1920x1080@30 mode manually and would have the same
>>>>                 effect with probably better quality. See
>>>>                 https://de.wikipedia.org/wiki/Deinterlacing
>>>>                 <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640585999%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=ooF4BCKR%2Bg605BO7bXh7IYvP3F9Q88vC%2BuM6RM%2BflE8%3D&reserved=0>
>>>>                 for reference.
>>>>
>>>>                 If you can give us some more information what is
>>>>                 happening when the system freeze we could try to
>>>>                 narrow this down, but we can't spend much time on a
>>>>                 very specific use case in a driver which is in
>>>>                 maintenance mode.
>>>>
>>>>                 Regards,
>>>>                 Christian.
>>>>
>>>>                 Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
>>>>>                 24fps is intended for video only. Anything
>>>>>                 interactive at 24fps, as just moving the mouse
>>>>>                 around, is extremely choppy.
>>>>>
>>>>>                 No way anyone would prefer that over an interlaced
>>>>>                 resolution or a lower resolution. That is, by far,
>>>>>                 the worst option.
>>>>>
>>>>>                 Just try it on your screen, set it to 24Hz or
>>>>>                 alike, and tell me your experience. You can't even
>>>>>                 tell where the mouse is going to go.
>>>>>
>>>>>                 On Wed, 31 Mar 2021 at 08:44, Christian König
>>>>>                 <christian.koenig@amd.com
>>>>>                 <mailto:christian.koenig@amd.com>> wrote:
>>>>>
>>>>>                     Hi Alberto,
>>>>>
>>>>>                     well a frame rate of 24Hz is perfectly
>>>>>                     reasonable for a TV and desktop usage.
>>>>>
>>>>>                     This is probably caused by the TVs limited
>>>>>                     HDMI bandwidth and a refresh rate of 30/25 Hz
>>>>>                     for the interlaced mode isn't much better either.
>>>>>
>>>>>                     Regards,
>>>>>                     Christian.
>>>>>
>>>>>                     Am 30.03.21 um 22:59 schrieb Alberto Salvia
>>>>>                     Novella:
>>>>>>                     The frame-rate at 24Hz is extremely poor for
>>>>>>                     normal desktop usage.
>>>>>>
>>>>>>                     If the highest resolution, aka 1080p, uses
>>>>>>                     that refresh rate then the desktop will
>>>>>>                     default to that frame-rate.
>>>>>>
>>>>>>                     Other progressive modes don't exhibit any issue.
>>>>>>
>>>>>>                     On Tue, 30 Mar 2021 at 18:26, Christian König
>>>>>>                     <christian.koenig@amd.com
>>>>>>                     <mailto:christian.koenig@amd.com>> wrote:
>>>>>>
>>>>>>                         Hi Alberto,
>>>>>>
>>>>>>>                         I think the driver should only support
>>>>>>>                         resolutions that are *progressive*, but
>>>>>>>                         also at least of *50Hz*.
>>>>>>
>>>>>>                         Why do you think so?, the 24Hz resolution
>>>>>>                         seems to be the native one of the display.
>>>>>>
>>>>>>                         Regards,
>>>>>>                         Christian.
>>>>>>
>>>>>>                         Am 30.03.21 um 17:37 schrieb Alberto
>>>>>>                         Salvia Novella:
>>>>>>>                         This is why I'm using interlaced:
>>>>>>>
>>>>>>>                         $ *xrandr*
>>>>>>>                         Screen 0: minimum 320 x 200, current
>>>>>>>                         1920 x 1080, maximum 8192 x 8192
>>>>>>>                         DisplayPort-0 disconnected (normal left
>>>>>>>                         inverted right x axis y axis)
>>>>>>>                         HDMI-0 connected primary 1920x1080+0+0
>>>>>>>                         (normal left inverted right x axis y
>>>>>>>                         axis) 16mm x 9mm
>>>>>>>                            1920x*1080i*    60.00*+  50.00  59.94
>>>>>>>                            1920x1080 *24.00*    23.98
>>>>>>>                            1280x*720*      60.00  50.00  59.94
>>>>>>>                            1024x768    75.03  70.07  60.00
>>>>>>>                            832x624   74.55
>>>>>>>                            800x600   72.19  75.00  60.32  56.25
>>>>>>>                            720x576   50.00
>>>>>>>                            720x576i    50.00
>>>>>>>                            720x480   60.00  59.94
>>>>>>>                            720x480i    60.00  59.94
>>>>>>>                            640x480   75.00  72.81  66.67  60.00
>>>>>>>                          59.94
>>>>>>>                            720x400   70.08
>>>>>>>                         DVI-0 disconnected (normal left inverted
>>>>>>>                         right x axis y axis)
>>>>>>>
>>>>>>>                         I think the driver should only support
>>>>>>>                         resolutions that are *progressive*, but
>>>>>>>                         also at least of *50Hz*.
>>>>>>>
>>>>>>>                         On Tue, 30 Mar 2021 at 15:41, Christian
>>>>>>>                         König <ckoenig.leichtzumerken@gmail.com
>>>>>>>                         <mailto:ckoenig.leichtzumerken@gmail.com>>
>>>>>>>                         wrote:
>>>>>>>
>>>>>>>                             Mhm, no idea why an interlaced
>>>>>>>                             resolution would cause a crash.
>>>>>>>                             Maybe some miscalculation in the
>>>>>>>                             display code.
>>>>>>>
>>>>>>>                             But apart from that if you just
>>>>>>>                             connected your PC to a TV I also
>>>>>>>                             wouldn't recommend using an
>>>>>>>                             interlaced resolution in the first
>>>>>>>                             place.
>>>>>>>
>>>>>>>                             See those resolutions only exists
>>>>>>>                             for backward compatibility with
>>>>>>>                             analog hardware.
>>>>>>>
>>>>>>>                             I think we would just disable those
>>>>>>>                             modes instead of searching for the bug.
>>>>>>>
>>>>>>>                             Regards,
>>>>>>>                             Christian.
>>>>>>>
>>>>>>>                             Am 30.03.21 um 11:07 schrieb Alberto
>>>>>>>                             Salvia Novella:
>>>>>>>>                             I guessed so.
>>>>>>>>
>>>>>>>>                             The GPU is a Radeon HD5870, and the
>>>>>>>>                             screen is an old Telefunken TV
>>>>>>>>                             (TLFK22LEDPVR1).
>>>>>>>>
>>>>>>>>                             Since my real display got into
>>>>>>>>                             repair I used this TV meanwhile,
>>>>>>>>                             and to my surprise it froze the system.
>>>>>>>>
>>>>>>>>                             On Tue, 30 Mar 2021 at 10:15,
>>>>>>>>                             Christian König
>>>>>>>>                             <christian.koenig@amd.com
>>>>>>>>                             <mailto:christian.koenig@amd.com>>
>>>>>>>>                             wrote:
>>>>>>>>
>>>>>>>>                                 Hi Alberto,
>>>>>>>>
>>>>>>>>                                 well what hardware do you have?
>>>>>>>>
>>>>>>>>                                 Interlaced resolutions are not
>>>>>>>>                                 used any more on modern
>>>>>>>>                                 hardware, so they
>>>>>>>>                                 are not well tested.
>>>>>>>>
>>>>>>>>                                 Regards,
>>>>>>>>                                 Christian.
>>>>>>>>
>>>>>>>>                                 Am 30.03.21 um 10:04 schrieb
>>>>>>>>                                 Alberto Salvia Novella:
>>>>>>>>                                 > The entire desktop hangs
>>>>>>>>                                 after some minutes when using
>>>>>>>>                                 the module
>>>>>>>>                                 > "radeon" with an interlaced
>>>>>>>>                                 resolution.
>>>>>>>>                                 >
>>>>>>>>                                 > Easier to trigger by playing
>>>>>>>>                                 a video on Firefox, at least on
>>>>>>>>                                 kwin_x11.
>>>>>>>>                                 > Wayland didn't exhibit the
>>>>>>>>                                 problem.
>>>>>>>>                                 >
>>>>>>>>                                 > Other display drivers, from
>>>>>>>>                                 different computers I have
>>>>>>>>                                 tried, didn't
>>>>>>>>                                 > allow those interlaced
>>>>>>>>                                 resolutions all together. It
>>>>>>>>                                 seems they know
>>>>>>>>                                 > there will be problems.
>>>>>>>>
>>>>>>>>
>>>>>>>>                             _______________________________________________
>>>>>>>>                             amd-gfx mailing list
>>>>>>>>                             amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>>>>>                             https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640585999%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=y2RJRp4SEnJQ7qPYYJKnr0B4xRkYEZJcYY6sZ4B%2BQ5g%3D&reserved=0>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>


--------------6974DE70093A7B5A8B7D80BA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Yeah, agree that must be some kind of bug in the upper layer of the
    stack.<br>
    <br>
    Most likely some userspace component is not handling the specialties
    of interlacing correctly (different vblank timing every other
    frame).<br>
    <br>
    It probably only works on Intel and after restarting the display
    manager by coincident.<br>
    <br>
    Sorry, but as I said this is a use case which basically nobody is
    using any more and because of this the different parts of the stack
    are not tested well enough for this.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 31.03.21 um 17:47 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHJvkbviwB3JLU84P+mb58rvxaKOahO+B9LPMw3n8nGKvTHAOg@mail.gmail.com">
      
      <div dir="ltr">
        <div>Restarting the <b>display manager</b> service works and,
          more importantly, makes the bug no longer reproducible.</div>
        <div><br>
        </div>
        <div>Restarting the <b>window manager</b> doesn't work.</div>
        <div><br>
        </div>
        <div><b>Changing</b> display manager makes the bug still
          reproducible.</div>
        <div><br>
        </div>
        <div>Maybe this is due to xorg-server, isn't it?<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at 16:55,
          Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Well the hardware is working fine as far as I can see.<br>
            <br>
            Can you try to kill the X server over SSH and see if you
            then get some screen update?<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 31.03.21 um 16:52 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr"><a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F0f3d7caa23b99655%23CvUAikkFYSdQ9XixPHvBe7ebfaQ7nXcFVBhXAotYMPrG&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640576009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1RIyUWLBE8srNTGyf4VujAABOKYB8xMowLUXhShn2u0%3D&amp;reserved=0" originalsrc="https://bin.privacytools.io/?0f3d7caa23b99655#CvUAikkFYSdQ9XixPHvBe7ebfaQ7nXcFVBhXAotYMPrG" shash="yDeZVZqesFBDn0I/4GqshNG9z//CDCrITK0WOCyK3RfcYQ/OYiVw3SHzd3r/5G/u/v/JNnFiwuUF0TveQs9BZe4fEg8TfCQ3S2l+jY79sxrFswjFnPwf3cuzAaJfUdncsR3J3qPEHDmfib2ND+QQHgZkc2WkaqruRsFxUKL/xWg=" target="_blank" moz-do-not-send="true">Output</a>.<br>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at
                  16:36, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Mhm strange.<br>
                    <br>
                    Can you get me the output of &quot;sudo cat
                    /sys/kernel/debug/dri/0/radeon_fence_info&quot; when the
                    problem happens?<br>
                    <br>
                    Thanks,<br>
                    Christian.<br>
                    <br>
                    <div>Am 31.03.21 um 16:33 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>- The computer still replies to <b>ping</b>.</div>
                        <div>- The <b>journal</b> shows no errors, but
                          a few <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F5a0bf22220398549%23D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640576009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QFHXVQ9dHqxidVzjJ22S%2FxW%2FaWRuf4okzfoUZ0SlahM%3D&amp;reserved=0" originalsrc="https://bin.privacytools.io/?5a0bf22220398549#D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy" shash="QA0oaQQlkknJNQGNDyrXgsnRzWRVHbDqR6neZke3RKVxQng4mP0U+n4vstYHKQWMk4MQOXAAwRzYNU0iuYZ3YeN8viebCS0EG/d4AVFJ8kYrFS/9WcYmSvjAeEWCWBVe07Y727GQ+PvWoP55PXWMy4knKbQTJUJ7UvKIkpNxvRQ=" target="_blank" moz-do-not-send="true">warnings</a>.</div>
                        <div>- The <b>mouse</b> doesn't freeze.<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar
                          2021 at 10:09, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div> Can you access the system over the
                            network and see if there is anything in the
                            system log?<br>
                            <br>
                            It sounds like the display stack has
                            crashed, but when the sound keeps playing
                            the system is most likely still responsive
                            over network.<br>
                            <br>
                            Thanks,<br>
                            Christian.<br>
                            <br>
                            <div>Am 31.03.21 um 10:05 schrieb Alberto
                              Salvia Novella:<br>
                            </div>
                            <blockquote type="cite">
                              <div dir="ltr">
                                <div>What happens is this simple: after
                                  a few minutes, about 6 or so, the
                                  entire content of the screen stays
                                  still. In some minor situations only
                                  the applications panel of KDE Plasma.</div>
                                <div><br>
                                </div>
                                <div>If music is playing it continues
                                  playing, so only graphics are hung.
                                  Yet in most cases the power button
                                  won't shut down the computer, as it
                                  usually does.<br>
                                </div>
                                <div><br>
                                </div>
                                <div>At least this is the case using
                                  kwin on x11, and not on wayland. It
                                  only happens on &quot;radeon&quot; and not on
                                  Intel or &quot;radeonhd&quot;.</div>
                              </div>
                              <br>
                              <div class="gmail_quote">
                                <div dir="ltr" class="gmail_attr">On
                                  Wed, 31 Mar 2021 at 09:48, Christian
                                  König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                  0.8ex;border-left:1px solid
                                  rgb(204,204,204);padding-left:1ex">
                                  <div> Correct, but a TV is intended
                                    for videos only. That's why it
                                    implements only the lower HDMI
                                    standard.<br>
                                    <br>
                                    Interlaced transmits only halve the
                                    lines with each frame, so a 60Hz
                                    mode effectively either becomes a
                                    30Hz mode, halving the vertical
                                    resolution or adaptive motion
                                    compensated which the know visual
                                    artifacts. Depending on what the
                                    deinterlacing setting on your TV is.<br>
                                    <br>
                                    You could just add a progressive
                                    1920x540@60 or 1920x1080@30 mode
                                    manually and would have the same
                                    effect with probably better quality.
                                    See <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640585999%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ooF4BCKR%2Bg605BO7bXh7IYvP3F9Q88vC%2BuM6RM%2BflE8%3D&amp;reserved=0" originalsrc="https://de.wikipedia.org/wiki/Deinterlacing" shash="vPWCLu2KWRiZKGLjr91+mJthFbsuRZuffiNZrJUahEonB8DvpCuvVPnW5U6/X/EAErqM9CJwmeogdrcOiDYGEJTckRS1iO2lm2VvXtaKceSG9UOpXzvn6apuZdU9gdl/Fcz337lWDp2YD3n8Kqt1ao2hYf29VJQVkKextOeHBV8=" target="_blank" moz-do-not-send="true">https://de.wikipedia.org/wiki/Deinterlacing</a>
                                    for reference.<br>
                                    <br>
                                    If you can give us some more
                                    information what is happening when
                                    the system freeze we could try to
                                    narrow this down, but we can't spend
                                    much time on a very specific use
                                    case in a driver which is in
                                    maintenance mode.<br>
                                    <br>
                                    Regards,<br>
                                    Christian.<br>
                                    <br>
                                    <div>Am 31.03.21 um 09:21 schrieb
                                      Alberto Salvia Novella:<br>
                                    </div>
                                    <blockquote type="cite">
                                      <div dir="ltr">
                                        <div>24fps is intended for video
                                          only. Anything interactive at
                                          24fps, as just moving the
                                          mouse around, is extremely
                                          choppy.</div>
                                        <div><br>
                                        </div>
                                        <div>No way anyone would prefer
                                          that over an interlaced
                                          resolution or a lower
                                          resolution. That is, by far,
                                          the worst option.</div>
                                        <div><br>
                                        </div>
                                        <div>Just try it on your screen,
                                          set it to 24Hz or alike, and
                                          tell me your experience. You
                                          can't even tell where the
                                          mouse is going to go.<br>
                                        </div>
                                      </div>
                                      <br>
                                      <div class="gmail_quote">
                                        <div dir="ltr" class="gmail_attr">On Wed, 31
                                          Mar 2021 at 08:44, Christian
                                          König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                          wrote:<br>
                                        </div>
                                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                          0.8ex;border-left:1px solid
                                          rgb(204,204,204);padding-left:1ex">
                                          <div> Hi Alberto,<br>
                                            <br>
                                            well a frame rate of 24Hz is
                                            perfectly reasonable for a
                                            TV and desktop usage.<br>
                                            <br>
                                            This is probably caused by
                                            the TVs limited HDMI
                                            bandwidth and a refresh rate
                                            of 30/25 Hz for the
                                            interlaced mode isn't much
                                            better either.<br>
                                            <br>
                                            Regards,<br>
                                            Christian.<br>
                                            <br>
                                            <div>Am 30.03.21 um 22:59
                                              schrieb Alberto Salvia
                                              Novella:<br>
                                            </div>
                                            <blockquote type="cite">
                                              <div dir="ltr">
                                                <div>The frame-rate at
                                                  24Hz is extremely poor
                                                  for normal desktop
                                                  usage.<br>
                                                </div>
                                                <div><br>
                                                </div>
                                                <div>If the highest
                                                  resolution, aka 1080p,
                                                  uses that refresh rate
                                                  then the desktop will
                                                  default to that
                                                  frame-rate.</div>
                                                <div><br>
                                                </div>
                                                <div>Other progressive
                                                  modes don't exhibit
                                                  any issue.<br>
                                                </div>
                                              </div>
                                              <br>
                                              <div class="gmail_quote">
                                                <div dir="ltr" class="gmail_attr">On
                                                  Tue, 30 Mar 2021 at
                                                  18:26, Christian König
                                                  &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                                  wrote:<br>
                                                </div>
                                                <blockquote class="gmail_quote" style="margin:0px 0px
                                                  0px
                                                  0.8ex;border-left:1px
                                                  solid
                                                  rgb(204,204,204);padding-left:1ex">
                                                  <div> Hi Alberto,<br>
                                                    <br>
                                                    <blockquote type="cite">I
                                                      think the driver
                                                      should only
                                                      support
                                                      resolutions that
                                                      are <b>progressive</b>,
                                                      but also at least
                                                      of <b>50Hz</b>.</blockquote>
                                                    <br>
                                                    Why do you think
                                                    so?, the 24Hz
                                                    resolution seems to
                                                    be the native one of
                                                    the display.<br>
                                                    <br>
                                                    Regards,<br>
                                                    Christian.<br>
                                                    <br>
                                                    <div>Am 30.03.21 um
                                                      17:37 schrieb
                                                      Alberto Salvia
                                                      Novella:<br>
                                                    </div>
                                                    <blockquote type="cite">
                                                      <div dir="ltr">
                                                        <div>This is why
                                                          I'm using
                                                          interlaced:<br>
                                                        </div>
                                                        <div><br>
                                                        </div>
                                                        <div>$ <b>xrandr</b><br>
                                                          Screen 0:
                                                          minimum 320 x
                                                          200, current
                                                          1920 x 1080,
                                                          maximum 8192 x
                                                          8192<br>
                                                          DisplayPort-0
                                                          disconnected
                                                          (normal left
                                                          inverted right
                                                          x axis y axis)<br>
                                                          HDMI-0
                                                          connected
                                                          primary
                                                          1920x1080+0+0
                                                          (normal left
                                                          inverted right
                                                          x axis y axis)
                                                          16mm x 9mm<br>
                                                          &nbsp; &nbsp;1920x<b>1080i</b>
                                                          &nbsp; &nbsp;60.00*+
                                                          &nbsp;50.00 &nbsp;
                                                          &nbsp;59.94 &nbsp;<br>
                                                          &nbsp; &nbsp;1920x1080 &nbsp;
                                                          &nbsp; <b>24.00</b>
                                                          &nbsp; &nbsp;23.98 &nbsp;<br>
                                                          &nbsp; &nbsp;1280x<b>720</b>
                                                          &nbsp; &nbsp; &nbsp;60.00 &nbsp;
                                                          &nbsp;50.00 &nbsp;
                                                          &nbsp;59.94 &nbsp;<br>
                                                          &nbsp; &nbsp;1024x768 &nbsp;
                                                          &nbsp; &nbsp;75.03 &nbsp;
                                                          &nbsp;70.07 &nbsp;
                                                          &nbsp;60.00 &nbsp;<br>
                                                          &nbsp; &nbsp;832x624 &nbsp; &nbsp;
                                                          &nbsp; 74.55 &nbsp;<br>
                                                          &nbsp; &nbsp;800x600 &nbsp; &nbsp;
                                                          &nbsp; 72.19 &nbsp;
                                                          &nbsp;75.00 &nbsp;
                                                          &nbsp;60.32 &nbsp;
                                                          &nbsp;56.25 &nbsp;<br>
                                                          &nbsp; &nbsp;720x576 &nbsp; &nbsp;
                                                          &nbsp; 50.00 &nbsp;<br>
                                                          &nbsp; &nbsp;720x576i &nbsp;
                                                          &nbsp; &nbsp;50.00 &nbsp;<br>
                                                          &nbsp; &nbsp;720x480 &nbsp; &nbsp;
                                                          &nbsp; 60.00 &nbsp;
                                                          &nbsp;59.94 &nbsp;<br>
                                                          &nbsp; &nbsp;720x480i &nbsp;
                                                          &nbsp; &nbsp;60.00 &nbsp;
                                                          &nbsp;59.94 &nbsp;<br>
                                                          &nbsp; &nbsp;640x480 &nbsp; &nbsp;
                                                          &nbsp; 75.00 &nbsp;
                                                          &nbsp;72.81 &nbsp;
                                                          &nbsp;66.67 &nbsp;
                                                          &nbsp;60.00 &nbsp;
                                                          &nbsp;59.94 &nbsp;<br>
                                                          &nbsp; &nbsp;720x400 &nbsp; &nbsp;
                                                          &nbsp; 70.08 &nbsp;<br>
                                                          DVI-0
                                                          disconnected
                                                          (normal left
                                                          inverted right
                                                          x axis y axis)</div>
                                                        <div><br>
                                                        </div>
                                                        <div>I think the
                                                          driver should
                                                          only support
                                                          resolutions
                                                          that are <b>progressive</b>,
                                                          but also at
                                                          least of <b>50Hz</b>.<br>
                                                        </div>
                                                      </div>
                                                      <br>
                                                      <div class="gmail_quote">
                                                        <div dir="ltr" class="gmail_attr">On
                                                          Tue, 30 Mar
                                                          2021 at 15:41,
                                                          Christian
                                                          König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                                                          wrote:<br>
                                                        </div>
                                                        <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid
                                                          rgb(204,204,204);padding-left:1ex">
                                                          <div> Mhm, no
                                                          idea why an
                                                          interlaced
                                                          resolution
                                                          would cause a
                                                          crash. Maybe
                                                          some
                                                          miscalculation
                                                          in the display
                                                          code.<br>
                                                          <br>
                                                          But apart from
                                                          that if you
                                                          just connected
                                                          your PC to a
                                                          TV I also
                                                          wouldn't
                                                          recommend
                                                          using an
                                                          interlaced
                                                          resolution in
                                                          the first
                                                          place.<br>
                                                          <br>
                                                          See those
                                                          resolutions
                                                          only exists
                                                          for backward
                                                          compatibility
                                                          with analog
                                                          hardware.<br>
                                                          <br>
                                                          I think we
                                                          would just
                                                          disable those
                                                          modes instead
                                                          of searching
                                                          for the bug.<br>
                                                          <br>
                                                          Regards,<br>
                                                          Christian.<br>
                                                          <br>
                                                          <div>Am
                                                          30.03.21 um
                                                          11:07 schrieb
                                                          Alberto Salvia
                                                          Novella:<br>
                                                          </div>
                                                          <blockquote type="cite">
                                                          <div dir="ltr">
                                                          <div>I guessed
                                                          so.</div>
                                                          <div><br>
                                                          </div>
                                                          <div>The GPU
                                                          is a Radeon
                                                          HD5870, and
                                                          the screen is
                                                          an old
                                                          Telefunken TV
(TLFK22LEDPVR1).</div>
                                                          <div><br>
                                                          </div>
                                                          <div>Since my
                                                          real display
                                                          got into
                                                          repair I used
                                                          this TV
                                                          meanwhile, and
                                                          to my surprise
                                                          it froze the
                                                          system.<br>
                                                          </div>
                                                          </div>
                                                          <br>
                                                          <div class="gmail_quote">
                                                          <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at 10:15, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                                          wrote:<br>
                                                          </div>
                                                          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid
                                                          rgb(204,204,204);padding-left:1ex">Hi
                                                          Alberto,<br>
                                                          <br>
                                                          well what
                                                          hardware do
                                                          you have?<br>
                                                          <br>
                                                          Interlaced
                                                          resolutions
                                                          are not used
                                                          any more on
                                                          modern
                                                          hardware, so
                                                          they <br>
                                                          are not well
                                                          tested.<br>
                                                          <br>
                                                          Regards,<br>
                                                          Christian.<br>
                                                          <br>
                                                          Am 30.03.21 um
                                                          10:04 schrieb
                                                          Alberto Salvia
                                                          Novella:<br>
                                                          &gt; The
                                                          entire desktop
                                                          hangs after
                                                          some minutes
                                                          when using the
                                                          module <br>
                                                          &gt; &quot;radeon&quot;
                                                          with an
                                                          interlaced
                                                          resolution.<br>
                                                          &gt;<br>
                                                          &gt; Easier to
                                                          trigger by
                                                          playing a
                                                          video on
                                                          Firefox, at
                                                          least on
                                                          kwin_x11. <br>
                                                          &gt; Wayland
                                                          didn't exhibit
                                                          the problem.<br>
                                                          &gt;<br>
                                                          &gt; Other
                                                          display
                                                          drivers, from
                                                          different
                                                          computers I
                                                          have tried,
                                                          didn't <br>
                                                          &gt; allow
                                                          those
                                                          interlaced
                                                          resolutions
                                                          all together.
                                                          It seems they
                                                          know <br>
                                                          &gt; there
                                                          will be
                                                          problems.<br>
                                                          <br>
                                                          </blockquote>
                                                          </div>
                                                          <br>
                                                          <fieldset></fieldset>
                                                          <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C7640f7339c964ba77ef708d8f45c50fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637528024640585999%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=y2RJRp4SEnJQ7qPYYJKnr0B4xRkYEZJcYY6sZ4B%2BQ5g%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="Q99Ycc+B8WLq9g3/U3SbN3Av5gHfv/FvOGFS52+InPSpxBD2YuOXstri6eUeY7TD0w3/FRNhHLkDpuI0Hv69TD2vd71m52SGsNmHJhuc1wvTi7m+TuEvRasvpv9TK4JQZ9/LYFHCj2oXC7VomDL3g0K6ZsSPlqc1RSXzTQ2u3r8=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                                                          </blockquote>
                                                          <br>
                                                          </div>
                                                        </blockquote>
                                                      </div>
                                                    </blockquote>
                                                    <br>
                                                  </div>
                                                </blockquote>
                                              </div>
                                            </blockquote>
                                            <br>
                                          </div>
                                        </blockquote>
                                      </div>
                                    </blockquote>
                                    <br>
                                  </div>
                                </blockquote>
                              </div>
                            </blockquote>
                            <br>
                          </div>
                        </blockquote>
                      </div>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------6974DE70093A7B5A8B7D80BA--

--===============0455399306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0455399306==--
