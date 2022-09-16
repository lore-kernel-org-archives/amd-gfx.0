Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02374C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 13:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D911810E411;
	Fri, 16 Sep 2022 13:26:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E03910E411
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 13:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2u4B4x4b/BB52eUGnoZoifzNk8P4xYodHX87isrUpium3YOIHvCxMVvDeBEb6//ZXBOVMy/ZiuOsxY5KJcMy0sf+5K1Jigo0beBa/vcC12clI7RWAgmUab/tt06qe8aTXS3dIjVepJYi/6beMa/3GADLeM/qoYlifa8btqmI0maCvK4IOx02z8MPLRNFvBlb8Aww9HNWP/aMfBCgmCRZnKv+0OxeTsuRD9z5eK3ZIckraDUvb0Fll3wcdHol87OdaRP+KGBQZjjqRMiRhbWR4TLfD9v3rlOlHR/rHGQ0V9TU2lds26iLpa1S5HDV09b+SynhMtkvbj6s+tkp+D2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yFM2XSIz9sjes3C+W8wzCYl+Mhvld4MIr/xzOMCEkU=;
 b=OClpKlYAqPpRW4OteX7IiIM2rO8onBri9ZhOQRzcrD6exPtGjWo2MDpvjmS3t/0zkShH3UQIFpTcaz3ECDibmn5RJbwR6Bq48kSPzqY3bs+uOPL6i3PPH8m71YIs1MILH3waqt9w0MzFJc+PF9PWKG7Xj+rLoUjvsM3uSp+87CGOR50IX2ckR+AfQCiqEIhVsCoyxVJ37ZjowuuSHrEUPK+LPRCVrvhlpKnjo6B1+50lsqs5i8bE4izsl/W+5SzYFG7QpRPQWCIwszt3/INaSWW1JA7jjdONwik+URFlvwhBi3N+N8Cg0SRQMWWoC2cjoga+id5x8tZUJ2iGYV3G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yFM2XSIz9sjes3C+W8wzCYl+Mhvld4MIr/xzOMCEkU=;
 b=Hg5KuKIV3+c19GXteI47PKf9/ytqcHGhrTBg6rQidnKKgh1Ma3S3/zLIGRG1mUOOPDfqnoMB0GJNnjswmZ6++STvn4PfiroELKGldPw2K8XcWgngYoLzTYi9RdYeEeQQzjUw/LqLXrkAhvn3fKX6UplPxYi7XY4AfAcrCJpPRYI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 16 Sep
 2022 13:26:03 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3423:feff:10d0:dbd2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3423:feff:10d0:dbd2%7]) with mapi id 15.20.5632.017; Fri, 16 Sep 2022
 13:26:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs
Thread-Topic: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs
Thread-Index: AQHYyYZnOepuIHiUKEuQ04TNdjKzp63iDIx6
Date: Fri, 16 Sep 2022 13:26:03 +0000
Message-ID: <BL1PR12MB5144619A53F9386DF598165FF7489@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220916043859.109621-1-yifan1.zhang@amd.com>
In-Reply-To: <20220916043859.109621-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-16T13:26:02.632Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL3PR12MB6524:EE_
x-ms-office365-filtering-correlation-id: 68f1c83a-38ed-4834-9696-08da97e700ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +U8D/YKpk9ntL8cQKjm6BzO7Rw6PqVtkuahBDyHu1QRoKuvKd+z5iJSrXsR1IwN5NO9/GyWPyTUGweZAB572T6G29pJPAe8WKZZ0qJrYPntNQF52xjSEUdudyKWf2YQzIM32XV1loK1MBZL8DLU1VelNGM/RAWGLb4BoKVveFNEQjuLQI/W6PFz9rSGqvrVVE6uKLAm76il6Cv0K6F3eis6lQ5ddxmrePuXWtvFDDpB7QdoRQqYm6Wrxu1qXijAdl2jkmROBUi7j5QXtGjKWWJy1dWyBm1SLV9Z3NLO03NAvTear3FAsEN6GDcdvp6zNAwyvHfPDzkab0hs2GuUBeZ+2126fKC+hT2YXgfHxKGgGgjYOuVLQoXvsbAQSDRtXB6UN2rvoRa9HD7vTwViZdbSHr339vRyIr1SsUYuuuMmvnO4FyySijMZXPhYlg9IbxfaGDRaSB6PtvqIfExh2iGL1DcephnyUZyXw+LJiQnW5a36S9oajaUAuXO66TXwCIq8LDJOdK0L9p7RB1aC8NRVO52v7nKOSfPOp43itL8OrFNTg1/Q7sGPVs+kSSSIC7YQX9cs9eHMPVlvCQBNfFhpmG8UF90UHqON7yAZBrFWoh4CsfQe6yXefOUpm3wFHT1CAIkL0PtfwUbhditLT0CqN7hrSLrg+/c8GcXQkIZTEX/g2ep6n8AdVzcFp9/zXffTmQDu98matK/Hh17NAy8U7Qh0BDq8yzd67gikJK7A/CAIo7UeKQ2B1cjnY6wosCpLBsHFeIJwVV2UKXdu1Rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(5660300002)(71200400001)(316002)(33656002)(2906002)(52536014)(478600001)(4326008)(122000001)(26005)(66556008)(8676002)(64756008)(110136005)(53546011)(54906003)(186003)(55016003)(86362001)(9686003)(38070700005)(6506007)(19627405001)(76116006)(66476007)(66946007)(41300700001)(8936002)(7696005)(66446008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQ+llQesuT352YdKX063okMDNZmSAb1y+YnkgoydKQVkPpnq81UXgLU1+L2V?=
 =?us-ascii?Q?XxS2fn1IEVf4ddT0p9zTdb5vG8q1J+vAr1uT/pKHaDdbTSvKraZiPLMnB9oD?=
 =?us-ascii?Q?6rUbb1mI2d0eONYm10iKNGcomtAZTZbcgfikuz2bgK73r0rxmUDhYvzONJCD?=
 =?us-ascii?Q?sjObIjYlNDVMIbApOMPD51FI9WSqFtEHSdRmf+LAylk2FrLYg/+v5/pZUHWE?=
 =?us-ascii?Q?bDAtdEivryHgCitaU8AYwY2F9VLKyWymLlpP1+8ruFLtAyZ/T37C2eXO5b1z?=
 =?us-ascii?Q?0PaNLQXNF0Wv/+4IMrwRXPyCByWzCpnLmY0Xjo7s0U4cVTj8iww85nsq1vnh?=
 =?us-ascii?Q?WndtoOig0X7ebjcuBo1aqPSq/UpsaOEotDDK6cbxea8n8m0dAdd8NfsK2rJ8?=
 =?us-ascii?Q?3qbWGgbFmhBdBphotFUuveMi/J7S9+tdNbqAtFrctm8w8mrw/eTQnCxT4hdU?=
 =?us-ascii?Q?RMB8Tz7SgNaip8ubvgQJed002Nv0cKHPWEXF6bawfr22G5jjbes1uP82ebRs?=
 =?us-ascii?Q?wm1oc2SPtF4Oe+UtQTBGUyNvW+S1bQWBxqJFTYZPYQIZvkLadQ//ZvRTXr6i?=
 =?us-ascii?Q?PVCEL4t1E+9yJLi8aoiCSaDXsd2GCYL3qbXuu6CZqqHWK5pvvZ0HW7baYF0c?=
 =?us-ascii?Q?xDWbUlUgggFa4qy5XClRJGrTMAfEFQzUxoum4BokqWRHjO8e7heu1K/0Hccc?=
 =?us-ascii?Q?PKWuqaihX+qawzzqagGXyl6ahSCFuXRK7lKPZVJsTDPik4Im12I5r68Z/12u?=
 =?us-ascii?Q?UUleNwSsSeQ7T9vM9dOp+kA6bUSTkKUpOcsuIoL0eVEACmNY6A6RgQvfCDPf?=
 =?us-ascii?Q?33/tmkt9xOg4PJG17tYeYk3H6Ys3J8Bms3b03MhlW+qf8EGcJgY6ZlkT1wrA?=
 =?us-ascii?Q?GfxP63nkAivHygHEeanT/2lIdrnLTFNGQJE5alecPcdxpOUZhgUflwveoYxK?=
 =?us-ascii?Q?NzxFGt2dvSkPGNoNOMokqoTZhNQfwT1RHdkmRUhvJfQC1xcIFfWokwics32D?=
 =?us-ascii?Q?+0cVwz5rViGBPg8KAinNpFUYpkMhhYzns3S3sCfAyWnAW0RN6xtyaQNwOzaD?=
 =?us-ascii?Q?qXpuJdGSGEDeK4hhXIOLW3qBDU6HNLDwWBtcQU0zUulq18EXxSr71WxsVr03?=
 =?us-ascii?Q?JGKmgsyLmASlBeCBGdM2dWyiEM6ad8G5WNphToG08KO1c714E54mknSC6saK?=
 =?us-ascii?Q?TatC7Fk1fRtHghI7mWDoTVjMjRi+5OZjPKU+p71J86ZVhBGfkbrKRtEXWeVm?=
 =?us-ascii?Q?5kLoBkPCBisTZpQHsLEAvQOd3qXGrzy5SBYMGZ7UIlHpNGP5yguIEiLszhWs?=
 =?us-ascii?Q?BnAuxZJVIcEypDB8te2ytKqz7obS/BDtZAFMb3uGjmvxTOUg3U/Xwg2ECgZ1?=
 =?us-ascii?Q?5tS3S5efpXlH56S1e8nOdiYuEcpzBN6qkg/j026xvAbtXZfjfUKKT41Rgiv+?=
 =?us-ascii?Q?JsIAjjn+O3xEp/rupdwWs/eGDsSRoSgm8RT/XyUOEOGpLYUNPsE4IaSCkeI0?=
 =?us-ascii?Q?kLjSKV1C1NW4+NZhSVUrDWsCtDDQxJyWSxAGnOMViyuXhAjO+92ifd6EmYa1?=
 =?us-ascii?Q?EXlB+sD/lLxJG1w2rWo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144619A53F9386DF598165FF7489BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f1c83a-38ed-4834-9696-08da97e700ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 13:26:03.0715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPioNI+C4fk7jujyNehhC8eCu6LgvgBxU8oXrF1wI4djUfhXqhLzGzsYzA5ebQl2k4HqmsR5RwV9wlYkjvWPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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
Cc: "Huang, Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144619A53F9386DF598165FF7489BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Friday, September 16, 2022 12:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs

This patch addes MES and MES-KIQ version in debugfs.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 1369c25448dc..bb0ed358909f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -328,6 +328,14 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info=
_firmware *fw_info,
                 fw_info->ver =3D adev->psp.cap_fw_version;
                 fw_info->feature =3D adev->psp.cap_feature_version;
                 break;
+       case AMDGPU_INFO_FW_MES_KIQ:
+               fw_info->ver =3D adev->mes.ucode_fw_version[0];
+               fw_info->feature =3D 0;
+               break;
+       case AMDGPU_INFO_FW_MES:
+               fw_info->ver =3D adev->mes.ucode_fw_version[1];
+               fw_info->feature =3D 0;
+               break;
         default:
                 return -EINVAL;
         }
