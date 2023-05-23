Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE8C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 18:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A435110E10D;
	Tue, 23 May 2023 18:13:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D7610E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 18:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3RF1Ey3IPJDULmkXspp3KtbQnFn8FnVRNIdoIFLeNoCelkKXqJkKxp5E+ZAZ5lOk3nNmFIsv7e1K1oU85XHyUKCJCW3DaoJGW21iQtTAPpzmrpOy5OsXlzEEjNngLG8Tf+WsQpOuNEkb82aHEJU4OHks3gH5L6MeK7PHuZ3fu60Ozs55yIk1WYKEYcs5tUFBGLzNPNLkqhoVtSDbwiY3FeV9ZJFA2E2XH1t+6HBYM14EPNmaoF63JmWxKukDe+NRfYVHhW+TLV+pIgYuI0QZ1oZo9RrjitfiD/vg3vTn3zVhvjPk9n4YFRrxLM3vibZ4gbQB5LMytDaMxg0B3UbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPH9yfvueZrVgjYYS7degtLBCfHJWg+CZXa/9/ZCLS8=;
 b=lpsCblxbvkOuyUY+8T/cDQtUfviTXJjCclO9NYxNiDYL1ObK3OlTcsKngmvYGv/C7tYXPPr2P9NvdlmIDX45xp/jgM3u3klFNLOokj6Koyyue1yV41qNClmVG9iYPf5ILaz5/CwZZkwNM2y32dZsfEwkgONFPq25xHVLeB38lpNKEeaDvVGegUKTn4Di4VFXvmYeISyHbECcZTHDkLvfrdFtJnlRa3Ziy9Y+F955/Q0d2uwtLg8E3+49fo2qambxVLC9Y4eu7WgMD3LTkkkAtlOmIhfb1swWKo/HKZE0F7oS66350Ms0fQw/rKpDNhmFVRYHRADfZZxFBsepxucxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPH9yfvueZrVgjYYS7degtLBCfHJWg+CZXa/9/ZCLS8=;
 b=Pg3G5hugdO3ytIWdYk0uhYmBCSVGynJdmCN3EII2iNeaGS1uc+D2WH10ACCp8MiP4XhRsbuC1hWLELnXHBzQRMJkmMFsxpen0XSbbJGO2WiY/SnN25mItRNWUqbySd4api0AKk/EW8uwD9A3JfrXQc56gVM3uwUYSmxDqZpRHeo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 18:13:01 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 18:13:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Set event interrupt class for GFX 9.4.3
