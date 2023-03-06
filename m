Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B459BC678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 08:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AC910E0F4;
	Mon,  6 Mar 2023 08:09:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4710910E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 08:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7eFRxVpqtrVrMo/sIKVPNCIYZhmw2iVnY5iFLQbg81zrmg2cxZfqjNXlWOYdiuG2LI0jjgsgUJjwL6rELoJzMKwHz3Bo6VmTfORQaUHbCyWkrFIU5WRwbYae9XiCSLl1IKruMK9dr/IkoA5oa93axrSnRp7HLPX9oW6jOiOgEgLFMpprPHzyF96BnGNpdm8VwXRdjKz34K0q40yGZmyVkrvQSXizOR21K/Ngooz/YRoFQ6iOoZ1v8ebsn/fGpTUGNSGyg5SRxb7+T/t92u5Lw3Vy8jS9N3IP03pWsZe6VqutBtrDjYPlyt+UkfVPSja69XwV1V6FpPjDo+ctFd7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+JIX5FE0kDaeBbp+qjSztQi/guZ1YVWVSb03SZQEr0=;
 b=DDUqp+v5sBPmatHBgsORynlw+rM/vHD+e+Q99jETr8FUIxbJ4nken4JviStZ6RESuKKWZR8d2AKsV9WvVDoJbSqmQdjYGak+LZnR5XroSDklVk+RzbS2+Ox5JCVSN7S4Fvp1emJf8jVrIa4NdqnpweCY2azmALmVqw5BU365hdOjXwmWkh8QTf46of8oTqwq6/+DcVf2zpCn1rnM0FmW7LeBY3YchUU946CxBohNlfViukOidSSWursp31yGpd5MxtYaW6ju/6Iw4CmFCy1RJC7KX9FBgWrL9bWze6BfKtlvJvtMJg4ZM1KUuEeUFQA8DQQBx514kGENQ/ltC1tVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+JIX5FE0kDaeBbp+qjSztQi/guZ1YVWVSb03SZQEr0=;
 b=2PO7VNJNdTh1vTCCtVh0+0ybu2SNnhhqRV97kS5lW3q/tt0QxQ8C8zgPdocXMKdBQHma+2dwy+zipO4os8yOaVJ8P6yFfMk5r5X8D8ZHOC7TZFoBzi12XN2+YhiODJvcWbE03xqTdSv8uR2bvnDK2er37rTD6D2hsfLYfsekVZw=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 08:09:41 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::4083:34d5:f1ee:396a]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::4083:34d5:f1ee:396a%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 08:09:41 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Move to common helper to query soc rev_id
Thread-Topic: [PATCH 2/2] drm/amdgpu: Move to common helper to query soc rev_id
Thread-Index: AQHZUAJP54cx44vhdkGVdzMEgv+GlK7tZfFA
Date: Mon, 6 Mar 2023 08:09:40 +0000
Message-ID: <DM4PR12MB518188E87FD5972A62D2FC50EFB69@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230306080401.20501-1-Hawking.Zhang@amd.com>
 <20230306080401.20501-2-Hawking.Zhang@amd.com>
