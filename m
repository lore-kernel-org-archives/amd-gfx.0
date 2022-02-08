Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F92C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 10:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E0D10E234;
	Tue,  8 Feb 2022 10:54:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B10A10E234
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 10:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne8TDIbfouU3KT7DJGQdtXUhyMz9MDzeJ9mIXdSaH38Fd6VL6Fb47VFQGGGKGIgnjYTYEBeGRdbGIrW53w2Ut99C5s6CeV4l8ZcL2vd+HAh6yZwWzHts2h4hahS9Q/sRV/F/KsJ2RYC+CRQ4FODOxxDzvuJmuTvM1nwQg6c4WPCIpJQnnzDID1rccKZoTCHiH6+p5JOsA5/1UL6j4YSP6Qw68Ssf0cbdmtGBCboydCjpAydEzaG539VG3yO0qkzOSZs6Hrv/f4GKC6qZl8XZ44Oj6ST3Qw1Vltha7+0cUaxtcVp4he1xwpB0XVoohbAA1FCgzfio8BzBVE9KA1h+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dd+NA+Ff61P4/2Y0Q8yX/b4bpP6TkivikUJhRvJCuQs=;
 b=SD6t/t0s6O73qaAkTIKDJwnBP/9FkSGQXdjTRVZDNKAulnsk/fVXYJjCVqQCImXXPY7iDetnMTdJ9VCJ0UKcMLnRZ9UX73xUgaDYHDgQwBUmWkI7HtMcdMArLOuCQehkChwhGNYA/ekleMhmiQ2y7g3rIKe5EER7cxI8qJFlugmGWE2HcRV/o59HY/5CE/Xq8z2amiJWHT1E2k+zjEbegmeFKbV1qhSdJ+Tc2IMWgegSP7Vi1VY7VFrJJ4AGt2TlJTfRpTpLJnV0vW4o/nT0L96nx1llxr2n3E/NaUoG7qGs8fOBDs3O/TMTmnSHpYVADU0+q4eBrck8TxD4IWmwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd+NA+Ff61P4/2Y0Q8yX/b4bpP6TkivikUJhRvJCuQs=;
 b=q8thf/R0eOxvkGWPMSQvr5km0aTeHIacnCe+o0iPSf7roaCxMC9lV0nFlrHalwAOdiC1Ssx/K/NBgmu/d5GqLgqTk9nJoNJhVZepkPjyZY1qvgFinMpLlODQBeZCDGXgb5P3ZU4vvliVmx6OiWPiWYBmae+VzLstNJi0I6e0HK4=
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 10:54:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 10:54:31 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Thread-Topic: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Thread-Index: AQHYHMRKEuI7k3gxsE6+AKRNd2dQfqyJenRA
Date: Tue, 8 Feb 2022 10:54:31 +0000
Message-ID: <DM4PR12MB5040B0106D3BAF984844F298F22D9@DM4PR12MB5040.namprd12.prod.outlook.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
In-Reply-To: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e6eabcb-5da2-4e4e-0b88-08d9eaf1629d
x-ms-traffictypediagnostic: DM6PR12MB4220:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4220925ED5CE450AD196DC02F22D9@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHkKqkgEEL5bHjhVIZdfZALPLHELIsNAx2ds7DHuu72dDslwKyi2ZFFZwx3w3yQjk5a8lweAL7/zuVm6mOEI5gyfyDlF368NQXVF4WbsqHJSrWISntJMiJr0NAiELydpuh1yh3a/tMUnNKmbBNczdTNzsRAfbdfwmbws9oIjw7ZglXlSD7UT1wlLMlGnwJvKHdaA62otD6kJodED3f38HdlPUSDvkM+WSnL2jRJGw4mmOv6AJP9rvemH/2GVFoM55CDD8VUPJPm4aCqZUhwz9gReHm3SF5O7sB99stsqozSZ6uB3nCqbK4q6h42J1STI0CSWBcPEyMyhfCV20KaNyIusbvSm3VQu9sByQ7PA8Vy5AK7GDu7emeid/xaGjrQ1Xe1OvFWTyM5IVRK/t6+DiKpZiTj0nGTFHUEUgiONmiPANVhxGoDmkToji0sQZYhMTo8hJJaOmrVtIqFG0tHVJoH7Ko0GW54XvEY99NOfl9WTzuf15d38ncRJdVB0LlIKodfDQu7uTZdMM/r+OtijO3mRtKs1KKgTwqJM1gU2AGPbW7rYb15hHcXOB2aASNCYIkE+2/CP1o2o8vBaUhM5d5YYNDBmN+w1BhauFLRvI6sGx4O7Kg80eZmz+3MExCxAys/T0kmZEKnD1jKuJH/j80yvtvf2w9R4QKgktknSaEkrwAkMIdB+1aBx+HwpV47rePb1EViFL7DMPn/et2ERug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66446008)(8936002)(5660300002)(66476007)(66946007)(66556008)(33656002)(38070700005)(6506007)(8676002)(7696005)(122000001)(4326008)(9686003)(76116006)(53546011)(26005)(110136005)(186003)(38100700002)(86362001)(71200400001)(2906002)(52536014)(54906003)(55016003)(83380400001)(508600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?za8JZnueN+S7rjcTtmUmHXeoqSmtr9x3CX8yZ+Z/iBanSS6fHVa17zT83xs4?=
 =?us-ascii?Q?WS1cyV7d+H/ymZDWSOtTjaiPNfCL2EMUw2Gw24M/DjpXmrg3YWiUEFHd/T65?=
 =?us-ascii?Q?wyE5semkj1FQa616UvOssI7mTGeDQ5nQDPQHrNcepHy3fkz4HhCVHVAPq/ZS?=
 =?us-ascii?Q?eDz3HO9D/MQv49GSyjoIFWxUbHF153NZ3Kju2jbbMrlja4SpWP1Uwe85tYC7?=
 =?us-ascii?Q?B46rBQTZ3WSXRZzaH8of2FCtJZqXmGkc0K4Ho3F9/C8raLHCvR3h1Ub8tOQN?=
 =?us-ascii?Q?hXcAmDALldLaNAmj/k9RZWqGaPtg6MMipykK6PQg+6BLeAPQ7jaepl8aAiLr?=
 =?us-ascii?Q?mNTYudx8rKQlKOV/3tf/5oC/3dsG8daanIDttxpglADNbkhQzAYE0in8IKe/?=
 =?us-ascii?Q?ZUniLrjidECZ1u52Y8YD/68Ca7div9LaPDcfGb8Epy31WmwHTvf54ogQR+Dc?=
 =?us-ascii?Q?2+/kSbeMJ4S2IL/XSuyy6s8RnK0CRC1u6s+HmW/BZEpC/bQ8VIxHoKknMtwB?=
 =?us-ascii?Q?6wAWk30aPriupkHvodbi6B/QcsoUCaCPnn1t27zw2Wv5sI2LLATresukPem/?=
 =?us-ascii?Q?FZsyPitln5tHN3LXdTPc82/LUj8ZpeTs8svf6qnRwGYbYy8UDl6JgeOFrKEs?=
 =?us-ascii?Q?VHlIMIEEvY2RHfWRhXYoaqPV7U8dbvdbyzf9sA5R6aP6kCXhNZ8c0EEKjZbb?=
 =?us-ascii?Q?zjxb7mFLklDCCbKomOOYoYAzw8VDJmOZoUWDPs3wKTXh9GgcQMcvGrzyVpHH?=
 =?us-ascii?Q?bi65ZM6lKMW+l6t0FWd5ndGVuu+qft5XmVn+tKyDmOkOzSqOaLJ7D7wMLtmI?=
 =?us-ascii?Q?mG1prQom/lefYnAAnNHL/0nktUu+WcxsEzoxFDA1kJyP43L+d/yU1Ul6qyAS?=
 =?us-ascii?Q?9x5EL8erAEMdtui4aBegch/BisfHQGdjodP+bsESD17YkqiL7ZyJZQvhNVN+?=
 =?us-ascii?Q?M3seZx6Xg+U925FKcS+it/y9O81VIfwsCKbzkB7mGEZfM8PSS+EvOd1h033f?=
 =?us-ascii?Q?lDWkhUZ/nSRZxCYZ6x4Icb/4wnO2DtKtwYe01g0kLvF5TOo8gfWAJlRcMx49?=
 =?us-ascii?Q?M1Ab5pFmADS5icBBhFCZug2hE0vOQNLtFgpZ/IT52D5G+1I5d5u/9YZOVzbR?=
 =?us-ascii?Q?/YhyXhkPaehaQcm8VruOnMnISRHI5Xg4u4AAn+sTCCSsCNVQPFZuYFRfKSdJ?=
 =?us-ascii?Q?CKe/TUuHUATxSlaWpzBOjeoJc9ZUBF/7soU78znyeaYdZWej5d0osUiKiCrw?=
 =?us-ascii?Q?F8VC+wgTJKfhwwAmNuf6ZMmmSMMaigpqchH7NDGIIXM2ziZobSUYMDDxQ5UV?=
 =?us-ascii?Q?ikYam5vDAKQ32a/Od8Oo/hY75AJzMWZOnbSR5fkA5Iqz5Lxj3Uybf48IuHY1?=
 =?us-ascii?Q?/isE80kl9z1DHjC5rGWrZpzibz7e0pxVaY/+stSI/9lIkHo0G2LtKsolMBxp?=
 =?us-ascii?Q?2xYhkhALadjbnn1pwRd3zQVQ7LZONDwchEJS4edJ72dPh30dwpMSbipW2I5r?=
 =?us-ascii?Q?YoQIwX7q4IlT4Qs6bgYGQWqc9ZmNjuQcrUnU4zpweY+kTx6hZ5nL94ivGj4d?=
 =?us-ascii?Q?dv4VlD/RrpNioT4RGMCLWMxE4Itw1+XYIHkc8n+RvfeFfYGRfVG0jzuEL4ug?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6eabcb-5da2-4e4e-0b88-08d9eaf1629d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 10:54:31.1332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85eVz7pqdmImu6C9juvK1wKVVArnKZTQNoVnfQtXvI3o315KcA8AeoV0sPrlf1ynu5eyPgDIXsuxqWl1qMrtwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I thought we spoke and agreed about:
- Not doing dynamic memory allocation during a reset call,
- Not doing string operations, but just dumping register values by index.=20

NACK !

- Shashank

-----Original Message-----
From: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>=20
Sent: Tuesday, February 8, 2022 9:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>; Somalapu=
ram, Amaranath <Amaranath.Somalapuram@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list

List of register to be populated for dump collection during the GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 +++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index b85b67a88a3d..78fa46f959c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,9 @@ struct amdgpu_device {
=20
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE]=
;
+
+	/* reset dump register */
+	long			reset_dump_reg_list[128];
 };
