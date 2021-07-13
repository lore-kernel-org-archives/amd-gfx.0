Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9E9C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD16661154
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD16661154
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5739C6E048;
	Tue, 13 Jul 2021 07:14:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B5A6E048
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3boGxrUI8CYW6DPSWf4+Q3/kvC7eRgvjuVPwdJG3hF6dhKcRaGd11tjS3ZVTGG93adkUq0c8qimL2qgo6SWU85fs9aXpkViTq1OgP73vbE1ItLPinzSgBULGv4SmZpjLg/pzFLXA4kSqBO22gyHUdchMJabRAqKEFM1ZstTNtauotFLHZ4AFn4/q3lFzZmj+6cM042QXdxuPgYUBbfoCPnYH4H3N3Vp5ED6+ARN7KMpxzAVrz2fIQhmBDfP+UExEDVOsonwhJr++wtjnmesvDID+k74KVyuHJXtXm3sEJ4g2gjRffkYEmG92VjuM0RGJ/7Zee541Mk2JR1YVsR3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqpPSHtx4Y/5hTNxGxImJ/g83wZP7AhJutxA1J1SqNE=;
 b=hBwmalujdhDB3Tdwu25UPqAvllcnuexYloRdGYZCHhiELv8uD6c1/uFcC5j3WGvRHRiWsiqxITH3kl5BO/55msj1khi3Gbred4qjIhnSQwDXz8ri7O51+w+56RzgAlrh9P0k1o26fRUSHbGJ5er/5Z8iGNHH4XZH5Jggxsu8NR5Y4LT2CaKxXG7ReYgAPiq+FjMLqlXqMGUrwYgQcCZt3jBXZN8TWIQZ6Ae7VXgwPQeuMNo0PPQYUJiz6oDPdfH/7OSlXYYhDG7c3dJjVGkn/oHMz/+aLAthh6eG/r8hbgAIPZy6iGhhAOI/7lFVXJ13SamF9i299IBlmYlNqaWGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqpPSHtx4Y/5hTNxGxImJ/g83wZP7AhJutxA1J1SqNE=;
 b=Ji/VVCC8piPsOyb/TcF0GMz0rp3+juSi2XqQtq/dnNg93DRQOY83TuBxXZQf4BKQ1ib+vQAB+osBgXZZIyM7fbF1mhEIc2EmplDqr/Z2C6vq7fjaxgXGWvMoXIkhaEmLUJGyz9mtucLA8WwOVOp8egB8LLZl0suVTngcxU/6wkc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Tue, 13 Jul 2021 07:14:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 07:14:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add waiting for response of mode-reset
 message for yellow carp
Thread-Topic: [PATCH] drm/amd/pm: Add waiting for response of mode-reset
 message for yellow carp
