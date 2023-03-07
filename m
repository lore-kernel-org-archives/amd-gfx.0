Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DB5C64EC4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 02:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEF810E34B;
	Tue,  7 Mar 2023 02:23:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4170D10E34B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 02:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EndYz0EQDtz5gYCX3Fv0KdRRhnRu9HcrFO1eyBb8Hm8iKprJO476EAaKUKTreV24Q8GhKWAz4di0FWXDFEoS9TZGd9+ERz2QWUQ+b21La8apKk3YKEfFVxZm6y+iviCX+iG3OIOMPX/S2cNsnU6MRjV+fp089sRVQSuc+Nmg+6qBuE/c4kAPKcfM0ad53vl4SzuGN8Fgo2LnwpR6QkG5yD4CPd7qnJvBpAxxqQye9ftIcLuYOIwlk679vRvCgTwtzvZ6M8qdVyjpwp5ZtDzqxhQYrw75RpdGRjamMeN6jdpjpuvBOHv3Ylq5E6QmCaL8ViSXRIGR2OPsKxYGEVgBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmTSF2KkwpHCvpYVRl2wCnWXKFC/ACKM6ALJRz7iwH4=;
 b=Q1NGG0kdDqyXd2mJmjFuJWPL0YNwyZxiaXtLUiNvr2r9gs70QHmD1qy8fXDvDUU5Kc6kV38cTB8yNT06oLld0vgtVqrHtUCkVyJ58qXQ7N1u9eJhb6XjMnJ0TXF7hGgnm9X3x5KONBkFFfo2vSILPnqx4+Dccsqkhs+IwksyxfaSHOzUKKvYQSz7dvkY4nlCEDsgcqMPDtcH1GW5K1Urw61606bLuhmhu9tkc+ssZ0INslOl2rq0wT3TPEsD5xnzyFVq5t7E+xUda6DCW0AmM7cRyu8vgAN7mVUvRW3DxTWiIfDGzlWD0VUKQQ0+USmEMahAsE+eo5OXvLeXLXneew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmTSF2KkwpHCvpYVRl2wCnWXKFC/ACKM6ALJRz7iwH4=;
 b=kjULkKAMizb64YMMM4H8z8cNVsm82JzAzjMS5W2OTy2o/rWVXMOkWYkShumSPbFCGnN+P6MQWMl/Jv1FkSLhy22lqRA4aPNcCpLr5IEF4WkLLUUUHWImYghdAeSISrWphpU4yiG+V1PI6gIlqYWXFE+5GpxJVQH/CovMVQtgCLE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.27; Tue, 7 Mar 2023 02:23:36 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:23:36 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu
 device
Thread-Topic: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu
 device
