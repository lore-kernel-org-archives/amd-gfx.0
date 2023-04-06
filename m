Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A7EC76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 08:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E2188F78;
	Thu,  6 Apr 2023 08:13:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EA288F78
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 08:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4j9M15CCHbkjBjDfOq0D3Bo6hb8cmzQvpcP9H4lG5R/fb2PUiAZXAVQzQX+KYsy6B1ElGZTMWUllgLBH36Qo0zVuOvn1x0QJrMBYdSxXIhuo1ZwYY1BOLVOMudB9ou8fOSoVLEZeIGMa0W3guEJ+V3b3yUwu7TJNUbH8sxubHAp8LPLXtC57y7QU7cZoXK+faGtXOwn21qq7ANFYwghdQxZxRCxHPquq4x4p0US/mBNtdWkDLyMddq2SpuAbyt16yTjUzQd+51nf+LF9oXK9rJJaC8i9orEbaDZvMSu9pkbEGNURAeLNQ5ZcGHTmyM5XWmBzUXimYF1G1UF8VmX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0WPKUGZzAT2shtz26kJhijPoc9d97ep6lwvi6H+skg=;
 b=cWOisnH+DM16vGOFZsuTHscXD+wp69uToZ/hMUbuAqku71iiIIZIxFbbxl1Gpf2wUy/+GqVr8GpCcPsnMi2zkDumNd+Np/2yVYdmCQ6Qm7UL26PTntwwywfXLnSqa+bAz1IAsBXWOE6fh1SCOW2B7zQJj9EjpNonnFyqvgfJNzyR4TQoZZevKFvi42oATuC79ffcefoDjw982ULfS1395rY+OxN+deEFzhDxxqbFQ7QER4LnoZXZHGbsvy6rnH3YEtu0XRNUUwx55VlIsNHuj6AdbGQq2hLADr8qQv6dea4N/bEBU2VC6aMsiXRiR7URGhhw/bze6dybV1XusUtn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0WPKUGZzAT2shtz26kJhijPoc9d97ep6lwvi6H+skg=;
 b=kA76Te+pRtNWf4x+4BABFAKjPWaCv1+HNBPmABKQmjanHMkUia9nbWhzxFo61iYvTRO+MKvgIvRh58uURFHNRfwdNuiMyDnWHcQ9t5f31NJ5A4SYMhQmJqcpTyn13Sl/8FEFfzZX9S98oRhgDmX2inpkHa1rU1i3brpp6ZlKkQk=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 08:13:21 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::bdae:e5a1:6d73:892f]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::bdae:e5a1:6d73:892f%6]) with mapi id 15.20.6254.038; Thu, 6 Apr 2023
 08:13:21 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error
