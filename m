Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD34C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 02:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7506C10E1E7;
	Wed, 13 Apr 2022 02:50:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A9210E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 02:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Z4ymqwE/kg8lXhiGFlzAh5k8L3cWxLwOc4yJEjip/QpJ99c8WZim2eIBqBL90gnodaNTsK+YXPCSGN+O4s6D+24AnC3Cxm8rzWqcTneEk/VnzyWzANspL3KEawNuprF/waTL1kPFPzOlTxMIdWz7kLy9S8l2usoS9hymtesBLiwz0oyj9Je3/Rxfk75hbvBt6lKH8135EO2bSYBLB7/aegUgnjdFdf+mfm+TNARrItsc2nRKJofbjDjOOUajrhlRD5ByzphKfMsb008igqWx1lZtuzRlK+rMUEENhFEsX6VvMG+RfqXEdFZCbBBLgXuJHJfwcHbcTyfs8RlILDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TboiL+yCgLMhrcXVkcAcOEElVpnYzDRwCTbfdhKMW4s=;
 b=fnGf+7P0j+gb0jwWoDx21BTCoe2wXovXkSwwPaCDOkMzLCyGregTpkHxqagCP5I8Ck7EsNws3oHT7Rw6quFl68Ki8eQ8KkEEO6FaP4EWS2wHdD8ozpJJAyZzxr8teqtpQ12+2uhVOOahPluJsnHF2gwTgYx3fNjzInZAUc4Ne8Np4YJJc7Ci4EefFpAkhVdC6jwR89k7p1zppxfKGdJdmxExwXt+ny8Q/0n0uvhki6zLtKzzMLax5RXEw1dFXIbDMKYcx2VayUQk54sttui+bpB4KC1gt206pwe0zuLtFA0hFkpH2WY2CSx4RxrEbNKZ32dUGdWXg37X8XxzhwX+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TboiL+yCgLMhrcXVkcAcOEElVpnYzDRwCTbfdhKMW4s=;
 b=4UehMNbBefbMtJVsJKQbJ0uCwH5ADKvgbCKl3QYJJC5DAv8phtJKWxUltHYNZNlbrNtT43ubQj4XGoPycqGQbRaM4I1pA6yTNV/I3uVnNO3ZnuxTpJ6AZoQ1ZhCDIhF0HElRqikRidXnBGzBO0hlAhjmNYsQ+0AqHP53gw6ZPKU=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Wed, 13 Apr
 2022 02:50:48 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 02:50:48 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling in
 send_smc_mesg
Thread-Topic: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling
 in send_smc_mesg
Thread-Index: AQHYTiLyUOjnlUM7yUKFWAJa8dUfaqzsxwkAgABeidY=
Date: Wed, 13 Apr 2022 02:50:47 +0000
Message-ID: <CH0PR12MB53873F45BB9F69104BA2F956F0EC9@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220412040801.19905-1-darren.powell@amd.com>
 <9e2af2ba-b6a1-3056-9125-c0106240ba42@amd.com>
