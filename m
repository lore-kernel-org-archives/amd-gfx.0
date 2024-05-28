Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314FFC25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 19:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4891011263F;
	Tue, 28 May 2024 19:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="usltsda4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BECC112642
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 19:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FidTI04BtkxQluesz1PyvKp+9dXAEekQG6vBawXeBtSyg4/XNXB6NIkQ2rGkFC3bzWLFONNNDZGR7AKjcVQsmejDAuh+w/gyze5Ml1srSnbz+cmvHzLaG5pKrrUxNTSWxMPWcT3Le07Sd2RSvArqzTthSKZmYvpLUVP9gMr7qKI6xyL4LZTXWHvMn0ONkTPw/aevwQ73JLt+serj4lVyCtG2feVinhKcu98eBF/Ff0lHdYSu/+AWvVe01QbKeq8Y+ID4Ogh6mYHaeOc815a/ksSUZkvmOBHEkpnSBf9dey13aIeBgBnzZazHkEt06UpDFqc9UTQfhFBJTnnqVOfqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvAUMyF9cqQ+t0X3+WrDJuf3vBQb9Q+VfMU39CQbNCc=;
 b=G1CqR1YeFVSUpycboevgL0VO2Rm1RZ27UAmRQRckmMeqAa+UkObKXqT4yW9/gLiaXxqJkhnzIuqtqcnYdgXHtVtaV251DlTbMnh7UtYr3nDEGe6cqKPIp/qJCEk52kVTCuOO8qhdRUBouqHTNpqcibwGewXyQ+8ztC6XhQ18ISLXxGCP71gmpn7rdVjWtGUv5hLhBLThiCeABkFnUNlQgNY+bJaS4P2wXMi2aKLroiVIaj30XlzXVa5RRgAk1CjyLLdq+bCiJ5jxlTt8tArnjKL/lBd09jvuGXpWAbdPmuiwWjISQZUMtJhWyvf0wB1y4rqhaRDHoRBo92Dlhiyxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvAUMyF9cqQ+t0X3+WrDJuf3vBQb9Q+VfMU39CQbNCc=;
 b=usltsda4fUT2TIO537xORzvjkUHVedETIB+vc9jJ9C+cOXMu251mhdkyPYw/rzCbBJug/GdQ3zfNGAvRlluKf70RzqhH6VDK0PENnMZpXv928aVvyYPAYJR9iLqJG/07ztGqRIsf21BrQWCKpu/i77NA3tsGWIgGoQv30HESRXc=
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 19:04:51 +0000
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af]) by SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 19:04:51 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Li, Yunxiang (Teddy)"
 <Yunxiang.Li@amd.com>
Subject: RE: [PATCH v2 10/10] Revert "drm/amdgpu: Queue KFD reset workitem in
 VF FED"
Thread-Topic: [PATCH v2 10/10] Revert "drm/amdgpu: Queue KFD reset workitem in
 VF FED"
