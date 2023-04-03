Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AEEC761AF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 07:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A49510E143;
	Mon,  3 Apr 2023 07:00:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07ECC10E143
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 07:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPuoPaV2G6aVQ2cgagExk19rFjVK0/K4emrxw8fcYnHa/cnOfd9bLdph5p3iFMDrFMb62/dp7vApkNfLalYnkoZQQUbw6WP9AkcHBCITEg1Xkv9myggC5EP98a+7WQVqG9qqdCcHi+sEcUOcoTQxILQXrm2BJ9FLPl4OROW4/iPafecpPg2S9tFTY37RLvMXDX/758A+ZNnfudjZXUlEgTTi8LCPiIQtXrVSCSyiFqKS0fHPfGr+U4+msuIY/RmkJtEv8xHzpX3CT1/XR78V+EGlHLyaQ4VjGJ6mJhM7s1977cphl4Ay0vneYjfc7yxySJyAi09keIT1/HzjLXhRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AXpD1NEMZXomX7DaXZw1wq2f3MBLbTzeIKsAJET4GM=;
 b=YaglEELcJKUZl30NWcRSLgPz8L8/433Y03EYTGe/M7SLbldGUj5fbnlWQl+g/jxChBrEsn31DTQjLXAbREGGk3/ze4K7MF6iHAH1hveQfuad9GgXtgoz0Q1cm31Q+ICJNuwGmGN2hJwHAigshZsC6ygerXyXpwzQAj5TH9LznbmbDRVU7LDDCeSOwy5ny4K0gnVugcOju4OXjVqHOcOWghwrVPOwo26jxDZ+RifLv39T1RqpznGx5efVEG0cVShyyd+6RiV7cSBAYn2OoWVkFv/lh1mV9/KVhzoi6pXe88MJRzkbL1ra4Ksz9Ljhlrghmp7Rit07fTwj9p5NIH2HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AXpD1NEMZXomX7DaXZw1wq2f3MBLbTzeIKsAJET4GM=;
 b=ItrO42Ol1aCXgl7Fw0MfXYfSdDxTjoL6+Z77SaLSZpIwlbj8GGGqj3zjvT8zJbB81K10J7t89nxhieom/YeQ1T8mnjeRcakZIBBU3SXpdYubY4ykkwbW4RRbeIixu51x2MNj1r+qd/174ImNwoiRsNBTZznFFw0CukZ/eof3DP8=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 3 Apr
 2023 07:00:18 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::bb38:d4e0:f6b4:a63f]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::bb38:d4e0:f6b4:a63f%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:00:18 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Topic: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Index: AQHZZdBDO0k9cJG1UUCgKiC41iaIJ68Y8aoAgAAxdTA=
