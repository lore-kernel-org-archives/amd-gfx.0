Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034E7C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A256D64FB3
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A256D64FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254C36F3AD;
	Fri,  5 Feb 2021 02:27:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6307B6F3AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 02:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkwHRfY2Hjvy9En5i8iOaAj1E4OQ3Ra2hFn5iwZFQEm43K5jNBaXFLxwbEPLZrkl7xoq7KZ+RJoboHgFNAkMuLkxcCf3rcxfgArBcpVh2z/OnbuKp6SxBa8MD3QLXxeZZ5S4dSUBv+e+tjICLTuZk3R9PRO0qYmiqEssxFeTl38wwYRBlfjHlyU0+JVkHgQ3Nmnjxc5i2Co/vGUrUy4dqLvaLPc3EOuYjG00OyDE/Cf5jB4nfzf4IuxsMeaA1sB+SbZJrvYQ9c1tmNSsixtHbRe0mbCK34zrsK3uWsPw6sb/lqVJiAruQEBTCu+AQDzfTK6tA6Svdhgz59Ni4XsKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEos7q9u4NJ/Blgk09KolTXnZlLjzZXc+/ajIVkdyJ8=;
 b=VFKfaBIFRCol/CpsewrEsWyANUEE6RkND+fkCzrdgkZAZJzkNiV65s7syLWo5fTiRVGb7Zsp/Q8h1/HQ1eemLAhf9jMz7jbChy2YgVRX6Xxq91nyvUPWcWKLCgODusx5CCJ2qw4N12e5i68nl7jAnXzlxIL3un0xZvvN+G/nvVO4xskPkUV96c4+BQnHfdds4peVkirFj8O7yFCxTR81NB2X8ueNQnIGSvkp9eDVE0r42GUV76jpc/whFUtqLwfevKbOhwEZqbBJko7l19axNJ+rlls+xHju9Ao6Ig07NO2pzcAtqm6fynEWYh8zE+NqMHDi66useRrv2WXKtX+YZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEos7q9u4NJ/Blgk09KolTXnZlLjzZXc+/ajIVkdyJ8=;
 b=5X6mrg6KUxf5g3v8idX1P8Tr0zQzFupHlh/SJvyswDiPCXAmZsm1i2Kf2/DxYvGi0XvHKnoYH4inMH/rJ/RNDBDKgPYlIh7Ht8flVLrqgzf49Fp9OBhBQUBmrVGftxTUX5eSvbxQEWOAcxn5YlGWFVgJrCMSyHEX+1tVRZcAk+Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3965.namprd12.prod.outlook.com (2603:10b6:208:168::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Fri, 5 Feb
 2021 02:27:16 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Fri, 5 Feb 2021
 02:27:15 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend (v2)
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210204200450.1900-1-alexander.deucher@amd.com>
 <MN2PR12MB4549BB8EC131A991E38ABF6897B29@MN2PR12MB4549.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d05854d6-ad34-5328-ee01-87c47ef538ca@amd.com>
Date: Thu, 4 Feb 2021 21:27:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB4549BB8EC131A991E38ABF6897B29@MN2PR12MB4549.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 02:27:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8422d7ad-5585-498b-46f5-08d8c97d8d6f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3965:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3965A9ABAF38C6DA4E1F9A7892B29@MN2PR12MB3965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwvnQZjSdEx4RtQKDnEWwzL6HbjYoVWPC0oxpInflEFAT88nW8edQIQqhCdTInLIfxv9NWhzgJ+RPVqbSbQYLMJkjukZs9Ov024IDwsuitD871WP470Ao9zJXtT8iQIVXongMxz/FVHXD6UrnFWr2wkQuoLZN61/donCjftXHs75nBC5a1d55f1xFU9oQ7hVEQwOJZQF1YBGYAi36XBHDK5ZVt0cuMwEO7nOwzMYFAMhiIFuKIgKODEop9tFEeNM72fnNEnghLsLMJNeSwIvP3kP9AcR85yd8ybOKSa+MXf0eofxL9MmmGSyjulim0FN1Y1pe9A8qbeFvGIRi+5Zbp8iN1/TYIYeOVRnmqZ2I7GtJPxSkw4/txurfPTny2sizvsHl1t3nvL+kyazC+l7bx6EcMP56sAHE73TMEIvEZ8cjNTmEbfXJsjs9/7UaxL8f3yhqslATXLcih8kMTOA+keqi9iAOdVRo8y6kzaqlR7NUBn6GuJ+4PEvLgsdZ96mcXgylfNWVZxT4ceF1EcrSOI0PKrRgRNYIFK8MKxGuk9L89ZP7qUU/rcPqvYJuafM0rflfOTBKwtTLLsSBR2btxLmofEU43kJljStYSNxQLUWPKq7mL7h3XKlbLog+pdVZ8hzhqlndYw6VFmNgOnatQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(66556008)(83380400001)(956004)(478600001)(6486002)(966005)(66476007)(5660300002)(66946007)(36756003)(8936002)(8676002)(31696002)(86362001)(15650500001)(110136005)(2906002)(2616005)(52116002)(31686004)(186003)(44832011)(16526019)(316002)(26005)(16576012)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?eQ+OF2p3Bg1VSXiRD98N54DXW/MxvpMebqSzL9Fi7N8fkU7xTsbK1YIj?=
 =?Windows-1252?Q?QjvV9+80l7v/gM4QAw5Joe81Wcj5H2bI9lAvdZlxdkPTc7oiVG+o0mxg?=
 =?Windows-1252?Q?Pv4xffWVGmSFRX4EF8GkG+WlpPVCNFlNDN4ZD7FTHV21S9FZLpumBOIu?=
 =?Windows-1252?Q?7N7X8Y39JWyEV7Ya8guLsvz7tjpWOXIeCREpYt5BY4585/+xCMEW7y4o?=
 =?Windows-1252?Q?xBwHfV9RvHDsdejSlWFkyNhy9QCSiXXpvMWviZhXWnJfUlvgMtu2TmtH?=
 =?Windows-1252?Q?lFYq9WU92do1456F7L2Gu6t140n0K5EzN8CQeSdJHG2O82gqSQZpxiNm?=
 =?Windows-1252?Q?X3zFm87I3KqdfskvHNftlVVWZ1VpDgbD5mytlRvuJaLFHiufWIzx5iTV?=
 =?Windows-1252?Q?74763znn3YrUuuZ4dTkYruA16gWw0hZabJ2WWTxf8ziwgR+aUfhihV8H?=
 =?Windows-1252?Q?VNbc8MDRKw79ihN7DvV1pziTUjF/kmIw9qm/5uRo+N8uSgnMnppjdD+b?=
 =?Windows-1252?Q?EeYfZb3SUIf955lLXmSO/2fTSphJ9oEmbiTzIpeUXFRSpzQg4M5y41qw?=
 =?Windows-1252?Q?4taQk2R4dE5zM1LFcGyKG4DQvV2KwBK36svr8svkLUJnI2JfEsvF/hom?=
 =?Windows-1252?Q?mTPKKvVvT7Au0C8tEVy2QXrmbe1lXa6L/y3x9vSA91Lk+9DX5rgtVDk2?=
 =?Windows-1252?Q?ibPJRppEhsWbxavJaz7NX7mg2T72xzerA8eA8aPMj2E2/uqL6h55qMhk?=
 =?Windows-1252?Q?jc3CsHmbosebRVEhSbiZFPafd7FiSUVsVM/KfjeQbBmqN4IamZQdWVay?=
 =?Windows-1252?Q?o6H0Oin7k0g9gMxG5B+g+NMimI0Bxhrhxl7/1jRVnA2I6r0U0vGwMF0a?=
 =?Windows-1252?Q?ZexaoLKDEJX90wZ2vKkF667Tp9xUIflpLC/xaWLco3+9qsG46nThFD7x?=
 =?Windows-1252?Q?Q1xFWt57jSt6TrDt7egRhy2tizyar1bSbCt15OZqxOHuvBGDm4FXgcSB?=
 =?Windows-1252?Q?3tfuz0AUA3+b+rsHxeGKBQXYFSLogeC6DBNdPBuuolUiL5Qe0DzNCphm?=
 =?Windows-1252?Q?DR/aE3vR0Q04BuHkw7yG/yFtVdFWhLzVb/L6FFlS5isRm4Nb9tQ0794V?=
 =?Windows-1252?Q?NvLi9yDzpR7PCPG5sBKa6xZaT6ex11EYiX0RZ4lGVmaR8wbVaQOa8ks9?=
 =?Windows-1252?Q?StAm71EriRuw6811pIlYijyq3Gnkf5Er/ceHAqFvrWL73DNUXr4wOLbs?=
 =?Windows-1252?Q?X+VL1RB8v+TxLeMMzL/CRGRMtSB3Yv4IoCMjNdaGQN0yCrl7oLf43tnK?=
 =?Windows-1252?Q?MxIkAj53KUcUrG3LrdHazKn93xCH8+ymcfHnVgnMCw20EqvBorwwij0s?=
 =?Windows-1252?Q?VYjvHjllcYP/y/6sdfG7xnug+mX97qMYs7DSOvAHcgrImU9z+LEbzaqh?=
 =?Windows-1252?Q?KZVB/2eQrV1qG5M+wzjKtA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8422d7ad-5585-498b-46f5-08d8c97d8d6f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 02:27:15.7106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csN10ei6VQsnDjM/rrZFpxlWCIOvWl/F748PI8jXxwy63mAwearMREAsFedxU4CYFrvVyB5eM/xHkoD0zapyVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3965
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-02-04 um 9:20 p.m. schrieb Lazar, Lijo:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> If it's part of adev, does it need an arg? Can't kfd check it directly?

We could. Actually amdgpu_amdkfd_suspend/resume are just a set of
wrapper functions before calling into KFD. That would be the perfect
place to check the adev->run_pm flag.

Either way, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
=A0 Felix


>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Alex Deucher <alexdeucher@gmail.com>
> *Sent:* Friday, February 5, 2021 1:34:50 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon
> for kfd runtime suspend (v2)
> =A0
> the flag used by kfd is not actually related to fbcon, it just happens
> to align.=A0 Use the runpm flag instead so that we can decouple it from
> the fbcon flag.
>
> v2: fix resume as well
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> =A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> =A01 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0ee6514ee55c..b7ebd424bbc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3734,7 +3734,7 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_device_ip_suspend_phase1(adev);
> =A0
> -=A0=A0=A0=A0=A0=A0 amdgpu_amdkfd_suspend(adev, !fbcon);
> +=A0=A0=A0=A0=A0=A0 amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 /* evict vram memory */
> =A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_bo_evict_vram(adev);
> @@ -3818,7 +3818,7 @@ int amdgpu_device_resume(struct drm_device *dev,
> bool fbcon)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0=A0 }
> -=A0=A0=A0=A0=A0=A0 r =3D amdgpu_amdkfd_resume(adev, !fbcon);
> +=A0=A0=A0=A0=A0=A0 r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
> =A0=A0=A0=A0=A0=A0=A0=A0 if (r)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return r;
> =A0
> -- =

> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
