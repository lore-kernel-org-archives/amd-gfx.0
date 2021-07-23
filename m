Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F76C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 13:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C1360EB1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 13:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3C1360EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E3B6E055;
	Fri, 23 Jul 2021 13:35:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071236E055
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 13:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBh/2YuwUVhd4J3/oc4QwWEuRhvl4xr739lKzDEZNOIE90cf+BB8tuaV6C6z8rEGE5Al7o86YdUPC0tzk0l0cikkoQjvtWFU1MH4ha1I5EmHg5tm3e2WYTQjwxRjl8u7oK0PwhJDVk6QvlRsIeev42Q1O8NQlvaOuxFb9GCxdB6v51nBa1X6uelrnM7DiKwnbgWHX+uhokegUWvhffsuKBdAUjdOEw8KQS36Ofw33QQrgZEAxSoNs9WMN4eUxBHcOWHjYhzYEcDju/y3GovzqypUiuhoQH2m+tbSOcBOzm54K3PINMoXlJUNFVd6noIZcqsC5E3Q6wisdCVpO3LtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF2YE8Ztl9CDPbdH47Un6ANewP3EBFiyQss9pCESWhg=;
 b=MAkLjMI5wJmIVyghNobI0JaZnY8Wp9zKNEGKO/82ZI1cS/glqDS2DJU+8bpBxO01VszjTbNiiI47eZ0dDjhPOAaRONbMEArtsA23JeMumGIooB2qgW4Q1jMT85zDxZMKhcI8A/6FP4JfwwAln2J0+A0p9FVh+N4QsPDzDZUK7sUHvrWZpKzUeXx7WuoHbr2txRcVe7CspII0xa6YG3JUiig7Z2YCuEjxBuQNboW/JRw2GGSNfVWvY7RD8HeqA1ZSZywAYyP1xz1i2YiXfjGd32LDXs9fMY0orEFqfkbbnXVtMsDeoRqMOWwmMJB4o3md2MMga+ku1ueFrgrSvmTFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF2YE8Ztl9CDPbdH47Un6ANewP3EBFiyQss9pCESWhg=;
 b=LgO/PllpOoNKCx5vx6Z/QXkwKg8egZUTxC2alP7x3+EaJuLR+pjuyRX6CmIvg0HMUuPyEQP30dZ9PIt+H7Z9BHGHfMJXcFjxdPINBLxVccHLt3ym2JxE1rQhUpOk990TGi+8XC/QL3jVwuJlBs/sloWvViWEBVqWAwITyj0OB/M=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 13:35:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 13:35:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXf6KArp1evGMI8Ui4R5MXjboX7atQVlYAgAA5bTk=
Date: Fri, 23 Jul 2021 13:35:45 +0000
Message-ID: <BL1PR12MB51440587093D45E69AFEDF1DF7E59@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210723090933.806633-1-evan.quan@amd.com>,
 <1b728523-e245-13f1-b649-ca422d29594a@amd.com>
