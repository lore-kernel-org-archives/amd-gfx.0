Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277D0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 17:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808D410E307;
	Fri, 21 Jan 2022 17:46:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D91B10E307
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 17:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcP8YzpUWVj+RANRpBHdB6W/Tkg7CU1Z8ArESzC+6wn+W2r2Ix4sZf+qSi5XaBYT+HGuv419LzYDRMowqCTFY9u6QyJwtaR3auQyxJFvvbILIVOyYICyrdn62+5uHy2/yyyOZpSvWK6o89z1zFcUUfwr1Y4dUj3CRQ0lP6SexXBSJyrfCu7Wj1D/sXAu4TR9a7eZHJB1ap8o0JDR+Pls3EbB7NoAAyCiW6bitXAql6vEhe4OAgxLOgaDbGbtSkruseQ73Hijz/cGkUdjZAG0x2wCz09vf5HdSjHq7BnaEzIltuF9bS9dRzz9iVH04V/cs4/Y5nv0nbQwpDBzCxxA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKML45cC0yOB6SkoRUd8GRmFQOW9uUlWqOkjXxaTR98=;
 b=HDzxdYiAY0+EshLZ6+HxxROJnnJxZLKz5OjZDGamZ4Ete3KjHuPOkHSzxjz7K7jW0Y9il3YtnLbaSK/NYFdKQOJdpwKOQjiMsY5cL8+oz3dKCqQ4VJgfEGXV+qQLb3CbCw0gldJVS6HElwJeqE1oZ0DVA3P0KCqjB1fIgEolAEs+a794BLZsi6f37yMh6p9pz6DxNdhKgTqAEKk8rbhKqKy3hAFayD4msWD5Azg29i89isserQ/X6GuBl2QSXyiSz/HhsYaqYqirIxTXYIFBIdfWr18DlYaTfZMs/7SsSw0HRhfbPP0XqtFUM309RIrZ4Tg42reC13jzkDH6Ouz1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKML45cC0yOB6SkoRUd8GRmFQOW9uUlWqOkjXxaTR98=;
 b=ZG/U1NnVTnuzASUSr9RIk7wAYBOOjNXLvHCFbW/PJuKoen8k2iaFF0OVQsa9iQS/Oe+2stYT+Yphw2P8QTUoyu75lXoTBWlnnGAFQXFrExwCKSgoy3FHg/USCnlJGFjlQBJF7n4jNxfMU3jyvXAQtfZishdxMQTgh/uWXESnU8Q=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN7PR12MB2756.namprd12.prod.outlook.com (2603:10b6:408:29::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 17:46:30 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%6]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 17:46:30 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYDOZvWjqZ4w+i3kugLoq0I8xZOqxsVlTQgADwzQCAAHvfAA==
