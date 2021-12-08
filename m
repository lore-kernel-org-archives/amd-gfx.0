Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 14:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51946736B0;
	Wed,  8 Dec 2021 14:45:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318F2736B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 14:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNU66XjN6pgi9wY/w0fy8IIKePr4/F5rKBoVcSsVsBF+yC/KVuXWOjVUM/VjitlbYO9A+OTw3K5U9EWGWL/ZWKPyNF7J7daNLniEgZTZJL+KD6KByQEi47r4gNADcHmnJ8zgy2FshwPgjCa4JY2a+Hta5xavWWJ4Pdh4jyu0Pq4kA33HqEPOD0b9kRMasIr3XqHrHWdboM2PDQ+V9JoyfH4FmyE57Saz3QhrN15tfiE/c93hCv2eQfjYKiBEvueVEvOQTUTWVWhS8iwuCJCv4weSktYGUYYpDPY5dy8B1K8rorXU9dG3Q5DdNHMo+ShM0juUEA7D7IFl/L4jJbTupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXACXCBl8pKbBVk/XQyuLKX56uSSc/59BQU/fOepODg=;
 b=DVCPOyfLM3QGvR1Qr9Alm/Ar1Ar5UVMP3A/0y7udtGvTWdzFKWVMxKE/dt4e0BSSDPEpbUPy1IFkabcLWG6A7XmuHgUIJEJz76n3K/k2EDLzNvH2xcD0Gz3PsGvVtifAEijv0mXXhmit512io7aEOvJu+PYTE94AokcIEu+KA5Gc1cykp1UYxP3B4i3EDbeMtWii9dhcl+/BEYHvbf//n3CeK8Aa+q1vSyeneC0NeRyQj623Ag/23LESIaKZMiDueyfXF+5wc2YeJFwgWWesku3jxaW81FxeIm2sW09QwlyIUYCZ8Xl9hQVu9yRWVZXPYCnj7XVeMmSQPQ9L8bb3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXACXCBl8pKbBVk/XQyuLKX56uSSc/59BQU/fOepODg=;
 b=m9CWppZ1PSyl4zK/nuLn8yLwpnBNdYUNrgpw9A9jKddw0OYb9YkdA99+tpjOKVWWzBr6c5sJwccV12iJmkGutnA384sNcCE+ee2xeya8GSfgf8nQge9zctN3FR4zNjPb096kiapT8BnQC+VKQ5ute8bEv3L1CkjigSyVHV2TV7Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 14:45:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.032; Wed, 8 Dec 2021
 14:45:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove the redundant code of psp bootloader
 functions
Thread-Topic: [PATCH] drm/amdgpu: Remove the redundant code of psp bootloader
 functions
