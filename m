Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C46CCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 05:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDEE10E379;
	Mon, 13 Oct 2025 05:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WUe8qoUV";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9E310E379
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 05:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9ErzBUi3l2xxO8OxxKauHsxB+om5IhB4c0FdnPylZtE5tGtm7+9mWPNyFf8UkMgSWT7GUFZ6mKlGhM4gHMr1NGmi/tqwLnjIo3lasPdhH0wDxjC5W8df0U4ghhUU6++Sa1rSoFD8TBjzvGUqHi8MKOCSkDqCaC4ZhQBkWx+f6qRH+tgmDc6hD3mN3TSnC1L2cs+74Ro/RgKHoc9JVTeEQq1hCLwsE/PwG8EVsgSp5l94b9ZQPXdSdF0PWLqrZg/nluHewEI2GWlBATn6QOEOyHFGYpHiY70cJbTBOV95UNXcHpbVhsSZf9X4/yTCBMkZnhtacvWCevmo4xc6VYU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgDdHGtfHKSTwmZOmkhxICJwazCAp2qOQAjrGSDvnx8=;
 b=nndsRydKskr32+AIWpUfvvkTC3uWL2zsBgROEHgnqMt3CKEIThnBF4rJpy1c53dQ3TPsFTHe5vuQvNXe2LdPDQEHHQp49Yye0irPgU8ZPXPnNAxYQF7l9EYnQDxrHMvYilGEcSH7uRalzw9uv2nr40S0mHdst8BwUkbTNm41ylnne4YISFqBm6ykpLdwVyDOXTpY68K1ipoY/sQ1oXPUyvV5yt1Go161LHvASkbfFfLrZJyPllUQGyqPtAgOk2THfEVskoDowIPwK2LkAlNYIHQVybNbE86rWq9/vsYGlclneIOZTrun+esOn6apHw8ES1CG9+d27AvmGaxBb6x9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgDdHGtfHKSTwmZOmkhxICJwazCAp2qOQAjrGSDvnx8=;
 b=WUe8qoUVhBAyTupDMHANYlpzjXbbRaNC75wZRZ2ZypqXXYtXkqhjJGQQspaa2s4fh9958Bk9gQbqGPV3BLQmIaLlW/crD17/Znet5F/qRA0F0kcgkGzMQL+ghlAb37blzaekkEQi6qqb47J6fFO5vHp+iC4Duq91nYlnJY9qmqI=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Mon, 13 Oct 2025 05:57:48 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::ea90:cd3d:64e3:7297]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::ea90:cd3d:64e3:7297%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:57:47 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Thread-Index: AQHcObgdjNwMgcXCFkuydjWJKjx9R7S/mQgg
Date: Mon, 13 Oct 2025 05:57:47 +0000
Message-ID: <DM6PR12MB4340C777C6DEBCE54761B816FAEAA@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20251010073246.204178-1-Victor.Zhao@amd.com>
 <20251010073246.204178-2-Victor.Zhao@amd.com>
