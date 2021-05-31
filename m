Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4282FC4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 05:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21AD61090
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 05:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21AD61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626F66E47B;
	Mon, 31 May 2021 05:58:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370816E47B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 05:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCknNfqGQxoizsNscqRtogJP4mlhCM8uIJT0pYamtm5LdtsvTP1/7nKRgwqA58ioNJ0OV1XW+kOCpunlpt0dLepRHOg/vIUAWuQe/7JCIaqJBDUgNiszU7vFC8O4srShG8pt1isNABAVtWc/o1Fc/a3zjNMVZW3m+0+GRaoIfTbA0gKSUkDnEGjAsT+YgVANwNbLYhVTwqZEtez4iDHR8WIKkFmxhgSpFBxNKLcM57bUO+iD4TA9bkvQFVODGbyiDc1XEHAfKDUgzGMmrJjFLfhFtMoz4IDr1zbZxA+RB5bMSHBfDabDa3mirDFiKjH45VJgT8N1+nIL8pU7nlTAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpNkKZxM/khO82HKMosZILryFw1uDsGoLvGKkV2Ac0w=;
 b=k17RHIJjP8CinsxafR78RqJ+ntUd7003kNDJzD4eB9YC3WqySjHnWKzrccSdEH2YtOEy58+SPZTHOxpuUQ2kXTnk5JeET4di0xhw3Ns1sT/LbAhjmJi79msW+o4wDKWIzSKeb0sar+lJVgXqFgY1n1d0tYrg4Zz+w6zHTeobtOed96ynwqyUCVq0nX0VAuKPSeJPSmmH6vjMvqp5Te66B99NWV7dyeEk8EdTdeLrNP2+HQE3GADzW8PRq4tbDz6Zqth+/CbdVbbnQOgHZYQKD494eSIicphFEoaNFqj7CENpIaQXqmj63T+cNQsFpv7ZmnE7FYRATzIewSSUcjmXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpNkKZxM/khO82HKMosZILryFw1uDsGoLvGKkV2Ac0w=;
 b=VeU1A+LchhxKFKWWiWC6JE7yV1FgPW4HikdtP+GKZFN+r3VHQf6VY0ge3W58qJKB0w0AXPjjDpc5gwex5zesfQQ8TVOyRmMBrcexs1LwJGJbB5vtKn2NebRtQynsvBuXOU1M+JrWGJ1Hputtj3Lg0Udf9fv3KXMkuWpKc1nYSkI=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 05:57:58 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d%7]) with mapi id 15.20.4173.024; Mon, 31 May 2021
 05:57:57 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Xin (Justin)" <Xin2.Li@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Topic: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Index: AQHXUhfCh7fN3sOtD0iagY5GhfqIRKr2cacAgAB69gCABjAogA==
Date: Mon, 31 May 2021 05:57:57 +0000
Message-ID: <PH0PR12MB5417C9E021D64EE4A7433A6B8F3F9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210526101310.1872892-1-xin2.li@amd.com>,
 <BL1PR12MB52692DDE6DC4D82AEB5E4A6784249@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BYAPR12MB4759A953391A086672B58D43BB239@BYAPR12MB4759.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4759A953391A086672B58D43BB239@BYAPR12MB4759.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T23:57:42.0000000Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f412ec4-570a-4456-6732-08d923f90a81
