Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4A4CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 02:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9754010E1D5;
	Fri, 16 Oct 2026 02:57:53 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C5710E1D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 02:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0EHER79uDSFHYM/x3O9RSqi/V4k1mSPC6BHY3ys1Ja4SPFcTTODpwTsELneEZ4REt+VMGdmlyiFIGg/hF1LPEbdVv9U81I9AWX4D1F5OwGwEut8DouY7WLFiG3ls+35gOwGo1opiSGmyqBdjZuDr2o1qeBNI9CZHgSax4J2l7ivWGf5mwzb9JOVzd1vdcb1EyB9cMWXQOwd4bl2nR2mgem0yh9y8H+vMVN0aukTiXBhpHbsuhT5mHEHIhj+FQ4/nDqcfhf7PP4crkllgntLU2nW1MtNL799jaqLK+eYErziWMiQiHTzfGI8A6Sy+KlIgOJ4OEGRmKZSLWhQr9i9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0fZg1aIZr2Um/R3Y2rw93D+JsIROKI0Z8mq5Jrtko0=;
 b=KGRXKQ/8ABfhL8xcS4L4YBNWJSaauEK672S0OjLgRuboiRHLYuyWEyYKTfr0sa3iWBewB0qfFKUrWewERg0AaljSPBorC3PCkd9OturGaxUxWRWsSkR8AOsriNtWMUEtSePe4OK8LfuumwFbVgWSni0ILkYH3wRpI0DqeZR4nvIFeE9XaTxglq/fDsQ0XQTuc3afaJpX8ASeRj8q/GTFkLfUjTqgP6jjO6Bzi0sG59VNylIQzXSFaguKI/Y+t37j4a/HA/cKMv4hVSORitaQTamtChilmqarWjJDYWIDE2VEMsjplD6yPU3C97+5dl4I7sbKnICTZGZSJxUixSpVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0fZg1aIZr2Um/R3Y2rw93D+JsIROKI0Z8mq5Jrtko0=;
 b=cwY6M7G2iISQ87+hzeXYHghflqZP0GsIBykRtoKWBKW1yhcPIP7fNBNQ6SbXALl2iR2qeNSDN2tXWeUxPLaGVWBLNX/qSGRWgDB8heRbd7JFiXn1xurj/WTNq44XRVt+63Emd4finqUNKNzJOksHCU9A6Hw5IKNLkcQgaAxrVF4=
Received: from CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 02:57:43 +0000
Received: from CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd]) by CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 02:57:43 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add log when register access is blocked in PTL
Thread-Topic: [PATCH] drm/amdgpu: Add log when register access is blocked in
 PTL
