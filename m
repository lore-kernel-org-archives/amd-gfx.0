Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52848C636CC
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 06:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B14910E715;
	Fri,  3 Feb 2023 06:05:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE80710E715
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 06:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrWibYvAQP4uPDByZ/xZNOb/oBQ9GF8wa64m9yf6voj7FD+zMJJCDmh5omlLUjaXi6S33hYCoONs8ZlmawKs3pobDTElztomR2wE8V5mQXyMdlfiDJaT+eadtfjE2z9g7WgBRaxDnF1ZVKNUpgs0aXEpIDrg22Fw195vyiV2zE3ItzfmyxxVIDKCrc3V+9PiCHDJ1MhV/PTZi1ni2nxaTtgyCo9rykBtoM8mtmAf+Na+6lpRkrNSMVUA+Dw4Z6UWh4UiS9YRo7/w9sWwBklj8MufJEfywAtsc8CF6nNm+Awte1Dwt4ounqXYZNM6FsbmEFoTxy/fshfP2Up870+npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUB3pWBfkQ464VBAp1BCb7cOeWCxtwnczhVcXjX5nKg=;
 b=Ps9FjgpNBltpdayMT0gV2N2ZngO3DEP59molQczI777QYdNoA7uof6g/6GrOtFXAiSjXJERbSHfW8u1xx6BdL7WRncgBzEdm5vfzAtxZhqDHjf1UB5gYVGzln0X4Fw4Z6UWHshQN0yGYvBKX8XTspw6Ka3qyZY3OO0o2/6YMO0mtBRkhTyM+nlHRw2lZuPNPv5/M7u7deOhlNv42MR6PF47zeAbrTptZBNheTBdBmA86AGrmFKvXCY5pwiP8buVC7QZPYJhAssLiCdglWuFDbgghEL6pya8yUSgoXTA+dCBefR8w1v971dgY470fNZY4nqJ4lOd/+8lqgrlceWkA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUB3pWBfkQ464VBAp1BCb7cOeWCxtwnczhVcXjX5nKg=;
 b=Ou6oZ0ds6fRYFxyJF7N1Fy9hK2xkvz+bRlcQv2i9gitSqPXgY1gxCtCKYanqv2UWf2Qe9c2BmXr8vpYir0tbRvNzdLQmsWMVgddX0NiEErUGWWvq7DXmgqxYVEGXjLzEQUEdyx8/sddQvLkgK5n7UN4Fkkeug9S6Rd5Er4cnpA0=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 06:05:00 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0%7]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 06:04:59 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Topic: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Index: AQHZNuxfg8FNVol4pke6J9qzLuANM667iUeAgAExmRA=
