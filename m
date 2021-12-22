Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F044C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 03:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBD610E2CE;
	Wed, 22 Dec 2021 03:19:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AE510E2CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 03:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPC+X8pJptTVdu5dVVo9wOqXpp98BiOwem6c211LLW2ylXIy03SwUUD66BtFQwP+oO3gUdDQEtgoauuqVgxu0clmDLEOuhwwgSO+dP/oihdT5jnItqmTStiyiiW+xD6vGEjGnqMrSy0LMhgb7fY0d/iXum+j/3LJzPLcckDUu5sjqgFfJnMigwnhdSPKhn81bB3y9N5XwFfF6z2JDmSRBlOaWLajFoRn8MIbAP1FfxUilHIcCWIyM7iUZmK1ByphUqGLsWRrnfA1oCPpoK2WfzvU4teDkWdC7iDkPZQZGbrZxhAnrNkD5sdvTVveMRJ8lSySbLsDyHN10+sfns1dOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icuUHWYloxdq6Y7maAQMw3+/r5+3jM+/4us0dPDFdoM=;
 b=ad6/Ya32QEoQHBlwtf2Nl4u74QdoCSDbQl5aoswOmJzlY22mgwZlAkaFN5/bsL769G4YhOtD2aEN3XwxTksns4Cu326mOhyKjOBm716yVGB0O17Cyc2tfN8MbWhqVvrMGVn5NeIFv0VRniLrEL1YbHWRYIYyLM4qeudyHTpSa/B1zhNnO5OaInMuoWRWMLloovRNqpD2PP5HqxKRkhl8AHSwyZNh1HGpwsQlPwJgJo24hPclEdl4k79V9aTEAFjc8NfRqmAcjt4U2BMOnEPdBj45la75jBixJKSzCzarKxiFgPb/M5tds+Au/XWEeTsBvekDR1vEoyuhOvAeJxQRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icuUHWYloxdq6Y7maAQMw3+/r5+3jM+/4us0dPDFdoM=;
 b=VB+UDMLIWb38XEzENTYknycPCxQWS/DJrBEyH1by1XqJK8HJBenJh96ZwAWgiTa65e++XIj4sO8H7ldBy0OdEmuzVuTw599s+A8sjIU7+FstXxQ9XaOMkQTmVv7eWJ4CeKSK9RtU72a9MO9R+jiuN4fzLjAGOHVRvYjRX3kAX2c=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Wed, 22 Dec 2021 03:19:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%5]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 03:19:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX9bvn0cz5y9SCVk+6Kkcghzhxyaw7vGaAgAFCcYCAAAXzAIAA1Iow
Date: Wed, 22 Dec 2021 03:19:08 +0000
Message-ID: <DM6PR12MB26190A8388C1E472837BC094E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
 <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
 <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-22T03:19:05Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b9d7e15-9ab1-4236-3bb4-08d9c4f9d12c
