Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8C3C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 07:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565ED10E44B;
	Thu, 23 Mar 2023 07:17:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E832910E449
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 07:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIpYpcor4CHctrL+11lNzW9fu5aqcPXsMqvMZef0GH/WL3DxQeBs+rM1fIMfQ4miTEnDD5hcbEOqrdpnkyRomx2H3uXSo28hS+Delb5zKTjoJb8iBY9TcUr8XOZLUT4iQcDmUAiIl4kNoaLYld9grOO72JZ0zmvTi9/kHjVzpQYzmR9erS0Jxix+JJhPiYOcrE351Qr9EuUS9ZoSU8ww1XPQPXTIXhWbfmMQbs8Ez4hop6yQEQKiEGl2VF0P93e/Vuj4RMP/nkGira0LCraHCf6pz8f2kc9VMqWhxkRMUoA7+6FnUDV/7pBrq8+yvnGhkoF+LYgTZYmwYXhHU84Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKsGg7Q5UfWXd5WSwsRKe2z9CmVcuialEm52/7lUuQA=;
 b=W4pt4MJocz+jnykf7XeLsygJZBm4Eri94YxG1p6pgPUuHK5ZRm1ddtS7YJ6Uzs1ne7EKFrSGdZzgROz9TTiVYKJie+BazsTnbBwTFE26hp5vAO0A71CVKmSbUG3OexYp7ognxlvsb6vtEQ3BJ7vTjPnKgET7S358LKMfdvxu1AqJK3quqJYJuS9bXN3JrdnG0gZ+6hX1of6WPlhK+ZLEmJfa7unfFe/3JJPbUJdQwau5lppITeevOF5lD/N8NYp5LVutSBRI9SIkCygU4we0Vh285u3vhGhTD2xMraBk80dCtg2woYfhIRYk0l7YSDn2vCHPyT29Z2Vo3gkG58xtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKsGg7Q5UfWXd5WSwsRKe2z9CmVcuialEm52/7lUuQA=;
 b=bywO52bvZmTXnw9Cxuof90/m9HIfxjk2ESDzsEsZCG6mBma27AtgXWdrhYtoMMf3oA55ooiUA72GNCu6v6qnwkPKZAVzqeQc0+fntziRMv172PBr8ootn1C+4mD1EiWJeb+M5Nli/rVFYjF+iR/AWq7g+CJ0xhV8Ckj3i0cFBFY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:17:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 07:17:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, WenYou" <WenYou.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Thread-Topic: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Thread-Index: AQHZXJ8Cvt8pFLlCdUGwD8dZ681k2a8H9KxA
