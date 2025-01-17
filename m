Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49830C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 01:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0ACA10E110;
	Fri, 17 Jan 2025 01:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H+Y5DlQc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DAA10E110
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 01:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkutqR+WXZHDQItuVHBxTXYftJFE/zg6oM9BkQsQT9aovdlqxO4UYoi1CiA1iXuGjwqUIEjpLA6v4OoSJG0VGIGDuc8X8ppu1wxnexQBlt9A5idlV4WeH3UxitdiRXBNOTzptBS9jFD0tZVEKD7kuihjPE17zwfSxVsb1+EDZ+OLbgQ+IPop98so+FcVZU+2kv+EnoJeKmtwsvNBpQ3TcCCvRzI+oh6TWVusmkWanGXydRZK6VER+V+kvZMrl5rXhtmUkF+PQIEgHC075/DNxW2u7wED5O3BFZujkyfTjXBx8AAx728HgrayuI9SUKvy/o2DaQvH9euNPt3nwIaVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd25AcCiUNt3JpY83tCqzkVzfrnfQvLfxcYJY+MlU3M=;
 b=dh+m1xSpFeJ2XYSa18Xvcjo1YvRCZMa7N9LfCId91wdlKI9Vlp1t5J1c9mymFuK/tNtCszWSInJ4ggcYVcmc+88U2cboaduhRbtJbOBVnGoAVa1UkYTALIvPLylmpQHiCXUp2DA7Lq6boefY0GYwol6ii4DE47+ZBEJK2P8Ma05nulTFeZXrOe+8HG/+c6t3Tx0HVMiLhPp8XPgI9dlfRNlxdGiEto3tB4kGEogHj6xMhiJnwdCdwXk4YUz4+3bdcpVVcQqvHC9UdgFduPLcuCNhurlNQOHwsUMrZVWSJXbAY6hkzL6+jvDmPaEJEpElMcVqDH6+xRGeFDVYxpJfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd25AcCiUNt3JpY83tCqzkVzfrnfQvLfxcYJY+MlU3M=;
 b=H+Y5DlQcVewmxvTn7NTYmcN/PMLBFEqv6HcYdIawzd2h3UwFr8OHWEswDFTZP6caSqwE722X3QRxax4PZicTcFEWE4KeyMyUPa18XdOWvTM2x+bE2pfdktqIECe8j/cM1kLeW+ZwzKON/RQLGy4SrOcEWA6EnGl9PK6Hrq7pxsk=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.14; Fri, 17 Jan 2025 01:13:23 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%2]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:13:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Jiang Liu <gerry@linux.alibaba.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>,
 "shuox.liu@linux.alibaba.com" <shuox.liu@linux.alibaba.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC v2 01/15] drm/amdgpu: add helper functions to track status
 for ras manager
Thread-Topic: [RFC v2 01/15] drm/amdgpu: add helper functions to track status
 for ras manager
