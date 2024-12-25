Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC1E77188
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2024 01:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8794310E034;
	Wed, 25 Dec 2024 01:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aN4wghyy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB61F10E034
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 01:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/qh5KE0RSkXH9flDpiIYCrHVZfn8R8yTiHOruZ5HYm4rcZ5Of5fSkMssveWeZ3XgkmFCmXj+8nXvlAjJtjLFx1iDzN8qkmLwanNDwx2ubFbq/urabjdOTdDXPBhUBT+aSGaaU3y4r5TSv2O/PSDUcjoGRnjAIcK8ntMvR0jV4/zr63AWPTwrXpHYm+dYf2joUJzOup96fFYS4BZAe0rJ5H84V0RkdVVSzbt+l+9aiGG3ef49cWA6l7lIKZZRJAse/M0bn4q7xQiDpO6HO0FA7BQhCJFT1/Iux0lAjbOrdZiOjAz7t0ohShahdKo2SFbTdMUEincDTLWQEyRxuv2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B2A1o3k1bm/BMdpwVYlW7ZvVX+Rx5djAofy76Z9U4c=;
 b=Cy1Dk21Zg35UOD3vYnTOhXYtuCTx+2XZcIiKSuaSr8L7aaexVCrPJ8voexFazh2Fcwwcd2zm0Gl9IvCxkN8XTVKsgQPDPe9pwz6buiLhtD0iyha3xLuVVK0eMkFZ2TZLR+WOfspGSfDtdHbN3qkhttsK6/8p5dlUUQBansX0A51B8kyu0y0nXzD/x/WEQFldLDV2sT3i4GJW7fC0uVGU+McvGsiDgvQYHsDGprVHGYjeaK/pTJ11ZANdAfq1fSIl3Pvc8rsH/A5urpptaZzEm0NTaPup269ZzjC4MZUyMSYASpXxEdpJMZsiNJ+MOMKuGr+TW+UzW3YJzFxNqOY5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B2A1o3k1bm/BMdpwVYlW7ZvVX+Rx5djAofy76Z9U4c=;
 b=aN4wghyy2jMNg760MDBu7ya2sUgm+GxTk/Sm/IPCaew7r0cPsHEgJ5T/DJWfO+LWfajLnNecRB9YEqlP85++GcWm04TRxcIPGKOGmA1aYQvQSUea4er3lbwwfJBfdkxhbh4gZz/SnFXehfRO9wXe4BRg+G/VDT2pDsrFYrtarb8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 01:59:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 01:59:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Yuan" <Yuan.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Yuan" <Yuan.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Thread-Topic: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Thread-Index: AQHbSq26SoGiWQU/M0SR0SLlrNdz7LL2S3bg