In-Reply-To: <1b728523-e245-13f1-b649-ca422d29594a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-23T13:35:45.538Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db88d3bd-433b-4393-dff3-08d94ddec6a8
x-ms-traffictypediagnostic: BL1PR12MB5080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5080BEC2B721CD34E3A5BA26F7E59@BL1PR12MB5080.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDFbPUrLEb80aF/X4+/A1tkKO1EAYWVQzIIbEzxxgsw5Xrij/nITzWJPBibacq9Xvo02rpwP1jqC7HFsFDNkl6AE4+TgjbR8k9CRp1DoxOIwN99JZLRWOsiWcLuHKue2mBssXah/lJ5/fozGuyCDtRD4n0NNY3Vjn1aUogqCByBTopQo0rfD8rWmti9ptZpjavzPUTs1TbKeFFnQeagNBTl05jAaB5SnlAZfrRSANRA49luvDEqMfB10xEKbsw98f+5BKPlHOO4pgg/EU7xBo64bLjRisGiukDUmt1WOsmx6G5BE/1djhLn9CQXLSDl9KC0n5URFcyRciy6H9pDiGbAzHBVMzLUinWS+NQIleqoyYWGQzcmV1XC8gnkd6itf35PU6v9h5ADGhSP9/SeQ4CQsplMF1g2TNc8AAH7g67S5k2exeHtyVt8Jo8Blx1eM5/fbHDWTxCD8hmPtucl9J11/o47d0lUy/5ikeRvfyoEgZpGo9YReypIGZdaGD4Ksz1rGVbeNvT8DmIEzBPvgDEn/iVTmZ7ORXhkowC59dTh4Gw5ZDA9RYyLtzqk5IXOavaZqmcMtWI4S7/j9N0qUsf4BKs3N3YDgJ2+QPpQSTFNUdsvK42F5Y6/8wVFVPxhaNHd9uFKxkQq9uPujUNJvze1xspVuFY2ImqmFRXpA7UqmwpevTIMAwELwh+/2OSwvNNq1lRf7HKxmcvYoa6mK5E/TI44NoXgntDVSeUM7r6U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(478600001)(66946007)(122000001)(55016002)(110136005)(9686003)(8936002)(8676002)(316002)(7696005)(2906002)(83380400001)(6506007)(19627405001)(26005)(53546011)(66574015)(33656002)(86362001)(52536014)(38100700002)(5660300002)(71200400001)(76116006)(66476007)(186003)(66556008)(64756008)(66446008)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Si2H+dOQzdfazF1e774YopVTKx01iqONNc1cOylgc1TXgHyt3rw8NOaqtRM1?=
 =?us-ascii?Q?z+lvu7Z9O1Y84EA11yUalTklsUEAE52m//KxOWWpfiq3dV7jfQ84A4LMjnzF?=
 =?us-ascii?Q?RCjmy4QXCs8hGFSQLa+w9OooiKRMjrT++/DBQiQHixEIx+5N17uexyUnoqVC?=
 =?us-ascii?Q?q9zUkPhP1N1U+FpnAP/FKp/KYL1hT9QmAXEGkcpZ3jRxrT6ILGLKqOIjN4Ae?=
 =?us-ascii?Q?dS7NUekpO5KKTykZsvQH5V4wRtPryvDP/05nqdQwvfzaFrc+715zph9nPFDZ?=
 =?us-ascii?Q?CUctjj4aQ8PfSGfYAuY2pUFr9VmTGeobW5JYbfzCASR4saCTj0Iq2xYoMmH8?=
 =?us-ascii?Q?yTkhVFzHyYVlKVKxCWArmDhwl7ul61/zNmidnEO9vFfq5fPMAZylugT3zJxq?=
 =?us-ascii?Q?Eh5usCrEDuMBx1HhMB2p14+TelqQ4TJeCbcNkmImIvsEnuAxWKlqfwLL4ipg?=
 =?us-ascii?Q?NyTNYRwdUrAs28ienU86ZgLfNZnwJqnH9dzNjoyc1ZRE7lI378d0nt1GMAcX?=
 =?us-ascii?Q?Si1R9p/ZAZmw69531T6ri6xrNmgozAeuw5Tl//q+vSx+i7HBeNyWOmxZkwIo?=
 =?us-ascii?Q?ir+wvdKQywOZt0b7/gjB2ctJQshgOk0JNUFVjBfZhx3P1IUVHL/Eto1BQeOD?=
 =?us-ascii?Q?vMz5S7xktXkXXRRJJXaKzth0yutDEzgpDOFNMri6sbPWI9f4737AGADuIU0F?=
 =?us-ascii?Q?/1DZd/ag0MK05VAiAYW9EE4i1rJywkn32gVXAk+/p56MOIpeBRy3y7qeQrMp?=
 =?us-ascii?Q?GhkEJayhilqhGwWszQejlOnDOv0dQ22h4AUvLLWFlRwhSnAF551QBd+pFf1t?=
 =?us-ascii?Q?Gx3U/sYewNkQyn2AbOjCnK1Yd+Cr9CmxgZCfXCZy6z51sMfMYYWY+vHct/0f?=
 =?us-ascii?Q?ERXf7Gh7vakGQKI3cjoBJpHFLZFeeMK0oQ3GLvzTsBqp0EZIZuIRYUUcPTau?=
 =?us-ascii?Q?3G7Ho3S57f8XwVFF6x/eSEJcELe48Mr+wiaTnVs4ex8qajAX94Z/Mu9LMMz9?=
 =?us-ascii?Q?QSaVdpCsINMeaAa/qy0OYvK/ANXy83lbyEXWyOrteRlvzztXvSIM/Z2KkYkh?=
 =?us-ascii?Q?yhaMdFYLvkIgWuVUVjddIMilIx286+RZ8buPJaM8oDRZrs3TYIaIpXjjIVaV?=
 =?us-ascii?Q?1mGSX7UZs45DphGQrv4k/lRlyRBuwxXFtoxtfCYZ9emWbmCB3k5psvsrmQX8?=
 =?us-ascii?Q?SFvyz7K3eMPuWhv6YXzlrt5AkP5UAHp8X3wm9RGnHqvp/9NEZUFk9GnjHGat?=
 =?us-ascii?Q?qu/6uqBZpkaNxb9WN/QHHFG5o2ndzGATHRT20OleMbFvSXTaS8c2h+mnSgKF?=
 =?us-ascii?Q?DtAbniHBIV17UZFaB3ygB6Tx?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db88d3bd-433b-4393-dff3-08d94ddec6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 13:35:45.9495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyAOXIFP+anxeXNp7bloIl4StvRsxKBMh/BlJjMwMVnk60F0BjRJMjwIHZOCUw1TFKTump0kTAPvZ0iwa9+8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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
