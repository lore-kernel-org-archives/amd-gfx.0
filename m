Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D236C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 06:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097BD10E1A7;
	Wed, 28 May 2025 06:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jyna6YEt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B9B10E585
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnExaSEca0/MczTiyyp90dlRfV2NKsdoODuzZKT1wn+EXLVMYbu2GwxV6JRSyFAcEo9NOZ6izAMG3E1CMwD/rfQ/IoV4OGNyaVNkwhNAYO7yAVy/d6vWY2tkoEmu+U984POa+bKE7WbM6XEjA7q/ZKuGyVy2z8PGOfAK2gzAlxaH6sCxFBApMMEYgT5X22okk50cSJ0t0Kkcjr9BZRokszqi5oZyCrVZ3oOb8L0irN8CXQaqOxfs4LB4vBCsLUZJy8/wlmsaMyN+N6VxlKsfzSuzw0a1Fj9KSvgk8xPmPTzJsXhfktZTOl9tyEg9WabcP34439Lo3mgHZ2rclQUcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tITsFrPewupfY8yrnEMxN88OEZ7Z/7A27H/AVj0HiE4=;
 b=ZImjh90bJGiQpjKAP9+h4dg8uI1q8T3Ch78IpOyYIzjZjrwKd89k7Kq7osnP0qnaUvU3U/LOUbPRtqmDLjG3SonJavJCWp1X0/FYRrJGnAI1zYHBsYhJeaMSfjS+kMglHe9sxFj1GFdT2EJNqi/YMWVyTZ+CI9wwTLclHKrt/3ARE4eVdbEP46ho2QooLIChwrRx45lJG6cH+oFf9MMidoq3Nbj/EsZsI7YR2P0FsB72CO6wfCHbOKg8WpsuQJcxXjezPi9rKUCuNJSCM3hdsBC8ie/Do98/bCk1jsm0Do7uQ3lOwdcWn65wmWXBqLG5urPpP0bzOss4beBOu9x3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tITsFrPewupfY8yrnEMxN88OEZ7Z/7A27H/AVj0HiE4=;
 b=Jyna6YEtoxbeWUI2AVUjpUFjxbBkenjwQqFAv1oisDW5sd05OFNcsettk+Y5rBtIGITedd2ENb0xqhe9TA6jIzmVALBYDB/wO8FvFrmQD7A5lx+Vb8tyDoaflmcoI9/9uDDovzdlZO+n2uy/CnATSWtLePU+WhvovF8u0qycLfc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 06:19:31 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 06:19:31 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v2] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHbzvUTZbMMhfehQE6fQzi1RSDgA7Pnkvww
