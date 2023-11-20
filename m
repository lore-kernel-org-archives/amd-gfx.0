Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D485C5ACB3
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 02:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D15A10E222;
	Mon, 20 Nov 2023 02:55:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A2910E222
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 02:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSXrFlhBiZAAiBLDa+PaxHtJIxaSDNcYLbrn50zqJx+Mh9nfT9dMIR95eCfARn1d8kImvER+trmKn/WtUfk8mOdVhVzlaU5BDdxFrOsEKrIpG+chJkbT5PemQRMwaYOh+goMYGg9CI0iXRkS3ML/A5TsKYwK+n9erxVte+A/Mgs2Lsun5xZLPiDzkeGt4blKv2O2YbTQ1Zu5hcAsu/P6QgT8XgMc4P6GwKLCJjh423bkfYm70OH6qRr2zOBuwq01wyvs7oNqsnF0+thj5i+ku7o2/P2fCpcJ0+ShOY0Ek5t8mV2XyR+2lHdHaxOLg5Qaos+2pPIE0BtORMwuGTlErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIskbwnvkNRC4+m5T9/rN8ZWDaoYE9wocHlNlVWmoVA=;
 b=gZtJ4NdNp1GxL6k6VFosniKCDMnq1JziEPEh9xqzo17CpvQNm9bkln2+7miJ8pSD6h8E3ikSay6PCyfUS2HJJ+Ompo7V1Ed6R621VbhbEP7e14hFnW0hpKCKmqNIpG+3fd+pAVMQ+WbtOHoyc5M/1ie/7Hcj3Uc7j1ZOslc24Vrutw1pSKTQfNd336/RtOKTR5iUeBbx2a4s8IJqfMkSkz2HwhsSnT7dhH9UnIhwmbseodP24WFUgvW53TAQoEmXo1zsArkOUkT6ebiEJMEwLzLiSAm5Tpjj11lTpkLBS6ElRkTgLIhS4QhVIMTm49ecsYn+F3X887nhTr8gr+RdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIskbwnvkNRC4+m5T9/rN8ZWDaoYE9wocHlNlVWmoVA=;
 b=cRSahRpJvXkRpsEyXF/GzMPUK0+qtttAnAnOSem8EW7/xEI3ur7KaZgJEvc2XBEqyA0rfECXtmCR6fY+n4EwnB6ozRRMwOKRpKtl27pUomztxst9Q1ROK0QpZzB5AsWcodSBcOtnHW7gJbXvP4v+97+6YfE7tCHOjx3XXu8hT5U=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 02:55:35 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 02:55:34 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error
 query
Thread-Topic: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error
 query
Thread-Index: AQHaG1w5kt27zQF/ykOIITEkv8H5MLCCgrBA
Date: Mon, 20 Nov 2023 02:55:34 +0000
Message-ID: <PH7PR12MB79882D3743C00475E46E43539AB4A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231120024855.27697-1-Hawking.Zhang@amd.com>
 <20231120024855.27697-3-Hawking.Zhang@amd.com>
