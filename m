Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B80C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 20:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9F565141
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 20:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9F565141
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C4E6E125;
	Tue,  9 Mar 2021 20:12:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9BC6E125
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 20:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbc6YeiRPrssKT77qL5KOEhzqPLGfbck+G8jDrb5XQEyguenpIeNvCTaAjczikTUZSvKYG5eRjWWz6P9OZIYZ1CUhkM8W5CEGhWumTZ3w7vOA92/PiSjNrswpaayQyyf6PJ6OQSEIvKjnBQ+/jP+31xkTlUep5zj9DlWH/ABVVoz+Bn2iKgbDLU/qazioA9AodbmXnSiNJWNuy6MPjvBJFXgdPHCPQzjN4xitW1p7T16suaGcAkZ9FDawLQ+uT8+F89AHQCKYQ0iIyIaj0kG+JtqXeDUuvGzkRzeJOG1wYK2CNwnYoheR/gO4wtTg1cMaRZvoTTPIYesBUhXJEDY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KApWcQ3RgBslpcOLCBKpqpkhFe75QKygevonAabfBqo=;
 b=ACWwD8xciygO8QD4fR+CmuB4XuD694QsurGbni6cuAOesRdVR3nH6eyylsXZbQEju2mseTzzD1oj8Z2kBsPWaEOOmNV9Q1j2fOowWFjhqD9LmO+AQKaw42RylWrFbjbOMNZ7YFDolweiffftwESrpNdjMiYpAV2w/940qB60shdE/sQogxlN3BE2oYKoHvZoUlRR3aFt/+aNZuJ69BAD/KUkQC7Z+KvcmzmNBi0Tr8RHqL9I874CxG3YKU6N3/pjTn6cHNpb2XvjSLhA2vKy+hvr4xNOSZKgYiO8pggMuQii4RGU2j2LU+kdNyMzb9aM/WYdcsMUiA3EwGhTRM0vIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KApWcQ3RgBslpcOLCBKpqpkhFe75QKygevonAabfBqo=;
 b=IcBTPNPTzxsVyIL8RZNaLT4qoBUIXI6BOWDFNYnXZWSjzmS3MyUKM14eqUAPWYZMtPnp50cOx6z7LmRjBqUSz0NVciQxtkzh7SVYVrLQHsopK4gV+FXpg0tCqO7kNIWXyvSqswOCDXemYBB9/Dec9Q05KMX/pjYm8ONsZ6UMpJI=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 20:12:12 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 20:12:12 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Bump KFD API version