@@ -1581,6 +1589,22 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)
                                 fw_info.feature, fw_info.ver);
         }

+       /* MES_KIQ */
+       query_fw.fw_type =3D AMDGPU_INFO_FW_MES_KIQ;
+       ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
+       if (ret)
+               return ret;
+       seq_printf(m, "MES_KIQ feature version: %u, firmware version: 0x%08=
x\n",
+                  fw_info.feature, fw_info.ver);
+
+       /* MES */
+       query_fw.fw_type =3D AMDGPU_INFO_FW_MES;
+       ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
+       if (ret)
+               return ret;
+       seq_printf(m, "MES feature version: %u, firmware version: 0x%08x\n"=
,
+                  fw_info.feature, fw_info.ver);
+
         seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);

         return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c2c9c674a223..12fdf62730b8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -755,6 +755,10 @@ struct drm_amdgpu_cs_chunk_data {
         #define AMDGPU_INFO_FW_TOC              0x15
         /* Subquery id: Query CAP firmware version */
         #define AMDGPU_INFO_FW_CAP              0x16
+       /* Subquery id: Query MES_KIQ firmware version */
+       #define AMDGPU_INFO_FW_MES_KIQ          0x17
+       /* Subquery id: Query MES firmware version */
+       #define AMDGPU_INFO_FW_MES              0x18

 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED             0x0f
--
2.37.3


--_000_BL1PR12MB5144619A53F9386DF598165FF7489BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yifan Zhang &lt;yifan1.zhang@=
amd.com&gt;<br>
<b>Sent:</b> Friday, September 16, 2022 12:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Tim=
 &lt;Tim.Huang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;; Zhang=
, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch addes MES and MES-KIQ version in debugf=
s.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++=
<br>
&nbsp;include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++++<br>
&nbsp;2 files changed, 28 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 1369c25448dc..bb0ed358909f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -328,6 +328,14 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info=
_firmware *fw_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_info-&gt;ver =3D adev-&gt;psp.cap_fw_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_info-&gt;feature =3D adev-&gt;psp.cap_feature_vers=
ion;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_INFO_FW_MES_KIQ:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_info-&gt;ver =3D adev-&gt;mes.ucode_fw_version[0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_info-&gt;feature =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_INFO_FW_MES:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_info-&gt;ver =3D adev-&gt;mes.ucode_fw_version[1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_info-&gt;feature =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1581,6 +1589,22 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_info.feature, fw_info.ver);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MES_KIQ */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query_fw.fw_type =3D AMDGPU_INFO_FW_M=
ES_KIQ;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_firmware_info(&amp;fw_=
info, &amp;query_fw, adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;MES_KIQ feature v=
ersion: %u, firmware version: 0x%08x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_info.feature, fw_info.ver);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MES */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query_fw.fw_type =3D AMDGPU_INFO_FW_M=
ES;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_firmware_info(&amp;fw_=
info, &amp;query_fw, adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;MES feature versi=
on: %u, firmware version: 0x%08x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_info.feature, fw_info.ver);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;VBIOS =
version: %s\n&quot;, ctx-&gt;vbios_version);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index c2c9c674a223..12fdf62730b8 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -755,6 +755,10 @@ struct drm_amdgpu_cs_chunk_data {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_FW_TOC=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x15<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Subquery id: Query CAP =
firmware version */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_FW_CAP=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x16<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Subquery id: Query MES_KIQ firmwar=
e version */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_FW_MES_KIQ&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x17<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Subquery id: Query MES firmware ve=
rsion */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_FW_MES&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x18<br=
>
&nbsp;<br>
&nbsp;/* number of bytes moved for TTM migration */<br>
&nbsp;#define AMDGPU_INFO_NUM_BYTES_MOVED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0f<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144619A53F9386DF598165FF7489BL1PR12MB5144namp_--