x-ms-traffictypediagnostic: DM5PR12MB1451:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1451355A89E386D45DBE8A15E47D9@DM5PR12MB1451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOCXRO46wXISdei2QA9lugYl1Pve7k6uyOGcJPJgcuJUn18pDFitnWb/v+KXHZkfsYrCyJAjmAzLAmNUyi279Yvx3eyWeqtf7/RXnC23qYF2YyGPtMrjLHQGouG9UJKNi7+4ajjnIpRrR/JdB2Zah7eo1Nby+6lwMCK6TyknK/Ccbnb+D+vPehff0663+m90XnK77UN2JUWjKHjtFIgeBdbyEfav4ZXRRpV+nS2rbtnwFJbevJaXFhEZXKcTdMw9cTeU/Ut0O8DoDmbjxJCssxYtrPzHqXPx7ogPVVdLQbZgbw5iJ6tAzFvh1615g3uYu+ASFrjh+DzR4NKfvuhzSefiqF+w7KJOXxt3CRa4cI+yuCdxCNw4x/0VrpjXMin5vF+x5+MlYK7AD/W+hYMRFR65ESrsYDh+ZYJyDqPz16rgQebZ5vTvtlvvS5H8tZP1ePd99KRdJPH9eYKXCAzw9tUsUw4xL3qfImOugd4s+3jolZ4J71FgIq6pTU2J7yXHCZxehVCnroXhWJjM7SPQOO80oxccg7QM8c5k2p1p1K0Cg/MGMrcOghs1OYU8MjZmp9ne+WJVjrIVwxOWeXYiXCcpPgdA5B3C32pEi6u0p5M/kFJOoKGVfDZnnrF73LgF6WTRjrnF5ZSQHDcbjnIWCjAIhiyXrMv+BfmDcCGubJiFYghW0wQ4mgrDw4HjFZqXqsAiy7YRMuadmV4/ELLwmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(110136005)(9686003)(38100700002)(55016003)(64756008)(83380400001)(186003)(8936002)(33656002)(71200400001)(38070700005)(5660300002)(66476007)(66946007)(8676002)(86362001)(76116006)(4326008)(66446008)(66556008)(6506007)(2906002)(508600001)(52536014)(316002)(26005)(7696005)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KGRvvQ4rWnn1vOgzqHIYmSP9EX3EbT9RjD6y9vneTsD2bt6Lzu27VeQlDb/X?=
 =?us-ascii?Q?yUfp+zlY804xazTfQpCNdm6vr9ziR0bhIkDcF6PBTU/fIkgrEJv7xC4oob9t?=
 =?us-ascii?Q?Yh+XFFQt/gThoF9hMFpXuOEIw0ovKn0XssLtv3MBgcEoUMcQrRiK0c5aDb/C?=
 =?us-ascii?Q?Dz3ongPpOm4MV/icb2yItUb1MZB7hiuqSxrbcVp0/+ka3MtxZCBqmmq1X2QC?=
 =?us-ascii?Q?eFTEwbOgeIH3kUYfobPA8bAsiE0t7Y8SIFq7Ps34M7HEDVNq+zPIYEPvovhM?=
 =?us-ascii?Q?23tsmwoSM3C0WRJQoGwqVwJAKnDdDmyOY/fux+1MMU1UoyzzrfbwKyu3AcCB?=
 =?us-ascii?Q?S9oM5Ee2NOx4NzY3m6Bn1ESdqpswXSbGRK9AXf+mnXCnLoUOzXM1Ov6vsSjp?=
 =?us-ascii?Q?1Q56TbxI72/w2k0XrTr7kDj0rLZ/a33T/qpPlGgcWbKancYXIy8vJx5UoNOp?=
 =?us-ascii?Q?d9lkC5cF3SkwUhNPtJCCqT+BqhEcZrE+GXtwbq2zcpua/PfyF9tJ4v+pX2HP?=
 =?us-ascii?Q?O1h4VQ3skh6N65FwXMuP/+Xl+HCYM2CxvgGiqQE+O2G0slC4gaNJPJJ/4W2o?=
 =?us-ascii?Q?z11zOwpMA9a74s4GGdnfBCsEO+DJjpW7ZAA9FoZ++/mQ0YE0pdr+olM0lb+4?=
 =?us-ascii?Q?ax0YXKVSTaY+66LbKIvTh6lsSigZGQzOUP1IK+Hk6XOtDGQtJ2ybDAATtVBQ?=
 =?us-ascii?Q?g54y27xZuCOrb1oNPcriIm/b+U6QbxO0quh1/SkCt+xSRlLA/sWeAuT57DEL?=
 =?us-ascii?Q?Xj30Yl7UFu/TMHYVS2a0bu5PFq14K1oSmYOrYjRtB6yb+Fl99y1DQhq5N82P?=
 =?us-ascii?Q?nxKAtBfFP1sVAflfJgbKNT1Uw+uqR2fMaCk6lMCaM3BQp2YRYMqJ8cqXZFto?=
 =?us-ascii?Q?Zuc49KQiczkyhklIU/P9qoB3rv7p6CoRLo1zNUSpGjNuHAwmwHGUi0HiStuS?=
 =?us-ascii?Q?dG1AES1UXTR52lesadXS7T2Nd4n5plZHQlJtx2r9EXjdIkokSPUY0WR1bBju?=
 =?us-ascii?Q?CTdfsxXKcvYdsntW4unOCO1Tg9w2eB8C/Z3LKbjLSC5y6KHQJbL4Qp2eursZ?=
 =?us-ascii?Q?B7jb6zQjMFulw1UrLs7jPj8jvwjZVG6QZPOIS2AVc9mRcbKh2avzcNqDrlKk?=
 =?us-ascii?Q?H0tNU42IcDe8G1/a/7yyeNCTyZQGjDaFjcq0SoYMJQvn3VvgGocDSBY1jzje?=
 =?us-ascii?Q?FveRMXIiShTLpB0jzoTDfYltVGVpikcngiwW1chGn/h8z522DThrP3r1ZIh5?=
 =?us-ascii?Q?F5YkSwcKfJ2lhiU+68PwIsOuzAGVoh8XBhuO4Qw3oOdmaiUNpET3LHHuqF3q?=
 =?us-ascii?Q?GuNYetJZfCoaJeEFsvxyqYC2LYAoTK8N+4TDqhRNHMprtkvzqQDYSy88s2ql?=
 =?us-ascii?Q?vffUMknqraJc/qFRpLvsmt5SEC1eCaeQhbulryf3MVT3LGsplpyaMOd/Zb1i?=
 =?us-ascii?Q?+ZTa4t6buw9tQzeeLpVtLT7edkcL+7fn7IcM3H35Kvnk8DEpJ7K5S3rj1WQ4?=
 =?us-ascii?Q?Nt6dbC1k+X7wzNPg0GwdpE6z8gUBcF5PquY0dXfs545ifjbF44hCkv5sE2FN?=
 =?us-ascii?Q?jIViJTRKvDjQBPsqLQo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB26190A8388C1E472837BC094E47D9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9d7e15-9ab1-4236-3bb4-08d9c4f9d12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 03:19:08.3936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuJLGCeReva+9PXFiZu10Z/rB2uv/Kf3YUlRPEgeGdlIOQJO7+gvVpp9CgDZfQTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB26190A8388C1E472837BC094E47D9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Nikolic,=
 Marina
