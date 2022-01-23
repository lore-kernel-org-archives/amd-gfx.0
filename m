Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDF4C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 13:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCBD10F91C;
	Sun, 23 Jan 2022 13:48:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE06410F91C
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 13:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y95ptIjN+D7Iz/2WH57EWF6LTl47+snve8bxArF0Qi0p6xhXEp5XzQlaZp8/efrA7EVXwDdvAosLOvTXMcHty/XTUz1KvpofDI8kVZxYp2xmWqGaEHy6rDOvzzhfoQuAvmJA3ndCdyqKg/CSWPqrz47TUETzHlQabjcUQs1O/1tdpD97h/ccJbiqP7H9XoMmOKtJN4QwxBYjU8ip9Icr/n4p+T/LYjA63ZPT8rkzI6kBtFv6JXmD4TRYpycPv6rjWw8o56N7V6Segllsr/57QeUUP9K4UlpBpdc6UbOhqV8SlPkG8xo8/lat6Fqg9gh/gsIc6ICG9Elma9gg/FXlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXj/Ofg7UvIkdZ3cGwWELLtIRBmU5/2j/Y0twXysqf0=;
 b=Z9n65f4G/WujsgjQEs8KhJN/QpKgjbYaiYXQSxsak1E39Qxata7jHLf69KAN8QyxEhqarCM3d58diRnf3pBNlVBkucXfvV5ybarQ2TInMbw8dj3TRT6QtYobrQbQhni7G9wQ/41ZzpDMe6vqtodqovsFtGHNC0CQv06++fgUtcoJzZpYmTaf7Ucvywl5CwzV8dQ16uqM77W2fFJLFs23hJuuPmpYPBahgdjklBmRyjfDX1T7sGWv2std0dmUPr3QLnJHjDSPEWF0O0eXOA2SryRMc/PQBVfcuaeZMWxxOZm4VLFHEAzQbcG2h3fATp/hWiN7NHq72VCxO2JnnhUxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXj/Ofg7UvIkdZ3cGwWELLtIRBmU5/2j/Y0twXysqf0=;
 b=GimoQEwaChuyyv5KkRGwVosMxLqLDwcDvGx6zD7njrQOauG6wBWzwDFsegQeZEZpNLcRsLnmta9skw+Q6qxRKvSeuTozE3KKWlHLoeQAQ67oCtdBpSEy1z+o/n6REdgEp8j5suORgsJohUHmf2xR0FIe669tz6XQF8gj8wtccNQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Sun, 23 Jan 2022 13:48:16 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 13:48:16 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Thread-Index: AQHYDig4nekKuvD7bkuvUqhbvq8ctKxstVvAgAD+1wCAAu8mwA==
