Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BADC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 08:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C05610EA14;
	Fri, 11 Feb 2022 08:06:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F8710EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 08:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3knhPCIWhb0uCwCp/MS5ogv8w1AGSCYPdBqyTyiaGTk3qUF38GMAB4tcXkIh6hwaUovFXOIugqZr74LR2e1amaAO3AL9LRg0LT6kw13KBAJOPUFIiNh1G0BqfApMd2L4vfHG6kwzMM/kviL7035T+xBYGDyaV1zgEd3H/V8iqUG+SxF6BBu3+M2mO6nxnLhZn/k90IL0heR3FVUM1RDrS8Lk3qjE98FlxbMf3JwglL2nFAYRhan9f1hNDsVEp6hC1GUpHbS7YlIT7BHv2E/R98JbefBBpwz0vNhwTR4nOKv+aynjixyHa9/IDx5lGIGoWYwkY76BgrtVDwqJNdpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/NsY3VCgwxlDE+e2teaG328AUvw2pOQ/7dkJUAghII=;
 b=Gqw8HovB4fa6hQwfB8106E/UPcgswOiVJ6mBLGTii9VIhTJUa0yjVXXySXo3Gyj6Cx0kTh9LdD2SAK238y7RleMeRGg1rKGHQcd2G6ZsNXAqWbXxsBts3bYK/Q4DNhC/PyiR37OdDx2wHuHei+My0rt4TQzGoEkO+IwFDfB6FSLgKLXRApVPzIrYOdPjnfH/yUE3/M8UeuSdXbT9C2kVlOvlscdpEg4bKvdf7nkJ7O7qc1ljf9B4gqf2zl7JEWb/egy9geGBr2l1XCmBN91eAU5qnrK6XQ9B+240iyfg0fqMGUpMqHowDEUj+StGVo+ir89rIQK5u0zmR5aFO+OjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/NsY3VCgwxlDE+e2teaG328AUvw2pOQ/7dkJUAghII=;
 b=AzbVkThJe1I6RIUsq+YWU6XUR6Km0JEOS1DysQ/B+G0/LDr9RxFrIXr2mqA+YOf1Yr4B14SFEYF6gWijLDRXkmKcN92Luv1vil7Eh2s64XTdmHKwYF4grulASIGMg28FwwkRqpqslmTfsG5S+xZ+Dpeua0+JaSlJOhNeDWboWGc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 08:06:49 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 08:06:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/12] drm/amd/pm: move the check for dpm enablement to
 amdgpu_dpm.c
Thread-Topic: [PATCH 05/12] drm/amd/pm: move the check for dpm enablement to
 amdgpu_dpm.c
Thread-Index: AQHYHxxhcgyeujvSdUycSoGtR5dr8KyN/i+w
Date: Fri, 11 Feb 2022 08:06:48 +0000
Message-ID: <DM5PR12MB2469337677D909DECE1E1241F1309@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
 <20220211075209.894833-5-evan.quan@amd.com>
