Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D6AC64EC7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 08:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBC910E0A3;
	Wed,  1 Mar 2023 08:20:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 102E410E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 08:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTreOrHB4pCYd9sCzp0+lEmsTWLYrrLVukIJqshLADjsbn1tamsg4Ci69IN4VhQPIOUJHgMItxkD+cM99ELRa2PTeQS9tOTPRp9qVs6xP1e8ZRAdH0i3IUvTUhdF4DhHx9nhyXGtRo3evV4sJBhTpckTGMMV4v4amruvIPADEyxqAqUWOLJjGpkCay86KxP29q8K6AGQTi4brijHLsrInlgZ4N06MZPupCd7UJswE49/scSvAdUaYrx/p3Y17A67UspOx3/AIn14yZADZIxYG4DhyJUAoxGIfaFnZa/a+rlenkB6V5RVyjtkV1YHrgBxqohtNo0dWsvPLeC5gktUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PesDH0T/UxvwQ5ZxVbfdRHWNsSnz3y8oGIFDnNU7bdA=;
 b=SAn+iHWiUW2k3B32iZprM1ZEnTwEhlubj0/WQCH+qjX7vwbLH/1QLvvO95boHuWI1ZygexaK9cjMFO8nqHlxoweUmIHjPEYNgwnOVGcMmeZDqkEHK3ds1ux1waSTmX4pR747Pq7gIbxS9kt8Jrj/x1rxr8s/no6YjtNiNsT/430CTf5f0HUNrTrfaD8qoPGRNBKwd6EQtp9eGRnTJPg+8ZweZly5jVKKhasgsrJG13MMUYszfMIH6lqieOsESzCL6dbwFWShFECs+rB0Jk/T3kMe20dH/eHNKR66uXFE5VAnZodEgfRhT9YCIXvH/ubH5EE6kWNtz0veEQU1+cjDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PesDH0T/UxvwQ5ZxVbfdRHWNsSnz3y8oGIFDnNU7bdA=;
 b=CRk1iYYVNygL/aqEKl+s1es7CNIh/O3zJARqQlXxXhMSzYTJxdE9e3iU5wX3InUz7MD/3EksOSFg7tBKEr7UXhvvuRKyl3XH1mGIaCCa7ajKvqpp4jo4TpdI8SykN6PIaTc4hEgutpE9MavTgFiHmgzJ0ndrm8xu2roafa/oljI=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 08:20:52 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 08:20:52 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable ecc_info table support for smu v13_0_10
Thread-Topic: [PATCH] drm/amd/pm: Enable ecc_info table support for smu
 v13_0_10
