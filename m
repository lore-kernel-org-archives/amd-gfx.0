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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A232C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5078260FF3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5078260FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C2C6EAB0;
	Wed, 31 Mar 2021 14:36:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23C56EAB0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 14:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgFmPFbsj/gImh6T+WYTHExjj/5I/S7tERqmdwksLzFLS4yA+J1DokkcMPqce7BmjxXnebZ3blfW4uIxI4lr51fX9fXL9YsDv1MMAJeBvoatAQf9HEDY1bB0keb0R6dHy/dj7yhgGHmfYSY1EC2dhMpeY2P8UM9G8ia0kBocEWo+TZpK9xJPp8DgwnNqLPRa5d02BLMEkhbee8YobGZamWrDveVUAG5tmzV2h7Y1LrIsBA2x0MROepjsyPivwFFLOr4+YeHhBjkt+N6Ne8F5p8Vwu8unk4p1bKSbZK0M34h9AEvtztS1/5saSoMWBPBrADOo4IYyCAx7NpvSX/4JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xirYkKosfi8KnyohK9QnWuIYKmKMC1w3yv2v7OpoZl4=;
 b=RQvcEBgJ7HtUvEg/7in7i0hT0yXJvgMBNGQr2mgZ6gMm4ef3n63REyd+KYvO8J6t1QWbxboY5fHS48+knND+ounJszB5B1F23dZg4YxJw6ViebUYy+YdNu0CXISKVFimlbZIjNGqGAXkCiVc5aoRBJvYMTCTKQP4752cqG5b7lkVyOfVh1XYr/dwaQvOp5+eiYWf55d486tV1kq4KtdsBTlKkrTu0kcPyjr89Vj4J7T526HVB3oKCFdBhIkd9QgdfEaleQQ6DGxi5A8hZxKuSl0uP44Z+CMYNl3WKSwrjvT7JWR6PZRSQQd0kqvruz4y3GG9828rIvA/Wmq5Kxn72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xirYkKosfi8KnyohK9QnWuIYKmKMC1w3yv2v7OpoZl4=;
 b=szzVHIPqx8Bt6XoL5N3Pzvq3+chd+hIrDYw5rqizerRzWigZbpQ07F5AaODNAImGK/54X4Ctfv2k8VOiHR4broeEzMu1JiV+0S/CT92MdAsvjRl6Ib7Ge3VnjKP01IkLUfsZnRmODgRlbGBc+BEkCUl4CfZZdnB/YLBRe3D0crU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 14:36:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 14:36:51 +0000
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
 <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com>
 <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0eee8e42-5da8-1ce3-bff7-fe6e2ab18cde@amd.com>