x-ms-traffictypediagnostic: PH0PR12MB5418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54188A4EC98C3CA6F7455DC38F3F9@PH0PR12MB5418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtfyyzScCmQ9rTNvJzXjxhGZlcXdItGawSlUp00wXyBEs7PmrSWPCDgR2MxjMxxP31dq+U154fpdFDsG9Bo8bc9Dl7t/2xQ3jrhwaGxHSeaNokl3GeU+RNWHWVXucalufVXiuCDd2yVSsqtliEPQCa6FuwbJtQqzaWVQD2nilbltl+BkSDG+5ePqYpPbqg8+qRDbtmL+OdH1leLoUF5229cqofCsAmB0rJxkyPDYdDYffUEEAajdoSBl7K7H1Vl/jj5AoFkaxxMXhI2cCOqljKRZ/J8b/bVM1Ol+OjQD5w9zT2MjLNnrk/iXL0ZrKmibElrqjN6+amX3jrbZVmEFHYeR0ssqKL/zRNIslnsQzwFwYfwTbHvqe8piXO2ni7bfmVfegtS1bNGKPpXZX4qDlgRMKeNH9W+/f9f8SwYX6VQic92WPefXavYl2pzVcxhdsNBZvKWXf0FYJmYfpYdnJ9aVm7DynkU+sE6kgsD+1HUjE3cTuZIEktKICdGABgLs1GUadR6873/UkWcxqx6oWpUnHu1T1mwUm5zVDFfs9qRgVMUEFj6dE1DMxqW9izxZbDIlYYz9uFbNCImCRNYS9VsG8lLbG6S9POOypTn5DYWDEzK0XgZ6QqOYD7f7uZn1W40hTyoDe0CEHTxwCkbKuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(55016002)(122000001)(38100700002)(66476007)(66446008)(71200400001)(110136005)(54906003)(66556008)(64756008)(53546011)(66946007)(8936002)(8676002)(9326002)(76116006)(7696005)(52536014)(4326008)(26005)(966005)(45080400002)(478600001)(166002)(86362001)(9686003)(186003)(83380400001)(33656002)(2906002)(316002)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B+sNjXIfqHN7wrSznc1TgFfCxzmp/X5m9zFgaAAln8UM1vmycmrvgXlGG8mc?=
 =?us-ascii?Q?lJ9XphuE7UYtnFgsERB7aNzmJ6zw6FsNqCE89jhrDQUioryN6KTl3emMmi96?=
 =?us-ascii?Q?jcqn2OIqWpv/SGR/3iOnlyGu3Wdjs8Bj+k7QFeV/e5GNVr1LczMVefYEO7Xl?=
 =?us-ascii?Q?2PcykrmcKaqwXIG3SFmukbbyUy1jKWySFLEi15kddsQ1n9yqefy3FTLO3NqG?=
 =?us-ascii?Q?xL/ijpK+f9bUk/iK/UnJjLsP3goFpsFTL2NLTJTq4wPSWyJ4W81PSUgJXgzX?=
 =?us-ascii?Q?g/Fb2DAa2TUhG85GxAsJKwYnHZab92nX++Zi+Dc20G8HBY4DRW0JBFnbee+B?=
 =?us-ascii?Q?+BiRA+DhM73g+Lfa7INuF5iwTfuPtSNKJhuj5CfR/Ev+0wlg/acJglkDyzW1?=
 =?us-ascii?Q?o1xARo7XYI3dXQUpa/dOk1weiOQV5z2vpksp+Pu6V41SnPUCbbF0LYXUKkur?=
 =?us-ascii?Q?gGAjZO+aJv+Mb2BC2y3gF1C6KD4xLGnAbS52YdpeLOsMmNfURCoNPj76o9C3?=
 =?us-ascii?Q?/0K+dSqxF4XeKJq/nMoWglxgNIHzv4v4p3oL3qVHGLSDIhkzCXiFuvGTnfhd?=
 =?us-ascii?Q?nF0HJWi6dca0vVYp46Fkxd746YGFum5pSQ1Zzu4LBicW/oBOZu8R/Jocmr8x?=
 =?us-ascii?Q?ayXiddExnPzSxQE92Zb+ZDQxFU+ZJAhTfGZQ/XMf9DxXRQPuKCc0us4vEqhP?=
 =?us-ascii?Q?z1+BxGSgh3BKQSf8oGPxMt48KAvtzAoYzlkeq9PMgiR1NuJrDhTG4o1/xp52?=
 =?us-ascii?Q?jbBDR/sMyBnVG/02H3XwVNJ9Lmj1WuYOrG1Lu4dL1ZZEK9OPyGTuaNH1fi5J?=
 =?us-ascii?Q?R2HAzJS/e6d6aDNwzlPKVs06RB4G9zQuuM6NwnlDXdN0e3tuo/QUVU7LoCQx?=
 =?us-ascii?Q?TxHh2lT3I1izr7Nq7zRkMPgF/SOkpQ9E/dDgPjPC/oywY0xGq3xIJWTbMaQp?=
 =?us-ascii?Q?2rIK297aIu9Yetl+IQyxgosXlDFSROxQ14U91tajL0byE+E6FX+bTSivxS62?=
 =?us-ascii?Q?vm5p1w44RbfVR1+G2c+4IkiCEC6n8rQsATDYiKtFK6TRMhOu/9DVyCRrh3E/?=
 =?us-ascii?Q?R6IZzMylvAdqIMsgliG2pcVJxlvXTW6MRusVc1a1oDmXQQL/AIMk6DXq7RP/?=
 =?us-ascii?Q?UKI/GwDFbqBYAghchQUEkj337FC8lit0hmTLW9jUWhykBVH65CtVMdwJRYyB?=
 =?us-ascii?Q?+fxj43DuVPVqEctnz1qs1/59KTHxhZ5GiYrCGoXAu8SdZqFXbsdTlMYE/uaY?=
 =?us-ascii?Q?GEy1Jge2TXjAZsNbfXMrO1euwwLZgVkI7wMSzXLyyLAiLfp9WdVY0JQMICpY?=
 =?us-ascii?Q?WTO2aXqBhRmEGpcM4zQpIJ6W?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f412ec4-570a-4456-6732-08d923f90a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 05:57:57.8582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjw6R0DkbO6Z2dUvm11Rb7Ld6jHbz9BP9UK44Rh+dOYJ7dx8or7iSxGyjpN4Un11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Min,
 Frank" <Frank.Min@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0797043244=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0797043244==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_PH0PR12MB5417C9E021D64EE4A7433A6B8F3F9PH0PR12MB5417namp_"

