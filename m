Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCBC2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 05:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1897460FE3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 05:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1897460FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1736E06B;
	Tue, 22 Jun 2021 05:28:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B206E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 05:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU0XPa735Z+XMKv/Td4dUd6quvLWdBEa9Mxi5ccPPq67U/OE8Rxw7Pb9HL+wpMBJpn01KT4TIxREBSAuWlAW5ufezOuj26lo+X1wKYAqHiltFzcptLHsVHnwnBHJ8wDpBA5P7PziAUMmB1K6j/MMiWjRGhQHvjGWhO/DRLXmHEtuawf0kWFr/qKkeeSeuMxPI8rvCMiFAfdLjx38eqKhR6ITl5YsWJo3PxIeILtvIkZsWaII0OM/ZLizKA4qx3xQcVJjlO6DCH8AZzUCSYqOFvb/vn+8FPF5LYRwXukg2en/7vCEpewhxyvIxQ+uWli7D1rjudCMe6cHGOf9JZ1isg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C8aVZ4jPV1XDxNbEwqFWcMVUWfOycAhwZCXg/PjlwA=;
 b=XqOMbkkRYQUxnz9X1gpMgh3XB33jg/qmCVg95J+mVLCuFV4pwGldThXgbiSLTOTkpuq5qPRafboHjrzwnifEn+Uz7ywbsBdo7ekS+Lb5EWP2FBaroX6m49qWY/EwfXxIReJ/nJ1my8XipCri8DUfZA2fflIvI1sBEWOzq0kjR5b3OagsMAhgZT8Ro+31LHMQdg0mEpnRH23BGgFc+BWoonPlrX9i9uVMIZs7RGQIyG5RI1giCDRugE7tG2qInHKKOUjdE5rmO+JT35gQOhlf/gCTR3XBsv0+buxgffudyL/BacgFzUu0dT8GQmMCE6zMA9NhVhliTDKR0INwGbXRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C8aVZ4jPV1XDxNbEwqFWcMVUWfOycAhwZCXg/PjlwA=;
 b=bKhl9KHmoNpWnMtlt1Fw2T3DxXV4D63AuYCqkFeL3LZBEhpeTbQfm4VhR3R8o8DAef24EPFn736bYVwasa4wmSkbtvsRJLdXucJuGqlimdxnWV4G1cpvIkbNyRf24uGe+VC/k/ZC4mGvnh6/CqUjSt7X2l43nMPLGvMwVKnoJ6o=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 05:28:06 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 05:28:06 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap
 calls
Thread-Topic: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap
 calls