In-Reply-To: <20220211075209.894833-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-11T08:06:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e8853e81-7719-482c-9738-30c7ebbfcce1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-11T08:06:46Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 32647ff2-8a74-4eb2-a6b5-effd54173760
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb92cd7-5a4a-4e7c-796e-08d9ed35745c
x-ms-traffictypediagnostic: DM6PR12MB3225:EE_
x-microsoft-antispam-prvs: <DM6PR12MB32256A7B0D98D6FE997BB761F1309@DM6PR12MB3225.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:218;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPYuKP9vbIv5wKpDMRpRImsZQo5JxHqdofXJdPzTIQBBTzTMDOjikwd79R1J9W1ptwNhw05TXPJzWEXQHvkL2AEv5ECEMKjuv01Iw1E9goswpWeyO3V0q3HHnX4quY9cmWv+qgFwFgY6jfXk6qXdJWwht0Zd1sp43h+Ab71TgBDEOb/HO/T1t5hsML4zbIV0jN6Iln+rXQLlQebwaDgIkTOOo5gdWAwlB3ZDy5ad3JYdheCRa7Hkg+Bw0HLR5AR+na9x6u64jsSIu3V7Fl+xFmTTHMj1xwaa0tdWFlG9ig1x4trxvB5lZYhWbZftK77jB5KRdl8dUYq8SkZM8q2e6AkDr0xRpmSsoibEimrDjBvdbdxkoMhracybBo6mhspm8HgbxumZMBWWB5WV7j62TW+CxJEm4KsOR7bFaFe5IphjDxq5KuQgxDRUboVyDl46ws9fFadyRzkVbHDnj+1DM+aVbhtuWoltnIZQHXSrFGh3KJ8tjGDF/8cFxiRaCvd/k6Dm//9eXNirvGrFMm2BOIRcUR7eoVMfltYbiNofQbyNIgFqnAziFMufq5XjySF4TLQ3EUHcTAZuQjbUYZOygojgndXzSGOPFhChIUvmJwfGe09hpsKFxOwEnNrJtPUOGzDkn4aVos3PumYc9KJywPnpUTV0uZHZYzHImihwbbDpAvEoOhh3nlyjQzfd4YRzNS/5dE1owY+TeD0KLCkEIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(55016003)(33656002)(66476007)(66446008)(7696005)(38100700002)(6506007)(76116006)(52536014)(5660300002)(9686003)(66946007)(66556008)(86362001)(30864003)(64756008)(8936002)(8676002)(4326008)(38070700005)(110136005)(316002)(54906003)(83380400001)(186003)(71200400001)(122000001)(53546011)(2906002)(26005)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IcrH4WUqJHE/FSTi8gwriaiOoXXlrFSqbPr93le1N1b9ZClcb1uxrn0kxEod?=
 =?us-ascii?Q?d7ciO8clIRqshfOFPilklkQAimpNkSDrateIasBU9rGRw/OZiCmJLOMOM1Zz?=
 =?us-ascii?Q?5DVG3RG98vq5jE7l+0/i/ZH3gDTtm+yNSpIEzLalrtGyNjZz8BJipgGsKtPS?=
 =?us-ascii?Q?22KIfF+/muxNQFLx0nEuXoZhhlDz8WcVTciv639QPZTN9gVFkx/km3wQtFb1?=
 =?us-ascii?Q?+Swt/f0gzc08nnjHIdO3IYQXxfKXOrJGA49CvjAyxMuup20Vm96/WbyMylMO?=
 =?us-ascii?Q?20X/oFwFk3mNvSAuZfR7G/axLNXLfAnvxIao2HDAHzpb8ng5A5NaDs2Uoh5s?=
 =?us-ascii?Q?hrlgdT3Eq3I2e9t7iLnhO3jNlEa/OqPN3b+b4Xpa1i9Pol8z4DZ1sxFebSEa?=
 =?us-ascii?Q?6V0/Q8dxTZikLvWgFvMT7MEJ5uxesGIzr5PBESfkhjSzDUJnqEJ1okfuwW8c?=
 =?us-ascii?Q?O94u4s89j1krhy1Lu3Lt+te1EiVTOQOLe8FTwCcOmY/1MM5BTkWzzgozjDJA?=
 =?us-ascii?Q?3tvW2/tR92o9fHkaudalQ6LLPMkPU2/VF7/F+NI1nLjX8yWLzwBPxI8X73Nr?=
 =?us-ascii?Q?ukS2h9WgslnzlFiwVf7xJo8YTZ07u8Xfdhb+p6kwrwI0Zf5B5u/DNE9fOKRh?=
 =?us-ascii?Q?3Q0LTJv1l/BjW4s/WF9yLECP4THPyQ5tyb59Osr24LAahmlKmygE231EFWEY?=
 =?us-ascii?Q?1GIba5tLW650Fjb0yaz01Rox6otobMK9vJWtLAGyqCP8r8M2PFIhSDBryYrY?=
 =?us-ascii?Q?w5TE6KzKKkHis7oSJoFSgiE5TV4NYWRuHkNz4UaJlBjW7LKH0SniRthDGigC?=
 =?us-ascii?Q?Q2s07orUj3lAH6wHYKb5yFU9CnjjVZFE3NeVw61fkYIGNGBZFhwkLRpgCPJb?=
 =?us-ascii?Q?fUhltkdu3pm7o6jx4LFAZ2vzV92pfdDefxyaNubtRq5qZ+H/hGUhv1gx/Zef?=
 =?us-ascii?Q?9SJpnYXQq3Utwqv9OR4yaFuIHfwN0qv5/ODgW20hx64BsuiwtYKoxEU4dMbG?=
 =?us-ascii?Q?VRT0SZSU55b9edDeRBvPaa9svDq5W2hyg6a2DRGgCzyDVKxFqzoabl3DdvuW?=
 =?us-ascii?Q?p1QcMTlgHY4klq3gRPBn+jtKNlh5QYHHJ/W1YJSqcceg5YGtJIn0qXWdLNkm?=
 =?us-ascii?Q?xyk7eldpvDi6QPhzJiDr+UG3KJNmBTDlhI4n/yest/Olw9birxXc5LTy7usd?=
 =?us-ascii?Q?hjtCeQJ+j/rVJzmcASzI/C6+Yu78i6eXgT+K6C+tWaHLErlMWFJy/dhnvvOF?=
 =?us-ascii?Q?bUdNrb994+aN/Sg+R1Fe2UNJ1grzlZZANSY6QlgzcH0b8WUga+0p4gnHuuBo?=
 =?us-ascii?Q?YYTyefCI54Gh1J/6I89uaRQhODCM6QsTMR+hrMQRy1+aqw3kB+aYAYwEvRKe?=
 =?us-ascii?Q?uBpMYLx1BVl6d1VaVtZvdZ6S2aXjor1/NZnK8R6D8pO8/Y17CmLcF9VO8JNF?=
 =?us-ascii?Q?ojLb7MllvxCnFnJsk2jZHaexMP7z6QYLENLFkhBitlShp1HTMwQ8+eTF0Qfc?=
 =?us-ascii?Q?/YuJ7fy+A5pICFpoEwmJC3t8vzO9dys7vfiU8uIqZKtnyoc2hFf3CvvcYJel?=
 =?us-ascii?Q?OmVBogqqx+Mp0qEbADKztd8ygBcMB18Ct806p0C2DVPR5MR+7D45K17Dnmi8?=
 =?us-ascii?Q?Kf9xG1D7nvpvhHEGJN3YWz4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb92cd7-5a4a-4e7c-796e-08d9ed35745c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 08:06:48.9028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTDWLy5oYoqLadD6H17/9biyswZMtW9WDbtrBD2gYOx/UPbKWvrnu01jG3YDtUVGjvSosaSxUc8mzytEzIWLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

mutex_lock(&adev->pm.mutex);
-	ret =3D smu_write_watermarks_table(smu);
+	ret =3D pp_funcs->set_watermarks_for_clock_ranges(adev->powerplay.pp_hand=
le,
+							NULL);
 	mutex_unlock(&adev->pm.mutex);

I guess we should separate this from this patch, and send another patch to =
address it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, February 11, 2022 3:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>; rui.huang@amd.com
Subject: [PATCH 05/12] drm/amd/pm: move the check for dpm enablement to amd=
gpu_dpm.c

Instead of checking this in every instance(framework), moving that check to
amdgpu_dpm.c is more proper. And that can make code clean and tidy.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I2f83a3b860e8aa12cc86f119011f520fbe21a301
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  16 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 277 ++++++++++++++++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  25 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  12 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |   4 -
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 117 ++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 135 +--------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
 9 files changed, 352 insertions(+), 240 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index 2c929fa40379..fff0e6a3882e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -261,11 +261,14 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu=
