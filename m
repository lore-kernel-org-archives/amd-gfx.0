Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CC3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 08:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78C610E219;
	Tue,  8 Nov 2022 08:01:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7F210E219
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 08:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjJdvjHGHQs9QRIoIZiF6a6BbxusS9U9dFa8ktDcewK+WHbLfiUBS1DauXQN0h5qthuRwXV+flAoGYv8T9bpEWIHkdAMtuqCCFr6IKpBbooGcTpmHbbSeRyop+SjyMbkq+11Lu3VWK96ejrV1Rf6Z5G4w2OLI8G/QyNHjEZVDHnNplfEsiQLh4hQpeAo6XVlvbkTXuCSLHvrlPW5rVWJAVr/oA3DJzherNAbvR6Ze91Els2MFgF4snxOQYCyldvYCMFxUxaKtO32Gdt1bAokqJo79WA3QjaMnGmTEsUrx1Q4veXx0d6W+E1OQoPhL8ukwQmhFDviLz7SLaCBes5kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu1bzx3SUBQSK8uRfM2haRsZPdo1mAs5D84fly5iTGw=;
 b=lYsP9aqGJkrrWR4CHT5GFfHeKWEvOEZs9K6pqUPlsHfdp+OIc7s157E1Hzj3lKpGNyOtgFFLVSTUn4jhISCfVicWMT0tB0E5HTiM4LnvcKo+ed6LkfKByCLm+1kJY56ZCQTv9WBg7WvWzDi/pPiJQYOpJ1oUMa84Y9vYkzep7l9eiIxnDEc3ax43fdjHckVLG9qzb8Y5bQuQR7lzFRpOM54dJinr1erqTkP0yvcpL+/5+D6dTwA5ZvgjfUxjWvCxR/2oG3TRmuIgW7thEIxpYJvzog6onioTU/YG2TcvMI1BDJEiYDfWfYBoWV0xn0sosm1P49bv7+SFZZIJAn/JSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu1bzx3SUBQSK8uRfM2haRsZPdo1mAs5D84fly5iTGw=;
 b=jthVIIAJ8rtO/GwBGAKrS8vh7hGO6WQvfvPdkJ+B4LKSIpIqRCnIKlSAMxgCYft3bd5mBS7uRqNEQNDwuJlkwCPfgNw4wwCt4Y1REgsVihm67IIp56rqvISZUPo5tMJ91H3hj8pZHyC/xZcNorfUjSY10igkUzbWZyEL6uuUbmM=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Tue, 8 Nov 2022 08:01:25 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01%9]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 08:01:25 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Subject: RE: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Topic: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Index: AQHY4tFVpYvpMYHRLUurvXDdtV25kK4oe3YAgADSeqCAAJAjgIAAC0PAgAAFIoCAAae2gIAA/0LwgABrlQCAB1XWwA==
Date: Tue, 8 Nov 2022 08:01:25 +0000
Message-ID: <DS7PR12MB63331E4430DC731D92B0A7CAF43F9@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
 <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
 <92da389f-3c26-6fe1-0525-d38730b6924a@daenzer.net>
 <8b3240e6-c460-5dbd-eede-29ff4825e642@daenzer.net>
 <DS7PR12MB63332B114E5E3B45F91178AFF4389@DS7PR12MB6333.namprd12.prod.outlook.com>
 <04361686-5bdd-8ca8-2ecd-c5dfdaa1a41b@daenzer.net>
