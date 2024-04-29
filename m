Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 03:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C7411288E;
	Mon, 29 Apr 2024 03:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/Ic9Gzl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D98611288E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 03:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCup/0on68AoiO42hB+WA7iKlNrPpn4ZYctnNUK25Egdvw6/TwSkZe+qFYobuIFWarAJwBjlAAbboMiPU+/aLaGD6vCGPVodbIJS3Byb/GiZd+cF2SjzVjeApLNBaB6O77TKrBD1nL/E/LepRPyiudK+eGF4z33/eDOIvJYqqetn2Xz+AxekxkYL8nLAa018Sp72ibHlumtgEXp8sB5dZBfmQmbs8iT/w137DPo4zgj7aOjtMbQ+davyq54RkAgguSOF8q5/0rKBY22Ne8/Rqk4OOBBVzN2hueUQqlrDhRuz70W3Ww3Im9Q+S6RaqvqK+W6FpjQv+UiZ3tl4UTZBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grie0yRcxQ4G3L9zkKEJP8JtLkqoAebdJAyqZqxGR/0=;
 b=LXSx5brsFwjZ2oi4n2rCqwMrwWoTTn+qCwyRvHXDa3WkJISg9G8i4MTI7OA6Q4noykgmwyTQqm/K27wSR+xNBC6YW9OejVyAYkbn50Nprfmrnw1kfhBLyjfIV/2nR9JyMw4fujGgQru3KnwAZf3tXUAaYjSwBh9dw9942QSf4EWNI7YXMmRKjUIXiGxVzjtA1hPf6ZKT3SwGjFJfv+Y7b8pdGXBKiYu8VYLBfskikqBkkqf175oswPTCZZuo+KC1QdEqqijn9eH32VUw/tOy0yqASlAHMlyG198muxWj9Nz/JrOtLFj0ekibTKKtWxgfd6H+Ol9pDcG/FvQ7FHView==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grie0yRcxQ4G3L9zkKEJP8JtLkqoAebdJAyqZqxGR/0=;
 b=M/Ic9GzlZtsW1BDilHaM+4j63aZcfBHAAucINhO22ZU9XOoNLM4U1pCSmaFMK23fgK8JgTnf7rHdZVJL/grYwmto0tUo8uB15VwqUbEmB49PC7X66Q48c1rkpVITS7tNu5DZ7Jw7HLOdFUut7nksnfyxzxuOcI3Rf3B7FPY4Hqs=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 03:09:11 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 03:09:10 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Topic: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Index: AQHamTrcGlEc6M/qL0avS3xCrTPhGrF9TkkAgAFEUHA=
Date: Mon, 29 Apr 2024 03:09:10 +0000
Message-ID: <CH2PR12MB4215879C8C0AC75CC85F4189FC1B2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240428070801.376129-1-YiPeng.Chai@amd.com>
 <PH7PR12MB599731EAE3607BA58FAEB27B82142@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599731EAE3607BA58FAEB27B82142@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=064223ac-c921-440f-930e-c0b9b039dfe7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T07:42:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SJ1PR12MB6268:EE_