_ctx *ctx,
 {
 	struct amdgpu_device *adev =3D ctx->adev;
 	enum amd_dpm_forced_level current_level;
+	int ret =3D 0;
=20
 	if (!ctx)
 		return -EINVAL;
=20
-	current_level =3D amdgpu_dpm_get_performance_level(adev);
+	ret =3D amdgpu_dpm_get_performance_level(adev, &current_level);
+	if (ret)
+		return ret;
=20
 	switch (current_level) {
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 9f985bd463be..56144f25b720 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -813,15 +813,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
 		unsigned i;
 		struct drm_amdgpu_info_vce_clock_table vce_clk_table =3D {};
 		struct amd_vce_state *vce_state;
+		int ret =3D 0;
=20
 		for (i =3D 0; i < AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {
-			vce_state =3D amdgpu_dpm_get_vce_clock_state(adev, i);
-			if (vce_state) {
-				vce_clk_table.entries[i].sclk =3D vce_state->sclk;
-				vce_clk_table.entries[i].mclk =3D vce_state->mclk;
-				vce_clk_table.entries[i].eclk =3D vce_state->evclk;
-				vce_clk_table.num_valid_entries++;
-			}
+			ret =3D amdgpu_dpm_get_vce_clock_state(adev, i, vce_state);
+			if (ret)
+				return ret;
+
+			vce_clk_table.entries[i].sclk =3D vce_state->sclk;
+			vce_clk_table.entries[i].mclk =3D vce_state->mclk;
+			vce_clk_table.entries[i].eclk =3D vce_state->evclk;
+			vce_clk_table.num_valid_entries++;
 		}
=20
 		return copy_to_user(out, &vce_clk_table,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 1d63f1e8884c..b46ae0063047 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -41,6 +41,9 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool =
low)
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
 	if (!pp_funcs->get_sclk)
 		return 0;
=20
@@ -57,6 +60,9 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool =
low)
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
 	if (!pp_funcs->get_mclk)
 		return 0;
=20
@@ -74,6 +80,13 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_devi=
ce *adev, uint32_t block
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	enum ip_power_state pwr_state =3D gate ? POWER_STATE_OFF : POWER_STATE_ON=
;
=20
+	if (!adev->pm.dpm_enabled) {
+		dev_WARN(adev->dev,
+			 "SMU uninitialized but power %s requested for %u!\n",
+			 gate ? "gate" : "ungate", block_type);
+		return -EOPNOTSUPP;
+	}
+
 	if (atomic_read(&adev->pm.pwr_state[block_type]) =3D=3D pwr_state) {
 		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
 				block_type, gate ? "gate" : "ungate");
@@ -261,6 +274,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_devic=
e *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (amdgpu_sriov_vf(adev))
 		return 0;
=20
@@ -280,6 +296,9 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *ad=
ev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
@@ -297,6 +316,9 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev=
,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	void *pp_handle =3D adev->powerplay.pp_handle;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (pp_funcs && pp_funcs->set_df_cstate) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D pp_funcs->set_df_cstate(pp_handle, cstate);
@@ -311,6 +333,9 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_devi=
ce *adev, bool en)
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D smu_allow_xgmi_power_down(smu, en);
@@ -327,6 +352,9 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_devi=
ce *adev)
 			adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D pp_funcs->enable_mgpu_fan_boost(pp_handle);
@@ -344,6 +372,9 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_dev=
ice *adev,
 			adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D pp_funcs->set_clockgating_by_smu(pp_handle,
@@ -362,6 +393,9 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device =
*adev,
 			adev->powerplay.pp_funcs;
 	int ret =3D -EOPNOTSUPP;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D pp_funcs->smu_i2c_bus_access(pp_handle,
@@ -398,6 +432,9 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, =
enum amd_pp_sensors senso
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D -EINVAL;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!data || !size)
 		return -EINVAL;
=20
@@ -485,6 +522,9 @@ int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_dev=
ice *adev, bool enable)
 {
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
 		ret =3D smu_handle_passthrough_sbr(adev->powerplay.pp_handle,
@@ -500,6 +540,9 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_dev=
ice *adev, uint32_t size)
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&adev->pm.mutex);
 	ret =3D smu_send_hbm_bad_pages_num(smu, size);
 	mutex_unlock(&adev->pm.mutex);
@@ -514,6 +557,9 @@ int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device =
*adev,
 {
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (type !=3D PP_SCLK)
 		return -EINVAL;
=20
@@ -538,6 +584,9 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device=
 *adev,
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (type !=3D PP_SCLK)
 		return -EINVAL;
=20
@@ -556,14 +605,18 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_devi=
ce *adev,
=20
 int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
 {
-	struct smu_context *smu =3D adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!is_support_sw_smu(adev))
 		return 0;
=20
 	mutex_lock(&adev->pm.mutex);
-	ret =3D smu_write_watermarks_table(smu);
+	ret =3D pp_funcs->set_watermarks_for_clock_ranges(adev->powerplay.pp_hand=
le,
+							NULL);
 	mutex_unlock(&adev->pm.mutex);
=20
 	return ret;
@@ -576,6 +629,9 @@ int amdgpu_dpm_wait_for_event(struct amdgpu_device *ade=
v,
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
=20
@@ -591,6 +647,9 @@ int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *=
adev, uint32_t *value)
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
=20
@@ -605,6 +664,9 @@ uint64_t amdgpu_dpm_get_thermal_throttling_counter(stru=
ct amdgpu_device *adev)
 {
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
=20
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
 	if (!is_support_sw_smu(adev))
 		return 0;
=20
@@ -619,6 +681,9 @@ uint64_t amdgpu_dpm_get_thermal_throttling_counter(stru=
ct amdgpu_device *adev)
 void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
 				 enum gfx_change_state state)
 {
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	mutex_lock(&adev->pm.mutex);
 	if (adev->powerplay.pp_funcs &&
 	    adev->powerplay.pp_funcs->gfx_state_change_set)
@@ -632,27 +697,33 @@ int amdgpu_dpm_get_ecc_info(struct amdgpu_device *ade=
v,
 {
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
=20
 	return smu_get_ecc_info(smu, umc_ecc);
 }
=20
-struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device =
*adev,
-						     uint32_t idx)
+int amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
+				   uint32_t idx,
+				   struct amd_vce_state *vstate)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-	struct amd_vce_state *vstate =3D NULL;
+
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
=20
 	if (!pp_funcs->get_vce_clock_state)
-		return NULL;
+		return -EOPNOTSUPP;
=20
 	mutex_lock(&adev->pm.mutex);
 	vstate =3D pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
 					       idx);
 	mutex_unlock(&adev->pm.mutex);
=20
-	return vstate;
+	return 0;
 }
=20
 void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
@@ -660,6 +731,9 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_d=
evice *adev,
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	mutex_lock(&adev->pm.mutex);
=20
 	if (!pp_funcs->get_current_power_state) {
@@ -679,6 +753,9 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_d=
evice *adev,
 void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state)
 {
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	mutex_lock(&adev->pm.mutex);
 	adev->pm.dpm.user_state =3D state;
 	mutex_unlock(&adev->pm.mutex);
@@ -692,19 +769,22 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device =
*adev,
 		amdgpu_dpm_compute_clocks(adev);
 }
=20
-enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_d=
evice *adev)
+int amdgpu_dpm_get_performance_level(struct amdgpu_device *adev,
+				     enum amd_dpm_forced_level *level)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-	enum amd_dpm_forced_level level;
+
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
=20
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
-		level =3D pp_funcs->get_performance_level(adev->powerplay.pp_handle);
+		*level =3D pp_funcs->get_performance_level(adev->powerplay.pp_handle);
 	else
-		level =3D adev->pm.dpm.forced_level;
+		*level =3D adev->pm.dpm.forced_level;
 	mutex_unlock(&adev->pm.mutex);
=20
-	return level;
+	return 0;
 }
=20
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
@@ -717,13 +797,16 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_=
device *adev,
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->force_performance_level)
 		return 0;
=20
 	if (adev->pm.dpm.thermal_active)
 		return -EINVAL;
=20
-	current_level =3D amdgpu_dpm_get_performance_level(adev);
+	amdgpu_dpm_get_performance_level(adev, &current_level);
 	if (current_level =3D=3D level)
 		return 0;