Thread-Topic: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error
Thread-Index: AQHZaF91fVmF7H3loUaZjmU+LQuXcq8d7nrw
Date: Thu, 6 Apr 2023 08:13:21 +0000
Message-ID: <DM4PR12MB5181E87934EE46C414790A82EF919@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230406081142.1426354-1-Lyndon.Li@amd.com>
In-Reply-To: <20230406081142.1426354-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-06T08:13:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=296e2a8f-420e-4530-b84e-3c4c9ed6ee90;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-06T08:13:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 63f3cb8c-5e94-4c66-87c5-e6bfe1e91631
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|BL1PR12MB5897:EE_
x-ms-office365-filtering-correlation-id: 5a6fba1b-327d-4f7d-9bfd-08db3676c947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuDNkahy+bbP2rCX77368PxPIXuccoK4EpnA6po03nnCXK7jal+dK/r4+XJv4Taoz3citlJWM8cHAaXNb5fjXtoWABlTvzaULNd3lW27ZHUYfig+OyQYVS1w4uiB+EJ0nhKnmq8G+R4fFngdpq3kgSvsNgEfFkE5lcPNeqJz0rjVgWDqEIpjv7oTeKr/OCIIyKb00UkRzoAz+sXOz+G9Hl3U3IqSiUYtBRPCvYmEC/+deQfLNomeOpy5N1TCVKbJ1BCy4W3eL97g9qGmjPpAqyIt2ozmSPlnyhNPjHl3NC7qWXV/qcxBq2bsTB1LDD3xk2II9i9NMvAr8SLa8w7tlro45idSpMAWmuAMt+rtQQZhBekq7ZPlUmb8jJiZAtsA5YYQn+657yqejJagle/icqfv0IOJKKcHHQEZgwto4DnG14buryV3B1oiFcCtVthudIqjaszkReBqUaCmSHa2+aaKVBzU3BG99V9DOrfZh0Y4RIluZCafjh42V7th0GX6xmOUTBFCy/u6Yu77/KtnvnFN4nmUg6GdJJOZ74w5UxGwaXMvk0cPWR4SZSnc3uboAIoYtFertuf6J7savRE6CDw5XO+u4i95FkoSY2242Wf90OWLEKuYAdgTlZ+m36o/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(71200400001)(7696005)(66446008)(4326008)(66476007)(66946007)(66556008)(110136005)(64756008)(8676002)(76116006)(316002)(33656002)(2906002)(38100700002)(5660300002)(38070700005)(122000001)(8936002)(52536014)(478600001)(41300700001)(86362001)(55016003)(53546011)(54906003)(9686003)(6506007)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+fXGRftkAhpRbgK9I/t3Jn5JmXAesfgL2ZVZYeD5RmtUD5hkYQ4tIo9nP44T?=
 =?us-ascii?Q?7DmCSNdH9Ib66Hms7wzUca9FiJ+EF+Nx0jrmO8GYsBI2VthMhLMBisyen+BP?=
 =?us-ascii?Q?G0m8SIFgNJGtoA6ZBoJJjOXqvDH5dZUbF9hG6sWzdznL+F0w6aUA1yzJUpE4?=
 =?us-ascii?Q?nmpf5T+bvmqrkZU/HItgHmk/jgvD0drRaYpgwDlVgWqgQarR4vc92sfOGiIl?=
 =?us-ascii?Q?YkndwcAllcn+2SPsDCx5g73/ZW2u6aGi2CqnwB2vUESlMqsxKuEqRUaa9XYo?=
 =?us-ascii?Q?AK6OoXsVxlpvwB6ibCQ99aypsPJK0UPZ0cel5CabqyIcNW7Q6Z3EGdOmdiEY?=
 =?us-ascii?Q?QjrKBvnegBmEHiu4sULC/kSPmcGe+rT0HO4w10ENrM9Wu/uVX5hcTqvmG4sA?=
 =?us-ascii?Q?znEcpB4DcZKeu3fUDkQedmtE6MXQSfKSBIKwDlhd85LvXMWfvbezbJbOy/nv?=
 =?us-ascii?Q?LaSN83sfCrOjvUxenjHtvoMB0DUCw53JQRLC83WKMLKyO5hutpw3fYEE7VXI?=
 =?us-ascii?Q?Hlte9f4jc7da9XiGe/FNUDQiC/v7QcJyrrybHDBwGRguhAal/8zNsGIf2dHp?=
 =?us-ascii?Q?ZrEsIjBn+W++3zy7V943nJip8nCrqg9F3I8p/e8TuThIxRavXCrp8ZpfhycW?=
 =?us-ascii?Q?zBKUccAILrMgEM1mB7JCcFicXD3Qx4VSaahyYwwBQv/LPwRzqQKp3X6xs9D0?=
 =?us-ascii?Q?/ZxFHRamr5eLnIHVetkyJ5LVlPp+DJA7zgIQJTMtluUxP59FDzzVRjpWx5Ve?=
 =?us-ascii?Q?Y4s9GVsOZObTly7l3NjCi8yUUailWgZl1sA/QegppqLWR0zc8RCaL2OlbiNf?=
 =?us-ascii?Q?JOLzpJRbVaLLHitHxWzGSICSQPL90iG/3YGMNZFcknP8oLK775HVKJ0ZO7QF?=
 =?us-ascii?Q?a5pvb+hBY4JcgAnx0NNOkARR0KugfT8lBaBOEtkUyAcVh5aaz78iSCEr7HC6?=
 =?us-ascii?Q?DeArPFtZm+GfgfW65OuxS34BQNxpZesg983dheeF08z6/hjXCcOEPGPYELX5?=
 =?us-ascii?Q?Ga+qV89E3uvIQDqgnYka4s858GP1D+jWCgun+R5Rb6n6JcuMa/ovmINl+Ku5?=
 =?us-ascii?Q?ZyrVxCWWO9mUXPL9Io5taNN3PxoEsRBOl0yL8c82+g/gt3g0FOM0HxVTu7vb?=
 =?us-ascii?Q?tUvLzkAJbu0rXOxV8ZrUsNRwWPjYqgVqNANtOlNTffSepeNs6ig7ngNsCpaj?=
 =?us-ascii?Q?xOzakDeBpYmUUnOaXkTWlxmXL0j3nWEO1mtLDFjkSf/XDJG61hWGZEcM5Dwo?=
 =?us-ascii?Q?IQKw+zm9qlec+FIJlvICDB6gVgPyEjYc+MSaMCWThdyf6nGTJrogsmGL1/ot?=
 =?us-ascii?Q?ktRnwC/VRPuKHlun7QgawcjcGC0enDIGvQrW9KLgyqtejVT54btBdIWW5MWQ?=
 =?us-ascii?Q?J/D69kU6JFcBgmA/kkklEza3QZC7t4c/3ClhYQqSSGlKhuvr3nitpQcJolf2?=
 =?us-ascii?Q?CCu/ZJ66h95g1E4WpNTY9GzAagwdHiDw0uidRbIKjHEEHYjjtcd8EbYFm82P?=
 =?us-ascii?Q?2I5TjoViA2LWRdmuUWjAXaW0fYOlYB4enCDmkJgmlzVcWH+kLBwHF+jRdidx?=
 =?us-ascii?Q?GmzxFv3jx02zIGwZdmM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6fba1b-327d-4f7d-9bfd-08db3676c947
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 08:13:21.3425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TITyCz3wz0jtLSY0VxBJWDwdpMR1siuTIu2EquH6pvMfzRvdy/DoMqR2Xp7p3+wt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Li, Lyndon" <Lyndon.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Thursday, April 6, 2023 4:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Zhang, =
Hawking <Hawking.Zhang@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error

Fix sdma v4 sw fini error for sdma 4.2.2 to solve the following general pro=
tection fault

[  +0.108196] general protection fault, probably for non-canonical address =
0xd5e5a4ae79d24a32: 0000 [#1] PREEMPT SMP PTI [  +0.000018] RIP: 0010:free_=
fw_priv+0xd/0x70 [  +0.000022] Call Trace:
[  +0.000012]  <TASK>
[  +0.000011]  release_firmware+0x55/0x80 [  +0.000021]  amdgpu_ucode_relea=
se+0x11/0x20 [amdgpu] [  +0.000415]  amdgpu_sdma_destroy_inst_ctx+0x4f/0x90=
 [amdgpu] [  +0.000360]  sdma_v4_0_sw_fini+0xce/0x110 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index b5affba22156..96b0c3d42346 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1870,7 +1870,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
=20
-	if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 0) ||
+	if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 2) ||
             adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
--
2.34.1
