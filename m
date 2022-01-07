Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 19:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6545410E583;
	Fri,  7 Jan 2022 19:33:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F1810E583
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 19:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfHSTyNPkJ3nFwF8kidltebb/XAG02Wwfxqj8VSqHJzkqRqpd/27Fy9xLjgiMxBwkw2RQnk/RLWyMpJNsP4dnduY8Uqz25An4GE+deqtGHRrioQoAur6rxnefTXVmgfLTbCG5cDThfu5/U2DUzi2N0cH3mMlGl/uZCi0JDnwYMxNleqAKSzW3AlsUOyFTFPMNwxVERvQMWxQGW1RcV1C0erAMzV9svHdek9wBmQ70x0VqNwkrlPAYebXVpVEPhnBN0fLQHY990L7HHqppFXjHJYbNau4cLdIJISQricRTO9d5cKGMP8gZjvBlpLEwzO+c4X89s+G6o6NkhVWA3RiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGjGTwC/rp5H6DtPoJ6942gDb8cTVc4M3JWrtKTLnFw=;
 b=AfX6iQzHAKUSP0B7Z3Mi7OhIag7nrAAAlDtFJ79EpRN9t5mFbXhFQRAxp1FV8GBaU4QJdrO5EJyLcvgDMo67QhelKdgtIGo15mRGqS9BOZw+9xec28/Y1Doo4CCWsxGvOlDJIKos7n5rW1p3nYwBdjAdfFaiEkH3lD06UB+HmFS0KKVx6J/Yc3J8VmC7HeZo5LjUxmiFM0Z5QBk53FiMSEAMpTGRWZBzEzG9+z5g/tem1Fg+eP1eeXw4Ec897XCt0tdASuwhjCtngh/NXc15tsPdGQZA52S0z3tt0vsKXzdGxWhJPaf1EFGLBEi+VCHHvfe0E7++XsZympsn7d16rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGjGTwC/rp5H6DtPoJ6942gDb8cTVc4M3JWrtKTLnFw=;
 b=HwRYJuJ147d4K11tBeIlyzHd55QsB0U4TPWcubWkdpMieEsXz6kiXYQ/7Tq9UbPK+asw+/bTERW2PMue2J6Jsth+jh3wN6Lw+UiIWSCMzh+pzp4wxov0mEtAk4a1cYLMQ0hdFO2N/P9ZnguJKII0CEEqKE/ScZ+il/UFtBgHwcU=
Received: from BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 19:33:28 +0000
Received: from BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::c38:f6e6:7b1b:2d10]) by BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::c38:f6e6:7b1b:2d10%8]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 19:33:28 +0000
From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>
To: Isabella Basso <isabbasso@riseup.net>
Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML
Thread-Topic: [PATCH v2] drm/amd/display: move calcs folder into DML
Thread-Index: AQHX9fhf/BmbZdaIJ0SkYEjASRRnLKw8BUyAgASFqXmAET/sgIAGQ0MV
Date: Fri, 7 Jan 2022 19:33:28 +0000
Message-ID: <BY5PR12MB42117A6DE6AAC96030654D6BFB4D9@BY5PR12MB4211.namprd12.prod.outlook.com>
References: <20211220232047.1327228-1-isabbasso@riseup.net>
 <8cd2132a5242a15f48628dc993110fc2@riseup.net>
 <BY5PR12MB42117515E3411EFF7F6602B6FB7E9@BY5PR12MB4211.namprd12.prod.outlook.com>
 <9b6f3b8e65326fde5b1166559d578030@riseup.net>
