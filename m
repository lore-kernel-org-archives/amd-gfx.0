Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EFC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 13:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CBD64F71
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CBD64F71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AB16E112;
	Fri, 12 Mar 2021 13:51:17 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680077.outbound.protection.outlook.com [40.107.68.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBDE6E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 13:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlBPHGDi0RFKii0jNwplbEmsb0fPDSVU+vPpzUVGuT3l73j0cmKUsrtOUtWyR4vWPPeRTqoT6EmV/3XtWB92Gpvwbntdd72o3f3fe0TMH7XZunE0WXUnoX6aUl/byz0kE9uuFnGj0rei26oTsXqs2NebsrqF0H+j0xB5bMv/7K5ish2nj1+39OsCckkBGzjsRYOu84mOx4d2USIz+q+ai+ni2Rl5qrhl5ruFfJbcTmUxh1RTFWEmr92jQxxkTCHbTgaWVMJI/eafAOHhykXE1TMAguOWYK0loWln0aHh9anUhANv+B2uM0DsDGe4n2IxII+RRV2FOUCrZWDe9klDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGpSvcpVjUnI1FpwrhzBDju6oGrvZyknDSZDyS1UL/k=;
 b=Y9KCwnUHCJGb0Nmp39R6L6t1R14iuctaGxS/0mf4r8XQ97EuleJSQ8DiV+cEyLUCGCnrewnjKS2LIFxrzNuyLrLS+wGgy5cYgT815ehZIMpuyz3TL9qccFDMfBAQ+ErU5Mm69hHTrVjlgWfGR44NkRAp2Hnxo26yEWQkcEF5F8y/CXDoepHSzoBGVXrDiZPfbGYyDGvzfGD0cX5kZ0AFsSAicrHA09FBzJeDiQv4oQQ8i9Me9B7uvHSoITPI7iLoYOFx7Lqkd/R9rIwfnEuig2dVKOdXW/FJDvXpdx/QauHj4+lhoB5XtcxMF7anVT/gl/jBU8nabt6kdGmTK81YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGpSvcpVjUnI1FpwrhzBDju6oGrvZyknDSZDyS1UL/k=;
 b=xVFbsIXANMatjGvk6LZ431Ok9fylfsAw0GuHY0xGU9Cby/SSNp2qj2+Iio+kaUB48sq3LqqOwW/hkI6HJ9hzUZIstFm9B0CHUTaA22kfx9lP7UJmeX7Il7FZsgmSSAZIf6HWHEViKq60Mhb5GNU4CxjQMlLKjN+T6idNMFbIWS8=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 13:51:11 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 13:51:11 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Index: AQHXFpo1/qViy9Iqmk2vLKn/BFJ85qp/tiyAgACmLos=
Date: Fri, 12 Mar 2021 13:51:11 +0000
Message-ID: <DM6PR12MB3835F2F751F9A0F52009CC5EF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210311171548.10671-1-shaoyun.liu@amd.com>,
 <MN2PR12MB45495AB3BB248A637F218F38976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45495AB3BB248A637F218F38976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.228.81.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 938d3338-3b84-4da5-1ca8-08d8e55de588
x-ms-traffictypediagnostic: DM6PR12MB3306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3306152732E6456E246D0B01F46F9@DM6PR12MB3306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcF+Xxv9ROjdyE8vzfOJvWD5FN4GIH6beQNVd0X6Db1ZC6ZooQRGIJ40hTyd8qGcP9dC3mj4heIxLi+Hg8sFR5lE/cYuV2Cam6wNKxtoKPzuGVQrmeXiIUrvUokY7IQd71BohFBc5F76YqteJ66C89BbTdRlu+sR3+LS3WyGyfSOFb5lcRtVLk1EHQMsHtVc0OWhVa4x8VJJtz4E5zatdnmQX/xkohFJy5zES5JIvXs/0gu72mp2HLHJsBiYzoTQxQMtESK8oeBkcrCSi4eYyLR9YirX6aP/oFzHXcMokLg1MrtqZsAgNCW4rBQUPNaTLG6XIPp3UzgglLxKoE1KYBFfi+1CFdCR4p0pTV49GE6cEbek9589hGywmEcmau2vq+PhbgyQuWzWzpSxNLYRCxh2CJXtSts/RmiMF5IlmAmicuo1gIm/HFdHMy/ErHH/W+qa4zUHHJfMD6FzVdEaTgqkcgmHoOS5tbHNDlKcovCSsLVE1hzvY5iuXKY05lb/6Ce6VUR2mHTA5G66YZTCQ5RY7VFi9hSq0TsK1MHSIHwVNoXixN5Ls2OnaieQMW0N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(53546011)(8936002)(91956017)(76116006)(110136005)(316002)(26005)(33656002)(6506007)(166002)(5660300002)(186003)(64756008)(8676002)(478600001)(66476007)(45080400002)(66446008)(66556008)(86362001)(52536014)(9686003)(71200400001)(55016002)(83380400001)(2906002)(966005)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?SfEfdtDWPdjw5cMLLGOtdGl5nbeiA+2cb6zYiCPE6xnyQDMUuiESLdivnt?=
 =?iso-8859-1?Q?btiDqBiry4/Tbs4y4tJO8N1uMKx2BuDHy97ERl6x/ss9QkLEtBRdj5JCL+?=
 =?iso-8859-1?Q?7SO+mWOPD+LGvz4NPmVENnzC4ljQnugFHoTiPXF9Q202Ujebyygu/jIWXi?=
 =?iso-8859-1?Q?ANv2FNkzvi7KaEXMwjAuSOXZwtsrrj0W+LOoOxkBHE0wGSQqFIYPe1eQFJ?=
 =?iso-8859-1?Q?rMnkyMMgWIzJvSB+G3/l/WA14L6dP38Zalm+UwjDJ3BqbNFMYDuBPdvoZv?=
 =?iso-8859-1?Q?c0X9N+3qySnqSynWxcM13uHbMBcNb2W0tanRJ4ccPdsnDOHsZn/2eveLIp?=
 =?iso-8859-1?Q?62zeS7HqK41+vkzBwcZV/eXdV2O6bc2WpUUHHyiKYlAHsVpVcxc8owbYV8?=
 =?iso-8859-1?Q?pfp6oK9idhAa0AQtZ1unOWuWjR74hwzMmYqKH7Dso+jntxPNyJBs2fAOyS?=
 =?iso-8859-1?Q?16Qmbm9pi1PB8ihMGwMn/RA9GcZLw1sMe0s3Eiw+U9/EHLnUSQo5DwBGaE?=
 =?iso-8859-1?Q?Xy2feXlXiFhFUHwHABIiUEnUhErzqXLkIRK7OYyRnCfRZIEXrTN6DwQOkl?=
 =?iso-8859-1?Q?CYeOesAhvPyHOK7CJ9jfA+60I6b6GWShcP2L3QiyURteEP/5A5TOjvG206?=
 =?iso-8859-1?Q?T2NbrZ5bt+vBN9zpmL42Ss8syyKf2C9paELdJc8PAnMQsL/3YYFuPHMti6?=
 =?iso-8859-1?Q?+Ba515vn+p7H/VAqA130DdOC1cumLG6ZjYonUWM5o+n6rFF1c+/0aq3eUA?=
 =?iso-8859-1?Q?njMJzg4nVPreBjFRyt64UDCSa/3NddzlA0WRktiM5ysN0VnXS816hsSFGe?=
 =?iso-8859-1?Q?GHcOFsULtg0jm8XWIhNUqwNcovXPy9DKemK4eHe+8eItHcssIaG5bVK8+4?=
 =?iso-8859-1?Q?30tRpx5yZ8dbgXKkueQ/pZOkE+4sm52YMH8rFgcwaOkuCx3jm5zCMZ29wt?=
 =?iso-8859-1?Q?LzovlXX6TSMwiSYKs6w6R7U4gGNvyKKVTTfYt3lOxXuuosWgZxWfaqnwMg?=
 =?iso-8859-1?Q?YroVeGDbTgmqCPIqb6TaQ3p4eDQ8V2dVWS0iODl2NmogUh+QDv6kGLaFVm?=
 =?iso-8859-1?Q?FpYjVYtyOORnwJhE+w+XlnvILkKJ38rPf5BEFbMDLoPvCTtLqzK7L4yjVV?=
 =?iso-8859-1?Q?FWyDoiGBx2LwlqcB/qKaX++Nwaib9A00VPaDAx9/5eBMR1zf9UjSx9rXlH?=
 =?iso-8859-1?Q?blHsoGy2gsjd2daqLw3kTR4QE8/6fFOYfSbJgu93rX6TJk4840uSsILimJ?=
 =?iso-8859-1?Q?/qkdRH5TFMIBagvS9Q91mIZkPRL8s8U14vMpLeJd4dHcv0xoZR78fMX6wN?=
 =?iso-8859-1?Q?7DxT5jbKfA43m/jo1t25jWHdCgnpqpntGO3a439XIpo6WHM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938d3338-3b84-4da5-1ca8-08d8e55de588
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 13:51:11.7807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73n5lPtiXNvM3oXCZqbcMlQHvduy2n9lfSeC+F/Xm+vO0RzddU8+aAF4jUrQjrIvPMGjCskZTLrtJqfLo/LGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
Content-Type: multipart/mixed; boundary="===============1861406446=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1861406446==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3835F2F751F9A0F52009CC5EF46F9DM6PR12MB3835namp_"

--_000_DM6PR12MB3835F2F751F9A0F52009CC5EF46F9DM6PR12MB3835namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the comments. This light sbr solution could be applied to other =
asic as well. In swsmu code, It will check whether the function pointer set=
_light_sbr is valid before real call the function. So for other asics if th=
e smu apply the same change, just add the ppt function pointer and we will =
have this support without further code change.

Thanks
Shaoyun.liu

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: March 11, 2021 10:42 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

[AMD Public Use]

We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 10:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion

This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

+       /* For XGMI + passthrough configuration , enable light SBR */
+       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
+               smu_set_light_sbr(&adev->smu, true);

         if (adev->gmc.xgmi.num_physical_nodes > 1) {
                 mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (amdgpu_device_cache_pci_state(adev->pdev))
                 pci_restore_state(pdev);

-       /* Enable lightSBR on SMU in passthrough + xgmi configuration */
-       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
-               smu_set_light_sbr(&adev->smu, true);
-
         if (adev->gmc.xgmi.pending_reset)
                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wor=
k,
                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D7nd=
htOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;reserved=3D0

--_000_DM6PR12MB3835F2F751F9A0F52009CC5EF46F9DM6PR12MB3835namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>Thanks for the comments. This light sbr solution could be applied to o=
ther asic as well. In swsmu code, It will check whether the function pointe=
r set_light_sbr is valid before real call the function. So for other asics =
if the smu apply the same change,
 just add the ppt function pointer and we will have this support without fu=
rther code change.</div>
<div><br>
</div>
<div>Thanks</div>
<div>Shaoyun.liu</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> March 11, 2021 10:42 PM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of sh=
aoyunl<br>
Sent: Thursday, March 11, 2021 10:46 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion<br>
<br>
This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.<br>
<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu@amd.com&gt;<br>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----<br>
&nbsp;1 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index cada3e77c7d5..fb775a9c0db1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configurati=
on , enable light SBR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_=
physical_nodes &gt; 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_cache_pc=
i_state(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_restore_state(pdev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable lightSBR on SMU in passthro=
ugh + xgmi configuration */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.pend=
ing_reset)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_wq, &amp;mgpu_info.delayed_=
reset_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffi=
es(AMDGPU_RESUME_MS));<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;re=
served=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;r=
eserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB3835F2F751F9A0F52009CC5EF46F9DM6PR12MB3835namp_--

--===============1861406446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1861406446==--
