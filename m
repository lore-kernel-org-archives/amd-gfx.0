Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813A01075261
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 06:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E78B10E0E6;
	Thu, 19 Mar 2026 06:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GlrvoTcV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF8510E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 06:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouiMfrTWzLl8US6kVhfcg5/ihZc4QtIHcpFhRxY3bqwPU2QDjh/xjcj0dlXRmcF9XKR1R2csf9J3/g4tD70NzflY7CTZmVGqezhdPhWdQWMTftKXCHm7LMkNnyqqflvdMgUcBgoZqovBIdQMKLGnkBpJUzS2Moq7Z8rDJo1yrXyetCqYjyDejnlvoSg/XiB0S9T9Wjs1Kpv0ER/183dlCXS6nhgnL9A8d2o9F4kA0q9FjtUHIH8rZq+nylGqfVtZ+FLjAlNI9Ayf5QbyPzZu0LZTbylJYkSBa/31Z2665WmSmDID9ipag+cvhgHB3OVARBTlvkTgHLiZrU8KbLdn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yLEdMX4/tMonqvxV741GOd3MgZ5cgEZBoWoWOuxBk0=;
 b=qYB0D9znKjMxUAoldTH8H4TN3w1Gps6SQLMA39KgYdela0ds2SXY1lsWRt7644M69ez9EtaLnXl2udzZoXUxa5as9tXxjRWkweUBL5gHU75jIDemZCWhBFf2Lao4RlmrIvqXDes+KLgxkbZNjXsUj25onknkJE+MDL41DHVcfqIbR9LKG6pqViWSvcumvDJPZPIYkJuHxyvlhCpNG5Cc77bfmopf1AloYRl2+HOCDO7Wom2OO4BOyQNv1NN4Ongf/Sbyptjdmzdzm5EYjNvJt8N85TftKjg2VCMCOYnEdJoFEbABeKhOPfubJ0a9i0uNS7uuKpK+vrOuUz8Yw2IGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yLEdMX4/tMonqvxV741GOd3MgZ5cgEZBoWoWOuxBk0=;
 b=GlrvoTcVStekzPWDNzKhoyFvGb2daihNwQ9bNEmGAJQPfXMnLP4j7JDUcM9nv25UxJyXnQVD38NaxWMusS4voUWbkCXMdYd99Tha/fbNwYIW98dFjLzghqvLgBLDd/LjWXOriUIRbZYr9YdR63NtJxhzihrLHj1EeGI8RZytFl4=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:27:05 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 06:27:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Topic: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Index: AQHctq0to8syQiKarkGCBSlqkqwr77Wz802AgAATn4CAAAHhAIABF5rAgAA1ZACAAA5UoA==
