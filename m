Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F23C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 14:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6361110E88D;
	Fri,  1 Aug 2025 14:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M74jYSZV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BA110E88D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 14:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZB4ZhjGAw6W2MVikLWL/7gCSrmZQJ0pPcuw9sG0pdLQJ7VwaqdNCnSAA4OOLnk+sI17EsqDosapzvXfrLZbeCk0BasYzSM9czHbOymm/0k/wVTDxHENFnYOGdk7KIjep7kJsTr9QeWFvoqgx8P/hyvmS+9BzqE0LqtYU5u5OAF+R03tdqqMUYpygSEltKsRtm0V/iaKKqbD7mPcl4ieYSsW1hWB4qsmmo7YV/qptOoLJ5/LOl+MJpCp5TyU4uVR8enLlZCLmYas9ulB7I64Awtfu/xMy3WUGyNqniBdoUM+R8ev4QpJa54sW5oMRdpaKYr4rgPuIEtd3TEzzPEIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjhEPkpk6ZhWRdhH2qdWjBdOuC3eAW4uaoaBQEFy1G4=;
 b=Y23WDMzFERQSnxVISmupxitvCY3+Fwt2ayDSxsLx36WDB/a6vShxfg7dm9jIwkwkNc27RAqZvPwoykOfw8Jw5BKxsCDvNWjCyIv7com/AwNvIAaHB1EaDpTwTTMhXT+iM50peVAddkLb6/p555/cy47m+jaTANwdr4tGzRGo8mHef32YJStZVsymxedpp+FXiVS7i1kx+hgVpjkHfDFqxs6oUGXRxg9/YjJDIAr8z1WbTLPdtCnS6HVJsgRYnb03JFtY1OzaB28NwMc1RsFtxg6JX8pzoUMJ/2xubYHJNJr2+jfMfHh+5ygn/xYRis9Iip0NYZPp/BCfb60UWfGxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjhEPkpk6ZhWRdhH2qdWjBdOuC3eAW4uaoaBQEFy1G4=;
 b=M74jYSZVs2Akuo9RHzw1Q6yHy5YKZ3ql1TyKUw4hOIdqaGZIdXNAQ1erihUGnRfdCO7F6Ct7JA8t0Dfl6CX9CT65o5ctDooCWGhqWVtMmK7FhpNpfX6nHG8CmNjeeTwThzDerzJqnLl+B0angAemPuFPtXikxgdfDWo+vmseaMk=
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:43:21 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%6]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:43:21 +0000
From: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Destroy KFD debugfs after destroy KFD wq
Thread-Topic: [PATCH] drm/amdkfd: Destroy KFD debugfs after destroy KFD wq
Thread-Index: AQHcAu8jJtcddO9BIEyTW8tV6bKv0bRN3ubk
Date: Fri, 1 Aug 2025 14:43:21 +0000
Message-ID: <BL1PR12MB53360CD154457CDFF209A4A48226A@BL1PR12MB5336.namprd12.prod.outlook.com>
References: <20250801141801.130397-1-Amber.Lin@amd.com>
In-Reply-To: <20250801141801.130397-1-Amber.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-01T14:43:20.5640000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5336:EE_|DM4PR12MB7552:EE_
x-ms-office365-filtering-correlation-id: 4bc5158c-9dff-434f-8b90-08ddd109c2e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xUEzN2DVij4m8tH3YUDeBSTT6Q1IGDYthljEn3QNTZbMS6IccWUBttq6Gy?=
 =?iso-8859-1?Q?oWilHJsxvzq10vlmKEUT3V75TKKdwGMvD+lCjHLdgs2YdxxHsXtjgGQefS?=
 =?iso-8859-1?Q?wjP5eILSWyG0e0xEMk5D9MkY+HtszVuyXKAX4j7SRjNfhQmApI3W1qu25m?=
 =?iso-8859-1?Q?MRNtgHgKLV7hRFRKrjAnBSlZKzs0t7Ks1atNMjniRn13vaKynwDBqmgglL?=
 =?iso-8859-1?Q?034aym4iZ2Mp+SN+2H4ptemMrSleQAYrWMt+Z5Z3fnD94JZWUWwjV0uq6T?=
 =?iso-8859-1?Q?3O8R5noY9ACZbyzHd+IRW6pgTrDjmNk0Zh682F7POzTfyaA1fhaao2JI2N?=
 =?iso-8859-1?Q?rGdVqUbvB1mMavzqb/T4GIsVjrW3jLg+V9FrwyQMPq0IiITDLgI8blWnWY?=
 =?iso-8859-1?Q?6MHAqrbfaeGMUa/GEd50LiDZ2zsaKpyr+XRxZqNYw/GPTxEyYonDbJV5N8?=
 =?iso-8859-1?Q?3oEd6+QI1PV6ArfCuITbyeL886lwdxl6+VqsHt3UPR8iwuFzgS6sYRMbxI?=
 =?iso-8859-1?Q?KwgrCjL/VGOSQ0Fip5qk8qUZadEtsrApTkb4oHTbFsGx6yjYRJ7/7X4NrQ?=
 =?iso-8859-1?Q?C43idQz7NzL9U45Surm+JLY0WyNS69fz4cI+BthXSCwv9I7moSkdcPInk7?=
 =?iso-8859-1?Q?Qq3RNVnKrecbt7v9ZPIpeEmKD9Hm3tq/gkWyMsuc2qAWPrkSj2bmJgHrId?=
 =?iso-8859-1?Q?QYOXEVQ69Pg9h1ppbwjCnaEbQOTD2fNos4vci06SVDN2/tJeiZ96z+urcg?=
 =?iso-8859-1?Q?CPIZ+eKAHr8ByXUzEQl5FJLKnCggT+CTgSYTcJXdDK28yVEdp7tw/IRJzg?=
 =?iso-8859-1?Q?h2kTzLUm+l4kkQB/Wfi5AUnf5xdQQJlntJeoQr6sMTWAdPVQfBZQ7xS5Up?=
 =?iso-8859-1?Q?BkKl/7llD9B7QIgmovsO8nnqhdf3dvaLZCCS4bA6jCrEThf7a7t15uB1ld?=
 =?iso-8859-1?Q?HgEOeSo4b4cMS/9xCiW0e7RN6VYwtQ81bq3JXpb/XiVPH7iyOGXl2ox013?=
 =?iso-8859-1?Q?ZhKB/C+3b66jLhIFIsOnmSPS39Z45z4htv46jB8o/a77r3VSzDqMyMrRhF?=
 =?iso-8859-1?Q?M4sOow+NZ/iEQU/mfu64KfLVQmZgONSqMi9et3SH6gvJtEG3Ro7J3a+xz1?=
 =?iso-8859-1?Q?TBtxmhHY/SXuBh35AlASvjrxG7nTjMUzSV5iNkxpuvxIixBip83ozIpsKo?=
 =?iso-8859-1?Q?eInco71Nz+Ou0wVUpNn8Gmjuu6jGYuRaeFbh1iQ0JOyMYWVrtrD4B4cRS/?=
 =?iso-8859-1?Q?9LdXQN31zEVFXYAjNCVWAOxFmyP+c5YMeh9UuOoghVK2IFcieS7dXWUg/I?=
 =?iso-8859-1?Q?Ziur3aNPjRIShWPs0EyTn9yRqPU5wa4kBqjo9Iv3nyLzVf0gLAjLq7CMw4?=
 =?iso-8859-1?Q?OhgnykyUZic0M+T+Xdf6hl0obBsvOdlfEF+I6VG6kUgK+NbuIzjNvooRUQ?=
 =?iso-8859-1?Q?JcnxuBFbaBpQ6tCbhnzQyqPQEFqeu2SvU40lG5XflCv0l3+t2acHKhyuOS?=
 =?iso-8859-1?Q?EtP+Ot8JwkjUjoFdk1mT2zLLk7oLJ94G/B2xS4shed0A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yjJLW7kyHiioZilF7NFMmlC0BxexGJEd4elEKwbxjJNzu3JyK33+u9A275?=
 =?iso-8859-1?Q?gMMpX6K7wxdLcu1Nq6ex5/+ONarZ0TfZbcGWPkOWamLOotJeeXlF7FyiHo?=
 =?iso-8859-1?Q?FVys7QzAuqY/uWirqwEN4lXccursjK8T6lw9DMV/pCZrlv4N/W7Rd1I/w1?=
 =?iso-8859-1?Q?2iuHWKvRlIPHFGnoeTivGQKsY2qgBna7sy7jnX1NXKd/FsuFZiO4i73gTG?=
 =?iso-8859-1?Q?NCXQNVaDpJxnePwZCzQ5HgC82KygrtgEMq9Efy+s1iFs6EOUKDHZcfMsuf?=
 =?iso-8859-1?Q?KHMmQ/e29dQv4A6E7pVTIha6mypveSHveg3YMiNpyeFycDbu8CQQqsS6pv?=
 =?iso-8859-1?Q?Cp85V6EE3y67wRDahN6EihFyc5GKVn+18+CNSC7iSMnEdmE1hvfRv1VHxr?=
 =?iso-8859-1?Q?QwlWPByfbuDhZjEJBzvPz2r93/EDWvqELE6abVWJWeFH9FF7H0Va3VVDXl?=
 =?iso-8859-1?Q?lbHe4eX5gYgse6n2rmJQnRAmXIRvVBJliU5t4trvnIDy6PEIlqlLLE2eG8?=
 =?iso-8859-1?Q?QS41TrIp2E12ZfUM/pdub6pKHSHF2SUB2JGVxz/owTWq6X7MYcTQwHF+ip?=
 =?iso-8859-1?Q?Zcuebdkf+YgY2r4H+kXK7Zqc5f07l7xnoPTI4aksSWRr50cSadoTdzCNiB?=
 =?iso-8859-1?Q?X57kBktGAGlzgRF50spSRHZsjZe3ko4vAXX30jdcyjpq4/c+iLbGx5p2yw?=
 =?iso-8859-1?Q?xVGqbuT+k1dgyRKPMNW+GH+mzOwvyNG9j5yWMhHWZ7Lw0app6BEfbOKugB?=
 =?iso-8859-1?Q?v2w6TRkXr2wO1Yn0pvsxlb4bkFFJas7DhZ1dQHBQLMZQC38/QYwcoSf5xr?=
 =?iso-8859-1?Q?GorxFkcHWvIPb/yGVyRYqGBIB20+WYdu59dzF1YBzoPaEvK2vAvGZ7XYEO?=
 =?iso-8859-1?Q?jYTc2KxWeS9Mmk5MENcy8uzTeI5exZmWNLGiNy2srhwRm9DnmNweEgpvto?=
 =?iso-8859-1?Q?p4mk8d/GN1f3YJftmEepolayNx0ZWc5QD+110oFU20YgeNhNEDh+02hgYz?=
 =?iso-8859-1?Q?0MWBqlGjBYaJ9p1stsLjGnllfVDfulqufTDIes8/YsJb0Q8nMBKKg67ZA7?=
 =?iso-8859-1?Q?AACuak0IXiMVEwzSV3wxF1WFC0MDchOjbJsBJo34RimbNCk8ikY9u9MCEj?=
 =?iso-8859-1?Q?P0B8r/D7yxqFqUatR4eCh9oG/OGkhltjvnrbMYxnaPw4l2XVC0D8dVic/s?=
 =?iso-8859-1?Q?W/Hh3RRbOJ54poBmQTtOK42xAFrSOr62/f97fkV6GkeFU3WJ5lXs2ndNje?=
 =?iso-8859-1?Q?dwg83GndoMQd98OAq+i5Ex+92PMrAqdV6clkfDeDl9r1mg8mMnLlBiU72W?=
 =?iso-8859-1?Q?6piusKxq/Kr1ODlD1wsgxHCNedlckyOCX4IYuJN+ymm4AMV11fQX+3Stb+?=
 =?iso-8859-1?Q?nPmgCXDG2cP/rcjbCFJpCm5aVsbQa4S1zD/tcOopBWDW0aAKXfTl0k46+P?=
 =?iso-8859-1?Q?zJ7mw4Q/yiQ2qUrjv3lMMVEQdWksqc4pZFiUunZP/7XyJwm4o238G+D2nf?=
 =?iso-8859-1?Q?YmkcuenhtBqELESg+PuG/DUJoB2Q1UXUdiXrx7uSw3By5JVtoalNxXTROA?=
 =?iso-8859-1?Q?55NCN918DIHluSHgd1xVodRT+uCua0PCt5SFXxAwtanYZhizWT5bwBv6Qy?=
 =?iso-8859-1?Q?v1TWG+6PeSG6s=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB53360CD154457CDFF209A4A48226ABL1PR12MB5336namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc5158c-9dff-434f-8b90-08ddd109c2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:43:21.0936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JFxAAa1KQqwtscUKvU3kf5+Yvxthaa1bE0OoiXsX7B8i3nZJyzOICIPdcZWigF68SbzQxz4FGT1hd9AXzPlxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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

