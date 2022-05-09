Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680E510F20E;
	Mon,  9 May 2022 14:02:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8BA10F1E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT1s7t2jJ8jZK0Vye8RFo/VC+QlJ6iI5R+DQ5dKdqZHtmCmtp8fu6alD7nQUclED50i/b5S3sAbequWFm8WmPKjuS01RCGbZxfCgb2M3T2clyDmUrbyq52m0+X87KDl7fZJfBnJXO4H1Kct5Gnwof4a0wubNbgE9jYX56M+89HzggtXigaGnm+/OSQiLQGaAdtfywM/hA58m2gFQ1CbEUesadkc5szXVB1LwTN5GNEz7fhJHA2szfV1oWgWeeQLppmQQis9yxv7tTc/h6ryCDkx4CxR60dUSgsrsYG1ddPtooThstAxJ2v1+aJf2YVOBFH5BwenxZuQ3rZLkqtI4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZndG6Df4Z3ZPuMRcKH5lbANALl6mkrD1p3ehQFbFMU=;
 b=i4HeAmN0cvkMdCEGbTtjXclR4LceE1ePqk8TeFI7xc2Pe/Cbvo8YWqDNXcygA6eTr0l41eVlzxmVO8aSDiVgKvd+/46TfIZJIZ/NOfeDSnqiCIdfcYvRJJWbAuD9/8w+4N67GvWjuKKJ2OtToSXOF86eJZOuYYNgCd3DdHSFQZm/jLTPtwsvBND/mvUw4EzjRfP/UsnEBAg6FGPcHMF6mLcoInRaWkTOBMrkyTEjxJ9ZGIkig6KJapvv2wQ0YZNoQYfbEVsPnGkzjLDplIpmri1JeQNxiZabGxbPpVjZwipypNe3k8xtYoyLT3JNqbekQz2sXxDTG490guUoRVM0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZndG6Df4Z3ZPuMRcKH5lbANALl6mkrD1p3ehQFbFMU=;
 b=UPbkuasVYbtud6aqpg4TjcQFamqRdG1+vmPr7+ZOd1klHRZZ4zXpN1xcvcMran3ntU4Tgc37NFHlwl7XRzIYB57WpUooxXYRTZ+xi1q3hmj/oZL5tdxwwllp/yvOL3yn1GhVRDPI9CIOzubJKqnPBx9ZEuufljkX8pL3E2ubSpg=
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:02:31 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec%4]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 14:02:31 +0000
From: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 05/17] drm/amd/display: revise Start/End SDP data
Thread-Topic: [PATCH 05/17] drm/amd/display: revise Start/End SDP data
Thread-Index: AQHYYIvB/xBMq75jyEar2K/9s9CF6q0WO8oAgABcwqs=
Date: Mon, 9 May 2022 14:02:31 +0000
Message-ID: <BN9PR12MB514555966520A0B1ACC7F5E68DC69@BN9PR12MB5145.namprd12.prod.outlook.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
 <20220505142323.2566949-6-dingchen.zhang@amd.com>
 <MW4PR12MB5668092BC7B387636C86877A96C69@MW4PR12MB5668.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB5668092BC7B387636C86877A96C69@MW4PR12MB5668.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-09T14:02:30.592Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84c070ed-ec1c-4fe8-3edf-08da31c48f6d
