Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D07C48286
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 01:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBDF10E8AB;
	Fri,  2 Feb 2024 01:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+Tl3cdY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0F610E8AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 01:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea+WJfVd1xcEcTlw17O6E5n2paW8ePXdND2d3aNk3tlvFlYzsVXECiuMdFadKwdgzVjSCJS9TtaYPQ+scWmIjsEOY1zNmIB7SjopH2s5bTlh9A6gqmutCmmnilebXWkg/GIxzqwTw971meOUG9BY49QYXky8dE7Qpjox0u/JnPuta7w7tkp7pVSFEskorEuaRfypuDfxfmRmMQHTf0/NGjvxHBsaQsDwQETkOmkj+sEvdBrRt5IMB3BqKXHh8NUDF9Qr6TjTDq+r63ueMhl2Ut7HUvwTH1aknaI0eXFw1ixxJHyEVbVypYoGVCFMkQ/sWPgOys0K71l0ZuZQMiX0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFfhF9rE/+eTlOrhv0q2zXdmEoifaQCo0zbYUT7paUU=;
 b=jaccTnqG3NrAX8VpS3UH/0SQPl4U7sM+t7vj0KQ2xMmB2ZlY8yCCvqVliH9m6tPJ95kKUh1vy07RGn1rQKIv819fEBW0uTWiF9hUYe/XEFkV7imx/yNv0dA6DMZwmYuGteR0fQrCJ2QwYkbCha5eVTJ37gOZ1fbUz+mD4zxvwgR6PPhOkpFs4rK7cYidegghMZQUilMZmiU30W/VXp/C9MAZCF4OrxSUERNcSaPR1nDgW5nNCvQtiVABLjjn6dwWJNiq+nghDltZX4Qk6U32qF9ntGTm9fL48Xc0Qd6vvwGaIvGhWnWxw9HTV5Br0pKJQ7EnVeIDok7Ano1H2vS6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFfhF9rE/+eTlOrhv0q2zXdmEoifaQCo0zbYUT7paUU=;
 b=i+Tl3cdYE6PFgFsdFmN+kAu5MTRD3GWySZvLU04n2Gx0LtX4igK+Yl6DzW/Yr6itFZqcUyjLQuyrGhufR5Qf8IYr99hzP3QbHXxUeKeU4SK0uowEZ5kNGhXGjtPIOPXnDpl+2MD65thbp8K32wiqS70Fy0c32H6cij1kN8Dlw5g=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 01:22:56 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::8f27:c25e:db39:f8b1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::8f27:c25e:db39:f8b1%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 01:22:56 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Jamadar, Saleemkhan"
 <Saleemkhan.Jamadar@amd.com>, "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg
 4.0.5 suspend
Thread-Topic: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg
 4.0.5 suspend
