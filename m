Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288CFC54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 16:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B73010FFBA;
	Fri, 22 Mar 2024 16:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQQ1jGOJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9F9112172
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 16:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B931fucXOnW+Q4E1jQRLjl6ovDf81A9/2OBUp2hfsbtmz49vUQHsTsbJH5hwKQhDXDqiy5f6xWiSJ1fg/YsmndT0kkMnKLbrwLBAcYke1IJfJUiFLd9W5dhBOdMZ38pf6jfysIjKgZaq1B/FLbDKYb6uYOvS7JcsZjXY3GgrACjgD5uh0tULfV9LqnyXzZJ3MEADyLY2BJRtl1w9VhLmZNn6NIM+R9IWgyWb3cjytXxVkZU/etcEWLslE/bLBNBMOZubyJfYlCQL3hbCPAJVKnuHF1dnspbqG5DoBLlNfGtCL81ZyJu6MZLG4F8+TTfjnhqdd6Q6MFnF7QkkQdJJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+DWu7EizkbdrMK/o9fQ0qPbke9/gSsEJ4ZcQ+U7XEU=;
 b=IAJb/M5qXxXSp1n8eo3FUEXHKfjSEc8Zbkv1WKO/icIfvsemlmk7hPtcfVFKtxEigLwjlxGCjpmmGAQyRiUghBuYrGF/PR6fyHaccdRGv2gQhZDImkpjUkrrMsdvEIck+giVy8YJruU1OyG3JHaBmvvCBT6vboRMoZwaNmbMRaTPcjw+fHYjCWXB59Rup8ABBa9CS5eVJTyd4bWIuywwzqG62VfPWVppIkb+UulYhHwLa7ZQbx3txlRgXakk5BvbNTueJowvnRDMqdWmszCouxx/dKFqrUKI0iVCoWXpJyJZltsXLChAN6w+wh2hhh10H+9dIRMWJTkFqmPBZQ8nnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+DWu7EizkbdrMK/o9fQ0qPbke9/gSsEJ4ZcQ+U7XEU=;
 b=yQQ1jGOJryKJ0JI39w/Vp4V8SbSBSfIU9PMUuHyVlkAQYKexIcRAFJ9kPoM6OJF0eAQaKQbWjC9TCqJSTijG/QJ5+tBJQaj05j/G5v0eXyAhyN0tLf1y4OKxxuQ/gm5tKCx+Vc/dvDLgETWA3zs9ZBHXSPuiqLGshWe7BhMlz8I=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Fri, 22 Mar
 2024 16:31:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 16:31:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable UMSCH 4.0.6
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable UMSCH 4.0.6
Thread-Index: AQHafAQ7ro2F1YW3IUqPhdH4e8humbFD9I78
Date: Fri, 22 Mar 2024 16:31:05 +0000
Message-ID: <BL1PR12MB51448D728DC4B7BFDC38C36AF7312@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240322025314.3104595-1-Lang.Yu@amd.com>
 <20240322025314.3104595-2-Lang.Yu@amd.com>
