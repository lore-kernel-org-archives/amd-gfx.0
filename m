Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 21:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B24E60EE9
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 21:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B24E60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5267737E7;
	Tue,  2 Nov 2021 21:00:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F12737E7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 21:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIKtWKMJTajO7hD22j0DslSjyJUPeE+h7i2T/O7eJXYXF9hfw82ZhunwIAroQUfijkJHYe603rugkyB4RX3Kkss55F31dN+SfS5MQUr5AJ/kHk5B5LEg0G9v96/61i8+QVF0jTyFdheyAAXQ2HrWY4QZ9wYLl0IGTH+OgWfED9YGvd+PFAswpTs/m1XR1Ks77XkG5i7D0oHFew+MEKjlS+oDQcSQ/u6NFwlQU4Qc3lOmP3iehFWGno9UnV8HeBXI331hu3dNDXvact1StpbzFueu0R/9i9lJVaVNgPdu6D53QBsGWO39f84ZBYZvCxVP2CbVgGLbG1ZMJdz6pfIqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxzKVGW0Wg4cMeMcVCHxevzZ5nWTHU41laWSLKIbESE=;
 b=FSTovC7k3MOVkQRbjO2ibzBFMB3ZnHImAEgblFlSpInghMQ/etJ568V1aer5Mx+pqpVLybFuuxFJkO5xiVhx4orPHv5pJdjWJ8z+3/BQfw3Mbz2vhi0b6st8FWxugFeXns/AZDYsjcgUgCv1wSZPqocikrPJBRaL2XibeC+3ZZp8yYBTOelooNTDjykj76xSh5+i+WMiXC1vsfSuEyCXwNz4tyKPbJRzvRukx3WVuY5F6HNxkOotnCCndtdLbIyPikpeHqTvwuzFTayfnAHAm1wc0Vif94+qjlPPIU3Pf9ItJLhiASHYu4I6hC/ub/YbOgGbzAT0XKgyNHTmAsJ7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxzKVGW0Wg4cMeMcVCHxevzZ5nWTHU41laWSLKIbESE=;
 b=Rf1cWszLU+ETEXjs8IJNY7UBUgqd21k819N4STb+0oHakymvm19TW3GD36QXCitxamWNV/ququi3MV3oIFBTLy1qhKhtaExMmU4mtMdKbFmBpyFQWOCgi4R6VZudxpUvrswSV7FqBuzDn5aAnPeaEEcIv2dMmZpxYWPJV+dJRKs=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.19; Tue, 2 Nov 2021 21:00:05 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 21:00:04 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdkfd: fix boot failure when iommu is
 disabled in Picasso."
Thread-Topic: [PATCH 1/2] Revert "drm/amdkfd: fix boot failure when iommu is
 disabled in Picasso."
Thread-Index: AQHX0B8mFiI3R9nSrE2yBLNFKaZ2EqvwsdsAgAAGhy8=
Date: Tue, 2 Nov 2021 21:00:04 +0000
Message-ID: <DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20211102192324.3402-1-James.Zhu@amd.com>
 <CADnq5_OnTAKba1CzcmrzxZZMwzJqn5WyuLqC7kst7qCoD5cYBQ@mail.gmail.com>
