Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76103CE7B19
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37BB10E056;
	Fri,  6 Sep 2024 14:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwzNK1cB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F9810E056
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 14:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cE2SjL9G2RbYXI8Z2o6+Y1wZCmcg+We/ow8ZCxYLfEbWTauK2OsuiBARcAdGSETU0C7Z2WTjsG8kLhNZNC6Uq+G0FsTKWR7XGsHbDLv9HnTZRpwXYZ1RdrU2LAO0px2M0cIMZ36feLQyYGqes63K+kWfLwgxmqSxLK58rUNP0gSE5sdbUHvOPKqrmp19ZUAerGJnhsEOq1GKqYkpw77Vi110ucm1bqd6FZy/y0RaMrQvzLuRBh5EQ/osmCQ7IxDm32L3zlWBUyw/XqtHzFjSpZeGGsQ6BdU/Ja0hXZ9V27ITzJhfG+Tx/+ClbhC8XtZhlVP2aKIyzE4dKWNebSNeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIvn+fHY+YZvMYRmLu/+cRYxDy/NDxSFe40zisY7X3c=;
 b=gO+4XaTApJc8Wu5Mo3fiS0MjVqKM6e8ohQzfrxDNM4mwN1EeuMIDa4rSdIBfF6g3+uVCZd+KEh0UWc/OvUY2TuylhWohbVShUbnFMKX/jxeLWYkFkrPGRGkSX1gWLPCxRfVek7i/OS/th0rAtzB2vn/YNoVPRrhisltf8ll5bvGbCCkNrSyvlzSkdq/qt80WDKU7WxyQ/MgP0IB+m2cPcCm1sC8DbOjTawSF8+yAiyLq1HsSaEK69VGY6/b8PKgeF8EUCA5UCBLIfz5DbS1F8Poc+rGhflcNuyAf66xsC3QGRz8xUOyU+QMeJfMCdlvNEmUBSX6Y2+nCS8VdF76UnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIvn+fHY+YZvMYRmLu/+cRYxDy/NDxSFe40zisY7X3c=;
 b=lwzNK1cBV6XSRa3i+NkeJ0+NnPzxoLYDBA6/38sDFxWnr1A5RRGGboidfeIhJb1Ps8hM4PjhR0ktTvqPQP7EKPBE6mEHWWDIHaD0RMsgm65MDOeF/C9TM61l9tM0Jyn0neMNhsdA5AjzCOEeU6wd0juCXMJZkKn6lDP7Sbd4UYU=
