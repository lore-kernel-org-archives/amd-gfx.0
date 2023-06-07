Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04ADC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 13:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5706D10E4F4;
	Wed,  7 Jun 2023 13:29:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B3C10E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 13:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSy6BL1PkZbpZtMuwdZg2a+8ca5n9VVNujvM9jM7elItScsJojAKJKYUKTNX/LpWbe7OgjUPXAt7Uh9/kxX9Clq+LbPiQS8CEeNgTU8nlgjH9+oMrOs6Ta4Z2o1WDa1pthwyJKuCqyHD8XFQXK2M+33K7xdCU9o8rouDb+rsuZWpQLTB5Unu6ZssQmEeWGTs2mp/MM8+VBzEIoijh5zaIbECMqalGoZrAzjkYxLs3XjUUJ/I+zJVRWMJYDCX2Yi2/AGzqLR8w9Q4dMyvKLbptE/VX2EcOEX5scdbNSYkRRtWTPgiW+PEjFI8W7elvPfJIPqirECWTSEWuuou3YAKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TZO7eR+Kwd/QagXEtZx0GMCLNWHcZDyZLp4JchNIc0=;
 b=TX9qKRhqOdCpWEBmGO/IcE1kkkWhs8dyM1I7f9ARP6lrqsOo2NVDBFwuiGxM8jtpDsjSy9C1b3K629VxxQNGcdk4ZeQ7FvffFgt/hnfTOOf73uY6oi6a/P1NoXy5LyvAo/wWr2q7pHwHWnufsg91FIp/rBh7mSY4qIcd77ap5gejBQ1+IagpFkQz33UvnyIp2jROhEUTXZVP6cZH9UjN2/NRN4HCVo0cWtUP+uAv7hZhWAPjb3kBGbZdayraaX7j9MRW1W14PKtlqPAPVYmgWrDh1SH0H3baBXDuKVleDQGMFVa2UoI8VSFS/ZiujC5pjG0y6Vyji//czLAhc3AJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TZO7eR+Kwd/QagXEtZx0GMCLNWHcZDyZLp4JchNIc0=;
 b=js9pjwvCNWuFwQKSgBM/scp5WGr3OLO5m7DtJG3jtrlgKTfg5SM8r5P4V7dqLYtw/Dd72BMBevsUBDJVq8UP5GbxHaS1nlzokSMvbQI4x4tmoDNJDk6E/ucls8Kl2resIjRNo/yfWhwtr1hHOrj6c6IFJheMCo03qymrcJtdMc4=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 13:29:44 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::1f2b:8491:96c8:26fa]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::1f2b:8491:96c8:26fa%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 13:29:44 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Thread-Topic: [PATCH] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Thread-Index: AQHZmTB320uQ/GNkuUOeDIarUC3Wfq9/Ud0b