Thread-Index: AQHZUJpD6mpYXdETo0awbUh1IJAGqq7ulVRw
Date: Tue, 7 Mar 2023 02:23:35 +0000
Message-ID: <DM5PR12MB24698E2A9E22CB2F80FA8249F1B79@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230307021221.45890-1-Lyndon.Li@amd.com>
In-Reply-To: <20230307021221.45890-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM4PR12MB6350:EE_
x-ms-office365-filtering-correlation-id: 5b577d46-d473-46f8-16b0-08db1eb2f47e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2BqDyPzn105eaYB4sLPS5aaSYrVqWy2cNCL0cyrUoODGaF2pKxKG5rDhcL9vYiHEChbO8rWUm3cH0kmNTQ6zNM8vakM5dMMfe+qRtykfzw//S08sz+dkJnCc0OspN7oYVFunRWkChtN0J47vz7ZSAPTP+KiE3OwJdljxUBz7kssZefu7RPgiZGq7ZczPt7pOHv95NHx8t1ENRt4veThnXGVHm92XZx8d2WOrZEo84vXq/Yr4TP2OLYTfh6BIBFcKv4zvQ2r+c0X5YUCjh2ALaGg93mCJwmwZlEYIUXiLBjGeGiujmJ3peOF+LwRDgmCHCKG8CRuF94AibJCXjNiZTWAaJ5y1A8nT//w1vYBDwBqgL3i5TMijCEVI9sKksXpM/qkWQ66hXYgPRy3knnXDqxM5rzxZnNV9T+35BUIRtG37rdk1oYZ5GH7t9dohkfOyDzSFIT1fCOI07fAoaSKH3WDpnWPudzHqoMXiPQx2ZEVFjiyGzg3+5fU9oCPgdgUBIhc5lNgL9quj2rxSg3ZAYOg9grecL11YEQHTWYl9ZdQaaJM35uFDyIn5nLoKkouclhF1o6dTSH/n69boeOqJ6PSMLD8ZS0gQ9hpX+KZUDksQrPPlG4BbmDVPavCK8ktVqjXRbkEtl/AXMghFmKlQFZoUBxmZCXCMJWM0Dt/A2cWGEJhznwBcc9x7spJdJwaqokWUPhdH9aehJAp85Nlpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(83380400001)(7696005)(33656002)(478600001)(55016003)(316002)(26005)(110136005)(54906003)(38070700005)(38100700002)(6506007)(122000001)(52536014)(9686003)(53546011)(186003)(86362001)(71200400001)(5660300002)(41300700001)(66946007)(2906002)(64756008)(4326008)(76116006)(8676002)(8936002)(66446008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aLSlvxMOqSsDFRot/u/U9NdIOblpnuPx4uwj/moB6LCNv53UXC7y/hib3Rp1?=
 =?us-ascii?Q?VaOumBiM+6RMdsBfaWnX+Bjm5lvMEoJ3/ZdAcXBmIkqIrgwPZzLx9vr87rnR?=
 =?us-ascii?Q?ys4XuVwYeO9pYHKWNjAuHftlHGiDXaW64/Vha3U1kHbaA4zPLivfUoHx9j1f?=
 =?us-ascii?Q?ZASgSMkqD2Rjho+ubjPK8PxUsRBdfjHA1vIST5xhD1YNsOy8YJVNkzl2PqNJ?=
 =?us-ascii?Q?3pX0OyoALK/M9SKkulNGskQnFHYcj35rkPzegZOvHCzao6qE1GLq/ENUG/3m?=
 =?us-ascii?Q?wEd7ltlLLJGDChAUNf1dqMRC5sy+AaZW+7jUT4ZYHcEb3A69Ya1r2SAnQTZT?=
 =?us-ascii?Q?CugnKA68MViXY4ky9Vur8tlSagrRdHRHZ8lXf5vFlom9lylECyMubaLge6Kj?=
 =?us-ascii?Q?Fo83N42J1p4TW3EmIcY+KvFHYwVJGpHxo1Vq+NUsyP1ifjA8JxYmG6bBZ+Am?=
 =?us-ascii?Q?dRgZskNWLu9yof75z5Pi7LnHtEZKaqU5SxavpArwfIWDQzcl2oUIpLssxR9m?=
 =?us-ascii?Q?ubwpqTYb50pTIjBo2gOikY9N69JkKgyUlplelPPUTdzamHHJ3WWuefPMc20/?=
 =?us-ascii?Q?e3oGtUpE6nLF3f4KfHo/t7PX08LbQL0LskONAExDyAF/qdJy7Xo7Lk/64Xjy?=
 =?us-ascii?Q?6CruBzOLisi0Vm8hY6os8VvJqKBrkBfWFgLzglT7ca/MbomZDq47CITIo6Rj?=
 =?us-ascii?Q?vJVyQmefzKSw/Ayq46CqYjptpB5SCJKCvQigxGVHqtU6KbqoGdFctcUhrCHz?=
 =?us-ascii?Q?hZ1/L5yuoolXHKpHv3SKHDLvgvD8ysJlra2L4e1osiIRWCcL5h4ty7v92odF?=
 =?us-ascii?Q?q4oaOJWjuNY7wGwrwyocg+szXbpcr7sYKBG//20C7Eqhy2w2Piaz8sx8Ljeo?=
 =?us-ascii?Q?8n+lHb5H6EKUBXxsL7F4/xrRxOZ79SwyFOj99U+EgzRomwisk5CSWh1CQ6iB?=
 =?us-ascii?Q?54eTrdDdqCGmGlVoEQQd9YHKAm37zosBmk+KhdlouE5aPB6zvlRRvNwV8Mvm?=
 =?us-ascii?Q?ZUzHMTQP685MmPeLZsgevqty7BLckCV2HX9sbUe1r8OLEie3R98hxW89TkJa?=
 =?us-ascii?Q?C+VVMf0OXLjDFqeClVeSSNQFDHXOTv36nUec9WlKcXbPCYTPNUH10xeyTL64?=
 =?us-ascii?Q?4AXkwFMBwYNHCGXSMcdUaVXsnmOdUPnP4RXRrDPWY8nSaYfdAhp8mbkZTgBt?=
 =?us-ascii?Q?LqMCyl+v0Wk8igfM/c26noQWst5jRe7U6oTVdjLT5SuuMeMwo4XsQhDxo6Qb?=
 =?us-ascii?Q?dTAhs0bDruF8+OGVPY2NHRwsCS4NkpNeeUWzVi39TgHCtiO0lzeIaKzliHXS?=
 =?us-ascii?Q?Eawd/NZpvEo74EPpLkuR+n7dwkGQbUwPkEHQsXvl88wSqCmCNL6ehvVtGmqa?=
 =?us-ascii?Q?wIr5y488qFsk2kmCYI2fCCgGlkRRao+S076sR26Wb1ZH73QVZzFgkucIk0fh?=
 =?us-ascii?Q?+dpN5hTsxTXbFYj4kWihRXNt8/kikxBM2k9Q5ylRP4K9mmWBLUFo3IFowZtB?=
 =?us-ascii?Q?n35M4i18MAjCXeOc6Ohpb3avmuO/enVRvNcNFpgN2jKAoR3ur0nyV5DQlKpu?=
 =?us-ascii?Q?+KCwvieCYkgGxnbwiDGS+Vr6vefpt/GIYIR011zB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b577d46-d473-46f8-16b0-08db1eb2f47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 02:23:35.7504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKnRit5IhxVusBu93aAzrdYr6EbgrbiXPpk9xb62BJeFiZS4LkfrzBDVdqCj6UOkwFTJ4a1hi9t3/cy9Vvh9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Li, Lyndon" <Lyndon.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Tuesday, March 7, 2023 10:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guch=
