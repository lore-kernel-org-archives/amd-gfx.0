Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8BC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 03:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F30D6138C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 03:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F30D6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977C66E02F;
	Wed,  2 Jun 2021 03:55:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05696E02F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 03:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/OAKTvLd+XaoMMlFoLsvEZ+Tl5MSDP0Vke2txq9MzyYp58MHmsF+eBBnJrxFpK400ggHpTqpfJoU/3PYOaFKr6orPxT26Q+O7uoQGTHTqFCvQH8837OvtWDjzkVhAo9jbjYoUd0cJDZfWFlp1OYP6bFJdUCQ+VlvMzKZXmdEvEv1t642SDXPeugJMWIruQrfUJmdeBk+tFHU3ZYxy6I4z8EKY4iVscajdqfwpdXF2qKZ514FP2c7EmkHQ5HQ+fATW5AqVvsvGQuTBNXiCGP6T8HY2EaGW/hIXzbBBlNDREYV6CqDMQtBZu7e0/4Y0SnLnf+hZKl5aQFpgmEi2QmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxUX8UlZ3RtwVm3Xe2eozgX1q86IU55PUJ7FBFNAqmw=;
 b=Hy078zykQTgdwVGiGhJ67jTj0rBTNLptxXO/EJXu+O2SDFmjoE5PZeJbjJrr/GaSOLhApJEtMeD/q6xyuiexLNrSqAjqPmf47N5ExC4bvaab0h4x6F0pYumPj3/IR0wLl6KxC/1oHpAKdo7OTdVuzwV+wiNTUuGwh1VOdVYXTzH4mc2bRNBQgfLPcR3K+bI92449R60XSSMsHBnf9suT8O9bRwSSdiAlg0znbIejmPJlO3P+pPCxITw0zb+Bio1qWy7CTt1lk+NUgpB5vXhxyRlVtLHUc2PEchwDlJfL920yYNiY0ujeSmcMwbp/ZWdJQ6JZKQaVV68hLc1y/U6kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxUX8UlZ3RtwVm3Xe2eozgX1q86IU55PUJ7FBFNAqmw=;
 b=TLdIbIL3gHzGjCAbfWXX2i9cvJX7ZiSCtrjlywjKnz+iZ0rgbiQSOb9dtPuBW+vb9cSsOUHz6vgDKuYWtAI6VZdSi6TrksCftZvs4fydyBSEftPE5V8rpR+2fE0TCJpjl8JAp+DVX7jiH+inschpYK3agSsCTXRTL7Q/DoDhJvY=
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Wed, 2 Jun 2021 03:55:07 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 03:55:07 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Topic: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Index: AQHXVBYeoepHF8dB0UqdYhF2bLZulqr9HXOAgAEghkWAAF7DgIABevFy
Date: Wed, 2 Jun 2021 03:55:06 +0000
Message-ID: <DM6PR12MB2954060EE8BA02E3E048FECEF03D9@DM6PR12MB2954.namprd12.prod.outlook.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
 <20210528230621.16468-3-darren.powell@amd.com>,
 <CH0PR12MB5348CD424C6F4A5E0A064598973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <DM6PR12MB2954B3E943CD476445C945E9F03F9@DM6PR12MB2954.namprd12.prod.outlook.com>,
 <CH0PR12MB5348DB50C9C32FB21586F41C973E9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348DB50C9C32FB21586F41C973E9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-02T03:54:52.330Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d245a4a0-2ae4-4e3e-aa57-08d9257a35ea
