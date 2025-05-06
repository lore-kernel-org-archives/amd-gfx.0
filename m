Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781BCC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 12:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F2910E08A;
	Tue,  6 May 2025 12:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a+wU3Q6V";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D6F10E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 12:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cptFEzErIO9Qh+QcACm5gFjS6dbTs0bu7iUdM854ETAZnMEaMRId2MDvrDAIQDOg3m1ymTtW9sJIFHJsHoolWDhsDxdnwuXeS94PMNi0LWvGLj7usfMo5Z7zjC6/sRQdIbRxYEdRUVDKuiaL+2p5rOUDzNKoqIAGMUdoHmXxZPOZDWVQe2vFMi1RuYatnwDuYaxfv3doI24R6Cg2bsbBotoTvAb/gnkmlJjgXJLzuuiRMGha0qUpTZ+tP0e3hyM8ECPpQbHU5PZIZk3TAX51PAefqHl1zbDCv3nX/dgUqRcIcxyUHQ43wS6XG+n+U8Djl2KpSu/oMvLl7WbMJC5JJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr1CXJBvX673YuSP9w2LFYhk7iI1DevpocuImO1tJqM=;
 b=Mxasfsa0s53xXD5JQoPaVTn/GTGuTohLI7sRIqLIBajfDEWW1HESAJT9XAsioJv7mW/FawihH2q/JtT7IqiTRygu+4C8nVCIM7v+sODKFLzNmTlXVj68Ek1bWhiuhRcK+UXgROkSQLuIcQuOf6ltyY+53mJ+QP58dGdcjvkpBXaei7oyyATeAvbYePe8aGqUd93imte1QymhfPG20cJtCZvzbyuehcmL9M7HKCyHPAOEEmzm3v0xj7fCmhFwdO560SPAtllnpe+AAQLGfP+OHjCMatZRIMaVoMblZoawGRLGzMg2qz4a7lPWuo4SCETekejPw5JIPl6MOZBD/gQp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr1CXJBvX673YuSP9w2LFYhk7iI1DevpocuImO1tJqM=;
 b=a+wU3Q6Vlk5UcS2WnsdzJkgZ+KFsji8VjF/xnGuhEDtm6o3aH1/1JidEygSxTCKQXYgh42pnfSwdxzmbdMagR42qcVHf0Kw1AGIihkSOnTxBUAB9f6Xu7rvhjPNZeb4cTrBYSwEX0QenMuvibZmU9jOlF0CkoQexrVcc8hDYH6k=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.28; Tue, 6 May 2025 12:27:40 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%3]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:27:40 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Jamadar, Saleemkhan"
 <Saleemkhan.Jamadar@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/vcn: using separate VCN1_AON_SOC offset
