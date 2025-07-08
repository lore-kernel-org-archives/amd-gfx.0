Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18027C71130
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 01:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868F810E0E0;
	Tue,  8 Jul 2025 01:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/sIVfy6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF38F10E0C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 01:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtXkFzQmLCH55+P6J8Fh06v7Qez8cIyexvNIkJ9QlveuiFcRtqtiOqCX9CtrgNCu2G6IlbUjE2VDeLEkALmdP6vi6yA/NsORTImhG7WDFzrXbRsRrSoXLhIa3njwUybhY/GkzG/KXESwPWUEX+4nETsi62bkRqW4I+9/j0AQtySYkCytJicV0VWIySXSXCjcIOj0uclNmv7wNONSTJtZVxgBc0U7NlFSxt22NjUdYgxR1iVicKij4wQd9GrqvjT/6cwVUIQjBUQ/4sJ9CiNWFIRZF3lbZvg3FCFo5DB+60qsbb3j+kdW9TyxNrsDAWyZ7DdifyVnX+QB/SK1arENWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqUUyH6x9qbsPL1SPEWNDd6CEVJRRgahEPzliBwM+yA=;
 b=jFu8A0+ZHdCMXab1UdyStrWTAXiPCPD/58pldXPVT4IsdFAz8Lpeqlo8xL5tbbRXJCRB4rniTlr2GM9okFpa8NCQw8xmh+mA7zqZPmUzf+57zO03geRUMySVpYb0zTRv7ouap2wvOHnyHsj/C5jXm4ra0f4zPoT7vIkSejgddNnONhWyR/MGkmavMoRD9g1cmVzdaT5sTmRKTbNfm+lkKvK1SLlg/mt0e42NnIAec/cNqYROfLDk6yGTAEyBNDAk2gR505l3FV6HoWM7NJ+89N7FcgQQ9gjBdXaW6pogPozlLH7qHIQnJnmhP1j1nDQR6y4Xg54e/BmN2qBjVCuYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqUUyH6x9qbsPL1SPEWNDd6CEVJRRgahEPzliBwM+yA=;
 b=q/sIVfy6EIOJYSkB+rDBoOPprTnUJ9Ep9sdZA4UG9/vHPvlkoFL5R+I6v1rdQ5cgLZMzQhhVyeVCAfktBiv3vEuhjtXSaxVvjc9j4ny7/n5pWp6Q8rJ/43fHP36YMhWZ849l+/Cqp4L8KsqZ3iXNFVpHKVqoHdLAS0lDrJ//I6U=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 01:14:17 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 01:14:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 04/36] drm/amdgpu: clean up sdma reset functions
Thread-Topic: [PATCH 04/36] drm/amdgpu: clean up sdma reset functions
Thread-Index: AQHb73HzySYn9OrJqkWIXKzZDtb18bQnbE1w
Date: Tue, 8 Jul 2025 01:14:15 +0000
Message-ID: <DM4PR12MB515299DDDBD7E4ABAB3EB3C7E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
 <20250707190355.837891-5-alexander.deucher@amd.com>
