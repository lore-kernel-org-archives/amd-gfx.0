Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3F7C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jan 2022 04:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7991138E2;
	Sat,  8 Jan 2022 04:46:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7801138E2
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jan 2022 04:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fThLEv5SHrbT8dVRWrVchDs4JUV2HDpRZORqa0lhUy4Mwpvg3HSIqAISOG/jH2N/9EZ9koEz9B/3vfQetv4dB2bQK1vbKUQp0mhZTANW1JZDrUdWaHiX0C8pot35alwplBm+mcnVebrOzUAf9So5luujw4du1+6lCPVURzOfx9BUjof2y1yY/5E6q3D3K1CBPFvh3ITVsKdPHdgDK74qoneMOBP8UEAxt/elkDrAuK7QEFmacWDJvD3Sj40OrOzdYQB21dorTTDUyK1BZg4wOENsY6tCwdUoFqGrBrYHALZ3mOQuoJUWuZKK/ONagLA/8OdHYBkvoYOT2UpxtRJrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGr9Oy9l+wQsQe9cSxlVSdEtfJ8ZDjD/BbhtBWZwRXM=;
 b=LsmPgAYmWFJyjUxaQpfxoIfNaU41uLiZfLEhzSAFqHlGpRtd82ov8UF2voMCgjgoxmiloYs5aWrwFW0Mq+OAALhO4scGh8JkjGV/LtPMgiQwt+3FvgKe93S0qx0t7bxWz/WuPZhCwjKJcDp3FP4DSF3jzYYuK5zEc/ZmIFdI1eIW6/P3vuQSvYGUs2YS7KIzB3Y42fTJ7POVaAngoFjZI5Z82a5d9KoUsVMHCrS+a+I2bETKQ/eEKgoxZj+mvL3AJj6j9hzmewbqTbwXmpgb87StIjsDZqRvdYKdsIQXtq3HQwCxXry3QwisTXAqVAfUL/YgSQjAttjSocmhdB+p7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGr9Oy9l+wQsQe9cSxlVSdEtfJ8ZDjD/BbhtBWZwRXM=;
 b=124TtaZ8OWmETPf4naTukieunWEd4NhnMYWTBx/ChnHkh0+8wAnizOBsYGn15GchPxnB1ZKhhEtdEEQer8pYXA86gWmHdH3ViFC/Pc0Zxd92rSoPeYB/O7/P/cQylXB1t+DWUYoSphrD23ZLphiKNx8H1+cuaethGcUipGRVEmM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Sat, 8 Jan
 2022 04:46:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 04:46:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Thread-Topic: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Thread-Index: AQHYA782vPatll5F50u8MqRKJHI2b6xYjc6g
