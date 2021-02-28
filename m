Return-Path: <SRS0=JjkA=H6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673B8C433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 00:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F301964D5D
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 00:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F301964D5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364AB6E197;
	Sun, 28 Feb 2021 00:55:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3914F6E195
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 00:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiBIJWckBf/gaVxyWQAmxzZPd9dTYzVQokHs5xG9z4UH1mbsvOJda+kCS9HACl3obVZyFWVo7YuLy2/GpPvU2Z/yJUnypDrj9VaynE3+za0FyMSW+YE9yQNWvwCpMOZFBp+Lw1J5WQ4pko53VYbXG+nRE4cZ9A/u4x9YUNkEx+Uvz1+gXc1BuG2/OGvwEOtsLlq+ygPK/G+uqaDEqwhBVbRkYiGGKEQ6JhP0QvTh3+F6635ZPy4IJLu24FuAbea5QTWSwNVxDlwWdognqXqYuxhvBh9wExtWxaar0YdUDO4TFY4CPJaYoemxv98gKnA3Ta0NXPQ/9US2/DoUI0JJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi7bAsX+KQ5D2UL2upsUcs7Unslg41QavbSCgrPBWY0=;
 b=C1xBeOrvm/VMKOMAcBCzKc6RLHwBPJP05HpQK36SAr0i99VMeaJnknJNFacQODXXiJSJoqbMmry/R4lvJHWWMqXGveQsv+lNELYPFxQQuMr70GrkMOs5HH4/8pcIZTf4pvSlHlmrooIOBrYlDcUgEB0+zWVEIaVW/ELkMrrc4AUzL+zwmBTSHjKeIRJizgfFc8yexzGnmoyp2u6qL7o1clUeEgyCYFHAzF3hyvp0jH6G6hMkt7T63EwXNQLyB07YqqcRjljlkdhPeR4VimoW+rvRM8TQ/f8KCYsCXFEyUEfGaP6g53BVVfEPAMTJ696idpOQCXdPlPQS2OYqLijtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi7bAsX+KQ5D2UL2upsUcs7Unslg41QavbSCgrPBWY0=;
 b=dIYggGWeH6MX2v7b+aaA+MlZbT/1dwAruxjwJMvLo8m26Dz5rIpf33ietWYSKYLsOPv616xhP7TaxvUKReqm0JZNnVxoKI5k6wcv5q2e5yQMkH9x4CgdbKvIbQ5LE2ZWGQDvfhLJ/MF00cccg6hyNCqDw0dVg3bTbSGClMNaOOo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2798.namprd12.prod.outlook.com (2603:10b6:805:69::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 28 Feb
 2021 00:55:23 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3890.020; Sun, 28 Feb 2021
 00:55:22 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JGQ10gYSBuZXcgYXBwcm9hY2ggdG8gZGV0ZWN0?=
 =?UTF-8?Q?_which_ring_is_the_real_black_sheep_upon_TDR_reported?=
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <eb07f03b-0ea4-f9a1-47bf-4e8b65ac7081@amd.com>
 <DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <d0fb9566-49c6-cfda-f38d-740bd032ca1d@amd.com>
Date: Sat, 27 Feb 2021 19:55:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:1f10:eb39:4a6b:30f8]
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:1f10:eb39:4a6b:30f8]
 (2607:fea8:3edf:49b0:1f10:eb39:4a6b:30f8) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23 via Frontend Transport; Sun, 28 Feb 2021 00:55:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0f19066-8538-48b2-ab7e-08d8db8386ce