un <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Ma, Jun <Jun.Ma2@=
amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu devi=
ce

Actually, the drm_dev_enter in psp_cmd_submit_buf does not protect anything=
.
And it is not used to prevent concurrent access.
If DRM device is unplugged, it will always check the condition in WARN_ON.
We'd better not keep adding commands to the list.
Simply moving the drm_dev_enter/drm_dev_exit higher level will not solve th=
e issue.
Because psp_cmd_submit_buf is called in many places, such as psp_hw_init-->=
psp_load_fw, psp_suspend-->psp_xgmi_terminate, amdgpu_device_gpu_recover-->=
amdgpu_ras_suspend.
So drop drm_dev_enter/drm_dev_exit in psp_cmd_submit_buf.

When removing amdgpu, the calling order as follows:
amdgpu_pci_remove
	drm_dev_unplug
	amdgpu_driver_unload_kms
		amdgpu_device_fini_hw
			amdgpu_device_ip_fini_early
				psp_hw_fini
					psp_ras_terminate
						psp_ta_unloadye
							psp_cmd_submit_buf

[ 4507.740388] Call Trace:
[ 4507.740389]  <TASK>
[ 4507.740391]  psp_ta_unload+0x44/0x70 [amdgpu] [ 4507.740485]  psp_ras_te=
rminate+0x4d/0x70 [amdgpu] [ 4507.740575]  psp_hw_fini+0x28/0xa0 [amdgpu] [=
 4507.740662]  amdgpu_device_fini_hw+0x328/0x442 [amdgpu] [ 4507.740791]  a=
mdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 4507.740875]  amdgpu_pci_remov=
e+0x5a/0x140 [amdgpu] [ 4507.740962]  ? _raw_spin_unlock_irqrestore+0x27/0x=
43
[ 4507.740965]  ? __pm_runtime_resume+0x60/0x90 [ 4507.740968]  pci_device_=
remove+0x39/0xb0 [ 4507.740971]  device_remove+0x46/0x70 [ 4507.740972]  de=
vice_release_driver_internal+0xd1/0x160
[ 4507.740974]  driver_detach+0x4a/0x90
[ 4507.740975]  bus_remove_driver+0x6c/0xf0 [ 4507.740976]  driver_unregist=
er+0x31/0x50 [ 4507.740977]  pci_unregister_driver+0x40/0x90 [ 4507.740978]=
  amdgpu_exit+0x15/0x120 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 4c617faaa7c9..02f948adae72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -603,27 +603,14 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)  {
 	int ret;
-	int index, idx;
+	int index;
 	int timeout =3D 20000;
 	bool ras_intr =3D false;
 	bool skip_unsupport =3D false;
-	bool dev_entered;
=20
 	if (psp->adev->no_hw_access)
 		return 0;
=20
-	dev_entered =3D drm_dev_enter(adev_to_drm(psp->adev), &idx);
-	/*
-	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
-	 * a lock in drm_dev_enter during driver unload because we must call
-	 * drm_dev_unplug as the beginning  of unload driver sequence . It is ver=
y
-	 * crucial that userspace can't access device instances anymore.
-	 */
-	if (!dev_entered)
-		WARN_ON(psp->cmd_buf_mem->cmd_id !=3D GFX_CMD_ID_LOAD_ASD &&
-			psp->cmd_buf_mem->cmd_id !=3D GFX_CMD_ID_UNLOAD_TA &&
-			psp->cmd_buf_mem->cmd_id !=3D GFX_CMD_ID_INVOKE_CMD);
-
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
=20
 	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp)); @@ -687,8=
 +674,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
=20
 exit:
-	if (dev_entered)
-		drm_dev_exit(idx);
 	return ret;
 }
=20
--
2.34.1

