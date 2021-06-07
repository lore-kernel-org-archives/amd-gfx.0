Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7434C47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCC3611AC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCC3611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8CE897C8;
	Mon,  7 Jun 2021 15:30:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B5F897C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 15:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkJuGLCdpUnWkrZL9wd3/rY27KUCAtMgwQrTh4jkB1k7tJ2icCgj5xidDE7qwuAGAPzEkX8hBPAKT1f1tCTam3DXyXnNBVzHSgezHe4ap5AE8YIU4qmIFN3hqYOZv+4pLNZXr7+u4XFze4uM8piVOouLpEd/XbJjLfIUEFX0sFejTYkucEnwwQX/uybn9BwiC7P60qBcwgvYUO6n8uVnFad5zyOlD2DTHpEDE8oMda+vkkomThrry1CtnOKUzlVm8ZP76QEa7wR1octvsTdhyv2Czou4WphY9FPg12FUk0E7U3Fc7S1VDpoba+y1cYBKpg9faSkAb8KuTQvVUHgs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph+hfOYd7EsQiQoQAGwrQNUBxVdPjqDKdd8YYYpIC6s=;
 b=HrkLrRL2c9ew+nrqKGV8Q6f+lyg04lDbMgBtIyrCN4HJn8eXrcHQVMAuNMgWo1bzYqyzn/i0u4nlSq23gFViPHwQPaVitdue0wiT4WvvTxZCIo13EO2J9G1V/naVkV3rAX+kBspIFfbSwnEnTKIAwmYKmL2ssaOj8BsWhltwS5Py2UEa6w1z0ufagCGBwBjiyg7QKsfn4k/n2GfNNzMFea/oQVyqmitC+jlXo22QMbuIJ99+slqU/T73qCIWN77xAWZdKohV6+ie//HcvUhFVvGGrktMcUvAqklDvQNDf2P9FAhu584wOcmheTtBtl+7piINisfroldLsP8XpeWhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph+hfOYd7EsQiQoQAGwrQNUBxVdPjqDKdd8YYYpIC6s=;
 b=pB8Mg+xub1uIMPEE0DVvEIPt31JaS5ldoEv53ZBf0fC9uEs42dUB4PSBlSU7OjjKZu3K34PhBVogXDTxyG9ZTfaBX74T3JaaZJnzjI5LXXKzDGQtc4hjwW01T9+rvOPGqAWNC9zNOEi2TXCmNrTNU9uAfVSv6FBwSaYPLJ2Zx4g=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 15:30:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 15:30:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix warning reported by kernel test robot
