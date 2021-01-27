Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036EBC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957FA2064B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957FA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0086E50B;
	Wed, 27 Jan 2021 04:37:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF29B6E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqoAUBD8rzpGNzHjw6aJg2Ri3CZlAml1PnRQGs9wMK4BHFljJh7E/vELAtcMswf6Pi4mOnGcgfDpuBvksalWWezD74mqvdtSBtqcuGBuQBxCV8goHmai/uXY9SuvDUDqbks3fWTVLY99iAvW/gDcn+2zF9EHgWUOqiKrrqvhTb3BQcJpe/0XfpuGToi9k7Oh6h80Sgr5cOF2p9ZbJW8olmCaXZcPPJjFh5fI6ZFLyvklg3ZQ6IOhXJYYGQkoKd5zMfm6F53FDrFw3fKa1PP9wHKl3DNwGUhjvcjPErvHWx637G5bYvXgrTeuHssr0cA8qVGedKgyY37eJMFO08npVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7TyAxnZkpV5p6LUr4tZ5FUFKQlBD/u7Eq8xEn8kCH8=;
 b=REKABQmVQwRMHJTwSCv1vtSxD0Osl3oTwvQOrLmTFxEBMWlfCA7QEBjfPyq3Z3bVnI6fcEjLDpeg4MZahp8TwE/Tc7Cx+omJJuVoP/8Ru0JKF3Q6YapjztuBTBWEYRKri9uEAHacI4hjEEpn58WHQTKZs+ROr+IDHUl4PgTRLjn3LZwDi4oMXfjIZRy6n4blMst/ywVdP4hL34jwLAkln+Fu5uyYJciL0AC55Lmy+kvMtDzSiu6yL8tUc/zaIDjh+LUMZP4Xat6TKUoa/1kJa/Q6Dwcv/xXsHTNuDi5f4zFVY4QGUdm91J0cbo+gZpFLeJs2ApcTljvhMvSLmJg6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7TyAxnZkpV5p6LUr4tZ5FUFKQlBD/u7Eq8xEn8kCH8=;
 b=XJgalpGAEFYlU0aVqTO7FSA3FqNRmQtdm/EsZi7G7bNd+onh6cWMsD0vcSgLi804abFj1HZKDux4QRP9m7149UsuFHtmB5tRk9P6Ym46lwGjXQ4uLJOLlyA0VlB9yMfS9/x+OYz/RcYH6ajpsRcvYltXYeYfAySUUaWB2MFSABY=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 27 Jan
 2021 04:37:24 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:37:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A+A8B54h1FnhECsUfCRTVBIg6o61ZoAgAANYYCAAABmgIAAAHSA
Date: Wed, 27 Jan 2021 04:37:24 +0000
Message-ID: <MN2PR12MB4549DE6D9D34295D8E63402B97BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
 <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>,
 <CY4PR12MB1287945849A59414A6B38144F1BB9@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB44887DFA0177C949C1F99166F7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44887DFA0177C949C1F99166F7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:37:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.208.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6191f363-2141-4d7f-eed0-08d8c27d3e8b
