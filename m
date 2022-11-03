Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C134C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 02:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F5210E563;
	Thu,  3 Nov 2022 02:58:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F06A10E563
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 02:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBX7uJWhVB+YLCCZYssTE/05is9nvmCkF0W/frqUe7GHwq7L1p6lA4ZbJ6fMPUVgee3FHJdLdSsZoc2Rck2OQF/ORK9RuhqbNP87AQyJgjoAxG6DfcZ/3RRsDACRSeEnXagqjErQRwxGeF8YcIxcX2Jiyz00lzAMk8afq/2CHjFME2TN4ZoeidynBB7/ahZYpYiyHj3dtKrkSW44IJ71lLTZ/cpUYrR0POwxbosu/0wj/CttviQLy3kVtwnuzQejSdHnLNiZBr6jA/VQ3ljeimCC3AEcMaBDLjHf7Y8WJBZdHlmxjdhYtn6sXWS/6+DU1n1+/xYp+j80xj6if9H9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgJC1irmgcME0sU7W1mxg9TBETlfUj/WO7Y1Il9nBPo=;
 b=bBvC66yG+ufc0dHnzaxRS8xXy93Bm4jlMzRz5VPxwTK5D4PmZpzq5hmXX2SJG+X+o1PqktjDlajlNmb7m+eiIVEjV8PnAZmhbKywvG4gIrrMDKOtETmT644DfxzejpfyCTIM6wdXItlWuI21chyJBXneYY9mJjhiD2lg1G9XRMg1lDhnkVo9FbpUnhMOmstOBA4ztQjqcm6IvWWEV8Kf4WOA7D6d1C1fo6+NiWo7TfWA6EEDThc36xB5JuPvG6U00Rp8xkCF43GxvmhayZL2+4chvzO05c1F93QRElJm9AGSJeyWCiyDlf30IpPa8u+vUa4Zrk9c5XU2/kX8Sl4CjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgJC1irmgcME0sU7W1mxg9TBETlfUj/WO7Y1Il9nBPo=;
 b=OtPAtB8PaUJ8gAr8/WP9QTHD2vOdAQo/s/eQ0j8V2oWG24OVsxmQwLHoLPUBG/C1iXCAZa9Ch2Rt8afApbXBWL/nx1pRIE5JwyaRr1j8dZgNA/+9GYax803DocIY0/oTkYSRsPSJcGc8r56BydKVRrV6hsTXKHxRAHQpjnmA0Fw=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Thu, 3 Nov 2022 02:58:52 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 02:58:52 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Subject: RE: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Topic: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Index: AQHY4tFVpYvpMYHRLUurvXDdtV25kK4oe3YAgADSeqCAAJAjgIAAC0PAgAAFIoCAAae2gIAA/0Lw
Date: Thu, 3 Nov 2022 02:58:52 +0000
Message-ID: <DS7PR12MB63332B114E5E3B45F91178AFF4389@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
 <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
 <92da389f-3c26-6fe1-0525-d38730b6924a@daenzer.net>
 <8b3240e6-c460-5dbd-eede-29ff4825e642@daenzer.net>
