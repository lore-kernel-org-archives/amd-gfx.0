Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA7AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 13:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ADD10F169;
	Mon,  9 May 2022 13:14:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF14A10EE19
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 13:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/QsdUeH37nY0K93OdWITcdPMgqwsBdS2QD1pM/H7+QDsNRDnlUhu6kfLarplvPkV135j+1ArW0mZ1xBDsgrwa0Fc1MTDMri21q4FguUqgr77Gtzc01g2pXBckwV/NZ4SXZToOeVcSmNHf9hTD7iNSU6/LSDjl9/hze0aI09yl+n9O0Foo9b8xy8Tm83DjM/OxPcv55tMJPvvAz1uqWUa0Lxw6FbVsejZLMuCdnRYV7PrNqSjbZjEUetFAys63uNjnJrG8w1D9LHlFjumIZ1/RvWhKMi/DzP5Ig4D07f797scaPLnkY6NiGvD7ngM5hzi7rvj9RUoXIJV9Dj0oYoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkuoeHb3A82X9riVbkmlHSt8m8Y3xoCDsxe7GCV+cFo=;
 b=OSYo3i7CHRRsKwweFWnAd79R8svJrJ5R9gCPl4zdW+LRevuWME3drVy+obS6f7IUt9OR5TzuP/tImuBmUYJXDP5h+XdHmGOXdGS5gF8jYVhW3Oq/swv4QWPeQ8KfXFclGtPNgsLx+wCfVANmBEF6UE8yTfR2/sslWGRRuCkXyub/6ib0jj23qP45zzoKQA0qT9AzfVA5U+mIkVuFUfRKJl1CYjc6tw7z0Mx1ipd9tGd0489a36KhgGVP6QkE5ljb1wEUGB6M50t3ENTpaYX5M9Mav9GENMd5AyT2yvXS7QW9wG2xqVprM/ASXY0Kha1nQ/6xupj0unN89TlqymBjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkuoeHb3A82X9riVbkmlHSt8m8Y3xoCDsxe7GCV+cFo=;
 b=FQyIfqn0uUTp734TbsSG8NTJRlOeWbWOb7sceWP43yBQQlqB7RRz3ndRBZHwuqyHMUgs8ZGiTfs3obj9xjaZ/neA82inwQrWuwXuq9SQzzexJvwtfSXYQig/ri1IkvMM5WFM5KQh7ompxPocdtaij/0Mg9E+WPaSaBpjrAw0X/g=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by CH2PR12MB4822.namprd12.prod.outlook.com (2603:10b6:610:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 13:14:03 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 13:14:02 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/15] DC Patches May 9, 2022
