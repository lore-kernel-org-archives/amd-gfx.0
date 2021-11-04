Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01CCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C93B61212
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C93B61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FAC6F8C9;
	Thu,  4 Nov 2021 16:19:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6AA6F8C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 16:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFUI76vvkl6+mrYYka3sTsMNZE3nZG0YIv8BcFh4IVJ1adLH/kkDabN4SbVwdP/oeUCcTrW98ntYP0pXt/eMav2+990yBx6zhUOjzqWKaFWynTrvvCywddhS5oWlm2Uoq4NY7xIVBXp0FJmSCpgkI8k339Ld+OPd8snjEdU9a+ilvlxhUMGKKLk5edLxhjQGr0Aez70+XmcgVRwCDZyCqhAC9WOWzE16v4w8Nb6RgVuZucK/uG2Z/MaQa/A7YBNKzxZ7K1WPTC+jAISshZPXF/UAKmZHnkSbiMSVeqvEDFeuKOErkdfRd9Se40yYVGa4W8m5vHyTFNVqAe5EJWyXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsfQ/MdBF/OwCvGrHtzVJEUtYCU95NwnDz7Xc9+6HYc=;
 b=QwkRSomN5TthVA6949SChz/Gr0dMiXClZp23ZEzHzvTPw7klOG7BmNJrxvo7VuKXTWcmhVVrEB/tm3qcyaMPPgl5MXXrRkCVefZ83URzBCOP4fPcnDoCPgdzpE142j+KaOZRQk3uKT5xAv/bhA6xGkB7jyRFQqWAHsH3oDTyDofnc0xPDtRJjnOYGdMBJg5IJbfICWb8zAqgszB9rHyWfeWS8MVjhPe5JfK7aanAd57X7YtHKcbs2bbDtyY6p84AlzBgo5z9KNwH3evelkJONqgihjLIqKaK4lzWUdroMEXMS7NqOBK+55Ql+/1cTMpl7xzhaDuKeaK8EVY3WUUCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsfQ/MdBF/OwCvGrHtzVJEUtYCU95NwnDz7Xc9+6HYc=;
 b=Y6X6w4tOv2dvNkBpaeyKEO7axfdnW66ualupx1hLejXLsNPg3EL1jKe1ADHTdttSxTHZhBN/5VK4zNt5gr2iFb9szxzMSLnm22tNcofDrzkZVzCGxmLjpm3TpD+QRunZDJy8x+0cgEopn6OnOQVALuv7bv7ZTsg4tJhA1loENc0=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4700.namprd12.prod.outlook.com (2603:10b6:5:35::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.19; Thu, 4 Nov 2021 16:19:02 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::dd97:b89a:dbf6:ed12]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::dd97:b89a:dbf6:ed12%3]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 16:19:02 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/1] drm/amdkfd: Add sysfs bitfields and enums to uAPI
