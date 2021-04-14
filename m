Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB0C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7F1611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7F1611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF2E6E44E;
	Wed, 14 Apr 2021 06:18:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9486E44E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 06:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOIdczliX9/7MGd8Oi1YJ43E4ztl2UWDCLoQSrhomZykPhiFaBBgpjNBpys0aTVKDLnEgCyT2Pb6PnAOxiLLOrO52mu8suzbGZ5F6kFSJ4xgm50bh4tuzqUtbGkWlcUEnkCWk5XLM1w+lJLEGKwq0aIt++ja9eb/xFb+TxghUpWthoBYgHpOnTd3JT6MwlsMf4QrHFyzGg6fFslWxd6i/StupDFIEuepQUCdfzvNsuvywG07qtqYMebibtLIo2Ndgd8MDttUIQKyEZ2lRboQ+PVc0wo3PnGlcI3ZUWyRK+IJEHR5Hj+5Ch0n/fu4LFt+GuNGkAt4pcQbKn/d1kU40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syLn9azjrH80lcRxa4y9seYNKj9gzj454m1R9zpeavA=;
 b=ffCVStu9pCibcAJnyHDpnwAWKjd5KduW/4ogH+BdLvJGStfhgOH1uwXSW8qPhUhj28mU90hpUvYYptR77C1FOw+cmERhgGJDs6BQyCXbmL8hrTTjRnJ8qFemStFjay2jJr5OML8fu2jUA/WubIlGUUm4FSHv5MOAW6fYM+EPu6enlG4Vx31gX2xJcDjkB+C2I6GjYxV/4tAvYFdPxf6Ua9KmaLdlRlHbIlGPR0mAWalcGuVolVlb1jOb2KGGKreN56Aoe4iuMieqiaRV8NMu7+xnZvJMtZHWsiNoER29v5Bh2YDr5c0OXFl7CFEB1pX97YoN0b0B1sazQIqZzPtv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syLn9azjrH80lcRxa4y9seYNKj9gzj454m1R9zpeavA=;
 b=pLxqhF90dXcQbK4oq3xGosOvmyF2WqoeBQG0vAje0Zr79qUyvbDiOuVzIu2u+i5vsOkHqyp0dNh1fje89ATh4g89MvUyRVtTWYdJb/RHwhEcCxTdVZSQAhCUd5WAgbb5DMte4hRloFDGynYWHj7OcP3wGDeSZ6hK+vDHKgWjhf8=
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 06:18:28 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a%6]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 06:18:28 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk
 for vangogh
Thread-Topic: [PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk for
 vangogh
Thread-Index: AQHXMPX8+e+z9hqqVka+p6fyPSqFHg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 14 Apr 2021 06:18:28 +0000
Message-ID: <BN6PR12MB1124EA970392831E473BD0F0F14E9@BN6PR12MB1124.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 131793dd-e7aa-49d8-dc14-08d8ff0d1ea3
x-ms-traffictypediagnostic: BN7PR12MB2836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2836E7EDB439E862C5EB3747F14E9@BN7PR12MB2836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bn+7D9cAd5G61YEaL9ynQ6HMFmoeirZv0N0N5eQ84mWPMds0e0/nuD5aWjo907NrBaYWkXh33M4xyRrrX/rO7O4Z2cvsxbLU+AKVe9E0GkHYHf7ZfS4lC0+ZoBfxZu5mY4lKLNNparGvg4VcQnuvRnfZjQwTTBo9DVr/Q0a24l0rvC8ArRMV8XOZLxh0vloCJMzqx4pguoWKqpAyQuIDx/13okiIKyTI7+SiKjXGBPbwDNWy2KBLKmJ+28ijvYsHCPk7hVAnTSk4D8Pi2QZ52sO3h/D+m8oJ9FfVJZKAnVfMKpj50wonWT0qWqfy1ZzKMk68kLh/Zf3hmIgOgdqx3Q/y7/+36WONVAgkZ9FvoK+M7VofHXeBYaBasL72HlKMKzG/Dqck9jLWGgHlBi1MJk0o/KF+B8XOSrBTlyGYOyJ1QH7LdjazyNMlE6T/MRopWCH3zjISlR3QxMnR2LcWRZmKlbBJAkoo09sYt1TIDcxkGA1gm2EF5FnDisThpFe82mKc+wjJBppKje0Oie98hauQdhI4Ph2kBWkuEe4sUXo8CChlDBpxWTbUhDv+rvPpeaWTzvnM1LpcaGDd/VzVpefqbTS1hGdtbGEVnY9jJxw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(76116006)(83380400001)(26005)(38100700002)(9686003)(33656002)(7696005)(558084003)(316002)(5660300002)(66556008)(64756008)(66446008)(478600001)(54906003)(52536014)(71200400001)(4326008)(6506007)(2906002)(66476007)(8936002)(66946007)(86362001)(6916009)(186003)(122000001)(55016002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TAQmF0uOslF/extwbEUQ60sJQ4VoNMSsUkpQSWGTI57+Pk9IlGdWLv53VBRH?=
 =?us-ascii?Q?pO5dcA3CMu6IwWZaHQOZIv74eqs8o7eUtqzqMDqOlBEHOw9P96UZdr9bz4+X?=
 =?us-ascii?Q?lQK7TpsLr5rSIgpDztrkHTu1ggkq8qWTYkpjWUK3quYBFXxbEeRd2/off+CK?=
 =?us-ascii?Q?Wh2WodyIbgWI8qGT95x8rKnCLS9eFvn+Bu+13TCMQ4yzFqcMp5jF1XFMmRu4?=
 =?us-ascii?Q?FKvwR0EKfDHuHAv9z9IGJJiRww0EAKg3okv4LB/YU0SIpQ50ws9LmD7F5yim?=
 =?us-ascii?Q?4FsWq2ZVHQ1X9Awe/jsQnUZrGZcaBa83verVVTo58f+wLei5IJ+OHxldYTqw?=
 =?us-ascii?Q?Rxr5I0DGRLTfLmWQ8Ok7fshZuKWz5mVJAl0p1tAtitLBkcMfoPP3FcWXRl/+?=
 =?us-ascii?Q?dsJPgJNlum7P+2h8lQmS0T2MZ4UjIMnUAx6CF9OS7IZHO/xAC9ra1tTwuM5+?=
 =?us-ascii?Q?0OFEUDxsPxEB3aLYqlaOwxJr7+NJ5HElE1qFKZTOBtIiiQhrLjwCXd+QAsyC?=
 =?us-ascii?Q?py06OO2NojTDCRTbVIrzpGzvi7rJInNbpEw4/wVs0f7bpNDAVdursL7ceN7p?=
 =?us-ascii?Q?rnwCWS1RClya/qZgdJq0uMRG5Tgtyi7MwKCVyiuRYiRsB+BFHy5+igRthRcD?=
 =?us-ascii?Q?ysI/JsdQ/Vth+71WQqgNr+v4Q4I5PE2LYUnYNWPvUTDHnrk7hjKxG3qnkbMI?=
 =?us-ascii?Q?KeXOshXOYaX4RpoDR4yQiV4M7uTiB/tN3sR/PYYEjWAOm9Jb6f8x00CT7aRp?=
 =?us-ascii?Q?A5oAS0w6fb05nci9grWRq3eUfwF4iOMtEx82zsLyD7Ib12t5NCWr8p+egYZe?=
 =?us-ascii?Q?fGPBJx4nA6qCKYK9nflM8HXsx+TNLpkux/d4RcVyv8UFkSp4VKc6QLNAiRg2?=
 =?us-ascii?Q?4WzpBLRvfM/6GQugsi4PGwfm24DRmsc6HfmgQZ0l7dV4ttoQJ1EhY/baE7KQ?=
 =?us-ascii?Q?acxt94fpEyPZIU8OV5b5rdM9ViM8rl/Ki7+MUUv1QQCGjZ28TcJLFOIjQ9ZK?=
 =?us-ascii?Q?vVhGocr1yWRauYAYnZ/7tzU/PjIrbctNSEzZCv+BpwwfKpod3VoT0IlYwqYw?=
 =?us-ascii?Q?RtpS0EjBb7W1yQxjiIf9XOFLR292c4H4HciPnpepseLrID7OMjz05+bi2vMN?=
 =?us-ascii?Q?5aIvBr+MyQ9uONp6xyOfxpIwsHoSE7kCIcBY0bBZWVShUuCo7BHtkWg67/VA?=
 =?us-ascii?Q?tx3r9W0uedyGrS4hhHg0q+hzvLSxVsQS5Dz4pJumT4knOhlbu3FomyeGQ4W9?=
 =?us-ascii?Q?7ymDgZrYRSu2szrxSEvemM0AYoQYaEy+LSYMB27lL9f1qpKhjxufPK3cgOWc?=
 =?us-ascii?Q?Rl8+raZJDO+hoVGGhKYrr+zX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131793dd-e7aa-49d8-dc14-08d8ff0d1ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 06:18:28.5178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjVpCAOLX98JwWEkHezWALywtDEpwzL6++FTJaaQdHXYIG4BVqcYZlvuYyZXQsnK1jI+RYaI1iLzf5ZZD/Fcuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Du, Xiaojian would like to recall the message, "[PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk for vangogh".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
