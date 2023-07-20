Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC07EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 07:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6956F10E56C;
	Thu, 20 Jul 2023 07:35:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B9910E56C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 07:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqhWBqEf4QAmi0j88FcYop4vX19XEvzRGybOVLxKE6bkXh8RaRz2NPwFNsLx+Q/EHEU26GrjNORL5bt7kmaznP2nCNukGcaLMNJQtSNxulAvy2kO59aXweKG9Y2NU85fKknP6OgVY0PK/z7tVhCKrbKboKy7wasQtBky+PQEcSisHBTk93GP4jbWWeKUtOzjZjlo0abOQ5TsCKmf3ZRY2RiKmohVemUEdNo0o7TzdQJFAp6yLSRHp1MFhhXtF/iUiGDzcKurtPZCzwtSCetvr0pKyPhAcNXpSUaeaChlbFyml93oh5ceTjCs2Xs3HuVoC3LDkjayPwNCv+28lVlQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SmL9ZhbEi8ed8NuL/32IHX9hR3cX7wa8eRgD5jzla0=;
 b=YdMH8MDJlxu24AYKK2owV2hTCk3O0mcQI/ZZOJymtU2fzSQnYz/9ic76Dml769o3QOU1ummBz0GZRkG8nuqDrGv5wStAPlCfGBIk5z1PnPCzl/crI7Vn6/Q9MBWKfteg7zFKxk3XN8px+cdpvWWcsx3KDqsni0/EjodcWyDNcUnULUof+1ZcdsHxa0iFhBaCijWbZDLn35HEdwjQvwA3obhrFyhbqMgC0T1fOO1i+XoKHc0J4qq5y52+d9/RY7kppHFYJtx6pNolq6LT2pRy2G1TAy7mF+egyASMzpsn5whTT36lbpK2GS2r7gLe81QQDUoAmyqGA+Vj8tYbZAlK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SmL9ZhbEi8ed8NuL/32IHX9hR3cX7wa8eRgD5jzla0=;
 b=NsHVaUR3C0uYDAMPig5P1buI2s0Rl8kn3yExDAXplBXx9vtXtqcfDz8vgyrz/jIhQLumGIvLYM930cEfuo8Aqm+8He0M8s1aYHvUczk9A4/YRy367C95qd/Pn/qS0eVpvqT7R0NiECAymdCkpR82wroakQAWJrHOpPZvXGGF/co=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:312::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 07:35:01 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::761d:1336:8dcc:b54a]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::761d:1336:8dcc:b54a%6]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 07:35:01 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: add ta initialization failure check
 condition
Thread-Topic: [PATCH 1/2] drm/amdgpu: add ta initialization failure check
 condition
Thread-Index: AQHZuj4+bxGIfYuGi0S1HtBF50P9bq/CRIig
Date: Thu, 20 Jul 2023 07:35:00 +0000
Message-ID: <PH7PR12MB87969DAD2E4E4AD5D76F94DBB03EA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230719123956.1163008-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230719123956.1163008-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4908c7d3-210a-4cd5-89e3-631aab2f184d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-20T07:33:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA3PR12MB8802:EE_
x-ms-office365-filtering-correlation-id: 08a002cc-5782-4585-5bd1-08db88f3d373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIfNq7rnrRIVGEMFFCfABcJgjnNrYqK6nHmDQaDif4sRB1vC8sAZE9tHVhxoafCeC7rcZv1pZDL7uNp+Nl0MS3YFAO2RQ10GSNlyN6qyZZ5Kafg6YT49UlVvnYRwqy7jYjwx4HyIRBs2IDqJoqFO5zMN7kKc5bclCDWhY9/8ltnthVQaN1m9Q6oKibP2qIYjY/SJRu3jgVwqf1zWKP7I0DjGfik0caw4L6nUOVxYW63kK9T2jKftMFwn3sP72fxx85M1orwtPo6GfEwWPOUT4Xn2LkFeefsmGmA2/vp4wqRqflcRCGzOFMEQc9LCA5fsu/mieuWcY3v9pHLDkbNnf+K82YAKUBqExssEhQpo7wrrD8hRUsnA4BzLPfQNExs8D9Yyj0eTZiqWJxV0cEeoxKRhz/Rf8XyUdbONhAldnTnrhhTMXX358DkNSDCTjYYvObWUoWeCS7fLuTcYbVen5W20D9zMwfhvYWTLakO+tRYlbZcO4UG6RGu8gpvG9ZXhCYXVS6DSjI+EzmN4xNc43BPepfUce7v1KJwFDFaXB8bJ6HyaN51kGlXewFSeaA5TL6srGFjZAf3znYykkf6cbo8IA5GtxtGh2Mz7XMKnjP13ir+pmCj6D4gfT73hTNOI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002)(55016003)(4326008)(316002)(71200400001)(76116006)(66946007)(64756008)(66446008)(66556008)(66476007)(26005)(186003)(6506007)(53546011)(41300700001)(110136005)(478600001)(7696005)(9686003)(54906003)(52536014)(8936002)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LgD21tVYj16Fc7kzsr6EusY+evtI7rtKo/nDOOi3CwMp8LNRn1rxV3JZvDXD?=
 =?us-ascii?Q?/nkd1uHhfuydmIp6Rvr5OVEEArnQPtoS+nSCsIVhu8pwgbwucdcLASHXYx/f?=
 =?us-ascii?Q?omwInzupCFxB0mlfwd4NJFOGP/RshIxTAzMktNWzsl+Fch5QCgf3kYV5/vVu?=
 =?us-ascii?Q?aaSI9/yZml4K6/1of4DNJdO+rCryTkve2r2bMpXLTp5LqtWSbU/WgDMAGlrX?=
 =?us-ascii?Q?TW+m0amjgkHpxu86EqHGhmMx2CbK+cl4Ca0PPDRXeGLnc3pVTjGthKbRT4l0?=
 =?us-ascii?Q?DAjK89+hlJtLvC86pnP/haKZttKfKrN00JhdeSTkoEPN5fLArGKkIbxB1anz?=
 =?us-ascii?Q?7MqmdBxzoygNgqV9h6n2EEeADip+d2EFnlze/XgVQ7SMQCtxu4saKGyZFy8e?=
 =?us-ascii?Q?/3BfUm0qqNJGU3tbGN6R5KxrEMfW5CAWN97C7ecy8Ai2ZUF8zwBoql4vDMA1?=
 =?us-ascii?Q?F/cdoAV7XCR7P1SK/B96Wfw5hTtxXukZy5SEPZ0CDd7N0ZrjTRyksEtNLHLF?=
 =?us-ascii?Q?BPzWfhKJzDvSD25GUoFQcMsFYWwpq4aYPpbnhPioxCwyVD34/eAIlym320zt?=
 =?us-ascii?Q?Y8iKwmXPbEJ+eAX3Zs4ms6TJdtahQ8mdeEm+OoGHjy03884tDGSos/YrwoMN?=
 =?us-ascii?Q?VdKYu0gwR+e+Gpwe6ixM4n2bVhMUvgFCBG9svfu9+4c59C2iXGyQY8M1EsLY?=
 =?us-ascii?Q?Q8bUkpjhb1Dm3lfotjX361zrvT2PJCRlU70n1cUlOAQab7LGuIEhzZTq8HGo?=
 =?us-ascii?Q?BKnpc1q9ZoTyYXtBcUYuWu0WwKgQrxSpyTA3zS/JW4ztggTGPFxiIWlgJo3d?=
 =?us-ascii?Q?03mVciQjMqG+YoceHBhPApULOt7rgHpvTRDjdyZERgCJCZADE67sIZ/MzD83?=
 =?us-ascii?Q?JaDmqIN++PZlDf79Pb5IGWnkp8/rwvRtyTE5qz2EAItpK0KXN4srhdZQ+yYY?=
 =?us-ascii?Q?IGcyAZ355cq6WbWJ5pPrY19hRTEF/ArzoIqVUqjowjxq6JwBapsQJSuAz9+n?=
 =?us-ascii?Q?rLjYhFHXeuWVeIfOCPRF8K+MyOePH5AD9dupEabtY7u382XSIzk+fxClz6lk?=
 =?us-ascii?Q?v0SQhY4uVl5gxJFz+i+dE6DdQ9li8HJ0b3YIM7lFQp4bRlvVlTJ12E1i1ycF?=
 =?us-ascii?Q?SHFwUn6oxpJs83nNA7AmWS+SAhbn2G7s/1tzFwSUiWR8f0wVYtqYEAIShHE5?=
 =?us-ascii?Q?14pSATUhURtwb7LGHBShQNQI3EsVsBqdQA265H2kdNGdDrBcTaF5PIjEfU8U?=
 =?us-ascii?Q?oBwLINak0XX9ZAs5E72w2wAfiw83ems3OT7mS6BvDUoySUVcaADq5CmPkXrD?=
 =?us-ascii?Q?Bxy/hmJQ2Y99MSeTlT1T0YR/mBaSQyv5boFdDIdZxxqj4GPUX1c3iWcrj/QO?=
 =?us-ascii?Q?LuvqxIorK4u4X6KTGztQEPxU7VBnLkY5BIMNdBPvZjSqL3ZySZJgVUi2cTui?=
 =?us-ascii?Q?MDixprX5S5KuKBcdd1jIwlopV27AWBJRpL7QcRFc9JZBHqCgXLRanBNqSYoS?=
 =?us-ascii?Q?1enu5gplAR7p70PwOs9s4m/34y5fHA6YOQ3aOd3zYWa6n++EfzdYvfKxgHZb?=
 =?us-ascii?Q?hg7C7m8yCt3MsL0N0k4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a002cc-5782-4585-5bd1-08db88f3d373
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 07:35:00.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9bKQUzn+X60uzL8/Wg6mBMRAsIYivxob4XL7Hv1U/xIbDA9sMgNoip6fC2F3vUg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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
> Sent: Wednesday, July 19, 2023 8:40 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add ta initialization failure check cond=
ition
>
> Add ta initialization failure check condition.

[Tao] better to say "Add condition check for ta initialization failure"

>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index 468a67b302d4..049d34fd5ba0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -220,7 +220,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *=
fp,
> const char *buf, size_t
>       }
>
>       ret =3D psp_fn_ta_initialize(psp);
> -     if (ret || context->resp_status) {
> +     if (ret || context->resp_status || !context->initialized) {
>               dev_err(adev->dev, "Failed to load TA via debugfs (%d) and =
status
> (0x%X)\n",
>                       ret, context->resp_status);
>               if (!ret)
> --
> 2.34.1