Thread-Index: AQHXZx2PzIKs5vTIBUKeGzMQsvgcAqsffx5k
Date: Tue, 22 Jun 2021 05:28:06 +0000
Message-ID: <CO6PR12MB5473C117661C9441AF94AB91A2099@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210622041716.2295-1-darren.powell@amd.com>
In-Reply-To: <20210622041716.2295-1-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-22T05:28:05.707Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2351258b-04f5-487d-b59e-08d9353e83e9
x-ms-traffictypediagnostic: CO6PR12MB5442:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB544249EE4059289C1A4BE774A2099@CO6PR12MB5442.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvniQas/Xd6/mRX5RMgc3lY7izaxgOnlIrsa+8Xm4K4KsUhLdswhJQFVYiJTbhh3Ji27e7OC+pJeXaha/memm/QSpyD0pAZe022EIPq0UEoQyFaxEOFQzoA+ipNvxyJHbOxVZggmSgWl95d4+h9MzufrcbuZEv56NgjSIUkehk6F7aUpHm+zcO96rQUpsWnH/RYPaPtMZ5iaTGGqVR5eDMRbJVASFUFkVb0f8znkJ2q7wa+6xwS2DhQawkNutbiP5C/sFTUkaP1Mtzht0DCgGd3yMmF1gHWxFfHDCZQfG2RhOQKe9FbD+acU4UpXfBSJOt+IpG02dyzVsNGIRM2kP9YiIWDIWg47GyeVMaluR1k+uKkN2lp+S6u4Nd8ObcY90bpzQ3mY1Y7i6O9QHsVl3QV2gK4JUglFBvmnEcotsfHJfjGnkVxWpciNWsSW6IQzD0eqZYt7emzhgV4Ky9JbWBfUaLm1G2fxz8INbrs/fQbxiWCpft8apmucvOXo0AdJx/NPavHwx9FkTDL8BEvbVmMS7hJCyZhsg+H3RTPPbSYDxQBcNCMtDxx8PF1fcsNKnmwSUq3WtVbIFUjmYSM5XI/4MTN6nJO1ibpnd/wELy5EJqiC5vHJ8EpZ7d9Oj434nT+MMW1vsAcUE/ZGCWk4MsfRpRvxQ0CVNuZkFpB5vbEcdR0mkPrSTFVTP12pDKmI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(2906002)(8676002)(45080400002)(478600001)(86362001)(19627405001)(9686003)(966005)(8936002)(33656002)(186003)(6506007)(53546011)(71200400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(110136005)(83380400001)(166002)(7696005)(38100700002)(76116006)(91956017)(316002)(52536014)(55016002)(122000001)(26005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9ag3/uhhbYDJvSWZuvhNdW9KqYsop8kIZDHMNR3Er0rDhcCzPX7g8XOcAp?=
 =?iso-8859-1?Q?1U49Wfe8gZN/PXxuyLyzkWnZ8q0PI2WYiMG53OUP76yYdsBt5w5JHalIhD?=
 =?iso-8859-1?Q?A9Ew2l/JHO2eOSAzl0TpvxtJejiEXM8cfoazLDhKaUAkS51uwAMdUQAjC3?=
 =?iso-8859-1?Q?v7Db5k4xCk+s9xkhoQwu84WLGDEm1AP2rwCi4U7U8nyBO5Sf6p0MeF3P42?=
 =?iso-8859-1?Q?Tk5NeDlEAdO7q4jB5HtdSGplNm/8lLa2+4TVDr1yRXHQEn0F5gr4sve4lC?=
 =?iso-8859-1?Q?SNV38QuG83c2Tede/bzz80qOFGTv/gjQRjd1d3OL8H+Ubc23uZX8dacN+o?=
 =?iso-8859-1?Q?m1o36lanMOnWEG1M4+KHuSLS/nH1ysmCwW/cs2u+uLm1W2MOs8NFVvXUbt?=
 =?iso-8859-1?Q?nKUrpgeVagim4I/MXp2VI3gDPTLsdHAz7NZi3192xUCeRDkqLGlc+1eA3+?=
 =?iso-8859-1?Q?h7QxtYsD4sFuppje+JoqFt74GCz8cak2NYRQo9j5b7BosSAJmjyYiFtRjs?=
 =?iso-8859-1?Q?aUo1JXOmyBc/ymCJsjqgIoqEGbTRAJ0MBdMVFrysxsO+gF5FM5wWhM3KmG?=
 =?iso-8859-1?Q?L4h9LZpz4e/H6HaF5gkQfw4KSKmzWuU+o2MDYmo2w+AViQr6w1mTURgXhX?=
 =?iso-8859-1?Q?99hytKQZKn7nrWJf5U2HfFXsS00JkLM2KavduzpKFnp5ccxig1C/Ldy5av?=
 =?iso-8859-1?Q?8QcVjyqViGiG5AGNg0O/llolu6H1+zZyhp6urK3WxKeO4zE0vysBiREAuc?=
 =?iso-8859-1?Q?8TYKTRmao19zuGFEbu/hBUAphaz9ukA+E31/6pIkTi/x1zEuCtre1OHn1e?=
 =?iso-8859-1?Q?6P7N8HO0S2fHUxPGOcuozIbc5bSbeGoephs+UEzaSBjmcq9jxkaLrEYUxs?=
 =?iso-8859-1?Q?/LzgOrKzO0TlnFn5/7+YO3XR/ynQQ/1sIVAoXSIiI4BC4hTDyiXNhm6rnK?=
 =?iso-8859-1?Q?A8oVp9a+GUOvgzBMtnI55gFfdOGVAotXdelKEnLSF4tOggLddEByqW1YGK?=
 =?iso-8859-1?Q?A338ULjtre7Bl7R52bhL3ABHJ0Bq2rUd8TbOsGOGnJdg7bxk02Q7tFTZmj?=
 =?iso-8859-1?Q?U+mc2LaD96pkM6Qk9opKs4vl71VRG7kxpDiBsXWKK8mFNOn/WVykO5Al6c?=
 =?iso-8859-1?Q?Z0N6IbDIR11vTAZt5rFw8G5VLtom5XopYFF/L7fTF2VuQJ0uys+MPExx0g?=
 =?iso-8859-1?Q?Qs05oPs5VRM/LcYRAnWHtf0tv4yHnVbj7pjbMc8xT7r8xDvS17NWEKgvC0?=
 =?iso-8859-1?Q?DGtjXvKFSXfbMMA9Y+8ZORx5Pf6ZogYyrwGWyRkicbDgXkZar8Qq1oDUKf?=
 =?iso-8859-1?Q?4Nn8Iwkihh3upYNsC2VOgbbnyfFiEkDHW0mXr6FYDS5Di8JmMvlOt0yJVk?=
 =?iso-8859-1?Q?n00E7uxVEZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351258b-04f5-487d-b59e-08d9353e83e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 05:28:06.5090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrDaFgEiB/xEvYKDGkU2+30VZWxsOBxfTbFRDlaxt317iWFlBTlXhzedWIGI6lZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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
Content-Type: multipart/mixed; boundary="===============1767767070=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1767767070==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473C117661C9441AF94AB91A2099CO6PR12MB5473namp_"

--_000_CO6PR12MB5473C117661C9441AF94AB91A2099CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Please optimize the following code together in new generic function.

if (pp_funcs && pp_funcs->get_power_limit){}
please check above codes before calling pm_runtime_xxx interfaces to avoid =
empty operation in pm_runtime cycle.

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Darren P=
owell <darren.powell@amd.com>
Sent: Tuesday, June 22, 2021 12:17 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap c=
alls

created generic function and call with enum from
 * amdgpu_hwmon_show_power_cap_max
 * amdgpu_hwmon_show_power_cap
 * amdgpu_hwmon_show_power_cap_default

=3D=3D=3D Test =3D=3D=3D
AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " =
" -f 10`
HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}

cp pp_show_power_cap.txt{,.old}
lspci -nn | grep "VGA\|Display" > pp_show_power_cap.test.log
FILES=3D"
power1_cap
power1_cap_max
power1_cap_default "

for f in $FILES
do
  echo  $f =3D `cat $HWMON_DIR/$f` >> pp_show_power_cap.test.log
done

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 86 +++++-------------------------
 1 file changed, 14 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b2335a1d3f98..99c21d1a2c4e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2901,14 +2901,14 @@ static ssize_t amdgpu_hwmon_show_power_cap_min(stru=
ct device *dev,
         return sprintf(buf, "%i\n", 0);
 }

-static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
-                                        struct device_attribute *attr,
-                                        char *buf)
+static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
+                                  struct device_attribute *attr,
+                                  char *buf,
+                                  enum pp_power_limit_level pp_limit_level=
)
 {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         enum pp_power_type power_type =3D to_sensor_dev_attr(attr)->index;
-       enum pp_power_limit_level pp_limit_level =3D PP_PWR_LIMIT_MAX;
         uint32_t limit;
         ssize_t size;
         int r;
@@ -2941,85 +2941,27 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(stru=
ct device *dev,
         return size;
 }

-static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
+static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)
 {
-       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
-       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       enum pp_power_type power_type =3D to_sensor_dev_attr(attr)->index;
-       enum pp_power_limit_level pp_limit_level =3D PP_PWR_LIMIT_CURRENT;
-       uint32_t limit;
-       ssize_t size;
-       int r;
-
-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
-       if (r < 0) {
-               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-               return r;
-       }
-
-       if (pp_funcs && pp_funcs->get_power_limit)
-               r =3D pp_funcs->get_power_limit(adev->powerplay.pp_handle, =
&limit,
-                                             pp_limit_level, power_type);
-       else
-               r =3D -ENODATA;
-
-       if (!r)
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-       else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
-
-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+       return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_L=
IMIT_MAX);
+}