Thread-Index: AQHbZVxsV7OmgTPGFE61zBbSF8en5bMaLk9w
Date: Fri, 17 Jan 2025 01:13:22 +0000
Message-ID: <DM4PR12MB60127369D0875E309FEFCC69821B2@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <789f547f5101fe763a9244d1bda560dd562cb604.1736732062.git.gerry@linux.alibaba.com>
In-Reply-To: <789f547f5101fe763a9244d1bda560dd562cb604.1736732062.git.gerry@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b6de77ec-834f-4d4a-a114-c48bf4afdfc6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-17T01:09:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|SN7PR12MB6886:EE_
x-ms-office365-filtering-correlation-id: 0a815add-f912-46fe-d9fc-08dd369422f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xxjdrfNQciIyX50NykG2pyv0Wuwv27kJXwUFPgM6O4r7lHw0ZlTMDxoX6Bbr?=
 =?us-ascii?Q?DaMStveARc3FH3rQK4GDDzqIYTFJb73dHVtdjpxD0gdFWbBgQ4zBBmoG97Rl?=
 =?us-ascii?Q?gQ+gQeNyyVj0oU4J9DWhJGb3UNVkaFg9fNuQCCqYNCloJ9HoDfzhf+qzdxMB?=
 =?us-ascii?Q?cv8m7f8eum9H+cbENDquivwqpd9bxBJHU3zaLF1Je4xHWBZpxMK0gVT5KY/A?=
 =?us-ascii?Q?XriR+xDzF/xW+jtDaLMABokgHzUGKpuOKeL+RPARFMBuC7zFr2laMeejZe+f?=
 =?us-ascii?Q?9KFtkynCsa9++kSvWuTHY2lpQoFmogu2PPnzm0yUIX9QkFKFTYPtMKRJFRnu?=
 =?us-ascii?Q?I7ay1ZnyxOXYd6UCyYINg7DChqS5SqXvX2WSY5z/Hsgw66PWXaH3akgg7ctp?=
 =?us-ascii?Q?bKFetA0Cw5uuuMRHdZKu3quD++WO7gtaSl4aIiQAGt4RoYgmi752H1QeDz/l?=
 =?us-ascii?Q?JUhdcQBQhQ6Ht2Yj996QC03gsMMhQe/UudSRkahoQIKf2C9lSy8p89SFKhq9?=
 =?us-ascii?Q?DuZCgPZKmcpe50O+lsW5dHt3nwN6adIqDZgHZb1CIcp25ouKh5ZeSsn366YA?=
 =?us-ascii?Q?4li1Ksyyx7wy79Mq6hgdA2P54cd8OWU1/9ugqopaWo9nJ5XyqdWOYc8oYvn4?=
 =?us-ascii?Q?sG6mF5WY51uwkKr42p/UqZr+VfwSPq3PiENJ2B4B5D9nB65O/HUeqFul7HQP?=
 =?us-ascii?Q?nv5FIxIdB6yku3WNNhMcUqDy2MMXV9hOIMPsJgJdfNMm0ctF/k6tZz+CM+6g?=
 =?us-ascii?Q?a/3F5dMvRBp9PYidn94kdGL3yRyi6xeNS1aibilEhS6Pn6dq+sXkDzlqtr/8?=
 =?us-ascii?Q?T2wblRfLxAtrZtDCUjSiCSV2BjIXhqoHoNjTNGMxk/Jbcs1vQVnDtluAAPE8?=
 =?us-ascii?Q?d9JwSBsKqC/7nGRvDpJtm2RR+ZovMG6dlQPb9QG5vpr0XItA07EnjM7g0Sxb?=
 =?us-ascii?Q?ax3W8WdUiJ0zEupGkGwNIK1f+Uix02c6BRVzgO0SMmrLQS/geBjwEDEPWJ8+?=
 =?us-ascii?Q?U68WgFnIzJnYwGKC/oS3PW9p4NZL88K4Vo5XOQUG/4d8Kn66NJXb1pY+SRgR?=
 =?us-ascii?Q?W1B9KyLO06E0m9Wb7SYbL3H+MuQiFVjk4Q3O/PF6E3199arzE70C4Kn/osR1?=
 =?us-ascii?Q?VuEwbSSt4kf/4sk9obeomKTQy+N95SiRTRX2LSHZlcP8R59jiW/nI6ZJbEF7?=
 =?us-ascii?Q?SiUNWtZeb6cRuSPSUrIB6OzJjsSChp7Ys+BUmeVg/cCkxBNockhnG9vUH/O9?=
 =?us-ascii?Q?QAA2hUYxl51qS0d8/nSQbdNFM9nzSKnPoSJFgES/A/pmKA8PnTdr1AGDgCAz?=
 =?us-ascii?Q?u6vo1xqWVfCif7aMVX+8ukYaMCoA0Z7YwR364GW22zF+LnDff8SsU7tg0+ft?=
 =?us-ascii?Q?rqH7iszzRoxtb69yyzMs2oSUJIaNpqAOKECivNMQz7PlbeSekWsloXdiZ5q5?=
 =?us-ascii?Q?atej+2W4QiNiLl94uZP0zCuGkmNSOgY/cGx58MWw5ZAe3FDK/arCzA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDIPsicAfHmp1Pw879mREK0IGAzfHfKnSBBoj1eSFo6jDsg7lcr2PRx6x7hU?=
 =?us-ascii?Q?b7PbLeMNxaYdg7fRhtMeHcoQ27+yCYNYUR9QSEUrWRTvSOidkOvrVffWN7lZ?=
 =?us-ascii?Q?e2+4V4DjgrzZD0O0srvXr3lBnVhMbKNUXJJ0B4f6qXAyUvT5eTcydKSNY2ve?=
 =?us-ascii?Q?AVKHHsYwFhBk1TUnQWguDvJIZkgfaCpBnij0otsxHvQDJKJqvcglzY0Qha87?=
 =?us-ascii?Q?VpOKuAKbKn2tGRR0jOamlPz/AZLw6Ion2Tc6+/n3POPZ1O4mcMI2KwAigBJF?=
 =?us-ascii?Q?09vsuQdiuZlpPN+xe/f1OZTpnjtjl+Q2W7j4JhQ6cO5rdKl0+F2kePbtjWk/?=
 =?us-ascii?Q?tr2lj5WRdZgh6TTySfNotJ21PuVPdJ/ol5LX/Trp5csgcUClEjW0KD5yDVEn?=
 =?us-ascii?Q?P/6HlBI/+ww097nGs57mPDZ0UHRZA9D5WadTpnZfQEnDcNFGAJS57h2dwbWz?=
 =?us-ascii?Q?GF6s9OsHWj2gwaak3TvdRMV+E46WzMlNqFKU2fcyxciqjsEPxmOKwmiaDwet?=
 =?us-ascii?Q?JllskKg1NwoxjNl0CgXdVdsRudAeKlnH82HEYhgR1JPI6yrpXQ5hljleUNoE?=
 =?us-ascii?Q?nQyhZ7+UJalVfh8jPq1VwgxGd1NFMMaEOYh2adQASdAwrhyzIjVf/qC3ho1R?=
 =?us-ascii?Q?v02TRUGLIXGzW/gJIXwr3w4em8SeZMD9kdhWz7pK6dSrGVr8r2GA0/g3UzfN?=
 =?us-ascii?Q?3bT+yGGtnrhMdWEDuLws9jF4ScSiF+Vul5/6Kqcw5lE48gY/hAqOHJRFHM5o?=
 =?us-ascii?Q?v0c+c4gPvrUELpCeByogzxs2qJWkZZLcswZ0WJ/unDqRkyGiy7S4SsVEo7zt?=
 =?us-ascii?Q?ZCl9uRiWrEkCpWjtkxhYEdiEl+sJHAt949TNL0Ch/4O6Gslhmoatzz0OfzsT?=
 =?us-ascii?Q?coJdTpXpU/s5HZcvmlFLNnsfj1qATvomJIdgiNHxgtREBaslz2Zb/r+CMcWM?=
 =?us-ascii?Q?3OXkpWqjb+Zm8qqnOIlZxFIniMGyytd5egg0NcE3G3aEGxLS8KQDhlxvPWhl?=
 =?us-ascii?Q?qjr0sXEmxjuHCpYke5i1GP+H57Uo7tHDCtMYMGJSal6J7Pb19B9gyoIUwKaH?=
 =?us-ascii?Q?Z3sIj472/ghjUcChx2mOaGhJIKK+G6T6DUccvD3nI22A92mEYDADMiRm2swn?=
 =?us-ascii?Q?mkf7wMPwrD93m4vugk/TtIhaNGytki3SWMj7oRXqr+61ttcGZiFaUipEVh+K?=
 =?us-ascii?Q?e54MScBHmVrbFHl2KYAUkgDVa3NfB7gMWIe4fa292Cjh4bdFH9PDYaRgIBsd?=
 =?us-ascii?Q?xBWz43VpxjuszEuerJCRPqeWL50eJMcoBNX4gCOmStcrkD89dgKHvTOtTjdD?=
 =?us-ascii?Q?9/CEU7NI9/y1zggWEj2OiqPSRiMkk5nxfizkk1d4HyZ2d1gW4tpUwyk7r855?=
 =?us-ascii?Q?FuMgftz03t0z19cxugTZ7S/lwue33uTrXCVtKUdXOLLJIxC4UtO/TegQZUf0?=
 =?us-ascii?Q?HgbYrO1MvlkVfAaka+nENWx/Y57sovnMTH9lBHycAxdEEetRdRTH6s3qY7r1?=
 =?us-ascii?Q?kWDErIE5+lAd68GuA0l8bwOQ0+K3qG5TPbI0ydXekcaQ/0UiFL6CCD4YXtLC?=
 =?us-ascii?Q?aN6FEJn2ZZH3peena8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a815add-f912-46fe-d9fc-08dd369422f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 01:13:22.5892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzvi0LhKTLyjQqpDCsjxPuvB/9lZnSwT33fkRx+C2hBpfsjeO1kitgCyUZpQcM1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiang Li=