In-Reply-To: <20240322025314.3104595-2-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-22T16:31:05.586Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH2PR12MB4133:EE_
x-ms-office365-filtering-correlation-id: 32a6d349-3845-4617-3f66-08dc4a8d78ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PVHdcm+7Tl4FXQ9C3FlsDQzHdj4X/X/sY14Qd/t7oC01FHktByUkLcGPecNitvsFiAF3YChtDKpN/E2xFbnwCdrFZLALGcGXA5F31iANv/y6eahcB7vtcSl+jV2AGtzj3x757c6Lhsr9Mh6p5F/4LVie8FUsCZl0mkB1je+DE0K97ZBhfqpUTOHQKBaeS4iKCMffh6uJ8mNc83wwt2aUhEKjdJfTavvW/HcFbJpiK3XqT7HzdNcD7bX17w5niJ84LVE6rIt3pNfztuGNEuGucIB6ncdE5DPsLN4O35Rq4rM3rurJAb8QjmT2FyR6JhdfNBIb7CqQMaDnLi+IQ7lBlUvE6Z+TGhw72+M7CLJh4MG4wbHL1dDf9o+eAb+5Xi7ACd1YiDX1SpV6AXmh+k5EME3sJ1LvTM5LSbCuZJ6CkXYEnkJT747+qAkTlwNUdz6aiJDsecM4O/qqSqwMZ0IHuJvmmEXkP4gjI9kD+m2l7ilQUFliqN2L/KI0pDixnkbBb9C7POC3FGDE3ZPbiRx+R3O4wRXVn7Kxz6HUzki41J5TRNkz0dGSM8CtobO1g2soGNUHgpxyfL7p6yGbYjncQPBbn+NWAjzCspDKuSLsYq7iJ5omkQMtpLjC2g38ktc07OHH+v9ZUD3EeaOsteIpOHvZ0dO57CryhuWM1wRs+9SsBvpEQN6czqNF1aPHyTXrgiHc+UAqZkbWNUozwLnPv2/5XIxyDxwqNljgeHysYE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i0qXq8g+q0prNIJVnxE7lBCCynI6ksOslHct48bHESWWpxY2rxAQ2JXj/rqN?=
 =?us-ascii?Q?sJIxm6ROy85CLZayOyoS1v99uN/LnjIMB+3kwOxnbf7CNo9gb3+5gSTpV4Hz?=
 =?us-ascii?Q?QOOl8iQLu4GYPBFDCG58gXJL1fvC3aI1GKRkwVQFoJVnITxY6gN5nB7GvtSv?=
 =?us-ascii?Q?GTxC7inETgEEBJClQOVRbweZSpZUUdbnS+OtuPyBxNq715q73s4sO2Wf6+ls?=
 =?us-ascii?Q?ZcdR5gzSB62xr7dynTmHmzAZ/ivUzxBflWcfEHth+V/tHTTo1qhTrthw4SDt?=
 =?us-ascii?Q?KSGNA5HM9NRyHBjU7XSPyvj84LetvJdqarqJdEOjwCb9+DiTSSx3udTYaWUq?=
 =?us-ascii?Q?gN8oUumRRf1rA3/HJ/KmJyZsXxtPwgHivqK6VcJ2QeVVqfLOr0JIQDYPhHAb?=
 =?us-ascii?Q?Sekm95oqtZJVkd8qIv5yeJoiygtpO4k91P6AZ2WNYH0y/0UBvj2uaAX0KlhY?=
 =?us-ascii?Q?ubyQQjf4Od7/FN1S/Wx1QPDc+vRyF9o+7mAYpYUvTW2FfXRQKoWDo56xpnWO?=
 =?us-ascii?Q?r4KsDXxjnc71j+qnV2QbcNqLNxlF3Yqd+d7zAlGKxOLCE/TJ1C/daK3uscZZ?=
 =?us-ascii?Q?J9Pt/4oujotOXQjP3t/FXv/tM0J3R+bJ2NVvo+PyIWr6QOcXvZ5+KmI13slZ?=
 =?us-ascii?Q?6MZxu6HWaHkRobnvRudWINCe4lIgBw9XePvjO/zMLVYFGmGCzg0/L2qseBr/?=
 =?us-ascii?Q?fAjrJ7FUI1WbPHtMbI9zl3WuVLIy4dB88Gux+W/iLOn/W+nzmeTVBcaqy6Xb?=
 =?us-ascii?Q?DCJ0Blf66aKWLeagYQXpvNtYT+x1zCgw3Dl6IL1GUlVo86jRMvla4PeVKT4F?=
 =?us-ascii?Q?kFxPRFf1T7hvnIig5yuJjOaYG2X7bgpBO7LmeHYQ9MDWzJLDBH4TqNM8SSLS?=
 =?us-ascii?Q?SJbz7iUrue4LSmNqnhLTfskNmTLMp6BMvrGH90WmynWLVaZlqPItxzFce9fr?=
 =?us-ascii?Q?zNAkSDoU/4b2mzOaL/K7HTXiIScJkwV08+EkeHml+V3VpnrVAsmuDAwv0jHS?=
 =?us-ascii?Q?9nseciPojQs01Y4fyxTRyka/9ET/TJTCxcuqVbb7teU8Vh3vtw0Vjy3aiiCI?=
 =?us-ascii?Q?9ux2Mi9ArxiRM8pCFhxZBbCww6hzxTyjHO5Ozl16dEYT6sejpshpYiT6J2ud?=
 =?us-ascii?Q?7ddOvWJlfXIW5UIX6k3OCjleqGfYwPJO3wlE8OJ79KrvRZl2AAtvjyCZfsRl?=
 =?us-ascii?Q?d/iozj9YehZNp6771tQsr9qOhWyhbFTrrPUpBnyyN/oGuWXrdqktjPQk+3hS?=
 =?us-ascii?Q?Fs5JK9h1BK8/sKfFXQs6Ov4v19CBmAFKiWtPjBb79hY8/9swUsbdb+CNsH2N?=
 =?us-ascii?Q?QFYulTYo1dyaogiOLFnYmLEpPndRW1o3S5Go8e7PHzTeM8EJTC+0d1qSYUqN?=
 =?us-ascii?Q?ogr390e02HjWQX3TGnEf1c5eXT9gxxvHSuU9rwLQSeQsUEoR9ASzBSZqPtjN?=
 =?us-ascii?Q?1JYOK2H9egP0k+DBdgOzBZr3DIMjEJbbbFVDjTibCoqv1CvW+FdBlf2J5r4S?=
 =?us-ascii?Q?hQi2bB8/QGh7wRKm0H/C62MdofdCUTaPsZ/W1IPsfgp9Bkgc5Io26MI+3eu/?=
 =?us-ascii?Q?JJ4D2qTpGF094WNYJv4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448D728DC4B7BFDC38C36AF7312BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a6d349-3845-4617-3f66-08dc4a8d78ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 16:31:05.9134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6hCxqDc4/M0/EUbR8bHSRFFRl8Hd2sw3quABe7V1cucM8myRSCqyqXIXdE0s/pmJLK/ViRvPaU/+UFv2CF3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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

