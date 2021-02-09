Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E5BC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 05:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5299064D73
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 05:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5299064D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF426EA94;
	Tue,  9 Feb 2021 05:27:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E109D6EA94
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Feb 2021 05:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWC1d1YaSCyH8SFulHszVtjlXwirqme+Qja4AtQ2i72L/A2Vsa5sHUyYypy+AqVguqZ73MK7BkBglSS+drGhpZ04abHk71O6XbnBJ8fPUXNFwxirJY5cy45JrdrHPGqph7PjmCg34Bkwaj+ffYwnFs3rULHx8LGiH/STfUqzzcS20rG3IJby8PFVZTJ2xWHlzap4ZO9/k/lcPzxfCvdqbI4xb8UB5bPTeWtXDuy0aMGrbnEg5Twf8+PEIUUmVlRHU0qxho3gfURU8ccjSe+AevVpIkqLJe813iOc9McNSRNBVFjA9rLQpjbTYSJWwDiSl2W8ECNXXW1OKw5Vw91qzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC0x0w/tkHfkcoSkl0cmftze7yKd+5nbvWv/x5fsW34=;
 b=B5+UGvuqg8x5jzSljbuL/2F5iqgt4yMiD4sAB6PRrqxuLSn/RZeEwp5u0xcQJXKqJt1l5xoZmfDUpCXEkbaks5TP5nI7VFdL7gLIda03GYiHZetEui/gMbfKy53sEfogWWQnG8oSXVg1xLZLQOCOF8sfBqtzxt9ZqCE90C89kdPGrHeolVJEGOnByEi7hSaFQU7Wp6nGiwanHy5/Z7mDlyvVHgcTe74pjlqW2mzOr+TazgM+nzL3GVzOu/epPUPvPZjnPRxMrs5d6TwcjOo2XgDOE08q77kE6wWa2NvDyN2YPA2+XtqGv3QJLNRvp9sk0zYKKchKI05eQA74aIxJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC0x0w/tkHfkcoSkl0cmftze7yKd+5nbvWv/x5fsW34=;
 b=1bxO4+KsYem2iH6ymoTfj3aVFYpWuM35sf/LxahcAWr2VPMVIuqSRP4lwIE4l1boB21chlXrnyBUS/oRakv1kUu6rlXsOQoX5c0ZnGS7ztEudOIQ2OFTPipNUvULkVOhOt7vuut7iIZp6OcCR2ZihqCUsiIfSWkk6BgTLyQFkPU=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3120.namprd12.prod.outlook.com (2603:10b6:208:cf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 05:27:26 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 05:27:26 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Thread-Topic: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Thread-Index: AQHW7t8VR6rBx2lk/0WnCdCvinoRZKov5B86gB9xQQCAABSDow==
Date: Tue, 9 Feb 2021 05:27:26 +0000
Message-ID: <MN2PR12MB30225E137752C5FBF8B5D6CEA28E9@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210120034821.15400-1-Xiaojian.Du@amd.com>
 <MN2PR12MB3022DF9FACBC945BA0E7750CA2A20@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <MWHPR12MB1248C40D2A09B5DED1C179F5EC8E9@MWHPR12MB1248.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB1248C40D2A09B5DED1C179F5EC8E9@MWHPR12MB1248.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-09T05:27:25.680Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c69a01e-f024-4c43-1bb1-08d8ccbb62f5
x-ms-traffictypediagnostic: MN2PR12MB3120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3120CA67668534DA370B67AFA28E9@MN2PR12MB3120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/VUMn5+Cp9EJHST3OFNnBD+4Ex3ScDS9rCm1aYgWZyMBdmbp2TdaRxs6fSgyq1Oin/KNu2QvL2WNLBpl+nUZReBZT9jNRXPNc2REmQjTQxWgM+5l4IFd9Co5T/wVZIrTgNCKIhln+Ky0WcNuhS7ULvlWnPcUuCm4U21QpdOwpROUs0Ts6n8fy4BqX/HnnNWPhkpSRr3fxkE55CoddakLBVLt+YLqB0yAdpC6hAosAs0R8YLMTmbs2wYDJ4OFRiZkeg2d5vWwj3+10r0dUBZ097wGsr9PBDBIG3HybE9fbfOPLD3kc0hmOH8E5oTm9F9Jan+K4NiuA4DLN1zHyNkEzNf0zNbW6FpmW7HDYoKofj939x5uQN2ERtQQwj55jXeVn5hNIQvZ8i4IucevO5wxPj+LoGKY7AceENIVMXgbMjnmJ4A4Kfc50r2wx4+qUY2QLTFO2WOM0kPL9ltwfU1u+RX0l74wKRJZ5zPdf3qnG0TNIojUMwKNjNBoXSYejbPfm3LD5/WQX1YSQ3n2eTC3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(7696005)(52536014)(83380400001)(6636002)(76116006)(66446008)(186003)(91956017)(2906002)(66556008)(64756008)(66476007)(6506007)(5660300002)(8936002)(55016002)(53546011)(66946007)(33656002)(86362001)(54906003)(110136005)(8676002)(26005)(478600001)(19627405001)(71200400001)(9686003)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?6eJZl0EZTlzcipKNz0XeIhAA/p2tMT5h3rXH5NgLlFrlkML2G0hSbbMq?=
 =?Windows-1252?Q?Z8SWK0ZXlRsz3z/3JzbPINTWs5Q9Xg23glymLjZKuhpIMWecwLp7PPtg?=
 =?Windows-1252?Q?QKndC2qhUcm67VASwpZflk2iRMZ80ON/2tELTQtJ96EPEIyp9ylXeZ+i?=
 =?Windows-1252?Q?ep2zpO2TJzDCBk0SGBhpBQcPKIBHxbl0ugOEExu4nAXyGtYCY4F8pWMe?=
 =?Windows-1252?Q?BDClpcuSTpkVPZWE1sFRYq8FxR77Epr5kN3tatgIVotUvhWgK2oW/MxO?=
 =?Windows-1252?Q?InmYEV9l0ubPH/K+jKFVSKH60KbjD4Qe4gs11GJd+J7lZ0SAiHUkSOLC?=
 =?Windows-1252?Q?V6i8czvN3N0VAKNsmnLNgIOiCbXbMAjbdOCMDRPxpfFc9vSgNB02rREd?=
 =?Windows-1252?Q?Dz7h669fLDSsoJb0CPOq7tRsB3NnPSQm+eQJt0OESH9iUaFYyzju8O0Y?=
 =?Windows-1252?Q?NmCnmMc5Bya9MghKGWDaxyw4q6wIqKH2Wxjh2U+NNsQAKD9EmbOlrPSq?=
 =?Windows-1252?Q?d5MQeRTEv5QWSEKSHYXLnISjZqDn50pNwy4dtCv41ilLEev3bWp4RG0K?=
 =?Windows-1252?Q?q7rHeFdprZl1fzc1eJ39czXagx2hPdsRGIo4hFlGOoBSprJ3pvz3V4bs?=
 =?Windows-1252?Q?51QUF/4v95O/k8KG+qaDnzjlaM8LOnsLA2HScL8EDd7FcL0CNwszU1KD?=
 =?Windows-1252?Q?DNxBti0Fphj/mTtXnMcy0blA5GssTuLs0rvOg4Zg32SL01SC1dVSRjOc?=
 =?Windows-1252?Q?yZ0r29RvlMXL9QgMMi2xPY3AdsY3hPjZKRbSvM+whue9Fxu+/oLy6po4?=
 =?Windows-1252?Q?KuSP4Rl84dNJ+HtUQieyson6dJGTXyzR04q5sScCCORRyz9YeI6z4yyD?=
 =?Windows-1252?Q?is9qmk8gqan0qk/1/1wqSWzY97guYH7lKKvP6PEWnqR6XCswdnsNe+K7?=
 =?Windows-1252?Q?3iP+p+fw50Un+5M67bEeO96Yzjv6MBQFcbajTCbFR7bSZuclU6iFMDoj?=
 =?Windows-1252?Q?MGNyJFVCRKoQfjg7UZoHTie/kLsxH+zT6AwQ+9xtQlMfSnsYhES8f0Iv?=
 =?Windows-1252?Q?MrR3LVQPOKFHIKeo0MUFCL5UYk0pWCe+8I1U3ZWEtRYBt4jBZ06H3wc+?=
 =?Windows-1252?Q?8uuKqFbUYhE29gLSEbUheZMueeSvQLf2DGcD/kns/OpGet/2IewVknpU?=
 =?Windows-1252?Q?ePP2k3k4AzXLYl9/KJC8hVPQllbRnH0PIqeiQcTnOJ7Dn+Oimudbe8pl?=
 =?Windows-1252?Q?OQizdLAK8JeD9dqUSCh/+jTPaBryQzONRxDTYiK5gw+Wt20MimYdmld2?=
 =?Windows-1252?Q?su6XKPU/ARJLUbHMKVBVSHpnybhSY3D+7HMwQnpxVmPwZKMXLTHIAIfE?=
 =?Windows-1252?Q?cu9XHbYhMg7Ox9ZCkKr+J48T4WA7yqowYFaLfax8/2MRdfFpR38xq2/t?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c69a01e-f024-4c43-1bb1-08d8ccbb62f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 05:27:26.2657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGXu0x/2txyDg7C8eNY+28vfPxu2MlKJFru1FCUDBO+J7Y8AsGIUBxtKkap7mjjg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3120
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============1955140108=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1955140108==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30225E137752C5FBF8B5D6CEA28E9MN2PR12MB3022namp_"

--_000_MN2PR12MB30225E137752C5FBF8B5D6CEA28E9MN2PR12MB3022namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

If it is not in manual mode, we should give the user a hint.
if possible, we should move this check into amdgpu_pm.c , it is also can be=
 used swsmu backend.

the patch is
Acked-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Tuesday, February 9, 2021 12:10 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: make the error log more clear for fine gra=
in tuning function


[AMD Official Use Only - Internal Distribution Only]


+ Alex



Hi all,



Recently, many users reported the issue to us that fine grain not enabled. =
Actually, most of them are just caused by not switching to =93manual=94 mod=
e.



         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");



We have to need reminder in the warning message to tell the user where they=
 are.



Any objection for this patch? I found Navi series actually didn=92t need th=
is operation to update max/min clock levels. Would you clarify whether dGPU=
 still needs this before we move the prints into amdgpu_pm.c?



However, in APU fine grain design, patch looks good for me.

Acked-by: Huang Rui <ray.huang@amd.com<mailto:ray.huang@amd.com>>



Thanks,

Ray



From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, January 20, 2021 12:10 PM
To: Du, Xiaojian <Xiaojian.Du@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, =
Lijo <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make the error log more clear for fine gra=
in tuning function



[AMD Official Use Only - Internal Distribution Only]





________________________________

From: Du, Xiaojian <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>>
Sent: Wednesday, January 20, 2021 11:48 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Quan, Evan <E=
van.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Wang, Kevin(Yang) <Kevin1.Wang=
@amd.com<mailto:Kevin1.Wang@amd.com>>; Lazar, Lijo <Lijo.Lazar@amd.com<mail=
to:Lijo.Lazar@amd.com>>; Du, Xiaojian <Xiaojian.Du@amd.com<mailto:Xiaojian.=
Du@amd.com>>; Du, Xiaojian <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>=
>
Subject: [PATCH] drm/amd/pm: make the error log more clear for fine grain t=
uning function



From: Xiaojian Du <xiaojian.du@amd.com<mailto:xiaojian.du@amd.com>>

From: Xiaojian Du <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>>

This patch is to make the error log more clear for fine grian tuning
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,
but only when another sysfs file -- power_dpm_force_performance_level is
switched to "manual" mode, it is allowd to access "pp_od_clk_voltage".

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>=
>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 88322781e447..ed05a30d1139 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwm=
gr *hwmgr,
         }

         if (!smu10_data->fine_grain_enabled) {
-               pr_err("Fine grain not started\n");
+               pr_err("pp_od_clk_voltage is not accessible if power_dpm_fo=
rce_perfomance_level is not in manual mode!\n");

[kevin]:

for above codes, the old one looks better for me, i prefer to keep current =
design.



Best Regards,

Kevin
                 return -EINVAL;
         }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..a847fa66797e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");
                 return -EINVAL;
         }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..4ce8fb1d5ce9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context =
