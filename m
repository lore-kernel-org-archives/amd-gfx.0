Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C870C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 11:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79EF10E19D;
	Fri, 25 Mar 2022 11:25:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6991110E324
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 11:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv0vwyLom3agT06iccIog30rL0ct6oV0QdioPmQM4ZCbfMLPIlHOkmC4oN9BruEy8I2D5YDrpeg1cCI+Liqa2tsTv1QucZvYmHrsbz8fyUsnEKgdlpU2/h0UquwaMxpN3LrEqP9o13aX7x0X6xJ9BwbDX8GwIILN9C/Q0g1MwD4O8bf5M7l2vwAhzgeZ2d+lo4xYRg6dhHxLdSrgyH9tXiWdiTrh9aFbQqbzlOppqGVMsp53Cc/jYSU+Yy/k9AjsgUWCsDryKN5gdNUTyddmlvFj+yLdnFH7QIpxFHNPR5llKuH9AJHRA6zRSG1vIsgTLvcAR/Ru93PT2A6EmpKQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciA3I73ArvjKBQth55DHyI9l0G9GN9bDr3eDMsDq59M=;
 b=NMMLgn78v8fveL/bnqtqxahIfOwSyfeyYCaDgQSnoZwydtA0j2qvttAcO69082nZN0FWVga/oCd5Hj6fsUNvRkSpFPEcTx0jcFCb3UWDOBh0yP/72P2DGBwchOJnRdB9CqqPbXoJRuGViW5CWO5IDgIOup9aDPf3mn7wnvmU68lqbSjvhW1ZTEiqRXpkO45GiuppkrQ+K72Idv/FFl6CglTG1DW4XEAZLAkw0A5tJWNRlChN0eOHbzgbaB4/7tjAyx9AIfVxd+HHW9n4rMD3+2T9UuOuY9NkwYnTPNmHF8vi639X0df3fdDKj+SIv/o/tPGmJJqadoDwy4Wz/cUR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciA3I73ArvjKBQth55DHyI9l0G9GN9bDr3eDMsDq59M=;
 b=ViROFe/S2wcAQd+QHNIGFiExiGcrTmX8cGYw3bu4UJVDPVHlco/lfcSU+AVe6UfxQk8orPJYLv+06mRhMKo1j9NRpDoB2PDlBB/80+nN9eCDYgOPU+/PaW9FL6urQbb0LawauhhsSogeX5uE80wa6sm02T0y1Jq3ppWcBWn+SsY=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 11:25:20 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::1cd6:26c2:47da:bfb3]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::1cd6:26c2:47da:bfb3%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 11:25:20 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Check feature support using IP version
