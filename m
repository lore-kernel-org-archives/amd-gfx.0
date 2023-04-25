Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A98C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 08:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D52B10E6C5;
	Tue, 25 Apr 2023 08:36:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5FE10E254
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 08:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEJMJbpIhcHOvGslCYdSNmBao9pbAA8Tqo/Za+EuHaLETM2lKZLVF6hrZAds8d0DCirFqxJI2M60ssMLAG98fwlgC1ZgCTQDiVVBlrZGzKcqyfR9sAqe7eX1oAP49pfM92HedpMJ9TPU//Ftos+RpHb+yLF1h2OohkCpvnQAfT1wi7lZt/9w8ogouvtr1Kcd++4bH9Ok7SdYgLeAOqzBKfhuaD3Mj7nXzBjUSkfDhFoFI38ko0EPteD/2WMvGaYUUHLbEbjtP8q2CeODOfbYNOE899rQ0wFg8jlMDo6tI0MCjbqOZDozX12pUu1Bnv0X7S2ShP3sYdkjq20PAqLtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yfpsU2ck7eNtbRxMUE4Y4AJPhQibNszEHSYq+vswO0=;
 b=H+fkOXYdmZsEvmT4wdOREYE0V/Z0CWVo+ry7ckSrHqXiXLrk455aI0OsxXlioo5lGHNMzb7X5w6cPgTAFVKuODP+Xbyia/al+0oIlfviXJ2hb3+W3ozNzENLcH/yWVO5QKha4tPPzNpxJ+Tpjp3nEqRUHVzU4wpjsPJwClV59GCcrtyKPZd5/3vaVGwgzseonNtDDnt29p1VxW+euJD9gFte7n094hOzQQyAO0g3rY5pxIC3PjUJOhn7vhCYvoHShGTiSSMeVWTveHe/2yvGu5/e1MRM0wq9N49bqW+A1Fopt62dhyKenGE/H39lArnS4WszdKB5i6OPj9e2NfmgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yfpsU2ck7eNtbRxMUE4Y4AJPhQibNszEHSYq+vswO0=;
 b=FkUqZ7T+Ll6mSWtsE4T9WmT7RwIBLJJqnVtIsQF+MwyJKrj8AkePmj8QVCNZtEkAtkM96wZY1DMH/x3WzZTJ0xEkkwxeviN1k3ZdlA90CCnk8hdMmrrbuDELYMrHP4MX7CviudJU7V2Iv+qSsaLqW2odOFsOk5IxHmU8mkHo/w4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 08:35:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 08:35:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: fix amdgpu_irq_put call trace in
 gmc_v10_0_hw_fini
Thread-Topic: [PATCH v2 3/3] drm/amdgpu: fix amdgpu_irq_put call trace in
 gmc_v10_0_hw_fini
Thread-Index: AQHZd0CZ9bfF+pEP+0SxeBQXSivOnq87szlF
Date: Tue, 25 Apr 2023 08:35:54 +0000
Message-ID: <BN9PR12MB5257A3D7D6D445C7FB278977FC649@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
 <20230425063837.26701-3-Hongkun.Zhang@amd.com>