Date: Fri, 21 Jan 2022 17:46:30 +0000
Message-ID: <BL1PR12MB5157D2953F2142727BF94230E25B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220119034120.28807-1-mario.limonciello@amd.com>
 <BL1PR12MB5157B51FADD5148BC295792CE25A9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB323862243A6C32EF7511ECBBFB5B9@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB323862243A6C32EF7511ECBBFB5B9@BYAPR12MB3238.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T19:58:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=97d9e7da-77bb-44ac-a394-83cf2076ec21;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-21T17:46:28Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 55ca0bfb-8e45-429a-bef3-336289220109
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85de25e8-a87c-447d-ae1b-08d9dd05f502
x-ms-traffictypediagnostic: BN7PR12MB2756:EE_
x-microsoft-antispam-prvs: <BN7PR12MB275674E43C39CBA33323C405E25B9@BN7PR12MB2756.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18UOEykonR9jc6c0FxwwgbSKedQb/1KYenzlxUIFhvFUyc4ElBJnIzfI5RbU/Pj72xcXN6jX+Sl22wlRErg29kmMc5UZXeJI9lhfaEMNDFw1yJdIDiip1ZPEbm3/Ryas93wNdzwRvFx9zgE+UhNZRmogs8/NGh/443w4UNWpx93g/Jdrw/31QKK//P1GIpk1PzbvzIAGPw3OssDvUbbkv6CR+arQpsU9xQnVoveXgBsMW4WkiHvwpGR/aWFIE3RlN/23iJHO5nU7da/zk8wycr8RCXWAQh7xo2kVz0fgJlFB+9ICyszcanEr/IPSaB0f/RWb9Fkqo6l37f9PcHkz8hsiSoxNiizi+Zy63CfHnchFuZr2OwigAm6cn6SU/hgrZiluxg/UxF4SIzovJttiG/OEb1O0VWw7oZYHxTLRJQTMvZ9GsYjfgyVzjIWxfD/lPJcub3FwI05NIyzNZ+cuw9Zep8GStYrKa3pLkVi9DnLRNvWR1LLt9eyR8FE7rPS9wXYuzaWd5Bt9qKwDIoSflmXSKpA+AHpEhoPMY0/un4KdiZ121VAHEuk+tYKqUpMYtwX8Lqjgh0ZngQstcgrtj3ono9bbMf1mH2NlK1QZ+dJFyGUCp8bCVAX/zUftv0Fn8iBcAolS6m0VtgSHL/NslfyiVtqB7s2mpJBhZFL9yb+bBB7uXT9eD+/glumFFVGJf6CPdcCk60QkNswMOdFkxUDOx9mbdO6pKpI8jXf19Is=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(66556008)(66476007)(66946007)(5660300002)(66446008)(64756008)(83380400001)(38070700005)(26005)(71200400001)(8936002)(6506007)(53546011)(2906002)(7696005)(86362001)(122000001)(38100700002)(8676002)(316002)(966005)(55016003)(4326008)(508600001)(52536014)(33656002)(76116006)(6636002)(9686003)(110136005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d5KCCqxZg2jeYi1V6/FBSigFAm4ud8dF/WdBEKutvVvyULWgL8kP9aI3XLI4?=
 =?us-ascii?Q?Fg7kNj2Drfy9WdyTs/knkEj8rRcPkDX/5LpX9NeETo1pN2u96czJsgh8v5ut?=
 =?us-ascii?Q?Hp6YXL97K0u08BnvkV4upBTeNwDlmaRgEfoJ+E8zM458dr8RXklKpfaCVFw1?=
 =?us-ascii?Q?EN31nyqMd8F1BqR3GNMBSBOloLMp4Rm0+WrH5weN5GnGYi1oTzQmX99rQVBQ?=
 =?us-ascii?Q?qVjEKQWg1KnuFqsu1fmPt96CwOl7OYc5uRTLSTUdXeFa06bKAKrm+J/2HtRS?=
 =?us-ascii?Q?pkRwBLor6pGHNLA2bmXRULpoLtAl79bGo2WIaIX/NYVgg+ecFh+si8Io8Fa2?=
 =?us-ascii?Q?9rq5qDu3MRPDXSEBoeXzVmzOnKGtZIT6quEspscpIgnFVez9FodctC1IHcIQ?=
 =?us-ascii?Q?WCqpym9Rmaf5V7ZH5CxWkP2mcLeGL0AQkhzfOqWtcZLkk2ogyAUNrXQDCgra?=
 =?us-ascii?Q?cMV8K9cvV90i01U824w+D1ax/SbcKpFqPUtogDR519U83A0+WZh+2Qr/5Eye?=
 =?us-ascii?Q?hgxoahfMUWmbFMJM126Z9i1iaRZQMx25WuuQ0MXSilBikj48PM7SHBZmNqO7?=
 =?us-ascii?Q?lMkLUuA9JZ1TkKYSuS901bZyoWZSefyMfAIXIKOB+419o+mNYN1BchhktwLz?=
 =?us-ascii?Q?c5MFWFH++pYkWdAmqK0LyfooxBGMATt0lOO7qVGhzEeH0/gxNYV2f3cpDoqS?=
 =?us-ascii?Q?hyoGf4Iah9u/VIL6z4m/hhwxAI3pe8pvi8qLIphMPazB4lI6toxAShAmM9bx?=
 =?us-ascii?Q?J+WErCBNU3CjeZkYtFnZIW+yPeIzlbiSYb3J/j+nWTBTIL/vr/hkOZirMKip?=
 =?us-ascii?Q?86jGBC3tQgY8QHCdwf69+ybQL/fB/HrIY6G8vDXuk/HXyZ00XLFiqQYMUspW?=
 =?us-ascii?Q?IAgbW6giYdk/7Pm+bSZ2+rMqVZcRsu4uhq+hZ5gJz456P2fPoITXgQbUzyH+?=
 =?us-ascii?Q?bUHiqd9SgN7XG6lFNW7NlkmrE9KgurxlBFr9HQWoXfpGhS0gcb5MribWLiWE?=
 =?us-ascii?Q?aHFvK+Abh8S0IReW3LVF19Br6E8Mfuox0d7YuLHs8Ri9KrpoT4PKcUYnm278?=
 =?us-ascii?Q?hbhEFvEoMhhg+ZPWvRFoO291Z+ZU6KBzRT6gdYpFbki+fBYvTPnX1sSGZhdZ?=
 =?us-ascii?Q?k0nh0TobCR1NnpHhKMHGayLtrmgQG0vfDVOA5ZinuQYXJspAwXlK8K9xAFCN?=
 =?us-ascii?Q?13ac0BEjYvGX5veGQKwBbAfem9CUgqDAab+XeDMAqYeFSnyxq3JwAbK8GcPx?=
 =?us-ascii?Q?IC+Bz8r05Je670NP123+ZxdSczvu+CVSMUY9tMRZzCAfKVArw4IZ7/kF25uU?=
 =?us-ascii?Q?XPc//6EuuOfU50KpvIEzqpwsn/qMoNCZLwJ7+R5yE9KN58qPNUIpEnRzbdkn?=
 =?us-ascii?Q?GqAggwhPTbaIIyrYvzeJo7yiSqsgqF6WaCDmCRQizWV6MMZteS85RjHEV8p5?=
 =?us-ascii?Q?7DwVz6T/XR2+c64MqB5m1I4URAOn2tQpyktL4D3Yyy7X7kFyah+xrKBgYUW9?=
 =?us-ascii?Q?i83TPpufL0v8iU1cy7Nj9VBf9PvFtpWq/sYfa6ixItBzCqtw8nwWFGY2pKSJ?=
 =?us-ascii?Q?kZq3FobsbLOjfZXU/T9/GEpphwWN0CxwkcUl2nO2aHbAxRK2o/hz/RCX2hEg?=
 =?us-ascii?Q?ULGgkYYWTM81zzuvJT4TWEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de25e8-a87c-447d-ae1b-08d9dd05f502
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 17:46:30.3710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUQjhDpE5NAfoiOK8e3hKRj/Q9q2T7VmZQo5N6UVKJEQ+dg8Z5vSNAWAEfekSEhjmSWAWjEPEwqlzLQ8CVL6WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2756
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> The S2idle suspend/resume process seems also depends on the
> CONFIG_SUSPEND. Moreover, why this check function still return true even
> when BIOS/AMDPMC not configured correctly? You know we still looking into
> some S0ix abort issue and system will run into such problem when mark tho=
se
> misconfigured case also as s0ix.