x-ms-traffictypediagnostic: BL0PR12MB4690:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4690859CFFAEACB253A122B597BB9@BL0PR12MB4690.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GybTBV+OCZKcERYk74V0v/+1jYmMRRfmCc8MIYfSOT3QjcvlYzwjHkyfVqsuYdTmp22XYoVzF4Fg552vSu3wDSfmxxWFSUlTpD6cXxwzdaBuYCbOqKkUF1t5u6HoDNMhd6vapZwrRqCPh7dfESTz+kyC/2Nwpxrh5BpHFTygOZFiGpZLh9ff4yDuMXb+U+5waTsoOsDZzDx52MMTxCuqQrb4r8misi099NG6MEDRvzN8TS/jo/9666Ol36AO00juBmMz8n5Cpv0F0qYQMhJLbxWJaAS1+7BxbU8XdeVQzW89AFIGJsGvbETeBRfERVDRgEWs1SpzZowgFymtgIEQtOpuK5zD9prSKqub/IjIXQS6WHhqWnqI/ys8x98hAxTBZM1GaxBmgeKfMKVrC/CAIiRoY81pqxmdTY0vDQd7QdU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(7696005)(316002)(110136005)(2906002)(478600001)(86362001)(966005)(76116006)(52536014)(45080400002)(66476007)(66556008)(64756008)(66446008)(66946007)(55016002)(55236004)(53546011)(6506007)(71200400001)(186003)(26005)(33656002)(8936002)(9686003)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RzuFdiEKcZuHlZn3mO+nVtIt6ceLpYEqvDnQe/Vhe13x1exLOSCU5ko8NZFh?=
 =?us-ascii?Q?cYN0fNF6wrsISl/l1mWUPcAst9t1mFSoHLUv4HxU0ghZ2N+zFkCb7ZiB2Ds5?=
 =?us-ascii?Q?d32cDjFh7vPccZiS1WvkXa3w0UGX57Ie0XXXKD8pZdEo2QqPSV2c3t74OVWh?=
 =?us-ascii?Q?LuxAf5hDoKmaaCdKy0d7y3mzSf4zoK6oJcsWFAKPjRV61xUOLpQs4vwPx/YW?=
 =?us-ascii?Q?zKof/HZyv0/UC1uwNfym6Hl1XmJkixwOV6y+rfm5zd8KoX7FYHdt1RoXkvm7?=
 =?us-ascii?Q?HMO4wgTsSNfP7trGmzdlZGciikVXLSSQl+nYtZOy3G2V755A2UkDHXyD07j9?=
 =?us-ascii?Q?8O4HDDW01GJ5cZObTr06RxFoBHiRLi9KkKt4//z5oDdXQM3wAkz76blybaqU?=
 =?us-ascii?Q?2sJ7QLzS+3DFgcgsmT0XAmiwxQeK6ruDH3kIMMoICWTa8XsXTjwm4268oao+?=
 =?us-ascii?Q?EDbTalpFvcmpuygNkUhk4kAWiuGRxwkIbTP7UOI1jNWgUqMN8lYRlAb1Xhri?=
 =?us-ascii?Q?g1mgiDP4+uNWRARs79HnE8PNIfCj/CibrdJv3LugE/kewI4P21IyVMwXfBKf?=
 =?us-ascii?Q?LmzISlicyOC6XjQ2ooAQBWeCo+4HAzMJTEuAkJpobev2BRP3YK1RxNfMVdmy?=
 =?us-ascii?Q?NauqRRcPwNrTyYLZexN141CdqZR0iITUEs3+qa7WR/XpGWVk7f7yy1Q/sdqi?=
 =?us-ascii?Q?39/kjQQyx3ibTa66UmVP93mPDIhbS3j/ae5MVYqWHHn3LbH+NMGAjPBt4x+l?=
 =?us-ascii?Q?7okENfsg3HSPcytnH4NXW2s/MEJpBNTiEug3wKcliWwohSDo7mfRf/rqKpUb?=
 =?us-ascii?Q?1dIWGyw5GmAWdjqugfp6sqKkwh3s7GiaVE5zvhbe4odAWmCQxygOuVE4lact?=
 =?us-ascii?Q?c7wqCnhRXO9Ypj5DLeC6KTd4zGoMlNBO04f7/X2a4vG0tJBCJeXbTaHQP8lY?=
 =?us-ascii?Q?u7DFMwzTTvHbrOyVaHJB38C5MW+F7C/waeGh3J9JW9jIHLfLWgYT0opia/3k?=
 =?us-ascii?Q?8CHV19swsNcCm5L0Quy68rvyaY5jHc9SjVrLVsFqnKYXriDg+LQwzfxakivu?=
 =?us-ascii?Q?9OdaG+u0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6191f363-2141-4d7f-eed0-08d8c27d3e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:37:24.8356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+az3NsumNXrPIAOh9Clmfmxg7gWvmaJzgvHsZVIA+jpa0m9XYsPA07EhMlUP/ye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
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
Content-Type: multipart/mixed; boundary="===============2028499122=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2028499122==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549DE6D9D34295D8E63402B97BB9MN2PR12MB4549namp_"