In-Reply-To: <20230425063837.26701-3-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-25T08:35:17.3504806Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4888:EE_
x-ms-office365-filtering-correlation-id: cfa96c50-a950-4e22-d929-08db456815cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BK9pw0wQA5qEWHFlrwuB4TbEojZMdrRpuLHyx7VtFKBVtOaC47O4KYg4kf+kQwhk9inBlGEU74vgc8K306E1CXyDZEf1HNJ1KeYRvzWygPgZ4E0iiG4JUBwDI/FN0J/+R1FZFXpDytQjQTWD7n6DdsTewiZpClQni1x+Ihb/Xbxog2INjuB55qgvKZtMIxJVPj07pfzfsl82SDrjkBDt8eitrSFyw+R9eQ8hoSQxYyCod7ZVgSRqURxChO7RUMBZt06wonYZkYVEIMpnk8yLa1CXxupDYAQShKeHbxau4ikiZsEgnlDP5vP7Em0/qbto3f/OItA1zwVUU39F/Sz04a+OH2XK/BlFfZ5Auw5S0/tc0S0z3qPjh+FOLTTamin+2I6R+HyR5EVRmx8eejdq7UicQ7w3MzOlGhIkRqj0nym/4ciEcQoGXv0m1XsfsiXtpjqotjNCN9b2PmhzZq1m/QV/4gCjNEExOX/4mxmKudeezaQfiI3LneNN2UVpyMtC7Spo/yB90gxcg5NoCEMCVZ/OBDmlCsN5MIK0C8RqCpGgUrCWkRpZayh3KMeWCsG4QdP+C6cMdZCWy9PQ5PvF36H1KPEDf4Qu9pOkc+j2Aas+DKyiDWmXr+FrZK1BGBucsnCCvXPr9Yjg8VNqoqY6d4TcE5Ce6WccmtWBRAa4ZLo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(38070700005)(38100700002)(8676002)(8936002)(2906002)(5660300002)(52536014)(33656002)(86362001)(83380400001)(7696005)(55016003)(71200400001)(26005)(6506007)(110136005)(54906003)(478600001)(9686003)(66946007)(53546011)(186003)(91956017)(76116006)(122000001)(41300700001)(316002)(4326008)(64756008)(66446008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tb/7ZShTUx3niax2G55QIVnrAGnIjb9Z5DTCwybSkNgL/GsCZbqYKKRKtP4U?=
 =?us-ascii?Q?7XIJNyipu2LaJUlhwSsZHu2GJYdze4Vhi3/9P+brrzTO+5Y/OaVJQoHAVVoB?=
 =?us-ascii?Q?xVbg+FgWkr+8CeB41tn44Za5nV+bxV/uixusZ8h20gnDxz+X18iUBHawKDby?=
 =?us-ascii?Q?fz8jY0OYEwYPKAhuwD+Nopq3T9N4jFvYRaED/l/+R2mc0KeYwrfQqEohCrOp?=
 =?us-ascii?Q?+mE99nr89jp+qXxOUDFsPopvVxcmu88zOp2DKecCX/AQ/SxyidGbVqcvlRFO?=
 =?us-ascii?Q?aP+ecW3Syq3Cuf/88/VJvlt7FPT3LsW4YqPLk2qEBnsg23J64g3eN9x89CGI?=
 =?us-ascii?Q?EYZ/LxDNNqPb+jhfZt1Oik4HQQw7nUmQ6cpe7503Whj7NOCkDoGcXXaYN9Nz?=
 =?us-ascii?Q?gZHpH9uzz/R2rgVvFFtU7sZJ6vMxZnU/dYM2arwYrKTEw7pmYf0XFoEa5NjF?=
 =?us-ascii?Q?yoFJl0VGlkdv4MeAXQanwpF+HR5Dcf9QuucBgqUhEHfO6bJJ5zoOWPAVYIfr?=
 =?us-ascii?Q?hh9qGcEyuxX2OR7hkSnSeqT/rUANDuIS0GriCkumVINl+TX/AUzSYhiGE8wz?=
 =?us-ascii?Q?JFciZgLxAQEgXXu6WC0qapdizclQPwkhvl19VuygYKf/DjfEJQihJbRHmMRb?=
 =?us-ascii?Q?BwyHh0b1wIMIOMt93gWdmch5cl4VyEWDLCteXr9pcJJfid7XyLpX/nZBKhU5?=
 =?us-ascii?Q?tafFC6jEgUKPerV102GMF9otYCmB59ZpfGsmCkzb+fRwZeToeOscKiwrjTUi?=
 =?us-ascii?Q?BW5rFWb8C2Y/jUhfKdFTdajwcnETxphp15/yQOWwXeduk5POdY/rssllJg2Q?=
 =?us-ascii?Q?3ixyRhBnkAYYmCNzcOyGv3dc3PKWSqmYapU0RfE8gEShzbdOr+JSqFS2Alyk?=
 =?us-ascii?Q?znREVljl6T11N68QSpfBSYva2g5AgjsBSGCpwdTTUTLRMso7ghF7jsNIWwYn?=
 =?us-ascii?Q?BjWSEIx5aoLt7GTc+zFKFg7gt4aJdUqgjAkeAsQGQo8Fd+wJejELagkdg/5b?=
 =?us-ascii?Q?4nIZbrW/DS3fzKIQPEBfuSKdt37RvD9MElRFw0CCzwwewd4BNp9Yfqz5Q2Kf?=
 =?us-ascii?Q?+loscZn8BS2YOoSGl91N3RsAMQig2qsp370U5tMr05t6LGaIg3TeTv4zAkCh?=
 =?us-ascii?Q?qX/1r3hNyeMC/ZhgE0wA4tHN/yiKf3qAnqRfEWDb2614pDOYGhUSBx6ayQdF?=
 =?us-ascii?Q?KQjDX1wPDBxNad9DdBZLtLSj+k5lZLiZIKFfDN/gLKHCW6QMd41/AUqFlmsk?=
 =?us-ascii?Q?79mTZxxksS7VWBRLkP9EMKoeA6CqQ+TSZr6O/2q34qJFxuM2Dq+TYzpnNxJ6?=
 =?us-ascii?Q?zjGhRgQRkwGqIHtldfLnqVguZXcL1yim2oP49hTproeNQCQil5gcvJWnCRMF?=
 =?us-ascii?Q?AkNRGTcsQ43Y6ojKMr8EiDawQSiHAVLBT/d0t48NUmH91yff0JHqPfvE+fIg?=
 =?us-ascii?Q?tZuEUWruBHWJvl5WsKC/5I21J2QEYQ8VS91GL1kQY1qUe3WFyDtI87t916Ix?=
 =?us-ascii?Q?wd3aD1HuJiOAKSLnRIC0TggCglvaFzq6wpPfYjbKmnIJ0O2FqkgGXLLlgYCm?=
 =?us-ascii?Q?lJ7zDWxP/UcSzO8D+kt+RImgYGskJqbkNVC7dab44nzCWSgnAr+CwLoK3r+E?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257A3D7D6D445C7FB278977FC649BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa96c50-a950-4e22-d929-08db456815cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 08:35:54.7214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rn3bc3/rcC4dbzd2wDdXxesuyceoBljmY1JvrZHuIFTIzTC5TkVRwRWhG2HQ9RhAvrJ5f+B7ONT8kCq6DmZ3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257A3D7D6D445C7FB278977FC649BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Horatio Zhang <Hongkun.Zhang@amd.com>
Date: Tuesday, April 25, 2023 at 14:38
To: Zhang, Hawking <Hawking.Zhang@amd.com>, Koenig, Christian <Christian.Ko=
enig@amd.com>, amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>
Cc: Chen, Guchun <Guchun.Chen@amd.com>, Xu, Feifei <Feifei.Xu@amd.com>, Yao=
, Longlong <Longlong.Yao@amd.com>, Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v1=
0_0_hw_fini
The gmc.ecc_irq is enabled by firmware per IFWI setting,
and the host driver is not privileged to enable/disable
the interrupt. So, it is meaningless to use the amdgpu_irq_put
function in gmc_v10_0_hw_fini, which also leads to the call
trace.

[   82.340264] Call Trace:
[   82.340265]  <TASK>
[   82.340269]  gmc_v10_0_hw_fini+0x83/0xa0 [amdgpu]
[   82.340447]  gmc_v10_0_suspend+0xe/0x20 [amdgpu]
[   82.340623]  amdgpu_device_ip_suspend_phase2+0x127/0x1c0 [amdgpu]
[   82.340789]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[   82.340955]  amdgpu_device_pre_asic_reset+0xdd/0x2b0 [amdgpu]
[   82.341122]  amdgpu_device_gpu_recover.cold+0x4dd/0xbb2 [amdgpu]
[   82.341359]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[   82.341529]  process_one_work+0x21d/0x3f0
[   82.341535]  worker_thread+0x1fa/0x3c0
[   82.341538]  ? process_one_work+0x3f0/0x3f0
[   82.341540]  kthread+0xff/0x130
[   82.341544]  ? kthread_complete_and_exit+0x20/0x20
[   82.341547]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 23d4081eca00..5697b66bf0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1143,7 +1143,6 @@ static int gmc_v10_0_hw_fini(void *handle)
                 return 0;
         }

