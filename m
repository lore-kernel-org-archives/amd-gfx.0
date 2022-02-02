Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BBCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 14:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D655710E327;
	Wed,  2 Feb 2022 14:05:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FD610E29C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 14:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X965k+/K8AmeFYCkn9H1nmv6yOtRERLzokLTO5Ip7k7LgSAEAXAet8km5g67KnwcBBZspPPWXPrs2/yJJSfDDasJCswOxh9CXO5TzYqexCNSCBTCt5oKil1pM/gZZpLSpmV1tpXIE01y1ULW1CsW52nUy7a6OFAIM/uTw6V5aLQYFtdAx31v9pOZaGp/CMDlCmQezCAqKrzcXa6Y5GlcFsMB4bKEL+qVLYClFe2gKvcSrsgfR9CNeI5x5jj4vrXouZ089MVh0fvpO+4BVsoFFGCj2pMZGd6TVkqs8NyWFofxOo14XhpBsPHc+cDTkEyqpXR0C3H7DmNXjJH+bf86Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbykSaYjyVyAUHwQtgdjIjmucMqVTaDbNxtS9TZekAg=;
 b=L/2+GSZ4AgH/WhQxW2bYSeX+vKELQHt6o5fqs/9T6Q93L2f6DUVStl6zS4GUqn66GjKLaNZfGrU1o18G5Edo1GnJhIR0LlOV/fFbvvTbaBt22DItGa610N1mr4jefmpfnmdY36Zybv0B9Xq7RkbfulWD3Kk9CG6LpEN0QXtXGyvzWIMvscmqfesAQui55KGG0qydCkX7yAoe1uD7sttoEfuJFD9L/wqnBcX/2eeedYa8iwqdaJtuoIEENP6APfY14m5boxY9qc9syJjjVgTpUgpAWryUlD6aHmEgvXlA/Ko6muvIZBEKNowCG2Q0QEwM/9UxpLUV0Zd1vu9LBVP9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbykSaYjyVyAUHwQtgdjIjmucMqVTaDbNxtS9TZekAg=;
 b=Edhz0yVnxpPVYKpoIK4Fd7CVUIKaV7BcsB7+/VvZdxleOeJ604VQ4VHUfdsOQdZhTECVD3W9xyr49Zno+5EGnYqAinJ139qkWNFlFdtoPCA+5Xl5BZn3A/wPeVseR37UgWyrjy+HBWaS5pys0SerSBp49rAreS7CECArRu4ries=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 14:05:36 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:05:36 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
