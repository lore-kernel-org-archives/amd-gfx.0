Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B23C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 20:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227F110E0B4;
	Fri,  8 Apr 2022 20:54:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859B510E0B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 20:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDy4cl8uLJX3va5VANSMXmUFldjvoAT7sCDWYOC+CzVdJ1vWg3XLD/p2woXO1WBzHwQyLMiTjnszV0v1BGgyZwv9GwqzrbODBZVul/cp+HIOQP5cqsrNstf1KUN8QuWNtq5JSzu7sQ9X4Xkd6Y6vkbLgQB9mQFB2TtaXy0TGICP2U1tVx8KLS6REB7BOFnoBH+Gkv/Hh0FpVATQpH6iXZdcw+7cb2Xewun4E51TtuD6MUbFXoMb9pJvlvnHCYCkydB85wLLNXrgEyZekc8q8vXpYaW0xXvJA5xuHHL/SHAAiAV8ZK/VRwoeI9I5jMoqv8sQW88PY4pHTPdvo7elMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18hllbBXZHlW9soT68ocbYS45rxyaQQO+gt57UI5LjI=;
 b=YJhV7UjcW+ZySvZoy3Iw/wlqkcN5596e5BVLe2/UqYVUP9+3xou4O9AdISWES8QcvDs6yC4yOcRhK5rQmTPpD35hyexCpvZjpzm/dNiUtBHAnnmjt6QDBoVxW+/r7Ql05OLWhIAcmK3tIkW3g84zUbVOkWb5LumA247EdvwDCJolM+v11wQ+9CK3OIGLSectnZmbU0jvGn392ObmM0DMfbbR7vXKmCAGkJo/PRzEGd8EQzUkoipSC7NGpJa3cOG1bVFeu06dHZ+c1gGmdA1rcZnQdiV/J3h7V0350q2Y7lZHoCP2rYcOabHxtFfxNbSU8m5uv7UyjVvPOHP183gC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18hllbBXZHlW9soT68ocbYS45rxyaQQO+gt57UI5LjI=;
 b=hXeNdbhsjx6Gd8An+DX5ypCWRBJY8xdWbibE28r0fo5/+pf5rQBBg0umre5wkvSBeH0FYHzK42FIWKbvwjU+pqbhbg+6BpF3jmdU6+420b9kQfO8fg5qoIRDOnPFJxXHyi+VJXyGG6Nj3F/b5/ggrzy1VKqjJkutnDgj3yQdSNU=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by BYAPR12MB3573.namprd12.prod.outlook.com (2603:10b6:a03:df::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 20:54:08 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b%3]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 20:54:07 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling in
 send_smc_mesg
Thread-Topic: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling
 in send_smc_mesg
Thread-Index: AQHYS01CYQj88LkJUEqtmiVpQFbHnqzmfkKl
Date: Fri, 8 Apr 2022 20:54:07 +0000
Message-ID: <CH0PR12MB53872389351505A3CFBEDCA9F0E99@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220408022639.7909-1-darren.powell@amd.com>
 <2b3c10db-4eeb-3b7b-4ae4-ef3aeb3128ee@amd.com>
