Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A5C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1334D60720
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1334D60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77796E8FB;
	Wed, 14 Apr 2021 09:18:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5290D6E8FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv2CZRq0sfW5QI+nJXUpj6uRD05G0pyOinxMkycsMlC7uVCcb5hGrejNRAgD9dOK9FCAWLne2tWUj8aF0HljE6fJi/y49R/LzO0QxVTbQlp7YKq0VzAwMfs3f2E0rzrwwC66GZli1Z2qh81L7WS2waBtemEJ6YFO24Hh9BhfqoYO+QxAGpkwYtO4BHUfcNRzotlo7Ga06h5oohRdSfd6f6JIsY6kqLraOKKVEvPSxj2/YvGf1HGqoaVB+j3bBR9guX5l1nBKC4Ii1qg3c14URL/uRrsHRzE7pfeXc2vloZQbY0cdu7wM7tss86O4Va1ibdUxYWYIpopv7cEQmLX09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUGiuUmZ0xzTfXp/lntHQmJgM24DNlkwP5eAKNeVZ0=;
 b=SwSjKFZ5Ku3q5XxURKYgoL+3e4uBWcnHJqADv+YHD2JBaYPO4rN4SrwygZqICndT8wsiD7C8AIBRTaC7QCGQJVwymJq2lzUOfI6ZESHXYeagL5YaOjL+3nU2v2NJAqwGD47YIrGuWEfDT9H9hPJrh1R7OjQJ0xD33SRoo3VlE2feh+QspBjM8fDBKq7QiJWnEFf7NXfr+Ws6Onnurfz5p7spNqlR62ytThEDUptQTeVt8RertwkYieTsNRWw/si8mcFevPybCwnzIMqFHJ8nuf3Q2zN36V/TJLoQ4EJytUiueY2SlDZm//eSI5kfKRr/deRh+8phC6iyKffI1jYP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUGiuUmZ0xzTfXp/lntHQmJgM24DNlkwP5eAKNeVZ0=;
 b=Tv5cJDPn/wDyh4TVTo+SJ6rvb+5c0+xQAhvsYVefWnNlvNwkioLU+vSY3jHR7xKx3owU//svfT2UPbcmTmo3VMj7L8Vc04wKKWzlfAOG1dogHO6pvZelhaaxiJho/dsRh/rpFHf2oB6BdwuO3BuM3y5WBHHzhjZIqfP+zIJEXQ4=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 09:18:24 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:18:24 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Recall: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Topic: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Index: AQHXMQ8e7qiZS7Q5k0+9gaw0JCWkUw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 14 Apr 2021 09:18:23 +0000
Message-ID: <MW2PR12MB246071165B6EA07077290B339A4E9@MW2PR12MB2460.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dfcd3ac-7c54-4df5-9b12-08d8ff26412f
x-ms-traffictypediagnostic: MW3PR12MB4427:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB442737C6B02F923358EDED079A4E9@MW3PR12MB4427.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDY38X08WjmsKtebke+iBAxNRg30KS3L1tau6Rhz9fOG6WhvtzJH3yW35c+5jtJWnkQp8goamBp9kSNXwwfy7lmyJiOwcL2ZmVHjXrUXSrpe6mCpC/XL1MYAV2MuJUE1ek/eT0/SKpfuvwCBKrVr3wTt0aSAy7rUn57K8W8rAEERdCj51RCe2angAsMa8ikgAcMSxX9doLHzlsfdh7UBOf7Z5U9yNKHj9UMuMzMMnmAR+h+XpTkR/TcGzMOiV5VyTxM7lFfz0trfhTgvDzP/NJ952rfGx1M8itwKsR/64Uq4SnLkGImWWx7/IsXxGzX6ysSrA/c6cuGCtcd41yPuh96necOz1UZqc1auJGUH9E7nSjjlujEYtWsK34Z07xrfF7PMjE647/jUdOLEfGytsF0qORoCHFEAYZgSXl8A8LytqBv7JeVIYMANhdl0UkESGzAUkZdJvQdrb2b9mThMvMBAs/p7hAhshEqtdpPPcUfk6OgHtm3jlYOFo/rrNrR2MIZHwYvmOpofsP/9IESGN+hcE4M/hWiJHAzXOlIM2daZ1I5XjFLxxLigKfR9wWtFd6ArYZFPuxtO4D3nWA5zT061SFN2OU8k2evwDJG9s7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(66556008)(38100700002)(66446008)(66476007)(5660300002)(64756008)(76116006)(7696005)(316002)(66946007)(86362001)(4326008)(2906002)(122000001)(55016002)(110136005)(33656002)(6636002)(186003)(8936002)(8676002)(26005)(52536014)(71200400001)(9686003)(558084003)(83380400001)(6506007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K12U8Hwjhc/Mqum4aNFoE23y7ruH54ajoV5pqAunQa6OnqDkkXiyM3mfI6Z1?=
 =?us-ascii?Q?8IeLFLcS+Qs+LtIXiYgBeu0QY3kCCqDA8Tt28iuJtlbY77ykOrSL8d7FNvlI?=
 =?us-ascii?Q?2W0H15gypEzCXJvazA9JsUnBwjjkLEReEBuVY3T5qSllRIwPF40RU3HE/m0s?=
 =?us-ascii?Q?J8N4pPB4Ucy5LpLhFk//5V4oHQbUQG5k3IkaHjsBLvv0OXk37DrGWjHql8cd?=
 =?us-ascii?Q?pYTDJiVXs/a3hYtwpxQV3C8Hvz4mBL3hmAxAYPqLmfMGrgznHED0JRFIq63e?=
 =?us-ascii?Q?1nvW70Z1d7k2xptomKiMiq2MTeI18J62AQ8G/nWMqQy+xZ9TPEBkDi5QglM7?=
 =?us-ascii?Q?GPu5ba7WBHe1wJ6cmNnP8zwboOIavKJYADJQGVjszFaCj2eBhbtPrDTAUeam?=
 =?us-ascii?Q?I7p0ZzzJ53SIwbtd6zg/0vXKMIZGKl9Ig2dH4tki7TnIfXrRL3kPD5DlizoI?=
 =?us-ascii?Q?el0MnynZxi0pR2iUeQ64pFcENmBf+7fII756/bf6g610PQpr54KW0WzgaQ6q?=
 =?us-ascii?Q?JRJpZVm6bf2bVkzvWCShNjWcsKakWGxCpiLobq9JijvfBjiOCCOFAQIzVLsQ?=
 =?us-ascii?Q?lwdw/vqm39abwhyhugYYtfkOkofdcugeeLjenFQkITnmO4QLhWE5OyDr2Shh?=
 =?us-ascii?Q?6gTd2/ji3VQ1IbcU9Ag3hCkTB8QpiNsrIW6HWKn1vWLHHV194QI7NUmfuSgq?=
 =?us-ascii?Q?WVeofzZXmdnV+fn023x0mfAkJsy+RnW2aDUVvJpA0je/XuW3A/SoW9GaeYQn?=
 =?us-ascii?Q?H7b/1/hCji6AE2tXlchHuBQ7HeQtDF3jcA4y8+lP00HBSybXS5SpAOZLvfZR?=
 =?us-ascii?Q?KWtUBZup3TKZH84b33wsWa8MxsVYtEpqF6Jj9bCmzN0Oad1+X45hX5baFN8Q?=
 =?us-ascii?Q?HTS6gvdO2pzJsHILCaVUOuGENWdk1wL9R8L9NlACxyhJg3KVvVl/oDNeBeUG?=
 =?us-ascii?Q?0T3//AIQ37Blg8RXl5QpP7w7ek1fmPu4s6KBAwubd7JL4jgMQvwglsu5cQDQ?=
 =?us-ascii?Q?394SuJQgMEgOtIzkFB2jS9HKE3R2hsNxQiv7BY8kqQqzHUib/DiTnl+Y3h3r?=
 =?us-ascii?Q?wF9SxseFcDtjoXaA7fL2tXEbwapECym8Fh61cbFxsw5yIbCbwQd3uNGfDU2R?=
 =?us-ascii?Q?6wYs0n2Du15aiSvVkNeQEgpUnU/6jaiwVIwJRE/iezHLU/WNjm+ji/DeZO4m?=
 =?us-ascii?Q?Ae+RDqfxDS+xg8puxTbaQRhrHb+VHcx8wv1IYIG5ucr5KuqKEEowfs00BiNi?=
 =?us-ascii?Q?3O50dPMcEga25WTTUjPw7AJCVe1QQoS5D0t41P/VGX5J/qerB43axz5QMeAC?=
 =?us-ascii?Q?lS1pAIxGBy/DI5aS5ekMF3am?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfcd3ac-7c54-4df5-9b12-08d8ff26412f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:18:23.8635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40XIUKZ6QQb17OcOKwBmHt2E7FgcL6Wd4Zad9VNWH+7AZQcNQuX9/KuH2R0vShwvX9yajFIHq+L3GI31ibJiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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