Thread-Index: AQHdW/rli02xBl/jeUyeJlBVpn5xC7b/e4bQ
Date: Fri, 16 Oct 2026 02:57:43 +0000
Message-ID: <CH2PR12MB4168855D01B75EA23DC881389C9B2@CH2PR12MB4168.namprd12.prod.outlook.com>
References: <20261014164116.2985138-1-kent.russell@amd.com>
In-Reply-To: <20261014164116.2985138-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T02:55:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4168:EE_|CH1PR12MB9621:EE_
x-ms-office365-filtering-correlation-id: 42efc993-775f-42b5-29a7-08df2b313fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: kczkI+mI08/qneAh30GBeQJ7YBEKl7SA6Tq95bjd2TsfWsa2lyWFZSEl5CH7QHcT2FJ5vP+2aTssR1UmkonM36EN9Usw9DEmSJ7E7pdMc7VInFBOZXVi5fEhHWpnmvVCXUOSXWYJXEEtRe4QGch8Lpfo4Jj6PH4Y4gM7DxjUKcbDLp3bN5VkcsRAs+u1gBcgdLz3MAKfoHdAbNhX5Zaoey98/I5TifBSVc0LbXYhO83ACptBeeW+C7Ai2zQJvZzDRgGOjGjMJZZT8Am3t8Jzr5WTgPScZsYkBg7xdy8hP3u2O+nguhnoO56KxfMbHcAs8SafnWMsliqpPQsNxStDgBIPVTwaPkC509Kdrw7pzod6F76BmIs2r5lZSzfSm1kCcD82B2I3ET1jago0ZgeA48lWNjmtmz7/+QEQrzrIQiU32iNrHML1rvlAyOWSIw3rkYATbFNCdvbbCa4DeMF0B7LEH4HqzGw7TEKaAPijjkHRdMWNlKDgxUqA6rPXAItsISrcFPQsAcjB95AJr30rJDRWZ1WMHuQXW11SQcGqnWmaLWNngnJTTrrn6IWqR+f8OJsNvDEV+hD3ee2wWJiujOac+tBCXLPXvTPi4p4TFEFJGFGAfZu7vktt4gdaWHnZx0+EefgD7J3PYpwh/X+FVH/AARdZUElNiBpGKOmTHsQzuEmsb1j8llDnQMiCV77Ojgen6y1cEf36eDTFzJPL/UJn3TBw+zW/CZ+DZr4QSBU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NS0oaDfJS/RMPvfx/fFj/2WIjz0jdvSAl86vsLO4gReymrwjbW1oyGHghiAI?=
 =?us-ascii?Q?uV2X9/+C23O2mMdgCdl51JTDmt4WAtDDMP8YE/gXMKuuP802/mNw3NSCGr4A?=
 =?us-ascii?Q?m4E3v8pt9udmXsCW2a1cU/goMCmOc8rcZndroky9ER3Nh57UehLHZcYjWE7M?=
 =?us-ascii?Q?kl4E/ozeXRxm6qq9Bw/W43pQN6AcPXiaKgx6zN2RmuTuzxxbg3xoWHNXW6FO?=
 =?us-ascii?Q?awaAdAomREJp6YeStlxgbQMZRzfhs08Mlie+ofVz4qZhNR1rJJ9Cavapdlc3?=
 =?us-ascii?Q?dfPgWSP0x0qERobfTeZlk2ZXmmv+BA7ysM71qAQ/D4bg1uLFKs47l6AVlN0T?=
 =?us-ascii?Q?8/FHzlLl62igs/GBrFpjGp44kel5hvVWv4uiNMt1We9u/xhiBG4scEVrjLs7?=
 =?us-ascii?Q?8jxJc+Ssaxojzn2PvqryPD3IpRcTu5yNy1LpNB2tez4ycCEhxSCTZqSiyhDH?=
 =?us-ascii?Q?nfEEhNvn2RphpJgY9P8buHHTbdAaJV3qUpObH8cao26HqX1TRgkaRyeCmWbw?=
 =?us-ascii?Q?/0D+Rd8YtPyBFzczgP4Kjn7of/H4QCBANb2oITd2RAhOcYXsrklJ/Y5wyVcY?=
 =?us-ascii?Q?rZCKik7Zgt09Ithi1d3EB6SoRJjRFkffn89vd/m239Yz6QY6+FaPDmvY/grK?=
 =?us-ascii?Q?1CfbIWhaIrtxrgktksEvqKdy6Ynh/TUrJpCxFsd0WeSMkEQR9W0SSTMV/RuC?=
 =?us-ascii?Q?P2kJTZ2lk4sQ1kEuL7w/fEk5p0Hzxvr9OazT1wYcwRRaxsttf1lLZuOMxXqd?=
 =?us-ascii?Q?aHXSngTInXFMUaNHxxEO0a+WEz2cHik5YmyknuOELwbNqoJPFHQQIcEmpywP?=
 =?us-ascii?Q?4hu1jj7g0EhbbRjwPhsMSNL6hc4iHGGImb6lM1xJV2YHxgfqHzvdT3dze6f/?=
 =?us-ascii?Q?ZarJwSRZt/QvDqaxsSPEIb4I8bN26o6HP1jfrvrmTbfDF3Yps7Gjl+yDIOHC?=
 =?us-ascii?Q?RBu8yvdZZa3AxRJRRKceKfrBGKwdRC8QqS6Y+0cTVy8lpJryN3Xn3XHbiDQQ?=
 =?us-ascii?Q?fq2e1LXZTEylB9XaOes9e0F/Oo8iesyKVNY9FlEZ0UD0RmUINb9IUNCi04J5?=
 =?us-ascii?Q?7/FVG4QsIImiZsnFcZ46T7zg4eVO8niZNO1j15umCX4Nlm/+VaH8hV0kAHvo?=
 =?us-ascii?Q?Y64Wc6qcRcbqUhexjkZKmA2K8ch+OrWbhaW259NWVCze7JzZeaiC7mekujTi?=
 =?us-ascii?Q?kSAUg8p3qzHJd0W/4REUKBu4WyH9olHDIEbuWeS8vMOCAL4ZJm5nvMBpNzyH?=
 =?us-ascii?Q?U84pqijVdaJ6i+q02eSeZiHBp1bujD58l3JmG0/lG9Q7zwNhROgebQJT7urW?=
 =?us-ascii?Q?fnMyb8KxKVDvmNbclkztP7qwFqYEgh6vBk568h03wTGL4fVSIHdDw9hgYBYl?=
 =?us-ascii?Q?9QDWP1Nbfd/UtHhLfHJzkKly7C/x5dCVY82Bzk+hCNUKAbLcBp7MgjKn1jmj?=
 =?us-ascii?Q?VadCeam/k4wL5NH3KDIyFReGLVrraW0JnOhEh4RJnCdbb+SyGXdgM6Cepatn?=
 =?us-ascii?Q?nidJADMs4m2ivBc8lxX6By0QhgrTZjJO5E0nQYOADRD0wU1kvNFCWUNucB9n?=
 =?us-ascii?Q?L7Efo87dcQN6rLC+DFwEP2hB9pk+EtCQUfGFOFBtXiS3vTXqBrESn2PWukYv?=
 =?us-ascii?Q?nPHUiIsUfHuzaDPQmJDIatKvFk7s5RmmnbplKDIzqZLoR+URQuujHEKNNG79?=
 =?us-ascii?Q?1C6Y4TmUvXyLqirQEU5vOYMbDjEEZR3/9Vz42P7l59IgP4Lx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42efc993-775f-42b5-29a7-08df2b313fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 02:57:43.0743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7Z5t/jvLQkVD3GHIaZpwYOoEvDP2T/0+SR2Mg8cGzH9vSABOHU+nCvDijPinqDuxeaXVgoOnW2Td9cHbcq95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621
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

