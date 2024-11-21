Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E292D75BCE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 08:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FA110E894;
	Thu, 21 Nov 2024 08:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8Br02pi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E6C10E894
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 08:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqzr4xiRxPt+qm1UH4skTff7WTK+5JJ2BA0XWHq6Rv/wvlEKW/f0fzGX0FL8omctVB2BnC3L4yH9H1jwhU5J4LkCs7zY/kYuVZQFY9TsC62Y9TyYvhP2HJjzdzNTUpfYQ0NId82zIoaPOXunBfMg9o7F44QN7xnG8B9oXD6WI49ErJ2UWuOlg1j0skOUhZnhrJ/7VDsXwLYkNz7b226lM7MjwMEYGCgPdHsnbcQFKMFYSvxSzZ5On8b2+KMS6yfObAclR32JSP6cHbL/pCYCpmD4FriK64pG4F6q3CRQuzF/2XsqQFFhEGI8UONtEg92WEMwYycLCuZhF1YVt31G6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TymXamBMvSVv7HZOEbFQ1osLcroSNt4oxLybe99SmB4=;
 b=e+m8aEheZgoghvRqq1Ai+7Wuy1vjNyZfg/n/Cr+ddWgbEPIUQdvpCtZqJ/mCCNaNq73tAjiFyRN/aiTvTYkPBYaAKooXKCC8d5Ih5vYw98auKrknuX+XKBVFPpg0TAFaJcRB/bHq+WjJMmZ2Zgrn9PnxlpNS0uiSX03Mdamom++HYldWdzsK9nrC4YhEBFSioT4/5AwXkt3MmhZxCj6AnQiH/9FYnXO8LtBzZDzIWREzqLsVrIp+/4yoMCyvupw0vh0ONdnagcUM7NrYYhkFrPbeWxLfLvoCtWRyRFjvrNnUh/CGOyfHoJbsHlxM70ogGBeD9PG0fDQHtfeLLf2LiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TymXamBMvSVv7HZOEbFQ1osLcroSNt4oxLybe99SmB4=;
 b=J8Br02piX/ZYxyknAdm4oqHLkoVOVNHfISTPXdYIL7uIPssVU2lYijKFXax++d9GFIiMY1Yg0Tw8fTo1AMhvqauAtFh74Rn9oje6njGsnPedEyWvzqVSY3vdDTXAlxEboOSIhH72NAueMIB+lF2jxPu4IyTCo6DaEcOpXlBg2LY=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 08:16:24 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 08:16:23 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Topic: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Index: AQHbO8hOnWx5fJjctEim5f/IwIjsn7LBSehlgAABLnKAABerAIAAAFiE
Date: Thu, 21 Nov 2024 08:16:22 +0000
Message-ID: <SA1PR12MB7343A1D60F5DE97216A822CBEB222@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241121034835.1011382-1-shikang.fan@amd.com>
 <SA1PR12MB73430909A842EFAB0FBD01A9EB222@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343558D8C9CB6A72BB898FFEB222@SA1PR12MB7343.namprd12.prod.outlook.com>
 <92c9b941-7b9f-4420-8190-ec9725a63a97@amd.com>
