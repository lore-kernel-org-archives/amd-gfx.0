Return-Path: <SRS0=JDsk=IF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B33C433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Mar 2021 07:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FA364D90
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Mar 2021 07:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FA364D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F78D6E56A;
	Sun,  7 Mar 2021 07:43:54 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B3F6E56A
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Mar 2021 07:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebYN8ZXYo2NyRlG1+u6GdGk8o51BUmMJ6FnbSgIXwtsCM1CgOlVboDF16ifShx4byQi/iE0QVjJ4iIuz+QCC7i54V1PZnQ/UnWgVztH0Rb0zY366GTdzISqvwtRNxeXMI7emU52FKailZ1DwGN+NBPUeBz6lLh9vZsyqt6uDDTg3o9v2JDbDxET0fuMuIAuwaWcZYvzqwUYGJpRL/o5rMjYkTIqKlYpwD1RFa19pTqTq3z2ww/pKokpllYTHrB9NbuKujyqPWn+RgsFQpOSVV6UasmGXkMZEg93wVvxtqf4ZRCEYB4X4+i52mD1ddEa2SJff3awqwsv7Bb+c1pqvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D77WFjr1yohP7ZTIsqYtEFUgqVcyZYer+sjgGXzp10=;
 b=P+MYzXbCXEgmRFdlFgoVMKKYIQdqcJI4dzcc49daQ5krVII5P9c9icv+tt7mtOGtZSIjrnGR++zbPxiKYiLJ4VN2Q9T3eP82zLVq4ECfPLP6u4sjBHUYRxQ+OhGRmZWTxPeZou++h+CS1OnkzoYLr34O7hsT+QxU6qteO32IyNu7PQFaF2QqhaX5Sl8MCTR2F+LvBiLFfadaxKznCITtJdZUIN9tt3u7YFCh1vILj11PQjcrXywirwZN9sAW6JmBGcKAP5i5MqXQzY8l1Aesid/Plb/MpcYcMVehcN75XqgaGy0yu/s7cr/VVXT6vVOEo0BDJSZtBzBI5wW/Fh4QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D77WFjr1yohP7ZTIsqYtEFUgqVcyZYer+sjgGXzp10=;
 b=L9BnDXtSYPu2xWZECnzb1axNbME4Wc+o/ViHUBE/tHKfz9EYOsjhdcFndF5+KOgNTkc1tUzZoNxlMRBCyLkyH0UuSscRR2y+RHR/BIspZROJank7eEVBdCRxfK676kIXAyMGV49hiNC2As2bWPNoGxvtCIOgLIr+0Mp2EEqt9Bk=
Received: from BYAPR12MB3528.namprd12.prod.outlook.com (2603:10b6:a03:138::28)
 by BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Sun, 7 Mar
 2021 07:43:46 +0000
Received: from BYAPR12MB3528.namprd12.prod.outlook.com
 ([fe80::67:fa48:3a38:1e93]) by BYAPR12MB3528.namprd12.prod.outlook.com
 ([fe80::67:fa48:3a38:1e93%3]) with mapi id 15.20.3912.026; Sun, 7 Mar 2021
 07:43:46 +0000