In-Reply-To: <CADnq5_OnTAKba1CzcmrzxZZMwzJqn5WyuLqC7kst7qCoD5cYBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-02T21:00:03.890Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: ed28fea7-e23f-c084-1409-c223ff3bc616
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62d5b3ef-69c2-42c2-f4bc-08d99e43bebb
x-ms-traffictypediagnostic: DM5PR12MB1515:
x-microsoft-antispam-prvs: <DM5PR12MB151534F50731854A78F5A8F2E48B9@DM5PR12MB1515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FuwM0WvGzQKlcc0zqKd6yinvwCvPJwHg4Tk+gryCqjLV/PUDesPsGXrsngMxiE0OwWn35J2BF+3hVeRj3TS0wYrWqEjJzpho5XrVACvtjOAMUFFvZMCvGu+JVZGegEaMc+NZzBJRhQeIv8S2XK9/80hztYk7crImyfgRN1cNT9aK6SXixsrBUoL01gaFceD/mugAV7IihfQs5yGX1y4vDX/fMfeIE6XqJBbVlRZM8LyKzx4M+5CTH6g2VXTon8LaqwDy/Eg9ivJCBNyXw105BN7uo4tfof4wZbYOHJgsfcS5r1071RqyRxoKxX7ijMJlzCzoFjM7wVREfVS1azwvaT9p467QdbynoxstK0UJI8rwedO8wCqrzShqr/9Szn0fmZrRLXdQqL0Ihdc7a45VJGJQJ0ht6m6oWRNoivtIhAomhL7Hr/xMgQTewU4cBJ+ni2aJaPNMq+e3X7GoR3C4+Zs9j21Szp8YwoItSMAE0J5beQkRgqAIJElt8yyiUdAFVslLDBFDKSSBft4MTyVU5KnFEhdMEMbt/PmcILghU4S5ZsvSHR3qHZMHpuGt9ikCfUnahzmnP3leVASR/XqrovIX9BZ/AfAG8s7Od8YQImvPNVdtXtzAuc0HewYTP4m7i0FWus5NgpocbTG/MbY2o9CFKn7WOmvCLSVtFbl4NDaashx5gVszv5vYGFnKl2pP/lCe35M11XJ+bVvrZ6N2uaVhTpeltKjwZJWkHLT8SY6EeB49l7pmILQ2DyJrh45F9bCo7hAUiQY1TrlHw8f+rxqLWup5qX3v4dyt7cqSGQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(186003)(45080400002)(33656002)(6916009)(86362001)(55016002)(26005)(83380400001)(508600001)(71200400001)(38100700002)(52536014)(316002)(166002)(66946007)(4326008)(7696005)(66556008)(64756008)(66476007)(66446008)(966005)(9686003)(5660300002)(8936002)(2906002)(8676002)(91956017)(76116006)(54906003)(19627405001)(38070700005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jD+17RysK6InO/cgGZCGLkEvIU3kXodN/VbO3YP0btwZvmKpweBpZrfEYBx7?=
 =?us-ascii?Q?lt836gvvJUU4xNCLzd9M26Z6QW9t89y34sMJE00RN3MUDuEhU7rVgMiWdEgj?=
 =?us-ascii?Q?yUPDeFuwzZm2OvxvInrnYJPmMj+DGUo7sZuk7Ha4VrikZTLjWNsmjnOyvJdK?=
 =?us-ascii?Q?P8KbAavGMIrwnFywrrZQFX0ferpClcFGHQFfcjRIcE6Vrs6WM/38rc37YbxN?=
 =?us-ascii?Q?fUg6I3DWJp99IwceT/SAzxWWqhmf4oLEJlJm3hklZaBwpCXUrEqgJ0kAY93R?=
 =?us-ascii?Q?wRvI6CxZlvO2vvl6QESu2HSfU4FpLAQeSFrlpYSSL99BsAMkna/Ao+WTo+WC?=
 =?us-ascii?Q?NqxxFvK2Cx3Hm5iSGjJxblH4BYv+bVqL+lck0LBZC890/zKgBMTIekBxHpYA?=
 =?us-ascii?Q?lB/TqlaqvkdrYJ9y9huYOTbisS164fvXVH9YckTgD9VOeVAXHHIfs35f+Ueg?=
 =?us-ascii?Q?sWFPh0NDPr7Y3MHmSOwytIrUbjp4S9XJb9/qvLzotnZ62TYa0iNrZda2d66Y?=
 =?us-ascii?Q?VsZd9vTauLYrE1pCs+ethvHiV8C+dYMJSCbzOGR1TB7qdlCi+FTGKRdRxKHp?=
 =?us-ascii?Q?ZgonfX7AN3OtnAUAhUtmssgffgX5FAzJTXBt+om+ecdkWV5HfoZv7x9jpQWZ?=
 =?us-ascii?Q?oAIaHmfLfZFE2hJ7EfGLTbsBczFBZJmeiW09dmRcQN1yR5y1fZpcOBd+flci?=
 =?us-ascii?Q?6EdSBnpU2I+RA+NpEmHi9V9GjTFn6aBTxzyywTHTn20V+UhUDeNfMNw2pLY0?=
 =?us-ascii?Q?cHYCBY0qQbA839HmMHVrK5fT4qFfyAZPeYQfjYX6Vr/BSrdWW6kS6fHM9AO+?=
 =?us-ascii?Q?jRAjTlMihnbgcvLUp6ukzvfcrLTt9Kqg8ZQOF1FZ7P/x3PRTkiCnwPQIZuSZ?=
 =?us-ascii?Q?fmpBm3hhQx9BN61VZEMf6uTRyYnWbidnYvC8GvehDVDK3iA2qj6x5t6A7coU?=
 =?us-ascii?Q?UbiRH2R5oYRQANrEO5RX3EtkMNICteeDofCclQl+V9LE27SZkdY3al69HG+J?=
 =?us-ascii?Q?ek7zOhtcYtpASBRjVix0x2tPZZ/M1flHiRQCx21e4bnhroXsVf6luDXUc2v9?=
 =?us-ascii?Q?Iu67AaUsOZdTQxuYMhP+JIUL9Dn3ZcQjgfo+bZmBCQBkIcJLaTCEhgi7miZo?=
 =?us-ascii?Q?TKWHPg1K6InDDriK87j7sfXeOe77VHuWZKDy3pA1VH1qq3LktQ4rfxsFD6jT?=
 =?us-ascii?Q?PQbwdaSNT+q8RK0ZiaLfb640w7zaSq/10IPVW6FsKrTeNjgg902esFiqOtWe?=
 =?us-ascii?Q?3jZFrz3KHkx9s65tDpEdjLe2vm8Xtn64Za6jV1bGQruv7ro8n06PwzINt6Ab?=
 =?us-ascii?Q?CDPVZrxuQaAacl437aJEz+imIr3XlxHkH0x3uZDU+wbDBAak/OsH07sKHezE?=
 =?us-ascii?Q?U768e0Et/8PACJ7GWmq+g/WFb5UnLWlx742brsq48hvsJScMSu+29ZPCRMFo?=
 =?us-ascii?Q?wk0OBo3Ceb9qBCGFF5iwvWAWPAKQifoL129HBANMwnhTT8uFSAvPr+JPn1fC?=
 =?us-ascii?Q?ea3JgS/1jbaZKRUeponCPMoj758JWLuYMHtBGjPNcheH/hgiRTtjZ/p1Cg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9DM5PR12MB1884namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d5b3ef-69c2-42c2-f4bc-08d99e43bebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 21:00:04.7892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffBOUbg9by13hEVaQv+SeTfsd5R6jSgqbsA/vG08VISccqGsNHUr/wcOmC3zhRgb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Ken Moffat <zarniwhoop@ntlworld.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9DM5PR12MB1884namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


Hi Alex

Sure, Let me check it can be merged into one patch.


Thanks & Best Regards!


James Zhu

________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, November 2, 2021 4:34 PM
To: Zhu, James <James.Zhu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhu, James <Jam=
es.Zhu@amd.com>; Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdkfd: fix boot failure when iommu is=
 disabled in Picasso."

On Tue, Nov 2, 2021 at 3:23 PM James Zhu <James.Zhu@amd.com> wrote:
>
> To revert wrong merge during rebase.
> This reverts commit afd18180c07026f94a80ff024acef5f4159084a4.

Missing your signed-off-by.  Might be better to just merge these two
patches into one unless they are individually applicable to different
kernels (e.g., 5.15 vs drm-next).  Also these will probably fix the
following:
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu=
gzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214859&amp;data=3D04%7C01%7CJames.Z=
hu%40amd.com%7Cd89a2e71a6204428008908d99e40368f%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637714820908943450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DwOm=
avKInLZrl3Qge2N83kgMh2dATo4aUH%2BW6QrPvL30%3D&amp;reserved=3D0
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1770&amp;data=3D04%7C01%7CJ=
ames.Zhu%40amd.com%7Cd89a2e71a6204428008908d99e40368f%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637714820908943450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dk3GJBSFKw8FJhGs9Urpm8PmFPzN7m0LFl5p7Wv1FfGY%3D&amp;reserved=3D0

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 7677ced16a27..be26c4016ade 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1031,9 +1031,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>         svm_migrate_init(kfd->adev);
>
> -       if(kgd2kfd_resume_iommu(kfd))
> -               goto device_iommu_error;
> -
>         if (kfd_resume(kfd))
>                 goto kfd_resume_error;
>
> --
> 2.25.1
>

--_000_DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9DM5PR12MB1884namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Sure, Let me check it can be merged into one patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, November 2, 2021 4:34 PM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@amd=
.com&gt;; Zhu, James &lt;James.Zhu@amd.com&gt;; Ken Moffat &lt;zarniwhoop@n=
tlworld.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] Revert &quot;drm/amdkfd: fix boot failure w=
hen iommu is disabled in Picasso.&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Nov 2, 2021 at 3:23 PM James Zhu &lt;James=
.Zhu@amd.com&gt; wrote:<br>
&gt;<br>
&gt; To revert wrong merge during rebase.<br>
&gt; This reverts commit afd18180c07026f94a80ff024acef5f4159084a4.<br>
<br>
Missing your signed-off-by.&nbsp; Might be better to just merge these two<b=
r>
patches into one unless they are individually applicable to different<br>
kernels (e.g., 5.15 vs drm-next).&nbsp; Also these will probably fix the<br=
>
following:<br>
Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214859&amp;amp;data=3D04=
%7C01%7CJames.Zhu%40amd.com%7Cd89a2e71a6204428008908d99e40368f%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637714820908943450%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3DwOmavKInLZrl3Qge2N83kgMh2dATo4aUH%2BW6QrPvL30%3D&amp;amp;re=
served=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugzill=
a.kernel.org%2Fshow_bug.cgi%3Fid%3D214859&amp;amp;data=3D04%7C01%7CJames.Zh=
u%40amd.com%7Cd89a2e71a6204428008908d99e40368f%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637714820908943450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D=
wOmavKInLZrl3Qge2N83kgMh2dATo4aUH%2BW6QrPvL30%3D&amp;amp;reserved=3D0</a><b=
r>
Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1770&amp;amp;dat=
a=3D04%7C01%7CJames.Zhu%40amd.com%7Cd89a2e71a6204428008908d99e40368f%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637714820908943450%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3Dk3GJBSFKw8FJhGs9Urpm8PmFPzN7m0LFl5p7Wv1FfGY%3D&amp;am=
p;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1770&amp;amp;data=3D04%7C01%7CJa=
mes.Zhu%40amd.com%7Cd89a2e71a6204428008908d99e40368f%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637714820908943450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sd=
ata=3Dk3GJBSFKw8FJhGs9Urpm8PmFPzN7m0LFl5p7Wv1FfGY%3D&amp;amp;reserved=3D0</=
a><br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ---<br>
&gt;&nbsp; 1 file changed, 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_device.c<br>
&gt; index 7677ced16a27..be26c4016ade 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -1031,9 +1031,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,<br=
>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_init(kfd-&=
gt;adev);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(kgd2kfd_resume_iommu(kfd))<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto device_iommu_error;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_resume(kfd))<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; goto kfd_resume_error;<br>
&gt;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9DM5PR12MB1884namp_--
