Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14275EE49AE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 07:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9563D10E3BC;
	Wed, 23 Aug 2023 07:41:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D3410E389
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 07:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZO9Y5zSvFLPx1K9hStc8wBYBZuP/aXABLcxMSnahLHN3Mx26JzFUs94z/KfMYHoI7s85yBwS/z/0RNiS8pMuM35nFGx1OAhCMmkf38JBg6FLwx9hAwAcMzLo/9hZ3wmp9nDYqn1rV5037cdvn5+KKA066/WGY7EbptDoV0dRHw4l5kA47Ty4hlPIHGbbLLVmolV8kF7vCpI0p3KVZG1QwOi124XdXXOGgT2DK8ijdYmrgXfPr82E5Buc4jBu09tPPQIwGP+mm5gYWjFkGMQfMdgfHQ3W75xYBjjgxnav8p711Ou4D6LAgNc4NKfz97LEL1GcOu54iKsbJxOHaZDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t+aaka3R6LxJzUUlUhZxR9VMqwg0905kEyIj45rT78=;
 b=PxibKIHlBwmyNV3zcFpDqrb6XXjO2I1+Tg4AmdhQHV5jvtSOlBPO+xMG0jExNzSXyU7y+n6Tu5hIDPEHunrVkZNKcpZZI5uPw1MiU5Z3y4vcMOFyrPzpauGiPsHCkl16lpfrE1rGLJqX1Js/AxrvvyWjcqx8JtI/GBZcMIhDICUOiy0P8/bkf2d0N76l3FP5Xu94ypqrYM/Gv+1YgOdJprzu2S5/2z8vixCnP8qRxa1+OkinIPpfm1HuNgoxavhQhurFgWNJoGzKUAbb04HAAqLTyLp19zfXQmZqcokJXvgOxB96+4IchIBo3LLh2t77hVZWmfDNEAVwf/Eb5uudwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t+aaka3R6LxJzUUlUhZxR9VMqwg0905kEyIj45rT78=;
 b=zn4F1KVhtuLqdpCWYJnyoNToMH8cS/QWkxJ6gn/2u3FFLlbkVso4LXYHGU5JgxjkzlEK4DkVb3VSTnwpbLGj8IqDtH0sBc4bXd4IEDuZG4PEUpyeWJX7eCs4PWdHcVFE3uvY/A6pXg8s59Pg0czBNm/CcI6oxoLyhPMvnFuQDok=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 07:41:55 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd%4]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 07:41:55 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: Remove the duplicate dpm status check