AMD General

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Thursday, October 15, 2026 12:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Russell, Kent <Kent.Russell@amd.com=
>
> Subject: [PATCH] drm/amdgpu: Add log when register access is blocked in P=
TL
>
> PTL will limit access to specific registers. Instead of silently dropping=
 these attempts,
> log them in dmesg for reference. Also add a dev_debug option to show what
> pasid/addr/packet type failed.
>
> v2: Make sure to guard it by MEC v195, and move enable call into ptl_hw_i=
nit
> function
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 35 +++++++++
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 76 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/soc15_int.h        |  1 +
>  3 files changed, 112 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 0ffdef21df0a..718aab5c7b3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -171,6 +171,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_devic=
e
> *adev,
>                               struct amdgpu_cu_info *cu_info);
>  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int
> xcc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device
> *adev, int xcc_id);
> +static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device
> +*adev);
>
>  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>                               uint64_t queue_mask)
> @@ -2465,6 +2466,11 @@ static int gfx_v9_4_3_ptl_hw_init(struct amdgpu_de=
vice
> *adev)
>
>       gfx_v9_4_3_perf_monitor_ptl_init(adev, enable ? 1 : 0);
>
> +     /* Enable PTL register skip notifications if PTL is supported */
> +     if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED)
> +             if (adev->gfx.mec_fw_version >=3D 194)
> +                     gfx_v9_4_3_enable_ptl_skip_interrupt(adev);
> +
>       return 0;
>  }
>
> @@ -2661,6 +2667,7 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_b=
lock
> *ip_block)  static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_bl=
ock)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>
>       if (adev->gfx.ras &&
>           adev->gfx.ras->enable_watchdog_timer)
> @@ -3327,6 +3334,34 @@ static int gfx_v9_4_3_set_bad_op_fault_state(struc=
t
> amdgpu_device *adev,
>       return 0;
>  }
>
> +/*
> + * Enable GENERIC1 interrupt (bit 30) for PTL register skip notification=
s.
> + * When FW skips a privileged register access due to PTL, it signals
> +via
> + * GENERIC1 and KFD receives interrupt source 177 with skip details.
> + */
> +static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device
> +*adev) {
> +     u32 mec_int_cntl_reg, mec_int_cntl;
> +     int i, j, k, num_xcc;
> +
> +     num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +     for (i =3D 0; i < num_xcc; i++) {
> +             for (j =3D 0; j < adev->gfx.mec.num_mec; j++) {
> +                     for (k =3D 0; k < adev->gfx.mec.num_pipe_per_mec; k=
++) {
> +                             mec_int_cntl_reg =3D
> gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
> +
> +                             if (mec_int_cntl_reg) {
> +                                     mec_int_cntl =3D
> RREG32_XCC(mec_int_cntl_reg, i);
> +                                     mec_int_cntl =3D
> REG_SET_FIELD(mec_int_cntl,
> +                                                     CP_ME1_PIPE0_INT_CN=
TL,
> +                                                     GENERIC1_INT_ENABLE=
, 1);
> +                                     WREG32_XCC(mec_int_cntl_reg,
> mec_int_cntl, i);
> +                             }
> +                     }
> +             }
> +     }
> +}
> +
>  static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *ad=
ev,
>                                             struct amdgpu_irq_src *source=
,
>                                             unsigned type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e241ad7d55df..8dee8c43824d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -123,6 +123,28 @@ enum SQ_INTERRUPT_ERROR_TYPE {  #define
> KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000  #define
> KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
>
> +/*
> + * PTL (Peak TOPS Limiter) register skip notification.
> + * When FW skips a privileged register access, it sends interrupt 177
> + * with GENERIC1 and provides packet type info in CPC_INT_CNTX_ID[31:28]=
.
> + */
> +#define CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG  1
> +#define CPC_PTL_PACKET_TYPE_SET_SH_REG               2
> +#define CPC_PTL_PACKET_TYPE_COPY_DATA_READ   3
> +#define CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE  4
> +#define CPC_PTL_PACKET_TYPE_WRITE_DATA               5
> +#define CPC_PTL_PACKET_TYPE_COND_WRITE               6
> +#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM     7
> +#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64   8
> +
> +/* CPC_INT_CNTX_ID[31:28]: packet type that was skipped */
> +#define CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT  28
> +#define CPC_INT_CNTX_ID__PACKET_TYPE_MASK    0xF0000000
> +
> +/* CPC_INT_INFO[30:28]: queue ID */
> +#define CPC_INT_INFO__QUEUE_ID__SHIFT                28
> +#define CPC_INT_INFO__QUEUE_ID_MASK          0x70000000
> +
>  /*
>   * The debugger will send user data(m0) with PRIV=3D1 to indicate it req=
uires
>   * notification from the KFD with the following queue id (DOORBELL_ID) a=
nd @@ -
> 142,6 +164,30 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>                               KFD_DEBUG_CP_BAD_OP_ECODE_MASK)
>       \
>                               >> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
>
> +static const char *cpc_packet_type_name(uint32_t packet_type) {
> +     switch (packet_type) {
> +     case CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG:
> +             return "SET_UCONFIG_REG";
> +     case CPC_PTL_PACKET_TYPE_SET_SH_REG:
> +             return "SET_SH_REG";
> +     case CPC_PTL_PACKET_TYPE_COPY_DATA_READ:
> +             return "COPY_DATA_READ";
> +     case CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE:
> +             return "COPY_DATA_WRITE";
> +     case CPC_PTL_PACKET_TYPE_WRITE_DATA:
> +             return "WRITE_DATA";
> +     case CPC_PTL_PACKET_TYPE_COND_WRITE:
> +             return "COND_WRITE";
> +     case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM:
> +             return "WAIT_REG_MEM";
> +     case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64:
> +             return "WAIT_REG_MEM64";
> +     default:
> +             return "UNKNOWN";
> +     }
> +}
> +
>  static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>                               uint16_t pasid, uint16_t client_id)  { @@ -=
352,6 +398,8
> @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
>               source_id =3D=3D SOC15_INTSRC_SDMA_ECC ||
>               source_id =3D=3D SOC15_INTSRC_SQ_INTERRUPT_MSG ||
>               source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE ||
> +             (client_id =3D=3D SOC15_IH_CLIENTID_GRBM_CP &&
> +              source_id =3D=3D SOC15_INTSRC_CP_PTL_REG_SKIP) ||
>               KFD_IRQ_IS_FENCE(client_id, source_id) ||
>               ((client_id =3D=3D SOC15_IH_CLIENTID_VMC ||
>               client_id =3D=3D SOC15_IH_CLIENTID_VMC1 || @@ -538,6 +586,3=
4
> @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
>                               KFD_DEBUG_DOORBELL_ID(context_id0),
>
>       KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
>                               NULL, 0);
> +             } else if (source_id =3D=3D SOC15_INTSRC_CP_PTL_REG_SKIP) {
> +                     uint32_t packet_type, queue_id;
> +                     uint32_t skipped_addr;
> +
> +                     /*
> +                      * PTL (Peak TOPS Limiter) register skip notificati=
on.
> +                      * FW skipped a privileged register access and is n=
otifying
> KFD.
> +                      * Data from IH entry (not registers):
> +                      * - context_id0 contains CPC_INT_CNTX_ID with pack=
et
> type in [31:28]
> +                      * - context_id1 contains CPC_INT_INFO with queue I=
D in
> [30:28]
> +                      * - context_id2 contains CPC_INT_ADDR (skipped reg=
ister
> address)
> +                      * - PASID comes from CPC_INT_PASID (already extrac=
ted
> from IH entry)
> +                      */
> +                     skipped_addr =3D
> SOC15_CONTEXT_ID2_FROM_IH_ENTRY(ih_ring_entry);
> +
> +                     /* Extract packet type from CPC_INT_CNTX_ID[31:28] =
*/
> +                     packet_type =3D (context_id0 &
> CPC_INT_CNTX_ID__PACKET_TYPE_MASK) >>
> +
>       CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT;
> +
> +                     /* Extract queue ID from CPC_INT_INFO[30:28] */
> +                     queue_id =3D (context_id1 &
> CPC_INT_INFO__QUEUE_ID_MASK) >>
> +                                     CPC_INT_INFO__QUEUE_ID__SHIFT;
> +
> +                     dev_info_ratelimited(dev->adev->dev,
> +                             "PTL: AQL request was rejected due to incom=
patible
> user input; please verify your PTL configuration.");
> +                     dev_dbg_ratelimited(dev->adev->dev,
> +                             "PTL: register access skipped - pasid 0x%x,
> queue %u, packet %s, addr 0x%x\n",
> +                             pasid, queue_id,
> cpc_packet_type_name(packet_type), skipped_addr);
>               }
>       } else if (client_id =3D=3D SOC15_IH_CLIENTID_SDMA0 ||
>                  client_id =3D=3D SOC15_IH_CLIENTID_SDMA1 || diff --git
> a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> index e5c0205f2618..736b02ccdefb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> +++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> @@ -25,6 +25,7 @@
>
>  #include "soc15_ih_clientid.h"
>
> +#define SOC15_INTSRC_CP_PTL_REG_SKIP 177
>  #define SOC15_INTSRC_CP_END_OF_PIPE  181
>  #define SOC15_INTSRC_CP_BAD_OPCODE   183
>  #define SOC15_INTSRC_SQ_INTERRUPT_MSG        239
> --
> 2.43.0

