Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5224AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 01:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D62660F38
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 01:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D62660F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A0A6E5B6;
	Tue, 12 Oct 2021 01:24:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC136E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 01:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty/Oh/znZ28bTG/MHwuOYyP5GQGNX4ZoHlKv9JV/1v1gzskSIde6WPCnA62VdfzM0PCb8Hb6Bs4Im5cafO2GesBufc3PAytBftS1nr65tMo8myX3ijtc4wO7iqgGM2hTFz8AfvWcdRfMI+fig3dmrWJHre2iZmOo06KIELC9Uh1l2VUCYbQTPTY56pIkXvlKuJo4rpOS3mcdQ+6bUtXz1a8FSBRa0QYvQpukJW8DA/MOTbJJMJ+lxr+/XDWbG0dgmzmQe3vw9Omfu2VDjGkkMrqKZv7XMJXxzsuR4JLV27ViZU7MF9PqIFyVsZNp8AECQwUKNOjEg2qLeRqV2okjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RESTe1kt7+4mqTSSC1eUvJCnMje7at+YSN9CdfTcQu8=;
 b=H5bCTxVxL6HjeR2ikUDeXcfRxurM6nSttUeuYjT8rKNg7xs7LV5C7K0aRPW07IpI9JEyCKpakHBx/MecWHO890Laij7FIwuL29SIJDnf+Pmf63kifPJTRFHdI9iB9FmCa74w/kZTJSdEbi81iTGvgXN9vsbqj9sabuw8REfbWzOG0xUr6lX2v2Frrf9nkqXaXJYza+A7BTWhpn2gyTPrkpeUel85MCYM7IL4N2IHB4TxBghRH0mWipUYUTDlgQZSmYe0ksH3r++zd8KYjsMaJPFDcigY+zJP4OTyn8k79gllBTf4hRhNoCfZsi2l1mDmbJP42hPzaGF3Ws9c9RGE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RESTe1kt7+4mqTSSC1eUvJCnMje7at+YSN9CdfTcQu8=;
 b=Lxe00p0NTKs+vJqM9pCtQwpaUf1j/OriiFAjdnM7u0Qwg3dB4Nxe1PqccHSm4qL+rvJLKS0PIrZKf+jVEQBo6bOwGxqkKUgzuLu+oN3eLXG/lGrMg8GUAQpRDa/8Xc/jreu/gK3CvFrYc/Qt2D1TGG+UQNKfHpapopKy90F7WKg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Tue, 12 Oct 2021 01:24:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 01:24:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: properly handle sclk for profiling modes
 on vangogh
Thread-Topic: [PATCH] drm/amdgpu/pm: properly handle sclk for profiling modes
 on vangogh