Thread-Topic: [PATCH] drm/amdgpu/pm: Remove the duplicate dpm status check
Thread-Index: AQHZ1ZGrLa3f0mvJJ0mcZtASLEvLoq/3fyqw
Date: Wed, 23 Aug 2023 07:41:55 +0000
Message-ID: <CY5PR12MB6369A9FEBF3319AE2811D60AC11CA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230823071536.1107514-1-Jesse.Zhang@amd.com>
In-Reply-To: <20230823071536.1107514-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9244037b-32bc-4be0-af8e-b53bb401b32f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-23T07:40:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH3PR12MB8901:EE_
x-ms-office365-filtering-correlation-id: 8a910659-1092-4c39-b6ac-08dba3ac6c61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OL/TKjEiVGklBNkQz3zU1ghFYSFVxvrrnTiIVqpD1mAyq3VOHBez0w+PguFqZB2s1rnGvqApHR9APfwqLgSIzbQkKMR6V2m9PZbvJ5XFou5ziUxYf6Vc7zmn49WPDFVAvBTSTq0iLJymTMlOn69bAP1/PGOP5AeYxE1xeR7usi982RfdNu1YZlIAQA5E2X40/HHEBl3zi5fVFlj+cEl4PwdZc3zMIgYUJzpNIAO4jjepgW/hhviNwgPNkDXtCI8yRf5klkqwsOWjYofBu8q0Arey+heCQyxktz1D4LouR4IWzQK6W5rlf2WfAd6/bzsOP8L3XJAEbmITsAO8icOZ4Ht1j7pCko0w6yk3BKiRLP1wAjfuoNtDhzKXEzQ9ax59yLhnzBe1tKQcJNspgOKo7nJXt+VYZ6+GTziXra8HcqXGC4rsEqbpVRfAzwkfEeqMCTbvf2+OsgK902RJZY3SUn2sK77vVyCi/JwY0yKLw1pT0qOAjTPvDI+pwaLTVTIOynjuCd8MVYJdAZWKtF7NDYsTW7Lp4rEMRFcQr8PQHsRN75NB63/+YppsEPUM70kwLms6kcvbFWOcgi/464+KNKw8h7wOYikEyMKFyHV30sj2V2OjTKnRjNmNOelW/cW7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(38100700002)(38070700005)(122000001)(33656002)(86362001)(55016003)(9686003)(41300700001)(110136005)(54906003)(64756008)(66476007)(66556008)(66946007)(66446008)(76116006)(7696005)(6506007)(316002)(53546011)(52536014)(4326008)(8936002)(8676002)(478600001)(71200400001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hC9qrrQNEYbUpE1Pn0W0S4wF93HMMsTxktRGLhGM8vNeTdVhnJWyVq0+MAKi?=
 =?us-ascii?Q?yCB9VoMiwE7k5xZtCi8kbSLCvSxlwUxxLMD4QL+iPV1G3w5WLsxjhJCDCl/S?=
 =?us-ascii?Q?tikep2CZD+lmFl6d6WMo3Uax4UZKDbbK9qoPdEMI35vpERixpfUiQno62uFS?=
 =?us-ascii?Q?obzhXe4lpBfnvHkz9x3aiLPKs+JnVJnPlQ/rLQr4WRYuGGCFHQ/5y3ZbXFcI?=
 =?us-ascii?Q?2K9osVfU5Simg/54ZHSVw4CcRto+sXSwhmmdOBAjxkzcp12nVhYOYQhL1zDD?=
 =?us-ascii?Q?R6QLQGzBFwylMQzpO5MhAQETHfY3RXF6e0HIexEMFdmQ2+1qU5psfOriPiiU?=
 =?us-ascii?Q?pPLbN6zSc/PStCKKSEyrmjdvTcWY33TcsxkCaByQ/VOVTGJCOG5f0h0wEZT1?=
 =?us-ascii?Q?ot/2YBwvRmuLGcNP6/38Zd0EVik3KrJ780lW2g0tYDM6/QNiUNTkG9tA3B1R?=
 =?us-ascii?Q?zrJ0dOLWaC8iIV+Dbcj00wf3tCtJGEKC5aL3+zAICHyQnoWNeYeI8IiVSjZx?=
 =?us-ascii?Q?7XsGx3QRrNrzdEWia/FHT34feFatK8kvahHmSbBXSri+74efwg9Iy6Cp8ULo?=
 =?us-ascii?Q?aHWrO35ApOEfyp3YLCS/nYUYHlq2S2VKHR/dibeeDt4qG4M3kZkz1mPq5ZmL?=
 =?us-ascii?Q?4i5ZNSvWOC8go5+/JPapHLVxaMstz3hZWitEqgfTanh7lPmLVycSi2OEYhuh?=
 =?us-ascii?Q?rWS032KgEMz+BvHSoqTDY+GRJwjpaa3MKZjuRy5XHD+nfC+t0+kLuzm4vrRb?=
 =?us-ascii?Q?6seU2hVKBxapfV49VZeD74gTqX/aj4sK3dRkRmGlH5uoxjzlwILYAeQFyoyd?=
 =?us-ascii?Q?991jgiQvWXaLCGT8/hBAYryGu6qyf88K8f+Rjq0uaks5Gp5Td3fGxkGRpdvB?=
 =?us-ascii?Q?lSX73/60+5kLUH7wKS+PEGdbExfY/2xJPTneyr1f3r0cnEFmHZL3m5y8Pint?=
 =?us-ascii?Q?5MP6AiH6Wcd5EgzRyjjXebMCazVq9VSwH/j7XAqKmC6eaBn8nTEKo1x1Dtey?=
 =?us-ascii?Q?80EAEJVCqBC80mctHDtSpx2/GyQvo5CMYnbFGhF3J0ByA60vLJTkjsbTVNM0?=
 =?us-ascii?Q?g8WAE00AqXpmekWF33p94RRIsQyvlyafJjUt1ibZU+OrlkqFy2SMpoFy4dxO?=
 =?us-ascii?Q?MJ3s4LI0opIFw6tNm+q7S42aYx91g0Lta3VEK1vOIBNOo2fble+Ive8MG+Zb?=
 =?us-ascii?Q?zmIwbrhpcB/L2ht/AQNxbCJMLVMmPg1cFoROOmCqGrS1XjtGxwTTkyV5TnrM?=
 =?us-ascii?Q?dQw4dOL+f4N8K2qqAWvB1ykiWo1x41G6H0G28LGWGywyvBIzW0BF4DQx/FwU?=
 =?us-ascii?Q?lybTOs8oqTc/TQesQSgq2ERsDQXVexUZ7zQAZy1nMgmz+EN+c0Guxv2qYABJ?=
 =?us-ascii?Q?2zh0TSVVWmVombScxe4VM/V0vHO9kJjC7vpJe1zCiK9fAyZA5MU4WeA1F07H?=
 =?us-ascii?Q?lDLcQ6kiFvXrcb6AO9g0/lwTDBchvN8u6yJmZs04SAk+5mZ/lyHhnqvdYDpH?=
 =?us-ascii?Q?S40ARoj5YbYL8mqAMUGrq9vIa9ydY0DpBE7n2uiIHFPSHcGX9swJyxIj1Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a910659-1092-4c39-b6ac-08dba3ac6c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:41:55.0920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7s1GfHyYW15e4OS+iPSxlU6zqutHn86RjCwjE4/VzpMwJQM8rSkIEFLDwxPCV+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Jesse Zhang <Jesse.Zhang@amd.com>
Sent: Wednesday, August 23, 2023 3:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Remove the duplicate dpm status check

Since the smu firmware has fixed the issue that described in the commit "60=
d61f4ed6ead".
So we only need keep dpm status check in the funciton - smu_v13_0_5_set_sof=
t_freq_limited_range.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index c6e7c2115a26..0dce672ac1b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1060,7 +1060,7 @@ static int smu_v13_0_5_set_performance_level(struct s=
mu_context *smu,
                return -EINVAL;
        }

-       if (sclk_min && sclk_max && smu_v13_0_5_clk_dpm_is_enabled(smu, SMU=
_SCLK)) {
+       if (sclk_min && sclk_max) {
                ret =3D smu_v13_0_5_set_soft_freq_limited_range(smu,
                                                            SMU_SCLK,
                                                            sclk_min,
--
2.25.1

