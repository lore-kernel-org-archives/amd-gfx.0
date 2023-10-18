Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8C4CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 07:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF02E10E021;
	Wed, 18 Oct 2023 07:43:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B80E10E021
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 07:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvMNTGX3jgpJKy7qep9O9CN0S0ymBYARdXfzjcEG7AOLdQUopo3h7/cy/fofD9B0200twaG5du12NTfL6atSmqPlalkdZQDAXv7Nu+kS3Hb8G/kuPRAFCJhlM1FmrZkK//bxJlF0os2LmpV9uV/Eocw2oKPqRJMR46lYeG9Sw6HABD99SsTsJYa9SKIYKFCPOXMfhixjsFBlJlYMtyneFOHuj+BR3QJjhtbRPHaxhMCAEP/XgubgErhyr2YfLws8kldnTCgNq7JtXE8ViEHFAOyukBWCM5owSlVRHkJJY8OpA7TJzEzKw36cqhnf6XY65TtwVh+iFs9TnqAqmUwycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIWApfzkXK7MCzfUwMO6XOwJb7JbiaEM88Zo8JC9JSE=;
 b=j4lta3sl1qr/gOx0HIUMCTNgd21VJLDxHq40BsG2/aBPmNrmaL6ZizxpnPorvLK8Cuh4wfZJfuKjX7o3LCAhBwp+AY7PjwEQ77RrWVUpQ08XmLEhX/q1Gx1JThMU5ZIXJwHXTBPn8biy/pq3brxizn3rDAI7zjrPYDTJ6ZXQqaetH39w3nR8m5vNBH9kt3wgFruhzf5RB3LXgojZ38bzhfGNtNLwhnOgAqFO96buddmJuYKPOQRVotyslieifvGypCik+sSqVBMiErXkR8ZvAYI2qY7a2CntdWQypPNts7oISrxGHDcWwFh8OBkLHTsSWe44VJZxqCCFz6es1g+kaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIWApfzkXK7MCzfUwMO6XOwJb7JbiaEM88Zo8JC9JSE=;
 b=MtYKxMOzyLjHbDhTHrRz6HVNEiTuIh99FOtaybtAqfZbFZv2NDlXERnXz8NnZWFnDq6zIOiXOKsrZB0CZPzd85GeBgcIy+1/QekkuS7gRdmlRwLHrryDiA8kIHP5wj0hNpbEV2FDEoTFMUJfejINvMNa9ePk5LoqgY//nW76Yk4=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 07:43:41 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 07:43:41 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu: drop status reset for GCEA 9.4.3 and MMEA
 1.8
Thread-Topic: [PATCH 6/6] drm/amdgpu: drop status reset for GCEA 9.4.3 and
 MMEA 1.8
Thread-Index: AQHaAPftWc7LQXLs0kSBx5+UVM1Fi7BPKxVg
Date: Wed, 18 Oct 2023 07:43:41 +0000
Message-ID: <PH7PR12MB7988A291AAB0565F3F4114F89AD5A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
 <20231017124552.27509-6-tao.zhou1@amd.com>
