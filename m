Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B451C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 09:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D6810FA0B;
	Thu, 28 Apr 2022 09:11:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F06810FA12
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 09:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9efBVCWJApYzhmiNRU28pVgJiI7JCvKxTonWQoEFRHh34ILIScT+9dU6CgiwHVVKlbYC5vqh2R8VBtdR1t8qFaXxX1nitw+nfoyhi5r1Z70C4EZs3Tqe/qtg+wls+mr92RBLDYd8gbB2i0l7dx075uSfTTJppEUWFeh68fhlRNgPIQ3ipyAVhIQDTbndjLyF7QjAjCDgaAgvJStdf4cfiAVo0/lbg2NDva4TWqt/MuWtv5MO+M5EgNBI0W02AN6BIVmW4eAwdm5SAhbjNQIwhGihkn7mKcfaiOGaLVzWrpo+wljWl3VI6aymTCSFSW8y4ZfFGHmroVrurgUMMycVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ4t+DpCnaCEG9Eq3zEP26yzDdCWoRwgM+X0zAWKr8Y=;
 b=MhIud4WEPEckRxPXez9wLGvBcDHAmUSo6Rfh9BCObCz3hpiJuCwXTRTM8WTuOxN7y3jhSw0c/sZLrb2W+Oiw1kD0CcHYYCRaEQDa9APemefCED+I9AIHpRJnTLpgbOn6lfv9McI2WlGK5ytp/hgd0x4mbbsP4RT4sBMUI5DLhMcqaTyfUcgWt+vUtqvA5xtv9birwFALcusTnbPsxZsvCJbDueFET81wCpmjicSMaBf1ekmIsrsXf1GBB0TXFxxk/eHNDqYcyLBoFukc/x92BEkd5BqHSiS+byH1UnpiZUKlyGcywPRkajh9OVZ7RPimHIMDGwkx+6C86xtMl8sPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ4t+DpCnaCEG9Eq3zEP26yzDdCWoRwgM+X0zAWKr8Y=;
 b=glnB6nriuIaqGxD60/j4b2em1jMhnbzvtSD2k+gMQAq1BahmCPvD9mJYVI9wUfq24QOaegpYbj/5nMez14OzEOnzYCtcXoVpPVKeHd11b95juWzemt4Ko9mqIVc8Cy/Rge7teGXUyVBhrik8VAmjD1eFasvXJvMAsA9JT4oIjqM=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by BN8PR12MB2929.namprd12.prod.outlook.com (2603:10b6:408:9c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 09:10:57 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c02f:cbc1:308b:b4b9]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c02f:cbc1:308b:b4b9%4]) with mapi id 15.20.5206.012; Thu, 28 Apr 2022
 09:10:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: Fix build warning for TA debugfs interface