--_000_BL1PR12MB51448D728DC4B7BFDC38C36AF7312BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lang Yu =
<Lang.Yu@amd.com>
Sent: Thursday, March 21, 2024 10:53 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Yu, Lang <Lang.Yu@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veera=
badhran.Gopalakrishnan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable UMSCH 4.0.6

Share same codes with 4.0.5 and enable collaborate mode for VPE.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  7 +++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 3c407164837b..07c5fca06178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2247,6 +2247,7 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(st=
ruct amdgpu_device *adev)
 {
         switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 5):
+       case IP_VERSION(4, 0, 6):
                 if (amdgpu_umsch_mm & 0x1) {
                         amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip=
_block);
                         adev->enable_umsch_mm =3D true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 99210a3b1044..95f80b9131a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -189,10 +189,13 @@ static void setup_vpe_queue(struct amdgpu_device *ade=
v,
         mqd->rptr_val =3D 0;
         mqd->unmapped =3D 1;

+       if (adev->vpe.collaborate_mode)
+               memcpy(++mqd, test->mqd_data_cpu_addr, sizeof(struct MQD_IN=
FO));
+
         qinfo->mqd_addr =3D test->mqd_data_gpu_addr;
         qinfo->csa_addr =3D test->ctx_data_gpu_addr +
                 offsetof(struct umsch_mm_test_ctx_data, vpe_ctx_csa);
-       qinfo->doorbell_offset_0 =3D (adev->doorbell_index.vpe_ring + 1) <<=
 1;
+       qinfo->doorbell_offset_0 =3D 0;
         qinfo->doorbell_offset_1 =3D 0;
 }

@@ -287,7 +290,10 @@ static int submit_vpe_queue(struct amdgpu_device *adev=
, struct umsch_mm_test *te
         ring[5] =3D 0;

         mqd->wptr_val =3D (6 << 2);
-       // WDOORBELL32(adev->umsch_mm.agdb_index[CONTEXT_PRIORITY_LEVEL_NOR=
MAL], mqd->wptr_val);
+       if (adev->vpe.collaborate_mode)
+               (++mqd)->wptr_val =3D (6 << 2);
+
+       WDOORBELL32(adev->umsch_mm.agdb_index[CONTEXT_PRIORITY_LEVEL_NORMAL=
], mqd->wptr_val);

         for (i =3D 0; i < adev->usec_timeout; i++) {
                 if (*fence =3D=3D test_pattern)
@@ -571,6 +577,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_=
mm *umsch)

         switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 5):