X-MS-TrafficTypeDiagnostic: SN6PR12MB2798:
X-MS-Exchange-MinimumUrlDomainAge: lists.freedesktop.org#0
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2798B64E10BA464F5F4961E1EA9B9@SN6PR12MB2798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8oemPse6SoTGGaNWM6PXnn35i4ppWZiDKaX+2ophHvOH3SbXoT42fSJbvos+S2JmSZNvf2A7OSjO1ATiTUMM8w6uSDB0p/mQzAMMHgjNSzrZe4g4C/ZYUo9unJuBZk3UuSe+Ge0efAPL8hAUve0tnM39AL/kzX57mpE3an0SlMzcwI49d/8NqyfQ8i5t3d+1mfs0SUmjpINn0lxgZEgRxLbxUiqjEGAL71a8/W4ANpfmbH9WzBdeLJUN4g1XkflHfe9IFJ70UHqe7au+7P4YczbboW09zw3iQ6nA6D4pBaR7VqRSTiYvg0A3rZshQ/6HH7i+mxgCobePquu1PBa6W+RQAUa0YgcJNLLh2vTKIlnOhsR3GkXwP3hmhZxxDBhCg/sUCVRKpku/4gUBmYT1L3fLW7JTYea2YJoVk9AdVUDYsCQ+emXGvex2q700gxWOuED0/XojzbG7TWnNwmmEyK1LDIbzCIP1ZYUjUN2Xy1c4DgOB7O2lzXvRfBE+1m92W5bH3mDzNxk+ChRumogZ+Yuuanor7ToL9vlo3VXivn70XNBzm/SZinAlQ5d0I0z8wNZjzxuCIB2rK/SCZJcx9n0oY37ommzx8HcA3nDLV/fbiCqu0zYDGHBFII+2yGeFLlu8jGZfynT4qMGyslxDH0msZU1QxvtbgKo7CGUvJYTAS1i2j/y6/Wrm7XESFuy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(2906002)(44832011)(478600001)(110136005)(31696002)(4326008)(83380400001)(166002)(966005)(54906003)(6666004)(5660300002)(66946007)(66556008)(33964004)(53546011)(52116002)(66476007)(2616005)(186003)(8936002)(16526019)(316002)(6486002)(31686004)(86362001)(224303003)(30864003)(36756003)(43740500002)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXh6Z3BNL01HSkkwTnUyLzBqTnRzUzg2blJzUWhKb1JiUlBpZTRObU5FbmVY?=
 =?utf-8?B?d1ozTUdwMmhMRW1JS3R6a2FNZU0zOFE1cDVNSS9FWTJKdTY5NU1tejM1ZWFy?=
 =?utf-8?B?QlpXYUI3MGg3NFRDazJ1WDc3b3RGSHdWaFlxekU5Z2hMdGhXNlh0L0NGbkxw?=
 =?utf-8?B?MGFJMkw1d0tSRi9WZHdNbmxxVE1obzlQMlA1Y2E2b25wWkR2dS9FR1JvWUJO?=
 =?utf-8?B?K2JFbXMyd09EMURXRFNaZTd1RXJudW1vWHVIQzRkNXJhWml6b2E4R3FhSzFS?=
 =?utf-8?B?eGVhSkRlS2FJdWNyMHhRN3kwRXVIV00rZ3hzbWttOUlJRmZnSURuR3JFSU1B?=
 =?utf-8?B?UjA3aGRSRjM3K2xtbDNLUGl3c3JZQXMvcGxjN2ZkWGZCZHN3UStQWW5KUHRp?=
 =?utf-8?B?NkRnbjFKTXRiVTVrWWZ4VWFMRjZYZE9JbmRlaVh3OVhWZWZoa1pRNjBVenU1?=
 =?utf-8?B?VmNZZDBEZEczZ2tmVTliKzVrVFhHNDk1Y3o2aW9mNUdzMnV4aXEzSHU3NHRl?=
 =?utf-8?B?WXRNN08zOTJuWmhUdE40TGhYT3JGejNNb21SRHkzWkg5NDRlbHUzK1JlNnF3?=
 =?utf-8?B?V243dXlwcWFLdmZyYnlOV3dKQWVLRkR3aVBELzhmVFVvRmtObGdEdXFFbXk0?=
 =?utf-8?B?VGtWaUVsaXYwRGdmM2hVdmExaDhvcVJUVjBpOGxUMXc3WmltelpFRTBlb3dk?=
 =?utf-8?B?N2RwWExkdXY3Ti9LUGJpeVFrWVR2QVY4WitsK2NUdjcwSFA4UEhKT1NEb0lr?=
 =?utf-8?B?ZXZKK2l2NWM1dUNNUWFveXhGNEszWmhubGtrTFgrOGdNU044UnIxRXVib0dn?=
 =?utf-8?B?cm5sUERZUFZpdHhlTjlMYUwxZmxBa1dmSnRqQS9SeHFnQ0hmUXRWQ1E5ZzY1?=
 =?utf-8?B?OTdvSGk1LzAyVkY2T2pURTBiT2ZRanhBcXFwRk1zd29VY0s0ZXlTT3ArbUJY?=
 =?utf-8?B?Y1BLM2JmWTJYM1pvYno4ZWF0ZSthbGpZeXRDQUErRWZBRHlpN2Fwa3R3bTBZ?=
 =?utf-8?B?U1QzeGc0VzV3Zi9JTjk4dHBwWXp2ejhlaTcxRC9leG9BK2Y2TVg3TWdrZDFK?=
 =?utf-8?B?cFhTYUlvRFBvYS9FaXRDazBFV3JRczFJb3RwZ01iY3BKcjBMYUIzL2dRcXVa?=
 =?utf-8?B?dXBMZFhTUmN1T1dGOEFQRitYem0zVnZ2SUwvOXRsV2NpYW9CejhLdXNPaC8v?=
 =?utf-8?B?V0dQTHgyZUhPQjdZVnloZ21WUythei9sWG15cExFMG5MUlJwSlFqTGpnZGdX?=
 =?utf-8?B?aDBhRkhlbmU2dm1zamw5VFQrWGI5akhEK1BVZDhRb3R1NEpqZHNhWUFPaTlI?=
 =?utf-8?B?dFVTa1JSZThpSU5Zd0tVRGxXK3hvNldYTVlnVzB4b2h5Ujk4bm1aMW5Zb3Jo?=
 =?utf-8?B?cUlVTGxLZXhaM09rVDRBU0tkcVJJTW1Ea1NGVkdkd05uYTlTRWNpYjRaRy9i?=
 =?utf-8?B?U1hwNUI4ZFJROTAzcDFnVW84N3M2QmNlS3BMelY5L1UyS2NhWjdGdHBaS3l0?=
 =?utf-8?B?cDZCc3Y2TGpQcUo5VTNtTks0by85bmxIRTYxYndXalBnMnBZa3NLUnE5bUJh?=
 =?utf-8?B?VG9rSCtUb1h5d3JUSXBtOGMraUt2Rm1Ud2FXbUM4aEl5U0ZNNlZIeVBjMWkr?=
 =?utf-8?B?K1ZrQzdJeks5STNUbEUvZWZ2NU1KQ0VpVnBDREVSMkVCQ3ZiNzB3MnhPejQ3?=
 =?utf-8?B?UDUwbUw0aVJmN0ZYZ1FvMHlzNi93L3VwaW16TE5ZTVBDU2FsRzB3dTJFZDBO?=
 =?utf-8?B?S2ZKT0F4WEdxVTN6YUEzWk5Hc1NtN1ZXODA3aGJoZXRlanBFVUVDaVN5TEVI?=
 =?utf-8?B?em1BbnI1Q0FJRjdVU2ZCV1U3TTM0c2VsUkx5U1U2TjlnWFZwdDlMajhqa0ZO?=
 =?utf-8?Q?pO8w1Nv7H8fUd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f19066-8538-48b2-ab7e-08d8db8386ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2021 00:55:22.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUNQJOBgeEv3Ug7s0L7BeVUcHRh6K7sCQ+qmiXfqWcvGUcmGKRjyOFuKi1IdYACVwAZcxxABbI8ZDprs00VX7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1331605844=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1331605844==
