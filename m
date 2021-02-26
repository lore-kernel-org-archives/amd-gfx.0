Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697ECC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 05:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D837B64EDB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 05:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D837B64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420AD6E8EC;
	Fri, 26 Feb 2021 05:58:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA266E8EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 05:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAZjmqG5LQdWiE7eCwHFHAlpmJNUlf1uA3gxXdVLwP7Ugme8NywvHoHcX3Io4XsJPs08qiSxOuWht/hOWWQ88CZQ7qV7n98bquAEyJ7Awu6aAZjhuXFGWuWmNHXscuNo3LPkteqOOJdZw4Shz6ucLzza1uqLN6ugOjmu5hYXjef1GOoNxeqctbUiVQLTvXtURuvSOl5GDWMXjc8qpdSTJzt4jUeeZBQGG5iVAnyNICLkBh7YGfhShAaCp7MqplOZnmt4LvOEUu0QDmYyZ7XcgYO5+KBLERBE0ahTeYUTCCFb/ek3B4bDdTx1JECiqd/l8ivRR2Xat+8oO0NKwNlXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS60mooscy05o+U9fggQMp+6I5FeSEOHqeqkRgt1X/4=;
 b=DrkptWrNGDYSlOkcRlzLjR4Hszpo7VOiO3EsNDOH1740jurtp0aylpVrSkQNsy1SZS6y3yQhu7+GVklNTJ4dT73Bc0lq37R/7Cx7hcvy85DF3zVQP/BYTuZpuoztLzDseDFNIlwufX23vveA2Jm2JGc/DhDJF+MEVDEd7+0aMkRFwtDbISRiBNDtcfm3SvJfsrMupaGFVbcRzxfG/khWFHGp3K+gbQmVB97l1f69PaHiDSQbzq42Xd7gAEtqvdIf0gXs3oXUKDkGUUcGSzX1nPo4POP4DZeNDJ9klpP/0orVhxXiWUOB7Nk1kAPoVYyalKVw3BAlnw8odsv19yRm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS60mooscy05o+U9fggQMp+6I5FeSEOHqeqkRgt1X/4=;
 b=tHxsnm6kEme8ISYTVXnJ9Z/ox0fWqFLXecisdYXnKIlagQiCC6RnmiNXEOAX4jWiRjqO//XXrn3fJ3w0H6QbLPqcQ3Nc1lAQn1YiYdMuVg687Fe3Ommp19SciIoFklbhgZntR7ObuhxwQJjvi3/i54jD44iHiklXmiUTDCbAMQo=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 05:58:19 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3868.033; Fri, 26 Feb
 2021 05:58:19 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [RFC] a new approach to detect which ring is the real black sheep
 upon TDR reported 
Thread-Topic: [RFC] a new approach to detect which ring is the real black
 sheep upon TDR reported 