x-ms-office365-filtering-correlation-id: ba8e0bf3-6cc7-44e3-7e7b-08dc67f9bdbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?EkS8EtPC0h0Qk6/S8ntxnago+H3EiByKmieLZGSZH2kwjD04yqNqKRBFBtTT?=
 =?us-ascii?Q?GZGbgWyPl8uaViuBSeO1kqSTywvzscAXAf4WsvlhiUsH+thntSW+r0Q17YGr?=
 =?us-ascii?Q?H+tTb//2+QYUE/7hr8ZwhZs2nE3INuIv8aJJ1FMyv63jScv0APR2EPjfHuNd?=
 =?us-ascii?Q?soQW97v5ZIA9+7j8fWQT4+AjiallxyHMy/8pb0sp3HGcrb1e5DHPh3ccjTEd?=
 =?us-ascii?Q?0WVr5/YOHqQSmPL8UV4ujpjwug6A637EirJgwdVrzTZKCGalM/Vg9JOiZ+6p?=
 =?us-ascii?Q?rchIp8eBO5Z3BfUbtkgekJeXROHMFhSgkvQTZSiVeE68OpxYf1YvTjo9uu3x?=
 =?us-ascii?Q?IPXOfGifU6FKFXZZc6FArqEeg4PmLDRj2Uc/v62ZJwr4IC7kYeJ4LmFHdtvv?=
 =?us-ascii?Q?MjRDUJuAQ9BwHBbKAIy2xfncG78NpfpnSpDhZKI0uctMoCBtlLy/RB9spixZ?=
 =?us-ascii?Q?aBurejH7OjK+ZsD+1FuMf5wtQRDRvzM4c3N2gxwQ6ze1ZAvSVPufXgfatkYu?=
 =?us-ascii?Q?bOB0Wa6TdRMoJn7yXUYSTHYR7rBuVO85F2cSXjOb1xmo/OdTk8XEFF6aIAp9?=
 =?us-ascii?Q?r+soIjQXDb6rcMC/IGRFpx0lDQusGJX5mHeQM1TDdnNYvTchHgGWG7EkOoic?=
 =?us-ascii?Q?4/Ec/t0kMEZVs7TCzI4PHRAo9wC5xEJ93MTjrRgrT31yrsGV5rsKlZH9lCuD?=
 =?us-ascii?Q?qz8+IY4aGCibycBYYzgLRAMSgEdx+80jCsr9mqi8djt8zLkkIEHVH1fkdd6k?=
 =?us-ascii?Q?7r4Tkt3B8DyTO0P9ewLjnmgQLtwPLx/qGzbZWfR1kTbypapUEljKJ+ljwSrN?=
 =?us-ascii?Q?7MVqWAmPYaWsiogOhiWtfmSwlXCfc8uavRAD6q9ZC3qLIV5hDNK0PVOjpPIU?=
 =?us-ascii?Q?VIsJ1wKlb/MaEW5yGY772Q4OdAHJUdWOldd57VOz8mcy1hNW+w7oU+A/rB6M?=
 =?us-ascii?Q?RuOsHmZv5CeYcmI6tSkBnYY7MMX+/aAJDQH9+OULOkMiGNAEsaohh4XHGqJf?=
 =?us-ascii?Q?JOFatlwkGE/KAfw3VFP4DgkyzXYBH7XyVcX9MqckwIgnDyPTvOpudVOhH12N?=
 =?us-ascii?Q?orYD1gNCHWknIUU18psHEtNw5KFLulYVdlIUeP6bqMB9ISODM/NzxyM22JlA?=
 =?us-ascii?Q?unULx7JhS6q5Is5rv82wtIZ5KhJ3UtNOB7tBW/pk9YH668bkm572R1blvZgB?=
 =?us-ascii?Q?yAQOvsvddgdruEUjTmYvQqQJqgw2iDGJ3D5bC3sIMJrQXLmZeC/myU3ZZsZ9?=
 =?us-ascii?Q?MJtWfQr68xkSuO0r+Eiv+IAxIrGs1s6OQVEMv6nAv0L59pvUo1uTkc2+NYtr?=
 =?us-ascii?Q?xSR/puw6iJHcxsiqCU893oC6XcbSEcDPmMzWL8pkapx0HA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cSDMB1O+z99SawOtDemMontIYksgLL+KzRchEQm1Ev6f1wBJbTuhuKeeUZtu?=
 =?us-ascii?Q?w7PZN5+1q/MhajFYggrHUN8AGXksnvfw3YxEbtTfrIlQVDMzSZ6dUN7yFk/6?=
 =?us-ascii?Q?vZ/hLtgtvgWwN4eN7nN+354rySjaa6mOAqgCJoOxi8c5UCEu2w4AuoG+Rnet?=
 =?us-ascii?Q?C0knnmcR+5QW2fcrp550R7TENzN7Iq3PVDgBL02eMarWud52rUFityNx7OoX?=
 =?us-ascii?Q?FWV2xF2mNJa2EYUIU06CxAbKArKlSlCEaCK4x2EjlzDJvN1KBFwzqWQbmwIG?=
 =?us-ascii?Q?GanZuMqzctxP2bKNg+orP6496UKMjpSF5GKq3RXtkQBTAH9d8tEsS+LrQWWX?=
 =?us-ascii?Q?5qas9ijl1S6KPzERS9jvty02Jv31RuJp7M/Y8iXj0ROccRDUBdNppdUphNRw?=
 =?us-ascii?Q?fQtO7O63AJN8MPACxRls/V8/b5Ni3WwGXTu2L6inP5566NhctGFonKANsiv2?=
 =?us-ascii?Q?MFqIM3mdZkNTIg5AYswAhuHzFC9b2E1N0Lwg6nuXQVLmUxyC9JRLoscj87dB?=
 =?us-ascii?Q?Lz6gOC1zkowT3idleJiuv5s2s/y/2Q1S4pkDu+zDsUlg9P8IejflU7qA0Cwe?=
 =?us-ascii?Q?+dP23mFVQjbAOsdFbJ4aER7wcxBfO/2xSOmmBw9LYRmAOs0D0iSWe9mkrToM?=
 =?us-ascii?Q?6GgCd7+IKRjZrNxjPZZIpacoizeJNdCZgz53VEd6BgkHcN5S1q9ks6mxfykw?=
 =?us-ascii?Q?kAQlw79CPLhbn4JL+7i+eBG4G2XlEk98PadCJPHCdRvu860XiDFEPAjN9gNN?=
 =?us-ascii?Q?4t+9vj8B+W9ZzQrPay0jK97JTeX7gIqDIYR2XjtMT7iknAM2aUS0xI5byEgp?=
 =?us-ascii?Q?tGJr3CrgODOG0mRnTzp1CeA2g/P6JwSyzhbKHKfJxKi0hnuT19W4v9kFZ0zJ?=
 =?us-ascii?Q?M/Q9N3a2QpIiqQTyydw+x970LrMYpm/EmRaGX2h4logJPtQ+S0ZmJp8gbZRE?=
 =?us-ascii?Q?1o5wqvNzCucivQB+ea785JpvZ1tBgi8bL3OHhFzavl+N/1mVJ5eavkgpeeT9?=
 =?us-ascii?Q?QGDauPdbjhHmvAlC/+2GIzAcXMPkceDQSEubISJB3YkVoc8XLNH14MEMkKWI?=
 =?us-ascii?Q?awr/VYNlNIeBy5KGral+0J3+A6g+++R5FoS4UqhCw0nCIaLDw9gjQ5nN9cKu?=
 =?us-ascii?Q?GWyTO+8nemuTAbWW7I4DW3xHyq1PuYdqw2wvMrE9l2d3JIJXdutO+rkaI3Sk?=
 =?us-ascii?Q?PXQXrG38VYaqKzEgdiaPvh7c19MJrL6bvXRcEtWdJd6VM5OObAza+1mJld/+?=
 =?us-ascii?Q?19LyBekvXwokbm7mpruA62RrTE9yGHkYk6q/b+5L4JXTZGwMauuM6SNqdOb1?=
 =?us-ascii?Q?BzfXAXpuHuK+QamwbWZNxlYJhW0znRt3rh3FVqurccuhAjDh/Rvrivmn4LAj?=
 =?us-ascii?Q?fa2YFROLm5qpPTPxeXeWXmD7A5fLX9zMVyOFyfi0vpr0cXMSD3ACJ78p/DG0?=
 =?us-ascii?Q?8U1iIJ/OfkhmzfoGEAe6XCC0sGmsED2VQ/tezuZ2O5l/yP7CJb7eSTedbD9p?=
 =?us-ascii?Q?B7HYS63Z2T1UJvKhZDYugTQw7UHtiVuOIicVKW9Dg+rYVL5N/705q+698uyD?=
 =?us-ascii?Q?37zfDwXpHZjKtcvHX5s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8e0bf3-6cc7-44e3-7e7b-08dc67f9bdbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 03:09:10.7525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RAIuc65uow4A4cOTF3y8lV0XmspRsvXto7HRS7ge31UDkd2noWS4BWSvOEn2J21750NH55EvGKgPQTNnR0wVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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