Date: Sun, 23 Jan 2022 13:48:15 +0000
Message-ID: <DM5PR12MB24693D0DA8DEB7A110845477F15D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220120180429.616236-1-alexander.deucher@amd.com>
 <DM5PR12MB2469737FA78BF772FEE50E59F15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BL1PR12MB51440AE2886ACA76CD25CE60F75B9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51440AE2886ACA76CD25CE60F75B9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-23T13:48:13Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-23T13:48:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 92d05b88-5f83-47cb-9e58-3c89f30383c4
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a9e764-cf20-41e8-bf56-08d9de7701b8
x-ms-traffictypediagnostic: DM6PR12MB4043:EE_
x-microsoft-antispam-prvs: <DM6PR12MB404371AD736CF8D7447247E6F15D9@DM6PR12MB4043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoARUdvOP8ZnxOWTZhSTfnpMMMcSgOD1HqU0zV2Ftoc4WNHUxKIYlJ4AWsRJJGtZ5aE8WRE/azcMtl5Aqh3qL1kmYzmdlJrTGxeFaBOZeYyuMHJXeh7JbbaU5A0lFfaXHW1OvrYuxVkY4rVy1eBZNUE1hdXDDDIdn/yFFM1dQVNQnzfUhWJKyVk9jaqEGmt0mF65r9x1bAXdUg46xjsORRYieEeRUIyNBb1pS6ZuNoSBAgwJjjOt4fnif7QpeHuUK0oh0oRAE1q3V8uJMoZuDrtivESrmcLS0jPIehVk9VHd27mSFmf9eEi+ilFGxh46IHOBB5QCvwY/LFhMb3zrYUTngJUQ+I8hKzUGGNa31lDYaQrjL5jnTPwcIo/HcDkdGLvfzsO69KPx039lEBZI7RhGO1D+6MM3LctNlUERIwoEJqzqxuwRs+dApPURyc+o1338nuG/GvGiS0dF1THnOdaPWkwWLUn88YfB6I/SZKNT5JjbeDX1PjPNJwP/c4US29wy2hfEXfCpTf2cP6HgtkA0BERsVYkraNbqx5thHEKpPWtVPqfri/QCN1bze94qUJWVTjy3Lx0skKt4OB5VuT40iaqUooKxnhHP1UWy44vQMkf56KCPT3q4/TjI4ZYgRjFnro5+vtP+RM0HNIqWpGVSQswBUjlIkK432hRJ1+S0acai0bdYwPPXbuzbqrJe/oz2sRqW+Kf9eRBn08e0xw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(86362001)(8936002)(33656002)(7696005)(38070700005)(53546011)(83380400001)(5660300002)(6506007)(316002)(76116006)(66446008)(66946007)(9686003)(66476007)(66556008)(64756008)(2906002)(110136005)(52536014)(38100700002)(55016003)(8676002)(71200400001)(508600001)(122000001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUpAtmigxv480txhyuIvwu0keqb9qYpoDSVN0zMGbN83/RKptaPfCTLS1oAr?=
 =?us-ascii?Q?rJ5RRuOYWa/WtaHprvAWKKGxehbrf9qVXGFOiH0ID6VjkDrlW1tk6pWjlmRy?=
 =?us-ascii?Q?v7lba88wEbSRGb0el6HRvt8rTNW2Dwwrkevw7Ao1jogaSwwOB6/85q4wR5rA?=
 =?us-ascii?Q?R+GtO1Cl+8YH2L1liCnO5Lw+1cPHi6ihJ5z4vUxMOcSiWvcAUCVab4oM1U7Z?=
 =?us-ascii?Q?ew1v/DBdxUDYntLoz9wvnzpfHsvUuORJBCXqfxgyVzCm72uUliR/BGda9hiU?=
 =?us-ascii?Q?llfq1qP1rnI/wAla4YhEaL95/DYdYZPvl1JawUWr5riYqXQKf2h+IrCXmkSW?=
 =?us-ascii?Q?ePRKUWVtOucPU6C48vo2A94gNNVdw3uwwUag4MlNUh67G5GR5/biXZgNC6J1?=
 =?us-ascii?Q?mlwNxe/aWp3BoZsvlsS+UwOmhdgxJFdw8IyHYpabLo60at49rXl8JrfptV+3?=
 =?us-ascii?Q?T9CMWw1bU19PB/R/DZKVrB0g/OVfwbgavGMczaQNc4gTX6euZ6GiLnd2PM1I?=
 =?us-ascii?Q?v3ZqycE0koAE8sKh3m7EZ0L/12ADoe5b7Kw1Pfh4NzcEeDQnACqIGTg+kcwY?=
 =?us-ascii?Q?NDYlwApk04L4wXM+y1RRMnlRJvgN7jhLdncME0Snc6z9IW6w+o+8fWC0cQDc?=
 =?us-ascii?Q?hDEx/KeRnCu0Ynzw7PyTwJRlYvT0riuBY4yfNlZ9wgKAiZx0KXrjn2xM3c9X?=
 =?us-ascii?Q?R4rmxlTEPZCGLv746eAut2vl4Y//AW9vLeLzUYoLl6fyZ4/H5k73A8ruvZEj?=
 =?us-ascii?Q?0hP35TkvD/O7vH/I6DbSuIiAkTjJ1uxvJWJ8rMQlLsmDtiB39Unyr0jB1PyR?=
 =?us-ascii?Q?j3c97XmZBZbMAIFIcdLILkYaeyYP39Qc5JuO7YERphSFyuEZWpL3/nhrhrjg?=
 =?us-ascii?Q?qQfgvlpPIh6k/OCniQk1Amb2JjA4SQJaJ6LH1HLbsPR82J1V2lE6A4d5d6Df?=
 =?us-ascii?Q?Wt5G8W8AMsjy6Fz8uSxno0+8onYBTUUL2TTRFcqEI1urIu/daoKothfQWcp7?=
 =?us-ascii?Q?xbMpr3QlwEGSDuxTpasoYLTQUzViuX8qypCte7LFP+45/b1WBjjA5uO7i3+p?=
 =?us-ascii?Q?exC5hoDJZMJwTQ1ARRtQwsGVB4XZv1dMmClGeHLUX17a7IbAxarXsCU/XhrY?=
 =?us-ascii?Q?lVnQ6V43bGQ/ohI/abUewJmAMtWiYfe6q3pxGdIhKNvyEsR/n77+ifRVlqZn?=
 =?us-ascii?Q?iD8gyKo+doHontwpRGQTLejIlclS4OHAh37ltNPmRCxSJRrZBG4sqIcWAn5V?=
 =?us-ascii?Q?KfBrnd+sQGfwfrU/ce9eVP5vSwXMLl4ZnRYoynkpfbb846hzJ18dG0cAYW5X?=
 =?us-ascii?Q?Y+M7E11Ezjg0ZQCnwRPm/RfHifqQv0cURLbckL/624+NIC2+Lu0z24UWxf8F?=
 =?us-ascii?Q?ZjX+6S2tK4lSmwd8+044p937tzxal3Aj8nF/YbKTY01lZfAvbUKAeVMtBdLm?=
 =?us-ascii?Q?UkP2eOEaW3Iaf6TqnvpkzC3r1AetuJ3fwQmgq0eQSGiT+RBQB42WmWyNQCFw?=
 =?us-ascii?Q?S/c9es3ZiFpHrWS41dyTzkdaGMKXgjybnipzEjI3u3Quja852GklBPlWjZXY?=
 =?us-ascii?Q?3bdnRd7VfMDU4CtClxncqjFjfQXgOAwET0S66R8jgbRWNbqhuOUBATI6ju4S?=
 =?us-ascii?Q?K8JxjD/LDeKVsSIDwL80ilo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24693D0DA8DEB7A110845477F15D9DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a9e764-cf20-41e8-bf56-08d9de7701b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 13:48:15.9901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4smwDXcCoBKf3BPCtWW83Dbt4Rht2KZErNS8ahzrwQvqmEhKPhfpsdMRnj6baBn1eu35K/zn6pUVmrPJ/PpWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

--_000_DM5PR12MB24693D0DA8DEB7A110845477F15D9DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is: Reviewed-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@=
amd.com>

Regards,
Guchun

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Saturday, January 22, 2022 1:00 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait=
_for_training_aux_rd_interval


[Public]

It just changes the limit for when we use msleep vs udelay, not the units.

Alex
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Thursday, January 20, 2022 8:49 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait=
_for_training_aux_rd_interval

[Public]

If we change if condition, how about the division by "wait_in_micro_secs/10=
00", as the sleep time is less now. Shall we adjust it as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Friday, January 21, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait_for=
_training_aux_rd_interval

Some architectures (e.g., ARM) have relatively low udelay limits.
On most architectures, anything longer than 2000us is not recommended.
Change the check to align with other similar checks in DC.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c
index 1f8831156bc4..aa1c67c3c386 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -202,7 +202,7 @@ void dp_wait_for_training_aux_rd_interval(
         uint32_t wait_in_micro_secs)
 {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-       if (wait_in_micro_secs > 16000)
+       if (wait_in_micro_secs > 1000)
                 msleep(wait_in_micro_secs/1000);
         else
                 udelay(wait_in_micro_secs);
--
2.34.1

--_000_DM5PR12MB24693D0DA8DEB7A110845477F15D9DM5PR12MB2469namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Series is: Reviewed-by: Guchun Chen <a href=3D"mailt=
o:guchun.chen@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Saturday, January 22, 2022 1:00 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in =
dp_wait_for_training_aux_rd_interval<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">It just=
 changes the limit for when we use msleep vs udelay, not the units.<o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 8:49 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in =
dp_wait_for_training_aux_rd_interval</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[Public]<br>
<br>
If we change if condition, how about the division by &quot;wait_in_micro_se=
cs/1000&quot;, as the sleep time is less now. Shall we adjust it as well?<b=
r>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Friday, January 21, 2022 2:04 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait_for=
_training_aux_rd_interval<br>
<br>
Some architectures (e.g., ARM) have relatively low udelay limits.<br>
On most architectures, anything longer than 2000us is not recommended.<br>
Change the check to align with other similar checks in DC.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c<br>
index 1f8831156bc4..aa1c67c3c386 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
@@ -202,7 +202,7 @@ void dp_wait_for_training_aux_rd_interval(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wait_in_micro_sec=
s)<br>
&nbsp;{<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wait_in_micro_secs &gt; 16000)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wait_in_micro_secs &gt; 1000)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; msleep(wait_in_micro_secs/1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; udelay(wait_in_micro_secs);<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24693D0DA8DEB7A110845477F15D9DM5PR12MB2469namp_--
