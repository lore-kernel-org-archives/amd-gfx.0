Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF3E10E258;
	Thu,  9 Dec 2021 16:53:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13BD10ED2E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwyRYNcrTRGmlXIP+MKcp2lZx+tiQgqkBOXHvIBRyj6HaJ84N3cMOZAxqN3N4eb8+nkhYltEjAZFK1s/wPqBlwA6ZhBLIbpbk2B6Oa5rKRgVwo8MWlvP0ieBlg9+MJB5/DHxv9a2gEXBUeH4yTiipF866VqP4C7ueZGIgjXAZHMdVOyTO3xKDeaY22+sT/r02wge8WiWk5AbItEj+ohUA9xfj9qQ9xXzLU3Zi/lxXX/3qD9ehpzwP5pAHXb9A4bvBMvNyIcwcTZjOd0kmmWHd5bi1HTRfWCHzUu1BnHwbeIMJr6k+UH0XKkBczK1361D28dtq5Ioc3TPO2hy7kfcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUCemSu3rlMefkxV/fN3r26Edh0XS8t3Z8mMgZxtd0o=;
 b=Q3iA+na+cgM9tVIJnfJIhPbY0iWfJevqi6YwXjtqY0l/Ne97mkx4w3dbFW1CEsA35XJFjL+J5A8BOR5a1mOVci45MNtBw8VTuPzS0YeOGEBKIY+0u6XVV7G/tITeki35lGJ02QoIPruzHTltXEM54XAAK29eVmOArTJlD0UUX7/aJzWW+hzvTHm9+7kvlzKASk+ITFSI20WYwJZonAn0K74G/QqFrgisCYs00velpftlQink09iOqVfYXB2q/+OKmWNMDw8pwOze2WMSvIvUFHckkzu5LjMwLe08A7fdGwtjX2Dqw+/h3iweokzWu1+sXD6Zyq1ZwjkBB+CnWdTVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUCemSu3rlMefkxV/fN3r26Edh0XS8t3Z8mMgZxtd0o=;
 b=I9gbBSe/qZjAZr9GNluDeFdo3MfC3R2Znali38et4byGOzmCN5lj/upCT/WEp9fJ0HdBI0rn4TlBHPvQMFvhf9Gx+22ThUdePW76kcdj8BkzSLDbas8TnrLaUFfo+Nc9xGLVfRfJ/xiRo2XQaT+okfsCZqJzdDxr5uLcrDFMges=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 01:48:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 01:48:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Thread-Topic: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Thread-Index: AQHX6/4HOLaLs2wvbk2Gxt3AQmcr26wpZHxQ
Date: Thu, 9 Dec 2021 01:48:27 +0000
Message-ID: <DM6PR12MB26198BCA8EBB91200235DC52E4709@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211208063609.5593-1-darren.powell@amd.com>
 <20211208063609.5593-2-darren.powell@amd.com>
