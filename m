Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B1C19F2B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 22:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0890712A7BB;
	Wed,  3 Aug 2022 22:48:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E4E11BAB3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 22:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkwqvO53UMuazu3mGKNRD9WcyDihxtdqQE3BJ7jSlbXJGWBa4+mOLfpxizVtsHm9KsmxL4zfFjy0JUCc1ZyhKCZ19Z6zgjUhhO6Pq9zuoSyNpKkCtwnYs+noUqB0JQMmx+yklltrmUQLOBBwVA6T3EcZH2Sngnd5IY31hXDRXmSD0WtafM0UI7h9pUZRqCsLLv7ZWPfoTeTjlovuxgDB8KKKQuD11jK15yCOCOrOHFKMdCn8v426Mvu5cnRlZiNneQI2E8QAA4vm4favAh1F34AdkVgLqtgMtlhxLvE6+DlxewUtS4IPuFn4uezEp3Kj6+NV9Blcjg0ib0JYo/yJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5WsNRxFdnAN/60P86nVg2ulRG9t2OMFDKnOUgOCgik=;
 b=fUCaTdu22LWAqTlf2PduGjLRl1BZyaXeNZt2uOyhZo5wLaaQSILw9bw0k4u8vUwFLjhyesNFwrZAYyOoY1nhS9kQ5sP+xwIAqbQ47wtIx5+O/HNHAFssEcOGxh8XE0Xz4kZ0CJmCPxDKCtY9ly/LHbWcF+7dmEKo8UDuSAlEQh8FdUV7o2Uo+9zW6eR4Q230gULwsXdK6VUNPij8Bp8s8ASNa1dYJMi6VE+DZiEa/lrGYBT6ttyvTwe4yGNudTD0ApqbhMdRNEEG0Dfr3PWSo3DL7Q/GOGofYVsylvnD3TWJiUtoMXDhqFPK54v4PiRDh+BAsuPSAPMk33bnM2+q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5WsNRxFdnAN/60P86nVg2ulRG9t2OMFDKnOUgOCgik=;
 b=iQVvC+6DpZDItEp23nyDGY3Wryl3ISjNgPURioPgAnJBAs+2zWa8ikLAgE0yL3riDILOafNgrQmiure72vlhfNK1DkBEV6QRtrZYaidAmzKEtWecd6ArLo9e9jpcTU4UIJGk45/iHHV6ptr1y/IzxHO27aHyYQJ8VZz6HFAAMx0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 22:48:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 22:48:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Avoid another list of reset devices
