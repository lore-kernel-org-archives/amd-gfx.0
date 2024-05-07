Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA6EC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 03:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA78B10E41D;
	Tue,  7 May 2024 03:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zQ3Ch9ZT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB32410E41D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 03:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRYsn4UbF0e5zL1aS8s3ifnMFROZEhJquQdUT/PQaf7q/AoA/umHCyqPl7ie5tXQEUPv4fWh7JVNAEL8BiG7UxG60Smh5r/bwlhkxjcbKCGWBZcoaTiJyC7f7lfghDU0gslwkFlKFegHp1nl1xjvK3M6/BtHObjiuySvwn7g0xGw3sofhOg0FWd2jJLc5haVOn7geBGw8nq04neH+6BiD21G+dWU/OzpAUqQTZvNsWfaIHKEh3VNCLeVAs78Rga4sMf6QCsgJmz1pKxybsTLBP+TkZCl8g6LSL+bHeQWFURBCQ+LUyz2LboU7Orkx3d1quUDUirlFKvlyAD3hA7ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGpfcyZEJH9VwN/fu5NQ5FwB0IOfTFyHuaxip7TaDKw=;
 b=Hqr82Gq40pLCBrGJGAZzD4f/1ntsqRW6ot8xjhzFHzH/06fxlJPoqGVr6SDQ2MgDr3kDe77GOTzu+aVM7dCPIBN2o3u4m/Fq+Vh6N5lIimwTH3NLvMvABJOUGqAepwWWR/R5//hgqUswf1FLWxSxInErXmEUu13qXXm3F9DTLFKFZIYXdV9r7Gfm0ODUfuqgm2j8RzH4C0i7q6qbwrRJe0xtn+/jAgZV8bDi/qsDCpHwetJCnL9RRJzbC147KVgM9elQOnPH0ezseuaq1nx5/CYFZPdvHyNVFbFrrJ+9P1fWDVoMe7gi3uNi2iT9X5v4n79OHddruS84GiPO0V4lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGpfcyZEJH9VwN/fu5NQ5FwB0IOfTFyHuaxip7TaDKw=;
 b=zQ3Ch9ZT5lDFbl5e23YDcw3tgFU0a2JiXyRTTYVzD6zT9PbrfAPqC1zj2bYUD0ixFrXSLfakrnjb0NGxqgptwNAhRLAbTr2FQHzjFcdg4n57oGiNs0eATcBzTV1CAvGHXxiMDkNVsPHht0ovfNHJk1ejQjGav+CG6qxl2jX6QF0=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 03:37:55 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 03:37:55 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix out-of-bounds read of
 df_v1_7_channel_number
Thread-Topic: [PATCH] drm/amdgpu: Fix out-of-bounds read of
 df_v1_7_channel_number
