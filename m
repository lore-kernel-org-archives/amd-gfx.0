Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42621C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 05:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF5C10FACD;
	Thu, 18 Apr 2024 05:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mdq/Phgo";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC28D10FACD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 05:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXN5mLuvsV756u/UpTIDZstZQ3sw3beYv1F+9VUIzWSIOvdBr1e5okclavNmU794XpTp6zK6yDEnJbjqgHQas2jw0TYa8TcvkRt+4SfHzz638AdgLu0t20r8RxgiD572z3p3hVnTGrRsDSc1x5tAH35gnPOZi0UDR+iTVHGPaHbRxp7W7VX6TrGivPVZ1Io9Eg0YXf6HI0wFHSCkEffsrIooeeYDI5i9zHV02dh9S9s2O3I54GGxZp0dvs6CHkSETnsc4YFq0myvVr1zXjsW2nDdgldhJOUiwm/mHFDiuo2hswaSLYK28mVmhQ6EeZAXe8b3T9ludVCDjmrTZ34pYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84dLAxOgX8V+V4cq/oBtHkwWESow4VNBuTdrPrCNtX0=;
 b=bHaWlSGLimv2u1soDnphFnvqaLyarCHNZ9bbp44QDUd//MNBmNDHhV6JfrY0+vSpTsD/w35AemEm62Dvv6Gmg6BFltK6eFbmqH7tyEQvMBpb/r7fD8oBZxnPJv9jZC9DX8DXOIoQIdC6AfcmneVtVt6dmY+hqJOefCdSSk86481vdB261+zI2dIKXDiBsJZ0rltapnCa5Br0gS1NfbDRuYqThavQNPyiV3plRovpOI6GTkQR6PbDtjqpjjiD2Rmk0WQhZRSobzNQA0FDd+qYlID7HDjkevxwutujL1Ou3oDrRQjmRFJph0l71Muot7/z1RW7fE/qqqdsdaiwrJgFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84dLAxOgX8V+V4cq/oBtHkwWESow4VNBuTdrPrCNtX0=;
 b=Mdq/PhgoGB550hK3QEmjNAxO3i0BmuN/FgRLytenCu8tO1fmBe4dZbBVDPgkLmgyXW7pAXwWZFxZzhveXP+Ey1ERQ7I9pBXFkYx6ONrqov70tqe+V8WA73oV3nJqhrQ6IMQCooiuQhMUpU+9kIAgOTN7EWHOt/4TXhDD9oIAz2s=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Thu, 18 Apr 2024 05:55:03 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 05:55:03 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Restore config space after reset
