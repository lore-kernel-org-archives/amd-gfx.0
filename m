Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 05:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E33D60FC1
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 05:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E33D60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234CB6ECCF;
	Thu, 23 Sep 2021 05:48:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17986ECCF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 05:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlqn1eAnG2DOVxKI7X01K6yiFgZmq+gV7ji7tIMzmbD4TFq4KnwoZ3br1UTQN3uBKVHhZDcBIWp8dYdVJ6+V0k8g9Kh5RrtHrQrnV+lbXJDzD4qiHhHCKLK8n+agHsDHW6M7MNolQf2OoJizTx4r7++EBF5+V4c+vkS1Wfw9n0b9a402syYnvtwQOQ8G8kG55//AT0KFlrQmYr54JfsURm/Oi1sTlHSfkSTJoxT6AUNoAAD1dDz+8CQ+JymTjcX7rGhomcZvbZLqLCc57HIYhJ2xdAtJVtLU3+D6zj8DtL8G4jnTVGBJidcF8hqVr6XdK8eghI8xCdgvWd3uUkZxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qLqGQS53PpNMLQdIymgOOcnImK8/kQ1JhsMbcmsHq0w=;
 b=UFi8nw/DY+ZduynOk9p6abwLH/f5BMgcr+CqkDTwS9L7qs+Z31TugAr5VfeWt28Mjyjh3+o53LSFjXnkOzEWXmLHaZxRKHn5XGGWa5Uhk75eTzBSPu47QTs0DxkvghvXr2Bd5x7LFuK2PUE37KpRKiZVYHhJlrneVTnl1gVCZ3cFtXk/aPl/vpToF14MOnoFrVDup2dxnAdkwwZIHanCT6ykJn/g5gCdzcsju9FrPdpuiPnqjqCCJ4QO4+y+zTDVI1i9gZnWqn+JeXkRiCtsU5Ym/N0xk7r45mgLl3RGg940uBX4+dSWOJhCIeRmznbWtxjVYsRdk8EdnT0jRpwWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLqGQS53PpNMLQdIymgOOcnImK8/kQ1JhsMbcmsHq0w=;
 b=s6uc4MiASALZJzaVQjCWNkESUJDx21XJK2Mcr/bx9ASlf8lL09kbNpvhsKZ8SOqoWp4q1EtV70drAowxWCYV/UOz3AU6GIlLGjwGT5kufM089Qd9/4Y8D8k9guQXAsYK7AdM4OlGuw305Qi6Nb3dAl5CJoVtNetCtJbPt7MMzkU=
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB4698.namprd12.prod.outlook.com (20.178.3.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.16; Thu, 23 Sep 2021 05:47:57 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::f8ad:7908:6643:2afd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::f8ad:7908:6643:2afd%3]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 05:47:57 +0000
From: "Keely, Sean" <Sean.Keely@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, "Gong, Curry"
 <Curry.Gong@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix to use real compute unit number for
 shader array mask
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix to use real compute unit number for
 shader array mask