Date: Mon, 3 Apr 2023 07:00:18 +0000
Message-ID: <CH2PR12MB42153455C15B4151D1FE6281FC929@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
 <DM5PR12MB1770077FD7D17A141B9D608CB0929@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770077FD7D17A141B9D608CB0929@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-03T07:00:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77aa5156-25a5-4735-a093-69ee1d4e4933;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-03T07:00:14Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 58cbc079-33a4-45b1-b9ee-2b7b4caeae82
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|IA1PR12MB6483:EE_
x-ms-office365-filtering-correlation-id: df4dd435-6da4-4144-5a64-08db3411159f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PPKk1G5H+/EgJZGdR4yrbh6zKkIqO6AsC4CVH8qrigdYzwaRewuO6USiBUSYHk9op+rVivmk/WTw+N/YPoirzN1do+7QmmtgKRXv2qt8MFEm/dPlR3VsfJWr7yxdYwykoyO99sglRH2HQCMmGxp+mpkvIEaxJyXep4nXLjAtQFMumRzVQiJG1nCNXFyTsuyrr4LpF7I+H+KsjJQK755I9eo1k2D8SXbmuGhwAYsnnklVHWsB3+5CIMauzhet4sZaL9UODw9omUD4fe7673OgfvftLH/snxzJF9NIcm1U+2DIcnCAEjQAIusg/WfvTD+BFFVWiPin1JM2Pnqz5kdvxgrJ6DnCUGZ5aw+Mlobf2HZP68RctqtIzSrcvhq7lHVpcavw2rpF5qKp/AEInbbvrj0st30L5Y7JgOsh9nMEmWpMngoKzHHbfZUumhZ7mrqO75rdQyOHoS+R+27c6yOts13tJIdoDwMcpiLPNp2qApP4dk+eDYBsmicNcm9Pxnr+zGL5Es/ClEqb3n+4dc5KNLicY6Pop84ax6P9CC2EiPo4i154deKNM2zAnXsoafCxjf+Iy2eS1IWEYhutbZln9m1JigFuknKdotp7dJc773Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(30864003)(54906003)(6506007)(110136005)(316002)(8676002)(5660300002)(7696005)(38100700002)(9686003)(66476007)(33656002)(4326008)(64756008)(66446008)(71200400001)(83380400001)(186003)(478600001)(66556008)(53546011)(76116006)(66946007)(2906002)(26005)(38070700005)(122000001)(52536014)(86362001)(55016003)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aD7UUB/JSdO68keja+PTRzwwWtfem95H/bb0BclZEwCWBwlVjdaN59IBEqQz?=
 =?us-ascii?Q?vxEwucdtUfvPjTTq1Quc0s0Ov9xO/2Mv0EplPFXG8wOnfoK2hevXh3o0SOAX?=
 =?us-ascii?Q?f83rnsj4TAb/4smMnjE0XbuUdX3G3RjnJgv1TGPwX0PZ5eTP3jVpJfHo3i3d?=
 =?us-ascii?Q?fDY8g12b/oroqWeh4ubDsHElk9qSbAFMe7hhHdTECSXlUpDpTWN9ICuBbGZ/?=
 =?us-ascii?Q?nPzSjCos06n01mlHpqPnXoLqKuGlcX9qdC520Oy9/dSfvfQvQlfOBmTn6qvh?=
 =?us-ascii?Q?/BPjOsgSDRvYJS3Na9AHoupDY+qmhZM2JHtqzQRmXVlERDnU6Wt+3J/Ptj5t?=
 =?us-ascii?Q?fVOSby8qiz0BaxuR+94qm1StiCzrHfcf3gWhPasw9DBfV64yoJwMna///nGb?=
 =?us-ascii?Q?kkxIgTtg5hWTldbNoazdzzoI3i2hsze8C80cG/76AN73kQYJEbvlnRUNaMkT?=
 =?us-ascii?Q?++GecAKkYQq0NPDy00qRg2YveIfNNf9k7CmE/lyDbKmDOx24Z1jgHYMuDS+g?=
 =?us-ascii?Q?Bl6AJmkdSV7Mt38MPAfquEx3PxZ6X7HK+UyBXHmAibzyOLCH0B5Ef+T7GtQt?=
 =?us-ascii?Q?HhrfrHGB65U4VZeqTfdlTTr9gkIGcRMjXj5bRK0A3sIofOY04WD8qH1sbIFX?=
 =?us-ascii?Q?X4JhZ21w1jFXyzYCgBz46zVyuCobhhlXYCd9xi1BTlfzYeQDg5d+7cqJj1u6?=
 =?us-ascii?Q?5/zO9J9CcfFWigqLthKJUZA3NVF1IMkk/rVGtO3Lhj1atL4SDTFyV5xRpvpV?=
 =?us-ascii?Q?/YNVUGrKyt4K9GGGoUQCI7NgSemzG4H1SsN2YUIY94317vNPVCJjeQBMJvNO?=
 =?us-ascii?Q?kUdIhrA9hh/k+iDF0XOAWuB92M6Twf9bEH6DYA9yJkBMEZg7uZp5+FAHAHy+?=
 =?us-ascii?Q?EH9Qi3+ogviYV5zZP0PD92HAxtEf1xvoXiqCjgZxXp2WJ7GBcatCN4rkSRIy?=
 =?us-ascii?Q?gs2QplTtPza0BGHXFH+fBMHVFRf4E83SFtjd9ayGvzYoiYi6SQHVOUdGCWcm?=
 =?us-ascii?Q?C5PEvz6qL2lG20a39qgkv/9xe71sOSF9MtdizGewbPUd0nu99LlZkct8I46f?=
 =?us-ascii?Q?FzLNAunW05qo35gNt44LV1ayvkYMqmvR4RWdsGA7GAdUVlqPpWiaHwcKuydH?=
 =?us-ascii?Q?UyoPPzHRi4avkbgxMThdml5dwJ3EbRESeGhOxOVLNexbUEq87ghzdQA/3LKN?=
 =?us-ascii?Q?ydwMYl3SSmeHiS6zR7yDkGM4ChHNwHeqe6KmGPIVz7xH9Bo0uDprnmqpqNKT?=
 =?us-ascii?Q?tPZLSDuqYee7pIz5OLiLgJ4Y7G4+DX55peOLqgtLFFl+nW7Ty5Em2PnY+iG5?=
 =?us-ascii?Q?93E1mzh4H1Uj5Xjd7yrtlYJ0nYIm/pSDmso67otlOYAQsmaUxgfdejgFTH6f?=
 =?us-ascii?Q?YtvlZoCWGRHp+l/W8+GFBriNqDOF90SEbzZHGrBZy1GyX9mEBJNO8aFAqXpD?=
 =?us-ascii?Q?diGrZB34faHanOs2XFLiXNHUzU3sYT/1emxo42oBVfu3rqmBbLUUcFKOnOtW?=
 =?us-ascii?Q?2A6u6WF4En0XC7n7A9oBBFr3IM2RY6edB790AYi15VjmA+PDKndlRhEQQUzS?=
 =?us-ascii?Q?lfQUyO5+tzqwSjGdIAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4dd435-6da4-4144-5a64-08db3411159f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 07:00:18.4753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfbKg3XFF2zSFgf8E8qnuXgPjqSknV0kZQCRoDOLB7lDUIWBc9fiihTwnCgc3UZevTLtaoL1Mooq245Xy93FdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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




-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, April 3, 2023 11:45 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10

[AMD Official Use Only - General]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, April 3, 2023 9:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice=20
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,=20
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
>=20
> Optimize redundant code in umc_v8_10
>=20
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  31 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   7 +
>  drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 197=20
> +++++++++---------------
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

>[Tao] for ASIC which doesn't support node, can we set its node_inst_num to=
 1 and retire the macro LOOP_UMC_INST_AND_CH?

[Thomas] I am afraid not.
=09
	" #define LOOP_UMC_NODE_INST(node_inst) \
		for_each_set_bit((node_inst), &(adev->umc.active_mask), adev->umc.node_in=
st_num) "
=09
	The node instance loop of LOOP_UMC_EACH_NODE_INST_AND_CH  supports node ha=
rvest, so node_inst_num is not the real node instance number.


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
>  #define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)=20
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
>  	void (*err_cnt_init)(struct amdgpu_device *adev); @@ -104,4 +108,7=20
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
> @@ -76,10 +76,13 @@ static inline uint32_t=20
> get_umc_v8_10_reg_offset(struct amdgpu_device *adev,
>  		UMC_8_NODE_DIST * node_inst;
>  }
>=20
> -static void umc_v8_10_clear_error_count_per_channel(struct=20
> amdgpu_device *adev,
> -					uint32_t umc_reg_offset)
> +static int umc_v8_10_clear_error_count_per_channel(struct=20
> +amdgpu_device
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
>  static void umc_v8_10_query_correctable_error_count(struct=20
> amdgpu_device *adev, @@ -147,29 +140,29 @@ static void=20
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
> @@ -248,28 +241,28 @@ static void=20
> umc_v8_10_convert_error_address(struct
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
>  		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
> -		return;
> +		return 0;
>  	}
>=20
>  	/* calculate error address if ue error is detected */ @@ -287,37=20
> +280,25 @@ static void umc_v8_10_query_error_address(struct=20
> amdgpu_device *adev,
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
>  		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCntSel); @@ -332,23=20
> +313,14 @@ static void umc_v8_10_err_cnt_init_per_channel(struct=20
> amdgpu_device *adev,
>  	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,=20
> ecc_err_cnt_sel);
>  	/* set error count to initial value */
>  	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,=20
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
>  static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device=20
> *adev) @@ -406,37 +378,35 @@ static void=20
> umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdgpu_dev
>  	}
>  }
>=20
> +static int umc_v8_10_ecc_info_query_ecc_error_count(struct=20
> +amdgpu_device
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
>  static void umc_v8_10_ecc_info_query_ras_error_count(struct=20
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
> -static void umc_v8_10_ecc_info_query_error_address(struct=20
> amdgpu_device *adev,
> -					struct ras_err_data *err_data,
> -					uint32_t ch_inst,
> -					uint32_t umc_inst,
> -					uint32_t node_inst)
> +static int umc_v8_10_ecc_info_query_error_address(struct=20
> +amdgpu_device
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
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 && @@ -463,28 +433,15 @@ stati=
c=20
> void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device=20
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
