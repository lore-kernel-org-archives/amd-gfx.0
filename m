Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDF5CD6910
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 09:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A741710E129;
	Tue, 10 Oct 2023 09:25:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB41A10E129
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 09:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJB4UjBNJCIs9o9GHB3lPCUqDkLmb6BT7DHyXTgYirDBySiVfXOcwXVgGJTscLgQGx0G3KAQlqAkoFnbQEkJHrisnB7jyiY6K7d6PzSyx+94JMVy7J8o3/ydh15RGHxsl5tF3RnH1jfnGXMV/yH43mA7zeE1p3fup7dMwbutOk3rhOqmOtE5aDe+CfsJbo8c+A1vxfJMINS5siiBCLP3V+5L+jm24nIYyJQbm82RcX2XsTqPTqtgdqNs7IHpuMPnDa9OW9FM3bqyrjq3pZVYywywteLADQKaZC+lhxHrwPB9oxVLFK1adNSluM46/+9YSh8urdxYye4PbV9JzVYIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=575CGTP5Gk023k1dsw/L7sr/W0V+PEwHF7a07IXZH10=;
 b=NGUGYtDIOzDpuodd72SdgklJJRU8rarfKrIPZDZseGUmD98iW+d3mAIzoEReFgqnjmYtXnzfriARKNiA38wNlGhZTpe8BZz2rtc5vKowj9vGhfov2bpLODmW8F5FQnthXPBGwswhSpMryBz01bpR9zsbMGI3dUcuNhj7wmZEqIgaPag4LZzRxZJ4LcJa7fLYnC2tWX/C4cMCfDDrsKUG0rPPM1wpR6/g+E4Z0lVFTSJ1TMAG8BMP2yu+e/6mRjdVzCz/m4T/tjSt1MozmAli0pqJrD8lLSjGzUtICcDbd25Nci7lq0EG58tgyHvUku+56IhynDBepLgd/xOye97P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=575CGTP5Gk023k1dsw/L7sr/W0V+PEwHF7a07IXZH10=;
 b=OATsNPFmzbvMDm328Ws0Zr+m1ODlhHCEeOKZiLYrwkERU0PFr8e4hsqlpwgC+EleqJZZoZrYV1H/wLlXU1OZ2eqBt3H5tzJOYMHMK/eFO6m0Yu0HNnRpSi08gnAQzpWCu8VWCATCI3NwVpUB+K/Oq123kUJ03fTE5M6lFv3brP8=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 09:25:03 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:25:02 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8qZ0SmqTbiB0uJBjZ5G/CDQ7A/5QOAgADKnbCAAHo7gIABGubwgABm6FA=
Date: Tue, 10 Oct 2023 09:25:02 +0000
Message-ID: <CH2PR12MB4152AA672E37C965D09822A0FECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
 <BN9PR12MB5257442EEE0BB34C24F1A8F9FCCEA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB415201DE77642C298438B4ABFECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB415201DE77642C298438B4ABFECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c646e2ba-d647-4c22-85a9-510e3ea61461;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T01:40:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|MW4PR12MB6873:EE_