Thread-Topic: [PATCH] drm/amd/pm: Check feature support using IP version
Thread-Index: AQHYQCK/PAvKosNcfk2AH6NHn9cxVKzP9NEz
Date: Fri, 25 Mar 2022 11:25:19 +0000
Message-ID: <CO6PR12MB5473D304FAB582F9E208A6AE821A9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220325083115.1311275-1-lijo.lazar@amd.com>
In-Reply-To: <20220325083115.1311275-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-25T11:25:19.614Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb771e1-abf2-4b82-e1f7-08da0e52255e
x-ms-traffictypediagnostic: CH2PR12MB4119:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4119C0DC41A917E77DCF5DBF821A9@CH2PR12MB4119.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyRd64i4Y/xxvIZAQW+z6cuOS5hj0U/li8mwX79zjt4pmf+X8HWmXYsTn+07nJI7qERXyVV+DCvJrcE0Ok0RFWU1WUm62+4YOdyHQ0/skenHOtuwIDOzaAdmXf/5LL3VmQgBCwMdetFo5LWcj9SOetoZg77vJve4ghMI1fojkVlaHH7UDfHP9e+hSIi+NOHSNchz4QNXW26BSkjlGC2ZyhFMORIrDOQSD67Pna4kbpeARSP0LMdW5jhJu91Hq/V/XBawP0iGdDFFSf/UBX0ZCrn+75F9n8i8uSqO3Lqglo2eBicHS5FqQZM4Y3STwcH5CaIAJzu3LQo0gI7MhF7e4iR159fuKgpGF1wYG+pTNOxf+avj3xZn0LpY3Ektp7L0vVkcyyseQ8XPnuLQb9p4neKi0WLshlxHvMTUX/esu6kl7F8lccjno1CeZcZM9hWajVAKcP8R29rQ2fsVozxphzRJFIS0H6q8LkOHYdAq9FQjHZCzjI52lBZnJii9D/KsQbVysUNVl/yPeC2qukWJGEo7VnQWy3JoqTmG+doN5MiSvWLsp+ncLAq6y1UvsjZTgcMgAvZSYhRrxodxSgfr3uPWB9PVy9BSoWo6g59z81sk/R5y2do21OjPXfUk8fFVG5ZigFkUFfGaPVuFEOVW5v2/H1gKJLHGV5prxYg1U7mdzKFt7eo/2nUhTPAnYQankkV7R0/oj9mn0VFvQL4kXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(91956017)(54906003)(66476007)(110136005)(64756008)(66946007)(76116006)(66446008)(38070700005)(6506007)(19627405001)(66556008)(2906002)(508600001)(8936002)(5660300002)(38100700002)(71200400001)(52536014)(122000001)(316002)(83380400001)(8676002)(86362001)(53546011)(55016003)(33656002)(9686003)(7696005)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?coqV9kwx4EzfEb2rhVVIWV1w9PutgHPB4xJ4Y+p26oW0Xy0HUIbMDWgUOy?=
 =?iso-8859-1?Q?ien3mj9LLpwOG8TD73PIqJFjLa52LPmHQc5crvoTKhhTzORnXG2J7rlKy2?=
 =?iso-8859-1?Q?VTVVJ2QA/MTXVivD+iglV4gYd6JO3BnAX5Cz5owl3TrUmBNGm9DXGqbfhy?=
 =?iso-8859-1?Q?x15AQije65MhUqVgON/bjrQ4KODsjLvb4SPef7sfpUcirGaU+685Hxchfl?=
 =?iso-8859-1?Q?GY1WOha5lSmOjKvlax0FVDUYet47Skk+gQCIRbGXwgEvivGifaksNinNWy?=
 =?iso-8859-1?Q?Cy+7Qw4NQHPt8rDwEMjJ5KNK7v2pkalieXvzAQxcI7TMwel0cTLTYluxOP?=
 =?iso-8859-1?Q?uY4gOu/pa/rVEKSdShzrCv2CzEGtHZgSJS/ooGCOxf4rjQsiWKkfvxYCmV?=
 =?iso-8859-1?Q?Q4UkhiAAnvZbBw1UM+hLb1rj1Sbwlj0YiN+6s3/wr64YQ8tg8e4G5Q72pX?=
 =?iso-8859-1?Q?WgrQYrewq8Q2CU5tNj+rrN85FFDLF1r1lC0IZ9MbOInzrkPPynIJeUl4NM?=
 =?iso-8859-1?Q?fZ8zH24xTGA6WGzguz5f4MM+Y0W7dx5pxscTwIvj8/BElqwsDiWJG6cdhW?=
 =?iso-8859-1?Q?Pw3X05vN7JfDkKsGgkOmzKn1PTlmY1Mlyx7GGpDsMazSJ1UMu+2NhiH9Hi?=
 =?iso-8859-1?Q?LFlXGhxx59x2i1hbabOcrYsp3RvM28BNMHTW0okihWZzAkRVWauG1hzLLF?=
 =?iso-8859-1?Q?MYmuEMPVdtaxkACmt+7iF5P9XB/aQAFqPM/Uy8Zhazf+WTHjkBXKwzRgR6?=
 =?iso-8859-1?Q?lfVEan0bgpisU46do+HSvEPz4goc+/GiS47beGkL4X4WbPWJKooeT5knM9?=
 =?iso-8859-1?Q?pcZlRF/Zv/X6MeKNIoCQJHe6+QESAh2U2FSECCYzrXpTRYi41z+iiP7Kpr?=
 =?iso-8859-1?Q?SjAu4jaLmUYVuEJqb76mSNdWG7UKjpOzT8grTABpiC/N9r9K6ghbBhBRVd?=
 =?iso-8859-1?Q?kxLvzbwKCPnQlEwL0xPIXV045Gpf1Ll7ADYki5ZwJguIhzPW+2siZsVH+D?=
 =?iso-8859-1?Q?ePDip2LkaW1PGjKZnE3ZIpFj5wGOG3o88+yN6g4MSd5HtKYndrKrGAu7nz?=
 =?iso-8859-1?Q?rHyP+6IeDm4GF7qgY2TycQKneogq49LpMpFHPS5oVDYmUY/mdAu1+lcfy7?=
 =?iso-8859-1?Q?7ydH1VQWSH0D/WB/qNzRBrn/4gJOCCzM5wmIkYYs7WfMvliElxCLz0wRME?=
 =?iso-8859-1?Q?JCry0k5WlqPWiQZ6fNJvHDMMfWiRitXOL6OpLQiMz1lk6Q/D2qqodgHlsx?=
 =?iso-8859-1?Q?F+2vMP8WZiETJBlrKM25b73t7JzaSGIi330Dbt8oIuU9mSkfbpSBssDtOV?=
 =?iso-8859-1?Q?QwMCglo3L52tbbxL7v08FJwGjfi2A6noDKbaJs3vCsGyKebwo7g1ZBin3X?=
 =?iso-8859-1?Q?Mb+CBh/o9cLrEmNT/TgVwHvlGE79OPf/pRkY094yl86K5VQwNiIDyKxuS7?=
 =?iso-8859-1?Q?I08TR3v0Jsj0VS9LPrSZbsN6s7KT3uRe0iiAAHpb7lPCoqqvDG+bXJoXY0?=
 =?iso-8859-1?Q?35rmzuI3r9Tx9eMU2j1ade8+O0jDjJlWa0RrjZv/M/54yot5HmDAzqe+4f?=
 =?iso-8859-1?Q?uRJigq9h9YSnlXxJwVukv9myGirgukDceE/OzNoQyDtArFe3yq2/HrCQdm?=
 =?iso-8859-1?Q?mtzwNK3aZuiIHtsJ+VOsHLJDP87qPktjRs0FVhpcmuHlobwCA2FbYgnf0e?=
 =?iso-8859-1?Q?paXKUkhRFh8WVRMntHgtZGsrGtgATu99K47K42/4HvGHF5p82amLBpoWrY?=
 =?iso-8859-1?Q?BJ7JM0RpPzu/8IUYpDF/Z3rD8uUxRWCj6RfSjOZ4563lr5?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473D304FAB582F9E208A6AE821A9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb771e1-abf2-4b82-e1f7-08da0e52255e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 11:25:20.0136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLxHxrFPadkjq46ZsTb5z9eu3eyo6rAnx1cF9DFzk4f1Paf6wsxJQ5/9GGpGSqnP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473D304FAB582F9E208A6AE821A9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

       if (adev->asic_type > CHIP_VEGA20) {
+       if (gc_ver !=3D IP_VERSION(9, 4, 0) && mp1_ver > IP_VERSION(9, 0, 0=
)) {
                 /* VCN clocks */
[kevin]:

please put some comments here (why mp1_ver and gc_ver is needed both), it c=
an help developer to understand some backgrounds.
thanks.

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, March 25, 2022 4:31 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Quan, Evan <Ev=
an.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Check feature support using IP version

Instead of ASIC type, use GC and MP1 IP versions for feature support checks=
.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 72 ++++++++++++++++--------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5cd67ddf8495..f89e0ff3f5a4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1954,8 +1954,9 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                                uint32_t mask, enum amdgpu_device_attr_stat=
es *states)
 {
         struct device_attribute *dev_attr =3D &attr->dev_attr;
+       uint32_t mp1_ver =3D adev->ip_versions[MP1_HWIP][0];
+       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
         const char *attr_name =3D dev_attr->attr.name;
-       enum amd_asic_type asic_type =3D adev->asic_type;

         if (!(attr->flags & mask)) {
                 *states =3D ATTR_STATE_UNSUPPORTED;
@@ -1965,53 +1966,55 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
 #define DEVICE_ATTR_IS(_name)   (!strcmp(attr_name, #_name))

         if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-               if (asic_type < CHIP_VEGA10)
+               if (gc_ver < IP_VERSION(9, 0, 0))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-               if (asic_type < CHIP_VEGA10 ||
-                   asic_type =3D=3D CHIP_ARCTURUS ||
-                   asic_type =3D=3D CHIP_ALDEBARAN)
+               if (gc_ver < IP_VERSION(9, 0, 0) ||
+                   gc_ver =3D=3D IP_VERSION(9, 4, 1) ||
+                   gc_ver =3D=3D IP_VERSION(9, 4, 2))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
-               if (asic_type < CHIP_VEGA20)
+               if (mp1_ver < IP_VERSION(10, 0, 0))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
                 *states =3D ATTR_STATE_UNSUPPORTED;
                 if (amdgpu_dpm_is_overdrive_supported(adev))
                         *states =3D ATTR_STATE_SUPPORTED;
         } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
-               if (adev->flags & AMD_IS_APU || asic_type =3D=3D CHIP_VEGA1=
0)
+               if (adev->flags & AMD_IS_APU || gc_ver =3D=3D IP_VERSION(9,=
 0, 1))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pcie_bw)) {
                 /* PCIe Perf counters won't work on APU nodes */
                 if (adev->flags & AMD_IS_APU)
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(unique_id)) {
-               if (asic_type !=3D CHIP_VEGA10 &&
-                   asic_type !=3D CHIP_VEGA20 &&
-                   asic_type !=3D CHIP_ARCTURUS &&
-                   asic_type !=3D CHIP_ALDEBARAN)
+               if (gc_ver !=3D IP_VERSION(9, 0, 1) &&
+                   gc_ver !=3D IP_VERSION(9, 4, 0) &&
+                   gc_ver !=3D IP_VERSION(9, 4, 1) &&
+                   gc_ver !=3D IP_VERSION(9, 4, 2))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_features)) {
-               if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
+               if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0=
))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(gpu_metrics)) {
-               if (asic_type < CHIP_VEGA12)
+               if (gc_ver < IP_VERSION(9, 1, 0))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-               if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D CHI=
P_SIENNA_CICHLID))
+               if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 0)))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
-               if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D CHI=
P_SIENNA_CICHLID))
+               if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 0)))
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
                 if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -=