Sent: Tuesday, December 21, 2021 10:36 PM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg <Greg.Kitchen@a=
md.com>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode


[AMD Official Use Only]


[AMD Official Use Only]

From 06359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
From: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>=
>
Date: Tue, 14 Dec 2021 20:57:53 +0800
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 permission in ONEVF mode
[Quan, Evan] With the subject updated(remove the description about pp_dpm_s=
clk), the patch is acked-by: Evan Quan <evan.quan@amd.com>

BR
Evan
=3D=3D Description =3D=3D
Setting through sysfs should not be allowed in SRIOV mode.
These calls will not be processed by FW anyway,
but error handling on sysfs level should be improved.

=3D=3D Changes =3D=3D
This patch prohibits performing of all set commands
in SRIOV mode on sysfs level.
It offers better error handling as calls that are
not allowed will not be propagated further.

=3D=3D Test =3D=3D
Writing to any sysfs file in passthrough mode will succeed.
Writing to any sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".

Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic=
@amd.com>>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..c43818cd02aa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                }
        }

+       /* setting should not be allowed from VF */
+       if (amdgpu_sriov_vf(adev)) {
+               dev_attr->attr.mode &=3D ~S_IWUGO;
+               dev_attr->store =3D NULL;
+       }
+
 #undef DEVICE_ATTR_IS

        return 0;
--
2.20.1

________________________________
From: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com=
>>
Sent: Tuesday, December 21, 2021 3:15 PM
To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

Hi Kent,

Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.
@Kitchen, Greg<mailto:Greg.Kitchen@amd.com> required this for ROCM-SMI 5.0 =
release. In case you need it, he can provide more details.
I'm going to clarify commit message more and send a new patch.

