Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF05C5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 09:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBE610EB44;
	Fri, 23 Feb 2024 09:05:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDolvF2j";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144F210EB44
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 09:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB+7hdFlOOskD6owkzrogGWEx7HwFL+0ZwMun1PK+Hrx2SVmGZm+HAfM56aTcUop759KM0NnEk4ABMso5P+8ZBIWuOjRYXr2sMM6/Z2wgM/3TQp/rp9bLZwMaMnqsS+XV1jOhHdkEmvQiVpk6JoSqWFgibYqhhrvSW6M4c94P0CNLLPONN+tsLzXbQaLL2p4ybrnzSmaMGzJ5Qrx1FnWwMiCUsaajy7lSSYjvDVnjZEJZMR99vyryTij1vXon+og++b+76LPfpISz39okDOMmHHmx3jZs8Y3jIuuKrqUDeTrIPg3tmXKA1w/FYjx7lGgRlcLvbpjqZLvkHr/xsbXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt1VPSrlWkcxwM7ZBUg31wqxjT/BwG7jiDCzoCyrYn0=;
 b=H7UknzMOmzpy4RBde2vE6hRTW/TSdP59FADx6XKFUfnB7w7cyPb9RpA3Ac2964ArQC5CeBxGMyZcGIaZLfiXlWmI9qDeIcydiYct2+Uh9E+avzoffieWv50o3yf7yO67bGcWsQ1kJE0NB6s4bjMnp0IqPLjmIhZrfKMv8xOQAVJPnxBcYQI/tEcrwYPla0HwmX8HhWLKZT822PBRvc0pxJWCD5Bq40367lT88CWZJ6jcD91h7u5j3B7Mfhpec46aIUy+qVxuvo20NF3sxYVIiMjjiT3c1kqwYiRQ2DRbHs1W0oK30EQZAnLJtkI+WbUQYnHK2Co0M/RQ5r5Ki36oig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1VPSrlWkcxwM7ZBUg31wqxjT/BwG7jiDCzoCyrYn0=;
 b=qDolvF2jyEvPx5EpoIA5kskiXO7524tdj/24HcNA/sj4KxIfQcbVsDiouOn06mgO3UX/q67viXeDYHRv/hlFs3qXXI0Qh2ryPxy45NlPsQkibINCOwp8DdB6RIv//AlWfwVmlCpjympf8HNmg/N+TOmboBQjTSd4LGiZ7w3IPgg=
