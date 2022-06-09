Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9390ECCA483
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 11:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F45411AC8F;
	Thu,  9 Jun 2022 11:23:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA3F11AC7A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 11:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9FknhV2cbeF39XygYuJM1h1c9ggudU2ID048UY7zPI3JDhoHwDTwlJZPuZEZ7PSGxPlfu02LR4me8U6LphlMkvIJjDKQfqvPKWwDfM8ONzEk3V4moxkyM9VL3RgbuPgG7+CDiFp9vJUt5MXzB4xlcPokxS3Hd12ZQD7V7WXUVymeJ7x7Dp4C/erIxNVN9+wzHv8fkfpmDIFmppei2NKC1GiSmbPb19FWCpvdf8fpGoUQYfG0VhPieK+M3Q2aOI1tErEK++TqGQKyJkJpn7yQB6v2CizboTlO/6dftUSl3chVbeR/st8M3tPhsR0QOBJv8EsQA9ApvJ7xPtLI+2g4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8pHJWEj0BQ3um/9S4UCI+gmOwMp5fDih+P89lOWtTw=;
 b=Ih4ZpBEK8uWDtmK26h3ZzBxC84wrEG4sz2pUso0eyG3dZ6EvSiq8C8RXKegIRrUCq2sM1+VtsRIOo9P2BBLuR6cWNneREIZLW/f1FXNC66a6X4oe+Qx+ZguBZ/F5HLRPaWK42WYeGU+Ww3XDFClRTBfDHMbhAyV6tqCIxhqG+0D5BCnFYJu/HKYqL4636yrRcMWLJbACKYTizRfvJcSio3QN04DoQIZSYa6xBCSNtj9r+X8A0OI/z0EZd0YPmGXUWxcxEujVEXjhkEOn4mS0a4W3DUwjFX5qeMdfiEfatU8RuwHs5QHS+DOBHYGlCHSapfBIueEKLTomuBarVnO6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8pHJWEj0BQ3um/9S4UCI+gmOwMp5fDih+P89lOWtTw=;
 b=QnoAVvryDGBNivj/ZrKvDQmFK6zeIrLG7t2qwUC5JJSv+SSoQjmXDXn309D+Px8mBaMLk1RxKbos+aCTsW8eH5+fnzlAbFSfGfDVpPr1A9WD8uuWPE2iIWX6uEe01M4JXWGA6oOG40gNc1Uxrxem5i+SsmY2adp2CY5OwjAjheU=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 11:23:34 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62%4]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 11:23:32 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: disable GPA mode in backdoor load
