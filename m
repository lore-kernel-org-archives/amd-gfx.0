Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823A0EE4996
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 03:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECF410E2D3;
	Tue, 22 Aug 2023 03:48:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F3210E2D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 03:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/QK4H3kpGVTffuTj+G4yI08kkGWNUKQfs+aZ842zl3qMWxv65rxzbNXA9U/HKhR+Jq4+gnZ43uxBrzP90fCA9YVoXWwX2J+Geqo1RqOE+IqsdFHHIg3/57HOF87MB+Rzu+jylrQb5m4wWUz+f134uuv5n8guTSPi0HlGy6+02kxfGprRTf5VTNDYI5MRbaPkeh7oGaesiri/x1KNOo6cNaW0QKJaCw9qrra/O3/qVu2pDTlX/hzlKY2PyLW53Pc4Ke6Pq70wkUCZ+QfzWCJXY5FtjMLmo2LMk+x7Z37ldU4AXS2WgYk9p5QW+bnqSNYl5Q/rKSF7cfiEpJzOohjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNnQIfygxNH55oJpRbOXEk6Cu1ej0DaIebkKv13OrME=;
 b=IeWka6zgIKL88rrTNGmv5xqEtUe+6OF2pdZ62Ja46Y6d65z42G4OTg0D9mWPLx7XzA1Zdh7JYcTHvXs8cpzN9KdQqMDiByszTA0VRQo9+xUe7Q/byWi9Z/f6EpwA5NGukeUmglaLSq/0swrlKUQ8wM3JAXfLcKiTd8VAjdYewbyId/AXTD4Y53WAGmSR+0OM+TCC61JtrNHM9soOL0TOpMh8bzNVg9uG9/F6D54+bHln2t+CsXq3QDyCuo329HUFRdwKeLrNMyTDR7By9v3CdlQUXTXdFadcoXvvQa588muQ0hWNUSyl/JD8GMA1uKRW6UvkIzqx1DvCqqCa0ZaENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNnQIfygxNH55oJpRbOXEk6Cu1ej0DaIebkKv13OrME=;
 b=A42lJaHIIJP+ZB3xQEhPSthSqh4ES4K1FS4jI7RkP6BTNCc0JlEEP0ToM8/BJe3+FZs8jNZRyWndsPll39n0pE8dwrykeOrHZ7Dv0ZOpAcL6MzERxxj8JokmtN8XouIbTHuECXBslmRz5JZZDhyoFMnWulyLFBfAlPCE0a1emiY=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 03:48:29 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 03:48:29 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix error flow in sensor fetching