Date: Thu, 19 Mar 2026 06:27:04 +0000
Message-ID: <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-19T05:31:01.5800000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA1PR12MB7173:EE_
x-ms-office365-filtering-correlation-id: 2ca1c825-4b53-4747-dab7-08de858089bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|921020|38070700021|22082099003|18002099003|7053199007|56012099003;
x-microsoft-antispam-message-info: lt2yh77bgVqwB6wNunQtpGqioICqCQhTR/AKkC5DZRcEgBqsyhC9Ehj+DuR803RnOBbK6WMJ01/VxAzSUSj9IuMeR5/pzmDd2ymW8i5zPUtW0AOichRw3Vjh90i6NqZ19A4tuDmYUdWG4OeKHLYAw0Ive+sE5VBfyhRUbYyBqFgUrhV6wLPBbqVPjxs7lrClWWfh9YL9EKccF78UicHhEKyhF0RFziBJZIYBky/BCTQJ1mxaEdBW5EHcJcwmqqWem+7iANi630row3CvxvT4mNH8ySga9Lcsd9cjb1RkXSklTeteRqOv6fkyLRYsY1bCKwV6LvyWDxstO98by99w5cXK9Dw3vQvLpFEjZkgiT11lyemRJVfChNqcHM7ojr4JRsl1fjPXKb5bHPkaMgCKRKonMR6xa7qQZCxQR4icLvOnGbsa5zvu2lnBlaXolXHeG5RU934Dkq3tS1geGtAGtV7n0CM5xoxZCq0wj0E0VjyabD+hhFQpRu0DKXvdXKvYFH3y2Re8/H6soj2e9kqlg4gJGuHQ5DaN8cP6hoGpbEKSc0bwrCcoyuXXdJbWpis02tg67OF1iTnaHCiugJpjxerOI0FLctvsuMqoSqzN0T1p900pHix493z8K6Qv7d9P8PJWW69Uat/r0fVzq53T1PFfhsXy1RktN+D2BsdN/DcMPB6UZtWfCCLDoDnUFBmClDoPMhxIaVflUyqDxNdj1eiA45niNxdfMOktZOVctAnrb8baRKJNOrpFgjZcN3KKHAkPkZOU3Z/78s+yK9HL/h1MQvpGhKqV08SM0O/KrgKblK0TVBj3FESvOgZ6moNl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(921020)(38070700021)(22082099003)(18002099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TRrjDWq7N3prqofwUtIrPKKHnvn5PORt9azfjq/lwi58KgkN/wqDMOr6YX?=
 =?iso-8859-1?Q?Y0DToUvWjBoGYBilZV4U1f0w8ndu/SqzgzrITijNjDlTsQd6TKkfHo9Ds9?=
 =?iso-8859-1?Q?kLrK12EJYan1lZfBzL5LppYEYQbxPKH0gJ4ykknE+Ozn6n2imhlxOSe3kg?=
 =?iso-8859-1?Q?Jv05pvnhMRf+4AvryKqoHLpzt+MVU9n+3CWkmR9YlLsFhfTju+Tsz9+bE7?=
 =?iso-8859-1?Q?QsKAKFU1Ork+LDjdHZmLeAliOeiti+wRKJbC0yqGyXPLIVcRmUNetOdWr+?=
 =?iso-8859-1?Q?SqHFBJPkGT4QfCvSPabO5jyKWzS76jsq1ncceUPYTvTXGAUo1PTttcUoiD?=
 =?iso-8859-1?Q?x/sWCbbXJuvAyckUtnldXmUzTFVfaUxnb/r1kjHdV8cmzyZp84ZxMr2hCp?=
 =?iso-8859-1?Q?gQzdBzo5agwdLwG80p/ssxvapbURZV6CyVTzTt+9yeQGdpHKMcHC55THTl?=
 =?iso-8859-1?Q?trtTZfBt/C7wq3vpOCZQu44wdX+oQArpyuLRfQPu8O50PIzUoB0lF2E6ot?=
 =?iso-8859-1?Q?ur47pt3Im7BQJSL+Y4n8Rzx9YmUkqGsWY0mzwioWipfxJb0gIheQS8bXQM?=
 =?iso-8859-1?Q?G4BVvUPWViyr7040G97iFgMjS+CNbuE26BCZyMnYpGLtJQacmRWcz45uwh?=
 =?iso-8859-1?Q?9U5aTQeDz/ekinGIojdPqEROirnWUPbSpKjyw5JLqzXVfP6e+eS8g9aUbc?=
 =?iso-8859-1?Q?rOhISn9KRxM+/IBu0u/RItubZvo5GIpcdYJfEe0pVo9o9kEnsrUzUsFTug?=
 =?iso-8859-1?Q?rXYEbUaFrDp/Fo12k+qMOAWese/MdpCqz6X3L8NytnmtvTgccIVuwnF+qq?=
 =?iso-8859-1?Q?Dkpdb1nCXXqLkjyIuFhaLI7DTYXcx6vSwbxpRVHemC+zbdjpbIa+2yY6WO?=
 =?iso-8859-1?Q?eRE0p6d9FxVjRb/xH6Xc9adBNpwQWZuUONuoU00T/kgyQL+5JaubWJT+oE?=
 =?iso-8859-1?Q?jiSzYNruWZky+LoPEZON26pQ3dITX5S6BSXK/Se9a37JYxJpaECnfz4x/R?=
 =?iso-8859-1?Q?C1mTRINFX2SnnUZF6DevX72zchgSe7g6GfFPN9a3nqKsD2pMf0dD4mAGc1?=
 =?iso-8859-1?Q?wXPWzIretjRI37w0cOKyB8ss6Fu02cCrubFdWu/s+Od6cID77tGmB7lVB/?=
 =?iso-8859-1?Q?amX1o5kkMokFYHjrDaqRTDaoPYBzMYcJoPyh3lo0YJLAs4IY5LcC8y+9bg?=
 =?iso-8859-1?Q?1LBQeFoQWpayYEogxAlkTdGccyCfaETqCOfP3UO0NdwA2omTmM7BHlMYx4?=
 =?iso-8859-1?Q?7YEsZSUYDKcNZA26zF0SDXIAtqA4Pm4jmZkSk/aOHHdfzk+CPsKWZDcXTY?=
 =?iso-8859-1?Q?Tc1qIIhGeiTmiK7BNPSK3wsIlmLe0mVLIGw3TPlAPZIiDW6Bgis658RNKe?=
 =?iso-8859-1?Q?GcXQEvmF9siEGgw51cNkoKSDMw37vXAndW3jquTjgfh1Hk70BPfmtrahBO?=
 =?iso-8859-1?Q?SKgqPHK/4WDtW6SdMbLCV6PH962Jmwh+UonTOwxodqvhHYUwfcjJup+38z?=
 =?iso-8859-1?Q?QC2IsmbFwgIzUTqQUEGDg9Oq8ZkheIQMXgvyxWBmmsEYFQFgRrWu+27D6e?=
 =?iso-8859-1?Q?H85XC/kaFQGMw3ilu7+PZ+rOByvEazDcM/1Nx7eYSurNh34Nt3T6hT3T+t?=
 =?iso-8859-1?Q?9vbvysk+xlfFYBQa308ZZVNx9qcpNoUwv/r6q/KtIsZIw9Zl37VIiqDJMo?=
 =?iso-8859-1?Q?C/HNCNSLDYkbEVD9RnTlHYnA4MCVDfct9czGOVhmujoa1KUM8x1x//GtbO?=
 =?iso-8859-1?Q?aQ9+9+afkNTodzjN5uX66GdTUv0YyBkmI0WUqcBRBBX/aH?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB6000366C1E6582CD02D90AD6FB4FAPH7PR12MB6000namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca1c825-4b53-4747-dab7-08de858089bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 06:27:04.6219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36pHPpDaQ5WizgxzQ7BALcKi73HhUoj5kpubnq5mJODdpYalUuRBNCw9EN5o6AJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

--_000_PH7PR12MB6000366C1E6582CD02D90AD6FB4FAPH7PR12MB6000namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks for the confirmation. If Mesa doesn't zero the handle buffer, I'm go=
ing to drop this validation check in the kernel and then leave a debug mess=
age for this case.

Regards,
      Prike

From: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
Sent: Thursday, March 19, 2026 1:31 PM
To: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com=
>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument =
validation"

[Public]

Hi Prike,

Regarding below check in the Kernel patch,

/* Reject non-NULL pointers paired with a zero count. */
if (!args->num_syncobj_handles && args->syncobj_handles)
          return -EINVAL;

Mesa uses alloca for args->syncobj_handles, alloca(0) returns non NULL.


I think the check "Reject non-NULL pointers paired with a zero count" in Ke=
rnel can be skipped.


Thank you,
Yogesh

________________________________
From: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Sent: Thursday, March 19, 2026 8:03 AM
To: Khatri, Sunil <Sunil.Khatri@amd.com<mailto:Sunil.Khatri@amd.com>>; Zhan=
g, Jesse(Jie) <Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.com>>; Khatri, Su=
nil <Sunil.Khatri@amd.com<mailto:Sunil.Khatri@amd.com>>; Koenig, Christian =
<Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Mohan M=
arimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com<mailto:Yogesh.Mohanmarimuth=
u@amd.com>>; Olsak, Marek <Marek.Olsak@amd.com<mailto:Marek.Olsak@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument =
validation"

[Public]

Add @Mohan Marimuthu, Yogesh/@Olsak, Marek

It looks like the validation in several places doesn't match how Mesa alloc=
ates these buffers. i.e when num_syncobj_handles is zero, syncobj_handles m=
ust not be required to be NULL, because Mesa leaves it uninitialized when a=
llocating it on the stack. We should either implement a proper fix in Mesa =
for this case or drop the known broken validation check.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Khatri, Sunil
> Sent: Wednesday, March 18, 2026 5:39 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.com>>; =
Khatri, Sunil
> <Sunil.Khatri@amd.com<mailto:Sunil.Khatri@amd.com>>; Koenig, Christian <C=
hristian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>;
> Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@am=
d.com>>
> Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argumen=
t
> validation"
>
>
> On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> >> -----Original Message-----
> >> From: Khatri, Sunil <Sunil.Khatri@amd.com<mailto:Sunil.Khatri@amd.com>=
>
> >> Sent: Wednesday, March 18, 2026 4:22 PM
> >> To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koeni=
g@amd.com>>; Khatri, Sunil
> >> <Sunil.Khatri@amd.com<mailto:Sunil.Khatri@amd.com>>; Deucher, Alexande=
r
> >> <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>
> >> Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org=
>; Zhang, Jesse(Jie)
> >> <Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.com>>
> >> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl
> >> argument validation"
> >>
> >>
> >> On 18-03-2026 01:29 pm, Christian K=F6nig wrote:
> >>> On 3/18/26 08:47, Sunil Khatri wrote:
> >>>> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
> >>>>
> >>>> The patch has caused regression for userqueues where user is stuck
> >>>> and is waiting for fences and a gpu reset is triggered in kernel.
> >>>> Also for any of the parameters when count is zero, the driver does
> >>>> not read from the pointer and having that check is overkill.
> >>>>
> >>>> Application:
> >>>> MESA: error: amdgpu: getting wait num_fences failed
> >>>> MESA: error: amdgpu: getting wait fences failed
> >>>> MESA: error: amdgpu: getting wait num_fences failed
> >>>> MESA: error: amdgpu: getting wait fences failed
> > After I reverted this patch, the error still occurs when running glxgea=
rs.
> > Does it work fine on your end if you don't apply this patch?
> >
> > amdgpu: getting wait fences failed
> > amdgpu: getting wait fences failed
> > amdgpu: getting wait fences failed
>
> Yes, it works. You might need to update mesa too. I am using the latest m=
esa with
> ubuntu and i dont see those error. with your patch they do show.
>
> Regards
> Sunil Khatri
> >
> > Thanks
> > Jesse
> >
> >
> >>>> Dmesg:
> >>>> [  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail
> >>>> 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [
> >>>> 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000,
> >>>> type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [  124.687518]
> >>>> amdgpu 0000:0a:00.0: Dumping IP State [  124.688351] amdgpu
> >>>> 0000:0a:00.0: Dumping IP State Completed [  124.688355] amdgpu
> >>>> 0000:0a:00.0: [drm] AMDGPU device coredump file has been created [
> >>>> 124.688357] amdgpu 0000:0a:00.0: [drm] Check your
> >>>> /sys/class/drm/card0/device/devcoredump/data
> >>>> [  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout,
> >>>> signaled seq=3D569, emitted seq=3D571 [  124.688366] amdgpu
> >>>> 0000:0a:00.0:  Process Xwayland pid 3471 thread Xwayland:cs0 pid
> >>>> 3479 [  124.688369] amdgpu
> >>>> 0000:0a:00.0: Starting gfx_0.0.0 ring reset [  126.560451] amdgpu
> >>>> 0000:0a:00.0: MES(0) failed to respond to msg=3DRESET [  126.560456]
> >>>> amdgpu 0000:0a:00.0: failed to detect and reset [  126.560460]
> >>>> amdgpu
> >>>> 0000:0a:00.0: Failed to detect and reset queues, err (-110) [
> >>>> 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed [
> >>>> 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1 [
> >>>> 128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled,
> >>>> skipping HW
> >> reset [  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
> >>>> [  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but
> >>>> recovered through reset [  128.804574] amdgpu 0000:0a:00.0: GPU
> >>>> reset begin!. Source:  6 [  128.816663] amdgpu 0000:0a:00.0:
> >>>> Dumping IP State [  128.817458] amdgpu 0000:0a:00.0: Dumping IP
> >>>> State Completed [  130.963939] amdgpu 0000:0a:00.0: MES(1) failed
> >>>> to respond to msg=3DREMOVE_QUEUE [  130.963949] amdgpu 0000:0a:00.0:
> >>>> failed to unmap legacy queue
> >>>>
> >>>> Cc: Jesse Zhang <jesse.zhang@amd.com<mailto:jesse.zhang@amd.com>>
> >>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com<mailto:sunil.khatr=
i@amd.com>>
> >>>> ---
> >>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 --------------=
-----
> >>>>    1 file changed, 29 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> index 3fcd70a38374..0d9a13081f2f 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct
> >>>> drm_device
> >> *dev, void *data,
> >>>>         args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> >>>>             return -EINVAL;
> >>>>
> >>>> -  /* Reject non-NULL pointers paired with a zero count. */
> >>>> -  if (!args->num_syncobj_handles && args->syncobj_handles)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!args->num_bo_read_handles && args->bo_read_handles)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!args->num_bo_write_handles && args->bo_write_handles)
> >>>> -          return -EINVAL;
> >>>> -
> >>>>     num_syncobj_handles =3D args->num_syncobj_handles;
> >>>>     syncobj_handles =3D memdup_array_user(u64_to_user_ptr(args-
> >>> syncobj_handles),
> >>>>                                         num_syncobj_handles,
> >>>> sizeof(u32)); @@ -
> >> 950,25 +940,6 @@
> >>>> int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> >>>>         wait_info->num_bo_read_handles >
> >> AMDGPU_USERQ_MAX_HANDLES)
> >>>>             return -EINVAL;
> >>>>
> >>>> -  /* Reject non-NULL pointers paired with a zero count: the pointer
> >>>> -   * is meaningless and indicates inconsistent input from userspace=
.
> >>>> -   */
> >>>> -  if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles=
)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_syncobj_timeline_handles &&
> >>>> -      (wait_info->syncobj_timeline_handles || wait_info-
> >>> syncobj_timeline_points))
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles=
)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_bo_write_handles && wait_info->bo_write_handl=
es)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_fences && wait_info->out_fences)
> >>>> -          return -EINVAL;
> >>>> -
> >>> Mhm, in general such checks look valid to me.
> >>>
> >>> My educated guess is that userspace sets num_fences =3D 0 to query if
> >>> it needs to
> >> resize the pointer out_fences or not.
> >>> If you have time please double check which check fails here.
> >> Sure, i will check on that but for now i have pushed this revert.
> >>
> >> regards
> >>
> >> sunil khatri
> >>
> >>> Apart from that Reviewed-by: Christian K=F6nig <christian.koenig@amd.=
com<mailto:christian.koenig@amd.com>>.
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>     num_syncobj =3D wait_info->num_syncobj_handles;
> >>>>     ptr =3D u64_to_user_ptr(wait_info->syncobj_handles);
> >>>>     syncobj_handles =3D memdup_array_user(ptr, num_syncobj,
> >>>> sizeof(u32));

--_000_PH7PR12MB6000366C1E6582CD02D90AD6FB4FAPH7PR12MB6000namp_
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
</style><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Thanks for the confirmation. If Mesa doesn&#8217;t ze=
ro the handle buffer, I&#8217;m going to drop this validation check in the =
kernel and then leave a debug message for this case.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prike<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Mohan Marimuthu, Yogesh &lt;Yo=
gesh.Mohanmarimuthu@amd.com&gt;
<br>
<b>Sent:</b> Thursday, March 19, 2026 1:31 PM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Khatri, Sunil &lt;Suni=
l.Khatri@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Khatri=
, Sunil &lt;Sunil.Khatri@amd.com&gt;; Koenig, Christian &lt;Christian.Koeni=
g@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Olsak, Marek &lt;Marek.Olsak@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAIT ioc=
tl argument validation&quot;<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Prike,<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Regarding below check in=
 the Kernel patch,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div style=3D"margin-left:30.0pt">
<p class=3D"MsoNormal"><span style=3D"color:black">/* Reject non-NULL point=
ers paired with a zero count. */<o:p></o:p></span></p>
</div>
<div style=3D"margin-left:30.0pt">
<p class=3D"MsoNormal"><span style=3D"color:black">if (!args-&gt;num_syncob=
j_handles &amp;&amp; args-&gt;syncobj_handles)<o:p></o:p></span></p>
</div>
<div style=3D"margin-left:30.0pt">
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; return -EINVAL;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Mesa uses alloca for arg=
s-&gt;syncobj_handles, alloca(0) returns non NULL.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">I think the check &quot;=
Reject non-NULL pointers paired with a zero count&quot; in Kernel can be sk=
ipped.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Thank you,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Yogesh<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black">From:</span></b><span style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black">&nbsp;Liang, Prike &lt;<a href=3D"mailto:=
Prike.Liang@amd.com">Prike.Liang@amd.com</a>&gt;<br>
<b>Sent:</b>&nbsp;Thursday, March 19, 2026 8:03 AM<br>
<b>To:</b>&nbsp;Khatri, Sunil &lt;<a href=3D"mailto:Sunil.Khatri@amd.com">S=
unil.Khatri@amd.com</a>&gt;; Zhang, Jesse(Jie) &lt;<a href=3D"mailto:Jesse.=
Zhang@amd.com">Jesse.Zhang@amd.com</a>&gt;; Khatri, Sunil &lt;<a href=3D"ma=
ilto:Sunil.Khatri@amd.com">Sunil.Khatri@amd.com</a>&gt;; Koenig,
 Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig=
@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuche=
r@amd.com">Alexander.Deucher@amd.com</a>&gt;; Mohan Marimuthu, Yogesh &lt;<=
a href=3D"mailto:Yogesh.Mohanmarimuthu@amd.com">Yogesh.Mohanmarimuthu@amd.c=
om</a>&gt;;
 Olsak, Marek &lt;<a href=3D"mailto:Marek.Olsak@amd.com">Marek.Olsak@amd.co=
m</a>&gt;<br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@li=
sts.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAI=
T ioctl argument validation&quot;
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><a name=3D"BM_BEGIN"></a><span style=3D"font-size:11=
.0pt;font-family:&quot;Times New Roman&quot;,serif">[Public]<br>
<br>
Add @Mohan Marimuthu, Yogesh/@Olsak, Marek<br>
<br>
It looks like the validation in several places doesn&#8217;t match how Mesa=
 allocates these buffers. i.e when num_syncobj_handles is zero, syncobj_han=
dles must not be required to be NULL, because Mesa leaves it uninitialized =
when allocating it on the stack. We should
 either implement a proper fix in Mesa for this case or drop the known brok=
en validation check.<br>
<br>
Regards,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prike<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Khatri, Sun=
il<br>
&gt; Sent: Wednesday, March 18, 2026 5:39 PM<br>
&gt; To: Zhang, Jesse(Jie) &lt;<a href=3D"mailto:Jesse.Zhang@amd.com">Jesse=
.Zhang@amd.com</a>&gt;; Khatri, Sunil<br>
&gt; &lt;<a href=3D"mailto:Sunil.Khatri@amd.com">Sunil.Khatri@amd.com</a>&g=
t;; Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Chris=
tian.Koenig@amd.com</a>&gt;;<br>
&gt; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Al=
exander.Deucher@amd.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAIT ioctl=
 argument<br>
&gt; validation&quot;<br>
&gt;<br>
&gt;<br>
&gt; On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:<br>
&gt; &gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Khatri, Sunil &lt;<a href=3D"mailto:Sunil.Khatri@amd.co=
m">Sunil.Khatri@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, March 18, 2026 4:22 PM<br>
&gt; &gt;&gt; To: Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@=
amd.com">Christian.Koenig@amd.com</a>&gt;; Khatri, Sunil<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:Sunil.Khatri@amd.com">Sunil.Khatri@amd.=
com</a>&gt;; Deucher, Alexander<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.De=
ucher@amd.com</a>&gt;<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a>; Zhang, Jesse(Jie)<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:Jesse.Zhang@amd.com">Jesse.Zhang@amd.co=
m</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/W=
AIT ioctl<br>
&gt; &gt;&gt; argument validation&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 18-03-2026 01:29 pm, Christian K=F6nig wrote:<br>
&gt; &gt;&gt;&gt; On 3/18/26 08:47, Sunil Khatri wrote:<br>
&gt; &gt;&gt;&gt;&gt; This reverts commit 0cdff8eb31c139dde4716e4aa37198c16=
364629e.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; The patch has caused regression for userqueues where =
user is stuck<br>
&gt; &gt;&gt;&gt;&gt; and is waiting for fences and a gpu reset is triggere=
d in kernel.<br>
&gt; &gt;&gt;&gt;&gt; Also for any of the parameters when count is zero, th=
e driver does<br>
&gt; &gt;&gt;&gt;&gt; not read from the pointer and having that check is ov=
erkill.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Application:<br>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait num_fences failed<b=
r>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait fences failed<br>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait num_fences failed<b=
r>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait fences failed<br>
&gt; &gt; After I reverted this patch, the error still occurs when running =
glxgears.<br>
&gt; &gt; Does it work fine on your end if you don't apply this patch?<br>
&gt; &gt;<br>
&gt; &gt; amdgpu: getting wait fences failed<br>
&gt; &gt; amdgpu: getting wait fences failed<br>
&gt; &gt; amdgpu: getting wait fences failed<br>
&gt;<br>
&gt; Yes, it works. You might need to update mesa too. I am using the lates=
t mesa with<br>
&gt; ubuntu and i dont see those error. with your patch they do show.<br>
&gt;<br>
&gt; Regards<br>
&gt; Sunil Khatri<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt; Jesse<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt;&gt; Dmesg:<br>
&gt; &gt;&gt;&gt;&gt; [&nbsp; 122.668493] amdgpu 0000:0a:00.0: sq_intr: err=
or, detail<br>
&gt; &gt;&gt;&gt;&gt; 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id =
0, wgp_id 0 [<br>
&gt; &gt;&gt;&gt;&gt; 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, deta=
il 0x00000000,<br>
&gt; &gt;&gt;&gt;&gt; type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 =
[&nbsp; 124.687518]<br>
&gt; &gt;&gt;&gt;&gt; amdgpu 0000:0a:00.0: Dumping IP State [&nbsp; 124.688=
351] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Dumping IP State Completed [&nbsp; 124.=
688355] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: [drm] AMDGPU device coredump file has b=
een created [<br>
&gt; &gt;&gt;&gt;&gt; 124.688357] amdgpu 0000:0a:00.0: [drm] Check your<br>
&gt; &gt;&gt;&gt;&gt; /sys/class/drm/card0/device/devcoredump/data<br>
&gt; &gt;&gt;&gt;&gt; [&nbsp; 124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0=
.0 timeout,<br>
&gt; &gt;&gt;&gt;&gt; signaled seq=3D569, emitted seq=3D571 [&nbsp; 124.688=
366] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0:&nbsp; Process Xwayland pid 3471 thread =
Xwayland:cs0 pid<br>
&gt; &gt;&gt;&gt;&gt; 3479 [&nbsp; 124.688369] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Starting gfx_0.0.0 ring reset [&nbsp; 1=
26.560451] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: MES(0) failed to respond to msg=3DRESET=
 [&nbsp; 126.560456]<br>
&gt; &gt;&gt;&gt;&gt; amdgpu 0000:0a:00.0: failed to detect and reset [&nbs=
p; 126.560460]<br>
&gt; &gt;&gt;&gt;&gt; amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Failed to detect and reset queues, err =
(-110) [<br>
&gt; &gt;&gt;&gt;&gt; 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset=
 failed [<br>
&gt; &gt;&gt;&gt;&gt; 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. So=
urce:&nbsp; 1 [<br>
&gt; &gt;&gt;&gt;&gt; 128.790161] amdgpu 0000:0a:00.0: Guilty job already s=
ignaled,<br>
&gt; &gt;&gt;&gt;&gt; skipping HW<br>
&gt; &gt;&gt; reset [&nbsp; 128.790174] amdgpu 0000:0a:00.0: GPU reset(1) s=
ucceeded!<br>
&gt; &gt;&gt;&gt;&gt; [&nbsp; 128.804538] amdgpu 0000:0a:00.0: [drm] device=
 wedged, but<br>
&gt; &gt;&gt;&gt;&gt; recovered through reset [&nbsp; 128.804574] amdgpu 00=
00:0a:00.0: GPU<br>
&gt; &gt;&gt;&gt;&gt; reset begin!. Source:&nbsp; 6 [&nbsp; 128.816663] amd=
gpu 0000:0a:00.0:<br>
&gt; &gt;&gt;&gt;&gt; Dumping IP State [&nbsp; 128.817458] amdgpu 0000:0a:0=
0.0: Dumping IP<br>
&gt; &gt;&gt;&gt;&gt; State Completed [&nbsp; 130.963939] amdgpu 0000:0a:00=
.0: MES(1) failed<br>
&gt; &gt;&gt;&gt;&gt; to respond to msg=3DREMOVE_QUEUE [&nbsp; 130.963949] =
amdgpu 0000:0a:00.0:<br>
&gt; &gt;&gt;&gt;&gt; failed to unmap legacy queue<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Cc: Jesse Zhang &lt;<a href=3D"mailto:jesse.zhang@amd=
.com">jesse.zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Signed-off-by: Sunil Khatri &lt;<a href=3D"mailto:sun=
il.khatri@amd.com">sunil.khatri@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_userq=
_fence.c&nbsp;&nbsp; | 29 -------------------<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 29 deletions(-)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_=
fence.c<br>
&gt; &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<br>
&gt; &gt;&gt;&gt;&gt; index 3fcd70a38374..0d9a13081f2f 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=
<br>
&gt; &gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=
<br>
&gt; &gt;&gt;&gt;&gt; @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(st=
ruct<br>
&gt; &gt;&gt;&gt;&gt; drm_device<br>
&gt; &gt;&gt; *dev, void *data,<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-=
&gt;num_bo_read_handles &gt; AMDGPU_USERQ_MAX_HANDLES)<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; /* Reject non-NULL pointers paired with a zer=
o count. */<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_syncobj_handles &amp;&amp; =
args-&gt;syncobj_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_bo_read_handles &amp;&amp; =
args-&gt;bo_read_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_bo_write_handles &amp;&amp;=
 args-&gt;bo_write_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj_handles =3D args-=
&gt;num_syncobj_handles;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; syncobj_handles =3D memdup_ar=
ray_user(u64_to_user_ptr(args-<br>
&gt; &gt;&gt;&gt; syncobj_handles),<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj_handles,<br>
&gt; &gt;&gt;&gt;&gt; sizeof(u32)); @@ -<br>
&gt; &gt;&gt; 950,25 +940,6 @@<br>
&gt; &gt;&gt;&gt;&gt; int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_=
info-&gt;num_bo_read_handles &gt;<br>
&gt; &gt;&gt; AMDGPU_USERQ_MAX_HANDLES)<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; /* Reject non-NULL pointers paired with a zer=
o count: the pointer<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp; * is meaningless and indicates inconsis=
tent input from userspace.<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_syncobj_handles &amp;&=
amp; wait_info-&gt;syncobj_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_syncobj_timeline_handl=
es &amp;&amp;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (wait_info-&gt;syncob=
j_timeline_handles || wait_info-<br>
&gt; &gt;&gt;&gt; syncobj_timeline_points))<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_bo_read_handles &amp;&=
amp; wait_info-&gt;bo_read_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_bo_write_handles &amp;=
&amp; wait_info-&gt;bo_write_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_fences &amp;&amp; wait=
_info-&gt;out_fences)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; Mhm, in general such checks look valid to me.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; My educated guess is that userspace sets num_fences =3D 0=
 to query if<br>
&gt; &gt;&gt;&gt; it needs to<br>
&gt; &gt;&gt; resize the pointer out_fences or not.<br>
&gt; &gt;&gt;&gt; If you have time please double check which check fails he=
re.<br>
&gt; &gt;&gt; Sure, i will check on that but for now i have pushed this rev=
ert.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; regards<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; sunil khatri<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Apart from that Reviewed-by: Christian K=F6nig &lt;<a hre=
f=3D"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt;.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Regards,<br>
&gt; &gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj =3D wait_info-&gt=
;num_syncobj_handles;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D u64_to_user_ptr(wait_=
info-&gt;syncobj_handles);<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; syncobj_handles =3D memdup_ar=
ray_user(ptr, num_syncobj,<br>
&gt; &gt;&gt;&gt;&gt; sizeof(u32));<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB6000366C1E6582CD02D90AD6FB4FAPH7PR12MB6000namp_--
