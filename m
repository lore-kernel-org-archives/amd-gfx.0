Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC8BC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 14:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD2761A02
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD2761A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0361E6F3CF;
	Fri, 26 Mar 2021 14:12:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCCB46F3CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 14:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6dyA2n+9ldLomO3OSuX1H8/fvM4ZLk/K0KIHCAl1l4e+vwKGmRVk7lGAlBg1fnScS+Ok5YBhaJnLTTjO29Dwp6CUD58myx2MCU+cZcGh34qgL6Wmp+49IZBHENxZZA24yant7A6AYXfS5/efn5au0lF/xYj7DNowyKGR1ozrtUIVy0O5P/8mvkXVzURq9EHMEham4aqDMrq80pSSQMnhetXDmFmYRj6WJxW7VMId/s2b+FkNBXTWwI1ilwLHkj3ZMvYxmnVq+MQR7XoS7LeatNW97y8FSmSxeTdWmO3l1IvprOzuOOz0H8FhZEFApzBe+aHO7hJAWl1Jo1LrVXmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXm6RFFnc4BYodlz0XRts+uwKf7AuFQoBxWAed5eBY=;
 b=gAwd8pieZ2R36XoYTPOs2NvSn+Xya8ECLSpEw5xEGKee1Oize7CkhpMF8kjfxbXobJx9nwF9NYEWV++iuoW6iCORLkJ+isYWDAyzveEmM7sgM3M5tVqwCRZvOxhLOziadtXqfTPEsO9n9xPU7/pgY3nBEUrBMtlj20SFzv0BAxKgmrN2cvNcf8q94XaxU+d8IfjQ5hz1x41M98z2BX302VCPc78WvWq5AKiK7r3q4YbUYQ7dwWZ+9MQlp++gwr+9u+ZS62ARpMz2HFqBwY7ARLZSeN/mGou6WR0eiXYPLL6dFHsHl/2QGt8hhHXNttz02sE5R5urOzD8TkYI9MM2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXm6RFFnc4BYodlz0XRts+uwKf7AuFQoBxWAed5eBY=;
 b=G9jK7ITMJHb4+3JmoVgP/lWDEZ2lQT138Y0gSXkmoMkESZLBcccBTbFHubEffQZDPuOA8ZU4N8k+vswSjZ+OebMLH2IRwnZtQC7hQe5aF5S0vtL8/Sj71mc7npXyPSCPllkKIjyFw9vSjBdkDfmWEC6SAQHoKm7U2qvgisNnzOc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 14:12:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 14:12:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Topic: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Index: AQHXIfnGasn5xOE6L06i0xngRb/DoqqVwtuAgACNBLY=
Date: Fri, 26 Mar 2021 14:12:05 +0000
Message-ID: <MN2PR12MB448857020BBBAEDEC70B6FB0F7619@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210326043731.779691-1-alexander.deucher@amd.com>,
 <DM6PR12MB2971DB53BDFD4B623C368A619E619@DM6PR12MB2971.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2971DB53BDFD4B623C368A619E619@DM6PR12MB2971.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-26T14:12:04.692Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d2143af-529b-43ed-b5d7-08d8f061226b