Date: Wed, 28 May 2025 06:19:30 +0000
Message-ID: <PH0PR12MB5417B96B410513A018108C208F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250527104943.3020168-1-Emily.Deng@amd.com>
In-Reply-To: <20250527104943.3020168-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc3e1e79-46d5-483c-add9-89294efd6437;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T06:19:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ2PR12MB8926:EE_
x-ms-office365-filtering-correlation-id: 62c6b7cf-09bb-48e5-7a8a-08dd9daf9b9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7XKRDHMSUg//E+/o3b+huv+hxswM/BJ1EOfemqoIJJQpLKLJohPCK1a01WWl?=
 =?us-ascii?Q?9w5nAdMmEw4ztbO5l+tAKDN4PcWzD0JgLG8/zf5lVT92kiKsXXv8XKVssOqa?=
 =?us-ascii?Q?B/WeDFXInvA7vRzYRI7Z2Jminoc8pf9fKMQ/MksTzBpODDZYM1TU63RCz20l?=
 =?us-ascii?Q?HQ2epOQd5pjWt4IwXLfms1AvIzl2SnojwHMMXuKz+ZuI0GYJ1dorp3rxpu7r?=
 =?us-ascii?Q?sQMJU/+n6CvrY2Qb+5jZXUBGcqvrbKhW7+pNCmNGPmZgw/HcHHkP1S3A0DLC?=
 =?us-ascii?Q?PNlPBM7k5t0xakp1YBSWo4/i7dj6L7h/f/EzumSmWap2Bo7qr7uFxCJn4hnD?=
 =?us-ascii?Q?7kSmhwhhq/hVijb7zOf3hx5fOGR0T9PCXfm5NaEjO5km5P/nFFIasRzu0Zcz?=
 =?us-ascii?Q?C3fXUu8kNDsBCtII7Mw1DwWh3Og+Jwn7IpJlt977nXVKm5iQFQr2xpSH5n5d?=
 =?us-ascii?Q?pauCQ+cdqXt7sZm4lkpipom5RxnJIhKzhxpEDAZBEKEZpWAnecGozvDZP8XV?=
 =?us-ascii?Q?0Q9zt+ZF/IEw9Bpcs407TffWCZbB5nk2MLiBsDYixx9ag084/m4in+2oHJ9E?=
 =?us-ascii?Q?d38AcGh7D7vIDspL5V1R/GGEgqHf9zPC7W7qt1IND4jPukjAT0l1q6oIlDI3?=
 =?us-ascii?Q?81QBKYRU8Z/Jllig80mXgw81vwDd0D/g/DVkj2DFeBkcfjzmFVb5q05aeJuz?=
 =?us-ascii?Q?tMMsroPDUzFgqBxKxK7GuNSvvE8r0EjOp5JgN/UzOS8ayKQsrfsbkd796G/G?=
 =?us-ascii?Q?vFfotqOk9uApwe3Ll8/XwMhvttY/TWsyNVV/uhdFUmg6kaSWRJg3yQtYC/px?=
 =?us-ascii?Q?bZIAf12Ay3lqDOiIqdpU1DM89rifh5oXlUXoCwRPwOfG+pIHJtmctTNwVPFW?=
 =?us-ascii?Q?Z1HjaHi76IQxOwAO/L9JMzDfkANEBh3lYxhWLZMvV/mfXd6xKNgHp1fquYP8?=
 =?us-ascii?Q?H1yPbWhkwBiV0h26eRU/e4GwCZp5ijynGKG3VfOaufx3qNeqt652j8LMpC+q?=
 =?us-ascii?Q?NCiOe4LkVgSxSIbNoaOvr82SzaKmdHtavm/qthH45Z3WRk4IspxE6uk++I3T?=
 =?us-ascii?Q?B4cBiNzWMA0FPMDUieb3UgpL/A/m0c0gVSRICwwGNWlRoJa/cVqTS3YIZp5R?=
 =?us-ascii?Q?geCx4cdDiyW/K8EopK0VI2yL3zSfpbcNbmkbqQUCRS1Hw8tRn/kEAyh5aXJH?=
 =?us-ascii?Q?p1Fe2HtubgWTq0zFcsZLLLqQiGDC12HS5EFULumZxRwuSPVLQsltJFN9wX3P?=
 =?us-ascii?Q?i8mOoexxDgWM91dtcCJMZdPFV9ITqp2TVPApWB/tyQvBW0ytU3POiErWYHza?=
 =?us-ascii?Q?TLE25wi82wMjf5bRy3KyhygLdSoqcWYd6ROjENZwu4CU4BODOOsNGRLx+nLj?=
 =?us-ascii?Q?6FK3UCLmpidrFab9PaRjCNSKq6ALYWBN1Xn/xahUYrBTJ/Sv/WYOnzxN4QU+?=
 =?us-ascii?Q?Le2/30HIAB5Xz2rMT/2/sC0lerPYgcuO5sdfyg7SPA5yzFkRM8S7iA/sooKn?=
 =?us-ascii?Q?B/LiiUEerCIUBnU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8PNZ7Iwf3Sv7ka4dQVrMqLlFvXBpRY56Tt3BO5vI8K+ymNBBSINoIvroxxp0?=
 =?us-ascii?Q?/ZbMXPYiowgekHdVH9IBZ4jvCvyL3NkGMFdHf8OfyEXxZDpMDGKrtqvCkS4V?=
 =?us-ascii?Q?RI+8qO7dAqvRKTpsp6qNE51BeHOU0fH3cupERR0nPAVTpPJ+OYcy0Oi8/pa3?=
 =?us-ascii?Q?PxdRLs2VBtmUSKu2EjgUNAtzTgZa0K/fTEjlwJX277ww4Hmg9FtKGuDk2FUV?=
 =?us-ascii?Q?mxTU3BpIRITGb6NLy6H99US7easkQgI7/Y8/iVnBUlPmyt56OzXBtS8BnKCf?=
 =?us-ascii?Q?7iHm0sL1oHTQfEhaHnHjaKzgEo0iqqxg8A++CmNymW8P27HR3AOOqublZSOp?=
 =?us-ascii?Q?Asy7O4OyIfdHeK35e/TGxqrup8kOCS4wjqg0zmZtKtqeJBvfdWnY55EkOD2X?=
 =?us-ascii?Q?Vjtc11iCS4JWeV8ZuglQcEVwfGfuVsVcGtIxWlCe1AkuZNd/orWcfUbpIUvD?=
 =?us-ascii?Q?SPQGoNatS3RQziGqlAkXZWoR2401c+sNjgAq/rnQaOJzNblCdqbg6dfvS8ZP?=
 =?us-ascii?Q?RVng+djFRM2uTU0P45plR1jIaumA9QRz/Mlai4p9I/i8/o1pBR4SXobY8RyV?=
 =?us-ascii?Q?ycr/4Q5utQ5lTpIs8GXTL+K96t2S/o0rQ9ifBKKKCYg8/bN7mT2b/Ede0e4Z?=
 =?us-ascii?Q?ZW/KOJGSDXTdy0ytifeQ5eh3FcoxDWg605MOKaXpyrbrmpbdTsFxs7GPwALr?=
 =?us-ascii?Q?tXfsYV2V6/S/tBWWXiDoVJnZAJhZLJp+Q/qarcIzSpMSfuRiGJaQcMN8VgcO?=
 =?us-ascii?Q?zFV9yJYZqCKwWsmYyW9tkrGb3sCQ0oURdYb3xwXt/sNpfcS2VovgGmiE/LdE?=
 =?us-ascii?Q?qmcu66mmepa9uVOLw6RrZIA2GLfdi7kTf2rXraW9WrPEddqq0l5bn+ORs8M4?=
 =?us-ascii?Q?jgJAGnWYxpkEtyfGvAf1GhdrlebBr20+xp+5xCO1tSX8Iv1NbX0EC+BwCU2Z?=
 =?us-ascii?Q?di8H6KfOzbchJJcMBg5w2fAUQkLesZJgJwVludSV0mmJWmob+y6HT7/smU6D?=
 =?us-ascii?Q?8xrfP3W0LvMMdKLyywqM2oCgGtx2JEzp95oOvOrodXDj6jQbcJQvIlRNmXQL?=
 =?us-ascii?Q?PP9LF4yTSn3owiYdBWQxxd5mL0M6YCmZnMZO/zYJnaI99iDxYaSwoEYUfzZ1?=
 =?us-ascii?Q?lGt6cL63FPO1JHQGMjeA220/+Vc0+Dt1KNm5BPRexjtWKwGNtfpuZlSdYIoN?=
 =?us-ascii?Q?pxkmuzGZlw5Np3awwGwInlWYbYVi4oM619U1ecfORei4fJo2XW/XWiH8kxvy?=
 =?us-ascii?Q?svraLagVtFKaGHx/xjDVM4wjJkcgXWs7kZDJAWKpX/Uhl5V0BLjRcMi71xf3?=
 =?us-ascii?Q?GDOs2jKj77W6MN95Cche0eNDGenScm5JdCKwrF3/JdwQAJTO59sxuKH+4fdp?=
 =?us-ascii?Q?SsX0wzw3aouOMsa9h4OBUtA10bNWKgpJP8pgtKpUvb/s2pCCFQRFohECzcAY?=
 =?us-ascii?Q?hNTcaw/z5S5TrlPtDfT8a62OrNXg5MEJ4/bvJR3eI8I6VfKQtYs2S0LX7+gi?=
 =?us-ascii?Q?K+jzoJqqfM53MxBt4+HWkjuLC0nAlpVbsGYtn6105Wen3rTUQ2tzDIi4NHCa?=
 =?us-ascii?Q?ABUMY1wxWvGkv8XMdKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c6b7cf-09bb-48e5-7a8a-08dd9daf9b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 06:19:31.1781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpkwdjEy6N8uY6BDHGJ/v2+8BbTgX+t4+qo3p28U2F95qInG3AS+MxbiUqL1JvFE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, May 27, 2025 6:50 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of=
 full