Date: Fri, 3 Feb 2023 06:04:59 +0000
Message-ID: <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-03T06:04:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b7025091-7a1d-4cf6-a18f-7d7fe639988a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-03T06:04:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: adca154d-77cc-4c1a-9622-09d80d1e5952
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|LV2PR12MB5992:EE_
x-ms-office365-filtering-correlation-id: 9895acbb-9def-4748-8788-08db05ac94f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIczPKzLF3uDMmf1mf3NpwPFmkP4Hgkra36MvoUI263YLprQ5C05RVAmzsvda7VTUlmurLaoMj9Y16kC5WaWqzJFyIFEkgdLzZtkvQWfdHLWpq2b71WWQ9ryVAg7vLEtZpSKmR5Kf1mjTVYJomUV5Yt673+s7a2WFnxoSLNE3DucC+36OZ3HT0C4KH3Jj4Rf6VKxcjrfY4lytbcIRptXwvFvnzEXzFpiV9vBCspsXcejy0/LXsNfKTNVMtr+oScsNLjdCA2pM3eixgmlY+QQs1u8KHln+Z3njaZQD2rO2rkU+SnHgvCRga+PYw1FQxuD3PBQ0KmsSA8+eBRbIWD7R9d5ers+Zg4KJr5bx1G9b5BgYsw27f8LKi2qImFsFBI6N+OTiYPCqz3rhCzkc3n26xlNwpmzcmg3470rzXwzNxXNKTsEQ0MVqdLmSmVTJEMgnrwLwMOuYP52B3WcNTZa85Ff2pjAzaDh8uLqK+3XmjGbS3KByMpYfuzrC5b5Xeqv9ldntFTCVoW9A3+8tX3x8iP0ZMcLbFcnjPAbq4NuV8yzabt6XiGuUgv5Sk6Lbmkc1HxDTokJUh7eExObtwi2d8sfl4X/wkmdOjz/+io6a19bNIPoGWbbepR4G5U6kxgJ8XT2ATC7dEiRSvOwHX+8MyTKRFvH/o1pbhCOVYUwP5faE8GyvNL3SZ01zLJPaHGIPNDIRahu9uA3CIE3Srlpsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(122000001)(38100700002)(316002)(5660300002)(6636002)(110136005)(52536014)(83380400001)(33656002)(38070700005)(55016003)(86362001)(7696005)(186003)(2906002)(26005)(9686003)(478600001)(71200400001)(66946007)(66446008)(64756008)(66476007)(66556008)(76116006)(6506007)(8676002)(41300700001)(53546011)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rk+XmNoZN/RObe9DH+YHeGt6UaJuZvZdGEh1rb3dU7aSS9gQtTrdRaxnF/C9?=
 =?us-ascii?Q?ifZFX5QOVpsVRaYTz7kn2ICR1aH7CnzAstgi0WTekO10XNKSUP3av4+7YUIC?=
 =?us-ascii?Q?arBVWcOhEYmojH294UGY5aG6nbkT6uMnUdGnaylJCVk497RcL6DZEzEhuqMH?=
 =?us-ascii?Q?i1bm08MlXuripy1xUAxP3NOhwdp9ZIsC4dNdIqnyoB4Bi5jfrpz4ZUiTRuml?=
 =?us-ascii?Q?CRVJyfnLaxtx/sHWx73SHoE6v5TthWZP0sYyvC1s8FQqbAHUfyKNVdwEaED3?=
 =?us-ascii?Q?lX2Bft2+LgFURRZz/diioGBzg3grMd3AA6IFy9eop+8R6s8V0HsNH9Dzu/u2?=
 =?us-ascii?Q?srL+p+P9QpxuI/YJ/4k/I0YaI4eJMIGrK2BiYQjzb1nqu4C17RvB/k/06YQ5?=
 =?us-ascii?Q?tGMqmfGFWIr0TJLc4+01uE8Tse58LBMHwENeegprOl0LD/eNHFDdSOwHM2Uy?=
 =?us-ascii?Q?asy1BLgR16ADXxb799zHZt06/eFELfCY8Zp5NQK2U/GtVg0NLaQ051ovZ/2c?=
 =?us-ascii?Q?k7Ha/U7BKoCkRiDaaJ7uTZKZ1Cqxd8TPz8Br5eJhbAuib3Q4qpuTfjxnbCYj?=
 =?us-ascii?Q?0h83WDNkzsw2NK6bDjJ5hJaYETNTwFIpnkWBWXxam2KM5LF5HKpH/TNAZaSZ?=
 =?us-ascii?Q?KDGUnrwn+fuAIAhFJnHhUM5KjaIKC7yNK3Wgo/mAU93YHdNlo8fMfCIllgGI?=
 =?us-ascii?Q?Nt2hjNuu7rm2kSole+U0fwNxroviQ2JlCeIPJZuXmQ/UDpx1+MzcMfJ0bcYF?=
 =?us-ascii?Q?NJ/ZCkB6HhOqTN7D2IUBCthjRpOVpSX4hiu0Rs26lwYxgtXxaGuLF10Nnlo4?=
 =?us-ascii?Q?iGic5zbvmtCYBDKnpoC3wlY5Xdv66rrDstMMTowNNR/pceXAQliUr6zVXmRB?=
 =?us-ascii?Q?JuJRl6b1PmLBSsH0d6h1Xv+5BG26A26J0XfUCmJytY0Hkp4bPdGz6K51Vgq8?=
 =?us-ascii?Q?UltphJtkG1zOouxkLEKejQdzQClqHzaWAMCJ2pkmQXVrV3EywilwPt4ZSVBo?=
 =?us-ascii?Q?loTjae+NPFOAwldndbN1cMHOuloSw6P6G986gFNNazd568mNQJ+3Pn5CkVAL?=
 =?us-ascii?Q?8eHc9bClaodk9ts07mQqh6fIEkon5oYIN/d4/ECW/ZDiInvH6z4YIceQB4cb?=
 =?us-ascii?Q?oaxLzCt7tWRwZI/EM6Vgf/PKL6I+UwvApF7ecm0vukgTStgqy6SxEHt12F3Q?=
 =?us-ascii?Q?vU2+5CtlNxIiP0wCGfiMbrFAiDwWI2lvAIwXnPlxovOjNEJhDCgP1HajVxkz?=
 =?us-ascii?Q?u8BjjwhdeuY/myfdCN+MMccM0E8CyNSk7VhB5pB5LeoiPOnnfb4ADrwkIgic?=
 =?us-ascii?Q?DbuwaUIvE5OoTltRspWx7ik4V7rPegKtus7EYhtTrKzfKhCN7qoqOzLj14f7?=
 =?us-ascii?Q?vMebOkv7u+cV9yRFXrkUElJREDLlnl4czE12VQy/8N6w7bSyGjbuRvBgooYX?=
 =?us-ascii?Q?t+rcKnlI0ufEfVJ1G5YidFCzOxtgjA8bEY31UisgqMuvJP0Z52UW/MN2aI2Z?=
 =?us-ascii?Q?COATQxVvJvCwjZlbLRP0emEf49X9QdXdZOMn1D0ATUBWC9eRhAEARwyt4eMJ?=
 =?us-ascii?Q?GXWRfsEJfQHuIZrjuVM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB4458B37F3A4E9AF91F35279FEFD79MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9895acbb-9def-4748-8788-08db05ac94f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 06:04:59.4468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96C1rp/fCIropiPDQvILUA4V+d5CMvsEidkoosXki4DKhS/9lfxgL6fCpw93zI4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