Received: from CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 14:10:51 +0000
Received: from CO6PR12MB5441.namprd12.prod.outlook.com
 ([fe80::8937:4064:f4fa:2454]) by CO6PR12MB5441.namprd12.prod.outlook.com
 ([fe80::8937:4064:f4fa:2454%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 14:10:51 +0000
From: "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prica, Nikola" <Nikola.Prica@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
Thread-Topic: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
Thread-Index: AQHa/3HC/oM5fdy9wUGTBgs8g1+KG7JJC32AgAAQR3CAAAbYAIABdbXb
Date: Fri, 6 Sep 2024 14:10:50 +0000
Message-ID: <CO6PR12MB5441B3A86656FFD6D7EE9300E79E2@CO6PR12MB5441.namprd12.prod.outlook.com>
References: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
 <c93d6652-08fd-40fb-a629-d52bec489ede@amd.com>
 <CO6PR12MB54412BC4A08D1335062D28C4E79D2@CO6PR12MB5441.namprd12.prod.outlook.com>
 <b693de66-ecbb-4270-b52b-341a9c69cbe5@amd.com>
In-Reply-To: <b693de66-ecbb-4270-b52b-341a9c69cbe5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-06T14:10:50.424Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5441:EE_|DM4PR12MB6376:EE_
x-ms-office365-filtering-correlation-id: eb490318-a47c-42b5-5ca1-08dcce7db6a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MlGckiPBCyGz4IXJmop11BsLjjWp4lfR85pvu1eo9ygnTXeyKBWyCKHe0OxA?=
 =?us-ascii?Q?v1qHQ/RKuzWIideulABnhfIFxR8Y5zm+Jq9BHp6ObTDp5O59fwCMldF+LsDR?=
 =?us-ascii?Q?G4CT96G0Lw4gWjEJUsyl85Cb6QhD4uyej5MNI5LQq2fK45Ak4i0uIfNQrf4o?=
 =?us-ascii?Q?2gm1gWuq1v7t3TUsFOvQF0vVjkC+yt+mQZFXogvgCm2iZi6ZCGkdM7l7nuV+?=
 =?us-ascii?Q?w28X+zX7quhzoWtxaDU91ZwU0MhcL3NAwB/YJtYnbhvVwRfFOsO05x90vDSH?=
 =?us-ascii?Q?QD+3A5eSJ9/u9J9v3CTSTfOhdjRthCQaoGOa1SGltcOtV8Xnq6WcUxXDIomo?=
 =?us-ascii?Q?MaarokZWjJLNMSVyd2a5tRNJq0mODd3a9AnXcY+gV/8tPAPSovcRYDLEdwfn?=
 =?us-ascii?Q?z43iURqhQ6LLdZgcEr2e1zN7wsnFlyiEWygIhwf8n/CEJoyCrsIwSTihu1gx?=
 =?us-ascii?Q?EktdEw/2bizX4uGcxkw3efWVd53Ws6x7M45xKnWYGlW+clxGRvsK8FeHbrJq?=
 =?us-ascii?Q?CtpLV/XJ0i8dB2tz4WacjX85R8Q94kEZ7QnS017ncoJUbeVcWT+y24uQg9bc?=
 =?us-ascii?Q?KcJqdlGMYr6kU0DahNMzgqZl/oBOJ+V0RuWj0KuJzIfXYkS94R9uWW+3hfmy?=
 =?us-ascii?Q?3PQ2bs94qMEzQ8PrqdBJuMP6hanz+7dfAA9VeMUdr/ycLQmTrOMA/0ampYVz?=
 =?us-ascii?Q?rR1ne3QXUlMBgW1UEr05ha0h2jhhHsVpxgsrEHqi0CgMEzKdunkoLlas83uq?=
 =?us-ascii?Q?HUQ7niQQEVdyqeSF5LD8IWrG18Gk56NsFefDjvoGpZnw9OZQDVbetlYSmWcU?=
 =?us-ascii?Q?zBgKiFO+KejqF+HLguMJu/mJOwZ1tZkSbkUB3s5W94rfvSo3vf46HgA/bDGy?=
 =?us-ascii?Q?Vy3oAokBVjm4z1pR3v9MG9L7uFAHR/MSuvuomtc+ZDBAVAt4Yjp4srHtWehY?=
 =?us-ascii?Q?osWTJKYft/4+tfGDoR9RlAxoF6Kp2OExGeSim4Ohz7/nfts6mBxNREe+aEC+?=
 =?us-ascii?Q?GvqNKcOPDG/xQz0pRQHlUSlkFbhMUXhKURkA8ouMijBp2Rp4ad1rxJxSZ0Om?=
 =?us-ascii?Q?JheR+Zd3ZO6L8GD1SS5EB31/Y810Kt9jPUDB+MlDokgM5FphCX8+MA+Qi0gq?=
 =?us-ascii?Q?vJMTTF0NVE97+34mWCguGENPMF93GLGt4nbVoG5TAbJJXDONln47dtviDpMw?=
 =?us-ascii?Q?+XgTs0eILhStiTkEkO732hD6ZxDCPPUCsBoOOKcj7Ka1DO2fNM02N2kSYUPo?=
 =?us-ascii?Q?aabiWDWa030vOPmpr4OLWgRs19qrEzGYREcD6RAABDKzKfV51O31l3u0lUo1?=
 =?us-ascii?Q?RhrwFh4ZE3ANR2V7rNDF5u+GGJhzk4+JF3bwMMvIsJdd/NImJpVzgVkr3noP?=
 =?us-ascii?Q?3x3b8iqMia8HcnQK1SZ68sJZ8dS5jj4fVsZ18Ga8GDq2sJqnpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5441.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8a93+3P1Tl5u9d3wmUdIGh0CDyJ4R1PJ5+MpiQD7IwC8FtT3a7OwKeQE1Xb?=
 =?us-ascii?Q?vNTYJh67jiAIKyoMGQZQvNBqGJp0Ob9Aj1RPnrB4KKwcnUYlJkd2y9AKPBAg?=
 =?us-ascii?Q?vgXvEzdiAQQgGYBLAL6+wDaJRE1+1DGxTYdx0xfykjHN0FbObOcL4v7SiCJJ?=
 =?us-ascii?Q?BHiIaC7W6rDSFJPnuWg9DbbVoWlCZnYLFPqX+dF+HrXbA4XMYQ6whTyB1Ari?=
 =?us-ascii?Q?cZmYcJZS5nGIOG6zc6WD2m1K+SJqvlVsUDLdLeC29mfS6yMhIe8gLdAq67bi?=
 =?us-ascii?Q?RBsHHsHjmzIp4pctSQAzAAQvZmmge8hJAgl6FUknRw2k/kV0nYo6FSqORrpm?=
 =?us-ascii?Q?OqyRgRSXaxe5SDUBn5Zccn9PWh0iS0F9s0b5OKY+UErWsqzwHvgmak4DXa5d?=
 =?us-ascii?Q?8bLhiTWaWpaQcUny8A/oCGBb8HudNiJvt4EM7jNJpwpMFzbf7dR/C6bT9x31?=
 =?us-ascii?Q?iHR7Yc8YrmBwZ3uQHIMC8wJgIiQzhSHpqjAD9HmnOLJWOtwy/cfeM8dxlnmS?=
 =?us-ascii?Q?YXWnYORuLdrLCHuRCmiopCwxgZeI/JbVOKXTYkCpUtijp47RP8wxth95S61t?=
 =?us-ascii?Q?OcvNTewArhQXOIRXQp8zvC9TdAT4sB/pd56bmZyTWN0Hnzlpn28yUUTNTXyG?=
 =?us-ascii?Q?SiCM1EIS5u6reDS7LOpjhw57H+7wNshgfsgTY8MwILykvjxjQR7HiAqgMz3K?=
 =?us-ascii?Q?AJHewReKELxHGelD2BcIpT/h9mfmJiJQ/lzIQ57IxqFdP3zRDgcnLzcWb8IW?=
 =?us-ascii?Q?0IdfSleWE783Pc9uY0QBGTWxbQgU08GSOrYPuxfK1p0fq7SfPaRK8kFm2CXn?=
 =?us-ascii?Q?luGV1uXZMYlBttV0YqJJpBobN41j6vSoMZtNofLfZAff36tJ7bD3Im9Oa82d?=
 =?us-ascii?Q?O+cSA+mG+a4Gwm9VWjaq1QoGmdgEAZlbee2eA8yNtgadJIxxR6PJsOtL1Wrx?=
 =?us-ascii?Q?lJMfOy5uuLOJQ6yH3jsoDexgKM9/ym7BA1ykBYcKMahTsgtiHme89l1x61+F?=
 =?us-ascii?Q?p61yHH/MfLHvWS9/e9u2I0EZ+HP3W64rOx6xu7ji6fcVpdym/neWDnrtqsKQ?=
 =?us-ascii?Q?ZP3mB1UHz0VQyD8MXCtKN9YhhKTDDDbKeK7vj7BZmuOWfXuP8jlCrUj/VVqE?=
 =?us-ascii?Q?7E2Y0F9IBxepA3FcIsbx4Hv7yCUJlYz8jmepCiKubgu6buk/7DKT/GBKEWVx?=
 =?us-ascii?Q?GI8R+CRbSTsY+csqgfVnBri2/zKY7GCcHYxdLtv1EmR7k7qN9GJjJXRTdKg6?=
 =?us-ascii?Q?/mmjTQ9WWzoDk7bRb4HXhTrnolHLQOZmsqGT77SgvIstDUZs5nUDUb0oFDyG?=
 =?us-ascii?Q?PZwqigFbclseeU+QqeuBlzmEv+vsyICB4c+gMqZFt05AinK15IR4mXi/8TEP?=
 =?us-ascii?Q?iRLQJCJrpyJBOad2hoTpxBLSIC1mJg6XdIncvz0W5YsK53rXtnPZj/mXN6Et?=
 =?us-ascii?Q?mxGXUByxTxJDlRtzuGZmQEWGvmjWw0K17o6lHB2iMuYm7c+gq6vBzYR+SHcw?=
 =?us-ascii?Q?W5N5MwWg+cIDMvqpWmHtwDqccRDVE9nsxH1dUKgp6e5cBrsI65Qstuuf3rjl?=
 =?us-ascii?Q?Qb+nIrvBJmcmZFnNNFw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5441B3A86656FFD6D7EE9300E79E2CO6PR12MB5441namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5441.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb490318-a47c-42b5-5ca1-08dcce7db6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 14:10:50.9702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTJIWMH8ZB/6tMlGor1fdUt4JMHvrQrpVP8Mq1EMQnCQsrtRpUGBTkIsz9C3zVUtYxeveFUxZP3buNBEW0xS6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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

--_000_CO6PR12MB5441B3A86656FFD6D7EE9300E79E2CO6PR12MB5441namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I might have worded that poorly, I meant that it seems like TLB flush is ou=
t of sync with the SDMA update, which leads to a page fault reliably. I don=
't feel it has anything to do with the implicit sync in itself. When TLB fe=
nce is created it's added to the dma_resv of the vm's root buffer object wi=
th BOOKKEEP usage specified, in order to make sure no PD/PT is freed before=
 the flush. But I don't think it's being added as a job dependency within t=
he amdgpu_vm_sdma_update, we're adding all the fences found within the dma_=
resv object with KERNEL usage specified. I may be missing something so I'd =
love to hear what you think.

Best regards,
Dejan
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, September 5, 2024 2:40 PM
To: Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Prica, Nikola <Nikola.Prica@amd.com>; Kuehling, Felix <Felix.Kuehling@a=
md.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence

Well that explanation doesn't seem to make much sense either.

What do you mean with TLB flush is occurring prematurely?

Regards,
Christian.

Am 05.09.24 um 14:38 schrieb Andjelkovic, Dejan:

[AMD Official Use Only - AMD Internal Distribution Only]

Hi there. We're running into a page fault issue that's very easily reproduc=
ible on a SRIOV environment when using SDMA for page table updates. Going t=
hrough mapping logs and trace files, it seems TLB flush is occurring premat=
urely. Changing the usage to KERNEL completely stops the page fault from oc=
curring with no performance impact, which was confirmed with extensive test=
ing. Looking through amdgpu_vm_sdma.c, namely within amdgpu_vm_sdma_update =
when waiting for PD/PT moves to be completed, fences are iterated with KERN=
EL usage specified which are then added as a job dependency.

Best regards,
Dejan
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Thursday, September 5, 2024 1:17 PM
To: Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com><mailto:Dejan.Andjelkovic=
@amd.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Prica, Nikola <Nikola.Prica@amd.com><mailto:Nikola.Prica@amd.com>; Kueh=
ling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>; Deng, =
Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence

Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:
> When using SDMA for PT updates, a TLB fence hooked to a buffer
> objects dma resv object with usage declared as BOOKKEEP leaves a
> chance for TLB flush to occur prematurely. This will lead to a page
> fault. Raising the usage from BOOKKEEP to KERNEL removes this
> possibility.

Well that's complete nonsense. The usage model is for implicit syncing
and not even remotely related to TLB flushing.

What exactly is the problem you run into?

Regards,
Christian.

>
> Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com><mailto:Dejan=
.Andjelkovic@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index f93804902fd3..8efc2cf9bbb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *p=
arams,
>
>                /* Makes sure no PD/PT is freed before the flush */
>                dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> -                                DMA_RESV_USAGE_BOOKKEEP);
> +                                DMA_RESV_USAGE_KERNEL);
>        }
>   }
>