In-Reply-To: <9b6f3b8e65326fde5b1166559d578030@riseup.net>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4866709b-6b74-4d41-9d8e-08d9d21494d0
x-ms-traffictypediagnostic: BY5PR12MB4211:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4211466B33A97BBD7F774CBCFB4D9@BY5PR12MB4211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Grf5D4JfEQqZeKazQy5iOD79AX/TgH4PA0tnN8t56nf7g+rpMSyfB6H2h64c8xFrwnHCxVie0lLygL9BklNHbzjlTaHB/1N4C2llmeylnSVrHPAN2EtWTjC2srvLa16/V86LPBFMW05f8BI5M5jhi4YYUV3DUfcboX0vL84idHKTEwHDF93WHrLk2hoJzO1Wu7zaqcVW6vka6Pz2DRN545KcbrnCyBWeDVTJRw4Hi67UIZfmDb2KpU0Wo7mFPsmiyVfYOCFR0bGswAanIsIWiUqteNS63o5AySnNmO7SFpFx9aHIBDmTPmziLHAYSWBLVGSCy5WZ3BN6KuNTjLgp+7gdX4oDSqydb+ozaIGAK/KOqKFwvcfugDfrCZ9We6VvuqSR+WvF9qiBoh015bIBHesF/34I0c71tZ+s7E7Qw8m2wY0It1jV4AvP1In9RjO5IBDWshv2MEfESs1B5T1OsWcyQ3v30fmG3VLUQQlx9tpuVPcjRhoLCiJf3DT/ffETZz+F4MXOLWianfCAYrzbR9Wj8vIS/o/AAQi1Vmckx2PZzwECY6/n5JhIUjp/SL2dfup3Inx0rcLi2qmIfKz2BZRFdG0qQ72SPDLNAJDZrfj/X+zrzkwWwzAGcJ3hhg0Ww/wP/eT7N0j93Xinr82FahwEljs6tgHlCQ6PTI4no7cJoIwMfuyNL2ifSiT5x10tN1kJYBc4pyo6v1lJUPmiDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(6916009)(166002)(54906003)(8936002)(5660300002)(4326008)(4001150100001)(55016003)(38070700005)(64756008)(9686003)(86362001)(122000001)(33656002)(66446008)(66946007)(53546011)(71200400001)(7696005)(6506007)(52536014)(83380400001)(966005)(66556008)(66476007)(26005)(508600001)(2906002)(76116006)(8676002)(186003)(91956017)(45080400002)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rtb05OBlKCS8cfNHtxPRHL84L2M1RY8S/GtkcDwdZkYRmIkMNfn0sTZWyN?=
 =?iso-8859-1?Q?kQfKbEMI77fX2y0Z8enCkb6jYXKBeK9y7KPggcul6dDUfyueZeFWHTQVny?=
 =?iso-8859-1?Q?YZoIADT1b39OvA7pnrVdaCVoNYbqHFbyvLlrPORxMD7LcdA9bavxeq2Q7V?=
 =?iso-8859-1?Q?56VDDjVhuPYRYEW/+IfegS22e1M3NyKbtXRIUDgmHWymmrIqoZxyVQ4Jf0?=
 =?iso-8859-1?Q?QnN1Nm5J6MqOA9/R/lfCwD6K0Mx5+DxBb/9MTTOTh4B9RXRtGnUtK0jgTx?=
 =?iso-8859-1?Q?OHusMZ9EanKRrFr+/5x56Bhb1VAOmcqgFiw4SgbRurG96RvivXt0N9BPq2?=
 =?iso-8859-1?Q?Yjn48T4zHHKVEXQSTLd4seRVt4na1+5e4ZwDsMlArBTpOfmTyXBqUz2MRD?=
 =?iso-8859-1?Q?UM3f3/Gp/iygJxMQ0syFLfku2ZmVH2+t5WKLqUqR3n8cJXoA0a555/fXgE?=
 =?iso-8859-1?Q?Lh5uznC83UJenkTemZL/JPa4hGajNs/JsRHKuwEgLvniljR5zL8KWL3RQe?=
 =?iso-8859-1?Q?k4MY4zJ7a0bR9J3PwXOXum59f5qyb1G10ePIPEOejIema9kqlgtpALPtSA?=
 =?iso-8859-1?Q?UWmQCbOSzhqUs6P22Wwt36jvXVFNklo0E2hMznq5C9WMNR3IS3Q2uOORTH?=
 =?iso-8859-1?Q?LxjLNdRgSv0f0orojzVVpV3bFmjAIwcrvzrjv6S29sV8vkigOxBHwCc1MU?=
 =?iso-8859-1?Q?eDQolNJys7DuZ674iKZ19Y9Bx3DRNQHNGqW4d+nILImqb8KDjTg2f2FLl5?=
 =?iso-8859-1?Q?WGM94ASgN5qpKQmGuqkFd4NI1O6CLxYruIt3qbJ6z9RmVvLG7c5bTF4h9f?=
 =?iso-8859-1?Q?vsN86l6VPBCnKCgKvrfnlUj4++5utudq9UIgkNqXrytSvkxrFKlQP2hdDf?=
 =?iso-8859-1?Q?HMgivvCCsC66yay57IX7FQY6IQGcC2OYmP0bSlAGuvluaCqTFD/Nyo/YwA?=
 =?iso-8859-1?Q?u/+GgDtVGpDzAMwkKNs/1MpgTkhdlMwTg/b2dVUz+hIOTwevmmXu+ADwqG?=
 =?iso-8859-1?Q?8xDwAAoW7dOu4/yUYMUTv99it7lq6qAa5jtONSxpmhvN+6Zp0ym+SolRun?=
 =?iso-8859-1?Q?FhzduMRLFHiJ55uR5Gn7vb5/1r/lTQB7frWVl0AXVestaK6v6ShkV1VPT7?=
 =?iso-8859-1?Q?Q/QfvStjUgZh6wCCpyD/cGn+qd4+ekSbuUEfRPlZzGx5/q8hDewXwcqGbN?=
 =?iso-8859-1?Q?++qGH/2ULVs++WNJ0rJYLql3CjmTTWaWEMyMaGl/OrSLfZCXf8HYHnWr//?=
 =?iso-8859-1?Q?0G5sma2pVFjKtdIWs4SPYbi83kSpXQ7zVm7hMMaCvKgpBhNITzi3KE6E+J?=
 =?iso-8859-1?Q?RY2w1Y3cNX7qnRa1Q8EurKM1CYhHUVPA4pc+9h/Cqt+bD1yyN20yX39BJD?=
 =?iso-8859-1?Q?rY9osbu+F0bU4mV/0d8xdqzk3/4P8w+bfv6d7LdhQEQ+NstSFc5jytVQob?=
 =?iso-8859-1?Q?9NRRzU9HovGoCEFdw6ucqkubnPevyzHarej4z9WAcsbu3eokEx1lBSk/bI?=
 =?iso-8859-1?Q?+l1MNAPWdcRdo53apUMYTudla3+CpFcHpf16zMyMU/NLgqt7GuYkKOTpeB?=
 =?iso-8859-1?Q?RIs3Q6Djs8EL4qU/IG1w2tLKLjUmlg290CyRublr7QE749/NcNHbslRxJL?=
 =?iso-8859-1?Q?/ygs/ctnDVQAT8eIV1gM4HOweGk7UujUTi/CVZNRVquaYJxJ5zLnn4LQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB42117A6DE6AAC96030654D6BFB4D9BY5PR12MB4211namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4866709b-6b74-4d41-9d8e-08d9d21494d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 19:33:28.6577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N54cMQ1tJbkoai7jmAPQc4UPsb2HAi/Dc4Bi2n8GsbVVfuI4cc6KK3arxFtO9L8juTMQI4M5nh3xBXYZFEUOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Pan, 
 Xinhui" <Xinhui.Pan@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "mwen@igalia.com" <mwen@igalia.com>,
 "~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB42117A6DE6AAC96030654D6BFB4D9BY5PR12MB4211namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Isabelle,

