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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA92C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 08:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75BE619C9
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 08:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75BE619C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0996EA04;
	Wed, 31 Mar 2021 08:09:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0526EA00
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 08:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MClGcFCTCyycXPwggkKZeqvpIndSsskpVk9vpzm33niG5wAXYPC0jDGrzH7uAbaEsgbkZLKFL16RUSz69bv/ZpBgzz1J5GpV7Yx2P0OJ6XqtewrAOui/hzmyCMbyLwedsWfSZ5n8ZuWF6ANj1svJiJv3NlIXGFdR69Ka9eWlmT5S1EW0BGDM0h4/clIbjHcT/jqkiQR7ViCq/aafRiRMEt68SQcUKUm12ACZQPFYwrkroITaOnzzhxt93IsMWln3Q50EZLV53GQyAbYe/f6xI6/fH2sdXju4iHtKYE1qYnKEo83PGevfCcBxQH62dys66j8uW+CpBsGdyOQwDqaw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ySQ8UT469+VeUmws5cn5b6y6xSXAfa3gx2q/WcSxoQ=;
 b=Njnguy4yMBo2fNu7ZEJBP39+KxcocxndAq/EmpjBGRK4MZG5M8im/Qn1CjpNEDMtby55demp/TxEqohVKUMIC/SCoksLFfuTCFL32CEKdODLJ5QjEv61CDRX3yl5HuMXyZQ1GAYo1hNXR3zfVfezuEevkeCHgz8wBH8rJOJGvUOyHswo752VlFcuQ+Uwy+WQDOJae+/XKL6gnBKYLtqp9Ny8kNoYnRXS/98fGnv66OR61nb1ycblnTMqZimK5hvUeaqpjACfCwBT6W9Cmw2MhxRIXjhz94kiFOLF556Gwnrc3eK50lNHqwbAd5TEj04BP/IcJU7k5etYSjWu1x88bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ySQ8UT469+VeUmws5cn5b6y6xSXAfa3gx2q/WcSxoQ=;
 b=YIpDnwkKGnsAdcNJ4mwLMGfkvoBnnPdcrmZ77En50Zx4n/hMxJNrTYLnNCEn7xBwj6KoIVYcKduxcstOMRDzA8TQoNdiSjyi/GWBR6BpzsLBrh71OQOC30mSw44sH7ne6SY/bJn1CiBt23dsFb5dFYc+VFEhCZLPTXKnVqrp1yo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 08:09:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 08:09:44 +0000
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
 <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
 <7914f67b-e011-36ec-3f6d-1614ce96e3c4@amd.com>
 <CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com>