In-Reply-To: <20230306080401.20501-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|BL1PR12MB5239:EE_
x-ms-office365-filtering-correlation-id: b06a99eb-a750-436d-4d2d-08db1e1a231a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 653ZSAy9FWDW0f8ebsf8oQuQ+PuIzi4CwOD0MXK2zkNz1K7hoD8WCrze2cR2WtZ/kS7H3gZDrTyATdyPS/vbPOCTcGApLS6AfIgyimkz2AjPAR+I6mjeqlZeLZPeaRXWfAL0Oh1TUxVWrKK9kBCcY7Trj2X7/Lzb+toSDFBo3AF9MBQK9Yk14J+u4lRuKxC81rxAB9jmUWxusZ664hme/i5owFNrShlQLwXl5NDSQ8m3V4FoRCKqo5cJNbxTDxNkZod3C3gdVuwjoLNTD5AdR8aAmWJ3ceoJn0nMGNbnPx535k7qxIQ8FkH6HsAvbyaRvUQUO8Cy8UU9rKUQ6OceqRllFjroroIl2SCMTzWI8/r9Z81Vur3aIJsN8SHJ2EBnIASyXeQyuTh+NykHTHloVCQjQvESxdRdhs8HlvEB6TxUn/Q0KVPOYpZyXIYrzHLaHnV40ukCJjuSF8WnPGoZ3d35QXPABfUmk2btjR5YM+iLxu5k3VBKeOGc9tp9Mb+4horZSF0UImzo3WPPKR7Rv8SzOgIPBtTHmYt9eVzqBgYXbvWJM0gDSK7olgZdBZEHtqr1iFYMaTcS0NUUhO5w9A4HopEnFJOsq3Ipdf9aN9HmY/Zi6TGQ1Q3Ybg52/ZG/5xt4qDhem770KIH88ZWMELwk5tisAUZm3uJ88Hd5cBC5OyQo/SGApq9aNbyAAPrLL+OtSSOZHOXpldDCeheBlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199018)(26005)(6506007)(53546011)(38070700005)(83380400001)(33656002)(86362001)(55016003)(122000001)(38100700002)(9686003)(186003)(66556008)(66946007)(76116006)(66476007)(66446008)(41300700001)(4326008)(8676002)(64756008)(2906002)(52536014)(8936002)(5660300002)(478600001)(7696005)(71200400001)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CVNTv2xqndeKdirtYto+B5tRHx9Oni6AtNq1wrXY7WT8wJX8cBZNbqclF1kw?=
 =?us-ascii?Q?awRPfP5bYTebSnOUeGo4RD0vfH27GObHU1R55LBLl70gmYqlk+wFqa0jOj0N?=
 =?us-ascii?Q?pbCOPW1N9cby7rGPaeRqZ+F6gJll8JGllJkF5liaai8hoQ6cJbuyLj2Q/s39?=
 =?us-ascii?Q?oL56Q6c5CcUsyMZiHBm3hwJ8k9fpyAiU/bYs1w3SQKR3J0JLLjSGBqTocdHp?=
 =?us-ascii?Q?5q0M9HIVucscq6klTyZS1kFRs5wvEmgSObGPHvxtwF8iCXfz+CyR1PW4nHYC?=
 =?us-ascii?Q?oLlZHOXwySUtcClR0EI48Ggd1npSvgPW8uyMBm59TtOPOwHbag+hZb0WeILy?=
 =?us-ascii?Q?tUwHAIE6yTc6JscIiaWwuE8i0XEb76gv9Xbgv0Mj/VRC9/9O7JXnDBoLeVnm?=
 =?us-ascii?Q?HJtsuwQTLC24LKqhnrubnfTc9RJ8kjcj7q3yweTQO5Aq7BCH9z2qat3LMpVL?=
 =?us-ascii?Q?cyxhvhUTReXqP5YQrn2HhhXjFv2CS6S0mKGdQyq4Z6xBZ4+NP1t/9/pkNiig?=
 =?us-ascii?Q?nejQhg7cZGBraGg+s0yRM530HKb7McJpm10y+nfsZ28G5dQgxameuae9hGPb?=
 =?us-ascii?Q?Tu+sgagfoqPpvgAlrjLxvnSRvm2H+O2wM4yLN0AIbUd57QoA4QXIiNuT/YfM?=
 =?us-ascii?Q?rEJF8urnykszoTu0rmdOdF6gCbw0+k+em0/wHpac+bbRNC5Qe72cdIygpZ0u?=
 =?us-ascii?Q?61fMqC7cQymdCr5ZGLX2n/yIUndrDUao3GZFhi7eZxQT/n3CMixyzaRfK+eL?=
 =?us-ascii?Q?iIUy/1HKNnZyYB8wV5NuccWVfA5f+smAY0TJCafKj4fBaRdF5QIuOHFAkm80?=
 =?us-ascii?Q?FAf2AI4UyixYKNq3n5qdlZu2fkwxWUlXkPO6Pt8gCL5H43+DwLHdkfdIRqEj?=
 =?us-ascii?Q?WrU9K0WuFM4MzRHKFM8D+wGPLp7jI30/EjM5h/RvnDZ0xlENhrqJkPkC0zFO?=
 =?us-ascii?Q?zqKRRcfG9z8SdJJ1mNtN3+4JSNCoNlXoooYtDdC5SenTJifgOctgX/2SqJma?=
 =?us-ascii?Q?S6SNCzWoCEBrY/rj4y1CjvHkY8bs80RkQPyZlrLQGJMKS3fy3oENYygw6fQ8?=
 =?us-ascii?Q?mlGcsGJtFMSW3cX4tgVTuQ5lPGoc5JgI0W9G2KPWtUhsp7NyEmKZpeNZLp73?=
 =?us-ascii?Q?P2Dkaqu2JDGc4HLRHSqKcHnLuDGklE73CGxK7sZwFpn6yoZwEPt8/8OEeyHh?=
 =?us-ascii?Q?FQl3KIAAg1NXha9ZarmALgkdpHJmBeimOrv+NmGWvqixXqeow8ltfq2P+iXe?=
 =?us-ascii?Q?A3QbiAPTmxfsYS6T8qzd0SQDPtsKBP2I4jnAUIb94LwTm/GZ7PVdb52kakF+?=
 =?us-ascii?Q?wGBFTMVPLv34zgx0px2HLHhBVpT11xvgmp6Il+ggrcAlgTcpFsQdrtXDOEO4?=
 =?us-ascii?Q?sjgCPekWMzj3E5ZFDdyxJZVbvE9fZ59mUlucI+Ir+4lgC4mUJqm5ImMPxyJ4?=
 =?us-ascii?Q?4hPLZxwXuFfPhGf/23S6UKVtc1XeAcO1X+02S1O3/Vr0iLgoZW92DuvrLiCt?=
 =?us-ascii?Q?B2AEjZSKmQOg7lT/QF6FRX4LWmwtNXveqDkS419ALffwUAXmmjnMQLRmuJD/?=
 =?us-ascii?Q?ZsY+nCE5N+m4Ce04l6I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06a99eb-a750-436d-4d2d-08db1e1a231a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 08:09:40.9341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3oSSQJfgKiHurClPJzsvMyGdVb35UmM05h5rLtPw3F7FsD35HG5rwODFxRndqNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Monday, March 6, 2023 4:04 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Move to common helper to query soc rev_id