Thread-Topic: [PATCH] drm/amd/pm: Restore config space after reset
Thread-Index: AQHakL8KN2lB79TNU0Gb75k+LQpsKLFtiFaQ
Date: Thu, 18 Apr 2024 05:55:03 +0000
Message-ID: <DS7PR12MB607100B567AB144471350A548E0E2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240417120133.167619-1-lijo.lazar@amd.com>
In-Reply-To: <20240417120133.167619-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9c5f079e-38a8-4375-a733-7a520e11e42e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T05:54:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB6605:EE_
x-ms-office365-filtering-correlation-id: f0bbdcf4-8461-47b7-9ca1-08dc5f6c1757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XbHOzqT1+qo2PLF0aBRQcZ2gq7mYX9cDw99L4WmJxcm29cKM5kuiDKZiL9YHA83ZvVCsXhPBQBlJYMfdktghbhUHQccMhTqZ8lTro8LNSl26N3hOYc6xU73y0kcOUhsmlJgkr2pfU212BKlezGd3mnD6t/6C/x2Xb1t7KWNrA7UG2IQ6RDNMDipTR2FQaMvIAGOKPH/5AVR0Z1TdPALEWsILjGoM+Fa+eWcBd6U0eeorQr0Uvhm+fptXJgyoOXqHlEp94lFPpBfvUJ+bLhvahHS7pBxUhfvxtl8+FczhkKdQPQjiqJQkKagfGMgmNrjm1m+MXO5XY+fySV/Muh4i3ez8WZJq/0wu5D4g6VRWA7EZKQudLyESPe5LnKXYvOfMuXlCOyWUIivAVRjv5VvV5hEBHncH6Z6u0ypPrOAYVclkNNgf+7LOsvC4bqNsYRw1MzwVupitAwSFZRcPX+gpaIzyNzQ0YFXBcfpISx3Rcn4DkyZKHwJnc+uxmbGP50YQbN+SgL49DpGJZwZRUVa+xIXQQcHuD3a6qtEXTILKFV6afD6fgSdnUHfzMx1HfhdfKs3n17a7SLukxo5jz1jWLHgGtffVFtfCQ5oDyavVKZBOond9EKCD6e9hOCaMeS8F63sF/wyRBHmVSSkO9v0Q3uuuWMdK+HVmsDOWrPP8ItLsfy69RkC454sRTAiru4AXRVVRkIubv4l5PG4WmICjLBRcjM8vN33wfVT4nr3lvZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xnw5DNMrTE1N38bLGTWPAVUTsA7866EhuK4A1V5vBhQqdfw5R6TemK81C+Nf?=
 =?us-ascii?Q?3aP4Udog88l4wsn1Bfdvz5tl4XP8GLJ0nH1/ozdUtYZjgkMZPr6uXmrkAsFe?=
 =?us-ascii?Q?uE+3V4JH7N4KRxMP/R44KQQpGeNclc92Xt4yqerAAZDNqhoR0voLvND39P4+?=
 =?us-ascii?Q?wp8rGwvIb7gTEErFvi2U+8+rz1MvgwHUsgQsPcyAys1A10/iDKmn+eavsbmK?=
 =?us-ascii?Q?de7jBH8uiSkd+wy5wuMdx+HJZOCYJiIWqqnJJ9Rtr53UCwVVbVJhyYzqYcgp?=
 =?us-ascii?Q?P9isMvMvDzu/+zCn9TGe0XpbM2YLdzyufcC3OjolgAZhzhsxoG5/yaG9zRw0?=
 =?us-ascii?Q?o0bYkIX8vNifepgJmP8TUjxa1jKvc8Ux2RwNBE1SDL/4I++6aZVaL2rxaJz3?=
 =?us-ascii?Q?O1CVEFtOs10FpsF7m3c+AiWOVPs0bN+nI+nh++FfI9b0cJZfHJ0Y29XosxuR?=
 =?us-ascii?Q?kSLcUbLvj6TfDwVHUMDU08hQx84hpQ3YfuAws8ViEahTe47OzSUlRD+XU0Oh?=
 =?us-ascii?Q?4KEKBNa4n3eHuD/+hfXTWyDWSYIymdid2WqOy698WXD42wfw+CsQvMHl9I/3?=
 =?us-ascii?Q?AKN7mnLVU6LN+N5eeY0irgsYW5hlkcFaP7czzg0n2xJ07bsyUXdmvf0Rl3XR?=
 =?us-ascii?Q?6uaM76vcrQD88qIBHqXQ1IGYDadT/45TglDYj/qk4oS5HNrOJqGukkCDim4b?=
 =?us-ascii?Q?3c+Gn4AoIgHPKd1WfLApcqITw5sFRM4gbE6pYrM/zQyPiSu7XwSOxjKpUHMb?=
 =?us-ascii?Q?HcBaPDHXeY4eEBWtp7+TkZH+ZCXpc2gebnqPqolfl3Jbt/G32UINmelmFAUk?=
 =?us-ascii?Q?vJx+hwlkJ6helwehiNooYpCj7cTws4BD0yaq0NJgHF+G+V8WcYYgSMg5vsWZ?=
 =?us-ascii?Q?sZarPSG4GAhTS1+qMxLqBt+6zrptKqX+89J21DL3ktNSv3haX1Rwq2qDW1rB?=
 =?us-ascii?Q?xpUYPVS3td6o6FVqsmhjKw1Y637MJvJtdkz0H0V7DTeUVL4MoeXWfYEix8Qh?=
 =?us-ascii?Q?SiO9+stsmBGvaLimOHT/PHi2vKfEDuRlL+i2AZ04STl7ZtcagICwQKRg+KgO?=
 =?us-ascii?Q?8l6BQ8SpzT/Lh8G/He51tp/+OP+nQhYWXpb5Lk7OAEOmlt4Mg10B8KNhzvCH?=
 =?us-ascii?Q?0QM9ry9CVJAQ4NRxF9SDahslnPQOpPdttTI9Li2ccOIIri9wYsYeAtlCtkaj?=
 =?us-ascii?Q?HO7vbUEblzIIysDx07dIWz+mC8jVhn5JhEQruNSga/2riMCpTXC1fP1dH9ej?=
 =?us-ascii?Q?lIewK1NfSza4TtKqm7yfrAcdzROCOzZCPHPVAaBg3K01Cjfb+5j0LMBl2id/?=
 =?us-ascii?Q?NG8OQAxfEQYJMVkaSMNaEZ4GUcLjhi0OEB12pQrDc47jD3w1szGYxHGZDe2m?=
 =?us-ascii?Q?BUyP+OwHAQ+pT3qQiNqWqB8vd2c0HYAgQCKLP2Cs5oBwRtV+r7zM1l0gUKQc?=
 =?us-ascii?Q?rvG3Z1dWa7JfqSgY1UfxXWLmxtJJ801WMeshJeXag4M7TeSB3RsGoS9SzIus?=
 =?us-ascii?Q?NKMcinFrCVspMwW8mP/sgaPeJ4bhJCV9s8k/IgFIZ5CZzz1s/v3x+5WZUL6X?=
 =?us-ascii?Q?9Nn8fEmQ8YgvIk6TSqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bbdcf4-8461-47b7-9ca1-08dc5f6c1757
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 05:55:03.1945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET77I82gwpkzkZVyoj5PX/6HfZdJyMvdobp0MlJzsskvp2sp0isVdyE5QuZ/5zIntIOOwxaoEEcmYxsLDLGFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, April 17, 2024 5:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Restore config space after reset

