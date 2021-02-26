Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 11:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211506186A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 11:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211506186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4B4893DB;
	Fri, 26 Feb 2021 11:57:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CEF892E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 11:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4IvlhFBvLAjxGKEky8Cu+tLsKF65kyns95o7U/Q3qPkKmA26b2jt78v/UVu2lS87ZKJ+Hi/VvS8MIaTkz7AqriuJ4inVRTM0bMS9Gy3HWfBgDHkVgMZYm0nEcPvRqYcbRTFJ76gnxeFhycuJOG/8TR7KuIQo/j03m8uApfUtdvovhiLsK0lA1VbMfFyNXJwt0VbGFpN+Qv3TtmfAb7zIN4gaLlmIFWaFoOUW7es4QLYe+0IE7PyF9lISho8T8QYidFq1UcZu/Z7w3W9zlWjKF5dKjSkmVuYajVCpsE8dJpAffW/IlWlVmr2SdAOSQ6m79KkXA8dNxMgDsun5qj4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJx+gQPwLI9nYFLbpO+gPsNCcFBRTpq/X8Qlc5ym/L0=;
 b=m+JSnXdLuYj0YlVRiTitPkK8w1Lif7wBUgbLbCQUOHSNoIczLhgl9sCa1zjsr0SYVTF/+NZeGj9JY90ACc+gxGfXf6A86hQy1tpj+/63Gpc3NTXOqga59J67kWz707UkpgpuZUndli1t+cBwkSAjkTYuofS98rg0JbR39vup4u+AXLm7LxZ2fatyqupO7m8A7WU6oXiBNRzPl8ah2vTvgd6ChdwjDTeTLGuw/24/wcNnaUpYsd/7R05pg5D1bDgBAv8wI7X+sFfWhyS36n4QXAAYVWetGivSmA4Zsr67gSMfhGh4Um10+swQvFKDEOdDKEMkQ2kvwNxecqvEzbxdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJx+gQPwLI9nYFLbpO+gPsNCcFBRTpq/X8Qlc5ym/L0=;
 b=5lyj3jkykQQRLGV6fbE1qAvueMk7GXjm9CZqP/BFVa+ZRVabzIfNCJ2YlcZW9T+bMKNYndHHGBgakwarWYL9uE8k3To/J6h/ZivTjnl3iZTARdpBgZx0BFhvOeR86lP4MgyVVllz4qbpHWd/clvXXnUUFSUecznn3osgzO5w6TY=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (10.175.89.22) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.106.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.31; Fri, 26 Feb 2021 11:57:26 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3868.033; Fri, 26 Feb
 2021 11:57:26 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC] a new approach to detect which ring is the real black sheep
 upon TDR reported
Thread-Topic: [RFC] a new approach to detect which ring is the real black
 sheep upon TDR reported