In-Reply-To: <8b3240e6-c460-5dbd-eede-29ff4825e642@daenzer.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b98cfce7-4c57-4065-a273-38b1d99e1516;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T02:39:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|DM4PR12MB5360:EE_
x-ms-office365-filtering-correlation-id: 84469d8e-f391-40c0-2ae1-08dabd475713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJ23ZOyLEm8QsHJW9D8bfv5GPxJ6tmGBl5ksInkv7K3A02m48TB0lwczNJ23eJn32FPVQ0J0HmGLQsRnQH9wOA9e4W4UHsSAiwJFux9cwSphfZko3PnzVINuD9e/wA/8wRjIX0luXHOBTa7KqDn0NA41xN9OV35Z8rz/tGeLA4xsf22ezvSiSuYMnhaTOCJlVYxrVgdCzTIiyYbxcJYA8iHo6Laj4CNZzUNZQjzCNgbXij78n6lRWh/ReAxSJ2sjTtIkmlAeoF2VKnJuaKX/cUZAQJ0tNxKNCnPKXopopMPu7q2Twu1I+kLAn2kU281Jmyl3jhD63+QIfYEWa27MzXi59Wc1/CjgpGVjUt8n/kOXofJ+BsJ33anZScW3OQV+J6X+MOxOH1rUuct3uZ9Grgegzs0pRzqoEslSFfgdMRVfkxSmN87eizWfcfyBIV7eqGDVCkaWRZ+bdOTSIPcdn2Are/68NOr51zbO+vLLuP3cJRpaLzmqV9rZ8Czvi2Zayl6XVM9lSt6ze6S2ninCMQaHGESFDX0S+6r7Ehg8yYPRqsHl8Yom+qCcRLFv5BlEx3KoqLH2ju6ptG0C3mtg/m7ATBjccev8v7BZUnnUQGHIDhYPrZ63dJZezYNzV+xf6ITOs9M6tHfHPFsGMLQ6OW9NlmhCEo0JAmMovpHI9XnhaTVtvlvn/hLuTP99/wQ86j06ts17C1O6DQmxcLPLnJU9HYSBWZJSpVSU+TdK9aWnPM0QaXhtJ3sIXulp4KOvz0bA+jrHm9mfGUR/OylYoynG1uU45G/kGYptmEoNu7s/ZAAqSpoGpbI6udlR5LzE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(76116006)(478600001)(52536014)(8676002)(66556008)(4326008)(66946007)(64756008)(66476007)(33656002)(2906002)(55016003)(5660300002)(66446008)(54906003)(6916009)(316002)(45080400002)(8936002)(122000001)(41300700001)(83380400001)(71200400001)(38070700005)(53546011)(7696005)(6506007)(26005)(186003)(9686003)(86362001)(38100700002)(966005)(86284004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J9D4CZ0cUXuTpiiIIZ3K/7BmDRyhp4tf1q87/5iPpWGVKob1Z+Om86uOys?=
 =?iso-8859-1?Q?zu2RsIk9SA8D+TP6N6Wv31Wg14XHwQRozt4Z1A4eiIyCpsCcbMuEl8HnIg?=
 =?iso-8859-1?Q?D/MkrIvS+7qSss2X0B/YPbbCBeNkXXFb4SmrSKbF4ZKXchOTiX073xPvv0?=
 =?iso-8859-1?Q?gPzFWrCXz7xvlBTE1uqH2yuo9mlvQY3VUUw1uQM31d3pyNBkvN962UoiwL?=
 =?iso-8859-1?Q?J9etHfYQevR/6DNEZ3Rut6nOgcTacdhor0Pxa3Vo7BFIWJ2WKeYh8OqBY2?=
 =?iso-8859-1?Q?90GXh8BCmzRcle3ChV/0awMs48ibOtLhHmXa//TXWvut15zoSgoqFqIocn?=
 =?iso-8859-1?Q?Ex7thQ4ftcKloJQs/Fxad9vkGmLxT/4STNbtIlBmVKsIRZvT2matciOrdX?=
 =?iso-8859-1?Q?yvfhSvz6Dl1qXUMBJbatHSvGw2vFq0ArqGbxYc9zMtZ2fDMw7SzWns7HBb?=
 =?iso-8859-1?Q?KDtWRv9yFUpU+qHeEV5fSB8sHfSKk2T0Ukm5ZgmkA8GQVC+emN+9dmQT2A?=
 =?iso-8859-1?Q?YZ+3CA+J464W+2DeelwpeFAO8y3LfWBxqAdKV9MV2bmRExbYcbrmZOaiHv?=
 =?iso-8859-1?Q?eb3uI7nPcAJ5yFzUhBKaNqlFGWIR91bwBx4TGLX6rQ5cXpR+baCf9HHKbV?=
 =?iso-8859-1?Q?7/Du5meEUjUir5agMidanGpzwZRUl8vgj3OwhkkX4oWaecjuvt3RzBn326?=
 =?iso-8859-1?Q?bOLkMgAum/Wkd/3uQyRKnXLB3sf6ZMwKCb7svIRJQ5hegfa3ijQjD/HPZL?=
 =?iso-8859-1?Q?MiPbUKRmm/QDe3vTUunv36d3sBTLz9/UYghBHMYub6yJRaKel5IIGEqKyQ?=
 =?iso-8859-1?Q?+MSxW4EfyWDrs0LqqjkCqaV8LtRVTYJ0IeWeuFwhTMJ8SvTL6avJJ1Mow0?=
 =?iso-8859-1?Q?tXF/YhUPzWzk4o48J7N0Jd2noEwQ4cwbM+DDajqZBtG993j2i0fBG+SjWa?=
 =?iso-8859-1?Q?WmVvx7UeNnxkWD8eJihGgyT5HqzbnpxszdBJtY7Q5/KMujsnDb00fB56rq?=
 =?iso-8859-1?Q?yQ6AHtjKE+7Xq2ynpgjVM86+ZcZ1ufVZQVawQqMVjLpewngnYWEl6zqjK0?=
 =?iso-8859-1?Q?PvJ64QV18YbV5BbyU9Zf7XQ5cM3t0o6TS7BkhLL1aAGu+7PdrTWeS9HE3n?=
 =?iso-8859-1?Q?gnhrW2Ffy9Mat81ikFVZMzdIskydMBc/hABGtYK7DJ0zRGIPZIdOSUrB2d?=
 =?iso-8859-1?Q?bzSlPh2quTM2ZCqCD0yfpa5NQNxsAiJ4Ozl+uzTTNh51Y6USSgRKZLi6K1?=
 =?iso-8859-1?Q?bzIISpwL1eQYqYtsaA5o/3fAjO8UVpNT+gSIUh/+GgoGms0rXcDKDfYGpk?=
 =?iso-8859-1?Q?eN+02OZ0KBlz8710w+jMN4y9rCAgf6/8+YiA8fB8DCSZLB199W+4MPEDPr?=
 =?iso-8859-1?Q?01+XaAzXsrMziSBe1v6gIaJKn4HJWmMP97usnG9WlyYMRyrgJtq9AqdPSE?=
 =?iso-8859-1?Q?pMQKltF7F2RYNwdbkXwqQyI0LzCTNMfjUWtC6tpm47woBkvyYSGgjG97VL?=
 =?iso-8859-1?Q?Y81kGJsWKM2/ZQEsdINsAVOa3FSRQJf0k13g7EG/Ct6pDzkF82OKJtkLxd?=
 =?iso-8859-1?Q?UxShtQI2vqVmcvzz++ZJOX7zSrIZKOdnAViO03l8azdYmpzrHe34Jji4qj?=
 =?iso-8859-1?Q?312slAwfmZDWbETFCtP1+u64ZuLqs2hSfu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84469d8e-f391-40c0-2ae1-08dabd475713
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 02:58:52.7391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xlthdFCZJhU5RHN2/SPHsibg9g/loxt7bIdo1EYKG8aP/4TUqJYtw9cD0RLhD8RCe0vNtQHr7xj347YXoCfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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

>The bad news is that this series still makes some things very slow. The mo=
st extreme examples so far are glxgears (runs at ~400 fps now, ~7000 fps be=
fore, i.e. almost 20x slowdown) and hexchat (scrolling one page now takes ~=
1 second, I can see it drawing line by line; before it was almost instantan=
eous). I suspect this series makes the overhead of running a single GPU job=
 much bigger. On the bright side, I'm not noticing any significant intermit=
tent freezes anymore.

Hi Michel,

Thanks for the trying.
Is there high priority jobs running while executing glxgears? I am running =
glxgears while submitting high priority ibs using amdgpu_test, the fps rang=
es from 6000~8000.

Continuous preemption and resubmission may cause the slow fps. Could you ha=
ve a check about how fast the trailing fence seqNo expands. On my side, the=
 increment of Last signaled trailing fence is < 10 in a second.


cat /sys/kernel/debug/dri/0/amdgpu_fence_info
--- ring 0 (gfx) ---
Last signaled fence          0x00000001
Last emitted                 0x00000001
Last signaled trailing fence 0x0000013c
Last emitted                 0x0000013c
Last preempted               0x00000000

Thanks,
Jiadong

-----Original Message-----
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Wednesday, November 2, 2022 7:26 PM
To: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Huang, Ray <Ray.Huang@amd.com>; K=
oenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)