Thread-Index: AQHaVQWo7bzO3JD6ck6LtZAN9/Yi47D2Qmww
Date: Fri, 2 Feb 2024 01:22:56 +0000
Message-ID: <CY5PR12MB6369280B950FBACE95524B6EC1422@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240201115430.4180149-1-li.ma@amd.com>
In-Reply-To: <20240201115430.4180149-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4c90c289-2048-42e9-98ca-c8f17afefaa3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T01:22:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH0PR12MB5608:EE_
x-ms-office365-filtering-correlation-id: 716eb1a7-c583-4ce1-94b9-08dc238d7c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rBxDFZES6orPkRdiy2+d54+/jU/wn8dsfLEjuyx8Qw1sZhRIPjQaLAoYT1IJ73hvkZ8GTaaeIEKLIZyemHskOaGI+MWNryzvVOBvJfsPQ8zhb8QeZHSfHHIS74+yl6FHWDW4uHZdLme4ShbPGeOqo6Y28G6WORroPn8bLs+nwWRJKIvSwS28QR4YWjqF+Is7Y9RzLSGzKU0L+10kVOxV8yz8BR9/WFcbzXG8uw5cSDO3pCcVHoUqICGbR7cB0EmKgPTppXIO9VUrVV6bzVHNzOmVaz8qIUhWbzAd3o8whIoXaJ8k9vusNVWXshxIOVY4L9xSgbf4CK9CoXj62mIrtlfb+37THVDCxP3XPDcKWXlOa3I7zHdLFRi/3wG0t67QYbEcN6FOIYVCPlskSDx+wkGoSE1Sw6hKIj4bS3hWQm8bBRP7RmG3Fv6/Wmegu2X+n7qMb/XYM12NrtE9kLwlwYHoSWKyVrC/0yriWlAcOBLEjvuoiR8cvPu0n8c7HiKbSI//42yeM93ZhfscJgzt6CHvkVHADmJVOEbSVMQO2+Gi68sfJNCQiZtwzzTm7FcEnd0D+CGUAf8fjDR/ZBx9LBWEQN/ebKfqpvs4peLr1pjq9aOEd1wwNVg0JG4iHFRQV22qCCHE7BCpG4mK6W/dW3CoE9JdEaa+9t+QTpphwVQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(9686003)(38100700002)(52536014)(26005)(76116006)(478600001)(4326008)(15650500001)(71200400001)(41300700001)(66446008)(54906003)(66476007)(66946007)(53546011)(6506007)(8936002)(7696005)(110136005)(316002)(64756008)(122000001)(66556008)(2906002)(5660300002)(8676002)(33656002)(38070700009)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4NgKF58Wp/jiT52HKJP+w9HI+BVhQ38TeHgOMR/8e+zfSl7IPor526JsAKs?=
 =?us-ascii?Q?Vl8tKpX4UnwWtN7VSuZXsrMP9eM4uXcTPPG/VQ2MBkEPGkFj5oxwmS536WiH?=
 =?us-ascii?Q?LSm6JtuqiO1wmeNY3k8IlB+WB4V4ze35QSuRxounZ2J8u4UnTKExOwMw+ut6?=
 =?us-ascii?Q?u1KWPYKKsFE/V27t28/L2/fqYMrdH2qLLOEAlrVwoGpW1Rjq/4C0LTK6z8kA?=
 =?us-ascii?Q?L+T8uhlkE01GSUZom7UnokimGTSQdBO50l41k7pnsA3EDZ5eZSZqJcPYgX20?=
 =?us-ascii?Q?aoC9iiRL0SAcSi4rUFYLuID9xj3H2duVjCiFboQ23VKRCFBQ3ZssNTa02r1z?=
 =?us-ascii?Q?MlO6bNUEQ4Ihf5zlJ+7MzwKHbALLmfxC68Jdm05GXCuSIYjdveP9tiejxffh?=
 =?us-ascii?Q?bhAQLgptanYioENQw9nJTwiAUSqBzs0rX9NLQQmhFBZikZdthdI0NBOqSmcg?=
 =?us-ascii?Q?L5vdDMO0gEIb+HOWX4DKbQSwtS4YRuKdJsFZWzo3CVUxOWN+nZ8kmfFYq9Lh?=
 =?us-ascii?Q?jlTcuBg49z7ni/C7/nEIFGJdSn1pzYA+xW70yct76cr0dP0gRvJz4ye3hs1Z?=
 =?us-ascii?Q?7XSJO6WBTu5RYYlkBSZ9y4rLmqZ1K6//KBu441me2EX+mDCclLAWnFyTCwQt?=
 =?us-ascii?Q?jzWCR+kjPpDfIruugnn2NVJtOyOk2ffIjNl/Jygn2jhrgDCJSiUPPXU1793U?=
 =?us-ascii?Q?dSTDG6Q0b8Zl2YY3K6AJdtFQx7xRo9H5dKdnoLoKEe82pVml5jyQ4AxqXvtd?=
 =?us-ascii?Q?TQapkmPLtXiVztEQ5Kjmd8dW1aVBqEr5rBJFawmAlcdJbuXmd1zAwM5RTrBi?=
 =?us-ascii?Q?w7PQGrPzvo9GxovnlouOue1puVa3D9Y5tAj8Vcnl0MWqr2xhMuuku+JvQCsJ?=
 =?us-ascii?Q?bETywsa2ugO1kruTf+u+tSScv12sPXrNJFIG6TsFUhJtdU59ubjb8RChOQEl?=
 =?us-ascii?Q?AQgOivqyTCs5Xo6QMIR2PL4JoieuI2696bsGw7QUiQ61m9gaFB5crl1imF8z?=
 =?us-ascii?Q?0rt/YReyWcvhf8FojKJctqH2VcKsh/BlXWDXAVLNL2aHNGVOhiFj/vWYlv7Y?=
 =?us-ascii?Q?TQ1qncEBr3v9UdXiCd2tCLYkX89sIYTv7q+DXqktk7MqQqQ1ig6bgaIaJNk4?=
 =?us-ascii?Q?xN/RxEEWnMHnr2bL0PQXma1tfT4NXAHaJJR63PIh6QvZnUDYumR5DJhZnpg7?=
 =?us-ascii?Q?X0VmqgP6nCvvCvMmUxIGPkUcCqo7aReKZe13Q1/FiEG9qd7CXzMbTbpfKAR4?=
 =?us-ascii?Q?qA3lrVVpZ3DIB2PdW+M8A8PQJGX8E08UyCVHjzJsvs4CvBOCHUEBs6o3ydtr?=
 =?us-ascii?Q?33dgAOlHk020OxhBBzYdaJGFX7bMamBfQxMm5y6A25cSlxxljelFzVuHO35W?=
 =?us-ascii?Q?rJyLjfD+Hkq47zP2gjAQJtkNO2JtCnYlvkRxnsn61lliRhIDfquYiHKK+HpU?=
 =?us-ascii?Q?LrD+Ttsm51lCSgH9Xj4gH6eRh7riXsrBhjEstejpaVxcDU1NrQ3KSL6Yukcs?=
 =?us-ascii?Q?GTpVN+k1G0UNFTWSwBpyedwdWM2fieROeIhU/+zlu7uNVJzREhwtxHKCNMrg?=
 =?us-ascii?Q?dConF+I299pDkQc9wMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716eb1a7-c583-4ce1-94b9-08dc238d7c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 01:22:56.3907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqdZ5HKay36wVhEdP2wrA6tFtGSrds76FhKWQn8TEvNwTsAMzbZJwv0Ph9h0H52q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Thursday, February 1, 2024 7:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jamadar, Saleemkhan <Sa=
