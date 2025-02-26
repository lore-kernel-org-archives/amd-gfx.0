Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF28C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 06:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0085810E21B;
	Wed, 26 Feb 2025 06:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OAGx/mwv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D16C10E21B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 06:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD7d9l2E5AJC+9ap63hQCYfaZ7W+WzIYBKr4btxV71VJ8UIGVqaNNhADnOMETnaplHco22KCLjwds6XQYHyQFRTxj5aDU/x+BbX0PQTAGE6UcoNCihCHrHdd9bB5IEVJjjTa2jOpL8P6mW0J5YOwaoixpVZNelxg9GJF7LHwqL2IGixaVufKuz6xUOeLG2L8JdWaXGWSunkUQ90yMOAVgNvDqeLK+uhItrpyp+CfrNUmKUKNFYSRJDWAM3ievvEEFR6HPuFx5+TutJFuUSBPLIqNNHTwUlAE6Cv7Uxaex9PW75Cw7DlT1ckaMz8K8mdAeKV0W9abKGJspWlyByG3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pZvysfP8aZmdu5z2bbD+mQ+Rh8Cb20fInNcOkEAZjE=;
 b=Ry32fh2icgFZRLKmmvu6rcCRM5jFWXHB+k5pL3JuQas+/juR06GwCM6PkD33xbeHvlyRGKS3MBxHf3uBV4UjxXjeQ8uKvUrgL6VLXjwYQRD8WYjgwB8yD2j/+0B+IEaeVHZr3x45vWDbBqM15NKYYE2tkwEnNClIGWb/q+sDVK8dhJWLxYE7CsKRLLFQx6uQ98AB8vkgUw1lrXLyvTXbmtcYaKN5M573y8NzLfDatn7Ol+zdjaqVGHjYM77EWLP87M+B6T57w8Iivie5s8cLf5WbCDgOtjgrOQ5cPrrRxHZklY8giAyGhIh8729hoGlDW/Rg0qU+eGfHdKV/DrsPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pZvysfP8aZmdu5z2bbD+mQ+Rh8Cb20fInNcOkEAZjE=;
 b=OAGx/mwv4rZQMHu/m7G/j9mbv78VjglZwR/I8s5HzYQGtK2kc9VnXBhRkjKRREcRB7K5e8XQXrvJ3Lk+ku57+Lj+hJNbU1E995AyTGhcLGbbYJn0riZ1Zs+F2QNYG7c2nOhx0K/AxXTvqn3yUfdrz8/Bq8OUqYjj2H5q6ZgBgeo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:01:14 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 06:01:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Add support for xgmi_v6_4_1
