Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A48C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 21:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B98210E3FD;
	Wed,  5 Feb 2025 21:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tghVn5n6";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9C510E208
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 21:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLJyU4piDrbvnGy0p5iUykzYfeOfzliDFB1Zt3FZgJpas3RNqOXlGNyQu4qidy3NmMtpaNaA3RB969EQzVDiQSw87pU/a0gBfXKTKxMH7IOs4XQEeTP6dmoLbQ4c9xmf+AChRCYmBsAPWTdzt6oMECOxByL2B98m8OgBFJf2pEFtXuvxlaaqOT4/UrQ5/ntJ5D0XWoUvhbTiG7PFjOg/NY1sxK6jtl58ByV2cHopAHv2xYsAq0sbViPmxRpVJRU3BIXK9oOi+3SAuyqNG3YGFkkSIZBpo2F/KcVUTfYuNV3ZY//tN5HphoG3qaGIHb0AJ9YuS4sGA6zxjG1yHHRT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMxpRT2hPt22kQoDlIYFzJmJJ1FBScc/7f7GOGiRzXM=;
 b=jZt9GFUlb2iCbpqWlX7YPRPWFApKSj7BMQb12DTIL8pVAiOeIHRIQ2ZLBvx5Xb1CY+eGxvm26DNX5JbwcJXf5azYZiQdPWXPTD0p8idELPqehE8f4YWXdptbWXsaOnAqpvFjPBAGsxtFiEzS0AZZfegpVYhO29Z9wWFAOPUJkQbRf6Yi/b61Qfin3NH4zXPX8pnAQSbNyDMKf9yHPi4ikS+DoXXJy7K1T6Ungl4a7HS6noZ3pdiw05/adNP4COQtbj+rE2NhRMPdTSb8qxwMSLOgldRdib9GXdS95EfJITMJiyGeOWXEtntb//C5YIMcHEhsLtKD8DY3DRrisk9ROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMxpRT2hPt22kQoDlIYFzJmJJ1FBScc/7f7GOGiRzXM=;
 b=tghVn5n6JmU+2oFKY8lh4QKANBkfzfZvZf2HnsGeU4Qeh6yomfdUj0hgX+1FHoTH3hrIKkny2tbsS9gzh8HW3OztawOdpF/e541fcpFK4cRCJttP5B3vbGKt2d5j1JQy50LgRvusB1i8RTRSQfGX5qJLnDVxUTALvJi3BV5CZoY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 21:08:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:08:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: Add wrapper for freeing vbios memory
