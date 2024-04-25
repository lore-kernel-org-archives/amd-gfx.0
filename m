Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CA5C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 02:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E3B113FE3;
	Thu, 25 Apr 2024 02:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gWLBwDMZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE54B113FE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 02:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id1qDDrJhNVin3iGzu8RQvFOWrPWN33hVKLXN5pi7OK1RkTJovtmWBxDXOcuZ3vsFxAWP9YDsG73SdIvWvLEsNFopqf63D+XNZkNFrXEtpNeVozqdnej3TjKUAfQFOoHsPOB1K0/1TwTeCzqS8YjJvKrpjTHSC7M41gHRfCWIvF9G4WmEzA3+2owxX2wyWcEI1Ju3aagrwGaNt5OcaZGCadJ3jSEM1akGPoRQbEYTJ+Ye7ncqXF2g8PrmUF1G0byrLFx+flQ4FPoI7Gh6vNFJh4YpbQJEUZ4rVvS0G7/9ZE1m/0eUZntccm5GEs7RRHbRkRCnnRovrA4U4qS0QRdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7MRyT7SdScfm6LWEFh3TLBVrfCbuKcb0GQxoU14SyI=;
 b=VoxuB5G4PttjLbczrKQUpgkZOzWVb7lE9E55jpglYJQSyctRox4QnZ3GRBgFcsT03urIPNAKZNE1HfSjc07ata4/l0s1zaDZQhoUJDGXMO6Zc3//CtBbbVV61EU9JisA01Y7SNSnhhIe6Q6x65+pJ+CXadrdWwMxvywITAXYAae0rMyBzU+i5PkgBZWGxnfULrXH9sGp2rscqhzoIYkHTVgmQAO1GC3IhYzQnUhd5MqkI7TDtlu4ZK54GoU9cW7kTmyuVLzpdhClRT7NO0MTJXtpkPuAF6sFsBLxml/CNVIAV88eEQc67rpYCh8tmpqxXPPtEh+n8lh8LNLvcrHXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7MRyT7SdScfm6LWEFh3TLBVrfCbuKcb0GQxoU14SyI=;
 b=gWLBwDMZjgRKkVMlBlK766XnR9v/3qJ9ArKqonIPMYoDH0hEVshbC6IKwwTJNNGMCEGRH7r5ubUrMgQWqpPQATwI/5zxgZo5tn3/XmZLpKiFmg4TWBP/m8E/NvOfrfo6GUsXO1OxVHeSInmAkwxL9AUqea+uuMSM/Kc7yIuZThA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 02:45:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%2]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 02:45:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Topic: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca
 mode