In-Reply-To: <20231017124552.27509-6-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b0a032b0-e473-4af8-8ef2-d1bb72237e29;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T07:41:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DS7PR12MB6167:EE_
x-ms-office365-filtering-correlation-id: 4ed0bd5c-716d-4ee5-e473-08dbcfadf2b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxHTV2xfnndCNdsRcovhET4T0lB/jYI3vSiUu6cDxeaT+RrROGyQhkS5Wvnrj+vV5bkap5fDmWoC/X9gJe2dzL0y/3OGZwW0KhewJTHkSYIHNfL1t9XqSddiQcpq82Eks5JbIQZ53BKW9KVFS9MFbx8JsqNFqkF6aFSbl1+I3m60DWelVZvfyQ6Jhs1x2tYonC3Tb40u/J0YVVEGzQOuZ9YnIyqYmCmouM2ZXqjzkgBMik4pUvEzC537JVKjuf9Gb9LehO60gX5MNfEElm/GdMB5a9dcf3CfAwxa65RFKV0arLIRUBHCr1kKKL524pqDo47bGjMtW4b6qllmblR9a4saA+KDzkRvDQaqBFEev7Zy176REtghzolJ8mt/mUJmTeNCueUoEZJ+DlICLhWzux3+kuQEqmzFupV3uGy/NSauGgieL4D8nyjSiLKFQVDrX6NVZSsUO4nJjfV33/lynQN3FflFT+iNAWVkF++E7oxpswOy3NYIWMw0hwdbN08mKsUgeHDN0OoixJfEe0ccea5qJ0WpeI6s/Arw5tnM4VDL+0w4thGHeQjmzcOp9+I8F1UlmmAjyFYqCLKLZs1+awXOFjZw2eFV5LZxQF/gIsu1NiSo7FkW9MR2P2z6fcv+XuiUEJKECH2FOpKK4lfkfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(7696005)(6506007)(38070700005)(38100700002)(9686003)(71200400001)(53546011)(921005)(26005)(33656002)(122000001)(478600001)(66556008)(5660300002)(8936002)(66446008)(64756008)(76116006)(66946007)(110136005)(8676002)(41300700001)(52536014)(316002)(55016003)(2906002)(86362001)(66476007)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HmVoTfR/kAwoAeXalBHjBuVTqQELnmgILwrplPGk0eLVIEVFTAe72LTd992L?=
 =?us-ascii?Q?5g9wtUEOx/SW+2UW/fs0xgdF6tAmgT/aj/PHw9wfsaM4w7lQfEmIJMg/hQ4C?=
 =?us-ascii?Q?BXqZXPQ7o9euwtcnf+mK5EryaCZRr12D0phMC5zOYF+LK+u6n7fQWTjn+ZB7?=
 =?us-ascii?Q?FFLhiuTqSxkkhOjZBMNC35Z/Ygo2/XBfiRD3V2gJD8T0sQ8cJv2lK8Z8k/st?=
 =?us-ascii?Q?JN2FfdxBtv6fpAUAv3O+TnOyEsU3c6rh0/sBC2A3LMOM5T1pkYoH83qJsuV9?=
 =?us-ascii?Q?ya32bnJ0QxKXYdp+jFIT5viYeOI7JyBeQOJErBDmMGI5SkU5evFK7/vd4WJQ?=
 =?us-ascii?Q?picHZfSN8BRJGxw/LAcoud06R/WnyD0AIiDr8k0XsDYRiSYTdD1TQdvN6RDs?=
 =?us-ascii?Q?fqIcP8kHr86Cc8H5TqPBtuFR7IdnoHPTXxXMy6PS1t+0FIiV4zgiU7OsFRqD?=
 =?us-ascii?Q?3Q2fxClXIL/wo0tjsp2SUPc2kmUlydPs7TrNfcBd/SnSedWvt5ycfiVGCDG6?=
 =?us-ascii?Q?d88+HOCAbSHcc8YemlHhr0PR2ooIvYaCr8WXVkYDO7AJAErlQ049AJclfUal?=
 =?us-ascii?Q?VHo6+2aBEc0h2IJLDmPmnlxJuge9M6byEp3qtXRHmb7Iw6KPGBApyxYdPLJ9?=
 =?us-ascii?Q?3IHRE1pNWT8lHeqI/8f4ccGZd34b/D3Urell+JolKQgfO/zyzR9j0Qp8c4Ph?=
 =?us-ascii?Q?7kBm9o8mvnSd8yS0AmdWhedIWe7/cp9ifJyNFZDx0IWZfk7r4+aciukPI0Z2?=
 =?us-ascii?Q?5ntjIs7swkF16Mfeiki7AR/tbfZwqW6DDw6cAFEWBMyzv0lbTX4N1QKMO2zf?=
 =?us-ascii?Q?M/Z+D5zq2ZNy/vDbGALtVNBgRBIq5hqGmyzZ84cRi4kZKyy+gkfkGjTTyFUc?=
 =?us-ascii?Q?MDti4WMXNh/GZjWiDFb7wx0BdAQNMJDbWk4cpMqYFQ9ZV6R1XuOigUcW+EJS?=
 =?us-ascii?Q?Qb80y+PlLLhcRn1ou6fR7IAdgfyc270NjPPQtcioKeR90OHRnRVMVFbN2Twn?=
 =?us-ascii?Q?LMSsmi1Q+5h9Q8BEflMhHfasMmCeXiLOwBW6Dg/ViVJ+GmRjnHcmyz9B0wMR?=
 =?us-ascii?Q?THOPAYwuIDM/IOaXFxzdPA7ZTQSaQv0nctTQFk0zW9Ypc6TFydCcoUFe8rEg?=
 =?us-ascii?Q?9mJEFuE4jb9+qNosTS3VE5klS20EtlSA2W9fmv62B3IaJxvEd8Z7cI4p4HcJ?=
 =?us-ascii?Q?nVES/BOUhy8mdTa+1N4VXbTSdAgLd/LrgORw14AafbYpC9roUzN0H3Tr2cNP?=
 =?us-ascii?Q?XVmjej4bEMpN2AVHh2pA0pEfthkWW5/7bLmKC5NeCZQU8SYu/Gjd9+YzpPtQ?=
 =?us-ascii?Q?MIdXAvziiKjEW4g/On3547wCtsqyl0HKTRtUOaCNJ1f3z+NOfG9dtGpEbRFj?=
 =?us-ascii?Q?u/W580Sn/XbI4giDRuzq5o1RXJi3LD8VnyY/WRweOfqxmOK9CWVo8/tJ434D?=
 =?us-ascii?Q?eqSCNDIA41b1fZ/xd226nDFvpdu6yyabo4s+2hpyr3PEn0yaPjc6OVPcTUTt?=
 =?us-ascii?Q?l0CuUoA76/f9z5LgfdDngRc+hm6A7eoS4D40HQio2Wcm6WVoKjxHzvQmRZTM?=
 =?us-ascii?Q?2AXhIFN5WnKqerTDjb4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed0bd5c-716d-4ee5-e473-08dbcfadf2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 07:43:41.1271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMvtp48WEsJCgrdlXLBKAJvYyXXv6KqG/8USPpTMKQTol/oU0tVIsVD8uqlL4rYwfCUj31PvXLDJXmOHmNwe+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

PMfw doesn't reset any ce/ue status and count in debug mode, who takes resp=
onsible for it if in debug mode.

Regards,
Stanley
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, October 17, 2023 8:46 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li,
> Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 6/6] drm/amdgpu: drop status reset for GCEA 9.4.3 and
> MMEA 1.8
>
> PMFW will be responsible for it.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 22 -------
> drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 86 -------------------------
>  2 files changed, 108 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index a1c2c952d882..65da72735e52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3996,27 +3996,6 @@ static void
> gfx_v9_4_3_inst_reset_utc_err_status(struct amdgpu_device *adev,
>       WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regVML2_WALKER_MEM_ECC_STATUS, 0x3);  }
>
> -static void gfx_v9_4_3_inst_reset_ea_err_status(struct amdgpu_device
> *adev,
> -                                     int xcc_id)
> -{
> -     uint32_t i, j;
> -     uint32_t value;
> -
> -     mutex_lock(&adev->grbm_idx_mutex);
> -     for (i =3D 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
> -             for (j =3D 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j=
++) {
> -                     gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
> -                     value =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regGCEA_ERR_STATUS);
> -                     value =3D REG_SET_FIELD(value, GCEA_ERR_STATUS,
> -                                             CLEAR_ERROR_STATUS, 0x1);
> -                     WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regGCEA_ERR_STATUS, value);
> -             }
> -     }
> -     gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffffff=
f,
> -                     xcc_id);
> -     mutex_unlock(&adev->grbm_idx_mutex);
> -}
> -
>  static void gfx_v9_4_3_inst_reset_sq_timeout_status(struct amdgpu_device
> *adev,
>                                       int xcc_id)
>  {
> @@ -4042,7 +4021,6 @@ static void
> gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
>                                       void *ras_error_status, int xcc_id)=
  {
>       gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
> -     gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
>       gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index aa00483e7b37..616d75add087 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -756,96 +756,10 @@ static void
> mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
>               mmhub_v1_8_inst_query_ras_err_status(adev, i);  }
>
> -static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device
> *adev,
> -                                              uint32_t mmhub_inst)
> -{
> -     uint32_t mmea_cgtt_clk_cntl_addr_dist;
> -     uint32_t mmea_err_status_addr_dist;
> -     uint32_t reg_value;
> -     uint32_t i;
> -
> -     /* reset mmea ras err status */
> -     mmea_cgtt_clk_cntl_addr_dist =3D regMMEA1_CGTT_CLK_CTRL -
> regMMEA0_CGTT_CLK_CTRL;
> -     mmea_err_status_addr_dist =3D regMMEA1_ERR_STATUS -
> regMMEA0_ERR_STATUS;
> -     for (i =3D 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) =
{
> -             /* force clk branch on for response path
> -              * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN =3D 1
> -              */
> -             reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
> -                                             regMMEA0_CGTT_CLK_CTRL,
> -                                             i *
> mmea_cgtt_clk_cntl_addr_dist);
> -             reg_value =3D REG_SET_FIELD(reg_value,
> MMEA0_CGTT_CLK_CTRL,
> -                                       SOFT_OVERRIDE_RETURN, 1);
> -             WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
> -                                 regMMEA0_CGTT_CLK_CTRL,
> -                                 i * mmea_cgtt_clk_cntl_addr_dist,
> -                                 reg_value);
> -
> -             /* set MMEA0_ERR_STATUS.CLEAR_ERROR_STATUS =3D 1 */
> -             reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
> -                                             regMMEA0_ERR_STATUS,
> -                                             i *
> mmea_err_status_addr_dist);
> -             reg_value =3D REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
> -                                       CLEAR_ERROR_STATUS, 1);
> -             WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
> -                                 regMMEA0_ERR_STATUS,
> -                                 i * mmea_err_status_addr_dist,
> -                                 reg_value);
> -
> -             /* set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN =3D 0
> */
> -             reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
> -                                             regMMEA0_CGTT_CLK_CTRL,
> -                                             i *
> mmea_cgtt_clk_cntl_addr_dist);
> -             reg_value =3D REG_SET_FIELD(reg_value,
> MMEA0_CGTT_CLK_CTRL,
> -                                       SOFT_OVERRIDE_RETURN, 0);
> -             WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
> -                                 regMMEA0_CGTT_CLK_CTRL,
> -                                 i * mmea_cgtt_clk_cntl_addr_dist,
> -                                 reg_value);
> -     }
> -
> -     /* reset mm_cane ras err status
> -      * force clk branch on for response path
> -      * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET =3D 1
> -      */
> -     reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst,
> regMM_CANE_ICG_CTRL);
> -     reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
> -                               SOFT_OVERRIDE_ATRET, 1);
> -     WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL,
> reg_value);
> -
> -     /* set MM_CANE_ERR_STATUS.CLEAR_ERROR_STATUS =3D 1 */
> -     reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst,
> regMM_CANE_ERR_STATUS);
> -     reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ERR_STATUS,
> -                               CLEAR_ERROR_STATUS, 1);
> -     WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS,
> reg_value);
> -
> -     /* set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET =3D 0 */
> -     reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst,
> regMM_CANE_ICG_CTRL);
> -     reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
> -                               SOFT_OVERRIDE_ATRET, 0);
> -     WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL,
> reg_value);
> -}
> -
> -static void mmhub_v1_8_reset_ras_error_status(struct amdgpu_device
> *adev) -{
> -     uint32_t inst_mask;
> -     uint32_t i;
> -
> -     if (!amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__MMHUB)) {
> -             dev_warn(adev->dev, "MMHUB RAS is not supported\n");
> -             return;
> -     }
> -
> -     inst_mask =3D adev->aid_mask;
> -     for_each_inst(i, inst_mask)
> -             mmhub_v1_8_inst_reset_ras_err_status(adev, i);
> -}
> -
>  static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops =3D {
>       .query_ras_error_count =3D mmhub_v1_8_query_ras_error_count,
>       .reset_ras_error_count =3D mmhub_v1_8_reset_ras_error_count,
>       .query_ras_error_status =3D mmhub_v1_8_query_ras_error_status,
> -     .reset_ras_error_status =3D mmhub_v1_8_reset_ras_error_status,
>  };
>
>  struct amdgpu_mmhub_ras mmhub_v1_8_ras =3D {
> --
> 2.35.1