Thread-Topic: [PATCH] drm/amdgpu: Avoid another list of reset devices
Thread-Index: AQHYpy1Pn31Al3+8w0m7gPQZSzF3862dx74S
Date: Wed, 3 Aug 2022 22:48:16 +0000
Message-ID: <BN9PR12MB5257F90850AE17FF60660B36FC9C9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220803113620.3591261-1-lijo.lazar@amd.com>
In-Reply-To: <20220803113620.3591261-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-03T22:47:28.8875376Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d0f9ec9-880a-43ba-9ac1-08da75a24125
x-ms-traffictypediagnostic: DS7PR12MB6310:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdaoiD9a7OV8MgAE7cLtQ9+Eq9eUO6brqLZy/so/WcZ5JRulgqzN44QEcOhZWBzNrWOmahzBLw3vBm17NbZb2ne63fWpVRYr2L1Wp+WDkEI70ofHdyou0+fWwS+4vnk9oZhP2Vpl5dL4WuUi/kN4UYBfiswEEFC5f2sxrR0ojjXn58YOBVToDiJ1Rps2iMvndE3tVZJuEXtdHOxTpOPHcVo98WySOtC0rThjFdauUsdk/Dcpr7gRgJdBZcQ24rk8FOu2sUwlTUvxH8jzenxPWJMRQLnFZY2JTwPIdppx+e3xHD3OX9HhHYM3e0Y4tiQ6cnH4McLHhgHc6CBKmhnSMsMs7U7sFUeppl5LyoxICbDGCqkIWaXiswF0WNb20E6yG3/9TiVdsYCj/blbuxJBlXhus9IBmvICS/fRw3fHn8ElFzw5bdIvgRLdioxelw6nRYOW2A+d4wqWZd9AtQZjcoB2lvJzNPT7ipm/hfoRm7LOWH+MaD2qqI0ffMf4dHvOXhEOooBzNYKrt+pYrReHUDPc8h/Zu7MxBXluPZCH8wYzMArXvh9tH3Jt0xj8yRsHrbz1ib2T2Yj9KUMSbsLjqT/0vw30dnwOENopOTuBXzIbIem/kMmA2fTdnyo221XAp1LzLSUvDv0MHRa31qdFb9y5ZyVRjvsa9W2UhBD8VcZRwBjfNemImC+0RKuLeeH096uWfh/545pZCKj/HfWRmwepIKTsLTmD4xhOrgY5Q6pkNPuvavgSbvQVeRoS/i6DNulBoucaY2xdslRIyhnoJbw8uAWTi3OeX3BmKvfUWVvGtM132ylCU+EVaVz6EUB+fsuoovudolGb2EyonoE/zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52536014)(478600001)(5660300002)(316002)(110136005)(71200400001)(91956017)(8936002)(8676002)(66946007)(66556008)(4326008)(66476007)(66446008)(76116006)(45080400002)(64756008)(9686003)(53546011)(7696005)(2906002)(6506007)(41300700001)(33656002)(186003)(55016003)(122000001)(83380400001)(38070700005)(38100700002)(86362001)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wbhKhaPlKdbSpqEPIj6qWhEXKa9shXTn2IAejLbjr6BxKSvbHkhhgUQhyxz+?=
 =?us-ascii?Q?xEvPf3ATxufqUvsPBKGkmUnnnYB/gXcXl1vlFikTQk5zmt44s2IszFBzjiec?=
 =?us-ascii?Q?X3wDaOErcq8yIkfnJc3zq+mA28IslkVFJzP/igtDdy9/fHTgciEpnYauwM2k?=
 =?us-ascii?Q?TM276/4w0+7j0TU3TZUmeQ6UizWECPhotLyzJquhmZbjSWEwC8hEYVGGqCap?=
 =?us-ascii?Q?hFpj5H37LJNvwvaP6alw49IZciIDjUB0LBPi/VkMkKTJhFe21cYkCIxJPsWa?=
 =?us-ascii?Q?ei1nYU58fw2nAU+DlUnDiAUCf1yH1TtjobRdYaDey0FKb3qg2H57nFhwYKuF?=
 =?us-ascii?Q?FlaYvCbQQkfbU2Fuj+uKBR6jYXofJDS4NG6J8wK3yCcPeGFQqLiyP1uh7IJA?=
 =?us-ascii?Q?TqCsmsVYXZejdo5ae4Z6ZtdycINRuIPYhvxGHqnuAfA1E/nHb39ggRrYfPoq?=
 =?us-ascii?Q?cTDTh1HrellybyaKNrXsTllWxDNmegJYt7Rz3K1BXIg4vHUP7mEoKa6uzuLS?=
 =?us-ascii?Q?TBI4x4Dn2+MTR8ymVolHjKO/JZkSlUtrJk4UOxLGSlKtbP7WrxUIMGqJKp3K?=
 =?us-ascii?Q?nfSjVq0klLWs7xrste8KeBzsQYq6DUbqI2Rw0hg0cpN+t/UdmbRnm4H4mO/p?=
 =?us-ascii?Q?ph9h4QmGegwPKsXclrsJOwkAl7bqOV6+GgNW9mVWVWPxh7LSRd14eMmrxfMI?=
 =?us-ascii?Q?L5MDr+4nA/pvF8itelk6ZO7YA+5Zt38wzMjx5p8Q5BQZn9lo8twj+ppjpM9l?=
 =?us-ascii?Q?qaFooARlBJVW8qHTUwrsU7K8UULEKNeKhWk4UB8CYc++fMI0XE6ZAAzfJZTz?=
 =?us-ascii?Q?62nJ0OmWooVg/L6j26mh3jAuRAI4RQ24eA3E8f6eOXQYmTClDvrDxhdgn6UQ?=
 =?us-ascii?Q?aZMoCGtFHk4ZME5K/BGb9XBBiDWl+n4mH9SHSamN6V1jQedEMPrTTMitArqf?=
 =?us-ascii?Q?mbWFXkqVHvG5arH+CadY8ED+VhCG3a2XdbZx76F7ZxhIeULtoszVCmtARbWY?=
 =?us-ascii?Q?5WhClSUKBXNwMj0zVtMHnMbHI65xiOXCRALw3AuW3hoJzCSlkJZGN0bHv8th?=
 =?us-ascii?Q?BInik+GFC/7tVb4n9CJJPGNSuXrjGpnjv3ZwqZE68ftJuj0TEOvvHSxDc73p?=
 =?us-ascii?Q?aUcSOCov+7oliYjUhetRr+x1/bPccvaHnnMm+f4T2KaBjEZIFnzgkLrzINPE?=
 =?us-ascii?Q?rDLsCPIWEjZrajijzXmszPWVS9+/0j7m0HOLz0A5ScKx3ApOxiFyOYFotV2O?=
 =?us-ascii?Q?lVZ7tvhQ57uXsaGrVlyYzqP9Lc2bVKQjWy70pra6nsP+wbnkD9ib+m2TL7I8?=
 =?us-ascii?Q?XX7A6nM7jPsfd2ub+uxAF9wnV4q0N6wDJfhC5nKXEDVMBYhitqxLrNmvTJsh?=
 =?us-ascii?Q?9vLC80Q4xrM83L7bbTWTkgUX4fZc19P4TGkPY2vyw0Qr3zRuPuxEZjjnvcch?=
 =?us-ascii?Q?EfkX6O2q+6kJaNbEsOoEk3Pa1R9ybp1c8iYoAnj5fUFkUO5770A5llAwm0Yq?=
 =?us-ascii?Q?/ZojcKab0iqyyPdzx6d2igl6S2PhIU07qNGe+qJzfzWfq1SsN+dOdIrgYuY4?=
 =?us-ascii?Q?GJUM5kRVErR0Qkm2fZf4fpwYWILaX0569oL0/+dJBIkPCHKI38n1WUTnRGoi?=
 =?us-ascii?Q?/v9edlZV9ZHm35lxHg5p2CK92gChboPFKxaRoq1G6QX0vZV8ikE2+YIJVsCq?=
 =?us-ascii?Q?Tr5Y6Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257F90850AE17FF60660B36FC9C9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0f9ec9-880a-43ba-9ac1-08da75a24125
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 22:48:16.4168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqABTZ/nF7CByScGNubpEjjb9azhWxWaAnphr9Yh5y6lz7pe8GyJWCQBxPjbNWjUx4MA/bzvj9ByfcLV5wGhJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257F90850AE17FF60660B36FC9C9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, August 3, 2022 7:36:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid another list of reset devices

