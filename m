Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D43C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 08:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2758410E5AC;
	Wed, 24 May 2023 08:47:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC4810E5B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 08:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdRjuX70gZBsWlgGYrfAB50gvaB67M6a/5Cj3dU6DdLu0v8Lcv0nIZN8XRxhvIV+fEtHrOARZ2Aa5d2tuS/xnNja6s34s9F1+XAx10fEpwhHE7vs5Lgy5q/Zk/CSYIVCM0k8KZnBBnSrEVuECXF2mqYjATcVpPXepDFFva/EELjxGATlufrpSmN+x/oBrBKCZLdY2yN4nIw8ZtfBrffhSvt8ntTFLvifCpKcq4BtMyGl4DZmj1Ov4PajZPxij6E9rbr74+nTtLDzUpOsf7t7gBrS5CPDwnAAfS4w6TsGsr9Cu+aKAn6nJPmR/Tw8X46YhWQZKhIO3QtTD7zZN5u2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ten4noEqfDTS1HwjMUhzHEdiNkXBE58VZwPUtI+t01s=;
 b=Ry6nlQ+wrimU9jCNtopOM1rY2ss7QTSPXF/t83nNkkI8q9+L8Xs+ijEeNHIArYF+WZfN9gg/SoRfFeE6hIKOfRqeTsQRzqDPS3JeTNX342idvTUy/eNRTRGfc7w1nwYXUqpX1PFLn0sYSkvgKZ4CXadJEmvMkoiTUUkQbRh7WdFmyvYmhf2WY4IkDTUNcrrMampXAQQDLXAWh/kD+khR8OiDPbkVReVF+KdwvJuII2m7nJIgVQvOlvSZuSVV/GEqCCt7StszgrE0MGRBdBy2dYE5i9nFg4oCw2cFAwGcqJnCnjO/4qFNEd5nsTz7ATlz486DdCBlzKBWUjI7oIcPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ten4noEqfDTS1HwjMUhzHEdiNkXBE58VZwPUtI+t01s=;
 b=hRMZGQ/hSYx0jttpNXiWxMcnEJJ/dXG/huI83uPzjepqHUDD+UvPiuP0rPTBfkB5SEoMe4fJdvw284K9Z9JBY1zk5EwRyELtb6Fl1tfKaDXCorX5pUbsKp1Mb1L09Xc0I2rcIimYLx7JOQrUBp/L5OtamHjrBnBborRqS33LVo8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 08:46:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:46:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 6/6] drm/amdgpu: complement the 4, 6 and 8 XCC cases
Thread-Topic: [PATCH v2 6/6] drm/amdgpu: complement the 4, 6 and 8 XCC cases
Thread-Index: AQHZiYNZ8NYc6s0oHEKi+fkVJUarBK9pJXLQ
Date: Wed, 24 May 2023 08:46:53 +0000
Message-ID: <BN9PR12MB5257B353701B9FFBC99208D5FC419@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
 <20230518122059.28815-7-shiwu.zhang@amd.com>
