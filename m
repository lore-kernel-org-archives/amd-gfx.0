Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877BAC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 16:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0D8206D8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k1dm1WL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0D8206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4365F89A8C;
	Tue, 10 Nov 2020 16:55:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7144689A8C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 16:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKBypWPA0iE+SBmssLjqZf9yd1Z44T5AKBIYLkKPK52wxA+hDD32m01wE6qU0xRWuikC8qNaQp0e7sDaG5/4ekMapYAZBu6lqq1KJDGxWhPI/0VINr6FfoF42NKQFJN0HdBSKQe30vg07i36XQnF/dJiUK8sYVScHGEX2m6h3z23IA6/gr3X2fHkjAZT3u55ZGFUTiFQ1nggTbgkJFkoJE1M1xKD4RoEhatbbG3/C98AuUNIwJU7dPwEIhGgQ1/h9pBZ62p3gG6TI2ITYy9M4oNoTXGbKx7YKWxSEojxfF2+lOYkqgy5XM3B5v9MNEB30NEjAYFDAwsJceD6Pzf+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txl3nn1A5zb3mltv2F6bULt7Pi+M6cVgf1G0iHtQsCE=;
 b=Amh9ONvu20YMhyDaqbbgO/AZ4XburK1vKfTR5++wNmAyGJRYsPmrx8A52wAfVCZP4miBDJdYIddq+rKfD7/oH7rLEGYkvV7D+71V5GwigFW9b3afOOjuJLgL188nHCejA2yCqYfZ/XoZbjO2TH7T2zSq1aF68Ma0ajMgI9jS1/aGSLyZ6AnsZ10958U1zGKqwDJvyN3iSuBt8GXkSpXyrbhlce4nC8lpKB7wKSlXxZ6giaQdbrSP978kE/ptWMn/36gA0InnUzJufg72ZfDuKeCxPVTTSROpO+N5bhkS9kYuBjBu2tmqheDslCfWkZQbk5AKZjeLTDtSvktjHgpOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txl3nn1A5zb3mltv2F6bULt7Pi+M6cVgf1G0iHtQsCE=;
 b=k1dm1WL94rPirv+2aWVrCCs438n5kdgojuM+r82XtlnPquCBxjVFEk8bOuZEwINsltB2od5pgkGd1glSj0EJUjFxMKIjO9hhUO5kKHojP2pSQPtKIPdaDKNNl3qKOf+INqy18GdoHLqPZsX90FbpkbS3KRauaGsz6QAP1g2FDCY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4799.namprd12.prod.outlook.com (2603:10b6:208:a2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Tue, 10 Nov
 2020 16:55:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 16:55:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Wang, Chao-kai (Stylon)"
 <Stylon.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Topic: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Index: AQHWtzYiDKk3grY1AESJrpD+rZ4szqnBbMwAgAAg+fWAAATCAIAAA4V+
Date: Tue, 10 Nov 2020 16:55:18 +0000
Message-ID: <MN2PR12MB44888EC743B809BCAB6742B4F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201110074912.54097-1-stylon.wang@amd.com>
 <df99166b-de59-5aad-f921-b4263c082ca8@amd.com>
 <MN2PR12MB4488F51CB06882617DE3BD60F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <511c08b0-713f-2cb1-c323-5ea65a7f954a@amd.com>
In-Reply-To: <511c08b0-713f-2cb1-c323-5ea65a7f954a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-10T16:55:17.900Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7357e8c-0b6d-4e8d-ee08-08d885996785
x-ms-traffictypediagnostic: MN2PR12MB4799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4799C62BB16BFCE76257656EF7E90@MN2PR12MB4799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kt32ds0PbhhVN9FbVM4OH0TxTYnOnrywKEvmrsO+PGZ3D1M8abbwA/T1NszlvW6oH7uNMXJgN5Ofw5Tf9M5AoRYGjcHGjcjx4GBtzgBwetsNPyznn+tq/maADXArPjKX5tcefqwzjSVXLODuliwBhx7/QV3wRbzVatan/hQYvYycluCzxpbV3Xd9xtWXb3435Sod8LUHOKaaqpy/z8jT9HVWTlpK96MO5jxNj+qoCpNvOiizSskVjDTdVDgk8SIqQkepn9UP0ZwyEeWhemgBw0iMzEJWr0ywodUX1YsAIyzAtXST4/N0V+2GuRQlme9Q4yhPiLEhlUOqB/K8g0rGGAzP0Fm+18M43dBc/MOVWBk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(166002)(110136005)(316002)(55016002)(8676002)(19627405001)(33656002)(4001150100001)(71200400001)(5660300002)(83380400001)(76116006)(186003)(52536014)(26005)(53546011)(9686003)(66446008)(64756008)(2906002)(4326008)(6506007)(66556008)(66476007)(86362001)(7696005)(8936002)(966005)(66946007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3t9EMMRIJ4vfOXwmFPH5Om6fQ8BqcYefD2kaJfeTd9tmTE20pGwLiiNxyOQqiJx+w5IZXD7f/Sa2k5qiyKYuV2kb02hb6MTx1rDpd5Aj9Fih/AKDl88KjPZXLAEF+o/XDkaLR8R9Ii4VqYO6W87w8Sg8vB47WDDfhe7w9sgN8GZUn6cfA1ZJS7pYaomyAH455NDhpDHCuIe2uRc0irx9NbMsfmGfkqxGVdZgwKe6XBidIgf8fiuN7vn5Jy/ePU+afECW+ZEX4ncgsPqLwG+fdq/dUHYxzwHh9rpc9679kZvwecHMAQ6Nb/2StVN1s15+GOyD24u6KnkqLvgBGXEBK0eCXT3o1nxpJsUYf+G0AR2fZ5DdoDXrWba8QYAmEahR7CRR6R/5/e/B+nJ1au3Q+tl3aTnKsyFnybM4M+hvB/BZxs77Jjkj3RoxLJuxDthjaaoHBJ+GemNwZyGV8mViU2p8wElb6WX1ZHH6p2N6VbNO2iJ1qO2IS6Li8juDxUiTpArTIDcVwk5vtrEimA+kICtAFgGcyZzvSNLLC167en0FAwPwJpc9lK81gtqcVayFPTSXJubEjsFsaxWUj+NeUSS3u06dY5Jv1mCk+Nnz+pC6RJwiM3FZ+odfUCFTU8XCuQ77Ti8OotePD3Ote1plF2ghDpf4VsVh4jL93+btfvNa7+MCjVkEm8m6hITw3xNGC+GfSjFXBJGGEPzmF7jjz0SeQCt7ONkSgM4Np0uxhUrnqvQ3RBVWDO/OzYzaWfPgDlYAPpuZdta3jVDcUSFd/dlgY8HPlt4hNs70qELS42n7oXbS50rTfM8Mb9ssCWJerJW3bf4+a7XwuEaV+nKUjbPKE5wnIYodiriJCbLOxMHE+kLsPeCE4kXc286gIHwcJLPK836lPK+7lgZ+l71moA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7357e8c-0b6d-4e8d-ee08-08d885996785
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 16:55:18.4902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFLX//3tx5xMJYAFaILjVHwYIwpxXvDurLSDOTbbfUEJcuMYAFuBFp9FtZrTQGkN3DgM3VvLQl5Y3F770JetIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4799
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1173056307=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1173056307==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888EC743B809BCAB6742B4F7E90MN2PR12MB4488namp_"

--_000_MN2PR12MB44888EC743B809BCAB6742B4F7E90MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Ah, sorry, I missed that part of the patch.

Alex

________________________________
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Tuesday, November 10, 2020 11:42 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Chao-kai (Stylon)=
 <Stylon.Wang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freede=
sktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume

It's missing the "drm_connector_list_update" call which I assume is importa=
nt.

Stylon, can you review Lee Starnes's patch? Is the drm_connector_list_updat=
e call maybe not needed?

Thanks,
Harry

On 2020-11-10 11:26 a.m., Deucher, Alexander wrote:

[AMD Official Use Only - Internal Distribution Only]

Lee Starnes just sent the exact same patch yesterday.  Please review that o=
ne:
https://patchwork.freedesktop.org/patch/399497/

Alex

________________________________
From: Wentland, Harry <Harry.Wentland@amd.com><mailto:Harry.Wentland@amd.co=
m>
Sent: Tuesday, November 10, 2020 9:27 AM
To: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com><mailto:Stylon.Wang@amd.co=
m>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com><mailto:Nicholas.Kazl=
auskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alex=
ander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume

On 2020-11-10 2:49 a.m., Stylon Wang wrote:
> EDID parsing in S3 resume pushes new display modes
> to probed_modes list but doesn't consolidate to actual
> mode list. This creates a race condition when
> amdgpu_dm_connector_ddc_get_modes() re-initializes the
> list head without walking the list and results in  memory leak.
>
> Signed-off-by: Stylon Wang <stylon.wang@amd.com><mailto:stylon.wang@amd.c=
om>

Looks reasonable to me but haven't had a chance to understand whether
this is the best solution.

Acked-by: Harry Wentland <harry.wentland@amd.com><mailto:harry.wentland@amd=
.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0b6adf23d316..715e0bd489f8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(
>
>                        drm_connector_update_edid_property(connector,
>                                                           aconnector->edi=
d);
> -                     drm_add_edid_modes(connector, aconnector->edid);
> +                     aconnector->num_modes =3D drm_add_edid_modes(connec=
tor, aconnector->edid);
> +                     drm_connector_list_update(connector);
>
>                        if (aconnector->dc_link->aux_mode)
>                                drm_dp_cec_set_edid(&aconnector->dm_dp_aux=
.aux,
>


--_000_MN2PR12MB44888EC743B809BCAB6742B4F7E90MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ah, sorry, I missed that part of the patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry &lt;H=
arry.Wentland@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 10, 2020 11:42 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wang, Chao=
-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org &l=
t;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume<=
/font>
<div>&nbsp;</div>
</div>
<div>It's missing the &quot;drm_connector_list_update&quot; call which I as=
sume is important.<br>
<br>
Stylon, can you review Lee Starnes's patch? Is the drm_connector_list_updat=
e call maybe not needed?<br>
<br>
Thanks,<br>
Harry<br>
<br>
<div class=3D"x_moz-cite-prefix">On 2020-11-10 11:26 a.m., Deucher, Alexand=
er wrote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Lee Starnes just sent the exact same patch yesterday.&nbsp; Please review t=
hat one:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://patchwork.freedesktop.org/patch/399497/" id=3D"LPlnk2605=
81">https://patchwork.freedesktop.org/patch/399497/</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Harry.Wentland@amd.com"=
>&lt;Harry.Wentland@amd.com&gt;</a><br>
<b>Sent:</b> Tuesday, November 10, 2020 9:27 AM<br>
<b>To:</b> Wang, Chao-kai (Stylon) <a class=3D"x_moz-txt-link-rfc2396E" hre=
f=3D"mailto:Stylon.Wang@amd.com">
&lt;Stylon.Wang@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Kazlauskas, Nicholas <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:Nicholas.Kazlauskas@amd.com">
&lt;Nicholas.Kazlauskas@amd.com&gt;</a>; Deucher, Alexander <a class=3D"x_m=
oz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On 2020-11-10 2:49 a.m., Stylon Wang wrote:<br>
&gt; EDID parsing in S3 resume pushes new display modes<br>
&gt; to probed_modes list but doesn't consolidate to actual<br>
&gt; mode list. This creates a race condition when<br>
&gt; amdgpu_dm_connector_ddc_get_modes() re-initializes the<br>
&gt; list head without walking the list and results in&nbsp; memory leak.<b=
r>
&gt; <br>
&gt; Signed-off-by: Stylon Wang <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:stylon.wang@amd.com">
&lt;stylon.wang@amd.com&gt;</a><br>
<br>
Looks reasonable to me but haven't had a chance to understand whether <br>
this is the best solution.<br>
<br>
Acked-by: Harry Wentland <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:harry.wentland@amd.com">
&lt;harry.wentland@amd.com&gt;</a><br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<=
br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 0b6adf23d316..715e0bd489f8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(<br=
>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_con=
nector_update_edid_property(connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid);<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_edid_modes(conn=
ector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;num_mode=
s =3D drm_add_edid_modes(connector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_list_upda=
te(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aco=
nnector-&gt;dc_link-&gt;aux_mode)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_set_edid(&amp;aconnecto=
r-&gt;dm_dp_aux.aux,<br>
&gt; <br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44888EC743B809BCAB6742B4F7E90MN2PR12MB4488namp_--

--===============1173056307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1173056307==--
