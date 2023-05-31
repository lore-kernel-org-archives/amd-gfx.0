Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EA7C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 01:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA7F10E444;
	Wed, 31 May 2023 01:12:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59AF010E444
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 01:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nipWJNz8my0zBA2dcyDQutdWG7hi6NZ93tff4zyOH+rj6E8hsc0M5x2+TAbh/0smGX3jbeAcBEPAd+GeFhDbjjv7vxB5pXgUI+7bNMuXMCTGmRkBSZxkdwwfZE9q0LzBclFRaZPPjnRCv+HZK/HdEXivh2hS9kzP52DuZhtG448z1opvc+M30PdWfaffgx2xykDjTBVtMHeGUwgXn5Ee0gMawJJS9EQkxIxjukQIXfLU3AnLgjxlaz94BON3L79JABlc2VzyADDl1eW5Swzs0CME4/UbkoN0VuayJSyXHQLZDgCr5u43aiIgLea8rej9ibmXPxfHWnNq/EHRZfdENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsohUYC7NOoeoNZF2Bun5zDG9ODbzDMKWiBFlpzDT80=;
 b=d26U0jA2TP54FOXS21GKpkB1JwIFePmWdZSKSAoBGvnlUq2g+Zi08gY+K/2BGrYYSFNBkj5DUYhUoHn9CjrhQ6Rn+HQ4rqPo9OjxFVeTcAg3SPg1M9ETOCsIJZfkJjp/H/u7jDW9wSFnZrO+4vebJXTHoz4kRrvwI95fRqLH/rYjBCQZ7j9WP96NGxbQD6/SB6qDLLZMqENEio71wGUj6FUEC5DT7YQ1CDdaKd0SqLL0ziIjUc/3id6v3hyxHWKt93sx6j+IaBReGpHmip2l4D0AUSA+4aHw9/Owm0M9C9mF8FgvkbD7kf//YKgSvr9tHpAVOKDbVMWKrNIiCOVDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsohUYC7NOoeoNZF2Bun5zDG9ODbzDMKWiBFlpzDT80=;
 b=Q8BVSV4wVFZh7bcyFW1bsPsgbsURBRhEm/26DiXu60GcP5EyWdpQSfrlqPPZsCXGzdVSat4sqEIEI3+8/CIeeyOVwdzmS57XOl2cgf/ztPEkOrYAN+/xUefP279LIz09IVLLp4vLf6/KKQnUekv59VIszQCSxBg17Y7hPcBTf+8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Wed, 31 May 2023 01:12:29 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 01:12:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhu, James" <James.Zhu@amd.com>