A list of devices to be reset are already created in
amdgpu_device_gpu_recover function. Creating another list with the
same nodes is incorrect and not supported in list_head. Instead, pass
the device list as part of reset context.

Fixes: 9e08564727fc (drm/amdgpu: Refactor mode2 reset logic for v13.0.2)
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 45 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index c6cc493a5486..2b97b8a96fb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -148,30 +148,22 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_con=
trol *reset_ctl,
                               struct amdgpu_reset_context *reset_context)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->=
handle;
+       struct list_head *reset_device_list =3D reset_context->reset_device=
_list;
         struct amdgpu_device *tmp_adev =3D NULL;
-       struct list_head reset_device_list;
         int r =3D 0;

         dev_dbg(adev->dev, "aldebaran perform hw reset\n");
+
+       if (reset_device_list =3D=3D NULL)
+               return -EINVAL;
+
         if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
             reset_context->hive =3D=3D NULL) {
                 /* Wrong context, return error */
                 return -EINVAL;
         }

-       INIT_LIST_HEAD(&reset_device_list);
-       if (reset_context->hive) {
-               list_for_each_entry (tmp_adev,
-                                    &reset_context->hive->device_list,
-                                    gmc.xgmi.head)
-                       list_add_tail(&tmp_adev->reset_list,
-                                     &reset_device_list);
-       } else {
-               list_add_tail(&reset_context->reset_req_dev->reset_list,
-                             &reset_device_list);
-       }
-
-       list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
                 mutex_lock(&tmp_adev->reset_cntl->reset_lock);
                 tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_MO=
