Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296FBC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 06:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EF36120D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 06:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EF36120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D2B6E18F;
	Wed, 23 Jun 2021 06:46:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4906E18F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 06:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcjXtwxsxvziV8iKKHKdXtJ42aiFZyaZljZO/+9NqRr3N2zyoyXA2OVbEdU70gwJM4o12pZPiSMAuFuw/RDRdURv4BgzEEEkW2koJNE2SUfFAPSfIznf2FoUdzFH4GmJIHO3vLCxQH51IB0a2WfV3uEkjcd9gGlTPXlz9oHq8d1oT6lhuijShXW7sXdT5eJEo7geJ6gS55xx10mnz1pryMfy00NKaHFG++ccKRFu/fmJWH4hLE6jWIrKrBGbNItT6fubssxfOsxOnSNSoVTOyIyT9Cp3hxs9yfwMDIDwwyXIOuWA8liDcGxbnPupGrs/zXvatwMspBsF9+2dFwYJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V/tHZDgoXRH9TN0WekA3dS4QAN9m3iiN1Ao8tlglnU=;
 b=OZlD6z9j4PE2kNrTNQAuVHWB8ELFmS9JsQRo4id/bcsNQUUAsuxVn8Nunil70rz0vO4bEESv2nHb96MHNfH4XM+hSsLHurC9dAvheLTsCVbh+w8N+IlswbIMxpaaJBShVWZwggUB3ojboR4vwdmLTGISyvIx3wtOY9EZXZcdqoURC42PumsIvllsFLk1c8BZZnA2r0t2B9btHol6LUnQKoscI1PBy1d8ticxlAq6M7ZXZCTjSUOBm97oJVNronRNyDnBBI6CorfzjPCiKK/CZRnTRZ8HW31V650AzmgJp9T0MAaTf+Z8hLsAmzT+UW4K62JpLDCPJS4TdEJJtTwIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V/tHZDgoXRH9TN0WekA3dS4QAN9m3iiN1Ao8tlglnU=;
 b=sQab0ccftWtmPzD7Pgj1LyQ0EISgYb6S9PDe8HxfStT9cobhnZIFgfEr3Go/KJYaAl/9+DSw1Glx02Nnsb0UCrflTePIUrzcpAfQ1J8Hn/cZn2KrxIYzg00wKiCKAMK8VCA8ZsDrWI5OeR8TAPhWL4HJkg1bR48k15vKO80+9uQ=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 06:46:54 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 06:46:54 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap
 calls
Thread-Topic: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap
 calls
