Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12E7C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164B410E0D1;
	Fri, 10 May 2024 06:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLMqGwWQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4384B10E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeXtf++BrzuKJ2KdUtcWyd7RCnAKNzfV0Zhp5YVn2GbefjdGeCnYhg7PzacWzyLQ4G3yyPQsvA5lyfE++peAlqkzKH2E6ESfY6WaeA+0O3LJH7mQlo2rIu1ch05ganWA90UMS1x6zXO8EjrcWjltF6eCvHc/PbE2797V8ScK3GrEnhNjAGHkWcE9y3Kc5WacLKYm/lH8aDnA3y+6DX8dt1RdFNZenqnA1kwCzjVJN4D/YQvxCtP0/AES/Qa4rqeMxgeU0AAk7yAyZ6x9KEb9Jl2CJCXfjQs4v4ElPx6o3++2dS+Le4CM/tvnEZYS/Elp0V8g/v2X0RwnagTjLfCaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cODV6AAQeZsyi4KYsQBrVlxhpqwpAf6ZttUJX/bWrA4=;
 b=CCFm9jsTUDUAKpOqs4kMszOiuHQ40FrRUzrzWjQLxV3gS/43DPFlJMyRvagHv8vZF93I/QsMNY0YHTnZSSR0QzdkjqsBj0uEiwbM1xMqT4jeDvYTJeWNUe/AIKr4MuTrXXy3oQPtF5p3i4UMs0ek+R2kKlcPgkN80J63rzPe4XcPpj0VCAlXKJ6XBUIjAp6NGNJOFANfZSXnxwcFjU34A7y4jV5IMVu4p9dc3sM06RgyOX+IFq1hETqJylCTMB82PvrlG5Qskgl9k+y/n1FJpJI+5nAAVOJNbGe01BeamoUtj/xYFqZ9MqD/eJaXX3iXae7Rnq9acImnJQOFTEsDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cODV6AAQeZsyi4KYsQBrVlxhpqwpAf6ZttUJX/bWrA4=;
 b=bLMqGwWQCz/Ar5G1PvWXY/XJ5Uvz6cUPmdX+BGS/+4AGHMXVwWKimo/AMIhofq3pBUNejy7/E2X8W1OZFVO/26cPwUxE/bSTVcTVAfAwPHYszQRRpb5WFAzb2UYICB9yWhc3T6e3yjFf0P059GaHKgx2rt0tUc+b/0Sv89AqcUU=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Fri, 10 May
 2024 06:05:59 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:05:58 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 01/22] drm/amdgpu: fix dereference after null check