x-ms-office365-filtering-correlation-id: 020ce334-273d-4dd1-db77-08dbc972c84c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CaT1veTuIMXZqBlgEojlGsYQud/Ql1LUHX14BfQutlwAyDSHv+mJo2pDavTfi9rByxzBnuuoT9S8bjmi+8fMG/ReA69PxDenIE36wRYgyA/PmRBl/BB+7ArYy6Ws1n1myfTN8XckIorllF6Ii5V9sZ6RgxGJITcugzKyIymdyzTPQ4ZJps5AoO/2HAJm+vojn4a206PBgZfQhNdEGHiVr7Fcz1wR1cFXNK1UsskwA4d3qKRTlyz2EfulGqED8OfT6InuToc9e2g8XE2jySHTUBHcmRbUs3y/DtXWyaeOVbLqrAxSlJMA+Qzmwrcp9EwjCyFJGpLhUNshPCjF+xKFrnHKIRVoorbm3NXtKfX8ZqFunEi8ggRdeFy4orhqJcBFjmbb+8cq0++H8drQw/CAP+y0H88DYrHKhqDcklYUwyLrxmnT6mNwmqosikVDBcoNr20w0h0V6pLJvuDfzHmdAAE5KLqDLo+oS+WIv5eqXLK+JeVstptKAulVzCop9B/lDN+hYRcRZNC39ervgqDtIp8gbJOlFQ5NR3FuzqKKuXYd/yqjqR/XgNDDYe33WWyBEWpoeO38yjtCWMcP5I68QcVV+ofMUHpCA/wdlvRbKVwmy0HOccotjpi0wdsleAlz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(66446008)(2906002)(2940100002)(83380400001)(6506007)(76116006)(26005)(316002)(66556008)(110136005)(66476007)(66946007)(53546011)(64756008)(8676002)(52536014)(4326008)(41300700001)(5660300002)(8936002)(71200400001)(478600001)(9686003)(7696005)(33656002)(122000001)(38070700005)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ylFSAQcFXOinykdt3aYGSLE2DeMOFYQ5pHyNoXFynEcziO9xvXH9BZFutZ4u?=
 =?us-ascii?Q?KWFOiD6/2ZsBdJ0eWMoc3u/E8iFg3MFzfmlE5X6p/ppSwZHViJfOCzuFVeRM?=
 =?us-ascii?Q?WajmojXRcKlNiMmRKfMFkx/yD/LgNXt4myi0G6OrHjVOjb8OIFi0C2t5ocS8?=
 =?us-ascii?Q?dd/fKlUDW2FRv4qOZaQ9xFvwf0CnB8joBURkKk5tR61Enaxkbhcqnt+Cw7kg?=
 =?us-ascii?Q?KzP4tnLRtzPap2crBcqB80cQ91wDonuVah45UgK741UVG7qyDcBIK+O6mXbk?=
 =?us-ascii?Q?MjO9uXMN2YLLVpnsOdBJU5bfrbNYz24xQ7SKveIO9tm58aJme6oaFxcp6JEe?=
 =?us-ascii?Q?I0V+gLlxj1OFeMekh1QLzyvvkKlMop8EvkErHol0ax8sT5odnZt3Bfo5GW8C?=
 =?us-ascii?Q?dLujVR9872rIbMUWGkvCkBuMLsBRD7XETl6/YHJ5owd42Xkkwwt7uwypIAoE?=
 =?us-ascii?Q?tKvoguTWwrt+QrIrMZlZ7AK2s1ywvrrUTMnCDW058uzKJQJ8VxVT6U1KT1Hf?=
 =?us-ascii?Q?LxoPAc7K6YGROo10kzD6Nn0ljGih06qSFgTcCwexKWn5U+Dlc3kfFmb5rmpp?=
 =?us-ascii?Q?N8jlHoQ+48uf1wX79d537Uj96jFGN5/SV+ola9Qo5q+Tgqwwfye7ky7DwfjI?=
 =?us-ascii?Q?Ccs1rj2o0Qyy7JQ2/SVxwpAZd+awfiFUGyL4pIuX4OzTgNvS/Yutj2hqHSOC?=
 =?us-ascii?Q?V1NP1JnlgnJi/KoC28lrJ9TxdM3SCYQQmrFMTwpP9A32uusRW2Gdf5Q+DntI?=
 =?us-ascii?Q?jToQ5VAjhnyKwe5JYej7DEm75sI4P2JUyEYYs26AQCG2fX/30CBe/L3U2sCb?=
 =?us-ascii?Q?a+Hx11XZ3rUiVVxbcH8PBmUdhYqP9hmDG/PAH6ILbBGCaB2xdgXs/qx76Ujl?=
 =?us-ascii?Q?mjFY8qhF7522gwSHkn7g8YxtZ+gfSNCoQD810clqGLu0v03DlbUQVW/aPbKl?=
 =?us-ascii?Q?c6ADzTU93MSX71pG7JS5A2q6se8N3Zq3NV+oCKj2lv7FPLETRGijVqqc3hWm?=
 =?us-ascii?Q?5niIIpb+OUIHaROEUWik5UP+J932mfEYsLu06kZ0m98/ED8qNqGMdChPpgnE?=
 =?us-ascii?Q?UTKRn7g2P4O7toXt07rXmzGKqWqJzHjjmzlbN80Wfrhfs9d74Va706WbAQEU?=
 =?us-ascii?Q?o/79uRxJIBe5wsFZTgBhjWgk4IDMGEvxFlNztUnUlbkXYP3XbWgKFJKAdnv1?=
 =?us-ascii?Q?UFHiqA8GVM68Vn2+JNDST101lvZZfJl+EOmVpmzpCrzPuqCxBTmOvbX/x+A4?=
 =?us-ascii?Q?3a5re9RZziHET37mFIuiS6uwkRUC082BawgbfSo7g7nw4EVzdLRYFQB13w30?=
 =?us-ascii?Q?3pnjh2NvczyPOkNWjL/2f9Bag4SAmaM/tcYfRSUzxJDyg9e6isHqPFGyT9Dg?=
 =?us-ascii?Q?5Wj3cuurWf/cceF4+KyzmlenpYAw6Vju7Lc50zBf+sNB2+X/0fN5ux1CF5NG?=
 =?us-ascii?Q?ee6Yw4NTMBwGXrHGjNce9dpYcxbqCouFg1sB+f294HaXFC2Dze5dvnDpDIwH?=
 =?us-ascii?Q?Zmd1arcDqsMxww4LvOCFGJSBEPlVViO8/fzwHG4qtb/9MhdqkM+QPzWm/LNG?=
 =?us-ascii?Q?9S2KVfe5jMtxrXoG5i0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020ce334-273d-4dd1-db77-08dbc972c84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:25:02.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUvcLop8vIUiZJgoIIVAI8Z1AbG+3crlhgz6V/nFZ/NwPw9o8spznzP3O5F0q7so
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

