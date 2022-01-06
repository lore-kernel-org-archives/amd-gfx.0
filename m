Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF92C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 13:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A893410FD8A;
	Thu,  6 Jan 2022 13:46:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EEB10FD8A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 13:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny7nRSVZR00GUee1pHHiEusI9o9+R0MjglWUexavKqX7581pRT9dNrtCwisVKY0roKEOduVRAIZKz3Mz69lwmyfwfTSwqTvoE02nsuEn2ae8T4osf+6eAo530hth94CX7hQuXNUO9LwSDS4XjpRIJzNIwDJdXOHXr39nq9I5RFDkWW64ST0kfo2H8+IyrjkxBZTaPjFUh4iUym1mgOQdrQUrBOchQZP29aJ+oJb/Y+kih+zvEGVKokpAtiBHKtuh2gIt5q8ifF+8Z8/9T0ptdWbpfJJiBK6ZGAwPzH7WRq+KwVsMxdlV/MqS+CIcYCjWmCnpYCfrvO5zAf24MS7oDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ServV2MSFHr4PuxLeFv5Bs0rxh2HUHntjQWndqoxuNw=;
 b=HtJRFxQvrh/uoi5zgx1OaTV1ixbA1K+X/7GRvZzc0aCHyptLa2P3e1KNqIY4rgNgxir7zl8laPA4Jqz7E5b4aXdPUuqkNbZTpzXxbGXP+yW0l23VxVp6SMJmhs66xM44Nt9Kudiz9duxTmtpFM3zo0Y1qVYKYs2+EfPU3GsfLrbqsLmFyfuMF8mLjT3u4gi0M19NvjQZuTAN3ifVolRX78kjnKOUAOjgl3YsYJdQ/XTcsp9w9blKd0l60KGZsUc6hgRKqt7Q6m0MGcADTR+tLTo1R2TCNrFum8DLo3+49JvjAg4uzB4hSp4yQeFLFFY7NIg3S5s8omFgjC80oE4PhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ServV2MSFHr4PuxLeFv5Bs0rxh2HUHntjQWndqoxuNw=;
 b=3P8id++k6JKcx1Ot9iKDGmHCeQ1DSD+fIGq+FtPFD0BXS59mGGnBeufzgFuqnfQxYNZ62Df86aCbpYGWWKkrgbj4WEpibIZx7FY7+Oxr6zujzsK2gWoqjMaToGjhIlS9feYfWwVMpehMTcRNXq/scOrcTz95jyNhNwr9DbhvRDY=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 13:46:27 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 13:46:27 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/display: explicitly update clocks when DC is
 set to D3 in s0i3
Thread-Topic: [PATCH v2] drm/amd/display: explicitly update clocks when DC is
 set to D3 in s0i3
Thread-Index: AQHYAlaxrFmRbri3DUKjp1DCjwi796xV30iAgAAiYRA=
Date: Thu, 6 Jan 2022 13:46:27 +0000
Message-ID: <BL1PR12MB5157F21C23A020052FF5C13BE24C9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220105170656.2121-1-mario.limonciello@amd.com>
 <96531626-b1d0-70cd-7d87-3a282667e39e@leemhuis.info>
