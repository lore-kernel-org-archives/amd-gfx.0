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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB58C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1492C61209
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1492C61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8C789A77;
	Wed, 19 May 2021 03:00:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D9589A77
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 03:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9EFYkhlg8F8LuNJYyeibQgDyUldRW82jt/5AWtCZ2rek9pgcXVu0majX8hAxJjYr8up0GZW28dU3iH8nR+JamcRqsJ2pc0THXNikWts6Pg04QCbf4N24X8NC3rhy+Ji07au+7yAuJ72rrYGzFW+x+B4+ENNnBuNfqTefgAPzsUZFcfIv1vpiFPQG/2gLeEL0MJhuIrp5CxtPZpKRCyYXg6aPYA7cDTlMyxNI+Jee01FMUo6FN+MTgLyCMfrngzXVl6JQKC1j9vjlkOQ9ShVa6YUkvIojKhMXVSSHJBFyRcQ8U+Eo3TTZgTzna0LE9h+lCzZ2LhLi2oYHrl+bBCZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAlzRTLqJrW7BM9XqBW0kODwgQAhHBDQGBuYXzZeC2M=;
 b=mUtgF/IKLmIWrmuMd7P5AlS4LyrhaDv8ta9ndr9dIfOEzuZU1Pew/NWyBh6lWzsWpfKFaMpjPC+lLTWT4t55rgsVChr+5RweQjhnuZvcLvZKng1zO3lmV7OADE2l0iqUu3VkBgISelXgzuxjVzsNlVq4l4nBWlQ6GuwaFHnDgf/Tnp7CDME3o6WKp36A9Gdye52nrl73PVOYHLdVl7hvSVDe+lu9LN4PAaNzNwzRYbEYNMUzVXSwaPvevw0ZHlZbIBjsT0r1LqF43Zxh6jtWe7/VENb1Q6K2f8v3bPMi2p2NXMcJlfbLGODcQ0eKzLjYVw18mlBTKiCXfqGOLeqsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAlzRTLqJrW7BM9XqBW0kODwgQAhHBDQGBuYXzZeC2M=;
 b=h/X/kY1j+Ax3jdmSleiq5WUrZ2XfEswB7l+IWtdKMK0Bqd4JsJE+afgOQBIavIocppnLDBDAvfwNYI4ZBS3aTn6mtA+zTfQw1edVQ7yGn8fk+meGmMQ/siKmV1mWsBskfVfZWDno+dNlDKuuXIwW5LVMUWw0DbAa6DvHA2KNAqU=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 03:00:35 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 03:00:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Topic: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Index: AQHXSJn7vk+e1kNqVEOtUEdmqmqf56rjBYuAgAQ0pgCAABx1gIACwwoAgAACdICAAAa+gIAAANMAgAAAkvA=
Date: Wed, 19 May 2021 03:00:34 +0000
Message-ID: <CY4PR12MB12873E4A35B066FB196E4C87F12B9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>,
 <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <MN2PR12MB448807A739B82ED7721E4A5EF72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-19T02:52:44.691Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b604d9a5-4ce0-4887-d7e2-08d91a7245df