Received: from IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 09:05:25 +0000
Received: from IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::899e:d7d0:9e4b:7c44]) by IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::899e:d7d0:9e4b:7c44%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 09:05:25 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reserve more memory for MES runtime DRAM
Thread-Topic: [PATCH] drm/amdgpu: reserve more memory for MES runtime DRAM
Thread-Index: AQHaZiMWbPntF7coWUq+3WkQm4dSjrEXoYpQ
Date: Fri, 23 Feb 2024 09:05:25 +0000
Message-ID: <IA1PR12MB63564FF0AB65B2E4DCC836D3C1552@IA1PR12MB6356.namprd12.prod.outlook.com>
References: <20240223063801.1940129-1-Tim.Huang@amd.com>
In-Reply-To: <20240223063801.1940129-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e0967d89-b87b-4149-80a9-07b0cce97822;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-23T09:01:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6356:EE_|SA1PR12MB6920:EE_
x-ms-office365-filtering-correlation-id: f0d73ac0-ffbd-4624-022e-08dc344e92f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oIj/1kSyM/nO8DoKW+ba3c/H6qZfzq3tKFlLgzchNvzwLJRbW0QM5irJ/608uOn81sV9a4jG4fPW2DxC5vl0hqZUO/VMAydsQfDUeKF7LOYtZWgFl7wBUFhTnBlX0q5WTVH5wQaIEcd2IK3mDbBtZmlFosCAaZ0yXswAG0AgtL2eoNeTyL/QaMtTmeVdXANSaFv4y8eIglKxKWuy+tBiB15hMBHxt93oJOfh/izFClZk+PWitfOH/mJqVKO+5IsUNvV+kdP55xWSI3gpm9h+B6F8qzb5n7ADecq+S9B8VwKfC/3u5bZORpp3CkEmfTvL7p2qVB7lW/tdqubXfoarlqEqYWJH1PZaPWBaZANZqNijbtUI+707MNi1apHIXoMZiT2b27egdsEUksSq0AT3bYyvxNY4+awWW40IIdSEb4cWFWXlqdItR5oeigJhUkDGvFFvb0f/qg0Pq9f3SVJJYd76mB4+pCOwKh1pAEkeHCin1X9iSwF9mLMA/NnxW63Yr3C62j/KA+oZPmokQpoElPeFRcLUy1vXmLRVpAKdtBCmfvH0hvPaymR8mbfZxMNC9b6JFSPRZY3zPWlZEmbzDcTHvSAOE02Co/9f6nZr7/YaXM3SzHp7pSPys3rY0Va
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PmwpblE6e0CP04JZMxzE3UAzi9veUPokQOBkPMfa+rnpIszEwjSBC1sIjyLj?=
 =?us-ascii?Q?9Knx7k7NnO5q3It472eGtNUTWHbyIzcH6NbGb6zSRfmnXAt44/5HzL1Bblbu?=
 =?us-ascii?Q?kmygRCEpj2btt9cqgsHaivV/RVkLYSzpLxIHt0ht2WV0iBZYQN5+YaGUAaYH?=
 =?us-ascii?Q?/sGrQzs2RbTEwqx12MXMU06gn0seaJo0rWmfbbsAcxjMk76af6FnJHR0beNM?=
 =?us-ascii?Q?6HyxZyMOvMfTIrRfOJXCL1bW6JZ4SUsBbtUEe6Ll8H2sjGkU4Fsxam2VqjYI?=
 =?us-ascii?Q?d7m3GxSGA3CUfmYfNDZreARKjOyjiSgg5Tds3+sCfUn9tAuT1VF9hATSlNTr?=
 =?us-ascii?Q?1TPut13ow+AkyLTzSdcV+u1nH6nnditzU+bN9PZbcx0XvHv2Op8jdbu7SRzy?=
 =?us-ascii?Q?BR9PBtGqJnWTneBd8co48ZsjG0XxkJbFwNU6GN9/RjdUdd2yUPHqhgIuAQFh?=
 =?us-ascii?Q?XBBdhlhKM0d/WDNf1n3jf7Oz16ckZ4d+YgzknCj9wqDy8cZtxgCkI3mSHact?=
 =?us-ascii?Q?sDnEPyv7e4e99Mq3swuzlQXJouj5SwbNmIcA6EnSGfZs/TkPYTqQvXSD+vgg?=
 =?us-ascii?Q?XgkzKHbX+l+Lm/0dPtucsZfEkgrrIBDyQ7jsovX/fpZ40R3Nb+0vkGetR9sJ?=
 =?us-ascii?Q?Evj/BM8VHL2XNJjjeZGGftcmFfNf5ddFE8L/CN3m2umxO1dgGK8fnw4RfXAL?=
 =?us-ascii?Q?ua8hxdm5VkkT3cBLlXY6DjaJbTSBemDf4cycrW7P7IXT+dhJMswSf+A9iiGx?=
 =?us-ascii?Q?1brLWDHUWCm4A5e0wl/sbjAJhjnMldNgXo9ulZdTjO5KHjkA+b32l8FkB+vh?=
 =?us-ascii?Q?WIkwtd7LlfkDpfaTHCCN3S3VCphEyO1aY8QFl+6WAOcmogqsOLax/WxpPSXQ?=
 =?us-ascii?Q?Ntqg5IIV1vPVqHi+32QRYG3LfY47GlsTEXAnVMBNvlXjU9D+EZU69nyLiFWN?=
 =?us-ascii?Q?4NTowPeaMsGC+EEk0R0oGgJNSWnpcCN23llvIywq8mFWhIv4qDaugUlgWb26?=
 =?us-ascii?Q?AZdBGv/HxsxuYo0i5claEot2ReU4ENl6wZAHtzymeOiGo52J4htp8WoqBHVe?=
 =?us-ascii?Q?+Rj0T1CHRxrWwe5ZAD1rYOxVMOuXW10EvYTmxfJAF3l+9W4jTrYYvwFrOaOk?=
 =?us-ascii?Q?j3KXaWpFk8L6t7C6nVPogpGEQHx1+YOyfk6y6nBiro4uRMxP1C23q6okdohz?=
 =?us-ascii?Q?pIBzITA3b70DTVJvk7U+H6VTibdw2luI8ZOJVs7ztkA/c7uc2C0DYriGroJU?=
 =?us-ascii?Q?yKNLfOMC4Ayr9H3Q+uuRmJuSJXRyERPy+9jBC0JGzY592y1qqb1n4FIX7hW2?=
 =?us-ascii?Q?QbSsLsGeYU2EHKc1USlEhwEhOFY/0pRASjdByCeDtplxCTL8h/9Rg8oqn+5c?=
 =?us-ascii?Q?2YPOTNpFFo67hBRhV0JDWXyOQYEBqrnwaA31C2g0JsnDVAPHrUziNXe2S1b+?=
 =?us-ascii?Q?BYjrZDcR9ZD+OnTQcEqlmIzsOECYmtCOOXCh2fvl5Lub2K89vQlWnTPVJ4f+?=
 =?us-ascii?Q?NRGNPWhaFQDO57FF4hXA55Bk0moXkHxvIRdKEToQarBxv7QGX3ElBeXuFdoc?=
 =?us-ascii?Q?XDGkFT9f6tk3f/oaHL4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d73ac0-ffbd-4624-022e-08dc344e92f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 09:05:25.7379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8lO2jIGWSAH12tsBOWlY23e2yAcr+iqBHV62k2gJ5dJxhrA+b6hMC6XdQUceXNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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