In-Reply-To: <96531626-b1d0-70cd-7d87-3a282667e39e@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-06T13:46:15Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=663df6fe-27c4-45c5-a37e-20685ad0c7b0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-06T13:46:25Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 61f51c83-e0f9-46f6-b13c-e57860b78b87
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7ca2334-6c21-47fd-0530-08d9d11af025
x-ms-traffictypediagnostic: BL1PR12MB5046:EE_
x-microsoft-antispam-prvs: <BL1PR12MB50464D97234440D75AB89FDDE24C9@BL1PR12MB5046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/j0muz5K/O3RQ/3sKrA8Rpt+r/8pV1cwLV0oWBD18PwoKmqyha6vsd3UlDmkHE+hPuYbkNBc4yRuK8SaWIv+jBvhElHsjPDuDwyKWD8V/8qrrW5l+n3Vq/gXdNnmUNUOp2cdv4tFiqJQcarw/S/Cv8D8sVUfJA4uAq0stbFBvHkCTQ7zo0GFyMPgUOe26nX18wwR00FPCDrT1/VjCtl+CuG6Ozj3nS821WtX/lteKvZSGG+yJQ0j/ymaessgsUEZOWcmuVz6ecQAbplx7vfencq0Su5yyh159Cq1YvavBLUMtQKmJnCAXji5OcGZEQKbLi1H8d0zGz5gaQbTKO17JSVWvnLCXNC0A1geG1nOtoo0kFVw0WJGW+ApU1DXz+L/nCCQKBoI+uQ4Cn/Q7i4lZQ1fPqNjphokjEq92D/OUVucl93RlU++zrp0QJov+0184TEhBAkzBm3BR8YN6y+jkRTPGjC3EDAFIDA7ObJdjKtjCxmUL7ozMMQ7W5BCw5O439/NolkluPDSjngU6mGQfNbMrSjJQLWFrwhI8kmMiDmPcFu1k8RmGmK2akzv/LSH+ZnE167HRgfX2Dil66E4FXDPYa3axZS/jd2WmYNT1FmlTgLxWOaH/GHtXbbK2wU7wSN3XtGu11hnO8CY2J3LuY01+2MUWCX8I/Af/dUXxJuicFE/U9W/A8eS+3O1KUEbsVFNWl7mikvlpe2YN3nB6E/C+SMXxwwYs7BQuNNzMqlaBmf20RFy6H2zNiDHIwngTg3SRPT8/IDxmWG6OcpKnbU81bnj1+PMkVXMJCvkRQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(38100700002)(66556008)(64756008)(38070700005)(122000001)(66446008)(66476007)(186003)(45080400002)(110136005)(54906003)(4326008)(2906002)(55016003)(5660300002)(86362001)(83380400001)(33656002)(7696005)(966005)(52536014)(71200400001)(8936002)(508600001)(53546011)(8676002)(9686003)(15650500001)(6506007)(76116006)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nAagNM4nrc0NPU3nfVbv1h73XGW5iR7irsaJe4gvm21ImQqPmEAAoYqElA9v?=
 =?us-ascii?Q?I/9FezsoRvgPedbyFQ+crb6OKuqN17VwZsDiuvzDNKs3oFenVvcyRCDXvGgT?=
 =?us-ascii?Q?nGXlqs2fHiYW28CNIiFI5xFHYV52tA1xjKEk5pYXiRDCIqW+QzwFbktePnF8?=
 =?us-ascii?Q?nJAiT01be1doRXHvkpltl5yocGl5/w4zElWcITO2vhlCEgbsmBp/IU9p6p5t?=
 =?us-ascii?Q?IA1UOiECRsB73q8XEQX7xfywmdf912ugrzB3bczuUShVPdlsWLzqAagEhipe?=
 =?us-ascii?Q?V0HZVSouNzzbE0hFScs2d83+qgB+ox34YYFfRTG/PQFPZpCOCKoGXbZolnzL?=
 =?us-ascii?Q?L+lwF+zYvG6CsuRZwDI1YeDpt5vx9i3MXh99r1gImiofMowl4xu7nKvL4nQQ?=
 =?us-ascii?Q?MBJSyqA3Y9kdSh1kkQL1OCkCdSQaaOAqlkBCTiz8t14LUj5BZ9UFH+1gLZ6R?=
 =?us-ascii?Q?EOFjCzvgjX51Ltzf1QlfcRM36821TybgQLFiFcOzZ+MN+PZQ+4dso6h7Vpbr?=
 =?us-ascii?Q?erzoxu8xa3kB613goEM2w5etAAC5v8EdP8pgfvQ8hBUOvYN3zD2N/9e3o8Jz?=
 =?us-ascii?Q?Kne/On+8120RQTxi9ZKIKi8hifm4R5FcPEdUR0qrNw3LY3HeXVYVFxZfURP4?=
 =?us-ascii?Q?MdSTv73RMLi3KkNx/uqEwP/d1wpJxeiP3k1+CGSgy7G+dJEm5cOT3/ReedqQ?=
 =?us-ascii?Q?reUAYpguF553+daxlBDb5QKS0Ec46SzMqmsGWHuQUci+8MpngokxORq03YuV?=
 =?us-ascii?Q?25zzzjn5hywbRRKsi10mXHiSSOm2u2fPlG/A7RvDWRt1JKdOhgNswX7Fds1k?=
 =?us-ascii?Q?uxiFmFm0cnjHirsF6A4ktjfFVV/35IxZX5yRDsYjOJ/yXzHljuc8JsZ74n81?=
 =?us-ascii?Q?RH2Y7cfelJ8nm+kYcJOOL8s6++vF/Q3onp60KItps01PsibrBqWwvXFMpA0q?=
 =?us-ascii?Q?qc58OUf4jgJfrAJFyu53nPdcUc1P3lFKIp7GR0LnK+kRaSkA82Hk2rzgjdRA?=
 =?us-ascii?Q?a+YYXE0oYm786Bla4w+BLUoe2LTaNTdYhPFKI4r/Xk8RSdT9gc0YN1PYBZmz?=
 =?us-ascii?Q?RS8AjSiJKKU/KZbjM6lUJ6blqAMWNAb4TDv+vcESxQikU5T83apEUuY9xjXd?=
 =?us-ascii?Q?HBpY6IMGNoDwpjcdfkC8+rjvUGmctwEI2G4VyCIp3U50W+g4TSXCiPPnQjHl?=
 =?us-ascii?Q?bQmt/gC01/Oqk4mia2T7VRvLLiohc0PHJBBZ9ftZnCG1JdwZfqDyUg7/N5HG?=
 =?us-ascii?Q?Rh96WOMJlyanN743NZhw+YaJU6bubs4TUY4+W/T1JuFi59SMUWXI9Hmu/FMG?=
 =?us-ascii?Q?96FUTXDg00xORN5hdXEZlfmtsUKJVTRWhQ4B93K4i7gEoLNaYy7lIjguh8GU?=
 =?us-ascii?Q?/36q1cTOT7UpxeaGML/7mB+X6A0r/OW6xgn7OWGAc4ePK9xUoBYKaULnFWrK?=
 =?us-ascii?Q?j+5o/zmb8NvysQfXZyC7YmA27nujuisjE6fnx4mM28SqdlCNjLtVpofXEFMr?=
 =?us-ascii?Q?qkXV2uioUsBttslPs4MwweJ6AE5+G0SUie53Pfkh8KK3/n2zkhjG2rEqraRb?=
 =?us-ascii?Q?mqhN1RC0WxzSO3QdaPeEBqltwKDRfBvOfCEh+6BI958qBOm1ATGXy7OIqETl?=
 =?us-ascii?Q?o/YakxLhclGIVBh246gC52jqLvYZnxio6IGWbEgFU3utjRTYSkh9WrULau4u?=
 =?us-ascii?Q?q1dicotOGnvTEIwL53fvC4oBohM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ca2334-6c21-47fd-0530-08d9d11af025
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 13:46:27.7011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paPq9pPRPSTLOWtCB/CS9JCVxCQDiX/+quRdEZXjj+hmbexMPFgxJl6+A8HIvd5aj7PyHB600cVs24vLhDoMjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Thorsten Leemhuis <regressions@leemhuis.info>
> Sent: Thursday, January 6, 2022 05:39
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Scott Bruce
> <smbruce@gmail.com>; Chris Hixon <linux-kernel-bugs@hixontech.com>;
> spasswolf@web.de
> Subject: Re: [PATCH v2] drm/amd/display: explicitly update clocks when DC=
 is set
