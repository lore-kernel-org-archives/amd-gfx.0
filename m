Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194A710F9D3;
	Tue, 10 May 2022 14:20:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DEF10F9D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAlDQKKtsxvaZM12v/+aIBc0tLzd7J733TJuq6+cIHybgq5QYJIiOCbRWf2o8+Y0/hD4wERJ1WfKPqsQ7/gGnmqGMvZBwQVw0wt+//wcOwUkVgEEUMIlRt+XLncVm5L+aed8ddC1XWdlRYwMwjhJcuE2nb8neRxKcPBx9O+mrxBCJoQJjMBrlRc4qKJIiwFARQKP2Q1X2nl6DgkVPwmsx1CMBLq/7Tyuw+l/PEgPSc4NJ8qVDK7tItLkKSf1x80wg4R/C6pLdnHOa2nTE1hm2BYbo8dD8FvCKI7lntS0aqCY4UzssZ4ix4SmARbT0msaRauMmO+M4pO6ljUSeFbgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lH7JQhfNIWoAaXwNob0zOOndE29cKBAuXRPVzUKR9g=;
 b=Nfdo5iqaafB4Q+ct0Nx+466OH6HWRqZujlAiUPqnEf4mLQ3bDKSLhNnD4GXMuK78HLwN8lJtrRNjeBGxpnYZTttN7fFv/HgjgJP3g1FzvxJUh14rGfm1OZxEifn0dOp6J/4rr9LSMsVsZJ6TLSRaMMPeDjpHGZQdRepAYlmU3XyGtaqLNU6Cdl1XJGlcCuBupoJL6SaQvFeYWJIOu8y/iTDoB3mf0yjukeW0ytExuvzSJhbNbgPq4MA19E41KQauHOAdXr9W4mVxvSqzIdC/n55AGLR/IVHHXODrZMeg3CtgfR6dtunkJyyVntnwTpcsh4kWEhcIRAc1QiROiTBKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lH7JQhfNIWoAaXwNob0zOOndE29cKBAuXRPVzUKR9g=;
 b=U46bWTfVocduDBbdflHe06L7TQdx67wCZvfDvCD0hcwnshv5KTNnflXKeail8bRQBshAUi+vv01OlRi5z+3rWv24+jbczZ3tC2zrZBRp2S3T4IR9o7y8CDx+QJzsxYyHlsvNH42cj2XFmWTzHQD/smbq8ICZ2YsOxSqUnCN+r2w=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 14:20:44 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:20:44 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Paul Menzel
 <pmenzel@molgen.mpg.de>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>