+       case IP_VERSION(4, 0, 6):
                 fw_name =3D "amdgpu/umsch_mm_4_0_0.bin";
                 break;
         default:
@@ -750,6 +757,7 @@ static int umsch_mm_early_init(void *handle)

         switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 5):
+       case IP_VERSION(4, 0, 6):
                 umsch_mm_v4_0_set_funcs(&adev->umsch_mm);
                 break;
         default:
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c
index 8e7b763cfdb7..84368cf1e175 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -60,7 +60,7 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_ums=
ch_mm *umsch)

         umsch->cmd_buf_curr_ptr =3D umsch->cmd_buf_ptr;

-       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(4, 0, 5)=
) {
+       if (amdgpu_ip_version(adev, VCN_HWIP, 0) >=3D IP_VERSION(4, 0, 5)) =
{
                 WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
                         1 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
                 SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
@@ -248,7 +248,7 @@ static int umsch_mm_v4_0_ring_stop(struct amdgpu_umsch_=
mm *umsch)
         data =3D REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
         WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);

-       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(4, 0, 5)=
) {
+       if (amdgpu_ip_version(adev, VCN_HWIP, 0) >=3D IP_VERSION(4, 0, 5)) =
{
                 WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
                         2 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
                 SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
@@ -271,6 +271,8 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu=
_umsch_mm *umsch)

         set_hw_resources.vmid_mask_mm_vcn =3D umsch->vmid_mask_mm_vcn;
         set_hw_resources.vmid_mask_mm_vpe =3D umsch->vmid_mask_mm_vpe;
+       set_hw_resources.collaboration_mask_vpe =3D
+               adev->vpe.collaborate_mode ? 0x3 : 0x0;
         set_hw_resources.engine_mask =3D umsch->engine_mask;

         set_hw_resources.vcn0_hqd_mask[0] =3D umsch->vcn0_hqd_mask;
@@ -346,6 +348,7 @@ static int umsch_mm_v4_0_add_queue(struct amdgpu_umsch_=
mm *umsch,
         add_queue.h_queue =3D input_ptr->h_queue;
         add_queue.vm_context_cntl =3D input_ptr->vm_context_cntl;
         add_queue.is_context_suspended =3D input_ptr->is_context_suspended=
;
+       add_queue.collaboration_mode =3D adev->vpe.collaborate_mode ? 1 : 0=
;

         add_queue.api_status.api_completion_fence_addr =3D umsch->ring.fen=
ce_drv.gpu_addr;
         add_queue.api_status.api_completion_fence_value =3D ++umsch->ring.=
fence_drv.sync_seq;
--
2.25.1


--_000_BL1PR12MB51448D728DC4B7BFDC38C36AF7312BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lang Yu &lt;Lang.Yu@amd.com&g=
t;<br>
<b>Sent:</b> Thursday, March 21, 2024 10:53 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; Gopalakrishnan, Veerabadhran (=
Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: enable UMSCH 4.0.6</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Share same codes with 4.0.5 and enable collaborate=
 mode for VPE.<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
Reviewed-by: Veerabadhran Gopalakrishnan &lt;Veerabadhran.Gopalakrishnan@am=
d.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c&nbsp; | 12 ++++++++++--<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
7 +++++--<br>
&nbsp;3 files changed, 16 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 3c407164837b..07c5fca06178 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -2247,6 +2247,7 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(st=
ruct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(=
adev, VCN_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 5):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 6):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_umsch_mm &amp; 0x1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;umsch_mm_v4_0_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;enable_umsch_mm =3D true;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c<br>
index 99210a3b1044..95f80b9131a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
@@ -189,10 +189,13 @@ static void setup_vpe_queue(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;rptr_val =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;unmapped =3D 1;<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vpe.collaborate_mode)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy(++mqd, test-&gt;mqd_data_cpu_addr, sizeof(struct MQD_INFO=
));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qinfo-&gt;mqd_addr =3D tes=
t-&gt;mqd_data_gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qinfo-&gt;csa_addr =3D tes=
t-&gt;ctx_data_gpu_addr +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; offsetof(struct umsch_mm_test_ctx_data, vpe_ctx_csa);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qinfo-&gt;doorbell_offset_0 =3D (adev=
-&gt;doorbell_index.vpe_ring + 1) &lt;&lt; 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qinfo-&gt;doorbell_offset_0 =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qinfo-&gt;doorbell_offset_=
1 =3D 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -287,7 +290,10 @@ static int submit_vpe_queue(struct amdgpu_device *adev=
, struct umsch_mm_test *te<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring[5] =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;wptr_val =3D (6 &l=
t;&lt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // WDOORBELL32(adev-&gt;umsch_mm.agdb=
_index[CONTEXT_PRIORITY_LEVEL_NORMAL], mqd-&gt;wptr_val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vpe.collaborate_mode)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (++mqd)-&gt;wptr_val =3D (6 &lt;&lt; 2);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDOORBELL32(adev-&gt;umsch_mm.agdb_in=
dex[CONTEXT_PRIORITY_LEVEL_NORMAL], mqd-&gt;wptr_val);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;usec_timeout; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (*fence =3D=3D test_pattern)<br>
@@ -571,6 +577,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_=
mm *umsch)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(=
adev, VCN_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 5):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 6):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_name =3D &quot;amdgpu/umsch_mm_4_0_0.bin&quot;;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
@@ -750,6 +757,7 @@ static int umsch_mm_early_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(=
adev, VCN_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 5):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 6):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umsch_mm_v4_0_set_funcs(&amp;adev-&gt;umsch_mm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c<br>
index 8e7b763cfdb7..84368cf1e175 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c<br>
@@ -60,7 +60,7 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_ums=
ch_mm *umsch)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umsch-&gt;cmd_buf_curr_ptr=
 =3D umsch-&gt;cmd_buf_ptr;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, VCN_HWIP,=
 0) =3D=3D IP_VERSION(4, 0, 5)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, VCN_HWIP,=
 0) &gt;=3D IP_VERSION(4, 0, 5)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt=
