Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392E6C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 01:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE43624699
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 01:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i2/+MOE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE43624699
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1116E048;
	Mon,  2 Mar 2020 01:39:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA656E048
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 01:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIET01MR6cIGZyws9CLjxKwCNz0Vcbbzg/jWWS7XrGlSqXj7G1ew6NTEgqPuLoEfAM9sao54cCoTuaFvRa6hiwZ9QijjCGppCPH8OrS/42thKg05YVsOGuedwzdxuMjAsA3EPtybGXKmeyHNpvtrpRUyPa9xitZ4wse4wbiF0GHNz9tw2R6RSS4PXaXCInmseh1EA7lowCr+B+ReiIWnpEZFeLRH2Dy9hJWwgnGiMQEO9lT5EoPhsAt6QfS2GGM5XqpuUklU0W2ZBwqKEHQlbYqK0hgk+m/gIno/Eb6RUP7fTyztVctjJkEZhPiV3Lc81W/waBDkwup1MZ8PeM/EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoPZ8BiU/Xghpt/1Ysu4dEx5J0EAW+nbwTfNoJ7g+B0=;
 b=aiB+oWSQQQGx+/ISMH5DTL6KCSXNCwWPKNSvUn4H6t2UHN7iJBq/Kd8sslrUZVvREOlGYfufRgkLgSR4iWCFUlV6/ARDkrJgbNs3yT3f44M3PIYTDE5sJTM0anz5ac8u6gbrJK/j8rJkZnzrFUINRge6z/TwSdWcnAJH0YSD496CEelXGi5cLAw771qgvlkoa4msfl5EyGzNtJYVEbKRE54R3a5bOma/92NZ5J6oBJE1wY9m/fnjCKG50fGAh0qs7rD/BW0ksJ5Oj9TonTkIgRsvHKhGu+ci55bhK+AFEXvHWW9pHnJoTVge1iLNWhPCUEy0n217ntvaY+vUBq/xCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoPZ8BiU/Xghpt/1Ysu4dEx5J0EAW+nbwTfNoJ7g+B0=;
 b=i2/+MOE4hyHfbC7oD8MCW1EvY9EDJc+NtCxuThETTFzW0fktBeYYiIPt68SG8aygc4hUwA7Pwrq7vMAYvG0H/Kn0W/9bhqs/+sTq1PZ5LN9Q7MmB+UymOvtBQ+qUEb15GijYbw24lqC1Zz1ZwiltPG7siHAvUAii5r/p8lrNpvQ=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3199.namprd12.prod.outlook.com (2603:10b6:208:ae::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 01:39:48 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 01:39:48 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Dhume, Samir" <Samir.Dhume@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
Thread-Topic: [PATCH] drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
Thread-Index: AQHV3SgKUffgTmaXsEKcG2UQUZKULag0q/gw
Date: Mon, 2 Mar 2020 01:39:47 +0000
Message-ID: <MN2PR12MB3933522A78B2044202C4713D84E70@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200206195935.36365-1-samir.dhume@amd.com>
In-Reply-To: <20200206195935.36365-1-samir.dhume@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d62cf453-d109-4aae-b73b-08d7be4a97df
x-ms-traffictypediagnostic: MN2PR12MB3199:|MN2PR12MB3199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3199C0D1F5CA6952EA6384B584E70@MN2PR12MB3199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(2906002)(966005)(8936002)(9686003)(55016002)(81166006)(81156014)(8676002)(45080400002)(86362001)(478600001)(6506007)(7696005)(26005)(316002)(110136005)(186003)(33656002)(53546011)(52536014)(5660300002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(71200400001)(4326008)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3199;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: euEh5T31aQ7HdxPwM8HrrSkaT7UEo3NCn3kajrojnG6Q9brwLb58x7Jaap4iHW6azyOA1mJ1xruWpVHKv0h3lzZ/zEovbN81QiIOVCQHYESJ5F+Mro3eD4LkCdfXgUVwlp1+IBFgH/id75p/+hvGPDKgncQXeQx0XXVIrvHgwAdAQq0wh9C+R5dHigspwD+4dXaWWV1S3eUguTLyik50ZekRox+ERyVj5HJx3jwWpMxx4Gca6SSDZ50OaeN6vxMMxCE6iAbLpWmfh9Ufk4GvquT6GdNlaHBcqxMH46edpVcfgcgDcF2op+YRXCYY1v4b/aoVCx4CFRp0r+zyWh7Uqo+OJhWHR+ae1S8sfW+jkdutuy8PusPoVLiWHEheKPFGbpry+bE0ppL1YUBPO0hpJLWayxWX9wFvuVziyJsJtf5LLsccS71sFnM7/TGVvB6B2mql0Pb67m0O/mg4Hd76Q1y88gTCc0WM+lKy3jCKUGfmGA5xKXU+if62HxCxidYV+3EvqIOSp4MEzcDpH8CawA==
x-ms-exchange-antispam-messagedata: 7OhpsT9QbKygraSYFqz8G2jqfsv/gtpQppNM+vZ6JaTwvNrGM5KkC6Z0iEyM4kMYo/uttEHp/TGGknUcdCW0irKAyNYXSzjsxYinHg2wZ+lzkyiD7PetH6p3rN/KJiw02X0Hw4JU/nkQnVUvRPLPlA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62cf453-d109-4aae-b73b-08d7be4a97df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 01:39:48.0173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGmNLuKTPqms+gR7+MHiC/eXA1o2QLVeoo1tCG72JvP9m6RgqqB3R+PGA5d5IB48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3199
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
Cc: "Dhume, Samir" <Samir.Dhume@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Samir

Looks it is your first upstream path, 

The format of your description need to change:

Modify:
[PATCH] drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
To:
drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost

with that changed you can get my RB 
(means you can put "Reviewed-by: Monk Liu <monk.liu@amd.com>" to the tail of your commit description)

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Samir Dhume
Sent: Friday, February 7, 2020 4:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>
Subject: [PATCH] drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost

Ported from Vega10. SDMA stress tests sometimes see IRQ lost.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index cf557a428298..e08245a446fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -32,6 +32,7 @@
 #include "soc15_common.h"
 #include "navi10_ih.h"
 
+#define MAX_REARM_RETRY 10
 
 static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
@@ -283,6 +284,38 @@ static void navi10_ih_decode_iv(struct amdgpu_device *adev,
 	ih->rptr += 32;
 }
 
+/**
+ * navi10_ih_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	uint32_t reg_rptr = 0;
+	uint32_t v = 0;
+	uint32_t i = 0;
+
+	if (ih == &adev->irq.ih)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
+	else if (ih == &adev->irq.ih1)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);
+	else
+		return;
+
+	/* Rearm IRQ / re-write doorbell if doorbell write is lost */
+	for (i = 0; i < MAX_REARM_RETRY; i++) {
+		v = RREG32_NO_KIQ(reg_rptr);
+		if ((v < ih->ring_size) && (v != ih->rptr))
+			WDOORBELL32(ih->doorbell_index, ih->rptr);
+		else
+			break;
+	}
+}
+
 /**
  * navi10_ih_set_rptr - set the IH ring buffer rptr
  *
@@ -297,6 +330,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
 		WDOORBELL32(ih->doorbell_index, ih->rptr);
+
+		if (amdgpu_sriov_vf(adev))
+			navi10_ih_irq_rearm(adev, ih);
 	} else
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);  }
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cd2e01b4b73cb4b75ae9f08d7ab3f27e1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637166160122750193&amp;sdata=NtTwlzGVJWf8D%2BKWiaQKiAile9n03KlIW70mu8TkKXM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