Subject: RE: Fwd: Re: amd | ASUS ROG Strix G513QY fails to resume from suspend
 [regression] (#2008)
Thread-Topic: Fwd: Re: amd | ASUS ROG Strix G513QY fails to resume from
 suspend [regression] (#2008)
Thread-Index: AQHYZEkuY9VUsEy9ekKmZc53WkMqDK0X6hEAgAA/d6A=
Date: Tue, 10 May 2022 14:20:44 +0000
Message-ID: <BL1PR12MB51577545223636FF899765B9E2C99@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <note_1375796@gitlab.freedesktop.org>
 <66e1d78c-bf27-80b4-9804-6c9f3a8c5547@molgen.mpg.de>
 <2192e546-cac7-f802-2297-3461a1cf8e03@leemhuis.info>
In-Reply-To: <2192e546-cac7-f802-2297-3461a1cf8e03@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-10T14:20:10Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=24344b5a-2944-4810-9e20-15c123879dce;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-10T14:20:42Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a52a173f-403e-42a3-9e5b-cc6e86bcf79e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d1216bb-1e09-4c5b-825a-08da3290453c
x-ms-traffictypediagnostic: DM6PR12MB3500:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3500C5B3CA1CE5E3E38089F2E2C99@DM6PR12MB3500.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BASwPLzRRHdb/fgoNaWPWsr5rHGqFsjJpygZazqtKhA3v/LD9mTrie86bXLF0fKCo9I1LtM/kMooTLGMLi2Umdd6G1itjrv6HVrmzvtC1I6HIEgz6+2KYZmObxx68l24XfUrZbRlemGGflEwJZ6TCN5YmjplDm1oNB5XNOg/s9k32GaSQizKSGIjRLxOuthIkuhanPwlCC5eEINKBC6mo1+W956KftyNWvAR8+m74UlLd531oB75yH/jAcdAP8zwJEr6zk4BIor5GXHRkPvWz0aVEPwjEGciO9TBiQU7q1qEifNNQoM8vX56l+6Na8zb7NfNBtWc5F5rNOsCFI4k3QQ3H4X59teI4/N0S4aR7wL1zNL7tsU0VjO2QKRnJTHPI1kgzmRGqq3ZHh/7QUUUfqFxxD8354dM71SpUpu5BKcKNo199SnlXapPLwsR/p/k5btjQRtmdNw6kbdUdKZKaSxWqUfsYjE4XravRAiTxStT2wI6xOk0YfZTu66E8E2ltkRTwBcx0Kt1uaGcRo/zYciAv4zJ/NmyybSJXWtQH0L0CfVuEIjl/Vm5dHmblPSXO6/tAgY0tU9Myy4O48/TlA2eve83FC72jgPwmd2dd0rMC9BuDLNuynv2kc9pEPR6BCBtd68bfM3TXmfy+oSRH98cEqTYTidJuQCX2AlWpSwEMf4l0EWPnz7YVDHY4fDjZA5Mc+maREYH1Mhah6jGRbzi6hZov3ypahGhhqZ7vCzZJpUF+wYGV/zCkbqJiSs3zWD5UTJZ+tUWYkap0K5PFKNQl0WxpOYeOaC104f1dUc5cJxrc9xFYlP8DxOwf6UuXUQZoKENEqPDOOIOlsnXOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(9686003)(53546011)(7696005)(83380400001)(26005)(71200400001)(15650500001)(5660300002)(45080400002)(66556008)(122000001)(33656002)(186003)(2906002)(8936002)(508600001)(316002)(38070700005)(38100700002)(966005)(52536014)(76116006)(55016003)(66446008)(66476007)(64756008)(66946007)(4326008)(8676002)(86362001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qCHNPa/C6lZqeIKa9zMAYPidu/vNf4/gZhPhUU/EeHktNoMIBm0KRHka1/5?=
 =?us-ascii?Q?qYHnUpnxP4Ym7aZ5umYTPGlN+8mKz6ShoKkdVo4CZWaick65UR6zTY/hq1LR?=
 =?us-ascii?Q?pry9V6urPFxSnh9rwSuJRpbp9y6uAz87cY9Jy9w5lUGIXHOD2EL7U6S2whvs?=
 =?us-ascii?Q?z28ZMEi5LzAKc9Kz757EnOs7581KZfHJ5HY5DchTIcJ0M8paxcZ1awVXfaIA?=
 =?us-ascii?Q?zsaOPv5UGdW9L7QV+3UcU+txxN98pZGXbZ3hE4jlTiVhjtIH+Iux05OI1aj6?=
 =?us-ascii?Q?nRUqwFWqSKSemTtBvudbdk/FLxt3e7udIGMkwOr86fQu0yrORTH5fgUVwPnX?=
 =?us-ascii?Q?tVl8zebEHfyyNsZ3UQ2FXmV3iHHGu5hQF2WCu6/sEz9kxh4BwNm/TQA0EL8B?=
 =?us-ascii?Q?JYX6JOXdlKk8toLUDsFn9ywPum8ANfB4upGwcz0Z/dSnql0ffRz28yIq42PN?=
 =?us-ascii?Q?Y4qLucrrUvwXOsJ5XtHfCwGItCitNWaWF6cWE+xht+WZFVHtq41ZF3dKMDv1?=
 =?us-ascii?Q?H8Ka1i0SUAB46IfuSaek0+xxVjweNhnYF2Pmcgdt7vyPojH3mT77hkznVe8F?=
 =?us-ascii?Q?uLhiUEJpe68uX1uHTE0VgdB08jXFPL7alHRZwFTIuEg8BJjz60CcPixKcaeG?=
 =?us-ascii?Q?oLKn09TBeQiw1dCwTp98VNqOOPnbKCvf6ObinQiI4O7JPkfv/GVbh7KdY1st?=
 =?us-ascii?Q?KQIWn4zCnMj4FJsbTZY4MVtH7bsLy887JUXIr23/FrA6T/PH0NeBGcOU2U73?=
 =?us-ascii?Q?E/iSrQLUg3OGwu2TeKXf2iXsQb2qx4Jz63u1HOlq/jpu+XKshIx7U/Q2htPv?=
 =?us-ascii?Q?aD2j+RjKt8okmV0ujn7WWSEeYkHabBt0d/lcu4Bd58fcUk2icB+wbkvX4hOw?=
 =?us-ascii?Q?zMps+cbi9VZhX1hXZ8vn+Sz8wSKBvG8f143Gm9h1wglklQBP+5EjUuhJgi4Z?=
 =?us-ascii?Q?skUzK0xMHbVtnE1USrdtws/uuiSY228YipbxKZqCltKfYCDHSymMZ/9K5ExQ?=
 =?us-ascii?Q?Vkw/+ROs1itYfFlnahPlEw2nIKtOdi42nqV0a8uKk5hzkfouNWvVHZp34scA?=
 =?us-ascii?Q?FHFCEgRsmoT0CMM+rDjR7C4/E3XzZsHvFs19jvAEvRsMuGJTgsQLkW2iSLpN?=
 =?us-ascii?Q?LO10XofiIZ07PmxRkbP6b2C4VWY4CNRr4YZcKp+1UXcYzH5AB8j0Hqt8yB7s?=
 =?us-ascii?Q?O25S5fdLvAUegUwsZ4GifzU7HjV/W+3wpgo6S/LXLVGoTy1/8HmkeLsdkLVO?=
 =?us-ascii?Q?TIdryGd3aQAl64TKis2Uv30h1kAejWVVM9aeGX0+CZ4IGMVTpsPzAIXryXoV?=
 =?us-ascii?Q?UxAs2cXMyUkm8Q82b1aHtYtAxxpc2cwVQ+FCA5O7GCWXPJTv60KTpKrSqkB2?=
 =?us-ascii?Q?Lr/QBRuw44EzM6gZmP8HUkuyXMxAQA7KTQNgxeX6JRqkYwb+dLqHEYz7132C?=
 =?us-ascii?Q?B0CNtUGxUeBAiq2W7WfMMcWEBp0tg8b8pKy7DEkbcQnCeT1uPc6zkM+DPMOU?=
 =?us-ascii?Q?Jrg74bXjM/ypfTwvN2JaZDQsUFCXo7yc2t/6H1CFyS5y65qAd284sqdC9H6/?=
 =?us-ascii?Q?d9MEz7k5J41XcRa3NCsh3mhQn191AfpLaNyLt2xseUY1SYzanuQZVhbWVSQU?=
 =?us-ascii?Q?aaaTWcmh1XvbVOIsfNVAfNMAS8sZvj++TlWWuXXjXKo6kOCaTNKZsutNTqAa?=
 =?us-ascii?Q?stl/NBv56d7Jr7/M2ryV7zjCZb5qk8k6XNcOZ9JeCw0NN85ekE81sqy2ivMD?=
 =?us-ascii?Q?owF2Ahxdgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1216bb-1e09-4c5b-825a-08da3290453c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 14:20:44.3994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVb98D1EvBCsA1mVf5v2FIxOPjzfvioj9sR4zfn9HpLuq3U7BXcJd5oqHMNQuErYzKAWdcUa8F+u9OyyaxIK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3500
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Thorsten Leemhuis <regressions@leemhuis.info>
> Sent: Tuesday, May 10, 2022 05:33
> To: Paul Menzel <pmenzel@molgen.mpg.de>; regressions@lists.linux.dev
> Cc: amd-gfx@lists.freedesktop.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: Re: Fwd: Re: amd | ASUS ROG Strix G513QY fails to resume from
> suspend [regression] (#2008)
>=20
> On 10.05.22 10:37, Paul Menzel wrote:
> > Dear Linux regressions folks,
> >
> > A user reported a regression [1], which also trickled down to the stabl=
e
> > series, for example between 5.15.13 and 5.15.14.
> >
> > [1]:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F2008&amp;data=3D05%7C01%7Cmario.limonciello%40amd.com%
> 7C48555e8619c04186687808da327076c3%7C3dd8961fe4884e608e11a82d994e
> 183d%7C0%7C0%7C637877755868268003%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3D5m%2BEztsZA9qBT8vUSHVnvBCTBnB%2Bar
> U%2FnZqa3MC3lmA%3D&amp;reserved=3D0
>=20
> Many thx for forwarding. I'll add it to the tracking to ensure it's not
> forgotten:
>=20
> #regzbot introduced: 887f75cfd0da44c19dd
> #regzbot from: spin83
> #regzbot title: drm: amdgpu: ASUS ROG Strix G513QY fails to resume from
> suspend
> #regzbot link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F2008&amp;data=3D05%7C01%7Cmario.limonciello%40amd.com%
> 7C48555e8619c04186687808da327076c3%7C3dd8961fe4884e608e11a82d994e
> 183d%7C0%7C0%7C637877755868268003%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3D5m%2BEztsZA9qBT8vUSHVnvBCTBnB%2Bar
> U%2FnZqa3MC3lmA%3D&amp;reserved=3D0
>=20
> Maybe the culprit is actually daf8de0874ab5b74b38a38726fdd3d, the report
> is not clear on that, I just picked the newest the reporter mentioned
> for now.
>=20
> See the ticket for details, there were a few replies already. According
> to Paul the problems trickled down to the stable series, for example
> between 5.15.13 and 5.15.14.

The discussion is trending to a revert.  The revert is submitted here:
https://patchwork.freedesktop.org/patch/485708/

>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>=20
> P.P.S.: This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply -- ideally with also
> telling regzbot about it, as explained here:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinux
> -regtracking.leemhuis.info%2Ftracked-
> regression%2F&amp;data=3D05%7C01%7Cmario.limonciello%40amd.com%7C4
> 8555e8619c04186687808da327076c3%7C3dd8961fe4884e608e11a82d994e183
> d%7C0%7C0%7C637877755868268003%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000%7C%7C%7C&amp;sdata=3Dod7XqKGQVoduIldm71Dfj42Vhq2oHuHFpLAtL
> B2nLvE%3D&amp;reserved=3D0
