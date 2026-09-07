Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34F2C79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 10:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515FF10E746;
	Mon,  7 Sep 2026 10:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G4heWlME";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1D310E746
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 10:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5QjLliJ6r7gUeBkSGfA6rwD3zGEqYWJgYovhAIyWw4jc7S3ibpK/nPW6dSDjtpowEJV2tM61Rez4jVTnA0bkdXYHDsr1c20CZmHN4Q08jXr87YSn7NAIIa40DWpo7rcsQaPRNTXmIV5swXMo0xDsHDPU6rNiSNpRdAhXHQucHxi2VsyKiS/j2gDAhXctxyQwbT+IFZYMpzv9zD2j3IUp35rpVquDY5WiGlLCjkeKjdwZv61ShWVJKn7+ZP9fYACWIWcxh5rPiKv0L49Rv4evPMKjd43N8ihCCflEplx0m1qT0tGIGMl0Y7EPBHkIRlaKlAiLncnA+qCbGUvGz823A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnwOVEniWCXXbB9DIh3d7PQeZPEh27Sx51H8N2fVLps=;
 b=L+lHkXtqEHj1HbJStvDG3S8yjQ0Zz9CThFJYXNpxoup0yo3Vl/7o9SEFyjIvgm67RRteQH2HiX9CjdCv7AhltD2yCrapFHbILYR/+zKXwHJrAf0mrclica4khi49+dk7YECb864sb488LvV8cW+PReU+p7C8K/ibpz2GRBlDKjyZq6AcYp+GtanHSi7V6JynR2YESmjTqcU73g8vpm6R2wH9IF7PHrhBQXKs7Iz6YxzQgiJwjZfhKZyV4JJ/eoA5lmNIIic/crJSbRfjPOM3sZ4qZFFIfOPVD+ril8T5CVYyYUR6kFnbwK9t7/OUqq1F3NUxH3UKagD1feCZvCg23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnwOVEniWCXXbB9DIh3d7PQeZPEh27Sx51H8N2fVLps=;
 b=G4heWlMEdlCzgamujmPnWa79bTYeGXLTCng1Q+xAFpOJfqoJ2ZzXD1JklSbPLIJDrRxtZJdUbeQdMJpyrtjigzVtXhWA9Et7jxN73p+COnthCbdSsRUPiqjH0ZnZsKxiuufwJyHkDH9j9s9qYGnbKHxY8TGuUyFRQMT/hVgZ2Dw=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:07:36 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 10:07:36 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Yao, Chengjun" <Chengjun.Yao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Shi, Leslie" <Yuliang.Shi@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal
Thread-Topic: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal
Thread-Index: AQHdOTuT+HcikdHfzkmZTfLjqZhiPLbC0TuAgAAdm/A=
Date: Mon, 7 Sep 2026 10:07:36 +0000
Message-ID: <DM4PR12MB5748DD73CC3EB098700658838EB22@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260831112623.1475796-1-Chengjun.Yao@amd.com>
 <IA1PR12MB95302C0A8E92235524097C6392B22@IA1PR12MB9530.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB95302C0A8E92235524097C6392B22@IA1PR12MB9530.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T06:56:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|PH7PR12MB7188:EE_