x-ms-traffictypediagnostic: BYAPR12MB3416:EE_
x-microsoft-antispam-prvs: <BYAPR12MB34168F6E27F061017B2148148DC69@BYAPR12MB3416.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJi+hdZeoP0MlxOZnXmIdrwLj51b3gIuZcn8DqIEazqWaMNQHxnHtecksNw0+azSt6peFuUn58hRE9qoVEDiGYMoJ49RFCdJVISz/AN0MqXQZG9Dk/AtJi87OJIpjrowhsmyMFmrHtukw40cfrGb0jquG6N6C+tcNZuag7Mod00EaoXFv4zM9xTRHuUa6HH7hesGtILEysCOfD4uShhQunt+K5drtETspFb9nY9ztPSRqmikYVzdmT+vAms9duU6hSqztJfJMAeeuoWZJGO7jSSSsQWvlGV1zfZTfUXA7LEOLNdiqxJfJODwMimNqClwnh41L1A+I90dOvigG0Vh2IHc5AipJCBjJbJM8p+uPLwGRMVBmtVhrAGKaLmirT2BlPWQFq4AnRC8RiBHt6UN+ZsNcqkcZevay5sjRLg2DNfzCu6SRSfbTLPoPiYW0K82YV8kWtHrAl5MoO6GyuH+7c00LoeR5P9qndWwcB42vOdYHr8fUhhGCyx9eB7ZenrTIMGdJqIMbtni3Nj/sa4bhaXLmOaGdDARa93ot7KuJnMgDVnfyQPPFKnPwWTJ83G4R0v26xu1Uh5Wtt57bnfgY97Id4/UiLCwr70yJbr8Ptn2SQjGKdnkmwd0ca9U/cHekD7KG1vFrPBDZFeNsMK/jGC+FWqTq+Mj5tvy63thFB2uKHF2udB+Fs0cNBKa4xbAZVAuq9uCgO5b7jxowLlmvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(76116006)(66556008)(66446008)(4326008)(66946007)(66476007)(5660300002)(38070700005)(38100700002)(8676002)(64756008)(33656002)(122000001)(2906002)(8936002)(86362001)(91956017)(83380400001)(26005)(52536014)(6506007)(9686003)(71200400001)(55016003)(508600001)(54906003)(316002)(186003)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s6JAOmIKDjDIpvx+OvZY/XszNI8OKnA2fCcdJBLOQKvbrCiRuv3iF4P0vY?=
 =?iso-8859-1?Q?2jzTa4o24CeS9qS2ns4tU/IIHielhn2NKbXxPC2aHMcJKIl2Zi8jqJY48n?=
 =?iso-8859-1?Q?LZybHNTeKnj5eDOnn/viqOmn9cjIu/YOm/zjFAEmL6Y7J3J2fo5kRkJo8Y?=
 =?iso-8859-1?Q?71n/UMlYkby5awcxOdXd3bF8Lz7pnivx+azFw9pQHK/lcnLXv5/GrFtMAD?=
 =?iso-8859-1?Q?e1wBP5RSwnA8BQHTbXtg2SLxAEsttGzNdPCLg2qc+v0w8IvFJjtVtVHxcW?=
 =?iso-8859-1?Q?Zxh8WdxQ6HXT7IROecpu+tjdHN0vL/U2A31DObm14MCyd3znE2MUZTpc00?=
 =?iso-8859-1?Q?CfgaiGdNNJDP3JvdtAgaJl+voN494cLtjfskRXukabQiO5iAMCuYPZZLXo?=
 =?iso-8859-1?Q?MxVbkqoRgjcN1aUYt4gC6GyoPkrkffhMhNyRw3hNHWXG2nXg83376OE/Kv?=
 =?iso-8859-1?Q?xU62yym9Q6LmlUHuNnzifGmreeAMSrJPMh5YPP6lkark6P/ypdmN9z/5rP?=
 =?iso-8859-1?Q?EAD4LhtU5QqtcplWBc6XaKMELZOq6RN69KJjj+oINAB8BCOK6fpz3AQmF4?=
 =?iso-8859-1?Q?yOcMc0HiYYp+GTDApqxna41j0bht9ttj0UDE2OUweOkIPN1mXym3rbb5fW?=
 =?iso-8859-1?Q?eNUWLfL1CcjwrB5RPKDYwK8dOh+4nbMMyNDAYTh5fAo88SnTch/o1hSv7x?=
 =?iso-8859-1?Q?NrNxT+t/0YKUhVEnqhg3Q9SHpwGScqwznKVY5Nz4nzSJjF9VVvsOSLEIdW?=
 =?iso-8859-1?Q?vsmJRD0BAv4tHEkoErygQj86+XehscvJLMf5yZwM17D5wAUVnoKbh9SU/m?=
 =?iso-8859-1?Q?GF1QvfMZyJYILRFHifg8G4Y7odIj+mDzfjkwzUGZCHNkrTJkmoZtT4S12n?=
 =?iso-8859-1?Q?DZepsdUPb3g2dwo1uPJzL2IJZPUIMvXThRa4bUcGMbnHSjy0dGoOZFF+IA?=
 =?iso-8859-1?Q?uOJnKuZs++0IISnmO1BYcS5xiSeHGBDEzdXEtWzVPqoGSW5T8kR3m9STEW?=
 =?iso-8859-1?Q?oIDi+TLmnEbUVQKwpjLFgFInzUjIXaM52ECVz8RTrAuskoAqrQwl1hXjtl?=
 =?iso-8859-1?Q?9SxYdcDvM0rCJ1C4nYXf1DeVUHm6KLX+WjiIOwLohxVunDd+WS6FfhyL6H?=
 =?iso-8859-1?Q?95awWVrV18Pz7Ezx6o8jxFz8m1XSrni4hHPPW+Nr5oBytxKqic1aYSlecc?=
 =?iso-8859-1?Q?bMvXcH0ou5U916XsV33xrchE2NDIrdQDyLZDADbulzgQscOZAuVKSYWlC1?=
 =?iso-8859-1?Q?6N850EaVmNbE1ahsDmF04KayPPi40AMhatTQRPnlTLiaYgJpKZferkv2nD?=
 =?iso-8859-1?Q?e+gr3Cwgo/kugVDhaLpSPdVv0CEWNGV7y7u709F6Xo7AGaZH/0QL/QL1Qc?=
 =?iso-8859-1?Q?wQx4sSl2hksGL2zL19sUSfjGeGTAtdHFV5zrdQ+Eksp0bgHekmfyfN5E3p?=
 =?iso-8859-1?Q?Ipa5CvgOdDxBfmpqW+6roBwj53BImeWvSB3ECoE+22d1PJxOVuUxuB7+eF?=
 =?iso-8859-1?Q?oiW3A327KGXKY+T7EVh+dM2nzmbRgtk8r/bYnid4iY4SapUSEfLIYMR+W1?=
 =?iso-8859-1?Q?3ms2Vxl1A/eR+3thluHO8ze5/zpjDL7oP4nwpy8UY6uz1zKJoNBiK7fiVm?=
 =?iso-8859-1?Q?ZAktzv/RgnZPKM94aWG8exE71KzfElQZzOXAQTO0ZJWm350Vv5BHEmZAuT?=
 =?iso-8859-1?Q?IH50DL4QuajcisslbuD9zTJf837jGGcYvf8adVQx5H8SXQOPjA454SwnBH?=
 =?iso-8859-1?Q?JWsilMq1pfp2bc76a5d5pcKEwJXfesUmuu7FHkPNIs9b7o?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c070ed-ec1c-4fe8-3edf-08da31c48f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 14:02:31.5374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WHf1ZX5Ffm4lPP3LL2ByIokB6/tX6arwh5z9o0LwtdeahKTVKs6tLvwl6DqYL+SVOcQW1uiCLVFB6VzkoWUJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3416
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks Chandan for the comment, will revise the patch.