Content-Type: multipart/mixed; boundary="===============1809025762=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1809025762==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB51440587093D45E69AFEDF1DF7E59BL1PR12MB5144namp_"

--_000_BL1PR12MB51440587093D45E69AFEDF1DF7E59BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I haven't had a chance to look at the patches too closely, but if it could =
be done in a generic may, that makes sense to me.  Maybe as a follow up pat=
ch?

Alex

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, July 23, 2021 6:09 AM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings=
 properly for NV1x

The series looks good to me, though I prefer to use a common logic to
restore od settings so that smuv12,smuv13 gets the restore feature by
default once they add the user table logic. Don't have strong argument
for it unless Alex, Kenneth or others have some comments.

Anyway, the series is
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 7/23/2021 2:39 PM, Evan Quan wrote:
> The customized OD settings can be divided into two parts: those
> committed ones and non-committed ones.
>    - For those changes which had been fed to SMU before S3/S4/Runpm
>      suspend kicked, they are committed changes. They should be properly
>      restored and fed to SMU on S3/S4/Runpm resume.
>    - For those non-committed changes, they are restored only without feed=
ing
>      to SMU.
>
> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2
>    - better naming and logic revised for checking OD setting update(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 55 +++++++++++++------
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++
>   5 files changed, 82 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_smu.h
> index 3e89852e4820..c2c201b8e3cf 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
>        uint32_t power_limit;
>        uint32_t fan_speed_percent;
>        uint32_t flags;
> +     uint32_t user_od;
>
>        /* user clock state information */
>        uint32_t clk_mask[SMU_CLK_COUNT];
> @@ -352,6 +353,7 @@ struct smu_table_context
>
>        void                            *overdrive_table;
>        void                            *boot_overdrive_table;
> +     void                            *user_overdrive_table;
>
>        uint32_t                        gpu_metrics_table_size;
>        void                            *gpu_metrics_table;
> @@ -623,6 +625,12 @@ struct pptable_funcs {
>                                 enum PP_OD_DPM_TABLE_COMMAND type,
>                                 long *input, uint32_t size);
>
> +     /**
> +      * @restore_user_od_settings: Restore the user customized
> +      *                            OD settings on S3/S4/Runpm resume.
> +      */
> +     int (*restore_user_od_settings)(struct smu_context *smu);
> +
>        /**
>         * @get_clock_by_type_with_latency: Get the speed and latency of a=
 clock
>         *                                  domain.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd=
/pm/inc/smu_v11_0.h
> index 385b2ea5379c..1e42aafbb9fd 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *smu=
);
>
>   int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
>
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..8ca7337ea5fc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_=
context *smu)
>                }
>        }
>
> +     /* Restore user customized OD settings */
> +     if (smu->user_dpm_profile.user_od) {
> +             if (smu->ppt_funcs->restore_user_od_settings) {
> +                     ret =3D smu->ppt_funcs->restore_user_od_settings(sm=
u);
> +                     if (ret)
> +                             dev_err(smu->adev->dev, "Failed to upload c=
ustomized OD settings\n");
> +             }
> +     }
> +
>        /* Disable restore flag */
>        smu->user_dpm_profile.flags &=3D ~SMU_DPM_USER_PROFILE_RESTORE;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..d7722c229ddd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(struct =
smu_context *smu)
>                (OverDriveTable_t *)smu->smu_table.overdrive_table;
>        OverDriveTable_t *boot_od_table =3D
>                (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> +     OverDriveTable_t *user_od_table =3D
> +             (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
>        int ret =3D 0;
>
> -     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)o=
d_table, false);
> +     /*
> +      * For S3/S4/Runpm resume, no need to setup those overdrive tables =
again as
> +      *   - either they already have the default OD settings got during =
cold bootup
> +      *   - or they have some user customized OD settings which cannot b=
e overwritten
> +      */
> +     if (smu->adev->in_suspend)
> +             return 0;
> +
> +     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)b=
oot_od_table, false);
>        if (ret) {
>                dev_err(smu->adev->dev, "Failed to get overdrive table!\n"=
);
>                return ret;
>        }
>
> -     if (!od_table->GfxclkVolt1) {
> +     if (!boot_od_table->GfxclkVolt1) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt1,
> -                                                             od_table->G=
fxclkFreq1);
> +                                                             &boot_od_ta=
ble->GfxclkVolt1,
> +                                                             boot_od_tab=
le->GfxclkFreq1);
>                if (ret)
>                        return ret;
>        }
>
> -     if (!od_table->GfxclkVolt2) {
> +     if (!boot_od_table->GfxclkVolt2) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt2,
> -                                                             od_table->G=
fxclkFreq2);
> +                                                             &boot_od_ta=
ble->GfxclkVolt2,
> +                                                             boot_od_tab=
le->GfxclkFreq2);
>                if (ret)
>                        return ret;
>        }
>
> -     if (!od_table->GfxclkVolt3) {
> +     if (!boot_od_table->GfxclkVolt3) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt3,
> -                                                             od_table->G=
fxclkFreq3);
> +                                                             &boot_od_ta=
ble->GfxclkVolt3,
> +                                                             boot_od_tab=
le->GfxclkFreq3);
>                if (ret)
>                        return ret;
>        }
>
> -     memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> +     navi10_dump_od_table(smu, boot_od_table);
>
> -     navi10_dump_od_table(smu, od_table);
> +     memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> +     memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
>
>        return 0;
>   }
> @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_TABL
>                memcpy(table_context->overdrive_table, table_context->boot=
_overdrive_table, sizeof(OverDriveTable_t));
>                break;
>        case PP_OD_COMMIT_DPM_TABLE:
> -             navi10_dump_od_table(smu, od_table);
> -             ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (=
void *)od_table, true);
> -             if (ret) {
> -                     dev_err(smu->adev->dev, "Failed to import overdrive=
 table!\n");
> -                     return ret;
> +             if (memcmp(od_table, table_context->user_overdrive_table, s=
izeof(OverDriveTable_t))) {
> +                     navi10_dump_od_table(smu, od_table);
> +                     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRI=
VE, 0, (void *)od_table, true);
> +                     if (ret) {
> +                             dev_err(smu->adev->dev, "Failed to import o=
verdrive table!\n");
> +                             return ret;
> +                     }
> +                     memcpy(table_context->user_overdrive_table, od_tabl=
e, sizeof(OverDriveTable_t));
> +                     smu->user_dpm_profile.user_od =3D true;
> +
> +                     if (!memcmp(table_context->user_overdrive_table,
> +                                 table_context->boot_overdrive_table,
> +                                 sizeof(OverDriveTable_t)))
> +                             smu->user_dpm_profile.user_od =3D false;
>                }
>                break;
>        case PP_OD_EDIT_VDDC_CURVE:
> @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
>        .set_soft_freq_limited_range =3D smu_v11_0_set_soft_freq_limited_r=
ange,
>        .set_default_od_settings =3D navi10_set_default_od_settings,
>        .od_edit_dpm_table =3D navi10_od_edit_dpm_table,
> +     .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
>        .run_btc =3D navi10_run_btc,
>        .set_power_source =3D smu_v11_0_set_power_source,
>        .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0a5d46ac9ccd..7aa47dbba8d8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *s=
mu)
>                        ret =3D -ENOMEM;
>                        goto err3_out;
>                }
> +
> +             smu_table->user_overdrive_table =3D
> +                     kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNE=
L);
> +             if (!smu_table->user_overdrive_table) {
> +                     ret =3D -ENOMEM;
> +                     goto err4_out;
> +             }
> +
>        }
>
>        return 0;
>
> +err4_out:
> +     kfree(smu_table->boot_overdrive_table);
>   err3_out:
>        kfree(smu_table->overdrive_table);
>   err2_out:
> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *s=
mu)
>        struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>
>        kfree(smu_table->gpu_metrics_table);
> +     kfree(smu_table->user_overdrive_table);
>        kfree(smu_table->boot_overdrive_table);
>        kfree(smu_table->overdrive_table);
>        kfree(smu_table->max_sustainable_clocks);
>        kfree(smu_table->driver_pptable);
>        kfree(smu_table->clocks_table);
>        smu_table->gpu_metrics_table =3D NULL;
> +     smu_table->user_overdrive_table =3D NULL;
>        smu_table->boot_overdrive_table =3D NULL;
>        smu_table->overdrive_table =3D NULL;
>        smu_table->max_sustainable_clocks =3D NULL;
> @@ -2101,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_contex=
t *smu,
>
>        return ret;
>   }
> +
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
> +{
> +     struct smu_table_context *table_context =3D &smu->smu_table;
> +     void *user_od_table =3D table_context->user_overdrive_table;
> +     int ret =3D 0;
> +
> +     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)u=
ser_od_table, true);
> +     if (ret)
> +             dev_err(smu->adev->dev, "Failed to import overdrive table!\=
n");
> +
> +     return ret;
> +}
>