Date: Wed, 7 Jun 2023 13:29:43 +0000
Message-ID: <BY5PR12MB3873CA752F06E53410937624F653A@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230607110747.1769721-1-shikai.guo@amd.com>
In-Reply-To: <20230607110747.1769721-1-shikai.guo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-07T13:29:42.398Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SN7PR12MB6885:EE_
x-ms-office365-filtering-correlation-id: 4a29c063-17ef-41b0-46e6-08db675b416a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FtjXdJhSitKsjR39yRdngUUGGOjlJBf086jd+HAFKdunQvysRjJdKkblF4bEeIZGumaBnYMtlCKoTabcAAUgp0Pn5e9qIE5W6wV3Ei7Ia5JITVz3b6Cu7fqhRQLe+BYLX++EgRdr0YXJ317uCCIIWRNEFClZ/HuEc3GDxKWStMNIvj/jk4d01r2Ke4XDWoNq0O6VaGJEZYzZVKrzXwOc4642zpqvN+gYTnJpiQvm66ReD8n8tg9NwNDMz4EXVXeXodJbFa0oaJqX2ZK8G+SNXmGpKzFxVJGp5tSLNm+Pd1n0uSfzVgvSm0O3FXNuyyu28R0AJ1vjAdAeihCOLnwHZxwGJsX4mW/5kijcFwA2kjkAg1IL7nGA0yHoCejiKqFcFtvUlaw4AKy9LkO88bfqUuUGXgiV8R5gncs8cflc4gRL3jtnELhf22niFwpIM/yvRwldrClZjRjU3X0ruB/duKrsZdiREheDqkGAhSmO6ChkXHEK29sgudPVHIEi13QWURwVYz2cEWKWl3XgJjFhT1qmNGa1YrOPk2RHs8PX51FAbiokokKuxEM/DlKk+1Uom5N3UTvb+1e9JsH48QkuLvWIEc5CNpqlBruSsVjHyb2u3ToEr54lAzBOZY030hWY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(52536014)(8676002)(64756008)(316002)(2906002)(5660300002)(66446008)(8936002)(4326008)(66476007)(66556008)(66946007)(19627405001)(76116006)(41300700001)(110136005)(91956017)(54906003)(7696005)(71200400001)(6506007)(9686003)(53546011)(26005)(186003)(83380400001)(38070700005)(122000001)(478600001)(55016003)(38100700002)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OhBmlKoffX7jlRSFEIhcN1Vf3gtcmLhV//lvdRDikfLiOxG//DRA/dtKgx?=
 =?iso-8859-1?Q?37uBBX4epSonLOJc4EQMHNdDvEKmIwIuA2XFMguuqQ4HbPPcJMJy9GGKVz?=
 =?iso-8859-1?Q?QPTQ8cKvflCbtLx2smNRX4txjx98C+7VZ/uoHTQIbUJ9ICqsSXSTfP1wYP?=
 =?iso-8859-1?Q?KPDIQvlhapmFc+xNbH1RKT3j1+Jio5vUW+iPmzwfXFblccVWu60IvQQDps?=
 =?iso-8859-1?Q?MAUJpItBk0K+cefh4/L4bC+fGbfot+Jy+IBeND+bskgVDUFKq7uJLPOxKc?=
 =?iso-8859-1?Q?PEEATQqiu1E/r+4K78GzjYWESDJDYe1DWC3jzewCHX5+dUs8BgHyBHgfC2?=
 =?iso-8859-1?Q?9Q6lI1c0ercDZo5K3BRtUDbvw234SFDOyEJ/B6giG3c6Az+GgZZ+c15l7p?=
 =?iso-8859-1?Q?eBl7anoqgfmtugN72CdlnxD2cVEnbLWxv1dNCT66TasXlpnjuF78GcucmN?=
 =?iso-8859-1?Q?YGd1IVNn5k/HospFDrYixkkmvzDODwGMtbSDKg8ge9TYAszOAnYxTGLrb1?=
 =?iso-8859-1?Q?6wg5hKfjTaa1bAPWU3H5iB3ONQYWEw3hgMHQEZEgW2bVHYeziTxfg31GbR?=
 =?iso-8859-1?Q?pCOa5/gP/x3j+YJOcsOO47/GcmdnkHCRraPZN9mwGphs5/TM9Ge3NiSw9c?=
 =?iso-8859-1?Q?CS6wAa/VuROgCd0OeNjvyWjV276bIH9CWDF4cPzWUy4nzEzkB9eCd2s2Is?=
 =?iso-8859-1?Q?7ODMgJJsh+1ri9n8+L4ADlJM8OJpt1qDWK9f3d7Nr9HJvq6AOL3/oVKz+b?=
 =?iso-8859-1?Q?oSd8KBHusXpn9k0us0P0hFASQRXuqv00gBCf30PW5I6i+M6eQsQycASvPv?=
 =?iso-8859-1?Q?PDgtdGDmH6eR6L04Asxps7llAfNq54A0PyyLy/aDHi1l7UWCtZD7BzMg63?=
 =?iso-8859-1?Q?NXqXDynODLpQjdrotpX1Y7/sWz63gYY0NgFTymBzuqN852LuYDSU2s6TyJ?=
 =?iso-8859-1?Q?iRtoiupClkiqBoZEe3MQWAw5NEmv3riIKazkqWcxxX0yRs6JEaGBXF8WmQ?=
 =?iso-8859-1?Q?OiQ2RBlb6HPC12djcTFVCynP+MuUEk4N6RMrylPcAG/avUpxOFC5FWpLAF?=
 =?iso-8859-1?Q?/1ZvOQe9OCqHONKNCt1jEDkNoQgovuuNc3dS0ZIiKEE4xNIK3mLmZMmva4?=
 =?iso-8859-1?Q?rv+wYny8DcSdxE6Gz3F+yKo5u2c0VhNde6PdGSUZ0by6+ZioGag9tWyZM1?=
 =?iso-8859-1?Q?y4KBLkrKV/cpcKWkI5V3ihReiepSNOBJV2WGQcpNoicDcboN+W06DxshXv?=
 =?iso-8859-1?Q?05Ge1TlD5IOQpQCIzNzL399snd0+UzFPnQRfsPe26d656/WjaNjlLUtGm+?=
 =?iso-8859-1?Q?rItJ7dmaxdnQNqN7svvF0ofYK3M7/xW+WavvZm1p6E+3/+0PvPONE/8w/i?=
 =?iso-8859-1?Q?6ECwlJImWlWxJor/Ats/14KFENLnkRcMSnajM0pP3uVQ+UdqoQ4XK/8axj?=
 =?iso-8859-1?Q?awkUbAH2g2LKFTQQ3QLOM4sNaHGEb2Uw43wu3QC+5KJx3yPJAZz66anfnj?=
 =?iso-8859-1?Q?eoZHukkthOZg9qBTWhilupZINqGqyTe0kZcl051XumZSCzZ5D0/oQ5gSMc?=
 =?iso-8859-1?Q?SF4T4DHJK1JP5pCdp+cg2CNmK4BZsJxlFFwvStPpXR2EMBBcsGaisEctnV?=
 =?iso-8859-1?Q?RuE9nmEsuawak=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB3873CA752F06E53410937624F653ABY5PR12MB3873namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a29c063-17ef-41b0-46e6-08db675b416a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 13:29:43.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnOuYpsQo80F9OIV6L+IDQRl+kWmnJc9hDxzKdn/TiNgZbstEOvLtXc8tBrAP7SqoXX51Jq+h8l1vqPc9nz4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB3873CA752F06E53410937624F653ABY5PR12MB3873namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Shikai,

