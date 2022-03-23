Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1A3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 12:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE3910E6AD;
	Wed, 23 Mar 2022 12:01:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442C610E6AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 12:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAtb9JT0oIDkVUhvyBgKMLsbWCFkjrbn+8YwNHX4z8N45Mf/lxBpUYIOJt6gxLnygixkJfrZjE/nnYG3HDW+U9+fLAaBJMeLy1XA6aJxBh1G2Zyd1h1DcnwQnM46cnU6KhKk9k0uPYQ4l3x60e+Nlu8DMJCsHKCO+x/7rElIq+c9eXUh+xd3MfwqdeV7FLK7RvO3GMtwSnrZ5D/QwxG8NrQmAe3bB0zD2SApPe8i6RxYD+HE/5eySdjn5BEZ80rQ8HVPAW0nRgULYXFRgK0O7R0cIzmqh7vARtDrHcb1ANlQNpRfcSjcEUZ9iji21i5KtbPkvOIMfAyaxkTFWWH5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOBPFTkmZZP0Fp8KDOMY8LEIUeI/kHftJfphMi36fOE=;
 b=lwCb7cbpuaC05J60m2mBK4quLvzszCoD9H03HecWefnvhjjoijIFTaa710ir+vKshCpN1JitfQaE4b+KHYqHzP7+F/NyqrQ225z86QmNqgmLNvrY5rbLD9qlIOGlCP/zf/M7DjwNDU9lfv4rw9dNfob8a3R5Y+fYaOL7RhCbPUFvPXaMfs0rVS8Z0gonxeTLsNEpCZ8P3kny05GtqJw4g2nEKHbuAfsTsq8/9Dr8UeNyuHu4C+dxnr7/LSd9CKcU1sAfcZfu7JOmQzkD3mkREZa1m0RY84kPWBzYmxVL0jPGbu+sHyfqpnhZL76ohFpT0Ofu4jLKV98cyRvdbuuBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOBPFTkmZZP0Fp8KDOMY8LEIUeI/kHftJfphMi36fOE=;
 b=4pI1ZAPoGKoMkzPrAuqoZRmzaXL7K/bzQU4kXsJP3Sm28Yrnd3AImv6ICI72SW+C3nUlBG2nCkSFyEuKz7IhXBcPr9XfHRWRA9It5iPLiEkOyO/JTfUqK5MGq7pjIveBITxsJP+JwOichFsqCtDh59NlKONSR7Ql72hkbABq36U=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by CY4PR12MB1701.namprd12.prod.outlook.com (2603:10b6:903:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 12:01:28 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::fcad:40eb:12c8:977e]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::fcad:40eb:12c8:977e%7]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 12:01:27 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/6] Complete and add dynamic completion to umr
