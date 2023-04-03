Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ED7C76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 03:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B3110E11A;
	Mon,  3 Apr 2023 03:44:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC49410E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 03:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJXSNM4qXPlUVpZ/NtsxCm1rXWG6cNvH/tEZOuGIIqMreoBSXBl5B5BZHgevld0boUCT56PKpBieQi8DNqstEnWIJWe1nY3I7UNOsGgis0eovd4ShSWjqZoyCzXbI/DUK9y0HulG42MczyEeluxLJQNVEajpp5tysbWo9NgS0ZDIq996O4aCkVwXdqHvbodXP5+QomkTk2i0dXcX78CPbnHIJ4qEtPjobGFOKjzw9G8SL4RW6kQWpKagPniEnK6+akU+37AJmLmkJ3ebvQ4MAd4LeaHLAb8RMIuMh9P2pdyznht2my/3qMNpGTv/1fvKZ/Yq558D0d4UDFM49eSlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM+qtGCf7CJQMCjRnuWQwg++SVo8WijE2Fq3dQi+BmQ=;
 b=MZOFIwpD4oh2M0SQT+bhrpS2arUWG05FtVDhjFz66x04fMW7BSD+Sx9qF2ZWv8pPK9y8+olTxlcurfq9Nqtf4kbJBNtWamH4ZCQK4/9mr5QAXwI+Dws0Kj1NBtGNr1W3nd+WKvPlLuggB0HYMkFKelWqSEZ2U59TKcQjFwMed30aaWA0s+kX/XXoBWoQhrUHaVw0I9X5elMjm3TJxpOVVNDnc8E0+u3kffnTcyUhQMUdYtxZPrYbmT2B88aOovFf01fHbznvAnEGRUxAevUEl/OONSA4kA3/0u+1p3yuBI3NZ7QAJL6JcPKCEckZrLePMVxRobgsKAK9ugYZSiSIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM+qtGCf7CJQMCjRnuWQwg++SVo8WijE2Fq3dQi+BmQ=;
 b=wX01WzNdeBpJ5UKXAajuN2QqoyjBm+iuodJTCcaLKp/zCzhBzFe13Oh9FF7zxTVZNrxPDdpH+RCNyTOzZtYMFEAwxPXSV0QWSRghEaqCcqydWp4YmYvXv6JrX8QDzW7aPtSTDhvdxr6SkBxDxpVdIH0PuyfP6UIykjQLkXef3lc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 03:44:53 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 03:44:52 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Topic: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Index: AQHZZdBDIUgu9N2Ud0KJhtP8yMnXRq8Y8MrQ
