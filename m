Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6ADC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 23:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC77410E129;
	Fri, 28 Jan 2022 23:13:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8951B10E129
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 23:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElPN0WFr6bXxsd7Gb7+vXs4AeptQ98dM39lXhd76qPMxumzyhCdu0D3nvzIoMu4dk8YntKGwrFm9DlyufApETY3OCpFoOo0GRUffVJc8UfT3Kc9Ms5ofGGimZ+gSvDteO4Z/g6mUa6ZMh0qdzxz/sjAlF6IcRSbEbNB8nxZrQDJW1ah6NskmdHZiIBjPjhEmKzBnLfZu1FBhMrW6NBX1C3Ylx7/sMu+hTMu+snxDs0mGvQ7rTLQaU59RKJTJWzpMqtx+lqUQD/uY4RceoiFmRDZ63jR3tVBWcnObtypQiCO3J/b3ASbtQrNg3czcA0BCSqiNI5NdJMvL9uLEwW3bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXkQXqV6AqoXAprtXqG60skaKngIpQmGHsI3t24+dcs=;
 b=bbB76crUNwcZTmz3XFfbv48udXGoH1bDQ/4cN+G5YifvkCTL8rI3FL5Va9ccHDuxEvRBOlZTrKeKvODzT69Gqma1wuHjElkxR1RBMDjStLIZE/cxFbgYd/K8feXJQTzpuKDb+qYGHYMmwsgi5ckwQBGqjuT9UMC8kGbvIzXAUD+SO4wEaP/I5A6EovunSx3K7yl265OC3e5mBziqn75RPnMlirL7QaVRpvrORAr8o7NAtR/AT9yE4AcDN4r1K8TxW/jqhzWnMn2sffreezI00OC4W7P+7UrPUK8oJGpS+mD2PcdQzS6j3PhK5YBxDW1gtSxEJxt4CIC9KWD8M5kzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXkQXqV6AqoXAprtXqG60skaKngIpQmGHsI3t24+dcs=;
 b=ERsV1HYLuJeKFRX88CTkLsbWzZUA6uJuUXUn4hlbgINKoCUod4k/wpjrcMGYC8HmXJBBZsHb8meapod6KL8H6PpUHKs+SMcfWlAX4vQ2XsPW08IkKOugtAoIepCrVRu40ULStX/CRf5JnerMRHweix3F9SClAwSkxQuN71gtrBc=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM6PR12MB2922.namprd12.prod.outlook.com (2603:10b6:5:18d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 23:13:18 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 23:13:18 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
Subject: RE: [PATCH] drm/amd/display: Update watermark values for DCN301
Thread-Topic: [PATCH] drm/amd/display: Update watermark values for DCN301
Thread-Index: AQHYFJvaxeUvxEeQK02WNTVX+r2m7ax5D9Sw
Date: Fri, 28 Jan 2022 23:13:18 +0000
Message-ID: <DM4PR12MB52146C466B81D181B46BE3C39E229@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <20220128230706.6205-1-agustin.gutierrez@amd.com>
In-Reply-To: <20220128230706.6205-1-agustin.gutierrez@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=83930a67-0178-4381-940f-88f264d6e711;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T23:13:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afe0d7af-79f1-4e15-3510-08d9e2b3c528
x-ms-traffictypediagnostic: DM6PR12MB2922:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2922CB8E647DDDAFDC2B7FF49E229@DM6PR12MB2922.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tun+QgIrFm9p+3NiHe2rRuavDo5V4p3qT6AUEJKYBq5laUfwAQfN18ft00LZtmPGSYFWaOTdfoRsW6qGnELS1dfdOn7TmON6d870S78Q9Eaf2sOTSRb94CJ6q/60K7JrD2mwW5tjtat1DcesPSycu4WfpZ226OJcpMw3BhTtyAo2VlKtRWoAKzuGfY11GMHkihf9uKx//IeFTlFQnpBjNy5XROuUqKqEOwV0Qwk85BkISvPNkVeeYa7Dyhw2DiJefScZNxjZAyvmHqrOntimboPE2gO6FzIRVj79srFA37a/r5pIU3/rexZ043MOYy5sdxRN8D/k5h9Tuhn/vYp8pcuI+2eHndVVeLTSfR+fc/YYiWcfKTX19oZxy7GUeu+CebcfMLBp1olkGJKkikdXO9hPUADayT81sFDYlRvd38/2X0SXvVgaxZZzqvDJg2AR2NAhXXmAbycGH1hoDVbuNtzYuX2SBq+5Bip7JoofWYb/AobdroWB+utZnkgjvOQxGufQ7Rp8bVsGEWnA5cIhJI9p+8cPGlTHlMcWNCdRcJKWRATxJdgbHqGLM2QFzGh4vxhk7iyEjf6cKCj1E39vUs+cWAjwxCi+t91OjWG/m7SbyVLqvE1iiYHq/JZBunAZEVhiWzXvT+uHwnRF5L5HddXVvYtx8QB6Tbl/goJKYyHJ0Sv7dKFWv6jvLQKa62XSgicBZlMHDIt+Z8zHurGSBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(76116006)(2906002)(66946007)(52536014)(53546011)(5660300002)(6506007)(71200400001)(508600001)(15650500001)(7696005)(55016003)(26005)(64756008)(33656002)(110136005)(122000001)(83380400001)(6636002)(8936002)(66476007)(38070700005)(186003)(4326008)(316002)(8676002)(66446008)(38100700002)(66556008)(86362001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gVkcCPQCpwkdyaSEYS8xJ1tTqR8ODqYsbKOK0+6mSowr12B57F4cy2WMFNNh?=
 =?us-ascii?Q?GGBiHpNyhSlq5SluqHl/PDOa8n0UOwq5Qz3l9VtjIkN/eU4Y2Yc7CeiBuum1?=
 =?us-ascii?Q?/yhCFtS55kDFmTpq39WGzr53as7KGOYj7Ve+lIXTf5Te2FHGE3xV3+egU5T5?=
 =?us-ascii?Q?noyJfcZTsTgEQx/eA2cuHuowR5d2FF/Ci4AkmWnF14C2SrvWDsCmla7s379g?=
 =?us-ascii?Q?1FbXJugjvW+NgWSuywGvxZdDIdL6BocSR2/Z2DPiLjE3CRUiPAEYNtiXuZcE?=
 =?us-ascii?Q?a1Z0NBG0LMxQVZIfCNt68bCIOPrES43p2JuFQAkzWEHCYcKiwNDQ50Ftgvus?=
 =?us-ascii?Q?/uuS+TLDFlRvIma9NACX+46Qv8IPxMLCxUPilIdpk8yZL1IZdVdqJITfY24k?=
 =?us-ascii?Q?ziepH1VSD7RFASD6sVXLaTrGHg9ZMbQsWLiPTy3tPOD0imILiZvuw95CaIBz?=
 =?us-ascii?Q?V3kph4LWD59tN2BfvDAQ9E1SfkVt5v36b3tOon12LZo1rJzAC6D2vSLe5FRp?=
 =?us-ascii?Q?OlKXukKes7UMfUb2buBbMjmh0aWmH5IG85RKQm7xlDfgHq4dTtjMAALHiZPj?=
 =?us-ascii?Q?VRO6jpc7e86OdW2khL/3b9Cmyz7C2PWJpVUW4XLYC+HdxIITcK+EVAb7ta8Z?=
 =?us-ascii?Q?c6eQ2iuGl1kyvHE6NeWTm7ZH5Tv3YtuxRz+M1CpcLakw/SUSXbmUWmKT518f?=
 =?us-ascii?Q?/pDP93nMoM78wiI3RUtAuiA0xoiwiaeWslx/RsyF0BHE94Xm7cwGmt9amCt8?=
 =?us-ascii?Q?laNHvKeEGKybIGHtNe+XeaX+1ZLiFEisIL+SClMQQMwfy90pRU2KxwDc1UFi?=
 =?us-ascii?Q?EeAX41zmrl2f0BDEwSL612+372x2BuKjzlImJNCMbSjTerc+L79Y66/EzB6s?=
 =?us-ascii?Q?8zOLy82L/qJIuhjxRV5aZzuZqUMKWBn9YlZBoczAjAG090BRammZKbQpA+mB?=
 =?us-ascii?Q?1N4FiaY2JBhOaXMmD4LtUOmHfyzA38tOzivBfwFCJfF216++SiCgCenas/KI?=
 =?us-ascii?Q?SWqZ0+vLJIemGRC1hdsLb4MjRNriNdy/0szoigWqlutYR5fJqF/mtxTkjMAj?=
 =?us-ascii?Q?CXb/vpjUPtycA4944nPym10qG2/rTQC6LMZ+dj48aHKcbufN2EsA9FJKVl2l?=
 =?us-ascii?Q?f1BK0TauhCaUXJv0aG/pYjtYDH6vwv5yQ8Pag40+sp4gTcq5cQcuGXq6YCiK?=
 =?us-ascii?Q?YP9DLYuPmwK8hcyu6LB/uj7l23hqpb/6bKpuC9szfHmrukYugrPqLUW9MvdP?=
 =?us-ascii?Q?HNSIPupiCCK2UeTI8OQPqbucv+lREXSzSOjp68VytP5wW0grFcAWg0f2cW75?=
 =?us-ascii?Q?fosmjPEjsVqx6DHzTSf5fge8W9LFbYT5lOtOfh3JnVz2YFAP6MrGCw2Fwj47?=
 =?us-ascii?Q?0ecbOYhR2SdOGHgeRApIrJevrmkMpdN1yD/R3mqFvfOWRUZ1UksBVYgcphRp?=
 =?us-ascii?Q?3kD2poFcSE01BPlb59Caxo4ROCX93RuypZHeNFHW2bEpMlhpILk64GQCsHaq?=
 =?us-ascii?Q?cda8VZoHwTA3qv1BsKE4gN1xOVNWW1js3r1mUFPNMiiSHrvWWwXJ4gSfaiuw?=
 =?us-ascii?Q?BvgkzTpsNlrkOY5Pv3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe0d7af-79f1-4e15-3510-08d9e2b3c528
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 23:13:18.3937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ba0vLivBjExLvEP2jXGPfd89D25Wcd+k9boHFzZ3XzHHfzcmsgTBptcZQ4Jdx4zT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2922
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
Cc: "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Agusti=
n
> Gutierrez
> Sent: 2022/January/28, Friday 6:07 PM
> To: amd-gfx@lists.freedesktop.org; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>
> Cc: Gutierrez, Agustin <Agustin.Gutierrez@amd.com>
> Subject: [PATCH] drm/amd/display: Update watermark values for DCN301
>
>     [Why]
>     There is underflow / visual corruption DCN301, for high
>     bandwidth MST DSC configurations such as 2x1440p144 or 2x4k60.
>
>     [How]
>     Use up-to-date watermark values for DCN301.
>
> Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>

Looks good to me.

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  .../amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> index 48005def1164..bc4ddc36fe58 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> @@ -570,32 +570,32 @@ static struct wm_table lpddr5_wm_table =3D {
>                       .wm_inst =3D WM_A,
>                       .wm_type =3D WM_TYPE_PSTATE_CHG,
>                       .pstate_latency_us =3D 11.65333,
> -                     .sr_exit_time_us =3D 7.95,
> -                     .sr_enter_plus_exit_time_us =3D 9,
> +                     .sr_exit_time_us =3D 13.5,
> +                     .sr_enter_plus_exit_time_us =3D 16.5,
>                       .valid =3D true,
>               },
>               {
>                       .wm_inst =3D WM_B,
>                       .wm_type =3D WM_TYPE_PSTATE_CHG,
>                       .pstate_latency_us =3D 11.65333,
> -                     .sr_exit_time_us =3D 9.82,
> -                     .sr_enter_plus_exit_time_us =3D 11.196,
> +                     .sr_exit_time_us =3D 13.5,
> +                     .sr_enter_plus_exit_time_us =3D 16.5,
>                       .valid =3D true,
>               },
>               {
>                       .wm_inst =3D WM_C,
>                       .wm_type =3D WM_TYPE_PSTATE_CHG,
>                       .pstate_latency_us =3D 11.65333,
> -                     .sr_exit_time_us =3D 9.89,
> -                     .sr_enter_plus_exit_time_us =3D 11.24,
> +                     .sr_exit_time_us =3D 13.5,
> +                     .sr_enter_plus_exit_time_us =3D 16.5,
>                       .valid =3D true,
>               },
>               {
>                       .wm_inst =3D WM_D,
>                       .wm_type =3D WM_TYPE_PSTATE_CHG,
>                       .pstate_latency_us =3D 11.65333,
> -                     .sr_exit_time_us =3D 9.748,
> -                     .sr_enter_plus_exit_time_us =3D 11.102,
> +                     .sr_exit_time_us =3D 13.5,
> +                     .sr_enter_plus_exit_time_us =3D 16.5,
>                       .valid =3D true,
>               },
>       }
> --
> 2.25.1

