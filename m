Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745EAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B199910EB8E;
	Mon, 13 Dec 2021 03:35:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F50A10EB8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8CW/RVtWQdX8Z1OEiNq7uJBVSn+Xqc2WwvpDZHy7rGuk9t/ZDwAPQZYADT6JRinZb+cbdnr9eMF+8FC+/NUYJ9Q+xLe7Bbg+m2Erc/bFtG1G5UbpPn0V/DfbXVYiA/qxZbMSCcgZZ+3Pb6TWbqZ6mIaXPdWKx5J/Xvt/P5zhrwWffKCt0V4M63s1wxF5bd4p1o1HEUuAOhtr+6X38o2xA7GFdx5HGoaxogHrqChCqThFC4jTYy8fm3PIdd2pW/9hgDRHve0I8D7Tlyz4h849XzGAX1gP6O1antAltnCBd94Kghl2vxnbx+0mu6gmPvfRzHe78Lx3gQOL3ekMbFgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+ezLRI1o4frWK5/VYG4STiHxx1/K7IufBjFAX27fFk=;
 b=H67hPJNHPL9EBOQ/2z/PgjOREycM8QSWkBz1682fBYVGPNGKe01Qkpr1mK8FCSIB9OdRE2G1FaamnSYsupKMixNhPNxgttmHMJRbtOjssxmBJc8z8KaO6P7c6jUQIA/WyehkSau0j59d/Kn7Jdgra1FUGHYR/MuhNRUukGQR+KSeihSyaAS5a8yv857WwTn3y0dGEg9YJuVvfMkkSmaghONNd9LU0T0Z3EwVIiSVj0yGdPZJyJzYb+awlzgtn6iqHJz7biB9Ltu/CkPF1c7gSXS2ZEMtQfqw9L60MleCmJnziwco6oyLTYso+1HNc1xEWaipSodTivYjy9u5Le/Ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+ezLRI1o4frWK5/VYG4STiHxx1/K7IufBjFAX27fFk=;
 b=1YULERdBJRojIeuoZDzkoAsow+ouaBfE4BlVLhJHhXazCCYbn87rICz+SZjzVKSg21hVGXHhsgiFedM1KRLjZbg83MnW0qm8KF2Nrw8H6svoR5ejkYFWYh/PrrQH/pSyyjZsOPwIMlJW/2rFw32AmWtShTz2l9XjWvs1PvEI94g=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2827.namprd12.prod.outlook.com (2603:10b6:5:7f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.25; Mon, 13 Dec 2021 03:35:49 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 03:35:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Topic: [PATCH] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Index: AQHX7dJMfWpd/pqOmk6f+e8N5pPPF6wvyHQA
Date: Mon, 13 Dec 2021 03:35:49 +0000
Message-ID: <DM5PR12MB2469857D51B76ABBADA5BF27F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211210142848.7784-1-mario.limonciello@amd.com>
In-Reply-To: <20211210142848.7784-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T03:32:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=02185718-ded7-4174-94c8-fa327ce0bbd0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-13T03:35:46Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 32749378-2626-42b6-ab51-da3042df2d63
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40bda9b4-08f6-49bc-6066-08d9bde9a83a
x-ms-traffictypediagnostic: DM6PR12MB2827:EE_
x-microsoft-antispam-prvs: <DM6PR12MB282736E298D660A08F80D7A2F1749@DM6PR12MB2827.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCGwljfU9ijFv1s6VYR2l9zf75Mfoy7HyYqTVorTFoXn1qjOgVkMbVcbzgBpMtdDie85Z676DrpqSoDYMkDV42lHBifMVdIjbr6oo6xt6C7hqIwtQVxtO6eaDnozkQVz2kq9tYSYbB8Qomi/MbMKLhbwyTHKyLRSUk6brn06rDRgqu9U9hHYys/+3MHaA3nKvIoGIpwaPjvrOFNSPpesbiK33WoTMva1Nq8NF2kWlaewlgE2Dzi+1a12qOdBrf1QoMzJ9mcd8KuGBUsk6BGxZbZOTHMGpz9ZljITSXYa6scqPi/lx2dsO+QiyNyOcKRKbqFeXn+wazJf0CvPs0oMAgA44foI7M4cK/toGlZX6goL2nNiZ5gTZ4EEOLw1p6mtm4kyFEoRG4wA6fvPMBDsHhIAOmbqLCZahSq9lyASfyvES1nKsTMfapHAHNS3rMpZDdwp0wsA+axUQqwEaAhBX9MQo5JBKJ+Nrpxcfxff9+a4lgh7G3gqk4YyAw8WWpVVbr1ciyeEyf8nJnU1EcTmMvfUTe2VuMu1thP77tP35x24Kv8QdiHP44RFkMh/RFP6Admsn1iaTi4TPZCeIu4ZWnRCJQnlWZTWcqLeTbNHUsoOk/WCzzuUHrJVGt9lutHP2tuwordrRbryUdYSR6Q598BCLFrY5LkWufrsmeQXrcEsYJ0rH7L7hA0dzXAJrXqoBxWV6i1fNggCJYcZ7ffRlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(122000001)(8936002)(38100700002)(66446008)(316002)(71200400001)(66476007)(66556008)(5660300002)(66946007)(76116006)(52536014)(64756008)(53546011)(508600001)(4326008)(38070700005)(86362001)(55016003)(9686003)(6506007)(26005)(83380400001)(7696005)(110136005)(2906002)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qxhLRluKHYHGB38mtYmSLTx0dNkPRipOp8VESMfj2xdDN+IOfLyzxbMksSNb?=
 =?us-ascii?Q?8qW1ZR6fn3dXEnrAIv6+0yWV/atjU9BsFnCUF/V3MBQ1aNF0SU75MTFpoasj?=
 =?us-ascii?Q?Ifld+AtdIX3camKfxpOXe2ok6wVq6ZCX3mMHIsfHn0MrP40k8jH0KZo9qg+i?=
 =?us-ascii?Q?ToDP3Qr5E1KJcrKoLHY+LnPca05qAKRr4jPI1Cn3DqVX04GTH4Epfph7V42J?=
 =?us-ascii?Q?DQzU8xwHzV9FEUtbvQ9I2BKxGwx1y6UMudlhNgF+rxU+05xguM64WPlo7MpA?=
 =?us-ascii?Q?IWZmIx5kUXHgC5bVruHnh/0T9sE/3Dn1825b9MgK5b7gViGfzE3s1qgmP6EI?=
 =?us-ascii?Q?5UGyc8Vg/s5vqMaufl7G/OHaTxWUghrnctyRRqlzFC07vZway62JeKGaqrtI?=
 =?us-ascii?Q?68HMULy2rfooEkTmqNN3IhmARgXKaPgjZG4nOCnELzqRCb7mCaIrb6TOCCv4?=
 =?us-ascii?Q?hZvaKrRdmn9c4uxYqnGQJ1igFlAGWlIrcvbtEar53yvZnb/KqsieRLef+0Kt?=
 =?us-ascii?Q?btB+cU/LizYXw8WW7urwmhT++Ii5X0POsQMlp4bFxAKKfdfp53iH+iDd+tkq?=
 =?us-ascii?Q?y5y7piLi388rESHfUfg7HyK7jyPppZskwLjD4epwG6suqDr6DYcIFbU7SVxm?=
 =?us-ascii?Q?kjr5cLmywpGhUQqwrAI9sOcS2UUoaJ6Tx10972IIcxHKdYQjoWRJAbleH2yA?=
 =?us-ascii?Q?DBLnULivGAvARmUhZOVSu7VDo6g/StlEhDKhk4CX5KvE0QuE1LPEnnJ1l2YC?=
 =?us-ascii?Q?RSIoqAx7M2m/WoHeNJC47DGJ5zGPrOI+JJqcWBJNmFAO5nTxRgtdP9zCSW7L?=
 =?us-ascii?Q?p3odzwdQG877t/MozCpZfwMVtl2377brKF4wwxRtDU9g8V4wpsTLFPaXjM95?=
 =?us-ascii?Q?Yw4qRwkXm/JGF6L0zCK2mqHdb5pbjS9e+BTpvGLa/cg+aP+i87KhhDLXu7dL?=
 =?us-ascii?Q?pg10G24tnpJ1AHc3gvDWuHQShuXlj4Uf7jDgSVAvRubeJ0sh0+s+58rqTHzN?=
 =?us-ascii?Q?r2jeOCkKRYXxqCvNWBsSh3PuLMw/sGueYReBli2MJIzFoCHEiY/oNRMr/vZ1?=
 =?us-ascii?Q?mqeis6pkFBxfFeEK/mN84XUW+T5ShKGS1ERCLZ0UGI7N4KcC0c+nMAwV+jfU?=
 =?us-ascii?Q?fVmIvbzph97FItDdGtUEGC4HAts6KW+dEbcdhTA2CVAqZ73IyiSHK37tuz5U?=
 =?us-ascii?Q?dTZ92i6pyWX9EaUZGCN6nXxMKwRaeNBXDgx/wi5/AJ5mPS1yUEWIOmFAFRqG?=
 =?us-ascii?Q?/tzcFZeuxtwaAD6W4NwGVQhtz8v0hviiaoWDEEqBaO04gRt7FyhNzjM21S6j?=
 =?us-ascii?Q?gC005OO5AZcwEgNklkDOxC6mj5F0Wzc7IyDfoP+Qn8RSi8hMLEqEUWdjf5Au?=
 =?us-ascii?Q?Yv46cbXioLnV6AwcrlxaG8WnOEfyqug7+ln1QqKQ0GChiYt9IRg6rsoLOJL+?=
 =?us-ascii?Q?VgrEBRvN6QILdEyQnlwOAk+5dMd+QtLH4FJr1ph+KgoXAVB12EUumTUXhXhM?=
 =?us-ascii?Q?IIVGgMbzJFKFEFVN9eUGuAUX8jOIxfBbo1pz5zXO4bTfjfpmkzmSXzq0CbNX?=
 =?us-ascii?Q?+/Lhx5S+p1y4ycIDucYYbhT2Zn2HFvRpOsRRpeQekcNWH6YgFYTGOtdh2MZw?=
 =?us-ascii?Q?n2lqcYZ8IzBo70Z5B7yY5kA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bda9b4-08f6-49bc-6066-08d9bde9a83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 03:35:49.5501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CM+r4XA5M/ot+FxhjZgOBKitl+FllYw9KgDGJ7sGwSzf+e98wtsoc+5O7MnPabPPEqKCqupybM3sV4cuEoHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2827
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

In SMU11/SMU12, it will cache pm.fw_version unconditionally only in APU cas=
e. So we should apply the same code in smu_v13_0_check_fw_version?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Friday, December 10, 2021 10:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd/pm: fix reading SMU FW version from amdgpu_firmwar=
e_info on YC

This value does not get cached into adev->pm.fw_version during startup for =
smu13 like it does for other SMU like smu10.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..85dbd6a7efa9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -226,6 +226,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
=20
 	dev_info(smu->adev->dev, "smu fw reported version =3D 0x%08x (%d.%d.%d)\n=
",
 			 smu_version, smu_major, smu_minor, smu_debug);
+	if (!smu->adev->pm.fw_version)
+		smu->adev->pm.fw_version =3D smu_version;
=20
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
--
2.25.1