Date: Sat, 8 Jan 2022 04:46:35 +0000
Message-ID: <BN9PR12MB525708B7F3FB865CA4BFCC8EFC4E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220107120740.1041489-1-tom.stdenis@amd.com>
In-Reply-To: <20220107120740.1041489-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-08T04:46:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1fe7d959-63cd-41da-a573-6931ef13aea2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d33a3385-18ac-44f3-9337-08d9d261d975
x-ms-traffictypediagnostic: BN9PR12MB5195:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5195869BB6CE44C2E19FA10DFC4E9@BN9PR12MB5195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHgvbFXirPYdigpddIkWb8/JuMpFIKbmsXU3fDeh4AIKKyUKG3c4xqTuNFkUYyG5VlveRgeMPUntfJNunL6eb3dHu186iQlv8xbOJdI7Qr0MG8q3J+nTCqFLuROMIMeOK0LeLwBb7Vt6+46EO1Fx/mfH9xe/kLFn6EtOr5jF1riJwY8imS/2QNjkibQX/XcJ1whlIdwBXC7FSJ1yLzcJqTDzy8KT0AoQE3gx+HpOXNciZpUwoniZ4eoSqcc6sWAvNsVxG3dqlO7B/qVBJM5kTzLONIJziSy4el4VK/hcJjv08KlCxjCew6eyD2fzYR1M9PupZrW2vs3Kk0UfPFAWE8g5+Ih4lpiUoDffQjEB4DAwR2jvOkvcCRvEsXzs/OqOUOXnihixVl6spelQ7CEH7LpBIa7q/VXs31jR8mxGOkJfSyx90zcmIO3JGDKE7XoG+8V6da03eYclVCcewaGk3RyD3WSEjayGO6VE1IeTXoTOAXev4sc0RRi/8yI9Fzf2zLFMz50tZz5zQjxVWUHTRt01ztuWex2POKIXPos+hzP1G2uC/chBfWgMAbVSP1N+RC1w4jwRV0n6+qLJJQCrzAOaUvJoC+9EZlHtdiMscxsYUtqXhAzAPpiEnLFN3I373IWHRhiDSvIQQTdSaX6VURn4/e/qBkX6IYEkJS3kuptZnhsraOzOq5VlO39wOTfbfUr2hXkfs0OxSXNIEBTYXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(122000001)(38100700002)(55016003)(186003)(508600001)(38070700005)(66476007)(66946007)(66446008)(66556008)(76116006)(71200400001)(33656002)(316002)(110136005)(64756008)(2906002)(86362001)(8676002)(26005)(9686003)(8936002)(52536014)(5660300002)(53546011)(4326008)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kKGEv5PyB37a00ZItgv78Bx+p3AuYP4SsmZvp8v7EqjjH+H5oWheuMTPxEes?=
 =?us-ascii?Q?7epV4Ew0AOQWu7+RVF3WF2obJwkHPjP1YTupfKhwadbSzgXDHdnuSepy8dEZ?=
 =?us-ascii?Q?lcjU1IsbGAoWa2p6DC+Zfg5ZXBAvaGLur3t9FPheH15ClQtpuOboFxw8HOc/?=
 =?us-ascii?Q?ssOlbWW8qNYDjhINyAZo6ugq98s1097patnp1+GfA5yMnfbtZPZJkYMZHQkW?=
 =?us-ascii?Q?KfceGCUjPLvBAL8dCzR7GiOeZ+W9xpS6wnOH5VWHvakN8j6yrxGL6jevm33j?=
 =?us-ascii?Q?ryKhy5qckVY4R/F2xmnSnsEDUHXgtbowAMgC0KtlMFp675DixWO+1X4GQl1l?=
 =?us-ascii?Q?DAFb4+e4be7lgOMTdl6S6UqvD2f8jeUtr85NoY9wEBon5Mo1IKW9isyUlcD9?=
 =?us-ascii?Q?Z9fEbq81GytKbuNeUlF+ud+g6uHUjIg342Ai6YzNl8thysZEfVUiNG8IqfhL?=
 =?us-ascii?Q?6EZZ6QG+uCbs/t4byroDg1UY6h0Ex9u6cYkXF17XKSUwuKClWs/U3agxLjH9?=
 =?us-ascii?Q?0jggBpCgAWEAo7iIDCjgmREzc/ppvQfmjnKPxBZIx95d2kYvwn0cJkwl0vl6?=
 =?us-ascii?Q?LPgtM5NJBN5gvDcIMq5ju0luTmuoG8JV0oGyhg6IU7P3LYsI1v2S9Xmc+gRW?=
 =?us-ascii?Q?Q4wLTeily6FkpD1cCMCO4j0r0UF/kI4afzi7zn/2jWyohneOgPohTi8ziL8k?=
 =?us-ascii?Q?Kw5JIDddNx7EaosSvDYMW65MaOmMWvfhC5lve3xr85KB5JoKRnJV+xo2LVZX?=
 =?us-ascii?Q?Ku+K8sugsSoFbY16iv1sUeSFc5t/d4TVK6X3yogJhcYj1+pUJDdd7JAH1n/q?=
 =?us-ascii?Q?0Vc1D8HFyxM+9Ph6l7nAxaCbPufafwyJLxv5wTDDJ7zLm51zBiBsD9TdG4AF?=
 =?us-ascii?Q?upRumZAv7/5IirHjMR9J1oY1LZo/hVchxErBPfQQoz7nKOa89CpYGZ96izf8?=
 =?us-ascii?Q?V87D/v1RNh6SCq5wRLOaHHH6pajeTonHzR0iDGRLh5OupKm7Vucbg2G+F9UD?=
 =?us-ascii?Q?Pl75DTzhhqy/fIPi19PSE+RyMZVySqOsztoJLh8eg0JWNZWSBxf3lvuUWMXY?=
 =?us-ascii?Q?auBjOBiqFvHy9hqnBDYbMdDM+rIgcas8iqK8jvsELJnooZnU1NWfOuf29DHV?=
 =?us-ascii?Q?kb2JbzVTY1qVmbtDk2ZRsMuruNRxmN7WJuHvnTkdsaVDuUnCWen4tdME0Vkn?=
 =?us-ascii?Q?RfL/0DBx+Zeis533ttggCnqOrt014oGfLfRFzhlcM0x7Md5UKYaRHEZArLYV?=
 =?us-ascii?Q?PGqQWxFeDgH4OASiTg+HpSlbg/DHX6NS+w97+KrWZcwWKV6tg+gdLMfze8Ah?=
 =?us-ascii?Q?LpxpEP7hvfvrlaF8ao66hpn+q2RYYbiBM+aOv9YazivG+bX4H7W5W+d/ik+r?=
 =?us-ascii?Q?bK+ZDwxTq01Kaov6WBiX/WhlQRtRO9ok9mZKE2TJ6U3nKHMZQsgIh/neZ4lX?=
 =?us-ascii?Q?JR0HCkbcJ4mGf2i0ss39pt2Oa+DIpR2nhuDlrCOuaQwuBO5grQ51doRK+JIW?=
 =?us-ascii?Q?VAnQKFGyFmhm/PIOYGS/aFY9hQ0cm5LHqhjLEYxb4gk457lFtACOa00HYYHV?=
 =?us-ascii?Q?vLdfri3TeTZ8dLSHFIqSrlQ7eCX68+tVEmnheGTfjph376oU+GTvRPQYb8Ie?=
 =?us-ascii?Q?ADpXp4XmoZMoMPtDmmCteCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33a3385-18ac-44f3-9337-08d9d261d975
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2022 04:46:35.0720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJ7HQ2JwkDPREmGliUzGwd2Pv63v1k18lo7iBaSmKZ3kU3jO6zP4JjB1HTiN9I3ppceQg+/pLDMHb4eGT0nD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tom St D=
enis
Sent: Friday, January 7, 2022 20:08
To: amd-gfx@lists.freedesktop.org
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add pcie indirect support to amdgpu_mm_wre=
g_mmio_rlc()

The function amdgpu_mm_wreg_mmio_rlc() is used by debugfs to write to MMIO =
registers.  It didn't support registers beyond the BAR mapped MMIO space.  =
This adds pcie indirect write support.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c38e0e87090b..53a04095a6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -552,7 +552,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,  }
=20
 /**
- * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC =
path if in range
+ * amdgpu_mm_wreg_mmio_rlc -  write register either with=20
+ direct/indirect mmio or with RLC path if in range
  *
  * this function is invoked only the debugfs register access
  */
@@ -567,6 +567,8 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev=
,
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
 			return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
+	} else if ((reg * 4) >=3D adev->rmmio_size) {
+		adev->pcie_wreg(adev, reg * 4, v);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
--
2.32.0
