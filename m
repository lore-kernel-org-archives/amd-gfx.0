Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC0C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB8C10E1C5;
	Thu, 16 May 2024 19:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sy2i9Zbu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA0610E1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU9kuVZlKRfz+QcMPESQqKqXxRtuxM2q7ka26ZUFufya5/7aHgPTc2tZHjtBOSqp2woC7Usos9Vw5d8Jta44LrVCIyo+CZzdf/tN2GWJYpY7p3SV9DcyxKyI1ZDOVOpon3rWCzLWn7RieoYZC+qfFj2cZSVc50MaVm0Hy6zgBgXMWafDunq3MZ+RPbtzXM18q8jXGIkIlJ7Kb+2igwFKKW1cW3rIm6M1ni4OlTmE/6Zz29csHEFUh86RtHYLpZpoNog3zgawB743OP2AK/Ol/aAjvppPqEpxeHMtufHTmvU7MrSVRRTEi5c3gEpPzErOzfvR297Hv80aN6Kjm+6JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q50YGFsDSnZwnKvOVOV+iOcY2iDrO25s7aW67lMnLwQ=;
 b=Ddwf2RSsogvOGNp7PDcYP+ymcN1xsYqkKlblMGiQyzJFcuP71XkxRuVXrWoVQyL3iTF4Xo66hg727/3kTwQ+Nxalv1ANXwViQC+OvcSoyfdnuKFkwPEXCwFXvoP561RAy7QzQMXPZmpPWcVUFmvvl7QAY44QB5Aaq8sgm9HrihHHYpSoIAK9VO6uCKYiLsDXcAp6q+827uz2FwJBmYB4dtuAMbimMsVvAmaQLvcjmYmYJZYhZhYWhGH+macubMSOuFlINi29qSLA4zJZi+9BZZReC909RQri5YfAK1b+lEpY5KyrkioPOyXYJ3zJVZ6yJIQ2uK7JltHte0DckoQGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q50YGFsDSnZwnKvOVOV+iOcY2iDrO25s7aW67lMnLwQ=;
 b=sy2i9ZbuRi5VZXbrP8YQEL8cqkGs1oEOVWEyS+AtxXrsY4dgUlpMB9h5DNyqfeY3d1sDpk8bzeELxSDtAsOVx5YUwvvoUmWHrO5tvHIsKLZ80LsahHOjpdv9B7iNY4y/8FkOPlfVMXkWZs4SvF5+0juOCzMeLoGd3p969f8gEvc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:26:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 19:26:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: Re: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy documentation
Thread-Topic: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy
 documentation
Thread-Index: AQHap467EqM0yFP850mzI7DZ7KCC77GaPmv9
Date: Thu, 16 May 2024 19:26:38 +0000
Message-ID: <BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
 <20240516124318.508785-11-lijo.lazar@amd.com>
