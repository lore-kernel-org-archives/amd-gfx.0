Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BCEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 09:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F253310E9BF;
	Fri,  3 Nov 2023 09:23:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EB910E54B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 09:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOyELQrWZXjp6qA2f5e8MrJ8HR61+127jXf3N+pvSfCRygQZzJb4vaU4rtb2ZBFYbjIaDp3QdzRhKri/mhS9wsLPH3k3Op6/w1WD9erCmiRBuf9pqqvs9kk0k+AafintVJDyKCjqZGpu9iYIZz4ok/FspyZ4iVI0t4O2MsCJINhOyu8FXjWak+H6LG379uA1gyDIXxBOQsqG/E48PGiMG0BuP3eM/wIMqJwg/wxIJjFwgYcoqJq0IuLR6Y4wHmzP10Rv7FPGyZia6PqvsjRvPYh6opGc4+rnA9qR6dPiUhPMD8zPVrNkBU+W5OcNKGLSMLEy9tThmKk0yWGOTzaIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrRPefQM38zusU6uxdAss0DcEIyCxJV3TiaDWLrbSh0=;
 b=N2PaFp8LIzLIW7aWdK54sW/EEp0sKaDs2xnzrAgZKh9tqA/o+jD883Anr764LjwF8dkL72L/kQicWlBzOnu3UgoVmmAnkVu1qZuVlmSKZOpssFad/7IIGl8+kWf53FY/HMliW6xm/ySCV+2TnaY8gnn0NiajMcA5iwj6F6M/YBhOoyNvQDdJfwDNKGkB/N0neZRfNPMkAomX9qoKdDmHlvVsnG1sNJfts/hrp12WZyn+5gj/4zqxER69MkKwCF1FJHbJ/BvZ45y21RCa/YRO0YdmQbulI/7cu7TEKPHilBQzEi8MUZpxgyhxZLiIJIVAqnxW3tbkWjOR6n4tYAcoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrRPefQM38zusU6uxdAss0DcEIyCxJV3TiaDWLrbSh0=;
 b=TYsB7Zm7xC2H028BtuJeC8NK5Fb3/oGuJaE7lk/V3akqjpb1DwzGKUluGIkHpXnXmWRIk+l/T0ztBVT87ifJkGnGnVtVXnfseg2i+uNF2TaxWvf3RcfQSQCntRs+WljnxxlYaJJvNMoDEfv3V+tHeLM9kGk8cwFuOaZjBcqa/NI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 09:23:00 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::bf9c:c38a:4080:115c]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::bf9c:c38a:4080:115c%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 09:23:00 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: Hide irrelevant pm device attributes
