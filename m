Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06D1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 06:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9C96127A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 06:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9C96127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DD46E86F;
	Mon,  3 May 2021 06:12:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8416E86F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 06:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgFdHAeJdvClpRr5pQvOJdkyZyCcNalPGAcC3PFr8QWtM7ikQIFu+f27MVJJjloKZuwytV9YrB1+nkuGNeMgn17vgWlv/F4AChMGvgyPgdQTJAFNIjstp/CovCYGZjHnFl/6wc50t9noUnRqH4Y4xYhHcxGcMg8LRlLL5vUYqK5dFSPCaZj5jTUqp+zAMRR4jUwFImLeIc82BDSW3YJ95vRpUBl9WrUaoKOq2ExUuH8jqOfbL6QXQ4MJNwpuAwUjTiIJ5L0/mQzIlXYs5OA/0FsbI6AMH9SEG46HAVXIyq6aM+fet/c/ANOP/Ykr82nkcztxJr+3QCv54QgIMUAmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae24L8oHnDwq2AnGTX2oPtis8sAMfTAldfu63j6t4QI=;
 b=jYSURRnDymMpATgNGUtTlTrmWpw9s+9TGHeSBcF0W/WkuOW1mrIpF95UpeHSE4QdnYpkDtnJKij5BRBXwyjMrvL6NdeN11iBgG2CjhbOHnSlWvixaRZenfVWn8b8MQypSMemmismHCfAHWuRoNqmerl9GOhZqUezsoOKnh2Qids+NPjwLeD44U7QdDSgbsjTqPpFFheUIBgnMEmBLo2ysYLVVFr8s2VHmO5d3bGRSNRb4RF9CStP7d+Z0PTDXLi0bs93WVuph5g/fi4j4fZFbycV8Tl6zqhmI99tbNCPdRElwIEdy/En7GQJqXPcWk3uYWVk5WqkzCym0+Zx5BEtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae24L8oHnDwq2AnGTX2oPtis8sAMfTAldfu63j6t4QI=;
 b=FAQF+ZXXx+jfSpet16oDsF+MkkK8swk6slLkJXxndL/qtNesPq8YVJS4+/xs+b0QLJEjq2Fj2sNE1lZVJ6rRlbmXHS8xc62xhXyVYAC7oWCvUSwiFu7nsbNtYO8FcjfX4nwS/2E7bI8BzRuLUSUgFhcUVCzam6wa1in0udjp1DU=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 06:12:28 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 06:12:27 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private buffer
Thread-Topic: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private
 buffer