Thread-Topic: [PATCH] drm/amd: disable GPA mode in backdoor load
Thread-Index: AQHYe+siBYYda6GwREaXQ+XnZBO9Tq1G7ojA
Date: Thu, 9 Jun 2022 11:23:31 +0000
Message-ID: <BY5PR12MB3873C07B8D62D04427C46C90F6A79@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220609102310.2163021-1-yifan1.zhang@amd.com>
In-Reply-To: <20220609102310.2163021-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9f8e902-20ab-4b67-8b1a-909698de793c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-09T11:22:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bd21f9e-f039-4ba4-8fde-08da4a0a7c34
x-ms-traffictypediagnostic: CY5PR12MB6431:EE_
x-microsoft-antispam-prvs: <CY5PR12MB6431F153DD2B806B87E28871F6A79@CY5PR12MB6431.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LPK53Y7OETSROPkseJTiFE8V1SNqaKxb32Z1ZLfobsRPwc/cYWnL9kJLI7W3E00Q4yXD+oxD7WlAFYdgvFADty9lVU+ZGcsD+TSWphacdpi3tdB5RM88zGKxRwpgRMiGR/ka5CchtVbCJghdpH/IInz5mSpmXJ5x0DZ0xAzTkRWhEH6HIeRj143cNOjZ0u+NOkkG7kebUQn/ln2kHm5Cnv/Evg5b3XJYtzpH1Yp1/UM6yUjuX8q8o+3MDmB64tc6NONmhHvAPbNq/oxnRA0wMH3hClq9hpsKP9n4O8nmBjrKS7QbQPhILZtwOAlBE0zJN2dix/7nTAPW6lFLlI0+NyDb35nMDUxeBDdEO7duQdMl9U+X7BbP8goumtEoUDCRzn7lyLA2GemuSKHu+vjaTjN0Nl+dsCV0F16/jD0UvmxCJm6v+d8VA7kQS4X1zq3Ift96MZ7+k88M34b7XMHsFXZqfof7iaWxbF4n044E6Lp9TJPgm4RG6/hAOdwa5F2/yJvJPLRSv44FHoqS+AWCO9qhpFtnfUk3lD+wnWPqYn96cxHNWW8e+dScDrzhVWVegnNGnHrANIbWX9onJ3QDWKuuwUgpeU5zJ3b4yRW0AprzBWEkyjPLS/MmQPRHXBPGc47Dbe4uMS/EZQY2LjaMKZH9j9rXtQO92Wv6hymHvVz2YJngON/KNhXpijY0hetWIVyznWlbxgE6DYDK0xKBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(52536014)(508600001)(8936002)(54906003)(38100700002)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(5660300002)(2906002)(38070700005)(76116006)(83380400001)(316002)(33656002)(71200400001)(122000001)(26005)(9686003)(7696005)(6506007)(55016003)(86362001)(53546011)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/D+FILoVqZgXDMG1xtJRk9IKRSjgGaRxD72MdntArjhnEHclYVN20v7Uc0MN?=
 =?us-ascii?Q?64Lm6Lca3L4Uf4Limnh506C5K/LOutX8fhKZ078Am+Fn3HXfAjs0cL+5PPkF?=
 =?us-ascii?Q?M3LKJ2hTmK/5YNp9oXl2BS7Kp3TH4ePPA8b/NtzbfxQIEMnQDbswoujeN2+J?=
 =?us-ascii?Q?iRz4e8XwapDKeAhcOnxU12YEawPpIgTnN4snlhbkxSo8q05yqR1GkYq4MDEP?=
 =?us-ascii?Q?pT0g+E4/83jtyeckOwSaYY9YST9yHWur4z6Mtzyl9LN+Unno29XAjmLe5/ht?=
 =?us-ascii?Q?ZNSfO2XC9lqIWpfUkrg81VJGvTepe5HwBkIeTz6dZljFExonFRHyzPZ/qCEZ?=
 =?us-ascii?Q?+jhOU39+eYV8RiCxXLuWpfFK2Rt65wcliHyLsGQjFeoUdUYsz2gLhilqW5Se?=
 =?us-ascii?Q?ajlwAdzTwnKtWAIjVaZFeN8mQ6i1PFO1yjaOYx6V43aqOXYek3gyS8uyf1iD?=
 =?us-ascii?Q?YV0u5SY3EXeiT4VXe7JsRoVAYYy/HF6NZSc4gHtugHbop2XvQMrjs5CWOv3a?=
 =?us-ascii?Q?4vOW8tQt+Irjs3vA1FyGxrg+oDLY+MZKY7QqkeFLjit/zlr1gaLSXSC3k3MP?=
 =?us-ascii?Q?eK42QJDhsZxZZltUhX82ztN87xW4wnv+Uhz3Q3B1wefzcwDZfM8Afqckhh3m?=
 =?us-ascii?Q?Rq13LoNNCLohlzVt680S/Qyg+ARCHyfmDPxzm8z9Q4VSeK6dIz7s0THIUCF1?=
 =?us-ascii?Q?LQdFtzpp7ITwX9gDNWw43xtNmgeF6CpXzMBlRKcqIzPs9ogcaVI584V+q6j8?=
 =?us-ascii?Q?bD+v1d9pgIBTAl+i195JNqLoBREsf2Y9s6mxySnXRUq1gSjoxiRBa6aVGMDg?=
 =?us-ascii?Q?SpJkGXLmxtAeIGIFtlIdgk2Md51PYwya3zLpCASIng6CN6JF64UQhEuNmpUJ?=
 =?us-ascii?Q?Kbnhrhb2U2rzmjCQ195xPPCQJHIZgkCXJ0vpoHmQrNzoHSqh2p4xE446k5Bu?=
 =?us-ascii?Q?5RQlKKCtvjSlonnprgpgQ44oPLqltQ34sugKN2tJ10aDnHGdmVdM5M6h8SE9?=
 =?us-ascii?Q?kPfkr7F2W6j/5FEIISqxTPS/hEDSqA1ZlSdGL6hIwESTlTGCiwTg7hvIMuY9?=
 =?us-ascii?Q?l7QpwTXJu6WssRMKONtj9jv3t2lbLG68ibRpEesAXUL96s5MDmNbngycGSYp?=
 =?us-ascii?Q?njpPst+bPumaLseZ3vE3h9zbuvgPfcTxRd+Rgefi+lhEDuQ06A6t4DrF5vzV?=
 =?us-ascii?Q?5CsRhBnWx357g/fkHUwQU3QIG3HqARPTjCPcbQHqD3wwdccZibEI+x0Tfb5t?=
 =?us-ascii?Q?gQShfRXBCSocCtj6TFAmqueM6nD77Rvnous5QlRIrxWqs/ZEHAmJwIf8evuC?=
 =?us-ascii?Q?Z/oSrs7JLd0TDpeXyAMk/9+iXWkrdVhs0t0KuR6RLkoDKD1YcEDUPl9xTQ4x?=
 =?us-ascii?Q?tNSRXA9K+NgXfSBgP4xR9zLmmt+1KkZtgHQNtOy98Z7WiGxn4UeFvP0kv7JN?=
 =?us-ascii?Q?LLIvQ3N1YaeQgFOy+rGMXX4cox/YvCLox96OmwMCsSFgqnAVmR13YSYZ4/+u?=
 =?us-ascii?Q?NUfJwVi5i6CyyVhQ66pbo/V7PSWSfzdrNkuXMdEiA4Jkm/fR8ifjVzKE4bpn?=
 =?us-ascii?Q?I/0I6e/YCV2LyDnyIW78VqZXAxt60zqfKsxN/RRQzXfsw6F7oLLbYEtPIems?=
 =?us-ascii?Q?8uHkorYU2oGKX0VEUL5EEP/MzONtYfYp/xl0wUmC8QUgnk8d/3X2IPaGYCx3?=
 =?us-ascii?Q?i/YQ6zVkgudyjt7vBXsE7MJI7AvFiloQaG4v5M4TDfT5hzKs94lLzqD/N8PW?=
 =?us-ascii?Q?wYA+z/4lMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd21f9e-f039-4ba4-8fde-08da4a0a7c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 11:23:31.9981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snk6d2Uc8t/MSCokZphZnhzTPTewcDEtQJSLPvdp1vw0RGSZ+CB9QHuh3m+koGj8eGqP41kuOknVaRHWqK0s6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, June 9, 2022 6:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com=
>
Subject: [PATCH] drm/amd: disable GPA mode in backdoor load

GPA mode should be disabled in direct load.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index e331ea387ef0..571f13eb139d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4562,6 +4562,9 @@ static int gfx_v11_0_hw_init(void *handle)
                                if (adev->gfx.imu.funcs->start_imu)
                                        adev->gfx.imu.funcs->start_imu(adev=
);
                        }
+
+                       /* disable gpa mode in backdoor loading */
+                       gfx_v11_0_disable_gpa_mode(adev);
                }
        }

--
2.35.1

