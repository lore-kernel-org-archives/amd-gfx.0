Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A8AEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 06:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4BA10E0CF;
	Mon, 26 Jun 2023 06:03:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F5410E0CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 06:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHn44ruHAB2cOBiro84yjLDpeR/X380eQ4NGZDJpP5/AOtwpwCuJ52xXv8NLoZk+MewqMzSoZZyeEf+f5wEKXU+4aHOvkn93q/R4FCeiOGzRtdJQmRT/y9ptVZv5EwDmkqQbDENefGhpw41wYCEVFXgYzhR0gVAv8HHRAA2k5lhVM0Oo7RCAaVqaXr17sj0baOik/Uw+FWP1w1d+t9CVJlih7fBj7Aeg8+GzMRssAF9ZfEZgVbZEISZwOy3uhR7ppod5yI7quSaVVVgEyYR9ctyxQYElEOwVF7cA1r27V/K+numdJ8vd/EoDCKTFO0jxA04V+7xHuC8xct+dEHb2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY9OSXmZD6j5fE50gqJdB5QHa/hlLKaWjDIDrhb3+tE=;
 b=CjT4U1LoZPXMSQN3Qnca6mfqvjFAaRHf+Py5ePcyr7+oLyLOrxRb72tPNkve38oYJGfdHpWmr2ECPERZ2gImTsJHFe3cxNi8TYmdlqySUxFswh3hKi0Ze1h3mB23CizE9lRwOPsWDpWznY4tcryWWuiMCoKA4NBDGa5bZDhdH6dDGU4vNkoKWLgNRSgQDXfKWfXK+YB8j2lz7KA9YezAc2e+GJYrABfi/aWu+Rnc60qf+3QtyPudRepASvwkZ/PvqNoXvjD28uXgb1Bekgc2ac0nA4dKvGCBz6lnn0eIIsz0UCUE2ObQC/a/6ZjGENOrSg/Z2gIHI/P/RRFOu3DG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY9OSXmZD6j5fE50gqJdB5QHa/hlLKaWjDIDrhb3+tE=;
 b=bkO1rXWgpSBBEjto9i3/hsTXlsD7JVXJR3iutDb2Gn2NM3y0z95fdppnzY55XxBsbPi+djwyOa7nrtpf3j1jF/+oyajFNv/hwdIESVidX/4GmrQkkO6YQlafnkvEcsowBP2LgErJVxGu+ImNcs2eKmtFI/oyde7UsVg5h36KdOM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 06:03:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 06:03:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: gpu recovers from fatal error in poison mode