x-ms-traffictypediagnostic: BL0PR12MB2436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24366D8B75242FC7DAB88425F7619@BL0PR12MB2436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ujGUusRlnCL5aVANh53pWfyzOSyqhzU4JjYprnLZ2GuoHaOC1oin9BKTH/Zb3ZeUeYgN0CMyEH1UfmXu6mvJkuOtOIr5crZ1S1e3Bxmz8RSpznUHnRFSGeLyXdAeDT80ATlB7E5Vs4swzAlK/6zN4u05g9qG+ryZ0Ilbq5MCfZeuVyDwBoEqKt/aO5ZENP7nLWuMryri0HulQlvPmB0kHwrP5DueTFzzcPmkLPS967Fj4H2dRFbRSCIvxMZxTkR03GnPdF7KYPomBNNdQsyxax7YTni0yOKriVGsEyWIygct4t5hKZC6lpC6s3yUGaRuembIguqPunEoWZRYVMZ8B3GUl/vvkzCkvk9VnvfdmdeA+bwmnok7ZPQ2dcIFiv9JHMga7lJGkNO41W5PkQRpYnfDkcpLVXPa6HBuR4Jti1ZT5MmuhsuLmyw9WQKFrvqByu2ElIyP+5jK2EGJdfqQSz4DhXFbdqsm5oPBC2/xTorawcu6+ZzWMkz/fCwcmca3Vhaee1JynvgGL147ZjxOOyimz1iUlmTUfeSui/9AK408JmFyvmm4xAeU7Z2U2+X64mDP/gT3QQPjmDMS1nRk78uxqWDFVoTYzSDatFlVkY86KmDILhCG8t5GgVmBweR0yxf0xGohm0GSSftLVSCSaTdGpmrHPexdazY5sCWlLoh3nfu1dIAPRsu5pzDJMcDwXTGRyFytzNKzwWp//uflifStfDlX4lBVAf1ZUwfqFblCfNaBImCgYRlsaTLbPdR4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(110136005)(38100700001)(6506007)(478600001)(7696005)(66946007)(2906002)(83380400001)(55016002)(19627405001)(8676002)(45080400002)(86362001)(316002)(166002)(26005)(8936002)(52536014)(64756008)(66556008)(966005)(5660300002)(71200400001)(9686003)(66446008)(186003)(53546011)(76116006)(33656002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MUdDDmq2+QShjKuMjmq9AsxybzQYdSB+sF941hmGYVoEzopxZ/wsVOzMVFed?=
 =?us-ascii?Q?locHCdTNQ+MW8UneOcXxfEw/rE2+Rp97cWXsbiQfwRUbDLrlqPTXbz9fuCnF?=
 =?us-ascii?Q?7jKeRgKM1HDw2mwfbx1id+FAZHmYW6obbgPlbKIpvVstmvfHiekpKklmvKTX?=
 =?us-ascii?Q?/1JNvxT0yFHcWHGfGXAyLlhOljOcRd5N4AvlRZ7DaOblwFML1QCzlIzVcMGA?=
 =?us-ascii?Q?kTIZ2o8Aeow7pnqTty7v/u7Qw00Ca7fMhhzpYtYFwN6soHGDOh0d0FBkyo1a?=
 =?us-ascii?Q?i5/KGNbD3mNHgcGHJJ4gvK9J8L4G7qOMhpwoi0Idvtv/yfEA1YSM8Gr2RJrH?=
 =?us-ascii?Q?f0oCkKgoLl5FF0scbkzCsLP10DG9/DQ4D32rMC8HTw9FagkqZTkek0k67564?=
 =?us-ascii?Q?DeaXkCWHA+YolXLUIp8+JoddMnfN56/oreD1p2XO8OkaHzUIFT8HslYRsy6N?=
 =?us-ascii?Q?AtL4szLGw8Nr308DO4VyLUvKX3B3nL6vu2BjNrkMwbZZPzgugUVSH1Rt+jIG?=
 =?us-ascii?Q?4DkD2ZCa9BgRrtmSHfdfHNq2pJvjfRXWT4pyE7s41z3j/Q8SJsBe9RkYYuE+?=
 =?us-ascii?Q?ZbUBYZ/pkCE280AGcmY3f7yIgL/Crb7RTrWYheWrf8QK+HsQ3ECg33zQU6HK?=
 =?us-ascii?Q?kz7/fqrHHg5TcYr6Wyn0zDRZr08++krn1X3XJIKOhCdPYj4E3qYd0h5uoRoS?=
 =?us-ascii?Q?kg/wb4mfPnXeQJr+JII0hJiuAIDsMl/uHO+Ma2sOYPSNYCalwrzPkumLokOg?=
 =?us-ascii?Q?M3CAN/5LKEVE/VveR23GSMJs/gQcVyZGVRztjKYK4T+PmZ8WHO0hmXhcQRJT?=
 =?us-ascii?Q?fMO2l2kd+mqab2Yg/9VHdjzk9VmP8BUxoOhIcJDOzluS4XgN0GXaNwJsTecc?=
 =?us-ascii?Q?LN6f7hTy8Ej2JLoGh5rpwHFfoEIzHHNmR42zgYAmrJoDing/MYRxHRoq/JQp?=
 =?us-ascii?Q?zWIftzs1mYLFPBpUJhwJ4SkFSlVpE9UWNGGDq9OmziVR0TYvJznqMHBfCrsb?=
 =?us-ascii?Q?/j6C7BVciBpqobsXw8/bJNzbVUNmYui9AWZK3Hge6jjVlMBj3kx/vprDYvyH?=
 =?us-ascii?Q?No6atbWFslUCGPU39KwZ7vf+WdftfAkbnP+jC/yI6ztP2PoIul36HoLUmjeP?=
 =?us-ascii?Q?PjaIYRby8KRppy/nVosB3FniTLV+BamWoDqoqORPvVIJS7MvtjvkrAVo3Y+W?=
 =?us-ascii?Q?bAYZ2Y70qCCXaTcVd5DBZVu55llFVEZh6GxcGTMC2j5pjEsKqFSq8C1mSiOu?=
 =?us-ascii?Q?iRKe0cWtFPcLYBi/cgYjdRojS9SRS2E0rClUiOhpK/wZIqpilJ6hwdZIZZz0?=
 =?us-ascii?Q?3YIa6WiBi9MUXksmJeNFwBck?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2143af-529b-43ed-b5d7-08d8f061226b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 14:12:05.1877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNBolfkFX8E2Msjn8f8Vs537vA6HIP72V7Ctw71G8qRysxF/p9w+2vdnrP4M1MFIBcw9SQZhfuVAqcKC/i/3gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
