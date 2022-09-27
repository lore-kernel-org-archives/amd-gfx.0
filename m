Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA357C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 03:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584F310E898;
	Tue, 27 Sep 2022 03:07:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A3D10E898
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 03:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1qoQzfHNXgd1TFENgOQWleAkGr4irgI4hoOx45XGRcKr1UdLM/yx6V0tm97L4q7Hnp2k+/aJlMctR+Qh5D8kN0K6yed3772VeIZLJOUHPQVYH7w2rJ5b7a16a+jQJ3easSoR/feWignNf+d3frYHeks7/3KlBRZAD6ECDYUjq+tfpNMnTexBsSHRGK+S33NQXnnnUetJezSZjGcGU/dVb+toRCVYrbmQE0HCOcBGCyuRGeMscP+LOTFOeHM+VvMAJCKBgjMU3YAf/infhmEutwagidF0LLP7Yr7mo3dnstosSIGU8U54C2gHtd8YLWth7JBlOm24jrJ4kY+gtz5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN4zZ7Y+C7oikCPPMD8Yj7a1ut+YmIX6js5yMQhQ9VI=;
 b=KFmzJMlsQSrAbP72oWKymlA50NqzEOFUD1ccwhmdqFAladOYc01Ueyi+dhvK4UduIeJfzZkuTC5qR4i0c6Wj47bWSBgR+450iekbTcGYUNbZI9uBLrGMmOHzvDOcHMK+whac22o3J0fR77eIxjJKy1COhnTz7ZIJ8vLEql1ycCsWPu3JN8xeGtOKIHFrX8gqGQtDr+8UWo/M9i/t8OdD4NE2fQARJv4WDoNxORLkQD9sDBBLSdPTUaLvuKkxsqX98lbmXJrYs7Nzih/qllJj1S2WI8J0Fm4v7lM9yWsf8ReJ3o7Td+fIwF4chFloo7nmn8S64apd1hUmnmbTPqWrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN4zZ7Y+C7oikCPPMD8Yj7a1ut+YmIX6js5yMQhQ9VI=;
 b=WHUpBnfdpN19ZFxttShG9gvADiAIblzpxsRg+VC3xarVgkoFm9x3ZETEWBQ5ihMRk0rj0Uu46bUpd3Liclj11rRxj7J0BEK0St/MLkuwHffpMXUewPcIqIbnoJv4Hz7QHjLH8lFOXAqkpbNHv1MFH5wGtUg+EZN6NFFRai6N0NI=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 03:07:51 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af%4]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 03:07:51 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add rlc_sr_cntl_list to firmware array