--_000_MN2PR12MB4549DE6D9D34295D8E63402B97BB9MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

As far as I know, refclk is fixed at 25M for TACH; no need to consider ASIC=
 refclk.

Thanks,
Lijo

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Wednesday, January 27, 2021 10:05 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Ale=
x Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback


[AMD Public Use]


[AMD Public Use]

Is the xclk really 25 Mhz or is there some divider for the fan stuff?  Chan=
ging the xclk value will affect other places where this is used.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, January 26, 2021 11:33 PM
To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Alex Deucher =
<alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd-gfx@lists.freede=
sktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.=
org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Public Use]

In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.

If (adev->asic_type =3D=3D CHIP_RAVEN)
        return reference_clock / 4;

I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Quan, Evan
Sent: Wednesday, January 27, 2021 11:46 AM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd=
-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <=
evan.quan@amd.com<mailto:evan.quan@amd.com>>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,  if (!tach_period)  return -EINVAL;

-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;

 tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;  do_div(tmp64, (tach_=
period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3De%=
2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;reserved=3D0<https://n=
am11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskto=
p.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Clijo.lazar%40amd.com%=
7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637473189035661354%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DpfK0LTxZUBVlvvX3zs3D=
QjmtYyOJkNdFIBUGkTCyopg%3D&reserved=3D0>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dlp=
9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;reserved=3D0<https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Clijo.lazar%40amd.com%7C=
8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637473189035671303%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Da%2BTTK%2BJ0YjbNe9irLE=
9GRgK0koyGYKfrtcMUR0wkvxs%3D&reserved=3D0>

--_000_MN2PR12MB4549DE6D9D34295D8E63402B97BB9MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As far as I know, refclk is fixed at 25M for TACH; n=
o need to consider ASIC refclk.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Wednesday, January 27, 2021 10:05 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Quan, Evan &lt;Evan.Qu=
an@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.f=
reedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Is the =
xclk really 25 Mhz or is there some divider for the fan stuff?&nbsp; Changi=
ng the xclk value will affect other places where this is used.<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 26, 2021 11:33 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">al=
exdeucher@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.<br>
<br>
If (adev-&gt;asic_type =3D=3D CHIP_RAVEN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<br>
<br>
I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Quan, Evan<br>
Sent: Wednesday, January 27, 2021 11:46 AM<br>
To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@g=
mail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.<br>
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan &=
lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt;<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Wednesday, January 27, 2021 2:17 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
The xclk needs to be divided by 4.<br>
<br>
Fixes: acab02c1af43d3 (&quot;drm/amdgpu/pm/smu11: Fix fan set speed bug&quo=
t;)<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 147efe12973c..36dac106ed4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,&nbsp; if (!tach_period)&nbsp; return -EINVAL;<br>
<br>
-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);<br>
+/*<br>
+ * crystal_clock_freq div by 4 is required since the fan control<br>
+ * module refers to 25MHz<br>
+ */<br>
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;<br>
<br>
&nbsp;tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;&nbsp; do_div(tmp=
64, (tach_period * 8));<br>
--<br>
2.29.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Clijo.lazar%40amd.com%7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637473189035661354%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DpfK0LTxZUBVlvvX3zs3DQjmtYyOJkNdFIBUGkTCyopg%3D&amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cguchun=
.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdat=
a=3De%2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;amp;reserved=3D0=
</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Clijo.lazar%40amd.com%7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637473189035671303%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3Da%2BTTK%2BJ0YjbNe9irLE9GRgK0koyGYKfrtcMUR0wkvxs%3D&amp;reserved=3D0=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cgu=
chun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;=
sdata=3Dlp9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;amp;reserved=
=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4549DE6D9D34295D8E63402B97BB9MN2PR12MB4549namp_--

--===============2028499122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2028499122==--