Thread-Topic: [PATCH v3] drm/amdgpu: Fix build warning for TA debugfs interface
Thread-Index: AQHYWtmfOXXtpETmNU684j5dsAaLGK0FCc6L
Date: Thu, 28 Apr 2022 09:10:56 +0000
Message-ID: <CO6PR12MB5473B1699C4AC3EB02BFA26A82FD9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220428082524.32450-1-candice.li@amd.com>
In-Reply-To: <20220428082524.32450-1-candice.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-28T09:10:56.881Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 761db1bf-ab2d-46c1-ad4f-08da28f7013f
x-ms-traffictypediagnostic: BN8PR12MB2929:EE_
x-microsoft-antispam-prvs: <BN8PR12MB2929C25D6A70C0732E0ABEE382FD9@BN8PR12MB2929.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzGmikVD50zR7tRQygdIATzzupHWIEZdYrgCzEJok+CtOUK5PifFnhEHl+HkzAhffWKkIXmDSCsisf4va3Lkh6d/3egvR8OueLAslBqiFBSGQKsDQMrr1LZ4S39PCKGi6bLSrlkevfWMq+R8bb1GQVRd+cLTwG79S/waox5j+5FvdTipCcmRBGZc6fETIbtbi4D+3yayhz2lLGW+lNG8fZR5a1pSSIR4gBos+/euZruGa28BqC/+kzo/Y0eHd+C9sT80HUypKEJ/FvSujr0J5UCqFLhniiCm9tN/JVS/tyrlZ42e3Zr6Rte2nfTaAaWqVv2CNZlImkU1UXU0ZDYejxrojBnadE/wosIXKOZkLrJucVzHMSy4TvNtYqPeDSWkbRdtZRXvRU5WiFqs/MAofYG2Qu9fUIqfBOx2eP/3VnCBldeGhCGUwYzByyp9DSYpJ8VZeIrEExejBsSgrvJcJ4WONOwaDObufqkgNRuozkzApoJnIRviWnrdn44lWskmnN8Q1DxI5DXu1FRxKRc9ARoM1etvut/ZRm7vUO3oLDursWeOHrcMOmUOsn8KqKxgkq19yFbcj9zytQ7FWP8Z5ZqKzhTcS85M4hCJhhuXjNowCRlvIa6khuBpY7p9tZ3jkQUhKgMTlRpkJ5RIbbc1vJR96p9Qy5PUs4YXaclSa8Bl05grcLpjD4ByAYdEK9JwIVT2hLqBEG3d/qPVNuGq1gA0KMJlutCrMa1+sfk+zVs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(83380400001)(71200400001)(6506007)(53546011)(8936002)(186003)(52536014)(9686003)(508600001)(5660300002)(86362001)(26005)(33656002)(110136005)(19627405001)(316002)(2906002)(8676002)(64756008)(66476007)(66556008)(66446008)(76116006)(66946007)(91956017)(122000001)(55016003)(38100700002)(38070700005)(461764006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8jx4wl4VIXaiEH9U3A951atTAOEPsFjoMBI/dcrBFWCKwEsA5Y1GXWRNnK?=
 =?iso-8859-1?Q?g6Dcrd8ovg4jOZHWD3T5z+9zHBgBzt8ciBuT0VxIIlgwfUAarGIQtTPEjH?=
 =?iso-8859-1?Q?hvE81OGae+gpV16nFHTRyZZ8OFKlStn4127RV4SAC8N5k0J5Yxt469LqwF?=
 =?iso-8859-1?Q?9ecxIxWgA/zOhsDuoqYAuR812W9wbdJMj2UUVA6b56WQN/dzo5brzSPLvm?=
 =?iso-8859-1?Q?PM4vwPmOvarQy0oecnggabByyGlBWgzUNRhCwbBFv+846gL7FH/AI4MF2w?=
 =?iso-8859-1?Q?6scfBiyYfFUYAzwN44B7m5yULIDgCaRL+ZpK5IOSVu4K9hCbSrHk0Zn9Qt?=
 =?iso-8859-1?Q?KxhP6stXyzn6+1CSE/cBiEJl+EeeJpU3Uu7DJLFzyaUzDqOFWc84XMhuJt?=
 =?iso-8859-1?Q?EiQPsC3As8RNxHvzpv3gXLSZsVXbqapfHu/aFam7f3VQ9rtNsLWgQSQ1wo?=
 =?iso-8859-1?Q?hSLLLubGhXCjs1mf542or0/i1sLDBtq5iv2PcIW/vYYE0f+RI2tCoF86cE?=
 =?iso-8859-1?Q?zgKfQiYfXZi5vfaiMGcGxrPvWbs03b8IlEZxZVMLRkTf8fN15vj0syeeu/?=
 =?iso-8859-1?Q?1/OYVJKemBqZunsI5IHbhuHIRkjy0WHFMnXhxV/DisXa3Aw+vAusX7BEYF?=
 =?iso-8859-1?Q?UATBliuBiMhkdaRuMt0VfwrGCF6gNHovnQMuAeas+mLhPPbZzDR8UWBETh?=
 =?iso-8859-1?Q?+jOPQQtfucxxSrBM3AiPHdZDt06uTu+fjYNiS/gCRLHTmUwcjVZlsY3TZ3?=
 =?iso-8859-1?Q?0wywkvcfxSEboUxsBxdoyjynWTUNRHNCbNs4AruhwmtQ2HUSHp/oAYFHCR?=
 =?iso-8859-1?Q?wJmadzbTaNQGVUr9wuJvYLpe4MuBx4nhm2SqpC8OZXHJLclThnz3y5EuEJ?=
 =?iso-8859-1?Q?C4XSJpNGb14re3VjTwrykdz0/3dO0AtEYdDIwmLo/REVxrH5TU82oU+dG6?=
 =?iso-8859-1?Q?/TxmoOcWmx9DFK4Hf4QEwwB4Hn187EwxepMG3nUl5oMenVVXnN79NwFewF?=
 =?iso-8859-1?Q?esafa52T5ws65L/Dgx+wUfGubxP9xJ+fBgLIR61YoXqgR+t15bKVE7lIMf?=
 =?iso-8859-1?Q?htTX8/znaMLAEkFnNUUqCL83zSvTx5keRBrp2+jsb5Llpmii/ge5x2Jhac?=
 =?iso-8859-1?Q?QvGvmMM3LWlh5Yf41grrGkGdYs4Sa01hpZTcsmgvTzK/+3Zl7S7KyrP89R?=
 =?iso-8859-1?Q?UzGadm493jndLarezpI/paTZR74kCxuQIdrbnyuxmVStc9xHVGvbChw0h/?=
 =?iso-8859-1?Q?FB2uzBEhSoTCMf06qBB4l7apzDbo7gw42cWLXX96c6NMdQ16MzvC+6ihqS?=
 =?iso-8859-1?Q?qLWHwDs3y4xRoL3ivwM9wq+hHHwVtGYCw8SsXXoATVwM4+qdVcrgKUbUEW?=
 =?iso-8859-1?Q?Ly0Ts1By5/oUh1n4iIRbLjLg/i49vunbi483RdMf228q5wuNglocFknmkU?=
 =?iso-8859-1?Q?x4gttg2LYfvLg9JbRb4Fnzfxsi31IGpxtFhETJtNv+CQQfXfJWibyt1gkg?=
 =?iso-8859-1?Q?XcWvVexPXIRxedFZufLMz8D21RExGUl5c9J6AFTUjr7Y5lxKHb/lZr3euE?=
 =?iso-8859-1?Q?/MAQv39d9ho4ec2+h+zjIzqwyBo/ZjenQeoHiL4tBmfhhN4Aa68LJHHf53?=
 =?iso-8859-1?Q?nxw+X5wYpf43HOnAQXIhKyKrX1iOxo9rkTb6Bi2fZuqIHCtajs0qdslJy5?=
 =?iso-8859-1?Q?wKDpJ9zMinsM7qy+J5ZFrcIUP4GEgIbni7jLpSdsR1JJ0IAQljSqkDCZKd?=
 =?iso-8859-1?Q?+AEotaM+3CqaaqMuQMvyPPHRCbwr+V+5Iyv2h69RWOt+CZ?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473B1699C4AC3EB02BFA26A82FD9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761db1bf-ab2d-46c1-ad4f-08da28f7013f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 09:10:56.8861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgSCdKT5/gP+KKKVRed9g8nS7akn8hX9JyRYc2kaJB+PzJnR1tXdx63L9s+LWlOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2929
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

--_000_CO6PR12MB5473B1699C4AC3EB02BFA26A82FD9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <candice.li@amd.com>
Sent: Thursday, April 28, 2022 4:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix build warning for TA debugfs interface

Remove the redundant codes to fix build warning
when CONFIG_DEBUG_FS is disabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 40 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h |  1 -
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 6806deb098d3f7..0988e00612e515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -24,12 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_psp_ta.h"

-static const char *TA_IF_FS_NAME =3D "ta_if";
-
-struct dentry *dir;
-static struct dentry *ta_load_debugfs_dentry;
-static struct dentry *ta_unload_debugfs_dentry;
-static struct dentry *ta_invoke_debugfs_dentry;
+#if defined(CONFIG_DEBUG_FS)

 static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
                                             size_t len, loff_t *off);