In-Reply-To: <2b3c10db-4eeb-3b7b-4ae4-ef3aeb3128ee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T20:54:07.434Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 51238532-6ac1-4738-8e9e-087077951900
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40199287-201a-4403-e861-08da19a1ecd1
x-ms-traffictypediagnostic: BYAPR12MB3573:EE_
x-microsoft-antispam-prvs: <BYAPR12MB35736E79D54EA2A9347C5327F0E99@BYAPR12MB3573.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kzCehKkhz9JW6OHVjuRqIExc5w52W7VciiqjHdr78jGaYkqNBypq1U35GT2CtUVgIC4XfHHf4TlOXSNZ5hVxFSoc414lpRGO1Qo7N/qcW4WpQ7NkON20ud/UJy0itkKOARszpZWQBDBMjlcJYAG32BGw/EriiH9DVqwzgquTeXrrQKXqcshFVgMxQku9/WftOQotr2cpXuAgB5/nGZ8b97cIQJkFQyhN3X/veufsIDyCaFGvV7iQdk8aas/Da1FuI4U+S8Ae/gxpwnUpjbyQJGR/OeVp9a0UhyW2ZeO53IMbA4nZx2VvUZGE7mEoxnNi6XooquvrxGbSdXbYufHW7N2PEIALs9cRW3YBB5gfEe2qSDHwazVPjxhu2eO8b0NUurCun2HjW6SWCV5kna8ocPLdv7xA9irFYSbSAuukeoUc9ojDeFTwabi2lNzzMzPZegFrwVZoqhIsc9BzW7aUarodC2kRODgXK81uUR65iwGZ6CaBRainlG776FjBZEEZLnlTjSr+JnQ3+UQ/KdjeT7l+e8ndTRdKKoVZMLoc9VeP34uYP0mNXMHAsn+wIjV6TF3b0AKlFaVl4NX5h7dVOLOm1LMCK+5clnxNzRlkGyy/P7UDyYKbS2u9bCUAswPXOK676AqIZtw09ciDO9mm36VLeAa39mxWGeyj/W2WFJv6uMN7OEuPZNiyeoPY3ZC0hHC14RwzJBjsk1cbVHPw+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(38070700005)(26005)(186003)(8936002)(19627405001)(52536014)(55016003)(33656002)(5660300002)(316002)(6506007)(64756008)(66946007)(66556008)(76116006)(66476007)(66446008)(2906002)(508600001)(8676002)(9686003)(4326008)(122000001)(91956017)(86362001)(71200400001)(54906003)(110136005)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b0izHlgG1iaK/Mke8/i6HF9UzZv0aq+xnKdnWQE7myuR72RX+SLwfjiSYr?=
 =?iso-8859-1?Q?accvvwuuPaXrRRwnm+GOf+IYo8TKMDjNE/kcv/BBsBomTMRq5PvmdsCD6a?=
 =?iso-8859-1?Q?Ey1gK2/OQQ3k5zDenskQU3eiI2TIICbMBlQXs/fuN1QJT4JfppHSEP4vHl?=
 =?iso-8859-1?Q?rph7e0eoKzmNntzSoQmEYXg/AdRSjVG9VypQ9qaXsRVABTTTdMuJJLlXFk?=
 =?iso-8859-1?Q?jox4GkD+/0zYXzUNL8fd9JtGtuzHOnGK4zKP9ve5XRA7ZLoi+5CMA0dWwv?=
 =?iso-8859-1?Q?dduxaHmUaeg/HG9Z4yByk5CaF7IxoUo2O65T3i/AWvSsTmPW3r7GWnIooL?=
 =?iso-8859-1?Q?Li0TL5aDrIJCb9DLEzETNrI1kAu5SDseUyBuZRDHZhPHBr1ZtUVcwXe4Rz?=
 =?iso-8859-1?Q?1wxsxSxOfW+XelD2pmz1/7J45i8DU9xN3+N2xEEDFzYznh5KTq7a161UKM?=
 =?iso-8859-1?Q?QH2l45FGmDJqVbgC8h/6NXKmUSkXzQPieWcmiRyCEsn4Fm7/LfooLSIDJN?=
 =?iso-8859-1?Q?YiVvXon6yXME0vxpO3TIscvTD8VLcEJAv6X/yMMIZz6RIdnHZf+l00VC0e?=
 =?iso-8859-1?Q?Th5Tx5FhOF1aqjiK7bXqkOZ43/I57xSGtYY/UBgmY1N4w9bg3OwAOKnYdS?=
 =?iso-8859-1?Q?X//d0AFGWooObfznhW78OaHHzQMoTV3QEiD7ApyWKxwSAfXQfmbJypGWqH?=
 =?iso-8859-1?Q?Lcc7/xTfnlHahD+HEo5X8VC6i20C7cSfb8CxvRr4knhDxcwVBXSL2BXrU0?=
 =?iso-8859-1?Q?yX1MvQPWB7Qt/i0NtQncVYGEQh9aUXNna10QX4v1lelOXBG626la2uixJh?=
 =?iso-8859-1?Q?vwdLHlKJlZ1NZ7TPhFrQWVzFXCRjtEPFbXKSwheLLwz0Q9IvCMg9CcN+k8?=
 =?iso-8859-1?Q?nUG7HLmUDAhK5smXsD30rLUSyFV97I4DrK9NEEvkJ1/cTh8I+RIz6/4Qui?=
 =?iso-8859-1?Q?lgjbAURKX0MwuchZ5MNf0dIdANbICR6QPfK34Au7+NHvOf85+0ZDYphAlT?=
 =?iso-8859-1?Q?RnLyx2ig86AqfEWFef08roxQ/3k1bWaBevjK7vn2bYwKZgGJksy02qNT0P?=
 =?iso-8859-1?Q?WNxN4iOCk7wn3+03kQ0xYE/7fIDDtvZzrr80GSmP6/uQYqC8BU+AosR80m?=
 =?iso-8859-1?Q?K1KnyKCSQ6AWLVeCCvnbHWzRDBUwqMRx+STxA4exZDy9rsVwKILVb26bSG?=
 =?iso-8859-1?Q?nBTgf2QEZ3a4xvYV09Hw5g/kfxlNKnXLHd7kI5L3B6D/bZFwOytirhrBfO?=
 =?iso-8859-1?Q?AgPuq+P4Mp0Snq4jg8RrOK2G6zK/66noPbb1cBRv8XxpUdAPtgvcvh2EWo?=
 =?iso-8859-1?Q?C/OLLATR4cudatjtfJe9xQpgfiwzAE2z+Gs+ITs000ulTEE+jo12tbh8PG?=
 =?iso-8859-1?Q?woH/n5NdB5gWjIw61Y9aoO8XRwUd2NMR1GTObvvpwaN+CcgmQVI9uRdXkt?=
 =?iso-8859-1?Q?AEYG2ncNlZdP2g96+mN2G9RFxaNUfwpZS5gwwdPfOiGLzve6adAbW2MxjJ?=
 =?iso-8859-1?Q?rC8ykw5dGgTwXoe56ZDb48cIWyikr5yV3UWOJUI+AZeq2D7cJp2ojt5urI?=
 =?iso-8859-1?Q?FyustmtQzrPCB7BG5Ltl/2sI6rJ7bNBQu67SKvIFnvpfN9Ri1K7Cyiz1XQ?=
 =?iso-8859-1?Q?/yfOOuLm3a1ld+ksaDfW9VYiRt8RBPdyVwlUlRUDCBrqy/htMkDrHZUkfz?=
 =?iso-8859-1?Q?hpgxmlWWv3ZiEFaNa0F3N+NsSM5X984xGUjAz3xrsxYVn1mmf2iUld8v/y?=
 =?iso-8859-1?Q?qA7pWkSHjEfoKM0UnZhhKQ+Wjhur86yZLUOZREZXXxdIOG?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53872389351505A3CFBEDCA9F0E99CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40199287-201a-4403-e861-08da19a1ecd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 20:54:07.9017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtOQu67oiRc8QPoDGfsaMhGTfknrIM6pQGYbtaLP6UflKgc8aRb+WR+qHF7XsZz1PEAE4CFxZELkY1SldlrmBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3573
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB53872389351505A3CFBEDCA9F0E99CH0PR12MB5387namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