In-Reply-To: <20240516124318.508785-11-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-16T19:26:38.248Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY5PR12MB6321:EE_
x-ms-office365-filtering-correlation-id: 304e725c-4d15-4446-d856-08dc75de1ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?AP15sdUAXyUrq+BVZDfu5yPYKF3SVVvAbPT0SiGqEi2edsudyGPZkKzCwUD5?=
 =?us-ascii?Q?kVjR69C8u0GLZSPa49q/ENCFn8MlQlfzhPV9V0xkdlSSySjR/vbE9PxI6Z1z?=
 =?us-ascii?Q?zZUEzK8HJOHWdFKfQYWbdjk5Squ/juy+m9m05Bx7Wop16XyqIq3I+2fKSa9g?=
 =?us-ascii?Q?sl74RGNypn6dry2DWE89J+gMc++1Rr22d25elsMGurjS1q6xqN1yFbpnRqVc?=
 =?us-ascii?Q?o0VsAGEkmunenC1vQ9cBYann7oTI+51Gi7KK9BsL+pkwWCMb7a9kGNVV6hyA?=
 =?us-ascii?Q?+9Bwaro7a0Ig2OjCuftOLzFwste2OpBovGOoEJ2cUluaT7isdadzgiO5brWz?=
 =?us-ascii?Q?G1JzvelLA0qaavG+cWB9mjZGR1CxlYPqB8Mzri6PEYUh6ETRlRkbkjCmgqQG?=
 =?us-ascii?Q?/i3dViKBouY0FWWCULXR746rpZCLT9YjCSzmAc3oiBWtxx/RXQmmXDcVTQwH?=
 =?us-ascii?Q?CoWr5VrjEplvqEZPiY4xKqQ90u/XkeHqtODy/gFRKDHz5BvqYnErmUYC7n7R?=
 =?us-ascii?Q?T9bSWjOQeHHj6lwuv5amSHc5vl4U/TKEWkfrdwu0ofhBGca3SshRA65vcvH8?=
 =?us-ascii?Q?AJfnSM8bLuEclePZbwEn509gsApC+jhVfSMwKv6N1ujOXCo5u2QZ4ZUzkXo8?=
 =?us-ascii?Q?6Il0nHpn2ONT8KCiH+ZIjSzJXxAvYrl6r+7fJgarqOO/jOHm+dg2W9OoKuBU?=
 =?us-ascii?Q?Ul8wzDkgF6ws85NP4jfCJRjeSWNgJ8yX8AmjVCjXbfiAtD3i07IIlGQ9F9gw?=
 =?us-ascii?Q?UHBvPOayhY4aeBHje7nVCySfmmMGXENoanD5RrTUcDnSg3X4sEaThT6lpg/K?=
 =?us-ascii?Q?hzOKnWyDpWwrEucDadJr67oNij6lWkI7MOniAF2QQEyG4xhk28QNN7X31hCU?=
 =?us-ascii?Q?Z8FhA6drbOZ+2lqjBBddU/0e29DEcNwWvaHAozvfhts4KUVa6F+c9NHzrHC1?=
 =?us-ascii?Q?VWD+plfoILYb0HocTHkh2QwAPitl5lbI1BqP0jDew+WI7jU/zapZ92Z3Zvo0?=
 =?us-ascii?Q?SW+AMAQDF9GqDXBiRPAYZKyGzUqdD8ndC+5Ws72dZZVWOmSjYPhsbIFzHcXY?=
 =?us-ascii?Q?OT41OM/wLL9bsmMgiv7GQppqTPzMAy/X0Wqg30Ws4rPkMhAi0ZUDmJHXvH1h?=
 =?us-ascii?Q?QMU0gtUsdsV0LwcztrRiMWBrZFddEWQs7u718VWCehtZIrEzABo189GfapSr?=
 =?us-ascii?Q?0yNw9OpX7ZdC7CEwg4LzULL92YYTM/SHzBKjpkD46X/qe9+wVoy4XFJYIUCc?=
 =?us-ascii?Q?c2Zs/JaUG226/ns8wfkwq7ZjlmOoYAKIjkQI9CsgXsjgPzLYd8BmzWnTUY6q?=
 =?us-ascii?Q?hKkdcLic7O3ZEkdRQnEs7EtC/eyBgrEf3DHskfXd8a3HUQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ml4TT+hY91E1w1EZt4oXpeCukK3ouCZ2xQAkhWCTLZPjVsZx3V9Oi/o1AgIl?=
 =?us-ascii?Q?Qyh8aR/lGDEH5JXHpue9FX29KLCn2ymnpwOFTSC125DmrSRBCsOps1zBDnLo?=
 =?us-ascii?Q?AlJBO5L0IT8nZtbt4JG/Ec2XVZ3ZxIJcm/FeRwyOhXJZZdG94AIeNaw7acLa?=
 =?us-ascii?Q?rqJ92aLC7ppZlaeiYzSKAs6211wbOKTE7R4BC4YaBa24+pGQUhkq5AB0X3UF?=
 =?us-ascii?Q?yPABMpGuDWlAGPC5VDFGs9D1tUyQWVXVzxfOVO3u6XFkzSfhDfMeWeRM29AI?=
 =?us-ascii?Q?ugyOu8SHxIzKSzCU6neq5aEH5qsW32AXu8kWogF4bdIqdA0akcOHbj+gAJIy?=
 =?us-ascii?Q?JoRdxpdeNaJ/FgH7aPOZPEsI15snlYTFxG1ocY7DeBg2m5SUjs5B+dt2qYT1?=
 =?us-ascii?Q?0PwSGf367R2k4kk+EEsDAQk0icJ5JDJ2uNo9nVbJ20MhOeUoPdDtUtvdzxOX?=
 =?us-ascii?Q?tvmSllCVaSClGsXHd4UuF8ED03DC414qGHkd0mvAuALIIutFzTzKw4ICp7YG?=
 =?us-ascii?Q?40mXgmDq7Kr7+AK1uh8F5n6xIT5fLtOfdOKvWl3VRiTSSaCyfSCaC5ShP7cX?=
 =?us-ascii?Q?n23NEgYuJpBEEpcu3Ke756mu2+e9OqfiQJdh9S8raXfjLUDggoZrBLtHZaeU?=
 =?us-ascii?Q?CrMqzlTm0h17XLUgHNsv/92D//iGW3bjchnzu2VLgiFSweraXSVAx+qAya5h?=
 =?us-ascii?Q?0mwlLeqttTMWUugbZcIisgR1Tx0q4nHTZTh4i2b/jDtbsSIkpH/I01XfXkkB?=
 =?us-ascii?Q?s0odiS3wa7Iv1Xs8VKvPLotUl7EEThM20wxGRHxkGYnNp1HusWzjmrbg0nuk?=
 =?us-ascii?Q?GZHfbW4fkoJDEchY+QPj5T9F15yUdPI6MQOhEjSGPsrMb6K8l9nq3V2bN49F?=
 =?us-ascii?Q?it8/RjOybXhmxm7BmWpuOYXTbNlmPJHDMTb+YZl6AVLpP/NV8dtYmSMKzspl?=
 =?us-ascii?Q?CvMoSUkenY0yFryozJsWdafm7aX6fcmVe9dLQAAxyuIe+OhynXL2Ju/H2lhR?=
 =?us-ascii?Q?8p9wm9YU0WFihiWjcMPLZMB6+PZeoht2IXxCHUyjztCoSISjn6sxSX4/7bey?=
 =?us-ascii?Q?b0o6a9M6eu7jpDyCAgQP3rpxuDpZKEOwbN1YOMa1E9+hhoLSQl/87lRdChwY?=
 =?us-ascii?Q?1Zq53eCw4T3bay4JgL472+xn9wiy3fNFGRbzlS+xADHrS7urXwXbhj8awzpt?=
 =?us-ascii?Q?+90ZrNIaFgXyHww51XE8YT5MTzF2t7hsz/QAHadK69kwhISgPxwlzXdVSZ5W?=
 =?us-ascii?Q?HsDKui9ryD7iV02usE68KCHHdM6vdUhAnausi8bdailrN0VgDuZcqHtWhlAl?=
 =?us-ascii?Q?xfkqod7IX4FFatJLTG4RmuHyZM8R95bJmjGeGOEmKzcmEeKFbPvQ9BdOfiR7?=
 =?us-ascii?Q?GaommOM6F1IFeDn2Ks1kmYEaGwe27ocxXyQoEgIs/BS0SLOqLykD/VLQx9AW?=
 =?us-ascii?Q?5Uut6XGPekB6v20Vm/EaU+BU3aFU0Kl+OT+xdcyydRzgL1l4AGY1+wpPRk4p?=
 =?us-ascii?Q?zLrNFxgotR6v1TQfO79zLfeKa0ANgko9qVLWYTAuOnMUhwnbPDWJKjcQBfli?=
 =?us-ascii?Q?KldfY0coD24lSgOUUYA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304e725c-4d15-4446-d856-08dc75de1ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 19:26:38.6529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSDFy8PpJvLR9q0jV3/ppXhS434O6VmJWBobXrnEt2UlDFSA4B5HP4L+56+emNBbk3lE4vOdCLCmKvNE37ml/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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

