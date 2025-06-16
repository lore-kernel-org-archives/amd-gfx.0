Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E82C71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 04:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640CF10E277;
	Mon, 16 Jun 2025 04:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/+hIJCq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E434510E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 04:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF5KBPNdMzS1ifJt8mXfVs3fLB6ZBNMguQbma5w8QZHfmRzrVCG54ltHuGz2hG2mcU9OtCZhq4rXfiDiOlcqCy5/BRbX60awiecIcIwLN+uHkSL2G7IB4nGTOKNZ+xFDgNv4A3mgeCuAZD4+EH3WqFAW+hQPAVY+W0D3yCFuifxmrPUhqErOA4NSn6QLomZz9Wn1S0ZR+UzGq9gu5FKSgdwxXBEpBpeKb3Asu1T4T8DKmuGOQU1nS0B6AzvI09Utj8Qjs93/GW+jaodaPhG1+jhRdh3ktQtJmz/Vo5vljsSRIITn8hCdZDbXt7noPyAAvcvZZ0wdNHd5SN8/6Pea4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os9IhgTLfII9RbgKrt4EK5CO+09gdMiHXhK1VEJ+BnA=;
 b=ItqIvgaUYUo/TQ8CQkEzLQ7e8DUbKwVR8u649vKmp1R1TH68dQp3XsM6zpyAC0c9afgxQ6jANidOZIhjYeUJ1zKubYUSd2kcQT/wCkcQadSTGjC1A+htBwMPAgA5qp12vbb3Afs3DgvQ+Bzh7jRQoEORiE3JlfslRWI36huKe3bmPfBSlftKLWYSgLkUQuoN1gw0iP7yoX0I5RJYMqxp4yi8mKIMxEY1hVtMsmCJmGoDVQ95Kf0IOccJ62IpZAF5tWLVXAlj9AXN8VIpBAp9gxsmXXOsJrOVOJWW/TuqISGn/soz3/u+opMPujmZ/zMtjL2gIhiotajhvG5aoFz4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os9IhgTLfII9RbgKrt4EK5CO+09gdMiHXhK1VEJ+BnA=;
 b=O/+hIJCqteMeHjuI9n1Dt4ZDsTi2Dk6RRc8zWkehgmWoHQszWwLPv+ROxW6SHw2lrXtoJmPRq8M1qC5wIOr8SsxM/+eWzUbzxsv1QCs29WzE9RzrLiaxGpQmqbSGdTrNj5tjg0x9UhVmLgyvIbC9mqNWYo7ekb9/tOoLRa7joZI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 04:42:06 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 04:42:06 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Extend bus status check to more cases
