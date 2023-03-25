Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BCCC6FD1C
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Mar 2023 02:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1831910E069;
	Sat, 25 Mar 2023 02:36:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE8610E069
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Mar 2023 02:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vlg9FyuLh6D5HkwFk9bc9ZS1ZQ8qQs/+4v0c/en+rLzWVOkaZKwjyoPJlzt2j8X+n09mdqfVpLW1Webj0gdYTC+mNgI6bf1DFJ2YKZCxv1vzpv7wIP8RBf3AR3hizMuAXZsvmnSyufK6DKDC4T6mh+/0Xxr+tr8siAPnePS9PBj4217aiNjsgYiQUnH3ZitU2HgQPzXap2YKPsBiZ7SZrlhUEyH9Wrki21yhpXRXSfrmbDIMRqkgeCpjiMXfsbOWngkaaCYS2gRN4CRfPv2ukmiR7cOPwHcEMuD7M8IDeZUcWxZ4Co9kU1+fI2x9KnGrD2UnWrUP2x4x7cmTqknsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrJSCRB2opV6gtTyxLdX2ZKYIbmrRz+TCdwmdEYAmiQ=;
 b=DNlzIvZr3YAjGNGnL1gjWRJl8OUwLhFja402fAfYIC1wMRdNL5aag+/vR2HoECAcm4A+VxJJ9ax0syJ1S4qBmiLLuoxSpcwpRjUDFzwRMkS3dbHelsAbar3QNqnxNUSD/UDVNaz+NgwDyES14g96DN05aubE5o2NHCAEgT7utRyDIm2aSqQzDf9AzpCN1jHP94mupvaDrdMbxdYlRWPxv5O2QC0T5wy9pFxl8nke6AvUcMJws0t+GO46zBBzclW6hs+GoClIXeeIpyXZOArBg9WFQFOqxz/cvmuoJrUBeM8lFC3lot93+06uwdeXMSUpCM6gs+jvrT+tD6HYbwk1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrJSCRB2opV6gtTyxLdX2ZKYIbmrRz+TCdwmdEYAmiQ=;
 b=UA4Ql72z+PSNsOdjSclGyGUhwbMmdy270KllHkPv2GrLWYMuf5Cks1Xpc+f5U/aePBu1CT5dEoOXq0kSqwfF3DctYm1KDDxhvCgmHFmYBwDUJafq4WjoiY1TOAorD2+LtLX0mch7OzoRVoKfSFwwELd/Awv+q0VYKa8Sc/YLcCc=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sat, 25 Mar
 2023 02:36:39 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2%6]) with mapi id 15.20.6178.038; Sat, 25 Mar 2023
 02:36:39 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Topic: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Index: AQHZXh+B7xvV3d5R+USFW0xcMvXlaa8Jh6CAgAE6AxA=
Date: Sat, 25 Mar 2023 02:36:39 +0000
Message-ID: <BY5PR12MB387314E7018813FA34B60FEEF6859@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230324070812.1304117-1-tim.huang@amd.com>
 <DM5PR12MB2469985A3A3C5BD4279EDD87F1849@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469985A3A3C5BD4279EDD87F1849@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a7aa8ac-2da3-41d0-89b6-2da9797ae589;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-25T02:10:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SJ1PR12MB6292:EE_