Comments inline.

________________________________
From: Guo, Shikai <Shikai.Guo@amd.com>
Sent: Wednesday, June 7, 2023 7:07 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hua=
ng, Tim <Tim.Huang@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
Subject: [PATCH] drm/amd/pm: enable more Pstates profile levels for yellow_=
carp

This patch enables following UMD stable Pstates profile levels for power_dp=
m_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: shikaguo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 94 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  8 +-
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a92da336ecec..5c968ab2ea8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                                                         uint32_t max)
 {
         enum smu_message_type msg_set_min, msg_set_max;
+       uint32_t min_clk =3D min;
+       uint32_t max_clk =3D max;
+
         int ret =3D 0;

         if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
@@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(st=
ruct smu_context *smu,
                 return -EINVAL;
         }

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL=
);
+       if (clk_type =3D=3D SMU_VCLK) {
+               min_clk =3D min << SMU_13_VCLK_SHIFT;
+               max_clk =3D max << SMU_13_VCLK_SHIFT;
+       }
+
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, =
NULL);
+
         if (ret)
                 goto out;

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL=
);
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, =
NULL);
         if (ret)
                 goto out;

@@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu_c=
ontext *smu,
         return ret;
 }

+static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,
+                                       enum amd_dpm_forced_level level,
+                                       enum smu_clk_type clk_type,
+                                       uint32_t *min_clk,
+                                       uint32_t *max_clk)
+{
+       int ret =3D 0;
+       uint32_t clk_limit =3D 0;
+
+       switch (clk_type) {
+       case SMU_GFXCLK:
+       case SMU_SCLK:
+               clk_limit =3D YELLOW_CARP_UMD_PSTATE_GFXCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_SOCCLK:
+               clk_limit =3D YELLOW_CARP_UMD_PSTATE_SOCCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, =
NULL, &clk_limit);
+               break;
+       case SMU_FCLK:
+               clk_limit =3D YELLOW_CARP_UMD_PSTATE_FCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK=
)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_VCLK:
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk=
_limit);
+               break;
+       case SMU_DCLK:
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk=
_limit);
+               break;
+       default:
+               ret =3D -EINVAL;
+               break;
+       }
+       *min_clk =3D *max_clk =3D clk_limit;
+       return ret;
+}
+
 static int yellow_carp_set_performance_level(struct smu_context *smu,
                                                 enum amd_dpm_forced_level =
level)
 {
@@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,
         uint32_t sclk_min =3D 0, sclk_max =3D 0;
         uint32_t fclk_min =3D 0, fclk_max =3D 0;
         uint32_t socclk_min =3D 0, socclk_max =3D 0;
+       uint32_t vclk_min =3D 0, vclk_max =3D 0;
+       uint32_t dclk_min =3D 0, dclk_max =3D 0;
+
         int ret =3D 0;

         switch (level) {
@@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(struct=
 smu_context *smu,
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sc=
lk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fc=
lk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &=
socclk_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vcl=
k_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dcl=
k_max);
                 sclk_min =3D sclk_max;
                 fclk_min =3D fclk_max;
                 socclk_min =3D socclk_max;
+               vclk_min =3D vclk_max;
+               dclk_min =3D dclk_max;
                 break;
         case AMD_DPM_FORCED_LEVEL_LOW:
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min=
, NULL);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min=
, NULL);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk=
_min, NULL);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min,=
 NULL);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min,=
 NULL);
                 sclk_max =3D sclk_min;
                 fclk_max =3D fclk_min;
                 socclk_max =3D socclk_min;