Thread-Topic: [PATCH] drm/amd/pm: fix warning reported by kernel test robot
Thread-Index: AQHXW5sitPpz9V0HP0Cx7WgLMdYiwKsIrNB6
Date: Mon, 7 Jun 2021 15:30:37 +0000
Message-ID: <MN2PR12MB448823078E49E89E4F6CC686F7389@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210607124549.9061-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210607124549.9061-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-07T15:30:36.957Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a3efa1-1750-4ec9-2abe-08d929c93366
x-ms-traffictypediagnostic: MN2PR12MB4568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4568FD6D768DB0CC8631CCFCF7389@MN2PR12MB4568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/CwDaxE18u6kD/5nRudoVh3tNgDmnTiTwVXJv8JD8ph0o6JCoiQaFJoI2D8sXCfihBk7s2gdgBp9CoeSjVhjSyjYI8AbJG3jpYRDSVhwkL19iKWGqiWlM2YX54fYAGvOR1sIdm2TWWbyyWB5v5nl2uk2Jw7xmDVR4pRJJbwgiAyjl1HB+kth+C85FPH8aQ7R3DHrvUiq4QxZwMly0rmGRHbZIyEFJBleAGjixOdl6hEfTT6gn+MhbXUUBvmYeZ6SERIIZz7S0W7nTDT1K+WaUIzmvdAdoMAGC+uzgQsp2cq2GZaoO71MARxgJxRtpsSoDCpdVYkV2Ks0Lx6oooWBI0znYMQVUwhzo+mFqfMDp0m2dER1bwMXLotLPeJgHgBYBfhPDgRAvahAQ74I7G/j/C3LpFGASgys3K6uaIELgk8Too+9XS8QRTGMAwA9vJoS7DE+6Sc3cDRrauYjncSSO6tCj2lEjWwp7VE9z9YHEir8aeRDvPykVrP3yJFR9gpHUWD/RDlV4kTRix/kH1pcZ3Q404vxgI3T9I98xK6l6uNZuomma86VNgT0Pp+h8rLzjTdorYM4NpjwnsbtwAvBrKBa1Rh13iZS1eVnWrqzTvvtI+ychV8CrbNTZk3PCaxGqgxbe70kU0JWibzh2bNRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(366004)(26005)(4326008)(6506007)(38100700002)(53546011)(2906002)(186003)(9686003)(86362001)(83380400001)(8676002)(166002)(66446008)(7696005)(66476007)(5660300002)(71200400001)(33656002)(66946007)(66556008)(45080400002)(478600001)(76116006)(8936002)(316002)(19627405001)(55016002)(122000001)(966005)(110136005)(54906003)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9Bf76YXVkcBX+oMFW2lvHbD7tWTyhDUfy/riXRH/rCRV66e5SOZMltk9T8rp?=
 =?us-ascii?Q?ITqP8dNJXuGqyjAn6jBmxd06aJj4oA1WRUE/1iiUjBS3rp3J6A/0UyEJOI9N?=
 =?us-ascii?Q?o+DgsJ7XdxNNX059s/tWFthw7e/SaczBoCQPUP0f+IVBc08NNqFfa8d6P0kH?=
 =?us-ascii?Q?xz35dXGu/bWPiZsz6zuacEthm+9Fi11SSpnLUeD8dx5Tr9tjGa2tO0dOQTY5?=
 =?us-ascii?Q?RlpwOE2VXq9b/59KB7x9bMTm66a0ZqdCYdEjgrO+uBcT+sLi5MoNck2TnYTP?=
 =?us-ascii?Q?ClxHAnHO1Mnm5YilySjRD/+j7f2F/sAnljUgKmn8xqoPfh3RYgDiY60bGuEE?=
 =?us-ascii?Q?G1M0+K/aULMtpsaNpSrgSH2XWLYg6F6703b2XzsnPPFfbSc75euy7DfKtZ7c?=
 =?us-ascii?Q?USMJ2Gh2IQ2ecM9aAMVvb3AHP2dDNSmRJ9sYxJEaEneyHFvp0RuNgrkCndBt?=
 =?us-ascii?Q?iwEH/BtEsGvqWS9EZCc8qjKerHhQe7Ej8vmMdtPgFK7D/zJvJxG6ISu4dyXc?=
 =?us-ascii?Q?71nSmgKeomcd1IHU4XWx3SyYK9PWaJiX3deNZ+HFIZb3VPCvgwObZkTAlqqg?=
 =?us-ascii?Q?26DJaesM4NFOCRLQCXvSY8oqTV+alnSQSWVZv2LO/IgQlLOKyKorxnbM3mCK?=
 =?us-ascii?Q?nC7Q4ro00/vZZp5Ocn4rwbjiC/7Y81Gi/smxBUDAjN6bcyjKOsqfzbGIXOeH?=
 =?us-ascii?Q?v64fO3+cD/oBAnb2dQXjkHKfhg6beBEXmR6UGXtm+Z4JtF5tIOCrcKJelze6?=
 =?us-ascii?Q?bo7iF85FdyaxIXm6+f1pNrH/s/uqmZZyptL9mfGaF7odSjZfPNW8gDywnOop?=
 =?us-ascii?Q?hjckElwHBUqeV9K/mIqV8RUmIHq2FpjgoFFhsBlttgcbmPorDlSbtkI41b9L?=
 =?us-ascii?Q?7w8+dtWUS9399VpqNojnh6blMFOZIbMbEu9alzdwUR6DslWkcGmfC7KUWqSO?=
 =?us-ascii?Q?IuVy63kADNVE9s89NxMbvZUmYEip0Ygd2oRKXrkHeF8RpHBhKpZ509Z3Yn32?=
 =?us-ascii?Q?U/JXFTrvG8qvXra0ybCGJS39M4o+ZpOMC0DBJUC11VToB02NWA4FzkMI/H8F?=
 =?us-ascii?Q?anSv8yOcc8O0x8iVGpwZJUCKZIwVl2w4b+PBXPHRqYTIKu4NtSUKRWNMr3Eb?=
 =?us-ascii?Q?rl6hHOVJiLOlVGnrRtBedqtqAosxz2jS9IcrKRom9Gz9RswdjixWGTrUJO2T?=
 =?us-ascii?Q?mnoUZEwbyTzy+uprwVRGmQoRMAGEGKLL2pcKac1MJL3NHAbycQ5R9SBbv4Jt?=
 =?us-ascii?Q?0AerjupYTtLsROQNnOHlLfImm8Nbt3yrFqqxkoqDd9qIUbx825XL5wNL4L9T?=
 =?us-ascii?Q?H15ZCa6yI6lDV/dsmun4QRJn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a3efa1-1750-4ec9-2abe-08d929c93366
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 15:30:37.5043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B57upK48a9Cvy+dAwe/AzAR1E9tg51+okQ7Nw6dH6sVObDkTMK+YfSVHBeqrTkVCDHHSOl8jScyqSwdPxMgD3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: multipart/mixed; boundary="===============1482032207=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1482032207==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448823078E49E89E4F6CC686F7389MN2PR12MB4488namp_"