Thread-Topic: [PATCH] drm/amdkfd: Set event interrupt class for GFX 9.4.3
Thread-Index: AQHZjaIjLsQptJIsk0mhDIcIKObHpa9oKRhg
Date: Tue, 23 May 2023 18:13:01 +0000
Message-ID: <BL1PR12MB5144E11B06D63FC0E0B40B08F7409@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230523181212.697303-1-mukul.joshi@amd.com>
In-Reply-To: <20230523181212.697303-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-23T18:13:00.775Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB5510:EE_
x-ms-office365-filtering-correlation-id: 12dea737-7de6-4022-10a7-08db5bb9587f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+zUBuYO4aWFiZCh6BLLzEFeinQhFOgX52bIH/1LlTTOjFuvNNWs50Dfzf6nI2adO2HXSPbtnMAk15poGze12DHdnqxpX8x3tg4eYthzNTRbYBIAknF8qD7Zy7S0bE5p3Y0zKjsQcfNKdz3cGk/WEn+3hdRqZUWKKJgSKD9XxCvmL2q19ZnrXWR5rycngRyg/B5Gp9/dZy0KB1InfFXBw0nEIjGhIqozPffTqug5EYqcuFIKmdcsFYx2Z+NlUr1PBq4E6dIB8lH0l7tLW+ejVYn0W6yxLh4+fOdQwEm7+e+4J0KeQ8/M/5W6JbhbWPfp69BVpS0fl7b8BCp67oxSq8wuKRzEcHklmIQx+YVvQxKV7L2kc2lkCu6ZxGl33EiKCwXWurKHJvx910921+aLdaSZZB3eSNolyMjc+EKgIBDlE0CjjuBM76Ra/W+JOWCqlXh3ZNaf1ti75l3kzfWdmaMyi6ijKfAU684qpZRpt3lrM/mUlGB8bYAaNaYEgaPku59GtW4LPnx7YCoEgu+2miqlcjlznB3LcLmfZNEyUZmMSUOqtM4ynLeOcD4R1BDGGqTXTQy/umyOgSbFwj4odWWLdG2RPOE8qInDHSqszNo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(33656002)(186003)(6506007)(26005)(122000001)(53546011)(38100700002)(9686003)(83380400001)(2906002)(55016003)(316002)(71200400001)(64756008)(66556008)(66946007)(76116006)(4326008)(66446008)(66476007)(41300700001)(7696005)(86362001)(110136005)(19627405001)(478600001)(38070700005)(8676002)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fcuw5bbT+3B3G4RTItnVne58NQXiI75RU/gtsTsm7X5z2RpowKbmiP89JZ+D?=
 =?us-ascii?Q?5FWx+1KxDYmJLP6q63qEXTvzr8mYRkxEeIwtP//peu09Hv/aF7DXI6ldDAv9?=
 =?us-ascii?Q?Rafx36kiJRxv9eHcpnsAtME4H9T5VnEtQ9ehbOaJMVvcF0PjHWPU9+jPvlEF?=
 =?us-ascii?Q?z/bfu28cF+nr1+Un/iKfE2SUJ5owqcbyVivwPR09o4EgE+Jx244+z9scjPFZ?=
 =?us-ascii?Q?j4sKMa1FY2pyAGl+XsB66pgcFsTlv3g6sL+1ipkGpAAxgt5yaAtqDYPHpqhm?=
 =?us-ascii?Q?TW0cp4ecHJvNOgx7dqUdt7JXnyAFuW+NqXDe03hWRCgPIu8kkz66TnfSRKHo?=
 =?us-ascii?Q?CccHu2jrZKUeAg/F3XCy2eZE8zg1mRMSOMuHPcHz8C5JZopVEkrGp4snCH0J?=
 =?us-ascii?Q?QD1HIeF6V+OPdjOV3FAqaSo5USbbvch+MYDV6S7caVwKGxO9a16a5xDOatJY?=
 =?us-ascii?Q?VWdBbKRO3LO54P5EEIl0nVpOKvBfKrkEgCBF/kEA6NcTg2tOWGw9M5XuBMHY?=
 =?us-ascii?Q?7sBpSYwI4jy9+DEwW2So92NnE4FqdwOfS7frKd/Njt3nIJTawhvj/8BrecOv?=
 =?us-ascii?Q?BVpH96Kucj5h+XJE//H0l+Q9gRSrdr5U+r3cOsKHe5NLZWy4HgCVFRmQkXti?=
 =?us-ascii?Q?+glIqQ3vvupy8/sMj4xENg4An58NSul4ZMqsDDWKy0cl55zn13aYFvSpq1Bd?=
 =?us-ascii?Q?e4l2hdczpJ+qZHnPfzgmq1umec/ROye2/5mbGdXFcmGsD+O+rlwj3MHYTR38?=
 =?us-ascii?Q?AGCyXnMB7SmE0UZpQ1LZ1OYQ0fVvdmo4KW7mODgAH5KG8g1L3YF6kJ3oJ51z?=
 =?us-ascii?Q?+c5GLU0pdmGAyqpPs6n1yjOKa+y19Wr+vU4Rwg/fT+DOr1Go+ktP3vzZGti+?=
 =?us-ascii?Q?Ud6XvCjWkrzKfl+Z0/aB+w8KLt0eSGkM49yuiGUeW+m0ggL9hJfl4C1W229T?=
 =?us-ascii?Q?2IzxUDRZx6jdFjSr6PGISK3cMCPFGT08WBSdbVRIkcEknhcBom90jjNSECe1?=
 =?us-ascii?Q?1iUqN+RYFJBiRGcKtVn6XHkYPRLKUJeI+nmDurSKu5Aj7ELhcCFbj7z7mojc?=
 =?us-ascii?Q?8DWW5pk9MLt7Gz7dd2DgtNV6KMI08linmt/SUU/seegJmBMz0BGP7D223yAU?=
 =?us-ascii?Q?DJXXlnNDHGA+x01U8/A7r/5rtdIRTSB57pgFT50EZ9ZFA4PL6JPuNzLSJOmU?=
 =?us-ascii?Q?jhGP6/325u5+IprLno7KoWDi54lVtQwSw0JgTfk7eRklmVreulbtiHfufMvA?=
 =?us-ascii?Q?8UjuXun7t8F5Bf0tFTMqRbG+gO6y2ITDRqdKyIM9g28M1rDiooNU6bU1Doxw?=
 =?us-ascii?Q?ipyWXbaS6s0V9aYgddPk/wEzeYg0QC5sAeyZ/G3QtDBtf+N327cdk0hSrTjl?=
 =?us-ascii?Q?dsA5BWA0ZjcpFqIAYm1jVt5IBmy2HV/JiGwRSq3LiNZrto8vm2AWYebVbzgR?=
 =?us-ascii?Q?P+HnmQ73R4IBVRtff14QQiWxJQFEUa7nGymDDAStKOxk4o1jpc4P9KRyhVxS?=
 =?us-ascii?Q?LPyDUiFahD2GYovE2GYvtyGgSc/FzVHZTBJfVBo4rIUZYk+IFTq+irkRIh6t?=
 =?us-ascii?Q?9MFfZMDELVPYSeRDmHc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E11B06D63FC0E0B40B08F7409BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dea737-7de6-4022-10a7-08db5bb9587f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 18:13:01.4811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDmWb87GqQeghdoY5omknvU5819wosq63eqoSTP0AIGzoPOyeqX8suL3jf8GUR/7PozFwc/lk6x5jxs9zWv9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144E11B06D63FC0E0B40B08F7409BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Tuesday, May 23, 2023 2:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Set event interrupt class for GFX 9.4.3