Thread-Index: AQHasSPq0MoMMpmZ2EeObGNDFqspY7Gs/vtA
Date: Tue, 28 May 2024 19:04:50 +0000
Message-ID: <SJ1PR12MB62929D8CE5564ACAB1F39A798BF12@SJ1PR12MB6292.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-11-Yunxiang.Li@amd.com>
In-Reply-To: <20240528172340.34517-11-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=800036c2-cdfd-49aa-bf3b-adf548d4dc70;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T18:55:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6292:EE_|MW4PR12MB5627:EE_
x-ms-office365-filtering-correlation-id: 2e9802ac-df02-400f-7000-08dc7f490d28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?bWTOpAZ0Jlp45VG468Qx25IMcG0bO7r/gYZSMXgIQYYrXBTFP374ySIPe1kl?=
 =?us-ascii?Q?mnAyxfdCu0b0fTuknvAolNJW5MIGIwoFtU5cZEJHcl/V4HG1+jWcgwhdxZhS?=
 =?us-ascii?Q?Wvtkqf091J6UljJDAxnxsUVg1lYd/hUN/Ay7BrFthXc+aZTJcJkl9hL3RwyX?=
 =?us-ascii?Q?s+aK6SAZB4tRi8AnkEAHqprepKCpPCmPg8D18Nh2S80OTIA0cGkNBT7Tra1x?=
 =?us-ascii?Q?1sVYrqAb0Z8DCypaWaFbqAlpNrdZnTn1COsWzGs/1DKUrZaquprD7BJDZLOh?=
 =?us-ascii?Q?xvAUjQCXnMhT8Ul0jjEiqaAXX0/1xmvVexh6fY0Dh3xn7MDt7Nw0wcDbrYDE?=
 =?us-ascii?Q?VbUDvXfVRPx7w+USmpeJRYVZqdvXOH1s4CZi6DAje2o7x6wOEb7qnPjOaUiF?=
 =?us-ascii?Q?jO7c/ID1ILANWrjlDdGrgINtd5+T3RG9xqE+IN299s9muakdJky5DsnxuxOM?=
 =?us-ascii?Q?rdyRHKS35ekDktAevET2Am4pyBmBo5YhEO9DDZRY7mO1ia2UczPqBvvnbeh4?=
 =?us-ascii?Q?qVHL3OsQmoJbKbT0cJJtGZ7WG8ovVqGzLqTgsXf7N8+lHpgP1jtiSy0hrVoH?=
 =?us-ascii?Q?Sb04DBqXY9mDa7y1NDUEIKJGpGbUJDK2yAIk7mk3eCUnNmUACp4k5WZkFook?=
 =?us-ascii?Q?agwY5gLH1FVBOZIVQCWQytoKPl1GTAXfe/lj2qM0ARQYBXKc3wr1Zc8tydA3?=
 =?us-ascii?Q?qIky3cXxqTPQNrZVSXNHx60ViEqawmlUdIlYDeh8YJmtEm/inlt8ynJSqhZh?=
 =?us-ascii?Q?VCvBTAXMBvhR6JF4E26rpLWUCuLksw2MvZ+H3XH+zN+Vy7m3naq2Hnp9f6go?=
 =?us-ascii?Q?JyJlw1ZuNP8Gx446/UPJOar0UA+42metaswju6LLLQ6va+iuzbX87UzXmV2/?=
 =?us-ascii?Q?6oXaxsFeJ1gPOH03beQEwCmM7KPpCJwEAQBr486L9t2RppQcmQ2JQKQlhlHK?=
 =?us-ascii?Q?dfg6kMIL1x8NXpIS+nW69tziJHAOMcfK6vQGfonChDSRCZGjTGLUh1algbKC?=
 =?us-ascii?Q?CbHNkJRas5+K3eRFgCwOLaQSb2tSuYqsUwnsZbIfeT0ZM/VZbOcx5SxQW8R8?=
 =?us-ascii?Q?k1nl7bUrLPTaP1z50d00LS5ExATdYKMaU32LXZDtpkag+2OY4EsyBxFj/b1w?=
 =?us-ascii?Q?+xTtIIpc1es5Y8rZYWaZS8m53L2vxWr5TtSkuSfHsAgSybUSvc+VJZmte6Ga?=
 =?us-ascii?Q?9uLGh8GX71dq2JejNcanHRJUQDR9TbuaIPej7uvznEQTCsG99GYd48lEWIbc?=
 =?us-ascii?Q?PKATz/7Qyw0krNFc0L9j5sF2g93sDbg9SootGELcxI6v1YUsTjZqojkwio4c?=
 =?us-ascii?Q?Nhpe7c641KtLxWa0v5nzO+FGiZ6VibxJSiffOvJnebzMmQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6292.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?36yv/woVafui3m7aKD82RK6aO2fUncMBy56rnbCVAQq8C/YqBrryMB7I5FVK?=
 =?us-ascii?Q?tQK7Lygn5fuMqh9ayDt+MfT23jzVQDk5rB2C3IrowDkTSrjFvBdzL1yOV6LQ?=
 =?us-ascii?Q?2kx39K4JC+LY5iPat3Kwi79bywfQyE6wtcZ4lfWcan0AZJTpF4V1aUykdazl?=
 =?us-ascii?Q?F8WRo+MmsbKXTY8O76KtOlJhC1uG2+YwneV9YIUUZlH915DVtlopC9bxw3gs?=
 =?us-ascii?Q?BvB7j/8gFFncrjv7D866I34k2LUqLYhb4KK8HLQPKnlyoONPAIF/tQJ99wcH?=
 =?us-ascii?Q?JWvRlkWbOjZo1KqJKpWHrk7ite/unyDLU6aXRRdXQk4MwafCNOMmFCeq+nkT?=
 =?us-ascii?Q?k+Hr266U8YtAPJ47SQuNbxmtV3T20GsQ8t/SnVde3gWyTsUpT+GimTgCJ47g?=
 =?us-ascii?Q?f/tBV5czn7Wad8PT2Dql/hqneMPFoEEGq7cNJ6pgSumSHrj0dzU35kCQ09U7?=
 =?us-ascii?Q?gptVTxjqyB45ay4WpU74UUBqPQE+MXo6GNn0oxKOnDTHXEBYzaHuToiot1Ix?=
 =?us-ascii?Q?/q2ClPrqmIbGxsBA500mHico334of69YoII4aGwuUW/WZmaiXxGLG4/sHMde?=
 =?us-ascii?Q?N8y10b8GPq4SpbbyBQfp6ZypV/9jbCWKQvBq2hdGF1o20x6JooTaIjN27ZRi?=
 =?us-ascii?Q?eV2ajdRmpYo6E60R+M+6Xg9PXJjBUCQSWPNZyXVnibLgsIApFZyZSt6SEQPp?=
 =?us-ascii?Q?K4XKNvgMLEI4cActJqvIlU4iBNAxrG5wnIB30J/t9PkEqBNxYTFH+KUxWxXb?=
 =?us-ascii?Q?S51uQtPqYOjXT6RwaB8GxKUxXWZUtViQO6+C3gSFiImrtEwwBiVs97/Do5tR?=
 =?us-ascii?Q?9KMb2N56TZBrFIadq0+XfW45qg/2Lzv6IlNwdtYHJHZRXM4PPIzpc+GLrWQV?=
 =?us-ascii?Q?V1Zajoxfe7yQztYxguETIi1WlW33wFBFyDwAjCH7XQorTwGGHpomee0uhlyI?=
 =?us-ascii?Q?GX2yh33jhd4kHosPeWR7KXHecOUugTeXegbhozvDN7zwkY42B/2SL2J15gL+?=
 =?us-ascii?Q?eLwnb6P3ioVHBNDeHiycnpTFJLoKPkAoAdls60PwW2wqpiWPIceP6wElqZ/1?=
 =?us-ascii?Q?0PX0YprM0WWCsQiCJ21eDYHB/ycJPTiWUEvDTIC9QstptH3UgXZNd7pkwp3n?=
 =?us-ascii?Q?JJl/AHlF2H7VCVF+b7cLU4Tms5fa5xZSr4oa8o4pe3FuRbNV5hfSujhOzfFV?=
 =?us-ascii?Q?V60QaCAtuhjfaCHnz787XKbarHsuXSwAfcBvJ/oZUZ8grzgMKwXnBtxg5Rm5?=
 =?us-ascii?Q?GbKZjE76wT0fspYf/cS9tBdhLniaRJlVdPYHgdwTEEVfchGVWYHFxVut9GqH?=
 =?us-ascii?Q?/Jl2ejM2BCNVICQ9me+KRqu3KfZHsOu0XeD+8g2dmtYA2ozweD8yGEjhBGvC?=
 =?us-ascii?Q?YJiDMHXxBzw0twt4sTSB04JlDDEQbwq+fmyKA0Dgp3EZzaB6vkAp/c5dyiMf?=
 =?us-ascii?Q?CHBIu+ChhINMyK5mk747QbTpUzn3uc4Snp5jjBcIYBhPOZIHvEiXL865abQa?=
 =?us-ascii?Q?2s1HDjPcFdF3j7cAHzi7jYsbDSCbzFPmdiHUeyJXMpH+lP+bnrGSY8D89KUr?=
 =?us-ascii?Q?Y+aU+5gGle94HpNPrJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6292.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9802ac-df02-400f-7000-08dc7f490d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 19:04:50.9742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuqgiE5IerSNMaiphyyw+9uShibrZ4Xfh9xl+CC/rg2wguQRLvwRup63UOJwV8Fym/gqGvocYcx6JrKrAYjOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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

