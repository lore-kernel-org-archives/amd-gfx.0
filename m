Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7EFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 02:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330F110E72B;
	Tue, 14 Dec 2021 02:41:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17D110E72B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 02:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NetpYiCGgrcdOT5JotVn4BVsZHnZn6oq3EQ3kR8sIpxuPcHJX4/To4BG+zpCBGqG+hyUE0okGR3TjNVBxWS7+KW3S4H0w2a4R78fRpJ3SY9RAC8cC3yvwJ/aFKlksbfK0sOupBeAFrmV+1JwOKtid63kA94ho3ZM2UMQ1062sE0u0NYCzz3+Uai0+jiSOl+tktnQG0VIgfe5RDciK48M4/ZRA+eJlVghuJ++1atMUoEkoJl0H69af/at5l3zs7AN53X4Yw9wMM3Vq4zvf0+rnvYjlwuK6ORiDHX0W0X8Y83ORNyP4nguQO60VyTuMentIJbZynWHjOq95PlBGgPKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lp1dOmz/dJrzrhxdniEI4fY7MetZRdPuNNT3rZ2+9o=;
 b=WY/vZWlcDcDuRpf4+g0ZmggRbhngNNCApjj0l5DGOVjU2mfyhN9VEXq57vvlAxNNj6tczjLR48sWjMvWxSX3yOYOwdWCNkZiP3TZu2N9Pn1ugvCyxte7TVlK4/DKyHul6Rws3S/O197mOqE8I+lmX2KLUqfKxHPhnq53Hhn0u9lk0p0NrD8JpOlpediBWIEAAyLSylqYstKy0xH3+aTXFUvQeC89gy/SFiFFDVpvV3efQkFTWKu6W4hddKM40bclYHCyB9RnNqFXyUXSLhhgsAt2853lpDtLW7/w86WQCYGf21ljci8u1E3Q/9l9HYTQC85LrfxUbDuoas3lt4V6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lp1dOmz/dJrzrhxdniEI4fY7MetZRdPuNNT3rZ2+9o=;
 b=Bxdrvo+z+VNN0NJEunI63SMyBRIzsNk30bsQrjRYcfxTZYF+ghxX7HcK8oBFIMhpTe0+NMZ1qm5mbkVdsftSndAg8hWv8LqfV640pSbbpJ+X9ob/bPf95LbPOlX1Z5/bzPPs//n9heNeusZi8o6ceIakNAkNxnaO3qdFFdqeILw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Tue, 14 Dec 2021 02:41:18 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 02:41:17 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Index: AQHX8DNegoTcTUZgC0CbtWZdtakEaawxRa6g