BR,
Marina
________________________________
From: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
Sent: Monday, December 20, 2021 8:01 PM
To: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>=
; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>; =
Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Marina Nikolic
> Sent: Monday, December 20, 2021 11:09 AM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com=
>>; Nikolic, Marina
> <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>; Kitchen, Greg <G=
reg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read pr=
emission in
> ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs
> should only be allowed in passthrough mode.
> Options that are not mapped as SMU messages
> do not have any mechanizm to distinguish between
> passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish
> ONEVF and PASSTHROUGH use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikol=
ic@amd.com>>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..d2b168babc7d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_devic=
e *adev,
> struct amdgpu_device_
>               }
>       }
>
> +     /* security: setting should not be allowed from VF */
> +     if (amdgpu_sriov_vf(adev)) {

You should be checking for pp_dpm_sclk here, for example:
                if (DEVICE_ATTR_IS(pp_dpm_sclk) {

Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not 100% clear.

 Kent

> +             dev_attr->attr.mode &=3D ~S_IWUGO;
> +             dev_attr->store =3D NULL;
> +     }
> +
>  #undef DEVICE_ATTR_IS
>
>       return 0;
> --
> 2.20.1

--_000_DM6PR12MB26190A8388C1E472837BC094E47D9DM6PR12MB2619namp_
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Nikolic, Marina<br>
<b>Sent:</b> Tuesday, December 21, 2021 10:36 PM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Kitchen, Greg &l=
t;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">From 06=
359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">From: M=
arina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@=
amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Date: T=
ue, 14 Dec 2021 20:57:53 +0800<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Subject=
: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read<o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;p=
ermission in ONEVF mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] With the subject updated(remove t=
he description about pp_dpm_sclk), the patch is acked-by: Evan Quan &lt;eva=
n.quan@amd.com&gt;</i></b><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">BR<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Evan</span><b><i><o=
:p></o:p></i></b></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D =
Description =3D=3D<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Setting=
 through sysfs should not be allowed in SRIOV mode.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">These c=
alls will not be processed by FW anyway,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">but err=
or handling on sysfs level should be improved.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D =
Changes =3D=3D<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">This pa=
tch prohibits performing of all set commands<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">in SRIO=
V mode on sysfs level.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">It offe=
rs better error handling as calls that are<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">not all=
owed will not be propagated further.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D =
Test =3D=3D<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Writing=
 to any sysfs file in passthrough mode will succeed.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Writing=
 to any sysfs file in ONEVF mode will yield error:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&quot;c=
alling process does not have sufficient permission to execute a command&quo=
t;.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Signed-=
off-by: Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina=
.Nikolic@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">---<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;d=
rivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;1=
 file changed, 6 insertions(+)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">diff --=
git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm=
.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">index 0=
82539c70fd4..c43818cd02aa 100644<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">--- a/d=
rivers/gpu/drm/amd/pm/amdgpu_pm.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+++ b/d=
rivers/gpu/drm/amd/pm/amdgpu_pm.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">@@ -213=
3,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device *adev, =
struct amdgpu_device_<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; /* setting should not be allowed from VF */<o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; if (amdgpu_sriov_vf(adev)) {<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.mode &amp;=3D=
 ~S_IWUGO;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =3D NULL;<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;#=
undef DEVICE_ATTR_IS<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; return 0;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">--<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">2.20.1<=
o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikoli=
c@amd.com">Marina.Nikolic@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, December 21, 2021 3:15 PM<br>
<b>To:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitc=
hen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Kent=
,&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thank y=
ou for the review. Yes, I can confirm I am trying to set this for every sin=
gle file for SRIOV mode.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><a id=
=3D"OWAAM749892" href=3D"mailto:Greg.Kitchen@amd.com"><span style=3D"font-f=
amily:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Kitchen, Greg</=
span></a>&nbsp;required this for ROCM-SMI 5.0 release. In case
 you need it, he can provide more details.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I'm goi=
ng to clarify commit message more and send a new patch.<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">BR,<br>
Marina<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@am=
d.com">Kent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, December 20, 2021 8:01 PM<br>
<b>To:</b> Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Ma=
rina.Nikolic@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Nikolic, Marina &lt;<a href=3D"mailto:Marina.=
Nikolic@amd.com">Marina.Nikolic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=
=3D"mailto:Greg.Kitchen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEGIN=
"></a><span style=3D"font-family:&quot;Times New Roman&quot;,serif">[AMD Of=
ficial Use Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Marina Niko=
lic<br>
&gt; Sent: Monday, December 20, 2021 11:09 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mila=
n.Mitrovic@amd.com</a>&gt;; Nikolic, Marina<br>
&gt; &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@amd.com</=
a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitchen@amd.com">Greg.Kitc=
hen@amd.com</a>&gt;<br>
&gt; Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
 premission in<br>
&gt; ONEVF mode<br>
&gt;<br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Due to security reasons setting through sysfs<br>
&gt; should only be allowed in passthrough mode.<br>
&gt; Options that are not mapped as SMU messages<br>
&gt; do not have any mechanizm to distinguish between<br>
&gt; passthorugh, onevf and mutivf usecase.<br>
&gt; A unified approach is needed.<br>
&gt;<br>
&gt; =3D=3D Changes =3D=3D<br>
&gt; This patch introduces a new mechanizm to distinguish<br>
&gt; ONEVF and PASSTHROUGH use case on sysfs level<br>
&gt; and prohibit setting (writting to sysfs).<br>
&gt; It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
&gt;<br>
&gt; =3D=3D Test =3D=3D<br>
&gt; Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br=
>
&gt; Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&gt; &quot;calling process does not have sufficient permission to execute a=
 command&quot;.<br>
&gt; Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
&gt;<br>
&gt; Signed-off-by: Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd=
.com">Marina.Nikolic@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<br>
&gt;&nbsp; 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 082539c70fd4..d2b168babc7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,<br>
&gt; struct amdgpu_device_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* security: setting should not be allowed f=
rom VF */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
<br>
You should be checking for pp_dpm_sclk here, for example:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_sclk) {<br>
<br>
Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not
 100% clear.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;store =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp; #undef DEVICE_ATTR_IS<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.20.1</span><span style=3D"font-size:12.0pt;font-family:&quot;Times N=
ew Roman&quot;,serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB26190A8388C1E472837BC094E47D9DM6PR12MB2619namp_--