x-ms-office365-filtering-correlation-id: 4704c9e3-8227-4edb-1d68-08df0cc7d788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cuKyBlcsOizelPHM6xGXklrhKWig3Ca3W0zLhDiLzmF7npOhJRAIO4m0KGFbFlVn74qP6O8QygGAZGeCU5wv2qp9b2/68ONZD0QUTWV13sLzgZMgMNoIUiLTRYwhHemQ2X/kZ/TFzjwLVzJvebscC1SusY5dZOBi0J48mgj8JcXy3S0j51EPgF6zdQiQKt5cdWbKsq4BWYfoLJHxVsSX6I9ra5JqB0PP7uIE8VappJEMTOva7f9V7oQBQsG+JJADzk6rcB8s3KRxgeZxj5F8doBIWow61z2DGoTraZH1ur/n5LjX2eLw7vCP66GDN3BmiBZpInAVO52dIQlSTJKaF5kjkOpwMFvpY3V+8Z1jsbfuZi6xkz8IYtaZkB6AUd+Av+3H5wTjURkS2o/kVLFW2hA6pC5CdJhEJ2SbstMwPDzkCne3WU7CFh7nefyPJcLY6P+wvzgYDZEVpGHZYFQ3wRLWZBR7NfqUYDuRo0wm/zuRUJ6auCZs45Ahkq69t6klh+0pinxHwAA5FgTojvBMaAZ5TJK6feqn0XwzgqkDFmv8VC+8kxG09fVjyYW2BWdW7FdiEshXs9yRuRbXoCV7xYavgqIE6RcTuurk2LJ0JJtZxvMOkuIj7JgiKtq8Zbz1W+UhcAjTlZ6Tc7A1hVTLtK6K7W3dO6WNb404SUwkDz/XI9fOMLzDnqE68rJuTRQ73tXG39gOhBL2MZpHu5wngwk84auUPhcIDh0EroRzQTI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yclTxIZ7bsY1Kh0/f3sf+yvTbq1DvjFUX0dZzAv2zz0DgjZTzj63qvrnwpzu?=
 =?us-ascii?Q?+g8SgZEQzUm2LTHkhHFtWgm+6Hs4/NrjEiLWc2N5f50UpaKiHcaXe3w9/wv5?=
 =?us-ascii?Q?Qy/ozBZuhtzSweVtN8PiWR/NJYUwmos85sADlQ07A3xtSxwQ+mX//cXtSqOg?=
 =?us-ascii?Q?FHD2Ng5NzFooE4wzNbDAyKcroQBtkC28/Hwu1XYa2IOH0Tl+oHw8jc/0bTpZ?=
 =?us-ascii?Q?F4KyAvstOO9mYb+PDpcQL7x5rj2lLmbI614ndrnoGnvu2s2SgpOGh1jDh7ml?=
 =?us-ascii?Q?0q5rXPuoLL///lxTTqJJhMEYq6RJL9bTsS0Vj8cx0487eeqHxzqMRTLYBhh5?=
 =?us-ascii?Q?za1XzwVQN2U5dQDbXZikUJqeY9eKdXFH6vVccRyq4SklXGAFX1y6IJIYV0Yv?=
 =?us-ascii?Q?YdlUS/2sv2qClHcBiKaKkuZePglKJeXLG6F2P6wt0eHFMJ90tDtsIVjwWv5Y?=
 =?us-ascii?Q?xza8meO/M+Iaag318coJnSScVOGMT87/IYlg9EVX7UkdGMI1b3OrJi6PYBci?=
 =?us-ascii?Q?ri3VMWfOzBF/bLSYzuVvOldSJPy17LrggwTIhGwvaH1/M4UqbTrkyVDL3Kx2?=
 =?us-ascii?Q?wPylD0FMqnjYZLVATD2vMxOFLGl5CdKbF7aJRQLcxxa30UgP6V1vrBpIcgLM?=
 =?us-ascii?Q?cp3dw2VXtuiOyrQWPqug///FYUh8m7ijB5RjnRMqTWCxFawtrFZYvCt3YHsC?=
 =?us-ascii?Q?osMxRv2+nUqjZOWml6cNlwxMjxsI9vdojRSFEZV6wgSY1tz4W55oSh7eIj+V?=
 =?us-ascii?Q?6J55Y1/9nnpj4SLU+pcgKvLlqGEng23/2KFDvyhKPTvZEhk4E+1g2jJaQ49y?=
 =?us-ascii?Q?mF9hsUBacm8Jgm0MYTsfH+EX+6VfrkvAwz97aykaXLzS0VRic6EzfzZG+dGB?=
 =?us-ascii?Q?VN8vDutbNXtU+aP+f1ST/AyHNspUXijW+wbQjRJr5MDJQ3B/HjAKVgZgbrcB?=
 =?us-ascii?Q?DCTcQr7mhcOOiz7STT4n6yBMrq+maCKIZJ5rSwqAPgW+hE48XSW5LWdog6wv?=
 =?us-ascii?Q?4hHER6WrdW7dDQ9oXzkIWUtm40b0tfgt20gDyarMi6EVUKpMhRhuIQUOt5ZT?=
 =?us-ascii?Q?qFyVqpkXMiLEM0c+0rG9Ti6gmHS/3tlTQg5Jshwy6EOBil3rwI0B9DG3Gexo?=
 =?us-ascii?Q?TPJEOOiwpwRnNmnmYgWy2yDpuQoBsI35QoVWDZP2pI7E2Ytz+CbXlcNQu6HJ?=
 =?us-ascii?Q?LPd8sEEWWvlOfWxA12n5pblx5Uu+uzyJtiLy2ynVRUdILpfMTkwYzm29ZWfd?=
 =?us-ascii?Q?M7FPCmjLLA9mjCZqvc6p+2nMoml75uz++us4LweaHLEGNa2qwCHfoMASPHud?=
 =?us-ascii?Q?Oz+JQk6acU3co0bJYsT+gtViBmaHgPz8MWwq/w94XjiQl8SyjJRM1vsyzLCS?=
 =?us-ascii?Q?p/rDGJWIIhZ77E9zDbAZLkbeABg8AiH1Gnf9SUtXpQujcpbUQkvMP8sSk586?=
 =?us-ascii?Q?Ga8Tk4BDzH0Mwy28W3nCBW5pA04lGIKYQvjZR7HfaD3awiSKp7+whnb/Ph94?=
 =?us-ascii?Q?tP0jY1nmgRdaBsUEX9R/rfH0dF04MXGY1iyN2HwHmDa8KUYBuZeD8GXCMKIw?=
 =?us-ascii?Q?ecilcde/siFVg6bfJpN306U4xZV7QNfLGtEHVtJShWJMz/tUBKPyqk0lKrlM?=
 =?us-ascii?Q?NgQu0ShF3Q3t75gP8ILRcYaENA3NohlomTZy5foHzeZFMvF7Q7fjAS88xLUb?=
 =?us-ascii?Q?WBVGIdEIIOMzU4UpDBaiqHaEvE/9o9KhLJfsOEzqrfRMZ92b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4704c9e3-8227-4edb-1d68-08df0cc7d788
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 10:07:36.3644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Bx+3tuCOaVpWjrjrXjpvaDWTL5W5bgJOJAWMF0ho7NJSwBbuXKlmcX5vfnyGkGnm+GZ9ym3nMVnXu6yD/Ikpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Yao, Chengjun <Chengjun.Yao@amd.com>
Sent: Monday, September 7, 2026 1:51 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Shi, Leslie <Yuliang.Sh=
i@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device remova=
l