Thread-Topic: [PATCH 1/2] drm/amd/pm: Hide irrelevant pm device attributes
Thread-Index: AQHaDhr9gDZFF7txIkmGTfnhqt63KrBoUk2Q
Date: Fri, 3 Nov 2023 09:23:00 +0000
Message-ID: <DS7PR12MB60718C760B19F3C38AAD33AF8EA5A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231103055935.481843-1-lijo.lazar@amd.com>
In-Reply-To: <20231103055935.481843-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a056b314-ea56-4e62-b066-3178eb7c9d7a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-03T09:22:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH2PR12MB4858:EE_
x-ms-office365-filtering-correlation-id: 4ea9b093-66d8-4c57-ecf3-08dbdc4e7934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1bcnYoViOuiCp1nlJ0uKppXEclDtbwnlvd+RtA7YoVMi76yzW1sDsHplYe3NbVF091YqLsdNaOYJgrbjKCHi3mC3iwS1bN0ePeGPqXqvqoJ6jOJqZ3vdK9dEbmPyxQBpnoN3kO1vohyb0izVOFf5ApaVpO+t+tE5kk3gy4iLF3D0I825atBELdXS7NPH3ohk+2sZcca2243fizpevl36tthgvArkEwNPBoFJ8b/kwz9JZ3gZjNpsI/4bKLyRmgMi+vUf8fGVPa88ozktjM0w0Uvk6+JVYQoN2b19CWTIbv3P4ExsKLRxbpTfCEiMl8K1YW7x3YzmBF8zc/w3HJp4xJjivaWsZGe6YVWXda2gyVSElgihzkCUjJKXg4CpijhUxmHQSkfuUB1CAEDfV6ZTfU6hOIKbzJ40PF0kPZnYgWCRvGzmWfijiui9S1SBnUN7nGbrQgYrcIumDM2H6Qp4GvZ8jl7fYfoi5QJL3ro9VYCE0BsgQmK3ADFsn+WSVW2r8rOyUk+oZQYFv9hw964pKRZ6NTsTRk7TXZY/OX0tN4CaM1tE6AZLmsWwihzJ8OHpi6JWtdjnAQfJICv6tpGJhwNe/4PljG4hWWg0f4c8kdeDO275T565m/Cfh/sBFnj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66446008)(64756008)(54906003)(66946007)(66476007)(76116006)(66556008)(316002)(478600001)(33656002)(110136005)(26005)(9686003)(38070700009)(71200400001)(83380400001)(53546011)(6506007)(52536014)(7696005)(55016003)(8676002)(8936002)(4326008)(5660300002)(2906002)(41300700001)(38100700002)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pkDX3+5U99YpxOIKraJzWd24rF5zJTH1jczaRPwMyvgrAoxLw224tpMyaMoS?=
 =?us-ascii?Q?mPi5w5xHGnIkoykzzJO0WqOpGevuJmJEy6kt2CmizcNlg3uBVKvmNaGFLFMF?=
 =?us-ascii?Q?9S2zMQX9GZq5sdPibMt4m/CAPDdCyMtliz7NXzPTCmGdLwal/DtNpkLotLR2?=
 =?us-ascii?Q?9FELglQU5MmCKYvzKnidK7WKmXf+UMIYWBWERaKPfFgfJEE9teOpyK5QSk07?=
 =?us-ascii?Q?ft9waBjZRtFOjZx19Fs0+hlOXQ/WlJZMxIxLDKamovL8Z2rEzzT1iEoaZAnN?=
 =?us-ascii?Q?ea3fEGLRzx6IMybpDMORiP0SZz6CGpk7sO6+GVopTRScn9yUlnbFEWNivkjJ?=
 =?us-ascii?Q?lBC3Z5ktJi5Yk9C2wPuheL0Mq/A+4t2dwdAquUox/x7ZwzNUql5R1zo2C5N0?=
 =?us-ascii?Q?uZ6SGUJvdNYsKBkdjkS0cY/GbSyQ5d+9CX/55qnBZs4bScnjJfdVLqOGdUwy?=
 =?us-ascii?Q?uD+rqgPjBSx5A/qOu6F5nr1XnUxkzVhB2qc9ld58eR+DsSQp3qurNEjI4xaP?=
 =?us-ascii?Q?eub6Prwt+o8f06+XDUGyNKsYRlmCPf9vbdw8ghA2obT8fEi4nyh1s2iJRU1c?=
 =?us-ascii?Q?Ca/JHqoFZXlENajolVWbY5V3v5g0h/nOFSUpxHpLkBwz1UXsp//puIRU7IAT?=
 =?us-ascii?Q?RN8pRixS6fmwbN0uZnx+IC5B6tVs7sDw8Q1C+d1aeI25MoRXfYHwIRIb4m/F?=
 =?us-ascii?Q?qzYUZBLc2EtQ4X1LaiEpLyeyaAwpIh1uvi/Y/h7R7ynySE5uLEuKfn854sBt?=
 =?us-ascii?Q?U0qLdB2IOxeeYFEJkT3txWSnqRemJ3cchcl7O3nbFfe+yU1ycXauz77Eawjz?=
 =?us-ascii?Q?gHPlj2Dp3+p3GN7IbnCxc9IzAD66HUF78HEA9qvbpp2WnaFaT4QKOE3N/HP+?=
 =?us-ascii?Q?QE0awmYSrTis11cUKxHeJjr06keM+EfZ1FAn6/Ow7Emp0O86pmoh90Cr4K7x?=
 =?us-ascii?Q?YUcnAguBW+5PdjijmcTBJcoBnqc8syJW5BSdAKTkRDSvgBwe4WKge4pH8vjU?=
 =?us-ascii?Q?58Dnvq5t9sv1w4jcCWztZaq49W3hsviY09joXQeyNUZer2ne8gcPV6MeuTBT?=
 =?us-ascii?Q?r88GiN6+OfXrq8f1VdOcnRqBydgiQCDlyyROdEyeslqi3NoYaC7FKlJobt35?=
 =?us-ascii?Q?AwFK+C12YYqUPHcbcrnd7J7d3KyQdfclKULHKDmnFQHJssBnJgTBla0CJ7q6?=
 =?us-ascii?Q?PWzFyvraJZ6uflIpNK5DblsLXuqdi6FZ/bTqz20iIL+DluArgvEiy5yi6+J4?=
 =?us-ascii?Q?349oTBPGjn59h+ZXPT/mv6IbSc+oFaJxcVAmQoXMLxbpEtFrrg3byenIRw7r?=
 =?us-ascii?Q?cyWLTNbz4rl24zAjDeo9uz5oEOFvBzNmT0IDYQvylyHgu/ZMMaP1+fDxDXRg?=
 =?us-ascii?Q?/WZYKr4xd6d8XJ/+1ragw87Jwxqno3Kc6jnUSDhjiVUFzywAXyOVkjulHP+E?=
 =?us-ascii?Q?KhiHipspRoOgVE24WbgnK9zu3bBEKW0NtyaLbnjkBQsWP7B7ybr1XLhkQFJM?=
 =?us-ascii?Q?FUibznuZG8WCNle507TnuAWujUuDBuXMjDNCsBj//mclY+dYmec6uHDF611+?=
 =?us-ascii?Q?WNA5CX88jXzZ11DHNeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea9b093-66d8-4c57-ecf3-08dbdc4e7934
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 09:23:00.2106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFEi+6qiDCsoB0JpyKZEYXoxBOMCyzw2SZ7kytkfpa9cf9TT5+T6WI1F1CGU09jgNZ0OKfs27p9RCZQg6lVXMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Seies is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, November 3, 2023 11:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Hide irrelevant pm device attributes