*smu,
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");
                 return -EINVAL;

[Kevin]:

Just tell the User what's going on, not why.

and we'd better make a function to check manual mode , then embed it to eve=
ry sysfs node in amdgpu_pm.c

using a unify interface to return result to user.



Best Regards,

Kevin
         }

--
2.17.1

--_000_MN2PR12MB30225E137752C5FBF8B5D6CEA28E9MN2PR12MB3022namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div>If it is not in manual mode, we should give the user a hint.</div>
<div>if possible, we should move this check into amdgpu_pm.c , it is also c=
an be used swsmu backend.</div>
<div><br>
</div>
<div>the patch is&nbsp;</div>
<div>Acked-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div><br>
</div>
<div>Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 9, 2021 12:10 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Du, Xiaojian &lt;=
Xiaojian.Du@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar=
@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/pm: make the error log more clear for f=
ine grain tuning function</font>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+ Alex</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Hi all,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Recently, many users reported the issue to us that fine grain not enabled. =
Actually, most of them are just caused by not switching to =93manual=94 mod=
e.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
We have to need reminder in the warning message to tell the user where they=
 are. </p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Any objection for this patch? I found Navi series actually didn=92t need th=
is operation to update max/min clock levels. Would you clarify whether dGPU=
 still needs this before we move the prints into amdgpu_pm.c?</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