Date: Wed, 31 Mar 2021 10:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:46d6:1b43:479c:c70b]
X-ClientProxiedBy: AM9P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b]
 (2a02:908:1252:fb60:46d6:1b43:479c:c70b) by
 AM9P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Wed, 31 Mar 2021 08:09:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9818d7b8-17d6-49dc-3753-08d8f41c5809
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110CBF09729A11718156B35837C9@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sG+3tUzx1ZlqQ3L6+D//swMenmdv2SSXl7L2crbFzwlLJC+PuaGjUBGJXl0iqpj6EP4JBlbyO7UzNQYMQdz3EZyuwlzDXnVruZrzMpazBBREgGJ0ump9iSaZRwxRVfAgdzvnVHIxmluqoqzlsqyQYz8ZVfaxnpd4nafLPEgvX9fM2ORyv2AwIa1OW0FJQvfHJEPTlkMJAf4c/OteDOf1+QDss9Ne0UzFryEIbYHZYuTFecnJspKnwM5cBYBkeqP1kq8s48ivfDtusKmNphlJvkCrQ5bW3hIa0W8or8sIEPY6GrRKY8ByZeYWVv23iSpq2UlplagJ7EYpO3jBiO0882bxoQIUHEyon63idcm9flu4vHfhfB+jCRvckvnQGTa3bF2ObiytbSE+u7knIyhS4/ka/j/eTZNtp2D/n67Egray3/W8jn6V6KX5fSkyB2+WfJ/+9u7mAXVndN8YVVg0oybdTmpZAgKDy/fYIXGkNVhutwAIXHCsUxREZ/VvyH+YsvzAv/OzteyesUiQjxcWOFwEoqhEecCjAbEAJZ3lwbYtY9plTt8Yz7JP6aWTN7e3MJtKoGOa5xsVbe6zgJ00J7/l3fQVd6GYcpGtsNAVpM0IH+PMiJ2jATnR75VQ5JXvZZaX84VwZF+MpsJj3vI73dJuF7fNF1effk4cR7Nbgo1ZZ8dGJ50Wt0iIZTjWGHlhtQ7bKIU6pW6lC+3SMp8CnNJI7jol+H0dCmKYtxXQqjnLKWraziFKPMZp2EXxkI9757i85ucC4pvwf7nHbqH80HzsJ10gjeDbXtUBTDiGXus=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(4326008)(5660300002)(45080400002)(66574015)(30864003)(6666004)(966005)(478600001)(33964004)(186003)(66476007)(52116002)(38100700001)(8676002)(83380400001)(8936002)(31696002)(2906002)(166002)(31686004)(66556008)(36756003)(66946007)(6916009)(316002)(2616005)(86362001)(6486002)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2Z2Nlc3bUtDWk9hNlVEVURaT3JSbFlqbVl6cys5M1RBSDg4SDMrL092NVFl?=
 =?utf-8?B?TmZyUUNGZGpJcGtTYzJSbndRNU91eXB1cWtNbk1IbUlvL1Q1dEZESFFFQ2NG?=
 =?utf-8?B?NnV3b1NXNFd5SCt4SXFLVTh3T2VHOE81VXozV21wWVNZcXc1YmpoNk9UWHkv?=
 =?utf-8?B?N1FKS0psNlowYWF2K2V2YUllWWZnV1pqYTR4ekRRT0hnemhHRFFHQjNrNWYv?=
 =?utf-8?B?OENKUWJ3VGJ3TVVabVNXakplekRtVXFONHRESlV4R2QvZWpuRWFYNjJVcXRU?=
 =?utf-8?B?UnZWSG92ZG03ZW5YU1N2SW9BTE4veFF4MkhZSXhFNUg0ZFVRUFNqT2lxd1Vs?=
 =?utf-8?B?eWZ3SjBkVHpxaER2T2dCZXNpVlc0Ym5IRmN0bTdKVjNhM3kxOW5yWlRlSHc5?=
 =?utf-8?B?b29mTFg4djY2S1JDNXNCZlQ5NStWR0lpUFlJTWhWTmhuRXJOR1hheDBjUzVV?=
 =?utf-8?B?aUhMZ3oxUFdQNGM3ZGJFY3NlQ1VtemtxTnRXRFcvMGpLMHJmWVBBa3ZrSVc2?=
 =?utf-8?B?R2xoWVJDNThpVGVlcmFqazlLS0hkUzFud2xGVTRVQklWWGcyb2QyYjF6ZFB4?=
 =?utf-8?B?ckNXVnhucVNZaHJWR3QzNkgwYWpsc0ppbTY2QlpPV3VqMldkWDZxY0VXd2xG?=
 =?utf-8?B?bnl1VDhJL3lSWDhqOEhOaG0xYXJuYmxMVUtOcHRVeDBpcTM2bmJNV09Qa0dQ?=
 =?utf-8?B?L3kzNDlTMkR1bVJLcVVyejg3TmxnQnFWaFlOL3FjakJldnJkSk5qWnY2TU9R?=
 =?utf-8?B?UkxIc3dad09QbTBnMDZVd01TRXZYS1BTY2hoVW9IWllwNW8rQnNZZXhsck5r?=
 =?utf-8?B?MnFXeTFWeklXUXJVbnU1LzZKU1NqMjJZRU5ncnVrUHJUUVdOa3FMNDdndzll?=
 =?utf-8?B?ekVOYVVHVnlOSUtscVJReGVsQmR0RUlGeHlsWFo5L0VRUDFJMDg3WkRoVnFh?=
 =?utf-8?B?NGNqQ2RYS3ZDWkRiMlk4a0lKUHE4cXgvTmxjTDluYnQ2WHpUVzVXZkNsd2FV?=
 =?utf-8?B?RDFrVFhOUTJJNE1NTXk1bTlNOFVJZU9EdTAxczhJaXFPV1NxRVpYM1dRZVpT?=
 =?utf-8?B?cExoV3VKalMrUXl4OU5EOUh0dmJnamVVVFBjd1A1bDFqSGZYdDJHaVRSVFBO?=
 =?utf-8?B?YXhSNkI5cldMUmFrWmRpSExodmJ1dmllc1V5UWFzaVR5dWtTS0pKZWxDZjVy?=
 =?utf-8?B?M3B1Uk85cW43b2RkRnlDV1RzekY4WVBaR1FTbEhQbjBqMXVxbTJySHRjUW4y?=
 =?utf-8?B?Q1hhM3BTUTlaUTBGVjNmdzMrWmVpUzlPak93TXF5VEJUcTVZbGIrKzBuQ2xl?=
 =?utf-8?B?a1I1Wm1jci9ob04vamxMU2ZKcTdVaDlRdWhybU5JTjBIcC91ZndkakFrVFhh?=
 =?utf-8?B?SDc1VmxoRUhOaEhFTzNLTTlHbXF0RXBRbUFFd2RYdlNnb2Jsc2RTeTlWQW52?=
 =?utf-8?B?SVQvQWxsTVk5ay9jZ1BhSVhTKzZ0ejFpOFZuazMzbTh0VmQyaHNONnMwQlFH?=
 =?utf-8?B?SENLZXU4Z0Vzc1RUd1F3K000eGNITnpoUlhPZk9nbEZtOHZOQnBabjJ5VWRB?=
 =?utf-8?B?bUgzN3p1SDVob05OTTBRQmY3VG9hdzFkUXlaZDVjZGFFMTVaOUFjek01NHIz?=
 =?utf-8?B?V1pxejJVMFRwNUltbWNrQVJwb1N4anZNK1lPNXdIRkt6SXhFdE0wZFBQcTNM?=
 =?utf-8?B?bGZaUkduZnpuNDZTOVR6c3pzRVRydldaWU5NUEZXeEVPd0xiWXJnUjBBZDY1?=
 =?utf-8?B?UGFKR3NodFZScHVDUXNyM3VQUkxJaFQvbzA3REJCT1Y1S1pCR1ZPZ3NRcHRh?=
 =?utf-8?B?cmVNVG1qY3piVTN0Y05mb09pbjZBcGN2ZXZhTGRrYWtXaEdsV2N2NjJjMTlW?=
 =?utf-8?Q?0dLgmbaUqFuch?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9818d7b8-17d6-49dc-3753-08d8f41c5809
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 08:09:44.8884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cslGmeJilHp46K+dQ6whUdraX5nW9OjWEdtsaHhxFcc2DY9Tsx3/3gawbLtb3CJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 benh@kernel.crashing.org
Content-Type: multipart/mixed; boundary="===============0247288580=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0247288580==
Content-Type: multipart/alternative;
 boundary="------------6B593D2A6B597A2D905B01A6"