Thread-Index: AQHXsD3VcfInhdSpPEq6uNf8JqU0nquxG8bh
Date: Thu, 23 Sep 2021 05:47:57 +0000
Message-ID: <DM6PR12MB33555F49DF56C6721E9F692994A39@DM6PR12MB3355.namprd12.prod.outlook.com>
References: <20210923054201.1433036-1-ray.huang@amd.com>
In-Reply-To: <20210923054201.1433036-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T05:44:52.0006148Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d8795bb-aabe-453c-e6f6-08d97e55b1db
x-ms-traffictypediagnostic: DM6PR12MB4698:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4698873CF00741DE1395BB8194A39@DM6PR12MB4698.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPTRPheh6SMsjjAhOQppVrpS6hL2jy3adhi7MojyYLB9kRU49Xgv1zH2aZBRrSB/cqXjCCnW2s0rqTzMzPaqyDYNjRFKoz2ja92TKD473s5zCyT5XcV0z2R7aIpfpua1VsNNe9nn+p07dLyejRTH70xpWGAOLEVZ7A/8M6sUh9S9JEjBbXKAgpnER02OWl3NaPHDAlPsiO7PpNp/22Tz/GZeMb1vr7wAwdH4AxvnOZ2UJOTAivmgCW/XxDUn1Oos0FGhDeNualip0Yedij0ka2QLHJHImigOOa/MmLAEzNXpJledbdM3Hgnk29qgaYlPDugi6CrggrhiKNZvSiPxCngtmvHZ8UksJICgRlEngX7Ny8kTCcKvFqtGADfUd40JgpCMO4hCRmk7EXxfH24Ew47sm9EnrIgVpe2nXrJeIROChiNlnGh+x7FJdOR7TJi0sH5wSajr9BPsK4YAPqEd19PGS+gN3hJzyyLh3sBaZ0xyv7LuTXRQelozK9tgqRtfc+Gf9F1N1bSgHQ8q5BMWOv7NwnjhRStvDh1ZU72rWyeY8gp1RekLAARtY9iNMEXWdzbRBYARQUZXsLC2fMQYnWP847Y8eGoTqLAX1XYO6TAFuNuKDjthFgQA2mhQUvP4JYiRqG7JRjhK5GHqRqRusD89j/+ys+WEUD04nGPZfRShNPQ+dBP94F2vgTrHtnSdSHzZLSPRFgPtXeN3+JQibQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(110136005)(54906003)(508600001)(76116006)(38070700005)(38100700002)(66476007)(186003)(9686003)(316002)(8936002)(55016002)(7696005)(53546011)(91956017)(122000001)(2906002)(8676002)(6506007)(4326008)(33656002)(86362001)(52536014)(26005)(66556008)(5660300002)(71200400001)(66446008)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J0na/u7TxCOk8q/UUGu9ciEmIUViI0SenGc9zuAPa/AdYilCsjOPPad+c2CE?=
 =?us-ascii?Q?NxsCD5vC43WhtL6cla+R9Oct5K3JplQ2jJ2rFAzpnAnlwqd8o2NqXOUv0mhi?=
 =?us-ascii?Q?tLCFnUGu4zaAsWji1sqLSVyj9Px8oTJl5aJ3dAbsUGbcpjZBJsuPzAaulAHc?=
 =?us-ascii?Q?bHAozlGEgo0RYLqFJqwRSgDAnfwyD17O8BBe7FlvLFCNlRbFrzyVrRLyy09R?=
 =?us-ascii?Q?t0FGm8FTRoWiNLImg9EnMZAlV6ORj58babfokNJibuogtRkDLNy59S+aSy5u?=
 =?us-ascii?Q?VEFlsIAbyeaEt+bNhL+aSf0YLxMzF+SMm+rZfLkbBNbHvSw7JtpgdyT7ZJG1?=
 =?us-ascii?Q?QYIloSVR9Nt1ioWc8GsKL+A7OzsPeKi1PVHEJaR9HPdvC0F6Ml1fRAh1/z1V?=
 =?us-ascii?Q?jpEc3eAmtd231r7TXSVcsOj+t0CCN7bYvfYzkOv230h5hUw+b0HqE1fLKHyl?=
 =?us-ascii?Q?tj3r9lebOOhcan3K/FvzBEJlJRvUkvHmJYPPWyQYUdP21CvcrsCON9Bz2lpZ?=
 =?us-ascii?Q?ToHmuc+Lg79RKtfFcM3q9fs1/He4BxxegCjVVFUTH74ZvodsmZBQToQGbZRF?=
 =?us-ascii?Q?bdBDNg+3HHkgp/GsnNonFsGxCtjSNAi6bS7gixi2/XY9D+/7yPZ8CtIrolou?=
 =?us-ascii?Q?wvcxbMv+9egXi7hY7Bz9ZMZnKy4nRB76m5QT+bFhwAcNaPbj2xTiMNEhwJIS?=
 =?us-ascii?Q?xFDLgHBzPycLtaeFYKvawDbhIAWBeWMWYTLmqNdFLLe8DfUYp+G1g/lz0w9G?=
 =?us-ascii?Q?+DP1HO6lMpDf5dRt1hvVce2s2zD/lvUf41PYJrluJbuopSOHzaorQ44K1/8R?=
 =?us-ascii?Q?MYhwaOjv642UKcOc6JXrkvgw7WKbWa6mFNe9sqfhARyVC1xna1w0nmMmURhH?=
 =?us-ascii?Q?zWRcdgwFnLaj4HYmM3q9GGV/y+VGHCqgwcgPdHFeaW/CDNu2B34WJTIEnZU0?=
 =?us-ascii?Q?iBcOQlV4lbAz/rLsdtBzZl212kAlXs9Z2ygDdpdLaoyRTniOSULAZBzId4z/?=
 =?us-ascii?Q?WfRGGHdxiglGN5BHQ7HQGix6DRPG2ERCrqcthYYHFXJCl4N7lg6uNkP8uJZO?=
 =?us-ascii?Q?EQdMBrfi+XcmlTRrkeNUiQHb8d2zA6fSyx+laDQ1Wq3NO61dYPUXY9s7f7+/?=
 =?us-ascii?Q?oOtyxtBTejHbp1owxjCHGHssvAijMnzF+a+IldTnzG7nZCctPC1DRQGnSHT7?=
 =?us-ascii?Q?/T4bdE+c/T32C7BzJOtWrcNtAzJeUipneo7X8H9KT3n3LAcW8ic/bEAk6SRg?=
 =?us-ascii?Q?Kxfzf4kzFhtHFjnExrRtZUw6ejYMKeD0ropBZttO5ejCBAeRquG4MIUPmllU?=
 =?us-ascii?Q?FiCfHv45rTkiW5qL4w95tEXrvSGTkHd9/IG3qfCcOOaMvg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB33555F49DF56C6721E9F692994A39DM6PR12MB3355namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8795bb-aabe-453c-e6f6-08d97e55b1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 05:47:57.0594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIXphnILGaySnlj1zcR2v3D+ZKrGGPafX3rWNFD9Oe758EsFypbM4vvo7AdiQl0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4698
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