@@ -38,7 +33,6 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp=
, const char *buf,
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf=
,
                                             size_t len, loff_t *off);

-
 static uint32_t get_bin_version(const uint8_t *bin)
 {
         const struct common_firmware_header *hdr =3D
@@ -74,19 +68,19 @@ static bool is_ta_type_valid(enum ta_type_id ta_type)
 }

 static const struct file_operations ta_load_debugfs_fops =3D {
-       .write   =3D ta_if_load_debugfs_write,
+       .write  =3D ta_if_load_debugfs_write,
         .llseek =3D default_llseek,
         .owner  =3D THIS_MODULE
 };

 static const struct file_operations ta_unload_debugfs_fops =3D {
-       .write   =3D ta_if_unload_debugfs_write,
+       .write  =3D ta_if_unload_debugfs_write,
         .llseek =3D default_llseek,
         .owner  =3D THIS_MODULE
 };

 static const struct file_operations ta_invoke_debugfs_fops =3D {
-       .write   =3D ta_if_invoke_debugfs_write,
+       .write  =3D ta_if_invoke_debugfs_write,
         .llseek =3D default_llseek,
         .owner  =3D THIS_MODULE
 };
@@ -286,31 +280,25 @@ static ssize_t ta_if_invoke_debugfs_write(struct file=
 *fp, const char *buf, size
         return ret;
 }

-static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
         struct drm_minor *minor =3D adev_to_drm(adev)->primary;

-       dir =3D debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
+       struct dentry *dir =3D debugfs_create_dir("ta_if", minor->debugfs_r=
oot);

-       ta_load_debugfs_dentry =3D debugfs_create_file("ta_load", 0200, dir=
, adev,
-                                                    &ta_load_debugfs_fops)=
;
+       debugfs_create_file("ta_load", 0200, dir, adev,
+                                    &ta_load_debugfs_fops);

-       ta_unload_debugfs_dentry =3D debugfs_create_file("ta_unload", 0200,=
 dir,
-                                                    adev, &ta_unload_debug=
fs_fops);
+       debugfs_create_file("ta_unload", 0200, dir,
+                                    adev, &ta_unload_debugfs_fops);

-       ta_invoke_debugfs_dentry =3D debugfs_create_file("ta_invoke", 0200,=
 dir,
-                                                    adev, &ta_invoke_debug=
fs_fops);
-       return dir;
+       debugfs_create_file("ta_invoke", 0200, dir,
+                                    adev, &ta_invoke_debugfs_fops);
 }

+#else
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
-       dir =3D amdgpu_ta_if_debugfs_create(adev);
-#endif
-}

-void amdgpu_ta_if_debugfs_remove(void)
-{
-       debugfs_remove_recursive(dir);
 }
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h
index 883f89d57616d0..cfc1542f63ef94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -25,6 +25,5 @@
 #define __AMDGPU_PSP_TA_H__

 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
-void amdgpu_ta_if_debugfs_remove(void);

 #endif
--
2.17.1


--_000_CO6PR12MB5473B1699C4AC3EB02BFA26A82FD9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;candice.li@amd=
.com&gt;<br>
<b>Sent:</b> Thursday, April 28, 2022 4:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: Fix build warning for TA debugfs int=
erface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Remove the redundant codes to fix build warning<br=
>
when CONFIG_DEBUG_FS is disabled.<br>
<br>
Reported-by: Randy Dunlap &lt;rdunlap@infradead.org&gt;<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 40 ++++++++-------------=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h |&nbsp; 1 -<br>
&nbsp;2 files changed, 14 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c<br>
index 6806deb098d3f7..0988e00612e515 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
@@ -24,12 +24,7 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp_ta.h&quot;<br>
&nbsp;<br>
-static const char *TA_IF_FS_NAME =3D &quot;ta_if&quot;;<br>
-<br>
-struct dentry *dir;<br>
-static struct dentry *ta_load_debugfs_dentry;<br>
-static struct dentry *ta_unload_debugfs_dentry;<br>
-static struct dentry *ta_invoke_debugfs_dentry;<br>
+#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;<br>
&nbsp;static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *=
buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *off);<br>
@@ -38,7 +33,6 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp=
, const char *buf,<br>
&nbsp;static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char=
 *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *off);<br>
&nbsp;<br>
-<br>
&nbsp;static uint32_t get_bin_version(const uint8_t *bin)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *hdr =3D<br>
@@ -74,19 +68,19 @@ static bool is_ta_type_valid(enum ta_type_id ta_type)<b=
r>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const struct file_operations ta_load_debugfs_fops =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp; =3D ta_if_load_deb=
ugfs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp; =3D ta_if_load_debugfs_w=
rite,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODU=
LE<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct file_operations ta_unload_debugfs_fops =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp; =3D ta_if_unload_d=
ebugfs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp; =3D ta_if_unload_debugfs=
_write,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODU=
LE<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct file_operations ta_invoke_debugfs_fops =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp; =3D ta_if_invoke_d=
ebugfs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp; =3D ta_if_invoke_debugfs=
_write,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODU=
LE<br>
&nbsp;};<br>
@@ -286,31 +280,25 @@ static ssize_t ta_if_invoke_debugfs_write(struct file=
 *fp, const char *buf, size<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)<br>
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_minor *minor =
=3D adev_to_drm(adev)-&gt;primary;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D debugfs_create_dir(TA_IF_FS_N=
AME, minor-&gt;debugfs_root);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *dir =3D debugfs_create=
_dir(&quot;ta_if&quot;, minor-&gt;debugfs_root);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_load_debugfs_dentry =3D debugfs_cr=
eate_file(&quot;ta_load&quot;, 0200, dir, adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;ta_load_debugfs_fops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;ta_load&quo=
t;, 0200, dir, adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ta_load_=
debugfs_fops);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_unload_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_unload&quot;, 0200, dir,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_unload_debugfs_fops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;ta_unload&q=
uot;, 0200, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;ta=
_unload_debugfs_fops);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_invoke_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_invoke&quot;, 0200, dir,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_invoke_debugfs_fops);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dir;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;ta_invoke&q=
uot;, 0200, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;ta=
_invoke_debugfs_fops);<br>
&nbsp;}<br>
&nbsp;<br>
+#else<br>
&nbsp;void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-#if defined(CONFIG_DEBUG_FS)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D amdgpu_ta_if_debugfs_create(a=
dev);<br>
-#endif<br>
-}<br>
&nbsp;<br>
-void amdgpu_ta_if_debugfs_remove(void)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_remove_recursive(dir);<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h<br>
index 883f89d57616d0..cfc1542f63ef94 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h<br>
@@ -25,6 +25,5 @@<br>
&nbsp;#define __AMDGPU_PSP_TA_H__<br>
&nbsp;<br>
&nbsp;void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);<br>
-void amdgpu_ta_if_debugfs_remove(void);<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473B1699C4AC3EB02BFA26A82FD9CO6PR12MB5473namp_--
