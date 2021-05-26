Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACEC47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 20:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E68613EC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 20:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E68613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C0F6E0BA;
	Wed, 26 May 2021 20:53:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68B56E0BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 20:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq4W20fJY9U7ZtgY9teAqUcZm29Cfycu2Pe14Dtdpuu09yr0bKfmWKLcYJ0HO2HvKwvhv+WwxiN1oVTvAok41wO4Elmb3ZwP4ihRpmtPSpYoIkiALT+8fXP6EBf2590qUKRZki3m5lXymGj/g3OMwosgadRAHa69wqnTqRLQl455CPv9YY9BWcnn6oltNcj6u73MT3GMg54miWxituva0Jk9Kdut772n/RvboeLLbpviNZ0n9dxUJ/5kHzZ/pQ2W0hRxVodFbg1M0LxbWSvG1piZtX5IeBduZBng4IrTzSxgji49WfWlJGXJ4dLuCv+HXou+KA/dUhdVzoIZPs3zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmhnrEMTDMqStz6FC7Fs0Vzj37t9RMC8y86i8YOsBqs=;
 b=k5Yy3gfAZR5UtcaIhR613SncaerR4iEm/YHXGni5wQkQFUshIWOJQ+Q+CKaP/JYGW5p9g8MY3CL9jX1LxSqaWSw0KoGJtidsRcWtEfHuDTeuXjaMm6MvaEtxA4JNhC4vRGfmP8jgOIICSP72nQ74UOpISgJZKROIhi0eJ8rhMZ3UFRuc0iH4dSvddfY/MEhuD01WR7CwBQJjP0/2nDgceM21Wfycyk0QWFNcqhqLlnhPwvdJHNPjCEMxV9/fERvMBHbjYU4F+OjSY4tdiLDoyNpQT5xQVn5G7Lt07LyUQ8z1kPhpOj7/qWMoP9KWd+S7N4E1o6BgMVqe3YVcmq4Bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmhnrEMTDMqStz6FC7Fs0Vzj37t9RMC8y86i8YOsBqs=;
 b=BJQXpGvsxurPLb71IY/u7ZUBJEeimkPwE46DpGZi9hegdXgDrvSaNumQjwbiyaP2zLRShVJ3O60oBriNMpO9b63BBdjUX/mPjV37YqeYUPLBee7T5R2tv7hOX7PaEatr/TuTvQMIxRcUtjHRtkFcZegC9cRGa9okBOmHL53iuEc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 20:53:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 20:53:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
Thread-Topic: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
Thread-Index: AQHXUk5Ej/8IFNzda0y3rUDP6fR3D6r2PYVY
Date: Wed, 26 May 2021 20:53:53 +0000
Message-ID: <MN2PR12MB4488CF450A1A48ABC31DA947F7249@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210526164316.20547-1-luben.tuikov@amd.com>,
 <20210526164316.20547-3-luben.tuikov@amd.com>
