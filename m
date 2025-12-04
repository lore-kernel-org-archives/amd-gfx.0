Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA4ED1D89F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 09:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C0F10E8F4;
	Thu,  4 Dec 2025 09:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MhdP+X6u";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB2610E8F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 09:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKd3+BxPZXEs58aD3XcrMORDP2mSdxpIFVcgMU/dGjdO3SpDRxSMrLNVGsiF73E+WAU6p5QnSxAEHsz1Yto2X81nBhUvveq69lDtsfXRbKhjWCXblAfBh2sB7jkQ6WdNzubDw3j9i6l32EAxSuJUMIb0CPQyVx5lTJBJsGPA4mb1MnyC8U9cUdPO56lzUeB/H9l7we9XmAtWtlo9sKUIlJDTD8ajiRTCqPSpIVvdlkUUUGDM/kb7G5QYUVE2EEpB8TlRM+lO0dQfTYFcSxkPgsvIiT0RmmkNkILOmvmdhWXduL0J1arObQOJHhpORdXm0bdsFecITyJGhI5FGrvPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xrGDB3Yv5b4dL/RMEIw3J8E8d1tbD7tYRT9HnJgTJg=;
 b=SsV9MnyES43CuKL5oIWd9XRubQk5+RPPENMyqCzAg45vvaVXozbp1+OtWieJyaL0uQzLDC04s+ag1sl9ofZtprKTofgsCeBofutcp8IDuPkKfXWc7pYcr629cb79IxoT3LBjfWRWLxfhnH9sHO750f+os6q0LD0r454TcuZxMYOB7y5NGDwolGl/yQo1il9gvStln3Lnmwk1G3Ko+/ZHp8dR3Yjs8vUOiULXYq0lLXL2bLSd8LR18s2DmwkElUPgKol//RLqRXgdO4WkZlxuQHkCkrYPASWl9BdNf29nccQhlYXMC32dPZFmIEubnT4dkGlYwsXF34k/52chBff0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xrGDB3Yv5b4dL/RMEIw3J8E8d1tbD7tYRT9HnJgTJg=;
 b=MhdP+X6uQbXhmhsfRLM1kGm+4ImgGMq/n47pcPShzKh61G1qY3tcZwnP7Bgknqk6nbr1yDaRobsqsezGtI4bRxgumBkER1KMd0fVF1pTe1aBClBXnDXmZpYigkcP0Irc8KLUEowHO+3wIsuAaVpdKtFDDCABagT9S2wG54IpZgA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 09:43:30 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 09:43:30 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add address check for uniras
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add address check for uniras
Thread-Index: AQHcY2SHHC/X82Yug0WI22jRAj+MlrURPUzg
Date: Thu, 4 Dec 2025 09:43:29 +0000
Message-ID: <CH2PR12MB421591F8644C0221254646FDFCA6A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20251202082005.1184954-1-jinzhou.su@amd.com>
 <20251202082005.1184954-2-jinzhou.su@amd.com>
