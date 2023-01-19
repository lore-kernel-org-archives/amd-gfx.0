Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0C1C00A5A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 06:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EBD10E8AE;
	Thu, 19 Jan 2023 06:41:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DA910E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 06:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azwqJw+M1n+qvELWH3P3XgkpYxNrIFbXm7/UCMMsurC1DtBu5pTWI6xgDe6va1Sn6lURqv5MH+JXjLZcMmcjp0pliM5h3Leo0Sjl2cpXjHpMZ1uQTzNX+zip7qPzyWrk3D3KFL9GDmisB2CoUIcz0qQ7W7lBOjFNi0eJ18TTavaN0I/EuFe3L7pxGXafzX4M20BIwOqP1I0iQX8tBucgBVg5G6bAPuHiGDUWp9hJlTeU4QrLebZvxnChqKDHYnfGqSde3NTHf/nYyR7Dj6YJIbG3mkPyg8gnsUtlnplr2DJIDsIvqLzsknO47OVXHiyXwYK0nhCmA2XMYjTgeKao4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzGqj3RBpO5y9ZB9cAFcCrMD7eqhEdv6NTjc264an2Y=;
 b=C55tWvXHsJgZHSP8b1FlyAHfw+6KQT7cDV++HCpz/b5u5Wed6eJq/U18dMPLMCfnrtSEccgfQxgtX39IsOsXxdwYpZ3omlTuO7s5qojwwA3E0HgjxR/pu7BpjLdomgPb7gyEkfGU+J2hI0iADs5RY5XJezUYgxOaIrrmeWCsG0oxG/W55yZGTN0ev9jEYHcmzNFjcAHkASSC1aKs41PHDcLJjjTDNdVrpx6Y+CxxHbWAXpmZC/xzueFoOVvkkLSD75ty4NBasfR6www2UP/bxrDzdWo202LHKB/V2Ns13lBKPD4z307Dl6LBAY7hQNVL+RzYc1zNtJG2Cu4Wwyx72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzGqj3RBpO5y9ZB9cAFcCrMD7eqhEdv6NTjc264an2Y=;
 b=UvKiZAwdNEG1f2rnn8w3yaczlOOVADznFJm7I5fWJqyR5sVjUjET3L8jgXM/BEAoij0oIEUGJj4IR2cPctiZ8957vje0FNKHEbzI9+7RTwpmdR6fVLVgVLj+uAUCx77VvslMIstjIaeymHGbh897ukcliIjTp4MHt6fm5n2MlMw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 06:41:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 06:41:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: retire unused get_umc_v6_7_channel_index