EOPNOTSUPP)
                         *states =3D ATTR_STATE_UNSUPPORTED;
         }

-       switch (asic_type) {
-       case CHIP_ARCTURUS:
-       case CHIP_ALDEBARAN:
+       switch (gc_ver) {
+       case IP_VERSION(9, 4, 1):
+       case IP_VERSION(9, 4, 2):
                 /* the Mi series card does not support standalone mclk/soc=
clk/fclk level setting */
                 if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
                     DEVICE_ATTR_IS(pp_dpm_socclk) ||
@@ -2026,7 +2029,7 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_

         if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
                 /* SMU MP1 does not support dcefclk level setting */
-               if (asic_type >=3D CHIP_NAVI10) {
+               if (gc_ver >=3D IP_VERSION(10, 0, 0)) {
                         dev_attr->attr.mode &=3D ~S_IWUGO;
                         dev_attr->store =3D NULL;
                 }
@@ -2864,8 +2867,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct d=
evice *dev,
                                          char *buf)
 {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];

-       if (adev->asic_type =3D=3D CHIP_VANGOGH)
+       if (gc_ver =3D=3D IP_VERSION(10, 3, 1))
                 return sysfs_emit(buf, "%s\n",
                                   to_sensor_dev_attr(attr)->index =3D=3D P=
P_PWR_TYPE_FAST ?
                                   "fastPPT" : "slowPPT");
@@ -3177,6 +3181,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
         struct device *dev =3D kobj_to_dev(kobj);
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         umode_t effective_mode =3D attr->mode;
+       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];

         /* under multi-vf mode, the hwmon attributes are all not supported=
 */
         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
@@ -3245,18 +3250,18 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
               attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* =
can't manage state */
                 effective_mode &=3D ~S_IWUSR;

+       /* not implemented yet for GC 10.3.1 APUs */
         if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
-                ((adev->flags & AMD_IS_APU) &&
-             (adev->asic_type !=3D CHIP_VANGOGH))) &&     /* not implement=
ed yet */
+            ((adev->flags & AMD_IS_APU) && (gc_ver !=3D IP_VERSION(10, 3, =
1)))) &&
             (attr =3D=3D &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_power1_cap_min.dev_attr.attr||
+            attr =3D=3D &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_power1_cap.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_power1_cap_default.dev_attr.attr=
))
                 return 0;