--_000_CO6PR12MB5441B3A86656FFD6D7EE9300E79E2CO6PR12MB5441namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I might have worded that poorly, I meant that it seems like TLB flush is ou=
t of sync with the SDMA update, which leads to a page fault reliably. I don=
't feel it has anything to do with the implicit sync in itself. When TLB fe=
nce is created it's added to the
 dma_resv of the vm's root buffer object with BOOKKEEP usage specified, in =
order to make sure no PD/PT is freed before the flush. But I don't think it=
's being added as a job dependency within the amdgpu_vm_sdma_update, we're =
adding all the fences found within
 the dma_resv object with KERNEL usage specified. I may be missing somethin=
g so I'd love to hear what you think.<br>
<br>
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Dejan</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 5, 2024 2:40 PM<br>
<b>To:</b> Andjelkovic, Dejan &lt;Dejan.Andjelkovic@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Prica, Nikola &lt;Nikola.Prica@amd.com&gt;; Kuehling, Felix &lt;=
Felix.Kuehling@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TL=
B fence</font>
<div>&nbsp;</div>
</div>
<div>Well that explanation doesn't seem to make much sense either.<br>
<br>
What do you mean with TLB flush is occurring prematurely?<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 05.09.24 um 14:38 schrieb Andjelkovic, =
Dejan:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hi there. We're running into a page fault issue that's very easily reproduc=
ible on a SRIOV environment when using SDMA for page table updates. Going t=
hrough mapping logs and trace files, it seems TLB flush is occurring premat=
urely. Changing the usage to KERNEL
 completely stops the page fault from occurring with no performance impact,=
 which was confirmed with extensive testing. Looking through amdgpu_vm_sdma=