-       amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

         return 0;
--
2.34.1

--_000_BN9PR12MB5257A3D7D6D445C7FB278977FC649BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Seri=
es is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rega=
rds,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Horatio Zhang &lt;H=
ongkun.Zhang@amd.com&gt;<br>
<b>Date: </b>Tuesday, April 25, 2023 at 14:38<br>
<b>To: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Koenig, Christian =
&lt;Christian.Koenig@amd.com&gt;, amd-gfx@lists.freedesktop.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Chen, Guchun &lt;Guchun.Chen@amd.com&gt;, Xu, Feifei &lt;Feifei.=
Xu@amd.com&gt;, Yao, Longlong &lt;Longlong.Yao@amd.com&gt;, Zhang, Horatio =
&lt;Hongkun.Zhang@amd.com&gt;<br>
<b>Subject: </b>[PATCH v2 3/3] drm/amdgpu: fix amdgpu_irq_put call trace in=
 gmc_v10_0_hw_fini<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">The gmc.ecc_irq is enabled by firmware per IFWI setting,<br>
and the host driver is not privileged to enable/disable<br>
the interrupt. So, it is meaningless to use the amdgpu_irq_put<br>
function in gmc_v10_0_hw_fini, which also leads to the call<br>
trace.<br>
<br>
[&nbsp;&nbsp; 82.340264] Call Trace:<br>
[&nbsp;&nbsp; 82.340265]&nbsp; &lt;TASK&gt;<br>
[&nbsp;&nbsp; 82.340269]&nbsp; gmc_v10_0_hw_fini+0x83/0xa0 [amdgpu]<br>
[&nbsp;&nbsp; 82.340447]&nbsp; gmc_v10_0_suspend+0xe/0x20 [amdgpu]<br>
[&nbsp;&nbsp; 82.340623]&nbsp; amdgpu_device_ip_suspend_phase2+0x127/0x1c0 =
[amdgpu]<br>
[&nbsp;&nbsp; 82.340789]&nbsp; amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]<=
br>
[&nbsp;&nbsp; 82.340955]&nbsp; amdgpu_device_pre_asic_reset+0xdd/0x2b0 [amd=
gpu]<br>
[&nbsp;&nbsp; 82.341122]&nbsp; amdgpu_device_gpu_recover.cold+0x4dd/0xbb2 [=
amdgpu]<br>
[&nbsp;&nbsp; 82.341359]&nbsp; amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]=
<br>
[&nbsp;&nbsp; 82.341529]&nbsp; process_one_work+0x21d/0x3f0<br>
[&nbsp;&nbsp; 82.341535]&nbsp; worker_thread+0x1fa/0x3c0<br>
[&nbsp;&nbsp; 82.341538]&nbsp; ? process_one_work+0x3f0/0x3f0<br>
[&nbsp;&nbsp; 82.341540]&nbsp; kthread+0xff/0x130<br>
[&nbsp;&nbsp; 82.341544]&nbsp; ? kthread_complete_and_exit+0x20/0x20<br>
[&nbsp;&nbsp; 82.341547]&nbsp; ret_from_fork+0x22/0x30<br>
<br>
Signed-off-by: Horatio Zhang &lt;Hongkun.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index 23d4081eca00..5697b66bf0de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -1143,7 +1143,6 @@ static int gmc_v10_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gm=
c.ecc_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gmc.vm_fault, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257A3D7D6D445C7FB278977FC649BN9PR12MB5257namp_--