In-Reply-To: <20231120024855.27697-3-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dfdcf4cd-f59e-41f2-ba5c-19e140f9fb6e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-20T02:53:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DS7PR12MB6095:EE_
x-ms-office365-filtering-correlation-id: 0bbbd21e-1ec3-47e4-390e-08dbe9742ab2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VaCpII5CXatwdB1zaq2pTR1T+HvAmLy38Ytf/9gyWgzxP32sC1Cv0idzB8ADG50BVNNn2QG/OME74Aj8aV07fImtsoQPGPU6wtxsjIEK706x4qBmk6y8GbcPrQrvcZ9V6Qb3GGxYdJ4Gyn4jA+wWTId0dhIm8CSO1NxRwcT2ev+Og634rHym9O1vqNB3RgEQAwMM+xcZGkAQCVXhkuhJskBkzEvA+KlLqwYcFds59U3w8Noj3o5dmVEifIJqfxhF9gBw20cdem9DFYATpgoUjPXVBJ6U+xhWgNtyEZxsel/y/i8VSecl4/d+6fNCayd1QT17ysNSdKGVrR4/l3Cg1almpJIzfOgO3UTQ8DKmZgghCtY7hTbNLSdMimg9R+0Fdo9uUSigkDsT/1u01Jh9ObTve2CxnDJklD3ouqlDv3psA/l8A1cqGLyKOsOHEGkuLi8/zEVfEXXckC7EFHd/Lm+7A7GOG8WwbX46zg5rmn0dJmjjPL/0KOoW360C6SB0P1tBpcwCIaWT9fVTUfbQYjmKxYK1Ix7abJJoe5Cdn9kQIJHNm9LAs5nM6diiq1AXOC7PwrXubD2sAYuggAt4hjYTo6ZVO7OK5qTKh5G/+YCP+tsP+KtT+aTbz/T4LJ/u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(53546011)(26005)(9686003)(8676002)(52536014)(8936002)(38100700002)(15650500001)(2906002)(5660300002)(41300700001)(478600001)(6506007)(7696005)(71200400001)(110136005)(76116006)(6636002)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(33656002)(122000001)(86362001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7FJypydOiwgy/LvKZRdrFZTZMweBu/ynxM8WwpOmqyu19vCGQnKnWy6QVMJ2?=
 =?us-ascii?Q?n9Q0PUn34UByxWblvxAmDcif1tu8egtaX8fb396EO675kWR4kfbnvrQY1SwR?=
 =?us-ascii?Q?0KqYx77qRDDQqRydQ27QRAl6Tfu3BXom37hYhOHbKETxK3FuCXDmbPfSlKOf?=
 =?us-ascii?Q?aRIBw6B7SAPaHdlhqQGvl9bES7/nzZyfKHrbrcwRnxjHBRPOUZccz+e86P8n?=
 =?us-ascii?Q?Bc2WQxPajccmyvSErcEwuEVuBBlsxm14cX+Dcplqwdymc772I8BacEFkhtvU?=
 =?us-ascii?Q?lX/jy2tWzp/Kj3+e5M4U3OkZBsOOsRqfpnIQu4GQM3Atesd4BQ6wTAy78rMy?=
 =?us-ascii?Q?/8kX14p4Qj5NcSSpjHqVwrA0aXYnN0pgm8j+/+qGVxQnKsXrom6wZdSIUleE?=
 =?us-ascii?Q?J/kVhqsgE00z06/FEjx+ojtFzh2mgWAOVD7qkHXPoxoN/5oZkXuqhv6awKMh?=
 =?us-ascii?Q?DGqR+Hpg2qwTCk0BsrOzp1y5ZPmbra8uADRJsasiFKOFM6Q5NqlqE3mcB7Tb?=
 =?us-ascii?Q?+ViYjODzSRUMCLXRLVdhhOPA0KTdpSDkdrc4O2bxoTUX5ZbbSM409B+IKxzT?=
 =?us-ascii?Q?4hHtp6swRwwZr8taXKXb3fqh+Ih5hNfmfr/iHReW4PlyULTua3ck0rU6op4A?=
 =?us-ascii?Q?V36sGCSLrjvpiO/hRK02anOUIIppTFeSApHFV+XydswN8Z2TEtJ0wkmUpnn2?=
 =?us-ascii?Q?W0krDWDuCPGM0PYPK+IQBHVYBAb045iaAbyxm8QlnbekoD+BndCWkcCygkT2?=
 =?us-ascii?Q?BKzBlxubYL/dY1kFFIv3ROZcoQo210GWpVEM8Cs9xB2yoaWQf6rYTV6K72cZ?=
 =?us-ascii?Q?Rb6JXJZH9MB9cCx0CZAA88SA2BBUDZtXiOTKDUqLMg7McndIeZPYPcRcAENT?=
 =?us-ascii?Q?OjC+S33LcWjJVmzIWEsjgEtVR192cDb7WQ6NqO+Z3LJNXMDJG+GIkRJMmF2l?=
 =?us-ascii?Q?KikZE+U/u5ZvrD38fdyUFh1LeVaX8BZZ4J7b4AmlNPiasowd5tC19mBCkW9Q?=
 =?us-ascii?Q?5aWK3OQnz7S8Y1/YREz5Fdx26ezSJvq+6ZxadBdllLAkJJBHY1RWLdMnJK+6?=
 =?us-ascii?Q?GYtG+eSvpTieHa9rL+tKv+XMXHXSf5+9461wupF7EBh4c3lBOa/8AD1j6+zv?=
 =?us-ascii?Q?gJUkwiGczMzBTC5eHNoh86rh0p7mNk1f65IbQTPdWMZZfKNkZMt1h4ElPyJx?=
 =?us-ascii?Q?Dm7/V8WBNFnK+7WbWj2YjOYOJkOaw/CgSyqWHNU7sPbkeapj3Gid8A0ebMjV?=
 =?us-ascii?Q?p4hs45k8uIPoa0/HWijbIq/TPVv+z54Ic63F0u9SusQXO6iCL2AvF+a4o5VF?=
 =?us-ascii?Q?AB4NiBgL+tkJ+ovoqy2om/qtPMHoAxIbI/I1Ehx2+AQ6cIsy9bBUtvyVfkXW?=
 =?us-ascii?Q?tMXJZtfXKiiascGufnR6FZqprFAqCLHn/38dhkcRLQqHXbMnNKKe3e/+7R0D?=
 =?us-ascii?Q?5WT+eycxPPhpTJv8zKYaUBIbfRsm7rOjpypCQZAJHM8G6dEbIp9Bz5+VREfZ?=
 =?us-ascii?Q?Mhk+zfzXNiYDESVasCUih8xDCJ230LeUnsdRZgXuWWCD4QkVcuxP8kBn3FNY?=
 =?us-ascii?Q?DItyA+VPvcDkV7DUF7A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbbd21e-1ec3-47e4-390e-08dbe9742ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 02:55:34.4328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oUxbTGLEzvLe6S2SLDDCE5piwj9su41/3ehHvN5XaNg6x/M9gQPr4BuNojNEfrV6aj47zlOcJ1LWH4ZDeVgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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

The series is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, November 20, 2023 10:49 AM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>;
> Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error
> query
>
> Boot time error query is not available till a10109
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 3cf4684d0d3f..5f46877f78cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -821,7 +821,7 @@ static int psp_v13_0_query_boot_status(struct
> psp_context *psp)
>       if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 6))
>               return 0;
>
> -     if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) <
> 0x00a10007)
> +     if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) <
> 0x00a10109)
>               return 0;
>
>       for_each_inst(i, inst_mask) {
> --
> 2.17.1