In-Reply-To: <92c9b941-7b9f-4420-8190-ec9725a63a97@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-21T08:16:22.652Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: 713bd9ff-3b23-4590-87de-08dd0a04c949
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WSlKbZlLrR/HqI87i5UfHt8sbwDhykJqImhkfuORIwlywqmt83CBmV8r9n?=
 =?iso-8859-1?Q?4ci3fe/xcf3fphwT9kOFSkV71FT2fbOlQSn8VTnWR2/aAGokEnAT89/LYW?=
 =?iso-8859-1?Q?tuOcHcwG8vlJU0IuCDZcoLY4sLNU8iIluBhWMjP6IPBfi4zVnxKUDWYaZw?=
 =?iso-8859-1?Q?XznX0KatJcji9kSCJNL8cHcXg6fxs3PFRKoSb65mkbG3QYjWij8eLfdk+g?=
 =?iso-8859-1?Q?LoIEEhLL2t0A+Et7nZ0yKp+a0NfRSh3CkRudGYDphy0QY200j1sumFlPNt?=
 =?iso-8859-1?Q?9/6mrp6qob6gV6WSFezr8XugeF6GUjLKMkurXXsGEMjffHv4s+aJO6IuTO?=
 =?iso-8859-1?Q?HvCEanduspAPlQQ50amME8KQjwqeuQgAFjmyAJmsHZkBH86FGHZ5AdvfuJ?=
 =?iso-8859-1?Q?HRxgnucvIBz/xpZA4Rz3RGQ7AHJaRmF+OD/fw1lbI++s/vHtqAhXrUV9rr?=
 =?iso-8859-1?Q?B7+EwfM5PVxm6mWWnXErB64ZacjMvFSDnRqCp1e7wwqa63wDAzPvoIYRAI?=
 =?iso-8859-1?Q?o2AzW5s2c/pnrftkSvLqJ4SlqzDahQBchZaNEAyJQDsB6xSV0dMkNmQzAB?=
 =?iso-8859-1?Q?pfM0aN5gHTqTXsZKs0FeyThjU91GnUvvfjWPoZi9rtsRuuA5vtXRRImSr+?=
 =?iso-8859-1?Q?LFJksXHjumvtn1lbSjorbzV8mipHNcWxm7HUA0WQxw45nkDJnKlTlStCWJ?=
 =?iso-8859-1?Q?2z2ff8s8mrRaYYQ1NKlSdVwSaWi/fLKtvuW52EcDoyOL2t/nSprwo1pm2S?=
 =?iso-8859-1?Q?3F8TfvyPuBhaGxSLxHcI3dEWT+67zcVGswMER+uGkgY9fJLc59AcZ/bsb+?=
 =?iso-8859-1?Q?sE0yClQpdwcyoHkz0QSaP6NBd3qoDBrW2E2lKbN9qTt9q7sKkLNT76msC6?=
 =?iso-8859-1?Q?iPlnNzNSvCvOSfEWwJgIixKUT/0LvBHt09xiWqSOghVAucTyqJY16d9riI?=
 =?iso-8859-1?Q?l7u+jhxgtVa3BJAUEuGEKVMcKPfmzJ9+On54OPoy0Sk3oeRMg5Qjln3JMu?=
 =?iso-8859-1?Q?pFUVDzXWVNRvSaItAjkZRblZpkN1v5dTKIj5HyLImaMAORnFK/M6HOiUER?=
 =?iso-8859-1?Q?ZXVpA5rWNEZ84/bAYdLVOnMvYg2oCNTkOGTR1wfDRF/1P2ZEDWDFoZ6NCU?=
 =?iso-8859-1?Q?/Nun/Sg7CjzSjwQVyRHF5HniWtGGcA7ZCt05qLyrEGXwTvyakOnAxkOziT?=
 =?iso-8859-1?Q?QR10mSokWaMojVBpgYqy/bllX5hy+s1zhFEOThd1QjAUI5HhiFBijuu4zH?=
 =?iso-8859-1?Q?QahDqyiY5byXiL60HuIwSvJyPcg1B/zfWocVU146k+Nawr9XOicY3F/nzb?=
 =?iso-8859-1?Q?1wHwPrNIjfZOpxmeBf8GOkfyB6Mr/x+K3OdX+MZCO3nIcf1ppwwPXzz+wz?=
 =?iso-8859-1?Q?A5r98XPsuvrpSqvF224c5GjSG/S9ExqnybU6LP7VMWs3/0epuVUYI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?11j6q5DCZQk0bSumO7GE/h5xKt/4BZ4V1hR3h8Ol03b1gyE9nSf3abVLGQ?=
 =?iso-8859-1?Q?5xDp4CFnO/qCnpe1mezO0xNRG5Ce4VrqUreCO4eLg09n5vdXlCm/zYXli5?=
 =?iso-8859-1?Q?Xd4+OcVXJQKx22dSMTS6eTFptybkKhFcyph2Nbmek9MIhaJD5aQWQqC8mM?=
 =?iso-8859-1?Q?DFLlKQrxtkTldkUdo45FkSStwYFjg45dMu/xwx7xUUyRUm20Xu39eR3aMW?=
 =?iso-8859-1?Q?JQyX4dNZwV81+sq+NvKtuqQYMELXb3TaZuXAlie54UVm+3MBJhYHvJuRGU?=
 =?iso-8859-1?Q?TfZ2yIdBhPCeZucdyzjTmTFG9ilIl8NnVAEOVrLP2L6X5lweDvsZ9gFXHF?=
 =?iso-8859-1?Q?Jj8XnDDKvVniqS2lfgIrunG0t5AJ7dhl18attc9hnUrUWECpb2XL85e+4d?=
 =?iso-8859-1?Q?CBzGRzHcZux00o6P7v+voTgHbxjJiw2JvbW00nAK28bjx3r9lbEmc2kD6N?=
 =?iso-8859-1?Q?wrNLVFsmWVxXeGEy2yC4eKU9RYa4R8b+B8fo/nWjBFMBu0XtfOLhaodOZW?=
 =?iso-8859-1?Q?tyKwasDaPmuYDF9JFMWfHEEp96eMLen//hiXN30bj2G1KCaKRIsCY7rxzO?=
 =?iso-8859-1?Q?7kfLMYH+/iUXuQUM8g4ZzZa9PLElNccIfMlIeKOhRc1DI9fW5gY1+3zGv/?=
 =?iso-8859-1?Q?ZDYi5gsumAw86JaBlMF8yHQs+guHL1nYlRexJuMKyyL9ir0rPw6th5PbgT?=
 =?iso-8859-1?Q?mS6wWrNreNIjYtzelXQozrAjQaEGdR/LxhkIkFOzGFR5aG6sUr+KboO+vU?=
 =?iso-8859-1?Q?BBHkrfWciWsO73Rt6jyv0HwILb7jo7Kf+PLdWt4Xoc8MJZf8HKeWWXN0iK?=
 =?iso-8859-1?Q?GSKNtgJeLlzY8N5DkL0azU4dXoDhZbUNk43ZDuxOx6F2x1rFiuCBnrilAt?=
 =?iso-8859-1?Q?6iBN8lqTn9ZWTkKaPkclRQ0PuTfesK4l0R5KN8oAtEojznRvmWtbwKHbH2?=
 =?iso-8859-1?Q?K9R1JUE+igDKExJ4ys/Ie2X72PEZo5og61Kb6SgKiWuhcNPpn9AX93UZQ+?=
 =?iso-8859-1?Q?Kp1U3xPcymg36nrvPP0S/vvLd7X6NuC3BSnSOc91tZWaF00yiQ7iSIHiRL?=
 =?iso-8859-1?Q?7moGlEvRsENnVAKKdD7DfxEV4DlMAEOaNuzDqF935VI/GzgX0roJHZEGqu?=
 =?iso-8859-1?Q?9jqjK+90LXcRq35oTaIsBEErr7zLoTeDTa0WXTSDGsrKdaGhgwG+2l+KWt?=
 =?iso-8859-1?Q?Zf/Wjhjy2L6/OoM8gjcRZdE05oGM+kvku4akHU2jm7hUKX6H1MK0cZBXfp?=
 =?iso-8859-1?Q?FYnKLPuN4QpcDQUF+OeCOmxyGpq2RtCphmM+UmhtLumzjAQUh/m5sNGXzd?=
 =?iso-8859-1?Q?dywumWY+rygjXIQmt36ET+ZAWQ1n5AtZghUkx68lOCgi6f4nNISzyJ3arS?=
 =?iso-8859-1?Q?xcc/GCk1suy7pmtfBpr7nhYYglH1vvFXqL/D2u8VSkcyj5I8HBHfwwUmcy?=
 =?iso-8859-1?Q?G3GHIjisD/hijFnzDEj6Oun/MS8UvCZ27HuXBD2BT+tpNTJUFSSCEATiks?=
 =?iso-8859-1?Q?c9fS3nyYfr08yPPFeHw7cgD19YrVsq42cqCGTl6GD8QW/C2wRItMLPfpDf?=
 =?iso-8859-1?Q?ZrHlFU/6QRfwaSAwCpAK5vp62ZfjiaoytuRANhpRMIW78rrGfpT7jZzOGu?=
 =?iso-8859-1?Q?/DHRi8MhaA9/0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343A1D60F5DE97216A822CBEB222SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713bd9ff-3b23-4590-87de-08dd0a04c949
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 08:16:22.9466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SecL6OeIKGulPWNCw9QnQcYMfdzR8yByts+j2/61e+jt78mU2rhAezqVJvUwANlh8/X+XJOG1wAG7nzn/dR3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

