Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17CBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 17:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88AD810E559;
	Thu,  6 Jan 2022 17:21:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD0010E559
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 17:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJHxIT8cVKlQk45TQB1Ps0U69jUNFrAVy206vR1cABrDRdA54BnrhMcpYnh1BhvndEdMlot/prnXPJisuJeRcyV+CfOv8izP9k/4PdHE0zTwz3gZSMfLRgfffT0+R+sEpwbtk4/jNmucKNWQFtaMG4ci27g4PY3ooh6LznMxJetwgD90rjlTzYaGioqE+ug3Em3qQJPkB0WDYD2pqzuH5zha6VOgsZKQL2ZS/R2g7MQIyoQn2nbBCvbUxpaGkBnKfDdO099gT3j6vddfYh/eS5O1tf+bBiRxtU42xPbLR4252HAFoURv6Q4fnxawgeFaPJRh69By9Xp3/THdFMFGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FVnqGHQUU9YtKLDt2P/minBykglc7hW96bswOiVvLk=;
 b=US3xHdw7TxUDobrZ4sgbU6y/x9OOqrIrd7XoiVMIoPm7Oo4g66pOHj7YLd38SRwDxJw3usY3cxgmh/NbyiME31G+Q7ShqIITX4syMwlIDKi7RuE5At8eUCZ0Zm810PIb1oyYfrDOORfwizKNhlia9Lotrz/6h6QWdXyNRAi+xVYPPKvWsyJOL5SBNYGzrkDdjUwNuy28hBAsr6nxIWH51zSbCm8xQm9Xl7iBjz4p60ccGGwy/7R2GP2U7HNyL/nnGRaQl1cEING7gMEDLobRVwyx6DhvRGvCydPT2DTYhnK/J0IcixLSdkZyfHqo3yd9Wz9X/KCyiXAZnoYPGNopnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FVnqGHQUU9YtKLDt2P/minBykglc7hW96bswOiVvLk=;
 b=XAb3b+oumEhgSGDighVw1W/96M4cwUtl+WZ09KloKw3oB06oNxijHnUNBH3/p+V2s7oWUCk/CD0HTo0H0XjNSWk/nol36Dg5eGenvw/vsOduRtsnjRi0JZy0wi3Zm/ZMTehZ+fuYEZG47VKtmtoOmyM/4QD9ybZs0h/01d4W4lM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 17:21:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 17:21:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy
 Flounder.
Thread-Topic: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy
 Flounder.