>access
>
>For the suspend and resume process, exclusive access is not required.
>Therefore, it can be moved out of the full access section to reduce the du=
ration of
>exclusive access.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
> 4 files changed, 70 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>index 4cec3a873995..ba07e9c6619d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev,
>bool run_pm)
>       return r;
> }
>
>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>+run_pm) {
>+      if (adev->kfd.dev)
>+              kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>+
>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>+run_pm) {
>+      int r =3D 0;
>+
>+      if (adev->kfd.dev)
>+              r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>+
>+      return r;
>+}
>+
> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>                           struct amdgpu_reset_context *reset_context)  { =
diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>index b6ca41859b53..841ae8b75ab1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>
> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);  int
>amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev,
>+bool run_pm);
> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>                       const void *ih_ring_entry);
> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct kfd=
_dev *kfd,
>bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>                     struct amdgpu_reset_context *reset_context);  int
>kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@ static inlin=
e int
>kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>       return 0;
> }
>
>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>+run_pm) { }
>+
>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>+run_pm) {
>+      return 0;
>+}
>+
> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>                                   struct amdgpu_reset_context *reset_cont=
ext)  { diff --
>git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 625c416c7d45..6e29f8bd54bb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol
>notify_clients)
>       amdgpu_device_ip_suspend_phase1(adev);
>
>       if (!adev->in_s0ix) {
>-              amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>+              amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev) ||
>+adev->in_runpm);
>               amdgpu_userq_suspend(adev);
>       }
>
>@@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol
>notify_clients)
>       if (amdgpu_sriov_vf(adev))
>               amdgpu_virt_release_full_gpu(adev, false);
>
>+      if (!adev->in_s0ix)
>+              amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
>+
>       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>       if (r)
>               return r;
>@@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l
>notify_clients)
>       }
>
>       if (!adev->in_s0ix) {
>-              r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>+              r =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_runtime(adev=
) ||
>+adev->in_runpm);
>               if (r)
>                       goto exit;
>
>@@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device *dev, bo=
ol
>notify_clients)
>               amdgpu_virt_release_full_gpu(adev, true);
>       }
>
>+      if (!adev->in_s0ix) {
>+              r =3D amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
>+              if (r)
>+                      goto exit;
>+      }
>       if (r)
>               return r;
>
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>index bf0854bd5555..22c6ef7c42b6 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_=
pm)
>       if (!kfd->init_complete)
>               return;
>
>-      /* for runtime suspend, skip locking kfd */
>-      if (!run_pm) {
>-              mutex_lock(&kfd_processes_mutex);
>-              /* For first KFD device suspend all the KFD processes */
>-              if (++kfd_locked =3D=3D 1)
>-                      kfd_suspend_all_processes();
>-              mutex_unlock(&kfd_processes_mutex);
>-      }
>-
>+      kgd2kfd_suspend_process(kfd, run_pm);
>       for (i =3D 0; i < kfd->num_nodes; i++) {
>               node =3D kfd->nodes[i];
>               node->dqm->ops.stop(node->dqm);
>@@ -1055,6 +1047,36 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm=
)
>                       return ret;
>       }
>
>+      ret =3D kgd2kfd_resume_process(kfd, run_pm);
>+
>+      return ret;
>+}
>+
>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>+      struct kfd_node *node;
>+      int i;
>+
>+      if (!kfd->init_complete)
>+              return;
>+
>+      /* for runtime suspend, skip locking kfd */
>+      if (!run_pm) {
>+              mutex_lock(&kfd_processes_mutex);
>+              /* For first KFD device suspend all the KFD processes */
>+              if (++kfd_locked =3D=3D 1)
>+                      kfd_suspend_all_processes();
>+              mutex_unlock(&kfd_processes_mutex);
>+      }
>+}
>+
>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>+      int ret, i;
>+
>+      if (!kfd->init_complete)
>+              return 0;
>+
>       /* for runtime resume, skip unlocking kfd */
>       if (!run_pm) {
>               mutex_lock(&kfd_processes_mutex);
>--
>2.34.1