Thread-Topic: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
Thread-Index: AQHYGBRHzeajS24cCkGzNERB7UmrCqyASv+A
Date: Wed, 2 Feb 2022 14:05:36 +0000
Message-ID: <BL1PR12MB515746B1E714CCDB35EF2525E2279@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
In-Reply-To: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-02T14:05:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e0e3fd19-1c85-488c-99c4-4c192c05ae40;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-02T14:05:34Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d842cf3c-16d8-4c1b-bb26-2ebb29f0e8ab
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86098a4b-6dad-4d84-bc8d-08d9e65515f5
x-ms-traffictypediagnostic: BY5PR12MB4918:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4918DEA0021348E43C0AAF5CE2279@BY5PR12MB4918.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vEDDdOWbWrBuvO+rgxdfEd5WEHnJO9CBKGpjgae6tXDuF9B2EP6ioa3sMDsh156RdOi+b0BgXKKluk0eNEr5GSZbYUfKyGWXYwiUKmNEnooe4a56096uD6HaVkHtyJK6vqPJps1ier/7F4ULJFbX5vv9E6g/cLg7l8EFzLsPny3EuVmnvZcEWJOQQefk/6i6STiJG+3M+peDkjcerOUw+K7BL2juxEB2u5fx786BrvNVolNmd7sLmSJg9M5jC4assEYk+4IMJVIO1IcHtF0yjAjj1JkacC6MUAp6DWhEdXjcsH2SolO3+bNNNj5LRyZdV0+gCExumoca+a6besZMCoQE6aLxvTUEkBqRJZXGHXVp6Mb6FRldswF5YAyxxMvoejNT6YJUtYM1lPzmSGbkzz2xylQsGxDXkeyb39JlLv+5EXNfWRrli+mTDM0f5ISxEw/PDPViXnZ/wR4yjaaG0eolr8eOAI/L4cEffZx/exucQWUHTM8B3ykuJKzbvzOx3CcwS3hUH1bG4LEuVYAk0pTk+3ZjV5/Pf6/GCMXIRydaaoY13eYdPS8bn474GYVOwg7SDt4wctLBSzeHmIdc1T65Q24U3slP51ucNSXxvEl6y4YYLda4sKHnHh1Fzwgg7tydyjFld2Zw6SUEOxIjr+q4T7ZsXg++XAiU4XgBF60n1tFFspB2mMnoqo4WYL9twCg/pwEE6+3lhANaf5ioy+95m2dL71OlSVHAEAMsYOl7kcv5qDobiSd/HW1Q4uLQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(6636002)(54906003)(316002)(26005)(83380400001)(186003)(2906002)(15650500001)(8936002)(55016003)(9686003)(66556008)(86362001)(33656002)(38070700005)(38100700002)(7696005)(71200400001)(5660300002)(52536014)(53546011)(4326008)(64756008)(6506007)(508600001)(122000001)(76116006)(66476007)(8676002)(66946007)(66446008)(21314003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4UGk6khEwdFIe1QkfC1VFER+EqMm7BznmB8AeZvcVMynkaIYBLGWocH6+j0h?=
 =?us-ascii?Q?HFWWJSrlBEwN1mTVH31WtIprpRsM5yxc7hvWN4dyLXqmPp98idnfyZsNZy/y?=
 =?us-ascii?Q?UgdBGchTgiC35ZOYFXeH6nyPb+99IVX5v9mf2rP6+BjhjPUGMZXw6ENVh61v?=
 =?us-ascii?Q?Lg4ETdrSwOewgeLSdjrU8sauO1mEXG3r4CFgHhZCgLIe96DuEVI3p3invAca?=
 =?us-ascii?Q?3Gd5nO4XlRuL52u+07QFF3ruMzAwW42K9UjjNf9Y16Si6v67RMdYLNgWichJ?=
 =?us-ascii?Q?yQw6GyGpKEHXN1602JVpaEaYkaz0NX9A/H2CREbGp89+jhq9IY6y6v/dFYSs?=
 =?us-ascii?Q?U1qYgUJErwufj4IkaBxs1iPtthKnbRdaky+APHf/LVD2UsLMGuWKQ4wIeL1I?=
 =?us-ascii?Q?TUaIRxi5vlLrdTPZ3Le4MCrKmDCDSy7DyLC2BDLBdvJ+QBYZpDVyQb8JUKC3?=
 =?us-ascii?Q?n5wj7lMC+iQ9RIlBGsvdAqK3olk+oYGxl0LmrpOTP6mXj0snx2VFA2k4XtMc?=
 =?us-ascii?Q?itdXAjwlxYqr7PDYzRU3gjePzaRKiniaE5iA2fh8bSIfMEy4HxMZiuM5hMgc?=
 =?us-ascii?Q?DfT9/ZTf/bWa/G0NtdSe7jIk5ELHWNNQW3NuGdX2JmThJguIiYw0ESulyd9u?=
 =?us-ascii?Q?dtY9b0bAi8Ba3xaJqgwbylS+hf1/ocOB74qTnAY5IjGN/N6cXN5wtRvWVZ3x?=
 =?us-ascii?Q?HrqwyGSImDAaQLmxg2ye0Pc74mozG2xytREuoFgFX9d+nB+HITvLREY/JmZJ?=
 =?us-ascii?Q?ivwD0z6NL2Vcg/v4W3U01AmeGupuH8/RagWLhXP6V+d0ZyIFI0/vRwHm5Seg?=
 =?us-ascii?Q?Ro4qb/jUE+usgrvs7NwmX7AGYZ5qxRH1RAJn40RlGyn3FbewVr39ChVmtlfn?=
 =?us-ascii?Q?ftdExONGxjkUZpYEklFZNnpR8ipOzCTfPijHUONhpfrg9zYFUv/wO2+jew+r?=
 =?us-ascii?Q?VTqhqRh8r0Mm+TIi/7UpwhmOPJPE2glTWF9dZp+q0waVFkR4Cec251cSzzSY?=
 =?us-ascii?Q?dC07ujhaxxqFJ6+rl7kksTcdxAvpxOg+aRzswrUYApysKzBxrylKDQkPOgOp?=
 =?us-ascii?Q?pxXM/nT5uTU/9G+mDBR8vXjgYT7dSiPOvF6/+FnhCCiB6LSRweG3UsbBdqhF?=
 =?us-ascii?Q?DOt0kvLHzTPUWnzQeXYMO1AL/BMVDTMLM9Nm5DmuwsLV6ZJHcTjds2s0vvrc?=
 =?us-ascii?Q?NpGDA6gDqiBVGOj8kiAy7u3maiCpILDDoQvBU2+T15RrG/kIk+lKU4Pu/8kC?=
 =?us-ascii?Q?WrOu8VNr2+MKP4vBYRVQuU4p26uPzV3Nhwt3rfuqar3l4J2xtechU4HYoNFa?=
 =?us-ascii?Q?5e11XGjM4WObr8DvlOC6A3hVGvZ0uXWIJHQRk0rfU0C1poRC8gwzGB6Zwm28?=
 =?us-ascii?Q?lpZw66SQpGSl5UT4ZZgXGAlpdLh3jUSIQIQVvw4p2/Or+PYC0QoIc1+HowHA?=
 =?us-ascii?Q?yXbpsqQmA0q6SPVryTwgDFypptveNoiuKIyNHdVV+NJVevc6X4hjqjFKDtc9?=
 =?us-ascii?Q?AvTyv9GoyaQCxZ5wlkHwwX+ljCZugzyjTbNK7i8pcSgvymUsBu67mn5BoKTe?=
 =?us-ascii?Q?uKvq4FqkM6zJO0OvrjjodHm8VPZQiQa7aB200JJQABtQFI6QHy80HYRgeHIq?=
 =?us-ascii?Q?rBISnaqpAKbd/8nqWnv6iRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86098a4b-6dad-4d84-bc8d-08d9e65515f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 14:05:36.3733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jZco9oK/GVqnJTKosJyUkUKEu9fNlCZeObqpi53AX7iy5dHOGwfhXO79y6yFQq+i6aoXeJ5CYS42XT/zAxs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> Sent: Wednesday, February 2, 2022 03:07
> To: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>;
> Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> Subject: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
>=20
> [Why]
> amdgpu error observed if suspend is aborted during S0i3
> resume.
>=20
> [How]
> If suspend is aborted for some reason during S0i3 resume
> cycle, it follows amdgpu errors in resume.
> Skipping SDMA ip in suspend solves the issue on RENOIR
> (green sardine apu) chip. This time, the system is
> able to resume gracefully even the suspend is aborted.
>=20
> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7931132ce6e3..f01b1dffff7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2927,6 +2927,16 @@ static int amdgpu_device_ip_suspend_phase2(struct
> amdgpu_device *adev)
>  		     adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_GFX))
>  			continue;
>=20
> +		/* skip suspend of sdma for S0ix
> +		 * Resume has issues if the suspend is aborted during S0i3 cycle.
> +		 * Skipping sdma for RN/CZN/BRC chip - green sardine apu.
> +		 */
> +		if (adev->in_s0ix &&
> +		    (adev->asic_type =3D=3D CHIP_RENOIR &&
> +		     (adev->pdev->device =3D=3D 0x15e7 || adev->pdev->device =3D=3D
> 0x1638) &&
> +		     adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
>  		/* XXX handle errors */
>  		r =3D adev->ip_blocks[i].version->funcs->suspend(adev);
>  		/* XXX handle errors */
> --
> 2.25.1

As this is specific to RN/CZN I think this check is better suited in
drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c perhaps in=20
sdma_v4_0_suspend/sdma_v4_0_resume functions.

The aborted suspend case if it's specific to s0ix, can also use adev->in_s0=
ix as
part of the check.