In-Reply-To: <20211208063609.5593-2-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-09T01:48:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2a884311-7190-471b-b01f-de34c76b574e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae870861-10bd-4862-f718-08d9bab5fea8
x-ms-traffictypediagnostic: DM6PR12MB3577:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3577A7B622AFFDA7B725B69DE4709@DM6PR12MB3577.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tRtf/7N7vQ8fQINUjWZvDZRqQ7c4nrp9JRrmrBYGTmBVByppnoGYdgv0aaM7jNvTXPgT5v+B56xQI8WcIJ+I/IT9wpqD+DiKkrQ3lWyptooX1xsJgZpNpuNihBBtK1iu+nR5uGqQm+LH3C3qZZ+7j91QGNzZ6NBzFORSYJ3GWiN7N9QiaQZDXrTKaNynX/cfBvr1khTuEERFSpwyAAhGSbtZefOlzW9EvhEvQ2IYorbPYAYRRAHzqHdwc24gfH+yDMqZ8GFIOJsIB4CI65Fo1vjUeXzyyYpl/JMPxXhkGa/+qUEV0e4/2nzKEUTf3ZZ1raOou816QV3PlAO8UDVIkFEmc+oWw1gA6bs+dNXkCfSc6mVifLctLE1wIyBs5Me0g0nNySv+44lpg3ufqO/wb4t6RozVQUsjiyi/2y36Xde/qn2igeVaYkKRBD/w3WYHYqWEgKXsWoxYcc+7NbKVRLiKdjy1ZGXBeUM7POiFK8O63c2955NWYQ5LF07u/tZp53hmq6rofuCzRAS0fqcN7HqENgOfBaKdISkLBW3cC56c9okuWHLaDLJAzxuzSeOQZVMy6JMbTQsoD5ESFMXPLcl1lsNQt3t+YHAYyvq9OaSEUZxzFAyi93nTPjcJVZAoWjTbSCYipsO6qc8iyiVXhtSvR5EtRJGR6dlNOH9Ks4qsFjAU7hTL2g5jIXDhm72Fq8woLSal4AAPLv5yfggM+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(64756008)(53546011)(55016003)(86362001)(38070700005)(2906002)(66556008)(8676002)(4326008)(316002)(6506007)(8936002)(9686003)(110136005)(30864003)(52536014)(76116006)(71200400001)(122000001)(7696005)(966005)(33656002)(66476007)(66946007)(186003)(5660300002)(508600001)(26005)(83380400001)(38100700002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2T/SbC/U9PQ50CRDZGc/4z9WOHVhGTCDt5BgRGtAHesswUzF5Venc28GJrHN?=
 =?us-ascii?Q?Kpa69hbmjb6yrCRtp+CCDbd4lutzjrNRSeingrKiBH7hvCCvq8+cPfd/3KSk?=
 =?us-ascii?Q?6o/7h93ERHUZLEtHiO3nWh9mJCuObWZtNAXApMmQPbEszlaB+O5PJbXzbVjb?=
 =?us-ascii?Q?qWBup3iDToxFCle9lDyM9aYM6gPpHHc2qZwZwbU3Wn4DHiSOS5jLVRUogt3F?=
 =?us-ascii?Q?pyjIfAVpSRAVhTTCEqhaE4xPW+i2VUbQVsWfCeZVu9JA+5O9W5Yy7E4oC/rl?=
 =?us-ascii?Q?c91Q0Sfi0rfp1XABp31QCHszFCG+StmNXgCIZQFSCY0IUc/pwBKQhW1Qige9?=
 =?us-ascii?Q?4mJLPoOlfHT2ZtVuMM+i9CDgZA1oyJDblYIOSqGZb4M8/AqXIfyUbq5u9z/C?=
 =?us-ascii?Q?ftMGyPcdjli8pBYmyqRjvdOcC4zujlgsvq6pt6rbDd25OwAf8qRmSywwCI8l?=
 =?us-ascii?Q?K9SrN7hEIiAcV+P1Jq6v3pRj0/F+usYKK/K8s0Cn0lqqPxpkWHQCkRe29bop?=
 =?us-ascii?Q?FzOun0CwX8mwmX5GlHT4BnczsuLSA2fKdFSpunmr01ktT0YG0N1SXFnEZxrj?=
 =?us-ascii?Q?er+qVdMeYOv1NUoazPNp8oVfNginNCVX47qyeQJESe+GQOam5zBvZG04NZVF?=
 =?us-ascii?Q?5cKyAbu8a1lDDkjqieAhAaC32OrjVzQWrd1+JL4IjmYJK4W5NcfNKDgCyaT0?=
 =?us-ascii?Q?3BsrV50oznQ1465AVfaZ/LadtiBOyvU6K1pj3aV07kEklLQsH41gzXyAJs0F?=
 =?us-ascii?Q?EpU4wWzqZfgd4l23Mf3YtOzxIlgvG9p0OP9+7++6rA41kAhXu9SS4QlraRpu?=
 =?us-ascii?Q?V/V7kTh7ysBV6S8+CXzUYQHa0k7QPW4dKvKQ6NlUZFaZFDI8iKnzGomy6qpc?=
 =?us-ascii?Q?IzgnZ4sgljXKGoKBimPDch9YvbO/GSSydB5wbmY3r/Cj+naN5huqNumBkP09?=
 =?us-ascii?Q?nNft4+BuFEHy5EdVm3mVyzllPg4ugC3/znFUYJK8SgDDVWJCxS7K4ZxTky0j?=
 =?us-ascii?Q?fWVKqf8JY+rL6FnJYZobCzjo0g7a1wjQKVz0OyC1KhvN2xS3WlieHmaq4Yeq?=
 =?us-ascii?Q?4HukfDxdf5JKkNDpVfPvGz1Ih3CcramQAs8jXhZGXsUuu2FvyJ4FeMrP7QRY?=
 =?us-ascii?Q?vPTD7a7URGbrmaSpnyZOI3AclTFr3xDDMDG+cyWKSbn2VYCjAWwgWi7dez4y?=
 =?us-ascii?Q?ovcVR2k0cPPF8s83EWDWGm82pCro21c3REdC1fPyQqOr1vmeHuZ+CmnxPdKg?=
 =?us-ascii?Q?Rz0RYcIUe4QGbJAH2ZtykMQXXtqqnYlSS2hdURX0sHz828d3VuKK0Ln4iwCn?=
 =?us-ascii?Q?FkMANEekqYRvtRnY/O6I9HQ/yAXP0X9lPi9jPs656k4RJ1krabmxD3EVfuu6?=
 =?us-ascii?Q?+aOgkxX3E0bigZiX+JpeC8MzrzaRfpdRwSOefx3ht2EEdaz1e3mwnj3qESNQ?=
 =?us-ascii?Q?xshER75MbCrFVC1gRbfY2z/sZvggDKJzykNcm/Gpsu1nrznz3IQ5IBSFdMus?=
 =?us-ascii?Q?GJMe3pnjbXJtO1K2umhcbHiVK6hPEzlHN2XzGPELf+c6oOjnyLeqF7hP8feN?=
 =?us-ascii?Q?7Bypv2VklUuzpEBJiw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae870861-10bd-4862-f718-08d9bab5fea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 01:48:27.2129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKQksn5lou7+lHy99jHrqWRI2UEF4k7BtYtq8CzXCvGnWp61WXQM6yEn386MRTE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
X-OriginatorOrg: amd.com
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
Cc: "Powell, Darren" <Darren.Powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Darren Powell
> Sent: Wednesday, December 8, 2021 2:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
> accepts buffer base and write offset
>=20
>  - new power management function emit_clk_levels implemented by
> navi10_emit_clk_levels()
>        This function currently duplicates the functionality of
> navi10_print_clk_levels, where
>        snprintf is used write to the sysfs buffer. The first implementati=
on to use
> sysfs_emit
>        was unsuccessful due to requirement that buf must be aligned to a
> specific memory
>        boundary. This solution passes the buffer base and write offset do=
wn the
> stack.
>  - new power management function emit_clock_levels implemented by
> smu_emit_ppclk_levels()
>        This function combines implementation of smu_print_ppclk_levels an=
d
>        smu_print_smuclk_levels and calls emit_clk_levels
>  - new helper function smu_convert_to_smuclk called by
> smu_print_ppclk_levels and
>        smu_emit_ppclk_levels
>  - emit_clock_levels currently returns the length of the string written t=
o the
> buffer,
>        maintaining the behaviour of print_clock_levels, but will be upgra=
ded to
> return
>        error values in a subsequent patch
>  - failure of the emit_clock_levels at the top level
> (amdgpu_get_pp_dpm_clock) triggers a
>        fallback to the print_clock_levels, which can be removed after
> emit_clock_levels is
>        implemented across all platforms.
>=20
>  =3D=3D Test =3D=3D
>  LOGFILE=3Dpp_clk.test.log
>  AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>  AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR |
> awk '{print $9}'`
>  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>=20
>  lspci -nn | grep "VGA\|Display"  > $LOGFILE
>  FILES=3D"pp_od_clk_voltage
>  pp_dpm_sclk
>  pp_dpm_mclk
>  pp_dpm_pcie
>  pp_dpm_socclk
>  pp_dpm_fclk
>  pp_dpm_dcefclk
>  pp_dpm_vclk
>  pp_dpm_dclk "
>=20
>  for f in $FILES
>  do
>    echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
>  done
>  cat $LOGFILE
>=20
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  20 +-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  10 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  50 ++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 189
> ++++++++++++++++++
>  6 files changed, 262 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index bac15c466733..43f43a4f321b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -310,6 +310,7 @@ struct amd_pm_funcs {
>  	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>  	int (*force_clock_level)(void *handle, enum pp_clock_type type,
> uint32_t mask);
>  	int (*print_clock_levels)(void *handle, enum pp_clock_type type,
> char *buf);
> +	int (*emit_clock_levels)(void *handle, enum pp_clock_type type,
> char *buf, int *offset);
>  	int (*force_performance_level)(void *handle, enum
> amd_dpm_forced_level level);
>  	int (*get_sclk_od)(void *handle);
>  	int (*set_sclk_od)(void *handle, uint32_t value);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 49df4c20f09e..a1169a2397ca 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1056,8 +1056,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	ssize_t size;
> -	int ret;
> +	int size =3D 0;
> +	int ret =3D 0;
>=20
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> @@ -1070,10 +1070,18 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->print_clock_levels)
> -		size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> -	else
> -		size =3D sysfs_emit(buf, "\n");
> +	ret =3D -EOPNOTSUPP;
> +	if (adev->powerplay.pp_funcs->emit_clock_levels) {
> +		ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf,
> &size);
> +	}
The whole idea seems fine to me. However, we are trying to do some cleanups=
 to avoid spiking into power internals(as above via adev->powerplay.pp_func=
s->emit_clock_levels).
Check the patch series below:
https://lists.freedesktop.org/archives/amd-gfx/2021-December/072096.html
So, it would be better if you can rebase the patches here based on that. Or=
 you can wait a while to let me land them first.

BR
Evan
> +
> +	if (ret < 0) {
> +		if (adev->powerplay.pp_funcs->print_clock_levels) {
> +			size =3D amdgpu_dpm_print_clock_levels(adev, type,
> buf);
> +		}
> +		else
> +			size =3D sysfs_emit(buf, "\n");
> +	}
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 16e3f72d31b9..95add7afcc86 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -310,6 +310,9 @@ enum amdgpu_pcie_gen {
>  #define amdgpu_dpm_print_clock_levels(adev, type, buf) \
>  		((adev)->powerplay.pp_funcs->print_clock_levels((adev)-
> >powerplay.pp_handle, type, buf))
>=20
> +#define amdgpu_dpm_emit_clock_levels(adev, type, buf, offset) \
> +		((adev)->powerplay.pp_funcs->emit_clock_levels((adev)-
> >powerplay.pp_handle, type, buf, offset))
> +
>  #define amdgpu_dpm_force_clock_level(adev, type, level) \
>  		((adev)->powerplay.pp_funcs->force_clock_level((adev)-
> >powerplay.pp_handle, type, level))
>=20
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..dc1325783c10 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -620,6 +620,16 @@ struct pptable_funcs {
>  	 */
>  	int (*print_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf);
>=20
> +	/**
> +	 * @emit_clk_levels: Print DPM clock levels for a clock domain
> +	 *                    to buffer using sysfs_emit_at. Star current level=
.
> +	 *
> +	 * Used for sysfs interfaces.
> +	 * &buf: sysfs buffer
> +	 * &offset: offset within buffer to start printing
> +	 */
> +	int (*emit_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf, int *offset);
> +
>  	/**
>  	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
>  	 *                    domain.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e156add7b560..b0638d8308d2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2397,11 +2397,8 @@ static int smu_print_smuclk_levels(struct
> smu_context *smu, enum smu_clk_type cl
>  	return ret;
>  }
>=20
> -static int smu_print_ppclk_levels(void *handle,
> -				  enum pp_clock_type type,
> -				  char *buf)
> +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type
> type)
>  {
> -	struct smu_context *smu =3D handle;
>  	enum smu_clk_type clk_type;
>=20
>  	switch (type) {
> @@ -2434,12 +2431,54 @@ static int smu_print_ppclk_levels(void *handle,
>  	case OD_CCLK:
>  		clk_type =3D SMU_OD_CCLK; break;
>  	default:
> -		return -EINVAL;
> +		clk_type =3D SMU_CLK_COUNT; break;
>  	}
>=20
> +	return clk_type;
> +}
> +
> +static int smu_print_ppclk_levels(void *handle,
> +				  enum pp_clock_type type,
> +				  char *buf)
> +{
> +	struct smu_context *smu =3D handle;
> +	enum smu_clk_type clk_type;
> +
> +	clk_type =3D smu_convert_to_smuclk(type);
> +	if (clk_type =3D=3D SMU_CLK_COUNT)
> +		return -EINVAL;
> +
>  	return smu_print_smuclk_levels(smu, clk_type, buf);
>  }
>=20
> +static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type,
> char *buf, int *offset)
> +{
> +	struct smu_context *smu =3D handle;
> +	enum smu_clk_type clk_type;
> +	int ret =3D 0;
> +
> +	clk_type =3D smu_convert_to_smuclk(type);
> +	if (clk_type =3D=3D SMU_CLK_COUNT)
> +		return -EINVAL;
> +
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&smu->mutex);
> +
> +	if (smu->ppt_funcs->emit_clk_levels) {
> +		ret =3D smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf,
> offset);
> +	}
> +	else {
> +		ret =3D -EOPNOTSUPP;
> +	}
> +
> +	mutex_unlock(&smu->mutex);
> +
> +	return ret;
> +
> +}
> +
>  static int smu_od_edit_dpm_table(void *handle,
>  				 enum PP_OD_DPM_TABLE_COMMAND
> type,
>  				 long *input, uint32_t size)
> @@ -3117,6 +3156,7 @@ static const struct amd_pm_funcs
> swsmu_pm_funcs =3D {
>  	.get_fan_speed_pwm   =3D smu_get_fan_speed_pwm,
>  	.force_clock_level       =3D smu_force_ppclk_levels,
>  	.print_clock_levels      =3D smu_print_ppclk_levels,
> +	.emit_clock_levels       =3D smu_emit_ppclk_levels,
>  	.force_performance_level =3D smu_force_performance_level,
>  	.read_sensor             =3D smu_read_sensor,
>  	.get_performance_level   =3D smu_get_performance_level,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 60a557068ea4..e43c7e950a55 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1261,6 +1261,194 @@ static void navi10_od_setting_get_range(struct
> smu_11_0_overdrive_table *od_tabl
>  		*max =3D od_table->max[setting];
>  }
>=20
> +static int navi10_emit_clk_levels(struct smu_context *smu,
> +			enum smu_clk_type clk_type, char *buf, int *offset)
> +{
> +	uint16_t *curve_settings;
> +	int ret =3D 0;
> +	uint32_t cur_value =3D 0, value =3D 0;
> +	uint32_t freq_values[3] =3D {0};
> +	uint32_t i, levels, mark_index =3D 0, count =3D 0;
> +	struct smu_table_context *table_context =3D &smu->smu_table;
> +	uint32_t gen_speed, lane_width;
> +	struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
> +	struct smu_11_0_dpm_context *dpm_context =3D smu_dpm-
> >dpm_context;
> +	PPTable_t *pptable =3D (PPTable_t *)table_context->driver_pptable;
> +	OverDriveTable_t *od_table =3D
> +		(OverDriveTable_t *)table_context->overdrive_table;
> +	struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings;
> +	uint32_t min_value, max_value;
> +	int save_offset =3D *offset;
> +
> +	switch (clk_type) {
> +	case SMU_GFXCLK:
> +	case SMU_SCLK:
> +	case SMU_SOCCLK:
> +	case SMU_MCLK:
> +	case SMU_UCLK:
> +	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
> +	case SMU_DCEFCLK:
> +		ret =3D navi10_get_current_clk_freq_by_table(smu, clk_type,
> &cur_value);
> +		if (ret)
> +			return 0;
> +
> +		ret =3D smu_v11_0_get_dpm_level_count(smu, clk_type,
> &count);
> +		if (ret)
> +			return 0;
> +
> +		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +			for (i =3D 0; i < count; i++) {
> +				ret =3D
> smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
> +				if (ret)
> +					return (*offset - save_offset);
> +
> +				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, value,
> +						cur_value =3D=3D value ? "*" : "");
> +
> +			}
> +		} else {
> +			ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, 0, &freq_values[0]);
> +			if (ret)
> +				return 0;
> +			ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, count - 1, &freq_values[2]);
> +			if (ret)
> +				return 0;
> +
> +			freq_values[1] =3D cur_value;
> +			mark_index =3D cur_value =3D=3D freq_values[0] ? 0 :
> +				     cur_value =3D=3D freq_values[2] ? 2 : 1;
> +
> +			levels =3D 3;
> +			if (mark_index !=3D 1) {
> +				levels =3D 2;
> +				freq_values[1] =3D freq_values[2];
> +			}
> +
> +			for (i =3D 0; i < levels; i++) {
> +				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, freq_values[i],
> +						i =3D=3D mark_index ? "*" : "");
> +			}
> +		}
> +		break;
> +	case SMU_PCIE:
> +		gen_speed =3D
> smu_v11_0_get_current_pcie_link_speed_level(smu);
> +		lane_width =3D
> smu_v11_0_get_current_pcie_link_width_level(smu);
> +		for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %s %s %dMhz %s\n", i,
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 0) ? "2.5GT/s," :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 1) ? "5.0GT/s," :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 2) ? "8.0GT/s," :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 3) ? "16.0GT/s," : "",
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 1) ? "x1" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 2) ? "x2" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 3) ? "x4" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 4) ? "x8" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 5) ? "x12" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 6) ? "x16" : "",
> +					pptable->LclkFreq[i],
> +					(gen_speed =3D=3D dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i]) &&
> +					(lane_width =3D=3D dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i]) ?
> +					"*" : "");
> +		}
> +		break;
> +	case SMU_OD_SCLK:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS))
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
> +					  od_table->GfxclkFmin, od_table-
> >GfxclkFmax);
> +		break;
> +	case SMU_OD_MCLK:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX))
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
> +		break;
> +	case SMU_OD_VDDC_CURVE:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE))
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_VDDC_CURVE:\n");
> +		for (i =3D 0; i < 3; i++) {
> +			switch (i) {
> +			case 0:
> +				curve_settings =3D &od_table->GfxclkFreq1;
> +				break;
> +			case 1:
> +				curve_settings =3D &od_table->GfxclkFreq2;
> +				break;
> +			case 2:
> +				curve_settings =3D &od_table->GfxclkFreq3;
> +				break;
> +			default:
> +				break;
> +			}
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMHz %umV\n",
> +						  i, curve_settings[0],
> +					curve_settings[1] /
> NAVI10_VOLTAGE_SCALE);
> +		}
> +		break;
> +	case SMU_OD_RANGE:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset, "%s:\n",
> "OD_RANGE");
> +
> +		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_GFXCLKFMIN,
> +						    &min_value, NULL);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_GFXCLKFMAX,
> +						    NULL, &max_value);
> +			*offset+=3D sysfs_emit_at(buf, *offset,
> "SCLK: %7uMhz %10uMhz\n",
> +					min_value, max_value);
> +		}
> +
> +		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX)) {
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_UCLKFMAX,
> +						    &min_value, &max_value);
> +			*offset+=3D sysfs_emit_at(buf, *offset,
> "MCLK: %7uMhz %10uMhz\n",
> +					min_value, max_value);
> +		}
> +
> +		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE)) {
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
> +					      min_value, max_value);
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return (*offset - save_offset);
> +}
> +
>  static int navi10_print_clk_levels(struct smu_context *smu,
>  			enum smu_clk_type clk_type, char *buf)
>  {
> @@ -3245,6 +3433,7 @@ static const struct pptable_funcs navi10_ppt_funcs
> =3D {
>  	.i2c_init =3D navi10_i2c_control_init,
>  	.i2c_fini =3D navi10_i2c_control_fini,
>  	.print_clk_levels =3D navi10_print_clk_levels,
> +	.emit_clk_levels =3D navi10_emit_clk_levels,
>  	.force_clk_levels =3D navi10_force_clk_levels,
>  	.populate_umd_state_clk =3D navi10_populate_umd_state_clk,
>  	.get_clock_by_type_with_latency =3D
> navi10_get_clock_by_type_with_latency,
> --
> 2.34.1
