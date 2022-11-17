Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5F8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 03:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CDC10E521;
	Thu, 17 Nov 2022 03:34:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB4910E521
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 03:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je6x5+52DXClFzyO8uQW072PGeWIJVnHTbz5kobH0wilqiQSQzhzqSDq7yDMI0yGGhP7UyAJgdYxa9B4tGmnz4wrpgFxQ82+D4LS1KBgoGA1UkLGCk01/+8OfhxPI+UxIe3rmCw1OgmGqTcifOsceO5G4juA/79000ArDnXkW9ZbzKe9J4QpxPHI0kRFu0oXraNRpJlqqHi7Jzs6FTD1gEoK2/FvQ0LnpHHsrbpY/WFSPh5xbc57kfu6iCcrKP6CBO11tyvjo8qEFNoz0LD4D0v6p6to04W7f8BMhr/7DbHOKksHwinqMo4QZYzN+77O+7ev26eJHVLgz/TgAu4dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6yVy6LGN7Z5L8wDdHemJN2b2/VxLc3ITBH/aR5AIWU=;
 b=PJOPavNT3ve4MtkiRLzTT/3aB4Qr1ZSJls+v8dZ3liY407LWus368zzn0HGnVfLO1z+GbIsmTk1JetmawZJzZEXIR7lszpWSCu8UDfTq4MakUhSandSZPpeBXIPNhyogzkfC4YL7e+57O7dG3vTNIbOcwsoowTscudYjJNW3KylSIQ/+A2h+dw9TlPraVjtVlaMmrA1Xyw2Uzwi9F3LSbu8mIitGiSKYbKxAeU4DZyzMjelTlKM+LGzNKNcrl0lllXHSpKFLvM2L4jORS9DeCEPzsLN7+qFd16His3CXvxU5loivFErQC2Z/P+QtPlwMeSvdaePhL1jwbd7RVNBlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6yVy6LGN7Z5L8wDdHemJN2b2/VxLc3ITBH/aR5AIWU=;
 b=wHV9Eg107QsdoD/pvgJl4GvP4ifphLmhQugEUsZ194Dntu6qveR42+Ibs0+sJDOLhzsGPA2PEdKd420pcf6+mxRjXPvGcSqLsOyRm9M22P7Du9WwK2Pl03YA7iei+EKWY3opdGjq2BkMYPp0pWg+yJOY3GNvqqpEr1AV7dI2rMA=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 03:34:10 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01%9]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 03:34:10 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Subject: RE: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Topic: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Index: AQHY4tFVpYvpMYHRLUurvXDdtV25kK4oe3YAgADSeqCAAJAjgIAAC0PAgAAFIoCAAae2gIAA/0LwgABrlQCAB1XWwIAEL1YAgAZNgACAA84mMA==
Date: Thu, 17 Nov 2022 03:34:10 +0000
Message-ID: <DS7PR12MB63335EB86FB0A3830C7454F3F4069@DS7PR12MB6333.namprd12.prod.outlook.com>
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
 <DS7PR12MB63331E4430DC731D92B0A7CAF43F9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fb72d05b-dc74-fa84-51cf-3c3911aa46fc@daenzer.net>
 <ddf6786a-7bdc-c8fa-e432-7e20498bb26d@daenzer.net>