=20
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev) d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..dad268e8a81a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,  DEF=
INE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
=20
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode(f)->i_p=
rivate;
+	char *reg_offset;
+	int i, r, len;
+
+	reg_offset =3D kmalloc(2048, GFP_KERNEL);
+	memset(reg_offset,  0, 2048);
+	for (i =3D 0; adev->reset_dump_reg_list[i] !=3D 0; i++)
+		sprintf(reg_offset + strlen(reg_offset), "0x%lx ",=20
+adev->reset_dump_reg_list[i]);
+
+	sprintf(reg_offset + strlen(reg_offset), "\n");
+	len =3D strlen(reg_offset);
+
+	if (*pos >=3D  len)
+		return 0;
+
+	r =3D copy_to_user(buf, reg_offset, len);
+	*pos +=3D len - r;
+	kfree(reg_offset);
+
+	return len - r;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f, const=
 char __user *buf,
+		size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode(f)->i_p=
rivate;
+	char *reg_offset, *reg;
+	int ret, i =3D 0;
+
+	reg_offset =3D kmalloc(size, GFP_KERNEL);
+	memset(reg_offset,  0, size);
+	ret =3D copy_from_user(reg_offset, buf, size);
+
+	if (ret)
+		return -EFAULT;
+
+	while ((reg =3D strsep(&reg_offset, " ")) !=3D NULL) {
+		ret  =3D kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
+		if (ret)
+			return -EINVAL;
+		i++;
+	}
+
+	kfree(reg_offset);
+
+	return size;
+}
+
+static const struct file_operations amdgpu_reset_dump_register_list =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D amdgpu_reset_dump_register_list_read,
+	.write =3D amdgpu_reset_dump_register_list_write,
+	.llseek =3D default_llseek
+};
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)  {
 	struct dentry *root =3D adev_to_drm(adev)->primary->debugfs_root;
@@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
=20
 	adev->debugfs_vbios_blob.data =3D adev->bios;
 	adev->debugfs_vbios_blob.size =3D adev->bios_size;
--
2.25.1