Thread-Index: AQHZTASCO8DbEKmy+kGisZJamOPf1a7llTHQ
Date: Wed, 1 Mar 2023 08:20:51 +0000
Message-ID: <BL1PR12MB5334291097FD4A57206786089AAD9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230301061001.16542-1-candice.li@amd.com>
In-Reply-To: <20230301061001.16542-1-candice.li@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-01T08:20:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3983a02a-2fc5-48ec-8686-fa077188b30b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-01T08:20:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7675f8f1-5374-44cc-9c1c-0f821e1e89d2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|IA0PR12MB8226:EE_
x-ms-office365-filtering-correlation-id: e193e9cf-04c8-4427-e3a4-08db1a2ddf04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzH2mrxuqYbaPkCChdOKka8qszTEXJaoTySIphKQ8ekbBfYBgeSY4a6Pp1eNn7+Xs35O9yNubCuP9aaHN4lq1oC0nnQnHN+dqQdp2YLKhG55TfGgS5zuIhKLrR2QOLNLenUdi7NO7jJBtIXvyavLUkLK9rIRBogWUNETMLzxoNcQR5BXBPoqlRabWc+VAsJsOe2t+fpqO/DE8siPoDlWtSFSriaWwGKOCUHPtHW5X2pnpMXYPdlQfM8OuzqQNO8/UU+oyhD7frmg7y76F2fPV00oAw8U7/HtlApRq9gcLBrfplUXNlNJIIQxmJzGDsyv1XgRLI26d6/M8iaD4BJcFCC4ZS9MZN2Zf1rSirZIIFqp4rCqKgQs/HOZdiM3ulG7fpCd3+PFY+RCWX2sbGqcn4OF+GRDGp67gWYUAuj58YqHj+vynwZpSxia4ApHT/XbKiyZNa12DiY641giU9GsU4dHMdAuv6IMF/nxelC/REgC5OX0KUZyIW5e/Yrm9eENQw1Th35wGRIvjRbBlxZT+FyhNhEYN4HbqGlwHgXjCNpPvjCEVZ/+IJYMZKRhkkySxLvjh8DceJrfG/Fv1rO2BQ3TuJXC8wQOD5JGQxt9Y9CBajedmWcYm8YFeZIF3PklD9MTsWbcB2dOaaeMDcTvfanjFnNjDs2UNG5L9Ih7+XSOWNfFc8jWdfTpJlYMRMwwTIZLoFkW8yxFhAXC7PQRpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(478600001)(83380400001)(316002)(110136005)(33656002)(4326008)(122000001)(64756008)(66446008)(38100700002)(76116006)(8676002)(66476007)(53546011)(6506007)(26005)(9686003)(186003)(7696005)(71200400001)(5660300002)(66946007)(66556008)(55016003)(8936002)(41300700001)(86362001)(2906002)(52536014)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9BWqHHUQt0duDAuQRetbezg0jhQm82YF/lmqO7pMA3vUwI6gNpK0Ab1aAfnz?=
 =?us-ascii?Q?0lvvjkAp3OTaskNNnjmaFVhsvSb05JznRrzDdVkJsKPB2PiG9EqvxCV9kwON?=
 =?us-ascii?Q?dl4DJSrRznYeJ6c6o8sGIbL5w+eEynPXik0eFXED0ZJKNTcbr9nwz7jF4Dtb?=
 =?us-ascii?Q?2AyGPmhbXVfvFzEyaWfUea3mfCSXM1LK259YNBgE8UinPaEEYdSQL94LbD0K?=
 =?us-ascii?Q?w0j8kuFU7R1BKmT9swbv/KrbggEZXeqfiBr8L+/+qbboksQsDDwsffl9ZJj8?=
 =?us-ascii?Q?refIKwXU8KMbTpf5yBekr30EIrpScQuHztVzjXxfinb3pc9JX90tmzARumlf?=
 =?us-ascii?Q?OBSrLe8Ghu0KW20hE71W3a+4ThZseqRv+o5wc0eTW70SBXZCfrdR/JobcSEf?=
 =?us-ascii?Q?f5U/DyYHnpEUX4gD69jWWnJZiPEKWgpG6ziphRJi+4IFU5mo1OZZ4InHi9X+?=
 =?us-ascii?Q?b7x3SSx4iZGjcW3DZlM2bLuAryJJIIYOgWQfZ34xLNDkTXsN/XJAiepe4SOA?=
 =?us-ascii?Q?Oz1Oexg8/qS9nQaq3tPx6yKWf9sKK4Jl+0FSp9LdhJp96b+o8NS7UvHjdOrm?=
 =?us-ascii?Q?NlskR8dzsoqU7P/zyZpWttQoUuru6uC7tsrQ2RGkh4YvKaPtT0g/4EZerYBl?=
 =?us-ascii?Q?qXGPGb/RGy3NQPHV5hnuYtQm8wykvWDpFW2m2pxYLxOd/HRtac9TpTWZB1e9?=
 =?us-ascii?Q?Rc138yewQ15K6+tI+T2vYa3bMlj7CpOkO5YDt6admHNIN7FCaQlbGZ8v7bJi?=
 =?us-ascii?Q?j+wn/enY2wlZz0XrXrykKa7c0jgkQPYJa3oroixH+BaCoN2SJLkxvpjrn/X4?=
 =?us-ascii?Q?V8+FpxCPaza7r6eP2WvkXJsgmyxbBqlrlS/+dUrjEaZbi/5EnBvMwWarJoiS?=
 =?us-ascii?Q?/ovZIr2OmT3PP/0rPs5/58zG1l/2lnf4kygg0rpRogA4uCNPtp99hUuk8gvl?=
 =?us-ascii?Q?nlowXWx91EBGEEOmY6Ehe1E4DAWQrD7o5Hd4zASGlK3OehYY7JA0Yx9aKBb6?=
 =?us-ascii?Q?OV8M7LvJmXC2aRYgqPTKh7lzJKuNi1TcMQicArTuNuOvljQHc+V4eLwKesJC?=
 =?us-ascii?Q?Xs0mklRfRAXaH0unFp8hgAu2mEKUbcFSQgIPkUyMxPhTk3ZeSqRQ8Z+5Iipt?=
 =?us-ascii?Q?gH/SEZEyr6O9jUUgokuKtLe9DDrYDartDAYUsJlmtn8e7kRZxRUo9VoK/cbP?=
 =?us-ascii?Q?KhJad8MQolNStGs3zRnnGdWcttzVfORPkLr5DpJLZX0zObI/v6jBfR71D3xd?=
 =?us-ascii?Q?Uv5iRTu4esH3eofm/mK5+8YiLDdbm1UlOBnSeMzUnhbYnSw8fUS3PEuRjy/h?=
 =?us-ascii?Q?ZoY3kPRpRvk3dRh0LCMCnHNvW3aB0YS47vB6zw/D22CXjOxvEbkOF1PY2Bzg?=
 =?us-ascii?Q?9j19vm0pgC0SDtWfDuCcT6tE2SgdrDdP1c0DSvdzPR9TsByYg6vFVC1vRITO?=
 =?us-ascii?Q?V2mmcBrwCRzsS9ISqiQ7LPvywM9rx200jqNaCOP/icrxQXeT6YYIxGT7pKEe?=
 =?us-ascii?Q?DgAoW/YjzYJawd/qmGfqienesaFw2QxaT5bBepHLxf4voJ8csi7Nnocw0sz/?=
 =?us-ascii?Q?FYvHIjasfLKlRifTkdVKhM+ILCtrSCDkMb/H1RLY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e193e9cf-04c8-4427-e3a4-08db1a2ddf04
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 08:20:51.9922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzyHseu3LFpvbgT9++PJ/0KPWUNqtMkK2EifXiUDnojpJk0kBFTGNROhl2eBvlAwWQrKK8QGZkfJPp2pG2VOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Candice Li
> Sent: Wednesday, March 1, 2023 2:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amd/pm: Enable ecc_info table support for smu
> v13_0_10
>=20
> Support EccInfoTable which includes umc ras error count and error address=
.
>=20
> Signed-off-by: Candice Li <candice.li@amd.com>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 75
> +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 923a9fb3c8873c..27448ffe60a439 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -46,6 +46,7 @@
>  #include "asic_reg/mp/mp_13_0_0_sh_mask.h"
>  #include "smu_cmn.h"
>  #include "amdgpu_ras.h"
> +#include "umc_v8_10.h"
>=20
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
> @@ -90,6 +91,12 @@
>=20
>  #define DEBUGSMC_MSG_Mode1Reset	2
>=20
> +/*
> + * SMU_v13_0_10 supports ECCTABLE since version 80.34.0,
> + * use this to check ECCTABLE feature whether support  */ #define
> +SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
> +
>  static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D {
>  	MSG_MAP(TestMessage,
> 	PPSMC_MSG_TestMessage,                 1),
>  	MSG_MAP(GetSmuVersion,
> 	PPSMC_MSG_GetSmuVersion,               1),
> @@ -229,6 +236,7 @@ static struct cmn2asic_mapping
> smu_v13_0_0_table_map[SMU_TABLE_COUNT] =3D {
>  	TAB_MAP(ACTIVITY_MONITOR_COEFF),
>  	[SMU_TABLE_COMBO_PPTABLE] =3D {1, TABLE_COMBO_PPTABLE},
>  	TAB_MAP(I2C_COMMANDS),
> +	TAB_MAP(ECCINFO),
>  };
>=20
>  static struct cmn2asic_mapping
> smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] =3D { @@ -462,6
> +470,8 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
>  		       AMDGPU_GEM_DOMAIN_VRAM);
>  	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE,
> MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
>  			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO,
> sizeof(EccInfoTable_t),
> +			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>=20
>  	smu_table->metrics_table =3D kzalloc(sizeof(SmuMetricsExternal_t),
> GFP_KERNEL);
>  	if (!smu_table->metrics_table)
> @@ -477,8 +487,14 @@ static int smu_v13_0_0_tables_init(struct
> smu_context *smu)
>  	if (!smu_table->watermarks_table)
>  		goto err2_out;
>=20
> +	smu_table->ecc_table =3D kzalloc(tables[SMU_TABLE_ECCINFO].size,
> GFP_KERNEL);
> +	if (!smu_table->ecc_table)
> +		goto err3_out;
> +
>  	return 0;
>=20
> +err3_out:
> +	kfree(smu_table->watermarks_table);
>  err2_out:
>  	kfree(smu_table->gpu_metrics_table);
>  err1_out:
> @@ -2036,6 +2052,64 @@ static int
> smu_v13_0_0_send_bad_mem_channel_flag(struct smu_context *smu,
>  	return ret;
>  }
>=20
> +static int smu_v13_0_0_check_ecc_table_support(struct smu_context
> *smu)
> +{
> +	struct amdgpu_device *adev =3D smu->adev;
> +	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
> +	int ret =3D 0;
> +
> +	ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
> +	if (ret)
> +		return -EOPNOTSUPP;
> +
> +	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) &&
> +		(smu_version >=3D
> SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
> +		return ret;
> +	else
> +		return -EOPNOTSUPP;
> +}
> +
> +static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
> +									void
> *table)
> +{
> +	struct smu_table_context *smu_table =3D &smu->smu_table;
> +	struct amdgpu_device *adev =3D smu->adev;
> +	EccInfoTable_t *ecc_table =3D NULL;
> +	struct ecc_info_per_ch *ecc_info_per_channel =3D NULL;
> +	int i, ret =3D 0;
> +	struct umc_ecc_info *eccinfo =3D (struct umc_ecc_info *)table;
> +
> +	ret =3D smu_v13_0_0_check_ecc_table_support(smu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D smu_cmn_update_table(smu,
> +					SMU_TABLE_ECCINFO,
> +					0,
> +					smu_table->ecc_table,
> +					false);
> +	if (ret) {
> +		dev_info(adev->dev, "Failed to export SMU ecc table!\n");
> +		return ret;
> +	}
> +
> +	ecc_table =3D (EccInfoTable_t *)smu_table->ecc_table;
> +
> +	for (i =3D 0; i < UMC_V8_10_TOTAL_CHANNEL_NUM(adev); i++) {
> +		ecc_info_per_channel =3D &(eccinfo->ecc[i]);
> +		ecc_info_per_channel->ce_count_lo_chip =3D
> +				ecc_table->EccInfo[i].ce_count_lo_chip;
> +		ecc_info_per_channel->ce_count_hi_chip =3D
> +				ecc_table->EccInfo[i].ce_count_hi_chip;
> +		ecc_info_per_channel->mca_umc_status =3D
> +				ecc_table->EccInfo[i].mca_umc_status;
> +		ecc_info_per_channel->mca_umc_addr =3D
> +				ecc_table->EccInfo[i].mca_umc_addr;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
>  	.get_allowed_feature_mask =3D
> smu_v13_0_0_get_allowed_feature_mask,
>  	.set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
> @@ -2111,6 +2185,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>  	.send_hbm_bad_pages_num =3D
> smu_v13_0_0_smu_send_bad_mem_page_num,
>  	.send_hbm_bad_channel_flag =3D
> smu_v13_0_0_send_bad_mem_channel_flag,
>  	.gpo_control =3D smu_v13_0_gpo_control,
> +	.get_ecc_info =3D smu_v13_0_0_get_ecc_info,
>  };
>=20
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> --
> 2.17.1