--_000_PH0PR12MB5417C9E021D64EE4A7433A6B8F3F9PH0PR12MB5417namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Monk,
     Yes, actually this patch is to disable decode ring, and also want to l=
et gstreamer could continue running. As gstreamer will check both encode an=
d decode capability, if any of this is missing, then it couldn't run.
     As for navi12 sriov it disables decode ring, so adev->vcn.inst[i].ring=
_dec.sched.ready will be false, so add extra follow code here to report dec=
ode.

+                       if (adev->vcn.inst[i].ring_dec.sched.ready ||
+                               (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev)))
                                 ++num_rings;

Best wishes
Emily Deng
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li, Xin =
(Justin)
Sent: Thursday, May 27, 2021 3:18 PM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Min, Frank <Frank.Min@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing

Hi, friends.

My apologize for this patch.

I've ported this patch from another branch to fix gstreamer's lack of "vaap=
i264enc", currently this ported patch did fix that issue. However, since th=
is patch is ported from another branch, I might need to do some alternation=
s and audits mainly in its commit messages. I will file another review righ=
t after my fixes.

Thank you all for you time.

BR,
Justin

From: Liu, Monk <Monk.Liu@amd.com<mailto:Monk.Liu@amd.com>>
Date: Thursday, May 27, 2021 at 07:57
To: Li, Xin (Justin) <Xin2.Li@amd.com<mailto:Xin2.Li@amd.com>>, amd-gfx@lis=
ts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fre=
edesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Li, Xin (Justin) <Xin2.Li@amd.com<mailto:Xin2.Li@amd.com>>, Deucher, Al=
exander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>, Min,=
 Frank <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>, Koenig, Christian <Ch=
ristian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
[AMD Official Use Only]

Looks it lack enough background for people to review:


-                       if (adev->vcn.inst[i].ring_dec.sched.ready)
+                       if (adev->vcn.inst[i].ring_dec.sched.ready ||
+                               (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev)))
                                 ++num_rings;

[ml] why for SRIOV navi12 is forced to have those DEC rings ? since  SRIOV =
navi12 have no decode capability , any explain here ?


-               if (amdgpu_is_tmz(adev))
-                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;
[ML] why this is removed ? is it related to your issue ?


Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Li, Xin (Justin)
Sent: Wednesday, May 26, 2021 6:13 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Li, Xin (Justin) <Xin2.Li@amd.com<mailto:Xin2.Li@amd.com>>; Deucher, Al=
exander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Min,=
 Frank <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>; Koenig, Christian <Ch=
ristian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>
Subject: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing

since vcn decoding ring is not required, so just disable it.

Cc: Alex.Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@amd.co=
m>>
Cc: Christian.Konig <christian.koenig@amd.com<mailto:christian.koenig@amd.c=
om>>
Signed-off-by: Li.Xin.Justin <xin2.li@amd.com<mailto:xin2.li@amd.com>>
Signed-off-by: Frank.Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 25 ++++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 524e4fe5efe8..614e6b06e94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,
                         if (adev->uvd.harvest_config & (1 << i))
                                 continue;

-                       if (adev->vcn.inst[i].ring_dec.sched.ready)
+                       if (adev->vcn.inst[i].ring_dec.sched.ready ||
+                               (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev)))
                                 ++num_rings;
                 }
                 ib_start_alignment =3D 16;