--_000_BL1PR12MB51440587093D45E69AFEDF1DF7E59BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I haven't had a chance to look at the patches too closely, but if it could =
be done in a generic may, that makes sense to me.&nbsp; Maybe as a follow u=
p patch?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, July 23, 2021 6:09 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD s=
ettings properly for NV1x</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The series looks good to me, though I prefer to us=
e a common logic to
<br>
restore od settings so that smuv12,smuv13 gets the restore feature by <br>
default once they add the user table logic. Don't have strong argument <br>
for it unless Alex, Kenneth or others have some comments.<br>
<br>
Anyway, the series is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Lijo Lazar &lt;lijo=
.lazar@amd.com&gt;<br>
<br>
On 7/23/2021 2:39 PM, Evan Quan wrote:<br>
&gt; The customized OD settings can be divided into two parts: those<br>
&gt; committed ones and non-committed ones.<br>
&gt;&nbsp;&nbsp;&nbsp; - For those changes which had been fed to SMU before=
 S3/S4/Runpm<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend kicked, they are committed chang=
es. They should be properly<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restored and fed to SMU on S3/S4/Runpm r=
esume.<br>
&gt;&nbsp;&nbsp;&nbsp; - For those non-committed changes, they are restored=
 only without feeding<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to SMU.<br>