--_000_BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I didn't have time to go through every patch in detail, but overall it look=
s good to me.  The series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, May 16, 2024 8:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy documentation

Add documentation about the newly added pm_policy node in sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v5: Update documentation to reflect pm_policy nodes and sub nodes for each
policy type

 Documentation/gpu/amdgpu/thermal.rst |  6 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c   | 53 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgp=
u/thermal.rst
index 2f6166f81e6a..6d942b5c58f0 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -49,6 +49,12 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_power_profile_mode

+pm_policy
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: pm_policy
+
 \*_busy_percent
 ---------------

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5ff7783dfc43..3e5ffb83f398 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2220,6 +2220,59 @@ struct amdgpu_pm_policy_attr {
         enum pp_pm_policy id;
 };

+/**
+ * DOC: pm_policy
+ *
+ * Certain SOCs can support different power policies to optimize applicati=
on
+ * performance. However, this policy is provided only at SOC level and not=
 at a
+ * per-process level. This is useful especially when entire SOC is utilize=
d for
+ * dedicated workload.
+ *
+ * The amdgpu driver provides a sysfs API for selecting the policy. Presen=
tly,
+ * only two types of policies are supported through this interface.
+ *
+ *  Pstate Policy Selection - This is to select different Pstate profiles =
which
+ *  decides clock/throttling preferences.
+ *
+ *  XGMI PLPD Policy Selection - When multiple devices are connected over =
XGMI,
+ *  this helps to select policy to be applied for per link power down.
+ *
+ * The list of available policies and policy levels vary between SOCs. The=
y can
+ * be viewed under pm_policy node directory. If SOC doesn't support any po=
licy,
+ * this node won't be available. The different policies supported will be
+ * available as separate nodes under pm_policy.
+ *
+ *     cat /sys/bus/pci/devices/.../pm_policy/<policy_type>
+ *
+ * Reading the policy file shows the different levels supported. The level=
 which
+ * is applied presently is denoted by * (asterisk). E.g.,
+ *
+ * .. code-block:: console
+ *
+ *     cat /sys/bus/pci/devices/.../pm_policy/soc_pstate
+ *     0 : soc_pstate_default
+ *     1 : soc_pstate_0
+ *     2 : soc_pstate_1*
+ *     3 : soc_pstate_2
+ *
+ *     cat /sys/bus/pci/devices/.../pm_policy/xgmi_plpd
+ *     0 : plpd_disallow
+ *     1 : plpd_default
+ *     2 : plpd_optimized*
+ *
+ * To apply a specific policy
+ *
+ * "echo  <level> > /sys/bus/pci/devices/.../pm_policy/<policy_type>"
+ *
+ * For the levels listed in the example above, to select "plpd_optimized" =
for
+ * XGMI and "soc_pstate_2" for soc pstate policy -
+ *
+ * .. code-block:: console
+ *
+ *     echo "2" > /sys/bus/pci/devices/.../pm_policy/xgmi_plpd
+ *     echo "3" > /sys/bus/pci/devices/.../pm_policy/soc_pstate
+ *
+ */
 static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)
--
2.25.1


--_000_BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I didn't have time to go through every patch in detail, but overall it look=
s good to me.&nbsp; The series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 16, 2024 8:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> [PATCH v5 10/10] Documentation/amdgpu: Add PM policy docume=
ntation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add documentation about the newly added pm_policy =
node in sysfs.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
<br>
v5: Update documentation to reflect pm_policy nodes and sub nodes for each<=
br>
policy type<br>
<br>
&nbsp;Documentation/gpu/amdgpu/thermal.rst |&nbsp; 6 ++++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp; | 53 +++++++++++++++++=
+++++++++++<br>
&nbsp;2 files changed, 59 insertions(+)<br>
<br>
diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgp=
u/thermal.rst<br>
index 2f6166f81e6a..6d942b5c58f0 100644<br>
--- a/Documentation/gpu/amdgpu/thermal.rst<br>
+++ b/Documentation/gpu/amdgpu/thermal.rst<br>
@@ -49,6 +49,12 @@ pp_power_profile_mode<br>
&nbsp;.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&nbsp;&nbsp;&nbsp; :doc: pp_power_profile_mode<br>
&nbsp;<br>
+pm_policy<br>
+---------------------<br>
+<br>
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+&nbsp;&nbsp; :doc: pm_policy<br>
+<br>
&nbsp;\*_busy_percent<br>
&nbsp;---------------<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 5ff7783dfc43..3e5ffb83f398 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2220,6 +2220,59 @@ struct amdgpu_pm_policy_attr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_pm_policy id;<br>
&nbsp;};<br>
&nbsp;<br>
+/**<br>
+ * DOC: pm_policy<br>
+ *<br>
+ * Certain SOCs can support different power policies to optimize applicati=
on<br>
+ * performance. However, this policy is provided only at SOC level and not=
 at a<br>
+ * per-process level. This is useful especially when entire SOC is utilize=
d for<br>
+ * dedicated workload.<br>
+ *<br>
+ * The amdgpu driver provides a sysfs API for selecting the policy. Presen=
tly,<br>
+ * only two types of policies are supported through this interface.<br>
+ *<br>
+ *&nbsp; Pstate Policy Selection - This is to select different Pstate prof=
iles which<br>
+ *&nbsp; decides clock/throttling preferences.<br>
+ *<br>
+ *&nbsp; XGMI PLPD Policy Selection - When multiple devices are connected =
over XGMI,<br>
+ *&nbsp; this helps to select policy to be applied for per link power down=
.<br>
+ *<br>
+ * The list of available policies and policy levels vary between SOCs. The=
y can<br>
+ * be viewed under pm_policy node directory. If SOC doesn't support any po=
licy,<br>
+ * this node won't be available. The different policies supported will be<=
br>
+ * available as separate nodes under pm_policy.<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/.../pm_policy/&lt;poli=
cy_type&gt;<br>
+ *<br>
+ * Reading the policy file shows the different levels supported. The level=
 which<br>
+ * is applied presently is denoted by * (asterisk). E.g.,<br>
+ *<br>
+ * .. code-block:: console<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/.../pm_policy/soc_psta=
te<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 0 : soc_pstate_default<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 1 : soc_pstate_0<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 2 : soc_pstate_1*<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 3 : soc_pstate_2<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/.../pm_policy/xgmi_plp=
d<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 0 : plpd_disallow<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 1 : plpd_default<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 2 : plpd_optimized*<br>
+ *<br>
+ * To apply a specific policy<br>
+ *<br>
+ * &quot;echo&nbsp; &lt;level&gt; &gt; /sys/bus/pci/devices/.../pm_policy/=
&lt;policy_type&gt;&quot;<br>
+ *<br>
+ * For the levels listed in the example above, to select &quot;plpd_optimi=
zed&quot; for<br>
+ * XGMI and &quot;soc_pstate_2&quot; for soc pstate policy -<br>
+ *<br>
+ * .. code-block:: console<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;2&quot; &gt; /sys/bus/pci/devices/..=
./pm_policy/xgmi_plpd<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;3&quot; &gt; /sys/bus/pci/devices/..=
./pm_policy/soc_pstate<br>
+ *<br>
+ */<br>
&nbsp;static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2BL1PR12MB5144namp_--