> to D3 in s0i3
>=20
> Hi, this is your Linux kernel regression tracker speaking.
>=20
> On 05.01.22 18:06, Mario Limonciello wrote:
> > The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
> > hard hang on HPD") causes a regression in s0ix where the system will
> > fail to resume properly.  This may be because an HPD was active the las=
t
> > time clocks were updated but clocks didn't get updated again during s0i=
x.
> >
> > So add an extra call to update clocks as part of the suspend routine:
> > dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state
> >
> > In case HPD is set during this time, also check if the call happened du=
ring
> > suspend to allow overriding the WA.
>=20
> Thx for this. Our of interest: is that something that should still go
> into v5.16?

Not in v2.  There were review comments that led to creating a V3.  Once V3 =
is
reviewed if there is time remaining, yes.  If not, then it will be a great =
candidate
for 5.16.1.

>=20
> > Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> > Reported-by: Scott Bruce <smbruce@gmail.com>
> > Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
> > Reported-by: spasswolf@web.de
> > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugzi=
lla.
> kernel.org%2Fshow_bug.cgi%3Fid%3D215436&amp;data=3D04%7C01%7Cmario.li
> monciello%40amd.com%7C024b889dd8af440abbb008d9d1091f27%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637770660416166334%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DrzNDgWba05cL5Z6CTvlblJS96R%2F1
> 8Vh7ku0S%2FQTRbHQ%3D&amp;reserved=3D0
> > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1821&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> C024b889dd8af440abbb008d9d1091f27%7C3dd8961fe4884e608e11a82d994e1
> 83d%7C0%7C0%7C637770660416166334%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000&amp;sdata=3DTQW1vagoGW1DdNvsTVFKlA7gdJVvWhnxZU6BZPn3MH4%3D
> &amp;reserved=3D0
> > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1852&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> C024b889dd8af440abbb008d9d1091f27%7C3dd8961fe4884e608e11a82d994e1
> 83d%7C0%7C0%7C637770660416166334%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000&amp;sdata=3DN4C5PRnke4%2Bpswb3oAMhNsPq3AMLK5VuJG7Ht%2F1n0jk
> %3D&amp;reserved=3D0
>=20
> What is "BugLink"? It's not mention in the kernel's documentation, which
> tells people to use "Link:" for linking to bug reports:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.k=
e
> rnel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fsubmitting-
> patches.html&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7C024b
> 889dd8af440abbb008d9d1091f27%7C3dd8961fe4884e608e11a82d994e183d%7
> C0%7C0%7C637770660416166334%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a
> mp;sdata=3DGntDRw3WuCUZ%2Fys9uDAltqDs2zsBR4qQm3KdDA3VBKo%3D&amp;
> reserved=3D0
>=20
> That is not new, bug recently was made more explicit.
>=20
> Hence, please consider changing them to "Link:", there are tools out
> there that repy on them (I'm running such a tool, but there might be
> others out there we are not aware of).