.c, namely within amdgpu_vm_sdma_update when waiting for PD/PT moves to be =
completed, fences are iterated with
 KERNEL usage specified which are then added as a job dependency.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Best regards,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Dejan</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig@amd.co=
m">&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Sent:</b> Thursday, September 5, 2024 1:17 PM<br>
<b>To:</b> Andjelkovic, Dejan <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:Dejan.Andjelkovic@amd.com">
&lt;Dejan.Andjelkovic@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviat=
ed" href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Prica, Nikola <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:Nikola.Prica@amd.com">
&lt;Nikola.Prica@amd.com&gt;</a>; Kuehling, Felix <a class=3D"x_moz-txt-lin=
k-rfc2396E" href=3D"mailto:Felix.Kuehling@amd.com">
&lt;Felix.Kuehling@amd.com&gt;</a>; Deng, Emily <a class=3D"x_moz-txt-link-=
rfc2396E" href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TL=
B fence</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:<=
br>
&gt; When using SDMA for PT updates, a TLB fence hooked to a buffer<br>
&gt; objects dma resv object with usage declared as BOOKKEEP leaves a<br>
&gt; chance for TLB flush to occur prematurely. This will lead to a page<br=
>
&gt; fault. Raising the usage from BOOKKEEP to KERNEL removes this<br>
&gt; possibility.<br>
<br>
Well that's complete nonsense. The usage model is for implicit syncing <br>
and not even remotely related to TLB flushing.<br>
<br>
What exactly is the problem you run into?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Dejan Andjelkovic <a class=3D"x_moz-txt-link-rfc2396E" =
href=3D"mailto:Dejan.Andjelkovic@amd.com">
&lt;Dejan.Andjelkovic@amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index f93804902fd3..8efc2cf9bbb0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params=
 *params,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Makes sure no PD/PT is freed before the flush */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *f=
ence,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_RESV_USAGE_BOOKKEEP);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_RESV_USAGE_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB5441B3A86656FFD6D7EE9300E79E2CO6PR12MB5441namp_--