In-Reply-To: <04361686-5bdd-8ca8-2ecd-c5dfdaa1a41b@daenzer.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5c9b8828-6be1-498d-ab2f-bfbd8defd894;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-08T01:05:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|DM4PR12MB7766:EE_
x-ms-office365-filtering-correlation-id: d28a77ab-bebf-4ac1-6e21-08dac15f6f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcnFCweGx2WVlfBU/oW6Yfpawbl9ckPFbexI3Tc2I+HFptTRxsIJW9p1QQ4A/wnnJhtHg8B6YkNP3p56RK3h+bEIWtO9A5KUKPZIC+ZLV23FEaOg+Bxgtm2ncXY1iCrBHBHeh0l0v/sbrh1+Hrfm0mCy2eGpmv7kpzXwoOWhSFzjxXkvUNpIZJ2JVpfVGT6/kQM5W7ApZ9Cn1s/AdE+w9e6u5fjJ9i2DUGPR7QMufOQ0IgOTbl2BKPyl/LVx4Zx+E2fpM3tgUY8P0LQHb7ZOi8zLxh6SzryV/xFv0g1XQbvxwAG4C5Kg2aCYIPFh9baYSETZssVTIEKKfI5nNae0aVf0twOlyopeRf9PZOlQBZP1rPs3TGVjwPhd6fJzUw3u7gIilj0age/ZKQMAX57C4JU8xnF8gev2C6wJxNsQ7sdcBgaLpCJikY6puq8gDwn4oOoyD7eBOSGlopmmBLKbnOIcvEZJ98mBeL5yqAa3jzNGD74sM7NAnUv6YvF8Fns19CapiO9iqesnZUBmM46c1XsPvaQaOAxlo4n/pxqWQLq7SQtQ8O/MLAOQRxSe/LhpkJf9eepi7N6GJg5Vz8GsMuYssCMe2ungxCbokUgu6e6EUs5IjfVjaZITmO+hKvJd2abLKgxaFkWTIgK7i/Fg/DlD2YfZLHOOBH92WFEGsucqwl2xRTaqChREJRmqP24Fgb7cWKkQhBz7JMXdTNOuYjnXQaldfj8euUb2OvqwneA39YB02sDNSxQg/8bOQ7jIRbkNqP5mvhHy4cmBABpQpS4sgrRtqTK7YZ/REURrf1E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(38100700002)(86362001)(122000001)(38070700005)(55016003)(26005)(478600001)(966005)(8936002)(71200400001)(66476007)(66556008)(66946007)(76116006)(66446008)(6916009)(4326008)(54906003)(45080400002)(9686003)(83380400001)(6506007)(2906002)(316002)(5660300002)(52536014)(41300700001)(53546011)(7696005)(66574015)(64756008)(8676002)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7cI/fIKNTuZP3jxIn+1lz9dXQPuOPgMVmo5PGOsMqkWPOjxLPZZwZIFQzT?=
 =?iso-8859-1?Q?ybh8eOGPlwxNLQbBpNrpS5m1OKZbC4R6KGGChF8A6m48eX/Z53tvNTXmK8?=
 =?iso-8859-1?Q?Lk/Jqh6qG+ClvnhKYO+lHeoHvM34MlVC3hWhUaZYfWyvlmK4iqUTmfllLx?=
 =?iso-8859-1?Q?vfa83RIc8Fs36Pu81AvwmAVu43vnJFeWFWHzvu0mjL6zWk/ZHuBuxSa/0q?=
 =?iso-8859-1?Q?Y3F2PlsCig0CoD5JEOIRhPrg3QcYfg17oPyWAxXM4sbq47YBLiDcjCjoNb?=
 =?iso-8859-1?Q?KefrRK5Rk1cLshQwfaKWQ6AojegzFvEBDD+Zqw2mk0P657uogU9BYGxuqh?=
 =?iso-8859-1?Q?JOBnLSliYVoR06evjPehc9VNFdyvz1iphKP3kdWIYQPcnq2CqAJ4uXH2t0?=
 =?iso-8859-1?Q?1jST3JFXyXGRJf5HN9mwsvUke+KFlDLbyBmSCC/DsSFt2+ZmqxToUOymoT?=
 =?iso-8859-1?Q?+FqJbn0fR8/9euaYN2KHixX4wsq05H9kCWpv9bFv89eQYEeTfNlaI69qcP?=
 =?iso-8859-1?Q?mAoxRJIhVjEAKWhzurvTlYBaeRd1vy02T8VxpeycqhNK4u/K4NYMPMVzED?=
 =?iso-8859-1?Q?1MMlvDtN5iWSTUhEEKU5a3ExTuGxgHR2qVPiI77x14ZvTekCGIsDAG5KN1?=
 =?iso-8859-1?Q?MUKtYjMuiAliU/Xlj9CBxfLSjpkk8BsEPVvlNA3QrBWJip4DDyvuaPkLDz?=
 =?iso-8859-1?Q?gC2vsYx+Zwrg744mvi6cz/lnDCFBlS4PL4GC64yZ94HVx5m/AuCrIj3vZv?=
 =?iso-8859-1?Q?aSbKBAGcRSRepG5xfem8pC4oVEJ1H49wen+VDBdBioui3PDuAvazFEuXHd?=
 =?iso-8859-1?Q?DrLCh3FwGAuBZjJ30/BWhMpRP8cwviHHvT8eMl7e599sFsjIZplJBvOFKv?=
 =?iso-8859-1?Q?ZmXWr+JzYhbODSjEce/gA/q/C2Vk7K50ax8G0W16EFG5ohywLFYjn2s8Vq?=
 =?iso-8859-1?Q?yv8Sl1i9lwoRpLT1YXY74DcH+J03VYkd06j9X5tgs5L/dNtWCula5pcuU9?=
 =?iso-8859-1?Q?d5eccPD0kIsu66eae/r4sxr5/DlEebLcMdIuGJn4bEfluxc41rSC5N8RQ1?=
 =?iso-8859-1?Q?+huU8atgOA3oBzsuKUqMkLU2d2aB3Fhhb7TNbfowOQDY4OVI0xIcVT87Nx?=
 =?iso-8859-1?Q?s1jSVpopMJ4V48gDB9+HF7w6iU4e0PodWqdxJKeO5u95TLMNkc8hg6Dcw4?=
 =?iso-8859-1?Q?xSKiKPXGQy1KN0pLzu3QXyVKVzUk7b79vKjhwiRjtnNGbyRJRGoxwEw70Y?=
 =?iso-8859-1?Q?HrvSY56b0+dp/nCuRKYs1dOrruItwRqVkCqgT8XdAFV4rDy9Vim8/9NWQt?=
 =?iso-8859-1?Q?5+KSkBvQMa/stakaUkntRST20bRsmredWDwXGRWwgwi4b48mzyDa6dH4Ph?=
 =?iso-8859-1?Q?71XNSlunQOKRdv8ZEVg/jCNQu6K2vA5Kz+iw+FmKMjU5m23+qTyXtPYJS/?=
 =?iso-8859-1?Q?K9U0GE0SKwlkRHJ/a3mXIOafLkpLrEZ0iUYymFU4G7HuD8kg1HK+I+v1mL?=
 =?iso-8859-1?Q?tdYAJF4Y+CFpy7DC8dSUc3VSmHCdZgBTbWnmC4AQoPZuicbZuN+dyhcZw9?=
 =?iso-8859-1?Q?xp2hvFCTSBYeTNCSQOHZ6IKegEL0kfbxJMojXkkULDupojdCUEavED8fTX?=
 =?iso-8859-1?Q?cSEg1VcHB+hVTZOUDwC5OIP45SEfE3Hy5S?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28a77ab-bebf-4ac1-6e21-08dac15f6f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 08:01:25.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Gy4CiGBlZ2DGJVYrQHgWQ1WxSogeXj/bmOBDN+FN9W5MrZN0dSWi1pLCg6l1Kdlv/ES5iGHFV79OrCS18Mqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Michel,