=20
@@ -783,6 +866,9 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *=
adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_pp_num_states)
 		return -EOPNOTSUPP;
=20
@@ -801,6 +887,9 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev=
,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->dispatch_tasks)
 		return -EOPNOTSUPP;
=20
@@ -818,6 +907,9 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev,=
 char **table)
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_pp_table)
 		return 0;
=20
@@ -837,6 +929,9 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_dev=
ice *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_fine_grain_clk_vol)
 		return 0;
=20
@@ -858,6 +953,9 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device =
*adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->odn_edit_dpm_table)
 		return 0;
=20
@@ -878,6 +976,9 @@ int amdgpu_dpm_print_clock_levels(struct amdgpu_device =
*adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->print_clock_levels)
 		return 0;
=20
@@ -917,6 +1018,9 @@ int amdgpu_dpm_set_ppfeature_status(struct amdgpu_devi=
ce *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_ppfeature_status)
 		return 0;
=20
@@ -933,6 +1037,9 @@ int amdgpu_dpm_get_ppfeature_status(struct amdgpu_devi=
ce *adev, char *buf)
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_ppfeature_status)
 		return 0;
=20
@@ -951,6 +1058,9 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device =
*adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->force_clock_level)
 		return 0;
=20
@@ -963,27 +1073,33 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_devic=
e *adev,
 	return ret;
 }
=20
-int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
+int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev,
+			   uint32_t *value)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-	int ret =3D 0;
+
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
=20
 	if (!pp_funcs->get_sclk_od)
-		return 0;
+		return -EOPNOTSUPP;
=20
 	mutex_lock(&adev->pm.mutex);
-	ret =3D pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
+	*value =3D pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
=20
-	return ret;
+	return 0;
 }
=20
 int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (is_support_sw_smu(adev))
-		return 0;
+		return -EOPNOTSUPP;
=20
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->set_sclk_od)
@@ -1000,27 +1116,33 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *ad=
ev, uint32_t value)
 	return 0;
 }
=20
-int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
+int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev,
+			   uint32_t *value)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-	int ret =3D 0;
+
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
=20
 	if (!pp_funcs->get_mclk_od)
-		return 0;
+		return -EOPNOTSUPP;
=20
 	mutex_lock(&adev->pm.mutex);
-	ret =3D pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
+	*value =3D pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
=20
-	return ret;
+	return 0;
 }
=20
 int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (is_support_sw_smu(adev))
-		return 0;
+		return -EOPNOTSUPP;
=20
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->set_mclk_od)
@@ -1043,6 +1165,9 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_d=
evice *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
=20
@@ -1060,6 +1185,9 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_d=
evice *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_power_profile_mode)
 		return 0;
=20
@@ -1077,6 +1205,9 @@ int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *=
adev, void **table)
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
=20
@@ -1094,6 +1225,9 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_dev=
ice *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
=20
@@ -1111,6 +1245,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device=
 *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_fan_speed_pwm)
 		return -EOPNOTSUPP;
=20
@@ -1128,6 +1265,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device=
 *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_fan_speed_pwm)
 		return -EOPNOTSUPP;
=20
@@ -1145,6 +1285,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device=
 *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_fan_speed_rpm)
 		return -EOPNOTSUPP;
=20
@@ -1162,6 +1305,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device=
 *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_fan_speed_rpm)
 		return -EOPNOTSUPP;
=20
@@ -1179,6 +1325,9 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_dev=
ice *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
=20
@@ -1198,6 +1347,9 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *=
adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_power_limit)
 		return -ENODATA;
=20
@@ -1217,6 +1369,9 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *=
adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_power_limit)
 		return -EINVAL;
=20
@@ -1232,6 +1387,9 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_de=
vice *adev)
 {
 	bool cclk_dpm_supported =3D false;
=20
+	if (!adev->pm.dpm_enabled)
+		return false;
+
 	if (!is_support_sw_smu(adev))
 		return false;
=20
@@ -1247,6 +1405,9 @@ int amdgpu_dpm_debugfs_print_current_performance_leve=
l(struct amdgpu_device *ade
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->debugfs_print_current_performance_level)
 		return -EOPNOTSUPP;
=20
@@ -1265,6 +1426,9 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_=
device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_smu_prv_buf_details)
 		return -ENOSYS;
=20
@@ -1282,6 +1446,9 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_d=
evice *adev)
 	struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
=20
+	if (!adev->pm.dpm_enabled)
+		return false;
+
 	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
 	    (is_support_sw_smu(adev) && smu->is_apu) ||
 		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
@@ -1297,6 +1464,9 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *ade=
v,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_pp_table)
 		return -EOPNOTSUPP;
=20
@@ -1313,6 +1483,9 @@ int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device=
 *adev)
 {
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
=20
+	if (!adev->pm.dpm_enabled)
+		return INT_MAX;
+
 	if (!is_support_sw_smu(adev))
 		return INT_MAX;
=20
@@ -1321,6 +1494,9 @@ int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device=
 *adev)
=20
 void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
 {
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	if (!is_support_sw_smu(adev))
 		return;
=20
@@ -1333,6 +1509,9 @@ int amdgpu_dpm_display_configuration_change(struct am=
dgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->display_configuration_change)
 		return 0;
=20
@@ -1351,6 +1530,9 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device=
 *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_clock_by_type)
 		return 0;
=20
@@ -1369,6 +1551,9 @@ int amdgpu_dpm_get_display_mode_validation_clks(struc=
t amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_display_mode_validation_clocks)
 		return 0;
=20
@@ -1387,6 +1572,9 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct =
amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_clock_by_type_with_latency)
 		return 0;
=20
@@ -1406,6 +1594,9 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct =
amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_clock_by_type_with_voltage)
 		return 0;
=20
@@ -1424,6 +1615,9 @@ int amdgpu_dpm_set_watermarks_for_clocks_ranges(struc=
t amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_watermarks_for_clocks_ranges)
 		return -EOPNOTSUPP;
=20
@@ -1441,6 +1635,9 @@ int amdgpu_dpm_display_clock_voltage_request(struct a=
mdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->display_clock_voltage_request)
 		return -EOPNOTSUPP;
=20
@@ -1458,6 +1655,9 @@ int amdgpu_dpm_get_current_clocks(struct amdgpu_devic=
e *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_current_clocks)
 		return -EOPNOTSUPP;
=20
@@ -1473,6 +1673,9 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_d=
evice *adev)
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	if (!pp_funcs->notify_smu_enable_pwe)
 		return;
=20
@@ -1487,6 +1690,9 @@ int amdgpu_dpm_set_active_display_count(struct amdgpu=
_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_active_display_count)
 		return -EOPNOTSUPP;