-       return size;
+static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
+                                        struct device_attribute *attr,
+                                        char *buf)
+{
+       return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_L=
IMIT_CURRENT);
 }

 static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)
 {
-       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
-       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       enum pp_power_type power_type =3D to_sensor_dev_attr(attr)->index;
-       enum pp_power_limit_level pp_limit_level =3D PP_PWR_LIMIT_DEFAULT;
-       uint32_t limit;
-       ssize_t size;
-       int r;
-
-       if (amdgpu_in_reset(adev))
-               return -EPERM;
-       if (adev->in_suspend && !adev->in_runpm)
-               return -EPERM;
-
-       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
-       if (r < 0) {
-               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-               return r;
-       }
-
-       if (pp_funcs && pp_funcs->get_power_limit)
-               r =3D pp_funcs->get_power_limit(adev->powerplay.pp_handle, =
&limit,
-                                             pp_limit_level, power_type);
-       else
-               r =3D -ENODATA;
-
-       if (!r)
-               size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-       else
-               size =3D snprintf(buf, PAGE_SIZE, "\n");
-
-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
-       return size;
+       return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_L=
IMIT_DEFAULT);
 }
+
 static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)

base-commit: 1971ad5abcd8575efd12d2e6639fd8f58210a8d8
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C502816aea3734f79bf5208d93534af53%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637599322688052639%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DFn=
BkxT957mNoTpd3jnEHBYQZV3ImGOfmy3K0ToGKNII%3D&amp;reserved=3D0