--_000_SA1PR12MB7343A1D60F5DE97216A822CBEB222SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ok, thank you!

Regards,
Shikang.

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, November 21, 2024 4:12 PM
To: Fan, Shikang <Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify b=
ad jobs

Yeah, just wanted to point out the unused variable as well.

With that fixed the patch is Reviewed-by: Christian K=F6nig <christian.koen=
ig@amd.com><mailto:christian.koenig@amd.com>

Regards,
Christian.

Am 21.11.24 um 07:49 schrieb Fan, Shikang:

[AMD Official Use Only - AMD Internal Distribution Only]

I forgot to delete the unused counter "j" from the patch, I'll remove it wh=
en submit the patch to the branch.

Thanks,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com><mailto:Shikang.Fan@amd.com>
Sent: Thursday, November 21, 2024 2:47 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>; Koenig,=
 Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify b=
ad jobs

+@Koenig, Christian<mailto:Christian.Koenig@amd.com>

Hi Christian,
Could you please help review this patch? I removed the timeout wait in the =
function.

Thanks,
Shikang

________________________________
From: Shikang Fan <shikang.fan@amd.com><mailto:shikang.fan@amd.com>
Sent: Thursday, November 21, 2024 11:48 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com><mailto:Shikang.Fan@amd.com>; Deng, E=
mily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad j=
obs

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.
v3: Remove the timeout wait in has_job_running