x-ms-traffictypediagnostic: DM5PR12MB1386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1386DB2D36B6377DF3DCE737F03D9@DM5PR12MB1386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O43yHFplLsKdYxQEv8ASa4Iddou+1yAFq8cQXTM3yrUWYEnGjSPBVtC5TSpUjLC4r5S9O901AfXufffL3tjRHHFmaDGl2GrbPFSFGMhiF+O3dAn87PFr0EhbYxDeZT/ip9gByGER1G2KVP4nq5BWKV6KA9MIPgeZ7uklvUfehJc1JpbtQSJ+OOYmFwFitU82CKZP4VtL5haEBxdNGb7NZfOYBKythu2+J2Gvs/rG2Jpy6lSL0PZggAhSBIzAR1rYawTlBQu7+2c4LnroxFFoKpZTHmdfxYPGKTrZXiFoMmkJJbvRHV65k+hlNAXlIuOP+bidiOKubdqCpPV0I+WWF+Vl4WPWPV05TlKC2eC04pgH+mjTQjfr1yDUyV5s5s4L1+igWPIRZExTLr6SRbnZvzgseW5Gkr6+U2Q4YsZVj3h5Sd8/LBuEVIXHjjuo/V7U4WvLxtJRfllZq9Zftm/mzbfXQSEXPMvE3+ziQQkhYIJFNP2HK1A3UMEib8ns+3d23ECpo1uCDUYxdXKq4bPQCixmnkEnK8zEfEeGkOsyK8b03z00UeaS9+HYjzJGfrArW6ASWWTHYkUCWCnE8LmuxrIN5WxxbYYl1ZHaYC+UguM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(9686003)(71200400001)(83380400001)(52536014)(86362001)(19627405001)(478600001)(110136005)(76116006)(66446008)(53546011)(66556008)(55016002)(66946007)(64756008)(66476007)(6506007)(2906002)(38100700002)(316002)(5660300002)(186003)(33656002)(8676002)(7696005)(8936002)(91956017)(30864003)(19627235002)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+fJqKpKqH0Dceje7hut1/Gt9YmDo/XxvutIT6fix5+A9EFML3kwmB9u8ww6i?=
 =?us-ascii?Q?qFExSNkEGnOU3CQkwiowJ0VzTYLIe54PvHgx/qVo/E1WRdXB+RWgFcyKsxVR?=
 =?us-ascii?Q?ZTO81+LdZNeyrxGPOloxG+20TuYg03WQQ243KyOzpLGMCqBFxHUl32bSzaH2?=
 =?us-ascii?Q?epU8+FAyPZR39kjUPCqDrRqqqfLSEFaIf+GxJjXnNPa9of9oT8Zy+tK8cGor?=
 =?us-ascii?Q?LslqaHHFxtAyiq3T7bpGsC+sbMW6/jQ7Nu7KkVkKRozXUvv/UthF2ZWm09zD?=
 =?us-ascii?Q?jo3BoMP+1T0Zp2lHFd+yG/Ng7DtQaIDBKImb4O/Q1cFF5miYc1vEYg7Nu6xg?=
 =?us-ascii?Q?mby5Vf4/DB9b0qAOKU7r5de6iDabXi2a0pDWbVYLNgxxoIOR8Hi1hWHEbvE/?=
 =?us-ascii?Q?OETW5tIZbKxJ0q/lFa3u5aT7u6E08oBUNBx5hUn6DpZ2krwYncs/nNJu+nkH?=
 =?us-ascii?Q?A27uD2JzjHI6dk2sxmPIo5cR5FJ7ZuhmwjhZXv5bgPozk/flXArBp7fPsmLK?=
 =?us-ascii?Q?1T9oDyYSoqlxhFnn89rcolzw7rmxT1Ei76Ivz5ofyhmCyYDXyqneJBMVEjIm?=
 =?us-ascii?Q?2Uhdt/znYUFr33Tn5I+XV5d9Mh1qQu2nx0/+kFTk6DdIPZ5J2pX61PJSUc3n?=
 =?us-ascii?Q?6GdfhpgJ91sU+GRhBDGZ+YKg8RJ1N5ZFqHcbCBhTLOEGs/rq1bPjV1xve6CU?=
 =?us-ascii?Q?K1Uwn5PWD1gnxifUz7qJRo7Oc8ysOKb8NjXyrAZVSt6g9GK96R54u1mE8oRQ?=
 =?us-ascii?Q?vWfWabu054A5Okhs33M5bvbSxFXHWTeYLx3+ULV/sYd+4gb+dKaFjw10zL81?=
 =?us-ascii?Q?t70QYOipNx+GJ9PvvsryTiWdDB3ps5pDitge7y2spIDoIy8Cgtq6FuX67p+T?=
 =?us-ascii?Q?fzbciYLJIow1pMvofKD8QJpAYrSqsY9SY1Yy9gXTh9FYPkmJDX1r5oHpofIN?=
 =?us-ascii?Q?5QDZOaIU6q3FFO/g733tYJEjrAGW5pt1bphIkmiVpBtUfxXHlSjiUX389wDY?=
 =?us-ascii?Q?U3yJ7L2gH4Sy5Uw0ECKqYO2xMfSxQpwW1Fm5VRceuAF48CpA/RPmn0JnR3uO?=
 =?us-ascii?Q?+pke/NcbdqVGbz8CSokBCy4Be5Nd2B74rXPkcX0xxQEt5F8/Et/orkpCK2Yf?=
 =?us-ascii?Q?gKUesDWygN1e57lmJpcdOdBhf2sWl5E8oEIW1A3qXP9WU3VrFTZFyP6mMOMi?=
 =?us-ascii?Q?/C9f9bWR4//uq2Ij1PqwiFLuBWMjSlXwlm/sMJAK7fnZkSM4fViU7cG1Zqpr?=
 =?us-ascii?Q?OkXit+x+MoNO+Qolvwkl+uFvCTt3YjcBlptxRlSxoWw0l6Vz3gnMuEKk9GE5?=
 =?us-ascii?Q?UrKHdA6XcMCjb2KscRXd1kbp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d245a4a0-2ae4-4e3e-aa57-08d9257a35ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 03:55:06.9555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3omhOD7hXhfa8Vao0CDc6jvEj7i6EfLyBym6ce7X8NWOADMtH9gghBNxYv+vRHAbIwW6lVts1D7B119ZBwVZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
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
Content-Type: multipart/mixed; boundary="===============1275543689=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1275543689==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2954060EE8BA02E3E048FECEF03D9DM6PR12MB2954namp_"