This patch is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, February 23, 2024 2:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: reserve more memory for MES runtime DRAM

This patch fixes a MES firmware boot failure issue when backdoor loading th=
e MES firmware.

MES firmware runtime DRAM size is changed to 512k, the driver needs to rese=
rve this amount of memory in FB, otherwise adjacent memory will be overwrit=
ten by the MES firmware startup code.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 26d71a22395d..36127e204dfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -56,6 +56,7 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *ad=
ev);  static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);

 #define MES_EOP_SIZE   2048
+#define GFX_MES_DRAM_SIZE      0x80000

 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)  { @@ -475,7=
 +476,13 @@ static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_d=
evice *adev,
                   le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes));
        fw_size =3D le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);

-       r =3D amdgpu_bo_create_reserved(adev, fw_size,
+       if (fw_size > GFX_MES_DRAM_SIZE) {
+               dev_err(adev->dev, "PIPE%d ucode data fw size (%d) is great=
er than dram size (%d)\n",
+                       pipe, fw_size, GFX_MES_DRAM_SIZE);
+               return -EINVAL;
+       }
+
+       r =3D amdgpu_bo_create_reserved(adev, GFX_MES_DRAM_SIZE,
                                      64 * 1024,
                                      AMDGPU_GEM_DOMAIN_VRAM |
                                      AMDGPU_GEM_DOMAIN_GTT,
@@ -611,8 +618,8 @@ static int mes_v11_0_load_microcode(struct amdgpu_devic=
e *adev,
        WREG32_SOC15(GC, 0, regCP_MES_MDBASE_HI,
                     upper_32_bits(adev->mes.data_fw_gpu_addr[pipe]));

-       /* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
-       WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);
+       /* Set 0x7FFFF (512K-1) to CP_MES_MDBOUND_LO */
+       WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x7FFFF);

        if (prime_icache) {
                /* invalidate ICACHE */
--
2.39.2