Using the dml makefile for everything sounds better to me.
Could you send the v3 version using your way to me?

Regards,
Jasdeep

________________________________
From: Isabella Basso <isabbasso@riseup.net>
Sent: January 3, 2022 2:52 PM
To: Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>; Wentland, Harry <=
Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, =
Sun peng (Leo) <Sunpeng.Li@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Zhuo=
, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; mwen@igalia.com <mwen@igalia.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; ~lkcam=
p/patches@lists.sr.ht <~lkcamp/patches@lists.sr.ht>
Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML

Hello, Jasdeep,

On 2021-12-23 17:44, Dhillon, Jasdeep wrote:
> [AMD Official Use Only]
>
>  Hi Isabbasso,
>
>  The patch fails to compile when there is No DCN because the calc
> object files fail to generate since dml depends on the
> CONFIG_DRM_AMD_DC_DCN being enabled (Makefile inside dc folder):
>
>  ifdef CONFIG_DRM_AMD_DC_DCN
> DC_LIBS +=3D dcn20
> DC_LIBS +=3D dsc
> DC_LIBS +=3D dcn10 dml
> DC_LIBS +=3D dcn21
> DC_LIBS +=3D dcn30
> DC_LIBS +=3D dcn301
> DC_LIBS +=3D dcn302
> DC_LIBS +=3D dcn303 endif
>
>  A few changes need to be made to the patch, which are:
>
>  -The Makefile in dc needs the line: DC_LIBS+=3D dml/calcs
>  -the Makefile in the calcs folder that the patch deletes can be
> placed inside of dc/dml/calcs instead of adding it to the Makefiles in
> dc/dml
>

Siqueira had warned me of this issue just before you emailed me, so I'd
already
prepared a v3 with no calcs Makefile but actually using the dml one for
everything, as it's pretty much set up for working with or without the
DRM_AMD_DC_DCN config turned on. Would this be alright, or would you
rather
have it as you suggested?

From what I tested locally both work pretty much the same. I think my
solution
is a little harder to test but ends up being a little more compact,
which might
translate into being more maintainable (maybe?).

Please let me know what you think :).
Cheers,
--
Isabella Basso