Thread-Topic: [PATCH 00/15] DC Patches May 9, 2022
Thread-Index: AQHYYV/0voj6liTof0WgCUjv6RmSMq0Wil5Q
Date: Mon, 9 May 2022 13:14:02 +0000
Message-ID: <DM6PR12MB352902B7FE179953EBBD474F9CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-09T13:13:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=395b3f16-d9aa-4693-b599-ccfdd25d5980;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-09T13:13:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 050cb432-e514-409a-a46f-8ac136b1bacc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40a207e3-d750-4fa3-54c3-08da31bdc99f
x-ms-traffictypediagnostic: CH2PR12MB4822:EE_
x-microsoft-antispam-prvs: <CH2PR12MB482226B8BB18C1668B50C98A9CC69@CH2PR12MB4822.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IR3JmYdrYTEN4e2ESdBcBGIuRP/jnjo7eyYJkuURaYqjsHSM3GFuDyUa03ttncKRlT9CGtiArk4sm9cTjmejlAXwQoLYQuBjXn4VoM02zfGKWWzc2XPX+a4c9xaujDldq0CsdNg2F98A2MLSgMQcJ0umteAEkU+tVSsYKyO+uauwwQJB8rgGqiVxJEWmI8hax0pWe8b7aZT2KUWupv0OB537MvGG9PpXDEkT9oefXeBOJv7ghVU4QZfheToIV2cx7/ImM4Ma50nvIqK1bzjgRAkrKm0J3vhGfwOU2oY/exzuDYWol0kiCvnkp7/fyKuCx1WhblMLZJBahfCFiuSPf9s7dKttk6SA7YAVLXKcAKBeqs0UcCvrsLqhMMdNx8Onl39CdASu24245YAd4TFvbEDPqx3M5DFGSLXlkTQSJZeOJBAes3gcdZ/9Dam+burPIaNNHT58GExdQIHdIifeJnCjju5llvippzO6hAq6zK7AtofxcYf1kLnp6PsTMWxe9tFZkSp8X8zHgxG/yZHVhUlGoTnzSpAwo6FbQQrqMXw5zSysscoGcZ5hRbWxrVaFHn17hyUGh8q1Ji2ESY1LkjDN1ZYisgHvTZltoowY+wsjMEM+IMyUspkF9vBT3cqP0u7tGD81fTSzFOTOpeSbMDlfujObQhENVg2KshhcIYWnWcuO0qfVRR3kTpDo62zXLuSa9tSt19177ZcFZFiMQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(52536014)(54906003)(76116006)(8936002)(64756008)(66446008)(66476007)(66946007)(66556008)(38100700002)(8676002)(316002)(86362001)(53546011)(122000001)(110136005)(2906002)(9686003)(26005)(6506007)(7696005)(508600001)(71200400001)(38070700005)(33656002)(55016003)(83380400001)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gBwu6uYNXwAt7+X7DKlrprhA/Or4S8UuN8FARadmwRzTxsnV7RkamnJNIVMw?=
 =?us-ascii?Q?v4AOAl+CuQwgl0ci7bV2VWr0POH5uSuA1tReXomiGPiejN9BJYEPDbJBwzBv?=
 =?us-ascii?Q?28rZju6zsOmNmCEsAutRbDh4fMARWSSDO4SAf+bis/6CfdvEe4hsS5Aca6mh?=
 =?us-ascii?Q?4Wq1+lpgLX9/BySIXzojM5JsO6liNf+blrRGqDD8IHFburSjJTmDsCDfv1kM?=
 =?us-ascii?Q?RrkALe+aM1rw+Ru6BDHKmEo8uQmJtvkOcJBRpQ0UP9NbYEq4NnclHKK3CiUr?=
 =?us-ascii?Q?eOqwVj6x7LekNPHWXFv2gOlBNDCTjBYCRYJsCvnT8cIFa09FF2NRrFM45N52?=
 =?us-ascii?Q?IjTH0VV65967ExkXgyhikGCsdJZme68AM3oWinqysu4pnPxO0rS3U5RhS1pd?=
 =?us-ascii?Q?mGpghLxnqP36/yPM8j4xoLqPQjLuGQSyIKmVRiNL5AO9utBHXnD2eUDpeFPJ?=
 =?us-ascii?Q?3pCCEk2LfdApkuOtI7hvmSD3AWuBRX/oY62WMvuIsZQuw1O7G/LZKMrl3NOr?=
 =?us-ascii?Q?WFof65XtnEE9WlX1sKwuS3bElfGRo9hBwbAeqTjBaVvbO3VbQ7ecWgWxk5Oa?=
 =?us-ascii?Q?UN3kcApMTnzbkXCPuVbFyh5Z5CbD9E4wkQ/ATGMT24gdGqcEgwHT/nJsoojy?=
 =?us-ascii?Q?N7ApeSxXTxUzP1Z0biG7fIEr3fKjwTKhJDTq/QuSAO8OC7Rc8t+8KYvJxwSo?=
 =?us-ascii?Q?aTY1t4s2OMfyMoaE4IKFtC3FQk+/k5eu4q0iqrsyTipA003t+2qRVsExMQso?=
 =?us-ascii?Q?8jiVKnPtvh5uq8Z/kIMdgW378HkhiG1ju86MlSkKqqG1UUt/foDSnpImdYFt?=
 =?us-ascii?Q?E9YfgLUzn49/3+yh5Du9P1V00ytzLoWaimMZ8ZRsY/mx2MrzusjHGcilrw3A?=
 =?us-ascii?Q?WMXGvK2iAzZylFkeYOVtfgPPfeRR3xOnh5L8LhvirvwmHqnnTVQ+HcdXnKc6?=
 =?us-ascii?Q?EypYLuz/e2b5TzHkFCM+WG1+UQ6+QrMj/z1g5gCf8JTEh7L6ANkE90qOcd4E?=
 =?us-ascii?Q?V7kzLHUr6BlDsebRDBqe42AyZZQYPhYLaeIPrW2piPfAjI1aK+eVLBMUrtvu?=
 =?us-ascii?Q?vcHqbYti1arX9wwY7dsM4YHaV4ofduue14yjPOs0LO9sXej/ADLZWuH/jd0r?=
 =?us-ascii?Q?qUJlbDC9AEY4BsMp+3g5Kd6PbNKKY2OoadQre/GxEdDBdiGCB+Cf4Pd0zGoY?=
 =?us-ascii?Q?P38VhjnzGsQpetqDFC885FKkfescVXbOT0bgOZN9JIaX/wmZzGTK1mJeLDAu?=
 =?us-ascii?Q?gf2d9Njtoq5ZQ5N7uLzBj369fN3R8h3Wws5GbWdC3nTAqqewGQXZ4f8cljiu?=
 =?us-ascii?Q?WYRDuhgl9iuWfJlyt2JIy1ZNAY4GvpA5xJK5Tlq6ZgYfK8ZUGRydLHjlGKw6?=
 =?us-ascii?Q?Xqnu8lI4pE5gRNPIvMUwBHZwtEFCkOY6/n5IIjVPlBhSLiIoe2Xo7vsNMsfi?=
 =?us-ascii?Q?z2CfbAF9hDt9gqHMFow2KSYRgYGrsTrRWYj9jp5/3itFljoupFBOZqr7y0fD?=
 =?us-ascii?Q?kAo+XkcRpRKLc8FaCUnWlA6ZtpWjvW+Zq4RPmglsxrkeAz2QbR5UkPqqiEuv?=
 =?us-ascii?Q?SlQYNg9Ui0ThrM+tysjZ5XAR83PaEQx/sjTgsE8p5uBNeqelvHSR2gcQlSiO?=
 =?us-ascii?Q?KZG7h1DLhAxLBAAfu9N0Lzp/UNwljLZhm0c699EjZhvYWXeZvUxHNv10v0fY?=
 =?us-ascii?Q?N08477KOVW/qtV5OhSdGbDhkOln/2JDuwVZfqJIkPyGj4ZdT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a207e3-d750-4fa3-54c3-08da31bdc99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 13:14:02.7120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zn+3DhDWcaL6jQiUweR5vIokv5Qw7uNARvWz0TuEwbSxtm1YdtMuTzmxDKAl+MOwrcEg7DHkwdHin4sLSVl5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4822
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz and DSC via =
USB-C to DP DSC Hub with 3x 4k 60hz.
=20
Tested on Ubuntu 22.04 with Kernel Version 5.16, and ChromeOS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com =20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stylon W=
ang
Sent: May 6, 2022 11:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/15] DC Patches May 9, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
    - Refactor LTTPR code
    - Fix PSR after hibernate
    - Fix DC build errors
    - Fix IRQ unregister error when unloading amdgpu
    - Improve DP link training
    - Fix stutter
    - Remove redundant CONFIG_DRM_AMD_DC_DCN guards
    - Fix 2nd connected USB-C display not lighting up

