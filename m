Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B3C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778FD610CD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778FD610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EDB6E039;
	Wed, 19 May 2021 03:03:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACB56E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 03:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cStdYz7iKHFw84hLdL1ncxXYtKuPPwnVq8BDxF9hiUDOraKv8Sn9Y0YnmMEn81eATM1E0LG4/YClJo2hbiJ+we+s+HhDrMnyBSfJjhTMiphMFeTuSRVT8JE+LwaPxf0VnzV/4At2T7JzIH2sx1xMQpShVrc7sgVQYXMT0VtGUFuBKBCgelczBCwhPS6Fuaf7cR17+hM6mel4TNhy2cLPsoshxhrOVoC+vzf4dM7/+KMAMOw9t05MOMXsmVGkphFeHc7Z4FWoCoiWmMB5yXkrdxtyY7pru+qyNKvgONNqaQjiKU27AUgUKhknmJ9+weVKEXAIor2pWc/KtnXm9lWsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2RizyX5vjz8V4Rk84gDv1X9k2Z+51aVBVTrI9yDQJ4=;
 b=DfW+OsA24RhIbfjI4w+YC++ePePiZfNc5oCZWKF9wPCbwYfqVXJ1frvXu+Yof7PlZ7ODQO1uuDRQ1gDNeoArWYc31ovIrGTc0glFOD4Pq2ZYs4bJQ58qbTfUNAx+x0T0ftM5Tm6376pnoIP231G3SS/7GeCDwCyuPmVB0rkNCQtECwm6n+4/4jcslIWMc0vPTLs3/owVCf5MvvyrMeIKKOvEXHkvkh/CkxXBnYMx+Dw65WcQsq68zihef8mqx86aukwy7zHvoVLrd4ebXQlXpBK58WtetQMyNgIwU+UAIVJWlX6JGwHBEwlHdsCKE4nsgmbM3F2k6yOYXC2DbkCtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2RizyX5vjz8V4Rk84gDv1X9k2Z+51aVBVTrI9yDQJ4=;
 b=vwbg7l68k/y4Q5IbnjnX0W+jPsGCenSrcdv3EAlDMJRMZbxHv11FxuLstPPet5Ewjtq6vp7L5IrCVSOF7fabDYM/Rndea908qYUVYUMc+SRkJ/wSzq57CWEh9ir0HjjmcthFBs8LWkSkz3VFYXajgxyfSUg3v8UVK//IKON1PBU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 03:03:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 03:03:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhu, Changfeng"
 <Changfeng.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Topic: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Index: AQHXSJn7ZKzTtOpbdU+CrPUZHuAuKqrjBYuAgAQ0pgCAABx1gIACwwoAgAACdICAAAYZc4AAAXgAgAABXACAAABz3A==