Thread-Index: AQHXZ9izt/E3vdL1Sk6AdKJeYK1eRashJz3H
Date: Wed, 23 Jun 2021 06:46:54 +0000
Message-ID: <CO6PR12MB5473E7F39EF710914885BE46A2089@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210623023428.2124-1-darren.powell@amd.com>
In-Reply-To: <20210623023428.2124-1-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-23T06:46:54.156Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f2a41c8-65e3-478c-5e3a-08d93612b071
x-ms-traffictypediagnostic: CO6PR12MB5427:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54271EDD7AF8EBAC2757F4D4A2089@CO6PR12MB5427.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:31;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFa0Cs0WkcvN/++VUd9h667DwE9HP3I5/EUD9FB5Ul1ME3VcD0ajdEbTBsP7C6tjjJEbmT4jq/GEIIAya1y2UCbtW/egX2HsEWIBqi5AUaM8v3IHBMQKbpd3QkFwvj0qUgYkJoV7eUNCEnBsqQGRWADphat0RGlGAPAMLEwH4HqX5AwcpUMJycn3f1xy8i71+WluO9iSQkywSZzqzts876I0/UGP+svkSDqdXTqMdPtGCLh81iW14SKsxbzcjl4r2Pwjx2cTeqoc8WgR25I/299Tmidexb8cuEre/SxxRxZpsiZW6bwgTFg2CUf9jBE4JU3tML/jsFLiv4Jg0mEBRMyZwgpkXcVsfIPpxu/9xUdD3j4ipQyeIVo14RCYhAdO9AD2u4mZc/oemhj/9ypVwCoOI9Aou/Uexdy5bxMWy9qwUQR/B8iZz5M5cP3v5ByBEJ4oI9/5ebKAEt0dhb+UMz4EXeskEMqXmr2G46uO6k9Rc0+o/i0Nul5erdxCK9YU9HP0M5/l+AfPEL3sJk38OaGugHBjE90LUb6AZV7PMKITf14W1Woar2H8pK2Y4BTRYNY5J469sZKJglApgn0ex8qbA/rfsnPnn2+d4y2bHNw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(26005)(9686003)(52536014)(33656002)(5660300002)(83380400001)(8936002)(8676002)(2906002)(186003)(6506007)(53546011)(55016002)(7696005)(19627405001)(478600001)(110136005)(86362001)(71200400001)(38100700002)(76116006)(91956017)(316002)(122000001)(66946007)(66446008)(66476007)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pqF2bsWnJuERHO4SkV3eEOB41zHco1l1Rrms4ZSLjEIPNoV+DnQQxkomHY?=
 =?iso-8859-1?Q?bwCrBx7rNp0yL+vbTZcph8wmw4eqSkkT+94WTeY8ZrSKXJl6Z3LLQt7S76?=
 =?iso-8859-1?Q?Xpg2Q3VdMFjvHhdYEaaE7t3Um0Qxygf76oUTs/hKljoEzl+exVBqtKm+dW?=
 =?iso-8859-1?Q?9frVpJyxjAR1P9HIrL6fPf61zpRKxiZYzF1JDRbhlHL4T3lrmwRgWMSsaG?=
 =?iso-8859-1?Q?WyXNfsjV4lMVJdt8gHtNX0bttD2Es/rJeXEu8VqnzJDNvZkdfunSKkgEWS?=
 =?iso-8859-1?Q?ME9CSoMRwetQvemwm0brC91s/Kc+jjMQvML1lhyIZ0DgehYPdMCYzHDEyK?=
 =?iso-8859-1?Q?VdoMj7U3EHQpnrX4QIZth1T8e/BEc8GNnZQzV7zW1XZIIWUPH2kwRbacLG?=
 =?iso-8859-1?Q?y6bS/7oqh8kNMYQetmHtJKlMOxoqRaB1b1rFDDHGvq/dMWQSLqYjepmPlu?=
 =?iso-8859-1?Q?36OqQ/X440fvn8krcWu7qLbBXTiHUXZaw3/XH7klRXUOQ/uyXH82RPr4iz?=
 =?iso-8859-1?Q?QMwDTISzqd3NDC7Hm1hdQynHIaRsTm1D7dkHn9A6ERPl0kpFp3B2N0LEIT?=
 =?iso-8859-1?Q?TCJpEZQy3aiRXwmcUlRjTgUONg1llSypBDxqXWU0Fa9aUgRXGKMzyeZuwY?=
 =?iso-8859-1?Q?cgEqfu2e69oNUF9FCeS4zE3+bCyN/mJIs5jNPvtoE5hbdbdFS/x0iFkN3w?=
 =?iso-8859-1?Q?lYUi0S2rm6ryitDaja49xG0z4Np0kihtDHKJNrzA3j3vh87dmC8MfBEDRl?=
 =?iso-8859-1?Q?qw30gBr2jJRHlllxFGSBGSvymvDLQrHKFwpyz7rp6jWyro3raw924tnlRV?=
 =?iso-8859-1?Q?JKRerqJ8dWezJzh0ktYu6PV/zm3yiaGZcvqbW83JSYbvn/0j9ssZCkYbq+?=
 =?iso-8859-1?Q?FlBDz+7z9X4PxhY7SJ8oECh/PhV6GCsjx8CPZ7WSFr3pmwxN0Oa489E6Yc?=
 =?iso-8859-1?Q?MqXr4ypxFEXP4En3oLKrUZX//T1NcCD/mlnwhiMUb79S/Dfr7QisnE6AaT?=
 =?iso-8859-1?Q?r5iRCCEc1CzgdoB//ekN4eqM9Q7f89q3KNoJcJALJZxsd4qJdxEFtUyux6?=
 =?iso-8859-1?Q?gnjQWljtOj5r5yplwlCUtZm3m4R0BMqkU9mpMEYH4qrouluhLFuVygL3G1?=
 =?iso-8859-1?Q?lYVWaIAC5nmfsHVREYVpxSglMbg14h6hOQJ+L25oaUoGIZBiNYo3L6W5mP?=
 =?iso-8859-1?Q?08WMUgK76fQbNwnwG7jGVWUMVlgG/A7pNJmFrdzz7sL7hiWQV+0hlsYX/l?=
 =?iso-8859-1?Q?uIja/nDjnE0Rr3KWAyV2IEsm0LPf6dGjn2sZ9guamift1L3tiEh9R+pzyE?=
 =?iso-8859-1?Q?N8Stqd8T3NY1bCqcvQVzdOe+uRaMDar0hVeoSim8gVvKaNx7Qnh0AVSmW7?=
 =?iso-8859-1?Q?hKXoTfu3/a?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2a41c8-65e3-478c-5e3a-08d93612b071
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 06:46:54.6390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZe/q3d/MsfHN61vgObCztObnm77+Mxf33NIhe3ifsJFQv55t+MkE7KsA74d4Bbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Content-Type: multipart/mixed; boundary="===============2011018453=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2011018453==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473E7F39EF710914885BE46A2089CO6PR12MB5473namp_"