Thread-Topic: [PATCH 1/4] drm/amdgpu: Add wrapper for freeing vbios memory
Thread-Index: AQHbd8KHTDcWnvfRxUy37vJ/tQYPt7M5M2Fh
Date: Wed, 5 Feb 2025 21:08:37 +0000
Message-ID: <BL1PR12MB51445BCB4824FC9A1F081E89F7F72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250205113832.1903614-1-lijo.lazar@amd.com>
In-Reply-To: <20250205113832.1903614-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-05T21:08:36.872Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB6176:EE_
x-ms-office365-filtering-correlation-id: 35c4097b-8e45-45ed-d396-08dd46294246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iTI4DB7/WuN1wsjdfuztGUgNHyJB0wPREU5Rf+df4CYyXwdcENSYN4y18Nb2?=
 =?us-ascii?Q?gZiGvIVKd3Zzsn6e3u9b168mKej7aAPGYnHtejJI6w93tGXLGa+gIQoXwJaq?=
 =?us-ascii?Q?EIYM/xsWHDuaOZlha2uWQ0C0Y7+OTfLBr7QFbKF9ej25a+MY2/3gPaEkqAbD?=
 =?us-ascii?Q?UUqWCsZtFfPpjwWxcMEQE8bAXt9Kk2CYrNdgfBN2HAT+Y0YXyIN3mdQk5cQb?=
 =?us-ascii?Q?ar0w0QTzFDH0BH7G7tbi8dZeWQVNRAE/drSxMm4CXwXYWAMERRQR36lL3s0v?=
 =?us-ascii?Q?jwCv8wzKSV7Iu6At61Mw53/gmn1byNHGEk2N2dsjIKCP4E+VCRgcEeQ3FZl9?=
 =?us-ascii?Q?SZJ7fkPhdI+k8eGM0Vj5tWjpIDBc1NeU4AbRpiP4U/S2vvT68USph67icY9x?=
 =?us-ascii?Q?p4od9ktk/R6aY7/8SQUu9mObmbYu8n1lwuIRxRwrRCy6ohbqSCundxU+yB9s?=
 =?us-ascii?Q?tVycOibaXsyEjrWYwJMYyWHSV3qKbLrZEDMlMeoSoHU1vew3F9/WBmC9Npg0?=
 =?us-ascii?Q?dmFWZJzybCbKwNky0o31uVEZi3SlS6XJDZ7BbfaebWIesuMkKT4V5XB535d/?=
 =?us-ascii?Q?5np6ZCmryQSaZxZstKRZkpWFDTyIf2wUxEw379bFjyDyhKUa6LeHOAozxwdq?=
 =?us-ascii?Q?4/mMF7PB90a9zUy23CJiACxPqwJs3WR8TIQw6SzalaUJUw/7Px73iVX/mRUG?=
 =?us-ascii?Q?WvoabdK8j7Lq4rE4+y2xNft2Vny2hPErM1vMnJB7s/Hf1XMshYTKfMttOs3F?=
 =?us-ascii?Q?Bgknli8ZxQfim4VwZRrSg7YGQmDLoSycPVyZb74s+/mI4/nhH3CCQjHieRne?=
 =?us-ascii?Q?avXvI6p3tuv7rGJr2jGp9ey05UKnqxnpeN24RR2NQ7TCNxue6S5s9/oLuAoj?=
 =?us-ascii?Q?k6awVNDC3Q3W9DFGWTZyeQ4P5/bfncgUsyPxamfNATdN+UiqpM4CjNLkju/n?=
 =?us-ascii?Q?Fxt7OpPpzYON+3OcAAXGWR5EeJeVIRLulhexYcvDgR8XxnX8L0ijY8/nUaxQ?=
 =?us-ascii?Q?KbqegGeUJcIacpBXAsUGHpK3rlJfHsr92t4V3vnxdhqEIUg0vTsMgpYN+4I/?=
 =?us-ascii?Q?xjGg2WMbkdyCFczXww3E+fO7NYWuk4ex/l1Ngy87uQFwLZIQCfNLOc+xdO3t?=
 =?us-ascii?Q?6FAhdCU+kFXVeCco6LAngWJ6UEp0uQ73o7mrPw1wT/+dGRj3BH+WjTPKFkOT?=
 =?us-ascii?Q?PG1u0cxwKqld+dubVeRlH/JIq0BbOypbuKscQ0YHEJlHt6UNdlX2ayjkp2HE?=
 =?us-ascii?Q?QWpy3lpsBiWffZXlQ+QfYIdfOWzyPzNaG86cUAA1vuZqGi1XbeWUkGXtNzmB?=
 =?us-ascii?Q?EK+m44dTrAbEnqh+mvP/f/0hCsB7aWVQjLyljKfQsVEseEa6fPlQnq/mQ/Tx?=
 =?us-ascii?Q?lkbwttSvvxAzWRxF/1xzkJewFeoKkj6PVuxf3A+Vdlec2cJ43xq8V42+762h?=
 =?us-ascii?Q?gMuw0e+NIZJab+khqedzYwNkWjDq0PZu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VAMsnYxKIJZP6URsFDznCXkxSxy34mjLnfvVVm6utGM+QDvYL+lA4uM2+sQ3?=
 =?us-ascii?Q?LkG/hWoUFIk6VXCZqz4xZ4KgOHnr7CRscZ7JzOeVEJuwwYmWC/mIcOWR/IM+?=
 =?us-ascii?Q?s/kffUHEmb0uNvQJnyQANVLt/JvpoIm7OoT4atMzUIvDmPiN5WNYSAhvBUml?=
 =?us-ascii?Q?ak65DbgSQtrqahPhaLSuvPhGecpEtMHibgWwWz3AOJoUlnHmxRxQ+hObZ1Ua?=
 =?us-ascii?Q?rbnq/sVFtcatEXK8hd0tCi5Oeh4/fkJufJ6TrBcqxz9Sru5raRN2w+wyDkkl?=
 =?us-ascii?Q?ef2vnYRdPdxpjoJL5rcpCbmeQzXOPrmKPmhzMoemAToSiHDblIFBW+356ag1?=
 =?us-ascii?Q?944gXwSs/r6CYqCgWx7kmzZ3FYE4FsRMX+OwJleOw4koFlRApy6ely4t2xfV?=
 =?us-ascii?Q?3qwMfRwvYljCwtC16PtrQzdkbTw26R+tE2w3g7fObwYNypuCvd6mu/ZFo4v3?=
 =?us-ascii?Q?CwT8QMQ7G2oy/0zOxlIlCFw4WTAWx6/xz5fXd4qpww+4bJ2GZGTJv9gsNZ8N?=
 =?us-ascii?Q?VHWGIqXaHrCA+I0pumuNyxFx8O27L3Nzn362FKDA5H2ROGGH0GbjJF02EQDV?=
 =?us-ascii?Q?vy+wHPVqSI01DGL9L0MzGO/N9TQWqcx240VTmXO3lTjSMLeYfEUaw1uBOz90?=
 =?us-ascii?Q?ojlP2kyPYqb+fJvMv3Lmd+nOe7Sl99TcPidwU4xG+Noka2yZXpyzxOtRAIvU?=
 =?us-ascii?Q?q40t5ZFqXX2sM1DMdYAWEvJXxTIyHy7c31OzlH1/8DNjwv3FzJVjN1xMrEiB?=
 =?us-ascii?Q?ilr3mvRA/VGZpuX7YzYlQpuVSxAcbCARHAlW24e9YohZcAuYizPoy1MoZRzu?=
 =?us-ascii?Q?SoPy/YUCUfTIAvaOTIX4JVMJQFTktzlJIVEe5jvar5LJ26IwZC4QcUV03q1O?=
 =?us-ascii?Q?5LxaeuMg+YNkInBWBQi+dX0ky7s6YQTu9ZQ9ZnOpvtExlnkUDIc9oSWfQbxm?=
 =?us-ascii?Q?RIwr7DUyMjv+g0cdtTyJrRm/+l+wv+U9cag6jVhiDuksXEpTgA1Vb5+wDHX1?=
 =?us-ascii?Q?QDBWJicyyA0Zlp+coEKvbp77tDGIEmEfX1FoG3Ywio+oNvuu8QdEX3QV8K+U?=
 =?us-ascii?Q?J0onzK0pNiJdU3gS1J5wCEyJQWqjex8hjAEJiQh2V/pMkyRaLrk2t917GrL3?=
 =?us-ascii?Q?MwV8mY4awstRRgTh7YjRoQ5jcG9jodgRWxSHvhZxOUXlohKXRhWs0ZDAeWiZ?=
 =?us-ascii?Q?bH5DrlYEpu/XLS9nl5oFC53G+JwQs435GBsbXkeo1tC7qAKN8rOBYG7DzVau?=
 =?us-ascii?Q?X8P1h84+94ozOowNW267Zc5t7WAAA0tEcu3Y6HJbkqBuWYghYjMnZD+GZ+KU?=
 =?us-ascii?Q?//Or2bTPekpeE+qM4L+9uVds4j8q4CxnZx15YnEiAPa2IUrQeSfszFKDAdPp?=
 =?us-ascii?Q?p2lgxaHYT9cGtydf0klpA5V+9A59rHrowLDxVJKFhfkWJA2fgl6/R+amf3Z7?=
 =?us-ascii?Q?ZmRwmMCivYioYkBig3au5QLuqCIR/hSHf6VT5MrGSk9OlPeXDUhPK0F4Q1Uy?=
 =?us-ascii?Q?PhJheuX1BwtjqUF4GU0RCZpv46TWJG2IVg+UGFjmjmoQV0SRNhIa7k53EX8/?=
 =?us-ascii?Q?7MS24l3UaKMWN5433/g=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445BCB4824FC9A1F081E89F7F72BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c4097b-8e45-45ed-d396-08dd46294246
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 21:08:37.5865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpicoeN+p7+bHaPeM1c8U6H7mcKTr8GLbtSG1IxmhlHY2Bsg5cmcY9YXW+92/qsHCacQ3AoSIsNBaUQO5wvMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