Thread-Index: AQHX7CCALTHzfVU3d0ivCihpdhS5xawoq2xQ
Date: Wed, 8 Dec 2021 14:45:20 +0000
Message-ID: <BN9PR12MB52578474AF7D12916B14257CFC6F9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211208104311.180213-1-YiPeng.Chai@amd.com>
In-Reply-To: <20211208104311.180213-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T14:45:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=04239496-6dbe-4af8-b79a-5bf64ca55a86;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 397f2492-c078-4f4a-46ee-08d9ba595bd0
x-ms-traffictypediagnostic: BN9PR12MB5083:EE_
x-microsoft-antispam-prvs: <BN9PR12MB50836886914EC4EB5A63D114FC6F9@BN9PR12MB5083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEzVMslTqgoUwQ6bqcKi/u289jCrLggd6GZv7szVQW3xj0BeWd+Va8au8VWTyp7PIuqPh8ihcUbj3du43hsIPzzPnh8MueYcHzGdbd6gPM+4ufUk5ziyrEavOz0VB3RPELSPYdVywNymsebDvsaU7ldjwgkT0XZNT3iArVlqx3bWWoariOdHiyVcMrSAyytWuvNdODrd/bLNOtUJwV7DRRPPgHjO7eBxyd6j9TKwRlwORTffo71TgwN0xgeOaer0IdcgosdPt+KKz73oIuEq4F/m3uDbUjmN6Ec07CL82+9J5PaISdKLH6aWu9Ji6eP9DPU0aZBBvsn1w52Jf+Zu79FRkBE7LA2aowk5Jih+Zk1fk8COAVobgVyNIPcQWxAvLsEUVXkoQV4wxU1sDdxhHbDJWDFqCQYtzg3WOnD91oapE/VxzLEz2pGr/Jazauadw+9XQt8n5RAplUUjRwtv/vQ2pPKJYW20T/fHNCb2wm2Tqi3YFk9QVB08fbkwR+0KLAXF4tP1Y/ERGU2JpvNAx5bhyCJAt3Sk+vUR0jM6N1HQWcg7Fv6timUDvFw39nRvKQMA68xOd9K3dEyXbYK8xJghpiGKrenFEBmLEUZ0oIyX5rl3osO7MLf8fIahv7kcW4rFUlKJ7+YpQmwIUI72cMJ++yPqMdKrOVDJH3kxHwL8oZU7BQrH3Ps9YfKaGTYnFCc9YZy5E/h8kKpi/eGCAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(5660300002)(66446008)(64756008)(83380400001)(508600001)(54906003)(110136005)(38070700005)(52536014)(55016003)(4326008)(53546011)(122000001)(66556008)(33656002)(186003)(2906002)(9686003)(71200400001)(66946007)(86362001)(26005)(8676002)(8936002)(6506007)(76116006)(7696005)(66476007)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xvqSjsPphlE3Q5vOrFd4qXN/A5Ss+tcS6gzI6P2WtBXrpG5rEe7jxzdnwSOz?=
 =?us-ascii?Q?d9+Ls38byRB/PEtvunpvRPksKR2aLeSXlVKTH9XpBAiDGDwf/LH/VE+ZsNR+?=
 =?us-ascii?Q?ZBy+A1F5tVj8W3w8urUpICuhK1mmjZInItFQFJXXh8LKvlAoElbaEuC+Fu3/?=
 =?us-ascii?Q?UhzQbc0VgEKJF+ibFa6lA1MlF7mfem0mtg9mGDotUe20AtNq8i+lvyC3jJd2?=
 =?us-ascii?Q?7j9alog0nqgBaRmY/6fANiAXxbHX7IM1q67zFvkV73yx+cIr8QvWvn3iGWwq?=
 =?us-ascii?Q?Zg7t74TxTNp7jnnKgd8k79jtZMP2CZ42kDsn1Eq/ovXqcTPW69LBhxWV95JI?=
 =?us-ascii?Q?apSF2E6Y7aLLsV9tmUnZeMLsdLw9bwDLwqIv+rulb7TnYufxxZcHM7+kGg/v?=
 =?us-ascii?Q?YP0+cj1khBkxR20IfUtGe7rP4OG5Wu/8rvlnAxH201vIWGh8yqB/n7LPxXX0?=
 =?us-ascii?Q?bJjv0ufP1aNjFepKQ7dUnFpXYGoFrjHDFSAbitrhA0n3SIZuLKqlo2vr+5XC?=
 =?us-ascii?Q?9DpO8/UVU57q6wf4Cnx5yCGORfMnft47vA8U6GpIKXi2pypMsjj1J5IeQiOS?=
 =?us-ascii?Q?h6oeLR7NGYnB32TVTq50/m+SD+cNBaa6/dsFD96PS5dQmyztICGTYkxaoKiL?=
 =?us-ascii?Q?2bS0EznJt5BCAO7E2e8GaW+E164i+VmHjyYA0+16jZco6tHwM9/fNfj6/Qen?=
 =?us-ascii?Q?CqEPi+uQFkFlkyYLlrFzhrjnSGKhm4+9xvGLnp0x8zvFI62kfeWj/O0Jz1ln?=
 =?us-ascii?Q?eNkVyYIShhgcyqgLCtUmFLiHtAIdrcHcIM5fmpKzKVht6Kd2D/dVxZki2E0i?=
 =?us-ascii?Q?tp/SUKGH/sc/f7NxyGUJXtIW3UMwtia/ERoP6cINR0eZ/9zIKyUthOONmaSQ?=
 =?us-ascii?Q?XYN8hazFMOg0q219NQs9WglY6Z++GSfRzWMI9pUGhQFrnXknJRn0SAvJgO2p?=
 =?us-ascii?Q?B0qfEUWtA4EjIgmHHdRxSVXwTspEPk9fbLxsZ2Oi0Iz5459omItgliBEyBa5?=
 =?us-ascii?Q?F/fqOutDA/bWP/GCyNmjsTWdlwIIOgoJkg0mY6XZLeM0dmWQ6DMA57BpWo6l?=
 =?us-ascii?Q?VFDf+byEUGFdm97DL4NQwD3MsjSzmvEFHq03tdSEIvAuda+tpMDggUhxBOlp?=
 =?us-ascii?Q?TuiU+M5zsTR5BK8cPtd6RC4HqOeNyI+5oxp+NJDdcSYgNd06WSlFbzBTxlip?=
 =?us-ascii?Q?xrcsOcMFsh/Sbyu0xidd9Q7fP4UT8nvqIliUz4y+lGJlx1LvsMNih9wqs0Pa?=
 =?us-ascii?Q?GcaOdI0lEy9a3QY8J9YhAJ5Zql2PMI3P3Cqm3Ey7WS2dv/T6lAFJOTYK0woc?=
 =?us-ascii?Q?bPMhjLSoCdTvJLBd3Ki4Fpoh/cynqczDxqCKcs7s3Ifq8faYtmUSDb2RovpQ?=
 =?us-ascii?Q?p1FTw7Xd0nkoDA9YWjOvwiutJ5uDDJy6G/YP/RKiEH6HBHHGBRkvxFw7i9x7?=
 =?us-ascii?Q?H3uslHK+20Ku9RjKlIiEZPaHgDbTrmnSY+Agwg/FwTBLS14hPqng61JMegzD?=
 =?us-ascii?Q?Cw2Oa8N9bK7W8Eh1F7EG7qCRjgdCEWmWioSGYLp6yMng1lbDgYRd5+TT1t7J?=
 =?us-ascii?Q?m1iEMjujgFvDIr9i/hUqx3eC/e6eOj5xpj0codkJYj7ROhuBReQcwuANOdWP?=
 =?us-ascii?Q?3XaE6B/x+xeSAAKwSsHDJsI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397f2492-c078-4f4a-46ee-08d9ba595bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 14:45:20.3812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iC6yNmkQQT6Ashvh19nsla8KfHymZRebkKRmH5uaZystW/7Ogw0Ko7Um9UG962pq//qXBjWzLU6HadvbKxM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Feel free to talk with Likun to get a sienna_cichlid board for the testing.

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Wednesday, December 8, 2021 18:43
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Remove the redundant code of psp bootloader fu=
nctions