Thread-Topic: [PATCH] drm/amdgpu: Extend bus status check to more cases
Thread-Index: AQHb3FNEg7Ek6lvZ60yaTwPGW4CwGLQFOU1A
Date: Mon, 16 Jun 2025 04:42:05 +0000
Message-ID: <DS7PR12MB607182A1AAA249E4653A1FF68E70A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250613110630.837166-1-lijo.lazar@amd.com>
In-Reply-To: <20250613110630.837166-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T04:41:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH2PR12MB9518:EE_
x-ms-office365-filtering-correlation-id: 06e2995f-3b77-42e7-42e1-08ddac90257a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1/DrvcYmsnDjalB0xS5UuwkRfL2N/UtxCNNoX7Eth7hf3rS3AiuTJVMQmjgP?=
 =?us-ascii?Q?/7uNVeHTdcFB8DWaAZY0kN9rygp6cfUD1u1fDKv71eHG6bKdh0HlbvmzGbZU?=
 =?us-ascii?Q?3kKp3uFQbLkPJltkiKloNblYVJ4dPxJ0Lyshy6OJ7MJqMSIXtEOWp/9FcmCn?=
 =?us-ascii?Q?W8KKUMjvhpT6jKWWI2m2WqrDyDM6aFordvMBndjDYj/eBj4o/9dh2H5W/+zl?=
 =?us-ascii?Q?eJRutQzB34heUiG5pV9+yN6GpngWtb7P3yXpdqhOG6xlkb/+Fli3of1U7pDt?=
 =?us-ascii?Q?1BHLpF7E6p3W1E6BUmDtbu8wWI02X37ZbiD+Nx2YkhkGYGPDG9KE0AVxmI/Q?=
 =?us-ascii?Q?wreuQAjjZOXJXA+kohPAK5II/NaH6vULayMeq6r+1XbLFuGWRz4FMK/fbylD?=
 =?us-ascii?Q?7VKObvVYM+nUx325SknKIUO7Jdg3wvr5x7owVUZuDYDU3svdSFN5hxbMTRKQ?=
 =?us-ascii?Q?roiuD307I3ikGW+DX5vE87V857vrLup12Z5yeheCzbQzdrqbVdpsUbi3Emr9?=
 =?us-ascii?Q?o0UEQzaK7NYgMBewd3HGCTz40FuBDHDzaopGDBqm+WRyanqpbUzqLVvtHgZ5?=
 =?us-ascii?Q?YxrffmU4JY6A/E+otr9mpoA6MVJmpDxlC95HOvOeRAmdJnpO2kQfnrIRznE9?=
 =?us-ascii?Q?6Q8x3AImPKZ44hwzoMX4ogQW7/x2lERQ62SNdlQQexg6+1r2Q80nCFfy/K/F?=
 =?us-ascii?Q?Bjrb+xySXSFOlA5g9KHaR/lHuMkAewaNXM3zp7uzF5gP5cpksxR8vi+5trdb?=
 =?us-ascii?Q?HbllOYJciUp0hrCcUbzNcKrrzTlP+W6dzfWxbMASHNYAx8U663/1R6YdUb4S?=
 =?us-ascii?Q?9rmcUjuXMLhPNlSPM/Jz8Xf5g4SCtVGwk3nErubuJ1zlM9n0YvlucPR/zfN4?=
 =?us-ascii?Q?dt/uxqBbEnL+7/QYGXjQTYyAEbJPxheVa6XXrnRH4hGScnU+o7sd34P19Hh4?=
 =?us-ascii?Q?NjKVPmjiQp+dsgOYl+8GQylqKW978KPV/YKcdcjvusvRgXXrvlICrg8KtBQV?=
 =?us-ascii?Q?m2ktDiHQEm2dxqSq+NlYhiziNn1z/fOhNjGJPceAJK2eZTe8NkOD9sTE60Ah?=
 =?us-ascii?Q?W7CyvaopVjaPGEJnKlOEZidHRPKU4d2nWWFn0rkZTV1/vx2VaitdftlsUwiD?=
 =?us-ascii?Q?JPF0Xu+lgzMWnSq1L36UYCe8D7Yia7DbNGAsD/d34RKM4pR5rnQlyP+EJ3Xi?=
 =?us-ascii?Q?nIGlckKYTeOB4TP6jYMj4S8EJ6uI16alaTKxb44kT6ShtlYtjdk4/HP6uQBG?=
 =?us-ascii?Q?2k0Oewv55SZs2fr1VRsZD9RfLyoErtuc5KmeAeE0YBH4f4JEGjDS3TuepgSp?=
 =?us-ascii?Q?EtNdRC0+CG+MHEpamVx97dzm8FgXbxwlbQeVNnxYlcsUmhvCcKAAxUs3UJQ7?=
 =?us-ascii?Q?f60FziZnQgRmRleL2gfGTi8ybGPwlZpOrh31DOJsNv99ysFu1tZaDbn0GzqC?=
 =?us-ascii?Q?f074pLvwBal99DgUy6OuFAPnlZh3cKYoUPi27pVAfWbRci6fBiuITQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FnIHZ5pajda6m84WZN7h7xwPBACtjDmdL+4fSbtYwNcHBSTgF2bZgyJgRzPV?=
 =?us-ascii?Q?Clz3Rd2A8YRHOh05645bs2swaqQUPyjpoZ21jjUroFf9u3aYgCo9eNemoEQ+?=
 =?us-ascii?Q?uRLynMLiq3CpcBY2UHYqo2nSfBg0kCF7Qw4XuMJQw71ed0ijKA9t+mPUdPgc?=
 =?us-ascii?Q?Csm7Ngur5EGw1RXJrpbhYobxDSxH+RVx2pdzmWG2IwUDtGl7TxhuwHzHGhsf?=
 =?us-ascii?Q?IXNJlQFE4hZEaeBtIRaW1/PnLFBJNMfuNebiFfqi83HzxRwJzDUDW+5pw82e?=
 =?us-ascii?Q?WeNod6JR5fbRX7SDkjzLjcQAwpRMCGwmBD0FxiMDx/pJzxdLb0VHBLltwwLG?=
 =?us-ascii?Q?0I9NpFUteBl6pyQuOlCdUiUW+bZvlobseR2+tdSQf6ePmGVWwWcY78u3kS+F?=
 =?us-ascii?Q?PU7nl9oOR6ocEs1Gi16Jjg3H3+Fmx6S87CI/dqdfPbOy63MzjH22X95zKQMt?=
 =?us-ascii?Q?ktcpAHtTIWmco7RdDFmJW4mjCLiZv4+uWd364mEULstmKeoZXAopcWphe9UM?=
 =?us-ascii?Q?s2GoO8RjOVhiA9xu1uNmHbLp54xnBiIEQdjcQsBsVbqr7y+Jp383zXZY+ajp?=
 =?us-ascii?Q?kPbCb66+whGV7A5018XV/U8TD/BDh8e6inuAuTX7MYJE9t1HoOUda/jdxboq?=
 =?us-ascii?Q?MO/VqQ3BaLDJb5SBbe1jdxn69l+sa09IID1dkjKWrVUahr0++2qcpDouZ2x3?=
 =?us-ascii?Q?+sJfw5A5f1ZNS7SRRS+er/+erpb99FdDINT2CKBdYLGdY0FuEsUN+l58aCCo?=
 =?us-ascii?Q?kTTlAEO4Oh0bE5AIoqtzdKon8TcuOldSJnKXVzxk49QITpNPwX6kTq9v8GdI?=
 =?us-ascii?Q?TcTR1p5JZfGmnvn4xsSgf1xajJw0XdHOupQF1nJswAqWpr7nUYRhCfLjC430?=
 =?us-ascii?Q?Z5k4tpTRTBSFXt1tABSGh3ChvAYHNYrMm7lQg9r22DwF+yPG8GnWy8BqWt8x?=
 =?us-ascii?Q?oNC3cdUKeHm+lO1JSh4rakHRzagJ7j1ENeMvIO1XUXWUU/fUt/yyry+8ILhB?=
 =?us-ascii?Q?ysZtzaWPoDfefrgq8ZgSJpyU5Wpl/5lO6rHHT35Pa4HcZon5kvLfIdrbNAen?=
 =?us-ascii?Q?i5DuyJuoqdPRr+HyacQTsp+eMks7fcWGi/CfsiRnGj6gPn7+0WqqHCdjEWMk?=
 =?us-ascii?Q?TigEqWk7c5PActcCkrawDSFgtm9hKAClEkxLBhiBFds6oAgbE7TA6KyADz/+?=
 =?us-ascii?Q?+DKJ7zyFPPJL6Iy1NNr8Yk/IXZif8jDxZKQuipn2+4O7vZe0xEN5/KH5DEXf?=
 =?us-ascii?Q?BUPVg6HArSkclR77eV1hMnGSjPWZAMOlPtNdyhxeWwuH9me2YtGgxvuMcyqd?=
 =?us-ascii?Q?BvS7lmUvhvhWYm68IFzToeMsb4SWVVWsx79eh32jqeJzOzHK9WtwcBGegOnS?=
 =?us-ascii?Q?u2+tmmhQ2wzCnSSXdnKRNZd9NOnRmtbwiZZ0aKM9IJDcSi+YtKSdCVAyPAf/?=
 =?us-ascii?Q?mlNyjqSAy50qzRKpkvv+YrvqFZsHMg803zog9zqKA+2A/Qd3Cp7IkYIoUk+P?=
 =?us-ascii?Q?+eDVn2O2yGJEkIJPP/0Fhrk0qZqJ+2U7x/vFbN3ShwlM4AroGWAaWdnSd8Zh?=
 =?us-ascii?Q?z2Uob0B/HT88zhkjsVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e2995f-3b77-42e7-42e1-08ddac90257a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 04:42:05.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N23RCC8HtjQKsqBYrfieDiZ9T0/NwVJjKfntDHrdlmvzgMT1+0OtF61+Zw12Af/nZWmWGYpmmsGc8pcbQw3KXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 13, 2025 4:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Extend bus status check to more cases