In-Reply-To: <ddf6786a-7bdc-c8fa-e432-7e20498bb26d@daenzer.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4fda2bf1-0192-441e-8da0-50dc73583298;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-17T03:21:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|BL0PR12MB4882:EE_
x-ms-office365-filtering-correlation-id: c183dc04-7eb4-445c-afc4-08dac84c96f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2joQWpY2O2+eoODcpPZQaq60ejqp6cancVzBwW/CgeHFY/m2yqieJGBKx5cAjnO55l+9TIB8eEOW/Bi4oz7saK3GVCK0pALNk6TjID5MnaGyOc8Ydq9PR5BQ5sVqqTawx7Cdz8b3uCFHWgB3PhLkc4h0xSNVjFjkWxQmY00U8vqdwFhVB7CAcQ/Gl5mQDMr2CmLUcM9y30Pr7wS6BrEAQ2mB+F4QBufPw+mrK7lSzMQ8ESJSvCFZqRmJaW/7iZsKpDz3hKZLQFx63hHztHALT6R6eRIh+tFq/K83HAMUGUXuhIOf9WIid7dReJCrYFhf83/dCzOkwBVb8yZ3auhOZhhdfGJKF2WCCGo9HxRA11MUn8xCRtLAm6W7hpQP2+eBBOjwy72883swFc7mqi62+8K0rUVIxZnazFsF7u4ZbfJEFeAxSaoctHdVNblXwxYsw4rrm43LEb0fCr5/uornvz6+DiueRlR51i5/lCUCI5XW2lFmgfUqZcPOjKfrHx4pKL+7OOThkirQtSeBi8iUU5b7ZQW6+VjYkd9cJ735sfu7vKeJ+4CStZPLC1ra1H8IJwON8TB7aslFLAxyFtccYedZi+288U80cIdiCW40f8/zryxa3zpUFBlCQz9Jr9sPsr6XqJ2aaXuLL9w4SxQUBhpmq5/GkZOF9zHWe/EYJAa7WT1t8EZMmqKB0tkzMOxfU79zGUQUh51iGgPVJ58t/RjOeRfi/qQXIg9em7MvDFqtpbvkUU3yTSkQDiU9dimK2Cr7e5PD5qX4BX+RtZeHHS4anK2UAk1PLM5xgnoF3i8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(86362001)(33656002)(55016003)(122000001)(38100700002)(38070700005)(316002)(71200400001)(9686003)(26005)(53546011)(7696005)(6506007)(6916009)(45080400002)(54906003)(2906002)(4001150100001)(478600001)(83380400001)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8676002)(966005)(4326008)(8936002)(52536014)(186003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l4jIiMZ9eIwTTAODo+jpCd8f0WXBGpCRoVkli/Ny8pTT7Va1SqFtTl5vzR?=
 =?iso-8859-1?Q?LZfOdXbZ7WxFfKeitEqw8lzGIwiiU2ESTXH8v9Utlg7+hj72LwK0pXCKc+?=
 =?iso-8859-1?Q?lfcwzEKzaw+o1/qrdohFJQxcsT3VbmNjGgjxhLCY2jxFpM/AWkjWUHWubH?=
 =?iso-8859-1?Q?oyJ5ZBSeTfKphbJZldhjBe+9sBnrJFz01uOPvvco1qzE3SflWsaqzdkj7E?=
 =?iso-8859-1?Q?ZwjXXQhBjZ3AbSdyWHKzAkOGOVZB8byLVRhdOiSMtpTEbB2CelDaqNRFLj?=
 =?iso-8859-1?Q?oEV4loQg1/kzwmliFTffuNSZOScFmDyqzd7dZv1GJg+y1fYOQRcw9L7YZS?=
 =?iso-8859-1?Q?WGiKsR0Gr7Ymw8Op69mNHHR0YLLfMCyBXb7W5Nno2UGAHV3836kNOUgiDt?=
 =?iso-8859-1?Q?iRaj5BXIWBmn9QVsLj81kjuFO8mKV+5QpZTcx/FkuyQwSwUgVBH9/cNQV2?=
 =?iso-8859-1?Q?10As95cPZGp975ymIVlpU6pN9X6kf39id8NIxUJPMu/Caw9uhef1i4oWN+?=
 =?iso-8859-1?Q?0AEwhgFm9UFE1N6QqB2eN0lCJj6D2MnkCRwIKxin1dHgaxLardhfqc9wDi?=
 =?iso-8859-1?Q?HECEBkDtWdSCxx0cbyC1n0hOc0bmC6i6ql6t8LLC9zCQLtV8+QVCyggPsh?=
 =?iso-8859-1?Q?tWcTSVX2R2ILkGbjIgxYj8RTEpSPxb13hlmsQmfS45+O5XVeNF9EcIi7NL?=
 =?iso-8859-1?Q?QX7Oed3Jb4iXwulMz2IL0AOBAtluB9fLBansCvvvjQ2u5DjPH93rtglEuV?=
 =?iso-8859-1?Q?gBlxlLwhUfb/n9ZgikVKjxuIVuLzxn1tFyFIOuVKETANFH/XhFkueH1y8G?=
 =?iso-8859-1?Q?lwniBKLDwgoyT0GzU2lsqAVM6QpYbZL35i8P45tqOudYBwGt8fdNktt+H1?=
 =?iso-8859-1?Q?WvJznuaGEHCxUKQJKarY+ngTTX3EvgqmC5aMDONHPInbTPrtktA/gcr1AW?=
 =?iso-8859-1?Q?uysKomtGIy4byf0RoVllzcf3kj7p+M3QafzgNlKFUq0RP9rs8WmHGXo8WY?=
 =?iso-8859-1?Q?9cK7hbQX6PLM6sRNyalkBd0NeF75jRrM8VC5qmHUEnzgqzH0Jcb4yIf4it?=
 =?iso-8859-1?Q?JO9JzjO9/qwt5QK2XMVEld2tX6eAltidISW6WlFXvhH//CLwVyeA9Fvn/T?=
 =?iso-8859-1?Q?7Yq77A+KDK6euylL4SkEs3fxYAssO4OJos5GCP2wjTxA1euBdbAsjhiBk3?=
 =?iso-8859-1?Q?UN4L+Nnx3AOsfkGb8HQDXTKQ8zfT4fxtDT0v+nJJDlfo/agtpAbwqTRt5X?=
 =?iso-8859-1?Q?CDLoiGbhCyfcSQ3y/MG5wqC9RAj4/vA6OvV7vVBi4BgX7oQbeWo9WTF+/M?=
 =?iso-8859-1?Q?fCB+SxOpm4UEafc1pjFBvdKSk6+o33sUtFu2QQ72eXWAJBkhe9r7bxment?=
 =?iso-8859-1?Q?TO+EzSDnHFEA2p/LbpTBuBwUWNXGp/qCJnYc0TbGg8pU0ngTXjHdckmOpv?=
 =?iso-8859-1?Q?AZEP3l1cXwEBBIeEPT1/0K+0uwsKBtjWZEaEHbA8d39GdV7Q7Bm9ds/cXM?=
 =?iso-8859-1?Q?Legf1fL4LI5oUi/EnP7g2M1pPJ5iSmQ27wgUtCn0Q9tK1w8xeAgNrJu78I?=
 =?iso-8859-1?Q?5Bp/uB6UWK4xgSmg9DRzCm9EOmh4WJdlEwTO0Z751q0QLP7RdXT4PfoZ5L?=
 =?iso-8859-1?Q?pPxzQJT3jOiRTTrpXSAbhZCbjbwbu0KTgS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c183dc04-7eb4-445c-afc4-08dac84c96f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 03:34:10.1540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cg3e/1oqoMJxKfzk4/EalM6myf2h32Jhid5n7GQux7FTM350baYjtaRqGlPhOw62nweTwUIa7Sdcu0NqhtUjPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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

I didn't reproduce the hang yet but find a race condition related with fenc=
e signaling time. I updated the patch series based on kernel 5.18.

Thanks,
Jiadong

-----Original Message-----
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Tuesday, November 15, 2022 1:15 AM
To: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Huang, Ray <Ray.Huang@amd.com>; K=
oenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)