Content-Language: en-US

--------------6B593D2A6B597A2D905B01A6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Can you access the system over the network and see if there is anything 
in the system log?

It sounds like the display stack has crashed, but when the sound keeps 
playing the system is most likely still responsive over network.

Thanks,
Christian.

Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
> What happens is this simple: after a few minutes, about 6 or so, the 
> entire content of the screen stays still. In some minor situations 
> only the applications panel of KDE Plasma.
>
> If music is playing it continues playing, so only graphics are hung. 
> Yet in most cases the power button won't shut down the computer, as it 
> usually does.
>
> At least this is the case using kwin on x11, and not on wayland. It 
> only happens on "radeon" and not on Intel or "radeonhd".
>
> On Wed, 31 Mar 2021 at 09:48, Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Correct, but a TV is intended for videos only. That's why it
>     implements only the lower HDMI standard.
>
>     Interlaced transmits only halve the lines with each frame, so a
>     60Hz mode effectively either becomes a 30Hz mode, halving the
>     vertical resolution or adaptive motion compensated which the know
>     visual artifacts. Depending on what the deinterlacing setting on
>     your TV is.
>
>     You could just add a progressive 1920x540@60 or 1920x1080@30 mode
>     manually and would have the same effect with probably better
>     quality. See https://de.wikipedia.org/wiki/Deinterlacing
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&data=04%7C01%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608d8f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527747331540923%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=7dTqbjDCQaDTGcXA3yt8jKzSnT%2BrqcdkMhukqyOGwg0%3D&reserved=0>
>     for reference.
>
>     If you can give us some more information what is happening when
>     the system freeze we could try to narrow this down, but we can't
>     spend much time on a very specific use case in a driver which is
>     in maintenance mode.
>
>     Regards,
>     Christian.
>
>     Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
>>     24fps is intended for video only. Anything interactive at 24fps,
>>     as just moving the mouse around, is extremely choppy.
>>
>>     No way anyone would prefer that over an interlaced resolution or
>>     a lower resolution. That is, by far, the worst option.
>>
>>     Just try it on your screen, set it to 24Hz or alike, and tell me
>>     your experience. You can't even tell where the mouse is going to go.
>>
>>     On Wed, 31 Mar 2021 at 08:44, Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Hi Alberto,
>>
>>         well a frame rate of 24Hz is perfectly reasonable for a TV
>>         and desktop usage.
>>
>>         This is probably caused by the TVs limited HDMI bandwidth and
>>         a refresh rate of 30/25 Hz for the interlaced mode isn't much
>>         better either.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>>>         The frame-rate at 24Hz is extremely poor for normal desktop
>>>         usage.
>>>
>>>         If the highest resolution, aka 1080p, uses that refresh rate
>>>         then the desktop will default to that frame-rate.
>>>
>>>         Other progressive modes don't exhibit any issue.
>>>
>>>         On Tue, 30 Mar 2021 at 18:26, Christian König
>>>         <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>>>         wrote:
>>>
>>>             Hi Alberto,
>>>
>>>>             I think the driver should only support resolutions that
>>>>             are *progressive*, but also at least of *50Hz*.
>>>
>>>             Why do you think so?, the 24Hz resolution seems to be
>>>             the native one of the display.
>>>
>>>             Regards,
>>>             Christian.
>>>
>>>             Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>>>             This is why I'm using interlaced:
>>>>
>>>>             $ *xrandr*
>>>>             Screen 0: minimum 320 x 200, current 1920 x 1080,
>>>>             maximum 8192 x 8192
>>>>             DisplayPort-0 disconnected (normal left inverted right
>>>>             x axis y axis)
>>>>             HDMI-0 connected primary 1920x1080+0+0 (normal left
>>>>             inverted right x axis y axis) 16mm x 9mm
>>>>                1920x*1080i*    60.00*+  50.00    59.94
>>>>                1920x1080 *24.00*  23.98
>>>>                1280x*720*      60.00    50.00    59.94
>>>>                1024x768      75.03    70.07  60.00
>>>>                832x624       74.55
>>>>                800x600       72.19    75.00  60.32    56.25
>>>>                720x576       50.00
>>>>                720x576i      50.00
>>>>                720x480       60.00    59.94
>>>>                720x480i      60.00    59.94
>>>>                640x480       75.00    72.81  66.67    60.00    59.94
>>>>                720x400       70.08
>>>>             DVI-0 disconnected (normal left inverted right x axis y
>>>>             axis)
>>>>
>>>>             I think the driver should only support resolutions that
>>>>             are *progressive*, but also at least of *50Hz*.
>>>>
>>>>             On Tue, 30 Mar 2021 at 15:41, Christian König
>>>>             <ckoenig.leichtzumerken@gmail.com
>>>>             <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>>
>>>>                 Mhm, no idea why an interlaced resolution would
>>>>                 cause a crash. Maybe some miscalculation in the
>>>>                 display code.
>>>>
>>>>                 But apart from that if you just connected your PC
>>>>                 to a TV I also wouldn't recommend using an
>>>>                 interlaced resolution in the first place.
>>>>
>>>>                 See those resolutions only exists for backward
>>>>                 compatibility with analog hardware.
>>>>
>>>>                 I think we would just disable those modes instead
>>>>                 of searching for the bug.
>>>>
>>>>                 Regards,
>>>>                 Christian.
>>>>
>>>>                 Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>>>>                 I guessed so.
>>>>>
>>>>>                 The GPU is a Radeon HD5870, and the screen is an
>>>>>                 old Telefunken TV (TLFK22LEDPVR1).
>>>>>
>>>>>                 Since my real display got into repair I used this
>>>>>                 TV meanwhile, and to my surprise it froze the system.
>>>>>
>>>>>                 On Tue, 30 Mar 2021 at 10:15, Christian König
>>>>>                 <christian.koenig@amd.com
>>>>>                 <mailto:christian.koenig@amd.com>> wrote:
>>>>>
>>>>>                     Hi Alberto,
>>>>>
>>>>>                     well what hardware do you have?
>>>>>
>>>>>                     Interlaced resolutions are not used any more
>>>>>                     on modern hardware, so they
>>>>>                     are not well tested.
>>>>>
>>>>>                     Regards,
>>>>>                     Christian.
>>>>>
>>>>>                     Am 30.03.21 um 10:04 schrieb Alberto Salvia
>>>>>                     Novella:
>>>>>                     > The entire desktop hangs after some minutes
>>>>>                     when using the module
>>>>>                     > "radeon" with an interlaced resolution.
>>>>>                     >
>>>>>                     > Easier to trigger by playing a video on
>>>>>                     Firefox, at least on kwin_x11.
>>>>>                     > Wayland didn't exhibit the problem.
>>>>>                     >
>>>>>                     > Other display drivers, from different
>>>>>                     computers I have tried, didn't
>>>>>                     > allow those interlaced resolutions all
>>>>>                     together. It seems they know
>>>>>                     > there will be problems.
>>>>>
>>>>>
>>>>>                 _______________________________________________
>>>>>                 amd-gfx mailing list
>>>>>                 amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>>                 https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608d8f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527747331550917%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=5BcOM0IHbXdYbWjy1a7VQOFgbkFGoV0FMzbDmZe94l0%3D&reserved=0>
>>>>
>>>
>>
>


--------------6B593D2A6B597A2D905B01A6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Can you access the system over the network and see if there is
    anything in the system log?<br>
    <br>
    It sounds like the display stack has crashed, but when the sound
    keeps playing the system is most likely still responsive over
    network.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 31.03.21 um 10:05 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com">
      
      <div dir="ltr">
        <div>What happens is this simple: after a few minutes, about 6
          or so, the entire content of the screen stays still. In some
          minor situations only the applications panel of KDE Plasma.</div>
        <div><br>
        </div>
        <div>If music is playing it continues playing, so only graphics
          are hung. Yet in most cases the power button won't shut down
          the computer, as it usually does.<br>
        </div>
        <div><br>
        </div>
        <div>At least this is the case using kwin on x11, and not on
          wayland. It only happens on &quot;radeon&quot; and not on Intel or
          &quot;radeonhd&quot;.</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at 09:48,
          Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Correct, but a TV is intended for videos only. That's
            why it implements only the lower HDMI standard.<br>
            <br>
            Interlaced transmits only halve the lines with each frame,
            so a 60Hz mode effectively either becomes a 30Hz mode,
            halving the vertical resolution or adaptive motion
            compensated which the know visual artifacts. Depending on
            what the deinterlacing setting on your TV is.<br>
            <br>
            You could just add a progressive 1920x540@60 or 1920x1080@30
            mode manually and would have the same effect with probably
            better quality. See <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608d8f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527747331540923%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7dTqbjDCQaDTGcXA3yt8jKzSnT%2BrqcdkMhukqyOGwg0%3D&amp;reserved=0" originalsrc="https://de.wikipedia.org/wiki/Deinterlacing" shash="tAfthBTRehtz4MOnRmlmu2jbeLG+X43s8ihuuRDwSz21fgnIma99PLyzlI8WMsMecsfGunDU7f3Mg2fUt1HcxR/v42XUGeCg+LHDcLOSKu1ymVvetn9zgsCOfOfZWS/JDith415GIkFvwQJaLHNvGJG2z9O07bFBDcqXg7xts5M=" target="_blank" moz-do-not-send="true">https://de.wikipedia.org/wiki/Deinterlacing</a>
            for reference.<br>
            <br>
            If you can give us some more information what is happening
            when the system freeze we could try to narrow this down, but
            we can't spend much time on a very specific use case in a
            driver which is in maintenance mode.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>24fps is intended for video only. Anything
                  interactive at 24fps, as just moving the mouse around,
                  is extremely choppy.</div>
                <div><br>
                </div>
                <div>No way anyone would prefer that over an interlaced
                  resolution or a lower resolution. That is, by far, the
                  worst option.</div>
                <div><br>
                </div>
                <div>Just try it on your screen, set it to 24Hz or
                  alike, and tell me your experience. You can't even
                  tell where the mouse is going to go.<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at
                  08:44, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Hi Alberto,<br>
                    <br>
                    well a frame rate of 24Hz is perfectly reasonable
                    for a TV and desktop usage.<br>
                    <br>
                    This is probably caused by the TVs limited HDMI
                    bandwidth and a refresh rate of 30/25 Hz for the
                    interlaced mode isn't much better either.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <div>Am 30.03.21 um 22:59 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>The frame-rate at 24Hz is extremely poor
                          for normal desktop usage.<br>
                        </div>
                        <div><br>
                        </div>
                        <div>If the highest resolution, aka 1080p, uses
                          that refresh rate then the desktop will
                          default to that frame-rate.</div>
                        <div><br>
                        </div>
                        <div>Other progressive modes don't exhibit any
                          issue.<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Tue, 30 Mar
                          2021 at 18:26, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div> Hi Alberto,<br>
                            <br>
                            <blockquote type="cite">I think the driver
                              should only support resolutions that are <b>progressive</b>,
                              but also at least of <b>50Hz</b>.</blockquote>
                            <br>
                            Why do you think so?, the 24Hz resolution
                            seems to be the native one of the display.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            <div>Am 30.03.21 um 17:37 schrieb Alberto
                              Salvia Novella:<br>
                            </div>
                            <blockquote type="cite">
                              <div dir="ltr">
                                <div>This is why I'm using interlaced:<br>
                                </div>
                                <div><br>
                                </div>
                                <div>$ <b>xrandr</b><br>
                                  Screen 0: minimum 320 x 200, current
                                  1920 x 1080, maximum 8192 x 8192<br>
                                  DisplayPort-0 disconnected (normal
                                  left inverted right x axis y axis)<br>
                                  HDMI-0 connected primary 1920x1080+0+0
                                  (normal left inverted right x axis y
                                  axis) 16mm x 9mm<br>
                                  &nbsp; &nbsp;1920x<b>1080i</b> &nbsp; &nbsp;60.00*+ &nbsp;50.00
                                  &nbsp; &nbsp;59.94 &nbsp;<br>
                                  &nbsp; &nbsp;1920x1080 &nbsp; &nbsp; <b>24.00</b> &nbsp;
                                  &nbsp;23.98 &nbsp;<br>
                                  &nbsp; &nbsp;1280x<b>720</b> &nbsp; &nbsp; &nbsp;60.00 &nbsp; &nbsp;50.00
                                  &nbsp; &nbsp;59.94 &nbsp;<br>
                                  &nbsp; &nbsp;1024x768 &nbsp; &nbsp; &nbsp;75.03 &nbsp; &nbsp;70.07 &nbsp;
                                  &nbsp;60.00 &nbsp;<br>
                                  &nbsp; &nbsp;832x624 &nbsp; &nbsp; &nbsp; 74.55 &nbsp;<br>
                                  &nbsp; &nbsp;800x600 &nbsp; &nbsp; &nbsp; 72.19 &nbsp; &nbsp;75.00 &nbsp;
                                  &nbsp;60.32 &nbsp; &nbsp;56.25 &nbsp;<br>
                                  &nbsp; &nbsp;720x576 &nbsp; &nbsp; &nbsp; 50.00 &nbsp;<br>
                                  &nbsp; &nbsp;720x576i &nbsp; &nbsp; &nbsp;50.00 &nbsp;<br>
                                  &nbsp; &nbsp;720x480 &nbsp; &nbsp; &nbsp; 60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                                  &nbsp; &nbsp;720x480i &nbsp; &nbsp; &nbsp;60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                                  &nbsp; &nbsp;640x480 &nbsp; &nbsp; &nbsp; 75.00 &nbsp; &nbsp;72.81 &nbsp;
                                  &nbsp;66.67 &nbsp; &nbsp;60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                                  &nbsp; &nbsp;720x400 &nbsp; &nbsp; &nbsp; 70.08 &nbsp;<br>
                                  DVI-0 disconnected (normal left
                                  inverted right x axis y axis)</div>
                                <div><br>
                                </div>
                                <div>I think the driver should only
                                  support resolutions that are <b>progressive</b>,
                                  but also at least of <b>50Hz</b>.<br>
                                </div>
                              </div>
                              <br>
                              <div class="gmail_quote">
                                <div dir="ltr" class="gmail_attr">On
                                  Tue, 30 Mar 2021 at 15:41, Christian
                                  König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                  0.8ex;border-left:1px solid
                                  rgb(204,204,204);padding-left:1ex">
                                  <div> Mhm, no idea why an interlaced
                                    resolution would cause a crash.
                                    Maybe some miscalculation in the
                                    display code.<br>
                                    <br>
                                    But apart from that if you just
                                    connected your PC to a TV I also
                                    wouldn't recommend using an
                                    interlaced resolution in the first
                                    place.<br>
                                    <br>
                                    See those resolutions only exists
                                    for backward compatibility with
                                    analog hardware.<br>
                                    <br>
                                    I think we would just disable those
                                    modes instead of searching for the
                                    bug.<br>
                                    <br>
                                    Regards,<br>
                                    Christian.<br>
                                    <br>
                                    <div>Am 30.03.21 um 11:07 schrieb
                                      Alberto Salvia Novella:<br>
                                    </div>
                                    <blockquote type="cite">
                                      <div dir="ltr">
                                        <div>I guessed so.</div>
                                        <div><br>
                                        </div>
                                        <div>The GPU is a Radeon HD5870,
                                          and the screen is an old
                                          Telefunken TV (TLFK22LEDPVR1).</div>
                                        <div><br>
                                        </div>
                                        <div>Since my real display got
                                          into repair I used this TV
                                          meanwhile, and to my surprise
                                          it froze the system.<br>
                                        </div>
                                      </div>
                                      <br>
                                      <div class="gmail_quote">
                                        <div dir="ltr" class="gmail_attr">On Tue, 30
                                          Mar 2021 at 10:15, Christian
                                          König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                          wrote:<br>
                                        </div>
                                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                          0.8ex;border-left:1px solid
                                          rgb(204,204,204);padding-left:1ex">Hi
                                          Alberto,<br>
                                          <br>
                                          well what hardware do you
                                          have?<br>
                                          <br>
                                          Interlaced resolutions are not
                                          used any more on modern
                                          hardware, so they <br>
                                          are not well tested.<br>
                                          <br>
                                          Regards,<br>
                                          Christian.<br>
                                          <br>
                                          Am 30.03.21 um 10:04 schrieb
                                          Alberto Salvia Novella:<br>
                                          &gt; The entire desktop hangs
                                          after some minutes when using
                                          the module <br>
                                          &gt; &quot;radeon&quot; with an
                                          interlaced resolution.<br>
                                          &gt;<br>
                                          &gt; Easier to trigger by
                                          playing a video on Firefox, at
                                          least on kwin_x11. <br>
                                          &gt; Wayland didn't exhibit
                                          the problem.<br>
                                          &gt;<br>
                                          &gt; Other display drivers,
                                          from different computers I
                                          have tried, didn't <br>
                                          &gt; allow those interlaced
                                          resolutions all together. It
                                          seems they know <br>
                                          &gt; there will be problems.<br>
                                          <br>
                                        </blockquote>
                                      </div>
                                      <br>
                                      <fieldset></fieldset>
                                      <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608d8f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527747331550917%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5BcOM0IHbXdYbWjy1a7VQOFgbkFGoV0FMzbDmZe94l0%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="NBES5s9ksHVtzfJnUUDUbmQXKohSsuqfOWOv38HS8bSJRPcdjuhNVXxIFXM7jzm4bCaCT0YUmHQgv0pHFmNBGTsWyZhmpkMwcnzMVauB7ycQEsCJutiTcfEZyRFhoZ02+x+Xxid1lYUcujgwwsryiAkyKTYVUYzPoVyT5yobp6g=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
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
  </body>
</html>

--------------6B593D2A6B597A2D905B01A6--

--===============0247288580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0247288580==--