Thread-Index: AdcMAadhaEND07KHR4C1q7rMxPXb/AAE23MAAAgNKLAAAE2JUA==
Date: Fri, 26 Feb 2021 11:57:26 +0000
Message-ID: <DM5PR12MB17084EADC1B4C8603C864E84849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-26T11:57:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc8c3edd-2118-4185-aa11-732b6fecf3cb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1469e86-d9b9-4eaf-1c52-08d8da4daf9a
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28915ADFED9EE2A285001980849D9@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMKdw1fmM2wCGG1Ln1Zzob2ExiW7Fu57DhxsIJwoatsvj9LE+EqUSU1Olng6j5FgbNvzOO8V8Zlg0g9VHEZvBFgmYTZ9WYxwJiEmyAFftvabsFD48p8/xPqPTa4Pb6Iu+ton5m0IM3sGgUZ/ZnkFXHn+DW8VD6a8AscGYjzfC5wUhAsz01OKFWKm4SyYuqxeCst3USd99cE00MvgbLfiuiv0Bw5Z/qRjgbswBQ59F/VySxxubU5V2++hKnaVfICv16O7KCAJl6oOHtmkEXx4e/nL1Flcjk0UIAD51qsU8DQFyAMjA6zgCmuV0jizi6DGTAWlrRq8lWBFGMabOHgtDxG83EyYyhUTSOZnnazxKhKm76jGrvxo6cJbY8RnQi/GMSofupF7ClnzQy2QZnyMR1zB9xvpJg0rpMZk5B1s33tePgKT2UlS3KQrH6UGZkRuvHOHMO2H+2mhAFwvrN2tWtVACTWsPYP2JwNcStroSI3dPUMVh/h7UEir7SX/UxhnRY8uPTH8tRsgTDnM2G/Hxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(316002)(8936002)(110136005)(53546011)(66946007)(83380400001)(33656002)(5660300002)(54906003)(8676002)(6506007)(76116006)(66476007)(66446008)(186003)(66556008)(2906002)(64756008)(52536014)(26005)(86362001)(55016002)(9686003)(71200400001)(478600001)(7696005)(2940100002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XIDUJy4AxejxZsr2lzdyxkbVC9daAblhYIXQoWz7dZ+kiYnW2rvAeBoWPWYr?=
 =?us-ascii?Q?90Q92jLDnYAx+5+Vo48o8fLTApidr0brP3Qmq+oi/IMRG2FAAJOkLYq15vcA?=
 =?us-ascii?Q?klsD7Klmc+xc2P/HvuAxVUtHVPb8pI7nCJlPT+In+DohnyrtB6EYUGBY5TWW?=
 =?us-ascii?Q?Ews43OeHPRp4d2yBEaw3EiLCk4ciEfRDUm5itrhEe0rzcl3VAD7mBlsm3HR3?=
 =?us-ascii?Q?54zVylvCoq0QHjoFCM0M4xHXAnmvs+sn8DGuSamJ/7PqkKGpiflP9WZNNL+/?=
 =?us-ascii?Q?/FqGfeH2aYAdojXzETtVZhZrzKfvWezOtg8lWVp3ziJTvgsk6O1qM5Fjv3AW?=
 =?us-ascii?Q?sUMzqM+SllVcL4gE08ceVqCpUUufEXgaHwGhCHJHzF3W7XURx9Dwar9IqilQ?=
 =?us-ascii?Q?RcG5F+uuOO+HhDgQoJejcWWKUknzjhXVpJT5E9On0SYsHgVXF9K6wQpyzqEg?=
 =?us-ascii?Q?zEI1XFBGOft4/0xKzndjAOzJ0bCLTikOAezSL+AQr0AbDmuJkWBHBVkfI2er?=
 =?us-ascii?Q?yArll4VHTnRJMp3JLFZcGenGKcV0Giv71ET126akftaP6Ffn5LiDRzXW29Wn?=
 =?us-ascii?Q?SQXBic4pKL+XBQy62jE+M/JDhJlB02Ne1SeTYB8o0vKsEXb97fRjT9Rg+ibh?=
 =?us-ascii?Q?3lVulVUMZ2AV58Q7vSAsoMFqJX59JVVr56pbpGmMaw3GG+6mj10YLPmXNG8T?=
 =?us-ascii?Q?KNje38r1FpiZW1vbA+x19H+Z/WEEClLrKaVW6auRyEKKwPyiEbeTZJPZ89yD?=
 =?us-ascii?Q?uvvTn0NLyM0KdFg9Z5ttRHq44WxjBdF642ifSipyLwBJ8VbPqsY0nAlAytBL?=
 =?us-ascii?Q?/jCQpqbtYBzYlKuM/40CEScWxFYAMXWlqgCri3WLWYNYaxDehK0QAx+xBIwE?=
 =?us-ascii?Q?T2cGmbNU2Fdd0fj8VSgiWnY8wePpY4s1Kh2g0xc0w7xsV+a5Y1yNdY5dAdb7?=
 =?us-ascii?Q?WIahhPq3E0KBc7d/W9d3MrNJejtYi4hyRtfLMwZWqzoIBFpgcsL8RB+gQs/I?=
 =?us-ascii?Q?qhyjgk4WYZ05UdvmxZverOokZM4o91B5Z9AgBrRd6sGF3F16RbmHJGZibe4M?=
 =?us-ascii?Q?prstlUyBTK0FrKM5s0Z3e0kUZGGrzB3yhwAtfPjkh0gsFjb2XaJ69bHqaAo9?=
 =?us-ascii?Q?ZVzQPdmlKDr8FQHXGm+zsRqGT24W6kH2M5OwS2EHruUZKoyHN05FbrY6hD+h?=
 =?us-ascii?Q?1RyY5G3gLhJMabquxXAgVTLz5P+AjPq5gI+FcOkmbTz/RAmS9GtOEyXStveL?=
 =?us-ascii?Q?y0BkiXsllDMP4B7uRuZxnbnPVuuj4UudYjfxoz8Bf8EYZLPUdiUcTlHLn8Lu?=
 =?us-ascii?Q?q7SgRVdBOnNYy9u+pozw0/US?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1469e86-d9b9-4eaf-1c52-08d8da4daf9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 11:57:26.5515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFOmuKR6S7EhAGi2452VlojXc9d8UHb+aTypqi+3Yh52imZvhGUhDH+sho7GnRp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1310401291=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1310401291==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB17084EADC1B4C8603C864E84849D9DM5PR12MB1708namp_"

--_000_DM5PR12MB17084EADC1B4C8603C864E84849D9DM5PR12MB1708namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

static void drm_sched_job_timedout(struct work_struct *work)
279 {
280     struct drm_gpu_scheduler *sched;
281     struct drm_sched_job *job;
282
283     sched =3D container_of(work, struct drm_gpu_scheduler, work_tdr.wor=
k);
284
285     /* Protects against concurrent deletion in drm_sched_get_cleanup_jo=
b */
286     spin_lock(&sched->job_list_lock);
287     job =3D list_first_entry_or_null(&sched->ring_mirror_list,
288                        struct drm_sched_job, node);
289
290     if (job) {
291         /*
292          * Remove the bad job so it cannot be freed by concurrent
293          * drm_sched_cleanup_jobs. It will be reinserted back after sch=
ed->thread
294          * is parked at which point it's safe.
295          */
296         list_del_init(&job->node);
297         spin_unlock(&sched->job_list_lock);
298
299         job->sched->ops->timedout_job(job);

Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

From: Liu, Monk
Sent: Friday, February 26, 2021 7:54 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org
Cc: Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Z=
hang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: RE: [RFC] a new approach to detect which ring is the real black sh=
eep upon TDR reported


[AMD Official Use Only - Internal Distribution Only]

See in line

Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

From: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@a=
md.com>>
Sent: Friday, February 26, 2021 3:58 PM
To: Liu, Monk <Monk.Liu@amd.com<mailto:Monk.Liu@amd.com>>; amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Andy <Andy.Zhang@amd.com<mailto:Andy.Zhang@amd.com>>; Chen, Hora=
ce <Horace.Chen@amd.com<mailto:Horace.Chen@amd.com>>; Zhang, Jack (Jian) <J=
ack.Zhang1@amd.com<mailto:Jack.Zhang1@amd.com>>
Subject: Re: [RFC] a new approach to detect which ring is the real black sh=
eep upon TDR reported

Hi Monk,

in general an interesting idea, but I see two major problems with that:

1. It would make the reset take much longer.

2. Things get often stuck because of timing issues, so a guilty job might p=
ass perfectly when run a second time.
[ML] but the innocent ring already reported a TDR, and the drm sched logic =
already deleted this "sched_job" in its mirror list, thus you don't have ch=
ance to re-submit it again after reset, that's the major problem here.

Apart from that the whole ring mirror list turned out to be a really bad id=
ea. E.g. we still struggle with object life time because the concept doesn'=
t fit into the object model of the GPU scheduler under Linux.

We should probably work on this separately and straighten up the job destru=
ction once more and keep the recovery information in the fence instead.
[ML] we claim to our customer that no innocent process will be dropped or c=
ancelled, and our current logic works for the most time, but only when ther=
e are different process running on gfx/computes rings then we would run int=
o the tricky situation I stated here, and the proposal is the only way I ca=
n figure out so far, do you have a better solution or idea we review it as =
another candidate RFC ? Be note that we raised this proposal is because we =
do hit our trouble and we do need to resolve it .... So even a not perfect =
solution is still better than just cancel the innocent job (and their conte=
xt/process)
Thanks !

Regards,
Christian.
Am 26.02.21 um 06:58 schrieb Liu, Monk:

[AMD Public Use]

Hi all

NAVI2X  project hit a really hard to solve issue now, and it is turned out =
to be a general headache of our TDR mechanism , check below scenario:


  1.  There is a job1 running on compute1 ring at timestamp
  2.  There is a job2 running on gfx ring at timestamp
  3.  Job1 is the guilty one, and job1/job2 were scheduled to their rings a=
t almost the same timestamp
  4.  After 2 seconds we receive two TDR reporting from both GFX ring and c=
ompute ring
  5.  Current scheme is that in drm scheduler all the head jobs of those tw=
o rings are considered "bad job" and taken away from the mirror list
  6.  The result is both the real guilty job (job1) and the innocent job (j=
ob2) were all deleted from mirror list, and their corresponding contexts we=
re also treated as guilty (so the innocent process remains running is not s=
ecured)


But by our wish the ideal case is TDR mechanism can detect which ring is th=
e guilty ring and the innocent ring can resubmits all its pending jobs:

  1.  Job1 to be deleted from compute1 ring's mirror list
  2.  Job2 is kept and resubmitted later and its belonging process/context =
are even not aware of this TDR at all


Here I have a proposal tend to achieve above goal and it rough procedure is=
 :

  1.  Once any ring reports a TDR, the head job is *not* treated as "bad jo=
b", and it is *not* deleted from the mirror list in drm sched functions
  2.  In vendor's function (our amdgpu driver here):

     *   reset GPU
     *   repeat below actions on each RINGS * one by one *:

1. take the head job and submit it on this ring

2. see if it completes, if not then this job is the real "bad job"

3.  take it away from mirror list if this head job is "bad job"

     *   After above iteration on all RINGS, we already clears all the bad =
job(s)

  1.  Resubmit all jobs from each mirror list to their corresponding rings =
(this is the existed logic)

The idea of this is to use "serial" way to re-run and re-check each head jo=
b of each RING, in order to take out the real black sheep and its guilty co=
ntext.

P.S.: we can use this approaches only on GFX/KCQ ring reports TDR , since t=
hose rings are intermutually affected to each other. For SDMA ring timeout =
it definitely proves the head job on SDMA ring is really guilty.

Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------



--_000_DM5PR12MB17084EADC1B4C8603C864E84849D9DM5PR12MB1708namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
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
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">static void drm_sched_job_timedout(struct work_struc=
t *work)<o:p></o:p></p>
<p class=3D"MsoNormal">279 {<o:p></o:p></p>
<p class=3D"MsoNormal">280&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler=
 *sched;<o:p></o:p></p>
<p class=3D"MsoNormal">281&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *jo=
b;<o:p></o:p></p>
<p class=3D"MsoNormal">282<o:p></o:p></p>
<p class=3D"MsoNormal">283&nbsp;&nbsp;&nbsp;&nbsp; sched =3D container_of(w=
ork, struct drm_gpu_scheduler, work_tdr.work);<o:p></o:p></p>
<p class=3D"MsoNormal">284<o:p></o:p></p>
<p class=3D"MsoNormal">285&nbsp;&nbsp;&nbsp;&nbsp; /* Protects against conc=
urrent deletion in drm_sched_get_cleanup_job */<o:p></o:p></p>
<p class=3D"MsoNormal"><b>286&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;sched-=
&gt;job_list_lock);<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>287&nbsp;&nbsp;&nbsp;&nbsp; job =3D list_first_en=
try_or_null(&amp;sched-&gt;ring_mirror_list,<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>288&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct drm_sched_job, node);<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>289<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>290&nbsp;&nbsp;&nbsp;&nbsp; if (job) {<o:p></o:p>=
</b></p>
<p class=3D"MsoNormal"><b>291&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /*<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>292&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; * Remove the bad job so it cannot be freed by concurrent<o:p></o:p=
></b></p>
<p class=3D"MsoNormal"><b>293&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; * drm_sched_cleanup_jobs. It will be reinserted back after sched-&=
gt;thread<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>294&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; * is parked at which point it's safe.<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>295&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; */<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>296&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; list_del_init(&amp;job-&gt;node);<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>297&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; spin_unlock(&amp;sched-&gt;job_list_lock);<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>298<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b>299&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; job-&gt;sched-&gt;ops-&gt;timedout_job(job);<o:p></o:p></b></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Thanks <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
<p class=3D"MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Liu, Monk <br>
<b>Sent:</b> Friday, February 26, 2021 7:54 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org<br>
<b>Cc:</b> Zhang, Andy &lt;Andy.Zhang@amd.com&gt;; Chen, Horace &lt;Horace.=
Chen@amd.com&gt;; Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> RE: [RFC] a new approach to detect which ring is the real b=
lack sheep upon TDR reported<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">See in line<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Thanks <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
<p class=3D"MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian &lt;<a href=3D"mailto=
:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
<b>To:</b> Liu, Monk &lt;<a href=3D"mailto:Monk.Liu@amd.com">Monk.Liu@amd.c=
om</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Cc:</b> Zhang, Andy &lt;<a href=3D"mailto:Andy.Zhang@amd.com">Andy.Zhang=
@amd.com</a>&gt;; Chen, Horace &lt;<a href=3D"mailto:Horace.Chen@amd.com">H=
orace.Chen@amd.com</a>&gt;; Zhang, Jack (Jian) &lt;<a href=3D"mailto:Jack.Z=
hang1@amd.com">Jack.Zhang1@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [RFC] a new approach to detect which ring is the real b=
lack sheep upon TDR reported<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hi Monk,<br>
<br>
in general an interesting idea, but I see two major problems with that:<br>
<br>
1. It would make the reset take much longer.<br>
<br>
2. Things get often stuck because of timing issues, so a guilty job might p=
ass perfectly when run a second time.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[ML] but the innocent=
 ring already reported a TDR, and the drm sched logic already deleted this =
&#8220;sched_job&#8221; in its mirror list, thus you don&#8217;t have chanc=
e to re-submit it again after reset, that&#8217;s the major
 problem here.<br>
<br>
Apart from that the whole ring mirror list turned out to be a really bad id=
ea. E.g. we still struggle with object life time because the concept doesn'=
t fit into the object model of the GPU scheduler under Linux.<br>
<br>
We should probably work on this separately and straighten up the job destru=
ction once more and keep the recovery information in the fence instead.<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[ML] we claim to our =
customer that no innocent process will be dropped or cancelled, and our cur=
rent logic works for the most time, but only when there are different proce=
ss running on gfx/computes rings then
 we would run into the tricky situation I stated here, and the proposal is =
the only way I can figure out so far, do you have a better solution or idea=
 we review it as another candidate RFC ? Be note that we raised this propos=
al is because we do hit our trouble
 and we do need to resolve it &#8230;. So even a not perfect solution is st=
ill better than just cancel the innocent job (and their context/process)<o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Thanks ! <o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 26.02.21 um 06:58 schrieb Liu, Monk:<o:p></o:p></=
p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi all<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">NAVI2X &nbsp;project hit a really hard to solve issu=
e now, and it is turned out to be a general headache of our TDR mechanism ,=
 check below scenario:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">There is a job1 running on compute1 ring at timestamp
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">There is a job2 running on gfx ring at timestamp<o:p>=
</o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list=
:l0 level1 lfo1">Job1 is the guilty one, and job1/job2 were scheduled to th=
eir rings at almost the same timestamp
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">After 2 seconds we receive two TDR reporting from bot=
h GFX ring and compute ring<o:p></o:p></li><li class=3D"MsoListParagraph" s=
tyle=3D"margin-left:0in;mso-list:l0 level1 lfo1"><b>Current scheme is that =
in drm scheduler all the head jobs of those two rings are considered &#8220=
;bad job&#8221; and taken away from the mirror list
</b><o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in=
;mso-list:l0 level1 lfo1">The result is both the real guilty job (job1) and=
 the innocent job (job2) were all deleted from mirror list, and their corre=
sponding contexts were also treated as guilty<b> (so the
 innocent process remains running is not secured)</b><o:p></o:p></li></ol>
<p class=3D"MsoListParagraph"><b>&nbsp;</b><o:p></o:p></p>
<p class=3D"MsoNormal">But by our wish the ideal case is TDR mechanism can =
detect which ring is the guilty ring and the innocent ring can resubmits al=
l its pending jobs:<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 level1 =
lfo2">Job1 to be deleted from compute1 ring&#8217;s mirror list<o:p></o:p><=
/li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 lev=
el1 lfo2">Job2 is kept and resubmitted later and its belonging process/cont=
ext are even not aware of this TDR at all
<o:p></o:p></li></ol>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Here I have a proposal tend to achieve above goal an=
d it rough procedure is :<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">Once any ring reports a TDR, the head job is *<b>not</b>* treated as =
&#8220;bad job&#8221;, and it is *<b>not</b>* deleted from the mirror list =
in drm sched functions<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l1 level1 lfo3">In vendor&#8217;s function (ou=
r amdgpu driver here):<o:p></o:p></li></ol>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level2 =
lfo3">reset GPU<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"marg=
in-left:0in;mso-list:l1 level2 lfo3">repeat below actions on each RINGS * o=
ne by one *:<o:p></o:p></li></ul>
</ol>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-9.0pt=
;mso-list:l1 level3 lfo3">
<![if !supportLists]><span style=3D"mso-list:Ignore">1.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">
</span></span><![endif]>take the head job and submit it on this ring<o:p></=
o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-9.0pt=
;mso-list:l1 level3 lfo3">
<![if !supportLists]><span style=3D"mso-list:Ignore">2.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">
</span></span><![endif]>see if it completes, if not then this job is the re=
al &#8220;bad job&#8221;<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-9.0pt=
;mso-list:l1 level3 lfo3">
<![if !supportLists]><span style=3D"mso-list:Ignore">3.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">
</span></span><![endif]>&nbsp;take it away from mirror list if this head jo=
b is &#8220;bad job&#8221;<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level2 =
lfo3">After above iteration on all RINGS, we already clears all the bad job=
(s)<o:p></o:p></li></ul>
</ol>
<ol style=3D"margin-top:0in" start=3D"3" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">Resubmit all jobs from each mirror list to their corresponding rings =
(this is the existed logic)<o:p></o:p></li></ol>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">The idea of this is to use &#8220;serial&#8221; way =
to re-run and re-check each head job of each RING, in order to take out the=
 real black sheep and its guilty context.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">P.S.: we can use this approaches only on GFX/KCQ rin=
g reports TDR , since those rings are intermutually affected to each other.=
 For SDMA ring timeout it definitely proves the head job on SDMA ring is re=
ally guilty.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
<p class=3D"MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
<p class=3D"MsoNormal">------------------------------------------<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB17084EADC1B4C8603C864E84849D9DM5PR12MB1708namp_--

--===============1310401291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1310401291==--