+       /* not implemented yet for APUs having <=3D GC 9.3.0 */
         if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
-            ((adev->flags & AMD_IS_APU) &&
-             (adev->asic_type < CHIP_RENOIR))) &&       /* not implemented=
 yet */
+            ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)))=
) &&
             (attr =3D=3D &sensor_dev_attr_power1_average.dev_attr.attr))
                 return 0;

@@ -3294,8 +3299,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
                 return 0;

         /* only SOC15 dGPUs support hotspot and mem temperatures */
-       if (((adev->flags & AMD_IS_APU) ||
-            adev->asic_type < CHIP_VEGA10) &&
+       if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
             (attr =3D=3D &sensor_dev_attr_temp2_crit.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp3_crit.dev_attr.attr ||
@@ -3310,13 +3314,13 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
                 return 0;

         /* only Vangogh has fast PPT limit and power labels */
-       if (!(adev->asic_type =3D=3D CHIP_VANGOGH) &&
+       if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1)) &&
             (attr =3D=3D &sensor_dev_attr_power2_average.dev_attr.attr ||
-                attr =3D=3D &sensor_dev_attr_power2_cap_max.dev_attr.attr =
||
+            attr =3D=3D &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
-                attr =3D=3D &sensor_dev_attr_power2_cap.dev_attr.attr ||
-                attr =3D=3D &sensor_dev_attr_power2_cap_default.dev_attr.a=
ttr ||
-                attr =3D=3D &sensor_dev_attr_power2_label.dev_attr.attr))
+            attr =3D=3D &sensor_dev_attr_power2_cap.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_power2_cap_default.dev_attr.attr =
||
+            attr =3D=3D &sensor_dev_attr_power2_label.dev_attr.attr))
                 return 0;

         return effective_mode;