+               vclk_max =3D vclk_min;
+               dclk_max =3D dclk_min;
                 break;
         case AMD_DPM_FORCED_LEVEL_AUTO:
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min=
, &sclk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min=
, &fclk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk=
_min, &socclk_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min,=
 &vclk_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min,=
 &dclk_max);
                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-               /* Temporarily do nothing since the optimal clocks haven't =
been provided yet */
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &scl=
k_min, &sclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &fcl=
k_min, &fclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &s=
occlk_min, &socclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &vcl=
k_min, &vclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &dcl=
k_min, &dclk_max);
                 break;
         case AMD_DPM_FORCED_LEVEL_MANUAL:
         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
@@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struct =
smu_context *smu,
                         return ret;
         }

+       if (vclk_min && vclk_max) {
+               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
+                                                             SMU_VCLK,
+                                                             vclk_min,
+                                                             vclk_max);
+               if (ret)
+                       return ret;
+       }
+
+       if (dclk_min && dclk_max) {
+               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
+                                                             SMU_DCLK,
+                                                             dclk_min,
+                                                             dclk_max);
+               if (ret)
+                       return ret;
+       }
+
         return ret;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
index a9205a8ea3ad..59257bbd66e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,6 +24,12 @@
 #define __YELLOW_CARP_PPT_H__

 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
+
+#define SMU_13_VCLK_SHIFT              16


The macro 'SMU_13_VCLK_SHIFT' can be shared by SMU13 APUs and is defined in=
 smu_v13_0.h in the patch for SMU v13.0.4.
So, it should not need this definition again. thanks.

Tim

+
+//UMD PState Rembrandt Msg Parameters in MHz
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK       700
+#define YELLOW_CARP_UMD_PSTATE_SOCCLK          678
+#define YELLOW_CARP_UMD_PSTATE_FCLK                    800

 #endif
--
2.25.1


