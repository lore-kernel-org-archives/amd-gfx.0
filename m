Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858F3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BBF10E9BA;
	Tue, 14 Dec 2021 07:39:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FA310E8C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkl7iowET6KPVYyNiKBA8i6Z67DcbLnrlREw4SasOMC+tpP7uN2fguxlAtMAzqA3SLVJfcvoMMMYE0mu0WQY669gjJpk/mg30xDIo3ILUYSmJZxM6dWRjoPpxshVQLKH6pPKxWsxg3o2v4CT0KcAw9G+aOlc20/3zD9Ay5PH/bk3l4thZG0CnRzQYvoI4sDzxlFC+8t00BvJxlcmJk5/x1Q0spT70DbkJL0l++m3s9jWhGDc4Q0TjgQTINlHSasmlKNZOKvL0TYdUvk2ZA4UY7+qmXlIZ/7qPtK35plc24auO39ztljKzIuu4E+U3UI3XD6kKMVX9uZKCBpvFh3/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnnpdRjDuCWarZPLWfJWVUkAoe8K0gKRx0bBR+fySPc=;
 b=I2fHGYdUdmPXG2iA+QEbnOCPdyvScsKowb0/0kNnJf2OUiJdnWdulJcCuULYb7ASZTw8Hg7nFdxSKXmZ4jyv6dOH3ugh+AIGvSetb1amSAttUSsfOMY/KNuBBqrpw//JyHyV44MMnZ8S2MjrZbwXmnXM1I3e+32FGBDEFjBYqbfVBsjbXN89tYDR22BJEvMr/cK9RdPcuGHxxi/YlypsRQsSTZUJsBkgsmmX77CGQTgzL9RjMNuu1uKget5kCjsgRvHxuZh9sgFDiwH9NnMEjat47nlC3nFfa6vZnQGg/pNU0jclZJglGyWcIxMxX6dWGS/xgmfGoOePiV/BZ+9rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnnpdRjDuCWarZPLWfJWVUkAoe8K0gKRx0bBR+fySPc=;
 b=inzP02hQx17kQZNmTwmUqLTgiwepSi5FrYwguvUCZXmZVlTMmsCPzKt9Nn0n8HK3vNmTgRHSig495iRvf3SZ7Z72sDBHrvvlHjfaL/aUrPwyIgBjGCfZzMZJFwy2WhsUuPvxaOqmQJ3+b/FD94TmekCbFUGHp8Xia/ApNXOrZ10=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 07:39:37 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:39:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Skip power state allocation
