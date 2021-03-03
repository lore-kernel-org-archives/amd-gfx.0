Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5813C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 16:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1AF64ED0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 16:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1AF64ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE166E9B7;
	Wed,  3 Mar 2021 16:27:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69156E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 16:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByOmC9OqsNYoS39Sj/IoHBGG7L0Q2h+GWgcil1oxqBr5w/5krbkui4d15eaGQ2wjpdBMQNk7ZY2JZQGawfUiVmpfy10tvHihcYmeXaEhjMnZHBcuIarKMLn+pV1YZJMq3DNM/jAhXm4LiDpfREvSA5jPhuOip8gDH0v4ZxqnTLdKjepFril8AYOSeYNbWSIsxTH10PRFDq3BED/L5NUhpLAQfsXgQshdH0edMuCegKTRjrP5GdXBtrLaqAP62Ga7pOrDtxQ4/NLtNbnqw8E0O63fWjG5aPF5RD9mHUoiObN3mldGbDAsuF9GEN6DWw7QRxb21xoo6NElQndk7UPkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAHiVIge68Z3UuHYOMBjWaaMcHSufYXhGbp+wJJ47Hw=;
 b=Rv9P/BeBp7qeksH6F6Y+wpPOj8yxr87CJOCuk/FL23Wjus3zFz5VfV46gsZXJCRIQtxgJ2u6kU7inX9/wjF4S+pbu72M5K13PhONG0aYGEFB8ZPpUJBxw5kokJtAfa79+DX433NzRkw1VyjZYHSQI5DKaMgk5i/mZbtuhdoxxz+kEckKLtLcPtfuSZz5NEQi8X03UXz7tg8HD3YNfjXc9DvHZub6tEhIBctfPzELCtPNw3EQIRFx+1mRAzG1rJZewEzDFd+TPoHolL3yqZ8m9glmcFPdNWuROvCWdy1tEAeDRSJUVCIBasRrH0qer28hlCPIwNghXbLVK+WZ8QtjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAHiVIge68Z3UuHYOMBjWaaMcHSufYXhGbp+wJJ47Hw=;
 b=AkmOBEaB3iCmEwFB7jT0Kutc2GxK5XaVpDhgEpHZ1RSDfR8GDiXLc43wn7uc3wH8g8DgLvbgtA/5dKcP921enKrj8jJEmLVVnSB7ZSkjDcfL2e/kL/sQcdA36hrKsoCTf9IMP3arK5lcHvVhrIIh80e6eZAnH8Flct976T6bGAs=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4985.namprd12.prod.outlook.com (2603:10b6:5:16d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 16:27:41 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 16:27:41 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Use a new capability bit for SRAM ECC
Thread-Topic: [PATCH 1/1] drm/amdkfd: Use a new capability bit for SRAM ECC
Thread-Index: AQHXDJEyROS/DdPXnUicHyl6GUtavqpyewAg
Date: Wed, 3 Mar 2021 16:27:41 +0000
Message-ID: <DM6PR12MB3324CCC2B1B231722D17644985989@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210226224534.14377-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210226224534.14377-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-03T16:27:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a5d3817c-1ac3-423a-a6a6-496bf1d5e1fa;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:3427:759d:d02b:d257]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 057a5439-dc64-4be9-d09d-08d8de61445a
x-ms-traffictypediagnostic: DM6PR12MB4985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4985A52CC0AC2465FE7C02F985989@DM6PR12MB4985.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlLLAYcKlYfEd1XJRqANVXP+siWyV1uF4dCfzWLQ/joS18pRXh48oBknWC9+8YQNFfk8Gmd5BteCehjmZq/ZC6gPS7fI8hCBhSFFGtpRT/Jd6bieN9qMl7LGEFevjnNhnOn7FiLfzPBeqMjKXeyLsB1SJLu6VPSo9tlylwZxB7cSTc+UHk0TDbEoiCOlzJaSO8vJf9Kvq4crawgaWwpqZRhPLmjEvXe/Vrnxi1c+feGroFbqZAv5gzinjZHXO0BAX3njMNnHjFhPiI2dXdCar8Mep+t1YFGw7TH9iGIJ6iijjUJTgJ+wTkjOo66mBlmdIH6BmTtal4yOxNKUu3IFRg/OGAI4GjP/Yn5IiPpUAgb+QsYR/gDefxTjN+erc3q7NJiEoNtp9KkoGoUySe9im9K2CpDNWJ34tpaxoEOKsWx2vm4dZuoFoqGZclfABEdUCkDh7C6V1FWTg3uRE1MjFNpOlo183FaIzQROoTz/atPcaDaX/KtqmFQjNy5+bn7RBCEQURDXv3L36aeHawf5EtmOBF4I5SdoUVnmYJYgRhrxyEQAf8XPMnXPzL8vmNNG/Nh9GXpWL0zJZXqTvF/A/d6AVLW5/dMYz25rOAPGLYY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(71200400001)(2906002)(64756008)(7696005)(8936002)(8676002)(45080400002)(55016002)(66946007)(52536014)(6506007)(5660300002)(86362001)(33656002)(53546011)(478600001)(66556008)(66446008)(66476007)(83380400001)(76116006)(966005)(110136005)(9686003)(186003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N9Q6HoXUjTX7S6CWJR7kOhD9i06buxmyRkzvDlKaB/B+aDqvQg+r5viYx4Ft?=
 =?us-ascii?Q?oVBJYCjhcce+++cPJ72VXGuDQ3+Nv7b0jXXoPOHHhDkkmilcbn7YDaLDxpCp?=
 =?us-ascii?Q?e+5f9W3Rt6NoGo6tiqxgCw5GiKe3+wZ6v05Mkv3g/DMOnY52Za8DKlQooPiS?=
 =?us-ascii?Q?SKa4DBQuaHvdPC13hfMJUfP6yHgmb3QcVQJk88ePPdcpr3vwxUt57xZoP/HJ?=
 =?us-ascii?Q?qX6jN7eOzG2DCGMb8U09SMeBae80hEx6P30I3GALbTLljBxDR5eOja/Y8oBH?=
 =?us-ascii?Q?z657aKQA9S2KTKAXF3CSsfh2dqiU1zA4XX5F6hngoHpGttOCPzNHaDIWO6/v?=
 =?us-ascii?Q?EdAnwxEPS04tHnkEuhiIUyI+3UWFO+em11o2eGg7pPB5cCAvkw4R4KJJPMd1?=
 =?us-ascii?Q?WE5pb4wlu8Weh3z8/m2ruY2NIB7UVdjUMc0a+vkLSvoR1OSb0lCVp0sd5Gae?=
 =?us-ascii?Q?IhnMpFLJd07qFqgM2CphqzHqrltAeVgl6OxLMDsyFybV6QAZoJhcXqi9qf+6?=
 =?us-ascii?Q?hcPxhO/R9CDKLwlLsEezasT7YLsJjJyt6uUAwqnnP1IqgO8Fy8roFrfcMWGZ?=
 =?us-ascii?Q?nAxTcFfsBHUrx64O3Q6No9Ete1IBIbtvrRGGgOTkOGlDO08O/o4MwERnTbZx?=
 =?us-ascii?Q?i1eoSsso4QWBEfmbtDUq5cHVvkMNrCPiTtrvgDszLSU+ruz4kCOuQW0k0TEt?=
 =?us-ascii?Q?NQjaj5HZqSWAcgTZS6vcClXurXZTEKoL4vRgfbM8o/33h5ArXYfKEAg85vsg?=
 =?us-ascii?Q?WjVaT1GKRU55XGvWR6KSnb5aX30UYl2qKfdaVWLxfd+VSvDMG0NPQI6/Xymo?=
 =?us-ascii?Q?p+2HvieyIGd3inhnfSTD50O1TJAJIm0y2QeDh6IARFOjcJQBIv+oH1/KMzlv?=
 =?us-ascii?Q?v6CCXn/QG3/FFN56T4sN2fo6pPuFrcblPMNwhWzDeC/483Vg5Se9VpLiADZW?=
 =?us-ascii?Q?NAlMaa5fqD5oMXiX5fcPAMsV5U3IRMrz/3nCOAN+L53gxThZroP5N7LF0d1s?=
 =?us-ascii?Q?r0/v200l9yvgZSZw5/6MPuklChucH2eSPUKnIUozCIdSOlCyq+YtSdCVhyK2?=
 =?us-ascii?Q?eQ8VDk/Al9wVVZBoTMQx+VD4xMHTci7HeO1mFDGnfsVDUj/aq+8vLIJJhvrn?=
 =?us-ascii?Q?bIZNKM3JDoFE7VizFFtfMvp1Chdczz3BaAE1+3Gj2QJDkc6OKypjLBEGhxC4?=
 =?us-ascii?Q?U0L2ab/ABOhYbXhCWyWZ1+QClxIo5vi5qnTRqmonjcqhIbeCE55aAZgODY84?=
 =?us-ascii?Q?bDeAfL4BN7EnoUekhK/csQ6icU1c7W9P1d3xCE2hQ+5xwa2nOKSjxeKWrsU4?=
 =?us-ascii?Q?6DRMq2hMErPETtr6aN/8hHPtxqRJdLZvDBeO2XRiv2ycMUF0Dw2teaKmXjJq?=
 =?us-ascii?Q?IpyzCfWDIMmUYyjq6kNimzz7l1sE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057a5439-dc64-4be9-d09d-08d8de61445a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 16:27:41.2521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndiEP5Lm/RpQlFiYBo9d4mndV3MmAiLpM0uX7DzfPJUuBgP3y7NHbBcICCy5mX3rKBqmURflR/GZv8lPgmUgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4985
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Friday, February 26, 2021 5:46 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 1/1] drm/amdkfd: Use a new capability bit for SRAM ECC
> 
> Existing, buggy user mode breaks when SRAM ECC is correctly reported as
> "enabled". To avoid breaking existing user mode, deprecate that bit and
> leave it as 0. Define a new bit to report the actual SRAM ECC mode that
> new, correct user mode can use in the future.
> 
> Fixes: 7ec177bdcfc1 ("drm/amdkfd: fix set kfd node ras properties value")
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 416fd910e12e..b8b68087bd7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -47,13 +47,14 @@
>  #define HSA_CAP_DOORBELL_TYPE_2_0		0x2
>  #define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
> 
> -#define HSA_CAP_SRAM_EDCSUPPORTED		0x00080000
> +#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000 /* Old buggy
> user mode depends on this being 0 */
>  #define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
>  #define HSA_CAP_RASEVENTNOTIFY			0x00200000
>  #define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
>  #define HSA_CAP_ASIC_REVISION_SHIFT		22
> +#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
> 
> -#define HSA_CAP_RESERVED			0xfc078000
> +#define HSA_CAP_RESERVED			0xf80f8000
> 
>  struct kfd_node_properties {
>  	uint64_t hive_id;
> --
> 2.30.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7Cb8d46efc3f554cef4f7308d8daa85
> 3bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637499763789222071%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C1000&amp;sdata=ZhBBLDSK21I9o%2F1wsoFpWUlPtiezJ2rHHmIvJ51lsT4%3
> D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