x-ms-office365-filtering-correlation-id: 7a8260a9-b384-46cd-9986-08db2cd9c2d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NlswSBzO0dbPxRNFFOFvtiSYlptK0BeDVvo7VTOIHgHAH0Ko7uKbPWBNIKUZJ1fGgdngw2PLpBmM1nlARD126G/h71tIU9uV8shMD3lGfeSBHJiA+wQEr+RIG9ImY230tfEY+N7KL3k+NcaVHh9ciNYymvnFMI72nH2A3Gtlv71+EXKp4ZXFjx75W8gKUH76lNQ8IIaUYsPnIuOKPO5ZWEXkn9XnAQYT37OzqKl83so1RbKF6qGbLn4pz0DbCM0nqcXcXyWzXJwjeNKnE/Y8IlQhh4wd2w2LsyFHpRowaqexNyf5OsxV89xJcGN9QPokCXDhC0/wNoF9Hp0DggaIIQ4DTyofyATuauSo0Ygm7/7F57zWzmhAxTYfMblbuoxtiMwRTEUFphSFV4MzlzpJREKVFcGs2GUWs1nmqIU487L10xURD6Plv32HfcZZEOGpa3aJtjxxkk1+UmDa4ivs2lvyoj+8Nygw8i2cxoq17g/h9i2tjhc0iRJd/CvLDAc4FWwJGnrrdBgM1Viu6WG62wOEsD/pozxe7cEEvTIazCS/aLU9y4ObFs2t7qYRQ6tLpnT1oSXPAOVs5FzW04GQD30VwpV3qZRp/welfY3ZY9p0PZVxEou4Lz/EjUjp6v8q2xGR+6Ru3k771UCBzM9AhAdbkWxPsaYw0SG3bMd3izLP95r6yT48mAzOMB3jTTP+rzH5PocRt7Dg4xPbGII2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(52536014)(33656002)(110136005)(66946007)(2906002)(76116006)(38070700005)(4326008)(26005)(6506007)(478600001)(71200400001)(54906003)(7696005)(83380400001)(186003)(316002)(9686003)(53546011)(5660300002)(38100700002)(122000001)(55016003)(8936002)(66556008)(64756008)(66476007)(8676002)(66446008)(41300700001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bn+OeHk9oUqE8WaW+gZfrXS4cgIiFSwUD+273O6GzUBW4wQU7VGbSgsF4Nhw?=
 =?us-ascii?Q?ZNLqVNl3tIgj28gQ/0CXPUbgiL0TNkwx7MT++cgJBKBO+qWuihBnjIv7bUO9?=
 =?us-ascii?Q?fhr5ZP3yWjAOopcHzxsi1tARrpx1x26f2M/EMczFktM/RxX91rzooHtX7wvg?=
 =?us-ascii?Q?0aZ8k+Kpye/9ruj3kyYDdxCR8YkaV8dVwYdUTdIoa/zgVEwgcasnF5m7lTqx?=
 =?us-ascii?Q?BDbGuR18jADPP+LTFcPACpM7/V7hTJFTnYIzHjrWw2PIdBTjH9t9AWcJSamH?=
 =?us-ascii?Q?5IUBXREKv2ZTYmqzBwdYgdiHQd8gaG0Et+h42G7ueHV+SiBHV/XruW3/0SKm?=
 =?us-ascii?Q?blzWpWzcTAmFJFMyYSdk768d7p8o0BF9vIc1GDvY8OCn5KwIxMZ2f/evrJqM?=
 =?us-ascii?Q?TzK2I9wDxrNaAsRtxpBU06GNYTmmakpdawsvGHnGbhJn4vch6ukCRuI0NxUH?=
 =?us-ascii?Q?AUFimeHXuBpUG1uE9PQFxkir3TGYqk/PKaosiyuKML6ffjp+qvJBSNwHoS4V?=
 =?us-ascii?Q?sc/XbNKFAaDfk4Tz7hqlGfs0uaqu29eVKrl2+sB/Y/tP5MNHx/3PoPE75zox?=
 =?us-ascii?Q?c703hLERo/O+sLpybrjZFaArnriCFfgaqtKEbqvQTCgB+hDklk1AH3IS9/iB?=
 =?us-ascii?Q?v6eTu8Je42O8s+7KkDCo/wZtVJa80uAbpg05P3a6PNEQ2DsT71SLbj1+8Tll?=
 =?us-ascii?Q?pGPzOyccY7dH0iR8AQEVcTLq6B86Ddgl4Lzjm215s6xh0kosmiQcxSRGnt4y?=
 =?us-ascii?Q?jhg99NafV5o32QU5FxlfdPHwT7hXkx215Z6FYs3EWnGQrwZ/JWNopQPKxWLF?=
 =?us-ascii?Q?0ArowZvhmNVYDjjf40Rxd7ol/5mYHWNr43p5Yb/P6Y1nVMIASn2uuGVrwnHr?=
 =?us-ascii?Q?wSNVvtG+UhFmWi33tNIJwFtRLaO519e/drg+Tts3kJVQPTlE6wcycZx5fZ78?=
 =?us-ascii?Q?h9QlX5pnvsZToAxsLCWThg/Dge5221PHFZJzj4++ZN+M2oPP3xL2s7FB6weT?=
 =?us-ascii?Q?Gj2tN9GI/C66rgQuddv092PfPpI3jxD1wk2xXdbLSzrKOTPsyoFVW8OGVjye?=
 =?us-ascii?Q?ih5dbR2Amxn25RvATAytQJXtJzp9uzxqo6u2/Q52Q0u67Id99hN1l3j7y4U1?=
 =?us-ascii?Q?VfV/y8mbF4WhVI2knh6IRZ5R6Ifp+RUzSWwDJzG4csPiRRvz2vDpnqHeWoq9?=
 =?us-ascii?Q?v9Coxb4JvydUu6d42EMc7+oahy2Mi2mTZEpMEaAVarCsRNZ0XO0L0Jvf0wOC?=
 =?us-ascii?Q?b/U93ecTaf0Jb032FE71TsFVoWtxcPdJUswbmZmEb5IF2v8ADoFSsdNaQ9Uu?=
 =?us-ascii?Q?IAHXkrffbdDKW0gHX9ldWw5jB/mNIKHAd7CDzQ+8Gump8uSqzhL0mJbC2eA+?=
 =?us-ascii?Q?ijrP1DK3pitQY/8GrquhbjEY0gaJEbDXU8/Gz1tOXEH2oMxQf9M2CuCheCmP?=
 =?us-ascii?Q?lnc4T6IoQEEnbx7KJLkAWpoKqarQaCQBkeIhdIbN+8Rl7YV1a9SXPegDNFob?=
 =?us-ascii?Q?0mn7OPRlhmyWwHdz4xU04gbj80OYgpsmnf21nMfI6pXLBIgu3xhr0/KJFWob?=
 =?us-ascii?Q?T8aoMXUDMyxb2satVQ79kpzyXhgLzKc+E5qdcnUC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8260a9-b384-46cd-9986-08db2cd9c2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 02:36:39.0998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHwCf0wCIxVmQ/rEX3L6VV9UODy1u1+7OGp/52jZ/g7DgZ1LC0gUGNpLm5r+jmkD37p1oM/TVlWkWOctBVdMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, March 24, 2023 3:26 PM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Ma, Li <Li.Ma@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; H=
uang, Tim <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tim
> Huang
> Sent: Friday, March 24, 2023 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
>
> If the gfx imu is poweroff when suspend, then it need to be re-enabled
> when resume.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 ++++++++++++++++-
> ------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..94fe8593444a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -162,10 +162,15 @@ int smu_get_dpm_freq_range(struct smu_context
> *smu,
>
>  int smu_set_gfx_power_up_by_imu(struct smu_context *smu)  {
> -     if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
> -             return -EOPNOTSUPP;
> +     int ret =3D 0;
> +     struct amdgpu_device *adev =3D smu->adev;
>
> -     return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +     if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
> +             ret =3D smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +             if (ret)
> +                     dev_err(adev->dev, "Failed to enable gfx imu!\n");
> +     }
> +     return ret;
>  }
>
>  static u32 smu_get_mclk(void *handle, bool low) @@ -196,6 +201,19 @@
> static u32 smu_get_sclk(void *handle, bool low)
>       return clk_freq * 100;
>  }
>
> +static int smu_set_gfx_imu_enable(struct smu_context *smu) {
> +     struct amdgpu_device *adev =3D smu->adev;
> +
> +     if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> +             return 0;
> +
> +     if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
> +             return 0;
> +
> +     return smu_set_gfx_power_up_by_imu(smu); }
> +
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>                                 bool enable)
>  {
> @@ -1396,15 +1414,9 @@ static int smu_hw_init(void *handle)
>       }
>
>       if (smu->is_apu) {
> -             if ((smu->ppt_funcs->set_gfx_power_up_by_imu) &&
> -                             likely(adev->firmware.load_type =3D=3D
> AMDGPU_FW_LOAD_PSP)) {
> -                     ret =3D smu->ppt_funcs-
> >set_gfx_power_up_by_imu(smu);
> -                     if (ret) {
> -                             dev_err(adev->dev, "Failed to Enable gfx
> imu!\n");
> -                             return ret;
> -                     }
> -             }
> -
> +             ret =3D smu_set_gfx_imu_enable(smu);
> +             if (ret)
> +                     return ret;
>               smu_dpm_set_vcn_enable(smu, true);
>               smu_dpm_set_jpeg_enable(smu, true);
>               smu_set_gfx_cgpg(smu, true);
> @@ -1681,6 +1693,10 @@ static int smu_resume(void *handle)
>               return ret;
>       }
>
> +     ret =3D smu_set_gfx_imu_enable(smu);
> +     if (ret)
> +             return ret;

>> smu_set_gfx_imu_enable in smu_hw_init is valid when sum->is_apu is true.=
 So such check is still necessary in smu_resume?

>>Regards,
>>Guchun

For both hw_init or resume, it should be ok if not have the smu->is_apu che=
cking. Because we will check the valid of smu->ppt_funcs->set_gfx_power_up_=
by_imu in the final call path,
so, for dGPU or APUs without IMU that did not implement this interface will=
 return 0.   Thanks.

Tim

>       smu_set_gfx_cgpg(smu, true);
>
>       smu->disable_uclk_switch =3D 0;
> --
> 2.25.1