DE2;
         }
@@ -179,7 +171,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
          * Mode2 reset doesn't need any sync between nodes in XGMI hive, i=
nstead launch
          * them together so that they can be completed asynchronously on m=
ultiple nodes
          */
-       list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
                 /* For XGMI run all resets in parallel to speed up the pro=
cess */
                 if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
                         if (!queue_work(system_unbound_wq,
@@ -197,7 +189,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,

         /* For XGMI wait for all resets to complete before proceed */
         if (!r) {
-               list_for_each_entry (tmp_adev, &reset_device_list, reset_li=
st) {
+               list_for_each_entry(tmp_adev, reset_device_list, reset_list=
) {
                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
                                 flush_work(&tmp_adev->reset_cntl->reset_wo=
rk);
                                 r =3D tmp_adev->asic_reset_res;
@@ -207,7 +199,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
                 }
         }

-       list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
                 mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
                 tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_NO=
NE;
         }
@@ -339,10 +331,13 @@ static int
 aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
                                   struct amdgpu_reset_context *reset_conte=
xt)
 {
+       struct list_head *reset_device_list =3D reset_context->reset_device=
_list;
         struct amdgpu_device *tmp_adev =3D NULL;
-       struct list_head reset_device_list;
         int r;

+       if (reset_device_list =3D=3D NULL)
+               return -EINVAL;
+
         if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] =3D=3D
                     IP_VERSION(13, 0, 2) &&
             reset_context->hive =3D=3D NULL) {
@@ -350,19 +345,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_=
control *reset_ctl,
                 return -EINVAL;
         }

-       INIT_LIST_HEAD(&reset_device_list);
-       if (reset_context->hive) {
-               list_for_each_entry (tmp_adev,
-                                    &reset_context->hive->device_list,
-                                    gmc.xgmi.head)
-                       list_add_tail(&tmp_adev->reset_list,
-                                     &reset_device_list);
-       } else {
-               list_add_tail(&reset_context->reset_req_dev->reset_list,
-                             &reset_device_list);
-       }
-
-       list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
                 dev_info(tmp_adev->dev,
                          "GPU reset succeeded, trying to resume\n");
                 r =3D aldebaran_mode2_restore_ip(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c4a6fe3070b6..e8a0b19b7398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4742,6 +4742,8 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_de=
vice,
                                     reset_list);
         amdgpu_reset_reg_dumps(tmp_adev);