=20
@@ -1504,6 +1710,9 @@ int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdg=
pu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->set_min_deep_sleep_dcefclk)
 		return -EOPNOTSUPP;
=20
@@ -1520,6 +1729,9 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct a=
mdgpu_device *adev,
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
 		return;
=20
@@ -1534,6 +1746,9 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdg=
pu_device *adev,
 {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
=20
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	if (!pp_funcs->set_hard_min_fclk_by_freq)
 		return;
=20
@@ -1549,6 +1764,9 @@ int amdgpu_dpm_display_disable_memory_clock_switch(st=
ruct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->display_disable_memory_clock_switch)
 		return 0;
=20
@@ -1566,6 +1784,9 @@ int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struc=
t amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
 		return -EOPNOTSUPP;
=20
@@ -1584,6 +1805,9 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(str=
uct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_uclk_dpm_states)
 		return -EOPNOTSUPP;
=20
@@ -1602,6 +1826,9 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_devi=
ce *adev,
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	int ret =3D 0;
=20
+	if (!adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs->get_dpm_clock_table)
 		return -EOPNOTSUPP;
=20
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b0243068212b..84aab3bb9bdc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -273,11 +273,14 @@ static ssize_t amdgpu_get_power_dpm_force_performance=
_level(struct device *dev,
 		return ret;
 	}
=20
-	level =3D amdgpu_dpm_get_performance_level(adev);
+	ret =3D amdgpu_dpm_get_performance_level(adev, &level);
=20
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
=20
+	if (ret)
+		return ret;
+
 	return sysfs_emit(buf, "%s\n",
 			  (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
 			  (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
@@ -1241,11 +1244,14 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device =
*dev,
 		return ret;
 	}
=20
-	value =3D amdgpu_dpm_get_sclk_od(adev);
+	ret =3D amdgpu_dpm_get_sclk_od(adev, &value);
=20
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
=20
+	if (ret)
+		return ret;
+
 	return sysfs_emit(buf, "%d\n", value);
 }
=20
@@ -1275,11 +1281,14 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device =
*dev,
 		return ret;
 	}
=20
-	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
+	ret =3D amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
=20
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
=20
+	if (ret)
+		return ret;
+
 	return count;
 }
=20
@@ -1303,11 +1312,14 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device =
*dev,
 		return ret;
 	}
=20
-	value =3D amdgpu_dpm_get_mclk_od(adev);
+	ret =3D amdgpu_dpm_get_mclk_od(adev, &value);
=20
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
=20
+	if (ret)
+		return ret;
+
 	return sysfs_emit(buf, "%d\n", value);
 }
=20
@@ -1337,11 +1349,14 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device =
*dev,
 		return ret;
 	}
=20
-	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
+	ret =3D amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
=20
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
=20
+	if (ret)
+		return ret;
+
 	return count;
 }
=20
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index ddfa55b59d02..49488aebd350 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -429,12 +429,14 @@ void amdgpu_dpm_gfx_state_change(struct amdgpu_device=
 *adev,
 				 enum gfx_change_state state);
 int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
 			    void *umc_ecc);
-struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device =
*adev,
-						     uint32_t idx);
+int amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
+				   uint32_t idx,
+				   struct amd_vce_state *vstate);
 void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev, enum a=
md_pm_state_type *state);
 void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state);
-enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_d=
evice *adev);
+int amdgpu_dpm_get_performance_level(struct amdgpu_device *adev,
+				     enum amd_dpm_forced_level *level);
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level);
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
@@ -464,9 +466,9 @@ int amdgpu_dpm_get_ppfeature_status(struct amdgpu_devic=
e *adev, char *buf);
 int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
 				 enum pp_clock_type type,
 				 uint32_t mask);
-int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev);
+int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value);
-int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev);
+int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value);
 int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/d=
rm/amd/pm/legacy-dpm/legacy_dpm.c
index 9613c6181c17..59550617cf54 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -959,10 +959,6 @@ static int amdgpu_dpm_change_power_state_locked(struct=
 amdgpu_device *adev)
 	int ret;
 	bool equal =3D false;
=20
-	/* if dpm init failed */
-	if (!adev->pm.dpm_enabled)
-		return 0;
-
 	if (adev->pm.dpm.user_state !=3D adev->pm.dpm.state) {
 		/* add other state override checks here */
 		if ((!adev->pm.dpm.thermal_active) &&
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index 991ac4adb263..bba923cfe08c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -295,7 +295,7 @@ static int pp_set_clockgating_by_smu(void *handle, uint=
32_t msg_id)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->update_clock_gatings =3D=3D NULL) {
@@ -335,7 +335,7 @@ static int pp_dpm_force_performance_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (level =3D=3D hwmgr->dpm_level)
@@ -353,7 +353,7 @@ static enum amd_dpm_forced_level pp_dpm_get_performance=
_level(
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	return hwmgr->dpm_level;
@@ -363,7 +363,7 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return 0;
=20
 	if (hwmgr->hwmgr_func->get_sclk =3D=3D NULL) {
@@ -377,7 +377,7 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return 0;
=20
 	if (hwmgr->hwmgr_func->get_mclk =3D=3D NULL) {
@@ -391,7 +391,7 @@ static void pp_dpm_powergate_vce(void *handle, bool gat=
e)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return;
=20
 	if (hwmgr->hwmgr_func->powergate_vce =3D=3D NULL) {
@@ -405,7 +405,7 @@ static void pp_dpm_powergate_uvd(void *handle, bool gat=
e)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return;
=20
 	if (hwmgr->hwmgr_func->powergate_uvd =3D=3D NULL) {
@@ -420,7 +420,7 @@ static int pp_dpm_dispatch_tasks(void *handle, enum amd=
_pp_task task_id,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	return hwmgr_handle_task(hwmgr, task_id, user_state);
@@ -432,7 +432,7 @@ static enum amd_pm_state_type pp_dpm_get_current_power_=
state(void *handle)
 	struct pp_power_state *state;
 	enum amd_pm_state_type pm_type;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !=
hwmgr->current_ps)
+	if (!hwmgr || !hwmgr->current_ps)
 		return -EINVAL;
=20
 	state =3D hwmgr->current_ps;
@@ -462,7 +462,7 @@ static int pp_dpm_set_fan_control_mode(void *handle, ui=
nt32_t mode)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->hwmgr_func->set_fan_control_mode =3D=3D NULL)
@@ -480,7 +480,7 @@ static int pp_dpm_get_fan_control_mode(void *handle, ui=
nt32_t *fan_mode)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->hwmgr_func->get_fan_control_mode =3D=3D NULL)
@@ -497,7 +497,7 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint3=
2_t speed)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->hwmgr_func->set_fan_speed_pwm =3D=3D NULL)
@@ -513,7 +513,7 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint3=
2_t *speed)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->hwmgr_func->get_fan_speed_pwm =3D=3D NULL)
@@ -529,7 +529,7 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint3=
2_t *rpm)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->hwmgr_func->get_fan_speed_rpm =3D=3D NULL)
@@ -545,7 +545,7 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint3=
2_t rpm)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->hwmgr_func->set_fan_speed_rpm =3D=3D NULL)
@@ -565,7 +565,7 @@ static int pp_dpm_get_pp_num_states(void *handle,
=20
 	memset(data, 0, sizeof(*data));
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!h=
wmgr->ps)
+	if (!hwmgr || !hwmgr->ps)
 		return -EINVAL;