&gt; <br>
&gt; Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
&gt; --<br>
&gt; v1-&gt;v2<br>
&gt;&nbsp;&nbsp;&nbsp; - better naming and logic revised for checking OD se=
tting update(Lijo)<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 8 +++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 9 +++<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | =
55 +++++++++++++------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbs=
p; | 25 +++++++++<br>
&gt;&nbsp;&nbsp; 5 files changed, 82 insertions(+), 17 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm=
/amd/pm/inc/amdgpu_smu.h<br>
&gt; index 3e89852e4820..c2c201b8e3cf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_limit;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fan_speed_percent;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t user_od;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user clock state informat=
ion */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_mask[SMU_CLK_CO=
UNT];<br>
&gt; @@ -352,6 +353,7 @@ struct smu_table_context<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *overdrive_=
table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *boot_overd=
rive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *user_overdrive_table;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics_table_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_metric=
s_table;<br>
&gt; @@ -623,6 +625,12 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND=
 type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *input, uint32_t size);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @restore_user_od_settings: Restore t=
he user customized<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD settings on S3/S4/Run=
pm resume.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*restore_user_od_settings)(struct smu_c=
ontext *smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_clock_by_type_w=
ith_latency: Get the speed and latency of a clock<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; domain.<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/=
amd/pm/inc/smu_v11_0.h<br>
&gt; index 385b2ea5379c..1e42aafbb9fd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *=
smu);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int smu_v11_0_set_light_sbr(struct smu_context *smu, bool =
enable);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index ebe672142808..8ca7337ea5fc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct s=
mu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Restore user customized OD settings */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;user_dpm_profile.user_od) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (smu-&gt;ppt_funcs-&gt;restore_user_od_settings) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_fun=
cs-&gt;restore_user_od_settings(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to uplo=
ad customized OD settings\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable restore flag */<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.fla=
gs &amp;=3D ~SMU_DPM_USER_PROFILE_RESTORE;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; index 59ea59acfb00..d7722c229ddd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(stru=
ct smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (OverDriveTable_t *)smu-&gt;smu_table.overdrive_table;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *boot_od_ta=
ble =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (OverDriveTable_t *)smu-&gt;smu_table.boot_overdrive_ta=
ble;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *user_od_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (OverDriveTable_t *)smu-&gt;smu_table.user_overdrive_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)od_table, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For S3/S4/Runpm resume, no need to s=
etup those overdrive tables again as<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - either they already ha=
ve the default OD settings got during cold bootup<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - or they have some user=
 customized OD settings which cannot be overwritten<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;in_suspend)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)boot_od_table, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to get overd=