Thread-Topic: [PATCH] drm/amd/amdgpu: Add support for xgmi_v6_4_1
Thread-Index: AQHbiBKGHtwvRM+b5UuJYUyvDDBULLNZF3BA
Date: Wed, 26 Feb 2025 06:01:14 +0000
Message-ID: <BN9PR12MB52576AFD4EB153742D51A447FCC22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250226055123.805639-1-asad.kamal@amd.com>
In-Reply-To: <20250226055123.805639-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=02738d19-9feb-492b-bfb5-79fa2861abf4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T06:00:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6130:EE_
x-ms-office365-filtering-correlation-id: 939b2854-f2ef-41d2-74ed-08dd562afa41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Xj/DMCKsaCRMas7LsK1bV0s4Vm79ktClp/BVc8vTsK1PUWMwnuQ89o9srnA+?=
 =?us-ascii?Q?rTYeoeVih3tjdgR+WQOUwDJSb5MOkUXBjbRxlFNHkRNqtED02jhtIbVudN0e?=
 =?us-ascii?Q?16DrTvEss2/pn+4Ree+gAlCDJpS37Eq8QjPCRuxd1RA51ztN+ystTScoo8MQ?=
 =?us-ascii?Q?vZgQFtrP7paMk/wivtqqcuPYUeHuLkbRw5/mXmpVg6m4aaAcgl93f67C7oRP?=
 =?us-ascii?Q?RTo/TMNwJ9zeBlElsaUOJsUSkQ8PJ/ld6JW+eOrDapXevVNPV04LL7aPJ/Bq?=
 =?us-ascii?Q?qBDvJt8m/UJtRr6ca19IHpeVrckDHiRc+EwF4zNLGDvNxbD1pgNpDPJjzjO1?=
 =?us-ascii?Q?/PQjhQTfivurKZbF6jqQlQuSnA/ctO2J1TVzY7NnUtPcaWfToKkmsroBBrj6?=
 =?us-ascii?Q?sx1Hnx9Kw9ypD8LLL2mFIT+eNziiT/Fw4LRZBpg3A8ylTCcjDIo8/r6rfavf?=
 =?us-ascii?Q?mtDqHMtNmlyXzPAYATMS2pccNiwie+cuLT6YV3sFAbMeqfvEmBgej40YlyhN?=
 =?us-ascii?Q?vblABUdN2T7SBCH5GiAyzR7jBhkK//Qbqa3lIZXiCbNX312GoyX5KeswTERB?=
 =?us-ascii?Q?XPCraLTJAwqEhkezvFepw/8mW+KkuQhkrGtpVh1Rtk7kCfN72zY46QTWVMsh?=
 =?us-ascii?Q?q6aBiMQdQTkHMn8Xyt/y9eF0QoALXHwnE7VPne9P0coztPYyo9LNytoG39bk?=
 =?us-ascii?Q?rSrNiL3bFwBrMbSbHWUNxKDk0bqD7WhrvQjzOBKzjRMkHE2IHB5SlRgCzjE9?=
 =?us-ascii?Q?z6y5fL+9pESYWhUTD+Rl6+q7wKCAym2wxjp8dHnZVOrKBfLYmgOgk8XiFbgo?=
 =?us-ascii?Q?Lb4K6r7LvtPvsh6bNP073sjkvaELMHnecnvYkZOBgPUTZy2K57koV3NBef1k?=
 =?us-ascii?Q?Igq9PDMrvsP9Pwum0Kjwcemno6DdcQwyxwaorj+1eQc4+n6wjY2m6R+F96Mb?=
 =?us-ascii?Q?nSPaXiBiG2JbUVBrrTxmnmhL2tKm2XmsOa7UY+twJgx1St4xQmO3qk+oq9Z2?=
 =?us-ascii?Q?3SHxJAU23fwviG1zu9FXJQ8Wz3nn173CBGLmPZP36e68EBMvK+ZpFff76OeW?=
 =?us-ascii?Q?suBt+xFkeAkPWgXs6uaCXK0Oxth06EEJ4BOZaPIAfM/OgdJ06rS2jhIetgby?=
 =?us-ascii?Q?QJ8AQ/pyLkBBTAExwc49Gz6+71wo7BgnNg3u8qLiviRv7fNBD6qXm7HXQ5Nj?=
 =?us-ascii?Q?mNAAfsUNQSQncxhEUKW2kL0cl0+qgx1ArfN6cwFIJtZhp9fdcN/OAJOD6MGV?=
 =?us-ascii?Q?j7Vf54THbv7ZKDzRixuOVqPda3SD8F/tN29jX3RUvOHfp66+I89P6bIp/UjA?=
 =?us-ascii?Q?MQdhF7RS0jkZ2jumwMdC+1w0jGeOq5Fzw5WSRefbNb6YAxpI4o0tSSL70FUd?=
 =?us-ascii?Q?4KOftOVnXaZ81hp6kAruV3u/m3MbCJBOjocn3t4of77jAteR6JhpZF96x8yW?=
 =?us-ascii?Q?yKABQb8Iqx/o22FHcNcASf1ZMPjFMsqZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1nmXRufR3bPaz8w+TeNERgIqf3ZTSAGBqS+VZO5c94K4ePKGpQQkrF9QjUKU?=
 =?us-ascii?Q?O2OIVDx66fo6fqXCKV7ehPAcWe6F29V33uC+mwSYt65a3RyejHzZ9WWTf4rS?=
 =?us-ascii?Q?ATafzMwiRPCNCgLrDq+Jn0lgTRf6vVHiLzbW3PW4DZaA/4ehnLJ37dmo7LMZ?=
 =?us-ascii?Q?OJuklPRkViixRdJSp3KQvh++IQ23oztLR5NTkTevCKfojfpo8xHiXZ8okUKH?=
 =?us-ascii?Q?TEWaj1awKlb2AdNuEnkJmFTy2rkAgK+jqhCPVQCN06Rvh7nUygVVaG4C9rCr?=
 =?us-ascii?Q?cZonogrKqwSuG+edCNAnsOz/KaWyqKE9Tonz6gNQ3/EvYzuwYiqrLq3HmQxu?=
 =?us-ascii?Q?FLL2mXcH/y5VTyi6uN6rbprGEfOsJpoxO0VBaOXyykHWBfXfhrWLVUajC5X5?=
 =?us-ascii?Q?aDHZUptSqaUQa0orvg7LMyz6sQbG0ijfSSv7M82PxN6mUiyUrJAruCi6hjBW?=
 =?us-ascii?Q?5O7DbgPb6a7BxU+lcMtuailLAcOQOyhUVlQpN4yENArHvVRkd+uW9Zh/X8yY?=
 =?us-ascii?Q?PIlBxoaaw8LGKX3p4rly8UvN3h+tFAQt/uGHzBQ+1ca+Lrd6SmkV7is83mie?=
 =?us-ascii?Q?AGjuPMs3YWDYy1sLnnhiwMDsA7VlTxmc99q+rlnq9zLimHdoPLORfdsITD5Z?=
 =?us-ascii?Q?DZ4LS6Ii3MktaMphEJ+YXFm6rm4JukDUw/ZYjCd7IpEyDFnchFKZh4sDnikB?=
 =?us-ascii?Q?uNpSdBYKPdUqfp43pNmpKp6gwEn4nH2Rp5h/h36LqP7hJGIxRrCGCWwYvsmX?=
 =?us-ascii?Q?v2OkFWiWjTnzDyZU3FHTW+b6TmpemniMp5mGfI1oh19FfVnC4FgcaIz/MUx9?=
 =?us-ascii?Q?4PS7rTqacOJQentlI5ksOWvO+3Mbjz7y6fu+qJPKT/K4qag7uEFvMIrpopP2?=
 =?us-ascii?Q?/eRpyxWNxqrzwu99kggVny4VV29GyEYrYguMd+Ukxtn/VKrXbdkTH9PZkvKE?=
 =?us-ascii?Q?K5nbYy3xTY2VhVflViknxwCP7GwPlkb3D8Hn0YcFr7E7dz3L5uSHaUiJArWU?=
 =?us-ascii?Q?Vtmlm26WPVkB/6h0ffF1aCgaKO9wvlwbZEnrTOPaT2D5a2IRqGFeYUtW8k28?=
 =?us-ascii?Q?AvyVoYvdyKwcdDAvGhXb3rummNSfi7tC0bbpkW8GYB0mXO10hMjooTzke2Il?=
 =?us-ascii?Q?0PQu8F0LwE701XgXz1NtQERL5kklklqN2gwnQlBVnvvAGtWIshuMv4qwOyUc?=
 =?us-ascii?Q?JwZ8u3Y0nsJZyf11NuA3S9Bl8uX5VHds5C8FTyFtBojvB0JzgZUViA2ZBFo9?=
 =?us-ascii?Q?ppu/TiPCmClkMA3Q084fMsC0ouv8jgW2CEttPUAXJcSSjolFBX0iarkgxKOf?=
 =?us-ascii?Q?Qsqmh/0uH1vamwGBK0aKr6SmzWXoSPbGHIBZ6MvpUG1/uzuLnMh4bYoybR1+?=
 =?us-ascii?Q?6r8QPGHPWM4vKn421fZQcVmsbUchMHz+2lZfinP5leDdvFQv3uKVxJ5wmr0q?=
 =?us-ascii?Q?52KuOwnnRoXJQIKmriJvi73To8f0MZsb5Le0dH2OwhGKnw4r1U9sGxPKJFvZ?=
 =?us-ascii?Q?eP2fMKNDdCp2X4DUV7wIBvII2IVr4fjOprcnOEniIGNsHXKunD4mqpNCh+lZ?=
 =?us-ascii?Q?DMle1hAxgnq5UtO8VP4fa6G7R2dIlGVAkqC/BSg9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939b2854-f2ef-41d2-74ed-08dd562afa41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:01:14.3604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dVWn4N4oufa22cWOwyy9U6m2ARDLz66S8KgoX+ukp4XuLTLGkoRifyje6ogJvQ+gDq8+K+rGOTP3tw63d0RpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, February 26, 2025 13:51
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add support for xgmi_v6_4_1