leemkhan.Jamadar@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhr=
an.Gopalakrishnan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma, Li <Li=
.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg 4.0.=
5 suspend

A supplement to commit: 45fa6f32276f7ce571227f8368cf17378b804aa1
There is an irq warning of jpeg during resume in s2idle process. No irq ena=
bled in jpeg 4.0.5 resume.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  9 ---------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index bc38b90f8cf8..88ea58d5c4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -674,14 +674,6 @@ static int jpeg_v4_0_set_powergating_state(void *handl=
e,
        return ret;
 }

-static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
-                                       struct amdgpu_irq_src *source,
-                                       unsigned type,
-                                       enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
                                        struct amdgpu_irq_src *source,
                                        unsigned int type,
@@ -765,7 +757,6 @@ static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_=
device *adev)  }

 static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs =3D {
-       .set =3D jpeg_v4_0_set_interrupt_state,
        .process =3D jpeg_v4_0_process_interrupt,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_5.c
index 6ede85b28cc8..78b74daf4eeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -181,7 +181,6 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
                        RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
                        jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STAT=
E_GATE);
        }
-       amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);

        return 0;
 }
@@ -516,14 +515,6 @@ static int jpeg_v4_0_5_set_powergating_state(void *han=
dle,
        return ret;
 }

-static int jpeg_v4_0_5_set_interrupt_state(struct amdgpu_device *adev,
-                                       struct amdgpu_irq_src *source,
-                                       unsigned type,
-                                       enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
                                      struct amdgpu_irq_src *source,
                                      struct amdgpu_iv_entry *entry) @@ -60=
3,7 +594,6 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_devi=
ce *adev)  }

 static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs =3D {
-       .set =3D jpeg_v4_0_5_set_interrupt_state,
        .process =3D jpeg_v4_0_5_process_interrupt,  };

--
2.25.1

