Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE0DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBE160720
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBE160720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EA46E8FC;
	Wed, 14 Apr 2021 09:16:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4D26E8FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkHzfkgJxJlFG7FxkbGt9R5FeTO4f+NI1IvzV0NsC+6LmbvYzSVhylf58JpKzKSsgK9iixTbM9QheoEGN89V3+1daimEkA2nSheQfQUmwNzs2OomaKgk+9AmaN9Ox/9H0g2+V2JEyLxmPC4ur9WoU+PPVdk9W+swlUze8t5XoF/ajmFSe6k6BHWJvdFz93tvvCbupOcmyjohv2DU5C5+ePauarlW3f9bUvz4zkWLXnSoWfYY5/l6skDE77b4fxpFFwe38+HwEnOWev0CKZNRAsOYc+Rg0gGf5GOhQtHuUZW/5Gre7R5eLx1eA6FejfDIVSxiCxiRlpL3CWvA9Ao3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUGiuUmZ0xzTfXp/lntHQmJgM24DNlkwP5eAKNeVZ0=;
 b=COBOa3Xt28PHeQR3cCz7/1sD9V9bcl7Pt0u3NXQ6QaznpEbu9NyDRMED9tn6TXzqu6ny1hUeDviz4xmyKANn6Pm67+8AncSEBCwUxSdDlGts1Nt5fqmZbVIuHoNJjiGG5k6A39X+hV7BX1FipQXo7FbAvMSQBp55YG0MLAoNv91UEw4yM3hnZuNhmEsepGqDHAW8Kwmkq5iLETJzWp2KXr6j6WifL+rFICoP6DmC+DSz4/Fx0uttVHoS4b0i7ZNAmlFoUkb+65QT643KJJFs+OTjo6hP5fagdY9CbMiHbXSkB25K8mbF/YWZEVbsHxjOxI3zn44BLV/pRzl9rtmAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUGiuUmZ0xzTfXp/lntHQmJgM24DNlkwP5eAKNeVZ0=;
 b=PMngZeOKkDcFltww2qnRm0XpNmQL6+WJAOGvUSgciasDmmVlgLN3i+sCm3lh4g6o+D6JW6Ev696Sm2b+pe9XbvuMMmkedjk5NY6HIropXJBOY2A3F9wVhnkoEhrg7rlx+jNDjZccEC3J7SMzX41vPn6RBzEQgWvSy4IFI1Uj4y0=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 09:16:30 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:16:30 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Recall: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Topic: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Index: AQHXMQ7aSz8lKD5TmUWy6Q95IE1VKQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 14 Apr 2021 09:16:30 +0000
Message-ID: <MW2PR12MB2460DEC1D80C10A3D5DDD6449A4E9@MW2PR12MB2460.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cafb1717-f8c1-4c25-fed2-08d8ff25fd4d
x-ms-traffictypediagnostic: MWHPR1201MB0174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0174A700D1BA44B292E757549A4E9@MWHPR1201MB0174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmwNBvC5tY8j8v/7IQoBa40NiQem3l13kPtIys+x8yMDscwY6Uvu13z//Tz5Ng/li/uXTV0AqcxnZSDChJuIxoFw7QUowOHFJJrJ3seehlEIEBd8NK2zvJIt/1EY/K2tp96LfgwBFRMjIROtOUwzhQRcZT34uQSzU75RYUH4sqlPWuNkkLZ1NB4X1eGaIygrRariCCwdqcr/tFV2e9AEl9dzUjfgUKgh73WKzscMdNSVw544Vy4QNjojIkQZxVdf4CKANZe8MTjlFu4FGwN7P582JYIundPnRcCdsEkWD0ZbYJhZtFZ94w3BSlSp/PwEdqMonjnuwNwMQMvKEODr4mIk9EIvlPTqbqTMpu9OnhrGfT/gR67HYE/Icg97pxPaIPp8Rkb/jGP2HlLqldZdR/0dn24NITlYLzeN+MjNoPVRRg6mgT/4l2nZbj+9Bp+na35MKS8RirE3vCgEzmVoeZb5yoXRn26oJeLDs0ljfL47onEcKmn6rSJjcvY+870PhHBCOwDEL/gWV73tV/qPwxQrDke2r4yNV/5Jf0VTAppQD/DXv0B1XNLh9M7RDJqCTgq+sKK4u6Nn/CqxkBcXNH/3Fsu76heoS7/pl/hEOvk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(55016002)(86362001)(9686003)(33656002)(478600001)(110136005)(4326008)(6636002)(8936002)(558084003)(8676002)(186003)(52536014)(316002)(64756008)(66476007)(66946007)(76116006)(66556008)(66446008)(83380400001)(6506007)(7696005)(38100700002)(71200400001)(2906002)(26005)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lBGF5FoEOB1rWJc/O5Sd45VLkmB4eKsdy/MBxub1EYdV4N3UNEKjsPu++VAI?=
 =?us-ascii?Q?KMuWkwWDhqEan/i5AuwYpAF54btCUp8nZQR5Sn+iRQozMfTfFqTvCdPiNiVU?=
 =?us-ascii?Q?Vkc7ZC9N+H8aNmB0OJgUkkqWHucVfYLK1UglcH9x7bIu1qWnC6EfsG2LAipF?=
 =?us-ascii?Q?d/cOiKJmqeCx4gQyWtMOJIBSbcvOlHxpsyv4dCzhN6OLD3mEehC8FY7S18vg?=
 =?us-ascii?Q?sJ5ihRxSw0SGcK+KmVm6/MPCt1ZjzOaWlJXpUP/eL/QAjBH0ohctNPYZJ8WF?=
 =?us-ascii?Q?6rrmaMKeli60+8zsEn3YeWi2danQQAFPvcNo1vg75wXTGq/9cs8/20cHGCbn?=
 =?us-ascii?Q?GNe2TauWK4BRVZXydo4dbaq8c0HMb710nJiK5ofMRTD4MVumTUS62nEG44HT?=
 =?us-ascii?Q?W4Ta+O6cgG1LNbUChwIyV5V/WI8fkyuLy7bo8dUxJ7i/1BwFwgalhzqamSSH?=
 =?us-ascii?Q?fLCd0Vknd1KM97qHtjipoRLyyPbt5qb1lZv0oIoviRmL/nGOu+gFXR4/VrKq?=
 =?us-ascii?Q?Mzt65yfSOxSDu6hHnmOlFTn3QJgBD2tB0BbaCrR0n4Z6Qg3X8VDpRzioOWdX?=
 =?us-ascii?Q?zqsuVXM7cU1HVQM12oOI9vv/PVucB6asrb57+eIerTV81c4iaWOYJYlzN/cI?=
 =?us-ascii?Q?/mqXFJg2P63Ax42gFbgOSLpMJ0e5Y8xgpRrTb1hszeUdyva69Y/b4ZOAeMm2?=
 =?us-ascii?Q?JkmhuJzUW2BGu+MyypsJgR7boZaHM4gV0tlNt/TmOudG8Z5h0Ck2Xcecn2G+?=
 =?us-ascii?Q?KcnApUWEcDD6Iey/ubka6a1zo5Uami9qZ4Sr2z+Cdv2vyXWFe3V3n7X7IR3u?=
 =?us-ascii?Q?yC1CFWWYbepp3FGxJKzaYZ3JabCNqAPpD0v2cuQy1DjWVsNeOAhJY0tHQ8Uy?=
 =?us-ascii?Q?G7hDzFo8JCszNe6Pd4ieNCM4Gj8v9a6KBo+UArQBpeFQKYxyRsT4KrMbwCYe?=
 =?us-ascii?Q?mM7P7g2BF9SR/ajHeDvjspwHWXf7zt0OaPbR0RTNCeeZ/lpzPOO/t1Bq7Vhx?=
 =?us-ascii?Q?jw9jVGeIObR8LqOSJNrne7Dr3bNE5V7hx7IgpY5Py/3mMOQQf8SG2zfpdx6R?=
 =?us-ascii?Q?uhMxGyTt6CCeEaW8P/nZO5x7U5lXJdsZow4LoijwWIRvs57f1XCPfJGEUo9I?=
 =?us-ascii?Q?1f9zE6Roh6bMI/qNaOWgWKBZde2pJV84y//qgyPpHBzDGr19Jc+rjZ+26MmR?=
 =?us-ascii?Q?tV28c1xHer9eae50AM7fUMB1N+MBBJO7a/Lj2N04vEfJOU8JTxztan4wAzfN?=
 =?us-ascii?Q?24vgDGbQuict475Qhn4CxTjLnCsSAahEC/ZEyXmwRlgnMyWa0CDfuvdF6M3F?=
 =?us-ascii?Q?xhbwvJBUAawCheZMSsxPdC8w?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafb1717-f8c1-4c25-fed2-08d8ff25fd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:16:30.0285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8N9iu850cRo85+BoooWh1+Y65Xz1ZSHAKcq1trJQ96qj84Wox3tUC5/orxrSoG80XLVSAm0aUB18AaYcCwelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yang, Stanley would like to recall the message, "[PATCH] drm/amd/sriov no need to config GECC for sriov".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