Thread-Topic: [PATCH] drm/amd/pm: fix error flow in sensor fetching
Thread-Index: AQHZ0fCZYQv5HhYMdUKwxhW+Pwf0HK/1q7tg
Date: Tue, 22 Aug 2023 03:48:29 +0000
Message-ID: <MN2PR12MB4128CDEF42D8A44553632F82901FA@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230818162505.1782006-1-alexander.deucher@amd.com>
In-Reply-To: <20230818162505.1782006-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d28320cf-ddbf-43ee-9329-aae63db867b4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-22T03:48:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|PH0PR12MB7862:EE_
x-ms-office365-filtering-correlation-id: 0e79893f-7b07-400b-bde9-08dba2c2a5f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ygDoEWVhIDAhUGYKs+Q68LEcaJIFN5BVuFk7ARQ6wc3r5UrQqaqsbQtG+3D7+1uXMolqhSu4+Je8QeCj0H7TEGdNO3BdezqE1xIogUFLTjxpYntWhs2h8t4k0qPVzg0pqyr2Bd9gB1GP3YDFcA1as1EX5jkHUxcphldXWBedLTl2iV8NFvDHhff8eHKx/aaD/O0VF5Yr09sB3sMPgBHFfpzv8Dn4iHEDWKQxe+M8BV9vEATvCgXPMS4PmGdsdPzaaQrAA2xm8IYd/Wbz/A1QzaPgdJlO/7MdmehfFNomAqzEkhTFH+hyik8yP6GHWa1V2Gw/tsbzlPcFFTTIPq+bjXkeiZYG8JG6gt7HY18kI3uUNAApsj0kO7IgCYU8QasIDag5xeiaGWe5LpVnXAEzvKOEG4OqeMcZMVXkKl7rw5O1KuZRGUnMN2+RXbOXN1IFvp2Zk7hLX8UUFNL+WeYOCL/qsMvEgkKLxkqW+ZmxUy5DdDwvxxzJu6cjnaMp++xl7j/JRNinm0YLcroJ6XK+LlISs1x4FCKF9Tse/LcgtNCLF3EavaVHmGNbFy2QpqGhEJDjaPX08pnP+AzIcHfdpEIppE0uV94qLB5x5sdBJZtMDOMStDtiAL+V0wP8HgM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(66946007)(9686003)(110136005)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(55016003)(71200400001)(38100700002)(38070700005)(53546011)(55236004)(6506007)(83380400001)(2906002)(86362001)(7696005)(5660300002)(33656002)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YZbaOd9Vc4aF+JJ8mQY6rCUMtIF2pLuoBzgW2pkVz0uCpPtQ2I9+zVQuIe6s?=
 =?us-ascii?Q?lQTiijQOQV8O4LDHqx+xxyB2iBG1Zz3Hv3zg+9iLy1Eb6xRZbEqsffWyzUJ6?=
 =?us-ascii?Q?KRZpXADEf8z7mrSOUn9bHjwjw5pnwMyjRcvyCsE5UepMcg6bbtu6x+4tU9pE?=
 =?us-ascii?Q?vtUA0AEFSm3n0qZ8fN+dU/2UchOJ3Ps3mF2rlxqeP6xMH7X+BO1SVB/zqKdb?=
 =?us-ascii?Q?8SZcCCNYnp0mSISj+yCWlo0ILQutZFYKWdjAp63EmYEk3DgNvy5xqolAieky?=
 =?us-ascii?Q?GJ1+sMK34uQSQ/7+52YutGmkVV07AmqyRu1OEG08JxQm+EsaiHeVViHmBe0Q?=
 =?us-ascii?Q?ixJiPAtgjHB0wHCUqt4G0w1da/XVqVY+K0srT2QF0w7vGd9PEu4RtKPrkKbO?=
 =?us-ascii?Q?GNSNp9aPMMh7lrUsF/1Aw8prkST+BsReypSqkGDj+W5mlM48C0BnnFdrgTJz?=
 =?us-ascii?Q?qhve5pFOewrG+mme1kDfHpazQIuvKaY5J4u55aHMGWFgbmeWnG64FV4baM6j?=
 =?us-ascii?Q?ZYKkcFJflhmoeCvYXVgdwZcGiRawdvfK2oiQDjC39T/PlccCuGBDy7Cck7FN?=
 =?us-ascii?Q?XyBO3s/dVTKI2IDeY4rCzp4wKhYHy6Pl+YdYa43S055QvpvaV4dI0WNGS6f1?=
 =?us-ascii?Q?AbpwzJ6zZWSFLKcVthUA3rRiN6pbGC/NeP9UDmHlLKWZx8z2IbaeyMuEkqEX?=
 =?us-ascii?Q?mD4grWuDlIwdvie5UF6zV2F7W+lHDZyQBrf/dq6zi+GI6VPHhZO3Xe7x+Lk6?=
 =?us-ascii?Q?/fq40yDqIfIcRCso+90pkIcJkhDxuV65eUEp/GKH8zC/x3WYLyA9/INWiySS?=
 =?us-ascii?Q?+DxFnGZfRZLxY3F4lPJxBT6yIAwHUtVtJ4fxzMSbmn+WMvLwA/dj1RxVQ7py?=
 =?us-ascii?Q?Ddloexwmn0BrnzsZtfDdGGJhqWA0AfvTxCWu6fe6URiPPmDlZyhYT1vEl6Io?=
 =?us-ascii?Q?QGlDamStnzZIvkZVPjpUiM2HavIolcWD9AHctn9h4S6wDnmeN/4uPJuP/oRO?=
 =?us-ascii?Q?GN3goJqGU2FgzYgGS/QNteWCtD1o0usTVwBVIFb8x/h4c81vv2otszSuDlhw?=
 =?us-ascii?Q?LPjq7ZjfshDr/WzAytqiTxaXJ0B8MfGOECWyufNtlS/vYRPuiOVeqZI0ck2C?=
 =?us-ascii?Q?6S0L5UrbWt1UXdIOpEL8smnTP+NKmYFIjKbnUucwwrsA/oCLsLPsM4m+eThK?=
 =?us-ascii?Q?44CwFhXUO/QhudqhPMYtUEn9AAsXkESdSves4n0Kzj2LVs3LSXlP64sPoPFv?=
 =?us-ascii?Q?VaJ+6/5HO+6i4f9nD1dE18wUxlrnqZgNTtlWKA5OUWeM6oWSXWX7r8iampbA?=
 =?us-ascii?Q?CHeT90kB+b5kSCQq+aYb2lnlZkb7N7j4cOQ+n3fq0WMlsC+RnrVypcI04Mpk?=
 =?us-ascii?Q?bPhWQNU649BZFeFnVjuiUU7O9km2wouxWk1JVv4kCp/y88fOjHCwzF3XGPT0?=
 =?us-ascii?Q?1ML+6NsL1WdWQrsGMHpgVpf3Ev+rf2cGDHhuVgDEJ/PsskXrsmVV6NzZO6xl?=
 =?us-ascii?Q?aZFTGBz7lIMLNizJMBMXrDiZBzOdyWVpn5sjeTJGavc4mjS/NxfTTiGO+0/G?=
 =?us-ascii?Q?NNHdEIBX8TBfKUqrVU0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e79893f-7b07-400b-bde9-08dba2c2a5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 03:48:29.4584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqGODVXDm2hGJXahrDbdBDJvFl1t1+Z8/8ycn5N1WZMCk0+0evPsiaSQEZJcjFvZVrTeQL7QXVxcCFK2NAZ8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, August 18, 2023 9:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jiapeng Chong <jiapeng.=
chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/pm: fix error flow in sensor fetching

Sensor fetching functions should return an signed int to handle errors prop=
erly.

Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index f03647fa3df6..a6697c266270 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1467,9 +1467,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struc=
t device *dev,
        return -EINVAL;
 }

-static unsigned int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *=
adev,
-                                                   enum amd_pp_sensors sen=
sor,
-                                                   void *query)
+static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
+                                          enum amd_pp_sensors sensor,
+                                          void *query)
 {
        int r, size =3D sizeof(uint32_t);

@@ -2772,8 +2772,8 @@ static ssize_t amdgpu_hwmon_show_vddnb_label(struct d=
evice *dev,
        return sysfs_emit(buf, "vddnb\n");
 }

-static unsigned int amdgpu_hwmon_get_power(struct device *dev,
-                                          enum amd_pp_sensors sensor)
+static int amdgpu_hwmon_get_power(struct device *dev,
+                                 enum amd_pp_sensors sensor)
 {
        struct amdgpu_device *adev =3D dev_get_drvdata(dev);
        unsigned int uw;
@@ -2794,7 +2794,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct dev=
ice *dev,
                                           struct device_attribute *attr,
                                           char *buf)
 {
-       unsigned int val;
+       int val;

        val =3D amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER)=
;
        if (val < 0)
@@ -2807,7 +2807,7 @@ static ssize_t amdgpu_hwmon_show_power_input(struct d=
evice *dev,
                                             struct device_attribute *attr,
                                             char *buf)
 {
-       unsigned int val;
+       int val;

        val =3D amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWE=
R);
        if (val < 0)
--
2.41.0