From: "Jacob, Anson" <Anson.Jacob@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH] Revert freesync video patches temporarily
Thread-Topic: [PATCH] Revert freesync video patches temporarily
Thread-Index: AQHXEvlPIAQK+pQ3akKRK41qsNVLV6p4JJfr
Date: Sun, 7 Mar 2021 07:43:46 +0000
Message-ID: <BYAPR12MB35284DE92227E6E0F4D07BF8EB949@BYAPR12MB3528.namprd12.prod.outlook.com>
References: <20210307022635.200468-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210307022635.200468-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-07T07:43:32.8247113Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.19.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 186beba2-a46e-4941-0e31-08d8e13cbd5c
x-ms-traffictypediagnostic: BY5PR12MB3860:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3860CC833EC9233924A10AC4EB949@BY5PR12MB3860.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaodqZiD6/zs/V75ztQ0bIUTbPTvegOPmk51TF5fAfgDDlhDa9/I+HSscxXj6SkwWU8n33520qqVJ4i42MkMvKb+46GCqWbFinY96F6TdaWepiC1LizPlB8/RDIfopz0br6pi52YftptzZty6fjS6lyZC1jj+9HLrhtvSlAQASEiUujdGlfs+0UuMONWHPaDMH03Jzlrbb8FS9dlWLZ8ifWCCLHRFNKGBr/rjp9iqEBhPB97s4QljB1wAOhzwoHzXD15sqMAClRP/HVJIUTpPT0rz5nJRi0O2cwfir1xVPHTye1KxpGvTWUfxf8ZGcfVyk8Er0DIHmnXx+bBKjupAhqjiDqvr8q10z+qb++rshi25Jhg4Nl9AaSmM6UQqnxxi9gMaFep7BR6MOb6QIJ3piVm+831mvTgwcHOI3aCfiMCmiB3e/J7tcBOYHWbga9jC9OaEOteHS9Vj3uJh1hwTu3sAvMEgPTkMDkgCtmCOdRROX/nXrd5u6bFNquVwukPJYMsfYeQIdAhxNi7nsJ85g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3528.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(558084003)(71200400001)(2906002)(6636002)(66476007)(64756008)(86362001)(8936002)(4326008)(55016002)(9686003)(8676002)(6506007)(5660300002)(33656002)(478600001)(52536014)(316002)(66446008)(110136005)(7696005)(66946007)(76116006)(66556008)(186003)(91956017)(54906003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U8jMsxq4mWzvYZMDL9Nkm7g/Ir6JML0kSeId9mbMqLWvhTPaMgSwQVH3I/+i?=
 =?us-ascii?Q?yNC8NiRaNQ+cHmhCorCUQDyCMoVNZtI9/A9DkoFmEmthkN4eUzABnZYbdm4L?=
 =?us-ascii?Q?KhRka8aJb3dSOeOHSayetZGEP7M5/JwuqqdY6r/q6a1ydlp7NUixnT6wu8x+?=
 =?us-ascii?Q?awpC/l6Us7XMujfzic7F9OpWB6RGLMxEFNlGZBRprirm7K+neSJXehysk2+q?=
 =?us-ascii?Q?peNBtqLnghMgEAYwBxqa4AkEWBWCGejMTBbKP7ztwfssbNwdAvqMj3ukO5T5?=
 =?us-ascii?Q?4Q/workVAfei3Y6DVgqo0pzQBjkNOs4f8aGqxSrGBNWY8LjhkXoaKrDVg2D1?=
 =?us-ascii?Q?bYnuP5jxy6fxUCMCpUOB8DN3gcdJcewapAydriReI75TUrXGzD4+LeXvEI6Z?=
 =?us-ascii?Q?Of1NmUnttKESpaCaVyGSYPXm+QL5P/Imr9U5kSJEBW0VqCwnzACSWblRHPxN?=
 =?us-ascii?Q?7vDJoDDh4I8wd3QziapY233QpzNKUd/IjsJmZi9lFp3L/+GUGvfNv8ydB5g5?=
 =?us-ascii?Q?dMRkYKo2nqIG+PmND4XToZhW2ad34DooHYrsVlF6waOX7ujIE7YR2xWT2j+6?=
 =?us-ascii?Q?yeIb2eg952sKLUUTVbgESm+pTt9Jl5owp+dmk/+C6oByAMgtxei8JxYXakqj?=
 =?us-ascii?Q?4YBp/ZAExdjerkfNjMcKHpZjo9LWhsqtAt0WlRLJH3ro24hCx1eHNgDCpfhI?=
 =?us-ascii?Q?Bfo9o8/YXWa8UZDtwJl37+ZibXWkIurx/w3s0X5EngguAfo8T6Fj39uPq1jw?=
 =?us-ascii?Q?nmNlJ7GroZQeWRoUmExnpxjwA7SmCVXLctLHEgitY9IgvGjiBmLPtC/zYZFN?=
 =?us-ascii?Q?dEQhbS9gTrUSpfCJNem8bkwLv2256swtcuAeDT2npfUOnz/Zd1gawcgEL3Hf?=
 =?us-ascii?Q?zVM3iEgfN5YuHHfrZB6MWr7+UcIK93G0pX2wVpZ7MO4ILvHLECSMTeALxYg/?=
 =?us-ascii?Q?E3tQSRMat7IV0zaiQsWWlH7kTWBxRxpGOfLrXQycKGrfRt73g9bScp5lsvnJ?=
 =?us-ascii?Q?bP19oW4M9kkGo7yXL76GhG+bWY3MVsA1kJicNZr8a6BuErwdUZDvoghX2JnF?=
 =?us-ascii?Q?Z8GM1PK2SAvyIC/wV6DETMlU4XygSNawSAtMP2luZalvV7vJTb0c31NwxYIa?=
 =?us-ascii?Q?bYu4xVDbfutVcnNO10fSNp5H/xDt4pzICEvoV8j5NAIiV7hlrfH8gtITjF71?=
 =?us-ascii?Q?WHoWhREf+V+2LJoFr7di50PC/sP0jKQi18FvoJ0vxnqS9OZoIMVoXBD03/Nr?=
 =?us-ascii?Q?ZvTOtTt++wgbNxDSSce29QvD707AliPxPobS7ZcYvVByAOIK1Lo7eI04Z01I?=
 =?us-ascii?Q?Eyn0CrWJGYMH5R1NZDPDSyU7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186beba2-a46e-4941-0e31-08d8e13cbd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2021 07:43:46.3289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pm1+LL9/qNXwkmTRgrD/hkeAvPv9DdZeSGj+4wlzsSpTxRnrhPdjmwYeHbSChFb/LHqwTSNJGvnqfG8MD0qvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3860
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
Cc: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>
Content-Type: multipart/mixed; boundary="===============0085021068=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0085021068==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB35284DE92227E6E0F4D07BF8EB949BYAPR12MB3528namp_"

--_000_BYAPR12MB35284DE92227E6E0F4D07BF8EB949BYAPR12MB3528namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Anson Jacob <Anson.Jacob@amd.com>


-- Anson


--_000_BYAPR12MB35284DE92227E6E0F4D07BF8EB949BYAPR12MB3528namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
Reviewed-by: Anson Jacob &lt;Anson.Jacob@amd.com&gt; <br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
-- Anson</div>
<br>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB35284DE92227E6E0F4D07BF8EB949BYAPR12MB3528namp_--

--===============0085021068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0085021068==--