;&lt; UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,<br=
>
@@ -248,7 +248,7 @@ static int umsch_mm_v4_0_ring_stop(struct amdgpu_umsch_=
mm *umsch)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, VCN_UMSCH_RB_DB_CTRL, EN, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, 0, regVC=
N_UMSCH_RB_DB_CTRL, data);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, VCN_HWIP,=
 0) =3D=3D IP_VERSION(4, 0, 5)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, VCN_HWIP,=
 0) &gt;=3D IP_VERSION(4, 0, 5)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 &lt=
;&lt; UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,<br=
>
@@ -271,6 +271,8 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu=
_umsch_mm *umsch)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vmid_mask=
_mm_vcn =3D umsch-&gt;vmid_mask_mm_vcn;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vmid_mask=
_mm_vpe =3D umsch-&gt;vmid_mask_mm_vpe;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.collaboration_mask_v=
pe =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;vpe.collaborate_mode ? 0x3 : 0x0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.engine_ma=
sk =3D umsch-&gt;engine_mask;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vcn0_hqd_=
mask[0] =3D umsch-&gt;vcn0_hqd_mask;<br>
@@ -346,6 +348,7 @@ static int umsch_mm_v4_0_add_queue(struct amdgpu_umsch_=
mm *umsch,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue.h_queue =3D inpu=
t_ptr-&gt;h_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue.vm_context_cntl =
=3D input_ptr-&gt;vm_context_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue.is_context_suspe=
nded =3D input_ptr-&gt;is_context_suspended;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue.collaboration_mode =3D adev=
-&gt;vpe.collaborate_mode ? 1 : 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue.api_status.api_c=
ompletion_fence_addr =3D umsch-&gt;ring.fence_drv.gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue.api_status.api_c=
ompletion_fence_value =3D ++umsch-&gt;ring.fence_drv.sync_seq;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448D728DC4B7BFDC38C36AF7312BL1PR12MB5144namp_--