--_000_CO6PR12MB5473E7F39EF710914885BE46A2089CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: Powell, Darren <Darren.Powell@amd.com>
Sent: Wednesday, June 23, 2021 10:34 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap c=
alls

v2: reorder to check pointers before calling pm_runtime_* functions

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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 96 ++++++------------------------
 1 file changed, 19 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b2335a1d3f98..fa63160e6405 100644
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
@@ -2918,17 +2918,17 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(stru=
ct device *dev,
         if (adev->in_suspend && !adev->in_runpm)
                 return -EPERM;

+       if ( !(pp_funcs && pp_funcs->get_power_limit))
+               return -ENODATA;
+
         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
         if (r < 0) {
                 pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
                 return r;
         }

-       if (pp_funcs && pp_funcs->get_power_limit)
-               r =3D pp_funcs->get_power_limit(adev->powerplay.pp_handle, =
&limit,
-                                             pp_limit_level, power_type);
-       else
-               r =3D -ENODATA;
+       r =3D pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+                                     pp_limit_level, power_type);

         if (!r)
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
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


--_000_CO6PR12MB5473E7F39EF710914885BE46A2089CO6PR12MB5473namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Powell, Darren &lt;Da=
rren.Powell@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 23, 2021 10:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] amdgpu/pm: remove code duplication in show_powe=
r_cap calls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">v2: reorder to check pointers before calling pm_ru=
ntime_* functions<br>
<br>
&nbsp;created generic function and call with enum from<br>
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
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 96 ++++++-----------------------=
-<br>
&nbsp;1 file changed, 19 insertions(+), 77 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b2335a1d3f98..fa63160e6405 100644<br>
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
@@ -2918,17 +2918,17 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(stru=
ct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &a=
mp;&amp; !adev-&gt;in_runpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( !(pp_funcs &amp;&amp; pp_funcs-&=
gt;get_power_limit))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENODATA;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(=
adev_to_drm(adev)-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
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
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pp_funcs-&gt;get_power_limit(ad=
ev-&gt;powerplay.pp_handle, &amp;limit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_limi=
t_level, power_type);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
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
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473E7F39EF710914885BE46A2089CO6PR12MB5473namp_--

--===============2011018453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2011018453==--
