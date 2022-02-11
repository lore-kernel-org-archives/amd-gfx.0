Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 01:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDD010E1F5;
	Fri, 11 Feb 2022 01:52:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86D410E1F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 01:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYIby8hB1gb1pj2I+l2btZOqUjedixyRojj+sKTEWxI3obfN878Jq3k/5Cql50Ah088xaO5SUmEnKI9uzLHJMqb4x2e8h+BmIg/Ng8ID0mZsA4Gl/XC5qUUjmDwos3q0kKbTQ2eg85q11n7L7+bsmVpfu0vtitss2QPiv0hJDCHypDRjO1JN8I4bnDaKbfQGc9XNmOpyzlE7shEYoT3wUTG+K1s9ZAPfZ7gM50tOPukk8tVJWNIWQfCQ8n+aQTyV4WNVefljt1O7SPrz1spzaJuX9irAYHHhdHIlk/yZbLK485KTa/aIoyQzSElUr2bKmgZwAY31CECG9hYPd6xCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu2zp3Lc18Ah0UOz2dSkxBCxA+NdDixUxGZpUYq/kX4=;
 b=gT0T4BaHUv0S45pDyYVlGxyYdqiqbki9LI26609M7mEujFnbRTQJN48I4+XCuQ85qGjAznzVjXYzbrDIMeTvJYQ3nb4cliwxUbPDqLx8TIIedc7A3csGPHeIOuzGYzhpBEfew7V5ClMoebKekH1HtncDZF59TVfmWYPTV25M+LBhRkEQpYDsAdjsWmAKHBr78v7LMmUQa/pW3pS9z28+MIAQUZfjrzXK7vcV6YQKECEGF7qsaPgmyScmGUXZRPX18oFt576h9yK7Wo+GHna9E/RHOCR/9riTKur6qW9/Vv70IfL+LTax4IUEaqGQzGVOqEJjXZh6u7Lcg/9cMWrHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu2zp3Lc18Ah0UOz2dSkxBCxA+NdDixUxGZpUYq/kX4=;
 b=SitTXBPQlGYPQ6fkcyJJo67b7JxBs55KI3NU/K7OcC0iAjcsYeNoCf32mrsFdNwjPYaRBVBlxjYfHzkX7Pp0GNYr7YE5BaGn77LOHW8zFH15FptF5nq2P4IRTdz0AgbFxGWxCn8a6OejfM0YIhVDhfJt8e8FaZD3YJu//lN8Kmg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Fri, 11 Feb 2022 01:51:56 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 01:51:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Topic: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Index: AQHYHkkn0o65+UeWJkG6vD0PnB9K2qyMjc2AgAANoQCAAPsUIA==
Date: Fri, 11 Feb 2022 01:51:55 +0000
Message-ID: <DM5PR12MB2469925F130D1880D2997527F1309@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220210064029.16545-1-guchun.chen@amd.com>
 <BL1PR12MB52546BEFD2C3B67857A269C5FC2F9@BL1PR12MB5254.namprd12.prod.outlook.com>
 <BN9PR12MB53240E14C93287D3D3AC6A438B2F9@BN9PR12MB5324.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB53240E14C93287D3D3AC6A438B2F9@BN9PR12MB5324.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-11T01:49:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6f09b96c-76fa-4fdc-b45d-cc405c6d15a7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-11T01:51:53Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ad7f02f6-247d-40cf-9714-0f00846d98c6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b53b0de-9c5b-4b5e-8a3a-08d9ed01156f