Date: Wed, 31 Mar 2021 16:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:46d6:1b43:479c:c70b]
X-ClientProxiedBy: AM4PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:200:89::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b]
 (2a02:908:1252:fb60:46d6:1b43:479c:c70b) by
 AM4PR0202CA0015.eurprd02.prod.outlook.com (2603:10a6:200:89::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Wed, 31 Mar 2021 14:36:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e3f0ea6-4933-4c8e-e19f-08d8f4526c55
X-MS-TrafficTypeDiagnostic: BL0PR12MB2450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2450CC7BDAB7D83D291A07CD837C9@BL0PR12MB2450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/fVXfJ/Ch64p03vkRslDPg/amacsf0oZujisdv7wauQ7mR3kufj0HtTMJwyMn8FdasbSuqQiXW3l4ykeXoCrFy8684EGBgTf/lq6/i478QL+6XWsGvPwKaGCguXVCUmokiAHTYOp8CL7bWWKuisPAk0cC1AhGyOPUd98y0ltrlOeUfz1y9igYoSMT5k1dGgKt+7kABji/CJwQDOWsqSAE8swATxhJRgNX1XPmB8KcAngXDfWRveADv5OMm1d7J17TMb733c6PLDc88koYeHsSLRNNiHjSbM0RDPg975cgLbf4JmoEJhMF4wiFfJAF589DHp9+26lLeqUXPaRSF/Z8WcoQYwaxudyo8pC3KhgS0ueLVIYT5/p9W9M8wT7pekrN57Q5cie+sRgDJbhfwAaIeTttA3xAfWLslqLHcd4chiXHgYQsPyqy/Z68G5hrG6NnfmrZW6laJbw6t5YTSbZ3m42+0/xQq3szTKsBvWwzndJLWI6r2hLBal5yCNHpZZfTP6nfsHb0gSA3P3RYQUFjbWSXO6DzxlRtGgxrf9uHDMvjcAOX3fEsMTEx10ZH4MAnob6JK1eXbTjiOJTzRL7mrx260zWkl8Thoq9c6/LZkPRhGmiCznQ00c43K/A98+/7Byxhlmlvss+Vt2vq/0Xr5XPc0s7lpHA9zm4eDmYLAo7bgejeQyEh7zaPXjatpNvpeyTYArThTwoCMe7OFN2MI4UKS8ryVdj49vj7047HkKbtf3sPAYCCmcLX8wnQLwIrqeJYXx/zn+Kaez7ayqpIVxI77nsBPvJzu4sMauyco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(16526019)(2906002)(2616005)(5660300002)(66946007)(8676002)(478600001)(316002)(6666004)(66476007)(66556008)(8936002)(36756003)(33964004)(4326008)(45080400002)(86362001)(52116002)(66574015)(30864003)(186003)(6486002)(31686004)(83380400001)(6916009)(166002)(38100700001)(31696002)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZjNhUHgvSTFiOUt2T1NSdzhuTkhqYXo2ZkJMa0Y0OVUrc29Fc09ZYmcreXVG?=
 =?utf-8?B?RHNvaUNRY1NaSU03L0ZhYnh1WVRtNU5zSi9RN01OcUJSbVhFejIxVkVKOEtN?=
 =?utf-8?B?dFVMR2d1dkxHdVNBMXU1NUk1OEF4blFHcVF3UlNTNlRKeStvblcyaGJVV1dF?=
 =?utf-8?B?UWJ2OVNIYkt1STBWdUE5L3QwWjkvUzdJaG9xL3BtSisrcUdwWitXUllZdEV5?=
 =?utf-8?B?ZnlxQTU5RTBlZWRuRXRFVjZqZUZHNGR1bE11cnBOZy9BMTNMcHFoSGNMaVRM?=
 =?utf-8?B?bU1UUjQzSTlrK2pWcnUvY3pBYS9JVUMrenkwc2l1OHV1YmpvOXRnYkdtTnZN?=
 =?utf-8?B?Q3BJaFkxWVJtcEU3dXN6RnpEUm1WL2ZCQzdtL0FITExFNE9US3o4TUJaSnpZ?=
 =?utf-8?B?Y1d2YXFkYm92VHFNeHJ2STEyVzNUUUh5amZPQU43Wmd3YVh5akNWTHNIc1hj?=
 =?utf-8?B?OTk5SEFXa3V4QW4zaGRLeDl0VWgvNDFVZGJUaVo0Qzg5dEsyUlJJUjJMNTdM?=
 =?utf-8?B?YmFWcTZORDNwMUNuRWFJeDZ6dkM3OWNaejFWTVNrTWJrdS9HTUxxY25jNEps?=
 =?utf-8?B?allYQ1kzZmJPTlMvSFJQWlBaUFo5VnpPVHM4ZEdROXhuR2lVVGxKNmFiS1dm?=
 =?utf-8?B?MytkYU5qa0lIeG1JN3FOdUVvVFFlSW5xSEl0K2VXTUFiYzJ3d3lCQ3MxaHJK?=
 =?utf-8?B?NzNvdURZVXB2Yy9xQ3VsUWNJcDZyaEpWaUpyRTYxNnVMbWVUOVhxNFJOSzln?=
 =?utf-8?B?UzFqdmpYc3Jja3Eza2JLR3dRMU1sYS9oRGZCdEFLSy82NjQ4WVhVSXdBTE1h?=
 =?utf-8?B?MC9aams3bGZKQmdFTk5GU2JndE1CdTFPUWVSUkNOTDk3OGwyK296VWhiVHdG?=
 =?utf-8?B?ZVJyNjdTUStBZlYvV2pzd29TUy9XdW1yaU9hdVQ3eG4xcW5vN3dQMkdOUVpq?=
 =?utf-8?B?RVdaTGNjWTJGdi93WWZJSjFzbWNjbms0UXIrbmJXV29XWHh1TjE1U04vTE51?=
 =?utf-8?B?V0ovN2h6dko1STczQU5hbldERGFZRVllanpwdUFSY0RILzlaV256N01rV1hN?=
 =?utf-8?B?VjNLVlR1NkRQQmlYYnpocE5ZZDVLejNJTG1BSzAwVitxalNPNnVzaXRBVTYx?=
 =?utf-8?B?cmxZclY3TTFPMjl0M1NMdWs0STR6cUt3ekxHYlNnK3ViSEhZTkJUK2w2c2Ro?=
 =?utf-8?B?Z0w4L3NaZjZEYkJoUEcvMkI4OWJ2NHZacW0zU05hSk53bnlheHVqNHpXUGVR?=
 =?utf-8?B?ZkRsaGRIUWJOTHdBemdlRXJpZEhyRjBnREFPR25maWNSSXgwQ2F3TmM1a1NN?=
 =?utf-8?B?d3g4UExPM0tuTTk2a0tYTDJ5SXJ6d2x6dC85VFFoQjV0TlNLUFpxUzB2NjVY?=
 =?utf-8?B?TFBwa3hJY1RzckxKc2pLTWprNkRPK0VvODcwaTF3WHJBQzFlakxTV1krbVMy?=
 =?utf-8?B?T2hIYnR3cDhIL0VjdzU3b3hLNmNVdlFCbjdENzJqSmw3RGEwcjJHWVh5eStM?=
 =?utf-8?B?K2JrYVVPdmRMNlBpZ3B4eU9HV3lZemdoUmtRRjhrVW5GZ0RwK2liVU5BMFBh?=
 =?utf-8?B?bmFtcXc1TmwyUzVyNjYycGRmSnFYeGNaNUdQSFB3alAwRFlrRXpqRHB3MjdL?=
 =?utf-8?B?OVBOeEtGWndVanMvdEtuOUNFN3cvd21yd0tGZ1NGbXZMa2Z1bVRNSnk5Z0Vn?=
 =?utf-8?B?T2c0UzM3N1NNSUIwZ0RpUnhreHhzSnBGQ0JlM1V6R2ZxdU5wck1OVDJBZENh?=
 =?utf-8?B?MnpOVkYzR2FPNXBTb29KbDdCOG9wYVI3VFVRdjYzcjZVR1E5eitDZUhzdnAy?=
 =?utf-8?B?eVlNUjNDRmtXMWYvT2s1M2JFNXlJMVgweERlOXl0TEYyREw1V3A4Rm1ZMHpO?=
 =?utf-8?Q?OvvOBFvIWyARK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f0ea6-4933-4c8e-e19f-08d8f4526c55
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 14:36:51.8876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlBLTCTG4l8M7fEJaAkQCa2fBVml6+/WosLtxKN+oXGekS++NpzoRLVw1Z9SjQNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
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
Content-Type: multipart/mixed; boundary="===============0009527351=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0009527351==
Content-Type: multipart/alternative;
 boundary="------------DFDA8552E9F9BFB4581021B6"
Content-Language: en-US

--------------DFDA8552E9F9BFB4581021B6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Mhm strange.

Can you get me the output of "sudo cat 
/sys/kernel/debug/dri/0/radeon_fence_info" when the problem happens?

Thanks,
Christian.

Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:
> - The computer still replies to *ping*.
> - The *journal* shows no errors, but a few warnings 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F5a0bf22220398549%23D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy&data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=1jQLb8pO7eJYTORNisjequdWSCoKPsrrv7y%2F4U%2BojLM%3D&reserved=0>.
> - The *mouse* doesn't freeze.
>
> On Wed, 31 Mar 2021 at 10:09, Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Can you access the system over the network and see if there is
>     anything in the system log?
>
>     It sounds like the display stack has crashed, but when the sound
>     keeps playing the system is most likely still responsive over network.
>
>     Thanks,
>     Christian.
>
>     Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
>>     What happens is this simple: after a few minutes, about 6 or so,
>>     the entire content of the screen stays still. In some minor
>>     situations only the applications panel of KDE Plasma.
>>
>>     If music is playing it continues playing, so only graphics are
>>     hung. Yet in most cases the power button won't shut down the
>>     computer, as it usually does.
>>
>>     At least this is the case using kwin on x11, and not on wayland.
>>     It only happens on "radeon" and not on Intel or "radeonhd".
>>
>>     On Wed, 31 Mar 2021 at 09:48, Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Correct, but a TV is intended for videos only. That's why it
>>         implements only the lower HDMI standard.
>>
>>         Interlaced transmits only halve the lines with each frame, so
>>         a 60Hz mode effectively either becomes a 30Hz mode, halving
>>         the vertical resolution or adaptive motion compensated which
>>         the know visual artifacts. Depending on what the
>>         deinterlacing setting on your TV is.
>>
>>         You could just add a progressive 1920x540@60 or 1920x1080@30
>>         mode manually and would have the same effect with probably
>>         better quality. See
>>         https://de.wikipedia.org/wiki/Deinterlacing
>>         <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=UTefQjeEYVrJto%2FqBlna%2FQKihbJe2HQG%2BczlZViFPDY%3D&reserved=0>
>>         for reference.
>>
>>         If you can give us some more information what is happening
>>         when the system freeze we could try to narrow this down, but
>>         we can't spend much time on a very specific use case in a
>>         driver which is in maintenance mode.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
>>>         24fps is intended for video only. Anything interactive at
>>>         24fps, as just moving the mouse around, is extremely choppy.
>>>
>>>         No way anyone would prefer that over an interlaced
>>>         resolution or a lower resolution. That is, by far, the worst
>>>         option.
>>>
>>>         Just try it on your screen, set it to 24Hz or alike, and
>>>         tell me your experience. You can't even tell where the mouse
>>>         is going to go.
>>>
>>>         On Wed, 31 Mar 2021 at 08:44, Christian König
>>>         <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>>>         wrote:
>>>
>>>             Hi Alberto,
>>>
>>>             well a frame rate of 24Hz is perfectly reasonable for a
>>>             TV and desktop usage.
>>>
>>>             This is probably caused by the TVs limited HDMI
>>>             bandwidth and a refresh rate of 30/25 Hz for the
>>>             interlaced mode isn't much better either.
>>>
>>>             Regards,
>>>             Christian.
>>>
>>>             Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>>>>             The frame-rate at 24Hz is extremely poor for normal
>>>>             desktop usage.
>>>>
>>>>             If the highest resolution, aka 1080p, uses that refresh
>>>>             rate then the desktop will default to that frame-rate.
>>>>
>>>>             Other progressive modes don't exhibit any issue.
>>>>
>>>>             On Tue, 30 Mar 2021 at 18:26, Christian König
>>>>             <christian.koenig@amd.com
>>>>             <mailto:christian.koenig@amd.com>> wrote:
>>>>
>>>>                 Hi Alberto,
>>>>
>>>>>                 I think the driver should only support resolutions
>>>>>                 that are *progressive*, but also at least of *50Hz*.
>>>>
>>>>                 Why do you think so?, the 24Hz resolution seems to
>>>>                 be the native one of the display.
>>>>
>>>>                 Regards,
>>>>                 Christian.
>>>>
>>>>                 Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>>>>                 This is why I'm using interlaced:
>>>>>
>>>>>                 $ *xrandr*
>>>>>                 Screen 0: minimum 320 x 200, current 1920 x 1080,
>>>>>                 maximum 8192 x 8192
>>>>>                 DisplayPort-0 disconnected (normal left inverted
>>>>>                 right x axis y axis)
>>>>>                 HDMI-0 connected primary 1920x1080+0+0 (normal
>>>>>                 left inverted right x axis y axis) 16mm x 9mm
>>>>>                    1920x*1080i*  60.00*+  50.00    59.94
>>>>>                    1920x1080 *24.00*    23.98
>>>>>                    1280x*720*      60.00    50.00    59.94
>>>>>                    1024x768      75.03  70.07    60.00
>>>>>                    832x624       74.55
>>>>>                    800x600       72.19  75.00    60.32    56.25
>>>>>                    720x576       50.00
>>>>>                    720x576i      50.00
>>>>>                    720x480       60.00  59.94
>>>>>                    720x480i      60.00  59.94
>>>>>                    640x480       75.00  72.81    66.67    60.00
>>>>>                  59.94
>>>>>                    720x400       70.08
>>>>>                 DVI-0 disconnected (normal left inverted right x
>>>>>                 axis y axis)
>>>>>
>>>>>                 I think the driver should only support resolutions
>>>>>                 that are *progressive*, but also at least of *50Hz*.
>>>>>
>>>>>                 On Tue, 30 Mar 2021 at 15:41, Christian König
>>>>>                 <ckoenig.leichtzumerken@gmail.com
>>>>>                 <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>>>
>>>>>                     Mhm, no idea why an interlaced resolution
>>>>>                     would cause a crash. Maybe some miscalculation
>>>>>                     in the display code.
>>>>>
>>>>>                     But apart from that if you just connected your
>>>>>                     PC to a TV I also wouldn't recommend using an
>>>>>                     interlaced resolution in the first place.
>>>>>
>>>>>                     See those resolutions only exists for backward
>>>>>                     compatibility with analog hardware.
>>>>>
>>>>>                     I think we would just disable those modes
>>>>>                     instead of searching for the bug.
>>>>>
>>>>>                     Regards,
>>>>>                     Christian.
>>>>>
>>>>>                     Am 30.03.21 um 11:07 schrieb Alberto Salvia
>>>>>                     Novella:
>>>>>>                     I guessed so.
>>>>>>
>>>>>>                     The GPU is a Radeon HD5870, and the screen is
>>>>>>                     an old Telefunken TV (TLFK22LEDPVR1).
>>>>>>
>>>>>>                     Since my real display got into repair I used
>>>>>>                     this TV meanwhile, and to my surprise it
>>>>>>                     froze the system.
>>>>>>
>>>>>>                     On Tue, 30 Mar 2021 at 10:15, Christian König
>>>>>>                     <christian.koenig@amd.com
>>>>>>                     <mailto:christian.koenig@amd.com>> wrote:
>>>>>>
>>>>>>                         Hi Alberto,
>>>>>>
>>>>>>                         well what hardware do you have?
>>>>>>
>>>>>>                         Interlaced resolutions are not used any
>>>>>>                         more on modern hardware, so they
>>>>>>                         are not well tested.
>>>>>>
>>>>>>                         Regards,
>>>>>>                         Christian.
>>>>>>
>>>>>>                         Am 30.03.21 um 10:04 schrieb Alberto
>>>>>>                         Salvia Novella:
>>>>>>                         > The entire desktop hangs after some
>>>>>>                         minutes when using the module
>>>>>>                         > "radeon" with an interlaced resolution.
>>>>>>                         >
>>>>>>                         > Easier to trigger by playing a video on
>>>>>>                         Firefox, at least on kwin_x11.
>>>>>>                         > Wayland didn't exhibit the problem.
>>>>>>                         >
>>>>>>                         > Other display drivers, from different
>>>>>>                         computers I have tried, didn't
>>>>>>                         > allow those interlaced resolutions all
>>>>>>                         together. It seems they know
>>>>>>                         > there will be problems.
>>>>>>
>>>>>>
>>>>>>                     _______________________________________________
>>>>>>                     amd-gfx mailing list
>>>>>>                     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>>>                     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411082891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=5HXXJnOGGnEYSV%2BY%2FyWu031sE4CxFTKS2QqcKvlhhPs%3D&reserved=0>
>>>>>
>>>>
>>>
>>
>


--------------DFDA8552E9F9BFB4581021B6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Mhm strange.<br>
    <br>
    Can you get me the output of &quot;sudo cat
    /sys/kernel/debug/dri/0/radeon_fence_info&quot; when the problem happens?<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 31.03.21 um 16:33 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com">
      
      <div dir="ltr">
        <div>- The computer still replies to <b>ping</b>.</div>
        <div>- The <b>journal</b> shows no errors, but a few <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F5a0bf22220398549%23D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1jQLb8pO7eJYTORNisjequdWSCoKPsrrv7y%2F4U%2BojLM%3D&amp;reserved=0" originalsrc="https://bin.privacytools.io/?5a0bf22220398549#D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy" shash="rY+G6ZubMvs/m9XCySS79aijEtVeBJooyAcN1rWIklpBGH+V3mfnMVAgBX9Y1EogHxDS0OMqzwZt26s/4BY0ZFTR5E9hg8886a9ShGKvkv7UG0ScbmbCGpVTOLLNnDtYzGpfdSqEotGnRkZR+ZHwLkQvg2gmatdKMLYy7OjoHd4=" moz-do-not-send="true">warnings</a>.</div>
        <div>- The <b>mouse</b> doesn't freeze.<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at 10:09,
          Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Can you access the system over the network and see if
            there is anything in the system log?<br>
            <br>
            It sounds like the display stack has crashed, but when the
            sound keeps playing the system is most likely still
            responsive over network.<br>
            <br>
            Thanks,<br>
            Christian.<br>
            <br>
            <div>Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>What happens is this simple: after a few minutes,
                  about 6 or so, the entire content of the screen stays
                  still. In some minor situations only the applications
                  panel of KDE Plasma.</div>
                <div><br>
                </div>
                <div>If music is playing it continues playing, so only
                  graphics are hung. Yet in most cases the power button
                  won't shut down the computer, as it usually does.<br>
                </div>
                <div><br>
                </div>
                <div>At least this is the case using kwin on x11, and
                  not on wayland. It only happens on &quot;radeon&quot; and not on
                  Intel or &quot;radeonhd&quot;.</div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at
                  09:48, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Correct, but a TV is intended for videos only.
                    That's why it implements only the lower HDMI
                    standard.<br>
                    <br>
                    Interlaced transmits only halve the lines with each
                    frame, so a 60Hz mode effectively either becomes a
                    30Hz mode, halving the vertical resolution or
                    adaptive motion compensated which the know visual
                    artifacts. Depending on what the deinterlacing
                    setting on your TV is.<br>
                    <br>
                    You could just add a progressive 1920x540@60 or
                    1920x1080@30 mode manually and would have the same
                    effect with probably better quality. See <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UTefQjeEYVrJto%2FqBlna%2FQKihbJe2HQG%2BczlZViFPDY%3D&amp;reserved=0" originalsrc="https://de.wikipedia.org/wiki/Deinterlacing" shash="XsjxJP6KTrU0bhN3YVZw0ojeokBRiGRSSDkXrWiQfzS/TAPQEu7gY38KPzYcdQ1LT80hBsvTba8n+nknalzPWryg/Zx6LSSpl/P4k9+Q3n4yk6Oft8jEvVmsYgSaDp3S3QZj3bDrOmBSv6Z/CxvEceBCwiA8lNUsiEuxVz+Flzo=" target="_blank" moz-do-not-send="true">https://de.wikipedia.org/wiki/Deinterlacing</a>
                    for reference.<br>
                    <br>
                    If you can give us some more information what is
                    happening when the system freeze we could try to
                    narrow this down, but we can't spend much time on a
                    very specific use case in a driver which is in
                    maintenance mode.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <div>Am 31.03.21 um 09:21 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>24fps is intended for video only. Anything
                          interactive at 24fps, as just moving the mouse
                          around, is extremely choppy.</div>
                        <div><br>
                        </div>
                        <div>No way anyone would prefer that over an
                          interlaced resolution or a lower resolution.
                          That is, by far, the worst option.</div>
                        <div><br>
                        </div>
                        <div>Just try it on your screen, set it to 24Hz
                          or alike, and tell me your experience. You
                          can't even tell where the mouse is going to
                          go.<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar
                          2021 at 08:44, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div> Hi Alberto,<br>
                            <br>
                            well a frame rate of 24Hz is perfectly
                            reasonable for a TV and desktop usage.<br>
                            <br>
                            This is probably caused by the TVs limited
                            HDMI bandwidth and a refresh rate of 30/25
                            Hz for the interlaced mode isn't much better
                            either.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            <div>Am 30.03.21 um 22:59 schrieb Alberto
                              Salvia Novella:<br>
                            </div>
                            <blockquote type="cite">
                              <div dir="ltr">
                                <div>The frame-rate at 24Hz is extremely
                                  poor for normal desktop usage.<br>
                                </div>
                                <div><br>
                                </div>
                                <div>If the highest resolution, aka
                                  1080p, uses that refresh rate then the
                                  desktop will default to that
                                  frame-rate.</div>
                                <div><br>
                                </div>
                                <div>Other progressive modes don't
                                  exhibit any issue.<br>
                                </div>
                              </div>
                              <br>
                              <div class="gmail_quote">
                                <div dir="ltr" class="gmail_attr">On
                                  Tue, 30 Mar 2021 at 18:26, Christian
                                  König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                  0.8ex;border-left:1px solid
                                  rgb(204,204,204);padding-left:1ex">
                                  <div> Hi Alberto,<br>
                                    <br>
                                    <blockquote type="cite">I think the
                                      driver should only support
                                      resolutions that are <b>progressive</b>,
                                      but also at least of <b>50Hz</b>.</blockquote>
                                    <br>
                                    Why do you think so?, the 24Hz
                                    resolution seems to be the native
                                    one of the display.<br>
                                    <br>
                                    Regards,<br>
                                    Christian.<br>
                                    <br>
                                    <div>Am 30.03.21 um 17:37 schrieb
                                      Alberto Salvia Novella:<br>
                                    </div>
                                    <blockquote type="cite">
                                      <div dir="ltr">
                                        <div>This is why I'm using
                                          interlaced:<br>
                                        </div>
                                        <div><br>
                                        </div>
                                        <div>$ <b>xrandr</b><br>
                                          Screen 0: minimum 320 x 200,
                                          current 1920 x 1080, maximum
                                          8192 x 8192<br>
                                          DisplayPort-0 disconnected
                                          (normal left inverted right x
                                          axis y axis)<br>
                                          HDMI-0 connected primary
                                          1920x1080+0+0 (normal left
                                          inverted right x axis y axis)
                                          16mm x 9mm<br>
                                          &nbsp; &nbsp;1920x<b>1080i</b> &nbsp;
                                          &nbsp;60.00*+ &nbsp;50.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                                          &nbsp; &nbsp;1920x1080 &nbsp; &nbsp; <b>24.00</b>
                                          &nbsp; &nbsp;23.98 &nbsp;<br>
                                          &nbsp; &nbsp;1280x<b>720</b> &nbsp; &nbsp; &nbsp;60.00
                                          &nbsp; &nbsp;50.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                                          &nbsp; &nbsp;1024x768 &nbsp; &nbsp; &nbsp;75.03 &nbsp;
                                          &nbsp;70.07 &nbsp; &nbsp;60.00 &nbsp;<br>
                                          &nbsp; &nbsp;832x624 &nbsp; &nbsp; &nbsp; 74.55 &nbsp;<br>
                                          &nbsp; &nbsp;800x600 &nbsp; &nbsp; &nbsp; 72.19 &nbsp;
                                          &nbsp;75.00 &nbsp; &nbsp;60.32 &nbsp; &nbsp;56.25 &nbsp;<br>
                                          &nbsp; &nbsp;720x576 &nbsp; &nbsp; &nbsp; 50.00 &nbsp;<br>
                                          &nbsp; &nbsp;720x576i &nbsp; &nbsp; &nbsp;50.00 &nbsp;<br>
                                          &nbsp; &nbsp;720x480 &nbsp; &nbsp; &nbsp; 60.00 &nbsp;
                                          &nbsp;59.94 &nbsp;<br>
                                          &nbsp; &nbsp;720x480i &nbsp; &nbsp; &nbsp;60.00 &nbsp;
                                          &nbsp;59.94 &nbsp;<br>
                                          &nbsp; &nbsp;640x480 &nbsp; &nbsp; &nbsp; 75.00 &nbsp;
                                          &nbsp;72.81 &nbsp; &nbsp;66.67 &nbsp; &nbsp;60.00 &nbsp;
                                          &nbsp;59.94 &nbsp;<br>
                                          &nbsp; &nbsp;720x400 &nbsp; &nbsp; &nbsp; 70.08 &nbsp;<br>
                                          DVI-0 disconnected (normal
                                          left inverted right x axis y
                                          axis)</div>
                                        <div><br>
                                        </div>
                                        <div>I think the driver should
                                          only support resolutions that
                                          are <b>progressive</b>, but
                                          also at least of <b>50Hz</b>.<br>
                                        </div>
                                      </div>
                                      <br>
                                      <div class="gmail_quote">
                                        <div dir="ltr" class="gmail_attr">On Tue, 30
                                          Mar 2021 at 15:41, Christian
                                          König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                                          wrote:<br>
                                        </div>
                                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                          0.8ex;border-left:1px solid
                                          rgb(204,204,204);padding-left:1ex">
                                          <div> Mhm, no idea why an
                                            interlaced resolution would
                                            cause a crash. Maybe some
                                            miscalculation in the
                                            display code.<br>
                                            <br>
                                            But apart from that if you
                                            just connected your PC to a
                                            TV I also wouldn't recommend
                                            using an interlaced
                                            resolution in the first
                                            place.<br>
                                            <br>
                                            See those resolutions only
                                            exists for backward
                                            compatibility with analog
                                            hardware.<br>
                                            <br>
                                            I think we would just
                                            disable those modes instead
                                            of searching for the bug.<br>
                                            <br>
                                            Regards,<br>
                                            Christian.<br>
                                            <br>
                                            <div>Am 30.03.21 um 11:07
                                              schrieb Alberto Salvia
                                              Novella:<br>
                                            </div>
                                            <blockquote type="cite">
                                              <div dir="ltr">
                                                <div>I guessed so.</div>
                                                <div><br>
                                                </div>
                                                <div>The GPU is a Radeon
                                                  HD5870, and the screen
                                                  is an old Telefunken
                                                  TV (TLFK22LEDPVR1).</div>
                                                <div><br>
                                                </div>
                                                <div>Since my real
                                                  display got into
                                                  repair I used this TV
                                                  meanwhile, and to my
                                                  surprise it froze the
                                                  system.<br>
                                                </div>
                                              </div>
                                              <br>
                                              <div class="gmail_quote">
                                                <div dir="ltr" class="gmail_attr">On
                                                  Tue, 30 Mar 2021 at
                                                  10:15, Christian König
                                                  &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                                  wrote:<br>
                                                </div>
                                                <blockquote class="gmail_quote" style="margin:0px 0px
                                                  0px
                                                  0.8ex;border-left:1px
                                                  solid
                                                  rgb(204,204,204);padding-left:1ex">Hi
                                                  Alberto,<br>
                                                  <br>
                                                  well what hardware do
                                                  you have?<br>
                                                  <br>
                                                  Interlaced resolutions
                                                  are not used any more
                                                  on modern hardware, so
                                                  they <br>
                                                  are not well tested.<br>
                                                  <br>
                                                  Regards,<br>
                                                  Christian.<br>
                                                  <br>
                                                  Am 30.03.21 um 10:04
                                                  schrieb Alberto Salvia
                                                  Novella:<br>
                                                  &gt; The entire
                                                  desktop hangs after
                                                  some minutes when
                                                  using the module <br>
                                                  &gt; &quot;radeon&quot; with an
                                                  interlaced resolution.<br>
                                                  &gt;<br>
                                                  &gt; Easier to trigger
                                                  by playing a video on
                                                  Firefox, at least on
                                                  kwin_x11. <br>
                                                  &gt; Wayland didn't
                                                  exhibit the problem.<br>
                                                  &gt;<br>
                                                  &gt; Other display
                                                  drivers, from
                                                  different computers I
                                                  have tried, didn't <br>
                                                  &gt; allow those
                                                  interlaced resolutions
                                                  all together. It seems
                                                  they know <br>
                                                  &gt; there will be
                                                  problems.<br>
                                                  <br>
                                                </blockquote>
                                              </div>
                                              <br>
                                              <fieldset></fieldset>
                                              <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411082891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5HXXJnOGGnEYSV%2BY%2FyWu031sE4CxFTKS2QqcKvlhhPs%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="u56q1lUI6O5q7apnXYhggsqUoU/FBRn6d287wNR5pLOMB7RuRwYGRso1pwzLpFPW2EFyb7gKoJhhykt6bbK90D5c1AyPusVg6S3ipyGapJtdycKufQjvHXziCGZpG8itRkccrFH5xirIfyalAsnIKDJEf7sgOIj4b16WZcidMsI=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
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
  </body>
</html>

--------------DFDA8552E9F9BFB4581021B6--

--===============0009527351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0009527351==--