Thread-Topic: [PATCH 0/6] Complete and add dynamic completion to umr
Thread-Index: AQHYPqwG45ELteffLku1HWh8qH2afqzM3f4F
Date: Wed, 23 Mar 2022 12:01:27 +0000
Message-ID: <DM6PR12MB354735CF18298BE941AA4DC7F7189@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220323114842.78516-1-luben.tuikov@amd.com>
In-Reply-To: <20220323114842.78516-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-23T12:01:27.354Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 20177e90-2ab2-37f1-47a2-b2f3988a66bf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70689e73-1054-4589-a72a-08da0cc4dc85
x-ms-traffictypediagnostic: CY4PR12MB1701:EE_
x-microsoft-antispam-prvs: <CY4PR12MB17017048AD18C70ECB9C0AD4F7189@CY4PR12MB1701.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hLJde8RF3Ov5ZswsehQT2DyCmjXiTX0H6uA/fEp8GzixLIJH7bfZ0370KIt1X9kSdp6BFZ3EGrbk5TbJwMhmtV4brjTtgA6Z3Xe0I/UywUtZdiNtMF8fCBc5ATHhD7FS0atm7fe/X0geSNjm23QFsB2QN+qTJFGGgrjhOTEQ9bC8WJVqukHll3asPQ8ZOeDzgPRA58J+qzNgQlYWURLK7F8zaTdk9mHqQZQ8NB/xJFV//5KlbZI5nDqUhlIHQ7kEwyRwEpLf447twle7x5YwaDcbJPG8/gKL9lmrcF/FEZTvOaRJbXrfwD7/fVhL47iOprhQ3xNWaFTsdMuFGo31qwNGg0gz0+KpLfOnHJK/iQrS4QUNvuhp4RJxiS0i/69jo1V1OP7Qg4zPjyBB4GKA55Wf1aS1Jx0LikWgIaDcSxaGDtQZLRxETPOmXaKARGJQ2ed3pqBaNPVT0cepZ1VTzh9nUrpewG1bmeehTlvXjwrbRwilNRsvnIukcGFkTX/k0cPypy5oW7SDk6n4S1vIZw14TEqM0kztqjo7g3tblH8BWAfDxmltEc3MoD7MPACdyrIi5JwEjLb8SWxsrN1cqjC3bxmJqi6ZjtmBPlyny7JWqfUbYsd0hYnnMK49jrxfq25W/6Ewk6YwZy37tmoL52UIxGxz3sEn0oNbJULKv9KPsOlq6C7ZP3zVQRynddk7nVW/rCMqGpO0x4fkPFXxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(53546011)(316002)(64756008)(122000001)(110136005)(5660300002)(54906003)(38100700002)(8676002)(4326008)(55016003)(38070700005)(2906002)(52536014)(33656002)(7696005)(8936002)(9686003)(76116006)(66946007)(91956017)(86362001)(66574015)(66446008)(66556008)(66476007)(186003)(71200400001)(83380400001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OI5mJ61vYhKrK58i98FaASW5/uTKrkmXc8TuJVSZ9NVcccG1eTHbv63e1s?=
 =?iso-8859-1?Q?oD56sKU7LNG2KghDLkWg2QIlHKNHnsNb1moiGxWrSFIFcFNyHb9Zb0kN2J?=
 =?iso-8859-1?Q?cbXFZGzp8esUAiwfEzsIiBcJYnd5uaekp96gvXpaXRFYgMkg1K3MUp2yLw?=
 =?iso-8859-1?Q?jhgk9Pj4wPtMrLjut6o1ntVbcfVxEnL/0isjjrGMPko2geiAw4os9h/bUa?=
 =?iso-8859-1?Q?IjDSqzu2i5bVHmmfXyzuI9elxn3dD3OI5I+yHUuHdqKAdrBpJZ5wVS4wZG?=
 =?iso-8859-1?Q?TsD98EPAshym5Swgb7It/DstNwefvP6a1m0LWdEBUQ2uzelGmrRvMBV/Ad?=
 =?iso-8859-1?Q?yrV7F37Kk5Tpw/vl3lypaoJEE3b2Je+47IleM1du0M5wGijR666/TB5T7W?=
 =?iso-8859-1?Q?jJXwdfROt4vBnrZ+ISPXaHCoOuwgGWwHbDAcM744BfZWCp0dN5Fr9obc/K?=
 =?iso-8859-1?Q?ddfJgx7Ufm226WewkRBVxu5ltfPQ8utuK37ieWaeGAI+kYUPNI8Alggh2f?=
 =?iso-8859-1?Q?WKU5rr2mxpSfLM0qGAiZSpvh4Q2ar+VT77QZ1z2nBRhkxUV/wWo5ECN3T0?=
 =?iso-8859-1?Q?G1U5Lv1s1Y54awi/x0BCw7r/XlMaMTkr4Uxa/VPvSYbxY3xgk9fK8QiyGC?=
 =?iso-8859-1?Q?m+hVpfO7lbN0Nf5B3y9ZOE2Z8XwdY8WCAbBMwd0vGRpU1mUqAwpKzZfzLL?=
 =?iso-8859-1?Q?4uxZJ2STRmuOuYrsysZDAFBtwqG+fRTZwB0+zwQRh2UFGfW3Tf5ES+DpG7?=
 =?iso-8859-1?Q?HdGzRM1GZMA/igzqAqjnJwGc5m8CzCDHfe1rYFcmo1V9SWLvipNB/LMcLf?=
 =?iso-8859-1?Q?eijiAtPaR/fcHoT9p81mY6Wytp4GQ/uWdXJwjvT/s/R2mcg9BPsSmoIZqh?=
 =?iso-8859-1?Q?MP1au+Uqz3fQcNtlVlQ8D5EPKSc1NfSGddnGQCXRZw4/XBem54FWyfsMr2?=
 =?iso-8859-1?Q?bX7z5bthKgIiJydCtt76umndgPf/xe6ORubppW60D5N2et7OvCgiOFtYdn?=
 =?iso-8859-1?Q?BM+YjXgMQ45zrKXIvZMBwUD+nP2VYsFHecyMxA0ROvCxgUPKa212kEj2WH?=
 =?iso-8859-1?Q?4OUiz7a2XzcskxhTNx0ZRHRDLsgwRmBEfZSv70sGaQZHmPYZQdwu0KlHCF?=
 =?iso-8859-1?Q?ArPIyXZk90991QMRwjT/BNiyxIIMO4LUjDnY8bKyNCzC+pZlG8zOiorhci?=
 =?iso-8859-1?Q?QZPq9IFdOhMpAdSL4HAju68nJI7O1q+v4D09zjI73p3V74n0hViSnqubd1?=
 =?iso-8859-1?Q?rdJTl4npulRRJzfSt0WxNtVAZ5j3Cygeo+XkiCeDGOZPYyMbecqdFyV2p5?=
 =?iso-8859-1?Q?3AC/itxwlvGtnZCRqImrmsTjPKUfACpLmS3OGpg++Dme5RMg9MR5/EpQ1U?=
 =?iso-8859-1?Q?r+oD/4thx5OPikkfYM8Frys8zBHh1MA+pT8cFlwiksfcJ0gzWUU2KJ0Hyi?=
 =?iso-8859-1?Q?8SnVKMevio3MKZ6o5OKi2PvseJUnP9TRgJdMjZh5hpagGBR5x5T/9X/aC4?=
 =?iso-8859-1?Q?8AqltRq1UTxY7yG1tPRqqgAK2w7RtXNRRUAUHWeE5DQUbUsOvTUvJ0pLFh?=
 =?iso-8859-1?Q?R4a06kQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70689e73-1054-4589-a72a-08da0cc4dc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 12:01:27.7341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rmH6IucjfrU8ULHYrfbV4j+x2lu1wuzKvI2omeCHVrDhGD8C5zvq8Z248ub/XobMn4sZNo2iadlZiJnl9axRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks Luben, I've added my Rb and pushed out the series to main.

Cheers,
Tom

________________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, March 23, 2022 07:48
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; Deucher, Alexander; Pelloux-Prayer, Pierre-Eric; StDenis=
, Tom; Koenig, Christian
Subject: [PATCH 0/6] Complete and add dynamic completion to umr

Complete and add dynamic completion to umr.

Some of the difficulties seen in this work were,

*) slightly different output of sysfs files depending on the system
   configuration and the number of controllers in the system.

*) Merging of the IP Discovery sysfs discovery mechanism.

*) The varied and finicky user input strings.

This work was tested on two different systems with different ASICs,
with three distinct configurations, one of which includes two
different AMD GPU controllers in the same system.

Luben Tuikov (6):
  umr: Rename "scripts/umr" --> "scripts/umr-completion.bash"
  umr: Rename completion function
  umr: Complete umr completion
  umr: Replace and reuse asic.ipblock.reg completion
  umr: Replace and reuse ipblock completion
  umr: Add FILES section to the man page

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>

 doc/umr.1                   |  13 +-
 scripts/umr                 |  83 --------
 scripts/umr-completion.bash | 402 ++++++++++++++++++++++++++++++++++++
 src/app/CMakeLists.txt      |   2 +-
 4 files changed, 414 insertions(+), 86 deletions(-)
 delete mode 100644 scripts/umr
 create mode 100644 scripts/umr-completion.bash


base-commit: d773ac6b1f529c02d8d2021d69e2dcfad736628d
--
2.35.1.607.gf01e51a7cf