inline

________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Friday, April 8, 2022 9:33 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Wenhui.Sheng@amd.com <Wenhui.Sheng@amd.=
com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling=
 in send_smc_mesg

I'd add who and how is the message dropped, and also mention that we're una=
ble
to recognize a dropped message.

On 2022-04-07 22:26, Darren Powell wrote:
>  Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
>  cases exist where messages are silently dropped with no error returned
>  to the caller. These cases occur in unusual situations where either:
>   1. the caller is a virtual GPU, or

The caller? Isn't this code executed on a CPU sending to the SMU (which liv=
es on a GPU)?
[DP] Great point, will fix

>   2. a PCI recovery is underway and the HW is not yet in sync with the SW
>
>  For more details see
>   commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>   commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW=
 state")
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..b1bd1990c88b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context *s=
mu)
>   * completion of the command, and return back a value from the SMU in
>   * @read_arg pointer.
>   *
> - * Return 0 on success, -errno on error, if we weren't able to send
> + * Return 0 on success, or if the message is dropped.
> + * On error, -errno is returned if we weren't able to send

Something like this:

  Return 0 on success, -errno on error. If the message was dropped
  due to PCI bus recovery or sending to a virtual GPU, we're unable
  to detect this and success is also returned.

>   * the message or if the message completed with some kind of
>   * error. See __smu_cmn_reg2errno() for details of the -errno.
>   *
>   * If we weren't able to send the message to the SMU, we also print
> - * the error to the standard log.
> + * the error to the standard log. Dropped messages can be caused
> + * due to PCI slot recovery or attempting to send from a virtual GPU,
> + * and do not print an error.

