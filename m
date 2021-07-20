Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FFC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 10:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B665E610D2
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B665E610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711376E047;
	Tue, 20 Jul 2021 10:22:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9996E047
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 10:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRpEuEvmf+CHNNR038zccP5EXYrvZuGd9Rj/0fIfpiYtFrL1NrHHgrZtJMhYJphs7jZIpz0iwC7SXLFaafbDIrbxoV1APolWW2wGhUUdKpSNtMD0JOl0L8yQVLa2YjOKtdlC0lr3QJL/7wBJxwY+8z4o1FPU+rWfFSnTBF6VN4H9HQFyAr1Gl9gds1YhNiq494ttc5qiZ0XpkRmIrq34Zz5gXUkFWBx4+6WtPHgJmsgsOuhujOiGoDRx94Lx0kaFLb/lzp74bFhEsy+55wASqrC9vvHqMKOcXVTilwYh+1VNUzijLd1AfXj7rnNjn2mPQvHroC3I66ItJjjkTH/TTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noAp7c3Q5ByuwkrudYHrQRn+h3VJuaX5T9Tuh6GdR1Y=;
 b=JfrfLTsLg3KFAK7eyXL5B8gQgxQAv3G+sde0YX9H0u6ImxNYoNhwWnXZwFj3aZC3CHEEhEoOu336R67bTWVG+n/xq9zjLxap+88DukGkGNjoh21W7xtICmkY7k8dM7Pi2m8O5HmtR+iwZyetqHFhbSJ2qONNxlML4rxcnJYBOqe59+T+tOXqVaV7pQ+YqBqww+8wNT0wKVkx39hXVYJYlyPyHoRBoHMO6xVKm9WB39Dpvv6tT0Ip+9naCxPBUjGxwhE3T4TcUYox2ZIrSb9Pz+/f/oGAO6mRcBOhr+kTmjDddY/s2uBhH9S8I3nHpt4i569zW04extKcu62pWR9dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noAp7c3Q5ByuwkrudYHrQRn+h3VJuaX5T9Tuh6GdR1Y=;
 b=YLv5OhnKvB/RRhzjmNM0QqTalPxX/+z9g0UET5v28uivf8lmmnOF5McCk79dCnhAYsG1w25lHzF63yZCOccQY1NS3APIUN4kU7Jsd+15VQxCMnLrisStnDMAyF/vdGZhiayhuyTd5dSlLHLqJdB15UYholLSbhE1kStWCIb7Ynk=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Tue, 20 Jul 2021 10:22:48 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 10:22:48 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add error message when programing registers
 fails
Thread-Topic: [PATCH] drm/amdgpu: Add error message when programing registers
 fails