Thanks for enlightening me.  If I need to spin for v4 I'll fix it up on nex=
t submission,
otherwise I'll fix it up v3 manually before it goes into amd-staging-drm-ne=
xt.

>=20
> FWIW, in principe I agree that we need a seperate tag for this. But then
> we should get this discussed and blessed through the usual channels.
> That's why I recently proposed "Reported:", without much success so far:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ker
> nel.org%2Flkml%2Fc6724c7fb534a46e095e6aef13d996ed9589e578.163904296
> 6.git.linux%40leemhuis.info%2F&amp;data=3D04%7C01%7Cmario.limonciello%40
> amd.com%7C024b889dd8af440abbb008d9d1091f27%7C3dd8961fe4884e608e1
> 1a82d994e183d%7C0%7C0%7C637770660416166334%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000&amp;sdata=3DoBGtPqXfzBcn%2FqUrH7hDQtMIXwIKBY6xh3Qqd0
> xkRjg%3D&amp;reserved=3D0

At least some distributions kernel teams use BugLink (presumably from their=
 own
tools).

>=20
> Ciao, Thorsten
>=20
> > Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
> > Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD =
to
> dcn20")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > changes from v1->v2:
> >  * Add fallthrough statement
> >  * Extend case to check if call was explicitly in s0ix since #1852 show=
ed
> hpd_state
> >    can be set at this time too
> >  * Adjust commit message and title
> >  * Add extra commit and bug fixed to metadata
> >  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 5 ++++-
> >  drivers/gpu/drm/amd/display/dc/core/dc.c                  | 3 +++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> > index fbda42313bfe..fa5efe10b779 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> > @@ -23,6 +23,8 @@
> >   *
> >   */
> >
> > +#include "amdgpu.h"
> > +
> >  #include "dccg.h"
> >  #include "clk_mgr_internal.h"
> >
> > @@ -126,6 +128,7 @@ static void rn_update_clocks(struct clk_mgr
> *clk_mgr_base,
> >  			bool safe_to_lower)
> >  {
> >  	struct clk_mgr_internal *clk_mgr =3D
> TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > +	struct amdgpu_device *adev =3D clk_mgr_base->ctx->driver_context;
> >  	struct dc_clocks *new_clocks =3D &context->bw_ctx.bw.dcn.clk;
> >  	struct dc *dc =3D clk_mgr_base->ctx->dc;
> >  	int display_count;
> > @@ -157,7 +160,7 @@ static void rn_update_clocks(struct clk_mgr
> *clk_mgr_base,
> >  			}
> >
> >  			/* if we can go lower, go lower */
> > -			if (display_count =3D=3D 0 && !hpd_state) {
> > +			if (display_count =3D=3D 0 && (adev->in_s0ix || !hpd_state))
> {
> >
> 	rn_vbios_smu_set_dcn_low_power_state(clk_mgr,
> DCN_PWR_STATE_LOW_POWER);
> >  				/* update power state */
> >  				clk_mgr_base->clks.pwr_state =3D
> DCN_PWR_STATE_LOW_POWER;
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 91c4874473d6..8e0c820f6892 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -3299,6 +3299,9 @@ void dc_set_power_state(
> >  		}
> >
> >  		break;
> > +	case DC_ACPI_CM_POWER_STATE_D3:
> > +		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
> > +		fallthrough;
> >  	default:
> >  		ASSERT(dc->current_state->stream_count =3D=3D 0);
> >  		/* Zero out the current context so that on resume we start with
