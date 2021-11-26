Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC321C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 06:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5D26E5AE;
	Fri, 26 Nov 2021 06:20:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE046E5A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 06:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCirvuL0WtGOuIyHI2mb4tPdnQi9Wlt7mQDQbcX4wMbcgvqBf1kj2EbY+iPh3+Ug6ADBWm5XGQMAkTsYoisVknQr9VbUiT6VvEt6h5wfNsh7vhD6PFFh9j4fCJXYopIOQgHH/RcEenC/oL/xZO6vS08AwjuKDL/Em0CATZdcbZao7rv1F96IJBQbDGGPI3MXFPlB8m39BqMa9ktn2y3I+FnGbdC0ilvpk5sF3c76kuu21I71eQmZTmH3/20X/ugoLnFRxmM32fD8WFavdUdOJ2BxOkwZUMGAvGEQVuNATP3mWhk0jmWquuzpni4Fq657JW6h0hf+B4kOI7yOvrVqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoLviUg2G0jFx2dnYo5aP4enQBtvdNZPISEzjTjgdj8=;
 b=WQkZ6Bba1d0BiT7/c9Gfnv2c9yXe1nb38fYvxylmcYrF1hx9UpHZjqdzLvRpYrYdr466Sl40YLWPWfpIscPA223XCVqEuvWp+aC4j/VmEgNuRzWoi/3qCIcjUuX25ltdQaLQdvp+aazHy6NzGh7+bxz0vOE7ODV3oUH9PI/JxqtsRrUOowWAyrDkQZ6v/gVkblJbcBODU5LnFEiRMNYRHg1aKwGPFGteRk4eSqTkFpkjovqLh2zSHposuj/zJwJJUqlt0+/xTUJVY7PLjPobX6w0gX6M7yqWuPzl836aAOWbRir6tIZ02GQ/7FoPBOOj/VOoshPq5Qti1DCNojPyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoLviUg2G0jFx2dnYo5aP4enQBtvdNZPISEzjTjgdj8=;
 b=nm68GNFP+c49L8voKe39L6dek6hRdofuOB4uDVgeZHSPGocEZry73dkdEZOwFecpk9ysfiIO6IdLFHm3T+l0+fxbzRBF5VQn+Nx7WS6GfgRQaWHFsZh7U7ELPWlhkpdknLpqSLKuc6zb0q9LbmK6GjDM8Jz6h+yFprDPg3j1xiU=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 06:20:00 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 06:20:00 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests
Thread-Topic: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests
Thread-Index: AQHX4oYJMcN5657UV0G5m6g/Ny1jHqwVViec
Date: Fri, 26 Nov 2021 06:20:00 +0000
Message-ID: <CO6PR12MB54737A72AFACD25BCFD3078E82639@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211126052502.134980-1-lijo.lazar@amd.com>
In-Reply-To: <20211126052502.134980-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T06:20:00.323Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 199b8a50-9e29-619e-f982-5bc32c569f86
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deb78167-b19b-4e27-6ab1-08d9b0a4c6fb
x-ms-traffictypediagnostic: CO6PR12MB5476:
x-microsoft-antispam-prvs: <CO6PR12MB54768843FF7DBF26C9F1633482639@CO6PR12MB5476.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzf66XPJiM49QXuzgKv/cEyn2aPuLlR/bL1h0vTqo0xo5xB5pxWcpKjWfZB4pjaff+lXzLdpY9u/wfQRx04T5eSYzfCtk3iMt2UHtwoyoVt1aU8X9nI2ZaMZhaTnb9yBwQnjgk4pOAGf8SXbH2sZ0tkbiAQ5MbfVccXCjtUAmxYr1IhGHPhg75R2yGnzET3RcjArTNmVeU501ZCfEW4Omm2Ga3+4JyeOo6rGnU3Lj7Z/BMRuf4w/cTEB53pv1WRvLwFqgtKzyaw2LRG9vH3CvWbIZ6VLg7JIIimRJHzA24D7IMcisMvTr13KhFvzkIVvANh7VTOULdxOWl8GuebZ3ggR19bbyeUfmRDnTklXNSBFY9jB4XLPEB4YIyiuWCscG9ZZ5HlZoUOQ/anpWI5W35cgJzNxDdhyhUCIJYfXr9hPZ8mKqtoRPtSIUro57zcNX3haNaPIKbOuCv8OEOzze/5sUAqBRjAddDkCg9Z7vi0wQNufrcKKtwueBmxIYGmzQhf+PnOo0JlZSpPiUXp5RAbfsPKERyvODVsPOaC/xFUkaumVDd2Wfx5pyPQR94q48aVAV1zehBismCOqtWZN/gR5KxjMOrG1WnEEdBJzvl1NsFU52jP7xbYDd7fjCFfYreEGz6eCzrXLlnnAYEd6GAMNe1TEVBR9bdYaWbvLgsGnneHksupzvzI0cBxVf7+PHJD/Lzuk7coWI5VcrOquyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(8676002)(52536014)(6506007)(110136005)(316002)(38070700005)(38100700002)(7696005)(5660300002)(2906002)(54906003)(4326008)(186003)(508600001)(53546011)(83380400001)(122000001)(66556008)(66946007)(64756008)(33656002)(19627405001)(76116006)(91956017)(66476007)(66446008)(86362001)(71200400001)(8936002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DskYqY+u2vAKnx5URIFuAHWItK8r1xkVS8X2OAw0rhB61YUXszypuApH/g?=
 =?iso-8859-1?Q?EX7jWAAXVYwxSUFqUTOc+7EsT1BtkZuFADSLbNJRxFNdI/zuV5PBWuVK9D?=
 =?iso-8859-1?Q?fwYHFIsCNEdFdpSmIEdypudPj3iX+JZ0slPbRdX9DrNwG/E3DR4ufDKrxY?=
 =?iso-8859-1?Q?pzMh5rsaC0QT3SekR/g8nqK/GE7RzPd+o16gqjruNXCqWC+A6wzVCZ0ETo?=
 =?iso-8859-1?Q?UqDObSibHlVYZqTabjimTN1GfCB+IJtzXGlVMQ2hP5ZEV+5+SaHoGCfSXX?=
 =?iso-8859-1?Q?6qaAVv/kYuMuonDyRm71llhUYM/uOfiVxzJdiSQgokwhBWS8KuWn+74Yd1?=
 =?iso-8859-1?Q?7W3v1KNKi1JrivmqpvErEteSIKNiExuQxYZn6hyFmhh6ma1iBtbZJGGify?=
 =?iso-8859-1?Q?UgKnf+Ia8/pNP6qbHC2USNrxtXu9IJCyt47wqmGRx+eAgUvPdtfuEqzG1C?=
 =?iso-8859-1?Q?ejG26gACPGdPDWAperD+n5zz5zxt0Mz14YYSXlWPom7C85/aVI0WI0hKPB?=
 =?iso-8859-1?Q?DAI7VoiSsNJfLNmE2NjFKzQNGPbKo54IcNjrAPgbzC2CH8lpY7Cqy86Rl2?=
 =?iso-8859-1?Q?E/94PhGVN0lEL/nzkhE4xVhkrSvwtBc5vlrQ7Tms3Z+fB0iksc1gf73uA8?=
 =?iso-8859-1?Q?0/orIEts4xWPcegRuhBN2WDWRJNgWbP0dEoSV3MDWS9Dmguox8uks2MHRL?=
 =?iso-8859-1?Q?5vpSjnO18tAHmxEAeQu2i+ZJXacRdcxEjobA1zv/7WMWD0W0T9j4rAkpoS?=
 =?iso-8859-1?Q?B99uyxCzrLQbWJGoLtHeVgqQd9TdZ4y50CJ7qYfuUdD9VLugTe7LoC7cq8?=
 =?iso-8859-1?Q?qi8pOb/MIMPpSKwuwBFTJp5HVxvUmQhh+454kxM+GJeg8pSis4qmCnDFH7?=
 =?iso-8859-1?Q?4jj3il9QjIflXBeE71zRNUUkXIg9NZ/xbJuIFQI0gWH0JJjZpWyiDnXRyu?=
 =?iso-8859-1?Q?WneNXkqq96ER6VrsIOdR2ewbgZKeLaHw5j/2460e9NEthH9epwkjO3TTH5?=
 =?iso-8859-1?Q?bsOi/ySJXtBE9YPMMT5crblSspOwVGq4T4MimblT1ebbugXrA87zN2ixAR?=
 =?iso-8859-1?Q?I71XMmnVXZUsdeJCzxSP30kgcuNHf8ucdirfjLZyYvXPmLyHpm0thol5rA?=
 =?iso-8859-1?Q?2+BQxS48AYO0Zu3Ga84PtHGAr9tmKHsfjwSpKkktBZ3gaRjxkz7D9fFmNQ?=
 =?iso-8859-1?Q?EXEWIhxTawbtNeZRYf+ctSEIAxWjiXdMJdAAD3qFO3nA9VF7IR7jcBac/2?=
 =?iso-8859-1?Q?2nbikFispxqiXLbNy0H+3l3mx/OGLhn5ZHFtKddKN3lXrogL/qRjNCScZ0?=
 =?iso-8859-1?Q?lZYySVf2INmG8r+dIShNw1NnqAIgzMOV2+21KjIatuek+puYBs3qzX96R1?=
 =?iso-8859-1?Q?lKmInyfUVrTtcp2bZVYzuUf0PoPicuT/tnfy9PXQtOZ6GUoe46//JL2BvZ?=
 =?iso-8859-1?Q?HDQvPXBeMW7A1jlf0PGRTBb4C+YPAYpJBTFLFITkNPZiuZCThEIYC9It8y?=
 =?iso-8859-1?Q?mDM4R9Pdayzlfi1VcVIk7fVbi1VwPtMxl3EDGjNvXJCrh2txLH3sxBU8TS?=
 =?iso-8859-1?Q?2xsBjPxzyuM/kRtKT+X1fIvstjcwn6GCFN+0PAyxa/TZwJR7+BO+1oculD?=
 =?iso-8859-1?Q?SReKstj0+8wCixvzUPEcZOPuc1I6O/AuLmvMOVqHIPj0QGMWZkrKNcuXKo?=
 =?iso-8859-1?Q?uKzP3ZQ5ZbLMVdLDMFs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54737A72AFACD25BCFD3078E82639CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb78167-b19b-4e27-6ab1-08d9b0a4c6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 06:20:00.7175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiLf1o05BoBxnjIV5vIjHJD7HCA9VS0lP15sYfLKtSdWc6RmpgYoc9WaIDLH0fad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB54737A72AFACD25BCFD3078E82639CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


Reviewed-by: Kevin Yang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Friday, November 26, 2021 1:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests

v1: Ideally power gate/ungate requests shouldn't come when smu block is
uninitialized. Add a WARN message to check the origins if such a thing
ever happens.

v2: Use dev_WARN to log device info (Felix/Guchun).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index e156add7b560..ea99afb38d2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -277,8 +277,12 @@ static int smu_dpm_set_power_gate(void *handle,
         struct smu_context *smu =3D handle;
         int ret =3D 0;

-       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+               dev_WARN(smu->adev->dev,
+                        "SMU uninitialized but power %s requested for %u!\=
n",
+                        gate ? "gate" : "ungate", block_type);
                 return -EOPNOTSUPP;
+       }

         switch (block_type) {
         /*
--
2.25.1


--_000_CO6PR12MB54737A72AFACD25BCFD3078E82639CO6PR12MB5473namp_
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
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Kevin Yang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Friday, November 26, 2021 1:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Limonciell=
o, Mario &lt;Mario.Limonciello@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhan=
g@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/pm: Add warning for unexpected PG reques=
ts</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">v1: Ideally power gate/ungate requests shouldn't c=
ome when smu block is<br>
uninitialized. Add a WARN message to check the origins if such a thing<br>
ever happens.<br>
<br>
v2: Use dev_WARN to log device info (Felix/Guchun).<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index e156add7b560..ea99afb38d2b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -277,8 +277,12 @@ static int smu_dpm_set_power_gate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&gt;a=
dev-&gt;pm.dpm_enabled)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&gt;a=
dev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_WARN(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;SMU =
uninitialized but power %s requested for %u!\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gate ? &qu=
ot;gate&quot; : &quot;ungate&quot;, block_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (block_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54737A72AFACD25BCFD3078E82639CO6PR12MB5473namp_--