--_000_DM6PR12MB2954060EE8BA02E3E048FECEF03D9DM6PR12MB2954namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I'm not sure exactly what you are looking for. The enums sample_window and =
limit_level map to power{1,2} and cap{min,max,default,current} respectively=
. I added the enums to make the function signatures more readable and stop =
the use of value as an input and output variable.
Please give more specific example?
Darren

=3D HWMON Mapping =3D
=3D=3D Read =3D=3D

SENSOR(power1_average)     amdgpu_hwmon_show_power_avg(0)           amdgpu_=
dpm_read_sensor(AMDGPU_PP_SENSOR_GPU_POWER)
SENSOR(power1_cap_max)     amdgpu_hwmon_show_power_cap_max(0)       get_pow=
er_limit(PP_PWR_LIMIT_MAX, PP_PWR_WINDOW_DEFAULT)
SENSOR(power1_cap_min)     amdgpu_hwmon_show_power_cap_min(0)       0
SENSOR(power1_cap)         amdgpu_hwmon_show_power_cap(0)           get_pow=
er_limit(PP_PWR_LIMIT_CURRENT, PP_PWR_WINDOW_DEFAULT)
SENSOR(power1_cap_default) amdgpu_hwmon_show_power_cap_default(0)   get_pow=
er_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_DEFAULT)
SENSOR(power1_label)       amdgpu_hwmon_show_power_label(0)         "slowPP=
T"
SENSOR(power2_average)     amdgpu_hwmon_show_power_avg(1)           amdgpu_=
dpm_read_sensor(AMDGPU_PP_SENSOR_GPU_POWER)
SENSOR(power2_cap_max)     amdgpu_hwmon_show_power_cap_max(1)       get_pow=
er_limit(PP_PWR_LIMIT_MAX, PP_PWR_WINDOW_FAST)
SENSOR(power2_cap_min)     amdgpu_hwmon_show_power_cap_min(1)       0
SENSOR(power2_cap)         amdgpu_hwmon_show_power_cap(1)           get_pow=
er_limit(PP_PWR_LIMIT_CURRENT, PP_PWR_WINDOW_FAST)
SENSOR(power2_cap_default) amdgpu_hwmon_show_power_cap_default(1)   get_pow=
er_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_FAST)
SENSOR(power2_label)       amdgpu_hwmon_show_power_label(1)         "fastPP=
T"


=3D=3D Write =3D=3D

SENSOR(power1_cap)         amdgpu_hwmon_set_power_cap(0,value)      set_pow=
er_limit( (0<<24) || value )
SENSOR(power2_cap)         amdgpu_hwmon_set_power_cap(1,value)      set_pow=
er_limit( (1<<24) || value )



=3D Summary =3D