Fix the warning during driver load because the event
interrupt class is not set for GFX9.4.3.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index e92b93b2c14c..862a50f7b490 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -139,6 +139,7 @@ static void kfd_device_info_set_event_interrupt_class(s=
truct kfd_dev *kfd)
         case IP_VERSION(9, 4, 0): /* VEGA20 */
         case IP_VERSION(9, 4, 1): /* ARCTURUS */
         case IP_VERSION(9, 4, 2): /* ALDEBARAN */
+       case IP_VERSION(9, 4, 3): /* GC 9.4.3 */
         case IP_VERSION(10, 3, 1): /* VANGOGH */
         case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
         case IP_VERSION(10, 3, 6): /* GC 10.3.6 */
--
2.35.1


--_000_BL1PR12MB5144E11B06D63FC0E0B40B08F7409BL1PR12MB5144namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joshi, Mukul &lt;Muku=
l.Joshi@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 23, 2023 2:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Deucher, Alexand=
er &lt;Alexander.Deucher@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Set event interrupt class for GFX 9.4.3=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix the warning during driver load because the eve=
nt<br>
interrupt class is not set for GFX9.4.3.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index e92b93b2c14c..862a50f7b490 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -139,6 +139,7 @@ static void kfd_device_info_set_event_interrupt_class(s=
truct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0): =
/* VEGA20 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1): =
/* ARCTURUS */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2): =
/* ALDEBARAN */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3): /* GC 9.4.3=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
 /* VANGOGH */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
 /* YELLOW_CARP */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6):=
 /* GC 10.3.6 */<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E11B06D63FC0E0B40B08F7409BL1PR12MB5144namp_--