Thread-Index: AdcMAadhaEND07KHR4C1q7rMxPXb/A==
Date: Fri, 26 Feb 2021 05:58:18 +0000
Message-ID: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T05:58:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=06f4d1e9-2b06-453d-9061-98aa757256d8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00ecbc1d-b08a-4fd5-7ce8-08d8da1b8436
x-ms-traffictypediagnostic: DM6PR12MB4218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB421836955A121D7CC1F4BA64849D9@DM6PR12MB4218.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x2Sfxqx6oo2fCvGlI8f6HgJIeRcckqdymKdf0RIz8nV7MI6dKlN1PEw7yDG0Z1qBLHq6TdUb42H6To61hu1QhYty52KKhGlKC08uSodE21MOJiMzASFCiEuNdsG1F1/XTCfJHRZ21lEsMxRZH5dgl3+Wrkb0xSR9ufzmFoZf65BZjMcnYlJtIUhfVmBWEKA237umbOyFMUH5sNx+WQIml72qdzLFNFbjEccrjjeYNp5zoG2yl310hiD2+BO1gQWUrj8J9m8iyZYrUJXJPpb1UVx6oWpNFhI1jmi2pkpsp2+mqV5besQaI/+tz+IEMDroYQnzp85g5a7Ml931zxOxYT16DkYtNiuseP6Nh7CYopb7vDB+ZeVaM6HaTlYEws0RtceNvP58kK63cRsYM8qj1Uyzs4gsy8UhdD7isXn00wpf4T8Jodc70rhvHw0CsF/XdNRYT8qK2FVEAqLT5QtHCuHnOfMx/bqJiZNfgPQ+ibKWbBVAws/xvpvpGqCoc+yDLDqqWiT9DzUFfxOGQpG1iQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(316002)(71200400001)(7696005)(9686003)(83380400001)(4326008)(6506007)(54906003)(55016002)(5660300002)(26005)(6916009)(4743002)(8936002)(8676002)(186003)(2906002)(478600001)(33656002)(86362001)(52536014)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fVk+c4Raxgm0M3Q1qgD8JLqZsNVJkQhrgO9uzFNHFDw7Jt88N4lXhGrY5M30?=
 =?us-ascii?Q?nLN23nkkgSOuKbjmWkGpl4tg+l3ryDlVEgHDxNhcEfFDF0fD7PQ17gFizlP5?=
 =?us-ascii?Q?O4WWvLGLKm7kztr2tYBZBcX/aKaXP3FPspVQlxrajGUOXKpyDiYUW0BPuRKS?=
 =?us-ascii?Q?UQwMavoaIs2/bYy4MXtcwaLyelcNvs+DS0scf2vF3D9PGOtYx0C1vBroLBaZ?=
 =?us-ascii?Q?qgbdnAZPsWZeFoIJUbPx/byRurjeNOkE5UdgtIA6OEEtbH59VRZDbAGIuGi4?=
 =?us-ascii?Q?+JMa9HhrPTFVeKGuFLIR84nRmuSb6ZAFHXMbM647UE1aHt3X0IaGnbfUG1Tn?=
 =?us-ascii?Q?6z0qPj+/pyBqYUbzTPkxDCeP3xedZXYwDQnxN6yMPL73Krz4RmYaij6YXOZ/?=
 =?us-ascii?Q?JwpygtONF7zH5jK4lsQQufWuw/H/E8sYkDhOzsMaxYRxa4uzUpBxXtkX7ax+?=
 =?us-ascii?Q?1GaOSzDAuf6OlX0wbP4mi1EH+awM0cO7kerCZi6naPuZ6ZqQ0M4l37+wDrYV?=
 =?us-ascii?Q?owD0wJhdTYOBk/ML3GkfPlsC0bvuVZeM6wJYaNlhLXSWWrq26x0XBPzXdd9m?=
 =?us-ascii?Q?2mqSHGeq2YZx2nTvi5Ha6Sw/6rFoUY6968gCfklSK6+/qBLXWzQqUTEMdCBU?=
 =?us-ascii?Q?qcShsLXYqXQsxmUS3zJ6sNJvC8bYdsEi7b/AoAke3L/saHt0mRcb/93//4pe?=
 =?us-ascii?Q?wPP17gSlG5BrcFCjtn2PODyRxspWc+rS6qAtu+kgKEZKuDfaqrJxy6SiEETw?=
 =?us-ascii?Q?v2G4b30oEHVKmIdAJQXi9K58ARxfcHDhQgL6arVmANGniqC1YwyhdZ22Mwzr?=
 =?us-ascii?Q?SUijsV9UB+A+O8mcdcIqhhI9ceWIquM3FkHFJjhDgMxWJ3/+mDmhUW0Tbz4z?=
 =?us-ascii?Q?JKiPtR56YmN4n0Mz3jPETxSYKicPM2B6D+sOHhwsTe8wMmDegC/3LfTDYj2G?=
 =?us-ascii?Q?CfN6nAsGiZeD497D6BiYlvfzd9URBmm1qQANmkjeJadZIqh8FmssBt25eRqc?=
 =?us-ascii?Q?a76a37pTbFkJOm4LFcfPUHZ+eO2h2zkcs8yOd7FivpsQQBbBQrdHCAhiqVAL?=
 =?us-ascii?Q?j70bA8m+3ixBpIK/rzYVDqZKGmOj4FPfAShgjceWynhe+S0yAvDzT95r4L/d?=
 =?us-ascii?Q?H3zGRIRphnAhByY3xtpWf/ElT6nT6c9k7+3z+crGgcDim+IuTyOV48WOWshZ?=
 =?us-ascii?Q?ajNyMHvxX/IWt9KryQ8dT7y9W6XoxP/mvPe8JdVfv7TEIfiLtY4dYVexX4p3?=
 =?us-ascii?Q?kvhcp5AdalH1+ZCBcXPUWEVtxbRUoS+4YYQE+YhzQxazYrmVPfAXVWNEfrSx?=
 =?us-ascii?Q?ynwmQHUuBbH23MzwHzpDvYUu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ecbc1d-b08a-4fd5-7ce8-08d8da1b8436
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 05:58:18.8351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S84vs9rNdz6OmEnW+x7GZ2jsHpQ2K4IYnMI9WVxdOvXhikSxR/6+8ezF4qPKqjwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1219276335=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1219276335==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1708D28565B445EABA872A3B849D9DM5PR12MB1708namp_"

--_000_DM5PR12MB1708D28565B445EABA872A3B849D9DM5PR12MB1708namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi all

NAVI2X  project hit a really hard to solve issue now, and it is turned out =
to be a general headache of our TDR mechanism , check below scenario:


  1.  There is a job1 running on compute1 ring at timestamp
  2.  There is a job2 running on gfx ring at timestamp
  3.  Job1 is the guilty one, and job1/job2 were scheduled to their rings a=
t almost the same timestamp
  4.  After 2 seconds we receive two TDR reporting from both GFX ring and c=
ompute ring
  5.  Current scheme is that in drm scheduler all the head jobs of those tw=
o rings are considered "bad job" and taken away from the mirror list
  6.  The result is both the real guilty job (job1) and the innocent job (j=
ob2) were all deleted from mirror list, and their corresponding contexts we=
re also treated as guilty (so the innocent process remains running is not s=
ecured)


But by our wish the ideal case is TDR mechanism can detect which ring is th=
e guilty ring and the innocent ring can resubmits all its pending jobs:

  1.  Job1 to be deleted from compute1 ring's mirror list
  2.  Job2 is kept and resubmitted later and its belonging process/context =
are even not aware of this TDR at all


Here I have a proposal tend to achieve above goal and it rough procedure is=
 :

  1.  Once any ring reports a TDR, the head job is *not* treated as "bad jo=
b", and it is *not* deleted from the mirror list in drm sched functions
  2.  In vendor's function (our amdgpu driver here):
     *   reset GPU
     *   repeat below actions on each RINGS * one by one *:

1. take the head job and submit it on this ring

2. see if it completes, if not then this job is the real "bad job"

3.  take it away from mirror list if this head job is "bad job"

     *   After above iteration on all RINGS, we already clears all the bad =
job(s)
  1.  Resubmit all jobs from each mirror list to their corresponding rings =
(this is the existed logic)

The idea of this is to use "serial" way to re-run and re-check each head jo=
b of each RING, in order to take out the real black sheep and its guilty co=
ntext.

P.S.: we can use this approaches only on GFX/KCQ ring reports TDR , since t=
hose rings are intermutually affected to each other. For SDMA ring timeout =
it definitely proves the head job on SDMA ring is really guilty.

Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------


--_000_DM5PR12MB1708D28565B445EABA872A3B849D9DM5PR12MB1708namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">NAVI2X &nbsp;project hit a really hard to solve issu=
e now, and it is turned out to be a general headache of our TDR mechanism ,=
 check below scenario:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">There is a job1 running on compute1 ring at timestamp
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">There is a job2 running on gfx ring at timestamp<o:p>=
</o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list=
:l0 level1 lfo1">Job1 is the guilty one, and job1/job2 were scheduled to th=
eir rings at almost the same timestamp
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">After 2 seconds we receive two TDR reporting from bot=
h GFX ring and compute ring<o:p></o:p></li><li class=3D"MsoListParagraph" s=
tyle=3D"margin-left:0in;mso-list:l0 level1 lfo1"><b>Current scheme is that =
in drm scheduler all the head jobs of those two rings are considered &#8220=
;bad job&#8221; and taken away from the mirror list
<o:p></o:p></b></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in=
;mso-list:l0 level1 lfo1">The result is both the real guilty job (job1) and=
 the innocent job (job2) were all deleted from mirror list, and their corre=
sponding contexts were also treated as guilty<b> (so the
 innocent process remains running is not secured)<o:p></o:p></b></li></ol>
<p class=3D"MsoListParagraph"><b><o:p>&nbsp;</o:p></b></p>
<p class=3D"MsoNormal">But by our wish the ideal case is TDR mechanism can =
detect which ring is the guilty ring and the innocent ring can resubmits al=
l its pending jobs:<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 level1 =
lfo2">Job1 to be deleted from compute1 ring&#8217;s mirror list<o:p></o:p><=
/li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 lev=
el1 lfo2">Job2 is kept and resubmitted later and its belonging process/cont=
ext are even not aware of this TDR at all
<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Here I have a proposal tend to achieve above goal an=
d it rough procedure is :<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">Once any ring reports a TDR, the head job is *<b>not</b>* treated as =
&#8220;bad job&#8221;, and it is *<b>not</b>* deleted from the mirror list =
in drm sched functions<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l1 level1 lfo3">In vendor&#8217;s function (ou=
r amdgpu driver here):<o:p></o:p></li><ul style=3D"margin-top:0in" type=3D"=
disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level2 =
lfo3">reset GPU<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"marg=
in-left:0in;mso-list:l1 level2 lfo3">repeat below actions on each RINGS * o=
ne by one *:<o:p></o:p></li></ul>
</ol>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-9.0pt=
;mso-list:l1 level3 lfo3">
<![if !supportLists]><span style=3D"mso-list:Ignore">1.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">
</span></span><![endif]>take the head job and submit it on this ring<o:p></=
o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-9.0pt=
;mso-list:l1 level3 lfo3">
<![if !supportLists]><span style=3D"mso-list:Ignore">2.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">
</span></span><![endif]>see if it completes, if not then this job is the re=
al &#8220;bad job&#8221;<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-9.0pt=
;mso-list:l1 level3 lfo3">
<![if !supportLists]><span style=3D"mso-list:Ignore">3.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">
</span></span><![endif]>&nbsp;take it away from mirror list if this head jo=
b is &#8220;bad job&#8221;<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level2 =
lfo3">After above iteration on all RINGS, we already clears all the bad job=
(s)<o:p></o:p></li></ul>
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">Resubmit all jobs from each mirror list to their corresponding rings =
(this is the existed logic)<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The idea of this is to use &#8220;serial&#8221; way =
to re-run and re-check each head job of each RING, in order to take out the=
 real black sheep and its guilty context.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">P.S.: we can use this approaches only on GFX/KCQ rin=
g reports TDR , since those rings are intermutually affected to each other.=
 For SDMA ring timeout it definitely proves the head job on SDMA ring is re=
ally guilty.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
<p class=3D"MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB1708D28565B445EABA872A3B849D9DM5PR12MB1708namp_--

--===============1219276335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1219276335==--