Thread-Topic: [PATCH] drm/amd/pm: Skip power state allocation
Thread-Index: AQHX8LoS/6MIXGTEZEGLTpvKDE9stawxmc6t
Date: Tue, 14 Dec 2021 07:39:37 +0000
Message-ID: <CO6PR12MB547335BCC41CA68F0F28A90182759@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211214071259.580602-1-lijo.lazar@amd.com>
In-Reply-To: <20211214071259.580602-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T07:39:39.606Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: c1f63d4f-0681-5335-f208-c024ce05a328
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f236fd11-9a8e-42b6-03b2-08d9bed4e17a
x-ms-traffictypediagnostic: CO6PR12MB5411:EE_
x-microsoft-antispam-prvs: <CO6PR12MB54114B8D4008672770FC0EDA82759@CO6PR12MB5411.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cynwq362axj5K33C9OIX2RhrS/sUOZw+tshidgIjoxBqfXF4pyEgx6EbiuJ+6A2aYWpuGs2CoSaUKbuTBMgcoefWYbeb1XUbe0ehE6q1TzMcvF73JBDW/KZu20xWcPkWOR+yM6qyhk6bu2VZhItmC2NUUrtcEZjwAIvUNjxLaOZLTJIcmV15b0wL4sdwdxzb4Fp3tDFPTG89VdO+akabNcEY3CFZChDmJuJgPixd1awswFTPHQ/RAasnyE4E2RvpWAxu9nZ37piVrfjTn9bzKZwxEP7nTzJGxPcKuc5zPrjaDEE5Nb5p+VpIGOwVAMQ8y5JLUaguIEfd3ySeaB4duGMyB2WiJZbwCKyfQ19DuZ3mVBEzw6ZwlfqB/C+5NqSth8fhicOlRdX/IL4nsMbvXI34pfrtOS1DGBrCvXw/lkRU1CY2bq7aU/ro5wxi5BboCTMSp08r0NdyyeoykOjkrPadGnjeT8/e/+VrH64PrO8sAezbFHVGWBxwC/KIOfpBXzhtdH2qD7TItRvyzrjsiowDy/9OcChjqtb4GJ6LVwO2Z2Iz5doZOOZSv3J6tD1DKDdy3Mqo7BY/GvJcgXK+kY4zzEj24CLJRf4HLG+EEHc5cl52t+7IGB1RGRhKyJxHV03fEuJ0UewYjS/Ef/SMamH8xjBNv6vikoXsc+sH2bOobdU9X1ssbOtuWZ39ijZIoMxMPcngf2sQAZwY6ON3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(66946007)(9686003)(86362001)(76116006)(38100700002)(110136005)(2906002)(52536014)(7696005)(83380400001)(6506007)(4326008)(26005)(186003)(53546011)(38070700005)(316002)(122000001)(66556008)(64756008)(66446008)(66476007)(54906003)(508600001)(5660300002)(55016003)(33656002)(8936002)(71200400001)(19627405001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tPPnF4nBL09fHJuWEY4FK1J4v5pgmudRIvNbRXgbzlSnf+ut1YpFCTimMe?=
 =?iso-8859-1?Q?erjiWyc25/5rC+LbfE+17B6e4LA4raVU4KIuLvglSDoltPhPqrzO7+13Q8?=
 =?iso-8859-1?Q?peGhA91Vma442jX22xUjS6Kjl9kBVB6ZRzgVULfjpLc0DlS834C+0NTGr4?=
 =?iso-8859-1?Q?i7Gl4vRZBdbTHVUIdsBj+Xbn8kw4M8uVgTHiLjBT7AjAtEHhHo4dGKr/5b?=
 =?iso-8859-1?Q?lqQ0pHAfHYKXXV0UYH+TnIgWihikF+JokEDcNjxVhOChn7f2UBC7S+SVPq?=
 =?iso-8859-1?Q?YLwnRAvYfI1ZRy7qELql60MAhigENC7CFq8Xp/C5bXsXl4mbQ4BtwRfZVw?=
 =?iso-8859-1?Q?E5CiDZgBCESa+3bX1daKoWg59K7lnZmOOlXI4BZgacZ1zryGjha6yW8Iou?=
 =?iso-8859-1?Q?9IgixcAgDhBbn9Nd8Cc7s2yelufZwZ9xIpWD67QP6pdh7ZiKOkTQHboz57?=
 =?iso-8859-1?Q?7n81NokEY8UfZICwXgL407I/XG+FXTfNUfOeqTLC7AhfegHsMEp1fLB6OK?=
 =?iso-8859-1?Q?Au2lMb0T06xaJBysqeXT90+m5kMdQu3sl0OyTQo4/4a2yomQTjs311dVqf?=
 =?iso-8859-1?Q?v9NxjbGJDDd89WyqRO0kz4NDmubGd7OWR8wh5glnDGo1OGdUvZYKqYkVX7?=
 =?iso-8859-1?Q?h+QO7K8zsGkO3Eo6cC231fRjmEj/+wkGGDUqj7m+WDcd8KUlRhNb6+o3hD?=
 =?iso-8859-1?Q?0yBRDkV/QJHPS19NUL37A36yEoyfQu6+Yu6C2y7DSzxkgjKp0XmZN85LmA?=
 =?iso-8859-1?Q?mcUDZ/tUy5hX7qBFcDqwR2PJM7Ch/jNoMoviqdNpPVo5gM48g1xQOpqDA6?=
 =?iso-8859-1?Q?lkvxx+S9Yk8QS5Z5ZDBNR4+z0FneMJqjV0hK2TWZMuvnBOKenS40Xzjyn9?=
 =?iso-8859-1?Q?TxewAzUp0E3TD1cI9pl/5NaLrFGQsj+XZNAjp+2Ru1tA0Y8RUr5MfK641Z?=
 =?iso-8859-1?Q?HfZ1Dr7574RBkxEt8CJEK1cK+Nx3K8HgxsqeEHYvFI6HnO/1c0ZueiiXIa?=
 =?iso-8859-1?Q?dk7TA8wDoev9YaY4pehNJ06Z/qONkv7sxokMoMVGzfaUPIpUIwIObQWQu0?=
 =?iso-8859-1?Q?5VqCzw3vbShOh71kVRsJq1/cOskMFIDBDCxW8M+GLwpIW+jjuUo1Mn6ngZ?=
 =?iso-8859-1?Q?YMxa7H/zx7gPHrrJE8QfGdSl135fskG007LOiOnjSeBIdpH78l6cRPMb5r?=
 =?iso-8859-1?Q?torjfVo7wO2946QLTRosvYHuD6rHun2pHYHSqXbb9clnUWZNI8axKwn2SK?=
 =?iso-8859-1?Q?ZSayAmlk+l0ZjcI/4BYF5a6wuVtTXDFOr9/yuUgZfa2AlXA9xZ30ntNE9o?=
 =?iso-8859-1?Q?/gJ/qcekHfIBg2aBTT8Oa3nTGgDckM+HidaAFjMdh9yFB/7+G/Qp6FeWQv?=
 =?iso-8859-1?Q?gOJoTAdia0mr1e8/J1Xf2b32ARU15bCV6Ufux7Q2By1RFZ3+958CGPmdOi?=
 =?iso-8859-1?Q?APaaOfmWD5ssIyDscTXZ1s+EhHZqB15UXacPlsU5Czo588KJwxorPGS6p9?=
 =?iso-8859-1?Q?pBpebyO/zGpHmOVZ9F0sRSnqPc4eTcMjYZ2GDnKr+tPvG8B3HZH5p0AQsb?=
 =?iso-8859-1?Q?Cd9t1ep62F5LarDxKgle/FJm77RmaYG+BYGWw0pmvhGNJhQLbg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB547335BCC41CA68F0F28A90182759CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f236fd11-9a8e-42b6-03b2-08d9bed4e17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:39:37.3443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE01S3pqTTF0q3JHz4HYzRqDSwZx8iIfq+DThbsw88vwcNp4gq2PtZ2+EpMtY3fm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB547335BCC41CA68F0F28A90182759CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, December 14, 2021 3:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Quan, Evan <Ev=
an.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Skip power state allocation

Power states are not valid for arcturus and aldebaran, no need to
allocate memory.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 10 ----------
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 05defeee0c87..58bc387fb279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -295,16 +295,6 @@ static int arcturus_allocate_dpm_context(struct smu_co=
ntext *smu)
                 return -ENOMEM;
         smu_dpm->dpm_context_size =3D sizeof(struct smu_11_0_dpm_context);

-       smu_dpm->dpm_current_power_state =3D kzalloc(sizeof(struct smu_powe=
r_state),
-                                      GFP_KERNEL);
-       if (!smu_dpm->dpm_current_power_state)
-               return -ENOMEM;
-
-       smu_dpm->dpm_request_power_state =3D kzalloc(sizeof(struct smu_powe=
r_state),
-                                      GFP_KERNEL);
-       if (!smu_dpm->dpm_request_power_state)
-               return -ENOMEM;
-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6e781cee8bb6..0907da022197 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -262,16 +262,6 @@ static int aldebaran_allocate_dpm_context(struct smu_c=
ontext *smu)
                 return -ENOMEM;
         smu_dpm->dpm_context_size =3D sizeof(struct smu_13_0_dpm_context);

-       smu_dpm->dpm_current_power_state =3D kzalloc(sizeof(struct smu_powe=
r_state),
-                                                  GFP_KERNEL);
-       if (!smu_dpm->dpm_current_power_state)
-               return -ENOMEM;
-
-       smu_dpm->dpm_request_power_state =3D kzalloc(sizeof(struct smu_powe=
r_state),
-                                                  GFP_KERNEL);
-       if (!smu_dpm->dpm_request_power_state)
-               return -ENOMEM;
-
         return 0;
 }

