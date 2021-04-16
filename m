Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49316C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 04:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F134E6044F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 04:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F134E6044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CF86EB1D;
	Fri, 16 Apr 2021 04:20:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BAF6EB1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 04:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgwF54eygDXpCZ+PZ6TPwu2DOU7r5HWNJHvsgBPGC1l0BUCCI6doOZ77bGNs9dqorWix5ngMEkIYce6J4IAek4BvaCqGi+YrPVb4FDpJWECpFmRdl2qu4KJ/b2lP+H4lxk4XRZQzXEKt/5UhJIEbUE59h6ZLi4cC2ZilQ4GlzCsCrwCmDNJ8eGIouUEIUgZRc+eHZYIx5Yf8lDTqOgetAh8aQJlu5okWu1kXKKL502AWS5ZNJDeIvVEbjCRtWBP3jUBfht5F2KCiM+UZWIWPGr7dCeRMLxvuAoIgixjsnIM5MOtU5qocznWYOTwaa/vl00MO9oGaA/vAsM4eoN/97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQV+0xE+hj8ouQVSU8c4X45p9PtxOmWM/SQL6q845AU=;
 b=B4glUeaGa4rsFmgta+YTuMAlPbGcA49NsK8r4FDs+obn+zPULXG87pXhMTTaw1m0BnzKSiFhrioYwHX1xIFDPoAY4cwFrNVg54D71cu0xqlLprUjqC3xiohMNaH5rUW+Ff5yAbGf4ExdIR0VAxwTKf/EAawPmBxSJThjdWLMY6qyZHKmSIt6NUIxhXh0TykB6fozGkjy4kLgJbsSnwy4ErZqiySGlx86wGtoYsN4fk/P9rUDCFOIBUslHVpihc2h5hRt+6Ig0eMWzzxkDzvagc93shZzrRZVP5ObETbsE6Yr9YBINmYj1mBVEY+BIgHwko3ujBgy/JEjoznGnYAcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQV+0xE+hj8ouQVSU8c4X45p9PtxOmWM/SQL6q845AU=;
 b=2h8yxUq4D6wzZIxXvcNlMK/QWoioyGCScSH0Zk/YiUv+slySLiokW3p1K3Of+wskTpqqNeNChc8+Tb/RwEH82VznE1VKhkBoCAipgGvoRLHuiMmOwDlV2svRd+taZNyHDpUkILJ8rugHX9n+oP3/gFcBB3w0Joy+mWYLGUAMMq0=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 04:20:43 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%9]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 04:20:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private buffer
Thread-Topic: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private
 buffer
