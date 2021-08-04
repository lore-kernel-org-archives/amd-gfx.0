Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2493FC432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 03:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAFC61037
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 03:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEAFC61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE9A6E9AF;
	Wed,  4 Aug 2021 03:34:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F726E9AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 03:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJtGHntfYe7G/ce+Sm+Tya9qaxTN/u6qVlaefyjE8Wv/claZXqq/XD4ZL+gsCSakju1j8AVQDFBPISoauKRVOLGWqwHBVT3ENbE3U1eh0KKxqKc4LN9blAOS3y3RdWljI5m/ZqqM8CcTWReorqceWD1uOSKJSv8hcIkrRxmBoJE3JG71heiegvCrub/NecDJqZbRnKNuCg62xIPxi74eFSRVfk796YaIYp+q6Im5oXy/JYAWdwoH9Zyl7rSPq/sThhK3mLp1JMY/8PhD1K53TYPJu3+6XKN0c3L1aRuM800yTSxO4URTUnIImayLwuuElea3X7/pip7/Kk4dSG7zhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izRJOIa2NPOMLbXyPqfPR5IkO6yv4oKrgNl9ljULaaQ=;
 b=KvuFeNKfHVV6Vmz0klnVVGXbsxO1GMShLWYjP0j9RK+HGotjEtGCzDAovO+p4D3qopq5iTL9k/YvwRztkDTtpA4EOuVgSruC7yVZzlICaWS1C9MLlk0J/A515zcuo336eOenrJTr/onTWRxBvWLwTQr5WyRtfLPruN4Is5/TiUtO704zlu/nBC/XM2nM5SLcrB8GF86y37MAx1lSvORBbAHQSg0LgQaM+rw22zySAztv1sNo1PyskrR8lyXnkGqGpbiIvCLT/Db3f70M+HRBUeCXtIXnjH3JIBtlvJiPc/f5qmneXgM0tRqf3tzHH0sAvzC6l83ihFOwfnwUpPKDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izRJOIa2NPOMLbXyPqfPR5IkO6yv4oKrgNl9ljULaaQ=;
 b=DQ3zkWVGCQY3urmY8Y5vhHKjOb8SfrclqsIqmvgEdW4jJCZXMIEwIxvfVYtfkO6jL355tfgUzVhAaS/2NP4WLBG+9fS79JJiY+DcJdmjrC09VVOtDTcJGji0uSb0LnJhGNe5Rcrb2yf2zHckgflbnPy4wGK2KPiGeXVzS//+vZc=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Wed, 4 Aug
 2021 03:34:24 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%8]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 03:34:24 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Topic: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Index: AdeITLg7attLKh5xSlmEVfidPAvHswAIhHnwAABMeRIAHFsMcA==
Date: Wed, 4 Aug 2021 03:34:23 +0000
Message-ID: <BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <BN9PR12MB52265FFACD0557EC17C4FAE6FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>,
 <DM5PR12MB24697166AD67A6E7A60718AAF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BN9PR12MB522659C72ED024CE62496CFDFBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB522659C72ED024CE62496CFDFBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Guchun.Chen@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-04T03:34:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a7f71c0-678c-4b51-22b0-08d956f8c110
x-ms-traffictypediagnostic: BN9PR12MB5065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB506588CBD3DC79E18B4BF3C7FBF19@BN9PR12MB5065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+bhbgrqq+JduwoJRkQeoO2pots8lccKn8KUfPp6+wrFogCroUttfQA5gkDXqG/vuQmhE+tNLKg+AUOSdinu98TF5QczSm/JhQiI7K9h58//GRPkjsiGhsJULfgE0RGoNryOm7XGACE8fVRusPZmHTybA+uuqtOHv62voaZo5nH0CgY7smLnaI9cIFjOIzOF7UDN+aHZ8DTwULdn+sT/QP32+5LY5pZvrLm8xBu6S6VzxfUe/+i/4yGpXCmzBaLoSGs6HPkHCHDgj38Rh6MkCOpS3vg4JyHSCP4UGCBrsC/XycmyHOi9Zp0Md+G2u0dBiOjRgB9mmGsCC/AnHrd7lylD490UudZNqaB+WZM04a8UvJu7JRc9xa3UPFWf3NwvifmxMKnTCtGKgvY6YftchczXHTgJbEbs+DzKU3Rm55hPwqawkNwdEofcBfR1bRKu1IBSuTvWbiE7D4WNTNxUquLwen2RVvLTJAHiYeatnSs3hP0n6QhjHfTrbxPYTHloMXGCyd9KvPU+jrVAR0Kjev9jEZLx5eiUgiwGWeAm/6DiciBp+YjY0TosuHs1Z3WbgmHBXphlP8/LWdygDZGDT73Q3EFUXGAaXJoeExtkRImAOp6mvwWt66oWBbJWftiupxORlEEGSmj22QK0rTXGLSEhbfATG5qRcHFWrTRZLgVUJGukzKlelomKFYu55WTqeq167uwcYgthuTTQHONe8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(66446008)(64756008)(66556008)(66476007)(66616009)(316002)(186003)(66946007)(478600001)(38100700002)(76116006)(9686003)(8676002)(8936002)(5660300002)(4326008)(55016002)(71200400001)(122000001)(52536014)(7696005)(54906003)(99936003)(86362001)(26005)(2906002)(33656002)(83380400001)(110136005)(53546011)(38070700005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v9PCeaMNee40OtwolpzoVRHNyDguPpLO8rg90PNfzciNhCzFO0nZTL6X2B5O?=
 =?us-ascii?Q?NCAenbn+6B2p4Jopu/+ajwvKyzPXdXoH/6/VFEupoziPI8IBuhcjnXgP176i?=
 =?us-ascii?Q?JleiFiNGecA0WLvjzj48U4yo7ebwVdyjzjMClzWg10XL4Po5IO9oKUBAb0zJ?=
 =?us-ascii?Q?eBWK/jZe78CTIzEOdntwlIPXN0Nvryd3BJkJswWE3Pf1DLKozVSJWw5dOX20?=
 =?us-ascii?Q?JgkhadXwbgGgmw54EsVLC8kTaFYLQuSdoihBpf5PTiyqn5RPAGsE370uLrQx?=
 =?us-ascii?Q?7q0k68xGBCZD3rznEWhhJeCzCa3im/7zLb7rknOfo9djmapnb34y6JwsSpzj?=
 =?us-ascii?Q?m7llPmq5iNWd5mUmnTExT23qzfxsgRax9zoOUTayI5BNhD+F0UzZZFSo4+Yt?=
 =?us-ascii?Q?ttsZIQhW20YcLJ7lLvniRdZLF/M3DSMCAxExuzU5db201P5d3MGn9M8nYyMg?=
 =?us-ascii?Q?O+hg5zIMw/9pOUSo2jqTJvb6IcB4YPZe7dbIlFo1yGbj3b8dDnR+1LapRs9m?=
 =?us-ascii?Q?bMcHlJ5BXBojjGGmJhbYbX9rcCH/wZFrppuj2vXnGvxf+11gCcJ75ftaJsKF?=
 =?us-ascii?Q?Lf2LsBLNvZY4Hd9nQsY0kDki8j59riA0dQlHxAxbK45KDBMjNPJtglaRTLAb?=
 =?us-ascii?Q?pNEahucQnoJ/RrpdquWr7Z87CQqI5HupebKoAqBUcxj7TA2bsnYvhHacwA1t?=
 =?us-ascii?Q?C4ytPzXdYR35OpUWsKcQ73tNQXSWH2HuwUVsp2sS/cfg6V4YzDSAe/x9eFSd?=
 =?us-ascii?Q?yI/ob11u4sSTkFZHnwiTdGL5N3+R2YIJWOPQBx7PwonD+TbOCrkFec5UEB4h?=
 =?us-ascii?Q?GQyuAZKczKe+kE+13NOjFMTHyjdrT4ayJv+uXAVZLtA0JBfZ77hM+8isVXqH?=
 =?us-ascii?Q?kufVnYZRrHK3Qm8pbOBZmwJgOSYWbqqwWL3pg+iHWTv+jf0mSIFBpDAiK4S0?=
 =?us-ascii?Q?eSzUOWsKIMYJUuOH2hUPbBPlifnycfVMxi3sVo3/2a1k/DZNL6ijZLaevCow?=
 =?us-ascii?Q?ZYbmuwnevq4yaaYdw6Z84hI/Cwwj6bRClXjPkozbI2LAUEJrhFrhS3wCrLRF?=
 =?us-ascii?Q?9BZ9Cxxpu3w1KMwjZoYYe7rPNO4DPHWlmm6aCsq7ABzaVvWCfGhBuUfYysmi?=
 =?us-ascii?Q?Y3E3GduS3oy4faIx5OYC103QLsyA1j9dCbjgRaG+7G7xlyOTO/Q74bdEvGYe?=
 =?us-ascii?Q?bpdZQDh3NUvkbNBhs1Yu7SwS47YMNxHu7TARQukKPOl67AXihkfOQN5AdZW4?=
 =?us-ascii?Q?m4MjWzLMrEcxqtBuL43fOGr6qNwiTvJwNcZ7oWzT9wYHKH5mhOkjIl5xJBsN?=
 =?us-ascii?Q?ci35AbNPZbPBGRfvXKqfkZqn?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7f71c0-678c-4b51-22b0-08d956f8c110
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 03:34:23.8403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/i510a5d1RMYirrUWDaC6b7ZQU/UCbLX5TI2vsD0SAoWKvDM2fwuanOpFsOcHvynY0EphK4gAehMIL8l7TCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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

--_004_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_"

--_000_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

@Chen, Guchun<mailto:Guchun.Chen@amd.com>,
Based off your feedback I double checked the code, and I changed my opinion=
 about it, I think it's better just to reuse the original mutex for now. I'=
ve submitted an updated patch for review

From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, August 3, 2021 10:07 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss

Hello Guchun,

In most of those cases you are right it is redundant, the reason i kept the=
m separate for now is to resolve this bug while also keeping those interfac=
es modular, and not affecting the psp submit sequence yet. We are planning =
a bigger change to that source to remove alot of the duplicate code regardi=
ng the cmd buffer prepare/submit flow and will probably go back down to one=
 mutex there.

Thank you,
John Clements

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, August 3, 2021 9:58 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]



Before calling into psp_cmd_submit_buf, a mutex psp->cmd_buf_mutex is there=
, and after entering psp_cmd_submit_buf, there is another mutex psp->mutex,=
 is it a bit redundant?



Regards,

Guchun



From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, August 3, 2021 5:50 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Chen, Guchun <Guchun.Chen@amd=
.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access



[AMD Official Use Only]



Submitting patch to synchronize access to psp cmd submission memory to reso=
lve potential race conditions.

--_000_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsipheader23c54b6f, li.xmsipheader23c54b6f, div.xmsipheader23c54b6f
	{mso-style-name:x_msipheader23c54b6f;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheadera4477989, li.xmsipheadera4477989, div.xmsipheadera4477989
	{mso-style-name:x_msipheadera4477989;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
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
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a id=3D"OWAAM657D9489ADBF421697FD567A7A47E1AE" href=
=3D"mailto:Guchun.Chen@amd.com"><span style=3D"font-family:&quot;Calibri&qu=
ot;,sans-serif;text-decoration:none">@Chen, Guchun</span></a>,<o:p></o:p></=
p>
<p class=3D"MsoNormal">Based off your feedback I double checked the code, a=
nd I changed my opinion about it, I think it&#8217;s better just to reuse t=
he original mutex for now. I&#8217;ve submitted an updated patch for review=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, August 3, 2021 10:07 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Hello Guchun,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">In most of those cases you are right it is redundant, t=
he reason i kept them separate for now is to resolve this bug while also ke=
eping those interfaces modular, and not
 affecting the psp submit sequence yet. We are planning a bigger change to =
that source to remove alot of the duplicate code regarding the cmd buffer p=
repare/submit flow and will probably go back down to one mutex there.<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Thank you,
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">John Clements<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, August 3, 2021 9:58 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheader23c54b6f"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Before calling into psp_cmd_submit_buf, a mutex psp=
-&gt;cmd_buf_mutex is there, and after entering psp_cmd_submit_buf, there i=
s another mutex psp-&gt;mutex, is it a bit redundant?<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:J=
ohn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 3, 2021 5:50 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto=
:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: added synchronization for psp cmd buf a=
ccess<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsipheadera4477989"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]</span><o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Submitting patch to synchronize access to psp cmd s=
ubmission memory to resolve potential race conditions.<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_--

--_004_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-added-synchronization-for-psp-cmd-buf-acc.patch"
Content-Description:  0001-drm-amdgpu-added-synchronization-for-psp-cmd-buf-acc.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-added-synchronization-for-psp-cmd-buf-acc.patch";
	size=20630; creation-date="Wed, 04 Aug 2021 03:34:00 GMT";
	modification-date="Wed, 04 Aug 2021 03:34:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkOTk4ZTEwYTZjZjE1ZGM3NzY3YzcyYzhlYzljNGZhMjE2MDMyNDRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgNCBBdWcgMjAyMSAxMTozMTowMyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBhZGRlZCBzeW5jaHJvbml6YXRpb24gZm9yIHBzcCBjbWQgYnVmIGFjY2Vz
cwoKcmVzb2x2ZWQgcmFjZSBjb25kaXRpb24gYWNjZXNzaW5nIHBzcCBjbWQgc3VibWlzc2lvbiBt
ZW1vcnkKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNv
bT4KQ2hhbmdlLUlkOiBJNTY2MDRjNTNjZGI4MmY5OGRkNmYyZWRjMzVjZjBmZDc5NmE4MTRiYwot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIwNSArKysrKysr
KysrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMzkgaW5zZXJ0aW9ucygrKSwgNjYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4
IGYzNDFkNTFmYmFhMi4uOWRjMmQ2ZDk3MTJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCkBAIC00MjYsOCArNDI2LDYgQEAgcHNwX2NtZF9zdWJtaXRfYnVmKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwLAogCWlmICghZHJtX2Rldl9lbnRlcigmcHNwLT5hZGV2LT5kZGV2
LCAmaWR4KSkKIAkJcmV0dXJuIDA7CiAKLQltdXRleF9sb2NrKCZwc3AtPm11dGV4KTsKLQogCW1l
bXNldChwc3AtPmNtZF9idWZfbWVtLCAwLCBQU1BfQ01EX0JVRkZFUl9TSVpFKTsKIAogCW1lbWNw
eShwc3AtPmNtZF9idWZfbWVtLCBjbWQsIHNpemVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCkp
OwpAQCAtNDg3LDExICs0ODUsMjYgQEAgcHNwX2NtZF9zdWJtaXRfYnVmKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwLAogCX0KIAogZXhpdDoKLQltdXRleF91bmxvY2soJnBzcC0+bXV0ZXgpOwogCWRy
bV9kZXZfZXhpdChpZHgpOwogCXJldHVybiByZXQ7CiB9CiAKK3N0YXRpYyBzdHJ1Y3QgcHNwX2dm
eF9jbWRfcmVzcCAqYWNxdWlyZV9wc3BfY21kX2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkK
K3sKKwlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gcHNwLT5jbWQ7CisKKwltdXRleF9s
b2NrKCZwc3AtPm11dGV4KTsKKworCW1lbXNldChjbWQsIDAsIHNpemVvZihzdHJ1Y3QgcHNwX2dm
eF9jbWRfcmVzcCkpOworCisJcmV0dXJuIGNtZDsKK30KKwordm9pZCByZWxlYXNlX3BzcF9jbWRf
YnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQoreworCW11dGV4X3VubG9jaygmcHNwLT5tdXRl
eCk7Cit9CisKIHN0YXRpYyB2b2lkIHBzcF9wcmVwX3Rtcl9jbWRfYnVmKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwLAogCQkJCSBzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAogCQkJCSB1aW50
NjRfdCB0bXJfbWMsIHN0cnVjdCBhbWRncHVfYm8gKnRtcl9ibykKQEAgLTUwMCw4ICs1MTMsNiBA
QCBzdGF0aWMgdm9pZCBwc3BfcHJlcF90bXJfY21kX2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBz
cCwKIAl1aW50MzJfdCBzaXplID0gYW1kZ3B1X2JvX3NpemUodG1yX2JvKTsKIAl1aW50NjRfdCB0
bXJfcGEgPSBhbWRncHVfZ21jX3ZyYW1fcGEoYWRldiwgdG1yX2JvKTsKIAotCW1lbXNldChjbWQs
IDAsIHNpemVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCkpOwotCiAJaWYgKGFtZGdwdV9zcmlv
dl92Zihwc3AtPmFkZXYpKQogCQljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfU0VUVVBfVk1SOwog
CWVsc2UKQEAgLTUxNyw4ICs1MjgsNiBAQCBzdGF0aWMgdm9pZCBwc3BfcHJlcF90bXJfY21kX2J1
ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIHN0YXRpYyB2b2lkIHBzcF9wcmVwX2xvYWRfdG9j
X2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKIAkJCQkgICAgICB1aW50NjRf
dCBwcmlfYnVmX21jLCB1aW50MzJfdCBzaXplKQogewotCW1lbXNldChjbWQsIDAsIHNpemVvZihz
dHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCkpOwotCiAJY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0xP
QURfVE9DOwogCWNtZC0+Y21kLmNtZF9sb2FkX3RvYy50b2NfcGh5X2FkZHJfbG8gPSBsb3dlcl8z
Ml9iaXRzKHByaV9idWZfbWMpOwogCWNtZC0+Y21kLmNtZF9sb2FkX3RvYy50b2NfcGh5X2FkZHJf
aGkgPSB1cHBlcl8zMl9iaXRzKHByaV9idWZfbWMpOwpAQCAtNTMwLDcgKzUzOSw3IEBAIHN0YXRp
YyBpbnQgcHNwX2xvYWRfdG9jKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCQkJdWludDMyX3Qg
KnRtcl9zaXplKQogewogCWludCByZXQ7Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9
IHBzcC0+Y21kOworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBhY3F1aXJlX3BzcF9j
bWRfYnVmKHBzcCk7CiAKIAkvKiBDb3B5IHRvYyB0byBwc3AgZmlybXdhcmUgcHJpdmF0ZSBidWZm
ZXIgKi8KIAlwc3BfY29weV9mdyhwc3AsIHBzcC0+dG9jLnN0YXJ0X2FkZHIsIHBzcC0+dG9jLnNp
emVfYnl0ZXMpOwpAQCAtNTQyLDYgKzU1MSw4IEBAIHN0YXRpYyBpbnQgcHNwX2xvYWRfdG9jKHN0
cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCWlmICghcmV0KQogCQkqdG1yX3NpemUgPSBwc3AtPmNt
ZF9idWZfbWVtLT5yZXNwLnRtcl9zaXplOwogCisJcmVsZWFzZV9wc3BfY21kX2J1Zihwc3ApOwor
CiAJcmV0dXJuIHJldDsKIH0KIApAQCAtNTk4LDcgKzYwOSw3IEBAIHN0YXRpYyBib29sIHBzcF9z
a2lwX3RtcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHN0YXRpYyBpbnQgcHNwX3Rtcl9sb2Fk
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCWludCByZXQ7Ci0Jc3RydWN0IHBzcF9nZnhf
Y21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21kOworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7
CiAKIAkvKiBGb3IgTmF2aTEyIGFuZCBDSElQX1NJRU5OQV9DSUNITElEIFNSSU9WLCBkbyBub3Qg
c2V0IHVwIFRNUi4KIAkgKiBBbHJlYWR5IHNldCB1cCBieSBob3N0IGRyaXZlci4KQEAgLTYwNiw2
ICs2MTcsOCBAQCBzdGF0aWMgaW50IHBzcF90bXJfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBz
cCkKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgJiYgcHNwX3NraXBfdG1yKHBzcCkp
CiAJCXJldHVybiAwOwogCisJY21kID0gYWNxdWlyZV9wc3BfY21kX2J1Zihwc3ApOworCiAJcHNw
X3ByZXBfdG1yX2NtZF9idWYocHNwLCBjbWQsIHBzcC0+dG1yX21jX2FkZHIsIHBzcC0+dG1yX2Jv
KTsKIAlEUk1fSU5GTygicmVzZXJ2ZSAweCVseCBmcm9tIDB4JWxseCBmb3IgUFNQIFRNUlxuIiwK
IAkJIGFtZGdwdV9ib19zaXplKHBzcC0+dG1yX2JvKSwgcHNwLT50bXJfbWNfYWRkcik7CkBAIC02
MTMsMTQgKzYyNiwxNCBAQCBzdGF0aWMgaW50IHBzcF90bXJfbG9hZChzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBOVUxMLCBjbWQsCiAJCQkJ
IHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwogCisJcmVsZWFzZV9wc3BfY21kX2J1Zihwc3ApOwor
CiAJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIHZvaWQgcHNwX3ByZXBfdG1yX3VubG9hZF9jbWRf
YnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCQkJCSAgICAgICAgc3RydWN0IHBzcF9nZnhf
Y21kX3Jlc3AgKmNtZCkKIHsKLQltZW1zZXQoY21kLCAwLCBzaXplb2Yoc3RydWN0IHBzcF9nZnhf
Y21kX3Jlc3ApKTsKLQogCWlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKIAkJY21kLT5j
bWRfaWQgPSBHRlhfQ01EX0lEX0RFU1RST1lfVk1SOwogCWVsc2UKQEAgLTYzMCw3ICs2NDMsNyBA
QCBzdGF0aWMgdm9pZCBwc3BfcHJlcF90bXJfdW5sb2FkX2NtZF9idWYoc3RydWN0IHBzcF9jb250
ZXh0ICpwc3AsCiBzdGF0aWMgaW50IHBzcF90bXJfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwKQogewogCWludCByZXQ7Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+
Y21kOworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVm
KHBzcCk7CiAKIAlwc3BfcHJlcF90bXJfdW5sb2FkX2NtZF9idWYocHNwLCBjbWQpOwogCURSTV9J
TkZPKCJmcmVlIFBTUCBUTVIgYnVmZmVyXG4iKTsKQEAgLTYzOCw2ICs2NTEsOCBAQCBzdGF0aWMg
aW50IHBzcF90bXJfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldCA9IHBzcF9j
bWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwKIAkJCQkgcHNwLT5mZW5jZV9idWZfbWNfYWRk
cik7CiAKKwlyZWxlYXNlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlyZXR1cm4gcmV0OwogfQogCkBA
IC02NjIsOSArNjc3LDcgQEAgaW50IHBzcF9nZXRfZndfYXR0ZXN0YXRpb25fcmVjb3Jkc19hZGRy
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCQkJCQl1aW50NjRfdCAqb3V0cHV0X3B0cikKIHsK
IAlpbnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNtZDsKLQot
CW1lbXNldChjbWQsIDAsIHNpemVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCkpOworCXN0cnVj
dCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7CiAKIAlpZiAoIW91dHB1dF9wdHIpCiAJCXJldHVybiAt
RUlOVkFMOwpAQCAtNjcyLDYgKzY4NSw4IEBAIGludCBwc3BfZ2V0X2Z3X2F0dGVzdGF0aW9uX3Jl
Y29yZHNfYWRkcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAlpZiAoYW1kZ3B1X3NyaW92X3Zm
KHBzcC0+YWRldikpCiAJCXJldHVybiAwOwogCisJY21kID0gYWNxdWlyZV9wc3BfY21kX2J1Zihw
c3ApOworCiAJY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0dFVF9GV19BVFRFU1RBVElPTjsKIAog
CXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwKQEAgLTY4MiwxOSArNjk3
LDIxIEBAIGludCBwc3BfZ2V0X2Z3X2F0dGVzdGF0aW9uX3JlY29yZHNfYWRkcihzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCwKIAkJCSAgICAgICgodWludDY0X3QpY21kLT5yZXNwLnVyZXNwLmZ3YXJf
ZGJfaW5mby5md2FyX2RiX2FkZHJfaGkgPDwgMzIpOwogCX0KIAorCXJlbGVhc2VfcHNwX2NtZF9i
dWYocHNwKTsKKwogCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgcHNwX2Jvb3RfY29uZmln
X2dldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgKmJvb3RfY2ZnKQogewog
CXN0cnVjdCBwc3BfY29udGV4dCAqcHNwID0gJmFkZXYtPnBzcDsKLQlzdHJ1Y3QgcHNwX2dmeF9j
bWRfcmVzcCAqY21kID0gcHNwLT5jbWQ7CisJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsK
IAlpbnQgcmV0OwogCiAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKIAkJcmV0dXJuIDA7CiAK
LQltZW1zZXQoY21kLCAwLCBzaXplb2Yoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3ApKTsKKwljbWQg
PSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBzcCk7CiAKIAljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURf
Qk9PVF9DRkc7CiAJY21kLT5jbWQuYm9vdF9jZmcuc3ViX2NtZCA9IEJPT1RDRkdfQ01EX0dFVDsK
QEAgLTcwNSwzNyArNzIyLDQ1IEBAIHN0YXRpYyBpbnQgcHNwX2Jvb3RfY29uZmlnX2dldChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgKmJvb3RfY2ZnKQogCQkJKGNtZC0+cmVz
cC51cmVzcC5ib290X2NmZy5ib290X2NmZyAmIEJPT1RfQ09ORklHX0dFQ0MpID8gMSA6IDA7CiAJ
fQogCisJcmVsZWFzZV9wc3BfY21kX2J1Zihwc3ApOworCiAJcmV0dXJuIHJldDsKIH0KIAogc3Rh
dGljIGludCBwc3BfYm9vdF9jb25maWdfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1
aW50MzJfdCBib290X2NmZykKIHsKKwlpbnQgcmV0OwogCXN0cnVjdCBwc3BfY29udGV4dCAqcHNw
ID0gJmFkZXYtPnBzcDsKLQlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gcHNwLT5jbWQ7
CisJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKIAogCWlmIChhbWRncHVfc3Jpb3ZfdmYo
YWRldikpCiAJCXJldHVybiAwOwogCi0JbWVtc2V0KGNtZCwgMCwgc2l6ZW9mKHN0cnVjdCBwc3Bf
Z2Z4X2NtZF9yZXNwKSk7CisJY21kID0gYWNxdWlyZV9wc3BfY21kX2J1Zihwc3ApOwogCiAJY21k
LT5jbWRfaWQgPSBHRlhfQ01EX0lEX0JPT1RfQ0ZHOwogCWNtZC0+Y21kLmJvb3RfY2ZnLnN1Yl9j
bWQgPSBCT09UQ0ZHX0NNRF9TRVQ7CiAJY21kLT5jbWQuYm9vdF9jZmcuYm9vdF9jb25maWcgPSBi
b290X2NmZzsKIAljbWQtPmNtZC5ib290X2NmZy5ib290X2NvbmZpZ192YWxpZCA9IGJvb3RfY2Zn
OwogCi0JcmV0dXJuIHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5mZW5j
ZV9idWZfbWNfYWRkcik7CisJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21k
LCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKKworCXJlbGVhc2VfcHNwX2NtZF9idWYocHNwKTsK
KworCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgcHNwX3JsX2xvYWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiB7CisJaW50IHJldDsKIAlzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCA9
ICZhZGV2LT5wc3A7Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21kOwot
Ci0JbWVtc2V0KGNtZCwgMCwgc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwKSk7CisJc3Ry
dWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKIAogCWlmICghaXNfcHNwX2Z3X3ZhbGlkKHBzcC0+
cmwpKQogCQlyZXR1cm4gMDsKIAorCWNtZCA9IGFjcXVpcmVfcHNwX2NtZF9idWYocHNwKTsKKwog
CW1lbXNldChwc3AtPmZ3X3ByaV9idWYsIDAsIFBTUF8xX01FRyk7CiAJbWVtY3B5KHBzcC0+Zndf
cHJpX2J1ZiwgcHNwLT5ybC5zdGFydF9hZGRyLCBwc3AtPnJsLnNpemVfYnl0ZXMpOwogCkBAIC03
NDUsMTQgKzc3MCwxNiBAQCBzdGF0aWMgaW50IHBzcF9ybF9sb2FkKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCWNtZC0+Y21kLmNtZF9sb2FkX2lwX2Z3LmZ3X3NpemUgPSBwc3AtPnJsLnNp
emVfYnl0ZXM7CiAJY21kLT5jbWQuY21kX2xvYWRfaXBfZncuZndfdHlwZSA9IEdGWF9GV19UWVBF
X1JFR19MSVNUOwogCi0JcmV0dXJuIHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwg
cHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CisJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwg
TlVMTCwgY21kLCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKKworCXJlbGVhc2VfcHNwX2NtZF9i
dWYocHNwKTsKKworCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyB2b2lkIHBzcF9wcmVwX2FzZF9s
b2FkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKIAkJCQl1aW50NjRfdCBh
c2RfbWMsIHVpbnQzMl90IHNpemUpCiB7Ci0JbWVtc2V0KGNtZCwgMCwgc2l6ZW9mKHN0cnVjdCBw
c3BfZ2Z4X2NtZF9yZXNwKSk7Ci0KIAljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfTE9BRF9BU0Q7
CiAJY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX3BoeV9hZGRyX2xvID0gbG93ZXJfMzJfYml0cyhh
c2RfbWMpOwogCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9waHlfYWRkcl9oaSA9IHVwcGVyXzMy
X2JpdHMoYXNkX21jKTsKQEAgLTc2Niw3ICs3OTMsNyBAQCBzdGF0aWMgdm9pZCBwc3BfcHJlcF9h
c2RfbG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCiBzdGF0aWMgaW50
IHBzcF9hc2RfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwotCXN0
cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNtZDsKKwlzdHJ1Y3QgcHNwX2dmeF9j
bWRfcmVzcCAqY21kOwogCiAJLyogSWYgUFNQIHZlcnNpb24gZG9lc24ndCBtYXRjaCBBU0QgdmVy
c2lvbiwgYXNkIGxvYWRpbmcgd2lsbCBiZSBmYWlsZWQuCiAJICogYWRkIHdvcmthcm91bmQgdG8g
YnlwYXNzIGl0IGZvciBzcmlvdiBub3cuCkBAIC03NzUsNiArODAyLDggQEAgc3RhdGljIGludCBw
c3BfYXNkX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKGFtZGdwdV9zcmlvdl92
Zihwc3AtPmFkZXYpIHx8ICFwc3AtPmFzZF91Y29kZV9zaXplKQogCQlyZXR1cm4gMDsKIAorCWNt
ZCA9IGFjcXVpcmVfcHNwX2NtZF9idWYocHNwKTsKKwogCXBzcF9jb3B5X2Z3KHBzcCwgcHNwLT5h
c2Rfc3RhcnRfYWRkciwgcHNwLT5hc2RfdWNvZGVfc2l6ZSk7CiAKIAlwc3BfcHJlcF9hc2RfbG9h
ZF9jbWRfYnVmKGNtZCwgcHNwLT5md19wcmlfbWNfYWRkciwKQEAgLTc4NywxNCArODE2LDE0IEBA
IHN0YXRpYyBpbnQgcHNwX2FzZF9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCQlwc3At
PmFzZF9jb250ZXh0LnNlc3Npb25faWQgPSBjbWQtPnJlc3Auc2Vzc2lvbl9pZDsKIAl9CiAKKwly
ZWxlYXNlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgdm9p
ZCBwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21k
LAogCQkJCSAgICAgICB1aW50MzJfdCBzZXNzaW9uX2lkKQogewotCW1lbXNldChjbWQsIDAsIHNp
emVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCkpOwotCiAJY21kLT5jbWRfaWQgPSBHRlhfQ01E
X0lEX1VOTE9BRF9UQTsKIAljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSBzZXNz
aW9uX2lkOwogfQpAQCAtODAyLDcgKzgzMSw3IEBAIHN0YXRpYyB2b2lkIHBzcF9wcmVwX3RhX3Vu
bG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCiBzdGF0aWMgaW50IHBz
cF9hc2RfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCWludCByZXQ7Ci0Jc3Ry
dWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21kOworCXN0cnVjdCBwc3BfZ2Z4X2Nt
ZF9yZXNwICpjbWQ7CiAKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikpCiAJCXJldHVy
biAwOwpAQCAtODEwLDYgKzgzOSw4IEBAIHN0YXRpYyBpbnQgcHNwX2FzZF91bmxvYWQoc3RydWN0
IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFwc3AtPmFzZF9jb250ZXh0LmFzZF9pbml0aWFsaXpl
ZCkKIAkJcmV0dXJuIDA7CiAKKwljbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlw
c3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+YXNkX2NvbnRleHQuc2Vzc2lvbl9p
ZCk7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBOVUxMLCBjbWQsCkBAIC04MTcs
MTQgKzg0OCwxNCBAQCBzdGF0aWMgaW50IHBzcF9hc2RfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogCWlmICghcmV0KQogCQlwc3AtPmFzZF9jb250ZXh0LmFzZF9pbml0aWFsaXplZCA9
IGZhbHNlOwogCisJcmVsZWFzZV9wc3BfY21kX2J1Zihwc3ApOworCiAJcmV0dXJuIHJldDsKIH0K
IAogc3RhdGljIHZvaWQgcHNwX3ByZXBfcmVnX3Byb2dfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9j
bWRfcmVzcCAqY21kLAogCQl1aW50MzJfdCBpZCwgdWludDMyX3QgdmFsdWUpCiB7Ci0JbWVtc2V0
KGNtZCwgMCwgc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwKSk7Ci0KIAljbWQtPmNtZF9p
ZCA9IEdGWF9DTURfSURfUFJPR19SRUc7CiAJY21kLT5jbWQuY21kX3NldHVwX3JlZ19wcm9nLnJl
Z192YWx1ZSA9IHZhbHVlOwogCWNtZC0+Y21kLmNtZF9zZXR1cF9yZWdfcHJvZy5yZWdfaWQgPSBp
ZDsKQEAgLTgzMywxNyArODY0LDIxIEBAIHN0YXRpYyB2b2lkIHBzcF9wcmVwX3JlZ19wcm9nX2Nt
ZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKIGludCBwc3BfcmVnX3Byb2dyYW0o
c3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIGVudW0gcHNwX3JlZ19wcm9nX2lkIHJlZywKIAkJdWlu
dDMyX3QgdmFsdWUpCiB7Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21k
OworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7CiAJaW50IHJldCA9IDA7CiAKIAlpZiAo
cmVnID49IFBTUF9SRUdfTEFTVCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwljbWQgPSBhY3F1aXJl
X3BzcF9jbWRfYnVmKHBzcCk7CisKIAlwc3BfcHJlcF9yZWdfcHJvZ19jbWRfYnVmKGNtZCwgcmVn
LCB2YWx1ZSk7CiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLCBwc3At
PmZlbmNlX2J1Zl9tY19hZGRyKTsKIAlpZiAocmV0KQogCQlEUk1fRVJST1IoIlBTUCBmYWlsZWQg
dG8gcHJvZ3JhbSByZWcgaWQgJWQiLCByZWcpOwogCisJcmVsZWFzZV9wc3BfY21kX2J1Zihwc3Ap
OworCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtODUzLDggKzg4OCw2IEBAIHN0YXRpYyB2b2lkIHBz
cF9wcmVwX3RhX2xvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAogCQkJ
CSAgICAgdWludDY0X3QgdGFfc2hhcmVkX21jLAogCQkJCSAgICAgdWludDMyX3QgdGFfc2hhcmVk
X3NpemUpCiB7Ci0JbWVtc2V0KGNtZCwgMCwgc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNw
KSk7Ci0KIAljbWQtPmNtZF9pZAkJCQk9IEdGWF9DTURfSURfTE9BRF9UQTsKIAljbWQtPmNtZC5j
bWRfbG9hZF90YS5hcHBfcGh5X2FkZHJfbG8gCT0gbG93ZXJfMzJfYml0cyh0YV9iaW5fbWMpOwog
CWNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9waHlfYWRkcl9oaQk9IHVwcGVyXzMyX2JpdHModGFf
YmluX21jKTsKQEAgLTg4Niw4ICs5MTksNiBAQCBzdGF0aWMgdm9pZCBwc3BfcHJlcF90YV9pbnZv
a2VfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAogCQkJCSAgICAgICB1aW50
MzJfdCB0YV9jbWRfaWQsCiAJCQkJICAgICAgIHVpbnQzMl90IHNlc3Npb25faWQpCiB7Ci0JbWVt
c2V0KGNtZCwgMCwgc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwKSk7Ci0KIAljbWQtPmNt
ZF9pZAkJCQk9IEdGWF9DTURfSURfSU5WT0tFX0NNRDsKIAljbWQtPmNtZC5jbWRfaW52b2tlX2Nt
ZC5zZXNzaW9uX2lkCT0gc2Vzc2lvbl9pZDsKIAljbWQtPmNtZC5jbWRfaW52b2tlX2NtZC50YV9j
bWRfaWQJPSB0YV9jbWRfaWQ7CkBAIC04OTgsMjUgKzkyOSwyOSBAQCBzdGF0aWMgaW50IHBzcF90
YV9pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCiAJCSAgdWludDMyX3Qgc2Vzc2lvbl9p
ZCkKIHsKIAlpbnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNt
ZDsKKwlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gYWNxdWlyZV9wc3BfY21kX2J1Zihw
c3ApOwogCiAJcHNwX3ByZXBfdGFfaW52b2tlX2NtZF9idWYoY21kLCB0YV9jbWRfaWQsIHNlc3Np
b25faWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAogCQkJ
CSBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKIAorCXJlbGVhc2VfcHNwX2NtZF9idWYocHNwKTsK
KwogCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgcHNwX3hnbWlfbG9hZChzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpj
bWQgPSBwc3AtPmNtZDsKKwlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kOwogCiAJLyoKIAkg
KiBUT0RPOiBieXBhc3MgdGhlIGxvYWRpbmcgaW4gc3Jpb3YgZm9yIG5vdwogCSAqLwogCisJY21k
ID0gYWNxdWlyZV9wc3BfY21kX2J1Zihwc3ApOworCiAJcHNwX2NvcHlfZncocHNwLCBwc3AtPnRh
X3hnbWlfc3RhcnRfYWRkciwgcHNwLT50YV94Z21pX3Vjb2RlX3NpemUpOwogCiAJcHNwX3ByZXBf
dGFfbG9hZF9jbWRfYnVmKGNtZCwKQEAgLTkzMywxMyArOTY4LDE1IEBAIHN0YXRpYyBpbnQgcHNw
X3hnbWlfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAkJcHNwLT54Z21pX2NvbnRleHQu
c2Vzc2lvbl9pZCA9IGNtZC0+cmVzcC5zZXNzaW9uX2lkOwogCX0KIAorCXJlbGVhc2VfcHNwX2Nt
ZF9idWYocHNwKTsKKwogCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgcHNwX3hnbWlfdW5s
b2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCWludCByZXQ7Ci0Jc3RydWN0IHBzcF9n
ZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21kOworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpj
bWQ7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7CiAKIAkvKiBYR01J
IFRBIHVubG9hZCBjdXJyZW50bHkgaXMgbm90IHN1cHBvcnRlZCBvbiBBcmN0dXJ1cy9BbGRlYmFy
YW4gQStBICovCkBAIC05NTEsMTEgKzk4OCwxNSBAQCBzdGF0aWMgaW50IHBzcF94Z21pX3VubG9h
ZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAkgKiBUT0RPOiBieXBhc3MgdGhlIHVubG9hZGlu
ZyBpbiBzcmlvdiBmb3Igbm93CiAJICovCiAKKwljbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBz
cCk7CisKIAlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+eGdtaV9jb250ZXh0
LnNlc3Npb25faWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21k
LAogCQkJCSBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKIAorCXJlbGVhc2VfcHNwX2NtZF9idWYo
cHNwKTsKKwogCXJldHVybiByZXQ7CiB9CiAKQEAgLTExNzUsNyArMTIxNiw3IEBAIHN0YXRpYyBp
bnQgcHNwX3Jhc19pbml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiBzdGF0
aWMgaW50IHBzcF9yYXNfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0
OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNtZDsKKwlzdHJ1Y3QgcHNw
X2dmeF9jbWRfcmVzcCAqY21kOwogCXN0cnVjdCB0YV9yYXNfc2hhcmVkX21lbW9yeSAqcmFzX2Nt
ZDsKIAogCS8qCkBAIC0xMTkzLDYgKzEyMzQsOCBAQCBzdGF0aWMgaW50IHBzcF9yYXNfbG9hZChz
dHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAllbHNlCiAJCXJhc19jbWQtPnJhc19pbl9tZXNzYWdl
LmluaXRfZmxhZ3MuZGdwdV9tb2RlID0gMTsKIAorCWNtZCA9IGFjcXVpcmVfcHNwX2NtZF9idWYo
cHNwKTsKKwogCXBzcF9wcmVwX3RhX2xvYWRfY21kX2J1ZihjbWQsCiAJCQkJIHBzcC0+ZndfcHJp
X21jX2FkZHIsCiAJCQkJIHBzcC0+dGFfcmFzX3Vjb2RlX3NpemUsCkBAIC0xMjExLDYgKzEyNTQs
OCBAQCBzdGF0aWMgaW50IHBzcF9yYXNfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAkJ
CWRldl93YXJuKHBzcC0+YWRldi0+ZGV2LCAiUkFTIEluaXQgU3RhdHVzOiAweCVYXG4iLCByYXNf
Y21kLT5yYXNfc3RhdHVzKTsKIAl9CiAKKwlyZWxlYXNlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlp
ZiAocmV0IHx8IHJhc19jbWQtPnJhc19zdGF0dXMpCiAJCWFtZGdwdV9yYXNfZmluaShwc3AtPmFk
ZXYpOwogCkBAIC0xMjIwLDcgKzEyNjUsNyBAQCBzdGF0aWMgaW50IHBzcF9yYXNfbG9hZChzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHN0YXRpYyBpbnQgcHNwX3Jhc191bmxvYWQoc3RydWN0IHBz
cF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKLQlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAq
Y21kID0gcHNwLT5jbWQ7CisJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKIAogCS8qCiAJ
ICogVE9ETzogYnlwYXNzIHRoZSB1bmxvYWRpbmcgaW4gc3Jpb3YgZm9yIG5vdwpAQCAtMTIyOCwx
MSArMTI3MywxNSBAQCBzdGF0aWMgaW50IHBzcF9yYXNfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogCWlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKIAkJcmV0dXJuIDA7CiAK
KwljbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlwc3BfcHJlcF90YV91bmxvYWRf
Y21kX2J1ZihjbWQsIHBzcC0+cmFzLnNlc3Npb25faWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJt
aXRfYnVmKHBzcCwgTlVMTCwgY21kLAogCQkJcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CiAKKwly
ZWxlYXNlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlyZXR1cm4gcmV0OwogfQogCkBAIC0xNDczLDcg
KzE1MjIsNyBAQCBzdGF0aWMgaW50IHBzcF9oZGNwX2luaXRfc2hhcmVkX2J1ZihzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCkKIHN0YXRpYyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKIHsKIAlpbnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBw
c3AtPmNtZDsKKwlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kOwogCiAJLyoKIAkgKiBUT0RP
OiBieXBhc3MgdGhlIGxvYWRpbmcgaW4gc3Jpb3YgZm9yIG5vdwpAQCAtMTQ4NCw2ICsxNTMzLDgg
QEAgc3RhdGljIGludCBwc3BfaGRjcF9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXBz
cF9jb3B5X2Z3KHBzcCwgcHNwLT50YV9oZGNwX3N0YXJ0X2FkZHIsCiAJCSAgICBwc3AtPnRhX2hk
Y3BfdWNvZGVfc2l6ZSk7CiAKKwljbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlw
c3BfcHJlcF90YV9sb2FkX2NtZF9idWYoY21kLAogCQkJCSBwc3AtPmZ3X3ByaV9tY19hZGRyLAog
CQkJCSBwc3AtPnRhX2hkY3BfdWNvZGVfc2l6ZSwKQEAgLTE0OTgsNiArMTU0OSw4IEBAIHN0YXRp
YyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAkJbXV0ZXhfaW5p
dCgmcHNwLT5oZGNwX2NvbnRleHQubXV0ZXgpOwogCX0KIAorCXJlbGVhc2VfcHNwX2NtZF9idWYo
cHNwKTsKKwogCXJldHVybiByZXQ7CiB9CiBzdGF0aWMgaW50IHBzcF9oZGNwX2luaXRpYWxpemUo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCkBAIC0xNTMyLDcgKzE1ODUsNyBAQCBzdGF0aWMgaW50
IHBzcF9oZGNwX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiBzdGF0aWMgaW50
IHBzcF9oZGNwX3VubG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0Owot
CXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNtZDsKKwlzdHJ1Y3QgcHNwX2dm
eF9jbWRfcmVzcCAqY21kOwogCiAJLyoKIAkgKiBUT0RPOiBieXBhc3MgdGhlIHVubG9hZGluZyBp
biBzcmlvdiBmb3Igbm93CkBAIC0xNTQwLDEwICsxNTkzLDE0IEBAIHN0YXRpYyBpbnQgcHNwX2hk
Y3BfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCWlmIChhbWRncHVfc3Jpb3ZfdmYo
cHNwLT5hZGV2KSkKIAkJcmV0dXJuIDA7CiAKKwljbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBz
cCk7CisKIAlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+aGRjcF9jb250ZXh0
LnNlc3Npb25faWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21k
LCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKIAorCXJlbGVhc2VfcHNwX2NtZF9idWYocHNwKTsK
KwogCXJldHVybiByZXQ7CiB9CiAKQEAgLTE2MTIsNyArMTY2OSw3IEBAIHN0YXRpYyBpbnQgcHNw
X2R0bV9pbml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiBzdGF0aWMgaW50
IHBzcF9kdG1fbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwotCXN0
cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNtZDsKKwlzdHJ1Y3QgcHNwX2dmeF9j
bWRfcmVzcCAqY21kOwogCiAJLyoKIAkgKiBUT0RPOiBieXBhc3MgdGhlIGxvYWRpbmcgaW4gc3Jp
b3YgZm9yIG5vdwpAQCAtMTYyMiw2ICsxNjc5LDggQEAgc3RhdGljIGludCBwc3BfZHRtX2xvYWQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAKIAlwc3BfY29weV9mdyhwc3AsIHBzcC0+dGFfZHRt
X3N0YXJ0X2FkZHIsIHBzcC0+dGFfZHRtX3Vjb2RlX3NpemUpOwogCisJY21kID0gYWNxdWlyZV9w
c3BfY21kX2J1Zihwc3ApOworCiAJcHNwX3ByZXBfdGFfbG9hZF9jbWRfYnVmKGNtZCwKIAkJCQkg
cHNwLT5md19wcmlfbWNfYWRkciwKIAkJCQkgcHNwLT50YV9kdG1fdWNvZGVfc2l6ZSwKQEAgLTE2
MzYsNiArMTY5NSw4IEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9sb2FkKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogCQltdXRleF9pbml0KCZwc3AtPmR0bV9jb250ZXh0Lm11dGV4KTsKIAl9CiAKKwly
ZWxlYXNlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlyZXR1cm4gcmV0OwogfQogCkBAIC0xNjcxLDcg
KzE3MzIsNyBAQCBzdGF0aWMgaW50IHBzcF9kdG1faW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKIHN0YXRpYyBpbnQgcHNwX2R0bV91bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApCiB7CiAJaW50IHJldDsKLQlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gcHNwLT5j
bWQ7CisJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKIAogCS8qCiAJICogVE9ETzogYnlw
YXNzIHRoZSB1bmxvYWRpbmcgaW4gc3Jpb3YgZm9yIG5vdwpAQCAtMTY3OSwxMCArMTc0MCwxNCBA
QCBzdGF0aWMgaW50IHBzcF9kdG1fdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCWlm
IChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKIAkJcmV0dXJuIDA7CiAKKwljbWQgPSBhY3F1
aXJlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQs
IHBzcC0+ZHRtX2NvbnRleHQuc2Vzc2lvbl9pZCk7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9i
dWYocHNwLCBOVUxMLCBjbWQsIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwogCisJcmVsZWFzZV9w
c3BfY21kX2J1Zihwc3ApOworCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMTc1MSwxMCArMTgxNiwx
MiBAQCBzdGF0aWMgaW50IHBzcF9yYXBfaW5pdF9zaGFyZWRfYnVmKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogc3RhdGljIGludCBwc3BfcmFwX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
CiB7CiAJaW50IHJldDsKLQlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gcHNwLT5jbWQ7
CisJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKIAogCXBzcF9jb3B5X2Z3KHBzcCwgcHNw
LT50YV9yYXBfc3RhcnRfYWRkciwgcHNwLT50YV9yYXBfdWNvZGVfc2l6ZSk7CiAKKwljbWQgPSBh
Y3F1aXJlX3BzcF9jbWRfYnVmKHBzcCk7CisKIAlwc3BfcHJlcF90YV9sb2FkX2NtZF9idWYoY21k
LAogCQkJCSBwc3AtPmZ3X3ByaV9tY19hZGRyLAogCQkJCSBwc3AtPnRhX3JhcF91Y29kZV9zaXpl
LApAQCAtMTc2OSwxOCArMTgzNiwyMiBAQCBzdGF0aWMgaW50IHBzcF9yYXBfbG9hZChzdHJ1Y3Qg
cHNwX2NvbnRleHQgKnBzcCkKIAkJbXV0ZXhfaW5pdCgmcHNwLT5yYXBfY29udGV4dC5tdXRleCk7
CiAJfQogCisJcmVsZWFzZV9wc3BfY21kX2J1Zihwc3ApOworCiAJcmV0dXJuIHJldDsKIH0KIAog
c3RhdGljIGludCBwc3BfcmFwX3VubG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlp
bnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBwc3AtPmNtZDsKKwlzdHJ1
Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gYWNxdWlyZV9wc3BfY21kX2J1Zihwc3ApOwogCiAJ
cHNwX3ByZXBfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3AtPnJhcF9jb250ZXh0LnNlc3Npb25f
aWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLCBwc3AtPmZl
bmNlX2J1Zl9tY19hZGRyKTsKIAorCXJlbGVhc2VfcHNwX2NtZF9idWYocHNwKTsKKwogCXJldHVy
biByZXQ7CiB9CiAKQEAgLTE5MDUsNyArMTk3Niw3IEBAIHN0YXRpYyBpbnQgcHNwX3NlY3VyZWRp
c3BsYXlfaW5pdF9zaGFyZWRfYnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogc3RhdGljIGlu
dCBwc3Bfc2VjdXJlZGlzcGxheV9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCWlu
dCByZXQ7Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21kOworCXN0cnVj
dCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBhY3F1aXJlX3BzcF9jbWRfYnVmKHBzcCk7CiAKIAlt
ZW1zZXQocHNwLT5md19wcmlfYnVmLCAwLCBQU1BfMV9NRUcpOwogCW1lbWNweShwc3AtPmZ3X3By
aV9idWYsIHBzcC0+dGFfc2VjdXJlZGlzcGxheV9zdGFydF9hZGRyLCBwc3AtPnRhX3NlY3VyZWRp
c3BsYXlfdWNvZGVfc2l6ZSk7CkBAIC0xOTE4LDI2ICsxOTg5LDI4IEBAIHN0YXRpYyBpbnQgcHNw
X3NlY3VyZWRpc3BsYXlfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAogCXJldCA9IHBz
cF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7
CiAKLQlpZiAocmV0KQotCQlnb3RvIGZhaWxlZDsKKwlpZiAoIXJldCkgeworCQlwc3AtPnNlY3Vy
ZWRpc3BsYXlfY29udGV4dC5zZWN1cmVkaXNwbGF5X2luaXRpYWxpemVkID0gdHJ1ZTsKKwkJcHNw
LT5zZWN1cmVkaXNwbGF5X2NvbnRleHQuc2Vzc2lvbl9pZCA9IGNtZC0+cmVzcC5zZXNzaW9uX2lk
OworCQltdXRleF9pbml0KCZwc3AtPnNlY3VyZWRpc3BsYXlfY29udGV4dC5tdXRleCk7CisJfQog
Ci0JcHNwLT5zZWN1cmVkaXNwbGF5X2NvbnRleHQuc2VjdXJlZGlzcGxheV9pbml0aWFsaXplZCA9
IHRydWU7Ci0JcHNwLT5zZWN1cmVkaXNwbGF5X2NvbnRleHQuc2Vzc2lvbl9pZCA9IGNtZC0+cmVz
cC5zZXNzaW9uX2lkOwotCW11dGV4X2luaXQoJnBzcC0+c2VjdXJlZGlzcGxheV9jb250ZXh0Lm11
dGV4KTsKKwlyZWxlYXNlX3BzcF9jbWRfYnVmKHBzcCk7CiAKLWZhaWxlZDoKIAlyZXR1cm4gcmV0
OwogfQogCiBzdGF0aWMgaW50IHBzcF9zZWN1cmVkaXNwbGF5X3VubG9hZChzdHJ1Y3QgcHNwX2Nv
bnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQg
PSBwc3AtPmNtZDsKKwlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kID0gYWNxdWlyZV9wc3Bf
Y21kX2J1Zihwc3ApOwogCiAJcHNwX3ByZXBfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3AtPnNl
Y3VyZWRpc3BsYXlfY29udGV4dC5zZXNzaW9uX2lkKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0
X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CiAKKwlyZWxlYXNl
X3BzcF9jbWRfYnVmKHBzcCk7CisKIAlyZXR1cm4gcmV0OwogfQogCkBAIC0yMzEyLDggKzIzODUs
NiBAQCBzdGF0aWMgaW50IHBzcF9wcmVwX2xvYWRfaXBfZndfY21kX2J1ZihzdHJ1Y3QgYW1kZ3B1
X2Zpcm13YXJlX2luZm8gKnVjb2RlLAogCWludCByZXQ7CiAJdWludDY0X3QgZndfbWVtX21jX2Fk
ZHIgPSB1Y29kZS0+bWNfYWRkcjsKIAotCW1lbXNldChjbWQsIDAsIHNpemVvZihzdHJ1Y3QgcHNw
X2dmeF9jbWRfcmVzcCkpOwotCiAJY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0xPQURfSVBfRlc7
CiAJY21kLT5jbWQuY21kX2xvYWRfaXBfZncuZndfcGh5X2FkZHJfbG8gPSBsb3dlcl8zMl9iaXRz
KGZ3X21lbV9tY19hZGRyKTsKIAljbWQtPmNtZC5jbWRfbG9hZF9pcF9mdy5md19waHlfYWRkcl9o
aSA9IHVwcGVyXzMyX2JpdHMoZndfbWVtX21jX2FkZHIpOwpAQCAtMjMzMCwxMyArMjQwMSwxNSBA
QCBzdGF0aWMgaW50IHBzcF9leGVjdXRlX25vbl9wc3BfZndfbG9hZChzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCwKIAkJCSAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Zpcm13YXJlX2luZm8gKnVjb2Rl
KQogewogCWludCByZXQgPSAwOworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQgPSBhY3F1
aXJlX3BzcF9jbWRfYnVmKHBzcCk7CiAKLQlyZXQgPSBwc3BfcHJlcF9sb2FkX2lwX2Z3X2NtZF9i
dWYodWNvZGUsIHBzcC0+Y21kKTsKLQlpZiAocmV0KQotCQlyZXR1cm4gcmV0OworCXJldCA9IHBz
cF9wcmVwX2xvYWRfaXBfZndfY21kX2J1Zih1Y29kZSwgY21kKTsKKwlpZiAoIXJldCkgeworCQly
ZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCB1Y29kZSwgY21kLAorCQkJCQkgcHNwLT5mZW5j
ZV9idWZfbWNfYWRkcik7CisJfQogCi0JcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgdWNv
ZGUsIHBzcC0+Y21kLAotCQkJCSBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKKwlyZWxlYXNlX3Bz
cF9jbWRfYnVmKHBzcCk7CiAKIAlyZXR1cm4gcmV0OwogfQpAQCAtMjgwNywxNSArMjg4MCwxNSBA
QCBpbnQgcHNwX2dwdV9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIGludCBwc3Bf
cmxjX2F1dG9sb2FkX3N0YXJ0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCWludCByZXQ7
Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCA9IHBzcC0+Y21kOwotCi0JbWVtc2V0KGNt
ZCwgMCwgc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwKSk7CisJc3RydWN0IHBzcF9nZnhf
Y21kX3Jlc3AgKmNtZCA9IGFjcXVpcmVfcHNwX2NtZF9idWYocHNwKTsKIAogCWNtZC0+Y21kX2lk
ID0gR0ZYX0NNRF9JRF9BVVRPTE9BRF9STEM7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYo
cHNwLCBOVUxMLCBjbWQsCiAJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwogCisJcmVsZWFz
ZV9wc3BfY21kX2J1Zihwc3ApOworCiAJcmV0dXJuIHJldDsKIH0KIAotLSAKMi4xNy4xCgo=

--_004_BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19BN9PR12MB5226namp_--
