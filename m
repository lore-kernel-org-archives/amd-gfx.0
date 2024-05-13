Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2ACC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 21:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2116110E641;
	Mon, 13 May 2024 21:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIKqmzjg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F03010E641
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 21:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL+B7qcvsbA+i3Db7ANGsyXH51NZQmDToxz8qb0xtxzXF4IRoR7o5Xw+tadAWSQCq84d4DWS0UcXfF0PdZbH4TJpYjqL1bklDqbWrJJ7xNKY5+hKnzP2AGNFL1RV1lAZ46+uV6EnJPIhnPXaVXLEXa1fGi168RbLEKuklk8wE8wnZ+pY/WxProit4uCyW9RL1DlezbJsK7uYdcy0g697rtyXgXNam7i2RrqPVKbQy1K2lQVVyNi3Oom+D2MKD5ClbSVSUMV9DOfYkmb/yvUfvhRu8YYz3e9mhPiroNUIMOXoC0H2jBI9uppuE51OA1ymtEMgDfDNcuCotV6I7BDSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM7GamdAzTFw4Untm6qmkn+nxaD92DGIA/5GkJ/4dPM=;
 b=HmAC2v3xgXT2GiGb/Lh925mIAxQIuCIVzsEvLGSNI6ZJyBTdUU+UqBNFJyMkYiZ+ZonIC40s9L58g07WTfhKuGXVJCjdrwHNwWMzZk2P4zqThAd3BuuEGW0fv9B6CV/llIv8C14D2u5l1oau3Wq67HsH1PDdklHejd0BLq5JjDND1TKvRXVrbWDXDQHOHlsSxKJH5NQshbKOmCRHSlmoSM/wc/CcRU7PEtUcE8PyiEt36XTXoM1mVJJ2SZ0rGChnQGdTTWXLfiVCtsqhxfMTrB1SGH0B12CxoDFMH7Ezcf1ug0gF3ywY2ie81wK56p/pJ8qw2XDvUaJH4RbKfxhJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM7GamdAzTFw4Untm6qmkn+nxaD92DGIA/5GkJ/4dPM=;
 b=SIKqmzjgOF526KXiJT4WTw8iU8VVPje+5EBJehyxbPo4OvG+wSjwIGi+tx2m884OYS+FIrFBFd8t/Wa19o8pYVFR52YFqLNcFpiyDdYDWi1hpnk6d8/f1buvS4CCrgr53hh2P7v43wBB26tKTul5mY+fIpDfY10KQkz0a6evNqc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 21:36:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 21:36:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH v3 10/10] Documentation/amdgpu: Add PM policy documentation
Thread-Topic: [PATCH v3 10/10] Documentation/amdgpu: Add PM policy
 documentation
Thread-Index: AQHapRb9JZ5xqwitM0Gcd7w+3KEj77GVsCSA
Date: Mon, 13 May 2024 21:36:13 +0000
Message-ID: <BL1PR12MB5144BB418683EAFF6ACADBADF7E22@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
 <20240513092111.341168-11-lijo.lazar@amd.com>