During mode-2 reset, pci config space registers are affected at device side=
. However, certain platforms have switches which assign virtual BAR address=
es and returns the same even after device is reset. This affects pci_restor=
e_state() as it doesn't issue another config write, if the value read is sa=
me as the saved value.

Add a workaround to write saved config space values from driver side.
Presently, these switches are in platforms with SMU v13.0.6 SOCs, hence res=
trict the workaround only to those.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 59e5c6256ea2..ef17c8c1bf39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2315,6 +2315,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct sm=
u_context *smu, void **table
        return sizeof(*gpu_metrics);
 }

+static void smu_v13_0_6_restore_pci_config(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+       int i;
+
+       for (i =3D 0; i < 16; i++)
+               pci_write_config_dword(adev->pdev, i * 4,
+                                      adev->pdev->saved_config_space[i]);
+       pci_restore_msi_state(adev->pdev);
+}
+
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)  {
        int ret =3D 0, index;
@@ -2336,6 +2347,20 @@ static int smu_v13_0_6_mode2_reset(struct smu_contex=
t *smu)
        /* Restore the config space saved during init */
        amdgpu_device_load_pci_state(adev->pdev);

+       /* Certain platforms have switches which assign virtual BAR values =
to
+        * devices. OS uses the virtual BAR values and device behind the sw=
itch
+        * is assgined another BAR value. When device's config space regist=
ers
+        * are queried, switch returns the virtual BAR values. When mode-2 =
reset
+        * is performed, switch is unaware of it, and will continue to retu=
rn
+        * the same virtual values to the OS.This affects
+        * pci_restore_config_space() API as it doesn't write the value sav=
ed if
+        * the current value read from config space is the same as what is
+        * saved. As a workaround, make sure the config space is restored
+        * always.
+        */
+       if (!(adev->flags & AMD_IS_APU))
+               smu_v13_0_6_restore_pci_config(smu);
+
        dev_dbg(smu->adev->dev, "wait for reset ack\n");
        do {
                ret =3D smu_cmn_wait_for_response(smu);
--
2.25.1

