Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8E8C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 04:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAA260FE9
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 04:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAA260FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18A76E0F8;
	Mon,  7 Jun 2021 04:06:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83E06E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 04:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmSoXUX3yQ7sxgH0SxSaHDbvWHo8h5IIFjo5A0XbmoR6WRS9lQbPGe4lEr2Gl9tAXAPVQOwrpO2V5YQge7Y6g8vq7dn4Qhfm1QJupv2zO3TXkCbsQd4f3zg9/8cphoCIonjk0q4HaLTmYz3ytsvtpeX9uOR9dbTmUI7b6maCuhbTQiOIKrB3aBh1d6/PJBSpDsez0UolzARox19AdSP6vJevsYV8vLpiO1bs8zRV9Tk3RhdNsxq4LKKxDOzAHP8he3lMC5XOTUbXT46JVidlxjc0aTkk/50jAelMCj4Kv3q2/LWogDkJj6nmrJBQHGHrwCpiSaMtm7zKnYVzhUKJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS1VnUfywRPoE4EuuAQtgS1zMnSNPxvOJSGUdlXfNso=;
 b=oYnIVpvz3wrBbjrSqG+h8GDtFqzO7+570k5bq+t3hwbSLy39d0Cma80RhuBSuN16Tx584Zgza7+10ApwMedKhX08oEtXYidkJZBLYtA4eobNcckUoUPmrZiaGa1lJ6b3c9DU4ce2jBbR1GEi3POtCI2Is2kL9Fhva9w9gJ7hr3zoYduhyDsYFRWqOS/sLERMaD1+iTVR16hzRl2jktNss8xm09HGGFGRoCJpeMSOSpfqFdtquTZ/r61i1imP95jXpJL/c0IA9Pcui6RLxhcoreMkx4NF23yj1g2LP1tg7l3X1wZCD9MkSx00NBfh458bOiqrBfvdgqRljZLe85KqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS1VnUfywRPoE4EuuAQtgS1zMnSNPxvOJSGUdlXfNso=;
 b=tpQ9TTrl1gDrI4f3T+aDXG//jsTKDqdPJcsQ0k9Jl35yzRBvfTyMsOLasAa5PXBproncus/GzSbSVzb7zjMrbnoJN1pOaoRygKwqyTMoPJTMa4SIEHIgK6rLVOGFNY4Fzr5nCkYYPxpWFKOQai7fkUPGImPDe75G1DPR/GdyCMs=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR1201MB2524.namprd12.prod.outlook.com (2603:10b6:300:eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 04:06:33 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 04:06:33 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AQHXW1KA7KttwKtXtk+kqkzCLBnyMg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 7 Jun 2021 04:06:33 +0000