Thread-Index: AQHYAs9D7VAUv8IW9kW5L42uAoZ+I6xWPSaQ
Date: Thu, 6 Jan 2022 17:21:13 +0000
Message-ID: <BL1PR12MB51449E0379D8A2CAA705D2A1F74C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220106073000.14878-1-PengJu.Zhou@amd.com>
In-Reply-To: <20220106073000.14878-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-06T17:18:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9405054d-906e-4fa0-adbf-224677a10997;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-06T17:21:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5474fe3d-4c00-4733-be0a-9f5b0a16948a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d53c149f-0066-4a3f-092a-08d9d138f0a6
x-ms-traffictypediagnostic: BL1PR12MB5287:EE_
x-microsoft-antispam-prvs: <BL1PR12MB528713C2600DCB743873F02BF74C9@BL1PR12MB5287.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8NItUr81ORXrAN5sMBvi7P2jSy4hn0DDkDF7P+VuePvKdDWzlpq1KtYSHHwcJw3g8C/u2L1k/ZTxi/8Y3nEWfst8HeOsV0D9/WiZt2Cxnd4imOW+9yTvA+6Q3cVaALPxxfk8Yu464XnUO0/TtYJEd0dRprRvEkj5+KpH/FpsgoMxIBP1NX61e9DbXp6nVsf1gcE37uwQjBSnfg1hwcdnB3cnLem4KgG4jVeUePkCFygGIm6bDRziyDwc7Ht6xYyL/VckFr8VSBYE1CuD5Y02VhLjgS6xjH2/OYm0MX7rgLXmF3aMpvs80R3MWTxPw8EuWv4gmx9gSXhGv+JMGbXiLCndwfeNNI+45cHLdfYMXBA9FO+zsv357GxCHVLxfSiWgeyN8GbUUFBKpc0PdaIyGjpimcgkNJZ3FgEHmcQcus4ISIHjHl4fDb83OqekY/CH1/mHGw9qc15hRechoVcK6IpUE7CqFH3QcIvJO4j+DTcX104Crhae5nQ5mYsxaZ3AvDv3ZxA0FlkGFWj6tKKD1o09xv/Zf+Qthzxx/rEqc6SKIVwL68k/I8ODPBMEkqRwwhfIxLSQB5Jq6U/an2OQuBqFHfkLwuynxmtgQaeQ0XF8ze1Q8wuaA3RVa5PQJ6CruTmPZ7AuO8jn8tiEQzJHeUKdPHzNKz3yKzVphHwdji2OscGNa2bOp9HGuVV5D6eN4XD6zqw4htmpUAYJcqHFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(33656002)(38100700002)(122000001)(76116006)(110136005)(316002)(66556008)(2906002)(66946007)(66476007)(7696005)(64756008)(71200400001)(66446008)(52536014)(5660300002)(8936002)(8676002)(508600001)(53546011)(6506007)(186003)(26005)(9686003)(83380400001)(55016003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OOcnHyqhZmW76HZwef+oI5jhDLuxnf9ypmZFRKdjbbGmzcmCV7E3Z1fcmcgc?=
 =?us-ascii?Q?UiSQ5wsiBm52YKxTOOMTmm6h4MgmrwkbBByrVyFXCm0w0M3MTaCTSVRH0pYt?=
 =?us-ascii?Q?6T8D8EkJzkASF93QgQWpM8p2Szt/h+YLW3wnW1WOMn/G74fT7cqw05+p2vay?=
 =?us-ascii?Q?gZIaZV2s5Y22eTAjtLQJ/g14bgddLVekGpdIunVL/hcD3e4iJVknjahnKwTC?=
 =?us-ascii?Q?FAV0XveuHmYlccct+a633Fpdj1/5un1HbEu+TMHAaJcm7wRNufyuBd7pZdcG?=
 =?us-ascii?Q?DkiRGeZMOfva23rTZzIxM/fZWVIfXkJM3BzgqNMM8GQci/zkYPqCYnimsFLI?=
 =?us-ascii?Q?qZKUrQhE2uE9YuBuh6tZ/Rp7Mcs97uyHm5Py/ZXWxE2jOgLQ7Lcm0dLaArC4?=
 =?us-ascii?Q?rE6IeDauLXToo0iLqd+/WunSxUu7RJNKOGZ7ICh00F/epLL0bc3sUVw0vQ2K?=
 =?us-ascii?Q?oyYnSn+MxUEUWje0Gm/c0LYL3Jtu9wCDMDhjoIpkWwHkIT75gDybMQnETdVG?=
 =?us-ascii?Q?9pkzXU5jx9pKXbYiShYKzeXV8gwIw6MEJSwOUEu3jnPorgeOC8h8y8v3dJf2?=
 =?us-ascii?Q?D2So1gMhKJM5RzGpLwNwYyNGIvOLcAcyih+rwP+zqCH5ctHNwQzTgVO9g4Av?=
 =?us-ascii?Q?nQ7kJ3/pSeY/M4a3sudQtkdnGUSbmwYP4PK3FskCMn6ogPia8gcj19gxwyy8?=
 =?us-ascii?Q?qdv8KtWdfj185TnwjkuD7TcvS9KhukXM9KqWVs1h+nxmasm/vqfQPP0eDGN0?=
 =?us-ascii?Q?j+2VZ8wI924a+siTwNedp8QU2jVNZmp+IZdTg2tBJhCWMax4NLYpLD04d9cj?=
 =?us-ascii?Q?UHECRIITYLTLZfoiPmlWYLaWNv3fDecGan7vnrTObe3/DurFO2SNg8XDqFxc?=
 =?us-ascii?Q?CM2AbeIDUa7+Fg7LeXeyUtyt4aA1lXqB6B0puvNLCDGp7UqXwEBmiu6tf2mg?=
 =?us-ascii?Q?MfK4PMIMTSYDf5alJbYMtB5c9uq4bKdvaPa5rXv27KLSxuRte0pL8HSILLu0?=
 =?us-ascii?Q?IR/0tmsR276iAJG91AJjnCbogzBzG6CmhXv62QbylkLBJLEJab+LJwJ4aUi6?=
 =?us-ascii?Q?IG5PVOg5KW+CD9nKevko3shbdccOvpZF0TPH9ciirtopbPjMzEpl8IKqIct4?=
 =?us-ascii?Q?0c6F4+UfHq62cF6fDO9MCkcFG3NMdX/1UU2OfLhBTXuh6q5vvT9Qmf9wUWeK?=
 =?us-ascii?Q?kBnmPIIfAnKqaoC81vU3gurFRyaEK8FBOwYJWKDCLtsXD76Nd5js0PV4kx+b?=
 =?us-ascii?Q?SEWoE0HQZUt5VJcnCOd2bnUQbczI2llQvnkQsGCZuOPxWCPK6D84pzcHaWTs?=
 =?us-ascii?Q?hdni6d5T+MaFCBYabxNm5UsXskd2LZD1DysEm1nOBeIEkEyVYTDOnRHRTd5g?=
 =?us-ascii?Q?OZByLd0s3Q6Oju9LfGjrq+sAhE56ilpkBK1gVifuHFUnW+deXmDK+qBF0ZsR?=
 =?us-ascii?Q?Dnu5EK7ZNzBvCwUsSaq3IyBVyagRKI3yKKZ9VmOU4cpvlJzCYBajTHaKu/1M?=
 =?us-ascii?Q?1GK9cZXNV7rKOYSD9t/kRdjkib/Jtht5mMvRtIoWS1HGX1vx9cZhFMxhVpPo?=
 =?us-ascii?Q?CClQ4yOhqJvvFYzi9HJFP1JfjR+bAlCxNXsNdN0i3dBEzsXnsMB456VWDF9o?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c149f-0066-4a3f-092a-08d9d138f0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 17:21:13.4797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdi3jvgn/NueZP7vv4Fz7lNhSUMyvn29kZpgntRF843I9MXTKxLBTL9N2N9eFnR9nBOBnJFYk+SjgNYWAdu/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Peng Ju Zhou
> Sent: Thursday, January 6, 2022 2:30 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy
> Flounder.
>=20
> Certain Navy Flounder cards have 2 VCNs, enable it.
>=20
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 580a5b387122..57e001d73ec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -550,7 +550,8 @@ void amdgpu_discovery_harvest_ip(struct
> amdgpu_device *adev)
>  	}
>  	/* some IP discovery tables on Navy Flounder don't have this set
> correctly */
>  	if ((adev->ip_versions[UVD_HWIP][1] =3D=3D IP_VERSION(3, 0, 1)) &&
> -	    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2)))
> +	    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2)) &&
> +	    (adev->pdev->revision !=3D 0xFF))

We added this check because some navy flounder boards did not correctly set=
 the harvesting in the IP discovery table.  It would be nice to sort that o=
ut so we only enable this workaround on the boards with the bad harvest tab=
le.  I suppose that would probably come down to the PCI revision anyway, so=
 this is probably fine.

Acked-by: Alex Deucher <alexander.deucher@amd.com>


>  		adev->vcn.harvest_config |=3D
> AMDGPU_VCN_HARVEST_VCN1;
>  	if (vcn_harvest_count =3D=3D adev->vcn.num_vcn_inst) {
>  		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
> --
> 2.33.1