@@ -3421,6 +3425,8 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq=
_file *m,

 static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_dev=
ice *adev)
 {
+       uint32_t mp1_ver =3D adev->ip_versions[MP1_HWIP][0];
+       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
         uint32_t value;
         uint64_t value64 =3D 0;
         uint32_t query =3D 0;
@@ -3467,7 +3473,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file =
*m, struct amdgpu_device *a
         if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_ENABLED_SMC_FEA=
TURES_MASK, (void *)&value64, &size))
                 seq_printf(m, "SMC Feature Mask: 0x%016llx\n", value64);

-       if (adev->asic_type > CHIP_VEGA20) {
+       if (gc_ver !=3D IP_VERSION(9, 4, 0) && mp1_ver > IP_VERSION(9, 0, 0=
)) {
                 /* VCN clocks */
                 if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_POW=
ER_STATE, (void *)&value, &size)) {
                         if (!value) {
--
2.25.1


--_000_CO6PR12MB5473D304FAB582F9E208A6AE821A9CO6PR12MB5473namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;asic_type
 &gt; CHIP_VEGA20) {</span><br>
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gc_ver !=3D
 IP_VERSION(9, 4, 0) &amp;&amp; mp1_ver &gt; IP_VERSION(9, 0, 0)) {</span><=
br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Euro=
pean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robot=
o, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-co=
lor:rgb(255, 255, 255)">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* VCN
 clocks */</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
[kevin]:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
please put some comments here (why mp1_ver and gc_ver is needed both), it c=
an help developer to understand some backgrounds.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks.<br>
<br>
Reviewed-by: Kevin Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, March 25, 2022 4:31 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@am=
d.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Check feature support using IP version<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Instead of ASIC type, use GC and MP1 IP versions f=
or feature support checks.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 72 ++++++++++++++++-------------=
-<br>
&nbsp;1 file changed, 39 insertions(+), 33 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 5cd67ddf8495..f89e0ff3f5a4 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -1954,8 +1954,9 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask, enum amdgpu_device_attr=
_states *states)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *d=
ev_attr =3D &amp;attr-&gt;dev_attr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_ver =3D adev-&gt;ip_vers=
ions[MP1_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *attr_name =3D =
dev_attr-&gt;attr.name;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_asic_type asic_type =3D adev=
-&gt;asic_type;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(attr-&gt;flags &amp;=
 mask)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_UNSUPPORTED;<br>
@@ -1965,53 +1966,55 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_<br>
&nbsp;#define DEVICE_ATTR_IS(_name)&nbsp;&nbsp; (!strcmp(attr_name, #_name)=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_=
socclk)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &lt; CHIP_VEGA10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gc_ver &lt; IP_VERSION(9, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_dpm_dcefclk)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &lt; CHIP_VEGA10 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type =3D=3D CHIP_ARCTURUS ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type =3D=3D CHIP_ALDEBARAN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gc_ver &lt; IP_VERSION(9, 0, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_VERSION(9, 4, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_dpm_fclk)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &lt; CHIP_VEGA20)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (mp1_ver &lt; IP_VERSION(10, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_od_clk_voltage)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_dpm_is_overdrive_supported(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_SUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
mem_busy_percent)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type =3D=3D CHIP_VEG=
A10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || gc_ver =3D=3D IP_VERSION(=
9, 0, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pcie_bw)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* PCIe Perf counters won't work on APU nodes */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
unique_id)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type !=3D CHIP_VEGA10 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type !=3D CHIP_VEGA20 &amp;&amp;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type !=3D CHIP_ARCTURUS &amp;&amp;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type !=3D CHIP_ALDEBARAN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gc_ver !=3D IP_VERSION(9, 0, 1) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver !=3D IP_VERSION(9, 4, 0) &amp;&am=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver !=3D IP_VERSION(9, 4, 1) &amp;&am=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver !=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_features)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type &lt; CHIP_VEGA1=
0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || gc_ver &lt; IP_VERSION(9,=
 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
gpu_metrics)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &lt; CHIP_VEGA12)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gc_ver &lt; IP_VERSION(9, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_dpm_vclk)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D CHIP_SIE=
NNA_CICHLID))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_VERSION(10,=
 3, 0)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_dpm_dclk)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D CHIP_SIE=