Subject: RE: [PATCH] drm/amdxcp: fix Makefile to build amdxcp module
Thread-Topic: [PATCH] drm/amdxcp: fix Makefile to build amdxcp module
Thread-Index: AQHZktxvrb/lpSQCoUuIp1U0yq+u/a9zlB1g
Date: Wed, 31 May 2023 01:12:29 +0000
Message-ID: <DM5PR12MB2469002178FF6E5DEFE5329EF1489@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230530095218.418845-1-bob.zhou@amd.com>
In-Reply-To: <20230530095218.418845-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a459152f-741f-444b-8faa-01a7f52d0820;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-31T01:12:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CH2PR12MB5017:EE_
x-ms-office365-filtering-correlation-id: 459a1b68-bf7e-4cd2-4644-08db61741a84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qJ1SOgjUJKlkuTBf9oi0n2RVolUxh8OySIHf3b8km4kGVWRpb/fRwbOTZgPD4s05S+WIUjVbzsQ8YTiV89m8KkcfoC7xm408WViKwMt/9vZDvqr1lqwgV7bL6heXh7q7fmTyWaIPJyLW0qNv3tKb5fUzmnKmGZK7zvEuFHnWuP6VghkLd2HSYUzbhQkVyXDfOBeqOmfp12gnV3jlPMVa0oOiGTC/5vAzAcfr1staNrIXTtIA7sBD6/mprDAo9BOMdqXf/pKlUl4vr8OdiVhQ+7OI3mPgAjNgnn1kaSccaZjdxCEfAqV92kbAGHv/qQqjV3paZjW8jaKO36tKERmuKaQcxTZ0Yhj2xhXbSge5OJtO4bCC1uvJbu+n16WtomH15ee8OJ/ExTBHFZK9+pYj0alyGxBIShQCsJKJWSswX4c0jwNk8b2FWr0o7lhcU46uxna5O1ncTpo+sh5UXDF0aIt71H2rtnd3/zKZG7iox/GzMQPEqtjVtOi7KJ+saLc+2mcjTKfpgjy0+jU1AsaBQx6WgfrXJjQ07KI/3UW/2zwU8QwQ9tG+nDRMAlGpyfT1v4+fi1AjKM89sYtGTqDQlseUVGHOhFyKHKf9rsgr/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(54906003)(66899021)(71200400001)(478600001)(110136005)(66476007)(8936002)(8676002)(5660300002)(52536014)(2906002)(33656002)(86362001)(38070700005)(4326008)(66946007)(122000001)(66446008)(6636002)(76116006)(64756008)(66556008)(316002)(55016003)(38100700002)(41300700001)(186003)(26005)(9686003)(53546011)(6506007)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fltDSCwqCMFGWx5/xJZ5x6qokmd5T0hNsuD2XBqbet6c1Cgk09sZgJgh3bDS?=
 =?us-ascii?Q?ByUCI9Xb6YmXAaxQ1VnxHZuql5wBvLZgaNaK8/eYdFdc3YAKibk4fyp9NZxD?=
 =?us-ascii?Q?W3RmxSoKZ3/izPcBAT6Gry4FYrCOZ19zPW4zrQuzcVEGz6d420aIVO/Ov9aB?=
 =?us-ascii?Q?5WN1Qf873Vb1RM91rwIYQ3InBKwKNtvAZmB9K2IzQp4YPRvNFEvRQjwHKrp1?=
 =?us-ascii?Q?CmTlXh/7b68Kc4+0wyTQuR/g5sYOQS7lDWCVUD0WY/Q3DiFP0jbPaMcdfRmv?=
 =?us-ascii?Q?f8t+LdrnJ8VYLD2OWA7hbkpaT/PPHf1eNPdKt0it/wasqYX1TJXACdsOliA5?=
 =?us-ascii?Q?Sib23fHp5KjxVqNaHQpUtTIoB9W0RT/M3sTspe0UkLGqLGI8Re+1V7mGk/XU?=
 =?us-ascii?Q?LlNOyOtaEbwZo01G+WUZIvK7ZhxowRa1N4cpifWG8oCw6fa9qXaSLUp59NkY?=
 =?us-ascii?Q?2MjBx7e73qQFKjzM98iPgLCEL+KObrwwMkAMJEcYC7cuGMoLcAJp10YW72bp?=
 =?us-ascii?Q?3n4mPWyfAnDb7CTeCuVjrlcHq9DMgfrJ4R/R0LReXglF81AlRPfxll6nrPjA?=
 =?us-ascii?Q?pwuk98gn1rW+BgI2u0hUPQq124WqhIjJNUSWTrXW9F90X5QS5ELM5WIFpM9k?=
 =?us-ascii?Q?5vz3JP6v8ZuhxxopOM32Bq479jaTbLsjdwdfV9UB8j6l2cziRy1yQgpn4Qz8?=
 =?us-ascii?Q?1GngzaYjxCCjTygHWf7tuLyocGB+JWwgCcRvm2toEz71QH3TYoovjQ1X6Adq?=
 =?us-ascii?Q?vhXJ75VFBK7X6xMg9M4+6oz9l7bWaz6JzgTcuGDlngq9fGfrT6SsHMpUpjo2?=
 =?us-ascii?Q?aVfsyaLT3Ufef2ZievbIqXQDOkLKALLXYdE/ExjPH6Zqr+CvBX0v7DJoO2am?=
 =?us-ascii?Q?6eRWtXr/t93YZciYD2x7nsID2J1i+rbz6BeCTSiqbc7fU542ROsIsu7cCfER?=
 =?us-ascii?Q?j9Wi0s2ebIkl5m+ecjOvtGwl9M1KyF9cc8pI1QPRKgzrL1LproiUG52yEnG2?=
 =?us-ascii?Q?4KwWuS+oIkw3wPYV3Qod95x88kgcLyw3J8OVkx6g4xcM45pcMF5SzDf3Uzuc?=
 =?us-ascii?Q?/ffcz9jBHQI/YuxLxZ8CxCArunm5IbNVULWhxCGnXHOFRT08iJs7F1ZUf4SU?=
 =?us-ascii?Q?Cf8eDCQECtabtx4vF6xODX035Abtt/L5Cm8VGxsUk6wCxXUpTFJavx976t2R?=
 =?us-ascii?Q?LGW/Sbh3kVUKsKvL+E4x0HUjfd8Bhuz+z66wA+Qd/jMEtCJS6aFLaaBFfYxT?=
 =?us-ascii?Q?PNlttZtIkgc4urUpfsGG6lTU7KLR+6X9hdv0+XEBuie6NFbbktodi+I04Aar?=
 =?us-ascii?Q?kSlHFjLl4z/Eiyfsck+imQqczSIWzOacIPayqDM8jIsLvHMyhGSjS4YVoC9q?=
 =?us-ascii?Q?MB5H74+HgVTOP10zmz43s9QeX3MXD5PV+1K1f/QKlzF2v9jObgifHz7Dg2GN?=
 =?us-ascii?Q?wQ/SBmXMa887tMQ2JBjTAYx2O1y7a+rbKTackNDI9/avZVVGYqrPAADOf2Vy?=
 =?us-ascii?Q?PLDHAI5jItNEisY0sxZXJIt1YkdP5DDvG9EZ3CW3ScHtXOcQaXgksUQ52Vew?=
 =?us-ascii?Q?txpppuzL/MwWBhZjbJU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459a1b68-bf7e-4cd2-4644-08db61741a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 01:12:29.1613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: km1m+z6t4seEf47nZYf6tCO22I1k+n0u2KxyX4qxuuMKvu0J74KpQQpuXB3KxusANlkG/y6Tc5eGdtrIVCYUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>, "Shi, Leslie" <Yuliang.Shi@amd.com>, "Cui,
 Flora" <Flora.Cui@amd.com>, "Song, Asher" <Asher.Song@amd.com>, "Ma,
 Jun" <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Tuesday, May 30, 2023 5:52 PM
> To: amd-gfx@lists.freedesktop.org; Zhu, James <James.Zhu@amd.com>
> Cc: Cui, Flora <Flora.Cui@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>; Ma, Jun
> <Jun.Ma2@amd.com>; Song, Asher <Asher.Song@amd.com>; Zhou, Bob
> <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amdxcp: fix Makefile to build amdxcp module
>
> After drm conduct amdgpu Makefile, amdgpu.ko has been created and
> "amdgpu-y +=3D" in amdxcp Makefile isn't used.
> So modify amdgpu-y to amdxcp-y and build amdxcp module.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdxcp/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/Makefile
> b/drivers/gpu/drm/amd/amdxcp/Makefile
> index 5e1bd70748d4..870501a4bb8c 100644
> --- a/drivers/gpu/drm/amd/amdxcp/Makefile
> +++ b/drivers/gpu/drm/amd/amdxcp/Makefile
> @@ -20,6 +20,6 @@
>  # OTHER DEALINGS IN THE SOFTWARE.
>  #
>
> -amdgpu-y :=3D amdgpu_xcp_drv.o
> +amdxcp-y :=3D amdgpu_xcp_drv.o
>
> -obj-$(CONFIG_DRM_AMDGPU) +=3D amdgpu_xcp_drv.o
> +obj-$(CONFIG_DRM_AMDGPU) +=3D amdxcp.o
> --
> 2.34.1

