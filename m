Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E018DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 03:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED5B11B386;
	Fri, 10 Jun 2022 03:15:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7102C11B386
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 03:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChcvS/c0hKfOWjq00wPyLZR3jEPiIaSOXClhuNSu3Hheoryh1mEuuHC8CXYzK0fIxOAbSKhmctmVqj0nL8gC4A/fvGuBBi8OBpE/iZI8RescMIRdcovodZt4XJnnMNw2Vvj/gGHbY3smxoLIWFtq68gSDu+mW1KOhZvza/dzPcmsoHH9ReMLHw548NR7S7ETUkvYp5vr/0M6Qzt/39diZpymr7wcG7t23WCa+A0ACV/yzQLR0bqivHzPp1PbB/fsrT52sfp8IeZ2UKxtlqDRd3hspEFujDBFn4XwX0k60lzxmzz36HuO0Ej7eiWbJWLNn6huVQCLNM11pEu7Uze9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeX/1b9fvJu+yocqrwtLrH6nbDj+9vdeEZYZxSgZv2A=;
 b=UOwXIVyfsQ1v7Wj158UMd+1Cqkt9AXDweBn7LJu+yLKzQ9FBvSZ1qRbxk9wLc36C3SgUD3Tz5lLxN/VawzrRnUZ2WKxUCSj6F+KePu5lgAj0GRwOCRYrRpwW+PW01mRTI2cgmSRkrRbG6iTSTsDpxBm7+swqUqphNfxKGJwGV5ADmNJw+wkz3VGr8kjeSoWViYH4btE7oxh7fansggysqFQ96O6wcJ9V/H25mZQwwbQ/Y2/sCvYnLuWuDrT7j3OqwjxjwaRDPx2nnjcE0XNnlXtrzdcN862j4ah/GdljcHJ30ni63ZDDuy4tsqMI3cB9win0k2LsqWBw+iTlO4UnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeX/1b9fvJu+yocqrwtLrH6nbDj+9vdeEZYZxSgZv2A=;
 b=gHx0tqaIc+dStg12pY61kEH+nWm6CFjIrz5vWO/9gmke2h9FW93EcuA+bxx4p5Q8g8KyPBQXO/5E8DvpnJo9amOFExHeUEItZ9KwSoqwZE7WKbKPlua1++6WqIhVBF3aPrelT8HWoCpc4PIpQ0P8jNv5Ld96Hzgniaho02klJso=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 10 Jun 2022 03:15:19 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5108:cd17:1f53:8f88]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5108:cd17:1f53:8f88%7]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 03:15:19 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue for
 smu13
Thread-Topic: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue
 for smu13
Thread-Index: AQHYe/TIhkq+4Q4Vr0Ss97/driNMA61H8xMAgAAFb4c=
Date: Fri, 10 Jun 2022 03:15:19 +0000
Message-ID: <PH7PR12MB5997EC755C7D359CDFDCDA1182A69@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220609113255.2124596-1-KevinYang.Wang@amd.com>
 <DM6PR12MB26192F91D5F6917C4399C0F4E4A69@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26192F91D5F6917C4399C0F4E4A69@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-10T03:15:19.701Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 203a82df-03c8-4eff-0099-08da4a8f72ba