[AMD Official Use Only - General]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Sunday, April 28, 2024 3:48 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

[AMD Official Use Only - General]

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Sunday, April 28, 2024 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

Add mutex to protect ras shared memory.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 121 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 5583e2d1b12f..fa4fea00f6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1564,6 +1564,66 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
        }
 }

+static int psp_ras_send_cmd(struct psp_context *psp,
+               enum ras_command cmd_id, void *in, void *out) {
+       struct ta_ras_shared_memory *ras_cmd;
+       uint32_t cmd =3D cmd_id;
+       int ret =3D 0;
+
+       mutex_lock(&psp->ras_context.mutex);
+       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
+       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__ENABLE_FEATURES:
+       case TA_RAS_COMMAND__DISABLE_FEATURES:
+               memcpy(&ras_cmd->ras_in_message,
+                       in, sizeof(ras_cmd->ras_in_message));
+               break;
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               memcpy(&ras_cmd->ras_in_message.trigger_error,
+                       in, sizeof(ras_cmd->ras_in_message.trigger_error));
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               memcpy(&ras_cmd->ras_in_message.address,
+                       in, sizeof(ras_cmd->ras_in_message.address));
+               break;
+       default:
+               dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
+               ret =3D -EINVAL;
+               goto err_out;
+       }
+
+       ras_cmd->cmd_id =3D cmd;
+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
[Kevin]:
It's better to check 'ret' value first before use this 'out' data.