rive table!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt2) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt2) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt3) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt3) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt3,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq3);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memcpy(boot_od_table, od_table, sizeof(OverD=
riveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(smu, boot_od_table);<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(smu, od_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(od_table, boot_od_table, sizeof(OverD=
riveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(user_od_table, boot_od_table, sizeof(=
OverDriveTable_t));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu=
_context *smu, enum PP_OD_DPM_TABL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(table_context-&gt;overdrive_table, table_context=
-&gt;boot_overdrive_table, sizeof(OverDriveTable_t));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_COMMIT_DPM_TABLE:=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; navi10_dump_od_table(smu, od_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_ta=
ble, true);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&g=
t;dev, &quot;Failed to import overdrive table!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (memcmp(od_table, table_context-&gt;user_overdrive_table, sizeof(Ove=
rDriveTable_t))) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(sm=
u, od_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_=
table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to impo=
rt overdrive table!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(table_context-&g=
t;user_overdrive_table, od_table, sizeof(OverDriveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profil=
e.user_od =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!memcmp(table_conte=
xt-&gt;user_overdrive_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;boot_ove=
rdrive_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(OverDriveTable_t)))=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.user_od =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_EDIT_VDDC_CURVE:<=
br>
&gt; @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_fun=
cs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_soft_freq_limited_range=
 =3D smu_v11_0_set_soft_freq_limited_range,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_od_settings =3D=
 navi10_set_default_od_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .od_edit_dpm_table =3D navi1=
0_od_edit_dpm_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .restore_user_od_settings =3D smu_v11_0_rest=
ore_user_od_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_btc =3D navi10_run_btc,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_source =3D smu_v1=
1_0_set_power_source,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D smu=
_cmn_get_pp_feature_mask,<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; index 0a5d46ac9ccd..7aa47dbba8d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r3_out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu_table-&gt;user_overdrive_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(tables[SMU_TABL=
E_OVERDRIVE].size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu_table-&gt;user_overdrive_table) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err4_out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +err4_out:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;boot_overdrive_table);<b=
r>
&gt;&nbsp;&nbsp; err3_out:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;overdriv=
e_table);<br>
&gt;&nbsp;&nbsp; err2_out:<br>
&gt; @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_=
dpm =3D &amp;smu-&gt;smu_dpm;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;gpu_metr=
ics_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;user_overdrive_table);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;boot_ove=
rdrive_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;overdriv=
e_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;max_sust=
ainable_clocks);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;driver_p=
ptable);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;clocks_t=
able);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_ta=
ble =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;user_overdrive_table =3D NULL;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;boot_overdrive=
_table =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;overdrive_tabl=
e =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;max_sustainabl=
e_clocks =3D NULL;<br>
&gt; @@ -2101,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_con=
text *smu,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +int smu_v11_0_restore_user_od_settings(struct smu_context *smu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D =
&amp;smu-&gt;smu_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *user_od_table =3D table_context-&gt;us=
er_overdrive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)user_od_table, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to import overdrive table!\n=
&quot;);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440587093D45E69AFEDF1DF7E59BL1PR12MB5144namp_--

--===============1809025762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1809025762==--