Thread-Topic: [PATCH v2] drm/amdgpu/vcn: using separate VCN1_AON_SOC offset
Thread-Index: AQHbvcxuhmTbRe+hQ0SsWw9BZXfD3rPFiNEQ
Date: Tue, 6 May 2025 12:27:39 +0000
Message-ID: <DM8PR12MB539954F5A25D84E18D75A4EFE589A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250505144549.1263994-1-ruijing.dong@amd.com>
In-Reply-To: <20250505144549.1263994-1-ruijing.dong@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ce9f1a96-df9c-48c1-a8b8-2cb392fb1976;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-06T12:27:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|CY5PR12MB6105:EE_
x-ms-office365-filtering-correlation-id: 9b926518-3cab-46a2-ab41-08dd8c996483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dqUNi+LWOtjR37zP2D/ZcnFiSj75v1HJ+hckb0Y5AlT9f2Inr7tW2bpIUdWs?=
 =?us-ascii?Q?vu/sVzxXdr/R7X4hyUDvUZUD4jdb2Wg1Ntf+91ZBztj+PlC5l61msGpjr1nh?=
 =?us-ascii?Q?RL9LQMO8zLBK2B76bWZ3yp/puqLupX650t22Fq3YqWm/q7JDaRQPh4T09+e2?=
 =?us-ascii?Q?FnZbC5bClqLsqHqbXHW+XJ7Ps/3MD1WWsrkIk138MxqNS6nP8+Ee8iHEkZWw?=
 =?us-ascii?Q?aXE1d9xv9groEaJczxEHVIm8AScQlynjtOZGaluu/qDngzAyBcoDJyGCEwOC?=
 =?us-ascii?Q?7KSShfhOriyLkTFSLM8mY9D+/6q/zlO6i4ZtI60PsI1eN85BObUq43Fg7a22?=
 =?us-ascii?Q?Ms3ZQd1VdrHMGK11HoUTyudAdjvyA9UHV6BWAd8V6qjORrL4QRBeO9eZEm0F?=
 =?us-ascii?Q?IKozel2BheJp18gHSbqrqpj7Y2zxPGFAuziTRGAJkF3ZoAh6MlO4svDEHXWD?=
 =?us-ascii?Q?KgwkH/EF/E+yxtWctH+iOc3pKKls+BauP9mV9pOfvvaPfQqVsbzhcHfFtT9Z?=
 =?us-ascii?Q?hOs/7JPHD3nnQ3XLAwSpwJ8SrVFftmKydh8qLhAHtPH+2fnR7ZTThU/zEoSR?=
 =?us-ascii?Q?akz5pa2Z5fD8EgESituycnzBw0SEZ3Y2X5vFhnxvNwLgchZ/eyHMCh60i8lQ?=
 =?us-ascii?Q?7V6SJxrweqzeID/oe8f8SCQIjnKXtlUl/+IaazX/9WuHObacMlt4DJMymFIf?=
 =?us-ascii?Q?y9THMjZP0/5cxKb+fpxfts3TLv3TKYYPoMSrKAnetsa7mr2gmvlrVbYtuKAk?=
 =?us-ascii?Q?k2ZEPAqubB5xAP5caEKK+waMfdjk94xUc9U90lNpO1OdoBWUi+aOnksP992S?=
 =?us-ascii?Q?tm00MzRvQCOAQ8ARNzsrOdj5F4ZwXvsFFeWaN4dUWiyYj9IM/exPYEKDwSXc?=
 =?us-ascii?Q?7MjHIKz9GNfy26K+MEZqW3mLfT56VWJnkOMax9n4+5GkYAkQSPYQPmL+JI23?=
 =?us-ascii?Q?vT+jRvVdQL6MM6GjUDlDSuQ0fkzu1CBqYklnss6w5HQfZ4q6CNt8PLjJpp+T?=
 =?us-ascii?Q?azl8Xq3xaz8p9Bj3t2Kv5A58+w09R10vTfC9auGh6pONQIycJrZ5XIZZPxj9?=
 =?us-ascii?Q?JASEmISMzfMHLKyFcZZ1WyVuB9TSw+HHuhqMI3HjQBftXNqTPzdb8vPA6zdy?=
 =?us-ascii?Q?q5+ZshvQ3l7L1qpT6CBjR70lxd3yY0dCTwblPMYdd5JkZrXeEFiTJoDsopkR?=
 =?us-ascii?Q?c/lizN6/kuy4Dhh2w1vVLD7Y2QHeFAaodrlUy/lA4dg1jDj8VOBPG2Wncdiz?=
 =?us-ascii?Q?nQALOmSGMOyN0kCkmngWJU36+IOhPZjg/I67bohKVMDt6aEKqE6k4MwxUGju?=
 =?us-ascii?Q?sLqXJKeY0i0Qv0NF9qMmg4DAC+ULssTR3CtSybi9YMHDkWoVDisI8L572eC3?=
 =?us-ascii?Q?t34F1jXOSEk+ZSBCGYgnhbkwOijkSRGx0oY7bbwCcQsgZPwE8wMgLIzQpAxh?=
 =?us-ascii?Q?BbtV3YUNGKw8H3yxkITrWEHJ/TenBUm0DsrxeiTplZpT/0HJadYKbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v5UQJYMIj4IPw1k/Tt2c/6YA/IU5Xspe+qVAiEjxeULQIamAUNLgFGGRFC96?=
 =?us-ascii?Q?kQ0DLyqjWeqk5Xig1g3SxSUsRg0YseyT1mYxr7kV85QUoD+xWRZTZuf4rZcZ?=
 =?us-ascii?Q?8W8AgSiffMLG4ebGOEVGxpFoAYz3zpTde/gtOF0zatzOzmgDCX2iUAMquQn2?=
 =?us-ascii?Q?vEodVPw9+kbRZfhEtDlE64yiEMlHA4OP1sVhvUPyL5kONxXbAgTVBlKs8c0h?=
 =?us-ascii?Q?UeoPjTbJVz5pAItNFR9WLg7Y4v8CY80dxtAHqZaHJLo8wmnT2lyyBUWYXaXM?=
 =?us-ascii?Q?+3+R5hhI5+DbfQ1IaO6GObU/OZLhvJZmIyUNfxmqmlbn2fFSu0TI1Nh0nWcd?=
 =?us-ascii?Q?KU+uxh1xtwXOYF931j1ncCQI1dtrFdsM+NxQUy5CLeZ4BxwotYa90Rnp8wDj?=
 =?us-ascii?Q?5rK7tU3If2jaAipAgi1eYhMLpWviEo3Nrbrp8DblsL4TmacpdnA7eful/rpY?=
 =?us-ascii?Q?UChK6XYfN7EB1kxrI7qUHRoGJeQNG+rjWvx+zoUs1VIe4PXnNTh0Zj4iy3fZ?=
 =?us-ascii?Q?dTXTu/qff/DF7/xuCkRyzbTtg1+tkWSkzr6AegMKCUs/ztfqUqNjZhfmbN09?=
 =?us-ascii?Q?Hh7A/3mUPY2MYTDzv1cQUgwZoK6S8rW/OJG4YXDpOisXnz+eZL/XCWh4pN0E?=
 =?us-ascii?Q?pIe7E9jvhcDurA08c2gAD1WCbRUi2OrRwntIthyzrJBLUu/oq4+CnpaAd83w?=
 =?us-ascii?Q?xyyBZGzABvtnXwzvLPc4ACFLxo78H3by/O/2wFHghtMQNHhZ7+s+I1afdYrQ?=
 =?us-ascii?Q?a3oxwrI1V4J6XKU5kRZVBHslEu4cXUhroIaLInzIVpQ+xKUfW8IMdAKrSlI6?=
 =?us-ascii?Q?qXLQeVyyi4jbcEySP+s3z9nrSI0HtVugzihR1Zcwus6AFcpjAHUiCydSnrsu?=
 =?us-ascii?Q?LrHtFB5NtNh1PV9IZ8A82D7UeuopkLmZtMWyAqCqrsz5B4FwAya47Q/IxPLQ?=
 =?us-ascii?Q?8tifmnmuBinRt2nm+7Nq0XuF5wwCs/KlNdmVXMbTe9allp+zwoQeo9mi9FGl?=
 =?us-ascii?Q?V4p/JTkthfEYXoQ+D9zJ8ge5ayRyPyWQZJKJrghVpnt6gDxArTDfwAeYMPt8?=
 =?us-ascii?Q?PJP0WnYJ1YUHOJYg/SdBtOwP3dcxdsOKreWgdEA0NOpEYQXtXbA4udHvbG77?=
 =?us-ascii?Q?4tFG7VV46k4aHIRPiXLG+8doFB5gRKn3obar9Gb0RpC0cta1Ztug6iexH1TX?=
 =?us-ascii?Q?LoN4QD3PAkBAuEViQP0RPngjIPxN8b28Cd/W5aSYlV3LkbQ5n/ykLzOMGIw/?=
 =?us-ascii?Q?4APs9sHwycF1uKbZR3or+uQ4u6R48hIpDaB8+84BpAqqUm3wDHIw13c0GuB4?=
 =?us-ascii?Q?A84iMJs9MneArBv3R2jExWRDJkLwAsCdU+hW1gtVx8BUoH2aV9NcHafMcRJt?=
 =?us-ascii?Q?/Itf5En7i7mj9mFo5fQDxZ9b16UBcUjZekp4hHFF7+Ptz1BR8J6j7m4Y7v2B?=
 =?us-ascii?Q?9a4ixOe2onzPKRwWHNfcaD/ZE2Z9bP7x+yQ5RE30sw4+9aC3OtoNx0xR0fXz?=
 =?us-ascii?Q?L9AhUqQ8Hnnh/si5GC1WEpvpNAgaRgg3ZcVXkgHVM9O/VCR8MyZwd7q3Yyi8?=
 =?us-ascii?Q?2PoscEhHdKYSv6yveRA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b926518-3cab-46a2-ab41-08dd8c996483
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 12:27:40.0676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9vAPfqfZPPt1UJVnlL5ct/CZrFCSCoyIhv/VjYgNzXCvqjMDlyviOz4thF0fNYr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Dong, Ruijing <Ruijing.Dong@amd.com>
> Sent: May 5, 2025 10:46 AM
> To: amd-gfx@lists.freedesktop.org; Jamadar, Saleemkhan
> <Saleemkhan.Jamadar@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Dong, Ruijing
> <Ruijing.Dong@amd.com>
> Subject: [PATCH v2] drm/amdgpu/vcn: using separate VCN1_AON_SOC offset
>
> v1: fix GFX10_ADDR_CONFIG programming for vcn1
> v2: VCN1_AON_SOC_ADDRESS_3_0 offset varies on different
>     VCN generations, the issue in vcn4.0.5 is caused by
>     a different VCN1_AON_SOC_ADDRESS_3_0 offset.
>
> This patch does the following:
>
>     1. use the same offset for other VCN generations.
>     2. use the vcn4.0.5 speical offset
>     3. update vcn_4_0 and vcn_5_0
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 1 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
>  8 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index cdcdae7f71ce..83adf81defc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -66,7 +66,6 @@
>  #define VCN_ENC_CMD_REG_WAIT         0x0000000c
>
>  #define VCN_AON_SOC_ADDRESS_2_0      0x1f800
> -#define VCN1_AON_SOC_ADDRESS_3_0     0x48000
>  #define VCN_VID_IP_ADDRESS_2_0               0x0
>  #define VCN_AON_IP_ADDRESS_2_0               0x30000
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8e7a36f26e9c..b8d835c9e17e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -39,6 +39,7 @@
>
>  #define VCN_VID_SOC_ADDRESS_2_0
>       0x1fa00
>  #define VCN1_VID_SOC_ADDRESS_3_0                             0x48200
> +#define VCN1_AON_SOC_ADDRESS_3_0
>       0x48000
>
>  #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET                     0x1fd
>  #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET
>       0x503
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index d716510b8dd6..3eec1b8feaee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -39,6 +39,7 @@
>
>  #define VCN_VID_SOC_ADDRESS_2_0
>       0x1fa00
>  #define VCN1_VID_SOC_ADDRESS_3_0                             0x48200
> +#define VCN1_AON_SOC_ADDRESS_3_0
>       0x48000
>
>  #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET                     0x27
>  #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET
>       0x0f
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 22ae1939476f..0b19f0ab4480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -40,6 +40,7 @@
>
>  #define VCN_VID_SOC_ADDRESS_2_0
>       0x1fa00
>  #define VCN1_VID_SOC_ADDRESS_3_0                             0x48200
> +#define VCN1_AON_SOC_ADDRESS_3_0
>       0x48000
>
>  #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET                     0x27
>  #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET
>       0x0f
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index c6f6392c1c20..351afec0fc82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -46,6 +46,7 @@
>
>  #define VCN_VID_SOC_ADDRESS_2_0
>               0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0
>       0x48300
> +#define VCN1_AON_SOC_ADDRESS_3_0
>               0x48000
>
>  #define VCN_HARVEST_MMSCH
>                       0
>
> @@ -614,7 +615,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>
>       /* VCN global tiling registers */
>       WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
> -             VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev-
> >gfx.config.gb_addr_config, 0, indirect);
> +             VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG), adev-
> >gfx.config.gb_addr_config, 0, indirect);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 139c83bd165e..712e1fba33ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -45,6 +45,7 @@
>
>  #define VCN_VID_SOC_ADDRESS_2_0              0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0     0x48300
> +#define VCN1_AON_SOC_ADDRESS_3_0     0x48000
>
>  static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] =3D {
>       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index a8cfc63713ad..558469744f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -46,6 +46,7 @@
>
>  #define VCN_VID_SOC_ADDRESS_2_0
>       0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0
>       (0x48300 + 0x38000)
> +#define VCN1_AON_SOC_ADDRESS_3_0
>       (0x48000 + 0x38000)
>
>  #define VCN_HARVEST_MMSCH
>               0
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index d99d05f42f1d..75c9e7091558 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -533,7 +533,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>
>       /* VCN global tiling registers */
>       WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
> -             VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev-
> >gfx.config.gb_addr_config, 0, indirect);
> +             VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG), adev-
> >gfx.config.gb_addr_config, 0, indirect);
>
>       return;
>  }
> --
> 2.48.0.rc0.12.gaaf18a9a82