Signed-off-by: Emily Deng <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com><mailto:shikang.fan@amd.com=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b3ca911e55d6..f53889ce71a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
 }

 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver recei=
ves
+ * FLR notification from host driver. If there are still jobs running, the=
n
+ * the guest driver will not respond the FLR reset. Instead, let the job h=
it
+ * the timeout and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-       int i;
+       int i, j;
         struct drm_sched_job *job;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)
                 if (!amdgpu_ring_sched_ready(ring))
                         continue;

-               spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
-               spin_unlock(&ring->sched.job_list_lock);
-               if (job)
+               if (amdgpu_fence_count_emitted(ring))
                         return true;
         }
         return false;
--
2.34.1



--_000_SA1PR12MB7343A1D60F5DE97216A822CBEB222SA1PR12MB7343namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Ok, thank you!<br>
<br>
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang.</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Koenig=
, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, November 21, 2024 4:12 PM<br>
<b>To:</b>&nbsp;Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v3] drm/amdgpu: Check fence emitted count t=
o identify bad jobs</span>
<div>&nbsp;</div>
</div>
<div>Yeah, just wanted to point out the unused variable as well.<br>
<br>
With that fixed the patch is Reviewed-by: Christian K=F6nig <a href=3D"mail=
to:christian.koenig@amd.com" id=3D"OWAb1402645-f293-8142-3dee-5daaed440c43"=
 class=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;christian.koenig@amd.com&gt;</a><br>
<br>
Regards,<br>
Christian.<br>
<br>
</div>
<div>Am 21.11.24 um 07:49 schrieb Fan, Shikang:</div>
<blockquote>
<p style=3D"margin: 5pt; font-family: Calibri; font-size: 10pt; color: rgb(=
0, 0, 255);">
[AMD Official Use Only - AMD Internal Distribution Only]</p>
<br>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
I forgot to delete the unused counter &quot;j&quot; from the patch, I'll re=
move it when submit the patch to the branch.<br>
<br>
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"x_divRplyFwdMsg"><span style=3D"font-family: Calibri=
, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Fan,=
 Shikang