--_000_CO6PR12MB5473C117661C9441AF94AB91A2099CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Please optimize the
 following code together in new generic function.</span><br>
</div>
<div><span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49, =
48); font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west european)&=
quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, roboto, &qu=
ot;helvetica neue&quot;, sans-serif; font-size: 12pt;"><br>
</span></div>
<div><span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49, =
48); font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west european)&=
quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, roboto, &qu=
ot;helvetica neue&quot;, sans-serif; font-size: 12pt;">if (pp_funcs &amp;&a=
mp; pp_funcs-&gt;get_power_limit){}</span><br>
</div>
<div><span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49, =
48); font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west european)&=
quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, roboto, &qu=
ot;helvetica neue&quot;, sans-serif; font-size: 12pt;">please check above
 codes before calling pm_runtime_xxx interfaces to avoid empty operation in=
 pm_runtime cycle.</span></div>
<div><br>
</div>
<div>Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin:0px;font-size:14px;font-family:&quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif"><br=
>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin: 0px; font-size: 12pt; font-family: &quot;segoe ui&qu=
ot;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple=
-system, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif=
; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Best Regards=
,</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin: 0px; font-size: 12pt; font-family: &quot;segoe ui&qu=
ot;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple=
-system, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif=
; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Kevin</span>=
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Darren Powell &lt;darren.powe=
ll@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 22, 2021 12:17 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] amdgpu/pm: remove code duplication in show_powe=
r_cap calls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">created generic function and call with enum from<b=
r>
&nbsp;* amdgpu_hwmon_show_power_cap_max<br>
&nbsp;* amdgpu_hwmon_show_power_cap<br>
&nbsp;* amdgpu_hwmon_show_power_cap_default<br>
<br>
=3D=3D=3D Test =3D=3D=3D<br>
AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d &quot=
; &quot; -f 1`<br>
AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d &q=
uot; &quot; -f 10`<br>
HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}<br>
<br>
cp pp_show_power_cap.txt{,.old}<br>
lspci -nn | grep &quot;VGA\|Display&quot; &gt; pp_show_power_cap.test.log<b=
r>
FILES=3D&quot;<br>
power1_cap<br>
power1_cap_max<br>
power1_cap_default &quot;<br>
<br>
for f in $FILES<br>
do<br>
&nbsp; echo&nbsp; $f =3D `cat $HWMON_DIR/$f` &gt;&gt; pp_show_power_cap.tes=
t.log<br>
done<br>
<br>
Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 86 +++++------------------------=
-<br>
&nbsp;1 file changed, 14 insertions(+), 72 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b2335a1d3f98..99c21d1a2c4e 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2901,14 +2901,14 @@ static ssize_t amdgpu_hwmon_show_power_cap_min(stru=
ct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;=
%i\n&quot;, 0);<br>
&nbsp;}<br>
&nbsp;<br>
-static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; char *buf)<br>
+static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *=
attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_limit_level=
 pp_limit_level)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_type power_t=