On 2022-11-10 18:00, Michel D=E4nzer wrote:
> On 2022-11-08 09:01, Zhu, Jiadong wrote:
>>
>> I reproduced the glxgears 400fps scenario locally. The issue is caused b=
y the patch5 "drm/amdgpu: Improve the software rings priority scheduler" wh=
ich slows down the low priority scheduler thread if high priority ib is und=
er executing. I'll drop this patch as we cannot identify gpu bound accordin=
g to the unsignaled fence, etc.
>
> Okay, I'm testing with patches 1-4 only now.
>
> So far I haven't noticed any negative effects, no slowdowns or intermitte=
nt freezes.

I'm afraid I may have run into another issue. I just hit a GPU hang, see th=
e journalctl excerpt below.

(I tried rebooting the machine via SSH after this, but it never seemed to c=
omplete, so I had to hard-power-off the machine by holding the power button=
 for a few seconds)

I can't be sure that the GPU hang is directly related to this series, but i=
t seems plausible, and I hadn't hit a GPU hang in months if not over a year=
 before. If this series results in potentially hitting a GPU hang every few=
 days, it definitely doesn't provide enough benefit to justify that.


Nov 14 17:21:22 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* rin=
g gfx_high timeout, signaled seq=3D1166051, emitted seq=3D1166052 Nov 14 17=
:21:22 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process info=
rmation: process gnome-shell pid 2828 thread gnome-shel:cs0 pid 2860 Nov 14=
 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset begin!
