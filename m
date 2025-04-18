Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D121C369C9
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 08:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF71810E1AE;
	Fri, 18 Apr 2025 08:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvYW/NMP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A7310E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 08:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccyJwm5o9heJWxFea8womFFVtY8832hdpeIb8wYKiwoF57G9hk8Pw0NNEzAQLjA3zBT0LnKGSrL600tFSHut0sr5RDSJQYFd4Bp8aG9zP5w+z0V84x6LnMlkRnEj+e67j550hG74cM3ZUptTDBIaphapFzflLWZvYYfclVm54+Co7UbGxMtnDd3T2PIK+i/c2TSXC688mKSpKsnClixY6gkHvJxsRSW2/2X9KcW2gCu+yO3+7DVZv9KX4aC5IeH2XTt5W2OglnmpkjSnbgRLFVBqfiNqvWVQtHs42I9wBGrUhGcr3aIHQjKuQG+NUevJQRu2ir2GF4IpxZu1yVLqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF4GgxUZE+lhlceZU5IVcf4DpTfQq3UJGavl9qKJnLo=;
 b=QIVF/hY6ldMUvzOvJyDf6gpVPdOsDxB7Q/KK7eKk+85voIzcrNNO/ks7I7nbVXw0BDNf2nbwPiuGcnkfThCAxVqDsRlE4XOq7tn5RRqH7xBEdfBJJlw2F+y585OQmVijMtaeyq4JFGhNN4J8r0mGJ/AbbGaYT7LAMwFCCbql2vXRhfmxYAeVBycUdura2583USkq16oQnJUdzx+a9mHaWPBhoymkotNdHVeghBbVDC4FIMo+VZ5CCvF4ljCVM7n1him563EfFxLfTqhKUTanL5yXUluDG5kdin04zFkHUvoRYTpmAnfBp3Lb5HnmiUYANLCXLPoRkYJMH0ZnaMLj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF4GgxUZE+lhlceZU5IVcf4DpTfQq3UJGavl9qKJnLo=;
 b=UvYW/NMPSZ3NtujLURCNnPa0nt+6sHzClY/m4csvx/1KsDPrFwrtZRAvOsG0FlRwt78HVgIiqvu20FXM8siIlHDjvW2YzRfoj+V8fEYELfMc0JRWxfmLAMsiRlDFcLwzevplybiFOK5Kj3k/ZaxAALyGEHj00lmEBQ/+k2eTM/s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.42; Fri, 18 Apr
 2025 08:28:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 08:28:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Print kernel message when error logged by
 scrub
Thread-Topic: [PATCH] drm/amdgpu: Print kernel message when error logged by
 scrub