@@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
                         dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
                 if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
                         dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTI=
ON;
-               if (amdgpu_is_tmz(adev))
-                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;

                 vm_size =3D adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZ=
E;
                 vm_size -=3D AMDGPU_VA_RESERVED_SIZE;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index 8af567c546db..dc8a36766c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct amdgpu_ring *ring =3D &adev->vcn.inst->ring_dec;
-       int i, r;
+       int i, r =3D -1;

         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
                                              ring->doorbell_index, 0);

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                 vcn_v2_0_start_sriov(adev);
-
-       r =3D amdgpu_ring_test_helper(ring);
-       if (r)
-               goto done;
+               if (adev->asic_type =3D=3D CHIP_NAVI12)
+                       ring->sched.ready =3D false;
+       } else {
+               r =3D amdgpu_ring_test_helper(ring);
+               if (r)
+                       goto done;
+       }

         //Disable vcn decode for sriov
         if (amdgpu_sriov_vf(adev))
@@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)

 done:
         if (!r)
-               DRM_INFO("VCN decode and encode initialized successfully(un=
der %s).\n",
-                       (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode=
":"SPG Mode");
+               DRM_INFO("VCN %s encode initialized successfully(under %s).=
\n",
+                       (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev))?"":"decode and",
+                       (adev->pg_flags &
+                               AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mod=
e");

         return r;
 }
@@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *r=
ing)
         unsigned i;
         int r;

-       if (amdgpu_sriov_vf(adev))
-               return 0;
-
         WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
         r =3D amdgpu_ring_alloc(ring, 4);
         if (r)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cmonk.liu=
%40amd.com%7Cb86e27d9b55f429b352308d9202ee408%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637576208056272141%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DcMllN=
28FN56voTpWwdnMmBB3CGXezs%2FaEwflSZD6qr4%3D&amp;reserved=3D0<https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org=
%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CEmily.Deng%40amd.com%7Cd54=
43c0408834299dba308d920df8dcc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637576966819274495%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DURmI6iI7DC5tlOH2ujCKAQ70o=
xJQUWX6VcAhzjlkrWM%3D&reserved=3D0>

--_000_PH0PR12MB5417C9E021D64EE4A7433A6B8F3F9PH0PR12MB5417namp_
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
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
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Monk,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Yes, actually this patch is=
 to disable decode ring, and also want to let gstreamer could continue runn=