NNA_CICHLID))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_VERSION(10,=
 3, 0)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_power_profile_mode)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=
=3D -EOPNOTSUPP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (gc_ver) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* the Mi series card does not support standalone mcl=
k/socclk/fclk level setting */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_mclk) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_socclk)=
 ||<br>
@@ -2026,7 +2029,7 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_=
dcefclk)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* SMU MP1 does not support dcefclk level setting */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &gt;=3D CHIP_NAVI10) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gc_ver &gt;=3D IP_VERSION(10, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_a=
ttr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_a=
ttr-&gt;store =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2864,8 +2867,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VA=
NGOGH)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_ver =3D=3D IP_VERSION(10, 3, 1=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf, &quot;%s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_sensor_dev_attr(a=
ttr)-&gt;index =3D=3D PP_PWR_TYPE_FAST ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fastPPT&quot; =
: &quot;slowPPT&quot;);<br>
@@ -3177,6 +3181,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev =3D kob=
j_to_dev(kobj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umode_t effective_mode =3D=
 attr-&gt;mode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* under multi-vf mode, th=
e hwmon attributes are all not supported */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
@@ -3245,18 +3250,18 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* c=
an't manage state */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; effective_mode &amp;=3D ~S_IWUSR;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* not implemented yet for GC 10.3.1 =
APUs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;family =3D=
=3D AMDGPU_FAMILY_SI) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ((adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
adev-&gt;asic_type !=3D CHIP_VANGOGH))) &amp;&amp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* not implemented yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-=
&gt;flags &amp; AMD_IS_APU) &amp;&amp; (gc_ver !=3D IP_VERSION(10, 3, 1))))=
 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
