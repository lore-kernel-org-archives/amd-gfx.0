Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F11C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 02:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7870D10E121;
	Fri,  8 Apr 2022 02:58:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9623710E107
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 02:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbTv+ht+soeQYS3zrIdnyD9c7aPlzQi47qmANAsaJ50ceBYItAcBcYqS7G9uHqGdmWr52+Cf5LrxLGDBF/+mf9P1VSUtfgbOydN6ZI82ExOzbYTUNyvFcmd6xWNWt6Mq00WEvvyqQIi2nidrv3QkrCP3RERmB3YCUBndZMBX7UrjUJIl0dfNKFS1Wbb/AYtcv3KHLccj1Hy8kNMYPEPv4JzJK8xOdXvJtq8C+D7FL61wotpBn8NHvz5OEz4XtEKFCyH17bSG7a/vmmmkGmTvobv9iwGPmWQW9TOZSxIhdRBrzMD9zIA1v88HR2veSyobBFdbfE459MTvIPzjkywtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSFpWpAZLlbC0CBq8j9X1JqbQUACb8HOIxtS2CAbOKE=;
 b=hYEvLZSVENp2xht3+Zco6+3nzGEKnqCtfYtus7+FvUaPbnRC96nor2pj3+R+yz8qhJxSL0aDz25RrbyyognSZBS9TBqh8nnuU1xTyCX8uicQr8OdrdlrBbE9tEuaDzZue6p7RGH1vqaPJwdKD0h1NMQnW2pXleMDecj8AM0AGjIaKG9MFZTBK0w6z1cZpiNZT21UEwAES3+/B2W79pUvF2uBhjU8VF3KEXrs4HzuNMKErs1Iu2rmrkU+rAVLYPGLejwaRBGln6V8lyl0oHsyTTgsgnpa+X+ZovFv48bIyX4PXVPsgnWuZywR/chOsoU74ff1awN/IhC2g/PJ8sOU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSFpWpAZLlbC0CBq8j9X1JqbQUACb8HOIxtS2CAbOKE=;
 b=n2n3gSuX2+6ek96Mlv65rmCJhk4mlv9bUfisO7wqMFOK+fVQ3QhfBCpPBWwvWMmHIGZN57DbzWck4hHv9j6JR0rY+t9JFpffznifvK+17kFkSRGrhui+mykDyaFeUp8Ysjhr9o5vAKrA0ry78iDLWQ2LSHyH2AAyWLLHobdcDSo=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:58:36 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c74:17fc:59b9:6f57]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c74:17fc:59b9:6f57%9]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 02:58:36 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: print more correctable error info
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: print more correctable error info
Thread-Index: AQHYSu7z0K1S0UxQyEeEQqCljTSFIazlTwyQ
Date: Fri, 8 Apr 2022 02:58:35 +0000
Message-ID: <DM5PR12MB177014D82A157785A35EDA75B0E99@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220408021826.12173-1-Stanley.Yang@amd.com>
In-Reply-To: <20220408021826.12173-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T02:49:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fe06eb6b-bd48-453f-9b93-84ec83ef45e3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-08T02:58:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: c2e3208b-1bd0-4d06-9292-3c5bdb8057ab
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5a4de18-8874-4728-24cd-08da190bacc4
x-ms-traffictypediagnostic: DM6PR12MB4252:EE_
x-microsoft-antispam-prvs: <DM6PR12MB42520BBE7F8AC03356942886B0E99@DM6PR12MB4252.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKpY+gwuBhaL+uqGR12mUozB2tCRJhC1+iN6Ez++l1sHzXR45hMMQpodLo6TgzHRJTmras4atVdQRMtaMN1bwiMzwLdzuWerttvvLn4/JmXaKlC4p6wvw4ZcNBcEIW9nDVuJojqlmvwBiOxSRrzRKT3rcsqvXBJxu/PwKlo/Ec4FyS+4OvWh+u+HvvIW0/XWd2AQqNQt/eRe4jSskAuLn0eJXWPSIWP1MHZscC4ULKquNrBzjX+YwBeSdz52yLFfq+5PRPl/Rd/l5dyhXw/HorRmLLXl5FPsd3Ikq4gqRkGUovf3jYJKJa5pdk1cQtNdft3AoPwLRB3udwilY243858rc3DeDobGmkGB6q4ZqdwgsDjhXwu//J3GFQCPARvKdEu36dRFwX/9Slzn/ECuJo0F7APLTBNkUb6EU/zRNrF7sng9XRHL86QzQ5Z8qy4opFrLe+7f6mHgGN6zEBWcuaTX62s+bVoniz4P1AWTUBfzAh3Vht6A7zz3s0d4sKmDct6+yWINsPJsrQNHNzuTxaLMWHutuoYIbAhiTnXSTMX/TTEj8znWOwi5+YkzlCn6JfRSHIcrIZh1IJnzocbeGxpZ+bIo2e8WLvb6wBwPOYVLeTmyMUHch9mWQA0gb1xzhZlcMSI9Qu3dHbtEZ9mFuqltZbEIVvwkPHSX/r1LGRC8Z8YrPDClpr6wDHcyupMMP577OKSaWI6clNBRitGt4q4GxPF8qGWM7ijGjDZJJ2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(2906002)(33656002)(83380400001)(186003)(508600001)(7696005)(53546011)(8676002)(64756008)(4326008)(66446008)(6506007)(38100700002)(66946007)(66556008)(66476007)(76116006)(5660300002)(8936002)(55016003)(52536014)(122000001)(26005)(71200400001)(316002)(110136005)(6636002)(9686003)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D1LpjY+8nANwLUfqa0c/zQHHXy804WBn9Hoal4vsrcosyZyxzjp/nzSZaPhr?=
 =?us-ascii?Q?w6MFeOnP92EdoR2X0c0x5DwcaBxxvhr9L7AwjnxJuqs1pPS37+2mfAUxDyGh?=
 =?us-ascii?Q?IBIvbHjTG/c2wf6YLN5hngvjHb6IHeLpQFdiOO5RuWz/GyV+s27vdekxUaQc?=
 =?us-ascii?Q?C//MY0qf8X0mVBRUv/1qv2qQEaZj3sxypSpr4rEivATecY4YdrO+pwmNM8hh?=
 =?us-ascii?Q?bqLfMk61YdwLlX8feO+V6qdcxqbNdbgGdreuR7HG5w5DgU+Mh+6g34obPnnr?=
 =?us-ascii?Q?mQD5Ck4lzpQKTiZE3ZPEHprq85q8QL13PVlQZouHpaPmIDm86hBjH2Nqxc2S?=
 =?us-ascii?Q?PbgRqrK8jZL/KD42R54ikAkOBrzUCKJ6e55/mD9QemKV1nxm0CfYVHvnwXDA?=
 =?us-ascii?Q?CVEH/+2r8FN0Tk7/k6J9fkxq5czBVKoKFx5+bqEh+srRAoTje2nEIrSLeROt?=
 =?us-ascii?Q?S3Ps0dr5ufMmLlTKqmV6xWgzoci43EwNpnpD9ak1dYLyu/kcRWjP8F+NVVJa?=
 =?us-ascii?Q?6HjJKfKF/TqdzOd4upksLWAwRGmPJRECVHyS8Xi94euYympte3gFZffawh5L?=
 =?us-ascii?Q?2hAMKwZpWssaSNeFofUgfRzA2gkhXxa8J1pe4XtxdCmADrvWdq5wL8n7Z28l?=
 =?us-ascii?Q?R7AsMSALu0AC2+HdqB5BXVWrBk1a1qgX1yUlk4a7FTGyRGTfA0NETt8aZApU?=
 =?us-ascii?Q?zzxgQdH/w5/xXh/O+CKy+V9SXOUqOP+WgTRNd01GMEYMPlBxfWGK18TUxASF?=
 =?us-ascii?Q?ZPHy5Y1yEvLDSiAmoWT4xxXUBGdnVp1lZAPR06if3AtF1tTiSHt9Us+5hoU8?=
 =?us-ascii?Q?ahYH78DPj1qSt0NXIlstSVxc6FjtOL4NZgBlULxm+w0pGt1+boslUgiODCaP?=
 =?us-ascii?Q?qTdI9dfCA9E4DW2J8aaqB72XbjR21ePhSPRHfz4YHAHRh7h/AoUBnEJUq7K/?=
 =?us-ascii?Q?uKMwDQXDVkjjQWP/958TLWNoNyBdipdVqkoIWG8bDPzhF+4K9JfTNg1K1O56?=
 =?us-ascii?Q?ygN5Ao3gJAXM+RiaCZuwfq4bncv26j97LuUcy+0IkE+pPLrGzVwNtfuWc6E1?=
 =?us-ascii?Q?DHGphQ6m7NfXqNQ3J5607Kag18h3h78vr7b7i6G8pcgTBBWuudBUcUeFOzpa?=
 =?us-ascii?Q?iIDyQ0wh0jIe52Y5xoCUGHvriZDJAIvrWoVnsqIRg9rpK/V8zzmiWxwGJTF/?=
 =?us-ascii?Q?2BIYLTpRQS/GQ+Xv6O0G3FqQ3LgrWCskpKY5mlKFoRvQzG7HNpwgYExbjKlS?=
 =?us-ascii?Q?PLQnKojkmW7tMSdX2fapIr+UuhsTeNqkq7l723Y6HJBn4hM7AJwvkTfqU/JJ?=
 =?us-ascii?Q?+rCCg9hAgxlUkNRTn2L7lGRl9Y1bbvYaFpdlpIlJb78wihypkhSaBCKS5Nbj?=
 =?us-ascii?Q?8ZHg6Z7bWl9R5Ov6d4/ESmhtSbOtEdx4Zw/RiuHjBguVfqmhFNM/HG4GdWJD?=
 =?us-ascii?Q?jCEzYKe50uI6M2PeB4MpovBp+S/nKMNqeA0HuFY5L36wXF7UV2/ze6Jzk1FV?=
 =?us-ascii?Q?qHojGet38WpVZlvHiWvGD2wjpZgBQKGQznEkACGtB9vxEpPLpwTSA6gKx9oK?=
 =?us-ascii?Q?O8Jd1cWtjEF2zGnPPiTIzNX4zxXzSPhzNkT/PDq7ZInqfSr6qlZkb3aJrhuZ?=
 =?us-ascii?Q?AiD5yoZgjMhnepvXKMDBrEVM1xMTpLgMBqmfXWODu18L95A2poQDr9Zju1cH?=
 =?us-ascii?Q?5Lf4xBgC+cz8LgeV0iA++qC/TU3kGG2dQXYmOwE+dDNmb+Jl1rwE5S1M4OZn?=
 =?us-ascii?Q?EXhxqZrB1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a4de18-8874-4728-24cd-08da190bacc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 02:58:35.8654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqBgQPJww62fZTvKP3QSkqz//inr8YATDcHWrkirICyBkE6ZrWn8jCg+J+d2eBbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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