--_000_BL1PR12MB53360CD154457CDFF209A4A48226ABL1PR12MB5336namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

________________________________
From: Lin, Amber <Amber.Lin@amd.com>
Sent: August 1, 2025 10:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Huang, J=
inHuiEric <JinHuiEric.Huang@amd.com>
Cc: Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Destroy KFD debugfs after destroy KFD wq

Since KFD proc content was moved to kernel debugfs, we can't destroy KFD
debugfs before kfd_process_destroy_wq. Move kfd_process_destroy_wq prior
to kfd_debugfs_fini to fix a kernel NULL pointer problem. It happens
when /sys/kernel/debug/kfd was already destroyed in kfd_debugfs_fini but
kfd_process_destroy_wq calls kfd_debugfs_remove_process. This line
    debugfs_remove_recursive(entry->proc_dentry);
tries to remove /sys/kernel/debug/kfd/proc/<pid> while
/sys/kernel/debug/kfd is already gone. It hangs the kernel by kernel
NULL pointer.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_module.c
index aee2212e52f6..33aa23450b3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -78,8 +78,8 @@ static int kfd_init(void)
 static void kfd_exit(void)
 {
         kfd_cleanup_processes();
-       kfd_debugfs_fini();
         kfd_process_destroy_wq();
+       kfd_debugfs_fini();
         kfd_procfs_shutdown();
         kfd_topology_shutdown();
         kfd_chardev_exit();
--
2.34.1


--_000_BL1PR12MB53360CD154457CDFF209A4A48226ABL1PR12MB5336namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Lin, Amber &lt;Amber.Lin@amd.com&gt;<br>
<b>Sent:</b>&nbsp;August 1, 2025 10:18 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
<b>Cc:</b>&nbsp;Lin, Amber &lt;Amber.Lin@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdkfd: Destroy KFD debugfs after destroy =
KFD wq</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Since KFD proc content was moved to kernel =
debugfs, we can't destroy KFD<br>
debugfs before kfd_process_destroy_wq. Move kfd_process_destroy_wq prior<br=
>
to kfd_debugfs_fini to fix a kernel NULL pointer problem. It happens<br>
when /sys/kernel/debug/kfd was already destroyed in kfd_debugfs_fini but<br=
>
kfd_process_destroy_wq calls kfd_debugfs_remove_process. This line<br>
&nbsp;&nbsp;&nbsp; debugfs_remove_recursive(entry-&gt;proc_dentry);<br>
tries to remove /sys/kernel/debug/kfd/proc/&lt;pid&gt; while<br>
/sys/kernel/debug/kfd is already gone. It hangs the kernel by kernel<br>
NULL pointer.<br>
<br>
Signed-off-by: Amber Lin &lt;Amber.Lin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_module.c<br>
index aee2212e52f6..33aa23450b3f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c<br>
@@ -78,8 +78,8 @@ static int kfd_init(void)<br>
&nbsp;static void kfd_exit(void)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_cleanup_processes();<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_fini();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_destroy_wq();<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_fini();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_shutdown();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_topology_shutdown();<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_chardev_exit();<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB53360CD154457CDFF209A4A48226ABL1PR12MB5336namp_--