Date: Thu, 23 Mar 2023 07:17:17 +0000
Message-ID: <DM6PR12MB2619305C4B4123F8F42BE48FE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-3-WenYou.Yang@amd.com>
In-Reply-To: <20230322091607.1609145-3-WenYou.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T07:17:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=16eb569f-dddd-48d8-a480-f3fb1b9e3dd9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH3PR12MB7497:EE_
x-ms-office365-filtering-correlation-id: d6b9223b-8bb2-42b6-14f9-08db2b6ea25a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYTSuZGe97qxDOm75rMHc3laD7lIeCyRt5ynDS+tCwJoFTsNeqIpDqJkYgcTgQGoQzdrNBe3XCNCdecuykelm8J2HG4GjjRmif6+zwmJ3EQCpKUFgdaVgrxB9azQkYqlmchzECZqV1Vcdy0/HNNw5Ny2/a/JPzrb/fdpyiNZnkgE7jltWs/ypRGw+zK+W5UTrEh6eg96IN1jaRq96xRDooApw42eARe2QejkidfHTBR8F5I82mZAlnKfkQtQ87o9ekgHenE1zFImkHdjnT7r88du0mRL0yCbandhRsqStnWfqH6+0Dvvjbtz4d3qTEOYK1RIgKgQh5Gkzyz/iLDNjDuiY19VlHkpqgVUg2YPjvyy8zcKdj5diYeVDLgBDD3Pm18bpfJ7o1NTexMJUgCaHdtXUBaoDHP9L86gpuT5uGF/iFCXTd96J7yFgXM9HCC3klLSuwcvUsQPyTwols+eNurOTESWmUZywVuPoyd+7aleyDXq8AvRWEk01+pr9Otz2RTOfgSy7IPVBGhBMd30364XHWVWjAlpDfvl02r0WnGAqQFZu7FeU8ktQsP0bpZYz+r3AAoR4rlmrq4KxGq8bKx2EU07/H/rsAX7SCQZH8yJKoqjY300Ss9L/6XftrB73tawoJ+WwQwTJmGrl2hoOBCiG7NDciGAJV2G6QCTFXECP6no0/nUowgtktPfZrc2xtmxi1fXSWYXbLMtRtabVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199018)(86362001)(55016003)(33656002)(478600001)(66556008)(71200400001)(316002)(76116006)(4326008)(52536014)(6636002)(66446008)(64756008)(8676002)(9686003)(54906003)(66946007)(186003)(66476007)(26005)(110136005)(53546011)(6506007)(83380400001)(38100700002)(38070700005)(7696005)(41300700001)(8936002)(5660300002)(15650500001)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dMpNpx7nSED+cUN8hAlUR8LymYkgmsFM26iEV9/lro4ZoqRGoS5SzLNIgL7x?=
 =?us-ascii?Q?LyYhlSNP35rlxWwIQshhZECn/YJ4h7M6zcvVNNizeT63maE3tZhKuO1fb3fW?=
 =?us-ascii?Q?xf6BnMFhpj9cpV29mcsNc22a7RgTT+oKMdkPp3Et8U5H38ORCKMSQw+9aSto?=
 =?us-ascii?Q?bgOaspcpYZK1zolnvaJKmHLfSUDQEG389berfTmurOvM/BQyFmgj/3i4cqWQ?=
 =?us-ascii?Q?45tYNK2BGnoX0880hifj7yAXogSy/+u9QmSVCxYCTuLecj8yXCLFI4Rnv9rA?=
 =?us-ascii?Q?1lr/Aogs3EIxmuZZzwDCw4FW6DPDLym0RpzEg4uSUpJ4F1SiGZeyVm4elEOH?=
 =?us-ascii?Q?qG/ORxdq/Pfsh1ZVgKhf1w9upoQv0n+VuDcV+M+DNhcKSzlvWnu6BnitaDqd?=
 =?us-ascii?Q?HH+4aYG4ZrexV99Pz5WSilxK+d4/Ncvsw+VvCJafxxdJhxhRVvWKSCW3a9nm?=
 =?us-ascii?Q?gtbmoXVVUtOVJIAv2EnHp7PUlcYFhjzaGqagelHmPqpI/o9g/NRlkFU41CcS?=
 =?us-ascii?Q?qiAQGL6kdIMLfZpXYWeDycY+U3uN4Os2l+QsG2cP5u++16VjH8CHiBoXzWka?=
 =?us-ascii?Q?oV58EOlb4DvJcjbbxMOv/Ab0t5bCELjjH+QGM9U1lIXroRoTAmijkCLGrLkp?=
 =?us-ascii?Q?0rZJAopX5tffhgEDAJnBkFcFesIB/wxPyixp5I6yHykKVq0JTE3Yg2mMa3rI?=
 =?us-ascii?Q?na/K2ikpQnar6mFnilA0JuXOIGYetyP2QhPo2uVY/wojRJBgtmoK6L6mKa5P?=
 =?us-ascii?Q?6Y0AT+sTHCGX+FuLFovyaZJC4NBETtLY+a1tqlj8JFzMWLJQtz9WvO9eWFoe?=
 =?us-ascii?Q?9jrup2Ta4diHpaJcLml49b8V1EN5BbVQ/V78N196UWfgInPgdWKHaLIyDWHT?=
 =?us-ascii?Q?sMAcazJvlAzw/0+eTWHaSZcb+p0qY+snwy7e953aamZYw89T+b5z+PVei5P0?=
 =?us-ascii?Q?gSmeMYax5VyyTlrf2uefEs59vsr52HULm+RsfbmYpgurX4/Q9xwoTwhHlqkM?=
 =?us-ascii?Q?NgmxJGByP4tEac4qRGdQ7LH28DS0OvHz4JRMzAV0izs66LY2cyzfLrRBaEF+?=
 =?us-ascii?Q?RskkabTByO4ulahuUSuiIyOxdEemPzNUuq0ZxV+iq99ARbNO4G8vwRUYg8+X?=
 =?us-ascii?Q?PyjUTmpOYTPg1u72NqcoTutS6DBUY+cocHXvvi2+6J40Xd8VOwDa16st/G8u?=
 =?us-ascii?Q?CtpC1vsPAtldgsRxgNTnbVjMvb5j6TaIv0CKzUGQrgUOqkI6ng40c/TuIXfS?=
 =?us-ascii?Q?aetxJsKKpTlViqT2LTmOjw7DMLr6GF2e8Ma5z3EbDq0xP9fRKl0Zg5TuRuv3?=
 =?us-ascii?Q?6znDTh/CYHLSPgEab2SHWOCqOp57IUiTK5lgW9NxjGG2r1G69Qtds0ZYaRvI?=
 =?us-ascii?Q?WuG0QN5gXUKwJ29hJ9qGAo5OQfPEzb32kcZkluZcMNgTp/gnyeBYmVLZn7HZ?=
 =?us-ascii?Q?RK0cXDtEb3lbQZkX9B5sCKakIP7KNXEHKFqx1HrppDv8/sQqduq/mj2/6mFR?=
 =?us-ascii?Q?OI21h8W1GFitLL0dpBkoDsCLL47L0I0dvEMc8LgOpdQw0unT2J3vlJKV166z?=
 =?us-ascii?Q?AYeHJB/hcsVRLLLmrSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b9223b-8bb2-42b6-14f9-08db2b6ea25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:17:17.2954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfko2NNVFVVDqRaNwfwz5QOh7DKPSboaDXkMTGCPeydKqA3rwFdI+qPQrflbIALU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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
Cc: "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang, 
 WenYou" <WenYou.Yang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Wenyou Yang
> Sent: Wednesday, March 22, 2023 5:16 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Li, Ying <YING.LI@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, WenYou <WenYou.Yang@amd.com>; Liu,
> Kun <Kun.Liu2@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>
> Subject: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable
> message to pmfw
>=20
> When the CPU SMT status change in the fly, sent the SMT-enable
> message to pmfw to notify it that the SMT status changed.
>=20
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..5cd85a9d149d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -22,6 +22,7 @@
>=20
>  #define SWSMU_CODE_LAYER_L1
>=20
> +#include <linux/cpu.h>
>  #include <linux/firmware.h>
>  #include <linux/pci.h>
>=20
> @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle,
> uint32_t speed);
>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>  static int smu_set_mp1_state(void *handle, enum pp_mp1_state
> mp1_state);
>=20
> +static int smt_notifier_callback(struct notifier_block *nb, unsigned lon=
g
> action, void *data);
> +
> +extern struct raw_notifier_head smt_notifier_head;
> +
> +static struct notifier_block smt_notifier =3D {
> +	.notifier_call =3D smt_notifier_callback,
> +};
By embedding smt_notifier into "struct smu_context" structure, you do not n=
eed this smt_notifer and current_smu below.
You can refer to omap_dma_busy_notifier().

BR
Evan
> +
>  static int smu_sys_get_pp_feature_mask(void *handle,
>  				       char *buf)
>  {
> @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device
> *adev)
>  	return 0;
>  }
>=20
> +static struct smu_context *current_smu;
> +
>  static int smu_early_init(void *handle)
>  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -645,6 +656,7 @@ static int smu_early_init(void *handle)
>  	mutex_init(&smu->message_lock);
>=20
>  	adev->powerplay.pp_handle =3D smu;
> +	current_smu =3D smu;
>  	adev->powerplay.pp_funcs =3D &swsmu_pm_funcs;
>=20
>  	r =3D smu_set_funcs(adev);
> @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
>  	if (!smu->ppt_funcs->get_fan_control_mode)
>  		smu->adev->pm.no_fan =3D true;
>=20
> +	raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
> +
>  	return 0;
>  }
>=20
> @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
>=20
>  	smu_fini_microcode(smu);
>=20
> +	raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
> +
>  	return 0;
>  }
>=20
> @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct
> smu_context *smu, uint32_t size)
>=20
>  	return ret;
>  }
> +
> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	int ret =3D -EINVAL;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
> +		ret =3D smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
> +
> +	return ret;
> +}
> +
> +static int smt_notifier_callback(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct smu_context *smu =3D current_smu;
> +	int ret =3D NOTIFY_OK;
> +
> +	ret =3D (action =3D=3D SMT_ENABLED) ?
> +				smu_set_cpu_smt_enable(smu, true) :
> +				smu_set_cpu_smt_enable(smu, false);
> +	if (ret)
> +		ret =3D NOTIFY_BAD;
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 09469c750a96..7c6594bba796 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1354,6 +1354,11 @@ struct pptable_funcs {
>  	 * @init_pptable_microcode: Prepare the pptable microcode to
> upload via PSP
>  	 */
>  	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @set_cpu_smt_enable: Set the CPU SMT status
> +	 */
> +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
>  };
>=20
>  typedef enum {
> --
> 2.39.2