Thread-Topic: [PATCH 1/1] drm/amdkfd: Bump KFD API version
Thread-Index: AQHXFR/Z4Hlq8ULUNEmUibptmxt0vKp8Fpqg
Date: Tue, 9 Mar 2021 20:12:11 +0000
Message-ID: <DM6PR12MB3324C38C15943CF5BEE7168585929@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210309200644.28188-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210309200644.28188-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-09T20:12:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8a55e1c5-0f89-41fc-b9b5-89e5a89af74d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8d6707f-12d5-4eb8-761b-08d8e337a009
x-ms-traffictypediagnostic: DM6PR12MB3420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3420498D56999443C02A5E8285929@DM6PR12MB3420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqJu0KSK8d50Z10Ank7KvU4Nw2MAUx8maMe4t581H/4jF+o995+x83NIwnRIZAG0KuxtIjGbhVoFP0s+vrrtiaW4n4nw5rTyBFBeYtKyZe4j1mzAmrh6NAJDtozZz6xIl1tD0ddBFKMON0P5KIga9q69r5tuJCy9jEPCrBW0UdDFqy21RDSrNz5uKgYFpNpKPNeVyVL76uP2Ox4fGJlEFjgPSF5A/nO6seXFvMCSBDhxcgouP4WXWtltTqTXEurryV3FChWQoRvRo/p7bhl9QAKbskzZGeAY7kBTc/IIqf4CLP+gMi0Mr8Q1thUxVI0LozSDy62oetK0kKrI7k69g7V1bsMfYC5hHij/tnteViqy/d3OZ1OzWXuojyDEWyd6Nq2pOCK4JG0wXXX5qWeOtUos8CTmaXR49F6U4P6Naj48vvGyN+fUgFFveUYtMXLq/5CWxXCIXBcDbprGEec8g27YMhpn3glxUHkvrDZdUUqS+uj87xencMo2Ji7TqHHMht9+ziZ3y4AlIErgQPiYooUjg10h+ct0uV+DIqh/5mhhjeX/8cgn8z3vsZIXrmWl73qxvde3hvCvfHHWo6vJ9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(83380400001)(64756008)(45080400002)(66556008)(66476007)(66946007)(33656002)(66446008)(86362001)(76116006)(110136005)(5660300002)(478600001)(316002)(8936002)(4326008)(186003)(966005)(71200400001)(8676002)(52536014)(7696005)(2906002)(53546011)(6506007)(9686003)(55016002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?djWwjqoWOYXjWXsAMrqjJ4ujeG0EJKtkMuUfbOsNjttdl3By8vbTJrgDNYI2?=
 =?us-ascii?Q?1QfIlA75qe02uVrc+Y4pPahe/IIdmkPAMoTtMaSTupEaPT1sZEKdegvRE7c+?=
 =?us-ascii?Q?G/u38vNqyDAK2H1JSA6tu/Bw3/I0S5rB7AOwletULmKHQP6267dGx4thhuYw?=
 =?us-ascii?Q?b+VcU19S7ZJxEl6uT8W++gK9oKdZOut2bhMmSdd5RtmxmvqRLQHyiZCe4+xi?=
 =?us-ascii?Q?LhOZXmlIN7UbUu4otELOIF59IRZaFe8h+6DkaxTffhZOncoeaR/KTrxZjewu?=
 =?us-ascii?Q?u5M6/IyJMy7wSYJ4a1EHPiCTd9rGCeVOuVuNI9JplT2fsEzvYbMh9qDQaR+5?=
 =?us-ascii?Q?8q8jrnPn850pklnrujxEnOi6J2ZoiXdXDHPpK3RKzkiV6d//W+9CuxXoSSZx?=
 =?us-ascii?Q?SgUN6sGeRru8uPhgbaM0VF4fN9BBCuZCZb9BfoC9AAGGlD5absrS6e8+Q/8X?=
 =?us-ascii?Q?u76VUG/0Vakywc6tncklHWn+Ah6y3ZnsUv3aci2kq2MlkEB2nYo4VJYO1m83?=
 =?us-ascii?Q?l7uqcIaI8X/ulrYoigrElgCoXYmrynzF2EiZb56nyy2rafiCzVcH5gNhNGEH?=
 =?us-ascii?Q?z9nmLVqOPrDCTXXt6e7rq5mlaKmmP8U5tJyBzcsPmpzNa6xTmRWxHKycNKhX?=
 =?us-ascii?Q?qVnVmT/nvdYtVBXEW6WefqbzML75bv3hQrF49mxyOq4vp67MFRYFsZL7h4b8?=
 =?us-ascii?Q?hPrAZIknh1qH8EcTGmHhr84XluHNd8QYdcYWGNEBHahjJGfR8fBvvZ5upBAk?=
 =?us-ascii?Q?XbGU8Ug7ppFfS4XhCVuHSs9yy0ECtil06OUOnDp9Y/tlrCzk/JQ4UScLwV1T?=
 =?us-ascii?Q?nGiCu4UpWTlurh2mgngwDFqUexg7USHRjkzsNEvgoVvDbOiBf5VKoyMdueAW?=
 =?us-ascii?Q?XfcBSGwQpP8NVyG3HBdgcgr74ZHbT31rhQ9OS1mw8TW0Vss21l8PNXQt06lM?=
 =?us-ascii?Q?ek8nkpL4uT+5/8uKUGo2QOg0TwqrQHP/eBp8PWQ8ueIqIfyUaJT/9IFDA1q0?=
 =?us-ascii?Q?joNKPGc+sl92/OLdfjwFH1g/ur2o8zfhDJQKfvE9gAs3+2cEYQCS5rDif9g/?=
 =?us-ascii?Q?Ci2g8y8tFU7Tm0MroGiC8mYu4ob6kySacFLLXjBNs/SlFTXG/gEK8Y7ezHP+?=
 =?us-ascii?Q?pKIoLywdHKn4TTGJ/wzZaj4XMo00DStROnPcClz6W/TcntN9pPdZFCgwWMfs?=
 =?us-ascii?Q?eW504wGKNEzBz45Zyg1g1X67WOUmwkLDMCJ/VqqrnflzOxI7XvGUGhMIuT9K?=
 =?us-ascii?Q?6rXb9M87mHa28gOtpW2/Ccz0XTjlPUZir4QEI0d4lDd4o27uYMilKjuKQhSl?=
 =?us-ascii?Q?fchQCo6f3DzWdhO/+qbD6Oon?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d6707f-12d5-4eb8-761b-08d8e337a009
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 20:12:11.9986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5M4/D/pwPbB/i2bP5CaIy91miLBnqk0J/W5Tc/dxzuPGwrO9p0PhJA1P6IQNZsBb5smHwR+u5S0i2okbGF6lEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3420
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
Cc: "Keely, Sean" <Sean.Keely@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Tuesday, March 9, 2021 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Keely, Sean <Sean.Keely@amd.com>
> Subject: [PATCH 1/1] drm/amdkfd: Bump KFD API version
> 
> Indicate the availability reliable SRAM EDC state in the new bit
> in the device properties.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 18449f746097..bf5e7d7846dd 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -29,9 +29,10 @@
>  /*
>   * - 1.1 - initial version
>   * - 1.3 - Add SMI events support
> + * - 1.4 - Indicate new SRAM EDC bit in device properties
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 3
> +#define KFD_IOCTL_MINOR_VERSION 4
> 
>  struct kfd_ioctl_get_version_args {
>  	__u32 major_version;	/* from KFD */
> --
> 2.30.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7C8bb8eefe2ce04a31f74a08d8e336f
> ada%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509172574069509%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C1000&amp;sdata=DmZmiISmcNY7rEvli49s5d6JFIvanYqCLFmeM1azFUk%3D
> &amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