x-ms-traffictypediagnostic: DM5PR1201MB0139:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB01396E3339A9FB40A517BA1CF1309@DM5PR1201MB0139.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bRkmCu0AkSCUBIrEmosE5eFQgU2Mef2bUskUPDPo4fdYj4xSd8oznZfrnvg7bRTg5+2ADr3YSwmZbiO0mdX/zG8rzxC/H3K+AMF8I6wcaynzCXJhdO27f+ivxbbsEkLBph8H7rwGxYdPQYnAXYd4rz8qKqwGsufe5iSDbTYIOlcqI+kfgvcj8oSBgEgz5S8FAkYbZOKV3WF131cIWEm8QLTtSABbVNW3evss1RPaCy5LHN+U3LgsUIKXWcqCURAyAAW6kABa59pnOCi1M0v1xzjXCOOBBRfNvADePGX0zKvyOMs735rMDHNkyzX4tfoC6RE/pjZaIuLEGDjHFEetDgC1XyXLBRCiVv4WTJyefPtGKzDS+9esYcCGqFzW9n6IzzOft25DiBygdbZ+numIEXmMz/Abe0zS+CURjrNiaTkE5c5d1MprU+agYBx9a4mMwnSS6y6rCB9G353girCM6SvmzemeDT5ThY6EkAtamsj0rIPR8CzNZp776S3E4dgsx7qnMITkxCH35C/snp3mklPmfSzKtcwLK6sLpLh53wAIn/dJSN0vm0h57P3ONvfSVNH64MS4A99A7R4AN+Rn4oKFHSi/GwYNZ6RadCXzHVLjFeFxUNnZbNuDHh+WdIN3eHklB+6U9FpeNnxg8RtcXaegkCWxg3SXCp9EJVoPpeW84++HbIpZRe9BM8B+4dRI4IMaBzD85wf8fiRmCRhyBZYyYEGqs278Z38/vJ1vR6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(71200400001)(5660300002)(55016003)(33656002)(2906002)(66556008)(8676002)(26005)(186003)(66946007)(110136005)(6636002)(8936002)(52536014)(76116006)(9686003)(122000001)(38070700005)(64756008)(66446008)(38100700002)(66476007)(86362001)(53546011)(316002)(921005)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/rlSsHqv4I5in9l+wpjEIQbuerEJFzmtskpexYX5zHYJ6ZQeQJGybvhVtzpo?=
 =?us-ascii?Q?CJlxdhKBCVQz3dAJFo/4FlFAiSus1eeS1FnH/fTJn8Jix0xcLUEikQwDBifC?=
 =?us-ascii?Q?SpA+MsWG429APyLYGQLbc1rpQF0niTVJUJAxHlvJcLHLVR7/kc7sqIM84Lmp?=
 =?us-ascii?Q?qpeeD8M7BRYU37tOn4kC32EgF8TpPfZxM8Gz1CeJdSDQvSBd9AMupDbNfe/Q?=
 =?us-ascii?Q?CeCA6HqW6ny/c3gW029M3SqQ+KJ1V7KVG2pW/lfKvdl0v4k1RGmRitZW5gop?=
 =?us-ascii?Q?Pg1FAP4V3pnTnAweJAsnxfFVWPFJE9lyoamFwZh7y9U6P3A7oRCrrHuTrZUK?=
 =?us-ascii?Q?KAGIOjix0SH0vSkDrWHG1xNSSrnHuQ8C6YTEywBTFv2XliRviM4gg7ffIHRU?=
 =?us-ascii?Q?SAJjv0p8qzNq9foJqCEDc8QRONfVxIfMQSnFUYRoMxm3V3pbKJxocG3STO/u?=
 =?us-ascii?Q?+3Y55ylGoMd4ZIPjppMS6QvXjOem7QCvL7V2AIakI9++hGZf2htJbJFqUiGj?=
 =?us-ascii?Q?6/QEnc5G81O8xJShkYJ4iT+dfDfBOzxwNQMmUYOaSvX82wUAXrLA/R13Z3sT?=
 =?us-ascii?Q?u+fFDIsp1loioVvx6KSl3w57eWsgXaMU9QYuEHv0eqUho4E2CQOlXziWY+d7?=
 =?us-ascii?Q?G9jQBSyDfpE7T2NM/sZNtQ9/lFrsrHZD+16cR603cMt4Lx8EEfzuEc1FSrT5?=
 =?us-ascii?Q?joi4PHtYYmZUJNBG3vE2QKZfJLJOj9bx6/QT0tUfYemWi5ascpWsfUIqj9uQ?=
 =?us-ascii?Q?G4CHQ/VOovxd/SMpv/VPRg1gbnRXsPF3R7nyOGT/dmucE8Q3gzox9ub7bfo9?=
 =?us-ascii?Q?0ELXGsnSUBKT4hJk4RCNlsWa9jpv9gLQCkIme9YKDwwuLU+CR65WyYIlgYL7?=
 =?us-ascii?Q?/g1ogC3ULn4xoPVvrbJS3JJg0sO3jybmpeLbpTKpTshOqvUlUFzLDC6uVBPC?=
 =?us-ascii?Q?O9IJn307FzAMTboBW6pXzv4T4aahVtUn4jxqeSzirugICFqX7wOCt6Gp/IS6?=
 =?us-ascii?Q?U1aE/41HPkhl3P3qnltHdG/QAJpzGBGTEv1X3kn+gXr7kCU/QKaV/9kljRwo?=
 =?us-ascii?Q?vc4mxykkCa3rYkLhO+KqnQpnb5MUiq9YkdwQPXt03czXGpZ0Ul+8cyKyRjM9?=
 =?us-ascii?Q?YRCTQGtRwtWeY6CwhqnSQJJ6VUJ0Ac/55b+RnbD63zD78w/BSf2xbog6JxKb?=
 =?us-ascii?Q?HtV/jUMHgGuQOlwL6AFBKQp7Lmj2iQljSUpWUxa2HBOHVcsHV8c1N/6giMzI?=
 =?us-ascii?Q?VoDPUMWpjO5p+MxYtrA6cXsgU2MFc/c/ePsxyDNWGOw68QxFv7Kjaxa5mWC6?=
 =?us-ascii?Q?Acslanhv605Vt3HQWlJ6APR/jRqYkC8oOCbbFDD4V2un5LoyB4agV4fP60Ll?=
 =?us-ascii?Q?hVUMC8o8TeiElW3TYTdpwVN8dshn8fTSlsVTVbJIhwOwacsKZq7sJmxY94D0?=
 =?us-ascii?Q?+qhftBwytn3lhvIaMzf3YHZcE9hPjiwqCcGsxdDVGEH5liHLpreHLkq2Gvs6?=
 =?us-ascii?Q?X4yfh9iGdq3eiGLHRMKHgYQYTwOHYVBisEgLiy+3nutawMedPYFruSjIzYoP?=
 =?us-ascii?Q?xDS2UPO766Ez5LSXUep+iFyhG51DbJBihylZCxPHlly9dXnVG+hNtWQnb5hx?=
 =?us-ascii?Q?dTRlo9/qV0dJGXz3WaSj2is=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b53b0de-9c5b-4b5e-8a3a-08d9ed01156f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 01:51:55.8455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rH5459y2PYAvRpHY/JcO68qL5BsYmBgePjgIFS49RBHxI9YSjddwkBgDt+UP6WO1qFDgaTPOokKvO2Vut6f1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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