Thread-Index: AQHalgulD017J3LfvEmkNJm/hzY1z7F4R+AA
Date: Thu, 25 Apr 2024 02:45:48 +0000
Message-ID: <BN9PR12MB525739408DE080422FEF4DD4FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240424055228.904041-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240424055228.904041-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=320f36b6-4617-43d3-b1b7-9f48d7279a89;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T02:40:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6475:EE_
x-ms-office365-filtering-correlation-id: 0f67f0c0-74ec-4ca5-57ac-08dc64d1d019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?B5R6stwuQRzr0qHPGbgTagbB0ojBPtHEBnfB2DteJAj+3xsDf+BHaSnk1mKb?=
 =?us-ascii?Q?FePTepSpj0qkQ2qyh9ceUf2+Vl0uygbdZaRLBYNmyfp86erWKgR0unUo05/U?=
 =?us-ascii?Q?pma7/SJpnkaH22JMCrMSTJGlo8e9CPafMwfzJchxLn/SEASm2BkhDLULI4x+?=
 =?us-ascii?Q?Tvrx9xkxnWURW2gaZYfVkHUPLzKy2IrcCGp2Dpi4Opi8X1j0gJK5sH68Pb6W?=
 =?us-ascii?Q?oLjPG5xaJUK154XoMyd4FHGzMconkthH5A5ATNjDVrPCPQ1t8Pl7bdG3d2j9?=
 =?us-ascii?Q?ZdJHA2Kzyd1AEjqraIte3uU4ZPCEa8/7+dbu8w5lfjkvG0UfiY0+CMyLayeY?=
 =?us-ascii?Q?QXekLrJgqy7fTBB1M72piRqhifWIsUSMA2HR2lau2F26DBFtdQOOna6Yqw+w?=
 =?us-ascii?Q?5RjmX6RGoTPccF0kpWMKyuVBWAdI2A1R2Xc7MQOcPy3VUoruPd89Ft1sXVSD?=
 =?us-ascii?Q?0HBQfLAPwtL98Lvl/uSqOgjP0/5udAK5HxZpgVvJ75PB3WoQch0NrbbjHJie?=
 =?us-ascii?Q?fkrOZ74nlfiuM+4lk7DmKaqHM9R/aHCxW0AuBft52CVNt4Wh96jjgibW+JnG?=
 =?us-ascii?Q?Je7mZ0Zkpz17UmVJWoRDWZmKbWk0FD5njVVvoDuwWL4/8vacphs762Y6c8Cg?=
 =?us-ascii?Q?lJ5QaEGdAFykRAHhJAjjw04WjfKlDJ1JMAsjlfAfSr8OMeEneNTI59n3trw8?=
 =?us-ascii?Q?ZOunJSVjtrSRrSQGCdUm1V8Sv7tQRs0hGYEbmiP4GkgqWCgn6teA3RxAHOn3?=
 =?us-ascii?Q?ngm6S0IOXmlMeMQ5SQ4Sg5LaRuSWiu7geY91Sl2d5WEw33zKskHgt2SUmLh3?=
 =?us-ascii?Q?UD8YvZt0SH6eYZNxSZfJ4R96dfGpvCZNyGVKpy4io3+ekYoeUGumUVW9CBJZ?=
 =?us-ascii?Q?HL0Oj0/ybvG5pUu7ntF14InYB2cSlcnbtT/D13jBo5TMCRYCKjvMyRocXZam?=
 =?us-ascii?Q?hayqAr3dF7FuEJuvBpZWC7rvQPNGKUioNJICovfuP12wxQ7Ksm8oPXHBVIFX?=
 =?us-ascii?Q?WJJcvKA2LgzvAtkT1PRC4fO6Q6F+mMCoiovvruYrXrMXY2/WLWfz3GoHzl0c?=
 =?us-ascii?Q?yqknKTNCNNWfw6VPnUPw30X/4rQJhzf/jbiq3tBqz49Mj6FJPQ2WkSjbRT5O?=
 =?us-ascii?Q?kAV/XlYJ2DOlL5NZJdTrKXBTQaCyOqFRGQ70W5QxF4NmpXrVUV/0oWEbsNS6?=
 =?us-ascii?Q?ppmPYQD7qaVG7Q1Fe7ucfZZdQisrAlVTHtt2xCtOvoJtc5GG7gHHfD6tFQ5R?=
 =?us-ascii?Q?Nk7ePGzG57lGBNmSKamE4n7IvnSprR3F8gyivAgQWBUegyJp8M5US77xjk2x?=
 =?us-ascii?Q?CScGbEwkxLyFomoeklDLKTdUnJFB03tFKmgGSzq/pzK65Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0U3wqYWE8RNknfKjj+YIFs0QSbt7vjMI0SpFA3G/Riq9CS68HSZF235vSiFc?=
 =?us-ascii?Q?X0p4q1+MNS3xcx81UGrG8hKlC3Zz3dlO5npHjw2SmUj13SfCIBwhzELedxHS?=
 =?us-ascii?Q?aNquFDXA3q39ayWcJm5ksfi+VQj6Y/o4WVKog7Rmr77WLEbj28cmLH2niiZ6?=
 =?us-ascii?Q?ZTLqFZxBk302bQ8rp80Hjuvejuv1X22pZ14IQ49KMC3USReKIPb/0V8Qw5N9?=
 =?us-ascii?Q?p1739uuM37QPHljXI3i36zU8+PiZ1j+MUAYO2VZs6gvX7vfjA36VUoIdlCMx?=
 =?us-ascii?Q?qQZ/gRVIZu7+SECgBaJ4w8NoHm+2Rufkc2/0sRAUifrBkeHz9JVi+z2fE3Gt?=
 =?us-ascii?Q?Cra1bMQr7Yl0DGM4sgHOQ2khMtoZqfrdjH6mSB2H+m3xsMWKgNgmwBholojt?=
 =?us-ascii?Q?I8gG2nwqSGc9Io5MvKpn0fkQNVNZt5GZETgYuswku8zavpLeouf3nPD5ja3s?=
 =?us-ascii?Q?P69iUcqIqNXpIdDJnxkYod2fm7/AwzHwlb8ORAX9y41zKrkqEig0bXZ4PT+l?=
 =?us-ascii?Q?gwenSE8xvIQuzSJuE4axVRuCGay7kBEjW5Zrmm4tOQcW68YoezD0eiYN/gdP?=
 =?us-ascii?Q?rq65/QnjroYyc5MDr5c4BSUtt0IcSXXWg3fzufBoFsMjhaahgzRsq1stKC/M?=
 =?us-ascii?Q?1iZaG3JxXJXtkyXvzFUdRd8AlXzQqcysWnM9OaibWbbVoujHPhxhy67VR1XK?=
 =?us-ascii?Q?WKpUcrULSEhBxnm/it3rNohvq9HhDESL0b+4a2t84KMvfIioDLSJ0EiUi9Ws?=
 =?us-ascii?Q?e94MV4od0i5yDFpf0Ww61uBnERcTm2pMhceBQh+SM6x+pj+4oIb/+N+18TCy?=
 =?us-ascii?Q?JCNxLGZyTI5HmYGGhkIOYEwRrWBc7iNdf7/NC7Heiy7ACMs8jjLPyhRN2Mke?=
 =?us-ascii?Q?lla/M3pjEiBAvuKBu0fGoxOAViOCd4gPDOCij9uxBcFZXMDI8T58LI3Ay6Gh?=
 =?us-ascii?Q?FyLOfpWaF4TIlBPh0sBJz7kb/WNTKnHNeBTCzafL/136bNi9O/OXZ0icUgxJ?=
 =?us-ascii?Q?8SlBZFWTYMpqZo3RCXPUI7DiO5C05ycdLFIwnpF2jfH/QAD+CIPmW3W92Ieb?=
 =?us-ascii?Q?Rr525sWURIR4JsYlB3L8axo/BkMAMeeviFDq5kz6i+4xTHZS48a/hLoewyy3?=
 =?us-ascii?Q?qK6FZp1KIOHQAbQwjSl0IAM4i8dY9xFwSmpkVTowqKlCqo6l5TEw5dYscFxc?=
 =?us-ascii?Q?TSg5F+TltVjU2Cy214mFpRqQEvEDDS/8brnhXjvcck/iqCuodoBsxG74MxaK?=
 =?us-ascii?Q?UjQpaszajxW26inyBHCpCrMjDjCkpZze112fgf2KR7BNQmCSFD7NEKCAbF/w?=
 =?us-ascii?Q?3YEnzld53SJaq7bECKb6bcEKdv2Ju4L2TighnV1E37wKQjfPp7NSJTzNAqzi?=
 =?us-ascii?Q?EpVaVHYtXiuH+GnLuc56L1bsLcAaNX0z8SPp3M9y2XLaV90TeX8lADyqmdWH?=
 =?us-ascii?Q?mceFSHXv+f30Gjhok6QZqInswGhh5nanXfUVzI5IdZPj/cAbCVIYGMfjK3ky?=
 =?us-ascii?Q?NlTmmIZq0GF2U4V5ntIqc1bNLC632eHM1dNOaKBY8SFPslV7fwNFWsoh/yrV?=
 =?us-ascii?Q?RDGGDqs7cEoGgAOz+UOOdZj6bmnXv27JVnboMZS7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f67f0c0-74ec-4ca5-57ac-08dc64d1d019
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 02:45:48.1628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHOvDPrupG+UatylqIWZxpB+REzQpwtil6/2eIlHQTleVEpFRQjf2RktDC8v41nHLMbsnyvbct/R67bexB7HYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

The patch is Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Kevin, Thomas,

Alternatively, we need to explore the opportunity to centralize legacy ras =
and aca ras implementation in the same API. Take sysfs create/remove interf=
ace for example, legacy RAS and ACA RAS do share the same logic, just have =
different filesystem node.

For now, ACA RAS is trending to back to IP specific ras late init. Let's re=
visit the code to see if we can re-use the common ras_late_init or create a=
ca_ras_late_init api.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, April 24, 2024 13:52
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode

Fix ras mode2 reset failure in ras aca mode.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index edb3cd0cef96..11a70991152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1254,6 +1254,10 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, =
enum amdgpu_ras_block blk,  {
        struct ras_manager *obj;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        obj =3D get_ras_manager(adev, blk);
        if (!obj)
                return -EINVAL;
--
2.34.1