ype =3D to_sensor_dev_attr(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_limit_level pp_limit_le=
vel =3D PP_PWR_LIMIT_MAX;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
@@ -2941,85 +2941,27 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(stru=
ct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&nbsp;}<br>
&nbsp;<br>
-static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,<br>
+static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev_ge=
t_drvdata(dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_type power_type =3D to_=
sensor_dev_attr(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_limit_level pp_limit_le=
vel =3D PP_PWR_LIMIT_CURRENT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EPERM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&amp; !a=
dev-&gt;in_runpm)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EPERM;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev_to_drm=
(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs &amp;&amp; pp_funcs-&gt;=
get_power_limit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_handle,=
 &amp;limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_limit_level, power_type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -ENODATA;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm=
(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev_to_dr=
m(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_hwmon_show_power_cap_ge=
neric(dev, attr, buf, PP_PWR_LIMIT_MAX);<br>
+}<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
+static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct device_attribute *attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; char *buf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_hwmon_show_power_cap_ge=
neric(dev, attr, buf, PP_PWR_LIMIT_CURRENT);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev_ge=
t_drvdata(dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_funcs =
=3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_type power_type =3D to_=
sensor_dev_attr(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_limit_level pp_limit_le=
vel =3D PP_PWR_LIMIT_DEFAULT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EPERM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&amp; !a=
dev-&gt;in_runpm)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EPERM;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev_to_drm=
(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs &amp;&amp; pp_funcs-&gt;=
get_power_limit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_handle,=
 &amp;limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_limit_level, power_type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -ENODATA;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, limit * 1000=
000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm=
(adev)-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev_to_dr=
m(adev)-&gt;dev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_hwmon_show_power_cap_ge=
neric(dev, attr, buf, PP_PWR_LIMIT_DEFAULT);<br>
&nbsp;}<br>
+<br>
&nbsp;static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
<br>
base-commit: 1971ad5abcd8575efd12d2e6639fd8f58210a8d8<br>
-- <br>
2.31.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C502816aea3734f79bf5208d93534af53%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637599322688052639%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DFnBkxT957mNoTpd3jnEHBYQZV3ImGOfmy3K0ToGKNII%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C502816aea3734f79bf5208d93534af53%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637599322688052639%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DFnBkxT957mNoTpd3jnEHBYQZV3ImGOfmy3K0ToGKNII%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473C117661C9441AF94AB91A2099CO6PR12MB5473namp_--

--===============1767767070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1767767070==--