In-Reply-To: <20210526164316.20547-3-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-26T20:53:53.069Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [204.111.139.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d8a321a-831d-4822-bed9-08d920885f82
x-ms-traffictypediagnostic: BL0PR12MB4852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB48525041F999B7C3B231405EF7249@BL0PR12MB4852.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txVtkWHRM6zV66oFZqYnK9YkgwO4zCXhVIwEvNNvEfmcFkP1y6jyo8iSO1nTBllnZqmh4trBj0kQEtKBy71JYzi8k0iwWZwXBSAkn2ascy9c6SvKXUcvRE/YJJgK9UzEYISPGLsXL6jB6WM2ZEXbOj9zlOKerJVWxeD5ORVXRqr5ek8KbE1YraH1NhRCxuDkHKgygIrJZ6oFZsg/QgY/pvgVuRXa/WY/+T6mFsF5ke7kRHCypH8Jz5on0n7+MfBJ32gh1edCCLjVtnWfcLW/1TyGz1jw4qUPVsED8prLvhdumc2WsD9zN6FRkkPNnGmrY1EAfpskg3q/g1Eo93ttBD4a5XCWwUME+UdkpicLvlER72QHo+JZHV2DckFEXhxl/UDec0NH4GP9FgZKH1HndzcDoNGV1HiLbYH1eSZMa84/egxK1hNkoL5iMmqQzZbZnY9TsZjoW7ynMZat/Xr+UL+ujhSxyraMreGoyWA1ohQ8ZUlRWpbQWLLmskpv6rUEGr+p+xC6liSNI9aINtJKGVyz6itcHyoIuqD++EiOy6atMFEq7eP+Q7xJpIzQneQ8pEba3XkdMqo57Z5Z/mBiwtgP7fTOfvB/FIrVHVAB6mU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(64756008)(66946007)(53546011)(5660300002)(186003)(33656002)(26005)(316002)(54906003)(122000001)(7696005)(38100700002)(71200400001)(66476007)(6506007)(9686003)(8936002)(76116006)(86362001)(478600001)(66556008)(52536014)(19627405001)(55016002)(66446008)(83380400001)(4326008)(66574015)(2906002)(110136005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G2wbgY/vN8gItGiP2q+BL1KjlwKJKwCqM3OKjNN25NkvoEMIIl7dQB64H09PLA2rdHbduraFifk5vokmdwMeH9XjjsvSaILAG5/b7L0uIMkmmjYuKHOJBhxVEftCozD48Cy+Jot30dXhOwLQxUigPo1syHEtE0+VPkjHlfn//izP8ItbyElen6C9j5UMIrKFFQPdkpgVwS81zMuFI08gMWnKeaYD5QE3I1qkaMOYhI7W4oxlETRubSIPltPLLFX5WAEQlJdGLzI+MejEWio57xTc36KuMQL2FeB2Rp+oNCbcKPFArdFPHx21hFpt2FhiU0QUiHV8GJ52bFi7m9o/7cPC7+QxFRLoUwT0kJmDITJgVCVpOxl2LpngvYlNvoJJTeI9rS/bHx/YxvLNF+aRGrJUzJH93tcb/63pu9VZYvldL6H6UcQGBX8xIBxrtDusm7FMJM9H0ulc44TftRc4+O6gxqLf5zj+lLDM+1o1K6p0zk5LtC+vAU4yWKxfv1YPlgdzsDG50djq+vUTwd3KJeuBIhCJ1dV6aTJxEVqw4q13L2pQA3pQJTsbRY+l6mTHXWM6JVnCEnkQ6HWdiMSST4kb0mp2vVgAUDtstp8EBKK50d2hgSqa4iAx9evJg+7DdyH/azltebKP/HKGd0LZMURXzZF4b0mEFZFlFiMXmu5k3Laoy/GN1ea4odGXbgR5M5c+MMUWhfH1z2ry7fPcxLIVnU20vtdOJoNqt40sHXrQmfQp8bEX3hAU3rC5K1Pa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8a321a-831d-4822-bed9-08d920885f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 20:53:53.6943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYByZ7Ycs4jaUXx0GrwPQTkfi955gJudAeOPGKBMQNAUr7cFg2izbDfW0c+13K0c9YggN30N0IBwmA9noQqo0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
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
Cc: "Clements, John" <John.Clements@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1163935238=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1163935238==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488CF450A1A48ABC31DA947F7249MN2PR12MB4488namp_"

--_000_MN2PR12MB4488CF450A1A48ABC31DA947F7249MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, May 26, 2021 12:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Clements, John=
 <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error coun=
ters

On Context Query2 IOCTL return the correctable and
uncorrectable errors in O(1) fashion, from cached
values, and schedule a delayed work function to
calculate and cache them for the next such IOCTL.

v2: Cancel pending delayed work at ras_fini().
v3: Remove conditionals when dealing with delayed
    work manipulation as they're inherently racy.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 31 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 40 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 ++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index bb0cfe871aba..e7a010b7ca1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -331,10 +331,13 @@ static int amdgpu_ctx_query(struct amdgpu_device *ade=
v,
         return 0;
 }

+#define AMDGPU_RAS_COUNTE_DELAY_MS 3000
+
 static int amdgpu_ctx_query2(struct amdgpu_device *adev,
-       struct amdgpu_fpriv *fpriv, uint32_t id,
-       union drm_amdgpu_ctx_out *out)
+                            struct amdgpu_fpriv *fpriv, uint32_t id,
+                            union drm_amdgpu_ctx_out *out)
 {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
         struct amdgpu_ctx *ctx;
         struct amdgpu_ctx_mgr *mgr;

@@ -361,6 +364,30 @@ static int amdgpu_ctx_query2(struct amdgpu_device *ade=
v,
         if (atomic_read(&ctx->guilty))
                 out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_GUILTY;

+       if (adev->ras_enabled && con) {
+               /* Return the cached values in O(1),
+                * and schedule delayed work to cache
+                * new vaues.
+                */
+               int ce_count, ue_count;
+
+               ce_count =3D atomic_read(&con->ras_ce_count);
+               ue_count =3D atomic_read(&con->ras_ue_count);
+
+               if (ce_count !=3D ctx->ras_counter_ce) {
+                       ctx->ras_counter_ce =3D ce_count;
+                       out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_C=
E;
+               }
+
+               if (ue_count !=3D ctx->ras_counter_ue) {
+                       ctx->ras_counter_ue =3D ue_count;
+                       out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_U=
E;
+               }
+
+               schedule_delayed_work(&con->ras_counte_delay_work,
+                                     msecs_to_jiffies(AMDGPU_RAS_COUNTE_DE=
LAY_MS));
+       }
+
         mutex_unlock(&mgr->lock);
         return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ed3c43e8b0b5..ec936cde2726 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 #include <linux/reboot.h>
 #include <linux/syscalls.h>
+#include <linux/pm_runtime.h>

 #include "amdgpu.h"
 #include "amdgpu_ras.h"
@@ -2116,6 +2117,30 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
                 adev->ras_hw_enabled & amdgpu_ras_mask;
 }

+static void amdgpu_ras_counte_dw(struct work_struct *work)
+{
+       struct amdgpu_ras *con =3D container_of(work, struct amdgpu_ras,
+                                             ras_counte_delay_work.work);
+       struct amdgpu_device *adev =3D con->adev;
+       struct drm_device *dev =3D &adev->ddev;
+       unsigned long ce_count, ue_count;
+       int res;
+
+       res =3D pm_runtime_get_sync(dev->dev);
+       if (res < 0)
+               goto Out;
+
+       /* Cache new values.
+        */
+       amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
+       atomic_set(&con->ras_ce_count, ce_count);
+       atomic_set(&con->ras_ue_count, ue_count);
+
+       pm_runtime_mark_last_busy(dev->dev);
+Out:
+       pm_runtime_put_autosuspend(dev->dev);
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
@@ -2130,6 +2155,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
         if (!con)
                 return -ENOMEM;

+       con->adev =3D adev;
+       INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw=
);
+       atomic_set(&con->ras_ce_count, 0);
+       atomic_set(&con->ras_ue_count, 0);
+
         con->objs =3D (struct ras_manager *)(con + 1);

         amdgpu_ras_set_context(adev, con);
@@ -2233,6 +2263,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
                          struct ras_fs_if *fs_info,
                          struct ras_ih_if *ih_info)
 {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       unsigned long ue_count, ce_count;
         int r;

         /* disable RAS feature per IP block if it is not supported */
@@ -2273,6 +2305,12 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
         if (r)
                 goto sysfs;

+       /* Those are the cached values at init.
+        */
+       amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
+       atomic_set(&con->ras_ce_count, ce_count);
+       atomic_set(&con->ras_ue_count, ue_count);
+
         return 0;
 cleanup:
         amdgpu_ras_sysfs_remove(adev, ras_block);
@@ -2390,6 +2428,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
         if (con->features)
                 amdgpu_ras_disable_all_features(adev, 1);

+       cancel_delayed_work_sync(&con->ras_counte_delay_work);
+
         amdgpu_ras_set_context(adev, NULL);
         kfree(con);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 10fca0393106..256cea5d34f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -340,6 +340,11 @@ struct amdgpu_ras {

         /* disable ras error count harvest in recovery */
         bool disable_ras_err_cnt_harvest;
+
+       /* RAS count errors delayed work */
+       struct delayed_work ras_counte_delay_work;
+       atomic_t ras_ue_count;
+       atomic_t ras_ce_count;
 };

 struct ras_fs_data {
--
2.31.1.527.g2d677e5b15


--_000_MN2PR12MB4488CF450A1A48ABC31DA947F7249MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 26, 2021 12:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@am=
d.com&gt;; Clements, John &lt;John.Clements@amd.com&gt;; Zhang, Hawking &lt=
;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS err=
or counters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Context Query2 IOCTL return the correctable and=
<br>
uncorrectable errors in O(1) fashion, from cached<br>
values, and schedule a delayed work function to<br>
calculate and cache them for the next such IOCTL.<br>
<br>
v2: Cancel pending delayed work at ras_fini().<br>
v3: Remove conditionals when dealing with delayed<br>
&nbsp;&nbsp;&nbsp; work manipulation as they're inherently racy.<br>
<br>
Cc: Alexander Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: John Clements &lt;john.clements@amd.com&gt;<br>
Cc: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 31 +++++++++++++++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 40 ++++++++++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 5 ++++<br>
&nbsp;3 files changed, 74 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index bb0cfe871aba..e7a010b7ca1f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -331,10 +331,13 @@ static int amdgpu_ctx_query(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+#define AMDGPU_RAS_COUNTE_DELAY_MS 3000<br>
+<br>
&nbsp;static int amdgpu_ctx_query2(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv, uint32_t =
id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union drm_amdgpu_ctx_out *out)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv, uint32_t id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; union drm_amdgpu_ctx_out *out)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras=
_get_context(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx_mgr *mgr=
;<br>
&nbsp;<br>
@@ -361,6 +364,30 @@ static int amdgpu_ctx_query2(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;ctx-&=
gt;guilty))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; out-&gt;state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_GUIL=
TY;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ras_enabled &amp;&amp; c=
on) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Return the cached values in O(1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * and schedule delayed work to cache<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * new vaues.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int ce_count, ue_count;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ce_count =3D atomic_read(&amp;con-&gt;ras_ce_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ue_count =3D atomic_read(&amp;con-&gt;ras_ue_count);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ce_count !=3D ctx-&gt;ras_counter_ce) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;ras_coun=
ter_ce =3D ce_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;state.fl=
ags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ue_count !=3D ctx-&gt;ras_counter_ue) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;ras_coun=
ter_ue =3D ue_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;state.fl=
ags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; schedule_delayed_work(&amp;con-&gt;ras_counte_delay_work,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_t=
o_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgr-&gt;=
lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index ed3c43e8b0b5..ec936cde2726 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -27,6 +27,7 @@<br>
&nbsp;#include &lt;linux/uaccess.h&gt;<br>
&nbsp;#include &lt;linux/reboot.h&gt;<br>
&nbsp;#include &lt;linux/syscalls.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
@@ -2116,6 +2117,30 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp; amdgpu_ras_mask;<br>
&nbsp;}<br>
&nbsp;<br>
+static void amdgpu_ras_counte_dw(struct work_struct *work)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D container_=
of(work, struct amdgpu_ras,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_counte_delay_work.work);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D con-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D &amp;adev-=
&gt;ddev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ce_count, ue_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D pm_runtime_get_sync(dev-&gt;d=
ev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cache new values.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_query_error_count(adev, &a=
mp;ce_count, &amp;ue_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ce_count,=
 ce_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ue_count,=
 ue_count);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(dev-&gt;dev=
);<br>
+Out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;de=
v);<br>
+}<br>
+<br>
&nbsp;int amdgpu_ras_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D=
 amdgpu_ras_get_context(adev);<br>