Content-Type: multipart/mixed; boundary="===============1640243524=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1640243524==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448857020BBBAEDEC70B6FB0F7619MN2PR12MB4488namp_"

--_000_MN2PR12MB448857020BBBAEDEC70B6FB0F7619MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Can someone double check this on RN/CZN with S3 and S0ix?

Alex

________________________________
From: Liu, Zhan <Zhan.Liu@amd.com>
Sent: Friday, March 26, 2021 1:46 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resu=
me

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2021/March/26, Friday 12:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on
> resume
>
> The SMU comes back up with DPM enabled by the sbios, but the driver still
> has to set up the SMU/driver mailbox, etc.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d4b804c7b986..462917d4d5e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context
> *smu)
>  uint32_t pcie_gen =3D 0, pcie_width =3D 0;
>  int ret =3D 0;
>
> -if (adev->in_suspend && smu_is_dpm_running(smu)) {
> +if (!smu->is_apu && adev->in_suspend &&
> smu_is_dpm_running(smu)) {
>  dev_info(adev->dev, "dpm has been enabled\n");
>  /* this is needed specifically */
>  if ((adev->asic_type >=3D CHIP_SIENNA_CICHLID) &&
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=3D04%7C01%7Czhan.liu%40amd.com%7C500744d08f7946b2c5d
> e08d8f010ec49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375
> 23302768646367%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DvN
> JawxwfojJrxNOG5L8Y2BAWpGRRN6valpk6y00XIQw%3D&amp;reserved=3D0

--_000_MN2PR12MB448857020BBBAEDEC70B6FB0F7619MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Can someone double check this on RN/CZN with S3 and S0ix?</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Zhan &lt;Zhan.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Friday, March 26, 2021 1:46 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup =
on resume</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - Internal Distribution Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Alex<br>
&gt; Deucher<br>
&gt; Sent: 2021/March/26, Friday 12:38 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on<br>
&gt; resume<br>
&gt;<br>
&gt; The SMU comes back up with DPM enabled by the sbios, but the driver st=
ill<br>
&gt; has to set up the SMU/driver mailbox, etc.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
Reviewed-by: Zhan Liu &lt;zhan.liu@amd.com&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index d4b804c7b986..462917d4d5e2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context<b=
r>
&gt; *smu)<br>
&gt;&nbsp; uint32_t pcie_gen =3D 0, pcie_width =3D 0;<br>
&gt;&nbsp; int ret =3D 0;<br>
&gt;<br>
&gt; -if (adev-&gt;in_suspend &amp;&amp; smu_is_dpm_running(smu)) {<br>
&gt; +if (!smu-&gt;is_apu &amp;&amp; adev-&gt;in_suspend &amp;&amp;<br>
&gt; smu_is_dpm_running(smu)) {<br>
&gt;&nbsp; dev_info(adev-&gt;dev, &quot;dpm has been enabled\n&quot;);<br>
&gt;&nbsp; /* this is needed specifically */<br>
&gt;&nbsp; if ((adev-&gt;asic_type &gt;=3D CHIP_SIENNA_CICHLID) &amp;&amp;<=
br>
&gt; --<br>
&gt; 2.30.2<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists</=
a>.<br>
&gt; freedesktop.org%2Fmailman%2Flistinfo%2Famd-<br>
&gt; gfx&amp;amp;data=3D04%7C01%7Czhan.liu%40amd.com%7C500744d08f7946b2c5d<=
br>
&gt; e08d8f010ec49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375<br>
&gt; 23302768646367%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL<br>
&gt; CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3Dv=
N<br>
&gt; JawxwfojJrxNOG5L8Y2BAWpGRRN6valpk6y00XIQw%3D&amp;amp;reserved=3D0<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448857020BBBAEDEC70B6FB0F7619MN2PR12MB4488namp_--

--===============1640243524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1640243524==--