In case of unexpected errors, check if device is alive on the bus.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +------  drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     | 10 ++++++++++
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ea9206ab3ed1..928d28d100f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1780,4 +1780,19 @@ extern const struct attribute_group amdgpu_flash_att=
r_group;

 void amdgpu_set_init_level(struct amdgpu_device *adev,
                           enum amdgpu_init_lvl_id lvl);
+
+static inline int amdgpu_device_bus_status_check(struct amdgpu_device
+*adev) {
+       u32 status;
+       int r;
+
+       r =3D pci_read_config_dword(adev->pdev, PCI_COMMAND, &status);
+       if (r || PCI_POSSIBLE_ERROR(status)) {
+               dev_err(adev->dev, "device lost from bus!");
+               return -ENODEV;
+       }
+
+       return 0;
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2795a34563f4..a968a9cab27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6066,14 +6066,9 @@ static int amdgpu_device_health_check(struct list_he=
ad *device_list_handle)  {
        struct amdgpu_device *tmp_adev;
        int ret =3D 0;
-       u32 status;

        list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-               pci_read_config_dword(tmp_adev->pdev, PCI_COMMAND, &status)=
;
-               if (PCI_POSSIBLE_ERROR(status)) {
-                       dev_err(tmp_adev->dev, "device lost from bus!");
-                       ret =3D -ENODEV;
-               }
+               ret |=3D amdgpu_device_bus_status_check(tmp_adev);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 1c083304ae77..41acc1ce0b3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -353,11 +353,14 @@ static int aqua_vanjaram_query_partition_mode(struct =
amdgpu_xcp_mgr *xcp_mgr)

        if (adev->nbio.funcs->get_compute_partition_mode) {
                mode =3D adev->nbio.funcs->get_compute_partition_mode(adev)=
;
-               if (mode !=3D derv_mode)
+               if (mode !=3D derv_mode) {
                        dev_warn(
                                adev->dev,
                                "Mismatch in compute partition mode - repor=
ted : %d derived : %d",
                                mode, derv_mode);
+                       if (derv_mode =3D=3D AMDGPU_UNKNOWN_COMPUTE_PARTITI=
ON_MODE)
+                               amdgpu_device_bus_status_check(adev);
+               }
        }

        return mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 7eaf58fd7f9a..59f9abd0f7b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -86,6 +86,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 #define SMU_RESP_BUSY_OTHER     0xFC
 #define SMU_RESP_DEBUG_END      0xFB

+#define SMU_RESP_UNEXP (~0U)
 /**
  * __smu_cmn_poll_stat -- poll for a status from the SMU
  * @smu: a pointer to SMU context
@@ -171,6 +172,15 @@ static void __smu_cmn_reg_print_error(struct smu_conte=
xt *smu,
                dev_err_ratelimited(adev->dev,
                                    "SMU: I'm debugging!");
                break;
+       case SMU_RESP_UNEXP:
+               if (amdgpu_device_bus_status_check(smu->adev)) {
+                       /* print error immediately if device is off the bus=
 */
+                       dev_err(adev->dev,
+                               "SMU: response:0x%08X for index:%d param:0x=
%08X message:%s?",
+                               reg_c2pmsg_90, msg_index, param, message);
+                       break;
+               }
+               fallthrough;
        default:
                dev_err_ratelimited(adev->dev,
                                    "SMU: response:0x%08X for index:%d para=
m:0x%08X message:%s?",
--
2.25.1