ttr =3D=3D &amp;sensor_dev_attr_power1_cap_max.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_power1_cap_min.dev_attr.attr||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_power1_cap_min.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_power1_cap.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_power1_cap_default.dev_attr.attr))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* not implemented yet for APUs havin=
g &lt;=3D GC 9.3.0 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;family =3D=
=3D AMDGPU_FAMILY_SI) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-=
&gt;flags &amp; AMD_IS_APU) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
adev-&gt;asic_type &lt; CHIP_RENOIR))) &amp;&amp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* not implemented yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-=
&gt;flags &amp; AMD_IS_APU) &amp;&amp; (gc_ver &lt; IP_VERSION(9, 3, 0)))) =
&amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
ttr =3D=3D &amp;sensor_dev_attr_power1_average.dev_attr.attr))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
@@ -3294,8 +3299,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only SOC15 dGPUs suppor=
t hotspot and mem temperatures */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;flags &amp; AMD_IS_APU=
) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;asic_type &lt; CHIP_VEGA10) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;flags &amp; AMD_IS_APU=
) || gc_ver &lt; IP_VERSION(9, 0, 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
ttr =3D=3D &amp;sensor_dev_attr_temp2_crit.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp3_crit.dev_attr.attr ||<br>
@@ -3310,13 +3314,13 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only Vangogh has fast P=
PT limit and power labels */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;asic_type =3D=3D CHIP_=
VANGOGH) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(gc_ver =3D=3D IP_VERSION(10, 3,=
 1)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
ttr =3D=3D &amp;sensor_dev_attr_power2_average.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_power2_cap_max.dev_attr.a=
ttr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_power2_cap_max.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_power2_cap_min.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_power2_cap.dev_attr.attr =
||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_power2_cap_default.dev_at=
tr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_power2_label.dev_attr.att=
r))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_power2_cap.dev_attr.attr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_power2_cap_default.dev_attr.attr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_power2_label.dev_attr.attr))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return effective_mode;<br>
@@ -3421,6 +3425,8 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq=
_file *m,<br>
&nbsp;<br>
&nbsp;static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgp=
u_device *adev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_ver =3D adev-&gt;ip_vers=
ions[MP1_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value64 =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t query =3D 0;<br>
@@ -3467,7 +3473,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file =
*m, struct amdgpu_device *a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_senso=
r(adev, AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK, (void *)&amp;value64, &=
amp;size))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;SMC Feature Mask: 0x%016llx\n&quo=
t;, value64);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt; CHIP_VEGA=
20) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_ver !=3D IP_VERSION(9, 4, 0) &=
amp;&amp; mp1_ver &gt; IP_VERSION(9, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* VCN clocks */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VC=
N_POWER_STATE, (void *)&amp;value, &amp;size)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
value) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473D304FAB582F9E208A6AE821A9CO6PR12MB5473namp_--
