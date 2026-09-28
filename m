Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C7C98328
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 03:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE3310E746;
	Mon, 28 Sep 2026 03:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7JynBBX";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0383510E746
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 03:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVVWc+s+WLgeLBXi/C1jmQjBfUElvDAfl24KipZF8vdptKeq+1Nd4oGdmcJDMcAbinbN4flJDE4It4zcuXtFCTzrL5SK/FCdYhXPQx+EA0heWAFlJH9uNRrsJY9t3MpGn8F7wj2l1NWeRvLDzWdE21fwGzIL+H8bCk0JsPEsrgUEzMoQTT6phYq5hxjBU1osI4jcF6TsdkL0Ax6b7+6lPb3P2iDT6U1p8vdHI/x0yUdItG7bn0DQhtHtMR2WZeRobc+2YaRft+DzPMEiiiMmFYzDPd2b1rbZ1ADq8MAY6krlRyBDiaNR2nCGUR2eVFDFk2QrnnUxQAwAxd86Sv6bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5GBwru2oxK3xfp3fp0nErDatn6o9YRRZ0je9ZpnlRE=;
 b=neaIWvPpFZfIPnwyoUI0B/nGuFKSetdXi6N2TVc2PWCuH0rZqqpBekHsvczaLDniSyIQf+Thx7BzePwDb0T8cFIAOc6JtZQzrSMMWoqyS+hrzZpMcIlkyojbR9Z/cSaYO6IaKFH2MbdH2Jdu76hPIjZMAGUGXlUv9+lw/VshoS5X81mIvneIeSH8UaG7L1r2iwUXTRUROAlRvGnJRbpzdkjD7R7p/Hs8vU4J/JrpM76QkgZlwEVNLZN5RlKQvWIGQfop6vlMnlsXzMKYl/4ytSMetXXSsMFYlGnPV8SjqjSz8iAhdLC750jR8shc9LsNIDtvcvnecCzZdc/UqJV6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5GBwru2oxK3xfp3fp0nErDatn6o9YRRZ0je9ZpnlRE=;
 b=C7JynBBXc5VIQSqLBR1Lv/mNCuSSfA677Eo4V0EPDyWLsMudAK7LEuVRX/jLKn5FRh3pTqDFMTYfFgmQwZ1AF1mfd3yzqEmrqK90oYzhB16YLmp63HNuNGuIpZW86wlNkUn/qVT+ijg2rZ8m/rvhwSX9mhAryjiMYstOUk2PGC0=