Date: Mon, 3 Apr 2023 03:44:52 +0000
Message-ID: <DM5PR12MB1770077FD7D17A141B9D608CB0929@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-03T03:44:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77aa5156-25a5-4735-a093-69ee1d4e4933;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-03T03:44:47Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: aa2e2811-4a9e-4aba-bb68-6cf2d8eb2c86
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|MW4PR12MB7439:EE_
x-ms-office365-filtering-correlation-id: 80fc8765-7a40-472f-6ec5-08db33f5c882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZObthtKQB34iaIon26MfsTy6Y7Na88Xm9+U1IC0D8ybox/tZwZ2yovH4WWR63xrTnHvtXtqD+28HvtnZvdytuCT/YhgJo8aAI0tWp+heKFCAMVFaydDXHBA1hqEz+ITpl1INW8zhKN1KlmAIcWeun9LEU5+4Xm++lH9suXDFzJ79gaskfpAVaGMH6XKRPXovmB7MTBQM6UwZ5EM76sGdCNV68HZ/Z/mP5TDVriwuXtGYRgAxaeoPBAAUWChl4dB2oQSPbVKNYXUCoCMzsHh74Wp70vrtQnmDN08rOy4fQ9P6w8sj7v5nqIOhq36lDIkIynG3qmfEnHxhCfxgOl2P/HIPUo/qbtQoyamZaWu5vb/fbwbIYgxVRr9EMJmtSE13WYryKUrZXj12oY+pN2ag+QKuRFgA864nPr0kIZ4Go60KMAKWzNRF4VTOdYERJ22SexcQvm6TtWbf6/Of0EG+1+yajukdEdZao7GYlJnsrPgzx73iVzW/C9O3Wgjy2h+cExFJ7aVr/CKI5liDp1cx8br4YRNT6BrRdNxMPjNF+xwdxVGeV6xvCc3vYxWnEiVeidQ44TcHdH9RXtP5ZYvz7pnBuEK1Gm9LVP4F3SS3ZaX0csjOfXrfRNt1fF+NgtUK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(38070700005)(26005)(9686003)(6506007)(33656002)(86362001)(53546011)(83380400001)(55016003)(38100700002)(122000001)(186003)(66556008)(66476007)(66446008)(64756008)(66946007)(478600001)(76116006)(30864003)(2906002)(4326008)(52536014)(5660300002)(8676002)(316002)(110136005)(8936002)(54906003)(41300700001)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gz/q3J7MqkFQkt2/+2ojumX5RhCG6vYsXH4bsYuZx2D+pvJAzMoSnEhMra1b?=
 =?us-ascii?Q?oZJXP246yZQ/1lmxHavEYthW9m41BtvIWQwb/dYTznClQ+fl5qgTUNq+vgKi?=
 =?us-ascii?Q?+PJQoAkOhkgRgiIuyeM8o7PevXYsTQZFR9uok1P1e2R1Nni4+BCB3fEWZD8N?=
 =?us-ascii?Q?u71Nv8VaN/kGXW9+0UQ/S9oa1NIt/MRddeH6UKK1vBWd2kCRAgrwvde96A3O?=
 =?us-ascii?Q?e5KHVlUqzZROGxicnOkOrsBLdFuQYREATAa0c7qnDTlnC9HS9NXoTRF6mEIR?=
 =?us-ascii?Q?mo6w+5VPy+Gzqz0BH/5bXCXz3W6CPPZwu849uWgEL1uJipv52DjDHsRUdBtn?=
 =?us-ascii?Q?4d3ODsFhHG6zYsXB6eVFFIbtjnpnjNzTGyQfri5QauTaJ3gh9iDZSZOg7BrS?=
 =?us-ascii?Q?5VuMtRc5XSWqOz8EDSP1wRBjBSf0lC4SKxc2NM9tbMgNt/Nf/3dUncul13Yr?=
 =?us-ascii?Q?oHR/yJWQFUz/50MlTTKUBjqi3AbWAWYwIoMW6pNhIFnGcW7PpXBegWsZYAkf?=
 =?us-ascii?Q?ArVF49Hz9jIqqB+j2mwhffVD4Cs8sLAwup369exNSBwkB+nBTjHiUHIko9VJ?=
 =?us-ascii?Q?7COy1LQdkCMYpZQ9HBneSOzWvi8t2AFv4T7oRh4LJ4UBV6omRFTaVgo1GxXk?=
 =?us-ascii?Q?Wd+QOM9LoCqgYCg9QabpYmHgmWv8vqYDgBmD5tkb7NI8iOOe0CZC3z4fd7X6?=
 =?us-ascii?Q?/NRqqdle/UynzceXmQzbX5DTiz2h+3DO3W+xd1A1dETcj79+XxNbooBZr2yJ?=
 =?us-ascii?Q?7276ETa6wA+qu1ypiRs1cpaKWj/QXb2WcqfFWrM+LHpkYnr0Gzhqj7s6ceRy?=
 =?us-ascii?Q?c1z4YI6XNcnRtM0QJtMkBnCDkbwz4yKh0WKhx0gSi1rxZ+/0YUDzhFFOICT+?=
 =?us-ascii?Q?VlrlYegUy5zP3avYnUJWjRjv4HCpgo1eD2w0m1JBzJ/urr4aqLnP0BfAqvev?=
 =?us-ascii?Q?GzzCGSjVbXr/yvCd5K6qwvsDDqQOPiWfqkQPYipjHWvvbY7lRWfvL6qWiOfn?=
 =?us-ascii?Q?HHeSEUNeVoY4y/oad49NEPXlqI7vXzgznyN6+LbAZFRxT1EsghXsgTiorDMa?=
 =?us-ascii?Q?X7D+tTSMM7Io1jAxXAYaycU+69tb5TaTxcQPv+KVqfXL9s8Sld9NnKr+oYop?=
 =?us-ascii?Q?AjbLGnCSRvIH1RkfAlihwIueQCMA4jbAKRtYWNEa9YZY8redjHS1xqpJE1Km?=
 =?us-ascii?Q?VuvvLPMx+jgAjPxP/M3AhUiuyLNWrqg6+Jp6qm7bhUxhIMJKQOUWjKjvCcCZ?=
 =?us-ascii?Q?txjSmt4ED+4PK8nFJDkwc6jlpHAL6POyouOeyodZEzuOf7jPgA8q3hIrBjhx?=
 =?us-ascii?Q?6qwRTAWDDnJBg9uMZnzzasjjBrdLfccFkm58g0ydfXzuCMS+tWM5mfqGEiFs?=
 =?us-ascii?Q?7Ls8NspdF2O1LlMc+l83FrTX7q48J1df6CUee4hSQoPw7OX2TkdyARSiDypY?=
 =?us-ascii?Q?1lrx8Tcoj8jNPUNkJGI29AYpBqgaZxejgSfbsUhyzR2NeBvxx1/Zkp6bfAUH?=
 =?us-ascii?Q?SPeHPQloRKaJ+i5pKgHgc0bfXIaTy1XhLTe4Va1ddjO1u7tYH82BoQyWtA6x?=
 =?us-ascii?Q?S4GyxTXXDY6V/tgUjE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fc8765-7a40-472f-6ec5-08db33f5c882
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 03:44:52.6919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8tW67HTvvC5MRE9ntk5SL79wrLohfztytYHnKUJNbvgLFzQ4KS15l0dIjFHxcgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, April 3, 2023 9:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
>=20
> Optimize redundant code in umc_v8_10
>=20
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  31 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   7 +
>  drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 197 +++++++++---------------
>  3 files changed, 115 insertions(+), 120 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 9e2e97207e53..734442315cf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -302,3 +302,34 @@ void amdgpu_umc_fill_error_record(struct
> ras_err_data *err_data,
>=20
>  	err_data->err_addr_cnt++;
>  }
> +
> +int amdgpu_umc_scan_all_umc_channels(struct amdgpu_device *adev,
> +			umc_func func, void *data)
> +{
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +	int ret =3D 0;
> +
> +	if (adev->umc.node_inst_num) {
> +		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +			ret =3D func(adev, node_inst, umc_inst, ch_inst, data);
> +			if (ret) {
> +				dev_err(adev->dev, "Node %d umc %d ch %d
> func returns %d\n",
> +					node_inst, umc_inst, ch_inst, ret);
> +				return ret;
> +			}
> +		}
> +	} else {
> +		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {

[Tao] for ASIC which doesn't support node, can we set its node_inst_num to =
1 and retire the macro LOOP_UMC_INST_AND_CH?

> +			ret =3D func(adev, 0, umc_inst, ch_inst, data);
> +			if (ret) {
> +				dev_err(adev->dev, "Umc %d ch %d func
> returns %d\n",
> +					umc_inst, ch_inst, ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index d7f1229ff11f..f279c8057f96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -47,6 +47,10 @@
>  #define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> \
>  		LOOP_UMC_NODE_INST((node_inst))
> LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
>=20
> +
> +typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
> +			uint32_t umc_inst, uint32_t ch_inst, void *data);
> +
>  struct amdgpu_umc_ras {
>  	struct amdgpu_ras_block_object ras_block;
>  	void (*err_cnt_init)(struct amdgpu_device *adev); @@ -104,4 +108,7
> @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
>  		struct amdgpu_iv_entry *entry);
>  int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
>  			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
> +
> +int amdgpu_umc_scan_all_umc_channels(struct amdgpu_device *adev,
> +			umc_func func, void *data);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> index fb55e8cb9967..6dff313ac04c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> @@ -76,10 +76,13 @@ static inline uint32_t get_umc_v8_10_reg_offset(struc=
t
> amdgpu_device *adev,
>  		UMC_8_NODE_DIST * node_inst;
>  }
>=20
> -static void umc_v8_10_clear_error_count_per_channel(struct amdgpu_device
> *adev,
> -					uint32_t umc_reg_offset)
> +static int umc_v8_10_clear_error_count_per_channel(struct amdgpu_device
> *adev,
> +					uint32_t node_inst, uint32_t umc_inst,
> +					uint32_t ch_inst, void *data)
>  {
>  	uint32_t ecc_err_cnt_addr;
> +	uint32_t umc_reg_offset =3D
> +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
>=20
>  	ecc_err_cnt_addr =3D
>  		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt); @@
> -87,24 +90,14 @@ static void
> umc_v8_10_clear_error_count_per_channel(struct amdgpu_device *adev,
>  	/* clear error count */
>  	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
>  			UMC_V8_10_CE_CNT_INIT);
> +
> +	return 0;
>  }
>=20
>  static void umc_v8_10_clear_error_count(struct amdgpu_device *adev)  {
> -	uint32_t node_inst       =3D 0;
> -	uint32_t umc_inst        =3D 0;
> -	uint32_t ch_inst         =3D 0;
> -	uint32_t umc_reg_offset  =3D 0;
> -
> -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> {
> -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> -						node_inst,
> -						umc_inst,
> -						ch_inst);
> -
> -		umc_v8_10_clear_error_count_per_channel(adev,
> -						umc_reg_offset);
> -	}
> +	amdgpu_umc_scan_all_umc_channels(adev,
> +		umc_v8_10_clear_error_count_per_channel, NULL);
>  }
>=20
>  static void umc_v8_10_query_correctable_error_count(struct amdgpu_device
> *adev, @@ -147,29 +140,29 @@ static void
> umc_v8_10_query_uncorrectable_error_count(struct amdgpu_device *adev
>  		*error_count +=3D 1;
>  }
>=20
> +static int umc_v8_10_query_ecc_error_count(struct amdgpu_device *adev,
> +					uint32_t node_inst, uint32_t umc_inst,
> +					uint32_t ch_inst, void *data)
> +{
> +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> +	uint32_t umc_reg_offset =3D
> +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
> +
> +	umc_v8_10_query_correctable_error_count(adev,
> +					umc_reg_offset,
> +					&(err_data->ce_count));
> +	umc_v8_10_query_uncorrectable_error_count(adev,
> +					umc_reg_offset,
> +					&(err_data->ue_count));
> +
> +	return 0;
> +}
> +
>  static void umc_v8_10_query_ras_error_count(struct amdgpu_device *adev,
>  					   void *ras_error_status)
>  {
> -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
> -
> -	uint32_t node_inst       =3D 0;
> -	uint32_t umc_inst        =3D 0;
> -	uint32_t ch_inst         =3D 0;
> -	uint32_t umc_reg_offset  =3D 0;
> -
> -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> {
> -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> -						node_inst,
> -						umc_inst,
> -						ch_inst);
> -
> -		umc_v8_10_query_correctable_error_count(adev,
> -						umc_reg_offset,
> -						&(err_data->ce_count));
> -		umc_v8_10_query_uncorrectable_error_count(adev,
> -						umc_reg_offset,
> -						&(err_data->ue_count));
> -	}
> +	amdgpu_umc_scan_all_umc_channels(adev,
> +		umc_v8_10_query_ecc_error_count, ras_error_status);
>=20
>  	umc_v8_10_clear_error_count(adev);
>  }
> @@ -248,28 +241,28 @@ static void umc_v8_10_convert_error_address(struct
> amdgpu_device *adev,
>  	}
>  }
>=20
> -static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
> -					 struct ras_err_data *err_data,
> -					 uint32_t umc_reg_offset,
> -					 uint32_t node_inst,
> -					 uint32_t ch_inst,
> -					 uint32_t umc_inst)
> +static int umc_v8_10_query_error_address(struct amdgpu_device *adev,
> +					uint32_t node_inst, uint32_t umc_inst,
> +					uint32_t ch_inst, void *data)
>  {
>  	uint64_t mc_umc_status_addr;
>  	uint64_t mc_umc_status, err_addr;
>  	uint64_t mc_umc_addrt0;
> +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> +	uint32_t umc_reg_offset =3D
> +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
>=20
>  	mc_umc_status_addr =3D
>  		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0);
>  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
>=20
>  	if (mc_umc_status =3D=3D 0)
> -		return;
> +		return 0;
>=20
>  	if (!err_data->err_addr) {
>  		/* clear umc status */
>  		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL);
> -		return;
> +		return 0;
>  	}
>=20
>  	/* calculate error address if ue error is detected */ @@ -287,37 +280,2=
5
> @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
>=20
>  	/* clear umc status */
>  	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
> +
> +	return 0;
>  }
>=20
>  static void umc_v8_10_query_ras_error_address(struct amdgpu_device *adev=
,
>  					     void *ras_error_status)
>  {
> -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
> -	uint32_t node_inst       =3D 0;
> -	uint32_t umc_inst        =3D 0;
> -	uint32_t ch_inst         =3D 0;
> -	uint32_t umc_reg_offset  =3D 0;
> -
> -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> {
> -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> -						node_inst,
> -						umc_inst,
> -						ch_inst);
> -
> -		umc_v8_10_query_error_address(adev,
> -					err_data,
> -					umc_reg_offset,
> -					node_inst,
> -					ch_inst,
> -					umc_inst);
> -	}
> +	amdgpu_umc_scan_all_umc_channels(adev,
> +		umc_v8_10_query_error_address, ras_error_status);
>  }
>=20
> -static void umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *ade=
v,
> -					      uint32_t umc_reg_offset)
> +static int umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *adev=
,
> +					uint32_t node_inst, uint32_t umc_inst,
> +					uint32_t ch_inst, void *data)
>  {
>  	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>  	uint32_t ecc_err_cnt_addr;
> +	uint32_t umc_reg_offset =3D
> +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
>=20
>  	ecc_err_cnt_sel_addr =3D
>  		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCntSel);
> @@ -332,23 +313,14 @@ static void
> umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *adev,
>  	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
> ecc_err_cnt_sel);
>  	/* set error count to initial value */
>  	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
> UMC_V8_10_CE_CNT_INIT);
> +
> +	return 0;
>  }
>=20
>  static void umc_v8_10_err_cnt_init(struct amdgpu_device *adev)  {
> -	uint32_t node_inst       =3D 0;
> -	uint32_t umc_inst        =3D 0;
> -	uint32_t ch_inst         =3D 0;
> -	uint32_t umc_reg_offset  =3D 0;
> -
> -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> {
> -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> -						node_inst,
> -						umc_inst,
> -						ch_inst);
> -
> -		umc_v8_10_err_cnt_init_per_channel(adev, umc_reg_offset);
> -	}
> +	amdgpu_umc_scan_all_umc_channels(adev,
> +		umc_v8_10_err_cnt_init_per_channel, NULL);
>  }
>=20
>  static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device *adev)
> @@ -406,37 +378,35 @@ static void
> umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdgpu_dev
>  	}
>  }
>=20
> +static int umc_v8_10_ecc_info_query_ecc_error_count(struct amdgpu_device
> *adev,
> +					uint32_t node_inst, uint32_t umc_inst,
> +					uint32_t ch_inst, void *data)
> +{
> +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> +
> +	umc_v8_10_ecc_info_query_correctable_error_count(adev,
> +					node_inst, umc_inst, ch_inst,
> +					&(err_data->ce_count));
> +	umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
> +					node_inst, umc_inst, ch_inst,
> +					&(err_data->ue_count));
> +	return 0;
> +}
> +
>  static void umc_v8_10_ecc_info_query_ras_error_count(struct amdgpu_devic=
e
> *adev,
>  					void *ras_error_status)
>  {
> -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
> -
> -	uint32_t node_inst       =3D 0;
> -	uint32_t umc_inst        =3D 0;
> -	uint32_t ch_inst         =3D 0;
> -
> -	/* TODO: driver needs to toggle DF Cstate to ensure
> -	 * safe access of UMC registers. Will add the protection
> -	 */
> -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> {
> -		umc_v8_10_ecc_info_query_correctable_error_count(adev,
> -							node_inst, umc_inst,
> ch_inst,
> -							&(err_data-
> >ce_count));
> -		umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
> -							node_inst, umc_inst,
> ch_inst,
> -							&(err_data-
> >ue_count));
> -	}
> +	amdgpu_umc_scan_all_umc_channels(adev,
> +		umc_v8_10_ecc_info_query_ecc_error_count,
> ras_error_status);
>  }
>=20
> -static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device
> *adev,
> -					struct ras_err_data *err_data,
> -					uint32_t ch_inst,
> -					uint32_t umc_inst,
> -					uint32_t node_inst)
> +static int umc_v8_10_ecc_info_query_error_address(struct amdgpu_device
> *adev,
> +					uint32_t node_inst, uint32_t umc_inst,
> +					uint32_t ch_inst, void *data)
>  {
>  	uint32_t eccinfo_table_idx;
>  	uint64_t mc_umc_status, err_addr;
> -
> +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
>  	eccinfo_table_idx =3D node_inst * adev->umc.umc_inst_num * @@ -
> 447,10 +417,10 @@ static void
> umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>=20
>  	if (mc_umc_status =3D=3D 0)
> -		return;
> +		return 0;
>=20
>  	if (!err_data->err_addr)
> -		return;
> +		return 0;
>=20
>  	/* calculate error address if ue error is detected */
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 && @@ -463,28 +433,15 @@
> static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device
> *adev,
>  		umc_v8_10_convert_error_address(adev, err_data, err_addr,
>  					ch_inst, umc_inst, node_inst,
> mc_umc_status);
>  	}
> +
> +	return 0;
>  }
>=20
>  static void umc_v8_10_ecc_info_query_ras_error_address(struct
> amdgpu_device *adev,
>  					void *ras_error_status)
>  {
> -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
> -
> -	uint32_t node_inst       =3D 0;
> -	uint32_t umc_inst        =3D 0;
> -	uint32_t ch_inst         =3D 0;
> -
> -	/* TODO: driver needs to toggle DF Cstate to ensure
> -	 * safe access of UMC resgisters. Will add the protection
> -	 * when firmware interface is ready
> -	 */
> -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> {
> -		umc_v8_10_ecc_info_query_error_address(adev,
> -						err_data,
> -						ch_inst,
> -						umc_inst,
> -						node_inst);
> -	}
> +	amdgpu_umc_scan_all_umc_channels(adev,
> +		umc_v8_10_ecc_info_query_error_address, ras_error_status);
>  }
>=20
>  const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops =3D {
> --
> 2.34.1