=20
 	data->nums =3D hwmgr->num_ps;
@@ -597,7 +597,7 @@ static int pp_dpm_get_pp_table(void *handle, char **tab=
le)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!h=
wmgr->soft_pp_table)
+	if (!hwmgr || !hwmgr->soft_pp_table)
 		return -EINVAL;
=20
 	*table =3D (char *)hwmgr->soft_pp_table;
@@ -625,7 +625,7 @@ static int pp_dpm_set_pp_table(void *handle, const char=
 *buf, size_t size)
 	struct pp_hwmgr *hwmgr =3D handle;
 	int ret =3D -ENOMEM;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (!hwmgr->hardcode_pp_table) {
@@ -655,7 +655,7 @@ static int pp_dpm_force_clock_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->force_clock_level =3D=3D NULL) {
@@ -676,7 +676,7 @@ static int pp_dpm_print_clock_levels(void *handle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->print_clock_levels =3D=3D NULL) {
@@ -690,7 +690,7 @@ static int pp_dpm_get_sclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->get_sclk_od =3D=3D NULL) {
@@ -704,7 +704,7 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t va=
lue)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_sclk_od =3D=3D NULL) {
@@ -719,7 +719,7 @@ static int pp_dpm_get_mclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->get_mclk_od =3D=3D NULL) {
@@ -733,7 +733,7 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t va=
lue)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_mclk_od =3D=3D NULL) {
@@ -748,7 +748,7 @@ static int pp_dpm_read_sensor(void *handle, int idx,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !=
value)
+	if (!hwmgr || !value)
 		return -EINVAL;
=20
 	switch (idx) {
@@ -774,7 +774,7 @@ pp_dpm_get_vce_clock_state(void *handle, unsigned idx)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return NULL;
=20
 	if (idx < hwmgr->num_vce_state_tables)
@@ -786,7 +786,7 @@ static int pp_get_power_profile_mode(void *handle, char=
 *buf)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !=
hwmgr->hwmgr_func->get_power_profile_mode)
+	if (!hwmgr || !hwmgr->hwmgr_func->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
 		return -EINVAL;
@@ -798,7 +798,7 @@ static int pp_set_power_profile_mode(void *handle, long=
 *input, uint32_t size)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !=
hwmgr->hwmgr_func->set_power_profile_mode)
+	if (!hwmgr || !hwmgr->hwmgr_func->set_power_profile_mode)
 		return -EOPNOTSUPP;
=20
 	if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
@@ -813,7 +813,7 @@ static int pp_set_fine_grain_clk_vol(void *handle, uint=
32_t type, long *input, u
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_fine_grain_clk_vol =3D=3D NULL)
@@ -826,7 +826,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t=
 type, long *input, uint3
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->odn_edit_dpm_table =3D=3D NULL) {
@@ -860,7 +860,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 	long workload;
 	uint32_t index;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_power_profile_mode =3D=3D NULL) {
@@ -900,7 +900,7 @@ static int pp_set_power_limit(void *handle, uint32_t li=
mit)
 	struct pp_hwmgr *hwmgr =3D handle;
 	uint32_t max_power_limit;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_power_limit =3D=3D NULL) {
@@ -932,7 +932,7 @@ static int pp_get_power_limit(void *handle, uint32_t *l=
imit,
 	struct pp_hwmgr *hwmgr =3D handle;
 	int ret =3D 0;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!l=
imit)
+	if (!hwmgr || !limit)
 		return -EINVAL;
=20
 	if (power_type !=3D PP_PWR_TYPE_SUSTAINED)
@@ -965,7 +965,7 @@ static int pp_display_configuration_change(void *handle=
,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	phm_store_dal_configuration_data(hwmgr, display_config);
@@ -977,7 +977,7 @@ static int pp_get_display_power_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!o=
utput)
+	if (!hwmgr || !output)
 		return -EINVAL;
=20
 	return phm_get_dal_power_level(hwmgr, output);
@@ -991,7 +991,7 @@ static int pp_get_current_clocks(void *handle,
 	struct pp_hwmgr *hwmgr =3D handle;
 	int ret =3D 0;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	phm_get_dal_power_level(hwmgr, &simple_clocks);
@@ -1035,7 +1035,7 @@ static int pp_get_clock_by_type(void *handle, enum am=
d_pp_clock_type type, struc
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (clocks =3D=3D NULL)
@@ -1050,7 +1050,7 @@ static int pp_get_clock_by_type_with_latency(void *ha=
ndle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!c=
locks)
+	if (!hwmgr || !clocks)
 		return -EINVAL;
=20
 	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
@@ -1062,7 +1062,7 @@ static int pp_get_clock_by_type_with_voltage(void *ha=
ndle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!c=
locks)
+	if (!hwmgr || !clocks)
 		return -EINVAL;
=20
 	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
@@ -1073,7 +1073,7 @@ static int pp_set_watermarks_for_clocks_ranges(void *=
handle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !=
clock_ranges)
+	if (!hwmgr || !clock_ranges)
 		return -EINVAL;
=20
 	return phm_set_watermarks_for_clocks_ranges(hwmgr,
@@ -1085,7 +1085,7 @@ static int pp_display_clock_voltage_request(void *han=
dle,
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!c=
lock)
+	if (!hwmgr || !clock)
 		return -EINVAL;
=20
 	return phm_display_clock_voltage_request(hwmgr, clock);
@@ -1097,7 +1097,7 @@ static int pp_get_display_mode_validation_clocks(void=
 *handle,
 	struct pp_hwmgr *hwmgr =3D handle;
 	int ret =3D 0;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!c=
locks)
+	if (!hwmgr || !clocks)
 		return -EINVAL;
=20
 	clocks->level =3D PP_DAL_POWERLEVEL_7;
@@ -1112,7 +1112,7 @@ static int pp_dpm_powergate_mmhub(void *handle)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->powergate_mmhub =3D=3D NULL) {
@@ -1127,7 +1127,7 @@ static int pp_dpm_powergate_gfx(void *handle, bool ga=
te)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return 0;
=20
 	if (hwmgr->hwmgr_func->powergate_gfx =3D=3D NULL) {
@@ -1142,7 +1142,7 @@ static void pp_dpm_powergate_acp(void *handle, bool g=
ate)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return;
=20
 	if (hwmgr->hwmgr_func->powergate_acp =3D=3D NULL) {
@@ -1208,7 +1208,7 @@ static int pp_notify_smu_enable_pwe(void *handle)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->smus_notify_pwe =3D=3D NULL) {
@@ -1228,8 +1228,7 @@ static int pp_enable_mgpu_fan_boost(void *handle)
 	if (!hwmgr)
 		return -EINVAL;
=20
-	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||
-	     hwmgr->hwmgr_func->enable_mgpu_fan_boost =3D=3D NULL)
+	if (hwmgr->hwmgr_func->enable_mgpu_fan_boost =3D=3D NULL)
 		return 0;
=20
 	hwmgr->hwmgr_func->enable_mgpu_fan_boost(hwmgr);
@@ -1241,7 +1240,7 @@ static int pp_set_min_deep_sleep_dcefclk(void *handle=
, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk =3D=3D NULL) {
@@ -1258,7 +1257,7 @@ static int pp_set_hard_min_dcefclk_by_freq(void *hand=
le, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq =3D=3D NULL) {
@@ -1275,7 +1274,7 @@ static int pp_set_hard_min_fclk_by_freq(void *handle,=
 uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_hard_min_fclk_by_freq =3D=3D NULL) {
@@ -1292,7 +1291,7 @@ static int pp_set_active_display_count(void *handle, =
uint32_t count)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	return phm_set_active_display_count(hwmgr, count);
@@ -1350,7 +1349,7 @@ static int pp_get_ppfeature_status(void *handle, char=
 *buf)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !=
buf)
+	if (!hwmgr || !buf)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->get_ppfeature_status =3D=3D NULL) {
@@ -1365,7 +1364,7 @@ static int pp_set_ppfeature_status(void *handle, uint=
64_t ppfeature_masks)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->set_ppfeature_status =3D=3D NULL) {
@@ -1395,7 +1394,7 @@ static int pp_smu_i2c_bus_access(void *handle, bool a=
cquire)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->smu_i2c_bus_access =3D=3D NULL) {
@@ -1413,7 +1412,7 @@ static int pp_set_df_cstate(void *handle, enum pp_df_=
cstate state)
 	if (!hwmgr)
 		return -EINVAL;
=20
-	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwm=
gr_func->set_df_cstate)
+	if (!hwmgr->hwmgr_func->set_df_cstate)
 		return 0;
=20
 	hwmgr->hwmgr_func->set_df_cstate(hwmgr, state);
@@ -1428,7 +1427,7 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t =
pstate)
 	if (!hwmgr)
 		return -EINVAL;
=20
-	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwm=
gr_func->set_xgmi_pstate)
+	if (!hwmgr->hwmgr_func->set_xgmi_pstate)
 		return 0;
=20
 	hwmgr->hwmgr_func->set_xgmi_pstate(hwmgr, pstate);
@@ -1443,7 +1442,7 @@ static ssize_t pp_get_gpu_metrics(void *handle, void =
**table)
 	if (!hwmgr)
 		return -EINVAL;
=20
-	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwm=
gr_func->get_gpu_metrics)
+	if (!hwmgr->hwmgr_func->get_gpu_metrics)
 		return -EOPNOTSUPP;
=20
 	return hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
@@ -1453,7 +1452,7 @@ static int pp_gfx_state_change_set(void *handle, uint=
32_t state)
 {
 	struct pp_hwmgr *hwmgr =3D handle;
=20
-	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
+	if (!hwmgr)
 		return -EINVAL;
=20
 	if (hwmgr->hwmgr_func->gfx_state_change =3D=3D NULL) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 96a3388c2cb7..97c57a6cf314 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -68,9 +68,6 @@ static int smu_sys_get_pp_feature_mask(void *handle,
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	return smu_get_pp_feature_mask(smu, buf);
 }
=20
@@ -79,9 +76,6 @@ static int smu_sys_set_pp_feature_mask(void *handle,
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	return smu_set_pp_feature_mask(smu, new_mask);
 }
=20
@@ -219,13 +213,6 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled) {
-		dev_WARN(smu->adev->dev,
-			 "SMU uninitialized but power %s requested for %u!\n",
-			 gate ? "gate" : "ungate", block_type);
-		return -EOPNOTSUPP;
-	}
-
 	switch (block_type) {
 	/*
 	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
@@ -315,9 +302,6 @@ static void smu_restore_dpm_user_profile(struct smu_con=
text *smu)
 	if (!smu->adev->in_suspend)
 		return;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return;
-
 	/* Enable restore flag */
 	smu->user_dpm_profile.flags |=3D SMU_DPM_USER_PROFILE_RESTORE;
=20
@@ -428,9 +412,6 @@ static int smu_sys_get_pp_table(void *handle,
 	struct smu_context *smu =3D handle;
 	struct smu_table_context *smu_table =3D &smu->smu_table;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
 		return -EINVAL;
=20
@@ -451,9 +432,6 @@ static int smu_sys_set_pp_table(void *handle,
 	ATOM_COMMON_TABLE_HEADER *header =3D (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (header->usStructureSize !=3D size) {
 		dev_err(smu->adev->dev, "pp table size not matched !\n");
 		return -EIO;
@@ -1564,9 +1542,6 @@ static int smu_display_configuration_change(void *han=
dle,
 	int index =3D 0;
 	int num_of_active_display =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!display_config)
 		return -EINVAL;
=20
@@ -1704,9 +1679,6 @@ static int smu_handle_task(struct smu_context *smu,
 {
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
 		ret =3D smu_pre_display_config_changed(smu);
@@ -1745,9 +1717,6 @@ static int smu_switch_power_profile(void *handle,
 	long workload;
 	uint32_t index;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
=20
@@ -1775,9 +1744,6 @@ static enum amd_dpm_forced_level smu_get_performance_=
level(void *handle)
 	struct smu_context *smu =3D handle;
 	struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
=20
@@ -1791,9 +1757,6 @@ static int smu_force_performance_level(void *handle,
 	struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
=20
@@ -1817,9 +1780,6 @@ static int smu_set_display_count(void *handle, uint32=
_t count)
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	return smu_init_display_count(smu, count);
 }
=20
@@ -1830,9 +1790,6 @@ static int smu_force_smuclk_levels(struct smu_context=
 *smu,
 	struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
 		dev_dbg(smu->adev->dev, "force clock level is for dpm manual mode only.\=
n");
 		return -EINVAL;
@@ -1917,9 +1874,6 @@ static int smu_set_df_cstate(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
 		return 0;
=20
@@ -1934,9 +1888,6 @@ int smu_allow_xgmi_power_down(struct smu_context *smu=
, bool en)
 {
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
 		return 0;
=20
@@ -1947,22 +1898,11 @@ int smu_allow_xgmi_power_down(struct smu_context *s=
mu, bool en)
 	return ret;
 }
=20
-int smu_write_watermarks_table(struct smu_context *smu)
-{
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	return smu_set_watermarks_table(smu, NULL);
-}
-
 static int smu_set_watermarks_for_clock_ranges(void *handle,
 					       struct pp_smu_wm_range_sets *clock_ranges)
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->disable_watermark)
 		return 0;
=20
@@ -1973,9 +1913,6 @@ int smu_set_ac_dc(struct smu_context *smu)
 {
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	/* controlled by firmware */
 	if (smu->dc_controlled_by_gpio)
 		return 0;
@@ -2083,9 +2020,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32=
_t speed)
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->set_fan_speed_rpm)
 		return -EOPNOTSUPP;
=20
@@ -2126,9 +2060,6 @@ int smu_get_power_limit(void *handle,
 	uint32_t limit_type;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	switch(pp_power_type) {
 	case PP_PWR_TYPE_SUSTAINED:
 		limit_type =3D SMU_DEFAULT_PPT_LIMIT;
@@ -2199,9 +2130,6 @@ static int smu_set_power_limit(void *handle, uint32_t=
 limit)
 	uint32_t limit_type =3D limit >> 24;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	limit &=3D (1<<24)-1;
 	if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
 		if (smu->ppt_funcs->set_power_limit)
@@ -2230,9 +2158,6 @@ static int smu_print_smuclk_levels(struct smu_context=
 *smu, enum smu_clk_type cl
 {
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->print_clk_levels)
 		ret =3D smu->ppt_funcs->print_clk_levels(smu, clk_type, buf);
=20
@@ -2319,9 +2244,6 @@ static int smu_od_edit_dpm_table(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret =3D smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
 	}
@@ -2340,9 +2262,6 @@ static int smu_read_sensor(void *handle,
 	int ret =3D 0;
 	uint32_t *size, size_val;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!data || !size_arg)
 		return -EINVAL;
=20
@@ -2399,8 +2318,7 @@ static int smu_get_power_profile_mode(void *handle, c=
har *buf)
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled ||
-	    !smu->ppt_funcs->get_power_profile_mode)
+	if (!smu->ppt_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
 		return -EINVAL;
@@ -2414,8 +2332,7 @@ static int smu_set_power_profile_mode(void *handle,
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled ||
-	    !smu->ppt_funcs->set_power_profile_mode)
+	if (!smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
=20
 	return smu_bump_power_profile_mode(smu, param, param_size);
@@ -2426,9 +2343,6 @@ static int smu_get_fan_control_mode(void *handle, u32=
 *fan_mode)
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
=20
@@ -2445,9 +2359,6 @@ static int smu_set_fan_control_mode(void *handle, u32=
 value)
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
=20
@@ -2478,9 +2389,6 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *s=
peed)
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->get_fan_speed_pwm)
 		return -EOPNOTSUPP;
=20
@@ -2497,9 +2405,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 sp=
eed)
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->set_fan_speed_pwm)
 		return -EOPNOTSUPP;
=20
@@ -2524,9 +2429,6 @@ static int smu_get_fan_speed_rpm(void *handle, uint32=
_t *speed)
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->get_fan_speed_rpm)
 		return -EOPNOTSUPP;
=20
@@ -2542,9 +2444,6 @@ static int smu_set_deep_sleep_dcefclk(void *handle, u=
int32_t clk)
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	return smu_set_min_dcef_deep_sleep(smu, clk);
 }
=20
@@ -2556,9 +2455,6 @@ static int smu_get_clock_by_type_with_latency(void *h=
andle,
 	enum smu_clk_type clk_type;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
 		switch (type) {
 		case amd_pp_sys_clock:
@@ -2590,9 +2486,6 @@ static int smu_display_clock_voltage_request(void *ha=
ndle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->display_clock_voltage_request)
 		ret =3D smu->ppt_funcs->display_clock_voltage_request(smu, clock_req);
=20
@@ -2606,9 +2499,6 @@ static int smu_display_disable_memory_clock_switch(vo=
id *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D -EINVAL;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->display_disable_memory_clock_switch)
 		ret =3D smu->ppt_funcs->display_disable_memory_clock_switch(smu, disable=
_memory_clock_switch);
=20
@@ -2621,9 +2511,6 @@ static int smu_set_xgmi_pstate(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->set_xgmi_pstate)
 		ret =3D smu->ppt_funcs->set_xgmi_pstate(smu, pstate);
=20
@@ -2722,9 +2609,6 @@ static int smu_get_max_sustainable_clocks_by_dc(void =
*handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
 		ret =3D smu->ppt_funcs->get_max_sustainable_clocks_by_dc(smu, max_clocks=
);
=20
@@ -2738,9 +2622,6 @@ static int smu_get_uclk_dpm_states(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->get_uclk_dpm_states)
 		ret =3D smu->ppt_funcs->get_uclk_dpm_states(smu, clock_values_in_khz, nu=
m_states);
=20
@@ -2752,9 +2633,6 @@ static enum amd_pm_state_type smu_get_current_power_s=
tate(void *handle)
 	struct smu_context *smu =3D handle;
 	enum amd_pm_state_type pm_state =3D POWER_STATE_TYPE_DEFAULT;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->get_current_power_state)
 		pm_state =3D smu->ppt_funcs->get_current_power_state(smu);
=20
@@ -2767,9 +2645,6 @@ static int smu_get_dpm_clock_table(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->get_dpm_clock_table)
 		ret =3D smu->ppt_funcs->get_dpm_clock_table(smu, clock_table);
=20
@@ -2780,9 +2655,6 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, =
void **table)
 {
 	struct smu_context *smu =3D handle;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (!smu->ppt_funcs->get_gpu_metrics)
 		return -EOPNOTSUPP;
=20
@@ -2794,9 +2666,6 @@ static int smu_enable_mgpu_fan_boost(void *handle)
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->enable_mgpu_fan_boost)
 		ret =3D smu->ppt_funcs->enable_mgpu_fan_boost(smu);
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 39d169440d15..bced761f3f96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1399,7 +1399,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
=20
 bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
-int smu_write_watermarks_table(struct smu_context *smu);
=20
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_=
type,
 			   uint32_t *min, uint32_t *max);
--=20
2.29.0