ing. As gstreamer will check both encode and decode capability, if any of t=
his is missing, then it couldn&#8217;t run.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; As for navi12 sriov it disa=
bles decode ring, so adev-&gt;vcn.inst[i].ring_dec.sched.ready will be fals=
e, so add extra follow code here to report decode.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (adev-&gt;vcn.inst[i].ring_dec.sched.ready ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_NAVI12 &amp=
;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Li, Xin (Justin)<br>
<b>Sent:</b> Thursday, May 27, 2021 3:18 PM<br>
<b>To:</b> Liu, Monk &lt;Monk.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Min, Frank=
 &lt;Frank.Min@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc miss=
ing<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi, friends.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My apologize for this patch. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve ported this patch from another branch to =
fix gstreamer&#8217;s lack of &#8220;vaapi264enc&#8221;, currently this por=
ted patch did fix that issue. However, since this patch is ported from anot=
her branch, I might need to do some alternations and audits
 mainly in its commit messages. I will file another review right after my f=
ixes.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you all for you time.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Justin<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Liu, Monk &lt;<a hr=
ef=3D"mailto:Monk.Liu@amd.com">Monk.Liu@amd.com</a>&gt;<br>
<b>Date: </b>Thursday, May 27, 2021 at 07:57<br>
<b>To: </b>Li, Xin (Justin) &lt;<a href=3D"mailto:Xin2.Li@amd.com">Xin2.Li@=
amd.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Li, Xin (Justin) &lt;<a href=3D"mailto:Xin2.Li@amd.com">Xin2.Li@=
amd.com</a>&gt;, Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher=
@amd.com">Alexander.Deucher@amd.com</a>&gt;, Min, Frank &lt;<a href=3D"mail=
to:Frank.Min@amd.com">Frank.Min@amd.com</a>&gt;, Koenig,
 Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig=
@amd.com</a>&gt;<br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc miss=
ing<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only]<br>
<br>
Looks it lack enough background for people to review:<br>
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_NAVI12 &amp=
;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<br>
<br>
[ml] why for SRIOV navi12 is forced to have those DEC rings ? since&nbsp; S=
RIOV navi12 have no decode capability , any explain here ?<br>
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_is_tmz(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;ids=
_flags |=3D AMDGPU_IDS_FLAGS_TMZ;<br>
[ML] why this is removed ? is it related to your issue ?<br>
<br>
<br>
Thanks <br>
<br>
------------------------------------------<br>
Monk Liu | Cloud-GPU Core team<br>
------------------------------------------<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Li, Xin (Justin)=
<br>
Sent: Wednesday, May 26, 2021 6:13 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Li, Xin (Justin) &lt;<a href=3D"mailto:Xin2.Li@amd.com">Xin2.Li@amd.com=
</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.co=
m">Alexander.Deucher@amd.com</a>&gt;; Min, Frank &lt;<a href=3D"mailto:Fran=
k.Min@amd.com">Frank.Min@amd.com</a>&gt;; Koenig, Christian
 &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</=
a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing<br>
<br>
since vcn decoding ring is not required, so just disable it.<br>
<br>
Cc: Alex.Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander=
.deucher@amd.com</a>&gt;<br>
Cc: Christian.Konig &lt;<a href=3D"mailto:christian.koenig@amd.com">christi=
an.koenig@amd.com</a>&gt;<br>
Signed-off-by: Li.Xin.Justin &lt;<a href=3D"mailto:xin2.li@amd.com">xin2.li=
@amd.com</a>&gt;<br>
Signed-off-by: Frank.Min &lt;<a href=3D"mailto:Frank.Min@amd.com">Frank.Min=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |&nbsp; 6 +++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c&nbsp;&nbsp; | 25 ++++++++++++++=
-----------<br>
&nbsp;2 files changed, 17 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 524e4fe5efe8..614e6b06e94e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
dev-&gt;uvd.harvest_config &amp; (1 &lt;&lt; i))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_NAVI12 &amp=
;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ib_start_alignment =3D 16;<br>
@@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo-&gt;ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_mcbp || amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo-&gt;ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTION;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_is_tmz(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;ids=
_flags |=3D AMDGPU_IDS_FLAGS_TMZ;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vm_size =3D adev-&gt;vm_manager.max_pfn * AMDGPU_GPU_=
PAGE_SIZE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vm_size -=3D AMDGPU_VA_RESERVED_SIZE;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c<br>
index 8af567c546db..dc8a36766c4a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
@@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
=3D &amp;adev-&gt;vcn.inst-&gt;ring_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D -1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;vc=
n_doorbell_range(adev, ring-&gt;use_doorbell,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;doorbell_index, 0);<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vcn_v2_0_start_sriov(adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_helper(ring);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto done;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI12)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.r=
eady =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_ring_test_helper(ring);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto done;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Disable vcn decode for s=
riov<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
@@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)<br>
&nbsp;<br>
&nbsp;done:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN decode and encode initialized successfully(un=
der %s).\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pg_fla=
gs &amp; AMD_PG_SUPPORT_VCN_DPG)?&quot;DPG Mode&quot;:&quot;SPG Mode&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN %s encode initialized successfully(under %s).=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_t=
ype =3D=3D CHIP_NAVI12 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev))?&quot;&quot;:&quot;d=
ecode and&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pg_fla=
gs &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_VCN_DPG)?&quot;DPG Mode&quot=
;:&quot;SPG Mode&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
@@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *r=
ing)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(adev-&gt;vcn.inst[r=
ing-&gt;me].external.scratch9, 0xCAFEDEAD);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(ri=
ng, 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7CEmily.Deng%40amd.com%7Cd5443c0408834299dba308d920df8dcc%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637576966819274495%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DURmI6iI7DC5tlOH2ujCKAQ70oxJQUWX6VcAhzjlkrWM%3D&amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cmonk.l=
iu%40amd.com%7Cb86e27d9b55f429b352308d9202ee408%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637576208056272141%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=
=3DcMllN28FN56voTpWwdnMmBB3CGXezs%2FaEwflSZD6qr4%3D&amp;amp;reserved=3D0</a=
><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_PH0PR12MB5417C9E021D64EE4A7433A6B8F3F9PH0PR12MB5417namp_--

--===============0797043244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0797043244==--
