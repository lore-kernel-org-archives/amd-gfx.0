Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FCFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 02:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6390261090
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 02:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6390261090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D3E6E423;
	Thu,  9 Sep 2021 02:43:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FD86E423
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 02:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN0nsaqbWOaB64hcHySc7xCceYk65OX6Wsh3hdrMJAZJsmK1TW/EC9rC7N9w2CQea66HqqpvkC4DhXL27MdRfUXhTcK8VBrYUl72Q/+n7gvTfvSafhUtAn92A1HfH90c71E1kEGWBLIMRrLXg+XMgnLh3zaGoYjB4T3QRxJhXfjxnJNrM894QPxHXKOY2BLIAt4RC+AomlrHitzROZtjUGOQ3D6r3eUUErvRwR66FlsFDhnfYOvZvZ8pILYbgXZAP4F/FMTRswWuuESxyh1AYcgg6BzZaYy66QWIZOqkKn89kitVadhSyTYIkaTiBw5ytvf2prlc9PSMvMi7CVCVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2i5PTzUSRg3h2BXDKegxhyxojtgmLTJOtd0Bge9bNWE=;
 b=K2J3Q2BFfDvwGKyzsK4MkQNIeJyJQErqIjc8v+fo9bps9SV8duVJPYXFxTKSnSkfQDR/fJ2CH7CJkTuCrI7Z0puDgas13MA9OAubUjyFEb3YHvfgPrd++gRVLgXpKJML5MKF9d4EDkb+g6dnuhAaQJxRDrAhgkVmG1Dg/sEvUZ4tc2VTDvnTdhxN3qky4YyMQTZDnPx4TQRZy86hjLdRLOmXU9c7YAi2ltwzQORgAKekdx/Bl/jrRAR02U9aonnJBduAWAtKrSO47qkn9du6zG0z9RK3o0ImgK78mH6UubAP1j20/7TyqN7mHOKpOmwO1GZuMv4/b2eJ/GQmLCS73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i5PTzUSRg3h2BXDKegxhyxojtgmLTJOtd0Bge9bNWE=;
 b=iq6RAZBNke7G3Ugce66oOt9Kzc97MFS2k4Oy/Ezk2ULy2dZ9GTlf4xaeCsV1lBSLkNNk3NcZCGUJnjcCirtYpVe0Hg3g8Zy1812pzt0m4Yny8sZXxTnPnD5pL15rPsyjHyIL2XX0AiBR/rppM8Fb+5mHuVhifKREnT/tUG6rB7A=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Thu, 9 Sep 2021 02:43:07 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 02:43:07 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>
Subject: RE: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
Thread-Topic: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
Thread-Index: AQHXpHZHU9itz+o/Z0SrCH1yaBZ0dquZrxWAgAAQcoCAAAEmAIAAFOiAgAAATvCAAAlVAIAAAleAgAAMTQCAACeZAIAAoFQAgABI+AA=
Date: Thu, 9 Sep 2021 02:43:06 +0000
Message-ID: <DM6PR12MB4250EC35F696D19098E9642AFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
 <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
 <4e6c0a19-0476-d8ca-c233-6f143cca511c@gmail.com>
 <CH0PR12MB5387C11CD331985AB96F0DCEF0D49@CH0PR12MB5387.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5387C11CD331985AB96F0DCEF0D49@CH0PR12MB5387.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T02:43:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51aefbfe-9dcf-4b27-e360-08d9733b8dfc
x-ms-traffictypediagnostic: DM5PR1201MB2488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB24884333815F6C1C89B41EF2FBD59@DM5PR1201MB2488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaVvmd4hy78GdmZfA0Zef0Nk3tC4fOojYMvUXYHFdk4GU5SC/WK8Ij7+K/vZQuCF/y4NRUoqy627IQq/28NBEBgpFVyXzAZ0teCyIhMMKB64S1Vs3wZlGPuleHJ9nhjb/h/e7RhXybaus5r9hBajVLtFGFJRZhkRCDP5kUwm1F6fAwoa/SbjVseyFjUjJxXHeau2LCcq7hEWHrrOP0g58pG0S0AZmaT6PQWY3CHagddCvm5EJjIXcJ3+oCxKCotZTEq6JX3EHogBNYWTEhKvKJwPfm8/vzgMUORUwAFuxGOZY6EpaESK4BgSEgbBSz8xudEOj9kwcNnvu+TXI4sh3gfcJhRTNWBslovlYO0eqTzFs8nwTGIpx3ylFa+VbBL2hU7ZEPItCIQauXNGU2ey+ZaPhiLm3kJbonfHJP/FJOoalDO8hFKXi8dSjtspKP6SxwiQV4X3rMelb6xFnT8F/ae58G83JcXqhc4OxfRQQAAZ7uvMSD3nOUICTAYBSINW+dRJB2fahKHCwy/gFkzonoij7x7jj5mydYkhI7hd+S0tSnEpa86VtYlDUy1jqD4G2tVuQvETxo+0tuk5T5zVVcHB3TlCC6I21S+soE1sGVq3mdfnAscjV47YkmC9SZHCU9mFbFbHODYWB/LeBgAxhACr7sCjxYmZbeKta9o9Fd0oshUnjlhbVkwLc/Mum7l9qS5xWqjKa6vImMYD1B5ZSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(53546011)(66574015)(8676002)(4326008)(86362001)(26005)(8936002)(110136005)(71200400001)(83380400001)(54906003)(316002)(52536014)(33656002)(76116006)(508600001)(2906002)(55016002)(66946007)(38100700002)(66556008)(66446008)(64756008)(6506007)(122000001)(186003)(7696005)(9686003)(66476007)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u30I6QFMqUZ4jIknqFLkR7sULnvrc5de/8Av2Tnba6/xqOkcKMqansEPIN?=
 =?iso-8859-1?Q?D5bVTGarsixcSD/hqvSASKFfpp+6i7F1dzDNYnzsjmFwyxuQOLI7gLADBS?=
 =?iso-8859-1?Q?CaGnIBh1RK0VwPUolRbGbA1UvD1wItxi8at1hRMUqhc4pj7s23LGs/J3bd?=
 =?iso-8859-1?Q?49ppubzibSR8qd3jil5WTmJmm2NQd3XAxsHBPY/RpCynf/EpCsVTE5hKRc?=
 =?iso-8859-1?Q?jgN1Vnhq98VKKD1u2i+xvPX2HZBUCwKY7ULxsU26EnmGfkLNMg77qO1EGG?=
 =?iso-8859-1?Q?yhg6hIh8llJEad8+u/NSFbDDFF1Q5Ze8IyZDhbjhiJ92oNSqPQwStC1/fG?=
 =?iso-8859-1?Q?5welV3MPS8HISPO7bo4qaYWpGLfR7e/iYMneeLGw4fYVp1LgbGVbOYeniv?=
 =?iso-8859-1?Q?oEv8O3EnpxjC++09eznhhJM/otFJtFwVsWV2o9ffQ0t4yxjFqyyQ7EuIhz?=
 =?iso-8859-1?Q?u9O3TtQAy4pD/YhDaajWRT6fL/+YO5vxf3KXRSEkMztYyTQiCfo/3+0K4S?=
 =?iso-8859-1?Q?WzgWJvaqJVA81adk19zAdKEA1c88/QWQtKkhjpwSW3NYgUc35SVqjSNHnD?=
 =?iso-8859-1?Q?s/x9iQkNONK1NqsoSVWkkyJDtMLh127D4GmKcqGh4OuKVzMod1tJkEj4sX?=
 =?iso-8859-1?Q?QJhwV0OcW5QpJGn4nue+4l9z/nZfxqn8K5HRBxhE6JablCihRVM+iM5y65?=
 =?iso-8859-1?Q?W+faNyJYFnB6/UhAupVWJvF0as5gg5rq2Id4YbZazbz247nC+4hGD7k9mg?=
 =?iso-8859-1?Q?6Tt2/R8tbZzEEBV+EXbl6bJAmBzVEDYxiR5JOEut+8dGFRIMXAy10LmHac?=
 =?iso-8859-1?Q?ij+Re81LeNEtUDC7Q2eUgjOJn+FpkCgIXn3cbZfnHPHNw4mzZ9se/P+BJe?=
 =?iso-8859-1?Q?WSrJ7VzI85htQDRqvUH73PC89OQceMVVT0+a3MdPziQArAfklnciomuQgr?=
 =?iso-8859-1?Q?q6DvBhmDWvWWCqYT/abu0CYTwAZQRxpBnz7zUnRic7MXVGOWoM7g5o1F9r?=
 =?iso-8859-1?Q?Bue67VoC3cNw6O+JAgbjF62fn567AmPodgk7BAUbW/FAxk15Pnk3WtqCYP?=
 =?iso-8859-1?Q?v47nQOPbDQbQB5+sRe0GILkXC+qBnxkAWRYAUiv0PVk2ftjzBsRJZQdO6B?=
 =?iso-8859-1?Q?LyEaVI/LHgbvKKACTyyJI2aZ2tel1tFgj+GyVqaP/jG0ehJL5TEMznYJjD?=
 =?iso-8859-1?Q?6w7SocMNqhSCOEXYUJdo8oYHTyn058UwfqT/0BbDIKid2yIbUG8T7eIFdm?=
 =?iso-8859-1?Q?7RQe7g46XLD85nOrfUvDReK7LJblxvf+hKZuvvBDtuiHr8WsrRhy1HMwoB?=
 =?iso-8859-1?Q?+5d4h/CgIpTWqfVTChPrwQKOcrukS5ulojPP4P7EiWi3fITQzUPihic1hl?=
 =?iso-8859-1?Q?vi21ls9FN9?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4250EC35F696D19098E9642AFBD59DM6PR12MB4250namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aefbfe-9dcf-4b27-e360-08d9733b8dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 02:43:07.0129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaQCbR045RmQZb1NPoywbdB4aSp5xnxp1QhgDhdYY7CQWqXsGWcrCQegkNyikPzZcysQ0NbynOmttve3dPnF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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

--_000_DM6PR12MB4250EC35F696D19098E9642AFBD59DM6PR12MB4250namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

So the final decision is rollback to scnprintf().
If we can define our own helper functions like sysfs_emit/sysfs_emit_at
but without page boundary aligned limitation to make life easier?

Regards,
Lang

From: Powell, Darren <Darren.Powell@amd.com>
Sent: Thursday, September 9, 2021 6:18 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Lazar, Lijo <Lijo=
.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings


[AMD Official Use Only]



________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Wednesday, September 8, 2021 8:43 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Yu, Lang <=
Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>; amd-gfx@lists.freedesktop.org<mai=
lto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org<mailto:am=
d-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Tian T=
ao <tiantao6@hisilicon.com<mailto:tiantao6@hisilicon.com>>; Powell, Darren =
<Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings

Am 08.09.21 um 12:22 schrieb Lazar, Lijo:
> On 9/8/2021 3:08 PM, Christian K=F6nig wrote:
>> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>>>> [AMD Official Use Only]
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
>>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>>>> To: Yu, Lang <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>; Christian K=
=F6nig
>>>>> <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leichtzumerken@gmail=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.De=
ucher@amd.com>>; Huang, Ray
>>>>> <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Tian Tao <tiantao6@his=
ilicon.com<mailto:tiantao6@hisilicon.com>>
>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>> warnings
>>>>>
>>>>>
>>>>>
>>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
>>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>>>>> To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoe=
nig.leichtzumerken@gmail.com>>; Yu, Lang
>>>>>>> <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>; amd-gfx@lists.freedeskto=
p.org<mailto:amd-gfx@lists.freedesktop.org>
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.=
Deucher@amd.com>>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Tian Tao <tiantao6@h=
isilicon.com<mailto:tiantao6@hisilicon.com>>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>>>> warnings
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/8/2021 12:07 PM, Christian K=F6nig wrote:
>>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>>>>>>>>> address. Make them happy!
>>>>>>>>>
>>>>>>>>> Warning Log:
>>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>>>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>>>>> [  492.654805] Call Trace:
>>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>>>>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>>>>> 492.658245] vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>>>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 492.660713]
>>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>>>>>>>>> dev_attr_show+0x1d/0x40
>>>>>>>>
>>>>>>>> Mhm, that at least partially doesn't looks like the right
>>>>>>>> approach to me.
>>>>>>>>
>>>>>>>> Why do we have string printing and sysfs code in the hardware
>>>>>>>> version specific backend in the first place?
>>>>>>>>
>>>>>>>
>>>>>>> This is a callback meant for printing ASIC specific information to
>>>>>>> sysfs node. The buffer passed in sysfs read is passed as it is
>>>>>>> to the callback API.
>>>>>>>
>>>>>>>> That stuff needs to be implemented for each hardware generation
>>>>>>>> and
>>>>>>>> is now cluttered with sysfs buffer offset calculations.
>>>>>>>>
>>>>>>>
>>>>>>> Looks like the warning happened because of this usage.
>>>>>>>
>>>>>>>                   size =3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_SCLK, buf);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_MCLK,
>>>>>>> buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_VDDC_CURVE, buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_RANGE,
>>>>>>> buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_CCLK,
>>>>>>> buf+size);
>>>>>>>
>>>>>>>
>>>>>> [Yu, Lang]
>>>>>> Yes. So it is fine we just fix the caller
>>>>>> amdgpu_get_pp_od_clk_voltage like
>>>>> following:
>>>>>>
>>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>>>         struct device_attribute *attr,
>>>>>>         char *buf)
>>>>>> {
>>>>>>     struct drm_device *ddev =3D dev_get_drvdata(dev);
>>>>>>     struct amdgpu_device *adev =3D drm_to_adev(ddev);
>>>>>>     ssize_t size, offset;
>>>>>>     int ret, i;
>>>>>>     char temp_buf[512];
>>>>>>     char clock_type[] =3D {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>>>>                          OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>>>>
>>>>>>     if (amdgpu_in_reset(adev))
>>>>>>         return -EPERM;
>>>>>>     if (adev->in_suspend && !adev->in_runpm)
>>>>>>         return -EPERM;
>>>>>>
>>>>>>     ret =3D pm_runtime_get_sync(ddev->dev);
>>>>>>     if (ret < 0) {
>>>>>>         pm_runtime_put_autosuspend(ddev->dev);
>>>>>>         return ret;
>>>>>>     }
>>>>>>
>>>>>>     offset =3D 0;
>>>>>>
>>>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>>>>         for (i =3D 0; i < ARRAY_SIZE(clock_type); i++) {
>>>>>>             size =3D amdgpu_dpm_print_clock_levels(adev,
>>>>> clock_type[i], buf);
>>>>>>             if (offset + size > PAGE_SIZE)
>>>>>>                 break;
>>>>>>             memcpy(temp_buf + offset, buf, size);
>>>>>>             offset +=3D size;
>>>>>>         }
>>>>>>         memcpy(buf, temp_buf, offset);
>>>>>>         size =3D offset;
>>>>>>     } else {
>>>>>>         size =3D sysfs_emit(buf, "\n");
>>>>>>     }
>>>>>>     pm_runtime_mark_last_busy(ddev->dev);
>>>>>>     pm_runtime_put_autosuspend(ddev->dev);
>>>>>>
>>>>>>     return size;
>>>>>> }
>>>>>>
>>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe
>>>>> another arg to
>>>>> pass offset along with buf?
>>>>>
>>>> [Yu, Lang]
>>>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>>>
>>> Though it's not a problem based on codeflow, static analysis tools
>>> might complain.
>>>
>>>> Or we just rollback to sprintf/snprintf.
>>>>
>>>
>>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took
>>> the effort to convert these, he may have some other ideas.
The changes I made were intended to simply replace snprintf with sysfs_emit=
 as per
linux/Documentation/filesystems/sysfs.rst:246,247
 -  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
    the value to be returned to user space.

I specifically tried not to change the design, but only as I didn't have
background in Power Management.

>>
>> This is not what I meant. See from the design point of view the
>> print_clock_levels() callback is the bad idea to begin with.
>>
>> What we should have instead is a callback which returns the clock as
>> a value which is then printed in the amdgpu_get_pp_od_clk_voltage()
>> function.
>>
>> This avoids passing around the buffer and remaining size everywhere
>> and also guarantees that the sysfs have unified printing over all
>> hardware generations.
>>
>
> The scenario is one node used for multiple parameters - OD_SCLK,
> OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with
> lots of nodes). On top of it, the parameters supported (for ex: CCLK
> is not valid on dGPUs),  the number of levels supported etc. vary
> across ASICs. There has to be multiple calls or the call needs to
> return multiple values for a single parameter (for ex: up to 4, 8 or
> 16 levels of GFXCLK depending on ASIC).

Well exactly that is questionable design for sysfs.

See the sysfs_emit() and sysfs_emit_at() functions are designed the way
they are because you should have only one value per file, which is then
printed at exactly one location.

Take a look at the documentation for sysfs for more details.

> I don't know the history of the callback, mostly it was considered
> more efficient to print it directly rather than fetch and print.
> Alex/Evan may know the details.

Yeah, somebody with a bit more background in power management needs to
take a closer look at this here. Just keep me looped in.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>

--_000_DM6PR12MB4250EC35F696D19098E9642AFBD59DM6PR12MB4250namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So the final decision is rollback to scnprintf().<o:=
p></o:p></p>
<p class=3D"MsoNormal">If we can define our own helper functions like sysfs=
_emit/sysfs_emit_at
<o:p></o:p></p>
<p class=3D"MsoNormal">but without page boundary aligned limitation to make=
 life easier?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Lang<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Powell, Darren &lt;Darren.Powell@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, September 9, 2021 6:18 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Laza=
r, Lijo &lt;Lijo.Lazar@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; amd-g=
fx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Tian Tao &lt;tiantao6@hisilicon.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnin=
gs<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 8, 2021 8:43 AM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;; Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@a=
md.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray=
.Huang@amd.com">Ray.Huang@amd.com</a>&gt;; Tian Tao &lt;<a href=3D"mailto:t=
iantao6@hisilicon.com">tiantao6@hisilicon.com</a>&gt;; Powell,
 Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darren.Powell@amd.com<=
/a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnin=
gs</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Am 08.09.21 um 12:22 schrieb Lazar, Lijo:<br>
&gt; On 9/8/2021 3:08 PM, Christian K=F6nig wrote:<br>
&gt;&gt; Am 08.09.21 um 11:29 schrieb Lazar, Lijo:<br>
&gt;&gt;&gt; On 9/8/2021 2:32 PM, Yu, Lang wrote:<br>
&gt;&gt;&gt;&gt; [AMD Official Use Only]<br>
&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd=
.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Sent: Wednesday, September 8, 2021 4:55 PM<br>
&gt;&gt;&gt;&gt;&gt; To: Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">La=
ng.Yu@amd.com</a>&gt;; Christian K=F6nig<br>
&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com=
">ckoenig.leichtzumerken@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt;&gt;&gt;&gt;&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Huang, Ray<br>
&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd=
.com</a>&gt;; Tian Tao &lt;<a href=3D"mailto:tiantao6@hisilicon.com">tianta=
o6@hisilicon.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_=
emit_at <br>
&gt;&gt;&gt;&gt;&gt; warnings<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 9/8/2021 1:14 PM, Yu, Lang wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; [AMD Official Use Only]<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.L=
azar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent: Wednesday, September 8, 2021 3:36 PM<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; To: Christian K=F6nig &lt;<a href=3D"mailto:ck=
oenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;; Y=
u, Lang<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu=
@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:A=
lexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Huang, Ray<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.H=
uang@amd.com</a>&gt;; Tian Tao &lt;<a href=3D"mailto:tiantao6@hisilicon.com=
">tiantao6@hisilicon.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emi=
t/sysfs_emit_at<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; warnings<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 9/8/2021 12:07 PM, Christian K=F6nig wrote:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 08.09.21 um 07:56 schrieb Lang Yu:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sysfs_emit and sysfs_emit_at requrie a=
 page boundary aligned buf<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; address. Make them happy!<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Warning Log:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 492.545174] invalid sysfs_emit=
_at: buf:00000000f19bdfde at:0 [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.546416] WARNING: CPU: 7 PID: 1304 =
at fs/sysfs/file.c:765<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sysfs_emit_at+0x4a/0xa0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 492.654805] Call Trace:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 492.655353]&nbsp; ? smu_cmn_ge=
t_metrics_table+0x40/0x50 [amdgpu] [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.656780]&nbsp; vangogh_print_clk_le=
vels+0x369/0x410 [amdgpu] [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.658245] vangogh_common_print_clk_l=
evels+0x77/0x80 [amdgpu] [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.659733]&nbsp; ? preempt_schedule_c=
ommon+0x18/0x30 [ 492.660713]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; smu_print_ppclk_levels+0x65/0x90 [amdg=
pu] [ 492.662107]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_get_pp_od_clk_voltage+0x13d/0x1=
90 [amdgpu] [ 492.663620]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dev_attr_show+0x1d/0x40<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Mhm, that at least partially doesn't looks=
 like the right <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; approach to me.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Why do we have string printing and sysfs c=
ode in the hardware<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; version specific backend in the first plac=
e?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is a callback meant for printing ASIC spe=
cific information to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; sysfs node. The buffer passed in sysfs read is=
 passed as it is <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; to the callback API.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That stuff needs to be implemented for eac=
h hardware generation <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is now cluttered with sysfs buffer offset =
calculations.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Looks like the warning happened because of thi=
s usage.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dp=
m_print_clock_levels(adev, <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_SCLK, buf);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev, <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_MCLK,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_VDDC_CURVE, buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_VDDGFX_OFFSET, buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_RANGE,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev, <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_CCLK,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; [Yu, Lang]<br>
&gt;&gt;&gt;&gt;&gt;&gt; Yes. So it is fine we just fix the caller <br>
&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_get_pp_od_clk_voltage like<br>
&gt;&gt;&gt;&gt;&gt; following:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; static ssize_t amdgpu_get_pp_od_clk_voltage(struct=
 device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
device_attribute *attr,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *b=
uf)<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;ssize_t size, offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;int ret, i;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;char temp_buf[512];<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;char clock_type[] =3D {OD_=
SCLK, OD_MCLK, OD_VDDC_CURVE,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (amdgpu_in_reset(adev))=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EPERM;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (adev-&gt;in_suspend &a=
mp;&amp; !adev-&gt;in_runpm)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EPERM;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runt=
ime_put_autosuspend(ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;}<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;offset =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (adev-&gt;powerplay.pp_=
funcs-&gt;print_clock_levels) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
=3D 0; i &lt; ARRAY_SIZE(clock_type); i++) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt; clock_type[i], buf);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (offset + size &gt; PAGE_SIZE)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; memcpy(temp_buf + offset, buf, size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; offset +=3D size;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
buf, temp_buf, offset);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;} else {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sysfs_emit(buf, &quot;\n&quot;);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;}<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;return size;<br>
&gt;&gt;&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Prefer to avoid any extra stack or heap usage for buff=
er. Maybe <br>
&gt;&gt;&gt;&gt;&gt; another arg to<br>
&gt;&gt;&gt;&gt;&gt; pass offset along with buf?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [Yu, Lang]<br>
&gt;&gt;&gt;&gt; Actually, the buf address contains the offset(offset_in_pa=
ge(buf)) .<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Though it's not a problem based on codeflow, static analysis t=
ools <br>
&gt;&gt;&gt; might complain.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Or we just rollback to sprintf/snprintf.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; snprintf with (PAGE_SIZE-size) may be simpler. I think Darren =
took <br>
&gt;&gt;&gt; the effort to convert these, he may have some other ideas.<br>
The changes I made were intended to simply replace snprintf with sysfs_emit=
 as per&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">linux/Documentation/filesystems/sysfs.rst:246,247 <o=
:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;- &nbsp;show() should only use sysfs_emit() or=
 sysfs_emit_at() when formatting<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">&nbsp; &nbsp; the value to be returned to user space=
.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I specifically tried not to change the design, but o=
nly as I didn't have&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">background in Power Management.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt;&gt;<br>
&gt;&gt; This is not what I meant. See from the design point of view the <b=
r>
&gt;&gt; print_clock_levels() callback is the bad idea to begin with.<br>
&gt;&gt;<br>
&gt;&gt; What we should have instead is a callback which returns the clock =
as <br>
&gt;&gt; a value which is then printed in the amdgpu_get_pp_od_clk_voltage(=
) <br>
&gt;&gt; function.<br>
&gt;&gt;<br>
&gt;&gt; This avoids passing around the buffer and remaining size everywher=
e <br>
&gt;&gt; and also guarantees that the sysfs have unified printing over all =
<br>
&gt;&gt; hardware generations.<br>
&gt;&gt;<br>
&gt;<br>
&gt; The scenario is one node used for multiple parameters - OD_SCLK, <br>
&gt; OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with <=
br>
&gt; lots of nodes). On top of it, the parameters supported (for ex: CCLK <=
br>
&gt; is not valid on dGPUs),&nbsp; the number of levels supported etc. vary=
 <br>
&gt; across ASICs. There has to be multiple calls or the call needs to <br>
&gt; return multiple values for a single parameter (for ex: up to 4, 8 or <=
br>
&gt; 16 levels of GFXCLK depending on ASIC).<br>
<br>
Well exactly that is questionable design for sysfs.<br>
<br>
See the sysfs_emit() and sysfs_emit_at() functions are designed the way <br=
>
they are because you should have only one value per file, which is then <br=
>
printed at exactly one location.<br>
<br>
Take a look at the documentation for sysfs for more details.<br>
<br>
&gt; I don't know the history of the callback, mostly it was considered <br=
>
&gt; more efficient to print it directly rather than fetch and print. <br>
&gt; Alex/Evan may know the details.<br>
<br>
Yeah, somebody with a bit more background in power management needs to <br>
take a closer look at this here. Just keep me looped in.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4250EC35F696D19098E9642AFBD59DM6PR12MB4250namp_--
