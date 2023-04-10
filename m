Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF91EC76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 17:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7661B10E240;
	Mon, 10 Apr 2023 17:35:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E834F10E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 17:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOQanA0gf6lVSMxiVk61WzRHTm06FSVsnPWyklZ7IibAy5Rk4Y/3FKLg4o/WHV78GShZSPuvBUFpcUx8PynxKsadwBGejNKI/98sDQkoe8h6deIzxi6iorLHCnZfuO8xuvcu7gTFAw1UvxxS2c5rSabBa2DckDTu1AIaPUkQCaanM26NdCU87ipgZs2aree1aNgARvNJEUHdiB3ZAYfrUBNRe67UznGOVTcKhUtlYykSi7nYsjavDNUZTZueux/xDVtuxIczQp8Hahz352wAdskgFbK7/ERp6+c8kWTev2oC0gLC20MknF4z2YuYtSHgmPdKsOIuqNeofWi+aUvjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTfvOoGXzD6jiZDE81olrQPoMROFh2R6E/MrmGH54OU=;
 b=Cbp/tyN7GmZ82bvZROHwD18nb3RraGnagQqLN28XdrdBxyMC4z9HBmekhjRBQBpopCcHzHDg1Zh7bUJ9HHsbDwaAFuYlrky9comq9d1iLpzz0zpC47vANp9MoB6x+l8+/HaYAu6YLWO+P1YwN0uCRMCfNyZOSKWbG3xX3+mKZyZ7pKXj4BsvUlqSNzhTsIb08KA1eD8p4vRwnJkqcqVczAqhuKHL6OOm0I1Gj/qB++2GApuFb7LHYNuaDRrHIU+744v1NMNk5neGtLi6vQXXjW0txk0ftPAekTdRmIwVyg8R8knUY87C7j+QqBlMjeJ8izY74vYOPirr2Zzlv1Nqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTfvOoGXzD6jiZDE81olrQPoMROFh2R6E/MrmGH54OU=;
 b=bCkqiWN/ErHONqrFRujDf+kHmpZxYWs7TAKLT+ECQkfC241grAPaXNZF4dRBzG/nD/NB5Z5wu2rALkmpOOYJGxwLNAQzeLBFz8l51J/A1mKXCxtBg2xtCbGAmKMSQp3Z/ATunKPVtHXpzHEEbM+frwa0Dyutq0C7hTvCxImoHKs=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 17:35:46 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc%9]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 17:35:43 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Add logging for DP link traning Test
 Pattern Seqeunces
Thread-Topic: [PATCH v2] drm/amd/display: Add logging for DP link traning Test
 Pattern Seqeunces
Thread-Index: AQHZa9JpFIuBAGZ0akmw+RBYWNwg668kzcXg
Date: Mon, 10 Apr 2023 17:35:43 +0000
Message-ID: <MN2PR12MB4128F4212F6C8EEA37044D3290959@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230410173200.1881023-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230410173200.1881023-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-10T17:35:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=82835e19-2457-4c7f-a387-fd5de2d3f625;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 8156e418-10ba-42f2-06cd-08db39ea02da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtQJOkcl1C0Ngbk1oGRp631t7oBYv5ilrV99NMivj/mSueyLo9mYIom+OvBv8tWQNWQ1HZT7DD9aftNpf/Uo5GSZ4PNwLWooP5ytGoI1L+dh++rDFLU0Y+D/FmSk5DoRasY+gRUkFWZJqjU8QggsdhuHI2h3fUa1/r9BxkNvxNckyWAvkBuUk3l7TGtiymwVIb8eRksNpzju8upDOGxfPu+Y2yD45aml4abNnw9bVgJcXSUci30JL0oqOXFDLf8W/cvLEEFf0RZssCXQfhpJD0VeSfoi74cKx/G4Gp9abzngI8fZ+egFUJifyGShClCGVhXJV/MKZqOgk+i5m3NIDz9tlTmxUzUdMFsZ2krlN5mXUeQmVrUsIKbsIvCyfwo1oWm1btPweLK4Ppz4CI27BFI5gWKKhjHoAuVLvpqGsMgwVdanlnbLegHfApOzd3bfcMhmuK5U9Q0/+mq/3OLbi2PGtTrKu02wcZXPl4C6SOVuF0YhLk4LHPyYLW50UCqITKZ0yLiQqSUxixpdQdQP+6eJdNCB/+yuzQDFrccxsbHVFJzB1Ru11S4/XFGiwfC4NJSwM+C7VB221kr9GYexAK66dUJyvOV9VihXWO10yRoNvxkUHmLVY9lQA8tyUpQu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(33656002)(86362001)(2906002)(38070700005)(55016003)(9686003)(71200400001)(7696005)(53546011)(186003)(83380400001)(26005)(6506007)(76116006)(66476007)(478600001)(4326008)(66556008)(64756008)(66446008)(66946007)(122000001)(41300700001)(8936002)(8676002)(38100700002)(6636002)(110136005)(316002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M/iLi9p3osVvlfAoDiK68Lu2hf8bJzCkHU8nisn48uCnc1qFrw4D9HP7bC+y?=
 =?us-ascii?Q?6u52krv2rcktjYnY2HItP9oFeEwdpa4fFbLGioWwRGxm7Gd0R9Er9+EjMBpS?=
 =?us-ascii?Q?yv0rPPPoWdalhxUiMmNm4KeU+3skKS4X/s7YFe/vnY0szmOyxXpX064xNd/a?=
 =?us-ascii?Q?JBcHoLabrvp3IRuTiUECR+6FCDVQl3bjoTtsDHUNPGPTS0eKzwefD2jP7gMJ?=
 =?us-ascii?Q?ItQE8NfMsrPHWV/VVW3U9SQZdpd+AV+82nR7HXE745+hAUC0TsF8FnDmls6b?=
 =?us-ascii?Q?vmSE45EeQRv0eGzN5jBrQXzl88coVEyveypTEn7HEtDWtBz/hTxFy4ynuXIo?=
 =?us-ascii?Q?E7gMap9q/Iq170489/hCubuQPSCDKBV5xp+sytCqfrlUSrrHcAh3WFg3iKVb?=
 =?us-ascii?Q?bIM/tFst8NGHkKwBQaWSAmWmokEl+/0mn04/2dHMAvZafQCpZWVUWX6dF5n4?=
 =?us-ascii?Q?3+JWKm79IwcovxLIbTrzSj1XoRR1ECQ/Ed5NKcLobi94QX5QxsXkZu1o4l2s?=
 =?us-ascii?Q?EmEsXja4VmzakPeTIrgi50WEKaHPRV+yDMy3a9hA7wDIxPrDZhKfcgIzUBnN?=
 =?us-ascii?Q?sIlI2zuLhlIyMkW20QFNxBou8DYGf+SVa9m41fgWDuVlYYlh1YEfJzyVqW6W?=
 =?us-ascii?Q?FT0wYq36EvMC3gBXchxNQSZNefakpLLzgCse8PWwnoc5WdlUwVXFusy0iofJ?=
 =?us-ascii?Q?097y7QqrjHhhCFCk/1eKpD82astNDuXZ7exLs/qGk2AQjpZPjwp1NPJyruyk?=
 =?us-ascii?Q?jIJcjw1WOtnr37QXCa1XUEj5HvIA/7h41p3v+PYhg3HIeIj/39B//Ic6PEjL?=
 =?us-ascii?Q?8KctVNzo0v2DtVx3tBryRSeuRakh/s3UTU1U+kdJjW3UupL/hAgmZCuZI/YX?=
 =?us-ascii?Q?tJASWyfsyFoumSy+/qRhgu3TK7PvUsPWpP0XoD82VOQn8ua+v8RAVJvFxJTG?=
 =?us-ascii?Q?JGVu+TnU3iIlhmioJ7KZAAL58CSE02J9tygUZAQ0BqunSB8OfCXfJmiwZAyC?=
 =?us-ascii?Q?2KkiZMOF/Ni3BrWxaozxkRroD75p96jWMBoBwQRth80TdxrcXmAtlb3sZnFy?=
 =?us-ascii?Q?/dyENMRHzNd73dmuV0HG9MsDPfu2FBnNtdE2afuw0Stwy28upWLgVsCPwQjp?=
 =?us-ascii?Q?s9W6WKYLl/j2eq1V2u739pfEcFyYycNWDFl1ipQIv+M2ikATwp5/4KuaykNB?=
 =?us-ascii?Q?C0UjnT95aen43cNhqZO0hQJ6YYmZcxAD0I2ei7XBqJqN+6nbgu6iiUVMFFm2?=
 =?us-ascii?Q?eK8nuT2M8lyLwXShPHQ5YZuo4Snk5wdH/wkneF+a9Z5RmWnxD2oSpDLVclO/?=
 =?us-ascii?Q?6e4jENj5crmJl4DSO6Ekn/Jmz+0D+boG+xroJnpC4ydS9rTcbc3PgApaXuIe?=
 =?us-ascii?Q?6cEsi+VElpNKnW2HdWOXAHqWfrqd5uiKbAG9ZeXgwlwA9sVUl0q7xb8n0PK2?=
 =?us-ascii?Q?PtCigofsq3wFP4wNsikJ8N8GQhx3q+vua0c9/BlySeYNbyexuNmjCuoD1lAN?=
 =?us-ascii?Q?8GPuaZY0wSDNm5M/Vi/OOILuGh4pVXfU+TrGg16guOCpcXRaRwx/ZGfh0syN?=
 =?us-ascii?Q?0HEaClWZOI9WyiEAovo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8156e418-10ba-42f2-06cd-08db39ea02da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 17:35:43.5421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYJvIDvWDuDi+FyvzuZme7TiHeWxSEl6ESOXT2mNbSQDaX2TLiQy7w2H6zMqUW8C4oq80TbnTHI9AIc4Cxnxfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>=20
Sent: Monday, April 10, 2023 11:02 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com=
>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>
Subject: [PATCH v2] drm/amd/display: Add logging for DP link traning Test P=
attern Seqeunces

Add some more logging for DP link traning test pattern seqeunces for better=
 debugging.

Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:

 - it is better to use : instead of \n, following the log format in default=
 section (Jerry)
 - seems no need to print dpcd_tr_pattern if it is already mentioned in the=
 string (Jerry)

 .../drm/amd/display/dc/link/protocols/link_dp_training.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training=
.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 70fc0ddf2d7e..265233979cf8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -212,27 +212,36 @@ enum dpcd_training_patterns
=20
 	switch (pattern) {
 	case DP_TRAINING_PATTERN_SEQUENCE_1:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS1\n",=20
+__func__);
 		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_1;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_2:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS2\n",=20
+__func__);
 		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_2;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_3:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS3\n",=20
+__func__);
 		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_3;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS4\n",=20
+__func__);
 		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_4;
 		break;
 	case DP_128b_132b_TPS1:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b training pattern=20
+TPS1\n", __func__);
 		dpcd_tr_pattern =3D DPCD_128b_132b_TPS1;
 		break;
 	case DP_128b_132b_TPS2:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b training pattern=20
+TPS2\n", __func__);
 		dpcd_tr_pattern =3D DPCD_128b_132b_TPS2;
 		break;
 	case DP_128b_132b_TPS2_CDS:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b training pattern TPS2 CD=
S\n",
+					__func__);
 		dpcd_tr_pattern =3D DPCD_128b_132b_TPS2_CDS;
 		break;
 	case DP_TRAINING_PATTERN_VIDEOIDLE:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern videoidle\n",=20
+__func__);
 		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_VIDEOIDLE;
 		break;
 	default:
--
2.25.1