power1 =3D> PP_PWR_WINDOW_DEFAULT   ( label ("slowPPT"))
power2 =3D> PP_PWR_WINDOW_FAST      ( label ("fastPPT"))


power_avg         =3D> AMDGPU_PP_SENSOR_GPU_POWER
power_cap_max     =3D> PP_PWR_LIMIT_MAX
power_cap_min     =3D> PP_PWR_LIMIT_MIN (optimized to 0)
power_cap         =3D> PP_PWR_LIMIT_CURRENT
power_cap_default =3D> PP_PWR_LIMIT_DEFAULT



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 1, 2021 12:56 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature


[Public]



May be just call it power_limit or power_cap similar to hwmon. The various =
limits correspond to hwmon power[1-*]_cap and levels correspond to min/ max=
 etc.



Thanks,

Lijo



From: Powell, Darren <Darren.Powell@amd.com>
Sent: Tuesday, June 1, 2021 4:50 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature



[Public]



>< > The limits are not limited to sample window. There are limits like APU=
 only limit, platform limit and totally obscure ones like PPT0/PPT1 etc.
>It's better that the new enum takes care of those as well in case there is=
 a need to make them available through sysfs.



I think you mean something more like this?

+ enum pp_power_constraints
+{
+       PP_PWR_CONSTRAINT_DEFAULT,
+       PP_PWR_CONSTRAINT_FASTWINDOW,
+};
+





________________________________

From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Monday, May 31, 2021 2:04 AM
To: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature



[Public]



-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Sent: Saturday, May 29, 2021 4:36 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signa=
ture

 add two new powerplay enums (limit_level, sample_window)  add enums to smu=
_get_power_limit signature  remove input bitfield stuffing of output variab=
le limit  update calls to smu_get_power_limit

* Test
 AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`  AMD=
GPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -=
f 10`  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=3D=3D=3D power1 cap =3D=3D=3D" ; cat $HWMON_DIR/power1_cap ;       =
    \
 echo "=3D=3D=3D power1 cap max =3D=3D=3D" ; cat $HWMON_DIR/power1_cap_max =
;   \
 echo "=3D=3D=3D power1 cap def =3D=3D=3D" ; cat $HWMON_DIR/power1_cap_defa=
ult

Signed-off-by: Darren Powell <darren.powell@amd.com<mailto:darren.powell@am=
d.com>>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 14 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 +++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++--
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..ddbf802ea8ad 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,20 @@ enum pp_df_cstate {
         DF_CSTATE_ALLOW,
 };

+enum pp_power_limit_level
+{
+       PP_PWR_LIMIT_MIN =3D -1,
+       PP_PWR_LIMIT_CURRENT,
+       PP_PWR_LIMIT_DEFAULT,
+       PP_PWR_LIMIT_MAX,
+};
+
+ enum pp_power_sample_window
+{
+       PP_PWR_WINDOW_DEFAULT,
+       PP_PWR_WINDOW_FAST,
+};
+

< > The limits are not limited to sample window. There are limits like APU =
only limit, platform limit and totally obscure ones like PPT0/PPT1 etc.
It's better that the new enum takes care of those as well in case there is =
a need to make them available through sysfs.

Thanks,
Lijo

 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 13da377888d2..f7b45803431d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         uint32_t max_limit =3D 0;
         ssize_t size;
         int r;
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         ssize_t size;
         int r;

@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRE=
NT);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURREN=
T,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         ssize_t size;
         int r;

@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAU=
LT);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAUL=
T,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 523f9d2982e9..b97b960c2eac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {  #if !defined(SWSMU_=
CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYE=
R_L4)  int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
-                       enum smu_ppt_limit_level limit_level);
+                       enum pp_power_limit_level pp_limit_level,
+                       enum pp_power_sample_window sample_window);

 bool smu_mode1_reset_is_support(struct smu_context *smu);  bool smu_mode2_=
reset_is_support(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd=
/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8aff67a667fa..44c1baa2748d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint=
32_t speed)

 int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
