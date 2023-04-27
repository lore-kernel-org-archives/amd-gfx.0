Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E084DC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 12:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7229E10EB3E;
	Thu, 27 Apr 2023 12:46:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D97C10EB3E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 12:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHyNldhBvT8qay3qDzN1BMSRpzSAJWRrMGJFsLpIwCJ8IGuv09hS2ryRRPNO88hRFrrI9yeF3vLafo2YYyV0eIVXNYa2E3SwH7epfhTx+UHGHzwlwsd4cIs5GqGxHbGdPV+ASAABGoXhJhDk4Scg994K8VcNN9MMaiRjQipjV8QeYEpMr9fhxWTDF3No1ggVzTRCcWG/tJXCcAMwCa5aWrnoeSR9mqZYYv920Col2LXOaxJjyELWNZS0cjpv5U1mKmtXVBuaMDR+3c/jgqzJ+qBbl9jwVKdrIG0HJO7rnMBpIJjyuzITgAk07sjfoBkPg9pt2mjzLLfWlovbefUN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKMBprkf/2dfuq0HTkEyWzWA1GjkYr2C8rluvrIgcIg=;
 b=hP3Ds5H3ABaxeB4aKXdywkVpkksLkRKLfzLwCSF9HVqzNqlaJLvNZDCmCPQLqBggAwkn0gVhqPbQsn6WyfYPUjlAkP7FMhnImdG+90yu5t546+tdg9EEe0IWJdrgvFSH2fqyWrzwylvMigG1/EVb2e7IvjDiUoPe192K8TktvJvOMefCBAwRye8tljJAf1xGmy/xdkHqeffg5UNDv9o2b/A3ZNnLSynlACPH8ufuksFUOueMkhm4ghi7uMnmiviHxTolkDUjVr7Wo5Z9jnbV71dpJhF7bjoWZrVcsDolQiA4VQXwjmhzg28CF6Vi3pnFvw5w+YB67hg+If7yHN9TXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKMBprkf/2dfuq0HTkEyWzWA1GjkYr2C8rluvrIgcIg=;
 b=HDqUpVWBvfrPcGMvZfOnLJ1eLUfvaOjr7uQoxaNQt8XJP714m6VV6xeeglACUcCBPg5Ku1ZgsLaj1508D3VvDCUp7hRn6c7N7bxuCGEYVQnYftG2juQNT7obRCv73V4MK9rVG7XJidLxi3/dTheTlHFCbADghTwe8AhXL/b4G6s=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 12:46:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 12:46:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable SDMA WPTR_POLL_ENABLE for SR-IOV
Thread-Topic: [PATCH] drm/amdgpu: disable SDMA WPTR_POLL_ENABLE for SR-IOV
Thread-Index: AQHZeNDkXQ5LmsbRXkeoqsjOK1xYta8/Gsyw
Date: Thu, 27 Apr 2023 12:46:33 +0000
Message-ID: <BL1PR12MB51442069D0FA800A820C4BA5F76A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230427062400.14032-1-horace.chen@amd.com>
In-Reply-To: <20230427062400.14032-1-horace.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-27T12:46:32Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7a865005-559a-4458-9946-dac75770e14d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-27T12:46:32Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c9eeb42d-cab9-45e6-b9f7-a2ef0c70c1c2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV2PR12MB5846:EE_
x-ms-office365-filtering-correlation-id: 0e03a3f0-97ca-449a-e701-08db471d6e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYGPxZd+q9jnk90P1nSiU4p/xcxQNND1VdpDqTVSj9fuvJvT0YSPoUBg+8+YGORaX75oL+F2sy24GpgjPnmYTW+AwGqtqKwtx3iBttdbH/GzrvdJCkIEwPZPz5o7WxYeHrg1sUgDzYYXxeozYG3RQ8CuXnu387wc3Oqosi6mLKbqnlwT+fX9BqTuRR3LYUhUMro3SgYlC9ZS3pZfqN3of9FlOqBvHQP/bXoAmD1zXMNuwyYLIxfk4tLxS3IyazIaN4NPv97aBVAZIrhD88r6A6zSh/1JJMLS/3x+6fN0487rGrjfDd577yW/8hvd9gpgrUj7py/g3lsxW6IzlyQuSb1oGQSGNUCvJoAmojp36OKQzaQ5nU68gHz8jkzgosQCEjxlbPOPW7Ndvixh+GbrpJk2H7X7Kske9lvOy/iA6aFTFi2Zj8+88Rhl17zJPvY5mlOEm+2J6nuek2Oxz3YKi2PJcdR7Da0gIY0FWFqKBvcbGUbDQuNjBd1Z9sy4D9/pcvui7yjyTZHeLE3eglrrZ1cjZw1Ozrw0/BDvoyIByAq6sc6ixDF3/zFjbdlyuQucfd6K0CWd6ZDyJ1CfQ2eB2koG6uaKHDpu06aiPxAHvts=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(2906002)(54906003)(110136005)(316002)(38100700002)(83380400001)(122000001)(38070700005)(33656002)(71200400001)(8936002)(5660300002)(7696005)(8676002)(6506007)(478600001)(86362001)(53546011)(9686003)(26005)(52536014)(55016003)(41300700001)(186003)(66476007)(66446008)(4326008)(66556008)(64756008)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kp9BkDELdndRE/xMGon5Ovl2GWBAhJdX91QwBsLTOXH3mU/xAiH5nXtLzeLV?=
 =?us-ascii?Q?wfi3J+xTkywhXcHGTkBLquG4CxnNDXlSiC8jpa1WJH0ZwaLzx958cChZz/xf?=
 =?us-ascii?Q?z/iT7CrTgXA2AYjdvXADgHRhkKJ/HIamshQ0XUaQ+me7DfK89Zs3dt08R8Lk?=
 =?us-ascii?Q?p8u8S7R86Xni40eQHoCESWQnrkMSLgcdtH+IieLGD11p3ebyD4EpgjY06k8h?=
 =?us-ascii?Q?LqQMx0/sZYhaWwNmg3JjEn5laX46TnSSuNzM+0gJj01cF4Lk+g7PQP34/1Pl?=
 =?us-ascii?Q?G8FQ2JAFgeLiP/ZnU3/pjqXnCsGYauPDKxaj/yVugX8Q26V1jXEJAMc9JAi2?=
 =?us-ascii?Q?uelgXnRWNrf8u8axt4QDunTzDnjK2IYTq6By2rgKmqdhUq1HVyjU3BdId0PP?=
 =?us-ascii?Q?gOXcY2Edf8OLiopbiDC/0NLTEAiu8HHFS3joWuYTp8kkg1qSRHUoKvhhqFOv?=
 =?us-ascii?Q?jJ2wJVVx9egPDRNmCFS4yBhdMy0rPuyJNelosPpoFbNaSSkR5dOlF9CG9MbA?=
 =?us-ascii?Q?YPH1J0HHYyKaXGG5l+cbRADzhEIt/hO9GgGddArJtLsGMrApqIihsMJMIKE6?=
 =?us-ascii?Q?GtW3/eMLVouwxPPD88urngZdDWO+59Ywx8OOxf1yvZL+RysRGa1du5cEd9Km?=
 =?us-ascii?Q?T5Ai/Hk0eGCoBO/hinWU9jkSEtBWfzd2LnyeArubx5ka6cu3jbCPtCHbnyaj?=
 =?us-ascii?Q?MLVr8LwNwri31DOqxF7SMsrE2Y1u1tl41bS9vm6bEPC4ELOneskwtPlyhZmr?=
 =?us-ascii?Q?RJJ0PZg/H0v9fIW29BN7eOKTk6wgH4uBncKm+VePApymcSoQeJVhA19k4y1i?=
 =?us-ascii?Q?Yiq+G7Xx8cPUpAbNlwDoyoPEWkI6an3mCmf5bx/VCbH++Roa7oqxSqfd4Fv0?=
 =?us-ascii?Q?tWjNAbpy6vp+L6yjqnDZdFX2f1fbwdm9X35Xg8yxGhGVR+T1BqWYC+q8IC2u?=
 =?us-ascii?Q?s2a8AxS+Jw4JI5KPyi39EiVoy5gSaNB9b9Gq4HKQP0Ly8G8s1oCfuDj4tOoL?=
 =?us-ascii?Q?gXJhz6saGmXsFfkL2ZAQbhssTXLd8JulXEdEeT0qTSv4M23ND42vpCOqwIEc?=
 =?us-ascii?Q?AGRbyuOBChmmqEsDnBZRVkSaNgzqHx+2PJAKj50zNym+sCEU5PteOZDNNoCY?=
 =?us-ascii?Q?MiEnCNecZZ6SIFVejNIPS7WyKkzb2pXW5LIiTTbY8z+56BnOdLgyOmCIzah7?=
 =?us-ascii?Q?lPKjXjvC1DE6A5aGxFbK/QpQnRHCKIFX6iQ596bj1PQB/GU0LAzFHxwyJRTt?=
 =?us-ascii?Q?3SrjnBpQ53WfS/dMclTLs4vHP9C6i4SvQRJQ1NrfpeepyG1PrAr4eg8FCVyc?=
 =?us-ascii?Q?BoRsedGhJ670Mmx3QUFJQUJoFzS5SHVdZ6grgmUjN6EX2BPgsxVecak1z7Cx?=
 =?us-ascii?Q?8sqlfDlXSC4jCrUzgsOiTGNMc2nkZW0xgaOdk2odS5oYV/jYrzJSRWU/T5h+?=
 =?us-ascii?Q?JSk3zyk8zawBTbf6sKN3VZiQbKQHYj4Qc2M8hKLSOAW4Jp8FIscoWD6FjYBB?=
 =?us-ascii?Q?IeFlsIntK6pK1/RDCJKgQlDi3CT31MdRBdssHY/HjAEQS0S63YyJu+rrFBhN?=
 =?us-ascii?Q?tGBK3hXCfd4UaqduO2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e03a3f0-97ca-449a-e701-08db471d6e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 12:46:33.7861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: On2w0hfD652vFDECiVKbAQnu3/EBCgADdGWW5WHvIPn24ebXISk1KZKacLO/LWdNDqeXiYqW133VarsbVe84bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Horace Chen <horace.chen@amd.com>
> Sent: Thursday, April 27, 2023 2:24 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>;
> Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>
> Subject: [PATCH] drm/amdgpu: disable SDMA WPTR_POLL_ENABLE for SR-
> IOV
>=20
> [Why]
> This WPTR_POLL_ENABLE is a hardware contigious polling which will cause
> FCLK and UCLK to keep on a high level.
> Mostly its case can be covered by F32_WPTR_POLL_ENABLE which polls by
> firmware.
> So to save power, SR-IOV also needs to disable this bit
>=20
> Signed-off-by: Horace Chen <horace.chen@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index eb722830531f..3d9a80511a45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -510,10 +510,7 @@ static int sdma_v6_0_gfx_resume(struct
> amdgpu_device *adev)
>  		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
>=20
>  		rb_cntl =3D REG_SET_FIELD(rb_cntl,
> SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
> -		if (amdgpu_sriov_vf(adev))
> -			rb_cntl =3D REG_SET_FIELD(rb_cntl,
> SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
> -		else
> -			rb_cntl =3D REG_SET_FIELD(rb_cntl,
> SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
> +		rb_cntl =3D REG_SET_FIELD(rb_cntl,
> SDMA0_QUEUE0_RB_CNTL,
> +WPTR_POLL_ENABLE, 0);
>  		rb_cntl =3D REG_SET_FIELD(rb_cntl,
> SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
>=20
>  		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i,
> regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
> --
> 2.34.1