[Public]

Hi Victor,

I thought about that before sending the patch, as there is indeed a hack in=
 gfx9 old code. So my idea is not to impact asics with gfx10, so add the ch=
eck in the caller.

Anyway, I will double verify your suggestion on ASICs with gfx10. If it's f=
ine, I will submit a v2 patch.

Regards,
Guchun

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>=20
Sent: Thursday, February 10, 2022 6:50 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; amd-gfx@lists.freedesktop.org; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Ko=
enig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx =
v9

[AMD Official Use Only]

Hi Guchun,

RLCG read is available on Aldebaran if amdgpu_sriov_reg_indirect_gc() flag =
is set. Instead of adding a new function, I think we should simply add a ch=
eck inside amdgpu_virt_get_rlcg_reg_access_flag():


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..1ee600e90312 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -836,7 +836,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,
                /* only in new version, AMDGPU_REGS_NO_KIQ and
                 * AMDGPU_REGS_RLC are enabled simultaneously */
                } else if ((acc_flags & AMDGPU_REGS_RLC) &&
-                          !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+                          !(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
                        *rlcg_flag =3D AMDGPU_RLCG_GC_WRITE_LEGACY;
                        ret =3D true;
                }

Thanks,
Victor

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, February 10, 2022 5:02 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhou=
, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx =
v9

[CAUTION: External Email]

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, February 10, 2022 14:40
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9

Fall back to MMIO to read registers as rlcg read is not available for gfx v=
9 in SRIOV configration. Otherwise, gmc_v9_0_flush_gpu_tlb will always comp=
lain timeout and finally breaks driver load.

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx=
9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a3274fa1c7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -37,6 +37,16 @@
                vf2pf_info->ucode_info[ucode].version =3D ver; \
        } while (0)

+static bool amdgpu_virt_is_rlcg_read_supported(struct amdgpu_device
+*adev) {
+       /* rlcg read is not support in SRIOV with gfx v9 */
+       if ((adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(9, 0, 0)) ||
+               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)))
+               return false;
+
+       return true;
+}
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  {
        /* By now all MMIO pages except mailbox are blocked */ @@ -957,7 +9=
67,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
        u32 rlcg_flag;

        if (!amdgpu_sriov_runtime(adev) &&
-           amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, fal=
se, &rlcg_flag))
+               amdgpu_virt_is_rlcg_read_supported(adev) &&
+               amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 false,
+&rlcg_flag))
                return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);

        if (acc_flags & AMDGPU_REGS_NO_KIQ)
--
2.17.1