Thread-Index: AQHXd7TilMyXk+rQak2VQsE6R5Otj6tAfekg
Date: Tue, 13 Jul 2021 07:14:38 +0000
Message-ID: <DM6PR12MB2619093E75AB638CD21901A2E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210713070057.554024-1-aaron.liu@amd.com>
In-Reply-To: <20210713070057.554024-1-aaron.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T07:14:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9a20d0e3-909c-49e8-8d82-3d65fa1f77ec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c87f0f2-0fd4-46d4-4e88-08d945cde04a
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4959C043AE9ECBDC0AD96F61E4149@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hEINZEdePWSovjUlsG+bs9BTJGRcMnM7BXciWF6WBTDA+6AISAucQ40Ckac9xVAwMIRfJW5S8PWzcfskAsNHS3No/rHFQzhtkXZh+XW4DCyf0ULmtN37IR50BubIpmB6UDfzLUjdA8KW9t91BHNW6NRrPn7fLbCAakuS0EnzLJCKNDyPUqow43FabQRhNUf5ttt2G/Y6rqRXedK8P7bv4OFhuqFtk9gOxvnBppJMToiWCGbRcsh8romjam7MO+7awuoLSiiLOTmAeUUB6+bc5dQ7hJ9zP6aJoQOsN6fCUFccQEi2/YNeoZI5V6J6qs8horXVbYhL7cg+HHVwwk/8S2p+1MGexOgfs2sJfD2osJmHkvBTLSLh7ujRsbZBe9k0J8fmQyyJlyTDs0Sw/lzg4KNeKc0fLVieqhzgtsj0r4POlX0rx4gdLb1rI4fCaT96U40GaVpYaEw9FEE/L+8eUUL5hgQlcC9NzBR/ZhRUlBqLbENtTlC8jH920qrXx8C9xe7sCgNhTydS9COohGzr+oQsfkq5+0WdXQ9FZrY/91p1UqnMc+Uosg52Wh+a0079SidqIiBcpKohCA8yI2OTCEbVBmQe0RKf5UEyLgRq2IC2Wh3yrhcSiYN2Z6r5Rd2OXrFfRoDKC4JPk834ar+fbXiPzZ3X+DftKLgqj0c6IMYlbUNnpJD4rC4ttPLB/ULnbv2zRgR/jRWSj8ztNaUlRPj1RxwNyLvEAmi9AbtGQEj1BMWmcUvI2nVqxx2Mu1ED1M8NF36ziF41ChxrR7gqw/sRyXzvg9sEB96fhv1Juw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(2906002)(4326008)(86362001)(26005)(66556008)(64756008)(8676002)(66446008)(45080400002)(66476007)(9686003)(83380400001)(52536014)(76116006)(71200400001)(186003)(66946007)(5660300002)(38100700002)(8936002)(15650500001)(122000001)(316002)(6506007)(53546011)(110136005)(54906003)(33656002)(7696005)(478600001)(966005)(55016002)(69900200002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07X5i8HZo4fEGqCEKLOp6g9jI3E7usnoQ8IZmiPK+2zcZTk5b3oNFFuMjaj1?=
 =?us-ascii?Q?ajxvKyFaVzBmH0C1u7Wmz+AXJKj4CrEkz0cl/amTqI3xpZIySvULZruU4blp?=
 =?us-ascii?Q?5qx4BXM1dieI3djkGpHptrjDvF6jM+QhZEXbRsQVp1Vr7JvibnB3HEBJ7Kjc?=
 =?us-ascii?Q?ZhWxksaq4rGYVmQLMVSFAGmbdZBQioMBbOo+/jtq8i0Au3d5O/DpH2SH0nC1?=
 =?us-ascii?Q?2Zf7l9OIAadpAJfyG3+rVkkCHtx9uzp/5ErY/KuQOtmYdJave3Z/dATGgP5d?=
 =?us-ascii?Q?XB6H+0xStMZIkgQo0rOxrxt3bqCVnhM4BNhqWzBamVStXs4Ag9JE7MNpZu9h?=
 =?us-ascii?Q?9/75Mlxey7uVtcXEj7v77FA73PZpoyt8lZErB7w0d1qjQYMozge2NIvyfeXk?=
 =?us-ascii?Q?6csfv9+OUf527J03sQmAnpZ1Px3VrwICUtHIwpliqtXXusYuD+dI3F0qIvF3?=
 =?us-ascii?Q?yBpWmGDLrgHbOFsrGcB4BbMkzEDZMfEik1XnikJSVvmCFwcwseuEFGE7pwWk?=
 =?us-ascii?Q?JQb/TJNPiqlpb/CtYsgHRJRSd3hEvKWhzs+Dba2YhWkJd7U66N3DVDQFe2QP?=
 =?us-ascii?Q?s7speTHGYfdSK/hAh7ZfvVs/JRFVxS2KjxMIItBnGzvgYyeB55IIeaaToPrP?=
 =?us-ascii?Q?aO3rgIjsQ0jBIF577OWSOyH9hqkb06i1RujCXDxRupLzFpL6COtd/9OfuY8S?=
 =?us-ascii?Q?E7cLyGdwNaQK2VjkCQI7XCCpSU5ZNVlaJH5Hh3Odn5jzKMqWDYBvmDHx20B+?=
 =?us-ascii?Q?NTkQpW5lB9sHYg+MFqt2iXb3ogsnQkCyRXF5YgSpZdRubEl/Eh/WKXQSkuJr?=
 =?us-ascii?Q?ZisxhTY+YOFY3PH97T1HUxbS+Tr8eGWmxZpApFnKrjXFh3JE/4IyYaWRNQoy?=
 =?us-ascii?Q?HvjKHq+7hEBlx49N2gm9bcq2YfB2iUYAWSK+rP0IIEl+fkzkLECYVsM/c4LM?=
 =?us-ascii?Q?qzGFc3pxF33baPECrWrr+qGexJU0Xf7quK/bQBca8RtlDchiBSYM4jOyeyVV?=
 =?us-ascii?Q?zD5XqyN5oX1mTtz4Rf1Cf648jjCwGjvL81Y49tpUE3O/tUZDAL/DGqKOnKyF?=
 =?us-ascii?Q?ZDjDU1JJCP7wP3Tfnd1/LzY61uv7vOfrcP+fHzWHgDH8tDWcSJ2q+DFumlLU?=
 =?us-ascii?Q?a2mfskvNz8AK4yqkzc82vxfT4hDiv/njKLQ+VZduplxU0KoTAHoxYzs+arbz?=
 =?us-ascii?Q?v41iqH9NLLdjeBqK/0cySLyvhbRen+S0f8PW9krdyP0ViUFqQUBsM29LEqLN?=
 =?us-ascii?Q?EB2cEYudIe5aj3FrLKjdJntoy8yLLkaOVsgtc71oPM+xkwsKDaE+tYysZmme?=
 =?us-ascii?Q?kog2BTettEGNLh3gs25MR+Dq?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c87f0f2-0fd4-46d4-4e88-08d945cde04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 07:14:38.2794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwtLCO2P3gwJAEJSmyYdic+ASd1kDFeWJzSt/D+XxFDMjPw0DhVwIn0hnzWPZ0EM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Aaron Liu
> Sent: Tuesday, July 13, 2021 3:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: [PATCH] drm/amd/pm: Add waiting for response of mode-reset
> message for yellow carp
> 
> Remove mdelay process and use smu_cmn_send_smc_msg_with_param to
> send mode-reset message to SMC.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index de92f713a911..0cfeb9fc7c03 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -298,13 +298,9 @@ static int yellow_carp_mode_reset(struct
> smu_context *smu, int type)
>  	if (index < 0)
>  		return index == -EACCES ? 0 : index;
> 
> -	mutex_lock(&smu->message_lock);
> -
> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
> type);
> -
> -	mutex_unlock(&smu->message_lock);
> -
> -	mdelay(10);
> +	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index,
> type, NULL);
> +	if (ret)
> +		dev_err(smu->adev->dev, "Failed to mode reset!\n");
> 
>  	return ret;
>  }
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C1045fee1435a4b49d
> 1ae08d945cc0427%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7617564811709038%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=
> FSmq1fObJ5x2Yl86ZWsGpr7SZPju6o4CZYyPp2xBZOs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