Replace soc15, nv, soc21 get_rev_id callback with common helper so we don't=
 need to duplicate code when introduce new asics.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            |  7 +------
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  7 +------
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  7 +------
 5 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9387731afb8b..527795f921a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1149,7 +1149,7 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device=
 *adev,
 				 u32 reg_addr, u32 reg_data);
 void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 				   u32 reg_addr, u64 reg_data);
-
+u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);  boo=
l amdgpu_device_has_dc_support(struct amdgpu_device *adev);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b1b815dc69b3..13fa8a2709c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -807,6 +807,18 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devic=
e *adev,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);  }
=20
+/**
+ * amdgpu_device_get_rev_id - query device rev_id
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Return device rev_id
+ */
+u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev) {
+	return adev->nbio.funcs->get_rev_id(adev);
+}
+
 /**
  * amdgpu_invalid_rreg - dummy reg read function
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 60c10132ed32..492a8b148227 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -566,11 +566,6 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops =3D &xgpu_nv_virt_ops;
 }
=20
-static uint32_t nv_get_rev_id(struct amdgpu_device *adev) -{
-	return adev->nbio.funcs->get_rev_id(adev);
-}
-
 static bool nv_need_full_reset(struct amdgpu_device *adev)  {
 	return true;
@@ -712,7 +707,7 @@ static int nv_common_early_init(void *handle)
=20
 	adev->asic_funcs =3D &nv_asic_funcs;
=20
-	adev->rev_id =3D nv_get_rev_id(adev);
+	adev->rev_id =3D amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id =3D 0xff;
 	/* TODO: split the GC and PG flags based on the relevant IP version for w=
hich
 	 * they are relevant.
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 6392d10e6eaf..2c37b49f5c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -653,11 +653,6 @@ const struct amdgpu_ip_block_version vega10_common_ip_=
block =3D
 	.funcs =3D &soc15_common_ip_funcs,
 };
=20
-static uint32_t soc15_get_rev_id(struct amdgpu_device *adev) -{
-	return adev->nbio.funcs->get_rev_id(adev);
-}
-
 static void soc15_reg_base_init(struct amdgpu_device *adev)  {
 	/* Set IP register base before any HW register access */ @@ -907,7 +902,7=
 @@ static int soc15_common_early_init(void *handle)
 	adev->se_cac_rreg =3D &soc15_se_cac_rreg;
 	adev->se_cac_wreg =3D &soc15_se_cac_wreg;
=20
-	adev->rev_id =3D soc15_get_rev_id(adev);
+	adev->rev_id =3D amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id =3D 0xFF;
 	/* TODO: split the GC and PG flags based on the relevant IP version for w=
hich
 	 * they are relevant.
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 9d91e20a22bb..21e271877c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -411,11 +411,6 @@ const struct amdgpu_ip_block_version soc21_common_ip_b=
lock =3D
 	.funcs =3D &soc21_common_ip_funcs,
 };
=20
-static uint32_t soc21_get_rev_id(struct amdgpu_device *adev) -{
-	return adev->nbio.funcs->get_rev_id(adev);
-}
-
 static bool soc21_need_full_reset(struct amdgpu_device *adev)  {
 	switch (adev->ip_versions[GC_HWIP][0]) { @@ -557,7 +552,7 @@ static int s=
oc21_common_early_init(void *handle)
=20
 	adev->asic_funcs =3D &soc21_asic_funcs;
=20
-	adev->rev_id =3D soc21_get_rev_id(adev);
+	adev->rev_id =3D amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id =3D 0xff;
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
--
2.17.1