@@ -2130,6 +2155,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!con)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;adev =3D adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;con-&gt;ras_co=
unte_delay_work, amdgpu_ras_counte_dw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ce_count,=
 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ue_count,=
 0);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;objs =3D (struct r=
as_manager *)(con + 1);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_set_context(ade=
v, con);<br>
@@ -2233,6 +2263,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct ras_fs_if *fs_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct ras_ih_if *ih_info)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras=
_get_context(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ue_count, ce_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable RAS feature per=
 IP block if it is not supported */<br>
@@ -2273,6 +2305,12 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto sysfs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Those are the cached values at ini=
t.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_query_error_count(adev, &a=
mp;ce_count, &amp;ue_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ce_count,=
 ce_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ue_count,=
 ue_count);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;cleanup:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_sysfs_remove(ad=
ev, ras_block);<br>
@@ -2390,6 +2428,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (con-&gt;features)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_disable_all_features(adev, 1);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;con-&gt=
;ras_counte_delay_work);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_set_context(ade=
v, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(con);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index 10fca0393106..256cea5d34f2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -340,6 +340,11 @@ struct amdgpu_ras {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable ras error count=
 harvest in recovery */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_ras_err_cnt_h=
arvest;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RAS count errors delayed work */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work ras_counte_delay_=
work;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ras_ue_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ras_ce_count;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct ras_fs_data {<br>
-- <br>
2.31.1.527.g2d677e5b15<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488CF450A1A48ABC31DA947F7249MN2PR12MB4488namp_--

--===============1163935238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1163935238==--