Thread-Index: AQHaoC159qBQN1mfDUWZf+vA41ctv7GLHzDQ
Date: Tue, 7 May 2024 03:37:54 +0000
Message-ID: <CH3PR12MB8074F990461379B8405257FAF6E42@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240507031849.269814-1-Jun.Ma2@amd.com>
In-Reply-To: <20240507031849.269814-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=188e044d-6d18-4af2-bb8f-0549dd418780;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-05-07T03:37:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA1PR12MB8495:EE_
x-ms-office365-filtering-correlation-id: c2a6bcd1-f915-4d6c-3cc5-08dc6e4714bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZgGu4d/6QwOV53nea+mAxS48ZUpUY9+T2ZxH0IslsW+UagWH8U1qPSobFpIN?=
 =?us-ascii?Q?MBTyaMvDhZiabj4ZXRde/m0VgSjecp1ZfmJN/duKnUVJmVkDuox+8vPFEKxv?=
 =?us-ascii?Q?N9zMXE2bTfYxEBWrqj6kVUAYzPfDw4f8HHHHvv1+Knl5xq6ObP5h5xDvLkGT?=
 =?us-ascii?Q?MuVFaryKQh7HVsCiHbgepswFZVjweGhfYzUZ3gKBx2II3z8MahTjd1WwD+5K?=
 =?us-ascii?Q?507LPXXS30Z9SsNXwvncHAIbUkJ6Mk6n1OiOJKUMMjmCooWwJPBhNddGXAfM?=
 =?us-ascii?Q?pj9u0eToxf1R6myaMEwlzUoO351AhWI0fZ3FRK0FgQl9cCUh/ShEc+h39pWm?=
 =?us-ascii?Q?Gtx/3puvuk+eRAdhjMyyqFGBPVq0FpPIBYZXyDygBD2NVcbieIqpu5rZ9CT5?=
 =?us-ascii?Q?YSFWW98VzYLPzqPNrdooSIieLvS8kyXQ1vBSIpk3dQQ3cJDgHIX+2Cj//uWV?=
 =?us-ascii?Q?J3pkqmqbo32vmKx4P63D3fOEutLAgGhIDOzkrtU9+jWLmWibksPxzb0U+BdX?=
 =?us-ascii?Q?51vCV14lQZ/mMS2MNxRGUOY2Z2oOBDu1S5/uAba65CFQdwFu/FZ3hknNQoIJ?=
 =?us-ascii?Q?yY4/QdXh5z2YVrIyUgVPeSYCVXWDrxBRzBP7MXiKvaN1+xRQSPUvQ2wgGRah?=
 =?us-ascii?Q?3KwQ0htx64oJOrTpW+F+Q9gBd0yk0v3xNgSErUJ9qqlSXpMeipKhG0dT5FLs?=
 =?us-ascii?Q?tetPimk496jcYFBp8JoaG+ci4GIAAkFaPftLWY/K46W03X6GsN5tJFrZjMDS?=
 =?us-ascii?Q?KFdYRtjZjsehndZztLnXGiQaXxBoh+oQegDI0UdexxGIuipMDXYPbinuUTAr?=
 =?us-ascii?Q?SRzze27eR4OBS7aGCGqXa/5ZvMrs/uoGQfP014MDB9MiF/2S6qFs1mOqZqo1?=
 =?us-ascii?Q?UI4K6N5s5RVv6txwR4JkVh7rJYkTrIIXd3jf48To+7YQ2LtlSpjHTmK6hJJS?=
 =?us-ascii?Q?V7BUKjmJxfDaqSkrEPRs8YZNqeKTIWB9c94zELpx88g8Kgkx9ItdNunI/SGa?=
 =?us-ascii?Q?eRarSGeLKGMun3R+RmDFVLUCsbS4MyVvtGj4DAUFzsOkU0PJIjCy1gW5RLiG?=
 =?us-ascii?Q?qxn95dfPwKEXrKsF5Wd3R9h8/OgQpyLPK/mpc8Ti0wwcyEK/z+32Jp+39F5X?=
 =?us-ascii?Q?bK+BIIqNcajFsHzao3XcakbizifGtv2WKGspp2MNAXFCa+f1ux9pXOlxb0xy?=
 =?us-ascii?Q?EbGHag8zRymNAR8jODN7XRKplgCwfeAAKQeSBDCR6+KF3t05jzZJROEcPSyz?=
 =?us-ascii?Q?zRILerFjZmx0+/b1sSyjCJViDsjRwq9eg3JrFxYGLF6qQIsEG36a9XaAj+m8?=
 =?us-ascii?Q?2o8cZPK2++C7QHiXWC06Uw6OJJCwdSnIh7W0YHBA047ewQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4z8s/VOfK0ufHVvuq+PAdsr0c4nsnKPzLVSWbGvlEtC/vdBe8q1rqUo2l5pm?=
 =?us-ascii?Q?b6hyn99TX1kEpI0VuRIAC/cBw0TbN+9ltjqA22cQfga79W0mKnBDFvaATFL2?=
 =?us-ascii?Q?NID3C80HxLs4sA4lfnArjeNrDoOS05r5wTguFL6VrSpMzFffRMTtYFNMEbMf?=
 =?us-ascii?Q?3RvV3DPRhq6aLnsLOIFeRcLn0EPAY6Dkte13ZKVObPBPnYemhm2ZFuy0FxAm?=
 =?us-ascii?Q?ISPXmFF9Gjqqb1k8Xrj5sit62sSBC1pC6HYrN31sxYi3e8PPBnSUKrEb8dOA?=
 =?us-ascii?Q?4Njo6IacQBi8fW/nteHXa7Pm42H1HK3H7/v6c45tknrlYTNvkoA7xNVYPA68?=
 =?us-ascii?Q?fbSo/sEV2tBeEqxEOEue8HYAxGSYtGw1t84EL5MjpD3ao80rde477OstPWu9?=
 =?us-ascii?Q?KG5UCDuB/NRgG65dshIhwZXFxjkN42sejIz6UXeEjL++wQjLEiNLRfU37Ega?=
 =?us-ascii?Q?C3NH86RhtoX2kPzkCX6Hitk/rfYzeyMBGd0Vqi7EugAoeRvWgdNAgmJUk3mV?=
 =?us-ascii?Q?lpVBuPzeCuQqqg+iVOTTSfvpFRqgdMvrpwLtSeQz70bpybepU8AjIVuLSGTz?=
 =?us-ascii?Q?fVm2E99Q8CEFHyeTWk9fsnyDhXsQwm799HWQmUVgTlGYrUvr7ioRef6gr+bD?=
 =?us-ascii?Q?TB8niJmEPb0ooLkDEkW9nfqheQVwXpQGTIFCZ7fk+23X4RCBasqEB7HdZoHk?=
 =?us-ascii?Q?RpwRKp2f+ZmQmFvGptZtAGG2ccEfIXqunqIUh+gmSdSpimX5TbLehYNbG9E0?=
 =?us-ascii?Q?uUohl4ll4q7kZj2OrwcFhNsunS4DimxCEqxWEC8LTr7h7WhV64PY57umvy4J?=
 =?us-ascii?Q?k4HTTqK3nGI8fwjZCAm+RxM97VscwttlhIVJOvNWu7slLxAzsxcUzU8LhRz2?=
 =?us-ascii?Q?YzwZMRf+Tc/CVBknVtuHs2bnSr2p5m8+747Fnc+Lh4yrCgmkyXPqmxcy4JXL?=
 =?us-ascii?Q?1oQOY6UPqHQuF6ZCr7mG6P3Mlps51g3POXlpKc2BS3xHeuJW3zJMjHcsnItR?=
 =?us-ascii?Q?TxPzLvnoDhPlDTgQSpdly2Hgia9mzBvnnc1IDpx1RVBWi4DtQ3JKVspFwCXZ?=
 =?us-ascii?Q?HXH9Vme8gx+VnZMqn26WQ8u83EMeztv9tb0ACbupT6Gv4I2y76fJin1odmR1?=
 =?us-ascii?Q?Z2eO3Y00qr9vyJLo4tVYNhXPvP4yntPK6B9fpwoL3y0ysifEsVNCYNi7fAOR?=
 =?us-ascii?Q?adzY9TXHM5rI0zf8GEq1VbwncGfcfr+DB688nGxhcorW7ACDGUVspWDtEGYC?=
 =?us-ascii?Q?JH4PxyLuumovm7C6oCmX9O41VdQIwEhjMqDtVChJvOP3E86k7W8IW65sLcy+?=
 =?us-ascii?Q?M7FiMM15Gqj5zYeNfFZZfqUclYkoo2orPKIZD8uv21vxb2cSXNJbkxnsClhN?=
 =?us-ascii?Q?yY/qVWs63bpkF6CEntwN2ffL+UeLZnRvLJ778tchVcM5b0C6xcEXcMOa6MsN?=
 =?us-ascii?Q?XdI8JFGOz5vaop8c/Z6l7NNppnLoBYsROm+06VmCRMF+FFAdY17Ul2EMvTP3?=
 =?us-ascii?Q?ft1maczcP4/j4Ed/w9U6EjhvGVeQAfu5TszUbZpT2Ujxrn9706NkUqUwyQ5u?=
 =?us-ascii?Q?U6l1RuPAQ5G5G1Vg5qw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6bcd1-f915-4d6c-3cc5-08dc6e4714bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 03:37:54.8753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGGTrJa8ck2NhlaJePK/rBBPealZdjoCHu2AjlswAIdFDMV6MrYb1oqiRmszVAbOm/2G9kfTusi7WsoY8w1N2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495
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

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma Jun
> Sent: Tuesday, May 7, 2024 11:19 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix out-of-bounds read of
> df_v1_7_channel_number
>
> Check the fb_channel_number range to avoid the array out-of-bounds read e=
rror
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> index 5dfab80ffff2..cd298556f7a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> @@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct
> amdgpu_device *adev)
>       int fb_channel_number;
>
>       fb_channel_number =3D adev->df.funcs->get_fb_channel_number(adev);
> +     if (fb_channel_number >=3D ARRAY_SIZE(df_v1_7_channel_number))
> +             fb_channel_number =3D 0;
>
>       return df_v1_7_channel_number[fb_channel_number];
>  }
> --
> 2.34.1