--_000_BY5PR12MB3873CA752F06E53410937624F653ABY5PR12MB3873namp_
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
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Shikai,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Comments inline.</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> Guo, Shikai &lt;=
Shikai.Guo@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 7, 2023 7:07 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Liu, Aaron &lt;Aaron.L=
iu@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Guo, Shikai &lt;Shika=
i.Guo@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: enable more Pstates profile levels for =
yellow_carp</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">This patch enables following UMD st=
able Pstates profile levels for power_dpm_force_performance_level interface=
.<br>
<br>
- profile_peak<br>
- profile_min_mclk<br>
- profile_min_sclk<br>
- profile_standard<br>
<br>
Signed-off-by: shikaguo &lt;shikai.guo@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; | 94 +++++++++++++=
+++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h&nbsp; |&nbsp; 8 +-<br>
&nbsp;2 files changed, 98 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index a92da336ecec..5c968ab2ea8d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(stru=
ct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_message_type msg_=
set_min, msg_set_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_clk =3D min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_clk =3D max;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!yellow_carp_clk_dpm_i=
s_enabled(smu, clk_type))<br>
@@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(st=
ruct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_min, min, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_type =3D=3D SMU_VCLK) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; min_clk =3D min &lt;&lt; SMU_13_VCLK_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_clk =3D max &lt;&lt; SMU_13_VCLK_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_min, min_clk, NULL);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_max, max, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_max, max_clk, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
@@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum amd_dpm_forced_level level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum smu_clk_type clk_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t *min_clk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t *max_clk)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_limit =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D YELLOW_CARP_UMD_PSTATE_GFXCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SOCCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D YELLOW_CARP_UMD_PSTATE_SOCCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D YELLOW_CARP_UMD_PSTATE_FCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_FCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_FCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &amp;clk_=
limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &amp;clk_=
limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *min_clk =3D *max_clk =3D clk_limit;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;static int yellow_carp_set_performance_level(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dp=
m_forced_level level)<br>
&nbsp;{<br>
@@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_min =3D 0, s=
clk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fclk_min =3D 0, f=
clk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t socclk_min =3D 0,=
 socclk_max =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vclk_min =3D 0, vclk_max =3D=
 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t dclk_min =3D 0, dclk_max =3D=
 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
@@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL=
, &amp;sclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL=
, &amp;fclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NU=
LL, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &amp;vclk=
_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &amp;dclk=
_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sclk_min =3D sclk_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fclk_min =3D fclk_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; socclk_min =3D socclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vclk_min =3D vclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dclk_min =3D dclk_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
LOW:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &amp=
;sclk_min, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &amp=
;fclk_min, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &a=
mp;socclk_min, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &amp;vclk_min, =
NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &amp;dclk_min, =
NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sclk_max =3D sclk_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fclk_max =3D fclk_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; socclk_max =3D socclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vclk_max =3D vclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dclk_max =3D dclk_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
AUTO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &amp=
;sclk_min, &amp;sclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &amp=
;fclk_min, &amp;fclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &a=
mp;socclk_min, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &amp;vclk_min, =
&amp;vclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &amp;dclk_min, =
&amp;dclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_STANDARD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_SCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_MCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_PEAK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Temporarily do nothing since the optimal clocks haven't been =
provided yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &amp;sclk=
_min, &amp;sclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &amp;fclk=
_min, &amp;fclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &amp;so=
cclk_min, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &amp;vclk=
_min, &amp;vclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &amp;dclk=
_min, &amp;dclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
MANUAL:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_EXIT:<br>
@@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vclk_min &amp;&amp; vclk_max) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D yellow_carp_set_soft_freq_limited_range(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_VCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vclk_min,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vclk_max);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dclk_min &amp;&amp; dclk_max) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D yellow_carp_set_soft_freq_limited_range(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_DCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dclk_min,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dclk_max);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
index a9205a8ea3ad..59257bbd66e0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
@@ -24,6 +24,12 @@<br>
&nbsp;#define __YELLOW_CARP_PPT_H__<br>
&nbsp;<br>
&nbsp;extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);<br>
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1100<br>
+<br>
+#define SMU_13_VCLK_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, Bli=
nkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; display: i=
nline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255)=
;" class=3D"ContentPasted0 ContentPasted1">The
 macro 'SMU_13_VCLK_SHIFT' can be shared by SMU13 APUs and is defined in&nb=
sp;smu_v13_0.h in the patch for SMU v13.0.4.</span><br>
</div>
<div class=3D"PlainText elementToProof"><font face=3D"Segoe UI Web (West Eu=
ropean), Segoe UI, -apple-system, BlinkMacSystemFont, Roboto, Helvetica Neu=
e, sans-serif" style=3D"color: rgb(0, 0, 0);">So, it should not need this d=
efinition again. thanks.&nbsp;</font></div>
<div class=3D"PlainText elementToProof"><font face=3D"Segoe UI Web (West Eu=
ropean), Segoe UI, -apple-system, BlinkMacSystemFont, Roboto, Helvetica Neu=
e, sans-serif" style=3D"color: rgb(0, 0, 0);"><br>
</font></div>
<div class=3D"PlainText elementToProof"><font face=3D"Segoe UI Web (West Eu=
ropean), Segoe UI, -apple-system, BlinkMacSystemFont, Roboto, Helvetica Neu=
e, sans-serif" style=3D"color: rgb(0, 0, 0);">Tim</font></div>
<div class=3D"PlainText elementToProof"><br>
+<br>
+//UMD PState Rembrandt Msg Parameters in MHz<br>
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
700<br>
+#define YELLOW_CARP_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 678<br>
+#define YELLOW_CARP_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 800<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB3873CA752F06E53410937624F653ABY5PR12MB3873namp_--