Thread-Index: AQHXfSxrqr+gHt6jTkuwSN5wj6n0K6tLp2+A
Date: Tue, 20 Jul 2021 10:22:48 +0000
Message-ID: <DM8PR12MB5478B9CEC4F452FA025FE53AF8E29@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210720055748.4397-1-Roy.Sun@amd.com>
In-Reply-To: <20210720055748.4397-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-20T10:22:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cc12e913-e212-4484-8bc4-0115da00dd42;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b306e16-1a1a-4534-acd8-08d94b68528c
x-ms-traffictypediagnostic: DM4PR12MB5184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5184FA0A3430FBFEC1A14ECDF8E29@DM4PR12MB5184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6brTJzD6MtF1vYJ8/HG9ufyaeGEf9plo5B2Ux0nXkJVBXgRojrCXtM8xoKS4duO2lcerLJzVDoM0NIFskNbaIj+TybYkV3lFmqj6+DipvOu1lqWAhzPFukjEXh+EcqrSIwxXOqnfUJKHdd3CGhzbL3L8R2+JmtriYU2T6IlN3acWRghxShXvHuS4vpOlt9Nyz4WVpQBGoTo0BhcuUq/jHmi9EXegwCfadikVv0crGie5Gyqt0LnN0JrKQ+0RauzYMOwHrk9gz72JnZvSzjGHXnR9ninzg2gqzv/80wjqs0By8BTVZzJ82kMOGkRgeTHcg+XlP8quUIwYFIxqttqe5deGt9EA/wsTXA0qTxczaW892qztrerD6e1bhXyTJsxYPfel6V4UAxWwBzdIiziLAclp4lzIue/X5X1bYTexKUVLSAyVIe5AY87+IF/QPlYm9jX6QxAYBO/aWOqT/81SSCECZEPO9qA60zEbcBJ0Bigyydx6mXUC1wiSoL9TNp7ZcQXHd+JbDU1rWSyQj1kOLHm9Pl9bphJRIhSmtWr1C2G+V0SbJQLCnSxEOvlDDBpn2LbeEPyEGGyVnm/HzsCmnksk7OASAcp4nQmR6qgjEUCvN8HyXFWWjzR6/+/JaoCop0+NKZjT8qfrxMo+dTuMVpT8ITEYCDxZ23pXOT3ZAHutOxSp/pZGXo8GubR1q6TJIexfO7aE1vwnUUcIFxA5o/e/eIXEu+jeaTP8gkwV+QOdvNjQikc2uvYQIfAawHxR17EZZFy1smAl3aGNPwV0iUivTJtvsHu57ULjWgTNZLE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(45080400002)(52536014)(8676002)(33656002)(122000001)(4326008)(110136005)(316002)(478600001)(2906002)(66446008)(15650500001)(66476007)(966005)(66946007)(64756008)(7696005)(66556008)(5660300002)(8936002)(76116006)(26005)(83380400001)(186003)(6506007)(86362001)(71200400001)(9686003)(55016002)(38100700002)(53546011)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p0WK8Ll9MXrsfSAR1wMNBJhbVzwzg8wNdtn3GVUjqCWDiYnmtz/xvJjkpBf7?=
 =?us-ascii?Q?aNC67knlIyarliQPsGzTstkXHX5CM+nG9rt+9aGoS0DNRWtK4/m6R/MzaadG?=
 =?us-ascii?Q?DSuG8htvp1d+dLg+cWe9mMWeBMNAo+AK2zE5R9M6fKGlsBzeE4KvvTsjHGi2?=
 =?us-ascii?Q?bUrAbQP4arVDRjgPhGRPS4yR+gMvkjHMtQ6BcmKYLg3c/KisKAlGhQjBB1HR?=
 =?us-ascii?Q?htlkxOwTfSY//osVJBsrYWnNARE9mNoWAYFcmDxIbZVLaoRl1sFQ+uO94PeO?=
 =?us-ascii?Q?wiQMcoRE2VHCYSBpPffEQMqcOpwfpHCAUVd8OZ7GZgZsBpYFzReRgfc2Y9XR?=
 =?us-ascii?Q?Fad8Yh1MEBJS95w05MLDLwUlSJjk9NNsh3EWjeKqNHxAWYrpsFH/GUZbndhS?=
 =?us-ascii?Q?w2FjdzDTM4ihZ+ekSGv81JqX8CZmHCzvYZ+zVtRXgdFDUd6tLR7uoAcL0uhq?=
 =?us-ascii?Q?UILWfZjb9uYLx/uty3kMrYjdP0YM5UrhcdfPtqkaA4OGFix9GP9522W/usEM?=
 =?us-ascii?Q?yndgBmpQAsWs/1NrSZX5AqxtAcQm7bKna6hFLDHE3C7jwWE9MnMk2xP9u2in?=
 =?us-ascii?Q?FKbARdfP3b8fg03A4F8pcez6ewGILpvASRa7wqSxV3mqfnmV50nQMQnRwaF2?=
 =?us-ascii?Q?v3EsK7NcSEGL76hbPRbDge5GqwhUbkNMdH0wYiMQp/wO+UQOCFQ997ZlLhsC?=
 =?us-ascii?Q?/22JDurodnu5wbqN5GqujwS+GfArSnanQUycGAZrm2rYdv0VdCY3AcK22CQH?=
 =?us-ascii?Q?KSTB7XoBmImli81Q/Mb7KQL3Oe7cpisT3lh9P0/NFl25Om1vFdE4l0WHWZsB?=
 =?us-ascii?Q?fFcVYGazedLBJQxdc/ZrvhNhUSz3jh9NF4c63ArNGRM+tlX7/fPjUgUHbfl4?=
 =?us-ascii?Q?QmvWSX9osTpTVWYAd2/gVIEoiX04IOjH80wAswXpEUkh3wM+BqCMfof1bF7i?=
 =?us-ascii?Q?S1a82Ar+4nSZoexcptE9AAqEUhLDEBNXwYk+SroSHg9NYq4Z9Vhv8A4I/zdz?=
 =?us-ascii?Q?uxB6VKpmhqQT7s4uJT3zYkCW4VM/zbTk7tIy5xarZk+2BVqkUW0xYw4zq6p3?=
 =?us-ascii?Q?z+or+PIeNgrQ2ZRkqnj3QkFs0ltlC29YdpRspEkOHZxhurfa3jW+xAYw25Ie?=
 =?us-ascii?Q?QDHECdk6LWWzlURC0igATk/pDfY8nPWD7rlL8JrqLk1W3Y8WriY6I0U8UM8p?=
 =?us-ascii?Q?OgFr+hx9mLVYJSj1ZKI356mIcCPAqd6+X7+SVrhSkAx5zBEMq9/UfVyM+Uvs?=
 =?us-ascii?Q?H3szCf7eJzQrIVCN99ZUN2IQiO9U0PmLx+kXUpt3Qi/dvcl5bF9IcBy1XYZc?=
 =?us-ascii?Q?bzcG1jwQ9VlyLmpA6vFzcq5F?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b306e16-1a1a-4534-acd8-08d94b68528c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 10:22:48.2293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4N1uMdkF98naQmkQ1rMA42yfJC5Ad+RwOR2wf1hfwryF7qpgYAti7TA0zMK6R12EO4NfJClYH1zKziVzvQJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
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
Cc: "Sun, Roy" <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Update inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roy Sun
> Sent: Tuesday, July 20, 2021 1:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sun, Roy <Roy.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Add error message when programing registers
> fails
> 
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index bc4347a72301..67a6fffd528b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -56,6 +56,10 @@
>  #define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	1
>  #define GFX10_MEC_HPD_SIZE	2048
> 
> +#define RLCG_INTERFACE_NOT_ENABLED	0x4000000
> +#define RLCG_WRONG_OPERATION_TYPE	0x2000000
> +#define RLCG_NOT_IN_RANGE	0x1000000
> +
>  #define F32_CE_PROGRAM_RAM_SIZE		65536
>  #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
> 
> @@ -185,6 +189,9 @@
>  #define GFX_RLCG_GC_READ	(0x1 << 28)
>  #define GFX_RLCG_MMHUB_WRITE	(0x2 << 28)
> 
> +#define RLCG_ERROR_REPORT_ENABLED(adev) \
> +	(amdgpu_sriov_reg_indirect_mmhub(adev) ||
> amdgpu_sriov_reg_indirect_gc(adev))
> +
>  MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
>  MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/navi10_me.bin");
> @@ -1523,9 +1530,9 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device
> *adev, u32 offset, u32 v, uint32
>  		writel(v, scratch_reg0);
>  		writel(offset | flag, scratch_reg1);
>  		writel(1, spare_int);
> -		for (i = 0; i < retries; i++) {
> -			u32 tmp;
> +		u32 tmp;
> 
> +		for (i = 0; i < retries; i++) {
>  			tmp = readl(scratch_reg1);
>  			if (!(tmp & flag))
>  				break;
> @@ -1533,8 +1540,19 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device
> *adev, u32 offset, u32 v, uint32
>  			udelay(10);
>  		}
> 
> -		if (i >= retries)
> -			pr_err("timeout: rlcg program reg:0x%05x failed !\n",
> offset);
> +		if (i >= retries) {
> +			if (RLCG_ERROR_REPORT_ENABLED(adev)) {
> +				if (tmp & RLCG_INTERFACE_NOT_ENABLED)
> +					pr_err("The interface is not enabled,
> program reg:0x%05x failed!\n", offset);
Rlcg interface is here, but rlcg vfgate is closed, Can we print rlcg vfgate is disabled?
> +				else if (tmp &
> RLCG_WRONG_OPERATION_TYPE)
> +					pr_err("Wrong operation type,
> program reg:0x%05x failed!\n", offset);
> +				else if (tmp & RLCG_NOT_IN_RANGE)
> +					pr_err("The register is not in range,
> program reg:0x%05x failed!\n", offset);
> +				else
> +					pr_err("Unknown error type, program
> reg:0x%05x failed!\n", offset);
> +			} else
> +				pr_err("timeout: rlcg program reg:0x%05x
> failed!\n", offset);
> +		}
>  	}
> 
>  	ret = readl(scratch_reg0);
> --
> 2.32.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPengju.Zhou%40amd.com%7Ca462e6a099324085
> 069308d94b438cb4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37623575771035281%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hn
> AyuX7Zx7fg0jN4d61Up48dimBSKRMomfN44UFEliE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