Add support for xgmi_v6_4_1 and use it appropriate places

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 49da137d42c9..e180803b67a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -315,6 +315,7 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *a=
dev, int global_link_num)

        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
                xgmi_state_reg_val =3D xgmi_v6_4_get_link_status(adev, glob=
al_link_num);
                break;
        default:
@@ -1205,6 +1206,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_de=
vice *adev, struct ras_comm

        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
                r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL=
,
                                        &xgmi_v6_4_0_aca_info, NULL);
                if (r)
@@ -1264,6 +1266,7 @@ static void amdgpu_xgmi_legacy_reset_ras_error_count(=
struct amdgpu_device *adev)

        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
                for (i =3D 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6=
_4); i++)
                        pcs_clear_status(adev,
                                        xgmi3x16_pcs_err_status_reg_v6_4[i]=
);
@@ -1298,6 +1301,7 @@ static void amdgpu_xgmi_reset_ras_error_count(struct =
amdgpu_device *adev)  {
        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
                xgmi_v6_4_0_reset_ras_error_count(adev);
                break;
        default:
@@ -1323,7 +1327,9 @@ static int amdgpu_xgmi_query_pcs_error_status(struct =
amdgpu_device *adev,
                if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D
                    IP_VERSION(6, 1, 0) ||
                    amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D
-                   IP_VERSION(6, 4, 0)) {
+                   IP_VERSION(6, 4, 0) ||
+                   amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D
+                   IP_VERSION(6, 4, 1)) {
                        pcs_ras_fields =3D &xgmi3x16_pcs_ras_fields[0];
                        field_array_size =3D ARRAY_SIZE(xgmi3x16_pcs_ras_fi=
elds);
                } else {
@@ -1431,6 +1437,7 @@ static void amdgpu_xgmi_legacy_query_ras_error_count(=
struct amdgpu_device *adev,

        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
                /* check xgmi3x16 pcs error */
                for (i =3D 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6=
_4); i++) {
                        data =3D RREG32_PCIE(xgmi3x16_pcs_err_status_reg_v6=
_4[i]);
@@ -1527,6 +1534,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct =
amdgpu_device *adev,  {
        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
                xgmi_v6_4_0_query_ras_error_count(adev, ras_error_status);
                break;
        default:
--
2.46.0