+
+       reset_context->reset_device_list =3D device_list_handle;
         r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
         /* If reset handler not implemented, continue; otherwise return */
         if (r =3D=3D -ENOSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index 9e55a5d7a825..ffda1560c648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -37,6 +37,7 @@ struct amdgpu_reset_context {
         struct amdgpu_device *reset_req_dev;
         struct amdgpu_job *job;
         struct amdgpu_hive_info *hive;
+       struct list_head *reset_device_list;
         unsigned long flags;
 };

--
2.25.1


--_000_BN9PR12MB5257F90850AE17FF60660B36FC9C9BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</=
div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Hawking</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 3, 2022 7:36:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Avoid another list of reset devices</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A list of devices to be reset are already created =
in<br>
amdgpu_device_gpu_recover function. Creating another list with the<br>
same nodes is incorrect and not supported in list_head. Instead, pass<br>
the device list as part of reset context.<br>
<br>
Fixes: 9e08564727fc (drm/amdgpu: Refactor mode2 reset logic for v13.0.2)<br=
>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&nbsp;&nbsp; | 45 +=
++++++---------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp; |&nbsp; 1 +<br>
&nbsp;3 files changed, 17 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c<br>
index c6cc493a5486..2b97b8a96fb4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<br>
@@ -148,30 +148,22 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_con=
trol *reset_ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_context)<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)reset_ctl-&gt;handle;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *reset_device_list =
=3D reset_context-&gt;reset_device_list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head reset_device_list;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quo=
t;aldebaran perform hw reset\n&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_device_list =3D=3D NULL)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[M=
P1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
set_context-&gt;hive =3D=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Wrong context, return error */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;reset_device_list=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;hive) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry (tmp_adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;reset_co=
ntext-&gt;hive-&gt;device_list,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc.xgmi.head=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&a=
mp;tmp_adev-&gt;reset_list,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;re=
set_device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;reset_context-&gt;reset_req_dev-&gt;reset_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;reset_device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry (tmp_adev, &amp;r=
eset_device_list, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, reset_d=
evice_list, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;tmp_adev-&gt;reset_cntl-&gt;reset_loc=
k);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_cntl-&gt;active_reset =3D AMD_RESE=
T_METHOD_MODE2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -179,7 +171,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Mode2 reset doesn'=
t need any sync between nodes in XGMI hive, instead launch<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * them together so t=
hat they can be completed asynchronously on multiple nodes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry (tmp_adev, &amp;r=
eset_device_list, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, reset_d=
evice_list, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* For XGMI run all resets in parallel to speed up th=
e process */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
queue_work(system_unbound_wq,<br>
@@ -197,7 +189,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI wait for all r=
esets to complete before proceed */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry (tmp_adev, &amp;reset_device_list, reset_lis=
t) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, reset_device_list, reset_list) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (t=
mp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;tmp_adev-&gt;res=
et_cntl-&gt;reset_work);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D tmp_adev-&gt;asic_reset_re=
s;<br>
@@ -207,7 +199,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry (tmp_adev, &amp;r=
eset_device_list, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, reset_d=
evice_list, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;tmp_adev-&gt;reset_cntl-&gt;reset_l=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_cntl-&gt;active_reset =3D AMD_RESE=
T_METHOD_NONE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -339,10 +331,13 @@ static int<br>
&nbsp;aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_=
ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_=
context *reset_context)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *reset_device_list =
=3D reset_context-&gt;reset_device_list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head reset_device_list;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_device_list =3D=3D NULL)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;rese=
t_req_dev-&gt;ip_versions[MP1_HWIP][0] =3D=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(13, 0, 2) &amp;&am=
p;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
set_context-&gt;hive =3D=3D NULL) {<br>
@@ -350,19 +345,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_=
control *reset_ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;reset_device_list=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;hive) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry (tmp_adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;reset_co=
ntext-&gt;hive-&gt;device_list,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc.xgmi.head=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&a=
mp;tmp_adev-&gt;reset_list,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;re=
set_device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;reset_context-&gt;reset_req_dev-&gt;reset_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;reset_device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry (tmp_adev, &amp;r=
eset_device_list, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, reset_d=
evice_list, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &quot;GPU reset succeeded, trying to resume\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D aldebaran_mode2_restore_ip(tmp_adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index c4a6fe3070b6..e8a0b19b7398 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -4742,6 +4742,8 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_en=
try(device_list_handle, struct amdgpu_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_li=
st);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_reg_dumps(tmp=
_adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context-&gt;reset_device_list =
=3D device_list_handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_reset_perform=
_reset(tmp_adev, reset_context);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If reset handler not im=
plemented, continue; otherwise return */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOSYS)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h<br>
index 9e55a5d7a825..ffda1560c648 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
@@ -37,6 +37,7 @@ struct amdgpu_reset_context {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *rese=
t_req_dev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *h=
ive;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *reset_device_list;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5257F90850AE17FF60660B36FC9C9BN9PR12MB5257namp_--