x-ms-traffictypediagnostic: CY4PR12MB1623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB162332F7D5AB966B421298D4F12B9@CY4PR12MB1623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yhi+Tm7O6iruvFCXXD/ONmYUaf5YIonmTVFV1iD5uEWFKO7niFBCI/f/lc6J/QhJDAnA8yspPxaQt1zNDIGGSK9ZjLE1OfcrSVQ+KOJYLKVFKI8MkcULt5hHrBaHQ4mfFN6Nt/KaScuic8KLxw9YKiWMcFyWaTmLCqujt7oG+YQ3xyjCwouHXStb7wOmSYnZACg7ViDWruAr9xTfhvmk+xOBesQVoqnNAepdIp5KTVBTi3dQ99rqlfcWX5nDOxCL8gmy1lOZK5s3qLrn/xII2ME3q6c/9A+/DrH0rPS/Fl+S5/PVkXj/+2EX5NCxsrEXWhBaJbiibRheF3qaK6PGkKFNnqHgKVq4jt61wiEMFFpMSAtdEQvb8PBZZXmazRM6NK/x0mg2b11edQYkoSpfxixIEtQ729azDtYh99s8qC+SOfzufELao6r6iPgPMg5LLKihrLIm4X0APWsx9gGsxiZIyGy3XzQ5fL8IRgPQfkPjBw9RI3M/fSvJZipyVa27kZRcAEzEriCRkPaJnpTtro8z640uhremlm3Y0Ag7b43/41BTQQ5y2+TMczU+YTN4FSvRMoyuB9IVhvvORXDVsGiV9iSfmay74X4l+IREo4ntABgQaMm70NN1KWB4Uo/+0/TaSWxMl+FmgM7UsDYaYQz2GJ/uWcrO9Vm7FlNr7AiE7sPBw1JnA8D9wk+xietS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(86362001)(110136005)(54906003)(2906002)(7696005)(186003)(66946007)(66476007)(6636002)(66446008)(66556008)(64756008)(38100700002)(9686003)(122000001)(71200400001)(33656002)(55016002)(76116006)(478600001)(316002)(45080400002)(53546011)(6506007)(8676002)(4326008)(966005)(83380400001)(166002)(8936002)(5660300002)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?46/JwkL7PRIw96gYhJyMR9I5qzGQtdAXxsbMe3BccDwY/Sg1/Q/SW3oKmzc3?=
 =?us-ascii?Q?lZBvG8n7jXCw8y/VAT0f1h6mQSiJ+ZqrWaxTbG38MAlcNL2646eZcX0MnCKq?=
 =?us-ascii?Q?5mjb/hNyRGFVAEBUB3tyHt3W1w0/2dI/dOkDyZik8HXmHDg1c0p+NYSzwrhU?=
 =?us-ascii?Q?OMi7psx5t/QxmmuZ622rWAZ/rNELpvPrJTdvoA4zmG3vOk/gBF3/hH7PqZd5?=
 =?us-ascii?Q?3vI22ZnpEy+mPvM3N2F8w3UB3oz2k/MZDkocsME+NPZjgLJH+dqiJ1RArWCN?=
 =?us-ascii?Q?+zXP2wtRk7+FSEWW5bvIUvEIK0k4hfAsM/nvN9J4Zl6UomAgMKO1j8lEyFuR?=
 =?us-ascii?Q?lm9U0+GylrlxiqEzX2WwNZf8oSFrF5NZwNR9DupEnJrp3dEU/aWGe2b4lXl2?=
 =?us-ascii?Q?9THzFra8nDddcU6XsvsvyH7Yg2j7Aqk0+Z0bnEMlpG4pB+BR12fYDo2AWSSx?=
 =?us-ascii?Q?Gw8bpircmYF2NjMPc4QPoR6Q0vgkpryVi0tyanQT486JSgLHvz1MuX7rwjjU?=
 =?us-ascii?Q?8gSZgJb10PP+KlYZqjk/z2ZxzuZ3w1UZ64rLoT0Jnr2SSeZKWzej/IrwdlTR?=
 =?us-ascii?Q?mHJiel0EBotU7NidTnt/c/5j88EU0X3NloUnPPmuPRM3hB4y3sZitXAEOFtR?=
 =?us-ascii?Q?O580Iq/vmB6cBkvw93Ak8wQHyXPu8JkoFv9PzBpX0dOulIfHV9HvYi4MTdRV?=
 =?us-ascii?Q?h7Uwd+4yTcKP5czobSX4YY3hzg4OMOcw88atn7PzzXKmZCCOzHi8V6gMmMIm?=
 =?us-ascii?Q?GsoBwhAdAVW9yAjGXdgx38I8xDNt4bwwsIwCkiTncsqwYAHWATP88FnxQ/ez?=
 =?us-ascii?Q?v3Tcz39oaAqbqDtGMfGqtmfH7sz3EqRV+8BHRNIimyBVEZcOe/d4xBf4QGsp?=
 =?us-ascii?Q?8BSypQpzuNlEgJot+2LeFlZic0CTyPRefwnq/WjyB3CZNr9TcmOCGADqdp0A?=
 =?us-ascii?Q?X/O7dku8NN+QGsdCO1C4REDTbG3zAzSXAm/A6lT5Px1n7timaJgngNlRibIN?=
 =?us-ascii?Q?yAnkDAEXluhnNO14+oh/2e20FLThGkIuOBnzh/HHmZB56ZoJUVplNgAxzRQl?=
 =?us-ascii?Q?haSJAF/+Uy7uUSNNHPyGSExj3xeWalL69SLdYu63KDhlKgYPvISdrksGABl+?=
 =?us-ascii?Q?yTmWBl79JTUYRTY97Q/KAEBqf2WbuEQ6PGiPPG8QJ6PrNbj4/ozZLeorkWby?=
 =?us-ascii?Q?sSRQ4JEj/J1cJC8LV0jdyp9Nr6Dh6tr2rQXsxgIOL54wU1nERR2ruADWt+0f?=
 =?us-ascii?Q?EMsnro9VrtIAwlsk9xJskxWeUpqoUjD5ZxD/gTtvl8lVkIlSt1c8BFfUQjt9?=
 =?us-ascii?Q?VtC28mXoqlbef1oqKfa4OHPk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b604d9a5-4ce0-4887-d7e2-08d91a7245df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 03:00:34.9507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPyad4Cfc5Lysn6UHdQieo0vyp3oQpTJMpz+SFDvEyHzLc5e6mboJzaHpvWxoWKKzj3TtvwJVQHj4i8FvUp8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Content-Type: multipart/mixed; boundary="===============0819292993=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0819292993==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB12873E4A35B066FB196E4C87F12B9CY4PR12MB1287namp_"

--_000_CY4PR12MB12873E4A35B066FB196E4C87F12B9CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Nirmoy's patch landed already if I understand correctly.

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

--_000_CY4PR12MB12873E4A35B066FB196E4C87F12B9CY4PR12MB1287namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Nirmoy&#8217;s patch landed already if I understand =
correctly.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">d41a39dda140 drm/scheduler: improve job distribution=
 with multiple queues<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhu, Changfeng<br>
<b>Sent:</b> Wednesday, May 19, 2021 10:56 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Alex Deuch=
er &lt;alexdeucher@gmail.com&gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br=
>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx list &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is the issue exposed by <span style=3D"font-siz=
e:12.0pt;color:black">
Nirmoy's patch that provided better load balancing across queues.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">BR,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Changfe=
ng.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;
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
 avoid compute hang<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ Nirmo=
y<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I thoug=
ht we disabled all but one of the compute queues on raven due to this issue=
.&nbsp; Maybe that patch never landed?&nbsp; Wasn't this the same issue tha=
t was exposed by Nirmoy's patch that provided
 better load balancing across queues?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Zhu=
@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 10:28 PM<br>
<b>To:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;<br>
<b>Cc:</b> Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
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
erved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB12873E4A35B066FB196E4C87F12B9CY4PR12MB1287namp_--

--===============0819292993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0819292993==--