The psp bootloader functions code of psp_v13_0.c had been optimized before.=
 According the code style of psp_v13_0.c to remove the redundant code of ps=
p_v11_0.c.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 79 ++++++--------------------
 1 file changed, 16 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index de53ca061d88..a3e6aa17a8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -284,13 +284,16 @@ static bool psp_v11_0_is_sos_alive(struct psp_context=
 *psp)
 	return sol_reg !=3D 0x0;
 }
=20
-static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
+static int psp_v11_0_bootloader_load_component(struct psp_context  	*psp,
+					       struct psp_bin_desc 	*bin_desc,
+					       enum psp_bootloader_cmd  bl_cmd)
 {
 	int ret;
 	uint32_t psp_gfxdrv_command_reg =3D 0;
 	struct amdgpu_device *adev =3D psp->adev;
+	uint32_t sol_reg;
=20
-	/* Check tOS sign of life register to confirm sys driver and sOS
+	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
 	if (psp_v11_0_is_sos_alive(psp))
@@ -300,13 +303,13 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_c=
ontext *psp)
 	if (ret)
 		return ret;
=20
-	/* Copy PSP KDB binary to memory */
-	psp_copy_fw(psp, psp->kdb.start_addr, psp->kdb.size_bytes);
+	/* Copy PSP System Driver binary to memory */
+	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
=20
-	/* Provide the PSP KDB to bootloader */
+	/* Provide the sys driver to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
 	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
-	psp_gfxdrv_command_reg =3D PSP_BL__LOAD_KEY_DATABASE;
+	psp_gfxdrv_command_reg =3D bl_cmd;
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
 	       psp_gfxdrv_command_reg);
=20
@@ -315,69 +318,19 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_c=
ontext *psp)
 	return ret;
 }
=20
-static int psp_v11_0_bootloader_load_spl(struct psp_context *psp)
+static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
 {
-	int ret;
-	uint32_t psp_gfxdrv_command_reg =3D 0;
-	struct amdgpu_device *adev =3D psp->adev;
-
-	/* Check tOS sign of life register to confirm sys driver and sOS
-	 * are already been loaded.
-	 */
-	if (psp_v11_0_is_sos_alive(psp))
-		return 0;
-
-	ret =3D psp_v11_0_wait_for_bootloader(psp);
-	if (ret)
-		return ret;
-
-	/* Copy PSP SPL binary to memory */
-	psp_copy_fw(psp, psp->spl.start_addr, psp->spl.size_bytes);
-
-	/* Provide the PSP SPL to bootloader */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
-	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
-	psp_gfxdrv_command_reg =3D PSP_BL__LOAD_TOS_SPL_TABLE;
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
-	       psp_gfxdrv_command_reg);
-
-	ret =3D psp_v11_0_wait_for_bootloader(psp);
+	return psp_v11_0_bootloader_load_component(psp, &psp->kdb,=20
+PSP_BL__LOAD_KEY_DATABASE); }
=20
-	return ret;
+static int psp_v11_0_bootloader_load_spl(struct psp_context *psp) {
+	return psp_v11_0_bootloader_load_component(psp, &psp->kdb,=20
+PSP_BL__LOAD_TOS_SPL_TABLE);
 }
=20
 static int psp_v11_0_bootloader_load_sysdrv(struct psp_context *psp)  {
-	int ret;
-	uint32_t psp_gfxdrv_command_reg =3D 0;
-	struct amdgpu_device *adev =3D psp->adev;
-
-	/* Check sOS sign of life register to confirm sys driver and sOS
-	 * are already been loaded.
-	 */
-	if (psp_v11_0_is_sos_alive(psp))
-		return 0;
-
-	ret =3D psp_v11_0_wait_for_bootloader(psp);
-	if (ret)
-		return ret;
-
-	/* Copy PSP System Driver binary to memory */
-	psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
-
-	/* Provide the sys driver to bootloader */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
-	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
-	psp_gfxdrv_command_reg =3D PSP_BL__LOAD_SYSDRV;
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
-	       psp_gfxdrv_command_reg);
-
-	/* there might be handshake issue with hardware which needs delay */
-	mdelay(20);
-
-	ret =3D psp_v11_0_wait_for_bootloader(psp);
-
-	return ret;
+	return psp_v11_0_bootloader_load_component(psp, &psp->kdb,=20
+PSP_BL__LOAD_SYSDRV);
 }
=20
 static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
--
2.25.1