Thread-Topic: [PATCH v2 1/1] drm/amdkfd: Add sysfs bitfields and enums to uAPI
Thread-Index: AQHXqOWeJWSVQQBh/ECbP4Hsln9yTqvz3H+Q
Date: Thu, 4 Nov 2021 16:19:01 +0000
Message-ID: <DM5PR12MB46806B5C723B187B0A16C1D4858D9@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210913212320.2470858-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210913212320.2470858-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=39a27aca-a12e-41e5-a5d6-c55ec6e1ff8e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-04T16:15:13Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 7873faf2-1fd2-414c-b708-6f6e195effcd
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c4a2e27-9ebd-442c-57c6-08d99faed090
x-ms-traffictypediagnostic: DM6PR12MB4700:
x-microsoft-antispam-prvs: <DM6PR12MB470005D6E524CC0E447EE85D858D9@DM6PR12MB4700.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fR/SND+Jsv0WySpH87X8jhWnl9bpMHIKE5YqnSCHbEcJharwVc/TWsYxJoKV+sCA0FkedRr1CdUKJWeFvUtZT3X7DZziUXQw3Tuu4H2Z5WlNqJO9HqJEXPxBThZ0k2ITp/3wzLD59xbEMbpE4a2UzU7w/mYxhr0W74K1v5aZaG7Iba3/KosQ/5Tz2UFfkuVUZOWQ/HolDHeuI3EPyMiWcCNsutCrL6Y8KSvVhmWpjEA0wM02aXjk5GlEo1X0MdOkpt7KGAlNDsxfbK45qkNKZEkH+RkU49Ik3RTzvcXDLYpC6zWVrnrnyNZ0iRznIH+re9akQmYdQENzlAQhsF54rV4ZZ+2GhZPMjXNiSlBXDjOuzXPcAUEXpdAIzfXzjRfsN81Gd31m2yAeWZCqv20AC9NM/LGU/EHSVbUmwiknH3ukHS57XnkBXWDa4zRgP2+dK79DocPMANH/s2AwoWaV4L5g8Per6XlGPNGwUgY0Txkm3EvTHlNX6LH6IiHcAnAe2Akwmi/lmleksuRI0UtI6loC5d0A5JWNla92JYBSSr4vVO/Jlr/EgGke9+VUTV6wIuo0RjlWENAFhFN8MuH1CLj5YBxniFJdzBJ315UPQmYpTu9rKqlOKJzPd1Oq3a2x7UipOpEZ7i47m2sBe1p/H3Y8Z0x7INiNDsLk7IFoMmuzt4vYyeoPNvrx+L5ChpwOs25vjMx8oRCt1lkG2ZEOdSiRWc8iYNQPBML36Z6WCM9R6Cj/MOHq25tKaQNNRybtqBdkfZ7FeqGLD7DW3gbV+Z6mTUCPzkglrkoi1i/793w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(2906002)(966005)(53546011)(7696005)(316002)(5660300002)(71200400001)(9686003)(110136005)(8936002)(33656002)(38100700002)(66556008)(55016002)(66476007)(6506007)(64756008)(38070700005)(76116006)(66446008)(83380400001)(8676002)(52536014)(66946007)(45080400002)(508600001)(186003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1efQYTFLMuL1qZaLXO3MDitsUFhHwd2cyhD6r911g4Yi+rlHMhNfpvYjWva?=
 =?us-ascii?Q?TIUL/35FA6A9P8NDXs01PhvuPnR5mhf1LGQwOvJeBipG70yrAUh3L7fuukcC?=
 =?us-ascii?Q?ttKOh662Knme6JJZX02PSPHbUpCtyYrH+/g2NXd0tkVmwcl7ggjnTp9/vwN9?=
 =?us-ascii?Q?cZIBXQEPpOEToU9YODF/Kdf9aBPTjJ6ZtTz1GFQc6TM3BgKJZdIbC5YWgYbQ?=
 =?us-ascii?Q?huaIES/sdJOI8fEd0d8pXaCbknGkhLWdLLF1/lJiuzBs0i+7IWafzDJdH0JZ?=
 =?us-ascii?Q?/fz4f36GRZtu81imYfjdjGXSRPZuSZ8F67TauZQrUJh8sHx79KRO6qhT5YXb?=
 =?us-ascii?Q?z62RErpBnU5JOmLUT5YaNp+LfkAraq6WT1jjaaGLcmw4Of9kLK4RoKZbYeDn?=
 =?us-ascii?Q?tV4EtHpTrS+v8ot6D6k/pMOS7EjWfhXVeX9Siz+TdN51rberxiOejHPa58Tb?=
 =?us-ascii?Q?oxvKXOkswEjfKezkPVduHKpIEiZfVNs+7OwFHnEcd45bO5nF8/mbrjS9n0wA?=
 =?us-ascii?Q?Y6mCqJnCDuO+W7Yxi30NJBRZgk0CCGsmMcOws+K4JOZjJEj+9S4fMcaZ5kjE?=
 =?us-ascii?Q?fYPVb5+KeVBHtTrpoRP8EBj1Qvp/GSvNeQ9+5oT2/9G55d6avx1wbQtpusrf?=
 =?us-ascii?Q?4u6xiq3KqaOrseMs+neUang6BxcjqUySND1otKxBnV8adJRRGsKoKREWvMdx?=
 =?us-ascii?Q?pr34py4/AEFXHcaHaF+Chl3SesQENODqx4ESO8mZoMWAj9mtMdanZaRRtBcW?=
 =?us-ascii?Q?NwvQ7xuY5eAeivwET/dyJM0qNQI8kSQLXOGDYf26XQeQEAIlYwyPVeEjpQHm?=
 =?us-ascii?Q?Foj0lYfoBftvFD7L15y8SuILI4ztHVKD5tPuO6irIP3RKRBd/k5oAGWnyE9C?=
 =?us-ascii?Q?0J8W+jm7rdyVovLz0ADjY7qiNcch3S318HiBsO0m3uWi4CCyK12pMCuroUyz?=
 =?us-ascii?Q?aXSYuW59r+RruE6LH+Iog0poBEzHpunyv5Zqw/pMDgZFYf7eoY0VvHP9ml7c?=
 =?us-ascii?Q?KCSFJd7dwmk9mxqIa3NRlStpfYnjDncyZDstWCR3s7Ebsnf5u6H0n8voBdmr?=
 =?us-ascii?Q?1jrkkm9jgsiYgpdDltKYzZabTO+JZRK54CFo6JyqxcjHzy/iGkuVNyR1zthB?=
 =?us-ascii?Q?lFR+Me2MjEam/lwriHxoFiDG3GBfIHnlnagUyv+bLhTMLuvF5b1lIoGhsEx+?=
 =?us-ascii?Q?4Feu+DQAVSDVVqR3n0LybiaFFbDkUcrQz4XHPkrMedRz3TmrbwJrZmAhHGJ1?=
 =?us-ascii?Q?bpXxiiSA6/4vmdFk7VeTqmgVNRxclSclCyEL9VtkhZXyYyf9SqNn7DjnGgcz?=
 =?us-ascii?Q?vwY2kxhWWRPzq2xSgaIqBvigAzj/15GRbuVVKJZ7mOO259mwM4HAGDbKSKfl?=
 =?us-ascii?Q?Vb8MznIBmxi+UvJGLqIqF9ZOFuqPRuUvAiQWH9W38UwjpPTgOIPGOm5uzJPj?=
 =?us-ascii?Q?8RjfCTPhtFa1HPBCQHdfhVn1VEebc1naSazWqy88trtl2R/avNec9cNRfSO2?=
 =?us-ascii?Q?PhVSF5jXrHYZEGgNmaTQkUjq8ATBs5LQ2aQxLzDxh/gma/FTn5APN/KalowD?=
 =?us-ascii?Q?FAtrXgnrTh/8jRh/UvI6+XiuhqJXwWX5DEgbdJ+T7NFUYFxLlnXrCqLwPt/O?=
 =?us-ascii?Q?sIkWUq/MNEsUifw+2uqVJZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4a2e27-9ebd-442c-57c6-08d99faed090
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 16:19:01.9893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJxf2pKJlFVr7L1KZAcJ4HqbGtUSSqnpVzA/L910EdOJOVGkupPwGtmPr1zzJ78V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4700
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

[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: September 13, 2021 5:23 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH v2 1/1] drm/amdkfd: Add sysfs bitfields and enums to
> uAPI
>
> [CAUTION: External Email]
>
> These bits are de-facto part of the uAPI, so declare them in a uAPI heade=
r.
>
> The corresponding bit-fields and enums in user mode are defined in
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit
> hub.com%2FRadeonOpenCompute%2FROCT-Thunk-
> Interface%2Fblob%2Fmaster%2Finclude%2Fhsakmttypes.h&amp;data=3D04%
> 7C01%7Cjonathan.kim%40amd.com%7C60c91f7b30794bf670c808d976fcc
> 000%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637671650
> 194006492%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DWQU
> JKcixWV0gxBYSxUzZx05nAtyYjoRNz7oJO%2BnjsLA%3D&amp;reserved=3D0
>
> HSA_CAP_...           -> HSA_CAPABILITY
> HSA_MEM_HEAP_TYPE_... -> HSA_HEAPTYPE
> HSA_MEM_FLAGS_...     -> HSA_MEMORYPROPERTY
> HSA_CACHE_TYPE_...    -> HsaCacheType
> HSA_IOLINK_TYPE_...   -> HSA_IOLINKTYPE
> HSA_IOLINK_FLAGS_...  -> HSA_LINKPROPERTY
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  MAINTAINERS                               |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  46 +--------
>  include/uapi/linux/kfd_sysfs.h            | 108 ++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 45 deletions(-)  create mode 100644
> include/uapi/linux/kfd_sysfs.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84cd16694640..7554ec928ee2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -930,6 +930,7 @@ F:
> drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>  F:     drivers/gpu/drm/amd/include/v9_structs.h
>  F:     drivers/gpu/drm/amd/include/vi_structs.h
>  F:     include/uapi/linux/kfd_ioctl.h
> +F:     include/uapi/linux/kfd_sysfs.h
>
>  AMD SPI DRIVER
>  M:     Sanjay R Mehta <sanju.mehta@amd.com>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index a8db017c9b8e..f0cc59d2fd5d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -25,38 +25,11 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/kfd_sysfs.h>
>  #include "kfd_crat.h"
>
>  #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
>
> -#define HSA_CAP_HOT_PLUGGABLE                  0x00000001
> -#define HSA_CAP_ATS_PRESENT                    0x00000002
> -#define HSA_CAP_SHARED_WITH_GRAPHICS           0x00000004
> -#define HSA_CAP_QUEUE_SIZE_POW2                        0x00000008
> -#define HSA_CAP_QUEUE_SIZE_32BIT               0x00000010
> -#define HSA_CAP_QUEUE_IDLE_EVENT               0x00000020
> -#define HSA_CAP_VA_LIMIT                       0x00000040
> -#define HSA_CAP_WATCH_POINTS_SUPPORTED         0x00000080
> -#define HSA_CAP_WATCH_POINTS_TOTALBITS_MASK    0x00000f00
> -#define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT   8
> -#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK   0x00003000
> -#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT  12
> -
> -#define HSA_CAP_DOORBELL_TYPE_PRE_1_0          0x0
> -#define HSA_CAP_DOORBELL_TYPE_1_0              0x1
> -#define HSA_CAP_DOORBELL_TYPE_2_0              0x2
> -#define HSA_CAP_AQL_QUEUE_DOUBLE_MAP           0x00004000
> -
> -#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED 0x00080000
> /* Old buggy user mode depends on this being 0 */
> -#define HSA_CAP_MEM_EDCSUPPORTED               0x00100000
> -#define HSA_CAP_RASEVENTNOTIFY                 0x00200000
> -#define HSA_CAP_ASIC_REVISION_MASK             0x03c00000
> -#define HSA_CAP_ASIC_REVISION_SHIFT            22
> -#define HSA_CAP_SRAM_EDCSUPPORTED              0x04000000
> -#define HSA_CAP_SVMAPI_SUPPORTED               0x08000000
> -#define HSA_CAP_FLAGS_COHERENTHOSTACCESS       0x10000000
> -#define HSA_CAP_RESERVED                       0xe00f8000
> -
>  struct kfd_node_properties {
>         uint64_t hive_id;
>         uint32_t cpu_cores_count;
> @@ -93,17 +66,6 @@ struct kfd_node_properties {
>         char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
>  };
>
> -#define HSA_MEM_HEAP_TYPE_SYSTEM       0
> -#define HSA_MEM_HEAP_TYPE_FB_PUBLIC    1
> -#define HSA_MEM_HEAP_TYPE_FB_PRIVATE   2
> -#define HSA_MEM_HEAP_TYPE_GPU_GDS      3
> -#define HSA_MEM_HEAP_TYPE_GPU_LDS      4
> -#define HSA_MEM_HEAP_TYPE_GPU_SCRATCH  5
> -
> -#define HSA_MEM_FLAGS_HOT_PLUGGABLE            0x00000001
> -#define HSA_MEM_FLAGS_NON_VOLATILE             0x00000002
> -#define HSA_MEM_FLAGS_RESERVED                 0xfffffffc
> -
>  struct kfd_mem_properties {
>         struct list_head        list;
>         uint32_t                heap_type;
> @@ -116,12 +78,6 @@ struct kfd_mem_properties {
>         struct attribute        attr;
>  };
>
> -#define HSA_CACHE_TYPE_DATA            0x00000001
> -#define HSA_CACHE_TYPE_INSTRUCTION     0x00000002
> -#define HSA_CACHE_TYPE_CPU             0x00000004
> -#define HSA_CACHE_TYPE_HSACU           0x00000008
> -#define HSA_CACHE_TYPE_RESERVED                0xfffffff0
> -
>  struct kfd_cache_properties {
>         struct list_head        list;
>         uint32_t                processor_id_low;
> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysf=
s.h
> new file mode 100644 index 000000000000..e1fb78b4bf09
> --- /dev/null
> +++ b/include/uapi/linux/kfd_sysfs.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef KFD_SYSFS_H_INCLUDED
> +#define KFD_SYSFS_H_INCLUDED
> +
> +/* Capability bits in node properties */
> +#define HSA_CAP_HOT_PLUGGABLE                  0x00000001
> +#define HSA_CAP_ATS_PRESENT                    0x00000002
> +#define HSA_CAP_SHARED_WITH_GRAPHICS           0x00000004
> +#define HSA_CAP_QUEUE_SIZE_POW2                        0x00000008
> +#define HSA_CAP_QUEUE_SIZE_32BIT               0x00000010
> +#define HSA_CAP_QUEUE_IDLE_EVENT               0x00000020
> +#define HSA_CAP_VA_LIMIT                       0x00000040
> +#define HSA_CAP_WATCH_POINTS_SUPPORTED         0x00000080
> +#define HSA_CAP_WATCH_POINTS_TOTALBITS_MASK    0x00000f00
> +#define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT   8
> +#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK   0x00003000
> +#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT  12
> +
> +#define HSA_CAP_DOORBELL_TYPE_PRE_1_0          0x0
> +#define HSA_CAP_DOORBELL_TYPE_1_0              0x1
> +#define HSA_CAP_DOORBELL_TYPE_2_0              0x2
> +#define HSA_CAP_AQL_QUEUE_DOUBLE_MAP           0x00004000
> +
> +/* Old buggy user mode depends on this being 0 */ #define
> +HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED 0x00080000
> +
> +#define HSA_CAP_MEM_EDCSUPPORTED               0x00100000
> +#define HSA_CAP_RASEVENTNOTIFY                 0x00200000
> +#define HSA_CAP_ASIC_REVISION_MASK             0x03c00000
> +#define HSA_CAP_ASIC_REVISION_SHIFT            22
> +#define HSA_CAP_SRAM_EDCSUPPORTED              0x04000000
> +#define HSA_CAP_SVMAPI_SUPPORTED               0x08000000
> +#define HSA_CAP_FLAGS_COHERENTHOSTACCESS       0x10000000
> +#define HSA_CAP_RESERVED                       0xe00f8000
> +
> +/* Heap types in memory properties */
> +#define HSA_MEM_HEAP_TYPE_SYSTEM       0
> +#define HSA_MEM_HEAP_TYPE_FB_PUBLIC    1
> +#define HSA_MEM_HEAP_TYPE_FB_PRIVATE   2
> +#define HSA_MEM_HEAP_TYPE_GPU_GDS      3
> +#define HSA_MEM_HEAP_TYPE_GPU_LDS      4
> +#define HSA_MEM_HEAP_TYPE_GPU_SCRATCH  5
> +
> +/* Flag bits in memory properties */
> +#define HSA_MEM_FLAGS_HOT_PLUGGABLE            0x00000001
> +#define HSA_MEM_FLAGS_NON_VOLATILE             0x00000002
> +#define HSA_MEM_FLAGS_RESERVED                 0xfffffffc
> +
> +/* Cache types in cache properties */
> +#define HSA_CACHE_TYPE_DATA            0x00000001
> +#define HSA_CACHE_TYPE_INSTRUCTION     0x00000002
> +#define HSA_CACHE_TYPE_CPU             0x00000004
> +#define HSA_CACHE_TYPE_HSACU           0x00000008
> +#define HSA_CACHE_TYPE_RESERVED                0xfffffff0
> +
> +/* Link types in IO link properties (matches CRAT link types) */
> +#define HSA_IOLINK_TYPE_UNDEFINED      0
> +#define HSA_IOLINK_TYPE_HYPERTRANSPORT 1
> +#define HSA_IOLINK_TYPE_PCIEXPRESS     2
> +#define HSA_IOLINK_TYPE_AMBA           3
> +#define HSA_IOLINK_TYPE_MIPI           4
> +#define HSA_IOLINK_TYPE_QPI_1_1        5
> +#define HSA_IOLINK_TYPE_RESERVED1      6
> +#define HSA_IOLINK_TYPE_RESERVED2      7
> +#define HSA_IOLINK_TYPE_RAPID_IO       8
> +#define HSA_IOLINK_TYPE_INFINIBAND     9
> +#define HSA_IOLINK_TYPE_RESERVED3      10
> +#define HSA_IOLINK_TYPE_XGMI           11
> +#define HSA_IOLINK_TYPE_XGOP           12
> +#define HSA_IOLINK_TYPE_GZ             13
> +#define HSA_IOLINK_TYPE_ETHERNET_RDMA  14
> +#define HSA_IOLINK_TYPE_RDMA_OTHER     15
> +#define HSA_IOLINK_TYPE_OTHER          16
> +
> +/* Flag bits in IO link properties (matches CRAT flags, excluding the
> + * bi-directional flag, which is not offially part of the CRAT spec,
> +and
> + * only used internally in KFD)
> + */
> +#define HSA_IOLINK_FLAGS_ENABLED               (1 << 0)
> +#define HSA_IOLINK_FLAGS_NON_COHERENT          (1 << 1)
> +#define HSA_IOLINK_FLAGS_NO_ATOMICS_32_BIT     (1 << 2)
> +#define HSA_IOLINK_FLAGS_NO_ATOMICS_64_BIT     (1 << 3)
> +#define HSA_IOLINK_FLAGS_NO_PEER_TO_PEER_DMA   (1 << 4)
> +#define HSA_IOLINK_FLAGS_RESERVED              0xffffffe0
> +
> +#endif
> --
> 2.32.0