In-Reply-To: <20240513092111.341168-11-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ee599af1-0ae3-471c-9de2-184629a38f37;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-13T21:33:27Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB8136:EE_
x-ms-office365-filtering-correlation-id: 788505e5-9fab-4610-a86b-08dc7394b664
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?xXmDK2jCwfzwBpr+ku9e3jy+2u5mt5pMy7BU8xnvL6s7x8ZAiHheUVwD3O6U?=
 =?us-ascii?Q?/T7aHIJ1fzC1/N+g7HoFiineFqkQ6KE5qp1aEcsnly9YIKCfiR9F/uxu0WNm?=
 =?us-ascii?Q?t8D9GUZmWjrN5dMkhya/E9dGdFX4ZnyyYMZ5W+gtY8XoUCuFucUljgiQlNd+?=
 =?us-ascii?Q?wwS6Xjn2QXnLZuO5fVITDZvNcfaBxOSgiKmvsk/wxlMYMdGwuIbyA3jmTYKI?=
 =?us-ascii?Q?Puveg+bWpFfRlSCAfGBfnF3i3MwZYyW5VLglyYuoo+OvGVSJYn7Gs8duTjR+?=
 =?us-ascii?Q?hwGlpTk41WjIwP4OB4kUxAHjQDFKLb4sZM+SlTXz1c61pQOqQcycWea/JHpm?=
 =?us-ascii?Q?o3svPhhCjKcyv9tCMEtq3x8h/WPwJTY+HFEHfq7YhFgiP/5yHkGofMWdkaxu?=
 =?us-ascii?Q?tHlnygZkEy9+qe7NeZYmfF+6Qu/x60sEjrEoMtKZCsD3+xzzkBnlK9T7ktnN?=
 =?us-ascii?Q?q7HzFNDdWkzBmNbTDNJMoke/DesG28sGItYYqbk51XSD1Ll16V8VS0/824Vl?=
 =?us-ascii?Q?l+l4pMQ4vk2P5NVHjURSUs1VqJqcEATtwr4DWyP2ZmLtSgnEwKEV1x/y43nY?=
 =?us-ascii?Q?ICftu15w1yqdjNn7xxJFoFmsiH4ijmca+GuLZWtJe4QurwmdGHSd8m6sDl1E?=
 =?us-ascii?Q?4GbHPlbcjM4Il0zCBY3faIqaG2XVsO1eDFpFn17AZoEkw1qAnW7g2ucHDUi0?=
 =?us-ascii?Q?RiAyt4jazMLRubomUyCly2irti1Tp6ScX5Zxxfaeil/UFrw1+TwTDxbdmMG7?=
 =?us-ascii?Q?NIf8Iu94Tb9+uJxZiCHWQkpfJtWxmoxVY5GpcR6n1oVl5QOEN5eJW5YzTFbD?=
 =?us-ascii?Q?XGyemIns9w7sMr/ZjrLmVw32g+Y5CPbc36wXCE6y+xG2EABRxWdYx71LEfM3?=
 =?us-ascii?Q?maJVQ0kf53HeEATFU0zgTUnt2MJtQpk0MYy1VKljCWVyxn2WPJBAKsRI8ysI?=
 =?us-ascii?Q?WvgloXepl8PutxKmH8pYTN0EYdBLp3PnyMiAkI/8sKHxABc7prT2QnQi2fm4?=
 =?us-ascii?Q?GONZmG0ty4fTQyI8NVqmt3Hwb4JkLDwPVinsuIbbYc/UGU1uyMLgNU02K/4Q?=
 =?us-ascii?Q?6franf9b9YG4uOyb+O0lZl1XXL7tgZ9gE4j9k/XPGOSu2CpEANdhXno36n1P?=
 =?us-ascii?Q?Vm2kLAtEzaTTIdwxHCLsUFlgi0SdAzkz/H9Lol/92Y7jCHdfKtn797LbSltG?=
 =?us-ascii?Q?VTQGyBS9zgP539BcB3dR8Z5NYuKBc3D3Gtp9aXk1Ge9LjsDc+kbx0vJpuRTP?=
 =?us-ascii?Q?x8qNR19pSoJlrwQrGMBT71Fm3V7/qBeYvqJHwVROXqvYGjN+Zmtv+VVrpS3W?=
 =?us-ascii?Q?8mayn5U5I5k9AQ0A419F+QJLaMZvZzCgDL8ZOWaqYZKILw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O8S6fqPvYcTplpeO40VIlMsHQW8k+W8iJz2mUxDjmGRLD6OWv5Nj4EysNELz?=
 =?us-ascii?Q?IP5BnNFHnOkNkGeeNbXtfwvvCIYyElrhyulUzEvS+T788Wh2xscS/TlfM7ji?=
 =?us-ascii?Q?GN/eCA9zlphV/0M+D7CmDzhnVGUZwG96HpDarfOqDfMBXXnuuYl4rsMdChE/?=
 =?us-ascii?Q?2Spr4jGLYCvaJ1HWHKAWgjDeM7SJpIzbObFO8aDtObMiiDExNNCIwMPBoHxT?=
 =?us-ascii?Q?cQUFmtQBwjL9XgQnOj3mtyYxz4/NObQzIkzr+qR4UyC6jx+pBmKhqtpGxxoQ?=
 =?us-ascii?Q?DH4IpmW6gG+7di2plakNBLHq9NlaWke1buYlNu0OTwvGM7aZzJaAii6VMzYw?=
 =?us-ascii?Q?MEerhadN4tFQFwP/HM1A8d0ImiODe2uQ7gevHlJd0fOCtA0ITba8kdhXkoOp?=
 =?us-ascii?Q?Oozzrx13bJH3FPUDOI1yEAp4IUX6wNnYOIW6X3JnBnaOS5k21TUawa+k2q4E?=
 =?us-ascii?Q?UermCLtmw9zPeG2NPVec+jivrr1KJGdohq+GE0bRm8+2mIyiHORCNmGqSQtx?=
 =?us-ascii?Q?MCARESYhkIGkUXtXz1YcsnAtdBbotnxYvuq/gvemFGFN+wOf/K6l+QDMm5li?=
 =?us-ascii?Q?rIBL+H0vp/02R+CWLTHi9EmIxzAk1oEGflVHMdtoXi1AWAao4y7W/Aq0He+X?=
 =?us-ascii?Q?9LVzRXdG4M/toIJnzixA3TIyck4NmD0VaivsM9Ac/KfjV10Orm0+jzy3E924?=
 =?us-ascii?Q?oRFFMbPQ5VxM563/tfBnMnPuXMRpJTT6EoJINFf6/tLOaND0Ikr7MQmdZVFR?=
 =?us-ascii?Q?DZ1xbJEls465q5xSSEvhM6SgN2+cJFs/KdaK+r1yGaYC0ZV8Wkka4lT4Gi03?=
 =?us-ascii?Q?IBm4VTepfjOTZh3U8SoandLqa04SEPSmZFMPGnRqQhOMEVOH9rLflh/EJjln?=
 =?us-ascii?Q?5GsBdT0gjlQDWEofVIVJ0RBLZDS3/Pnhpd/p0bQEbxoaBd3NN6REo5JnUH4s?=
 =?us-ascii?Q?YkllYoCntv05/gZ4yMeHgzLnMcL2S0GRPM1sVfsTBrWSFmRDvMV6PrFISrkH?=
 =?us-ascii?Q?jzKAWMXeiJZNYGRLASmSlWm1WVgb082BYoyb7d3K+AMar8A18yS4r044rqM8?=
 =?us-ascii?Q?w87ir5j2PCCxgq9Nxtkbn43v3xi929U8t5C4GjGCYk7mdnvS0T9VnPxt8p6K?=
 =?us-ascii?Q?snjkBG/VKoXUxf6YrW4ACRdKPc9y/rTC1UlFON5hsJVgAO1dL8l43JqBKll2?=
 =?us-ascii?Q?bId4Lx2zjgH9VOpUsvEkfSXFT+L6/AkEn6x7y2SOpJqUREV6Fl+jZ1B1nlIx?=
 =?us-ascii?Q?9MRGhLBwP3LopT0TNZjKoqnIEz3I0zfbU6t65MgQyNMAGrVzK9AqP2hU0UjZ?=
 =?us-ascii?Q?7PE0vRVMGAttXuPpn3t/8aT6liOB6N15hX13xVhs9DaSR5jxLPoOgE55YvBw?=
 =?us-ascii?Q?BNzSYGhwDGZtetWyJbgybax0nmXo56Ol2aQN8ynLJ5Qw+htq0PcegsPGjLYt?=
 =?us-ascii?Q?2csyutTFPev910d7mO4Nw6zQ2af2vaz/SiB28tD8//FEj+c5H8KCuxu83J4h?=
 =?us-ascii?Q?yZGk+ZdugyK9242Ds2AyrFF6eb5qBUvKuLZQOSHxQWfW6w+bSQL3qZgUIvVa?=
 =?us-ascii?Q?t+1zu/c5G4M+/UF9aww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788505e5-9fab-4610-a86b-08dc7394b664
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 21:36:13.2023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJCPfsBL1udzzD+5EkC+0zkY8g/kzUKxSRHfQLQ9aF61x03wawnAl9olvu0RTgb7ir9+mmCBabu/QJ9qsjJWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, May 13, 2024 5:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma,
> Le <Le.Ma@amd.com>
> Subject: [PATCH v3 10/10] Documentation/amdgpu: Add PM policy
> documentation
>
> Add documentation about the newly added pm_policy node in sysfs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  Documentation/gpu/amdgpu/thermal.rst |  6 ++++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c   | 48
> ++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/thermal.rst
> b/Documentation/gpu/amdgpu/thermal.rst
> index 2f6166f81e6a..6d942b5c58f0 100644
> --- a/Documentation/gpu/amdgpu/thermal.rst
> +++ b/Documentation/gpu/amdgpu/thermal.rst
> @@ -49,6 +49,12 @@ pp_power_profile_mode  .. kernel-doc::
> drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pp_power_profile_mode
>
> +pm_policy
> +---------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pm_policy
> +
>  \*_busy_percent
>  ---------------
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9cca4716ec43..45766d49f1f2 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2214,6 +2214,54 @@ static int pp_dpm_clk_default_attr_update(struct
> amdgpu_device *adev, struct amd
>       return 0;
>  }
>
> +/**
> + * DOC: pm_policy
> + *
> + * Certain SOCs can support different power policies to optimize
> +application
> + * performance. However, this policy is provided only at SOC level and
> +not at a
> + * per-process level. This is useful especially when entire SOC is
> +utilized for
> + * dedicated workload.
> + *
> + * The amdgpu driver provides a sysfs API for selecting the policy.
> +Presently,
> + * only two types of policies are supported through this interface.
> + *
> + *  Pstate Policy Selection - This is to select different Pstate
> +profiles which
> + *  decides clock/throttling preferences.
> + *
> + *  XGMI PLPD Policy Selection - When multiple devices are connected
> +over XGMI,
> + *  this helps to select policy to be applied for per link power down.
> + *
> + * The list of available policies and policy levels vary between SOCs.
> +They can
> + * be viewed by reading the file. The policy level which is applied
> +presently is
> + * denoted by * (asterisk). E.g.,
> + *
> + * .. code-block:: console
> + *
> + *   cat /sys/bus/pci/devices/.../pm_policy
> + *   soc pstate
> + *   0 : soc_pstate_default
> + *   1 : soc_pstate_0
> + *   2 : soc_pstate_1*
> + *   3 : soc_pstate_2
> + *   xgmi plpd
> + *   0 : plpd_disallow
> + *   1 : plpd_default
> + *   2 : plpd_optimized*
> + *
> + * To apply a specific policy
> + *
> + * "echo <policy type> <level> > /sys/bus/pci/devices/.../pm_policy"
> + *
> + * For the levels listed in the example above, to select
> +"plpd_optimized" for
> + * XGMI and "soc_pstate_2" for soc pstate policy -
> + *
> + * .. code-block:: console
> + *
> + *   echo "xgmi 2" > /sys/bus/pci/devices/.../pm_policy
> + *   echo "soc_pstate 3" > /sys/bus/pci/devices/.../pm_policy

The naming should be consistent between what is printed when you read the f=
ile and what you write to it.  E.g., policy_type should be soc_pstate and x=
gmi_plpd in both cases.

Alex

> + *
> + */
> +
>  static ssize_t amdgpu_get_pm_policy(struct device *dev,
>                                   struct device_attribute *attr, char *bu=
f)  {
> --
> 2.25.1