u
Sent: Monday, January 13, 2025 09:42
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com;=
 simona@ffwll.ch; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo <Lijo.L=
azar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario <=
Mario.Limonciello@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Russell=
, Kent <Kent.Russell@amd.com>; shuox.liu@linux.alibaba.com; amd-gfx@lists.f=
reedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 01/15] drm/amdgpu: add helper functions to track status fo=
r ras manager

Add helper functions to track status for ras manager and ip blocks.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++++  dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 5e55a44f9eef..f0f773659faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -377,12 +377,28 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip=
_block);

 #define AMDGPU_MAX_IP_NUM 16

+enum amdgpu_marker {
+       // Markers for IRQs, used for both ip blocks and ras blocks.
+       AMDGPU_MARKER_IRQ0 =3D 32,
+       AMDGPU_MARKER_IRQ1,
+       AMDGPU_MARKER_IRQ2,
+       AMDGPU_MARKER_IRQ3,
+       AMDGPU_MARKER_IRQ4,
+       AMDGPU_MARKER_IRQ5,
+       AMDGPU_MARKER_IRQ6,
+       AMDGPU_MARKER_IRQ7,
+       AMDGPU_MARKER_IRQ_MAX =3D 63,
+};
+
+#define AMDGPU_MARKER_IRQ(idx)         (AMDGPU_MARKER_IRQ0 + (idx))
+
 struct amdgpu_ip_block_status {
        bool valid;
        bool sw;
        bool hw;
        bool late_initialized;
        bool hang;
+       uint64_t markers;
 };

 struct amdgpu_ip_block_version {
@@ -410,6 +426,28 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *ad=
ev,  int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
                               const struct amdgpu_ip_block_version *ip_blo=
ck_version);