Thread-Topic: [PATCH] drm/amdgpu: add rlc_sr_cntl_list to firmware array
Thread-Index: AQHY0hko5btbXvnOSUCM5dyHp5m0ha3ymG7Q
Date: Tue, 27 Sep 2022 03:07:51 +0000
Message-ID: <DM4PR12MB5181412F20FA23640D178B39EF559@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20220927023032.13051-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220927023032.13051-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-27T03:07:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cc85d92d-bb5f-4131-870f-d814f3eaa931;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-27T03:07:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e7ce4604-059a-4918-8364-b73bebe902b3
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|LV2PR12MB5872:EE_
x-ms-office365-filtering-correlation-id: 2244f117-158b-41c6-d8ee-08daa035770d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEx79s6nQWaHYEbfc9k/kv+prJy8JfDO+Q+hLIkSsy86SkCuLYMrs4B54P8kLiIhcFkK55znmjugZ+wz3s4RehF07FoXCN6tp23WqnLJ1PWxhDQE61tRzKI6jPQfk4ejl05tuAh4DX+D3Gl+g7TFgIsfEuDDofmSH86NCW+n3XUfzJfJ4VwpagJ7zQ63yzmC8A77BjAbzKtT3tG+98tQkWea18plTwXOF0suExGIMpYaWbnTMLTw9ZgxJBwIGhm6mbDsuqvFypAlmx+94smOLEVmcVqsG1ybhSGvvcerFpRJ5l1gf5Iga20jtjA3et03FnWEcHqIOumUR1L/C5YSI/Pv7cx9oLVJPGxBnNUIrkqQP1GO5PhfBO2QjAODhF8Q/VQhRt0OIGbTiMVJSBHx6r+tFaelBbcl8g80U9K0lcsyW5WP4mR4CK6Wv7Q+bJfiNNrSIA6jnwn7lWqMg8WjQxpPa0LO1EXTymkl0dcPn3RcGPCA/WT7eF9arG1M65KaoKEs0rR8yX8goQUtNJIl82d3sj9avMhGKxUUiKSvF84jXQITBbSzzqDe0Opxume9o5G9NaQF26Lvw+b9MwS09RpVatAXMH3/ID/+3MwieZVoZVIli+F9PrHImiZ69sKRjVFOWE6fmYcp4uGHySLFKMXNmtNub5MQz/VMCOs3X7SHyWLrwERtGwWQgR63GyadospuAoLkdRQH0u6yH2WeAXvECevK35OBCookJf89V8LUTaw+pBY/Nir4QTFH///9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(53546011)(7696005)(6506007)(71200400001)(41300700001)(9686003)(83380400001)(186003)(2906002)(26005)(55016003)(5660300002)(110136005)(6636002)(64756008)(66556008)(8936002)(76116006)(66476007)(52536014)(478600001)(8676002)(66946007)(66446008)(316002)(33656002)(38100700002)(86362001)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+T6lse24tdwEiGJzaIHYd9tMbEMQky3vIhBwpJhSoNcsX0TCHUAu+DUd3vkq?=
 =?us-ascii?Q?XXNH42o++/U18BnxfC6xOhPjk/KgcLGnzYjOKyUC1rf84Da3LjaBAjKBxuX/?=
 =?us-ascii?Q?t8BZOkq3TX4wBTS67FN1tX0kDxzWsh23rA1zRpmXOXr1X8jVnEN2hQ/pWHSI?=
 =?us-ascii?Q?+phLpdBLadHOn9oaeMHlvTRvp7McCuqEns/u8x1BpUlwZj1JKVFM0SdnHXm8?=
 =?us-ascii?Q?Rw+WCZLvl69dQVz8T9vPti4qUIIL4ujfo3XJ0g0vCSKXuxh91eHK1nxMROI3?=
 =?us-ascii?Q?+tJ/eazFGLUqY4u4v5khXvXFIJhu2I2/eoAdlrdHwDoko3OKkjJ+eCtbRw6M?=
 =?us-ascii?Q?M7t7wsefwEtZWrKH1r1KXcO75gW95EzLPNd+ZdFyfSTVpg6o58jYEclkOT7o?=
 =?us-ascii?Q?h2j+vT32i8AraZL9drzqg4kaGjO6CBVC+nYsaabVxc440On1BE7TamjhIUCT?=
 =?us-ascii?Q?s2jzqxCktwoovc3T2pmKuJOy1VEfojLH9U5oUXwT/QXqxtpEuPfD+qGDdkYs?=
 =?us-ascii?Q?qWWCyxrlxTpZol5kaCYJdnQk406pqPkJXwJ7f74F/Eo0stNSQo6GtzV8pjWI?=
 =?us-ascii?Q?adhc9Ipjw/6Kq9MBDoW2wIqLu5Gl3yY+xJi1brWfd0EIran4TafzoETEHnRP?=
 =?us-ascii?Q?smIeq2AV/YKHz/WSXkoFqVVl3V9Hq3eIe5D0fZp4EfqZT+HcdUeY0K2Qk8Yu?=
 =?us-ascii?Q?st9o8jU6n6euuC2Ah+3vCcR5LivIVoiUhDqHw55yD/1UYp52vhO/5hqChJr+?=
 =?us-ascii?Q?A6NhkKH9rZaIbNat4pyycu80w8HfiWNIqtj18iwL2fS6KKjA/UWBc6U3nioX?=
 =?us-ascii?Q?kJPrOmxhYegw+/KwL2Lr9tqT5s3dJmQxJ6M7ZiWqtIQo8CYJZVHD0fFcaAWV?=
 =?us-ascii?Q?BW4+TIHc3FM7ypL/RI9lC1/nLOJOumSylCTGuOyw9AoIGKAxEwEklQG23b8y?=
 =?us-ascii?Q?AwQVBcMUyftW2y7pMWOmAg1wMHQD5tT0muka1cRE8JIiVin72k6hcp5jn90z?=
 =?us-ascii?Q?AhG/MfAD57nbED/0KzTCNfXjg+mhtcDig4v8tPUXZ887Rblh1em/xp0wIVkh?=
 =?us-ascii?Q?+n8OeyI4tg0YEYIZ6sExJzhEdro/HoCVm0EvhngILHAaRPuP7Siew/kN23RA?=
 =?us-ascii?Q?vVQ9yJwbFxGEjdiAe/OmwIQ4MFagWxBG8ufXS6S/fUepCWJHJy0v8DsGNEeh?=
 =?us-ascii?Q?PIeOnELt+3xXC3mIwTJJ0vRXwtBBZ2DWTShJOL9sK1ECdBmjhKa4v3rIfzxs?=
 =?us-ascii?Q?x2FyQvtQpLJKYrQ93j2kFLD2ZPwtVRsyZbSgEy8JKuisio+rw9BFI/vP90Hc?=
 =?us-ascii?Q?lXL8YDcEEGD33BQA4nJcWMz0on8mSjynl2oZE/wftSkyOCF6OO3dU70p1j1x?=
 =?us-ascii?Q?wrKuTvwJV2pr+ctKEySYUQSezB5ESId6+vuXgeV3mbN4MFWdMwopUkQ5saZN?=
 =?us-ascii?Q?83x3HzdBZp6hmFmvDnPuikAmvem6rtkRLKXx8YW/wcGoh1nfJ7TuWP2WQWpd?=
 =?us-ascii?Q?eo066AABzRiG6JR6IF4eJaEsL0va+mXm1RM5MegRIWhcAtA9AtGznpQQteBD?=
 =?us-ascii?Q?hXSNQ2OoakSdO+rz3hk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2244f117-158b-41c6-d8ee-08daa035770d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 03:07:51.6984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWy5kSAvyaslvmHrooXaO6sWTnBUcWww5kEuHyMml6vfSFfB1Nq08UyJyprF4aW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Tuesday, September 27, 2022 10:31 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add rlc_sr_cntl_list to firmware array

To allow upload the list via psp

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index 13675b3aa218..792333206362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -359,6 +359,14 @@ static void amdgpu_gfx_rlc_init_microcode_v2_1(struct =
amdgpu_device *adev)
 		le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_list_length);
=20
 	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.save_restore_list_cntl_size_bytes) {
+			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL];
+			info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL;
+			info->fw =3D adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=3D
+				ALIGN(adev->gfx.rlc.save_restore_list_cntl_size_bytes, PAGE_SIZE);
+		}
+
 		if (adev->gfx.rlc.save_restore_list_gpm_size_bytes) {
 			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM=
];
 			info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;
--=20
2.17.1
