Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63910E77180
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 17:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0555010EBB8;
	Wed, 11 Dec 2024 17:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijrKw7yT";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8310110EBBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 17:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncvo5foJfLfoJfhp/ypY/5ohq1lIYk2UCMN/+2W4ucDygNsztpdGoTkOm9N/h4kt0w8UUShMZRvbQo/w206MBaKXzNJkeCq6Jo35tXCqo8ieKn3R9GoFpT6seFs8BHPEUNShc6fM0m+cmBS3nLD6xOuceSVwdihDExF6t4sJ9yK8KyB+qYrfx8fNgoybovD4zy8M2ULYLOn2+VY1ziMQNXWCvjZLL9riwNUVGxW1o7nM4ql8uOIfyYtTdYQMcYnrjA13gBuIBlBr/ojiMcPHzfErspIUOsO9HHQTzqurraXb7Y9f+W27hpgFrMj08ZdloiOsENun00YeDBsWEOWWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao6SGErJCoq+d/mIxekcBlo/5rru7gzQbExF8ZuaZLE=;
 b=FNX0HkUOI1U2axqRTBjwaPy2ginT94XSPoY6ha5meWkyGr7MomT8qo4JgCw2sgnU9IId4hWsPFEBeZh6xMJcTr8jlgqnfM0KebajKryjYzqb7TpdLo2dkkrtTtgvwRH6hGmHa8OEdd7OMZ0KXcI0EP24jiVR3UP6m54kAEB3Vd5s6RcpSZfhYmH0/TEoy3k0P8n6BeOvU2iq3tublY1fw4Jdo5jFQuiyeZQU2YasS1BIbIzQOZPEquhWLXvQZiDRR/Q6RFHsGXDjApSMI0OfLL86iQUSxz/TxVx7W9HyUmXwkMSoYK727iXzJqi7ZnACI0k2YjzQsS5D5GJzdsYcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao6SGErJCoq+d/mIxekcBlo/5rru7gzQbExF8ZuaZLE=;
 b=ijrKw7yTmJoiEGIz9slJGLfl1hDZDJnOG9q0gbh8Ph/D+bDVgd/BO0eH+fe2kit0z9hpDnPJCwra9abghMzgKlPe/Q32Zqk/RjPWj/7FWUYkm1zqStRaLt/8BLD9uLvk9w9ceA1qeqjrrV3UKrHfJIbx0DpNHBFHi/8nyJWiKYQ=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 17:05:56 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 17:05:56 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/jpeg5.0.1: use num_jpeg_inst for SR-IOV
Thread-Topic: [PATCH 2/2] drm/amdgpu/jpeg5.0.1: use num_jpeg_inst for SR-IOV
Thread-Index: AQHbS00esa0dIYT2R0ariWf9DGpv9bLhRqIQ
Date: Wed, 11 Dec 2024 17:05:56 +0000
Message-ID: <SJ1PR12MB6194DE9DF0C50E0C7F87F626953E2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20241210214703.34668-1-alexander.deucher@amd.com>
 <20241210214703.34668-2-alexander.deucher@amd.com>