>  Could you revise your patch based on these changes.
>
>  Regards,
>  Jasdeep
>
> -------------------------
>
> From: isabbasso@riseup.net <isabbasso@riseup.net>
> Sent: December 20, 2021 6:23 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>;
> Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> Pan, Xinhui <Xinhui.Pan@amd.com>; Zhuo, Qingqing (Lillian)
> <Qingqing.Zhuo@amd.com>; Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>;
> mwen@igalia.com <mwen@igalia.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> ~lkcamp/patches@lists.sr.ht <~lkcamp/patches@lists.sr.ht>
> Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML
>
> On 2021-12-20 20:20, Isabella Basso wrote:
>> The calcs folder has FPU code on it, which should be isolated inside
> the
>> DML folder as per
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.freedesktop.org%2Fseries%2F93042%2F&amp;data=3D04%7C01%7CJasdeep.Dhill=
on%40amd.com%7C8a3d537d1fb64bac26c308d9cef28d37%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637768363894413584%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DrpK=
QjmK4atQn0U3RMCmkMTe9Yyj0dq4YDBhQeA48lyM%3D&amp;reserved=3D0
> [1].
>>
>> This commit aims single-handedly to correct the location of such FPU
>> code and does not refactor any functions.
>>
>> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
>> ---
>>  drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
>>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68
> -------------------
>>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 13 +++-
>>  .../amd/display/dc/{ =3D> dml}/calcs/bw_fixed.c |  0
>>  .../display/dc/{ =3D> dml}/calcs/calcs_logger.h |  0
>>  .../display/dc/{ =3D> dml}/calcs/custom_float.c |  0
>>  .../display/dc/{ =3D> dml}/calcs/dce_calcs.c    |  0
>>  .../dc/{ =3D> dml}/calcs/dcn_calc_auto.c        |  0
>>  .../dc/{ =3D> dml}/calcs/dcn_calc_auto.h        |  0
>>  .../dc/{ =3D> dml}/calcs/dcn_calc_math.c        |  0
>>  .../display/dc/{ =3D> dml}/calcs/dcn_calcs.c    |  0
>>  11 files changed, 13 insertions(+), 70 deletions(-)
>>  delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/bw_fixed.c
> (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D>
> dml}/calcs/calcs_logger.h (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D>
> dml}/calcs/custom_float.c (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dce_calcs.c
> (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D>
> dml}/calcs/dcn_calc_auto.c (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D>
> dml}/calcs/dcn_calc_auto.h (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D>
> dml}/calcs/dcn_calc_math.c (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dcn_calcs.c
> (100%)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile
>> b/drivers/gpu/drm/amd/display/dc/Makefile
>> index b1f0d6260226..1872adc96a00 100644
>> --- a/drivers/gpu/drm/amd/display/dc/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
>> @@ -23,7 +23,7 @@
>>  # Makefile for Display Core (dc) component.
>>  #
>>
>> -DC_LIBS =3D basics bios calcs clk_mgr dce gpio irq virtual
>> +DC_LIBS =3D basics bios clk_mgr dce gpio irq virtual
>>
>>  ifdef CONFIG_DRM_AMD_DC_DCN
>>  DC_LIBS +=3D dcn20
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> deleted file mode 100644
>> index f3c00f479e1c..000000000000
>> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> +++ /dev/null
>> @@ -1,68 +0,0 @@
>> -#
>> -# Copyright 2017 Advanced Micro Devices, Inc.
>> -# Copyright 2019 Raptor Engineering, LLC
>> -#
>> -# Permission is hereby granted, free of charge, to any person
> obtaining a
>> -# copy of this software and associated documentation files (the
> "Software"),
>> -# to deal in the Software without restriction, including without
> limitation
>> -# the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
>> -# and/or sell copies of the Software, and to permit persons to whom
> the
>> -# Software is furnished to do so, subject to the following
> conditions:
>> -#
>> -# The above copyright notice and this permission notice shall be
> included in
>> -# all copies or substantial portions of the Software.
>> -#
>> -# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
>> -# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
>> -# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
>> -# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
>> -# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
>> -# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
>> -# OTHER DEALINGS IN THE SOFTWARE.
>> -#
>> -#
>> -# Makefile for the 'calcs' sub-component of DAL.
>> -# It calculates Bandwidth and Watermarks values for HW programming
>> -#
>> -
>> -ifdef CONFIG_X86
>> -calcs_ccflags :=3D -mhard-float -msse
>> -endif
>> -
>> -ifdef CONFIG_PPC64
>> -calcs_ccflags :=3D -mhard-float -maltivec
>> -endif
>> -
>> -ifdef CONFIG_CC_IS_GCC
>> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>> -IS_OLD_GCC =3D 1
>> -endif
>> -endif
>> -
>> -ifdef CONFIG_X86
>> -ifdef IS_OLD_GCC
>> -# Stack alignment mismatch, proceed with caution.
>> -# GCC < 7.1 cannot compile code using `double` and
> -mpreferred-stack-boundary=3D3
>> -# (8B stack alignment).
>> -calcs_ccflags +=3D -mpreferred-stack-boundary=3D4
>> -else
>> -calcs_ccflags +=3D -msse2
>> -endif
>> -endif
>> -
>> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D $(calcs_ccflags)
>> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D $(calcs_ccflags)
>> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D $(calcs_ccflags)
>> -Wno-tautological-compare
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D
> $(calcs_rcflags)
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D
> $(calcs_rcflags)
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D
> $(calcs_rcflags)
>> -
>> -BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o
>> -
>> -ifdef CONFIG_DRM_AMD_DC_DCN
>> -BW_CALCS +=3D dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
>> -endif
>> -
>> -AMD_DAL_BW_CALCS =3D $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
>> -
>> -AMD_DISPLAY_FILES +=3D $(AMD_DAL_BW_CALCS)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index eee6672bd32d..82f26da6778e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -73,6 +73,11 @@
>> CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D
>> $(dml_ccflags)
>>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=3D $(dml_ccflags)
>>  CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o :=3D $(dml_ccflags)
>>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_ccflags)
>> +
>> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D $(dml_ccflags)
>> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D $(dml_ccflags)
>> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D $(dml_ccflags)
>> -Wno-tautological-compare
>> +
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D
> $(dml_rcflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dml_rcflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=3D
>> $(dml_rcflags)
>> @@ -94,7 +99,11 @@
>> CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D
> $(dml_ccflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=3D
> $(dml_rcflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D
> $(dml_rcflags)
>>
>> -DML =3D display_mode_lib.o display_rq_dlg_helpers.o
> dml1_display_rq_dlg_calc.o \
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D
> $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D
> $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D
> $(dml_rcflags)
>> +
>> +DML =3D display_mode_lib.o display_rq_dlg_helpers.o
> dml1_display_rq_dlg_calc.o
>>
>>  ifdef CONFIG_DRM_AMD_DC_DCN
>>  DML +=3D dcn20/dcn20_fpu.o
>> @@ -105,6 +114,8 @@ DML +=3D dcn30/display_mode_vba_30.o
>> dcn30/display_rq_dlg_calc_30.o
>>  DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
>>  DML +=3D dcn301/dcn301_fpu.o
>>  DML +=3D dsc/rc_calc_fpu.o
>> +DML +=3D calcs/dce_calcs.o calcs/bw_fixed.o calcs/custom_float.o
>> +DML +=3D calcs/dcn_calcs.o calcs/dcn_calc_math.o
> calcs/dcn_calc_auto.o
>>  endif
>>
>>  AMD_DAL_DML =3D $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
>
> Hi all,
>
> This isn't a v2, but actually a v1, I apologize for the mistake.
>
> --
> Isabella Basso
>
>
> Links:
> ------
> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
atchwork.freedesktop.org%2Fseries%2F93042%2F&amp;data=3D04%7C01%7CJasdeep.D=
hillon%40amd.com%7C8a3d537d1fb64bac26c308d9cef28d37%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637768363894413584%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=
=3DrpKQjmK4atQn0U3RMCmkMTe9Yyj0dq4YDBhQeA48lyM%3D&amp;reserved=3D0

--
Isabella Basso

--_000_BY5PR12MB42117A6DE6AAC96030654D6BFB4D9BY5PR12MB4211namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>Hi Isabelle,</div>
<div><br>
</div>
<div>Using the dml makefile for everything sounds better to me.<br>
</div>
<div>Could you send the v3 version using your way to me?</div>
<div><br>
</div>
<div>Regards,</div>
<div>Jasdeep</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Isabella Basso &lt;is=
abbasso@riseup.net&gt;<br>
<b>Sent:</b> January 3, 2022 2:52 PM<br>
<b>To:</b> Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; daniel@ffwll.ch &lt;daniel@ffwll.=
ch&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrigo &=
lt;Rodrigo.Siqueira@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&=
gt;;
 Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Zhuo, Qingqing (Lillian) &lt;Qingq=
ing.Zhuo@amd.com&gt;; mwen@igalia.com &lt;mwen@igalia.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; ~lkcamp/patches@li=
sts.sr.ht &lt;~lkcamp/patches@lists.sr.ht&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd/display: move calcs folder into DML<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello, Jasdeep,<br>
<br>
On 2021-12-23 17:44, Dhillon, Jasdeep wrote:<br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt;&nbsp; Hi Isabbasso,&nbsp; <br>
&gt; <br>
&gt;&nbsp; The patch fails to compile when there is No DCN because the calc=
<br>
&gt; object files fail to generate since dml depends on the<br>
&gt; CONFIG_DRM_AMD_DC_DCN being enabled (Makefile inside dc folder): <br>
&gt; <br>
&gt;&nbsp; ifdef CONFIG_DRM_AMD_DC_DCN <br>
&gt; DC_LIBS +=3D dcn20 <br>
&gt; DC_LIBS +=3D dsc <br>
&gt; DC_LIBS +=3D dcn10 dml <br>
&gt; DC_LIBS +=3D dcn21 <br>
&gt; DC_LIBS +=3D dcn30 <br>
&gt; DC_LIBS +=3D dcn301 <br>
&gt; DC_LIBS +=3D dcn302 <br>
&gt; DC_LIBS +=3D dcn303 endif<br>
&gt; <br>
&gt;&nbsp; A few changes need to be made to the patch, which are: <br>
&gt; <br>
&gt;&nbsp; -The Makefile in dc needs the line: DC_LIBS+=3D dml/calcs <br>
&gt;&nbsp; -the Makefile in the calcs folder that the patch deletes can be<=
br>
&gt; placed inside of dc/dml/calcs instead of adding it to the Makefiles in=
<br>
&gt; dc/dml&nbsp; <br>
&gt; <br>
<br>
Siqueira had warned me of this issue just before you emailed me, so I'd<br>
already<br>
prepared a v3 with no calcs Makefile but actually using the dml one for<br>
everything, as it's pretty much set up for working with or without the<br>
DRM_AMD_DC_DCN config turned on. Would this be alright, or would you<br>
rather<br>
have it as you suggested?<br>
<br>
From what I tested locally both work pretty much the same. I think my<br>
solution<br>
is a little harder to test but ends up being a little more compact,<br>
which might<br>
translate into being more maintainable (maybe?).<br>
<br>
Please let me know what you think :).<br>
Cheers,<br>
--<br>
Isabella Basso<br>
<br>
&gt;&nbsp; Could you revise your patch based on these changes.&nbsp; <br>
&gt; <br>
&gt;&nbsp; Regards,&nbsp; <br>
&gt;&nbsp; Jasdeep <br>
&gt; <br>
&gt; -------------------------<br>
&gt; <br>
&gt; From: isabbasso@riseup.net &lt;isabbasso@riseup.net&gt;<br>
&gt; Sent: December 20, 2021 6:23 PM<br>
&gt; To: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Chri=
stian<br>
&gt; &lt;Christian.Koenig@amd.com&gt;; daniel@ffwll.ch &lt;daniel@ffwll.ch&=
gt;;<br>
&gt; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrigo<br>
&gt; &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@am=
d.com&gt;;<br>
&gt; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Zhuo, Qingqing (Lillian)<br>
&gt; &lt;Qingqing.Zhuo@amd.com&gt;; Dhillon, Jasdeep &lt;Jasdeep.Dhillon@am=
d.com&gt;;<br>
&gt; mwen@igalia.com &lt;mwen@igalia.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt=
;;<br>
&gt; ~lkcamp/patches@lists.sr.ht &lt;~lkcamp/patches@lists.sr.ht&gt;<br>
&gt; Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML <b=
r>
&gt; <br>
&gt; On 2021-12-20 20:20, Isabella Basso wrote:<br>
&gt;&gt; The calcs folder has FPU code on it, which should be isolated insi=
de<br>
&gt; the<br>
&gt;&gt; DML folder as per<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D04%7C=
01%7CJasdeep.Dhillon%40amd.com%7C8a3d537d1fb64bac26c308d9cef28d37%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637768363894413584%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00&amp;amp;sdata=3DrpKQjmK4atQn0U3RMCmkMTe9Yyj0dq4YDBhQeA48lyM%3D&amp;amp;r=
eserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D04%7C01%7CJasdeep.Dhi=
llon%40amd.com%7C8a3d537d1fb64bac26c308d9cef28d37%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637768363894413584%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=
=3DrpKQjmK4atQn0U3RMCmkMTe9Yyj0dq4YDBhQeA48lyM%3D&amp;amp;reserved=3D0</a><=
br>
&gt; [1].<br>
&gt;&gt;<br>
&gt;&gt; This commit aims single-handedly to correct the location of such F=
PU<br>
&gt;&gt; code and does not refactor any functions.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Isabella Basso &lt;isabbasso@riseup.net&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/display/dc/Makefile&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68<br>
&gt; -------------------<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dml/Makefile&nbsp;&nbsp; | 13=
 +++-<br>
&gt;&gt;&nbsp; .../amd/display/dc/{ =3D&gt; dml}/calcs/bw_fixed.c |&nbsp; 0=
<br>
&gt;&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/calcs_logger.h |&nbsp; 0=
<br>
&gt;&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/custom_float.c |&nbsp; 0=
<br>
&gt;&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/dce_calcs.c&nbsp;&nbsp;&=
nbsp; |&nbsp; 0<br>
&gt;&gt;&nbsp; .../dc/{ =3D&gt; dml}/calcs/dcn_calc_auto.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 0<br>
&gt;&gt;&nbsp; .../dc/{ =3D&gt; dml}/calcs/dcn_calc_auto.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 0<br>
&gt;&gt;&nbsp; .../dc/{ =3D&gt; dml}/calcs/dcn_calc_math.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 0<br>
&gt;&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/dcn_calcs.c&nbsp;&nbsp;&=
nbsp; |&nbsp; 0<br>
&gt;&gt;&nbsp; 11 files changed, 13 insertions(+), 70 deletions(-)<br>
&gt;&gt;&nbsp; delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Make=
file<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/b=
w_fixed.c<br>
&gt; (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt;<br>
&gt; dml}/calcs/calcs_logger.h (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt;<br>
&gt; dml}/calcs/custom_float.c (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/d=
ce_calcs.c<br>
&gt; (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt;<br>
&gt; dml}/calcs/dcn_calc_auto.c (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt;<br>
&gt; dml}/calcs/dcn_calc_auto.h (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt;<br>
&gt; dml}/calcs/dcn_calc_math.c (100%)<br>
&gt;&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/d=
cn_calcs.c<br>
&gt; (100%)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt;&gt; index b1f0d6260226..1872adc96a00 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt;&gt; @@ -23,7 +23,7 @@<br>
&gt;&gt;&nbsp; # Makefile for Display Core (dc) component.<br>
&gt;&gt;&nbsp; #<br>
&gt;&gt;<br>
&gt;&gt; -DC_LIBS =3D basics bios calcs clk_mgr dce gpio irq virtual<br>
&gt;&gt; +DC_LIBS =3D basics bios clk_mgr dce gpio irq virtual<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt;&gt;&nbsp; DC_LIBS +=3D dcn20<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&gt;&gt; deleted file mode 100644<br>
&gt;&gt; index f3c00f479e1c..000000000000<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&gt;&gt; +++ /dev/null<br>
&gt;&gt; @@ -1,68 +0,0 @@<br>
&gt;&gt; -#<br>
&gt;&gt; -# Copyright 2017 Advanced Micro Devices, Inc.<br>
&gt;&gt; -# Copyright 2019 Raptor Engineering, LLC<br>
&gt;&gt; -#<br>
&gt;&gt; -# Permission is hereby granted, free of charge, to any person<br>
&gt; obtaining a<br>
&gt;&gt; -# copy of this software and associated documentation files (the<b=
r>
&gt; &quot;Software&quot;),<br>
&gt;&gt; -# to deal in the Software without restriction, including without<=
br>
&gt; limitation<br>
&gt;&gt; -# the rights to use, copy, modify, merge, publish, distribute,<br=
>
&gt; sublicense,<br>
&gt;&gt; -# and/or sell copies of the Software, and to permit persons to wh=
om<br>
&gt; the<br>
&gt;&gt; -# Software is furnished to do so, subject to the following<br>
&gt; conditions:<br>
&gt;&gt; -#<br>
&gt;&gt; -# The above copyright notice and this permission notice shall be<=
br>
&gt; included in<br>
&gt;&gt; -# all copies or substantial portions of the Software.<br>
&gt;&gt; -#<br>
&gt;&gt; -# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF=
 ANY KIND,<br>
&gt; EXPRESS OR<br>
&gt;&gt; -# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF<br>
&gt; MERCHANTABILITY,<br>
&gt;&gt; -# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN =
NO<br>
&gt; EVENT SHALL<br>
&gt;&gt; -# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,<b=
r>
&gt; DAMAGES OR<br>
&gt;&gt; -# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR<br>
&gt; OTHERWISE,<br>
&gt;&gt; -# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE<=
br>
&gt; USE OR<br>
&gt;&gt; -# OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&gt; -#<br>
&gt;&gt; -#<br>
&gt;&gt; -# Makefile for the 'calcs' sub-component of DAL.<br>
&gt;&gt; -# It calculates Bandwidth and Watermarks values for HW programmin=
g<br>
&gt;&gt; -#<br>
&gt;&gt; -<br>
&gt;&gt; -ifdef CONFIG_X86<br>
&gt;&gt; -calcs_ccflags :=3D -mhard-float -msse<br>
&gt;&gt; -endif<br>
&gt;&gt; -<br>
&gt;&gt; -ifdef CONFIG_PPC64<br>
&gt;&gt; -calcs_ccflags :=3D -mhard-float -maltivec<br>
&gt;&gt; -endif<br>
&gt;&gt; -<br>
&gt;&gt; -ifdef CONFIG_CC_IS_GCC<br>
&gt;&gt; -ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
&gt;&gt; -IS_OLD_GCC =3D 1<br>
&gt;&gt; -endif<br>
&gt;&gt; -endif<br>
&gt;&gt; -<br>
&gt;&gt; -ifdef CONFIG_X86<br>
&gt;&gt; -ifdef IS_OLD_GCC<br>
&gt;&gt; -# Stack alignment mismatch, proceed with caution.<br>
&gt;&gt; -# GCC &lt; 7.1 cannot compile code using `double` and<br>
&gt; -mpreferred-stack-boundary=3D3<br>
&gt;&gt; -# (8B stack alignment).<br>
&gt;&gt; -calcs_ccflags +=3D -mpreferred-stack-boundary=3D4<br>
&gt;&gt; -else<br>
&gt;&gt; -calcs_ccflags +=3D -msse2<br>
&gt;&gt; -endif<br>
&gt;&gt; -endif<br>
&gt;&gt; -<br>
&gt;&gt; -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D $(calcs_ccflags)<b=
r>
&gt;&gt; -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D $(calcs_ccflag=
s)<br>
&gt;&gt; -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D $(calcs_ccflag=
s)<br>
&gt;&gt; -Wno-tautological-compare<br>
&gt;&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D<br>
&gt; $(calcs_rcflags)<br>
&gt;&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D<br>
&gt; $(calcs_rcflags)<br>
&gt;&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D<br>
&gt; $(calcs_rcflags)<br>
&gt;&gt; -<br>
&gt;&gt; -BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o<br>
&gt;&gt; -<br>
&gt;&gt; -ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt;&gt; -BW_CALCS +=3D dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o<br>
&gt;&gt; -endif<br>
&gt;&gt; -<br>
&gt;&gt; -AMD_DAL_BW_CALCS =3D $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CAL=
CS))<br>
&gt;&gt; -<br>
&gt;&gt; -AMD_DISPLAY_FILES +=3D $(AMD_DAL_BW_CALCS)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt; index eee6672bd32d..82f26da6778e 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt; @@ -73,6 +73,11 @@<br>
&gt;&gt; CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D<br=
>
&gt;&gt; $(dml_ccflags)<br>
&gt;&gt;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=3D $(dml_c=
cflags)<br>
&gt;&gt;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o :=3D $(dml_ccf=
lags)<br>
&gt;&gt;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_cc=
flags)<br>
&gt;&gt; +<br>
&gt;&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D $(dml_ccflags)=
<br>
&gt;&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D $(dml_ccfl=
ags)<br>
&gt;&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D $(dml_ccfl=
ags)<br>
&gt;&gt; -Wno-tautological-compare<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D<b=
r>
&gt; $(dml_rcflags)<br>
&gt;&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dml_=
rcflags)<br>
&gt;&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20=
.o :=3D<br>
&gt;&gt; $(dml_rcflags)<br>
&gt;&gt; @@ -94,7 +99,11 @@<br>
&gt;&gt; CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D<br>
&gt; $(dml_ccflags)<br>
&gt;&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.=
o :=3D<br>
&gt; $(dml_rcflags)<br>
&gt;&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o =
:=3D<br>
&gt; $(dml_rcflags)<br>
&gt;&gt;<br>
&gt;&gt; -DML =3D display_mode_lib.o display_rq_dlg_helpers.o<br>
&gt; dml1_display_rq_dlg_calc.o \<br>
&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D<br>
&gt; $(dml_rcflags)<br>
&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D<br>
&gt; $(dml_rcflags)<br>
&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D<br>
&gt; $(dml_rcflags)<br>
&gt;&gt; +<br>
&gt;&gt; +DML =3D display_mode_lib.o display_rq_dlg_helpers.o<br>
&gt; dml1_display_rq_dlg_calc.o<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt;&gt;&nbsp; DML +=3D dcn20/dcn20_fpu.o<br>
&gt;&gt; @@ -105,6 +114,8 @@ DML +=3D dcn30/display_mode_vba_30.o<br>
&gt;&gt; dcn30/display_rq_dlg_calc_30.o<br>
&gt;&gt;&nbsp; DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_ca=
lc_31.o<br>
&gt;&gt;&nbsp; DML +=3D dcn301/dcn301_fpu.o<br>
&gt;&gt;&nbsp; DML +=3D dsc/rc_calc_fpu.o<br>
&gt;&gt; +DML +=3D calcs/dce_calcs.o calcs/bw_fixed.o calcs/custom_float.o<=
br>
&gt;&gt; +DML +=3D calcs/dcn_calcs.o calcs/dcn_calc_math.o<br>
&gt; calcs/dcn_calc_auto.o<br>
&gt;&gt;&nbsp; endif<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; AMD_DAL_DML =3D $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))<br=
>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c<br>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h<b=
r>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h<br=
>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h<=
br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c<b=
r>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c<br=
>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c<=
br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c<br>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c<=
br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c<b=
r>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c=
<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h<=
br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h<b=
r>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h=
<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c<=
br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c<b=
r>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c=
<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c<br>
&gt;&gt; similarity index 100%<br>
&gt;&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c<br>
&gt;&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c<br>
&gt; <br>
&gt; Hi all,<br>
&gt; <br>
&gt; This isn't a v2, but actually a v1, I apologize for the mistake.<br>
&gt; <br>
&gt; --<br>
&gt; Isabella Basso<br>
&gt;&nbsp; <br>
&gt; <br>
&gt; Links:<br>
&gt; ------<br>
&gt; [1] <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D0=
4%7C01%7CJasdeep.Dhillon%40amd.com%7C8a3d537d1fb64bac26c308d9cef28d37%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637768363894413584%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000&amp;amp;sdata=3DrpKQjmK4atQn0U3RMCmkMTe9Yyj0dq4YDBhQeA48lyM%3D&amp;a=
mp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D04%7C01%7CJasdeep.Dhi=
llon%40amd.com%7C8a3d537d1fb64bac26c308d9cef28d37%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637768363894413584%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=
=3DrpKQjmK4atQn0U3RMCmkMTe9Yyj0dq4YDBhQeA48lyM%3D&amp;amp;reserved=3D0</a><=
br>
<br>
-- <br>
Isabella Basso<br>
</div>
</span></font></div>
</body>
</html>

--_000_BY5PR12MB42117A6DE6AAC96030654D6BFB4D9BY5PR12MB4211namp_--