If gfx is not power on, both check will return ahead. The logic will not ch=
ange.
If gfx is power on early in resume, tlb flush in the IP specific (gmc v11) =
callback will never be called because it returned ahead in the higher level=
 check in amdgpu_gmc_flush_gpu_tlb() :

if (!down_read_trylock(&adev->reset_domain->sem) && //--> true in gfx11
+!adev->gfx.is_poweron)         //--> (!adev->gfx.is_poweron) =3D false in =
gfx11, and the whole if statement will be false, not return ahead.

Thanks,
Feifei

-----Original Message-----
From: Xu, Feifei
Sent: Tuesday, October 10, 2023 10:28 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

Yes, adev->gfx.is_poweron check will be applied in gmc_v11 callback, which =
will be called after the generic gmc part: amdgpu_gmc_flush_gpu_tlb() funct=
ion.
But in commit: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tl=
b v2"), the flush is moved at a higher level amdgpu_gmc_flush_gpu_tlb() fun=
ction.

Thus the gmc_v11 callback will never be called in the resume because adev->=
reset_domain->sem not released and returned ahead. Adding a check of adev->=
gfx.is_poweron will let GFX11 not breaking ahead, like following:

if (!down_read_trylock(&adev->reset_domain->sem) && //--> true in gfx11
+!adev->gfx.is_poweron)         //-->false in gfx11, and the whole if state=
ment will be false, not return ahead. The following gmc v11 callback will b=
e executed later.

Thanks,
Feifei

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, October 9, 2023 4:58 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

[AMD Official Use Only - General]

adev->gfx.is_poweron check should already be applied in IP specific (gmc v1=
1) callback. If gfx is not power on, it does nothing but just returns. I di=
dn't see how it helps resolve the issue if we just move the check from one =
function to another.

Regards,
Hawking

-----Original Message-----
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Monday, October 9, 2023 09:51
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

[AMD Official Use Only - General]

Hi,

>> Based on your description, the above code should use "||" instead of
>> "&&",
&& is to add more restriction here.  To avoid skipping necessary TLB flush =
by return.
For Asics < GFX11, !adev->gfx.is_poweron is always true (this paremeter is =
intrudoced from GFX11), only depends on reset_domain->sem; For Asics =3D GF=
X11, !adev->gfx.is_poweron might be false (which gfx might already poweron =
in the reset), this will make the if () not ture, return will not be execut=
ed, thus flush TLB.

>> And after merging code into one line may result in the lock not being re=
leased if the lock can be acquired success.
If !adev->gfx.is_poweron is true, the reset_domin->sem will not be down_rea=
d_trylock, thus could avoid this deadlock.

Thanks,
Feifei

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Sunday, October 8, 2023 9:36 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei X=
u
Sent: Sunday, October 8, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tl=
b after reset on GFX11.
Gfxhub tlb flush need check if adev->gfx.is_poweron set.

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2f9bb86edd71..048d32edee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *ade=
v, uint32_t vmid,
                /*
                 * A GPU reset should flush all TLBs anyway, so no need to =
do
                 * this while one is ongoing.
+                * For GFX11, gfxhub flush check if adev->gfx.is_poweron is=
 set.
                 */
-               if (!down_read_trylock(&adev->reset_domain->sem))
+               if (!down_read_trylock(&adev->reset_domain->sem) &&
+!adev->gfx.is_poweron)
                        return;

[Kevin]:
Based on your description, the above code should use "||" instead of "&&", =
And after merging code into one line may result in the lock not being relea=
sed if the lock can be acquired success.

Best Regards,
Kevin

                if (adev->gmc.flush_tlb_needs_extra_type_2)
--
2.34.1



