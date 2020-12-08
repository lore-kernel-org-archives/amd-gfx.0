Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F7C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054B223A6A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054B223A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AD06E06E;
	Tue,  8 Dec 2020 07:03:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680073.outbound.protection.outlook.com [40.107.68.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC636E06E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 07:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngrGz8UPjkYY8PfyoKl/uT9vKEhbtCt3DTjqWOd32rSCZ2wW+/ugQabSbLzPeLzqTD2oPMBqH+8mQ/u7qiiw2C5fd/BwMTIuGRD9fMXdxYPN0Y2PtvcWe1XX0r+M2M2tHxVnAOjcv2W1r+VTJIEB51P2DfjrDOmqdgWEtYXqMbPJ22N+6sZXxOD1UNMU7sOxil7LWvRsoiXYoclgkwrwiOCnqUgV00j3Ut9Tb+VXMakJbwTy7/4JoyfitOtqBwkzrEoBONJEbs9b6sffzpsJq6Z7/95qcxqA1rF8ZusWtW+RkV6SuD8nO64RehKFKIlAex9pFpP0L0YJbPwHqSbKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjNAe+pUg9eGhyVsiZvIyDv/QZloKj0U1D7vvLOaipA=;
 b=Qk2MqLCY360X29vN+k8+lxF1RQ1YIi1yScdTOh3fALA0cyukkAcDcduoPlBU44vYK/2yhfdjistWFFIhI+cjCtlsiF5WLIhlS6y1y5tJFDYKLGnGkFgSyNBrZ9Wkqwl2FBxQ0VoGALrufBjZFYm2BmKvdPRPFlX6JiqSdDHUKdEOJLPzcFLcbuMp70/LYuJqoJB88u7CDFibl3A00YKM6X1m5EKvB/+vnAkVi/a3SurUs246DBASdJo/ZPEsBXysphQn8hNErwZqiDLyY/Zu9D7pFxEAK2xFF7CtaJtlMvimhWGILb64CFlHTSaLQlIH9z3aDQf7mEo6YY4zY+KifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjNAe+pUg9eGhyVsiZvIyDv/QZloKj0U1D7vvLOaipA=;
 b=wyRwjRhDQ/oULvt6IHA9lSsVyUQfI666YdoY32ZEt619gKgb0wv+V+P1uKPs49EIbvfeJFGnQ7jrPMACOGtDD8rl9dkOso8ewUpUXNQA+pEhZ44R6IrigeYy/bsR0r9cZokn+Ews2Ypbv/nwi2mhd+Gxmn1xFfm6U+kTxubD9ng=
Received: from CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 07:02:56 +0000
Received: from CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696]) by CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696%9]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 07:02:56 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH 5/8] drm/amd/pm: add smu13 ip support for moment(V3)
Thread-Topic: [PATCH 5/8] drm/amd/pm: add smu13 ip support for moment(V3)
Thread-Index: AQHWzTAn1ek/epAfGE2/t76eoV11Hw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Tue, 8 Dec 2020 07:02:56 +0000
Message-ID: <CH2PR12MB4940F31369B059A403A486E4F0CD0@CH2PR12MB4940.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7c234f3-d685-4d66-3c7a-08d89b474a7e
x-ms-traffictypediagnostic: CH2PR12MB4229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4229547E509FA9B62E7D3F40F0CD0@CH2PR12MB4229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayR8q+FZJUe8w++KLV6NrydnE4l5TVh71wCH2nB0Id4/xUrukKbgGQvZLIVM+0Ik3y8GRP8e7oR8Y4MUnOfuKW+CkSryOMsr/bnj33b0s0r7jF7XHf+3B4IFzxMu3Kg97WrKTIoWOuUtaSfbRC8hjVlUE48iNUh4PHooN0dmAaqZt8HDfLecnfUmbsmYAqOK93W2u7me+2eZibwmIp9OK/wNsQkhiBoLS4aSHD47kIq4AO+V7ZoDcc2unSMz7vTlmIvuTf35x+nK6/n+hE8SOQAjLMlx8Rag/nmFVlb8xgQELaYUMqg6dymPlWeDEA7y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4940.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(54906003)(2906002)(26005)(55016002)(6506007)(4326008)(478600001)(9686003)(186003)(8676002)(71200400001)(8936002)(86362001)(64756008)(66476007)(6916009)(33656002)(7696005)(66446008)(52536014)(316002)(66946007)(76116006)(83380400001)(66556008)(558084003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/FaKZse9l3IKiyQ+SyXRU488I0msFtWa8r93v1FcpTPiaC2dyJ60lNndPnaz?=
 =?us-ascii?Q?SX7BNrj6RKDxjkDskQdrgi8Y3jxiMyHqpeHarTJR+3W24lROqgnW/54FwGKe?=
 =?us-ascii?Q?5juixBNS2b+sOuSTnzIajwEUp4rPHhpBHAhJ0oadxzBJMVl2FrhSV5Tq2K2M?=
 =?us-ascii?Q?xIyvUY7SDSJ7D8QZtnGY7RnDQ5PVhfWqOoD4vNnVKeS6PH4qGIH3FZ5Fh9LH?=
 =?us-ascii?Q?PidcUrZXE+IwIL6CHSBz3zmonlkj3OlTydKwfT60o3Rj8USsP66yoVs64nVy?=
 =?us-ascii?Q?0qs6r6vj3eikjs1qzCyd6HYgfJlQaiDJu5ohu7N4pqQ1rEaalt9wgKjircO0?=
 =?us-ascii?Q?XCeBwtNTjdgmrcdTgAmZ2PR3SJhTOUx9OeEZPLuoBMG6PKbIpXGFfRLCG7Xf?=
 =?us-ascii?Q?a5MAMCf6rhK/wTXVOich1shgd0XnIDzRUce82Cb7FMnaVIPYlxlQSRiU/We9?=
 =?us-ascii?Q?g3KNQV271DzLJxtFIjug7YkZYBYLXn5RKgwTGhWd/8oUFEeKMpKzKUeHiuXD?=
 =?us-ascii?Q?ZY26y1GiOHtW0smU06nVfw4LxBqb+hTluX3gp29lwcnPdQsxFFaKRhXB0WU8?=
 =?us-ascii?Q?9StSs8PvIeh8bYFixmAXROYSX9DaN6Jv21dlvYyP0h3u3KeX+GYUAO36LG5p?=
 =?us-ascii?Q?vso4p4xVCFhx9R4FrMoBVtnIoPk0SKjrZLCpFLflgbaCSGS5HBGtdQ/jS4IT?=
 =?us-ascii?Q?jB3HIvD4LgnrrTE7agXupxQw2CCskNJhEbwNYUFKSzvwB4ZfLGGJapj9vHjU?=
 =?us-ascii?Q?4U8ag0jT7MYmy77EbWyx4LblNlSESAzgbd68GiBosvyALr/thX6l9Z5+fh3D?=
 =?us-ascii?Q?z4OPF7VsOImq0Xy2F4uqyMoaFhrOWD0AiHroQKPUIYoFcXnymnaNmIYJk1MP?=
 =?us-ascii?Q?TpmsnkbdlqdLUKzjabpDlhfilFiHxKYMqty2jog7sooPivdZcvYO/K/7g0iX?=
 =?us-ascii?Q?6TKBqaqcGBlTRCRm9aQdn6xS/BFBMbbDQkL8hie7jWA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c234f3-d685-4d66-3c7a-08d89b474a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 07:02:56.6938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leSwVmllZ2T3KI2+j2Bw3Fs8xze0GoYuw6vd8nbjLXLn9i7JNwhWTU0mDapptT4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Liu, Aaron would like to recall the message, "[PATCH 5/8] drm/amd/pm: add smu13 ip support for moment(V3)".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