Best Regards,
Kevin
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;
+               else if (out)
+                       memcpy(out,
+                               &ras_cmd->ras_out_message.address,
+                               sizeof(ras_cmd->ras_out_message.address));
+               break;
+       default:
+               break;
+       }
+
+err_out:
+       mutex_unlock(&psp->ras_context.mutex);
+
+       return ret;
+}
+
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        struct ta_ras_shared_memory *ras_cmd; @@ -1605,23 +1665,15 @@ int p=
sp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  int psp_ras_ena=
ble_features(struct psp_context *psp,
                union ta_ras_cmd_input *info, bool enable)  {
-       struct ta_ras_shared_memory *ras_cmd;
+       enum ras_command cmd_id;
        int ret;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       if (enable)
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__ENABLE_FEATURES;
-       else
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__DISABLE_FEATURES;
-
-       ras_cmd->ras_in_message =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       cmd_id =3D enable ?
+               TA_RAS_COMMAND__ENABLE_FEATURES : TA_RAS_COMMAND__DISABLE_F=
EATURES;
+       ret =3D psp_ras_send_cmd(psp, cmd_id, info, NULL);
        if (ret)
                return -EINVAL;

@@ -1645,6 +1697,8 @@ int psp_ras_terminate(struct psp_context *psp)

        psp->ras_context.context.initialized =3D false;

+       mutex_destroy(&psp->ras_context.mutex);
+
        return ret;
 }

@@ -1729,9 +1783,10 @@ int psp_ras_initialize(struct psp_context *psp)

        ret =3D psp_ta_load(psp, &psp->ras_context.context);

-       if (!ret && !ras_cmd->ras_status)
+       if (!ret && !ras_cmd->ras_status) {
                psp->ras_context.context.initialized =3D true;
-       else {
+               mutex_init(&psp->ras_context.mutex);
+       } else {
                if (ras_cmd->ras_status)
                        dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_=
cmd->ras_status);

@@ -1745,12 +1800,12 @@ int psp_ras_initialize(struct psp_context *psp)  in=
t psp_ras_trigger_error(struct psp_context *psp,
                          struct ta_ras_trigger_error_input *info, uint32_t=
 instance_mask)  {
-       struct ta_ras_shared_memory *ras_cmd;
        struct amdgpu_device *adev =3D psp->adev;
        int ret;
        uint32_t dev_mask;
+       uint32_t ras_status;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

        switch (info->block_id) {
@@ -1774,13 +1829,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
        dev_mask &=3D AMDGPU_RAS_INST_MASK;
        info->sub_block_index |=3D dev_mask;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__TRIGGER_ERROR;
-       ras_cmd->ras_in_message.trigger_error =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__TRIGGER_ERROR, info,
+ &ras_status);
        if (ret)
                return -EINVAL;

@@ -1790,9 +1840,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
        if (amdgpu_ras_intr_triggered())
                return 0;

-       if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENI=
ED)
+       if (ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
                return -EACCES;
-       else if (ras_cmd->ras_status)
+       else if (ras_status)
                return -EINVAL;

        return 0;
@@ -1802,25 +1852,16 @@ int psp_ras_query_address(struct psp_context *psp,
                          struct ta_ras_query_address_input *addr_in,
                          struct ta_ras_query_address_output *addr_out)  {
-       struct ta_ras_shared_memory *ras_cmd;
        int ret;

-       if (!psp->ras_context.context.initialized)
-               return -EINVAL;
-
-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__QUERY_ADDRESS;
-       ras_cmd->ras_in_message.address =3D *addr_in;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
-       if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+       if (!psp->ras_context.context.initialized ||
+               !addr_in || !addr_out)
                return -EINVAL;

-       *addr_out =3D ras_cmd->ras_out_message.address;
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__QUERY_ADDRESS, addr_in,
+ addr_out);

-       return 0;
+       return ret;
 }
 // ras end

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index ee16f134ae92..686023918ce3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -197,6 +197,7 @@ struct psp_xgmi_context {  struct psp_ras_context {
        struct ta_context               context;
        struct amdgpu_ras               *ras;
+       struct mutex                    mutex;
 };

 #define MEM_TRAIN_SYSTEM_SIGNATURE             0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd..87f213f92d83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size

        context->session_id =3D ta_id;

+       mutex_lock(&psp->ras_context.mutex);
        ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shar=
ed_buf_len);
        if (ret)
                goto err_free_shared_buf; @@ -366,6 +367,7 @@ static ssize_=
t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
                ret =3D -EFAULT;

 err_free_shared_buf:
+       mutex_unlock(&psp->ras_context.mutex);
        kfree(shared_buf);

        return ret;
--
2.34.1


