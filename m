Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80ADC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 02:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2639A10EED5;
	Wed, 13 Apr 2022 02:48:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A7110E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 02:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+ly6VoWDoYxOaOOyjSg+1cBkIYyI1Ei4Ow4kv9YjfISg5yiplZmmYhhFN36VTPkt+AjUgJ5dXK7O/KuiZSfSrLDR/IluiUPtPQ98JJbqXVvgtATfyL3/ZhKuVT0gC+S63hBY5JpxOm/t23Cyl+VrDPJ8Xyi72EI1FlT+R+rur7c1dxpq0JmRUOhPD1U9Y22l0BWdvyBJGXDgnuxCztRoyTVsZchg+EzL1c281scuFP+1b7y3ayRtM7JDOztTDMsOtWQpu6GNlDGrUSx8B/EnIvOfbR8J4T53LTYopmcgllN0SYL2oj0gmjKLCDC0eyPJZKURwfosIaNASFCzIt+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqLTzB8aPyniBoHFX6DaiLZDm1pBuiVxbKK98rtR4QY=;
 b=fJm0K75i31E5kq96piexEqLCF9nbCn55bkXxaRY3sUEgjwRfOJoOcmzPXG68T8S41TgQUqpYrUCbhPh63UyFDrSPvJRNvZ60U/L8wLMRuTEBd7kt0iAACMaQEz06Ai0AKVogHUSJbhqTVFWPIDGPFtsdE7IUT0Tfav4NU+wRJ8JhQlcC3W/VsSarOqAl53Ci/CS6z/PXqSljyS7g4Y8ol4gCqIbSd4tzV7D020dyTGoEhffZhVv3VntIRoxqbVq+j3DcGVPYMLEcW+9hHs3XXPYFhzYQ565fLguPd06MUHog1efZQ4xtBcvCtEXWbgYlcMWmAImS+577DxoMTibLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqLTzB8aPyniBoHFX6DaiLZDm1pBuiVxbKK98rtR4QY=;
 b=EJozeJ87i+0f2lF6se7/zF7eOeXQRSxDHFyMyV8oNEiX+uRpPXmyTiUcEhHj0RxEuRhygxCjAYmB1jwoBakoVr4fFPH/i/r2McZ1S8kgQ7MrHRfRJ7yZLqdtH/oRrcfQfjpAOzJQA9YwWuSW4ECrKPIchhqfBQYI35m+6JV0eZ4=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by DM5PR12MB1740.namprd12.prod.outlook.com (2603:10b6:3:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 02:48:11 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 02:48:11 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling in
 send_smc_mesg
Thread-Topic: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling
 in send_smc_mesg
Thread-Index: AQHYTiLyUOjnlUM7yUKFWAJa8dUfaqzrrKYAgAF1zNI=
Date: Wed, 13 Apr 2022 02:48:11 +0000
Message-ID: <CH0PR12MB53876084BC763BB8A40F732FF0EC9@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220412040801.19905-1-darren.powell@amd.com>
 <97cb1d93-8e66-db98-4ecf-7e3f44dbe894@amd.com>
In-Reply-To: <97cb1d93-8e66-db98-4ecf-7e3f44dbe894@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-13T02:48:10.508Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: e66560e5-712b-06da-6c4a-ef84d9837e62
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf7d3b00-291a-4b0a-9a67-08da1cf80c6c
x-ms-traffictypediagnostic: DM5PR12MB1740:EE_
x-microsoft-antispam-prvs: <DM5PR12MB17401E7227D16D9AE3ADE680F0EC9@DM5PR12MB1740.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCDMISMqW28sIvhd25jrE/1Wg3gTFaMWOOY5BiBzN6QGIDpcNXMX+zHgJAMrc0J0PGQFMF5bOUdwU22fJtxt+UF94URGxFTqY5dG/6YsmA2htRZP+nR0E8dEW+iGi0zyE2iZnGjfShjl9tUNtQQB4Y3yPL+gYlWiY9yPte6LuLW6BchSHwmjmwLOfyYae9jLqnBq2bT2pFK3BeAzosls+oZdGMy8+sc7OR/iebCoqoXZNyUxhnYz3hw4CLa44BzjAMM/PCHeXE/OPa5SE7G1JW3MSswnDbzfALOl98pEV+G+xs9Pef4wMy7fKDVK+I8aAMkWR/Ly0ZYRnso6xk+C3FY8txxOR+dr+1JhWEPiCDPK2v6ENkuOHHMKoZSu6mvQxjI3+YFudfwvjFlJPiXegn/3DLSV62tahYctDcJxlPJs+vKLxd+HsRc6t2Yb/Yzm0aNoFt+y4vc2fwopUKI0r8qXUI8X71JBn0uHA7YW6ZarEPEnvb4BDRtLA9T/UQO8kUQlgQhJVobctW3SZOnqo9dfp7XeokTSevOQ9ldkgZxmsEUzhygcjZJieUYIVzD2jKymGhcBIvlsECYizR3aQFjg/8KHdZbfiE3GZN9kHTIq4hoA4tvuJLXr7W2d2h6EfYm5dgEZPalXw1YTMEo07z6ih2I/kJU8vCxJyFtvOMbWPu9QQ5RPY1u09B7wA10PrxgKcExp5YoN4ELYsXChfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(66476007)(186003)(110136005)(316002)(66556008)(9686003)(64756008)(8676002)(76116006)(83380400001)(33656002)(6506007)(508600001)(54906003)(71200400001)(122000001)(19627405001)(53546011)(4326008)(5660300002)(55016003)(66946007)(38070700005)(7696005)(38100700002)(86362001)(8936002)(52536014)(2906002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i5ZfT9TM4D3j2i/K0LmwD6KPCuHMRS10bNU5rT7zD/53+ehB/5B2pr5o+M92?=
 =?us-ascii?Q?PCYyiprl/ArGwfYHymkjLU81EyF/AoFeJSqJk4naDvxp8WO0ZNEl0KcoFIcg?=
 =?us-ascii?Q?I5781O9HPXbO1QjAlf9ps4wA65aalIe1wr5VFcR0FkFYH5cZlAX+UmhXFnPC?=
 =?us-ascii?Q?UiUXKvY55foFWSiRL2jBrWE4dRquZUa3zfpAmRn59QewhCtjpOF7stpGoSsv?=
 =?us-ascii?Q?dvHu1xUxFBOwFgjk92v4l9nRAIEUGmdwUG7yWxsbjYF/zutspyUTDVdKrLDb?=
 =?us-ascii?Q?ctGbqsfmQJXKJU208fn0+aOKSXPfLIopEgZHeGXxgUmHVs+pV+ZPYcrif6oa?=
 =?us-ascii?Q?wLBMmJZNGhXxNr1nZvwyD5T0rU08IZ/vOFgQiBA1RnSmDg7EnHldLcrDfBD4?=
 =?us-ascii?Q?Fzo8YWC0yoDUh6MRIScPpCNfcnfYwecD9Rn4KrNG+1bDtwpyG7HoptP+/QbV?=
 =?us-ascii?Q?dzwW3uKlQxvkXTEMNsIf5zFRuzjjsrvOm6jih3e6FI/GxjuaO7CUV9uJRYHk?=
 =?us-ascii?Q?Ps+JVxOl7hNmzkEGJqsZ/1MODeJ2z7hho96aV8cHaWZK42QREZlucF35Q/KP?=
 =?us-ascii?Q?tDuWELrCJ8Z1Byxr7JmQ9/7pT6+SwGMfsxwvj7oMuKrNyhYXi4dtUx2wM1zj?=
 =?us-ascii?Q?yzVIK5G0hOp31jC5igEIAasakszd2EAjkUpHnSokfx2jtqtZM37/jTvzhNyM?=
 =?us-ascii?Q?IahmzST9ow+cAqnpBwfcttYh4g5rJc4ro7VJZKIT9S4y1SKPcRfYS09VkYrz?=
 =?us-ascii?Q?mOkQUTqOf927i/WLOGEBe5O80aH1cU+Z6m1mV4dBjZy42fbWQ/+DIrI5xDjZ?=
 =?us-ascii?Q?5GJT8bUq1IJZVjGw+BichFj3TuRg3WFGsJ6TAt5JkN8h2W9EQoRMfiNoSpRl?=
 =?us-ascii?Q?jVI+mMvHVWvRY975kjbM65fFzWDM273DswFUrDHY7pV/2j15kpJIzRx8VAeZ?=
 =?us-ascii?Q?xAGI9+PaeJNpRzOvLseN91iyTYgcCOOZu+kkRBi5UT3II6UEA3MxexYH0e6p?=
 =?us-ascii?Q?vNMcDwsCDb/rRHXDU9Vz9X7dO7k1Ho49SXQGyvFkkRDVgIBwJnOfSjQaX2ky?=
 =?us-ascii?Q?9AXvRmZoSKqQeF27thbPw/vj2s9NziJM17+IJodUW63VFEFLNBNqxstESeai?=
 =?us-ascii?Q?HUy+fGv1IVDKYzx17iC4nkFzMQZEYW616ET0IbakrcVIdAA9f93fiYF8wjgU?=
 =?us-ascii?Q?a4VfR018ghtD7POaQrF0/Gv12MpFYab0/QHmZPOshmqrBbSbNVQcorf7zWei?=
 =?us-ascii?Q?H0Ube+aECvINupN6Wrh1y2q6ZeyzTZe48pohg9WkKl3BCeGIFj0rACO8KIOJ?=
 =?us-ascii?Q?U+ngUhhJRHuH2riz5jD9MrA0wPYMHjDKPXV6jjn1R1DAqTW4/2Jt9VIKZ+BJ?=
 =?us-ascii?Q?q/f2Rtow/ssLnwP35bKHVaAWjHf5AtLaczPY3hnH8//V8G49bE551CQTdwNH?=
 =?us-ascii?Q?CwE5e/jG9FegNjruw8eauLbAaqoE4zqGX6+UXGoEO7ljqmIwBHnICLUqPc1F?=
 =?us-ascii?Q?XE4/bWPW7YA9v7GUnXJWJFIR+4k6buLDkNbbxn3T9k0JO2XbOkSuUXhJbu/4?=
 =?us-ascii?Q?o5NtCzwtPctsFG3cxgga+vBnJwx5yvMZTf6coxYuHodrGxQ5EwDk/ermzKUo?=
 =?us-ascii?Q?bJUXXxe8w+GTdMt0AoRCZwOh/bc199CUDpwFEK2tpjQnrPWJwX2ETQ0vA/om?=
 =?us-ascii?Q?ouhEfXimUjlvGV8C8E/mPcfKdJo6vPdSH9eVx8fjVURpQP//?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53876084BC763BB8A40F732FF0EC9CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7d3b00-291a-4b0a-9a67-08da1cf80c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 02:48:11.1477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2QNlZf7PnGhkLObHn1FHJvo3vwTI9Qburo60lDWldo8n8apQLDR0pdBwg0ySMmtJT3otis8jsXJINQizq0xTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB53876084BC763BB8A40F732FF0EC9CH0PR12MB5387namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I needed to dig further down to find the message map, I had been looking ba=
ck in mailing list looking for clarification but hadn't found anything.
Will reword
Thanks
Darren
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, April 12, 2022 12:19 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Quan, Evan <Evan.Quan@amd.com>; G=
rodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; pmenzel@molgen.mpg.de <pmenz=
el@molgen.mpg.de>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling=
 in send_smc_mesg



On 4/12/2022 9:38 AM, Darren Powell wrote:
> Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
> cases exist where messages are silently dropped with no error returned
> to the caller. These cases occur in unusual situations where either:
>   1. the message target is a virtual GPU, or

This is not fully correct - only messages which are not valid for
virtual GPU are dropped, not all.

Thanks,
Lijo

>   2. a PCI recovery is underway and the HW is not yet in sync with the SW
>
> For more details see
>   commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>   commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW=
 state")
>
> (v2)
>    Reworked with suggestions from Luben & Paul
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..8008ae5508e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *sm=
u)
>    * completion of the command, and return back a value from the SMU in
>    * @read_arg pointer.
>    *
> - * Return 0 on success, -errno on error, if we weren't able to send
> - * the message or if the message completed with some kind of
> - * error. See __smu_cmn_reg2errno() for details of the -errno.
> + * Return 0 on success, -errno when a problem is encountered sending
> + * message or receiving reply. If there is a PCI bus recovery or
> + * the destination is a virtual GPU, the message is simply dropped and
> + * success is also returned.
> + * See __smu_cmn_reg2errno() for details of the -errno.
>    *
>    * If we weren't able to send the message to the SMU, we also print
>    * the error to the standard log.
>
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7
>

--_000_CH0PR12MB53876084BC763BB8A40F732FF0EC9CH0PR12MB5387namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
I needed to dig further down to find the message map, I had been looking ba=
ck in mailing list looking for clarification but hadn't found anything.</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Will reword</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Darren</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 12, 2022 12:19 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Quan, Evan &lt;Evan.=
Quan@amd.com&gt;; Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; pme=
nzel@molgen.mpg.de &lt;pmenzel@molgen.mpg.de&gt;<br>
<b>Subject:</b> Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error h=
andling in send_smc_mesg</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 4/12/2022 9:38 AM, Darren Powell wrote:<br>
&gt; Contrary to the smu_cmn_send_smc_msg_with_param documentation, two<br>
&gt; cases exist where messages are silently dropped with no error returned=
<br>
&gt; to the caller. These cases occur in unusual situations where either:<b=
r>
&gt;&nbsp;&nbsp; 1. the message target is a virtual GPU, or<br>
<br>
This is not fully correct - only messages which are not valid for <br>
virtual GPU are dropped, not all.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp; 2. a PCI recovery is underway and the HW is not yet in syn=
c with the SW<br>
&gt; <br>
&gt; For more details see<br>
&gt;&nbsp;&nbsp; commit 4ea5081c82c4 (&quot;drm/amd/powerplay: enable SMC m=
essage filter&quot;)<br>
&gt;&nbsp;&nbsp; commit bf36b52e781d (&quot;drm/amdgpu: Avoid accessing HW =
when suspending SW state&quot;)<br>
&gt; <br>
&gt; (v2)<br>
&gt;&nbsp;&nbsp;&nbsp; Reworked with suggestions from Luben &amp; Paul<br>
&gt; <br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.c<br>
&gt; index b8d0c70ff668..8008ae5508e6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context =
*smu)<br>
&gt;&nbsp;&nbsp;&nbsp; * completion of the command, and return back a value=
 from the SMU in<br>
&gt;&nbsp;&nbsp;&nbsp; * @read_arg pointer.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; - * Return 0 on success, -errno on error, if we weren't able to send<b=
r>
&gt; - * the message or if the message completed with some kind of<br>
&gt; - * error. See __smu_cmn_reg2errno() for details of the -errno.<br>
&gt; + * Return 0 on success, -errno when a problem is encountered sending<=
br>
&gt; + * message or receiving reply. If there is a PCI bus recovery or<br>
&gt; + * the destination is a virtual GPU, the message is simply dropped an=
d<br>
&gt; + * success is also returned.<br>
&gt; + * See __smu_cmn_reg2errno() for details of the -errno.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * If we weren't able to send the message to the SMU,=
 we also print<br>
&gt;&nbsp;&nbsp;&nbsp; * the error to the standard log.<br>
&gt; <br>
&gt; base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB53876084BC763BB8A40F732FF0EC9CH0PR12MB5387namp_--
