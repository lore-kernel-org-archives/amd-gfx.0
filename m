Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867EECDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 13:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0726610E3F0;
	Wed, 18 Oct 2023 13:13:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D4010E3DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 13:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPP8rQfLb/DiL0rtWlhPyXF1oEcGEDnnEXvj95g4feqsVjQ6LKNH0QC6y3oYLtvlG6qJu3Uh+iNwbdg1p8/gQrvjsZaFY2U4Eqvy8Z+XALD2PknmvAl0EA18FPpQ071btxku9Vi1fTbbmAwUSEmYJcbqi6J3mKq8mkFvm+aF1/S0H1vyGZN/HqKBVCbKyVLKqRvXsh63WFLrlkNwmfZBbZ8uzLO00p+VK8LU5myLlT+LTarI8vf3Jt5OGjfQEufNT/WIT4Y2T8p1RYmgIyzlZKQpMX8gNAYEc3hN1Ww/DKBRICEjIqtScjwGyf8cznvn022WaSAj6q8aVuyJoHUOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tovWK19t1G4IsTGRJyCdO9lXixNprRjW13Dhm/i3tCw=;
 b=NpAjYe/E0tBVRAz8LHTpLBMBJhm0HxR32OIriCO3AwrV1JfipQyYmlyU1lY6JHHWOiSA7mKO8w4etWoXUDf4q3/LjKaAz66z2sUJv5xyW4cB+q/FJ/PFXucxrGYz9khSDsfh8SqUDnPyWs/jMrmUdUgclhhFos2FTEJqudPc4B16FoPo/IDY5Yq5tlvyiMYL4HCzSZue9pmJmhuIUILB0dxK0c6o6O9PgpDgWXaOkDSnB9poTbPfIIEK2ywqiyBSle4Ku6z6S5ZPNUr301nXjJwkzZiQb+oXO6hkXveEIhUiGaE1ola3OI4LeEmgyLOjZMrBSH5KdMdtyLKq4ImCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tovWK19t1G4IsTGRJyCdO9lXixNprRjW13Dhm/i3tCw=;
 b=gFiP/sG5Xpv/bSxXJFmHJwoETSHqH/1gIGDjThqpX8Mxr5ywzKHcD589TqNzDKmHe966Z4PN0dO1TQGL32e0o2abVYg2Acph3huPfpU871MFF6KtSkzHZ8e95Wzr/WH6qqAYTaWL6ODkQJRLftysId7w5d6MOF1hFhSrwRG5uUw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 13:13:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 13:13:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Enable mca debug mode mode when
 ras enabled
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Enable mca debug mode mode
 when ras enabled