In-Reply-To: <20251202082005.1184954-2-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-04T09:40:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SN7PR12MB7936:EE_
x-ms-office365-filtering-correlation-id: 5b239c5f-8630-40c0-97c9-08de331994f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MXfD/9dwplAk5u/wPrKRm+o04QBWghBBqEdaYX+NQS1yd7lZ6WUWDOCm88Af?=
 =?us-ascii?Q?GjyAGjIondjQGyTpFLmdizx7hVLYGUCxO6YIselbzF2wDGWr1yk/XRw1vEA9?=
 =?us-ascii?Q?8l2OCuGDTP8lPmV/AHPM0b8Xrg43N9K/VqhurxI4mlMVMtnSRkZoFmzEpQxe?=
 =?us-ascii?Q?vSfbOdva1E6YDoVJCozhi2Id0UV2TD2FRr+TeG5TQda7OJP3mbb4FsDXkLNs?=
 =?us-ascii?Q?E1TNppCh+xT4elEnnifFYjBL8zNqoahx7Y6pBNAjl38qzkx4IUqON6ygCkUD?=
 =?us-ascii?Q?1ciosHNo8TT4Vq2X7bhgkinhxkOJBaAXPcncUo/L9wN0aqOvsK88g+GvVnYd?=
 =?us-ascii?Q?bplBakKOZHqRun5NP9Pz+/P22ejMy7VelxmivINMoqCi1Vwc2GO5OTAVqK+O?=
 =?us-ascii?Q?RESt6NqaE1ok6QVoZAjIF+k3gxtWKzh7/ZCN/ARxaOsNcwUiLlkuo0oMO19l?=
 =?us-ascii?Q?qh9gGSag4R/fAF5+N0XsLtRHeVQ80liAScCMH2NRDe5YKrKee4eDW69ygJO5?=
 =?us-ascii?Q?zcNP+HYrWa4MEUyx/RrkP5HZ0nv/MttL4mXsYKvuMxVcTZhfhjP/KoXE726P?=
 =?us-ascii?Q?8k1iRlRdmjetZSaRlHwPV8t5uD2lxQKOTj2w6krX4Tbit8FyrHEcab8vhh4V?=
 =?us-ascii?Q?Z/hBeuTOfS1N5Do8f0RZOqBnakfZMQ0FeLO5ThghR+qcEZnjr5k+bUQcrQcR?=
 =?us-ascii?Q?FWqVO2ogJBl0T6UzfNICVu+DCZPFtKeVTpwY+ooe4+jDIziIgMkmleuclknh?=
 =?us-ascii?Q?Zt7N+tbnur/cigxe8e3F/4rwm0i6JDhsYSXF4L8fS+qztRBXBp2KqnHtPLHQ?=
 =?us-ascii?Q?9rdvnWcnrOXMFtcVOgNmdL2M7NW2DH6GGYG3NJtIzFNq8plTBWKbxSU9aDHF?=
 =?us-ascii?Q?40xd4PwrbK98tQUbSRimiRrFcqUZfPOxNNzfMNfiWNP5T6l1WNrs9cUFF21u?=
 =?us-ascii?Q?8kc38QipATg4yQRuOQtxKtla4Q/IjdLEMFnKw/qAcbLVrGPe4RutIB4NEEZG?=
 =?us-ascii?Q?kcHp64Y/6AJH2vtnkM3mBIHRr5VfJHpuNIBJZ74boNXDZYriPpyedMNn6MxL?=
 =?us-ascii?Q?lyTsxXTnS55ctWSyEgQcjd71Lx+o7MsrGevlfnVNQP80zU7ZFsiJYqS/2vaH?=
 =?us-ascii?Q?WAPDLBvRq49tAkvqD0c3g9DAf8ORT9dtIPr3TrSXI7+obJ/yy3FeQgl/wy1e?=
 =?us-ascii?Q?Czj7g3rm3EtNcJYKhXEMh91N9b7mC5jk5PBDcnwcafwYS4tgpNncxWoBVynK?=
 =?us-ascii?Q?BUpNQkD75uFJqrJSNaFaVVh9ZtixDM8/O0rx8QLoBv50lYPUb8nWU2PFWGQo?=
 =?us-ascii?Q?1a53yTSRMPoVF1pbyirMgRJt/xyOYewerZ9ndmCGIyT6+sacj40xeViFCLwW?=
 =?us-ascii?Q?gYr5/GlDExyb8zVJ1O8S0ajvY7HIXlOf0MvHAr7pEynuiCXA33wpxSAgdczR?=
 =?us-ascii?Q?rFfO+c1yERHMmK7zRPxrvn4DySHMM7jIKHO4PVR2wwVsGQot8NIJbcz/9khB?=
 =?us-ascii?Q?y1vL/h5mpBuySuejhdy8W2zWl8y3JmYaGBy+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YjhjidQrIYfdINmcZEtSEy4oOt+rD/oKgDtUOK5o0QL29ABevqjRrhaJikKk?=
 =?us-ascii?Q?GODMH0vYPsVB7otXw8gtpB/UAn9iKVlVu8FWBLTuFh6Rh+YBFO+XxmHN7/wj?=
 =?us-ascii?Q?6t1aQkge7hGEw2nyfF2FQpsMrKngAnBVq/k1djKFvpahQ6MT18xvXNEdzWAN?=
 =?us-ascii?Q?LoNhn9Olnp7HOssO8RRMPg8Wl/WbR/V//fYUGmlboIXC/G4tFBqryuZ/NJzd?=
 =?us-ascii?Q?/QjHPiWN618LEZok+vnWFogn4pAxs2HiEMXOTWKaeM+StcqzEan9qPy0LWJk?=
 =?us-ascii?Q?zb2XExQM0OqXNWH53BCgZSICSgqXd42pzuZqX8lUfVBJMsuuTLxLKZc0lWvZ?=
 =?us-ascii?Q?ZTuB9lT3nncFRWhJwTdTlQmhmK/2Ufe1mTIcTLjMBKTl4REHJ7T29Q+3Jlf8?=
 =?us-ascii?Q?zdhRU6AYatALRodhqLsfrqXl4im23PemkQhiIpch2WxJIEWZXQR4M8aiKNlm?=
 =?us-ascii?Q?GZo7qBULy8ueQ4Q+VMS81fUjkDUfGJdQ3ZxDYwsni0eb4ANzS8AWswcHoo0P?=
 =?us-ascii?Q?DflA6bIKc/L711kHec/ueaBm71x7qdLTCzFyHPYHEk269L50ULp9BY5z+VkS?=
 =?us-ascii?Q?Dx8A5Rp9QWefmMRLKmH1pfzsh0fouQqLth+6DIzO/W9KnBKMy7Ha3ijhBlkm?=
 =?us-ascii?Q?x6nJvh87fo+Y5wfrKOUnU//qlhJqyHvaiArEizt0FM9myK8LuQZIBQ84BurK?=
 =?us-ascii?Q?tX3VZUQ6FIUn0PccjDRxew0+LIDANlwa5AeWyaq8aJu+NMEDIDUdu0LeXZka?=
 =?us-ascii?Q?diwqDlssb3chc/SvLxFlzjeB5nmqLU3hSwa57tSMwzupeGMWhEpFPi1U/Gx2?=
 =?us-ascii?Q?mfkN+Lnsmx+EB1jWOhE6qo287uy6q0osWpYoVVGh/rghW1QE+dwo0rPOnQcb?=
 =?us-ascii?Q?BmI1XJbNmtbVavJUByPURNYZO9xajmILa1Rrh5U8BlNvkEcNFgm5LvF1IJV1?=
 =?us-ascii?Q?ff5iJJv5Kd7NnGvy1CtIieObfGaTPrcCe47drurN0xPbflQ8UoHhB6fxxJ/X?=
 =?us-ascii?Q?CFCn30eRVffyhFmtI8A48pL2+W4uI5yBat+KaLrY03BtQDzPV9vF3yLtyZab?=
 =?us-ascii?Q?ynUbZt28cwD60SAkssPlpplI0tPcUeaO1HOFcr1pkTbacnd32fDTPq3wicv4?=
 =?us-ascii?Q?o+2syHLQTVdxlSBgyOgM5eCbTAj8q6ClC4oCmbPtYueTfvA5vpSZmedkYkI8?=
 =?us-ascii?Q?NPD1RmX7IDoUcjHchW3h2cNPm2H3ywi7aLRE3D1V9BWLAQPgf5Abr51f26Pb?=
 =?us-ascii?Q?TiUq799FLKzsctlO3q44mukZ7bvBCCz0i7Pr+SmAibk0OgbyeWc0JgQQgt1L?=
 =?us-ascii?Q?XpGNcpXMj6cR+UGZ5amzZ+R+jE73VzEjOQuDIPIMhjBmV/WvTV85K6aZe5dC?=
 =?us-ascii?Q?MKQBrLyAcMTiqNh8nlWUC8+17QvCZXPVx1O1Jq1DeDY1+3qNlbffzmgRhmJ/?=
 =?us-ascii?Q?1qInJmEEZo0LQRGaebW8uhAmSv/DfggMjDceURaUUPhd/MHsve/9IQyiS4E0?=
 =?us-ascii?Q?BImkgECXm1Dkc7Lb/BOpbKXKkT3TiaxweM1B2Z5pi1wE2YBwmDB+1IDAKg2r?=
 =?us-ascii?Q?OqWkEoCcGim0VlwtnI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b239c5f-8630-40c0-97c9-08de331994f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 09:43:29.9530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lgNk+EBnEcyZooqLeHOdcruGiH2UUsNHJLv6vETefBZnxzL+bQ4sNNc+L9GX49wtVi+Y6Vfqt+PEhvP5DRkrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
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

Series is

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

-----Original Message-----
From: Su, Joe <Jinzhou.Su@amd.com>
Sent: Tuesday, December 2, 2025 4:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Su, Joe <Jinzhou.Su@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add address check for uniras

Add address check for uniras

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 97eece7d8504..3271bbf75cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -237,8 +237,13 @@ static int amdgpu_check_address_validity(struct amdgpu=
_device *adev,
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;

-       count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
+       if (amdgpu_uniras_enabled(adev))
+               count =3D amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, ad=
dress,
+                       page_pfns, ARRAY_SIZE(page_pfns));
+       else
+               count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                address, page_pfns, ARRAY_SIZE(page_pfns));
+
        if (count <=3D 0)
                return -EPERM;

--
2.43.0