If return false then the driver expects to go the "S3 path" which "may" wor=
k now
after the patches that reset GPU on resume landed.

If you think this is wrong and it should be returning false in this case - =
then I think
we need another function that checks if s3 is actually a valid target.  The=
n in
suspend we test if we're doing s3, and we test if we're (safely) doing s0ix=
.
If we can't do either then the GPU stays fully powered up across the suspen=
d
cycle and you see these warnings.
Thoughts on that?

>=20
> Thanks,
> Prike
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Friday, January 21, 2022 3:59 AM
> > To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Li=
ang,
> > Prike <Prike.Liang@amd.com>
> > Cc: Bjoren Dasse <bjoern.daase@gmail.com>
> > Subject: RE: [PATCH v4] drm/amd: Warn users about potential s0ix proble=
ms
> >
> > [Public]
> >
> > Add back on Lijo and Prike, my mistake they got dropped from CC.
> >
> > > -----Original Message-----
> > > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Sent: Tuesday, January 18, 2022 21:41
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Bjoren Dasse
> > > <bjoern.daase@gmail.com>
> > > Subject: [PATCH v4] drm/amd: Warn users about potential s0ix problems
> > >
> > > On some OEM setups users can configure the BIOS for S3 or S2idle.
> > > When configured to S3 users can still choose 's2idle' in the kernel b=
y
> > > using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803
> > ("drm/amdgpu:
> > > always reset the asic in suspend (v2)"), the GPU would crash.  Now
> > > when configured this way, the system should resume but will use more
> > power.
> > >
> > > As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> > > potential power consumption issues during their first attempt at
> > > suspending.
> > >
> > > Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v3->v4:
> > >  * Add back in CONFIG_SUSPEND check
> > > v2->v3:
> > >  * Better direct users how to recover in the bad cases
> > > v1->v2:
> > >  * Only show messages in s2idle cases
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 21 +++++++++++++++-----
> > -
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > index 4811b0faafd9..2531da6cbec3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > @@ -1040,11 +1040,20 @@ void amdgpu_acpi_detect(void)
> > >   */
> > >  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)  { -#if
> > > IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> > > -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> > > -		if (adev->flags & AMD_IS_APU)
> > > -			return pm_suspend_target_state =3D=3D
> > > PM_SUSPEND_TO_IDLE;
> > > -	}
> > > -#endif
> > > +#if IS_ENABLED(CONFIG_SUSPEND)
> > > +	if (!(adev->flags & AMD_IS_APU) ||
> > > +	    pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> > > +		return false;
> > > +#else
> > >  	return false;
> > > +#endif
> > > +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > > +		dev_warn_once(adev->dev,
> > > +			      "Power consumption will be higher as BIOS has
> > not
> > > been configured for suspend-to-idle.\n"
> > > +			      "To use suspend-to-idle change the sleep mode in
> > > BIOS setup.\n");
> > > +#if !IS_ENABLED(CONFIG_AMD_PMC)
> > > +	dev_warn_once(adev->dev,
> > > +		      "Power consumption will be higher as the kernel has not
> > > been compiled with CONFIG_AMD_PMC.\n");
> > > +#endif
> > > +	return true;
> > >  }
> > > --
> > > 2.25.1