Thread-Index: AQHaAcSBDI0UB3FVoEiKOwid747LvbBPhiZA
Date: Wed, 18 Oct 2023 13:13:26 +0000
Message-ID: <BN9PR12MB52570CE939503DCCE3C6E08FFCD5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231018131017.3280997-1-Stanley.Yang@amd.com>
In-Reply-To: <20231018131017.3280997-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e70b5a33-64fa-4766-bfde-67adfdc0d8df;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T13:13:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5746:EE_
x-ms-office365-filtering-correlation-id: d2214fb7-c61f-4f68-872f-08dbcfdc03ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHbIsOmeEIzZYA7P22UzenSoGIHRJntrEey510bpupVr6YsS57LoHO9TZ9JbsKxI3PqJSkEp38owfSRGwJ6cpmPkuYUr2PhkTZXPATtjatgcWVaC0027z+n0NosPX0NTLCQxLlrbbD5hqrrglR+JBLOnqfkjhHNKJlnJ1cU5IBs0t6DzjXWTCe7bM+wcgK7Gaz3nhOmf8NrTMzuKWR4LJB6HaSICACiKCaZzRDasaw3U9Dvbr7DabDDIe03wvE+5pP4/9k4GPcthG5JT2eWKxyjeXMNptW2NLjMUAELkYEo3T4DGwEARtc3ZaxwvIFPkW+VddbgM0K4LfhE1KI1Umez9w85eEOerN/ECIgsx/m7z/lV7mdQvp35E2cDSXnHjGMxGUGaaYDQfK6+7OrbvnhlOXRgvx5/e/dwGSaavtXYmdM+6NUITRF8NS9pdfQNkbsacwR487NlzJfF5s5u3ynpo+xNQeKVpwEROrKO82LAWy2Qbnl90oNgF/o+eIXA3WAc3qBqz6CXaHfwm+pdEVBf8Ut7QWfPmdoelpYzLQmL9XHHpFKbO0h9oNbM8E/sLLHP7KU58awCJJEhjMcMs52c7XL4AwgitC+MDDWlaXtMoGPiSILwsgH877yZCorad
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(2906002)(122000001)(52536014)(33656002)(8936002)(86362001)(4326008)(5660300002)(8676002)(53546011)(71200400001)(83380400001)(38100700002)(26005)(38070700005)(9686003)(6506007)(7696005)(316002)(478600001)(41300700001)(110136005)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gRVzuDJnUhjRdtMDYGGelCpHWj75ddLnFOw+OrAyAZOxMQCymNoGhoVcSP3U?=
 =?us-ascii?Q?FUTJ/1AvnRrZBHsSF+aEs2yhnIib2gC0gj+OQJEid5XRLX9+UOPlAfIqHXIM?=
 =?us-ascii?Q?JLgQhRJoEQv6HN8EF2WP2YWmducH8q0uBhr6YXPDiBVFYP704VZaB6+RHDr+?=
 =?us-ascii?Q?k8Xmn1LFlVsbbosG/Gxvp7dgpvfwZ3rLM/jRDS+AHaVC7/ha8F7hpQgXfozV?=
 =?us-ascii?Q?V46sEnbG26q/ZOdz9Sehxx2ZGk2m8hn/BD6ysaRIpzEq3HoYu7C9XTgbnCge?=
 =?us-ascii?Q?FNgVTJosZgtlF33yvdyUfHnelXWgAqCBTT4RC/evNARdDWX3I+EaenZ4ijT+?=
 =?us-ascii?Q?TCAxQvWerqzpYGIqbZGRy9T/hGC4/IqJvJEUKriPmDH2wQKh4mUUvTk8kaxW?=
 =?us-ascii?Q?kd/AS/Nm/Cvq2Td7yyU3PsN2XW4/Baj5LK6h08uTeYYEOz8LlPc8U2jmvTni?=
 =?us-ascii?Q?yFKcros2XPAt0CUW2rmscL/ZLe0wa1XZQh1q1LNzYxp5m1LtCakbHbV1Wi67?=
 =?us-ascii?Q?UIl168zU2pL6Sgx7l6f2sxiex62ahb+1ZwHRMLsOzai2OYSYPbRJHtozupEs?=
 =?us-ascii?Q?5UCKVKKXUwbTgo2o011EdGZcgoDv+5/7p4phnqnJv9f+2ggGLRDvTwwICnum?=
 =?us-ascii?Q?zt40iuFhU4MCKDvkw5YUfyUPEu+K+keeGeL3R3Y4updGBYg+CIFRN5SFvbtR?=
 =?us-ascii?Q?chCYi2CSn1zelhdYhKSHecGuhtzLKq3oeAZfJelwf8g9hX1MzSC7dquX4nHU?=
 =?us-ascii?Q?zbSj2N0i2ho0MFyMET0cpJLm7/PIeJ7qz2VFOVguBu7KHg4u83DaYpiMjZww?=
 =?us-ascii?Q?wZBZa7rK/LG6/XgPGyxBf8M/FuvkwalmDrC4zRxbUID+7ssxH/YaDS71Yc+3?=
 =?us-ascii?Q?ZhsxVl16xn3sDRrHs9i3kcbvOTEOGJYd13orBXxMgL14BrAb240/WnrBS6Rs?=
 =?us-ascii?Q?sE8snT6axLObRGQVnPNlE9uNBzqQ6zPi8u4XAYY6EG2W+lyUF6CXm2cBzotp?=
 =?us-ascii?Q?eher3jNtAS8k9hbGTncvRXWGb1gAIZvvwa1aI6+STu457y1auamXIsCrDMkS?=
 =?us-ascii?Q?7VvDTBqZRFYYxTdqcyUyHcQBXwp/IQwe5EcuJ2h1IrhA5giYEHY9luMZUnEH?=
 =?us-ascii?Q?IlWGWS9S7sRmdb2YeUgEJSubQExtZ86AvqUtm6OWfYOwui1s6oPURqcVdE7b?=
 =?us-ascii?Q?v6+UhAJTMZh8PUpj0SPLG0xrmwivVE0AKCFLjK6c7ZqCdGL+oH/gJoYc1Sp3?=
 =?us-ascii?Q?IXETnBruK0DmgJV9FAlnelsSXRGhlPHiwhJkJ0sEvC/a87BWv0HGUN2Bdgia?=
 =?us-ascii?Q?Ygvam0ABmvXRBmoF2ZWDcxHCju3WgJObrLFKzOitkOff/+QD50eYTa9jzrZA?=
 =?us-ascii?Q?I42y7ez3dpvV2CI327bCd8TmSZtvlL+SM+Yb74fLkKJusb6ANLwftRS6tOOF?=
 =?us-ascii?Q?EsL30BeQ5jwQm01vBVrbxeEVIvot866Fave+n5bxaP8pTu9Xs4MWZzI0juZA?=
 =?us-ascii?Q?0Wggw2B3lNq7kRL9O6JQ42eoiOBfGWoL/2fpv4KBLH7uacjhHfZoDFwDZSSe?=
 =?us-ascii?Q?LBktb6e6txuPPMafgR9G0TEOK+sbfPKtkINOQMVK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2214fb7-c61f-4f68-872f-08dbcfdc03ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 13:13:26.8758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csAF8YfpNHz9Efn529gv2zHoUVSQNl/znY0A+hCE4iOCSxn4NoNdP1CETjC+baw1LgpJ32N3jfESlZPFsSDc2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Wednesday, October 18, 2023 21:10
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Enable mca debug mode mode when =
ras enabled

Enable smu_v13_0_6 mca debug mode if ras is enabled.

Changed from V1:
        enable mca debug mode if ras enabled.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cab5a5569bc6..89c63237e470 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2298,7 +2298,7 @@ static int smu_v13_0_6_post_init(struct smu_context *=
smu)  {
        struct amdgpu_device *adev =3D smu->adev;

-       if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev, AMDGPU_=
RAS_BLOCK__UMC))
+       if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
                return smu_v13_0_6_mca_set_debug_mode(smu, true);

        return 0;
--
2.25.1