---

Alan Liu (1):
  drm/amd/display: do not disable an invalid irq source in hdp finish

Alex Hung (7):
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in dc
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in dce
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in gpio
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in irq
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN for z10
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in amdgpu_dm
  drm/amd/display: remove unnecessary else by CONFIG_DRM_AMD_DC_DCN

Aric Cyr (1):
  drm/amd/display: 3.2.185

Evgenii Krasnikov (1):
  drm/amd/display: Reset cached PSR parameters after hibernate

Josip Pavic (2):
  drm/amd/display: move definition of dc_flip_addrs struct
  drm/amd/display: do not wait for vblank during pipe programming

Michael Strauss (1):
  drm/amd/display: Refactor LTTPR cap retrieval

Stylon Wang (1):
  Revert "drm/amd/display: Fix DCN3 B0 DP Alt Mapping"

Wenjing Liu (1):
  drm/amd/display: do not calculate DP2.0 SST payload when link is off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  46 +----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 -
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   3 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   4 -
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 -
 .../display/dc/bios/command_table_helper2.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  41 +---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 179 ++++++++++--------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |   2 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  25 +--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  12 --
 drivers/gpu/drm/amd/display/dc/dc.h           |  51 +----
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  15 +-  .../drm/amd/displa=
y/dc/dce/dce_clock_source.h |  12 +-  drivers/gpu/drm/amd/display/dc/dce/dc=
e_dmcu.c |  10 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |  21 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   6 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 -
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |   3 +-
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  |   2 -
 .../display/dc/gpio/dcn30/hw_factory_dcn30.h  |   2 -
 .../dc/gpio/dcn30/hw_translate_dcn30.c        |   2 -
 .../dc/gpio/dcn30/hw_translate_dcn30.h        |   2 -
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 -
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  17 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   3 +-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   3 -
 .../display/dc/irq/dcn30/irq_service_dcn30.h  |   3 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   5 -
 .../amd/display/include/link_service_types.h  |   6 +
 42 files changed, 161 insertions(+), 391 deletions(-)

--
2.35.1