<a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWAd855acdb-88e5-8c45-49bd-398=
e3f4e685f" class=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;Shikang.Fan@amd.com&gt;</a><br>
<b>Sent:</b>&nbsp;Thursday, November 21, 2024 2:47 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" id=3D"OWAe71d8f=
54-d8e4-52bb-2913-148a503eed05" class=3D"x_moz-txt-link-abbreviated OWAAuto=
Link">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWA299a5084-eb1b-e1e5-aeb8-8c6e1ddc2c4f" class=3D"x_moz-txt-l=
ink-rfc2396E OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Koenig, Christian <a href=3D"mai=
lto:Christian.Koenig@amd.com" id=3D"OWAf64e6e5d-c0b2-9805-9a02-6c0b3b19bc78=
" class=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Cc:</b>&nbsp;Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com" id=3D"OWA=
b7afa9ac-3418-bba9-9404-9014b06895fb" class=3D"x_moz-txt-link-rfc2396E OWAA=
utoLink">
&lt;Emily.Deng@amd.com&gt;</a><br>
<b>Subject:</b>&nbsp;Re: [PATCH v3] drm/amdgpu: Check fence emitted count t=
o identify bad jobs</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
+<a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWAAM340083" class=3D"x_=
x_tWKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b">@Koenig, Christian</a><br>
<br>
Hi Christian,<br>
Could you please help review this patch? I removed the timeout wait in the =
function.<br>
<br>
Thanks,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calib=
ri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Sh=
ikang Fan
<a href=3D"mailto:shikang.fan@amd.com" id=3D"OWA588dadcf-d48c-dd95-22d8-fb1=
53d5a16a2" class=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;shikang.fan@amd.com&gt;</a><br>
<b>Sent:</b>&nbsp;Thursday, November 21, 2024 11:48 AM<br>
<b>To:</b>&nbsp;<a href=3D"mailto:amd-gfx@lists.freedesktop.org" id=3D"OWAf=
fa0e8c4-626f-b3b0-b374-46b3256d169c" class=3D"x_moz-txt-link-abbreviated OW=
AAutoLink">amd-gfx@lists.freedesktop.org</a>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" id=3D"OWA255b5eba-51ee-f84=
8-bca5-c435842e698c" class=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b>&nbsp;Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"O=
WA2e9217cd-a5e1-e0db-1933-9907c38ac97f" class=3D"x_moz-txt-link-rfc2396E OW=
AAutoLink">
&lt;Shikang.Fan@amd.com&gt;</a>; Deng, Emily <a href=3D"mailto:Emily.Deng@a=
md.com" id=3D"OWAec7685c6-0db2-d435-c979-4088409c6fe0" class=3D"x_moz-txt-l=
ink-rfc2396E OWAAutoLink">
&lt;Emily.Deng@amd.com&gt;</a><br>
<b>Subject:</b>&nbsp;[PATCH v3] drm/amdgpu: Check fence emitted count to id=
entify bad jobs</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">In SRIOV, when host driver =
performs MODE 1 reset and notifies FLR to<br>
guest driver, there is a small chance that there is no job running on hw<br=
>
but the driver has not updated the pending list yet, causing the driver<br>
not respond the FLR request. Modify the has_job_running function to<br>
make sure if there is still running job.<br>
<br>
v2: Use amdgpu_fence_count_emitted to determine job running status.<br>
v3: Remove the timeout wait in has_job_running<br>
<br>
Signed-off-by: Emily Deng <a href=3D"mailto:Emily.Deng@amd.com" id=3D"OWA62=
837c60-60c3-f148-35fd-fdda97a1a33b" class=3D"x_moz-txt-link-rfc2396E OWAAut=
oLink">
&lt;Emily.Deng@amd.com&gt;</a><br>
Signed-off-by: Shikang Fan <a href=3D"mailto:shikang.fan@amd.com" id=3D"OWA=
b715c14a-aebf-bc1e-d72b-c99105026e83" class=3D"x_moz-txt-link-rfc2396E OWAA=
utoLink">
&lt;shikang.fan@amd.com&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------<br>
&nbsp;1 file changed, 7 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b3ca911e55d6..f53889ce71a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t<br>
+ * amdgpu_device_has_job_running - check if there is any unfinished job<br=
>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; *<br>
- * check if there is any job in mirror list<br>
+ * check if there is any job running on the device when guest driver recei=
ves<br>
+ * FLR notification from host driver. If there are still jobs running, the=
n<br>
+ * the guest driver will not respond the FLR reset. Instead, let the job h=
it<br>
+ * the timeout and guest driver then issue the reset request.<br>
&nbsp; */<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_fence_count_emitted(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
--<br>
2.34.1<br>
<br>
</div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_SA1PR12MB7343A1D60F5DE97216A822CBEB222SA1PR12MB7343namp_--