Thread-Index: Adcyd8YK4pp00ZyLQcGIGtNhxLg8mA==
Date: Fri, 16 Apr 2021 04:20:42 +0000
Message-ID: <MN2PR12MB45494ADEDB34EB9E565D0CC9974C9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-16T04:20:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8655b2aa-9650-4dfd-a884-bd1b3ec4e5e6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.218.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab1d58c-ffd7-414e-05fd-08d9008f0023
x-ms-traffictypediagnostic: MN2PR12MB3885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3885653F87ED9613EFDC036E974C9@MN2PR12MB3885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0fy/vu7tApynDMXVqihrSacnA9WG6XoJP4jEY9DLB/+wHytCDSatrXf9OofrXWXl/ILFQ/xPSet55Osg6oFWaeCbDQyNB9vy6hRj9QHjsCO80Ot8givXSujNIGktZxp1sAQepcGwD7IzEEkeMmlw/PXjPcp6NgdtHLm1oETLM7rd4vuXypRCFsMuNCLP/WmAlCpgVC7p98PN+bIc+ysBhUVjlI19budbcW9XB0VbkjQSW8DGZZm2gQSbWv0P5W61UhlHFSHemaOOnEZdLHcgQ4BSqSOwvPr6rgXCTzAE2cG0CgK/TApsQ8OIEbzmbM5TqPNGisameE5Pwj3bOmNded7h3Cjq3Je83WJEhPjIvuKIPypobuOxVX9yo7ZdChbRAkF+QTLuj5+snmlVtENsuimSihqBonJfs9OSQq3nUTGz6MBDZ+tT3WHZpgmPsvwkC18GJuAlWE1X944e+Z1vbpeD7XtTS9W1MRWdCBjM0qGtdDA2HlAJwqJTMeVf00iHZbpXjhjp/jSlbY1f26SSNVnd31sF+vXs/7r8fzvk6Y5TdOombTWZ9zsMVlbn2n4GgQl2/cWRhn2T4kNBZd+tKPdAKlFp/pAnENDriHJan0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(71200400001)(316002)(478600001)(52536014)(2906002)(38100700002)(55016002)(8936002)(6916009)(186003)(26005)(8676002)(55236004)(6506007)(54906003)(4326008)(7696005)(122000001)(86362001)(66476007)(64756008)(66556008)(66946007)(66446008)(66574015)(5660300002)(83380400001)(33656002)(9686003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?afsWgkbmp5FnqaHFpoiZPCK7LlHn3N4j1T7wxP0oSIqob/Fhbo/75Jitjn?=
 =?iso-8859-1?Q?m3ZWjfqqV2lck4hhXvqrpzF3k2xWe3LpnKC3lwBLfLueV5ZFaCF90bze5w?=
 =?iso-8859-1?Q?6Rg4p12L5wTeutb9rYQ+qVtwR+uwMtY8ZwcBcxxImokhCpUisUrNd9oRG1?=
 =?iso-8859-1?Q?DW7nyP8Wy8XSpcl4JWFUoy7AghEO1i8588qftH+3Gtwz6RxDP9vBJVxK5a?=
 =?iso-8859-1?Q?0LAB5Cet+0oazCb8zxKXXAvx9/NM6OdtXXgCHAaUnMilBzBKBUBwM0N+uK?=
 =?iso-8859-1?Q?dB+BOUa0LXgGd05C1cZzMKRpJXp9D5ifb5t1hT11MO+Xhzd6c6bf4JVXbt?=
 =?iso-8859-1?Q?XcWyp2IYpkclp4iYGQABDqXPln+YeV5gouloeoFjIZnev16tOwqTaTHCz0?=
 =?iso-8859-1?Q?mbs0h63E9AeM5AaPw6tahR7SMTrwHYwNCjLg8K5cwlYdVq1V6CB7iCb/IH?=
 =?iso-8859-1?Q?G7qXam5L8nNhynyn2BDSkE+9wGdKCkyZdDyk905WkZEA4Z3t/QejIvnNZS?=
 =?iso-8859-1?Q?HSiRYauMK9FbbWNxd7fOnkiqIk7B2hsxSlAmXuhf0gX3FimUbxFvqo1is0?=
 =?iso-8859-1?Q?XfjbKOB6D0QITCx8WZhGUvi7IfE2QvxSC3tP+eRDD//SzHn1uLCecLdVue?=
 =?iso-8859-1?Q?mzaIjYcbd4ctBMoicatlXpnTokAG9tDoCPiIiX18FIWDnYFSibKR2447xq?=
 =?iso-8859-1?Q?gFFE+xg3zuYt5pTUNX1d+uvF7TY0BcsleBXPACxhNmXU2HPNig6edfac0u?=
 =?iso-8859-1?Q?SjzD+Es2B/P+hVdjqEv2GY/YcKO2v6GeOTdewJ+/GyucHfGVLIjjKUJr9x?=
 =?iso-8859-1?Q?xlPaJRQJ9TzKdBcdGnRY1xLIMebthRgp1uaesfOtv0PZKHyWR4SH1Y6Pbq?=
 =?iso-8859-1?Q?IakoxKekdQbArySYhEouieBMxvRMtm3u/TRww8pdHGevgN6YwQeuNwWWKf?=
 =?iso-8859-1?Q?yo3SmAScyZa/TB4mMDN/JLy6QXbjx/q9A3DDe6ldWtOIIpkrETV8F6Qpo2?=
 =?iso-8859-1?Q?ymayflYwGd/ZSItXnDAgZvraZf2n/YoL0Uxp/8yJ4lTZmcKjkdjjZ0DemE?=
 =?iso-8859-1?Q?SXnsUrHrfFBZAk81I08jsXK3FEnjQVy5Yj8BHND+CfwGIxFCrTv7gSTMg9?=
 =?iso-8859-1?Q?Jjv88ioBTDxMYf0n0wHQ9H7NFzopAPa7LzECKOYmrlLAsYaQmM0VMlg3wn?=
 =?iso-8859-1?Q?qE1nTnu/iwfOMaYj5b6lfG7XyW41l8UigPU/sUjAfOOoBwJukFkOaFayCk?=
 =?iso-8859-1?Q?gye2wK7o4RSL+qkcF9u2XndLKlLrrpa2QJvk8/7QEDD6tRjOzEIgSytpY1?=
 =?iso-8859-1?Q?4/DVFmftG554rtExR3UsfM4dDdD5S7W7VNAX8WBexWWrNN/fV9sOYulBWK?=
 =?iso-8859-1?Q?K7sULMjjhM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab1d58c-ffd7-414e-05fd-08d9008f0023
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 04:20:43.0203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OFw8zi7McthNfiQ7188Q7rirQO4hk/ZgY5QbxLXEwUWeh1ajF+x7WgGsa4G9tpo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Add debugfs interface to read region allocated for FW private buffer

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 8128603ef495..a229baa88483 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3526,6 +3526,45 @@ static int amdgpu_debugfs_pm_info_show(struct seq_fi=
le *m, void *unused)
 =

 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_pm_info);
 =

+/*
+ * amdgpu_pm_priv_buffer_read - Read memory region allocated to FW
+ *
+ * Reads debug memory region allocated to PMFW
+ */
+static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev =3D file_inode(f)->i_private;
+	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+	void *pp_handle =3D adev->powerplay.pp_handle;
+	size_t smu_prv_buf_size;
+	void *smu_prv_buf;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	if (pp_funcs && pp_funcs->get_smu_prv_buf_details)
+		pp_funcs->get_smu_prv_buf_details(pp_handle, &smu_prv_buf,
+						  &smu_prv_buf_size);
+	else
+		return -ENOSYS;
+
+	if (!smu_prv_buf || !smu_prv_buf_size)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf, size, pos, smu_prv_buf,
+				       smu_prv_buf_size);
+}
+
+static const struct file_operations amdgpu_debugfs_pm_prv_buffer_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D simple_open,
+	.read =3D amdgpu_pm_prv_buffer_read,
+	.llseek =3D default_llseek,
+};
+
 #endif
 =

 void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
@@ -3537,5 +3576,10 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *ad=
ev)
 	debugfs_create_file("amdgpu_pm_info", 0444, root, adev,
 			    &amdgpu_debugfs_pm_info_fops);
 =

+	if (adev->pm.smu_prv_buffer_size > 0)
+		debugfs_create_file_size("amdgpu_pm_prv_buffer", 0444, root,
+					 adev,
+					 &amdgpu_debugfs_pm_prv_buffer_fops,
+					 adev->pm.smu_prv_buffer_size);
 #endif
 }
-- =

2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