Date: Wed, 19 May 2021 03:03:54 +0000
Message-ID: <MN2PR12MB448886D0F0CD237D056B3445F72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>,
 <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <MN2PR12MB448807A739B82ED7721E4A5EF72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>,
 <CY4PR12MB12873E4A35B066FB196E4C87F12B9@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12873E4A35B066FB196E4C87F12B9@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-19T03:03:53.925Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [204.111.139.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb449df9-379e-44c8-81cf-08d91a72bce9
x-ms-traffictypediagnostic: MN2PR12MB4487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4487B5D4264C5D1C84419122F72B9@MN2PR12MB4487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkGLbq0/db/5pYkRiqiWXlhAOUUwOoDPyc8MElyyIBBtwtsK8zi+CJGSqGy2gTP2qQnMxFmHOHWHk8bmW8NvNB+lYsXfK2bBBp3z3yDRh+uGzoYlNjo+cw5kKEJqXv0bS3J6p2d0py0SWdvqTHGFADKzskDzzqV/PYFVp3F+5kP4Z1KIAg5fADKrIDKDHYsLcUyYrapWdwFM98gDD8HrwY91qb9E0WKZBA5rEZ+l49jz0z8yGtHP8L3qJq7Z7onQW49h62aaTnOb7HJPpCxLXVcsCAhaRswr+2qn3mMQz2SPDmtzEQCQhMVktWjEU98fRtBf9mu5NYgJVR32E6Lb7m5yliYvYZJW4s+1tteRUh9RcsJ1M+YkPSMo7ZQ5chUWuDAQCyErVxTZRPcqnfLmzpLis15mIwYcTMUiBItT8hfNxC7IOvIR0yngmgNErv2mQ1DXXplJn9/jaiMxOycFEjLfjgV9SkNwFkayvtb5XDsuo39P84Qm+Wvc2zcE2v4TpDQFK/RIhPCTGv41TrKLRMPOAxN7IziV/b9chaqRW3c8sEMz8TzHkHqAqNIyVWRE93w6453lt4HgIcIdquOcY2e4BwF/GuDroNzw1FjzQOReULIcsISYAjJUIeCfG7FdAIoolFX8gWuufj02yxG4Qy+Lb89/y4ahEsY1PxU7kO2lYrmq6XnG3qKynC+mEaOu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(110136005)(54906003)(8676002)(76116006)(71200400001)(166002)(26005)(66946007)(52536014)(83380400001)(19627405001)(19627235002)(498600001)(6506007)(66556008)(66476007)(8936002)(66446008)(122000001)(64756008)(7696005)(55016002)(9686003)(2906002)(45080400002)(86362001)(6636002)(186003)(38100700002)(4326008)(33656002)(966005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?dfuYvEe3qlAEQXlX/IX79rcArqw/wdsFL3dfJ5yydyIxSfD3y4O9Wfq0?=
 =?Windows-1252?Q?w6dukEG8vtbkQJlLmK8p7QxDswQKXWr37JPv/A81YO6OZHTJSF6hfMar?=
 =?Windows-1252?Q?T4f58ylRErwU38HBJxpEs0nypgdhBBCdhmQazKDiYQ4Vt06hiogtyRh/?=
 =?Windows-1252?Q?Cu/Vu6X8UELQ7/t6YGNR7IbEQJrWTbcS1EFthYjhh+Q/br4BQz1ezPYO?=
 =?Windows-1252?Q?Vl5aZea9COrpO+wDmvPEYvZs7Hc2UhHnRTDo4ZCh1+Q6d3isgNmXXV/0?=
 =?Windows-1252?Q?qzLcjpcqcgzLMdoCTVVPl64ML8oN8RZ61qRiCobZA+QooIqzg0/O6tFT?=
 =?Windows-1252?Q?CVZQVjNNINkshYxlxQgsmtvEzCvilCZR7PVxf1oijUBV/X27XeM/iNyQ?=
 =?Windows-1252?Q?FGyEMDy1qIowO+k8WfHHkDTEqQlR+796/1DmQCI/eEo0byfoj+JMnM7+?=
 =?Windows-1252?Q?3lU4bOaIztxzCWxtdNCfmurFfvqx+Fm9VspTJl1aKluINk4xvO+1UDCH?=
 =?Windows-1252?Q?kvdp5I6Fh+wXEzmYgcGAVq4octx+IZpEr0WRjt2GYYxw0FBLO0u38NFT?=
 =?Windows-1252?Q?tx8NNS+W8p9JmrwRv6pcyEn9Y4mxaYtMPGcKCt9Mwvo0f46eEhYyndvP?=
 =?Windows-1252?Q?LoKpmr69dW9TSIBikxWCqjJJrGu0BqSTUSdB9oLToqpYxtfb1sVXxlOT?=
 =?Windows-1252?Q?MER9z/lhiEZW7fHExrTQ3IXyP5yF3mv2PuUwDSHsG3hR0s/Wz4/gGSRV?=
 =?Windows-1252?Q?XAnaaH+ba8iZ7waDsjaESdcjnOMoH2OANE6Sakh684Cb9QZId3l8UAk7?=
 =?Windows-1252?Q?1yIsG4u/rkk6lzPnaZuquv9HubUTh9eblphB0FbQ0sWdXXgOhwYdKmVa?=
 =?Windows-1252?Q?F/NGCJlIOVqlmnNkJseda60qABo6MhgJdJzJiFBHyopI4mW9QlBG9QR8?=
 =?Windows-1252?Q?3aS8SkwUCXz58N6R2DHIErA4/8JSbM3CoBVG4gdYzJ/yFXyW2Edo2n/B?=
 =?Windows-1252?Q?D3r1myoa9gYTWuyzG0HMI58SQ3aNKFedEIw+dSS2z501aZXbWIY5O5Nr?=
 =?Windows-1252?Q?MkQKJ9TSa9TekDfkJz2Y36xyx6KyxRhqiB4T1ftczNxARTR6hKa5u2N4?=
 =?Windows-1252?Q?i00MSwXXbvhWgCUc7X3R3m10ygxEoeZ+7WbhnUfoche3JYAj+NGHdpnh?=
 =?Windows-1252?Q?xrPx59F8CzwRpEuLJzLsl9ns5L05MZCIz9d+k9wcw2H0+jfd1qG+yWR3?=
 =?Windows-1252?Q?cr0p59aBJC9pYon5oC55T9bef6OCut+gVm0V91OYhaoZ0ZpVznamjCSP?=
 =?Windows-1252?Q?b1Aytsr3tVUPoh2VKXSyohEh8I3VLvqBJB0fuRVQGVTJNjEhXgZh55T+?=
 =?Windows-1252?Q?N+mkmay6YLSF2LmKsRz2IoWHcIYhhL1wZJ/2N8s2pn7wfc7r8vzjbc3F?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb449df9-379e-44c8-81cf-08d91a72bce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 03:03:54.5618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJWwCKs5qwswPf+88XmdJvWpDoue/LfarQZcez79FvTuR0prMoecNRvCetryKNzutplnqRcZHQdXJ05LVWgfbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0545802079=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0545802079==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448886D0F0CD237D056B3445F72B9MN2PR12MB4488namp_"

--_000_MN2PR12MB448886D0F0CD237D056B3445F72B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

I thought we had disabled all but one of the compute queues on raven due to=
 this issue or at least disabled the schedulers for the additional queues, =
but maybe I'm misremembering.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, May 18, 2021 11:00 PM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Das, Nirmoy <Nirmoy.=
Das@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang


[Public]


Nirmoy=92s patch landed already if I understand correctly.



d41a39dda140 drm/scheduler: improve job distribution with multiple queues



Regards,

Guchun



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhu, Cha=
ngfeng
Sent: Wednesday, May 19, 2021 10:56 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Alex Deucher <alexdeuch=
er@gmail.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang



[Public]



[Public]



Hi Alex,



This is the issue exposed by Nirmoy's patch that provided better load balan=
cing across queues.



BR,

Changfeng.



From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Wednesday, May 19, 2021 10:53 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>; A=
lex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; Das, Nir=
moy <Nirmoy.Das@amd.com<mailto:Nirmoy.Das@amd.com>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; amd-gfx list =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang



[Public]



+ Nirmoy



I thought we disabled all but one of the compute queues on raven due to thi=
s issue.  Maybe that patch never landed?  Wasn't this the same issue that w=
as exposed by Nirmoy's patch that provided better load balancing across que=
ues?



Alex



________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhu, Changfeng <Changfeng.Zhu@amd.com=
<mailto:Changfeng.Zhu@amd.com>>
Sent: Tuesday, May 18, 2021 10:28 PM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; amd-gfx list =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang



[AMD Official Use Only - Internal Distribution Only]

Hi Alex.

I have submitted the patch: drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang

Do you mean we have something else to do for re-enabling the extra compute =
queues?

BR,
Changfeng.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Sent: Wednesday, May 19, 2021 10:20 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; amd-gfx list =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang

Care to submit a patch to re-enable the extra compute queues?

Alex

On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng <Changfeng.Zhu@amd.com<mailt=
o:Changfeng.Zhu@amd.com>> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Ray and Alex,
>
> I have confirmed it can enable the additional compute queues with this pa=
tch:
>
> [   41.823013] This is ring mec 1, pipe 0, queue 0, value 1
> [   41.823028] This is ring mec 1, pipe 1, queue 0, value 1
> [   41.823042] This is ring mec 1, pipe 2, queue 0, value 1
> [   41.823057] This is ring mec 1, pipe 3, queue 0, value 1
> [   41.823071] This is ring mec 1, pipe 0, queue 1, value 1
> [   41.823086] This is ring mec 1, pipe 1, queue 1, value 1
> [   41.823101] This is ring mec 1, pipe 2, queue 1, value 1
> [   41.823115] This is ring mec 1, pipe 3, queue 1, value 1
>
> BR,
> Changfeng.
>
>
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>
> Sent: Monday, May 17, 2021 2:27 PM
> To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; Z=
hu, Changfeng
> <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.free=
desktop.org>>
> Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to
> avoid compute hang
>
> On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> > On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com<mailto:changfeng=
.zhu@amd.com>> wrote:
> > >
> > > From: changzhu <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
> > >
> > > From: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
> > >
> > > There is problem with 3DCGCG firmware and it will cause compute
> > > test hang on picasso/raven1. It needs to disable 3DCGCG in driver
> > > to avoid compute hang.
> > >
> > > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@=
amd.com>>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.d=
eucher@amd.com>>
> >
> > WIth this applied, can we re-enable the additional compute queues?
> >
>
> I think so.
>
> Changfeng, could you please confirm this on all raven series?
>
> Patch is Reviewed-by: Huang Rui <ray.huang@amd.com<mailto:ray.huang@amd.c=
om>>
>
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> > >  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 22608c45f07c..feaa5e4a5538 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(str=
uct amdgpu_device *adev,
> > >         amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >
> > >         /* Enable 3D CGCG/CGLS */
> > > -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) =
{
> > > +       if (enable) {
> > >                 /* write cmd to clear cgcg/cgls ov */
> > >                 def =3D data =3D RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_=
OVERRIDE);
> > >                 /* unset CGCG override */ @@ -4959,8 +4959,12 @@
> > > static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *ade=
v,
> > >                 /* enable 3Dcgcg FSM(0x0000363f) */
> > >                 def =3D RREG32_SOC15(GC, 0,
> > > mmRLC_CGCG_CGLS_CTRL_3D);
> > >
> > > -               data =3D (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDL=
E_THRESHOLD__SHIFT) |
> > > -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > > +                       data =3D (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG=
_GFX_IDLE_THRESHOLD__SHIFT) |
> > > +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               else
> > > +                       data =3D 0x0 <<
> > > + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > > +
> > >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> > >                         data |=3D (0x000F << RLC_CGCG_CGLS_CTRL_3D__C=
GLS_REP_COMPANSAT_DELAY__SHIFT) |
> > >
> > > RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > index 4b660b2d1c22..080e715799d4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle=
)
> > >                         adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS | @@
> > > -1413,7
> > > +1412,6 @@ static int soc15_common_early_init(void *handle)
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_RLC_LS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > li
> > > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C0
> > > 1%
> > > 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961
> > > fe
> > > 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CT
> > > WF
> > > pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > > CI
> > > 6Mn0%3D%7C1000&amp;sdata=3DlBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2
> > > BV
> > > 7pSY%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp;reserved=3D0<https=
://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freede=
sktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Cguchun.chen%40amd=
.com%7C3fc7a549816d4c8061c008d91a719cb8%7C3dd8961fe4884e608e11a82d994e183d%=
7C0%7C0%7C637569897555065647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DYTC%2FvVR%2BbPK=
w9JKayhmHapRkkEFaczoGzJJ3jFJqBAM%3D&reserved=3D0>

--_000_MN2PR12MB448886D0F0CD237D056B3445F72B9MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I thought we had disabled all but one of the compute queues on raven due to=
 this issue or at least disabled the schedulers for the additional queues, =
but maybe I'm misremembering.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 11:00 PM<br>
<b>To:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.com&=
gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx list &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle21
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt">
[Public]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Nirmoy=92s patch landed already if I understand co=
rrectly.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">d41a39dda140 drm/scheduler: improve job distributi=
on with multiple queues</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Guchun</p>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.fre=
edesktop.org&gt;
<b>On Behalf Of </b>Zhu, Changfeng<br>
<b>Sent:</b> Wednesday, May 19, 2021 10:56 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Alex Deuch=
er &lt;alexdeucher@gmail.com&gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br=
>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx list &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Hi Alex,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">This is the issue exposed by <span style=3D"font-s=
ize:12.0pt; color:black">
Nirmoy's patch that provided better load balancing across queues.</span></p=
>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">BR,<=
/span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Chan=
gfeng.</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Deucher, Alexander &lt;<a href=3D"mai=
lto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, May 19, 2021 10:53 AM<br>
<b>To:</b> Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chan=
gfeng.Zhu@amd.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher@g=
mail.com">alexdeucher@gmail.com</a>&gt;; Das, Nirmoy &lt;<a href=3D"mailto:=
Nirmoy.Das@amd.com">Nirmoy.Das@amd.com</a>&gt;<br>
<b>Cc:</b> Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">+ Ni=
rmoy</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">I th=
ought we disabled all but one of the compute queues on raven due to this is=
sue.&nbsp; Maybe that patch never landed?&nbsp; Wasn't this the same issue =
that was exposed by Nirmoy's patch that provided
 better load balancing across queues?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Alex=
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf=
 of Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Z=
hu@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 10:28 PM<br>
<b>To:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;<br>
<b>Cc:</b> Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
Hi Alex.<br>
<br>
I have submitted the patch: drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang<br>
<br>
Do you mean we have something else to do for re-enabling the extra compute =
queues?<br>
<br>
BR,<br>
Changfeng.<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher=
@gmail.com</a>&gt;
<br>
Sent: Wednesday, May 19, 2021 10:20 AM<br>
To: Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Z=
hu@amd.com</a>&gt;<br>
Cc: Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd.com</=
a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">a=
md-gfx@lists.freedesktop.org</a>&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang<br>
<br>
Care to submit a patch to re-enable the extra compute queues?<br>
<br>
Alex<br>
<br>
On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng &lt;<a href=3D"mailto:Changf=
eng.Zhu@amd.com">Changfeng.Zhu@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;<br>
&gt; Hi Ray and Alex,<br>
&gt;<br>
&gt; I have confirmed it can enable the additional compute queues with this=
 patch:<br>
&gt;<br>
&gt; [&nbsp;&nbsp; 41.823013] This is ring mec 1, pipe 0, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823028] This is ring mec 1, pipe 1, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823042] This is ring mec 1, pipe 2, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823057] This is ring mec 1, pipe 3, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823071] This is ring mec 1, pipe 0, queue 1, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823086] This is ring mec 1, pipe 1, queue 1, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823101] This is ring mec 1, pipe 2, queue 1, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823115] This is ring mec 1, pipe 3, queue 1, value 1<=
br>
&gt;<br>
&gt; BR,<br>
&gt; Changfeng.<br>
&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;<br>
&gt; Sent: Monday, May 17, 2021 2:27 PM<br>
&gt; To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeuc=
her@gmail.com</a>&gt;; Zhu, Changfeng
<br>
&gt; &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Zhu@amd.com</a>=
&gt;<br>
&gt; Cc: amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">=
amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to <=
br>
&gt; avoid compute hang<br>
&gt;<br>
&gt; On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:<br>
&gt; &gt; On Fri, May 14, 2021 at 4:20 AM &lt;<a href=3D"mailto:changfeng.z=
hu@amd.com">changfeng.zhu@amd.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: changzhu &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">=
Changfeng.Zhu@amd.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com"=
>Changfeng.Zhu@amd.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There is problem with 3DCGCG firmware and it will cause comp=
ute <br>
&gt; &gt; &gt; test hang on picasso/raven1. It needs to disable 3DCGCG in d=
river <br>
&gt; &gt; &gt; to avoid compute hang.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87<br>
&gt; &gt; &gt; Signed-off-by: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu=
@amd.com">Changfeng.Zhu@amd.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher=
@amd.com">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; WIth this applied, can we re-enable the additional compute queues=
?<br>
&gt; &gt;<br>
&gt;<br>
&gt; I think so.<br>
&gt;<br>
&gt; Changfeng, could you please confirm this on all raven series?<br>
&gt;<br>
&gt; Patch is Reviewed-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.co=
m">ray.huang@amd.com</a>&gt;<br>
&gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---<=
br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp; |=
&nbsp; 2 --<br>
&gt; &gt; &gt;&nbsp; 2 files changed, 7 insertions(+), 5 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; index 22608c45f07c..feaa5e4a5538 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_g=
ating(struct amdgpu_device *adev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_r=
lc_enter_safe_mode(adev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable 3D=
 CGCG/CGLS */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; =
(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_3D_CGCG)) {<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write cmd to clear cgcg/cgls ov */<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15(GC, 0, mm=
RLC_CGTT_MGCG_OVERRIDE);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unset CGCG override */ @@ -4959,8 +4=
959,12 @@ <br>
&gt; &gt; &gt; static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_de=
vice *adev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable 3Dcgcg FSM(0x0000363f) */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D RREG32_SOC15(GC, 0, <br>
&gt; &gt; &gt; mmRLC_CGCG_CGLS_CTRL_3D);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (0x36 &lt;&lt; RLC_CGCG_CGLS_CTRL_3D__CG=
CG_GFX_IDLE_THRESHOLD__SHIFT) |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
LC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_3D=
_CGCG)<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata =3D (0x36 &lt;&lt; RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIF=
T) |<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC_CGCG_CGLS_CTRL_3D__CGCG_=
EN_MASK;<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata =3D 0x0 &lt;&lt; <br>
&gt; &gt; &gt; + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPP=
ORT_GFX_3D_CGLS)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data |=3D (0x000F &lt;&lt; RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANS=
AT_DELAY__SHIFT) |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; &gt; &gt; RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; index 4b660b2d1c22..080e715799d4 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(voi=
d *handle)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_MGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CP_LS |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX_3D_CGCG |=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_3D_CGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGCG |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGLS | @@ <br>
&gt; &gt; &gt; -1413,7<br>
&gt; &gt; &gt; +1412,6 @@ static int soc15_common_early_init(void *handle)<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_MGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_RLC_LS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CP_LS |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX_3D_CGCG |=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_3D_CGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGCG |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGLS |<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.17.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; amd-gfx mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lis=
ts.freedesktop.org</a><br>
&gt; &gt; &gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2F">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F</a><br=
>
&gt; &gt; &gt; li <br>
&gt; &gt; &gt; sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D04%7C0<br>
&gt; &gt; &gt; 1% <br>
&gt; &gt; &gt; 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3=
dd8961<br>
&gt; &gt; &gt; fe <br>
&gt; &gt; &gt; 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnkno=
wn%7CT<br>
&gt; &gt; &gt; WF <br>
&gt; &gt; &gt; pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXV<br>
&gt; &gt; &gt; CI <br>
&gt; &gt; &gt; 6Mn0%3D%7C1000&amp;amp;sdata=3DlBzswAPBguL0mWFglEk%2Bg2eDCEu=
hir7JfFjov%2<br>
&gt; &gt; &gt; BV<br>
&gt; &gt; &gt; 7pSY%3D&amp;amp;reserved=3D0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Cguchun.chen%40amd.com%7C3fc7a549816d4c8061c008d91a719cb8%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637569897555065647%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3DYTC%2FvVR%2BbPKw9JKayhmHapRkkEFaczoGzJJ3jFJqBAM%3D&amp;reserved=3D=
0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Ca=
lexander.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;amp;sdata=3D33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp;amp;res=
erved=3D0</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB448886D0F0CD237D056B3445F72B9MN2PR12MB4488namp_--

--===============0545802079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0545802079==--
