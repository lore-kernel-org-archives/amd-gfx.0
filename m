Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCCC4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 18:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D2B10E64E;
	Wed, 10 Jan 2024 18:40:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBFE410E64E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 18:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlBgTmQ1Vx6tBIeUSqvpkY0v1nH5xhOf9cTBSToF+AtLKdQH+mSW2XZzou59chfdhaCQ618dX6R1TmzVAk31GAyy0XaFvnehA5BhIJNzH2MTuqQoqr77HTPub/Q17kl4XvZocibizuxfH4r5HSlM4VgpYwbdb4bj7qWcvvb08zjH7IzzmDCkac0vQZw7/Jz9bdEDd/eUo/LCQGQvlNyMMhHQKWZNOVyv0P//jCRJYWrhMGymnNwtC3AwdBgYsE1d8dNFsg6WGsElA6OI9KOSShTqLaV7k3V2f/mz8DoTwRRF49UByN/O+lqmceybHsIFm0YEPONSS+95JNv6gf3vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRVp2uV8/k76Ut4UT+vab6vUX6vfHoie7yfMqV0L/iI=;
 b=D4NpybUaTZn3PUbAEhcfRYEfV0+5k7r1cSTgyH7cNdUyi399BhSeJQ2Jhtc4/m+0jwax0LeQngiFoDwnaQYaeVhnd4nadIblx03gwvzTyMasIaFI4Ksil02sdAIh9e9alVsEmkPbHwvKSNZusOeugQ2Rw8tO9OluFl3MSKmWzSdTD5OVFWPFGccUzd47viUt7CTWCTRDsxtcDxmUK91OP4y/giH/wWw1/mKKwGaSC0+9ia8p19/0Fj8roMGw9YExccOzjXSb8t/ztobeycRnmE3hnPfrFt+Mbc/f393u/3VgPBHZsteBvheDBl+n8tk9vCq2MXI5m5h2PVJo5NtyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRVp2uV8/k76Ut4UT+vab6vUX6vfHoie7yfMqV0L/iI=;
 b=2HBvl7fSyvaJZDV+6eHKMhhIrc3Dqm64QgLjxTdh4LT+f+ynfLrp1FFLHT21ThDvJe90LrUCSnhnE+P/Upq38DvjR6Rxec2AK+PttX0ZYQN1mUk3c/xaGx7tkMo7sa/ct/fV/z7LjbL5oiB5BkH6PeeLQh0d7cGvkrxiGsic4nE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 18:40:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 18:40:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3
Thread-Topic: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3
Thread-Index: AQHaQxMxL+wSdy20a0ml83f/QtbXdbDTYtPQ
Date: Wed, 10 Jan 2024 18:40:45 +0000
Message-ID: <BL1PR12MB51440CC74F70DFC430F03C92F7692@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240109154625.1608427-1-alexander.deucher@amd.com>
In-Reply-To: <20240109154625.1608427-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2adbc7c5-2557-4d3f-bf18-8180af112ac4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-10T18:40:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB9140:EE_
x-ms-office365-filtering-correlation-id: 93fe4338-7b21-4f63-8c5c-08dc120ba863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91xmnNQBmcz9WHHciXJr9lDxYWjec01zjt+rlhbNDnrm/XLJvU7QADAna0tx2zj3yAwXXNyyBRUGyroFaBUxYeApGLnGq3QVoUwZ6U6J8Wdnc5RdQYMWJmI2tCDvVLzPT+8VAJpde1WgB273WK9cvBqenLXyQT1RNTKpMZKTTX94kMqkrBm1MiV/1PqdlEVMyKwyygEbgRcxWCK473MbhkRhUCvfEP1vYf5yKnutgFxmNcZFldfYuvcDdIiZ8trCwLrvSkCxI6yUTy1EvbEEpAhKAEsok9qE3o73yd/G6KqiXzKhBxtQSs34C3dtrG4gs+I0EM8ZWAxiBE/0tD/pzb/P2vK2lpAF8q7NEy75PGAxP/cPQvTB1veGs795RsFukl652LJcYKOiWaTygZvZbN1RmIvrHVj5Escfef570wooozpC1/BDFvfsCu5Gvur9oPUwr7YhPdRiOz+164BdAkdqXDoqiYPkuTlemPhh0i6RKoKcCK3UWzbMlZCXCN3sAO8r1NhnN3vE1lCGwvwhYEMiDkEJeOLpjQMDwE+200VucJaCt68sLRa3OBFrGrmz7uxryuoOrX4aZKYbNwaT5W8z2ROlaKX3LIyALqPNU1HvJ5D1VchD3Ui208gPlNSb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(478600001)(83380400001)(71200400001)(52536014)(122000001)(66476007)(8936002)(8676002)(66446008)(6916009)(66946007)(64756008)(76116006)(316002)(26005)(9686003)(53546011)(6506007)(66556008)(55016003)(7696005)(33656002)(86362001)(2906002)(5660300002)(41300700001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRh7Is9fVqwoH3UzkHy7hjAkRnOky1iwY2sVUYQXwGiqIW03N15iCtxIRxHy?=
 =?us-ascii?Q?WmN/u9SZ/Q329l9MQnPZNa/BzIELObQB50OpDxY9Ijx5D/dkdOePq3S2gVlj?=
 =?us-ascii?Q?i138PwQ2td2WeVt+ecDgjP2mE+gbhqilJFZqHb+hCkTdm4M8HZXCCYn2aaVv?=
 =?us-ascii?Q?sHwE7Xnvjgo4guBpQKK2Ui9HtTu/oxzfPnTVcPr+0Bjpu/GLvwSSiyuLxPKt?=
 =?us-ascii?Q?5Lxgnam4DQSWtvcMSn4uHDHJRbE6N6yAmzl6pR+RRJDwMQLRCAMBFRaeFypv?=
 =?us-ascii?Q?eGtpRVAV86yWAiTtwK/Tf5gsBBigk5uui7VyuqOvYpd/ik9GUOf8uue0k0Dp?=
 =?us-ascii?Q?ZTEJ5UMTxXo1yCAesOFbIEzrCme+iyqFydJeg3AwUQo/0jJe4fYTgxIW/3z7?=
 =?us-ascii?Q?lKV5f9IkicDnzF0M3D/3Cc3nPXoQU2/2VH5K0izvNzItGi3uMkNWe9RHtn8C?=
 =?us-ascii?Q?iSvyZnVKc2wzifKz8XE9H67ynmvC966PkJwynJ9DMvOtxwIPZVW+VJvG+U1b?=
 =?us-ascii?Q?0SRJlBZF3eqj+j8t1uVwBEte43L+fNzT4kW0TFlQBliojpiN22dZNkIcUD2q?=
 =?us-ascii?Q?dm49Zc3LajmK0bin3sBIynoNLgiUOgaKesNtuBa8hDJA6d9oPVNe2QNQfIxz?=
 =?us-ascii?Q?U2zdEYHnuKEQWd/qrtQ7DEfWm/cHaXjLjc/qyRy5wBB/XN0MnjNEC/P64YJh?=
 =?us-ascii?Q?pYq0DrXmjkquvxk8l5q696qFaDBcQGpM7Oc+mqQY1xD9ugKQImu/RkPqZ5b+?=
 =?us-ascii?Q?jsZk2sPc6GYNzpCo8NHowHv5NDtADaFIEJefwU8fQeKwvbrwbaa0bSzXRB1D?=
 =?us-ascii?Q?eaC8OtX2c9cUdOhFABQKSB+mhQz/rn55ylltsft3oK5lgqrQXXNQ0jyZiDiT?=
 =?us-ascii?Q?1iFEFgfNeYZCftcL38TrO9ykHVgT207LvDO7yIlvUtPTIu17D5uLG9CUNMkY?=
 =?us-ascii?Q?4T9TqHSoDXUkIVL+FSRkpeOpgUFKtQnOByc10794/pnu5+baS8zKHAh6bydX?=
 =?us-ascii?Q?V+MqRFbHsnFpXZ/dw1sz5eGG6kGDgmxw7NxDdWg1EAVBBbkJq2YXtyge4Fwx?=
 =?us-ascii?Q?QqSCdC367J7zUw86IKuU/v0RA9OYRZhdHOP40ukNEGkYBI07aZJxzbeo4kVN?=
 =?us-ascii?Q?hN7wrMGmZOchwhwbxmH6vSCKsOxEkY6QAw5addA8gaWuI021MT5NyANXdHOa?=
 =?us-ascii?Q?rfv5vcP/L6OtpztYnfTlSUgiODN2ir+U3laQnI+V4rSIoREt1Vgz1R4mTJ62?=
 =?us-ascii?Q?0tItwuCX3dY5gqvHaeTRsTUdAhA0m8DWsRnP1OHM8W9pOaNISMJyu0L29p8S?=
 =?us-ascii?Q?uN3zXSDq7NqYkdlNe7jE4g5G/U8sAYNZ3UN4dfG7LxvhQldgZ1wL/85zk4gu?=
 =?us-ascii?Q?B3OJ3IlZWSujKrKNUUe0e8giiW7H1j4jlJ2056R+vRjXzce9/vPkfYWCbL+t?=
 =?us-ascii?Q?gb1bQg+l2ezYvbrdlUHOcQk5PRQ4Z/rglKMhSu9AC7iHDEXZ+XvTc0Xu4Cct?=
 =?us-ascii?Q?qmWVf5ZfJd8emcneW2L5RSHI1r9pV6QTSA6VLl1oTtZG/Xe/oH9nyJmpv7aU?=
 =?us-ascii?Q?2uoigaKFSRSWNAeWsbI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe4338-7b21-4f63-8c5c-08dc120ba863
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 18:40:45.8342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtRhh3nTCPaItImgYKge8xQJMwyW7P95CdKiyURC2x/RoZdAlmNUk4S3zNR2D2BqrkDv+3viFihVuBFDNltD6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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

[Public]

Ping!

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, January 9, 2024 10:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3
>
> No longer needed.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index b8fde08aec8e..f96811bbe40e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1963,8 +1963,6 @@ static int
> amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>               amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
>               break;
>       case IP_VERSION(9, 4, 3):
> -             if (!amdgpu_exp_hw_support)
> -                     return -EINVAL;
>               amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
>               break;
>       case IP_VERSION(10, 1, 10):
> --
> 2.42.0