x-ms-traffictypediagnostic: DM5PR12MB1612:EE_
x-microsoft-antispam-prvs: <DM5PR12MB16124855603A13F6E7174E7E82A69@DM5PR12MB1612.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZYHqstFnXB8v0lFEF1apOCrYni4j1NXvo+EapS0eAY8iY7c/GWxxK3YG3pcQlB2tnMUj7lZIYc97wJAPSQVfs7CMT6TnZGKw10SoOIj0KMJmMRaWpS+js5GGPAAWs8RyjeMCsK7iKwiLrS0eN16P5Zae1imB2AgzjLrI8buj3+UxQIz7I/O9UOE0XfNF+HVP17ahA/VtpMdD2dcwN/HNRTCq7nN+i8sTrfccmTi359XMEzbrNYd7bucbuSHMlwx58OZK+1a6vVMiCm7UwZf5XKJZHHrLog00+Acj8KSZLcz22/WehcVlCE7IOTkaaX9l9sa0EOHZ1am5SVAwRXYFvHu5C6x3awK3nJVmyGFhxSAona/gTbeONmSgWTL0JEQjui/YWy/r9PKbq9nmaLFyoNIoAOkeRTd+D6ncV7nDsqX0tl5CfQagB8EpwW7Z2v3WnezDfLtyTGcD8vWaS1+x95jPnMUyjvNVvi86j2j4aXhWqrFG1ZdV0WfIKO4wSn2mrnZndoviCKJq7fVyffCYXTcxgOjz7YsErzHEcRbKvxFhtGfX4HJmAE/AgPjAUnbbuGn7R2hPoyxf3hmw+d7ojz5jqdH9FNFEmwkXxisWVfyMg3lSx1FoDtyKdgM7ROr1uh9cRA3ojutIXs/R6J/ftHN3k8c9x8mvQnjAwD12BCq3Auv+4RnNS8TZUKy+qtI3Mgae1u0W/q8ntIcZ7kJ3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(91956017)(66446008)(66476007)(66556008)(64756008)(19627405001)(38070700005)(76116006)(38100700002)(54906003)(66946007)(8676002)(4326008)(122000001)(19627235002)(316002)(8936002)(5660300002)(33656002)(52536014)(83380400001)(53546011)(9686003)(26005)(86362001)(6506007)(186003)(71200400001)(7696005)(508600001)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?faYgMpuM2MBOwktrnzyNg9XjRzPVOMK3OadHcQjDeE9x9OBwFQa2eRkqd/?=
 =?iso-8859-1?Q?LSyg/rp9ySMAQ7ubbuKhRl/nHYq94CnFcsNEt9e2bQSBZwSaGfmpKje4CT?=
 =?iso-8859-1?Q?1tbH8dT0qsenPLn1t0vBF0mw2BbxHVuT9eb3zSgswppqYbuDzzrUe1vy9v?=
 =?iso-8859-1?Q?D903o2mzyJanb9Kd2ESbEFdR05UmKp0wK9c8vHJYIAM/VivZ66iVQAb7xJ?=
 =?iso-8859-1?Q?SVYZETQrZrsNhyAVRCWwRTDbDISOsDkVetTSw5q+IFNoQUcdt+vKZkXG+y?=
 =?iso-8859-1?Q?isY1YucH1AefAv31nxnOgkSfMffmvndXMSRUdQ0aD5MC8SuEQ3KeS/qTQl?=
 =?iso-8859-1?Q?zGT7DeaWttJRKGxTYyrbx6R/KAb5GeMY9lVnEf2wxyTz0G8GbjuJZ6L+tQ?=
 =?iso-8859-1?Q?f4eIrprt5umG/WDojMrHAj2kH87Gj2rFsgXOkfJZpsfS0gK/+2V73LtSqu?=
 =?iso-8859-1?Q?uG4vfclTNETj0b0WJDpSatPCFzipMsu2VIKTIa1x3TebhkIaKuMr4VYbSS?=
 =?iso-8859-1?Q?gRbdTmLQohAYxbSJiC9LJ1nvtQTM2J2bie3L9dAa29mVM/XiNuDRBUkCfM?=
 =?iso-8859-1?Q?ZmWK3egm/T9djvoYFXGXaATmBmWMTvUgbmlRdeVW6hX48czrBc7PmxyyMI?=
 =?iso-8859-1?Q?S3qKbJyYj1XivLAPQI94hXg2G7Db21nKi1WuB2t2QJ+z3WPKUFnR9nGMxP?=
 =?iso-8859-1?Q?y/8f1KFRjyDOA+uR8j1fwSaRLx8AaW/F+vCXFaS+Hbq1pWX0mTcJ5rjlb+?=
 =?iso-8859-1?Q?H1iJRj/8KUgseMdj2q2RFDw2d6ME5klJkzvu1wFF40fGKAxk53NjPEdR3P?=
 =?iso-8859-1?Q?t6xq7B2KjB4KL/kPsz3lkw9BBZuMRsZ5zTpbKMbRBHGHnukJ171P4eyZKR?=
 =?iso-8859-1?Q?wmZBEeZiDX9j8L8R6o+z38OH8bJazJ1ZfBVLpM2Y6/w50wQxv903chOnFA?=
 =?iso-8859-1?Q?3f0VHnfvjmde78oIxB45et7XpsbqfWKmvpmvdvv27CvoWqWDy6+qGKmD9Y?=
 =?iso-8859-1?Q?6MkPNFmqP1xYtC4NwCLP28RdC6cIGxRnfyMetW3ZDUcotWYTQCMXehdkYi?=
 =?iso-8859-1?Q?YpZxaqr48j0s22XPaDp/P4HT2imPgmTReJujLg4mZgaxE1Kw9uv935tAch?=
 =?iso-8859-1?Q?PuLeozJICur6IoHfmYUv3ldj1FzlrFlbkXnzp1J5nqrtlm/zNbaXaml+X9?=
 =?iso-8859-1?Q?n17gZtikI7JBMof2cRJDEh9QARDkq4wztd+jFqyetnXnNhd04WNtPvxq2D?=
 =?iso-8859-1?Q?4LvQacPDo6+PRb5bjjNV1552s0bpm98ZGghlh3kXgaOJSadek4ZvTtSQzh?=
 =?iso-8859-1?Q?y/IxW6ze7EdOCb7omtAH2RyCvO7t3lTD7Gqjk4mXB5vWLKWCFZHofmO/vs?=
 =?iso-8859-1?Q?nOzCPscz4drzWZRf2iOLh1nqMfUJaC+/i3Bf239URNit5/0KosH4nVmJ6B?=
 =?iso-8859-1?Q?Fhjv11N81pe1fDd8lZDixylv9GXi4dDCNGYxbg1YG25tEBZ8ilmt62sTGK?=
 =?iso-8859-1?Q?MCWyQ2Pw5Oa0K3xI6uVwQWGFSUZDaYmRuf5ekM/v8Dv1TQEXzsxm6RWZ6r?=
 =?iso-8859-1?Q?SbJORTquHnXKDR/nJixdDL2ZjJGsnBb6hwN0YBYF0My2h0+MFa1mqbNDfn?=
 =?iso-8859-1?Q?KqfPGAfhTLAAmXiGuPFN8yiA93bZPYNyDeKGIPwhyCH+6E561lCKK+GAIx?=
 =?iso-8859-1?Q?mGFcPG9g5sFyY9gsd7ss0HXoYBNL1498AkKhGNQaEQw6zoWJnFl3MfHQeZ?=
 =?iso-8859-1?Q?doLWtyPWlEK+N95revs1WWWmRQRFBUot4E7ztk7AtktKrR?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997EC755C7D359CDFDCDA1182A69PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203a82df-03c8-4eff-0099-08da4a8f72ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 03:15:19.1449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qk0A8NvZl65wlirYTmraEwCsZrX2BCR/lKScLSjtA6mG7UOdE4m3BsQA5lWM6vYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB5997EC755C7D359CDFDCDA1182A69PH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, June 10, 2022 10:55 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue =
for smu13

[AMD Official Use Only - General]

Will this break gpu reset? As PPSMC_MSG_PrepareMp1ForUnload may put SMC int=
o out-of-service state. That may make it unable to serve succeeding reset m=
essages.
Can you have a confirm?

BR
Evan

[kevin]:

I missed this case, it will cause gpu reset fail when do SMC unload.
I will submit a new patch to fix this issue.

thanks.

Best Regards,
Kevin
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Thursday, June 9, 2022 7:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue fo=
r
> smu13
>
> issue calltrace:
> [  402.773695] [drm] failed to load ucode SMC(0x2C)
> [  402.773754] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
> response status is (0x0)
> [  402.773762] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load smu
> failed!
> [  402.966758] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail to stop
> psp ring
> [  402.966949] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading
> failed
> [  402.967116] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR*
> hw_init of IP block <psp> failed -22
> [  402.967252] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
> [  402.967255] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>
> if not reset mp1 state during kernel driver unload, it will cause psp
> load pmfw fail at the second time.
>
> add PPSMC_MSG_PrepareMp1ForUnload support for
> smu_v13_0_0/smu_v13_0_7
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 8 ++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f57710790b8c..14ebc35d9cf0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -66,6 +66,8 @@ static int smu_set_fan_control_mode(void *handle, u32
> value);
>  static int smu_set_power_limit(void *handle, uint32_t limit);
>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> +static int smu_set_mp1_state(void *handle, enum pp_mp1_state
> mp1_state);
> +
>
>  static int smu_sys_get_pp_feature_mask(void *handle,
>                                       char *buf)
> @@ -1414,6 +1416,12 @@ static int smu_disable_dpms(struct smu_context
> *smu)
>        switch (adev->ip_versions[MP1_HWIP][0]) {
>        case IP_VERSION(13, 0, 0):
>        case IP_VERSION(13, 0, 7):
> +             ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +             if (ret) {
> +                     dev_err(adev->dev, "Fail set mp1 state to
> UNLOAD !\n");
> +                     return ret;
> +             }
> +
>                return 0;
>        default:
>                break;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 26fb72a588e7..fda89e309b07 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>        MSG_MAP(GetPptLimit,
>        PPSMC_MSG_GetPptLimit,                 0),
>        MSG_MAP(NotifyPowerSource,
>        PPSMC_MSG_NotifyPowerSource,           0),
>        MSG_MAP(Mode1Reset,
>        PPSMC_MSG_Mode1Reset,                  0),
> +     MSG_MAP(PrepareMp1ForUnload,
>        PPSMC_MSG_PrepareMp1ForUnload,         0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT]
> =3D {
> @@ -1662,6 +1663,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>        .baco_exit =3D smu_v13_0_baco_exit,
>        .mode1_reset_is_support =3D
> smu_v13_0_0_is_mode1_reset_supported,
>        .mode1_reset =3D smu_v13_0_mode1_reset,
> +     .set_mp1_state =3D smu_cmn_set_mp1_state,
>  };
>
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index a92ab3266091..185058637f7d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -116,6 +116,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D
>        MSG_MAP(DramLogSetDramSize,
>        PPSMC_MSG_DramLogSetDramSize,          0),
>        MSG_MAP(AllowGfxOff,
>        PPSMC_MSG_AllowGfxOff,                 0),
>        MSG_MAP(DisallowGfxOff,
>        PPSMC_MSG_DisallowGfxOff,              0),
> +     MSG_MAP(PrepareMp1ForUnload,
>        PPSMC_MSG_PrepareMp1ForUnload,         0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT]
> =3D {
> @@ -1647,6 +1648,7 @@ static const struct pptable_funcs
> smu_v13_0_7_ppt_funcs =3D {
>        .baco_set_state =3D smu_v13_0_7_baco_set_state,
>        .baco_enter =3D smu_v13_0_7_baco_enter,
>        .baco_exit =3D smu_v13_0_baco_exit,
> +     .set_mp1_state =3D smu_cmn_set_mp1_state,
>  };
>
>  void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1

--_000_PH7PR12MB5997EC755C7D359CDFDCDA1182A69PH7PR12MB5997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, June 10, 2022 10:55 AM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Yang(Kevin) &l=
t;KevinYang.Wang@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail=
 issue for smu13</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">[AMD Official Use Only - General]<b=
r>
<br>
Will this break gpu reset? As PPSMC_MSG_PrepareMp1ForUnload may put SMC int=
o out-of-service state. That may make it unable to serve succeeding reset m=
essages.<br>
Can you have a confirm?<br>
<br>
BR<br>
Evan</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">I missed this case, it will cause g=
pu reset fail when do SMC unload.</div>
<div class=3D"PlainText elementToProof">I will submit a new patch to fix th=
is issue.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">thanks.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">Best Regards,</div>
<div class=3D"PlainText elementToProof">Kevin<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Yang<br>
&gt; Wang<br>
&gt; Sent: Thursday, June 9, 2022 7:33 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Yang(Kevin)<br>
&gt; &lt;KevinYang.Wang@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.c=
om&gt;<br>
&gt; Subject: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue=
 for<br>
&gt; smu13<br>
&gt; <br>
&gt; issue calltrace:<br>
&gt; [&nbsp; 402.773695] [drm] failed to load ucode SMC(0x2C)<br>
&gt; [&nbsp; 402.773754] [drm] psp gfx command LOAD_IP_FW(0x6) failed and<b=
r>
&gt; response status is (0x0)<br>
&gt; [&nbsp; 402.773762] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load sm=
u<br>
&gt; failed!<br>
&gt; [&nbsp; 402.966758] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail=
 to stop<br>
&gt; psp ring<br>
&gt; [&nbsp; 402.966949] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware lo=
ading<br>
&gt; failed<br>
&gt; [&nbsp; 402.967116] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR*<br=
>
&gt; hw_init of IP block &lt;psp&gt; failed -22<br>
&gt; [&nbsp; 402.967252] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init=
 failed<br>
&gt; [&nbsp; 402.967255] amdgpu 0000:03:00.0: amdgpu: Fatal error during GP=
U init<br>
&gt; <br>
&gt; if not reset mp1 state during kernel driver unload, it will cause psp<=
br>
&gt; load pmfw fail at the second time.<br>
&gt; <br>
&gt; add PPSMC_MSG_PrepareMp1ForUnload support for<br>
&gt; smu_v13_0_0/smu_v13_0_7<br>
&gt; <br>
&gt; Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++<br>
&gt;&nbsp; 3 files changed, 12 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index f57710790b8c..14ebc35d9cf0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -66,6 +66,8 @@ static int smu_set_fan_control_mode(void *handle, u3=
2<br>
&gt; value);<br>
&gt;&nbsp; static int smu_set_power_limit(void *handle, uint32_t limit);<br=
>
&gt;&nbsp; static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);<=
br>
&gt;&nbsp; static int smu_set_gfx_cgpg(struct smu_context *smu, bool enable=
d);<br>
&gt; +static int smu_set_mp1_state(void *handle, enum pp_mp1_state<br>
&gt; mp1_state);<br>
&gt; +<br>
&gt; <br>
&gt;&nbsp; static int smu_sys_get_pp_feature_mask(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; char *buf)<br>
&gt; @@ -1414,6 +1416,12 @@ static int smu_disable_dpms(struct smu_context<=
br>
&gt; *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions=
[MP1_HWIP][0]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &=
quot;Fail set mp1 state to<br>
&gt; UNLOAD !\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; index 26fb72a588e7..fda89e309b07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; @@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping<br>
&gt; smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(NotifyPowerSource,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_NotifyPowerSource,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(Mode1Reset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Mode1Reset,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnload,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PrepareMp1ForUnloa=
d,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT=
]<br>
&gt; =3D {<br>
&gt; @@ -1662,6 +1663,7 @@ static const struct pptable_funcs<br>
&gt; smu_v13_0_0_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_bac=
o_exit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =3D<=
br>
&gt; smu_v13_0_0_is_mode1_reset_supported,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0_m=
ode1_reset,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_cmn_set_mp1_state,<br=
>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; index a92ab3266091..185058637f7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; @@ -116,6 +116,7 @@ static struct cmn2asic_msg_mapping<br>
&gt; smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowGfxOff,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowGfxOff,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisallowGfxOff,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisallowGfxOff,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnload,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PrepareMp1ForUnloa=
d,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT=
]<br>
&gt; =3D {<br>
&gt; @@ -1647,6 +1648,7 @@ static const struct pptable_funcs<br>
&gt; smu_v13_0_7_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v13_=
0_7_baco_set_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_7_=
baco_enter,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_bac=
o_exit,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_cmn_set_mp1_state,<br=
>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)<br>
&gt; --<br>
&gt; 2.25.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB5997EC755C7D359CDFDCDA1182A69PH7PR12MB5997namp_--