Thread-Index: AQHbsDQYmNZ/Bg8BcUyn5CxaXpylKrOpFGow
Date: Fri, 18 Apr 2025 08:28:24 +0000
Message-ID: <BN9PR12MB5257BB833702FE8C7259D8C2FCBF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250418073228.117249-1-xiang.liu@amd.com>
In-Reply-To: <20250418073228.117249-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=27a696e7-6883-4591-bd54-4832fea2ae94;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T08:18:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: 294aa718-7554-4ab4-dd32-08dd7e52fcaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wOz61MDZBAJ47Ss27eI7BeJ1SpFwVRo+xag/D9txhiy2hgS2xSF84c9XLOdL?=
 =?us-ascii?Q?D3b/HE3T7AY4X5d8cKee1Zcjgoh6YogvqQc/1smaK5fxa9O2+SZlJ/MigbDw?=
 =?us-ascii?Q?VLds7uN8xBGW1VN5c2Zfu7Atpc2Xu5b8adAtqvL74WABSGlGdxrWokEz1nzf?=
 =?us-ascii?Q?dRgsFzGIfWSmhbHdoI6aZA+yBSHD5d3RS/c8DsZiooVnP9w2JMmYXPHw/boS?=
 =?us-ascii?Q?b4cU74R00/HYrvd9P4/eQDwdHR62OA+8sUs/f0Dh1NzJJmQxQbmPKwXl66X5?=
 =?us-ascii?Q?WG2LQdawj3UzB/SCihJJGETddMEj1XE4IWNRUYuLSstz5D5+B1goNoeZ0xE8?=
 =?us-ascii?Q?L/nZdNTEWf6fz0YUk1F2TUSUqYbpQDGmMhs+SKtCKP+lNXlHjVpfT0ujEknJ?=
 =?us-ascii?Q?N5/OFUpC+5SUq2nphNuqMgjQ2IBd06hx0rqJoXUCNz912iwgiVjnakPjxupg?=
 =?us-ascii?Q?6sIxP4m2noe+SQ44paHpxjAhZVgD3usXN4DqqrTICd5BzbYNrR6xr4cCcoW9?=
 =?us-ascii?Q?FmoWCgqNc1sioUs3gTx9kF/k4i7dWYXzmiTgX5sChmM6x1kuLtUOUYfp59g1?=
 =?us-ascii?Q?oF6fh8c1hRrfHUkIr3jIHzLwmbsZhH6aIQowuICSLPRb0k/UJquPr3yuGCbF?=
 =?us-ascii?Q?q5f9252aBv3WdU90FTIRMzo8UTxQcCUPK2darXjf9RT8VDrER7/ukpU+q3EL?=
 =?us-ascii?Q?ArXi1YFpMrDbTmSZcPkjzjZCW4KOQ0RLyhvCbDdZ6HEUBRvffHpMUj3iQBMI?=
 =?us-ascii?Q?fXhk48+GqLkM4Yk4hOUcuTowb2ZrPxeP3W2W2W+StV+83jx4CuWoH/Zv5zLf?=
 =?us-ascii?Q?/xUNyE2daMUVR1f6VIium15mB+Tuxx0FrSjm4EumYZnLGjUBW3S2xDngMhIC?=
 =?us-ascii?Q?H/slyqUMyBtoRErSuZTrrJRpxa6Y4hTdKu4MHtIdO669KMxVdVQwGfZUmdhu?=
 =?us-ascii?Q?jmYdA1BtG0kWsF2UY5XlsSHh6AyxPkYsLUsTwevgf6TdDTXwBz6xEM7upicm?=
 =?us-ascii?Q?RGSt3YexNaaCmZG+oDeTr8tRr7lkI3zw6yzgg5DhTwFdjv5CbaUqYAuki/1O?=
 =?us-ascii?Q?XLWtoiY8Vdy8IAmcC94m6CJr47uP96LX+CD/nM8eLHgHpgmuPYaK5XDTbQz8?=
 =?us-ascii?Q?T3LkqhVt7BBOH4ZOfxvWndauVZoue7e9mD1ce38NPyibY53bXmOmvMDkwE9K?=
 =?us-ascii?Q?vQkhuVnSd9ysImisiyqIQz41t42IT0KCuUpjA9AtAR/ToQqtB8cw1c7VC1Ya?=
 =?us-ascii?Q?V7dARBUd5WxoktOFi0yg+U27AzVHNRl1YOs/Dy2pmjJ2l26crkR4jkozjy4u?=
 =?us-ascii?Q?RHD8sSwVnvB4h0T3v/BodBIrk+ar9fUuDthLB/Qy8co4FLkwxZm/YD56Dr8Z?=
 =?us-ascii?Q?IWn83EcATJyQoFcWvZnLPsnIKYouhiTouy0vzCdPxQraRNtYeg9CKLEQoWDx?=
 =?us-ascii?Q?9P2IQfxNRDO906PKl0+Pb/abDi4VJRELlEolZRWBNIg6hzPlaz/jLw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKpGI8VQwSXH6tQo3zXM/OInEeQvpzlvt3FxazKz8x+etNseOAJFVfdf4mrB?=
 =?us-ascii?Q?ickwGmkLKEmYmLj0tN9d5HukDxY6cZ4tj/bScka9rX+MoFW3oiGWwvbfOZWP?=
 =?us-ascii?Q?I8pFtQRHkzEz2WjIJZ4C5vYyRdyTVd/Nwp/NgWYWVLSsjIPaJSJYiBMZg24g?=
 =?us-ascii?Q?zTqVf/uLcdV2I+uXy9qyjsZXQg1ubjtXPvu76WudktxIg5m38WPuf1D7K9h0?=
 =?us-ascii?Q?PUaMPNnFsxo44COThkxhylzXbwg6TA1nuB7d4bSUkEJn9zHZ7QzVEqcx4mPO?=
 =?us-ascii?Q?ewmJoJPTNtd5YWSwSpNB9GV9EyTnnyNc0Q8FVq3fj/9SQOTQExiWLatbY2U6?=
 =?us-ascii?Q?BXriw6SqcCxrddvPnkh8T2aDbWyxXHPJk1p+duhP3mlcqP+klaqWQ+wJU1cP?=
 =?us-ascii?Q?PaAVeanT0WRm62wHa8zfVIz4E+loNAx9zn5zOKg5yQf4IGUEpQ+BboqpGPHa?=
 =?us-ascii?Q?QTaXfQ+y5fkIVw48HiXpgbT14NwSHManXOYTk/GUKea9678gjED6GuR1TfQ4?=
 =?us-ascii?Q?fwLnyqAO2m5+d2/hEFIFNA0rvOLZCm6ELnJEGHpeZ4u02RbB+WrM4VFIoHSi?=
 =?us-ascii?Q?JdhLZwViEyVMRpCV0HQcoEYJrNJVpcpoqvgBzFGLhZM0tDHS1cW7dFsEaU0b?=
 =?us-ascii?Q?G233AChNkeJcHLD4vs1O0KUB16UlrWQvSNI/C41cwbDSJWfuVeOqozE2BEDT?=
 =?us-ascii?Q?oQ9gWNsUPQY3uGf5M7ZdYPTAT9n6QHfOgkclCCNDycWQMqs/ZJ/GzPyNu2/r?=
 =?us-ascii?Q?hk/1+LdeEewqqFmwcs9UEWFfRgba1nfvad0WG3A5DeYhE2cEoK/KleK2oHc7?=
 =?us-ascii?Q?vWJKMxEWQcQ1JcUoXrYq9dNmzbmlODouzEzBc+ASp4FRZUighfdN4LcGrO38?=
 =?us-ascii?Q?491jasmkh8ukp8ys1yzdXnM1/u3/jKJ1IK5xh9/q/10yw7Qe6Fzmd0eBV47w?=
 =?us-ascii?Q?X/TuvrOLYv3ZUaStvIHjWLTwi1WjxGE967P+0c0QGEamGcgos9DPBUJaQwl2?=
 =?us-ascii?Q?BAEZwp1uTNzSqZBUfhrjDbZ7BOp8+x8b3UGiXsstw8V5BMD6C3Jm3AoK3jNj?=
 =?us-ascii?Q?e5Wu4L273LOmP9p+5ayDslZcRqCIDItouy/QJ+mZMb6oJg8PUO/BYSjnvvB5?=
 =?us-ascii?Q?Szq/dv06lLC/s7UdJ+gd/YzlCQGz+1Xzyr+FlbNkRhOGlDfIG8bevhMn4yAx?=
 =?us-ascii?Q?o2HtBowVf0e8ZV7OsSpIzRz+inmKXrs5CccbuhmoSATUDNKGTTVs0NtXuMho?=
 =?us-ascii?Q?A3opUzBtqVDJPmaol3gALq87idaJNn4ubF38a/dw7slJ/5VmekL4I5LSNhZg?=
 =?us-ascii?Q?sO3qolClNJayd3m+9LwO6kI7W17SZ0m0tAL0HQ/L4g27lckghdhp5oMk7wAu?=
 =?us-ascii?Q?6oloFzwF9peBrUuMwk+iiPvaumypkByLEHGKkUmqR7uwdqEdZKXzaexKlKZg?=
 =?us-ascii?Q?3aQpi3k3CaQaDLvk36Rn0vH0QhNJ+/cELXhMY9eu/UmKWe0yyCUPGKf81xtk?=
 =?us-ascii?Q?y4bgiOsSgfi9YRqJPwgv2wwh4bo4mgxfFj9I/nrfiMK1MKlKDE01/c0FNa7b?=
 =?us-ascii?Q?8uCLJrDCvWS/NKjESAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294aa718-7554-4ab4-dd32-08dd7e52fcaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 08:28:24.7722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M83TyNOF28QdPhK/54Z7SZjdRxywgntKfzqa2TdYkkzGE7pJ6hBgOXVGjyfO9I3RWoZl7DsNjoh2lCeJlYsupQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

It's okay to only check scrub bit so the check includes all the scenarios r=
ather than solely for poison creation. Please also update the kernel messag=
e to "hardware error logged by the scrubber"

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, April 18, 2025 15:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Print kernel message when error logged by scru=
b

Print a kernel message when the scrub bit of status register is set to indi=
cate that errors are being logged by the scrub.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index b4ad163f42a7..2b7b3abdbfc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -120,6 +120,10 @@ static void aca_smu_bank_dump(struct amdgpu_device *ad=
ev, int idx, int total, st
        for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
                RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=3D0=
x%016llx\n",
                              idx + 1, total, aca_regs[i].name, bank->regs[=
aca_regs[i].reg_idx]);
+
+       if (ACA_BANK_ERR_IS_DEFFERED(bank) &&
+           ACA_REG__STATUS__SCRUB(bank->regs[ACA_REG_IDX_STATUS]))
+               RAS_EVENT_LOG(adev, event_id, HW_ERR "Error logged by scrub=
\n");
 }

 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_smu_type type,
--
2.34.1

