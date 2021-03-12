Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F78C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 14:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774A964FE2
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 14:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774A964FE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE936E12D;
	Fri, 12 Mar 2021 14:48:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3A96E12D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 14:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQEIS3K34KpLsoqX09kNm7KjHON03A2e1Y09I9/HrdhjsKXJ4jMatv3ax/dUQxY0qLv7kPUObOYhVLSqkTO9vtGlI5M4cyPU6EjDSQAb9DogRDcMl02AhmgAgFptoWghMSYmjBAkOgltJ4PNzm7xdqBAFPpGnsRxghBKTdnjYgpUhl7ukrye5rB0SVM2qrx3Qpuq12xs6UYH9YyJXFwXWljJSPRmsMZwicF/kWhlUdOXc5E6uAcdx4y6TDUH/aCfYN0aFsKHGza8THC+JSsi1DH4htQj8CSV6okaoZXWLl5s7VOOEeWkyChDNkF4ZiXAOv5uzWA2UBZZm8W0Elw/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45Vk25o5JYZO1LMiZ9eAoCRW7CGYItj4rafvVyeTj9o=;
 b=bw8Ui0fJQHcaMdr+VOSHCQ3msmwRp1TBa065DhpzeASP7+bN2mCDtzd+zha0akfWOQgQL7ji00U55VegrpFRrjg1OayhGaiNi+k63GKSqExp8ONTeG69zUc//8cStY1NBQ+qTBE6lLGP6muBrZsF+qI2J0ffdrwd7zhu6X7gmDKMAh0IqDoxiTCD0vZ9o3avFShNdWoBWAeP/MTEVPgV6l7ZPcH/uU5w/ipNXsOw893shAHwEHJXhFvPQ/dndCPZSY6pszhxsNzA+Jufl2NeU9eDIri3tz9xCEc3M3HFfVAxKLwhu3T3aZOukGe28GYuRojZ8rwzc4GzQTbClREXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45Vk25o5JYZO1LMiZ9eAoCRW7CGYItj4rafvVyeTj9o=;
 b=eg0L+514nVg0BDhRyv1AU6qNrgCrBDPng+vDyEhCjyzB5hGUev6TNnh6Wa7z90GmdFOJkt0/MqG31RBVlrZdfyEDl8KHbmt11p4pNfRPypJU/tdOWZFRG2cd0+RRyecj5prbmJKYJJ84P2s0fCK6yjSuWv2RHIqV/zYqQQnhyx4=