Thread-Topic: [PATCH] drm/amdgpu: gpu recovers from fatal error in poison mode
Thread-Index: AQHZp/CfipRBl8XLZUuK7K1fr1JTi6+cl9dA
Date: Mon, 26 Jun 2023 06:03:24 +0000
Message-ID: <BN9PR12MB525763D694EAD12381FAD582FC26A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230626053912.1864767-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230626053912.1864767-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d8135bbf-11c5-4999-a491-95b2fc4f8d00;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-26T06:02:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9182:EE_
x-ms-office365-filtering-correlation-id: ab54f80e-ef4b-41b2-f49b-08db760b0d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goTq5W+dQ74pCzU3auCppNrYYQhkXXKOIf68wxtBW5uAlrDkF8ad8rLYrsaNvoGzbprTU68+BfYL9s+2rgKIURtlb4Xoqkk9fSd5m2a62ErJUHm2S+kY9uyRWTs3Wrn8czxoubtyl4dwGy8+RmAtWfMqq2lwGYjR5W3q1PiQFxPPVxbMTuzxUmMkBvOn6xje7a1JkM0CPS6WA8uQo7104KV3Eewiqe9SDy87CblGuYWilgkv2WhLyw85BRbzpZSrpFCVm4yBB2fV+h2EPW8O+LydoS2aufYEJfz/RXITKXurDYyD8AQnhmcLEsdiZhgH3gTocOMqMd9s9kHBTb2PlAUAcGViigO+vh0zmHSua4gCNQPAqNJE9nbJWzxcNHz5KHOcQwjFoAjZQ6EjJAr5rukm+lzGQbsW5cLZT8V9wW+rN8BuqLxrNLVsdOCoQi4NMMoB9+7+727rAntPXDxenJ28rmb8bla69jmx0xZI3lgBkKAzqxiONo81XazAZyjtceRg2h3vn3S+bnBClls+2nmsrC8ZhE0XCen4BXtJWri++f3BjE/nKkKUYlfY0IpFDI2hFlrgqWg+xByGaHBurlfnCyoEvVqN8kN1OFe/Qo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(7696005)(110136005)(54906003)(478600001)(83380400001)(55016003)(38070700005)(86362001)(66476007)(66446008)(64756008)(33656002)(53546011)(186003)(26005)(6506007)(2906002)(71200400001)(9686003)(4326008)(122000001)(76116006)(316002)(66556008)(66946007)(38100700002)(8936002)(5660300002)(52536014)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Omn4kQqFezp01LO8w5E+4/msXxzUdhVuhreD5ItQ9ebzlua7yRJIZemfyxOJ?=
 =?us-ascii?Q?XHMHuX7ud4GZvNp+tdEICo5Bz5uCoHKB1tVNphGaXfbY8A7JYnyO6rjZneAR?=
 =?us-ascii?Q?gi+5Qc+oYTEwuSdR901AE/BonqM8YrzP9ChuGNVI7+nHaJh8Wx07tdPafG8J?=
 =?us-ascii?Q?ucHzz+X4Zo/ccIsHaIqJUVeCkY/4WQrOvOOKUoiRDD3SvtcoGLpd2pgwENFv?=
 =?us-ascii?Q?BPweYSqI69CSKFhB8cAUz65Ke5LWF7yYnjZxFofY1A8np4P+RCObv1Ku7dl8?=
 =?us-ascii?Q?kkmDj0BcsUlhsv6fGq3mwznKKFhbfPXTabyAjjmHqwN0qePOdeyEflIDvBFC?=
 =?us-ascii?Q?iJP1n9np/NxkJv9FQSUkC5Hdfo/d40p+fDxVvdVoNtAH4hZBa31Tdj5ERjMu?=
 =?us-ascii?Q?dn6+EJyp7jz7UEWmjumALy3TqEBFmRnYACV6/dfI7aK9cDFJFuAzvxNwK4Ca?=
 =?us-ascii?Q?EkWm8wzPhAj4Xmam8fiPmtQBTa6D+Mkzd8fTE93oZofjLvbJjRa1j+ioBtMe?=
 =?us-ascii?Q?NVUT5kBj03zGQj3psKQKkUoh8e99c7HOOxuoImeNZgtJ9WOS13bk15W7nCDX?=
 =?us-ascii?Q?4J8U0pusngBjyErxJ+EbCv6EBh/wv0LVIK3hJOAla1xa22CLzp891NHMSnJn?=
 =?us-ascii?Q?2O6tn1rw+3h2gtYHXT6VwUGgflm5P9lQIkuP566IP7W4Zgx+TOQn++axQVNM?=
 =?us-ascii?Q?SaRoceC0/w/tUpJeRN2LH6yNyur9Ummb1qvDpJffWZz4N88ZVREZkUPtLWcC?=
 =?us-ascii?Q?I2C8raaU44VKMLsIao9/QDF/M3ihYfmw3++coWTJoogVVpukP+xx01TghByq?=
 =?us-ascii?Q?dQEAtT7qYKOfm5m5SKC39GMgq0BgWIT5UzMqxPM2st1YbERc999XINXVB/Lr?=
 =?us-ascii?Q?r5apdj60RfASvluDqKAXEvMP3X1RWfO00jSYrWhApuqzKVxx4y3Ve1yAWl06?=
 =?us-ascii?Q?8RK8GXWFdAgvU4slRIAGgmo6zDWthbml45fAuqcyu48t2GYntfP14z9BhNNR?=
 =?us-ascii?Q?VPaTDrOdxQHBAELV0UsnBdyR66R0M09810EmM0KWmx4jwYqB8RpPHpPHjtE9?=
 =?us-ascii?Q?8AFE4uv5XEzhT1YJYDCWghwOogyW74OSQOU2xgJ9Q38PZi7e1Cm3Hon52vfI?=
 =?us-ascii?Q?KyR7QxFtMvEjxflA9xIYHNDB3F5Wpyok5+21NHVsQgDhRjWkybzM7QIV+UU7?=
 =?us-ascii?Q?2+dcG33mmxi05pjabjJKG8pMlYD7vnPTaN54XcmPSP0UGBp7DVcQCS/pft0r?=
 =?us-ascii?Q?oB4YyyW9eYamnD0xqimx47IW8KHR9i5ZxfP2gAlrZkMcT2+rYONBZcLV7JFd?=
 =?us-ascii?Q?wzHRz4XgE3mu/dOTrcPj1tWj7NUP5Hs18XcoUBPZF0lFn7FZ3AbqP5ufy+5O?=
 =?us-ascii?Q?ApqSmhxQatwKu0e52aTU1q9zmwGQDpeTo9cKM+05CcN5IfsH7SAjAJ9fLdI4?=
 =?us-ascii?Q?iOoq0U+AdgfnGWVk0Gw+lXNsz+6Ta8P+VEr2F95Uy9mRP1cLvazcu+ojEMSr?=
 =?us-ascii?Q?Ohatk/Cc6F/Dq8CbhXe3y6LHqsTeuRz7Ak4SQdkOZ/oxer651jLPKEVv5WzJ?=
 =?us-ascii?Q?hX0tS8jLGu6NJ7pExgE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54f80e-ef4b-41b2-f49b-08db760b0d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 06:03:24.2714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjrH3PGG3OWI+37lgbcLcDj+F/XLIIENZDZ+aoyl/sfngp3tROFCU06a5t0IcavXCYRyUA086La7QK0yU8bLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Monday, June 26, 2023 13:39
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: gpu recovers from fatal error in poison mode