--_000_DM6PR12MB33555F49DF56C6721E9F692994A39DM6PR12MB3355namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

That is not how the register works.  The *16 has nothing to do with cu coun=
ts.  This is to address the upper and lower 16 bits in the register as each=
 half of the register programs a separate SH.



________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Thursday, September 23, 2021, 12:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix; Keely, Sean; Deucher, Alexander; Yu, Lang; Gong, Curry=
; Huang, Ray
Subject: [PATCH 1/2] drm/amdgpu: fix to use real compute unit number for sh=
ader array mask

We should use the real compute unit number for shader array mask. Some
asic doesn't have 16 compute units per shader array.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c
index c021519af810..0891c937f4da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -159,12 +159,12 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager=
 *mm,
                 se_mask[i] =3D 0;

         i =3D 0;
-       for (cu =3D 0; cu < 16; cu++) {
+       for (cu =3D 0; cu < cu_info.num_cu_per_sh; cu++) {
                 for (sh =3D 0; sh < cu_info.num_shader_arrays_per_engine; =
sh++) {
                         for (se =3D 0; se < cu_info.num_shader_engines; se=
++) {
                                 if (cu_per_sh[se][sh] > cu) {
                                         if (cu_mask[i / 32] & (1 << (i % 3=
2)))
-                                               se_mask[se] |=3D 1 << (cu +=
 sh * 16);
+                                               se_mask[se] |=3D 1 << (cu +=
 sh * cu_info.num_cu_per_sh);
                                         i++;
                                         if (i =3D=3D cu_mask_count)
                                                 return;
--
2.25.1



--_000_DM6PR12MB33555F49DF56C6721E9F692994A39DM6PR12MB3355namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
That is not how the register works.&nbsp; The *16 has nothing to do with cu=
 counts.&nbsp; This is to address the upper and lower 16 bits in the regist=
er as each half of the register programs a separate SH.</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
<br>
</div>
<div id=3D"id-ec38a610-bedc-41cc-8e8d-68642b653015" class=3D"ms-outlook-mob=
ile-reference-message">
<div style=3D"font-family: sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>From:</strong> Huang, Ray &lt;Ray.Huang@a=
md.com&gt;<br>
<strong>Sent:</strong> Thursday, September 23, 2021, 12:42 AM<br>
<strong>To:</strong> amd-gfx@lists.freedesktop.org<br>
<strong>Cc:</strong> Kuehling, Felix; Keely, Sean; Deucher, Alexander; Yu, =
Lang; Gong, Curry; Huang, Ray<br>
<strong>Subject:</strong> [PATCH 1/2] drm/amdgpu: fix to use real compute u=
nit number for shader array mask<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style><font size=3D"=
2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">We should use the real compute unit number for sha=
der array mask. Some<br>
asic doesn't have 16 compute units per shader array.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c<br>
index c021519af810..0891c937f4da 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c<br>
@@ -159,12 +159,12 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager=
 *mm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; se_mask[i] =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (cu =3D 0; cu &lt; 16; cu++) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (cu =3D 0; cu &lt; cu_info.num_cu=
_per_sh; cu++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (sh =3D 0; sh &lt; cu_info.num_shader_arrays_per_=
engine; sh++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
se =3D 0; se &lt; cu_info.num_shader_engines; se++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cu_per_sh[se][sh] &gt; cu) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (cu_mask[i / 32] &amp; (1 &lt;&lt; (i % 32)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_mask[se] |=3D 1 &lt=
;&lt; (cu + sh * 16);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_mask[se] |=3D 1 &lt=
;&lt; (cu + sh * cu_info.num_cu_per_sh);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (i =3D=3D cu_mask_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font><br>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB33555F49DF56C6721E9F692994A39DM6PR12MB3355namp_--