-                       enum smu_ppt_limit_level limit_level)
+                       enum pp_power_limit_level pp_limit_level,
+                       enum pp_power_sample_window sample_window)
 {
-       uint32_t limit_type =3D *limit >> 24;
+       enum smu_ppt_limit_level limit_level;
+       uint32_t limit_type;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                 return -EOPNOTSUPP;

+       switch(sample_window) {
+       case PP_PWR_WINDOW_DEFAULT:
+               limit_type =3D SMU_DEFAULT_PPT_LIMIT;
+               break;
+       case PP_PWR_WINDOW_FAST:
+               limit_type =3D SMU_FAST_PPT_LIMIT;
+               break;
+       default:
+               return -EOPNOTSUPP;
+               break;
+       }
+
+       switch(pp_limit_level){
+       case PP_PWR_LIMIT_CURRENT:
+               limit_level =3D SMU_PPT_LIMIT_CURRENT;
+               break;
+       case PP_PWR_LIMIT_DEFAULT:
+               limit_level =3D SMU_PPT_LIMIT_DEFAULT;
+               break;
+       case PP_PWR_LIMIT_MAX:
+               limit_level =3D SMU_PPT_LIMIT_MAX;
+               break;
+       case PP_PWR_LIMIT_MIN:
+       default:
+               return -EOPNOTSUPP;
+               break;
+       }
+
         mutex_lock(&smu->mutex);

         if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT) {
--
2.25.1

--_000_DM6PR12MB2954060EE8BA02E3E048FECEF03D9DM6PR12MB2954namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm not sure exactly what you are looking for. The enums sample_window and =
limit_level map to power{1,2} and cap{min,max,default,current} respectively=
. I added the enums to make the function signatures more readable and stop =
the use of value as an input and
 output variable.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please give more specific example?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Darren&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>
<div>=3D HWMON Mapping =3D</div>
<div>=3D=3D Read =3D=3D</div>
</div>
<div></div>
<pre style=3D"font-family:monospace, monospace;background-color:rgb(248, 24=
9, 250);border:1px solid rgb(234, 236, 240);padding:1em;line-height:1.3em;f=
ont-size:14px">SENSOR(power1_average) &nbsp; &nbsp; amdgpu_hwmon_show_power=
_avg(0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_dpm_read_sensor(AMDGPU_PP=
_SENSOR_GPU_POWER)=0A=
SENSOR(power1_cap_max) &nbsp; &nbsp; amdgpu_hwmon_show_power_cap_max(0) &nb=
sp; &nbsp; &nbsp; get_power_limit(PP_PWR_LIMIT_MAX, PP_PWR_WINDOW_DEFAULT)=
=0A=
SENSOR(power1_cap_min) &nbsp; &nbsp; amdgpu_hwmon_show_power_cap_min(0) &nb=
sp; &nbsp; &nbsp; 0=0A=
SENSOR(power1_cap) &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hwmon_show_power_cap(=
0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_power_limit(PP_PWR_LIMIT_CURRENT,=
 PP_PWR_WINDOW_DEFAULT)=0A=
SENSOR(power1_cap_default) amdgpu_hwmon_show_power_cap_default(0) &nbsp; ge=
t_power_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_DEFAULT)=0A=
SENSOR(power1_label) &nbsp; &nbsp; &nbsp; amdgpu_hwmon_show_power_label(0) =
&nbsp; &nbsp; &nbsp; &nbsp; &quot;slowPPT&quot;=0A=
SENSOR(power2_average) &nbsp; &nbsp; amdgpu_hwmon_show_power_avg(1) &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_dpm_read_sensor(AMDGPU_PP_SENSOR_GPU_POW=
ER)=0A=
SENSOR(power2_cap_max) &nbsp; &nbsp; amdgpu_hwmon_show_power_cap_max(1) &nb=
sp; &nbsp; &nbsp; get_power_limit(PP_PWR_LIMIT_MAX, PP_PWR_WINDOW_FAST)=0A=
SENSOR(power2_cap_min) &nbsp; &nbsp; amdgpu_hwmon_show_power_cap_min(1) &nb=
sp; &nbsp; &nbsp; 0=0A=
SENSOR(power2_cap) &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hwmon_show_power_cap(=
1) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_power_limit(PP_PWR_LIMIT_CURRENT,=
 PP_PWR_WINDOW_FAST)=0A=
SENSOR(power2_cap_default) amdgpu_hwmon_show_power_cap_default(1) &nbsp; ge=
t_power_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_FAST)=0A=
SENSOR(power2_label) &nbsp; &nbsp; &nbsp; amdgpu_hwmon_show_power_label(1) =
&nbsp; &nbsp; &nbsp; &nbsp; &quot;fastPPT&quot;=0A=
</pre>
<div>
<div>=3D=3D Write =3D=3D</div>
</div>
<pre style=3D"font-family:monospace, monospace;background-color:rgb(248, 24=
9, 250);border:1px solid rgb(234, 236, 240);padding:1em;line-height:1.3em;f=
ont-size:14px">SENSOR(power1_cap) &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hwmon_=
set_power_cap(0,value) &nbsp; &nbsp; &nbsp;set_power_limit( (0&lt;&lt;24) |=
| value )=0A=
SENSOR(power2_cap) &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hwmon_set_power_cap(1=
,value) &nbsp; &nbsp; &nbsp;set_power_limit( (1&lt;&lt;24) || value )=0A=
</pre>
<p style=3D"margin:0.5em 0px;color:rgb(34, 34, 34);font-family:sans-serif;f=
ont-size:14px;background-color:rgb(255, 255, 255)">
<br>
</p>
<div>=3D Summary =3D</div>
<pre style=3D"font-family:monospace, monospace;background-color:rgb(248, 24=
9, 250);border:1px solid rgb(234, 236, 240);padding:1em;line-height:1.3em;f=
ont-size:14px">power1 =3D&gt; PP_PWR_WINDOW_DEFAULT &nbsp; ( label (&quot;s=
lowPPT&quot;))=0A=
power2 =3D&gt; PP_PWR_WINDOW_FAST &nbsp; &nbsp; &nbsp;( label (&quot;fastPP=
T&quot;))=0A=
</pre>
<pre style=3D"font-family:monospace, monospace;background-color:rgb(248, 24=
9, 250);border:1px solid rgb(234, 236, 240);padding:1em;line-height:1.3em;f=
ont-size:14px">power_avg &nbsp; &nbsp; &nbsp; &nbsp; =3D&gt; AMDGPU_PP_SENS=
OR_GPU_POWER=0A=
power_cap_max &nbsp; &nbsp; =3D&gt; PP_PWR_LIMIT_MAX=0A=
power_cap_min &nbsp; &nbsp; =3D&gt; PP_PWR_LIMIT_MIN (optimized to 0)=0A=
power_cap &nbsp; &nbsp; &nbsp; &nbsp; =3D&gt; PP_PWR_LIMIT_CURRENT=0A=
power_cap_default =3D&gt; PP_PWR_LIMIT_DEFAULT</pre>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 1, 2021 12:56 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Segoe UI"}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheaderc10f11a2, li.x_msipheaderc10f11a2, div.x_msipheaderc10f11a2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Public=
]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">May be just call it power_limit or power_cap simil=
ar to hwmon. The various limits correspond to hwmon power[1-*]_cap and leve=
ls correspond to min/ max etc.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks,</p>
<p class=3D"x_MsoNormal">Lijo</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Powell, Darren &lt;Darren.Powell@amd.=
com&gt; <br>
<b>Sent:</b> Tuesday, June 1, 2021 4:50 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Subject:</b> Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sa=
ns-serif; color:black"><br>
<span style=3D"background:white">&gt;&lt; &gt; The limits are not limited t=
o sample window. There are limits like APU only limit, platform limit and t=
otally obscure ones like PPT0/PPT1 etc.</span><br>
<span style=3D"background:white">&gt;It's better that the new enum takes ca=
re of those as well in case there is a need to make them available through =
sysfs.</span></span><span style=3D"font-size:12.0pt; color:black"></span></=
p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">I th=
ink you mean something more like this?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sa=
ns-serif; color:black; background:white">+ enum pp_power_constraints</span>=
<span style=3D"font-size:12.0pt; color:black"><br>
</span><span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif; color:bl=
ack; background:white">+{</span><span style=3D"font-family:&quot;Segoe UI&q=
uot;,sans-serif; color:black"><br>
<span style=3D"background:white">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_P=
WR_CONSTRAINT_DEFAULT,</span><br>
<span style=3D"background:white">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_P=
WR_CONSTRAINT_FASTWINDOW,</span><br>
<span style=3D"background:white">+};</span><br>
<span style=3D"background:white">+</span></span><span style=3D"font-size:12=
.0pt; color:black"></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.=
com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, May 31, 2021 2:04 AM<br>
<b>To:</b> Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darr=
en.Powell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[Public]<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darren.Po=
well@amd.com</a>&gt;
<br>
Sent: Saturday, May 29, 2021 4:36 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darren.Powe=
ll@amd.com</a>&gt;<br>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signa=
ture<br>
<br>
&nbsp;add two new powerplay enums (limit_level, sample_window)&nbsp; add en=
ums to smu_get_power_limit signature&nbsp; remove input bitfield stuffing o=
f output variable limit&nbsp; update calls to smu_get_power_limit<br>
<br>
* Test<br>
&nbsp;AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d=
 &quot; &quot; -f 1`&nbsp; AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $=
AMDGPU_PCI_ADDR | cut -d &quot; &quot; -f 10`&nbsp; HWMON_DIR=3D/sys/class/=
hwmon/${AMDGPU_HWMON}<br>
<br>
&nbsp;lspci -nn | grep &quot;VGA\|Display&quot; ; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap =3D=3D=3D&quot; ; cat $HWMON_DIR/powe=
r1_cap ;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap max =3D=3D=3D&quot; ; cat $HWMON_DIR/=
power1_cap_max ;&nbsp;&nbsp; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap def =3D=3D=3D&quot; ; cat $HWMON_DIR/=
power1_cap_default<br>
<br>
Signed-off-by: Darren Powell &lt;<a href=3D"mailto:darren.powell@amd.com">d=
arren.powell@amd.com</a>&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; | 14 +++=
+++++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 18 +++++-----<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | 3=
4 +++++++++++++++++--<br>
&nbsp;4 files changed, 57 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index b1cd52a9d684..ddbf802ea8ad 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -192,6 +192,20 @@ enum pp_df_cstate {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF_CSTATE_ALLOW,<br>
&nbsp;};<br>
&nbsp;<br>
+enum pp_power_limit_level<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_MIN =3D -1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_CURRENT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_DEFAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_MAX,<br>
+};<br>
+<br>
+ enum pp_power_sample_window<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_WINDOW_DEFAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_WINDOW_FAST,<br>
+};<br>
+<br>
<br>
&lt; &gt; The limits are not limited to sample window. There are limits lik=
e APU only limit, platform limit and totally obscure ones like PPT0/PPT1 et=
c.
<br>
It's better that the new enum takes care of those as well in case there is =
a need to make them available through sysfs.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&nbsp;#define PP_GROUP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF00=
00000<br>
&nbsp;#define PP_GROUP_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 13da377888d2..f7b45803431d 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_limit =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_MAX);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
MAX, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_CURRENT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
CURRENT, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_DEFAULT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
DEFAULT, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 523f9d2982e9..b97b960c2eac 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {&nbsp; #if !defined(S=
WSMU_CODE_LAYER_L2) &amp;&amp; !defined(SWSMU_CODE_LAYER_L3) &amp;&amp; !de=
fined(SWSMU_CODE_LAYER_L4)&nbsp; int smu_get_power_limit(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_lim=
it_level limit_level);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_li=
mit_level pp_limit_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sa=
mple_window sample_window);<br>
&nbsp;<br>
&nbsp;bool smu_mode1_reset_is_support(struct smu_context *smu);&nbsp; bool =
smu_mode2_reset_is_support(struct smu_context *smu); diff --git a/drivers/g=
pu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.=
c<br>
index 8aff67a667fa..44c1baa2748d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint=
32_t speed)<br>
&nbsp;<br>
&nbsp;int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_lim=
it_level limit_level)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_li=
mit_level pp_limit_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sa=
mple_window sample_window)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type =3D *limit &gt;&g=
t; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_limit_level limit_level;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(sample_window) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_WINDOW_DEFAULT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_type =3D SMU_DEFAULT_PPT_LIMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_WINDOW_FAST:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_type =3D SMU_FAST_PPT_LIMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(pp_limit_level){<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_CURRENT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_CURRENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_DEFAULT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_DEFAULT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_MAX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_MAX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_MIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit_type !=3D SMU_DE=
FAULT_PPT_LIMIT) {<br>
--<br>
2.25.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2954060EE8BA02E3E048FECEF03D9DM6PR12MB2954namp_--

--===============1275543689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1275543689==--