Content-Type: multipart/alternative;
 boundary="------------7DD5C085E67C287144C0BF2A"
Content-Language: en-US

--------------7DD5C085E67C287144C0BF2A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-02-26 10:56 p.m., Liu, Monk wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> H Andrey
>
> The scenario I hit here is not the one you mentioned, let me explain 
> it with more details by another much easier understood example:
>
> Consider ring you have a job1 on KCQ, but the timeout of KCQ is 60 
> seconds (just for example)
>
> You also have a job2 on GFX ring, and the timeout of GFX is 2 seconds
>
> We submit job1 first, and assume job1 have bug and it will cause 
> shader hang very very soon
>
> After 10 seconds we submit job2, since KCQ have 60 seconds to report 
> TDR thus SW know nothing about the engine already hang
>

So gfx job hangs because it has a dependency on buggy compute job which 
already is hanging ?


> After 2 seconds we got TDR report from job2 on GFX ring, 
> sched_job_timeout() think the leading job of GFX ring is the black 
> sheep so it is deleted from the mirror list
>
> But in fact this job1 is innocent, and we should insert it back after 
> recovery , and due to it was already deleted this innocent job’s 
> context/process is really harmed
>

I am still missing something - we don't ever delete bad jobs or any jobs 
until they are signaled, we reinsert the bad  job back into mirror list 
in drm_sched_stop
(here - 
https://elixir.bootlin.com/linux/v5.11.1/source/drivers/gpu/drm/scheduler/sched_main.c#L385) 
after sched thread is stopped and continue with the reset procedure.

Andrey


> Hope above example helps
>
> Thanks
>
> *发件人:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *发送时间:*2021年2月27日0:50
> *收件人:*Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> *抄送:*Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace 
> <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *主题:*Re: [RFC] a new approach to detect which ring is the real black 
> sheep upon TDR reported
>
> On 2021-02-26 6:54 a.m., Liu, Monk wrote:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     See in line
>
>     Thanks
>
>     ------------------------------------------
>
>     Monk Liu | Cloud-GPU Core team
>
>     ------------------------------------------
>
>     *From:*Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>
>     *Sent:* Friday, February 26, 2021 3:58 PM
>     *To:* Liu, Monk <Monk.Liu@amd.com> <mailto:Monk.Liu@amd.com>;
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     *Cc:* Zhang, Andy <Andy.Zhang@amd.com>
>     <mailto:Andy.Zhang@amd.com>; Chen, Horace <Horace.Chen@amd.com>
>     <mailto:Horace.Chen@amd.com>; Zhang, Jack (Jian)
>     <Jack.Zhang1@amd.com> <mailto:Jack.Zhang1@amd.com>
>     *Subject:* Re: [RFC] a new approach to detect which ring is the
>     real black sheep upon TDR reported
>
>     Hi Monk,
>
>     in general an interesting idea, but I see two major problems with
>     that:
>
>     1. It would make the reset take much longer.
>
>     2. Things get often stuck because of timing issues, so a guilty
>     job might pass perfectly when run a second time.
>
>     [ML] but the innocent ring already reported a TDR, and the drm
>     sched logic already deleted this “sched_job” in its mirror list,
>     thus you don’t have chance to re-submit it again after reset,
>     that’s the major problem here.
>
> Just to confirm I understand correctly, Monk reports a scenario where 
> the second TDR that was reported by the innocent job is bailing out 
> BEFORE having a chance to run  drm_sched_stop for that scheduler which 
> should have reinserted the job back into mirror list (because the 
> first TDR run is still in progress and hence amdgpu_device_lock_adev 
> fails for the second TDR) and so the innocent job which was extracted 
> from mirror list in drm_sched_job_timedout is now lost.
> If so and as a possible quick fix until we overhaul the entire design 
> as suggested in this thread - maybe we can modify 
> drm_sched_backend_ops.timedout_job callback to report back premature 
> termination BEFORE drm_sched_stop had a chance to run and then 
> reinsert back the job into mirror list from within  
> drm_sched_job_timedout? There is no problem of racing against 
> concurrent drm_sched_get_cleanup_job once we reinsert there as we 
> don't reference the job pointer anymore after this point and so if 
> it's already signaled and freed right away - it's ok.
>
> Andrey
>
>
>     Apart from that the whole ring mirror list turned out to be a
>     really bad idea. E.g. we still struggle with object life time
>     because the concept doesn't fit into the object model of the GPU
>     scheduler under Linux.
>
>     We should probably work on this separately and straighten up the
>     job destruction once more and keep the recovery information in the
>     fence instead.
>
>     [ML] we claim to our customer that no innocent process will be
>     dropped or cancelled, and our current logic works for the most
>     time, but only when there are different process running on
>     gfx/computes rings then we would run into the tricky situation I
>     stated here, and the proposal is the only way I can figure out so
>     far, do you have a better solution or idea we review it as another
>     candidate RFC ? Be note that we raised this proposal is because we
>     do hit our trouble and we do need to resolve it …. So even a not
>     perfect solution is still better than just cancel the innocent job
>     (and their context/process)
>
>     Thanks !
>
>
>     Regards,
>     Christian.
>
>     Am 26.02.21 um 06:58 schrieb Liu, Monk:
>
>         [AMD Public Use]
>
>         Hi all
>
>         NAVI2X  project hit a really hard to solve issue now, and it
>         is turned out to be a general headache of our TDR mechanism ,
>         check below scenario:
>
>          1. There is a job1 running on compute1 ring at timestamp
>          2. There is a job2 running on gfx ring at timestamp
>          3. Job1 is the guilty one, and job1/job2 were scheduled to
>             their rings at almost the same timestamp
>          4. After 2 seconds we receive two TDR reporting from both GFX
>             ring and compute ring
>          5. *Current scheme is that in drm scheduler all the head jobs
>             of those two rings are considered “bad job” and taken away
>             from the mirror list *
>          6. The result is both the real guilty job (job1) and the
>             innocent job (job2) were all deleted from mirror list, and
>             their corresponding contexts were also treated as
>             guilty*(so the innocent process remains running is not
>             secured)*
>
>         **
>
>         But by our wish the ideal case is TDR mechanism can detect
>         which ring is the guilty ring and the innocent ring can
>         resubmits all its pending jobs:
>
>          1. Job1 to be deleted from compute1 ring’s mirror list
>          2. Job2 is kept and resubmitted later and its belonging
>             process/context are even not aware of this TDR at all
>
>         Here I have a proposal tend to achieve above goal and it rough
>         procedure is :
>
>          1. Once any ring reports a TDR, the head job is **not**
>             treated as “bad job”, and it is **not** deleted from the
>             mirror list in drm sched functions
>          2. In vendor’s function (our amdgpu driver here):
>
>               * reset GPU
>               * repeat below actions on each RINGS * one by one *:
>
>         1.take the head job and submit it on this ring
>
>         2.see if it completes, if not then this job is the real “bad job”
>
>         3. take it away from mirror list if this head job is “bad job”
>
>               * After above iteration on all RINGS, we already clears
>                 all the bad job(s)
>
>          3. Resubmit all jobs from each mirror list to their
>             corresponding rings (this is the existed logic)
>
>         The idea of this is to use “serial” way to re-run and re-check
>         each head job of each RING, in order to take out the real
>         black sheep and its guilty context.
>
>         P.S.: we can use this approaches only on GFX/KCQ ring reports
>         TDR , since those rings are intermutually affected to each
>         other. For SDMA ring timeout it definitely proves the head job
>         on SDMA ring is really guilty.
>
>         Thanks
>
>         ------------------------------------------
>
>         Monk Liu | Cloud-GPU Core team
>
>         ------------------------------------------
>
>
>
>     _______________________________________________
>
>     amd-gfx mailing list
>
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------7DD5C085E67C287144C0BF2A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-02-26 10:56 p.m., Liu, Monk
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML \9884\8BBE\683C\5F0F \5B57\7B26";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.HTML
	{mso-style-name:"HTML \9884\8BBE\683C\5F0F \5B57\7B26";
	mso-style-priority:99;
	mso-style-link:"HTML \9884\8BBE\683C\5F0F";
	font-family:"Courier New";}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">H
              Andrey<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">The
              scenario I hit here is not the one you mentioned, let me
              explain it with more details by another much easier
              understood example:<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">Consider
              ring you have a job1 on KCQ, but the timeout of KCQ is 60
              seconds (just for example)<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">You
              also have a job2 on GFX ring, and the timeout of GFX is 2
              seconds<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">We
              submit job1 first, and assume job1 have bug and it will
              cause shader hang very very soon
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">After
              10 seconds we submit job2, since KCQ have 60 seconds to
              report TDR thus SW know nothing about the engine already
              hang</span></p>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>So gfx job hangs because it has a dependency on buggy compute job
      which already is hanging ?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">After
              2 seconds we got TDR report from job2 on GFX ring,
              sched_job_timeout() think the leading job of GFX ring is
              the black sheep so it is deleted from the mirror list<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">But
              in fact this job1 is innocent, and we should insert it
              back after recovery , and due to it was already deleted
              this innocent job’s context/process is really harmed</span></p>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I am still missing something - we don't ever delete bad jobs or
      any jobs until they are signaled, we reinsert the bad&nbsp; job back
      into mirror list in drm_sched_stop <br>
      (here -
<a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v5.11.1/source/drivers/gpu/drm/scheduler/sched_main.c#L385">https://elixir.bootlin.com/linux/v5.11.1/source/drivers/gpu/drm/scheduler/sched_main.c#L385</a>)
      after sched thread is stopped and continue with the reset
      procedure.</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">Hope
              above example helps<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US">Thanks
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:DengXian" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0cm 0cm 0cm">
              <p class="MsoNormal"><b><span style="font-family:DengXian">发件人<span lang="EN-US">:</span></span></b><span style="font-family:DengXian" lang="EN-US"> Grodzovsky,
                  Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                  <br>
                </span><b><span style="font-family:DengXian">发送时间<span lang="EN-US">:</span></span></b><span style="font-family:DengXian" lang="EN-US"> 2021</span><span style="font-family:DengXian">年<span lang="EN-US">2</span>月<span lang="EN-US">27</span>日<span lang="EN-US"> 0:50<br>
                  </span><b>收件人<span lang="EN-US">:</span></b><span lang="EN-US"> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>;
                    Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  </span><b>抄送<span lang="EN-US">:</span></b><span lang="EN-US"> Zhang, Andy
                    <a class="moz-txt-link-rfc2396E" href="mailto:Andy.Zhang@amd.com">&lt;Andy.Zhang@amd.com&gt;</a>; Chen, Horace
                    <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Zhang, Jack (Jian)
                    <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                  </span><b>主题<span lang="EN-US">:</span></b><span lang="EN-US"> Re: [RFC] a new approach to detect
                    which ring is the real black sheep upon TDR reported<o:p></o:p></span></span></p>
            </div>
          </div>
          <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <div>
            <p class="MsoNormal"><span lang="EN-US">On 2021-02-26 6:54
                a.m., Liu, Monk wrote:<o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheadera92f4c5c" style="margin:0cm"><span style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7" lang="EN-US">[AMD Official Use Only - Internal
                Distribution Only]</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">See in line<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
            <div>
              <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                  Cloud-GPU Core team<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
            </div>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0cm 0cm 0cm">
                <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span lang="EN-US"> Koenig, Christian
                    <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
                    <b>To:</b> Liu, Monk <a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">&lt;Monk.Liu@amd.com&gt;</a>;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Zhang, Andy <a href="mailto:Andy.Zhang@amd.com" moz-do-not-send="true">&lt;Andy.Zhang@amd.com&gt;</a>;
                    Chen, Horace
                    <a href="mailto:Horace.Chen@amd.com" moz-do-not-send="true">&lt;Horace.Chen@amd.com&gt;</a>;
                    Zhang, Jack (Jian)
                    <a href="mailto:Jack.Zhang1@amd.com" moz-do-not-send="true">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [RFC] a new approach to detect
                    which ring is the real black sheep upon TDR reported<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">Hi Monk,<br>
                <br>
                in general an interesting idea, but I see two major
                problems with that:<br>
                <br>
                1. It would make the reset take much longer.<br>
                <br>
                2. Things get often stuck because of timing issues, so a
                guilty job might pass perfectly when run a second time.<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">[ML] but the innocent ring already reported
                a TDR, and the drm sched logic already deleted this
                “sched_job” in its mirror list, thus you don’t have
                chance to re-submit it again after reset, that’s the
                major problem here.<o:p></o:p></span></p>
          </blockquote>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p><span lang="EN-US">Just to confirm I understand correctly,
              Monk reports a scenario where the second TDR that was
              reported by the innocent job is bailing out BEFORE having
              a chance to run&nbsp; drm_sched_stop for that scheduler which
              should have reinserted the job back into mirror list
              (because the first TDR run is still in progress and hence
              amdgpu_device_lock_adev fails for the second TDR) and so
              the innocent job which was extracted from mirror list in
              drm_sched_job_timedout is now lost.<br>
              If so and as a possible quick fix until we overhaul the
              entire design as suggested in this thread - maybe we can
              modify drm_sched_backend_ops.timedout_job callback to
              report back premature termination BEFORE drm_sched_stop
              had a chance to run and then reinsert back the job into
              mirror list from within&nbsp; drm_sched_job_timedout? There is
              no problem of racing against concurrent
              drm_sched_get_cleanup_job once we reinsert there as we
              don't reference the job pointer anymore after this point
              and so if it's already signaled and freed right away -
              it's ok. <o:p></o:p></span></p>
          <p><span lang="EN-US">Andrey<o:p></o:p></span></p>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US"><br>
                Apart from that the whole ring mirror list turned out to
                be a really bad idea. E.g. we still struggle with object
                life time because the concept doesn't fit into the
                object model of the GPU scheduler under Linux.<br>
                <br>
                We should probably work on this separately and
                straighten up the job destruction once more and keep the
                recovery information in the fence instead.<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">[ML] we claim to our customer that no
                innocent process will be dropped or cancelled, and our
                current logic works for the most time, but only when
                there are different process running on gfx/computes
                rings then we would run into the tricky situation I
                stated here, and the proposal is the only way I can
                figure out so far, do you have a better solution or idea
                we review it as another candidate RFC ? Be note that we
                raised this proposal is because we do hit our trouble
                and we do need to resolve it …. So even a not perfect
                solution is still better than just cancel the innocent
                job (and their context/process)<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">Thanks ! <o:p>
                </o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US"><br>
                Regards,<br>
                Christian.<o:p></o:p></span></p>
            <div>
              <p class="MsoNormal"><span lang="EN-US">Am 26.02.21 um
                  06:58 schrieb Liu, Monk:<o:p></o:p></span></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="msipheader251902e5" style="margin:0cm"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100" lang="EN-US">[AMD Public Use]</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Hi all<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">NAVI2X &nbsp;project
                  hit a really hard to solve issue now, and it is turned
                  out to be a general headache of our TDR mechanism ,
                  check below scenario:<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="1">
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">There is a job1 running on compute1
                    ring at timestamp
                    <o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">There is a job2 running on gfx ring at
                    timestamp<o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">Job1 is the guilty one, and job1/job2
                    were scheduled to their rings at almost the same
                    timestamp
                    <o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">After 2 seconds we receive two TDR
                    reporting from both GFX ring and compute ring<o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><b><span lang="EN-US">Current scheme is that in drm
                      scheduler all the head jobs of those two rings are
                      considered “bad job” and taken away from the
                      mirror list
                    </span></b><span lang="EN-US"><o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">The result is both the real guilty job
                    (job1) and the innocent job (job2) were all deleted
                    from mirror list, and their corresponding contexts
                    were also treated as guilty<b> (so the innocent
                      process remains running is not secured)</b><o:p></o:p></span></li>
              </ol>
              <p class="MsoListParagraph"><b><span lang="EN-US">&nbsp;</span></b><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">But by our wish
                  the ideal case is TDR mechanism can detect which ring
                  is the guilty ring and the innocent ring can resubmits
                  all its pending jobs:<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="1">
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l2 level1 lfo2"><span lang="EN-US">Job1 to be deleted from compute1 ring’s
                    mirror list<o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l2 level1 lfo2"><span lang="EN-US">Job2 is kept and resubmitted later and
                    its belonging process/context are even not aware of
                    this TDR at all
                    <o:p></o:p></span></li>
              </ol>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Here I have a
                  proposal tend to achieve above goal and it rough
                  procedure is :<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="1">
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level1 lfo3"><span lang="EN-US">Once any ring reports a TDR, the head
                    job is *<b>not</b>* treated as “bad job”, and it is
                    *<b>not</b>* deleted from the mirror list in drm
                    sched functions<o:p></o:p></span></li>
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level1 lfo3"><span lang="EN-US">In vendor’s function (our amdgpu driver
                    here):<o:p></o:p></span></li>
              </ol>
              <ol style="margin-top:0cm" type="1" start="2">
                <ul style="margin-top:0cm" type="disc">
                  <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level2 lfo3"><span lang="EN-US">reset GPU<o:p></o:p></span></li>
                  <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level2 lfo3"><span lang="EN-US">repeat below actions on each RINGS *
                      one by one *:<o:p></o:p></span></li>
                </ul>
              </ol>
              <p class="MsoListParagraph" style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                level3 lfo3">
                <!--[if !supportLists]--><span lang="EN-US"><span style="mso-list:Ignore">1.<span style="font:7.0pt
                      &quot;Times New Roman&quot;">
                    </span></span></span><!--[endif]--><span lang="EN-US">take the head job and submit it on this
                  ring<o:p></o:p></span></p>
              <p class="MsoListParagraph" style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                level3 lfo3">
                <!--[if !supportLists]--><span lang="EN-US"><span style="mso-list:Ignore">2.<span style="font:7.0pt
                      &quot;Times New Roman&quot;">
                    </span></span></span><!--[endif]--><span lang="EN-US">see if it completes, if not then this job
                  is the real “bad job”<o:p></o:p></span></p>
              <p class="MsoListParagraph" style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                level3 lfo3">
                <!--[if !supportLists]--><span lang="EN-US"><span style="mso-list:Ignore">3.<span style="font:7.0pt
                      &quot;Times New Roman&quot;">
                    </span></span></span><!--[endif]--><span lang="EN-US">&nbsp;take it away from mirror list if this
                  head job is “bad job”<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="2">
                <ul style="margin-top:0cm" type="disc">
                  <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level2 lfo3"><span lang="EN-US">After above iteration on all RINGS,
                      we already clears all the bad job(s)<o:p></o:p></span></li>
                </ul>
              </ol>
              <ol style="margin-top:0cm" type="1" start="3">
                <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level1 lfo3"><span lang="EN-US">Resubmit all jobs from each mirror list
                    to their corresponding rings (this is the existed
                    logic)<o:p></o:p></span></li>
              </ol>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">The idea of this
                  is to use “serial” way to re-run and re-check each
                  head job of each RING, in order to take out the real
                  black sheep and its guilty context.<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">P.S.: we can use
                  this approaches only on GFX/KCQ ring reports TDR ,
                  since those rings are intermutually affected to each
                  other. For SDMA ring timeout it definitely proves the
                  head job on SDMA ring is really guilty.<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                  Cloud-GPU Core team<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
            </blockquote>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"><br>
                <br>
                <o:p></o:p></span></p>
            <pre><span lang="EN-US">_______________________________________________<o:p></o:p></span></pre>
            <pre><span lang="EN-US">amd-gfx mailing list<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><o:p></o:p></span></pre>
            <pre><span lang="EN-US"><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------7DD5C085E67C287144C0BF2A--

--===============1331605844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1331605844==--