In-Reply-To: <20251010073246.204178-2-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T05:57:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|SN7PR12MB6768:EE_
x-ms-office365-filtering-correlation-id: dcf57c2f-211c-4863-528b-08de0a1d6f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Az511pt9r0KbNAMl/tBpnOAPK582bnJ1qGWvDOO5UOC+dkE7woHEtBCQ06SP?=
 =?us-ascii?Q?OBmoC+1oQxOZJMLjJSOFd2mRtFnWJHxhFRCaG+Ed4rj+GIVgs5ra/kMuA3aq?=
 =?us-ascii?Q?5iUAV+Ek417jHeK/QCbbUUGA55tvVxjiLAnFWN8gXEP+84b+HZdODS1JGqml?=
 =?us-ascii?Q?/Um2hlshSgF7W0l+ScGiFZAL4Tg1MSPituoUY3oISfAl3p+zqph1JEdpsuYB?=
 =?us-ascii?Q?0HiPCw6gN4OB7hUtx4iBdRZD97eiy6MzucqMlYcC2YnOLg4UD2CEAjWvhE53?=
 =?us-ascii?Q?k7y949eXQV2V2uE318Y+h2QKlyMlOPpgJ088hfcrzKRC0AqvtNdbmzK6LVyk?=
 =?us-ascii?Q?UNqNIYtyMlrqvjrsomq7Gh6rvvFxLk7Ok+mgjnY8jXnsY7oq/4TPR42sPAbu?=
 =?us-ascii?Q?PpTX6QLO8oTFsJ43FBAQGC81qv05cuL5glTkwPUAqtBoPWeEJ1smkIuSvTAf?=
 =?us-ascii?Q?/XHVNZycFzvCfSieIQokfGpgLAby8NgKcJrGN4UJcEXTYU7h1rYp2RFA/8B2?=
 =?us-ascii?Q?tMvaERba/PXlxa5F9OyspRi6gnzefhmRPWBHEKTkUQ8yL56+dFboGs+b0N1x?=
 =?us-ascii?Q?ul2xvlsSXjc97xo0CgznlXzzkGgfYQqSDM6oLaf5pb+nRvX0dM2K4uApkm9K?=
 =?us-ascii?Q?uSFuhg95HE/khu7AEuOJcxvZ/xCf9qUYkQCly00wNLxgmZ0ksNXBaHViP9HK?=
 =?us-ascii?Q?HA+rV9bRivV0u04E2u0hAlOiXQoAruNVR7SLNyPyAlSTGbGStM2/1LFBHmyS?=
 =?us-ascii?Q?jyfWHEfy4KBdimijNIiHTFPKATKXfVhd6OnkXHyWdIWMc3BEa8CchXMigcsz?=
 =?us-ascii?Q?dsiBELjJjekZ70qtEtpcmZ+kqKrHy0+RsvD7m5HVdqb3hQ3uZ4sCgKtGq3I/?=
 =?us-ascii?Q?tU9Tm8E/E4VticKxLecwNLZJ0GZXBhDYE678nmfrcSio4YcqI5v8z4/wOBCJ?=
 =?us-ascii?Q?76nB3f/Qom7flNS3o44ciY9N/u6WM9WM7Q74wBAKC6Aq/LUwOGa3dT5VEZFk?=
 =?us-ascii?Q?E/b4lEx+Xidt4JAyyvUiDmjl8JzxR2M5aD/HfhYB05a3UuRjPJ+8jxZXekr3?=
 =?us-ascii?Q?u8pRWxEdZ3Wnl4h371U6XGBDrYtSw8GmOx7IDLDFfU+xCKDMjADAe/b1vEgZ?=
 =?us-ascii?Q?FQ/4N3CixJnMHzEqHVRZrgF4WwJqGrvCPw4PpEqbP/NQEQ29bMgPXe98oAOS?=
 =?us-ascii?Q?3SpeeRl5bzr1oyZwwONvL7qSvn5qU2YmaYP6eXLsAQ2tHW35qvTbEeW58Tlw?=
 =?us-ascii?Q?kNw8jy28XVCziDH53+Owr/4cbqgXIxBl4iFc65zH8z3lTTBAnYVkgGLTErIM?=
 =?us-ascii?Q?sP2t8dWv/1kDZtdRMQ1mg+SCU+jlMb8gvRCWFx0ghzQgJd1rg8TCzWFGi27h?=
 =?us-ascii?Q?hwlaZThgIZ6IsjcqKo+YznNYDQd5wgpDG5GRYR+58+MvVAfXwtq6Jfu2QCeu?=
 =?us-ascii?Q?Qe1yqSowXsBOzN7DEaIzMlq6w6NIXdk2kgGNoo5JQCGzlcOy7HASIpcq2kmf?=
 =?us-ascii?Q?ljfL9ZZXO9cqv+NmPMJEs1VsYqr9mFlX0LAq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AqjFJtRxVN7NwZJqq71XXLhqtZI8ku1z120ahjAlcLm9ULrdBkqao4PEcg2l?=
 =?us-ascii?Q?rXRRrFapaWVEuWFm8mOH0Xz/DBpnBM6FHyr2lWWBcpFOMPWh3Gv6XqS0JYEC?=
 =?us-ascii?Q?n9iaMiVNP4U9lueigACtm9JxAvOmPDW+UgBCXHIrrpph8u4Pv6gXzFYH6oHd?=
 =?us-ascii?Q?UV9Ymo+i+gEnVaikIxEKXwa/FwOqfQku46e4GwGPeQW48pucRzMfmxtmdRap?=
 =?us-ascii?Q?562nswTA3P/CD16ZiQGSC/h08VakbU+kGWorrHEH8vVvptcr4fWwZHk93RnN?=
 =?us-ascii?Q?7mOVW4Ny36v8ZmyTT35IoWnlGBYSH53ezwO4Ea15X5lTkXg6kS48rgY4RBUQ?=
 =?us-ascii?Q?TjBz3UYemAmxte0H5zsy5DXQqnYhc3PFLFDdlmoML7dC4de6J0uLb9Ca1/n4?=
 =?us-ascii?Q?WoAzR/o3A4nyN8/4o9uZN/sXgZyipeDf4ZrMVvbva+I2pBIxo3m2hlFJd7hU?=
 =?us-ascii?Q?tIrvDJg/DsRNIsAnahj2cZn0lRy8+mMIvLl+irkdj/ICt/t2EtbdEztDgybT?=
 =?us-ascii?Q?pahmXABzChTTg/FhbeMBisjyxgOKUM73/E8lkv5v+BTHqUO7CQCdLZs8VpIG?=
 =?us-ascii?Q?0NbtGGJsWcLz6ey5AmSRbhn6Z20EKZUqGNy98jsKkwS5PIrW9Ed0ufSumk4q?=
 =?us-ascii?Q?yay+bXgbZIH1ogKJ2cF23IorQgGJF0HhhJIHrOGv1RB15x9Rh6t6uFket3nj?=
 =?us-ascii?Q?r3Y/pkDp4bzepVS0WPE/yEJgylIH/wUToJi82MEvyI5hs/2Ie5NXXZEGcFq2?=
 =?us-ascii?Q?wNBGAkmHFfT9mQn7UjX9It0pUVQa9cKGFN8friI8MVQ2dtLSfXIvsl4Zg1hI?=
 =?us-ascii?Q?5Y8Nq25F2pr9vkmslm0w7Kh9gb2ZwWfp+9uyfG7DiG8PZ9TCdOsV71PlMdpE?=
 =?us-ascii?Q?ulLLzA5F2/AFEUKHkkznuDSclUTax3aOH0KUqMvmDFRXxiYlqqN4hSdiPzWg?=
 =?us-ascii?Q?SrHiXBPnKyYq7f9R8wLXEvLDDSmKgzCX+tgQLyxYAzq+MQxSsCd0tJmcxHiz?=
 =?us-ascii?Q?mOkembID164P1igzAOx4LLiN01vq6g80C/RjNoq8D3CtW9Z9ZtPeDBr0v6vL?=
 =?us-ascii?Q?ixD2XzoEI1+zYa0hjEzHHxbY/zRPfQRw1OTf6FqsJs1oMAunMmpwkQrx+cll?=
 =?us-ascii?Q?r1AL0GCekCN+lJOxhA4YevOAqW2ZNbcxTxgijJxJ5CxLnuE7MK5lY9TF5aw6?=
 =?us-ascii?Q?gE0qfRmbiRg883PaJ35VMNxIXRwnZWuh+HLtXPiVzjAZBP8xJiwgSKyXx7wi?=
 =?us-ascii?Q?7Z8eNrWzlmvlIZe2P7UsMocR0nc5fN0OvP6gpTTRIz2AOagHCpC9zHl8lwM9?=
 =?us-ascii?Q?S0N6YERP11//1CzK9RFkLUro3GXC4C/whcnpf5O5PTH/vlLEwW7Q2vEvUuFr?=
 =?us-ascii?Q?SwaJVBtDgbBfftQvBBIX4VeZFNtwQRQ30Ve4+NFwEaFG4VCydOQ6OSvfycDn?=
 =?us-ascii?Q?/dupLREW/xSt72cbTWhegZt8J+MxBbX8L1FhxrMEehsYBv+HmrLDus2IGbKq?=
 =?us-ascii?Q?i8D7xvHkiNMahI7t7IHOMOAuQZ0/kKGdSMC9JvbFeQWZ+7jhZz7NvMMbxmff?=
 =?us-ascii?Q?RJBvpJ7n2TM8fK/NmRk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf57c2f-211c-4863-528b-08de0a1d6f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 05:57:47.5823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gl7umBJym766BphqeHBsq9rwhmsEtRO6lCgMHQAKgnjNAefp2GgAEGrcq7r05p8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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