--_000_MW3PR12MB4458B37F3A4E9AF91F35279FEFD79MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

>> It's simply illegal to free up memory during suspend.
Why? In my understanding, the limit was caused by DMA shutdown.

Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, February 2, 2023 7:43 PM
To: Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Subject: AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Big NAK to this! This warning is not related in any way to the hw state.

It's simply illegal to free up memory during suspend.

Regards,
Christian.

________________________________
Von: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Gesendet: Donnerstag, 2. Februar 2023 10:54
An: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com=
>>
Cc: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Betreff: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unavaila=
ble

Reduce waringings, only warn when DMA is unavailable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..e3e3764ea697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,
         if (*bo =3D=3D NULL)
                 return;

-       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
+               !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_T=
YPE_SDMA].status.hw);

         if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
                 if (cpu_addr)
--
2.37.3

--_000_MW3PR12MB4458B37F3A4E9AF91F35279FEFD79MW3PR12MB4458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; It's simply illegal to free up memory durin=
g suspend.<o:p></o:p></p>
<p class=3D"MsoNormal">Why? In my understanding, the limit was caused by DM=
A shutdown.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt; <br>
<b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
<b>To:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Big NAK to this! This warning is not related in any =
way to the hw state.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">It's simply illegal to free up memory during suspend=
.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">Von:</span></b><span =
style=3D"color:black"> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">=
Jack.Xiao@amd.com</a>&gt;<br>
<b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
<b>An:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christia=
n.Koenig@amd.com</a>&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao@am=
d.com</a>&gt;<br>
<b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is u=
navailable</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Reduce waringings, on=
ly warn when DMA is unavailable.<br>
<br>
Signed-off-by: Jack Xiao &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 2d237f3d3a2e..e3e3764ea697 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_=
TYPE_SDMA].status.hw);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reser=
ve(*bo, true) =3D=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
-- <br>
2.37.3<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MW3PR12MB4458B37F3A4E9AF91F35279FEFD79MW3PR12MB4458namp_--