In-Reply-To: <9e2af2ba-b6a1-3056-9125-c0106240ba42@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-13T02:50:47.563Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: b82b0377-f7cc-457b-2f75-dd63cc937c3a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9f1e5f6-5cad-4101-4465-08da1cf869e2
x-ms-traffictypediagnostic: BYAPR12MB2888:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2888C56BAA80F9AFCBBE72DBF0EC9@BYAPR12MB2888.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nf92luKDcCRel3mmopL78Im6K0wC6NnRz17VaAmC0dvatsqZ9ipnEzGrswtBpspMuxMqNuip0hmoyUDpMmoGWtCpovlTICcfHoxHc5TE/e9ZLV+U12MtX+fruOz3QpWIFUPIwA+/rt93BzIODBjeoAhdEdq21tQePCt4U4zxWfQB3n1ZIgEXdUXjjg8as/hu70fX03qA8J7seBmqeSDDHMTeE1EbAAUfKqxL7uQ2latUfGy4c1c5ayWmlwp93bBUguSG7p7+wnREXni1kiHLZtavf1tfc4eFkIF7rnJ4W+LzDVur0tQ3RkuyM/++ctf/krrcGdfJ8Ey3hglyItBuHa9vhxKSN2MD8gua+WZQLssy49akDM42QnG9IXUX6C1f1f+j9xf0uaINlIuUrgXKx7pgqHuCB/nHM7rZLBnZPHTR00UaSXCV39poiQCqdlI40Kb78zq+w1cBEtpCHpTxPZu87BcTSxx9y/YnqUkQHeynWj/uhDJs1fU+pvL2QqZhHbWALLnPCCGl0V6YyKJpJyZvXcr7GBM+WvDGzLF0bXJgXPBq/tdkOhmBTrhEpR4itWytYX/ramgNgpsO8lbh4Mo6RGq/1Els50NSZFxWhzcWRm7Kuzvume/HUNY8jbEfF80ukW8+aWoTFTI0gyX1/c2J1NwtUdltHpBm57oUw54ZIXBXb4IhE+FrjA+Y9osT2kMXim6zw8riJ/cHtYsyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(26005)(9686003)(86362001)(53546011)(83380400001)(6506007)(7696005)(5660300002)(19627405001)(186003)(52536014)(2906002)(55016003)(316002)(54906003)(38070700005)(110136005)(33656002)(508600001)(66476007)(66946007)(64756008)(66556008)(66446008)(122000001)(71200400001)(8676002)(38100700002)(4326008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KPN2X384w8tkUzQ0eCaWkHjBSGURTJBd8A/RRzEOoNmO1iFMGQR2v4e0Vti5?=
 =?us-ascii?Q?HVMIt9crYXIb7Oidu60USXDfdiITVIoU+K/SMgW5/9z6mRfCZLRan7YAmTqa?=
 =?us-ascii?Q?ztN8xesLcRsmQx1CjJ76FWaBc0JveGrn4jzX5VD+cbVDpieXYGiIVYRGmvVe?=
 =?us-ascii?Q?oLAok6MHUe+02KpMo3/nEXh1ZkjBKEpjLt2paC4nz9lRPnUfdM+DqDMpZldE?=
 =?us-ascii?Q?LkZSi5sKAtWd6js57QjfEZ4esvd/tep9BVKas6WqOyfLICFs1CO5yntRjJy1?=
 =?us-ascii?Q?wxM5tC8ljiss9xrtWfMiZ7y+PR+v/lLSjj39r+R1z+mLWSLASX0KREWMmrvJ?=
 =?us-ascii?Q?HxaVNgOFqcW8E55JWGEUdnGRL8uY3JyHQ5HyN+IzW6ToZ0N+c2M8bsQmnASD?=
 =?us-ascii?Q?aQQSaPaBqYSR6CBsKT68shmYcc+6QvZ+IEfOoMcUdZz/0xH4v9YMkkE5xHmm?=
 =?us-ascii?Q?d9dfTzGEzbSsD4dgueX+qktgto1KIQ4jQDRzwO1hYZ9GDmJbWzqxcMkAFODL?=
 =?us-ascii?Q?aqXmkaVfKCXWrjfzGONKJYh6BUfHjcTwECqu6CNlMWLnexC4IHAdbm9v8AQ0?=
 =?us-ascii?Q?mIueKjz8C8HPbyHkKG76i4zOMQZELgJ7oBEcIggREoFxkbdEyOsqxxPyBxf/?=
 =?us-ascii?Q?wj6No23rKkpcoj/vyhVkE/kAqvMKJMw25cBAEhK0UuuhB3YfPGOnYVbpZsRD?=
 =?us-ascii?Q?EGBgkMrG+5//ndxKyxto0ZJ5FhzC/h2OyTIng57bIDM2LCrh++uojtu7CQIL?=
 =?us-ascii?Q?q8jZKwSQjU9hdEOaQw/9ieh+qL/2R5DL+1pA/bVwHtwL/+oYspACbwzqVgan?=
 =?us-ascii?Q?UfIb0NOr3in+45Vwz+2sZ3qic0fN8C0ddexbXPqwt7pD0OQ1dAcXPzCReI+a?=
 =?us-ascii?Q?IxeqJC+g+uEzOEreazTWcQlnF2lbd4RtuTqyHpt4Xv+C7h9CIMmPEbvQsIkr?=
 =?us-ascii?Q?3GWgLCyP3IDMpNNN42mBmWkgeFnOUh/tEPThZqd6ytJU8a8UpSnfqe2T5kWj?=
 =?us-ascii?Q?6/hjxSjf4lUgMN4Qq//LaHkSqRMZCJu2oFRnBPAWQobMZkEgCnYzZy6sAKTm?=
 =?us-ascii?Q?sW+qIxa6gB17XILaIYIQch0ye8KS86ELBpXc0yu8NIf77UF5PPP3P73b7FLv?=
 =?us-ascii?Q?kez8LiViK7kFPyZXM+z8Y/kWHsRgfg16T4zItPxAQIX1Xy1JCFStzcsCYJr0?=
 =?us-ascii?Q?hZRmPfF4uZZTenrnK3C28vyAk3Qsf1mdeY6wp/JLNeO+EWLg7Y7LllqVCST3?=
 =?us-ascii?Q?vqsJr0/vjIY0dKLggHx5h+G/iW25ymEqX6eYuNeRuggto6SCrX6ditzo5fga?=
 =?us-ascii?Q?M6qShbsrS///PqV4yqIMzCN3CDTlkRlPhbPbf0R9IYoXI0bcwuvn6Yefhlzi?=
 =?us-ascii?Q?81mt7PglYZCmtuNJIUKeron+QaWMvkZwMmQfiueM7CPZ6Pjhjj06YtNZD5K9?=
 =?us-ascii?Q?l5Sn52N2xnfiwJb/mNnBzmwGlSrPyt02qdl+SnQVEu/pkO+LfZ7HSQt/n4Zd?=
 =?us-ascii?Q?grKDhLSP8AzViC58vin+jUnouF1XmXUiSDlkQHcbia/NA/PLqRS+/xFtJ7Ux?=
 =?us-ascii?Q?qR5RP5aUnF402JTb5RT1ZzBpbGtvos4it/2vyWI27osKIaOp9NNj9dGvGGxp?=
 =?us-ascii?Q?mDXlS79z4gCAMld3FOVRrjI/fDiNWRySoBEVFVskaj6QuqFrq+BiR2+Kc00Q?=
 =?us-ascii?Q?PnauN3EuMhoxWnSVwlRbt5s5+WkUNliI8OaG3w4gNZ2dj0GH?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53873F45BB9F69104BA2F956F0EC9CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f1e5f6-5cad-4101-4465-08da1cf869e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 02:50:47.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SX0Vy2Huz5w+4FXo7uiRZpLb2brVHzcwoujT8cp0S4EvJt2q0rAsmLNmHEauS3j5Q33pPo1KZWQT7BQ0PZJAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
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
Cc: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB53873F45BB9F69104BA2F956F0EC9CH0PR12MB5387namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Yes, it looks like I was a little snippy writing that intro, will lighten t=
he grammar.
Thanks
Darren
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Tuesday, April 12, 2022 5:09 PM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; pmenzel@molgen.mpg.de <pmenzel@molgen.m=
pg.de>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling=
 in send_smc_mesg

I suppose I didn't quite register this on a first read:

On 2022-04-12 00:08, Darren Powell wrote:
> Contrary to the smu_cmn_send_smc_msg_with_param documentation, two

I'd just say

  Clarify the documentation to also mention that we drop
  messages and return success in the following two cases:
     1. ...

That "Contrary to the ..." sounds a bit harsh.

Regards,
Luben

> cases exist where messages are silently dropped with no error returned
> to the caller. These cases occur in unusual situations where either:
>  1. the message target is a virtual GPU, or
>  2. a PCI recovery is underway and the HW is not yet in sync with the SW
>
> For more details see
>  commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>  commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW =
state")
>
> (v2)
>   Reworked with suggestions from Luben & Paul
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..8008ae5508e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *sm=
u)
>   * completion of the command, and return back a value from the SMU in
>   * @read_arg pointer.
>   *
> - * Return 0 on success, -errno on error, if we weren't able to send
> - * the message or if the message completed with some kind of
> - * error. See __smu_cmn_reg2errno() for details of the -errno.
> + * Return 0 on success, -errno when a problem is encountered sending
> + * message or receiving reply. If there is a PCI bus recovery or
> + * the destination is a virtual GPU, the message is simply dropped and
> + * success is also returned.
> + * See __smu_cmn_reg2errno() for details of the -errno.
>   *
>   * If we weren't able to send the message to the SMU, we also print
>   * the error to the standard log.
>
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