DZ


From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Sent: Monday, May 9, 2022 4:26 AM
To: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx@lists.freedes=
ktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;=
 Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.=
com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle=
.Kotarac@amd.com>
Subject: RE: [PATCH 05/17] drm/amd/display: revise Start/End SDP data

Hi,

Why not set  "vsc_packet_rev2" when "stream->link->psr_settings.psr_version=
 =3D=3D DC_PSR_VERSION_1"?
This would be safer for future PSR versions also.

BR,
Chandan V N

>[why & how]
>We need to implement the VSC packet rev4 that is required by PSRSU.
>
>Follow the eDP 1.5 spec pg. 257
>
>Signed-off-by: David Zhang <dingchen.zhang@amd.com>
>---
> .../display/modules/info_packet/info_packet.c | 29 +++++++++++++++++--
> 1 file changed, 27 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c=
 b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>index 79bc207415bc..c7d1b48c0478 100644
>--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>@@ -145,8 +145,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_=
state *stream,
>                stereo3dSupport =3D true;
>        }
>
>-      /*VSC packet set to 2 when DP revision >=3D 1.2*/
>-      if (stream->link->psr_settings.psr_version !=3D DC_PSR_VERSION_UNSU=
PPORTED)
>+      /*VSC packet set to 4 for PSR-SU, or 2 for all other PSR support ca=
ses*/
>+      if (stream->link->psr_settings.psr_version =3D=3D DC_PSR_VERSION_SU=
_1)
>+              vsc_packet_revision =3D vsc_packet_rev4;
>+      else if (stream->link->psr_settings.psr_version !=3D
>+DC_PSR_VERSION_UNSUPPORTED)
>                vsc_packet_revision =3D vsc_packet_rev2;
>
>        /* Update to revision 5 for extended colorimetry support */ @@ -15=
9,6 +161,29 @@ void mod_build_vsc_infopacket(const struct >dc_stream_state =
*stream,
>        if (vsc_packet_revision =3D=3D vsc_packet_undefined)
>                return;
>
>+      if (vsc_packet_revision =3D=3D vsc_packet_rev4) {
>+              /* Secondary-data Packet ID =3D 0*/
>+              info_packet->hb0 =3D 0x00;
>+              /* 07h - Packet Type Value indicating Video
>+               * Stream Configuration packet
>+               */
>+              info_packet->hb1 =3D 0x07;
>+              /* 04h =3D VSC SDP supporting 3D stereo + PSR/PSR2 + Y-coor=
dinate
>+               * (applies to eDP v1.4 or higher).
>+               */
>+              info_packet->hb2 =3D 0x04;
>+              /* 0Eh =3D VSC SDP supporting 3D stereo + PSR2
>+               * (HB2 =3D 04h), with Y-coordinate of first scan
>+               * line of the SU region
>+               */
>+              info_packet->hb3 =3D 0x0E;
>+
>+              for (i =3D 0; i < 28; i++)
>+                      info_packet->sb[i] =3D 0;
>+
>+              info_packet->valid =3D true;
>+      }
>+
>        if (vsc_packet_revision =3D=3D vsc_packet_rev2) {
>                /* Secondary-data Packet ID =3D 0*/
>                info_packet->hb0 =3D 0x00;
>--
>2.25.1