--
2.25.1


--_000_CO6PR12MB547335BCC41CA68F0F28A90182759CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 14, 2021 3:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@am=
d.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Skip power state allocation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Power states are not valid for arcturus and aldeba=
ran, no need to<br>
allocate memory.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nbsp; | 10 --------=
--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ----------<br=
>
&nbsp;2 files changed, 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
index 05defeee0c87..58bc387fb279 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
@@ -295,16 +295,6 @@ static int arcturus_allocate_dpm_context(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_context_si=
ze =3D sizeof(struct smu_11_0_dpm_context);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_current_power_state =
=3D kzalloc(sizeof(struct smu_power_state),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G=
FP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm-&gt;dpm_current_power_st=
ate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_request_power_state =
=3D kzalloc(sizeof(struct smu_power_state),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G=
FP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm-&gt;dpm_request_power_st=
ate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index 6e781cee8bb6..0907da022197 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -262,16 +262,6 @@ static int aldebaran_allocate_dpm_context(struct smu_c=
ontext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_context_si=
ze =3D sizeof(struct smu_13_0_dpm_context);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_current_power_state =
=3D kzalloc(sizeof(struct smu_power_state),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_=
KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm-&gt;dpm_current_power_st=
ate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_request_power_state =
=3D kzalloc(sizeof(struct smu_power_state),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_=
KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm-&gt;dpm_request_power_st=
ate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB547335BCC41CA68F0F28A90182759CO6PR12MB5473namp_--