Fatal error occurs in ras poison mode, mode1 reset is used to recover gpu.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++++++++  drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 700eb180ea60..c6f8b6b50b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2065,6 +2065,14 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                                ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE2_RESET;
                                reset_context.method =3D AMD_RESET_METHOD_M=
ODE2;
                        }
+
+                       /* Fatal error occurs in poison mode, mode1 reset i=
s used to
+                        * recover gpu.
+                        */
+                       if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MOD=
E1_RESET) {
+                               ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET;
+                               set_bit(AMDGPU_NEED_FULL_RESET, &reset_cont=
ext.flags);
+                       }
                }

                amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);=
 @@ -2956,9 +2964,12 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device=
 *adev)
                return;

        if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) =3D=3D 0) {
+               struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
                dev_info(adev->dev, "uncorrectable hardware error"
                        "(ERREVENT_ATHUB_INTERRUPT) detected!\n");

+               ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                amdgpu_ras_reset_gpu(adev);
        }
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 46bf1889a9d7..ffb49b2d533a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -340,6 +340,7 @@ enum amdgpu_ras_ret {
 #define AMDGPU_RAS_ERR_ADDRESS_VALID   (1 << 2)

 #define AMDGPU_RAS_GPU_RESET_MODE2_RESET  (0x1 << 0)
+#define AMDGPU_RAS_GPU_RESET_MODE1_RESET  (0x1 << 1)

 struct amdgpu_ras_err_status_reg_entry {
        uint32_t hwip;
--
2.34.1