In-Reply-To: <20230518122059.28815-7-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T08:46:51Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c72cb075-65fc-47bb-8d95-29e6d7cf520d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5750:EE_
x-ms-office365-filtering-correlation-id: 359f4fc5-9a26-4961-51d5-08db5c336cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVF+JDLUjGyiCyGFj4mAliBu+N1yglYeGITD5XLOJsIbt97lkG7ee9KgXCLPm4KwXyWTfZhptmHXkk4lzZCOsZ5uTTWyKXfV26TcW6SVQEn8vxaSdQen05zvutrM0+zz+X+qonIOuoIUkmEL/6UU18yRKEhAdxBJ72r3BqhSJRaKu3m8aWr+3WkZc7zH85jAroyQBMuKNjLU3WLR5A42fwMS7IvtTi3zmY9FkvxbuTOhEGPnNuEdhk7uATLLqfqxFkgytHn6ao/XKCajAoWH/Y4ppCuxyg+hNNcLhcNTz4YIjMzz/wEgG/2mxClvNwEVl1VeLxm5vSZK2rEAJ78KRWtSNdX8LaDtl4g1bqFRp6R57jmOQMYwEv5qZPLuh7qIk8mW3I5WfENU9TJ+XJJyKErgzrM4+bkr+Oy5rtdCmPnkRSR8gg1AXWgoZ4WhMpBduo2bPrJKwAxpS8W6mcc2+PwiUAAExB6i8u7qlwyo2qzPZTwV2ZjRL2/PB2o/j8ophCFrHYK5WAKi0r3Hm3nBhRJb8eTjhpFr7PFVtPJKZr9/V8Ky/gVWfkwWEcI3Z1tZkec/FHSdXFaGTqXgyMpZ3kPZREvRP24X3rbLTCDGa0EqHBU/4NfOFY/JY55NMg+r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(66476007)(66556008)(66446008)(66946007)(64756008)(76116006)(7696005)(110136005)(41300700001)(71200400001)(316002)(5660300002)(8936002)(52536014)(8676002)(478600001)(38070700005)(86362001)(55016003)(38100700002)(122000001)(33656002)(9686003)(6506007)(186003)(53546011)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hxTpyyPGHKczvYitIhV1fUfnPAFnqbVR+BNm7w0j3NCETEFvMyKoLuc4NXbG?=
 =?us-ascii?Q?LX1EWGYE7fLApDq2W2PJq22r+w8cZ06026XjRwQ+Apa8N1T9luc13IjTuNA0?=
 =?us-ascii?Q?qLqY35JnWtkOsjVALiNusVYDvzO6RdpED+J5t6UaMkqzP0FfItbgd3doR6wa?=
 =?us-ascii?Q?ngqFUwS4Zdq2qeQzndP89HXqIGc1oiZuWsNH+KDUhnHYweJfdxuFTEkBstts?=
 =?us-ascii?Q?2Bno1WyqKsXbJP3VQ1O4OLIEwk7GfjqRyEe6Hz4r0xw0P/j+hWBOlx7QNFQS?=
 =?us-ascii?Q?0OXs4kvKwHoknCQoiyvqhvylMQPK2Zy5z6JmBajMizAH49FjcrTCm3/c1rB0?=
 =?us-ascii?Q?2RVWNdYKrE9rDsXq5aTOy7tRwzATe4GyEWA/C4yPoSxzeVGuwD7JGcCPDQB+?=
 =?us-ascii?Q?bZ9gAy6dTZZhXmiArEOAFSEceg/w6tkg5HQpwNDbMeBTIiCMN9+uSwrOCJ6h?=
 =?us-ascii?Q?N0zwvX3z+ot722fxm95N0DVTolFPLVTTFk+NT6pKVkAUfWt7yYzw2+rmwYUB?=
 =?us-ascii?Q?vm9CsxGazvePaXtw/viAJVgstrypR3zvrguYOSZJ3LblZ5uSTOxGlJL+O4xY?=
 =?us-ascii?Q?1SFSraFjN6bMsbxXJ8769EGjaBH8EcehS1Nq//ReCHdzGEdACy6CoKHyLHPu?=
 =?us-ascii?Q?eEme9JQDBVf1/BR97Gzi96qzXsNhtvIYj3FcJ35Dym9Vxa2nTpYdfSAO2KCB?=
 =?us-ascii?Q?n1uNlGxOAWLWc6gC8tb7nrhXu6LBY2zkgh+3ztcVh15D4LNyRUzvRJykyXka?=
 =?us-ascii?Q?T5VeooG65F0tNpiXqjxohlpumau2RoNaUbX9BBMzFO55P9zYM67dzY/oEk/u?=
 =?us-ascii?Q?L1x1ZNNiUNENzvKM6gN82xmv/Qm/uqobtNk3x0es3Zq/IxkiilIun2AjTnvS?=
 =?us-ascii?Q?P2QR9ZMjoqr90N7RrH35jrQhcerDwANqjPfwf9kWC7fuKcm5aBIIDEo1hPqQ?=
 =?us-ascii?Q?r8kInrqIdCeFf47A0MVa93nIoXUhPjNXOkYbX+6ldJwbniLI3ezlc+hlHA/P?=
 =?us-ascii?Q?8dojMXCWvZqfrKJa46S3gu0MxOn1d8qu2ZRio6JNYlt0NsdbJfsX/HJmzIXn?=
 =?us-ascii?Q?nEYLIZZ9VBybuqzyJqdSDI8XDyRH34yZEBKXRogug8YtT3w89Z9VJkvW1JtY?=
 =?us-ascii?Q?ZPYWRvC/5vPczbDJq2JhGu31uoyGCq5OvAJczyaUWdYSVhsRArV9ilMOPDQb?=
 =?us-ascii?Q?V077jBUdsUjWyYgqONXQ5QjFPqjLVsCOyqtc9nHIt6eaQTVPt6Y0Pbr4Fg7K?=
 =?us-ascii?Q?MkpWJTRADZ9Rr6RfUlKir2lBQ05reYnKpvKQH8Wm5NRq9ZRuY1KlYhrDKZsx?=
 =?us-ascii?Q?RP/kkP2CR5i74YMzvVjMMG1MmE2MEVgJSJQHM6sfGTP1iMLPY4jXRFWxpr9c?=
 =?us-ascii?Q?bLsTHy0OsFHrn8Uj7GPdSa8XO31OUjz1UktnLDKLImVqBpsrSfnMDt7aC5kI?=
 =?us-ascii?Q?o6Ws73lmlvX7UG7ptiLTAhX8yIQg3ODZnE00RYCnIUA/U7WK91/tjbd2xKKX?=
 =?us-ascii?Q?0cKJ9B1tC5D7tVQ10qq+KjEYqpDgP8+tcopTY51SdBjNHZq42e+rfBtmLA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359f4fc5-9a26-4961-51d5-08db5c336cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:46:53.9553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2e6vcIoiWtrvAT+L7ccrFt3gCq3VzJ7zeIPbDb8UFMHD1rCLmG+LOrEYevNvPOnWdPDGSOYt/HUoW86Dhjiw9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Thursday, May 18, 2023 20:21
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 6/6] drm/amdgpu: complement the 4, 6 and 8 XCC cases

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..97f6f854d077 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1031,6 +1031,9 @@ static void gfx_v9_4_3_xcc_program_xcc_id(struct amdg=
pu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
 		break;
 	case 2:
+	case 4:
+	case 6:
+	case 8:
 		tmp =3D (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_X=
CP_CTL, VIRTUAL_XCC_ID);
 		tmp =3D tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_C=
TL, NUM_XCC_IN_XCP));
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
--=20
2.17.1