Date: Wed, 25 Dec 2024 01:59:23 +0000
Message-ID: <BN9PR12MB52575349DCB4839C252DC9F5FC0C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241210024459.2993-1-yfeng1@amd.com>
In-Reply-To: <20241210024459.2993-1-yfeng1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20ea1cf2-319f-409e-beb6-e18cb2de4f4f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-25T01:57:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6031:EE_
x-ms-office365-filtering-correlation-id: c4c69205-61d2-4408-0706-08dd2487c114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Xj+hMqInejtknWb4sNgUtB8DZ9iE9g4LIkFtL5aDhBXd1jEj9plmJxQH6ZVE?=
 =?us-ascii?Q?AyQSaF5poDYFDnWnczeJOMcb+8+plm2LJZtkC9v4qwwZKDP8HYhxbawHOveN?=
 =?us-ascii?Q?MKM542ACl7QuxsFNB9RPVFO9FzMDwVxEyCatZsi9peH/ecsm9UyiqJESqvpP?=
 =?us-ascii?Q?yPIaQG3PfFEFI2Ql7Rqfmm7GwIxxXljElXnGBorBcaP4iNmvRj0zapd/yP35?=
 =?us-ascii?Q?+JaWifmtNkjyRJT6K9fGSL4rZBDQrd7gJbxMzdvxVLSS7NO11z66GLYz+F6I?=
 =?us-ascii?Q?/ZPDThSMNjnZnDmJ4vgmynV/cs/n7bsdhmKMqgqJob8rx/zwYRPFdVVyH+WB?=
 =?us-ascii?Q?jCSW92lMvTuNH6PdP03XnN1u0Bxb59brCUOG3yxjMszW1TsXuL+25CZqeOkl?=
 =?us-ascii?Q?Ak07FWYel66L69u16Jsw4cygu9DzDk10rjNWqiVeXmTOzSCudCsd7n7M5J1H?=
 =?us-ascii?Q?AaFGd0uJL7aNJ+QPJsA4frL0blZjziaQ2/SMhOOKPgYOZ+/ItttSSZ/0Mq2s?=
 =?us-ascii?Q?Cni21KCPdmLdE2mpcXTj2iCjy4a9lhU3F2flI7edrEpPr0jjdLGJWUXajL11?=
 =?us-ascii?Q?pBFjKn1illcf9BxYXii81X4/9BfvQjjx0tyb45Wdvi7PTfBTW3PWYbwxqYDb?=
 =?us-ascii?Q?J7EF3g8rGxRpXiNSgmSKGUC/zDwsE7MTk+se6b4SHa0A24CpYuyFF+gviC2e?=
 =?us-ascii?Q?/XQ22K4E2y/Yd/B8f+WAHub+61iZESGqYKNrBM+pY+gyJ9kq94iToRJj1LFo?=
 =?us-ascii?Q?OsUKgfwEoMiAyLHFd+ckGe/OUpwwuRUKTzXattHZ9XHRwL2yMq993WzbO5wJ?=
 =?us-ascii?Q?ke4pI/yDuGuxDfAPYCqDsCtNY3ns574BlJ/sprpXh/GKjpHAny49mhcz6vuN?=
 =?us-ascii?Q?JNoYAmRoUBgU/RLHM2qIBJnT1ees4AoN4XU9pr0iG9yEOvhG4Grqbm15ULFI?=
 =?us-ascii?Q?n9RRlgz8Kox9vWWBd/28XEvhRK5aMv7rmFQICQttOhZWUyT64ofEsXdfjInY?=
 =?us-ascii?Q?tnqbrraiP+QH47OQNHnhCcG5lslMwbWMoJ70Xzq1xVrsr+kN87cf7SM8heEw?=
 =?us-ascii?Q?9mioWOE/2hgqwgn5PbmtMQz97Zi6atFrM7B2z5LiMIJ6DCmEjbeOw0fw54E0?=
 =?us-ascii?Q?YqztSYzeofJ1MIb4UPZgIAtStXOYnNJspnANg32wtFRhgP8gas1OVn5t+cg0?=
 =?us-ascii?Q?5qRs1DmTmOlSfC3NSHkSSGRWQMOuhalWL+aiftI8oWE+m4PwsAyhwwB5dR7Y?=
 =?us-ascii?Q?/iMEtR1kfP9yGCVk7P6xFet3R291w8YyUiuk2MR0jsSrGIvbB4VrMxq1JSpv?=
 =?us-ascii?Q?lichPegqISjAn8shDi9VRe0kgVsGOs2m/djI26owFaXU3ACb6Dac434XgtYn?=
 =?us-ascii?Q?KX88irY5uax+EjOT0qQ1tybyNI/1DPQVMPdxTnlPMIcLwm0Sr9/Fj5cGqOI4?=
 =?us-ascii?Q?s9ep43CJT8uvT7AWcVJyJFOAAMa+rWN7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C6qLCE32TxAda9ELo+m9+wbj2oDx/6l6i5trNbtqh87lZkgFjm3QUYeKmRrY?=
 =?us-ascii?Q?zJYIbHWVJ4gqSi3AS+Wq0j2q4XIqyeMHFVcecqU86yw/pMVdS5i1LKMvBVw8?=
 =?us-ascii?Q?kSDsoX55lkRTD61g6owd/8YV+oLe2ULAJADiyAVryylaCg+P5KjNxUrgqfVs?=
 =?us-ascii?Q?xoJZtSKdWF4dXshlFo2UqR8TJ51EYpcP0OaujJE7brlNtx7DUDoztcJQhinj?=
 =?us-ascii?Q?3c91cAM00kLZroo/WOOMTCEJ0GoIBFq/r4B25Uch1PuVcKsqNOuS20XD9p+G?=
 =?us-ascii?Q?RqfInDIZvlDf7FFBvHBSyfe2arl43vhi4jGFhlLIEGJEn0uKg8uQbu7BkndC?=
 =?us-ascii?Q?z00XuuPkRvkeCfHCZqMqXHI6fwaeInkz4Ch0Z7hR+AyMxXuWxi69sLmEam+p?=
 =?us-ascii?Q?U9OlNGH/cWx3T1vmWPibFc92njOX75J9S9gBJEWai/DBtlAmlIv2xYwpVX4/?=
 =?us-ascii?Q?gf8W0tftvogF2oZBBbyK4AVNZ5zzkyuClCrwEId1U8Fq1QTHwvupNRxfKNZQ?=
 =?us-ascii?Q?WMIJRUu4i9C8Nm4d7XZCUIniKsvp6IcNgCI+810Zc8zT/qGnFj43gI2V2ggJ?=
 =?us-ascii?Q?NTUS4TVsjBFHECqjCKJk+w/6VYxTliU8xqsQjkpt3Q+xJDEVshieO6ezY1Tb?=
 =?us-ascii?Q?LYBFd4n9khT9MH/LYZmviv5vQI9/gH/10EmPrDRyuxncDYhKNAUVl3TyeIJu?=
 =?us-ascii?Q?kN9FxpUN6I5tS1o1/ouyU7+kZh1a5CAKvKTU0oVqgA2aVtmGxOitAK5nwp4j?=
 =?us-ascii?Q?KgIxNxOSjMPpCGDJ41XguZURV4H3QLuir9/UMc7YJscAgjrByBmApnOXbab+?=
 =?us-ascii?Q?MgWeOjYehnj0Ux+x7SoaQFOltWiq+fslJBlW5nwTcia2z9GV+g1c3eBuS+H/?=
 =?us-ascii?Q?MeinqcftyG5NUa1eS8mep0WeoLRnPbTSaYuHl+Z+PsaBjuoaQsbh3Mz8kZaE?=
 =?us-ascii?Q?KtsvJ0sQYxAEwsnfacLPtvNySfm837rT7HzDc3LCBW/sOd9yaHfULvCog6qc?=
 =?us-ascii?Q?owKe7FT8eLShGx0h9da+cNzxqT14uSjF48DXPPG3z5+SHVFH322zFSjFqvn+?=
 =?us-ascii?Q?LJnvzd5e+iovYzCQEVsl1kDBBvvsJa4eyL57LhyRacyr7guaz5ha2DCT76h8?=
 =?us-ascii?Q?SdeaiEE41S+7SA5CKSFpy1jVRkAZcESqSQgowIUQUKkD9Hw7RKuIhqO78YRN?=
 =?us-ascii?Q?tnriyLpXfO9e+x5rH8Or5QxnWfXoHw2bI15aif0IWg+tmp8atL/JhcJaES/5?=
 =?us-ascii?Q?ACdiC93z5VIBIYCkLFJKh07hranWSr/IfD51fQLu4s1PrF4jq5mFrl1T14e7?=
 =?us-ascii?Q?dYW9zTUwI3680YApxsH/IYfsJHA0NdJ6Zkov6aSQT0YXiWAHHXoyEFzG+qN4?=
 =?us-ascii?Q?XJDUk6APVVozAi5n2Ih817w0E8zNaNDpdEJCQ5/xO25NP+Yn26cfxycPzbVL?=
 =?us-ascii?Q?R8fiYiV7zdrj1w8r7lomgbszwWv4oxPFE0wKNANtXAuYOShM6Kk3sGKxw6KW?=
 =?us-ascii?Q?XEIxZAzfqIGchgFCdZARvmDLHw1yylXFM9y9gogajWqN/Oflnvcpr4wHRdsA?=
 =?us-ascii?Q?tSC58zWR5eZYqp/vUF0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c69205-61d2-4408-0706-08dd2487c114
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 01:59:23.4536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrTcZl9tiqqqfUgdCIqpUYKW2ql/mvTL7vtuaAuEZ6uF7jwqcvty522LhmsaP6NfXu5IIxJXRtZTJiMzJbsUQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yuan Fen=
g
Sent: Monday, December 9, 2024 21:45
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Yuan <Yuan.Feng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF

From: yfeng1 <yfeng1@amd.com>

Users might switch to ROCM build does not include MEC SJT FW and driver nee=
ds to consider this case.

Signed-of-yfeng1 <yfeng1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index cc038f300a56..5e6c1aab2e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -579,10 +579,15 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struc=
t amdgpu_device *adev,  {
        int err;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
                                           AMDGPU_UCODE_REQUIRED,
                                           "amdgpu/%s_sjt_mec.bin", chip_na=
me);
+               if (err)
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_f=
w,
+                                          AMDGPU_UCODE_REQUIRED,
+                                          "amdgpu/%s_mec.bin", chip_name);
+       }
        else
                err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
                                           AMDGPU_UCODE_REQUIRED,
--
2.34.1