Nov 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: free PSP TMR buff=
er Nov 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: MODE2 reset No=
v 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset succeeded=
, trying to resume Nov 14 17:21:22 thor kernel: [drm] PCIE GART of 1024M en=
abled.
Nov 14 17:21:22 thor kernel: [drm] PTB located at 0x000000F400A00000 Nov 14=
 17:21:22 thor kernel: [drm] VRAM is lost due to GPU reset!
Nov 14 17:21:22 thor kernel: [drm] PSP is resuming...
Nov 14 17:21:22 thor kernel: [drm] reserve 0x400000 from 0xf431c00000 for P=
SP TMR Nov 14 17:21:23 thor kernel: amdgpu 0000:05:00.0: amdgpu: RAS: optio=
nal ras ta ucode is not available Nov 14 17:21:23 thor kernel: amdgpu 0000:=
05:00.0: amdgpu: RAP: optional rap ta ucode is not available Nov 14 17:21:2=
3 thor gnome-shell[3639]: amdgpu: The CS has been rejected (-125), but the =
context isn't robust.
Nov 14 17:21:23 thor gnome-shell[3639]: amdgpu: The process will be termina=
ted.
Nov 14 17:21:23 thor kernel: [drm] kiq ring mec 2 pipe 1 q 0 Nov 14 17:21:2=
3 thor kernel: amdgpu 0000:05:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] =
*ERROR* ring kiq_2.1.0 test failed (-110) Nov 14 17:21:23 thor kernel: [drm=
:amdgpu_gfx_enable_kcq.cold [amdgpu]] *ERROR* KCQ enable failed Nov 14 17:2=
1:23 thor kernel: [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* res=
ume of IP block <gfx_v9_0> failed -110 Nov 14 17:21:23 thor kernel: amdgpu =
0000:05:00.0: amdgpu: GPU reset(2) failed Nov 14 17:21:23 thor kernel: amdg=
pu 0000:05:00.0: amdgpu: GPU reset end with ret =3D -110 Nov 14 17:21:23 th=
or kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* GPU Recovery Failed: =
-110 [...] Nov 14 17:21:33 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] =
*ERROR* ring gfx_high timeout, signaled seq=3D1166052, emitted seq=3D116605=
2 Nov 14 17:21:33 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* P=
rocess information: process gnome-shell pid 2828 thread gnome-shel:cs0 pid =
2860 Nov 14 17:21:33 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset be=
gin!


--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7CJiadong.Zhu%40amd.com%7C33282c71226444b6c24508dac663cf4a%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C638040429257070484%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3DCb8OyRawA9T9%2FfGSehB9r9JY%2FKcC4%2B%2FCdY8UaRh79t4=
%3D&amp;reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer

