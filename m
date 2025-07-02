Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785C4C83038
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 03:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7C210E66F;
	Wed,  2 Jul 2025 03:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8TJJ3IM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC5A10E658
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 03:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ+pLuqMNSCES+EoiabgGPMPMJ1DiuFh9GLRk4o+yFm+h6BLWgECw1dEraqOIbugg8JoRXnU+9XqP/9TaRGvqVrqGN5lCItEACihCGKnxnAk6UPG3zOl7nXhqam7hxOPi3K7pmFbnAC8eGAfhk8qJzfJ1qYA/KVTCUhe41dY0y6TsvwpDmGanZvDXYY1bQJZeZ1tYMJ5a+52roTlleAIl2jRf1KnIz/vfrzjfzfb3rsm0vkXP4nKcPXaZtO+WQ/lQQvff0ELpRiD7Ul5lTMc5lcmr0HwyhdlipysDSrvw8Uu9qKknCP3/vOiK4hKMeIdKu6/K0OPUXiVheZtQijkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R8tqR17rw1xUXVjmhPUrYC7t8BvcP7/J3UTESVkNuE=;
 b=f/asv//uyaTKgbsNazHL1FZnhgpmoJ/5qfJzMmQnxykdq8WFVmyKSuthbSfHJOo/W2cRtaKmHtZA9M+FppOIIgClF4PlO4kk5qfRtQYGnHytWzDFIwmlUEpYz8UtTjlI/EH7a6JnAEj4Bgvc/aeQhuDE9AGWGIWJZXbpLOjyXIAX2M80g72ZdAK2C5YujeCWQzrl2XJKDGBvLgsXtr14a7ve9Mdp09TlXUBr7mxwOlHh5dTKy/dzMolNgD+9mDPsBL5cnh0YOnIea7CAoMZpLOBYLK9elLZjTSSn9KOd/Kh6Ls6yeCCk8X1L/PZ7536GFFKm3j1npghtMC0B5rHiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R8tqR17rw1xUXVjmhPUrYC7t8BvcP7/J3UTESVkNuE=;
 b=x8TJJ3IMAOfSH/LhDQ5TVRAKsJWYGgerXUZomiq2Uniir5m5b4CgX68RBRPARRwIM0WFDC9l78QrccltAquhJWFxFBL1Mp6dJ3552QCN4YnMv/hUZdPXqQLEcz1BorAZlFhHEWf2XfajV5HcE4HVsBTi3zJoOb65arj7lbgO6xY=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Wed, 2 Jul
 2025 03:47:16 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37%3]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 03:47:15 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Tomasevic, Vojislav"
 <Vojislav.Tomasevic@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add a noverbose flag to psp_wait_for
Thread-Topic: [PATCH] drm/amdgpu: Add a noverbose flag to psp_wait_for
Thread-Index: AQHb6mn2yNSQ+IxiBE2C+xrjfUKnjLQeL+Wg
Date: Wed, 2 Jul 2025 03:47:15 +0000
Message-ID: <CY5PR12MB608126FCC3FFE81C98581F0E8E40A@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20250701092409.1303971-1-lijo.lazar@amd.com>
In-Reply-To: <20250701092409.1303971-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T03:35:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|DM6PR12MB4250:EE_
x-ms-office365-filtering-correlation-id: 84ab91ae-25fd-4d19-88d1-08ddb91b22cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GZiMSS/Y/uwnccliXjmL/asaUmgR8ByycNFu6XL40126jtuA4HHFUCo2AZCP?=
 =?us-ascii?Q?cdyRNm5gVFTNPygMIZadzFs3LwJKjSSmRVBbpX8KVTgJQsbY45gEjXV0cIu0?=
 =?us-ascii?Q?zrOaBxSaR4gdgPFjO1dCYQi3y8hJj6MgyqzglwChTZ19k5Bed5mo5sp+3Chf?=
 =?us-ascii?Q?P/NwWIPwuWEck+q1wNpYeFKBTGRTtPUiXWKuMZJxt2ClYP09q2wiCqkfV4UF?=
 =?us-ascii?Q?VPGuNuJiCnbVj9t0vm3jzo3VXi2E8GnO6jny2zjX+mN/E6Iv+M1yGNIsMl1O?=
 =?us-ascii?Q?Yb8/X6VYzCItD46vLjNVkuFPkfcbzMGB6sCx8QuSfCV+dUBmbf6lbPgsZ+oV?=
 =?us-ascii?Q?odo1IdcUFyk/B+fTsywPh12sLoukXYaLFFrHJ+9lMlSwt23U34zDSZxwd3hN?=
 =?us-ascii?Q?KC71BaBJdIi1hmviLEREGIc18JeqojhhPnCpcPoQ1pGRrZhR0yBZTubDRm8i?=
 =?us-ascii?Q?LyFJAPrDq28wLs/tXHMrq5jYPE5wXE0L9Dc6a83HJvHt1rzgg9HDpojp6NUi?=
 =?us-ascii?Q?DpZ8ssleOqCWDQO7gCtnE7afVv/HvQsLIr9gw5F0WWD5ZW8F5OnGBbA1MouP?=
 =?us-ascii?Q?mDwV0NbEUrrzyQZrcb4OQywwAXk0BBoZRfYCSnvky0mEtGJkSSRITjb61tP5?=
 =?us-ascii?Q?ayUc79YErVDPQEyBEsDSWZblHX3sHtMDcsI1hg+9Hw3KrCtze617yYOu7AU/?=
 =?us-ascii?Q?p+KmrDHemwCL1lRQ2AZIefF/ABE9KnG5PUS4mb2MAf8SUFobWPP7ZuH+BKdS?=
 =?us-ascii?Q?o0zgPfV1zhjnCYAao+q79WofoW5ePj6ejN8rnDvcXqT56mxOEc0a8DBQpdUh?=
 =?us-ascii?Q?rYc+206NfxXt8zJiOlsks34pMSyGin9xOdBgA7spsS+2ZeXsgQnILbhxooBY?=
 =?us-ascii?Q?m0H1+RafoWNaBig7+vtLgnmk4Mq64LT5X0Qz8blMNgAullaBY5fiV5MGR1MK?=
 =?us-ascii?Q?Y9RmcLCcudXHboQOpqa8DiNhqP246I5HXFqQ9ae+BUvaCfKn+y6wSc5+NI0s?=
 =?us-ascii?Q?65qSkaZm5m5KGtQxm/wVNLka9KhT93m41lSqDAheo5663f6Gf5Aphl/1am6U?=
 =?us-ascii?Q?83iBBQpSMCTu0wyBjCugpQguFWgjr/IjF086S0s1WoqMC9/h9Px1ytZNThIs?=
 =?us-ascii?Q?F594V0io/xD6JC6QhV55tdv4AV30eZ0VIHHwFw1gV3WOsf3sDjU8QE1P6mFw?=
 =?us-ascii?Q?DzJZwKt/PpKeCphw/I2QMPpMnXWCEnHF6BVC1v/sRBRtjRwmrfIzp7hOHMMK?=
 =?us-ascii?Q?s5lAGv26rqhgJHPZG0h52lnJ586hNwOjrlc+Va75dqyS+51uoRJG9UxA0EwB?=
 =?us-ascii?Q?lcQuUZhhsUNU5DQfFmKvtu94UzMr/9TycyxrCSnOSXsa6MkGWx1FZNNzY5ZL?=
 =?us-ascii?Q?eoUby5D/e6cYn30aNmG0+79qhiNUMvXiGE5AC6KsfaQM9PMxnR8XDuM0+REr?=
 =?us-ascii?Q?uAztA98bOcjNSZh5DaGP6xaIDhfYTy18l53r+ui8k2oH0lBz6dQ6Ccdh+Tf3?=
 =?us-ascii?Q?mS/3FLyhEuxaiA0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhLyUHyInCMqbgm6kBhUyVaKGv1I4WHMdhYMKb2UguvDE7QBTmNEDw/C2ca4?=
 =?us-ascii?Q?J4mkzrkjj7RPDs7YdellwaSwcxjsbRVdQksvnOWfS3oLE7Sg82zdQly/b0Kg?=
 =?us-ascii?Q?sj17eqNtLfw2yrmTSvU80riyw9FY4oe/D0o19dV6CGnVawLzxfy6acUPnGcy?=
 =?us-ascii?Q?ftaNq1ylk8ODLnyiEodbmPVpKMWxi0sEfI/GJNogatm1vFMRXmyfbv5odc6S?=
 =?us-ascii?Q?PIwPCJjYNs93Ls1SLf5f4fq9O65gPjD8JNqL8+fw1ShHSAgMQ2h5ofdKIrKk?=
 =?us-ascii?Q?u9XtndexDC9YNE7qta2wg9eDT78Ztniv07lRfd7AylB6Hxi4YA7r2xrMgWBq?=
 =?us-ascii?Q?EBwz5LI+M0XJon24EhF+3B/y9sYVBAPtAwM82yF+rx+K7ftJ85vyTYo8yYX7?=
 =?us-ascii?Q?cEiYA4o9oOtFKGD/H9Sc6WHi3NjzYs2lFtjRGA0VKRH+L1H4nyFSekqQUfzq?=
 =?us-ascii?Q?UiZo+TLvvF7rzJ471JV4ubObF7j5EKdT7zIIPvRIMWYXybo3ErDMNq7o7VX3?=
 =?us-ascii?Q?jlUL/u8MoqaE7va+y2KAnnJuQ4P391hP8uJnV0H7IQCEXs8tiHh1ao1eJv8N?=
 =?us-ascii?Q?5r7XoxdsO2dr6NjT9QQ4ufwK0kdKNdwDLK68vtGSobSCMa5s+8+lAW0CIvGs?=
 =?us-ascii?Q?hSiqGjsKRXYU7qQdzrToVTMcDbxJzd/efvyeVUNLYum3i4WSgBk2g3m9rDWT?=
 =?us-ascii?Q?9iHS+nZE7tvUw4y2+o3Q+Mr3RMOdSwrsSKaAGIXQyRdO/NfY3B5C+s5LSg3O?=
 =?us-ascii?Q?ndOOKgE7Q73vhf92lva9aKKKLQNLGiZO+bLNLN8l/k8uPKAJJiVGn8nPsLSd?=
 =?us-ascii?Q?YTw0dhQ5YuRh6yTxMnQtCA/5cwNHHnKkTv5un3UUSX5btABK2j0ou0/vPVwi?=
 =?us-ascii?Q?BesjKJVOizsg02eTBlBJlLtfwZg72blJ3AZTN1G2737kxhhzfCDgKN6nMBOy?=
 =?us-ascii?Q?K5PCoKA0XmSw5gx0hTDqdSJZnxoWf64BxxYaB3oULHwYrOJKj8T8n40eM9U4?=
 =?us-ascii?Q?ib+J+1/WmYzyB0OQLSkEOeyzKiz7bkMfQK9OQw1fqejldAT3eLt88kEtP3Pt?=
 =?us-ascii?Q?S4khx2/bVVap003abb+VytV+p6dYnPstwQcHtSqBgt/muHciJlD8E89qrUof?=
 =?us-ascii?Q?YlOobWyzlbFwdBUWLDamBD0VE7H2vmB71jY4iANfqsO7k08Axc+/RpuiBh5o?=
 =?us-ascii?Q?T2cjMLIjfv4mdLsaL6l9Out7eSXfHKs4IsCCJOQdTnSmyq3I3b+X8TGeZ3FW?=
 =?us-ascii?Q?yxwZhj9r84V5hcTT6e1swgWohYrwdv1SnwhEv8YMWYf8Lml0KCtZxlZVueJh?=
 =?us-ascii?Q?Eu6K8f7KJkOm9vahL93iyhKFn5ADAW6GMgOcM47eT2eheNOKAV5j895d7jCq?=
 =?us-ascii?Q?nDnpuT3qEw1k7B9Pw6PBo3pw3ueN9vMeTILdXsauvb1hk8KlX4vjeKCM6U6m?=
 =?us-ascii?Q?AOYyEAPhVL2bujaArjDn6X7phuIZjtSiMbEmYNgPnxGD/9AalPglgsWcqFTE?=
 =?us-ascii?Q?Szkswlhe05satZNY5VBSHxfy/WhmfCwHHkVwly369TywD31ODWTFzCmnRz8T?=
 =?us-ascii?Q?J9mT55nvjv7xbtZ9KUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ab91ae-25fd-4d19-88d1-08ddb91b22cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 03:47:15.5062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAIZ/L14djhorOipxejZt0Fp7bOgZdFrGVWIfaaP0hB32HLPrtsIpPE0DCeTlTQaU/m9d+Y2KR+740Aj28V38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

Apart from minor comment inline, patch looks good to me.

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad


-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 1, 2025 2:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Tomasevic, Vojislav <Voj=
islav.Tomasevic@amd.com>
Subject: [PATCH] drm/amdgpu: Add a noverbose flag to psp_wait_for

For extended wait with retries on a PSP register value, add a noverbose fla=
g to avoid excessive error messages on each timeout.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 13 +++---  drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h  |  7 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 35 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 10 ++---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 20 ++++-----
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 41 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 22 +++++-----
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 55 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c    | 41 +++++++++---------
 10 files changed, 130 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 04dedf38eb0d..25aa35de1e41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -575,9 +575,11 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_bloc=
k)
        return 0;
 }

-int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
-                uint32_t reg_val, uint32_t mask, bool check_changed)
+int psp_wait_for(struct psp_context *psp, uint32_t reg_index, uint32_t reg=
_val,
+                uint32_t mask, uint32_t flags)
 {
+       bool check_changed =3D flags & PSP_WAITREG_CHANGED;
+       bool verbose =3D !(flags & PSP_WAITREG_NOVERBOSE);
        uint32_t val;
        int i;
        struct amdgpu_device *adev =3D psp->adev; @@ -597,9 +599,10 @@ int =
psp_wait_for(struct psp_context *psp, uint32_t reg_index,
                udelay(1);
        }

-       dev_err(adev->dev,
-               "psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x"=
,
-               reg_index, mask, val, reg_val);
+       if (verbose)
+               dev_err(adev->dev,
+                       "psp reg (0x%x) wait timed out, mask: %x, read: %x =
exp: %x",
+                       reg_index, mask, val, reg_val);

        return -ETIME;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 4bc0ec49d2e9..35888f1937bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,9 @@ enum psp_reg_prog_id {
        PSP_REG_LAST
 };

+#define PSP_WAITREG_CHANGED (1U << 0) /* check if the value has changed
+*/ #define PSP_WAITREG_NOVERBOSE (1U << 1) /* No error verbose */
+
AK: Can we use BIT macro here?

 struct psp_funcs {
        int (*init_microcode)(struct psp_context *psp);
        int (*wait_for_bootloader)(struct psp_context *psp); @@ -532,8 +535=
,8 @@ extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;  exte=
rn const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;  extern const=
 struct amdgpu_ip_block_version psp_v14_0_ip_block;

-extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
-                       uint32_t field_val, uint32_t mask, bool check_chang=
ed);
+int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
+                uint32_t field_val, uint32_t mask, uint32_t flags);
 extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t re=
g_index,
                        uint32_t field_val, uint32_t mask, uint32_t msec_ti=
meout);

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 2c4ebd98927f..3584b8c18fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -94,7 +94,7 @@ static int psp_v10_0_ring_create(struct psp_context *psp,

        /* Wait for response flag (bit 31) in C2PMSG_64 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_64),
-                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        return ret;
 }
@@ -115,7 +115,7 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,

        /* Wait for response flag (bit 31) in C2PMSG_64 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_64),
-                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 1a4a26e6ffd2..6cc05d36e359 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -152,11 +152,9 @@ static int psp_v11_0_wait_for_bootloader(struct psp_co=
ntext *psp)
        for (retry_loop =3D 0; retry_loop < 10; retry_loop++) {
                /* Wait for bootloader to signify that is
                    ready having bit 31 of C2PMSG_35 set to 1 */
-               ret =3D psp_wait_for(psp,
-                                  SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMS=
G_35),
-                                  0x80000000,
-                                  0x80000000,
-                                  false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);

                if (ret =3D=3D 0)
                        return 0;
@@ -252,8 +250,8 @@ static int psp_v11_0_bootloader_load_sos(struct psp_con=
text *psp)
        /* there might be handshake issue with hardware which needs delay *=
/
        mdelay(20);
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_81),
-                          RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
-                          0, true);
+                          RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81), 0,
+                          PSP_WAITREG_CHANGED);

        return ret;
 }
@@ -279,11 +277,11 @@ static int psp_v11_0_ring_stop(struct psp_context *ps=
p,
        if (amdgpu_sriov_vf(adev))
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        else
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        return ret;
 }
@@ -321,13 +319,13 @@ static int psp_v11_0_ring_create(struct psp_context *=
psp,
                /* Wait for response flag (bit 31) in C2PMSG_101 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        } else {
                /* Wait for sOS ready for ring creation */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
                if (ret) {
                        DRM_ERROR("Failed to wait for sOS ready for ring cr=
eation\n");
                        return ret;
@@ -353,7 +351,7 @@ static int psp_v11_0_ring_create(struct psp_context *ps=
p,
                /* Wait for response flag (bit 31) in C2PMSG_64 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -387,7 +385,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *ps=
p)
        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);

        ret =3D psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
-                          MBOX_TOS_READY_MASK, false);
+                          MBOX_TOS_READY_MASK, 0);

        if (ret) {
                DRM_INFO("psp is not working correctly before mode1 reset!\=
n"); @@ -402,7 +400,7 @@ static int psp_v11_0_mode1_reset(struct psp_contex=
t *psp)
        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);

        ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP=
_MASK,
-                          false);
+                          0);

        if (ret) {
                DRM_INFO("psp mode 1 reset failed!\n"); @@ -428,8 +426,9 @@=
 static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int=
 msg)

        max_wait =3D MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
        for (i =3D 0; i < max_wait; i++) {
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_35),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
                if (ret =3D=3D 0)
                        break;
        }
@@ -608,7 +607,7 @@ static int psp_v11_0_load_usbc_pd_fw(struct psp_context=
 *psp, uint64_t fw_pri_mc
        WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                            0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -645,7 +644,7 @@ static int psp_v11_0_read_usbc_pd_fw(struct psp_context=
 *psp, uint32_t *fw_ver)
        WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_=
VER);

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                                    0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (!ret)
                *fw_ver =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0_8.c
index 338d015c0f2e..93787a90d598 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -43,7 +43,7 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, @@ -53,7 +53,7 @@=
 static int psp_v11_0_8_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -91,13 +91,13 @@ static int psp_v11_0_8_ring_create(struct psp_context *=
psp,
                /* Wait for response flag (bit 31) in C2PMSG_101 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        } else {
                /* Wait for sOS ready for ring creation */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -123,7 +123,7 @@ static int psp_v11_0_8_ring_create(struct psp_context *=
psp,
                /* Wait for response flag (bit 31) in C2PMSG_64 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c
index d54b3e0fabaf..4c6450d62299 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -82,7 +82,7 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_co=
ntext *psp)

        /* Wait for bootloader to signify that is ready having bit 31 of C2=
PMSG_35 set to 1 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                          0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -97,7 +97,7 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_co=
ntext *psp)
               psp_gfxdrv_command_reg);

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                          0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);

        return ret;
 }
@@ -118,7 +118,7 @@ static int psp_v12_0_bootloader_load_sos(struct psp_con=
text *psp)

        /* Wait for bootloader to signify that is ready having bit 31 of C2=
PMSG_35 set to 1 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                          0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -133,8 +133,8 @@ static int psp_v12_0_bootloader_load_sos(struct psp_con=
text *psp)
               psp_gfxdrv_command_reg);

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_81),
-                          RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
-                          0, true);
+                          RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81), 0,
+                          PSP_WAITREG_CHANGED);

        return ret;
 }
@@ -163,7 +163,7 @@ static int psp_v12_0_ring_create(struct psp_context *ps=
p,

        /* Wait for response flag (bit 31) in C2PMSG_64 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_64),
-                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        return ret;
 }
@@ -186,11 +186,11 @@ static int psp_v12_0_ring_stop(struct psp_context *ps=
p,
        if (amdgpu_sriov_vf(adev))
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        else
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        return ret;
 }
@@ -222,7 +222,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *ps=
p)
        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);

        ret =3D psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
-                          MBOX_TOS_READY_MASK, false);
+                          MBOX_TOS_READY_MASK, 0);

        if (ret) {
                DRM_INFO("psp is not working correctly before mode1 reset!\=
n"); @@ -237,7 +237,7 @@ static int psp_v12_0_mode1_reset(struct psp_contex=
t *psp)
        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);

        ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP=
_MASK,
-                          false);
+                          0);

        if (ret) {
                DRM_INFO("psp mode 1 reset failed!\n"); diff --git a/driver=
s/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 58b6b64dcd68..af4a7d7c4abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -182,7 +182,7 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_con=
text *psp)
                   ready having bit 31 of C2PMSG_33 set to 1 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_33)=
,
-                       0x80000000, 0xffffffff, false);
+                       0x80000000, 0xffffffff, PSP_WAITREG_NOVERBOSE);

                if (ret =3D=3D 0)
                        break;
@@ -213,7 +213,7 @@ static int psp_v13_0_wait_for_bootloader(struct psp_con=
text *psp)
        for (retry_loop =3D 0; retry_loop < retry_cnt; retry_loop++) {
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35)=
,
-                       0x80000000, 0xffffffff, false);
+                       0x80000000, 0xffffffff, PSP_WAITREG_NOVERBOSE);

                if (ret =3D=3D 0)
                        return 0;
@@ -362,8 +362,8 @@ static int psp_v13_0_bootloader_load_sos(struct psp_con=
text *psp)
        /* there might be handshake issue with hardware which needs delay *=
/
        mdelay(20);
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_81),
-                          RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
-                          0, true);
+                          RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81), 0,
+                          PSP_WAITREG_CHANGED);

        if (!ret)
                psp_v13_0_init_sos_version(psp);
@@ -386,7 +386,7 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, @@ -396,7 +396,7=
 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -434,13 +434,13 @@ static int psp_v13_0_ring_create(struct psp_context *=
psp,
                /* Wait for response flag (bit 31) in C2PMSG_101 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        } else {
                /* Wait for sOS ready for ring creation */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
-                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -466,7 +466,7 @@ static int psp_v13_0_ring_create(struct psp_context *ps=
p,
                /* Wait for response flag (bit 31) in C2PMSG_64 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -529,8 +529,9 @@ static int psp_v13_0_memory_training_send_msg(struct ps=
p_context *psp, int msg)

        max_wait =3D MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
        for (i =3D 0; i < max_wait; i++) {
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_35),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35)=
,
+                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
                if (ret =3D=3D 0)
                        break;
        }
@@ -682,7 +683,7 @@ static int psp_v13_0_load_usbc_pd_fw(struct psp_context=
 *psp, uint64_t fw_pri_mc
        WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_35),
-                            0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -719,7 +720,7 @@ static int psp_v13_0_read_usbc_pd_fw(struct psp_context=
 *psp, uint32_t *fw_ver)
        WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW=
_VER);

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_35),
-                                    0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (!ret)
                *fw_ver =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36);

@@ -744,8 +745,9 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *p=
sp, int cmd)
                ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0, 0, regMP0_SMN_C2PMSG_115),
                                                 MBOX_READY_FLAG, MBOX_READ=
Y_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
        else
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_115),
-                                  MBOX_READY_FLAG, MBOX_READY_MASK, false)=
;
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115=
),
+                       MBOX_READY_FLAG, MBOX_READY_MASK, 0);
        if (ret) {
                dev_err(adev->dev, "SPI cmd %x timed out, ret =3D %d", cmd,=
 ret);
                return ret;
@@ -769,7 +771,7 @@ static int psp_v13_0_update_spirom(struct psp_context *=
psp,

        /* Confirm PSP is ready to start */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_115),
-                          MBOX_READY_FLAG, MBOX_READY_MASK, false);
+                          MBOX_READY_FLAG, MBOX_READY_MASK, 0);
        if (ret) {
                dev_err(adev->dev, "PSP Not ready to start processing, ret =
=3D %d", ret);
                return ret;
@@ -804,7 +806,7 @@ static int psp_v13_0_dump_spirom(struct psp_context *ps=
p,

        /* Confirm PSP is ready to start */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_115),
-                          MBOX_READY_FLAG, MBOX_READY_MASK, false);
+                          MBOX_READY_FLAG, MBOX_READY_MASK, 0);
        if (ret) {
                dev_err(adev->dev, "PSP Not ready to start processing, ret =
=3D %d", ret);
                return ret;
@@ -931,8 +933,9 @@ static int psp_v13_0_reg_program_no_ring(struct psp_con=
text *psp, uint32_t val,
                WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, id);
                WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_103, val);

-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
+                       0x80000000, 0x80000000, 0);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0_4.c
index f65af52c1c19..5f39a2edcc95 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -76,11 +76,9 @@ static int psp_v13_0_4_wait_for_bootloader(struct psp_co=
ntext *psp)
        for (retry_loop =3D 0; retry_loop < 10; retry_loop++) {
                /* Wait for bootloader to signify that is
                    ready having bit 31 of C2PMSG_35 set to 1 */
-               ret =3D psp_wait_for(psp,
-                                  SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PM=
SG_35),
-                                  0x80000000,
-                                  0x80000000,
-                                  false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35)=
,
+                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);

                if (ret =3D=3D 0)
                        return 0;
@@ -185,8 +183,8 @@ static int psp_v13_0_4_bootloader_load_sos(struct psp_c=
ontext *psp)
        /* there might be handshake issue with hardware which needs delay *=
/
        mdelay(20);
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_81),
-                          RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
-                          0, true);
+                          RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81), 0,
+                          PSP_WAITREG_CHANGED);

        return ret;
 }
@@ -206,7 +204,7 @@ static int psp_v13_0_4_ring_stop(struct psp_context *ps=
p,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, @@ -216,7 +214,7=
 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -254,13 +252,13 @@ static int psp_v13_0_4_ring_create(struct psp_context=
 *psp,
                /* Wait for response flag (bit 31) in C2PMSG_101 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        } else {
                /* Wait for sOS ready for ring creation */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
-                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -286,7 +284,7 @@ static int psp_v13_0_4_ring_create(struct psp_context *=
psp,
                /* Wait for response flag (bit 31) in C2PMSG_64 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v14_0.c
index ffa47c7d24c9..36ef4a72ad1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -109,11 +109,9 @@ static int psp_v14_0_wait_for_bootloader(struct psp_co=
ntext *psp)
        for (retry_loop =3D 0; retry_loop < 10; retry_loop++) {
                /* Wait for bootloader to signify that is
                    ready having bit 31 of C2PMSG_35 set to 1 */
-               ret =3D psp_wait_for(psp,
-                                  SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2=
PMSG_35),
-                                  0x80000000,
-                                  0x80000000,
-                                  false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_3=
5),
+                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);

                if (ret =3D=3D 0)
                        return 0;
@@ -228,9 +226,10 @@ static int psp_v14_0_bootloader_load_sos(struct psp_co=
ntext *psp)

        /* there might be handshake issue with hardware which needs delay *=
/
        mdelay(20);
-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2P=
MSG_81),
-                          RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81),
-                          0, true);
+       ret =3D psp_wait_for(psp,
+                          SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_81)=
,
+                          RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81), 0,
+                          PSP_WAITREG_CHANGED);

        return ret;
 }
@@ -250,7 +249,7 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_1=
01),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, @@ -260,7 +259=
,7 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
                /* Wait for response flag (bit 31) */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_6=
4),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -298,13 +297,13 @@ static int psp_v14_0_ring_create(struct psp_context *=
psp,
                /* Wait for response flag (bit 31) in C2PMSG_101 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_1=
01),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);

        } else {
                /* Wait for sOS ready for ring creation */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_6=
4),
-                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -330,7 +329,7 @@ static int psp_v14_0_ring_create(struct psp_context *ps=
p,
                /* Wait for response flag (bit 31) in C2PMSG_64 */
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_6=
4),
-                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
        }

        return ret;
@@ -393,8 +392,9 @@ static int psp_v14_0_memory_training_send_msg(struct ps=
p_context *psp, int msg)

        max_wait =3D MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
        for (i =3D 0; i < max_wait; i++) {
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_35),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_3=
5),
+                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
                if (ret =3D=3D 0)
                        break;
        }
@@ -545,8 +545,9 @@ static int psp_v14_0_load_usbc_pd_fw(struct psp_context=
 *psp, uint64_t fw_pri_mc
         */
        WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20)=
);

-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2P=
MSG_35),
-                            0x80000000, 0x80000000, false);
+       ret =3D psp_wait_for(psp,
+                          SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35)=
,
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -582,8 +583,9 @@ static int psp_v14_0_read_usbc_pd_fw(struct psp_context=
 *psp, uint32_t *fw_ver)

        WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_=
FW_VER);

-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2P=
MSG_35),
-                                    0x80000000, 0x80000000, false);
+       ret =3D psp_wait_for(psp,
+                          SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35)=
,
+                          0x80000000, 0x80000000, 0);
        if (!ret)
                *fw_ver =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36);

@@ -607,11 +609,13 @@ static int psp_v14_0_exec_spi_cmd(struct psp_context =
*psp, int cmd)
                ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0, 0, regMPASP_SMN_C2PMSG_115),
                                                 MBOX_READY_FLAG, MBOX_READ=
Y_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
        else
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_115),
-                                  MBOX_READY_FLAG, MBOX_READY_MASK, false)=
;
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_1=
15),
+                       MBOX_READY_FLAG, MBOX_READY_MASK, 0);

-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2P=
MSG_115),
-                               MBOX_READY_FLAG, MBOX_READY_MASK, false);
+       ret =3D psp_wait_for(psp,
+                          SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115=
),
+                          MBOX_READY_FLAG, MBOX_READY_MASK, 0);
        if (ret) {
                dev_err(adev->dev, "SPI cmd %x timed out, ret =3D %d", cmd,=
 ret);
                return ret;
@@ -634,8 +638,9 @@ static int psp_v14_0_update_spirom(struct psp_context *=
psp,
        int ret;

        /* Confirm PSP is ready to start */
-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2P=
MSG_115),
-                          MBOX_READY_FLAG, MBOX_READY_MASK, false);
+       ret =3D psp_wait_for(psp,
+                          SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115=
),
+                          MBOX_READY_FLAG, MBOX_READY_MASK, 0);
        if (ret) {
                dev_err(adev->dev, "PSP Not ready to start processing, ret =
=3D %d", ret);
                return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c
index f6b75e3e47ff..833830bc3e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -91,7 +91,7 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_con=
text *psp)

        /* Wait for bootloader to signify that is ready having bit 31 of C2=
PMSG_35 set to 1 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                          0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -109,7 +109,7 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_c=
ontext *psp)
        mdelay(20);

        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                          0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);

        return ret;
 }
@@ -130,7 +130,7 @@ static int psp_v3_1_bootloader_load_sos(struct psp_cont=
ext *psp)

        /* Wait for bootloader to signify that is ready having bit 31 of C2=
PMSG_35 set to 1 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),
-                          0x80000000, 0x80000000, false);
+                          0x80000000, 0x80000000, 0);
        if (ret)
                return ret;

@@ -147,8 +147,8 @@ static int psp_v3_1_bootloader_load_sos(struct psp_cont=
ext *psp)
        /* there might be handshake issue with hardware which needs delay *=
/
        mdelay(20);
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_81),
-                          RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
-                          0, true);
+                          RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81), 0,
+                          PSP_WAITREG_CHANGED);
        return ret;
 }

@@ -168,7 +168,7 @@ static void psp_v3_1_reroute_ih(struct psp_context *psp=
)

        mdelay(20);
        psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                    0x80000000, 0x8000FFFF, false);
+                    0x80000000, 0x8000FFFF, 0);

        /* Change IH ring for UMC */
        tmp =3D REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x=
1216b); @@ -180,7 +180,7 @@ static void psp_v3_1_reroute_ih(struct psp_cont=
ext *psp)

        mdelay(20);
        psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-                    0x80000000, 0x8000FFFF, false);
+                    0x80000000, 0x8000FFFF, 0);
 }

 static int psp_v3_1_ring_create(struct psp_context *psp, @@ -217,9 +217,9 =
@@ static int psp_v3_1_ring_create(struct psp_context *psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_101 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
-                                       mmMP0_SMN_C2PMSG_101), 0x80000000,
-                                       0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       0x80000000, 0x8000FFFF, 0);
        } else {

                /* Write low address of the ring to C2PMSG_69 */ @@ -240,10=
 +240,9 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_64 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
-                                       mmMP0_SMN_C2PMSG_64), 0x80000000,
-                                       0x8000FFFF, false);
-
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       0x80000000, 0x8000FFFF, 0);
        }
        return ret;
 }
@@ -267,11 +266,13 @@ static int psp_v3_1_ring_stop(struct psp_context *psp=
,

        /* Wait for response flag (bit 31) */
        if (amdgpu_sriov_vf(adev))
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       0x80000000, 0x80000000, 0);
        else
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       0x80000000, 0x80000000, 0);

        return ret;
 }
@@ -311,7 +312,7 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp=
)

        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);

-       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, 0);

        if (ret) {
                DRM_INFO("psp is not working correctly before mode1 reset!\=
n"); @@ -325,7 +326,7 @@ static int psp_v3_1_mode1_reset(struct psp_context=
 *psp)

        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);

-       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, 0);

        if (ret) {
                DRM_INFO("psp mode 1 reset failed!\n");
--
2.49.0