I reproduced the glxgears 400fps scenario locally. The issue is caused by t=
he patch5 "drm/amdgpu: Improve the software rings priority scheduler" which=
 slows down the low priority scheduler thread if high priority ib is under =
executing. I'll drop this patch as we cannot identify gpu bound according t=
o the unsignaled fence, etc.

Thanks,
Jiadong

-----Original Message-----
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Thursday, November 3, 2022 5:05 PM
To: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Huang, Ray <Ray.Huang@amd.com>; K=
oenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)

On 2022-11-03 03:58, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
>
>> The bad news is that this series still makes some things very slow. The =
most extreme examples so far are glxgears (runs at ~400 fps now, ~7000 fps =
before, i.e. almost 20x slowdown) and hexchat (scrolling one page now takes=
 ~1 second, I can see it drawing line by line; before it was almost instant=
aneous). I suspect this series makes the overhead of running a single GPU j=
ob much bigger. On the bright side, I'm not noticing any significant interm=
ittent freezes anymore.
>
> Hi Michel,
>
> Thanks for the trying.
> Is there high priority jobs running while executing glxgears?

Yes, mutter is submitting high priority jobs. However, I don't think that c=
an explain the problem by itself:

mutter only draws once per display refresh cycle. Let's assume mutter's GPU=
 work takes ~6-7ms (conservative example, should be less than that usually)=
. That leaves ~10ms per display refresh cycle (at 60 Hz refresh rate) where=
 GPU work from glxgears & Xwayland can run without getting preempted. Since=
 glxgears runs at ~7000 fps without this series, it should be able to draw =
at least ~70 frames in 10ms[0], which corresponds to over 4000 fps. Yet it =
manages only 1/10 of that.

[0] Worst case consideration, ignoring the fact that without this series, g=
lxgears runs at ~7000 fps while mutter sustains 60 fps.


> I am running glxgears while submitting high priority ibs using amdgpu_tes=
t, the fps ranges from 6000~8000.

It's getting clear that artificial tests such as amdgpu_test don't suffice =
for evaluating the real-world impact of this kind of change.


> Continuous preemption and resubmission may cause the slow fps. Could you =
have a check about how fast the trailing fence seqNo expands. On my side, t=
he increment of Last signaled trailing fence is < 10 in a second.

I had to go back to a kernel without this series, as it was just unusable. =
As this is my main machine, I don't know when I'll get a chance to check th=
is.


--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7CJiadong.Zhu%40amd.com%7C5cb642e1abf34ab7377308dabd7adfb7%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C638030632689527329%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3DjJuSMxqY4nMltWdrSOe4iJF5kmwPG2gBFXudDmheNBc%3D&amp;=
reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer

