Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B3EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 04:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E27010E185;
	Wed, 13 Dec 2023 04:07:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C17910E185
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 04:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2wU0X3hMwduq4uelsmjf9gtcKPmY3aMk1EK5hC15mAWL/WU78dphDW9CLGt5ygW0s0y/K+hSgaNSCy5XjiGFkzEQ5g4gPa093duaKqmuhgvkacqTBufDwKoz6c9rgdebmN4fwWIPx6hkd+wab4lqc3bJOiUFUvKAGGmg4/0Z7KDz73o+8KMvNPt5fkKstRncvCQJLdMUKZG3FfPq7jmIvyofsYzNvfNdwxUyYKJnesFzNS0S9/U1NUYJmqczUz1n0cQrQA7MMl6QrHxwysyRjrikTxUUA8q0MQb42SZBk6yH5ioYIMJ4PCbBcGXUrzk6N9KbA5OHuGg+AyL4gv6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfSd+2Hn6zX6sCU6kZr3NX/fuUrwLhbudlb7oqMLLxk=;
 b=hPYQHCsL7eoledwILlBV+ZSndSazRzmz484iM1kGUm5mqQnIIC6MqzBgC07jY5lQBR3oiHrfTtMLunKMydc0nChBsGbPfc2x1jtbbDXgggVeNBI0AqyKhGIVSL1uwYtGpyMtuabKfG3TudeEZQpxicf+NHH0WK8HEZx1oES7ZSUnkjFKDZTzbP8mafGAP+BJwkUkl3QoHayOcPrKdUw8ZJDgvYHmdrKwFKJwPWfuqcGSxNxxXlRcHxgzrEJza/VMO6GBmn+IlKi9YfoLr59gSDNX0RbgDKxzbp4ju6geogGSBIb/TVsA4Oh5mCKSdA/mUcLkhDNEIbKEYREpZ8BLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfSd+2Hn6zX6sCU6kZr3NX/fuUrwLhbudlb7oqMLLxk=;
 b=DMi8h323Q7Spy3scISQK2kZrYwYO3z+Sav23MeY3ih+k430odAVcFgWuW123EikWnkGzt5JZonu1SYlaTt0Ug63ImKpBL/1KsJYoyhzIIEBD/EH2/M5m8KzNzhyI8Mc34S6/wM3k0IMKYLiHdsujqs801iSbOZSN9mKohj0/O+8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 04:07:40 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::28b7:3ee9:2c4b:6ae]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::28b7:3ee9:2c4b:6ae%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 04:07:40 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: fix mes set shader debugger process management
Thread-Topic: [PATCH] drm/amdkfd: fix mes set shader debugger process
 management
Thread-Index: AQHaLHdTu1pi6XN9kEyuJkcz/NdpHLCl7iQAgAAzU6CAAAsuAIAAAaNQgAACkYCAAAkqcIAADNaAgAAPVnCAABWggIAAKykd
Date: Wed, 13 Dec 2023 04:07:40 +0000
Message-ID: <CH0PR12MB5372A1E3E4C24B4F2C3C13BAF48DA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20231211211612.3109-1-Jonathan.Kim@amd.com>
 <c4fc2b14-07b1-4b27-b460-166dcb343d74@amd.com>
 <CH0PR12MB5372AA024278ED7F7F078EEFF48EA@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CY8PR12MB7435E109E255C480398C0FE4858EA@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CH0PR12MB5372602539AA4398F2ED5822F48EA@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CY8PR12MB74359C2CC97BEEC4DF059B3C858EA@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CH0PR12MB53724D1E4C95E787790DF22BF48EA@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CY8PR12MB7435E7214AF1FF85B32D20B1858EA@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CH0PR12MB5372DEE37C77FD4CA22B8B2FF48DA@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CY8PR12MB7435882A1367094CB9150448858DA@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435882A1367094CB9150448858DA@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-12T21:31:14.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|MN0PR12MB6245:EE_
x-ms-office365-filtering-correlation-id: 095da8d0-0bea-4529-c7a6-08dbfb910c80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41YV2gKYR1TfmcJl/evhoPwJF6X3oEizv3GUMWYA6vgoZsSzj7l9dKzbL1SXlYcTL3pdRAyhx0e0mCzmwmaF5wa7T9A/my+uguDfViwYFz62XStrGFXuoMI0xdDa61+ZLGbKRtsMQLIg/gbC9iSUqj+AiMA7Udu/nM18pYk/aqRiHIa1pb+2GB/CndCPR8CWXEzh7Ari92FfVtTVRvL2QNI3ewUHJ6ZI6lesa5yL5WA1oa0+VivaO6v7kcZE9Sgm455CZVTuK0KT1AStX8+I80Xe8Zu38ZRUSA+YS6/Gl8K5Hh984EdMIAicwO9UIu9oF5ACMz7e5kN+1wAcBhMWp63cgsWu5P4+yKvtZp50SOoafH6rmc/12AapK7UpIdqxsn5MZFbz+BfQ9i9mDAzZMX/Qmybbs+vXHY5QO90ikMTwfY0Eto3SZaApAVpTQXQu8qE6OcumWBGuhJRZ5H8288tDAj8GYpdBA5vu5FSqdz632n9KWQSALLwACrpQjyn+eleQ2N/X87EuuhrTZmv3ahARh2ij3pfCqOir1sTzPGl/jZEry1PyGUZvQHso5hdX8cIBPWRNVcRvn7cXJ6RIe9y+RDm35DW/sAxCJ2eWKVY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4001150100001)(2906002)(5660300002)(52536014)(30864003)(4326008)(8936002)(8676002)(66476007)(64756008)(316002)(66446008)(110136005)(66946007)(76116006)(66556008)(54906003)(55016003)(41300700001)(7696005)(6506007)(45080400002)(478600001)(71200400001)(53546011)(9686003)(26005)(83380400001)(122000001)(38100700002)(38070700009)(33656002)(166002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tz4t2Ha4MYSnNvN+8b/N14YbPyu1GBRKk8qnjEPAdM7TKJPPNxktelAtxfW0?=
 =?us-ascii?Q?bi3XuJ5Bzx1yrPW94nYEfdMGUG0NeZ/9VEcjQxT3gKZklTl8v1YlGE+B3pdb?=
 =?us-ascii?Q?/wsdav5Xs3+7D+YguwpAEWEySXb69uoc1Lq3DzR1w+17PDCWXemgoDPY3u6k?=
 =?us-ascii?Q?H6kOAJd5WAAI63Kow3gOlX+uHuy4jc05ASrzAT5/C7eB4wR2czX+H16szGn2?=
 =?us-ascii?Q?0tZFbBMiHU4eWVQgClKe08cEdRt6oBkaVtyYe8tZu5x4nZhFUEyunXNNTQYj?=
 =?us-ascii?Q?sfPtpDxRK6y7y/44a3hJ9mYgHFTmsHIeTaR+7kvb0hTWhmLhIVy0NuF+dHUM?=
 =?us-ascii?Q?A748GZU0MUZhakv1esO7BCFWsagj88vlP4Gpvb9bJpX+RRJv5KUZv3BlZO8d?=
 =?us-ascii?Q?g+zugzABJFk3TXFSA3MdHwURaWWnuOTXQ0x7gvATi58HSTEGTGVG7oYV35w5?=
 =?us-ascii?Q?t8I+vHjn5BgHRbeHLH8XGxc3mkOBuTn31IpXjzQm9FcBeg2+H7BCRN+RVIXV?=
 =?us-ascii?Q?kJXxU6cTI3T9MW7W4jd0tQ0weFTo0uhtKLF4Dd9J2JkkpbFsLM98D7Q0n1iT?=
 =?us-ascii?Q?zBG7EKJG3/LBuVGFNuy1Givh1KfsOf7AxxWrfl9RSKlJygPFzRi56F2yFMio?=
 =?us-ascii?Q?zpfKaLVZ+BpULDdrFlXM5wakyl1/CjmCRCaWAXvidCQuqdV8cDJkUFu+GNBK?=
 =?us-ascii?Q?K+5Uu0E6ZUuQOLg8OFpqiiajKQAM/bQLChzpOiywSrqEKCm3q1btF+KJ1+CI?=
 =?us-ascii?Q?2GGdO8lojFJyteXrR7bKqUtcZyz9ZDOH0Vjrpvd+SEsn3xy7dj2dI30a4xfJ?=
 =?us-ascii?Q?Pv67ddbyR7POCL8fsUxM+xWI+foFDUhkgOKbs7mQhswg4T/31kaaIYcgHzf5?=
 =?us-ascii?Q?enjtEhoqcP+vjJG9eyr91LmvECWmxqm8TA2qgelzoQKkk3EFXfKe2OZtNGh/?=
 =?us-ascii?Q?3quVQcN9aRprXAYN91zbcnBuiQ1+Lq8I1ruuBJ9ArTfeQiHkYZUp18IOlp/R?=
 =?us-ascii?Q?QeW3A2n1ZSmtwKW+J//JoS02r/V0wsKFAyrlx2PJFK/zxasvroY+MVPPghS2?=
 =?us-ascii?Q?Q+IS2c0QiTyvyCjEZuguR+kXt3Um8L921RW8RXJhB7kcxHDSAFrlCLtHnpyc?=
 =?us-ascii?Q?cnt+J82IZ0BEA9ohQlW3VNjHvK/DmZsecVfkSahdzDZY0AlS5VZb4POAvMsm?=
 =?us-ascii?Q?VpoEz4vBGlEjIYqtXq9rZt5BAyUQ82d6rEoV/poA7VH7hz4JxpBFUCPCvgRE?=
 =?us-ascii?Q?/QgFKjSA2bLzK5Wogvel03nDUXp1Umd5E87o1gclewYOoki5pu/RjP3Z6VO6?=
 =?us-ascii?Q?KGpX39JTHZ8XBVeQ2Gykaj442+ioMIpvrNZCe1kX+XyKqgkYUu3y+Lmu2U9u?=
 =?us-ascii?Q?QPeXDqKBxorSC+6WpADruI4BgT6C5+0XbM1hMRnbwvM4lb5ZwT32jXxVkY/+?=
 =?us-ascii?Q?UDzLE+DKQSoNxYr9+tNlQhRt91tth2IDyaz4V2+PmcSijINiAqX1V3/AKHHh?=
 =?us-ascii?Q?xl8lYmf4ctM5iZUnbpeYHeNdXW1rWCpGk6IE8K2VWAf/jk1hWl2pTyHpxZlq?=
 =?us-ascii?Q?aWU7Ppq09meguJrwCF+uSu3dzxz3fIpzR/MPqgIM?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5372A1E3E4C24B4F2C3C13BAF48DACH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095da8d0-0bea-4529-c7a6-08dbfb910c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 04:07:40.1615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFHDe1D3CT7wJ3F7nNZIJ7hiyk5UMi3t8a8u5C8QYvrUD5Z4g/O+nUMhlFKD8SKcaCMdz5CZ4RCnUI6eL8CqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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
Cc: "Wong, Alice" <Shiwei.Wong@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5372A1E3E4C24B4F2C3C13BAF48DACH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

You try to add one new interface to inform mes about the context flush afte=
r driver side finish process termination , from my understanding, mes alrea=
dy know the process context need to be purged after all the related queues =
been removed even without this notification. What do you expect mes to do a=
bout this context flush flag ? Mes should block this process context for ne=
xt set_sched command? Mes can achieve  this by ignore the set_sched command=
 with trap disable parameter on an invalid process context .

Shaoyun.liu

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Tuesday, December 12, 2023 8:19:09 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Huang, JinHuiEric <JinHuiEric.Huang=
@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.=
com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process manage=
ment

[Public]

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Tuesday, December 12, 2023 7:08 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process
> management
>
> [Public]
>
> I see,  so the  problem is after process context , set_shader been  calle=
d with
> disable parameter,  do you know the  reason why  MES re-added the
> process context into the  list ?

Because MES has no idea what disable means.

All it knows is that without the flush flag, set_shader should update the n=
ecessary per-VMID (process) registers as requested by the driver, which req=
uires persistent per-process HW settings so that potential future waves can=
 inherit those settings i.e. ADD_QUEUE.skip_process_ctx_clear is set (why A=
DD_QUEUE auto clears the process context otherwise is another long story, b=
asically an unsolvable MES cache bug problem).

Common use case example:
add_queue -> set_shader call either transiently stalls the SPI per-VMID or =
transiently dequeues the HWS per-VMID depending on the request settings -> =
fulfils the per-VMID register write updates -> resumes process queues so th=
at potential waves on those queues inherit new debug settings.

You can't do this kind of operation at the queue level alone.

The problem that this patch solves (along with the MES FW upgrade) is an un=
fortunate quirk of having to operate between process (debug requests) and q=
ueue space (non-debug requests).
Old HWS used to operate at the per-process level via MAP_PROCESS so it was =
a lot easier to balance debug versus non-debug requests back then (but it w=
as also lot less efficient performance wise).

Jon

>
> Shaoyun.liu
>
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Tuesday, December 12, 2023 6:07 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process
> management
>
> [Public]
>
> > -----Original Message-----
> > From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> > Sent: Tuesday, December 12, 2023 5:44 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> > <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> > <Harish.Kasiviswanathan@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process
> > management
> >
> > [Public]
> >
> > Do you mean SET_SHADER_DEBUGER can  be called before ADD_QUEUE ?
> I
> > think  even in that  situation MES should still be able to handle it
> > as long as MES already  remove the process context from its list , MES
> > will treat the process context as a new item. I still don't understand =
why
> MES haven't
> > purged the  process context from the list after process termination .  =
 Will
> > debug queue itself  also use the add/remove queue interface  and  is
> > it possible the debug queue itself from the  old process  still not be
> > removed ?
>
> SET_SHADER_DEBUGGER can be called independently from ADD_QUEUE.
> The process list is updated on either on SET_SHADER_DEBUGGER or
> ADD_QUEUE.
> e.g. runtime_enable (set_shader) -> add_queue -> remove_queue (list
> purged) -> runtime_disable (set_shader process re-added) -> process
> termination (stale list) or debug attach (set_shader) -> add_queue ->
> remove_queue (list purged) -> debug detach (set_shader process re-added) =
-
> >process termination (stale list)
>
> MES has no idea what process termination means.  The new flag is a proxy
> for this.
> There are reasons for process settings to take place prior to queue add
> (debugger, gfx11 cwsr workaround, core dump etc need this).
>
> I'm not sure what kernel/debug queues have to do with this.
> By that argument, the list should be purged.
>
> Jon
>
> >
> > Shaoyun.liu
> >
> > -----Original Message-----
> > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Sent: Tuesday, December 12, 2023 4:48 PM
> > To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Huang, JinHuiEric
> > <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> > <Harish.Kasiviswanathan@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process
> > management
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> > > Sent: Tuesday, December 12, 2023 4:45 PM
> > > To: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> > > <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> > > <Harish.Kasiviswanathan@amd.com>
> > > Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process
> > > management
> > >
> > > [Public]
> > >
> > > Shouldn't the driver side  remove all the remaining  queues for the
> > > process during  process termination ?  If all the  queues been
> > > removed for the process ,  MES should purge the  process context
> > > automatically , otherwise it's bug inside MES .
> >
> > That's only if there were queues added to begin with.
> >
> > Jon
> >
> > >
> > > Regard
> > > Sshaoyun.liu
> > >
> > > -----Original Message-----
> > > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > > Sent: Tuesday, December 12, 2023 4:33 PM
> > > To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Huang, JinHuiEric
> > > <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> > > <Harish.Kasiviswanathan@amd.com>
> > > Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process
> > > management
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> > > > Sent: Tuesday, December 12, 2023 4:00 PM
> > > > To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kim, Jonathan
> > > > <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> > > > Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> > > > <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> > > > <Harish.Kasiviswanathan@amd.com>
> > > > Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger
> > > > process management
> > > >
> > > > [AMD Official Use Only - General]
> > > >
> > > > Does this requires the  new MES FW for this process_ctx_flush
> > > > requirement ?  Can driver side add logic to guaranty when  call
> > > > SET_SHADER_DEBUGGER, the process address  is always valid ?
> > >
> > > Call to flush on old fw is a NOP so it's harmless in that case.
> > > Full solution will still require a new MES version as this is a
> > > workaround on corner cases and not a new feature i.e. we can't stop
> > > ROCm from running on old fw.
> > > The process address is always valid from the driver side.  It's the
> > > MES side of things that gets stale as mentioned in the description
> > > (passed value to MES is reused with new BO but MES doesn't refresh).
> > > i.e. MES auto refreshes it's process list assuming process queues
> > > were all drained but driver can't guarantee that
> SET_SHADER_DEBUGGER
> > (which
> > > adds to MES's process list) will get called after queues get added
> > > (in fact it's a requirements that it can be called at any time).
> > > We can attempt to defer calls these calls in the KFD, considering all
> cases.
> > > But that would be a large shift in debugger/runtime_enable/KFD code,
> > > which is already complicated and could get buggy plus it would not
> > > be intuitive at all as to why we're doing this.
> > > I think a single flag set to flush MES on process termination is a
> > > simpler compromise that shows the limitation in a more obvious way.
> > >
> > > Thanks,
> > >
> > > Jon
> > >
> > >
> > > >
> > > > Regards
> > > > Shaoyun.liu
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Eric Huang
> > > > Sent: Tuesday, December 12, 2023 12:49 PM
> > > > To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> > > > gfx@lists.freedesktop.org
> > > > Cc: Wong, Alice <Shiwei.Wong@amd.com>; Kuehling, Felix
> > > > <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> > > > <Harish.Kasiviswanathan@amd.com>
> > > > Subject: Re: [PATCH] drm/amdkfd: fix mes set shader debugger
> > > > process management
> > > >
> > > >
> > > > On 2023-12-11 16:16, Jonathan Kim wrote:
> > > > > MES provides the driver a call to explicitly flush stale process
> > > > > memory within the MES to avoid a race condition that results in
> > > > > a fatal memory violation.
> > > > >
> > > > > When SET_SHADER_DEBUGGER is called, the driver passes a memory
> > > > address
> > > > > that represents a process context address MES uses to keep track
> > > > > of future per-process calls.
> > > > >
> > > > > Normally, MES will purge its process context list when the last
> > > > > queue has been removed.  The driver, however, can call
> > > > > SET_SHADER_DEBUGGER regardless of whether a queue has been
> > added
> > > or not.
> > > > >
> > > > > If SET_SHADER_DEBUGGER has been called with no queues as the
> > > > > last call prior to process termination, the passed process
> > > > > context address will still reside within MES.
> > > > >
> > > > > On a new process call to SET_SHADER_DEBUGGER, the driver may
> end
> > > up
> > > > > passing an identical process context address value (based on
> > > > > per-process gpu memory address) to MES but is now pointing to a
> > > > > new allocated buffer object during KFD process creation.  Since
> > > > > the MES is unaware of this, access of the passed address points
> > > > > to the stale object within MES and triggers a fatal memory violat=
ion.
> > > > >
> > > > > The solution is for KFD to explicitly flush the process context
> > > > > address from MES on process termination.
> > > > >
> > > > > Note that the flush call and the MES debugger calls use the same
> > > > > MES interface but are separated as KFD calls to avoid
> > > > > conflicting with each other.
> > > > >
> > > > > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > > > > Tested-by: Alice Wong <shiwei.wong@amd.com>
> > > > Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
> > > > > ---
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 31
> > > > +++++++++++++++++++
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 10 +++---
> > > > >   .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
> > > > >   drivers/gpu/drm/amd/include/mes_v11_api_def.h |  3 +-
> > > > >   4 files changed, 40 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > > index e544b823abf6..e98de23250dc 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > > @@ -916,6 +916,11 @@ int
> > amdgpu_mes_set_shader_debugger(struct
> > > > amdgpu_device *adev,
> > > > >       op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
> > > > >       op_input.set_shader_debugger.process_context_addr =3D
> > > > process_context_addr;
> > > > >       op_input.set_shader_debugger.flags.u32all =3D flags;
> > > > > +
> > > > > +     /* use amdgpu mes_flush_shader_debugger instead */
> > > > > +     if (op_input.set_shader_debugger.flags.process_ctx_flush)
> > > > > +             return -EINVAL;
> > > > > +
> > > > >       op_input.set_shader_debugger.spi_gdbg_per_vmid_cntl =3D
> > > > spi_gdbg_per_vmid_cntl;
> > > > >       memcpy(op_input.set_shader_debugger.tcp_watch_cntl,
> > > > tcp_watch_cntl,
> > > > >
> > > > > sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
> > > > > @@ -935,6 +940,32 @@ int
> > amdgpu_mes_set_shader_debugger(struct
> > > > amdgpu_device *adev,
> > > > >       return r;
> > > > >   }
> > > > >
> > > > > +int amdgpu_mes_flush_shader_debugger(struct amdgpu_device
> > *adev,
> > > > > +                                  uint64_t process_context_addr)=
 {
> > > > > +     struct mes_misc_op_input op_input =3D {0};
> > > > > +     int r;
> > > > > +
> > > > > +     if (!adev->mes.funcs->misc_op) {
> > > > > +             DRM_ERROR("mes flush shader debugger is not
> > supported!\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
> > > > > +     op_input.set_shader_debugger.process_context_addr =3D
> > > > process_context_addr;
> > > > > +     op_input.set_shader_debugger.flags.process_ctx_flush =3D
> > > > > + true;
> > > > > +
> > > > > +     amdgpu_mes_lock(&adev->mes);
> > > > > +
> > > > > +     r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > > > > +     if (r)
> > > > > +             DRM_ERROR("failed to set_shader_debugger\n");
> > > > > +
> > > > > +     amdgpu_mes_unlock(&adev->mes);
> > > > > +
> > > > > +     return r;
> > > > > +}
> > > > > +
> > > > >   static void
> > > > >   amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
> > > > >                              struct amdgpu_ring *ring, diff
> > > > > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > > > index 894b9b133000..7d4f93fea937 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > > > @@ -296,9 +296,10 @@ struct mes_misc_op_input {
> > > > >                       uint64_t process_context_addr;
> > > > >                       union {
> > > > >                               struct {
> > > > > -                                     uint64_t single_memop : 1;
> > > > > -                                     uint64_t single_alu_op : 1;
> > > > > -                                     uint64_t reserved: 30;
> > > > > +                                     uint32_t single_memop : 1;
> > > > > +                                     uint32_t single_alu_op : 1;
> > > > > +                                     uint32_t reserved: 29;
> > > > > +                                     uint32_t process_ctx_flush:
> > > > > + 1;
> > > > >                               };
> > > > >                               uint32_t u32all;
> > > > >                       } flags;
> > > > > @@ -374,7 +375,8 @@ int
> amdgpu_mes_set_shader_debugger(struct
> > > > amdgpu_device *adev,
> > > > >                               const uint32_t *tcp_watch_cntl,
> > > > >                               uint32_t flags,
> > > > >                               bool trap_en);
> > > > > -
> > > > > +int amdgpu_mes_flush_shader_debugger(struct amdgpu_device
> > *adev,
> > > > > +                             uint64_t process_context_addr);
> > > > >   int amdgpu_mes_add_ring(struct amdgpu_device *adev, int
> gang_id,
> > > > >                       int queue_type, int idx,
> > > > >                       struct amdgpu_mes_ctx_data *ctx_data, diff
> > > > > --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > > > > b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > > > > index 77f493262e05..8e55e78fce4e 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > > > > @@ -87,6 +87,7 @@ void kfd_process_dequeue_from_device(struct
> > > > kfd_process_device *pdd)
> > > > >               return;
> > > > >
> > > > >       dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> > > > > +     amdgpu_mes_flush_shader_debugger(dev->adev, pdd-
> > > > >proc_ctx_gpu_addr);
> > > > >       pdd->already_dequeued =3D true;
> > > > >   }
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> > > > > b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> > > > > index 1fbfd1aa987e..ec5b9ab67c5e 100644
> > > > > --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> > > > > +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> > > > > @@ -572,7 +572,8 @@ struct SET_SHADER_DEBUGGER {
> > > > >               struct {
> > > > >                       uint32_t single_memop : 1;  /*
> > > > > SQ_DEBUG.single_memop
> > > */
> > > > >                       uint32_t single_alu_op : 1; /* SQ_DEBUG.sin=
gle_alu_op
> */
> > > > > -                     uint32_t reserved : 30;
> > > > > +                     uint32_t reserved : 29;
> > > > > +                     uint32_t process_ctx_flush : 1;
> > > > >               };
> > > > >               uint32_t u32all;
> > > > >       } flags;
> > > >
> > >
> > >
> >
> >
>
>


--_000_CH0PR12MB5372A1E3E4C24B4F2C3C13BAF48DACH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">You try to add one new interface to inform mes about the c=
ontext flush after driver side finish process termination , from my underst=
anding, mes already know the process context need to be purged after all th=
e related queues been removed even
 without this notification. What do you expect mes to do about this context=
 flush flag ? Mes should block this process context for next set_sched comm=
and? Mes can achieve &nbsp;this by ignore the set_sched command with trap d=
isable parameter on an invalid process
 context .</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Shaoyun.liu</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kim, Jonathan &lt;Jon=
athan.Kim@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 12, 2023 8:19:09 PM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Huang, JinHuiEric &lt;=
JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
<b>Cc:</b> Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix &lt;Fel=
ix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan=
@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdkfd: fix mes set shader debugger process=
 management</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
&gt; Sent: Tuesday, December 12, 2023 7:08 PM<br>
&gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; Huang, JinHuiEric<br>
&gt; &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix<br>
&gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish<br>
&gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process<b=
r>
&gt; management<br>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; I see,&nbsp; so the&nbsp; problem is after process context , set_shade=
r been&nbsp; called with<br>
&gt; disable parameter,&nbsp; do you know the&nbsp; reason why&nbsp; MES re=
-added the<br>
&gt; process context into the&nbsp; list ?<br>
<br>
Because MES has no idea what disable means.<br>
<br>
All it knows is that without the flush flag, set_shader should update the n=
ecessary per-VMID (process) registers as requested by the driver, which req=
uires persistent per-process HW settings so that potential future waves can=
 inherit those settings i.e. ADD_QUEUE.skip_process_ctx_clear
 is set (why ADD_QUEUE auto clears the process context otherwise is another=
 long story, basically an unsolvable MES cache bug problem).<br>
<br>
Common use case example:<br>
add_queue -&gt; set_shader call either transiently stalls the SPI per-VMID =
or transiently dequeues the HWS per-VMID depending on the request settings =
-&gt; fulfils the per-VMID register write updates -&gt; resumes process que=
ues so that potential waves on those queues
 inherit new debug settings.<br>
<br>
You can't do this kind of operation at the queue level alone.<br>
<br>
The problem that this patch solves (along with the MES FW upgrade) is an un=
fortunate quirk of having to operate between process (debug requests) and q=
ueue space (non-debug requests).<br>
Old HWS used to operate at the per-process level via MAP_PROCESS so it was =
a lot easier to balance debug versus non-debug requests back then (but it w=
as also lot less efficient performance wise).<br>
<br>
Jon<br>
<br>
&gt;<br>
&gt; Shaoyun.liu<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;<br>
&gt; Sent: Tuesday, December 12, 2023 6:07 PM<br>
&gt; To: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Huang, JinHuiEric<br>
&gt; &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix<br>
&gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish<br>
&gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger process<b=
r>
&gt; management<br>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
&gt; &gt; Sent: Tuesday, December 12, 2023 5:44 PM<br>
&gt; &gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; Huang, JinHuiEric=
<br>
&gt; &gt; &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org<b=
r>
&gt; &gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix<br>
&gt; &gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish<br>
&gt; &gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; &gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger proc=
ess<br>
&gt; &gt; management<br>
&gt; &gt;<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt; Do you mean SET_SHADER_DEBUGER can&nbsp; be called before ADD_QUE=
UE ?<br>
&gt; I<br>
&gt; &gt; think&nbsp; even in that&nbsp; situation MES should still be able=
 to handle it<br>
&gt; &gt; as long as MES already&nbsp; remove the process context from its =
list , MES<br>
&gt; &gt; will treat the process context as a new item. I still don't under=
stand why<br>
&gt; MES haven't<br>
&gt; &gt; purged the&nbsp; process context from the list after process term=
ination .&nbsp;&nbsp; Will<br>
&gt; &gt; debug queue itself&nbsp; also use the add/remove queue interface&=
nbsp; and&nbsp; is<br>
&gt; &gt; it possible the debug queue itself from the&nbsp; old process&nbs=
p; still not be<br>
&gt; &gt; removed ?<br>
&gt;<br>
&gt; SET_SHADER_DEBUGGER can be called independently from ADD_QUEUE.<br>
&gt; The process list is updated on either on SET_SHADER_DEBUGGER or<br>
&gt; ADD_QUEUE.<br>
&gt; e.g. runtime_enable (set_shader) -&gt; add_queue -&gt; remove_queue (l=
ist<br>
&gt; purged) -&gt; runtime_disable (set_shader process re-added) -&gt; proc=
ess<br>
&gt; termination (stale list) or debug attach (set_shader) -&gt; add_queue =
-&gt;<br>
&gt; remove_queue (list purged) -&gt; debug detach (set_shader process re-a=
dded) -<br>
&gt; &gt;process termination (stale list)<br>
&gt;<br>
&gt; MES has no idea what process termination means.&nbsp; The new flag is =
a proxy<br>
&gt; for this.<br>
&gt; There are reasons for process settings to take place prior to queue ad=
d<br>
&gt; (debugger, gfx11 cwsr workaround, core dump etc need this).<br>
&gt;<br>
&gt; I'm not sure what kernel/debug queues have to do with this.<br>
&gt; By that argument, the list should be purged.<br>
&gt;<br>
&gt; Jon<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Shaoyun.liu<br>
&gt; &gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;<br>
&gt; &gt; Sent: Tuesday, December 12, 2023 4:48 PM<br>
&gt; &gt; To: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Huang, JinHuiEric<b=
r>
&gt; &gt; &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org<b=
r>
&gt; &gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix<br>
&gt; &gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish<br>
&gt; &gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; &gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger proc=
ess<br>
&gt; &gt; management<br>
&gt; &gt;<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
&gt; &gt; &gt; Sent: Tuesday, December 12, 2023 4:45 PM<br>
&gt; &gt; &gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; Huang, JinHu=
iEric<br>
&gt; &gt; &gt; &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
&gt; &gt; &gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix=
<br>
&gt; &gt; &gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish<br>
&gt; &gt; &gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; &gt; &gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger=
 process<br>
&gt; &gt; &gt; management<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [Public]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Shouldn't the driver side&nbsp; remove all the remaining&nbs=
p; queues for the<br>
&gt; &gt; &gt; process during&nbsp; process termination ?&nbsp; If all the&=
nbsp; queues been<br>
&gt; &gt; &gt; removed for the process ,&nbsp; MES should purge the&nbsp; p=
rocess context<br>
&gt; &gt; &gt; automatically , otherwise it's bug inside MES .<br>
&gt; &gt;<br>
&gt; &gt; That's only if there were queues added to begin with.<br>
&gt; &gt;<br>
&gt; &gt; Jon<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regard<br>
&gt; &gt; &gt; Sshaoyun.liu<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;<br>
&gt; &gt; &gt; Sent: Tuesday, December 12, 2023 4:33 PM<br>
&gt; &gt; &gt; To: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Huang, JinHuiE=
ric<br>
&gt; &gt; &gt; &lt;JinHuiEric.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
&gt; &gt; &gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, Felix=
<br>
&gt; &gt; &gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish<br>
&gt; &gt; &gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; &gt; &gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader debugger=
 process<br>
&gt; &gt; &gt; management<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [Public]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; &gt; From: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
&gt; &gt; &gt; &gt; Sent: Tuesday, December 12, 2023 4:00 PM<br>
&gt; &gt; &gt; &gt; To: Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;;=
 Kim, Jonathan<br>
&gt; &gt; &gt; &gt; &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freedesktop=
.org<br>
&gt; &gt; &gt; &gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, =
Felix<br>
&gt; &gt; &gt; &gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish=
<br>
&gt; &gt; &gt; &gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; &gt; &gt; &gt; Subject: RE: [PATCH] drm/amdkfd: fix mes set shader deb=
ugger<br>
&gt; &gt; &gt; &gt; process management<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; [AMD Official Use Only - General]<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Does this requires the&nbsp; new MES FW for this proces=
s_ctx_flush<br>
&gt; &gt; &gt; &gt; requirement ?&nbsp; Can driver side add logic to guaran=
ty when&nbsp; call<br>
&gt; &gt; &gt; &gt; SET_SHADER_DEBUGGER, the process address&nbsp; is alway=
s valid ?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Call to flush on old fw is a NOP so it's harmless in that ca=
se.<br>
&gt; &gt; &gt; Full solution will still require a new MES version as this i=
s a<br>
&gt; &gt; &gt; workaround on corner cases and not a new feature i.e. we can=
't stop<br>
&gt; &gt; &gt; ROCm from running on old fw.<br>
&gt; &gt; &gt; The process address is always valid from the driver side.&nb=
sp; It's the<br>
&gt; &gt; &gt; MES side of things that gets stale as mentioned in the descr=
iption<br>
&gt; &gt; &gt; (passed value to MES is reused with new BO but MES doesn't r=
efresh).<br>
&gt; &gt; &gt; i.e. MES auto refreshes it's process list assuming process q=
ueues<br>
&gt; &gt; &gt; were all drained but driver can't guarantee that<br>
&gt; SET_SHADER_DEBUGGER<br>
&gt; &gt; (which<br>
&gt; &gt; &gt; adds to MES's process list) will get called after queues get=
 added<br>
&gt; &gt; &gt; (in fact it's a requirements that it can be called at any ti=
me).<br>
&gt; &gt; &gt; We can attempt to defer calls these calls in the KFD, consid=
ering all<br>
&gt; cases.<br>
&gt; &gt; &gt; But that would be a large shift in debugger/runtime_enable/K=
FD code,<br>
&gt; &gt; &gt; which is already complicated and could get buggy plus it wou=
ld not<br>
&gt; &gt; &gt; be intuitive at all as to why we're doing this.<br>
&gt; &gt; &gt; I think a single flag set to flush MES on process terminatio=
n is a<br>
&gt; &gt; &gt; simpler compromise that shows the limitation in a more obvio=
us way.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Jon<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; &gt; Shaoyun.liu<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; &gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org=
&gt; On Behalf Of<br>
&gt; &gt; &gt; &gt; Eric Huang<br>
&gt; &gt; &gt; &gt; Sent: Tuesday, December 12, 2023 12:49 PM<br>
&gt; &gt; &gt; &gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-<br=
>
&gt; &gt; &gt; &gt; gfx@lists.freedesktop.org<br>
&gt; &gt; &gt; &gt; Cc: Wong, Alice &lt;Shiwei.Wong@amd.com&gt;; Kuehling, =
Felix<br>
&gt; &gt; &gt; &gt; &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan, Harish=
<br>
&gt; &gt; &gt; &gt; &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
&gt; &gt; &gt; &gt; Subject: Re: [PATCH] drm/amdkfd: fix mes set shader deb=
ugger<br>
&gt; &gt; &gt; &gt; process management<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On 2023-12-11 16:16, Jonathan Kim wrote:<br>
&gt; &gt; &gt; &gt; &gt; MES provides the driver a call to explicitly flush=
 stale process<br>
&gt; &gt; &gt; &gt; &gt; memory within the MES to avoid a race condition th=
at results in<br>
&gt; &gt; &gt; &gt; &gt; a fatal memory violation.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; When SET_SHADER_DEBUGGER is called, the driver pas=
ses a memory<br>
&gt; &gt; &gt; &gt; address<br>
&gt; &gt; &gt; &gt; &gt; that represents a process context address MES uses=
 to keep track<br>
&gt; &gt; &gt; &gt; &gt; of future per-process calls.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Normally, MES will purge its process context list =
when the last<br>
&gt; &gt; &gt; &gt; &gt; queue has been removed.&nbsp; The driver, however,=
 can call<br>
&gt; &gt; &gt; &gt; &gt; SET_SHADER_DEBUGGER regardless of whether a queue =
has been<br>
&gt; &gt; added<br>
&gt; &gt; &gt; or not.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; If SET_SHADER_DEBUGGER has been called with no que=
ues as the<br>
&gt; &gt; &gt; &gt; &gt; last call prior to process termination, the passed=
 process<br>
&gt; &gt; &gt; &gt; &gt; context address will still reside within MES.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On a new process call to SET_SHADER_DEBUGGER, the =
driver may<br>
&gt; end<br>
&gt; &gt; &gt; up<br>
&gt; &gt; &gt; &gt; &gt; passing an identical process context address value=
 (based on<br>
&gt; &gt; &gt; &gt; &gt; per-process gpu memory address) to MES but is now =
pointing to a<br>
&gt; &gt; &gt; &gt; &gt; new allocated buffer object during KFD process cre=
ation.&nbsp; Since<br>
&gt; &gt; &gt; &gt; &gt; the MES is unaware of this, access of the passed a=
ddress points<br>
&gt; &gt; &gt; &gt; &gt; to the stale object within MES and triggers a fata=
l memory violation.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The solution is for KFD to explicitly flush the pr=
ocess context<br>
&gt; &gt; &gt; &gt; &gt; address from MES on process termination.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Note that the flush call and the MES debugger call=
s use the same<br>
&gt; &gt; &gt; &gt; &gt; MES interface but are separated as KFD calls to av=
oid<br>
&gt; &gt; &gt; &gt; &gt; conflicting with each other.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Jonathan Kim &lt;jonathan.kim@amd.c=
om&gt;<br>
&gt; &gt; &gt; &gt; &gt; Tested-by: Alice Wong &lt;shiwei.wong@amd.com&gt;<=
br>
&gt; &gt; &gt; &gt; Reviewed-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt=
;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 31<br>
&gt; &gt; &gt; &gt; +++++++++++++++++++<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.=
h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 +++---<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manag=
er.c&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/include/mes_v11_ap=
i_def.h |&nbsp; 3 +-<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; 4 files changed, 40 insertions(+), 5 d=
eletions(-)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes=
.c<br>
&gt; &gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
&gt; &gt; &gt; &gt; &gt; index e544b823abf6..e98de23250dc 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
&gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
&gt; &gt; &gt; &gt; &gt; @@ -916,6 +916,11 @@ int<br>
&gt; &gt; amdgpu_mes_set_shader_debugger(struct<br>
&gt; &gt; &gt; &gt; amdgpu_device *adev,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op_input.op =
=3D MES_MISC_OP_SET_SHADER_DEBUGGER;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op_input.set_s=
hader_debugger.process_context_addr =3D<br>
&gt; &gt; &gt; &gt; process_context_addr;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op_input.set_s=
hader_debugger.flags.u32all =3D flags;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* use amdgpu mes_flush_=
shader_debugger instead */<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (op_input.set_shader_=
debugger.flags.process_ctx_flush)<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op_input.set_s=
hader_debugger.spi_gdbg_per_vmid_cntl =3D<br>
&gt; &gt; &gt; &gt; spi_gdbg_per_vmid_cntl;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(op_inpu=
t.set_shader_debugger.tcp_watch_cntl,<br>
&gt; &gt; &gt; &gt; tcp_watch_cntl,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; sizeof(op_input.set_shader_debugger.tcp_watch_cntl=
));<br>
&gt; &gt; &gt; &gt; &gt; @@ -935,6 +940,32 @@ int<br>
&gt; &gt; amdgpu_mes_set_shader_debugger(struct<br>
&gt; &gt; &gt; &gt; amdgpu_device *adev,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +int amdgpu_mes_flush_shader_debugger(struct amdgp=
u_device<br>
&gt; &gt; *adev,<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint64_t process_context_addr) {<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mes_misc_op_input=
 op_input =3D {0};<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mes.funcs-=
&gt;misc_op) {<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;mes flush shader debugger is not<br=
>
&gt; &gt; supported!\n&quot;);<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; op_input.op =3D MES_MISC=
_OP_SET_SHADER_DEBUGGER;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; op_input.set_shader_debu=
gger.process_context_addr =3D<br>
&gt; &gt; &gt; &gt; process_context_addr;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; op_input.set_shader_debu=
gger.flags.process_ctx_flush =3D<br>
&gt; &gt; &gt; &gt; &gt; + true;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;ade=
v-&gt;mes);<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs=
-&gt;misc_op(&amp;adev-&gt;mes, &amp;op_input);<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to set_shader_debugger\n&quo=
t;);<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(&amp;a=
dev-&gt;mes);<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; static void<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; amdgpu_mes_ring_to_queue_props(struct =
amdgpu_device *adev,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring, =
diff<br>
&gt; &gt; &gt; &gt; &gt; --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br=
>
&gt; &gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt; &gt; &gt; &gt; &gt; index 894b9b133000..7d4f93fea937 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt; &gt; &gt; &gt; &gt; @@ -296,9 +296,10 @@ struct mes_misc_op_input {<br=
>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint64_t process_context_addr;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; union {<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; &gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint64_t single_memop : 1;<br>
&gt; &gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint64_t single_alu_op : 1;<br>
&gt; &gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint64_t reserved: 30;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint32_t single_memop : 1;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint32_t single_alu_op : 1;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint32_t reserved: 29;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint32_t process_ctx_flush:<br>
&gt; &gt; &gt; &gt; &gt; + 1;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t u32all;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } flags;<br>
&gt; &gt; &gt; &gt; &gt; @@ -374,7 +375,8 @@ int<br>
&gt; amdgpu_mes_set_shader_debugger(struct<br>
&gt; &gt; &gt; &gt; amdgpu_device *adev,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint32_t *tcp_=
watch_cntl,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool trap_en);<br>
&gt; &gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; &gt; +int amdgpu_mes_flush_shader_debugger(struct amdgp=
u_device<br>
&gt; &gt; *adev,<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t process_context_addr)=
;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; int amdgpu_mes_add_ring(struct amdgpu_=
device *adev, int<br>
&gt; gang_id,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; int queue_type, int idx,<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_mes_ctx_data *ctx_data, diff<br>
&gt; &gt; &gt; &gt; &gt; --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_que=
ue_manager.c<br>
&gt; &gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_man=
ager.c<br>
&gt; &gt; &gt; &gt; &gt; index 77f493262e05..8e55e78fce4e 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue=
_manager.c<br>
&gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue=
_manager.c<br>
&gt; &gt; &gt; &gt; &gt; @@ -87,6 +87,7 @@ void kfd_process_dequeue_from_de=
vice(struct<br>
&gt; &gt; &gt; &gt; kfd_process_device *pdd)<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;dqm-&g=
t;ops.process_termination(dev-&gt;dqm, &amp;pdd-&gt;qpd);<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_flush_shader_=
debugger(dev-&gt;adev, pdd-<br>
&gt; &gt; &gt; &gt; &gt;proc_ctx_gpu_addr);<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;alread=
y_dequeued =3D true;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/include/mes_v11_a=
pi_def.h<br>
&gt; &gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/include/mes_v11_api_def.h<br=
>
&gt; &gt; &gt; &gt; &gt; index 1fbfd1aa987e..ec5b9ab67c5e 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.=
h<br>
&gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.=
h<br>
&gt; &gt; &gt; &gt; &gt; @@ -572,7 +572,8 @@ struct SET_SHADER_DEBUGGER {<b=
r>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t single_memop : 1;&nbsp; /*<br>
&gt; &gt; &gt; &gt; &gt; SQ_DEBUG.single_memop<br>
&gt; &gt; &gt; */<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t single_alu_op : 1; /* SQ_DEBUG.single_alu_op<br>
&gt; */<br>
&gt; &gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t reserved : 30;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t reserved : 29;<br>
&gt; &gt; &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t process_ctx_flush : 1;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t u32all;<br>
&gt; &gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } flags;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5372A1E3E4C24B4F2C3C13BAF48DACH0PR12MB5372namp_--