This is a moot point with the clarification I suggested above and I'd remov=
e that.
[DP] sounds more succinct, will address in v2

>   *
>   * Command completion status is printed only if the -errno is
>   * -EREMOTEIO, indicating that the SMU returned back an
>
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

Regards,
--
Luben

--_000_CH0PR12MB53872389351505A3CFBEDCA9F0E99CH0PR12MB5387namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
inline</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Friday, April 8, 2022 9:33 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Wenhui.Sheng@amd.com &lt;W=
enhui.Sheng@amd.com&gt;; Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error h=
andling in send_smc_mesg</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">I'd add who and how is the message dropped, and al=
so mention that we're unable<br>
to recognize a dropped message.<br>
<br>
On 2022-04-07 22:26, Darren Powell wrote:<br>
&gt;&nbsp; Contrary to the smu_cmn_send_smc_msg_with_param documentation, t=
wo<br>
&gt;&nbsp; cases exist where messages are silently dropped with no error re=
turned<br>
&gt;&nbsp; to the caller. These cases occur in unusual situations where eit=
her:<br>
&gt;&nbsp;&nbsp; 1. the caller is a virtual GPU, or<br>
<br>
The caller? Isn't this code executed on a CPU sending to the SMU (which liv=
es on a GPU)?<br>
[DP] Great point, will fix</div>
<div class=3D"PlainText"><br>
&gt;&nbsp;&nbsp; 2. a PCI recovery is underway and the HW is not yet in syn=
c with the SW<br>
&gt; <br>
&gt;&nbsp; For more details see<br>
&gt;&nbsp;&nbsp; commit 4ea5081c82c4 (&quot;drm/amd/powerplay: enable SMC m=
essage filter&quot;)<br>
&gt;&nbsp;&nbsp; commit bf36b52e781d (&quot;drm/amdgpu: Avoid accessing HW =
when suspending SW state&quot;)<br>
&gt; <br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--<br>
&gt;&nbsp; 1 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.c<br>
&gt; index b8d0c70ff668..b1bd1990c88b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp; * completion of the command, and return back a value from =
the SMU in<br>
&gt;&nbsp;&nbsp; * @read_arg pointer.<br>
&gt;&nbsp;&nbsp; *<br>
&gt; - * Return 0 on success, -errno on error, if we weren't able to send<b=
r>
&gt; + * Return 0 on success, or if the message is dropped.<br>
&gt; + * On error, -errno is returned if we weren't able to send<br>
<br>
Something like this:<br>
<br>
&nbsp; Return 0 on success, -errno on error. If the message was dropped<br>
&nbsp; due to PCI bus recovery or sending to a virtual GPU, we're unable<br=
>
&nbsp; to detect this and success is also returned.<br>
<br>
&gt;&nbsp;&nbsp; * the message or if the message completed with some kind o=
f<br>
&gt;&nbsp;&nbsp; * error. See __smu_cmn_reg2errno() for details of the -err=
no.<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * If we weren't able to send the message to the SMU, we al=
so print<br>
&gt; - * the error to the standard log.<br>
&gt; + * the error to the standard log. Dropped messages can be caused<br>
&gt; + * due to PCI slot recovery or attempting to send from a virtual GPU,=
<br>
&gt; + * and do not print an error.<br>
<br>
This is a moot point with the clarification I suggested above and I'd remov=
e that.<br>
[DP] sounds more succinct, will address in v2</div>
<div class=3D"PlainText"><br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * Command completion status is printed only if the -errno =
is<br>
&gt;&nbsp;&nbsp; * -EREMOTEIO, indicating that the SMU returned back an<br>
&gt; <br>
&gt; base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7<br>
<br>
Regards,<br>
-- <br>
Luben<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB53872389351505A3CFBEDCA9F0E99CH0PR12MB5387namp_--