[AMD Official Use Only - AMD Internal Distribution Only]

Nack to the revert. The FLR sequence is defined as the following (host-init=
iated reset):

1) host sends FLR_NOTIFICATION
2) Guest gets interrupt and queues FLR work item
3) Guest sends READY_TO_RESET
4) Host sends FLR_NOTIFICATION_COMPLETION
5) Guest starts recovery

In RAS FED, guest interrupts are disabled and therefore it won't receive #1=
. Consequently #2 & #4 will break.

It doesn't make sense to re-use this sequence as-is in FED scenario. On the=
 other hand,
KFD reset work item performs the guest-initiated reset:

1) Guest waits for mailbox to work (handles the FED disable mailbox)
2) Guest sends REQ_GPU_RESET_ACCESS
3) Host acks back
4) Guest starts recovery

We should keep this commit until proper guest FED reset workitem is impleme=
nted.

Thanks,
Victor


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Yunxiang Li
> Sent: Tuesday, May 28, 2024 1:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Li, Yunxiang (Teddy)
> <Yunxiang.Li@amd.com>
> Subject: [PATCH v2 10/10] Revert "drm/amdgpu: Queue KFD reset workitem in
> VF FED"
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> This reverts commit 2149ee697a7a3091a16447c647d4a30f7468553a.
>
> The issue is already fixed by
>   fa5a7f2ccb7e ("drm/amdgpu: Fix two reset triggered in a row")
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 44450507c140..4bacbf1db9e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -616,7 +616,7 @@ static void
> amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>                     amdgpu_sriov_runtime(adev)) {
>                         amdgpu_ras_set_fed(adev, true);
>                         if (amdgpu_reset_domain_schedule(adev->reset_doma=
in,
> -                                                         &adev->kfd.rese=
t_work))
> +                                                         &adev->virt.flr=
_work))
>                                 return;
>                         else
>                                 dev_err(adev->dev, "Failed to queue work!=
 at %s", __func__);
> --
> 2.34.1