AMD General

Ping...

-----Original Message-----
From: Chengjun Yao <Chengjun.Yao@amd.com>
Sent: Monday, August 31, 2026 7:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Shi, Leslie <Yuliang.Sh=
i@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>; andrey.grodzovsky@amd.com; Yao, Che=
ngjun <Chengjun.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal

amdgpu_pci_remove() calls drm_dev_unplug() before fini_sw(), so
drm_dev_enter() is already false there and the iounmap() guarded by it is s=
kipped. This .remove path runs on both hot-unplug and plain rmmod, so the r=
egister BAR ioremap mapping leaks one instance per unload.

Unmap rmmio unconditionally (guard only on non-NULL) and drop the now unuse=
d idx.

Fixes: 62d5f9f7110a ("drm/amdgpu: Unmap MMIO mappings when device is not un=
plugged")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 18cfa2dbcc2dc..c175c29040274 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4343,7 +4343,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)

 void amdgpu_device_fini_sw(struct amdgpu_device *adev)  {
-       int i, idx;
+       int i;
        bool px;

        amdgpu_device_ip_fini(adev);
@@ -4385,11 +4385,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ad=
ev)
        if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
                vga_client_unregister(adev->pdev);

-       if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
+       /* Unmap rmmio unconditionally; drm_dev_enter() is false after unpl=
ug */
+       if (adev->rmmio) {
                iounmap(adev->rmmio);
                adev->rmmio =3D NULL;
-               drm_dev_exit(idx);
        }

        if (IS_ENABLED(CONFIG_PERF_EVENTS))
--
2.43.0