Thread-Index: Adcyd8YK4pp00ZyLQcGIGtNhxLg8mANa3k8Q
Date: Mon, 3 May 2021 06:12:27 +0000
Message-ID: <MN2PR12MB454958A234C834277F0BF5FC975B9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <MN2PR12MB45494ADEDB34EB9E565D0CC9974C9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45494ADEDB34EB9E565D0CC9974C9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-03T06:12:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8655b2aa-9650-4dfd-a884-bd1b3ec4e5e6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2350:5e70:f4e8:7528:4b15:23b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4163d20-b3db-4c2f-c908-08d90dfa6d78
x-ms-traffictypediagnostic: MN2PR12MB4408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4408CE704D8A3D08E5520B3D975B9@MN2PR12MB4408.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tl3TjLSbfkOUXn2W3p0CF+f9YbG/7AshBISeQ6DtteUDSvvqLPXvp68kLaolWavE/+2dHpyTYkTpXzgR8sZfHRm03LpkEuol/pqa/5SBNT/c7DB0AlPHhMshnMbGP7UtCCzHMarEN8/Hz7/ZU1qdcwnEW381+u+i4XlKLerrmcKvRbwNzgEjkGYOHhnq/5iP4/ZZaWi8QigQj3zMpVvdQw0ivsoopZQNBZZaEBWRc99JgZ6CuxvLaZCDo04KPvaKzcI9Ym0a3ABd+/uuIYHKiKIXdUddQDo7K8wCwrUjDHOjHsudNApKsJ+RYj6Q39deKK/BORMaOradZXxuWV4U7nVPDXX5wo83QwuyHi13/xl8RrmGn+Zz2esKcZpgNmCf5kFsyZnd52o9UK2H/qchNrsRziRZGBYMH8f4Twv/rcGJoznkNp8qxr6R8xe/2KrdtJUsY4x9pCI9g0ENbVuX7mDH/7/75NiWtVmKW6EWK64rvaSV4YojLtzROb/7zFgE2UEwRGiBy+c2B5nfXmLDLp0jFSbA88Yp8aQjFJ0N5dZ1ocv6Kh7ZOQdeiaWd0VeLCAD2XgpvvZ6mie8YDP7quzSO3Cnh+bQUy0Fn0PGbddDBLUGbj0ocx7EU7U0nZYDCWttcIw3uBl2bNB5zgp5wxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(966005)(38100700002)(64756008)(71200400001)(4326008)(66476007)(76116006)(66446008)(478600001)(52536014)(8676002)(53546011)(33656002)(45080400002)(66574015)(86362001)(66946007)(66556008)(2906002)(316002)(8936002)(9686003)(110136005)(83380400001)(122000001)(186003)(55016002)(5660300002)(7696005)(54906003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?2fxZFiTx8N3SOVeqAgD5Mp7aJxdQbygfpKwDY+NftO495k0A4cC8sn27j/?=
 =?iso-8859-1?Q?o0pm16By4O6GkyS7uZTWx8nlOrDB33U+q7GNAZNWUBPokC3gxBDn6UEV+y?=
 =?iso-8859-1?Q?IB7Q8GUWKNq68mDtC8xOhA+6WvdF/ZDIYKz6/QtXkAXJ9LhLHMPw2dSFWX?=
 =?iso-8859-1?Q?gYjiAEW6CwVBePc+RIHFNiDXSrnQxU+lnra7brFkDaLlisvE1rDNKM2JM3?=
 =?iso-8859-1?Q?jL3yWGo5dBQMWiJ9Gw9dQFn9s37906C2ikwkr0/BH3+uHNW1cDLmxFNXvS?=
 =?iso-8859-1?Q?vwsaBQqF1bLCdBZ1gfSCSD/HsMIMz7QL8oxAr/fE1+bb3omLiw5QkO3bfj?=
 =?iso-8859-1?Q?gNLVr1s6GJbUCIb60weTA0S1KDn3UEm0tzlT9fh1IqoG82F9o12VZtMilJ?=
 =?iso-8859-1?Q?quQDNKVE9DMtkFoCS2K6ZLZUk4CHos13jLPRqSkVoFHTdQ33YannWEbotx?=
 =?iso-8859-1?Q?cr/iJLmbEDs6G0OGC7alK5esxdtcLtNRjb5C1Hrlx86pnWXbdGL9MFrb1n?=
 =?iso-8859-1?Q?8ZjUnqFfWMAQTWPFufWVxFrqV1r6i7bSD4aoIJss/KU19Lm8ApF06pSnm6?=
 =?iso-8859-1?Q?V00AUSfQMjluaBucrZjQyW8LJ9+/5OmkvGuUsd2+oy/9JGB8kU9jdII1pj?=
 =?iso-8859-1?Q?jrMS7M1uBIfgfR7Sdp9jTZrfo60OaQA40XTUlz666qS9TZowkoL9Sff0s+?=
 =?iso-8859-1?Q?GKJhV2X4OcVjSDEAPDaiFwbIjXiCiPnaDH5xEI9bZZGxHesdZ2YZtAfE4X?=
 =?iso-8859-1?Q?xZZPRaW1cDm/ngN4VdTaiUYT2drMomi6nAYAn6DZeDg8cphaYGloDnIF4p?=
 =?iso-8859-1?Q?CnfGLNlKKA3CRgeWQNvX81RN5YEROeJ9kA9dDxMq5BnYfoAwAmt2Ra0HZ4?=
 =?iso-8859-1?Q?jANKsKGsGlCwzewIzJBm8fchUbgCOOidyXnc2VS58URuSlnXJu/o43dphd?=
 =?iso-8859-1?Q?1bgmo092txSRSjtn1aEz71KzKEwMQlQcyM2Twm2q8oTi36vlTQvzBvRGPx?=
 =?iso-8859-1?Q?WEwb0CjsfWqsTG/l0hfBhxM7tzyz35NTzLTIk4GFw+3l1RSelEA5v1flQd?=
 =?iso-8859-1?Q?xvLRbYLr/mfUAORFMCXMYKDDXciX6WX6PZAehFRsvSd0JWp8wK6vOFdVek?=
 =?iso-8859-1?Q?mkOHm+n4N0zDurkOLuhEgPkiEIHx0wXE1bRqJZPbdKGbwdSSVxCrLB2veM?=
 =?iso-8859-1?Q?dSfY4GIql0K+pCljTD0KOh7IaO/791dsJK37/zKpMogFWqF05BDF8Ncx25?=
 =?iso-8859-1?Q?fxRuS17xaWw8iWSVh0cg4Y3Lq2cIysoPYFGzy4zTOHAfWBrScrnsR/Gu/e?=
 =?iso-8859-1?Q?5YIvHuOKIPv2/b4bjkQGxSpGphHV4KsD24RM9bXo6BqfbFHcinp6WIXUtj?=
 =?iso-8859-1?Q?O9ZVAKNBAX/H/jERqx3pVat2mP8l/8TTY+bl727bLsoEYp5V0njNCyCibW?=
 =?iso-8859-1?Q?OQsmrphdv+apvOeP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4163d20-b3db-4c2f-c908-08d90dfa6d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 06:12:27.6873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uouMXpApCYQR/RFldPA+JOoo0ZQf6EoLa4+Rxxzzh6j80tgZfJfYPwZn+Kse4LOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

<Ping>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Friday, April 16, 2021 9:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevi=
n1.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawk=
ing <Hawking.Zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private buffer

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
+ * Reads debug memory region allocated to PMFW  */ static ssize_t =

+amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
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

 void amdgpu_debugfs_pm_init(struct amdgpu_device *adev) @@ -3537,5 +3576,1=
0 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
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
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7C7832088a2ca34c755be908d9008f0258%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637541436501320898%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DPxT=
2L7MXjlrTSk37nP1GGCcWTzSzRWbEtO5w%2BkRUbMs%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
