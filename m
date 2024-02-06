Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69482C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9680112DC5;
	Tue,  6 Feb 2024 20:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4efZxdfc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A995112DC8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1oOjlpdbOvk/VnS0QbBCAvmD6ghthts+Drif2ruiw7ZpUMxVWDc2wTLbq0ehna6yjvKAdUWjqzLKoKjIXUquREvqLapXehIZWUEDHskEDmHe/23/z4v1A2c4BZHedtF+IN1CiXOOXU1JDKjVRAPCcRZ+GDXIpXeHRN2z7F7OacqOy9iVtjDQN+K8Wbg9NFPJHjTr0cir00leudB6NiVjuL/nfST1no+pgiiqSVZl5DpZsHhODo3m23LuB3qPnu80RWrERmtxowRZeFkIA/s/9VTZehAKQfKEJ9aOHYVTKZdJPRW5P9Q9vAoRWeygUBd+dT5nt91gE+OISWzR8XU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjvtpOcEHARttkmgJLl/5rUnbYrYnoHLWz6Nrae7xX4=;
 b=eNN0CAgZQeiw3f2mD2UGFCRGbg36oJq+slQ1sguBbxiVNg4jPMEbudTLWYa4ddx6kCv5FjJqgNnNohIgc5Z6sbOFkJTU3xPKt92Gq1l93MngPQqOKY2eVAtwZNcGe+lJYPMgOhwkDJ7/l/ciNbM2FqcISGVFdVSh0D2ImRPZPzU6gTi3ld6VAJDXHKbwVPQrHh5c5Lmm1M+GUyEKUoOkYG7cGgtuCOts8iNJZqWudy6Qe6feoeTQcn5WMCAWOHlwqjN2BRJbLf+/gglQpFxV3TuWp4aWwmJ6HYnOoqf1+WGgoSLHbBc/C4iRMejE1RocJaL9k1l7viFJKFSlNntVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjvtpOcEHARttkmgJLl/5rUnbYrYnoHLWz6Nrae7xX4=;
 b=4efZxdfcW9wAA1IOhB8HInDNIPF6mf1j9+SL403mBg1gD52SoTU/xb9j4SIQ/uhMVTLEP9p2mQNhTM4mjVYfvKeUQsV6XcHqYxQv/gJ5CXxYmrq4QacdQyrrrUYw2EPKjagwtPffYy2xbpjGW81NVmh3vQAix7UG8cc0pkkhnKA=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 20:06:10 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::a1f9:8073:1b53:8779]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::a1f9:8073:1b53:8779%5]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 20:06:10 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Topic: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Index: AQHaWScmk7skoPyTuUSCJWb/4yuISrD9vUFA
Date: Tue, 6 Feb 2024 20:06:10 +0000
Message-ID: <BL3PR12MB64252107FFFBDCFAE77D9F3AEE462@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240206180545.626910-1-kent.russell@amd.com>
In-Reply-To: <20240206180545.626910-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=79a2657e-0a7b-4a03-ae06-b42de747dee3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T20:05:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: 27932309-b281-43de-08bf-08dc274f0fd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aNb7K0ol7tlDYZ0Q+DH4ihFrpVR7d9ra86R/Yipkl2VNOC7CsrXSDEeUp4HZ+/jEDyTM+hujCKavj+gfYJ+MQs8HtjnefJU0ohSekRqcuSvr6dm1IFOO1wk+9BMn8OQ+qi+HnhPLFly7f0WfUoXd2QDqdJHS+x0LZ8S07iejxbShK6ebIIwo9r0/fms83SPgi9CwSDMxAjI3F8nbSeOdwLro1LhQcPJV7pHtMYklPfcDxoiI4B6H2y7zmPEeVgFr9ElupGxRN/aDgQwj6KwfC37K0sO5M9SWFWev6lWzH4Q5ObbeCJbh3PsabwOnojftY1LAWDqdzkswZUcp721pyy5ezYi0y+cmb5BC6uvFwL6VLP2eIe5oEF8/08Fg1zFrMH9xdPAwcrK2m16EcHELgHQrS43kdzsr6A7HR16YuAgYaqSvHJwFJzAJnrALwMrRwbQ2CAfVIYDKBilCesFMDPiNfbaFdOzVRu6CKO/lHDRqmxQuVgwBGypFSLq99nenQ3K7jWhcdbLtIwHSdVDz1RPK6/uMD/9KN7P8MIhHgBe47qStAFO5McZJbuQN4PdbSa2i2VlqEpPyWLGTJ0Gwd3mbREeuEptdkCNMW1+SRqyj+SbOVynEVtH0pfVC/BO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(9686003)(26005)(6506007)(7696005)(86362001)(64756008)(5660300002)(55016003)(66946007)(8676002)(8936002)(33656002)(66476007)(53546011)(66446008)(316002)(110136005)(122000001)(478600001)(52536014)(71200400001)(38100700002)(76116006)(83380400001)(2906002)(38070700009)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y2JBkKvu6bEvjOWoak00D3tMa8IFNtoyUrHMdV4ECvtwwVNfcQ9IvDT2OTJt?=
 =?us-ascii?Q?muX2GyOponJhL198/DaDPgHYoVGvojYV8OcJhgr/SFmUxe8uQsnYbSubkEZe?=
 =?us-ascii?Q?XEC++7gsPbrIW2toXKMH+A5SDYqdK/4wF6tVSjZnh9q8b+V0Mh888ZicBAFa?=
 =?us-ascii?Q?mCQGZ6vWf+ujOdELLseznmOjcHEpk6PWGHIFOWu2m+FcLM18uWnhx87yxnmf?=
 =?us-ascii?Q?y4dXkOSE03SDV8nw/rmgZn5xLnxvzz1zpw5u7u+zD9R+xg5uUQsqbLdOrbQ2?=
 =?us-ascii?Q?wjmoSJHdY/EU3yk/+DrQuXDxtm0M+RDeM0/lzEZMwiuEa3kWo7QCFiYXlx5/?=
 =?us-ascii?Q?Wv/qISaa06LrCVkmHZFEZfe1UhbPMw0o2Cb//s9hKhQn2vLNb60z4BgBUrkz?=
 =?us-ascii?Q?d7V5C/hV+u8LrldiF3/d46OdVpYunRsAz/TG/dY0+N4ike77z1P/5BtytvRn?=
 =?us-ascii?Q?oAljX7wlKeTprHwPCwRd11EV3V0wmAgeZhUIy4HeTsncrhBah3NjV9cnUyPa?=
 =?us-ascii?Q?fXE0jKGkaLwgTnnMtvhPyLyMkcLIugL/Lk2yttdKi83k8S3P8r6RoLdMGhVN?=
 =?us-ascii?Q?jes+sbkNzaLz/Zo5nduVj8Ouy59S6OHEWTR23Zkv76/XIAzEfvY9ko5liezU?=
 =?us-ascii?Q?mbEmPtM/+qNdX8k9W2XgEVRDKZ3USa4d6uvOarjp3ys5QEiWnHdgY7i6c0Ec?=
 =?us-ascii?Q?AwsgQFjc1+ERP8OBllQYrt7Ly8r/yE7PdqWkYYPM5ve3TKIrRevS7SnBnv9p?=
 =?us-ascii?Q?mmKqLi2HnhTfM8sWncCiUKqaUKAMbaEkT1i3Or9w+OMsNRnPuq3fPQOT7T5X?=
 =?us-ascii?Q?cHNxUCuZblnTdxGMdz5irvmycDjZQY74uVjmohOkwadjy3kC+rOUAC9a9k6J?=
 =?us-ascii?Q?8tE7oEMrulatuCDIGrucJAW1BABgMf+Uyqg9FylCQ7ZpvYQZcdmEHWg2i480?=
 =?us-ascii?Q?iz+PvGkUSEGQZlRuzFE8TuC6OSkw3gCFQSWnKvbjcqhxwbdkcln2sk3Lp226?=
 =?us-ascii?Q?N0GF3Wh8D4d5V6phRPTL+ToU4vkUR6dp/aFOi6XZZqXlBBybdSYNQU/x967W?=
 =?us-ascii?Q?6cOZRIYa2keb2iskmWAqsdXcif6IQZCy5eON7iMuq+gm5SokyHGa+H2/QLcJ?=
 =?us-ascii?Q?iX01pE0GoGUL7Uot/P4xKGDkXuUuutA7eAXMe0Tw6aWHIltsGKy8GEOsR8I1?=
 =?us-ascii?Q?ucgMhb/jwre4Awt0oCp/Zya6aRU1R+sl0uhgxPH1P93UP6xqYwNVFnsFrwcl?=
 =?us-ascii?Q?Cjc466AhwcT0DTP7sn1AvdsnBSx+qW6/8qQHmY/F7IfsxQaSNVLbG1UfW75G?=
 =?us-ascii?Q?D1jDP5IJ0BJcUWTpu4rynbnUMO8I6eGjKyuBMUmH2Rmeu1hZB7u3Bnr3jpDk?=
 =?us-ascii?Q?EUWtZsJLH8ewBtKxxmhFLgNl4gh3hBZrNp//VICw+VDZANYJY73vxIDQOU4Z?=
 =?us-ascii?Q?pddcGIJuCoKGY54jtFnT6hMp9LmvY7gJ39pqpVVCw1YXhWgw9foRJmQG210j?=
 =?us-ascii?Q?WsEGfyERBYdcjFZYRgB6ioQm4nXr89rOJoyKZQXVRVMh/vGdw61UC5yqtZIu?=
 =?us-ascii?Q?02uc2gMY1fuV2gm8c7c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27932309-b281-43de-08bf-08dc274f0fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 20:06:10.0897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjXGIk4vW5mNXdh9tD0G0FzdTbWWiGEvuK8s60t6qMuAf/UbKVeKlHe2M7Y3szvRV5Aa4isDSTmocLYsYaun5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

The commit description needs a Fixes tag of the offending commit.
With that fixed, this patch is:

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Tuesday, February 6, 2024 1:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
>
> Its currently incorrectly multiplied by number of XCCs in the partition
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3df2a8ad86fb..64bf2a56f010 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1640,9 +1640,7 @@ static int fill_in_l2_l3_pcache(struct
> kfd_cache_properties **props_ext,
>               else
>                       mode =3D UNKNOWN_MEMORY_PARTITION_MODE;
>
> -             if (pcache->cache_level =3D=3D 2)
> -                     pcache->cache_size =3D
> pcache_info[cache_type].cache_size * num_xcc;
> -             else if (mode)
> +             if (mode)
>                       pcache->cache_size =3D
> pcache_info[cache_type].cache_size / mode;
>               else
>                       pcache->cache_size =3D
> pcache_info[cache_type].cache_size;
> --
> 2.34.1