Message-ID: <MW2PR12MB4684060F69788AC23AF0342CFD389@MW2PR12MB4684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd0e9df3-4ec5-446a-f1e4-08d92969a335
x-ms-traffictypediagnostic: MWHPR1201MB2524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB2524711970723F3FEDBA8478FD389@MWHPR1201MB2524.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXy/gsqVZE2eXq9a5VFQI6u5wdZ83TnMbCSmgpN3eEAPrKN3rzqbyCsRXZHAtf9AaUIV8N3IDZpkwDRFSFEzf8zi/H+Sc/5TU2gtm8405a5P8jCHMY8btdWmDce2/4z9EpWNfVnFQU/oXLCvBwMLFb+YHLCGZeFitAJ8TjP4GacF0JjkzCBADXS1Y3tXw8bBtiWitNdsmSjCH81qjah4bgfZyz0D47f1xdDtxHm+2F266Ym5kz2HLnmpz4kZa3zhyxEvisjpwhqizutxZJEFEm0g9hF3EpBMEgMmx2OzTwZOZYZ8JvmFHEeSvONxolsmf/yTOSc2N7t/Y9AwzM9aGwEHafl2eSo4u3JsznGVI77jraV6ce+N3SWcwNm123yX1hsQLBt+BKyRAmglhjaXUfHxYRb5x5UDy9kQAMniNf+PSkjx7WNRFFfmZt4RTSL3e6eI3igtwcgDBFxQjKTiR8E6g12UGTnd7hSav61Iyfca4nY9xGFdvnU2NDibYRupnLWo0kppLi5216D5yT83MXXNzrk9FCCGe3bT29R72g1ndb0v8yl6/wL6sfhVewQ4o0WDjKn3PZ1rcnn/+oFg7y5Hg1ibsHKKlVk6wHhCKps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(7696005)(478600001)(8936002)(86362001)(52536014)(5660300002)(76116006)(66476007)(8676002)(186003)(33656002)(122000001)(9686003)(66946007)(66556008)(66446008)(64756008)(26005)(55016002)(15650500001)(83380400001)(2906002)(316002)(71200400001)(110136005)(6506007)(558084003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YQGOa+xkXozv9ZWtL4QygREnXEMgHHjQZYDjxYmPeYMZ4inZQrmFVotjOLTR?=
 =?us-ascii?Q?/1uoHqiIdXrYf8JD/T9X9OG4uUHtMUiyoL0a19JOJLFi2nse4a1TO0U6xQAD?=
 =?us-ascii?Q?U6IJar56WTil/8US8rL33EvTeOLCr3BpRJHsLvhrBCTsIDwptSsddO1lN44h?=
 =?us-ascii?Q?v97hDARl6LNHVwQF5cH6/kcoqO4Ioz6ybNRifm/J+ph/MNyFOOms0PXr40pg?=
 =?us-ascii?Q?m/HUGJX5iR+ggDn83XdJ5Od9h1YQuxrT+tm5WKWj+ztXGuRIOSJElQ1G3JJJ?=
 =?us-ascii?Q?VdmiUt/4uTY1pEJGElIUJIi8VQjxo9zvUmTBQlUq3i0CasYqml2gnaacYJgG?=
 =?us-ascii?Q?A3Zlok/nLK6wkQLGnBmFK5FT0VUL9btntQNiBzDVTh/e3LuGEyeQhGnj3/pB?=
 =?us-ascii?Q?dm0mPf4cDhWYfhwRa/UDsBum3Jy4EdMlBUSHWAsX1G8OHQqrAcwEewGiZ39e?=
 =?us-ascii?Q?a0y8gDyUTGplyVOr6la64UmW/rgqpyvFCiTAf6E2JGhsDQj8OLzBfRE2cXNl?=
 =?us-ascii?Q?b6ZBw1t5AnHWm9QMNK0plt3xPnKRY/ccx2/cOtijcdUgZD30ORF+8BhXFaaE?=
 =?us-ascii?Q?scqCYbfJlCMzsQD0aplQ7MiEjco813AGvvJCyVAduO+BMFxRxvVx7RemTeEP?=
 =?us-ascii?Q?88MPbLV97Xcyw2zeGWs4nJH/5bbaVZxtCLiLBTNAPUub5qtT+y+dd6GgPfrC?=
 =?us-ascii?Q?MmZ6UMl0IUg+c08kP9e195PgNthfiWrt4mArwOnmWLztr0Txi19xUMCKG/47?=
 =?us-ascii?Q?VUIY/Nu11U4bJjZFvRIxha8XxdAKmX35N41za3h7Pa4TBL8TJvOdtXkzqQLz?=
 =?us-ascii?Q?RB+3H4XS3TFbUyFUKMmlp1Ll/iEaiQKHZ1fxQYixW5fPPpUr772KLLr2EbIy?=
 =?us-ascii?Q?sNij5ter1wc0cXoD9sTWkeARNQgdXan8tvZiHzu2k7jILp9hqTTj0BS8Fi/7?=
 =?us-ascii?Q?o82VkDpmMklg7Q0/XRDHp3E29shuJIpjuQ4nqWDwubYGKIfzfFaPciU7k45F?=
 =?us-ascii?Q?xGwMgoRsfbKyMQ3XUNFqGn/rblCur+CvRO0c8dTPyP9NglleA49eLW52OehV?=
 =?us-ascii?Q?toVKUXWpZWl4CYRmCpoxU649+zL1ih4dGUrjaMWY8ZlvP758JiHWnH7qnZ7B?=
 =?us-ascii?Q?GPIcsY+3uQBXflo/2uH9nC7+Ue+hYqOMUm4Nwd2EX1YnCCN4bf/P7m3dULrR?=
 =?us-ascii?Q?0PKKJAxMhk4RzmhR3fxk2f3jVOGbAn8UdPmykfz/+9mN41z2dGVCyz2rKSyC?=
 =?us-ascii?Q?fYefws5CZTBP5ToLSbEvzTuerXHasT5uKw8A1zxd//WERI5i99LVXwlROpOu?=
 =?us-ascii?Q?162sgIf/xdd1zAA+bkhitlM5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0e9df3-4ec5-446a-f1e4-08d92969a335
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 04:06:33.5062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyIN9lb46eZym9Mz+robSPqmq5c8CiLwBq7k6Yr74b5WePjOh/7yVLPAdgu80lES1dI4EPF/bezuTsD/vTHmCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2524
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Zhu, Changfeng would like to recall the message, "[PATCH] drm/amdgpu: Update psp fw attestation support list".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