However, in APU fine grain design, patch looks good for me.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Acked-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com">ray.huang@amd.=
com</a>&gt;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Thanks,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Ray</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
<b>Sent:</b> Wednesday, January 20, 2021 12:10 PM<br>
<b>To:</b> Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: make the error log more clear for f=
ine grain tuning function</p>
</div>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]=
</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in; font-size=
: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Du, Xiaojian &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian.Du@amd.co=
m</a>&gt;<br>
<b>Sent:</b> Wednesday, January 20, 2021 11:48 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Qua=
n@amd.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.=
com">Kevin1.Wang@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Du, Xiaojian &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian.Du@amd.co=
m</a>&gt;; Du, Xiaojian &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian=
.Du@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: make the error log more clear for fine =
grain tuning function</span>
</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
From: Xiaojian Du &lt;<a href=3D"mailto:xiaojian.du@amd.com">xiaojian.du@am=
d.com</a>&gt;<br>
<br>
From: Xiaojian Du &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian.Du@am=
d.com</a>&gt;<br>
<br>
This patch is to make the error log more clear for fine grian tuning<br>
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.<br>
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,<br=
>
but only when another sysfs file -- power_dpm_force_performance_level is<br=
>
switched to &quot;manual&quot; mode, it is allowd to access &quot;pp_od_clk=
_voltage&quot;.<br>
<br>
Signed-off-by: Xiaojian Du &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaoj=
ian.Du@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp;&nbsp;&nbsp;&nb=
sp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 3 ++-<br>
&nbsp;3 files changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 88322781e447..ed05a30d1139 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwm=
gr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu10_data-&gt;fine_g=
rain_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Fine grain not started\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;pp_od_clk_voltage is not accessible if power_dpm_fo=
rce_perfomance_level is not in manual mode!\n&quot;);</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
[kevin]:</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
for above codes, the old one looks better for me, i prefer to keep current =
design.</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Best Regards,</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Kevin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 6d3c556dbe6b..a847fa66797e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index ab15570305f7..4ce8fb1d5ce9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif; color:#323130">=
[Kevin]:</span></p>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif; color:#323130">=
Just tell the User what's going on, not why.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;text-align:justify">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif">and we'd better=
 make a function to check manual mode , the<span style=3D"color:#323130">n =
embed it t</span>o every sysfs node in amdgpu_pm.c</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;text-align:justify">
using a unify interface to return result to user.</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Best Regards,</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;margin-bottom:12.0pt">
Kevin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.17.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30225E137752C5FBF8B5D6CEA28E9MN2PR12MB3022namp_--

--===============1955140108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1955140108==--