Thread-Topic: [PATCH 01/22] drm/amdgpu: fix dereference after null check
Thread-Index: AQHaooTsdwJXqWcA60ea8yFNv2AxlbGP7uyg
Date: Fri, 10 May 2024 06:05:58 +0000
Message-ID: <CH3PR12MB8074DEBB3D483BB06CB421BCF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2a049390-76d1-4535-873e-6ec5643cb149;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:21:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|LV3PR12MB9439:EE_
x-ms-office365-filtering-correlation-id: d2ffd9cd-6427-4c14-9271-08dc70b7431d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rXDKctbmmb4oEMTKOPbMfc2YTuSYoxkW1R20LYW4E3eHYvPjMyPN7XMWbt?=
 =?iso-8859-1?Q?NZigOOtBSKslCHXYrW+BO3uNn9+QZ210nmH2qliel+y1n5RW/d+YZkwrmM?=
 =?iso-8859-1?Q?KVfKjXfBJm+0zPXHPIbDzKtW6zWGVfSnyRUowAJBrLol1GCdLICMaEQJ47?=
 =?iso-8859-1?Q?uKjb4wTI0aIR6t9xS2TaoLWefN/ukDJ7iFXK4aJGdTzdjmwoOEFXhQ65tL?=
 =?iso-8859-1?Q?03fGFHqhHO67KB6Tuu1mnJFQ1ki7RUHC3uOgkt0CNDTQrVUEggGOehjh+T?=
 =?iso-8859-1?Q?CrVccKiKoZpqEBWeuTSFzIayHixlU7JwwkKcM0DIchPHUqbtxpKEicKbXI?=
 =?iso-8859-1?Q?Eypjcr8wKu1NnAxCJOaG8Krb3DP17E/V2FOYeKK/3KG7JjIpy2Q2D1gHlq?=
 =?iso-8859-1?Q?lr7eR8cRWDt0lXwI2KV10TsUM+ilykK1/ExiJycz10bAoj495Ii0zyE5GO?=
 =?iso-8859-1?Q?GqiKQl0elDLqTUyBbwReFVMrPA25WGVkWvrA/x0CX+lU1BqNXglXgibCKG?=
 =?iso-8859-1?Q?mLmNVLURuqzZ6QlJHV93pb075a+fhgTrlDTsmI0LWw8BXeDodeAGlLoBcE?=
 =?iso-8859-1?Q?nHNB3Y9d2tq9iLjONWCXYA3GrIGP/OYKI+GLjp+57Vbs83bC2Prtx4WBjJ?=
 =?iso-8859-1?Q?QPLLWmUsAgcjubji0OX/EyBGaHZk8ICW+njVw/DmKmCqeGWOJlYhY1kNfE?=
 =?iso-8859-1?Q?53B14IivxJ/6gXTw7JsyAoJoCwC4aPi7aMFqFHyCDJ0XQeQNHe9gI5JMFL?=
 =?iso-8859-1?Q?ynk0ZaNhphjJK1+T9t+pmKbxmYh2xjK6jiiIpbqCIYEbrWphdh3uyPB1yf?=
 =?iso-8859-1?Q?C0kuSfyw2A+MKqAUCJ51D7gfk6S/Hg8ijKAB+5L+byqKK08lm8YziYYEDR?=
 =?iso-8859-1?Q?1KGOKQjKWO9YE/qML8sXtGtchTHH37xbzLxsp6qYAlgbr1eRNEj7S50ycy?=
 =?iso-8859-1?Q?XS2YF5cCBLrtzC6FmFacE51Ftho6qaKMca9Tol7Flk/5i5PNwBckkF2D8N?=
 =?iso-8859-1?Q?TEqf/M6/VIdsgG55Wq401zX4ZH773LAmGdptz5PMd+LEtQTFFa47CoxQ17?=
 =?iso-8859-1?Q?neCNkVgR+emMDhAq4nXKw50mFJXqtjERaNLQoEynuQ6oFYNPGvpfAoqD+u?=
 =?iso-8859-1?Q?zR3UmPbsYb7Q3QfD0HGwiC5PhPeCXnmEl3b6BrHJ3yJhtgJO9Aqj0tSX0Q?=
 =?iso-8859-1?Q?qDTiDnkZzLCE1SkWo8fC3HyVNDRalpwsNx7hD04EThJbiiQsZcMSAISADn?=
 =?iso-8859-1?Q?pc7hNGS4sCxs6lkDH5L6UIjdBnz53bJ2SEn1b+cv+A3NyE1igKy8L0BOMY?=
 =?iso-8859-1?Q?y+dr8z/cSAP3lSmNpbI1EOP5unIod2v9MghIW3nxLOcZCkXSKB3wkJz3XE?=
 =?iso-8859-1?Q?t/HsCXPzWe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2FmWyYpePbUw/70pM4AdBOMJ00Lew64z3QuSnLqHpuXjUiXOL4UNMS1nBt?=
 =?iso-8859-1?Q?CmdQcUVy1ozcx06Ig2rHUJh1NFIY5SMXtPTkfI9ByGxWk5Np3PVXX9YPUM?=
 =?iso-8859-1?Q?t15nYTsCkmh6k6xlJslu2DvsLyS4jdW9KCfi48sChlUt0lQwvR5dU+AtYL?=
 =?iso-8859-1?Q?82mQcZWQD0XoFiFpTDkhPEWwKxkidf+ZyiApNhWNYldWvN28wBGBVaO6el?=
 =?iso-8859-1?Q?Pqf8P2OhFvhLrZlAx7eNOBFboWKcnX4je73tKlYPgfAVzFtyjnPPgAOOgk?=
 =?iso-8859-1?Q?b7L2j6mzQZU27UjVuHGa7oqTTX2mVu/NuCnwfQ0D0SQCnz9KbfcNhDq4BH?=
 =?iso-8859-1?Q?XyA3Tqdb/iWDQRR8SskuM1q+ceEdmFIeNqf0w4oX7Ix/xyFakHa0cuxAgJ?=
 =?iso-8859-1?Q?m6Q+glHexV46QGOXHi+MAzdSzxlAPAF1B5A7qwC5zQNlRRpJrruSOMRYGF?=
 =?iso-8859-1?Q?G4euByC/0dIliax00uSnc3hH+2OYv6L2Q1U+Gv4vLqbfhdwdsrzeP7NKBS?=
 =?iso-8859-1?Q?3nWdQq3AoQMJsTqzrKo8LQBfUyUtavwiyjHi9Cydbr/yuL+N0gMzqyLEFL?=
 =?iso-8859-1?Q?QTMEKBurI2VAarYLqR7PG0UA5WuG4go2rPaTdgtiCDJU+FQpvCe8aQ2LCL?=
 =?iso-8859-1?Q?YFkUtrBCPbDLodG52B6L2ljELioBMoDnAJbsckAUiMxwGCjnECghjZ9O0w?=
 =?iso-8859-1?Q?T6ai0Zc3DFZTlwEQtBJWn0DQCOX/ip389GEZ5OoRl50CkUY0AaEsq8b+HH?=
 =?iso-8859-1?Q?t/evqzmAyg56lwIqgLyaYpoC3tO5T9cli34TQnWmck/R+QikyJYQzKIgHA?=
 =?iso-8859-1?Q?ecApGBEOMoTjQtXCYT5g2FPFpxkSu8HlEbQY67FFWvKnpVC0DliBlFlI1F?=
 =?iso-8859-1?Q?JkUia1tKJS6fmu/lwUj8g1mgff4ZVDGi+cs1N/DWGyjvXYgIwH0Bm6BljS?=
 =?iso-8859-1?Q?J236X94ruXLbxHGYm6cG4+N1OHWtwIvU3XGG+5oZQNhOkxEh0PKvVyYiAz?=
 =?iso-8859-1?Q?cgaSXz8/ki8kEzLNQgy/NtCE8Y42ouMVY8etUdYHsomCZ0gY7hZDBZSG2Z?=
 =?iso-8859-1?Q?LnjDtA3+BhKaD2jQsP1xh39zcdrWcCIzH/HDcKC5ybDd8MUP3fnku3Vy2E?=
 =?iso-8859-1?Q?iH7GAsTwJUT1yEImcz0ncRL4ZSVqSMGGqf+SZsNPTBdPQ9mH+S7qFA3p4L?=
 =?iso-8859-1?Q?4LHNlKCr/EvHy02j6IGCZjwPHaaaSHWutLwvlGL9qDcf74lepDnzBofQAi?=
 =?iso-8859-1?Q?MwyipSjbtdBRQsjPY6TRVfBCzamaOCkY2y5mfo+LS2Rj4FVw7TeHwqAEkE?=
 =?iso-8859-1?Q?YGscQnuAlA80m5SYlwI11F71qb+4NKkJfAid5j0VHMgeaxrEPi9EfFEl9s?=
 =?iso-8859-1?Q?6fKWyn/mroxk8m0DVYbDrSB+H2gDShO0org5y7eCwpCk5VP556W6TMr8UA?=
 =?iso-8859-1?Q?h4hbWHnacsoWWLp6hRPw/JaZgPaWruzEdJsh9y3BtFwX3Ht5svFJwgL1rv?=
 =?iso-8859-1?Q?fHLPni53o8NjZ/H232CfX9/5pF46wLr4QtDld5oLIO4U1Rqy3dBrR4zQj9?=
 =?iso-8859-1?Q?j6bExLJl+riVGrZF5JzyN+6sRtFNxRMcJH09kfD6Dt7VRNizZcL8JqR2cA?=
 =?iso-8859-1?Q?yujqlH7BN8t5w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ffd9cd-6427-4c14-9271-08dc70b7431d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:05:58.6827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAhldrf/QBdADd5Ka7IzNFNSzT3vuY+ywb6Cu9vp1vSAjJR4UtQTz4oMws9knT8gL5EeBbw54VzFHL3r/MihPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 01/22] drm/amdgpu: fix dereference after null check
>
> check the pointer hive before use.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 77f6fd50002a..00fe3c2d5431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5725,7 +5725,7 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>        * to put adev in the 1st position.
>        */
>       INIT_LIST_HEAD(&device_list);
> -     if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes >
> 1)) {
> +     if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes >
> 1) && hive) {
>               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head)
> {
>                       list_add_tail(&tmp_adev->reset_list, &device_list);
>                       if (adev->shutdown)
> --
> 2.25.1