Date: Tue, 14 Dec 2021 02:41:17 +0000
Message-ID: <DM5PR12MB2469F11AABDA9E7A723EA67CF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213150842.21141-1-mario.limonciello@amd.com>
In-Reply-To: <20211213150842.21141-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T02:33:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=39d4bdf5-1728-4f16-baf5-7ceedd5dff86;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T02:41:14Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f6890a90-8b00-4972-98a9-672c767741e1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d584d21f-ca89-414e-42a3-08d9beab347f
x-ms-traffictypediagnostic: DM5PR1201MB0122:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB0122C1592ADC3B2DAFE428FBF1759@DM5PR1201MB0122.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7LuX5sdpFF91kt9itdGCW0ZE7l70ZJiOgOnh7vooJ4ZNXP+j14/qiPgSZcY3f2zeu4NnwHPUAvhuhFAO2ljTNu4N2h3Zih7wdtRnF/ivIcx+Rh6zxA6N4LWwNCeBq/L5J3MkGLSMuZAeyejnQzCMtaxtT6ujEn/Ud+0aw2osyCm+VztewPdApxrVQWSnyyevM4X+P2adreH3HhzGQvjYyx2uunWsMKf0abBV246av4Di+UMEJltn1tGGdojtZjn7OHeulHWlzSFsJlCzGI5phwmChYQ5Gsam1SbVG+NrnPF3NzHrGn7KaHJjkOZUiwXyyxkRNpMpU0HdiGrkGfQZeSG5dvPWhnvTftIacOKNLqpPrSMAonnZDECkBdXazDhplmzZzF0h/DNQ/MdkS6CCY6vlOOWDOAZX4c24Qs3kGYwMgkkV6/spqQjYmEGHonIcPi3ThJkitBTWM8br1v7comBzblhHabvHTibhCYgm3u6nMxV6Iu7AhSPGUG6tTn1t5zZf1hJTlf3Qc673Y0t/hVKAXvF0IMZt5+L7edFIl1EQguMzfKifGqT3q+QTCMgVpkqpFpvKdzcA07P3RJffjy6mNfioNbnHYyQ33gL/DhQINSoAupf9QT1ENsOYZQMioKLpswOcm5nBzhln5tFTTTxjqioUXaPlyEmv1LSBeUCa9hAdRVRychy/44cpyUYJDN+Ufpl3GfwLWCY8Mes/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(4326008)(5660300002)(8676002)(2906002)(38070700005)(38100700002)(122000001)(53546011)(8936002)(7696005)(76116006)(64756008)(83380400001)(26005)(66476007)(66446008)(66556008)(66946007)(52536014)(33656002)(316002)(110136005)(86362001)(9686003)(508600001)(71200400001)(55016003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cK95BN5bOVSlCBfMnUJ8iHkzYjZGXoxmlZq+mYN19W0S3Ydr/cj/uoCcDb4i?=
 =?us-ascii?Q?v5YpOD0YiC5MmQUUKvCgQfN7lcbNms1sFFhTa6a6/UTMYt11z6GDAoxvKv8s?=
 =?us-ascii?Q?ZVkX5zWfwscK86l/rEbtmcfScvcJboWlp70y5uB2R+ti7Ihp+wskNtHbeOoJ?=
 =?us-ascii?Q?+hUNkgbGNOnv5gm80Dlk2tQSzdFfTSEYv04VGBrfBkqVfJTlTbsrxcYD7U9X?=
 =?us-ascii?Q?GXXdKX3tCIoLoIyXwsLQfryyXfyogSNpigZlY252gz1/ClinjUJOBWzOkd1T?=
 =?us-ascii?Q?kvs15WT9CgPGQRc/jOTM07dUKlJn0N6NkXcaiVHTeEZ+SxkFPx4g7gocGz/6?=
 =?us-ascii?Q?LbR0uFdRsNv4hWLyNYj4JhZkNEzdsXgYSDDIkTL64SedUiSb8r8my+x96Kzq?=
 =?us-ascii?Q?F/jx3ec4CB2HtmDcpBfph+ApNM95XXFMr27Fzo88CCvvd7DzOyqmucFwnIo9?=
 =?us-ascii?Q?/Pvw4P1aLf27Y5aFybi0nmXCl+or4LF+2u55xKVvc6gtUt96bfAJx7XAefMx?=
 =?us-ascii?Q?QaJ34V3NU6emIaNa4jkLQtuNqemgh3Shx+dKSOsGfbZTx6HCdLAj+zd4EKyq?=
 =?us-ascii?Q?8l0liTTyxygPXzB6Jp9NgAc2e0X2Ls0dv+xGSCXn0WshGTPERajkEXqwDQUe?=
 =?us-ascii?Q?szU4d7gaIUvClMO65pO4PLm6h4ILPIXj7O8qNzCuaWKFqhvCcbM3IcZL+x5k?=
 =?us-ascii?Q?xn8QpUFk440ersIqYVAayuM/2KbMqS0Z6W2ZfC2T3JqtdQzcVUx92MwwC1J9?=
 =?us-ascii?Q?iA9gVWsPRRAvgt4NkQxf0BLVEwfpP8E1cTUI+FKvYJNyaTGHzHzhemm6BoFC?=
 =?us-ascii?Q?Zx4bEEHoOmyXb32Cs6F3uHf8tRiv/7phF1c1c3BxxU8Cm9lkuw/b3+iWePMT?=
 =?us-ascii?Q?+S6g7n7kKt0Kfl8n+YRsjsKDsMshPfemIkkDA0XoWAWA9VBlF72SyOd8S/Mt?=
 =?us-ascii?Q?Xogj5ik22o4y3h3AZ/Zsnin3O/FdA84RoqjnviZzjZ79caaxGnr2hR6NPk3q?=
 =?us-ascii?Q?cnGtCGwmKkrvFLQPal2gblowd522q3GE5Jrli4YSDEtga0xD4pULQsw3tXl8?=
 =?us-ascii?Q?f3wl7izKIxtkbD1c3vrmwkRJ2Vww5iP4u7TfPDiirObZ6AHEiJ6QWSbcNmm6?=
 =?us-ascii?Q?hFyIVXxBcYRidsh/TIA4fwvxDoQiMpWCH3t0J0g6QdBb7kyEIqB+kD/LqVc3?=
 =?us-ascii?Q?oGr7AkIhy4njJn4VJ9QoKKU2Ah/682s4xLZZkvkJWEIQkZCwwFu1rJUJDP3K?=
 =?us-ascii?Q?Ynq6LCcJJ9uxTC5fke5DdMUj0eU70u4BSyE0DmOrl5fvQ72F6uZ80fUqkrbn?=
 =?us-ascii?Q?VsTQFWxZ59/ijnyGr7y5B/dXbujaNRGULUx0MnXOFeYnex5X03EQW7QO6v+/?=
 =?us-ascii?Q?kV6ucNo8ub00aUlRn/khO7EpFTwTj8GxgBTleTRqKdPgN34w+7cxOln6Dnhs?=
 =?us-ascii?Q?0Cm7QeXcY5vvxSiFJNbHWawFvjVL9k55nm/8K9EQMyNXio0IvXAeYgpdtcWd?=
 =?us-ascii?Q?fCuQvXo/YNJuxttbUFqVEAN3eIky10oC94HjXI3T/t9O5/g4yVo8zjAIRFIR?=
 =?us-ascii?Q?4AXLHGYO0ybRGUVu4cKCaCvgphnapcGWNZGpaPgm7Ie068YaAmYHWYNCi0/V?=
 =?us-ascii?Q?kIXHSuDhDqR94VvTsGtBwnU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d584d21f-ca89-414e-42a3-08d9beab347f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 02:41:17.7357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2qKYXuBLMigwwrLKw7eRPbOJz+cVbCpjO3sMPezsGiu/+52nfHQMqYtiJ/Dk0BXaa2tnnMoYG6Pz6v2P/qQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

A nitpick.

As we have defined a local variable 'adev', so code like 'smu->adev' should=
 be replaced directly by 'adev' in the function to make code clean.

With above addressed, the series is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Monday, December 13, 2021 11:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from amdgpu_=
firmware_info on YC

This value does not get cached into adev->pm.fw_version during startup for =
smu13 like it does for other SMU like smu12.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
* Run on all v13 APU to match v12 behavior  drivers/gpu/drm/amd/pm/swsmu/sm=
u13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..7fdb63da1316 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -196,6 +196,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
=20
 int smu_v13_0_check_fw_version(struct smu_context *smu)  {
+	struct amdgpu_device *adev =3D smu->adev;
 	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
 	uint16_t smu_major;
 	uint8_t smu_minor, smu_debug;
@@ -208,6 +209,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_major =3D (smu_version >> 16) & 0xffff;
 	smu_minor =3D (smu_version >> 8) & 0xff;
 	smu_debug =3D (smu_version >> 0) & 0xff;
+	if (smu->is_apu)
+		adev->pm.fw_version =3D smu_version;
=20
 	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
--
2.25.1