+static inline void amdgpu_ip_block_set_marker(struct amdgpu_ip_block *ip_b=
lock,
+                                             enum amdgpu_marker marker)
+{
+       WARN_ON(marker > 63);
+       WARN_ON(ip_block->status.markers & (0x1ull << marker));
+       ip_block->status.markers |=3D 0x1ull << (int)marker; }
+
+static inline bool amdgpu_ip_block_test_and_clear_marker(struct amdgpu_ip_=
block *ip_block,
+                                                        enum amdgpu_marker=
 marker)
+{
+       bool set =3D false;
+       uint64_t value =3D 0x1ull << (int)marker;
+
+       if ((ip_block->status.markers & value) !=3D 0) {
+               ip_block->status.markers &=3D ~value;
+               set =3D true;
+       }
+
+       return set;
+}
+
 /*
  * BIOS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f0924aa3f4e4..5e19d820ab34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5207,3 +5207,40 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)

        return con->is_rma;
 }
+
+bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
+                           struct ras_common_if *head, int marker) {
+       struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, head);
+
+       if (obj && obj->markers & (0x1ull << marker))
+               return true;
+
+       return false;
+}
+
+void amdgpu_ras_set_marker(struct amdgpu_device *adev,
+                          struct ras_common_if *head, int marker) {
+       struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, head);
+
+       WARN_ON(marker > 63);
+       WARN_ON(obj->markers & (0x1ull << marker));
[kevin]:

It's best to check for null pointers before accessing member variables
Best Regards,
Kevin
+       if (obj)
+               obj->markers |=3D 0x1ull << marker;
+}
+
+bool amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
+                                     struct ras_common_if *head, int marke=
r) {
+       bool set =3D false;
+       uint64_t value =3D 0x1ull << marker;
+       struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, head);
+
+       if (obj && (obj->markers & value) !=3D 0) {
+               obj->markers &=3D ~value;
+               set =3D true;
+       }
+
+       return set;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 82db986c36a0..35881087b17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -634,6 +634,8 @@ struct ras_manager {
        struct ras_common_if head;
        /* reference count */
        int use;
+       /* Flags for status tracking */
+       uint64_t markers;
        /* ras block link */
        struct list_head node;
        /* the device */
@@ -977,4 +979,12 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *=
adev, u64 event_id,
                                const char *fmt, ...);

 bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
+
+bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
+                           struct ras_common_if *head, int marker); void
+amdgpu_ras_set_marker(struct amdgpu_device *adev,
+                          struct ras_common_if *head, int marker); bool
+amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
+                                     struct ras_common_if *head,
+                                     int marker);
 #endif
--
2.43.5