Received: from IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:31:48 +0000
Received: from IA1PR12MB9032.namprd12.prod.outlook.com
 ([fe80::f46:156c:de1d:2715]) by IA1PR12MB9032.namprd12.prod.outlook.com
 ([fe80::f46:156c:de1d:2715%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:31:48 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
CC: "Ming, Davis" <Davis.Ming@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF
Thread-Index: AQHdS+7twUQwZq6CnUuN2hHDUlfrYbbjW6aQ
Date: Mon, 28 Sep 2026 03:31:47 +0000
Message-ID: <IA1PR12MB90323A67E5FBD9F60E5CDA90FA8D2@IA1PR12MB9032.namprd12.prod.outlook.com>
References: <20260924063519.688340-1-Victor.Zhao@amd.com>
 <20260924063519.688340-2-Victor.Zhao@amd.com>
In-Reply-To: <20260924063519.688340-2-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com,Shaoyun.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-28T03:30:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9032:EE_|SJ2PR12MB9140:EE_
x-ms-office365-filtering-correlation-id: cb84421d-61b7-4a84-d8e9-08df1d11070b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4elSHlWkewlozqoIp51wm8JeuoNTi8r7OOluIaVZIXQOdgZseAsf2WRojsA10b9vkrO7r9st4M4fctVtqFSdfC6KdXUQDlXKP///wG7X1+mi89KunDq5xV1XNADgbOeMhQ/PKJ2/7XOFhPvwk1x6cHOlsxQo1oZXDqA9TTdfiu1vXuf6K6KP232r7b6KzNxxY+mH8HGsOorDLfrP7xSDb/vQzCsDjE83ice7xk2nULcHY+8MoIZKPuJuY3pmnnQDriP1sZVFfWCIqK0BE0miNoby4H2jTyuqWgiviW/Bh5eyoXYF41ye7/Dl9mOBYFj3YL49ZzGK+op66E96kwVEn/CEFv58l1LOjtEiN7c381UI+eDqJb61tkGBexOcF1T1PGoEAEkUAEaDj6LnzIqdJbfxAJNDc3uqksizCuFgAa9qJxYKM+IdhLKuUFD27z2KLOL5K8Ws6Ev6rY2GQKrFSZd3qmYmb1JWOm51PlEbppoqN8//JYDkCbyocZqHnt6IfA9eFhm7IlcmeW9BFwtPeLeZUvp0nBhi0GJC73rDwXApT4AmNtFRZnfgYAt4GwRBN3+ZOA8af69FKQ4sB3DQaOOayDz9Y4xqc4dMaHKsqsfv2Hd4fPJ0YT6Do9dzQBq4NaQxJivNMsspnSStB8dwfSNOdy1AduYn/6X5u0nsji+z50JtBy0lwwzhwlpID5EdoeGdWJwEVWgbO/2gJr76Mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rl2SInV8s2kwjAjFTHNHlPSoqtTJv95nXRapBCuKvQ/MokveQKa7aVm4Pl0k?=
 =?us-ascii?Q?5W0FgUEmB+bG3yLbjeBoN9PtCAtYZiywLSRWkGz5Li/MVIdL5mqonFvdNJx7?=
 =?us-ascii?Q?s32rLtf1ZLKscPl16l9i0g60jdWxu6nMx+3wz7vZrQSxOOBQvexuiLtbmkgl?=
 =?us-ascii?Q?TKKIafzUoHjNA/HDkyATuAvE3DWJaY3NAr+NrTVNP+SLobHZSKqAOtZsMBLO?=
 =?us-ascii?Q?Y8avVf5tZMn3M8oRc7ADzpLU+SkHXtRRBjmBYmf/cdVi6nSIW0UWzUDu+zt5?=
 =?us-ascii?Q?IQZsh8GKk9g8ttz8ZTxRUUCmt2HpSNPKFp+i4MEa1CsbRaMMvX6yE5uZ5ukX?=
 =?us-ascii?Q?+d9qWn9a6jtQyPipEIcPna+WAn/39c2uryx+LaJpxHTff10GVUAb77qDqnEL?=
 =?us-ascii?Q?a8Es9B10/3j9L/LwKkS8acJvyY4EmNkydF3O/ve69W0wvwl7TtZw5AXjlQo/?=
 =?us-ascii?Q?CCHUmqpd5qATrzlpt3o59KhX36XCgYH82iyKF2I7bOCYRsYoB2Lo/AI0JTvc?=
 =?us-ascii?Q?p8cl8ZlBm6Qk5dNM0TJQ9Y/GoMlrTY/83PAOUKz+1XpuTgTOod6Z8VYh0J8Q?=
 =?us-ascii?Q?SXmgLTqFm2YH78IEprLn3rKxWIxeZkUZA68pmtJsGYSZLegfgdXhUZEIQpVI?=
 =?us-ascii?Q?uLrepbdRUyGJXy9tJfzocF6ue/iVqoqcMg10IliKN33ghnGX6mD18SeCI56P?=
 =?us-ascii?Q?ZY4H9lWmQKc10JFlnDt6Smf2IxYXJWGX51oOc5HPQFjSmLI+odMMQPljLINZ?=
 =?us-ascii?Q?l+IhoLJt3eswAAR3Dwxuh7PaCiFxosnxntfeMxQ5VGgSmCoB2SBvsDSV4nKd?=
 =?us-ascii?Q?GAwoSYEj5CetDNtts2E4S9Aqa67xEor0X+lw9Lsuok93ccMdFVp1VQ9qpWm+?=
 =?us-ascii?Q?gAhGUZWw1Th5hocaw6kSmktwmENzcuVaq6szi9vY/MjPXYX2aEs7g4guHTJI?=
 =?us-ascii?Q?aAVR+PyCKsGGuE8KJNZ95XwiTsjcoiL9ADcqV5Q3CrYWD+nQih27pask5z2z?=
 =?us-ascii?Q?RaopQ+DUIFgbNSasCgThPlV7ijWoQV6jsnYuyyT7NTUgmZMNCMfp6xP5HD57?=
 =?us-ascii?Q?eeouLqzHfd6qc7e27Uk4hYm3DBZNfMvh87AKxh/qPyb93HV4muQ/XDUvZykF?=
 =?us-ascii?Q?CqBOydklyOoGtquyqJwXRrGvBiNBH6C56zMm/0PUYkI1EiSpU4TBte194YyN?=
 =?us-ascii?Q?ncGPOH8F3x4KjCok7ycboh5+w3Pzfli3ptjnxgYCRjaQILxDmtqIVqp3EyBz?=
 =?us-ascii?Q?A1SJC8DLPdRm/fiPnmrN6kEYgwuSsZqhTEI6qzgOtiuWIFiM5KYa6c6Vf1YQ?=
 =?us-ascii?Q?7FC6+AaBinSiSsEh5ScqxEPt51y4GTbZ2SzuTurjnS381CbcBQfX9rURBNnk?=
 =?us-ascii?Q?wl4w+EdDdk/YFcOcoWwAJPp06dcZX2oykGUCvhMeKCUctgicMurJYBCHJy73?=
 =?us-ascii?Q?eHaS0qNnFTCKiaKOmJzQrNAv4KCzHJ1G0PQXu0dzRlTcGv/xpmCOi5H9PRM9?=
 =?us-ascii?Q?AmhZKkAc33U3eTJX2exIL0P/RHn8DhRCfRPXOJ8G2UoqwzNxGeJgxF8lZUKZ?=
 =?us-ascii?Q?+8bkNTUKe2JVa6Y0v0BjsGvBs2WpAKAlZFd730HmoJiKM6LqFnUlEeGC/Gpc?=
 =?us-ascii?Q?SMHfwqDI6VDQ4lXQ2Ik+hPffmFqqjNbc4TFXk80aUTMURf5a1acPiqE5NCe3?=
 =?us-ascii?Q?iAGhe7kSC+7RwOuRlZLk7ynnWL3hxJYvTw88sH7BJ0/21mvN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb84421d-61b7-4a84-d8e9-08df1d11070b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:31:47.9501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mf6qPHc0WOO78G2bH/F6PRgjJ1gmhwj1hItXJ+t2ZE3SbrTyFLA5Ixhk7fzM4E2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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

@Lazar, Lijo @Liu, Shaoyun,

Can you help review?

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Thursday, September 24, 2026 2:35 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com=
>
Cc: Ming, Davis <Davis.Ming@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Zhao,=
 Victor <Victor.Zhao@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF

[why]
VF timestamp queries need a TSC sample independent of CP/MES.
The SMUIO path is not safe on VF.

[how]
Capture via RLC_CAPTURE_GPU_CLOCK_COUNT and read the consecutive count regi=
sters with amdgpu_mes_rreg64().

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index d6f70d33201a0..3c8133c94d6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3168,10 +3168,36 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_ip=
_block *ip_block)
        return -ETIMEDOUT;
 }

+static uint64_t gfx_v12_1_get_rlc_gpu_clock_counter(struct
+amdgpu_device *adev) {
+       uint64_t clock =3D 0;
+       uint32_t reg;
+
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return 0;
+       if (amdgpu_device_skip_hw_access(adev) ||
+           !adev->mes.ring[0].sched.ready)
+               goto unlock_reset;
+
+       mutex_lock(&adev->gfx.gpu_clock_mutex);
+       WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1=
);
+       reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+                              regRLC_GPU_CLOCK_COUNT_LSB);
+       clock =3D amdgpu_mes_rreg64(adev, reg, 0);
+       mutex_unlock(&adev->gfx.gpu_clock_mutex);
+
+unlock_reset:
+       up_read(&adev->reset_domain->sem);
+       return clock;
+}
+
 static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev=
)  {
        uint64_t clock =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return gfx_v12_1_get_rlc_gpu_clock_counter(adev);
+
        if (adev->smuio.funcs &&
            adev->smuio.funcs->get_gpu_clock_counter)
                clock =3D adev->smuio.funcs->get_gpu_clock_counter(adev);
--
2.50.1