[ Dropping Andrey's no longer working address from Cc ]

On 2022-11-01 11:09, Michel D=E4nzer wrote:
> On 2022-11-01 10:58, Zhu, Jiadong wrote:
>>
>>> Patch 3 assigns preempt_ib in gfx_v9_0_sw_ring_funcs_gfx, but not in gf=
x_v9_0_ring_funcs_gfx. mux->real_ring in amdgpu_mcbp_trigger_preempt presum=
ably uses the latter, which would explain why amdgpu_ring_preempt_ib ends u=
p dereferencing a NULL pointer.
>>
>> It's weird the assignment should be in gfx_v9_0_ring_funcs_gfx instead o=
f gfx_v9_0_sw_ring_funcs_gfx.
>>
>> [PATCH 3/5] drm/amdgpu: Modify unmap_queue format for gfx9 (v4):
>> @@ -6925,6 +7047,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_rin=
g_funcs_gfx =3D {
>>         .emit_cntxcntl =3D gfx_v9_ring_emit_cntxcntl,
>>         .init_cond_exec =3D gfx_v9_0_ring_emit_init_cond_exec,
>>         .patch_cond_exec =3D gfx_v9_0_ring_emit_patch_cond_exec,
>> +       .preempt_ib =3D gfx_v9_0_ring_preempt_ib,
>>         .emit_frame_cntl =3D gfx_v9_0_ring_emit_frame_cntl,
>>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait, diff --git
>> a/drivers/gpu/drm/amd/amdgpu/soc15d.h
>> b/drivers/gpu/drm/amd/amdgpu/soc15d.h
>
> Ah! Looks like stg applied patch 3 incorrectly for me. :(
>
> I'll try and test with this fixed this week, and report back.

I'm now running with patch 3 applied correctly, and with patch 5 as well.


The good news is that I'm now seeing a positive effect with GpuTest benchma=
rks which are GPU-limited at low frame rates. In particular, with the pixma=
rk piano benchmark, the GNOME Wayland session now actually stays more respo=
nsive on this machine than it does on my work laptop with an Intel iGPU. Ho=
wever, with the plot3d benchmark (with /plot3d_vertex_density=3D1750 on the=
 command line to increase GPU load), it still doesn't quite manage to keep =
the desktop running at full frame rate, in contrast to the Intel iGPU.

The bad news is that this series still makes some things very slow. The mos=
t extreme examples so far are glxgears (runs at ~400 fps now, ~7000 fps bef=
ore, i.e. almost 20x slowdown) and hexchat (scrolling one page now takes ~1=
 second, I can see it drawing line by line; before it was almost instantane=
ous). I suspect this series makes the overhead of running a single GPU job =
much bigger. On the bright side, I'm not noticing any significant intermitt=
ent freezes anymore.


In summary, while the benefits are promising, the downsides are unacceptabl=
e for enabling this by default.


--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7CJiadong.Zhu%40amd.com%7Cb15fb94893a247d734ff08dabcc5265c%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C638029852189066953%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3DawC3VH4zMdZGK9ayi8V3goI%2B%2FEkj0%2B2LL2VokYlLXSk%3=
D&amp;reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer

