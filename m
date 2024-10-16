Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF351D20688
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 01:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B4F10E2B4;
	Wed, 16 Oct 2024 01:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o+QTHYJB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0542410E28F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 01:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhSrajXX+y8WtzWYaJ91DG4u2i98+qm/ZPyDa9gF1c7J8OO1W5CKEjwEu7NMOBYK2fPXqtURT1ZakMpZYXfE2qmnkqHnya9irI7KRiGYS2kZu1jd870XznBC3RidmntxQAlI8ZV2FXJQrsJcxqUfVRPGQXe2DGB1apL89Nh5V2VNSOPcQErtzKjircai5kMucUeybpLjc71Ka4UvwCGLlvWUW9eRF1FRjRLa9GxkwfMjm9Z1C25HXqq0PagK6lJGgAPCDSmyrLdBY7idEsWSNdUi9ADipU3DU+voVD9HUtPzN51KNlIeKdhl3rqPXu1ys4u1WhoeObf8Zliw0ec5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWms46wWuz5JxxxV9KiYDyPT34a/WEedqCgngaOBips=;
 b=sNIkuJ08+aAY3cEeRwe59AZoxiT73oBaMxz4KMON4pPLPCF+c/dMSCNnN1ytXz6IfdoT3Kwb3JK0Bmcvt3qef6skvRYLGh9X5KEyQQq3wYYXE+dLTBBy3Kbpzvr5MNP6zuBqYVblmsDHYXL5sWaWUykzRIhR1y28fL86qByxZE4ngxhHveYvX9VZ3NKQGbBMqXVnFQWGZ4lgrN2HnLeaM1ZSDlaR9OnuEnNCBDU9CtDf2+oNep5+TTyikwDJJ50+laf5MqqdISYbgTfI+j6kQUUVg9CkJaVdSgQjsur4cUcBgNdzcs1fiBPXeCo1UsiJrJS2sgx1DsAGRf1k7MK7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWms46wWuz5JxxxV9KiYDyPT34a/WEedqCgngaOBips=;
 b=o+QTHYJBC0knPH3nJnaGSOXImDcXF9sCtVDhShuDVaIaxaCB3eJuFV6GMmjrbEj+NTd/OzwrOJDw5YLuDCC+3m0Cnu4kJ5DkgLvLh7Jxc3JbC8vW8WaruDm4G/h8R/VxMLfZP1BgUz5mWeyMBUYiLWJ9I1lD+W7KbvwjOaxFupg=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 01:38:10 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:38:09 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
 option"
Thread-Topic: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
 option"
Thread-Index: AQHbHzzLVXguS+lldk62eb6rEOOnybKImWkQ
Date: Wed, 16 Oct 2024 01:38:09 +0000
Message-ID: <DS7PR12MB63337F65C0C2FE54DAA01BDEF4462@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20241015195933.2500409-1-alexander.deucher@amd.com>
In-Reply-To: <20241015195933.2500409-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d407c24c-416d-4b5d-a482-fb3613bcf3b6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T01:37:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|SA0PR12MB7003:EE_
x-ms-office365-filtering-correlation-id: 38107cd2-0635-4acd-fccf-08dced83310f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rTgHwj0UdRhRwXCGWYYvLhg7tA3t99UX3Mjxt3TK/hTEOKAJGOwMxTxIhnqj?=
 =?us-ascii?Q?0vP68L0TNANtGPBD9X4DnYQHruKJ6fqspNOOShbCYNJDDTR1kpt++xE4+WQv?=
 =?us-ascii?Q?QALKKsA3roCOs63NFEZ/Lly3ZO4uirelGLGEMEg6Jfa5xCFmqyTzQQznD3dN?=
 =?us-ascii?Q?e4JOKInktqRbLfE3gK/WVP5vSD7MYgZV81MFhPXZ/qYFiHBwfkT9i8oVA7FK?=
 =?us-ascii?Q?Hb/gXSwS4CjkhOODrv8dmhkLJb1rfJkDZxMcd6PMDoSFJhbaouHCVt/miZfa?=
 =?us-ascii?Q?JHY9YiS2xikfGVhnOogMq9ewPHO2q5AMZaw9Vnw3PAgm5YjPnB8AeHJD3A0g?=
 =?us-ascii?Q?sdLvgPoaCRwIZZjMW6Cj8gZ4kIXXv2ahqANnp94kS7qFdSTqYPCSwXmIEmtL?=
 =?us-ascii?Q?ErMZvKSRqVTaOH0N0Y2U/YSNUBuJ3J3tw6ebDMfNrkd1y8Z1FjCHTVX21wjR?=
 =?us-ascii?Q?QqO4ji83VTjRKTeZD/nPoTKHMhv4f5rF0ftvpvtpOmq3oCPbyGxH85rOvk30?=
 =?us-ascii?Q?xFdvMLnYpoiOhsaGk0iJGpZiDL9yIGRzo4RC3O1jYkGYFBrbz/gIqpgL5hTG?=
 =?us-ascii?Q?qWXJ9RSvG67s7PCDRA3ZTxr3IbJTl31Fx62pNL6VSGe6AtukBEzO3x8YoWkK?=
 =?us-ascii?Q?Nw0jzsPa1UabRn082/w+NWjwcnWbMDRfrnuUxLppZN3dWtaSCcptJyI/n1hs?=
 =?us-ascii?Q?flC0NQSdlBEJ88m//ODe+Uih8BAa/f4GW0VB5W6+t6nYluAlmr4u6FQ8TJBo?=
 =?us-ascii?Q?EnE8Ecs2SK2WtIb5uUBrMmh9LqcLmlTufr1jIMDGfc6qf1zjXtYqCyXKXo8S?=
 =?us-ascii?Q?sfIoYIUqFmE0sZFH6Zg0mMrKwgZKOhFyfUEhI17zFLjU11ooTHXL0Viy9K9n?=
 =?us-ascii?Q?z7PUNOMryIztnb5qf4Ha1nymS4/WTesFkwSIhqagCHpA7er3hC82Um2jCshe?=
 =?us-ascii?Q?pAg7t0vvtflF9ycS8sf4SdoOM2MD6RmKWj1jwlluDT8wIB8sroILWTMx7ZMs?=
 =?us-ascii?Q?oUNVe/3hYlJ6fQq5CqAn5S2Id6OAqC0yOS38h/9Hk97Tg1mCBtTz9c52pLD1?=
 =?us-ascii?Q?n/fYWQtFsYtyx/lLGSUf5S+S97vFFzfx5Y06S3xzF7l9gzyI0rYy8VSQkiOc?=
 =?us-ascii?Q?hLbtbFNaWThUxSq+SvZab1TSvIgm8UkvtQQZLDurb+8DatKT8LzCXUmhVGkn?=
 =?us-ascii?Q?T48m/zb/3+52D+lGbWeev0lLNQUgYjAVllPn9S8muiCMS5GGpeVd7K4t1kG5?=
 =?us-ascii?Q?NVckpWT1z0Rh6arywXnG374TFSLIx0aWQOz/KS/j7ICr2/iON5QyKcOV8Wc4?=
 =?us-ascii?Q?gTM4uA+ZBIW/3KEbtfAx+Jw/u6vbZuCx8cyG1+/9flpt2Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Axu0HIV8Ee+iDh7NEhC78A92bjge/gg0lDotarlA8ZXlYFpocVSTdWGVCo/E?=
 =?us-ascii?Q?qZasEnizpNYvd+QsX+nZkbh/8BE+LF6zNMBG1amWDPbo/JdE08KdaKpLYndR?=
 =?us-ascii?Q?eFUN8ayaLVJSg5X/XBUQlN/u8t5+rOjoJ5NAeFWy3l0OGJTYmtpeA2TAodW9?=
 =?us-ascii?Q?XYkp4qhQaD2IbDwFBZWML+S2NaYCHSLDyvfsQoGhS2EK+SuuD0nBfEQ9pziO?=
 =?us-ascii?Q?gLLkJLEJf3EGw7Akzl/8k/gz29WAQl6Jq/Ryu7dDcrM81KepUJ+Zgx4CKwow?=
 =?us-ascii?Q?fLuk1JKXdqKn301eYCeUf7WunXpYiZQe32AP0pUyOyUn3ZhzpISNy/e2Jr9Q?=
 =?us-ascii?Q?I+UlChTE2NqeDtKWIGV+ScxbmXK1BqtkUz9JFFOfL0J/tLHfeyEIacbEm8Hh?=
 =?us-ascii?Q?ONFG6gF5Xn7cPa2P2YwDEI2G/+S0j4FScPSXd6QTqrEAW6HJuayTzs5OUCq0?=
 =?us-ascii?Q?Kw1D5fIuVVdJ2X0ld4177MKbxJXPS7EfnXH1mm8vra/09HZWWwMOjP2kXP1F?=
 =?us-ascii?Q?PraGcMal0IeMUy4nfDcaWwN7Q3qLwA7Ip01uEL4o4Ebc8VJFkouQ2g3cW+yC?=
 =?us-ascii?Q?hSfPGnk3CiH7lQ4JKLbleV4J2xKGszpkWFscPwWyLBywlDK+peCfiF+B2OlC?=
 =?us-ascii?Q?egS5B0NVxffxk1H2AJ0vnqkWEkX5+La6h5lb3RTK97yIoNMU4yMfmU5p8QIE?=
 =?us-ascii?Q?cFwVJVNSVh93qIJwatDY2CMawJYu1j+kmCvT7DMkjjQaW7bt4Yw29UitVdK1?=
 =?us-ascii?Q?CjnKWuTTiU561EJszavqJCfrZrtfr5bm4zmZKe7ZQOsV6u8QMJnXcaVIEcHc?=
 =?us-ascii?Q?+y7lcjEy8406J075B7H34KX1FzFCPphA5S2cDFgUlAcjV7PeWUHnlzF+CvOu?=
 =?us-ascii?Q?VDTAGGPuB4KHuihBcCY1DsN48oyUDMrgQ43ZRA1BKX+1HGuRKw9vxJSKflwq?=
 =?us-ascii?Q?tJdVr6VSxor3Y1JBTDq5/20nsd4EZ8UaZmIjzD6lX3qoZ0FaAsqp0KYeq2bQ?=
 =?us-ascii?Q?nmbCf3ymbDHormCAJDvU+NU/edC8nCv1pPvaXnVzDiacw/tKP0lP8JAY9mnN?=
 =?us-ascii?Q?8E7bi0ZW6yCr7aS0am38/pqsEMW8JdtJ1yETWvbbhhLXjkebW2jDhU0PfZyK?=
 =?us-ascii?Q?9qb1OYrXn2d+Wl8aMd3nEFWGZpDxEEpEY/MY0unpSi+x7LZCy8w2Rxj218fi?=
 =?us-ascii?Q?P890D5EIY2G3FOTLu7NaQel97X8D9JC+Z8p39TCnqCcQM96tDUfsCttif1Wj?=
 =?us-ascii?Q?DIg1ji1d6ZRP4zwXFWU5dEPrCh7Hhde+4MgIvDL7rOvOUncRMQtWz+B52rJg?=
 =?us-ascii?Q?Kgzw+rKcrw415nkH8ax/38bJlzKIFm8YcEj1AuN1CvYl0d/kV2JyooOjbfSr?=
 =?us-ascii?Q?eNAqdnb90PiEdrV8wiHPMxU3UEBDhWPT5W9MSg9H2Yq4e3iTHiUjLbofXJci?=
 =?us-ascii?Q?N0ATkhfVuTFv4Kwx4Timn2Bg9bq0AmY34gAIUUy2uZMM1M561JC9Zim/3v3f?=
 =?us-ascii?Q?m1BqoTlQBFOPAVpeX2yoojBRI7HcbzT1WtY2u0DZT+ufmC0Qw5Xl4wX1lxof?=
 =?us-ascii?Q?gMtTG+9OqWohsh70nQw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38107cd2-0635-4acd-fccf-08dced83310f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:38:09.9194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egSQY/QdlhVKEvtBasSqBAfdfUktldDvtcuZe8MFdxails0Elu4iRvVktHgzvh4zEAwmAgjhelpxj6Ie/Ysvyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Jiadong Zhu <Jiadong.Zhu@amd.com>


> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Wednesday, October 16, 2024 4:00 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Subject: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
> option"
>
> This reverts commit 7c1a2d8aba6cadde0cc542b2d805edc0be667e79.
>
> Extended validation has completed successfully, so enable these features =
by
> default.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jonathan Kim <jonathan.kim@amd.com>
> Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ------
>  3 files changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 2817198d4b55..740525407154 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1132,10 +1132,6 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
> amdgpu_device *adev,
>       uint32_t low, high;
>       uint64_t queue_addr =3D 0;
>
> -     if (!adev->debug_exp_resets &&
> -         !adev->gfx.num_gfx_rings)
> -             return 0;
> -
>       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>       amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b5102da25798..508a2dcc0b1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7260,10 +7260,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring
> *ring,
>       unsigned long flags;
>       int i, r;
>
> -     if (!adev->debug_exp_resets &&
> -         !adev->gfx.num_gfx_rings)
> -             return -EINVAL;
> -
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index ccd17dca0396..4fd7e9c5856c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3055,9 +3055,6 @@ static void gfx_v9_4_3_ring_soft_recovery(struct
> amdgpu_ring *ring,
>       struct amdgpu_device *adev =3D ring->adev;
>       uint32_t value =3D 0;
>
> -     if (!adev->debug_exp_resets)
> -             return;
> -
>       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
>       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
>       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1); @@ -
> 3573,9 +3570,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *rin=
g,
>       unsigned long flags;
>       int r;
>
> -     if (!adev->debug_exp_resets)
> -             return -EINVAL;
> -
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
>
> --
> 2.46.2