[AMD Official Use Only]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, April 8, 2022 10:18 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: print more correctable error info
>=20

[Tao] it's better to add description for the patch.

> Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 62
> ++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index c45d9c14ecbc..803119f75e39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -70,15 +70,46 @@ static void
> umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device  {
>  	uint64_t mc_umc_status;
>  	uint32_t eccinfo_table_idx;
> +	uint32_t umc_reg_offset;
> +	uint32_t mc_umc_addr;
> +	uint64_t reg_value;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
> +						umc_inst, ch_inst);
> +
>  	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	/* check for SRAM correctable error
>  	  MCUMC_STATUS is a 64 bit register */
>  	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D
> +1) {
>  		*error_count +=3D 1;
> +
> +		if (mc_umc_status)
> +			dev_info(adev->dev, "MCA STATUS 0x%llx,
> umc_reg_offset 0x%x\n",
> +mc_umc_status, umc_reg_offset);
> +
> +		/* print IPID registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print SYND registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA SYND 0x%llx,
> umc_reg_offset 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print MISC0 registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA MISC0 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +	}

[Tao] can we implement a query_error_status function and:

1. call query_error_status in xxx_error_count function, like this patch, or
2. register it to adev->umc.ras and call it in amdgpu_ras_get_ecc_info.

>  }
>=20
>  static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct
> amdgpu_device *adev, @@ -242,7 +273,9 @@ static void
> umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>  	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>  	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
>  	uint64_t mc_umc_status;
> +	uint32_t mc_umc_addr;
>  	uint32_t mc_umc_status_addr;
> +	uint64_t reg_value;
>=20
>  	/* UMC 6_1_1 registers */
>  	ecc_err_cnt_sel_addr =3D
> @@ -277,8 +310,33 @@ static void
> umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>  	  MCUMC_STATUS is a 64 bit register */
>  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D
> +1) {
>  		*error_count +=3D 1;
> +
> +		if (mc_umc_status)
> +			dev_info(adev->dev, "MCA STATUS 0x%llx,
> umc_reg_offset 0x%x\n",
> +mc_umc_status, umc_reg_offset);
> +
> +		/* print IPID registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print SYND registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA SYND 0x%llx,
> umc_reg_offset 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print MISC0 registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA MISC0 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +	}
>  }
>=20
>  static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_devi=
ce
> *adev,
> --
> 2.17.1