--_000_MN2PR12MB448823078E49E89E4F6CC686F7389MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaomeng=
 Hou <Xiaomeng.Hou@amd.com>
Sent: Monday, June 7, 2021 8:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@a=
md.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: fix warning reported by kernel test robot

Kernel test robot throws warning ->

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:483:2:
   warning: variable 'member_type' is used uninitialized whenever switch
   default is taken [-Wsometimes-uninitialized]
       default:
       ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:487:47:
   note: uninitialized use occurs here
       return yellow_carp_get_smu_metrics_data(smu, member_type, value);
                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:465:2:
   note: variable 'member_type' is declared here
       MetricsMember_t member_type;
       ^
   1 warning generated.

Fix this warning by return errno when the clk type is unsupported.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 031c49fb4582..0cd7902d5172 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -728,7 +728,7 @@ static int yellow_carp_get_current_clk_freq(struct smu_=
context *smu,
                 return smu_cmn_send_smc_msg_with_param(smu,
                                 SMU_MSG_GetFclkFrequency, 0, value);
         default:
-               break;
+               return -EINVAL;
         }

         return yellow_carp_get_smu_metrics_data(smu, member_type, value);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C78c8040ef84146dda0ab08d929b243e8%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637586667893606471%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dz1sKNaF9lOApOndQEvUHKZcpS7LUaO7hKaUnHdi7Qug%3D&amp;reserved=3D0

--_000_MN2PR12MB448823078E49E89E4F6CC686F7389MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaomeng Hou &lt;Xiaomeng.Hou=
@amd.com&gt;<br>
<b>Sent:</b> Monday, June 7, 2021 8:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Hou, Xiaomeng (Matthew) &l=
t;Xiaomeng.Hou@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH] drm/amd/pm: fix warning reported by kernel test rob=
ot</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Kernel test robot throws warning -&gt;<br>
<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:483=
:2:<br>
&nbsp;&nbsp; warning: variable 'member_type' is used uninitialized whenever=
 switch<br>
&nbsp;&nbsp; default is taken [-Wsometimes-uninitialized]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~<br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c=
:487:47:<br>
&nbsp;&nbsp; note: uninitialized use occurs here<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return yellow_carp_get_smu_metrics_dat=
a(smu, member_type, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~<br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c=
:465:2:<br>
&nbsp;&nbsp; note: variable 'member_type' is declared here<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MetricsMember_t member_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
&nbsp;&nbsp; 1 warning generated.<br>
<br>
Fix this warning by return errno when the clk type is unsupported.<br>
<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index 031c49fb4582..0cd7902d5172 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -728,7 +728,7 @@ static int yellow_carp_get_current_clk_freq(struct smu_=
context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg_with_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetFclkFrequency, 0, val=
ue);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return yellow_carp_get_smu=
_metrics_data(smu, member_type, value);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C78c8040ef84146dda0ab08d929b243e8%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637586667893606471%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dz1sKNaF9lOApOndQEvUHKZcpS7LUaO7hKaUnHdi7Qug%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C78c8040ef84146dda0ab08d929b243e8=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637586667893606471%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3Dz1sKNaF9lOApOndQEvUHKZcpS7LUaO7hKaUnHdi7Qug%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448823078E49E89E4F6CC686F7389MN2PR12MB4488namp_--

--===============1482032207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1482032207==--