Change return code to EOPNOTSUPP for unsupported functions. Use the error c=
ode information to hide sysfs nodes not valid for the SOC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 12 ++++++------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  4 ++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index aed635e2da9c..aed232d107b6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -491,7 +491,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, =
enum amd_pp_sensors senso  int amdgpu_dpm_get_apu_thermal_limit(struct amdg=
pu_device *adev, uint32_t *limit)  {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int ret =3D -EINVAL;
+       int ret =3D -EOPNOTSUPP;

        if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
                mutex_lock(&adev->pm.mutex);
@@ -505,7 +505,7 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_devi=
ce *adev, uint32_t *limit  int amdgpu_dpm_set_apu_thermal_limit(struct amdg=
pu_device *adev, uint32_t limit)  {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int ret =3D -EINVAL;
+       int ret =3D -EOPNOTSUPP;

        if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
                mutex_lock(&adev->pm.mutex);
@@ -1182,7 +1182,7 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev=
)
        int ret =3D 0;

        if (!pp_funcs->get_sclk_od)
-               return 0;
+               return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
        ret =3D pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
@@ -1196,7 +1196,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev=
, uint32_t value)
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;

        if (is_support_sw_smu(adev))
-               return 0;
+               return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
        if (pp_funcs->set_sclk_od)
@@ -1219,7 +1219,7 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev=
)
        int ret =3D 0;

        if (!pp_funcs->get_mclk_od)
-               return 0;
+               return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
        ret =3D pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
@@ -1233,7 +1233,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev=
, uint32_t value)
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;

        if (is_support_sw_smu(adev))
-               return 0;
+               return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
        if (pp_funcs->set_mclk_od)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 6ad957aaef3c..083048131bca 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2237,6 +2237,18 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
        } else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
                if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) =3D=3D XGMI_P=
LPD_NONE)
                        *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_mclk_od)) {
+               if (amdgpu_dpm_get_mclk_od(adev) =3D=3D -EOPNOTSUPP)
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_sclk_od)) {
+               if (amdgpu_dpm_get_sclk_od(adev) =3D=3D -EOPNOTSUPP)
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(apu_thermal_cap)) {
+               u32 limit;
+
+               if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) =3D=3D
+                   -EOPNOTSUPP)
+                       *states =3D ATTR_STATE_UNSUPPORTED;
        }

        switch (gc_ver) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 7fe32cdea5a8..6d6221024d7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2747,7 +2747,7 @@ static int smu_read_sensor(void *handle,

 static int smu_get_apu_thermal_limit(void *handle, uint32_t *limit)  {
-       int ret =3D -EINVAL;
+       int ret =3D -EOPNOTSUPP;
        struct smu_context *smu =3D handle;

        if (smu->ppt_funcs && smu->ppt_funcs->get_apu_thermal_limit)
@@ -2758,7 +2758,7 @@ static int smu_get_apu_thermal_limit(void *handle, ui=
nt32_t *limit)

 static int smu_set_apu_thermal_limit(void *handle, uint32_t limit)  {
-       int ret =3D -EINVAL;
+       int ret =3D -EOPNOTSUPP;
        struct smu_context *smu =3D handle;

        if (smu->ppt_funcs && smu->ppt_funcs->set_apu_thermal_limit)
--
2.25.1