Thread-Index: AQHXvrE9D/HoA1yqbk27bt3uu7wLb6vOkkWg
Date: Tue, 12 Oct 2021 01:24:27 +0000
Message-ID: <DM6PR12MB2619422BADA8A9336855FA12E4B69@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211011150340.165831-1-alexander.deucher@amd.com>
In-Reply-To: <20211011150340.165831-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T01:24:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=05592fbd-7cbe-4927-99f3-8e56a4fa94a8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11a9d4ee-56dc-4cc5-3d1f-08d98d1f0886
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31794BA470C14780E43C73E9E4B69@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKWBGY1KJDqHzF9xkydr1eVxsuz5Ja3GdaixY7jCRkXInNukY1j5Kz7r7sRh1Mv8vYVXH4lk9Agi9Jp4e6TTTEopp/ib/ne/DAmiPaurnWauqWGukMpwqtTMCXBS7RXuRiXgKJO+ukVw9klsiM6nubiy/4pyYfXoD2Fgaxe6qol8vTlrOwbPhl+Y54eLF0eKWZe69WzmHZ5cAuv1XpatJPzUwCo7cYqa39UlYE56SiYnNPw8pM7yLjVXRrFkf/99r2Pdsx59uv7zY4PypzSEu9GM9MidoWxoJPScFqKxXpDe5+9+t/9g2DfLJJfIYc7JubRoVe2+2DtFVKw3569tHQUqY8mvjHwu6Ft1rtUX+SW2ttxyMA3D/owyoNp8+QlSAw5x3p1HGgMazUP6sa1sozjwQHFzNMjCMjjxGmGTC2yr1qxHssfMX15QqqRYWfoPbj8qg4+zl7/kLazsIHrjrPo48oUOas56ini4znCw3Br2q5lvyuWZX4GaCpg8QZV/n4+Y2t1UgnPwKUKpWHpqxXwgJhKnaKHRIgzt1Mkg2fid5EyH+JsDSn/hKV0yDJqUfGLXiWF1Sz1f9ZA0Rv4ThbcDP6vhpFuUgCaxbrBeJ3mhEuL3BmxNvVpyH1SZmq70pg45shQpEJPpjk6iSaQcuz9FpBNcr6NJTVIzIQN1nzOCzzWuTxwCoQPZ7sCVVHmPGEWQ1KaGzayAkmXw3IFPkRK25/fMnbaPekZM0Y7JbyZxWVAFLBshMlO8xssy6EQcfxKw1+dHW/EM05et4uWbW8OFJ9iVxsztp8JDzJDYVbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(86362001)(8676002)(4326008)(8936002)(316002)(9686003)(83380400001)(55016002)(2906002)(45080400002)(5660300002)(71200400001)(53546011)(66446008)(64756008)(66556008)(966005)(76116006)(66476007)(66946007)(38070700005)(52536014)(508600001)(38100700002)(122000001)(26005)(186003)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+5fRDpe7Zl/Jh0JvEqaQp0xpvxb3zCFfmQx00y1GYSABQFpba5HUL8yS/UHr?=
 =?us-ascii?Q?qLnf7039joT3Cv2bFN0p4nMIcoxPxHen7LrXVOl79UZEagNcuSr4Feyto83f?=
 =?us-ascii?Q?S49B1808ZcSHA2PxUe++rdrUKB0Y5Ewn6dIAtKJmo+wHGDq3yXcjHMRHCth5?=
 =?us-ascii?Q?zpJ/PlYM4DZY2PENuEGn8tEUxoS1GN/YNHCKrgTC64hJjmoC8emS1MtvKSgJ?=
 =?us-ascii?Q?KZ/S7TbLVAgDmj9T5UjhZs5gwPiWmZBQLKtYWGhn5Fp2waO2OnQ8+YNxVe5X?=
 =?us-ascii?Q?+DDWl6JnrNee1v3DFovYgAnXiaM3jyAD+9JzXgkbSguWxNKR31SvtDSdXdi1?=
 =?us-ascii?Q?YJ7f5N6yKZmi+cMxqYETWPwBWW5Yuv7k4wd/AM5aq4bZFLi6Q8FOMN7sTgbW?=
 =?us-ascii?Q?KYgHXu3PvY3aH01dedEzHKo1vwn6yh4yA/q5fQKTnUls6zBD3L+jjrc6qkle?=
 =?us-ascii?Q?XpGG9bVr/yxJ3vccXvAzgowtika2tgPHgQqNK4CAGJtzKeOTeZDFgWqZgjn9?=
 =?us-ascii?Q?ZSilpvfcYe0at7XoihDcwaFce6SFKvfbS6+p1doA98dGlmpn6IUYcCQsMnGU?=
 =?us-ascii?Q?v837bC0h5v/rjQkPp5qqIk2pjha5ufq+k7WbyMKeySHjBYJAO79ltHND1pK7?=
 =?us-ascii?Q?qUt+DVImCpZ/9H5IVUVisgWpKI5Vx+gRx8F3i+YPnMQXWHFRopacqn+LJIVe?=
 =?us-ascii?Q?01uMCvOYUoG0aihtdj+eZ2JkCNgCB+i4A8IKU745PcF603gnT4KxLj4HwPFN?=
 =?us-ascii?Q?5LFEc8jnqyuU6Jnq0RL5VjLJPb3cvIbVwcdu1yiClO0ht+95B5RfFNV6YiQ+?=
 =?us-ascii?Q?lM5Pn0f9L+dEArBeFrkJ5LLGaQ9ZIDMSNJ0ENiOFlczVTz+5wgtyuAEBNY76?=
 =?us-ascii?Q?XbFlBhAwPhSb+U4VSNAjwo2X8MYYRZdraRpmBHbOu3VzkF/BYYBNrKbo18k/?=
 =?us-ascii?Q?QOSvzswAgATbnm7HzYAWyBXWPlXqRjhlIHkiZIuwPHaKVzSH3o5AMESnu7PZ?=
 =?us-ascii?Q?OHKXnm9Y9ZZlcXuL8p2TskYDUjgBKprxZp7vHwDsdqGc7UiOiCE6uSvq8rhM?=
 =?us-ascii?Q?0MfcTNkxiIg3ZO/dFOOJCRdqBA8ZRFJwLLnc9Tq2hxVe8Uz7VaffqAzZOnGt?=
 =?us-ascii?Q?t26rZUzeh7NX/I06z63nWpLvEHA8YSdjwvovvs6R1VAhv5LoeEQUnr9s6B13?=
 =?us-ascii?Q?9We6DPealRHgxQ6eEAovjb+agzKVKRhY4Nhy5kcyXCilUI+f++Yei6Hwq/IJ?=
 =?us-ascii?Q?ZMSaV/ryEYSbBb9kLdxbXDcNrNDE5WtMDpt/ARyFGf+7PlaX6t2mOuxAgU/T?=
 =?us-ascii?Q?QWYECX8ku1h+keG+ITxzuKMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a9d4ee-56dc-4cc5-3d1f-08d98d1f0886
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 01:24:27.5314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4USg4D/GcCZt5MLguMK59q0IM/7kD+CNzDPMw4o2hwvntr5LF8fYI358izzYbNIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Monday, October 11, 2021 11:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/pm: properly handle sclk for profiling modes
> on vangogh
>=20
> When selecting between levels in the force performance levels interface s=
clk
> (gfxclk) was not set correctly for all levels.  Select the proper sclk se=
ttings for
> all levels.
>=20
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1726&amp;data=3D04%7C01%7Cevan.quan%40amd.com%7C3bf
> 2cf5224d4467295e508d98cc85ebf%7C3dd8961fe4884e608e11a82d994e183d%
> 7C0%7C0%7C637695614479890816%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3DnnWeLhX6hPmlP42pH9ygjiLX44HIzPApyR0%2BIFh5oaQ%3D&a
> mp;reserved=3D0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 89 ++++++------------
> -
>  1 file changed, 29 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index bdd1a01e27b4..8d5f32807821 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1386,52 +1386,38 @@ static int vangogh_set_performance_level(struct
> smu_context *smu,
>  	uint32_t soc_mask, mclk_mask, fclk_mask;
>  	uint32_t vclk_mask =3D 0, dclk_mask =3D 0;
>=20
> +	smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> +	smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> +
>  	switch (level) {
>  	case AMD_DPM_FORCED_LEVEL_HIGH:
> -		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
> +		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_soft_max_freq;
>  		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
>=20
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
>=20
>  		ret =3D vangogh_force_dpm_limit_value(smu, true);
> +		if (ret)
> +			return ret;
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_LOW:
>  		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
> -		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
> -
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> +		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_hard_min_freq;
>=20
>  		ret =3D vangogh_force_dpm_limit_value(smu, false);
> +		if (ret)
> +			return ret;
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_AUTO:
>  		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
>  		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
>=20
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> -
>  		ret =3D vangogh_unforce_dpm_levels(smu);
> -		break;
> -	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> -		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
> -		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
> -
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> -
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -					SMU_MSG_SetHardMinGfxClk,
> -
> 	VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -					SMU_MSG_SetSoftMaxGfxClk,
> -
> 	VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);
>  		if (ret)
>  			return ret;
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +		smu->gfx_actual_hard_min_freq =3D
> VANGOGH_UMD_PSTATE_STANDARD_GFXCLK;
> +		smu->gfx_actual_soft_max_freq =3D
> VANGOGH_UMD_PSTATE_STANDARD_GFXCLK;
>=20
>  		ret =3D vangogh_get_profiling_clk_mask(smu, level,
>  							&vclk_mask,
> @@ -1446,32 +1432,15 @@ static int vangogh_set_performance_level(struct
> smu_context *smu,
>  		vangogh_force_clk_levels(smu, SMU_SOCCLK, 1 <<
> soc_mask);
>  		vangogh_force_clk_levels(smu, SMU_VCLK, 1 << vclk_mask);
>  		vangogh_force_clk_levels(smu, SMU_DCLK, 1 << dclk_mask);
> -
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>  		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
> -		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
> -
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> -
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinVcn,
> -
> 	VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxVcn,
> -
> 	VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);
> -		if (ret)
> -			return ret;
> +		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_hard_min_freq;
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>  		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
>  		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
>=20
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> -
>  		ret =3D vangogh_get_profiling_clk_mask(smu, level,
>  							NULL,
>  							NULL,
> @@ -1484,29 +1453,29 @@ static int vangogh_set_performance_level(struct
> smu_context *smu,
>  		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -		smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
> -		smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
> -
> -		smu->cpu_actual_soft_min_freq =3D smu-
> >cpu_default_soft_min_freq;
> -		smu->cpu_actual_soft_max_freq =3D smu-
> >cpu_default_soft_max_freq;
> -
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinGfxClk,
> -				VANGOGH_UMD_PSTATE_PEAK_GFXCLK,
> NULL);
> -		if (ret)
> -			return ret;
> +		smu->gfx_actual_hard_min_freq =3D
> VANGOGH_UMD_PSTATE_PEAK_GFXCLK;
> +		smu->gfx_actual_soft_max_freq =3D
> VANGOGH_UMD_PSTATE_PEAK_GFXCLK;
>=20
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxGfxClk,
> -				VANGOGH_UMD_PSTATE_PEAK_GFXCLK,
> NULL);
> +		ret =3D vangogh_set_peak_clock_by_device(smu);
>  		if (ret)
>  			return ret;
> -
> -		ret =3D vangogh_set_peak_clock_by_device(smu);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_MANUAL:
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>  	default:
> -		break;
> +		return 0;
>  	}
> +
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinGfxClk,
> +					      smu->gfx_actual_hard_min_freq,
> NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxGfxClk,
> +					      smu->gfx_actual_soft_max_freq,
> NULL);
> +	if (ret)
> +		return ret;
> +
>  	return ret;
>  }
>=20
> --
> 2.31.1