In-Reply-To: <20241210214703.34668-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2862d36f-967f-4bfa-a916-7d5b36439f2c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-11T17:03:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SA3PR12MB9107:EE_
x-ms-office365-filtering-correlation-id: 0c85312d-b51a-4ccb-79dc-08dd1a0613da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9YiIQWjUhzBooMWwAYqjmkGUCDyt2J3w5ZhVdlrvINYGYE5MvmyfJgqPhH7Q?=
 =?us-ascii?Q?gukhK79SXvQL6u47QRhLzZO38c37LRWAN9kM/2iBT8ujLKVR9kHSrs78CBGM?=
 =?us-ascii?Q?mv0GzRx+gef12JznxsAXtssOubZBR1sTIAInaSWS+eRgT1NwAvl0nqLYizn6?=
 =?us-ascii?Q?PKBq+ESv9FY7lCLbRZTpzjEj0uAjDiy3uzrXGvr72vLjOqbPVqWSyiBtal76?=
 =?us-ascii?Q?+XovkKFvw7jozUBalU3TXH0fspw+AN+1P4mRmO+Q/DP+cMs2yOt1kHWibIMd?=
 =?us-ascii?Q?5HheXbtJobZVgj2xhtYob6IINHXM6iFp7OZAUbHh66SQUPD8yZ16uAT4gO3q?=
 =?us-ascii?Q?Sq/BNSLVxk5k9wWpWdFzpf8BUDt3aCv8VqKB25Zcn1Y3iNuoLEEdbtZGN9bz?=
 =?us-ascii?Q?hq68aznk4SYVb9BOycImBUA0ZvylY98HAzAsI35mdMKb2ubobgcqm3FZXPmE?=
 =?us-ascii?Q?avcKD6zxwHtmyxgrVa6ZUQo3AsOiRTu8KiIrWFurqjHUvu0dO5cem7pLAIur?=
 =?us-ascii?Q?EnkZaFOCSywUGP0TknFXNifJPKr5kYCfIwbxJ9DPy5RWw215zzAu+IHUn2qF?=
 =?us-ascii?Q?1ZhhaEHEI2K36+UzkwDwmLuFAiB9Oly68o6MtbAU6BIG+W75KW/9k825bu1c?=
 =?us-ascii?Q?Al4b9OWBptzGZxtRa1NsscOJVxSwSM7fT53Cnt49YoaiDAM6Nez997qenXep?=
 =?us-ascii?Q?6jnGQkEoTS7YzBUllekcZJJweYqRl80YQ+ZtRExU/5BOWGB3QiRXcJA6Xbon?=
 =?us-ascii?Q?iPIXrYZqysyh13CDOTrZKJCs1lfFowA02x9o+DQlSasTARuR2lTqMOvXqeXt?=
 =?us-ascii?Q?vSwks8cFVzUabEMjMhrFR0SoQzuir/9G3FBNiVanXCyaN480FiTqkgQry0dZ?=
 =?us-ascii?Q?DR0CBr7U4gtIqalW/VCQfw04jbsemgiS0qRC9H/DNuAxiaMfl3jIjY3JxJL2?=
 =?us-ascii?Q?yudEN3JQ7zkROFHws6wQSJ8oHTAe3OP9WZoCVZO4g09UasEb58l55k5CN7zQ?=
 =?us-ascii?Q?/XvNDba99dTwAcSNpRGlygzCaO5FWqJLcWKQcyx1ZdUn3Ruta0BqYh6kNBDC?=
 =?us-ascii?Q?ZFG6kDre36R93p0IuJlK03vtz9rEyUz8ZnQkaIUeSDAYFMYCHCSptq+VZFTx?=
 =?us-ascii?Q?jleO38BMfxi9IFnIo9YDHH5R0xur99bfVvQiOSTT0QxAxNdlZDkMzoSJTczc?=
 =?us-ascii?Q?mtN6dFcmP49OmTB8pOJmzfVquvXxV4FWkjXf5Uh4CA7fCo/O/IHZkM61dSyd?=
 =?us-ascii?Q?8WIEgxCDFZnnruTBlOdi1g8JLN9416iaY7rbhQt7R+jlm+QqRAPBW1zli5SQ?=
 =?us-ascii?Q?CBQUZrzZKrjUY2UpeKISnjw5af/8y1pcDBwlBr3WCb3xc/lWje36pG1B3mc1?=
 =?us-ascii?Q?io9p3fk+ajQ6UeCM2MX0zWA7oCGt+AhO5dKcUfKzrC3VabPN+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kHRA7JefoRxE1Z2dFhZKlWluxSPC5w8+Pff/VM1caf/znfLPhqaFvTfCMeNv?=
 =?us-ascii?Q?Sqosij9csRQLYhTJQBrkD9gGnymv+8DlMkOSlvrYix0KWtdMMlFgF2hUUgwU?=
 =?us-ascii?Q?3ByYMkaW9d1R//YOftQj6CHhi4Y836cFtcUW8J8VvUEwwIapN7DwzEzfTgad?=
 =?us-ascii?Q?rIk0OQSkx4NnzAebIrNvDLmlDKMD8YyqM7UM4DvThRhBlJCXLVrgFewJ9IUg?=
 =?us-ascii?Q?CRH6xT5wbLL8w4ptMMDWrG4pjRoDnQpXYfqfFaD5JWpLiFpwcJAKzop/CfyT?=
 =?us-ascii?Q?l3dW+OnojNQAhoxPH7bDTU8BQaNNgoEFQFOtae69yRWQbj0TTSmNnFWBL/dI?=
 =?us-ascii?Q?ygAb0f+xB/R/MgZLPOsN3yb7mFfo9MnoypiQCdVWZYPenCevk4H0B/O+9TFK?=
 =?us-ascii?Q?0EmPr6/wPpTiyz1UnL3e32kvelDpnSPZnnYf3p/Yv0YDjzFYzoL5gY5MYX+e?=
 =?us-ascii?Q?GGfyVB7rUe1bYnwtb7PUAgNtZa7kDQvAfyoNZEzEs0bYNSpip2bB50nOAdC4?=
 =?us-ascii?Q?9VjRY/UaQlehFBRYYmiWyvVg/GVaoZvGUYTN0lF0meRvo+dCVazF7s0BnfPf?=
 =?us-ascii?Q?ODhn/xjTna+J/y5SbgZtxijLNTNAgYd/c57YAIVeZKti4ticqAHSqvB9Egju?=
 =?us-ascii?Q?BJAm1BWCcTecH/Fnc/QRvB0n3izqlqm7UNOieUviTYNOhIc2hXJSFgGAqUcD?=
 =?us-ascii?Q?Xq0iD7QJuMGIFdBy4w9Zwn3pdr6wDE053myEvNSA2GCP7vie4q3MYChR06XL?=
 =?us-ascii?Q?/J9P6El5zyNmnnitNMcS4cIITSb6p6q+hZVRO09ZBc7SbMCeqcmlyIwUI/dh?=
 =?us-ascii?Q?+TwBSyWypHX7quNNWswInZyUbusJSd2GzChMsCXee7LZYh5Qw4OhTDce0L1I?=
 =?us-ascii?Q?2ztey+agTLztHMo8DIFhSd5HRM8vxFGqXPfrr+4ifqBwd1yLHPU4qfUpFZIn?=
 =?us-ascii?Q?GyZkCJ4AWvNkc51MRM3WL8dYzruPQATuSEhQ1nvXCS9GcU2GUkGVhOaxmE6a?=
 =?us-ascii?Q?gmpKz+YSPsq3K57xS96yuEsNYk/oa4mxhbe7gPr+Pb/t6SjIj5ZhvpB6fN+3?=
 =?us-ascii?Q?TgS0U6hQ/PLf/+ceVR4lV2lvK8t+qfA/Mzv1pKw/BH8KBWfz0aR5Ek2304oF?=
 =?us-ascii?Q?WNdFoj5YKnnjCTnTrpmkrmjWQ35UFnOdRTuL0/ObG/Rbckm8W4yuhfnU0q2j?=
 =?us-ascii?Q?YMDszpRXpk7GhZ7W8CQbDDim4RPcxOb+VzvobDixo55BbG3l6YcNbgrG+nkd?=
 =?us-ascii?Q?FEfzQuDxo4kJVJ2A9SV+e0geoVWNsp0Z/9gXSaqnT3tOhrPhrQFBZO9UtLxN?=
 =?us-ascii?Q?MChb0EnogEeI+d/Gu/M75inXnmH6X4R9irIXpvZ7vZNAOMLWWZcXwqp+v9Zn?=
 =?us-ascii?Q?2s3Sb3Hc+0qTPN3n6f2qmUlkdYx23IlZA5mIJA3SjKoejMR74///rUZiV2hg?=
 =?us-ascii?Q?B0NLbtXW9fkjb85RFYb/nEozeAttgIZSLqIoqrLs8x/S9arwa4OYLBtRcfCI?=
 =?us-ascii?Q?3jNq44BhVrdWZlt4pE3coOX9vXmDdJx/j0akxpBq+K38eRr/LxeF/HbUQ5ts?=
 =?us-ascii?Q?FQfSUoxH9jh1IFwiamg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85312d-b51a-4ccb-79dc-08dd1a0613da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 17:05:56.0953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhHtxUY2icD7Gz9IHBMOgXleboomv5sWCsESCABfVaqx8jmU1aU+CMcS+sCJ6c6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
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

The series is:

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, December 10, 2024 4:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg5.0.1: use num_jpeg_inst for SR-IOV

They should be the same, but use the proper variable.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v5_0_1.c
index 8bfa400e7a874..40d4c32a8c2a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -183,7 +183,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *=
ip_block)

        if (amdgpu_sriov_vf(adev)) {
                /* jpeg_v5_0_1_start_sriov(adev); */
-               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
+               for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
                        for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
                                ring =3D &adev->jpeg.inst[i].ring_dec[j];
                                ring->wptr =3D 0;
--
2.47.1