Regards,
--
Luben

--_000_CH0PR12MB53873F45BB9F69104BA2F956F0EC9CH0PR12MB5387namp_
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
Yes, it looks like I was a little snippy writing that intro, will lighten t=
he grammar.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Darren</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 12, 2022 5:09 PM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; pmenzel@molgen.mpg.de &lt;=
pmenzel@molgen.mpg.de&gt;; Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com=
&gt;<br>
<b>Subject:</b> Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error h=
andling in send_smc_mesg</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I suppose I didn't quite register this on a first =
read:<br>
<br>
On 2022-04-12 00:08, Darren Powell wrote:<br>
&gt; Contrary to the smu_cmn_send_smc_msg_with_param documentation, two<br>
<br>
I'd just say<br>
<br>
&nbsp; Clarify the documentation to also mention that we drop<br>
&nbsp; messages and return success in the following two cases:<br>
&nbsp;&nbsp;&nbsp;&nbsp; 1. ...<br>
<br>
That &quot;Contrary to the ...&quot; sounds a bit harsh.<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; cases exist where messages are silently dropped with no error returned=
<br>
&gt; to the caller. These cases occur in unusual situations where either:<b=
r>
&gt;&nbsp; 1. the message target is a virtual GPU, or<br>
&gt;&nbsp; 2. a PCI recovery is underway and the HW is not yet in sync with=
 the SW<br>
&gt; <br>
&gt; For more details see<br>
&gt;&nbsp; commit 4ea5081c82c4 (&quot;drm/amd/powerplay: enable SMC message=
 filter&quot;)<br>
&gt;&nbsp; commit bf36b52e781d (&quot;drm/amdgpu: Avoid accessing HW when s=
uspending SW state&quot;)<br>
&gt; <br>
&gt; (v2)<br>
&gt;&nbsp;&nbsp; Reworked with suggestions from Luben &amp; Paul<br>
&gt; <br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---<br>
&gt;&nbsp; 1 file changed, 5 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.c<br>
&gt; index b8d0c70ff668..8008ae5508e6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context =
*smu)<br>
&gt;&nbsp;&nbsp; * completion of the command, and return back a value from =
the SMU in<br>
&gt;&nbsp;&nbsp; * @read_arg pointer.<br>
&gt;&nbsp;&nbsp; *<br>
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
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * If we weren't able to send the message to the SMU, we al=
so print<br>
&gt;&nbsp;&nbsp; * the error to the standard log.<br>
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

--_000_CH0PR12MB53873F45BB9F69104BA2F956F0EC9CH0PR12MB5387namp_--