--_000_BL1PR12MB51445BCB4824FC9A1F081E89F7F72BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Might be nice to apply this to where we free the vbios in amdgpu_device_fin=
i_sw() as well.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


Alex

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 5, 2025 6:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add wrapper for freeing vbios memory

Use bios_release wrapper to release memory allocated for vbios image and
reset the variables.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index 423fd2eebe1e..a9b3f4702f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -84,6 +84,13 @@ static bool check_atom_bios(struct amdgpu_device *adev, =
size_t size)
         return false;
 }

+static inline void amdgpu_bios_release(struct amdgpu_device *adev)
+{
+       kfree(adev->bios);
+       adev->bios =3D NULL;
+       adev->bios_size =3D 0;
+}
+
 /* If you boot an IGP board with a discrete card as the primary,
  * the IGP rom is not accessible via the rom bar as the IGP rom is
  * part of the system bios.  On boot, the system bios puts a
@@ -121,7 +128,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_de=
vice *adev)
         iounmap(bios);

         if (!check_atom_bios(adev, size)) {
-               kfree(adev->bios);
+               amdgpu_bios_release(adev);
                 return false;
         }

@@ -149,7 +156,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
         pci_unmap_rom(adev->pdev, bios);

         if (!check_atom_bios(adev, size)) {
-               kfree(adev->bios);
+               amdgpu_bios_release(adev);
                 return false;
         }

@@ -189,7 +196,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_dev=
ice *adev)
         amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);

         if (!check_atom_bios(adev, len)) {
-               kfree(adev->bios);
+               amdgpu_bios_release(adev);
                 return false;
         }

@@ -225,7 +232,8 @@ static bool amdgpu_read_platform_bios(struct amdgpu_dev=
ice *adev)

         return true;
 free_bios:
-       kfree(adev->bios);
+       amdgpu_bios_release(adev);
+
         return false;
 }

@@ -327,7 +335,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *=
adev)
         }

         if (!check_atom_bios(adev, size)) {
-               kfree(adev->bios);
+               amdgpu_bios_release(adev);
                 return false;
         }
         adev->bios_size =3D size;
@@ -392,7 +400,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device =
*adev)
                                              GFP_KERNEL);

                         if (!check_atom_bios(adev, vhdr->ImageLength)) {
-                               kfree(adev->bios);
+                               amdgpu_bios_release(adev);
                                 return false;
                         }
                         adev->bios_size =3D vhdr->ImageLength;
--
2.25.1


--_000_BL1PR12MB51445BCB4824FC9A1F081E89F7F72BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Might be nice to apply this to where we free the vbios in amdgpu_device_fin=
i_sw() as well.&nbsp; Either way:</div>
<div class=3D"elementToProof" style=3D"margin: 0px; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"margin: 0px; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 5, 2025 6:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu: Add wrapper for freeing vbios memor=
y</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use bios_release wrapper to release memory allocat=
ed for vbios image and<br>
reset the variables.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 ++++++++++++++------<br=
>
&nbsp;1 file changed, 14 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c<br>
index 423fd2eebe1e..a9b3f4702f6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
@@ -84,6 +84,13 @@ static bool check_atom_bios(struct amdgpu_device *adev, =
size_t size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
+static inline void amdgpu_bios_release(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;bios =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;bios_size =3D 0;<br>
+}<br>
+<br>
&nbsp;/* If you boot an IGP board with a discrete card as the primary,<br>
&nbsp; * the IGP rom is not accessible via the rom bar as the IGP rom is<br=
>
&nbsp; * part of the system bios.&nbsp; On boot, the system bios puts a<br>
@@ -121,7 +128,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iounmap(bios);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!check_atom_bios(adev,=
 size)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -149,7 +156,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_unmap_rom(adev-&gt;pde=
v, bios);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!check_atom_bios(adev,=
 size)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -189,7 +196,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_read_bios_from=
_rom(adev, adev-&gt;bios, len);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!check_atom_bios(adev,=
 len)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -225,7 +232,8 @@ static bool amdgpu_read_platform_bios(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;free_bios:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bios_release(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -327,7 +335,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!check_atom_bios(adev,=
 size)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;bios_size =3D siz=
e;<br>
@@ -392,7 +400,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
check_atom_bios(adev, vhdr-&gt;ImageLength)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;bios);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;bios_size =3D vhdr-&gt;ImageLength;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445BCB4824FC9A1F081E89F7F72BL1PR12MB5144namp_--