In-Reply-To: <20250707190355.837891-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-08T01:14:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB9146:EE_
x-ms-office365-filtering-correlation-id: 3196742e-b365-4c3d-909d-08ddbdbcc1e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sIAfoR/S9gem2yne6+Pu6z9Y99ZbxPhmtZeAdhTYWEUNxYRryMSAG+8FNYZi?=
 =?us-ascii?Q?lOGZx/N8GI8JD9148MmlZIa5QAaMRizGLN58PJarydvFjGQRvGSZzBHLWkBG?=
 =?us-ascii?Q?IXQsgcYdoV4aLFAKNOe3Stua7XRsuX6vAos180PZiTuTgLtvi8iwXQeKXyzX?=
 =?us-ascii?Q?Po2vv+Z7xmwoYMvufUYJKO/noJTKjPw3ozr/YINsgYpnckx2oD5V3wFBaUDP?=
 =?us-ascii?Q?EJjyG+fbU05G/ylrt9Q/nzsmXD1UxZKuFq8z68oIW+aWj0vIaDBYkZlrTIHF?=
 =?us-ascii?Q?bmmINxljF0FIrXKyE+Brv4/75gekIPdkv+jJp9grbxqRPy9JI4Lm19tu0qpY?=
 =?us-ascii?Q?SbTsPumDB8lNiNGAUfmJM1NA5Z6IZuGhan5ZJQhfc56HvE0E0KrM6nEsMgQf?=
 =?us-ascii?Q?3dUdZWrCkkokQxaW3nhs0JlxuQohHfh60TrXLS9ysjrwsAtr9iB9YUpgMO9g?=
 =?us-ascii?Q?lfW0PvuES20uDyXme4Gwe66yZT9twhH1BmDWBaN3TgTngpCz5XRFCIrg9FGU?=
 =?us-ascii?Q?/b5hngIxZZ45VTnRF6dDtHwvJCEVWSHcCoQFWeCamAoyzkTSpwWxq8oEKobx?=
 =?us-ascii?Q?gWImoQe3w2nWt668E4YgEsFo4nrHPbbciSrDDLoI+2iYXcHrBfXkp0PpRIBg?=
 =?us-ascii?Q?4bljurcgp8QwODLWm61dfgAEMG3c5cbD1pm2IrlBZj/Z5C3fgChX/F7cDfOH?=
 =?us-ascii?Q?8+CXk2EVV/LQLMPbMTNRx1fNpaf4yLwUFpg2BceBKcpe8dpD51Ifd14KbOSi?=
 =?us-ascii?Q?qVaRQjHVzFI1yfSQ1sLKPKz6fypRIwmzLb7fIjwMP+yT5VAPN574cK9OL7OA?=
 =?us-ascii?Q?+2WreoYXD/Qd1+DAoXo6tw4oumH8r9O6rMUYqcPihE4VxFiOYhBJ0A1wrOE+?=
 =?us-ascii?Q?1crNI/CZEB3e8FisBkULMSY0xGAR3CzL+pJ/IVmzx2hJVuDMC2JgSMBEo5+3?=
 =?us-ascii?Q?qDxHqNIetGXOIjq7cbuWEa9iH1FnfguINEg0pOpheOr4QCXaF0REtCwtnDM+?=
 =?us-ascii?Q?NMFvilpySgWRgzjihxh5ImKi4dgVA4Iu/1W+vy6FKRR0yLe/0znnghnuT+Mh?=
 =?us-ascii?Q?oxh2SL57B+EfBqqipYOgEu5oBW7fgxpB8fwNwdt7nyXMspdyyqfhMRDr3Opv?=
 =?us-ascii?Q?BoiRzqNpQcW/xSFNHMB2kWDc/djErgfnkL7oRBPQ1R60O4egmCyhB8BezfD4?=
 =?us-ascii?Q?OuFlqnj5h0tVQPTioryuH9rsCTmXVPi05YyUlsQTggUidd5xXv59SD3YUx8+?=
 =?us-ascii?Q?z+/Z5skNN1vmuws2F4oxAKT3alhBkf1fUJ0JXPEJbFLH3wicp/eOWZQMrleN?=
 =?us-ascii?Q?aOTm+7Hfgqsyzp9xYVAjo65OZETmDHQVw/0zmUe0R3qx1dLLP01YizQEIJP4?=
 =?us-ascii?Q?eFK3u2ZM3RlRdZSgD+k63CPjTyBnHrcRdLRQIo6Mofa1pfQ+cVI2+4GoW8aG?=
 =?us-ascii?Q?GnTv/nf+vkpkbomYRPuznO9ApysV8zoXzawuQ60jAvMhCBmVwac6TQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnesAD9XqsG/k7fbWgnNXOBVs7JRlf0++HgfURt1QH1PRcTBVjfNbLkcqvRA?=
 =?us-ascii?Q?iY0QNX4Kn6SpYQ/CvWBX/X4/+to3KHYsovmdbITrb8TBFjMwneoXAIp+RTIA?=
 =?us-ascii?Q?yvn7doF8s9vuhbfKyDuSVQygpE9YY0PmgtYZ5c1gJ7/mrsJf1wlG2NZl5dwl?=
 =?us-ascii?Q?2e+GzUVz1WLya8gze1eC/yppkhhqExAIxCgeC0uQwA5fMA4ZYVBjBSj3tf5K?=
 =?us-ascii?Q?iaHT/Vvzq5St7CHGFQzWlcTl0+zUPGlt1gkZoa7GlQBRSqF2wCTLI5k0zVc9?=
 =?us-ascii?Q?RsEXg3EbKclTtmK9/avC6XmK6U8pvGa5+KDjyhIufg/1gJ5PdIL729APKH9d?=
 =?us-ascii?Q?0k2bFqGhaiQSUuua69N5/LFTURaQCCPKt9Q8Ck7Ewd9dM4wByephiIMOnFoC?=
 =?us-ascii?Q?8I/uWKWQLcU7wmUlB4f93ajnTsY865hda3fBMWxl1vAf5srd2AihCiTi5D/b?=
 =?us-ascii?Q?x/RUISTWwptz8kvF9TLIR39pI75UqB6smDwLL8yABIbVjMKEJVIDXxxl1MZS?=
 =?us-ascii?Q?q2aQSTWPdnAyLmjpH6sjT+7AiO9lZADg1TkOI7QXdNEBaYFfkeS+A9NJhoRD?=
 =?us-ascii?Q?w1WLbMZOpgfVW7yK5r98IcRbK3j69niGsgQaBZnO3z7LgVbmJnQGburKV784?=
 =?us-ascii?Q?hLRWMZ9ZDrKqxlE/IWtIrSbYNWulPOWIrdkP/puM/t0yn0IbVxPBe3EDKN2u?=
 =?us-ascii?Q?H7s/XDafEVOF9CTomsQhFaYSFA5iMSiqx+pyAqFKQD0Jj4SxCdRyiXI7rmPK?=
 =?us-ascii?Q?5ig+EKaAjgbScDNYL10MJjaUodeOB0SdDvGcXsmedVbGs6ukbUTfyouy6t6/?=
 =?us-ascii?Q?CvsCCvZKY5mHcHPARSYkF/cqRNbMrYME5Gr2nWrGg378ti+riAvmOYkNQ0MB?=
 =?us-ascii?Q?AUaHFZMWmHmOs/M4BJ+TmcDHi4+XC+msRFdqGiVg2+Q4zujhiiUU7y1NC1gr?=
 =?us-ascii?Q?PteZaYOZUVMpDkm1ibCmOn5AJul+j2oFTybt3ld1fgl6NE9CnA8d55CfqRqI?=
 =?us-ascii?Q?+gj/W+XiryvSbe2ETFu1Ejs9BStBXsewFbzSXbTKe86C9nFI86DdkJgJgsOM?=
 =?us-ascii?Q?g3QX+7GYdBBSUSYqKotRhDuyvJmFYgEtilFgpgoetQxIbp0xTt0HK2EUP4pw?=
 =?us-ascii?Q?a/k+xHfNXEAXfEQDqhXxsUHosPTPrtqTXyK8/Yb1IDQbT6kAvptf9mpn5Kv8?=
 =?us-ascii?Q?LXpybSPiIjgS57DyNIpz3Y0hwwJHIdNkvb8CGq5YB3rjFdCdECyWnAGaa8hU?=
 =?us-ascii?Q?4i1awFuKN9TUQuj4Faw4cq9IfltC/ACY+1PS2zkndOozXa+I8P5t7h5cHxQT?=
 =?us-ascii?Q?RIAs9ypvgD9HRTW6/dvH9lt2w1IhnTxWBlUwWiLyfAg5c5ceb776QwqQGz5/?=
 =?us-ascii?Q?eGV+xdGfHCX200dbcu9boet6qGj5x58q1yuZsBvEHR5oOrfHQ+Vpzo636S+7?=
 =?us-ascii?Q?hAdx0eLW+L9LqBqf2egfRyiwG23to7Ujziw9IGlb9VvNP4An4hIgQT6WRfr+?=
 =?us-ascii?Q?8yc4VZ/kDlJ1dP+HRbSJsk2icZ7eKWCc7ywGcZw9Et2l5egWVVRd/QSb/bDJ?=
 =?us-ascii?Q?taSGVCtlWzDzPCPY15U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3196742e-b365-4c3d-909d-08ddbdbcc1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 01:14:16.1142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdqxvePKE2lIBnU3yUADKNTgtdagSseucQE0VQU3POvO3NaMrLdajB2seBDoDx9+ls+k3GNHtZHzaIeQHBvu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, July 8, 2025 3:03 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 04/36] drm/amdgpu: clean up sdma reset functions

Make them consistent and drop unneeded extra variables.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 11 +++++++++--  drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c | 11 +++++++++--  drivers/gpu/drm/amd/amdgpu/sdma_v6_=
0.c | 13 ++++---------  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 13 ++++---=
------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 5a1098bdd8256..1d8ae5ef6e1c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1544,11 +1544,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring=
 *ring,
                                 struct amdgpu_fence *timedout_fence)  {
        struct amdgpu_device *adev =3D ring->adev;
-       u32 inst_id =3D ring->me;
        int r;

+       if (amdgpu_sriov_vf(adev))
+               return -EINVAL;
+
+       if (ring->me >=3D adev->sdma.num_instances) {
+               dev_err(adev->dev, "sdma instance not found\n");
+               return -EINVAL;
+       }
+
        amdgpu_amdkfd_suspend(adev, true);
-       r =3D amdgpu_sdma_reset_engine(adev, inst_id, false);
+       r =3D amdgpu_sdma_reset_engine(adev, ring->me, false);
        amdgpu_amdkfd_resume(adev, true);

        return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 6843c2c3d71f5..908ed8b849376 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1457,11 +1457,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring=
 *ring,
                                 struct amdgpu_fence *timedout_fence)  {
        struct amdgpu_device *adev =3D ring->adev;
-       u32 inst_id =3D ring->me;
        int r;

+       if (amdgpu_sriov_vf(adev))
+               return -EINVAL;
+
+       if (ring->me >=3D adev->sdma.num_instances) {
+               dev_err(adev->dev, "sdma instance not found\n");
+               return -EINVAL;
+       }
+
        amdgpu_amdkfd_suspend(adev, true);
-       r =3D amdgpu_sdma_reset_engine(adev, inst_id, false);
+       r =3D amdgpu_sdma_reset_engine(adev, ring->me, false);
        amdgpu_amdkfd_resume(adev, true);

        return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index d2effa5318176..99be92efb74c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1575,18 +1575,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring=
 *ring,
                                 struct amdgpu_fence *timedout_fence)  {
        struct amdgpu_device *adev =3D ring->adev;
-       int i, r;
+       int r;

        if (amdgpu_sriov_vf(adev))
                return -EINVAL;

-       for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               if (ring =3D=3D &adev->sdma.instance[i].ring)
-                       break;
-       }
-
-       if (i =3D=3D adev->sdma.num_instances) {
-               DRM_ERROR("sdma instance not found\n");
+       if (ring->me >=3D adev->sdma.num_instances) {
+               dev_err(adev->dev, "sdma instance not found\n");
                return -EINVAL;
        }

@@ -1596,7 +1591,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *=
ring,
        if (r)
                return r;

-       r =3D sdma_v6_0_gfx_resume_instance(adev, i, true);
+       r =3D sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
        if (r)
                return r;
        amdgpu_fence_driver_force_completion(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_0.c
index 99a080bad2a3d..b79dc0a37667a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *=
ring,
                                 struct amdgpu_fence *timedout_fence)  {
        struct amdgpu_device *adev =3D ring->adev;
-       int i, r;
+       int r;

        if (amdgpu_sriov_vf(adev))
                return -EINVAL;

-       for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               if (ring =3D=3D &adev->sdma.instance[i].ring)
-                       break;
-       }
-
-       if (i =3D=3D adev->sdma.num_instances) {
-               DRM_ERROR("sdma instance not found\n");
+       if (ring->me >=3D adev->sdma.num_instances) {
+               dev_err(adev->dev, "sdma instance not found\n");
                return -EINVAL;
        }

@@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ri=
ng,
        if (r)
                return r;

-       r =3D sdma_v7_0_gfx_resume_instance(adev, i, true);
+       r =3D sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
        if (r)
                return r;
        amdgpu_fence_driver_force_completion(ring);
--
2.50.0