Ping on the series

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Friday, October 10, 2025 3:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com=
>
Subject: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov

Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for hdp fl=
ush. This register need to be write from CPU for nbif to aware, otherwise i=
t will not work.

Implement amdgpu_kiq_hdp_flush and use kiq to do gpu hdp flush during sriov=
 runtime.

v2:
- fallback to amdgpu_asic_flush_hdp when amdgpu_kiq_hdp_flush failed
- add function amdgpu_mes_hdp_flush

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 71 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
 5 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7a899fb4de29..65cc6f776536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7279,10 +7279,17 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *=
adev,
        if (adev->gmc.xgmi.connected_to_cpu)
                return;

-       if (ring && ring->funcs->emit_hdp_flush)
+       if (ring && ring->funcs->emit_hdp_flush) {
                amdgpu_ring_emit_hdp_flush(ring);
-       else
-               amdgpu_asic_flush_hdp(adev, ring);
+               return;
+       }
+
+       if (!ring && amdgpu_sriov_runtime(adev)) {
+               if (!amdgpu_kiq_hdp_flush(adev))
+                       return;
+       }
+
+       amdgpu_asic_flush_hdp(adev, ring);
 }

 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev, diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_gfx.c
index 7f02e36ccc1e..bf28e8ef6c14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -33,6 +33,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_mes.h"
 #include "nvd.h"

 /* delay 0.1 second to enable gfx off feature */ @@ -1194,6 +1195,75 @@ vo=
id amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, ui=
nt3
        dev_err(adev->dev, "failed to write reg:%x\n", reg);  }

+int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev) {
+       signed long r, cnt =3D 0;
+       unsigned long flags;
+       uint32_t seq;
+       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
+       struct amdgpu_ring *ring =3D &kiq->ring;
+
+       if (amdgpu_device_skip_hw_access(adev))
+               return 0;
+
+       if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
+               return amdgpu_mes_hdp_flush(adev);
+
+       if (!ring->funcs->emit_hdp_flush) {
+               return -ENODEV;
+       }
+
+       spin_lock_irqsave(&kiq->ring_lock, flags);
+       r =3D amdgpu_ring_alloc(ring, 32);
+       if (r)
+               goto failed_unlock;
+
+       amdgpu_ring_emit_hdp_flush(ring);
+       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+       if (r)
+               goto failed_undo;
+
+       amdgpu_ring_commit(ring);
+       spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+       /* don't wait anymore for gpu reset case because this way may
+        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+        * never return if we keep waiting in virt_kiq_rreg, which cause
+        * gpu_recover() hang there.
+        *
+        * also don't wait anymore for IRQ context
+        * */
+       if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
+               goto failed_kiq_hdp_flush;
+
+       might_sleep();
+       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+               if (amdgpu_in_reset(adev))
+                       goto failed_kiq_hdp_flush;
+
+               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
+       }
+
+       if (cnt > MAX_KIQ_REG_TRY) {
+               dev_err(adev->dev, "failed to flush HDP via KIQ timeout\n")=
;
+               return -ETIMEDOUT;
+       }
+
+       return 0;
+
+failed_undo:
+       amdgpu_ring_undo(ring);
+failed_unlock:
+       spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq_hdp_flush:
+       dev_err(adev->dev, "failed to flush HDP via KIQ\n");
+       return r < 0 ? r : -EIO;
+}
+
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)  {
        if (amdgpu_num_kcq =3D=3D -1) {
@@ -2484,3 +2554,4 @@ void amdgpu_debugfs_compute_sched_mask_init(struct am=
dgpu_device *adev)
                            &amdgpu_debugfs_compute_sched_mask_fops);
 #endif
 }
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index fb5f7a0ee029..efd61a1ccc66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *a=
dev,
                                  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_=
t xcc_id);  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, =
uint32_t v, uint32_t xcc_id);
+int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);  void amdgpu_gfx_c=
p_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 8d03e8c9cc6d..be62681b0c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -523,6 +523,18 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device=
 *adev,
        return r;
 }

+int amdgpu_mes_hdp_flush(struct amdgpu_device *adev) {
+       uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+
+       hdp_flush_req_offset =3D adev->nbio.funcs->get_hdp_flush_req_offset=
(adev);
+       hdp_flush_done_offset =3D adev->nbio.funcs->get_hdp_flush_done_offs=
et(adev);
+       ref_and_mask =3D adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
+
+       return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hd=
p_flush_done_offset,
+                                            ref_and_mask, ref_and_mask);
+}
+
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
                                uint64_t process_context_addr,
                                uint32_t spi_gdbg_per_vmid_cntl,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 6b506fc72f58..3a51ace2fa14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -427,6 +427,7 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,  int am=
dgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
                                  uint32_t reg0, uint32_t reg1,
                                  uint32_t ref, uint32_t mask);
+int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
                                uint64_t process_context_addr,
                                uint32_t spi_gdbg_per_vmid_cntl,
--
2.25.1