Thread-Topic: [PATCH] drm/amdgpu: retire unused get_umc_v6_7_channel_index
Thread-Index: AQHZK87uJynaRe1iH0qa/kblK7wcWa6lSk+A
Date: Thu, 19 Jan 2023 06:41:05 +0000
Message-ID: <BN9PR12MB52577807F549BF61F9E1B73EFCC49@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230119062550.6681-1-tao.zhou1@amd.com>
In-Reply-To: <20230119062550.6681-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=62fb81d1-adf3-4cd7-bc9e-e2fad555f33e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-19T06:40:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5157:EE_
x-ms-office365-filtering-correlation-id: ecd76337-fe85-4aa9-576e-08daf9e823fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raRBtzFFQk0iaZMUESoJSmLSLFi6s8fONTMGdZC23KaR+RbkCUyuwrQ1pw9LGGB01Mow9D5g0q8EmrDF3TVBvXpCOASIcyRJvFrw03punuCA+YIYwcu8tDhUcSalgxwST36DZVvFGD7htcOs3ksvtnFusWnaYMMrMQDXTUKycUfvdMcFUkrl46Y/dMm/nREekdElXt2FgSL0+LRVsRl/3ftzh4sCcAGr0T1Q0+OxZwvNLeVYp4b925SlwO3TiD5CtgGz2fxZEP9UI4wtD3FeNtEpg0u4EtW9tKTV4RFS436ErLHb/+XpbO6l5yOqkmXzUEVr5DJC+KXmboasFOWDhKTSL2n/CyQgqbm9tZ8++VjfN4ejnK3hBb03Yfu8EC3aouwcioLNw8hPmnGhUTKTZExstEHyFTSQ090+2IZaHkkO68sp51KM8YiQ5u4ig/omxWCIKRd/zelStpuyh46qUutw3SugXUFy78PFP38IH6ZnPW88qcSF1a2kDhvAIIc0CsFx3mJUf7D6fZG1hbzGzTWe85/DBp1Lkx2EdiicteRS0jwbM1IsCAXtKZp7eSkIbCOjbpHZn1IfXH5/lrbyck6kI2lEwInSUgfysT8FmxUPL3POsMCsy2OtwXqEeOYKFBDrHTo/6Bwk9zZSET8OujscQ4LVbM2oNFBhRUPvhui2KvzMC0HuF6BNmd16wHXBxZhbCvW8xPZ2RhoEHG+O9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(71200400001)(8936002)(122000001)(316002)(52536014)(5660300002)(86362001)(33656002)(7696005)(478600001)(53546011)(6506007)(2906002)(26005)(38070700005)(110136005)(55016003)(83380400001)(38100700002)(66556008)(66946007)(8676002)(64756008)(76116006)(66446008)(66476007)(186003)(9686003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aCYJnNaeZ3kcmoHREX4i+3GRc9pq09I/ovrCr0E/80HPyufKtJYsjTyuqRKW?=
 =?us-ascii?Q?BBGMg87+y4k5OcbhWa38+TAmX6bF7xjW/fJ6HTZLMC4u+URi7dBYenAvyI3V?=
 =?us-ascii?Q?ivVd6yB3iS/jd3hk7vHU7xZkLV0SZ1Serx7zKgNKNp2AYYRpbKAMaIc54gsd?=
 =?us-ascii?Q?TkPJIZMVSi68bi/F4FGHrvyXG6mO98IjBbHXv3WPy/84Rdj3HsGoBJLXfPFO?=
 =?us-ascii?Q?XJ0hGMUZSVP/nXoVcnZInJgsyWamXNAIckrQQqamY2sCd/h1dqPcxbARgOxd?=
 =?us-ascii?Q?Qbp8X5IKD1YyRsw0VIQBZPIdKQIh4GHjRfjFiVz/mBOVgOiotzbg/I82BerM?=
 =?us-ascii?Q?rG7P8CG5eDb1dmSYc4Kiy2diA8ohL+KsNTX9FlYDIQqFEU+PAJrT4FpcZasX?=
 =?us-ascii?Q?Bx0A2p5XQ5fmzYB2LA3wIVuGEXD6MZfS5ohPszxAyHSvd+R6TAXqVgNrrQGU?=
 =?us-ascii?Q?g7pdtAaUs/gNJNuBRYfu8ft29K03byjZuOFRcJPKntkfRctXNPLoWQ1hr2lT?=
 =?us-ascii?Q?QUquz2FrNKZRoa6N+zz+k9T9Xx5zat+hA3Uh5QY+b4EqJXJoVDsXKP4D1a+s?=
 =?us-ascii?Q?hjeBR0a+CnCHoPWu/h2kuloMZDDyGT0ykBeIyPyuOLT2QKoSq/oc+vdczYTT?=
 =?us-ascii?Q?wBGVsTxQKBJTSnYMzTJKnzc2PTDCWkJ2Bc6yqPsP4iuiTSQMtJXtjsccSHuY?=
 =?us-ascii?Q?omBzf1u7cJcOSEFXWt6+VsAkCK+R6db8tacC2k6opnB7FV0jLVHsdIzIdPuE?=
 =?us-ascii?Q?I0abd9a9GHpBNZSgmK3tev0ldKnwPJQ49t6Rf7NexO5ZPSq3GNN4rYFYcU37?=
 =?us-ascii?Q?E6vaxbEAo8K5VODxIzonJHGDTqf/2JWeoOHz94fACTNLbJ42WduGpjwoEzOx?=
 =?us-ascii?Q?DLqn0aHSh+TYxIPmUdN4zVk5hDVsAO60YqLNpLSnyUQDFgT4O2xcaWcHN7uR?=
 =?us-ascii?Q?nTsyObQSViAuLYefToD0F1dck82/T5fjaND76izwocURPopiTSVOMtPYde8p?=
 =?us-ascii?Q?giF78v8FCQYEZWRqujoZom+ntoiURoveRK2d8APVuSjhA93XGm9C6OshzadU?=
 =?us-ascii?Q?JbkM3kTpYeLzS2YkQzbFvZGM/Tlli4BZbY/QfhzC/4j3f9wKmjZ4Hbfj2iGS?=
 =?us-ascii?Q?TlYKioOx87I41Qgaq6ZLv+URMamSPeoKYPSMUja1BAjZZrEov8bpxOxpXCw7?=
 =?us-ascii?Q?hM21RY4uGfXFUpmXlujo63sia3SMcjWrdIhvyH5oRmqzQrV6vuQha6+zy1EQ?=
 =?us-ascii?Q?o9JsBR2mip/Fhzmgd000kWNARTNPK3fCyMY2CH8Mc85P9e4lMqrrZ7a4DvNG?=
 =?us-ascii?Q?P7y7PizgwgXm7EVmFU7WGtUZqHP9lNh3QxMhJmvg5udqz74CnIg+LYEuOi4h?=
 =?us-ascii?Q?eWbCeT0+p3YMhoTm3mYAcfBakhMNWFqctv6MIP4PS7VEIv5vliMf8wB1oRms?=
 =?us-ascii?Q?P8VMkrizOKEnRpEZafdREkaZ1vY3Fk0LR+ClAihhzeKnq53jFajCL6qbpywj?=
 =?us-ascii?Q?Z3lI4td9LpHn1pPhLL79jwsWa+roIToGkCw8/aVm+y0GF2RnotjHx8Q3l97Y?=
 =?us-ascii?Q?tGMBu0JhPmsg8EnEuOY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd76337-fe85-4aa9-576e-08daf9e823fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 06:41:05.7371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxKUqdLUpioNDA8eW26SQloGeXKoa91RJsPLwrw1iDQiEKGeFpD8VqQo9df296ZNH4ohN8XKsd/DeWfWoghMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, January 19, 2023 14:26
To: Yang, Stanley <Stanley.Yang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>; Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: retire unused get_umc_v6_7_channel_index

Fix the following compile warning:

drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:53:24: warning: unused function 'get_=
umc_v6_7_channel_index' [-Wunused-function] static inline uint32_t get_umc_=
v6_7_channel_index(struct amdgpu_device *adev,
                          ^
1 warning generated.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 72fd963f178b..e08e25a3a1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -57,13 +57,6 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct am=
dgpu_device *adev,
        return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_=
inst;  }

-static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *ad=
ev,
-                                             uint32_t umc_inst,
-                                             uint32_t ch_inst)
-{
-       return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_=
num + ch_inst];
-}
-
 static void umc_v6_7_query_error_status_helper(struct amdgpu_device *adev,
                                                  uint64_t mc_umc_status, u=
int32_t umc_reg_offset)  {
--
2.35.1