Received: from DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 14:48:35 +0000
Received: from DM6PR12MB3500.namprd12.prod.outlook.com
 ([fe80::99ad:984a:7f84:be07]) by DM6PR12MB3500.namprd12.prod.outlook.com
 ([fe80::99ad:984a:7f84:be07%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 14:48:35 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ecc query support for arcturus
Thread-Topic: [PATCH] drm/amdgpu: update ecc query support for arcturus
Thread-Index: AQHXF0z6Rz9HdRTDYkeSIoVbLrF+iqqAbqdQ
Date: Fri, 12 Mar 2021 14:48:35 +0000
Message-ID: <DM6PR12MB35008619DCC39A7DD5BB4E4FE96F9@DM6PR12MB3500.namprd12.prod.outlook.com>
References: <20210312143533.14863-1-Hawking.Zhang@amd.com>
In-Reply-To: <20210312143533.14863-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=10b6b27c-5d9e-444d-9e9d-586bc2e6debb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-12T14:47:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96975841-9b61-4c6c-7bc3-08d8e565ea1e
x-ms-traffictypediagnostic: DM6PR12MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB502407E0AC141CA8E6A2A79CE96F9@DM6PR12MB5024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiyzMZqS7nygGdTeBc8fKXEF6oEwKpLJpLa01loJZWCEaEXyz29SxdDiuG3TfdYPz7NwmP2o8L54xYgPC5HM/ib3X8iv5ysQPnUuFty/9qvz53kCfdXc9FiHp9yuMKmDHBYt1oXZXRyBUeTdBJmGUtmdPSw88y+r2zgJxvlgrkjoxtKPhu/XJ12egwSBmJ5MZ6ftwTZvYR7o8MbmIx4ZqNmzz37YSXS7NCpN5/FXcaThFMux1z7yF9XTHrwZ5etwE3vBPA794sOysibCA9fm246ngk/XESrnn2vvGPfTp9ZBPUZBSeTINwRJYMMzwyW7ebqL4tASuNGVOJr5sSkw8oWVe6QykgMABnxUIHzgQnlY69TzHiB1ab92EbGlcZqFKaLDsj4eVJociWoTEohx5QxSwsu+/VP0zNrzmPASV12n8omqAUvpbQvuj13+Tfy/hps6xc5mhkvXwDyGhjr5o75nG4s8FTEkQPeZAcTwsqC1thrUUG4q/hLHDWnUWWxwJwedPKNq5AZGBOUdU9je7H+f0IN4MHJCCe/Dn6UI8CTMJqzi6m7yXY4J2oXFU3aQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3500.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(366004)(136003)(376002)(346002)(53546011)(110136005)(316002)(9686003)(64756008)(66946007)(66556008)(186003)(52536014)(76116006)(66476007)(66446008)(71200400001)(26005)(55016002)(6506007)(5660300002)(7696005)(478600001)(15650500001)(83380400001)(4326008)(6636002)(86362001)(2906002)(8676002)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kHsQlqF2TK/FZRxWP8VZ8SxsCaqYxGiMzaeTidzviOy6jS8p49sFipm71hSV?=
 =?us-ascii?Q?v4YPFHqoQEIFoUU8YXzuQZUdHb6eS+DtCkudzotjoGQeIVwXysI59eyc0Bg4?=
 =?us-ascii?Q?ZVqa0wZc5zYpkPOIwHRESzRcoiw0O/q9McCu3KDpB5LRJ60hRNH7pIMpp9R0?=
 =?us-ascii?Q?DsxnpUSDI4iUiJnBZuGz2dPHQzQot0s0V37gB1IkPItgwp4BYDopGYxWwLVm?=
 =?us-ascii?Q?cWWCynHfEGvoMv047aN37nXnT4h4k6NUwgUvqiPxTUtoykeSwtScujpCF2yW?=
 =?us-ascii?Q?BrQg2PkwNJUtfTriO0e2YOh7C5a/qVpYlGxpjqrXMezlhlPrVWzAx6sjk/SO?=
 =?us-ascii?Q?Szfv3ZUNB7rfnur7cCnaqxkg5S8X0Bx76Q7qc5IrM2Rd/4evdatlgvkE+6sY?=
 =?us-ascii?Q?OMYjN7tmMaOfb8SzsxSpmOHlrNfU4lCew4SeGu4JseBL4jVEf6VXOQfkyYqJ?=
 =?us-ascii?Q?KFr/g/yfxuSlHwV9zN4LC04qMuOboGTXJjFaiNvYf0P3yKAX+ALH6NNXTyAU?=
 =?us-ascii?Q?/v4iiPdMBRJgcYT1LpTAiXjBBMWH5S9/wOdAcsfp3r7BiZ9oIuFh5F+Uorub?=
 =?us-ascii?Q?cSk1Qtzjlm2juDyy840Zuvqa6JR3BG3tFl6Ieu+6NIMebajHTEGDwHrdcfwf?=
 =?us-ascii?Q?V39OvDi0gUSAw3VNIHojkZDdDXz0Kklq6i4omgyljrCYgFThCQ1vuDUd+xXE?=
 =?us-ascii?Q?Ld4CGMHf2cVxJopG4y9U59oUBbxBWNnT+kOz9YIzA98g8VZjoE9ySsUWImB5?=
 =?us-ascii?Q?MvDn92uei7pq4vuOwX4hpFo37pXk0KCzpCh8l0ZX8KoOVsoO5ovsGDhzMhwT?=
 =?us-ascii?Q?Z3Na5JQ9EGn8rO723PAH40fQPkJ1Y17LbB25p8unLZfIBUlnmxPA+3zIqX41?=
 =?us-ascii?Q?JUgkIpblSH21NO//jW6eLWZ3I04IV9egu09nHkgECKicZMJdwd3s8SpInOOi?=
 =?us-ascii?Q?53xnL9UJwh7BRs5WtacWH2SQCHXbUSdOXu2MRaA/Q6PXe0jK5ddIJsqDLROs?=
 =?us-ascii?Q?p6GEknu2LZbolRJHE5PbHWE8murgcXp8LhnFwoCf98w2yNocz2WZIX8k583K?=
 =?us-ascii?Q?NXjN0h2XlRHpUO6DO6/CgF1p5e5MtFtwKzAVyVED9a4CDyZON4AjE9Ehhbuw?=
 =?us-ascii?Q?AP1TE6wS5ZE/0il8jR439G/obxIajviIWBpdFXpPcmwBLXhe3MNPJgZX9cSo?=
 =?us-ascii?Q?zLhYU81WaLC5y7UH0oi/Qmpbx9IY8d4AmbkGnZSQuFPZa/bSao3GCiMqZTqa?=
 =?us-ascii?Q?iEU73DwnaubSK0OmCbUbcvsxqbjw64lu+oC1iqUHyPFSP0DHn0XWlV50o41S?=
 =?us-ascii?Q?eBlIn5MhS19z1Cx1KjhOT+2J?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96975841-9b61-4c6c-7bc3-08d8e565ea1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 14:48:35.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOCEuQnjvZJc0snYK/p6ueBHeRT2p5pGHpR0Cnd4kz2czOxZP+z7P7fnQ05YwyBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch looks good to me

Reviewed-by: Frank Min <Frank.Min@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, March 12, 2021 10:36 PM
To: amd-gfx@lists.freedesktop.org; Min, Frank <Frank.Min@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update ecc query support for arcturus

arcturus and sienna_cichlid share the same version of umc_info interface (umc_info v33). arcturus uses umc_config to indicate ECC capability, while sienna_cichlid uses umc_config1 to indicate ECC capability. driver needs to check either umc_config or umc_config1 to decide ECC capability for ASICs that use umc_info v33 interface.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 2b5c823995f9..60716b35444b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -361,6 +361,8 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 union umc_info *umc_info;
 u8 frev, crev;
 bool ecc_default_enabled = false;
+u8 umc_config;
+u32 umc_config1;

 index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 umc_info);
@@ -372,19 +374,21 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 (mode_info->atom_context->bios + data_offset);
 switch (crev) {
 case 1:
+umc_config = le32_to_cpu(umc_info->v31.umc_config);
 ecc_default_enabled =
-(le32_to_cpu(umc_info->v31.umc_config) &
- UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 break;
 case 2:
+umc_config = le32_to_cpu(umc_info->v32.umc_config);
 ecc_default_enabled =
-(le32_to_cpu(umc_info->v32.umc_config) &
- UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 break;
 case 3:
+umc_config = le32_to_cpu(umc_info->v33.umc_config);
+umc_config1 = le32_to_cpu(umc_info->v33.umc_config1);
 ecc_default_enabled =
-(le32_to_cpu(umc_info->v33.umc_config1) &
- UMC_CONFIG1__ENABLE_ECC_CAPABLE) ? true : false;
+((umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ||
+ (umc_config1 & UMC_CONFIG1__ENABLE_ECC_CAPABLE)) ? true : false;
 break;
 default:
 /* unsupported crev */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
